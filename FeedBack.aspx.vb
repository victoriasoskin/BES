
Partial Class FeedBack
    Inherits System.Web.UI.Page

    Protected Sub LBDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LBDATE.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Now()
    End Sub
End Class
