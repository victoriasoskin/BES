<%@ Page Title="" Language="VB" MasterPageFile="~/Welfare.master" AutoEventWireup="false" CodeFile="WelFareBuy.aspx.vb" Inherits="WelFareBuy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
    <table>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblfname" Text="שם פרטי" /> 
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbfname" Width="120" AutoCompleteType="None" />
                <asp:RequiredFieldValidator runat="server" ID="rfvfname" ControlToValidate="tbfname" Display="Dynamic" ErrorMessage="חובה להקליד שם פרטי" ForeColor="Red" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lbllname" Text="שם משפחה" />
            </td>
            <td>
                <asp:TextBox runat="server" ID="tblname" Width="120" AutoCompleteType="None"  />
                <asp:RequiredFieldValidator runat="server" ID="rfvlname" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד שם משפחה" ForeColor="Red"/>
            </td>
        </tr>
       <tr>
            <td>
                <asp:Label runat="server" ID="lblid" Text="תעודת זהות" AutoCompleteType="None" />
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbid" Width="120" />
                <asp:RequiredFieldValidator runat="server" ID="rfvtb" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" ForeColor="Red"/>
                <asp:RangeValidator runat="server" ID="rvid" ControlToValidate="tbid" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" Type="Integer" MinimumValue="111111" MaximumValue="999999999" ForeColor="Red"/>
            </td>
        </tr>
       <tr>
            <td>
                <asp:Label runat="server" ID="lblfrm" Text="שם המסגרת" AutoCompleteType="None" />
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbfrm" Width="120" />
                <asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbfrm" Display="Dynamic" ErrorMessage="חובה להקליד שם מסגרת" ForeColor="Red"/>
            </td>
        </tr>
      <tr>
            <td>
                <asp:Label runat="server" ID="lblphone" Text="טלפון" AutoCompleteType="Disabled"  />
            </td>
            <td>
                <asp:TextBox runat="server" ID="tbphone" Width="120" />
                <asp:RequiredFieldValidator runat="server" ID="rfvphone" ControlToValidate="tbphone" Display="Dynamic" ErrorMessage="חובה להקליד מספר טלפון" ForeColor="Red"/>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button runat="server" ID="btnord" Text="להזמנת תווי קניה" Width="100%" />
                <asp:Label runat="server" ID="lblerrenter" Text="בעיה בפרטים המזהים. בדוק את תעודת הזהות" ForeColor="Red" Visible="false"/>
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
            <table runat="server" style="">
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
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" style="">
                            <tr runat="server" style="background-color:Silver">
                                <th runat="server">
                                    תאריך ההזמנה</th>
                                <th runat="server">
                                    סכום ההזמנה</th>
                                <th runat="server">
                                    סכום לתשלום</th>
                                <th runat="server"></th>
                            </tr>
                            <tr runat="server" ID="itemPlaceholder">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
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

