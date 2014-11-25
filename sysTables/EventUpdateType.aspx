<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="EventUpdateType.aspx.vb" Inherits="Default3" title="��� ������� - ���� ���� �����" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT [CustEventupdateType], [CustEventUpdateTypeID] FROM [CustEventUpdateType]" DeleteCommand="DELETE FROM [CustEventUpdateType] WHERE [CustEventUpdateTypeID] = @CustEventUpdateTypeID" InsertCommand="INSERT INTO [CustEventUpdateType] ([CustEventupdateType], [CustEventUpdateTypeID]) VALUES (@CustEventupdateType, @CustEventUpdateTypeID)" UpdateCommand="UPDATE [CustEventUpdateType] SET [CustEventupdateType] = @CustEventupdateType ,[CustEventUpdateTypeID] = @CustEventUpdateTypeID WHERE [CustEventUpdateTypeID] = @CustEventUpdateTypeID">
        <DeleteParameters>
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustEventupdateType" Type="String" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustEventupdateType" Type="String" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 85px; height: 19px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="���� ���� �����" Width="175px"></asp:Label></td>
            <td style="width: 100px; height: 19px">
            </td>
        </tr>
        <tr>
            <td style="width: 85px; height: 149px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    DataKeyNames="CustEventupdateTypeID" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:CommandField CancelText="�����" DeleteText="�����" EditText="�����" InsertText="�����"
                            NewText="���" SelectText="�����" ShowDeleteButton="True" ShowEditButton="True"
                            UpdateText="�����">
                            <ItemStyle Wrap="False" />
                        </asp:CommandField>
                        <asp:BoundField DataField="CustEventUpdateTypeID" HeaderText="��'" ReadOnly="True"
                            SortExpression="CustEventUpdateTypeID" />
                        <asp:BoundField DataField="CustEventUpdateType" HeaderText="��� �����" SortExpression="CustEventupdateType">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px; height: 149px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="CustEventupdateTypeID"
                    DataSourceID="SqlDataSource1" DefaultMode="Insert" HeaderText="����� ��� ���� ����"
                    Height="50px" Width="125px">
                    <Fields>
                        <asp:BoundField DataField="CustEventupdateTypeID" HeaderText="CustEventupdateTypeID"
                            InsertVisible="False" ReadOnly="True" SortExpression="CustEventupdateTypeID"
                            Visible="False">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustEventUpdateTypeID" HeaderText="��'" ReadOnly="True"
                            SortExpression="CustEventUpdateTypeID" />
                        <asp:BoundField DataField="CustEventupdateTypeName" HeaderText="��� �����" SortExpression="CustEventupdateTypeName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:CommandField CancelText="�����" DeleteText="�����" EditText="�����" InsertText="�����"
                            NewText="���" SelectText="�����" ShowInsertButton="True" UpdateText="�����" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
</asp:Content>

