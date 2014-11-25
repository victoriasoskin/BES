Imports System.Data.SqlClient
Imports WRCookies
Imports PageErrors
Partial Class Testparameters
    Inherits System.Web.UI.Page

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        's = "<script"
        ' Response.TrySkipIisCustomErrors = True
    End Sub


    Protected Sub BTNsql_Click(sender As Object, e As System.EventArgs) Handles BTNsql.Click
        Dim b As CheckBox = CType(sender, CheckBox)
        Exit Sub
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim CD As New SqlCommand("sELECT * From NONE", dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = CD.ExecuteReader
        If dr.Read Then
            Dim i As Integer = dr("x")
        End If

        dbConnection.Close()
    End Sub

    Protected Sub btnSession_Click(sender As Object, e As System.EventArgs) Handles btnSession.Click
        If Request.QueryString("ID") Is Nothing Then Response.Write("Nothing ") Else Response.Write("Not-Noting ")
        If Request.QueryString("ID") = vbNullString Then Response.Write("vbnllstring ") Else Response.Write("Not-vbnllstring ")
        Response.End()
        '     Response.Write(ReadCookie_S("TestP") & " = ")
        If Request.QueryString("U") IsNot Nothing Then Session("UserID") = Request.QueryString("U")
        WriteCookie_S("TestP", Session("UserID"))
        Response.Write(Session("UserID") & "<br />")
        Session.Clear()
        Session.Abandon()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim CD As New SqlCommand("sELECT 1/0 AS X", dbConnection)
        Session("Alpha") = 1
        If Request.QueryString("U") IsNot Nothing Then Session("UserID") = Request.QueryString("U")
        Response.Write(Session("UserID") & "<br />")
        'Response.Write(ReadCookie_S("TestP"))
        'Response.Write(Request.QueryString("I"))
        Response.End()
        dbConnection.Open()
        Dim dr As SqlDataReader = CD.ExecuteReader
        If dr.Read Then
            Dim i As Integer = dr("x")
        End If
        dbConnection.Close()
    End Sub
End Class
