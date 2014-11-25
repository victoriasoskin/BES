Imports System.Data.SqlClient
Imports eid
Imports System.Net.Mail
Imports MessageBox

Partial Class NewEMPPROP
    Inherits System.Web.UI.Page
    Protected Sub tbJobtime_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        If Not IsPostBack And tb.Text = vbNullString Then tb.Text = "1.00"
    End Sub
    Protected Sub tbManager_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        If tb.Text = vbNullString Then tb.Text = Session("UserName")
    End Sub
    Protected Sub CBDAY_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
        Dim tb As TextBox = CType(lvi.FindControl("tbSHR"), TextBox)
        If tb IsNot Nothing Then
            If cb.Checked Then
                tb.Enabled = True
                tb.Text = ViewState("sSHR")
            Else
                tb.Enabled = False
                tb.Text = vbNullString
            End If
        End If
        tb = CType(lvi.FindControl("tbSMIN"), TextBox)
        If tb IsNot Nothing Then
            If cb.Checked Then
                tb.Enabled = True
                tb.Text = ViewState("sSMIN")
            Else
                tb.Enabled = False
                tb.Text = vbNullString
            End If
        End If
        tb = CType(lvi.FindControl("tbEHR"), TextBox)
        If tb IsNot Nothing Then
            If cb.Checked Then
                tb.Enabled = True
                tb.Text = ViewState("sEHR")
            Else
                tb.Enabled = False
                tb.Text = vbNullString
            End If
        End If
        tb = CType(lvi.FindControl("tbEMIN"), TextBox)
        If tb IsNot Nothing Then
            If cb.Checked Then
                tb.Enabled = True
                tb.Text = ViewState("sEMIN")
            Else
                tb.Enabled = False
                tb.Text = vbNullString
            End If
        End If
    End Sub
    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lvi As ListViewItem = CType(btn.NamingContainer, ListViewItem)

        AddEmp(lvi)
    End Sub
    Sub AddEmp(ByVal lvi As ListViewItem)

        ' Check if EmpID was supplied

        Page.Validate()
        If Page.IsValid = False Then Exit Sub

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlCom As New SqlCommand("", dbConnection)
        Dim sF As String = "Begin Transaction Delete From p6t_Emps Where EmpID="
        Dim sV As String = "("

        ' EmpID

        Dim cid As Controls_CheckID = CType(lvi.FindControl("tbcheckid"), Controls_CheckID)
        Dim lbl As Label = CType(lvi.FindControl("lblerrempid"), Label)
        If cid.Text = vbNullString Then
            lbl.Visible = True
            Exit Sub
        Else
            lbl.Visible = False
        End If

        sF &= cid.Text
        sF &= " Delete From p6t_WorkDays Where EmpID=" & cid.Text
        sF &= " Insert Into p6t_Emps(EmpID,FirstName,LastName,BirthDate,Address,FrameID,FirstDate,JobID,JobTime,Tarif,Salary,TravelCode,Travel,SalaryAdd,CellPhone,StudyFundID,CompanyCar,SMngrAppr,Manager,Loadtime,Status) Values"

        sV &= cid.Text & ","

        'First name

        Dim tb As TextBox = CType(lvi.FindControl("tbfirstname"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'Last name

        tb = CType(lvi.FindControl("tblastname"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'Birth Date

        Dim tbx As Controls_EnterDate = CType(lvi.FindControl("tbxbirthDate"), Controls_EnterDate)
        sV &= "'" & tbx.SelectedDate & "',"

        'Address

        tb = CType(lvi.FindControl("tbAddress"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'FrameID

        If Sfrm.SelectedFrame = vbNullString Then
            lblerrframe.Visible = True
            Exit Sub
        Else
            lblerrframe.Visible = False
        End If
        sV &= Sfrm.SelectedFrame & ","

        'First Date

        tbx = CType(lvi.FindControl("tbxFirstDate"), Controls_EnterDate)
        sV &= "'" & tbx.SelectedDate & "',"

        'JobID

        Dim tdd As TreeDropDown = CType(lvi.FindControl("tddJob"), TreeDropDown)
        lbl = CType(lvi.FindControl("lblerrjob"), Label)
        If tdd.SelectedValue = vbNullString Then
            lbl.Visible = True
            Exit Sub
        Else
            lbl.Visible = False
        End If
        MailMsgBox(tdd.SelectedValue)
        sV &= tdd.SelectedValue & ","

        'Jobtime

        tb = CType(lvi.FindControl("tbJobTime"), TextBox)
        sV &= tb.Text & ","

        'tarif

        tb = CType(lvi.FindControl("tbtarif"), TextBox)
        Dim b As Boolean = tb.Text = vbNullString
        sV &= If(tb.Text = vbNullString, "NULL", Replace(tb.Text, ",", "")) & ","

        'Salary

        tb = CType(lvi.FindControl("tbSalary"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", Replace(tb.Text, ",", "")) & ","
        lbl = CType(lvi.FindControl("lblerrsalary"), Label)
        If b And tb.Text = vbNullString Then
            lbl.Visible = True
            Exit Sub
        Else
            lbl.Visible = False
        End If

        'Travel

        Dim rbl As RadioButtonList = CType(lvi.FindControl("rblTravelCode"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'Travel

        tb = CType(lvi.FindControl("tbTravel"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", tb.Text) & ","

        'SalaryAdd

        tb = CType(lvi.FindControl("tbSalaryAdd"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", tb.Text) & ","

        'CellPhone

        rbl = CType(lvi.FindControl("rblCellPhone"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'StudyFund

        rbl = CType(lvi.FindControl("rblStudyFundID"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'CompanyCar

        rbl = CType(lvi.FindControl("rblCompanyCar"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'SMngrAppr

        rbl = CType(lvi.FindControl("rblSMngrAppr"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'Manager

        tb = CType(lvi.FindControl("tbManager"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'Loadtime

        tbx = CType(lvi.FindControl("TBDate1"), Controls_EnterDate)
        sV &= "'" & tbx.SelectedDate & "',"

        'Status

        sV &= "1)"

        sF &= sV

        ' Add WorkDays to table

        Dim lv As ListView = CType(lvi.FindControl("lvwd"), ListView)

        For Each lvi In lv.Items
            tb = CType(lvi.FindControl("TBEMIN"), TextBox)
            Dim s As String = tb.Text
            tb = CType(lvi.FindControl("TBEHR"), TextBox)
            s &= tb.Text
            tb = CType(lvi.FindControl("TBSMIN"), TextBox)
            s &= tb.Text
            tb = CType(lvi.FindControl("TBSHR"), TextBox)
            s &= tb.Text

            If s <> vbNullString Then
                If tb.Text <> vbNullString Then
                    s = tb.Text
                    sF &= " Insert into p6t_WorkDays(EmpID,Weekday,Starthour,Endhour) Values("
                    sF &= cid.Text & ","
                    Dim hdn As HiddenField = CType(lvi.FindControl("hdnWeekDay"), HiddenField)
                    sF &= hdn.Value & ","
                    tb = CType(lvi.FindControl("TBSMIN"), TextBox)
                    sF &= "'" & Right("00" & s, 2) & ":" & Right("00" & tb.Text, 2) & "',"
                    tb = CType(lvi.FindControl("TBEHR"), TextBox)
                    sF &= "'" & Right("00" & tb.Text, 2) & ":"
                    tb = CType(lvi.FindControl("TBEMIN"), TextBox)
                    sF &= Right("00" & tb.Text, 2) & "')"
                End If
            End If
        Next

        sF &= " if @@ERROR<>0 ROLLBACK TRANSACTION ELSE COMMIT TRANSACTION Checkpoint"

        sqlCom.CommandText = sF
        sqlCom.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Try
            sqlCom.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
        End Try
        dbConnection.Close()
        SendEmails(1)
        MessageBox.Show("נתוני הההצעה נשלחו לתפוצה המתאימה")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If Not IsPostBack Then
            If Request.QueryString("E") IsNot Nothing And Request.QueryString("E") <> vbNullString Then
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim sqlCom As New SqlCommand("Select FrameName,e.FrameID From p6t_Emps e Left outer join FrameList f on f.frameID=e.FrameID Where EmpId=" & Request.QueryString("E"), dbConnection)
                dbConnection.Open()

                Dim dr As SqlDataReader = sqlCom.ExecuteReader
                If dr.Read Then
                    Sfrm.SelectedFrame = dr("FrameID")
                    LVEMPS.EditIndex = 0
                    'LVEMPS.DataBind()
                    'Dim cid As Controls_CheckID = CType(LVEMPS.EditItem.FindControl("tbcheckid"), Controls_CheckID)
                    'Dim lv As ListView = CType(LVEMPS.EditItem.FindControl("lvwd"), ListView)
                    'DSWD.SelectParameters("EmpID").DefaultValue = cid.Text
                    'lv.DataBind()
                    LVEMPS.InsertItemPosition = InsertItemPosition.None

                End If

            End If
            ViewState("sSHR") = "08"
            ViewState("sSMIN") = "00"
            ViewState("sEHR") = "17"
            ViewState("sEMIN") = "00"
        End If
    End Sub
    Protected Sub tbHM_TextChenged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        ViewState("s" & Mid(tb.ID, 3, 9).ToUpper) = Right("00" & tb.Text, 2)
    End Sub
    Protected Sub tbcheckid_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DDLEMPS_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLEMPS.SelectedIndexChanged
        Dim s As String
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedValue = vbNullString Then
            s = "Newempprop.ASPX"
        Else
            s = "Newempprop.ASPX?E=" & ddl.SelectedValue
        End If
        Response.Redirect(s)
    End Sub

    Protected Sub DDLEMPS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLEMPS.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = ddl.SelectedValue
        If Not IsPostBack Then
            ddl.ClearSelection()
            Dim li As ListItem = ddl.Items.FindByValue(Request.QueryString("E"))
            If li IsNot Nothing Then li.Selected = True
        End If
    End Sub

    Protected Sub DDLEMPS_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLEMPS.Load
    End Sub
    Function ShowT(ByVal sF As String) As String
        Return If(IsNumeric(Eval(sF)), Format(Eval(sF), "00"), vbNullString)
    End Function
    Sub MailMsgBox(ByVal i As Integer)
    End Sub
    Protected Sub tdd_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tdd As TreeView = CType(sender, TreeView)
        Dim t As TreeDropDown = CType(tdd.NamingContainer, TreeDropDown)
        Dim lvi As ListViewItem = CType(t.NamingContainer, ListViewItem)
        Dim lbl As Label = CType(lvi.FindControl("lblNewmail"), Label)
        Dim i As Integer = tdd.SelectedValue
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlC As New SqlCommand("select Mail from p6t_Jobs where JobID=" & i, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = sqlC.ExecuteReader
        If dr.Read Then
            Dim j As Integer = dr("Mail")
            lbl.Visible = j <> 0
        End If
        dr.Close()
        dbConnection.Close()

    End Sub
    Sub SendEmails(ByVal iMode As Integer)
        Dim iType As Integer = 1
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

        Dim lv As ListView = LVEMPS
        Dim lvi As ListViewItem = If(lv.InsertItem Is Nothing, lv.EditItem, lv.InsertItem)
        Dim sU As String
        If iMode = 2 Then sU = "U" Else sU = vbNullString
        Dim tb As Controls_CheckID = CType(lvi.FindControl("TBCHECKID"), Controls_CheckID)
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
                Dim hdn As HiddenField = CType(lvi.FindControl("hdnMail"), HiddenField)
                If hdn IsNot Nothing Then
                    Try
                        If hdn.Value Then j = 1 Else j = 0
                    Catch ex As Exception
                        j = 0
                    End Try
                End If
                hdn = CType(lvi.FindControl("hdnCell"), HiddenField)
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
End Class

