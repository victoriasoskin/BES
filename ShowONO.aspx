<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ShowOno.aspx.vb" Inherits="ShowOno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<table>
	<tr>
		<td>
			<asp:Label runat="server" ID="lblName" Font-Bold="true" Font-Size="Medium" />
		</td>
		<td>
			<asp:Label runat="server" ID="lblDate" />
		</td>
	</tr>
	<tr>
		<td> 
			<asp:Label runat="server" ID="lblMood" />
		</td>
		<td>
			<asp:Label runat="server" ID="lblTxt" />
		</td>
	</tr>

	<tr>
		<td colspan="2">
			<asp:Chart runat="server" ID="ctl02" DataSourceID="DSONO" Width="700" Height="500">
				<Series>
					<asp:Series Name="Series1" XValueMember="Name" YValueMembers="Val">
					</asp:Series>
				</Series>
				<ChartAreas>
					<asp:ChartArea Name="ChartArea1">
					</asp:ChartArea>
				</ChartAreas>
			</asp:Chart>
		</td>
	</tr>
	<tr>
		<td>
			<asp:Button runat="server" ID="btnBack" Text="חזרה" PostBackUrl="CustEventReport.Aspx" />
		</td>
	</tr>
</table>
<asp:SqlDataSource runat="server" ID="DSONO" 
		ConnectionString="<%$ ConnectionStrings:Book10VPS %>" SelectCommand="SELECT a.CustomerID,a.Loadtime,q.Name,a.Val,CASE h.Val WHEN 0 THEN N'ירוד' ELSE N'טוב' END AS Mood,h.Txt,c.CustFirstName,c.CustLastName
FROM ExtData.dbo.Survey_Answers a
LEFT OUTER JOIN ExtData.dbo.Survey_HAnswers h on h.EventID=a.EventID
lEFT OUTER JOIN ExtData.dbo.Survey_Q q ON a.QUestionID=q.ID
LEFT OUTER JOIN Book10.dbo.CustomerList c ON c.CustomerID=a.CustomerID
where a.EventID=@EventID">
	<SelectParameters>
		<asp:QueryStringParameter Name="EventID" QueryStringField="E" />
	</SelectParameters>
	</asp:SqlDataSource>
			    <asp:DataList runat="server" ID="dtCust" DataSourceID="dsONO">
				<ItemTemplate>
					<asp:HiddenField runat="server" ID="hdnName" Value='<%#Eval("CustFirstName") & " " & Eval("CustLastName") %>' OnPreRender="hdnName_PreRender" />
					<asp:HiddenField runat="server" ID="hdnMood" Value='<%#Eval("Mood") %>' OnPreRender="hdnMood_PreRender" />
					<asp:HiddenField runat="server" ID="hdnTxt" Value='<%#Eval("Txt") %>'  OnPreRender="hdnTxt_PreRender" />
					<asp:HiddenField runat="server" ID="hdndate" Value='<%#Eval("LoadTime") %>' OnPreRender="hdnDate_PreRender" />
				</ItemTemplate>
			</asp:DataList>
</asp:Content>

