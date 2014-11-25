Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Xml

Public Class sqlOps
    Public Shared Function getSqlScalar(sql As String, ConnString As String, Optional sFld As String = vbNullString) As Object
        Dim sclr As Object = Nothing
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(ConnString)
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        If sFld = vbNullString Then
            Dim retObj As Object = cD.ExecuteScalar()
            If retObj IsNot Nothing AndAlso retObj IsNot DBNull.Value Then
                sclr = CType(retObj, Object)
            End If
        Else
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                sclr = dr(sFld)
            End If
            dr.Close()
        End If
        dbConnection.Close()
        Return sclr
    End Function
    Public Shared Function getXmlFromSql(sql As String, ConnString As String) As XmlDocument
        Dim doc As New XmlDocument
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(ConnString)
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim Generator As System.Random = New System.Random()
        Dim n As Integer = Generator.Next(100000, 999999)
        Dim sFile As String = HttpContext.Current.Server.MapPath("fn" & n & ".XML")
        Dim s As String = cD.ExecuteScalar().ToString
        Dim xd As XDocument = XDocument.Parse(s)
        xd.Save(sFile)
        doc.Load(sFile)
        If System.IO.File.Exists(sFile) = True Then
            System.IO.File.Delete(sFile)
        End If
        Return doc
    End Function
    Public Shared Sub WriteXmlFileFromSql(sql As String, sConnstring As String, sFileName As String)
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(sConnstring)
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim Generator As System.Random = New System.Random()
        Dim n As Integer = Generator.Next(100000, 999999)
        Dim sFile As String = HttpContext.Current.Server.MapPath(sFileName)
        Dim s As String = cD.ExecuteScalar().ToString
        Dim xd As XDocument = XDocument.Parse(s)
        xd.Save(sFile)
    End Sub
End Class
