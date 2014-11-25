<%@ Page Language="VB" MasterPageFile="~/SherutO.master" AutoEventWireup="false" CodeFile="~/Entry.aspx.vb" Inherits="Entry"  title="בית אקשטיין - דף כניסה" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="DSSERVICE" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAME" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSTB" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT p0t_Ntb.UserID, p0t_Ntb.UserName, p0t_Ntb.Password, p0t_Ntb.ServiceID, p0t_Ntb.FrameID, p0t_Ntb.UserGroupID, p0t_Ntb.URName, p0t_UGroup.UserGroupName, p0t_UGroup.Stype, ServiceList.ServiceName, FrameList.FrameName FROM p0t_Ntb LEFT OUTER JOIN FrameList ON p0t_Ntb.FrameID = FrameList.FrameID LEFT OUTER JOIN ServiceList ON p0t_Ntb.ServiceID = ServiceList.ServiceID LEFT OUTER JOIN p0t_UGroup ON p0t_Ntb.UserGroupID = p0t_UGroup.UserGroupID">
    </asp:SqlDataSource>
    <div runat="server" id="divform">
                <asp:Label ID="LBLCLS" runat="server" Font-Size="16pt" 
        Width="219px" Visible="False"
        BackColor="Red" ForeColor="#FFFFCC"></asp:Label>
        <div class="login">
		<!--[if !IE]><!-->
		<!--<![endif]-->	
        <asp:FormView ID="FVLOGIN" runat="server" DataKeyNames="UserID" 
			DataSourceID="DSTB" DefaultMode="Insert" BackColor="#C0C0FF" 
			BorderColor="#0000C0" BorderWidth="1px" > 
			<InsertItemTemplate>
				  <table cellpadding="4">
					<tr>
						<td style="width: 100px">
							<asp:Label ID="Label3" runat="server" Text="שם משתמש" Width="81px"></asp:Label>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
								Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						<td style="width: 100px">
							<asp:TextBox ID="TextBox1" runat="server" Width="100px"></asp:TextBox></td>
					</tr>
					<tr>
						<td style="width: 100px">
							<asp:Label ID="Label4" runat="server" Text="סיסמא"></asp:Label>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
								Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
						<td style="width: 100px">
							<asp:TextBox ID="TextBox2" runat="server" TextMode="Password" Width="100px"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td style="width: 100px">
							<br />
							<asp:Button ID="BTNLOGIN" runat="server" Text="כניסה" OnClick="Button1_Click" OnPreRender="Button2_PreRender" /></td>
						<td style="width: 100px">
							<asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="TextBox2"
								Display="Dynamic" ErrorMessage="*"></asp:CustomValidator>
						</td>
					</tr>
                    <tr>
                        <td>
                             <button id="btnf" style="width:90px;background:none;border:0;color:#0000ff;text-decoration:underline;cursor:pointer;" onclick="window.open('/RequestPW.aspx', null, 'toolbar=no,location=center,status=yes,menubar=no,scrollbars=no,alwaysRaised=yes,resizable=no,width=400,height=295');return false;">שכחתי סיסמא</button>
                        </td>
                    </tr>
				</table>
			</InsertItemTemplate>
		</asp:FormView>
	</div>
	</div>
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
  </div>
</asp:Content>

