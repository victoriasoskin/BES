Imports System.Data.SqlClient
Partial Class BVAREP
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If IsPostBack Then
            CopySession()
        Else
        End If
    End Sub
    Dim TotalColvalue(0 To 16) As Decimal
    Function GetColValue(ByVal xxx As Decimal, ByVal i As Integer) As Decimal
        TotalColvalue(i) += xxx
        Return xxx
    End Function
    Function GetTotal(ByVal i As Integer) As Decimal
        Return TotalColvalue(i)
    End Function

    'Protected Sub DDLVERSION_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLVERSION.SelectedIndexChanged
    '    CopySession()
    '    Session("DateB") = Nothing
    'End Sub

    Protected Sub DDLDates_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDates.SelectedIndexChanged
        CopySession()
    End Sub

    Protected Sub DDLSHERUT_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSHERUT.SelectedIndexChanged
        CopySession()
    End Sub
     Protected Sub DDLDates_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDates.PreRender
        'If DDLDates.SelectedValue Is Nothing Then
        DDLDates.SelectedValue = Session("DATEB")
        'End If
    End Sub
    Sub CopySession()
        'Session("Version") = DDLVERSION.SelectedItem.Text
        Session("Frame") = DDLSHERUT.SelectedItem.Text
        If DDLDates.SelectedValue Is Nothing Then
            Session("dateb") = DDLDates.Items(0).Value
        Else
            Session("DateB") = DDLDates.SelectedValue
        End If
        Session("CALC") = 1
    End Sub

    Protected Sub DSREPDATA_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles DSREPDATA.DataBinding
        Dim ds As SqlDataSource = CType(sender, SqlDataSource)

    End Sub

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        Session("CALC") = 0

    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim gv As GridView = CType(sender, GridView)
    End Sub
    'Protected Sub LBTNRCLASS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LBTNRCLASS.PreRender
    '    'Dim ddl As DropDownList = DDLSHERUT
    '    'Dim i As Integer
    '    'If ddl.SelectedValue <> vbNullString Then
    '    '    i = ddl.SelectedValue
    '    '    Dim s As String = "SELECT  COUNT(ACTID) AS cnt, FrameCategoryID FROM  "
    '    '    s = s & "dbo.p2v_NotorWrongbudclassification GROUP BY FrameCategoryID"
    '    '    s = s & " HAVING(FrameCategoryID =" & i & ")"
    '    '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
    '    '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
    '    '    Dim ConComp As New SqlCommand(s, dbConnection)
    '    '    dbConnection.Open()
    '    '    Dim dr As SqlDataReader = ConComp.ExecuteReader()
    '    '    dr.Read()
    '    '    If dr.HasRows = True Then
    '    '        LBTNRCLASS.Enabled = True
    '    '        LBTNRCLASS.Text = "נדרש סיווג לתקציב"
    '    '        LBTNRCLASS.PostBackUrl = "p2a_BudgetClass.aspx?FrameID=" & i
    '    '    End If
    '    '    dbConnection.Close()
    '    'End If
    'End Sub

    Protected Sub DDLYEAR_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLYEAR.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            Dim d As DateTime = DateAdd(DateInterval.Month, -2, Now())
            ddl.Text = CType(DatePart(DateInterval.Year, d), String)
            Session("DateS") = CType(ddl.Text & "-01-01", DateTime)
        End If
    End Sub

    Protected Sub DDLYEAR_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLYEAR.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("DateS") = CType(ddl.Text & "-01-01", DateTime)
    End Sub

    Protected Sub HyperLink1_Unload(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub HyperLink1_Disposed(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    'Protected Sub DDLVERSION_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLVERSION.DataBound
    '    Dim ddl As DropDownList = CType(sender, DropDownList)
    '    ddl.ClearSelection()
    '    Dim lm As ListItem = ddl.Items.FindByText(Session("Version"))
    '    If Not lm Is Nothing Then lm.Selected = True
    'End Sub

    Protected Sub DDLDates_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDates.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.ClearSelection()
        Dim lm As ListItem = ddl.Items.FindByText(Session("dateB"))
        If Not lm Is Nothing Then lm.Selected = True
    End Sub

    Protected Sub DDLSHERUT_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSHERUT.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.ClearSelection()
        Dim lm As ListItem = ddl.Items.FindByText(Session("Frame"))
        If Not lm Is Nothing Then lm.Selected = True
    End Sub
End Class
