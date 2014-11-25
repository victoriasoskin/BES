<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FeedBack.aspx.vb" Inherits="FeedBack" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [p0t_FeedBack] WHERE [FBID] = @FBID" InsertCommand="INSERT INTO [p0t_FeedBack] ([UserID], [FeedBackSubject], [FeedBack], [FBDate], [FBResponse], [FBRDate]) VALUES (@UserID, @FeedBackSubject, @FeedBack, @FBDate, @FBResponse, @FBRDate)"
        SelectCommand="SELECT [FBID], [UserID], [FeedBackSubject], [FeedBack], [FBDate], [FBResponse], [FBRDate] FROM [p0t_FeedBack] WHERE ([UserID] = @UserID)"
        UpdateCommand="UPDATE [p0t_FeedBack] SET [UserID] = @UserID, [FeedBackSubject] = @FeedBackSubject, [FeedBack] = @FeedBack, [FBDate] = @FBDate, [FBResponse] = @FBResponse, [FBRDate] = @FBRDate WHERE [FBID] = @FBID">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters> 
        <DeleteParameters>
            <asp:Parameter Name="FBID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:sessionParameter SessionField="UserID" Name="UserID" Type="Int32" />
            <asp:Parameter Name="FeedBackSubject" Type="String" />
            <asp:Parameter Name="FeedBack" Type="String" />
            <asp:Parameter Name="FBDate" Type="DateTime" DefaultValue='<% Now() %>' />
            <asp:Parameter Name="FBResponse" Type="String" />
            <asp:Parameter Name="FBRDate" Type="DateTime" />
            <asp:Parameter Name="FBID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:sessionParameter SessionField="UserID" Name="UserID" Type="Int32" />
            <asp:Parameter Name="FeedBackSubject" Type="String" />
            <asp:Parameter Name="FeedBack" Type="String" />
            <asp:controlParameter ControlID=lbdate Name="FBDate" Type="DateTime" />
            <asp:Parameter Name="FBResponse" Type="String" />
            <asp:Parameter Name="FBRDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>
    &nbsp;&nbsp;<br />
    <table>
        <tr>
            <td style="width: 100px">
    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
        Text="משוב" Width="430px"></asp:Label></td>
            <td style="width: 100px">
                <asp:Label ID="LBDATE" runat="server" Width="152px"></asp:Label></td>
        </tr>
    </table>
    <br />
    <asp:Panel ID="Panel1" runat="server" Height="89px" Width="590px">
        <span style="color: #FFFFFF">שלום רב,</span><br style="color: #FFFFFF" />
        <asp:Label ID="Label6" runat="server" Font-Size="XX-Large" 
            style="color: #FF0000" Text="אנא, פנו לרותם באמצעות המייל, תודה."></asp:Label>
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" Font-Size="Medium" Width="120px">help@b-e.org.il</asp:HyperLink>
        <br />
        <br style="color: #FFFFFF" />
        <span style="color: #FFFFFF">אנו מבקשים לקבל מכם משוב על מערכת המידע החדשה. 
        דעתכם חשובה לנו. הגיבו על הכל: תקלות, בעיות תפעוליות, חוסרים, מיותרים, 
        עיצוב..... הכל!</span><br style="color: #FFFFFF" />
        <br style="color: #FFFFFF" />
        <span style="color: #FFFFFF">אנו נטפל בכל משוב ונעמוד אתכם בקשר.</span><br 
            style="color: #FFFFFF" />
        <br style="color: #FFFFFF" />
        <span style="color: #FFFFFF">תודה מראש על שיתוף הפעולה.</span></asp:Panel>
    <br />
    <br />
    <br />
    <br />
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="FBID"
        DataSourceID="SqlDataSource1" DefaultMode="Insert" HeaderText="טופס משוב" Height="50px"
        Width="125px" Enabled="False">
        <Fields>
            <asp:BoundField DataField="FBID" HeaderText="מס'" InsertVisible="False" ReadOnly="True"
                SortExpression="FBID" />
            <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" Visible="False" />
            <asp:TemplateField HeaderText="נושא" SortExpression="FeedBackSubject">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeedBackSubject") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FeedBackSubject") %>' Width="570px"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("FeedBackSubject") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="משוב" SortExpression="FeedBack">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FeedBack") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Rows="10" Text='<%# Bind("FeedBack") %>'
                        TextMode="MultiLine" Width="570px"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FeedBack") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FBResponse" HeaderText="תגובה" SortExpression="FBResponse"
                Visible="False" />
            <asp:BoundField DataField="FBRDate" HeaderText="תאריך תגובה" SortExpression="FBRDate"
                Visible="False" />
            <asp:CommandField CancelText="ביטול" InsertText="שלח" ShowInsertButton="True" />
        </Fields>
    </asp:DetailsView>
</asp:Content>
