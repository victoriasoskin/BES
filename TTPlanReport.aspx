<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false" CodeFile="TTPlanReport.aspx.vb" Inherits="TTPlanReport" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.edt
		{
		    text-align:right;
		}
	</style>
	<script type="text/javascript">
		function flipShow(t, x) {
			if (t.value == ':::') { 
				var y = document.getElementById('spnPurpose' + x);
				if (y) y.style.display = 'block';
				y = document.getElementById('spnDescription' + x);
				if (y) y.style.display = 'block';
				y = document.getElementById('spnCriteria' + x);
				if (y) y.style.display = 'block';

				var b = document.getElementById('inpPurpose' + x);
				if (b) b.value = '^^^';
				b = document.getElementById('inpDescription' + x);
				if (b) b.value = '^^^';
				b = document.getElementById('inpCriteria' + x);
				if (b) b.value = '^^^';			
			}
			else {
				var y = document.getElementById('spnPurpose' + x);
				if (y) y.style.display = 'none';
				y = document.getElementById('spnDescription' + x);
				if (y) y.style.display = 'none';
				y = document.getElementById('spnCriteria' + x);
				if (y) y.style.display = 'none';

				var b = document.getElementById('inpPurpose' + x);
				if (b) b.value = ':::';
				b = document.getElementById('inpDescription' + x);
				if (b) b.value = ':::';
				b = document.getElementById('inpCriteria' + x);
				if (b) b.value = ':::';
			}

		}
	</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ToolkitScriptManager runat="server">
</asp:ToolkitScriptManager>
<div runat="server" id="divform" class="pg" style="min-height:750px;">
	<topyca:pageheader runat="server" ID="PageHeader1" Header="" ButtonJava="window.close();" />
<div runat="server" id="divbuttons">
	<table style="text-align:center;">
		<tr>
			<td>
				<asp:Label runat="server" ID="lblCustEventID" BackColor="#EEEEEE" BorderColor="#DDDDDD" BorderStyle="Ridge" />
			</td>
		</tr>
		<tr>
			<td>
				<asp:ImageButton runat="server" ID="btnWord" CausesValidation="false" Visible="false"
					Width="35px" Height="35px"  ImageUrl="~/images/Microsoft-Word-icon.png" />
			</td>
		</tr>
	</table>							
</div>

	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="divbuttons" HorizontalOffset="750" VerticalOffset="65" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
	<div id="divheader">
		<asp:ListView runat="server" ID="lvHdr" DataSourceID="DSCustomer" DataKeyNames="CustomerID"  >
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
								<td style="font-weight:bold;">
									ת.ז:
								</td>
								<td>
									<%#Eval("CustomerID")%>
									<asp:HiddenField runat="server" ID="hdnFormHeader" Value='<%#Eval("FormType") & " " & Eval("Name") %>' OnPreRender="hdn_PreRender" />
								</td>
								<td style="font-weight:bold;">
									ת.לידה:
								</td>
								<td>
									<%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
								</td>
							</tr>
							<tr>
								<td style="font-weight:bold;">
									מסגרת:
								</td>
								<td>
									<%#Eval("FrameName")%>
								</td>
								<td style="font-weight:bold;">
									ת.קליטה:
								</td>
								<td>
									<%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>
								</td>
							</tr>
							<tr>
								<td style="font-weight:bold;">
									מעדכן התוכנית:
								</td>
								<td>
									<%#Eval("URName")%>
								</td>
								<td style="font-weight:bold;">
									ת.עדכון:
								</td>
								<td>
									<%#Format(Eval("CustEventDate"), "dd/MM/yyyy")%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</ItemTemplate>
		</asp:ListView>
	</div>
	<hr />
	<div id="divWorkPlanReport">
		<asp:ListView runat="server" ID="lvReport" DataSourceID="DSWorkPlanReport" DataKeyNames="ID" InsertItemPosition="None" ViewStateMode="Disabled" >
			<LayoutTemplate>
				<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width:100%;">
					<thead>
						<tr>
							<th style="width:10%;">&nbsp;</th>
							<th style="width:20%;">מטרת התמיכה</th>
							<th style="width:35%;">אופן ביצוע (תדירות, זמן, ספק ופירוק התמיכה בפועל)</th>
							<th style="width:25%;">קריטריונים להצלחה</th>
							<th style="width:10%;">תאריכים/תדירות<br />בה התבצעה התמיכה</th>
						</tr>
					</thead>
					<tr ID="itemPlaceholder" runat="server">
					</tr>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnEdit" CommandName="edit" Text="עריכה" CausesValidation="false" CommandArgument="ID" Visible="false" />
						<asp:Button runat="server" ID="btnDel" CommandName="delete" Text="מחיקה" OnClientClick="return confirm('האם למחוק?');" Visible="false" />
						<asp:HiddenField runat="server"	ID="hdnID" Value='<%#Eval("ID")  %>' />
 					</td>
					<td style="background-color:#DDDDDD;">
						<%#ShowText("Purpose")%>
					</td>
					<td style="background-color:#DDDDDD;">
						<%#ShowText("Description")%>
					</td>
					<td style="background-color:#DDDDDD;">
						<%#ShowText("Criteria")%>
					</td>
					<td	style="background-color:#EEEEEE;border-bottom:1px solid #AAAAAA;vertical-align:top;">
						<%#Eval("TxtWhen")%>
					</td>
				</tr>
				<tr>
					<td style="border-bottom:1px solid #AAAAAA;">מעקב חודשי</td>
					<td colspan="4" style="background-color:#EEEEEE;border-bottom:1px solid #AAAAAA;"">
						<%#Eval("TxtWhat")%>
					</td>
				</tr>
			</ItemTemplate>
			<InsertItemTemplate>
				<tr><td colspan="6"><hr /></td></tr>
				<tr>
					<td colspan="6" style="font-weight:bold;font-size:medium;" >הוספת דיווח</td>
				</tr>
				<tr>
				<tr>
					<td colspan="6" style="background-color:#999999;">
						<asp:DropDownList runat="server" ID="ddlWP" DataSourceID="DSWorkPlan" DataTextField="Purpose" DataValueField="WpID" AppendDataBoundItems="true" SelectedValue='<%#Bind("WorkPlanID") %>' AutoPostBack="true" OnSelectedIndexChanged="DDL_SelectedIndexChanged" OnPreRender="DDL_PreRender">
							<asp:ListItem Value="" Text="בחר תמיכה" />
						</asp:DropDownList>
						<asp:HiddenField runat="server" ID="hdnWorkPlanID" Value='<%#Eval("WorkPlanID") %>' />
						</td>
				</tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnInsert" CommandName="Insert" Text="הוספה" />
						<asp:Button runat="server" ID="btnCancel" CommandName="cancel" Text="ביטול"  CausesValidation="false"/>
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblPurpose" Text='<%#Eval("Purpose")%>' />
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblDescription" Text='<%#Eval("Description")%>' />
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblCriteria" Text='<%#Eval("Criteria")%>' />
					</td>
					<td style="vertical-align:top;">
						<asp:TextBox runat="server" ID="ckeTxtWhen" Rows="4" Text='<%#Bind("TxtWhen") %>' TextMode="MultiLine" Columns="10" Height="100%" />
					</td>
				</tr>
				<tr>
					<td>מעקב חודשי</td>
					<td colspan="4">
						<asp:TextBox runat="server" ID="ckeTxtWhat" Text='<%#Bind("TxtWhat") %>' Rows="4" TextMode="MultiLine" Width="100%" Height="100%" />
					</td>
				</tr>
				<tr><td colspan="6"><hr /></td></tr>
			</InsertItemTemplate>
			<EditItemTemplate>
				<tr><td colspan="6"><hr /></td></tr>
				<tr>
					<td colspan="6" style="font-weight:bold;font-size:medium;" >עדכון דיווח</td>
				</tr>
				<tr>
				<tr>
					<td colspan="6" style="background-color:#999999;">
						<asp:DropDownList runat="server" ID="ddlWP" DataSourceID="DSWorkPlan" DataTextField="Purpose" DataValueField="WpID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="DDL_SelectedIndexChanged" OnPreRender="DDL_PreRender">
							<asp:ListItem Value="" Text="בחר תמיכה" />
						</asp:DropDownList>
						<asp:HiddenField runat="server" ID="hdnWorkPlanID" Value='<%#Eval("WorkPlanID") %>' />
						</td>
				</tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnUpdate" CommandName="update" Text="עדכון" CommandArgument="ID" OnClick="btnUpdate_Click" />
						<asp:Button runat="server" ID="btnCancel" CommandName="cancel" Text="ביטול"  CausesValidation="false"/>
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblPurpose" Text='<%#Eval("Purpose")%>' />
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblDescription" Text='<%#Eval("Description")%>' />
					</td>
					<td style="background-color:#DDDDDD;">
						<asp:Label runat="server" ID="lblCriteria" Text='<%#Eval("Criteria")%>' />
					</td>
					<td style="vertical-align:top;">
						<asp:TextBox runat="server" ID="ckeTxtWhen" Rows="4" Text='<%#Bind("TxtWhen") %>' TextMode="MultiLine"  Columns="10" Height="100%" />
					</td>
				</tr>
				<tr>
					<td>מעקב חודשי</td>
					<td colspan="4">
						<asp:TextBox runat="server" ID="ckeTxtWhat" Text='<%#Bind("TxtWhat") %>' Rows="4" TextMode="MultiLine" Width="100%" Height="100%" />
					</td>
				</tr>
				<tr><td colspan="6"><hr /></td></tr>
			</EditItemTemplate>
		</asp:ListView>
	</div>
	<div id="divbuttons1">
		<asp:Button runat="server" ID="btnDel" Text="מחיקת הדיווח" OnClientClick="return confirm('האם למחוק את הדיווח?')" Visible="false" /><br />
		<input type="button" onclick="window.open('/videos/mt.swf','_blank','toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=800,width=900');" value="סרטון הדרכה" />
	</div>
</div>
	<asp:SqlDataSource runat="server" ID="DSCustomer" CancelSelectOnNullParameter="False" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="DECLARE @CustomerID int
DECLARE @FrameID int
SELECT @CustomerID = CustomerID,@FrameID = CustFrameID FROM CustEventList WHERE CustEventID = @CustEventID
SELECT e.CustomerID,c.CustFirstName + ' ' + c.CustLastName AS Name, c.CustBirthDate, i.CustEventDate As EnterDate,f.FrameName,e.CustEventDate, u.URName,e.CustRelateID AS FormID,ft.Name AS FormType
FROM CustEventList e
LEFT OUTER JOIN CustomerList c ON c.CustomerID = e.CustomerID
INNER JOIN		(SELECT TOP 1 CustEventDate,CustomerID,CustFrameID 
				 FROM CustEventlist i
				 WHERE CustEventTypeID = 1 AND CustFrameID = @FrameID AND CustEventID IN (	SELECT CusteventID
																							FROM CustStatus
																							WHERE CustomerID = @CustomerID)
				 ORDER BY CustEventDate DESC
				) i ON i.CustomerID = e.CustomerID AND i.CustFrameID = e.CustFrameID
LEFT OUTER JOIN FrameList f ON e.CustFrameID = f.FrameID
LEFT OUTER JOIN p0t_NtB u ON e.UserID = u.UserID
CROSS JOIN (SELECT * FROM TT_FormTypes WHERE ID = @FormTypeID) ft
WHERE CustEventID = @CustEventID" >
		<SelectParameters>
			<asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
			<asp:QueryStringParameter Name="FormTypeID" QueryStringField="FT" />
		</SelectParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource runat="server" ID="DSWorkPlanReport" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		DeleteCommand="DELETE FROM [TT_WorkPlanReport] WHERE [ID] = @ID" 
		InsertCommand="INSERT INTO [TT_WorkPlanReport] ([CstpID],[CustEventID], [WorkPlanID], [TxtWhen], [TxtWhat], [UserID], [Loadtime],CustomerID) VALUES (@CstpID, @CustEventID,@WorkPlanID, @TxtWhen, @TxtWhat, @UserID, GETDATE(),@CustomerID)" 
		SelectCommand="SELECT R.ID as ID,r.CstpID,r.WorkPlanID,p.Purpose,p.Description,p.Criteria,r.TxtWhen, [TxtWhat],r.UserID,r.Loadtime,u.URName
						FROM TT_WorkPlanReport r
						LEFT OUTER JOIN (SELECT * FROM dbo.TT_fnWorkPlan(NULL)) p ON p.WpID=r.WorkPlanID
						LEFT OUTER JOIN p0t_NtB u ON u.UserID=r.UserID
						Where CustEventID=@CustEventID
                        ORDER BY r.ID
						" 
		UpdateCommand="UPDATE [TT_WorkPlanReport] SET [WorkPlanID] = @WorkPlanID, [TxtWhen] = @TxtWhen, [TxtWhat] = @TxtWhat, [UserID] = @UserID, [Loadtime] = GETDATE(),CustomerID=@CustomerID WHERE [ID] = @ID" >
		<DeleteParameters>
			<asp:Parameter Name="ID" Type="Int32" />
		</DeleteParameters>
		<InsertParameters>
			<asp:Parameter Name="CstpID" Type="Int32" />
			<asp:Parameter Name="CustEventID" />
			<asp:Parameter Name="WorkPlanID" Type="Int32" />
			<asp:Parameter Name="TxtWhen" Type="String" />
			<asp:Parameter Name="TxtWhat" Type="String" />
			<asp:QueryStringParameter QueryStringField="U" Name="UserID" Type="Int32" />
			<asp:QueryStringParameter QueryStringField="C" Name="CustomerID" Type="Int64" />
		</InsertParameters>
		<SelectParameters>
<%--			<asp:ControlParameter Name="CstPID" Type="Int32" ControlID="lblCustEventID" PropertyName="Text" DefaultValue="" />--%>
			<asp:QueryStringParameter Name="CustEventID" QueryStringField="ID" type="Int32"/>
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="WorkPlanID" Type="Int32" />
			<asp:Parameter Name="TxtWhen" Type="String" />
			<asp:Parameter Name="TxtWhat" Type="String" />
			<asp:QueryStringParameter QueryStringField="U" Name="UserID" Type="Int32" />
			<asp:QueryStringParameter QueryStringField="C" Name="CustomerID" Type="Int64" />
		</UpdateParameters>
	</asp:SqlDataSource>
	<asp:SqlDataSource runat="server" ID="DSWorkPlan" CancelSelectOnNullParameter="false"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT [WpID], [Purpose], [Description], [Criteria] FROM dbo.TT_fnWorkPlan(@CstPID)" >
		<SelectParameters>
			<asp:ControlParameter Name="CstPID" Type="Int32" ControlID="lblCustEventID" PropertyName="Text" />
		</SelectParameters>
	</asp:SqlDataSource>
	
</asp:Content>

