<%@ Page Language="VB" MasterPageFile="~/Sherut.master" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;
    <script runat="server">
    
        Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
            Session.Abandon()
            Session("Backto") = "Default.aspx" '"asp.Default_aspx"
            Response.Redirect("~/Entry.aspx")
        End Sub
</script>
</asp:Content>

 