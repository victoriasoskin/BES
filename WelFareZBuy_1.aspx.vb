﻿Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Web.Configuration
Imports System.Net.Configuration

Partial Class WelFareZBuy_1
    Inherits System.Web.UI.Page
    Const sWelfareEmail As String = "klila.s@b-e.org.il"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("op") <> vbNullString Then
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim cD As New SqlCommand("SELECT OP_Header_1,OP_Footer_1,btnORDtext,OPName FROM WelFareOps Where OpID = " & Request.QueryString("OP"), dbConnection)
                cD.CommandType = Data.CommandType.Text
                dbConnection.Open()
                Dim dr As SqlDataReader = cD.ExecuteReader
                If dr.Read Then
                    'If Not IsDBNull(dr("OP_Header_1")) Then lblText_HEADER.Text = dr("OP_Header_1")
                    'If Not IsDBNull(dr("OP_Footer_1")) Then lblText_FOOTER.Text = dr("Oariel   karlosP_Footer_")
                    '    If Not IsDBNull(dr("btnOrdText")) Then btnord.Text = dr("btnOrdText")
                End If
                dr.Close()
                dbConnection.Close()
            End If
        End If
    End Sub
    Protected Sub cbAgreerequired_Prerender(sender As Object, e As System.EventArgs)
        If Not IsPostBack Then
            Dim cb As CheckBox = CType(sender, CheckBox)
            cb.Visible = Request.QueryString("AG") = "True"
        End If
    End Sub
    Protected Sub btnord_Click(sender As Object, e As System.EventArgs) Handles btnord.Click
        Dim iMatchLevel As Integer = 0
        If Request.QueryString("AG") <> "True" Or cbAgree.Checked Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT EmployeeName,fr.FrameName HFrame FROM [Book10].[dbo].[HR_SL_EmpList] e left outer join [Book10].[dbo].[SL_CFY_1_HFrameID] f on f.frm_catid= e.frm_catid left outer join Book10_21.dbo.p0t_coordframeid c on c.financeframeid=f.frm_catid  left outer join Book10_21.dbo.FrameList fr on fr.FrameID=c.SherutFrameID Where EmployeeID=" & tbid.Text, dbConnection)
            cD.CommandType = Data.CommandType.Text
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                Dim sD As String = dr("EmployeeName")
                sD = sD.Replace(" ", vbNullString)
                Dim sE As String = tblname.Text & tbfname.Text
                sE = sE.Replace(" ", vbNullString)
                If sE = sD Then iMatchLevel = 2
                'sD = dr("HFrame")
                'sD = sD.Replace(" ", vbNullString)
                'sE = tblname.Text & tbfname.Text
                'sE = sE.Replace(" ", vbNullString)
                'If sD = sE Then iMatchLevel = iMatchLevel + 1
                Session("MatchLevel") = iMatchLevel
                GetOPsParams(Request.QueryString("OP"))
                If ViewState("minS") = ViewState("maxS") Then
                    If CheckmaxOrdersOK(tbid.Text, ViewState("maxOrders")) Then
                        PlaceOrder(iMatchLevel)

                        ' MessageBox.Show(ViewState("OKmsg"))
                        Response.Redirect("WelfareThanks.aspx")
                        Exit Sub
                    Else
                        MessageBox.Show("לא ניתן להזמין יותר מ" & If(ViewState("maxOrders") = 1, "הזמנה אחת", " " & ViewState("maxOrders") & " הזמנות"))
                        Exit Sub
                    End If
                Else
                    divOrders.Visible = True
                    If CheckmaxOrdersOK(tbid.Text, ViewState("maxOrders")) Then
                    Else
                        MessageBox.Show("לא ניתן להזמין יותר מ " & If(ViewState("maxOrders") = 1, "הזמנה אחת", " " & ViewState("maxOrders") & " הזמנות"))
                        Exit Sub
                    End If
                    divOrders.Visible = True
                    divOrders.DataBind()
                    If rblOps.SelectedIndex <= 0 Then
                        Dim li As ListItem = rblOps.Items(0)
                        If li IsNot Nothing Then
                            li.Selected = True
                            GetOPsParams(rblOps.SelectedValue)
                        End If
                    End If
                End If
            Else
                MessageBox.Show("ישנה טעות בהקלדת הפרטים האישיים. הפרטים צריכים להיות מוקלדים כפי שקיימים במערכת החילן - נט - מערכת השכר")
            End If
            dr.Close()
            dbConnection.Close()
        Else
            MessageBox.Show("נא לאשר תנאי מבצע לפני ביצוע הזמנה")
        End If

    End Sub
    Sub GetOPsParams(OpID As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select discount,minS,maxS,MaxOrders,OKmsg,OPName From WelFareOps Where OpID=" & OpID, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            Session("Wel_DisCount") = dr("discount")
            ViewState("minS") = dr("minS")
            ViewState("maxS") = dr("maxS")
            ViewState("maxOrders") = dr("MaxOrders")
            ViewState("OKmsg") = dr("OKmsg")
            ViewState("OPName") = dr("OPName")
        End If
        dr.Close()
        dbConnection.Close()

    End Sub

    Protected Sub OrderDateTextBox_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(Today, "dd/MM/yyyy")
    End Sub
    Protected Sub STextBox_TextChanged(sender As Object, e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim lvi As ListViewItem = CType(tb.NamingContainer, ListViewItem)
        Dim lbl As Label = CType(lvi.FindControl("sDLabel"), Label)
        Dim btn As Button = CType(lvi.FindControl("InsertButton"), Button)
        Dim rv = CType(lvi.FindControl("rvs"), RangeValidator)
        Dim dd As Decimal
        If IsNumeric(tb.Text.Replace(",", vbNullString)) Then
            dd = CDec(tb.Text.Replace(",", vbNullString))
            If dd >= ViewState("minS") And dd <= ViewState("maxS") Then
                lbl.Text = Format(dd * (1 - Session("Wel_Discount")), "#,###.00")
                If btn.Text = "חישוב הסכום לתשלום" Then btn.Text = "הזמנה"
            Else
                rv.IsValid = False
            End If
        Else
            rv.IsValid = False
        End If
    End Sub
    Protected Sub STextBox_PreRender(sender As Object, e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim lvi As ListViewItem = CType(tb.NamingContainer, ListViewItem)
        Dim btn As Button = CType(lvi.FindControl("InsertButton"), Button)
        tb.Attributes.Add("onkeyup", _
        btn.ClientID & ".value='חישוב הסכום לתשלום';")
    End Sub

    Protected Sub lvorders_PreRender(sender As Object, e As System.EventArgs) Handles lvorders.PreRender
        Dim lv As ListView = CType(sender, ListView)
        If lv.Items.Count >= ViewState("maxOrders") Then lv.InsertItemPosition = InsertItemPosition.None Else lv.InsertItemPosition = InsertItemPosition.LastItem
    End Sub
    Protected Sub InsertButton_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lv As ListView = CType(btn.NamingContainer.NamingContainer, ListView)
        Dim i As Integer = lv.Items.Count
        Dim s As String = vbNullString
        If i >= ViewState("maxOrders") - 1 Then s = "\n לא ניתן להוסיף עוד הזמנות"
        If btn.Text = "הזמנה" Then MessageBox.Show("ההזמנה נקלטה. תודה" & s)
    End Sub
    Function CheckmaxOrdersOK(EmpID As String, maxAllowd As Integer) As Boolean
        Dim bOrds As Boolean = True
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select count(*) As Cnt From WelFareTrans Where OpID=" & Request.QueryString("OP") & " AND EmployeeID=" & EmpID, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            If dr("Cnt") >= maxAllowd Then
                bOrds = False
            End If
        End If
        dr.Close()
        dbConnection.Close()
        Return bOrds
    End Function
    Sub PlaceOrder(iMatchLevel As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("insertWelf", dbConnection)
        cD.CommandType = Data.CommandType.StoredProcedure
        cD.Parameters.AddWithValue("@EmployeeID", tbid.Text)
        cD.Parameters.AddWithValue("@FirstName", tbfname.Text)
        cD.Parameters.AddWithValue("@LastName", tblname.Text)
        If tbfname.Text <> vbNullString Then cD.Parameters.AddWithValue("@FrameName", tbfrm.Text)
        If tbphone.Text <> vbNullString Then cD.Parameters.AddWithValue("@Phone", tbphone.Text)
        If tbemail2.Text <> vbNullString And tbemail1.Text <> vbNullString Then cD.Parameters.AddWithValue("@Email", tbemail2.Text & "@" & tbemail1.Text)
        cD.Parameters.AddWithValue("@OpID", Request.QueryString("OP"))
        cD.Parameters.AddWithValue("@S", ViewState("maxS"))
        If Not IsDBNull(Session("Wel_DisCount")) Then cD.Parameters.AddWithValue("@discount", Session("Wel_DisCount"))
        cD.Parameters.AddWithValue("@MatchLevel", iMatchLevel)
        dbConnection.Open()
        cD.ExecuteNonQuery()
        dbConnection.Close()
        SendEmails(sWelfareEmail, "מבצע רווחה: " & ViewState("OPName"), "שלום,<br /><br />" & _
                   tbfname.Text & " " & tblname.Text & " (ת.ז. " & tbid.Text & ") ממסגרת " & tbfrm.Text & ", הכניס הזמנה עבור " & ViewState("OPName") & ".<br /><br />" & _
                   If(tbphone.Text <> vbNullString, "טלפון: " & tbphone.Text & "<br />", vbNullString) & _
                   If(tbemail1.Text <> vbNullString, "דואר אלקטרוני: " & tbemail2.Text & "@" & tbemail1.Text & "<br />", vbNullString) & _
                   "<br />בברכה,<br />מערכת הניהול")

    End Sub
    Const BccEmail As String = "arielpelli1@gmail.com"
    Const ErrEmailAddress As String = "ariel@topyca.com"
    Sub SendEmails(sMail As String, Subject As String, body As String)
        'Dim password As String = "karlos"
        'Dim username As String = "sigal@be-online.org"
        'Dim dd As SmtpClient = New SmtpClient()
        'dd.Host = "mail.be-online.org"
        'dd.Credentials = New System.Net.NetworkCredential(username, password)
        'Dim m As New System.Net.Mail.MailMessage
        'm.IsBodyHtml = True
        'm.Subject = Subject
        'm.Body = body
        'm.From = New MailAddress("noreply@be-online.org")
        'm.To.Clear()
        'If sMail = vbNullString Then
        '    sMail = ErrEmailAddress
        'End If
        'm.To.Add(New MailAddress(sMail))
        'm.Bcc.Add(New MailAddress(BccEmail))
        'Try
        '    dd.Send(m)
        'Catch ex As Exception
        '    Throw ex
        'End Try

        Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        Dim password As String = mailSettings.Smtp.Network.Password
        Dim username As String = mailSettings.Smtp.Network.UserName
        Dim dd As SmtpClient = New SmtpClient()
        dd.Credentials = New System.Net.NetworkCredential(username, password)
        Dim m As New MailMessage()
        m.IsBodyHtml = True
        m.To.Add(New MailAddress(sMail))
        m.From = New MailAddress("noreply@be-online.org")
        m.Subject = Subject
        m.Body = "<html dir=""rtl""><body>" & body & "</body></html>"
        dd.Send(m)
    End Sub

End Class