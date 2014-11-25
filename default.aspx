<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" Title="בית אקשטיין - דף ראשי" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 		<div id="DIV1" runat="server" style="position:relative;top:0px;right:0px;font-size: smaller; font-family: Arial;direction:rtl;width:100%;height:768px; background-image:url('images/be002X.jpg');background-repeat:no-repeat;background-position:right top">
   <div style="position:relative;top:0px;right:0px;">
        <table>
            <tr>
                <td align="right" style="width: 100px" valign="top" rowspan="2">
                    <asp:Label ID="Label4" runat="server" Width="50px"></asp:Label>
                </td>
                <td align="right" style="width: 100px" valign="top" rowspan="2">
                    <asp:Label ID="Label3" runat="server" Height="464px"></asp:Label>
                </td>
                <td align="right" style="width: 400px" valign="top" colspan="2">

                    <asp:Label ID="LBLSPeCIAL" runat="server" Width="434px" ForeColor="Blue"
                        Font-Bold="True" Font-Size="Large" BackColor="LightGray" Visible="false" 
                        Text=""></asp:Label>
                </td>
                <td align="right" style="width: 100px" valign="top" rowspan="2"></td>
            </tr>
            <tr>
                <td align="right" style="width: 400px" valign="top">
                    <br />
                    <asp:Label ID="LBLLICALERT" runat="server" Width="379px" ForeColor="Red" Font-Bold="true" Font-Size="Large"></asp:Label><br />
                    <asp:Label ID="LBLFFALERT" runat="server" Width="379px" ForeColor="Red" Font-Bold="true" Font-Size="Large"></asp:Label>
                </td>
                <td align="right" style="width: 400px" valign="top">
                    <br />

                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td align="right" style="width: 100px" valign="top">&nbsp;</td>
                <td align="right"
                    style="width: 100px; font-family: Gungsuh; font-weight: 700; text-decoration: underline; font-size: medium"
                    valign="top">
                    <asp:HyperLink ID="hle" runat="server" Visible="false"
                        NavigateUrl="cEventExpiration.aspx?l=4" ForeColor="white">יש פעולות שפג תוקפן, או עומד לפוג בקרוב</asp:HyperLink>

                    <br />
                </td>
                <td align="right" style="width: 177px" valign="top">&nbsp;</td>
                <td align="right" style="width: 100px" valign="top">&nbsp;</td>
            </tr>
            <tr>
                <td align="right" style="width: 100px" valign="top">&nbsp;</td>
                <td align="right" style="width: 100px" valign="top">&nbsp;</td>
                <td align="right" style="width: 177px" valign="top">
                    <br />
                    <br />
                </td>
                <td align="right" style="width: 100px" valign="top"></td>
            </tr>
        </table>
        <asp:Button runat="server" ID="btnh" Text="M" Visible="false" />
        <div style="position: fixed; left: 0px; top: 0px;background-color:white;">
            <p style="color: Blue; width: 152px;">
                <asp:Label ID="Label7" runat="server" Text="חדשות והודעות" Font-Bold="True"
                    Font-Size="Medium" Font-Underline="True"></asp:Label><br />
             <asp:HyperLink runat="server" ID="hlguide" NavigateUrl="~/App_News/מדריך למשתמש.pdf" Text="מדריך למשתמש" Target="_blank" />
           </p>
            <iframe id="I1" runat="server" height="600px" scrollrars="vertical"
                style="font-weight: 700; font-family: @Arial Unicode MS; width: 251px;"
                src="App_News/News.htm" name="I1"></iframe>
        </div>
        <div style="position:absolute;top:520px;left:220px;">
                                <asp:Label ID="Label5" runat="server" Text="במקרה של תקלה יש לפנות לויקטוריה סוסקין<br/>טלפון: 050-7628378 בשעות העבודה<br/> או במייל לכתובת:<br/> "
                        Width="135px" /><br />
                    <asp:HyperLink ID="HyperLink2" runat="server" Width="120px"
                        NavigateUrl="mailto:victoria.s@b-e.org.il" Height="22px">victoria.s@b-e.org.il</asp:HyperLink>
                    <br />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="http://www.logmein123.com"
                        Width="195px">קישור לקבלת תמיכה מרחוק</asp:HyperLink>

        </div>

    </div>
    </div>
</asp:Content>

<%--And (SurveyID = 8) AND (LEN(t.TextDET) > 0) AND (a.FrameID = ISNULL(@FrameID, a.FrameID)) AND (fl.ServiceID = @ServiceID) And (t.QuestionID=@QuestionID)
--%>
