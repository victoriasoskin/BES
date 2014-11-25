<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p5aFFormReport.aspx.vb" Inherits="p5aFFormReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
    <asp:SqlDataSource ID="dslq" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT grp, AVG(perc) AS perc, FormTypeID FROM p5v_FormResults WHERE (UserID = @UserID) GROUP BY grp, ord,FormTypeID HAVING (FormTypeID = 1) order by ord">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:label runat="server" ID="lblhdr" Text="ממוצע מסגרתי"  ForeColor="Blue" Font-Bold="true" Font-size="Large" Width="150" />
</div>
<div>
  <asp:listview runat="server" ID="lvr_r" DataSourceID="dslq">
    <LayoutTemplate> 
        <table  border="1" cellpadding="3">
                   <thead style="background-color:Silver" align="center">
                <tr>
                    <td colspan="3" align="center" style="font-weight:bold">ממוצע מסגרתי</td>
                </tr>
                <tr>
                    <td style="width:80px">סולם</td>
                    <td style="width:80px">אחוזון</td>
                </tr>
            </thead>
            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
</table>
 </LayoutTemplate>
 <itemtemplate>
    <tbody>
        <tr>
            <td style="background-color:Silver">
                <asp:Label runat="server" ID="lblgrp" Text='<%#Eval("grp") %>' Width="180" Font-Bold='<%#Eval("grp")="סיכום" %>'></asp:Label>
            </td>
             <td>
                <asp:Label runat="server" ID="lblprc" Text='<%#Eval("perc","{0:#.0}") %>' Font-Bold='<%#Eval("grp")="סיכום" %>'></asp:Label>
            </td> 
        </tr>
    </tbody>
 </ItemTemplate>
  </asp:listview>
</div>
</asp:Content>

