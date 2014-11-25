
Partial Class debits
    Inherits System.Web.UI.Page
    Dim tot(0 To 1) As Double

    Protected Sub ddlmonths_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlmonths.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            Dim d As DateTime = DateAdd(DateInterval.Month, -2, CDate(DatePart(DateInterval.Year, Today) & "-" & DatePart(DateInterval.Month, Today) & "-1"))

            Dim li As ListItem = ddl.Items.FindByText(Format(d, "MMM-yy"))
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub
    Function val(ByVal sF As String, ByVal sFR As String, ByVal i As Integer) As String
        Dim d As Double
        Try
            d = Eval(sF)
        Catch ex As Exception
            d = 0
        End Try
        tot(i) = tot(i) + d
        Return Format(d, sFR)
    End Function
    Function tval(ByVal sFR As String, ByVal i As Integer) As String
        Return Format(tot(i) * If(i = 0, 0.5, 1), sFR)
    End Function

    Protected Sub DSDEBIT_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSDEBIT.Selecting
        Dim d As DateTime = CDate(ddlmonths.SelectedItem.Text)
        e.Command.Parameters("@PDate").Value = d
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Dim gvr As GridViewRow = e.Row
        Dim lbl As Label = CType(gvr.FindControl("lblframe"), Label)
        If lbl IsNot Nothing Then
            If lbl.Text = vbNullString Then
                gvr.BackColor = Drawing.Color.Silver
            End If
        End If
    End Sub

    Protected Sub lblsum_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim dtot As Double
        Dim gvr As GridViewRow = CType(lbl.NamingContainer, GridViewRow)
        Dim gv As GridView = CType(gvr.NamingContainer, GridView)
        If lbl.Text = vbNullString And gvr.BackColor = Drawing.Color.Silver Then
            Dim i As Integer = gvr.RowIndex
            Try
                i = i + 1
                gvr = gv.Rows(i)
                While gvr IsNot Nothing And gvr.BackColor <> Drawing.Color.Silver And i < gv.Rows.Count
                    Dim lbl1 As Label = CType(gvr.FindControl("lblsum"), Label)
                    dtot = dtot + CDbl(Replace(lbl1.Text, ",", ""))
                    i = i + 1
                    gvr = gv.Rows(i)
                End While
            Catch ex As Exception

            End Try

            lbl.Text = Format(dtot, "#,###")
        End If

    End Sub
End Class
