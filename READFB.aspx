<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="READFB.aspx.vb" Inherits="READFB" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
        Text="טבלת משוב"></asp:Label><br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." DataKeyNames="FBID" CellPadding="2">
        <Columns>
            <asp:CommandField CancelText="ביטול" EditText="עריכה" ShowEditButton="True" UpdateText="עדכון" />
            <asp:BoundField DataField="FBID" HeaderText="מספר" InsertVisible="False" ReadOnly="True"
                SortExpression="FBID" />
            <asp:BoundField DataField="URName" HeaderText="שם משתמש" ReadOnly="True" SortExpression="URName" />
            <asp:TemplateField HeaderText="נושא" SortExpression="FeedBackSubject">
                <EditItemTemplate> 
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("FeedBackSubject") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FeedBackSubject") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="50px" />
                <ItemStyle Width="50px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="משוב" SortExpression="FeedBack">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("FeedBack") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FeedBack") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="250px" />
                <HeaderStyle Width="250px" />
                <ItemStyle Width="250px" />
            </asp:TemplateField>
            <asp:BoundField DataField="FBDate" HeaderText="תאריך" ReadOnly="True" SortExpression="FBDate" />
            <asp:TemplateField HeaderText="תגובה" SortExpression="FBResponse">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FBResponse") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("FBResponse") %>'></asp:Label>
                </ItemTemplate>
                <ControlStyle Width="200px" />
                <ItemStyle Width="200px" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="תאריך תגובה" SortExpression="FBRDate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FBRDate") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("FBRDate") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [p0t_FeedBack] WHERE [FBID] = @FBID" InsertCommand="INSERT INTO [p0t_FeedBack] ([UserID], [FeedBackSubject], [FeedBack], [FBDate], [FBResponse], [FBRDate]) VALUES (@UserID, @FeedBackSubject, @FeedBack, @FBDate, @FBResponse, @FBRDate)"
        ProviderName="<%$ ConnectionStrings:bebook10.ProviderName %>" SelectCommand="SELECT p0t_FeedBack.FBID, p0t_FeedBack.UserID, p0t_FeedBack.FeedBackSubject, p0t_FeedBack.FeedBack, p0t_FeedBack.FBDate, p0t_Ntb.URName, p0t_FeedBack.FBResponse, p0t_FeedBack.FBRDate FROM p0t_FeedBack LEFT OUTER JOIN p0t_Ntb ON p0t_FeedBack.UserID = p0t_Ntb.UserID"
        UpdateCommand="UPDATE [p0t_FeedBack] SET  [FBResponse] = @FBResponse, [FBRDate] = @FBRDate WHERE [FBID] = @FBID">
        <DeleteParameters>
            <asp:Parameter Name="FBID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FBResponse" Type="String" />
            <asp:Parameter Name="FBRDate" Type="DateTime" />
            <asp:Parameter Name="FBID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="FeedBackSubject" Type="String" />
            <asp:Parameter Name="FeedBack" Type="String" />
            <asp:Parameter Name="FBDate" Type="DateTime" />
            <asp:Parameter Name="FBResponse" Type="String" />
            <asp:Parameter Name="FBRDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

