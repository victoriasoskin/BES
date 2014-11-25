Imports System.Data.SqlClient
Partial Class SurIDList
    Inherits System.Web.UI.Page

	Protected Sub DSLIST_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSLIST.Inserting
		For i = 0 To e.Command.Parameters.Count - 1
			Dim s As String = e.Command.Parameters(i).ToString
			Dim sv As String = e.Command.Parameters(i).Value
			If s = "@FrameID" And sv = vbNullString Then
				Dim ddl As DropDownList = CType(DVE.FindControl("ddlframes"), DropDownList)
                e.Command.Parameters(i).Value = ddl.SelectedValue
			End If
		Next
	End Sub

	Protected Sub btnShow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
		DVE.Visible = True
	End Sub

	Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		DVE.DefaultMode = DetailsViewMode.Edit

	End Sub

	Protected Sub Label5_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim lbl As Label = CType(sender, Label)
		Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
		lbl.Text = gvr.RowIndex + 1
	End Sub

	Protected Sub btneps_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim btn As Button = CType(sender, Button)
		Dim sTT As String
		If LCase(btn.ID) = "btneps" Then
			sTT = "האם לאפס את הנסקר "
		Else
			sTT = "האם לסגור את הנסקר(!!!!!) "
		End If

		Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
		If gvr.Cells(9).Text = "כן" And gvr.Cells(10).Text = "לא" Then
			Dim s As String = gvr.Cells(2).Text & " " & gvr.Cells(3).Text.Replace("'", "") & " " & gvr.Cells(4).Text.Replace("'", "") & " ממסגרת " & gvr.Cells(5).Text.Replace("'", "").Replace("&quot;", "")
			btn.Visible = True
			btn.OnClientClick = "return confirm('" & sTT & s & "?');"
		Else
			btn.Visible = False
		End If
	End Sub

	Protected Sub btneps_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim btn As Button = CType(sender, Button)
		Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
		Dim hdn As HiddenField = CType(gvr.FindControl("hdnformid"), HiddenField)
		Dim s As String = hdn.Value
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim sqlCom As New SqlCommand("delete from Survey_Answers where formid=" & s, dbConnection)
		dbConnection.Open()
		sqlCom.ExecuteNonQuery()
		sqlCom.CommandText = "Delete From Survey_Forms where formid=" & s
		sqlCom.ExecuteNonQuery()
		sqlCom.CommandText = "Update SurveyIDList set password=null,done=null where done=" & s
		sqlCom.ExecuteNonQuery()
		dbConnection.Close()
		GridView1.DataBind()
	End Sub
	Protected Sub btncls_Click(ByVal sender As Object, ByVal e As System.EventArgs)
		Dim btn As Button = CType(sender, Button)
		Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
		Dim hdn As HiddenField = CType(gvr.FindControl("hdnformid"), HiddenField)
		Dim s As String = hdn.Value
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim sqlCom As New SqlCommand("Update SurveyIDList set done=-1 where done=" & s, dbConnection)
		dbConnection.Open()
		sqlCom.ExecuteNonQuery()
		dbConnection.Close()
		GridView1.DataBind()
	End Sub
End Class
