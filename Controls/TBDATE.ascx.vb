
Partial Class Controls_EnterDate
    Inherits System.Web.UI.UserControl
    Private _DateFormat As String
    Private _OnTBFocus As String
    Public Property OnTBFocus() As String
        Get
            Return _OnTBFocus
        End Get
        Set(ByVal Value As String)
            _OnTBFocus = Value
        End Set
    End Property
    Public Property DateFormat() As String
        Get
            Return _DateFormat
        End Get
        Set(ByVal Value As String)
            _DateFormat = Value
        End Set
    End Property
    Private _TabIndex As Integer    ' TabIndex - of textBox
    Public Property TabIndex() As Integer
        Get
            Return _TabIndex
        End Get
        Set(ByVal Value As Integer)
            _TabIndex = Value
        End Set
    End Property
    Private _SelectedDate As String
    Public Property SelectedDate() As String
        Get
            Return _SelectedDate
        End Get
        Set(ByVal Value As String)
            _SelectedDate = Value
            zzztbdate.Text = If(Value = vbNullString, If(LCase(InitDate()) = "today", Format(Today(), DateFormat), InitDate), Format(CDate(Value), DateFormat))
        End Set
    End Property
    Private _InitDate As String '
    Public Property InitDate() As String
        Get
            Return _InitDate
        End Get
        Set(ByVal Value As String)
            _InitDate = Value
        End Set
    End Property
    Private _ShowCalendar As Boolean = True
    Public Property ShowCalendar() As Boolean
        Get
            Return _ShowCalendar
        End Get
        Set(ByVal Value As Boolean)
            _ShowCalendar = Value
        End Set
    End Property
    Private _AddTime As String ' "+ddmmyy" or "-ddmmyy"
    Public Property AddTime() As String
        Get
            Return _AddTime
        End Get
        Set(ByVal Value As String)
            _AddTime = Value
        End Set
    End Property

    Protected Sub zzzbtnclndr_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles zzzbtnclndr.Click
        zzzClndr.Visible = Not zzzClndr.Visible
    End Sub

    Protected Sub zzztbdate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzztbdate.TextChanged
        Dim tb As TextBox = CType(sender, TextBox)
        Dim d As DateTime
        Dim c() As Char = Trim(tb.Text)
        Dim iStat As Integer = 0      'day
        Dim sD As String = ""
        Dim sM As String = ""
        Dim sY As String = ""
        Dim s As String
         For i = 0 To c.Length - 1
            Select Case iStat
                Case 0
                    If IsNumeric(c(i)) Then
                        If sD.Length < 2 Then
                            sD = sD & CType(c(i), String)
                        Else
                            iStat += 1
                        End If
                    Else
                        iStat += 1
                    End If
                Case 1
                    If IsNumeric(c(i)) Then
                        If sM.Length < 2 Then
                            sM = sM & CType(c(i), String)
                        Else
                            iStat += 1
                        End If
                    Else
                        iStat += 1
                    End If
                Case 2
                    sY = sY & CType(c(i), String)
            End Select
        Next
        If sY.Length = 0 Then sY = CStr(DatePart(DateInterval.Year, Today))
        s = If(sY.Length <= 2, CStr(2000 + CInt("0" & sY)), sY) & "-" & sM & "-" & sD
        If IsDate(s) Then
            zzzcvdate.IsValid = True
            d = CDate(s)
            tb.Text = Format(d, DateFormat)
            SelectedDate = cCDate(tb.Text)
        Else
            zzzcvdate.IsValid = False
        End If
        If zzzcvdate.IsValid Then If zzztbdate.Text <> vbNullString Then SelectedDate = cCDate(zzztbdate.Text)
    End Sub

    Protected Sub zzzClndr_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzzClndr.SelectionChanged
        zzztbdate.Text = Format(zzzClndr.SelectedDate, DateFormat)
        zzzClndr.Visible = False
        SelectedDate = cCDate(zzztbdate.Text)
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        zzztbdate.TabIndex = TabIndex()
        zzzbtnclndr.TabIndex = TabIndex + 1
        zzzClndr.TabIndex = TabIndex + 2
        If ShowCalendar = False Then zzzbtnclndr.Visible = False
        If DateFormat = vbNullString Then DateFormat = "yyyy-MM-dd"
        Dim d As DateTime
        If SelectedDate <> vbNullString Then Exit Sub
        If zzztbdate.Text = vbNullString And InitDate <> vbNullString Then
            Select Case LCase(InitDate)
                Case "today"
                    d = Today()
                Case ""
                Case Else
                    d = CDate(InitDate)
            End Select
            If IsDate(d) And AddTime <> vbNullString Then
                Dim iSign As Integer = If(Left(AddTime, 1) = "-", -1, 1)
                d = DateAdd(DateInterval.Day, CInt(Mid(AddTime, 2, 2)) * iSign, d)
                d = DateAdd(DateInterval.Month, CInt(Mid(AddTime, 4, 2)) * iSign, d)
                d = DateAdd(DateInterval.Year, CInt(Mid(AddTime, 6, 2)) * iSign, d)
            End If
            If IsDate(d) Then zzztbdate.Text = Format(d, DateFormat)
        End If
        If zzztbdate.Text <> vbNullString Then SelectedDate = cCDate(zzztbdate.Text)
        If OnTBFocus <> vbNullString Then zzztbdate.Attributes.Add("onfocus", OnTBFocus())
        If OnTBFocus <> vbNullString Then zzzbtnclndr.Attributes.Add("onmouseover", OnTBFocus())
        OnTextChanged(New System.EventArgs)
    End Sub
    Private Function cCDate(ByVal sD As String) As String
        If sD.Length > 0 Then
            Dim sV() As String = sD.Split("/")
            Return If(sV.Length = 3, If(Len(sV(2)) = 2, If(CInt(sV(2)) > 50, "19" & sV(2), "20" & sV(2)), sV(2)) & "-" & sV(1) & "-" & sV(0), If(LCase(InitDate()) = "today", Format(Today(), DateFormat), InitDate))
        Else
            Return vbNullString
        End If
    End Function

    Protected Sub zzztbdate_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzztbdate.PreRender
        Dim tb As TextBox = CType(sender, TextBox)
        If tb.Text = vbNullString And SelectedDate <> vbNullString Then
            tb.Text = Format(CDate(SelectedDate), DateFormat)
        End If

    End Sub
    Public Event TextChanged As System.EventHandler
    Protected Overridable Sub OnTextChanged(ByVal e As System.EventArgs)
        RaiseEvent TextChanged(zzztbdate, e)
    End Sub
End Class
