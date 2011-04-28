
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

#ifdef __cplusplus 
#define unique extern "C"
#else
#define unique
#endif

unique int InstallHook(void *real, void* hook, void* thunkJMP, int traditional_hook);
unique char* lastError;
