
Partial Class Default5
    Inherits System.Web.UI.Page
    Dim ttl As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("Default2.Aspx")
        LBLTODAY.Text = Format(Now(), "dd/MM/yy")
        On Error Resume Next
        Dim i As Integer = Session("MultiFrame")
        Dim s As String = Session("frameID")
        Dim k As Integer = Len(s)
        Dim s1 As String = Session("serviceid")
        Dim l As Integer = Len(s1)

        If i = 1 Then
            Err.Clear()
            DDLSERVICES.Visible = True
            DDLFRAME.Visible = True
        End If

        Dim ddl As DropDownList = CType(DDLLDATE, DropDownList)
        Dim d As Date = CDate(Year(Now()) & "-" & Month(Now()) & "-1")
        If ddl.Items.Count = 0 Then
            ddl.Items.Clear()
            For i = 0 To 5
                d = DateAdd(DateInterval.Month, -1, d)
                Dim iL As New ListItem(Format(d, "MMM-yy"), Format(d, "yyyy-MM-dd"))
                ddl.Items.Add(iL)
            Next
            ddl.ClearSelection()
            ddl.SelectedIndex = 1
        End If


    End Sub
    Function scnt() As String
        Dim i As Integer = Eval("CNT")
        ttl += i
        Return CStr(i)
    End Function
    Function stotal() As String
        Return CStr(ttl)
    End Function

    Protected Sub DDLLDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLLDATE.PreRender
        'Dim ddl As DropDownList = CType(sender, DropDownList)
        'Dim d As Date = CDate(Year(Now()) & "-" & Month(Now()) & "-" & 1)
        'Dim i As Integer
        'If ddl.Items.Count = 0 Then
        '    ddl.Items.Clear()
        '    For i = 0 To 5
        '        d = DateAdd(DateInterval.Month, -1, d)
        '        Dim iL As New ListItem(Format(d, "MMM-yy"), d)
        '        ddl.Items.Add(iL)
        '    Next
        'End If
    End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles Button1.Click
        GridView1.DataSourceID = "DSCUSTNOTPAID"
        GridView1.DataBind()
    End Sub
    Protected Sub lnkb_Click(sender As Object, e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)


        Dim gv As GridView = CType(lnkb.NamingContainer.NamingContainer, GridView)
        For Each gvrx As GridViewRow In gv.Rows
            Dim dlx As DataList = CType(gvrx.FindControl("dlnpd"), DataList)
            If dlx IsNot Nothing Then dlx.Visible = False
        Next
        Dim gvr As GridViewRow = CType(lnkb.NamingContainer, GridViewRow)
        Dim dl As DataList = CType(gvr.FindControl("dlnpd"), DataList)

        dsnpd.SelectParameters("CustomerID").DefaultValue = gvr.Cells(1).Text
        Dim hdn As HiddenField = CType(gvr.FindControl("hdnframeid"), HiddenField)
        dsnpd.SelectParameters("FrameID").DefaultValue = hdn.Value
        dl.Visible = True
        dl.DataBind()


    End Sub
End Class


