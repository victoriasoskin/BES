<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TBEmail.ascx.vb" Inherits="TBEmail" %>
<div style="white-space:nowrap;padding:0px;">
    <asp:RegularExpressionValidator runat="server" ID="rgexp1" ForeColor="Red" ControlToValidate="zzztbemail1" ErrorMessage="כתובת לא חוקית" ValidationExpression="\w+([-+.']\w+)*" Display="Dynamic" />
    <asp:RegularExpressionValidator runat="server" ID="rgexp2" ForeColor="Red" ControlToValidate="zzztbemail2" ErrorMessage="כתובת לא חוקית" ValidationExpression="\w+([-.]\w+)*\.\w+([-.]\w+)*"  Display="Dynamic" />
    <asp:TextBox runat="server" ID="zzztbemail2"  style="border:2px inset #EEEEEE;" />@<asp:TextBox runat="server" ID="zzztbemail1" style="border:2px inset #EEEEEE;" />
</div>