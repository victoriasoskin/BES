Imports System.IO
Imports WRCookies
Imports BesConst
Partial Class SurveyFrameList
    Inherits System.Web.UI.Page
    Dim bHideAction As Boolean
    Sub doExcel(sF As String, lv As ListView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(lv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
    End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        bHideAction = True
        ListView1.DataBind()
        doExcel("Rep.xls", ListView1)

    End Sub

    Protected Sub totcntLabel_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Tot("cntLabel")
    End Sub
    Protected Sub totacntLabel_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Tot("acntLabel")
    End Sub
    Protected Sub totprcLabel_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim lv As ListView = CType(lbl.NamingContainer, ListView)
        Dim lbl1 As Label = CType(lv.FindControl("totacntLabel"), Label)
        Dim lbl2 As Label = CType(lv.FindControl("totcntLabel"), Label)
        If IsNumeric(lbl1.Text) And IsNumeric(lbl2.Text) Then lbl.Text = Format(CDbl(lbl1.Text) / CDbl(lbl2.Text), "0%")
    End Sub
    Protected Sub lblActions_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        If ActionVisible(False) Then
            lbl.Text = "פעולות"
        End If
    End Sub
    Function Tot(sControlID As String) As Integer
        Dim lv As ListView = CType(ListView1, ListView)
        Dim lvi As ListViewItem
        Dim lbl As Label
        Dim total As Integer = 0
        For i = 0 To lv.Items.Count - 1
            lvi = lv.Items(i)

            lbl = CType(lvi.FindControl(sControlID), Label)
            If lbl IsNot Nothing Then If IsNumeric(Trim(lbl.Text)) Then total = total + Trim(lbl.Text)

        Next
        Return total / 2
    End Function
    Function ActionVisible(Optional bData As Boolean = True) As Boolean
        Return If(bData = True, Eval("GORD") = 2, True) And Session("SType") = "Admin" And Not bHideAction
    End Function

    Protected Sub ddlSurveys_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSurveys.SelectedIndexChanged
        'Dim ddl As DropDownList = CType(sender, DropDownList)
        'WriteCookie(SurveyCookiesKey, "LastSurvey", ddl.SelectedValue)
        Dim cbl As CheckBoxList = CType(sender, CheckBoxList)
        Dim s As String = vbNullString
        For Each li As ListItem In cbl.Items
            If li.Selected Then s &= li.Value & ","
        Next
        If s <> vbNullString Then
            DSCOUNT.SelectParameters("SurveyIDS").DefaultValue = Left(s, Len(s) - 1)
        End If
    End Sub

    Protected Sub ddlSurveys_PreRender(sender As Object, e As System.EventArgs) Handles ddlSurveys.PreRender
        'If Not IsPostBack Then
        '    If ReadCookie(SurveyCookiesKey, "LastSurvey") IsNot Nothing Then
        '        Dim ddl As DropDownList = CType(sender, DropDownList)
        '        Dim li As ListItem = ddl.Items.FindByValue(ReadCookie(SurveyCookiesKey, "LastSurvey"))
        '        If li IsNot Nothing Then
        '            ddl.ClearSelection()
        '            li.Selected = True
        '        End If
        '    End If
        'End If
    End Sub

    'Protected Sub DSCOUNT_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSCOUNT.Selecting
    '    For i = 0 To e.Command.Parameters.Count - 1
    '        Response.Write(e.Command.Parameters(i).ToString & "=" & e.Command.Parameters(i).Value & "<br />")
    '    Next
    'End Sub
End Class
