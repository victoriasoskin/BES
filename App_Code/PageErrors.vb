Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports BesConst
Public Class PageErrors
    Shared Sub WriteErrorLog(Optional bSurvey As Boolean = False, Optional SpecComment As String = vbNullString)
        If LCase(Left(HttpContext.Current.Request.Url.AbsoluteUri, 16)) = "http://localhost" Then Exit Sub
        Dim ex As Exception = HttpContext.Current.Server.GetLastError
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sSessID As String = HttpContext.Current.Session.SessionID
        Dim sHostIP = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(1).ToString()
        Dim s As String = HttpContext.Current.Request.Url.AbsoluteUri
        Dim sWeb As String
        Dim sBrswr As String = WhichBrowser()
        Dim sErr As String = "Unidentified Error"
        If ex IsNot Nothing Then
            sErr = ex.ToString() ' HttpContext.Current.Error.Message 'If(Server.GetLastError() Is Nothing, vbNullString, Server.GetLastError().InnerException.ToString.Replace("'", "''"))
        End If
        Dim sU As String = If(HttpContext.Current.Session("UserID") Is Nothing, "0", HttpContext.Current.Session("UserID"))
        Try

        Catch exxxx As Exception

        End Try
        Dim cd As New SqlCommand("INSERT INTO AA_errLog(ERRTime,UserID,errMessage,Page,SessionID,ComputerName,SourceID,Browser,SpecComment) VALUES(GETDATE()," & "0" & sU & ",'" & sErr.Replace("'", "''") & "','" & s.Replace("'", "''") & vbCrLf & _
           "','" & sSessID & "','" & sHostIP & "',0,'" & sBrswr & "'," & If(SpecComment = vbNullString, "NULL", "'" & SpecComment.Replace("'", "''") & "'") & ")", dbConnection)
        dbConnection.Open()
        Try
            cd.ExecuteNonQuery()
        Catch exx As Exception
            Throw exx
        Finally
            dbConnection.Close()
        End Try
        If Not bSurvey Then
            s = "<html><head><title></title></head><body style='direction:rtl;'><div style='position:absolute;top:30%;right:40%;height:150px;width:250px;background-color:#DDDDDD;border:2px outset #AAAAAA;text-align:center;'><br />"
            If sU = "0" Then
                sWeb = System.Configuration.ConfigurationManager.AppSettings("ReturnToEntry")
                s &= "לצערנו, נותקת מהמערכת<br />עליך לחזור ולהתחבר למערכת.<br /><br /><a href='" & sWeb & "'>לדף הכניסה למערכת</a></div></body></html>"
            Else
                sWeb = System.Configuration.ConfigurationManager.AppSettings("ReturnToDefault")
                s &= "לצערנו ארעה תקלה. <br />התקלה דווחה לצוות המערכת. <br /><br /><br /><a href='" & sWeb & "'>בחזרה למערכת</a></div></body></html>"
            End If
            HttpContext.Current.Server.ClearError()
            HttpContext.Current.Response.Write(s)
        End If


    End Sub
    Shared Sub WriteEntryLog()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sSessID As String = HttpContext.Current.Session.SessionID
        Dim sHostIP = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(1).ToString()

        Dim client_ip As String = HttpContext.Current.Request.UserHostAddress()

        Dim sBrswr As String = WhichBrowser()
        Dim s As String = HttpContext.Current.Request.Url.AbsoluteUri
        Dim sWeb As String = HttpContext.Current.Request.Url.Host
        Dim sU As String = If(HttpContext.Current.Session("UserID") Is Nothing, "0", HttpContext.Current.Session("UserID"))
        Dim cd As New SqlCommand("INSERT INTO AA_Log(LogTime,UserID,Page,SessionID,ClientIP,HostIP,SourceID,Browser)VALUES(GETDATE()," & "0" & sU & ",'" & s.Replace("'", "''") & vbCrLf & _
               "','" & sSessID & "','" & client_ip & "','" & sHostIP & "',0,'" & sBrswr & "')", dbConnection)
        dbConnection.Open()
        Try
            cd.ExecuteNonQuery()
        Catch exx As Exception
            Throw exx
        Finally
            dbConnection.Close()
        End Try
    End Sub
    Shared Function WhichBrowser() As String
        Dim s As String = vbNullString
        Try
            With HttpContext.Current.Request.Browser
                s &= "Browser Capabilities" & vbCrLf
                s &= "Type = " & .Type & vbCrLf
                s &= "Name = " & .Browser & vbCrLf
                s &= "Version = " & .Version & vbCrLf
                s &= "Major Version = " & .MajorVersion & vbCrLf
                s &= "Minor Version = " & .MinorVersion & vbCrLf
                s &= "Platform = " & .Platform & vbCrLf
                s &= "Is Beta = " & .Beta & vbCrLf
                s &= "Is Crawler = " & .Crawler & vbCrLf
                s &= "Is AOL = " & .AOL & vbCrLf
                s &= "Is Win16 = " & .Win16 & vbCrLf
                s &= "Is Win32 = " & .Win32 & vbCrLf
                s &= "Supports Frames = " & .Frames & vbCrLf
                s &= "Supports Tables = " & .Tables & vbCrLf
                s &= "Supports Cookies = " & .Cookies & vbCrLf
                s &= "Supports VBScript = " & .VBScript & vbCrLf
                s &= "Supports JavaScript = " & _
                    .EcmaScriptVersion.ToString() & vbCrLf
                s &= "Supports Java Applets = " & .JavaApplets & vbCrLf
                s &= "Supports ActiveX Controls = " & .ActiveXControls & _
                    vbCrLf
                s &= "Supports JavaScript Version = " & _
                    HttpContext.Current.Request.Browser("JavaScriptVersion") & vbCrLf
            End With
        Catch ex As Exception
        End Try
        Return s
    End Function
End Class
