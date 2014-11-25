<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p5aStatusTable.aspx.vb" Inherits="SysTables_p5aStatusTable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <div id="HDR">
            <asp:Label ID="Label1" runat="server" Text="טבלת סטטוס" Font-Bold="True" 
                Font-Size="Medium" ForeColor="Blue"></asp:Label>
        </div>
        <div id="BodyGrid">
            <table>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" DataKeyNames="StatusID" DataSourceID="dstab">
                            <Columns>
                                <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" 
                                    ShowDeleteButton="True" ShowEditButton="True" UpdateText="עדכון" />
                                <asp:BoundField DataField="RowID" HeaderText="מס" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RowID" />
                                <asp:BoundField DataField="StatusID" HeaderText="זיהוי" ReadOnly="True" 
                                    SortExpression="StatusID" />
                                <asp:BoundField DataField="Status" HeaderText="סטטוס" SortExpression="Status" />
                                <asp:BoundField DataField="TableName" HeaderText="טבלה" 
                                    SortExpression="TableName" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td valign="top">
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="StatusID" DataSourceID="dstab" DefaultMode="Insert" 
                            HeaderText="הוספת סטטוס חדש" Height="50px" Width="125px">
                            <Fields>
                                <asp:BoundField DataField="RowID" HeaderText="RowID" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RowID" />
                                <asp:BoundField DataField="StatusID" HeaderText="זיהוי" ReadOnly="True" 
                                    SortExpression="StatusID" />
                                <asp:BoundField DataField="Status" HeaderText="סטטוס" SortExpression="Status" />
                                <asp:BoundField DataField="TableName" HeaderText="טבלה" 
                                    SortExpression="TableName" />
                                <asp:CommandField CancelText="ביטול" InsertText="הוספה" 
                                    ShowInsertButton="True" />
                            </Fields>
                        </asp:DetailsView>
                    </td> 
               </tr>
           </table>
            <asp:SqlDataSource ID="dstab" runat="server" 
                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                DeleteCommand="DELETE FROM [ExEventStatus] WHERE [StatusID] = @StatusID" 
                InsertCommand="INSERT INTO [ExEventStatus] ([StatusID], [Status], [TableName]) VALUES (@StatusID, @Status, @TableName)" 
                SelectCommand="SELECT [RowID], [StatusID], [Status], [TableName] FROM [ExEventStatus]" 
                UpdateCommand="UPDATE [ExEventStatus] SET  [Status] = @Status, [TableName] = @TableName WHERE [StatusID] = @StatusID">
                <DeleteParameters>
                    <asp:Parameter Name="StatusID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Status" Type="String" />
                    <asp:Parameter Name="TableName" Type="String" />
                    <asp:Parameter Name="StatusID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="StatusID" Type="Int32" />
                    <asp:Parameter Name="Status" Type="String" />
                    <asp:Parameter Name="TableName" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>

</asp:Content>

