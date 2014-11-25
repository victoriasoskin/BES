Imports System.Data.SqlClient
Imports eid
Imports System.Net.Mail
Imports MessageBox
Imports System.Web.Configuration
Imports System.Net.Configuration

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
        'Dim cv As CompareValidator = CType(lvi.FindControl("cov1"), CompareValidator)
        'cv.Validate()

        AddEmp(lvi)
    End Sub
    Sub Errmsg(s As String)
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", "<script langualge=&quot;javascript&quot;>alert('" & s & "');</script>")
    End Sub
    Sub AddEmp(ByVal lvi As ListViewItem)
        Dim sErr As String = vbNullString
        ' Check if EmpID was supplied

        Page.Validate()
        Dim cid As Controls_CheckID = CType(lvi.FindControl("tbcheckid"), Controls_CheckID)
        Dim lbl As Label = CType(lvi.FindControl("lblDupID"), Label)
        Dim tdd As TreeDropDown = CType(lvi.FindControl("tddJob"), TreeDropDown)
        If cid.IDValid = False Then
            sErr = "תעודת הזהות כבר קיימת ברשימה\n"
        End If
        If Not IsPostBack Then lbl.Text = vbNullString
        If Page.IsValid = False Then
            sErr &= "חסרים נתונים בדף (הערות באדום)\n"
        End If

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlCom As New SqlCommand("", dbConnection)
        Dim sF As String = "Begin Transaction Delete From p6t_Emps Where EmpID="
        Dim sV As String = "("

        ' EmpID

        '   Dim cid As Controls_CheckID = CType(lvi.FindControl("tbcheckid"), Controls_CheckID)
        If cid.Text = vbNullString Then
            Exit Sub
        Else
        End If

        sF &= cid.Text
        sF &= " Delete From p6t_WorkDays Where EmpID=" & cid.Text
        sF &= " Insert Into p6t_Emps(EmpID,FirstName,LastName,BirthDate,Address,FrameID,FirstDate,JobID,JobTime,Tarif,Salary,TravelCode,Travel,SalaryAdd,AcademicDegree,YearsCertified,Rewards,School,Matriculation,CellPhone,Mail,StudyFundID,CompanyCar,SMngrAppr,Manager,Loadtime,Status) Values"

        sV &= cid.Text & ","

        'First name

        Dim tb As TextBox = CType(lvi.FindControl("tbfirstname"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'Last name

        tb = CType(lvi.FindControl("tblastname"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'Birth Date

        Dim tbx As TextBox = CType(lvi.FindControl("tbbirthDate"), TextBox)
        If IsDate(tbx.Text) Then sV &= "'" & Format(CDate(tbx.Text), "yyyy-MM-dd") & "',"

        'Address

        tb = CType(lvi.FindControl("tbAddress"), TextBox)
        sV &= "'" & Replace(tb.Text, "'", "''") & "',"

        'FrameID

        If Sfrm.SelectedFrame = vbNullString Then
            lblerrframe.Visible = True
            sErr &= "לא נבחרה מסגרת\n"
        Else
            lblerrframe.Visible = False
        End If
        sV &= Sfrm.SelectedFrame & ","

        'First Date

        Dim tbrx As Controls_EnterDate = CType(lvi.FindControl("tbxFirstDate"), Controls_EnterDate)
        sV &= "'" & tbrx.SelectedDate & "',"

        'JobID

        lbl = CType(lvi.FindControl("lblerrjob"), Label)
        If tdd.SelectedValue = vbNullString Then
            lbl.Visible = True
            sErr &= "לא נבחר תפקיד\n"
        Else
            lbl.Visible = False
        End If
        MailMsgBox(tdd.SelectedValue)
        sV &= tdd.SelectedValue & ","

        'Jobtime

        tb = CType(lvi.FindControl("tbJobTime"), TextBox)
        sV &= "'" & tb.Text & "',"

        'tarif

        tb = CType(lvi.FindControl("tbtarif"), TextBox)
        Dim b As Boolean = tb.Text = vbNullString
        sV &= If(tb.Text = vbNullString, "NULL", Replace(tb.Text, ",", "")) & ","

        'Salary

        tb = CType(lvi.FindControl("tbSalary"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", Replace(tb.Text, ",", "")) & ","

        If b And tb.Text = vbNullString Then
            '            cv.IsValid = False 
            sErr &= "לא הוזן או שכר או תעריף\n"
            Exit Sub
        Else
            '           cv.IsValid = True
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

        'AcademicDegree

        Dim ddl As DropDownList = CType(lvi.FindControl("ddlAcademicDegree"), DropDownList)
        sV &= If(ddl.SelectedValue = vbNullString, "NULL", ddl.SelectedValue) & ","

        'YeadsCertified

        tb = CType(lvi.FindControl("tbYearsCertified"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", tb.Text) & ","

        'Rewards

        tb = CType(lvi.FindControl("tbRewards"), TextBox)
        sV &= If(tb.Text = vbNullString, "NULL", tb.Text) & ","

        'School

        rbl = CType(lvi.FindControl("rblSchool"), RadioButtonList)
        sV &= If(rbl.SelectedValue = vbNullString, "NULL", rbl.SelectedValue) & ","

        'Matriculation

        rbl = CType(lvi.FindControl("rblMatriculation"), RadioButtonList)
        sV &= rbl.SelectedValue & ","


        'CellPhone

        rbl = CType(lvi.FindControl("rblCellPhone"), RadioButtonList)
        sV &= rbl.SelectedValue & ","

        'Email

        rbl = CType(lvi.FindControl("rblMail"), RadioButtonList)
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

        tbrx = CType(lvi.FindControl("TBDate1"), Controls_EnterDate)
        sV &= "'" & tbrx.SelectedDate & "',"

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
        If sErr = vbNullString Then
            dbConnection.Open()
            Try
                sqlCom.ExecuteNonQuery()
            Catch ex As Exception
                Throw ex
            End Try
            dbConnection.Close()
            SendEmails(1)
            MessageBox.Show("נתוני הההצעה נשלחו לתפוצה המתאימה")
        Else
            'SendEmails(1)
            MessageBox.Show(sErr)
            '   Errmsg(sErr)

        End If
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
        Dim tb As TextBox = CType(sender, TextBox)
        Dim tbx As Controls_CheckID = CType(tb.NamingContainer, Controls_CheckID)
        Dim lvi As ListViewItem = CType(tbx.NamingContainer, ListViewItem)
        Dim lbl As Label = CType(lvi.FindControl("lblerrempid"), Label)
        If IsPostBack And tb.Text = vbNullString Then
            lbl.Visible = True
        Else
            lbl.Visible = False
        End If
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
        '        Dim lbl As Label = CType(lvi.FindControl("lblNewmail"), Label)
        Dim rbl As RadioButtonList = CType(lvi.FindControl("rblMail"), RadioButtonList)
        Dim i As Integer = tdd.SelectedValue
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlC As New SqlCommand("select Mail from p6t_Jobs where JobID=" & i, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = sqlC.ExecuteReader
        If dr.Read Then
            Dim j As Integer = dr("Mail")
            If j <> 0 Then
                '               lbl.Visible = True
                rbl.SelectedValue = 1
            Else
                rbl.SelectedValue = 0
            End If
        End If
        dr.Close()
        dbConnection.Close()

    End Sub
    Sub SendEmails(ByVal iMode As Integer)
        Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        If iMode = 3 Then
            Dim password As String = mailSettings.Smtp.Network.Password
            Dim username As String = mailSettings.Smtp.Network.UserName
            Dim dd As SmtpClient = New SmtpClient()
            dd.Credentials = New System.Net.NetworkCredential(username, password)
            Dim m As New MailMessage()
            m.IsBodyHtml = True
            m.To.Add(New MailAddress(TextBox1.Text))
            m.From = New MailAddress("sigal@be-online.org")
            m.Subject = "בדיקה"
            Dim sx As String = Request.UserHostName()
            m.Body = "<html dir=""rtl""><body>" & sx & "</body></html>"
            dd.Send(m)
            Exit Sub
        End If
        Dim iType As Integer = 1
        If Not mailSettings Is Nothing Then
            Dim password As String = mailSettings.Smtp.Network.Password
            Dim username As String = mailSettings.Smtp.Network.UserName
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
                    m.From = New MailAddress("noreply@be-online.org")
                    'Try
                    '    m.From = New MailAddress(dR("Email"))
                    'Catch ex As Exception
                    '    m.From = New MailAddress("unknown@b-e.org.il")
                    'End Try
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
                     ((If(q.Attribute("ServiceID") Is Nothing, "0", q.Attribute("ServiceID").Value) = 0) Or (If(q.Attribute("ServiceID") Is Nothing, "0", q.Attribute("ServiceID").Value) = CInt(LoadSession("ServiceID"))))) _
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
        End If

    End Sub
    Sub cverrsalary_ServerValidate(source As Object, args As System.Web.UI.WebControls.ServerValidateEventArgs)
        Dim cv As CustomValidator = CType(source, CustomValidator)
        Dim lvi As ListViewItem = CType(cv.NamingContainer, ListViewItem)
        Dim tb As TextBox = CType(lvi.FindControl("tbtarif"), TextBox)
        If tb.Text <> vbNullString Xor args.Value <> vbNullString Then
            args.IsValid = True
        Else
            args.IsValid = False
        End If
    End Sub

    Protected Sub tbtarif_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim lvi As ListViewItem = CType(tb.NamingContainer, ListViewItem)
        Dim rfv As RequiredFieldValidator = CType(lvi.FindControl("rflsalary"), RequiredFieldValidator)
        If tb.Text <> vbNullString Then
            rfv.Enabled = False
        Else
            rfv.Enabled = False
        End If
    End Sub
    Protected Sub lblDupID_PerRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim lvi As ListViewItem = CType(lbl.NamingContainer, ListViewItem)
        Dim cid As Controls_CheckID = CType(lvi.FindControl("tbCheckID"), Controls_CheckID)
        If cid.IDValid = False Then
            lbl.Text = "תעודת הזהות כבר קיימת ברשימה"
        Else
            lbl.Text = vbNullString
        End If
        If Not IsPostBack Then lbl.Text = vbNullString
    End Sub

    Protected Sub LVEMPS_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles LVEMPS.ItemDataBound
        Dim lvi As ListViewItem = e.Item

    End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        SendEmails(3)
    End Sub
    Protected Sub rbl_PreRender(sender As Object, e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim s As String = rbl.ID
        s = Mid(s, 4)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("HDN" & s), HiddenField)
        If hdn.Value <> vbNullString Then
            Dim li As ListItem = rbl.Items.FindByValue(hdn.Value)
            If li IsNot Nothing Then li.Selected = True
        End If
    End Sub
End Class

