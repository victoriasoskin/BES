Imports System.Data.SqlClient
Imports System.IO
Imports System.Data
Imports BesConst
Imports WRCookies
Imports eid
Imports PageErrors
Imports UtilVB

Partial Class FormEditor
    Inherits System.Web.UI.Page
#Region "Load"
    Dim iRet As Integer
    Const CustEventTypeID As Integer = 128

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim iEventID As Integer = 0
        Dim u As New UtilVB()
        Dim Period As Integer
        Period = getPeriod()
        'Dim iCustRelateID As Integer = 0
        'Dim iCanUpdate As Integer = 0

        ' First Entry

        If Not IsPostBack Then


            If Request.QueryString("ID") Is Nothing Then Session("URLRefferer") = Request.QueryString("B")

            ' Save UserID

            If Session("UserID") Is Nothing Then UserLogin(Request.QueryString("U"), "Book10VPSC")
            WriteCookie_S("HRForm_UserID", Session("UserID"))
            WriteCookie_S("HRForm_UserName", Session("UserName"))

            'New Form

            If Request.QueryString("ID") Is Nothing Then

                If IsNumeric(Request.QueryString("E")) Then
                    iEventID = GetCurrentVersion(Request.QueryString("E"))
                Else
                    dbg("קריאה לא חוקית")
                End If

                ' Check if there is an existing Plan and user allowed to edit

                If iEventID <> 0 Then
                    Response.Redirect("FormEditor.aspx?ID=" & iEventID)
                Else
                    dbg("תקלה בפתיחת המסמך")
                End If
            Else
                lblEventID.Text = Request.QueryString("ID")

            End If
        End If
        PageHeader1.ButtonJava = "window.open('" & Session("URLRefferer") & "','_self')"
        PageHeader1.ButtonText = "חזרה"
        PageHeader1.Header = "הערכת עובד " & Period

    End Sub
      Protected Sub hdn_PreRender(sender As Object, e As System.EventArgs)
        Dim hdn As HiddenField = CType(sender, HiddenField)
        PageHeader1.Header = hdn.Value
    End Sub
#End Region

#Region "Debug"
    Sub dbg(s As String, Optional bError As Boolean = True, Optional NewID As Integer = 0)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""" & If(NewID = 0, "window.close();", "window.open('TTPlan.aspx?FT=1&ID=" & NewID & "','_self')") & """ /></div>")
        Response.End()
    End Sub
#End Region

#Region "Printing"

    Protected Sub btnprtForm_Click(sender As Object, e As System.EventArgs) Handles btnprtForm.Click, btnPrint.Click
        Dim sHdr As String = "הערכת עובד " & getPeriod() 'CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        ListViewPrint(Page, lvAnswers, sHdr)
        lvAnswers.DataBind()
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        'Verifies that the control is rendered 
    End Sub

    Sub ListViewPrint(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        LV1.Attributes("style") = "border-collapse:separate;direction:rtl;"
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        hw.InnerWriter.Write("<hr />")
        lvHdr.RenderControl(hw)
        hw.InnerWriter.Write("<hr />")
        LV1.RenderControl(hw)
        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.onload = new function(){")
        sb.Append("var printWin = window.open('', '', 'right=0")
        sb.Append(",top=0,width=1000,height=600,status=0');")
        sb.Append("printWin.document.write(""")
        Dim style As String = "<style type = 'text/css'>table {border:1px dotted white;} th {border:1px dotted Gray;font-family:Arial;} thead {display:table-header-group;} td {display:table-cell;font-size:x-small;direction:rtl;text-align:right;border:1px dotted white;font-family:Arial;} .tdxprint {border:1px dotted Gray;} .btn {color:Black;font-family:Arial;text-decoration:none;} .wp1 {width:0%;} .wp2 {width:30%;} .wp3 {width:45%;} .wp4 {width:25%;} .ansprint {color:Black;font-family:Arial; border:1px dotted Gray;} </style>"
        sb.Append(PrintedReportHeader(sTitle, sSubtitle) & style & gridHTML)
        sb.Append(""");")
        sb.Append("printWin.document.close();")
        sb.Append("printWin.focus();")
        sb.Append("printWin.print();")
        sb.Append("printWin.close();")
        sb.Append("};")
        sb.Append("</script>")
        pg.ClientScript.RegisterStartupScript(pg.[GetType](), "GridPrint", sb.ToString())
        LV1.DataBind()
    End Sub

    Private Shared Function PrintedReportHeader(sTitle As String, sSubtitle As String) As String
        Dim s As String = "<Table style='width:100%;direction:rtl;font-family:Arial;'>" & _
                        "<tr>" & _
                        "<td style='width:84%; text-align:center; font-size:x-large; font-weight:bold; color:Black; vertical-align:top;'>" & _
                        "<h1>" & sTitle & "</h1>" & _
                        "</td>" & _
                        "<td style='vertical-align:top; width:8%; text-align:right;'>תאריך:" & _
                        "<br />משתמש:" & _
                        "</td>" & _
                        "<td style='vertical-align:top; width:8%; text-align:right;'>" & _
                        Format(Today, "dd/MM/yy") & "<br/>" & _
                        ReadCookie_S("HRForm_UserName") & _
                        "</td></tr></table><br /><br />"
        Return s
    End Function

    Protected Sub btnWord_Click(sender As Object, e As System.EventArgs) Handles btnWord.Click
        Dim sHdr As String = "הערכת עובד " & getPeriod() 'CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        PrePW()
        ToWord(Page, lvAnswers, sHdr)

        lvAnswers.DataBind()
    End Sub
    Sub PrePW()

        '    lvHdr.DataBind()
        Dim btn As Button = CType(lvHdr.Items(0).FindControl("btnDate"), Button)
        If btn IsNot Nothing Then btn.Visible = False

        lvAnswers.DataBind()
        Dim sStyle1 As String = "background-color:white;border:1px dotted gray;margin-right:10px;"
        Dim sStyle2 As String = "background-color:white;border:1px dotted gray;text-align:center;width:16.6%"
        For Each lvi As ListViewItem In lvAnswers.Items
            btn = CType(lvi.FindControl("btnEdit"), Button)
            If btn IsNot Nothing Then
                btn.Visible = False
            End If
            Dim s As String
            Dim img As Image = CType(lvi.FindControl("img0"), Image)
            Dim rb As RadioButton = CType(lvi.FindControl("rb0"), RadioButton)
            Dim td As HtmlTableCell = CType(lvi.FindControl("td0"), HtmlTableCell)
            Dim tdn As HtmlTableCell = CType(lvi.FindControl("tdn0"), HtmlTableCell)
            Dim tdt As HtmlTableCell = CType(lvi.FindControl("tdt0"), HtmlTableCell)

            If img IsNot Nothing Then
                s = img.ImageUrl
                If LCase(Right(s, 6)) <> "nc.png" Then
                    If rb IsNot Nothing Then rb.Checked = True
                End If
                img.Visible = False
                rb.Visible = True
                If td IsNot Nothing Then td.Attributes.Add("style", sStyle1)
                If tdn IsNot Nothing Then tdn.Attributes.Add("style", sStyle2)
                If tdt IsNot Nothing Then tdt.Attributes.Add("style", sStyle2)
            End If
            For i = 6 To 10
                img = CType(lvi.FindControl("img" & i), Image)
                rb = CType(lvi.FindControl("rb" & i), RadioButton)
                td = CType(lvi.FindControl("td" & i), HtmlTableCell)
                tdn = CType(lvi.FindControl("tdn" & i), HtmlTableCell)
                tdt = CType(lvi.FindControl("tdt" & i), HtmlTableCell)
                If img IsNot Nothing Then
                    s = img.ImageUrl
                    If LCase(Right(s, 6)) <> "nc.png" Then
                        If rb IsNot Nothing Then rb.Checked = True
                    End If
                    img.Visible = False
                    rb.Visible = True
                    If td IsNot Nothing Then td.Attributes.Add("style", sStyle1)
                    If tdn IsNot Nothing Then tdn.Attributes.Add("style", sStyle2)
                    If tdt IsNot Nothing Then tdt.Attributes.Add("style", sStyle2)
                End If
            Next

            Dim tdx As HtmlTableCell = CType(lvi.FindControl("tdtxt"), HtmlTableCell)
            If tdx IsNot Nothing Then
                Dim sT As String = Left(tdx.InnerText.Trim, 3)
                Select Case sT
                    Case vbNullString
                        tdx.InnerText = vbNullString
                        tdx.Attributes.Add("style", "border:0px;")
                    Case "<i>"
                        tdx.InnerText = Chr(160)
                End Select
            End If
        Next

    End Sub

    Private Sub ToWord(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
 
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        Dim sb As New StringBuilder()

        Dim style As String = "<style type = 'text/css'>table {border:1px dotted white;} th {border:1px dotted Gray;font-family:Arial;} thead {display:table-header-group;} td {display:table-cell;font-size:x-small;direction:rtl;text-align:right;border:1px dotted white;font-family:Arial;} .tdxprint {border:1px dotted Gray;} .btn {color:Black;font-family:Arial;text-decoration:none;} .wp1 {width:0%;} .wp2 {width:25%;} .wp3 {width:45%;} .wp4 {width:25%;} .ansprint {color:Black;font-family:Arial; border:1px dotted Gray; background-color: White; } </style>"
        sb.Append("<html>")
        sb.Append("<header>" & style & "</header>")
        sb.Append("<body style='direction:rtl;font-family:Arial;width:500px;>")

        ' First page title

        hw.InnerWriter.Write("<div style='text-align:center;width: 100%;'><h1>" & sTitle & "</h1></div><hr />")
        lvHdr.Attributes("style") = "border-collapse:separate;"
        lvHdr.RenderControl(hw)
        hw.InnerWriter.Write("<hr />")

        'First page body

        lvAnswers.Attributes("style") = "border-collapse:separate;width:500px;"
        lvAnswers.RenderControl(hw)

        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")


        sb.Append("<div style='font-family:Arial;'>" & gridHTML & "</div>")

        sb.Append("</div></body></html>")

        Dim strReportName As String = Server.UrlEncode(sTitle.Replace(" ", "_")) & ".doc"
        Response.ContentType = "application/msword"
        Response.AddHeader("Content-Disposition", "attachment; filename=" & strReportName)
        Response.Charset = ""
        Response.Write(sb.ToString())
        Response.End()
    End Sub

#End Region

#Region "PopUP"

    'Function OpenPopUP(sF As String) As String
    '    Dim sID As String = lblCustEventID.Text
    '    Dim s As String = "window.open('TTWPPopUp.aspx?ID=" & sID & "&WP=" & Eval(sF) & "&D=" & sF & "&F=" & ViewState("CustRelateID") & "', '_blank', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=50%,width=825,height=400');return false;"
    '    Return s
    'End Function

    Function GetPostBackScript() As String

        Dim options As New PostBackOptions(btnPostback)
        Page.ClientScript.RegisterForEventValidation(options)
        Return Page.ClientScript.GetPostBackEventReference(options)

    End Function

#End Region

#Region "Util"

    Function GetCurrentVersion(lEmpID As Long, Optional iFrameID As Integer = 0) As Integer
        Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
        If ReadCookie_S("HRForm_UserID") = vbNullString Then WriteCookie_S("HRForm_UserID", Session("UserID"))
        Dim cD184 As New SqlCommand("EXEC HR_pVersionControl " & lEmpID & "," & iFrameID & "," & ReadCookie_S("HRForm_UserID"), dbConnection184)
        cD184.CommandType = Data.CommandType.Text
        dbConnection184.Open()
        Dim dr As SqlDataReader
        Try
            dr = cD184.ExecuteReader
        Catch ex As Exception
            Throw ex
            dr.Close()
            dbConnection184.Close()
            dbg("חלף זמן רב ללא שימוש במערכת. יש להכנס שנית", False)
        End Try
        Dim i As Integer = 0
        If dr.Read Then
            i = dr("EventID")
        End If
        dr.Close()
        dbConnection184.Close()
        lblEventID.Text = i
        Return i
    End Function

    Protected Sub DSWorkPlan_DB(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSAnswers.Updating
        Dim s As String = e.Command.Parameters("@FieldID").Value
        e.Command.Parameters("@Val").Value = Session("Field" & s)
        If e.Command.Parameters("@UserID").Value Is Nothing Then e.Command.Parameters("@UserID").Value = ReadCookie_S("HRForm_UserID")
    End Sub

    Function IsEditable() As Boolean
        Return True
        Return Session("CanUpdate")
    End Function
    Function Val(sF As String) As String
        Return If(IsDBNull(Eval(sF)), vbNullString, CStr(Eval(sF)))
    End Function
    Protected Sub rb_PreRender(sender As Object, e As System.EventArgs)
        Dim rb As RadioButton = CType(sender, RadioButton)
        If rb.Checked Then
            Dim lvi As ListViewItem = CType(rb.NamingContainer, ListViewItem)
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnFieldID"), HiddenField)
            Session("Field" & hdn.Value) = rb.ID.Substring(2)
        End If
    End Sub
    Protected Sub img_PreRender(sender As Object, e As System.EventArgs)

    End Sub
    Protected Sub lblTxt_PreRender(sender As Object, e As System.EventArgs)

    End Sub
    Protected Sub rb_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim rb As RadioButton = CType(sender, RadioButton)
        Dim lvi As ListViewItem = CType(rb.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("hdnFieldID"), HiddenField)
        Session("Field" & hdn.Value) = rb.ID.Substring(2)
    End Sub
#End Region

    Protected Sub btnEdit_Click(sender As Object, e As System.EventArgs)
        Session("Editing") = 1
    End Sub
    Protected Sub btnEdit_PreRender(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        If Session("Editing") = 1 Then
            btn.Attributes.Add("onclick", "alert('יש לשמור או לבטל קודם את הטקסט שנקלט'); return false;")
        Else
            btn.Attributes.Remove("onclick")
        End If
    End Sub
    Protected Sub btnEnable_Click(sender As Object, e As System.EventArgs)
        Session("Editing") = Nothing
    End Sub

    Protected Sub DS_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSEmp.Selecting
        If e.Command.Parameters("@UserID").Value Is Nothing Then e.Command.Parameters("@UserID").Value = ReadCookie_S("HRForm_UserID")
    End Sub
    Protected Sub btnDate_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lvi As ListViewItem = CType(btn.NamingContainer, ListViewItem)
        Dim dv As HtmlGenericControl = CType(lvi.FindControl("divclndr"), HtmlGenericControl)
        If dv IsNot Nothing Then
            dv.Visible = True
            btn.Visible = False
        End If


    End Sub
    Protected Sub clndr_PreRender(sender As Object, e As System.EventArgs)
        'Dim cl As Calendar = CType(sender, Calendar)
        'Dim lvi As ListViewItem = CType(cl.NamingContainer, ListViewItem)
        'Dim btn As Button = CType(lvi.FindControl("btnDate"), Button)
        'If cl.SelectedDate <> CDate(btn.Text) Then
        '    cl.SelectedDate = CDate(btn.Text)
        'End If
    End Sub

    Protected Sub btnSaveDate_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lvi As ListViewItem = CType(btn.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim dv As HtmlGenericControl = CType(lvi.FindControl("divclndr"), HtmlGenericControl)
        btn = CType(lvi.FindControl("btnDate"), Button)
        dv.Visible = False
        btn.Visible = True
        lv.DataBind()
    End Sub

    Protected Sub clndr_SelectionChanged(sender As Object, e As System.EventArgs)
        Dim cl As Calendar = CType(sender, Calendar)
        Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
        Dim cD184 As New SqlCommand("UPDATE HR_Events SET EventRegDate=GETDATE(),EventDate='" & Format(cl.SelectedDate, "yyyy-MM-dd") & "', UserID=" & ReadCookie_S("HRForm_UserID") & " WHERE EventID=" & lblEventID.Text, dbConnection184)
        cD184.CommandType = Data.CommandType.Text
        dbConnection184.Open()
        cD184.ExecuteNonQuery()
        dbConnection184.Close()
    End Sub

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        If Session("URLRefferer") <> vbNullString Then
            'Response.Write(Session("URLRefferer"))
            'Response.End()
            Response.Redirect(Session("URLRefferer"))
        End If
    End Sub
    Function getPeriod() As Integer
        Dim u As New UtilVB()
        Return u.selectDBScalar(String.Format("SELECT Book10.dbo.HR_fn_GetPeriod({0})", If(Request.QueryString("ID") Is Nothing, "0", Request.QueryString("ID"))))
    End Function
End Class
