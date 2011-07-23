[Setup]
AppName=PDFStreamDumper
AppVerName=PDFStreamDumper 0.9.2xx
DefaultDirName=c:\PDFStreamDumper
DefaultGroupName=PDFStreamDumper
UninstallDisplayIcon={app}\unins000.exe
OutputDir=./
OutputBaseFilename=PDFStreamDumper_Setup


[Dirs]
Name: {app}\filter_samples
Name: {app}\filter_samples\CCITTFaxDecode
Name: {app}\filter_samples\complex
Name: {app}\filter_samples\DCTDecode
Name: {app}\filter_samples\JBIG2Decode
Name: {app}\filter_samples\jpxdecode
Name: {app}\iTextDecode
Name: {app}\iTextDecode\lzw_test
Name: {app}\iTextDecode\lzw_test\Properties
Name: {app}\iTextDecode\lzw_test\zlib
Name: {app}\iTextFilters
Name: {app}\iTextFilters\iText_Filters
Name: {app}\iTextFilters\iText_Filters\Properties
Name: {app}\iTextFilters\VB_filtersDebug
Name: {app}\scripts
Name: {app}\libemu
Name: {app}\sclog
Name: {app}\sclog\bin
Name: {app}\sclog\hooker
Name: {app}\sclog\hook_test
Name: {app}\sclog\parse_h
Name: {app}\husk
Name: {app}\plugins
Name: {app}\plugins\build_db
Name: {app}\plugins\objbrowser
Name: {app}\highlighters
Name: {app}\libemu\scSigs
Name: {app}\xor_bruteforcer
Name: {app}\sc_samples
Name: {app}\AS3_WebInstall

[Files]
Source: ./\highlighters\CPP.Bin; DestDir: {app}\highlighters
Source: ./\highlighters\Java.bin; DestDir: {app}\highlighters
Source: ./iTextSharp.dll; DestDir: {app}
Source: ./\beautify.js; DestDir: {app}
Source: ./\clsCmnDlg.cls; DestDir: {app}
Source: ./\CPdfParser.cls; DestDir: {app}
Source: ./\CPDFStream.cls; DestDir: {app}
Source: ./\CScriptFunctions.cls; DestDir: {app}
Source: ./\Form1.frm; DestDir: {app}
Source: ./\Form1.frx; DestDir: {app}
Source: ./\Form2.frm; DestDir: {app}
Source: ./\Form2.frx; DestDir: {app}
Source: ./\frmReplace.frm; DestDir: {app}
Source: ./\frmSclog.frm; DestDir: {app}
Source: ./\frmSclog.frx; DestDir: {app}
Source: ./\frmAbout.frm; DestDir: {app}
Source: ./\frmAbout.frx; DestDir: {app}
Source: ./\modCrc.bas; DestDir: {app}
Source: ./\Module4.bas; DestDir: {app}
Source: ./\PDFStreamDumper.exe; DestDir: {app}
Source: ./\Project1.vbp; DestDir: {app}
Source: ./\Project1.vbw; DestDir: {app}
Source: ./\Readme.txt; DestDir: {app}
Source: ./\CFunc.cls; DestDir: {app}
Source: ./\b64.bas; DestDir: {app}
Source: ./\frmRefactor.frm; DestDir: {app}
Source: ./\simple-fso..bas; DestDir: {app}
Source: ./\CInstruction.cls; DestDir: {app}
Source: ./\CDisassembler.cls; DestDir: {app}
Source: ./\modEscapes.bas; DestDir: {app}
Source: ./\olly.dll; DestDir: {app}
Source: ./\zlib.dll; DestDir: {app}
Source: ./\userLib.js; DestDir: {app}
Source: ./\myMain.js; DestDir: {app}
Source: ./\CApplyFilters.cls; DestDir: {app}
Source: ./\frmManualFilters.frm; DestDir: {app}
Source: ./\frmManualFilters.frx; DestDir: {app}
Source: ./\JS_UI_Readme.txt; DestDir: {app}
Source: ./\ucScint.ctl; DestDir: {app}
Source: ./\api.api; DestDir: {app}
Source: ./\dependancies\MSCOMCTL.OCX; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\msscript.ocx; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\richtx32.ocx; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\SCIVBX.ocx; DestDir: {app}; Flags: regserver
Source: ./\dependancies\SciLexer.dll; DestDir: {app}
Source: iTextDecode\lzw_test\Properties\AssemblyInfo.cs; DestDir: {app}\iTextDecode\lzw_test\Properties
Source: iTextDecode\lzw_test\zlib\Adler32.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\Deflate.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\InfBlocks.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\InfCodes.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\Inflate.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\InfTree.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\JZlib.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\StaticTree.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\Tree.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\ZDeflaterOutputStream.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\ZInflaterInputStream.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\zlib\ZStream.cs; DestDir: {app}\iTextDecode\lzw_test\zlib
Source: iTextDecode\lzw_test\app.config; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\lzw_test\Decoder.cs; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\lzw_test\LZWDecoder.cs; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\lzw_test\lzw_test.csproj; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\lzw_test\lzw_test.csproj.user; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\lzw_test\Program.cs; DestDir: {app}\iTextDecode\lzw_test
Source: iTextDecode\iTextDecode.exe; DestDir: {app}\iTextDecode\
Source: iTextDecode\iTextDecode.sln; DestDir: {app}\iTextDecode\
Source: CSharpFilters.cls; DestDir: {app}
Source: iTextFilters\iText_Filters\Properties\AssemblyInfo.cs; DestDir: {app}\iTextFilters\iText_Filters\Properties
Source: iTextFilters\iText_Filters\app.config; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\iText_Filters\Filters.cs; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\iText_Filters\iText_Filters.csproj; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\iText_Filters\iText_Filters.csproj.user; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\iText_Filters\LZWDecoder.cs; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\iText_Filters\MemMapFile.cs; DestDir: {app}\iTextFilters\iText_Filters
Source: iTextFilters\VB_filtersDebug\CSharedMemory.cls; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\CSharpFilters.cls; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\frmMain.frm; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\org_CSharpFilters.cls; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\Project1.exe; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\Project1.vbp; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters\VB_filtersDebug\Project1.vbw; DestDir: {app}\iTextFilters\VB_filtersDebug
Source: iTextFilters.dll; DestDir: {app}
Source: iTextFilters\iText_Filters.sln; DestDir: {app}\iTextFilters\
Source: iTextFilters.tlb; DestDir: {app}; Flags: regtypelib
Source: iTextFilters\iText_Filters.reg; DestDir: {app}\iTextFilters\
Source: iTextFilters\readme.txt; DestDir: {app}\iTextFilters\
Source: scripts\string_scan.vbs; DestDir: {app}\scripts\
Source: scripts\csv_stats.vbs; DestDir: {app}\scripts\
Source: scripts\unsupported_filters.vbs; DestDir: {app}\scripts\
Source: scripts\pdfbox_extract.vbs; DestDir: {app}\scripts\
Source: scripts\filter_chains.vbs; DestDir: {app}\scripts\
Source: scripts\obsfuscated_headers.vbs; DestDir: {app}\scripts\
Source: scripts\README.txt; DestDir: {app}\scripts\
Source: scripts\pdfbox_extract_text_page_by_page.vbs; DestDir: {app}\scripts\
Source: frmScTest.frm; DestDir: {app}
Source: husk.exe; DestDir: {app}
Source: simple_husk.dat; DestDir: {app}
Source: sclog\bin\sclog.exe; DestDir: {app}\sclog\bin
Source: sclog\hooker\asmserv.c; DestDir: {app}\sclog\hooker
Source: sclog\hooker\assembl.c; DestDir: {app}\sclog\hooker
Source: sclog\hooker\disasm.c; DestDir: {app}\sclog\hooker
Source: sclog\hooker\disasm.h; DestDir: {app}\sclog\hooker
Source: sclog\hooker\hooker.c; DestDir: {app}\sclog\hooker
Source: sclog\hooker\makelib.txt; DestDir: {app}\sclog\hooker
Source: sclog\hook_test\hook_test.c; DestDir: {app}\sclog\hook_test
Source: sclog\hook_test\hook_test.dsp; DestDir: {app}\sclog\hook_test
Source: sclog\hook_test\hook_test.dsw; DestDir: {app}\sclog\hook_test
Source: sclog\parse_h\example_output.gif; DestDir: {app}\sclog\parse_h
Source: sclog\parse_h\Form1.frm; DestDir: {app}\sclog\parse_h
Source: sclog\parse_h\parse_h.exe; DestDir: {app}\sclog\parse_h
Source: sclog\parse_h\Project1.vbp; DestDir: {app}\sclog\parse_h
Source: sclog\parse_h\Project1.vbw; DestDir: {app}\sclog\parse_h
Source: sclog\hooker.h; DestDir: {app}\sclog\
Source: sclog\hooker.lib; DestDir: {app}\sclog\
Source: sclog\main.cpp; DestDir: {app}\sclog\
Source: sclog\main.h; DestDir: {app}\sclog\
Source: sclog\psapi.lib; DestDir: {app}\sclog\
Source: sclog\sclog.dsp; DestDir: {app}\sclog\
Source: sclog\sclog.dsw; DestDir: {app}\sclog\
Source: sclog\README.txt; DestDir: {app}\sclog\
Source: husk\husk.cpp; DestDir: {app}\husk\
Source: husk\husk.dsp; DestDir: {app}\husk\
Source: husk\husk.dsw; DestDir: {app}\husk\
Source: plugins\build_db\Form1.frm; DestDir: {app}\plugins\build_db
Source: plugins\build_db\MD5Hash.cls; DestDir: {app}\plugins\build_db
Source: plugins\build_db\plugin.cls; DestDir: {app}\plugins\build_db
Source: plugins\build_db\Project1.vbp; DestDir: {app}\plugins\build_db
Source: plugins\build_db\Project1.vbw; DestDir: {app}\plugins\build_db
Source: plugins\build_db\simple-fso.bas; DestDir: {app}\plugins\build_db
Source: plugins\blank_build_db.mdb; DestDir: {app}\plugins\
Source: plugins\README.txt; DestDir: {app}\plugins\
Source: plugins\build_db.dll; DestDir: {app}\plugins\; Flags: regserver
Source: plugins\obj_browser.dll; DestDir: {app}\plugins\; Flags: regserver
Source: plugins\objbrowser\CMiniToolBox.cls; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\CNamedObject.cls; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\Form1.frm; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\MD5Hash.cls; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\plugin.cls; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\Project1.vbp; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\Project1.vbw; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\simple-fso.bas; DestDir: {app}\plugins\objbrowser\
Source: plugins\objbrowser\CParseHeaders.cls; DestDir: {app}\plugins\objbrowser\
Source: libemu\scSigs\CApiHash.cls; DestDir: {app}\libemu\scSigs
Source: libemu\scSigs\Form1.frm; DestDir: {app}\libemu\scSigs
Source: libemu\scSigs\Module1.bas; DestDir: {app}\libemu\scSigs
Source: libemu\scSigs\Project1.vbp; DestDir: {app}\libemu\scSigs
Source: libemu\scSigs\Project1.vbw; DestDir: {app}\libemu\scSigs
Source: libemu\credits.txt; DestDir: {app}\libemu\
Source: libemu\encoders.txt; DestDir: {app}\libemu\
Source: libemu\scSigs.exe; DestDir: {app}\libemu\
Source: libemu\scdbg.exe; DestDir: {app}\libemu\
Source: libemu\shellcode_hashs.txt; DestDir: {app}\libemu\
Source: libemu\string_matches.txt; DestDir: {app}\libemu\
Source: xor_bruteforcer\Form1.frm; DestDir: {app}\xor_bruteforcer\
Source: xor_bruteforcer\Project1.vbp; DestDir: {app}\xor_bruteforcer\
Source: xor_bruteforcer\Project1.vbw; DestDir: {app}\xor_bruteforcer\
Source: xor_bruteforcer\xorbrute.exe; DestDir: {app}\xor_bruteforcer\
Source: xor_bruteforcer\CAPIHash.cls; DestDir: {app}\xor_bruteforcer\
Source: AS3_WebInstall\AS3_webInstall.exe; DestDir: {app}\AS3_WebInstall\
Source: AS3_WebInstall\Form1.frm; DestDir: {app}\AS3_WebInstall\
Source: AS3_WebInstall\Form1.frx; DestDir: {app}\AS3_WebInstall\
Source: AS3_WebInstall\Project1.vbp; DestDir: {app}\AS3_WebInstall\
Source: AS3_WebInstall\Project1.vbw; DestDir: {app}\AS3_WebInstall\
Source: AS3_WebInstall\ucAsyncDownload.ctl; DestDir: {app}\AS3_WebInstall\

[Icons]
Name: {group}\PdfStreamDumper.exe; Filename: {app}\PDFStreamDumper.exe
Name: {group}\Source\PdfStreamDumper.vbp; Filename: {app}\Project1.vbp
Name: {group}\Readme.txt; Filename: {app}\Readme.txt
Name: {group}\Uninstall; Filename: {app}\unins000.exe
Name: {userdesktop}\PdfStreamDumper.exe; Filename: {app}\PDFStreamDumper.exe; IconIndex: 0
Name: {group}\Source\iTextDecoder.sln; Filename: {app}\iTextDecode\iTextDecode.sln
Name: {group}\Source\iTextFilters.sln; Filename: {app}\iTextFilters\iText_Filters.sln
Name: {group}\Source\sclog.dsw; Filename: {app}\sclog\sclog.dsw
Name: {group}\Source\husk.dsw; Filename: {app}\husk\husk.dsw
Name: {group}\Source\BuildDb_Plugin.vbp; Filename: {app}\plugins\build_db\Project1.vbp
Name: {group}\Source\ObjBrowser_Plugin.vbp; Filename: {app}\plugins\objbrowser\Project1.vbp

[Run]
Filename: {app}\Readme.txt; StatusMsg: View ReadMe; Flags: postinstall shellexec runmaximized
Filename: regedit.exe; Flags: nowait; Parameters: /s {app}\iTextFilters\iText_Filters.reg
Filename: {app}\AS3_WebInstall\AS3_webInstall.exe
