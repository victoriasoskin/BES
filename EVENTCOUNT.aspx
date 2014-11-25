<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="EVENTCOUNT.aspx.vb" Inherits="EVENTCOUNT" title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td style="width: 111px">
                <asp:Label ID="LBLHDR" runat="server" Width="150px" Font-Bold="True" Font-Size="Medium" ForeColor="#0033CC" Text="HDR"></asp:Label>
            </td>
            <td >
            </td>
            <td>
           </td>
            <td>
                  <asp:Label  runat="server" ID="LBLDT" text="כככ"></asp:Label>
          
            </td>
        </tr> 
        <tr>
       <td>
                  <asp:Label ID="LBLWY" text="" runat="server"></asp:Label>
       </td>
        <td>
        </td>
        <td>
        </td>
        <td>
        </td>
        </tr>
    </table>
    <asp:HiddenField ID="HDNWY" runat="server" />
    <asp:GridView ID="GridView1" runat="server" DataSourceID="DSEVENTS" 
        CellPadding="5" CellSpacing="4" style="margin-left: 0px">
        <FooterStyle Width="60px" Wrap="False" />
        <RowStyle Wrap="False" />
        <EmptyDataRowStyle Wrap="False" />
        <PagerStyle Wrap="False" />
        <HeaderStyle Wrap="False" Width="60px" />
        <Columns></Columns>
        <AlternatingRowStyle Wrap="False" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEVENTS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="p2p_EVENTCOUNT" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            <asp:controlParameter ControlID="HDNWY" Name="WorkYear" PropertyName="Value" 
                Type="String" />
            <asp:Parameter DefaultValue="2" Name="EventGroupID" Type="Int32" />
            <asp:Parameter DefaultValue="1" Name="WYType" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

