<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventReportU.aspx.vb" Inherits="CustEventReportU" title="��� ������� - ����� ���� ������" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:SqlDataSource ID="DSCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="CustTable" EnableViewState="False" 
        CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:Parameter DefaultValue="1" Name="Bldt" Type="Int32" />
            <asp:ControlParameter ControlID="TBID" Name="CUSTID" PropertyName="Text" />
            <asp:Parameter DefaultValue="0" Name="LeftToo" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table>
        <tr>
            <td style="width: 1007px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="DarkBlue"
        Text="����� ���� ������ - ����� �����" Width="369px"></asp:Label></td> 
            <td style="width: 86px">
                &nbsp;�.�.
                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBID"
        Display="Dynamic" ErrorMessage="���� �� ����" MaximumValue="999999999"
        MinimumValue="0" Type="Integer"></asp:RangeValidator></td>
            <td style="width: 86px">
                <asp:TextBox ID="TBID" runat="server" AutoPostBack="True" Width="97px"></asp:TextBox></td>
        </tr>
    </table>
        <table>
        <tr>
            <td colspan="3" valign="top">
                <asp:FormView ID="FVInsertEvent" runat="server" DataSourceID="DSEvents" 
                    DefaultMode="Edit">
        <InsertItemTemplate>
            <table border="1" bordercolor="#0033ff">
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
                    Text="* ���� ��� �����" Width="156px"></asp:Label></td>
                    <td style="width: 100px; height: 160px" valign="top">
                        <asp:ListBox ID="LSBEventType" runat="server" AutoPostBack="True" DataSourceID="dseVENTtYPES"
                            DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" Height="210px"
                            SelectedValue='<%# Bind("CustEventTypeID") %>' Width="150px" OnSelectedIndexChanged="LSBEventType_SelectedIndexChanged"></asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="LSBEventType"
                            Display="Dynamic" ErrorMessage="���� ����� ���� �����" Width="124px"></asp:RequiredFieldValidator></td>
                    <td style="width: 100px; height: 160px" valign="top" align="center">
                        <asp:Calendar ID="CalEvent" runat="server" BackColor="White" BorderColor="#3366CC"
                            BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="#003399" Height="196px" SelectedDate='<%# Bind("CustEventDate") %>' 
                            Width="220px" CellPadding="1" VisibleDate='<%# Bind("CustEventDate") %>' OnSelectionChanged="CalEvent_SelectionChanged" OnLoad="CalEvent_Load" ToolTip="���� ����� ����� �������� �� ������ ����� ����� ����� ������">
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
                            Text="����� ������" OnClick="BtnOK_Click" /></td>
                </tr>
                <tr>
                    <td align="right" colspan="4" valign="top" style="border-right-style: none; border-left-style: none; border-bottom-style: none">
                        <asp:Label ID="LBLREPHDR" runat="server" Font-Size="Medium" Font-Underline="True" Text="������ ������� �����"
                            Width="614px"></asp:Label></td>
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
                        <asp:BoundField DataField="CustEventTypeName" HeaderText="��� �����" SortExpression="CustEventTypeName" />
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
                                    onclick="LBTNCORR_Click" Visible='<%# Eval("AllowC") %>' 
                                    >�����</asp:LinkButton>
                                <asp:LinkButton ID="LBTNDEL" runat="server" CausesValidation="False" 
                                    CommandName="Delete" onclientclick="return confirm('��� ����� �� ������?');" 
                                    Visible='<%# Eval("AllowC")=1 %>'>�����</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table border="1" bordercolor="#0033ff">
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
                        <span style="font-size: 7pt">��� ����� ���.&nbsp; �� ������&nbsp; ����� ������ ���� ��� 
                        ������ ������ ���.
                            <br />
                        ������ ���� ����� ������ ��� �.�. � ENTER ����� <strong>�.�.</strong> ����� ����
                        </span>
                    </td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ��� �� ��� ������.&nbsp; �� ���� ������&nbsp; ���� ������� �����&nbsp; ������� ������.</span></td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ��� �� ����� ������. ���� ����� ����� �������� �� ��� ����� ���� ������ �� ����� 
                        ����� ����� dd/mm/yy ����� ����� ����</span>.</td>
                    <td align="right" bgcolor="#37a5ff" style="height: 52px" valign="top">
                        <span style="font-size: 7pt">
                        ��� �� ����� ������<br />
                        (�� ��� ����).</span></td>
                </tr>
                <tr>
                    <td style="width: 154px; height: 160px" valign="top">
                        <asp:ListBox ID="LBCustomers" runat="server" DataSourceID="DSCustomer" DataTextField="CustomerName"
                            DataValueField="CustomerID" Rows="12" AppendDataBoundItems="True" AutoPostBack="True" Height="210px" OnSelectedIndexChanged="LBCustomers_SelectedIndexChanged" Width="150px" EnableViewState="False" OnPreRender="LBCustomers_PreRender">
                        </asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LBCustomers"
                            Display="Dynamic" ErrorMessage="���� ����� �����"></asp:RequiredFieldValidator><asp:Label ID="Label4" runat="server" Style="border-top: black thin solid; margin-top: 1px"
                    Text="* ���� ��� �����" Width="156px"></asp:Label></td>
                    <td style="width: 100px; height: 160px" valign="top">
                        <asp:ListBox ID="LSBEventType" runat="server" AutoPostBack="True" DataSourceID="dseVENTtYPES"
                            DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" Height="210px"
                            SelectedValue='<%# Bind("CustEventTypeID") %>' Width="200px" OnSelectedIndexChanged="LSBEventType_SelectedIndexChanged"></asp:ListBox><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="LSBEventType"
                            Display="Dynamic" ErrorMessage="���� ����� ���� �����" Width="124px"></asp:RequiredFieldValidator></td>
                    <td style="width: 100px; height: 160px" valign="top" align="center">
                        <asp:Calendar ID="CalEvent" runat="server" BackColor="White" BorderColor="#3366CC"
                            BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="#003399" Height="196px" SelectedDate='<%# Bind("CustEventDate") %>' 
                            Width="220px" CellPadding="1" VisibleDate='<%# Bind("CustEventDate") %>' OnSelectionChanged="CalEvent_SelectionChanged" OnLoad="CalEvent_Load" ToolTip="���� ����� ����� �������� �� ������ ����� ����� ����� ������">
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
                            Display="Dynamic" ErrorMessage="���� ����� ��� 1/1/1911 �� 31/12/2015" MaximumValue="31/12/2015"
                            MinimumValue="1/1/1911" Width="205px" Type="Date"></asp:RangeValidator>
                    </td>
                    <td align="center" style="width: 100px; height: 160px" valign="top">
                        <asp:TextBox ID="TBEventComment" runat="server" Rows="5" Text='<%# Bind("CustEventComment") %>'
                            TextMode="MultiLine" Height="189px"></asp:TextBox>
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:Button ID="BtnOK" runat="server" OnClick="BtnOK_Click" 
                                        Style="position: static" Text="����� ������" />
                                </td>
                                <td>
                                    <asp:Button ID="BTNCANCEL" runat="server" onclick="BTNCANCEL_Click" 
                                        Text="�����" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="4" valign="top" style="border-right-style: none; border-left-style: none; border-bottom-style: none">
                        <asp:Label ID="LBLREPHDR" runat="server" Font-Size="Medium" Font-Underline="True" Text="������ ������� �����"
                            Width="614px"></asp:Label></td>
                </tr>
                <tr>
                    <td align="right" colspan="4" style="border-right-style: none; border-left-style: none;
                        border-bottom-style: none" valign="top">
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="CustEventID" DataSourceID="DSEventList"
                    EnableViewState="False" PageSize="8" style="border-top-style: none" CellPadding="4">
                    <Columns>
                        <asp:BoundField DataField="CustEventID" HeaderText="CustEventID" InsertVisible="False"
                            ReadOnly="True" SortExpression="CustEventID" Visible="False" />
                        <asp:BoundField DataField="CustomerID" HeaderText="�.�." SortExpression="CustomerID" Visible="False" />
                        <asp:BoundField DataField="CustEventGroupName" HeaderText="����� " ReadOnly="True"
                            SortExpression="CustEventGroupName" Visible="False">
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CustEventTypeName" HeaderText="��� �����" SortExpression="CustEventTypeName" />
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
                    </Columns>
                </asp:GridView>
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
    </asp:FormView>
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
        DeleteCommand="DELETE FROM [CustEventList] WHERE [CustEventID] = @CustEventID"
        InsertCommand="Cust_AddEvent"
        SelectCommand="SELECT * FROM [CustEventList] Where CustEventID=isnull(@CustEventID,CustEventID)" 
        UpdateCommand="Cust_UPDEvent" 
        InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="CustEventID" SessionField="CustEventID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" Type="Int64" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" Type="DateTime" />
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:Parameter Name="CustFrameID" Type="Int32" />
            <asp:Parameter Name="CframeManager" Type="String" />
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
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
        SelectCommand="SELECT CustEventTypes.CustEventTypeName, CustEventTypes.CustEventTypeID FROM CustEventTypes LEFT OUTER JOIN CustEventGroups ON CustEventTypes.CustEventGroupID = CustEventGroups.CustEventGroupID WHERE (CustEventGroups.CustEventServiceID = ISNULL(@ServiceID, CustEventGroups.CustEventServiceID)) AND (CustEventTypes.CustEventApp = 1) OR (CustEventGroups.CustEventServiceID IS NULL) ORDER BY CustEventTypes.CustEventGroupID, CustEventTypes.CustEventTypeID">
        <SelectParameters>
            <asp:SessionParameter Name="ServiceID" SessionField="ServiceID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEventList" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT CustEventList.CustEventID, CustEventList.CustomerID, CustEventList.CustEventTypeID, CustEventList.CustEventRegDate, CustEventList.CustEventDate, CustEventList.CustEventComment, CustEventList.CustFrameID, CustEventList.CframeManager, CustEventTypes.CustEventTypeName, FrameList.FrameName, CustEventGroups.CustEventGroupName, CustEventList.UserID, p0t_Ntb.URName AS CReporterUserName, CASE WHEN DateAdd(Day , AllowChangeEvent , CustEventRegDate) &gt; GetDate() THEN 1 ELSE 0 END AS AllowC FROM FrameList RIGHT OUTER JOIN CustEventList LEFT OUTER JOIN p0t_Ntb ON CustEventList.UserID = p0t_Ntb.UserID ON FrameList.FrameID = CustEventList.CustFrameID LEFT OUTER JOIN CustEventGroups RIGHT OUTER JOIN CustEventTypes ON CustEventGroups.CustEventGroupID = CustEventTypes.CustEventGroupID ON CustEventList.CustEventTypeID = CustEventTypes.CustEventTypeID left outer JOIN dbo.p0t_CustProperties on dbo.p0t_CustProperties.ServiceTypeID=FrameList.ServiceTypeID WHERE (CustEventList.CustomerID = @CustomerID) ORDER BY CustEventList.CustEventDate DESC" 
        DeleteCommand="DELETE FROM CustEventList WHERE (CustEventID = @CustEventID)">
        <SelectParameters>
            <asp:SessionParameter Name="CustomerID" SessionField="lastCustID" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>

