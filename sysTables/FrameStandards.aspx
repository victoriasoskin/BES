<%@ Page Language="VB" MasterPageFile="~/Sherut.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="FrameStandards.aspx.vb" Inherits="FrameStandards" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="#0000C0"
        Text="הזנת תקן לקוחות" Width="193px"></asp:Label>
    <asp:DropDownList ID="DDLSERVICE" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
        DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID">
        <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
    </asp:DropDownList>
    <asp:DropDownList ID="DDLWORKYEAR" runat="server" DataSourceID="DSWorkYears" DataTextField="WorkYear"
        DataValueField="WorkYearFirstDate" AppendDataBoundItems="True" AutoPostBack="True">
        <asp:ListItem Value="">&lt;בחר שנת עבודה&gt;</asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="DSServices" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSWorkYears" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [WorkYear], [WorkYearFirstDate] FROM [p0t_WorkYears]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSStandards" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="p2p_InputStandards" SelectCommandType="StoredProcedure" UpdateCommand="p2p_storestandards" UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLSERVICE" Name="ServiceID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="DDLWORKYEAR" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="DDLWORKYEAR" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:Parameter Name="מסגרת" Type="String" />
            <asp:Parameter Name="IM0" Type="Int32" />
            <asp:Parameter Name="IM1" Type="Int32" />
            <asp:Parameter Name="IM2" Type="Int32" />
            <asp:Parameter Name="IM3" Type="Int32" />
            <asp:Parameter Name="IM4" Type="Int32" />
            <asp:Parameter Name="IM5" Type="Int32" />
            <asp:Parameter Name="IM6" Type="Int32" />
            <asp:Parameter Name="IM7" Type="Int32" />
            <asp:Parameter Name="IM8" Type="Int32" />
            <asp:Parameter Name="IM9" Type="Int32" />
            <asp:Parameter Name="IM10" Type="Int32" />
            <asp:Parameter Name="IM11" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns=False  DataSourceID="DSStandards" Width="700px" DataKeyNames="מסגרת">
        <FooterStyle Wrap="False" />
        <EmptyDataRowStyle Wrap="False" />
        <RowStyle Wrap="False" />
        <EditRowStyle Wrap="False" />
        <SelectedRowStyle Wrap="False" />
        <PagerStyle Wrap="False" />
        <HeaderStyle Wrap="False" />
        <AlternatingRowStyle Wrap="False" />
        <Columns>
            <asp:TemplateField HeaderText="מסגרת">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("מסגרת") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLFRAME" runat="server" Text='<%# Bind("מסגרת") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:label runat=server id="LBLD1" Text='<%# hdrt(1) %>'/>             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS1" runat="server" Width="30px" Text='<%# vald(1) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD2" Text='<%# hdrt(2) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS2" runat="server" Width="30px" Text='<%# vald(2) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD3" Text='<%# hdrt(3) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS3" runat="server" Width="30px" Text='<%# vald(3) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD4" Text='<%# hdrt(4) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS4" runat="server" Width="30px" Text='<%# vald(4) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
              <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD5" Text='<%# hdrt(5) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS5" runat="server" Width="30px" Text='<%# vald(5) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD6" Text='<%# hdrt(6) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS6" runat="server" Width="30px" Text='<%# vald(6) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD7" Text='<%# hdrt(7) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS7" runat="server" Width="30px" Text='<%# vald(7) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD8" Text='<%# hdrt(8) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS8" runat="server" Width="30px" Text='<%# vald(8) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD9" Text='<%# hdrt(9) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS9" runat="server" Width="30px" Text='<%# vald(9) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
             <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD10" Text='<%# hdrt(10) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS10" runat="server" Width="30px" Text='<%# vald(10) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD11" Text='<%# hdrt(11) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS11" runat="server" Width="30px" Text='<%# vald(11) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <HeaderTemplate>
                    <asp:Label runat=server id="LBLD12" Text='<%# hdrt(12) %>' />             
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:TextBox ID="TBS12" runat="server" Width="30px" Text='<%# vald(12) %>' OnTextChanged="TBS_TextChanged" AutoPostBack="True"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
 </Columns>
    </asp:GridView>
</asp:Content>

