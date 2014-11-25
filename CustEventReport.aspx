<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventReport.aspx.vb" Inherits="CustEventReport" title="��� ������� - ����� ���� ������" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
		 <asp:ScriptManager ID="ScriptManager1" runat="server">
         </asp:ScriptManager>
<script type="text/ecmascript">
//To cause postback "as" the Button
function PostBackOnMainPage(){
  <%=GetPostBackScript()%>
}
</script>
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="�����" CausesValidation="false" />
    </div>
    <div runat="server" id="divform" >
    <asp:SqlDataSource ID="DSCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="CustTable" EnableViewState="False" 
        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure"> 
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:Parameter DefaultValue="1" Name="Bldt" Type="Int32" />
            <asp:ControlParameter ControlID="TBID" Name="CUSTID" PropertyName="Text" />
            <asp:ControlParameter ControlID="CBLEFTTOO" DefaultValue="0" Name="LeftToo" 
                PropertyName="Checked" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 1007px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="DarkBlue"
        Text="����� ���� ������" Width="432px"></asp:Label></td>
            <td style="width: 86px">
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBID"
        Display="Dynamic" ErrorMessage="���� �� ����" MaximumValue="999999999"
        MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
            <td style="width: 86px">
                <asp:TextBox ID="TBID" runat="server" AutoPostBack="True" Width="97px" Visible="false"></asp:TextBox></td>
                <td style="width: 106px">
                    <asp:CheckBox ID="CBLEFTTOO" runat="server" AutoPostBack="True" 
                        Text="��� �� ������ �����/��� �����" Width="164px" />
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
                        <asp:Label ID="Label8" runat="server" Text="1. ��� ��� �����"></asp:Label></td>
                    <td bgcolor="#37a5ff" align="right" valign="top">
                        <asp:Label ID="Label2" runat="server" Text="2. ��� ���� ������" Width="124px"></asp:Label></td>
                    <td bgcolor="#37a5ff" align="right" valign="top">
                        <asp:Label ID="Label9" runat="server" Text="3. ��� ������ ������" Width="139px"></asp:Label></td>
                    <td bgcolor="#37a5ff" align="right" valign="top">
                        <asp:Label ID="LbEventType" runat="server" Text="4. ��� ����"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px; width: 154px;" valign="top">
                        <span style="font-size: 7pt">�� ����� ���� ����� ������ ���� ��� ������ ������� ���.
                            <br />
                        ������ ���� ����� ������ ��� �.�. � ENTER ����� <strong>�.�.</strong> ����� ����
                        </span>
                    </td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ��� ���� ������ ������� ������ ������� ������.</span></td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ���� ����� ����� �������� �� ��� ����� ���� ������ �� ����� ����� ����� dd/mm/yy
                        ����� ����� ����</span>.</td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ��� ���� ��������� ������<br />
                        (�� ��� ����).</span></td>
                </tr>
                <tr>
                    <td style="width: 154px; height: 160px" valign="top">
                        <asp:ListBox ID="LBCustomers" runat="server" DataSourceID="DSCustomer" DataTextField="CustomerName"
                            DataValueField="CustomerID" Rows="12" AppendDataBoundItems="True" AutoPostBack="True" Height="210px" OnSelectedIndexChanged="LBCustomers_SelectedIndexChanged" Width="150px" EnableViewState="False" OnPreRender="LBCustomers_PreRender">
                        </asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LBCustomers"
                            Display="Dynamic" ErrorMessage="���� ����� �����"></asp:RequiredFieldValidator><asp:Label ID="Label4" runat="server" Style="border-top: black thin solid; margin-top: 1px"
                    Text="* ����� ������<br/> ** ���� ����" Width="156px"></asp:Label></td>
                    <td style="width: 100px; height: 160px" valign="top">
                        <asp:ListBox ID="LSBEventType" runat="server" AutoPostBack="True" DataSourceID="dseVENTtYPES"
                            DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" Height="210px"
                            SelectedValue='<%# Bind("CustEventTypeID") %>' Width="200px" 
                            OnSelectedIndexChanged="LSBEventType_SelectedIndexChanged" 
                            CausesValidation="True"></asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="LSBEventType"
                            Display="Dynamic" ErrorMessage="���� ����� ���� �����" Width="124px"></asp:RequiredFieldValidator></td>
                    <td style="width: 100px; height: 160px" valign="top" align="center">
                        <asp:Calendar ID="CalEvent" runat="server" BackColor="White" BorderColor="#3366CC" 
                            BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="#003399" Height="196px" SelectedDate='2008-04-15' 
                            Width="220px" CellPadding="1" VisibleDate="2008-03-11" OnSelectionChanged="CalEvent_SelectionChanged" OnLoad="CalEvent_Load" ToolTip="���� ����� ����� �������� �� ������ ����� ����� ����� ������">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" Height="1px" ForeColor="#336666" />
                            <TitleStyle BackColor="#003399" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" BorderColor="#3366CC" BorderWidth="1px" Height="25px" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                        </asp:Calendar>
                        <table>
                            <tr>
                                <td style="width: 100px">
                                    <asp:Label ID="Label7" runat="server" Text="��� �����:" Width="75px"></asp:Label></td>
                                <td style="width: 100px">
                        <asp:TextBox ID="TBDate" runat="server" AutoPostBack="True" OnTextChanged="TBDate_TextChanged"
                            ToolTip="�� ����� ����� �����  d/m/y ����  d - ���� �����, m -  ����� ����, y  - ����"
                            Width="81px"></asp:TextBox></td>
                            </tr>
                        </table>
                        <asp:RangeValidator ID="RVDATE" runat="server" ControlToValidate="TBDate"
                            Display="Dynamic" ErrorMessage="���� ����� ��� 1/1/1911 �� 31/12/2050" MaximumValue="2050-12-31"
                            MinimumValue="1911-1-1" Width="205px" Type="Date"></asp:RangeValidator>
                    </td>
                    <td align="center" style="width: 100px; height: 160px" valign="top">
                        <asp:TextBox ID="TBEventComment" runat="server" Rows="5" Text='<%# Bind("CustEventComment") %>'
                            TextMode="MultiLine" Height="189px"></asp:TextBox>
                        <asp:Button ID="BtnOK" runat="server" Style="position: static"
                            Text="����� ������" OnClick="BtnOK_Click" onprerender="BtnOK_PreRender" /></td>
                </tr>
                <tr>
                    <td align="right" colspan="4" valign="top" style="border-right-style: none; border-left-style: none; border-bottom-style: none">
                        <asp:HyperLink ID="HLREPHDR" runat="server" Font-Size="Medium" Font-Underline="True" Text="������ ������� �����"
                            Width="614px"></asp:HyperLink>
                        <asp:HyperLink ID="hlCUSTDET" runat="server">���� �����</asp:HyperLink>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="4" style="border-right-style: none; border-left-style: none;
                        border-bottom-style: none" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="CustEventID" DataSourceID="DSEventList"
                    EnableViewState="False" PageSize="8" style="border-top-style: none" CellPadding="4">
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
                        <asp:BoundField DataField="CustomerID" HeaderText="�.�." SortExpression="CustomerID" Visible="False" />
                        <asp:BoundField DataField="CustEventGroupName" HeaderText="����� " ReadOnly="True"
                            SortExpression="CustEventGroupName" Visible="False">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="��� �����">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" OnPreRender="HL_PreRender" 
                                    NavigateUrl='<%# Eval("CustEventUrl") %>' 
                                    Text='<%# Eval("CustEventTypeName") %>'></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="� �����"
                            HtmlEncode="False" SortExpression="CustEventDate" />
                        <asp:TemplateField HeaderText="����" SortExpression="CustEventComment">
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
                        <asp:BoundField DataField="FrameName" HeaderText="�����" SortExpression="FrameName">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="� �����"
                            HtmlEncode="False" SortExpression="CustEventRegDate" Visible="False" />
                        <asp:BoundField DataField="CframeManager" HeaderText="����" SortExpression="CframeManager" Visible="False">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CReporterUserName" HeaderText="�����" SortExpression="CReporterUserName">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="�������">
                            <ItemTemplate>
                                <asp:LinkButton ID="LBTNCORR" runat="server" CausesValidation="False" 
                                    onclick="LBTNCORR_Click" Visible='<%# Eval("AllowC") AND Eval("CustEventUrl") & vbnullstring = vbnullstring %>' 
                                    >�����</asp:LinkButton>
                                <asp:LinkButton ID="LBTNDEL" runat="server" CausesValidation="False" 
                                    CommandName="Delete" onclientclick="return confirm('��� ����� �� ������?');" 
                                    Visible='<%# Eval("AllowC") AND Eval("CustEventUrl") & vbnullstring = vbnullstring %>' onclick="LBTNDEL_Click">�����</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
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
        
             
			 
			SelectCommand="SELECT CustEventTypeName, CustEventTypeID FROM dbo.fn_EventTypeList(@ServiceID,@UserID) Order by CustEventOrder">
        <SelectParameters>
            <asp:SessionParameter Name="ServiceID" SessionField="ServiceID" />
        	<asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEventList" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT e.CustEventID, e.CustomerID, e.CustEventTypeID, e.CustEventRegDate, e.CustEventDate, e.CustEventComment, e.CustFrameID, e.CframeManager, t.CustEventTypeName, f.FrameName, g.CustEventGroupName, e.UserID, u.URName AS CReporterUserName, CASE WHEN DateAdd(Day , AllowChangeEvent , CustEventRegDate) &gt; GetDate() THEN 1 ELSE 0 END AS AllowC, CASE WHEN t.CustEventURL IS NULL THEN '' ELSE t.CustEventURL + CASE WHEN charindex('?' , t.CustEventURL) &gt; 0 THEN '&amp;' ELSE '?' END + 'ID=' + CASE LEFT (t.CustEventURL , 2) WHEN 'EX' THEN CAST(e.CustRelateID AS varchar(6)) ELSE CAST(e.CustEventID AS varchar(6)) END END AS CustEventUrl, e.CustRelateID FROM FrameList AS f RIGHT OUTER JOIN CustEventList AS e LEFT OUTER JOIN p0t_NtB AS u ON e.UserID = u.UserID ON f.FrameID = e.CustFrameID LEFT OUTER JOIN CustEventGroups AS g RIGHT OUTER JOIN CustEventTypes AS t ON g.CustEventGroupID = t.CustEventGroupID ON e.CustEventTypeID = t.CustEventTypeID LEFT OUTER JOIN dbo.p0t_CustProperties AS p ON p.ServiceTypeID = f.ServiceTypeID WHERE (e.CustomerID &lt;&gt; 0) AND (e.CustomerID = @CustomerID) ORDER BY e.CustEventDate DESC, e.CustEventRegDate DESC" 
        DeleteCommand="Cust_DelEvent" DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter Name="CustomerID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" />
        </DeleteParameters>
    </asp:SqlDataSource>
    </div>
	<asp:Button ID="btnPostback" runat="server" Visible="false" CausesValidation="false"  />
</asp:Content>

