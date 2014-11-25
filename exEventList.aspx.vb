
Partial Class Default3
    Inherits System.Web.UI.Page
    Public Function truncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function

    Protected Sub GVList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GVList.SelectedIndexChanged

    End Sub

    Protected Sub LNKBID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As Button = CType(sender, Button)
        Session("lastCustID") = lnkb.Text
        Response.Redirect("CustEventReport.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub
    Protected Sub DDLSERVICES_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSERVICES.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If IsNumeric(Session("FrameID")) Then
            ddl.Visible = False
        End If
    End Sub

    Protected Sub DDLFRAMES_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFRAMES.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If IsNumeric(Session("FrameID")) Then
            ddl.Visible = False
        End If
    End Sub

    Protected Sub btnSA_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim tb As TextBox = CType(gvr.FindControl("TBSA"), TextBox)
        Dim lbl As Label = CType(gvr.FindControl("LBComment"), Label)
        tb.Visible = True
        lbl.Visible = False
    End Sub
End Class
