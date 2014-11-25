
Partial Class PageHeader
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
    Private _ButtonJava As String
    Public Property ButtonJava() As String
        Get
            Return _ButtonJava
        End Get
        Set(ByVal Value As String)
            _ButtonJava = Value
            btnbck.Visible = _ButtonJava <> vbNullString
        End Set
    End Property
    Private _ButtonText As String
    Public Property ButtonText() As String
        Get
            Return _ButtonText
        End Get
        Set(ByVal Value As String)
            _ButtonText = Value
         End Set
    End Property
    Private _Width As Unit
    Public Property Width() As Unit
        Get
            Return _Width
        End Get
        Set(ByVal Value As Unit)
            _Width = Value
        End Set
    End Property


    Protected Sub lblDate_PreRender(sender As Object, e As System.EventArgs) Handles lblDate.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(Now(), "dd/MM/yyyy")
    End Sub

    Protected Sub lblUsername_PreRender(sender As Object, e As System.EventArgs) Handles lblUsername.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Session("UserName")
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        btnbck.Visible = ButtonJava <> vbNullString
    End Sub

    Protected Sub btnbck_PreRender(sender As Object, e As System.EventArgs) Handles btnbck.PreRender
        If ButtonJava <> vbNullString Then
            btnbck.Visible = True
            btnbck.Attributes.Add("onclick", ButtonJava)
        End If
        If ButtonText <> vbNullString Then
            btnbck.Attributes.Add("value", ButtonText)
        Else
            btnbck.Attributes.Add("value", "סגור")
        End If
    End Sub
End Class
