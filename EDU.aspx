<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="EDU.aspx.vb" Inherits="EDU" title="��� ������� - ����� �������" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" Height="55" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="�����" CausesValidation="false" />
    </div>
  <div id="divform" runat="server">      
        <table>
        <tr>
            <td style="width: 280px">
                 <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="���� �������" Width="551px"></asp:Label></td>
            <td style="width: 100px"> 
                <asp:Label ID="LBLDATE" runat="server" Text="Label" Width="97px"></asp:Label></td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LBLFRAMENAME"  runat="server" Text="Label" Width="165px"></asp:Label><asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSFRAMES" DataTextField="FrameName" DataValueField="FrameID" Visible="false">
                    <asp:ListItem Value="" Selected="True">&lt;��� �����&gt;</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="DDLGROUPID" runat="server" AutoPostBack="True" 
                    DataSourceID="DSGROUPTYPE" DataTextField="CustEventGroupName" 
                    DataValueField="CustEventGroupID" AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;��� ����&gt;</asp:ListItem>
                  
                </asp:DropDownList>
                <asp:LinkButton ID="LNKBADDCAND" runat="server" 
                    PostBackUrl="~/CustomerAdd2.aspx?CAND=1" 
                    ToolTip="��� ��� ������ ����� ����� ����� ������">����� ���</asp:LinkButton>
                <asp:SqlDataSource ID="DSGROUPTYPE" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    
                    
                    
                    SelectCommand="SELECT CustEventGroupName, CustEventGroupID FROM CustEventGroups WHERE (CustEventGroupSort = 1) or(CustEventGroupSort = 1) AND (@MF = 1)">
                    <SelectParameters>
                        <asp:SessionParameter Name="MF" SessionField="MultiFrame" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                <asp:Panel ID="Panel1" runat="server" BorderColor="#3333CC" 
                    BorderStyle="Dotted" BorderWidth="1px" Font-Size="X-Small" Height="140px" 
                    Visible="false">
                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Small" 
                        Font-Underline="True" ForeColor="#0033CC" Text="������ �����"></asp:Label>
                    <br />
                    1. ��� ������ ������ ��������.<br />
                    2. �����&nbsp; ��� �������� ���.<br />
					3.&nbsp; <span style="color: #FF0000"><b>���� ����&nbsp; ������ �������� � * ������ 
                    &quot;����&quot; ��� ������� ����� ���� �������</b></span><br />
					3. ������
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �. ��� ������ (����� ���� - ����) ���� �����&nbsp; �� ������ ������&nbsp; ����� �� 
                    ����� �������� (���� ������� ������ ��� ������)&nbsp;
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �. ���� ���� ������ ���� (�� ��)<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; �. ��� ��&nbsp; ������ ����� ������ ������� &quot;����&quot;&nbsp; (�� / �� / ������.)<br />
                    4. ������ �����: ����� ������ ��� �� ������ ������ &quot;�� ����&quot;&nbsp; (�� / ��� / �� 
					������)
					<br />
					5. ��� �� ��� �� ������ ���� �� ������.<br />
                </asp:Panel>
                                <asp:Button ID="btnhlp" runat="server" Text="��� ������ �����" />
                <asp:CheckBox ID="CBALLCAND" runat="server" AutoPostBack="True" 
                    Text="��� �� ������� ����� (������� � *)" />
                <asp:CheckBox ID="CBCORRECT" runat="server" Text="��� �� �� ������� (��� �����/���� ����� ��������)" AutoPostBack="true" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="2">
                <table>
                    <tr>
                        <td valign="top">
                <asp:ListBox ID="LSBCUST" runat="server" AutoPostBack="True" DataSourceID="DSCustomers"
                    DataTextField="CustomerName" DataValueField="CustomerID" Height="198px" Width="180px">
                </asp:ListBox></td>
                        <td valign="top">
                            <span style="font-size: 2px"></span>
                            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="DSSELECTEDCUST"
                                Height="198px" Width="480px" BackColor="#003399">
                                <Fields>
                                    <asp:BoundField DataField="�.�." HeaderText="�.�." SortExpression="�.�.">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="��" HeaderText="��" ReadOnly="True" SortExpression="��">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="����� ����" DataFormatString="{0:dd/MM/yy}" HeaderText="����� ����"
                                        SortExpression="����� ����">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="���" HeaderText="���" ReadOnly="True" SortExpression="���">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="�����" HeaderText="�����" SortExpression="�����">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="�����1" SortExpression="�����1">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="���" HeaderText="���" SortExpression="���">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="�����" HeaderText="�����" SortExpression="�����">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Fields>
                                <HeaderStyle Width="30%" />
                            </asp:DetailsView>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" valign="top">
<%--             <asp:UpdatePanel runat="server" ID="updt" UpdateMode="Always"><ContentTemplate>
--%>                
				<asp:HyperLink ID="HLUPD" runat="server">����� ���� �����</asp:HyperLink><br />
				<asp:Label runat="server" ID="lblerr" Text="�� ������ ���� ��� �����" Font-Bold="true" ForeColor="Red" Font-Size="Larger" Visible="false" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="DSEVENTTypes" CellPadding="2" 
                     DataKeyNames="CustEventID,CCEID">
                    <Columns>
                        <asp:TemplateField HeaderText="������" SortExpression="CustEventTypeName">
                            <ItemTemplate>
                                <asp:Label ID="LBLEVENTTYPE" runat="server" Text='<%# Eval("CustEventTypeName") %>' 
                                    ToolTip='<%# Eval("CustEventTypeComment") %>' 
                                    ForeColor='<%# dpr("CustEventDate") %>' onprerender="LBLEVENTTYPE_PreRender"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="����">
                            <ItemTemplate>
                            <asp:Label ID="CBMUST" runat="server" forecolor="Red"
                                    Text='<%# if(eval("custeventtypemust"),"*","") %>' Font-Bold="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="�� ����?" SortExpression="CustEventResult">
                            <ItemTemplate>
                                <asp:Label ID="LBLRESULT" runat="server" Text='<%# eval("CustEventResult") %>'  ForeColor='<%# dpr("CustEventDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="������" SortExpression="CustEventDate">
                             <ItemTemplate>
                                <asp:TextBox ID="TBDATE" runat="server" OnPreRender="TBDATE_PreRender" Text='<%# Bind("CustEventDate", "{0:dd/MM/yy}") %>'
                                    Width="57px"></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBDATE"
                                    Display="Dynamic" ErrorMessage="����� �� ����" MaximumValue="2050-12-31" MinimumValue="2008-1-1"
                                    Type="Date"></asp:RangeValidator>
                                <asp:Button ID="Button1" runat="server" Height="18px" OnClick="Button1_Click" Text="..." />
                                <asp:Calendar ID="CALEVENT" runat="server" Font-Size="X-Small" OnSelectionChanged="CALEVENT_SelectionChanged"
                                    Visible="False"></asp:Calendar>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TBDATE"
                                    Display="Dynamic" ErrorMessage="���� ����� �����"></asp:RequiredFieldValidator>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="����" SortExpression="CustEventComment">
                           <ItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" OnPreRender="TextBox3_PreRender" Width="349px" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" HeaderText="���� ����">
                            <ItemTemplate>
                                <asp:LinkButton ID="LNKBADDP" runat="server" CausesValidation="False" CommandName="Update"
                                    Text='<%# Eval("AnswerPositive") %>' onclick="LNKBADD_Click" OnClientClick="this.disable=true;"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <HeaderStyle BackColor="DarkBlue" />
                        </asp:TemplateField>
                        <asp:TemplateField SortExpression="CustEventTypeID" HeaderText="���� �� ����">
                            <ItemTemplate>
                                <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("CustEventTypeID") %>' />
                                <asp:LinkButton ID="LNKBADDN" runat="server" CausesValidation="False" CommandName="Update" OnClientClick="this.disable=true;"
                                    Text='<%# Eval("AnswerNegative") %>' onclick="LNKBADD_Click"></asp:LinkButton>

                            </ItemTemplate>
                            <ItemStyle Wrap="false" />
                            <HeaderStyle Width="0px" BackColor="DarkBlue" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventUpdateTypeID" HeaderText="CustEventUpdateTypeID"
                            SortExpression="CustEventUpdateTypeID" Visible="False" />
                        <asp:TemplateField ShowHeader="False" HeaderText="��� �����">
                            <ItemTemplate>
                               <asp:LinkButton ID="btnDel" runat="server" Text="���" Enabled='<%# NOT ISDBNull(Eval("CCEID"))  %>'
                                         CommandName="Delete"  
                                    OnClientClick="return confirm('��� ����?');" ></asp:LinkButton>
                                    <asp:HiddenField runat="server" ID="hdnOKK" Value='<%# Eval("RefStatusIND") + If(Eval("AnswerPositive")=eval("CustEventResult"),1,0) %>' />
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <HeaderStyle BackColor="DarkBlue" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
<%--               </ContentTemplate></asp:UpdatePanel>
--%>                 
                <asp:Button ID="btnCER" runat="server" Text="���� ������ ���� ������ ������ ������ ������"  Enabled="false" />
                <asp:HiddenField ID="hdncustname" runat="server" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSELECTEDCUST" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT CustomerID AS [�.�.], CustLastName + N' ' + CustFirstName AS ��, CustBirthDate AS [����� ����], Gender AS ���, CustomerAddress1 AS �����, CustomerAddress2 AS �����, CustomerCity AS ���, CustomerPhone AS ����� FROM vCustomerList WHERE (CustomerID = @CustomerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" PropertyName="SelectedValue"
                Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCustomers" runat="server" 
		ConnectionString="<%$ ConnectionStrings:bebook10 %>" CancelSelectOnNullParameter="False"
            SelectCommand="CANDTable" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            <asp:ControlParameter ControlID="CBALLCAND" Name="RejectedToo" 
                PropertyName="Checked" Type="Boolean" />
            <asp:ControlParameter ControlID="CBCORRECT" Name="ALLCust" 
                PropertyName="Checked" Type="Boolean" />
            <asp:Parameter Name="SFrameID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAMES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
		SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] ORDER BY [FrameName]">
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNEVENTGROUPID" runat="server" Value="2" />
    <asp:SqlDataSource ID="DSEVENTTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="pCandList" 
        DeleteCommand="DELETE FROM CustEventList WHERE (CustEventID = @CCEID)" 
        UpdateCommand="Cust_UPDEvent" UpdateCommandType="StoredProcedure" 
            SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" 
                PropertyName="SelectedValue" Type="Int64" />
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
            <asp:ControlParameter ControlID="DDLGROUPID" Name="EventGroupID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CCEID" Type="Int32" />
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
       	 <asp:Parameter Name="CustEventResult" Type="Int32" />
			<asp:Parameter Name="CustRelateID" Type="Int32" />
            <asp:Parameter Name="CCEID"  />
       </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNSERVICEID" runat="server" Value="3" />
    <asp:HiddenField ID="HDNMANAGER" runat="server" /> 

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
</div>     
</asp:Content>

