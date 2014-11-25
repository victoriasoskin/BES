
Partial Class p2a_DetailTrans
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
        LBTITLE.Text = "פירוט נתוני בפועל - תנועות לחשבון: " & Request.QueryString("ACCT") & _
        " - " & Request.QueryString("AccountName")
        LBSUBTITLE.Text = Request.QueryString("Frame") & ", מ" & _
        Format(CDate(Request.QueryString("DateS")), "MMMM-yy") & " עד " & _
        Format(CDate(Request.QueryString("DateB")), "MMMM-yy") & " (" & _
        Request.QueryString("BudgetIDtem") & ")"
    End Sub
    Public Function TruncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged

    End Sub
End Class
