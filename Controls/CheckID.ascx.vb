Imports System.Data.SqlClient
Partial Class Controls_CheckID
    Inherits System.Web.UI.UserControl
    Private _OnTBFocus As String
    Public Property OnTBFocus() As String
        Get
            Return _OnTBFocus
        End Get
        Set(ByVal Value As String)
            _OnTBFocus = Value
        End Set
    End Property
    Private _TableName As String    ' TableName - of ID's
    Public Property TableName() As String
        Get
            Return _TableName
        End Get
        Set(ByVal Value As String)
            _TableName = Value
        End Set
    End Property
    Private _ValidateNotExist As Boolean = True    ' TableName - of ID's
    Public Property ValidateNotExist() As Boolean
        Get
            Return _ValidateNotExist
        End Get
        Set(ByVal Value As Boolean)
            _ValidateNotExist = Value
        End Set
    End Property
    Private _FieldName As String    ' Field - Where ID is kept in "TableName"
    Public Property FieldName() As String
        Get
            Return _FieldName
        End Get
        Set(ByVal Value As String)
            _FieldName = Value
        End Set
    End Property
    Private _TabIndex As Integer    ' TabIndex - of TextBox
    Public Property TabIndex() As Integer
        Get
            Return _TabIndex
        End Get
        Set(ByVal Value As Integer)
            _TabIndex = Value
        End Set
    End Property
    Private _IsValid As Boolean    ' TabIndex - of TextBox
    Public Property IsValid() As Boolean
        Get
            Return _IsValid
        End Get
        Set(ByVal Value As Boolean)
            _IsValid = Value
        End Set
    End Property
    Public _Text As String    ' Text - ID
    Public Property Text() As String
        Get
            If _Text = vbNullString Then _Text = ViewState(Me.ID & "Text")
            Return _Text
        End Get
        Set(ByVal Value As String)
            _Text = Value
            zzztbid.Text = Value
            ViewState(Me.ID & "Text") = Value
        End Set
    End Property
    Public _RedirectProgram As String
    Public Property RedirectProgram() As String
        Get
            Return _RedirectProgram
        End Get
        Set(ByVal Value As String)
            _RedirectProgram = Value
        End Set
    End Property
    Public _RedirectField As String
    Public Property RedirectField() As String
        Get
            Return _RedirectField
        End Get
        Set(ByVal Value As String)
            _RedirectField = Value
        End Set
    End Property
    Public _IDValid As Boolean
    Public Property IDValid() As Boolean
        Get
            Return If(IsPostBack, True, _IDValid)
        End Get
        Set(ByVal Value As Boolean)
            _IDValid = Value
        End Set
    End Property
    Sub zzzCVEMPIDU_validate(ByVal sender As Object, ByVal args As ServerValidateEventArgs)
        Dim rdrctFld As String = vbNullString
        If ValidateNotExist() = True Then
            Dim cv As CustomValidator = CType(sender, CustomValidator)
            If Page.IsValid Then
                Dim l As Long = "0" & zzztbid.Text
                '    If LCase(Right(cv.ID, 1)) <> "u" Or CLng(args.Value) <> l Then
                Dim s As String = args.Value
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim conCom As New SqlCommand("select " & FieldName() & If(RedirectField <> vbNullString, "," & RedirectField, "") & " From " & TableName() & " Where " & FieldName() & "=" & s, dbConnection)
                dbConnection.Open()
                Dim dr As SqlDataReader = conCom.ExecuteReader
                args.IsValid = Not dr.Read
                IDValid = args.IsValid
                If dr.Read And RedirectField <> vbNullString Then rdrctFld = dr(RedirectField)
                dr.Close()
                dbConnection.Close()
                If args.IsValid = False Then
                    If RedirectProgram <> vbNullString Then
                        zzzbtnShwrec.Visible = True
                        ViewState("RDRCT") = RedirectProgram & If(RedirectField <> vbNullString, rdrctFld, "")
                    Else
                        zzzbtnShwrec.Visible = False
                    End If
                Else
                    zzzbtnShwrec.Visible = False
                End If
                'End If
            End If
        End If
        IDValid = args.IsValid
    End Sub

    Protected Sub zzztbid_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzztbid.TextChanged
        Text() = zzztbid.Text
    End Sub
    Public Event TextChanged As System.EventHandler
    Protected Overridable Sub OnTextChanged(ByVal e As System.EventArgs)
        RaiseEvent TextChanged(zzztbid, e)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        zzztbid.TabIndex = TabIndex()
        zzzbtnShwrec.TabIndex = TabIndex + 1
        OnTextChanged(New System.EventArgs)
        If OnTBFocus <> vbNullString Then zzztbid.Attributes.Add("onFocus", OnTBFocus())
    End Sub

    Protected Sub zzzbtnShwrec_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzzbtnShwrec.Click
        Response.Redirect(ViewState("RDRCT"))
    End Sub
    Protected Sub zzzvs_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub
End Class