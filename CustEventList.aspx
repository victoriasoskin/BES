<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventList.aspx.vb" Inherits="Default3" title="��� ������� - ���� ������" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="���� ����� ������" Width="136px"></asp:Label><table border="1">
        <tr>
            <td style="width: 100px; text-align: right">
                <strong>
                    <asp:Label ID="Label3" runat="server" Text="����� ������" Width="79px"></asp:Label></strong></td>
        </tr>
        <tr>
            <td bgcolor="#ccffff" bordercolor="#0000ff" bordercolordark="#0000ff" style="width: 100px">
    <table>
        <tr>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff" >
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID">
                    <asp:ListItem TEXT="&lt;��� �����&gt;" Value=""></asp:ListItem>
                </asp:DropDownList><br /> 
                <asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True"  AutoPostBack="True" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" EnableViewState="False">
                    <asp:ListItem Text="&lt;��� �����&gt;" Value=""></asp:ListItem>
                </asp:DropDownList></td>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Underline="True" Text="����� ��� ��� �����"
                    Width="126px"></asp:Label><br />
                <asp:DropDownList ID="DDLEVENTTYPE" runat="server" Font-Size="Small" AppendDataBoundItems="True" AutoPostBack="True" EnableViewState="False" Width="159px" DataSourceID="DSEVENTTYPES" DataTextField="CustEventTypeName" DataValueField="CustEventTypeID">
                    <asp:ListItem Text="&lt;��� ��� �����&gt;" Value=""></asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="DDLLISTTYPE" runat="server" AutoPostBack="True" Font-Size="X-Small">
                    <asp:ListItem Value="0" Selected="True">��� �� �� ������ �� ��� ������ �����</asp:ListItem>
                    <asp:ListItem Value="1">��� �� �� ������� ��� ���� ��� ��� ������ �����</asp:ListItem>
                    <asp:ListItem Value="2">��� ��� ���� �� ������ ������� ���� ������ �����</asp:ListItem>
                    <asp:ListItem Value="3">��� �� ������� ������ ��� ���� ������ ���� ������ �����</asp:ListItem>
                    <asp:ListItem Value="4">��� �� ������� ������ ���� ���� ������ �������� �������</asp:ListItem>
                </asp:DropDownList>
                <asp:Panel ID="Panel3" runat="server" Font-Size="X-Small" Height="35px" ScrollBars="Vertical"
                    Width="280px">
                    <strong><span style="text-decoration: underline">����:</span></strong> ��� �����
                    �� ����� ������� ��� ����� ��� ����� �� ����� ������, �� ����� ���� "����� ������".
                    ������� ��� ����� ��� ����� ����� ������ �� ����� ����� ������,&nbsp;</asp:Panel>
            </td>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label2" runat="server" Text="����� ��� �� ����" Font-Bold="True" Font-Underline="True" Width="131px"></asp:Label><br />
                <asp:TextBox ID="TBCUSTOMER" runat="server" AutoPostBack="True" ToolTip=" ���� ��� ������ ������ ��� ����� ���� Enter"
                    Width="83px"></asp:TextBox><asp:Panel ID="Panel1" runat="server" Font-Size="X-Small"
                        Height="50px" ScrollBars="Vertical" Width="125px">
                        ���� ��� ������ ����� ��� ����� ���� ENTER<br />
                        ������ ���� �� ������ ����� ���� ��� ������� ������</asp:Panel>
            </td>
            <td style="border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid; width: 89px;" valign="top" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Underline="True" Text="����� ��� �����"
                    Width="100px"></asp:Label><br />
                <asp:TextBox ID="TBDATE" runat="server" CausesValidation="True" Width="77px" AutoPostBack="True"></asp:TextBox><asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBDATE"
                    Display="Dynamic" ErrorMessage="*" MaximumValue="1/1/2090" MinimumValue="1/1/1900"
                    Type="Date"></asp:RangeValidator><asp:Panel ID="Panel2" runat="server" Font-Size="X-Small"
                        Height="50px" ScrollBars="Vertical" Width="125px">
                        ���� ����� ����� dd/mm/yy ���� ENTER������ ���� �� ������ �� ����� ����� ���� ������
                        ������</asp:Panel>
            </td>
            <td valign="top">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/CustEventList.aspx"
                    Width="73px" Font-Bold="True">��� ������</asp:HyperLink></td>
        </tr>
    </table>
            </td>
        </tr>
    </table>
    <asp:GridView ID="GVList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustEventID"
        Font-Size="Small" ForeColor="#333333" PageSize="13" EnableViewState="False" DataSourceID="DSEvents">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="�.�." SortExpression="CustomerID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustomerID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="LNKBID" runat="server" OnClick="LNKBID_Click" 
                        Text='<%# Eval("CustomerID") %>' Height="17px" ToolTip="��� ��� ����� ������ ���� ������ ���� ���� ��" Width="80px" Font-Size="X-Small"></asp:Button>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="��" SortExpression="Name" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="custeventtypename" HeaderText="��� �����" SortExpression="CustEventTypeName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="� �����"
                HtmlEncode="False" SortExpression="custEventDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="����" SortExpression="CustEventComment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                     <asp:Button ID="btnSA" runat="server" Height="16px" onclick="btnSA_Click" 
                        Text="..." Width="16px" />
                   <asp:Label ID="LBComment" runat="server" Text='<%# Truncfield("CustEventComment",25) %>'
                        ToolTip='<%# Eval("CustEventComment") & "" %>' Width="160px"></asp:Label>
                    <asp:TextBox ID="TBSA" runat="server" Height="75px" ReadOnly="True" 
                        Text='<%# Eval("CustEventComment") %>' TextMode="MultiLine" Visible="False"></asp:TextBox>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="FrameName" HeaderText="�����" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustFinalDate" DataFormatString="{0:dd/MM/yy}" HeaderText="��� ��"
                HtmlEncode="False" SortExpression="CustEventDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="� �����"
                HtmlEncode="False" SortExpression="CustEventRegDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CReporterUserName" HeaderText="�� ���" SortExpression="CReporterUserName">
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="��� �����">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("CustEventurl") %>' 
                        Text='<%# Eval("CustEventTypeName") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEvents" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" SelectCommand="p2p_CustEventList" CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="CustFrameID" PropertyName="SelectedValue" Type="Int32" DefaultValue=""  />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" Type="Int32" DefaultValue=""  />
            <asp:ControlParameter ControlID="DDLEVENTTYPE" Name="EventTypeID" PropertyName="SelectedValue"  Type="Int32" />
            <asp:ControlParameter ControlID="TBCUSTOMER" Name="CustomerName" PropertyName="Text" DefaultValue=" " />
            <asp:ControlParameter ControlID="TBDATE" Name="EventDate" PropertyName="Text" DefaultValue='2020-12-31' Type="DateTime" />
            <asp:ControlParameter ControlID="DDLLISTTYPE" Name="ListType" PropertyName="SelectedValue"  DefaultValue="0" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
   <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource> 
    <asp:SqlDataSource ID="DSEVENTTYPES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" SelectCommand="SELECT CustEventTypeName, CustEventTypeID FROM dbo.p0v_EventServiceList order by custeventtypeid" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="CustEventServiceID" SessionField="ServiceID" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
