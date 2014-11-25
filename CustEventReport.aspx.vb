Imports System.Data.SqlClient
Imports PageErrors
Partial Class CustEventReport
    Inherits System.Web.UI.Page
    Dim iCustEventID As Integer

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Session("FrameID") Is Nothing Then Response.Redirect("CustEventReportuS.Aspx")
            If Request.QueryString("C") <> vbNullString Then
                Session("lastcustID") = Request.QueryString("C")
            End If
        End If
        On Error Resume Next
        If Err.Number <> 0 Then Err.Clear()
        Dim lsb As ListBox
        Dim lb1 As Label
        Dim fv As FormView = FVInsertEvent
        lsb = CType(fv.FindControl("lbcustomers"), ListBox)
        Dim hl As HyperLink = CType(fv.FindControl("hlREPHDR"), HyperLink)
        Dim hl1 As HyperLink = CType(fv.FindControl("hlCustDet"), HyperLink)
        If Not IsPostBack And IsNumeric(Session("lastCustID")) Then
            On Error Resume Next
            lsb.ClearSelection()
            lsb.SelectedValue = Session("lastCustID")
            hl.Text = "פעולות אחרונות ללקוח " & lsb.SelectedItem.Text & " ת.ז. " & lsb.SelectedValue

            hl1.NavigateUrl = "CustStatus.aspx?CID=" & lsb.SelectedValue
            If Err.Number <> 0 Then
                Err.Clear()
                hl.Text = vbNullString
                lsb.SelectedValue = vbNullString
                Session("lastCustID") = vbNullString
            End If
            On Error GoTo 0
        Else
            hl.Text = "פעולות אחרונות ללקוח " & lsb.SelectedItem.Text & " ת.ז. " & lsb.SelectedValue
            hl1.NavigateUrl = "CustStatus.aspx?CID=" & lsb.SelectedValue
        End If
        'If IsNumeric(Session("FrameID")) Then
        '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '    Dim ConComp As New SqlCommand("SELECT * FROM ExEventList_P WHERE CustFrameID = " & Session("FrameID") & " AND ISNULL(RestoreDone,1)=1 ORDER BY ExEventID_P", dbConnection)
        '    ConComp.CommandType = Data.CommandType.Text
        '    dbConnection.Open()
        '    Dim dr As SqlDataReader = ConComp.ExecuteReader
        '    Dim s As String = vbNullString
        '    While dr.Read()
        '        If s = vbNullString Then s = "<table border=""1""><tr><td colspan=""2""><b>ישנם ארועים חריגים לשחזור עבור הלקוחות הבאים:</b></td></tr><tr><td><b>שם הדוח</b></td><td><b>ממתי</b></td><tr>"
        '        s &= "<tr><td align=""right"">" & dr("ExEventHeader") & "</td><td align=""right"">" & If(IsDBNull(dr("LogDate")), vbNullString, Format(dr("Logdate"), "dd/MM/yy HH:mm:ss")) & "</td></tr>"
        '    End While
        '    If s <> vbNullString Then
        '        s &= "<tr><td colspan=""2"" align=""right""><b>כדי לשחזר או למחוק את ארוע:</b><br />1. לבחור בלקוח<br />2. לבחור בפעולה <b>מילוי טופס ארוע חריג</b><br />3. לשחזר או למחוק את הארוע על פי ההוראות על המסך</td></tr></table>"
        '        scrMsg(s, True)
        '    End If
        'End If

    End Sub
    Protected Sub LBCustomers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lb As ListBox = CType(sender, ListBox)
        Dim fv As FormView = CType(lb.NamingContainer, FormView)
        Dim hl As HyperLink = CType(fv.FindControl("HLREPHDR"), HyperLink)
        Dim hl1 As HyperLink = CType(fv.FindControl("hlCustDet"), HyperLink)
        Dim s As String = CType(lb.SelectedValue, String)
        If s = "<לקוח חדש>" Then Response.Redirect("CustomerAdd2.aspx")

        If s = "[ארוע ללא לקוח]" Then
            Response.Redirect("ExEvent.aspx")
        ElseIf IsNumeric(lb.SelectedValue) Then
            Session("lastcustID") = lb.SelectedValue
            hl.Text = "פעולות אחרונות ללקוח " & lb.SelectedItem.Text & " ת.ז. " & lb.SelectedValue
            hl1.NavigateUrl = "CustStatus.aspx?CID=" & lb.SelectedValue
        End If
    End Sub
    Function FindEventTypeID(ByVal sender As Object) As Integer

    End Function
    Protected Sub BtnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        InsertEvent(fv)
    End Sub
    Public Sub InsertEvent(ByVal fv As FormView)
        Dim CustomerID As Long = 0
        Dim lsb As ListBox = CType(fv.FindControl("LBCustomers"), ListBox)
        If lsb.SelectedValue IsNot Nothing Then
            If IsNumeric(lsb.SelectedValue) Then
                CustomerID = CType(lsb.SelectedValue, Long)
            Else
                Response.Redirect("ErrMessage.aspx?m=המערכת לא זיהתה את הלקוח שעליו יש לרשום את הפעולה. נא Pלחזור על רישום הפעולה")
            End If
        Else
            Response.Redirect("ErrMessage.aspx?m=המערכת לא זיהתה את הלקוח שעליו יש לרשום את הפעולה. נא לחזור על רישום הפעולהx")
        End If

        lsb = CType(fv.FindControl("LSBEventType"), ListBox)
        Dim EventTypeID As Integer = CType(lsb.SelectedValue, Integer)

        Dim CustEventRegDate As DateTime = Now()

        Dim cal As Calendar = CType(fv.FindControl("CalEvent"), Calendar)
        Dim CustEventDate As DateTime
        CustEventDate = cal.SelectedDate

        Dim tb As TextBox = CType(fv.FindControl("TBEventComment"), TextBox)
        Dim CustEventComment As String = tb.Text
        On Error Resume Next
        Dim s As String = Session("FrameID")
        If Err.Number <> 0 Then
            Err.Clear()
            '      MsgBox("לא ניתן להוסיף פעולה")
            Response.Redirect("CustEventReport.aspx")

        End If
        Dim CustFrameID As Integer = Int(s)

        Dim CFramemanager As String = FindFrameManager(CustFrameID)

        Dim CUserID As Integer = Session("UserID")

        Dim EventUpdateTypeID As Integer = FindEventUpdateTypeID(EventTypeID)

        Select Case EventUpdateTypeID
            Case 1  'סימון סטטוס

            Case 2  'מחיקת סטטוס

            Case 3  'עדכון סטטוס

            Case 4  'תשלום

        End Select
        AddEvent(CustomerID, EventTypeID, CustEventRegDate, CustEventDate, CustEventComment, CustFrameID, CFramemanager, CUserID, EventUpdateTypeID)
    End Sub
    Protected Sub AddEvent(ByVal CustomerID As Long, ByVal EventTypeId As Integer, ByVal CustEventRegDate As DateTime, _
    ByVal CustEventDate As DateTime, ByVal CustEventComment As String, ByVal CustFrameID As Integer, ByVal CFrameManager As String, _
    ByVal UserID As String, ByVal EventUpdateTypeID As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Cust_AddEvent", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.AddWithValue("CustomerID", CustomerID)
        ConComp.Parameters.AddWithValue("CustEventTypeID", EventTypeId)
        ConComp.Parameters.AddWithValue("CustEventRegDate", CustEventRegDate)
        ConComp.Parameters.AddWithValue("CustEventDate", CustEventDate)
        ConComp.Parameters.AddWithValue("CustEventComment", CustEventComment)
        ConComp.Parameters.AddWithValue("CustFrameID", CustFrameID)
        ConComp.Parameters.AddWithValue("CFramemanager", CFrameManager)
        ConComp.Parameters.AddWithValue("UserID", UserID)
        ConComp.Parameters.AddWithValue("CustEventUpdateTypeID", EventUpdateTypeID)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub
    Private Function FindEventUpdateTypeID(ByVal EventTypeID As Integer) As Integer
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select CustEventUpdateTypeID From CustEventTypes Where CustEventTypeID=" & EventTypeID, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        Dim i As Integer = dr.Item("CustEventUpdateTypeID")
        dbConnection.Close()
        Return i
    End Function
    Private Function FindFrameManager(ByVal FrameID As Integer) As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select FrameManager From FrameList Where FrameID=" & FrameID, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        Dim s As String = dr.Item("FrameManager")
        dbConnection.Close()
        Return s
    End Function

    Protected Sub GVCustomersList_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridView = CType(sender, GridView)
        Dim gvr As GridViewRow
        Dim LidO As Long = 0
        Dim i As Integer

        For Each gvr In gv.Rows
            If CLng(gvr.Cells(3).Text) = LidO Then
                For i = 0 To gvr.Cells.Count - 3
                    gvr.Cells(i).Enabled = False
                Next
            End If
            LidO = CLng(gvr.Cells(3).Text)
        Next
    End Sub
    Public Function TruncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function
    Protected Sub LSBEventType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lb As ListBox = CType(sender, ListBox)
        Dim i As Integer = CType(lb.SelectedValue, Integer)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select CustEventUrl From CustEventTypes Where CustEventTypeID=" & i, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        Dim s As String
        s = CStr(dr.Item("CustEventUrl") & "")
        dbConnection.Close()
        Session("CustEventTypeID") = i
        If Len(s) > 0 Then
            Session("Hist") = Replace(Mid(Trim(Page.ToString), 5), "_", ".")
            'If Left(s, 11) = "javascript:" Then
            '    s = Left(s, 11) & "confirm('האם לפתוח תוכנית חדשה?');" & Mid(s, 12)
            'End If
            Response.Redirect(s)
        Else
            Session("Hist") = vbNullString
        End If
    End Sub

    Protected Sub DSCustomers_Deleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs)
        Dim ds As SqlDataSource = CType(sender, SqlDataSource)
        '    If MsgBox("האם אתה בטוח שברצונך למחוק את רשומת הלקוח?", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
        '        ds.DeleteParameters(0).DefaultValue = ""
        '    End If
    End Sub

    Protected Sub TBDate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim fv As FormView = CType(tb.NamingContainer, FormView)
        Dim cal As Calendar = CType(fv.FindControl("CALEVENT"), Calendar)
        Dim rv As RangeValidator = CType(fv.FindControl("RVDATE"), RangeValidator)
        On Error Resume Next
        Dim d As Date = CType(tb.Text, Date)
        If Err.Number = 0 Then
            If cal.SelectedDate <> tb.Text Then
                cal.SelectedDate = d
                cal.VisibleDate = d
            End If
        Else
            Err.Clear()
            rv.IsValid = False
        End If
    End Sub

    Protected Sub CalEvent_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cal As Calendar = CType(sender, Calendar)
        Dim fv As FormView = CType(cal.NamingContainer, FormView)
        Dim tb As TextBox = CType(fv.FindControl("TBDATE"), TextBox)
        tb.Text = cal.SelectedDate
    End Sub

    Protected Sub CalEvent_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cal As Calendar = CType(sender, Calendar)
        If IsPostBack = False Then
            cal.SelectedDate = Today
            cal.VisibleDate = Today
        End If
    End Sub

    Protected Sub LBCustomers_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lstb As ListBox = CType(sender, ListBox)
        Dim fv As FormView = CType(lstb.NamingContainer, FormView)
        Dim hl As HyperLink = CType(fv.FindControl("HLREPHDR"), HyperLink)
        If Not Session("LastCustID") Is Nothing And lstb.SelectedValue = vbNullString Then
            On Error Resume Next
            lstb.SelectedValue = CType(Session("LastCustID"), Long)
            If Err.Number <> 0 Then Err.Clear()
            Session("Lastcustid") = Nothing
            On Error Resume Next
            hl.Text = "פעולות אחרונות ללקוח " & lstb.SelectedItem.Text & " ת.ז. " & lstb.SelectedValue
            If Err.Number <> 0 Then
                Err.Clear()
                hl.Text = "לא נמצא לקוח עם ת.ז. זו"
                Dim gv As GridView = CType(fv.FindControl("GridView1"), GridView)
                gv.DataBind()
            End If
        Else
            'lb1.Text = "פעולות אחרונות ללקוח"
        End If

    End Sub

    Protected Sub btnDel_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim i As Integer = Session("CanDelete")
        If i <> 1 Then
            btn.Visible = False
        End If

    End Sub

    Protected Sub btnSA_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim tb As TextBox = CType(gvr.FindControl("TBSA"), TextBox)
        Dim lbl As Label = CType(gvr.FindControl("LBComment"), Label)
        tb.Visible = True
        lbl.Visible = False
    End Sub

    Protected Sub LBTNCORR_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbtn As LinkButton = CType(sender, LinkButton)
        Dim gvr As GridViewRow = CType(lbtn.NamingContainer, GridViewRow)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNCUSTEID"), HiddenField)
        Session("CustEventID") = CType(hdn.Value, Integer)
        Response.Redirect("CustEventReportU.aspx")
    End Sub

    Protected Sub TBID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TBID.TextChanged
        Dim tb As TextBox = CType(sender, TextBox)
        If IsNumeric(tb.Text) Then Session("LastCustID") = tb.Text
        '        Response.Redirect("~/CustEventReport.aspx")

    End Sub

    Protected Sub LBTNDEL_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub DSEventList_Deleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEventList.Deleting
    End Sub

    Protected Sub DSEventList_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSEventList.Deleted

    End Sub

    Protected Sub BtnOK_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        If Session("FrameID") Is Nothing Then
            btn.Enabled = False
        End If
    End Sub

    Protected Sub DSEventList_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSEventList.Selecting
        Dim lbx As ListBox = CType(FVInsertEvent.FindControl("LBCustomers"), ListBox)
        Dim s As String = vbNullString
        If lbx IsNot Nothing Then
            If lbx.SelectedIndex >= 0 Then
                s = lbx.SelectedValue
            ElseIf Session("LastCustID") IsNot Nothing Then
                s = Session("LastCustID")
            End If
            e.Command.Parameters(0).Value = CLng(s)
        End If
    End Sub
    Sub scrMsg(sMsg As String, bErr As Boolean)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
    Protected Sub CBLEFTTOO_CheckedChanged(sender As Object, e As System.EventArgs) Handles CBLEFTTOO.CheckedChanged
        Dim cb As CheckBox = CType(sender, CheckBox)
        If cb.Checked Then
            Session("LeftToo") = 1
        Else
            Session("LeftToo") = Nothing
        End If
    End Sub

    Protected Sub CBLEFTTOO_PreRender(sender As Object, e As System.EventArgs) Handles CBLEFTTOO.PreRender

    End Sub

    Protected Sub CBLEFTTOO_DataBinding(sender As Object, e As System.EventArgs) Handles CBLEFTTOO.DataBinding
        If Session("LeftToo") = 1 Then CBLEFTTOO.Checked = True Else CBLEFTTOO.Checked = False
    End Sub

    Protected Sub HL_PreRender(sender As Object, e As System.EventArgs)
        Dim hl As HyperLink = CType(sender, HyperLink)
        Dim s As String = hl.NavigateUrl
        If Left(s, 11) = "javascript:" Then
            Dim i As Integer = InStr(s, "&ID=")
            If i > 0 Then
                Dim s1 As String = Mid(s, i)
                s = Left(s, i - 1)
                s = s.Replace("?", "?" & Mid(s1, 2) & "&")
                hl.NavigateUrl = s
            End If
        End If

    End Sub
    Function GetPostBackScript() As String

        Dim options As New PostBackOptions(btnPostback)
        Page.ClientScript.RegisterForEventValidation(options)
        Return Page.ClientScript.GetPostBackEventReference(options)

    End Function

End Class
