
Partial Class SurveyPassword
    Inherits System.Web.UI.Page

    Protected Sub btnpwd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnpwd.Click
        'If tbpwd.Text = Session("SurveyPWD") Then
        '    Session("PWDSupplied") = 1
        '    Response.Redirect("~/SurveyEntry.aspx?s=" & "0" & Request.QueryString("S"))
        'End If
    End Sub

    Protected Sub lblhdr3_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblhdr3.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Session("SurveyName")
        tbpwd.Focus()
    End Sub

    Protected Sub tbpwd_TextChanged(sender As Object, e As System.EventArgs) Handles tbpwd.TextChanged
        If tbpwd.Text = Session("SurveyPWD") Then
            Session("PWDSupplied") = 1
            Response.Redirect("~/SurveyEntry.aspx?s=" & "0" & Request.QueryString("S"))
        End If
    End Sub
End Class
