
Partial Class ErrMessage
    Inherits System.Web.UI.Page

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Request.QueryString("M") IsNot Nothing Then
			perr.Text = Request.QueryString("M")
		End If
	End Sub
End Class
