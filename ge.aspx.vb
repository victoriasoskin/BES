Imports System.Net.Mail
Imports System.Net.Mail.MailMessage
Imports System.Web.Configuration
Imports System.Net.Configuration


Partial Class ge
    Inherits System.Web.UI.Page

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim s1 As String = ""
        If Request.QueryString("e") IsNot Nothing Then
            s1 = Request.QueryString("e")
        End If

        Dim s As String = "לא יודע?"
        Dim b As Boolean = False

        If Session("TheException") IsNot Nothing Then
            If InStr(LCase(Session("TheException")), "mac failed") = 0 Then
                b = True
                s = Session("TheException")
                Dim i As Integer = InStr(s, "ASP.")
                Dim j As Integer = InStr(s, "_aspx.")

                If i <> 0 And j <> 0 And j > i Then
                    s = "Program= " & Mid(s, i, j + 5) & "<br />" & s
                End If
            End If
        Else
            Try
                Dim ex As Exception = HttpContext.Current.Server.GetLastError()
                s = ex.ToString
                Dim iEx As Exception = HttpContext.Current.Error
                s = s & "<br /><br /><br />" & iEx.ToString
                b = True
            Catch ex As Exception

            End Try

        End If

        If Request.QueryString("aspxerrorpath") IsNot Nothing Then
            s = "<br />P2= " & Request.QueryString("aspxerrorpath") & "<br />" & s
            b = True
        End If

        If Session("UserID") IsNot Nothing Then
            s = "UserID= " & Session("UserID") & "<br />" & s
            b = True
        End If
        s = s & "  " & s1
        ' If InStr(LCase(s), "לא יודע") = 0 And InStr(LCase(Session("TheException")), "mac failed") = 0 Then SendMail(s)
        SendMail(s)
        If Request.QueryString("aspxerrorpath") IsNot Nothing Then
            Dim sa As String = LCase(Request.QueryString("aspxerrorpath"))
            If LCase(Request.QueryString("aspxerrorpath")) = "/surveys.aspx" Or LCase(Request.QueryString("aspxerrorpath")) = "/surveyentry.aspx" Then
                Server.Transfer("sessionerror.htm")
            End If

        End If

    End Sub
	Sub SendMail(ByVal sBody As String)
        Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        If Not mailSettings Is Nothing Then
            Dim password As String = mailSettings.Smtp.Network.Password
            Dim username As String = mailSettings.Smtp.Network.UserName
            Dim dd As SmtpClient = New SmtpClient()
            dd.Credentials = New System.Net.NetworkCredential(username, password)
            Dim m As New MailMessage()
            m.IsBodyHtml = True

            If sBody <> vbNullString Then
                m.Body = sBody
            End If

            m.Subject = "הודעה אוטומטית על תקלה במערכת הניהול"
            m.To.Add(New MailAddress("arielpell1@gmail.com"))
            m.From = New MailAddress("err@be-online.org")

            Try
                dd.Send(m)
            Catch ex As Exception
            End Try

        End If

    End Sub

End Class
