﻿<%@ Page Title="" Language="VB" MasterPageFile="~/Surveys.master" AutoEventWireup="false" CodeFile="SessionEnded.aspx.vb" Inherits="SessionEnded" %>

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
		<asp:Label runat="server" ID="lbltk" Text="נותקת מהמערכת עקב אי שימוש, עליך להכנס שנית!" Font-Bold="true" Font-Size="XX-Large" ForeColor="Red" />
		<br />
		<br />
		<asp:HyperLink runat="server" ID="hl" NavigateUrl="http://www.b-e.org.il" Text="אתר בית אקשטיין" />
	</div>
</asp:Content>
