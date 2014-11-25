<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ServiceList.aspx.vb" Inherits="ServiceList" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="טבלת שירותים" Width="161px"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="UserGroupID" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." AllowPaging="True">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            <asp:BoundField DataField="UserGroupID" HeaderText="UserGroupID" ReadOnly="True"
                SortExpression="UserGroupID" InsertVisible="False" >
            </asp:BoundField>
            <asp:BoundField DataField="UserGroupName" HeaderText="UserGroupName" SortExpression="UserGroupName" />
            <asp:BoundField DataField="Stype" HeaderText="Stype" SortExpression="Stype" />
            <asp:BoundField DataField="CanDelete" HeaderText="CanDelete" 
                SortExpression="CanDelete" />
            <asp:BoundField DataField="CanEdit" HeaderText="CanEdit" 
                SortExpression="CanEdit" />
            <asp:BoundField DataField="SUSER" HeaderText="SUSER" SortExpression="SUSER" />
            <asp:BoundField DataField="MultiFrame" HeaderText="MultiFrame" 
                SortExpression="MultiFrame" />
        </Columns>
    </asp:GridView>
            </td>
            <td style="width: 100px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="UserGroupID"
                    DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="50px" Width="125px" HeaderText="הוספת שירות">
                    <Fields>
                        <asp:BoundField DataField="UserGroupID" HeaderText="UserGroupID" 
                            SortExpression="UserGroupID" InsertVisible="False" ReadOnly="True" />
                        <asp:BoundField DataField="UserGroupName" HeaderText="UserGroupName" 
                            SortExpression="UserGroupName" />
                        <asp:BoundField DataField="Stype" HeaderText="Stype" SortExpression="Stype" />
                        <asp:BoundField DataField="CanDelete" HeaderText="CanDelete" 
                            SortExpression="CanDelete" />
                        <asp:BoundField DataField="CanEdit" HeaderText="CanEdit" 
                            SortExpression="CanEdit" />
                        <asp:BoundField DataField="SUSER" HeaderText="SUSER" SortExpression="SUSER" />
                        <asp:BoundField DataField="MultiFrame" HeaderText="MultiFrame" 
                            SortExpression="MultiFrame" />
                        <asp:CommandField ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        DeleteCommand="DELETE FROM [p0t_UGroup] WHERE [UserGroupID] = @UserGroupID" InsertCommand="INSERT INTO [p0t_UGroup] ([UserGroupName], [Stype], [CanDelete], [CanEdit], [SUSER], [MultiFrame]) VALUES (@UserGroupName, @Stype, @CanDelete, @CanEdit, @SUSER, @MultiFrame)"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT * FROM [p0t_UGroup]" 
        UpdateCommand="UPDATE [p0t_UGroup] SET [UserGroupName] = @UserGroupName, [Stype] = @Stype, [CanDelete] = @CanDelete, [CanEdit] = @CanEdit, [SUSER] = @SUSER, [MultiFrame] = @MultiFrame WHERE [UserGroupID] = @UserGroupID">
        <InsertParameters>
            <asp:Parameter Name="UserGroupName" Type="String" />
            <asp:Parameter Name="Stype" Type="String" />
            <asp:Parameter Name="CanDelete" Type="Int32" />
            <asp:Parameter Name="CanEdit" Type="Int32" />
            <asp:Parameter Name="SUSER" Type="Int32" />
            <asp:Parameter Name="MultiFrame" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserGroupName" Type="String" />
            <asp:Parameter Name="Stype" Type="String" />
            <asp:Parameter Name="CanDelete" Type="Int32" />
            <asp:Parameter Name="CanEdit" Type="Int32" />
            <asp:Parameter Name="SUSER" Type="Int32" />
            <asp:Parameter Name="MultiFrame" Type="Int32" />
            <asp:Parameter Name="UserGroupID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="UserGroupID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

