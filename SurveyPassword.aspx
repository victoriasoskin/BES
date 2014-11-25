<%@ Page Title="" Language="VB" MasterPageFile="~/SherutO.master" AutoEventWireup="false" CodeFile="SurveyPassword.aspx.vb" Inherits="SurveyPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="survhdr">
			<asp:Label ID="lblhdr1" runat="server" Text="מערכת הסקרים" />
			<br />
			<asp:Label id="lblhdr2" runat="server" Text="בקרת כניסה" />
			<br />
			<asp:Label id="lblhdr3" runat="server" Font-Size="X-Large" />
        </div>
        <div class="login"> 
        <table >
            <tr>
                <td>
                </td>
			<asp:Label id="Label1" runat="server" Text="הסקר סגור, תודה!"  ForeColor="red"  Font-Size="XX-Large" Font-Bold="true" Visible="false"/>
                <td>
                </td>
            </tr>
            <tr style="background-color:Silver;vertical-align:middle;height:50px;">
                <td>
                    <asp:Label runat="server" ID="lblphdr"  Text="סיסמא" />
                    
                </td>
                <td>
                  <asp:TextBox runat="server" ID="tbpwd"  TextMode="Password" AutoPostBack="True" 
                        Enabled="true" />
              </td>
              <td>
                 <asp:Button runat="server" ID="btnpwd" Text="כניסה" Visible="true" />
              </td>
            </tr>
        </table>
    </div>
	</div>
    <div style="text-align:center;vertical-align:middle;">
</asp:Content>

 