<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p3a_FrameDefs.aspx.vb" Inherits="p3a_FrameDefs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div><asp:Label ID="Label1" runat="server" Text="עדכון תאריכי הקפאה" 
        Font-Bold="True" Font-Size="Medium" ForeColor="#3333CC" Width="150px"></asp:Label></div>
<div><asp:SqlDataSource ID="DSFRAMES" runat="server"></asp:SqlDataSource>

</div>
</asp:Content>

 