VERSION 5.00
Object = "{0E59F1D2-1FBE-11D0-8FF2-00A0D10038BC}#1.0#0"; "msscript.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmInlineDecoderCalls 
   Caption         =   "Eval and replace inline string decoder calls"
   ClientHeight    =   8475
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   9450
   LinkTopic       =   "Form3"
   ScaleHeight     =   8475
   ScaleWidth      =   9450
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkUseHex 
      Caption         =   "Hex Output"
      Height          =   255
      Left            =   2640
      TabIndex        =   18
      Top             =   3720
      Width           =   1515
   End
   Begin VB.CommandButton cmdAbort 
      Caption         =   "Abort"
      Height          =   435
      Left            =   4200
      TabIndex        =   17
      Top             =   7920
      Width           =   1515
   End
   Begin VB.Frame fraRegex 
      Caption         =   "Regex"
      Height          =   675
      Left            =   2040
      TabIndex        =   12
      Top             =   60
      Width           =   7155
      Begin VB.TextBox txtFuncRegex 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   5100
         TabIndex        =   16
         Text            =   "\((.*?)\)"
         Top             =   240
         Width           =   1935
      End
      Begin VB.TextBox txtNumeric 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   900
         TabIndex        =   14
         Text            =   "\([0-9\*\+ ]+\)"
         Top             =   240
         Width           =   2295
      End
      Begin VB.Label Label5 
         Caption         =   "Function funcName && "
         Height          =   255
         Left            =   3480
         TabIndex        =   15
         Top             =   300
         Width           =   1635
      End
      Begin VB.Label Label4 
         Caption         =   "Numeric"
         Height          =   315
         Left            =   180
         TabIndex        =   13
         Top             =   300
         Width           =   615
      End
   End
   Begin MSComctlLib.ProgressBar pb 
      Height          =   315
      Left            =   120
      TabIndex        =   11
      Top             =   4080
      Width           =   9195
      _ExtentX        =   16219
      _ExtentY        =   556
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.CommandButton cmdHandleNumericExpansions 
      Caption         =   "Find Numeric Expansions"
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   3600
      Width           =   2415
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   1080
      TabIndex        =   7
      Top             =   7380
      Width           =   8115
   End
   Begin VB.TextBox Text1 
      Height          =   315
      Left            =   1080
      TabIndex        =   6
      Top             =   6960
      Width           =   8115
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Update Parent Script"
      Height          =   435
      Left            =   7080
      TabIndex        =   5
      Top             =   7920
      Width           =   2175
   End
   Begin VB.CommandButton cmdTest 
      Caption         =   "Test Decoder"
      Height          =   375
      Left            =   4620
      TabIndex        =   4
      Top             =   3600
      Width           =   1275
   End
   Begin VB.CommandButton cmdParse 
      Caption         =   "Extract Calls from main script and eval"
      Height          =   375
      Left            =   6000
      TabIndex        =   3
      Top             =   3600
      Width           =   3255
   End
   Begin MSScriptControlCtl.ScriptControl sc 
      Left            =   120
      Top             =   7740
      _ExtentX        =   1005
      _ExtentY        =   1005
      Language        =   "javascript"
   End
   Begin VB.TextBox txtDecoder 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2655
      Left            =   60
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   2
      Text            =   "frmInlineDecoderCalls.frx":0000
      Top             =   840
      Width           =   9195
   End
   Begin MSComctlLib.ListView lv 
      Height          =   2295
      Left            =   60
      TabIndex        =   0
      Top             =   4560
      Width           =   9195
      _ExtentX        =   16219
      _ExtentY        =   4048
      View            =   3
      LabelEdit       =   1
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   3
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "offset"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "call"
         Object.Width           =   7056
      EndProperty
      BeginProperty ColumnHeader(3) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   2
         Text            =   "eval"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.Label Label3 
      Caption         =   "Evaled"
      Height          =   195
      Left            =   180
      TabIndex        =   9
      Top             =   7380
      Width           =   795
   End
   Begin VB.Label Label2 
      Caption         =   "Extracted"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   6960
      Width           =   795
   End
   Begin VB.Label Label1 
      Caption         =   "Decoder Function: (script text)"
      Height          =   255
      Left            =   60
      TabIndex        =   1
      Top             =   480
      Width           =   2715
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Begin VB.Menu mnuClearList 
         Caption         =   "Clear List"
      End
      Begin VB.Menu mnuDeleteSelected 
         Caption         =   "Delete Selected"
      End
      Begin VB.Menu mnuTweakRegex 
         Caption         =   "Tweak Regex"
      End
   End
End
Attribute VB_Name = "frmInlineDecoderCalls"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim d As New RegExp
Dim mc As MatchCollection
Dim abort As Boolean

Private Sub cmdAbort_Click()
    abort = True
End Sub

Private Sub cmdHandleNumericExpansions_Click()
    
    On Error Resume Next
    
    d.Pattern = txtNumeric '"\([0-9\*\+ ]+\)"
    d.Global = True
    
    Dim m As match
    Dim li As ListItem
    Dim i As Long
    
    lv.ListItems.Clear
    Set mc = d.Execute(Form2.txtJS.Text)
    x = mc.Count
    abort = False
    
    For Each m In mc
        If abort Then Exit For
        Set li = lv.ListItems.Add(, , m.FirstIndex)
        li.SubItems(1) = m.Value
        li.tag = m.Length
        tmp = sc.eval(li.SubItems(1))
        If chkUseHex.Value Then
            Err.Clear
            li.SubItems(2) = "0x" & Hex(tmp)
            If Err.Number <> 0 Then li.SubItems(2) = tmp
        Else
            li.SubItems(2) = tmp
        End If
        li.Ghosted = True
        li.EnsureVisible
        i = i + 1
        setPB i, mc.Count
    Next
    
    pb.Value = 0
    
    
End Sub

Private Sub cmdParse_Click()
    On Error Resume Next
    Dim funcName As String
    
    x = txtDecoder.Text
    a = InStr(1, x, "function ", vbTextCompare)
    If a > 0 Then
        b = InStr(a, x, "(")
        If b > 0 Then
            funcName = Mid(x, a, b - a)
            funcName = Replace(funcName, "function ", Empty)
        End If
    End If
    
    If Len(funcName) = 0 Then
        MsgBox "Could not parse function name from decoder textbox? you must tell me which decoder function to use."
        Exit Sub
    End If
    
   'MsgBox funcName
    
    d.Pattern = funcName & txtFuncRegex '"\((.*?)\)"
    d.Global = True
    
    Dim m As match
    Dim li As ListItem
    Dim i As Long
    
    lv.ListItems.Clear
    Set mc = d.Execute(Form2.txtJS.Text)
    x = mc.Count
    
    pb.Value = 0
    i = 0
    
    sc.AddCode txtDecoder
    abort = False
    
    For Each m In mc
        If abort Then Exit For
        Set li = lv.ListItems.Add(, , m.FirstIndex)
        li.SubItems(1) = m.Value
        li.tag = m.Length
        tmp = sc.eval(li.SubItems(1))
        li.SubItems(2) = tmp
        li.EnsureVisible
        i = i + 1
        setPB i, mc.Count
    Next
    
    pb.Value = 0
     

End Sub

Private Sub cmdTest_Click()
    On Error Resume Next
    tmp = "decoder('#o]l[o]m.e0g]b[if.[o0atp[sr.d0r.1#S]e.f0eaf0r]g[a0umfx]mf[pe.1',8609,211)"
    If Not isIde() Then tmp = Empty
    x = InputBox("Enter a sample decoder call to test output:", , tmp)
    sc.AddCode txtDecoder.Text
    MsgBox sc.eval(x)
    If Err.Number <> 0 Then
        MsgBox "Error: " & sc.error.Description & " Line:" & sc.error.line
    End If
End Sub

Private Sub Command1_Click()
    On Error Resume Next
    Dim li As ListItem
    Dim i As Long
    
    x = Form2.txtJS.Text
    pb.Value = 0
    abort = False
    
    For Each li In lv.ListItems
        If abort Then Exit Sub
        If Len(li.SubItems(2)) > 0 Then
            If li.Ghosted Then
                x = Replace(x, li.SubItems(1), "(" & li.SubItems(2) & ")", , , vbBinaryCompare)
            Else
                x = Replace(x, li.SubItems(1), """" & li.SubItems(2) & """", , , vbBinaryCompare)
            End If
        End If
        i = i + 1
        setPB i, lv.ListItems.Count
    Next
    
    Form2.SaveToListView Form2.txtJS.Text, "Before Strip Inline" 'save a copy of the original
    Form2.txtJS.Text = x
    'Unload Me
    
End Sub

Private Function setPB(cur As Long, max As Long)
    On Error Resume Next
    pb.Value = CInt((cur / max) * 100)
    DoEvents
    Me.Refresh
End Function

Private Sub Form_Load()
    On Error Resume Next
    fraRegex.Visible = isIde()
    Me.Icon = Form1.Icon
    If Not isIde() Then txtDecoder = Empty
    mnuPopup.Visible = False
    x = Form2.txtJS.SelText
    If Len(x) > 0 And Len(x) < 1000 Then txtDecoder.Text = x
    lv.ColumnHeaders(lv.ColumnHeaders.Count).Width = lv.Width - lv.ColumnHeaders(lv.ColumnHeaders.Count).left - 150
End Sub

Private Sub lv_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Dim lineNum As Long
    Text1 = Item.SubItems(1)
    Text2 = Item.SubItems(2)
    lineNum = Form2.txtJS.SCI.DirectSCI.LineFromPosition(CLng(Item.Text))
    Form2.txtJS.GotoLineCentered lineNum, False
    Form2.txtJS.SelStart = Item.Text
    Form2.txtJS.SelLength = Item.tag
End Sub

Private Sub lv_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Button = 2 Then PopupMenu mnuPopup
End Sub

Private Sub mnuClearList_Click()
    lv.ListItems.Clear
End Sub

Private Sub mnuDeleteSelected_Click()
    On Error Resume Next
    For i = lv.ListItems.Count To 1 Step -1
        If lv.ListItems(i).selected Then lv.ListItems.Remove i
    Next
End Sub

Private Sub mnuTweakRegex_Click()
    fraRegex.Visible = Not fraRegex.Visible
End Sub
