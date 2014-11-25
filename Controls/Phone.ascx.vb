
Partial Class Phone
    Inherits System.Web.UI.UserControl
    Private _CSSClass As String
    Public Property CSSClass() As String
        Get
            Return _CSSClass
        End Get
        Set(ByVal Value As String)
            _CSSClass = Value
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

    Protected Sub zzzdsEH_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles zzzdsEH.Selecting
        If PhoneType IsNot Nothing Then
            Select Case PhoneType().ToLower
                Case "cell"
                    e.Command.Parameters("@Typ").Value = 1
                Case "line"
                    e.Command.Parameters("@Typ").Value = 0
            End Select
        End If
    End Sub

    Protected Sub zzzEH_DataBound(sender As Object, e As System.EventArgs) Handles zzzEH.DataBinding
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.CssClass = CSSClass
        ddl.TabIndex = TabIndex
        If Width <> 0 Then ddl.Width = 50
        If InStr(Text, "-") > 0 Then
            Dim s As String = Left(Text, InStr(Text, "-") - 1)
            Dim li As ListItem = ddl.Items.FindByValue(s)
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub

    Protected Sub zzztbPhone_DataBinding(sender As Object, e As System.EventArgs) Handles zzztbPhone.DataBinding
        Dim tb As TextBox = CType(sender, TextBox)
        tb.CssClass = CSSClass()
        tb.TabIndex = TabIndex + 1
        If Width <> 0 Then tb.Width = Width - 55
        If InStr(Text, "-") > 0 Then
            Dim s As String = Mid(Text, InStr(Text, "-") + 1)
            tb.Text = s
        End If
    End Sub

    Protected Sub zzzEH_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles zzzEH.SelectedIndexChanged
        Text = zzzEH.SelectedValue & "-" & zzztbPhone.Text
    End Sub

    Protected Sub zzztbPhone_TextChanged(sender As Object, e As System.EventArgs) Handles zzztbPhone.TextChanged
        Text = zzzEH.SelectedValue & "-" & zzztbPhone.Text
    End Sub

    Protected Sub RFV_PreRender(sender As Object, e As System.EventArgs) Handles zzzRFVPhone.PreRender, rfvEH.PreRender
        Dim rfv As RequiredFieldValidator = CType(sender, RequiredFieldValidator)
        rfv.Enabled = Required And Enabled
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
    End Sub

    Protected Sub zzzEH_PreRender(sender As Object, e As System.EventArgs) Handles zzzEH.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.Enabled = Enabled
    End Sub

    Protected Sub zzztbPhone_PreRender(sender As Object, e As System.EventArgs) Handles zzztbPhone.PreRender
        Dim tb As TextBox = CType(sender, TextBox)
        tb.Enabled = Enabled
    End Sub
End Class
