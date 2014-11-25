
Partial Class Default4
    Inherits System.Web.UI.Page

	Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
		Session("LastCustID") = Session("UserID")
		Session("UserID") = 32111
        Response.Redirect("Surveys.aspx?f=" & rblsurvey.SelectedValue)
	End Sub

	Protected Sub rblsurvey_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblsurvey.SelectedIndexChanged
	End Sub
End Class
