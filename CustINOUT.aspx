<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CustINOUT.aspx.vb" Inherits="CustINOUT" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="font-size:Large;font-family:Arial;" >
        פירוט פעולות לקוח
        <input type="button" value="סגור" onclick="window.open('', '_self', '');window.close();" style="float:left;" />
    </div>
    <div>
            <asp:GridView runat="server" ID="GVINOUT" DataSourceID="DSINOUT" 
                AutoGenerateColumns="False" CellPadding="4" > 
            <Columns>
                <asp:BoundField HeaderText="מסגרת" DataField="FrameName" />
                <asp:BoundField HeaderText="פעולה" DataField="CusteventTypeName" />
                <asp:BoundField HeaderText="תאריך" DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" />
                <asp:BoundField HeaderText="הערה" DataField="CustEventComment" />
            </Columns>
            <RowStyle Wrap="false" Font-Names="Arial" />
            <AlternatingRowStyle Wrap="false"  Font-Names="Arial" />
                    
        </asp:GridView>

    </div>
    <asp:SqlDataSource ID="DSINOUT" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT Framename,CustEventTypeName,CustEventDate,CustEventComment
  FROM CustEventList e
  LEFT OUTER JOIN CustEventTypes t ON t.CustEventTypeID=e.CustEventTypeID 
  LEFT OUTER JOIN FrameList f ON f.FrameID=e.CustFrameID
  WHERE e.CustEventTypeID in (1,2) AND CustomerID = @CustomerID
ORDER BY CustEventDate">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="C" />
        </SelectParameters>
    </asp:SqlDataSource>
    </form>
</body>
</html>
