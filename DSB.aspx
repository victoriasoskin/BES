<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false"
	CodeFile="DSB.aspx.vb" Inherits="DSB" %>

<%@ Register TagPrefix="topyca" TagName="GChart" Src="~/Controls/GChart.ascx" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<style type="text/css">
		.h1 
{ 
    font-size:xx-large;
    font-weight:bolder;
    padding-right:10px;
} 
		.dsb_pg
		{
			width: 100%;
			height: 100%;
			text-align: center;
		}
		.dsb_tbl
		{
			width: 100%;
			height: 100%;
		}
		.dsb_tbl td
		{
			width: 33.33%;
			height: 50%;
			text-align: center;
			background-color:#DDDDDD;
		}
	</style>
	<topyca:PageHeader runat="server" ID="ph1" Header="ששטוס" ButtonJava="window.open('default.aspx','_self')" ButtonText="חזרה" />
	<div class="dsb_pg">
	<div style="float:right;"><asp:Button runat="server" ID="btnBack" Visible="false" Text="סגור" OnClientClick="window.close();"/></div>	
		<topyca:GChart runat="server" ID="solo" XMLDataSource="App_Data/DSBCharts.xml" Visible="false" />
		<table id="tbl" runat="server" border="0" class="dsb_tbl">
				<tr>
					<td>
						<topyca:GChart ID="Chart11" runat="server" XMLDataSource="App_Data/DSBCharts.xml"  />
						<asp:ImageButton runat="server" ID="btn11" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=1&C=1" />
					</td>
					<td>
						<topyca:GChart ID="Chart12" runat="server" XMLDataSource="App_Data/DSBCharts.xml" />
						<asp:ImageButton runat="server" ID="btn12" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=1&C=2" />
					</td>
					<td>
						<topyca:GChart ID="Chart13" runat="server" XMLDataSource="App_Data/DSBCharts.xml"  />
						<asp:ImageButton runat="server" ID="btn13" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=1&C=3" />
					</td>
				</tr>
				<tr>
					<td>
						<topyca:GChart ID="Chart21" runat="server" XMLDataSource="App_Data/DSBCharts.xml"  />
						<asp:ImageButton runat="server" ID="btn21" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=2&C=1" />
					</td>
					<td>
						<topyca:GChart ID="Chart22" runat="server" XMLDataSource="App_Data/DSBCharts.xml"  />
						<asp:ImageButton runat="server" ID="btn22" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=2&C=2" />
					</td>
					<td>
						<topyca:GChart ID="Chart23" runat="server" XMLDataSource="App_Data/DSBCharts.xml"  />
						<asp:ImageButton runat="server" ID="btn23" ImageUrl="~/images/Pie-Chart-icon.png" Height="30" Width="30" style="float:right;" ToolTip="לחץ כאן לבחירה/שינוי הגרף בתא" PostBackUrl="DSBDef.ASPX?R=2&C=3" />
					</td>
				</tr>
				</table>
	</div>
	<asp:SqlDataSource ID="dscharts" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
		CancelSelectOnNullParameter="false" SelectCommand="SELECT [RowID], [RepID1], [RepID2], [RepID3] FROM [AA_UserCharts] WHERE ([UserID] = @UserID) ORDER BY [RowID]">
		<SelectParameters>
			<asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
