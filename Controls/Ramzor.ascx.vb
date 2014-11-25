
Partial Class Ramzor
    Inherits System.Web.UI.UserControl
    Private _SelectedValue As Integer
    Public Property SelectedValue() As Integer
        Get
            _SelectedValue = 0
            If zzzrb_1.Checked Then _SelectedValue = 1
            If zzzrb_2.Checked Then _SelectedValue = 2
            If zzzrb_3.Checked Then _SelectedValue = 3
            Return _SelectedValue
        End Get
        Set(ByVal Value As Integer)
            _SelectedValue = Value
            setSelectedValue(_SelectedValue)
        End Set
    End Property
    Private _OrgSelectedValue As Integer
    Public Property OrgSelectedValue() As Integer
        Get
            _OrgSelectedValue = "0" & zzzhdnS.Value
            Return _OrgSelectedValue
        End Get
        Set(ByVal Value As Integer)
            _OrgSelectedValue = Value
            zzzhdnS.Value = Value
        End Set
    End Property
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'setSelectedValue(SelectedValue)
    End Sub
    Protected Sub rb_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim rb As RadioButton = CType(sender, RadioButton)
        If rb.Checked Then
            SelectedValue = CInt(Right(rb.ID, 1))
        End If
    End Sub
    Private Sub setSelectedValue(i As Integer)
        zzzrb_1.Checked = False
        zzzrb_2.Checked = False
        zzzrb_3.Checked = False
        If i > 0 Then
            Select Case i
                Case 1
                    zzzrb_1.Checked = True
                Case 2
                    zzzrb_2.Checked = True
                Case 3
                    zzzrb_3.Checked = True
            End Select
        End If
    End Sub
    Protected Sub zzzBtnDel_Click(sender As Object, e As System.EventArgs)
        SelectedValue = 0
        setSelectedValue(0)
    End Sub
End Class
