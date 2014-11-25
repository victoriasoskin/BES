<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustPaymentEvent.aspx.vb" Inherits="CustPaymentEvent" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="דיווח תשלומים" Width="151px"></asp:Label><table border="1">
        <tr>
            <td style="width: 100px; height: 19px; text-align: right">
                איך משתמשים?</td>
            <td style="width: 100px; text-align: right; height: 19px;">
                <strong>
                    <asp:Label ID="Label3" runat="server" Text="סינון פעולות" Width="79px"></asp:Label></strong></td>
        </tr>
        <tr>
            <td bgcolor="#ccffff" bordercolor="#0000ff" bordercolordark="#0000ff" style="width: 100px">
                <asp:Panel ID="Panel1" runat="server" Font-Overline="False" Font-Size="X-Small" Height="50px"
                    ScrollBars="Vertical" Width="160px">
                    סמן את השורות ששולמו ולחץ אישור.<br />
                    אפשר לטפל כל פעם במסך אחד.<br /> 
                    <br />
                    ביטול תשלומים שסומנו: לחץ "הצג גם תשלומים ששולמו", בטל סימונים של שורות שיש לבטל
                    את תשלומן&nbsp; והקש אישור</asp:Panel>
            </td>
            <td bgcolor="#ccffff" bordercolor="#0000ff" bordercolordark="#0000ff" style="width: 100px">
    <table>
        <tr>
            <td style="height: 24px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="bottom" bordercolor="#0000ff" bordercolordark="#0000ff" >
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID">
                    <asp:ListItem TEXT="&lt;בחר שירות&gt;" Value=""></asp:ListItem>
                </asp:DropDownList><br />
                <asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True"  AutoPostBack="True" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" EnableViewState="False">
                    <asp:ListItem Text="&lt;בחר מסגרת&gt;" Value=""></asp:ListItem>
                </asp:DropDownList></td>
            <td style="height: 24px; border-right: 1px solid; border-top: 1px solid; border-left: 1px solid; border-bottom: 1px solid;" valign="bottom" bordercolor="#0000ff" bordercolordark="#0000ff">
                <asp:Label ID="Label2" runat="server" Text="לקוח"></asp:Label><br />
                <asp:TextBox ID="TBCUSTOMER" runat="server" AutoPostBack="True" ToolTip=" הקלד רצף אותיות המופיע בשם הלקוח והקש Enter"
                    Width="83px"></asp:TextBox>
            </td>
            <td style="width: 3px; height: 24px" valign="bottom">
    <asp:DropDownList ID="DDLWORKYEAR" runat="server" DataSourceID="DSWorkYears" DataTextField="WorkYear"
        DataValueField="WorkYearFirstDate" AppendDataBoundItems="True" AutoPostBack="True">
        <asp:ListItem Value="">&lt;בחר שנת עבודה&gt;</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td style="width: 3px; height: 24px" valign="bottom">
                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="CustPaymentEvent.aspx"
                    Width="73px">נקה מסננים</asp:HyperLink>
                <asp:Button ID="Button1" runat="server" Text="סמן" />
            </td>
        </tr>
    </table>
            </td>
        </tr>
    </table> 
    <asp:GridView ID="GVList" runat="server" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="DSEvents"
        Font-Size="Small" ForeColor="#333333" PageSize="12" ShowFooter="True">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="מסגרת" SortExpression="מסגרת">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("מסגרת") %>'></asp:TextBox>
                </EditItemTemplate>
                <FooterTemplate>
                    סה&quot;כ משולמים
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBFRAME" runat="server" Text='<%# Bind("מסגרת") %>'></asp:Label>
                    <asp:HiddenField ID="HDNFRAMEID" runat="server" 
                        Value='<%# Eval("CustFrameID") %>' />
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="ת.ז." SortExpression="ת.ז.">
                <ItemTemplate>
                    <asp:Button ID="LNKBID" runat="server" Font-Size="X-Small" Height="17px" 
                        OnClick="LNKBID_Click" Text='<%# Eval("ת_ז") %>' 
                        Width="80px" OnClientClick='<%# OpenINOUT() %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="שם" SortExpression="CustomerName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustomerName") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLNAME" runat="server" Text='<%# Eval("שם") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                 <FooterTemplate>
                     <asp:Label ID="LBLF1" runat="server" Text='<%# valfooter(1) %>'></asp:Label>
                 </FooterTemplate>
                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD1" Text='<%# hdrt(1) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM1" onclick="LNKBM1_Click">הכל</asp:linkbutton>            
                </HeaderTemplate>
               <ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH1" runat="server" Value='<%# vali(1) %>'/>
                    <asp:CheckBox ID="CBMONTH1" runat="server"  BackColor='<%# valv(1) %>'  
                        checked='<%# -vald(1) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(1) %>" 
                        BorderWidth="1px"  />
                </ItemTemplate>
                 <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:label runat="server" id="LBLD2" Text='<%# hdrt(2) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM2" onclick="LNKBM1_Click">הכל</asp:linkbutton>             
                </HeaderTemplate>
            <ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH2" runat="server" Value='<%# vali(2) %>'/>
                    <asp:CheckBox ID="CBMONTH2" runat="server" BackColor='<%# valv(2) %>'  
                        checked='<%# vald(2) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(2) %>" 
                        BorderWidth="1px"  /> 
                </ItemTemplate>
                  <HeaderStyle Wrap="False" />
                                  <FooterTemplate>
                     <asp:Label ID="LBLF2" runat="server" Text='<%# valfooter(2) %>'></asp:Label>
                 </FooterTemplate>

           </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:label runat="server" id="LBLD3" Text='<%# hdrt(3) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM3" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH3" runat="server" Value='<%# vali(3) %>'/>
                    <asp:CheckBox ID="CBMONTH3" runat="server" BackColor='<%# valv(3) %>'  
                        checked='<%# vald(3) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(3) %>" 
                        BorderWidth="1px"  />
                </ItemTemplate>
                  <HeaderStyle Wrap="False" />
                                  <FooterTemplate>
                     <asp:Label ID="LBLF3" runat="server" Text='<%# valfooter(3) %>'></asp:Label>
                 </FooterTemplate>

           </asp:TemplateField>
            <asp:TemplateField>                
                             <HeaderTemplate>
                    <asp:label runat="server" id="LBLD4" Text='<%# hdrt(4) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM4" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH4" runat="server" Value='<%# vali(4) %>'/>
                    <asp:CheckBox ID="CBMONTH4" runat="server" BackColor='<%# valv(4) %>'  
                        checked='<%# vald(4) %>'  
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(4) %>" 
                        BorderWidth="1px"  />
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF4" runat="server" Text='<%# valfooter(4) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD5" Text='<%# hdrt(5) %>'/> <br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM5" onclick="LNKBM1_Click">הכל</asp:linkbutton>             
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH5" runat="server" Value='<%# vali(5) %>'/>
                    <asp:CheckBox ID="CBMONTH5" runat="server" BackColor='<%# valv(5) %>'  
                        checked='<%# vald(5) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(5) %>" 
                        BorderWidth="1px"  />
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF5" runat="server" Text='<%# valfooter(5) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD6" Text='<%# hdrt(6) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM6" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH6" runat="server" Value='<%# vali(6) %>'/>
                    <asp:CheckBox ID="CBMONTH6" runat="server" BackColor='<%# valv(6) %>'  
                        checked='<%# vald(6) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(6) %>" 
                        BorderWidth="1px"  />
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF6" runat="server" Text='<%# valfooter(6) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD7" Text='<%# hdrt(7) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM7" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH7" runat="server" Value='<%# vali(7) %>'/>
                    <asp:CheckBox ID="CBMONTH7" runat="server" BackColor='<%# valv(7) %>'  
                        checked='<%# vald(7) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(7) %>" 
                        BorderWidth="1px"  /> 
                                        </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF7" runat="server" Text='<%# valfooter(7) %>'></asp:Label>
                 </FooterTemplate>

                 <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD8" Text='<%# hdrt(8) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM8" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH8" runat="server" Value='<%# vali(8) %>'/>
                    <asp:CheckBox ID="CBMONTH8" runat="server" BackColor='<%# valv(8) %>'  
                        checked='<%# vald(8) %>'  
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(8) %>" 
                        BorderWidth="1px"  /> 
                                        </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF8" runat="server" Text='<%# valfooter(8) %>'></asp:Label>
                 </FooterTemplate>

                 <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD9" Text='<%# hdrt(9) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM9" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH9" runat="server" Value='<%# vali(9) %>'/>
                    <asp:CheckBox ID="CBMONTH9" runat="server" BackColor='<%# valv(9) %>'  
                        checked='<%# vald(9) %>'  
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(9) %>" 
                        BorderWidth="1px"  /> 
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF9" runat="server" Text='<%# valfooter(9) %>'></asp:Label>
                 </FooterTemplate>

                 <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD10" Text='<%# hdrt(10) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM10" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH10" runat="server" Value='<%# vali(10) %>'/>
                    <asp:CheckBox ID="CBMONTH10" runat="server" BackColor='<%# valv(10) %>'  
                        checked='<%# vald(10) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(10) %>" 
                        BorderWidth="1px"  /> 
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF10" runat="server" Text='<%# valfooter(10) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD11" Text='<%# hdrt(11) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM11" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH11" runat="server" Value='<%# vali(11) %>'/>
                    <asp:CheckBox ID="CBMONTH11" runat="server" BackColor='<%# valv(11) %>'  
                        checked='<%# vald(11) %>' 
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(11) %>" 
                        BorderWidth="1px"  /> 
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF11" runat="server" Text='<%# valfooter(11) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
            <asp:TemplateField>                                 <HeaderTemplate>
                    <asp:label runat="server" id="LBLD12" Text='<%# hdrt(12) %>'/><br />
                     <asp:linkbutton runat="server" 
                         OnClientClick="return confirm('האם לסמן תשלום לכל הלקוחות המוצגים בחודש זה?');" 
                         ID="LNKBM12" onclick="LNKBM1_Click">הכל</asp:linkbutton>              
                </HeaderTemplate>
<ItemTemplate>
                    <asp:HiddenField ID="HDNPMONTH12" runat="server" Value='<%# vali(12) %>'/>
                    <asp:CheckBox ID="CBMONTH12" runat="server" BackColor='<%# valv(12) %>'  
                        checked='<%# vald(12) %>'  
                        oncheckedchanged="CBMONTH1_CheckedChanged" BorderColor="<%# valfc(12) %>" 
                        BorderWidth="1px"  /> 
                </ItemTemplate>
                                <FooterTemplate>
                     <asp:Label ID="LBLF12" runat="server" Text='<%# valfooter(12) %>'></asp:Label>
                 </FooterTemplate>

                  <HeaderStyle Wrap="False" />
           </asp:TemplateField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" 
            Wrap="False" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEvents" runat="server"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" DeleteCommand="Delete From CustEventList Where CustEventID=@CustEventID"
        
        InsertCommand="INSERT INTO p0t_PaymentTable(CustomerID, FrameID, FrameManager, PaymentDate, Comment, Paid, UserID) VALUES (@CustomerID, @FrameID, @FrameManager, @PaymentDate, NULL, 1, @UserID)" SelectCommand="p0p_ShowPayments"
        
        
        UpdateCommand="Update CustEventList Set CustEventComment=@CustEventComment Where CustEventID=@CustEventID&#13;&#10;" 
        SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <DeleteParameters>
            <asp:Parameter Name="CustEventID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustEventComment" />
            <asp:Parameter Name="CustEventID" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter Name="ServiceID" SessionField="ServiceID" Type="Int32" DefaultValue="" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="CustServiceID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="CustFrameID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="TBCUSTOMER" DefaultValue=" " type="String" Name="Customer" PropertyName="Text" />
            <asp:ControlParameter ControlID="DDLWORKYEAR" Name="FirstDate" PropertyName="SelectedValue" Type="DateTime" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" />
            <asp:Parameter Name="FrameID" />
            <asp:Parameter Name="FrameManager" />
            <asp:Parameter Name="PaymentDate" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="int32"/>
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceID] = isnull(@ServiceID,ServiceID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource> 
   <asp:SqlDataSource ID="DSWorkYears" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [WorkYear], [WorkYearFirstDate] FROM [p0t_WorkYears]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
</asp:Content>
