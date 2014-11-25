Imports System.Data.SqlClient
Imports PageErrors
Partial Class CustErrs
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Response.TrySkipIisCustomErrors = True
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sSessID As String = Session.SessionID
        Dim sBrswr As String = WhichBrowser()
        Dim sHostIP = System.Net.Dns.GetHostAddresses(System.Net.Dns.GetHostName()).GetValue(1).ToString()
        Dim s As String = Request.Url.AbsoluteUri
        Dim sWeb As String = Request.Url.ToString
        Dim sErr As String = If(Server.GetLastError Is Nothing, vbNullString, Server.GetLastError.InnerException.Message) ' HttpContext.Current.Error.Message 'If(Server.GetLastError() Is Nothing, vbNullString, Server.GetLastError().InnerException.ToString.Replace("'", "''"))
        Dim sU As String = If(Session("UserID"), "0", Session("UserID"))
        Dim cd As New SqlCommand("INSERT INTO AA_errLog(ERRTime,UserID,errMessage,Page,SessionID,ComputerName,SourceID,Browser)VALUES(GETDATE()," & "0" & sU & ",'" & sErr & "','" & s.Replace(",", ",,") & vbCrLf & _
           "','" & sSessID & "','" & sHostIP & "',0,'" & sBrswr & "')", dbConnection)
        dbConnection.Open()
        Try
            cd.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        Finally
            dbConnection.Close()
        End Try
        s = "<html><head><title></title></head><body style='direction:rtl;'><div style='position:absolute;top:30%;right:40%;height:150px;width:250px;background-color:#DDDDDD;border:2px outset #AAAAAA;text-align:center;'><br />"
        If sU = "0" Then
            sWeb = System.Configuration.ConfigurationManager.AppSettings("ReturnToEntry")
            s &= "לצערנו, נותקת מהמערכת<br />עליך לחזור ולהתחבר למערכת.<br /><br /><a href='" & sWeb & "'>לדף הכניסה למערכת</a></div></body></html>"
        Else
            sWeb = System.Configuration.ConfigurationManager.AppSettings("ReturnToDefault")
            s &= "לצערנו ארעה תקלה. <br />התקלה דווחה לצוות המערכת. <br /><br /><br /><a href='" & sWeb & "'>בחזרה למערכת</a></div></body></html>"
        End If
        Server.ClearError()
        Response.Write(s)

        'HttpContext.Current.Session("progname") = Environment.GetCommandLineArgs().ToString
        'System.Diagnostics.Debugger.Break()
        ' Code that runs when an unhandled error occurs
        '	Try
        '		Dim ex As Exception = HttpContext.Current.Server.GetLastError()
        '			HttpContext.Current.Session("TheException") = ex.ToString
        '	Catch ex1 As Exception

        '	End Try
        'HttpContext.Current.Server.ClearError()
        'HttpContext.Current.Server.Transfer("ge.aspx")
        'Code that runs when an unhandled error occurs
        'HttpContext.Current.Session("page")

    End Sub
End Class
