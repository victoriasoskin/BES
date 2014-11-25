<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p0aUserRowsB.aspx.vb" Inherits="Default2" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <br />
    <br />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table style="width: 100%">
        <tr>
            <td>
    <asp:Label ID="Label3" runat="server" ForeColor="#0033CC" 
        Text="הגדרת הרשאות צפיה תקציב" Width="187px" Font-Bold="True" Font-Size="Large"></asp:Label>
            </td>
            <td>
                &nbsp;                <a href="javascript:window.open('','_self','');window.close();">סגור</a>
</td>
        </tr>
        <tr>
            <td>
    <asp:Label ID="LBLUNAME" runat="server" ForeColor="#0033CC" Text="Label"></asp:Label>
    <br />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="RowID" DataSourceID="DSRows" CellPadding="5" 
                    EnableModelValidation="True">
        <Columns>
            <asp:TemplateField HeaderText="RowID" InsertVisible="False" 
                SortExpression="RowID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("RowID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:UpdatePanel runat="server" ID="cbx" UpdateMode="Conditional">
                        <ContentTemplate>
                             <asp:HiddenField ID="HDNCATEGORYID" runat="server" 
                                    Value='<%# Bind("CategoryID") %>' />
                             <asp:CheckBox ID="CheckBox1" runat="server" 
                                    Checked='<%# eval("RowID") isnot dbnull.value %>' AutoPostBack="True" 
                                    oncheckedchanged="CheckBox1_CheckedChanged" />
                        </ContentTemplate>                    
                    </asp:UpdatePanel>
                 </ItemTemplate>
                
            </asp:TemplateField>
            <asp:BoundField DataField="שירות_-_1" HeaderText="שירות_-_1" SortExpression="שירות_-_1" />
            <asp:BoundField DataField="שירות_-_2" HeaderText="שירות_-_2" SortExpression="שירות_-_2" />
            <asp:BoundField DataField="שירות_-_3" HeaderText="שירות_-_3" SortExpression="שירות_-_3" />
        </Columns>
    </asp:GridView>
            </td>
            <td valign="top">
             </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSRows" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        DeleteCommand="DELETE FROM p0t_NtbRowB WHERE (RowID = @RowID)" 
        InsertCommand="INSERT INTO p0t_NtbRowB(UserID, ServiceID, FrameID) VALUES (@UserID, @ServiceID, @FrameID)" 
        
        
        SelectCommand="SELECT p0t_NtbRow.UserID, CASE WHEN SHERUT_besqxl.[שירות_-_2] IS NULL THEN SHERUT_besqxl.[שירות_-_1] ELSE '' END AS [שירות_-_1], CASE WHEN SHERUT_besqxl.[שירות_-_3] IS NULL THEN SHERUT_besqxl.[שירות_-_2] ELSE '' END AS [שירות_-_2], SHERUT_besqxl.[שירות_-_3], SHERUT_besqxl.CategoryID, p0t_NtbRow.RowID FROM p0t_NtbRowB p0t_NtbRow RIGHT OUTER JOIN SHERUT_besqxl ON p0t_NtbRow.CategoryID = SHERUT_besqxl.CategoryID AND p0t_NtbRow.UserID = @UserID WHERE (SHERUT_besqxl.[שירות_-_1] IS NOT NULL) ORDER BY SHERUT_besqxl.סדר_שורות_שירות">
        <SelectParameters>
            <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="RowID" />
        </DeleteParameters>
        <InsertParameters>
            <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" />
            <asp:controlParameter controlid="FVADD$DDLSERVICE"  Name="ServiceID" />
            <asp:controlParameter controlid="FVADD$RBLFRAME" Name="FrameID" />
        </InsertParameters>
    </asp:SqlDataSource>
    <br />
</asp:Content>

