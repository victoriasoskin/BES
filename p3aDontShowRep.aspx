<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p3aDontShowRep.aspx.vb" Inherits="p3t_DontShowRep" title="בית אקשטיין - דוחות שלא יוצגו" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td colspan="2">
                <asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Medium" 
                    ForeColor="#0033CC" Text="רשימת דוחות שלא יוצגו" Width="196px"></asp:Label>
            </td>
        </tr>
        <tr> 
            <td valign="top">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="DSDontShow" CellPadding="5" DataKeyNames="RowID">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                    CommandName="Delete" Text="מחיקה"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
                            SortExpression="FrameName" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RepTypeName" HeaderText="דוח" 
                            SortExpression="RepTypeName" >
                            <ItemStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RowID" Visible="False" />
                    </Columns>
                </asp:GridView>
            </td>
            <td valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                    DataSourceID="DSDontShow" DefaultMode="Insert" Height="50px" Width="125px">
                    <Fields>
                        <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameName">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" 
                                    DataSourceID="DSFrame" DataTextField="FrameName" DataValueField="FrameID" 
                                    SelectedValue='<%# Bind("FrameID") %>'>
                                    <asp:ListItem Value="">&lt;בחירת מסגרת&gt;</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="DSFrame" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                    SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]">
                                </asp:SqlDataSource>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <br />
                                <br />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="דוח" SortExpression="RepTypeName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RepTypeName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:SqlDataSource ID="DSRepType" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                    SelectCommand="SELECT [RepTypeName], [RepTypeID] FROM [p0t_RepList]">
                                </asp:SqlDataSource>
                                <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                                    DataSourceID="DSRepType" DataTextField="RepTypeName" 
                                    DataValueField="RepTypeID" SelectedValue='<%# Bind("RepTypeID") %>' >
                                </asp:RadioButtonList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField CancelText="ביטול" InsertText="הוספה" 
                            ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSDontShow" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        DeleteCommand="DELETE FROM p4t_DontShowRep WHERE (RowID = @RowID)" 
        InsertCommand="INSERT INTO p4t_DontShowRep(FrameID, RepTypeID) VALUES (@FrameID,@RepTypeid)" 
        
        
        
        SelectCommand="SELECT FrameList.FrameName, p0t_RepList.RepTypeName, p4t_DontShowRep.RowID FROM p4t_DontShowRep LEFT OUTER JOIN p0t_RepList ON p4t_DontShowRep.RepTypeID = p0t_RepList.RepTypeID LEFT OUTER JOIN FrameList ON p4t_DontShowRep.FrameID = FrameList.FrameID">
        <DeleteParameters>
            <asp:Parameter Name="RowID" type="int32"/>
        </DeleteParameters>
        <InsertParameters>
           <asp:Parameter Name="FrameID" />
            <asp:Parameter Name="ReptypeID" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>

