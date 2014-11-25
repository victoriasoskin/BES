<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurIDList.aspx.vb" Inherits="SurIDList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<div class="reldiv">
		<div class="hdrdiv">
			רשימת משתתפים בסקר
		</div>
		<div>	
			<asp:SqlDataSource ID="dssurveys" runat="server" 
				ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
				SelectCommand="SELECT [Survey], [SurveyID] FROM [Surveys]"> 
			</asp:SqlDataSource>
			<div runat="server" id="divsrch">
				<table border="1">
					<tr>
						<td>
							סקר</td>
						<td>
							<asp:DropDownList ID="DDLSURVEYS" runat="server" 
								DataSourceID="dssurveys" DataTextField="Survey" DataValueField="SurveyID" 
								AppendDataBoundItems="True" ValidationGroup="FFilter">
								<asp:ListItem Value="">&lt;בחירת סקר&gt;</asp:ListItem>
							</asp:DropDownList>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td>
							תז</td>
						<td>
							<asp:TextBox ID="TBID" runat="server" Width="93px" ValidationGroup="Filter"></asp:TextBox>
							<asp:RangeValidator ID="RangeValidator3" runat="server" 
								ControlToValidate="TBID" Display="Dynamic" ErrorMessage="תז לא מספר" 
								MaximumValue="999999999" MinimumValue="000000001" Type="Integer" 
								ValidationGroup="Filter"></asp:RangeValidator>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td>
							שם</td>
						<td>
							<asp:TextBox ID="TBNAME" runat="server"></asp:TextBox>
						</td>
						<td>
						</td>
					</tr>
					<tr>
						<td>
							מסגרת</td>
						<td>
							<asp:DropDownList ID="ddlframe" runat="server" AppendDataBoundItems="True" 
								DataSourceID="DSFRAMES" DataTextField="FrameName" 
								DataValueField="SurveyFrameID">
								<asp:ListItem Value="">&lt;כל המסגרות&gt;</asp:ListItem>
							</asp:DropDownList>
						</td>
						<td>
							<asp:SqlDataSource ID="DSFRAMES" runat="server" 
								ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
								SelectCommand="SELECT [FrameName], [SurveyFrameID] FROM [Survey_FrameList]">
							</asp:SqlDataSource>
						</td>
					</tr>
					<tr>
						<td>
							השתתף</td>
						<td colspan="2">
							<asp:RadioButtonList ID="RBLP" runat="server" RepeatDirection="Horizontal">
								<asp:ListItem Selected="True" Value="0">הכל</asp:ListItem>
								<asp:ListItem Value="1">לא השתתף</asp:ListItem>
								<asp:ListItem Value="2">השתתף</asp:ListItem>
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr>
						<td>
							סגר</td>
						<td colspan="2">
							<asp:RadioButtonList ID="RBLD" runat="server" RepeatDirection="Horizontal">
								<asp:ListItem Selected="True" Value="0">הכל</asp:ListItem>
								<asp:ListItem Value="1">לא סגר</asp:ListItem>
								<asp:ListItem Value="2">סגר</asp:ListItem>
							</asp:RadioButtonList>
						</td>
					</tr>
					<tr>
						<td>
							פחות מ
						</td>
						<td>
							<asp:TextBox ID="TBCNT" runat="server" Width="85px" ValidationGroup="Filter"></asp:TextBox>
							<asp:RangeValidator ID="RangeValidator4" runat="server" 
								ControlToValidate="TBCNT" ErrorMessage="לא מספר" MaximumValue="999" 
								MinimumValue="0" Type="Integer" ValidationGroup="Filter"></asp:RangeValidator>
						</td>
						<td>
							תשובות
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<asp:SqlDataSource ID="dsjobs" runat="server" 
								ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
								SelectCommand="SELECT [JobName], [JobID] FROM [Survey_JobList] ORDER BY [JobName]">
							</asp:SqlDataSource>
							<asp:Button ID="btnShow" runat="server" Text="הצג" ValidationGroup="Filter" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div>
			<table>
				<tr>
					<td valign="top">
						<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
							DataSourceID="DSLIST" AllowSorting="True" BorderStyle="None" CellPadding="4" 
							Font-Size="Small" ShowFooter="True">
							<Columns>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:Label ID="Label5" runat="server" onprerender="Label5_PreRender" 
											Text="Label"></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
											CommandName="Select" onclick="LinkButton1_Click" Text="עריכה"></asp:LinkButton>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="ID" HeaderText="תז" SortExpression="ID" />
								<asp:BoundField DataField="LastName" HeaderText="שם משפחה" 
									SortExpression="LastName" />
								<asp:BoundField DataField="FirstName" HeaderText="שם פרטי" 
									SortExpression="FirstName" />
								<asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
									SortExpression="FrameName" />
								<asp:BoundField DataField="jobname" HeaderText="תפקיד" 
									SortExpression="jobname" />
								<asp:BoundField DataField="StartDate" DataFormatString="{0:dd/MM/yy}" 
									HeaderText="ת התחלה" ReadOnly="True" SortExpression="StartDate" />
								<asp:BoundField DataField="Sen" HeaderText="ותק" SortExpression="Sen" />
								<asp:BoundField DataField="p" HeaderText="השתתף" SortExpression="p" />
								<asp:BoundField DataField="D" HeaderText="סגר" SortExpression="d" />
								<asp:BoundField DataField="cnt" DataFormatString="{0:#}" HeaderText="תשובות" 
									SortExpression="cnt" />
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<asp:Button ID="btneps" runat="server" CausesValidation="False" 
											onclick="btneps_Click" onprerender="btneps_PreRender" Text="איפוס" />
										<asp:HiddenField ID="hdnformid" runat="server" Value='<%# eval("Done") %>' />
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<asp:Button ID="btncls" runat="server" CausesValidation="False" 
											onclick="btncls_Click" onprerender="btneps_PreRender" Text="סגירה" />
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
						</asp:GridView>
					</td>
					<td valign="top">
						<asp:DetailsView ID="DVE" runat="server" Height="50px" Width="125px" 
							AutoGenerateRows="False" DataSourceID="DSLIST" DataKeyNames="ID" DefaultMode="Insert" 
							HeaderText="הוספת משתתף" Visible="False">
							<Fields>
								<asp:TemplateField HeaderText="תז" SortExpression="ID">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ID") %>'></asp:TextBox>
									</EditItemTemplate>
									<InsertItemTemplate>
										<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ID") %>'></asp:TextBox>
										<asp:RangeValidator ID="RangeValidator2" runat="server" 
											ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="תז לא מספר" 
											MaximumValue="999999999" MinimumValue="0000000001" Type="Integer"></asp:RangeValidator>
										<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
											ControlToValidate="TextBox3" Display="Dynamic" ErrorMessage="חובה תז"></asp:RequiredFieldValidator>
									</InsertItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label3" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:BoundField DataField="LastName" HeaderText="שם משפחה" 
									SortExpression="LastName" />
								<asp:BoundField DataField="FirstName" HeaderText="שם פרטי" 
									SortExpression="FirstName" />
								<asp:TemplateField HeaderText="מסגרת" SortExpression="FrameName">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FrameName") %>'></asp:TextBox>
									</EditItemTemplate>
									<InsertItemTemplate>
										<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
											ControlToValidate="ddlframes" Display="Dynamic" ErrorMessage="חובה מסגרת"></asp:RequiredFieldValidator>
										<asp:DropDownList ID="ddlframes" runat="server" AppendDataBoundItems="True" 
											DataSourceID="DSFRAMES" DataTextField="FrameName" 
											DataValueField="SurveyFrameID">
											<asp:ListItem Value="">&lt;בחר מסגרת&gt;</asp:ListItem>
										</asp:DropDownList>
									</InsertItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="ת התחלה" SortExpression="StartDate">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
									</EditItemTemplate>
									<InsertItemTemplate>
										<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
											ControlToValidate="tbsdate" Display="Dynamic" ErrorMessage="חובה לבחור בתאריך"></asp:RequiredFieldValidator>
										<asp:RangeValidator ID="RangeValidator1" runat="server" 
											ControlToValidate="tbsdate" Display="Dynamic" ErrorMessage="תאריך לא חוקי" 
											MaximumValue="2015-1-1" MinimumValue="1980-1-1" Type="Date"></asp:RangeValidator>
										<asp:TextBox ID="tbsdate" runat="server" Text='<%# Bind("StartDate") %>'></asp:TextBox>
									</InsertItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label4" runat="server" Text='<%# Bind("StartDate") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="תפקיד" SortExpression="JobName">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("JobName") %>'></asp:TextBox>
									</EditItemTemplate>
									<InsertItemTemplate>
										<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
											ControlToValidate="ddljobs" Display="Dynamic" ErrorMessage="חובה תפקיד"></asp:RequiredFieldValidator>
										<asp:DropDownList ID="ddljobs" runat="server" AppendDataBoundItems="True" 
											DataSourceID="dsjobs" DataTextField="JobName" DataValueField="JobID" 
											SelectedValue='<%# Bind("JobID") %>'>
											<asp:ListItem Value="">&lt;בחירת תפקיד&gt;</asp:ListItem>
										</asp:DropDownList>
									</InsertItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label2" runat="server" Text='<%# Bind("JobName") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:CommandField CancelText="ביטול" DeleteText="מחיקה" InsertText="הוספה" 
									ShowEditButton="True" ShowInsertButton="True" UpdateText="עדכון" />
							</Fields>
						</asp:DetailsView>
					</td>
				</tr>
			</table>	
			
			<asp:SqlDataSource ID="DSLIST" runat="server" 
				ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
				SelectCommand="p0p_SurveyList" CancelSelectOnNullParameter="False" 
				SelectCommandType="StoredProcedure" InsertCommand="p0p_SurveyAdd" InsertCommandType="StoredProcedure" UpdateCommand="p0p_SurveyAdd" 
				UpdateCommandType="StoredProcedure">
				<SelectParameters>
					<asp:ControlParameter ControlID="DDLSURVEYS" Name="SurveyID" 
						PropertyName="SelectedValue" Type="Int32" />
					<asp:ControlParameter ControlID="TBID" DefaultValue="" Name="ID" 
						PropertyName="Text" Type="Int64" />
					<asp:ControlParameter ControlID="TBNAME" DefaultValue=" " Name="Name" 
						PropertyName="Text" Type="String" />
					<asp:ControlParameter ControlID="ddlframe" Name="FrameID" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="RBLP" Name="PPP" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="RBLD" Name="DDD" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="TBCNT" Name="cnt" PropertyName="Text" 
						Type="Int32" DefaultValue="999" />
				</SelectParameters>
				<UpdateParameters>
					<asp:Parameter Name="OpType" Type="Int32" />
					<asp:Parameter Name="SurveyID" Type="Int32" />
					<asp:Parameter Name="ID" Type="Int32" />
					<asp:Parameter Name="FirstName" Type="String" />
					<asp:Parameter Name="LastName" Type="String" />
					<asp:Parameter Name="FrameID" Type="Int32" />
					<asp:Parameter Name="SDate" Type="DateTime" />
					<asp:Parameter Name="JobID" Type="Int32" />
				</UpdateParameters>
				<InsertParameters>
					<asp:Parameter Name="OpType" Type="Int32" DefaultValue="1" />
					<asp:ControlParameter ControlID="DDLSURVEYS" Name="SurveyID" 
						PropertyName="SelectedValue" Type="Int32" />
					<asp:Parameter Name="FrameID" Type="Int32" />
					<asp:Parameter Name="ID" Type="Int64" />
					<asp:Parameter Name="FirstName" Type="String" />
					<asp:Parameter Name="LastName" Type="String" />
					<asp:Parameter Name="JobID" Type="Int32" />
					<asp:Parameter Name="Startdate" Type="DateTime" />
				</InsertParameters>
			</asp:SqlDataSource>
			
		</div>
    </div>

</asp:Content>

