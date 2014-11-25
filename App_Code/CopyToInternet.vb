Imports Microsoft.VisualBasic
Imports System.Data.SqlClient

Public Class CopyToInternet
    Public Shared Function fCopyToInternet(Constr As String, sSchema As String, sSource As String, sTareget As String) As Integer ' 0 - OK, <>0 - Error Eccording to the list below
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Constr).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        ' Sql procedure to prepare sql Command Text

        Dim cI As New SqlCommand("Copytable2Table", dbConnection)
        cI.CommandType = Data.CommandType.StoredProcedure
        cI.Parameters.AddWithValue("Schema", sSchema)
        cI.Parameters.AddWithValue("Source", sSource)
        cI.Parameters.AddWithValue("Target", sTareget)
        Dim df As New SqlParameter("RetCode", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        cI.Parameters.Add(df)

        dbConnection.Open()

        Dim dr As SqlDataReader = cI.ExecuteReader
        Dim sSql As String = vbNullString
        Dim sSqlb As String = vbNullString
        If dr.Read Then
            sSql = dr("InsCom")
            sSqlb = dr("sRows")
        Else
            Dim i As Integer = df.Value
        End If

        dr.Close()

        ' Build sql File text

        cI.CommandText = sSqlb
        cI.CommandType = Data.CommandType.Text
        dr = cI.ExecuteReader
        While dr.Read
            sSql &= " " & dr("TRow")
        End While

        dr.Close()
        sSql &= "')"


        cI.CommandText = sSql

        cI.ExecuteNonQuery()

        dbConnection.Close()

        Return 0
    End Function
End Class
