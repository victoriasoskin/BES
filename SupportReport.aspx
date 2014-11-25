<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SupportReport.aspx.vb" Inherits="Default2" title="אגף שירוץ - דוח תמיכות" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td align="left" colspan="3" style="width: 100px; height: 18px">
                <asp:DropDownList ID="DDLFRAME" runat="server" DataSourceID="DSFRAME" DataTextField="FrameName"
                    DataValueField="FrameID" AppendDataBoundItems="True" AutoPostBack="True" Visible="False">
                    <asp:ListItem>&lt;בחר מסגרת&gt;</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px; height: 18px;" colspan="3">
                <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#0000C0" 
                    Text="דוח תמיכות"></asp:Label>
                <asp:HiddenField ID="HDNFRAMEID" runat="server" />
            </td>
        </tr>
        <tr>
            <td style="width: 123px; height: 18px">
                <asp:Label ID="LBLFN" runat="server" Text="&lt;--&gt;" Width="201px"></asp:Label></td>
            <td style="width: 269px; height: 18px;" align="left">
                <asp:Label ID="Label6" runat="server" Text="נכון לתאריך: " Width="100px"></asp:Label></td>
            <td align="left" style="height: 18px">
                &nbsp;<asp:Label ID="LBLDT" runat="server" Text="Label"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 100px" colspan="3">
    <table border="1" >
        <tr>
            <td style="width: 100px; height: 18px;" align="center" bgcolor="#9999ff">
                <asp:Label ID="Label1" runat="server" Text="נושא" Width="34px"></asp:Label></td>
            <td style="width: 100px; height: 18px;" align="center" bgcolor="#9999ff">
                <asp:Label ID="Label3" runat="server" Text="ערך"></asp:Label></td>
            <td style="width: 51px; height: 18px;" align="center" bgcolor="#9999ff">
                <asp:Label ID="Label2" runat="server" Text="יעד (%)" Width="28px"></asp:Label></td>
            <td style="width: 51px; height: 18px;" align="center" bgcolor="#9999ff">
                <asp:Label ID="Label14" runat="server" Text="בפועל (%)"></asp:Label>
            </td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Label ID="Label4" runat="server" Text="מספר הלקוחות" Width="267px"></asp:Label></td>
            <td style="width: 100px" align="center" valign="top">
                <asp:DataList ID="DataList1" runat="server" DataSourceID="DSCUSTCOUNT">
                    <ItemTemplate>
                        <asp:Label ID="CUSTCNTLabel" runat="server" Text='<%# Eval("CUSTCNT") %>'></asp:Label>
                    </ItemTemplate>
                </asp:DataList></td>
            <td style="width: 51px" align="center" valign="top">
                &nbsp;</td>
            <td style="width: 51px" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Label ID="Label16" runat="server" Text="מספר הלקוחות הזכאים לתמיכות" Width="177px"></asp:Label></td>
            <td style="width: 100px" align="center" valign="top"><asp:DataList ID="DataList2" runat="server" DataSourceID="DSSUPPCUSTCNT">
                <ItemTemplate>
                    <asp:Label ID="SuppCntLabel" runat="server" Text='<%# Eval("SuppCnt") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
            <td style="width: 51px" align="center" valign="top">
                &nbsp;</td>
            <td style="width: 51px" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Label ID="Label5" runat="server" Text="מספר SIS בתוקף"></asp:Label></td>
            <td style="width: 100px" align="center" valign="top"><asp:DataList ID="DataList3" runat="server" DataSourceID="DSSIS">
                <ItemTemplate>
                    <asp:Label ID="SISCNTLabel" runat="server" Text='<%# Eval("SISCNT") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
            <td style="width: 51px" align="center" valign="top">
                &nbsp;</td>
            <td style="width: 51px" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td style="width: 100px" valign="top">
                <asp:Label ID="Label8" runat="server" Text="מספר שאלוני איכות חיים בתוקף" Width="195px"></asp:Label></td>
            <td style="width: 100px" align="center" valign="top"><asp:DataList ID="DataList4" runat="server" DataSourceID="DSQQ">
                <ItemTemplate>
                    <asp:Label ID="SISCNTLabel" runat="server" Text='<%# Eval("SISCNT") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
            <td style="width: 51px" align="center" valign="top">
                &nbsp;</td>
            <td style="width: 51px" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <asp:Label ID="Label10" runat="server" Text="מספר תוכניות תמיכה" Width="195px"></asp:Label></td>
            <td align="center" valign="top"><asp:DataList ID="DataList5" runat="server" DataSourceID="DSSP">
                <ItemTemplate>
                    <asp:Label ID="SISCNTLabel" runat="server" Text='<%# Eval("SISCNT") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
            <td align="center" valign="top"><asp:DataList ID="DataList6" runat="server" DataSourceID="DSSP">
                <ItemTemplate>
                    <asp:Label ID="SISCNTLabel" runat="server" Text='<%# Format(Eval("SuppTarget")/100,"#%") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
            <td valign="top"><asp:DataList ID="DataList7" runat="server" DataSourceID="DSSP">
                <ItemTemplate>
                    <asp:Label ID="SISCNTLabel" runat="server" Text='<%# Format(Eval("SISCNT")/Eval("SuppCnt"),"#%") %>'></asp:Label>
                </ItemTemplate>
            </asp:DataList></td>
        </tr>
    </table>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSCUSTCOUNT" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT CustFrameID, COUNT(CustomerID) AS CUSTCNT FROM vCustByFrame WHERE (CustFrameID = @Frameid) GROUP BY CustFrameID">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNFRAMEID" Name="Frameid" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSUPPCUSTCNT" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT COUNT(CustomerID) AS SuppCnt FROM vCustByFrame WHERE (CustFrameID = @FrameID) AND (SuppDate < GETDATE())">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNFRAMEID" Name="FrameID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSIS" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT COUNT(CustomerID) AS SISCNT FROM dbo.p0v_CustMaxD As p0v_CustMaxD WHERE (CustFrameID = @FrameID) AND (CustEventTypeID = 3) AND (dDate > GETDATE())">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNFRAMEID" Name="FrameID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSQQ" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT COUNT(CustomerID) AS SISCNT FROM dbo.p0v_CustMaxD As p0v_CustMaxD WHERE (CustFrameID = @FrameID) AND (CustEventTypeID = 4) AND (dDate > GETDATE())">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNFRAMEID" Name="FrameID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSP" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT COUNT(p0v_CustMaxD.CustomerID) AS SISCNT, ISNULL(FrameList.SuppTarget, 0) AS SuppTarget, p0v_CustSuppCNT.SuppCnt FROM dbo.p0v_CustSuppCNT As p0v_CustSuppCNT RIGHT OUTER JOIN dbo.p0v_CustMaxD As p0v_CustMaxD ON p0v_CustSuppCNT.CustFrameID = p0v_CustMaxD.CustFrameID LEFT OUTER JOIN FrameList ON p0v_CustMaxD.CustFrameID = FrameList.FrameID WHERE (p0v_CustMaxD.CustFrameID = @FrameID) AND (p0v_CustMaxD.CustEventTypeID = 5) GROUP BY FrameList.SuppTarget, p0v_CustSuppCNT.SuppCnt">
        <SelectParameters>
            <asp:ControlParameter ControlID="HDNFRAMEID" Name="FrameID" PropertyName="Value" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAME" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]"></asp:SqlDataSource>
</asp:Content>

