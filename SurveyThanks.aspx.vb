Imports WRCookies
Imports SurveysUtil
Imports BesConst
Partial Class SurveyThanks
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sSurveyName As String = vbNullString
        Dim sShortDesc As String = vbNullString
        Dim dSartDate As DateTime
        Dim dEndDate As DateTime
        Dim sL As String = If(Request.QueryString("L") Is Nothing, "1", If(Request.QueryString("L") = vbNullString, "1", If(IsNumeric(Request.QueryString("L")), Request.QueryString("L"), "1")))
        SetSurveyCookies(Request.QueryString("S"), sSurveyName, sShortDesc, dSartDate, dEndDate, sL, "Book10VPS")
        If sSurveyName Is Nothing Then
            Response.Redirect("http://www.b-e.org.il")
        Else
            lblSurveyName.Text = sSurveyName & "<br /><br />" & sShortDesc
        End If
    End Sub
End Class
