VERSION 5.00
Object = "{0E59F1D2-1FBE-11D0-8FF2-00A0D10038BC}#1.0#0"; "msscript.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Form1 
   Caption         =   "PDF Stream Dumper - http://sandsprite.com"
   ClientHeight    =   8940
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   13710
   BeginProperty Font 
      Name            =   "Courier New"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form1"
   ScaleHeight     =   8940
   ScaleWidth      =   13710
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ListView lvDebug 
      Height          =   1455
      Left            =   3240
      TabIndex        =   15
      Top             =   6480
      Visible         =   0   'False
      Width           =   10275
      _ExtentX        =   18124
      _ExtentY        =   2566
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Message"
         Object.Width           =   2540
      EndProperty
   End
   Begin MSComctlLib.ProgressBar pb 
      Height          =   285
      Left            =   5805
      TabIndex        =   14
      Top             =   6165
      Width           =   7710
      _ExtentX        =   13600
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   1
   End
   Begin MSScriptControlCtl.ScriptControl scAuto 
      Left            =   12240
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      Timeout         =   100000
   End
   Begin MSScriptControlCtl.ScriptControl sc 
      Left            =   12960
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      Language        =   "jscript"
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   13
      Top             =   8685
      Width           =   13710
      _ExtentX        =   24183
      _ExtentY        =   450
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   9
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel4 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel5 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel6 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel7 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel8 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
         BeginProperty Panel9 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin VB.TextBox txtDetails 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3615
      HideSelection   =   0   'False
      Left            =   4005
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   9
      Text            =   "Form1.frx":0000
      Top             =   1980
      Visible         =   0   'False
      Width           =   9135
   End
   Begin RichTextLib.RichTextBox txtUncompressed 
      Height          =   4095
      Left            =   3120
      TabIndex        =   3
      Top             =   1620
      Width           =   9855
      _ExtentX        =   17383
      _ExtentY        =   7223
      _Version        =   393217
      HideSelection   =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"Form1.frx":000D
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox he 
      Height          =   5895
      Left            =   2160
      TabIndex        =   12
      Top             =   120
      Width           =   11295
      _ExtentX        =   19923
      _ExtentY        =   10398
      _Version        =   393217
      HideSelection   =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"Form1.frx":008F
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Shell"
      Enabled         =   0   'False
      Height          =   375
      Left            =   0
      TabIndex        =   11
      Top             =   8280
      Width           =   855
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "..."
      BeginProperty Font 
         Name            =   "System"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   11640
      TabIndex        =   10
      Top             =   8280
      Width           =   615
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Load"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   12240
      TabIndex        =   0
      Top             =   8280
      Width           =   1335
   End
   Begin MSComctlLib.ListView lvSearch 
      Height          =   1455
      Left            =   2400
      TabIndex        =   7
      Top             =   6480
      Visible         =   0   'False
      Width           =   11175
      _ExtentX        =   19711
      _ExtentY        =   2566
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Search Results"
         Object.Width           =   2540
      EndProperty
   End
   Begin MSComctlLib.ListView lv2 
      Height          =   1455
      Left            =   2040
      TabIndex        =   6
      Top             =   6480
      Width           =   11415
      _ExtentX        =   20135
      _ExtentY        =   2566
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Errors"
         Object.Width           =   2540
      EndProperty
   End
   Begin MSComctlLib.TabStrip TabStrip1 
      Height          =   1815
      Left            =   2040
      TabIndex        =   5
      Top             =   6480
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   3201
      MultiRow        =   -1  'True
      Placement       =   1
      TabStyle        =   1
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Errors"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Search"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Debug"
            ImageVarType    =   2
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ListView lv 
      Height          =   8295
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   14631
      View            =   3
      LabelEdit       =   1
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Objects"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.TextBox txtPDFPath 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   2040
      OLEDropMode     =   1  'Manual
      TabIndex        =   1
      Text            =   "Drag and drop pdf file here"
      Top             =   8370
      Width           =   9615
   End
   Begin MSComctlLib.TabStrip ts 
      Height          =   6495
      Left            =   2040
      TabIndex        =   8
      Top             =   0
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   11456
      MultiRow        =   -1  'True
      Placement       =   1
      TabStyle        =   1
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Text"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "HexDump"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Stream Details"
            ImageVarType    =   2
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      Caption         =   "PDF Path"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   8400
      Width           =   1095
   End
   Begin VB.Menu mnuLoadTop 
      Caption         =   "Load"
      Begin VB.Menu mnuLoadFile 
         Caption         =   "Pdf File"
      End
      Begin VB.Menu muLoadShellcode 
         Caption         =   "Shellcode File"
      End
      Begin VB.Menu mnuLoadJSFile 
         Caption         =   "Javascript File"
      End
      Begin VB.Menu mnuPlugin 
         Caption         =   "Run Plugin"
         Begin VB.Menu mnuPluginList 
            Caption         =   "Automation Script"
            Index           =   0
         End
      End
   End
   Begin VB.Menu mnuExploitScan 
      Caption         =   "Exploits_Scan"
   End
   Begin VB.Menu mnuFormatJS 
      Caption         =   "Format_Javascript"
      Visible         =   0   'False
   End
   Begin VB.Menu mnuJavascriptUI 
      Caption         =   "Javascript_UI"
   End
   Begin VB.Menu mnuUnescape 
      Caption         =   "Unescape_Selection"
   End
   Begin VB.Menu mnuManualEscapes 
      Caption         =   "Manual_Escapes"
      Begin VB.Menu mnuManualEscape 
         Caption         =   "HexString Unescape (Preserve White Space)"
         Index           =   0
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "HexString Unescape (Strip White Space)"
         Index           =   1
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "% Unescape"
         Index           =   2
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "\x Unescape"
         Index           =   3
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "\n Unescape"
         Index           =   4
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "# Unescape"
         Index           =   5
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Octal UnEscape"
         Index           =   6
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Escape and Format Headers"
         Index           =   7
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Strip CRLF and WhiteSpace"
         Index           =   8
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Extract Valid Hex Chars from Blob"
         Index           =   9
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Extract Valid Hex from blob + u -> %u"
         Index           =   10
      End
      Begin VB.Menu mnuManualEscape 
         Caption         =   "Add % to HexString"
         Index           =   11
      End
      Begin VB.Menu mnuExtractHexFromParan 
         Caption         =   "Extract Data From () Page Data"
      End
      Begin VB.Menu mnuExtractHexDump 
         Caption         =   "Extract Hex From HexDump"
         Enabled         =   0   'False
      End
   End
   Begin VB.Menu mnuUpdateCurrent 
      Caption         =   "Update_Current_Stream"
   End
   Begin VB.Menu mnuGotoObject 
      Caption         =   "Goto_Object"
   End
   Begin VB.Menu mnuSearchFor 
      Caption         =   "Search_For"
      Begin VB.Menu mnuSearch 
         Caption         =   "Search Strings"
      End
      Begin VB.Menu mnuSearchFilter 
         Caption         =   "Javascript"
         Index           =   0
      End
      Begin VB.Menu mnuSearchFilter 
         Caption         =   "Flash Objects"
         Index           =   1
      End
      Begin VB.Menu mnuSearchFilter 
         Caption         =   "U3D Objects"
         Index           =   2
      End
      Begin VB.Menu mnuSearchFilter 
         Caption         =   "TTF Fonts"
         Index           =   3
      End
      Begin VB.Menu mnuSearchFilter 
         Caption         =   "Action Tags"
         Index           =   4
      End
   End
   Begin VB.Menu mnuFindReplace 
      Caption         =   "Find/Replace"
   End
   Begin VB.Menu mnuTools 
      Caption         =   "Tools"
      Begin VB.Menu mnuDecompress 
         Caption         =   "Zlib Decompress_File"
      End
      Begin VB.Menu mnuCompress 
         Caption         =   "Zlib Compress_File"
      End
      Begin VB.Menu mnub64decode 
         Caption         =   "Base64 Decode File"
      End
      Begin VB.Menu mnuDecrypt 
         Caption         =   "Force_Decrypt"
      End
      Begin VB.Menu mnuFilters 
         Caption         =   "Manual_Filters"
      End
      Begin VB.Menu mnuHexEditor 
         Caption         =   "View PDF in Hexeditor"
      End
      Begin VB.Menu mnuspacer4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuViewExploitDetections 
         Caption         =   "View Exploit Detections"
      End
      Begin VB.Menu mnuoptions 
         Caption         =   "Options"
         Begin VB.Menu mnuAutoEscapeHeaders 
            Caption         =   "Auto Escape Headers"
         End
         Begin VB.Menu mnuVisualFormatHeaders 
            Caption         =   "Visually Format Headers"
         End
         Begin VB.Menu mnuEnableShellButton 
            Caption         =   "Enable Shell Button"
         End
         Begin VB.Menu mnuHideHeaderStreams 
            Caption         =   "Hide Header Only Objects"
         End
         Begin VB.Menu mnuHideDups 
            Caption         =   "Hide Duplicate Streams"
         End
         Begin VB.Menu mnuAlwaysUseZlib 
            Caption         =   "Always use Zlib for FlateDecode"
         End
         Begin VB.Menu mnuDisableiText 
            Caption         =   "Disable iText Decompressors"
         End
         Begin VB.Menu mnuDisableDecomp 
            Caption         =   "Disable All Decompressors"
         End
         Begin VB.Menu mnuOpenLastAtStart 
            Caption         =   "Open Last PDF on Startup"
         End
      End
      Begin VB.Menu mnuAbout 
         Caption         =   "About"
      End
      Begin VB.Menu mnuAboutLvColors 
         Caption         =   "About Listview Colors"
      End
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Visible         =   0   'False
      Begin VB.Menu mnuShowRawHeader 
         Caption         =   "Show Raw Header"
      End
      Begin VB.Menu mnuSHowRawObject 
         Caption         =   "Show Raw Object"
      End
      Begin VB.Menu mnuSpacer99 
         Caption         =   "-"
      End
      Begin VB.Menu mnuMarkStream 
         Caption         =   "Mark Stream"
      End
      Begin VB.Menu mnuReplaceStream 
         Caption         =   "Replace Stream"
      End
      Begin VB.Menu mnuHideSelected 
         Caption         =   "Hide Selected Streams"
      End
      Begin VB.Menu mnuHideUnselected 
         Caption         =   "Hide Unselected Streams"
      End
      Begin VB.Menu mnuSpacer2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSaveStream 
         Caption         =   "Save Decompressed Stream"
      End
      Begin VB.Menu mnuSaveAllStreams 
         Caption         =   "Save All Decompressed Streams"
      End
      Begin VB.Menu mnuSpacer1 
         Caption         =   "-"
      End
      Begin VB.Menu mnusSaveRawStream 
         Caption         =   "Save Raw Stream"
      End
      Begin VB.Menu mnuSaveAllRaw 
         Caption         =   "Save All Raw Streams"
      End
   End
   Begin VB.Menu mnuPopup2 
      Caption         =   "mnuPopup2"
      Visible         =   0   'False
      Begin VB.Menu mnuErrorSaveRaw 
         Caption         =   "Save Raw Stream"
      End
      Begin VB.Menu mnuSHowRawObject2 
         Caption         =   "Show Raw Object"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'see about for credits
'
'you can download some malicous pdfs from here:
'http://jsunpack.jeek.org/dec/go?report=03d8f2450f56a7bc8eb8b2b59ca53f7818126da6

'todo: possibly support filters /JPXDecode /JBIG2Decode (havent needed them yet)
'      investigate /ObjStm ?
'      support more pdf encoding mechanisms?
'         http://blog.didierstevens.com/2008/04/29/pdf-let-me-count-the-ways/
'      figure out a way to show which page is which? and implement the getnword on page script cmd?
'
'      modify sclog to hook getfilesize() to see if its scanning for open file handles
'      modify sclog to include -f option to have it open a file handle for the shellcode


'from wikipedia - http://en.wikipedia.org/wiki/Portable_Document_Format
's - DCTDecode a lossy filter based on the JPEG standard
's easy? - CCITTFaxDecode a lossless filter based on the CCITT fax compression standard
's big - JBIG2Decode a lossy or lossless filter based on the JBIG2 standard, introduced in PDF 1.4
's - JPXDecode a lossy or lossless filter based on the JPEG 2000 standard, introduced in PDF 1.5

'itext filters available: iTextSharp.text.pdf.codec
'JBIG2Decode = Org.BouncyCastle.Apache.Bzip2

'from PDFSHARP Notes
'     /// (Required except for image masks and images that use the JPXDecode filter)
'      /// The number of bits used to represent each color component. Only a single value may be specified;
'      /// the number of bits is the same for all color components. Valid values are 1, 2, 4, 8, and
'      /// (in PDF 1.5) 16. If ImageMask is true, this entry is optional, and if specified, its value
'      /// must be 1.
'      /// If the image stream uses a filter, the value of BitsPerComponent must be consistent with the
'      /// size of the data samples that the filter delivers. In particular, a CCITTFaxDecode or JBIG2Decode
'      /// filter always delivers 1-bit samples, a RunLengthDecode or DCTDecode filter delivers 8-bit samples,
'      /// and an LZWDecode or FlateDecode filter delivers samples of a specified size if a predictor function
'      /// is used.
'      /// If the image stream uses the JPXDecode filter, this entry is optional and ignored if present.
'      /// The bit depth is determined in the process of decoding the JPEG2000 image.


'changelog
' 9-2-10
'   fixed bug with replace in js ui
'   fixed bug in stream parser now handles nested tags <<start <<another>> end of org>>stream blahblah>>data
' 9-8-10 - added the js refactoring code (big pita!!)
'        - added find/find next to replace form
'        - possible new bugs related to changing this forms lv to multiselect
'        - added support for /Filter /ASCIIHexDecode (01 00 04 02 00 01 01) (kind of a hack)
'        - added toolbox.disasm() function utilizing olly.dll to quick check if byte buffers are shellcode
'        - search now searchs headers too not just stream content
'        - added error handling in all CScript functions
' 9-9-10 - added more listview colors and detections for things.
' 12-10-10 - added support for objend (instead of endobj)
'          - added support for Filter Fl abbreviation (instead of full FlateDecode)
'          - made obj,endobj,stream,endstream marker searchs case insensitive.
'          - force all flateDecode through zlib now, iText could crash sometimes on long automated runs
'          - added a little more err handling to cmddecode_click, scripts could not get their DecodeComplete Event sometimes.
' 12-12-10 - added support for plugins and added database plugin
' 12-13-10 - js_ui added this and app objects, so if(app), if(this.app), app.eval() etc all work now.
'          - js_ui added app.doc, app.collab and function collab.geticon , collab.collectemailinfo, app.eval
'          - js_ui, on js error, now it scrolls to and highlights the line with teh error on it
'          - js_ui, txtOut.Text not auto cleared on script start so you can use it to hold a variable if need be.
'          - js_ui  tb.lv now refers to js form listview so you can pull variables from it in your scripts.
' 12-27-10 - big change to how js_ui executes code, now all wrapped in myMain() function to support this. seems stable.
'          - header _CHR(0)_ replaced with empty now (seems only to cause bug) also replaced py in header with empty
'          - added progress bar and doevents me.refresh to keep ui from freezing on big files




Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpszOp As String, ByVal lpszFile As String, ByVal lpszParams As String, ByVal LpszDir As String, ByVal FsShowCmd As Long) As Long
Private Declare Function GetTickCount Lib "kernel32" () As Long

Dim WithEvents parser As CPdfParser
Attribute parser.VB_VarHelpID = -1
Dim plugins() As Object

Option Explicit

Public Enum statss
    stNotLoaded = 0
    stProcessing = 1
    stComplete = 2
End Enum

Public selli As ListItem
Public dlg As New clsCmnDlg
Public AutomatationRun As Boolean
Public Status As statss
Public LoadTime As Long

Dim exploits()

Dim streamCount As Long
Dim jsCount As Long
Dim EmbeddedFilesCount As Long
Dim pageCount As Long
Dim ttfCount As Long
Dim U3DCount As Long
Dim flashCount As Long
Dim unspFilterCount As Long
Dim ActionCount As Long
Dim surpressHideWarnings As Boolean

Sub LoadPlugins()
    
    Dim tmp() As String, i As Integer, progid As String
    Dim wsc() As String
    
    On Error Resume Next
    
    
    tmp() = fso.GetFolderFiles(App.path & "\plugins", "*dll")
    
   'for the demo, we will just let the user register this way if they want
    'If MsgBox("Did you register all of the dlls & the wsc file with regsvr32 already?", vbYesNo) = vbNo Then
    '     For i = 0 To UBound(tmp)
    '        Shell "regsvr32 """ & tmp(i) & """", vbNormalFocus
    '     Next
    'End If
    
    ReDim plugins(0)
    
    For i = 0 To UBound(tmp)
        ReDim Preserve plugins(i)
        progid = GetBaseName(tmp(i)) & ".plugin"
        Set plugins(i) = CreateObject(progid)
        If Err.Number = 429 Then 'ActiveX component can't create object
            If MsgBox(progid & " not registered yet, register now?", vbYesNo) = vbYes Then
                    Shell "regsvr32 """ & App.path & "\plugins\" & tmp(i) & """", vbNormalFocus
                    Sleep 2000
            End If
        End If
        Set plugins(i) = CreateObject(progid)
        plugins(i).sethost Me
    Next
    
Exit Sub
hell: MsgBox tmp(i) & " - " & Err.Description
      Resume Next
      
End Sub

Function RegisterPlugin(intMenu As Integer, strMenuName As String, intStartupArgument As Integer)
    'here right after sethost in loadplugins sub
    Dim i As Integer
    
    'If intMenu = 0 Then
        i = mnuPluginList.Count
        Load mnuPluginList(i)
        mnuPluginList(i).Caption = strMenuName
        mnuPluginList(i).Visible = True
        mnuPluginList(i).tag = UBound(plugins) & "." & intStartupArgument
    'Else
     'same thing to some other menu
     
End Function

Private Sub mnuAlwaysUseZlib_Click()
    mnuAlwaysUseZlib.Checked = Not mnuAlwaysUseZlib.Checked
End Sub

Private Sub mnub64decode_Click()
    Dim a As String
    Dim b As String
    a = dlg.OpenDialog(AllFiles)
    If Len(a) = 0 Then Exit Sub
    b = fso.GetParentFolder(a) & "\" & fso.GetBaseName(a) & ".unmime"
    b64.UnMimeFileToFile a, b
    If fso.FileExists(b) Then
        MsgBox "Complete 0x" & Hex(FileLen(b)) & " bytes decompressed saved as: " & vbCrLf & vbCrLf & b
    End If
End Sub

Private Sub mnuLoadJSFile_Click()
    On Error Resume Next
    Form2.Show
    Form2.mnuLoadFile_Click
End Sub

Private Sub mnuOpenLastAtStart_Click()
    mnuOpenLastAtStart.Checked = Not mnuOpenLastAtStart.Checked
End Sub

Private Sub mnuPluginList_Click(Index As Integer)
    
    If Index = 0 Then
        mnuLoadAutomationScript_Click
        Exit Sub
    End If
    
    Dim tmp() As String
    On Error GoTo hell
    tmp = Split(mnuPluginList(Index).tag, ".")
    plugins(CInt(tmp(0))).startup CInt(tmp(1))
    Exit Sub
hell: MsgBox Err.Description
End Sub


Function DoEventsFor(x) 'for scripts
    On Error Resume Next
    Dim i As Integer
    For i = 0 To x
        DoEvents
    Next
    If Err.Number <> 0 Then DoEvents
End Function

Function SleepFor(ms) 'for scripts
    On Error Resume Next
    Sleep CLng(ms)
End Function

'for scripts
Function Shutdown()
    On Error Resume Next
    Dim f
    For Each f In Forms
        Unload f
    Next
    End
End Function

'for scripts
Function AppPath()
    AppPath = App.path
End Function


Function GetExploits()
    GetExploits = exploits
End Function

Private Sub Form_Resize()
    On Error Resume Next
    txtUncompressed.Width = Me.Width - txtUncompressed.Left - 300
    TabStrip1.Width = txtUncompressed.Width + 300
    ts.Width = TabStrip1.Width
    he.Width = txtUncompressed.Width
    txtDetails.Width = he.Width
    lv2.Width = he.Width
    lvSearch.Width = he.Width
    lvDebug.Width = he.Width
    pb.Width = Me.Width - pb.Left - 100
End Sub

Private Sub lv_KeyDown(KeyCode As Integer, Shift As Integer)
    
    'MsgBox KeyCode & " " & Shift
    'Exit Sub
    
    Dim li As ListItem
    Dim i As Long
    
    If KeyCode = 65 And Shift = 2 Then 'ctrl-a - select all
        For Each li In lv.ListItems
            li.Selected = True
        Next
    End If
    
    If KeyCode = 73 And Shift = 2 Then 'ctrl-i - invert selection
        For Each li In lv.ListItems
            li.Selected = Not li.Selected
        Next
    End If
    
    If KeyCode = 68 And Shift = 2 Then 'ctrl-d - delete selected
        For i = lv.ListItems.Count To 1 Step -1
            If li.Selected = True Then
                lv.ListItems.Remove i
            End If
        Next
    End If
    
    If KeyCode = 78 And Shift = 2 Then 'ctrl-n -select none
        For Each li In lv.ListItems
            li.Selected = False
        Next
    End If
    
End Sub

Private Sub lv2_MouseUp(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = 2 Then PopupMenu mnuPopup2
End Sub

Private Sub mnuAboutLvColors_Click()
    
    Const msg = "Red: Headers with Javascript tag\n" & _
                "Blue: Object Streams\n" & _
                "Green: Headers with /Launch or /Action or /OpenAction or /AA\n" & _
                "Purple: Headers with /EmbeddedFiles\n" & _
                "Orange: Unsupported Filters\n" & _
                "Yellow: TTF Fonts"
                
    MsgBox Replace(msg, "\n", vbCrLf), vbInformation
    
End Sub

Private Sub mnuAutoEscapeHeaders_Click()
    mnuAutoEscapeHeaders.Checked = Not mnuAutoEscapeHeaders.Checked
End Sub

Private Sub mnuDisableDecomp_Click()
    mnuDisableDecomp.Checked = Not mnuDisableDecomp.Checked
End Sub

Private Sub mnuDisableiText_Click()
    mnuDisableiText.Checked = Not mnuDisableiText.Checked
End Sub

Private Sub mnuEnableShellButton_Click()
    mnuEnableShellButton.Checked = Not mnuEnableShellButton.Checked
    Command1.enabled = mnuEnableShellButton.Checked
End Sub

Private Sub mnuErrorSaveRaw_Click()
        
    If lv2.SelectedItem Is Nothing Then
        MsgBox "Select a stream first"
        Exit Sub
    End If
    
    Dim b() As Byte
    Dim pth As String
    Dim pf As String
    Dim f As Long
    Dim c As CPDFStream
    
    pf = GetParentFolder(txtPDFPath)
    GetActiveData lv2.SelectedItem, , c
    
    b() = StrConv(c.OriginalData, vbFromUnicode, LANG_US)
    pth = dlg.SaveDialog(AllFiles, pf, "Save Stream", , Me.hwnd, "error_stream_0x" & Hex(c.StartOffset) & ".txt")
    
    If Len(pth) = 0 Then Exit Sub
    
    f = FreeFile
    If Dir(pth) <> "" Then Kill pth
    Open pth For Binary As f
    Put f, , b()
    Close f

    MsgBox "Error Stream Saved to file: " & vbCrLf & vbCrLf & pth, vbInformation
    
    
End Sub

Private Sub mnuExtractHexDump_Click()
    
    On Error Resume Next
    Dim x, tmp, i, first, last
    
    If Len(he.SelText) > 0 Then
        x = he.SelText
    Else
        x = he.Text
    End If
    
    'handles extraction from these cases
    'a = "000000   3C 3C 0D 0A 09 2F 54 79 70 65 2F 41 63 74 69 6F    <<.../Type/Actio"
    'b = "3C 3C 0D 0A 09 2F 54 79 70 65 2F 41 63 74 69 6F    <<.../Type/Actio"
    'c = "3C 3C 0D 0A 09 2F 54 79 70 65 2F 41"
    'd = "000   3C 3C 0D 0A 09 2F 54 79 70 65 2F 41 63 74 69 6F    <<."
    
    tmp = Split(x, vbCrLf)
    For i = 0 To UBound(tmp)
        tmp(i) = Trim(tmp(i))
        first = InStr(tmp(i), "   ")
        last = InStr(tmp(i), "    ")
        
        If first > 0 And first <> last Then
            tmp(i) = Mid(tmp(i), first + 1)
        End If
        
        last = InStr(tmp(i), "    ")
        If last > 0 Then
            tmp(i) = Mid(tmp(i), 1, last)
        End If
    
        tmp(i) = Replace(tmp(i), " ", Empty)
        
    Next
    
    he.Text = Join(tmp, "")
        
End Sub

Private Sub mnuExtractHexFromParan_Click()

    txtUncompressed.Text = ExtractFromParanthesisPageEncapsulation(txtUncompressed.Text)
    
End Sub

Private Sub mnuFilters_Click()
    frmManualFilters.Show
End Sub

Private Sub mnuHexEditor_Click()
    Dim h As String
    
    h = GetMySetting("hexeditor")
    If Len(h) = 0 Or Not fso.FileExists(h) Then
        If MsgBox("You have not yet configured which hexeditor to use select it now?", vbYesNo) = vbNo Then Exit Sub
        h = dlg.OpenDialog(exeFiles, , "Select hexeditor to use", Me.hwnd)
        If fso.FileExists(h) Then
            SaveMySetting "hexeditor", h
        Else
            Exit Sub
        End If
    End If
    
    On Error Resume Next
    Shell h & " """ & txtPDFPath.Text & """", vbNormalFocus
    
    If Err.Number <> 0 Then MsgBox Err.Description
    
End Sub

Private Sub mnuHideUnselected_Click()
    
    On Error Resume Next
    Dim i As Long
    
    For i = lv.ListItems.Count To 1 Step -1
        If lv.ListItems(i).Selected = False Then
            lv.ListItems.Remove i
        End If
    Next
    
End Sub

Private Sub mnuLoadAutomationScript_Click()
    
    Dim f As String
    dlg.SetCustomFilter "VBScripts", "*.vbs"
    f = dlg.OpenDialog(CustomFilter, App.path & "\scripts\", "Load automation script", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    RunAutomationScript f
    
End Sub

Private Sub mnuManualEscape_Click(Index As Integer)
    
    Dim activeObject As Object
    Dim ss As Long
    Dim hasSelection As Boolean
    
    On Error Resume Next
    
    Select Case ts.SelectedItem.Index
        Case 1: Set activeObject = txtUncompressed
        Case 2: MsgBox "You can not escape stuff on hex editor pane", vbInformation: Exit Sub
        Case 3: Set activeObject = txtDetails
    End Select
    
    Dim t As String
    t = activeObject.SelText
    If Len(t) = 0 Then
        'MsgBox "No text selected", vbInformation
        'Exit Sub
        hasSelection = False
    End If
    
    t = activeObject.Text
    If Len(t) = 0 Then Exit Sub
    
    ss = activeObject.SelStart
    
    Select Case Index
        Case 0: t = HexStringUnescape(t, , True)
        Case 1: t = HexStringUnescape(t, True, True)
        Case 2: t = unescape(t)
        Case 3: t = js_unescape(t)
        Case 4: t = nl_unescape(t)
        Case 5: t = pound_unescape(t)
        Case 6: t = octal_unescape(t)
        Case 7: t = EscapeHeader(t): t = VisualFormatHeader(t)
        
        Case 8: t = Replace(t, vbCr, Empty)
                t = Replace(t, vbLf, Empty)
                t = Replace(t, " ", Empty)
                t = Replace(t, vbTab, Empty)
                
        Case 9: t = ExtractValidHex(t)
        Case 10: t = ExtractValidHex(t, True)
        Case 11: t = AddPercentToHexString(t, True)
            
    End Select
    
    If hasSelection Then
        activeObject.SelText = t
        activeObject.SelStart = ss
        activeObject.SelLength = Len(t)
    Else
        activeObject.Text = t
    End If
    
 
End Sub

Private Sub mnuMarkStream_Click()
    
    If selli Is Nothing Then
        MsgBox "No stream selected"
        Exit Sub
    End If
    
    selli.ForeColor = &H808080
    
End Sub

Private Sub mnuShowRawHeader_Click()
    
    If selli Is Nothing Then
        MsgBox "No stream selected"
        Exit Sub
    End If
    
    On Error Resume Next
    Dim s As CPDFStream
    Set s = selli.tag
    txtUncompressed.Text = s.Header
    ts.Tabs(1).Selected = True
    
End Sub

Private Sub mnuShowRawObject_Click()

    If selli Is Nothing Then
        MsgBox "No stream selected"
        Exit Sub
    End If
    
    On Error Resume Next
    Dim s As CPDFStream
    Set s = selli.tag
    txtUncompressed.Text = s.RawObject
    ts.Tabs(1).Selected = True
    
End Sub

Private Sub mnuSHowRawObject2_Click()
    mnuShowRawObject_Click
End Sub

Private Sub mnuVisualFormatHeaders_Click()
    mnuVisualFormatHeaders.Checked = Not mnuVisualFormatHeaders.Checked
End Sub

Private Sub mnuDecrypt_Click()
    Dim newPath As String
    
    If csharp.Decrypt(txtPDFPath, newPath, "Encryption was not autodetected but flag could be obsfuscated want to try to decrypt anyway?") Then
        If MsgBox("Open now?", vbYesNo) = vbYes Then
            txtPDFPath = newPath
            cmdDecode_Click
        End If
    Else
        MsgBox "Error: " & newPath, vbInformation
    End If
    
End Sub

Private Sub mnuFindReplace_Click()
    
    Dim txtObj As Object
    
    Select Case ts.SelectedItem.Index
        Case 1: Set txtObj = txtUncompressed
        Case 2: Set txtObj = he
        Case 3: Set txtObj = txtDetails
    End Select
    
    frmReplace.LaunchReplaceForm txtObj
    
End Sub

Private Sub mnuGotoObject_Click()
    Dim x
    Dim li As ListItem
    Dim s As CPDFStream
    
    x = InputBox("Enter Object number to jump to")
    If Len(x) = 0 Then Exit Sub
    
    For Each li In lv.ListItems
        Set s = li.tag
        If s.Index = x Then
            li.Selected = True
            li.EnsureVisible
            lv_ItemClick li
            Exit Sub
        End If
    Next
    
End Sub

Private Sub mnuHideDups_Click()
    
    Dim i As Long
    Dim s As CPDFStream
    Dim c As New Collection
    Dim h As Long
    
    'being called from code not from UI
    If Not surpressHideWarnings Then mnuHideDups.Checked = Not mnuHideDups.Checked
   
    If mnuHideDups.Checked = False Then
        cmdDecode_Click
    Else
        For i = lv.ListItems.Count To 1 Step -1
            Set s = lv.ListItems(i).tag
            If s.ContainsStream Then
                If keyExists(s.OriginalDataCRC, c) Then
                    lv.ListItems.Remove i
                    h = h + 1
                Else
                    AddKey s.OriginalDataCRC, c
                End If
            Else
                If keyExists(s.HeaderCRC, c) Then
                    lv.ListItems.Remove i
                    h = h + 1
                Else
                    AddKey s.HeaderCRC, c
                End If
            End If
        Next
        If Not surpressHideWarnings Then MsgBox "Hid " & h & " duplicates", vbInformation
    End If
    
    lv.ColumnHeaders(1).Text = lv.ListItems.Count & " Objects Shown"
    
End Sub

 
Private Sub mnuHideSelected_Click()
    
    On Error Resume Next
    Dim i As Long
    
    For i = lv.ListItems.Count To 1 Step -1
        If lv.ListItems(i).Selected = True Then
            lv.ListItems.Remove i
        End If
    Next

End Sub


Private Sub mnuHideHeaderStreams_Click()
    
    Dim i As Long
    Dim s As CPDFStream
    Dim h As Long
    
    'being called manually not from UI
    If Not surpressHideWarnings Then mnuHideHeaderStreams.Checked = Not mnuHideHeaderStreams.Checked
   
    If mnuHideHeaderStreams.Checked = False Then
        cmdDecode_Click
    Else
        For i = lv.ListItems.Count To 1 Step -1
            Set s = lv.ListItems(i).tag
            If s.StartOffset = 0 Then ' no stream
                lv.ListItems.Remove i
                h = h + 1
            End If
        Next
        If Not surpressHideWarnings Then MsgBox "Hid " & h & " header only fields"
    End If
    
    lv.ColumnHeaders(1).Text = lv.ListItems.Count & " Objects Shown"
                
    
End Sub



Public Sub mnuJavascriptUI_Click()
    Dim t As String
    Dim wasSelection As Boolean
    Dim li As ListItem
    Dim cs As CPDFStream
    
    On Error Resume Next
    
    Dim selCount As Long
    For Each li In lv.ListItems
        If li.Selected Then selCount = selCount + 1
    Next
    
    If selCount > 1 Then
        'multiple streams selected..put them all together for js ui
        For Each li In lv.ListItems
            If li.Selected Then
                t = t & GetActiveData(li, False) & vbCrLf
            End If
        Next
    Else
        If txtUncompressed.SelLength > 0 Then
            t = txtUncompressed.SelText
            wasSelection = True
        Else
            t = txtUncompressed.Text
        End If
    End If
    
    t = Form2.StandardizeLineBreaks(t)
    Form2.Show
    Form2.txtJS.Text = t
    
    'comment this out for codemax
    If wasSelection Then
        Form2.txtJS.SelStart = 0
        Form2.txtJS.SelLength = Len(t)
    End If
    
End Sub

Private Sub mnuSearchFilter_Click(Index As Integer)
    
    On Error Resume Next
    Dim li As ListItem
    Dim sli As ListItem
    Dim s As CPDFStream
    Dim match As Boolean
    
    Dim x
    lvSearch.ListItems.Clear
        
    If lv.ListItems.Count = 0 And lv2.ListItems.Count = 0 Then
        MsgBox "No streams loaded nothing to search!", vbCritical
        Exit Sub
    End If
    
    For Each li In lv.ListItems
        Set s = li.tag
        match = False
        If li.Selected Then li.Selected = False
        
        Select Case Index
            Case 0:   If AnyofTheseInstr(pound_unescape(s.Header), "/JS,/Javascript") Then match = True
            Case 1:   If s.ContentType = Flash Then match = True
            Case 2:   If s.ContentType = U3d Then match = True
            Case 3:   If s.ContentType = TTFFont Then match = True
            Case 4:   If li.ForeColor = vbGreen Then match = True
        End Select
                
        If match Then
            Set sli = lvSearch.ListItems.Add(, , li.Text)
            Set sli.tag = li.tag
            sli.Text = sli.Text & "   " & pound_unescape(s.Header)
            li.Selected = True
        End If
        
    Next
    
    For Each li In lv2.ListItems
        Set s = li.tag
        match = False
        
        Select Case Index
            Case 0:   If AnyofTheseInstr(pound_unescape(s.Header), "/JS,/Javascript") Then match = True
            Case 1:   If s.ContentType = Flash Then match = True
            Case 2:   If s.ContentType = U3d Then match = True
            Case 3:   If s.ContentType = TTFFont Then match = True
            Case 4:   If li.ForeColor = vbGreen Then match = True
        End Select
                
        If match Then
            Set sli = lvSearch.ListItems.Add(, , li.Text)
            Set sli.tag = li.tag
            sli.Text = sli.Text & "   " & pound_unescape(s.Header)
        End If
    Next
    
    'If lvSearch.ListItems.Count > 0 Then
        TabStrip1.Tabs(2).Selected = True
    'End If
    
    lvSearch.ColumnHeaders(1).Text = lvSearch.ListItems.Count & " Search Results"
    
End Sub

 

Private Sub mnuUnescape_Click()
    
    On Error Resume Next
    Dim t As Object
    
    Select Case ts.SelectedItem.Index
        Case 1: Set t = txtUncompressed
        Case 3: Set t = txtDetails
        Case 2: MsgBox "Not valid on hex dump pane": Exit Sub
    End Select
    
    If t.SelLength = 0 Then Exit Sub
    
    If InStr(t.SelText, "%u") > 0 Then
        t.SelText = unescape(t.SelText)
    End If
    
    If InStr(t.SelText, "#") > 0 Then
        t.SelText = pound_unescape(t.SelText)
    End If
    
    If InStr(t.SelText, "\x") > 0 Then
        t.SelText = js_unescape(t.SelText)
    End If
    
    If InStr(t.SelText, "\n") > 0 Then
        t.SelText = nl_unescape(t.SelText)
    End If
        
    sc.Reset
    sc.AddObject "t", t, True
    sc.AddCode "t.SelText = unescape(t.SelText)"
    
    
End Sub

Private Sub mnuUpdateCurrent_Click()

    
    If lv.SelectedItem Is Nothing Then
        MsgBox "Select a stream first"
        Exit Sub
    End If
    
    Dim new_data As String
    Dim new_file As String
    Dim pf As String
    Dim f As Long
    Dim f2 As Long
    Dim stream As CPDFStream
    Dim msg As String
    Dim b() As Byte
    Dim new_bytes() As Byte
    Dim bOut() As Byte
    Dim i As Long
    
    'what if its not a stream and its just a header?
    
    GetActiveData lv.SelectedItem, False, stream
    
    If stream Is Nothing Then
        MsgBox "Could not get active stream?", vbCritical
        Exit Sub
    End If
    
    If Not stream.ContainsStream Then
        MsgBox "Selected item does not contain a stream...I guess i should update the header but I havent been programmed to do that yet."
        Exit Sub
    End If
    
    
    new_data = txtUncompressed.Text
    new_bytes() = StrConv(new_data, vbFromUnicode, LANG_US)
    
    If Not Module4.CompressData(new_bytes(), bOut()) Then
        MsgBox "Compression Failed", vbInformation
        Exit Sub
    End If

    new_bytes() = bOut()
    new_file = txtPDFPath & "_upd.pdf"
    
    
    If stream.CompressedSize < UBound(new_bytes) Then
        msg = "Original Compressed Stream size was smaller than new data.." & vbCrLf & _
               "Org: " & Hex(stream.CompressedSize) & " New: " & Hex(UBound(new_bytes) + 1) & vbCrLf & vbCrLf & _
               "Are you sure you want to continue?"
    
        If MsgBox(msg, vbYesNo) = vbNo Then Exit Sub
    ElseIf stream.CompressedSize > UBound(new_bytes) Then
        'pad the extra space with new lines (ignored char)
        ReDim Preserve new_bytes(stream.CompressedSize - 1)
        For i = UBound(bOut) To UBound(new_bytes)
            new_bytes(i) = &HA
        Next
    
    End If
    



    f = FreeFile
    Open txtPDFPath For Binary As f
    
    f2 = FreeFile
    Open new_file For Binary As f2
    
    ReDim b(stream.StartOffset - 1)
    Get f, , b() 'load the file up to the original stream
    Put f2, , b() 'save it to the new file
    
    Put f2, , new_bytes() 'save our new stream to new file
        
    ReDim b(LOF(f) - stream.EndOffset)
    Get f, stream.EndOffset + 1, b() 'load teh rest of the original file
    Put f2, , b() 'save rest of file to new file
    
    Close f
    Close f2
    
    txtPDFPath = new_file
    cmdDecode_Click
  
End Sub

Private Sub muLoadShellcode_Click()
    On Error Resume Next
    Form2.Show
    Form2.mnuLoadShellcode_Click
End Sub

Private Sub parser_Complete()
    On Error Resume Next
    pb.Value = 0
End Sub

Private Sub IncProgressBar()
    On Error Resume Next
    pb.Value = pb.Value + 1
End Sub

Private Sub parser_NewStream(stream As CPDFStream)
        
         
        DoEvents
        Me.Refresh
        DoEvents
        'should i add a progress bar?
        
        IncProgressBar
        
        Dim li As ListItem
        Dim h As String
        
        If Len(stream.Message) > 0 Then
            'add it to the error list
            Set li = lv2.ListItems.Add(, , "stream # " & stream.Index & " org sz = (0x" & Hex(Len(stream.RawObject)) & ")")
        ElseIf stream.StartOffset > 0 Then
            Set li = lv.ListItems.Add(, , stream.Index & " 0x" & Hex(stream.StartOffset) & "-0x" & Hex(stream.EndOffset))
            li.ForeColor = vbBlue
        Else
            If mnuHideHeaderStreams.Checked = False Then
                Set li = lv.ListItems.Add(, , stream.Index & " HLen: 0x" & Hex(Len(stream.Header)))
            End If
        End If
        
        If Not li Is Nothing Then
            Set li.tag = stream
            h = stream.escapedHeader
            
            If AnyofTheseInstr(h, "/Page ,/Page/") Then
                pageCount = pageCount + 1
            End If
            
            If stream.ContentType = Flash Then flashCount = flashCount + 1
            If stream.ContentType = TTFFont Then ttfCount = ttfCount + 1
            If stream.ContentType = U3d Then U3DCount = U3DCount + 1
            
            'add some color highlighting in order of importance
            
            If stream.UsesUnsupportedFilter Or stream.StreamDecompressor.DecompressionError = True Then
                li.ForeColor = &H80FF&     'orange
                unspFilterCount = unspFilterCount + 1
                If stream.UsesUnsupportedFilter Then
                    li.ToolTipText = "Unsupported Filter " & stream.StreamDecompressor.GetActiveFiltersAsString()
                Else
                    li.ToolTipText = "Decompression Error: " & stream.StreamDecompressor.GetActiveFiltersAsString()
                End If
            ElseIf AnyofTheseInstr(h, "/JS,/Javascript") Then
                li.ForeColor = vbRed ' &H80&       'red
                jsCount = jsCount + 1
                li.ToolTipText = "Javascript Block"
                
            ElseIf stream.StartOffset > 0 Then
                If stream.ContentType = TTFFont Then
                    li.ForeColor = &HFFFF&     'yellow
                    li.ToolTipText = "TTF Font"
                Else
                    li.ForeColor = vbBlue ' &H400000    'blue
                    li.ToolTipText = "Data Stream"
                End If
                streamCount = streamCount + 1
                
            ElseIf AnyofTheseInstr(h, "/Action,/Launch,/AA,/OpenAction") Then
                li.ForeColor = vbGreen  '<-- this color is hardcoded in mnuSearchFilters too!
                ActionCount = ActionCount + 1
                li.ToolTipText = "Launch Action"
                
            ElseIf AnyofTheseInstr(h, "/EmbeddedFiles") Then
                li.ForeColor = &H800080    'purple
                EmbeddedFilesCount = EmbeddedFilesCount + 1
                li.ToolTipText = "Embedded File"
            End If
            
        End If

End Sub


Private Sub cmdBrowse_Click()
    Dim p As String
    AutomatationRun = False
    p = dlg.OpenDialog(AllFiles, RecommendedPath(), "Load PDF File", Me.hwnd)
    If Len(p) > 0 Then
        txtPDFPath = p
        cmdDecode_Click
    End If
End Sub

Private Function RecommendedPath() As String
    On Error Resume Next
    RecommendedPath = fso.GetParentFolder(Form1.txtPDFPath)
End Function

Private Sub Command1_Click()
        On Error Resume Next
        Call ShellExecute(Me.hwnd, "Open", txtPDFPath, "", "C:\", 1)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Dim f As Form
    On Error Resume Next
    
    SaveSetting App.EXEName, "Settings", "LastFile", txtPDFPath
    
    SaveMySetting "EscapeHeaders", IIf(mnuAutoEscapeHeaders.Checked, 1, 0)
    SaveMySetting "FormatHeaders", IIf(mnuVisualFormatHeaders.Checked, 1, 0)
    SaveMySetting "HideDups", IIf(mnuHideDups.Checked, 1, 0)
    SaveMySetting "HideHeaderOnlyStreams", IIf(mnuHideHeaderStreams.Checked, 1, 0)
    SaveMySetting "ShellButtonEnabled", IIf(mnuEnableShellButton.Checked, 1, 0)
    SaveMySetting "DisableDecomp", IIf(mnuDisableDecomp.Checked, 1, 0)
    SaveMySetting "DisableiText", IIf(mnuDisableiText.Checked, 1, 0)
    SaveMySetting "AlwaysUseZlib", IIf(mnuAlwaysUseZlib.Checked, 1, 0)
    SaveMySetting "OpenLastAtStart", IIf(mnuOpenLastAtStart.Checked, 1, 0)
       
    FormPos Me, True, True
    
    For Each f In Forms
         Unload f
    Next
     
End Sub

Private Sub lv_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = 2 And Not selli Is Nothing Then PopupMenu mnuPopup
End Sub


Private Sub mnuCompress_Click()
    Dim base_file As String, out_file As String
    Dim tmp As String
    Dim b() As Byte
    Dim bOut() As Byte
    
    base_file = dlg.OpenDialog(AllFiles, , "Select File to compress", Me.hwnd)
    If Len(base_file) = 0 Then Exit Sub
    
    out_file = base_file & ".compressed"
    
    tmp = fso.ReadFile(base_file)
    b() = StrConv(tmp, vbFromUnicode, LANG_US)
    
    If Not Module4.CompressData(b(), bOut()) Then
        MsgBox "Compression Failed", vbInformation
        Exit Sub
    End If
    
    Dim f As Long
    f = FreeFile
    Open out_file For Binary As f
    Put f, , bOut()
    Close f
    
    MsgBox "Compressed Data saved as " & vbCrLf & vbCrLf & out_file
    

End Sub

Private Sub mnuDecompress_Click()
    Dim base_file As String, out_file As String
    Dim tmp As String
    Dim b() As Byte
    Dim bOut() As Byte
    
    base_file = dlg.OpenDialog(AllFiles, , "Select File to compress", Me.hwnd)
    If Len(base_file) = 0 Then Exit Sub
    
    out_file = base_file & ".decompressed"
    
    tmp = fso.ReadFile(base_file)
    b() = StrConv(tmp, vbFromUnicode, LANG_US)
    
    If Not Module4.UncompressData(b(), bOut()) Then
        MsgBox "Decompression Failed", vbInformation
        Exit Sub
    End If
    
    Dim f As Long
    f = FreeFile
    Open out_file For Binary As f
    Put f, , bOut()
    Close f
    
    MsgBox "Deompressed Data saved as " & vbCrLf & vbCrLf & out_file
    

End Sub


Public Sub cmdDecode_Click()
    
    On Error Resume Next
    Dim li As ListItem
    Dim startTime As Long
    Dim endTime As Long
    
     
    Status = stProcessing
    startTime = GetTickCount()
    
    streamCount = 0
    jsCount = 0
    EmbeddedFilesCount = 0
    pageCount = 0
    ttfCount = 0
    U3DCount = 0
    flashCount = 0
    unspFilterCount = 0
    ActionCount = 0
    
    Set parser = Nothing
    Set parser = New CPdfParser
    
    txtDetails.Text = Empty
    txtUncompressed.Text = Empty
    he.Text = Empty
    lv.ListItems.Clear
    lv2.ListItems.Clear
    lvSearch.ListItems.Clear
    lvSearch.ColumnHeaders(1).Text = "Search Results"
    lvDebug.ListItems.Clear
    
    If Not FileExists(txtPDFPath) Then GoTo end_of_func
    
    parser.ParseFile txtPDFPath
    
    If lv.ListItems.Count = 0 And lv2.ListItems.Count = 0 Then
       'MsgBox "No stream markers found in this file", vbInformation
       GoTo end_of_func
    End If
    
    lv.ColumnHeaders(1).Text = lv.ListItems.Count & " Objects"
    lv2.ColumnHeaders(1).Text = lv2.ListItems.Count & " Decompression Errors"
    
    With StatusBar
        .Panels(1).Text = "Streams:" & streamCount
        .Panels(2).Text = "JS: " & jsCount
        .Panels(3).Text = "Embeds: " & EmbeddedFilesCount
        .Panels(4).Text = "Pages: " & pageCount
        .Panels(5).Text = "TTF: " & ttfCount
        .Panels(6).Text = "U3D: " & U3DCount
        .Panels(7).Text = "flash: " & flashCount
        .Panels(8).Text = "UnkFlt: " & unspFilterCount
        .Panels(9).Text = "Action: " & ActionCount
    End With
    
    surpressHideWarnings = True
    If mnuHideDups.Checked = True Then mnuHideDups_Click
    If mnuHideHeaderStreams.Checked Then mnuHideHeaderStreams_Click
    surpressHideWarnings = False
    
    
end_of_func:

    On Error Resume Next
    Dim x As Procedure
    If AutomatationRun Then
    
        Me.Refresh
        DoEvents
        DoEvents
        
        For Each x In scAuto.Procedures
            If LCase(x.Name) = "decode_complete" Then
                scAuto.eval "Decode_Complete()"
                Exit For
            End If
        Next
        
        
    End If
    
    Dim fsize As Long
    
    Status = stComplete
    endTime = GetTickCount()
    LoadTime = endTime - startTime
    fsize = FileLen(txtPDFPath)
    
    Me.Caption = "PDFStreamDumper  - http://sandsprite.com     FileSize: " & fsize & "    LoadTime: " & LoadTime
    
    Dim oBrowser As Object
    Set oBrowser = GetObject("", "obj_Browser.plugin") 'not much of a plugin is it! more of a lib at this point :P
    oBrowser.initasLib Me
    
End Sub

Function AryIsEmpty(ary) As Boolean
    On Error GoTo hell
    Dim x
    x = UBound(ary)
    AryIsEmpty = False
    Exit Function
hell: AryIsEmpty = True
End Function




Private Sub mnuExploitScan_Click()
    
    Dim li As ListItem
    Dim c As CPDFStream
    Dim Data As String
    Dim p() As String
    Dim report() As String
    Dim i As Long
    
    On Error Resume Next
    
    For Each li In lv.ListItems
        Data = GetActiveData(li, False, c)
        For i = 0 To UBound(exploits)
            p() = Split(exploits(i), "=")
            If ContainsExploit(Data, p(1)) Then
                push report, "Exploit " & p(0) & " - " & p(1) & " - found in stream: " & c.Index
            End If
        Next
    Next
    
    For Each li In lv2.ListItems
        Data = GetActiveData(li, False, c)
        For i = 0 To UBound(exploits)
            p() = Split(exploits(i), "=")
            If ContainsExploit(Data, p(1)) Then
                push report, "Exploit " & p(0) & " found in stream " & c.Index
            End If
        Next
    Next
    
    'also scan main textbox
    For i = 0 To UBound(exploits)
            p() = Split(exploits(i), "=")
            If ContainsExploit(txtUncompressed, p(1)) Then
                push report, "Exploit " & p(0) & " - " & p(1) & " - found in main textbox"
            End If
    Next
        
    push report, vbCrLf & "Note other exploits may be hidden with javascript obsfuscation"
    push report, "It is also possible these functions are being used in a non-exploit way."

    
    Dim tmp As String
    tmp = fso.GetFreeFileName(Environ("temp"))
    fso.writeFile tmp, Join(report, vbCrLf)
    Shell "notepad.exe """ & tmp & """", vbNormalFocus
    
    
    
        
    
End Sub

Private Sub mnuFormatJS_Click()
    
    On Error GoTo hell
    Dim js As String
    
    js = fso.ReadFile(App.path & "\beautify.js")
    
    sc.Reset
    sc.AddCode js
    sc.AddObject "txtUncompressed", txtUncompressed, True
    sc.AddCode "txtUncompressed.text = js_beautify(txtUncompressed.text, {indent_size: 1, indent_char: '\t'}).split('\n').join('\r\n');"
    
    
    'DevControl.Text = Replace(DevControl.Text, vbLf, vbCrLf)

Exit Sub
hell:

MsgBox Err.Description

End Sub

'Function RunLZWDecompress() As String
'
'    On Error GoTo hell
'    Dim js As String
'
'    js = fso.ReadFile(App.path & "\lzwjs.js")
'
'    sc.Reset
'    sc.AddCode js
'    sc.AddObject "txtUncompressed", txtUncompressed, True
'
'    txtUncompressed.Text = "THIS IS MY TEST MESSAGE"
'    sc.AddCode "txtUncompressed.text = lzwCompress(txtUncompressed.text);"
'
'    Dim tmp, x, y
'
'
'    MsgBox "Compressed"
'    sc.AddCode "txtUncompressed.text = lzwDecompress(txtUncompressed.text);"
'
'Exit Function
'hell:
'    MsgBox "Error in RunLZWDecompress: " & Err.Description
'End Function

Private Sub mnuLoadFile_Click()
    cmdBrowse_Click
End Sub

Private Sub mnuReplaceStream_Click()
    
    'here is the money shot
    
    If lv.SelectedItem Is Nothing Then
        MsgBox "Select a stream first"
        Exit Sub
    End If
    
    Dim new_data As String
    Dim new_file As String
    Dim pf As String
    Dim f As Long
    Dim f2 As Long
    Dim stream As CPDFStream
    Dim msg As String
    Dim b() As Byte
    Dim new_bytes() As Byte
    
    GetActiveData lv.SelectedItem, False, stream
    
    If stream Is Nothing Then
        MsgBox "Could not get active stream?", vbCritical
        Exit Sub
    End If
    
    If stream.ContainsStream = False Then
        MsgBox "Selected item does not contain a stream...I guess i should update the header but I havent been programmed to do that yet."
        Exit Sub
    End If
    
    
    pf = GetParentFolder(txtPDFPath)
    new_file = dlg.OpenDialog(AllFiles, pf, "Open Compressed Replacement Stream", Me.hwnd)
    If Len(new_file) = 0 Then Exit Sub
    
    new_data = fso.ReadFile(new_file)
    new_bytes() = StrConv(new_data, vbFromUnicode, LANG_US)
    
    msg = "Original Compressed Stream size: " & Hex(stream.CompressedSize) & vbCrLf & _
          "New stream file size: " & Hex(Len(new_data)) & vbCrLf & vbCrLf & _
          "Are you sure you want to continue?"
    
    If MsgBox(msg, vbYesNo) = vbNo Then Exit Sub
    
    new_file = dlg.SaveDialog(AllFiles, pf, "Save New PDF As", , Me.hwnd)
    If Len(new_file) = 0 Then Exit Sub
    
    f = FreeFile
    Open txtPDFPath For Binary As f
    
    f2 = FreeFile
    Open new_file For Binary As f2
    
    ReDim b(stream.StartOffset - 1)
    Get f, , b() 'load the file up to the original stream
    Put f2, , b() 'save it to the new file
    
    Put f2, , new_bytes() 'save our new stream to new file
    
    'ReDim b(stream.CompressedSize)
    'Get f, , b() 'advance file pointer size of orginal compressed data
    
    ReDim b(LOF(f) - stream.EndOffset)
    Get f, stream.EndOffset + 1, b() 'load teh rest of the original file
    Put f2, , b() 'save rest of file to new file
    
    Close f
    Close f2
    
    MsgBox "You may have to edit the stream sizes in the obj header I didnt do this. Use the data from the details pane to determine offsets and sizes." & vbCrLf & vbCrLf & _
            "This streams header is: " & vbCrLf & vbCrLf & stream.Header, vbInformation
            
    If MsgBox("New PDF File Generated, would you like to load it now?", vbYesNo) = vbYes Then
        txtPDFPath = new_file
        cmdDecode_Click
    End If
    
End Sub

Private Sub mnuSaveAllRaw_Click()
    
    Dim b() As Byte
    Dim li As ListItem
    Dim pf As String
    Dim f As Long
    Dim pth As String
    Dim c As CPDFStream
    
    pf = GetParentFolder(txtPDFPath)
    
    For Each li In lv.ListItems
        GetActiveData li, False, c
        b() = StrConv(c.OriginalData, vbFromUnicode, LANG_US)
        f = FreeFile
        pth = pf & "raw_stream_" & safe(li.Text)
        If Dir(pth) <> "" Then Kill pth
        Open pth For Binary As f
        Put f, , b()
        Close f
    Next
    
    For Each li In lv2.ListItems
        GetActiveData li, False, c
        b() = StrConv(c.OriginalData, vbFromUnicode, LANG_US)
        f = FreeFile
        pth = pf & "raw_error_" & safe(li.Text)
        If Dir(pth) <> "" Then Kill pth
        Open pth For Binary As f
        Put f, , b()
        Close f
    Next
    
    MsgBox lv.ListItems.Count & " Streams dumped to " & pf, vbInformation
    
End Sub

Private Sub mnuSaveStream_Click()

    If lv.SelectedItem Is Nothing Then
        MsgBox "Select a stream first"
        Exit Sub
    End If
    
    Dim b() As Byte
    Dim pth As String
    Dim pf As String
    Dim f As Long
    Dim c As CPDFStream
    
    pf = GetParentFolder(txtPDFPath)
        
    b() = StrConv(GetActiveData(lv.SelectedItem, , c), vbFromUnicode, LANG_US)
    
    pth = dlg.SaveDialog(AllFiles, pf, "Save Stream", , Me.hwnd, "decomp_stream_0x" & Hex(c.StartOffset) & ".txt")
    
    If Len(pth) = 0 Then Exit Sub
    
    f = FreeFile
    If Dir(pth) <> "" Then Kill pth
    Open pth For Binary As f
    Put f, , b()
    Close f

    MsgBox "Stream Saved to file: " & vbCrLf & vbCrLf & pth, vbInformation

    
End Sub

Private Sub mnusSaveRawStream_Click()

    If lv.SelectedItem Is Nothing Then
        MsgBox "Select a stream first"
        Exit Sub
    End If
    
    Dim b() As Byte
    Dim pth As String
    Dim pf As String
    Dim f As Long
    Dim c As CPDFStream
    
    pf = GetParentFolder(txtPDFPath)
    GetActiveData lv.SelectedItem, False, c
    
    pth = dlg.SaveDialog(AllFiles, pf, "Save Raw Stream", , Me.hwnd, "raw_stream_0x" & Hex(c.StartOffset) & ".txt")
    If Len(pth) = 0 Then Exit Sub
  
    b() = StrConv(c.OriginalData, vbFromUnicode, LANG_US)
    
    f = FreeFile
    If Dir(pth) <> "" Then Kill pth
    Open pth For Binary As f
    Put f, , b()
    Close f

    MsgBox "Raw Stream Saved to file: " & vbCrLf & vbCrLf & pth, vbInformation

End Sub


Private Sub mnuSaveAllStreams_Click()
    
    Dim b() As Byte
    Dim li As ListItem
    Dim pf As String
    Dim f As Long
    Dim pth As String
    
    pf = GetParentFolder(txtPDFPath)
    
    For Each li In lv.ListItems
        b() = StrConv(GetActiveData(li), vbFromUnicode, LANG_US)
        f = FreeFile
        pth = pf & "stream_" & safe(li.Text)
        If Dir(pth) <> "" Then Kill pth
        Open pth For Binary As f
        Put f, , b()
        Close f
    Next
    
    For Each li In lv2.ListItems
        b() = StrConv(GetActiveData(li), vbFromUnicode, LANG_US)
        f = FreeFile
        pth = pf & "error_" & safe(li.Text)
        If Dir(pth) <> "" Then Kill pth
        Open pth For Binary As f
        Put f, , b()
        Close f
    Next
    
    MsgBox lv.ListItems.Count & " Streams dumped to " & pf, vbInformation
    
End Sub

Function GetActiveData(Item As ListItem, Optional load_ui As Boolean = False, Optional ret_Stream As CPDFStream) As String
    On Error Resume Next
    Dim s As CPDFStream
    Dim d As String
    
    Set s = Item.tag
    Set ret_Stream = s
    
    'use err message to determine if decompress was successful or not (or len s.decomdata huh?)
    
    If Len(s.Message) > 0 Then
        d = s.OriginalData
    ElseIf s.ContainsStream Then
        If s.isCompressed Then
            d = s.DecompressedData
        Else
            d = s.OriginalData
        End If
    Else
        d = s.GetHeaderWithViewOptions()
    End If
        
    If load_ui Then
         txtUncompressed.Text = Replace(d, Chr(0), ".")
         he.Text = HexDump(d)
         txtDetails.Text = s.GetDetailsReport()
         
         
         
         'If InStr(d, Chr(0)) > 0 Then
         '   Set ts.SelectedItem = ts.Tabs(2)
         'Else
         '   Set ts.SelectedItem = ts.Tabs(1)
         'End If
         'ts_Click
         
    End If
        
    GetActiveData = d
    
End Function

Function safe(ByVal x) As String
    x = Replace(x, "#", Empty)
    x = Replace(x, " ", "_")
    x = Replace(x, "(", Empty)
    x = Replace(x, ")", Empty)
    safe = x
End Function

Private Sub mnuAbout_Click()
    
    Const msg = "\n\nStream Parser and Decompression code by VBboy136 - 12/9/2008\n" & _
                "http://www.codeproject.com/KB/DLL/PDF2TXTVB.aspx\n\n" & _
                 "JS Beautify by Einar Lielmanis, <einar@jsbeautifier.org>\n" & _
                "conversion to Javascript code by Vital, <vital76@gmail.com>\n" & _
                "http://jsbeautifier.org/\n\n" & _
                "Scintilla by Neil Hodgson [neilh@scintilla.org]\n" & _
                "http://www.scintilla.org/\n\n" & _
                "ScintillaVB by Stu Collier\n" & _
                "http://www.ceditmx.com/software/scintilla-vb/\n\n" & _
                "iTextSharp.dll and iText_Filters.dll code by Bruno Lowagie and Paulo Soares\n" & _
                "http://itextpdf.com/terms-of-use/index.php\n\n" & _
                "sclog is a tool i wrote back at iDefense source here:\n" & _
                "http://labs.idefense.com/software/download/?downloadID=8\n\n" & _
                "libemu and sctest written by Paul Baecher and Markus Koetter in 2007.\n" & _
                "http://libemu.carnivore.it/about.html\n\n" & _
                "zlib.dll by Jean-loup Gailly and Mark Adler\n" & _
                "http://www.zlib.net/\n\n" & _
                "Crc32 code by Steve McMahon\n" & _
                "http://www.vbaccelerator.com/home/vb/code/libraries/CRC32/article.asp\n\n" & _
                "olly.dll GPL code Copyright (C) 2001 Oleh Yuschuk\n" & _
                "http://home.t-online.de/home/Ollydbg/\n\n" & _
                "Interface by dzzie@yahoo.com\nhttp://sandsprite.com\n\n" & _
                "Other thanks to Didier Stevens for the info on his blog on tags and encodings.\n" & _
                "http://blog.didierstevens.com/2008/04/29/pdf-let-me-count-the-ways/"

    Dim Header
    Header = "PDFStreamDumper " & App.Major & "." & App.Minor & "." & App.Revision
    MsgBox Header & Replace(msg, "\n", vbCrLf), vbInformation

End Sub




Private Sub mnuSearch_Click()
    On Error Resume Next
    Dim li As ListItem
    Dim sli As ListItem
    Dim s As CPDFStream
    
    Dim x
    lvSearch.ListItems.Clear
        
    If lv.ListItems.Count = 0 And lv2.ListItems.Count = 0 Then
        MsgBox "No streams loaded nothing to search!", vbCritical
        Exit Sub
    End If
    
    x = InputBox("Enter text to search for")
    If Len(x) = 0 Then Exit Sub
    For Each li In lv.ListItems
        Set s = li.tag
        If InStr(1, GetActiveData(li), x, vbTextCompare) > 0 Then
            Set sli = lvSearch.ListItems.Add(, , li.Text)
            Set sli.tag = li.tag
        End If
        If InStr(1, s.escapedHeader, x, vbTextCompare) > 0 Then
            Set sli = lvSearch.ListItems.Add(, , li.Text)
            Set sli.tag = li.tag
        End If
    Next
    
    For Each li In lv2.ListItems
        If InStr(1, GetActiveData(li), x, vbTextCompare) > 0 Then
            Set sli = lvSearch.ListItems.Add(, , li.Text)
            Set sli.tag = li.tag
        End If
    Next
    
    If lvSearch.ListItems.Count > 0 Then
        TabStrip1.Tabs(2).Selected = True
    Else
        MsgBox "0 Search Results", vbInformation
    End If
    
    lvSearch.ColumnHeaders(1).Text = lvSearch.ListItems.Count & " Search Results"
    

End Sub

Private Sub Form_Load()
    On Error Resume Next
    Dim f As String
    Dim x As String
    
    Set parser = New CPdfParser
    
    exploits = Array("CVE-2007-5020=mailto:%/..", _
                     "CVE-2007-5659=collectEmailInfo", _
                     "CVE-2008-2992=util.printf", _
                     "CVE-2009-0927=getIcon", _
                     "CVE-2009-1492=getAnnots", _
                     "CVE-2009-1493=customDictionaryOpen", _
                     "CVE-2009-4324=media.newPlayer", _
                     "Contains U3D file - possible CVE-2009-4324=^U3D", _
                     "Contains flash file - possible CVE-2010-1297(b4 10.1.53.64-newfunction), CVE-2010-2884(10.1.82.76), CVE-2010-3654(10.1.85.3)=^CWS", _
                     "Contains embedded image/tif, - possible CVE-2010-0188=image/tif", _
                     "Header contains a Launch Action - possible CVE-2010-1240=*/Launch*/Action*", _
                     "Header contains a Launch Action - possible CVE-2010-1240=*/Action*/Launch*", _
                     "CVE-2010-4091=printSeps" _
                     )

    
    mnuAutoEscapeHeaders.Checked = IIf(GetMySetting("EscapeHeaders", 1) = 1, True, False)
    mnuVisualFormatHeaders.Checked = IIf(GetMySetting("FormatHeaders", 1) = 1, True, False)
    mnuHideDups.Checked = IIf(GetMySetting("HideDups", 0) = 1, True, False)
    mnuHideHeaderStreams.Checked = IIf(GetMySetting("HideHeaderOnlyStreams", 0) = 1, True, False)
    mnuEnableShellButton.Checked = IIf(GetMySetting("ShellButtonEnabled", 0) = 1, True, False)
    mnuDisableDecomp.Checked = IIf(GetMySetting("DisableDecomp", 0) = 1, True, False)
    mnuDisableiText.Checked = IIf(GetMySetting("DisableiText", 0) = 1, True, False)
    mnuAlwaysUseZlib.Checked = IIf(GetMySetting("AlwaysUseZlib", 0) = 1, True, False)
    mnuOpenLastAtStart.Checked = IIf(GetMySetting("OpenLastAtStart", 0) = 1, True, False)
    
    lv2.ColumnHeaders(1).Width = lv2.Width - 100
    lv.ColumnHeaders(1).Width = lv.Width - 100
    lvSearch.ColumnHeaders(1).Width = lvSearch.Width - 100
    lvDebug.ColumnHeaders(1).Width = lvDebug.Width - 100
    lvSearch.Move lv2.Left, lv2.Top
    lvDebug.Move lv2.Left, lv2.Top
    txtUncompressed.Move he.Left, he.Top, he.Width, he.Height
    txtDetails.Move he.Left, he.Top, he.Width, he.Height
    FormPos Me, True
    
    LoadPlugins
    Me.Visible = True
    DoEvents
    Me.Refresh
    
    If Len(command) > 0 Then
        If InStr(1, command, ".js", vbTextCompare) > 0 Or InStr(1, command, ".vbs", vbTextCompare) > 0 Then
            RunAutomationScript command
        ElseIf InStr(1, command, ".sc", vbTextCompare) > 0 Then
            'load a shellcode file for analysis
            f = Replace(command, """", Empty)
            If fso.FileExists(f) Then
                x = fso.ReadFile(f)
                x = HexDump(x, 1)
                x = AddPercentToHexString(x)
                Form2.Show
                Form2.txtJS.Text = x
                Form2.txtJS.SelectAll
            End If
        Else
            'assume its a pdf file for analysis.
            txtPDFPath = Replace(command, """", Empty)
            cmdDecode_Click
        End If
    Else
        If mnuOpenLastAtStart.Checked Then
            txtPDFPath = GetSetting(App.EXEName, "Settings", "LastFile")
            If fso.FileExists(txtPDFPath) Then cmdDecode_Click
        End If
    End If
    
End Sub

Private Function RunAutomationScript(pth)
    On Error Resume Next
    Dim x As Procedure
    Dim main_found As Boolean
    Dim Decode_Complete_found As Boolean
    
    AutomatationRun = True
    
    scAuto.Reset
    
    'default = vbscript but we also support jscript
    If InStr(1, pth, ".js", vbTextCompare) > 0 Then scAuto.Language = "jscript"
        
     Me.Show
     Me.Visible = True
     Me.Refresh
    
    With scAuto
        .AddObject "Form1", Me, True
        .AddObject "dlg", dlg, True
        .AddCode fso.ReadFile(pth)
        
        For Each x In .Procedures
            If LCase(x.Name) = "main" Then
                main_found = True
            ElseIf LCase(x.Name) = "decode_complete" Then
                Decode_Complete_found = True
            End If
        Next
        
        'If Not Decode_Complete_found Then
        '    MsgBox "This script is not implemented properly, no Decode_Complete proceedure found", vbInformation
        'End If
        
        'this one is optional i guess
        If main_found Then scAuto.eval "main()"
        
    End With
    
End Function

Public Sub catch_up()
    DoEvents
    Me.Refresh
    DoEvents
End Sub

Private Sub lv_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Call GetActiveData(Item, True)
    Set selli = Item
End Sub

Private Sub lv2_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Call GetActiveData(Item, True)
    Set selli = Item
End Sub

Private Sub lvsearch_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Dim d As String
    Call GetActiveData(Item, True)
    Set selli = Item
End Sub





Private Sub mnuViewExploitDetections_Click()
    
    Dim tmp As String
    Dim report As String
    
    report = Join(exploits, vbCrLf)
    report = Replace(report, "=", vbTab)
    
    tmp = fso.GetFreeFileName(Environ("temp"))
    fso.writeFile tmp, report
    Shell "notepad.exe """ & tmp & """", vbNormalFocus
 
 
End Sub

Private Sub parser_SetObjectCount(cnt As Long)
    On Error Resume Next
    pb.Max = cnt
    pb.Value = 0
End Sub


Private Sub sc_Error()
    MsgBox "Script Error: " & sc.error.Description & "  " & sc.error.Text
End Sub

Private Sub scAuto_Error()
     MsgBox "Automation Script Error: " & scAuto.error.Description & vbCrLf & _
            "Line: " & scAuto.error.Line & vbCrLf & _
            "Source: " & scAuto.error.Source & vbCrLf & _
            "Text: " & scAuto.error.Text
End Sub

Private Sub TabStrip1_Click()
    If TabStrip1.SelectedItem.Index = 1 Then
        lv2.Visible = True
        lvSearch.Visible = False
        lvDebug.Visible = False
    ElseIf TabStrip1.SelectedItem.Index = 2 Then
        lv2.Visible = False
        lvSearch.Visible = True
        lvDebug.Visible = False
    Else
        lv2.Visible = False
        lvSearch.Visible = False
        lvDebug.Visible = True
    End If
End Sub

Private Sub ts_Click()

    If ts.SelectedItem.Index = 1 Then
        txtUncompressed.Visible = True
        he.Visible = False
        txtDetails.Visible = False
    ElseIf ts.SelectedItem.Index = 2 Then
        txtUncompressed.Visible = False
        he.Visible = True
        txtDetails.Visible = False
    Else
        txtUncompressed.Visible = False
        he.Visible = False
        txtDetails.Visible = True
    End If
    
    mnuExtractHexDump.enabled = he.Visible
    mnuExtractHexFromParan.enabled = Not he.Visible
    
End Sub


Private Sub txtPDFPath_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)
    On Error Resume Next
    AutomatationRun = False
    txtPDFPath = Data.Files(1)
    cmdDecode_Click
End Sub

Function GetParentFolder(pth)
    Dim x() As String
    x = Split(pth, "\")
    GetParentFolder = Replace(pth, x(UBound(x)), Empty)
End Function





'If Not fso.FileExists(txtPDFPath) Then
'    MsgBox "File not found: " & txtPDFPath, vbInformation
'    Exit Sub
'End If
'
'filenam = txtPDFPath
'ReDim TheBytes(FileLen(filenam$) - 1)
'
'f = FreeFile
'Open filenam$ For Binary Access Read As f
'Get f, , TheBytes()
'Close f
'
''Convert the entire byte array to a string
'sStr = StrConv(TheBytes, vbUnicode)
'
''Search for stream and endstream
'lStart = InStr(1, sStr, "stream")
'Do While lStart > 0
'    lEnd = InStr(lStart, sStr, "endstream")
'    If lEnd > 0 Then
'        'Get the stream without the text Stream
'        sStream = Mid(sStr, lStart + 6, lEnd - lStart - 6)
'
'        Set stream = New CPDFStream
'        stream.StartOffset = lStart + 5
'
'        'check if to remove the crlf after stream
'        If Left(sStream, 2) = vbCrLf Then
'            sStream = Mid(sStream, 3)
'            stream.StartOffset = stream.StartOffset + 2
'        End If
'
'        If Right(sStream, 2) = vbCrLf Then
'            sStream = Mid(sStream, 1, Len(sStream) - 2)
'        End If
'
'        If Right(sStream, 1) = Chr(&HA) Then
'            sStream = Mid(sStream, 1, Len(sStream) - 1)
'        End If
'
'        stream.CompressedSize = Len(sStream) - 1
'        stream.EndOffset = stream.StartOffset + stream.CompressedSize
'
'        If Len(sStream) > 1 Then
'            'Convert this stream to a byte array
'            TheBytes = StrConv(sStream, vbFromUnicode)
'
'            stream.OriginalData = sStream
'            stream.Index = cnt
'
'            'Decode this portion
'            Module4.UncompressData TheBytes, xbBufferOut
'
'            If aryIsEmpty(xbBufferOut) Then 'decompress error
'                stream.Message = "Decompression Error. Probably Not Compressed"
'                Set li = lv2.ListItems.Add(, , "stream # " & cnt & " org sz = (0x" & Hex(UBound(TheBytes)) & ")")
'                Set li.Tag = stream
'            Else 'everyting was ok
'                stream.Message = Empty
'                stream.DecompressedData = StrConv(xbBufferOut, vbUnicode)
'                stream.DecompressedSize = Len(stream.DecompressedData)
'                Set li = lv.ListItems.Add(, , cnt & " 0x" & Hex(stream.StartOffset) & "-0x" & Hex(stream.EndOffset))
'                Set li.Tag = stream
'            End If
'
'        Else
'            stream.Message = "Stream to small error decoding"
'            Set li = lv2.ListItems.Add(, , "stream #" & cnt & " org sz = (0x" & Hex(Len(sStream)) & ")")
'            Set li.Tag = stream
'        End If
'
'        'Search the next stream where we left off
'        lStart = InStr(lEnd + 8, sStr, "stream")
'    Else
'        lStart = 0
'    End If
'
'    cnt = cnt + 1
'
'Loop
'
