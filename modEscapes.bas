Attribute VB_Name = "modEscapes"

Function ExtractValidHex(x, Optional assumeUnicode As Boolean = False)
    On Error Resume Next
    Dim b() As Byte
    Dim ret As String
    
    b() = StrConv(x, vbFromUnicode, LANG_US)
    For i = 0 To UBound(b)
        If IsNumeric(Chr(b(i))) Then
            ret = ret & Chr(b(i))
        Else
            If b(i) >= Asc("a") And b(i) <= Asc("f") Then
                ret = ret & Chr(b(i))
            ElseIf b(i) >= Asc("A") And b(i) <= Asc("F") Then
                 ret = ret & Chr(b(i))
            End If
            
            If assumeUnicode = True Then
                If b(i) = Asc("U") Or b(i) = Asc("u") Then ret = ret & "%u"  'sure we will assume it was meant to be this..
            End If
            
        End If
    Next
    
    ExtractValidHex = ret
        
End Function

Function AddPercentToHexString(x, Optional noNulls As Boolean = False)
    On Error Resume Next 'x = 9090EB05 -> %90%90%EB%05
    Dim ret
    
    For i = 1 To Len(x) Step 2
        t = Mid(x, i, 2)
        ret = ret & "%" & t
    Next
    
    AddPercentToHexString = ret
    If noNulls Then
        AddPercentToHexString = Replace(ret, Chr(0), Empty)
    End If
    
End Function

Function MultiEscape(x)

    On Error Resume Next
    
    If InStr(x, "%") > 0 Then
        x = unescape(x)
    End If
    
    If InStr(x, "#") > 0 Then
        x = pound_unescape(x)
    End If
    
    If InStr(x, "\x") > 0 Then
        x = js_unescape(x)
    End If
    
    If InStr(x, "\n") > 0 Then
        x = nl_unescape(x)
    End If
    
    MultiEscape = x
    
End Function

Function EscapeHexString(hexstr)
    
    Dim b() As Byte
    Dim h As String
    Dim c As String
    Dim tmp As String
    On Error Resume Next
    
    h = HexStringUnescape(hexstr)
    b() = StrConv(h, vbFromUnicode, LANG_US)
    
    For i = 0 To UBound(b)
        c = Hex(b(i))
        If Len(c) = 1 Then c = "0" & c
        tmp = tmp & "%" & c
    Next
    
    EscapeHexString = tmp
    
End Function


Function unescape(x) '%uxxxx and %xx
    
    On Error GoTo hell
    
    Dim tmp() As String
    Dim b1, b2
    Dim i As Long
    
    'if instr(x, "%") < 1 then
    tmp = Split(x, "%")
    
    For i = 1 To UBound(tmp)
        t = tmp(i)
        
        If LCase(VBA.Left(t, 1)) = "u" Then
            If Len(t) >= 5 Then
                decode = Mid(t, 1, 5)
                b1 = Mid(decode, 2, 2)
                b2 = Mid(decode, 4, 2)
                tmp(i) = cHex(b2) & cHex(b1)
                If Len(t) > 5 Then tmp(i) = tmp(i) & Mid(t, 6)
            End If
        Else
            If Len(t) >= 2 Then
                decode = Mid(t, 1, 2)
                'If isHex(decode) Then
                    tmp(i) = cHex(decode)
                    If Len(t) > 2 Then tmp(i) = tmp(i) & Mid(t, 3)
                'Else
                '    tmp(i) = "%" & tmp(i)
                'End If
            'Else
            '    tmp(i) = "%" & tmp(i)
            End If
        End If
        
    Next
            
hell:
    unescape = Join(tmp, "")
     
     If Err.Number <> 0 Then
        MsgBox "Error in unescape:( " & Err.Description
     End If
     
End Function

Function pound_unescape(x) '#xx
    
    On Error GoTo hell
    
    Dim tmp() As String
    Dim b1, b2
    Dim i As Long
    
    tmp = Split(x, "#")
    
    If UBound(tmp) > 0 Then
        For i = 1 To UBound(tmp)
            t = tmp(i)
            
            If Len(t) >= 2 Then
                decode = Mid(t, 1, 2)
                If isHex(decode) Then 'bug fix added 12.5.10 others need it too!
                    tmp(i) = cHex(decode)
                    If Len(t) > 2 Then tmp(i) = tmp(i) & Mid(t, 3)
                Else
                    tmp(i) = "#" & tmp(i) 'bf
                End If
            Else
                tmp(i) = "#" & tmp(i) 'bf
            End If
            
        Next
    End If
            
hell:
    pound_unescape = Join(tmp, "")
     
     If Err.Number <> 0 Then
        MsgBox "Error in pound unescape:( " & Err.Description
     End If
     
End Function

Function octal_unescape(ByVal strin)
    
    On Error Resume Next
    Dim tmp() As String
    Dim i As Long
    Dim v As Long
    Dim nextThree As String
    Dim rest As String
    
    tmp = Split(strin, "\")
    For i = 0 To UBound(tmp)
        If Len(tmp(i)) < 4 And IsNumeric(tmp(i)) Then
            v = CLng("&O" & tmp(i))
            If v < 255 Then
                tmp(i) = Chr(v)
            Else
                If Len(tmp(i)) > 0 And i <> 0 Then tmp(i) = "\" & tmp(i) 'cause we join with ""
            End If
        Else
            rest = ""
            nextThree = Mid(tmp(i), 1, 3)
            rest = Mid(tmp(i), 4)
            If IsNumeric(nextThree) Then
                v = CLng("&O" & nextThree)
                If v < 255 Then
                    tmp(i) = Chr(v) & rest
                Else
                    If Len(tmp(i)) > 0 And i <> 0 Then tmp(i) = "\" & tmp(i) 'cause we join with ""
                End If
            Else
                If Len(tmp(i)) > 0 And i <> 0 Then tmp(i) = "\" & tmp(i) 'cause we join with ""
            End If
        End If
    Next
            
    octal_unescape = Join(tmp, "")
        
End Function

'Function octal_unescape(ByVal strIn)
'
'    On Error Resume Next
'    Dim tmp() As String
'    Dim i As Long
'    Dim v As Long
'
'    tmp = Split(strIn, "\")
'    For i = 0 To UBound(tmp)
'        If Len(tmp(i)) < 4 And IsNumeric(tmp(i)) Then
'            v = CLng("&O" & tmp(i))
'            If v < 255 Then
'                tmp(i) = Chr(v)
'            Else
'                tmp(i) = "\" & tmp(i) 'cause we join with ""
'            End If
'        Else
'            tmp(i) = "\" & tmp(i) 'cause we join with ""
'        End If
'    Next
'
'    octal_unescape = Join(tmp, "")
'
'
'End Function

Function js_unescape(x)
    
    On Error GoTo hell
    
    Dim tmp() As String
    Dim b1, b2
    Dim i As Long
    
    tmp = Split(x, "\x")
    
    If UBound(tmp) > 0 Then
        For i = 1 To UBound(tmp)
            t = tmp(i)
            
            If Len(t) >= 2 Then
                decode = Mid(t, 1, 2)
                'If isHex(decode) Then
                    tmp(i) = cHex(decode)
                    If Len(t) > 2 Then tmp(i) = tmp(i) & Mid(t, 3)
                'Else
                '    tmp(i) = "\x" & tmp(i)
                'End If
            'Else
            '    tmp(i) = "\x" & tmp(i)
            End If
            
        Next
    End If
            
hell:
     js_unescape = Join(tmp, "")
     
     'If Err.Number <> 0 Then
     '   MsgBox "Error in unescape:( " & Err.Description
     'End If
     
End Function

Function nl_unescape(ByVal x)
    
    x = Replace(x, "\r\n", vbCrLf)
    x = Replace(x, "\n", vbCrLf)
    x = Replace(x, "\r", vbCrLf)
    x = Replace(x, "\t", vbTab)
    x = Replace(x, "\(", "(")
    x = Replace(x, "\)", ")")
    x = Replace(x, "\" & vbCrLf, Empty)
    
    nl_unescape = x
    
End Function

Public Function HexStringUnescape(str, Optional stripWhite As Boolean = False, Optional noNulls As Boolean = False, Optional bailOnManyErrors As Boolean = False)
        
    Dim ret As String
    Dim x As String
    Dim errCount As Long
    
    On Error Resume Next
    
    If stripWhite Then
        str = Replace(str, " ", Empty)
        str = Replace(str, vbCrLf, Empty)
        str = Replace(str, vbCr, Empty)
        str = Replace(str, vbLf, Empty)
        str = Replace(str, vbTab, Empty)
        str = Replace(str, Chr(0), Empty)
    End If
    
    For i = 1 To Len(str) Step 2 'this is to agressive for headers...
        x = Empty
        x = Mid(str, i, 2)
        x = cHex(x, errCount)
        ret = ret & x
    Next
    
    If noNulls Then
        HexStringUnescape = Replace(ret, Chr(0), Empty)
    Else
        If bailOnManyErrors And (errCount > 5) Then
            HexStringUnescape = str
        Else
            HexStringUnescape = ret
        End If
    End If
    
        
End Function

Public Function cHex(v, Optional ByRef eCount As Long) As String
    On Error Resume Next
    cHex = Chr(CLng("&h" & v))
    If Err.Number <> 0 Then
        eCount = eCount + 1
        cHex = v
    End If
    Err.Clear
End Function

Public Function isHex(v) As Boolean
    On Error Resume Next
    x = Chr(CLng("&h" & v))
    If Err.Number = 0 Then isHex = True
    Err.Clear
End Function

Public Function isHexNum(v) As Boolean
    On Error Resume Next
    x = CLng("&h" & v)
    If Err.Number = 0 Then isHexNum = True
    Err.Clear
End Function

Function ExtractFromParanthesisPageEncapsulation(Data)
    
    On Error Resume Next
    
    Dim ret As String
    
    t = Split(Data, "(")
    For Each x In t
        If Len(x) > 0 Then
            a = InStr(x, ")")
            If a > 1 Then
                ret = ret & Trim(Mid(x, 1, a - 1))
            End If
        End If
    Next
    
    ExtractFromParanthesisPageEncapsulation = ret
    
End Function

Function EscapeHeader(ByVal raw As String) As String
    
    '#xx hex encoding
    '"\" & vbcrlf line continuations..(CR, LF or CRLF)
    '\xxx octal encodings
    '<9090eb> hex encodings
    '<90 90 eb> hex encodings (any amount of whitespace is ok in hex string like this...
    
    On Error GoTo hell
    Dim original As String
    Dim mods() As String
    Dim placeholders() As String
    Dim rchar As Byte
    Dim hadLeftOpen As Boolean
    Dim hadRightClose As Boolean
    
    original = raw
    
    raw = Replace(raw, vbCr, Chr(2))
    raw = Replace(raw, vbLf, Chr(2))
    raw = Replace(raw, Chr(2), vbCrLf)
    raw = Replace(raw, vbCrLf & vbCrLf, vbCrLf)
    
    raw = nl_unescape(raw)
    
    While IsWhitespace(raw): raw = Mid(raw, 2): Wend
    If VBA.Left(raw, 2) = "<<" Then
        raw = Mid(raw, 3)
        hadLeftOpen = True
    End If
    While VBA.Left(raw, 1) = "<": raw = Mid(raw, 2): Wend
    
    While IsWhitespace(raw, False): raw = Mid(raw, 1, Len(raw) - 1): Wend
    If VBA.Right(raw, 2) = ">>" Then
        raw = Mid(raw, 1, Len(raw) - 2)
        hadRightClose = True
    End If
    While IsWhitespace(raw, False): raw = Mid(raw, 1, Len(raw) - 1): Wend
    
    
    'nested markers are temporarily replaced while we go after <> hex strings
    raw = Replace(raw, "<<", Chr(2))
    raw = Replace(raw, ">>", Chr(3))
    
    offset = InStr(raw, "<")
    rchar = &H41
    
    'handle JS headers extra lightly may have embedded < > which below routine is to harsh for...
    isJSHeader = IIf(LCase(raw) Like "*/js*(*", True, False)
    
    'If InStr(raw, "/JS(") > 0 Then Stop
    
    Do While offset > 0 And Not isJSHeader
        b = InStr(offset, raw, ">") 'bug: if header has JS and > is embedded in quoted string bug...
        If b > 0 Then
            hexstring = Trim(Mid(raw, offset + 1, b - 1 - offset))
            
            If InStr(hexstring, " ") < 1 Then
                decoded = HexStringUnescape(hexstring, True, False, True) 'to agressive for generic use...
            Else
                decoded = hexstring
            End If
            
            push mods(), decoded
            
            'this style of replace could cause overlap with user data (a string of AAA?)
            'push placeholders(), String(Len(hexstring), Chr(rchar))
            'replace our hexstring with an equal length unique placeholder
            'raw = Replace(raw, hexstring, String(Len(hexstring), Chr(rchar)))
            'rchar = rchar + 1
            
            place = "__myVar_" & Chr(rchar)
            push placeholders(), place
            rchar = rchar + 1
            
            raw = Replace(raw, hexstring, place)
            If Len(place) > Len(hexstring) Then 'my original buffer just got longer by
                diff = Len(place) - Len(hexstring)
            Else
                diff = Len(hexstring) - Len(place)
            End If
            
            offset = offset + diff
            
        Else
            Exit Do
        End If
        If offset + 1 > Len(raw) Then Exit Do
        offset = InStr(offset + 1, raw, "<")
    Loop
        
    If isJSHeader Then
            raw = Replace(raw, "/(", "(")
            raw = Replace(raw, "/)", ")")
    End If
    
    raw = pound_unescape(raw)
    raw = octal_unescape(raw)
        
    If Not AryIsEmpty(mods) Then
        For i = 0 To UBound(mods)
            raw = Replace(raw, "<" & placeholders(i) & ">", mods(i))
        Next
    End If
    
    raw = Replace(raw, Chr(2), "<<")
    raw = Replace(raw, Chr(3), ">>")
    
    If hadLeftOpen Then raw = "<<" & raw
    If hadRightClose Then raw = raw & ">>"
    
    EscapeHeader = raw
            
    
    
Exit Function
hell:
    EscapeHeader = original

End Function

Function IsWhitespace(strin As String, Optional onLeft As Boolean = True) As Boolean
    
    Dim c As Byte
    
    If onLeft Then
        c = Asc(VBA.Left(strin, 1))
    Else
         c = Asc(VBA.Right(strin, 1))
    End If
    
     If c = 0 Or c = 9 Or c = 10 Or c = 12 Or c = 13 Or c = 32 Then IsWhitespace = True
    
End Function

Private Sub push(ary, Value) 'this modifies parent ary object
    On Error GoTo init
    x = UBound(ary) '<-throws Error If Not initalized
    ReDim Preserve ary(UBound(ary) + 1)
    ary(UBound(ary)) = Value
    Exit Sub
init: ReDim ary(0): ary(0) = Value
End Sub

Private Function AryIsEmpty(ary) As Boolean
  On Error GoTo oops
    x = UBound(ary)
    AryIsEmpty = False
  Exit Function
oops: AryIsEmpty = True
End Function
