<%@ Page Title="" Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="MultiTemplate.aspx.vb" Inherits="MultiTemplate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="phdrdiv" style="width:200px">
    תבניות סעיף תקציבי<br />
</div>
<div>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DSTEMP" CellPadding="4">
        <Columns>
            <asp:BoundField DataField="t" HeaderText="מספר תבנית" 
                SortExpression="t" />
            <asp:TemplateField HeaderText="תבנית">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server"  
                        NavigateUrl='<%# Eval("Lnk") %>' 
                        Text='<%# Eval("TempltSheetName") %>'></asp:HyperLink>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
         </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="DSTEMP" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
        
        
        SelectCommand="SELECT distinct b.[מספר תבנית] AS t, t.TempltSheetName, '/App_Doc/T' + CAST(b.[מספר תבנית] AS varchar(6)) + '.htm' AS Lnk 
                        FROM BEBudget AS b 
                        LEFT OUTER JOIN TemplateIndex AS t ON t.TempltID = b.[מספר תבנית] 
                        LEFT OUTER JOIN Budget_Besqxl bs on bs.CategoryID=b.BudgetCategoryID
                        WHERE (b.FrameCategoryID = @FrameCategoryID) AND (b.VersionCategoryID = @VersionCategoryID) AND 
                            (bs.[תקציב_-_1] = ISNULL(@b1, bs.[תקציב_-_1])) AND (ISNULL(bs.[תקציב_-_2], '') = ISNULL(@b2, ISNULL(bs.[תקציב_-_2], ''))) AND 
                            (ISNULL(bs.[תקציב_-_3], '') = ISNULL(@b3, ISNULL(bs.[תקציב_-_3], ''))) 
                            AND (REPLACE(ISNULL(b.נושא, ''),'&quot;','') = REPLACE(ISNULL(@s, ISNULL(b.נושא, '')),'&quot;',''))" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="FrameCategoryID" QueryStringField="f" 
                Type="Int32" />
            <asp:QueryStringParameter Name="VersionCategoryID" QueryStringField="v" 
                Type="Int32" />
            <asp:QueryStringParameter Name="b1" QueryStringField="b1" />
            <asp:QueryStringParameter Name="b2" QueryStringField="b2" />
            <asp:QueryStringParameter Name="b3" QueryStringField="b3" />
            <asp:QueryStringParameter Name="s" QueryStringField="s" />
        </SelectParameters>
    </asp:SqlDataSource>
    <input type="button" onclick="javascript:history.back();" value="חזרה"/>
</div>
</asp:Content>

