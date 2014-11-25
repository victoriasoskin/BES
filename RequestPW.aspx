<%@ Page Language="VB" validateRequest="false" AutoEventWireup="false" CodeFile="RequestPW.aspx.vb" Inherits="RequestPW" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title title="">שחזור סיסמא</title>
</head>
    <body dir="rtl" style="font-family:Arial (Hebrew);font-size:small;background-color:#EEEEEE;border:1px solid blue;">
        <form id="form1" runat="server">
        <div style="">
            <div runat="server" id="divhdr" style="">
                <asp:Label runat="server" ID="lblhdr" />
                <div runat="server" id="divmsgerr" visible="false" style="border:2px solid red;border-top:6px solid red;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:100px;right:20px;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;">
                    <asp:Label runat="server" ID="lblmsgerr" Height="55" style="text-align:right;"></asp:Label><br /><br />
                    <asp:Button runat="server" ID="btnerr" Text="אישור"  /> 
                </div>
                <div runat="server" id="divmsgerr2" visible="false" style="border:2px solid red;border-top:6px solid red;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:100px;right:20px;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;">
                    <asp:Label runat="server" ID="lblmsgerr2" Height="55" style="text-align:right;"></asp:Label><br /><br />
                    <asp:Button runat="server" ID="btnerr2" Text="אישור"  />
                </div>
                 <div runat="server" id="divmsgok" visible="false" style="border:2px solid blue;border-top:6px solid blue;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:100px;right:20px;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;">
                    <asp:Label runat="server" ID="lblmsgOK" Height="55" style="text-align:right;"></asp:Label><br /><br />
                    <button id="btnok" onclick="window.open('','_self','');window.close();">אישור</button>
                </div>
         </div>
            <div>
                <asp:Table runat="server" ID="tblblk" CellPadding="4" BorderWidth="1" >
                    <asp:TableRow runat="server" style="">
                        <asp:TableCell runat="server" ID="tdHelp" ColumnSpan="2">
                            <asp:Label runat="server" ID="lblhelp" />
                        </asp:TableCell></asp:TableRow><asp:TableRow ID="tremail" runat="server">
                        <asp:TableCell runat="server" ID="tdEmail1" >
                            <asp:Label runat="server" ID="lblEmail" />
                        </asp:TableCell><asp:TableCell runat="server" ID="tdEmail2" style="text-align:center;">
                            <span style="direction:ltr;"><asp:TextBox runat="server" ID="tbemail1" Width="100" TabIndex="70"/>@</span><asp:TextBox runat="server" ID="tbemail2" Width="70" TabIndex="60" />
                        </asp:TableCell></asp:TableRow><asp:TableRow>
                        <asp:TableCell></asp:TableCell><asp:TableCell runat="server" ID="tdbtn">
                           <asp:Button runat="server" ID="btnsnd" />
                           <asp:HiddenField runat="server" ID="hdnError" />
                           <asp:HiddenField runat="server" ID="hdnSuccess" />
                           <asp:HiddenField runat="server" ID="hdnsubj" />
                           <asp:HiddenField runat="server" ID="hdnBody" />
                         </asp:TableCell></asp:TableRow></asp:Table></div></div></form></body></html>