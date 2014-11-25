Imports PageErrors
Partial Class Default5
    Inherits System.Web.UI.Page
    Dim iTT(0 To 11) As Integer
    Dim iAT(0 To 12) As Integer
    Dim iDT(0 To 12) As Integer
    Dim indR As Integer

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LBLTODAY.Text = Today()
    End Sub
    Function hdrt(ByVal d As Double) As String
        Dim dt As DateTime = CType(DDLWY.SelectedValue, DateTime)
        Return Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M")
    End Function
    Function vald(ByVal d As Double, ByVal s As String) As String
        Dim dt As DateTime = CType(DDLWY.SelectedValue, DateTime)
        On Error Resume Next
        Dim s1 As String = Eval(Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M"))
        If Len(s1) = 0 Or Err.Number <> 0 Then
            Return vbNullString
        Else
            Dim l As Integer = Int(s1)
            If s = "יעד" Then iTT(Int(d) - 1) += l
            If s = "בפועל" Then iAT(Int(d) - 1) += l
            If s = "הפרש" Then iDT(Int(d) - 1) += l
            Return Format(l, "#0;#-")
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
    Protected Sub LBLSUMDIFFT_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim i As Integer
        Dim j As Integer
        Dim k As Integer = 0
        For i = 1 To 12
            Dim lbl1 As Label = CType(gvr.FindControl("LBLDT" & i), Label)
            If lbl1.Text <> vbNullString Then j = Int(lbl1.Text) Else j = 0
            k = k + j
        Next
        lbl.Text = Format(k, "#0;#-")
        If k >= 0 Then
            lbl.BackColor = Drawing.Color.LightGreen
            lbl.ForeColor = Drawing.Color.Black
        Else
            lbl.BackColor = Drawing.Color.Red
        End If
    End Sub

    Protected Sub LBLFRAME_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim lbl1 As Label = CType(gvr.FindControl("LBLTYPE"), Label)
        If lbl1.Text <> "יעד" Then lbl.Text = vbNullString
    End Sub
    Function GetTotal(ByVal i As Integer, ByVal s As String) As String
        Select Case s
            Case "יעד"
                Return Format(iTT(i - 1), "#;#-")
            Case "בפועל"
                Return Format(iAT(i - 1), "#;#-")
            Case "הפרש"
                Return Format(iDT(i - 1), "#;#-")
            Case Else
                Return vbNullString
        End Select
    End Function
End Class