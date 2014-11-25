<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SurveyHeader.ascx.vb" Inherits="SurveyHeader" %>
<style type="text/css">
    .h1 
    {
        font-size:xx-large;
        font-weight:bolder;
        width:600px;
        padding-right:10px;
    } 
</style>
<div>
    <table style="width:100%;">
        <tr>
        <td rowspan="3" style="padding-top:4px;padding-right:2px;width:40px;">
            <asp:Image  runat="server" ID="imglogo" 
                ImageUrl="~/images/BELogo.png" /></td>
        <td colspan="4" style="text-align:center;width:760;">
            <asp:Label runat="server" ID="lblhdr" Text="" CssClass="h1" />
        </td>
    </tr>
        <tr>
        <td style="font-weight:bold;text-decoration:underline;width:70px;padding-right:10px;">
            
        </td>
        <td style="width:260px;">
            
        </td>
        <td style="width:130px;">
            &nbsp
        </td>
       <td style="width:100px;">
            תאריך:
        </td>
        <td style="width:50px;">
            <asp:Label runat="server" ID="lblDate" />
        </td>
      </tr>
        <tr>
        <td style="font-weight:bold;text-decoration:underline;padding-right:10px;">     
        </td>
        <td>
        </td>
        <td>
        </td>
        <td>
           <asp:Label runat="server" ID="lblFormHdrNumber" Text="מספר שאלון הסקר שלך הוא: " Visible="false"/>
        </td>
        <td>
            <asp:Label runat="server" ID="lblFormNumber" />
        </td>
      </tr>
    </table>
<hr />
 </div>
