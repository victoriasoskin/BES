Imports System.Data.SqlClient

Partial Class Default2
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ifrm As Integer
        If IsNumeric(Session("FrameID")) Then
            HDNFRAMEID.Value = Session("FrameID")
            ifrm = Session("FrameID")
        Else
            DDLFRAME.Visible = True
            ifrm = 0
        End If
        Dim ConComp As New SqlCommand("Select FrameName From FrameList Where FrameID=" & ifrm, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        If ifrm <> 0 Then LBLFN.Text = dr("FrameName")
        dbConnection.Close()
        LBLDT.Text = Format(Now(), "dd/MM/yy")
    End Sub

    Protected Sub DDLFRAME_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFRAME.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim ifrm As Integer = ddl.SelectedValue
        HDNFRAMEID.Value = ifrm
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select FrameName From FrameList Where FrameID=" & ifrm, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        LBLFN.Text = dr("FrameName")
        dbConnection.Close()
        LBLDT.Text = Format(Now(), "dd/MM/yy")
    End Sub
End Class
