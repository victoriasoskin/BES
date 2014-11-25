<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p0aUserRows.aspx.vb" Inherits="Default2" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <br />
    <br />
    <table style="width: 100%">
        <tr>
            <td>
    <asp:Label ID="Label3" runat="server" ForeColor="#0033CC" 
        Text="הגדרת הרשאות צפיה" Width="187px" Font-Bold="True" Font-Size="Large"></asp:Label>
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
        DataKeyNames="RowID" DataSourceID="DSRows" CellPadding="5">
        <Columns>
            <asp:CommandField DeleteText="מחיקה" ShowDeleteButton="True" />
            <asp:BoundField DataField="ServiceID" HeaderText="מס' שירות" 
                SortExpression="ServiceID" Visible="False" />
            <asp:BoundField DataField="ServiceName" HeaderText="שירות" 
                SortExpression="ServiceName">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="FrameID" HeaderText="מס' מסגרת" 
                SortExpression="FrameID" Visible="False" />
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
                SortExpression="FrameName">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="RowID" HeaderText="RowID" InsertVisible="False" 
                ReadOnly="False" SortExpression="RowID" Visible="False" />
        </Columns>
    </asp:GridView>
            </td>
            <td valign="top">
                <asp:FormView ID="FVADD" runat="server" DataKeyNames="RowID" 
                    DataSourceID="DSRows" DefaultMode="Insert" BorderColor="#999999" 
                    BorderStyle="Solid" BorderWidth="2px" HeaderText="הוספת שורה">
                    <InsertItemTemplate>
                        <asp:SqlDataSource ID="DSFRAMES" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                            SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = @ServiceID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DDLSERVICE" Name="ServiceID" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="DSServices" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                            SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]">
                        </asp:SqlDataSource>
                        <table style="width: 100%">
                            <tr>
                                <td valign="top">
                                    <asp:DropDownList ID="DDLSERVICE" runat="server" AppendDataBoundItems="True" 
                                        AutoPostBack="True" DataSourceID="DSServices" DataTextField="ServiceName" 
                                        DataValueField="ServiceID">
                                        <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td valign="top">
                                    <asp:RadioButtonList ID="RBLFRAME" runat="server" DataSourceID="DSFRAMES" 
                                        DataTextField="FrameName" DataValueField="FrameID" Width="221px">
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="הוספה" />
&nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="ביטול" />
                    </InsertItemTemplate>
                    <HeaderStyle BackColor="#0099FF" Font-Bold="True" Font-Size="Small" 
                        ForeColor="White" />
                 </asp:FormView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSRows" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        DeleteCommand="DELETE FROM p0t_NtbRow WHERE (RowID = @RowID)" 
        InsertCommand="INSERT INTO p0t_NtbRow(UserID, ServiceID, FrameID) VALUES (@UserID, @ServiceID, @FrameID)" 
        SelectCommand="SELECT p0t_NtbRow.ServiceID, ServiceList.ServiceName, p0t_NtbRow.FrameID, FrameList.FrameName, p0t_NtbRow.RowID FROM p0t_NtbRow LEFT OUTER JOIN FrameList ON p0t_NtbRow.FrameID = FrameList.FrameID LEFT OUTER JOIN ServiceList ON p0t_NtbRow.ServiceID = ServiceList.ServiceID WHERE (p0t_NtbRow.UserID = @UserID)">
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

