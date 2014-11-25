<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SRCUSTNOTPAIDCNT.aspx.vb" Inherits="Default5" title="בית אקשטיין - לא משולמים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td colspan="2" style="height: 21px">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="דוח לא משולמים" Width="137px"></asp:Label></td>
            <td style="width: 100px; height: 21px;">
            </td> 
        </tr>
        <tr>
            <td >
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSSERVICES" DataTextField="ServiceName" DataValueField="ServiceID">
                    <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td >
                <asp:DropDownList ID="DDLFRAME" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSFRAME" DataTextField="FrameName" DataValueField="FrameID">
                    <asp:ListItem Value="">&lt;בחר מסגרת&gt;</asp:ListItem>
                </asp:DropDownList></td>
            <td >
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Label ID="Label3" runat="server" Text="מוצגים תשלומים בפיגור של למעלה מ" Width="194px"></asp:Label><asp:TextBox
                    ID="TBLP" runat="server" AutoPostBack="True" Width="13px">1</asp:TextBox>
                חודשים, &nbsp;<asp:Label ID="Label1" runat="server" Text="נכון לתאריך:" Width="67px"></asp:Label>
                <asp:Label ID="LBLTODAY" runat="server" Text="Label"></asp:Label>
                </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 169px">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="DSCUSTNOTPAID" AutoGenerateColumns="False" CellPadding="4" ShowFooter="True">
                    <FooterStyle Wrap="False" />
                    <RowStyle Wrap="False" />
                    <EmptyDataRowStyle Wrap="False" />
                    <SelectedRowStyle Wrap="False" />
                    <HeaderStyle Wrap="False" />
                    <Columns>
                        <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" FooterText="סה&quot;כ חודשים" >
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                            <FooterStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustomerID" HeaderText="ת.ז." SortExpression="CustomerID" >
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustomerName" HeaderText="שם הלקוח" SortExpression="CustomerName" >
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Custjoin" DataFormatString="{0:MMM-yy}" HeaderText="חודש קליטה"
                            SortExpression="Custjoin" >
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="מס' חודשים שלא שולמו" SortExpression="NotPaidCount">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NotPaidCount") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LBCNT" runat="server" Text='<%# scnt() %>' ></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                            <FooterTemplate>
                                <asp:Label ID="LBLTTL" runat="server" Text='<%# stotal() %>'></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
</Columns>
                </asp:GridView>
                </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSCUSTNOTPAID" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT vCustPaymentEvents.CustomerID, vCustPaymentEvents.CustomerName, vCustPaymentEvents.FrameName, vCustPaymentEvents.ServiceID, vCustPaymentEvents.UserID, vCustByFrame.CustEventDate AS Custjoin, COUNT(DISTINCT vCustPaymentEvents.PaymentMonth) AS NOTPAIDCOUNT FROM vCustPaymentEvents LEFT OUTER JOIN vCustByFrame ON vCustPaymentEvents.CustomerID = vCustByFrame.CustomerID WHERE (vCustPaymentEvents.CustFrameID = ISNULL(@FrameID, vCustPaymentEvents.CustFrameID)) AND (vCustPaymentEvents.PaymentMonth < DATEADD(month, - 1 - @BKCNT, GETDATE())) AND (vCustPaymentEvents.CustEventID IS NULL) AND (vCustPaymentEvents.ServiceID = @ServiceID) GROUP BY vCustPaymentEvents.CustomerID, vCustPaymentEvents.CustomerName, vCustPaymentEvents.FrameName, vCustPaymentEvents.ServiceID, vCustPaymentEvents.UserID, vCustByFrame.CustEventDate">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLFRAME" DefaultValue="" Name="FrameID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="TBLP" Name="BKCNT" PropertyName="Text" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAME" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

