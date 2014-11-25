<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="Properties.aspx.vb" Inherits="SysTables_Default" title="��� ������� - ������ ������" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSPROP" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [RowID], [GraceMonths] FROM [p0t_custProperties] WHERE [RowID] = 1"
        UpdateCommand="UPDATE p0t_custProperties SET GraceMonths = @GraceMonths">
        <UpdateParameters>
            <asp:Parameter Name="GraceMonths" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="DSPROP"
        DefaultMode="Edit" Height="50px" Width="125px" HeaderText="������">
        <RowStyle Wrap="False" />
        <Fields>
            <asp:BoundField DataField="GraceMonths" HeaderText="������ �� ����� �������" SortExpression="GraceMonths" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:CommandField CancelText="�����" EditText="�����" ShowEditButton="True" UpdateText="�����" />
        </Fields>
        <HeaderStyle Wrap="False" />
    </asp:DetailsView>
</asp:Content>

