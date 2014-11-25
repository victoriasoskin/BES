Imports System.Data.SqlClient
Imports eid
Imports PageErrors
Partial Class ServiceList
    Inherits System.Web.UI.Page

    Protected Sub CustomValidator1_ServerValidate(ByVal source As Object, ByVal args As System.Web.UI.WebControls.ServerValidateEventArgs)
    End Sub

    Protected Sub TextBox2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim UserName As String = tb.Text
        Dim dv As DetailsView = CType(tb.NamingContainer, DetailsView)
        Dim cv As CustomValidator = CType(dv.FindControl("CVUN"), CustomValidator)
        Dim tb1 As TextBox = CType(dv.FindControl("TextBox1"), TextBox)

        If Not UserName Is Nothing Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select UserName From p0t_Ntb Where UserName='" & UserName & "'", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            On Error Resume Next
            Dim s As String = dr("UserName")
            If Err.Number = 0 Then
                cv.IsValid = False
                tb.Focus()
                tb.Text = vbNullString
            Else
                Err.Clear()
                tb1.Focus()
            End If
            dbConnection.Close()
        End If
    End Sub

    Protected Sub TextBox2_TextChanged1(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim UserName As String = tb.Text
        Dim gvr As GridViewRow = CType(tb.NamingContainer, GridViewRow)
        Dim cv As CustomValidator = CType(gvr.FindControl("CVUN"), CustomValidator)
        Dim tb1 As TextBox = CType(gvr.FindControl("TextBox1"), TextBox)
        Dim tb2 As TextBox = CType(gvr.FindControl("TextBox4"), TextBox)
        Dim j As Integer
        If Len(tb2.Text) > 0 Then
            j = Int(tb2.Text)
        Else
            Stop
        End If

        If Not UserName Is Nothing Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select UserName,UserID From p0t_Ntb Where UserName='" & UserName & "'", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            On Error Resume Next
            Dim s As String = dr("UserName")
            Dim i As Integer = Int(dr("UserID"))
            If Err.Number = 0 And i <> j Then
                cv.IsValid = False
                tb.Focus()
                tb.Text = vbNullString
            Else
                Err.Clear()
                tb1.Focus()
            End If
            dbConnection.Close()
        End If
    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        DetailsView1.Visible = False
    End Sub

    Protected Sub LinkButton2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        DetailsView1.Visible = True
    End Sub
    Protected Sub DSUsers_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs)
        DetailsView1.Visible = True
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLID"), Label)
        Dim UID As Integer = CType(lbl.Text, Integer)
        lbl = CType(gvr.FindControl("LBLUN"), Label)
        Dim sUN As String = CType(lbl.Text, String)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Update p0t_Ntb set password='" & EncryptText(sUN) & "' Where userID=" & UID, dbConnection)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub

    Protected Sub Page_Error(sender As Object, e As EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub DSUsers_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs)
        Dim usr As String = e.Command.Parameters(0).Value
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Update p0t_Ntb set password='" & EncryptText(usr) & "' Where username='" & usr & "'", dbConnection)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub

	Protected Sub DSFrames_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs)
		Dim gv As GridView = CType(GridView1, GridView)
        Dim gvr As GridViewRow = Nothing
		Dim i As Integer
		For i = 1 To gv.Rows.Count - 1
			gvr = gv.Rows(i)
			If gvr.RowState = DataControlRowState.Edit Then Exit For
		Next

		Dim ddl As DropDownList = CType(gvr.FindControl("ddlservices"), DropDownList)
		If ddl.SelectedValue > 0 Then
			e.Command.Parameters(0).Value = CInt(ddl.SelectedValue)
		End If

	End Sub

	Protected Sub DDLFRAME_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim ddl As DropDownList = CType(sender, DropDownList)
		Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
		Dim hdn As HiddenField = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
		If hdn.Value IsNot Nothing Then ddl.SelectedValue = hdn.Value
	End Sub

	Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating

	End Sub

	Protected Sub DSFrames_Load(ByVal sender As Object, ByVal e As System.EventArgs)

	End Sub

	Protected Sub DDLFRAME_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim ddl As DropDownList = CType(sender, DropDownList)
		Dim gvr As GridViewRow = CType(ddl.NamingContainer, GridViewRow)
		Dim hdn As HiddenField = CType(gvr.FindControl("HDNFRAMEID"), HiddenField)
		hdn.Value = ddl.SelectedValue

	End Sub

    Protected Sub GridView1_PreRender(sender As Object, e As System.EventArgs) Handles GridView1.PreRender
        Dim gv As GridView = CType(sender, GridView)
        If IsDBNull(Session("SUser")) Then
            gv.Columns(12).Visible = False
        ElseIf Session("SUser") = 0 Then
            gv.Columns(12).Visible = False
        End If
    End Sub
End Class
