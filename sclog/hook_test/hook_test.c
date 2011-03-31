#include <windows.h>
#include <stdio.h>
#include "./../hooker.h"

#pragma warning (disable:4047)
#pragma warning (disable:4024)

unsigned int __declspec(naked) CalledFrom(void){
	_asm{
			mov eax, [ebp+4]
			ret
	}
}



//___________________________________________________________________method 1 raw byte buffer
//our thunk space for x stolen bytes and jmp back to real_api + x  
char Test_thunk[20];   
char LoadLibrary_thunk[20];				  

//out function pointers to the thunks so we can call them easily
void (*RealTest)(void) = Test_thunk;
HANDLE (__stdcall *Real_LoadLibrary)(char*) = LoadLibrary_thunk;

void test(void){ printf("Inside Test\n");}
void hook(void){ printf("In Hook\n");}

HANDLE __stdcall My_LoadLibrary(char* dllName){	
	printf("Inside hooked LoadLibrary! %s Called From: %X\n", dllName, CalledFrom() );
	return Real_LoadLibrary(dllName);
}


//___________________________________________________________________method 2 
//basically used to give us a function pointer with right prototype
//and 24 byte empty buffer inline which we assemble commands into in the
//hook proceedure. 
#define ALLOC_THUNK(prototype) __declspec(naked) prototype { __asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop};__asm{nop}; }	   

ALLOC_THUNK( FARPROC  __stdcall Real_GetProcAddress(HMODULE a0,LPCSTR a1));


FARPROC __stdcall My_GetProcAddress(HMODULE a0,LPCSTR a1)
{
	printf("Inside My_GetProcAddress(%s)\n",a1);
	return Real_GetProcAddress(a0,a1);
}


//___________________________________________________________________________







	




//__________________________________________________ main application code ____________
void main(void){
	
	HMODULE h=0;
	FARPROC f=0;

	if ( !InstallHook( test, hook, Test_thunk) ){
		printf("Install hook failed :(");
		return;
	}

	
	printf("Calling test!\n");
	test();
	
	printf("Trying to call the real api now!\n");

	RealTest();

	printf("And back where i belong at end\n");

	if (!InstallHook( LoadLibrary, My_LoadLibrary, LoadLibrary_thunk) ){
		printf("Install hook failed :(");
		return;
	}
	
	printf("Loadlibrary hook installed\n");
	
	h = LoadLibrary("ws2_32");
	printf("Ws2_32 handle=%X\n", h );

	if(!InstallHook( GetProcAddress, My_GetProcAddress, Real_GetProcAddress) ){
		printf("Install hook failed :(");
		return;
	}

	printf("GetProc Hook installed\n");
	f = GetProcAddress(h,"listen");
	printf("GetProcAddress(listen)=%X\n\n", f);


}


