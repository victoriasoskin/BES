Imports System.Net.Mail
Imports System.Net.Mail.MailMessage
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Net.Configuration
Imports System.Data.SqlClient
Imports System.Data.DbType
Imports System.Data
Imports eid

Partial Class EmpForm
    Inherits System.Web.UI.Page
	Dim cChecked As Collection
	Dim sDateField As String
	Dim sDateText As String
	Dim iType As Integer
    Const BackDays As Double = -14
	Const ForeDays As Double = 30
	Dim iMailSent As Integer


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        iType = 1
        'If Request.QueryString("T") IsNot Nothing Then

        DIVALL.Visible = True

        '       iType = Request.QueryString("T")
        Select Case iType
            Case 1
                XDACTS.DataFile = "~/App_Data/InEmpActs.xml"
                sDateField = "FirstDate"
                sDateText = "תאריך התחלה"
                hlactiontype.Text = "מצורף נוהל קליטת עובד:"
                hlactiontype.NavigateUrl = "App_Docs/נוהל_קליטת_עובד_חדש_לארגון.doc"

            Case 2
                XDACTS.DataFile = "~/App_Data/OutEmpActs.xml"
                sDateField = "LastDate"
                sDateText = "תאריך סיום"
                hlactiontype.Text = "מצורף נוהל סיום העסקת עובד:"
                hlactiontype.NavigateUrl = "App_Docs/נוהל_סיום_העסקת_עובד_בארגון.doc"

        End Select

        buttonCheck.Attributes.CssStyle("visibility") = "hidden"
        TVACTS.Attributes.Add("onclick", String.Format("document.getElementById('{0}').click();", buttonCheck.ClientID))
        '      End If

    End Sub
	Protected Sub btnADD_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim btn As Button = CType(sender, Button)
		Dim dv As DetailsView = CType(btn.NamingContainer, DetailsView)
		If CheckValidity(dv) Then
			LSBEMPS.ClearSelection()
			TVACTS.Visible = True
			lblchecklist.Visible = True
			lblshuly.Visible = True
			lblmail.Visible = True
			btn.CommandName = "Insert"
		Else
			btn.CommandName = Nothing
		End If
	End Sub
	Sub SendEmails(ByVal iMode As Integer)
        'Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        'Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        '		If Not mailSettings Is Nothing Then
        Dim password As String = "karlos" ' mailSettings.Smtp.Network.Password
        Dim username As String = "ariel@topyca.com" 'mailSettings.Smtp.Network.UserName
        Dim dd As SmtpClient = New SmtpClient()
        dd.Credentials = New System.Net.NetworkCredential(username, password)
        Dim m As New MailMessage()
        m.IsBodyHtml = True

        Dim xMail As XElement = XElement.Load(MapPath("App_Data/EmpMails.xml"))

        Dim query = From q In xMail.Descendants("Fields").Elements("Field") _
         Select q.Value
        Dim cFields As New Collection
        For Each q In query
            cFields.Add(q)
        Next

        Dim dv As DetailsView = DVEMPS
        Dim sU As String
        If iMode = 2 Then sU = "U" Else sU = vbNullString
        Dim tb As TextBox = CType(dv.FindControl("TBEMPID" & sU), TextBox)
        If tb.Text <> vbNullString And IsNumeric(tb.Text) Then
            Dim lEmpID As Long = tb.Text
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

            Dim conCom As New SqlCommand("Select * From p6v_MailFields Where EmpID=" & lEmpID & " And UserID=" & LoadSession("UserID"), dbConnection)
            dbConnection.Open()
            Dim dR As SqlDataReader = conCom.ExecuteReader
            If dR.Read Then

                Try
                    m.From = New MailAddress(dR("Email"))
                Catch ex As Exception
                    m.From = New MailAddress("unknown@b-e.org.il")
                End Try
                Dim iMailType As Integer = dR("MailType")
                Dim j As Integer
                Dim hdn As HiddenField = CType(dv.FindControl("hdnMail"), HiddenField)
                If hdn IsNot Nothing Then
                    Try
                        If hdn.Value Then j = 1 Else j = 0
                    Catch ex As Exception
                        j = 0
                    End Try
                End If
                hdn = CType(dv.FindControl("hdnCell"), HiddenField)
                If hdn IsNot Nothing Then
                    Try
                        If hdn.Value Then j = j + 1
                    Catch ex As Exception
                    End Try
                End If
                If j <> 0 Or iMailType <> 0 Then iMailType = 1
                Dim qMail = From q In xMail.Descendants("MailGroup").Descendants("Mail") _
                Where ((q.Parent.Attribute("GroupID").Value = iType) And (q.Parent.Attribute("Mode").Value = iMode) And _
                 ((q.Attribute("MailType").Value = 0) Or (q.Attribute("MailType").Value = iMailType)) And _
                 ((q.Attribute("ServiceID").Value = 0) Or (q.Attribute("ServiceID").Value = CInt(LoadSession("ServiceID"))))) _
                Select q
                For Each q In qMail
                    m.To.Clear()
                    Dim sm As String = q.Element("To").Value
                    m.To.Add(New MailAddress(sm))
                    m.Subject = q.Element("Subject").Value
                    Dim s As String = q.Element("Body").Value
                    s = Replace(s, vbLf, "<br/>")

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

            End If
            dR.Close()
            dbConnection.Close()
        End If
        '	End If

	End Sub

	Protected Sub TVACTS_TreeNodeCheckChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs) Handles TVACTS.TreeNodeCheckChanged
		Dim tv As TreeView = CType(sender, TreeView)
		Dim n As TreeNode = e.Node
		Dim iActID As Integer = n.Value
		Dim dv As DetailsView = DVEMPS
		Dim lbl As Label = CType(dv.FindControl("lblempid"), Label)
		If lbl IsNot Nothing Then
			If lbl.Text <> vbNullString And IsNumeric(lbl.Text) Then
				Dim lEmpID As Long = lbl.Text
				Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
				Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
				Dim conCom As New SqlCommand("Delete From p6t_ActStatus Where EmpID=" & lEmpID & " And ActID=" & iActID, dbConnection)
				dbConnection.Open()
				conCom.ExecuteNonQuery()
				If n.Checked Then
					Try
						conCom.CommandText = "Insert Into p6t_ActStatus(EmpID,ActID) Values(" & lEmpID & "," & iActID & ")"
						conCom.ExecuteNonQuery()
					Catch ex As Exception
					End Try
				End If
				dbConnection.Close()
			End If
		End If
	End Sub

	Protected Sub TVACTS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVACTS.PreRender

		Dim tv As TreeView = CType(sender, TreeView)
		Dim dv As DetailsView = DVEMPS
		If dv.DefaultMode <> DetailsViewMode.ReadOnly Then
			'tv.Visible = False
		Else
			'tv.Visible = True
			Dim lbl As Label = CType(dv.FindControl("lblempid"), Label)
			Dim db As New BES2DataContext
			Dim n As TreeNode
			If lbl IsNot Nothing Then
				If lbl.Text <> vbNullString And IsNumeric(lbl.Text) Then
					Dim lEmpID As Long = lbl.Text
					Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
					Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
					Dim conCom As New SqlCommand("select ActID From p6t_ActStatus Where EmpID=" & lEmpID, dbConnection)
					dbConnection.Open()
					Dim dr As SqlDataReader = conCom.ExecuteReader

					' Clear all (when klita action ids are from 1 to 50)

					For i = 1 To 50
						n = tv.FindNode("EmpActs/Title/" & i)
						If n IsNot Nothing Then n.Checked = False
					Next

					' Clear all (when aziva action ids are from 100 to 150)

					For i = 100 To 150
						n = tv.FindNode("EmpActs/Title/" & i)
						If n IsNot Nothing Then n.Checked = False
					Next
					While dr.Read
						n = tv.FindNode("EmpActs/Title/" & dr("ActID"))
						If n IsNot Nothing Then n.Checked = True
					End While
					dr.Close()
					dbConnection.Close()
				End If

			Else

				' Clear all (when klita action ids are from 1 to 50)

				For i = 1 To 50
					n = tv.FindNode("EmpActs/Title/" & i)
					If n IsNot Nothing Then n.Checked = False
				Next

				' Clear all (when aziva action ids are from 100 to 150)

				For i = 100 To 150
					n = tv.FindNode("EmpActs/Title/" & i)
					If n IsNot Nothing Then n.Checked = False
				Next

			End If
		End If
	End Sub

	Protected Sub RBLTYPE_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLTYPE.SelectedIndexChanged
		Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
		Dim sT As String = rbl.SelectedValue
		Response.Redirect("empform.aspx?T=" & sT)
	End Sub

	Protected Sub RBLTYPE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLTYPE.PreRender
		If Not IsPostBack Then
			If Request.QueryString("T") IsNot Nothing Then
				Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
				Dim li As New ListItem
				li = rbl.Items.FindByValue(Request.QueryString("T"))
				If li IsNot Nothing Then
					li.Selected = True
				End If
			End If
		End If
	End Sub
	Function fDate() As DateTime
		Try
			Return Eval(sDateField)
		Catch ex As Exception
		End Try
	End Function
	Function tDate() As String
		Return sDateText
	End Function
	Sub TBEMPID_validate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
		Dim cv As CustomValidator = CType(sender, CustomValidator)
		Dim l As Long = "0" & LoadSession("EmpID")
		If LCase(Right(cv.ID, 1)) <> "u" Or CLng(args.Value) <> l Then
			Dim s As String = args.Value
			Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
			Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
			Dim conCom As New SqlCommand("select EmpID From p6t_Emps Where EmpID=" & s, dbConnection)
			dbConnection.Open()
			Dim dr As SqlDataReader = conCom.ExecuteReader
			args.IsValid = Not dr.Read
			dr.Close()
			dbConnection.Close()
		End If
	End Sub

	Protected Sub CALDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim cal As Calendar = CType(sender, Calendar)
		Dim d As DateTime
		Try
			d = cal.SelectedDate
		Catch ex As Exception
			cal.SelectedDate = Today
		End Try
		If d = #12:00:00 AM# Then cal.SelectedDate = Today
	End Sub

	Protected Sub DSEMPS_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEMPS.Inserting

		Dim tb As TextBox = CType(DVEMPS.FindControl("TBEMPID"), TextBox)
		Dim cal As Calendar = CType(DVEMPS.FindControl("CALDATE"), Calendar)
		Dim tbbd As TextBox = CType(DVEMPS.FindControl("TBbd"), TextBox)
		For i = 0 To e.Command.Parameters.Count - 1
			Dim s As String = e.Command.Parameters(i).ToString
			If LCase(s) = "@jobid" Then
				Dim tv As TreeView = CType(DVEMPS.FindControl("tvjobs"), TreeView)
				If tv.SelectedNode IsNot Nothing Then
					e.Command.Parameters(i).Value = tv.SelectedNode.Value
				End If
			End If
			If LCase(s) = "@empid" Then
				e.Command.Parameters(i).Value = tb.Text
				Session("NewEmp") = tb.Text
				Session("NewEmpName") = e.Command.Parameters("@LastName").Value & " " & e.Command.Parameters("@FirstName").Value
				LSBEMPS.Enabled = True
			End If
			If LCase(s) = "@firstdate" Then
				If Request.QueryString("T") = 1 Then
					e.Command.Parameters(i).Value = cal.SelectedDate
				Else
					e.Command.Parameters(i).Value = Nothing
				End If
			End If
			If LCase(s) = "@lastdate" Then
				If Request.QueryString("T") = 2 Then
					e.Command.Parameters(i).Value = cal.SelectedDate
				Else
					e.Command.Parameters(i).Value = Nothing
				End If
			End If
			'	If LCase(s) = "@firstdate" Or LCase(s) = "@lastdate" Then e.Command.Parameters(i).Value = cal.SelectedDate
			Dim s1 As String = e.Command.Parameters(i).Value
			If LCase(s) = "@birthdate" Then
				Dim d As DateTime = CDate(tbbd.Text)
				e.Command.Parameters(i).Value = d
			End If

		Next
		'Dim cv As CustomValidator = CType(DVEMPS.FindControl("CVJOBS"), CustomValidator)
		'If cv IsNot Nothing Then
		'	If cv.IsValid Then
		'		Response.Write("<script>alert('תודה.  ההודעה נשלחה למשאבי אנוש ולשכר.  אולם זכור, רק עם קבלת הטפסים בדואר, יקבל העובד שכר');</script>")
		'	End If
		'End If
	End Sub

	Protected Sub btnAddEmp_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		LSBEMPS.Enabled = False
		TVACTS.Visible = False
		lblchecklist.Visible = False
		lblshuly.Visible = False
	End Sub

	Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		LSBEMPS.Enabled = True
		TVACTS.Visible = LSBEMPS.SelectedIndex >= 0
		lblchecklist.Visible = LSBEMPS.SelectedIndex >= 0
		lblshuly.Visible = lblchecklist.Visible
	End Sub
	Protected Sub TBEMPID_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim tb As TextBox = CType(sender, TextBox)
		Session("EmpID") = tb.Text
	End Sub

	Protected Sub DSEMPS_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSEMPS.Selecting
		If LoadSession("newEmp") IsNot Nothing Then
			Try
				Dim l As Long = CLng(Session("NewEmp"))
				e.Command.Parameters("@EmpID").Value = l
				Dim li As ListItem = LSBEMPS.Items.FindByValue(l)
				If li Is Nothing Then
					li = New ListItem(LoadSession("NewEmpName"), l)
					LSBEMPS.Items.Add(li)
				End If
				LSBEMPS.ClearSelection()
				li.Selected = True
			Catch ex As Exception

			End Try
			Session("newEmp") = Nothing
			Session("NewEmpName") = Nothing
		End If
	End Sub

	Protected Sub DVEMPS_ItemDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewDeletedEventArgs) Handles DVEMPS.ItemDeleted
		Dim li As ListItem = LSBEMPS.SelectedItem
		If li IsNot Nothing Then LSBEMPS.Items.Remove(li)
	End Sub

	Protected Sub DSEMPS_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEMPS.Updating
		Dim tb As TextBox = CType(DVEMPS.FindControl("TBEMPIDU"), TextBox)
		Dim cal As Calendar = CType(DVEMPS.FindControl("CALDATE"), Calendar)
		Dim tbbd As TextBox = CType(DVEMPS.FindControl("TBbd"), TextBox)
		Dim l As Long = CLng(LoadSession("EMPID"))
		For i = 0 To e.Command.Parameters.Count - 1
			Dim s As String = e.Command.Parameters(i).ToString
			If LCase(s) = "@jobid" Then
				Dim tv As TreeView = CType(DVEMPS.FindControl("tvjobs"), TreeView)
				If tv IsNot Nothing Then
					If tv.SelectedNode IsNot Nothing Then
						e.Command.Parameters(i).Value = tv.SelectedNode.Value
					End If
				End If
			End If
			If LCase(s) = "@empid" Then
				e.Command.Parameters(i).Value = tb.Text
				Session("NewEmp") = tb.Text
				Session("NewEmpName") = e.Command.Parameters("@LastName").Value & " " & e.Command.Parameters("@FirstName").Value
				LSBEMPS.Enabled = True
			End If
			If LCase(s) = "@firstdate" Then
				If Request.QueryString("T") = 1 Then
					e.Command.Parameters(i).Value = cal.SelectedDate
				Else
					e.Command.Parameters(i).Value = Nothing
				End If
			End If
			If LCase(s) = "@lastdate" Then
				If Request.QueryString("T") = 2 Then
					e.Command.Parameters(i).Value = cal.SelectedDate
				Else
					e.Command.Parameters(i).Value = Nothing
				End If
			End If
			'			If LCase(s) = "@firstdate" Or LCase(s) = "@lastdate" Then e.Command.Parameters(i).Value = cal.SelectedDate
			If LCase(s) = "@birthdate" Then
				Dim d As DateTime = CDate(tbbd.Text)
				e.Command.Parameters(i).Value = d
			End If
		Next
		'Dim cv As CustomValidator = CType(DVEMPS.FindControl("CVJOBS"), CustomValidator)
		'If cv IsNot Nothing Then
		'	If cv.IsValid Then
		'		Response.Write("<script>alert('תודה.  ההודעה נשלחה למשאבי אנוש ולשכר.  אולם זכור, רק עם קבלת הטפסים בדואר, יקבל העובד שכר');</script>")
		'	End If
		'End If
	End Sub

	Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim btn As Button = CType(sender, Button)
		Dim dv As DetailsView = CType(btn.NamingContainer, DetailsView)
		If CheckValidity(dv) Then
			'LSBEMPS.ClearSelection()
			'TVACTS.Visible = True
			'lblchecklist.Visible = True
			'lblshuly.Visible = True
			'lblmail.Visible = True
			btn.CommandName = "Update"
		Else
			btn.CommandName = Nothing
		End If

	End Sub

	Protected Sub DSEMPS_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSEMPS.Inserted
		SendEmails(1)
		Dim i As Integer = e.Command.Parameters("@jobID").Value
		MailMsgBox(i)
		TVACTS.Visible = True
		lblchecklist.Visible = True
		lblshuly.Visible = True
		Response.Write("<script>alert('תודה.  ההודעה נשלחה למשאבי אנוש ולשכר.  אולם זכור, רק עם קבלת הטפסים בדואר, יקבל העובד שכר');</script>")

	End Sub

	Protected Sub DSEMPS_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSEMPS.Updated
		SendEmails(2)
		Dim i As Integer = e.Command.Parameters("@jobID").Value
		MailMsgBox(i)
		TVACTS.Visible = True
		lblchecklist.Visible = True
		lblshuly.Visible = True
		LSBEMPS.DataBind()
		Response.Write("<script>alert('תודה.  ההודעה נשלחה למשאבי אנוש ולשכר.  אולם זכור, רק עם קבלת הטפסים בדואר, יקבל העובד שכר');</script>")

	End Sub

	Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
		divhelp.Visible = Not divhelp.Visible
	End Sub
	Protected Sub BtnNV_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
		TVACTS.Visible = False
		lblchecklist.Visible = False
		lblshuly.Visible = False
	End Sub
	Protected Sub BtnCNCL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
		TVACTS.Visible = LSBEMPS.SelectedIndex >= 0
		lblchecklist.Visible = LSBEMPS.SelectedIndex >= 0
		lblshuly.Visible = lblchecklist.Visible

	End Sub

    Protected Sub LSBEMPS_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles LSBEMPS.SelectedIndexChanged
        cbshowdoc.Visible = False
        TVACTS.Visible = True
        lblchecklist.Visible = True
        lblshuly.Visible = True
        Session("EmpID") = LSBEMPS.SelectedValue
    End Sub
	Protected Sub CALDATE_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim cal As Calendar = CType(sender, Calendar)
		Dim dv As DetailsView = CType(cal.NamingContainer, DetailsView)
		Dim cv As CustomValidator = CType(dv.FindControl("cvcal"), CustomValidator)
		Dim lbl As Label = CType(dv.FindControl("lbldate"), Label)
		lbl.Visible = False
		Dim d As DateTime = cal.SelectedDate
		If d >= DateAdd(DateInterval.Day, BackDays, Today) And d <= DateAdd(DateInterval.Day, ForeDays, Today) Then
			cv.IsValid = True
		Else
			cv.IsValid = False
		End If
	End Sub

	Protected Sub DVEMPS_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVEMPS.Load
	End Sub

	Protected Sub DVEMPS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVEMPS.PreRender
		Dim dv As DetailsView = CType(sender, DetailsView)
		Dim B As Boolean = Request.QueryString("T") = 2
		Dim ddl As DropDownList = CType(dv.FindControl("DDLEME"), DropDownList)
		If ddl IsNot Nothing Then ddl.Visible = B
		Dim lbl As Label = CType(dv.FindControl("lbleme"), Label)
		If lbl IsNot Nothing Then lbl.Visible = B
		lbl = CType(dv.FindControl("LBLEMPEME"), Label)
		If lbl IsNot Nothing Then lbl.Visible = B
		Dim rfv As RequiredFieldValidator = CType(dv.FindControl("RFVEME"), RequiredFieldValidator)
		If rfv IsNot Nothing Then rfv.Visible = B
	End Sub
	Protected Sub TVJOBS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		'Dim tv As TreeView = CType(sender, TreeView)
		'Dim n As TreeNode = tv.Nodes(0)
		'n.Text = "<בחירת תפקיד>"
		'Dim dv As DetailsView = CType(tv.NamingContainer, DetailsView)
		''		If dv.DefaultMode = DetailsViewMode.Edit Then
		'Dim hdn As HiddenField = CType(dv.FindControl("HDNJOB"), HiddenField)

		'If hdn.Value IsNot Nothing Then
		'	'Dim i As Integer = hdn.Value
		'	'For Each n In tv.Nodes
		'	'	Dim s As String = n.ValuePath
		'	'	If n.Value = i Then
		'	'		n.Selected = True
		'	'		Exit For
		'	'	End If
		'	'Next
		'End If
		''		End If

		''For Each n In tv.Nodes
		''	Response.Write(n.ValuePath & "<br/>")

		''Next
	End Sub
	Protected Sub TVJOBS_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim tv As TreeView = CType(sender, TreeView)
		Dim dv As DetailsView = CType(tv.NamingContainer, DetailsView)
		Dim lbl As Label = CType(dv.FindControl("lbljob"), Label)
		If lbl IsNot Nothing Then
			lbl.Text = tv.SelectedNode.Text
		End If
		lbl = CType(dv.FindControl("lbljobs"), Label)
		lbl.Visible = False
	End Sub
	Protected Sub CVJOBS_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
		Dim dv As DetailsView = CType(DVEMPS, DetailsView)
		Dim tv As TreeView = CType(dv.FindControl("tvjobs"), TreeView)
		If tv.SelectedNode IsNot Nothing Then
			Dim n As TreeNode = tv.SelectedNode
			args.IsValid = n.ChildNodes.Count = 0
		Else
			Dim lbl As Label = CType(dv.FindControl("lbljob"), Label)
			args.IsValid = lbl IsNot Nothing
		End If
	End Sub
	Private Sub PopulateRootLevel(ByRef tv As TreeView)

		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim objCommand As New SqlCommand("select id,Name,(select count(*) FROM p6v_Jobs " _
		 & "WHERE parent=sc.id) childnodecount FROM p6v_Jobs sc where parent IS NULL", _
		 dbConnection)
		Dim da As New SqlDataAdapter(objCommand)
		Dim dt As New DataTable()
		da.Fill(dt)

		PopulateNodes(dt, tv.Nodes)

	End Sub
	Private Sub PopulateNodes(ByVal dt As DataTable, ByVal nodes As TreeNodeCollection)
		For Each dr As DataRow In dt.Rows
			Dim tn As New TreeNode()
			tn.Text = dr("name").ToString()
			tn.Value = dr("id").ToString()
			nodes.Add(tn)

			'If node has child nodes, then enable on-demand populating
			tn.PopulateOnDemand = (CInt(dr("childnodecount")) > 0)
		Next
	End Sub
	Private Sub PopulateSubLevel(ByVal parentid As Integer, ByVal parentNode As TreeNode)
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim objCommand As New SqlCommand("select id,Name,(select count(*) FROM p6v_Jobs " _
		  & "WHERE parent=sc.id) childnodecount FROM p6v_Jobs sc where parent=@parent", _
		  dbConnection)
		objCommand.Parameters.Add("@parent", SqlDbType.Int).Value = parentid

		Dim da As New SqlDataAdapter(objCommand)
		Dim dt As New DataTable()
		da.Fill(dt)
		PopulateNodes(dt, parentNode.ChildNodes)
	End Sub
	Protected Sub TVJobs_TreeNodePopulate(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs)
		PopulateSubLevel(CInt(e.Node.Value), e.Node)
	End Sub
	Protected Sub TVJOBS_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim tv As TreeView = CType(sender, TreeView)
		If tv.Nodes.Count = 0 Then
			PopulateRootLevel(tv)
		End If
	End Sub
	Sub MailMsgBox(ByVal i As Integer)
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim sqlC As New SqlCommand("select Mail from p6t_Jobs where JobID=" & i, dbConnection)
		dbConnection.Open()
		Dim dr As SqlDataReader = sqlC.ExecuteReader
		If dr.Read Then
			Dim j As Integer = dr("Mail")
			If j = -1 Then
				Response.Write("<script>alert('לעובד זה ייפתח מייל ארגוני, שם משתמש וסיסמא ישלח אליך תוך שבוע');</script>")
			End If
		End If
		dr.Close()
		dbConnection.Close()
	End Sub
	Function CheckValidity(ByVal dv As DetailsView) As Boolean
		Dim lbl As Label
		Dim b As Boolean = True
		Dim cv As CustomValidator
		lbl = CType(dv.FindControl("lbljobs"), Label)
		Dim tv As TreeView = CType(dv.FindControl("TVJOBS"), TreeView)
		If tv.SelectedNode Is Nothing Then
			cv = CType(dv.FindControl("CVJOBS"), CustomValidator)
			cv.IsValid = False
			cv.Validate()
			b = False
			lbl.Visible = True
		ElseIf tv.SelectedNode.Value > 999 Then
			cv = CType(dv.FindControl("CVJOBS"), CustomValidator)
			cv.IsValid = False
			cv.Validate()
			b = False
			lbl.Visible = True
		Else
			lbl.Visible = False
		End If
		Dim cal As Calendar = CType(dv.FindControl("CALDATE"), Calendar)
		lbl = CType(dv.FindControl("lbldate"), Label)
		Dim d As DateTime = cal.SelectedDate
		Dim d1 As DateTime = Now()
		Dim l As Long = DateDiff(DateInterval.Day, d, Now)
		If ((l < BackDays) Or (l > ForeDays)) Then
			cv = CType(dv.FindControl("CVCAL"), CustomValidator)
			cv.IsValid = False
			lbl.Visible = True
			b = False
		Else
			lbl.Visible = False
		End If

		Return b

	End Function

    Protected Sub DDLSERVICES_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSERVICES.DataBound, DDLFRAMES.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If Left(ddl.Items(0).Text, 1) <> "]" And ddl.Items.Count = 2 Then
            ddl.Items.RemoveAt(0)
            DDLFRAMES.DataBind()
        End If
    End Sub

    Protected Sub cbshowdoc_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles cbshowdoc.CheckedChanged
        If LSBEMPS.SelectedValue = vbNullString Then
            Dim cb As CheckBox = CType(sender, CheckBox)
            TVACTS.Visible = cb.Checked
            TVACTS.DataBind()
        End If
    End Sub
End Class

