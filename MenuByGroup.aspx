<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="MenuByGroup.aspx.vb" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="reldiv">
	<div class="hdrdiv">תפריט לפי קבוצת משתמשים
	</div>
	<div>
		<table>
			<tr>
				<td>
					<asp:DropDownList ID="ddlg" runat="server" AppendDataBoundItems="True" 
						AutoPostBack="True" DataSourceID="DSG" DataTextField="UserGroupName" 
						DataValueField="Stype">
						<asp:ListItem Value="">&lt;בחירת קבוצה&gt;</asp:ListItem>
					</asp:DropDownList> 
					<asp:SqlDataSource ID="DSG" runat="server" 
						ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
						SelectCommand="SELECT [UserGroupName], [Stype] FROM [p0t_UGroup]">
					</asp:SqlDataSource>
				</td>
			</tr>
			<tr>
				<td>
					<asp:Label ID="lblnam" runat="server" Font-Bold="True" Font-Size="Medium" 
						ForeColor="Red"></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					<asp:SiteMapDataSource ID="SiteMapDataSource2" runat="server" />
					<asp:Menu ID="Menu2" runat="server" DataSourceID="SiteMapDataSource2" 
						DynamicEnableDefaultPopOutImage="False" DynamicHorizontalOffset="1" 
						MaximumDynamicDisplayLevels="0" StaticDisplayLevels="4" StaticSubMenuIndent="" 
						Visible="false">
						<LevelMenuItemStyles>
							<asp:MenuItemStyle Font-Bold="true" ForeColor="black" />
							<asp:MenuItemStyle Font-Bold="true" ForeColor="Black" />
							<asp:MenuItemStyle Font-Size="8" ForeColor="blue" />
						</LevelMenuItemStyles>
					</asp:Menu>
				</td>
			</tr>
		</table>
	</div>
</div>
</asp:Content>

