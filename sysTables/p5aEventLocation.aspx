<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p5aEventLocation.aspx.vb" Inherits="SysTables_p5aEventLocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

        <div id="HDR">
            <asp:Label ID="Label1" runat="server" Text="טבלת מקום האירוע" Font-Bold="True" 
                Font-Size="Medium" ForeColor="Blue" Width="177px"></asp:Label>
        </div>
        <div id="BodyGrid">
            <table>
                <tr>
                    <td valign="top">
                        <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                            AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="dstab">
                            <Columns>
                                <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" 
                                    ShowDeleteButton="True" ShowEditButton="True" UpdateText="עדכון" />
                                <asp:BoundField DataField="ID" HeaderText="זיהוי" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RepID" />
                                <asp:BoundField DataField="EventLocation" HeaderText="מקום האירוע" 
                                    SortExpression="Reported" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td valign="top">
                        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" 
                            DataKeyNames="RepID" DataSourceID="dstab" DefaultMode="Insert" 
                            HeaderText="הוספת מקום אירוע" Height="50px" Width="125px">
                            <Fields>
                                <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="RepID" />
                                <asp:BoundField DataField="EventLocation" HeaderText="מקום האירוע" 
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
                DeleteCommand="DELETE FROM [ExEventLocation] WHERE [ID] = @ID" 
                InsertCommand="INSERT INTO [ExEventLocation] ([EventLocation]) VALUES (@EventLocation)" 
                SelectCommand="SELECT [ID], [EventLocation] FROM [ExEventLocation]" 
                
                
                UpdateCommand="UPDATE [ExEventLocation] SET [EventLocation] = @EventLocation WHERE [ID] = @ID">
                <DeleteParameters>
                    <asp:Parameter Name="ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="EventLocation" Type="String" />
                    <asp:Parameter Name="ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="EventLocation" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>

</asp:Content>

