Imports System.Data.SqlClient
Imports System.IO
Imports System.Data
Imports BesConst
Imports PageErrors

Partial Class TTPlanOld
    Inherits System.Web.UI.Page
#Region "Load"
    Dim iRet As Integer
    Dim CustEventTypeID As Integer

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        CustEventTypeID = Request.QueryString("CTID")
        System.GC.Collect()
        Dim iCustEventID As Integer = 0
        Dim iCustRelateID As Integer = 0
        Dim iCanUpdate As Integer = 0
        Dim dCustEventDate As DateTime

        ' First Entry

        If Not IsPostBack Then

            Session("URLRefferer") = If(Request.UrlReferrer Is Nothing, "CustEventReport.Aspx", Request.UrlReferrer.ToString)
            Session("FormDisplayType") = 1

            'New Form

            If Request.QueryString("ID") Is Nothing Then

                ' Check if there is an existing Plan and user allowed to edit

                PlanStatus(iCustEventID, iCustRelateID, iCanUpdate, dCustEventDate)

                ' If A Plan already exists  then redirect with eventid

                If iCustEventID <> 0 Then
                    Response.Redirect("TTPlan.aspx?ID=" & iCustEventID & "&FT=1")
                End If

                ' Is the User allowed to Open a new plan

                If iCanUpdate = 0 Then

                    dbg("אין תוכנית תמיכות ללקוח זה", False)

                Else

                    If Request.QueryString("FT") Is Nothing Then dbg("אין סוג תוכנית")

                    iRet = OpenNewPlan(Request.QueryString("FT"), Session("FrameID"), Session("LastCustID"))
                    Response.Redirect("TTPlan.aspx?FT=1&ID=" & iRet)

                End If

            Else

                PlanStatus(iCustEventID, iCustRelateID, iCanUpdate, dCustEventDate)
                Session("CustEventID") = iCustEventID
                Session("FormDisplayType") = iCanUpdate
                Session("CustEventDate") = dCustEventDate
                Session("CustRelateID") = iCustRelateID
                lblCustEventID.Text = Request.QueryString("ID")

            End If
        End If
        PageHeader1.ButtonJava = "window.open('" & Session("URLRefferer") & "','_self')"
        PageHeader1.ButtonText = "חזרה"

        LVWeeklyPlan.DataBind()
        '     btnSave.Visible = Session("FormDisplayType") = 1
    End Sub
    Function OpenNewPlan(iFormTypeID As Integer, iFrameID As Integer, lCustomerID As Long) As Integer
        Dim dr As SqlDataReader

        'Check if there is already a plan if so retrieve it

        Dim iC As Integer = GetCurrentVersion()
        If iC <> 0 Then
            Response.Redirect("TTPlan.aspx?FT=1&ID=" & iC)
        End If

        ' Add Plan to 184

        Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
        Dim cD184 As New SqlCommand(vbNullString, dbConnection184)

        Dim sql1 As String = "DECLARE @D datetime" & vbCrLf & _
                            "DECLARE @CFrameManager nvarchar(50)" & vbCrLf & _
                            "DECLARE @CustEventUpdateTypeID int" & vbCrLf & _
                           "DECLARE @CustEventTypeID int" & vbCrLf & _
                            "SET @D = GETDATE()" & vbCrLf & _
                            "SET @CustEventUpdateTypeID = 1" & vbCrLf & _
                             "SELECT @CustEventTypeID = CustEventTypeID FROM TT_FormTypes WHERE ID = " & iFormTypeID & vbCrLf & _
                            "SELECT @CFrameManager = FrameManager FROM FrameList WHERE FrameID =" & iFrameID & vbCrLf & _
                             "INSERT INTO TT_Forms (FormTypeID,UserID,LoadTime) VALUES(" & iFormTypeID & "," & Session("UserID") & ",@D)" & vbCrLf & _
                            "SELECT ID,@CustEventTypeID as CustEventTypeID,@CFrameManager As FM,@CustEventUpdateTypeID as UT,@D As D FROM TT_Forms WHERE Loadtime=@D AND UserID = " & Session("UserID")

        cD184.CommandText = sql1
        cD184.CommandType = Data.CommandType.Text
        dbConnection184.Open()
        Dim iCustEventTypeID As Integer
        Dim D As DateTime
        Dim iFormID As Integer
        Dim sFM As String
        Dim iUT As Integer

        Try
            dr = cD184.ExecuteReader
            If dr.Read Then
                iCustEventTypeID = dr("CustEventTypeID")
                D = dr("D")
                iFormID = dr("ID")
                sFM = dr("FM")
                iUT = dr("UT")
            Else
                dr.Close()
                dbConnection184.Close()
                dbg("קריאת מספר תוכנית נכשלה ")
                Return -2
            End If
        Catch ex As Exception
            If dr IsNot Nothing Then dr.Close()
            dbConnection184.Close()
            dbg("כתיבת תוכנית נכשלה <br />" & ex.Message)
            Return -1
        End Try
        dr.Close()

        ' Add OP in 21

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        cD.CommandType = Data.CommandType.Text

        Dim sql2 As String = "EXEC Cust_AddEvent	" & lCustomerID & "," & vbCrLf & _
                       iCustEventTypeID & "," & vbCrLf & _
                       "'" & Format(D, "yyyy-MM-dd HH:mm:ss") & "'," & vbCrLf & _
                       "'" & Format(D, "yyyy-MM-dd") & "'," & vbCrLf & _
                       "'" & "תוכנית תמיכות " & "'," & vbCrLf & _
                       iFrameID & "," & vbCrLf & _
                       "'" & sFM & "'," & vbCrLf & _
                       Session("UserID") & "," & vbCrLf & _
                       iUT & "," & vbCrLf & _
                       iFormID
        cD.CommandText = sql2
        dbConnection.Open()
        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            cD184.CommandText = "DELETE FROM TT_Forms WHERE ID = " & iFormID
            cD184.ExecuteNonQuery()
            dbConnection184.Close()
            dbConnection.Close()
            dbg("כתיבת פעולה נכשלה <br />" & ex.Message)
            Return -3
        End Try



        dbConnection184.Close()
        dbConnection.Close()

        Return GetCurrentVersion()

    End Function
    Protected Sub DSCustomer_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSCustomer.Selecting
        If e.Command.Parameters("@CustEventID").Value = Nothing Then
            e.Command.Parameters("@CustEven").Value = iRet
        End If
    End Sub
    Protected Sub hdn_PreRender(sender As Object, e As System.EventArgs)
        Dim hdn As HiddenField = CType(sender, HiddenField)
        PageHeader1.Header = hdn.Value.Replace("תמיכות", "תמיכות (ישנה)")
    End Sub
    Function WW(i As Integer) As String
        Dim s As String = Chr(160)

        If IsDBNull(Eval("P" & i)) Then
            If Not IsDBNull(Eval("C" & i)) Then
                s &= Eval("C" & i)
            End If
        Else
            s = Eval("P" & i)
            If Not IsDBNull(Eval("C" & i)) Then
                s &= "<br />" & Eval("C" & i)
            End If
        End If
        Return s
    End Function
#End Region

#Region "SaveAnswer"

    'Protected Sub btnSave_PreRender(sender As Object, e As System.EventArgs) Handles btnSave.PreRender
    '    Dim btn As ImageButton = CType(sender, ImageButton)
    '    btn.Visible = Session("FormDisplayType") = 1
    'End Sub

#End Region

#Region "Debug"
    Sub dbg(s As String, Optional bError As Boolean = True, Optional NewID As Integer = 0)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""" & If(NewID = 0, "window.open('CustEventReport.aspx','_self');", "window.open('TTPlan.aspx?FT=1&ID=" & NewID & "','_self')") & """ /></div>")
        '                      "<br /><br /><br /><input type='button' value='אישור' onclick=""" & If(NewID = 0, "window.close();", "window.open('TTPlan.aspx?FT=1&ID=" & NewID & "','_self')") & """ /></div>")
        Response.End()
    End Sub
#End Region

#Region "Printing"

    Protected Sub btnprtForm_Click(sender As Object, e As System.EventArgs) Handles btnprtForm.Click
        Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        Dim iSaveFormDisplayType As Integer = Session("FormDisplayType")
        Session("FormDisplayType") = 0
        lvAnswers.DataBind()
        ListViewPrint(Page, lvAnswers, sHdr)
        Session("FormDisplayType") = iSaveFormDisplayType
        lvAnswers.DataBind()
    End Sub

    Protected Sub btnprWP_Click(sender As Object, e As System.EventArgs) Handles btnprWP.Click
        Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        lvWorkPlan.InsertItemPosition = InsertItemPosition.None
        lvWorkPlan.DataBind()
        For Each lvi In lvWorkPlan.Items
            'Dim btn As Button = CType(lvi.FindControl("btnEdit"), Button)
            'If btn IsNot Nothing Then btn.Visible = False
            'btn = CType(lvi.FindControl("btnDel"), Button)
            'If btn IsNot Nothing Then btn.Visible = False
        Next
        ListViewPrint(Page, lvWorkPlan, sHdr)
    End Sub

    Protected Sub btnprWWP_Click(sender As Object, e As System.EventArgs) Handles btnprWWP.Click
        Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        ListViewPrint(Page, LVWeeklyPlan, sHdr.Replace("תמיכות", "שבועית"))
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        'Verifies that the control is rendered 
    End Sub

    Sub ListViewPrint(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        LV1.Attributes("style") = "border-collapse:separate;direction:rtl;"
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
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
                        HttpContext.Current.Session("UserName") & _
                        "</td></tr></table><br /><br />"
        Return s
    End Function

    Protected Sub btnWord_Click(sender As Object, e As System.EventArgs) Handles btnpWord.Click
        Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
        Dim bCanUpdate As Boolean = Session("CanUpdate")

        Session("CanUpdate") = 0
        lvWorkPlan.InsertItemPosition = InsertItemPosition.None
        lvWorkPlan.DataBind()
        lvAnswers.DataBind()

        ToWord(Page, lvAnswers, sHdr)

        Session("CanUpdate") = bCanUpdate
        lvWorkPlan.InsertItemPosition = InsertItemPosition.LastItem
        lvWorkPlan.DataBind()
        lvAnswers.DataBind()

    End Sub

    Private Sub ToWord(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        Dim strReportName As String = Server.UrlEncode(sTitle.Replace(" ", "_")) & ".doc"
        Dim cbl As CheckBoxList = cblWord

        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        Dim sb As New StringBuilder()

        Dim style As String = "<style type = 'text/css'>table {border:1px dotted white;} th {border:1px dotted Gray;font-family:Arial;} thead {display:table-header-group;} td {display:table-cell;font-size:x-small;direction:rtl;text-align:right;border:1px dotted white;font-family:Arial;} .tdxprint {border:1px dotted Gray;} .btn {color:Black;font-family:Arial;text-decoration:none;} .wp1 {width:0%;} .wp2 {width:25%;} .wp3 {width:45%;} .wp4 {width:25%;} .ansprint {color:Black;font-family:Arial; border:1px dotted Gray; background-color: White; } </style>"
        sb.Append("<html>")
        sb.Append("<header>" & style & "</header>")
        sb.Append("<body style='direction:rtl;font-family:Arial;>")

        If cbl.Items(0).Selected Then

            ' First page title

            hw.InnerWriter.Write("<div style='text-align:center;width: 100%;'><h1>" & sTitle & "</h1></div><hr />")
            lvHdr.Attributes("style") = "border-collapse:separate;"
            lvHdr.RenderControl(hw)
            hw.InnerWriter.Write("<hr />")

            'First page body

            'Make Radiobutton visible for word

            For Each lvi As ListViewItem In lvAnswers.Items
                Dim img As Image = CType(lvi.FindControl("imgrbl"), Image)
                If img IsNot Nothing Then img.Visible = False
                Dim rbl As RadioButtonList = CType(lvi.FindControl("rblv"), RadioButtonList)
                If rbl IsNot Nothing Then
                    rbl.Visible = True
                    rbl_PreRender(rbl, Nothing)
                End If
            Next

            lvAnswers.Attributes("style") = "border-collapse:separate;"
            lvAnswers.RenderControl(hw)
        End If

        If cbl.Items(1).Selected Then

            'Second page title

            hw.InnerWriter.Write("<div style='text-align:center;width: 100%;page-break-before: always;'><h1>" & sTitle & "</h1></div><hr />")
            lvHdr.RenderControl(hw)
            hw.InnerWriter.Write("<hr />")

            'second page body

            For Each lvi As ListViewItem In lvWorkPlan.Items
                For Each ctrl As Control In lvi.Controls
                    If Left(ctrl.ID, 3) = "btn" Then ctrl.Visible = False
                Next
            Next

            lvWorkPlan.RenderControl(hw)

        End If

        If cbl.Items(2).Selected Then


            'Third page title

            hw.InnerWriter.Write("<div style='text-align:center;width: 100%;page-break-before: always;'><h1>" & sTitle.Replace("תמיכות", "שבועית") & "</h1></div><hr />")
            lvHdr.RenderControl(hw)
            hw.InnerWriter.Write("<hr />")

            'Third page body


            LVWeeklyPlan.RenderControl(hw)

            tblsign.RenderControl(hw)

        End If

        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")


        sb.Append("<div style='font-family:Arial;'>" & gridHTML & "</div>")
        sb.Append("</div></body></html>")

        Response.ContentType = "application/msword"
        Response.AddHeader("Content-Disposition", "attachment; filename=" & strReportName)
        Response.Charset = ""
        Response.Write(sb.ToString())
        Response.End()
    End Sub

#End Region

#Region "PopUP"

    Function OpenPopUP(sF As String) As String
        Dim sID As String = lblCustEventID.Text
        Dim s As String = "window.open('TTWPPopUp.aspx?ID=" & sID & "&WP=" & Eval(sF) & "&D=" & sF & "&F=" & Session("CustRelateID") & "', '_blank', 'toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=50%,width=825,height=400');return false;"
        Return s
    End Function

    Function GetPostBackScript() As String

        Dim options As New PostBackOptions(btnPostback)
        Page.ClientScript.RegisterForEventValidation(options)
        Return Page.ClientScript.GetPostBackEventReference(options)

    End Function

#End Region

#Region "Util"

    Sub PlanStatus(ByRef iCustEventID As Integer, ByRef iCustRelateID As Integer, ByRef iCanUpdate As Boolean, ByRef dCustEventDate As DateTime)
        iCustEventID = 0
        iCustRelateID = 0
        iCanUpdate = 0
        If IsNumeric(Session("LastCustID")) And IsNumeric(Session("FrameID")) And IsNumeric(Session("UserID")) Then
            Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
            Dim cd As New SqlCommand("SELECT CustRelateID,CustEventID,CanUpdate,CustEventDate FROM dbo.TT_fnPlanstatus(" & Session("LastCustID") & "," & Session("UserID") & "," & Session("FrameID") & "," & CustEventTypeID & "," & If(Request.QueryString("ID") = Nothing, "NULL", Request.QueryString("ID")) & ")", dbConnection184)
            dbConnection184.Open()
            Dim dr As SqlDataReader = cd.ExecuteReader
            If dr.Read Then
                If Not IsDBNull(dr("CustEventID")) Then iCustEventID = dr("CustEventID")
                If Not IsDBNull(dr("CustRelateID")) Then iCustRelateID = dr("CustRelateID")
                If Not IsDBNull(dr("CustEventDate")) Then dCustEventDate = dr("CustEventDate")
                iCanUpdate = dr("CanUpdate")
                Session("CanUpdate") = dr("CanUpdate")
            End If
            dr.Close()
            dbConnection184.Close()
        End If

    End Sub

    Function GetCurrentVersion() As Integer
        Dim connStr21 As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection21 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr21)
        Dim cD21 As New SqlCommand("EXEC TT_pVersionControl " & Session("LastCustID") & "," & Session("FrameID") & "," & Session("UserID"), dbConnection21)
        cD21.CommandType = Data.CommandType.Text
        dbConnection21.Open()
        Dim dr As SqlDataReader = cD21.ExecuteReader
        Dim i As Integer = 0
        If dr.Read Then
            i = dr("CustEventID")
        End If
        dr.Close()
        dbConnection21.Close()
        lblCustEventID.Text = i
        Return i
    End Function

    Protected Sub DSWorkPlan_DB(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSWorkPlan.Updating, DSWorkPlan.Updating, DSAnswers.Updating
        e.Command.Parameters("@CustEventID").Value = GetCurrentVersion()
    End Sub

    Function IsEditable() As Boolean
        Return Session("CanUpdate")
    End Function

    Function IsPrinted() As Boolean
        Return Eval("PrintSubText") Or Session("CanUpdate")
    End Function

#End Region
    Protected Sub rbl_PreRender(sender As Object, e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("hdnval"), HiddenField)
        If hdn.Value <> vbNullString Then
            Dim li As ListItem = rbl.Items.FindByValue(hdn.Value)
            If li IsNot Nothing Then li.Selected = True
        End If
    End Sub
    Protected Sub rbl_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("hdnval"), HiddenField)
        hdn.Value = rbl.SelectedValue
    End Sub
    Function ValImage(Sf As String) As String
        Dim s As String = "images/Val0.png"
        If Not IsDBNull(Eval(Sf)) Then
            s = "images/Val" & Eval(Sf) & ".png"
        End If
        Return s
    End Function

    Protected Sub btnBack_Click(sender As Object, e As System.EventArgs) Handles btnBack.Click
        If Session("URLRefferer") <> vbNullString Then
            'Response.Write(Session("URLRefferer"))
            'Response.End()
            Response.Redirect(Session("URLRefferer"))
        End If
    End Sub
End Class
