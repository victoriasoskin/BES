Imports System.Data

Partial Class CSTCOUNT
    Inherits System.Web.UI.Page
    Dim u As UtilVB
    Dim iTT(0 To 12) As Integer
    Dim iAT(0 To 12) As Integer
    Dim iDT(0 To 12) As Integer
    Dim indR As Integer

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        u = New UtilVB()
    End Sub

    Protected Sub rblR_PreRender(sender As Object, e As EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        If Not IsPostBack Then
            If u.FrameId <> 0 Then
                Dim s As String = u.FrameYearType(u.FrameId)
                rbl.SelectedValue = If(s = "C", "0", "1")
                rbl.Visible = False
            End If
        End If
    End Sub
    Protected Sub lblSubLabel_PreRender(sender As Object, e As EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim s As String
        If u.FrameId = 0 Then
            s = If(rblR.SelectedIndex >= 0, rblR.SelectedItem.Text, vbNullString)
        Else
            s = If(u.FrameYearType(u.FrameId) = "C", "ספירת לקוחות", "ספירת כיתות ותלמידים")
        End If
        lbl.Text = s
    End Sub

    Protected Sub ddlRegions_PreRender(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.Visible = u.FrameId = 0
        ddl.Enabled = rblR.SelectedIndex >= 0
    End Sub

    Protected Sub ddlYears_PreRender(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.Enabled = rblR.SelectedIndex >= 0
        u.RemoveDDLDupItems(ddl)
        If ddl.SelectedValue = vbNullString Then
            For i As Integer = ddl.Items.Count - 1 To 1 Step -1
                If ddl.Items(i).Value = vbNullString Then Exit For
                If CDate(ddl.Items(i).Value) <= Today Then
                    ddl.ClearSelection()
                    ddl.Items(i).Selected = True
                    Exit For
                End If
            Next
        End If
    End Sub

    Protected Sub btnShow_PreRender(sender As Object, e As EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim b As Boolean = rblR.SelectedIndex >= 0
        b = b And ddlRegions.SelectedIndex > 0
        b = b Or u.FrameId <> 0
        b = b And ddlYears.SelectedIndex > 0
        btn.Enabled = b
    End Sub

    Protected Sub btnXl_PreRender(sender As Object, e As EventArgs)
        Dim btn As Button = CType(sender, Button)
        btn.Enabled = GridView1.Rows.Count > 0
    End Sub

    Protected Sub LBLFRAME_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim lbl1 As Label = CType(gvr.FindControl("LBLTYPE"), Label)
        If lbl1.Text <> "יעד" Then
            lbl.Text = vbNullString
        Else
            gvr.BackColor = Drawing.Color.WhiteSmoke
        End If
    End Sub

    Protected Sub LBLSUMDIFF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim lbl1 As Label = CType(gvr.FindControl("LBLTYPE"), Label)
        Dim i As Integer
        Dim j As Integer
        Dim k As Integer = 0
        If lbl1.Text = "הפרש" Then
            For i = 1 To 12
                lbl1 = CType(gvr.FindControl("LBLS" & i), Label)
                If lbl1.Text <> vbNullString Then j = Int(lbl1.Text) Else j = 0
                k = k + j
            Next
            lbl.Text = Format(k, "#;#-")
            If k >= 0 Then
                lbl.BackColor = Drawing.Color.LightGreen
                lbl.ForeColor = Drawing.Color.Black
            Else
                lbl.BackColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub LBLSUMDIFFT_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim i As Integer
        Dim j As Integer
        Dim k As Integer = 0
        For i = 1 To 12
            Dim lbl1 As Label = CType(gvr.FindControl("LBLDT" & i), Label)
            If lbl1.Text <> vbNullString Then j = Int(lbl1.Text) Else j = 0
            k = k + j
        Next
        lbl.Text = Format(k, "#0;#-")
        If k >= 0 Then
            lbl.BackColor = Drawing.Color.LightGreen
            lbl.ForeColor = Drawing.Color.Black
        Else
            lbl.BackColor = Drawing.Color.Red
        End If
    End Sub

    Function vald(ByVal d As Double, ByVal s As String) As String
        Dim dt As DateTime = CType(ddlYears.SelectedValue, DateTime)
        On Error Resume Next
        Dim s1 As String = Eval(Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M"))
        If Len(s1) = 0 Or Err.Number <> 0 Then
            Return vbNullString
        Else
            Dim l As Integer = Int(s1)
            If s = "יעד" Then iTT(Int(d)) += l
            If s = "בפועל" Then iAT(Int(d)) += l
            If s = "הפרש" Then iDT(Int(d)) += l
            Return Format(l, "#0;#-")
        End If
    End Function
    Function GetTotal(ByVal i As Integer, ByVal s As String) As String
        Select Case s
            Case "יעד"
                Return Format(iTT(i), "#;#-")
            Case "בפועל"
                Return Format(iAT(i), "#;#-")
            Case "הפרש"
                Return Format(iDT(i), "#;#-")
            Case Else
                Return vbNullString
        End Select
    End Function

    Function hdrt(ByVal d As Double) As String
        Dim dt As DateTime = CType(ddlYears.SelectedValue, DateTime)
        Return Format(DateAdd(DateInterval.Month, d - 1, dt), "yyyy-M")
    End Function

    Protected Sub LBLTODAY_PreRender(sender As Object, e As EventArgs)
        If Not IsPostBack Then
            Dim lbl As Label = CType(sender, Label)
            lbl.Text = Format(Today, "dd/MM/yyyy")
        End If
    End Sub

    Protected Sub btnShow_Click(sender As Object, e As EventArgs) Handles btnShow.Click
        Dim sql As String = vbNullString
        Select Case rblR.SelectedValue
            Case "0"                                ' ספירת לקוחות

                sql = "EXEC Book10_21.dbo.p2p_CustCount "
                sql &= "'" & Format(CDate(ddlYears.SelectedValue), "yyyy-MM-dd") & "',"
                sql &= "'" & Format(Today, "yyyy-MM-dd") & "',"
                sql &= If(ddlRegions.SelectedValue = vbNullString, "NULL", ddlRegions.SelectedValue) & ","
                sql &= If(u.FrameId = 0, "NULL", u.FrameId.ToString)


            Case "1"                                ' ספירת כיתות

                sql = "EXEC Book10_21.dbo.p2p_CustCount "
                sql &= "'" & Format(CDate(ddlYears.SelectedValue), "yyyy-MM-dd") & "',"
                sql &= "'" & Format(Today, "yyyy-MM-dd") & "',"
                sql &= If(ddlRegions.SelectedValue = vbNullString, "NULL", ddlRegions.SelectedValue) & ","
                sql &= If(u.FrameId = 0, "NULL", u.FrameId.ToString)

        End Select

        Dim td As DataTable = u.selectDBQuery(sql)
        GridView1.DataSource = td
        GridView1.DataBind()

    End Sub

    Protected Sub btnXl_Click(sender As Object, e As EventArgs) Handles btnXl.Click
        Dim title As String = PageHeader1.Header
        Dim lbl As Label
        Dim gvr As GridViewRow
        Dim s As String = vbNullString
        For Each gvr In GridView1.Rows
            gvr.Cells(2).Text = ConvMinus(gvr.Cells(2).Text)
            For i As Integer = 1 To 12
                lbl = CType(gvr.FindControl("LBLS" & i), Label)
                If lbl IsNot Nothing Then lbl.Text = ConvMinus(lbl.Text)
            Next
            lbl = CType(gvr.FindControl("LBLSUMDIFF"), Label)
            If lbl IsNot Nothing Then lbl.Text = ConvMinus(lbl.Text)
        Next
        gvr = GridView1.FooterRow
        If gvr.Visible Then
            lbl = CType(gvr.FindControl("LBLT2"), Label)
            If lbl IsNot Nothing Then lbl.Text = ConvMinus(lbl.Text)
            For i As Integer = 1 To 12
                lbl = CType(gvr.FindControl("LBLDT" & i), Label)
                If lbl IsNot Nothing Then lbl.Text = ConvMinus(lbl.Text)
            Next
            lbl = CType(gvr.FindControl("LBLSUMDIFFT"), Label)
            If lbl IsNot Nothing Then lbl.Text = ConvMinus(lbl.Text)
        End If

        Dim subTitle = rblR.SelectedItem.Text + " נכון ל " + Format(Today, "dd/MM/yyyy")
        Dim Style As String = ".gv th {color: red;background-color:#DDDDDD;text-align:right;direction:rtl;}"
        u.ExportGridviewIntoOffice(GridView1, "rep.xls", "excel", Style, title, subTitle)
    End Sub

    Protected Sub lblReg_PreRender(sender As Object, e As EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Visible = u.FrameId = 0
    End Sub

    Protected Sub GridView1_PreRender(sender As Object, e As EventArgs) Handles GridView1.PreRender
        Dim gvr As GridViewRow
        If GridView1.Rows.Count > 0 Then
            If rblR.SelectedValue = "0" Then
                GridView1.Columns(2).Visible = False
            ElseIf rblR.SelectedValue = "1" Then
                GridView1.Columns(2).Visible = True
                Dim Sql As String = "EXEC Book10.dbo.In_pClassCount "
                Sql &= "'" & Format(CDate(ddlYears.SelectedValue), "yyyy-MM-dd") & "',"
                Sql &= "'" & Format(Today, "yyyy-MM-dd") & "',"
                Sql &= If(ddlRegions.SelectedValue = vbNullString, "NULL", ddlRegions.SelectedValue) & ","
                Sql &= If(u.FrameId = 0, "NULL", u.FrameId.ToString)
                Dim dtx As DataTable = u.selectDBQuery(Sql)

                Dim t(0 To 2) As Integer
                If dtx.Rows.Count > 0 Then
                    Dim k As Integer = If(dtx.Rows.Count > GridView1.Rows.Count, GridView1.Rows.Count - 1, dtx.Rows.Count - 1)
                    For i As Integer = 0 To k
                        Dim j As Integer
                        If IsDBNull(dtx.Rows(i)(2)) Then j = 0 Else j = CInt(dtx.Rows(i)(2))
                        Dim sD As String = If(j < 0, Math.Abs(j).ToString & "-", j.ToString)
                        GridView1.Rows(i).Cells(2).Text = sD
                        t(i Mod 3) += j
                    Next
                End If

                gvr = GridView1.FooterRow
                Dim lbl As Label = CType(gvr.FindControl("lblt0"), Label)
                lbl.Text = t(0)
                lbl = CType(gvr.FindControl("lblt1"), Label)
                lbl.Text = t(1)
                lbl = CType(gvr.FindControl("lblt2"), Label)
                lbl.Text = If(t(2) < 0, Math.Abs(t(2)).ToString & "-", t(2).ToString)

                End If

            'gvr = New GridViewRow(0, -1, DataControlRowType.Header, DataControlRowState.Normal)

            'Dim th As New TableHeaderCell()
            'th.HorizontalAlign = HorizontalAlign.Center
            'th.ColumnSpan = 2
            'th.Font.Bold = True
            'gvr.Cells.Add(th)

            'th = New TableHeaderCell()
            'th.HorizontalAlign = HorizontalAlign.Center
            'th.ColumnSpan = 1
            'th.BackColor = Drawing.Color.LightGray
            'th.BorderColor = Drawing.Color.Blue
            'th.BorderWidth = 2
            'th.BorderStyle = BorderStyle.Solid
            'th.Font.Bold = True
            'th.Text = If(rblR.SelectedValue = "1", "כיתות", "")
            'gvr.Cells.Add(th)

            'th = New TableHeaderCell()
            'th.HorizontalAlign = HorizontalAlign.Center
            'th.ColumnSpan = GridView1.Columns.Count - 3
            'th.BackColor = Drawing.Color.LightGray
            'th.Font.Bold = True
            'th.Text = If(rblR.SelectedValue = "1", "תלמידים", "לקוחות")
            'gvr.Cells.Add(th)

            'GridView1.HeaderRow.Parent.Controls.AddAt(0, gvr)

            GridView1.FooterRow.Visible = u.FrameId = 0
        End If
    End Sub

    Protected Sub LBLD0_PreRender(sender As Object, e As EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = "כיתות<br />" & ddlYears.SelectedItem.Text
    End Sub

    Private Function ConvMinus(s As String) As String
        If InStr(s, "-") > 0 Then
            If IsNumeric(s) Then
                s = CInt(s)
            End If
        End If
        Return s
    End Function
End Class
