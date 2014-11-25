<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false" CodeFile="Tree.aspx.vb" Inherits="Tree" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"> 
	<%--	<style type="text/css">
		.edt
		{
		    text-align:right;
		}
		.btn
		{
		    white-space:normal;text-decoration:none;background-color:#DDDDDD;border:2px;color:Black;
		}
		.wp1 {width:15%;} .wp2 {width:5%;} .wp3 {width:20%;} .wp4 {width:40%;} .wp5 {width:20%;}
		.ansprint {}
	</style>
<script type="text/ecmascript">
//To cause postback "as" the Button
//	function PostBackOnMainPage(){
//		<%=GetPostBackScript()%>
//	}       
	function popup(url) {
            params = 'width=' + screen.width;
            params += ', height=' + screen.height;
            params += ', top=0, left=0'
            params += ', fullscreen=yes';

            newwin = window.open(url, 'windowname4', params);
            if (window.focus) { newwin.focus() }
            return false;
        }
    function DoPrint()
    {
        document.all("PRINT").style.visibility = "hidden";
//        document.all("tdbtn0").style.visibility = "hidden";
//        document.all("tdbtn1").style.visibility = "hidden";
//        document.all("tdbtn2").style.visibility = "hidden";
//        
        document.execCommand('print', false, null);
        document.all("PRINT").style.visibility = "visible";
//        document.all("tdbtn0").style.visibility = "visible";
//        document.all("tdbtn1").style.visibility = "visible";
//        document.all("tdbtn2").style.visibility = "visible";

	}
	function myPrint() {

        document.printing.leftMargin = 1.0;

        document.printing.topMargin = 1.0;

        document.printing.rightMargin = 1.0;

        document.printing.bottomMargin = 1.0;

        document.printing.portrait = false;

        document.execCommand('print', false, null); // print without prompt
    }
</script>
--%></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ToolkitScriptManager runat="server">
</asp:ToolkitScriptManager>
<div runat="server" id="divform" class="pg">
<topyca:pageheader runat="server" ID="PageHeader1" ButtonJava="window.close();" />
	<div id="divTV" style="width:100%;">
	<table style="width:100%">
		<tr>
			<td style="width:75%;vertical-align:top;">
				<asp:TreeView ID="TV" runat="server" DataSourceID="XMLDS" OnTreeNodeCheckChanged="TV_CheckChanged"
				 ShowLines="true" 
					LineImagesFolder="~/TreeImages" 
					ShowExpandCollapse="true" >
					<DataBindings>
						<asp:TreeNodeBinding TextField="Name" ValueField="key" />
					</DataBindings>
					<SelectedNodeStyle BackColor="LightCyan" ForeColor="Blue" />
				</asp:TreeView>
			</td>
			<td style="width:25%;vertical-align:top;">
				<asp:ListView runat="server" ID="LVSM" DataSourceID="DSSM" DataKeyNames="EmployeeID">
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" >
							<tr>
								<td style="background-color:darkgray;font-weight:bold;">מראיין שני</td>
							</tr>
							<tr ID="itemPlaceholder" runat="server">
							</tr>

						</table>
					</LayoutTemplate>
					<ItemTemplate>
						<tr>
							<td>
								<asp:linkbutton runat="server" ID="lnkbEmployeeName" Text='<%#Eval("EmployeeName") %>' CommandName="Select" style="text-decoration:none;" OnClick="lnkb_Click" />
								<asp:HiddenField runat="server" ID="hdnEmployeeID" Value='<%#Eval("EmployeeID") %>' /> 
							</td>
						</tr>
					</ItemTemplate>
					<SelectedItemTemplate>
						<tr>
							<td style="background-color:LightCyan;">
								<asp:Label runat="server" ID="lnkbEmployeeName" Text='<%#Eval("EmployeeName") %>'  />
								<asp:HiddenField runat="server" ID="hdnEmployeeID" Value='<%#Eval("EmployeeID") %>' /> 
							</td>
						</tr>
					</SelectedItemTemplate>
				</asp:ListView>
			</td>
		</tr>
	</table>
		
	</div>
	<div runat="server" id="divbuttons">
		<table>
			<tr>
				<td>
					<asp:ImageButton runat="server" ID="btnSave" ImageUrl="images/diskette.png" Height="45px" Width="45px" />
				</td>
			</tr>
			<tr>
				<td>
					<asp:ImageButton runat="server" ID="btnEdit" ImageUrl="images/diskette.png" Height="45px" Width="45px" Visible="false" />
				</td>
			</tr>
			<tr>
				<td>
					<asp:ImageButton runat="server" ID="btnDelete" ImageUrl="images/Delete.png" Height="45px" Width="45px" Visible="false" />
				</td>
			</tr>
			<tr>
				<td>
					<asp:ImageButton runat="server" ID="btnAddC" ImageUrl="images/diskette.png" Height="45px" Width="45px" Visible="false" />
				</td>
			</tr>
			<tr>
				<td>
					<asp:ImageButton runat="server" ID="btnAddS" ImageUrl="images/diskette.png" Height="45px" Width="45px" Visible="false" />
				</td>
			</tr>
		</table>
	</div>
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="divbuttons" HorizontalOffset="750" VerticalOffset="65" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
<%--	<asp:ImageButton runat="server" ID="btnSave" ImageUrl="images/diskette.png" 
			Height="45px" Width="45px" />
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="btnSave" HorizontalOffset="750" VerticalOffset="65" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
	<asp:ImageButton runat="server" ID="btnEdit" ImageUrl="images/diskette.png" 
			Height="45px" Width="45px" />
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="btnSave" HorizontalOffset="750" VerticalOffset="5" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
--%><%--	<asp:ImageButton runat="server" ID="btnDel" ImageUrl="images/diskette.png" 
			Height="45px" Width="45px" />
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="btnSave" HorizontalOffset="0" VerticalOffset="165" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
	<asp:ImageButton runat="server" ID="btnAddChild" ImageUrl="images/diskette.png" 
			Height="45px" Width="45px" />
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="btnSave" HorizontalOffset="0" VerticalOffset="215" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
	<asp:ImageButton runat="server" ID="btnAddSib" ImageUrl="images/diskette.png" 
			Height="45px" Width="45px" />
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="btnSave" HorizontalOffset="0" VerticalOffset="265" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
--%></div>
<%--	<asp:Button ID="btnPostback" runat="server" Visible="false" CausesValidation="false"  />
--%>	<asp:XmlDataSource ID="XMLDS" runat="server" EnableCaching="false"></asp:XmlDataSource>

			<asp:SqlDataSource runat="server" ID="DSSM"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT s.EmployeeID, e.EmployeeName FROM HR_SecondManager AS s LEFT OUTER JOIN dbo.tf_HR_EmpList() AS e ON e.EmployeeID = s.EmployeeID
						UNION ALL
						SELECT -999 AS EmployeeID,'<span style=background-color:yellow;>ביטול מראיין שני</span>' AS EmployeeName"></asp:SqlDataSource>
</asp:Content>

