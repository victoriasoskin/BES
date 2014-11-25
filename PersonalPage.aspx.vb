
Partial Class PersonalPage
    Inherits System.Web.UI.Page

    Protected Sub Editor1_ContentChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Editor1.ContentChanged


        lblt.Text = Editor1.Content()
    End Sub
End Class
