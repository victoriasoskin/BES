<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="RSRCHREP.aspx.vb" Inherits="RSRCHREP" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="phdrdiv"><asp:Label runat="server" ID="lblhdr">דוח מערכת</asp:Label></div>
<asp:DropDownList runat="server" ID="rblrep" DataSourceID="DSREPLIST" 
        DataTextField="OpherName" DataValueField="OpherQuery" AppendDataBoundItems="true">
        <asp:ListItem Value="">בחר דוח</asp:ListItem>
 </asp:DropDownList>
<asp:Button runat="server" ID="btnShow" Text="הצג" />
    <asp:Button ID="btnEXL" runat="server" Text="XL" />
    <asp:GridView ID="GridView1" runat="server" DataSourceID="DSREP">
    </asp:GridView>
    <asp:SqlDataSource ID="DSREPLIST" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [OpherName], [OpherQuery] FROM [OpherReps]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSREP" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        ></asp:SqlDataSource>
</asp:Content>

