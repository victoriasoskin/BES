Imports WRCookies
Partial Class TTFStart
    Inherits System.Web.UI.Page

    Private Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Request.QueryString("T") Is Nothing Then Response.Redirect("CustEventReport")
        Dim s As String = Request.QueryString("T")
        s = s.Replace("@", "&")
        Dim sDel As String = "?"
        If InStr(s, "?") > 0 Then
            sDel = "&"
        End If

        If Request.QueryString("ID") IsNot Nothing Then
            s &= sDel & "ID=" & Request.QueryString("ID")
            sDel = "&"
        End If

        s &= sDel & "CID=" & Session("lastCustID")
        sDel = "&"
        Dim sXA As String = If(Session("FrameID") IsNot Nothing, Session("FrameID"), ReadCookie_S("RUS_FrameID"))
        s &= sDel & "F=" & sXA

        s &= sDel & "E=" & Session("UserID") * 62

        Response.Redirect(s)

    End Sub
End Class
