VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmReplace 
   Caption         =   "Find/Replace"
   ClientHeight    =   2640
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5355
   LinkTopic       =   "Form3"
   ScaleHeight     =   2640
   ScaleWidth      =   5355
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdFindAll 
      Caption         =   "Find All"
      Height          =   375
      Left            =   3960
      TabIndex        =   17
      Top             =   1800
      Visible         =   0   'False
      Width           =   1335
   End
   Begin MSComctlLib.ListView lv 
      Height          =   2655
      Left            =   5400
      TabIndex        =   16
      Top             =   0
      Visible         =   0   'False
      Width           =   4815
      _ExtentX        =   8493
      _ExtentY        =   4683
      View            =   3
      LabelEdit       =   1
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      FullRowSelect   =   -1  'True
      GridLines       =   -1  'True
      _Version        =   393217
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   2
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Line"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "Text"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.CheckBox chkUnescape 
      Caption         =   "Use %xx for hex character values"
      Height          =   240
      Left            =   1035
      TabIndex        =   15
      Top             =   945
      Width           =   2685
   End
   Begin VB.CommandButton cmdFindNext 
      Caption         =   "Find Next"
      Height          =   375
      Left            =   3960
      TabIndex        =   14
      Top             =   1350
      Width           =   1335
   End
   Begin VB.CommandButton cmdFind 
      Caption         =   "Find First"
      Height          =   375
      Left            =   3960
      TabIndex        =   13
      Top             =   900
      Width           =   1335
   End
   Begin VB.CheckBox chkCaseSensitive 
      Caption         =   "Case Sensitive"
      Height          =   255
      Left            =   2040
      TabIndex        =   11
      Top             =   2160
      Width           =   1695
   End
   Begin VB.OptionButton Option2 
      Caption         =   "Selection"
      Height          =   255
      Left            =   2040
      TabIndex        =   10
      Top             =   1440
      Width           =   1815
   End
   Begin VB.OptionButton Option1 
      Caption         =   "Whole Text"
      Height          =   255
      Left            =   2040
      TabIndex        =   9
      Top             =   1800
      Value           =   -1  'True
      Width           =   1695
   End
   Begin VB.TextBox Text4 
      Height          =   285
      Left            =   600
      TabIndex        =   7
      Top             =   1920
      Width           =   975
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   600
      TabIndex        =   6
      Top             =   1440
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Replace"
      Height          =   375
      Left            =   3960
      TabIndex        =   4
      Top             =   2250
      Width           =   1335
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   960
      TabIndex        =   3
      Top             =   480
      Width           =   4335
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   960
      TabIndex        =   1
      Top             =   0
      Width           =   4335
   End
   Begin VB.Label lblSelSize 
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   1200
      Width           =   2415
   End
   Begin VB.Label Label5 
      Caption         =   "Hex"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1920
      Width           =   615
   End
   Begin VB.Label Label4 
      Caption         =   "Char"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1440
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Replace"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   600
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Find"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1215
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Visible         =   0   'False
      Begin VB.Menu mnuCopyAll 
         Caption         =   "Copy All"
      End
   End
End
Attribute VB_Name = "frmReplace"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Author:   dzzie@yahoo.com
'Site:     http://sandsprite.com

Public active_object As Object
Dim lastkey As Integer
Dim lastIndex As Long
Dim lastsearch As String

Private Declare Sub SetWindowPos Lib "user32" (ByVal hwnd As Long, ByVal hWndInsertAfter As Long, ByVal x As Long, ByVal Y As Long, ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long)
Private Const HWND_TOPMOST = -1
Private Const HWND_NOTOPMOST = -2
Private Const SWP_SHOWWINDOW = &H40

Dim selli As ListItem



Private Sub cmdFind_Click()
    
    On Error Resume Next
    
    If chkUnescape.Value = 1 Then
        f = unescape(Text1)
    Else
        f = Text1
    End If
    
    lastsearch = f
    
    Dim compare As VbCompareMethod
    
    If chkCaseSensitive.Value = 1 Then
        compare = vbBinaryCompare
    Else
        compare = vbTextCompare
    End If
    
    x = InStr(1, active_object.Text, lastsearch, compare)
    If x > 0 Then
        lastIndex = x + 2
        active_object.SelStart = x - 1
        active_object.SelLength = Len(lastsearch)
        active_object.GotoLine active_object.CurrentLine - 1
        active_object.SelectLine
        Me.Caption = "Line: " & active_object.CurrentLine & " CharPos: " & active_object.SelStart
    Else
        lastIndex = 1
    End If
    
End Sub


Public Sub cmdFindAll_Click()
    On Error Resume Next
    If Me.Width < 10440 Then Me.Width = 10440
    lv.ColumnHeaders(2).Width = lv.Width - lv.ColumnHeaders(1).left - 100
    lv.ListItems.Clear
    lv.Visible = True
    
    If chkUnescape.Value = 1 Then
        f = unescape(Text1)
    Else
        f = Text1
    End If
    
    Dim compare As VbCompareMethod
    
    If chkCaseSensitive.Value = 1 Then
        compare = vbBinaryCompare
    Else
        compare = vbTextCompare
    End If
    
    lastIndex = 1
    lastsearch = f
    x = 1
    
    If Len(f) = 0 Then Exit Sub
    
    Dim li As ListItem
    
    Do While x > 0
    
        x = InStr(lastIndex, active_object.Text, lastsearch, compare)
    
        If x + 2 = lastIndex Or x < 1 Or x > Len(active_object.Text) Then
            Exit Do
        Else
            lastIndex = x + 2
            active_object.SelStart = x - 1
            active_object.SelLength = Len(lastsearch)
            Set li = lv.ListItems.Add(, , active_object.CurrentLine - 1)
            li.SubItems(1) = Replace(Trim(active_object.GetLineText(li.Text + 1)), vbTab, Empty)
            li.SubItems(1) = Replace(li.SubItems(1), vbCrLf, Empty)
        End If
        
    Loop
    
    Me.Caption = lv.ListItems.Count & " items found!"
    
End Sub

Private Sub cmdFindNext_Click()
    
    On Error Resume Next
    
    If chkUnescape.Value = 1 Then
        f = unescape(Text1)
    Else
        f = Text1
    End If
    
    If lastsearch <> f Then
        cmdFind_Click
        Exit Sub
    End If
    
    If lastIndex >= Len(active_object.Text) Then
        MsgBox "Reached End of text no more matches", vbInformation
        Exit Sub
    End If
    
    Dim compare As VbCompareMethod
    
    If chkCaseSensitive.Value = 1 Then
        compare = vbBinaryCompare
    Else
        compare = vbTextCompare
    End If
    
    x = InStr(lastIndex, active_object.Text, lastsearch, compare)
    
    If x + 2 = lastIndex Or x < 1 Then
        MsgBox "No more matches found", vbInformation
        Exit Sub
    Else
        lastIndex = x + 2
        active_object.SelStart = x - 1
        active_object.SelLength = Len(lastsearch)
        active_object.GotoLine active_object.CurrentLine - 1
        active_object.SelectLine
        Me.Caption = "Line: " & active_object.CurrentLine & " CharPos: " & active_object.SelStart
    End If
    
    
End Sub

Private Sub Command1_Click()
    
    On Error Resume Next
    
    If chkUnescape.Value = 1 Then
        f = unescape(Text1)
    Else
        f = Text1
    End If
    
    If chkUnescape.Value = 1 Then
        r = unescape(Text2)
    Else
        r = Text2
    End If
    
    Dim compare As VbCompareMethod
    
    If chkCaseSensitive.Value = 1 Then
        compare = vbBinaryCompare
    Else
        compare = vbTextCompare
    End If
    
    Dim curLine As Long
    Dim o As ucScint
    
    If Option1.Value Then 'whole selection
        If TypeName(active_object) = "ucScint" Then
            Set o = active_object
            curLine = o.CurrentLine
        End If
        active_object.Text = Replace(active_object.Text, f, r, , , compare)
        If curLine > 0 Then o.GotoLine curLine
    Else
        sl = active_object.SelStart
        nt = Replace(active_object.SelText, f, r, , , compare)
        active_object.SelText = nt
        active_object.SelStart = sl
        active_object.SelLength = Len(nt)
    End If
    
    lblSelSize = "Selection Size: " & Len(active_object.SelText)
    
End Sub

Public Sub LaunchReplaceForm(txtObj As Object)
    
    Set active_object = txtObj
    
    If Len(txtObj.SelText) > 1 Then
        lblSelSize = "Selection Size: " & Len(txtObj.SelText)
        'Option2.Value = True 'since we auto load selection into txtFind, and autoload last search type, this was a conflict of interest..
    End If
    
    If txtObj.Name = "txtJS" Then
        cmdFindAll.Visible = True
    End If
    
    Me.Show
    
End Sub




Private Sub Form_Load()
    Me.Icon = Form1.Icon
    FormPos Me, False
    SetWindowPos Me.hwnd, HWND_TOPMOST, Me.left / 15, Me.Top / 15, Me.Width / 15, Me.height / 15, SWP_SHOWWINDOW
    Text1 = GetMySetting("lastFind")
    Text2 = GetMySetting("lastReplace")
    If GetMySetting("wholeText", "1") = "1" Then Option1.Value = True Else Option2.Value = True
End Sub

Private Sub Form_Resize()
    On Error Resume Next
    lv.Width = Me.Width - lv.left - 200
    lv.height = Me.height - lv.Top - 300
    lv.ColumnHeaders(2).Width = lv.Width - lv.ColumnHeaders(2).left - 200
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FormPos Me, False, True
    SaveMySetting "lastFind", Text1
    SaveMySetting "lastReplace", Text2
    SaveMySetting "wholeText", IIf(Option1.Value, "1", "0")
End Sub

Private Sub lv_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Dim o As ucScint
    
    Set selli = Item
    If TypeName(active_object) = "ucScint" Then
        Set o = active_object
        o.GotoLineCentered CLng(Item.Text)
    Else
        active_object.GotoLine Item.Text
        active_object.SelectLine
    End If
    
End Sub

Private Sub lv_MouseDown(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Button = 2 Then PopupMenu mnuPopup
End Sub

Private Sub mnuCopyAll_Click()
    Dim li As ListItem
    On Error Resume Next
    Dim x As String
    For Each li In lv.ListItems
        x = x & li.Text & vbTab & li.SubItems(1) & vbCrLf
    Next
    Clipboard.Clear
    Clipboard.SetText x
    MsgBox Len(x) & " bytes copied", vbInformation
End Sub

Private Sub Text3_KeyPress(KeyAscii As Integer)
    lastkey = KeyAscii
End Sub

Private Sub Text3_KeyUp(KeyAscii As Integer, Shift As Integer)
    Dim x As String
    x = Hex(lastkey)
    If Len(x) = 1 Then x = "0" & x
    Text4 = x
    Text3 = Chr(lastkey)
End Sub
