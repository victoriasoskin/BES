<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="p2aPNTrans.aspx.vb" Inherits="PNTrans" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td colspan="3">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="������ ������" Width="176px"></asp:Label>
                <asp:CheckBox ID="CBBOTH" runat="server" AutoPostBack="True" Text="��� �� ������ ������ �� ������ ����� �����"
                    Width="295px" /></td>
        </tr>
        <tr>
            <td style="width: 100px"> 
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="DSTrans" CellPadding="2" DataKeyNames="OrgRowID">
                    <Columns>
                        <asp:CommandField CancelText="�����" DeleteText="�����" EditText="�����" ShowDeleteButton="True"
                            ShowEditButton="True" UpdateText="�����" />
                        <asp:BoundField DataField="Type" HeaderText="���" SortExpression="Type" ReadOnly="True" />
                        <asp:BoundField DataField="OrgFrame" HeaderText="����� ����" SortExpression="OrgFrame" ReadOnly="True">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACTID" HeaderText="ACTID" SortExpression="ACTID" Visible="False" ReadOnly="True" />
                        <asp:BoundField DataField="SortGroup" HeaderText="��� ����" SortExpression="SortGroup" ReadOnly="True" />
                        <asp:BoundField DataField="SortGroupName" HeaderText="����� ����" SortExpression="SortGroupName" ReadOnly="True" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AccountKey" HeaderText="�����" SortExpression="AccountKey" ReadOnly="True" />
                        <asp:BoundField DataField="accountname" HeaderText="�� �����" SortExpression="accountname" ReadOnly="True" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="� ������" SortExpression="transDate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("transDate", "{0:dd/MM/yy}") %>'></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TextBox1"
                                    Display="Dynamic" ErrorMessage="����� �� ����" MaximumValue="31/12/2015" MinimumValue="1/1/2007"
                                    Type="Date"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("transDate", "{0:dd/MM/yy}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="�����" SortExpression="Details">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Details") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="����" SortExpression="LCAmount">
                            <EditItemTemplate>
                                &nbsp;<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("LCAmount") %>'></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="TextBox3"
                                    Display="Dynamic" ErrorMessage="���� �� ����" MaximumValue="999999999" MinimumValue="-9999999999"
                                    Type="Double"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("LCAmount", "{0:N2}") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="src" HeaderText="src" SortExpression="src" Visible="False" ReadOnly="True" />
                        <asp:BoundField DataField="Frame" HeaderText="�����" SortExpression="Frame" ReadOnly="True">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="budget" HeaderText="�����" SortExpression="budget" ReadOnly="True">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OrgrowID" Visible="False" />
                    </Columns>
                </asp:GridView>
            </td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:Button ID="Button1" runat="server" PostBackUrl="~/p2aBVAREP.aspx" Text="���� ����" /></td>
            <td style="width: 100px">
            </td>
            <td style="width: 100px">
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSTrans" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT OrgRowID, Company, ACTID, SortGroup, SortGroupName, AccountKey, accountname, transDate, Details, LCAmount, CASE orgrowid % 1000 WHEN 886 THEN '�����' WHEN 887 THEN '�����' WHEN 888 THEN '��' ELSE '' END AS Type, OrgFrameID, Budget AS budget, Frame, OrgFrame FROM p2v_AddClassified AS p2v_DetailedTrans WHERE (BudgetCategoryID = @BudgetCategoryID) AND (FrameCategoryID = @FrameCategoryID) OR (@CBBOTH = 1) AND (CorID IN (SELECT CorID FROM p2v_AddClassified WHERE (BudgetCategoryID = @BudgetCategoryID) AND (FrameCategoryID = @FrameCategoryID)))" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="BudgetCategoryID" QueryStringField="BudgetItemID"
                Type="Int32" />
            <asp:QueryStringParameter Name="FrameCategoryID" QueryStringField="FrameID" Type="Int32" />
            <asp:ControlParameter ControlID="CBBOTH" Name="CBBOTH" PropertyName="Checked" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

