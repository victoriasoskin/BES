<%@ Control Language="VB" AutoEventWireup="false" CodeFile="PageHeader.ascx.vb" Inherits="PageHeader" %>
<style type="text/css">
    .h1 
    {
        font-size:xx-large;
        font-weight:bolder;
        padding-right:10px;
    } 
	.style1
	{
	}
</style>
<div dir="rtl" style="width:100%">
	<table  runat="server" style="width:100%" id="tblhdrx" >
		<tr>
			<td style="width:40px;">
				<input runat="server" id="btnbck" value="סגור" onclick="" type="button" /> 
			</td>
			<td style="text-align:center;" class="style1">
					<asp:Label runat="server" ID="lblhdr" Text="" CssClass="h1"  />
			</td>
			<td style="width:200PX;">
				<table style="float:left;">
					<tr>
						<td style="max-width:70px;padding-left:5px;text-align:right;">
							תאריך:
						</td>
						<td style="max-width:50px;padding-left:5px;text-align:right;">
							<asp:Label runat="server" ID="lblDate" />
						</td>
					</tr>
					<tr>
						<td style="max-width:70px;padding-left:5px;;text-align:right;">
							שם משתמש:
						</td>
						<td style="max-width:50px;padding-left:5px;text-align:right;">
							<asp:Label runat="server" ID="lblUsername" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<hr />
</div>
