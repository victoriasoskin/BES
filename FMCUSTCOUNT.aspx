<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FMCUSTCOUNT.aspx.vb" Inherits="Default5" title="בית אקשטיין - יעד לקוחות" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="server">
    <table>
        <tr>
            <td colspan="2">
                <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="עמידה ביעד לקוחות" Width="364px"></asp:Label></td>
            <td style="width: 100px">
                &nbsp; &nbsp; &nbsp;
            </td>
        </tr> 
        <tr>
            <td style="width: 100px">
                <asp:DropDownList ID="DDLWY" runat="server" DataSourceID="DSWY" 
                    DataTextField="Workyear" DataValueField="WorkyearFirstDate" AutoPostBack="True" 
                    AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;בחר שנה&gt;</asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 100px" align="left">
                </td>
            <td style="width: 100px">
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
                <asp:GridView ID="GridView1" runat="server" DataSourceID="DSSvA" AutoGenerateColumns="False" CellPadding="4">
                    <FooterStyle Wrap="False" />
                    <RowStyle Wrap="False" />
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
            </asp:TemplateField>
                        <asp:TemplateField HeaderText="סוג">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("סוג") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="LBLTYPE" runat="server" Text='<%# Bind("סוג") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:label runat="server" id="LBLD1" Text='<%# hdrt(1) %>'/>             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS1" runat="server" Width="30px" Text='<%# vald(1) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD2" Text='<%# hdrt(2) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS2" runat="server" Width="30px" Text='<%# vald(2) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD3" Text='<%# hdrt(3) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS3" runat="server" Width="30px" Text='<%# vald(3) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD4" Text='<%# hdrt(4) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS4" runat="server" Width="30px" Text='<%# vald(4) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
              <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD5" Text='<%# hdrt(5) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS5" runat="server" Width="30px" Text='<%# vald(5) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD6" Text='<%# hdrt(6) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS6" runat="server" Width="30px" Text='<%# vald(6) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD7" Text='<%# hdrt(7) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS7" runat="server" Width="30px" Text='<%# vald(7) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD8" Text='<%# hdrt(8) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS8" runat="server" Width="30px" Text='<%# vald(8) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD9" Text='<%# hdrt(9) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS9" runat="server" Width="30px" Text='<%# vald(9) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD10" Text='<%# hdrt(10) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS10" runat="server" Width="30px" Text='<%# vald(10) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD11" Text='<%# hdrt(11) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS11" runat="server" Width="30px" Text='<%# vald(11) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat="server" id="LBLD12" Text='<%# hdrt(12) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLS12" runat="server" Width="30px" Text='<%# vald(12) %>' ></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>         
                        <asp:TemplateField HeaderText="הפרש מצטבר">
                            <ItemTemplate>
                                <asp:Label ID="LBLSUMDIFF" runat="server" OnPreRender="LBLSUMDIFF_PreRender" ForeColor="White" Width="35px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
</Columns>
                </asp:GridView>
                </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSWY" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT p0t_WorkYears.Workyear, p0t_WorkYears.WorkyearFirstDate FROM ServiceList LEFT OUTER JOIN p0t_WorkYears ON ServiceList.FirstMonthofWorkYear = DATEPART(month, p0t_WorkYears.WorkyearFirstDate) RIGHT OUTER JOIN FrameList ON ServiceList.ServiceID = FrameList.ServiceID WHERE (FrameList.FrameID = @FrameID)">
        <SelectParameters>
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSvA" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="p2p_CustCount" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLWY" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="LBLTODAY" Name="RepDate" PropertyName="Text" Type="DateTime" />
            <asp:SessionParameter DefaultValue="0" SessionField="ServiceID" Name="ServiceID" Type="Int32" />
            <asp:SessionParameter DefaultValue="" Name="FrameID" SessionField="FrameID" Type="Int32" />
            <asp:SessionParameter Name="UserID" SessionField="userid" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

