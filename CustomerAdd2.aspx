<%@ Page Language="VB" MasterPageFile="~/Sherut.master"  AutoEventWireup="false" CodeFile="CustomerAdd2.aspx.vb" Inherits="CustomerAdd2" title="��� ������� - ����� ����" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="LBLHDR" runat="server" Font-Size="Large" Text="����� ����" 
                    Width="536px"></asp:Label></td>
        </tr>
        <tr>
            <td valign="top" >
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="CustomerID" DataSourceID="DSCutomers"
                    DefaultMode="Insert">
                    <InsertItemTemplate> 
                       <table>
                           <tr>
                               <td bgcolor="#37a5ff" colspan="4" style="text-align: center" >
                                   <asp:label id="LBLHD1" runat="server" font-size="12pt" Text="���� �����" /></td>
                              
                               <td bgcolor="#37a5ff" colspan="2" style="text-align: center" >
                                   <span style="font-size: 12pt">���� ����������</span></td>
                                <td bgcolor="#37a5ff" colspan="4" style="text-align: center" >
                                   <span style="font-size: 12pt">���� ������</span></td>
                           </tr>
                            <tr>
                                <td bgcolor="#37a5ff" >
                                    <asp:Label ID="Label3" runat="server" Text="�.�. / �����"  ForeColor="Red" Width="68px"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="TBID" runat="server" Text='<%# Bind("CustomerID") %>' Width="80px" OnTextChanged="TBID_TextChanged" TabIndex="10" ToolTip="���� �� ����� �����"></asp:TextBox><asp:Button
                                        ID="BTNEXIST" runat="server" CausesValidation="False" Text="��� ����?" ValidationGroup="a" /></td>
                                <td style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RFVID" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="���� ����� ���� �.�." Width="247px"></asp:RequiredFieldValidator><asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="��' �.�. �� ����" MaximumValue="999999999999" MinimumValue="0"
                                        Type="Double" Width="213px"></asp:RangeValidator><asp:CustomValidator ID="CVID" runat="server" ControlToValidate="TBID" Display="Dynamic"
                                        ErrorMessage="�� �.�. �� ��� ���� ������" Width="287px"></asp:CustomValidator></td>
                                <td style="width: 100px">
                                    &nbsp;
                                </td>
                                <td bgcolor="#37a5ff" colspan="2">
                                    <asp:Button ID="BTNCOPYCUSTTOAPT" runat="server" CausesValidation="False" OnClick="BTNCOPYCUSTTOAPT_Click"
                                        Text="����� ����� ����� ������ ����������" Width="250px" ToolTip='����� �� ������ ������ ����� �����/����� ����� ���������� �� ����� �����: �����, ���, �����, �����, ����� ������,  ����"�.' />
                                    </td>
                                <td bgcolor="#37a5ff" colspan="2">
                                    <asp:Button ID="BTNCOPYAPTTOFAM" runat="server" CausesValidation="False" OnClick="BTNCOPYAPTTOFAM_Click"
                                        Text="����� ���� ���������� ����� ������" Width="250px" ToolTip='����� �� ������ ������ ����� ���������� ����� ������ �� ����� �����: ��, �����, ���, �����, ����� , ���,  ����� ������, ����"�.' /></td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px;color:Red; ">
                                    �� �����</td>
                                <td style="width: 197px">
                                    <asp:TextBox ID="TBLastName" runat="server" Text='<%# Bind("CustLastName") %>' Width="110px" TabIndex="20"></asp:TextBox></td>
                                <td style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TBLastName"
                                        Display="Dynamic" ErrorMessage="���� ����� �� �����" Width="225px"></asp:RequiredFieldValidator></td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 112px" bgcolor="#37a5ff" >
                                    ��</td>
                                    <td style="width: 39px">
                                    <asp:TextBox ID="TBAPTNAME" runat="server" Text='<%# Bind("CustApotroposName") %>'
                                        Width="160px" TabIndex="240"></asp:TextBox></td><td bgcolor="#37a5ff" style="width: 213px">
                                    ��</td>
                                <td>
                                    <asp:TextBox ID="TBFAMNAME" runat="server" Width="160px" Text='<%# Bind("CustFamilyName") %>' TabIndex="400"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px;color:Red; " >
                                    �� ����</td>
                                <td style="width: 197px; ">
                                    <asp:TextBox ID="TBFirstName" runat="server" OnTextChanged="TextBox1_TextChanged"
                                        Text='<%# Bind("CustFirstName") %>' Width="110px" TabIndex="30"></asp:TextBox></td>
                                <td >
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TBFirstName"
                                        Display="Dynamic" ErrorMessage="���� ����� �� ����" Width="234px"></asp:RequiredFieldValidator></td>
                                <td style="width: 100px; ">
                                </td>
                                <td style="width: 112px" bgcolor="#37a5ff" >
                                   ���</td>
                                <td style="width: 39px" >
                                    <asp:DropDownList ID="DDLAPTType" runat="server" DataSourceID="DSApotroposType"
                                        DataTextField="CustApotroposTypeName" DataValueField="CustApotroposTypeID" SelectedValue='<%# Bind("CustApotroposTypeID") %>' TabIndex="250">
                                    </asp:DropDownList></td>
                                <td bgcolor="#37a5ff" style="width: 213px">
                                    <asp:Label ID="Label4" runat="server" Width="69px"></asp:Label></td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px;color:Red;">
                                    ����� ����</td>
                                <td style="width: 197px" >
                                    <table>
                                        <tr>
                                            <td colspan="1">
                                    <asp:TextBox ID="TBBirthDate" runat="server" Text='<%# Bind("CustBirthDate", "{0:dd/MM/yyyy}") %>'
                                        Width="80px" TabIndex="40" ToolTip="���� �� ����� ����� ����� d/m/y ���� d - ���� ����� m = �����  y = ��� �����"></asp:TextBox></td>
                                            <td>
                                    <asp:RadioButtonList ID="RBLGENDER" runat="server" AppendDataBoundItems="True" RepeatDirection="Horizontal" SelectedValue='<%# Bind("CustGender") %>' TabIndex="50">
                                        <asp:ListItem Text="�" Value="1" Selected="True"></asp:ListItem>
                                        <asp:ListItem Text="�" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList></td>
                                        </tr>
                                    </table>
                                </td>
                                <TD style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" Enabled='<%# int(Session("ServiceID"))<>5 %>' ControlToValidate="TBBirthDate"
                                        Display="Dynamic" ErrorMessage="���� ����� ����� ����" Width="207px"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator4" runat="server"
                                            ControlToValidate="TBBirthDate" Display="Dynamic" ErrorMessage="����� ���� �� ����" MaximumValue="1/1/2021"
                                            MinimumValue="1/1/1911" Type="Date" Width="220px"></asp:RangeValidator>
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 112px">
                                    <strong>����� ����������</strong></td>
                                <td style="width: 213px">
                                    <asp:TextBox ID="TBAPTAD1" runat="server" Text='<%# Bind("CustApotroposAddress1") %>'
                                       Width="160px" TabIndex="260" OnTextChanged="TBAPTAD1_TextChanged"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 213px">
                                    <strong>����� ������</strong></td>
                                <td style="width: 213px">
                                    <asp:TextBox ID="TBFAMAD1" runat="server" Width="160px" Text='<%# Bind("CustFamilyAddress1") %>' TabIndex="410"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#0099cc" style=" width: 113px; border-right: gray thin dotted; border-top: gray thin dotted; height: 26px; color:Red" bordercolordark="#000099" >                                    
                                    <strong>���� ����</strong></td>
                                <td style="width: 197px; border-top: gray thin dotted; border-left: gray thin dotted; height: 26px;" bordercolordark="#000099">
                                    <asp:DropDownList ID="DDLORIGINOFFICE" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("CustOriginOfficeTypeID") %>' DataSourceID="DSOriginOffice" DataTextField="CustOriginOfficeTypeName" DataValueField="CustOriginOfficeTypeID" TabIndex="60" ToolTip="��� ����� ����� ���� ������" OnSelectedIndexChanged="DDLORIGINOFFICE_SelectedIndexChanged">
                                        <asp:ListItem text="[��� ���� ����]" Value=""></asp:ListItem>
                                    </asp:DropDownList>
									<asp:RequiredFieldValidator runat="server" ID="rfvgm" ControlToValidate="DDLORIGINOFFICE" Display="Dynamic" ErrorMessage="���� ����� ���� ����" />
                                </td>
                                <td style=" width: 290px; height: 26px;">
                                </td>
                                <td style="width: 100px; height: 26px;">
                                </td><td style="width: 39px; height: 26px;">
                                    <asp:TextBox ID="TBAPTAD2" runat="server" Text='<%# Bind("CustApotroposAddress2") %>'
                                       Width="160px" TabIndex="270"></asp:TextBox></td>
                                <td style="width: 213px; height: 26px;">
                                    <asp:TextBox ID="TBFAMAD2" runat="server" Width="160px" Text='<%# Bind("CustFamilyAddress2") %>' TabIndex="420"></asp:TextBox></td>
                            </tr>
                           <tr>
                               <td bgcolor="#0099cc" rowspan="1" style="width: 113px;  border-right: gray thin dotted; " bordercolordark="#000099">
                                   ���</td>
                               <td style="width: 197px;border-left: gray thin dotted;" bordercolordark="#000099">
                                   <asp:TextBox ID="TBORIGINOFFICECITY" runat="server" AutoPostBack="True" OnTextChanged="TBORIGINOFFICECITY_TextChanged"
                                       TabIndex="62" Text='<%# Bind("CustOriginOfficeCity") %>'></asp:TextBox></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px; ">
                               </td>
                                <td style=" width: 112px;" bgcolor="#37a5ff">
                                    ���</td>
                                    <td style="width: 39px; ">
                                        <asp:TextBox ID="TBAPTCITY" runat="server" TabIndex="280" Text='<%# Bind("CustApotroposCity") %>'></asp:TextBox></td>
                                <td bgcolor="#37a5ff" style="width: 213px; ">
                                    ���</td>
                                <td style="width: 213px; ">
                                    <asp:TextBox ID="TBFAMCITY" runat="server" TabIndex="430" Text='<%# Bind("CustFamilyCity") %>'></asp:TextBox></td>
                           </tr>
                           <tr>
                               <td bgcolor="#0099cc" rowspan="1" style="width: 113px; border-right: gray thin dotted; border-bottom: gray thin dotted;" bordercolordark="#000099">
                                   �� �����</td>
                               <td style="width: 197px; border-left: gray thin dotted; border-bottom: gray thin dotted;" bordercolordark="#000099">
                                   <asp:TextBox ID="TBORIGINNAME" runat="server" Width="160px" Text='<%# Bind("CustOriginOfficeName") %>' TabIndex="64" ToolTip="���� �� �� ����� �� ����� �����. ������, ����� ����� ��� ������ ������, ���� ��� ���� ������ ��� ����."></asp:TextBox></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px; ">
                               </td>
                               <td bgcolor="#37a5ff" style="width: 112px; ">
                                   �����</td>
                               <td style="width: 39px; ">
                                   <asp:TextBox ID="TBAPTZIP" runat="server" Width="70px" TabIndex="290" Text='<%# Bind("CustApotroposZipcode") %>'></asp:TextBox><asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="TBAPTZIP"
                                       Display="Dynamic" ErrorMessage="����� ���� ����� ���� �� 5 �����" Type="Integer" MaximumValue="99999" MinimumValue="10000" Width="179px"></asp:RangeValidator></td>
                               <td bgcolor="#37a5ff" style="width: 213px">
                                   �����</td>
                               <td style="width: 213px; ">
                                   <asp:TextBox ID="TBFAMZIP" runat="server" OnTextChanged="TextBox11_TextChanged"
                                       Width="70px" Text='<%# Bind("CustFamilyZioCode") %>' TabIndex="440"></asp:TextBox>
                                   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBFAMZIP"
                                       Display="Dynamic" ErrorMessage="����� ���� ����� ���� �� 5 �����" MaximumValue="99999"
                                       MinimumValue="10000" Type="Integer" Width="179px"></asp:RangeValidator></td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" rowspan="1" >
                                   ���� �����</td>
                               <td style="width: 197px; ">
                                   <asp:DropDownList ID="DDLMEDCARE" runat="server" AppendDataBoundItems="True" DataSourceID="DSMEDCARE" DataTextField="CustMedCareName" DataValueField="CustMedCareID" TabIndex="66" SelectedValue='<%# Bind("CustMedCareID") %>'>
                                       <asp:ListItem Value="">&lt;��� ���� �����&gt;</asp:ListItem>
                                   </asp:DropDownList></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px; ">
                               </td>
                               <td bgcolor="#37a5ff" style="width: 112px; ">
                                   �����</td>
                               <td style="width: 39px;">
                                   <asp:TextBox ID="TBAPTPHONE" runat="server" Text='<%# Bind("CustApotroposPhone") %>'
                                       Width="100px" TabIndex="300"></asp:TextBox></td>
                               <td bgcolor="#37a5ff" style="width: 213px; ">
                                   �����</td>
                               <td style="width: 213px; ">
                                   <asp:TextBox ID="TBFAMPHONE" runat="server" Width="100px" Text='<%# Bind("CustFamilyphone") %>' TabIndex="450"></asp:TextBox></td>
                           </tr>
                            <tr>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 113px">
                                    <asp:Label ID="LBLADDRESSHDR" runat="server" Font-Bold="true" >����� �����</asp:Label></td>
                                <td style="height: 26px" >
                                    <asp:TextBox ID="TBCUSTAD1" runat="server" TabIndex="70" Text='<%# Bind("CustomerAddress1") %>' Width="160px"></asp:TextBox></td>
                                <td style="height: 26px" >
                                </td>
                                <td style="height: 26px; width: 100px;" >
                                </td>
                               <td bgcolor="#37a5ff" style="width: 112px; height: 26px;">
                                   ���</td>
                               <td style="width: 39px; height: 26px;">
                                   <asp:TextBox ID="TBAPTFAX" runat="server" TabIndex="310" Text='<%# Bind("CustApotroposFax") %>'
                                       Width="100px"></asp:TextBox></td>
                               <td bgcolor="#37a5ff" style="width: 213px; height: 26px;">
                                   ���</td>
                               <td style="width: 213px; height: 26px;">
                                   <asp:TextBox ID="TBFAMFAX" runat="server" Width="100px" Text='<%# Bind("CustFamilyFax") %>' TabIndex="460"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="TBCUSTAD2" runat="server" TabIndex="80" Text='<%# Bind("CustomerAddress2") %>' Width="160px" OnTextChanged="TBAD2_TextChanged"></asp:TextBox></td>
                                <td>
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td bgcolor="#37a5ff" style="width: 112px">
                                    ����� ������</td>
                                    <td style="width: 39px" >
                                        <asp:TextBox ID="TBAPTCELL1" runat="server" TabIndex="320" Text='<%# Bind("CustApotroposCell1") %>'
                                            Width="100px"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" >
                                    ����� ������</td>
                                <td>
                                    <asp:TextBox ID="TBFAMCELL1" runat="server" Width="100px" Text='<%# Bind("CustFamilyCell1") %>' TabIndex="470"></asp:TextBox></td>
                            </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px; height: 25px;color:Red;">
                                   ���</td>
                               <td style="height: 25px">
                                   <asp:TextBox ID="TBCUSTCITY" runat="server" TabIndex="90" AutoCompleteType="Search" Text='<%# Bind("CustomerCity") %>'></asp:TextBox></td>
                               <td style="height: 25px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9"  Enabled='<%# int(Session("ServiceID"))<>5 %>' runat="server" ControlToValidate="TBCUSTCITY"
                                        Display="Dynamic" ErrorMessage="���� ����� ���" Width="93px"></asp:RequiredFieldValidator></td>
                               <td style="width: 100px; height: 25px;">
                               </td>
                                <td bgcolor="#37a5ff" style="width: 112px; height: 25px;">
                                    ����� ������</td>
                                    <td style="width: 39px; height: 25px;">
                                        <asp:TextBox ID="TBAPTCELL2" runat="server" TabIndex="330" Text='<%# Bind("CustApotroposCell2") %>'
                                            Width="100px"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" style="width: 213px; height: 25px;">
                                    ����� ������</td>
                                <td style="width: 213px; height: 25px;">
                                    <asp:TextBox ID="TBFAMCELL2" runat="server" Width="100px" Text='<%# Bind("CustFamilyCell2") %>' TabIndex="480"></asp:TextBox></td>
                           </tr>
                           <tr>
                               <td style="width: 113px; " bgcolor="#37a5ff">
                                   �����</td>
                               <td style="width: 197px; ">
                                    <asp:TextBox ID="TBCUSTZIP" runat="server" Width="57px" TabIndex="120" Text='<%# Bind("CustomerZipCode") %>'></asp:TextBox></td>
                               <td style="width: 290px; ">
                                   &nbsp;<asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="TBCUSTZIP"
                                        Display="Dynamic" ErrorMessage="����� ���� ����� ���� �� 5 �����" Type="Integer" MaximumValue="99999" MinimumValue="10000" Width="183px"></asp:RangeValidator></td>
                               <td style="width: 100px; "></td>
                               <td style="width: 112px; " bgcolor="#37a5ff">
                                   ���"�</td>
                                   <td style="width: 39px; ">
                                   <asp:TextBox ID="TBAPTEMAIL" runat="server" Text='<%# Bind("CustApotroposEmail") %>'
                                       Width="160px" TabIndex="340"></asp:TextBox>
                                       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TBAPTEMAIL"
                                           Display="Dynamic" ErrorMessage="����� ��-���� �� �����" SetFocusOnError="True"
                                           ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Width="160px"></asp:RegularExpressionValidator></td>
                               <td bgcolor="#37a5ff" style="width: 213px; ">
                                   ���"�</td>
                               <td style="width: 213px; ">
                                   <asp:TextBox ID="TBFAMEMAIL" runat="server" Width="160px" Text='<%# Bind("CustFamilyEmail") %>' TabIndex="490"></asp:TextBox>
                                   <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TBFAMEMAIL"
                                       Display="Dynamic" ErrorMessage="����� ��-���� �� �����" SetFocusOnError="True"
                                       ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px">
                                   �����</td>
                               <td style="width: 197px">
                                   <asp:TextBox ID="TBCUSTPHONE" runat="server" Text='<%# Bind("CustomerPhone") %>' Width="98px" TabIndex="130"></asp:TextBox></td>
                               <td style="width: 290px">
                                    </td>
                               <td style="width: 100px">
                               </td>
                               <td style="width: 112px" bgcolor="#37a5ff">
                               </td>
                               <td bgcolor="#37a5ff" colspan="3" style="width: 112px">
                                   ����� / ���� ����</td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px">
                                   ����� ������</td>
                               <td style="width: 197px">
                                   <asp:TextBox ID="TBCUSTCELL1" runat="server" Width="98px" Text='<%# Bind("CustomerCell1") %>' TabIndex="140"></asp:TextBox></td>
                               <td style="width: 290px">
                                   </td>
                               <td style="width: 100px">
                               </td>
                               <td style="width: 112px" bgcolor="#37a5ff">
                               </td>
                               <td colspan="3" rowspan="3" style="width: 112px">
                                   <asp:TextBox ID="TextBox1" runat="server" Height="68px" TabIndex="495" TextMode="MultiLine"
                                       Width="420px" Text='<%# Bind("CustAddInfo") %>'></asp:TextBox></td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px;">
                                   ����� ������</td>
                               <td style="width: 197px; ">
                                   <asp:TextBox ID="TBCUSTCELL2" runat="server" Width="98px" Text='<%# Bind("CustomerCell2") %>' TabIndex="150"></asp:TextBox></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px;">
                               </td>
                               <td style="width: 112px;" bgcolor="#37a5ff">
                               </td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="height: 18px">
                                   ���"�</td>
                               <td style="height: 18px">
                                   <asp:TextBox ID="TBCUSTEMAIL" runat="server" Width="160px" Text='<%# Bind("CustomerEmail") %>' TabIndex="160"></asp:TextBox><asp:RegularExpressionValidator
                                       ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBCUSTEMAIL"
                                       Display="Dynamic" ErrorMessage="����� ��-���� �� �����" SetFocusOnError="True"
                                       ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                               <td style="height: 18px">
                                   </td>
                               <td style="height: 18px">
                               </td>
                               <td style="height: 18px; width: 112px;" bgcolor="#37a5ff">
                                   <asp:Label ID="LBRowID" runat="server" Text='<%# Eval("RowID") %>' Visible="False"></asp:Label>
                                   <asp:Label ID="Label2" runat="server" Width="68px"></asp:Label></td>
                           </tr>
                        </table>
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="�����" TabIndex="500"></asp:LinkButton>&nbsp;&nbsp; &nbsp;
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="cancel"
                            Text="���� ������ ������" PostBackUrl="~/CustomerList.aspx" TabIndex="510"></asp:LinkButton>
                        &nbsp;&nbsp; &nbsp;<asp:LinkButton ID="LnkBADDNGO" runat="server" CommandName="Insert" Text="����� ����� ������ ���� ������" TabIndex="520" OnClick="LinkButton1_Click" ToolTip="����� ����� �� �����/����� ����� ������� ������ ������ ���� ������/������� ��� ��� ����� �����/����� �����"></asp:LinkButton>
                    </InsertItemTemplate>
                </asp:FormView>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSCutomers" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [CustomerList] WHERE [CustomerID] = @CustomerID" InsertCommand="Cust_AddCustomer"
        SelectCommand="SELECT * FROM [CustomerList] ORDER BY [CustLastName]" UpdateCommand="UPDATE [CustomerList] SET [CustFirstName] = @CustFirstName, [CustLastName] = @CustLastName, [CustBirthDate] = @CustBirthDate, [CustOriginOfficeID] = @CustOriginOfficeID, [CustApotropos1ID] = @CustApotropos1ID, [CustApotroposID2] = @CustApotroposID2, [CustGender] = @CustGender WHERE [CustomerID] = @CustomerID" InsertCommandType="StoredProcedure">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustOriginOfficeID" Type="Int32" />
            <asp:Parameter Name="CustApotropos1ID" Type="Int32" />
            <asp:Parameter Name="CustApotroposID2" Type="Int32" />
            <asp:Parameter Name="CustGender" Type="Int32" />
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustOriginOfficeTypeID" />
            <asp:Parameter Name="CustOriginOfficeCity" />
            <asp:Parameter Name="CustOriginOfficeName" />
            <asp:Parameter Name="CustomerAddress1" />
            <asp:Parameter Name="CustomerAddress2" />
            <asp:Parameter Name="CustomerCity" />
            <asp:Parameter Name="CustomerZipCode" />
            <asp:Parameter Name="CustomerPhone" />
            <asp:Parameter Name="CustomerFax" />
            <asp:Parameter Name="CustomerCell1" />
            <asp:Parameter Name="CustomerCell2" />
            <asp:Parameter Name="CustomerEmail" />
            <asp:Parameter Name="CustGender" Type="Int32" />
            <asp:Parameter Name="CustApotroposName" Type="String" />
            <asp:Parameter Name="CustApotroposTypeID" Type="Int32" />
            <asp:Parameter Name="CustApotroposAddress1" Type="String" />
            <asp:Parameter Name="CustApotroposAddress2" Type="String" />
            <asp:Parameter Name="CustApotroposCity" />
            <asp:Parameter Name="CustApotroposZipcode" />
            <asp:Parameter Name="CustApotroposPhone" Type="String" />
            <asp:Parameter Name="CustApotroposFax" />
            <asp:Parameter Name="CustApotroposCell1" />
            <asp:Parameter Name="CustApotroposCell2" />
            <asp:Parameter Name="CustApotroposEmail" />
            <asp:Parameter Name="CustFamilyName" />
            <asp:Parameter Name="CustFamilyAddress1" />
            <asp:Parameter Name="CustFamilyAddress2" />
            <asp:Parameter Name="CustFamilyCity" />
            <asp:Parameter Name="CustFamilyZioCode" />
            <asp:Parameter Name="CustFamilyphone" />
            <asp:Parameter Name="CustFamilyFax" />
            <asp:Parameter Name="CustFamilyCell1" />
            <asp:Parameter Name="CustFamilyCell2" />
            <asp:Parameter Name="CustFamilyEmail" />
            <asp:Parameter Name="CustMedCareID" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type=Int32/>
            <asp:Parameter Name="CustAddInfo" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSOriginOffice" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [CustOriginOfficeTypeName], [CustOriginOfficeTypeID] FROM [CustOriginOfficeTypes]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSApotroposType" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustApotroposTypeName], [CustApotroposTypeID] FROM [CustApotroposTypes]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSMEDCARE" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [CustMedCareName], [CustMedCareID] FROM [CustMedCare]"></asp:SqlDataSource>
</asp:Content>

