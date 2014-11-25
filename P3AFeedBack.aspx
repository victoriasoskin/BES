<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p3aFeedBack.aspx.vb" Inherits="p3aFeedBack" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSFB" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [p3t_FeedBack] WHERE [FBID] = @FBID" InsertCommand="p3p_ADDFB"
        SelectCommand="SELECT p3t_FeedBack.SFeedback, p3t_FeedBack.Feedback, p3t_ProjectsHeaders.ProjName, p3t_FeedBack.FBID, p3t_FeedBack.ProjID FROM p3t_FeedBack LEFT OUTER JOIN p3t_ProjectsHeaders ON p3t_FeedBack.ProjID = p3t_ProjectsHeaders.ProjID WHERE (p3t_FeedBack.FBID = @FBID)"
        
        
        
        UpdateCommand="UPDATE [p3t_FeedBack] SET   [SFeedback] = @SFeedback, [Feedback] = @Feedback WHERE [FBID] = @FBID" 
        InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="FBID" QueryStringField="FBID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="FBID" Type="Int32" />
        </DeleteParameters> 
        <UpdateParameters>
            <asp:Parameter Name="SFeedback" Type="String" />
            <asp:Parameter Name="Feedback" Type="String" />
            <asp:querystringParameter QueryStringField="FBID" Name="FBID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:querystringParameter QueryStringField="projID" Name="ProjID" Type="Int32" />
            <asp:SessionParameter SessionField="UserID" Name="UserID" Type="Int32" />
            <asp:controlParameter ControlID="LBDate" Name="FBDate" Type="DateTime" />
            <asp:Parameter Name="SFeedback" Type="String" />
            <asp:Parameter Name="Feedback" Type="String" />
            <asp:QuerystringParameter QueryStringField="RootID" Name="RootID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    &nbsp;<br />
    <table>
        <tr>
            <td style="width: 100px">
    <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
        Text="משוב" Width="430px"></asp:Label></td>
            <td style="width: 100px">
                <asp:Label ID="LBDATE" runat="server" Width="152px"></asp:Label></td>
        </tr>
    </table>
        <asp:DetailsView ID="DVFB" runat="server" AutoGenerateRows="False" DataKeyNames="FBID"
        DataSourceID="DSFB" DefaultMode="Insert" 
    HeaderText="טופס משוב" Height="50px"
        Width="125px">
            <Fields>
                <asp:TemplateField HeaderText="הפרויקט">
                    <EditItemTemplate>
                        <asp:Label ID="LBLProjName" runat="server" ForeColor="White"></asp:Label>
                        <asp:HiddenField ID="HDNPROJID" runat="server" Value='<%# Eval("ProjID") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Label ID="LBLProjName" runat="server" ForeColor="White"></asp:Label>
                        <asp:HiddenField ID="HDNPROJID" runat="server" Value='<%# Eval("ProjID") %>' />
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="משתמש">
                    <EditItemTemplate>
                        <asp:Label ID="LBLUSERNAME" runat="server" ForeColor="White" Text="Label"></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Label ID="LBLUSERNAME" runat="server" ForeColor="White" Text="Label"></asp:Label>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="UserID" HeaderText="UserID" SortExpression="UserID" 
                Visible="False" />
                <asp:TemplateField HeaderText="נושא" SortExpression="SFeedback">
                    <EditItemTemplate>
                        <asp:TextBox ID="TBSub" runat="server" Text='<%# Bind("SFeedBack") %>' 
                            Width="570px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TBSub" runat="server" Text='<%# Bind("SFeedBack") %>' 
                        Width="570px"></asp:TextBox>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="משוב" SortExpression="FeedBack">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Font-Names="Arial" Rows="10" 
                            Text='<%# Bind("FeedBack") %>' TextMode="MultiLine" Width="570px"></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Rows="10" Text='<%# Bind("FeedBack") %>'
                        TextMode="MultiLine" Width="570px" Font-Names="Arial"></asp:TextBox>
                    </InsertItemTemplate>
                 </asp:TemplateField>
                <asp:CommandField CancelText="ביטול" InsertText="שלח" ShowInsertButton="True" 
                    ShowEditButton="True" UpdateText="עדכון" />
            </Fields>
        </asp:DetailsView>

    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <table style="width: 100%">
        <tr>
            <td>
                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False">חזרה</asp:LinkButton>
            </td>
        </tr>
    </table>

    </asp:Content>
