<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false"
	CodeFile="DSBDef.aspx.vb" Inherits="DSBDef" %>

<%@ Register TagPrefix="topyca" TagName="GChart" Src="~/Controls/GChart.ascx" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<style type="text/css">
		.h1
		{
			font-size: xx-large; 
			font-weight: bolder;
			padding-right: 10px;
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
			background-color: #DDDDDD;
		}
	</style>
	<topyca:PageHeader runat="server" ID="ph1" Header="בחירה/שינוי גרף בתא בששטוס" ButtonJava="" />
	<div class="dsb_pg">
		<div style="float: right;">
		</div>
		<div style="background-color:#EEEEEE;">
			<table>
				<tr>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl11" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl12" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl13" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
				</tr>
				<tr>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl21" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl22" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
					<td style="border:1px dotted Black;">
						<asp:Label runat="server" ID="lbl23" Text="XXX" BackColor="#EEEEEE" Font-Bold="true" ForeColor="#EEEEEE" />
					</td>
				</tr>
			</table>
			<table style="text-align:right;vertical-align:top;">
				<tr style="vertical-align:top;height:20px;">
					<td>
						<b>בחר גרף</b>
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlChrt" DataTextField="title" AutoPostBack="true"
							DataValueField="id" AppendDataBoundItems="true">
							<asp:ListItem Value="">בחר גרף</asp:ListItem>
						</asp:DropDownList>
					</td>
					<td rowspan="8">
						<asp:Label runat="server" ID="lblErr" Text="שמירת הגרף נכשלה. נסה שנית.<br />אם הבעיה חוזרת יש לפנית לאריאל 054-4333791." ForeColor="Red" Font-Bold="true"  Visible="false"/>
						<topyca:GChart runat="server" ID="solo" XMLDataSource="App_Data/DSBCharts.xml" Width="500" />
					</td>
				</tr>
				<tr style="vertical-align:top;height:20px;">
					<td>
						<asp:Label runat="server" ID="lblp0" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP0" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:top;max-height:30px;">
					<td>
						<asp:Label runat="server" ID="lblp1" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP1" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:top;max-height:30px;">
					<td>
						<asp:Label runat="server" ID="lblp2" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP2" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:top;max-height:30px;">
					<td>
						<asp:Label runat="server" ID="lblp3" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP3" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:top;max-height:30px;">
					<td>
						<asp:Label runat="server" ID="lblp4" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP4" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:top;max-height:30px;">
					<td>
						<asp:Label runat="server" ID="lblp5" Visible="false" />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlP5" DataTextField="Text" DataValueField="Value"
							Visible="false" />
					</td>
				</tr>
				<tr style="vertical-align:bottom;">
					<td>
						<asp:Button runat="server" ID="btnShow" Text="הצג" />
					</td>
					<td>
						<asp:Button runat="server" ID="btnSave" Text="שמור" />
						<asp:Button runat="server" ID="btnBack" Text="ביטול" PostBackUrl="~/DSB.aspx" />

					</td>
				</tr>
			</table>
		</div>
	</div>
	<asp:SqlDataSource ID="dscharts" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
		CancelSelectOnNullParameter="false" SelectCommand="SELECT [RowID], [RepID1], [RepID2], [RepID3] FROM [AA_UserCharts] WHERE ([UserID] = @UserID) ORDER BY [RowID]">
		<SelectParameters>
			<asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
</asp:Content>
