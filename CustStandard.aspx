<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustStandard.aspx.vb" Inherits="Default4" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="קליטת תקן לקוחות" Width="200px"></asp:Label></td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DSFrames" DataTextField="FrameName"
                    DataValueField="FrameID">
                </asp:DropDownList>
                <asp:DropDownList ID="DropDownList2" runat="server"> 
                    <asp:ListItem>1/9/2007</asp:ListItem>
                    <asp:ListItem>1/1/2008</asp:ListItem>
                    <asp:ListItem>1/9/2008</asp:ListItem>
                    <asp:ListItem>1/1/2009</asp:ListItem>
                    <asp:ListItem>1/9/2009</asp:ListItem>
                    <asp:ListItem>1/1/2010</asp:ListItem>
                    <asp:ListItem>1/9/2010</asp:ListItem>
                    <asp:ListItem>1/1/2011</asp:ListItem>
                    <asp:ListItem>1/9/2011</asp:ListItem>
                    <asp:ListItem>1/1/2012</asp:ListItem>
                    <asp:ListItem>1/9/2012</asp:ListItem>
                    <asp:ListItem>1/1/2013</asp:ListItem>
                    <asp:ListItem>1/9/2013</asp:ListItem>
                    <asp:ListItem>1/1/2014</asp:ListItem>
                    <asp:ListItem>1/9/2014</asp:ListItem>
                    <asp:ListItem>1/1/2015</asp:ListItem>
                    <asp:ListItem>1/9/2015</asp:ListItem>
                </asp:DropDownList></td>
        </tr>
        <tr>
            <td style="width: 100px">
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]"></asp:SqlDataSource>
</asp:Content>

