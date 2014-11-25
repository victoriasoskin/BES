<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventReportuS.aspx.vb" Inherits="CustEventReportuS" title="בית אקשטיין - ניהול תיקי לקוחות" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <asp:ScriptManager ID="ScriptManager1" runat="server">
         </asp:ScriptManager>
    <asp:SqlDataSource ID="DSCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="CustTable" EnableViewState="False" 
        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:Parameter DefaultValue="1" Name="Bldt" Type="Int32" />
            <asp:ControlParameter ControlID="TBID" Name="CUSTID" PropertyName="Text" />
            <asp:ControlParameter ControlID="CBLEFTTOO" DefaultValue="0" Name="LeftToo"  
                PropertyName="Checked" Type="Int32" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="SFrameID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 1007px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="DarkBlue"
        Text="ניהול תיקי לקוחות" Width="432px"></asp:Label><br /><asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSFRAMES" DataTextField="FrameName" DataValueField="FrameID">
                </asp:DropDownList>
                </td>
            <td style="width: 86px">
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBID"
        Display="Dynamic" ErrorMessage="מספר לא חוקי" MaximumValue="999999999"
        MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
            <td style="width: 86px">
                <asp:TextBox ID="TBID" runat="server" AutoPostBack="True" Width="97px" Visible="false"></asp:TextBox></td>
                <td style="width: 106px">
                    <asp:CheckBox ID="CBLEFTTOO" runat="server" AutoPostBack="True" 
                        Text="הצג גם לקוחות שעזבו/טרם נקלטו" Width="164px" />
            </td>
        </tr>
    </table>
        <table>
        <tr>
            <td colspan="3" valign="top">
                                        <asp:UpdatePanel runat="server" ID="up_q" UpdateMode="Conditional" ><ContentTemplate>


                <asp:FormView ID="FVInsertEvent" runat="server" DataSourceID="DSEvents" 
                    DefaultMode="Insert">
        <InsertItemTemplate>
            <table border="1" >
                <tr>
                    <td bgcolor="#37a5ff" align="right" valign="top" style="width: 154px">
                        <asp:Label ID="Label8" runat="server" Text="1. בחר בשם הלקוח"></asp:Label></td>
                 </tr>
                 <tr>
                    <td style="width: 154px; height: 160px" valign="top">
                        <asp:ListBox ID="LBCustomers" runat="server" DataSourceID="DSCustomer" DataTextField="CustomerName"
                            DataValueField="CustomerID" Rows="12" AppendDataBoundItems="True" AutoPostBack="True" Height="210px" OnSelectedIndexChanged="LBCustomers_SelectedIndexChanged" Width="150px" EnableViewState="False" OnPreRender="LBCustomers_PreRender" OnLoad="lsb_Load">
                        </asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LBCustomers"
                            Display="Dynamic" ErrorMessage="חובה לבחור בלקוח"></asp:RequiredFieldValidator><asp:Label ID="Label4" runat="server" Style="border-top: black thin solid; margin-top: 1px"
                    Text="* מועמד שהתקבל<br/> ** לקוח שעזב" Width="156px"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" colspan="4" valign="top" style="border-right-style: none; border-left-style: none; border-bottom-style: none">
                        <asp:HyperLink ID="HLREPHDR" runat="server" Font-Size="Medium" Font-Underline="True" Text="פעולות אחרונות ללקוח"
                            Width="614px"></asp:HyperLink><br />
                        <asp:HyperLink ID="hlCUSTDET" runat="server">פרטי הלקוח</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="4" style="border-right-style: none; border-left-style: none;
                        border-bottom-style: none" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="CustEventID" DataSourceID="DSEventList"
                    EnableViewState="False" PageSize="100" style="border-top-style: none" CellPadding="4">
                    <Columns>
                        <asp:TemplateField HeaderText="CustEventID" InsertVisible="False" 
                            SortExpression="CustEventID" Visible="False">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("CustEventID") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:HiddenField ID="HDNCUSTEID" runat="server" 
                                    Value='<%# Eval("CustEventID") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustomerID" HeaderText="ת.ז." SortExpression="CustomerID" Visible="False" />
                        <asp:BoundField DataField="CustEventGroupName" HeaderText="קבוצה " ReadOnly="True"
                            SortExpression="CustEventGroupName" Visible="False">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="סוג פעולה">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" 
                                    NavigateUrl='<%# Eval("CustEventUrl") %>' 
                                    Text='<%# Eval("CustEventTypeName") %>' OnPreRender="hl_preRender"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת פעולה"
                            HtmlEncode="False" SortExpression="CustEventDate" />
                        <asp:TemplateField HeaderText="הערה" SortExpression="CustEventComment">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemStyle Wrap="False" />
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnSA" runat="server" CausesValidation="False" Height="16px" 
                                                onclick="btnSA_Click" Text="..." Width="16px" />
                                        </td>
                                        <td>
                                            <asp:Label ID="LBComment" runat="server" 
                                                Text='<%# TruncField("CustEventComment",40) %>' 
                                                ToolTip='<%# Eval("CustEventComment") %>' Width="230px" Height="16px"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:TextBox ID="TBSA" runat="server" Height="73px" ReadOnly="True" 
                                                Text='<%# Eval("CustEventComment") %>' TextMode="MultiLine" Visible="False" 
                                                Width="237px"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת רישום"
                            HtmlEncode="False" SortExpression="CustEventRegDate" Visible="False" />
                        <asp:BoundField DataField="CframeManager" HeaderText="מנהל" SortExpression="CframeManager" Visible="False">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CReporterUserName" HeaderText="מדווח" SortExpression="CReporterUserName">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
    </asp:FormView></ContentTemplate>
    </asp:UpdatePanel>
                </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px;">
            </td>
            <td style="width: 100px; height: 18px;">
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSEvents" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        InsertCommand="Cust_AddEvent"
        SelectCommand="SELECT * FROM [CustEventList] Where CustEventID=@CustEventID" 
        UpdateCommand="UPDATE [CustEventList] SET [CustomerID] = @CustomerID, [CustEventTypeID] = @CustEventTypeID, [CustEventRegDate] = @CustEventRegDate, [CustEventDate] = @CustEventDate, [CustEventComment] = @CustEventComment, [CustFrameID] = @CustFrameID, [CframeManager] = @CframeManager, [CustConnectedItemID] = @CustConnectedItemID, [CustEventQuantity] = @CustEventQuantity, [CustEventSum] = @CustEventSum WHERE [CustEventID] = @CustEventID" 
        InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="CustEventID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" Type="DateTime" />
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:Parameter Name="CustFrameID" Type="Int32" />
            <asp:Parameter Name="CframeManager" Type="String" />
            <asp:Parameter Name="CustConnectedItemID" Type="Int64" />
            <asp:Parameter Name="CustEventQuantity" />
            <asp:Parameter Name="CustEventSum" />
            <asp:Parameter Name="CustEventID" Type="Int64" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" Type="DateTime" />
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:Parameter Name="CustFrameID" Type="Int32" />
            <asp:Parameter Name="CFramemanager" Type="String" />
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEventTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
             
			 SelectCommand="SELECT CustEventTypes.CustEventTypeName, CustEventTypes.CustEventTypeID FROM CustEventTypes LEFT OUTER JOIN CustEventGroups ON CustEventTypes.CustEventGroupID = CustEventGroups.CustEventGroupID WHERE (CustEventGroups.CustEventServiceID = ISNULL(@ServiceID, CustEventGroups.CustEventServiceID)) AND (CustEventTypes.CustEventApp = 1) OR (CustEventGroups.CustEventServiceID IS NULL) AND (CustEventTypes.DontUse IS NULL) ORDER BY CustEventTypes.CustEventOrder">
        <SelectParameters>
            <asp:SessionParameter Name="ServiceID" SessionField="ServiceID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAMES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
		SelectCommand="pFrameList" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEventList" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT e.CustEventID, e.CustomerID, e.CustEventTypeID, e.CustEventRegDate, e.CustEventDate, e.CustEventComment, e.CustFrameID, e.CframeManager, t.CustEventTypeName, f.FrameName, g.CustEventGroupName, e.UserID, u.URName AS CReporterUserName, CASE WHEN DateAdd(Day , AllowChangeEvent , CustEventRegDate) &gt; GetDate() THEN 1 ELSE 0 END AS AllowC, CASE WHEN t.TestCustEventURL IS NULL THEN '' ELSE t.TestCustEventURL + CASE WHEN charindex('?' , t.TestCustEventURL) &gt; 0 THEN '&amp;' ELSE '?' END + 'ID=' + CASE LEFT (t.TestCustEventURL , 2) WHEN 'EX' THEN CAST(e.CustRelateID AS varchar(6)) ELSE CAST(e.CustEventID AS varchar(6)) END END AS CustEventUrl, e.CustRelateID FROM FrameList AS f RIGHT OUTER JOIN CustEventList AS e LEFT OUTER JOIN p0t_NtB AS u ON e.UserID = u.UserID ON f.FrameID = e.CustFrameID LEFT OUTER JOIN CustEventGroups AS g RIGHT OUTER JOIN CustEventTypes AS t ON g.CustEventGroupID = t.CustEventGroupID ON e.CustEventTypeID = t.CustEventTypeID LEFT OUTER JOIN dbo.p0t_CustProperties AS p ON p.ServiceTypeID = f.ServiceTypeID WHERE (e.CustomerID &lt;&gt; 0) AND (e.CustomerID = @CustomerID) ORDER BY e.CustEventDate DESC, e.CustEventRegDate DESC" 
        DeleteCommand="Cust_DelEvent" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

