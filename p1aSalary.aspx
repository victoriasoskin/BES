<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="P1aSalary.aspx.vb" EnableEventValidation="false" Inherits="p1aSalary" title="עמידה בתקציב כח אדם" %>
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
         direction:ltr;
         text-align:right;
         white-space:nowrap;
     }
     .td2
     {
         padding:4px 4px 4px 4px;
         direction:ltr;
         text-align:right;
          white-space:nowrap;
    }
     .td3
     {
         background:#DDDDDD;
         padding:4px 4px 4px 4px;
         white-space:nowrap;
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
		style="font-size:small; width:800px;border:2px outset White">
        <div>
            <topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח שכר" ButtonJava=""  />
        </div>
		<div>
        <table><tr><td>
            <table id="tbldef">
                <tr>
					<td style="padding:0px 10px 0px 0px;vertical-align:middle;font-weight:bold;">מסגרת</td>
					<td style="vertical-align:middle;margin:0px;">
						<topyca:TreeDropDown ID="tddFrame" runat="server" InitialText="[בחירת_מסגרת]" TableName="" ValueType="Class" ConnStrName="BEBook10" CategoryID="CategoryID"
						ParentID="Parent" RootCategoryID="1" TextField="Name" itemOrder="itemOrder" OnSelectionChanged="tdd_SelectionChanged" OnPreRender="tdd_PreRender" />
				   </td>
                    <td  style="padding:0px 10px 0px 10px;vertical-align:middle;;font-weight:bold;">
                        תקופה
                    </td>
                    <td>
				        <asp:DropDownList ID="DDLPeriods" runat="server" AutoPostBack="True"
					        DataSourceID="DSPeriods" DataTextField="Period" DataTextFormatString="{0:MMM-yy}"
					        DataValueField="PeriodID" >
				        </asp:DropDownList>
                    </td>
				</tr>
 			</table>
			<div runat="server" id="divcls" visible="false"><button onclick="javascript:window.open('','_self','');window.close();">סגור</button></div>
				<asp:ListView ID="LVREP" runat="server" DataSourceID="DSSALREP">
					<ItemTemplate>
						<tr style="">
							<td class="td3">
								<asp:Label ID="BgtLabel" runat="server" Text='<%# Eval("JobName") %>'  />
							</td>
							<td class="td2">
								<asp:Label ID="MQLabel" runat="server" Text='<%# Eval("MQ","{0:N0}") %>' />
							</td>
							<td class="td1">
								<asp:Label ID="MQBLabel_Q" runat="server" Text='<%# GetColValue("MQB",2) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
							</td>
							<td class="td1">
								<asp:HyperLink ID="MQAHL_Q" runat="server" Text='<%# GetColValue("MQA",3) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>' NavigateUrl='<%# "p1aSalaryAcc.aspx?SP=" & ddlPeriods.SelectedValue & "&EP=" & ddlPeriods.SelectedValue & "&F=" & tddFrame.SelectedValue & "&J=" & if(IsDBNull(Eval("Job_CatID")),0,Eval("Job_CatID"))  %>' />
							</td>
							<td class="td1" style="border-left:1px dotted Black;">
								<asp:Label ID="MQDLabel_Q" runat="server" Text='<%# GetColValue("MQD",4) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
							</td>
							<td class="td1" style="border-right:1px dotted Black;">
								<asp:Label ID="AQBLabel_Q" runat="server" Text='<%# GetColValue("AQB",8) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
							</td>
							<td class="td1">
								<asp:HyperLink ID="AQAHl_Q" runat="server" Text='<%# GetColValue("AQA",9) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>' NavigateUrl='<%# "p1aSalaryAcc.aspx?SP=" & Eval("SPeriodID") & "&EP=" & ddlPeriods.SelectedValue & "&F=" & tddFrame.SelectedValue & "&J=" & if(IsDBNull(Eval("Job_CatID")),0,Eval("Job_CatID")) %>' />
							</td>
							<td class="td1">
								<asp:Label ID="AQDLabel_Q" runat="server" Text='<%# GetColValue("AQD",10) %>'  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
							</td>

						</tr>
					</ItemTemplate>
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" border="0" style="">
							<thead class="">
								<tr runat="server" style="">
									<td class="td1" style="font-weight:bold;text-align:center;">תפקיד</td>
									<td class="td1" style="font-weight:bold;text-align:center;">תקציב מקורי</td>
									<td colspan="3" class="td1" style="font-weight:bold;text-align:center; border-left:1px dotted Black;">
										<asp:Label runat="server" ID="MMQLabel_q" Text="שעות החודש"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td colspan="3" class="td1" style="font-weight:bold;text-align:center;border-right:1px dotted Black;">
										<asp:Label runat="server" ID="AMQLabel_q" Text="שעות מצטבר"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
								</tr>
								<tr>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">&nbsp;</td>
									<td class="td2" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">שעות</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">
										<asp:Label runat="server" ID="HMQBLabel_Q" Text="תקציב"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">
										<asp:Label runat="server" ID="HMQALabel_Q" Text="בפועל"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;border-left:1px dotted Black;">
										<asp:Label runat="server" ID="HMQDLabel_Q" Text="הפרש"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;border-right:1px dotted Black;">
										<asp:Label runat="server" ID="HAQBLabel_Q" Text="תקציב"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">
										<asp:Label runat="server" ID="HAQALabel_Q" Text="בפועל"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
									<td class="td1" style="font-weight:bold;text-align:center;border-bottom:1px dotted Black;">
										<asp:Label runat="server" ID="HAQDLabel_Q" Text="הפרש"  OnLoad="TD_Load" Font-Bold='<%#bBold() %>'/>
									</td>
								</tr>
							</thead>
							<tr ID="itemPlaceholder" runat="server">
							</tr>
							<tr>
								<td style="font-weight:bold;">סה&quot;כ</td>
								<td></td>
								<td style="direction:ltr;text-align:right;"><asp:Label runat="server" ID="lblF2" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
								<td style="direction:ltr;text-align:right;"><asp:Label runat="server" ID="lblF3" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
								<td style="direction:ltr;text-align:right; border-left:1px dotted Black;"><asp:Label runat="server" ID="lblF4" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
								<td style="direction:ltr;text-align:right; border-right:1px dotted Black;"><asp:Label runat="server" ID="lblF8" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
								<td style="direction:ltr;text-align:right;"><asp:Label runat="server" ID="lblF9" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
								<td style="direction:ltr;text-align:right;"><asp:Label runat="server" ID="lblF10" OnPreRender="lbl_PreRender" Font-Bold="true" /></td>
							</tr>
						</table>
					</LayoutTemplate>
				</asp:ListView>
</td></tr></table>
			</div>
 
     <asp:SqlDataSource ID="DSSALREP" runat="server" 
				ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" CancelSelectOnNullParameter="False"
        SelectCommand="SL_pSalary" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLPeriods" Name="PeriodID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:ControlParameter ControlID="tddFrame" Name="Frm_CatID" PropertyName="SelectedValue"
                Type="Int32" DefaultValue="0" />
            <asp:Parameter DefaultValue="229" Name="Bgt_CatID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
	<asp:SqlDataSource ID="DSPeriods" runat="server" 
				ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
				SelectCommand="SELECT PeriodID, Period FROM p0t_Periods WHERE (Period BETWEEN DATEADD(month, - 22, GETDATE()) AND DATEADD(month, 12, GETDATE())) ORDER BY Period DESC"></asp:SqlDataSource>

</div>
      <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" /><asp:Button runat="server" ID="btnTwo" Text="ביטול" CausesValidation="false" Visible="false" />
    </div>

</asp:Content>

