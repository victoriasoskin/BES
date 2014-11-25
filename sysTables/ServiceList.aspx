<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ServiceList.aspx.vb" Inherits="ServiceList" title="בית אקשטיין - טבלת שירותים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" 
					Text="טבלת אזורים/חטיבות" Width="161px"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="ServiceID" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display.">
        <Columns>
            <asp:TemplateField ShowHeader="False">
				<ItemTemplate>
					<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
						CommandName="Edit" Text="עריכה"></asp:LinkButton>
					&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" onclientclick="return confirm('האם למחוק את האזור?');"
						CommandName="Delete" Text="מחיקה"></asp:LinkButton>
				</ItemTemplate>
				<EditItemTemplate>
					<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
						CommandName="Update" Text="עדכון"></asp:LinkButton>
					&nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
						CommandName="Cancel" Text="ביטול"></asp:LinkButton>
				</EditItemTemplate>
				<ItemStyle Wrap="False" />
			</asp:TemplateField>
            <asp:BoundField DataField="ServiceID" HeaderText="מס'" ReadOnly="True" SortExpression="ServiceID" />
            <asp:BoundField DataField="ServiceName" HeaderText="שם האיזור/חטיבה" 
				SortExpression="ServiceName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="FirstMonthofworkyear" HeaderText="חודש תחילת שנת העבודה"
                SortExpression="FirstMonthofworkyear" />
        </Columns>
    </asp:GridView>
            </td>
            <td style="width: 100px" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="ServiceID"
                    DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="50px" Width="125px" HeaderText="הוספת שירות">
                    <Fields>
                        <asp:BoundField DataField="ServiceID" HeaderText="ServiceID" InsertVisible="False"
                            ReadOnly="True" SortExpression="ServiceID" Visible="False" />
                        <asp:BoundField DataField="ServiceName" HeaderText="שם האזור/חטיבה" 
							SortExpression="ServiceName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="FirstMonthofworkyear" HeaderText="חודש תחילת שנת העבודה"
                            SortExpression="FirstMonthofworkyear" />
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [ServiceList] WHERE [ServiceID] = @ServiceID" InsertCommand="INSERT INTO [ServiceList] ([ServiceName], [FirstMonthofworkyear]) VALUES (@ServiceName, @FirstMonthofworkyear)"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT [ServiceID], [ServiceName], [FirstMonthofworkyear] FROM [ServiceList]" UpdateCommand="UPDATE [ServiceList] SET [ServiceName] = @ServiceName, [FirstMonthofworkyear] = @FirstMonthofworkyear WHERE [ServiceID] = @ServiceID">
        <InsertParameters>
            <asp:Parameter Name="ServiceName" Type="String" />
            <asp:Parameter Name="FirstMonthofworkyear" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="ServiceName" Type="String" />
            <asp:Parameter Name="FirstMonthofworkyear" Type="Int32" />
            <asp:Parameter Name="ServiceID" Type="Int32" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="ServiceID" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

