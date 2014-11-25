Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports System.IO

Public Class UtilVB

    Dim connStr As String
    Dim dbConnection As System.Data.IDbConnection


    Public Sub New()
        connStr = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        dbConnection = New System.Data.SqlClient.SqlConnection(connStr)
    End Sub

    Private _FrameYearType As String
    Public ReadOnly Property FrameYearType(FrameId As Integer) As String
        Get
            If _FrameYearType = vbNullString Then
                Dim o As Object = selectDBScalar(String.Format("SELECT YearType FROM Book10_21.dbo.FrameList WHERE FrameId = {0}", FrameId))
                _FrameYearType = If(o Is Nothing, vbNullString, o.ToString)

            End If
            Return _FrameYearType
        End Get
    End Property

    Private _FrameId As Integer
    Public ReadOnly Property FrameId() As Integer
        Get
            If _FrameId = 0 Then
                _FrameId = If(HttpContext.Current.Session("FrameId") Is Nothing, 0, HttpContext.Current.Session("FrameId"))
            End If
            Return _FrameId
        End Get
    End Property

    Private _UserId As Integer
    Public ReadOnly Property UserId() As Integer
        Get
            If _UserId = 0 Then
                _UserId = If(HttpContext.Current.Session("UserId") Is Nothing, 0, HttpContext.Current.Session("UserId"))
            End If
            Return _UserId
        End Get
    End Property

    Public Function selectDBScalar(sql As String) As Object
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim o As Object = Nothing
        Try
            o = cD.ExecuteScalar()
        Catch ex As Exception
            Throw ex
        Finally
            dbConnection.Close()
        End Try
        Return o
    End Function

    Public Function selectDBQuery(sql As String) As DataTable
        Dim dt As New DataTable()
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = CommandType.Text
        cD.CommandTimeout = 300
        Dim da As New SqlDataAdapter()
        da.SelectCommand = cD
        da.Fill(dt)
        Return dt
    End Function

    Public Sub RemoveDDLDupItems(ByRef ddl As DropDownList)
        Dim cItems As New Microsoft.VisualBasic.Collection
        Dim cItems2Delete As New Microsoft.VisualBasic.Collection
        For i As Integer = 0 To ddl.Items.Count - 1
            Try
                cItems.Add(ddl.Items(i).Value, ddl.Items(i).Value)
            Catch ex As Exception
                cItems2Delete.Add(i)
            End Try
        Next
        For i = cItems2Delete.Count To 1 Step -1
            ddl.Items.RemoveAt(cItems2Delete(i))
        Next
    End Sub

    Public Sub ExportGridviewIntoOffice(gv As GridView, FileName As String, App As String, style As String, title As String, subTitle As String)
        'Try
        Dim contentType As String = String.Empty
        Dim addHeader As String = String.Empty
        Select Case App
            Case "word"
                contentType = "application/vnd.ms-word"
                addHeader = "attachment;filename=" + FileName + ".doc"
            Case "excel"
                contentType = "application/vnd.ms-excel"
                addHeader = "attachment;filename=" + FileName + ".xls"
        End Select

        System.Web.HttpContext.Current.Response.Clear()
        System.Web.HttpContext.Current.Response.ContentType = contentType
        System.Web.HttpContext.Current.Response.ContentEncoding = System.Text.Encoding.Unicode
        System.Web.HttpContext.Current.Response.BinaryWrite(System.Text.Encoding.Unicode.GetPreamble())
        System.Web.HttpContext.Current.Response.AddHeader("content-disposition", addHeader)
        System.Web.HttpContext.Current.Response.Charset = ""
        System.Web.HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Dim stringWrite As New StringWriter()
        stringWrite.Write("<html><header><style type='css/text'>" + style + "</style></header><body style='direction:rtl; font-family:Arial;'>" + "<h1>" + title + "</h1><h2>" + subTitle + "</h2>")
        Dim htmlWrite As New HtmlTextWriter(stringWrite)
        Dim frm As New HtmlForm()

        gv.Parent.Controls.Add(frm)
        frm.Controls.Add(gv)

        frm.RenderControl(htmlWrite)
        System.Web.HttpContext.Current.Response.Write(stringWrite.ToString() + "</body></html>")
        'Catch ex As Exception
        '    Throw ex
        'Finally
        System.Web.HttpContext.Current.Response.End()
        'End Try
    End Sub
    Public Sub executeSql(sql As String)
        Dim cD As New SqlCommand(sql, dbConnection)
        cD.CommandType = CommandType.Text
        dbConnection.Open()
        cD.ExecuteNonQuery()
        dbConnection.Close()
    End Sub
End Class
