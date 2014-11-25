<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustApotroposTypes.aspx.vb" Inherits="CustApotroposTypes" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Size="Large" Text="טבלת מבטחים רפואיים"
                    Width="202px"></asp:Label></td>
            <td style="width: 100px" valign="top">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 169px" valign="top">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        BackColor="DodgerBlue" CellPadding="4" DataKeyNames="CustMedCareID" DataSourceID="SqlDataSource1"
        EmptyDataText="אין נתונים להצגה" ForeColor="#333333">
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה" NewText="חדש" SelectText="בחירה" UpdateText="עדכון" >
                <ItemStyle Wrap="False" />
            </asp:CommandField>
            <asp:BoundField DataField="CustMedCareID" HeaderText="מס'"
                ReadOnly="True" SortExpression="CustMedCareID" />
            <asp:BoundField DataField="CustMedCareName" HeaderText="מבטח רפואי"
                SortExpression="CustMedCareName" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#EFF3FB" Wrap="False" />
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" Wrap="False" />
        <HeaderStyle BackColor="#37A5FF" Font-Bold="True" ForeColor="White" Wrap="False" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
            </td>
            <td style="width: 100px; height: 169px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
                    DataKeyNames="CustMedCareID" DataSourceID="SqlDataSource1" DefaultMode="Insert"
                    ForeColor="#37A5FF" GridLines="None" HeaderText="הוספת מבטח רפואי" Height="50px"
                    Width="125px">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                    <EditRowStyle BackColor="#2461BF" />
                    <RowStyle BackColor="#EFF3FB" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <Fields>
                        <asp:BoundField DataField="CustApotroposTypeID" HeaderText="CustApotroposTypeID"
                            InsertVisible="False" ReadOnly="True" SortExpression="CustApotroposTypeID" />
                        <asp:BoundField DataField="CustMedCareName" HeaderText="מבטח רפואי" SortExpression="CustMedCareName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                    </Fields>
                    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                    <HeaderStyle BackColor="#37A5FF" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    &nbsp;
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT [CustMedCareName], [CustMedCareID] FROM [CustMedCare]" DeleteCommand="DELETE FROM [CustMedCare] WHERE [CustMedCareID] = @CustMedCareID" InsertCommand="INSERT INTO [CustMedCare] ([CustMedCareName]) VALUES (@CustMedCareName)" UpdateCommand="UPDATE [CustMedCare] SET [CustMedCareName] = @CustMedCareName WHERE [CustMedCareID] = @CustMedCareID">
        <DeleteParameters>
            <asp:Parameter Name="CustMedCareID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustMedCareName" Type="String" />
            <asp:Parameter Name="CustMedCareID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustMedCareName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

