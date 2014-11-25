Imports System.Data.SqlClient
Partial Class MAint
    Inherits System.Web.UI.Page

    Protected Sub btnDel_Click(sender As Object, e As System.EventArgs) Handles btnDel.Click
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("X_Delete_ExEvent", dbConnection)
        cD.CommandType = Data.CommandType.StoredProcedure
        cD.Parameters.AddWithValue("@ExEventID", tbExID.Text)
        cD.Parameters.AddWithValue("@CustomerID", tbCID.Text)
        dbConnection.Open()
        Dim s As String = "תקלת תוכנה"
        Try
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                s = dr("Msg")
            End If
        Catch ex As Exception
        End Try
        dbg(s, False)
    End Sub
#Region "Debug"
    Sub dbg(s As String, Optional bError As Boolean = True, Optional NewID As Integer = 0)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""window.open('Maint.aspx','_self')"" /></div>")
        Response.End()
     End Sub
#End Region
End Class
