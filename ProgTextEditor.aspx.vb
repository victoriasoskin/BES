Imports CKEditor.NET
Imports System.Data.SqlClient
Partial Class ProgTextEditor
    Inherits System.Web.UI.Page

    Protected Sub ddltexts_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddltexts.SelectedIndexChanged
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Dim cD As New SqlCommand("SELECT rftext FROM ProgramTexts Where ProgramID = " & ddlProgs.SelectedValue & " AND textID=" & ddltexts.SelectedValue, dbConnection)
        'cD.CommandType = Data.CommandType.Text
        'dbConnection.Open()
        'Dim dr As SqlDataReader = cD.ExecuteReader
        'If dr.Read Then
        '    ckE.Text = dr("RFtEXT")
        'End If 
        'dr.Close()
        'dbConnection.Close()

    End Sub

    Protected Sub ddlProgs_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlProgs.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)

        ImageMapx.Visible = ddl.SelectedValue <> vbNullString
    End Sub

    Protected Sub ImageMapx_Click(sender As Object, e As System.Web.UI.WebControls.ImageMapEventArgs) Handles ImageMapx.Click
        Dim li As ListItem = ddltexts.Items.FindByValue(e.PostBackValue)
        If li IsNot Nothing Then
            ddltexts.ClearSelection()
            li.Selected = True
        End If
    End Sub

    Protected Sub ImageMapx_PreRender(sender As Object, e As System.EventArgs) Handles ImageMapx.PreRender
        Dim imgm As ImageMap = CType(sender, ImageMap)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("SELECT hsTop,hsBottom,hsLeft,hsRight,TextDescription,TextID FROM ProgramTexts Where ProgramID = " & ddlProgs.SelectedValue & " AND hsTop is not null", dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        While dr.Read
            Dim hspt As New RectangleHotSpot
            hspt.HotSpotMode = HotSpotMode.PostBack
            hspt.Top = dr("hsTop")
            hspt.Bottom = dr("hsBottom")
            hspt.Left = dr("hsLeft")
            hspt.Right = dr("hsRight")
            hspt.AlternateText = dr("TextDescription")
            hspt.PostBackValue = dr("TextID")
            imgm.HotSpots.Insert(0, hspt)
        End While
        dr.Close()
        dbConnection.Close()
    End Sub
End Class
