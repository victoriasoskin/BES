Imports System.Data.SqlClient
Partial Class CustEventReportU
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack And IsNumeric(Session("lastCustID")) Then
            On Error Resume Next
            Dim fv As FormView = FVInsertEvent
            Dim lsb As ListBox = CType(fv.FindControl("lbcustomers"), ListBox)
            lsb.SelectedValue = Session("lastCustID")
            Dim lb1 As Label = CType(fv.FindControl("LBLREPHDR"), Label)
            lb1.Text = "פעולות אחרונות ללקוח " & lsb.SelectedItem.Text & " ת.ז. " & lsb.SelectedValue
            If Err.Number <> 0 Then
                Err.Clear()
                lb1.Text = vbNullString
                lsb.SelectedValue = vbNullString
                Session("lastCustID") = vbNullString
            End If
            On Error GoTo 0
        End If

    End Sub
    Protected Sub LBCustomers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lb As ListBox = CType(sender, ListBox)
        Dim fv As FormView = CType(lb.NamingContainer, FormView)
        Dim lb1 As Label = CType(fv.FindControl("LBLREPHDR"), Label)
        Dim s As String = CType(lb.SelectedValue, String)
        If s = "<לקוח חדש>" Then
            Response.Redirect("CustomerAdd2.aspx")
        Else
            Session("lastcustID") = lb.SelectedValue
            lb1.Text = "פעולות אחרונות ללקוח " & lb.SelectedItem.Text & " ת.ז. " & lb.SelectedValue
        End If
    End Sub
    Function FindEventTypeID(ByVal sender As Object) As Integer

    End Function
    Protected Sub BtnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        UpdateEvent(fv)
        Response.Redirect("CustEventReport.aspx")
    End Sub
    Public Sub UpdateEvent(ByVal fv As FormView)
        Dim CustomerID As Long = 0
        Dim lsb As ListBox = CType(fv.FindControl("LBCustomers"), ListBox)
        If Not lsb.SelectedValue Is Nothing Then
            CustomerID = CType(lsb.SelectedValue, Long)
        End If

        Dim iCustEventID As Integer = Session("CustEventID")

        lsb = CType(fv.FindControl("LSBEventType"), ListBox)
        Dim EventTypeID As Integer = CType(lsb.SelectedValue, Integer)

        Dim CustEventRegDate As DateTime = Now()

        Dim cal As Calendar = CType(fv.FindControl("CalEvent"), Calendar)
        Dim CustEventDate As DateTime
        CustEventDate = cal.SelectedDate

        Dim tb As TextBox = CType(fv.FindControl("TBEventComment"), TextBox)
        Dim CustEventComment As String = tb.Text

        Err.Clear()
        On Error Resume Next
        Dim s As String = Session("FrameID")
        If Err.Number <> 0 Or s Is Nothing Then
            Err.Clear()
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select CustFrameID From CustEventList Where CustEventID=" & iCustEventID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            s = dr.Item("CustFrameID")
            dbConnection.Close()
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
        UpdEvent(CustomerID, iCustEventID, EventTypeID, CustEventRegDate, CustEventDate, CustEventComment, CustFrameID, CFramemanager, CUserID, EventUpdateTypeID)
    End Sub
    Protected Sub UpdEvent(ByVal CustomerID As Long, ByVal iCustEventID As Integer, ByVal EventTypeId As Integer, ByVal CustEventRegDate As DateTime, _
    ByVal CustEventDate As DateTime, ByVal CustEventComment As String, ByVal CustFrameID As Integer, ByVal CFrameManager As String, _
    ByVal UserID As String, ByVal EventUpdateTypeID As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Cust_UpdEvent", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.AddWithValue("CustomerID", CustomerID)
        ConComp.Parameters.AddWithValue("CustEventID", iCustEventID)
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
        If Len(s) > i - 3 Then
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
        If Len(s) > 0 Then
            Session("Hist") = Replace(Mid(Trim(Page.ToString), 5), "_", ".")
            Response.Redirect(s)
        Else
            Session("Hist") = vbNullString
        End If
    End Sub

    Protected Sub DSCustomers_Deleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs)
        Dim ds As SqlDataSource = CType(sender, SqlDataSource)
        'If MsgBox("האם אתה בטוח שברצונך למחוק את רשומת הלקוח?", MsgBoxStyle.YesNo) = MsgBoxResult.No Then
        '    ds.DeleteParameters(0).DefaultValue = ""
        'End If
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
        'Dim cal As Calendar = CType(sender, Calendar)
        'If IsPostBack = False Then
        '    cal.SelectedDate = Today
        '    cal.VisibleDate = Today
        'End If
    End Sub

    Protected Sub LBCustomers_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lstb As ListBox = CType(sender, ListBox)
        Dim s As String = Session("LastCustID")
        If Not Session("LastCustID") Is Nothing And lstb.SelectedValue = vbNullString Then
            lstb.SelectedValue = CType(Session("LastCustID"), Long)
            Session("Lastcustid") = Nothing
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

    Protected Sub BTNCANCEL_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("CustEventReport.aspx")
    End Sub
End Class
