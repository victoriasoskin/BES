<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="EmpForm.aspx.vb" Inherits="EmpForm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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
	<div>
		<br />
		<table style="width: 100%">
			<tr>
				<td colspan="2">
					<asp:Label runat="server" ID="LBLHDR" Font-Bold="True" Font-Size="Large" 
						ForeColor="Blue" Width="150px">����� �������</asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					<asp:Label runat="server" ID="lblhlp" Text=" ��� ������ �������" 
						Font-Bold="True" />
					<asp:RadioButtonList ID="RBLTYPE" runat="server" AutoPostBack="true"
						RepeatDirection="Horizontal" Width="187px" AppendDataBoundItems="True">
							<asp:ListItem Value="1" Selected="True">����� ����</asp:ListItem>
<%--							<asp:ListItem Value="2">����� ����</asp:ListItem>
--%>					</asp:RadioButtonList>
				</td>
				<td valign="bottom">
					<asp:Button ID="Button4" runat="server" Text="����" />
				</td>
			</tr>
		</table>
	</div>
	<asp:ScriptManager ID="ScriptManager1" runat="server" />

	<div id="divhelp" runat="server" visible="false">
		<table border="1">
			<tr>
				<td>
					��� ����� ���� ���� ���� ����� �� ����� ������ ����.
					<br /><span style="text-decoration: underline"><b>����� ������:<br /></b></span><br />
					1. ����� ���� ����� ������: ������ ������ ����� ����, �� ���� ������, ����� 
					������ ����� (�� ����) ������.
					<br />
					<br />
					2. �� ����� ������� ������ ����� ������ ���� ��������� �� ���� ����� ������ 
					�����: �. ���� (����� ���), ���� (����� ���), ���� (����� ������), ����� ����� 
					(����� �����). ������ ����� ����� ����� ����� ����� ��� ��� �������� �� ���� 
					�����.<br />
					<br />
					3. ������� ������� ������ ����� ������� ��� ���� �� ����. ���� ������� (�������� 
					����� &quot;�����&quot; ��������, ���� ������, �� ��� ����� �� ����� ���� ������ ������� 
					����� ������.
					<br />
					<span style="text-decoration: underline"><b>����:</b></span><br />
					����� ������ �� ����� �� ����� ������.<br />
					<br />
					4. ���� ����� �����, ���� ����� �� ����� ���� ������.
				</td>
			</tr>
		</table>
	</div>
	<div runat="server" id="DIVALL" visible="false">
		<div runat="server" id="divMF" >
			<table>
				<tr>
					<td>
						<asp:DropDownList ID="DDLSERVICES" runat="server" AutoPostBack="True" 
							DataSourceID="dsservices" DataTextField="ServiceName" 
							DataValueField="ServiceID" AppendDataBoundItems="true">
                                <asp:ListItem Text="[�� ��������]" Value="" />
						</asp:DropDownList>
			<asp:SqlDataSource ID="dsservices" runat="server" 
				ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
				
							SelectCommand="SELECT ServiceName , s.ServiceID FROM ServiceList s
                                           Where ServiceID in  (Select distinct ServiceID From FrameList Where FrameID in (Select FrameID From dbo.p0v_userFrameList WHERE (UserID = @UserID))) ">
				<SelectParameters>
					<asp:SessionParameter Name="UserID" SessionField="UserID" />
				</SelectParameters>
			</asp:SqlDataSource>
			
					</td>
					<td>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT FrameName,FrameID FROM FrameList  Where ServiceID= @ServiceID And FrameID in (Select FrameID From dbo.p0v_UserFrameList Where UserID=@uSERid) "
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    					<asp:DropDownList ID="DDLFRAMES" runat="server" DataSourceID="DSFrames" 
							DataTextField="FrameName" DataValueField="FrameID" AutoPostBack="True" 
                            AppendDataBoundItems="true" EnableViewState="False">
                                <asp:ListItem Text="[�� �������]" Value="" />
						</asp:DropDownList>
					</td>
                    <td>
                        <asp:CheckBox runat="server" ID="cbshowdoc" AutoPostBack="true" Text="��� ������"  />
                    </td>
				</tr>
			</table>
			
		</div>
		<table border="1" width="100%">
			<tr>
				<td colspan="4">
					<asp:HyperLink runat="server" ID="hlactiontype" NavigateUrl="App_Docs/����_�����_����_���_������.doc" Text="����� ���� ����� ����:" Font-Bold="true"></asp:HyperLink>
				</td>
			</tr>
			<tr style="background-color:#AADDFF">
				<td valign="top" style="width: 133px">����� ������</td>
				<td valign="top">
					������ ���� ������ �� ��� �� ������ ����. ������ ��� ������� ����� ������, ��� ���� �������.
					<br />
					<asp:SqlDataSource ID="DSEMPS" runat="server"
						ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
						DeleteCommand="UPDATE [p6t_Emps] SET  [Status] = -@Status, EmpID=@EmpID WHERE [EmpID] = @EmpID" 
						InsertCommand="INSERT INTO [p6t_Emps] ([EmpID], [FirstName], [LastName], [JobID], [FirstDate], [LastDate],[BirthDate], [FrameID], [Status], EMEID,CellPhone) VALUES (@EmpID, @FirstName, @LastName, @JobID, @FirstDate, @LastDate, @Birthdate, @FrameID, @Status,@EMEID,@CellPhone)" 
						SelectCommand="SELECT e.EmpID, e.FirstName, e.LastName, e.BirthDate, e.JobID, e.FirstDate, e.LastDate, e.FrameID, e.Status, e.CellPhone,o.JobName as JobName, e.EMEID, f.EMENAME,o.mail, FrameName FROM p6t_Emps AS e LEFT OUTER JOIN p6t_EME AS f ON e.EMEID = f.EMEID LEFT OUTER JOIN p6t_jobs AS o ON o.JobID = e.JobID left outer join Framelist fl on fl.FrameID=e.FrameID WHERE (e.EmpID = ISNULL(@EmpID, 0))" 
						
						
						UpdateCommand="UPDATE [p6t_Emps] SET EmpID=@EmpID,FirstName=@FirstName,LastName=@LastName,BirthDate=@BirthDate,JobID=isnull(@JobID,JobID),CellPhone=@CellPhone, FirstDate=@FirstDate,LastDate=@LastDate,  [Status] = @Status,EMEID=@EMEID WHERE [EmpID] = @OEmpID" 
						CancelSelectOnNullParameter="False">
						<SelectParameters>
							<asp:ControlParameter ControlID="LSBEMPS" Name="EmpID" 
								PropertyName="SelectedValue" Type="Int64" />
						</SelectParameters>
						<DeleteParameters>
							<asp:controlParameter ControlID="RBLTYPE" Name="Status" Type="Int32"  />
							<asp:Parameter Name="EmpID" Type="Int64" />
						</DeleteParameters>
						<UpdateParameters>
							<asp:Parameter Name="EmpID" Type="Int64" />
							<asp:Parameter Name="FirstName" Type="String" />
							<asp:Parameter Name="LastName" Type="String" />
							<asp:Parameter Name="BirthDate" Type="DateTime"/>
							<asp:Parameter Name="JobID" Type="Int32" />
							<asp:Parameter Name="CellPhone" />
							<asp:Parameter Name="FirstDate" Type="DateTime" />
							<asp:Parameter Name="LastDate" Type="DateTime" />
							<asp:controlParameter ControlID="RBLTYPE" Name="Status" Type="Int32"  />
							<asp:Parameter Name="EMEID" Type="int32" />
						<asp:SessionParameter Name="OEmpID" SessionField="EmpID" Type="Int64" />
						</UpdateParameters>
						<InsertParameters>
							<asp:Parameter Name="EmpID" Type="Int64" />
							<asp:Parameter Name="FirstName" Type="String" />
							<asp:Parameter Name="LastName" Type="String" />
							<asp:Parameter Name="JobID" Type="Int32" />
							<asp:Parameter Name="FirstDate" Type="DateTime" />
							<asp:Parameter Name="LastDate" Type="DateTime" />
							<asp:Parameter Name="Birthdate" Type="DateTime" />
							<asp:ControlParameter Name="frameid" PropertyName="SelectedValue" ControlID="DDLFrameS" Type="Int32" />
							<asp:controlParameter ControlID="RBLTYPE" Name="Status" Type="Int32"  />
							<asp:Parameter Name="EMEID" Type="int32" />
							<asp:Parameter Name="CellPhone" />
						</InsertParameters>
					</asp:SqlDataSource>
					<asp:XmlDataSource ID="xDSJobs" runat="server" DataFile="~/App_Data/T1.xml">
					</asp:XmlDataSource>
					<asp:SqlDataSource ID="DSEME" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
						
						SelectCommand="SELECT [EMENAME], [EMEID] FROM [p6t_EME] WHERE ([ord] IS NOT NULL) ORDER BY [ord]">
					</asp:SqlDataSource>
					<asp:SqlDataSource ID="dsemplist" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
						
						SelectCommand="SELECT [LastName] + ' ' +  [FirstName] As EmpName, [EmpID] 
FROM [p6t_Emps] e
left outer join FrameList f on f.FrameID=e.frameid
where	e.frameid=isnull(@frameid,e.FrameID) And e.FrameID in (Select FrameID From dbo.p0v_UserFrameList Where UserID=@UserID) 
	And	f.ServiceID=isnull(@Serviceid,f.ServiceID) And f.ServiceID in (Select distinct ServiceID From dbo.p0v_UserFrameList Where UserID=@UserID)
		and status=@status 
order by lastname,firstname" 
						CancelSelectOnNullParameter="False">
						<SelectParameters>
							<asp:ControlParameter Name="frameid" ControlID="DDLFrameS" PropertyName="SelectedValue"  Type="int32" />
							<asp:SessionParameter Name="UserID" SessionField="UserID" />
                            <asp:ControlParameter ControlID="DDLSERVICES" Name="Serviceid" 
                                PropertyName="SelectedValue" />
							<asp:ControlParameter ControlID="RBLTYPE" Name="status" PropertyName="SelectedValue" />
						</SelectParameters>
					</asp:SqlDataSource>
				</td>
				<td valign="top">
					<asp:Label runat="server" ID="lblchecklist" 
						Text="�������� , ����� checklist ��� ������ ����� ���� ������ ����� (�������� ����� ������ �����)." 
						Width="360px" Visible="False"/>
					<br />
					<asp:label runat="server" ID="lblshuly" ForeColor="Red" 
						Text="���� ����� �� �� ������, ���� ������, ������ ���!" Width="360px" 
						Visible="False" />
					<br />
				</td>
			</tr>
			<tr>
				<td valign="top" style="width: 133px">
					<asp:ListBox ID="LSBEMPS" runat="server" AutoPostBack="True" 
						DataTextField="EmpName" DataValueField="EmpID" DataSourceID="dsemplist" 
						Height="163px">
					</asp:ListBox>
				</td>
				<td valign="top">
					<asp:Label ID="Label3" runat="server" Height="1px" Width="250px"></asp:Label>
				<asp:DetailsView ID="DVEMPS" runat="server" AutoGenerateRows="False" 
					HeaderText="���� �����" Height="50px" DataSourceID="DSEMPS" 
					DataKeyNames="EmpID" EnableModelValidation="True">
					<FooterStyle Wrap="False" />
					<FieldHeaderStyle Wrap="False" />
					<EmptyDataTemplate>
						<asp:Button runat="server" ID="btnAddEmp" CommandName="new" Text="����� �� ������" OnClick="btnAddEmp_Click"/>
					</EmptyDataTemplate>
					<Fields>
						<asp:TemplateField HeaderText="����� ����">
							<EditItemTemplate>
								<asp:UpdatePanel runat="server" ID="updee" UpdateMode="Conditional">
									<ContentTemplate>
										<asp:TextBox ID="TBEMPIDU" runat="server" Text='<%# Bind("EmpID") %>' />
										<asp:CustomValidator ID="CVEMPIDU" runat="server" ControlToValidate="TBEMPIDU"  OnServerValidate="TBEMPID_validate"
											Display="Dynamic" ErrorMessage="����� ����� ��� ����� ������" />
										<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
											ControlToValidate="TBEMPIDU" Display="Dynamic" 
											ErrorMessage="���� ����� ����� ����" />
										<asp:CustomValidator ID="CustomValidator1" runat="server" ClientValidationFunction="ValidID" 
											ControlToValidate="TBEMPIDU" Display="Dynamic" 
											ErrorMessage="���� ����� ���� �� ����" />
									</ContentTemplate>
								</asp:UpdatePanel>
							</EditItemTemplate>
					
							<InsertItemTemplate>
								<asp:UpdatePanel runat="server" ID="updei" UpdateMode="Conditional">
									<ContentTemplate>
										<asp:TextBox ID="TBEMPID" runat="server" Text='<%# Bind("EmpID") %>' OnPreRender="TBEMPID_PreRender" />
										<asp:RequiredFieldValidator ID="RequiredFieldValidator22" runat="server" 
											ControlToValidate="TBEMPID" Display="Dynamic" 
											ErrorMessage="���� ����� ����� ����" />
										<asp:CustomValidator ID="CVALID" runat="server"  ClientValidationFunction="ValidID"
											ControlToValidate="TBEMPID" Display="Dynamic" 
											ErrorMessage="���� ����� ���� �� ����" />
										<asp:CustomValidator ID="CVEMPID" runat="server" ControlToValidate="TBEMPID" OnServerValidate="TBEMPID_validate"
											Display="Dynamic" ErrorMessage="����� ����� ��� ����� ������" />
									</ContentTemplate>
								</asp:UpdatePanel>
							</InsertItemTemplate>
					
							<ItemTemplate>
								<asp:Label runat="server" ID="lblempid" Text='<%#Eval("EmpID") %>' />
							</ItemTemplate>	
						</asp:TemplateField>
				
						<asp:TemplateField HeaderText="�� ����">
							<EditItemTemplate>
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="TBFIRSTNAME" Display="Dynamic" 
									ErrorMessage="���� ����� �� ����" />
								<asp:TextBox ID="TBFIRSTNAME" runat="server" Text='<%# Bind("FirstName") %>' />
							</EditItemTemplate>
							<InsertItemTemplate>
								<asp:TextBox ID="TBFIRSTNAME" runat="server" Text='<%# Bind("FirstName") %>' />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
									ControlToValidate="TBFIRSTNAME" Display="Dynamic" 
									ErrorMessage="���� ����� �� ����" />
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label runat="server" ID="lblempfirstname" Text='<%#Eval("FirstName") %>' />
							</ItemTemplate>
						</asp:TemplateField>
				
						<asp:TemplateField HeaderText="�� �����">
							<EditItemTemplate>
								<asp:TextBox ID="TBLASTNAME" runat="server" Text='<%# Bind("LastName") %>' />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
									ControlToValidate="TBLASTNAME" Display="Dynamic" 
									ErrorMessage="���� ����� �� �����" />
							</EditItemTemplate>
							<InsertItemTemplate>
								<asp:TextBox ID="TBLASTNAME" runat="server" Text='<%# Bind("LastName") %>' />
								<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
									ControlToValidate="TBLASTNAME" Display="Dynamic" 
									ErrorMessage="���� ����� �� �����" />
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label runat="server" ID="lblemplastname" Text='<%#Eval("LastName") %>' />
							</ItemTemplate>
						</asp:TemplateField>
				
						<asp:TemplateField HeaderText="����� ����">
							<ItemTemplate>
								<asp:Label runat="server" ID="lblbd" Text='<%#Eval("BirthDate","{0:d}") %>' />
							</ItemTemplate>
							<InsertItemTemplate>
								<asp:TextBox runat="server" ID="TBBD" Text='<%#bind("BirthDate","{0:d}") %>' Tooltip="��� ����� ���� ����� dd/mm/yy" />
								<asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbbd" Display="Dynamic" ErrorMessage="���� ����� ����� ����" />
								<asp:RangeValidator runat="server" ID="rvbd" ControlToValidate="tbbd" Display="Dynamic" ErrorMessage="����� �� ����" MinimumValue="1930-1-1" MaximumValue="2007-1-1" Type="Date" />
							</InsertItemTemplate>
							<EditItemTemplate>
								<asp:TextBox runat="server" ID="TBBD" Text='<%#bind("BirthDate","{0:d}") %>' Tooltip="��� ����� ���� ����� dd/mm/yy" />
								<asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbbd" Display="Dynamic" ErrorMessage="���� ����� ����� ����" />
								<asp:RangeValidator runat="server" ID="rvbd" ControlToValidate="tbbd" Display="Dynamic" ErrorMessage="����� �� ����" MinimumValue="1930-1-1" MaximumValue="2007-1-1" Type="Date" />
							</EditItemTemplate>
						</asp:TemplateField>
			
						<asp:TemplateField HeaderText="�����">
							<EditItemTemplate>
								<table>
									<tr>
										<td>
											<asp:Label runat="server" ID="lbljob" Text='<%# eval("JobName") %>' ToolTip="������ ����� ��� ��� ������ ����� ����� �������. ������ ��� ����� ���� ������ �����." />
										</td>
									</tr>
									<tr>
										<td>
											<asp:CustomValidator ID="CVJOBS" runat="server"
												ErrorMessage="�� ����� ������" Display="Dynamic" OnServerValidate="CVJOBS_ServerValidate">�� ����� �����</asp:CustomValidator>
											<asp:Label runat="server" ID="lbljobs"  ForeColor="Red" Text="���� ����� �����" Visible="false" />
											<asp:TreeView ID="TVJOBS" runat="server" OnTreeNodePopulate="TVJOBS_TreeNodePopulate" OnSelectedNodeChanged="TVJOBS_SelectedNodeChanged"   ShowLines="true" LineImagesFolder="~/TreeImages" ShowCheckBoxes="None"
												NodeStyle-ForeColor="White" ExpandDepth="0"  OnDataBinding="TVJobs_DataBinding" PopulateNodesFromClient="true" ShowExpandCollapse="true" OnPreRender="TVJOBS_PreRender">
												<DataBindings>
													<asp:TreeNodeBinding TextField="Text" ValueField="ID" />
												</DataBindings>
												<SelectedNodeStyle BackColor="LightCyan" ForeColor="Blue" />
											</asp:TreeView>
											<asp:HiddenField runat="server" ID="HDNJOB"  Value='<%# bind("JobID") %>' />
											<asp:HiddenField runat="server" ID="hdnEME" Value='<%# bind("EMEID") %>' />
											<asp:HiddenField runat="server" ID="hdnMAIL" Value='<%# eval("Mail") %>' />
											<asp:HiddenField runat="server" ID="hdnCELL" Value='<%# eval("CellPhone") %>' />
										</td>
									</tr>
								</table>
							</EditItemTemplate>
							<InsertItemTemplate>
								<table>
									<tr>
										<td>
											<asp:Label runat="server" ID="lbljob" />
										</td>
									</tr>
									<tr>
										<td>
											<asp:Label runat="server" ID="lbljobs"  ForeColor="Red" Text="���� ����� �����" Visible="false" />
											<asp:CustomValidator ID="CVJOBS" runat="server"
													ErrorMessage="�� ����� ������" Display="Dynamic" OnServerValidate="CVJOBS_ServerValidate">�� ����� �����</asp:CustomValidator> 
											<asp:TreeView ID="TVJOBS" runat="server" OnTreeNodePopulate="TVJOBS_TreeNodePopulate"   OnSelectedNodeChanged="TVJOBS_SelectedNodeChanged"  ShowLines="true" LineImagesFolder="~/TreeImages" ShowCheckBoxes="None"
													NodeStyle-ForeColor="White" ExpandDepth="0"  OnDataBinding="TVJobs_DataBinding" PopulateNodesFromClient="true" ShowExpandCollapse="true" OnPreRender="TVJOBS_PreRender">
												<DataBindings>
													<asp:TreeNodeBinding TextField="Text" ValueField="ID" />
												</DataBindings>
												<SelectedNodeStyle BackColor="LightCyan" ForeColor="Blue" />
											</asp:TreeView>
											<asp:HiddenField runat="server" ID="HDNJOB"  Value='<%# bind("JobID") %>' />
											<asp:HiddenField runat="server" ID="hdnEME"  Value='<%# bind("EMEID") %>' />
											<asp:HiddenField runat="server" ID="hdnMAil"  Value='<%# eval("Mail") %>' />
										</td>
									</tr>
								</table>
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label runat="server" ID="lblempjob" Text='<%#Eval("JobName") %>' />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:CheckBoxField DataField="CellPhone" HeaderText="����� ������" 
							SortExpression="CellPhone" />
						<asp:TemplateField >
							<HeaderTemplate>
								<asp:Label runat="server" ID="lbleme" Text="���� �����" />
							</HeaderTemplate>
							<EditItemTemplate>
								<asp:RequiredFieldValidator ID="RFVEME" runat="server" 
									ControlToValidate="DDLEME" Display="Dynamic" ErrorMessage="���� ����� ���� �����" />
								<asp:DropDownList ID="DDLEME" runat="server" AppendDataBoundItems="True" 
									DataSourceID="DSEME" DataValueField="EMEID" DataTextField="EMENAME"
									SelectedValue='<%# Bind("EMEID") %>'>
										<asp:ListItem Value="">&lt;����� ���� �����&gt;</asp:ListItem>
								</asp:DropDownList>
							</EditItemTemplate>
							<InsertItemTemplate>
								<asp:RequiredFieldValidator ID="RFVEME" runat="server" 
									ControlToValidate="DDLEME" Display="Dynamic" ErrorMessage="���� ����� ���� �����" />
								<asp:DropDownList ID="DDLEME" runat="server" AppendDataBoundItems="True" 
									DataSourceID="DSEME" DataValueField="EMEID" DataTextField="EMENAME"
									SelectedValue='<%# Bind("EMEID") %>'>
										<asp:ListItem Value="">&lt;����� ���� �����&gt;</asp:ListItem>
								</asp:DropDownList>
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label runat="server" ID="lblempEME" Text='<%#Eval("EMEName") %>' />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField>
							<HeaderTemplate>
								<asp:Label runat="server" ID="lbldateHDR" text='<%# tDate() %>'/>
							</HeaderTemplate>
							<EditItemTemplate>
								<asp:Calendar ID="CALDATE" runat="server"  OnSelectionChanged="CALDATE_SelectionChanged" VisibleDate='<%# fDate() %>' 
									SelectedDate='<%# fDate() %>' />
								<asp:TextBox runat="server" ID="tbstam" Height="0" Width="0" Visible="false" />
								<asp:Label runat="server" ID="lbldate"  ForeColor="Red" Text="����� �� ����� ����" Visible="false" />
								<asp:CustomValidator runat="server" ID="cvcal" ControlToValidate="tbstam" Display="Dynamic" ErrorMessage="����� �� ����� ����" />
							</EditItemTemplate>
							<InsertItemTemplate>
								<asp:Calendar ID="CALDATE" runat="server"
									SelectedDate='<%# fDate() %>' onprerender="CALDATE_PreRender" OnSelectionChanged="CALDATE_SelectionChanged" />
								<asp:Label runat="server" ID="lbldate"  ForeColor="Red" Text="����� �� ����� ����" Visible="false" />
								<asp:TextBox runat="server" ID="tbstam" Height="0" Width="0" Visible="false"/>
								<asp:CustomValidator runat="server" ID="cvcal" ControlToValidate="tbstam" Display="Dynamic" ErrorMessage="����� �� ����� ����" />						
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label runat="server" ID="lbldate" Text='<%#format(fDate(),"dd/MM/yyyy") %>' />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:BoundField DataField="FrameName" HeaderText="�����" ReadOnly="True" />
						<asp:TemplateField ShowHeader="False">
							<EditItemTemplate>
								<asp:Button ID="Button1" runat="server" CausesValidation="True" 
									CommandName="Update" Text="�����" onclick="Button1_Click" />
								&nbsp;
								<asp:Button ID="Button2" runat="server" CausesValidation="False" 
									CommandName="Cancel" Text="�����" OnClick="btnCNCL_Click" />
							</EditItemTemplate>
							<InsertItemTemplate>
								<asp:Button ID="Button1" runat="server" CausesValidation="True" 
									CommandName="Insert" Text="�����" onclick="btnADD_Click" />
								&nbsp;
								<asp:Button ID="Button2" runat="server" CausesValidation="False" 
									CommandName="Cancel" Text="�����" onclick="Button2_Click" />
							</InsertItemTemplate>
							<ItemTemplate>
								<table style="width: 100%">
									<tr>
										<td>
											<asp:Button ID="Button2" runat="server" CausesValidation="False" 
												CommandName="New" Text="����� �� ������" onclick="btnAddEmp_Click" />
										</td>
										<td>
											<asp:Button ID="Button1" runat="server" CausesValidation="False" OnClick="btnNV_Click"
												CommandName="Edit" Text="����� �����" />
										</td>
										<td>
											<asp:Button ID="Button3" runat="server" CausesValidation="False"  OnClick="btnNV_Click"
												CommandName="Delete" Text="�����"  onclientclick="return confirm('��� ����� �� �����?');" />
										</td>
									</tr>
								</table>
								&nbsp;&nbsp;
							</ItemTemplate>
						</asp:TemplateField>
					</Fields>
				</asp:DetailsView>
			</td>
			<td valign="top">
				<asp:XmlDataSource ID="XDACTS" runat="server" EnableCaching="false"  ></asp:XmlDataSource>
				<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">                        
					<ContentTemplate>
						<asp:TreeView ID="TVACTS" runat="server" DataSourceID="XDACTS" Visible="false"
							RootNodeStyle-Font-Size="XX-Small" RootNodeStyle-ForeColor="White"
							AutoGenerateDataBindings="false" ExpandDepth="3" >
							<SelectedNodeStyle BackColor="#99CCFF" />
							<DataBindings>
								<asp:TreeNodeBinding  DataMember="EmpActs" Textfield="Text" Value="EmpActs" PopulateOnDemand="False" />
								<asp:TreeNodeBinding DataMember="Title" Textfield="Text" Value="Title" />
								<asp:TreeNodeBinding DataMember="Act" TextField="Text" NavigateUrlField="Url" ShowCheckBox="true" ValueField="ID" PopulateOnDemand="true" />
								<asp:TreeNodeBinding DataMember="Download" TextField="Text" NavigateUrlField="Url" />
							</DataBindings>
						</asp:TreeView>
					</ContentTemplate>
					<Triggers>
						<asp:AsyncPostBackTrigger ControlID="buttonCheck" EventName="click" />
						<asp:PostBackTrigger ControlID="LSBEMPS" />
					</Triggers>
				</asp:UpdatePanel>
				<asp:button ID="buttonCheck" runat="server" CausesValidation="false" />
			</td>
		</tr>
		<tr style="background-color:#99CCFF">
			<td style="width: 133px"></td>
			<td>&nbsp;</td>
			<td>
				<asp:Label runat="server" ID="lblmail" Text=": �������, ���� ���� ������� �����: ���, ����� ����, ���������." Visible="false" />
			</td>
		</tr>
	</table>
</div>
</asp:Content>

