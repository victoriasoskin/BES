Imports SurveysUtil
Imports WRCookies
Imports System.Data.SqlClient
Imports BesConst
Partial Class SurveyLogin
    Inherits System.Web.UI.Page
    Dim sSurveyName As String = vbNullString
    Dim sShortDesc As String = vbNullString
    Dim dSartDate As DateTime
    Dim dEndDate As DateTime
    Const sBrowsers As String = "ie,chrome"

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
         'Set up if Not post back Entry
        'If Request.QueryString("B") Is Nothing Then
        '    Response.Write("<div style='direction:rtl;font-size:large;'>הסקר סגור עד 21:20 לצרכי תחזוקה</div>")
        '    Response.End()
        'End If
        Dim sB As String = LCase(Request.Browser.Browser)
        Dim iB As Integer = InStr(sBrowsers, sB)
        If iB = 0 Then lblBrowsers.Visible = True
        Dim sn As String = getUrl("SurveysSql.aspx")
        'Set up if Not post back Entry
        'If Request.QueryString("B") Is Nothing Then
        '    Response.Write("<div style='direction:rtl;font-size:large;'>הסקר סגור עד 21:20 לצרכי תחזוקה</div>")
        '    Response.End()
        'End If
        If Not IsPostBack Then

            Session("PWD") = vbNullString

            ' If No Survey was specified - go to be website

            If Request.QueryString("S") Is Nothing Or Not IsNumeric(Request.QueryString("s")) Then
                lblSurveyName.Text = "קוד סקר לא חוקי"
                divlogin.Visible = False
            Else

                ' Read Survey record from data base

                SetSurveyCookies(Request.QueryString("S"), sSurveyName, sShortDesc, dSartDate, dEndDate, If(Request.QueryString("L") Is Nothing, "1", Request.QueryString("L")), "Book10VPS")

                If sSurveyName = vbNullString Then
                    Response.Redirect("http://www.b-e.org.il")
                End If

                ' Set Head of screen

                Dim s As String = sSurveyName & "<br /><br/>" & sShortDesc

                ' if the survey is not yet opened or already closed

                If Not (Now >= dSartDate And Now <= dEndDate) Then
                    s &= "<br/><br />הסקר סגור, תודה!"
                    tbpwd.Enabled = False
                End If

                lblSurveyName.Text = s

            End If

            ' Prepare button to check pwd

            btnLogin.Attributes.Add("onclick", "pop('" & tbpwd.ClientID & "','" & Session("PWD") & "','" & getUrl("/SurveysSql.aspx?s=" & Request.QueryString("S")) & "&L=" & If(Request.QueryString("L") Is Nothing, "1", Request.QueryString("L")) & "');")  '++++++ 

        End If

        ' Check Login Type (Not implemented)

        Dim j As Integer = 1

        Select Case j
            Case 1

        End Select
        tbpwd.Focus()

    End Sub

    Protected Sub tbpwd_TextChanged(sender As Object, e As System.EventArgs) Handles tbpwd.TextChanged
        '    Response.Redirect("SurveysSql.aspx?s=12")
    End Sub
    Function getUrl(sPage As String) As String
        Dim sUrl As String = Request.Url.AbsoluteUri
        sUrl = Left(sUrl, sUrl.Length - InStr(StrReverse(sUrl), "/")) & sPage
        Return sUrl
    End Function
End Class
