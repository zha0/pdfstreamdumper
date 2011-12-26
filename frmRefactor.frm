VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmRefactor 
   Caption         =   "Form3"
   ClientHeight    =   7050
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14715
   LinkTopic       =   "Form3"
   ScaleHeight     =   7050
   ScaleWidth      =   14715
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox chkUseOriginalText 
      Caption         =   "Use Original Text"
      Height          =   375
      Left            =   6720
      TabIndex        =   9
      Top             =   360
      Width           =   1815
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Save && Exit"
      Height          =   375
      Left            =   12720
      TabIndex        =   8
      Top             =   360
      Width           =   1935
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Clear OverRides"
      Height          =   375
      Left            =   10440
      TabIndex        =   7
      Top             =   360
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Apply OverRides"
      Height          =   375
      Left            =   8640
      TabIndex        =   5
      Top             =   360
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Manually Refactor Again"
      Height          =   375
      Left            =   2160
      TabIndex        =   3
      Top             =   360
      Width           =   1935
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6135
      Left            =   8640
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   2
      Top             =   840
      Width           =   6015
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   6135
      Left            =   2160
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   840
      Width           =   6375
   End
   Begin MSComctlLib.ListView lv 
      Height          =   3495
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   6165
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
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Text            =   "Functions"
         Object.Width           =   2540
      EndProperty
   End
   Begin MSComctlLib.ListView lvArgs 
      Height          =   3495
      Left            =   0
      TabIndex        =   4
      Top             =   3480
      Width           =   2055
      _ExtentX        =   3625
      _ExtentY        =   6165
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
         Text            =   "LocalArgs"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "NewName"
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Still very messy this is a hard task"
      Height          =   495
      Left            =   2400
      TabIndex        =   6
      Top             =   120
      Width           =   3975
   End
End
Attribute VB_Name = "frmRefactor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Author:   dzzie@yahoo.com
'Site:     http://sandsprite.com

Public funcs As Collection
Dim selli As ListItem
Public global_script  As CFunc

Private Sub chkUseOriginalText_Click()
    
    If selli Is Nothing Then
        MsgBox "No function selected in listview"
        Exit Sub
    End If
    
    Dim f As CFunc
    Set f = selli.tag
    
    f.UseOriginalText = IIf(chkUseOriginalText.Value = 1, True, False)
    selli.ForeColor = IIf(f.UseOriginalText, vbBlue, vbBlack)
    
End Sub


Private Sub Command4_Click()
    'save and exit
    
    Dim f As CFunc
    
    If global_script.UseOriginalText Then
        Complete = global_script.OrgText
    ElseIf global_script.OverRides.Count > 0 Then
        Complete = global_script.OverRideScript
    Else
        Complete = global_script.CleanText
    End If
    
    For Each f In funcs
        If f.UseOriginalText Then
            'ok so they dont want to use the refactored code..but the function name must change.
            tmp = Split(f.OrgText, vbCrLf)
            p1 = InStr(1, tmp(0), "(")
            fxname = Mid(tmp(0), 1, p1 - 1)
            rest = Mid(tmp(0), p1)
            tmp(0) = "function " & f.NewName & rest
            UpdatedOrg = Join(tmp, vbCrLf)
            Complete = Replace(Complete, "__function_" & f.Index & "_placeholder", UpdatedOrg)
        ElseIf f.OverRides.Count > 0 Then
            Complete = Replace(Complete, "__function_" & f.Index & "_placeholder", f.OverRideScript)
        Else
            Complete = Replace(Complete, "__function_" & f.Index & "_placeholder", f.CleanText)
        End If
    Next
    
    Form2.txtJS.Text = Complete
    Unload Me
    
End Sub

Private Sub Command1_Click()
    
    'manually refactor
    
    If selli Is Nothing Then
        MsgBox "No function selected in listview"
        Exit Sub
    End If
    
    Dim f As CFunc
    Set f = selli.tag

    Text1 = f.OrgText
    
    f.debugOut = True
    f.ResetParse
    f.ParseSelf
    
    LoadArgsLv f
    
    Text2 = f.CleanText
    
    
End Sub

Function LoadArgsLv(f As CFunc)
    
    Dim li As ListItem
    
    lvArgs.ListItems.Clear
    i = 0
    For Each v In f.OrgVars
        vnew = IIf(f.IsGlobal, "gvar_" & i, "v" & i)
        overRide = f.OverrideExists(i)

        Set li = lvArgs.ListItems.Add(, , vnew & " = " & v)
        If Len(overRide) > 0 Then li.SubItems(1) = overRide
        
        i = i + 1
    Next
    
End Function

Function LoadFunctions(scriptIn As String, Optional debugMode As Boolean = False) As String
    'assumes we are receiving js beautified text
    
    Dim j As Long
    Dim jj As Long
    Dim b() As String
    Dim x
    Dim f As CFunc
    Dim li As ListItem
    
    Set funcs = New Collection

    a = vbCrLf & scriptIn
    
    a = Replace(a, vbCrLf, " " & vbCrLf) 'add a space to end of each line
    
    fstart = InStr(a, vbCrLf & "function") 'first we parse out all the function names
    While fstart > 0
        fstart = fstart + 2
        fend = InStr(fstart, a, vbCrLf & "} " & vbCrLf)
        If fend > 0 Then
            Set f = New CFunc
            Set f.ParentForm = Me
            f.OrgText = Mid(a, fstart, fend - fstart + 3)
            funcs.Add f
            f.Index = funcs.Count
            f.ParseName
            Set li = lv.ListItems.Add(, , f.NewName & " = " & f.OrgName)
            Set li.tag = f
        End If
        fstart = InStr(fstart + 10, a, vbCrLf & "function")
    Wend
        
    Set global_script = New CFunc
    
    For Each li In lv.ListItems 'remove all function blocks from global script block
        Set f = li.tag
        a = Replace(a, f.OrgText, "__function_" & f.Index & "_placeholder")
    Next
    
    global_script.IsGlobal = True
    Set global_script.ParentForm = Me
    global_script.OrgText = a
    global_script.ParseAsGlobal
    Set li = lv.ListItems.Add(, , "global_script")
    Set li.tag = global_script
    
    For Each li In lv.ListItems 'this has to be last in case functions use global variables
        Set f = li.tag
        f.ParseSelf
    Next
    
    
    If debugMode Then
        Me.Visible = True
    End If
    
    
     
    
End Function

 

Private Sub Command2_Click()
    
    Dim li As ListItem
    Dim didSomething As Boolean
    
    If selli Is Nothing Then
        MsgBox "No function selected in listview"
        Exit Sub
    End If
    
    Dim f As CFunc
    Set f = selli.tag

    Set f.OverRides = New Collection
    
    For Each li In lvArgs.ListItems
        If Len(li.tag) > 0 Then
            didSomething = True
            tmp = Split(li.Text, " = ")
            f.OverRides.Add tmp(0) & "->" & li.tag
        End If
    Next
    
    If Not didSomething Then
        MsgBox "You havent set any overrides yet. double click on the var you want to change in lower listbox"
    Else
        Text2 = f.ApplyOverrides
    End If
    
End Sub

Private Sub Command3_Click()
    
    If selli Is Nothing Then
        MsgBox "No function selected in listview"
        Exit Sub
    End If
    
    Dim f As CFunc
    Set f = selli.tag

    Set f.OverRides = New Collection
    Text2 = f.CleanText
    
End Sub



Private Sub Form_Load()
Me.Icon = Form1.Icon
End Sub

Private Sub lv_ItemClick(ByVal Item As MSComctlLib.ListItem)

    Dim f As CFunc
    Set selli = Item
    Set f = Item.tag
    Text1 = f.OrgText
    
    If f.OverRides.Count > 0 Then
        Text2 = f.OverRideScript
    Else
        Text2 = f.CleanText
    End If
    
    If f.IsGlobal Then
        chkUseOriginalText.enabled = False 'if you dont want to refactor main script whats the point to much would break
        chkUseOriginalText.Value = 0
    Else
        chkUseOriginalText.enabled = True
        chkUseOriginalText.Value = IIf(f.UseOriginalText, 1, 0)
    End If
    
    LoadArgsLv f
    
End Sub

Private Sub lvArgs_ItemClick(ByVal Item As MSComctlLib.ListItem)
    x = InputBox("Override default variable name with your own?")
    If Len(x) = 0 Then Exit Sub
    Item.tag = x
    Item.SubItems(1) = x
End Sub
