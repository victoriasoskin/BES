
Partial Class p3aFeedBack
    Inherits System.Web.UI.Page

    Protected Sub LBDATE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LBDATE.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Now()
    End Sub

    Protected Sub DVFB_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVFB.PreRender
        Dim dv As DetailsView = CType(sender, DetailsView)
        Dim lbl As Label = CType(dv.FindControl("LBLPROJNAME"), Label)
        lbl.Text = Request.QueryString("ProjName")
        lbl = CType(dv.FindControl("LBLUSERName"), Label)
        lbl.Text = Session("uSERnAME")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim s As String = Request.QueryString("SFeedback")
            If Left(s, 4) = "===>" Then s = Mid(s, 5)
            If s <> vbNullString Then
                If Left(s, 4) <> "ъщ- " Then
                    s = "ъщ- " & s
                End If
                Dim tb As TextBox = CType(DVFB.FindControl("TBSub"), TextBox)
                tb.Text = s
            End If

        End If
        If Request.QueryString("FBID") <> 0 Then
            DVFB.DefaultMode = DetailsViewMode.Edit
        End If

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect("~/p3aProject.aspx?projID=" & Request.QueryString("ProjID"))
    End Sub
End Class
