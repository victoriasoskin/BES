<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="Items.aspx.vb" Inherits="Default3" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <span style="font-size: 14pt; color: #3300cc"></span>
    <table>
        <tr>
            <td colspan="2" style="height: 9px">
                <strong><span style="font-size: 14pt; color: #3300cc">הגדרת סעיפי דיווח</span></strong></td>
        </tr>
        <tr>
            <td style="width: 270px">
    בחירת שירות &nbsp;&nbsp;
    <asp:DropDownList ID="DropDownListServices" runat="server" AutoPostBack="True" DataSourceID="AccessDataSourceServices"
        DataTextField="ServiceName" DataValueField="ServiceID">
    </asp:DropDownList></td>
            <td style="width: 100px">
            </td>
        </tr> 
        <tr>
            <td style="width: 270px">
                &nbsp;&nbsp;&nbsp;
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataSourceID="AccessDataSourceItems">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="ItemID" HeaderText="ItemID" InsertVisible="False" SortExpression="ItemID" Visible=false/>
                        <asp:BoundField DataField="ItemName" HeaderText="ItemName" SortExpression="ItemName" />
                        <asp:BoundField DataField="ServiceID" HeaderText="ServiceID" SortExpression="ServiceID" />
                        <asp:BoundField DataField="DataType" HeaderText="DataType" SortExpression="DataType" />
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px" valign="top">
                &nbsp;
            </td>
        </tr>
    </table>
    &nbsp;<br />
    &nbsp;&nbsp;&nbsp;
    <asp:AccessDataSource ID="AccessDataSourceDataType" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT [DataTypeID], [DataType] FROM [DataTypes]">
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceServices" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT [ServiceID], [ServiceName] FROM [MR_Services]" UpdateCommand="update MR_ItemList set ItemName=@ItemName,DataType=@TataType Where ItemId=@ItemID">
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceItems" runat="server" DataFile="App_Data\Sherut.mdb"
        DeleteCommand="DELETE FROM `MR_ItemList` WHERE `ItemID` = ?" InsertCommand="INSERT INTO `MR_ItemList` (`ItemID`, `ItemName`, `ServiceID`, `DataTypeID`) VALUES (?, ?, ?, ?)"
        SelectCommand="SELECT MR_ItemList.ItemID, MR_ItemList.ItemName, MR_ItemList.ServiceID, MR_ItemList.DataTypeID, DataTypes.DataType FROM (MR_ItemList LEFT OUTER JOIN DataTypes ON MR_ItemList.DataTypeID = DataTypes.DataTypeID) WHERE (MR_ItemList.ServiceID = ?)"
        UpdateCommand="UPDATE MR_ItemList SET ItemName = @ItemName, DataTypeID = @DataTypeID WHERE (ItemID = [@RowID])">
        <InsertParameters>
            <asp:Parameter Name="ItemID" Type="Int32" />
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="ServiceID" Type="Int32" />
            <asp:Parameter Name="DataTypeID" Type="Int32" />
        </InsertParameters>
        <DeleteParameters>
            <asp:Parameter Name="ItemID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ItemName" Type="String" />
            <asp:Parameter Name="DataTypeID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownListServices" Name="?" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:AccessDataSource>
</asp:Content>

