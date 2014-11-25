<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ADD.aspx.vb" Inherits="ADD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <table style="width: 100%"> 
            <tr>
                <td>
        <asp:Label ID="LBLHDR" runat="server" Font-Bold="True" Font-Size="Medium" 
            ForeColor="Blue" Text="הצגת פירוט עובדים" Width="340px"></asp:Label>
                </td>
                <td>
            <input id="חזרה" type="button" value="חזרה" onclick="history.back()" visible="true" /></td>
            </tr>
        </table>
    </div>
    <div>
    <table border="1">
        <tr>
            <td>
                <asp:Label BackColor="Bisque" ID="Label2" runat="server" Text="מסגרת: " Width="50px" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LBLFRAME" runat="server" Text="Label" Width="150px"></asp:Label>
            </td>
              <td>
                <asp:Label ID="Label5" BackColor="Bisque" runat="server" Text="תפקיד: " Width="65px" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LBLJOB" runat="server" Text="Label" Width="100px"></asp:Label>
            </td>
      </tr>
      <tr>
            <td>
                <asp:Label ID="Label7" BackColor="Bisque" runat="server" Text="מתאריך: " Width="50px" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LBLFDATE" runat="server" Text="Label" Width="150px"></asp:Label>
            </td>
            <td>
                <asp:Label ID="Label9" BackColor="Bisque" runat="server" Text="עד תאריך: " Width="65px" Font-Bold="true"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LBLTDATE" runat="server" Text="Label" Width="100px"></asp:Label>
            </td>
      </tr>
    </table>
    </div>
    <div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="DSTrans" CellPadding="4" ShowFooter="True">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" 
                            onprerender="LinkButton1_PreRender">פירוט</asp:LinkButton>
                        <asp:HiddenField ID="HDNACCOUNTNAME" runat="server" 
                            Value='<%# eval("AccountName") %>' />
                        <asp:HiddenField ID="HDNPDATE" runat="server" 
                            Value='<%# Eval("DateB") %>' />
                        <asp:HiddenField ID="HDNAccountkey" runat="server" 
                            Value='<%# Eval("AccountKey") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AccountKey" HeaderText="מס עובד/ חשבון" 
                    SortExpression="AccountKey" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="AccountName" HeaderText="שם עובד/ שם חשבון" 
                    SortExpression="AccountName" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="DepartmentID" HeaderText="מס מחלקה" 
                    SortExpression="DepartmentID" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="DepartmentName" HeaderText="מחלקה" 
                    SortExpression="DepartmentName" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="DateB" HeaderText="תאריך" 
                    DataFormatString="{0:MMM-yy}" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Details" HeaderText="פרטים" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="שעות" SortExpression="Q">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# v("Q") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        <asp:Label ID="Label3" runat="server"  Text='<%# tv() %>'></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# v("Q") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Wrap="False" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="DSTrans" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="p1p_Saltrans" SelectCommandType="StoredProcedure" 
            CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="0" Name="AMode" QueryStringField="AMode" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="FrameCategoryID" QueryStringField="FrameCategoryID" Type="Int32" />
                <asp:QueryStringParameter Name="BudgetCategoryID" QueryStringField="BudgetCategoryID" Type="Int32" />
                <asp:QueryStringParameter Name="JobCategoryID" QueryStringField="JobCategoryID" Type="Int32" />
                <asp:QueryStringParameter Name="FDate" QueryStringField="DateS" Type="DateTime" />
                <asp:QueryStringParameter Name="TDate" QueryStringField="DateB" Type="DateTime" />
                 <asp:QueryStringParameter Name="AccountKey" QueryStringField="Accountkey" Type="Int32" />
                <asp:QueryStringParameter DefaultValue="" Name="PDate" QueryStringField="PDate" 
                    Type="DateTime" />
                <asp:QueryStringParameter DefaultValue="" Name="AccountName" 
                    QueryStringField="AccountName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>

