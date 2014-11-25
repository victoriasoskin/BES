<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ExEventList.aspx.vb" Inherits="Default3" title="בית אקשטיין - ארועים חריגים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="רשימת ארועים חריגים" Width="237px"></asp:Label><table border="1">
        <tr>
            <td style="width: 100px; text-align: right">
                <strong>
                    <asp:Label ID="Label3" runat="server" Text="סינון ארועים" Width="79px"></asp:Label>
                <br />
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/CustEventList.aspx"
                    Width="73px" Font-Bold="True" Height="16px">נקה מסננים</asp:HyperLink></strong></td>
        </tr>
        <tr>
            <td bgcolor="#ccffff" bordercolor="#0000ff" bordercolordark="#0000ff" style="width: 100px">
    <table>
        <tr>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff" >
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID">
                    <asp:ListItem TEXT="&lt;בחר שירות&gt;" Value=""></asp:ListItem>
                </asp:DropDownList><br /> 
                <asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True"  AutoPostBack="True" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" EnableViewState="False">
                    <asp:ListItem Text="&lt;בחר מסגרת&gt;" Value=""></asp:ListItem>
                </asp:DropDownList></td>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text="סינון לפי סוג פעולה"
                    Width="126px" Height="16px" Visible="False"></asp:Label><br />
                <asp:DropDownList ID="DDLEVENTTYPE" runat="server" Font-Size="Small" 
                    AppendDataBoundItems="True" AutoPostBack="True" EnableViewState="False" 
                    Width="159px" DataSourceID="DSEVENTTYPES" DataTextField="lvl1" 
                    DataValueField="lvl1">
                    <asp:ListItem Text="&lt;כל הסוגים הראשיים&gt;" Value=""></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:DropDownList ID="DDLLISTTYPE" runat="server" AutoPostBack="True" 
                    Font-Size="Small" DataSourceID="DSEVENTSTYPE" 
                    DataTextField="lvl2" DataValueField="ID" AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;כל הסוגים&gt;</asp:ListItem>
                </asp:DropDownList>
                
            </td>
            <td style="border-style: solid; border-color: inherit; border-width: 1px; width: 108px;" 
                valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label2" runat="server" Text="סינון לפי שם לקוח" Font-Bold="True" Font-Underline="True" Width="131px"></asp:Label><br />
                <asp:TextBox ID="TBCUSTOMER" runat="server" AutoPostBack="True" ToolTip=" הקלד רצף אותיות המופיע בשם הלקוח והקש Enter"
                    Width="83px"></asp:TextBox><asp:Panel ID="Panel1" runat="server" Font-Size="X-Small"
                        Height="50px" ScrollBars="Vertical" Width="125px">
                        הקלד רצף אותיות הקיים בשם הלקוח והקש ENTER<br />
                        המערכת תציג רק לקוחות שבשמם קיים רצף האותיות שהוקלד</asp:Panel>
            </td>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid; width: 89px;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text="סינון לפי תאריך"
                    Width="100px"></asp:Label><br />
                <asp:TextBox ID="TBDATE" runat="server" CausesValidation="True" Width="77px" AutoPostBack="True"></asp:TextBox><asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBDATE"
                    Display="Dynamic" ErrorMessage="*" MaximumValue="1/1/2090" MinimumValue="1/1/1900"
                    Type="Date"></asp:RangeValidator><asp:Panel ID="Panel2" runat="server" Font-Size="X-Small"
                        Height="50px" ScrollBars="Vertical" Width="125px">
                        הקלד תאריך במבנה dd/mm/yy והקש ENTERהמערכת תציג רק ארועים עם תאריך ארוע לפני 
                        התאריך שהוקלד</asp:Panel>
            </td>
            <td valign="top">
                <asp:DropDownList ID="DDLSTATUS" runat="server" DataSourceID="DSSTATUS" 
                    DataTextField="ShortSatatus" DataValueField="StatusID" 
                    AppendDataBoundItems="True" AutoPostBack="True">
                    <asp:ListItem Value="">&lt;כל הסטסטוסים&gt;</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
            </td>
        </tr>
    </table>
    <div style="width: 581px">הרשימה מכילה אירועים החל מינואר 2009 ועד יום זה</div>
    <asp:GridView ID="GVList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" 
        Font-Size="Small" ForeColor="#333333" PageSize="13" EnableViewState="False" DataSourceID="DSEvents">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="ת.ז." SortExpression="CustomerID">
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("CustomerID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustomerID") %>'></asp:TextBox>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="שם" SortExpression="Name" DataField="CustomerName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ExEventHeader" HeaderText="כותרת" 
                SortExpression="ExEventHeader" />
            <asp:BoundField DataField="CustEventDate" HeaderText="ת ארוע חריג" 
                SortExpression="custEventDate" DataFormatString="{0:dd/MM/yy}" 
                HtmlEncode="False" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="סוג הארוע" SortExpression="lvl2">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# TruncField("lvl2",22) %>' ToolTip='<%#Eval("lvl2") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# TruncField("lvl2",25) %>' ToolTip='<%#Eval("lvl2") %>'></asp:TextBox>
                </EditItemTemplate>
                <ControlStyle Width="120px" />
                <FooterStyle Width="120px" />
                <HeaderStyle Width="120px" Wrap="true" />
                <ItemStyle Wrap="True" />
            </asp:TemplateField>
            <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת רישום"
                HtmlEncode="False" SortExpression="CustEventRegDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CReporterUserName" HeaderText="על ידי" SortExpression="CReporterUserName">
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Severity" HeaderText="חומרה" 
                SortExpression="Severity" />
            <asp:BoundField DataField="ShortSatatus" HeaderText="סטטוס" 
                SortExpression="ShortSatatus" />
            <asp:HyperLinkField DataNavigateUrlFields="ExEventID" 
                DataNavigateUrlFormatString="ExEvent.aspx?P=1&amp;ID={0}" 
                DataTextField="CustEventComment" HeaderText="קישור">
            <ItemStyle Wrap="False" />
            </asp:HyperLinkField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEvents" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT p0v_EXEventList.CustomerID, p0v_EXEventList.CustomerName, p0v_EXEventList.ExEventID, p0v_EXEventList.ExEventHeader, p0v_EXEventList.lvl2, p0v_EXEventList.ExEventAsClosingDate, p0v_EXEventList.CustEventDate, p0v_EXEventList.FrameName, p0v_EXEventList.ShortSatatus, p0v_EXEventList.Severity, p0v_EXEventList.CustEventRegDate, p0v_EXEventList.CReporterUserName, p0v_EXEventList.CustEventComment, p0v_EXEventList.ExEventTypeID FROM p0v_EXEventList LEFT OUTER JOIN dbo.p0v_UserFrameList ON p0v_EXEventList.CustFrameID = dbo.p0v_UserFrameList.FrameID WHERE (p0v_EXEventList.ServiceID = ISNULL(@serviceID, p0v_EXEventList.ServiceID)) AND (p0v_EXEventList.CustFrameID = ISNULL(@FrameID, p0v_EXEventList.CustFrameID)) AND (p0v_EXEventList.lvl1 = ISNULL(@LVL, p0v_EXEventList.lvl1)) AND (p0v_EXEventList.ExEventStatusID = ISNULL(@statusid, p0v_EXEventList.ExEventStatusID)) AND (dbo.p0v_UserFrameList.UserID = @UserID) GROUP BY p0v_EXEventList.CustomerID, p0v_EXEventList.CustomerName, p0v_EXEventList.ExEventID, p0v_EXEventList.ExEventHeader, p0v_EXEventList.lvl2, p0v_EXEventList.ExEventAsClosingDate, p0v_EXEventList.CustEventDate, p0v_EXEventList.FrameName, p0v_EXEventList.ShortSatatus, p0v_EXEventList.Severity, p0v_EXEventList.CustEventRegDate, p0v_EXEventList.CReporterUserName, p0v_EXEventList.CustEventComment, p0v_EXEventList.ExEventTypeID HAVING (p0v_EXEventList.CustomerName LIKE N'%' + ISNULL(@Cname, p0v_EXEventList.CustomerName) + N'%') AND (p0v_EXEventList.CustEventDate &lt;= ISNULL(@CustEventDate, p0v_EXEventList.CustEventDate)) AND (p0v_EXEventList.ExEventTypeID = ISNULL(@EXXTID, p0v_EXEventList.ExEventTypeID)) ORDER BY p0v_EXEventList.CustEventDate" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" 
                PropertyName="SelectedValue" Type="Int32" DefaultValue=""  />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="FrameID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDLEVENTTYPE" Name="LVL" 
                PropertyName="SelectedValue" Type="String" />
            <asp:ControlParameter ControlID="DDLSTATUS" Name="statusid" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UserID" SessionField="USERID" />
            <asp:ControlParameter ControlID="TBCUSTOMER" Name="Cname" PropertyName="Text" Type="String"/>
            <asp:ControlParameter ControlID="TBDATE" Name="CustEventDate" type="DateTime"
                PropertyName="Text" />
            <asp:ControlParameter ControlID="DDLLISTTYPE" Name="EXXTID" 
                PropertyName="SelectedValue" Type="int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEVENTSTYPE" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT lvl2, ID FROM p0v_EXEventType WHERE (lvl1 = @LVL1)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLEVENTTYPE" Name="LVL1" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource> 
    <asp:SqlDataSource ID="DSSTATUS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [ShortSatatus], [StatusID] FROM [ExEventStatus] ORDER BY [StatusID]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEVENTTYPES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT distinct lvl1 FROM p0v_EXEventType " 
        CancelSelectOnNullParameter="False">
    </asp:SqlDataSource>
</asp:Content>
