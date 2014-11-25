<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SurveyLogin.aspx.vb" Inherits="SurveyLogin" %>
<%@ Register TagPrefix="topyca" TagName="SurveyHeader" Src="~/Controls/SurveyHeader.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>בית אקשטיין - מערכת סקרים</title> 
   <style type="text/css">
		.reldiv
		{
			position:relative;
			font-size: smaller; 
			font-family: Arial;
			width:100%;
			direction:rtl;
		}
		.hdrdiv
		{
			text-align:center;
			font-size:x-large;
			font-weight:bold;
			color:Olive;
		}
		.scrl
		{
			position:absolute;
			bottom:auto;
			left:100;
		}
		.rblbrdr td
		{
		    border:1px solid grey;
		}
    .p 
    {
        width:200px;
        padding-right:10px;
    }
    .pg
    {
        position:absolute;
        background-color:#C0C0C0;
        width:800px;
        border-top-width:1px;
        border-style:outset;
        border-color:#DDDDDD;
    }
    .blockHeader
    {
        font-size:medium;
        color:ButtonText;
        font-weight:bolder;
        height:25px;   
        padding-right:10px;     
    }
    .blockfooter
    {
        padding-right:10px;        
    }
    .tbw
    {
        background-color: #ececec;
        font-family: verdana;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        font-family: verdana;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        font-family: verdana;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
        font-family: verdana;
        width:125px;
        border-style:groove;
    }
    .tdr
    {
        padding-right:10px;
        padding-top:5px;
    }
    .tbl
    {
        padding:10px;
        width:100%;
    }
    th
    {
        background-color:#AAAAAA;
        border-bottom:1px solid black;
    }
    .tbld
    {
        width:100%;
    }
    .tbld td
    {
        padding-right:10px;
    }
    .tdid
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
        width:20px;
    }
    .tdg
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
    }
   .tdq
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
    }
    .tda
    {
        border-bottom:1px outset #AAAAAA;
        width:300px;
    }
    .shf
    {
        background-color: #eaeaea;
        font-family: verdana;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
</style>
<script src="jquery-1.7.1.js" type="text/javascript"></script>
<script  type="text/javascript">
    function pop(vid, pwd, pth) {
         var t = document.getElementById(vid);
        if (t.value == pwd) {
            window.open(pth, '_blank', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,left=0,height=750,width=1080');
            window.open('', '_self', ''); window.close();
        }
   }
   </script>
</head>
<body> 
    <form id="form1" runat="server">
        <div class="reldiv">
            <div class="pg">
                <topyca:SurveyHeader runat="server" ID="PageHeader1" Header="דף כניסה - סקרים" />
                    <div style="width:100%;height:400px;vertical-align:middle;text-align:center;">
                        <asp:Label runat="server" ID="lblSurveyName" Font-Size="X-Large" Font-Bold="true" />
                        <asp:Label runat="server" ID="lblBrowsers" Font-Size="X-Large" Font-Bold="true" Visible="false" Text="&lt;br /&gt;עדיף לגלוש בדפדפנים הבאים:&lt;br /&gt;Internet Explorer&lt;br /&gt;Chrome&lt;br /&gt;גלישה בדפדפן אחר עלולה לגרום לתקלות בסקר!" ForeColor="Red" />
                         <BR />
                        <BR />
                        <BR />
                        <BR />
                        <BR />
                        <BR />
                        <BR />
                        <BR />
                        <div runat="server" id="divlogin" >
                            <p style="vertical-align:text-top;">
                                <asp:Label  ID="lblpwt" runat="server" style="font-size:large;font-weight:bold;" Height="24">סיסמא </asp:Label> 
                                &nbsp;&nbsp;<asp:TextBox runat="server" ID="tbpwd" TextMode="Password" CssClass="tbw" Height="18" />
                                <asp:Button runat="server" ID="btnLogin" Text="כניסה" Height="25" style="font-size:medium;font-weight:bold;" />
                            </p>
                        </div>
                    </div>
                    <br /><br />
            </div>
        </div>

    </form>
</body>
</html>
