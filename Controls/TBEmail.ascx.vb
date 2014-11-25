
Partial Class TBEmail
    Inherits System.Web.UI.UserControl
    Private _CSSClass As String
    Public Property CSSClass() As String
        Get
            Return _CSSClass
        End Get
        Set(ByVal Value As String)
            _PhoneType = CSSClass
        End Set
    End Property
    Private _TabIndex As Integer
    Public Property TabIndex() As Integer
        Get
            Return _TabIndex
        End Get
        Set(ByVal Value As Integer)
            _TabIndex = Value
        End Set
    End Property
    Private _Width As Integer
    Public Property Width() As Integer
        Get
            Return _Width
        End Get
        Set(ByVal Value As Integer)
            _Width = Value
        End Set
    End Property
    Private _PhoneType As String
    Public Property PhoneType() As String
        Get
            Return _PhoneType
        End Get
        Set(ByVal Value As String)
            _PhoneType = Value
        End Set
    End Property

    Private _Text As String
    Public Property Text() As String
        Get
            Return If(_Text Is Nothing, ViewState(Me.ID & "Text"), _Text)
        End Get
        Set(ByVal Value As String)
            _Text = Value
            ViewState(Me.ID & "Text") = Value
        End Set
    End Property


    Private _Domain As String
    Public Property Domain() As String
        Get
            Return _Domain
        End Get
        Set(ByVal Value As String)
            _Domain = Value
        End Set
    End Property

    Private _Required As Boolean
    Public Property Required() As Boolean
        Get
            Return _Required
        End Get
        Set(ByVal Value As Boolean)
            _Required = Value
        End Set
    End Property

    Private _Enabled As Boolean = True
    Public Property Enabled() As Boolean
        Get
            Return _Enabled
        End Get
        Set(ByVal Value As Boolean)
            _Enabled = Value
        End Set
    End Property

    Protected Sub zzztbemail1_DataBinding(sender As Object, e As System.EventArgs) Handles zzztbemail1.DataBinding
        Dim tb As TextBox = CType(sender, TextBox)
        tb.CssClass = CSSClass()
        tb.TabIndex = TabIndex
        If Width <> 0 Then tb.Width = (Width - 18) / 2 - 3
        If InStr(Text, "@") > 0 Then
            Dim s As String = Left(Text, InStr(Text, "@") - 1)
            tb.Text = s
        End If
    End Sub

    Protected Sub zzztbemail2_DataBinding(sender As Object, e As System.EventArgs) Handles zzztbemail2.DataBinding
        Dim tb As TextBox = CType(sender, TextBox)
        tb.CssClass = CSSClass()
        tb.TabIndex = TabIndex + 1
        If Width <> 0 Then tb.Width = (Width - 16) / 2
        If InStr(Text, "@") > 0 Then
            Dim s As String = Mid(Text, InStr(Text, "@") + 1)
            tb.Text = s
        ElseIf Domain <> vbNullString Then
            tb.Text = Domain
        End If
    End Sub

    Protected Sub zzztbemail_TextChanged(sender As Object, e As System.EventArgs) Handles zzztbemail1.TextChanged, zzztbemail2.TextChanged
        Text = zzztbemail1.Text & "@" & zzztbemail2.Text
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub zzztbemail_PreRender(sender As Object, e As System.EventArgs) Handles zzztbemail1.PreRender, zzztbemail2.PreRender
        Dim tb As TextBox = CType(sender, TextBox)
        tb.Enabled = Enabled
    End Sub
End Class
