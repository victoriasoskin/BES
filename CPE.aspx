<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CPE.aspx.vb" Inherits="Default3" title="בית אקשטיין - החלפת סיסמא" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT p0t_Ntb.UserID, p0t_Ntb.UserName, p0t_Ntb.Password, p0t_Ntb.ServiceID, p0t_Ntb.FrameID, p0t_Ntb.UserGroupID, p0t_Ntb.URName, p0t_Ntb.UEmail, FrameList.FrameName, ServiceList.ServiceName FROM p0t_Ntb LEFT OUTER JOIN ServiceList ON p0t_Ntb.ServiceID = ServiceList.ServiceID LEFT OUTER JOIN FrameList ON p0t_Ntb.FrameID = FrameList.FrameID WHERE (p0t_Ntb.UserID = @UserID)"
        UpdateCommand="UPDATE [p0t_Ntb] SET [Password] = @Password WHERE [UserID] = @UserID">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="USERID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:controlParameter controlid=DVPW$NEWPW2 Name="Password" Type="String" />
            <asp:Parameter Name="UserID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource> 
    <br />
    <asp:Button ID="Button2" runat="server" CausesValidation="False" Text="Button" 
        Visible="False" />
    <br />
    <br />
    <br />
    <br />
    <asp:DetailsView ID="DVPW" runat="server" AutoGenerateRows="False" DataKeyNames="UserID"
        DataSourceID="SqlDataSource1" Height="50px" Width="125px" DefaultMode="Edit" HeaderText="שינוי סיסמא">
        <Fields>
            <asp:BoundField DataField="UserID" HeaderText="UserID" InsertVisible="False" ReadOnly="True"
                SortExpression="UserID" Visible="False" />
            <asp:BoundField DataField="UserName" HeaderText="שם משתמש" ReadOnly="True" SortExpression="UserName" >
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField  SortExpression="Password">
                <HeaderTemplate>
                    <asp:Label runat="server" ID="lblhtcol" Text="סיסמא ישנה" OnPreRender="lblhtcol_PreRender" />
                </HeaderTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="OLDPW" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="OLDTBC"
                        ControlToValidate="OLDPW" ErrorMessage="הסיסמא אינה נכונה"
                        Text='הסיסמא אינה נכונה' Display="Dynamic" ForeColor="Salmon"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="OLDPW"
                        Display="Dynamic" ErrorMessage="הסיסמא אינה נכונה" ForeColor="Salmon"></asp:RequiredFieldValidator>
                    <asp:TextBox ID="OLDTBC" runat="server" 
                        Text='<%# DecryptText(Eval("Password")) %>' Visible="False"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    &nbsp;
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="סיסמא חדשה">
                <EditItemTemplate>
                    <asp:TextBox ID="NEWPW1" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="NEWPW1"
                        Display="Dynamic" ErrorMessage="חובה להקיש סיסמא חדשה" ForeColor="Salmon"></asp:RequiredFieldValidator>
<%--                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="NEWPW1"
                        ErrorMessage="אינו תואם את הגדרות מבנה סיסמא חוקי" ValidationExpression="(?!^[0-9]*$)(?!^[א-תa-zA-Z]*$)^([א-תa-zA-Z0-9]{6,20})$" Display="Dynamic" ForeColor="Salmon"></asp:RegularExpressionValidator>
--%>                </EditItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="סיסמא חדשה שנית">
                <EditItemTemplate>
                    <asp:TextBox ID="NEWPW2" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="NEWPW2"
                        Display="Dynamic" ErrorMessage="חובה להקיש סיסמא חדשה" ForeColor="Salmon"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="NEWPW1"
                        ControlToValidate="NEWPW2" Display="Dynamic" ErrorMessage="הסיסמאות החדשות שהוקשו לא זהות" ForeColor="Salmon"></asp:CompareValidator>
                </EditItemTemplate>
                <HeaderStyle Wrap="False" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        ForeColor="White" onclick="LinkButton1_Click" Text="עדכון"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" ForeColor="White" Text="ביטול"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Edit"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Fields>
    </asp:DetailsView>
    <br />
<%--    <asp:Panel ID="Panel1" runat="server" BorderColor="Blue" BorderStyle="Dotted" Height="178px"
        Width="298px">
        <strong><span style="color: #0000cc; text-decoration: underline">כללים להגדרת סיסמא
            חדשה<br />
        </span></strong>
        <ol>
            <li><span style="color: #0000cc">אורך הסיסמא לפחות 6 סימנים</span></li>
            <li><span style="color: #0000cc">בסיסמא חייבת להיות לפחות אות אחת, לפחות ספרה אחת וללא
                רווחים.</span></li>
            <li><span style="color: #0000cc">דוגמאות לסיסמאות חוקיות: יובל3512yoel, 4533, קק54קק</span></li>
            <li><span style="color: #0000cc">דוגמאות לסיסמאות לא חוקיות: אר26 (קצר מידי), אפריםהגדול
                (אין ספרות),45139077 (אין אותיות), גמ ל129 (יש רווחים)</span></li>
        </ol>
    </asp:Panel>
--%>    <br />
    <asp:Label ID="Label2" runat="server" ForeColor="#9900CC" Text="הערה: לאחר שינוי הסיסמא תנותק אוטומטית מהמערכת כדי שהשינויים יכנסו לתוקף."
        Width="488px"></asp:Label><br />
    <br />
    <asp:Label ID="Label1" runat="server" ForeColor="Blue" Style="left: 100px; top: 100px"
        Text=" אם שכחת את הסיסמא הישנה, אנא פנה למנהל המערכת." Width="344px"></asp:Label>
    <br />
    <br />
    <br />
</asp:Content>

