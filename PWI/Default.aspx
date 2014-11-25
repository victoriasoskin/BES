<%@ Page Title="Home Page" Language="C#" MasterPageFile="Site.master" AutoEventWireup="true" Inherits="WebPWI1._Default" CodeBehind="Default.aspx.cs" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
    <style type="text/css">
        .rbl td {
            padding-right: 10px;
        }
    </style>
    <script type="text/javascript">
        function alertSize() {
            var myWidth = 0, myHeight = 0;
            if (typeof (window.innerWidth) == 'number') {
                //Non-IE
                alert('nonie');
                myWidth = window.innerWidth;
                myHeight = window.innerHeight;
                document.getElementById('<%= height.ClientID %>').value = myHeight;

            } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
                //IE 6+ in 'standards compliant mode'
                myWidth = document.documentElement.clientWidth;
                myHeight = document.documentElement.clientHeight;
                document.getElementById('<%= height.ClientID %>').value = myHeight;
             } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
                 //IE 4 compatible
                 myWidth = document.body.clientWidth;
                 myHeight = document.body.clientHeight;
                 document.getElementById('<%= height.ClientID %>').value = myHeight;

             }
 }
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:HiddenField ID="width" runat="server" />
    <asp:HiddenField ID="height" runat="server" />
    <div runat="server" id="divFrame">
        <h3>פרטי הלקוח</h3>
        <asp:Label runat="server" ID="lblOno" Text="מלא רק את ת.ז. הלקוח, ולחץ על הכפתור: שלוף ממאגר<br />המערכת תתקשר למאגר בית אקשטיין ותציג הנתונים כפי ששמורים שם"
            OnPreRender="lblOno_PreRender" />
        <table>
            <tr>
                <td>ת.ז. הלקוח
                </td>
                <td>
                    <input name='CustomerID' type='text' value="<%= this.CustomerID %>" <%=(Request.QueryString["ID"]==null ? string.Empty : "disabled=''") %> />
                </td>
                <td>
                    <asp:Button ID='Button1' OnClick='Button1_Click' Text='שלוף ממאגר' runat='server' Height="26px" Width="97px" OnPreRender="btnRetr_PreRender" />
                </td>
                <td>
                    <asp:Label ID="ErrorMsg" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>שם
                </td>
                <td colspan="3">
                    <input type="text" class="data" name="CustomerName" value="<%= this.CustomerName %>" title="שם:" <%=(Request.QueryString["ID"]==null ? string.Empty : "disabled=''") %> />
                </td>
            </tr>
            <tr>
                <td>מין
                </td>
                <td colspan="3">
                    <input type="text" class="data" name="CustomerGender" value="<%= this.CustomerGender %>" title="מין" <%=(Request.QueryString["ID"]==null ? string.Empty : "disabled=''") %> />
                </td>
            </tr>
            <tr>
                <td>תאריך לידה
                </td>
                <td colspan="3">
                    <input type="text" class="data" name="CustomerBirthDate" value="<%= this.CustomerBirthDate %>" title="תאריך לידה" <%=(Request.QueryString["ID"]==null ? string.Empty : "disabled=''") %> />
                </td>
            </tr>
        </table>
        <hr />
        
        <label for="CustomerMood">מצב רוח כללי </label>
        <asp:DropDownList ID="DropDownList1" runat="server" Height="20px">
            <asp:ListItem Selected="True" Value="1">טוב</asp:ListItem>
            <asp:ListItem Value="0">ירוד</asp:ListItem>
            <asp:ListItem Value="2">לא מותאם</asp:ListItem>
        </asp:DropDownList>
        <input type="text" class="data" name="CustomerMood" title="מצב רוח כללי תאור במלל חופשי" />
        <hr />
        <span style="font-size:medium;font-weight:bold;">התאמת השאלון לצרכי הלקוח </span>
        <table>
            <tr>
                <td style="vertical-align: top;">
                    <asp:RadioButtonList
                        ID="RadioButtonList2" runat="server" RepeatColumns="2" RepeatDirection="Vertical" RepeatLayout="Table" CssClass="rbl">
                        <asp:ListItem Selected="True" Value="PreTest2.aspx">שאלון מקדים 2 פרצופים</asp:ListItem>
                        <asp:ListItem Value="PreTest3.aspx">שאלון מקדים 3 פרצופים</asp:ListItem>
                        <asp:ListItem Value="PreTest5.aspx">שאלון מקדים 5 פרצופים</asp:ListItem>
                        <asp:ListItem Value="" Enabled="false"></asp:ListItem>
                        <asp:ListItem Value="Test2.aspx">שאלון 2 פרצופים</asp:ListItem>
                        <asp:ListItem Value="Test3.aspx">שאלון 3 פרצופים</asp:ListItem>
                        <asp:ListItem Value="Test5.aspx">שאלון 5 פרצופים</asp:ListItem>
                        <asp:ListItem Value="Test10.aspx">שאלון סקלה 10</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
                <td style="vertical-align: top; padding-right: 20px; padding-top: 4px;">סוג השאלון:
                </td>
                <td style="vertical-align: top; padding-right: 10px; padding-top: 4px;">&nbsp;
                    <asp:Label runat="server" ID="lblQtype" Text="שאלון לתחום דיור" />
                </td>
            </tr>
        </table>
        <span style="font-size:medium;font-weight:bold;">הצגת השאלות בשאלון </span>
        <table>
            <tr>
                <td>
                    <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="rbl" RepeatDirection="Horizontal" RepeatLayout="Table">
                        <asp:ListItem Value="1">מלל בלבד</asp:ListItem>
                        <asp:ListItem Value="2">הקראה בלבד</asp:ListItem>
                        <asp:ListItem Value="3" Selected="True">מלל והקראה</asp:ListItem>
                    </asp:RadioButtonList>

                </td>
                <td style="padding-right:20px;">
                    <asp:Button ID="Button2" runat="server" Text="התחל" OnClick='Next_Click' />
                </td>
                <td style="padding-right:40px;">
                    <asp:Button ID="Button3" runat="server" Text="חזרה למערכת הניהול" PostBackUrl="~/CustEventReport.aspx" />
<%--        <asp:Label runat="server" ID="lblBrowser" OnPreRender="prsr_PreRender" ForeColor="Transparent"></asp:Label>--%>

                </td>
            </tr>
        </table>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
</asp:Content>

