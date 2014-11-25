<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyMNGT.aspx.vb" Inherits="SysTables_SurveyIDMNGT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="reldiv">
		<div class="hdrdiv">
			ניהול סקרים
		</div>
		<div>
			<table>
				<tr>
					<td>
						<div class="phdrdiv">
							רשימת המשתתפים
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<asp:Button ID="btnlist" runat="server" Text="העבר לסקר" />
					</td>
				</tr>
				
			</table>
		</div>

	</div>
</asp:Content>

