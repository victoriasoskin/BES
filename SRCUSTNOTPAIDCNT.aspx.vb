
Partial Class Default5
    Inherits System.Web.UI.Page
    Dim ttl As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LBLTODAY.Text = Format(Now(), "dd/MM/yy")
    End Sub
    Function scnt() As String
        Dim i As Integer = Eval("NOTPAIDCOUNT")
        ttl += i
        Return CStr(i)
    End Function
    Function stotal() As String
        Return CStr(ttl)
    End Function
End Class


