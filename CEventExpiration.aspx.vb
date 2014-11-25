Imports System.Data
Imports System.IO
Imports WRCookies

Partial Class CEE
    Inherits System.Web.UI.Page
    Dim bExcel As Boolean = False
    Dim sQstory As String = vbNullString
    Public Function truncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function

    Protected Sub LNKBID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As Button = CType(sender, Button)
        Session("lastCustID") = lnkb.Text
        Response.Redirect("CustEventReport.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim sQuery As String = Request.QueryString.ToString

        ' Session parameter autocall is there Allow data bind on load (cancel select on null parameter = false)

        If ReadCookie_S("CEE_AutoCall") = "1" Then
            DSEvents.CancelSelectOnNullParameter = False
            WriteCookie_S("CEE_AutoCall", Nothing)
        ElseIf Request.QueryString("o") <> vbNullString Then
            WriteCookie_S("CEE_" & ddlServices.ID, Request.QueryString("s"))
            WriteCookie_S("CEE_" & ddlFrames.ID, Request.QueryString("f"))
            WriteCookie_S("CEE_" & DDLEVENTTYPE.ID, Request.QueryString("e"))
            WriteCookie_S("CEE_" & DDLLISTTYPE.ID, Request.QueryString("o"))
            WriteCookie_S("CEE_AutoCall", "1")
            Response.Redirect("CEventExpiration.Aspx" & "?" & sQuery)
        End If

    End Sub
 
    Protected Sub lblexp_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Try
            Dim d As DateTime = lbl.Text
            If d <= Today() Then
                lbl.BackColor = Drawing.Color.Yellow
            ElseIf DateDiff(DateInterval.Day, Today(), d) < 14 Then
                lbl.ForeColor = Drawing.Color.Purple
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click

        'Build Query

        sQstory &= If(tbSearch.Text = vbNullString, vbNullString, "<b>שם הלקוח או ת. זהות שלו מכילים: </b>" & tbSearch.Text)
        ViewState("lblhdr") = sQstory
        DSEvents.CancelSelectOnNullParameter = False
        'GVList.DataSource = DSEvents
        GVList.DataBind()

    End Sub
    Protected Sub gridView_PageIndexChanging(ByVal sender As Object, ByVal e As GridViewPageEventArgs) Handles GVList.PageIndexChanging
        DSEvents.CancelSelectOnNullParameter = False
    End Sub

    Protected Sub gridView_Sorting(ByVal sender As Object, ByVal e As GridViewSortEventArgs) Handles GVList.Sorting
        DSEvents.CancelSelectOnNullParameter = False
    End Sub
    Protected Sub btnExcel_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        doExcel("Rep.xls", GVList)
    End Sub
#Region "Excel"
    Sub doExcel(sF As String, gv As GridView)

        ''Dim tw As New StringWriter()
        ''Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        ''Dim frm As HtmlForm = New HtmlForm()
        ''Response.ContentType = "application/vnd.ms-excel"
        ''Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        ''Response.Charset = ""
        ''EnableViewState = False
        ''Controls.Add(frm)
        ''frm.Controls.Add(gv)
        ' ''     frm.Controls.Add(lblfltr)
        ''frm.RenderControl(hw)
        ''Response.Write(tw.ToString())
        ''Response.End()
        ' ''gv.DataBind()
        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        lblhdr.Text = "<span style=""font-size:Large;"">דוח תוקף פעולות</span><br />" & ViewState("lblhdr")
        'Dim lbl As Label = CType(dlist.Items(0).FindControl("LBLREPH"), Label)
        'lbl.Text = "<span style=""font-size:Large;"">" & lbl.Text & "</span><br />"
        'frm.Controls.Add(lbl)
        'lblhdr.Text = ViewState("lblhdr")
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
        'gv.DataBind()
    End Sub

#End Region

    Protected Sub ddl_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlServices.SelectedIndexChanged, ddlFrames.SelectedIndexChanged, DDLEVENTTYPE.SelectedIndexChanged, DDLLISTTYPE.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        WriteCookie_S("CEE_" & ddl.ID, ddl.SelectedValue)
    End Sub
    Protected Sub ddl_PreRender(sender As Object, e As System.EventArgs) Handles ddlServices.PreRender, ddlFrames.PreRender, DDLEVENTTYPE.PreRender, DDLLISTTYPE.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If Request.QueryString("o") = vbNullString Then
            Dim s As String = ReadCookie_S("CEE_" & ddl.ID)
            If s <> vbNullString Then
                Dim li As ListItem = ddl.Items.FindByValue(s)
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                End If
            End If
        End If
        RemoveDDLDupItems(ddl)
        If ddl.Equals(ddlFrames) Or ddl.Equals(ddlServices) Then
            If ddl.Items.Count = 2 Then ddl.Items.RemoveAt(0)
        End If
    End Sub
    Sub RemoveDDLDupItems(ByRef ddl As DropDownList)
        Dim cItems As New Microsoft.VisualBasic.Collection
        Dim cItems2Delete As New Microsoft.VisualBasic.Collection
        For i As Integer = 0 To ddl.Items.Count - 1
            Try
                cItems.Add(ddl.Items(i).Value, ddl.Items(i).Value)
            Catch ex As Exception
                cItems2Delete.Add(i)
            End Try
        Next
        For i = cItems2Delete.Count To 1 Step -1
            ddl.Items.RemoveAt(cItems2Delete(i))
        Next
    End Sub
End Class
