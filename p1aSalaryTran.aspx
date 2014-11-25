<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p1aSalaryTran.aspx.vb" Inherits="p1aSalaryTran" %>
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
	<asp:SqlDataSource ID="DSPeriods" runat="server" 
				ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
				SelectCommand="SELECT PeriodID, Period FROM p0t_Periods WHERE (Period BETWEEN DATEADD(month, - 22, GETDATE()) AND DATEADD(month, 12, GETDATE())) ORDER BY Period DESC"></asp:SqlDataSource>    <asp:SqlDataSource ID="DSBgt" runat="server" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT [Name], [CategoryID] FROM [Categories_besqxl] WHERE ([Parent] = @CategoryID) ORDER BY [ItemOrder]">
		<SelectParameters>
			<asp:Parameter DefaultValue="49" Name="CategoryID" Type="Int32" />
		</SelectParameters>
	</asp:SqlDataSource>
    <asp:SqlDataSource ID="DSTRANS" runat="server"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		
		SelectCommand="SL_pSalaryTrans" 
		CancelSelectOnNullParameter="False" SelectCommandType="StoredProcedure" 
		DeleteCommand="DELETE FROM SL_AddSalTrans WHERE RowID = @RowID">
		<DeleteParameters>
			<asp:Parameter Name="RowID" />
		</DeleteParameters>
		<SelectParameters>
			<asp:QueryStringParameter Name="SPeriodID" QueryStringField="SP" Type="Int32" />
			<asp:QueryStringParameter Name="EPeriodID" 	QueryStringField="EP" Type="Int32" />
			<asp:QueryStringParameter Name="AccountKey" QueryStringField="A" Type="Int64" />
			<asp:QueryStringParameter Name="Frm_CatID" QueryStringField="F" Type="Int32" />
			<asp:QueryStringParameter Name="Bgt_CatID" QueryStringField="B" Type="Int32" />
			<asp:QueryStringParameter Name="Job_CatID" QueryStringField="J" Type="Int32" DefaultValue="0" />
		</SelectParameters>
	</asp:SqlDataSource>
			<asp:SqlDataSource ID="DSJobs" runat="server" 
                        CancelSelectOnNullParameter="False" 
                        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
                    SelectCommand="SELECT Name, CategoryID FROM Categories_besqxl WHERE (CategoryID IN (SELECT DISTINCT Job_CatID FROM SL_vBudget WHERE (Frm_CatID = @Frm_CatID) AND (PeriodID = @PeriodID)))
ORDER BY ItemOrder">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="Frm_CatID" QueryStringField="F" />
						<asp:QueryStringParameter Name="PeriodID" QueryStringField="EP" />
                    </SelectParameters>
                </asp:SqlDataSource>
			<asp:SqlDataSource ID="DSJobs_C" runat="server" 
                        CancelSelectOnNullParameter="False" 
                        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
                    SelectCommand="SELECT Name, CategoryID FROM Categories_besqxl WHERE (CategoryID IN (SELECT DISTINCT Job_CatID FROM SL_vBudget WHERE (Frm_CatID = ISNULL(@Frm_CatID,0)) AND (PeriodID = @PeriodID)))
ORDER BY ItemOrder">
                    <SelectParameters>
                        <asp:Parameter Name="Frm_CatID" DefaultValue="0" />
						<asp:QueryStringParameter Name="PeriodID" QueryStringField="EP" />
                    </SelectParameters>
                </asp:SqlDataSource>
    <div>
        <topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח שכר - פירוט תנועות" ButtonJava="" />
		<input  value="סגור" type="button" onclick="history.back();" />
    </div>
	<div>
		<table style="width:100%"><tr><td>
			<div runat="server" id="divcls" visible="false"><button onclick="javascript:window.open('','_self','');window.close();">סגור</button></div>
			<div id="divlv">
				<asp:ListView runat="server" ID="lvTrans" DataSourceID="DSTrans" DataKeyNames="RowID" >
				<EmptyDataTemplate>אין נתונים להצגה</EmptyDataTemplate>
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" style="">
							<thead>
								<tr>
									<td colspan="2" style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										מסגרת
									</td>
									<td colspan="5" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblFrm" />
									</td>
									<td style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										מתקופה
									</td>
									<td style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblSPeriod" />
									</td>
								</tr>
								<tr>
									<td colspan="2" style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										תקציב
									</td>
									<td colspan="5" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblbgt" />
									</td>
									<td style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										עד תקופה
									</td>
									<td style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblEPeriod" />
									</td>
								</tr>
								<tr>
									<td colspan="2" style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										תפקיד
									</td>
									<td colspan="5" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblJob"  />
									</td>
									<td>
									</td>
									<td>
									</td>
								</tr>
								<tr>
									<td colspan="2" style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										שם עובד
									</td>
									<td colspan="5" style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblAccountName" />
									</td>
									<td style="font-weight:bold;text-align:right;padding:4px 4px 4px 4px;">
										מספר עובד
									</td>
									<td style="background-color:#DDDDDD;padding:4px 4px 4px 4px;">
										<asp:Label runat="server" ID="lblAccountKey" />
									</td>
								</tr>
								<tr style="font-weight:bold;text-align:center;height:30px;padding:4px 4px 4px 4px;">
									<td>
										<asp:Label runat="server" ID="lblTPeriod" Text="תקופה" OnPreRender="lblPeiod_PreRenter" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbAccountKey" Text="מספר" CommandName="sort" CommandArgument="AccountKey" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbAccountName" Text="שם" CommandName="sort" CommandArgument="AccountName" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbComponentID" Text="מספר רכיב" CommandName="sort" CommandArgument="ComponentID" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbComponentName" Text="רכיב" CommandName="sort" CommandArgument="ComponentName" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbDetails" Text="פרטים" CommandName="sort" CommandArgument="Details" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbQ" Text="שעות" CommandName="sort" CommandArgument="Q" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbJob_CatID" Text="תפקיד" CommandName="sort" CommandArgument="Job_CatID" />
									</td>
									<td>
										<asp:linkbutton runat="server" ID="lnkbFrm_CatID" Text="מסגרת" CommandName="sort" CommandArgument="Frm_CatID" />
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
								<td>
								</td>
								<td>
								</td>
								<td>
								</td>
								<td  style="text-align:right;direction:ltr;">
									<asp:Label runat="server" ID="lblQF_1" OnPreRender="lnkb_PreRender"  />
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
								<asp:Label runat="server" ID="lblPeriod" Text='<%#Eval("Period","{0:MMM-yy}") %>'  />
								<asp:HiddenField runat="server" ID="hdnSourceID" Value='<%# Eval("SourceID") %>' />
								<asp:HiddenField runat="server" ID="hdnRowID" Value='<%# Eval("RowID") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblAccountKey" Text='<%#Eval("AccountKey") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblAccountName" Text='<%#Eval("AccountName") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblComponentID" Text='<%#Eval("ComponentID") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblComponentName" Text='<%#Eval("ComponentName") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblDetails" Text='<%#Eval("Details") %>' />
							</td>
							<td style="text-align:right;direction:ltr;">
								<asp:Label runat="server" ID="lblQ" Text='<%#sVal("Q",1) %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblJob" Text='<%#Eval("Job") %>' />
							</td>
							<td style="padding:4px 4px 4px 4px;">
								<asp:Label runat="server" ID="lblFrame" Text='<%#Eval("Frame") %>' />
							</td>
						</tr>
					</ItemTemplate>
					<EditItemTemplate>
						<td>
						</td>
					</EditItemTemplate>
				</asp:ListView>
	
			</div>
		</td></tr></table>
	</div>
</div>
</asp:Content>

