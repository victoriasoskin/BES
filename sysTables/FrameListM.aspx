<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FrameListM.aspx.vb" Inherits="Default2" title="בית אקשטיין - ניהול מסגרות" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px; height: 48px;">
                <asp:Label ID="Label5" runat="server" Font-Size="Large" Text="טבלת מסגרות" Width="132px"></asp:Label></td>
            <td style="width: 136px; height: 48px;">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 487px;" valign="top">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" DataKeyNames="Frameid" DataSourceID="SqlDataSource1"
        EmptyDataText="There are no data records to display." CellPadding="4" 
                    ForeColor="#333333" EnableModelValidation="True">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update"
                        Text="עדכון"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel"
                        Text="ביטול"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit"
                        Text="עריכה"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                        Text="מחיקה" OnClientClick="return confirm('האם למחוק את המסגרת?');"
                        ></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="שם מסגרת" SortExpression="FrameName">
                <EditItemTemplate>
                    &nbsp;
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FrameName") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                        Display="None" ErrorMessage="שם מסגרת ריק" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="שם מנהל" SortExpression="FrameManager">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FrameManager") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                        Display="None" ErrorMessage="שם מנהל ריק" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("FrameManager") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
<asp:TemplateField HeaderText="ת. התחלה" SortExpression="ManagerStartDate">
<ItemTemplate>
                    <asp:Label ID="Label9" runat="server" 
                        Text='<%# Bind("ManagerStartDate", "{0:d}") %>'></asp:Label>
                
</ItemTemplate>

    <EditItemTemplate>
        <asp:TextBox ID="TextBox4" runat="server" Height="18px" 
            Text='<%# Bind("ManagerStartDate", "{0:d}") %>' Width="80px"></asp:TextBox>
        <asp:RangeValidator ID="RangeValidator3" runat="server" 
            ControlToValidate="TextBox4" Display="Dynamic" ErrorMessage="תאריך לא חוקי" 
            MaximumValue="1/1/2020" MinimumValue="1/1/1980" Type="Date"></asp:RangeValidator>
    </EditItemTemplate>
</asp:TemplateField>
            <asp:TemplateField HeaderText="איזור/חטיבה" SortExpression="ServiceID">
                 <ItemTemplate>
                                    <asp:Label ID="Label29" runat="server" 
                                        Text='<%# Bind("ServiceName") %>'></asp:Label>
                
                </ItemTemplate>
               <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("ServiceID") %>' DataSourceID="SqlDataSource2" DataTextField="ServiceName" DataValueField="ServiceID">
                    </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email" SortExpression="Email">
                <EditItemTemplate>
                    &nbsp;<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox3"
                        Display="Dynamic" ErrorMessage="כתובת דואר במבנה לא חוקי" SetFocusOnError="True"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">כתובת דואר במבנה לא חוקי</asp:RegularExpressionValidator>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle HorizontalAlign="Left" Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="יעד תמיכות (%)">
                <EditItemTemplate>
                    <asp:TextBox ID="TBST" runat="server" Text='<%# Bind("SuppTarget") %>' Width="24px"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBST"
                        Display="Dynamic" ErrorMessage="חייב להיות בין 0 ל 100" MaximumValue="100" MinimumValue="0"
                        Type="Double"></asp:RangeValidator>&nbsp;
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("SuppTarget") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="לקות">
                <EditItemTemplate>
                    <asp:DropDownList ID="ddllakut" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="dslakut" DataTextField="Lakut" DataValueField="LakutID" 
                        SelectedValue='<%# Bind("LakutID") %>'>
                        <asp:ListItem Value="">&lt;בחר לקות&gt;</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("Lakut") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="סוג שירות">
                <EditItemTemplate>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="Ddlservicetype" Display="Dynamic" 
                        ErrorMessage="חובה לבחור סוג שירות"></asp:RequiredFieldValidator>
                    <asp:DropDownList ID="Ddlservicetype" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="dsservicetype" DataTextField="ServiceType" 
                        DataValueField="ServiceTypeID" SelectedValue='<%# Bind("ServiceTypeID") %>'>
                        <asp:ListItem Value="">&lt;בחר סוג שירות&gt;</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label7" runat="server" Text='<%# Eval("ServiceType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        	<asp:TemplateField HeaderText="קבוצת גיל" SortExpression="Age">
				<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                </ItemTemplate>
				<EditItemTemplate>
					<asp:DropDownList ID="DDLAGE" runat="server" DataSourceID="DSAGE" 
						DataTextField="Age" DataValueField="AgeID" SelectedValue='<%# Bind("AgeID") %>' AppendDataBoundItems="true">
							<asp:ListItem Text="&lt;בחר גיל&gt;" Value=""></asp:ListItem>
					</asp:DropDownList>
				</EditItemTemplate>
				<ItemTemplate>
					<asp:Label ID="Label8" runat="server" Text='<%# Eval("Age") %>'></asp:Label>
				</ItemTemplate>
			</asp:TemplateField>
        	<asp:TemplateField HeaderText="סוג שנת עבודה" SortExpression="YearType">
                <EditItemTemplate>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="DropDownList4" Display="Dynamic" 
                        ErrorMessage="חובה לבחור סוג שנה"></asp:RequiredFieldValidator>
                    <asp:DropDownList ID="DropDownList4" runat="server" 
                        SelectedValue='<%# Bind("YearType") %>'>
                        <asp:ListItem Value="">[בחר]</asp:ListItem>
                        <asp:ListItem Value="C">קלנדרית</asp:ListItem>
                        <asp:ListItem Value="A">אקדמית</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" 
                        Text='<%# if(Eval("YearType") is DBNULL.Value,"",if(Eval("YearType")="C","קלנדרית","אקדמית")) %>'></asp:Label>
                </ItemTemplate>
             </asp:TemplateField>
			<asp:CheckBoxField DataField="W_1" HeaderText="איכות חיים" 
				SortExpression="W_1" />
			<asp:CheckBoxField DataField="W_2" HeaderText="איכות חיים לתלמיד" 
				SortExpression="W_2" />
			<asp:CheckBoxField DataField="W_3" HeaderText="SIS" SortExpression="W_3" />
        </Columns>
        <FooterStyle BackColor="#37A5FF" Font-Bold="True" ForeColor="White" />
        <RowStyle BackColor="#EFF3FB" />
        <EditRowStyle BackColor="#2461BF" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <PagerStyle BackColor="#37A5FF" ForeColor="White" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
        <EmptyDataTemplate>
אין נתונים להצגה
        </EmptyDataTemplate>
    </asp:GridView>
            </td>
            <td style="width: 136px; height: 487px;" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="FrameID"
                    DataSourceID="SqlDataSource1" DefaultMode="Insert" Height="50px" 
                    Width="125px" HeaderText="הוספת מסגרת" EnableModelValidation="True">
                    <Fields>
                        <asp:BoundField DataField="FrameID" HeaderText="FrameID" InsertVisible="False" ReadOnly="True"
                            SortExpression="FrameID" Visible="False" />
                        <asp:TemplateField HeaderText="שם המסגרת" SortExpression="FrameName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FrameName") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1"
                                    Display="Dynamic" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("FrameName") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שם המנהל" SortExpression="FrameManager">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FrameManager") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("FrameManager") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="TextBox2"
                                    Display="Dynamic" ErrorMessage="RequiredFieldValidator">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("FrameManager") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
<asp:TemplateField HeaderText="תאריך התחלה">
<ItemTemplate>
                                <asp:Label ID="Label9" runat="server"></asp:Label>
                            
</ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox>
    </EditItemTemplate>
    <InsertItemTemplate>
        <asp:TextBox ID="TextBox5" runat="server" Height="23px" Width="80px" Text='<%# Bind("ManagerStartDate", "{0:d}") %>' ></asp:TextBox>
                <asp:RangeValidator ID="RangeValidator3" runat="server" 
            ControlToValidate="TextBox5" Display="Dynamic" ErrorMessage="תאריך לא חוקי" 
            MaximumValue="1/1/2020" MinimumValue="1/1/1990" Type="Date"></asp:RangeValidator>
    </InsertItemTemplate>
</asp:TemplateField>
                        <asp:TemplateField HeaderText="איזור/חטיבה" SortExpression="ServiceID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("ServiceID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="SqlDataSource2"
                                    DataTextField="ServiceName" DataValueField="ServiceID" SelectedValue='<%# Bind("ServiceID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="דואר אלק'" SortExpression="Email">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TextBox4"
                                    Display="Dynamic" ErrorMessage="כתובת דואל לא חוקית" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">כתובת דואל לא חוקית</asp:RegularExpressionValidator>
                            </InsertItemTemplate>
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("ServiceID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="יעד תמיכות (%)" SortExpression="SuppTarget">
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("SuppTarget") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("SuppTarget") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TBST" runat="server" Text='<%# Bind("SuppTarget") %>' Width="64px"></asp:TextBox>
                                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TBST"
                                    Display="Dynamic" ErrorMessage="חייב להיות מספר בין 0 ל 100" MaximumValue="100"
                                    MinimumValue="0"></asp:RangeValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="לקות">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddllakut" runat="server" AppendDataBoundItems="True" 
                                    DataSourceID="dslakut" DataTextField="Lakut" DataValueField="LakutID" SelectedValue='<%# Bind("LakutID") %>'>
                                    <asp:ListItem Value="">&lt;בחר לקות&gt;</asp:ListItem>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="סוג שירות" SortExpression="ServiceTypeID">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("ServiceTypeID") %>' 
									Height="22px"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlServicetype" runat="server" 
                                    AppendDataBoundItems="True" DataSourceID="dsservicetype" 
                                    DataTextField="ServiceType" DataValueField="ServiceTypeID" SelectedValue='<%# Bind("ServiceTypeID") %>'>
                                    <asp:ListItem Value="">&lt;בחר סוג שירות&gt;</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                    ControlToValidate="ddlServicetype" Display="Dynamic" 
                                    ErrorMessage="חובה לבחור סוג שירות"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("ServiceTypeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="קבוצת גיל" SortExpression="Age">
							<InsertItemTemplate>
								<asp:DropDownList ID="DDLAGE" runat="server" DataSourceID="DSAGE" 
									DataTextField="Age" DataValueField="AgeID" AppendDataBoundItems="true" SelectedValue='<%# Bind("AgeID") %>'>
										<asp:ListItem Text="&lt;בחר גיל&gt;" Value=""></asp:ListItem>
								</asp:DropDownList>
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label ID="Label8" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
							</ItemTemplate>
						</asp:TemplateField>
                        <asp:TemplateField HeaderText="סוג שנת עבודה" SortExpression="YearType">
							<EditItemTemplate>
								<asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("YearType") %>'></asp:TextBox>
							</EditItemTemplate>
							<InsertItemTemplate>
                   <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="DropDownList4" Display="Dynamic" 
                        ErrorMessage="חובה לבחור סוג שנה"></asp:RequiredFieldValidator>
                    <asp:DropDownList ID="DropDownList4" runat="server" 
                        SelectedValue='<%# Bind("YearType") %>'>
                        <asp:ListItem Value="">[בחר]</asp:ListItem>
                         <asp:ListItem Value="C">קלנדרית</asp:ListItem>
                        <asp:ListItem Value="A">אקדמית</asp:ListItem>
                   </asp:DropDownList>
							</InsertItemTemplate>
							<ItemTemplate>
								<asp:Label ID="Label7" runat="server" 
									Text='<%# Bind("YearType") %>'></asp:Label>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:CheckBoxField DataField="W_1" HeaderText="שאלוני איכות חיים" 
							SortExpression="W_1" />
						<asp:CheckBoxField DataField="W_2" HeaderText="שאלוני איכות חיים לתלמיד" 
							SortExpression="W_2" />
						<asp:CheckBoxField DataField="W_3" HeaderText="שאלוני SIS" 
							SortExpression="W_3" />
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                    </Fields>
                </asp:DetailsView>
                <asp:SqlDataSource ID="dsservicetype" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    SelectCommand="SELECT [ServiceType], [ServiceTypeID] FROM [p5t_ServiceType]">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="DSAGE" runat="server" 
					ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
					SelectCommand="SELECT [Age], [AgeID] FROM [p0t_Age]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="dslakut" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    SelectCommand="SELECT [Lakut], [LakutID] FROM [p5t_Lakut]">
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [FrameList] WHERE [FrameID] = @FrameID" InsertCommand="INSERT INTO FrameList(FrameName, FrameManager, ServiceID, Email, LakutID, ServiceTypeID, W_1, W_2, W_3, YearType, AgeID, ManagerStartDate) VALUES (@FrameName, @FrameManager, @ServiceID, @Email, @LakutID, @ServiceTypeID, @W_1, @W_2, @W_3, @YearType, @AgeID, @ManagerStartDate)"
        SelectCommand="SELECT FrameList.FrameID, FrameList.FrameName, FrameList.FrameManager, FrameList.ServiceID, FrameList.Email, ServiceList.ServiceName, FrameList.PaymentType, FrameList.SuppTarget, FrameList.LakutID, p5t_Lakut.Lakut, p5t_ServiceType.ServiceType, FrameList.W_1, FrameList.W_2, FrameList.W_3, FrameList.ServiceTypeID, FrameList.YearType, FrameList.AgeID, p0t_Age.Age, FrameList.ManagerStartDate FROM FrameList LEFT OUTER JOIN p0t_Age ON FrameList.AgeID = p0t_Age.AgeID LEFT OUTER JOIN p5t_Lakut ON FrameList.LakutID = p5t_Lakut.LakutID LEFT OUTER JOIN p5t_ServiceType ON FrameList.ServiceTypeID = p5t_ServiceType.ServiceTypeID LEFT OUTER JOIN ServiceList ON FrameList.ServiceID = ServiceList.ServiceID ORDER BY FrameList.FrameName"
        
        
        
		
		
		
        UpdateCommand="UPDATE FrameList SET FrameName = @FrameName, FrameManager = @FrameManager, ServiceID = @ServiceID, Email = @Email, SuppTarget = @SuppTarget, LakutID = @LakutID, ServiceTypeID = @ServiceTypeID, W_1 = @W_1, W_2 = @W_2, W_3 = @W_3, YearType = @YearType, AgeID = @AgeID, ManagerStartDate = @ManagerStartDate WHERE (FrameID = @FrameID)">
        <DeleteParameters>
            <asp:Parameter Name="FrameID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="FrameName" Type="String" />
            <asp:Parameter Name="FrameManager" Type="String" />
            <asp:Parameter Name="ServiceID" Type="Int32" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="SuppTarget" Type="Double" />
            <asp:Parameter Name="LakutID" />
            <asp:Parameter Name="ServiceTypeID" />
            <asp:Parameter Name="W_1" />
			<asp:Parameter Name="W_2" />
			<asp:Parameter Name="W_3" />
            <asp:Parameter Name="YearType" />
            <asp:Parameter Name="AgeID" />
            <asp:Parameter Name="ManagerStartDate" Type="DateTime" />
            <asp:Parameter Name="FrameID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="FrameName" Type="String" />
            <asp:Parameter Name="FrameManager" Type="String" />
            <asp:Parameter Name="ServiceID" Type="Int32" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="LakutID" />
            <asp:Parameter Name="ServiceTypeID" />
        	<asp:Parameter Name="W_1" />
			<asp:Parameter Name="W_2" />
			<asp:Parameter Name="W_3" />
        	<asp:Parameter Name="YearType" />
        	<asp:Parameter Name="AgeID" />
            <asp:Parameter Name="ManagerStartDate" Type="DateTime" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [ServiceName], [ServiceID] FROM [ServiceList]"></asp:SqlDataSource>
</asp:Content>

