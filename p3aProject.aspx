<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p3aProject.aspx.vb" Inherits="p3a_Project" title="מעקב אחזקה - הוספת פרויקט חדש" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
    <tr>
        <td style="width: 533px">
            <asp:Label ID="LBLHDR" runat="server" ForeColor="Blue" Text="הוספת פרויקט חדש" 
                Font-Bold="True" Font-Size="Medium"></asp:Label>
        </td>
        <td style="width: 533px">
            <asp:LinkButton ID="LNKBBACK" runat="server" CausesValidation="False" 
                Visible="False">חזרה</asp:LinkButton>
        </td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td style="width: 533px"> 
            <asp:HiddenField ID="HDNPID" runat="server" />
            <asp:SqlDataSource ID="DSprojHeaders" runat="server" 
                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                DeleteCommand="DELETE FROM [p3t_ProjectsHeaders] WHERE [ProjID] = @ProjID" 
                InsertCommand="INSERT INTO [p3t_ProjectsHeaders] ([ProjName], [ProjAddress], [FrameID], [Projdate], [StatusID]) VALUES (@ProjName, @ProjAddress, @FrameID, @Projdate, @StatusID)" 
                SelectCommand="SELECT p3t_ProjectsHeaders.ProjID, p3t_ProjectsHeaders.ProjName, p3t_ProjectsHeaders.ProjAddress, p3t_ProjectsHeaders.FrameID, p3t_ProjectsHeaders.Projdate, p3t_ProjectsHeaders.StatusID, p3t_StatusTable.StatusName, FrameList.FrameName FROM p3t_ProjectsHeaders LEFT OUTER JOIN p3t_StatusTable ON p3t_ProjectsHeaders.StatusID = p3t_StatusTable.StatusID LEFT OUTER JOIN FrameList ON p3t_ProjectsHeaders.FrameID = FrameList.FrameID WHERE (p3t_ProjectsHeaders.ProjID = @ProjID)" 
                
                
                UpdateCommand="UPDATE [p3t_ProjectsHeaders] SET [ProjName] = @ProjName, [ProjAddress] = @ProjAddress, [FrameID] = @FrameID, [Projdate] = @Projdate, [StatusID] = @StatusID WHERE [ProjID] = @ProjID">
                <SelectParameters>
                    <asp:SessionParameter Name="ProjID" SessionField="ProjID" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="ProjID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProjName" Type="String" />
                    <asp:Parameter Name="ProjAddress" Type="String" />
                    <asp:Parameter Name="FrameID" Type="Int32" />
                    <asp:Parameter Name="Projdate" Type="DateTime" />
                    <asp:Parameter Name="StatusID" Type="Int32" />
                    <asp:Parameter Name="ProjID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="ProjName" Type="String" />
                    <asp:Parameter Name="ProjAddress" Type="String" />
                    <asp:Parameter Name="FrameID" Type="Int32" />
                    <asp:Parameter Name="Projdate" Type="DateTime" />
                    <asp:Parameter Name="StatusID" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:DetailsView ID="DVAddproj" runat="server" AutoGenerateRows="False" 
                DataKeyNames="ProjID" DataSourceID="DSprojHeaders" DefaultMode="Insert" 
                Height="50px" Width="269px" HeaderText="הוספת פרויקט">
                <Fields>
                    <asp:TemplateField HeaderText="שם" SortExpression="ProjName">
                        <EditItemTemplate>
                            <asp:TextBox ID="TBPNameEdit" runat="server" Text='<%# Bind("ProjName") %>' 
                                ValidationGroup="UPD"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="TBPNameEdit" Display="Dynamic" 
                                ErrorMessage="חובה להזין שם" ValidationGroup="UPD"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TBPNameINS" runat="server" Text='<%# Bind("ProjName") %>' 
                                ValidationGroup="HDR"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="TBPNameINS" Display="Dynamic" 
                                ErrorMessage="חובה להזין שם" ValidationGroup="HDR"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLProjName" runat="server" Text='<%# Bind("ProjName") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="200px" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="כתובת" SortExpression="ProjAddress">
                        <EditItemTemplate>
                            <asp:TextBox ID="TBAddressEdit" runat="server" 
                                Text='<%# Bind("ProjAddress") %>' ValidationGroup="UPD"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="TBAddressEdit" Display="Dynamic" 
                                ErrorMessage="חובה להזין כתובת" ValidationGroup="UPD"></asp:RequiredFieldValidator>
                       </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TBAddressInsert" runat="server" 
                                Text='<%# Bind("ProjAddress") %>' ValidationGroup="HDR"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="TBAddressInsert" Display="Dynamic" 
                                ErrorMessage="חובה להזין כתובת" ValidationGroup="HDR"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("ProjAddress") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="200px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameID">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="DSFrames" 
                                DataTextField="FrameName" DataValueField="FrameID" 
                                SelectedValue='<%# Bind("FrameID") %>' ValidationGroup="UPD">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DSFrames" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]">
                            </asp:SqlDataSource>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DDLFrames" runat="server" DataSourceID="DSFrames" 
                                DataTextField="FrameName" DataValueField="FrameID" 
                                SelectedValue='<%# Bind("FrameID") %>' AppendDataBoundItems="True">
                                <asp:ListItem Value="">&lt;בחר מסגרת&gt;</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DSFrames" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]">
                            </asp:SqlDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ת התחלה" SortExpression="Projdate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TBSDateEdit" runat="server" 
                                Text='<%# Bind("Projdate", "{0:d}") %>' ValidationGroup="UPD"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="TBSDateEdit" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך" ValidationGroup="UPD"></asp:RequiredFieldValidator>
                             <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                ControlToValidate="TBSDateEdit" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך חוקי" MaximumValue="1/1/2020" 
                                MinimumValue="1/1/2006" Type="Date" ValidationGroup="UPD"></asp:RangeValidator>
                       </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TBSDateInsert" runat="server" 
                               Text='<%# Bind("Projdate") %>' ValidationGroup="HDR"></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                ControlToValidate="TBSDateInsert" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך חוקי" MaximumValue="1/1/2020" 
                                MinimumValue="1/1/2006" Type="Date" ValidationGroup="HDR"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="TBSDateInsert" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך" ValidationGroup="HDR"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Projdate", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סטטוס" SortExpression="StatusID">
                        <EditItemTemplate>
                            <asp:SqlDataSource ID="DSStatus" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                SelectCommand="SELECT [StatusName], [StatusID] FROM [p3t_StatusTable]">
                            </asp:SqlDataSource>
                            <asp:DropDownList ID="DDLStatusE" runat="server" DataSourceID="DSStatus" 
                                DataTextField="StatusName" DataValueField="StatusID" 
                                SelectedValue='<%# Bind("StatusID") %>' ValidationGroup="UPD">
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="DDLStatus" runat="server" DataSourceID="DSStatus" 
                                DataTextField="StatusName" DataValueField="StatusID" 
                                SelectedValue='<%# Bind("StatusID") %>' ValidationGroup="HDR">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DSStatus" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                SelectCommand="SELECT [StatusName], [StatusID] FROM [p3t_StatusTable]">
                            </asp:SqlDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("StatusName") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="עדכון" ForeColor="White" 
                                onclick="LinkButton1_Click3" ValidationGroup="UPD"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="ביטול" ForeColor="White" 
                                onclick="LinkButton2_Click1" ValidationGroup="UPD"></asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                CommandName="Insert" Text="הוספה" ForeColor="White" ValidationGroup="HDR"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="ביטול" ForeColor="White"></asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                CommandName="Edit" onprerender="LNKB_PreRender" Text="עריכה" 
                                onclick="LinkButton1_Click2"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
            </asp:DetailsView>
        </td>
        <td style="width: 533px">
            <asp:LinkButton ID="LNKBNEWFB" runat="server" 
                CausesValidation="False" Visible="false"
                                CommandName="New" Text="משוב חדש" Width="100px" ></asp:LinkButton>
 
        </td>
        <td>                     &nbsp;</td>
    </tr>
    <tr>
        <td valign="top" style="height: 233px; width: 533px" colspan="2">
            <asp:Label ID="LBLSTAGE" runat="server" Font-Bold="True" Font-Size="Small" 
                ForeColor="#0033CC" Text="שלבים"></asp:Label>
            <asp:GridView ID="GVRows" runat="server" AllowSorting="True" 
                AutoGenerateColumns="False" DataKeyNames="RowID" DataSourceID="DSRows" 
                CellPadding="4">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="עדכון"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                CommandName="Cancel" onclick="LinkButton2_Click" Text="ביטול"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LNKBEdit" runat="server" CausesValidation="False" 
                                CommandName="Edit" onclick="LinkButton1_Click1" Text="עריכה" 
                                onprerender="LNKB_PreRender"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LNKBDelete" runat="server" CausesValidation="False" 
                                CommandName="Delete" Text="מחיקה" 
                                onclientclick="return confirm('האם למחוק שורה זו?');" 
                                onprerender="LNKB_PreRender"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LNKBUP" runat="server" onclick="LNKBUP_Click" 
                                CausesValidation="False" onprerender="LNKB_PreRender">למעלה</asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LNKBDOWN" runat="server" CausesValidation="False" 
                                onclick="LNKBDOWN_Click" onprerender="LNKB_PreRender" >למטה</asp:LinkButton>
                            <asp:HiddenField ID="HDNRID" runat="server" Value='<%# Eval("RowID") %>' />
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="מס'" SortExpression="RowOrder">
                        <EditItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("RowOrder") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLROWORD" runat="server" Text='<%# Bind("RowOrder") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="תיאור" SortExpression="ProjDesc">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ProjDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ProjDesc") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום מתוכנן" SortExpression="PlannedEndDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TBPDATE" runat="server" Height="19px" 
                                Text='<%# Bind("PlannedEndDate", "{0:d}") %>' Width="77px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                ControlToValidate="TBPDATE" Display="Dynamic" ErrorMessage="חובה להזין תאריך"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" 
                                Text='<%# Bind("PlannedEndDate", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום בפועל" SortExpression="ActualEndDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TBADate" runat="server" 
                                Text='<%# Bind("ActualEndDate", "{0:d}") %>' Width="81px"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" 
                                Text='<%# Bind("ActualEndDate", "{0:d}") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="הערות" SortExpression="Comments">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("Comments") %>' 
                                TextMode="MultiLine"></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                        </ItemTemplate>
                        <ControlStyle Width="220px" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:SqlDataSource ID="DSRows" runat="server" 
                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                DeleteCommand="p3p_DelProjRow" 
                InsertCommand="INSERT INTO [p3t_ProjRows] ([ProjID], [ProjDesc], [PlannedEndDate], [ActualEndDate], [Comments], [RowOrder]) VALUES (@ProjID, @ProjDesc, @PlannedEndDate, @ActualEndDate, @Comments, @RowOrder)" 
                SelectCommand="SELECT * FROM [p3t_ProjRows] WHERE ([ProjID] = @ProjID) ORDER BY [RowOrder]" 
                
                
                UpdateCommand="UPDATE [p3t_ProjRows] SET [ProjID] = @ProjID, [ProjDesc] = @ProjDesc, [PlannedEndDate] = @PlannedEndDate, [ActualEndDate] = @ActualEndDate, [Comments] = @Comments WHERE [RowID] = @RowID" 
                DeleteCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="HDNPID" Name="ProjID" PropertyName="Value" 
                        Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="RowID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:ControlParameter ControlID="HDNPID" Name="ProjID" Type="Int32" />
                    <asp:Parameter Name="ProjDesc" Type="String" />
                    <asp:Parameter Name="PlannedEndDate" Type="DateTime" />
                    <asp:Parameter Name="ActualEndDate" Type="DateTime" />
                    <asp:Parameter Name="Comments" Type="String" />
                    <asp:Parameter Name="RowID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="HDNPID" Name="ProjID" Type="Int32" />
                    <asp:Parameter Name="ProjDesc" Type="String" />
                    <asp:Parameter Name="PlannedEndDate" Type="DateTime" />
                    <asp:Parameter Name="ActualEndDate" Type="DateTime" />
                    <asp:Parameter Name="Comments" Type="String" />
                    <asp:Parameter Name="RowOrder" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Small" 
                ForeColor="#0033CC" Text="משוב"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" DataKeyNames="FBID" DataSourceID="dsfb">
                <Columns>
                    <asp:TemplateField HeaderText="נקרא" SortExpression="FBRead">
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("FBRead") %>' />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" 
                                Checked='<%# Bind("FBRead") %>' oncheckedchanged="CheckBox1_CheckedChanged" 
                                onprerender="CheckBox1_PreRender" 
                                Enabled='<%# Eval("UserID")<>Session("UserID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" 
                                CommandArgument="FBID" CommandName="Delete" 
                                Visible='<%# ((not Eval("FBRead")) And (Session("UserID")=Eval("UserID"))) %>'
                                onclientclick="return confirm('האם למחוק את המשוב?')" >מחיקה</asp:LinkButton>
                            &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" 
                                NavigateUrl='<%# "~/p3afeedback.aspx?FBID=" & Eval("FBID") & "&ProjName=" & Eval("ProjName") & "&ProjID=" & Eval("ProjID") %>' 
                                Visible='<%# ((not Eval("FBRead")) And (Session("UserID")=Eval("UserID"))) %>'>עריכה</asp:HyperLink>
                        </ItemTemplate>
                        <ItemStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:HyperLinkField DataNavigateUrlFields="FBRootID,projID,ProjName,SFeedback" 
                        DataNavigateUrlFormatString="p3afeedback.aspx?RootID={0}&amp;ProjID={1}&amp;ProjName={2}&amp;SFeedback={3}" 
                        Text="משוב">
                        <ItemStyle Wrap="False" />
                    </asp:HyperLinkField>
                    <asp:BoundField DataField="FBDate" DataFormatString="{0:d}" HeaderText="תאריך" 
                        SortExpression="FBDate" />
                    <asp:BoundField DataField="UserName" HeaderText="משתמש" ReadOnly="True" 
                        SortExpression="UserName" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" Height="22px" onclick="Button1_Click" 
                                Text="+" CausesValidation="False" />
                            <asp:HiddenField ID="HDNUserID" runat="server" Value='<%# Eval("UserID") %>' />
                            <asp:HiddenField ID="HDNFBID" runat="server" Value='<%# Eval("FBID") %>' />
                            <asp:HiddenField ID="HDNROOTID" runat="server" 
                                Value='<%# Eval("FBRootID") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="משוב" SortExpression="SFeedback">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SFeedback") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLFBS" runat="server" Text='<%# Eval("SFeedback") %>' 
                                Width="350px" Font-Bold="True" Font-Underline="True" ></asp:Label>
                            <asp:Label ID="LBLFBT" runat="server" Text='<%# Bind("Feedback") %>' 
                                Visible="False" Width="350px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="dsfb" runat="server" 
                ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                DeleteCommand="DELETE FROM [p3t_FeedBack] WHERE [FBID] = @FBID" 
                InsertCommand="INSERT INTO [p3t_FeedBack] ([ProjID], [UserID], [FBType], [FBPID], [FBRootID], [FBDate], [SFeedback], [Feedback]) VALUES (@ProjID, @UserID, @FBType, @FBPID, @FBRootID, @FBDate, @SFeedback, @Feedback)" 
                SelectCommand="SELECT p3t_FeedBack.FBID, p3t_FeedBack.ProjID, p3t_FeedBack.UserID, p3t_FeedBack.FBRead, p3t_FeedBack.FBPID, p3t_FeedBack.FBRootID, p3t_FeedBack.FBDate, CASE p3t_FeedBack.FBID WHEN p3t_FeedBack.FBRootID THEN SFeedback ELSE '===&gt;' + isnull(SFeedBack,'') END AS SFeedback, p3t_FeedBack.Feedback, p0t_Ntb.UserName, p3t_ProjectsHeaders.ProjName FROM p3t_FeedBack LEFT OUTER JOIN p3t_ProjectsHeaders ON p3t_FeedBack.ProjID = p3t_ProjectsHeaders.ProjID LEFT OUTER JOIN p0t_Ntb ON p3t_FeedBack.UserID = p0t_Ntb.UserID WHERE (p3t_FeedBack.ProjID = @ProjID) ORDER BY p3t_FeedBack.FBRootID, p3t_FeedBack.FBID" 
                
                
                
                UpdateCommand="UPDATE [p3t_FeedBack] SET [ProjID] = @ProjID, [UserID] = @UserID, [FBType] = @FBType, [FBPID] = @FBPID, [FBRootID] = @FBRootID, [FBDate] = @FBDate, [SFeedback] = @SFeedback, [Feedback] = @Feedback WHERE [FBID] = @FBID">
                <SelectParameters>
                    <asp:QueryStringParameter Name="ProjID" QueryStringField="ProjID" 
                        Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="FBID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ProjID" Type="Int32" />
                    <asp:Parameter Name="UserID" Type="Int32" />
                    <asp:Parameter Name="FBType" Type="Int32" />
                    <asp:Parameter Name="FBPID" Type="Int32" />
                    <asp:Parameter Name="FBRootID" Type="Int32" />
                    <asp:Parameter Name="FBDate" Type="DateTime" />
                    <asp:Parameter Name="SFeedback" Type="String" />
                    <asp:Parameter Name="Feedback" Type="String" />
                    <asp:Parameter Name="FBID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="ProjID" Type="Int32" />
                    <asp:Parameter Name="UserID" Type="Int32" />
                    <asp:Parameter Name="FBType" Type="Int32" />
                    <asp:Parameter Name="FBPID" Type="Int32" />
                    <asp:Parameter Name="FBRootID" Type="Int32" />
                    <asp:Parameter Name="FBDate" Type="DateTime" />
                    <asp:Parameter Name="SFeedback" Type="String" />
                    <asp:Parameter Name="Feedback" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
        </td>
        <td valign="top" style="height: 233px">
            <asp:DetailsView ID="DVNewRow" runat="server" AutoGenerateRows="False" 
                DataKeyNames="RowID" DataSourceID="DSRows" DefaultMode="Insert" Height="50px" 
                Width="125px" HeaderText="הוספת שלב (שורה)">
                <Fields>
                    <asp:TemplateField HeaderText="מס'" SortExpression="RowOrder">
                        <EditItemTemplate>
                            <asp:Label ID="LBLORDE" runat="server" Text="Label"></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:Label ID="LBLROW" runat="server" onprerender="LBLROWORD_PreRender" 
                                Text='<%# Bind("RowOrder") %>'></asp:Label>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLROWORD" runat="server" onprerender="LBLROWORD_PreRender" 
                                Text='<%# Bind("RowOrder") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="תיאור" SortExpression="ProjDesc">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ProjDesc") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TBDESC" runat="server" Text='<%# Bind("ProjDesc") %>' 
                                Width="230px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="TBDESC" Display="Dynamic" ErrorMessage="חובה להזין תיאור"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("ProjDesc") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום מתוכנן" 
                        SortExpression="PlannedEndDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("PlannedEndDate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="DBPDate" runat="server" Text='<%# Bind("PlannedEndDate") %>'></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator2" runat="server" 
                                ControlToValidate="DBPDate" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך חוקי" MaximumValue="1/1/2020" 
                                MinimumValue="1/1/2007" Type="Date"></asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ControlToValidate="DBPDate" Display="Dynamic" ErrorMessage="חובה להזין תאריך"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("PlannedEndDate") %>'></asp:Label>
                        </ItemTemplate>
                        <HeaderStyle Wrap="False" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סיום בפועל" SortExpression="ActualEndDate">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("ActualEndDate") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TBADate" runat="server" Text='<%# Bind("ActualEndDate") %>'></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator3" runat="server" 
                                ControlToValidate="TBADate" Display="Dynamic" 
                                ErrorMessage="חובה להזין תאריך חוקי" MaximumValue="1/1/2020" 
                                MinimumValue="1/1/2007" Type="Date"></asp:RangeValidator>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("ActualEndDate") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="הערות" SortExpression="Comments">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Comments") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("Comments") %>' 
                                TextMode="MultiLine" Width="230px"></asp:TextBox>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField CancelText="ביטול" InsertText="הוספה" 
                        ShowInsertButton="True" />
                </Fields>
            </asp:DetailsView>
            <br />
        </td>
    </tr>
    <tr>
        <td valign="top" style="width: 533px" colspan="2">
            <br />
        </td>
        <td valign="top">
            &nbsp;</td>
    </tr>
</table>
</asp:Content>

