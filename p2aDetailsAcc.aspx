<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="p2aDetailsAcc.aspx.vb" Inherits="p2a_DetailsAcc" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 103px; height: 22px">
                <asp:Label ID="LBTITLE" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="פירוט נתוני בפועל - חשבונות לסעיף:" Width="689px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 103px; height: 18px">
                <asp:Label ID="LBSUBTITLE" runat="server" Text="מסגרת:" Width="507px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 103px; height: 213px" valign="top">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="DSACC" AllowSorting="True" CellPadding="6" PageSize="18" ShowFooter="True">
                    <Columns> 
                        <asp:HyperLinkField Text="פירוט" DataNavigateUrlFields="LinkDT">
                            <ItemStyle Wrap="False" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="Company" HeaderText="חברה" SortExpression="Company" />
                        <asp:BoundField DataField="SortGroup" HeaderText="קוד מיון" SortExpression="SortGroup" />
                        <asp:BoundField DataField="SortGroupName" HeaderText="קבוצת מיון" SortExpression="SortGroupName">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AccountKey" HeaderText="חשבון" SortExpression="AccountKey" />
                        <asp:BoundField DataField="accountname" HeaderText="שם חשבון" SortExpression="accountname">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Cutoff" HeaderText="חתך" SortExpression="Cutoff">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ACTID" HeaderText="ACTID" SortExpression="ACTID" Visible="False" />
                        <asp:TemplateField HeaderText="סכום" SortExpression="LCAmount">
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# GetColValue(Eval("LCAmount"),8).ToString("N0") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <FooterTemplate>
                             <%#GetTotal(8).ToString("N0")%>
                            </FooterTemplate>
                            <FooterStyle Wrap="False" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <table>
                    <tr>
                        <td style="width: 100px">
                &nbsp;<input onclick="history.back()" type="button" value="חזרה לדוח" /></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSACC" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT Company, CompanyID, SORTGROUP, SortGroupName, ACCOUNTKEY, accountname, Cutoff, BudgetCategoryID, FrameCategoryID, SUM(LCAmount) AS LCAmount, SUM(QUANT) AS QUANT, ACTID, '~/p2aDetailTrans.Aspx?ACTID=' + CAST(ISNULL(ACTID, 0) AS nvarchar(20)) + '&amp;Budgetitemid=' + LTRIM(RTRIM(STR(BudgetCategoryID))) + '&amp;FrameID=' + LTRIM(RTRIM(STR(FrameCategoryID))) + '&amp;DateB=' + CAST(DATEPART(year, @MTransDate) AS nvarchar(4)) + '-' + CAST(DATEPART(month, @MTransDate) AS nvarchar(2)) + '-01&amp;DateS=' + CAST(DATEPART(year, @VSDate) AS nvarchar(4)) + '-' + CAST(DATEPART(Month, @VSDate) AS nvarchar(2)) + '-01&amp;Frame=' + @Frame + '&amp;BudgetIDtem=' + @Budget + '&amp;SORTC=' + CAST(ISNULL(SORTGROUP, '') AS nvarchar(5)) + '&amp;SORTCN=' + ISNULL(SortGroupName, '') + '&amp;ACCT=' + ISNULL(ACCOUNTKEY, '') + '&amp;AccountName=' + replace(ISNULL(accountname, ''),':',' ') + CASE WHEN @SRC IS NULL THEN '' ELSE '&amp;SRC=' + CAST(@SRC AS nvarchar(2)) END AS LINKDT FROM p2v_Actual WHERE (Mtransdate &gt;= @VSDate) AND (Mtransdate &lt;= @MTransDate) GROUP BY Company, CompanyID, SORTGROUP, SortGroupName, ACCOUNTKEY, accountname, Cutoff, BudgetCategoryID, ACTID, FrameCategoryID HAVING (BudgetCategoryID = @BudgetCategoryID) AND (FrameCategoryID = @FrameCategoryID)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="MtransDate" QueryStringField="DateB" Type="DateTime" />
            <asp:SessionParameter Name="VSDate" SessionField="DateS" Type="DateTime" />
            <asp:QueryStringParameter Name="Frame" QueryStringField="Frame" />
            <asp:QueryStringParameter Name="Budget" QueryStringField="Budget" />
            <asp:QueryStringParameter Name="SRC" QueryStringField="SRC" type=Int32/>
            <asp:QueryStringParameter Name="BudgetCategoryID" QueryStringField="BudgetItemID"
                Type="Int32" />
            <asp:QueryStringParameter Name="FrameCategoryID" QueryStringField="FrameID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

