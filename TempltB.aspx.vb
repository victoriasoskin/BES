Imports MessageBox
Imports System.IO

Partial Class Templt1
    Inherits System.Web.UI.Page
    Protected Sub frm_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        MessageBox.Show(frm.InnerHtml & "aa")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim s As String = Request.QueryString("s")
        If IsURLValid(s) Then
            Try
                frm.Attributes("src") = Request.QueryString("s")
            Catch ex As Exception
                MessageBox.Show("מצטערים, לא ניתן להציג את התבנית.")
            End Try
        Else
            MessageBox.Show("מצטערים, לא ניתן להציג את התבנית.")
        End If
    End Sub
    Function IsURLValid(ByVal sUrl As String) As Boolean
        Dim b As Boolean = False
        Dim url As New System.Uri(sUrl)
        Dim req As System.Net.WebRequest
        req = System.Net.WebRequest.Create(url)
        Dim resp As System.Net.HttpWebResponse
        Try
            resp = CType(req.GetResponse(), System.Net.HttpWebResponse)
            Dim str As String = resp.Headers(0)
            resp.Close()
            req = Nothing
            b = True
        Catch ex As Exception
            req = Nothing
            b = False
        End Try
        Return b
    End Function
End Class
