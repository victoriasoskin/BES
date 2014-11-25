Imports System.Data.SqlClient
Imports eid
Imports System.Net.Configuration
Imports System.Web.Configuration
Imports System.Net.Mail
Imports System.Net.Mail.MailMessage


Partial Class LeavingEmp
    Inherits System.Web.UI.Page
    Dim bClosed As Boolean = False
#Region "Page"

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("E") IsNot Nothing Then
                FVIEW.DefaultMode = FormViewMode.ReadOnly
            End If
        End If
    End Sub

    Sub SetFrame(Optional iServiceID As Integer = 0, Optional iFrameID As Integer = 0, Optional sFrameName As String = vbNullString)

        If Session("MultiFrame") = 0 Then
            Dim ddl As DropDownList = CType(FVIEW.FindControl("ddlServices"), DropDownList)
            ddl.Visible = False
            Dim lbl As Label = CType(FVIEW.FindControl("lblService"), Label)
            lbl.Visible = True
            lbl.Text = Session("ServiceName")
            ddl = CType(FVIEW.FindControl("ddlFrames"), DropDownList)
            ddl.Visible = False
            lbl = CType(FVIEW.FindControl("lblFrame"), Label)
            lbl.Visible = True
            lbl.Text = Session("FrameName")
            Dim rfv As RequiredFieldValidator = CType(FVIEW.FindControl("rfvFrame"), RequiredFieldValidator)
            rfv.Visible = False
        Else
            If iFrameID <> 0 And iServiceID <> 0 Then
                Dim ddl As DropDownList = CType(FVIEW.FindControl("ddlServices"), DropDownList)
                Dim li As ListItem = ddl.Items.FindByValue(iServiceID)
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                    ddl = CType(FVIEW.FindControl("ddlFrames"), DropDownList)
                    li = ddl.Items.FindByValue(iFrameID)
                    If li IsNot Nothing Then
                        ddl.ClearSelection()
                        li.Selected = True
                    Else
                        li = New ListItem(sFrameName, iFrameID)
                        ddl.Items.Add(li)
                        ddl.ClearSelection()
                        li.Selected = True
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub hdnUserName_PreRender(sender As Object, e As System.EventArgs)
        Dim hdn As HiddenField = CType(sender, HiddenField)
        Dim s As String = hdn.Value
        hdn = CType(FVIEW.FindControl("hdnCUserName"), HiddenField)
        If hdn.Value <> vbNullString Then
            s = "פניה סגורה. נפתחה ע""י " & s & ", נסגרה ע""י " & hdn.Value & "."
        Else
            s = "פניה פתוחה. נפתחה ע""י " & s & "."
        End If
        lblstatus.Text = s
        hdn = CType(FVIEW.FindControl("hdnid"), HiddenField)
        lblid.Text = hdn.Value
    End Sub

    Protected Sub DSFrames_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSFrames.Selecting
        If FVIEW.DefaultMode = FormViewMode.Insert Then
            e.Command.Parameters("@ServiceID").Value = CType(FVIEW.FindControl("ddlServices"), DropDownList).SelectedValue
        End If
    End Sub

#End Region

#Region "CBHas"

    Protected Sub CBHasCompanyCell_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim b As Boolean = cb.Checked
        Dim lbl As Label = CType(FVIEW.FindControl("Label4"), Label)
        lbl.Enabled = b
        Dim tb As Phone = CType(FVIEW.FindControl("TBWorkCellV"), Phone)
        tb.Enabled = b
        Dim rfv As RequiredFieldValidator = CType(FVIEW.FindControl("RFVWF"), RequiredFieldValidator)
        rfv.Enabled = b
    End Sub

    Protected Sub CBWorkEmail_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim b As Boolean = cb.Checked
        Dim lbl As Label = CType(FVIEW.FindControl("Label2"), Label)
        lbl.Enabled = b
        lbl = CType(FVIEW.FindControl("Label1"), Label)
        lbl.Enabled = b
        Dim tb As TBEmail = CType(FVIEW.FindControl("tbworkemail"), TBEmail)
        tb.Enabled = b
        Dim rbl As RadioButtonList = CType(FVIEW.FindControl("rblAction"), RadioButtonList)
        rbl.Enabled = b
        Dim rfv As RequiredFieldValidator = CType(FVIEW.FindControl("rfvworkemail"), RequiredFieldValidator)
        rfv.Enabled = b
        rfv = CType(FVIEW.FindControl("rfvMailAction"), RequiredFieldValidator)
        rfv.Enabled = b
    End Sub
    Protected Sub tbWorkEmail_PreRender(sender As Object, e As System.EventArgs)
        Dim tb As TBEmail = CType(sender, TBEmail)
        tb.Enabled = CType(FVIEW.FindControl("CBWorkEmail"), CheckBox).Checked
    End Sub

#End Region

#Region "EmpID"

    Protected Sub btnCID_Click(sender As Object, e As System.EventArgs)
        If IsPostBack Then
            Dim tbCID As Controls_CheckID = CType(FVIEW.FindControl("tbcheckid"), Controls_CheckID)
            ChckID(tbCID)
        End If
    End Sub

    Sub ChckID(tbCID As Controls_CheckID)
        Dim ddl As DropDownList
        Dim s As String = tbCID.Text
        If IsNumeric(s) Then

            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT CASE WHEN EXISTS(SELECT * FROM EL_LeavingEmps WHERE EmpID = " & s & " ) THEN 1 ELSE 0 END AS b", dbConnection)
            cD.CommandType = Data.CommandType.Text

            ' if existing Form

            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                If dr("b") <> 0 Then
                    dr.Close()
                    dbConnection.Close()
                    Response.Redirect("LeavingEmp.aspx?E=" & s)
                End If
            End If
            dr.Close()

            'If New Form Then

            cD.CommandText = "SELECT [שם משפחה],[שם פרטי],[התחלה],[שם תפקיד],[מספר זהות],[מעמד],e.FrameID,f.FrameName,f.ServiceID,[תפקיד] FROM emplist e Left outer join FrameList f on f.FrameID=e.FrameID WHERE [מספר זהות]=" & s & " AND f.FrameID in (SELECT FrameID From dbo.p0v_UserFrameList Where UserID = " & Session("UserID") & ")"
            dr = cD.ExecuteReader
            If dr.Read Then

                If Session("MultiFrame") <> 0 Then SetFrame(dr("ServiceID"), dr("FrameID"), dr("FrameName"))

                Dim tb As TextBox = CType(FVIEW.FindControl("tbFirstName"), TextBox)
                tb.Text = dr("שם פרטי")
                tb = CType(FVIEW.FindControl("tbLastName"), TextBox)
                tb.Text = dr("שם משפחה")
                Dim tbd As Controls_EnterDate = CType(FVIEW.FindControl("tbStartDate"), Controls_EnterDate)
                tbd.SelectedDate = Format(dr("התחלה"), "dd/MM/yyyy")

                ddl = CType(FVIEW.FindControl("ddlJobs"), DropDownList)
                Dim li As ListItem = ddl.Items.FindByText(dr("שם תפקיד"))
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                End If


                ddl = CType(FVIEW.FindControl("ddlJobCharacteristics"), DropDownList)
                li = ddl.Items.FindByValue(dr("מעמד"))
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                End If
            Else
                If CType(FVIEW.FindControl("tbfirstname"), TextBox).Text = vbNullString Then scrMsg("לא קיים עובד עם תעודת זהות זו ברשימת העובדים", True)
            End If
            dr.Close()
            dbConnection.Close()
        End If


    End Sub

    Protected Sub tbcheckid_TextChanged(sender As Object, e As System.EventArgs)
        If IsPostBack And FVIEW.DefaultMode <> FormViewMode.Edit Then
            Dim tbCID As Controls_CheckID = CType(CType(sender, TextBox).NamingContainer, Controls_CheckID)
            ChckID(tbCID)
        End If
    End Sub
#End Region

#Region "sql"

    Sub buildParams(e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs, sCmdType As String)

        bldParam(e, "@EmpID", "cid", "tbcheckid")
        bldParam(e, "@FirstName", "tb", "tbFirstName")
        bldParam(e, "@LastName", "tb", "tbLastName")
        bldParam(e, "@FrameID", "sfr", "ddlFrames")
        bldParam(e, "@JobID", "ddl", "ddlJobs")
        bldParam(e, "@Phone", "phn", "tbPhone")
        bldParam(e, "@WorkCell", "phn", "tbWorkCell")
        bldParam(e, "@WorkCellv", "phn", "tbWorkCellv")
        bldParam(e, "@PrivateCell", "phn", "tbPrivateCell")
        bldParam(e, "@WLID", "ddl", "ddlWL")
        bldParam(e, "@Startdate", "dt", "tbStartdate")
        bldParam(e, "@JobCharacteristicsID", "ddl", "ddlJobCharacteristics")
        bldParam(e, "@LeaveRequestDate", "dt", "tbLeaveRequestDate")
        bldParam(e, "@CalculatedLeavingDate", "lbl", "lblCalculatedLeavingDate")
        bldParam(e, "@ActualLeavingDate", "dt", "tbActualLeavingDate")
        bldParam(e, "@LeaveImmediatly", "cb", "CBLeaveImmediatly")
        bldParam(e, "@Email", "eml", "tbEmail")
        bldParam(e, "@WorkEMail", "eml", "tbWorkEmail")
        bldParam(e, "@WorkMailActionID", "rbl", "rblAction")
        bldParam(e, "@UserID", "ses", "UserID")
        bldParam(e, "@Comment", "tb", "tbComment")

    End Sub

    Sub bldParam(e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs, sParam As String, sContType As String, sCntrl1 As String, Optional sCntrl2 As String = vbNullString)
        Dim s As String = vbNullString
        Dim b As Boolean
        Dim tb As TextBox

        Select Case sContType

            Case "cid"
                Dim tbCID As Controls_CheckID = CType(FVIEW.FindControl(sCntrl1), Controls_CheckID)
                s = tbCID.Text

            Case "tb"
                tb = CType(FVIEW.FindControl(sCntrl1), TextBox)
                s = tb.Text

            Case "phn"
                Dim tbp As Phone = CType(FVIEW.FindControl(sCntrl1), Phone)
                s = tbp.Text

            Case "ddl"
                Dim ddl As DropDownList = CType(FVIEW.FindControl(sCntrl1), DropDownList)
                s = ddl.SelectedValue

            Case "sfr"
                If Session("MultiFrame") = 0 Then
                    s = Session("FrameID")
                Else
                    Dim ddl As DropDownList = CType(FVIEW.FindControl(sCntrl1), DropDownList)
                    s = ddl.SelectedValue
                End If

            Case "eml"
                Dim tbe As TBEmail = CType(FVIEW.FindControl(sCntrl1), TBEmail)
                s = tbe.Text

            Case "ses"
                s = If(Session(sCntrl1) <> vbNullString, Session(sCntrl1), "NULL")

            Case "dt"
                Dim tbd As Controls_EnterDate = CType(FVIEW.FindControl(sCntrl1), Controls_EnterDate)
                s = xDate(tbd.SelectedDate)

            Case "cb"
                Dim cb As CheckBox = CType(FVIEW.FindControl(sCntrl1), CheckBox)
                b = cb.Checked

            Case "lbl"
                Dim lbl As Label = CType(FVIEW.FindControl(sCntrl1), Label)
                s = lbl.Text

            Case "rbl"
                Dim rbl As RadioButtonList = CType(FVIEW.FindControl(sCntrl1), RadioButtonList)
                s = rbl.SelectedValue
        End Select

        If sContType = "cb" Then
            e.Command.Parameters(sParam).Value = b
        Else
            If s = vbNullString Then
                e.Command.Parameters(sParam).Value = DBNull.Value
            Else
                e.Command.Parameters(sParam).Value = s
            End If
        End If

    End Sub

    Protected Sub DSLE_Inserting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSLE.Inserting
        buildParams(e, "insert")
    End Sub

    Protected Sub DSLE_Updating(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSLE.Updating
        buildParams(e, "update")
    End Sub

    Function xDate(sText As String) As String
        If sText = vbNullString Then
            Return vbNullString
        ElseIf InStr(sText, "-") > 0 Then
            Return sText
        Else
            Dim s() As String = sText.Split("/")
            Return s(2) & "-" & s(1) & "-" & s(0)
        End If
    End Function

#End Region

#Region "Dates"

    Function byLowLeaveDate(dateS As DateTime, dateR As DateTime, iJC As Integer) As String
        Dim sLd As String = vbNullString
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("SELECT dbo.FNminLeaveDate('" & Format(dateS, "yyyy-MM-dd") & "','" & Format(dateR, "yyyy-MM-dd") & "'," & iJC & ") AS d ", dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            sLd = If(IsDBNull(dr("d")), vbNullString, Format(dr("d"), "dd/MM/yyyy"))
        End If
        Return sLd
    End Function

    Protected Sub btnSend_Click(sender As Object, e As System.EventArgs)
    End Sub

    Protected Sub tbActualLeavingDate_PreRender(sender As Object, e As System.EventArgs)
        Dim tbd As Controls_EnterDate = CType(sender, Controls_EnterDate)
        Dim s As String = CType(FVIEW.FindControl("lblCalculatedLeavingDate"), Label).Text
        Dim sLeavReq As String = CType(FVIEW.FindControl("tbLeaveRequestDate"), Controls_EnterDate).SelectedDate
        Dim b As Boolean = CType(FVIEW.FindControl("CBLeaveImmediatly"), CheckBox).Checked

        'if date is too early or Leave immediatly is true make Actual date equal to calculated

        If IsDate(s) Then
            If tbd.SelectedDate < CDate(s) Then
                tbd.SelectedDate = s
            End If
        End If

        'Leave immediatly is true make Actual date equal to Start

        If b And IsDate(sLeavReq) Then
            tbd.SelectedDate = sLeavReq
        End If

    End Sub

    Protected Sub lblCalculatedLeavingDate_PreRender(sender As Object, e As System.EventArgs)
        Dim s As String
        Dim dateR As DateTime
        Dim dateS As DateTime
        Dim lbl As Label = CType(sender, Label)
        s = CType(FVIEW.FindControl("tbStartDate"), Controls_EnterDate).SelectedDate
        If Not IsDate(s) Then Exit Sub
        dateS = CDate(s)
        s = CType(FVIEW.FindControl("tbLeaveRequestDate"), Controls_EnterDate).SelectedDate
        If Not IsDate(s) Then Exit Sub
        dateR = CDate(s)
        s = CType(FVIEW.FindControl("ddlJobCharacteristics"), DropDownList).SelectedValue
        If Not IsNumeric(s) Then Exit Sub

        lbl.Text = byLowLeaveDate(dateS, dateR, CInt(s))
        Dim cv As CompareValidator = CType(FVIEW.FindControl("COMPVALBL"), CompareValidator)
        Dim b As Boolean = CType(FVIEW.FindControl("CBLeaveImmediatly"), CheckBox).Checked
        cv.ValueToCompare = If(IsDate(lbl.Text) And Not b, CDate(lbl.Text), CDate("2000-1-1"))

    End Sub

#End Region

#Region "scrMsg"

    Sub scrMsg(sMsg As String, Optional bErr As Boolean = True, Optional bTowButtons As Boolean = False, Optional sbtnMsgText As String = "אישור", Optional sbtnMsgOnClickText As String = vbNullString, Optional sbtnTwoText As String = "ביטול", Optional sbtnTwoOnClickText As String = vbNullString)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:50%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"
        btnmsg.Text = sbtnMsgText
        If sbtnMsgOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnMsgOnClickText)

        If bTowButtons Then
            btnTwo.Visible = True
            btnTwo.Text = sbtnTwoText
            If sbtnTwoOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnTwoOnClickText)
            Dim i As Integer = If(sbtnMsgText.Length > sbtnTwoText.Length, sbtnMsgText.Length, sbtnTwoText.Length) * 10 + 20
            btnmsg.Width = i
            btnTwo.Width = i
        End If

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click, btnTwo.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
#End Region

#Region "EmpEmail"
    Function fEmail(sFld As String, iPrt As Integer, Optional sDef As String = vbNullString) As String
        Dim s As String = If(IsDBNull(Eval(sFld)), sDef, Eval(sFld))
        If s <> sDef Then
            If iPrt = 1 Then
                s = Left(s, InStr(s, "@") - 1)
            Else
                s = Mid(s, InStr(s, "@") + 1)
            End If
        End If
        Return s
    End Function
#End Region

#Region "ReportEmails"
    Sub SendEmails(iType As Integer, ByVal iMode As Integer, lEmpID As Long, Optional iMailType As Integer = 0)
        Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        If Not mailSettings Is Nothing Then
            Dim password As String = mailSettings.Smtp.Network.Password
            Dim username As String = mailSettings.Smtp.Network.UserName
            Dim dd As SmtpClient = New SmtpClient()
            dd.Credentials = New System.Net.NetworkCredential(username, password)
            Dim m As New System.Net.Mail.MailMessage
            m.IsBodyHtml = True

            Dim xMail As XElement = XElement.Load(MapPath("App_Data/EmpMails.xml"))

            Dim query = From q In xMail.Descendants("Fields").Elements("Field") _
             Select q.Value
            Dim cFields As New Collection
            For Each q In query
                cFields.Add(q)
            Next

            Dim FV As FormView = FVIEW
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

            Dim conCom As New SqlCommand("SELECT e.EmpID,e.FirstName+ ' '+ e.LastName EmpName,f.FrameName,f.ServiceID, s.ServiceName,ISNULL(u.URName,u.UserName) AS UName,e.Loadtime,CASE WHEN e.WorkEmail IS NULL THEN 'אין' ELSE e.WorkEmail END AS Mail,CASE WHEN e.WorkCellV IS NULL THEN 'אין' ELSE e.WorkCellV END AS CellPhone,e.WorkCellV AS CellPhoneNumber,e.WorkEmail As MailAddress,a.WorkMailAction As MailAction,ActualLeavingDate,Comment FROM EL_LeavingEmps AS e LEFT OUTER JOIN FrameList AS f ON f.FrameID = e.FrameID LEFT OUTER JOIN ServiceList AS s ON s.ServiceID = f.ServiceID LEFT OUTER JOIN EL_WL AS w ON w.WLID = e.WLID LEFT OUTER JOIN p0t_NtB AS u ON u.UserID = e.UserID LEFT OUTER JOIN EL_WorkMailActions a on a.WorkMailActionID = e.WorkMailActionID WHERE e.EmpID = " & lEmpID, dbConnection)
            dbConnection.Open()
            Dim dR As SqlDataReader = conCom.ExecuteReader
            If dR.Read Then

                m.From = New MailAddress("noreply@be-online.org")
                Dim QRecipient = From q In xMail.Descendants("Recipients").Descendants("Recipient") _
                Where (((q.Attribute("ServiceID").Value = 0) Or (q.Attribute("ServiceID").Value = dR("ServiceID"))) And _
                      (q.Attribute("MailType").Value = iMailType)) _
                Select New With { _
                    .Nam = q.Attribute("Name").Value, _
                    .Eml = q.Attribute("Email").Value}
                Dim cRNam As New Collection
                Dim cREml As New Collection

                For Each q In QRecipient
                    cRNam.Add(q.Nam)
                    cREml.Add(q.Eml)
                Next

                Dim qMail = From q In xMail.Descendants("MailGroup").Descendants("Mail") _
                Where ((q.Parent.Attribute("GroupID").Value = iType) And (q.Parent.Attribute("Mode").Value = iMode) And _
                 (q.Attribute("MailType").Value = iMailType)) _
                Select q

                For Each q In qMail
                    For j As Integer = 1 To cRNam.Count
                        m.To.Clear()
                        Dim sm As String = cREml(j)
                        m.To.Add(New MailAddress(sm))
                        m.Subject = q.Element("Subject").Value
                        Dim s As String = q.Element("Body").Value
                        s = s.Replace("%Name%", cRNam(j))
                        For i = 1 To cFields.Count
                            Dim s1 As String = cFields(i)
                            Dim s2 As String
                            Try
                                s2 = dR(s1)
                            Catch ex As Exception
                                s2 = vbNullString
                            End Try
                            s = Replace(s, "#" & s1 & "#", s2)
                        Next
                        s = Replace(Replace(s, "[", "<"), "]", ">")
                        m.Body = "<html dir=""rtl""><body>" & s & "</body></html>"
                        Try
                            dd.Send(m)
                        Catch ex As Exception
                            Response.Write("<script>alert('תקלה במשלוח דוא""ל. יש לבדוק אם יש קישור לאינטרנט. אם יש, נא לדווח למוקד השירות');</script>")
                        End Try
                    Next
                Next

            End If
            dR.Close()
            dbConnection.Close()
        End If

    End Sub

    Protected Sub DSLE_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSLE.Inserted
        Dim l As Long = CType(CType(FVIEW.FindControl("tbCheckID"), Controls_CheckID).Text, Long)
        SendEmails(2, 1, l, 0)
        If CType(CType(FVIEW.FindControl("tbWorkCellV"), Phone).Text, String) <> vbNullString Then SendEmails(2, 1, l, 2)
        If CType(CType(FVIEW.FindControl("tbWorkEmail"), TBEmail).Text, String) <> vbNullString Then SendEmails(2, 1, l, 3)
        scrMsg("טופס עזיבת עובד נקלט במערכת<br />הודעה נשלחה למשאבי אנוש.<br />תודה.", False)
    End Sub

    Protected Sub DSLE_Updated(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSLE.Updated
        scrMsg("טופס עזיבת עובד עודכן במערכת", False)
    End Sub

#End Region

    Protected Sub FVIEW_PreRender(sender As Object, e As System.EventArgs) Handles FVIEW.PreRender
        If Not IsPostBack Then
            If FVIEW.DefaultMode = FormViewMode.Insert Then
                SetFrame()
            End If
        End If
    End Sub
    Protected Sub tbActualLeavingDate_TextChanged(sender As Object, e As System.EventArgs)
        Dim tbd As Controls_EnterDate = CType(FVIEW.FindControl("tbActualLeavingDate"), Controls_EnterDate)
        Dim lbl As Label = CType(FVIEW.FindControl("lblCalculatedLeavingDate"), Label)
        If IsDate(lbl.Text) Then
            If CDate(tbd.SelectedDate) < CDate(lbl.Text) Then
                scrMsg("תאריך עזיבה בפועל צריך להיות גדול מתאריך לפי חוק", True)
            End If
        End If
    End Sub
End Class

