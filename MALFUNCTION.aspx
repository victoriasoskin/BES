<%@ Page Title="" Language="VB" MasterPageFile="~/Surveys.master" AutoEventWireup="false" CodeFile="MALFUNCTION.aspx.vb" Inherits="MALFUNCTION" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.msgtks
		{
			top:300px;
			text-align:center;
		} 
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="msgtks">
		<asp:Label runat="server" ID="lbltk" 
			Text="לצערנו ארעה תקלה במערכת - אך הנתונים לא אבדו!" Font-Bold="True" 
			Font-Size="XX-Large" ForeColor="Red" /><br /> 
		<asp:Label runat="server" ID="lbltl" 
			Text="אנא היכנס\י שנית למערכת" Font-Bold="True" 
			Font-Size="X-Large" ForeColor="Red" />
			<br/><br />
<asp:Label runat="server" ID="lbltl2" 
			Text="הודעה נשלחה לצוות התמיכה" Font-Bold="True" 
			Font-Size="X-Large" ForeColor="Red" />			
			
		<br />
		<br />
		<asp:HyperLink runat="server" ID="hl" NavigateUrl="http://www.b-e.org.il" Text="אתר בית אקשטיין" />
	</div>
</asp:Content>

