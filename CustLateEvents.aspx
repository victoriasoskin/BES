<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustLateEvents.aspx.vb" Inherits="LateEvents" title="בית אקשטיין - תזכורת לביצוע" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="תזכורת לביצוע" Width="228px"></asp:Label><table border="1">
        <tr>
            <td style="width: 100px; text-align: right">
                <strong>
                    <asp:Label ID="Label3" runat="server" Text="סינון פעולות" Width="79px"></asp:Label></strong></td>
        </tr> 
        <tr>
            <td bgcolor="#ccffff" bordercolor="#0000ff" bordercolordark="#0000ff" style="width: 100px">
    <table>
        <tr>
            <td style="height: 24px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="bottom" bordercolor="#0000ff" bordercolordark="#0000ff" >
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID">
                    <asp:ListItem TEXT="&lt;בחר שירות&gt;" Value=""></asp:ListItem>
                </asp:DropDownList><br />
                <asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True"  AutoPostBack="True" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" EnableViewState="False">
                    <asp:ListItem Text="&lt;בחר מסגרת&gt;" Value="" Selected=True></asp:ListItem>
                </asp:DropDownList></td>
            <td style="height: 24px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="bottom" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:DropDownList ID="DDLGROUP" runat="server" DataSourceID="DSGROUPS" DataTextField="CustEventGroupName"
                    DataValueField="CustEventGroupID" AppendDataBoundItems="True" AutoPostBack="True">
                    <asp:ListItem Text="&lt;בחר קבוצת פעולות&gt;" Value=""></asp:ListItem>
                </asp:DropDownList><br />
                <asp:DropDownList ID="DDLEVENTTYPE" runat="server" Font-Size="Small" DataSourceID="DSEVENTTYPES" DataTextField="CustEventTypeName" DataValueField="CustEventTypeID" AppendDataBoundItems="True" AutoPostBack="True" EnableViewState="False">
                    <asp:ListItem Text="&lt;בחר סוג פעולה&gt;" Value=""></asp:ListItem>
                </asp:DropDownList></td>
            <td style="height: 24px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="bottom" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label2" runat="server" Text="לקוח"></asp:Label><br />
                <asp:TextBox ID="TBCUSTOMER" runat="server" AutoPostBack="True" ToolTip="  הקלד רצף אותיות המופיע בשם הלקוח והקש Enter"
                    Width="83px"></asp:TextBox>
            </td>
            <td style="width: 3px; height: 24px" valign="bottom">
                <asp:CheckBox ID="CBDT" runat="server" AutoPostBack="True" Text="הצג רק פעולות שמועדן עבר"
                    Width="191px" /><br />
                <br />
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/CustLateEvents.aspx"
                    Width="73px">נקה מסננים</asp:HyperLink></td>
        </tr>
    </table>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GVList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="DSEvents"
        Font-Size="Small" ForeColor="#333333" PageSize="15" EnableViewState="False">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="CustomerID" HeaderText="ת.ז." SortExpression="CustomerID" />
            <asp:BoundField DataField="Name" HeaderText="שם" SortExpression="Name" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventGroupName" HeaderText="קבוצה" SortExpression="CustEventGroupName">
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="custeventtypename" HeaderText="סוג פעולה" SortExpression="CustEventTypeName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת פעולה"
                HtmlEncode="False" SortExpression="custEventDate" />
            <asp:TemplateField HeaderText="הערה" SortExpression="CustEventComment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBComment" runat="server" Text='<%# Truncfield("CustEventComment",25) %>'
                        ToolTip='<%# Eval("CustEventComment") & "" %>' Width="160px"></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CFrameManager" HeaderText="מנהל" SortExpression="CFrameManager" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="המועד הבא" SortExpression="nextDate">
                <HeaderStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="LBnextDate" runat="server" OnPreRender="LBnextDate_PreRender" Text='<%# Eval("nextDate", "{0:dd/MM/yy}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEvents" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT CustomerID, CustFirstName + ' ' + CustLastName AS name, CustEventTypeName, CustEventDate, CustEventComment, FrameName, CframeManager, CReporterUserName, CustEventGroupName, CustFrameID, CustEventDays, nextDate FROM vCustLastEvents WHERE (CustFrameID = ISNULL(@FrameID, CustFrameID)) AND (CustFrameID = ISNULL(@CustFrameID, CustFrameID)) AND (ServiceID = ISNULL(@ServiceID, ServiceID)) AND (CustEventGroupID = ISNULL(@GroupID, CustEventGroupID)) AND (CustEventTypeID = ISNULL(@EventTypeID, CustEventTypeID)) AND (CustomerName LIKE '%' + @CustomerName + '%') AND (CustEventDays <> 0) AND (nextDate <= CASE @CBDT WHEN 1 THEN getdate() ELSE nextdate END) ORDER BY nextDate" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" DefaultValue="0" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="CustFrameID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLGroup" Name="GroupID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="DDLEVENTTYPE" Name="EventTypeID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TBCUSTOMER" Name="CustomerName" PropertyName="Text" DefaultValue=' ' />
            <asp:ControlParameter ControlID="CBDT" Name="CBDT" PropertyName="Checked" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSGROUPS" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustEventGroupName], [CustEventGroupID] FROM [CustEventGroups]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEVENTTYPES" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT [CustEventTypeName], [CustEventTypeID] FROM [CustEventTypes] WHERE ([CustEventGroupID] = isnull(@CustEventGroupID,[CustEventGroupID]))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLGROUP" Name="CustEventGroupID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
