Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports PageErrors

Partial Class Default4
    Inherits System.Web.UI.Page
    Dim tot(50) As Integer
    Dim totrow As Integer
    Dim bAuto As Boolean = False

    Sub ddlDates(ByVal ddl As DropDownList)
        Dim d As DateTime = CDate("2008-1-1")
        Dim d1 As DateTime = Today
        Dim j As Integer = DateDiff(DateInterval.Month, d, d1) + 1
        Dim i As Integer
        For i = 0 To j
            Dim lm As New ListItem(Format(DateAdd(DateInterval.Month, i, d), "MMM-yy"), DateAdd(DateInterval.Month, i, d))
            ddl.Items.Add(lm)
        Next
    End Sub

    Protected Sub ddlServices_DataBound(sender As Object, e As System.EventArgs) Handles DDLServices.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.Count = 2 Then
            ddl.Items.RemoveAt(0)
            '      DDLFRAME.Items.Clear()
        End If
        RemoveDDLDupItems(ddl)
    End Sub

    Protected Sub ddlFrames_DataBound(sender As Object, e As System.EventArgs) Handles DDLFRAME.DataBound
             Dim ddl As DropDownList = CType(sender, DropDownList)
        If Session("MultiFrame") = 0 Then
            If ddl.Items(0).Text = "כל המסגרות" Then
                ddl.Items.RemoveAt(0)
            End If
        End If
        RemoveDDLDupItems(ddl)
    End Sub
    Protected Sub DDLFDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFDATE.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            ddlDates(ddl)
            Dim d As DateTime = DateAdd(DateInterval.Year, DateDiff(DateInterval.Year, CDate("1900-1-1"), Today), CDate("1900-1-1"))
            Dim lm As ListItem = ddl.Items.FindByValue(d)
            If Not lm Is Nothing Then ddl.SelectedValue = d
        End If
    End Sub

    Protected Sub DDLTDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLTDATE.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            ddlDates(ddl)
            Dim d As DateTime = DateAdd(DateInterval.Month, 1, DateAdd(DateInterval.Month, DateDiff(DateInterval.Month, CDate("1900-1-1"), Today()), CDate("1900-1-1")))
            Dim lm As ListItem = ddl.Items.FindByValue(d)
            If Not lm Is Nothing Then ddl.SelectedValue = d
        End If

    End Sub

    Protected Sub DSREPDATA_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSREPDATA.Selecting
        Dim sQStory As String = "<b><u>תכולת הדוח: כל הארועים על פי המגבלות הבאות:</u></b><br />נתונים מורשים של " & Session("UserName") & ".<br />"
        Dim i As Integer
        For i = 0 To e.Command.Parameters.Count - 1
            Dim s As String = e.Command.Parameters(i).ToString
            Dim sv As String = e.Command.Parameters(i).Value
            If sv <> vbNullString Then
                Select Case LCase(s)
                    Case "@serviceid"
                        sQStory &= "<b>אזור:</b> " & DDLServices.SelectedItem.Text & "<br />"
                    Case "@frameid"
                        sQStory &= "<b>מסגרת:</b> " & DDLFRAME.SelectedItem.Text & "<br />"
                    Case "@fdate"
                        sQStory &= "<b>בחודשים:</b> " & DDLFDATE.SelectedItem.Text & " עד " & DDLTDATE.SelectedItem.Text & "<br />"
                    Case "@status"
                        If sv <> "0" Then
                            sQStory &= "<b>סטטוס:</b> " & ddlStatus.SelectedItem.Text & "<br />"
                        End If
                    Case "@ext1"
                        sQStory &= "<b>סיווג ראשי:</b> " & ddlET1.SelectedItem.Text & "<br />"
                    Case "@ext2"
                        sQStory &= "<b>סיווג משני:</b> " & ddlET2.SelectedItem.Text & "<br />"
                End Select
            End If
        Next
        ViewState("lblhdr") = sQStory
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        For Each gvr As GridViewRow In GridView1.Rows
            For i As Integer = 0 To gvr.Cells.Count - 1
                gvr.Cells(i).BorderColor = Drawing.Color.Silver
            Next
        Next
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim i As Integer
        Dim j As Integer = 0
        Dim k As Integer
        Dim s As String = "סה&quot;כ"
        Dim b As Boolean = RBLREPTYPE.SelectedIndex > 0
        Dim cell As TableCell
        If e.Row.RowType = DataControlRowType.DataRow Then
            totrow = 0
            For i = 0 To e.Row.Cells.Count - 1
                cell = e.Row.Cells(i)
                If Not IsNumeric(cell.Text) Then
                    cell.Wrap = False
                ElseIf Left(e.Row.Cells(0).Text, Len(s)) <> s Then
                    cell = e.Row.Cells(i)
                    If IsNumeric(cell.Text) Then
                        tot(i) = tot(i) + Int(cell.Text)
                        totrow = totrow + Int(cell.Text)
                        tot(1) = tot(1) + Int(cell.Text)
                        If j = 0 Then j = i
                        If cell.Text = 0 Then cell.Text = vbNullString
                    End If
                Else
                    e.Row.Font.Bold = True
                    e.Row.BackColor = Drawing.Color.Silver
                    totrow = totrow + Int(cell.Text)
                End If
            Next
            If totrow <> 0 And b Then e.Row.Cells(1).Text = totrow
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.BackColor = Drawing.Color.Gray
            cell = e.Row.Cells(0)
            cell.Text = "ס""כ הארועים"
            k = 0
            For i = 1 To e.Row.Cells.Count - 1
                cell = e.Row.Cells(i)
                cell.Text = CStr(tot(i))
                If i <> 1 Then k = k + tot(i)
            Next
            LBLSUMMARY.Text = "ס""כ הארועים בדוח: " & k
        End If
    End Sub
    Sub doExcel(sF As String, gv As GridView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        Dim lbl As Label = CType(dlist.Items(0).FindControl("LBLREPH"), Label)
        lbl.Text = "<span style=""font-size:Large;"">" & lbl.Text & "</span><br />"
        frm.Controls.Add(lbl)
        lblhdr.Text = ViewState("lblhdr")
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
        'gv.DataBind()
    End Sub
    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        GridView1.AllowSorting = False
        '  GridView1.DataBind()
        doExcel("Rep.xls", GridView1)
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        GridView1.DataSource = DSREPDATA
        Try
            GridView1.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub rbExReport_CheckedChanged(sender As Object, e As System.EventArgs) Handles rbExReport.CheckedChanged, rbWexReports.CheckedChanged
        Dim rb As RadioButton = CType(sender, RadioButton)
        If rb.Checked Then Response.Redirect(Mid(rb.ID, 3) & ".aspx")
    End Sub
    Sub RemoveDDLDupItems(ByRef ddl As DropDownList)
        Dim cItems As New Microsoft.VisualBasic.Collection
        Dim cItems2Delete As New Microsoft.VisualBasic.Collection
        For i As Integer = 0 To ddl.Items.Count - 1
            Try
                cItems.Add(ddl.Items(i).Value, ddl.Items(i).Value)
            Catch ex As Exception
                cItems2Delete.Add(i)
            End Try
        Next
        For i = cItems2Delete.Count To 1 Step -1
            ddl.Items.RemoveAt(cItems2Delete(i))
        Next
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
End Class
