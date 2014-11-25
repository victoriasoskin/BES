Imports System.Data.SqlClient
Partial Class CLOSEAPP
    Inherits System.Web.UI.Page

	Protected Sub DropDownList1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.PreRender
		Dim ddl As DropDownList = CType(sender, DropDownList)
		If Not IsPostBack Then
			ddl.Items.Clear()
			Dim li As ListItem
			li = New ListItem("בחירה", "")
			ddl.Items.Add(li)
			li = New ListItem("פתיחת האתר", "NULL")
			ddl.Items.Add(li)
            Dim d As Date = Now()
			Dim s As String = Format(d, "yyyy-MM-dd hh:mm")
			s = Left(s, 14) & "00"
			d = CDate(s)
			For i = 0 To 24
				s = Format(d, "yyyy-MM-dd hh:mm")
				li = New ListItem(s, "'" & s & "'")
				ddl.Items.Add(li)
				d = DateAdd(DateInterval.Hour, 1, d)
			Next
		End If
	End Sub

	Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
		Dim ddl As DropDownList = CType(sender, DropDownList)
		If ddl.SelectedValue <> vbNullString Then

			Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
			Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

            Dim ConComp As New SqlCommand("update dbo.p0t_AppClosed set d=" & ddl.SelectedValue, dbConnection)
			dbConnection.Open()
			ConComp.ExecuteNonQuery()
			dbConnection.Close()
		End If

	End Sub
End Class
