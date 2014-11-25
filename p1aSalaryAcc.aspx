<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p1aSalaryAcc.aspx.vb" Inherits="p1aSalaryAcc" %>
<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="Controls/TreeDropDown.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="Controls/PageHeader.ascx"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<link href="App_Themes/master.css" rel="stylesheet" type="text/css" />
<style type="text/css">
	thead td
	{
	    background-color:#CDCDCD;
	}
    .lstv
    {
        background-color: #FFFFFF;
        border-color: #999999;
        border-style:none;
        border-width:1px; 
        font-family: Arial;
    }
    .lstv td
    { padding:4px 4px 4px 4px;
      white-space:nowrap;
      border:1px dotted Gray;
      text-align:right;
    }
    .lpgblk
    {
        width:100%;
     }
     .gvc
     {
         border: none;
     }
     .td1
     {
         background:#DDDDDD;
         padding:4px 4px 4px 4px;
     }
     .td2
     {
         padding:4px 4px 4px 4px;
     }
	</style>

<script src="App_Script/jquery-1.7.1.js" type="text/javascript"></script>
<script src="App_Script/BER.js" type="text/javascript" />

<script  type="text/javascript">
	$(document).ready(function () {
		scrolify($('#itemPlaceholderContainer'), $('#divlv'), 160, 104); // 160 is height     
	});
	function frow() {
		alert(this.Type);
	}
 </script>
<asp:ScriptManager runat="server" ID="SCRIPT1"></asp:ScriptManager>
<div runat="server" id="divform" class="pg" 
	style="font-size:small;width:800px;border:2px outset White;">
    <asp:SqlDataSource ID="DSACT" runat="server" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		
		SelectCommand="SL_pSalaryAcc" SelectCommandType="StoredProcedure" 
		CancelSelectOnNullParameter="False">
		<SelectParameters>
			<asp:QueryStringParameter Name="SPeriodID" QueryStringField="SP" Type="Int32" />
			<asp:QueryStringParameter Name="EPeriodID" QueryStringField="EP" Type="Int32" />
			<asp:QueryStringParameter Name="Frm_CatID" QueryStringField="F" Type="Int32" />
			<asp:QueryStringParameter Name="Bgt_CatID" QueryStringField="B" Type="Int32" DefaultValue="" />
			<asp:QueryStringParameter Name="Job_CatID" QueryStringField="J" Type="Int32" DefaultValue="" />
			<asp:QueryStringParameter Name="AccountKey" QueryStringField="A" Type="Int64" DefaultValue="" />
			<asp:QueryStringParameter Name="Incompat" QueryStringField="i" Type="Int32" 
				DefaultValue="0" />
		</SelectParameters>
	</asp:SqlDataSource>
			<asp:SqlDataSource ID="DSJobs" runat="server" 
                        CancelSelectOnNullParameter="False" 
                        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
                    SelectCommand="SELECT Name AS Job, CategoryID AS job_CatID FROM Categories_besqxl WHERE (CategoryID IN (SELECT DISTINCT Job_CatID FROM SL_vBudget WHERE (Frm_CatID = @Frm_CatID) AND (PeriodID = @PeriodID)))
ORDER BY  ItemOrder">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Frm_CatID" QueryStringField="F" />
						<asp:QueryStringParameter Name="PeriodID" QueryStringField="EP" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <div>
        <topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח שכר - פירוט עובדים" ButtonJava="" />
		<asp:Button runat="server" ID="btncls" Text="סגור" PostBackUrl="~/p1aSalary.aspx" />
    </div>
	<div>
		<table><tr><td>
			<div runat="server" id="divcls" visible="false"><button onclick="javascript:window.open('','_self','');window.close();">סגור</button></div>
			<div id="divlv">
				<asp:ListView runat="server" ID="lvACT" DataSourceID="DSACT" >
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" style="padding:4px 4px 4px 4px;" >
							<thead>
								<tr style="padding:4px 4px 4px 4px;" >
									<td colspan="1" style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										מסגרת
									</td>
									<td colspan="3" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblFrm" />
									</td>
									<td style="font-weight:bold;padding:4px 4px 4px 4px;">
										מתקופה
									</td>
									<td style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblSPeriod" />
									</td>
								</tr>
								<tr>
									<td colspan="1" style="font-weight:bold;padding:4px 4px 4px 4px;">
										תפקיד
									</td>
									<td colspan="3" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblJob"  />
									</td>
									<td style="font-weight:bold;padding:4px 4px 4px 4px;">
										עד תקופה
									</td>
									<td style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblEPeriod" />
									</td>
								</tr>
								<tr style="font-weight:bold;text-align:center;height:30px;padding:4px 4px 4px 4px;">
									<td>
										<asp:Label runat="server" ID="lblPeriod" Text="תקופה" OnPreRender="lblPeiod_PreRenter" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbAccountKey" Text="מספר" CommandName="sort" CommandArgument="AccountKey" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbAccountName" Text="שם" CommandName="sort" CommandArgument="AccountName" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbQ" Text="שעות" CommandName="sort" CommandArgument="Q" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbJob" Text="תפקיד" CommandName="sort" CommandArgument="Job" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbFrame" Text="מסגרת" CommandName="sort" CommandArgument="Frame" />
									</td>
								</tr>
							</thead>
							<tr ID="itemPlaceholder" runat="server">
							</tr>
								<tr style="font-weight:bold;padding:4px 4px 4px 4px;">
									<td>
										סה"כ
									</td>
									<td>
										
									</td>
									<td>
										
									</td>
									<td  style="text-align:right;direction:ltr;">
										<asp:Label runat="server" ID="lblQ_F1" OnPreRender="lnkb_PreRender" />
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
						</table>
					</LayoutTemplate>
					<ItemTemplate>
						<tr style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
							<td style="padding:4px 4px 4px 4px;">
								<asp:HiddenField runat="server" ID="hdnCnt" Value='<%#Eval("Cnt") %>' />
								<asp:HiddenField runat="server" ID="hdnSourceID" Value='<%# Eval("SourceID") %>' />
								<asp:HyperLink runat="server" ID="hlPeriod" Text='<%#Eval("Period","{0:MMM-yy}") %>' NavigateUrl='<%# "p1aSalaryTran.aspx?A=" & Eval("AccountKey") & "&SP=" & IF(isDBNull(Eval("PeriodID")),Request.QueryString("SP"),Eval("PeriodID")) & "&EP=" & IF(isDBNull(Eval("PeriodID")),Request.QueryString("EP"),Eval("PeriodID")) & "&F=" & Request.QueryString("F") & if(Request.QueryString("b")=vbNullstring,vbNullString,"&B=" & Request.QueryString("B")) & "&J=" & If(Request.QueryString("J") = vbNullString,Eval("Job_CatID"),Request.QueryString("J"))  %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:HyperLink runat="server" ID="hlAccountKey" Text='<%#Eval("AccountKey") %>' NavigateUrl='<%# IF(IsDBNull(Eval("Period")),"p1aSalaryAcc.aspx?A=" & Eval("AccountKey") & "&F=" & Request.QueryString("F") & "&SP=" & Request.QueryString("SP") & "&EP=" & Request.QueryString("EP") & "&J=" & Request.QueryString("J") & "&B=" & Request.QueryString("B"),vbNullString)  %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblAccountName" Text='<%#Eval("AccountName") %>' />
							</td>
							<td style="text-align:right;direction:ltr;padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblQ" Text='<%#sVal("Q",1) %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblJob" Text='<%#Eval("Job") %>'  ForeColor='<%#If(IsdbNull(Eval("LJob_CatID")),Drawing.Color.Red,Drawing.Color.Black) %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblFrame" Text='<%#Eval("Frame") %>' />
								<asp:HiddenField runat="server" ID="hdnFrameID" Value='<%#Eval("Frm_CatID") %>' />
							</td>
						</tr>
					</ItemTemplate>
				</asp:ListView>
			</div>
		</td></tr></table>
	</div>
</div>

<asp:SqlDataSource ID="DSBgt" runat="server" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT [Name], [CategoryID] FROM [Categories_besqxl] WHERE ([Parent] = @CategoryID) ORDER BY [ItemOrder]">
		<SelectParameters>
			<asp:Parameter DefaultValue="49" Name="CategoryID" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
	
</asp:Content>

