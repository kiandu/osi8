Sub FixDateFormat()
    Dim ws As Worksheet
    Dim rng As Range
    Dim cell As Range
    Dim dt As Date
    
    ' Set to active sheet (or specify with Worksheets("SheetName"))
    Set ws = ActiveSheet
    
    ' Adjust the range to your column of dates (e.g., A2:A1000)
    Set rng = ws.Range("A2:A1000")
    
    For Each cell In rng
        If Not IsEmpty(cell.Value) Then
            On Error Resume Next
            ' Convert text (YYYY-MM-DD) into proper Date
            dt = DateValue(cell.Value)
            If Err.Number = 0 Then
                cell.Value = dt
                ' Format as MM/DD/YY
                cell.NumberFormat = "MM/DD/YY"
            End If
            On Error GoTo 0
        End If
    Next cell
    
    MsgBox "Dateeeeeee format conversion completed!", vbInformation
End Sub
