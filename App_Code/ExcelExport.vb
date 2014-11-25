Imports Microsoft.VisualBasic
Imports System.IO

Public Class ExcelExport
    Shared iXlF As Integer
    Shared Sub doExcel(ByVal sF As String, ByRef lblhdr As WebControls.Label, ByVal gv As GridView)
        Dim iR As Integer = 2       'Initial Row index
        Dim iC As Integer = 0       'Initial Column Index
        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim Controls As System.Web.UI.ControlCollection
        lblhdr.Text = "<meta HTTP-EQUIV=""content-type"" CONTENT=""text/html; charset=utf-8"" /><span style='font-size:x-large;font-weight:bold;color:Blue;'>" & lblhdr.Text & "</span>"
        Dim frm As HtmlForm = New HtmlForm()
        Controls = New System.Web.UI.ControlCollection(frm)
        HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" '"application/vnd.ms-excel"
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        HttpContext.Current.Response.Charset = "utf-8"
        frm.EnableViewState = False
        Controls.Add(frm)
        Controls.Add(lblhdr)    'Add Header Label
        iR += 1                     'Increase Row Index
        Dim sRow As String = vbNullString                           'Will hold the row reference
        Dim sCol As String = vbNullString                           'will hold the column reference
        iR += 1                     'Increase Row Index for gv header row
        For i = 0 To gv.Rows.Count - 1
            iC = 0                  'Initial Column Index
            For j = 0 To gv.Rows(i).Cells.Count - 1
                iC += 1
                If Left(gv.Rows(i).Cells(j).Text, 1) = "=" Then     'Formula always starts with "="

                    ' Convert from R1C1 Reference style To normal (A1) - full column or row reference is not supported

                    Dim sOrg As String = gv.Rows(i).Cells(j).Text   'Formula Text
                    Dim s() As Char = sOrg.ToCharArray              'Convert to char array
                    iXlF = 0                                        'Index of char array - initial value
                    Dim cRep As New Collection                      'Collection of converted excel references
                    Dim iSt As Integer                              'Will keep the postion of the first character in reference - so it can be replace later
                    Dim b As Integer = 0
                    While iXlF < s.Length - 1                       'Loop on formula
                        If LCase(s(iXlF)) = "r" Then                'if r is found 
                            iSt = iXlF                              'Save position
                            iXlF += 1                               'Position of next character
                            If IsNumeric(s(iXlF)) Then              'if next char is numeric - this is an absolute reference
                                sRow = "$" & iNumExl(s)             'get the whole number and convert to absolute row position
                            ElseIf s(iXlF) = "[" Then               'if brackets - this is arelative reference
                                iXlF += 1                           'Position of next character
                                sRow = iNumExl(s) + iR              'find full number and add current sheet row index
                                iXlF += 1                           'Position of next character
                            ElseIf LCase(s(iXlF)) = "c" Then        'if after r appears c ...
                                sRow = iR                           'this is a relastive reference of current sheet row
                            End If                                  'if not c it might not be a  reference - we will know later
                            b += 1                                  'Indicate that we have a row reference (or not)
                        Else
                            b = 0                                   'This is not a row reference
                        End If
                        If LCase(s(iXlF)) = "c" Then                'if c is found
                            iXlF += 1                               'Position of next character
                            If IsNumeric(s(iXlF)) Then              'if next char is numeric - this is an absolute reference
                                sCol = "$" & Chr(iNumExl(s) + 64)   'get the whole number and convert to absolute column position
                            ElseIf s(iXlF) = "[" Then               'if brackets - this is arelative reference
                                iXlF += 1                           'Position of next character
                                sCol = Chr(iNumExl(s) + iC + 64)    'find full number and add current sheet column index
                                iXlF += 1                           'Position of next character
                            End If
                            b += 1                                  'Indicate that we have a row reference
                        End If
                        If b = 2 Then                               'if We have borh row and column references...
                            cRep.Add(iSt & "|" & iXlF & "|" & sCol & sRow) 'Add posision,length ad reference into collection
                            b = 0                                   'zero reference indicator
                        End If
                        iXlF += 1                                   'Position of next character
                    End While

                    ' Replace references in the formula (from right to left - so position will remain OK)

                    For iX = cRep.Count To 1 Step -1
                        Try
                            Dim sv() As String = cRep(iX).split("|")
                            Dim sAA As String = sOrg.Substring(0, CInt(sv(0)))
                            sAA &= sv(2)
                            sAA &= Mid(sOrg, CInt(sv(1)) + 1)
                            sOrg = sAA ' Org.Substring(0, CInt(sv(0))) & sv(2) & sOrg.Substring(CInt(sv(1)), 999)
                        Catch ex As Exception
                        End Try
                    Next
                    gv.Rows(i).Cells(j).Text = sOrg
                End If
            Next
            iR += 1                                                'New row index
        Next
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        HttpContext.Current.Response.Write(tw.ToString())
        HttpContext.Current.Response.End()
        'gv.DataBind()
    End Sub
    Shared Function iNumExl(s() As Char) As Integer
        Dim so As String = vbNullString
        For i = iXlF To s.Length - 1
            If s(i) = "-" Or s(i) = "+" Or IsNumeric(s(i)) Then
                so &= s(i)
            Else
                iXlF = i
                Exit For
            End If
        Next
        Return CInt(so)
    End Function

End Class
