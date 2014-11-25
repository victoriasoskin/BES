<%@ Page Language="VB"MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FLM.aspx.vb" Inherits="Default2" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
    DataKeyNames="rowid" DataSourceID="AccessDataSource1" DefaultMode="Insert" 
    Height="50px" Width="125px">
    <Fields>
        <asp:BoundField DataField="rowid" HeaderText="rowid" InsertVisible="False" 
            ReadOnly="True" SortExpression="rowid" />
        <asp:BoundField DataField="FrameName" HeaderText="FrameName" 
            SortExpression="FrameName" />
        <asp:BoundField DataField="FrameManager" HeaderText="FrameManager" 
            SortExpression="FrameManager" />
        <asp:BoundField DataField="Service" HeaderText="Service"  
            SortExpression="Service" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
        <asp:CommandField ShowInsertButton="True" />
    </Fields>
</asp:DetailsView>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="rowid" 
    DataSourceID="AccessDataSource1" 
    EmptyDataText="There are no data records to display.">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:BoundField DataField="rowid" HeaderText="rowid" ReadOnly="True" 
            SortExpression="rowid" />
        <asp:BoundField DataField="FrameName" HeaderText="FrameName" 
            SortExpression="FrameName" />
        <asp:BoundField DataField="FrameManager" HeaderText="FrameManager" 
            SortExpression="FrameManager" />
        <asp:BoundField DataField="Service" HeaderText="Service" 
            SortExpression="Service" />
        <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
    </Columns>
</asp:GridView>
<asp:AccessDataSource ID="AccessDataSource1" runat="server" 
    DataFile="~\Sherut.mdb" 
    DeleteCommand="DELETE FROM `FrameList` WHERE `rowid` = ?" 
    InsertCommand="INSERT INTO `FrameList` ( `FrameName`, `FrameManager`, `Service`, `Email`) VALUES ( ?, ?, ?, ?)" 
    SelectCommand="SELECT `rowid`, `FrameName`, `FrameManager`, `Service`, `Email` FROM `FrameList`" 
    UpdateCommand="UPDATE `FrameList` SET `FrameName` = ?, `FrameManager` = ?, `Service` = ?, `Email` = ? WHERE `rowid` = ?">
    <DeleteParameters>
        <asp:Parameter Name="rowid" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="rowid" Type="Int32" />
        <asp:Parameter Name="FrameName" Type="String" />
        <asp:Parameter Name="FrameManager" Type="String" />
        <asp:Parameter Name="Service" Type="String" />
        <asp:Parameter Name="Email" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="FrameName" Type="String" />
        <asp:Parameter Name="FrameManager" Type="String" />
        <asp:Parameter Name="Service" Type="String" />
        <asp:Parameter Name="Email" Type="String" />
        <asp:Parameter Name="rowid" Type="Int32" />
    </UpdateParameters>
</asp:AccessDataSource>
</asp:Content>

