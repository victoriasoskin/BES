<%@ Page Title="" Language="VB" MasterPageFile="~/EmptyNPB.master" AutoEventWireup="false" CodeFile="FormEditor.aspx.vb" Inherits="FormEditor" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" validateRequest="false" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
--%><%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.edt
		{
		    text-align:right;
		}
		.btn
		{
		    white-space:normal;text-decoration:none;color:Black; 
		}
		.wp1 {width:15%;} .wp2 {width:25%;} .wp3 {width:40%;} .wp4 {width:20%;}
		.ansprint {} 
	</style>
<script type="text/ecmascript">
//To cause postback "as" the Button
//	function PostBackOnMainPage(){
//		<%=GetPostBackScript()%>
//	}       
	function popup(url) {
            params = 'width=' + screen.width;
            params += ', height=' + screen.height;
            params += ', top=0, left=0'
            params += ', fullscreen=yes';

            newwin = window.open(url, 'windowname4', params);
            if (window.focus) { newwin.focus() }
            return false;
        }
    function DoPrint()
    {
        document.all("PRINT").style.visibility = "hidden";
//        document.all("tdbtn0").style.visibility = "hidden";
//        document.all("tdbtn1").style.visibility = "hidden";
//        document.all("tdbtn2").style.visibility = "hidden";
//        
        document.execCommand('print', false, null);
        document.all("PRINT").style.visibility = "visible";
//        document.all("tdbtn0").style.visibility = "visible";
//        document.all("tdbtn1").style.visibility = "visible";
//        document.all("tdbtn2").style.visibility = "visible";

	}
	function myPrint() {

        document.printing.leftMargin = 1.0;

        document.printing.topMargin = 1.0;

        document.printing.rightMargin = 1.0;

        document.printing.bottomMargin = 1.0;

        document.printing.portrait = false;

        document.execCommand('print', false, null); // print without prompt
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<%--	<asp:ToolkitScriptManager runat="server">
</asp:ToolkitScriptManager>
--%><div runat="server" id="divform" class="pg">
<div onscroll="alert(this.scrollTop);" >
<topyca:pageheader runat="server" ID="PageHeader1" Header="הערכת עובד 2012" ButtonJava="" />
<div runat="server" id="divbuttons" style="position:fixed;top:65px;right:750px;">
	<table style="text-align:center;">
		<tr>
			<td>
				<asp:Label runat="server" ID="lblEventID" BackColor="#EEEEEE" BorderColor="#DDDDDD" BorderStyle="Ridge" />
			</td>
		</tr>
		<tr>
			<td>
				<asp:ImageButton runat="server" ID="btnWord" CausesValidation="false" ToolTip="העברה לוורד"
					Width="35px" Height="35px"  ImageUrl="~/images/Microsoft-Word-icon.png" />
			</td>
		</tr>
		<tr>
			<td>
				<asp:ImageButton runat="server" ID="btnPrint" CausesValidation="false" ToolTip="הדפסה"
					Width="35px" Height="35px"  ImageUrl="~/images/Print.png" />
			</td>
		</tr>
		<tr>
			<td>
				<asp:Button runat="server" ID="btnBack" CausesValidation="false" 
					Width="35px" Height="35px" Text="חזרה" />
			</td>
		</tr>
	</table>							
</div>

<%--	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="divbuttons" HorizontalOffset="750" VerticalOffset="65" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
--%>	<div id="divheader">
		<asp:ListView runat="server" ID="lvHdr" DataSourceID="DSEmp" >
			<LayoutTemplate>
				<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;">
					<tr ID="itemPlaceholder" runat="server">
					</tr>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr>
					<td>
						<table style="width:100%;font-size:small;">
							<tr>
								<td style="font-weight:bold;width:20%;">
									שם העובד:
								</td>
								<td style="width:30%">
									<%#Eval("EmployeeName")%>
<%--									<asp:HiddenField runat="server" ID="hdnFormHeader" Value='<%#Eval("FormType") & " " & Eval("Name") %>' OnPreRender="hdn_PreRender" />
--%>								</td>
								<td style="font-weight:bold; width:20%;">
									תחילת העסקה:
								</td>
								<td style="width:30%;">
									<%#Eval("StartDate", "{0:dd/MM/yyyy}")%>
								</td>
							</tr>
							<tr>
								<td style="font-weight:bold;">
									מסגרת
								</td>
								<td>
									<%#Eval("FrameName")%>
								</td>
								<td style="font-weight:bold;">
									תפקיד:
								</td>
								<td>
									<%#Eval("JobName")%>
								</td>
							</tr>
							<tr>
								<td style="font-weight:bold;">
									המעריך:
								</td>
								<td>
									<%#Eval("URName")%>
								</td>
								<td style="font-weight:bold;">
									תאריך הראיון:
								</td>
								<td>
									<asp:Button runat="server" ID="btnDate" Text='<%#Eval("EventDate","{0:dd/MM/yyyy}") %>' OnClick="btnDate_Click" />
									<div runat="server" id="divclndr" visible="false" style="text-align:center;position:fixed;">
<%--									<asp:UpdatePanel runat="server" ID="upd"><ContentTemplate>
--%>										<asp:Calendar runat="server" ID="cclndr" OnPreRender="clndr_PreRender" OnSelectionChanged="clndr_SelectionChanged" SelectedDate='<%#Eval("EventDate") %>' BackColor="White" />	
										<asp:Button runat="server" ID="btnSaveDate" Text="אישור" OnClick="btnSaveDate_Click" />
<%--										</ContentTemplate></asp:UpdatePanel>
--%>									</div>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</ItemTemplate>
		</asp:ListView>
	</div>
	<hr />
	<div id="divFormQ">
<%--		<asp:UpdatePanel runat="server" ID="upd"><ContentTemplate>
--%>			<asp:ListView runat="server" ID="lvAnswers" DataSourceID="DSAnswers" ViewStateMode="Disabled" DataKeyNames="FieldID" >
			<LayoutTemplate>
				<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;">
					<tr ID="itemPlaceholder" runat="server">
					</tr>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr runat="server" style="" >
					<td runat="server" style='<%#If(Val("AnswerTypeID")<>0,"border:1px dotted White;",vbnullstring) %>'>
						<table style="width:100%" dir="rtl">
							<tr style="height:20px;"><td colspan="2"></td></tr>
							<tr>
								<td style="width:5%;" rowspan="5">
									<asp:Button runat="server" ID="btnEdit" CommandName="Edit" Text="עריכה" Visible='<%#Val("AnswerTypeID")<>0 And Eval("CanEdit") <> 0 %>' OnClick="btnEdit_Click"  OnPreRender="btnEdit_PreRender" />
								</td>
								<td runat="server" style='<%#Eval("MainTextStyle") %>' >
								<asp:HiddenField runat="server" ID="hdnFieldID" Value='<%#Eval("FieldID") %>' />
									<asp:Label runat="server" ID="lblMainText" Text='<%#Eval("MainText") %>' ViewStateMode="Disabled" />
								</td>
							</tr>
							<tr>
								
								<td runat="server" style='<%#Eval("SubTextStyle") %>'>
									<asp:Label runat="server" ID="lblSubText" Text='<%#Eval("SubText") %>'  Visible='<%#IsEditable() %>' ViewStateMode="Disabled" />
								</td>
							</tr>
							<tr>
								<td style="width:95%;text-align:center;white-space:normal;vertical-align:top;">
									<div runat="server"	id="divrbl" visible='<%#Val("AnswerTypeID")=1 OR Val("AnswerTypeID")=3%>' >
										<table style="width:400px;">
										<tr style="vertical-align:top;background-color:#5088FF;">
											<td runat="server" id="tdt10" style="width:17%">משמעותית מעל הציפיות</td>
											<td runat="server" id="tdt9" style="width:17%">מעל הציפיות</td>
											<td runat="server" id="tdt8" style="width:16%">עומד בציפיות</td>
											<td runat="server" id="tdt7" style="width:16%">מתחת לחלק מהציפיות</td>
											<td runat="server" id="tdt6" style="width:17%">משמעותית מתחת הציפיות</td>
											<td runat="server" id="tdt0" style="width:17%">לא רלוונטי</td>
										</tr>
										<tr style="vertical-align:middle;background-color:#70AAFF;">
											<td runat="server" id="tdn10">10</td>
											<td runat="server" id="tdn9">9</td>
											<td runat="server" id="tdn8">8</td>
											<td runat="server" id="tdn7">7</td>
											<td runat="server" id="tdn6">6</td>
											<td runat="server" id="tdn0">0</td>
										</tr>
										<tr style="vertical-align:middle;background-color:#70AAFF;">
											<td runat="server" id="td10"><asp:Image runat="server" ID="img10" ImageUrl='<%#IF(Eval("Val")=10,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb10" Visible="false" GroupName="grp"  /></td>
											<td runat="server" id="td9"><asp:Image runat="server" ID="img9" ImageUrl='<%#IF(Eval("Val")=9,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb9" Visible="false" GroupName="grp"  /></td>
											<td runat="server" id="td8"><asp:Image runat="server" ID="img8" ImageUrl='<%#IF(Eval("Val")=8,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb8" Visible="false" GroupName="grp"  /></td>
											<td runat="server" id="td7"><asp:Image runat="server" ID="img7" ImageUrl='<%#IF(Eval("Val")=7,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb7" Visible="false" GroupName="grp"  /></td>
											<td runat="server" id="td6"><asp:Image runat="server" ID="img6" ImageUrl='<%#IF(Eval("Val")=6,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb6" Visible="false" GroupName="grp"  /></td>
											<td runat="server" id="td0"><asp:Image runat="server" ID="img0" ImageUrl='<%#IF(Eval("Val")=0,"~/images/C.png","~/images/NC.png") %>' OnPreRender="img_PreRender" AlternateText="V"/><asp:RadioButton runat="server" ID="rb0" Visible="false" GroupName="grp"  /></td>
										</tr>

									</table>
									</div>
								</td>
							</tr>
							<tr><td><b><%#If(Val("AnswerTypeID")=1,"הערכה מילולית – אנא ציין דוגמאות ספציפיות והסברים התומכים בהערכה אותה נתת",vbnullstring) %></b></td></tr>
							<tr>
								<td runat="server" id="tdtxt" class="ansprint" style='<%#Eval("TextStyle") & "width:95%;" %>'>
									<%#If(IsDBNull(Eval("Txt")), Eval("Comm"), Eval("Txt").Replace(Environment.NewLine, "<br />")) & "&nbsp;"%>
									<%--<asp:ListView runat="server" ID="lvSubField" Visible='<%#Val("AnswerTypeID")=3 %>'>
										<LayoutTemplate>
											<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;">
												<thead style="background-color:#CCCCCC;">
													<tr>
														<td  style="border:1px dotted white;">
															<b>מס</b>
														</td>
														<td  style="border:1px dotted white;">
															<asp:Label runat="server" ID="lblTxt1" OnPreRender="lblTxt_PreRender" Text="כותרת1" Font-Bold="true" />
														</td>
														<td  style="border:1px dotted white;">
															<asp:Label runat="server" ID="lblTxt2" OnPreRender="lblTxt_PreRender" Text="כותרת2" Font-Bold="true" />
														</td>
													</tr>
												</thead>
												<tr ID="itemPlaceholder" runat="server">
												</tr>
											</table>
										</LayoutTemplate>
										<ItemTemplate>
											<tr>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Nmbr")%>
												</td>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Txt1")%>
												</td>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Txt2")%>
												</td>
											</tr>
										</ItemTemplate>
									</asp:ListView>--%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</ItemTemplate>
			<EditItemTemplate>
				<tr>
					<td>
						<table style="width:100%" dir="rtl">
							<tr>
								<td></td>
								<td runat="server" style='<%#Eval("MainTextStyle") %>'>
								<asp:HiddenField runat="server" ID="hdnFieldID" Value='<%#Bind("FieldID") %>' />
									<asp:Label runat="server" ID="ckeMainText" Width="100%" Text='<%#Bind("MainText") %>' Font-Names="Arial" />
								</td>
							</tr>
							<tr>
								<td></td>
								<td runat="server" style='<%#Eval("SubTextStyle") %>'>
									<asp:Label runat="server" ID="ckeSubText" Width="100%" Text='<%#Bind("SubText") %>' Font-Names="Arial" />
								</td>
							</tr>
							<tr>
								<td rowspan="2" style="width:7%;">
									<asp:Button runat="server" ID="btnUpdate" Text="שמירה" CommandName="Update" OnClick="btnEnable_Click" />
									<asp:Button runat="server" ID="btnCancel" CommandName="Cancel" Text="ביטול" OnClick="btnEnable_Click" />
								</td>
								<td style="width:93%;text-align:center;white-space:normal;vertical-align:top;">
									<div runat="server"	id="divrbl" visible='<%#Val("AnswerTypeID")=1 OR Val("AnswerTypeID")=3%>' >
										<table style="width:400px;">
										<tr style="vertical-align:top;background-color:#5088FF;">
											<td style="width:17%">משמעותית מעל הציפיות</td>
											<td style="width:17%">מעל הציפיות</td>
											<td style="width:16%">עומד בציפיות</td>
											<td style="width:16%">מתחת לחלק מהציפיות</td>
											<td style="width:17%">משמעותית מתחת הציפיות</td>
											<td style="width:17%">לא רלוונטי</td>
										</tr>
										<tr style="vertical-align:middle;background-color:#70AAFF;">
											<td>10</td>
											<td>9</td>
											<td>8</td>
											<td>7</td>
											<td>6</td>
											<td>0</td>
										</tr>
										<tr style="vertical-align:middle;background-color:#70AAFF;">
											<td><asp:RadioButton runat="server" ID="rb10" Checked='<%#Eval("Val")=10 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
											<td><asp:RadioButton runat="server" ID="rb9" Checked='<%#Eval("Val")=9 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
											<td><asp:RadioButton runat="server" ID="rb8" Checked='<%#Eval("Val")=8 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
											<td><asp:RadioButton runat="server" ID="rb7" Checked='<%#Eval("Val")=7 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
											<td><asp:RadioButton runat="server" ID="rb6" Checked='<%#Eval("Val")=6 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
											<td><asp:RadioButton runat="server" ID="rb0" Checked='<%#Eval("Val")=0 %>' OnPreRender="rb_PreRender" OnCheckedChanged="rb_CheckedChanged" GroupName="rbl" /></td>
										</tr>

									</table>
									</div>
								</td>
							<tr>
								<td runat="server" class="ansprint" style='<%#Eval("TextStyle") & "width:93%;" %>'>
									<asp:Textbox runat="server" ID="ckeTxt" Width="100%" Text='<%#Bind("Txt") %>' TextMode="MultiLine" Rows='<%#Eval("NumberOfRows") %>' Font-Names="Arial" Visible='<%#Val("AnswerTypeID")<>3 %>' />
									<%--<asp:ListView runat="server" ID="lvSubField" InsertItemPosition="LastItem" Visible='<%#Val("AnswerTypeID")=3 %>'>
										<LayoutTemplate>
											<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;border:1px solid white;">
												<thead>
													<tr style="background-color:#CCCCCC;">
														<td style="width:15%;"></td>
														<td style="border:1px dotted white;width:5%">
															מס
														</td>
														<td style="border:1px dotted white;width:40%;">
															<asp:Label runat="server" ID="lblTxt1" OnPreRender="lblTxt_PreRender" Text="כותרת1" Font-Bold="true" />
														</td>
														<td  style="border:1px dotted white;width:40%;">
															<asp:Label runat="server" ID="lblTxt2" OnPreRender="lblTxt_PreRender" Text="כותרת2" Font-Bold="true" />
														</td>
													</tr>
												</thead>
												<tr ID="itemPlaceholder" runat="server">
												</tr>
											</table>
										</LayoutTemplate>
										<ItemTemplate>
											<tr>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<asp:Button runat="server" ID="btnEdit" Text="עריכה" CommandName="Edit" />
													<asp:Button runat="server" ID="btnDelete" Text="מחיקה" CommandName="Delete" OnClientClick="return confirm('האם למחוק?');" />
												</td>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Nmbr")%>
												</td>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Txt1")%>
												</td>
												<td style="border:1px dotted white;background-color:#EEEEEE;">
													<%#Eval("Txt2")%>
												</td>
											</tr>
										</ItemTemplate>
										<EditItemTemplate>
											<tr>
												<td>
													<asp:Button runat="server" ID="btnUpdate" Text="עדכון" CommandName="Updat" />
													<asp:Button runat="server" ID="btnCancel" Text="ביטול" CommandName="Cancel" />
												</td>
												<td>
													<%#Eval("Nmbr")%>
												</td>
												<td>
													<asp:Textbox runat="server" ID="TBTxt1" Text='<%#BInd("Txt1")%>' TextMode="MultiLine" Rows="2" Width="98%" />
												</td>
												<td>
													<asp:Textbox runat="server" ID="TBTxt2" Text='<%#BInd("Txt2")%>' TextMode="MultiLine" Rows="2" Width="98%" />
												</td>
											</tr>
										</EditItemTemplate>
										<InsertItemTemplate>
											<tr>
												<td>
													<asp:Button runat="server" ID="btnInsert" Text="הוספה" CommandName="Insert" />
													<asp:Button runat="server" ID="btnCancel" Text="מחיקה" CommandName="cancel" />
												</td>
												<td>
													<%#Eval("Nmbr")%>
												</td>
												<td>
													<asp:Textbox runat="server" ID="TBTxt1" Text='<%#BInd("Txt1")%>' TextMode="MultiLine" Rows="2" Width="100%" />
												</td>
												<td>
													<asp:Textbox runat="server" ID="TBTxt2" Text='<%#BInd("Txt2")%>' TextMode="MultiLine" Rows="2" Width="100%" />
												</td>
											</tr>
										</InsertItemTemplate>
									</asp:ListView>--%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</EditItemTemplate>
		</asp:ListView>
<%--		</ContentTemplate></asp:UpdatePanel>
--%>		<div style="width:100%;text-align:left;"><asp:Button runat="server" ID="btnprtForm" Text="הדפס" style="float:left;" CausesValidation="false" /></div>
	</div>
<hr />

	<asp:SqlDataSource ID="DSAnswers" runat="server" CancelSelectOnNullParameter="False"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="DECLARE @CANEDIT INT SELECT @CANEDIT = Book10.dbo.HR_fn_CanEdit(@EventID) SELECT *,@CANEDIT CANEDIT FROM  dbo.HR_fnAnswers_(@EventID) ORDER BY Ord" 
		 UpdateCommand="IF EXISTS(SELECT * FROM HR_Answers WHERE EventID = @EventID AND FieldID = @FieldID)
UPDATE HR_Answers SET FieldID=@FieldID,Txt=@Txt,Val=@Val,UserID=@UserID,Loadtime=GETDATE() WHERE EventID = @EventID AND FieldID = @FieldID
ELSE
INSERT INTO HR_Answers(EventID,FieldID,Txt,Val,UserID,Loadtime) VALUES(@EventID,@FieldID,@Txt,@Val,@UserID,GETDATE())" >
		<SelectParameters>
			<asp:ControlParameter ControlID="lblEventID" Name="EventID" type="Int32" PropertyName="Text" />
		</SelectParameters>
		<UpdateParameters>
			<asp:ControlParameter ControlID="lblEventID" Name="EventID" type="Int32" PropertyName="Text" />
			<asp:Parameter Name="FieldID" Type="Int32" />
			<asp:Parameter Name="Txt" Type="String"/>
			<asp:Parameter Name="Val" Type="Int32" />
			<asp:CookieParameter Name="UserID" CookieName="HRForm_UserID" Type="Int32" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource runat="server" ID="DSEmp" CancelSelectOnNullParameter="False" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT EmployeeName,StartDate,e.FrameID,JobName,v.EventDate, URName,FrameName
FROM HR_vEmpList e
CROSS JOIN (SELECT URName FROM p0t_NtB WHERE UserID = @UserID) u
LEFT OUTER JOIN FrameList f on f.FrameID = e.FrameID
CROSS APPLY (SELECT EmpID,EventDate FROM HR_Events WHERE EventID=@EventID) v
WHERE EmployeeID = v.EmpID " >
		<SelectParameters>
			<asp:ControlParameter Name="EventID" ControlID="lblEventID" PropertyName="Text" />
			<asp:CookieParameter Name="UserID" CookieName="HRForm_UserID" />
		</SelectParameters>
	</asp:SqlDataSource>
	</div>
</div>
	  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
    </div>
	<asp:Button ID="btnPostback" runat="server" Visible="false" CausesValidation="false"  />
	<input id="PRINT" type="button" value="הדפסה" onclick="DoPrint()" visible="false" />
</asp:Content>

