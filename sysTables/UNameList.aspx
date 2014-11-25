<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ServiceList.aspx.vb" Inherits="ServiceList" title="בית אקשטיין - הגדרת משתמשים" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px; height: 90px;">
                <asp:SqlDataSource ID="DSServices" runat="server" 
					ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
					SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]">
				</asp:SqlDataSource>
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="טבלת משתמשים" Width="161px"></asp:Label></td>
            <td style="width: 283px; height: 90px;" width="100">
                הקש שם משתמש לסינון הרשימה</td>
            <td style="width: 100px; height: 90px;">
                <asp:TextBox ID="TBUN" runat="server" AutoPostBack="True"></asp:TextBox>
            </td>
            <td style="width: 100px; height: 90px;">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 808px;" valign="top" colspan="3">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="DSUsers" EmptyDataText="There are no data records to display." AllowPaging="True" CellPadding="4" DataKeyNames="UserID"  >
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
        <asp:Button ID="btnDel" runat="server" Text="מחיקה"
            CommandName="Delete" OnClientClick="return confirm('האם למחוק את רשומת המשתמש?');" />
                </ItemTemplate>
                <EditItemTemplate></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LNKBUPD" runat="server" CausesValidation="True" CommandName="Update"
                        Text="עדכון"></asp:LinkButton>
                    <asp:LinkButton ID="LNKBCAN" runat="server" CausesValidation="False" CommandName="Cancel"
                        OnClick="LinkButton2_Click1" Text="ביטול"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LNKBEDIT" runat="server" CausesValidation="False" CommandName="Edit"
                        OnClick="LinkButton2_Click" Text="עריכה"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
        <asp:Button ID="btnzero" runat="server" Text="איפוס" OnClick="Button1_Click"
                      OnClientClick="return confirm('האם לאפס את סיסמת המשתמש?');" />
                </ItemTemplate>
                <EditItemTemplate></EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="קוד" SortExpression="UserID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Enabled="False" Text='<%# Eval("UserID") %>'
                        Width="27px"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="LBLID" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="שם משתמש" SortExpression="UserName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged1" Text='<%# Bind("UserName") %>'
                        Width="84px" AutoPostBack="True"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="CVUN" runat="server" ControlToValidate="TextBox2"
                        Display="Dynamic" ErrorMessage="השם קיים" SetFocusOnError="True"></asp:CustomValidator>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="LBLUN" runat="server" Text='<%# Bind("UserName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="אזור/חטיבה" SortExpression="Service">
                <EditItemTemplate>
                     <asp:DropDownList ID="DDLSERVICE" runat="server" DataSourceID="DSServices" 
                        DataTextField="ServiceName" DataValueField="ServiceID" AutoPostBack="True" 
                        AppendDataBoundItems="True" SelectedValue='<%# Bind("ServiceID") %>'>
                        <asp:ListItem Text="<בחר אזור>" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameName">
                <EditItemTemplate>
                 <asp:SqlDataSource runat="server" ID="DSFRAMES"
               ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                SelectCommand="Select FrameName, FrameID, ServiceID FROM FrameList" 
                FilterExpression="ServiceID = '{0}'">
                <FilterParameters>
                <asp:ControlParameter Name="ServiceID" ControlID="ddlservice" 
                     PropertyName="SelectedValue" />
                </FilterParameters>                        
            </asp:SqlDataSource>
					<asp:DropDownList ID="DDLFRAME" runat="server" DataSourceID="DSFrames" EnableViewState="false" 
                        DataTextField="FrameName" DataValueField="FrameID" 
                        AppendDataBoundItems="True" onprerender="DDLFRAME_PreRender" 
						onselectedindexchanged="DDLFRAME_SelectedIndexChanged">
                        <asp:ListItem Text="<בחר מסגרת>" Value=""></asp:ListItem>
                    </asp:DropDownList>
                     <asp:HiddenField ID="HDNFRAMEID" runat="server" 
						Value='<%# Bind("FrameID") %>' />
               </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="קבוצה" SortExpression="UserGroupID">
                <EditItemTemplate>
                    &nbsp;<asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="DSGroup"
                        DataTextField="UserGroupName" DataValueField="UserGroupID" SelectedValue='<%# Bind("UserGroupID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("UserGroupName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="שם להצגה" SortExpression="URName">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("URName") %>' CausesValidation="True" Width="84px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="TextBox3"
                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("URName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="דוא&quot;ל">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("UEmail") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox5"
                        Display="Dynamic" ErrorMessage="כתובת EMAIL לא חוקית" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("UEmail") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="תז" SortExpression="EmployeeID">
				<ItemTemplate>
					<asp:Label ID="Label4" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
				</ItemTemplate>
				<EditItemTemplate>
					<asp:TextBox ID="TBID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:TextBox>
					<asp:RangeValidator ID="RangeValidator1" runat="server" 
						ErrorMessage="מספר לא חוקי" ControlToValidate="TBID" Display="Dynamic" 
						MaximumValue="999999999" MinimumValue="100000" Type="Integer"></asp:RangeValidator>
				</EditItemTemplate>
			</asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="UserID,UserName" 
                DataNavigateUrlFormatString="p0aUserRows.aspx?UserID={0}&amp;UserName={1}" 
                HeaderText="הרשאות" Text="הרשאות" Target="_blank" />
            <asp:HyperLinkField DataNavigateUrlFields="UserID,UserName" 
                DataNavigateUrlFormatString="p0aUserRowsB.aspx?UserID={0}&amp;UserName={1}" 
                HeaderText="הרשאות תקציב" Text="הרשאות" Target="_blank" />
            <asp:TemplateField></asp:TemplateField>
            <asp:TemplateField></asp:TemplateField>
        </Columns>
    </asp:GridView>
                <asp:SqlDataSource ID="DSGroup" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
                    SelectCommand="SELECT [UserGroupName], [UserGroupID] FROM [p0t_UGroup] ORDER BY [UserGroupID] DESC">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DSUsers" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
                    DeleteCommand="DELETE FROM [p0t_Ntb] WHERE [UserID] = @UserID" InsertCommand="INSERT INTO p0t_Ntb(UserName, Password, ServiceID, FrameID, UserGroupID, URName, UEmail,EmployeeID) VALUES (ltrim(rtrim(CASE ISNUMERIC(@UserName) WHEN 1 THEN CAST(CAST(@UserName AS int) As varchar(15)) ELSE REPLACE(@UserName,'''','''''') END)),ltrim(rtrim(CASE ISNUMERIC(@UserName) WHEN 1 THEN CAST(CAST(@UserName AS int) As varchar(15)) ELSE REPLACE(@UserName,'''','''''') END)), @ServiceID, @FrameID, @UserGroupID, @URName, @UEmail,@EmployeeID)"
                    SelectCommand="SELECT p0t_Ntb.UserID, p0t_Ntb.UserName, p0t_Ntb.Password, p0t_Ntb.ServiceID, p0t_Ntb.FrameID, p0t_Ntb.UserGroupID, p0t_Ntb.URName, ServiceList.ServiceName, FrameList.FrameName, p0t_UGroup.UserGroupName, p0t_Ntb.UEmail,EmployeeID FROM p0t_Ntb LEFT OUTER JOIN p0t_UGroup ON p0t_Ntb.UserGroupID = p0t_UGroup.UserGroupID LEFT OUTER JOIN FrameList ON p0t_Ntb.FrameID = FrameList.FrameID LEFT OUTER JOIN ServiceList ON p0t_Ntb.ServiceID = ServiceList.ServiceID WHERE p0t_Ntb.UserGroupID<>31 AND (p0t_Ntb.UserName LIKE N'%' + ISNULL(@TBUN, p0t_Ntb.UserName) + N'%')"
                    
                    UpdateCommand="UPDATE p0t_Ntb SET UserName = ltrim(rtrim(CASE ISNUMERIC(REPLACE(@UserName,'''','''''')) WHEN 1 THEN CAST(CAST(@UserName AS int) As varchar(15)) ELSE REPLACE(@UserName,'''','''''') END)),  ServiceID = @ServiceID, FrameID = @FrameID, UserGroupID = @UserGroupID, URName = REPLACE(@URName,'''',''''''), UEmail = @UEmail,EmployeeID = @EmployeeID WHERE (UserID = @UserID)" 
                    CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="TBUN" Name="TBUN" PropertyName="Text" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="UserID" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="UserName" />
                        <asp:Parameter Name="ServiceID" />
                       <asp:Parameter Name="FrameID" />
                        <asp:Parameter Name="UserGroupID" />
                        <asp:Parameter Name="URName" />
                        <asp:Parameter Name="UEmail" />
                        <asp:Parameter Name="UserID" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="UserName" />
                        <asp:Parameter Name="ServiceID" />
                         <asp:ControlParameter Name="FrameID" ControlID="DetailsView1$DropDownlist2" PropertyName="SelectedValue" Type="Int32"/>
                        <asp:Parameter Name="UserGroupID" />
                        <asp:Parameter Name="URName" />
                        <asp:Parameter Name="UEmail" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </td>
            <td style="width: 100px; height: 808px;" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False"
                    DataSourceID="DSUsers" DefaultMode="Insert" Height="50px" Width="125px" HeaderText="הוספת משתמש" DataKeyNames="UserID">
                    <Fields>
                        <asp:TemplateField HeaderText="שם משתמש" SortExpression="UserName">
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" AutoPostBack="True" Text='<%# Bind("UserName") %>'
                                    Width="88px" OnTextChanged="TextBox2_TextChanged" CausesValidation="True"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox2"
                                    Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>&nbsp;
                                <asp:CustomValidator ID="CVUN" runat="server" ControlToValidate="TextBox2"
                                    Display="Dynamic" ErrorMessage="השם קיים" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                &nbsp;
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שירות" SortExpression="ServiceID">
                            <InsertItemTemplate>
                                <asp:SqlDataSource ID="DSServices" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
                                    SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLSERVICED" runat="server" AppendDataBoundItems="True" DataSourceID="DSServices"
                                    DataTextField="ServiceName" DataValueField="ServiceID" 
                                    SelectedValue='<%# Bind("ServiceID") %>' AutoPostBack="True">
                                    <asp:ListItem Value="" Selected="True">&lt;כל השירותים&gt;</asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameID">
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                &nbsp;<asp:SqlDataSource ID="DSFrames" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                   
                                    SelectCommand="SELECT FrameName, FrameID, ServiceID FROM FrameList WHERE (ServiceID = @ServiceID) ORDER BY FrameName">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="DetailsView1$DDLSERVICED" Name="ServiceID" 
                                            PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True"
                                    DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" >
                                    <asp:ListItem Value="">&lt;כל המסגרות&gt;</asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                &nbsp;
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="קבוצה" SortExpression="UserGroupID">
                            <EditItemTemplate>
                                &nbsp;
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="DSGroup"
                                    DataTextField="UserGroupName" DataValueField="UserGroupID" SelectedValue='<%# Bind("UserGroupID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                &nbsp;
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם להצגה" SortExpression="URName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("URName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" CausesValidation="True" Text='<%# Bind("URName") %>'
                                    Width="82px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox3"
                                    Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("URName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="דוא&quot;ל">
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("UEmail") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox6"
                                    Display="Dynamic" ErrorMessage="כתובת EMAIL לא חוקית" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="תז">
							<ItemTemplate>
								<asp:Label ID="Label3" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
							</ItemTemplate>
							<EditItemTemplate>
								<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:TextBox>
							</EditItemTemplate>
							<InsertItemTemplate>
					<asp:TextBox ID="TBID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:TextBox>
					<asp:RangeValidator ID="RangeValidator1" runat="server" 
						ErrorMessage="מספר לא חוקי" ControlToValidate="TBID" Display="Dynamic" 
						MaximumValue="999999999" MinimumValue="100000" Type="Integer"></asp:RangeValidator>
							</InsertItemTemplate>
						</asp:TemplateField>
                        <asp:CommandField CancelText="ביטול" InsertText="הוספה" ShowInsertButton="True" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
</asp:Content>

