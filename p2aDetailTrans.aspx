<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="p2aDetailTrans.aspx.vb" Inherits="p2a_DetailTrans" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 103px; height: 22px">
                <asp:Label ID="LBTITLE" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="פירוט נתוני בפועל - תנועות לחשבון" Width="689px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 103px; height: 18px"> 
                <asp:Label ID="LBSUBTITLE" runat="server" Text="מסגרת:" Width="507px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 103px; height: 213px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="3" DataSourceID="DSACC" PageSize="18" ShowFooter="True">
                    <Columns>
                        <asp:BoundField DataField="transDate" DataFormatString="{0:dd/MM/yy}" HeaderText="תאריך אסמכתא"
                            SortExpression="transDate">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CFDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת ערך"
                            SortExpression="CFDate">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="פרטים" SortExpression="Details">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Details") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# TRUNCFIELD("Details",25) %>' ToolTip='<%# Eval("Details") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ContraSortGroup" HeaderText="מיון נגדי" SortExpression="ContraSortGroup">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="מיון נגדי" SortExpression="ContraSortGroupName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ContraSortGroupName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# truncfield("ContraSortGroupName",25) %>'
                                    ToolTip='<%# Eval("ContraSortGroupName") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="ContraAccountKey" HeaderText="חן נגדי" SortExpression="ContraAccountKey">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="חן נגדי" SortExpression="ContraAccountName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ContraAccountName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# truncfield("ContraAccountName",22) %>'
                                    ToolTip='<%# Eval("ContraAccountName") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Ref" HeaderText="אסמכתא" SortExpression="Ref">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TransType" HeaderText="סוג ת" SortExpression="TransType">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="סכום" SortExpression="LCAmount">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# GetColValue(decimal.Parse(Eval("LCAmount").ToString()),9).ToString("N2") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <FooterTemplate>
                             <%#GetTotal(9).ToString("N2")%>
                            </FooterTemplate>
                            <FooterStyle Wrap="False" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <input onclick="history.back()" type="button" value="חזרה לפרוט חשבונות" /></td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSACC" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT transDate, CFDate, Details, ContraSortGroup, ContraSortGroupName, ContraAccountKey, ContraAccountName, Ref, TRANSTYPE, LCAmount, Mtransdate, BudgetCategoryID, FrameCategoryID FROM p2v_Actual WHERE (ACTID = @ActID) AND (Mtransdate BETWEEN @DateS AND @DateB) AND (BudgetCategoryID = @BudgetitemID) AND (FrameCategoryID = @FrameID)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="ACTID" QueryStringField="ACTID" Type=Int64 />
            <asp:SessionParameter DefaultValue="" Name="Dates" SessionField="DateS" />
            <asp:QueryStringParameter DefaultValue="" Name="DateB" QueryStringField="DateB" />
            <asp:QueryStringParameter Name="BudgetitemID" QueryStringField="BudgetItemID" />
            <asp:QueryStringParameter Name="FrameID" QueryStringField="FrameID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

