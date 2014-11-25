<%@ Control Language="VB" AutoEventWireup="false" CodeFile="NTreeDropDown.ascx.vb" Inherits="NTreeDropDown" %>
<style type="text/css">
table {
	border-collapse: collapse;
	border-spacing: 0;
}
</style>
<div dir="rtl" style="font-family:Arial;font-size:small;">
	<table style="margin:0px opx 0px 0px;color:Black;">
		<tr>
			<td style="vertical-align:top;margin:0px 0px 0px 0px;border-top:1px inset #DDDDDD;border-bottom:1px inset #DDDDDD;border-right:1px inset #DDDDDD;">
				<asp:Label runat="server" ID="zzzlblCurrentSelectionText" EnableViewState="true" />
				<asp:HiddenField runat="server" ID="zzzhdnCurrentSelectionValue" />
				<asp:HiddenField ID="zzzSaveTableName" runat="server" />
				<asp:HiddenField ID="zzzhdnDepth" runat="server" />
				<asp:TreeView  ID="zzztvDropDown"  ExpandDepth="0" PopulateNodesFromClient="true"  ShowLines="true" SelectedNodeStyle-BackColor="CadetBlue" SelectedNodeStyle-ForeColor="White" ShowExpandCollapse="true"   runat="server"   LineImagesFolder="~/TreeImages" ForeColor="Black" />
			</td>
			<td style="vertical-align:top;margin:0px opx 0px 0px;border-top:1px inset #DDDDDD;border-bottom:1px inset #DDDDDD;border-left:1px inset #DDDDDD;">
				<asp:ImageButton runat="server" ID="zzzbtnshowtree" ImageUrl="images/DropDown.gif" CausesValidation="false" />
			</td>
		</tr>
	</table>
</div>