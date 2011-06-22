VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "CPdfParser"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'Author:   dzzie@yahoo.com
'Site:     http://sandsprite.com

Event NewStream(stream As CPDFStream)
Event DebugMessage(msg As String)
Event SetObjectCount(cnt As Long)
Event Complete()

Private Function GetCount(marker, blob)
    On Error Resume Next
    GetCount = UBound(Split(blob, marker, , vbTextCompare))
    If Err.Number <> 0 Then GetCount = 0
End Function

Function ParseFile(fpath As String) As String
        
   ' On Error GoTo hell
    
    Dim stream As CPDFStream
    Dim sStr As String
    Dim objStart As Long
    Dim objEnd As Long
    Dim endObj As Long
    Dim lastObjEnd As Long
    
    Dim decryptor As String
    Dim dFile As String
    
    If Not fso.FileExists(fpath) Then
        MsgBox "File not found: " & fpath, vbInformation
        Exit Function
    End If
    
    sStr = LoadFile(fpath)
    
    RaiseEvent SetObjectCount(GetCount("endobj", sStr))
    
    If InStr(sStr, "/Encrypt") > 0 Then
        If csharp.Decrypt(fpath, dFile) Then
            sStr = LoadFile(dFile)
            Form1.txtPDFPath = dFile
        Else
            If Len(dFile) > 0 Then MsgBox "Decrypt failed output: " & dFile, vbInformation
        End If
    End If
        
    objStart = InStr(1, sStr, "obj", vbTextCompare)
    Do While objStart > 0
        Set stream = New CPDFStream
        
        objEnd = InStr(objStart, sStr, "endobj", vbTextCompare) 'must be case insensitive
        endObj = InStr(objStart, sStr, "objend", vbTextCompare) 'this works too (found in sample 1df9249930f1f26edf367aceb614c603.pdf)
        
        If objEnd < 1 And endObj < 1 Then
            RaiseEvent DebugMessage("Missing endstream marker objStart = 0x" & Hex(objStart))
            Exit Do
        End If
    
        If objEnd > endObj And endObj <> 0 Then objEnd = endObj 'use which ever comes first.
        
        stream.ObjectStartOffset = objStart - 1
        stream.ObjectEndOffset = objEnd + Len("endobj") - 2
        stream.Index = GetStreamIndex(sStr, objStart)
        stream.RawObject = Mid(sStr, objStart, objEnd - objStart)
        stream.ParseSelf
        
        RaiseEvent NewStream(stream)
        If stream.ObjectEndOffset > lastObjEnd Then lastObjEnd = stream.ObjectEndOffset
        
        objStart = InStr(stream.ObjectEndOffset, sStr, "obj", vbTextCompare)
    Loop
    
    RaiseEvent DebugMessage("Parsing complete 0x" & Hex(Len(sStr) - lastObjEnd) & " bytes after end of last object @ 0x" & Hex(lastObjEnd))
    RaiseEvent Complete
    
End Function

Private Function LoadFile(fpath As String) As String

    Dim b() As Byte

    f = FreeFile
    Open fpath For Binary Access Read As f
    ReDim b(LOF(f))
    Get f, , b()
    Close f
    
    LoadFile = StrConv(b, vbUnicode, LANG_US)
    
End Function


Private Function GetStreamIndex(s, ByVal startPos As Long)
    
    Dim a As Long
    Dim b As Long
    Dim ss As String
    Dim so As Long
    
    If startPos - 10 < 1 Then
        ss = Mid(s, 1, startPos - 1)
    Else
        startPos = startPos - 10
        ss = Mid(s, startPos, 10)
    End If
    
    'can be either take last one found
    a = InStrRev(ss, Chr(&HA))
    b = InStrRev(ss, Chr(&HD))
    If b > a Then a = b
    
    If a > 0 Then
        ss = Mid(ss, a + 1)
        b = InStr(ss, " ")
        If b > 0 Then
            GetStreamIndex = Trim(Mid(ss, 1, b - 1))
        End If
    End If
    
    
End Function
