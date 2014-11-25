Imports System.Data.SqlClient
Partial Class ErrLog
    Inherits System.Web.UI.Page
    Dim sID As String
    Protected Sub btns_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        sID = gvr.Cells(0).Text
        DetailsView1.Visible = True
        DetailsView1.DataBind()
        gv.DataBind()
    End Sub
    Protected Sub btnx_Click(sender As Object, e As System.EventArgs)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim sID As String = gvr.Cells(0).Text
        If IsNumeric(sID) Then
            Dim cD As New SqlCommand("Update AA_errLog set Comment='Fixed' WHERE ID=" & sID, dbConnection)
            dbConnection.Open()
            cD.ExecuteNonQuery()
            dbConnection.Close()
            gv.DataBind()
        End If
    End Sub

    Protected Sub dsdet_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles dsdet.Selecting
        e.Command.Parameters("@ID").Value = sID
    End Sub
End Class
