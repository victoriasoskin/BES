
Partial Class Welfarepwd
    Inherits System.Web.UI.Page

    Protected Sub bynlogin_Click(sender As Object, e As System.EventArgs) Handles bynlogin.Click
        If tbun.Text = "בית אקשטיין" And tbpw.Text = "1234" Then
            Session("pwbe") = "1234"
            Response.Redirect("WelFareZbuy_1.aspx?op=2&AG=True")
        Else
            lblerr.Visible = True
            Session.Clear()
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            tbun.Focus()
        End If
    End Sub
End Class
