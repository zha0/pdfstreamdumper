VERSION 5.00
Object = "{0E59F1D2-1FBE-11D0-8FF2-00A0D10038BC}#1.0#0"; "msscript.ocx"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Form2 
   Caption         =   "PDF Stream Dumper - JS UI"
   ClientHeight    =   8325
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   14460
   LinkTopic       =   "Form2"
   ScaleHeight     =   8325
   ScaleWidth      =   14460
   StartUpPosition =   3  'Windows Default
   Begin MSComctlLib.ListView lv2 
      Height          =   2670
      Left            =   0
      TabIndex        =   17
      Top             =   5580
      Width           =   2355
      _ExtentX        =   4154
      _ExtentY        =   4710
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   2
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "msg"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "data"
         Object.Width           =   2540
      EndProperty
   End
   Begin MSScriptControlCtl.ScriptControl sc 
      Left            =   13770
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      Language        =   "javascript"
   End
   Begin MSScriptControlCtl.ScriptControl sc2 
      Left            =   13140
      Top             =   90
      _ExtentX        =   1005
      _ExtentY        =   1005
      Language        =   "Javascript"
   End
   Begin PDFStreamDumper.ucScint txtJS 
      Height          =   5865
      Left            =   2430
      TabIndex        =   16
      Top             =   270
      Width           =   11895
      _ExtentX        =   12171
      _ExtentY        =   6853
   End
   Begin VB.Frame splitter 
      BackColor       =   &H00808080&
      Height          =   75
      Left            =   2400
      MousePointer    =   7  'Size N S
      TabIndex        =   9
      Top             =   6840
      Width           =   11895
   End
   Begin VB.Frame Frame1 
      Caption         =   "THIS RUNS SCRIPTS LIVE -- NO SANDBOX  -- (also watch for Adobe specific objects)"
      ForeColor       =   &H00000080&
      Height          =   615
      Left            =   2400
      TabIndex        =   4
      Top             =   6180
      Width           =   11895
      Begin VB.TextBox txtPageNum 
         Height          =   285
         Left            =   5220
         TabIndex        =   15
         Text            =   "1"
         Top             =   225
         Width           =   465
      End
      Begin VB.CheckBox chkNoResest 
         Caption         =   "No Reset"
         Height          =   195
         Left            =   10665
         TabIndex        =   13
         ToolTipText     =   "Check this to not reset the script control between runs (reset clears vars from old scripts which may be needed)"
         Top             =   270
         Width           =   1005
      End
      Begin VB.ComboBox cboVersion 
         Height          =   315
         Left            =   2790
         TabIndex        =   11
         Top             =   225
         Width           =   1320
      End
      Begin VB.CommandButton cmdRun 
         Caption         =   "Run"
         Height          =   375
         Left            =   8730
         TabIndex        =   5
         Top             =   180
         Width           =   1455
      End
      Begin VB.Label Label3 
         Caption         =   "this.pageNum"
         Height          =   285
         Left            =   4185
         TabIndex        =   14
         Top             =   270
         Width           =   1005
      End
      Begin VB.Label Label2 
         Caption         =   "app.viewerVersion :"
         Height          =   285
         Left            =   1350
         TabIndex        =   12
         Top             =   270
         Width           =   1455
      End
      Begin VB.Label lblToolbox 
         Caption         =   "Options"
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
         Left            =   8010
         TabIndex        =   8
         Top             =   270
         Width           =   585
      End
      Begin VB.Label lblClipboard 
         Caption         =   "<-- to clipboard"
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
         Index           =   1
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label lblClipboard 
         Caption         =   "^ to script pane"
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
         Left            =   5805
         TabIndex        =   6
         Top             =   270
         Width           =   1230
      End
   End
   Begin RichTextLib.RichTextBox old_txtJs 
      Height          =   5895
      Left            =   2430
      TabIndex        =   3
      Top             =   270
      Visible         =   0   'False
      Width           =   11895
      _ExtentX        =   20981
      _ExtentY        =   10398
      _Version        =   393217
      HideSelection   =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"Form2.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSComctlLib.ListView lv 
      Height          =   5235
      Left            =   45
      TabIndex        =   1
      Top             =   270
      Width           =   2295
      _ExtentX        =   4048
      _ExtentY        =   9234
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
         Text            =   "Saved Scripts"
         Object.Width           =   2540
      EndProperty
   End
   Begin RichTextLib.RichTextBox txtOut 
      Height          =   1275
      Left            =   2400
      TabIndex        =   10
      Top             =   6960
      Width           =   11895
      _ExtentX        =   20981
      _ExtentY        =   2249
      _Version        =   393217
      HideSelection   =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"Form2.frx":0080
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblClipboard 
      Caption         =   "<-- to clipboard"
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
      Left            =   2400
      TabIndex        =   2
      Top             =   0
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Script"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3600
      TabIndex        =   0
      Top             =   0
      Width           =   975
   End
   Begin VB.Menu mnuMainLoadFile 
      Caption         =   "Load"
      Begin VB.Menu mnuLoadFile 
         Caption         =   "Load JavaScript"
      End
      Begin VB.Menu mnuLoadShellcode 
         Caption         =   "Load Shellcode"
      End
   End
   Begin VB.Menu mnuBeautify 
      Caption         =   "Format_Javascript"
   End
   Begin VB.Menu mnuUnescapeSelection 
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
      Begin VB.Menu mnuAddPercentoHexString 
         Caption         =   "Add % to HexString"
      End
      Begin VB.Menu mnuVarPrefix 
         Caption         =   "Prefix Sel Lines with var"
      End
      Begin VB.Menu mnuHex2Unicode 
         Caption         =   "HexString to %u encoded"
      End
   End
   Begin VB.Menu mnuExploitScan 
      Caption         =   "Exploit_Scan"
   End
   Begin VB.Menu mnuSimplifySelection 
      Caption         =   "Simplify_Selection_Quotes"
   End
   Begin VB.Menu mnuShellcodeUI 
      Caption         =   "Shellcode_Analysis"
      Begin VB.Menu mnuLaunchSclog 
         Caption         =   "scLog ( iDefense - Runs Live)"
         Index           =   0
      End
      Begin VB.Menu mnuLaunchSclog 
         Caption         =   "scDbg ( libEmu - Emulation )"
         Index           =   1
      End
      Begin VB.Menu mnuScSigs 
         Caption         =   "scSigs  (Sig Check + libemu Unpack)"
      End
      Begin VB.Menu mnuXorBruteForce 
         Caption         =   "Xor BruteForcer"
      End
      Begin VB.Menu mnuspacer99 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSaveShellcode 
         Caption         =   "Save Bytes to file"
      End
      Begin VB.Menu mnuSc2ExeMain 
         Caption         =   "Shellcode 2 Exe"
         Begin VB.Menu mnuShellcode2Exe 
            Caption         =   "Simple Husk (sc 0x401000)"
            Index           =   0
         End
         Begin VB.Menu mnuShellcode2Exe 
            Caption         =   "Simple Husk w/Wsa Startup  (sc 0x401020)"
            Index           =   1
         End
         Begin VB.Menu mnuShellcode2Exe 
            Caption         =   "New Husk (supports cmdline + 6k sc buf)"
            Index           =   2
         End
      End
      Begin VB.Menu mnuSend2IDA 
         Caption         =   "Disassemble in IDA"
      End
      Begin VB.Menu mnuspacer2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSample 
         Caption         =   "Sample Shellcode"
         Begin VB.Menu mnuShellcode 
            Caption         =   "Copy sc files to /sc_samples directory to load list"
            Index           =   0
         End
         Begin VB.Menu mnuShellcode 
            Caption         =   "samples removed due to AV alert"
            Index           =   1
         End
      End
   End
   Begin VB.Menu mnuReplace 
      Caption         =   "Find/Replace"
   End
   Begin VB.Menu mnuBasicRefactor 
      Caption         =   "Basic_Refactor"
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Visible         =   0   'False
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu mnuSaveToFile 
         Caption         =   "Save to file"
      End
      Begin VB.Menu mnuSpacer5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCopyToJs 
         Caption         =   "Copy to JS TextBox"
      End
      Begin VB.Menu mnuCopyToLower 
         Caption         =   "Copy To Lower TextBox"
      End
      Begin VB.Menu mnuSpacer4 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRenameScript 
         Caption         =   "Rename Entry"
      End
      Begin VB.Menu mnuRemoveEntry 
         Caption         =   "Remove Entry"
      End
      Begin VB.Menu mnuClearAll 
         Caption         =   "Clear All"
      End
   End
   Begin VB.Menu mnuPopup2 
      Caption         =   "mnuPopup2"
      Visible         =   0   'False
      Begin VB.Menu mnuGotoLine 
         Caption         =   "Goto Line"
      End
      Begin VB.Menu mnuQuickEval 
         Caption         =   "Quick Eval"
      End
      Begin VB.Menu mnuCopyFuncsNames 
         Caption         =   "Copy Func Names"
      End
      Begin VB.Menu mnuShowHelp 
         Caption         =   "Show Help"
      End
      Begin VB.Menu mnuWordWrap 
         Caption         =   "Word Wrap"
      End
      Begin VB.Menu mnuCodeFolding 
         Caption         =   "Code Folding"
      End
      Begin VB.Menu mnuScintillaOptions 
         Caption         =   "Scintilla Options"
      End
      Begin VB.Menu mnuIndentGuide 
         Caption         =   "Show Indent Guides"
      End
      Begin VB.Menu mnuAutoComplete 
         Caption         =   "AutoComplete on CtrlSpace"
      End
   End
   Begin VB.Menu mnuPopup3 
      Caption         =   "mnuPopup3"
      Visible         =   0   'False
      Begin VB.Menu mnuCopyAllDatalv2 
         Caption         =   "Copy All w/Data"
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Author:   dzzie@yahoo.com
'Site:     http://sandsprite.com

Dim dlg As New clsCmnDlg
Dim toolbox As New CScriptFunctions

'splitter code taken from sample by Bruce Fast, submitted to the public domain. thanks!

'todo: we could add our listview to the toolbox class so scripts can pull
'saved script variables directly from there via something like
' savedVar1 = tb.lv.listitems(index).tag
'even if i am the only one who would use that :P

Private Capturing As Boolean
Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseCapture Lib "user32" () As Long
Private objsAdded As Boolean
Dim USING_MYMAIN As Boolean
Private Declare Function SetFilePointer Lib "kernel32" (ByVal hFile As Long, ByVal lDistanceToMove As Long, lpDistanceToMoveHigh As Long, ByVal dwMoveMethod As Long) As Long



Public Function StandardizeLineBreaks(ByVal x)
    x = Replace(x, vbCrLf, Chr(5))
    x = Replace(x, vbCr, Chr(5))
    x = Replace(x, vbLf, Chr(5))
    StandardizeLineBreaks = Replace(x, Chr(5), vbCrLf)
End Function



Private Sub lv2_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    If Len(Item.SubItems(1)) > 0 Then
        txtOut.Text = Item.SubItems(1)
    Else
        txtOut.Text = Item.Text
    End If
End Sub

 

Private Sub lv2_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Button = 2 Then PopupMenu mnuPopup3
End Sub

Private Sub mnuAutoComplete_Click()
    mnuAutoComplete.Checked = Not mnuAutoComplete.Checked
    txtJS.AutoCompleteOnCTRLSpace = mnuAutoComplete.Checked
End Sub

Private Sub mnuCodeFolding_Click()
    mnuCodeFolding.Checked = Not mnuCodeFolding.Checked
    txtJS.Folding = mnuCodeFolding.Checked
End Sub

Private Sub mnuCopyAllDatalv2_Click()
    On Error Resume Next
    Dim li As ListItem
    For Each li In lv2.ListItems
        If Len(li.SubItems(1)) > 0 Then
            ret = ret & li.SubItems(1) & vbCrLf
        End If
    Next
    Clipboard.Clear
    Clipboard.SetText ret
    MsgBox Len(ret) & " bytes copied", vbInformation
End Sub

Private Sub mnuCopyFuncsNames_Click()
    On Error Resume Next
    x = Split(txtJS.Text, vbCrLf)
    For Each Y In x
        If InStr(Y, "function") > 0 Then
            tmp = tmp & Y & vbCrLf
        End If
    Next
    tmp = Replace(tmp, vbTab, Empty)
    Clipboard.Clear
    Clipboard.SetText tmp
    MsgBox UBound(Split(tmp, vbCrLf)) & " lines copied to clipboard"
End Sub

Private Sub mnuCopyToJs_Click()
    On Error Resume Next
    If lv.SelectedItem Is Nothing Then Exit Sub
    txtJS.Text = lv.SelectedItem.tag
End Sub

Private Sub mnuCopyToLower_Click()
    On Error Resume Next
    If lv.SelectedItem Is Nothing Then Exit Sub
    txtOut.Text = lv.SelectedItem.tag
End Sub

Private Sub mnuGotoLine_Click()
    On Error Resume Next
    x = InputBox("Enter line to goto:")
    txtJS.GotoLine CLng(x)
End Sub

Private Sub mnuHex2Unicode_Click()
    On Error Resume Next
    x = Replace(txtJS.SelText, vbCrLf, Empty)
    x = Replace(x, Chr(0), "")
    If Len(x) = 0 Then
        MsgBox "Nothing selected!"
        Exit Sub
    End If
    While Len(x) Mod 2 <> 0
        x = x & "0"
    Wend
    For i = 1 To Len(x) Step 4
       a = Mid(x, i, 2)
       b = Mid(x, i + 2, 2)
       ret = ret & "%u" & b & a
    Next
    If Right(ret, 2) = "%u" Then ret = Mid(ret, 1, Len(ret) - 2)
    txtJS.SelText = ret
End Sub

Private Sub mnuIndentGuide_Click()
    mnuIndentGuide.Checked = Not mnuIndentGuide.Checked
    txtJS.LineIndentGuide = mnuIndentGuide.Checked
End Sub

Public Sub mnuLoadShellcode_Click()
    Dim f As String
    dlg.SetCustomFilter "Shellcode File (*.sc)", "*.sc"
    f = dlg.OpenDialog(CustomFilter, "", "Open file", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    If Not fso.FileExists(f) Then Exit Sub
    x = HexDump(fso.ReadFile(f), 1)
    txtJS.Text = AddPercentToHexString(x)
    txtJS.SelectAll
End Sub

Private Sub mnuQuickEval_Click()
    On Error Resume Next
    s = InputBox("Enter a script to execute in current script contect. You can use this to probe runtime variables like tb.alert(my_var) or tb.t(longtext_var)")
    If Len(s) = 0 Then Exit Sub
    sc.eval s
End Sub

Private Sub mnuScintillaOptions_Click()
    txtJS.ShowOptions
End Sub



Private Sub mnuSend2IDA_Click()
    Dim h As String
    Const def = "C:\Program Files\IDA\idag.exe"
    
    On Error Resume Next
    
    If Len(txtJS.SelText) = 0 Then
        MsgBox "You must first select the shellcode to extract in the script window."
        Exit Sub
    End If
    
    h = GetMySetting("idapath")
    If Len(h) = 0 And fso.FileExists(def) Then h = def 'use default if found
        
    If Len(h) = 0 Or Not fso.FileExists(h) Then
        If MsgBox("You have not yet configured the path to IDA install. select it now?", vbYesNo) = vbNo Then Exit Sub
        h = dlg.OpenDialog(exeFiles, , "Select IDA", Me.hwnd)
        If fso.FileExists(h) Then
            SaveMySetting "idapath", h
        Else
            Exit Sub
        End If
    End If
    
    x = txtJS.SelText
    x = PrepareShellcode(x) 'does not handle just hex blobs like 9090 other formats supported though with multiescape
    
    scf = App.path & "\tmp.sc"
    If fso.FileExists(scf) Then Kill scf
    fso.writeFile scf, x
    
    Shell h & " """ & scf & """", vbNormalFocus
    
    If Err.Number <> 0 Then MsgBox Err.Description
    
End Sub



Private Sub mnuShellcode_Click(Index As Integer)
    
    On Error Resume Next
    
    cap = mnuShellcode(Index).Caption
    If cap = "Copy sc files to /sc_samples directory to load list" Or _
       cap = "samples removed due to AV alert" Then _
    Exit Sub
    
    pth = App.path & "\sc_samples\" & cap
    
    If Not fso.FileExists(pth) Then
        MsgBox "File not found: " & pth
        Exit Sub
    End If
    
    tmp = fso.ReadFile(pth)
    tmp = HexDump(tmp, 1)
    txtJS.Text = AddPercentToHexString(tmp)
    txtJS.SelectAll
    
End Sub

Private Sub mnuShowHelp_Click()
    toolbox.Help
End Sub

Private Sub mnuVarPrefix_Click()

    On Error Resume Next

    If txtJS.SelLength = 0 Then
        MsgBox "This is used for the refactor form, used to add var to the beginning of all lines selected.", vbInformation
        Exit Sub
    End If
    
    x = txtJS.SelText
    tmp = Split(x, vbCrLf)
    For i = 0 To UBound(tmp)
        tmp(i) = "var " & tmp(i)
    Next
        
    If Err.Number = 0 Then txtJS.SelText = Join(tmp, vbCrLf)


End Sub

Private Sub mnuWordWrap_Click()
    mnuWordWrap.Checked = Not mnuWordWrap.Checked
    txtJS.WordWrap = mnuWordWrap.Checked
End Sub

Private Sub mnuXorBruteForce_Click()
    On Error Resume Next
    
    If Len(txtJS.SelText) = 0 Then
        MsgBox "You must first select the shellcode to extract in the script window."
        Exit Sub
    End If
    
    x = txtJS.SelText
    
    'does not handle just hex blobs like 9090 other formats supported though with multiescape
    
    x = PrepareShellcode(x)
    
    base = App.path & "\xor_bruteforcer"
    If fso.FileExists(base & "\sample.sc") Then Kill base & "\sample.sc"
    
    If Not fso.FileExists(base & "\xorbrute.exe") Then
        MsgBox "Could not find xorbrute.exe in xor_bruteforcer sub directory", vbInformation
        Exit Sub
    End If
    
    fso.writeFile base & "\sample.sc", x
    Shell """" & base & "\xorbrute.exe"" " & base & "\sample.sc", vbNormalFocus
    
End Sub

'splitter code
'------------------------------------------------
Private Sub splitter_MouseMove(Button As Integer, Shift As Integer, x As Single, Y As Single)
    Dim a1&

    If Button = 1 Then 'The mouse is down
        If Capturing = False Then
            splitter.ZOrder
            SetCapture splitter.hwnd
            Capturing = True
        End If
        With splitter
            a1 = .Top + Y
            If MoveOk(a1) Then
                .Top = a1
            End If
        End With
    End If
End Sub

Private Sub splitter_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Capturing Then
        ReleaseCapture
        Capturing = False
        DoMove
    End If
End Sub


Private Sub DoMove()
    On Error Resume Next
    Const buf = 10
    txtOut.Top = splitter.Top + splitter.Height + buf
    txtOut.Height = Me.Height - txtOut.Top - buf
    Frame1.Top = splitter.Top - Frame1.Height - buf
    txtJS.Height = Frame1.Top - txtJS.Top - buf
End Sub


Private Function MoveOk(Y&) As Boolean  'Put in any limiters you desire
    MoveOk = False
    If Y > Frame1.Height * 2 And Y < Me.Height - (Frame1.Height * 2) Then
        MoveOk = True
    End If
End Function

'------------------------------------------------
'end splitter code

Private Sub cmdRun_Click()
    On Error Resume Next
    
    Dim user_lib As String
    Dim main_wrapper As String
    
    user_lib = App.path & "\userlib.js"
    main_wrapper = App.path & "\myMain.js"
    
    List1.Clear
    toolbox.ResetAlertCount
    txtPageNum.SetFocus   'dont want run button to keep focus in case of tons of alerts, so you can hold down enter key without reexec script at end.
    
    USING_MYMAIN = False
    If fso.FileExists(user_lib) And fso.FileExists(main_wrapper) Then USING_MYMAIN = True
        
    If chkNoResest.Value = 0 Or objsAdded = False Then
        lv2.ListItems.Clear
        objsAdded = True
        sc.Reset
        
        If Not USING_MYMAIN Then 'old default support for basic objects..do we need to keep this?
            toolbox.DebugLog "Not using userlib or myMain falling back to internal toolbox based support for Adobe Objects"
            sc.AddObject "info", toolbox    'fall back in case userlib or main fuckup...
            sc.AddObject "media", toolbox
            sc.AddObject "spell", toolbox
            sc.AddObject "util", toolbox
            sc.AddObject "this", toolbox
            sc.AddObject "Collab", toolbox
        End If
        
        sc.AddObject "tb", toolbox
        sc.AddObject "toolbox", toolbox
        sc.AddObject "txtOut", txtOut
        
        If fso.FileExists(user_lib) Then
            sc.AddCode fso.ReadFile(user_lib)
        End If
        
    End If
    
    toolbox.RefreshObjBrowserData
    
    If USING_MYMAIN = True Then
        main_wrapper = fso.ReadFile(main_wrapper)
        main_wrapper = Replace(main_wrapper, "//real script here", txtJS.Text)
        sc.AddCode main_wrapper
    Else
        sc.AddCode txtJS.Text
    End If
    
End Sub

Private Sub lblToolbox_Click(Index As Integer)
    PopupMenu mnuPopup2
End Sub

Private Sub Form_Load()
    On Error Resume Next
    
    Me.Icon = Form1.Icon
    mnuWordWrap.Checked = IIf(GetMySetting("WordWrap", 1) = 1, True, False)
    mnuIndentGuide.Checked = IIf(GetMySetting("IndentGuide", 0) = 1, True, False)
    mnuCodeFolding.Checked = IIf(GetMySetting("CodeFolding", 0) = 1, True, False)
    mnuAutoComplete.Checked = IIf(GetMySetting("AutoComplete", 0) = 1, True, False)
    
    txtJS.WordWrap = mnuWordWrap.Checked
    txtJS.LineIndentGuide = mnuIndentGuide.Checked
    txtJS.Folding = mnuCodeFolding.Checked
    txtJS.AutoCompleteOnCTRLSpace = mnuAutoComplete.Checked
    
    lv.ColumnHeaders(1).Width = lv.Width - 200
    FormPos Me, True
    splitter.Top = GetMySetting("SplitterTop", splitter.Top)
    Form_Resize
    DoMove
    cboVersion.AddItem "8.0.1.3"
    cboVersion.AddItem "7.8.1.1"
    cboVersion.AddItem "8.9.0"
    cboVersion.AddItem "9.2"
    cboVersion.Text = "9.2"
    
    Dim tmp() As String
    i = 0
    tmp() = fso.GetFolderFiles(App.path & "\sc_samples\")
    For Each x In tmp
        If Len(x) > 0 And fso.FileExists(x) Then
            If i > 1 Then Load mnuShellcode(i)
            mnuShellcode(i).Caption = x
            'mnuShellcode(i).Tag = x
            i = i + 1
        End If
    Next
        
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    txtOut.Width = Me.Width - txtOut.Left - 300
    txtJS.Width = txtOut.Width
    txtOut.Height = Me.Height - txtOut.Top - 700
    
    lv2.Top = Me.Height - lv2.Height - 750
    lv.Height = lv2.Top - lv.Top - 25
    
    'lv.Height = Me.Height - lv.Top - 700
    Frame1.Width = txtJS.Width
    splitter.Width = txtJS.Width
    
    If Me.WindowState = vbMinimized Then Exit Sub
    
    If splitter.Top < Frame1.Height * 2 Then
        splitter.Top = Frame1.Height * 2
        DoMove
    ElseIf splitter.Top > Me.Height - (Frame1.Height * 2) Then
        splitter.Top = Me.Height - (Frame1.Height * 2)
        DoMove
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    On Error Resume Next
    FormPos Me, True, True
    SaveMySetting "SplitterTop", splitter.Top
    SaveMySetting "WordWrap", IIf(mnuWordWrap.Checked, 1, 0)
    SaveMySetting "IndentGuide", IIf(mnuIndentGuide.Checked, 1, 0)
    SaveMySetting "CodeFolding", IIf(mnuCodeFolding.Checked, 1, 0)
    SaveMySetting "AutoComplete", IIf(mnuAutoComplete.Checked, 1, 0)
    
    Dim tmpfiles(), f 'this is very messy!
    
    push tmpfiles, App.path & "\tmp.sc"  'send to ida tmp file
    push tmpfiles, App.path & "\libemu\sample.sc" 'sctest/scsigs
    push tmpfiles, App.path & "\xor_bruteforcer\sample.sc" 'xor bruteforcer
    push tmpfiles, "c:\shellcode.sc" 'sclog
    push tmpfiles, "c:\SHELLC~1.SC.dmp" 'sclog
    
    For Each f In tmpfiles
        If fso.FileExists(f) Then Kill f
    Next
    
End Sub

Private Sub lblClipboard_Click(Index As Integer)
    
    Dim li As ListItem
    On Error Resume Next
    
    Select Case Index
        Case 0
            Set li = lv.ListItems.Add(, , (lv.ListItems.Count + 1) & " len - " & Len(txtJS.Text))
            li.tag = txtJS.Text
            li.ToolTipText = li.tag
        Case 1
            Set li = lv.ListItems.Add(, , (lv.ListItems.Count + 1) & " len - " & Len(txtOut.Text))
            li.tag = txtOut.Text
            li.ToolTipText = li.tag
        Case 2
            txtJS.Text = txtOut.Text
            txtOut.Text = Empty
    End Select
    
End Sub

Private Sub lv_DblClick()
    If lv.SelectedItem Is Nothing Then Exit Sub
    txtJS.Text = lv.SelectedItem.tag
End Sub


Private Sub lv_KeyDown(KeyCode As Integer, Shift As Integer)
    
    'MsgBox KeyCode & " " & Shift
    'Exit Sub
    
    Dim li As ListItem
    Dim i As Long
    
    If KeyCode = 82 And Shift = 2 Then 'ctrl-r - rename
        For Each li In lv.ListItems
            If li.Selected Then
                x = InputBox("Rename entry " & li.Text, , li.Text)
                If Len(x) > 0 Then li.Text = x
            End If
        Next
    End If
    
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
        If MsgBox("Are you sure you want to deleted the selected entries?", vbYesNo) = vbYes Then
            For i = lv.ListItems.Count To 1 Step -1
                If li.Selected = True Then
                    lv.ListItems.Remove i
                End If
            Next
        End If
    End If
    
    If KeyCode = 78 And Shift = 2 Then 'ctrl-n -select none
        For Each li In lv.ListItems
            li.Selected = False
        Next
    End If
    
End Sub


Private Sub lv_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Button = 2 Then PopupMenu mnuPopup
End Sub

Private Sub mnuAddPercentoHexString_Click()
    
    On Error Resume Next
    Dim t As String
    Dim b() As Byte
    Dim c As String
    
    t = txtJS.SelText
    If Len(t) = 0 Then
        MsgBox "No selection", vbInformation
        Exit Sub
    End If
    
    t = HexStringUnescape(t, True)
    b() = StrConv(t, vbFromUnicode, LANG_US)
    t = Empty
    
    For i = 0 To UBound(b)
        c = Hex(b(i))
        If Len(c) = 1 Then c = "0" & c
        t = t & "%" & c
    Next
    
    txtJS.SelText = t
    
End Sub

Private Sub mnuBasicRefactor_Click()
    
    On Error GoTo hell
    Dim debugMode As Boolean
     
    If InStr(1, txtJS.Text, vbCrLf & "}" & vbCrLf) < 1 Then
        MsgBox "This assumes you already ran Format_Javascript", vbInformation
        'Exit Sub
    End If
    
   
    'debugMode = False
    debugMode = True
    
    
    lblClipboard_Click 0 'save a copy of the original
    frmRefactor.LoadFunctions txtJS.Text, debugMode
    
    If debugMode = False Then
        Dim f As CFunc
        Dim script As String
        script = txtJS.Text
        For Each f In frmRefactor.funcs
            script = Replace(script, f.OrgText, f.CleanText)
        Next
        
        txtJS.Text = script
        
        Unload frmRefactor
    End If
    
    Exit Sub
hell:
       MsgBox "Error in mnuBasicRefactor_Click() original was saved to left list probably have to restore from there", vbInformation
    
End Sub



Private Sub mnuBeautify_Click()
    
    On Error Resume Next
    Dim js As String
    
    js = fso.ReadFile(App.path & "\beautify.js")
    
    sc2.Reset
    sc2.AddCode js
    sc2.AddObject "txtUncompressed", txtJS, True
    sc2.AddCode "txtUncompressed.text = js_beautify(txtUncompressed.text, {indent_size: 1, indent_char: '\t'}).split('\n').join('\r\n');"


End Sub

Private Sub mnuClearAll_Click()
    
    If MsgBox("Are you sure you want to delete all items?", vbYesNo) = vbYes Then
        lv.ListItems.Clear
    End If
        
End Sub

Private Sub mnuExploitScan_Click()
    
    Dim report() As String
    Dim p() As String
    Dim exploits()
    Dim offset As Long
    
    On Error Resume Next
    
    exploits = Form1.GetExploits()
    
    For i = 0 To UBound(exploits)
            p() = Split(exploits(i), "=")
            If ContainsExploit(txtJS.Text, p(1), offset) Then
                push report, "Exploit " & p(0) & " - " & p(1) & " - found in main textbox"
                txtJS.SelStart = offset - 1
                'txtJS.SelLength = Len(p(1))
                
                'vbsci specific
                report(UBound(report)) = report(UBound(report)) & " Line: " & txtJS.CurrentLine
                
                'txtJS.SelColor = vbBlue
                'txtJS.SelBold = True
                'txtJS.SelLength = 0
                
            End If
    Next
    
    If AryIsEmpty(report) Then
        MsgBox "No exploits found", vbInformation
        Exit Sub
    End If
    
    push report, vbCrLf & "Other exploits may be hidden w/ obsfuscation"
    push report, "May also be used innocently."
    
    txtOut.Text = Join(report, vbCrLf)
    
    'Dim tmp As String
    'tmp = fso.GetFreeFileName(Environ("temp"))
    'fso.WriteFile tmp, Join(report, vbCrLf)
    'Shell "notepad.exe """ & tmp & """", vbNormalFocus
  
  
End Sub

Private Sub mnuFind_Click()
    
    
    
End Sub

Private Sub mnuLaunchSclog_Click(Index As Integer)
    
    If Len(txtJS.SelText) = 0 Then
        MsgBox "You must first select the shellcode to extract in the script window."
        Exit Sub
    End If
    
    x = txtJS.SelText
    
    'does not handle just hex blobs like 9090 other formats supported though with multiescape
    
    x = PrepareShellcode(x)
    
    If Index = 0 Then
        frmSclog.InitInterface CStr(x)
    Else
        frmScTest.InitInterface CStr(x)
    End If
    
End Sub

Private Sub mnuScSigs_Click()
    On Error Resume Next
    
    If Len(txtJS.SelText) = 0 Then
        MsgBox "You must first select the shellcode to extract in the script window."
        Exit Sub
    End If
    
    x = txtJS.SelText
    
    'does not handle just hex blobs like 9090 other formats supported though with multiescape
    
    x = PrepareShellcode(x)
    
    base = App.path & "\libemu"
    If fso.FileExists(base & "\sample.sc") Then Kill base & "\sample.sc"
    
    If Not fso.FileExists(base & "\scsigs.exe") Then
        MsgBox "Could not find scsigs.exe in libemu directory", vbInformation
        Exit Sub
    End If
    
    fso.writeFile base & "\sample.sc", x
    Shell """" & base & "\scsigs.exe"" " & base & "\sample.sc", vbNormalFocus
    
End Sub


Private Function PrepareShellcode(x) As String
    
    If InStr(x, """") > 0 Then x = Replace(x, """", Empty)
    If InStr(x, vbCrLf) > 0 Then x = Replace(x, vbCrLf, Empty)
    If InStr(x, vbCr) > 0 Then x = Replace(x, vbCr, Empty)
    If InStr(x, vbLf) > 0 Then x = Replace(x, vbLf, Empty)
    If InStr(x, vbTab) > 0 Then x = Replace(x, vbTab, Empty)
    If InStr(x, "+") > 0 Then x = Replace(x, "+", Empty)
    If InStr(x, "'") > 0 Then x = Replace(x, "'", Empty)
    If InStr(x, " ") > 0 Then x = Replace(x, " ", Empty)
    x = MultiEscape(x)

    PrepareShellcode = x
    
End Function

Public Sub mnuLoadFile_Click()
    Dim f As String
    dlg.SetCustomFilter "Javascript File (*.js)", "*.js"
    f = dlg.OpenDialog(CustomFilter, "", "Open file", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    If Not fso.FileExists(f) Then Exit Sub
    txtJS.Text = fso.ReadFile(f)
End Sub

Private Sub mnuManualEscape_Click(Index As Integer)
    
    Dim t As String
    Dim ss As Long
    On Error Resume Next
    
    t = txtJS.SelText
    ss = txtJS.SelStart
    
    If Len(t) = 0 Then
        MsgBox "No text selected", vbInformation
        Exit Sub
    End If
    
    Select Case Index
        Case 0: t = HexStringUnescape(t)
        Case 1: t = HexStringUnescape(t, True)
        Case 2: t = unescape(t)
        Case 3: t = js_unescape(t)
        Case 4: t = nl_unescape(t)
        Case 5: t = pound_unescape(t)
        Case 6: t = octal_unescape(t)
    End Select
    
    txtJS.SelText = t
    txtJS.SelStart = ss
    txtJS.SelLength = Len(t)
    
End Sub

Private Sub mnuRemoveEntry_Click()
    
    If lv.SelectedItem Is Nothing Then Exit Sub
    lv.ListItems.Remove lv.SelectedItem.Index
    
End Sub

Private Sub mnuRenameScript_Click()

    If lv.SelectedItem Is Nothing Then Exit Sub
    
    x = InputBox("Rename script", , lv.SelectedItem.Text)
    If Len(x) = 0 Then Exit Sub
    lv.SelectedItem.Text = x
    
End Sub

Private Sub mnuReplace_Click()
    
    frmReplace.LaunchReplaceForm txtJS
    
End Sub


Private Sub mnuSaveAll_Click()
    
    Dim li As ListItem
    Dim f As String
    On Error GoTo hell
    
    f = dlg.FolderDialog("", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    
    For Each li In lv.ListItems
        fso.writeFile f & "\script_" & li.Index & ".js", li.tag
    Next
    
    Exit Sub
hell:     MsgBox Err.Description
    
End Sub

Private Sub mnuSaveShellcode_Click()
    
    x = txtJS.SelText
    If Len(x) = 0 Then
        MsgBox "No text selected", vbInformation
        Exit Sub
    End If
    
    x = PrepareShellcode(x)
    
    Dim pth As String
    pth = dlg.SaveDialog(AllFiles, , "Save shellcode as", , Me.hwnd, RecommendedName("bytes.sc"))
    If Len(pth) = 0 Then Exit Sub
    
    fso.writeFile pth, x
    
End Sub

Private Function RecommendedName(Optional defaultName) As String
    
    On Error Resume Next
    Dim r As String
    Dim ext As String
    
    a = InStr(defaultName, ".")
    If a > 0 Then ext = Mid(defaultName, a)
    
    If Len(Form1.txtPDFPath) = 0 Then
        RecommendedName = defaultName
        Exit Function
    End If
    
    r = fso.GetBaseName(Form1.txtPDFPath)
    If Len(r) = 0 Then
        RecommendedName = defaultName
    Else
        r = r & ext
    End If
    RecommendedName = r
    
    
    
End Function

Private Sub mnuSaveToFile_Click()

    Dim li As ListItem
    Dim f As String
    On Error GoTo hell
    
    If lv.SelectedItem Is Nothing Then Exit Sub
    
    f = dlg.SaveDialog(AllFiles, "", "Save file", , Me.hwnd, "script_" & lv.SelectedItem.Index & ".js")
    If Len(f) = 0 Then Exit Sub
    
    fso.writeFile f, lv.SelectedItem.tag
    
    Exit Sub
hell:     MsgBox Err.Description
End Sub

Private Sub mnuShellcode2Exe_Click(Index As Integer)
    
    On Error Resume Next
    
    Dim pth As String
    Dim f As Long
    Dim Shellcode() As Byte
    Dim husk() As Byte
    Dim hFile As String
    Dim simple_husk As Boolean
    
    x = txtJS.SelText
    
    If Len(x) = 0 Then
        MsgBox "No text selected", vbInformation
        Exit Sub
    End If
    
    
    'If MsgBox("Do you want to use the simple husk?", vbYesNo + vbQuestion) = vbYes Then
    '    simple_husk = True
    'End If
    
    simple_husk = True
    If Index = 2 Then simple_husk = False
    
    hFile = App.path & IIf(simple_husk, "\simple_husk.dat", "\husk.exe")
    If Not fso.FileExists(hFile) Then
        MsgBox "Husk.exe container was not found did your AV eat it?", vbInformation
        Exit Sub
    End If
    
    hFile = fso.ReadFile(hFile)
    
    If simple_husk Then
        hFile = HexStringUnescape(hFile)
        husk() = StrConv(hFile, vbFromUnicode, LANG_US)
        For i = 0 To UBound(husk): husk(i) = husk(i) Xor &H77: Next
    Else
        husk() = StrConv(hFile, vbFromUnicode, LANG_US)
    End If
    
    x = PrepareShellcode(x)
    Shellcode() = StrConv(x, vbFromUnicode, LANG_US)
    
    If simple_husk And UBound(Shellcode) > &H1A49 Then
        MsgBox "Shellcode is larger than buffer in husk..may cause errors"
    End If
    
    If Not simple_husk And UBound(Shellcode) > 6000 Then
        MsgBox "Shellcode is larger than buffer in husk..may cause errors"
    End If
    
    pth = dlg.SaveDialog(AllFiles, , "Save Shellcode Executable As", , Me.hwnd, "shellcode.exe_")
    If Len(pth) = 0 Then Exit Sub
    
    If Err.Number <> 0 Then
        MsgBox Err.Description
        Exit Sub
    End If
    
    f = FreeFile
    Open pth For Binary As f
    Put f, , husk
    
    Dim offset As Long
    
    Select Case Index
        Case 0: offset = &H1000
        Case 1: offset = &H1020
        Case 2: offset = &H8030
    End Select
    
    Dim b As Byte
    If offset = &H8030 Then 'negative fuckers
        Seek f, &H7030
        For i = 0 To &H1000 'this is some stupid shit...
            Get f, , b
        Next
        Put f, , Shellcode()
    Else
        Put f, offset + 1, Shellcode()
    End If
    
    Close
    
    If Err.Number = 0 Then
        MsgBox "File generated successfully...", vbInformation
    Else
        MsgBox Err.Description
    End If
    
End Sub


Private Sub mnuSimplifySelection_Click()
    
    '"p"+"ar"+"ent"+""
    'effata+'A'+'B'+'C'+cruore+'E'+eumque+effata
    On Error Resume Next
    ss = txtJS.SelStart
    x = txtJS.SelText
    x = Replace(x, "'", """") 'unify
    x = Replace(x, """ + """, Empty) 'remove " + "
    x = Replace(x, "+""""", Empty) 'remove + empty
    x = Replace(x, """+""", Empty) 'remove "+"
    
    'txtJs.ReplaceSel x 'codemax
    txtJS.SelText = x
    txtJS.SelStart = ss
    txtJS.SelLength = Len(x)
    txtJS.SetFocus

End Sub

Private Sub mnuUnescapeSelection_Click()
    
    On Error Resume Next
    
    If txtJS.SelLength = 0 Then Exit Sub
    Dim t As Object
    
    Set t = txtJS
    
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
    
    sc2.Reset
    sc2.AddObject "txtJs", txtJS, True
    sc2.AddCode "txtJs.SelText = unescape(txtJs.SelText)"
    
    
    
End Sub

Private Sub sc_Error()
        
    On Error Resume Next
    Dim tmp() As String
    Dim cCount As Long
    Dim adjustedLine As Long
    Dim curLine As Long
    
    With sc.error
    
        curLine = txtJS.CurrentLine
        adjustedLine = .Line - IIf(USING_MYMAIN, 4, 0)
        
        txtOut.Text = "Time: " & Now & vbCrLf & "Error: " & .Description & vbCrLf & "Line: " & adjustedLine
        txtOut.Text = txtOut.Text & vbCrLf & "Source: " & txtJS.GetLineText(adjustedLine) 'vbsci specific
        lv2.ListItems.Add , , "Error: " & txtOut.Text
        
        tmp = Split(txtJS.Text, vbCrLf)
        For i = 0 To adjustedLine - 1
            If i = (adjustedLine - 1) Then
                If curLine > i And (adjustedLine - 5 > 0) Then
                    txtJS.GotoLine adjustedLine - 5 'display bug
                Else
                    txtJS.GotoLine adjustedLine
                End If
                txtJS.SelStart = cCount
                txtJS.SelLength = Len(tmp(i))
                Exit For
            Else
                cCount = cCount + Len(tmp(i)) + 2 'for the crlf
            End If
        Next
    
    End With
    
End Sub


Private Sub txtJS_AutoCompleteEvent(className As String)
    If className = "tb" Then
        txtJS.ShowAutoComplete "Save2Clipboard GetClipboard t eval unescape alert Hexdump WriteFile ReadFile HexString2Bytes Disasm pad EscapeHexString GetStream CRC getPageNumWords GetPageNthWord"
    End If
End Sub

'Private Const WM_USER = &H400
'Private Const EM_SETTARGETDEVICE = (WM_USER + 72)
'Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
'
''problems with codemax
''cant select a line? or set sellength
''can not turn on wrod wrap? - looks unfixable rest fixable..
''select all?
'Function InitCodeMax()
'    On Error Resume Next
'
'    Dim g As New CodeMaxCtl.Globals
'    Dim l As Language
'
'    SendMessage txtJs.hwnd, EM_SETTARGETDEVICE, 0, 60
'    Const keywords = "function,with,setTimeout,setInterval,app,alert,eval,doc,getAnnots"
'
'    With txtJs
'        .SetColor cmClrLeftMargin, &HC0C0C0
'        .SetColor cmClrLineNumber, vbWhite
'        Set l = g.GetLanguageDef("Java")
'
'        k = Split(keywords, ",")
'        For Each kk In k
'            l.keywords = l.keywords & Chr(10) & kk
'        Next
'
'        g.RegisterLanguage "Adobe_Javascript", l
'        .Language = "Adobe_Javascript"
'        .SetColor cmClrLineNumberBk, &H808080
'    End With
'
'End Function



Private Sub txtJS_GotFocus()

End Sub
