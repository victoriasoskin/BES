Imports System.Data.SqlClient
Partial Class ProcessSql
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("ConnectionString")).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(Session("SqlCommand"), dbConnection)
        dbConnection.Open()
        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
        End Try
        Session("SqlCommand") = Nothing
        dbConnection.Close()
        Dim sScript As String = "<Script langualge=&quot;javascript&quot;>window.open('', '_self', ''); window.close();</Script>"
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", sScript)
    End Sub
End Class
