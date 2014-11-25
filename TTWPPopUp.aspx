<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false" CodeFile="TTWPPopUp.aspx.vb" Inherits="TTWPPopUp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.edt
		{
		    text-align:right;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ScriptManager runat="server">
</asp:ScriptManager>
<asp:Label runat="server" ID="lblSingleFrame" />	
<div runat="server" id="divform" class="pg" style="min-height:400px;"> 
	<div id="divworkplan">
		<span style="font-size:large;font-weight:bold;">תוכנית תמיכות</span>
		<hr />
			<asp:ListView runat="server" ID="lvWorkPlan" DataSourceID="DSWorkPlan" DataKeyNames="ID,FormID">
			<LayoutTemplate>
				<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;">
					<thead>
						<tr>
							<th style="width:5%;">בחר</th>
							<th style="width:20%;">מטרת התמיכה</th>
							<th style="width:40%;">אופן ביצוע (תדירות, זמן, ספק ופירוק התמיכה בפועל)</th>
							<th style="width:30%;">קריטריונים להצלחה</th>
						</tr>
					</thead>
					<tr ID="itemPlaceholder" runat="server">
					</tr>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr>
					<td style="white-space:nowrap;">
						<asp:CheckBox runat="server" ID="cbf" onclick="SingleSelect('rbSelect',this);" OnPreRender="CB_PreRender" Enabled='<%#ViewState("iCanUpdate")=1 %>' />
						<asp:HiddenField runat="server" ID="hdnID" Value='<% #Eval("ID") %>' />
					</td>
					<td>
						<asp:Label runat="server" ID="lblPurpose" Text='<%#Eval("Purpose")%>' />
					</td>
					<td>
						<%#Eval("Description")%>
					</td>
					<td>
						<%#Eval("Criteria")%>
					</td>
				</tr>
			</ItemTemplate>
		</asp:ListView>
		<hr />

		<h3>הערה</h3>
		<div style="text-align:center;">
			<asp:TextBox runat="server" ID="tbComment" Width="98%" Rows="3" TextMode="MultiLine" />
		</div>
	</div>
	<div id="divbuttons" style="text-align:center;">
		<asp:Button runat="server" ID="btnOK" Text="אישור" />
	</div>
</div>
<asp:SqlDataSource runat="server" ID="DSWorkPlan" CancelSelectOnNullParameter="false"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT * FROM (
					   SELECT * FROM dbo.TT_fnWorkPlan(@CustEventID)
					   UNION ALL
					   SELECT 999999 AS [ID],999999 AS WpID, NULL AS FormID, 'מחיקת הפעולה' AS Purpose, NULL AS Description, NULL AS  Criteria, NULL AS cnt, NULL AS URName) a
					   ORDER BY WpID" >
		<SelectParameters>
			<asp:QueryStringParameter Name="CustEventID" QueryStringField="ID" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>

