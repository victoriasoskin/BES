<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="p3aDetTrans.aspx.vb" Inherits="p3a_DetTrans" title="אגף כספים - פירוט תנועות" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <table style="width: 100%">
        <tr>
            <td>
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" 
                    ForeColor="#0033CC" Text="פירוט תנועות"></asp:Label>
            </td>
            <td>
                <a href="javascript:window.open('','_self','');window.close();">סגור</a>
             </td>
        </tr>
        <tr> 
            <td colspan="2">
                <asp:Label ID="LBLDET" runat="server" Text="Label" Width="413px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:GridView ID="GVTrans" runat="server" DataSourceID="DSTrans" 
                    AutoGenerateColumns="False" ShowFooter="True" CellPadding="4">
                    <Columns>
                        <asp:BoundField DataField="ReportDate" HeaderText="ת דיווח" 
                            SortExpression="ReportDate" DataFormatString="{0:MMM-yy}" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TType" HeaderText="סוג" 
                            SortExpression="TType" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="accountname" HeaderText="שם חשבון" 
                            SortExpression="accountname" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="transDate" HeaderText="ת אסמכתא" 
                            SortExpression="transDate" DataFormatString="{0:dd/MM/yy}" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Details" HeaderText="פרטים" 
                            SortExpression="Details" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Ref" HeaderText="אסמ'" 
                            SortExpression="Ref" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ContraAccountName" HeaderText="שם חשבון נגדי" 
                            SortExpression="ContraAccountName" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="סכום" SortExpression="LCAmount">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# dVal("LCAmount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltot" runat="server" text='<%# dtval() %>' ></asp:Label>
                            </FooterTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSTrans" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT SORTGROUP, SortGroupName, ACCOUNTKEY, accountname, ContraAccountKey, ContraAccountName, transDate, Details, LCAmount, Ref, Cutoff, ReportDate, BudItem, Frame, TType FROM p4t_DetTrans as p3v_DetTrans WHERE (BudgetCategoryID = @BCID) AND (FrameCategoryID = @FCID) AND (ReportDate BETWEEN @RDTF AND @RDTT) ORDER BY ReportDate, transDate" 
        CancelSelectOnNullParameter="False" >
        <SelectParameters>
            <asp:QueryStringParameter Name="BCID" QueryStringField="BCID" />
            <asp:QueryStringParameter Name="FCID" QueryStringField="FCID" />
            <asp:QueryStringParameter Name="RDTF" QueryStringField="RDTF" />
            <asp:QueryStringParameter Name="RDTT" QueryStringField="RDTT" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

