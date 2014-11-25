
Partial Class HRS
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.Redirect("/HR_CKC.Aspx?U=" & Session("UserID"))
    End Sub
End Class
