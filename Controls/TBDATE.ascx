<%@ Control Language="VB" AutoEventWireup="false" CodeFile="TBDATE.ascx.vb" Inherits="Controls_EnterDate" %>
<div dir="rtl">
    <table>
        <tr>
            <td>
                <asp:TextBox runat="server" ID="zzztbdate" Width="70px" AutoPostBack="true" ValidationGroup="zzztbdate" BackColor="#ececec"/>
                <asp:CustomValidator runat="server" ID="zzzcvdate" ErrorMessage="תאריך לא חוקי" 
                    ControlToValidate="zzztbdate" Display="Dynamic" ValidationGroup="zzztbdate" />
            </td>
            <td>
            <asp:ImageButton runat="server" ID="zzzbtnclndr" 
                    ImageUrl="~/Controls/images/Calendar.ICO" style="width: 16px" 
                    BackColor="Silver" BorderColor="#666699" BorderStyle="Ridge" ValidationGroup="zzztbdate" />
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="3">
                <asp:Calendar runat="server" ID="zzzClndr" Visible="false" />
            </td>
        </tr>
    </table>
</div>