[Setup]
AppName=PDFStreamDumper
AppVerName=PDFStreamDumper 0.9.3xx
DefaultDirName=c:\PDFStreamDumper
DefaultGroupName=PDFStreamDumper
UninstallDisplayIcon={app}\unins000.exe
OutputDir=./
OutputBaseFilename=PDFStreamDumper_Setup


[Dirs]
Name: {app}\iTextFilters
Name: {app}\iTextFilters\iText_Filters
Name: {app}\iTextFilters\iText_Filters\Properties
Name: {app}\iTextFilters\VB_filtersDebug
Name: {app}\scripts
Name: {app}\libemu
Name: {app}\husk
Name: {app}\plugins
Name: {app}\plugins\build_db
Name: {app}\plugins\objbrowser
Name: {app}\plugins\VirusTotal
Name: {app}\highlighters
Name: {app}\libemu\scSigs
Name: {app}\xor_bruteforcer
Name: {app}\sc_samples
Name: {app}\AS3_WebInstall
Name: {app}\mupdf
Name: {app}\mupdf\jbig2dec
Name: {app}\mupdf\sample_data
Name: {app}\mupdf\VB_TEST

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
;Source: ./\olly.dll; DestDir: {app}
Source: ./\zlib.dll; DestDir: {app}
Source: ./\userLib.js; DestDir: {app}
Source: ./\myMain.js; DestDir: {app}
Source: ./\CApplyFilters.cls; DestDir: {app}
Source: ./\frmManualFilters.frm; DestDir: {app}
Source: ./\frmManualFilters.frx; DestDir: {app}
Source: ./\JS_UI_Readme.txt; DestDir: {app}
Source: ./\ucScint.ctl; DestDir: {app}
Source: ./\api.api; DestDir: {app}
Source: ./\sclog.exe; DestDir: {app}
Source: ./\sclog_README.txt; DestDir: {app}
Source: ./\sclog.url; DestDir: {app}
Source: ./\frmInlineDecoderCalls.frm; DestDir: {app}
Source: ./\frmInlineDecoderCalls.frx; DestDir: {app}
Source: ./\dependancies\MSCOMCTL.OCX; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\msscript.ocx; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\richtx32.ocx; DestDir: {win}; Flags: regserver uninsneveruninstall
Source: ./\dependancies\SCIVBX.ocx; DestDir: {app}; Flags: regserver
Source: ./\dependancies\SciLexer.dll; DestDir: {app}
Source: ./\dependancies\hexed.ocx; DestDir: {app}; Flags: regserver
Source: CSharpFilters.cls; DestDir: {app}
Source: frmScTest.frm; DestDir: {app}
Source: husk.dat; DestDir: {app}
Source: simple_husk.dat; DestDir: {app}
Source: frmBruteZLib.frm; DestDir: {app}
Source: frmBruteZLib.frx; DestDir: {app}
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
Source: iTextFilters.dll; DestDir: {app}; Flags: ignoreversion
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
Source: husk\husk.cpp; DestDir: {app}\husk\
Source: husk\exports.def; DestDir: {app}\husk\
Source: husk\husk.vcproj; DestDir: {app}\husk\
Source: husk\husk.sln; DestDir: {app}\husk\
Source: plugins\build_db\Form1.frm; DestDir: {app}\plugins\build_db
Source: plugins\build_db\MD5Hash.cls; DestDir: {app}\plugins\build_db
Source: plugins\build_db\plugin.cls; DestDir: {app}\plugins\build_db
Source: plugins\build_db\Project1.vbp; DestDir: {app}\plugins\build_db
Source: plugins\build_db\Project1.vbw; DestDir: {app}\plugins\build_db
Source: plugins\build_db\simple-fso.bas; DestDir: {app}\plugins\build_db
Source: plugins\build_db\modLVSort.bas; DestDir: {app}\plugins\build_db
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
Source: VS_LIBEMU.url; DestDir: {app}\
Source: plugins\VirusTotal\MD5Hash.cls; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\plugin.cls; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\Project1.vbp; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\Project1.vbw; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\Form1.frm; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\JSON.bas; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\cStringBuilder.cls; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\CVirusTotal.cls; DestDir: {app}\plugins\VirusTotal\
Source: plugins\VirusTotal\Form2.frm; DestDir: {app}\plugins\VirusTotal\
Source: plugins\virustotal.dll; DestDir: {app}\plugins\; Flags: regserver
Source: mupdf.dll; DestDir: {app}
Source: mupdf.bas; DestDir: {app}
Source: mupdf\jbig2dec\CHANGES; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\config_win32.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\COPYING; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith_iaid.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith_iaid.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith_int.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_arith_int.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_generic.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_generic.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_halftone.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_halftone.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_huffman.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_huffman.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_hufftab.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_image.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_image.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_metadata.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_metadata.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_mmr.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_mmr.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_page.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_priv.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_refinement.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_segment.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_symbol_dict.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_symbol_dict.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_text.c; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\jbig2_text.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\LICENSE; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\os_types.h; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\jbig2dec\README; DestDir: {app}\mupdf\jbig2dec
Source: mupdf\base_memory.cpp; DestDir: {app}\mupdf\
Source: mupdf\CONTRIBUTORS; DestDir: {app}\mupdf\
Source: mupdf\COPYING; DestDir: {app}\mupdf\
Source: mupdf\decoder.cpp; DestDir: {app}\mupdf\
Source: mupdf\exports.def; DestDir: {app}\mupdf\
Source: mupdf\filt_basic.cpp; DestDir: {app}\mupdf\
Source: mupdf\filt_faxd.cpp; DestDir: {app}\mupdf\
Source: mupdf\filt_jbig2d.cpp; DestDir: {app}\mupdf\
Source: mupdf\fitz-internal.h; DestDir: {app}\mupdf\
Source: mupdf\fitz.h; DestDir: {app}\mupdf\
Source: mupdf\mupdf_dll.opt; DestDir: {app}\mupdf\
Source: mupdf\mupdf_dll.sln; DestDir: {app}\mupdf\
Source: mupdf\mupdf_dll.suo; DestDir: {app}\mupdf\; Attribs: hidden
Source: mupdf\mupdf_dll.vcproj; DestDir: {app}\mupdf\
Source: mupdf\mupdf_dll.vcproj.DAVE_LAB.david.user; DestDir: {app}\mupdf\
Source: mupdf\README; DestDir: {app}\mupdf\
Source: mupdf\stm_buffer.cpp; DestDir: {app}\mupdf\
Source: mupdf\stm_open.cpp; DestDir: {app}\mupdf\
Source: mupdf\stm_read.cpp; DestDir: {app}\mupdf\
Source: iTextFilters\iText_Filters\CCITTFaxDecoder.cs; DestDir: {app}\iTextFilters\iText_Filters\
Source: ./\frmFilterVisualizer.frm; DestDir: {app}
Source: PDFStreamDumper.exe.manifest; DestDir: {app}



[Icons]
Name: {group}\PdfStreamDumper.exe; Filename: {app}\PDFStreamDumper.exe
Name: {group}\Source\PdfStreamDumper.vbp; Filename: {app}\Project1.vbp
Name: {group}\Readme.txt; Filename: {app}\Readme.txt
Name: {group}\Uninstall; Filename: {app}\unins000.exe
Name: {userdesktop}\PdfStreamDumper.exe; Filename: {app}\PDFStreamDumper.exe; IconIndex: 0
Name: {group}\Source\iTextFilters.sln; Filename: {app}\iTextFilters\iText_Filters.sln
Name: {group}\Source\husk.vcproj; Filename: {app}\husk\husk.vcproj
Name: {group}\Source\BuildDb_Plugin.vbp; Filename: {app}\plugins\build_db\Project1.vbp
Name: {group}\Source\ObjBrowser_Plugin.vbp; Filename: {app}\plugins\objbrowser\Project1.vbp
Name: {group}\Source\scDbg Source; Filename: {app}\VS_LIBEMU.url
Name: {group}\Source\scLog Source; Filename: {app}\sclog.url
Name: {group}\Source\mupdf.vcproj; Filename: {app}\mupdf\mupdf_dll.vcproj

[Run]
Filename: {app}\Readme.txt; StatusMsg: View ReadMe; Flags: postinstall shellexec runmaximized
Filename: regedit.exe; Flags: nowait; Parameters: /s {app}\iTextFilters\iText_Filters.reg
Filename: {app}\AS3_WebInstall\AS3_webInstall.exe
