
/*

Purpose: hooker.lib and related files is a basic API hooking library
         designed to patch the hook into the actual API call and reassemble
		 the stolen bytes in a seperate thunk which is then used to run the
		 real api from that point forward.


License: hooker.c Copyright (C) 2005 David Zimmer <david@idefense.com, dzzie@yahoo.com>

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


#define STRICT
#define MAINPROG

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <memory.h>
#pragma hdrstop

#include "disasm.h"

#pragma warning (disable:4024)
#pragma warning (disable:4047)

char lastError[500];

int EnableWrite(char* offset, int size){
	int prevPerm;
	if(!VirtualProtect(offset, size, PAGE_EXECUTE_READWRITE, &prevPerm)) return 0;
	return prevPerm;
}

int RestorePerm(char* offset, int size, int oldPerm){
	return VirtualProtect(offset, size, oldPerm, &oldPerm) ;
}

int _InstallHook(char* real, char* hook, char* thunk, int traditional_hook){

	t_disasm disasm;
	t_asmmodel am;

	/* 68 aa bb cc dd  push xxxxxxxx (push ret hook = 6 bytes) (non-traditional)
	   c3              ret
	   cc              int3 */
	char hook_code[6] = {0x68,0xAA,0xBB,0xCC,0xDD,0xC3};
	char myAsm[TEXTLEN] , errtext[TEXTLEN];
	char *pointer = real;
	
	int length=0, l=0, asmLen=0, wasJMP=0, oldPerm = 0;;

	if(!EnableWrite(thunk,20)){
		sprintf(lastError,"Could not set writable memory perm on thunk?");
		return 0;
	}	

	while(length<6){ //copy min space of first instructions of real fx to our thunk
		l = Disasm(pointer,10, (unsigned long)pointer, &disasm, DISASM_CODE);
		if(l<1){ 
			sprintf(lastError,"Disasm Error?");
			return 0;
		}
		switch(disasm.cmdtype){
			case C_JMP:
			case C_JMC:
			case C_CAL: 
				
				if(length==0){ //first instruction only				
					//printf("Your target fx address first inst is a jmp or call %s\n", disasm.result );
					if(l<5){
						sprintf(lastError,"Not enough space to embed our patch?");
						return 0;
					}
					//printf("Ok Trying to reasm for new thunk address...\n");
					l = Assemble(disasm.result,((unsigned long)thunk+length),&am,0,0,errtext);
					if(l<1){
						sprintf(lastError,"Asm Length failed? %d %s %s", asmLen, &disasm.result ,errtext);
						return 0;
					}
					wasJMP=1;
					memcpy( (void*)&thunk[length],am.code ,l);
					break;
				}

			default:
				memcpy( (void*)&thunk[length], pointer ,l);
				break;

		}

		length+=l;
		pointer+=l;
	}

	if(!wasJMP){
		sprintf(myAsm,"jmp 0%X", pointer); //where we will hop back into real api + x
		asmLen = Assemble(myAsm,((unsigned long)thunk+length),&am,0,0,errtext);
		
		if(asmLen<1){
			sprintf(lastError,"Asm Length failed? %d %s", asmLen,errtext);
			return 0;
		}

		memcpy( (void*)&thunk[length], am.code, asmLen); 
	}

	//printf("Ok i think the thunk is built! final size: %d\n", (length+asmLen) );

	
	//now we replace the first bytes of the real function with a 
	//rdirection to our hook replacement	
	if(traditional_hook){
		sprintf(myAsm,"jmp 0%X", (int)hook);                //jmp hook
		asmLen = Assemble(myAsm,(int)real,&am,0,0,errtext); //asm to embed at real fx start
		
		if(asmLen<1){
			sprintf(lastError,"Asm Length failed? %d %s", asmLen,errtext);
			return 0;
		}
	}else{
		memcpy( &hook_code[1], (int)&hook, 4); //embed our address in tmp buf
	}

	oldPerm = EnableWrite(real,asmLen);
	
	if(!oldPerm){
		sprintf(lastError,"Could not enable write on real function address? %x", real);
		return 0 ;
	}

	while(length--) real[length] = 0xCC; //be tidy for debugging sake (CC full stolen buffer from real function)
	
	if(traditional_hook){
		memcpy(real, am.code, asmLen);       //embed our patch at beginning of real function
	}else{
		memcpy(real, hook_code, 6);
	}
	
	RestorePerm(real,asmLen,oldPerm);

	return 1;

}


int InstallHook(void *real, void* hook, void* thunkJMP, int traditional_hook){

	t_disasm disasm;
	int l=0;
	char* realAllocation;
	
	l = Disasm( thunkJMP,10, (unsigned long)thunkJMP, &disasm, DISASM_CODE);
	
	if(l<1){ 
		sprintf(lastError,"InstallHook Looking for init JMP Disasm Error?");
		return 0;
	}
	
	//this handles the case where VC puts the function pointer to our thunk
	//into a jmp table which redirects execution to the real function body..
	//this is why i was originally using clean guaranteed byte buffers! pfft
	switch(disasm.cmdtype){
		case C_JMP: 
			realAllocation = disasm.jmpconst;
			return _InstallHook( (char*) real, (char*) hook, realAllocation, traditional_hook);
		default:
			return _InstallHook( (char*) real, (char*) hook, (char*)thunkJMP, traditional_hook);
	}
	
}
