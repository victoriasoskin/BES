Imports Microsoft.VisualBasic
Imports System.IO
Imports System.Security.Cryptography
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.Net.Mail
Imports System.Data.SqlClient

Public Class eid

    ' Encrypt the text 
	Public Shared Function EncryptText(ByVal strText As String) As String
		Return Encrypt(strText, "&%#@?,:*")
	End Function

	'Decrypt the text 
	Public Shared Function DecryptText(ByVal strText As String) As String
		Return Decrypt(strText, "&%#@?,:*")
	End Function


	'The function used to encrypt the text
	Private Shared Function Encrypt(ByVal strText As String, ByVal strEncrKey _
	   As String) As String
		Dim byKey() As Byte = {}
		Dim IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}

		Try
			byKey = System.Text.Encoding.UTF8.GetBytes(Left(strEncrKey, 8))

			Dim des As New DESCryptoServiceProvider()
			Dim inputByteArray() As Byte = Encoding.UTF8.GetBytes(strText)
			Dim ms As New MemoryStream()
			Dim cs As New CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write)
			cs.Write(inputByteArray, 0, inputByteArray.Length)
			cs.FlushFinalBlock()
			Return Convert.ToBase64String(ms.ToArray())

		Catch ex As Exception
			Return ex.Message
		End Try

	End Function

	'The function used to decrypt the text
	Private Shared Function Decrypt(ByVal strText As String, ByVal sDecrKey _
	  As String) As String
		Dim byKey() As Byte = {}
		Dim IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}
		Dim inputByteArray(strText.Length) As Byte

		Try
			byKey = System.Text.Encoding.UTF8.GetBytes(Left(sDecrKey, 8))
			Dim des As New DESCryptoServiceProvider()
			inputByteArray = Convert.FromBase64String(strText)
			Dim ms As New MemoryStream()
			Dim cs As New CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write)

			cs.Write(inputByteArray, 0, inputByteArray.Length)
			cs.FlushFinalBlock()
			Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8

			Return encoding.GetString(ms.ToArray())

		Catch ex As Exception
			Return ex.Message
		End Try

	End Function
	Shared Function LoadSession(ByVal s As String) As String
		Try
			Return HttpContext.Current.Session(s)

		Catch ex As Exception
			HttpContext.Current.Response.Redirect("Sessionended.htm")
			Return Nothing

		End Try
		If HttpContext.Current.Session(s) IsNot Nothing Then
		Else
		End If
	End Function
    Shared Sub SendErrMail(ByVal Subj As String, ByVal sBody As String, Optional ByVal sToMail1 As String = "ariel@topyca.com", Optional ByVal sToMail2 As String = "arielpelli1@gmail.com", Optional ByVal sFromMail As String = "beErr@be-online.org")
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

            m.Subject = Subj
            m.To.Add(New MailAddress(sToMail1))
            If sToMail2 <> vbNullString Then m.To.Add(New MailAddress(sToMail2))
            m.From = New MailAddress(sFromMail)

            Try
                dd.Send(m)
            Catch ex As Exception
            End Try

        End If

    End Sub
    Shared Function FindControlRecursive(ByVal ctrl As Control, ByVal id As String) As Control
        Dim c As Control = Nothing

        If LCase(ctrl.ID) = LCase(id) Then
            c = ctrl
        Else
            For Each childCtrl In ctrl.Controls
                Dim resCtrl As Control = FindControlRecursive(childCtrl, id)
                If resCtrl IsNot Nothing Then c = resCtrl
            Next
        End If
        Return c
    End Function
    Shared Sub InsertLog(iAct As Integer, iUsr As Integer, Optional sComm As String = vbNullString)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim strClientIP As String = HttpContext.Current.Request.UserHostAddress().ToString
        Dim cD As New SqlCommand("INSERT INTO LogTable(ActionID,UserID,TimeLg,IP, Comment) Values(" & iAct & "," & iUsr & ",'" & Format(Now(), "yyyy-MM-dd HH:mm:ss") & "','" & strClientIP & "'," & If(sComm = vbNullString, "NULL", "'" & sComm.Replace("'", "''") & "'") & ")", dbConnection)
        'HttpContext.Current.Response.Write(cD.CommandText)
        'HttpContext.Current.Response.End()
        dbConnection.Open()
        cD.ExecuteNonQuery()
        dbConnection.Close()
    End Sub
    Shared Sub UserLogin(iUserID As Integer, sConnstring As String)
        Dim connStr As String = ConfigurationManager.ConnectionStrings(sConnstring).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select u.UserID, UserName,Password,ServiceID,ServiceName,MainFrameID,FrameId,UserGroupID,Stype,URName,CanDelete,CanEdit,SUser,Multiframe,FrameName,ISNULL(xPw,0) as xPw From p0v_Ntb u Where UserID=" & iUserID, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        If dr.Read() Then
            HttpContext.Current.Session("UserID") = dr("UserID")
            HttpContext.Current.Session("UserName") = dr("UserName")
            HttpContext.Current.Session("Stype") = dr("SType")
            HttpContext.Current.Session("CanDelete") = dr("CanDelete")
            HttpContext.Current.Session("CanEdit") = dr("CanEdit")
            HttpContext.Current.Session("SUser") = dr("Suser")
            HttpContext.Current.Session("FrameName") = dr("FrameName")
            HttpContext.Current.Session("serviceName") = dr("ServiceName")
        Else
            dbConnection.Close()
            HttpContext.Current.Response.Redirect("/entry.aspx")
        End If

    End Sub
End Class
