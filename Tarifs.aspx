<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" CodeFile="Tarifs.aspx.vb" Inherits="Tarifs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
<asp:Label runat="server" ID="lblhdr" text="עדכון תעריפים" Font-Bold="True" 
        Font-Size="Large" ForeColor="Blue" Width="120px" />
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
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataSourceID="dstarifs">
        <Columns>
            <asp:BoundField DataField="ServiceID" HeaderText="ServiceID" ReadOnly="True" 
                SortExpression="ServiceID" Visible="False" />
            <asp:BoundField DataField="ServiceName" HeaderText="שירות" ReadOnly="True" 
                SortExpression="ServiceName" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="FrameID" SortExpression="FrameID" 
                Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FrameID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblframeid" runat="server" Text='<%# Bind("FrameID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
                SortExpression="FrameName" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="PDate" HeaderText="תאריך" ReadOnly="True" 
                SortExpression="PDate" DataFormatString="{0:MMM-yy}" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="תעריף" SortExpression="Tarif">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Tarif") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="tbtarif" runat="server" AutoPostBack="True" 
                        ontextchanged="tbtarif_TextChanged" Width="86px" Text='<%# Bind("Tarif", "{0:N}") %>' ></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" 
                        ControlToValidate="tbtarif" Display="Dynamic" ErrorMessage="מספר לא חוקי" 
                        MaximumValue="1000000" MinimumValue="0" 
                        Type="Double"></asp:RangeValidator>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dstarifs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT [ServiceID], [ServiceName], [FrameID], [FrameName], isnull([Pdate],@Pdate) as PDate, [Tarif] FROM [p4v_Tarifs] WHERE (isnull([Pdate],@Pdate) = @Pdate) ORDER BY [ServiceID], [FrameID]">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlmonths" Name="Pdate" 
                PropertyName="SelectedValue" Type="DateTime" />
        </SelectParameters>
    </asp:SqlDataSource>

</div>
</asp:Content>

