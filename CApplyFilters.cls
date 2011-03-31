VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CApplyFilters"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public UnsupportedFilter As Boolean
Public DecompressionError As Boolean
Public DecompErrorMessage As String

Private parent As CPDFStream
Private Const unsptFilters = "DCTDecode,CCITTFaxDecode,JBIG2Decode,JPXDecode"

Private hasDecodeParams As Boolean
Private predictor As Integer
Private columns As Integer
Private colors As Integer
Private bitspercomponent As Integer

Dim filters() As Decoders

Property Get GetActiveFiltersCount() As Long
    
    If AryIsEmpty(filters) Then
        GetActiveFiltersCount = 0
    Else
        GetActiveFiltersCount = UBound(filters) + 1
    End If
    
End Property
    
Sub ApplyFilters()
    
    Dim d As Decoders
    Dim buf As String
    
    If Form1.mnuDisableDecomp.Checked = True Then Exit Sub
    If UnsupportedFilter Then Exit Sub
    
    buf = parent.OriginalData
    
    If GetActiveFiltersCount() > 0 Then
    
        For Each x In filters
            d = x
            If csharp.Initilized And Form1.mnuDisableiText.Checked = False Then  'send everything through the iTextDecode
                
                If d = FlateDecode And Form1.mnuAlwaysUseZlib.Checked = True Then 'lets still use the zlib for this one...
                    buf = NativeDecompress(buf)   'something in the iText FlateDecode can crash occasionally...(only in long automated runs)
                Else
                    If d = DecodePredictor Then ParsePredictor 'comment out this line to disable the predictor support..(added 3.26.11)
                    If Not csharp.decode(buf, d) Then
                        DecompressionError = True
                        DecompErrorMessage = csharp.ErrorMessage
                        Exit For
                    Else
                        buf = csharp.DecodedBuffer
                    End If
                End If
                
            Else
                If d = FlateDecode Then
                    buf = NativeDecompress(buf)
                ElseIf d = ASCIIHexDecode Then
                    buf = HexStringUnescape(buf, True)
                Else
                    DecompressionError = True
                    If csharp.DetectDotNet = True Then
                        DecompErrorMessage = csharp.ErrorMessage
                    Else
                        DecompErrorMessage = "This filter requires .NET 2.0 or greater installed"
                    End If
                    Exit For
                End If
            End If
        Next
    
        If Not DecompressionError Then
            parent.DecompressedData = buf
            parent.DecompressedSize = Len(buf)
        End If
        
    End If
    
            
    
End Sub

Private Function NativeDecompress(ByVal s As String)
    Dim b() As Byte
    Dim bOut() As Byte
    
    b = StrConv(s, vbFromUnicode, LANG_US)
                
    Module4.UncompressData b(), bOut()
    
    If AryIsEmpty(bOut) Then
        parent.Message = "FlateDecode Decompression Error."
        DecompErrorMessage = parent.Message
        DecompressionError = True
    Else
        NativeDecompress = StrConv(bOut, vbUnicode, LANG_US)
    End If
                
End Function

Private Function ExtractNextValue(tag As String)
    On Error Resume Next
    Dim es As String
    es = LCase(parent.escapedHeader)
    a = InStr(1, es, LCase(tag), vbTextCompare)
    If a > 0 Then
        b = InStr(a, es, "/")
        c = InStr(a, es, "]")
        d = InStr(a, es, ">>")
        b = lowest(b, c, d)
        If b > 0 Then
            a = a + Len(tag) + 1
            ExtractNextValue = Trim(Mid(es, a, b - a))
        End If
    End If
End Function

Private Function lowest(ParamArray x())
    On Error Resume Next
    Dim l As Long
    For i = 0 To UBound(x)
        If l = 0 And x(i) > 0 Then l = x(i)
        If x(i) < l And x(i) >= 1 Then l = x(i)
    Next
    lowest = l
End Function

Sub ParsePredictor()
    On Error Resume Next
    Dim es As String
    Err.Clear
    
    predictor = ExtractNextValue("Predictor")
    columns = ExtractNextValue("Columns")
    colors = ExtractNextValue("Colors")
    bitspercomponent = ExtractNextValue("BitsPerComponent")
    If bitspercomponent = 0 Then bitspercomponent = ExtractNextValue("BPC")
    
    If columns = 0 Then columns = 1
    If colors = 0 Then colors = 1
    If bitspercomponent = 0 Then bitspercomponent = 8
    
    csharp.SetPredictorParams predictor, columns, colors, bitspercomponent
    
    DebugMsg "Stream: " & parent.Index & " has decode parameters p=" & predictor & " colu=" & columns & " color=" & colors & " bpc=" & bitspercomponent & " err? " & Err.Description
    
    
End Sub
'<<
' /Length 2901
' /Filter [ /ASCIIHexDecode /LZWDecode /ASCII85Decode /RunLengthDecode /FlateDecode ]
'>>
'    /DecodeParms [
'    <<
'        /Predictor 12 /Colors 1 /BitsPerComponent 8 /Columns 1
'    >>
'Fl is enough to declare it as FlateDecode

Sub DetermineFilters(pStream As CPDFStream, escapedHeader As String)

    Dim tmp() As String
    Dim d As Decoders
    
    On Error Resume Next
    
    Set parent = pStream
    
    Erase filters
    UnsupportedFilter = False
    
    'If InStr(1, escapedHeader, "DecodeParms", vbTextCompare) > 0 Then Stop
    
    tmp() = Split(escapedHeader, "/")
    
    For Each x In tmp
        
        d = -1
        
        x = sanitize(x)
        'Debug.Print x
        
        'If InStr(x, "Flate") > 0 Then Stop
        
        Select Case Trim(LCase(x))
            Case LCase("ASCIIHexDecode"): d = ASCIIHexDecode
            Case LCase("AHx"): d = ASCIIHexDecode   'sample: 2e8a03fc6ca7e0f6016ce26d1197b5ab
            
            Case LCase("LZWDecode"): d = LzwDecode
            Case LCase("LZW"): d = LzwDecode
            
            Case LCase("ASCII85Decode"): d = ASCII85Decode
            Case LCase("A85"): d = ASCII85Decode
            
            Case LCase("RunLengthDecode"): d = RunLengthDecode
            Case LCase("Rl"): d = RunLengthDecode
            
            Case LCase("FlateDecode"): d = FlateDecode
            Case LCase("Fl"): d = FlateDecode       'sample: 2e8a03fc6ca7e0f6016ce26d1197b5ab
            
            Case LCase("DCTDecode"): d = DCTDecode
            Case LCase("DCT"): d = DCTDecode
            
            Case LCase("CCITTFaxDecode"): d = CCITTFaxDecode
            Case LCase("CCF"): d = CCITTFaxDecode
            
            Case LCase("JBIG2Decode"): d = JBIG2Decode
            Case LCase("JPXDecode"): d = JPXDecode
            
            Case LCase("DecodeParms"): hasDecodeParams = True: 'Stop 'final processor
            Case LCase("DP"): hasDecodeParams = True: 'Stop 'final processor
        End Select
        
        If AnyofTheseInstr(x, unsptFilters) Then
            UnsupportedFilter = True
            parent.UsesUnsupportedFilter = True
        End If
        
        If d <> -1 Then push filters, d
        
    Next
        
    If hasDecodeParams Then push filters, DecodePredictor 'set the final filter to apply as decodepredictor
    
    If GetActiveFiltersCount() > 0 Then parent.isCompressed = True
    
End Sub

Function GetActiveFiltersAsString() As String
    
    If GetActiveFiltersCount() = 0 Then Exit Function
    
    Dim x, r() As String
    Dim d As Decoders
    For Each x In filters
        d = x
        If d = ASCII85Decode Then push r, "ASCII85Decode"
        If d = ASCIIHexDecode Then push r, "ASCIIHexDecode"
        If d = FlateDecode Then push r, "FlateDecode"
        If d = LzwDecode Then push r, "LzwDecode"
        If d = RunLengthDecode Then push r, "RunLengthDecode"
        If d = DCTDecode Then push r, "DCTDecode"
        If d = CCITTFaxDecode Then push r, "CCITTFaxDecode"
        If d = JBIG2Decode Then push r, "JBIG2Decode"
        If d = JPXDecode Then push r, "JPXDecode"
    Next
    
    GetActiveFiltersAsString = Join(r, ",")

    
End Function

Private Function sanitize(ByVal x)
        
    Dim found As Boolean
    found = True
    Do While found
        found = False
        If Right(x, 1) = vbCr Then x = stripLastChar(x, found)
        If Right(x, 1) = vbLf Then x = stripLastChar(x, found)
        If Right(x, 1) = "]" Then x = stripLastChar(x, found)
        If Right(x, 1) = "[" Then x = stripLastChar(x, found)
        If Right(x, 1) = " " Then x = stripLastChar(x, found)
        If Right(x, 1) = ">" Then x = stripLastChar(x, found)
        If Right(x, 1) = "<" Then x = stripLastChar(x, found)
        If Right(x, 1) = Chr(0) Then x = stripLastChar(x, found)
        If Right(x, 1) = vbTab Then x = stripLastChar(x, found)
    Loop
        
    sanitize = x
        
End Function

Private Function stripLastChar(x, ByRef setBool As Boolean)
    On Error Resume Next
    stripLastChar = Mid(x, 1, Len(x) - 1)
    If Err.Number = 0 Then setBool = True
End Function

Private Sub push(ary, Value) 'this modifies parent ary object
    On Error GoTo init
    x = UBound(ary) '<-throws Error If Not initalized
    ReDim Preserve ary(UBound(ary) + 1)
    ary(UBound(ary)) = Value
    Exit Sub
init: ReDim ary(0): ary(0) = Value
End Sub

Private Function AnyofTheseInstr(Data, match, Optional compare As VbCompareMethod = vbTextCompare) As Boolean
    Dim tmp() As String
    Dim x
    tmp = Split(match, ",")
    For Each x In tmp
        If InStr(1, Data, x, compare) > 0 Then
            AnyofTheseInstr = True
            Exit Function
        End If
    Next
End Function

Private Function AryIsEmpty(ary) As Boolean
  On Error GoTo oops
    x = UBound(ary)
    AryIsEmpty = False
  Exit Function
oops: AryIsEmpty = True
End Function
