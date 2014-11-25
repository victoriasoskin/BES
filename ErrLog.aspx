<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ErrLog.aspx.vb" Inherits="ErrLog" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
		<asp:CheckBox runat="server" ID="cbShowAll"  AutoPostBack="true" Text="Show all" />
		<asp:GridView runat="server" DataSourceID="dse" AllowPaging="True"  ID="gv"
			AutoGenerateColumns="False">
			<Columns>
				<asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
				<asp:BoundField DataField="ERRTime" HeaderText="ERRTime" 
					SortExpression="ERRTime" />
				<asp:TemplateField HeaderText="C" SortExpression="Comment"> 
					<ItemTemplate>
						<asp:Button runat="server" Text="X" ID="btnx" OnClick="btnx_Click" />
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField DataField="Page" HeaderText="Page" SortExpression="Page" />
				<asp:TemplateField HeaderText="E" SortExpression="E">
					<ItemTemplate>
						<asp:Button runat="server" Text="S" ID="btns" OnClick="btns_Click" Visible='<%#Eval("E")=1 %>' />
					</ItemTemplate>
				</asp:TemplateField>
				<asp:TemplateField HeaderText="ErrMessage" SortExpression="ErrMessage" 
					Visible="False">
					<ItemTemplate>
						<asp:Label ID="Label1" runat="server" Text='<%# Bind("ErrMessage") %>' style="width:400px;white-space:normal;"></asp:Label>
					</ItemTemplate>
					<ControlStyle Width="400px" />
					<ItemStyle Width="400px" />
				</asp:TemplateField>
			</Columns>
		</asp:GridView>
		<asp:SqlDataSource ID="dsdet" runat="server" 
			ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
			SelectCommand="SELECT * FROM [AA_vErrLog] WHERE ([ID] = @ID)">
			<SelectParameters>
				<asp:Parameter Name="ID" Type="Int32" />
			</SelectParameters>
		</asp:SqlDataSource>
		<asp:SqlDataSource runat="server" 
			ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" id="dse"
			
			
			SelectCommand="SELECT ID, ERRTime, UserID, Comment, Page, CASE ISNULL(errMessage,'') WHEN '' THEN 0 ELSE 1 END AS E,ErrMessage FROM AA_vErrLog WHERE Comment IS NULL OR @ShowAll != 0 ORDER BY ID DESC">
			<SelectParameters>
				<asp:ControlParameter ControlID="cbShowAll" Name="ShowAll" 
					PropertyName="Checked" />
			</SelectParameters>
		</asp:SqlDataSource>
    	<asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
			DataSourceID="dsdet" Height="50px" Visible="False" Width="125px" style="color:Black;">
			<Fields>
				<asp:BoundField DataField="ID" HeaderText="ID" SortExpression="ID" />
				<asp:BoundField DataField="ERRTime" HeaderText="ERRTime" 
					SortExpression="ERRTime" />
				<asp:BoundField DataField="Logtime" HeaderText="Logtime" 
					SortExpression="Logtime" />
				<asp:BoundField DataField="UserID" HeaderText="UserID" 
					SortExpression="UserID" />
				<asp:BoundField DataField="LoginUser" HeaderText="LoginUser" 
					SortExpression="LoginUser" />
				<asp:BoundField DataField="UserName" HeaderText="UserName" 
					SortExpression="UserName" />
				<asp:TemplateField HeaderText="Email" SortExpression="uEmail">
					<ItemTemplate>
						<asp:HyperLink ID="HyperLink1" runat="server" 
							NavigateUrl='<%# Eval("Uemail", "mailto:{0}") %>' Text='<%# Eval("Uemail") %>'></asp:HyperLink>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField DataField="FrameID" HeaderText="FrameID" 
					SortExpression="FrameID" />
				<asp:BoundField DataField="FrameName" HeaderText="FrameName" 
					SortExpression="FrameName" />
				<asp:BoundField DataField="Page" HeaderText="Page" SortExpression="Page" />
				<asp:BoundField DataField="errNumber" HeaderText="errNumber" 
					SortExpression="errNumber" />
				<asp:BoundField DataField="errMessage" HeaderText="errMessage" 
					SortExpression="errMessage" />
				<asp:BoundField DataField="SessionID" HeaderText="SessionID" 
					SortExpression="SessionID" />
				<asp:BoundField DataField="ComputerName" HeaderText="ComputerName" 
					SortExpression="ComputerName" />
				<asp:CheckBoxField DataField="Mailed" HeaderText="Mailed" 
					SortExpression="Mailed" />
				<asp:BoundField DataField="Comment" HeaderText="Comment" 
					SortExpression="Comment" />
				<asp:BoundField DataField="SourceID" HeaderText="SourceID" 
					SortExpression="SourceID" />
				<asp:BoundField DataField="Browser" HeaderText="Browser" 
					SortExpression="Browser" />
				<asp:BoundField DataField="ClientIP" HeaderText="ClientIP" 
					SortExpression="ClientIP" />
				<asp:BoundField DataField="HostIP" HeaderText="HostIP" 
					SortExpression="HostIP" />
				<asp:BoundField DataField="SpecComment" HeaderText="SpecComment" 
					SortExpression="SpecComment" />
			</Fields>
		</asp:DetailsView>
    </div>
    </form>
</body>
</html>
