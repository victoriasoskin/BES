<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FMCUSTNOTPAIDCNT.aspx.vb" Inherits="Default5" title="בית אקשטיין - לא משולמים" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td colspan="6">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="דוח לא משולמים" Width="137px"></asp:Label></td>
        </tr>
        <tr>
            <td >
                <asp:Label ID="Label1" runat="server" Text="נכון לחודש:" Width="67px"></asp:Label></td><td>
                <asp:DropDownList ID="DDLLDATE" runat="server">
                </asp:DropDownList>
                </td> 
                <td>
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSSERVICES" DataTextField="ServiceName" 
                    DataValueField="ServiceID" Visible="False">
                    <asp:ListItem Value="">&lt;כל השירותים&gt;</asp:ListItem>
                </asp:DropDownList>
                </td>
               <td>
                <asp:DropDownList ID="DDLFRAME" runat="server" AppendDataBoundItems="True"
                    DataSourceID="DSFRAME" DataTextField="FrameName" DataValueField="FrameID" 
                        Visible="False" EnableViewState="False">
                    <asp:ListItem Value="">&lt;כל המסגרות&gt;</asp:ListItem>
                </asp:DropDownList>
                </td>
 				<td>
                	<asp:Button ID="Button1" runat="server" Text="הצג" />
				</td>
               <td>
                <asp:Label ID="LBLTODAY" runat="server" Text="Label"></asp:Label>
                </td>
        </tr>
        <tr>
            <td colspan="4" style="height: 169px">
                <asp:SqlDataSource ID="dsnpd" runat="server" 
					ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT PaymentMonth FROM [p0v_PayListNU] where CustomerID=@CustomerID and paid=0  AND PaymentMonth between '2008-1-1'
    and @DateB AND FrameID=@FrameID">
					<SelectParameters>
						<asp:Parameter Name="CustomerID" />
						<asp:ControlParameter ControlID="DDLLDATE" Name="DateB" 
							PropertyName="SelectedValue" />
						<asp:Parameter Name="FrameID" />
					</SelectParameters>
				</asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="" 
                    AutoGenerateColumns="False" CellPadding="4" ShowFooter="True" 
                    CellSpacing="1" AllowSorting="True">
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
                        <asp:BoundField DataField="StartDate" DataFormatString="{0:MMM-yy}" HeaderText="חודש קליטה"
                            SortExpression="StartDste" >
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EndDate" DataFormatString="{0:MMM-yy}" 
                            HeaderText="חודש עזיבה" SortExpression="EndDate">
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="מס' חודשים שלא שולמו" SortExpression="NotPaidCount">
                           <ItemTemplate>
								<asp:HiddenField runat="server" ID="hdnFrameID" Value='<%#Eval("CustFrameID") %>' />
  								<asp:LinkButton runat="server" ID="lnkbCnt" Text='<%# scnt() %>' OnClick="lnkb_Click" />
								<asp:DataList runat="server" ID="dlnpd" DataSourceID="DSnpd" Visible="false" >
									<ItemTemplate>
										<%# Eval("PaymentMonth", "{0:MMM-yy}")%>
									</ItemTemplate>
								</asp:DataList>
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
    <asp:SqlDataSource ID="DSSERVICES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAME" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCUSTNOTPAID" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT CustFrameID,FrameName, CustomerID, CustomerName, StartDate, EndDate, SUM(CASE isnull(Paid , - 1) WHEN 0 THEN 1 ELSE 0 END) AS CNT FROM p0v_payListNU WHERE (PaymentMonth &gt;= CAST('2008-1-1' AS datetime) AND PaymentMonth &lt;= @DateB) AND (ServiceID = ISNULL(@CserviceID, ServiceID)) AND (CustFrameID = ISNULL(@CFrameID, CustFrameID)) AND (CustFrameID = ISNULL(@frameid, CustFrameID)) GROUP BY FrameName, CustomerID, CustomerName, StartDate, EndDate, CustFrameID ORDER BY CNT DESC" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLLDATE" Name="DateB" Type="DateTime"
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="CserviceID" DefaultValue=""
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLFRAME" Name="CFrameID" DefaultValue=""
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="frameid" SessionField="FrameID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

