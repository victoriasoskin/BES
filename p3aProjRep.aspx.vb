Imports System.Data.SqlClient
Partial Class p3a_Trans
    Inherits System.Web.UI.Page
    Dim dTot As Double
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("BCID") <> vbNullString Then
            SessionCLR("UAD_")
        End If
    End Sub
    Protected Sub DDLF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = Mid(ddl.ID, 5)
        ddl.SelectedValue = Session("UAD_" & s)
    End Sub
    Protected Sub LNKBCF_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        Dim s As String = Mid(lnkb.ID, 7)
        Session("UAD_" & s) = vbNullString
    End Sub
    Protected Sub DDLF_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = Mid(ddl.ID, 5)
        Session("UAD_" & s) = ddl.SelectedValue
    End Sub

    Protected Sub TBF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim s As String = Mid(tb.ID, 4)
        tb.Text = Session("UAD_" & s)
    End Sub

    Protected Sub TBF_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim s As String = Mid(tb.ID, 4)
        Session("UAD_" & s) = tb.Text
    End Sub

    Protected Sub LNKBSHOWALL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LNKBSHOWALL.Click
        SessionCLR("UAD_")
        Response.Redirect("p3aProjRep.aspx")
    End Sub
    Public Function truncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gv As GridView = GridView1
        Dim i As Integer
        If Session("UDA_VISIBLE") Is Nothing Or Session("UDA_VISIBLE") = 0 Then
            For i = 9 To 13
                gv.Columns(i).Visible = True
            Next
            Session("UDA_VISIBLE") = 1
            btn.Text = "<<<"
        Else
            For i = 9 To 13
                gv.Columns(i).Visible = False
            Next
            Session("UDA_VISIBLE") = 0
            btn.Text = "***"
        End If
    End Sub

    Protected Sub Button1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        If Session("UDA_VISIBLE") Is Nothing Or Session("UDA_VISIBLE") = 0 Then
            btn.Text = ">>>"
        Else
            btn.Text = "<<<"
        End If

    End Sub

    Protected Sub DDLFRAME_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim j As Integer = ddl.SelectedValue
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLORGROWID"), Label)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
        hdn.Value = ddl.SelectedValue
        'Dim ds As SqlDataSource = CType(gvr.FindControl("DSBUDITEMS"), SqlDataSource)
        'ds.DataBind()
        Dim i As Integer = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p3p_UPDTRANS", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.Clear()
        ConComp.Parameters.AddWithValue("OrgRowID", i)
        ConComp.Parameters.AddWithValue("FrameCategoryID", ddl.SelectedValue)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub


    Protected Sub DDLBUDITEM_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim GVR As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        If Not ddl Is Nothing Then
            If Not (GVR.DataItem Is Nothing) Then
                Dim i As Integer = CType(GVR.DataItem("BudgetCategoryID"), Integer)
                Dim s As String = CType(GVR.DataItem("BudItem"), String)
                Dim lm As ListItem = ddl.Items.FindByText(s)
                If Not (lm Is Nothing) Then
                    lm.Selected = True
                Else
                    Dim li As New ListItem(s, i)
                    ddl.Items.Insert(0, li)
                    li.Selected = True
                    ddl.ForeColor = Drawing.Color.Red
                End If
            End If
        End If
    End Sub
    Protected Sub DDLSubject_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim GVR As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim s As String = vbNullString
        If Not ddl Is Nothing Then
            If Not (GVR.DataItem Is Nothing) Then
                On Error Resume Next
                s = CType(GVR.DataItem("Subject"), String)
                If Err.Number <> 0 Then
                    Err.Clear()
                    s = "<-->"
                End If
                Dim lm As ListItem = ddl.Items.FindByText(s)
                If Not (lm Is Nothing) Then
                    lm.Selected = True
                Else
                    Dim li As New ListItem(s, s)
                    ddl.Items.Insert(0, li)
                    li.Selected = True
                    ddl.ForeColor = Drawing.Color.Red
                End If
            End If
            ddl.ToolTip = s
        End If
    End Sub
    Protected Sub DDLBUDITEM_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim j As Integer = ddl.SelectedValue
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLORGROWID"), Label)
        Dim i As Integer = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p3p_UPDTRANS", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.Clear()
        ConComp.Parameters.AddWithValue("OrgRowID", i)
        ConComp.Parameters.AddWithValue("BudgetCategoryID", ddl.SelectedValue)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub

    Protected Sub DDLSubject_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = ddl.SelectedValue
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLORGROWID"), Label)
        Dim i As Integer = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p3p_UPDTRANS", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.Clear()
        ConComp.Parameters.AddWithValue("OrgRowID", i)
        ConComp.Parameters.AddWithValue("Subject", ddl.SelectedValue)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
        ddl.ToolTip = ddl.SelectedValue
    End Sub
    Protected Sub DDLRDate_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim GVR As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        If Not ddl Is Nothing Then
            If Not (GVR.DataItem Is Nothing) Then
                Dim d As DateTime = CType(GVR.DataItem("ReportDate"), DateTime)
                Dim s As String = Format(d, "MMM-yy")
                Dim lm As ListItem = ddl.Items.FindByText(s)
                If Not (lm Is Nothing) Then
                    lm.Selected = True
                Else
                    Dim li As New ListItem(s, d)
                    ddl.Items.Insert(0, li)
                    li.Selected = True
                    ddl.ForeColor = Drawing.Color.Red
                End If
            End If
        End If
    End Sub
    Protected Sub DDLRDate_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim d As DateTime = ddl.SelectedValue
        Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLORGROWID"), Label)
        Dim i As Integer = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p3p_UPDTRANS", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.Clear()
        ConComp.Parameters.AddWithValue("OrgRowID", i)
        ConComp.Parameters.AddWithValue("ReportDate", ddl.SelectedValue)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub
    Function dVal(ByVal s As String) As String
        Dim dbl As Double = Eval(s)
        dTot = dTot + dbl
        Return Format(-dbl, "#,###")
    End Function
    Function dTVal() As String
        Return Format(dTot, "-#,###;#,###")
    End Function
    Sub SessionCLR(ByVal s1 As String)
        Dim i As Integer
        For i = 0 To Session.Contents.Count - 1
            Dim s As String = Session.Keys(i)
            If Left(s, 4) = s1 Then
                s = Session(i)
                Session(i) = vbNullString
            End If
        Next
    End Sub

    Protected Sub LBLBTM_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LBLBTM.PreRender
        'LBLBTM.Text = "זמן טעינת הדף: " & Format(Timer - HDNTOP.Value, "#,##0.###") & " יחידות זמן"
    End Sub

    Protected Sub HDNTOP_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles HDNTOP.PreRender
        'HDNTOP.Value = Timer
    End Sub
End Class

