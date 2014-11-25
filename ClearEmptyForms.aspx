<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ClearEmptyForms.aspx.vb" Inherits="Default2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="hdrdiv">מחיקת שאלונים ריקים</div>
<div class="container">
<br />
<br />
<asp:Button runat="server" ID="btndelete" 
		onclientclick="return confirm('האם למחוק את השאלונים הריקים?');" Text="מחיקה" 
		Width="200" Height="40" />
<br />
<asp:Label runat="server" ID="lblmsg" Text="המחיקה הסתיימה" ForeColor="Green" Visible="false" /> 
</div>
</asp:Content>

