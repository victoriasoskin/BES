<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CompareSal2Trans.aspx.vb" Inherits="CompareSal2Trans" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="inthdr">השוואת דוח לפירוט תנועות</div>
<div>
    <asp:SqlDataSource ID="dscompare" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        SelectCommand="pSalAudit_Rep2Trn" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlgirsa" Name="Version" 
                PropertyName="SelectedValue" Type="String" /> 
       </SelectParameters>
    </asp:SqlDataSource>
    <asp:DropDownList ID="ddlgirsa" runat="server" AutoPostBack="True" 
        DataSourceID="dsgirsa" DataTextField="VERSION" DataValueField="VERSION" AppendDataBoundItems="true">
        <asp:ListItem>[בחירת גרסה]</asp:ListItem>
    </asp:DropDownList>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="dscompare" EnableModelValidation="True">
        <Columns>
            <asp:BoundField DataField="FrameCategoryID" HeaderText="קוד" 
                SortExpression="FrameCategoryID" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Frame" HeaderText="מסגרת" SortExpression="Frame" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Subject" HeaderText="תפקיד" 
                SortExpression="Subject" />
            <asp:BoundField DataField="dateB" DataFormatString="{0:MMM-yy}" 
                HeaderText="חודש" SortExpression="dateB" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:HyperLinkField 
                DataTextField="QA" DataTextFormatString="{0:N0}" HeaderText="כמות בדוח" 
                DataNavigateUrlFields="LinkD" />
            <asp:BoundField DataField="QA_T" DataFormatString="{0:N0}" 
                HeaderText="כמות בתנועות" SortExpression="QA_T" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="dm" DataFormatString="{0:n0}" HeaderText="הפרש" />
            <asp:HyperLinkField 
                DataTextField="QAT" DataTextFormatString="{0:N0}" HeaderText="מצטבר בדוח" 
                DataNavigateUrlFields="LinkX" />
            <asp:BoundField DataField="QAT_T" DataFormatString="{0:N0}" HeaderText="מצטבר בתנועות" 
                ReadOnly="True" SortExpression="QAT_T" >
            <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="dt" DataFormatString="{0:n0}" HeaderText="הפרש" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="dsgirsa" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT DISTINCT [Version] FROM [p1t_MpRep] ORDER BY [Version] DESC">
    </asp:SqlDataSource>
</div>
</asp:Content>

