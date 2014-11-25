<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TreeDropDown.ascx.vb" Inherits="TreeDropDown" %>
<div dir="rtl">
	<table style="border-style:inset;border-width:thin;border-color:Gray;">
		<tr>
			<td valign="top">
				<asp:Label runat="server" ID="zzzlblCurrentSelectionText" Height="16px" EnableViewState="true" />
				<asp:HiddenField runat="server" ID="zzzhdnCurrentSelectionValue" />
				<asp:HiddenField ID="zzzSaveTableName" runat="server" />
				<asp:HiddenField ID="zzzhdnDepth" runat="server" />
				<asp:TreeView  ID="zzztvDropDown"  ExpandDepth="0" PopulateNodesFromClient="true"  ShowLines="true" SelectedNodeStyle-BackColor="CadetBlue" SelectedNodeStyle-ForeColor="White" ShowExpandCollapse="true"   runat="server"   LineImagesFolder="~/TreeImages" />
			</td>
			<td valign="top">
				<asp:ImageButton runat="server" ID="zzzbtnshowtree" ImageUrl="images/DropDown.gif" CausesValidation="false" />
			</td>
		</tr>
	</table>
</div>