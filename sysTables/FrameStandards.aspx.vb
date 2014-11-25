Imports System.Data.SqlClient
Partial Class FrameStandards
    Inherits System.Web.UI.Page
    Function hdrt(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        Return Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M")
    End Function
    Function vald(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        Return Eval(Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M")) & vbNullString
    End Function

    Protected Sub TBS_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim i As Integer
        Dim tb As TextBox = CType(sender, TextBox)
        Dim sTB As String = Left(tb.ID, 3)
        Dim gvr As GridViewRow = CType(tb.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLFRAME"), Label)
        Dim k As Integer = CDbl(Mid(tb.ID, 4))
        Dim dt0 As DateTime = CType(DDLWORKYEAR.SelectedValue, DateTime)
        Dim j As Integer = Int(tb.Text)
        Dim s As String = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("p2p_storestandards", dbConnection)
        ConComp.CommandType = Data.CommandType.StoredProcedure
        dbConnection.Open()
        For i = k To 12
            Dim dt As DateTime = DateAdd(DateInterval.Month, CDbl(i) - 1, dt0)
            ConComp.Parameters.Clear()
            ConComp.Parameters.AddWithValue("SDate", dt)
            ConComp.Parameters.AddWithValue("FrameName", s)
            ConComp.Parameters.AddWithValue("IM0", j)
            tb = CType(gvr.FindControl(sTB & i), TextBox)
            tb.Text = j
            ConComp.ExecuteNonQuery()
        Next
        dbConnection.Close()
    End Sub

    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        On Error Resume Next
        Dim i As Integer
        Dim s As String
        If IsPostBack Then
            If Not Session("ROWNUM") Is Nothing Then
                i = Int(Session("ROWNUM"))
            Else
                Exit Sub
            End If
            If Not Session("MONNUM") Is Nothing Then
                s = Int(Session("MONNUM"))
            Else
                Exit Sub
            End If
            Dim gv As GridView = GridView1
            Dim gvr As GridViewRow = CType(gv.Rows(i), GridViewRow)
            Dim j As Integer = Int(Mid(s, 4))
            If j < 12 Then j = j + 1 Else j = 1
            s = Left(s, 3) & j
            Dim tb As TextBox = gvr.FindControl(s)
            If Err.Number <> 0 Then
                Err.Clear()
                Exit Sub
            End If
            SetFocus(tb)
        Else
            Session("ROWNUM") = vbNullString
            Session("MONNUM") = vbNullString
        End If


    End Sub
End Class
