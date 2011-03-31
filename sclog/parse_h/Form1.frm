VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form Form1 
   Caption         =   "Header File Parser"
   ClientHeight    =   8550
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9480
   LinkTopic       =   "Form1"
   ScaleHeight     =   8550
   ScaleWidth      =   9480
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdView 
      Caption         =   "View"
      Height          =   255
      Left            =   8400
      TabIndex        =   13
      Top             =   0
      Width           =   915
   End
   Begin VB.TextBox txtMarker2 
      Height          =   315
      Left            =   7680
      TabIndex        =   12
      Text            =   "WINAPI"
      Top             =   360
      Width           =   1395
   End
   Begin VB.TextBox txtMarker1 
      Height          =   315
      Left            =   5340
      TabIndex        =   11
      Text            =   "WINBASEAPI"
      Top             =   360
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Find"
      Height          =   315
      Left            =   2760
      TabIndex        =   9
      Top             =   360
      Width           =   1095
   End
   Begin VB.TextBox Text3 
      Height          =   315
      Left            =   900
      TabIndex        =   8
      Top             =   360
      Width           =   1515
   End
   Begin MSComctlLib.ListView lv 
      Height          =   2235
      Left            =   0
      TabIndex        =   6
      Top             =   720
      Width           =   9435
      _ExtentX        =   16642
      _ExtentY        =   3942
      View            =   3
      MultiSelect     =   -1  'True
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
         Text            =   "Args"
         Object.Width           =   2540
      EndProperty
      BeginProperty ColumnHeader(2) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         SubItemIndex    =   1
         Text            =   "Proto"
         Object.Width           =   14111
      EndProperty
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Generate"
      Height          =   315
      Left            =   8160
      TabIndex        =   5
      Top             =   3000
      Width           =   1215
   End
   Begin VB.CommandButton cmdLoad 
      Caption         =   "Load"
      Height          =   255
      Left            =   7380
      TabIndex        =   4
      Top             =   0
      Width           =   855
   End
   Begin VB.TextBox txtHeader 
      Height          =   255
      Left            =   900
      OLEDropMode     =   1  'Manual
      TabIndex        =   3
      Top             =   0
      Width           =   6315
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   6
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2535
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   1
      Top             =   5940
      Width           =   9435
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Terminal"
         Size            =   6
         Charset         =   255
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2535
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   3360
      Width           =   9435
   End
   Begin VB.Label Label3 
      Caption         =   "Marker 1                                       Marker2"
      Height          =   315
      Left            =   4620
      TabIndex        =   10
      Top             =   360
      Width           =   4695
   End
   Begin VB.Label Label2 
      Caption         =   "Note! just a quick convience tool for std win32 api...generated output still needs manual fixup always :P"
      Height          =   315
      Left            =   120
      TabIndex        =   7
      Top             =   3000
      Width           =   7575
   End
   Begin VB.Label Label1 
      Caption         =   "Header File"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Width           =   915
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 
Dim index As Long

Private Sub cmdView_Click()
    
    If Not FileExists(txtHeader) Then
        MsgBox "File not found"
        Exit Sub
    End If
    
    On Error Resume Next
    Shell "notepad """ & txtHeader & """", vbNormalFocus
    
End Sub

Private Sub Command2_Click()
        
    If index = 0 Then index = 1
    
    For i = index To lv.ListItems.Count
        If InStr(1, lv.ListItems(i).SubItems(1), Text3, vbTextCompare) > 0 Then
            lv.ListItems(i).Selected = True
            lv.ListItems(i).EnsureVisible
            index = i
            Exit Sub
        End If
    Next
        
    If index >= lv.ListItems.Count Then
        MsgBox "No more found"
        index = 1
    End If
    
End Sub



Private Sub cmdLoad_Click()
    
    If Not FileExists(txtHeader) Then
        MsgBox "File not foudn to parse!"
        Exit Sub
    End If
    
    x = Split(ReadFile(txtHeader), vbCrLf)
    
    Dim ret() As String
    Dim active  As Boolean
    Dim inArgs As Boolean
    Dim setArg As Boolean
    Dim argI As Integer
    Dim li As ListItem
    
    For i = 0 To UBound(x)
        If x(i) = txtMarker1 Then
            active = True
            push ret, ""
        ElseIf active Then
        
            If x(i) = "LONG" Then x(i) = "int"
            
            If x(i) = txtMarker2 Then
                x(i) = "__stdcall"
                setArg = True
            End If
            
                 
            If inArgs Then
                x(i) = Trim(x(i))
                If InStr(x(i), " ") > 0 And InStr(x(i), "(") < 1 Then
                    ptr = False
                    f = Split(x(i), " ")
                    If InStr(f(UBound(f)), "*") > 0 Then ptr = True
                    f(UBound(f)) = "a" & argI & IIf(InStr(x(i + 1), ");") > 0, "", ",")
                    If ptr Then f(UBound(f)) = "*" & f(UBound(f))
                    ptr = False
                    argI = argI + 1
                    x(i) = Join(f, " ")
                End If
            End If
                    
                    
            addtop ret, x(i)
                
                
            If setArg Then
                argI = 0
                setArg = False
                inArgs = True
            End If
            
            If InStr(x(i), ");") > 0 Then
                Set li = lv.ListItems.Add(, , argI - 1)
                li.SubItems(1) = Trim(ret(UBound(ret)))
                li.SubItems(1) = Mid(li.SubItems(1), 1, Len(li.SubItems(1)) - 1)
                active = False
                inArgs = False
                argI = False
            End If

            
        End If
    Next
    
    
    
    
        
End Sub



'HANDLE __stdcall My_CreateFileA(LPCSTR a0,DWORD a1,DWORD a2,LPSECURITY_ATTRIBUTES a3,DWORD a4,DWORD a5,HANDLE a6)
'{
'
'    AddAddr( SCOffset() );
'    LogAPI("CreateFileA(%s)\n", a0);
'
'    HANDLE ret = 0;
'    try{
'        ret = Real_CreateFileA(a0, a1, a2, a3, a4, a5, a6);
'    }
'    catch(...){
'
'    }
'
'    return ret;
'}
Private Sub Command1_Click()
    Dim li As ListItem
    Dim x() As String
    Dim y() As String
    
    For Each li In lv.ListItems
        If li.Selected Then
            
            arglist = ""
            fxname = ""
            For i = 0 To li.Text
                arglist = arglist & "a" & i & ","
            Next
            
            tmp = li.SubItems(1)
            a = InStr(tmp, "__stdcall")
            b = InStr(tmp, "(")
            If a > 0 And b > 0 Then
                a = a + Len("__stdcall")
                fxname = Mid(tmp, a + 1, b - a - 1)
            End If
            
            If Len(arglist) > 0 Then arglist = Mid(arglist, 1, Len(arglist) - 1)
            
            tmp = Replace(li.SubItems(1), fxname, "My_" & fxname)
        
            push y, "ADD_THUNK( " & Replace(Replace(tmp, "My_", "Real_"), ");", ")") & " );"
            
            
            
            tmp = tmp & vbCrLf & "{" & vbCrLf & vbTab & _
                    "AddAddr( SCOffset() );" & vbCrLf & vbTab & _
                    "LogAPI(""" & fxname & "()"");" & vbCrLf & vbCrLf & vbTab & _
                    Mid(tmp, 1, InStr(tmp, " ")) & " ret = 0;" & vbCrLf & vbTab & _
                    "try{" & vbCrLf & vbTab & vbTab & _
                    "ret = Real_" & fxname & "(" & arglist & ");" & vbCrLf & vbTab & "};" & vbCrLf & vbTab & _
                    "catch(...){}" & vbCrLf & vbCrLf & vbTab & "return ret;" & vbCrLf & "}"
                    
            push x, tmp
        End If
                       
     Next
        
            
        Text1 = Join(x, vbCrLf)
        Text2 = Join(y, vbCrLf)
    
End Sub



Private Sub Form_Load()
    
    txtHeader = "C:\Program Files\Microsoft Visual Studio\VC98\Include\Winbase.h"
    
End Sub

 
Private Sub txtHeader_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, y As Single)
    txtHeader = Data.Files(1)
End Sub



Function ReadFile(filename)
  f = FreeFile
  temp = ""
   Open filename For Binary As #f        ' Open file.(can be text or image)
     temp = Input(FileLen(filename), #f) ' Get entire Files data
   Close #f
   ReadFile = temp
End Function

Function FileExists(path) As Boolean
  If Dir(path, vbHidden Or vbNormal Or vbReadOnly Or vbSystem) <> "" Then FileExists = True _
  Else FileExists = False
End Function

Sub addtop(ary, value)
    ary(UBound(ary)) = ary(UBound(ary)) & " " & value
End Sub

Sub push(ary, value) 'this modifies parent ary object
    On Error GoTo init
    x = UBound(ary) '<-throws Error If Not initalized
    ReDim Preserve ary(UBound(ary) + 1)
    ary(UBound(ary)) = value
    Exit Sub
init:     ReDim ary(0): ary(0) = value
End Sub

