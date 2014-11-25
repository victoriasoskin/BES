
Partial Class ADD
    Inherits System.Web.UI.Page
    Dim tot As Double
    Dim iRow As Integer = -2
    Dim NewiRow As Integer
    Dim iCnt As Integer
    Protected Sub LinkButton1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        On Error Resume Next
        Const sAm As String = "AMode="
        Dim s2 As String
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        Dim gvr As GridViewRow = CType(lnkb.NamingContainer, GridViewRow)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNACCOUNTKEY"), HiddenField)
        Dim l As Long = hdn.Value
        If Err.Number < 0 Then
            Err.Clear()
            l = 0
        End If
        hdn = CType(gvr.FindControl("HDNPDATE"), HiddenField)
        Dim s As String = Page.ClientQueryString
        Dim i As Integer = InStr(s, sAm)
        Dim s1 As String
        Dim iM As Integer
        If i = 0 Then
            If l = 0 Then
                hdn = CType(gvr.FindControl("HDNACCOUNTNAME"), HiddenField)
                s2 = hdn.Value
                s1 = "&AccountName=" & s2 & "&" & sAm & 1
            Else
                s1 = "&AccountKey=" & Format(l, "#") & "&" & sAm & 1
            End If
        Else
            s1 = "&PDate=" & Format(CDate(hdn.Value), "yyyy-MM-dd")
            iM = Val(Mid(s, i + Len(sAm), 1))
            If iM = 1 Then s = Left(s, Len(s) - 1) & 2
        End If
        If iM < 2 Then lnkb.PostBackUrl = "ADD.ASPX?" & s & s1

    End Sub
    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        On Error Resume Next
        Dim gv As GridView = CType(sender, GridView)
        Dim i As Integer = Request.QueryString("AMode")
        If Err.Number <> 0 Then
            Err.Clear()
            i = 0
        End If
        Select Case i
            Case 0
                gv.Columns(0).Visible = True
                gv.Columns(5).Visible = False
                gv.Columns(6).Visible = False
            Case 1
                gv.Columns(0).Visible = True
                gv.Columns(5).Visible = True
                gv.Columns(6).Visible = False
            Case 2
                gv.Columns(0).Visible = False
                gv.Columns(5).Visible = True
                gv.Columns(6).Visible = True
        End Select
    End Sub
    Function v(ByVal s As String) As String
        Dim d As Double = Eval(s)
        If NewiRow > iRow Then
            tot = tot + d
            iRow = NewiRow
        End If
        Return Format(d, "#,###.00")
    End Function
    Function tv() As String
        Return Format(tot, "#,###.00")
    End Function

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        NewiRow = e.Row.RowIndex
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        On Error Resume Next
        Dim s As String = Request.QueryString("FRAME")
        LBLFRAME.Text = s
        s = Request.QueryString("SUBJECT")
        LBLJOB.Text = s
        Dim d As DateTime = CDate(Request.QueryString("PDATE"))
        Dim d1 As DateTime
        If d < CDate("2000-1-1") Or Err.Number <> 0 Then
            Err.Clear()
            d = CDate(Request.QueryString("DateS"))
            d1 = CDate(Request.QueryString("DateB"))
        Else
            d1 = d
        End If
        LBLFDATE.Text = Format(d, "MMM-yy")
        LBLTDATE.Text = Format(d1, "MMM-yy")

    End Sub
End Class
