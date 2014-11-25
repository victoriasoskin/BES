<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CandReport.aspx.vb" Inherits="CandReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <br />
    <table >
        <tr>
            <td colspan="2" style="height: 23px">
                <asp:Label ID="LBLHDR" runat="server" Font-Bold="True" Font-Size="Medium" 
                    ForeColor="#0033CC" Text="דוח מצב מועמדים לחינוך" Width="170px"></asp:Label>
            </td>
            <td style="height: 23px" colspan="2">
               </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="LBLFRAME" runat="server" Text="Label" Visible="False"  
                    Width="250px"></asp:Label></td>
            <td>
               &nbsp;</td>
            <td colspan="2" align="left">
                  <asp:Label ID="LBLDate" runat="server" Width="98px" ></asp:Label>
               </td>
        </tr>
        <tr>
            <td colspan="2">
               <asp:DropDownList ID="DDLSERVICE" runat="server" DataSourceID="DSServices" 
                    DataTextField="ServiceName" DataValueField="ServiceID" 
                    AppendDataBoundItems="True" AutoPostBack="True">
                   <asp:ListItem Value="">&lt;כל האזורים&gt;</asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="DSPIVOT" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    SelectCommand="RepCallPivot" SelectCommandType="StoredProcedure" 
                    CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
                        <asp:ControlParameter ControlID="HDNWYEAR" Name="WYear" PropertyName="Value" 
                            Type="DateTime" />
                        <asp:Parameter DefaultValue="2" Name="CustEventGroupID" Type="Int32" />
                        <asp:Parameter Name="CityID" Type="Int32" />
                        <asp:ControlParameter ControlID="DDLSERVICE" 
                            Name="RegionID" PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="RBLROWFIELDS" Name="RowFields" 
                            PropertyName="SelectedValue" Type="String" />
                        <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DSServices" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    SelectCommand="SELECT distinct s.ServiceName, s.ServiceID
				FROM ServiceList s Left outer join Framelist f on f.serviceID=s.serviceID
				LEFT OUTER JOIN dbo.p0v_UserFrameList u ON f.FrameID = u.FrameID
				WHere UserID=@UserID And s.ServiceID not in (8,12)" >
                    <SelectParameters>
                        <asp:SessionParameter Name="UserID" SessionField="UserID" />
                    </SelectParameters>
                </asp:SqlDataSource>
                </td>
            <td>
                <asp:HiddenField ID="HDNWYEAR" runat="server" />
                <asp:SqlDataSource ID="DSGroups" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    
                    SelectCommand="SELECT [CustEventGroupName], [CustEventGroupID] FROM [CustEventGroups] WHERE  ([CustEventGroupSort] = 1)">
                </asp:SqlDataSource>
                <asp:DropDownList ID="DDLGROUP" runat="server" AutoPostBack="True" 
                    DataSourceID="DSGroups" DataTextField="CustEventGroupName" 
                    DataValueField="CustEventGroupID" AppendDataBoundItems="True" EnableViewState="False" 
                     Visible="false">
                </asp:DropDownList>
            </td>
            <td>
                <asp:RadioButtonList ID="RBLROWFIELDS" runat="server" 
                    RepeatDirection="Horizontal" Width="234px" AutoPostBack="True">
                    <asp:ListItem Value="CustEventGroupName|Frame|BYear^1" Selected="True">מסגרות ושנתונים</asp:ListItem>
                    <asp:ListItem Value="CustEventGroupName|Frame^2">מסגרות בלבד</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="GVPIVOT" runat="server" DataSourceID="DSPIVOT" 
                    AutoGenerateColumns="False" BorderColor="#FF0066" CellPadding="1" 
                    HorizontalAlign="Right" Width="800px">
                    <Columns>
                        <asp:BoundField DataField="RowHDR">
                        <ItemStyle Wrap="False" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </td>
        </tr>
    </table>
    <br />
</asp:Content>

