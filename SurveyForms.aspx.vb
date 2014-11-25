Imports WRCookies
Imports BesConst
Imports SurveysUtil
Imports PageErrors

Partial Class SurveyForms
    Inherits System.Web.UI.Page
    Dim sSurveyName As String = vbNullString
    Dim sShortDesc As String = vbNullString
    Dim dSartDate As DateTime
    Dim dEndDate As DateTime

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        If IsNumeric(ddlSurveys.SelectedValue) Then
            SetSurveyCookies(ddlSurveys.SelectedValue, sSurveyName, sShortDesc, dSartDate, dEndDate, 1, "Book10VPS")
            Session("PWD") = ReadCookie(SurveyCookiesKey, SurveyCookiePWD)
            Session("Repetative") = "1"
            Response.Redirect("SurveysSqlTemp.aspx?s=" & ddlSurveys.SelectedValue)
        End If
    End Sub

    Protected Sub ddlSurveys_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSurveys.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        WriteCookie(SurveyCookiesKey, "LastSurvey", ddl.SelectedValue)
     End Sub

    Protected Sub ddlSurveys_PreRender(sender As Object, e As System.EventArgs) Handles ddlSurveys.PreRender
        If Not IsPostBack Then
            If ReadCookie(SurveyCookiesKey, "LastSurvey") IsNot Nothing Then
                Dim ddl As DropDownList = CType(sender, DropDownList)
                Dim li As ListItem = ddl.Items.FindByValue(ReadCookie(SurveyCookiesKey, "LastSurvey"))
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                End If
            End If
        End If
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
End Class
