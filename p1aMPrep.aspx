<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="p1aMPrep.aspx.vb" Inherits="Default6" title="אגף כספים - תקן כח אדם" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSREP" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        
        
        SelectCommand="SELECT Subject, Mhours, tarif, Q, QA, diffM, QT, QAT, difft, HREP, LinkX, LinkD FROM p1t_MpRep WHERE (dateB = @dateB) AND (HREP = 1) AND (FrameCategoryID = ISNULL(@frameID, @FramemID)) ORDER BY Ord" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTO" Name="dateB" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DDLFRAME" Name="frameID" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="HDNFrameID" Name="FramemID" 
                PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource> 
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="LBLHDR" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#0000C0"
                    Text="עמידה בתקציב כח אדם" Width="238px" Height="19px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100px">
                <table>
                    <tr>
                        <td colspan="2">
                <asp:Label ID="LBLFRAMENAME" runat="server" Font-Bold="True" 
                    Font-Underline="True" ForeColor="#0033CC" Width="150px" Text=""></asp:Label>
                        </td>
                        <td style="width: 133px">
                            <asp:HiddenField ID="HDNServiceID" runat="server" />
                <asp:HiddenField ID="HDNFrameID" runat="server" />
                        </td>
                        <td style="width: 133px">
                            &nbsp;</td>
                        <td style="width: 133px">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" 
                    AutoPostBack="True" DataSourceID="DSSERVICES" DataTextField="Service" 
                    DataValueField="Service">
                    <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
                </asp:DropDownList>
                        </td>
                        <td style="width: 100px">
    <asp:DropDownList ID="DDLFRAME" runat="server" AutoPostBack="True" 
        DataSourceID="DSFrames" DataTextField="Frame" DataValueField="CategoryID" 
                    AppendDataBoundItems="True" EnableViewState="False">
        <asp:ListItem Value="">&lt;בחר מסגרת&gt;</asp:ListItem>
    </asp:DropDownList>
                        </td>
                        <td style="width: 133px">
                            <asp:DropDownList ID="DDLWY" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="DSWY" DataTextField="Workyear" 
                                DataValueField="WorkyearFirstDate" DataTextFormatString="{0:MMM-yy}" 
                                EnableViewState="False">
                                <asp:ListItem Value="">&lt;בחר שנת עבודה&gt;</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="width: 133px">
                            <asp:DropDownList ID="DDLTO" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                DataSourceID="DSDates" DataTextField="DL" DataValueField="DL" DataTextFormatString="{0:MMM-yy}" EnableViewState="False">
                                <asp:ListItem Value="">&lt;בחר תאריך&gt;</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="width: 133px">
                            &nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="DSREP" CellPadding="4" ShowFooter="True" 
                    BorderColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px">
                    <RowStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="2px" />
                    <Columns>
                        <asp:BoundField DataField="Subject" HeaderText="תפקיד" SortExpression="Subject">
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Mhours" DataFormatString="{0:#,###}" 
                            HeaderText="שעות חודשיות" SortExpression="Mhours" >
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                        </asp:BoundField>
                        <asp:TemplateField>
                            <ControlStyle BackColor="#CCCCCC" />
                            <ItemStyle BackColor="#CCFFFF" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="תקציב החודש" SortExpression="Q">
                               <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# sVal("Q", "#,###",0) %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###",0) %>'></asp:Label>
                            </FooterTemplate>
                            <FooterStyle Wrap="false" />
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="בפועל החודש" SortExpression="QA">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" 
                                    NavigateUrl='<%# Eval("LinkD") %>' Text='<%# sVal("QA", "#,###",1) %>'></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###",1) %>'></asp:Label>
                            </FooterTemplate>
                             <FooterStyle Wrap="false" />
                             <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                      </asp:TemplateField>
                        <asp:TemplateField HeaderText="הפרש החודש" SortExpression="diffM">
                             <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" 
                                     Text='<%# sVal("diffM", "#,###;#,###-",2) %>' 
                                     ForeColor='<%# fColor("diffM") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###;#,###-",2) %>' ForeColor='<%# tColor(2) %>'></asp:Label>
                            </FooterTemplate>
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                            <FooterStyle Wrap="false" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ControlStyle BackColor="#CCCCCC" />
                            <ItemStyle BackColor="#CCFFFF" />
                       </asp:TemplateField>
                        <asp:TemplateField HeaderText="תקציב מצטבר" SortExpression="S">
                             <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# sVal("QT", "#,###;#,###-",4) %>'></asp:Label>
                            </ItemTemplate>
                             <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###;#,###-",4) %>'></asp:Label>
                            </FooterTemplate>
                           <ItemStyle Wrap="False" />
                            <FooterStyle Wrap="false" />
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="בפועל מצטבר" SortExpression="SA">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink2" runat="server" 
                                    NavigateUrl='<%# Eval("LinkX") %>' Text='<%# sVal("QAT", "#,###;#,###-",5) %>'></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                             <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###;#,###-",5) %>'></asp:Label>
                            </FooterTemplate>
                             <FooterStyle Wrap="false" />
                             <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                      </asp:TemplateField>
                        <asp:TemplateField HeaderText="הפרש מצטבר" SortExpression="diffms">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" 
                                    Text='<%# sVal("difft", "#,###;#,###-",6) %>'   ForeColor='<%# fColor("difft") %>'
                                    ></asp:Label>
                            </ItemTemplate>
                             <FooterTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# sTot("#,###;#,###-",6) %>'  ForeColor='<%# tColor(6) %>'></asp:Label>
                            </FooterTemplate>
                            <ItemStyle Wrap="False" BorderColor="#EEEEEE" BorderStyle="Double" 
                                borderWidth="5px" />
                            <FooterStyle Wrap="false" />
                        </asp:TemplateField>
                    </Columns>
                  
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        
        
        
        SelectCommand="SELECT distinct [שירות_-_1] AS Service, CategoryID FROM p4v_ServiceList WHERE (UserID = @uSERid)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="uSERid" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        
        
        
        
        SelectCommand="SELECT Frame, CategoryID, Service, UserID FROM p4v_FrameList WHERE (Service = @Service) AND (UserID = @UserID)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="Service" 
                PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSWY" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT [Workyear], [WorkyearFirstDate] FROM [p0t_WorkYears]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSDates" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [DL] FROM [P0V_yearMonths] WHERE ([WorkyearFirstDate] = @WorkyearFirstDate)
">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLWY" Name="WorkyearFirstDate" 
                PropertyName="SelectedValue" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

