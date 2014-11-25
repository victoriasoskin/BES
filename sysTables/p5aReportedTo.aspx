<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p5aReportedTo.aspx.vb" Inherits="SysTables_p5aReportedTo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <div id="HDR">
            <asp:Label ID="Label1" runat="server" Text="רשימת גורמים מדווחים" Font-Bold="True" 
                Font-Size="Medium" ForeColor="Blue" Width="177px"></asp:Label>
        </div>
        <div id="BodyGrid">
            <table>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" DataKeyNames="RepID" DataSourceID="dstab">
                            <Columns>
                                <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" 
                                    ShowDeleteButton="True" ShowEditButton="True" UpdateText="עדכון" />
                                <asp:BoundField DataField="RepID" HeaderText="זיהוי" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RepID" />
                                <asp:BoundField DataField="Reported" HeaderText="גורם מדווח" 
                                    SortExpression="Reported" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td valign="top">
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="RepID" DataSourceID="dstab" DefaultMode="Insert" 
                            HeaderText="הוספת גורם מדווח" Height="50px" Width="125px">
                            <Fields>
                                <asp:BoundField DataField="RepID" HeaderText="RepID" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RepID" />
                                <asp:BoundField DataField="Reported" HeaderText="גורם מדווח" 
                                    SortExpression="Reported" />
                                <asp:CommandField CancelText="ביטול" InsertText="הוספה" 
                                    ShowInsertButton="True" />
                            </Fields>
                        </asp:DetailsView>
                    </td> 
               </tr>
           </table>
            <asp:SqlDataSource ID="dstab" runat="server" 
                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                DeleteCommand="DELETE FROM [ExEventReportedTo] WHERE [RepID] = @RepID" 
                InsertCommand="INSERT INTO [ExEventReportedTo] ([Reported]) VALUES (@Reported)" 
                SelectCommand="SELECT [RepID], [Reported] FROM [ExEventReportedTo]" 
                
                UpdateCommand="UPDATE [ExEventReportedTo] SET [Reported] = @Reported WHERE [RepID] = @RepID">
                <DeleteParameters>
                    <asp:Parameter Name="RepID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Reported" Type="String" />
                    <asp:Parameter Name="RepID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="Reported" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>

</asp:Content>

