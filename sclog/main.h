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

			sc_file     shellcode file to execute and log
			/addbpx     Adds a breakpoint to beginning of shellcode buffer
			/redir      Changes IP specified in Connect() to localhost
			/nonet      no safety net - if set we dont block any dangerous apis
			/nofilt     no api filtering - show all hook messages
			/dump       dumps shellcode buffer to disk at first api call (self decoded)
			/step       asks the user to permit each hooked API call before executing

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

*/

struct mem{
	int offset;
	int size;
}; 

//should be pretty safe to assume shellcode only does one alloc..
struct mem GAlloc;
struct mem VAlloc;

HANDLE logFile = NULL;

#include <tlhelp32.h> 

//basically used to give us a function pointer with right prototype
//and 24 byte empty buffer inline which we assemble commands into in the
//hook proceedure. 
#define ALLOC_THUNK(prototype) __declspec(naked) prototype { __asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop}; }	   

ALLOC_THUNK( HMODULE  __stdcall Real_LoadLibraryA(LPCSTR a0) );
ALLOC_THUNK( BOOL     __stdcall Real_WriteFile(HANDLE a0,LPCVOID a1,DWORD a2,LPDWORD a3,LPOVERLAPPED a4) ); 
ALLOC_THUNK( HANDLE   __stdcall Real_CreateFileA(LPCSTR a0,DWORD a1,DWORD a2,LPSECURITY_ATTRIBUTES a3,DWORD a4,DWORD a5,HANDLE a6) );
ALLOC_THUNK( HMODULE  __stdcall Real_LoadLibraryExA(LPCSTR a0,HANDLE a1,DWORD a2) );
ALLOC_THUNK( HMODULE  __stdcall Real_LoadLibraryExW(LPCWSTR a0,HANDLE a1,DWORD a2) );
ALLOC_THUNK( HMODULE  __stdcall Real_LoadLibraryW(LPCWSTR a0) );
ALLOC_THUNK( BOOL	  __stdcall Real_WriteFileEx(HANDLE a0,LPCVOID a1,DWORD a2,LPOVERLAPPED a3,LPOVERLAPPED_COMPLETION_ROUTINE a4)) ;
ALLOC_THUNK( HFILE    __stdcall Real__lclose(HFILE a0));
ALLOC_THUNK( HFILE	  __stdcall Real__lcreat(LPCSTR a0,int a1));
ALLOC_THUNK( HFILE	  __stdcall Real__lopen(LPCSTR a0,int a1));
ALLOC_THUNK( UINT	  __stdcall Real__lread(HFILE a0,LPVOID a1,UINT a2));
ALLOC_THUNK( UINT	  __stdcall Real__lwrite(HFILE a0,LPCSTR a1,UINT a2));
ALLOC_THUNK( BOOL	  __stdcall Real_CreateProcessA(LPCSTR a0,LPSTR a1,LPSECURITY_ATTRIBUTES a2,LPSECURITY_ATTRIBUTES a3,BOOL a4,DWORD a5,LPVOID a6,LPCSTR a7,struct _STARTUPINFOA* a8,LPPROCESS_INFORMATION a9));
ALLOC_THUNK( UINT	  __stdcall Real_WinExec(LPCSTR a0,UINT a1));
ALLOC_THUNK( BOOL	  __stdcall Real_DeleteFileA(LPCSTR a0));
ALLOC_THUNK( void	  __stdcall Real_ExitProcess(UINT a0));
ALLOC_THUNK( void	  __stdcall Real_ExitThread(DWORD a0));
ALLOC_THUNK( FARPROC  __stdcall Real_GetProcAddress(HMODULE a0,LPCSTR a1));
ALLOC_THUNK( DWORD	  __stdcall Real_WaitForSingleObject(HANDLE a0,DWORD a1));
ALLOC_THUNK( HANDLE	  __stdcall Real_CreateRemoteThread(HANDLE a0,LPSECURITY_ATTRIBUTES a1,DWORD a2,LPTHREAD_START_ROUTINE a3,LPVOID a4,DWORD a5,LPDWORD a6));
ALLOC_THUNK( HANDLE	  __stdcall Real_OpenProcess(DWORD a0,BOOL a1,DWORD a2));
ALLOC_THUNK( BOOL	  __stdcall Real_WriteProcessMemory(HANDLE a0,LPVOID a1,LPVOID a2,DWORD a3,LPDWORD a4));
ALLOC_THUNK( HMODULE  __stdcall Real_GetModuleHandleA(LPCSTR a0));
ALLOC_THUNK( SOCKET	  __stdcall Real_accept(SOCKET a0,sockaddr* a1,int* a2));
ALLOC_THUNK( int	  __stdcall Real_bind(SOCKET a0,SOCKADDR_IN* a1,int a2));
ALLOC_THUNK( int	  __stdcall Real_closesocket(SOCKET a0));
ALLOC_THUNK( int	  __stdcall Real_connect(SOCKET a0,SOCKADDR_IN* a1,int a2));
ALLOC_THUNK( hostent* __stdcall Real_gethostbyaddr(char* a0,int a1,int a2));
ALLOC_THUNK( hostent* __stdcall Real_gethostbyname(char* a0));
ALLOC_THUNK( int	  __stdcall Real_gethostname(char* a0,int a1));
ALLOC_THUNK( int	  __stdcall Real_listen(SOCKET a0,int a1));
ALLOC_THUNK( int	  __stdcall Real_recv(SOCKET a0,char* a1,int a2,int a3));
ALLOC_THUNK( int	  __stdcall Real_send(SOCKET a0,char* a1,int a2,int a3));
ALLOC_THUNK( int	  __stdcall Real_shutdown(SOCKET a0,int a1));
ALLOC_THUNK( SOCKET   __stdcall Real_socket(int a0,int a1,int a2));
ALLOC_THUNK( SOCKET   __stdcall Real_WSASocketA(int a0,int a1,int a2,struct _WSAPROTOCOL_INFOA* a3,GROUP a4,DWORD a5));
ALLOC_THUNK( int	  Real_system(const char* cmd));
ALLOC_THUNK( FILE*	  Real_fopen(const char* cmd, const char* mode));
ALLOC_THUNK( size_t   Real_fwrite(const void* a0, size_t a1, size_t a2, FILE* a3));

ALLOC_THUNK( int	  __stdcall Real_URLDownloadToFileA(int a0,char* a1, char* a2, DWORD a3, int a4));
ALLOC_THUNK( int	  __stdcall Real_URLDownloadToCacheFile(int a0,char* a1, char* a2, DWORD a3, DWORD a4, int a5));

ALLOC_THUNK( DWORD    __stdcall Real_GetFileSize( HANDLE a0, LPDWORD a1 ) );
ALLOC_THUNK( HANDLE   __stdcall Real_FindFirstFileA( LPCSTR a0, LPWIN32_FIND_DATAA a1 ) );
ALLOC_THUNK( HGLOBAL  __stdcall Real_GlobalAlloc( UINT a0, DWORD a1 ) );
ALLOC_THUNK( HGLOBAL  __stdcall Real_GlobalFree( HGLOBAL a0 ) );
ALLOC_THUNK( LPVOID   __stdcall Real_VirtualAlloc( LPVOID a0, DWORD a1, DWORD a2, DWORD a3 ) );
ALLOC_THUNK( BOOL     __stdcall Real_VirtualFree( LPVOID a0, DWORD a1, DWORD a2 ) );
ALLOC_THUNK( DWORD    __stdcall Real_GetTempPathA( DWORD a0, LPSTR a1 ) );

//my header and lib files are old! and i dont want to link to msvc90.dll with vs08..so fuck it
//ALLOC_THUNK( DWORD    __stdcall Real_GetFileSizeEx( HANDLE a0, PLARGE_INTEGER  a1 ) );
//ALLOC_THUNK( HANDLE   __stdcall Real_FindFirstFileExA( LPCSTR a0, FINDEX_INFO_LEVELS a1, LPVOID a2, FINDEX_SEARCH_OPS a3, LPVOID a4, DWORD a5 ) );
//ALLOC_THUNK( BOOL     __stdcall Real_IsDebuggerPresent( VOID ) );


char* ProcessFromPID(DWORD pid){ //must free() results

	PROCESSENTRY32 pe;
    HANDLE hSnap;
    char* buf = NULL;

    pe.dwSize = sizeof(pe);
    hSnap = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    
    Process32First( hSnap, &pe);
    if(pid == pe.th32ProcessID) goto found;

    while( Process32Next(hSnap, &pe) ){
		if(pid == pe.th32ProcessID) goto found;
	}

none:
	  buf = (char*)malloc(4);
	  strcpy(buf,"???");
	  return buf;

found:
	
	  try{
		if(pe.szExeFile){
			buf = (char*)malloc(strlen(pe.szExeFile));
			strcpy(buf,pe.szExeFile);
			return buf;
		}
	   }catch(...){}

		goto none;
	

}




//we cant just write to str because it may not be writable memory :-/
/*
void strlower(char *str){
	
	int max=1000;
	if(str ==0) return;

	int l = strlen(str);
	if(l>max)  l = max;

	for(int i=0; i < l; i++){
		str[i] = tolower(str[i]);
	}

}
*/


char* strlower(char *str){
	
	int max=1000;
	if(str == 0 ) return (char*)malloc(1);

	int l = strlen(str);
	if(l>max)  l = max;
	
	char* mstr = (char*)malloc(max+1);
	memset((void*)mstr,0,max+1);

	for(int i=0; i < l; i++){
		mstr[i] = tolower(str[i]);
	}

	return mstr;

}


char* ipfromlng(SOCKADDR_IN* sck){
	
	char *ip = (char*)malloc(16);
	unsigned char *x=0;

    _asm{
		 mov eax, [sck]
		 add eax,4
		 mov x,eax
	}

	sprintf(ip,"%d.%d.%d.%d\x00", x[0], x[1], x[2], x[3]);
	
	return ip;

}


void msg(char* msg, int color = -1, int logit=1){ //safe hook free console output
	
	DWORD cbWritten=0;

	if(color) SetConsoleTextAttribute(STDOUT,  color);
	Real_WriteFile( STDOUT , msg , strlen(msg), &cbWritten, NULL);
	if(color) SetConsoleTextAttribute(STDOUT,  0x7); //back to default gray

	if(logit==1 && logFile!=NULL){
		Real_WriteFile( logFile , msg , strlen(msg), &cbWritten, NULL);
		FlushFileBuffers(logFile);
	}

}

void hexdump(unsigned char* str, int len){
	
	char asc[19];
	int aspot=0;
    const int hexline_length = 3*16+4;
	
	char *nl="\r\n";
	char *tmp = (char*)malloc(50);
	
	if(nohex) return;

	msg(nl);

	for(int i=0;i< len;i++){

		sprintf(tmp, "%02x ", str[i]);
		msg(tmp);
		
		if( (int)str[i]>20 && (int)str[i] < 123 ) asc[aspot] = str[i];
		 else asc[aspot] = 0x2e;

		aspot++;
		if(aspot%16==0){
			asc[aspot]=0x00;
			sprintf(tmp,"    %s\r\n", asc);
			msg(tmp);
			aspot=0;
		}

	}

	if(aspot%16!=0){//print last ascii segment if not full line
		int spacer = hexline_length - (aspot*3);
		while(spacer--)	msg(" ");	
		asc[aspot]=0x00;
		sprintf(tmp, "%s\r\n",asc);
		msg(tmp);
	}
	
	msg(nl);
	free(tmp);


}

void infomsg(const char *format, ...)
{
	DWORD dwErr = GetLastError();

	if(format){
		char buf[1024];
		va_list args; 
		va_start(args,format); 
		try{
			_vsnprintf(buf,1024,format,args);
			msg(buf,infoMsgColor);
		}
		catch(...){}
	}

	SetLastError(dwErr);
}


//added 10.2.10
void DumpMemBuf(int offset, int size, char* ext){
	
		DWORD cbWritten;
		char pth[MAX_PATH]; //should be more than enough 
		
		if(size < 1 || offset < 1){
			infomsg("     DumpMemBuf invalid args %x %x\r\n\r\n", offset,size);
			return;
		}
		
		if( IsBadReadPtr((void*)offset,size) !=0 ){
			infomsg("     DumpMemBuf invalid args %x %x\r\n\r\n", offset,size);
			return;
		}

		void* memBuf;
		memBuf = malloc(size+1);
		memcpy(memBuf, (void*)offset, size);

		strcpy(pth,sc_file);
		sprintf(pth,"%s%s",pth,ext);
		
		HANDLE h = Real_CreateFileA( (const char*) &pth, GENERIC_WRITE, 0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL); 

		if (h  == INVALID_HANDLE_VALUE){
			infomsg("     Could not create dumpfile for DumpMemBuf %s\r\n\r\n", pth);
			return;
		}
	
		Real_WriteFile( h , memBuf , size, &cbWritten, NULL);
		CloseHandle(h);
		free(memBuf);

		SetConsoleTextAttribute(STDOUT,  0x0E); //yellow
		infomsg("     DumpMemBuf %x/%x bytes to %s\r\n", cbWritten, size, pth);
		SetConsoleTextAttribute(STDOUT,  0x07); //gray

} 

void DumpBuffer(){
	
		DWORD cbWritten;
		char pth[MAX_PATH]; //should be more than enough 
	
		if(autoDump==0) return;

		autoDump=0;
		strcpy(pth,sc_file);
		sprintf(pth,"%s.dmp",pth);
		
		HANDLE h = Real_CreateFileA( (const char*) &pth, GENERIC_WRITE, 0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL); 

		if (h  == INVALID_HANDLE_VALUE){
			infomsg("     Could not create dumpfile %s\r\n\r\n", pth);
			return;
		}
	
		Real_WriteFile( h , buf , bufsz, &cbWritten, NULL);
		CloseHandle(h);

		SetConsoleTextAttribute(STDOUT,  0x0E); //yellow
		infomsg("\r\n     /Dump Option - Dumping %x/%x bytes shellcode buf to %s\r\n", cbWritten,bufsz, pth);
		SetConsoleTextAttribute(STDOUT,  0x07); //gray

} 

void LogAPI(const char *format, ...)
{
	DWORD dwErr = GetLastError();

	if(HOOK_MSGS_OFF==1) return; //we init hooks earlier now so need this..

	if(format){
		char buf[1024]; 
		va_list args; 
		va_start(args,format); 
		try{

				if(stepMode) msg("Allow ? y/n ");

				_vsnprintf(buf,1024,format,args);
				msg(buf);
				
				if(autoDump) DumpBuffer();

				if(stepMode){
					 
					 char c;
					 DWORD dwBytesRead;
					
					 for(;;){
						ReadFile(STDIN,&c,1,&dwBytesRead,NULL); //make sure line input mode off!
						if(c=='y') break;
						if(c=='n') exit(0);
					 }

				}

		}
		catch(...){}
	}

	SetLastError(dwErr);
}


//used in WaitForSingleObject, LoadLibrary and GetProcAddress..does not account for new GAlloc or VAlloc bufs

__declspec(naked) int calledFromSC(){ //seems to work anyway :P
	
	_asm{
			 mov eax, nofilt  //no filter option display all hook output
			 cmp eax, 1       //if nofilt = 1
			 je  isOk
			 
			 pushad
			 mov eax, [ebp+4]  //return address of parent function (were nekkid)
			 mov ebx, buf      //start of shellcode
			 cmp eax, ebx
			 jl failed		   //call came from address lower than shellcode buffer	
			 
			 add ebx, bufsz    //add size of shellcode to buf base to get max offset
			 cmp eax, ebx
			 jg  failed        //call came from address higher than sc buffer

			 popad
	 isOk:	 mov eax, 1
			 ret

	 failed: popad
			 mov eax, 0
			 ret

	}
	
}

/* old versions only accounted for the main shellcode buffer, new ones account for GAlloc and VAlloc
__declspec(naked) int SCOffset(){ 
	
	_asm{
			 mov eax, [ebp+4]  //return address of parent function (were nekkid)
			 mov ecx, buf      //start offset of payload
			 sub eax, ecx      //eax now = relative buffer offset of call
			 ret
	}
	
}


void AddAddr(unsigned int offset){
	char tmp[20];
	
	if(offset <= bufsz) sprintf(tmp,"%4X ", offset);
	 else strcpy(tmp," --- "); //must be from other api we dont care (bad calc anyway)

	msg(tmp);
}
*/

//substantial change in behavior 10.2.10
void AddAddr(unsigned int retAdr){
	char tmp[35];
	
	int sc = retAdr - (int)buf; 
	int ga = -1;
	int va = -1;
	int color = 0xF; //white

	if(HOOK_MSGS_OFF==1) return;// color; 

	if(GAlloc.offset > 0) ga = retAdr - GAlloc.offset;
	if(VAlloc.offset > 0) va = retAdr - VAlloc.offset;

	if(sc <= bufsz){
		sprintf(tmp,"%4X ", sc);
	}else if(ga >=0 && ga <= GAlloc.size){
		sprintf(tmp,"GAlloc: %4X ", ga);
	}else if(va >= 0 && va <= VAlloc.size){
		sprintf(tmp,"VAlloc: %4X ", va);
	}else{
		if(showadr==1){
			sprintf(tmp," %8X ", retAdr);
		}else{
			color = 0x07; //default grey
			strcpy(tmp," --- "); //must be from other api we dont care (bad calc anyway)
		}
	}

	msg(tmp); //, color);
	//return color;
}

__declspec(naked) int SCOffset(){ //has to be called from parent hook function to mean anything...
	
	_asm{
			 mov eax, [ebp+4]  //return address of parent function (were nekkid)
			 ret
	}
	
}