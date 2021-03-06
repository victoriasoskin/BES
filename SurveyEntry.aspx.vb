Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Net.Mail.MailMessage
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Net.Configuration
Imports System.Data.DbType
Imports System.Data
Imports eid

Partial Class SurveyEntry
    Inherits System.Web.UI.Page
    Dim bcls As Boolean
    Dim bPWP As Boolean
    Dim bIDChanged As Boolean
    Dim SurveyNum As String = "8"

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim iID As Long
        Dim tb As TextBox
        Dim s As String
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        Dim CVEMPIDU As CustomValidator = CType(fv.FindControl("CVEMPIDU"), CustomValidator)
        Dim CV2 As CustomValidator = CType(fv.FindControl("CV2"), CustomValidator)
        Dim CVPW As CustomValidator = CType(fv.FindControl("CVPW"), CustomValidator)
        tb = CType(fv.FindControl("tbID"), TextBox)
        If Session("SurveyPWD") IsNot Nothing Then
            If tb.Text = vbNullString Then iID = GetSurveyPIN() Else iID = tb.Text
            If iID > 0 Then
                Session("LastCustID") = iID
                Session("UserID") = 32111
                Session("FrameID") = 10000
                Session("FrameName") = "בחר מסגרת"
                GoToSurvey(CInt(SurveyNum), iID)
            End If
        Else
            iID = If(IsNumeric(tb.Text), CLng(tb.Text), 0)
        End If
        If If(Session("SurveyPWD") Is Nothing, CV2.IsValid, True) And CVPW.IsValid Then
            If iID = 0 And Session("SurveyPWD") IsNot Nothing Then Session("BKSTATUS") = 1
            Select Case Session("BKSTATUS")
                Case 1
                    Session("BKSTATUS") = 3
                Case 2
                    Session("BKSTATUS") = 4
                Case 3                  ' password OK - go to survey
                    tb = CType(fv.FindControl("tbID"), TextBox)
                    GoToSurvey(CInt(SurveyNum), iID)
                Case 4                  'get new password
                    tb = CType(fv.FindControl("tbnpw1"), TextBox)
                    s = tb.Text
                    If s <> vbNullString Then
                        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                        Dim ConComp As New SqlCommand("update SurveyIDlist set Password='" & EncryptText(s) & "' where id=" & iID & " And SurveyID=" & SurveyNum, dbConnection)
                        ConComp.CommandType = Data.CommandType.Text
                        dbConnection.Open()
                        Try
                            ConComp.ExecuteNonQuery()
                        Catch ex As Exception

                        End Try
                        dbConnection.Close()
                        GoToSurvey(CInt(SurveyNum), CLng(tb.Text))
                    Else
                        Response.Redirect("~/SurveyEntry.aspx?s=" & SurveyNum)
                    End If
                Case 5
                    '                tb = CType(fv.FindControl("tbID"), TextBox)
                    GoToSurvey(CInt(SurveyNum), iID)
            End Select
        End If
    End Sub
    Sub FVstat1(ByVal fv As FormView, ByVal bVisible As Boolean)
        Dim tb As TextBox = CType(fv.FindControl("TBEPW"), TextBox)
        Dim lbl As Label = CType(fv.FindControl("LBLEPW"), Label)
        Dim rfv As RequiredFieldValidator = CType(fv.FindControl("RFVepw"), RequiredFieldValidator)
        tb.Visible = bVisible
        lbl.Visible = bVisible
        rfv.Visible = bVisible
        If bVisible Then tb.Focus()

    End Sub
    Sub FVstat2(ByVal fv As FormView, ByVal bVisible As Boolean)
        Dim tb As TextBox = CType(fv.FindControl("TBNPW1"), TextBox)
        Dim lbl As Label = CType(fv.FindControl("LBLNPW1"), Label)
        Dim rfv As RequiredFieldValidator = CType(fv.FindControl("rfvpw1"), RequiredFieldValidator)
        tb.Visible = bVisible
        lbl.Visible = bVisible
        lbl = CType(fv.FindControl("LBLNPw"), Label)
        lbl.Visible = bVisible
        If bVisible Then tb.Focus()
        tb = CType(fv.FindControl("TBNPW2"), TextBox)
        lbl = CType(fv.FindControl("LBLNPW2"), Label)
        rfv = CType(fv.FindControl("RFVpw2"), RequiredFieldValidator)
        tb.Visible = bVisible
        lbl.Visible = bVisible
        rfv.Visible = bVisible

    End Sub
    Sub FVstat3(ByVal fv As FormView, ByVal bVisible As Boolean)
        Dim ddl As DropDownList = CType(fv.FindControl("ddlframe"), DropDownList)
        Dim lbl As Label = CType(fv.FindControl("LBLframe"), Label)
        Dim tb As TextBox = CType(fv.FindControl("TBID"), TextBox)
        ddl.Visible = bVisible
        lbl.Visible = bVisible
        If bVisible Then
            HDNID.Value = tb.Text
            ddl.DataBind()
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim ips As Integer
            Dim sPWD As String = vbNullString
            Dim sXMLf As String = vbNullString
            If Session("SurveyPWD") IsNot Nothing Then sPWD = Session("SurveyPWD")
            If Session("XMLFile") IsNot Nothing Then sXMLf = Session("XMLFile")
            If Session("PWDSupplied") = 1 Then ips = 1 Else ips = 0
            Session.Clear()
            If ips = 1 Then Session("PWDSupplied") = 1
            If sPWD <> vbNullString Then Session("SurveyPWD") = sPWD
            If sXMLf <> vbNullString Then Session("XMLFile") = sXMLf
        End If
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select D From dbo.p0t_AppClosed", dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        Dim d As DateTime = dr("D")
        If Err.Number = 0 Then
            'LBLCLS.Text = "סגור לתחזוקה עד יום " & Format(d, "ddd") & ", " & Format(d, "dd/MM/yy") & " בשעה " & Format(d, "H:mm") & ". להתראות."
            LBLCLS.Visible = True
            bcls = True
        Else
            bcls = False
        End If
        If Session("PWDSupplied") = 1 Then LOGIN()

        FVLOGIN.FindControl("BTNLOGIN").Focus()
    End Sub
    Protected Sub Button2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        '    Page.MasterPageFile = "SHERUT.MASTER"
    End Sub

    Protected Sub lblhdr3_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblhdr3.PreRender
        Dim lbl As Label = CType(sender, Label)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select Survey,XMLFile,SurveyType,PWD From vSurveys Where SurveyID=" & 0 & SurveyNum, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        If dr.Read() Then
            lbl.Text = dr("Survey")
            Session("SurveyName") = lbl.Text
            Session("XMLFile") = dr("XMLFile")
            Session("Mode") = dr("SurveyType")
            If Session("BKSTATUS") Is Nothing Then Session("BKstatus") = 1
            If dr("PWD") IsNot DBNull.Value Then
                Session("SurveyPWD") = dr("PWD")
                If Session("PWDSupplied") <> 1 Then
                    Response.Redirect("SurveyPassword.aspx?s=" & 0 & SurveyNum)
                End If
            End If
        Else
            dr.Close()
            dbConnection.Close()
            Response.Redirect("surveyentry.aspx?s=8") '("http://www.b-e.org.il")
        End If
        dr.Close()
        dbConnection.Close()

    End Sub
    Sub TBID_validate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        args.IsValid = IDOKyet(args.Value)
    End Sub
    Function IDOKyet(ByVal s As String, Optional ByVal bNotDone As Boolean = False, Optional ByVal iframeid As Integer = 0) As Boolean
        If Session("SurveyPWD") IsNot Nothing Then Return True
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim s1 As String = "select ID,isnull(Done,0) As Done,isnull(Password,'-') As Password From SurveyIDList Where ID=" & s & " And SurveyID=" & SurveyNum
        If iframeid <> 0 Then s1 = s1 & " And FrameID = " & iframeid
        Dim conCom As New SqlCommand(s1, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader
        Try
            dr = conCom.ExecuteReader

        Catch ex As Exception
            Response.Write(s1)
            Response.End()
        End Try
        Dim i As Integer = 0
        Dim b As Boolean = False
        b = dr.Read
        If b Then
            Dim k As Integer = dr("Done")
            If bNotDone Then b = k <> -1
        End If
        dr.Close()
        dbConnection.Close()
        Return b
    End Function
    Sub TBPW_validate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        Dim cv As CustomValidator = CType(sender, CustomValidator)
        Dim fv As FormView = CType(cv.NamingContainer, FormView)
        Dim tb As TextBox = CType(fv.FindControl("tbepw"), TextBox)
        If tb.Visible Then
            Dim s As String = args.Value
            args.IsValid = EncryptText(s) = Session("PW")
            If Not cv.IsValid Then
                If Session("TPW") IsNot Nothing Then
                    Session("TPW") = Session("TPW") + 1
                Else
                    Session("TPW") = 1
                End If
            End If
        End If
    End Sub
    Sub GoToSurvey(ByVal SureveyID As Integer, ByVal ID As Long)
        If Session("Mode") = "survey" And InStr(Session("FrameID"), "|") > 0 And ViewState("frameselected") <> 1 Then
            FVstat1(FVLOGIN, False)
            FVstat2(FVLOGIN, False)
            FVstat3(FVLOGIN, True)
            Session("BKSTATUS") = 5
        Else
            Session("UserID") = 32111
            Dim ddl As DropDownList = CType(FVLOGIN.FindControl("ddlframe"), DropDownList)
            If ddl IsNot Nothing AndAlso ddl.SelectedIndex > 0 Then Session("Frameid") = ddl.SelectedValue & vbNullString
            Dim b As Boolean
            If Session("Mode") = "vote" Then
                b = IDOKyet(Session("LastCustID"), True)
            Else
                Dim tb As TextBox = CType(FVLOGIN.FindControl("TBID"), TextBox)
                b = IDOKyet(tb.Text, True, Session("FrameID"))
            End If
            If b Then
                Response.Redirect("~/SurveysSQL.aspx?f=" & Session("XMLFile"))
            Else
                Dim lbl As Label = CType(FVLOGIN.FindControl("lblerr"), Label)
                lbl.Visible = True
                FVstat1(FVLOGIN, False)
            End If
        End If
    End Sub

    Protected Sub TBnpw2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("BKSTATUS") = 4
    End Sub
    Protected Sub TBepw_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Session("BKSTATUS") = 3
    End Sub
    Protected Sub TBID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        bIDChanged = True
        Dim tb As TextBox = CType(sender, TextBox)
        Dim fv As FormView = CType(tb.NamingContainer, FormView)
        Dim lbl As Label = CType(fv.FindControl("lblerr"), Label)
        lbl.Visible = False
        Dim cv As CustomValidator = CType(fv.FindControl("CV2"), CustomValidator)
        If cv.IsValid And tb.Text <> vbNullString Then
            Session("LastCustID") = tb.Text

            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim conCom As New SqlCommand("select ID,isnull(Done,0) As Done,isnull(Password,'-') As Password,FrameID From SurveyIDList Where ID=" & tb.Text & " And SurveyID=" & SurveyNum, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = conCom.ExecuteReader
            Dim b As Boolean = False
            Dim s As String = vbNullString
            While dr.Read
                b = True
                Session("FormNO") = dr("Done")
                If Session("SurveyPWD") IsNot Nothing And Session("FormNo") IsNot Nothing Then
                    Session("BKSTATUS") = 3
                    Exit Sub
                End If
                s = s & dr("FrameID") & "|"
                If dr("Password") = "-" Then
                    Session("BKSTATUS") = 2 ' should define password
                    FVstat1(fv, False) ' New password
                    FVstat2(fv, True)
                    FVstat3(fv, False)
                Else
                    Session("PW") = dr("Password")
                    Session("BKSTATUS") = 1 ' there is already password
                    FVstat1(fv, True) ' already has password
                    FVstat2(fv, False)
                    FVstat3(fv, False)

                End If
            End While
            If Len(s) > 1 Then
                Session("FrameiD") = Left(s, Len(s) - 1)
            Else
                Response.Redirect("~/SurveyEntry.aspx?s=" & SurveyNum)
            End If
        End If
    End Sub
    Protected Sub btnmail_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim s As String = "שם: " & TBNAME.Text
        s = s & "<br /> טלפון: " & TBPHONE.Text
        s = s & "<br /> מייל: " & tbemail.Text
        s = s & "<br />" & tbmail.Text
        SendMail(s)
        tbmail.Text = vbNullString
        pnlmail.Visible = False
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

            m.Subject = " פניית נסקר: " & lblhdr3.Text

            'm.To.Add(New MailAddress("rotemz@b-e.org.il"))
            m.To.Add(New MailAddress("rotemz@b-e.org.il"))
            m.From = New MailAddress("Survey@be-online.org")

            Try
                dd.Send(m)
            Catch ex As Exception
                Throw ex
            End Try

        End If

    End Sub

    Protected Sub lnkbshowmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkbshowmail.Click
        pnlmail.Visible = True
        TBNAME.Focus()
    End Sub

    Protected Sub dsframes_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles dsframes.Selecting
        Dim tb As TextBox = CType(FVLOGIN.FindControl("TBEID"), TextBox)
        Try
            'e.Command.Parameters("ID").Value = CLng("0" & tb.Text)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub ddlframe_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        ViewState("frameselected") = 1
    End Sub

    Protected Sub TextBox3_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tbmail.TextChanged

    End Sub

    Protected Sub FVLOGIN_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FVLOGIN.PreRender
        If Session("SurveyPWD") IsNot Nothing Then
            Dim fv As FormView = CType(sender, FormView)
            Dim lbl As Label = CType(fv.FindControl("lblexh"), Label)
            lbl.Text = "<u>לסקר חדש</u> לחץ <b>כניסה</b><br/><u>להמשיך סקר</u> הקש מספר סקר ואז <b>כניסה</b>."
            Dim rfv As RequiredFieldValidator = CType(fv.FindControl("rfv1"), RequiredFieldValidator)
            rfv.Enabled = False
            Dim cv2 As CustomValidator = CType(fv.FindControl("CV2"), CustomValidator)
            cv2.Enabled = False
        End If
    End Sub
    Function GetSurveyPIN() As Integer
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim conCom As New SqlCommand("GetSurveyPIN", dbConnection)
        conCom.CommandType = CommandType.StoredProcedure
        conCom.Parameters.AddWithValue("@SurveyID", SurveyNum)
        Dim df As New SqlParameter("PIN", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        conCom.Parameters.Add(df)
        dbConnection.Open()
        conCom.ExecuteNonQuery()
        Dim iPP As Int16 = conCom.Parameters("PIN").Value
        dbConnection.Close()
        Return iPP
    End Function
    Sub LOGIN()
        Dim iID As Long
        Dim tb As TextBox
        Dim s As String
        Dim fv As FormView = CType(FVLOGIN, FormView)
        Dim CVEMPIDU As CustomValidator = CType(fv.FindControl("CVEMPIDU"), CustomValidator)
        Dim CV2 As CustomValidator = CType(fv.FindControl("CV2"), CustomValidator)
        Dim CVPW As CustomValidator = CType(fv.FindControl("CVPW"), CustomValidator)
        '  tb = CType(fv.FindControl("tbID"), TextBox)
        If Session("SurveyPWD") IsNot Nothing Then
            If vbNullString = vbNullString Then iID = GetSurveyPIN() Else iID = 0
            If iID > 0 Then
                Session("LastCustID") = iID
                Session("UserID") = 32111
                Session("FrameID") = 10000
                Session("FrameName") = "בחר מסגרת"
                GoToSurvey(CInt(SurveyNum), iID)
            End If
        Else
            iID = If(IsNumeric(vbNullString), CLng(tb.Text), 0)
        End If
        If If(Session("SurveyPWD") Is Nothing, CV2.IsValid, True) And CVPW.IsValid Then
            If iID = 0 And Session("SurveyPWD") IsNot Nothing Then Session("BKSTATUS") = 1
            Select Case Session("BKSTATUS")
                Case 1
                    Session("BKSTATUS") = 3
                Case 2
                    Session("BKSTATUS") = 4
                Case 3                  ' password OK - go to survey
                    tb = CType(fv.FindControl("tbID"), TextBox)
                    GoToSurvey(CInt(SurveyNum), iID)
                Case 4                  'get new password
                    tb = CType(fv.FindControl("tbnpw1"), TextBox)
                    s = tb.Text
                    If s <> vbNullString Then
                        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                        Dim ConComp As New SqlCommand("update SurveyIDlist set Password='" & EncryptText(s) & "' where id=" & iID & " And SurveyID=" & SurveyNum, dbConnection)
                        ConComp.CommandType = Data.CommandType.Text
                        dbConnection.Open()
                        Try
                            ConComp.ExecuteNonQuery()
                        Catch ex As Exception

                        End Try
                        dbConnection.Close()
                        GoToSurvey(CInt(SurveyNum), CLng(tb.Text))
                    Else
                        Response.Redirect("~/SurveyEntry.aspx?s=" & SurveyNum)
                    End If
                Case 5
                    '                tb = CType(fv.FindControl("tbID"), TextBox)
                    GoToSurvey(CInt(SurveyNum), iID)
            End Select
        End If

    End Sub
End Class
