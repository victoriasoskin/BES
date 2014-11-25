<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventGroups.aspx.vb" Inherits="Default3" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSEVENTGROUPS" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        
        SelectCommand="SELECT CustEventGroups.CustEventGroupName, CustEventGroups.CustEventGroupID, CustEventGroups.CustEventServiceID, ServiceList.ServiceName, CustEventGroups.CustEventGrouporder, CustEventGroups.CustEventGroupSort FROM CustEventGroups LEFT OUTER JOIN ServiceList ON CustEventGroups.CustEventServiceID = ServiceList.ServiceID" 
        DeleteCommand="DELETE FROM [CustEventGroups] WHERE [CustEventGroupID] = @CustEventGroupID" 
        InsertCommand="INSERT INTO [CustEventGroups] ([CustEventGroupName], [CustEventServiceID],CustEventGroupOrder,CustEventGroupSort) VALUES (@CustEventGroupName, @CustEventServiceID,@CustEventGroupOrder,@CustEventGroupSort)" UpdateCommand="UPDATE [CustEventGroups] SET [CustEventGroupName] = @CustEventGroupName, [CustEventServiceID] = @CustEventServiceID, CustEventGroupOrder = @CustEventGroupOrder,CustEventGroupSort = @CustEventGroupSort 
WHERE [CustEventGroupID] = @CustEventGroupID">
        <DeleteParameters>
            <asp:Parameter Name="CustEventGroupID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustEventGroupName" Type="String" />
            <asp:Parameter Name="CustEventServiceID" Type="Int32"/>
            <asp:Parameter Name="CustEventGroupOrder" />
            <asp:Parameter Name="CustEventGroupSort" />
            <asp:Parameter Name="CustEventGroupID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustEventGroupName" Type="String" />
            <asp:Parameter Name="CustEventServiceID" Type="Int32" />
            <asp:Parameter Name="CustEventGroupOrder" />
            <asp:Parameter Name="CustEventGroupSort" />
        </InsertParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 85px; height: 19px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="טבלת קבוצות פעולות"
                    Width="175px"></asp:Label></td>
            <td style="width: 100px; height: 19px">
            </td>
        </tr>
        <tr>
            <td style="width: 85px; height: 149px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    DataKeyNames="CustEventGroupID" DataSourceID="DSEVENTGROUPS" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowDeleteButton="True" ShowEditButton="True"
                            UpdateText="עדכון">
                            <ItemStyle Wrap="False" />
                        </asp:CommandField>
                        <asp:BoundField DataField="CustEventGroupID" HeaderText="מס'" ReadOnly="True" SortExpression="CustEventGroupID" />
                        <asp:BoundField DataField="CustEventGroupName" HeaderText="קבוצת פעולות" SortExpression="CustEventGroupName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="שירות" SortExpression="ServiceName">
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DSSERVICES" DataTextField="ServiceName"
                                    DataValueField="ServiceID" SelectedValue='<%# bind("CustEventServiceID") %>' AppendDataBoundItems="True">
                                    <asp:ListItem Text="<כל השירותים>" Value="" />
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventGroupOrder" HeaderText="סדר סטטוס" SortExpression="CustEventGroupOrder" />
                        <asp:CheckBoxField DataField="CustEventGroupSort" HeaderText="מיון מועמדים" 
                            SortExpression="CustEventGroupSort" />
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px; height: 149px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="CustOriginOfficeTypeID"
                    DataSourceID="DSEVENTGROUPS" DefaultMode="Insert" HeaderText="הוספת קבוצת פעולות"
                    Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="CustEventGroupID" HeaderText="CustEventGroupID" InsertVisible="False"
                            ReadOnly="True" SortExpression="CustEventGroupID" Visible="False">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustEventGroupName" HeaderText="קבוצת פעולות" SortExpression="CustEventGroupName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="שירות">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="DSSERVICES" DataTextField="ServiceName"
                                    DataValueField="ServiceID" SelectedValue='<%# Bind("CustEventServiceID") %>' AppendDataBoundItems="True">
                                     <asp:ListItem Text="&lt;כל השירותים&gt;" value=""/>
                               </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventGroupOrder" HeaderText="סדר סטטוס" SortExpression="CustEventGroupOrder" />
                        <asp:CheckBoxField DataField="CustEventGroupSort" HeaderText="מיון מועמדים" 
                            SortExpression="CustEventGroupSort" />
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                    </Fields>
                    <HeaderStyle Font-Bold="False" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
</asp:Content>

