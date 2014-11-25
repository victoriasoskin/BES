<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Testparameters.aspx.vb" Inherits="Testparameters" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
	<script type="text/javascript">function Func1(){alert("Delayed 60 seconds");}  function Func1Delay() {setTimeout("Func1()", 60000);}</script>
 </head>
<body style="direction:rtl;">
    <form id="form1" runat="server">
    <div>
		<h1>דימוי תקלות</h1>
		<asp:Button runat="server" ID="BTNsql" Text="תקלה בפניה לבסיס הנתונים" /><br />
		<asp:Button runat="server" ID="btnSession" Text="ניתוק בגלל טיימטאאוט או תקלה שמנתקת" /> 
   </div>
    </form>
</body>
</html>
