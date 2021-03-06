Imports System.Data.SqlClient
Imports System.DBNull
Imports eid
Imports PageErrors
Imports System.IO

Partial Class ExEvent
    Inherits System.Web.UI.Page
    Public bPrint As Boolean = False
    Public bAuto As Boolean
    Private Const SCRIPT_DOFOCUS As String = "window.setTimeout('DoFocus()', 1);" & vbCr & vbLf & "            function DoFocus()" & vbCr & vbLf & "            {" & vbCr & vbLf & "                try {" & vbCr & vbLf & "                    document.getElementById('REQUEST_LASTFOCUS').focus();" & vbCr & vbLf & "                } catch (ex) {}" & vbCr & vbLf & "            }"

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'sets onfocus event to all apropriate controls on the page.
         'Page.ClientScript.RegisterStartupScript(GetType(ExEvent), "ScriptDoFocus", SCRIPT_DOFOCUS.Replace("REQUEST_LASTFOCUS", Request("__LASTFOCUS")), True)
        'Page.ClientScript.RegisterStartupScript(Page.[GetType](), "ScriptDoFocus", SCRIPT_DOFOCUS.Replace("REQUEST_LASTFOCUS", Request("__LASTFOCUS")), True)

        If Not IsPostBack Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim s_P As String = vbNullString
            On Error Resume Next
            Dim i As Integer = CType(Session("FrameID"), Integer)
            Dim fv As FormView = FormView1
            If Request.QueryString("ID") Is Nothing Then
                FormView1.DefaultMode = FormViewMode.Insert
            Else
                i = Request.QueryString("ID")
                bPrint = Not Request.QueryString("P") Is Nothing
                Dim ConComp0 As New SqlCommand("Select ExEventStatusID From ExEventList Where ExEventID=" & i, dbConnection)
                ConComp0.CommandType = Data.CommandType.Text
                dbConnection.Open()
                Dim dr0 As SqlDataReader = ConComp0.ExecuteReader()
                dr0.Read()
                i = dr0.Item("ExEventStatusID")
                If i = 1 And Not bPrint Then
                    FormView1.DefaultMode = FormViewMode.Edit
                Else
                    FormView1.DefaultMode = FormViewMode.ReadOnly
                End If
                dbConnection.Close()
                Exit Sub
            End If
            Dim ConComp As New SqlCommand("Select FrameName,FrameManager From FrameList Where FrameID=" & i, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            Dim lb As Label = CType(fv.FindControl("LBFRAME"), Label)
            lb.Text = dr.Item("FrameName")
            lb = CType(fv.FindControl("CUSTFramemanager"), Label)
            lb.Text = dr.Item("FrameManager")
            lb = CType(fv.FindControl("CUSTFrameID"), Label)
            lb.Text = i

            lb = CType(fv.FindControl("CUSTEVENTREGDATE"), Label)
            lb.Text = CType(Now(), String)
            dr.Close()

            Dim l As Long = CType(Session("lastcustID"), Long)

            If l > 0 Then
                Dim ConComp1 As New SqlCommand("Select CustFirstName,CustLastName,CustBirthDate From CustomerList Where CustomerID=" & l, dbConnection)
                dr = ConComp1.ExecuteReader()
                dr.Read()
                lb = CType(fv.FindControl("LBCUSTOMER"), Label)
                Dim s As String = dr.Item("CustFirstName") & " " & dr.Item("CustLastName")
                lb.Text = s
                Dim tb As TextBox = CType(fv.FindControl("TBEXEVENTHEADER"), TextBox)
                tb.Text = s
                s_P = s_P & "'" & Replace(s, "'", "''") & "'"
                lb = CType(fv.FindControl("LBCustomerID"), Label)
                lb.Text = l
                lb = CType(fv.FindControl("LBBDATE"), Label)
                lb.Text = dr.Item("CustBirthDate")
                lb = CType(fv.FindControl("LBAGE"), Label)
                i = DatePart(DateInterval.Year, dr.Item("CustBirthDate"))
                lb.Text = DatePart(DateInterval.Year, Now()) - i
                dbConnection.Close()
            End If
            Err.Clear()

            Dim sqlx As New SqlCommand("Select top 1 * From ExEventList_P Where ISNULL(RestoreDone,1) = 1 And EXEventCustID=" & Session("LastCustID") & "ORDER BY ExEventID_P DESC", dbConnection)
            dbConnection.Open()
            Dim drx As SqlDataReader = sqlx.ExecuteReader
            If drx.Read Then
                divrstr.Visible = True
                For i = 0 To drx.FieldCount - 1
                    Dim s As String = drx.GetName(i)
                    resttb(drx, s)
                Next
                Dim iExIDP As Integer = drx("ExEventID_P")
                drx.Close()
                Dim sqlC As New SqlCommand("Update EXEventList_P set RestoreDone=1 Where EXEventID_P=" & iExIDP, dbConnection)
                sqlC.CommandType = Data.CommandType.Text
                sqlC.ExecuteNonQuery()
                dbConnection.Close()
            Else
                drx.Close()
                dbConnection.Close()
                Dim sqlp As New SqlCommand("Insert into ExEventList_P(ExEventCustID,ExEventHeader,CustFrameID,LogDate)VAlues(" & Session("LastCustID") & "," & s_P & "," & If(IsNumeric(Session("FrameID")), Session("FrameID"), "NULL") & ",'" & Format(Now(), "yyyy-MM-dd HH:mm:ss") & "')", dbConnection)
                sqlp.CommandType = Data.CommandType.Text
                dbConnection.Open()
                sqlp.ExecuteNonQuery()
                dbConnection.Close()

            End If
        End If


        'Session.Timeout = 120

    End Sub
    Sub resttb(ByVal drx As SqlDataReader, ByVal sF As String)
        Dim tb As TextBox = CType(FormView1.FindControl("TB" & sF), TextBox)
        If tb IsNot Nothing Then
            tb.Text = drx(sF)
        End If
    End Sub


    Protected Sub DDLEVENTSUBTYPE_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim fv As FormView = FormView1
        'Dim ddl As DropDownList = CType(fv.FindControl("DDLEVENTSUBTYPE"), DropDownList)
        'Dim i As Integer = ddl.SelectedValue
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        ''        Dim ConComp As New SqlCommand("Select EventType From vExEventType Where EventSubTypeID=" & i, dbConnection)
        'dbConnection.Open()
        'Dim dr As SqlDataReader = ConComp.ExecuteReader()
        'dr.Read()
        'Dim lb As Label = CType(fv.FindControl("LBEVENTTYPE"), Label)
        'lb.Text = dr.Item("Eventtype")
        'dbConnection.Close()
    End Sub
    Protected Sub FormView1_ItemInserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewInsertEventArgs) Handles FormView1.ItemInserting
        Dim fv As FormView = CType(sender, FormView)
        Dim cbl As CheckBoxList = CType(fv.FindControl("cbreportedto"), CheckBoxList)
        Dim iCount As Integer = cbl.Items.Count
        Dim i As Integer
        Dim s As String = vbNullString
        For i = 0 To iCount - 1
            If cbl.Items(i).Selected Then
                s = s & "," & i
            End If
        Next
        e.Values("ExEventReportedTo") = Mid(s, 2)

        Dim s1 As String
        Dim cal As Calendar = CType(fv.FindControl("CALEVENTDATE"), Calendar)
        s = CType(cal.SelectedDate, String)
        Dim ddl As DropDownList = CType(fv.FindControl("DDLHOUR"), DropDownList)
        s1 = CType(ddl.SelectedValue, DateTime)
        e.Values("ExEventDate") = CDate(s & " " & s1)

        cal = CType(fv.FindControl("CALCOLSINGDATE"), Calendar)
        s = cal.SelectedDate
        If cal.SelectedDate = "00:00:00" Then
            e.Values("ExEventClosingDate") = vbNullString
        End If
    End Sub
    Protected Sub DSEXEvents_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSEXEvents.Inserted
        If Err.Number <> 0 Then scrMsg(Err.Description, True)
        Response.Redirect("CustEventReport.Aspx")
    End Sub

    Protected Sub DSEXEvents_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEXEvents.Inserting
        Dim i As Integer
        For i = 0 To e.Command.Parameters.Count - 1
            Dim s As String = e.Command.Parameters(i).ToString
            Dim sv As String = e.Command.Parameters(i).Value
        Next
    End Sub

    Protected Sub LNKBINSERT_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        insertExEvent()
        'Dim i As Integer
        'Dim fv As FormView = CType(lnkb.NamingContainer, FormView)
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Dim conComp As New SqlCommand("p0p_INSEXEVENT", dbConnection)
        'conComp.CommandType = Data.CommandType.StoredProcedure
        'conComp.Parameters.Clear()

        'Dim ddl As DropDownList = CType(fv.FindControl("DDLSTATUS"), DropDownList)
        'i = ddl.SelectedValue
        'conComp.Parameters.AddWithValue("@ExEventStatusID", i)


        'If i = 3 Then
        '    conComp.Parameters.AddWithValue("@EXEVENTCLOSINGDate", Now())
        '    i = Request.QueryString("ID")
        '    conComp.Parameters.AddWithValue("@CustRelateID", i)
        'End If

        'If fv.DefaultMode <> FormViewMode.ReadOnly Then

        '    Dim lbl As Label = CType(fv.FindControl("LBCustomerID"), Label)
        '    Dim l As Int64 = lbl.Text
        '    conComp.Parameters.AddWithValue("@CUSTOMERID", l)
        '    Dim hdn As HiddenField
        '    If fv.DefaultMode = FormViewMode.Insert Then
        '        i = Session("CUSTEVENTTYPEID")
        '    Else
        '        hdn = CType(fv.FindControl("HDNEVENTTYPEID"), HiddenField)
        '        i = hdn.Value
        '    End If
        '    conComp.Parameters.AddWithValue("@CUSTEVENTTYPEID", i)

        '    lbl = CType(fv.FindControl("CustEventRegDate"), Label)
        '    Dim d As DateTime = lbl.Text
        '    conComp.Parameters.AddWithValue("@CustEventRegDate", d)

        '    Dim s1 As String
        '    Dim cal As Calendar = CType(fv.FindControl("CALEVENTDATE"), Calendar)
        '    d = CType(cal.SelectedDate, DateTime)
        '    ddl = CType(fv.FindControl("DDLHOUR"), DropDownList)
        '    s1 = CType(ddl.SelectedValue, DateTime)
        '    d = CDate(Format(d, "yyyy-MM-dd ") & s1)
        '    conComp.Parameters.AddWithValue("@CustEventDate", d)

        '    Dim tb As TextBox = CType(fv.FindControl("TBEXEVENTHEADER"), TextBox)
        '    conComp.Parameters.AddWithValue("@CustEventComment", tb.Text)

        '    conComp.Parameters.AddWithValue("@EXEVENTHEADER", tb.Text)

        '    If fv.DefaultMode = FormViewMode.Edit Then
        '        hdn = CType(fv.FindControl("HDNFRAMEID"), HiddenField)
        '        i = hdn.Value
        '    Else
        '        i = Session("FrameID")
        '    End If
        '    conComp.Parameters.AddWithValue("@CustFrameID", i)

        '    lbl = CType(fv.FindControl("CUSTFRAMEMANAGER"), Label)
        '    conComp.Parameters.AddWithValue("@CFRAMEMANAGER", lbl.Text)


        '    i = Session("UserID")
        '    conComp.Parameters.AddWithValue("@UserID", i)

        '    ddl = CType(fv.FindControl("DDLLOCATION"), DropDownList)
        '    i = ddl.SelectedValue
        '    conComp.Parameters.AddWithValue("@ExEventLocationID", i)

        '    ddl = CType(fv.FindControl("DDLEVENTSUBTYPE"), DropDownList)
        '    i = ddl.SelectedValue
        '    conComp.Parameters.AddWithValue("@ExEventTypeID", i)

        '    ddl = CType(fv.FindControl("DDLSEVERITY"), DropDownList)
        '    i = ddl.SelectedValue
        '    conComp.Parameters.AddWithValue("@ExEventSEVERITYID", i)

        '    tb = CType(fv.FindControl("TBExEventLocationDescrption"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventLocationDescrption", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventReporterJob"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventReporterJob", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventBodyInjury"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventBodyInjury", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventpropertyDamages"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventpropertyDamages", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventStory"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventStory", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventimmediateActions"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventimmediateActions", tb.Text)

        '    tb = CType(fv.FindControl("TBExEventRequiredActions"), TextBox)
        '    conComp.Parameters.AddWithValue("@ExEventRequiredActions", tb.Text)

        '    'ExEVENTWHYNOTCLOSED = NULL

        '    Dim cbl As CheckBoxList = CType(fv.FindControl("cbreportedto"), CheckBoxList)
        '    Dim iCount As Integer = cbl.Items.Count
        '    Dim s As String = vbNullString
        '    For i = 1 To iCount
        '        If cbl.Items(i - 1).Selected Then
        '            s = s & i & ","
        '        End If
        '    Next
        '    conComp.Parameters.AddWithValue("@ExEventReportedTo", s)
        '    If fv.DefaultMode = FormViewMode.Edit Then
        '        i = Request.QueryString("ID")
        '        conComp.Parameters.AddWithValue("@CustRelateID", i)
        '        conComp.Parameters.AddWithValue("@ActType", 1)
        '        hdn = CType(fv.FindControl("HDNCUSTEVENTID"), HiddenField)
        '        i = hdn.Value
        '        conComp.Parameters.AddWithValue("@CUSTEVENTID", i)

        '    End If
        'Else
        '    conComp.Parameters.AddWithValue("@ActType", 2)
        'End If

        'dbConnection.Open()
        'conComp.ExecuteNonQuery()
        'dbConnection.Close()

        'Response.Redirect("custeventreport.aspx")

    End Sub
    Protected Sub DDLSTATUS_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim fv As FormView = CType(ddl.NamingContainer, FormView)
        Dim hdn As HiddenField = CType(fv.FindControl("HDNCLOSINGDate"), HiddenField)

        'Dim ddl As DropDownList = CType(fv.FindControl("DDLEVENTSUBTYPE"), DropDownList)
        'Dim i As Integer = ddl.SelectedValue
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        ''        Dim ConComp As New SqlCommand("Select EventType From vExEventType Where EventSubTypeID=" & i, dbConnection)
        'dbConnection.Open()
        'Dim dr As SqlDataReader = ConComp.ExecuteReader()
        'dr.Read()
        'Dim lb As Label = CType(fv.FindControl("LBEVENTTYPE"), Label)
        'lb.Text = dr.Item("Eventtype")
        'dbConnection.Close()
    End Sub
    Protected Sub CalEvent_Load(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub LBAGE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim fv As FormView = CType(lbl.NamingContainer, FormView)
        Dim lbl1 As Label = CType(fv.FindControl("LBBDate"), Label)
        Dim i As Integer = DatePart(DateInterval.Year, CDate(lbl1.Text))
        lbl.Text = DatePart(DateInterval.Year, Now()) - i

    End Sub

    Protected Sub CALEVENTDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cal As Calendar = CType(sender, Calendar)
        Dim fv As FormView = CType(cal.NamingContainer, FormView)
        If fv.DefaultMode = FormViewMode.Insert Then
            If IsPostBack = False Then
                cal.SelectedDate = Today
                cal.VisibleDate = Today
            End If
        End If
    End Sub

    Protected Sub DDLHOUR_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        '        Dim s As String = Eval("CustEventDate", "HH:mm")
    End Sub
    Function ttm(ByVal fn As String) As String
        Dim s As String = Format(CDate(Eval("custeventdate")), "HH:mm")
        Dim i As Integer = CInt(Right(s, 2))
        i = CInt((i + 7) / 15) * 15
        Return Left(s, 3) + Format(i, "00")
    End Function

    Protected Sub CBReportedTo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub CBReportedTo_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cbl As CheckBoxList = CType(sender, CheckBoxList)
        Dim i As Integer = Request.QueryString("ID")
        If i <> 0 Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select RepID From ExEventRowsReported Where ExEventID=" & i, dbConnection)
            ConComp.CommandType = Data.CommandType.Text
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            While dr.Read()
                cbl.Items(dr("RepID") - 1).Selected = True
            End While
            dbConnection.Close()
        End If

    End Sub
    Protected Sub lblReported_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim i As Integer = Request.QueryString("ID")
        If i <> 0 Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select Reported From ExEventRowsReported e LEFT OUTER JOIN ExEventReportedTo r ON e.RepID = r.RepID Where ExEventID=" & i, dbConnection)
            ConComp.CommandType = Data.CommandType.Text
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            Dim s As String = vbNullString
            While dr.Read()
                s &= dr("Reported") & ", "
            End While
            If Len(s) > 0 Then lbl.Text = Left(s, Len(s) - 2)
            dbConnection.Close()
        End If

    End Sub


    Protected Sub CALEVENTDATE_PreRender1(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    'Protected Sub TB_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Dim tb As TextBox = CType(sender, TextBox)
    '    Dim sID As String = tb.ID

    '    Session("EX_" & sID) = tb.Text
    '    Dim fv As FormView = CType(tb.NamingContainer, FormView)
    '    Dim lnkb As LinkButton = CType(fv.FindControl("LNKBINSERT"), LinkButton)
    '    lnkb.Focus()

    '    '       If Not Request.Cookies("EX_" & sID) Is Nothing Then
    '    '       tb.Text = Request.Cookies("EX_" & sID).Value
    '    '       End If
    '    ' End If

    '    '      insertExEvent(1)
    '    UpdateP(tb)
    'End Sub

    Protected Sub TB_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim tb As TextBox = CType(sender, TextBox)
        'Dim sID As String = tb.ID
        'If tb.Text = vbNullString Then
        '    If Not Session("EX_" & sID) Is Nothing Then
        '        Dim s As String = Session("EX_" & sID)
        '        tb.Text = s
        '    End If
        'End If
    End Sub
    Private Sub insertExEvent(Optional ByVal iP As Integer = 0)
        Dim fv As FormView = CType(FormView1, FormView)
        Dim i As Integer
        Dim hdn As HiddenField
        Dim ddl As DropDownList
        Dim tb As TextBox
        Dim s As String
        Dim s1 As String
        If bAuto Then Exit Sub
        bAuto = True
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim conComp As New SqlCommand("p0p_INSEXEVENT", dbConnection)
        conComp.CommandType = Data.CommandType.StoredProcedure
        conComp.Parameters.Clear()
        Dim bReadOnly As Boolean = fv.DefaultMode = FormViewMode.ReadOnly           'Readonly or other status

        Dim NCustRelateID As New SqlParameter("@NCustRelateID", Data.SqlDbType.Int)
        NCustRelateID.Direction = Data.ParameterDirection.Output
        conComp.Parameters.Add(NCustRelateID)

        ddl = CType(fv.FindControl("DDLSTATUS"), DropDownList)  'Target Status
        Dim iStatus As Integer = ddl.SelectedValue
        conComp.Parameters.AddWithValue("@ExEventStatusID", iStatus)

        ' details of cust event

        Dim lbl As Label = CType(fv.FindControl("LBCustomerID"), Label)             'CustomerID
        Dim l As Int64
        If IsNumeric(lbl.Text) Then l = lbl.Text
        conComp.Parameters.AddWithValue("@CUSTOMERID", l) '

        If bReadOnly Then                                                           'Cust Event type id
            hdn = CType(fv.FindControl("HDNEVENTTYPEID"), HiddenField)
            i = hdn.Value
        Else
            If Session("CUSTEVENTTYPEID") Is Nothing Then
                hdn = CType(fv.FindControl("HDNEVENTTYPEID"), HiddenField)
                i = hdn.Value
            Else
                i = Session("CUSTEVENTTYPEID")
            End If
        End If
        conComp.Parameters.AddWithValue("@CUSTEVENTTYPEID", 49)  ' Eventtypeid of exevent

        lbl = CType(fv.FindControl("CustEventRegDate"), Label)                      'Event Reg date
        Dim d As DateTime = lbl.Text
        conComp.Parameters.AddWithValue("@CustEventRegDate", d)


        If bReadOnly Then                                                           'Cust Event Date
            lbl = CType(fv.FindControl("LBLEXDATE"), Label)
            On Error Resume Next
            d = CDate(lbl.Text)
            If Err.Number <> 0 Then
                Dim sBody As String = "UserID = " & Session("UserID") & "<br/>"
                sBody = sBody & "Current Date Value = '" & lbl.Text & "'<br/>"
                lbl = CType(fv.FindControl("LBCustomerID"), Label)              'CustomerID
                sBody = sBody & "CustomerID = " & lbl.Text & "<br />"
                sBody = sBody & "ExEventID = " & Request.QueryString("ID") & "<br />"
                hdn = CType(fv.FindControl("HDNCUSTEVENTID"), HiddenField)
                sBody = sBody & "CustEventID = " & hdn.Value & "<br/>"
                lbl = CType(fv.FindControl("CustEventRegDate"), Label)                      'Event Reg date
                sBody = sBody & "EventRegDate = " & lbl.Text & "<br />"
                sBody = sBody & "ErrorMessage = " & Err.Description & "<br />"
                SendErrMail("��� ����� ����� ����", sBody)
                Response.Redirect("ge.aspx")
            End If
        Else
            Dim cal As Calendar = CType(fv.FindControl("CALEVENTDATE"), Calendar)
            s = CType(cal.SelectedDate, String)
            ddl = CType(fv.FindControl("DDLHOUR"), DropDownList)
            s1 = CType(ddl.SelectedValue, DateTime)
            d = CDate(s & " " & s1)
        End If
        conComp.Parameters.AddWithValue("@CUSTEVENTdate", d)


        If fv.DefaultMode = FormViewMode.Edit Then                                  'Cust Frame ID
            hdn = CType(fv.FindControl("HDNFRAMEID"), HiddenField)
            i = hdn.Value
        Else
            i = Session("FrameID")
        End If
        conComp.Parameters.AddWithValue("@CustFrameID", i)

        lbl = CType(fv.FindControl("CUSTFRAMEMANAGER"), Label)                      'Cust Frame Manager
        conComp.Parameters.AddWithValue("@CFRAMEMANAGER", lbl.Text)

        i = Session("UserID")                                                       'user ID
        conComp.Parameters.AddWithValue("@UserID", i)


        ' Ex Event Fields

        If bReadOnly Then

            lbl = CType(fv.FindControl("LBLHDR"), Label)                             'EX Header
            conComp.Parameters.AddWithValue("@EXEVENTHEADER", lbl.Text)

            hdn = CType(fv.FindControl("HDNLOCATIONID"), HiddenField)                'Ex EventLocation ID
            conComp.Parameters.AddWithValue("@ExEventLocationID", hdn.Value)

            hdn = CType(fv.FindControl("HDNEVENTTYPE"), HiddenField)                 'Ex EventTYPE ID
            conComp.Parameters.AddWithValue("@ExEventTypeID", hdn.Value)

            hdn = CType(fv.FindControl("HDNSEVERITYID"), HiddenField)                'Ex Event SEVERITY ID
            conComp.Parameters.AddWithValue("@ExEventSeverityID", hdn.Value)

            lbl = CType(fv.FindControl("LBLLOCDESC"), Label)                          'EX Location Description
            conComp.Parameters.AddWithValue("@ExEventLocationDescrption", lbl.Text)

            lbl = CType(fv.FindControl("LBLFIRST"), Label)                            'EX Reporter Job
            conComp.Parameters.AddWithValue("@ExEventReporterJob", lbl.Text)

            lbl = CType(fv.FindControl("LBLBODYINJURY"), Label)                       'EX Body injury
            conComp.Parameters.AddWithValue("@ExEventBodyInjury", lbl.Text)

            lbl = CType(fv.FindControl("LBLPROPERTYDAMAGE"), Label)                   'EX property damage
            conComp.Parameters.AddWithValue("@ExEventpropertyDamages", lbl.Text)

            lbl = CType(fv.FindControl("LBLSTORY"), Label)                            'EX story
            conComp.Parameters.AddWithValue("@ExEventStory", lbl.Text)

            lbl = CType(fv.FindControl("LBLIMMEDIAT"), Label)                         'EX Immediate actions
            conComp.Parameters.AddWithValue("@ExEventimmediateActions", lbl.Text)

            lbl = CType(fv.FindControl("LBLREQUIRED"), Label)                         'EX required actions
            conComp.Parameters.AddWithValue("@ExEventRequiredActions", lbl.Text)

            tb = CType(fv.FindControl("TBWNC"), TextBox)                  'EX required actions
            conComp.Parameters.AddWithValue("@ExEventWhyNotClosed", tb.Text)

        Else

            tb = CType(fv.FindControl("TBEXEVENTHEADER"), TextBox)                    'EX Header
            conComp.Parameters.AddWithValue("@EXEVENTHEADER", tb.Text)

            ddl = CType(fv.FindControl("DDLLOCATION"), DropDownList)                  'Ex EventLocation ID
            conComp.Parameters.AddWithValue("@ExEventLocationID", ddl.SelectedValue)

            ddl = CType(fv.FindControl("DDLEVENTSUBTYPE"), DropDownList)              'Ex EventTYPE ID
            conComp.Parameters.AddWithValue("@ExEventTypeID", ddl.SelectedValue)

            ddl = CType(fv.FindControl("DDLSEVERITY"), DropDownList)                  'Ex Event SEVERITY ID
            conComp.Parameters.AddWithValue("@ExEventSeverityID", ddl.SelectedValue)

            tb = CType(fv.FindControl("TBExEventLocationDescrption"), TextBox)                     'EX Location Description
            conComp.Parameters.AddWithValue("@ExEventLocationDescrption", tb.Text)

            tb = CType(fv.FindControl("TBExEventReporterJob"), TextBox)                      'EX Reporter Job
            conComp.Parameters.AddWithValue("@ExEventReporterJob", tb.Text)

            tb = CType(fv.FindControl("TBExEventBodyInjury"), TextBox)                       'EX Body injury
            conComp.Parameters.AddWithValue("@ExEventBodyInjury", tb.Text)

            tb = CType(fv.FindControl("TBExEventpropertyDamages"), TextBox)                  'EX property damage
            conComp.Parameters.AddWithValue("@ExEventpropertyDamages", tb.Text)

            tb = CType(fv.FindControl("TBExEventStory"), TextBox)                            'EX story
            conComp.Parameters.AddWithValue("@ExEventStory", tb.Text)

            tb = CType(fv.FindControl("TBExEventimmediateActions"), TextBox)                 'EX Immediate actions
            conComp.Parameters.AddWithValue("@ExEventimmediateActions", tb.Text)

            tb = CType(fv.FindControl("TBExEventRequiredActions"), TextBox)                  'EX required actions
            conComp.Parameters.AddWithValue("@ExEventRequiredActions", tb.Text)

        End If

        Dim cbl As CheckBoxList = CType(fv.FindControl("cbreportedto"), CheckBoxList) 'Ex Reported to
        Dim iCount As Integer = cbl.Items.Count
        s = vbNullString
        For i = 1 To iCount
            If cbl.Items(i - 1).Selected Then
                s = s & i & ","
            End If
        Next
        conComp.Parameters.AddWithValue("@ExEventReportedTo", s)

        If iStatus = 3 Then
            conComp.Parameters.AddWithValue("@EXEVENTCLOSINGDate", Now())             'Ex Closing date
        End If

        If fv.DefaultMode = FormViewMode.Edit Or bReadOnly Then
            i = Request.QueryString("ID")
            conComp.Parameters.AddWithValue("@CustRelateID", i)
            conComp.Parameters.AddWithValue("@ActType", 1)
            hdn = CType(fv.FindControl("HDNCUSTEVENTID"), HiddenField)
            conComp.Parameters.AddWithValue("@CUSTEVENTID", hdn.Value)
        End If


        dbConnection.Open()
        For i = 0 To conComp.Parameters.Count - 1
            Dim sa As String = conComp.Parameters(i).ToString
            Dim sp As String = conComp.Parameters(i).Value
        Next

        conComp.ExecuteNonQuery()
        On Error Resume Next
        Dim crID As Integer = Convert.ToInt32(NCustRelateID.Value)
        Err.Clear()
        dbConnection.Close()
        SessionCLR("EX_")
        If iP = 0 Then
            Response.Redirect("custeventreport.aspx")
        Else
            Response.Redirect("ExEvent.aspx?ID=" & crID & "&P=1")
        End If

    End Sub
    Sub SessionCLR(ByVal s1 As String)
        Dim i As Integer
        For i = 0 To Session.Contents.Count - 1
            Dim s As String = Session.Keys(i)
            If Left(s, Len(s1)) = s1 Then
                s = Session(i)
                Session(i) = vbNullString
            End If
        Next
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Not Request.QueryString("p") Is Nothing Then
            Page.MasterPageFile = "sherutNOMENU.master"
        End If
    End Sub

    Protected Sub PREPRINT_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles PREPRINT.Click
        If Request.QueryString("ID") Is Nothing Then
            insertExEvent(1)
        Else
            Dim i As Integer = Request.QueryString("ID")
            Response.Redirect("ExEvent.aspx?ID=" & i & "&P=1")
        End If
    End Sub

    Protected Sub PANELPRINT_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles PANELPRINT.PreRender
        Dim pnl As Panel = CType(sender, Panel)
        If bPrint Then pnl.Visible = True Else pnl.Visible = False
    End Sub

    Protected Sub PREPRINT_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles PREPRINT.PreRender
        Dim btn As Button = CType(sender, Button)
        If bPrint Then btn.Visible = False Else btn.Visible = True
    End Sub
    Public Function TruncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i + 25 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function
    Protected Sub TB_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        UpdateP(tb)
    End Sub
    Sub UpdateP(ByVal tb As TextBox)
        Dim s As String = Mid(tb.ID, 3)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlC As New SqlCommand("Update EXEventList_P set " & s & "='" & Replace(tb.Text, "'", "''") & "' Where RestoreDone IS NULL AND EXEventCustID=" & Session("lastcustID"), dbConnection)
        sqlC.CommandType = Data.CommandType.Text
        dbConnection.Open()
        sqlC.ExecuteNonQuery()
        dbConnection.Close()

    End Sub

    Protected Sub rblrst_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblrst.SelectedIndexChanged
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlC As New SqlCommand("Update EXEventList_P set RestoreDone=" & If(rbl.SelectedValue = "0", "0", "NULL") & " Where RestoreDone=1 AND EXEventCustID=" & Session("lastcustID"), dbConnection)
        sqlC.CommandType = Data.CommandType.Text
        dbConnection.Open()
        sqlC.ExecuteNonQuery()
        dbConnection.Close()
        If rbl.SelectedValue = "0" Then
            Response.Redirect("CustEventReport.Aspx")
        Else
            divrstr.Visible = False
        End If
    End Sub
    Sub HookOnFocus(ByRef CurrentControl As Control)
        If (TypeOf CurrentControl Is TextBox) OrElse (TypeOf CurrentControl Is DropDownList) OrElse (TypeOf CurrentControl Is CheckBoxList) OrElse (TypeOf CurrentControl Is LinkButton) Then
            'adds a script which saves active control on receiving focus in the hidden field __LASTFOCUS.
            TryCast(CurrentControl, WebControl).Attributes.Add("onfocus", "try{document.getElementById('__LASTFOCUS').value=this.id;} catch(e) {}")
        End If
        'checks if the control has children
        If CurrentControl.HasControls() Then
            'if yes do them all recursively
            For Each CurrentChildControl As Control In CurrentControl.Controls
                HookOnFocus(CurrentChildControl)
            Next
        End If

    End Sub

    Protected Sub FormView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.PreRender
        If Not IsPostBack Then
            HookOnFocus(TryCast(FormView1, Control))
        End If

        ''replaces REQUEST_LASTFOCUS in SCRIPT_DOFOCUS with the posted value from Request["__LASTFOCUS"]
        ''and registers the script to start after Update panel was rendered
        ScriptManager.RegisterStartupScript(Me, GetType(ExEvent), "ScriptDoFocus", SCRIPT_DOFOCUS.Replace("REQUEST_LASTFOCUS", Request("__LASTFOCUS")), True)

    End Sub
    Sub scrMsg(sMsg As String, bErr As Boolean)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:50%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
#Region "Printing"

    'Protected Sub btnprtForm_Click(sender As Object, e As System.EventArgs) Handles btnprtForm.Click
    '    'Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
    '    'Dim iSaveFormDisplayType As Integer = Session("FormDisplayType")
    '    'Session("FormDisplayType") = 0
    '    'lvAnswers.DataBind()
    '    'ListViewPrint(Page, lvAnswers, sHdr)
    '    'Session("FormDisplayType") = iSaveFormDisplayType
    '    'lvAnswers.DataBind()
    'End Sub

    'Protected Sub btnprWP_Click(sender As Object, e As System.EventArgs) Handles btnprWP.Click
    '    '      Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
    '    '       lvWorkPlan.InsertItemPosition = InsertItemPosition.None
    '    '      lvWorkPlan.DataBind()
    '    '    For Each lvi In lvWorkPlan.Items
    '    '       Dim btn As Button = CType(lvi.FindControl("btnEdit"), Button)
    '    '      If btn IsNot Nothing Then btn.Visible = False
    '    '      btn = CType(lvi.FindControl("btnDel"), Button)
    '    '      If btn IsNot Nothing Then btn.Visible = False
    '    '      Next
    '    '  ListViewPrint(Page, lvWorkPlan, sHdr)
    'End Sub

    'Protected Sub btnprWWP_Click(sender As Object, e As System.EventArgs) Handles btnprWWP.Click
    '    '   Dim sHdr As String = CType(lvHdr.Items(0).FindControl("hdnFormHeader"), HiddenField).Value
    '    '   ListViewPrint(Page, LVWeeklyPlan, sHdr.Replace("������", "������"))
    'End Sub

    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        'Verifies that the control is rendered 
    End Sub

    Sub ListViewPrint(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        LV1.Attributes("style") = "border-collapse:separate;direction:rtl;"
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        'lvHdr.RenderControl(hw)
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
                        "<td style='vertical-align:top; width:8%; text-align:right;'>�����:" & _
                        "<br />�����:" & _
                        "</td>" & _
                        "<td style='vertical-align:top; width:8%; text-align:right;'>" & _
                        Format(Today, "dd/MM/yy") & "<br/>" & _
                        HttpContext.Current.Session("UserName") & _
                        "</td></tr></table><br /><br />"
        Return s
    End Function

    Protected Sub btnWord_Click(sender As Object, e As System.EventArgs) Handles btnWord.Click


        ToWord(Page, Nothing, "����� �� ���� ����")


    End Sub

    Private Sub ToWord(pg As Page, LV1 As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        Dim lbl As Label = CType(FormView1.FindControl("Label11"), Label)
        If lbl Is Nothing Then
            scrMsg("�� ���� ������ ����� ���� ��", False)
            Exit Sub
        End If
        Dim strReportName As String = lbl.Text
        strReportName = Left(strReportName, InStr(strReportName, " ") - 1)
        lbl = CType(FormView1.FindControl("LBLHDR"), Label)
        strReportName = lbl.Text.Replace(" ", "_") & "_" & strReportName
        strReportName = "����_����_" & strReportName & ".doc"
        strReportName = strReportName.Replace("/", "").Replace("\", "").Replace("%", "")
        strReportName = Server.UrlEncode(strReportName)

        Dim tr As HtmlTableRow = CType(FormView1.FindControl("tdlast"), HtmlTableRow)
        tr.Visible = False
        Dim cbl As CheckBoxList = CType(FormView1.FindControl("CBReportedTo"), CheckBoxList)
        If cbl IsNot Nothing Then cbl.Visible = False
        Dim ddl As DropDownList = CType(FormView1.FindControl("DDLSTATUS"), DropDownList)
        Dim td As HtmlTableCell
        If ddl IsNot Nothing Then
            If ddl.SelectedValue = "2" Then
                ddl.Visible = False
                td = CType(FormView1.FindControl("tdststus"), HtmlTableCell)
                td.InnerText = "����"
            End If
        End If
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        Dim sb As New StringBuilder()

        Dim style As String = "<style type = 'text/css'>table {border:1px dotted white;} th {border:1px dotted Gray;font-family:Arial;} thead {display:table-header-group;} td {display:table-cell;font-size:x-small;direction:rtl;text-align:right;border:1px dotted #999999;font-family:Arial;} </style>"
        sb.Append("<html><meta charset='utf-8'/>")
        sb.Append("<header>" & style & "</header>")
        sb.Append("<body style='direction:rtl;font-family:Arial;>")


        ' First page title

        hw.InnerWriter.Write("<div style='text-align:right;width: 550px;'><span style='font-size:large;font-weight:bold;'>" & sTitle & "</span></div>")
        FormView1.Attributes("style") = "width:530px;"
        FormView1.RenderControl(hw)
        tr.Visible = True
        If ddl IsNot Nothing Then ddl.Visible = True
        If cbl IsNot Nothing Then cbl.Visible = True
        If td IsNot Nothing Then td.InnerText = Nothing
        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")


        sb.Append("<div style='font-family:Arial;width:540px;'>" & gridHTML & "</div>")
        sb.Append("</div></body></html>")

        Response.ContentType = "application/msword"
        Response.AddHeader("Content-Disposition", "attachment; filename=" & strReportName)
        Response.Charset = ""
        Response.Write(sb.ToString())
        Response.End()

    End Sub

#End Region

    Protected Sub btnWord_PreRender(sender As Object, e As System.EventArgs) Handles btnWord.PreRender
        Dim btn As ImageButton = CType(sender, ImageButton)
        btn.Visible = FormView1.DefaultMode = FormViewMode.ReadOnly
    End Sub
End Class



