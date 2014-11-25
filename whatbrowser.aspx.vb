
Partial Class whatbrowser
    Inherits System.Web.UI.Page

    Protected Sub lbl_PreRender(sender As Object, e As System.EventArgs)
        lblb.Text = Request.Browser.Browser & " / " & Request.Browser.Type & " [" & Request.Browser.MajorVersion & " - " & Request.Browser.MinorVersion & "]"
    End Sub
End Class
