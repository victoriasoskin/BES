<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustOriginOfficeTypes.aspx.vb" Inherits="CustOriginOfficeType" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 85px; height: 19px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="���� ���� ������ �����" Width="175px"></asp:Label></td>
            <td style="width: 100px; height: 19px">
            </td>
        </tr>
        <tr>
            <td style="width: 85px; height: 149px;" valign="top">
                <asp:GridView  ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    DataKeyNames="CustOriginOfficeTypeID" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="�����" DeleteText="�����" EditText="�����" InsertText="�����" NewText="���" SelectText="�����" UpdateText="�����" >
                            <ItemStyle Wrap="False" />
                        </asp:CommandField>
                        <asp:BoundField DataField="CustOriginOfficeTypeID" HeaderText="��'" ReadOnly="True"
                            SortExpression="CustOriginOfficeTypeID" />
                        <asp:BoundField DataField="CustOriginOfficeTypeName" HeaderText="��� ���� ����" SortExpression="CustOriginOfficeTypeName" >
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px; height: 149px;" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="CustOriginOfficeTypeID"
                    DataSourceID="SqlDataSource1" HeaderText="����� ��� ���� ����" Height="50px"
                    Width="125px" DefaultMode="Insert">
                    <Fields>
                        <asp:BoundField DataField="CustOriginOfficeTypeID" HeaderText="CustOriginOfficeTypeID"
                            InsertVisible="False" ReadOnly="True" SortExpression="CustOriginOfficeTypeID" Visible="False" >
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustOriginOfficeTypeName" HeaderText="��� ���� ����" SortExpression="CustOriginOfficeTypeName" >
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        DeleteCommand="DELETE FROM [CustOriginOfficeTypes] WHERE [CustOriginOfficeTypeID] = @CustOriginOfficeTypeID"
        InsertCommand="INSERT INTO [CustOriginOfficeTypes] ([CustOriginOfficeTypeName]) VALUES (@CustOriginOfficeTypeName)"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT [CustOriginOfficeTypeID], [CustOriginOfficeTypeName] FROM [CustOriginOfficeTypes]"
        UpdateCommand="UPDATE [CustOriginOfficeTypes] SET [CustOriginOfficeTypeName] = @CustOriginOfficeTypeName WHERE [CustOriginOfficeTypeID] = @CustOriginOfficeTypeID">
        <InsertParameters>
            <asp:Parameter Name="CustOriginOfficeTypeName" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustOriginOfficeTypeName" Type="String" />
            <asp:Parameter Name="CustOriginOfficeTypeID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustOriginOfficeTypeID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

