Imports System.Data.SqlClient
Imports WRCookies
Partial Class CustEventReportuS
    Inherits System.Web.UI.Page
    Dim iCustEventID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("LeftToo") <> vbNullString Then
            CBLEFTTOO.Checked = True
            Session("LeftToo") = Nothing
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

    End Sub
    Protected Sub LBCustomers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lb As ListBox = CType(sender, ListBox)
        Dim fv As FormView = CType(lb.NamingContainer, FormView)
        Dim hl As HyperLink = CType(fv.FindControl("HLREPHDR"), HyperLink)
        Dim hl1 As HyperLink = CType(fv.FindControl("hlCustDet"), HyperLink)
        Dim s As String = CType(lb.SelectedValue, String)
        If s = "<לקוח חדש>" Then Response.Redirect("CustomerAdd2.aspx")
        WriteCookie_S("RUS_CustomerID", lb.SelectedValue)
        WriteCookie_S("RUS_CustomerName", lb.SelectedItem.Text)

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
    End Sub
    Protected Sub AddEvent(ByVal CustomerID As Long, ByVal EventTypeId As Integer, ByVal CustEventRegDate As DateTime, _
    ByVal CustEventDate As DateTime, ByVal CustEventComment As String, ByVal CustFrameID As Integer, ByVal CFrameManager As String, _
    ByVal UserID As String, ByVal EventUpdateTypeID As Integer)
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
    Protected Sub hl_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim hl As HyperLink = CType(sender, HyperLink)
        Dim s As String = hl.NavigateUrl
        If InStr(LCase(s), "ttplanreportx.aspx") > 0 Then
            s &= "&F=" & DDLFRAMES.SelectedValue
            s &= "&U=" & Session("UserID")
            s &= "&C=" & Session("LastCustID")
            hl.NavigateUrl = s
        End If
    End Sub

    Protected Sub DDLFRAMES_Load(sender As Object, e As System.EventArgs) Handles DDLFRAMES.Load
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = ReadCookie_S("RUS_FrameID")
        Dim sN As String = ReadCookie_S("RUS_FrameName")
        If s <> vbNullString Then
            Dim li As ListItem = ddl.Items.FindByValue(s)
            If li Is Nothing Then
                If Not IsPostBack Then
                    li = New ListItem(sN, s)
                    ddl.Items.Add(li)
                End If
            End If
            If li IsNot Nothing And Not IsPostBack Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub
    Protected Sub LSB_Load(sender As Object, e As System.EventArgs)
        Dim lb As ListBox = CType(sender, ListBox)
        Dim s As String = ReadCookie_S("RUS_CustomerID")
        Dim sN As String = ReadCookie_S("RUS_CustomerName")
        If s <> vbNullString Then
            Session("LastCustID") = CLng(s)
            Dim li As ListItem = lb.Items.FindByValue(s)
            If li Is Nothing Then
                If Not IsPostBack Then
                    li = New ListItem(sN, s)
                    lb.Items.Add(li)
                End If
            End If
            If li IsNot Nothing And Not IsPostBack Then
                lb.ClearSelection()
                li.Selected = True
                Dim gv As GridView = CType(FVInsertEvent.FindControl("GridView1"), GridView)
                gv.DataBind()
            End If
        End If
    End Sub

    Protected Sub DDLFRAMES_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles DDLFRAMES.SelectedIndexChanged
        WriteCookie_S("RUS_FrameID", DDLFRAMES.SelectedValue)
        WriteCookie_S("RUS_FrameName", DDLFRAMES.SelectedItem.Text)
    End Sub
End Class
