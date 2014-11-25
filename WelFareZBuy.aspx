<%@ Page Title="" Language="VB" MasterPageFile="~/Welfare.master" AutoEventWireup="false" CodeFile="WelFareZBuy.aspx.vb" Inherits="WelFareZBuy" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align:center;" runat="server" id="divTBL">
           <table style="margin-right:auto;margin-left:auto;empty-cells:show;text-align:right;width:600px;">
               <tr>
                    <td>
                        <asp:Label runat="server" ID="lblText_HEADER" text="החלק העליון של הדף" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <div style="background-color:#EEEEEE;"> 
                        <table style="font-size:small;">
                            <tr>
                                <td>
                                    שם פרטי&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbfname" Width="120" AutoCompleteType="None" TabIndex="10"/>
                                    <asp:RequiredFieldValidator runat="server" ID="rfvfname" ControlToValidate="tbfname" Display="Dynamic" ErrorMessage="חובה להקליד שם פרטי" ForeColor="Red" />
                                </td>
                                <td>
                                    שם משפחה&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tblname" Width="120" AutoCompleteType="None" TabIndex="20" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvlname" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד שם משפחה" ForeColor="Red"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    תעודת זהות&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbid" Width="120" TabIndex="30" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvtb" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" ForeColor="Red"/>
                                    <asp:RangeValidator runat="server" ID="rvid" ControlToValidate="tbid" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" Type="Integer" MinimumValue="111111" MaximumValue="999999999" ForeColor="Red"/>
                                </td>
                                    <td>
                                    <asp:Label runat="server" ID="lblphone" Text="טלפון" AutoCompleteType="Disabled"  />
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbphone" Width="120" TabIndex="40" />
    <%--                                <asp:RequiredFieldValidator runat="server" ID="rfvphone" ControlToValidate="tbphone" Display="Dynamic" ErrorMessage="חובה להקליד מספר טלפון" ForeColor="Red"/>
    --%>                            </td>
                            </tr>
                                <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblfrm" Text="שם המסגרת" AutoCompleteType="None" />
                                </td>
                                <td colspan="3">
                                    <asp:TextBox runat="server" ID="tbfrm" Width="120" TabIndex="50" />
    <%--                                <asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbfrm" Display="Dynamic" ErrorMessage="חובה להקליד שם מסגרת" ForeColor="Red"/>
    --%>                            </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblemail" Text="דואר אלקטרוני" AutoCompleteType="Disabled"  />
                                </td>
                                <td colspan="3">
                                    <span style="text-align:left;direction:ltr;"><asp:TextBox runat="server" ID="tbemail1" Width="100" TabIndex="70"/></span>@<asp:TextBox runat="server" ID="tbemail2" Width="70" TabIndex="60" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label runat="server" ID="lblText_FOOTER" text="החלק התחתון של הדף" />
                 </td>
            </tr>
            <tr>
                <td>
                    <asp:CheckBox runat="server" ID="cbAgree" Text="אני מאשר/ת" OnPreRender="cbAgreerequired_Prerender" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Button runat="server" ID="btnord" Text="הזמן/הזמיני"  />
                </td>
            </tr>
      </table>
  </div>
<div runat="server" id="divOrders" visible="false">
    <asp:RadioButtonList ID="rblOps" runat="server" DataSourceID="dsOPS" 
        DataTextField="OPName" DataValueField="OpID" BackColor="Blue" ForeColor="Wheat">
    </asp:RadioButtonList>
    <asp:SqlDataSource ID="dsOrders" runat="server"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT ID,OrderDate, S, (1-discount) * S AS sD FROM WelFareTrans WHERE (EmployeeID = @EmployeeID) AND (OpID = @OpID) And (Status=0)" 
        DeleteCommand="Update WelFareTrans set Status=1 Where ID=@ID" 
        InsertCommand="insertWelf" InsertCommandType="StoredProcedure" >
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:ControlParameter Name="EmployeeID" ControlID="tbid" PropertyName="Text" Type="Int32"/>
            <asp:ControlParameter Name="FirstName" ControlID="tbfname" PropertyName="Text" Type="String" />
            <asp:ControlParameter Name="LastName" ControlID="tblname" PropertyName="Text" Type="String" />
            <asp:ControlParameter Name="FrameName" ControlID="tbfrm" PropertyName="Text" Type="String" />
            <asp:ControlParameter Name="Phone" ControlID="tbphone" PropertyName="Text" Type="String"  />
            <asp:ControlParameter Name="OpID" ControlID="rblOps" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="S" Type="Decimal" />
            <asp:SessionParameter Name="discount" Type="Decimal" SessionField="Wel_Discount" />
            <asp:SessionParameter Name="MatchLevel" Type="Int32" SessionField="MatchLevel" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="tbid" Name="EmployeeID" PropertyName="Text" 
                Type="Int32" />
            <asp:ControlParameter ControlID="rblOps" Name="OpID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:ListView ID="lvorders" runat="server" DataSourceID="dsOrders" 
        EnableModelValidation="True" DataKeyNames="ID" InsertItemPosition="LastItem">
       <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="Update" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Cancel" />
                </td>
                <td>
                    <asp:TextBox ID="OrderDateTextBox" runat="server" 
                        Text='<%# Bind("OrderDate") %>' />
                </td>
                <td>
                    <asp:TextBox ID="STextBox" runat="server" Text='<%# Bind("S") %>' />
                </td>
                <td>
                    <asp:TextBox ID="sDTextBox" runat="server" 
                        Text='<%# Bind("sD") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table id="Table1" runat="server" style="">
                <tr>
                    <td>
                        אין הזמנות</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="background-color:#EEEEEE">
                 <td>
                    <asp:Label ID="OrderDateTextBox" runat="server"  OnPreRender ="OrderDateTextBox_PreRender"/>
                </td>
                <td>
                    <asp:TextBox ID="STextBox" runat="server" Text='<%# Bind("S") %>' OnTextChanged="STextBox_TextChanged" AutoPostBack="true" OnPreRender="STextBox_PreRender" Width="80" />
                    <asp:RequiredFieldValidator runat="server" ID="rfvs" Display="Dynamic" ErrorMessage="חובה להקליד סכום הזמנה" ForeColor="Red" ControlToValidate="STextBox" />
                    <asp:RangeValidator runat="server" ID="rvs" Display="Dynamic" Type="Double" MinimumValue='<%# Viewstate("minS") %>' MaximumValue='<%# Viewstate("maxS") %>' ControlToValidate="STextBox"  ErrorMessage='<%# "סכום ההזמנה המותר הוא בין " &  Format(Viewstate("minS"),"#,###")  & " לבין " & Format(Viewstate("maxS"),"#,###") & " שקל" %>' ForeColor="Red"/>
                </td>
                <td>
                    <asp:Label ID="sDLabel" runat="server" 
                        Text='<%# Format(Eval("S") * (1-Eval("discount")),"#,###.00") %>' />
                </td>
               <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="חישוב הסכום לתשלום" OnClick="InsertButton_Click" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="ביטול" CausesValidation="false" />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color:#EEEEEE">
              <td>
                    <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate","{0:dd/MM/yyyy}") %>' />
                </td>
                <td>
                    <asp:Label ID="SLabel" runat="server" Text='<%# Eval("S","{0:#,###.00}") %>' />
                </td>
                <td>
                    <asp:Label ID="sDLabel" runat="server" Text='<%# Eval("sD","{0:#,###.00}") %>' />
                </td>
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Delete" OnClientClick="return confirm('האם למחוק את ההזמנה?')"
                        Text="מחק" />
                </td>
             </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table id="Table2" runat="server">
                <tr id="Tr1" runat="server">
                    <td id="Td1" runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" style="">
                            <tr id="Tr2" runat="server" style="background-color:Silver">
                                <th id="Th1" runat="server">
                                    תאריך ההזמנה</th>
                                <th id="Th2" runat="server">
                                    סכום ההזמנה</th>
                                <th id="Th3" runat="server">
                                    סכום לתשלום</th>
                                <th id="Th4" runat="server"></th>
                            </tr>
                            <tr runat="server" ID="itemPlaceholder">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="Tr3" runat="server">
                    <td id="Td2" runat="server" style="">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
     </asp:ListView>
    <asp:Button ID="btnOK" runat="server" Text="יציאה" Width="277px" 
         CausesValidation="false"/>
    <asp:SqlDataSource ID="dsOPS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [OpID], [OPName] FROM [WelFareOPS] WHERE ([Active] = 1)">
    </asp:SqlDataSource>
</div>
</asp:Content>

