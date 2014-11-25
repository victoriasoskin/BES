<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TempltB.aspx.vb" Inherits="Templt1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>תבנית תקציב</title>
</head>
<body dir="rtl">
    <form id="form1" runat="server">
    <div>
        <div style="width:1440px;height:4000px">
<%--    <a href="javascript:window.open('','_self','');window.close();">סגור</a> 
--%>    <a href="javascript:history.back();">חזור</a>
        <iframe runat="server" id="frm" width="1440px" height="3600px" scrolling="auto" onprerender="frm_PreRender" >
        </iframe>
        </div>
    </div>
    </form>
</body>
</html>
