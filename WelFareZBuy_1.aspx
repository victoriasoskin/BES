<%@ Page Title="" Language="VB" MasterPageFile="~/Welfare.master" AutoEventWireup="false" CodeFile="WelFareZBuy_1.aspx.vb" Inherits="WelFareZBuy_1" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:ToolkitScriptManager runat="server">
    </asp:ToolkitScriptManager>
   <div style="text-align:center;" runat="server" id="divTBL">
           <table style="margin-right:auto;margin-left:auto;text-align:right;width:600px"">
                <tr>
                    <td>
                        <img alt="" src="WelfareDoc/belogo.png"  
                            style="float:right; height: 119px; width: 126px;" />
                        <img alt="" src="WelfareDoc/globus.png" 
                            style="float:left; height: 64px; width: 129px;" />
                     </td>
                </tr>
            </table>
            <table style="margin-right:auto;margin-left:auto;text-align:right;width:600px;border:1px solid #F17A2A;">
                <tr>
                    <td>
                        <asp:Label Width="600px" runat="server" ID="lblhdr" style="overflow:hidden;font-size:large;color:White;font-weight:bolder;background-color:#F17A2A;text-align:center;" Text="מבצע מהסרטים בשיתוף רשת GLOBUS MAX"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td><p style="font-size:medium;font-weight:bold;">
                        עובדי בית אקשטיין נהנים יותר!</P><p style="font-size:SMALL;">
ריכשו עכשיו מנוי  ל 8 סרטים ברשת בתי הקולנוע גלובוס מקס וגלובוס גרופ רק ב 216 ₪.<br />
 היכנסו לכתובת <a href="http://www.globusmax.co.il">http://www.globusmax.co.il</a> והתעדכנו ברשימת הסרטים ושעות ההצגה.<br />
 המנוי תקף לשנה וניתן לממש עד 4 כניסות ליום במנוי.<br />
תשלום דמי המנוי יתבצע דרך המשכורת באופן אוטומטי.</p>
                        <span style="float:right;font-size:small;"><a href="WelfareDoc/Cinemas.pdf" target="_blank">רשימת בתי הקולנוע</a></span>
 <span style="font-size:medium;font-weight:bold;float:left;"><br />צפייה מהנה!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>

                    </td>
                </tr>
               <tr>
                    <td style="text-align:center;">
                   
                          <asp:Label Width="600px" runat="server" ID="lblord" style="color:white;overflow:hidden;font-size:large;font-weight:bolder;background-color:#F17A2A;text-align:center;" >הזמנת כרטיסים</asp:Label>
                     </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lblText_HEADER" text="" />
  
                    </td>
                </tr>
                <tr>
                    
                    <td>
                    <div runat="server" style="text-align:center;width:100%;">
                        <table runat="server" id="tblfrm" style="text-align:right;background-color:#EEEEEE;font-size:small;width:100%">
                            <tr>
                                <td>
                                    שם פרטי&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbfname" Width="120" AutoCompleteType="None" TabIndex="10"/>
                                    <asp:RequiredFieldValidator runat="server" ID="rfvfname" ControlToValidate="tbfname" Display="Dynamic" ErrorMessage="חובה להקליד" ForeColor="Red" />
                                </td>
                                <td>
                                    שם משפחה&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tblname" Width="120" AutoCompleteType="None" TabIndex="20" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvlname" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד" ForeColor="Red"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    תעודת זהות&nbsp;<span style="color:Red;">*</span>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbid" Width="120" TabIndex="30" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvtb" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד" ForeColor="Red"/>
                                    <asp:RangeValidator runat="server" ID="rvid" ControlToValidate="tbid" Display="Dynamic" ErrorMessage="חובה להקליד" Type="Integer" MinimumValue="111111" MaximumValue="999999999" ForeColor="Red"/>
                                </td>
                                    <td>
                                    <asp:Label runat="server" ID="lblphone" >טלפון&nbsp;<span style="color:Red;">*</span></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbphone" Width="120" TabIndex="40" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfvphone" ControlToValidate="tbphone" Display="Dynamic" ErrorMessage="חובה להקליד" ForeColor="Red"/>
                                </td>
                            </tr>
                                <tr>
                                <td>
                                    <asp:Label runat="server" ID="lblfrm">שם מסגרת&nbsp;<span style="color:Red;">*</span></asp:Label>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox runat="server" ID="tbfrm" Width="120" TabIndex="50" />
                                    <asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbfrm" Display="Dynamic" ErrorMessage="חובה להקליד" ForeColor="Red"/>
                                </td>
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
                <td style="font-size:small;text-align:justify;border-top:1px solid #F17A2A;">כרטיס למימוש 8 כניסות לבתי הקולנוע של גלובוס מקס וגלובוס גרופ * יש להציג את הכרטיס בכל קניה * השימוש בכפוף לתקנון המבצע * אין כפל מבצעים והנחות * הכרטיס תקף לשנה מיום הנפקתו * ניתן לממש את הכרטיס בקופות הקולנוע בלבד * ניתן לממש עד 4 כרטיסים ליום * ניתן להזמין כרטיסים מהאינטרנט * הכרטיסים אינם תקפים לאולמות VIP * המנוי תקף לסרטי תלת מימד בתוספת  12 ש"ח בקופה * אובדן כרטיס יחויב בתשלם דמי טיפול * המנוי תקף לכל ימות השנה: חגים, חופשים ושבתות* טלח*

                    <asp:Label runat="server" ID="lblText_FOOTER" text="" />
                    <br /><br /><asp:CheckBox runat="server" ID="cbAgree" Text="אני מאשר/ת" OnPreRender="cbAgreerequired_Prerender" Font-Size="Medium" />
                </td>
            </tr>
        </table>
        <table style="margin-right:auto;margin-left:auto;text-align:right;width:600px"">

            <tr>
                <td align="center">
                    <asp:ImageButton runat="server" ID="btnord" Text="הזמן/הזמיני" 
                        ImageUrl="WelfareDoc/btnord.png" Height="35px" Width="123px" />
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

