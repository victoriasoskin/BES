Imports System.Data.SqlClient
Partial Class Default2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LBLUNAME.Text = Request.QueryString("UserName")
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim gvr As GridViewRow = CType(cb.NamingContainer, GridViewRow)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNCATEGORYID"), HiddenField)
        Dim sCat As String = "0"
        If hdn.Value IsNot Nothing Then sCat = hdn.Value
        Dim sUser As String = "0"
        If Request.QueryString("UserID") IsNot Nothing Then sUser = Request.QueryString("UserID")
        Dim sWhr = "Where CategoryID=" & sCat & " And UserID = " & sUser
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Delete from p0t_NtBRowB " & sWhr, dbConnection)
        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        If cb.Checked Then
            If sCat <> "0" And sUser <> "0" Then ConComp.CommandText = "Insert Into p0t_NtBRowB(UserID,CategoryID) Values(" & sUser & "," & sCat & ")"
            ConComp.ExecuteNonQuery()

        End If
        dbConnection.Close()
    End Sub
End Class
