Imports System.Data.SqlClient
Partial Class Tarifs
    Inherits System.Web.UI.Page

    Protected Sub tbtarif_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim gvr As GridViewRow = CType(tb.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("lblframeid"), Label)
        Dim d As DateTime = CDate(ddlmonths.SelectedItem.Text)
        Dim dbl As Double
        Try
            dbl = tb.Text
        Catch ex As Exception
            dbl = 0
        End Try
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p1p_tarifs", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        ConComp.Parameters.AddWithValue("@FrameID", Int(lbl.Text))
        ConComp.Parameters.AddWithValue("@Pdate", d)
        ConComp.Parameters.AddWithValue("tarif", dbl)
        dbConnection.Open()
        Try
            ConComp.ExecuteNonQuery()
        Catch ex As Exception

        End Try
        dbConnection.Close()
    End Sub
    Protected Sub ddlmonths_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlmonths.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            Dim d As DateTime = DateAdd(DateInterval.Month, -2, CDate(DatePart(DateInterval.Year, Today) & "-" & DatePart(DateInterval.Month, Today) & "-1"))

            Dim li As ListItem = ddl.Items.FindByText(Format(d, "MMM-yy"))
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub
End Class
