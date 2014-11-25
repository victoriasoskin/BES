
Partial Class SurveyHeader
    Inherits System.Web.UI.UserControl
    Private _Header As String
    Public Property Header() As String
        Get
            Return _Header
        End Get
        Set(ByVal Value As String)
            _Header = Value
            lblhdr.Text = Header
        End Set
    End Property
    Private _FormNumber As String
    Public Property FormNumber() As Integer
        Get
            Return _FormNumber
        End Get
        Set(ByVal Value As Integer)
            _FormNumber = Value
            If FormNumber <> 0 Then
                lblFormNumber.Text = FormNumber
                lblFormHdrNumber.Visible = True
            Else
                lblFormHdrNumber.Visible = False
            End If
        End Set
    End Property
    Protected Sub lblDate_PreRender(sender As Object, e As System.EventArgs) Handles lblDate.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(Now(), "dd/MM/yyyy")
    End Sub
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
    End Sub
End Class
