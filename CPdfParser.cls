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

Private Declare Function GetTickCount Lib "kernel32" () As Long

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
    Dim globalOffset As Long
    
    Dim decryptor As String
    Dim dFile As String
    Dim fSize As Long
    Dim starttick As Long
    
    If Not fso.FileExists(fpath) Then
        MsgBox "File not found: " & fpath, vbInformation
        Exit Function
    End If
        
    sStr = LoadFile(fpath)
    fSize = Len(sStr)
    
    RaiseEvent SetObjectCount(GetCount("endobj", sStr))
    
    If InStr(sStr, "/Encrypt") > 0 Then
        If csharp.Decrypt(fpath, dFile) Then
            sStr = LoadFile(dFile)
            Form1.txtPDFPath = dFile
        Else
            If Len(dFile) > 0 Then MsgBox "Decrypt failed output: " & dFile, vbInformation
        End If
    End If
    
    Dim part2 As String, part3 As String, part4 As String
    Dim defragLevel As Long
    
    HalveString sStr, part3 'divide the input file up into 4 parts for quicker parsing..(smaller strings)
    HalveString sStr, part2
    HalveString part3, part4
    
    defragLevel = 0
    globalOffset = 0
    starttick = GetTickCount()
    
    objStart = InStr(1, sStr, "obj", vbTextCompare)
    Do While objStart > 0
        Set stream = New CPDFStream
        
retry:
        objEnd = InStr(objStart, sStr, "endobj", vbTextCompare) 'must be case insensitive
        endObj = InStr(objStart, sStr, "objend", vbTextCompare) 'this works too (found in sample 1df9249930f1f26edf367aceb614c603.pdf)
        
        If objEnd < 1 And endObj < 1 Then
            If defragLevel < 3 Then
                If defragLevel = 0 Then sStr = sStr & part2
                If defragLevel = 1 Then sStr = sStr & part3
                If defragLevel = 2 Then sStr = sStr & part4
                defragLevel = defragLevel + 1
                GoTo retry
            End If
            RaiseEvent DebugMessage("Missing endstream marker objStart = 0x" & Hex(objStart))
            Exit Do
        End If
    
        If objEnd > endObj And endObj <> 0 Then objEnd = endObj 'use which ever comes first.
        
        stream.ObjectStartOffset = globalOffset + objStart - 1
        stream.ObjectEndOffset = globalOffset + objEnd + Len("endobj") - 2
        stream.Index = GetStreamIndex(sStr, objStart)
        stream.RawObject = Mid(sStr, objStart, objEnd - objStart)
        stream.ParseSelf
        
        RaiseEvent NewStream(stream)
        If stream.ObjectEndOffset > lastObjEnd Then lastObjEnd = stream.ObjectEndOffset
        
        sStr = Mid(sStr, objEnd + Len("endobj"))  ' we keep reducing the size so it gets faster as we go..
        globalOffset = globalOffset + objEnd + Len("endobj") - 1
        objStart = InStr(1, sStr, "obj", vbTextCompare)
        
        If objStart < 1 Then
            If defragLevel < 3 Then
                If defragLevel = 0 Then sStr = sStr & part2
                If defragLevel = 1 Then sStr = sStr & part3
                If defragLevel = 2 Then sStr = sStr & part4
                defragLevel = defragLevel + 1
                objStart = InStr(1, sStr, "obj", vbTextCompare)
            End If
        End If
        
    Loop
    
    RaiseEvent DebugMessage("Parsing Complete Objects: " & Form1.lv.ListItems.Count + Form1.lv2.ListItems.Count & "  Elapsed Time: " & ((GetTickCount() - starttick) / 1000) & " seconds")
    RaiseEvent DebugMessage("Parsing complete 0x" & Hex(fSize - lastObjEnd) & " bytes after end of last object @ 0x" & Hex(lastObjEnd))
    RaiseEvent Complete
    
End Function

'Function ParseFile(fpath As String) As String
'
'   ' On Error GoTo hell
'
'    Dim stream As CPDFStream
'    Dim sStr As String
'    Dim objStart As Long
'    Dim objEnd As Long
'    Dim endObj As Long
'    Dim lastObjEnd As Long
'    Dim globalOffset As Long
'
'    Dim decryptor As String
'    Dim dFile As String
'    Dim fSize As Long
'    Dim starttick As Long
'
'    If Not fso.FileExists(fpath) Then
'        MsgBox "File not found: " & fpath, vbInformation
'        Exit Function
'    End If
'
'    sStr = LoadFile(fpath)
'    fSize = Len(sStr)
'
'    RaiseEvent SetObjectCount(GetCount("endobj", sStr))
'
'    If InStr(sStr, "/Encrypt") > 0 Then
'        If csharp.Decrypt(fpath, dFile) Then
'            sStr = LoadFile(dFile)
'            Form1.txtPDFPath = dFile
'        Else
'            If Len(dFile) > 0 Then MsgBox "Decrypt failed output: " & dFile, vbInformation
'        End If
'    End If
'
'    Dim part2 As String
'    Dim defragged As Boolean
'
'    HalveString sStr, part2 'divide the input file up in two parts for quicker parsing..(smaller strings)
'
'    defragged = False
'    globalOffset = 0
'    starttick = GetTickCount()
'
'    objStart = InStr(1, sStr, "obj", vbTextCompare)
'    Do While objStart > 0
'        Set stream = New CPDFStream
'
'retry:
'        objEnd = InStr(objStart, sStr, "endobj", vbTextCompare) 'must be case insensitive
'        endObj = InStr(objStart, sStr, "objend", vbTextCompare) 'this works too (found in sample 1df9249930f1f26edf367aceb614c603.pdf)
'
'        If objEnd < 1 And endObj < 1 Then
'            If defragged = False Then
'                sStr = sStr & part2
'                defragged = True
'                GoTo retry
'            End If
'            RaiseEvent DebugMessage("Missing endstream marker objStart = 0x" & Hex(objStart))
'            Exit Do
'        End If
'
'        If objEnd > endObj And endObj <> 0 Then objEnd = endObj 'use which ever comes first.
'
'        stream.ObjectStartOffset = globalOffset + objStart - 1
'        stream.ObjectEndOffset = globalOffset + objEnd + Len("endobj") - 2
'        stream.Index = GetStreamIndex(sStr, objStart)
'        stream.RawObject = Mid(sStr, objStart, objEnd - objStart)
'        stream.ParseSelf
'
'        RaiseEvent NewStream(stream)
'        If stream.ObjectEndOffset > lastObjEnd Then lastObjEnd = stream.ObjectEndOffset
'
'        sStr = Mid(sStr, objEnd + Len("endobj"))  ' we keep reducing the size so it gets faster as we go..
'        globalOffset = globalOffset + objEnd + Len("endobj") - 1
'        objStart = InStr(1, sStr, "obj", vbTextCompare)
'
'        If objStart < 1 And defragged = False Then
'            sStr = sStr & part2
'            defragged = True
'            objStart = InStr(1, sStr, "obj", vbTextCompare)
'        End If
'
'    Loop
'
'    RaiseEvent DebugMessage("Parsing Complete Objects: " & Form1.lv.ListItems.Count + Form1.lv2.ListItems.Count & "  Elapsed Time: " & ((GetTickCount() - starttick) / 1000) & " seconds")
'    RaiseEvent DebugMessage("Parsing complete 0x" & Hex(fSize - lastObjEnd) & " bytes after end of last object @ 0x" & Hex(lastObjEnd))
'    RaiseEvent Complete
'
'End Function

Private Function HalveString(strIn As String, secondPart As String)
    Dim x As Long
    x = Len(strIn) / 2
    secondPart = Mid(strIn, x)
    strIn = Mid(strIn, 1, x - 1)
End Function

Function Old_ParseFile(fpath As String) As String
        
   ' On Error GoTo hell
    
    Dim stream As CPDFStream
    Dim sStr As String
    Dim objStart As Long
    Dim objEnd As Long
    Dim endObj As Long
    Dim lastObjEnd As Long
    Dim starttick As Long
    
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
        
    starttick = GetTickCount()
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
    
    RaiseEvent DebugMessage("Parsing Complete Objects: " & Form1.lv.ListItems.Count + Form1.lv2.ListItems.Count & "  Elapsed Time: " & ((GetTickCount() - starttick) / 1000) & " seconds")
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
