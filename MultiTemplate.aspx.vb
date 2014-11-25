
Partial Class MultiTemplate
    Inherits System.Web.UI.Page

    'Protected Sub DSTEMP_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSTEMP.Selecting
    '    For i As Integer = 0 To e.Command.Parameters.Count - 1
    '        '          If Not IsNumeric(e.Command.Parameters(i).Value) Then
    '        Response.Write(e.Command.Parameters(i).ToString & " = " & e.Command.Parameters(i).Value & "<br />")
    '        e.Command.Parameters(i).Value = Server.UrlDecode(e.Command.Parameters(i).Value)
    '        '        End If
    '    Next
    'End Sub
End Class
