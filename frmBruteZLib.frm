VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "mscomctl.ocx"
Begin VB.Form frmBruteZLib 
   Caption         =   "Zlib Brute Forcer - find zlib compressed sections of file"
   ClientHeight    =   8055
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14175
   LinkTopic       =   "Form1"
   ScaleHeight     =   8055
   ScaleWidth      =   14175
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdStop 
      Caption         =   "Stop"
      Height          =   330
      Left            =   13230
      TabIndex        =   9
      Top             =   45
      Width           =   825
   End
   Begin MSComctlLib.ProgressBar pb 
      Height          =   240
      Left            =   90
      TabIndex        =   8
      Top             =   450
      Width           =   13920
      _ExtentX        =   24553
      _ExtentY        =   423
      _Version        =   393216
      Appearance      =   0
   End
   Begin VB.CommandButton Command3 
      Caption         =   "?"
      Height          =   330
      Left            =   11565
      TabIndex        =   7
      Top             =   45
      Width           =   465
   End
   Begin RichTextLib.RichTextBox rtf 
      Height          =   5280
      Left            =   3150
      TabIndex        =   6
      Top             =   2565
      Width           =   10905
      _ExtentX        =   19235
      _ExtentY        =   9313
      _Version        =   393217
      Enabled         =   -1  'True
      ScrollBars      =   2
      TextRTF         =   $"frmBruteZLib.frx":0000
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton Command2 
      Caption         =   "..."
      Height          =   330
      Left            =   11025
      TabIndex        =   5
      Top             =   45
      Width           =   465
   End
   Begin VB.TextBox txtDetails 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1725
      Left            =   3150
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   720
      Width           =   10905
   End
   Begin MSComctlLib.ListView lv 
      Height          =   7125
      Left            =   90
      TabIndex        =   3
      Top             =   720
      Width           =   2985
      _ExtentX        =   5265
      _ExtentY        =   12568
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
      NumItems        =   1
      BeginProperty ColumnHeader(1) {BDD1F052-858B-11D1-B16A-00C0F0283628} 
         Object.Width           =   2540
      EndProperty
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Zlib Brute"
      Height          =   330
      Left            =   12060
      TabIndex        =   2
      Top             =   45
      Width           =   1140
   End
   Begin VB.TextBox txtFile 
      Height          =   330
      Left            =   810
      OLEDropMode     =   1  'Manual
      TabIndex        =   1
      Text            =   "Drag And Drop file here"
      Top             =   45
      Width           =   10140
   End
   Begin VB.Label Label1 
      Caption         =   "Load File"
      Height          =   285
      Left            =   45
      TabIndex        =   0
      Top             =   45
      Width           =   870
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "mnuPopup"
      Visible         =   0   'False
      Begin VB.Menu mnuStrings 
         Caption         =   "Strings"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuSearchStreams 
         Caption         =   "Search Streams"
      End
      Begin VB.Menu mnuSaveToFile 
         Caption         =   "Save Stream"
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu mnuSpacer 
         Caption         =   "-"
      End
      Begin VB.Menu mnuReplaceStream 
         Caption         =   "Replace Stream"
      End
      Begin VB.Menu mnuCopyAllStats 
         Caption         =   "Copy Stats for all Streams"
      End
   End
End
Attribute VB_Name = "frmBruteZLib"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim selli As ListItem
Dim abort As Boolean

Private Sub cmdStop_Click()
    abort = True
End Sub

Private Sub Command1_Click()
    
    If Not fso.FileExists(txtFile) Then Exit Sub
    
    On Error Resume Next
    
    If Not csharp.Initilized Then
        MsgBox csharp.ErrorMessage, vbExclamation
        Exit Sub
    End If
    
    Dim f As Long
    Dim b() As Byte
    Dim bOut() As Byte
    Dim tmp() As Byte
    Dim d As String
    
    Dim c As CPDFStream
    
    Dim li As ListItem
    Dim i As Long
    
    abort = False
    lv.ListItems.Clear
    pb.Value = 0
    rtf.Text = Empty
    txtDetails = Empty
    
    f = FreeFile
    Open txtFile For Binary As f
    ReDim b(LOF(f))
    Get f, , b()
    Close f
    
    'this can be horrbily slow on large byte buffers since we are doing it all as string
    'manipulations and then converting back and forth ALLOT..I should optimize this to make it faster
    'but this is just an add on right now using existing code, this can be much improved..but for now
    'it is what it is...the native zlib class didnt work for this for some reason. would be way faster
    
    d = StrConv(b, vbUnicode, LANG_US)
    
    For i = 0 To UBound(b)
    
        csharp.decode Mid(d, i), FlateDecode
        
        'Module4.UncompressData b, bout, i
        setPB i, UBound(b)
        DoEvents
        Me.Refresh
        DoEvents
        If abort Then Exit For
        
        'If Not AryIsEmpty(bout) Then
        If Len(csharp.DecodedBuffer) > 0 Then
            bOut = StrConv(csharp.DecodedBuffer, vbFromUnicode, LANG_US)
            Module4.CompressData bOut, tmp 'figure out how big compressed block was
            Set c = New CPDFStream
            c.StartOffset = i - 1
            
            If Not AryIsEmpty(tmp) Then
                c.EndOffset = i + UBound(tmp) - 1
                Erase tmp
            Else
                c.EndOffset = 0
            End If
            
            c.DecompressedSize = UBound(bOut)
            c.DecompressedData = StrConv(bOut, vbUnicode, LANG_US)
            c.DecompressedDataCRC = CRC32(c.DecompressedData)
            
            Set li = lv.ListItems.Add(, , "offset: 0x" & Hex(c.StartOffset) & " sz: 0x" & Hex(c.DecompressedSize))
            Set li.tag = c
            
            If c.EndOffset <> 0 Then i = c.EndOffset  'advance file pointer to after this chunk
            csharp.DecodedBuffer = Empty
            
        End If
    Next
    
    pb.Value = 0
    MsgBox lv.ListItems.Count & " Streams found!", vbInformation
            
        
End Sub

Function AryIsEmpty(ary) As Boolean
    On Error Resume Next
    x = UBound(ary)
    If x = -1 Or Err.Number <> 0 Then AryIsEmpty = True
End Function

Sub setPB(i, tot)
    On Error Resume Next
    pcent = CInt((i / tot) * 100)
    If pcent >= 100 Then pb.Value = 0 Else pb.Value = pcent
End Sub

Private Sub Command2_Click()
    f = Form1.dlg.OpenDialog(AllFiles, , , Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    txtFile = f
    Command1_Click
End Sub

Private Sub Command3_Click()
    Const msg = "This interface will go through a file byte by byte trying to\n" & _
                " find sections compressed with ZLIB. Found offsets will be added to \n" & _
                "the list on the left, details on top, hexdump on bottom. Right click on \n" & _
                "listview to save data to file.\n\n" & _
                "This can be VERY slow on files over 50k because the routines are \n" & _
                "_completely_ unoptimized for this task!"
    MsgBox Replace(msg, "\n", vbCrLf), vbInformation
End Sub

Private Sub Form_Load()
    pb.Value = 0
    lv.ColumnHeaders(1).Width = lv.Width - 100
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    abort = True
End Sub

Private Sub lv_ItemClick(ByVal Item As MSComctlLib.ListItem)
    On Error Resume Next
    Dim c As CPDFStream
    
    Set selli = Nothing
    Set c = Item.tag
    
    If c Is Nothing Then Exit Sub
    
    rtf.Text = Empty
    Set selli = Item
    
    r = "Start Offset: 0x" & Hex(c.StartOffset) & " (" & c.StartOffset & ")" & vbCrLf
    r = r & "End Offset: 0x" & Hex(c.EndOffset) & " (" & c.EndOffset & ")" & vbCrLf
    r = r & "DecompressedSize: 0x" & Hex(c.DecompressedSize) & " (" & c.DecompressedSize & ")" & vbCrLf
    r = r & "DecompressedDataCRC: " & c.DecompressedDataCRC & vbCrLf
    txtDetails = r
    
    rtf.Text = HexDump(c.DecompressedData)
    
End Sub

Private Sub lv_MouseUp(Button As Integer, Shift As Integer, x As Single, Y As Single)
    If Button = 2 Then PopupMenu mnuPopup
End Sub

Private Sub mnuCopyAllStats_Click()
    On Error Resume Next
    Dim c As CPDFStream
    Dim li As ListItem
    
    If lv.ListItems.Count = 0 Then Exit Sub
    
    For Each li In lv.ListItems
        Set c = li.tag
        r = r & "Start Offset: 0x" & Hex(c.StartOffset) & " (" & c.StartOffset & ")" & vbCrLf
        r = r & "End Offset: 0x" & Hex(c.EndOffset) & " (" & c.EndOffset & ")" & vbCrLf
        r = r & "DecompressedSize: 0x" & Hex(c.DecompressedSize) & " (" & c.DecompressedSize & ")" & vbCrLf
        r = r & "DecompressedDataCRC: " & c.DecompressedDataCRC & vbCrLf & vbCrLf
    Next
    
    Clipboard.Clear
    Clipboard.SetText r
    
    MsgBox Len(r) & " bytes saved to clipboard", vbInformation
    

End Sub

Private Sub mnuReplaceStream_Click()
    
    On Error Resume Next
    Dim f As String
    Dim b() As Byte
    
    If selli Is Nothing Then Exit Sub
    
    Dim c As CPDFStream
    Set c = selli.tag
    
    MsgBox "Not yet implemented!", vbInformation
    
End Sub

Private Sub mnuSaveAll_Click()
    On Error Resume Next
    Dim c As CPDFStream
    Dim li As ListItem
    Dim d As String
    Dim f As String
    Dim ok As Long
    
    If lv.ListItems.Count = 0 Then Exit Sub
    
    d = Form1.dlg.FolderDialog(, Me.hwnd)
    If Len(d) = 0 Then Exit Sub
    
    For Each li In lv.ListItems
        Set c = li.tag
        f = d & "\zbrute_" & Hex(c.StartOffset) & ".dat"
        If fso.FileExists(f) Then Kill f
        If SaveStream(c, f) Then ok = ok + 1
    Next
    
    MsgBox ok & "/" & lv.ListItems.Count & " Streams saved successfully!", vbInformation
    
End Sub

Private Sub mnuSaveToFile_Click()
    On Error Resume Next
    Dim c As CPDFStream
    
    If selli.tag Is Nothing Then Exit Sub
    Set c = selli.tag
    f = Form1.dlg.SaveDialog(AllFiles, , "Save file as", , Me.hwnd, "zbrute_" & Hex(c.StartOffset) & ".dat")
    If Len(f) = 0 Then Exit Sub
    
    MsgBox "Saved to file: " & SaveStream(c, f)
    
End Sub

Function SaveStream(c As CPDFStream, fpath) As Boolean
    On Error Resume Next
    Dim b() As Byte
    Dim f As Long
    
    b() = StrConv(c.DecompressedData, vbFromUnicode, LANG_US)
    f = FreeFile
    Open fpath For Binary As f
    Put f, , b()
    Close f
    
    SaveStream = IIf(Err.Number = 0, True, False)
    
End Function



Private Sub mnuSearchStreams_Click()
    On Error Resume Next
    Dim c As CPDFStream
    Dim li As ListItem
    Dim d As String
    Dim f As String
    Dim ok As Long
    
    If lv.ListItems.Count = 0 Then Exit Sub
    
    d = InputBox("Search for:")
    If Len(d) = 0 Then Exit Sub
    
    For Each li In lv.ListItems
        Set c = li.tag
        ok = InStr(1, c.DecompressedData, d, vbTextCompare)
        If ok > 0 Then
            f = f & li.Text & " offset: 0x" & Hex(ok) & vbCrLf
        End If
    Next
    
    If Len(f) > 0 Then
        MsgBox "Found " & d & " in: " & vbCrLf & vbCrLf & f
    Else
        MsgBox "String fragment not found in any streams", vbInformation
    End If
    
        
End Sub

Private Sub txtFile_OLEDragDrop(Data As DataObject, Effect As Long, Button As Integer, Shift As Integer, x As Single, Y As Single)
    On Error Resume Next
    txtFile = Data.Files(1)
    Command1_Click
End Sub
