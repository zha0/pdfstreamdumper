/*
Purpose: sclog.exe

		This research application was designed to allow malcode analysts to
		quickly get an overview of an unknown shellcodes functionality by
		actually executing it within the framework of a minimal sandbox
		implemented through the use of API hooking. 

		It is not recommended to run unknown payloads outside of VMWare type
		enviroments. 

		By using this tool, you take responsibility for any results the use 
		of this tool may cause. It is NOT guaranteed to be safe.

		sclog supports the following command line arguments:

			Usage: sclog <sc_file> [/addbpx /redir /nonet /nofilt /dump /step]

			sc_file       shellcode file to execute and log
			/addbpx       Adds a breakpoint to beginning of shellcode buffer
			/redir        Changes IP specified in Connect() to localhost
			/nonet        no safety net - if set we dont block any dangerous apis
			/nofilt       no api filtering - show all hook messages
			/dump         dumps shellcode buffer to disk at first api call (self decoded)
			/step         asks the user to permit each hooked API call before executing
			/hex        does not display hex dumps
			/anydll       does not block unknown dlls (still safer than nonet)
			/fhand=<file> opens file to provide a valid file handle shellcode can search for 
			/hooks        shows implemented hooks

		Several sample shellcode payloads are provided (*.sc) 
		See the readme file for example output.

License: sclog.exe Copyright (C) 2005 David Zimmer <david@idefense.com, dzzie@yahoo.com>

		 Assembler and Disassembler engines are Copyright (C) 2001 Oleh Yuschuk
		 and used under GPL License. (disasm.h, asmserv.c, assembl.c, disasm.c)

         This program is free software; you can redistribute it and/or modify it
         under the terms of the GNU General Public License as published by the Free
         Software Foundation; either version 2 of the License, or (at your option)
         any later version.

         This program is distributed in the hope that it will be useful, but WITHOUT
         ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
         FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
         more details.

         You should have received a copy of the GNU General Public License along with
         this program; if not, write to the Free Software Foundation, Inc., 59 Temple
         Place, Suite 330, Boston, MA 02111-1307 USA


ChangeLog:

 7.7.05 - ipfromlng changed char* to unsigned char*

 7.16.05
		- now dynamically links to msvcrt so those hook dll (oops)
		- added /nohex option
		- added /anydll option
		- added unhandled exception filter code

 9.24.05 - SetConsoleMode broke ctrl-c handler, now only for step mode 

 10.1.10 -  
			added support for /fhand option and following hooks
			added support for alloc free logging, and memdump of allocs on free if made from shellcode. (experimental)
			ADDHOOK(GetFileSize)
			//ADDHOOK(GetFileSizeEx)
			//ADDHOOK(FindFirstFileExA)
			ADDHOOK(FindFirstFileA)
			//ADDHOOK(IsDebuggerPresent)

  12.3.10 - added /alloc option so you have to specify when you want alloc free logging.
          - fixed bug with UrlDownload* not being hooked correctly (oops!)
		  - turned off logging for hooks while real UrlDownload* is running

  4.5.11  - VirtualAllocEx and CreateRemoteThread now do a GlobalAlloc and transfer of execution in process for logging.
	      - added /hooks option.
		  - changed /nohex option (default on) to /showhex (default off) - need to add to write file api
*/




//#define _WIN32_WINNT 0x5000  //for IsDebuggerPresent 
#include <Winsock2.h>
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>
#include <conio.h>

#pragma warning(disable:4996)
#pragma warning(disable:4018)

HANDLE STDOUT;
HANDLE STDIN;

DWORD bufsz=0;  //these are global so we can check to see if execution comes from 
char *buf;      //   this vincinity for logging ret address

int redirect=0; //cmdline option to change connect ips to 127.0.0.1
int nonet=0;    //no safety net if 1 we dont block any apis 
int nofilt=0;   //no api filters show all 
int autoDump=0; //quick autoway to get dump at first api call we detect
int stepMode=0; //call by call affirmation to allow
int anyDll=0;   //do not halt because of loadign unknown dlls
int showhex=0;    //show hexdumps
int showadr=0;  //show ret addr for calls outside of shellcode (debugging)
int allocLogging=0;
int showHooks=0;

int HOOK_MSGS_OFF = 1;
int last_GetSizeFHand = -44;
int rep_count=0;
int hook_count=0;

int infoMsgColor = 0x0E;
char sc_file[MAX_PATH];

void InstallHooks(void);

#include "hooker.h"
#include "main.h"   //contains a bunch of library functions in it too..


//___________________________________________________hook implementations _________

void myAtExit(void){

	if(GAlloc.offset > 0 && GAlloc.size > 0){
		DumpMemBuf(GAlloc.offset, GAlloc.size, ".galloc");
		GAlloc.offset=0; GAlloc.size=0;
	}

	if(VAlloc.offset > 0 && VAlloc.size > 0){
		DumpMemBuf(VAlloc.offset, VAlloc.size, ".valloc");
		VAlloc.offset=0; VAlloc.size=0;
	}

	if(logFile!=NULL) CloseHandle(logFile);

}


HGLOBAL __stdcall My_GlobalAlloc( UINT a0, DWORD a1 )
{

	/*
	if(GAlloc.offset > 0 && GAlloc.size > 0){
		LogAPI("Looks like a second GlobalAlloc was called..dumping first\r\n"); //i doubt we will see this
		DumpMemBuf(GAlloc.offset, GAlloc.size, ".galloc");
		GAlloc.offset=0; GAlloc.size=0;
	}
	*/

	HGLOBAL  ret = 0;
	try{
		ret = Real_GlobalAlloc(a0,a1);
	}
	catch(...){}
	
	if( calledFromSC() ){
		GAlloc.offset = (int)ret;
		GAlloc.size = a1;

		AddAddr( SCOffset() );
		LogAPI("GlobalAlloc(flags=0x%x, size:0x%x) = 0x%x\r\n",a0,a1,ret);
	}

	return ret;
}

HGLOBAL __stdcall My_GlobalFree( HGLOBAL a0 )
{

	if( calledFromSC() ){
		AddAddr( SCOffset() );
		LogAPI("GlobalFree()\r\n");
	
		if(GAlloc.offset > 0 && GAlloc.size > 0){
			DumpMemBuf(GAlloc.offset, GAlloc.size, ".galloc");
			GAlloc.offset=0; GAlloc.size=0;
		}
	}

	HGLOBAL  ret = 0;
	try{
		ret = Real_GlobalFree(a0);
	}
	catch(...){}

	return ret;
}

LPVOID __stdcall My_VirtualAlloc( LPVOID a0, DWORD a1, DWORD a2, DWORD a3 )
{

	/*
	if(VAlloc.offset > 0 && VAlloc.size > 0){
		LogAPI("Looks like a second VAlloc was called..dumping first\r\n"); //i doubt we will see this
		DumpMemBuf(VAlloc.offset, VAlloc.size, ".valloc");
		VAlloc.offset=0; VAlloc.size=0;
	}
	*/

	LPVOID  ret = 0;
	try{
		ret = Real_VirtualAlloc(a0,a1,a2,a3);
	}
	catch(...){}
	
	if( calledFromSC() ){
		VAlloc.offset = (int)ret;
		VAlloc.size = a1;

		AddAddr( SCOffset() );
		LogAPI("VirtualAlloc(size:0x%x) = 0x%x\r\n", a1, ret);
	}

	return ret;
}


LPVOID __stdcall My_VirtualAllocEx( HANDLE a0, LPVOID a1, DWORD a2, DWORD a3, DWORD a4 )
{
	//LPVOIDWINAPIVirtualAllocEx( HANDLE hProcess, LPVOID lpAddress, DWORD dwSize, DWORD flAllocationType, DWORD flProtect );
	
	AddAddr( SCOffset() );
	LPVOID  ret = 0;
	ret = GlobalAlloc(0x40, a2);
	LogAPI("VirtualAllocEx(proc=%x,addr=%x,sz=%x,type=%x) = %x \r\n", (int)a0,a1, a2, a3, ret);
	return ret;

}

BOOL __stdcall My_VirtualFree( LPVOID a0, DWORD a1, DWORD a2 )
{

	if( calledFromSC() ){
		AddAddr( SCOffset() );
		LogAPI("VirtualFree()\r\n");
		
		if(VAlloc.offset > 0 && VAlloc.size > 0){
			DumpMemBuf(VAlloc.offset, VAlloc.size, ".valloc");
			VAlloc.offset=0; VAlloc.size=0;
		}
	}

	BOOL  ret = 0;
	try{
		ret = Real_VirtualFree(a0,a1,a2);
	}
	catch(...){}

	return ret;
}


DWORD __stdcall My_GetFileSize( HANDLE a0, LPDWORD a1 )
{

	int interval = 25;
	int x[] = {'|','/','-','|','//','-'};
	char tmp[22] = {0};

	//yes i spent to much time on this but it was spamming any other way...

	if( (last_GetSizeFHand+1) == (int)a0 || (last_GetSizeFHand+4) == (int)a0){ 
				
		if(rep_count == (interval*5+1) ){
			rep_count=0;
			for(int i=0;i<40;i++) msg("\b \b",-1,-1);
			AddAddr( SCOffset() ); //we are assuming it was called from same offset otherwise it will hose our display
			LogAPI("GetFileSize(h=%x) ",a0);
		}else{
			if(rep_count % interval == 0){
				sprintf(tmp,"%c\b", x[rep_count/interval]);
				msg(tmp,-1,-1);
			}
			Sleep(10);
			rep_count++;
		}

	}else{
		AddAddr( SCOffset() ); 
		LogAPI("GetFileSize(h=%x) ",a0);
	}

	last_GetSizeFHand = (int)a0;

	DWORD  ret = 0;
	try{
		ret = Real_GetFileSize(a0,a1);
	}
	catch(...){}

	if(ret != 0xFFFFFFFF && ret != 0){
		for(int i=0;i<40;i++) msg("\b \b",-1,-1);
		AddAddr( SCOffset() );
		LogAPI("GetFileSize(h=%x) = 0x%x\r\n",a0,ret);
		last_GetSizeFHand = -44;
	}

	return ret;
}

/*
DWORD __stdcall My_GetFileSizeEx( HANDLE a0, PLARGE_INTEGER a1 )
{
	AddAddr( SCOffset() );
	LogAPI("GetFileSizeEx(handle:0x%x)",a0);

	DWORD  ret = 0;
	try{
		ret = Real_GetFileSizeEx(a0,a1);
	}
	catch(...){}

	return ret;
}


HANDLE __stdcall My_FindFirstFileExA( LPCSTR a0, FINDEX_INFO_LEVELS a1, LPVOID a2, FINDEX_SEARCH_OPS a3, LPVOID a4, DWORD a5 )
{
	AddAddr( SCOffset() );
	LogAPI("FindFirstFileExA(%s)",a0);

	HANDLE  ret = 0;
	try{
		ret = Real_FindFirstFileExA(a0,a1,a2,a3,a4,a5);
	}
	catch(...){}

	return ret;
}


BOOL __stdcall My_IsDebuggerPresent( VOID )
{
	AddAddr( SCOffset() );
	LogAPI("IsDebuggerPresent()");

	BOOL  ret = false;
	return ret;
}
*/


DWORD __stdcall My_GetTempPathA( DWORD a0, LPSTR a1 )
{

	DWORD  ret = 0;
	try{
		ret = Real_GetTempPathA(a0,a1);
	}
	catch(...){}

	AddAddr( SCOffset() );
	LogAPI("GetTempPathA() = %s\r\n",a1);

	return ret;
}

HANDLE __stdcall My_FindFirstFileA( LPCSTR a0, LPWIN32_FIND_DATAA a1 )
{
	AddAddr( SCOffset() );
	LogAPI("FindFirstFileA(%s)\r\n",a0);

	HANDLE  ret = 0;
	try{
		ret = Real_FindFirstFileA(a0,a1);
	}
	catch(...){}

	return ret;
}


HANDLE __stdcall My_CreateFileA(LPCSTR a0,DWORD a1,DWORD a2,LPSECURITY_ATTRIBUTES a3,DWORD a4,DWORD a5,HANDLE a6)
{

    HANDLE ret = 0;
    try{
        ret = Real_CreateFileA(a0, a1, a2, a3, a4, a5, a6);
    }
	catch(...){
	
	} 

	AddAddr( SCOffset() );	
	LogAPI("CreateFileA(%s) =0x%x\r\n", a0, ret);


    return ret;
}

BOOL __stdcall My_WriteFile(HANDLE a0,LPCVOID a1,DWORD a2,LPDWORD a3,LPOVERLAPPED a4)
{
    
	AddAddr( SCOffset() );	
	LogAPI("WriteFile(h=%x)\r\n", a0);

    BOOL ret = 0;
    try {
        ret = Real_WriteFile(a0, a1, a2, a3, a4);
    } 
	catch(...){	} 
    return ret;
}
 
HFILE __stdcall My__lcreat(LPCSTR a0,int a1)
{
    AddAddr( SCOffset() );	
	LogAPI("_lcreat(%s,%x)\r\n", a0, a1);

    HFILE ret = 0;
    try {
        ret = Real__lcreat(a0, a1);
    } 
	catch(...){	} 
    return ret;
}

HFILE __stdcall My__lopen(LPCSTR a0, int a1)
{
   
    AddAddr( SCOffset() );	
	LogAPI("_lopen(%s,%x)\r\n", a0, a1);

    HFILE ret = 0;
    try {
        ret = Real__lopen(a0, a1);
    }
	catch(...){	} 

    return ret;
}

UINT __stdcall My__lread(HFILE a0,LPVOID a1,UINT a2)
{
    AddAddr( SCOffset() );	
	LogAPI("_lread(%x,%x,%x)\r\n", a0, a1, a2);

    UINT ret = 0;
    try {
        ret = Real__lread(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

UINT __stdcall My__lwrite(HFILE a0,LPCSTR a1,UINT a2)
{
    
	AddAddr( SCOffset() );	
	LogAPI("_lwrite(h=%x)\r\n", a0);

    UINT ret = 0;
    try {
        ret = Real__lwrite(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}




BOOL __stdcall My_WriteFileEx(HANDLE a0,LPCVOID a1,DWORD a2,LPOVERLAPPED a3,LPOVERLAPPED_COMPLETION_ROUTINE a4)
{
    AddAddr( SCOffset() );	
    LogAPI("WriteFileEx(h=%x)\r\n", a0);

    BOOL ret = 0;
    try {
        ret = Real_WriteFileEx(a0, a1, a2, a3, a4);
    }
	catch(...){	} 

    return ret;
}

DWORD __stdcall My_WaitForSingleObject(HANDLE a0,DWORD a1)
{
   
   	if( calledFromSC() ){
		AddAddr( SCOffset() );	
		LogAPI("WaitForSingleObject(%x,%x)\r\n", a0, a1);
	}

    DWORD ret = 0;
    try {
        ret = Real_WaitForSingleObject(a0, a1);
    }
	catch(...){	} 

    return ret;
}


//_________ws2_32__________________________________________________________

SOCKET __stdcall My_accept(SOCKET a0,sockaddr* a1,int* a2)
{
    AddAddr( SCOffset() );	
	LogAPI("accept(%x,%x,%x)\r\n", a0, a1, a2);

    SOCKET ret = 0;
    try {
        ret = Real_accept(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_bind(SOCKET a0,SOCKADDR_IN* a1, int a2)
{
    
	AddAddr( SCOffset() );	
	LogAPI("bind(%x, port=%ld)\r\n", a0, htons(a1->sin_port) );

    int ret = 0;
    try {
        ret = Real_bind(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_closesocket(SOCKET a0)
{
    
	AddAddr( SCOffset() );	
	LogAPI("closesocket(%x)\r\n", a0);

    int ret = 0;
    try {
        ret = Real_closesocket(a0);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_connect(SOCKET a0,SOCKADDR_IN* a1,int a2)
{
    
	char* ip=0;	
	ip=ipfromlng(a1);
	
	if(redirect){
		infomsg("     Connect Redirecting Enabled: %s -> 127.0.0.1\r\n",ip); 
		free(ip);
		a1->sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
		ip=ipfromlng(a1);
	}

	AddAddr( SCOffset() );	
	LogAPI("connect( %s:%d )\r\n", ip, htons(a1->sin_port) );
	
	free(ip);

    int ret = 0;
    try {
        ret = Real_connect(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

hostent* __stdcall My_gethostbyaddr(char* a0,int a1,int a2)
{
    
	AddAddr( SCOffset() );	
	LogAPI("gethostbyaddr(%x)\r\n", a0);

    hostent* ret = 0;
    try {
        ret = Real_gethostbyaddr(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

hostent* __stdcall My_gethostbyname(char* a0)
{
    AddAddr( SCOffset() );	
	LogAPI("gethostbyname(%x)\r\n", a0);

    hostent* ret = 0;
    try {
        ret = Real_gethostbyname(a0);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_gethostname(char* a0,int a1)
{
    AddAddr( SCOffset() );	
	LogAPI("gethostname(%x)\r\n", a0);

    int ret = 0;
    try {
        ret = Real_gethostname(a0, a1);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_listen(SOCKET a0,int a1)
{
    
	AddAddr( SCOffset() );	
	LogAPI("listen(h=%x )\r\n", a0);

    int ret = 0;
    try {
        ret = Real_listen(a0, a1);
    }
	catch(...){	} 

    return ret;
}

int __stdcall My_recv(SOCKET a0,char* a1,int a2,int a3)
{
	AddAddr( SCOffset() );	
    LogAPI("recv(h=%x)\r\n", a0);

    int ret = 0;
    try {
        ret = Real_recv(a0, a1, a2, a3);

		if(ret>0){
			if(showhex==1) hexdump((unsigned char*)a1,ret);
		}

    } 
	catch(...){	} 

    return ret;
}

int __stdcall My_send(SOCKET a0,char* a1,int a2,int a3)
{
    
	AddAddr( SCOffset() );	
	LogAPI("send(h=%x)\r\n", a0);
    int ret = 0;

    try {

		if(a2>0 && *a1 !=0 && showhex==1)	hexdump((unsigned char*)a1,a2);
        ret = Real_send(a0, a1, a2, a3);
    
	}
	catch(...){	} 

    return ret;
}

int __stdcall My_shutdown(SOCKET a0,int a1)
{
    
	AddAddr( SCOffset() );	
	LogAPI("shutdown()\r\n");

    int ret = 0;
    try {
        ret = Real_shutdown(a0, a1);
    }
	catch(...){	} 

    return ret;
}

SOCKET __stdcall My_socket(int a0,int a1,int a2)
{
	
	AddAddr( SCOffset() );		
	LogAPI("socket(family=%x,type=%x,proto=%x)\r\n", a0, a1, a2);

    SOCKET ret = 0;
    try {
        ret = Real_socket(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

SOCKET __stdcall My_WSASocketA(int a0,int a1,int a2,struct _WSAPROTOCOL_INFOA* a3,GROUP a4,DWORD a5)
{
    
	AddAddr( SCOffset() );	
	LogAPI("WSASocketA(fam=%x,typ=%x,proto=%x)\r\n", a0, a1, a2);

    SOCKET ret = 0;
    try {
        ret = Real_WSASocketA(a0, a1, a2, a3, a4, a5);
    }
	catch(...){	} 

    return ret;
}



int My_URLDownloadToFileA(int a0,char* a1, char* a2, DWORD a3, int a4)
{
	
	AddAddr( SCOffset() );	

	if(!nonet){
		infomsg("Skipping URLDownloadToFileA(\r\n\t%s , \r\n\t%s)\r\n", a1,a2);
		DumpBuffer();
		return 0;
	}

	LogAPI("URLDownloadToFile(%s,%s)\r\n", a1, a2);

    SOCKET ret = 0;
	HOOK_MSGS_OFF = 1; //this is a noisy function for logging
    try {
        ret = Real_URLDownloadToFileA(a0, a1, a2, a3, a4);
    }
	catch(...){	} 

	HOOK_MSGS_OFF = 0;
    return ret;
}


int My_URLDownloadToCacheFile(int a0,char* a1, char* a2, DWORD a3, DWORD a4, int a5)
{
	
	AddAddr( SCOffset() );	

	if(!nonet){
		infomsg("Skipping URLDownloadToCacheFile(\r\n\t%s , \r\n\t%s)\r\n", a1,a2);
		DumpBuffer();
		return 0;
	}

	LogAPI("URLDownloadToCacheFile(%s, %s)\r\n", a1, a2);

    SOCKET ret = 0;
	HOOK_MSGS_OFF = 1;
    try {
        ret = Real_URLDownloadToCacheFile(a0, a1, a2, a3, a4, a5);
    }
	catch(...){	} 
    HOOK_MSGS_OFF = 0;

    return ret;
}

void __stdcall My_ExitProcess(UINT a0)
{
    
	if( calledFromSC() ){
		AddAddr( SCOffset() );	
		LogAPI("ExitProcess()\r\n");
	}

    try {
        Real_ExitProcess(a0);
    }
	catch(...){	} 

}

void __stdcall My_ExitThread(DWORD a0)
{
    
	if( calledFromSC() ){
		AddAddr( SCOffset() );	
		LogAPI("ExitThread()\r\n");
	}

    try {
        Real_ExitThread(a0);
    }
	catch(...){	} 

}

FILE* __stdcall My_fopen(const char* a0, const char* a1)
{

    AddAddr( SCOffset() );	
	LogAPI("fopen(%s)\r\n", a0);

	FILE* rt=0;
    try {
        rt = Real_fopen(a0,a1);
    }
	catch(...){	} 

	return rt;
}

size_t __stdcall My_fwrite(const void* a0, size_t a1, size_t a2, FILE* a3)
{

    AddAddr( SCOffset() );	
	LogAPI("fwrite(h=%x)\r\n", a3);

	size_t rt=0;
    try {
        rt = Real_fwrite(a0,a1,a2,a3);
    }
	catch(...){	} 

	return rt;
}

HANDLE __stdcall My_OpenProcess(DWORD a0,BOOL a1,DWORD a2)
{

	char* proc = ProcessFromPID(a2);
    AddAddr( SCOffset() );	
	LogAPI("OpenProcess(pid=%ld) = %s\r\n", a2, proc);
	free(proc);

    HANDLE ret = 0;
    try {
        ret = Real_OpenProcess(a0, a1, a2);
    }
	catch(...){	} 

    return ret;
}

HMODULE __stdcall My_GetModuleHandleA(LPCSTR a0)
{

    if( calledFromSC() ){
		AddAddr( SCOffset() );	
		LogAPI("GetModuleHandleA(%s)\r\n", a0);
	}

    HMODULE ret = 0;
    try {
        ret = Real_GetModuleHandleA(a0);
    }
	catch(...){	} 

    return ret;
}


//_________________________________________________ banned unless /nonet _______________
UINT __stdcall My_WinExec(LPCSTR a0,UINT a1)
{

	AddAddr( SCOffset() );	

    if(!nonet){
		infomsg("Skipping WinExec(%s,%x)\r\n", a0, a1);  
		DumpBuffer();
		return 0;
	}

	LogAPI("WinExec(%s,%x)\r\n", a0, a1);

    UINT ret = 0;
    try {
        ret = Real_WinExec(a0, a1);
    }
	catch(...){	} 

    return ret;


}

BOOL __stdcall My_DeleteFileA(LPCSTR a0)
{
	
	AddAddr( SCOffset() );	
 	infomsg("Skipping DeleteFileA(%s)\r\n", a0); //deleting is never cool nonet or not
	DumpBuffer();
	return 0;
	 

}

BOOL __stdcall My_CreateProcessA(LPCSTR a0,LPSTR a1,LPSECURITY_ATTRIBUTES a2,LPSECURITY_ATTRIBUTES a3,BOOL a4,DWORD a5,LPVOID a6,LPCSTR a7,struct _STARTUPINFOA* a8,LPPROCESS_INFORMATION a9)
{

	AddAddr( SCOffset() );	    

	if(!nonet){
		infomsg("Skipping CreateProcessA(%s,%s)\r\n", a0, a1);
		DumpBuffer();
		return 1;
	}

    BOOL ret = 0;
    try {
        ret = Real_CreateProcessA(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9);
    }
	catch(...){	} 

	LogAPI("CreateProcessA(%s,%s,%x,%s) = %d \r\n", a0, a1, a6, a7, (int)ret);
    return ret;



}

int My_system(const char* cmd)
{
    
	AddAddr( SCOffset() );	
	
	if(!nonet){
		infomsg("Skipping call to system(%s)\r\n", cmd);
		DumpBuffer();
		return 0;
	}
	
	LogAPI("system(%s)\r\n", cmd);

	int ret=0;
	try {
        ret = Real_system(cmd);
    }
	catch(...){	} 

    return ret;

}

HANDLE __stdcall My_CreateRemoteThread(HANDLE a0,LPSECURITY_ATTRIBUTES a1,DWORD a2,LPTHREAD_START_ROUTINE a3,LPVOID a4,DWORD a5,LPDWORD a6)
{

	/*
		HANDLE WINAPI CreateRemoteThread(
		  __in   HANDLE hProcess,
		  __in   LPSECURITY_ATTRIBUTES lpThreadAttributes,
		  __in   SIZE_T dwStackSize,
		  __in   LPTHREAD_START_ROUTINE lpStartAddress,
		  __in   LPVOID lpParameter,
		  __in   DWORD dwCreationFlags,
		  __out  LPDWORD lpThreadId
		);
		HANDLE WINAPI CreateThread(
		  __in_opt   LPSECURITY_ATTRIBUTES lpThreadAttributes,
		  __in       SIZE_T dwStackSize,
		  __in       LPTHREAD_START_ROUTINE lpStartAddress,
		  __in_opt   LPVOID lpParameter,
		  __in       DWORD dwCreationFlags,
		  __out_opt  LPDWORD lpThreadId
		);
   */
	
	AddAddr( SCOffset() );	
	LogAPI("CreateRemoteThread(h=%x, start=%x, param=%x)\r\n", a0,a3,a4);
	LogAPI("\tTransferring execution to threadstart\r\n");

    HANDLE my_ret = 0;
    //try {
        
		_asm{
			mov eax, a4
			mov ebx, a3
			push eax
			call ebx
		}

    //}
	//catch(...){	} 

    return (HANDLE)1;

}

BOOL __stdcall My_WriteProcessMemory(HANDLE a0,LPVOID a1,LPVOID a2,DWORD a3,LPDWORD a4)
{

    //BOOLWINAPIWriteProcessMemory( HANDLE hProcess, LPVOID lpBaseAddress, LPVOID lpBuffer, DWORD nSize, LPDWORD lpNumberOfBytesWritten );

	AddAddr( SCOffset() );	

	LogAPI("WriteProcessMemory(h=%x, adr=%x, buf=%x, len=%x) (Writing in process)\r\n", a0,a1,a2,a3);

    BOOL ret = 0;
    try {
		
		if(showhex==1) hexdump( (unsigned char*) a2, a3 );
        memcpy(a1, a2, a3);
		ret = 1;
		if(a4 != 0) *a4 = a3;

    }
	catch(...){	} 

    return ret;
}

 
// ________________________________________________  monitored ________________

HMODULE __stdcall My_LoadLibraryA(char* a0)
{
    int isOK=0;
   
    int dllCnt=7,i=0;
	
	char *okDlls[] = { "ws2_32","kernel32","advapi32", "urlmon", "msafd", "msvcrt", "mswsock" };

	HMODULE ret = 0;

	if(nonet || !*a0 || anyDll){
		isOK=1;
	}else{
				
		for(i=0;i<strlen(a0);i++) a0[i] = tolower(a0[i]);

		for(i=0;i<dllCnt;i++){
			if( strstr(a0, okDlls[i]) > 0 ){
				 isOK=1;
				 break;
			}
		}

	}	

	if(isOK==0){	
		AddAddr( SCOffset() );
		infomsg("Halting..LoadLibrary for dll not in safe list: %s\r\n",a0);
		exit(0);
	}
		
	if( calledFromSC() ){
		AddAddr( SCOffset() );
		LogAPI("LoadLibraryA(%s)\r\n",  a0);
	}

	try {
		ret = Real_LoadLibraryA(a0);
	}
	catch(...){	} 



	return ret;

}


 
FARPROC __stdcall My_GetProcAddress(HMODULE a0,LPCSTR a1)
{
	
	if( calledFromSC() ){
		AddAddr( SCOffset() );	
		LogAPI("GetProcAddress(%s)\r\n", a1);
	}

    FARPROC ret = 0;
    try {
        ret = Real_GetProcAddress(a0, a1);
    }
	catch(...){	} 

    return ret;
}

//_________________________________________________ end of hook implementations ________

void usage(void){
	printf("           Generic Shellcode Logger v0.1c BETA\r\n");
	printf(" Author David Zimmer <dzzie@yahoo.com> Developed @ iDefense.com\r\n");
	printf(" Uses the GPL Asm/Dsm Engines from OllyDbg (C) 2001 Oleh Yuschuk\r\n");
	printf("      ---- Compilation date: %s %s ----\r\n\r\n", __DATE__, __TIME__);

	SetConsoleTextAttribute(STDOUT,  0x0F); //white
	
	printf(" Usage: sclog file [/addbpx /redir /nonet /nofilt /dump /step /anydll\r\n");
	printf("                    /nohex /fhand <file> /showadr /log <file> /alloc]\r\n\r\n");
	printf("    file\t\tshellcode file to execute and log\r\n");
	printf("    /addbpx\t\tAdds a breakpoint to beginning of shellcode buffer\r\n");
	printf("    /redir\t\tChanges IP specified in Connect() to localhost\r\n");
	printf("    /nonet\t\tno safety net - if set we dont block any dangerous apis\r\n");
	printf("    /nofilt\t\tno api filtering - show all hook messages\r\n");
	printf("    /dump\t\tdump (probably decoded) shellcode at first api call\r\n");
	printf("    /step\t\task user before each hooked api to continue\r\n");   
	printf("    /anydll\t\tDo not halt on unknown dlls\r\n");
	printf("    /hex\t\tdisplay hexdumps\r\n");   
	printf("    /fopen <file>\topens file handle(s) the shellcode can search for\r\n"); 
	printf("    /showadr \t\tShow return address for calls outside shellcode bufffer\r\n"); 
	printf("    /alloc \t\tLog Alloc/Free and memdump allocs from shellcode\r\n");
	printf("    /log <file> \tWrite all output to logfile\r\n"); 
	printf("    /dll <dllfile> \tCalls LoadLibrary on <dllfile> to add to memory map\r\n"); 
	printf("    /foff hexnum \tStarts execution at file offset\r\n"); 
	printf("    /va  \t\t0xBase-0xSize  VirtualAlloc memory at 0xBase of 0xSize\r\n"); 
	printf("    /hooks \t\tshows implemented hooks\r\n\r\n"); 

	SetConsoleTextAttribute(STDOUT,  0x07); //default gray
	
	printf(" Note that many interesting apis are logged, but not all.\r\n");
	printf(" Shellcode is allowed to run within a minimal sandbox..\r\n");
	printf(" and only known safe (hooked) dlls are allowed to load\r\n\r\n");
	printf(" It is advised to only run this in VM enviroments as not\r\n");
	printf(" all paths are blocked that could lead to system subversion.\r\n");
	printf(" As it runs, API hooks will be used to log actions skipping\r\n");
	printf(" many dangerous functions.\r\n\r\n");

	SetConsoleTextAttribute(STDOUT,  0x0E); //yellow
	printf(" Use at your own risk!\r\n");
	SetConsoleTextAttribute(STDOUT,  0x07); //default gray
	ExitProcess(0);
}

LONG __stdcall exceptFilter(struct _EXCEPTION_POINTERS* ExceptionInfo){

	unsigned int eAdr = (int)ExceptionInfo->ExceptionRecord->ExceptionAddress ;
	
	if( eAdr > (unsigned int)buf  &&  eAdr < ( (unsigned int)buf+bufsz+50 ) ){
		eAdr -=(unsigned int)buf;
	}

	infomsg("   %x Crash!\r\n", eAdr); 

	myAtExit();

	ExitProcess(0);
	return 0;

}


void main(int argc, char **argv){
	
	DWORD l;
	OFSTRUCT o;
	WSADATA WsaDat;	
	int addbpx=0;
	int foff=0;
	int i=0;

    VAlloc.offset = 0;
	GAlloc.offset = 0;
	VAlloc.size   = 0;
	GAlloc.size   = 0;

	system("cls");
	//system("mode con lines=45");
	printf("\r\n");

	STDOUT = GetStdHandle(STD_OUTPUT_HANDLE);
	STDIN  = GetStdHandle(STD_INPUT_HANDLE);

	if(argc < 2) usage();
	if(strstr(argv[1],"?") > 0 ) usage();
	if(strstr(argv[1],"-h") > 0 ) usage();

	//first scan the args to set the basic options which require no output
	for( i=1; i<argc; i++){
		if(argv[i][0] == '-') argv[i][0] = '/';

		if(strstr(argv[i],"/addbpx") > 0 )  addbpx=1;
		if(strstr(argv[i],"/break") > 0 )  addbpx=1;
		if(strstr(argv[i],"/redir") > 0 )   redirect=1;
		if(strstr(argv[i],"/nonet") > 0 )   nonet=1;
		if(strstr(argv[i],"/nofilt") > 0 )  nofilt=1;
		if(strstr(argv[i],"/dump") > 0 )    autoDump=1;
		if(strstr(argv[i],"/step") > 0 )    stepMode=1; //might still have some side effects 
		if(strstr(argv[i],"/anydll") > 0 )  anyDll=1;
		if(strstr(argv[i],"/hex") > 0 )     showhex=1;
		if(strstr(argv[i],"/showadr") > 0 ) showadr=1;
		if(strstr(argv[i],"/hooks") > 0 ){  showHooks=1; break;}
		if(strstr(argv[i],"/alloc") > 0 )	allocLogging = 1; //used in InstalllHooks()

		if(strstr(argv[i],"/foff") > 0 ){
			if(i+1 >= argc){
				printf("Invalid option /foff must specify start file offset as next arg\n");
				exit(0);
			}
			foff = strtol(argv[i+1], NULL, 16);
			printf("Starting at file offset 0x%x\n", foff);
		}

		if(strstr(argv[i],"/dll") > 0 ){
			if(i+1 >= argc){
				printf("Invalid option /dll must specify dll to load as next arg\n");
				exit(0);
			}
			int hh = (int)LoadLibrary(argv[i+1]);
			printf("LoadLibrary(%s) = 0x%x\n", argv[i+1], hh);
		}

		if(strstr(argv[i],"/va") > 0 ){
			if(i+1 >= argc){
				printf("Invalid option /va must specify 0xBase-0xSize as next arg\n");
				exit(0);
			}
		    char *ag = strdup(argv[i+1]);
			char *sz;
			unsigned int size=0;
			unsigned int base=0;
			if (( sz = strstr(ag, "-")) != NULL)
			{
				*sz = '\0';
				sz++;
				size = strtol(sz, NULL, 16);
				base = strtol(ag, NULL, 16);
				int r = (int)VirtualAlloc((void*)base, size, MEM_RESERVE | MEM_COMMIT, 0x40 );
				printf("VirtualAlloc(base=%x, size=%x) = %x - %x\n", base, size, r, r+size);
				if(r==0){ printf("ErrorCode: %x\nAborting...\n", GetLastError()); exit(0);}
				//0x57 = ERROR_INVALID_PARAMETER 

			}else{
				printf("Invalid option /va must specify 0xBase-0xSize as next arg\n");
				exit(0);
			}
		}

	}
	
	LoadLibrary("urlmon.dll");
    LoadLibrary("wininet.dll");

	if(showHooks==1){
		InstallHooks();
		exit(0);
	}

	//now we scan for the options which can require messages and processing. (after hooks so log file shows
	for(i=2; i<argc; i++){

		if(strstr(argv[i],"/log") > 0 ){ 
			SetConsoleTextAttribute(STDOUT,  0x0E); //yellow
			if(i+1 < argc){
				char* target = argv[i+1];
				logFile = (HANDLE)OpenFile(target, &o , OF_CREATE);
				if(logFile==NULL){
					printf("Option /log Could not create file %s\r\n", target);
					printf("Press any key to continue...\r\n");
					getch();

				}
			}
			SetConsoleTextAttribute(STDOUT,  0x07); //default gray
		}

		if(strstr(argv[i],"/fopen") > 0 ){ //you can open multiple if you want...
			SetConsoleTextAttribute(STDOUT,  0x0E); //yellow
			if(i+1 < argc){
				char* target = argv[i+1];
				HANDLE fHand =  (HANDLE)OpenFile(target, &o , OF_READ);
				if(fHand == INVALID_HANDLE_VALUE ){
					printf("Option /fopen Could not open file %s\r\n", target);
					printf("Press any key to continue...\r\n");
					getch();

				}else{
					DWORD bs;
					printf("Opened %s successfully handle=0x%x  size=0x%x\r\n", target ,fHand, GetFileSize(fHand, &bs) );
				}
			}else{
				printf("/fHand File arg does not exist!\r\n");
				printf("Press any key to continue...\r\n");
				getch();
			}
			SetConsoleTextAttribute(STDOUT,  0x07); //default gray
		}

	}

	char* filename = argv[1];
	HANDLE h =  (HANDLE)OpenFile(filename, &o , OF_READ);
	
	if(h == INVALID_HANDLE_VALUE ){
		printf("Could not open file %s\r\n\r\n", filename);
		return;
	}

	strcpy(sc_file,argv[1]);
	bufsz = GetFileSize(h,NULL);
	
	if( bufsz == INVALID_FILE_SIZE){
		printf("Could not get filesize\r\n\r\n");
		CloseHandle(h);
		return;
	}

	if(addbpx){
		printf("Adding Breakpoint to beginning of shellcode buffer\r\n");
		bufsz++;
	}
	else{
		SetUnhandledExceptionFilter(exceptFilter);
	}

	atexit(myAtExit); //for GAlloc and VAlloc mem dumping if we have to.

	//buf = (char*)malloc(bufsz);
	buf = (char*)VirtualAlloc((void*)0x11110000 , bufsz, MEM_RESERVE | MEM_COMMIT , 0x40);
	if(buf == 0){
		printf("VirtualAlloc failed..aborting run\n");
		exit(0);
	};

	printf("Loading Shellcode into memory\r\n");

	if(addbpx){
		buf[0]= (unsigned char)0xCC;
		ReadFile(h, &buf[1]  , (bufsz-1) ,&l,0);
	}else{
		ReadFile(h, buf  , bufsz ,&l,0);
	}

	CloseHandle(h);

	printf("Shellcode buffer: 0x%x - 0x%x  (sz=0x%x)\r\n", (int)buf, (int)buf + bufsz, bufsz);

	if(foff > 0) printf("Start opcodes: %04x    %x %x %x %x %x\n", foff, buf[foff],buf[foff+1],buf[foff+2],buf[foff+3],buf[foff+4]);

	if(stepMode) SetConsoleMode(STDIN, !ENABLE_LINE_INPUT ); //turn off line input (bug: this breaks ctrl-c)

	printf("Starting up winsock\r\n");
	
	if ( WSAStartup(MAKEWORD(1,1), &WsaDat) !=0  ){  
		printf("Sorry WSAStartup failed exiting.."); 
		return;
	}

	printf("Installing Hooks\r\n" ) ;
	InstallHooks();

	msg("Executing Buffer...\r\n\r\n"); //we are hooked now only use safe display fx
	msg("_ret_____API_________________\r\n",0x02);

	HOOK_MSGS_OFF = 0;

	_asm{
		   mov eax, buf
		   mov ebx, foff
		   add eax, ebx
		   jmp eax
	}

	//we wont ever get down here..

}





//_______________________________________________ install hooks fx 

void DoHook(void* real, void* hook, void* thunk, char* name){

	if(showHooks==1){
		printf("\t%s\r\n",name);
		hook_count++;
	}else{
		if ( !InstallHook( real, hook, thunk, 0) ){ //try to install the real hook here
			infomsg("Install %s hook failed...Error: %s\r\n", name, &lastError);
			ExitProcess(0);
		}
	}
}


//Macro wrapper to build DoHook() call
#define ADDHOOK(name) DoHook( name, My_##name, Real_##name, #name );


void InstallHooks(void)
{
 
	ADDHOOK(LoadLibraryA); 
	ADDHOOK(WriteFile);
	ADDHOOK(CreateFileA);
	ADDHOOK(WriteFileEx);
	ADDHOOK(_lcreat);
	ADDHOOK(_lopen);
	ADDHOOK(_lread);
	ADDHOOK(_lwrite);
	ADDHOOK(CreateProcessA);
	ADDHOOK(WinExec);
	ADDHOOK(ExitProcess);
	ADDHOOK(ExitThread);
	ADDHOOK(GetProcAddress);
	ADDHOOK(WaitForSingleObject);
	ADDHOOK(CreateRemoteThread);
	ADDHOOK(OpenProcess);
	ADDHOOK(WriteProcessMemory);
	ADDHOOK(GetModuleHandleA);
	ADDHOOK(accept);
	ADDHOOK(bind);
	ADDHOOK(closesocket);
	ADDHOOK(connect);
	ADDHOOK(gethostbyaddr);
	ADDHOOK(gethostbyname);
	ADDHOOK(gethostname);
	ADDHOOK(listen);
	ADDHOOK(recv);
	ADDHOOK(send);
	ADDHOOK(shutdown);
	ADDHOOK(socket);
	ADDHOOK(WSASocketA);
	ADDHOOK(system);
	ADDHOOK(fopen);
	ADDHOOK(fwrite);

	//_asm int 3

	//ADDHOOK(URLDownloadToFileA);

	void* real = GetProcAddress( GetModuleHandle("urlmon.dll"), "URLDownloadToFileA");
	if ( !InstallHook( real, My_URLDownloadToFileA, Real_URLDownloadToFileA,0) ){ 
		infomsg("Install hook URLDownloadToFileA failed...Error: \r\n");
		ExitProcess(0);
	}

	/*
	00405CE9   68 84E74100      PUSH 41E784                              
	00405CEE   68 13114000      PUSH 401113
	00405CF3   68 AF104000      PUSH 4010AF
	00405CF8   A1 58044200      MOV EAX,DWORD PTR DS:[420458] <-- this deref was missing for these two
	00405CFD   50               PUSH EAX                          when using the macro?
	00405CFE   E8 E7B4FFFF      CALL 004011EA                             
	*/


	//ADDHOOK(URLDownloadToCacheFile);

	real = GetProcAddress( GetModuleHandle("urlmon.dll"), "URLDownloadToCacheFileA");
	if ( !InstallHook( real, My_URLDownloadToCacheFile, Real_URLDownloadToCacheFile,0) ){ 
		infomsg("Install hook URLDownloadToCacheFile failed...Error: \r\n");
		ExitProcess(0);
	}



	//added 10.1.10
	ADDHOOK(GetFileSize)
	ADDHOOK(GetTempPathA)
	ADDHOOK(FindFirstFileA)
	ADDHOOK(VirtualAllocEx)

	if(allocLogging == 1){
		ADDHOOK(VirtualAlloc)
		ADDHOOK(VirtualFree)
		ADDHOOK(GlobalAlloc)
		ADDHOOK(GlobalFree)
	}

	//ADDHOOK(IsDebuggerPresent) //header errors
	//ADDHOOK(GetFileSizeEx)     //old vc6 header and libs
	//ADDHOOK(FindFirstFileExA)  //old vc6 header and libs

	if(showHooks==1) printf("Hooks: %d\r\n", hook_count);
	 	
}


