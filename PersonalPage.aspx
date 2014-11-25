<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="PersonalPage.aspx.vb" Inherits="PersonalPage" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit.HTMLEditor" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="phdrdiv">
    בדיקת עריכת טקסט</div>
<div>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
   
            <cc1:Editor ID="Editor1" runat="server" Height="300px" Width="500px" />
            <asp:Label runat="server" ID="lblt" />

    <asp:SqlDataSource ID="SqlDataSource1" runat="server"  
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [ttt] FROM [texttab]"></asp:SqlDataSource>
   
</div> 
</asp:Content>

