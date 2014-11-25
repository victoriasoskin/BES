<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SUrveyStatus.aspx.vb" Inherits="Default3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="reldiv">
	<div class="hdrdiv">
		אחוזי הצבעה<br /><asp:SqlDataSource ID="dssurveys" runat="server" 
			ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
			SelectCommand="SELECT [Survey], [SurveyID] FROM [Surveys]">
		</asp:SqlDataSource>
		
	<asp:DropDownList ID="ddlsurveys" runat="server" AppendDataBoundItems="True"  
			AutoPostBack="True" DataSourceID="dssurveys" DataTextField="Survey" 
			DataValueField="SurveyID">
			<asp:ListItem Value="">&lt;בחירת סקר&gt;</asp:ListItem>
		</asp:DropDownList>
	</div>
	<div class="">
		<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
			DataSourceID="dscount" CellPadding="4" ShowFooter="True">
			<Columns>
				<asp:BoundField DataField="SurveyID" HeaderText="מס" 
					SortExpression="SurveyID" />
				<asp:BoundField DataField="Survey" HeaderText="שם" SortExpression="Survey" />
				<asp:BoundField DataField="FrameName" HeaderText="שם מסגרת" />
				<asp:TemplateField HeaderText="מספר משתתפים" SortExpression="c0">
					<ItemTemplate>
						<asp:Label ID="Label1" runat="server" Text='<%# val("c0",0) %>'></asp:Label>
					</ItemTemplate>
					<FooterTemplate>
						<asp:Label ID="Labe71" runat="server" Text='<%# tval(0) %>'></asp:Label>
					</FooterTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="כל הנסקרים" SortExpression="c1">
					<ItemTemplate>
						<asp:Label ID="Label2" runat="server" Text='<%# val("c1",1) %>'></asp:Label>
					</ItemTemplate>
					<FooterTemplate>
						<asp:Label ID="Labe72" runat="server" Text='<%# tval(1) %>'></asp:Label>
					</FooterTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="%">
					<ItemTemplate>
						<asp:Label ID="Label3" runat="server" 
							Text='<%# format(eval("c1")/eval("c0"),"0.0%") %>'></asp:Label>
					</ItemTemplate>
					<FooterTemplate>
						<asp:Label ID="Labe80" runat="server" Text='<%# pval(1,0) %>'></asp:Label>
					</FooterTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="נסקרים ששלחו הצבעתם למערכת" SortExpression="c2">
					<ItemTemplate>
						<asp:Label ID="Label5" runat="server" Text='<%# val("c2",2) %>'></asp:Label>
					</ItemTemplate>
					<FooterTemplate>
						<asp:Label ID="Labe72" runat="server" Text='<%# tval(2) %>'></asp:Label>
					</FooterTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="%">
					<ItemTemplate>
						<asp:Label ID="Label4" runat="server" 
							Text='<%# format(eval("c2")/eval("c0"),"0.0%") %>'></asp:Label>
					</ItemTemplate>
					<FooterTemplate>
						<asp:Label ID="Labe81" runat="server" Text='<%# pval(2,0) %>'></asp:Label>
					</FooterTemplate>
				</asp:TemplateField>
			</Columns>
		</asp:GridView>
		<asp:SqlDataSource ID="dscount" runat="server" 
			ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
			
			
			SelectCommand="SELECT SurveyID, Survey, c0, c1, c2, FrameName FROM dbo.vSurveyStatus WHERE (SurveyID = @SurveyID) ORDER BY SurveyID">
			<SelectParameters>
				<asp:ControlParameter ControlID="ddlsurveys" Name="SurveyID" 
					PropertyName="SelectedValue" />
			</SelectParameters>
		</asp:SqlDataSource>
	</div>
</div>
</asp:Content>

