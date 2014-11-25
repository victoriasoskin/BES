<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="EDU.aspx.vb" Inherits="EDU" title="בית אקשטיין - ניהול מועמדים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <!-- <table>
        <tr>
            <td style="width: 280px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="מיון מועמדים" Width="551px"></asp:Label></td>
            <td style="width: 100px">
                <asp:Label ID="LBLDATE" runat="server" Text="Label" Width="97px"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LBLFRAMENAME"  runat="server" Text="Label" Width="165px"></asp:Label><asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSFRAMES" DataTextField="FrameName" DataValueField="FrameID" Visible="false">
                    <asp:ListItem Value="" Selected="True">&lt;בחר מסגרת&gt;</asp:ListItem>
                </asp:DropDownList></td> 
            <td>
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="2">
                <table>
                    <tr>
                        <td valign="top">
                <asp:ListBox ID="LSBCUST" runat="server" AutoPostBack="True" DataSourceID="DSCustomers"
                    DataTextField="CustName" DataValueField="CustomerID" Height="198px" Width="180px">
                </asp:ListBox></td>
                        <td valign="top">
                            <span style="font-size: 2px"></span>
                            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="DSSELECTEDCUST"
                                Height="198px" Width="480px">
                                <Fields>
                                    <asp:BoundField DataField="ת.ז." HeaderText="ת.ז." SortExpression="ת.ז.">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="שם" HeaderText="שם" ReadOnly="True" SortExpression="שם">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="תאריך לידה" DataFormatString="{0:dd/MM/yy}" HeaderText="תאריך לידה"
                                        SortExpression="תאריך לידה">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="מין" HeaderText="מין" ReadOnly="True" SortExpression="מין">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="כתובת" HeaderText="כתובת" SortExpression="כתובת">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="כתובת1" SortExpression="כתובת1">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="עיר" HeaderText="עיר" SortExpression="עיר">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="טלפון" HeaderText="טלפון" SortExpression="טלפון">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Fields>
                                <HeaderStyle Width="30%" />
                            </asp:DetailsView>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" valign="top">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="DSEVENTTypes" CellPadding="1" DataKeyNames="CustEventID">
                    <Columns>
                        <asp:BoundField DataField="CustEventTypeName" HeaderText="פעולה" SortExpression="CustEventTypeName" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="תאריך" SortExpression="CustEventDate">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventDate") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TBDATE" runat="server" OnPreRender="TBDATE_PreRender" Text='<%# Bind("CustEventDate", "{0:dd/MM/yy}") %>'
                                    Width="57px"></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBDATE"
                                    Display="Dynamic" ErrorMessage="תאריך לא חוקי" MaximumValue="31/12/2050" MinimumValue="1/1/2008"
                                    Type="Date"></asp:RangeValidator>
                                <asp:Button ID="Button1" runat="server" Height="18px" OnClick="Button1_Click" Text="..." />
                                <asp:Calendar ID="CALEVENT" runat="server" Font-Size="X-Small" OnSelectionChanged="CALEVENT_SelectionChanged"
                                    Visible="False"></asp:Calendar>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TBDATE"
                                    Display="Dynamic" ErrorMessage="חובה להקיש תאריך"></asp:RequiredFieldValidator>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="הערה" SortExpression="CustEventComment">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" OnPreRender="TextBox3_PreRender" Width="349px" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Update"
                                    Text="עדכון...  "></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="CustEventTypeID">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CustEventTypeID") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("CustEventTypeID") %>' />
                            </ItemTemplate>
                            <HeaderStyle Width="0px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventUpdateTypeID" HeaderText="CustEventUpdateTypeID"
                            SortExpression="CustEventUpdateTypeID" Visible="False" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnDel" runat="server" Text="מחיקה"
                                         CommandName="Delete" OnClientClick="return confirm('האם למחוק את הפעולה?');" ></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSELECTEDCUST" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT CustomerID AS [ת.ז.], CustLastName + N' ' + CustFirstName AS שם, CustBirthDate AS [תאריך לידה], Gender AS מין, CustomerAddress1 AS כתובת, CustomerAddress2 AS כתובת, CustomerCity AS עיר, CustomerPhone AS טלפון FROM vCustomerList WHERE (CustomerID = @CustomerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" PropertyName="SelectedValue"
                Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" CancelSelectOnNullParameter="false"
        SelectCommand="SELECT CustLastName + ' ' + CustFirstName AS CustName, CustomerID, FrameName FROM vCustomerList WHERE (PUserID = @UserID) AND (CustEventDate IS NULL) AND (UserFrameID = ISNULL(@FrameID, UserFrameID)) ORDER BY CustLastName, CustFirstName">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="FrameID" PropertyName="SelectedValue" Type="Int32" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAMES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = @ServiceID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNSERVICEID" Name="ServiceID" PropertyName="Value"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNEVENTGROUPID" runat="server" Value="2" />
    <asp:SqlDataSource ID="DSEVENTTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT p0v_EVENTCLGroup.CustEventTypeName, CustEventList.CustEventDate, CustEventList.CustEventComment, p0v_EVENTCLGroup.CustomerID, p0v_EVENTCLGroup.CustEventTypeID, p0v_EVENTCLGroup.CustEventUpdateTypeID, CustEventList.CustEventID FROM dbo.p0v_EventCLGroup AS p0v_EVENTCLGroup LEFT OUTER JOIN CustEventList ON p0v_EVENTCLGroup.CustomerID = CustEventList.CustomerID AND p0v_EVENTCLGroup.CustEventTypeID = CustEventList.CustEventTypeID WHERE (p0v_EVENTCLGroup.CustEventGroupID = @EventGroupID) AND (p0v_EVENTCLGroup.CustomerID = @CustomerID) ORDER BY p0v_EVENTCLGroup.CustEventOrder" 
        DeleteCommand="DELETE FROM CustEventList WHERE (CustEventID = @CustEventID)" 
        UpdateCommand="Cust_UPDEvent" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNEVENTGROUPID" Name="EventGroupID" PropertyName="Value" />
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" PropertyName="SelectedValue" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
            <asp:controlParameter ControlID="LBLDATE" Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" type="DateTime"/>
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:SessionParameter SessionField="FrameID" Name="CustFrameID" Type="Int32" />
            <asp:ControlParameter ControlID="HDNMANAGER" Name="CFramemanager" Type="String" />
            <asp:sessionParameter SessionField="UserID" Name="userID" Type="Int32" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventID" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNSERVICEID" runat="server" Value="3" />
    <asp:HiddenField ID="HDNMANAGER" runat="server" /> 
    !-->
        <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Italic="True" 
        Font-Size="XX-Large" ForeColor="#0033CC" Height="16px" 
        Text="בבניה" Width="485px"></asp:Label>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />

</asp:Content>

