
Partial Class LateEvents
    Inherits System.Web.UI.Page
    Public Function TruncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function

    Protected Sub GVList_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        'Dim dv As System.Data.DataRowView = e.Row.DataItem
        'Dim lb As Label = CType(e.Row.FindControl("LBnextDate"), Label)
        'Dim d As Date = CType(lb.Text, Date)
        'If d < Now() Then
        '    lb.ForeColor = Drawing.Color.Red
        'End If
    End Sub

    Protected Sub LBnextDate_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lb As Label = CType(sender, Label)
        Dim d As Date = CType(lb.Text, Date)
        If d < Now() Then
            lb.ForeColor = Drawing.Color.Red
        End If

    End Sub
End Class
