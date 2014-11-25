<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ge.aspx.vb" Inherits="ge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="reldiv">
<div class="hdrdiv">
	<asp:Label runat="server" ID="aed" text="שגיאת מערכת" Font-Bold="true" Font-Size="XX-Large" Width="700"/>
</div>
<div class="phdrdiv">
<br /><br />
לצערנו, המערכת נתקלה בשגיאה. התקלה נרשמה, והיא תטופל. 
ניתן להמשיך לעבוד.<br /><br />
אם הבעיה חוזרת, נא להתקשר ל 050-7242664 לאריאל.
<asp:HyperLink runat="server" Text="לאתר בית אקשטיין" NavigateUrl="http://www.be.org.il" Visible="false" ID="hlsurvey" />
</div>
</div>
     
</asp:Content>

