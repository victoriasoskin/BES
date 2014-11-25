<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustOriginOfficeList.aspx.vb" Inherits="CustOriginOfficeList" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSOriginOffice" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        DeleteCommand="DELETE FROM [CustOriginofficeList] WHERE [CustOriginOfficeID] = @CustOriginOfficeID"
        InsertCommand="INSERT INTO [CustOriginofficeList] ([CustOriginOfficeName], [CustOriginbOfficeAddress1], [CustOriginOfficeAddress2], [CustOriginOfficeTypeID], [CustOriginOfficePhone], [CustOriginOfficeFax], [CustOriginOfficeEmail], [CustOriginOfficeContact1Name], [CustOriginOfficeContact1phone], [CustOriginOfficeContact2Name], [CustOriginOfficeContact2phone]) VALUES (@CustOriginOfficeName, @CustOriginbOfficeAddress1, @CustOriginOfficeAddress2, @CustOriginOfficeTypeID, @CustOriginOfficePhone, @CustOriginOfficeFax, @CustOriginOfficeEmail, @CustOriginOfficeContact1Name, @CustOriginOfficeContact1phone, @CustOriginOfficeContact2Name, @CustOriginOfficeContact2phone)"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT CustOriginofficeList.CustOriginOfficeID, CustOriginofficeList.[CustOriginOfficeName] AS CustOriginOfficeName, CustOriginofficeList.CustOriginbOfficeAddress1, CustOriginofficeList.CustOriginOfficeAddress2, CustOriginofficeList.CustOriginOfficeTypeID, CustOriginofficeList.CustOriginOfficePhone, CustOriginofficeList.CustOriginOfficeFax, CustOriginofficeList.CustOriginOfficeEmail, CustOriginofficeList.CustOriginOfficeContact1Name, CustOriginofficeList.CustOriginOfficeContact1phone, CustOriginofficeList.CustOriginOfficeContact2Name, CustOriginofficeList.CustOriginOfficeContact2phone, CustOriginOfficeTypes.CustOriginOfficeTypeName FROM CustOriginofficeList LEFT OUTER JOIN CustOriginOfficeTypes ON CustOriginofficeList.CustOriginOfficeTypeID = CustOriginOfficeTypes.CustOriginOfficeTypeID"
        UpdateCommand="UPDATE [CustOriginofficeList] SET [CustOriginOfficeName] = @CustOriginOfficeName, [CustOriginbOfficeAddress1] = @CustOriginbOfficeAddress1, [CustOriginOfficeAddress2] = @CustOriginOfficeAddress2, [CustOriginOfficeTypeID] = @CustOriginOfficeTypeID, [CustOriginOfficePhone] = @CustOriginOfficePhone, [CustOriginOfficeFax] = @CustOriginOfficeFax, [CustOriginOfficeEmail] = @CustOriginOfficeEmail, [CustOriginOfficeContact1Name] = @CustOriginOfficeContact1Name, [CustOriginOfficeContact1phone] = @CustOriginOfficeContact1phone, [CustOriginOfficeContact2Name] = @CustOriginOfficeContact2Name, [CustOriginOfficeContact2phone] = @CustOriginOfficeContact2phone WHERE [CustOriginOfficeID] = @CustOriginOfficeID">
        <DeleteParameters>
            <asp:Parameter Name="CustOriginOfficeID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustOriginOfficeName" Type="String" />
            <asp:Parameter Name="CustOriginbOfficeAddress1" Type="String" />
            <asp:Parameter Name="CustOriginOfficeAddress2" Type="String" />
            <asp:Parameter Name="CustOriginOfficeTypeID" Type="Int32" />
            <asp:Parameter Name="CustOriginOfficePhone" Type="String" /> 
            <asp:Parameter Name="CustOriginOfficeFax" Type="String" />
            <asp:Parameter Name="CustOriginOfficeEmail" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact1Name" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact1phone" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact2Name" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact2phone" Type="String" />
            <asp:Parameter Name="CustOriginOfficeID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustOriginOfficeName" Type="String" />
            <asp:Parameter Name="CustOriginbOfficeAddress1" Type="String" />
            <asp:Parameter Name="CustOriginOfficeAddress2" Type="String" />
            <asp:Parameter Name="CustOriginOfficeTypeID" Type="Int32" />
            <asp:Parameter Name="CustOriginOfficePhone" Type="String" />
            <asp:Parameter Name="CustOriginOfficeFax" Type="String" />
            <asp:Parameter Name="CustOriginOfficeEmail" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact1Name" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact1phone" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact2Name" Type="String" />
            <asp:Parameter Name="CustOriginOfficeContact2phone" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label2" runat="server" Font-Size="Large" Text="גורמים מפנים"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="CustOriginOfficeID" DataSourceID="DSOriginOffice"
                    EmptyDataText="There are no data records to display.">
                    <Columns>
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" UpdateText="עדכון" ShowDeleteButton="True" ShowEditButton="True" />
                        <asp:BoundField DataField="CustOriginOfficeID" HeaderText="CustOriginOfficeID" ReadOnly="True"
                            SortExpression="CustOriginOfficeID" Visible="False" />
                        <asp:BoundField DataField="CustOriginOfficeName" HeaderText="שם" SortExpression="CustOriginOfficeName" />
                        <asp:BoundField DataField="CustOriginbOfficeAddress1" HeaderText="כתובת" SortExpression="CustOriginbOfficeAddress1" />
                        <asp:BoundField DataField="CustOriginOfficeAddress2" HeaderText="כתובת" SortExpression="CustOriginOfficeAddress2" />
                        <asp:TemplateField HeaderText="סוג" SortExpression="CustOriginOfficeTypeID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DSOriginOfficeTypes"
                                    DataTextField="CustOriginOfficeTypeName" DataValueField="CustOriginOfficeTypeID"
                                    SelectedValue='<%# Bind("CustOriginOfficeTypeID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustOriginOfficeTypeName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustOriginOfficePhone" HeaderText="טלפון" SortExpression="CustOriginOfficePhone" />
                        <asp:BoundField DataField="CustOriginOfficeFax" HeaderText="פקס" SortExpression="CustOriginOfficeFax" />
                        <asp:BoundField DataField="CustOriginOfficeContact1Name" HeaderText="איש קשר 1" SortExpression="CustOriginOfficeContact1Name" />
                        <asp:BoundField DataField="CustOriginOfficeContact1phone" HeaderText="טלפון" SortExpression="CustOriginOfficeContact1phone" />
                        <asp:BoundField DataField="CustOriginOfficeContact2Name" HeaderText="איש קשר 2" SortExpression="CustOriginOfficeContact2Name" />
                        <asp:BoundField DataField="CustOriginOfficeContact2phone" HeaderText="טלפון" SortExpression="CustOriginOfficeContact2phone" />
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="CustOriginOfficeID"
                    DataSourceID="DSOriginOffice" DefaultMode="Insert" HeaderText="הוספת גורם" Height="50px"
                    Width="125px">
                    <Fields>
                        <asp:BoundField DataField="CustOriginOfficeID" HeaderText="CustOriginOfficeID" InsertVisible="False"
                            ReadOnly="True" SortExpression="CustOriginOfficeID" Visible="False" />
                        <asp:BoundField DataField="CustOriginOfficeName" HeaderText="שם" SortExpression="CustOriginOfficeName" />
                        <asp:TemplateField HeaderText="סוג" SortExpression="CustOriginOfficeTypeID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustOriginOfficeTypeID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="DSOriginOfficeTypes"
                                    DataTextField="CustOriginOfficeTypeName" DataValueField="CustOriginOfficeTypeID"
                                    SelectedValue='<%# Bind("CustOriginOfficeTypeID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustOriginOfficeTypeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustOriginbOfficeAddress1" HeaderText="כתובת" SortExpression="CustOriginbOfficeAddress1" />
                        <asp:BoundField DataField="CustOriginOfficeAddress2" HeaderText="כתובת" SortExpression="CustOriginOfficeAddress2" />
                        <asp:BoundField DataField="CustOriginOfficePhone" HeaderText="טלפון" SortExpression="CustOriginOfficePhone" />
                        <asp:BoundField DataField="CustOriginOfficeFax" HeaderText="פקס" SortExpression="CustOriginOfficeFax" />
                        <asp:BoundField DataField="CustOriginOfficeContact1Name" HeaderText="איש קשר 1" SortExpression="CustOriginOfficeContact1Name" />
                        <asp:BoundField DataField="CustOriginOfficeContact1phone" HeaderText="טלפון" SortExpression="CustOriginOfficeContact1phone" />
                        <asp:BoundField DataField="CustOriginOfficeContact2Name" HeaderText="איש קשר 2" SortExpression="CustOriginOfficeContact2Name" />
                        <asp:BoundField DataField="CustOriginOfficeContact2phone" HeaderText="טלפון" SortExpression="CustOriginOfficeContact2phone" />
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSOriginOfficeTypes" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustOriginOfficeTypeName], [CustOriginOfficeTypeID] FROM [CustOriginOfficeTypes]">
    </asp:SqlDataSource>
</asp:Content>

