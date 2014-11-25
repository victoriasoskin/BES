<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SRCUSTCOUNT.aspx.vb" Inherits="Default5" title="בית אקשטיין - יעד לקוחות" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td colspan="2">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="עמידה ביעד לקוחות" Width="368px"></asp:Label></td>
            <td style="width: 100px"> 
                &nbsp; &nbsp; &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DDLSERVICE" runat="server" DataSourceID="DSSERVICE" DataTextField="ServiceName"
                    DataValueField="ServiceID" AutoPostBack="True" AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
                </asp:DropDownList></td>
            <td align="right">
                <asp:DropDownList ID="DDLWY" runat="server" DataSourceID="DSWY" 
                    DataTextField="Workyear" DataValueField="WorkyearFirstDate" AutoPostBack="True" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;בחר שנה&gt;</asp:ListItem>
                </asp:DropDownList></td>
            <td>
                <table>
                    <tr>
                        <td style="width: 100px">
                <asp:Label ID="Label1" runat="server" Text="נכון לתאריך:" Width="80px"></asp:Label></td>
                        <td style="width: 100px">
                <asp:Label ID="LBLTODAY" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="height: 169px">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="DSSvA" AutoGenerateColumns="False" CellPadding="4" ShowFooter="True">
                    <FooterStyle Wrap="False" />
                    <RowStyle Wrap="False" BorderWidth="1px" />
                    <EmptyDataRowStyle Wrap="False" />
                    <SelectedRowStyle Wrap="False" />
                    <HeaderStyle Wrap="False" />
                    <Columns>
            <asp:TemplateField HeaderText="מסגרת">
                            <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />

                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("מסגרת") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLFRAME" runat="server" Text='<%# Bind("מסגרת") %>' OnPreRender="LBLFRAME_PreRender"></asp:Label>
                </ItemTemplate>
                <FooterTemplate>
                    סה"כ
                </FooterTemplate>
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="סוג">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("סוג") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LBLTYPE" runat="server" Text='<%# Bind("סוג") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <table>
                                    <tr>
                                        <td style="width: 100px">
                                            יעד</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px">
                                            בפועל</td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px">
                                            הפרש</td>
                                    </tr>
                                </table>
                            </FooterTemplate>
                        </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:label runat="server" id="LBLD1" Text='<%# hdrt(1) %>'/>             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS1" runat="server" Width="30px" Text='<%# vald(1,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST1" runat="server" Text='<%# GetTotal(1,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT1" runat="server" Text='<%# GetTotal(1,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT1" runat="server" Text='<%# GetTotal(1,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD2" Text='<%# hdrt(2) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS2" runat="server" Width="30px" Text='<%# vald(2,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST2" runat="server" Text='<%# GetTotal(2,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT2" runat="server" Text='<%# GetTotal(2,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT2" runat="server" Text='<%# GetTotal(2,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>

            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD3" Text='<%# hdrt(3) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS3" runat="server" Width="30px" Text='<%# vald(3,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST3" runat="server" Text='<%# GetTotal(3,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT3" runat="server" Text='<%# GetTotal(3,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT3" runat="server" Text='<%# GetTotal(3,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD4" Text='<%# hdrt(4) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS4" runat="server" Width="30px" Text='<%# vald(4,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST4" runat="server" Text='<%# GetTotal(4,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT4" runat="server" Text='<%# GetTotal(4,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT4" runat="server" Text='<%# GetTotal(4,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
              <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD5" Text='<%# hdrt(5) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS5" runat="server" Width="30px" Text='<%# vald(5,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST5" runat="server" Text='<%# GetTotal(5,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT5" runat="server" Text='<%# GetTotal(5,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT5" runat="server" Text='<%# GetTotal(5,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD6" Text='<%# hdrt(6) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS6" runat="server" Width="30px" Text='<%# vald(6,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST6" runat="server" Text='<%# GetTotal(6,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT6" runat="server" Text='<%# GetTotal(6,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT6" runat="server" Text='<%# GetTotal(6,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD7" Text='<%# hdrt(7) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS7" runat="server" Width="30px" Text='<%# vald(7,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST7" runat="server" Text='<%# GetTotal(7,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT7" runat="server" Text='<%# GetTotal(7,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT7" runat="server" Text='<%# GetTotal(7,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD8" Text='<%# hdrt(8) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS8" runat="server" Width="30px" Text='<%# vald(8,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                 <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST8" runat="server" Text='<%# GetTotal(8,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT8" runat="server" Text='<%# GetTotal(8,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT8" runat="server" Text='<%# GetTotal(8,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
           </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD9" Text='<%# hdrt(9) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS9" runat="server" Width="30px" Text='<%# vald(9,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST9" runat="server" Text='<%# GetTotal(9,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT9" runat="server" Text='<%# GetTotal(9,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT9" runat="server" Text='<%# GetTotal(9,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD10" Text='<%# hdrt(10) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS10" runat="server" Width="30px" Text='<%# vald(10,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST10" runat="server" Text='<%# GetTotal(10,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT10" runat="server" Text='<%# GetTotal(10,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT10" runat="server" Text='<%# GetTotal(10,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD11" Text='<%# hdrt(11) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS11" runat="server" Width="30px" Text='<%# vald(11,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                 <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST11" runat="server" Text='<%# GetTotal(11,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT11" runat="server" Text='<%# GetTotal(11,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT11" runat="server" Text='<%# GetTotal(11,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
           </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD12" Text='<%# hdrt(12) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS12" runat="server" Width="30px" Text='<%# vald(12,Eval("סוג")) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
                <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLST12" runat="server" Text='<%# GetTotal(12,"יעד") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="LBLAT12" runat="server" Text='<%# GetTotal(12,"בפועל") %>' ></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLDT12" runat="server" Text='<%# GetTotal(12,"הפרש") %>' ></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
            </asp:TemplateField>         
                        <asp:TemplateField HeaderText="הפרש מצטבר">
                            <ItemTemplate>
                                <asp:Label ID="LBLSUMDIFF" runat="server" OnPreRender="LBLSUMDIFF_PreRender" ForeColor="White" Width="35px"></asp:Label>
                            </ItemTemplate>
                            
                 <FooterTemplate>                    
                    <table>
                        <tr>
                            <td style="width: 100px">
                        </tr>
                        <tr>
                            <td style="width: 100px">
                        </tr>
                        <tr>
                            <td style="width: 100px; height: 18px">
                                <asp:Label ID="LBLSUMDIFFT" runat="server" OnPreRender="LBLSUMDIFFT_PreRender" ForeColor="White" Width="35px"></asp:Label></td>
                        </tr>
                    </table>
                </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                &nbsp;
                </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSWY" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT p0t_WorkYears.Workyear, p0t_WorkYears.WorkyearFirstDate FROM ServiceList LEFT OUTER JOIN p0t_WorkYears ON ServiceList.FirstMonthofWorkYear = DATEPART(month, p0t_WorkYears.WorkyearFirstDate) WHERE (ServiceList.ServiceID = @ServiceID)
">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICE" Name="ServiceID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSvA" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="p2p_CustCount" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLWY" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="LBLTODAY" Name="RepDate" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="DDLSERVICE" Name="ServiceID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="" Name="FrameID" Type="Int32" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSERVICE" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT distinct ServiceList.ServiceName, ServiceList.ServiceID FROM dbo.p0v_UserFrameList RIGHT OUTER JOIN FrameList ON dbo.p0v_UserFrameList.FrameID = FrameList.FrameID RIGHT OUTER JOIN ServiceList ON FrameList.ServiceID = ServiceList.ServiceID WHERE (dbo.p0v_UserFrameList.UserID = @USERID)">
        <SelectParameters>
            <asp:SessionParameter Name="USERID" SessionField="USERID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

