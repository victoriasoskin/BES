<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CoordFrames.aspx.vb" Inherits="CoordFrames" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="hdrdiv">התאמת מבנה ארגוני</div>
<div class="reldiv">

	<asp:GridView ID="gvframes" runat="server" AutoGenerateColumns="False" 
		DataKeyNames="SherutFrameID" DataSourceID="dsframes" 
        EnableModelValidation="True">
		<Columns>
			<asp:CommandField CancelText="ביטול" EditText="עריכה" ShowEditButton="True" 
                UpdateText="עדכון" />
			<asp:BoundField DataField="SherutFrameID" HeaderText="קוד באתר" ReadOnly="True" 
				SortExpression="SherutFrameID" />
			<asp:BoundField DataField="ServiceName" HeaderText="שם אזור באתר" 
				SortExpression="ServiceName" ReadOnly="True" /> 
			<asp:BoundField DataField="FrasmeNameF" HeaderText="שם מסגרת באתר" 
				SortExpression="FrasmeNameF" ReadOnly="True" />
			<asp:BoundField DataField="FFrameID" HeaderText="קוד בכספים" 
				SortExpression="FFrameID" ReadOnly="True" />
			<asp:BoundField DataField="שירות_-_1" HeaderText="אזור בכספים" 
				SortExpression="שירות_-_1" ReadOnly="True" />
			<asp:TemplateField HeaderText="מסגרת בכספים" SortExpression="Frame">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddlframes" runat="server" 
                        DataSourceID="dsfinanceframelist" DataTextField="Frame" 
                        DataValueField="FinanceFrameID" SelectedValue='<%# Bind("FinanceFrameID") %>' AppendDataBoundItems="true">
                        <asp:ListItem Value="">[בחר מסגרת]</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("Frame") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
		</Columns>
	</asp:GridView>
	<asp:SqlDataSource ID="dsfinanceframelist" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT isnull([שירות_-_3] , [שירות_-_2]) AS Frame, [CategoryID] as FinanceFrameID FROM [SHERUT_besqxl] Where isnull([שירות_-_3] , [שירות_-_2]) is not null order by isnull([שירות_-_3] , [שירות_-_2]) ">
    </asp:SqlDataSource>
	<asp:SqlDataSource ID="dsframes" runat="server" 
		ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
		SelectCommand="SELECT SherutFrameID, ServiceName, FrasmeNameF, FinanceFrameID As FFrameID, [שירות_-_1], ISNULL([שירות_-_3], [שירות_-_2]) AS Frame, FrameName, CategoryID as FinanceFrameID FROM p0v_CoordFrames ORDER BY FrasmeNameF" 
        
        
        UpdateCommand="if Exists (Select * from p0t_CoordFrameID where SherutFrameID=@SherutFrameID)
Update p0t_CoordFrameID set FinanceFrameID=@FinanceFrameID where SherutFrameID=@SherutFrameID
Else
Insert into p0t_CoordFrameID(SherutFrameID,FinanceFrameID) Values(@SherutFrameID,@FinanceFrameID)">
        <UpdateParameters>
            <asp:Parameter Name="SherutFrameID" Type="Int32" />
            <asp:Parameter Name="FinanceFrameID" Type="Int32" />
        </UpdateParameters>
	</asp:SqlDataSource>

</div>
</asp:Content>

