<%@ Page Title="" Language="VB" MasterPageFile="~/Welfare.master" AutoEventWireup="false" CodeFile="Welfarepwd.aspx.vb" Inherits="Welfarepwd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
    .pwdb
    {
        position: fixed;
        top: 50%;
        right:40%;
        background-color:Silver;
        border-left-style:inset;
        border-top-style:inset;
        border-right-style:outset; 
        border-bottom-style:outset; 
        direction:rtl;  
        font-family:Arial (Hebrew);  
    }
    
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pwdb">
<table>
    <tr>
        <td>
            <asp:Label runat="server" ID="lblunt" Text="שם משתמש" />
        </td>
        <td>
            <asp:TextBox runat="server" ID="tbun" Width="120" />
        </td>
    </tr>
    <tr>
        <td>
             <asp:Label runat="server" ID="lblpwt" Text="סיסמא" />
        </td>
        <td>
            <asp:TextBox runat="server" ID="tbpw" Width="120" TextMode="Password" />
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:Button runat="server" ID="bynlogin" Width="100%" Text="כניסה" />
            <asp:Label runat="server" ID="lblerr" ForeColor="Red" Text="שגיאה בשם משתמש או סיסמא" visible="false" />
    </tr>
</table>
</div>
</asp:Content>

