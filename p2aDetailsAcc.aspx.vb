
Partial Class p2a_DetailsAcc
    Inherits System.Web.UI.Page
    Dim TotalColvalue(0 To 16) As Decimal
    Function GetColValue(ByVal xxx As Decimal, ByVal i As Integer) As Decimal
        TotalColvalue(i) += xxx
        Return xxx
    End Function
    Function GetTotal(ByVal i As Integer) As Decimal
        Return TotalColvalue(i)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LBTITLE.Text = "פירוט נתוני בפועל - חשבונות לסעיף: " & Request.QueryString("Budget")
        LBSUBTITLE.Text = Request.QueryString("Frame") & ", מ" & _
        Format(CDate(Request.QueryString("DateS")), "MMMM-yy") & " עד " & _
        Format(CDate(Request.QueryString("DateB")), "MMMM-yy")
    End Sub
End Class
