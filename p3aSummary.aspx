<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p3aSummary.aspx.vb" Inherits="p3aSummary" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#0033CC" Text="דוח סיכום יציבות כלכלית (בבניה}" Width="239px"></asp:Label>
    <br />
    <table>
        <tr>
            <td style="width: 100px">
                <table>
                    <tr>
                        <td colspan="2">
                <asp:Label ID="LBLFRAMENAME" runat="server" Font-Bold="True" 
                    Font-Underline="True" ForeColor="#0033CC" Width="150px" Text=""></asp:Label>
                        </td>
                        <td style="width: 133px">
                <asp:HiddenField ID="HDNFrameID" runat="server" /> 
                        </td>
                        <td style="width: 133px">
                <asp:Label ID="LBLTODAY" runat="server" Text="Label"></asp:Label></td>
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
        DataSourceID="DSFrames" DataTextField="Frame" DataValueField="Frame" 
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
    </table>
    <br />
    <br />
    <table style="width: 100%" border="1" visible="false">
        <tr>
            <td>
                <asp:Label ID="Label4" runat="server" Text="עמידה ביעד לקוחות"></asp:Label>
            </td>
            <td style="width: 155px">
    <asp:SqlDataSource ID="DSSvA" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="p2p_CustCount" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLWY" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="LBLTODAY" Name="RepDate" PropertyName="Text" Type="DateTime" />
            <asp:Parameter DefaultValue="0" Name="ServiceID" Type="Int32" />
            <asp:SessionParameter DefaultValue="" Name="FrameID" SessionField="FrameID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="DSSvA">
                </asp:GridView>
                <br />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label5" runat="server" Text="עמידה בתקציב כח אדם" Width="163px"></asp:Label>
            </td>
            <td align="center" style="width: 155px" valign="middle">
    <asp:SqlDataSource ID="DSREP" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        
        
        SelectCommand="SELECT case when Sum(difft)&gt;=0 then '+' Else '-' End As sMP FROM p1t_MpRep WHERE (dateB = @dateB) AND (frame = isnull(@frame,@Framem)) AND (HREP = 1) " 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLTO" Name="dateB" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="DDLFRAME" Name="frame" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="LBLFRAMENAME" Name="Framem" 
                PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
                <asp:DataList ID="DSMP" runat="server" DataSourceID="DSREP" Font-Bold="True" 
                    Font-Size="Larger">
                    <ItemTemplate>
                        &nbsp;<asp:Label ID="sMPLabel" runat="server" Text='<%# Eval("sMP") %>' />
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="Label6" runat="server" Text="עמידה בתקציב הוצאות שוטפות והשקעות" 
                    Width="235px"></asp:Label>
            </td>
            <td style="width: 155px">
                &nbsp;</td>
        </tr>
        </table>
    <br />
    <br />
    <table>
        <tr>
            <td style="width: 100px; height: 18px">
                &nbsp;</td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        SelectCommand="SELECT [שירות_-_1] AS Service FROM [SHERUT_besqxl] WHERE ([שירות_-_1] IS NOT NULL) Group by [שירות_-_1]  ORDER BY max([סדר_שורות_שירות])">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        
        
        SelectCommand="SELECT ISNULL([שירות_-_3], [שירות_-_2]) AS Frame, CategoryID, IsParent FROM SHERUT_besqxl WHERE (ISNULL([שירות_-_3], [שירות_-_2]) IS NOT NULL) AND (IsParent IS NULL) And [שירות_-_1] = isnull(@Service,[שירות_-_1] ) ORDER BY סדר_שורות_שירות">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICES" Name="Service" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSWY" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT [Workyear], [WorkyearFirstDate] FROM [p0t_WorkYears]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSDates" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [DL] FROM [P0V_yearMonths] WHERE ([WorkyearFirstDate] = @WorkyearFirstDate)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLWY" Name="WorkyearFirstDate" 
                PropertyName="SelectedValue" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

