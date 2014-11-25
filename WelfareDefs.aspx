<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="WelfareDefs.aspx.vb" Inherits="WelfareDefs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="phdrdiv" style="width:200px">
    ניהול פעולות רווחה<br />
</div>
<div>
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="OpID" 
        DataSourceID="DSWelfareOps" InsertItemPosition="LastItem">
         <EditItemTemplate>
            <tr style="background-color: #FFCC66;color: #000080;">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update"  
                        Text="עדכון" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="ביטול" />
                </td>
                <td>
                    <asp:Label ID="OpIDLabel1" runat="server" Text='<%# Eval("OpID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="OPNameTextBox" runat="server" Text='<%# Bind("OPName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="MaxOrdersTextBox" runat="server" 
                        Text='<%# Bind("MaxOrders") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DiscountTextBox" runat="server" 
                        Text='<%# Bind("Discount","{0:0%}") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                        Checked='<%# Bind("Active") %>' />
                </td>
                <td>
                    <asp:TextBox ID="minSTextBox" runat="server" Text='<%# Bind("minS","{0:0}") %>' />
                </td>
                <td>
                    <asp:TextBox ID="maxSTextBox" runat="server" Text='<%# Bind("maxS","{0:0}") %>' />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="AgreeRequiredCheckBox" Checked='<%# Bind("AgreeRequired") %>' />
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" 
                style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;">
                <tr>
                    <td>
                       אין נתונים להצגה</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="הוספה" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="ביטול" />
                </td>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:TextBox ID="OPNameTextBox" runat="server" Text='<%# Bind("OPName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="MaxOrdersTextBox" runat="server" 
                        Text='<%# Bind("MaxOrders") %>' />
                </td>
                <td>
                    <asp:TextBox ID="DiscountTextBox" runat="server" 
                        Text='<%# Bind("Discount","{0:0%}") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                        Checked='<%# Bind("Active") %>' />
                </td>
                <td>
                    <asp:TextBox ID="minSTextBox" runat="server"  Text='<%# Bind("minS","{0:0}") %>' />
                </td>
                <td>
                    <asp:TextBox ID="maxSTextBox" runat="server"  Text='<%# Bind("maxS","{0:0}") %>' />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="AgreeRequiredCheckBox" Checked='<%# Bind("AgreeRequired") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #FFFBD6;color: #333333;">
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" 
                        Text="מחיקה" OnClientClick="return confirm('האם למחוק?');"/>
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="עריכה" />
                    <asp:LinkButton ID="EditPagebutton" runat="server" Text="עריכת דף המבצע" PostBackUrl='<%# "~/EditWelFare.aspx?OP=" & Eval("OpID") & "&AG=" & Eval("AgreeRequired")  %>' />
         <input type="button" value="למבצע!" onclick="window.open( '/WelFareZbuy_1.aspx?OP=2&AG=True', null, 'toolbar=no,location=center,status=yes,menubar=no,scrollbars=no,resizable=no,width=630,height=650');" />
                </td>
                <td>
                    <asp:Label ID="OpIDLabel" runat="server" Text='<%# Eval("OpID") %>' />
                </td>
                <td>
                    <asp:Label ID="OPNameLabel" runat="server" Text='<%# Eval("OPName") %>' />
                </td
                <td>
                    <asp:Label ID="MaxOrdersLabel" runat="server" Text='<%# Eval("MaxOrders") %>' />
                </td>
                <td>
                    <asp:Label ID="DiscountLabel" runat="server" Text='<%# Eval("Discount","{0:0%}") %>' />
                </td>
                <td>
                    <asp:CheckBox ID="ActiveCheckBox" runat="server" 
                        Checked='<%# Eval("Active") %>' Enabled="false" />
                </td>
                <td>
                    <asp:Label ID="minSLabel" runat="server"  Text='<%# Bind("minS","{0:0}") %>' />
                </td>
                <td>
                    <asp:Label ID="maxSLabel" runat="server"  Text='<%# Bind("maxS","{0:0}") %>' />
                </td>
                <td>
                    <asp:CheckBox runat="server" ID="AgreeRequiredCheckBox" Checked='<%# Eval("AgreeRequired") %>' Enabled="false" />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="1" 
                            style="background-color: #FFFFFF;border-collapse: collapse;border-color: #999999;border-style:none;border-width:1px;font-family: Verdana, Arial, Helvetica, sans-serif;">
                            <tr runat="server" style="background-color: Gray;color: #333333;">
                                <th runat="server">
                                </th>
                                <th runat="server">
                                    קוד</th>
                                <th runat="server">
                                    שם המבצע</th>
                                <th runat="server">
                                    מספר הזמנות מירבי</th>
                                <th runat="server">
                                    הנחה</th>
                                <th runat="server">
                                    פעיל</th>
                                <th runat="server">
                                    סכום מינימלי</th>
                                <th runat="server">
                                    סכום מקסימאלי</th>
                                <th id="Th1" runat="server">
                                    נדרשת הסכמה</th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" 
                        style="text-align: center;background-color: #FFCC66;font-family: Verdana, Arial, Helvetica, sans-serif;color: #333333;">
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DSWelfareOps" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        DeleteCommand="DELETE FROM [WelFareOPS] WHERE [OpID] = @OpID" 
        InsertCommand="INSERT INTO WelFareOPS(OPName, MaxOrders, Discount, Active, minS, maxS, AgreeRequired) VALUES (@OPName, @MaxOrders, @Discount, @Active, @minS, @maxS, @AgreeRequired)" 
        SelectCommand="SELECT OpID, OPName, MaxOrders, Discount, Active, minS, maxS, AgreeRequired FROM WelFareOPS ORDER BY OpID" 
        UpdateCommand="UPDATE WelFareOPS SET OPName = @OPName, MaxOrders = @MaxOrders, Discount = @Discount, Active = @Active, minS = @minS, maxS = @maxS, AgreeRequired = @AgreeRequired WHERE (OpID = @OpID) ">
        <DeleteParameters>
            <asp:Parameter Name="OpID" Type="Int32" />
         </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="OPName" Type="String" />
            <asp:Parameter Name="MaxOrders" Type="Int32" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="minS" Type="Decimal" />
            <asp:Parameter Name="maxS" Type="Decimal" />
            <asp:Parameter Name="AgreeRequired" Type="Boolean" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="OPName" Type="String" />
            <asp:Parameter Name="MaxOrders" Type="Int32" />
            <asp:Parameter Name="Discount" Type="Decimal" />
            <asp:Parameter Name="Active" Type="Boolean" />
            <asp:Parameter Name="minS" Type="Decimal" />
            <asp:Parameter Name="maxS" Type="Decimal" />
            <asp:Parameter Name="AgreeRequired" Type="Boolean" />
            <asp:Parameter Name="OpID" Type="Int32" />
       </UpdateParameters>
    </asp:SqlDataSource>
</div>
</asp:Content>

