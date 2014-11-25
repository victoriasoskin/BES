Imports System.Data.SqlClient
Partial Class Default2
    Inherits System.Web.UI.Page

	Protected Sub btndelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btndelete.Click
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim cD As New SqlCommand("ClearEmptyForms", dbConnection)
		cD.CommandType = Data.CommandType.StoredProcedure
        Dim cnt As New SqlParameter("@cnt", Data.SqlDbType.Int)
		cnt.Direction = Data.ParameterDirection.Output
		cD.Parameters.Add(cnt)

		dbConnection.Open()
		cD.ExecuteNonQuery()
		Dim iCnt As String = Convert.ToInt32(cnt.Value)
		dbConnection.Close()
		lblmsg.Text = "נמחקו " & iCnt & " שאלונים."
		lblmsg.Visible = True

	End Sub
End Class
