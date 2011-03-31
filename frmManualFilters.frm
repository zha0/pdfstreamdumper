VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form frmManualFilters 
   Caption         =   "Form3"
   ClientHeight    =   6945
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   14715
   LinkTopic       =   "Form3"
   ScaleHeight     =   6945
   ScaleWidth      =   14715
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdZlibDeflate 
      Caption         =   "Zlib Deflate"
      Height          =   285
      Left            =   135
      TabIndex        =   20
      Top             =   2745
      Width           =   1770
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   9
      Left            =   135
      TabIndex        =   19
      Top             =   6345
      Width           =   1815
   End
   Begin VB.CheckBox chkDebug 
      Caption         =   "Debug iText.Decode"
      Height          =   255
      Left            =   120
      TabIndex        =   18
      Top             =   2400
      Width           =   1815
   End
   Begin VB.TextBox txtHeader 
      Height          =   1095
      Left            =   2040
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   15
      Top             =   360
      Width           =   12615
   End
   Begin VB.CommandButton cmdOriginal 
      Caption         =   "Original"
      Enabled         =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   1680
      Width           =   1815
   End
   Begin VB.CheckBox chkHexdump 
      Caption         =   "Display as Hexdump"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   2040
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   8
      Left            =   120
      TabIndex        =   10
      Top             =   6000
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   9
      Top             =   5640
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   8
      Top             =   5280
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   7
      Top             =   4920
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   6
      Top             =   4560
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   5
      Top             =   4200
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   4
      Top             =   3840
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   3480
      Width           =   1815
   End
   Begin VB.CommandButton cmdDecode 
      Caption         =   "Command3"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   2
      Top             =   3120
      Width           =   1815
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Load Stream From File"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   1320
      Width           =   1815
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Load Active Stream"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   960
      Width           =   1815
   End
   Begin RichTextLib.RichTextBox txtUncompressed 
      Height          =   5295
      Left            =   2040
      TabIndex        =   11
      Top             =   1560
      Width           =   12615
      _ExtentX        =   22251
      _ExtentY        =   9340
      _Version        =   393217
      Enabled         =   -1  'True
      HideSelection   =   0   'False
      ScrollBars      =   2
      TextRTF         =   $"frmManualFilters.frx":0000
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
   Begin VB.Label lbliText 
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
      Left            =   1320
      TabIndex        =   17
      Top             =   600
      Width           =   615
   End
   Begin VB.Label label2 
      Caption         =   "iText Enabled?"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label lblBufLen 
      Caption         =   "Buffer Length: "
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   240
      Width           =   1695
   End
End
Attribute VB_Name = "frmManualFilters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim buf As String
Dim org As String



Private Sub chkHexdump_Click()
    DisplayData
End Sub

Private Function SetDecodePredictor() As Boolean
    On Error Resume Next
    x = InputBox("Enter following values seperated by commas:" & vbCrLf & vbCrLf & "predictor, columns, colors, bitsperscomponent", , "12,1,1,8")
    If Len(x) = 0 Then Exit Function
    x = Split(x, ",")
    If UBound(x) <> 3 Then
        MsgBox "not enough elements: " & UBound(x)
        Exit Function
    End If
    csharp.SetPredictorParams CInt(x(0)), x(1), x(2), x(3)
    SetDecodePredictor = True
End Function

Private Sub cmdDecode_Click(Index As Integer)
    
    On Error GoTo hell
    
    Dim dbugMode As Boolean
    
    Dim decode As Decoders
    If Len(buf) = 0 Then
        MsgBox "You have not loaded a stream yet", vbInformation
        Exit Sub
    End If
    
    If chkDebug.Value = 1 Then dbugMode = True
    
    If csharp.Initilized Then
        If Index = DecodePredictor Then
            If Not SetDecodePredictor() Then Exit Sub
        End If
        If csharp.decode(buf, CLng(Index), False, dbugMode) Then
            buf = csharp.DecodedBuffer
            DisplayData
        Else
            txtUncompressed.Text = csharp.ErrorMessage
        End If
    Else
        If Index = FlateDecode Then
            If NativeFlateDecompress(buf) Then
                DisplayData
            Else
                txtUncompressed.Text = "Zlib Flate Decode failed"
            End If
        ElseIf Index = ASCIIHexDecode Then
            'buf = unescape("%" & Replace(buf, " ", "%"))
            buf = HexStringUnescape(buf, True)
            DisplayData
        Else
            MsgBox "This filter requires .NET 2.0 or greater installed"
        End If
    End If
    
    Exit Sub
hell:     MsgBox Err.Description
End Sub

Private Function DisplayData() As String
    If chkHexdump.Value = 1 Then
        txtUncompressed.Text = HexDump(buf)
    Else
        txtUncompressed.Text = buf
    End If
    lblBufLen.Caption = "BufLen: 0x" & Hex(Len(buf))
End Function

Private Function NativeFlateDecompress(ByVal s As String) As Boolean
    Dim b() As Byte
    Dim bOut() As Byte
    
    b = StrConv(s, vbFromUnicode, LANG_US)
                
    Module4.UncompressData b(), bOut()
    
    If Not AryIsEmpty(bOut) Then
        buf = StrConv(bOut, vbUnicode, LANG_US)
        NativeFlateDecompress = True
    End If
                
End Function

 

Private Sub cmdZlibDeflate_Click()
        On Error GoTo hell
        If NativeFlateDecompress(buf) Then
            DisplayData
        Else
            txtUncompressed.Text = "Zlib Flate Decode failed"
        End If
        Exit Sub
hell:         txtUncompressed = "Error: " & Err.Description
End Sub

Private Sub Command1_Click()
    
    If Form1.selli Is Nothing Then
        MsgBox "No stream selected in main form", vbInformation
        Exit Sub
    End If
    
    On Error Resume Next
    Dim s As CPDFStream
    Set s = Form1.selli.tag
    
    If s Is Nothing Then
        MsgBox "Could not get stream from " & Form1.selli.Text
        Exit Sub
    End If
    
    If Not s.ContainsStream Then
        MsgBox "Selected object does not contain a stream.", vbInformation
        Exit Sub
    End If
    
    buf = s.OriginalData
    txtHeader.Text = IIf(Form1.mnuAutoEscapeHeaders.Checked, s.escapedHeader, s.Header)
    org = buf
    cmdOriginal.enabled = True
    DisplayData
    
End Sub

Private Sub cmdOriginal_Click()
    buf = org
    DisplayData
End Sub

Private Sub Command2_Click()
    
    On Error Resume Next
    Dim f As String
    Dim dlg As New clsCmnDlg
    
    f = dlg.OpenDialog(AllFiles, , "Open raw stream file", Me.hwnd)
    If Len(f) = 0 Then Exit Sub
    
    txtHeader.Text = "No PDF Header preview available when loading raw streams"
    org = fso.ReadFile(f)
    buf = org
    cmdOriginal.enabled = True
    DisplayData
    
End Sub

Private Sub Form_Load()
    
    Dim enabled As Boolean, i As Long
    
    For i = 0 To cmdDecode.Count - 1
        cmdDecode(i).Caption = FilterNameFromIndex(i, enabled)
        cmdDecode(i).enabled = enabled
    Next
    
    lbliText.Caption = IIf(csharp.Initilized, "True", "False")
    
    txtHeader.Text = "This form lets you manually test filters (and filter chains), display the exact error message, and watch the data transforms at each step. First load a stream then decode it. If you are working on a decode chain, you can get back to the original at any time with the original button"
    
    
End Sub

Private Sub Label1_Click()
    MsgBox "The parent buffer you are decoding gets updated each call so you can chain filters. "
End Sub

Private Sub lbliText_Click()

    MsgBox "For iText filters to be enabled you have to have: " & vbCrLf & vbCrLf & _
            "1) .NET runtime v2.0 or greater installed" & vbCrLf & _
            "2) iTextFilters dll has be correctly registered (should be done by installer" & vbCrLf & _
            "3) pdfStreamDumper has to be able to find the dll" & vbCrLf & vbCrLf & _
            "Initilization error message (if any) is: " & vbCrLf & vbCrLf & csharp.ErrorMessage, vbInformation
            
End Sub
