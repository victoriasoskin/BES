
Partial Class ShowOno
    Inherits System.Web.UI.Page

    Protected Sub ctl02_PreRender(sender As Object, e As System.EventArgs) Handles ctl02.PreRender
        Dim clr As String() = {"Blue", "Yellow", "Green", "Red", "LightBlue", "LightBlue", "Gray", "Orchid", "Pink", "Purple"}
        Try
            For i = 0 To 9
                ctl02.Series("Series1").Points(i).Color = System.Drawing.Color.FromName(clr(i))
            Next
        Catch ex As Exception

        End Try
        ctl02.ChartAreas(0).AxisX.LabelStyle.Angle = -60
        ctl02.ChartAreas(0).AxisX.Interval = 1
    End Sub

    Protected Sub hdnName_PreRender(sender As Object, e As System.EventArgs)
        If lblName.Text = vbNullString Then
            Dim hdn As HiddenField = CType(sender, HiddenField)
            lblName.Text = hdn.Value
        End If
    End Sub
    Protected Sub hdnMood_PreRender(sender As Object, e As System.EventArgs)
        If lblMood.Text = vbNullString Then
            Dim hdn As HiddenField = CType(sender, HiddenField)
            lblMood.Text = "מצב הרוח: " & hdn.Value
        End If
    End Sub
    Protected Sub hdnTxt_PreRender(sender As Object, e As System.EventArgs)
        If lblTxt.Text = vbNullString Then
            Dim hdn As HiddenField = CType(sender, HiddenField)
            lblTxt.Text = hdn.Value
        End If
    End Sub
    Protected Sub hdnDate_PreRender(sender As Object, e As System.EventArgs)
        If lblDate.Text = vbNullString Then
            Dim hdn As HiddenField = CType(sender, HiddenField)
            lblDate.Text = Format(CDate(hdn.Value), "dd/MM/yyyy")
        End If
    End Sub
End Class
