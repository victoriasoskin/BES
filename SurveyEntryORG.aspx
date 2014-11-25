<%@ Page Language="VB" MasterPageFile="~/SherutO.master" AutoEventWireup="false" CodeFile="~/SurveyEntry.aspx.vb" Inherits="SurveyEntry"  title="בית אקשטיין - דף כניסה למערכת סקרים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
	<script type="text/javascript">
		// DEFINE RETURN VALUES
		var R_ELEGAL_INPUT = -1;
		var R_NOT_VALID = -2;
		var R_VALID = 1;

		function ValidID(sender, args) { 
			//args.IsValid = true;
			args.IsValid = (ValidateID(args.Value) == R_VALID);
			return;
		}

		function ValidateID(str) {
			//INPUT VALIDATION
			return R_VALID
			// Just in case -> convert to string
			var IDnum = String(str);

			// Validate correct input
			if ((IDnum.length > 9) || (IDnum.length < 5))
				return R_ELEGAL_INPUT;
			if (isNaN(IDnum))
				return R_ELEGAL_INPUT;

			// The number is too short - add leading 0000
			if (IDnum.length < 9) {
				while (IDnum.length < 9) {
					IDnum = '0' + IDnum;
				}
			}

			// CHECK THE ID NUMBER
			var mone = 0, incNum;
			for (var i = 0; i < 9; i++) {
				incNum = Number(IDnum.charAt(i));
				incNum *= (i % 2) + 1;
				if (incNum > 9)
					incNum -= 9;
				mone += incNum;
			}
			if (mone % 10 == 0)
				return R_VALID;
			else
				return R_NOT_VALID;
		}
 
	</script> 
<%--	<script type = "text/javascript" >

		function preventBack() { window.history.forward(); }

		setTimeout("preventBack()", 0);

		window.onunload = function() { null };

	</script>
--%>
	<div>
    <asp:SqlDataSource ID="dsframes" runat="server" 
			ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
			
			SelectCommand="SELECT FrameList.FrameName, FrameList.SurveyFrameID As FrameID FROM Survey_FrameList as FrameList LEFT OUTER JOIN SurveyIDList ON FrameList.SurveyFrameID = SurveyIDList.FrameID WHERE (SurveyIDList.ID = @ID) AND (SurveyIDList.SurveyID = @SurveyID)">
			<SelectParameters>
				<asp:ControlParameter ControlID="HDNID" Name="ID" PropertyName="Value" />
				<asp:QueryStringParameter Name="SurveyID" QueryStringField="S" />
			</SelectParameters>
		</asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSERVICE" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAME" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    	<asp:HiddenField ID="HDNID" runat="server" />
    <asp:SqlDataSource ID="DSTB" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT p0t_Ntb.UserID, p0t_Ntb.UserName, p0t_Ntb.Password, p0t_Ntb.ServiceID, p0t_Ntb.FrameID, p0t_Ntb.UserGroupID, p0t_Ntb.URName, p0t_UGroup.UserGroupName, p0t_UGroup.Stype, ServiceList.ServiceName, FrameList.FrameName FROM p0t_Ntb LEFT OUTER JOIN FrameList ON p0t_Ntb.FrameID = FrameList.FrameID LEFT OUTER JOIN ServiceList ON p0t_Ntb.ServiceID = ServiceList.ServiceID LEFT OUTER JOIN p0t_UGroup ON p0t_Ntb.UserGroupID = p0t_UGroup.UserGroupID">
    </asp:SqlDataSource>
                <asp:Label ID="LBLCLS" runat="server" Font-Size="16pt" 
        Width="219px" Visible="False"
        BackColor="Red" ForeColor="#FFFFCC"></asp:Label>
        <div class="survhdr">
			<asp:Label ID="lblhdr1" runat="server" Text="מערכת הסקרים" />
			<br />
			<asp:Label id="lblhdr2" runat="server" Text="בקרת כניסה" />
			<br />
			<asp:Label id="lblhdr3" runat="server" Font-Size="X-Large" />
        </div>
        <div class="login">
        <asp:FormView ID="FVLOGIN" runat="server" DataKeyNames="UserID" 
			DataSourceID="DSTB" DefaultMode="Insert" BackColor="#C0C0FF" 
			BorderColor="#0000C0" BorderWidth="1px" >
			<InsertItemTemplate>
				<table cellpadding="4">
					<tr>
						<td style="width: 100px">
								<asp:Label ID="lblexh" runat="server" Text="הקש תעודת זהות " Width="120px"></asp:Label>
						</td>
						<td style="width: 100px">
									<asp:TextBox ID="TBID" runat="server" AutoPostBack="true" CausesValidation="true" Width="70px"
										ontextchanged="TBID_TextChanged" ></asp:TextBox>
									<asp:Label ID="lblerr" runat="server" ForeColor="Red" 
										Text="לפי רישומי המערכת, בעליה של תעודת זהות זו כבר השלים השתתפותו בסקר זה. אין אפשרות להשתתף שנית." 
										Visible="False"></asp:Label>
									<asp:RequiredFieldValidator ID="RFV1" runat="server" ControlToValidate="TBID"
										Display="Dynamic" ErrorMessage="**"></asp:RequiredFieldValidator>
										<asp:RangeValidator runat="server" ID="rvid" ControlToValidate="tbid" Display="Dynamic" Text="מספר תעודת זהות לא חוקי." Type="Integer" MinimumValue="1111" MaximumValue="999999999" />
									<asp:CustomValidator ID="CV2" runat="server" ClientValidationFunction="ValidID" 
										ControlToValidate="TBID" Display="Dynamic"   OnServerValidate="TBID_validate"
										ErrorMessage="מספר תעודת זהות לא חוקי.." />
						</td>
					</tr>
					<tr>
						<td>
							<asp:Label ID="LblEPW" runat="server" Text="סיסמא" Visible="false"></asp:Label>
						</td>
						<td style="width: 100px">
							<asp:TextBox ID="tbEPW" runat="server" TextMode="Password" Width="100px" Visible="false" OnTextChanged="TBepw_TextChanged"></asp:TextBox>
							<asp:CustomValidator ID="CVPW" runat="server" ControlToValidate="TBEPW"  OnServerValidate="TBPW_validate"
										Display="Dynamic" ErrorMessage="סיסמא לא נכונה. נסה שנית." />
							<asp:RequiredFieldValidator runat="server" ID="RFVepw" ControlToValidate="tbepw" ErrorMessage="סיסמא לא נכונה. נסה שנית" Display="Dynamic" Visible="false"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<asp:Label runat="server" ID="lblnpw" Text="עליך לבחור לעצמך סיסמא. כדי לודא את תקינותה הקש את הסיסמא פעמיים:" Visible="false" width="200px"/>
						</td>
					</tr>
					<tr>
						<td>
							<asp:label runat="server" ID="lblnpw1" text="סיסמא חדשה"  Visible="false" />
						</td>
						<td>
							<asp:TextBox runat="server" ID="tbnpw1" Width="100px" TextMode="Password" Visible="false" />
							<asp:RequiredFieldValidator runat="server" ID="rfvpw1" ControlToValidate="tbnpw1" Display="Dynamic" Visible="false" ErrorMessage="חובה להקליד סיסמא" />
						</td>
					</tr>
					<tr>
						<td>
							<asp:label runat="server" ID="lblnpw2" text="סיסמא חדשה שנית" Visible="false" />
						</td>
						<td>
							<asp:CompareValidator ID="coV1" runat="server" ErrorMessage="הסיסמא והסיסמא להשוואה אינן זהות" ControlToValidate="tbnpw2" ControlToCompare="tbnpw1" Display="Dynamic"></asp:CompareValidator>
							<asp:TextBox runat="server" ID="tbnpw2" Width="100px"  Visible="false"  TextMode="Password" CausesValidation="true" OnTextChanged="TBnpw2_TextChanged" />
							<asp:RequiredFieldValidator runat="server" ID="rfvpw2" ControlToValidate="tbnpw2" Display="Dynamic" Visible="false" ErrorMessage="חובה להקליד סיסמא" />
						</td>
					</tr>
					<tr>
						<td>
							<asp:label runat="server" ID="lblframe" text="תעודת הזהות מקושרת ליותר ממסגרת אחת" Visible="false" />
						</td>
						<td>
							<asp:DropDownList AppendDataBoundItems="true" runat="server" ID="ddlframe" 
								Visible="false" DataSourceID="dsframes" DataTextField="framename" 
								DataValueField="frameid" onselectedindexchanged="ddlframe_SelectedIndexChanged"> 
								<asp:ListItem Text="<בחר מסגרת>" Value="" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td style="width: 100px">
							<br />
							<asp:Button ID="BTNLOGIN" runat="server" Text="כניסה" CausesValidation="true" OnClick="Button1_Click" OnPreRender="Button2_PreRender" /></td>
						<td style="width: 100px">
							<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="tbEPW"
								Display="Dynamic" ErrorMessage="*"></asp:CustomValidator>
						</td>
					</tr>

				</table>
			</InsertItemTemplate>
		</asp:FormView>
	</div>
	<div class="divmail">
		<table cellpadding="4">
		<tr>
			<td>
				<asp:LinkButton ID="lnkbshowmail" runat="server" CausesValidation="false">לחץ כאן כדי לשלוח הודעה אל מנהל הסקר, או לבקש עזרה</asp:LinkButton>
			</td>
		</tr>
		<tr>
			<td>
				<asp:Panel runat="server" ID="pnlmail" Visible="false">
					<table>
						<tr>
							<td colspan="2">
								ציין בהודעה דרך להתקשר אליך: טלפון או דוא"ל
							</td>
						</tr>
						<tr>
							<td>שם
							</td>
							<td>
								
								<asp:TextBox ID="TBNAME" runat="server" ValidationGroup="vmail"></asp:TextBox>
								
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="TBNAME" Display="Dynamic" ErrorMessage="חובה להקיש שם" 
									ValidationGroup="vmail"></asp:RequiredFieldValidator>
								
							</td>
						</tr>
						<tr>
							<td>טלפון
							</td>
							<td>
								<asp:TextBox ID="TBPHONE" runat="server" ValidationGroup="vmail"></asp:TextBox>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
									ControlToValidate="TBPHONE" Display="Dynamic" ErrorMessage="חובה להקיש טלפון" 
									ValidationGroup="vmail"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td>דוא"ל
							</td>
							<td>
								<asp:TextBox ID="tbemail" runat="server"></asp:TextBox>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<asp:TextBox runat="server" TextMode="MultiLine" ID="tbmail" Rows="5" Columns="30" />
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<asp:Button runat="server" ID="btnmail" Text="שלח" onclick="btnmail_Click" 
									ValidationGroup="vmail"  />
							</td>
						</tr>
					</table>
				</asp:Panel>
			</td>
		</tr>	
		</table>
	</div>
</div>

</asp:Content>

