

           PdfStream Dumper v.9


Capabilities
--------------------------------------

	This tool is designed to allow you to parse and analyze PDF files in their raw format.
	It includes allot of features like being able to:
	
	- view all pdf objects
	- view deflated streams
	- view stream details such as file offsets, header, etc
	- save raw and deflated data
	- decompile Flash ActionScript 3 files with AS3 Sorcerer (Trial included) 
	- supports filters: FlateDecode, RunLengthDecode, ASCIIHEXDecode, ASCII85Decode, LZWDecode
        - supports filter chaining (ie multiple filters applied to same stream)
        - supports unescaping encoded pdf headers
	- search streams for strings
	- perform various types of manual escapes on selected data portions.
	- scan for functions which contain pdf exploits (dumb scan)
	- format javascript using js beautifier (see credits at end)
	- view streams as hex dumps
	- zlib compress/decompress arbitrary files
	- replace/update pdf streams with your own data
	- basic javascript interface so you can execute parts of embedded scripts
	- integrated UI for sclog shellcode analysis tool from idefense. (seperate install)
	- integrated UI for sctest shellcode analysis tool using libemu. (included in install)
	- js ui also has access to a toolbox class to do a bunch of things (dump to file etc)
	- decrypt encrypted pdf files (uses iTextSharp)
	- basic ability to rename obsfuscated javascript functions, arguments, and variables
	- can hide: header only streams, duplicate streams (by crc), selected streams
	
	This tool is useful for many things, it is free and open source.
	
	It does not parse pdfs fully, it basically just extracts obj streams and headers.
	
	I dont want to try to make it to smart, few assumptions means fewer places
	to try to break its analysis by malicious pdfs. Even if this means you have
	to manuallly apply more smarts when looking at it. 
	
	I am trying to keep this tool pretty raw so you can see their tricks yet
	still have the tools on hand to bypass them. 
	
	Decryption app is in C# using iTextSharp. It copies the contents of the owner
	password protected pdf into a new file and unencrypts it as it does so. 


Notes:
-----------------------------------------

	The filters and pdf decrypt features are optional
	they require .NET 2.0 (or above) installed. The app should run fine without
        them, just wont support these extra features.
	
	if you want to use the sclog shellcode analysis feature download the
	Malcode Analyst Pack from iDefense and install to its default location. 
	
	If you dont have it, the download will be initiated (visibly) 
	when you goto use it. 
	
	 -----> sclog runs LIVE SHELLCODE so    <----
	 -----> ONLY USE IT ON A TEST MACHINE ! <---- (duh)
	
	Download Link: http://labs.idefense.com/software/download/?downloadID=8
	
	I have now also integrated in sctest shellcode analysis tool from the guys
	at libemu project. This tool analyzes shellcode in an emulation envirnoment
	so should be safe(r). A binary is included with the install package. Would also
	like to thank the malzilla project for bringing this cool tool to my attention.

	If you find a pdf which pdfstreamdumper cant deal with, feel free to mail
	it in a password protected zip file to me at dzzie@yahoo.com



Hot Keys and other Behaviors:
---------------------------

	main form left hand listview supports coloring based on stream types, use mouseover to
	see tooltip, or use Tools->About lv Colors to see color map info.
	
	this listview also supports some hot keys. 
	Ctrl-a = select all
	ctrl-n = select none
	ctrl-d = deleted selected (no changes are made to the pdf)
	ctrl-i = invert selection
	
	these are useful with the listview right click menu options to save streams because these
	menu items work on all streams in the listview itself.
	
	also the Search menu item will auto select all the matches it finds in this main listview too
	in case you want to select all fonts and then save them the streams you are only a couple clicks
	away regardless of how many are in the file. 
	
	once you trim out the list, you can reload it anytime by clicking the load button again.
	
	also check out the Tools->options menu where you can auto hide duplicate streams, and header only
	streams. (you probably wan to view headers by default)
	
	Example: 
	--------------------
	  How do I extract all of the unique fonts in a decompressed format from a 
	  pdf quickly if the pdf has hundreds of objects?
	
	  1) make sure the tools->options->hide duplicate streams option is set
	  2) click the search_for->TTF Fonts This will select all fonts in main list.
	  3) right click on one of the selected fonts in the main list (on left) 
	      and choose the menu option to hide unselected
	  4) right click on main list (which only contains the fonts now) and choose
	      save all decompressed streams
	
	  To reload all of the streams again, just click the load button to start over.


Source Code and projects
---------------------------------------

	Source code for all components is included with this installer. 
	You will find a \source directory on the start menu entry with the
	project files. 
	
	There are also a couple other smaller debug projects
	nested in the various directories which I didnt list in the start menu. 
	
	See other projects for descriptions of the main project files.
	
	
	pdf_stream_dumper.exe - main app and vb6 source
		
	
	iTextDecode.exe
	---------------------------------------
	small command line app that implements the following decode filters from
	the iTextSharp project source.
	
	LZWDecode, FlateDecode, ASCIIHexDecode, ASCII85HexDecode.
	
	I also added a RunLengthDecode function that I ported from Didier Stevens python code
	
	This standalone exe uses input and output files. I use it for testing/developing filters
	since it can be run manually and debugged as an exe. 
	
	this application requires the .NET 2.0 framework (or above), 
	C# source to exe included.
	
	
	iTextFilters.dll
	----------------------------------------
	
	this is the dll version of iTextDecode so that it can be used easily from VB 
	over COM. it uses global memory offsets to pass binary data between VB6 and
	the managed memory of C#.
	
	pdfStreamDumper does not depend on this component in case you dont have the 
	.NET 2.0 framework installed. It still supports FlateDecode and ASCIIHEXDecode
	natively.
	
	this application requires the .NET 2.0 framework (or above), 
	C# source included.
	
	
	olly.dll
	----------------------------------------
	
	This is a x86 opcode disassembler engine taken from source by Oleh Yuschuk.
	more details here: http://sandsprite.com/CodeStuff/olly_dll.html


To Do:
----------------------------------------

	- implement JBig2,Jpx, CTTI, and DCT filters into iTextFilters/iTextDecode
	- i dont think my page count is accurate, need to figure that out so I can 
            implement script toolbox command to get page and words for scripts which
            (ab)use that in their decoding. 
        - xor brute forcer to search for embedded executables (or strings) in main 
            file or streams as well as shellcode


Credits:
---------------------------

	Original stream parser was written by by VBboy136 - 12/9/2008
	http://www.codeproject.com/KB/DLL/PDF2TXTVB.aspx
	
	Scintilla by Neil Hodgson [neilh@scintilla.org] 
        http://www.scintilla.org/

        ScintillaVB by Stu Collier
        http://www.ceditmx.com/software/scintilla-vb/

	AS3 Sorcerer Trial provided courtesy of Manitu Group. 
	http://www.as3sorcerer.com/

	JS Beautify by Einar Lielmanis, <einar@jsbeautifier.org>_
	conversion to Javascript code by Vital, <vital76@gmail.com>
	http://jsbeautifier.org/
	
	zlib.dll by Jean-loup Gailly and Mark Adler
	http://www.zlib.net/
	
	CRC32 code by Steve McMahon
	http://www.vbaccelerator.com/home/vb/code/libraries/CRC32/article.asp
	
	iTextDecode/iTextFilters use iTextSharp by Bruno Lowagie and Paulo Soares
	http://itextpdf.com/terms-of-use/index.php
	
	olly.dll GPL code Copyright (C) 2001 Oleh Yuschuk.
	http://home.t-online.de/home/Ollydbg/
	
	libemu and sctest.exe written by Paul Baecher and Markus Koetter 2007.	
	http://libemu.carnivore.it/about.html
	
        sclog is a tool i wrote back at iDefense source here  
        http://labs.idefense.com/software/download/?downloadID=8 

	Interface by dzzie@yahoo.com 
	http://sandsprite.com
	
	Other thanks to Didier Stevens for the info on his blog on tags and encodings.
	http://blog.didierstevens.com/2008/04/29/pdf-let-me-count-the-ways
	
