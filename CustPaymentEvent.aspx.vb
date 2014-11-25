Imports System.Data.SqlClient

Partial Class CustPaymentEvent
    Inherits System.Web.UI.Page
    Dim bisVal(0 To 11) As Integer
    'Public Function truncField(ByVal sfn As String, ByVal i As Integer) As String
    '    Dim s As String = Eval(sfn) & ""
    '    If Len(s) > i - 3 Then
    '        Return (Left(s, i - 3) & "...")
    '    Else
    '        Return (s)
    '    End If
    'End Function
    'Protected Sub CBPAID_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    'End Sub
    'Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    'End Sub 
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim cidN As Int64
        'Dim fidN As Int16
        'Dim didN As DateTime
        'Dim gv As GridView = CType(GVList, GridView)
        'Dim gvr As GridViewRow
        'Dim chb As CheckBox
        'Dim lbl As Label
        'For Each gvr In gv.Rows
        '    chb = CType(gvr.FindControl("CBPAID"), CheckBox)
        '    If Not chb Is Nothing Then
        '        lbl = CType(gvr.FindControl("LBLAYMENTNO"), Label)
        '        If chb.Checked And Not IsNumeric(lbl.Text) Then
        '            lbl = CType(gvr.FindControl("LBLCUSTID"), Label)
        '            cidN = lbl.Text
        '            Dim hdn As HiddenField = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
        '            fidN = hdn.Value
        '            lbl = CType(gvr.FindControl("LBLDATE"), Label)
        '            didN = CDate(lbl.Text)
        '            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '            Dim ConComp As New SqlCommand("Cust_AddEvent", dbConnection)
        '            ConComp.CommandType = Data.CommandType.StoredProcedure
        '            ConComp.Parameters.AddWithValue("CustomerID", cidN)
        '            hdn = CType(gvr.FindControl("HDNEVENTTYPE"), HiddenField)
        '            ConComp.Parameters.AddWithValue("CustEventTypeID", hdn.Value)
        '            ConComp.Parameters.AddWithValue("CustEventRegDate", Now())
        '            ConComp.Parameters.AddWithValue("CustEventDate", didN)
        '            lbl = CType(gvr.FindControl("LBLCOMMENT"), Label)
        '            ConComp.Parameters.AddWithValue("CustEventComment", lbl.Text)
        '            ConComp.Parameters.AddWithValue("CustFrameID", fidN)
        '            hdn = CType(gvr.FindControl("HDNMANAGER"), HiddenField)
        '            ConComp.Parameters.AddWithValue("CFrameManager", hdn.Value)
        '            ConComp.Parameters.AddWithValue("UserID", Session("UserID"))
        '            hdn = CType(gvr.FindControl("HDNUPDATE"), HiddenField)
        '            ConComp.Parameters.AddWithValue("CustEventUpdateTypeID", hdn.Value)

        '            dbConnection.Open()
        '            ConComp.ExecuteNonQuery()
        '            dbConnection.Close()
        '            GVList.DataBind()
        '        Else
        '            lbl = CType(gvr.FindControl("LBLPAYMENTNO"), Label)
        '            If Not chb.Checked And IsNumeric(lbl.Text) Then
        '                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '                Dim ConComp As New SqlCommand("Delete From CustEventList Where CustEventID=" & lbl.Text, dbConnection)
        '                dbConnection.Open()
        '                ConComp.ExecuteNonQuery()
        '                dbConnection.Close()
        '                GVList.DataBind()
        '            End If
        '        End If
        '    End If
        'Next
    End Sub
    Function hdrt(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        Return Format(DateAdd(DateInterval.Month, d - 1, dt), "MM")
    End Function

    Protected Sub GVList_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GVList.RowDataBound

    End Sub
    Function vald(ByVal d As Double, Optional ByVal bSum As Boolean = True) As Boolean
        Dim b As Boolean
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        On Error Resume Next
        Dim s As String = Format(DateAdd(DateInterval.Month, d - 1, dt), "[yyyy-M]")
        b = Eval(s)
        If Err.Number <> 0 Then
            b = False
            Err.Clear()
        End If
        If b And bSum Then bisVal(Int(d) - 1) = bisVal(Int(d) - 1) + 1
        Return b

    End Function
    Function vali(ByVal d As Double) As Integer
        Dim i As Integer
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        On Error Resume Next
        Dim s As String = Format(DateAdd(DateInterval.Month, d - 1, dt), "[yyyy-M]")
        i = Eval(s)
        If Err.Number <> 0 Then
            i = False
            Err.Clear()
        End If
        Return i
    End Function
    Function valfc(ByVal d As Double) As System.Drawing.Color
        If vald(d, False) Then
            Return Drawing.Color.DarkBlue
        Else
            Return Drawing.Color.White
        End If
    End Function
    Function valv(ByVal d As Double) As System.Drawing.Color
        Dim b As Boolean
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        On Error Resume Next
        Dim s As String = Format(DateAdd(DateInterval.Month, d - 1, dt), "[yyyy-M]")
        b = Eval(s)
        If Err.Number <> 0 Then
            b = False
            Err.Clear()
        Else
            b = True
        End If
        If b Then
            Return Drawing.Color.White
        Else
            Return Drawing.Color.Pink
        End If
    End Function
    Function valfooter(ByVal i As Integer) As Integer
        Return bisVal(i - 1)

    End Function

    Protected Sub CBMONTH1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub CBMONTH1_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub CBMONTH1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Exit Sub
        'Dim cidN As Int64
        'Dim fidN As Int16
        'Dim didN As DateTime
        'Dim lbl As Label
        'Dim hdn As HiddenField
        'Dim cb As CheckBox = CType(sender, CheckBox)
        'Dim gvr As GridViewRow = CType(cb.NamingContainer, GridViewRow)
        'Dim gv As GridView = CType(gvr.NamingContainer, GridView)
        'Dim ds As SqlDataSource = DSEvents
        'Dim ddl As DropDownList = DDLWORKYEAR
        'Dim sSql As String = vbNullString
        'Dim imi As Integer = Int(Mid(cb.ID, 8))
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        'If cb.Checked Then

        '    ' insert new payment

        '    ' Prepare Inset Paramenters

        '    lbl = CType(gvr.FindControl("LBLCUSTID"), Label)
        '    cidN = lbl.Text

        '    hdn = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
        '    fidN = hdn.Value

        '    didN = DateAdd("m", imi - 1, ddl.SelectedValue)

        '    Dim iUserID As Int16 = Int(Session("UserID"))

        '    'prepare sql command

        '    sSql = "INSERT INTO p0t_PaymentTable(CustomerID, FrameID, PaymentDate, Comment, Paid, UserID) VALUES ("
        '    sSql = sSql & cidN & ","
        '    sSql = sSql & fidN & ","
        '    sSql = sSql & "'" & Format(didN, "yyyy-MM-dd") & "',"
        '    sSql = sSql & "NULL, 1,"
        '    sSql = sSql & iUserID & ")"

        'Else

        '    '            If MsgBox("האם למחוק את התשלום?", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
        '    'delete a payment

        '    'prepare delete parameters

        '    hdn = CType(gvr.FindControl("HDNPMONTH" & imi), HiddenField)
        '    Dim pid As Integer = hdn.Value

        '    ' prepare sql command

        '    sSql = "Delete From p0t_Paymenttable Where paymentID = " & pid
        '    '           Else
        '    '           cb.Checked = True
        '    '        End If

        'End If

        '' Excute Sql Command

        'If sSql <> vbNullString Then
        '    Dim ConComp As New SqlCommand(sSql, dbConnection)
        '    ConComp.CommandType = Data.CommandType.Text
        '    dbConnection.Open()
        '    ConComp.ExecuteNonQuery()
        '    dbConnection.Close()
        '    GVList.DataBind()
        'End If
    End Sub

    Protected Sub LNKBM1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        Dim db As Double = CDbl(Mid(lnkb.ID, 6))
        Dim d As DateTime = DDLWORKYEAR.SelectedValue
        d = DateAdd(DateInterval.Month, db - 1, d)
        Dim iuid As Integer = Session("UserID")
        Dim s As String = Format(d, "yyyy-MM-dd")
        Dim ssql As String = "INSERT INTO p0t_PaymentTable SELECT CustomerID, CustFrameID AS FrameID, PaymentMonth AS PaymentDate, "
        ssql = ssql & "Comment,1 as Paid," & iuid & " AS UserID FROM dbo.p0v_payList WHERE (Paid = 0) AND (PaymentMonth='" & s & "')"
        On Error Resume Next
        Dim i As Integer = DDLSERVICES.SelectedValue

        If Err.Number <> 0 Then
            Err.Clear()
        Else
            ssql = ssql & " AND (ServiceID=" & i & ")"
        End If

        i = DDLFRAMES.SelectedValue
        If Err.Number <> 0 Then
            Err.Clear()
        Else
            ssql = ssql & " AND (CustFrameID=" & i & ")"
        End If
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand(ssql, dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
        GVList.DataBind()

    End Sub

    Protected Sub Button1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim gv As GridView = GVList
        Dim i As Integer
        Dim j As Integer
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        If Not IsPostBack Then Exit Sub
        For i = 1 To gv.Rows.Count
            Dim gvr As GridViewRow = CType(gv.Rows(i - 1), GridViewRow)
            For j = 1 To 12
                Dim ckb As CheckBox = CType(gvr.FindControl("CBMONTH" & j), CheckBox)
                If Not ckb Is Nothing Then
                    If (ckb.Checked And ckb.BorderColor = Drawing.Color.White) Or (Not ckb.Checked And ckb.BorderColor = Drawing.Color.DarkBlue) Then
                        Dim cidN As Int64
                        Dim fidN As Int16
                        Dim didN As DateTime
                        Dim hdn As HiddenField
                        Dim ds As SqlDataSource = DSEvents
                        Dim ddl As DropDownList = DDLWORKYEAR
                        Dim sSql As String = vbNullString
                        Dim imi As Integer = Int(Mid(ckb.ID, 8))

                        If ckb.Checked Then

                            ' insert new payment

                            ' Prepare Inset Paramenters

                            Dim btn As Button = CType(gvr.FindControl("LNKBID"), Button)
                            cidN = btn.Text

                            hdn = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
                            fidN = hdn.Value

                            didN = DateAdd("m", imi - 1, ddl.SelectedValue)

                            Dim iUserID As Int16 = Int(Session("UserID"))

                            'prepare sql command

                            sSql = "INSERT INTO p0t_PaymentTable(CustomerID, FrameID, PaymentDate, Comment, Paid, UserID) VALUES ("
                            sSql = sSql & cidN & ","
                            sSql = sSql & fidN & ","
                            sSql = sSql & "'" & Format(didN, "yyyy-MM-dd") & "',"
                            sSql = sSql & "NULL, 1,"
                            sSql = sSql & iUserID & ")"

                        Else

                            '            If MsgBox("האם למחוק את התשלום?", MsgBoxStyle.OkCancel) = MsgBoxResult.Ok Then
                            'delete a payment

                            'prepare delete parameters

                            hdn = CType(gvr.FindControl("HDNPMONTH" & imi), HiddenField)
                            Dim pid As Integer = hdn.Value

                            ' prepare sql command

                            sSql = "Delete From p0t_Paymenttable Where paymentID = " & pid
                            '           Else
                            '           cb.Checked = True
                            '        End If

                        End If

                        ' Excute Sql Command

                        If sSql <> vbNullString Then
                            Dim ConComp As New SqlCommand(sSql, dbConnection)
                            ConComp.CommandType = Data.CommandType.Text
                            ConComp.ExecuteNonQuery()
                            ConComp = Nothing
                        End If

                    End If
                End If
            Next
        Next

        ' Delete duplicates

        Dim ConDup As New SqlCommand("p0p_ClrDupPay", dbConnection)
        ConDup.CommandType = Data.CommandType.StoredProcedure
        ConDup.ExecuteNonQuery()

        dbConnection.Close()
        gv.DataBind()
    End Sub
    Protected Sub LNKBID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Timeout = 90
    End Sub
    Function OpenINOUT() As String
        Return "window.open('" & getUrl("/CustINOUT.aspx") & "?C=" & Eval("ת_ז") & "', '_blank', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=250,width=600');"
    End Function
    Function getUrl(sPage As String) As String
        Dim sUrl As String = Request.Url.AbsoluteUri
        sUrl = Left(sUrl, sUrl.Length - InStr(StrReverse(sUrl), "/")) & sPage
        Return sUrl
    End Function

    Protected Sub DSEvents_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSEvents.Selecting
        e.Command.Parameters("@ServiceID").Value = Nothing
        'For i = 0 To e.Command.Parameters.Count - 1
        '    Response.Write(e.Command.Parameters(i).ToString & " = " & e.Command.Parameters(i).Value & "<BR />")
        'Next

    End Sub
End Class
