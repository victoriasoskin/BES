<%@ Page Title="" Language="VB" MasterPageFile="~/Surveys.master" AutoEventWireup="false" CodeFile="SurveyE.aspx.vb" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="reldiv">
	<div class="hdrdiv">
		כניסה להזנת סקרים
	</div>
	<div>
		<table>
			<tr>
				<td colspan="2" align="center">
					<asp:RadioButtonList ID="rblsurvey" runat="server" DataSourceID="dssurvey"  
						DataTextField="Survey" DataValueField="XMLFile">
					</asp:RadioButtonList>
					<asp:SqlDataSource ID="dssurvey" runat="server" 
						ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
						SelectCommand="SELECT Surveys.Survey, Surveys.SurveyID, Surveys.XMLFile FROM SurveyTypes RIGHT OUTER JOIN SurveyGroups ON SurveyTypes.SurveyTypeID = SurveyGroups.SurveyTypeID RIGHT OUTER JOIN Surveys ON SurveyGroups.SurveyGroupID = Surveys.SurveyGroupID WHERE (SurveyGroups.SurveyTypeID = 3)">
					</asp:SqlDataSource>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				
					<asp:Button ID="Button1" runat="server" Text="סקר" />
				
				</td>
			</tr>
			</table>
	</div>
</div>
</asp:Content>


