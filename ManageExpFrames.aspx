<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ManageExpFrames.aspx.vb" Inherits="ManageExpFrames" MaintainScrollPositionOnPostback="true" %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<style type="text/css">
    .h1 
    {
        font-size:xx-large;
        font-weight:bolder;
        width:600px;
        padding-right:10px;
    } 
    .p  
    {
        width:200px;
        padding-right:10px;
    }
    .pg
    {
        position:absolute;
        background-color:#C0C0C0;
        width:800px;
        border-style:outset;
    }
    .blockHeader
    {
        font-size:medium;
        color:ButtonText;
        font-weight:bolder;
        height:25px;   
        padding-right:10px;     
    }
    .blockfooter
    {
        padding-right:10px;        
    }
    .tbw
    {
        background-color: #ececec;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
        width:125px;
        border-style:groove;
    }
    .tdr
    {
        padding-right:10px;
        padding-top:5px;
    }
    .tbl
    {
        padding:10px;
        width:100%;
    }
    th
    {
        background-color:#AAAAAA;
        border-bottom:1px solid black;
    }
    .tbld
    {
        width:100%;
    }
    .tbld td
    {
        padding-right:10px;
    }
    .tdid
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
        width:20px;
    }
    .tdq
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
    }
    .tda
    {
        border-bottom:1px outset #AAAAAA;
        width:300px;
    }
    .shf
    {
        background-color: #eaeaea;
        width:104px;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
    .tao td
    {
        border:1px dotted #666666;
    }
</style>
<script src="jquery-1.7.1.js" type="text/javascript"></script>
<script  type="text/javascript">
	function fout(t) {
		if (t.value == '-') {
			$('#tbldef').fadeOut('slow');
			t.value = '+';
		}
		else {
			$('#tbldef').fadeIn('slow');
			t.value = '-';
		}
	}
 </script>
<div runat="server" id="divform" class="pg">
<topyca:PageHeader runat="server" ID="PageHeader1" Header="ניהול תוקף פעולות" ButtonJava="" />
	<asp:SqlDataSource ID="DSFrames" runat="server" 
		ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
		SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] ORDER BY [FrameName]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="DSUsers" runat="server" 
		ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
		SelectCommand="SELECT [UserID], [UserName] FROM [p0t_NtB] ORDER BY [UserName]">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="DSEvents" runat="server" 
		ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
		
		SelectCommand="SELECT [CustEventTypeName], [CustEventTypeID] FROM [CustEventTypes] WHERE (([CustEventDays] IS NOT NULL) or ([CustEventmonths] IS NOT NULL) or ([CustEventYears] IS NOT NULL))">
	</asp:SqlDataSource>
	<asp:SqlDataSource ID="DSExpFrames" runat="server" 
		ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
		DeleteCommand="DELETE FROM [EE_FrameUserList] WHERE [ID] = @ID" 
		InsertCommand="INSERT INTO [EE_FrameUserList] ([FrameID], [CustEventTypeID], [UserID]) VALUES (@FrameID, @CustEventTypeID, @UserID)" 
		SelectCommand="SELECT l.ID, l.FrameID, f.FrameName, l.CustEventTypeID, e.CustEventTypeName, l.UserID, u.UserName FROM dbo.EE_FrameUserList AS l LEFT OUTER JOIN dbo.p0t_NtB AS u ON l.UserID = u.UserID LEFT OUTER JOIN dbo.CustEventTypes AS e ON l.CustEventTypeID = e.CustEventTypeID LEFT OUTER JOIN dbo.FrameList AS f ON l.FrameID = f.FrameID order by FrameName,UserName" 
		UpdateCommand="UPDATE [EE_FrameUserList] SET [FrameID] = @FrameID, [CustEventTypeID] = @CustEventTypeID, [UserID] = @UserID WHERE [ID] = @ID">
		<DeleteParameters>
			<asp:Parameter Name="ID" Type="Int32" />
		</DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="FrameID" Type="Int32" />
			<asp:Parameter Name="CustEventTypeID" Type="Int32" />
			<asp:Parameter Name="UserID" Type="Int32" />
		</InsertParameters>
		<UpdateParameters>
			<asp:Parameter Name="FrameID" Type="Int32" />
			<asp:Parameter Name="CustEventTypeID" Type="Int32" />
			<asp:Parameter Name="UserID" Type="Int32" />
			<asp:Parameter Name="ID" Type="Int32" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:ListView ID="ListView1" runat="server" DataKeyNames="ID" 
		DataSourceID="DSExpFrames" InsertItemPosition="LastItem">
<%--		<AlternatingItemTemplate>
			<tr class="tao">
				<td>
					<asp:Button ID="DeleteButton" runat="server" CommandName="Delete"  OnClientClick="return confirm('האם למחוק?');"
						Text="מחיקה" />
					<asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="עריכה" />
				</td>
				<td>
					<asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
				</td>
				<td>
					<asp:Label ID="FrameIDLabel" runat="server" Text='<%# Eval("FrameID") %>' />
				</td>
				<td>
					<asp:Label ID="FrameNameLabel" runat="server" Text='<%# Eval("FrameName") %>' />
				</td>
				<td>
					<asp:Label ID="CustEventTypeIDLabel" runat="server" 
						Text='<%# Eval("CustEventTypeID") %>' />
				</td>
				<td>
					<asp:Label ID="CustEventTypeNameLabel" runat="server" 
						Text='<%# Eval("CustEventTypeName") %>' />
				</td>
				<td>
					<asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' />
				</td>
				<td>
					<asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
				</td>
			</tr>
		</AlternatingItemTemplate>
--%>		<EditItemTemplate>
			<tr style="white-space:nowrap;">
				<td>
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
						Text="עדכון" />
					<asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
						Text="ביטול" />
				</td>
				<td>
					<asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
				</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlFrames"  DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" SelectedValue='<%# bind("FrameID") %>' >
					</asp:DropDownList>
				</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlEvents"   DataSourceID="DSEvents" DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" SelectedValue='<%# bind("CustEventTypeID") %>'  >
					</asp:DropDownList>
				</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlUsers"   DataSourceID="DSUsers" DataTextField="UserName" DataValueField="UserID" SelectedValue='<%# bind("UserID") %>'  >
					</asp:DropDownList>
				</td>
			</tr>
		</EditItemTemplate>
		<EmptyDataTemplate>
			<table runat="server" style="">
				<tr>
					<td>
						אין נתונים להצגה.</td>
				</tr>
			</table>
		</EmptyDataTemplate>
		<InsertItemTemplate>
			<tr style="">
				<td>
					<asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
						Text="הוספה" />
					<asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
						Text="ביטול" />
				</td>
				<td>
					&nbsp;</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlFrames"  DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" SelectedValue='<%# bind("FrameID") %>' >
					</asp:DropDownList>
				</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlEvents"   DataSourceID="DSEvents" DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" SelectedValue='<%# bind("CustEventTypeID") %>'  >
					</asp:DropDownList>
				</td>
				<td colspan="2">
					<asp:DropDownList runat="server" ID="ddlUsers"   DataSourceID="DSUsers" DataTextField="UserName" DataValueField="UserID" SelectedValue='<%# bind("UserID") %>'  >
					</asp:DropDownList>
				</td>
			</tr>
		</InsertItemTemplate>
		<ItemTemplate>
			<tr  class="tao">
				<td style="white-space:nowrap;">
					<asp:Button ID="DeleteButton" runat="server" CommandName="Delete" OnClientClick="return confirm('האם למחוק?');" 
						Text="מחיקה" />
					<asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="עריכה" />
				</td>
				<td>
					<asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
				</td>
				<td>
					<asp:Label ID="FrameIDLabel" runat="server" Text='<%# Eval("FrameID") %>' />
				</td>
				<td style="white-space:nowrap;">
					<asp:Label ID="FrameNameLabel" runat="server" Text='<%# Eval("FrameName") %>' />
				</td>
				<td>
					<asp:Label ID="CustEventTypeIDLabel" runat="server" 
						Text='<%# Eval("CustEventTypeID") %>' />
				</td>
				<td style="white-space:nowrap;">
					<asp:Label ID="CustEventTypeNameLabel" runat="server" 
						Text='<%# Eval("CustEventTypeName") %>' />
				</td>
				<td>
					<asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' />
				</td>
				<td  style="white-space:nowrap;">
					<asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
				</td>
			</tr>
		</ItemTemplate>
		<LayoutTemplate>
			<table runat="server">
				<tr runat="server">
					<td runat="server">
						<table ID="itemPlaceholderContainer" runat="server" border="0" style="">
							<tr runat="server" style="white-space:nowrap;">
								<th runat="server">
								</th>
								<th runat="server">
									קוד</th>
								<th runat="server">
									קוד מסגרת</th>
								<th runat="server">
									מסגרת</th>
								<th runat="server">
									קוד פעולה</th>
								<th runat="server">
									פעולה</th>
								<th runat="server">
									קוד משתמש</th>
								<th runat="server">
									משתמש</th>
							</tr>
							<tr ID="itemPlaceholder" runat="server">
							</tr>
						</table>
					</td>
				</tr>
				<tr runat="server">
					<td runat="server" style="">
					</td>
				</tr>
			</table>
		</LayoutTemplate>
	</asp:ListView>
</div>
</asp:Content>

