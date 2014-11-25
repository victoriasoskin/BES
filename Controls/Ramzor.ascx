<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Ramzor.ascx.vb" Inherits="Ramzor" %>
<div style="white-space:nowrap;">
    <asp:RadioButton runat="server" ID="zzzrb_1" BackColor="Red" GroupName="rbl" OnCheckedChanged="rb_CheckedChanged" />
    <asp:RadioButton runat="server" ID="zzzrb_2" BackColor="Yellow" GroupName="rbl" OnCheckedChanged="rb_CheckedChanged"/>
    <asp:RadioButton runat="server" ID="zzzrb_3" BackColor="Green" GroupName="rbl" OnCheckedChanged="rb_CheckedChanged" />
    <asp:Button runat="server" ID="zzzBtnDel" Text="x" OnClick="zzzBtnDel_Click" Height="21" />
    <asp:HiddenField runat="server" ID="zzzhdnS" Value='<%# OrgSelectedValue() %>' />
</div>