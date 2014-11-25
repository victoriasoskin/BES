Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic

Public Class TreeViewSqlTable

    Public Shared Sub PopulateRootLevel(TV As TreeView, CategoryID As String, TextField As String, TableName As String, ParentID As String, RootCategoryID As String, ItemOrder As String, Optional sConnName As String = "BeBook10")
        Dim connStr As String = ConfigurationManager.ConnectionStrings(sConnName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim objCommand As New SqlCommand("select " & CategoryID & " As CategoryID," & TextField & " as title,(select count(*) FROM " & TableName & " As x " _
    & " WHERE " & ParentID & " = y." & CategoryID & ") As childnodecount FROM " & TableName & " As y where " & ParentID & " = " & RootCategoryID & If(ItemOrder Is Nothing, vbNullString, " ORDER BY " & ItemOrder) _
    , dbConnection)

        Dim da As New SqlDataAdapter(objCommand)
        Dim dt As New DataTable()
        da.Fill(dt)

        PopulateNodes(dt, TV.Nodes)
    End Sub
    Public Shared Sub PopulateNodes(ByVal dt As DataTable, _
     ByVal nodes As TreeNodeCollection)

        For Each dr As DataRow In dt.Rows
            Dim tn As New TreeNode()
            tn.Text = dr("title").ToString()
            tn.Value = dr("CategoryID").ToString()
            nodes.Add(tn)

            'If node has child nodes, then enable on-demand populating
            tn.PopulateOnDemand = (CInt(dr("childnodecount")) > 0)
        Next
    End Sub
    Public Shared Sub PopulateSubLevel(ByVal pid As Integer, _
     ByVal parentNode As TreeNode, CategoryID As String, TextField As String, TableName As String, ParentID As String, RootCategoryID As Integer, ItemOrder As String, Optional sConnName As String = "BeBook10")
        Dim connStr As String = ConfigurationManager.ConnectionStrings(sConnName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim objCommand As New SqlCommand("select " & CategoryID & " As CategoryID," & TextField & " as title,(select count(*) FROM " & TableName & " As x " _
   & " WHERE " & ParentID & " = y." & CategoryID & ") As childnodecount FROM " & TableName & " As y where  " & ParentID & " = " & pid & _
    If(ItemOrder Is Nothing, vbNullString, " ORDER BY " & ItemOrder) _
         , dbConnection)

        Dim da As New SqlDataAdapter(objCommand)
        Dim dt As New DataTable()
        Try
            da.Fill(dt)
        Catch ex As Exception
            Exit Sub
        End Try
        parentNode.PopulateOnDemand = False
        PopulateNodes(dt, parentNode.ChildNodes)
    End Sub

End Class
