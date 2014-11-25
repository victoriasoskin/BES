<%@ Page Language="VB" MasterPageFile="~/Sherut.master"  AutoEventWireup="false" CodeFile="p2aBVAREP.aspx.vb" Inherits="BVAREP" title="Untitled Page" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSDates" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="SELECT DISTINCT DateB AS DL FROM p2v_bvarepw ORDER BY DateB" 
        CancelSelectOnNullParameter="False">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSREPDATA" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="p2p_BvARep" CancelSelectOnNullParameter="False" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLDates" Name="ReportDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DDLSHERUT" Name="SherutID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <table> 
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="תקציב מול בפועל" Width="170px"></asp:Label></td>
            <td align="left" style="width: 444px">
    <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl="~/p2a_sal4bva.aspx" 
                    Width="100px" Visible="False">נתוני שכר מפורטים</asp:LinkButton></td>
        </tr>
    </table>
    <table>
        <tr>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
            <td style="width: 100px; height: 18px">
                <asp:DropDownList ID="DDLDates" runat="server" DataSourceID="DSDates" 
                    DataTextField="DL" DataTextFormatString="{0:MMM-yy}" DataValueField="DL" 
                    AutoPostBack="True" AppendDataBoundItems="True" >
                    <asp:ListItem Value="">&lt;בחר תאריך&gt;</asp:ListItem>
    </asp:DropDownList></td>
            <td style="width: 100px; height: 18px">
                <asp:DropDownList ID="DDLSHERUT" runat="server" AppendDataBoundItems="True"
                    DataSourceID="DSSherut" DataTextField="Frame" DataValueField="CategoryID" AutoPostBack="True">
                    <asp:ListItem Value="" Text="&lt;בחר מסגרת&gt;"></asp:ListItem>
                </asp:DropDownList></td>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
            <td style="width: 100px; height: 18px">
                <asp:DropDownList ID="DDLYEAR" runat="server" AutoPostBack="True" EnableViewState="true">
                    <asp:ListItem>2008</asp:ListItem>
                    <asp:ListItem>2009</asp:ListItem>
                    <asp:ListItem>2010</asp:ListItem>
                    <asp:ListItem>2011</asp:ListItem>
                    <asp:ListItem>2012</asp:ListItem>
                    <asp:ListItem>2013</asp:ListItem>
                    <asp:ListItem>2014</asp:ListItem>
                    <asp:ListItem>2015</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
    </table>
    <table>
        <tr>
            <td colspan="4" style="height: 226px">
                <asp:GridView ID="GridView1" runat="server" DataSourceID="DSREPDATA" AutoGenerateColumns="False" CellPadding="4">
                    <Columns>
                        <asp:BoundField DataField="Budget" HeaderText="סעיף" SortExpression="Budget" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:HyperLinkField DataNavigateUrlFields="LinkSAP" DataTextField="SAP" DataTextFormatString="{0:#,###;(#,###)}"
                            HeaderText="תקופה מקבילה בפועל" >
                            <ItemStyle Wrap="False" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="SB" HeaderText="תקציב" SortExpression="SB" DataFormatString="{0:#,###;(#,###)}" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="בפועל">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# Eval("LinkSAO") %>'
                                    OnDisposed="HyperLink1_Disposed" OnUnload="HyperLink1_Unload" Text='<%# Eval("SAO", "{0:#,###;(#,###)}") %>'></asp:HyperLink>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                       <asp:HyperLinkField DataNavigateUrlFields="LinkSAA" DataTextFormatString="{0:#,##0;(#,##0)}" HeaderText="פ.נ." DataTextField="SAA">
                            <ItemStyle Wrap="False" />
                        </asp:HyperLinkField>
                        <asp:HyperLinkField DataNavigateUrlFields="LinkSA" DataTextField="SA" DataTextFormatString="{0:#,###;(#,###)}"
                            HeaderText="בפועל + פ.נ" >
                            <ItemStyle Wrap="False" />
                        </asp:HyperLinkField>
                        <asp:BoundField DataField="Diff" HeaderText="יתרה" SortExpression="Diff" DataFormatString="{0:#,###;(#,###)}" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Perc" HeaderText="% סטיה" SortExpression="Perc" DataFormatString="{0:###%}" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                &nbsp;</td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSherut" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        
        SelectCommand="SELECT DISTINCT p2v_bvarepw.Frame, p2v_bvarepw.FrameCategoryID AS CategoryID FROM dbo.p0v_UserFrameList RIGHT OUTER JOIN p0t_CoordFrameID ON dbo.p0v_UserFrameList.FrameID = p0t_CoordFrameID.SherutFrameID RIGHT OUTER JOIN p2v_bvarepw ON p0t_CoordFrameID.FinanceFrameID = p2v_bvarepw.FrameCategoryID WHERE (p2v_bvarepw.Frame IS NOT NULL) AND (topyca.p0v_UserFrameList.UserID = @UserID)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

