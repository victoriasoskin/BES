Partial Class CustStatus
    Inherits System.Web.UI.Page
    Public Function truncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub

End Class
