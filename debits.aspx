<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="debits.aspx.vb" Inherits="debits" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
    <asp:Label runat="server" ID="lblhdr" Text="דוח חייבים" Font-Bold="true" Font-Size="Large" ForeColor="blue" />
</div>
<div>

    <asp:DropDownList ID="ddlmonths" runat="server" DataSourceID="dsmonths" 
        DataTextField="D" DataValueField="D" AppendDataBoundItems="True" 
        AutoPostBack="True" DataTextFormatString="{0:MMM-yy}">
        <asp:ListItem Value="">&lt;בחר חודש&gt;</asp:ListItem>
    </asp:DropDownList> 

    <br />
    <asp:SqlDataSource ID="dsmonths" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="select d from p0v_Workmonths order by d">
    </asp:SqlDataSource>
</div>
<div>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="DSDEBIT" CellPadding="4" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="ServiceName" HeaderText="איזור/חטיבה" 
                ReadOnly="True" SortExpression="ServiceName" />
            <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameName">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("FrameName") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblframe" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="חודשי חוב" SortExpression="debit">
                 <FooterTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# tval("#,###",0) %>'></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblmonth" runat="server" Text='<%# val("debit","#,###",0) %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="tarif" HeaderText="תעריף" ReadOnly="True" 
                SortExpression="tarif" />
            <asp:TemplateField HeaderText="סכום" SortExpression="tot">
                <FooterTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# tval("#,###",1) %>'></asp:Label>
                </FooterTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblsum" runat="server" Text='<%# val("tot", "#,###",1) %>' 
                        onprerender="lblsum_PreRender"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="DSDEBIT" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT p.ServiceID, s.ServiceName, p.FrameID, p.FrameName, COUNT(p.Paid) AS debit, ISNULL(t.tarif, 0) AS tarif, ISNULL(t.tarif, 0) * COUNT(p.Paid) AS tot FROM p0v_PayListNU AS p LEFT OUTER JOIN ServiceList AS s ON s.ServiceID = p.ServiceID LEFT OUTER JOIN p4v_Tarifs AS t ON p.FrameID = t.FrameID AND t.pdate = @PDate WHERE (p.Paid = 0) AND (p.PaymentMonth &lt;= @PDate) GROUP BY p.ServiceID, s.ServiceName, p.FrameID, p.FrameName, t.tarif UNION SELECT p.ServiceID, s.ServiceName, NULL AS Expr1, NULL AS Expr2, COUNT(p.Paid) AS debit, NULL AS tarif, NULL AS tot FROM p0v_PayListNU AS p LEFT OUTER JOIN ServiceList AS s ON s.ServiceID = p.ServiceID WHERE (p.Paid = 0) AND (p.PaymentMonth &lt;= @PDate) GROUP BY p.ServiceID, s.ServiceName">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlmonths" Name="PDate" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

</div>
</asp:Content>

