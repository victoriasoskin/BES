Imports System.IO
Partial Class RSRCHREP
    Inherits System.Web.UI.Page

    Protected Sub btnShow_Click(sender As Object, e As System.EventArgs) Handles btnShow.Click
        If rblrep.SelectedValue <> vbNullString Then
            DSREP.SelectCommand = rblrep.SelectedValue
            lblhdr.Text = rblrep.SelectedItem.Text
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub btnEXL_Click(sender As Object, e As System.EventArgs) Handles btnEXL.Click
        If GridView1.Rows.Count >= 1 Then
            doExcel("REP.XLS", lblhdr, GridView1)
        End If
    End Sub
    Sub doExcel(sF As String, lblhdr As WebControls.Label, gv As GridView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        'frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write("<!DOCTYPE html PUBLIC " & Chr(34) & "-//W3C//DTD XHTML 1.0 Transitional//EN" & Chr(34) & " " & Chr(34) & _
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" & Chr(34) & ">" & vbCrLf & _
        "<html xmlns=" & Chr(34) & "http://www.w3.org/1999/xhtml" & Chr(34) & ">" & vbCrLf & _
        "<head>" & vbCrLf & _
        "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" & vbCrLf & _
        "</head><body>")
        Response.Write(tw.ToString())
        Response.Write("</Body></html>")
        Response.End()
        'gv.DataBind()
    End Sub
End Class
