
Partial Class WelfareDefs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Session("pwbe") = "1234"
    End Sub

    Protected Sub DSWelfareOps_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSWelfareOps.Updated
        'Dim s As String = e.Command.Parameters("Discount").Value
        's = s.Replace("%", "")
        'e.Command.Parameters("Discount").Value = CDec(s) / 100
    End Sub
End Class
