Imports System.Data.SqlClient
Partial Class Default5
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim iFrame As Integer = Session("FrameID")
        Dim iReptype As Integer = 2
        Dim s As String = "Select count(FrameID) as cnt from p4t_DontShowRep Where FrameID=" & iFrame & ",ReptypeID=" & iReptype
        Dim ConComp As New SqlCommand("Select count(RowID) as cnt from p4t_DontShowRep Where FrameID=" & iFrame & " And ReptypeID=" & iReptype, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        Dim i As Integer = dr("cnt")
        dr.Close()
        dbConnection.Close()
        If i > 0 Then
            Response.Redirect("p3aDontShowMessage.aspx")
        End If
        LBLTODAY.Text = Format(Now(), "dd/MM/yy")
    End Sub
    Function hdrt(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWY.SelectedValue, DateTime)
        Return Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M")
    End Function
    Function vald(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWY.SelectedValue, DateTime)
        On Error Resume Next
        Dim s As String = Eval(Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M"))
        If Len(s) = 0 Or Err.Number <> 0 Then
            Return vbNullString
        Else
            Return Format(Int(s), "#0;#-")
        End If
    End Function
    Protected Sub LBLSUMDIFF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim lbl1 As Label = CType(gvr.FindControl("LBLTYPE"), Label)
        Dim i As Integer
        Dim j As Integer
        Dim k As Integer = 0
        If lbl1.Text = "הפרש" Then
            For i = 1 To 12
                lbl1 = CType(gvr.FindControl("LBLS" & i), Label)
                If lbl1.Text <> vbNullString Then j = Int(lbl1.Text) Else j = 0
                k = k + j
            Next
            lbl.Text = Format(k, "#;#-")
            If k >= 0 Then
                lbl.BackColor = Drawing.Color.LightGreen
                lbl.ForeColor = Drawing.Color.Black
            Else
                lbl.BackColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub LBLFRAME_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim lbl1 As Label = CType(gvr.FindControl("LBLTYPE"), Label)
        If lbl1.Text <> "יעד" Then lbl.Text = vbNullString
    End Sub

    Protected Sub DDLWY_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLWY.PreRender
    End Sub

    Protected Sub DSSvA_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSSvA.Selecting
        Dim i As Integer
        For i = 0 To e.Command.Parameters.Count - 1
            Dim sp As String = e.Command.Parameters(i).ToString
            Dim sv As String = e.Command.Parameters(i).Value
        Next
        e.Command.CommandTimeout = 300
    End Sub
End Class

