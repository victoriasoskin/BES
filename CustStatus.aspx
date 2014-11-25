<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustStatus.aspx.vb" Inherits="CustStatus" title="בית אקשטיין - סטטוס לקוח" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	&nbsp;<asp:Label ID="Label27" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="פרטי הלקוח" Width="136px"></asp:Label><asp:FormView ID="FormView1" runat="server" BorderWidth="1px" DataKeyNames="RowID"
        DataSourceID="DSCutomers" Font-Size="Small">
        <ItemTemplate>
            <table>
                <tr> 
                    <td bgcolor="#37a5ff" colspan="4" style="text-align: center; height: 20px;">
                        <span style="font-size: 12pt">פרטי הלקוח</span> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    </td>
                    <td bgcolor="#37a5ff" colspan="2" style="text-align: center; height: 20px;">
                        <span style="font-size: 12pt">פרטי האפוטרופוס</span></td>
                    <td bgcolor="#37a5ff" colspan="4" style="text-align: center; height: 20px;">
                        <span style="font-size: 12pt">פרטי המשפחה</span></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff">
                        <asp:Label ID="Label3" runat="server" Text="ת.ז. / דרכון" Width="68px"></asp:Label></td>
                    <td style="width: 203px">
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("CustomerID") %>' Width="158px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 165px">
                        טלפון</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label20" runat="server" Text='<%# Eval("CustomerPhone") %>' Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" colspan="2">
                        &nbsp;</td>
                    <td bgcolor="#37a5ff" colspan="2">
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px; ">
                        שם משפחה</td>
                    <td style="width: 203px; ">
                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("CustLastName") %>' Width="158px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 165px">
                        טלפון סלולרי</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label21" runat="server" Text='<%# Eval("CustomerCell1") %>' Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 112px; ">
                        שם</td>
                    <td style="width: 39px; ">
                        <asp:Label ID="Label24" runat="server" Text='<%# Eval("CustApotroposName") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px; ">
                        שם</td>
                    <td style="">
                        <asp:Label ID="Label35" runat="server" Text='<%# Eval("CustFamilyName") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px">
                        שם פרטי</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("CustFirstName") %>' Width="158px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 165px">
                        טלפון סלולרי</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label22" runat="server" Text='<%# Eval("CustomerCell2") %>' Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 112px">
                        סוג</td>
                    <td style="width: 39px">
                        <asp:Label ID="Label25" runat="server" Text='<%# Eval("CustApotroposTypeName") %>'
                            Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px">
                        <asp:Label ID="Label4" runat="server" Width="70px"></asp:Label></td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px">
                        תאריך לידה</td>
                    <td style="width: 203px">
                        <table>
                            <tr>
                                <td colspan="1" style="">
                                    <asp:Label ID="Label10" runat="server" Text='<%# Eval("CustBirthDate", "{0:dd/MM/yy}") %>'
                                        Width="100px"></asp:Label></td>
                                <td style="">
                                    <asp:Label ID="Label11" runat="server" Text='<%# Eval("Gender") %>' Width="19px"></asp:Label></td>
                            </tr>
                        </table>
                    </td>
                    <td bgcolor="#37a5ff" style="width: 165px">
                        דוא"ל</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label23" runat="server" Text='<%# Eval("CustomerEmail") %>' Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" rowspan="2" style="width: 112px">
                        כתובת</td>
                    <td style="width: 213px">
                        <asp:Label ID="Label26" runat="server" Text='<%# Eval("CustApotroposAddress1") %>'
                            Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" rowspan="2" style="width: 213px">
                        כתובת</td>
                    <td style="width: 213px">
                        <asp:Label ID="Label37" runat="server" Text='<%# Eval("CustFamilyAddress1") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#0099cc" bordercolordark="#000099" style="border-right: gray thin dotted;
                        border-top: gray thin dotted; width: 113px">
                        <strong>גורם מפנה</strong></td>
                    <td bordercolordark="#000099" style="border-top: gray thin dotted; border-left: gray thin dotted;
                        width: 203px">
                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("CustOriginOfficeTypeName") %>'
                            Width="158px"></asp:Label></td>
                    <td style="width: 165px">
                        <asp:Label ID="Label36" runat="server" Width="70px"></asp:Label></td>
                    <td style="width: 39px">
                        </td>
                    <td style="width: 213px">
                        <asp:Label ID="Label38" runat="server" Text='<%# Eval("CustFamilyAddress2") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#0099cc" bordercolordark="#000099" rowspan="1" style="border-right: gray thin dotted;
                        width: 113px; ">
                        עיר</td>
                    <td bordercolordark="#000099" style="border-left: gray thin dotted; width: 203px;
                        ">
                        <asp:Label ID="Label13" runat="server" Text='<%# Eval("CustOriginOfficeCity") %>'
                            Width="158px"></asp:Label></td>
                    <td style="width: 165px; ">
                    </td>
                    <td style="width: 112px">
                    </td>
                    <td bgcolor="#37a5ff" style="width: 112px; ">
                        עיר</td>
                    <td style="width: 39px; ">
                        <asp:Label ID="Label28" runat="server" Text='<%# Eval("CustApotroposCity") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px; ">
                        עיר</td>
                    <td style="width: 213px; ">
                        <asp:Label ID="Label39" runat="server" Text='<%# Eval("CustFamilyCity") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#0099cc" bordercolordark="#000099" rowspan="1" style="border-right: gray thin dotted;
                        width: 113px; border-bottom: gray thin dotted; ">
                        שם הסניף</td>
                    <td bordercolordark="#000099" style="border-left: gray thin dotted; width: 203px;
                        border-bottom: gray thin dotted; ">
                        <asp:Label ID="Label14" runat="server" Text='<%# Eval("CustOriginOfficeName") %>'
                            Width="158px"></asp:Label></td>
                    <td style="width: 165px; ">
                    </td>
                    <td style="width: 112px; ">
                    </td>
                    <td bgcolor="#37a5ff" style="width: 112px; ">
                        מיקוד</td>
                    <td style="width: 39px; ">
                        <asp:Label ID="Label29" runat="server" Text='<%# Eval("CustApotroposZipcode") %>'
                            Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px; ">
                        מיקוד</td>
                    <td style="width: 213px; ">
                        <asp:Label ID="Label40" runat="server" Text='<%# Eval("CustFamilyZioCode") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" rowspan="1" style="">
                        מבטח רפואי</td>
                    <td style="width: 203px; ">
                        <asp:Label ID="Label15" runat="server" Text='<%# Eval("CustMedCareName") %>' Width="158px"></asp:Label></td>
                    <td style="width: 165px; ">
                    </td>
                    <td style="width: 112px">
                    </td>
                    <td bgcolor="#37a5ff" style="width: 112px; ">
                        טלפון</td>
                    <td style="width: 39px; ">
                        <asp:Label ID="Label30" runat="server" Text='<%# Eval("CustApotroposPhone") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px; ">
                        טלפון</td>
                    <td style="width: 213px; ">
                        <asp:Label ID="Label41" runat="server" Text='<%# Eval("CustFamilyphone") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" rowspan="2" style="width: 113px">
                        כתובת</td>
                    <td style="WIDTH: 203px">
                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("CustomerAddress1") %>' Width="158px"></asp:Label></td>
                    <td style="width: 165px; ">
                    </td>
                    <td style="width: 112px">
                    </td>
                    <td bgcolor="#37a5ff" style="width: 112px; ">
                        פקס</td>
                    <td style="width: 39px; ">
                        <asp:Label ID="Label31" runat="server" Text='<%# Eval("CustApotroposFax") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px; ">
                        פקס</td>
                    <td style="width: 213px; ">
                        <asp:Label ID="Label42" runat="server" Text='<%# Eval("CustFamilyFax") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 203px">
                        <asp:Label ID="Label17" runat="server" Text='<%# Eval("CustomerAddress2") %>' Width="158px"></asp:Label></td>
                    <td style="width: 165px">
                    </td>
                    <td style="width: 112px">
                    </td>
                    <td bgcolor="#37a5ff" style="width: 112px">
                        טלפון סלולרי</td>
                    <td style="width: 39px">
                        <asp:Label ID="Label32" runat="server" Text='<%# Eval("CustApotroposCell1") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff">
                        טלפון סלולרי</td>
                    <td>
                        <asp:Label ID="Label43" runat="server" Text='<%# Eval("CustFamilyCell1") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px">
                        עיר</td>
                    <td style="WIDTH: 203px">
                        <asp:Label ID="Label18" runat="server" Text='<%# Eval("CustomerCity") %>' Width="158px"></asp:Label></td>
                    <td style="width: 112px; border-top-style: ridge; border-right-style: ridge">
                        עדכון אחרון</td>
                    <td style="width: 112px; border-top-style: ridge; border-left-style: ridge">
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("UpdateDate", "{0:dd/MM/yy}") %>'
                            Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 112px">
                        טלפון סלולרי</td>
                    <td style="width: 39px">
                        <asp:Label ID="Label33" runat="server" Text='<%# Eval("CustApotroposCell2") %>' Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px">
                        טלפון סלולרי</td>
                    <td style="width: 213px">
                        <asp:Label ID="Label44" runat="server" Text='<%# Eval("CustFamilyCell2") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px">
                        מיקוד</td>
                    <td style="width: 203px">
                        <asp:Label ID="Label19" runat="server" Text='<%# Eval("CustomerZipCode") %>' Width="158px"></asp:Label></td>
                    <td style="border-right-style: ridge; border-bottom-style: ridge">
                        על ידי</td>
                    <td style="border-left-style: ridge; border-bottom-style: ridge">
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("UserName") %>' Width="100px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 112px">
                        <asp:Label ID="Label2" runat="server" Text='דוא"ל' Width="70px"></asp:Label></td>
                    <td style="width: 39px">
                        &nbsp;<asp:Label ID="Label34" runat="server" Text='<%# Eval("CustApotroposEmail") %>'
                            Width="120px"></asp:Label></td>
                    <td bgcolor="#37a5ff" style="width: 213px">
                        דוא"ל</td>
                    <td style="width: 213px">
                        <asp:Label ID="Label45" runat="server" Text='<%# Eval("CustFamilyEmail") %>' Width="120px"></asp:Label></td>
                </tr>
                <tr>
                    <td bgcolor="#37a5ff" style="width: 113px">
                        הערות / מידע נוסף</td>
                    <td colspan="7">
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustAddInfo") %>' TextMode="MultiLine"
                            ToolTip='<%# Eval("CustAddInfo") %>' Width="743px"></asp:TextBox></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    <hr width="1000" />
    <asp:Label ID="Label46" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="פעולות בתוקף" Width="136px"></asp:Label><asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustEventID" DataSourceID="DSActiveStatus"
        Font-Size="Small" ForeColor="#333333" PageSize="8" EnableViewState="False">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="custeventtypename" HeaderText="סוג" SortExpression="CustEventTypeName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="החל מתאריך"
                HtmlEncode="False" SortExpression="custEventDate" />
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="תיאור" SortExpression="CustEventComment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="LBComment" runat="server" Text='<%# Truncfield("CustEventComment",25) %>'
                        ToolTip='<%# Eval("CustEventComment") & "" %>' Width="160px"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת רישום"
                HtmlEncode="False" SortExpression="CustEventRegDate" />
            <asp:BoundField DataField="CReporterUserName" HeaderText="על ידי" SortExpression="CReporterUserName">
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <hr width="1000" />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="ControlText"
        Text="יומן פעולות לקוח" Width="136px"></asp:Label><br />
    <asp:GridView ID="GVList" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustEventID" DataSourceID="DSEvents"
        Font-Size="Small" ForeColor="#333333" PageSize="8" EnableViewState="False">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:BoundField DataField="CustEventID" HeaderText="מס'" InsertVisible="False" ReadOnly="True"
                SortExpression="CustEventID" />
            <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת פעולה"
                HtmlEncode="False" SortExpression="custEventDate" />
                
                       <asp:TemplateField HeaderText="סוג פעולה">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" 
                                    NavigateUrl='<%# Eval("CustEventUrl") %>' 
                                    Text='<%# Eval("CustEventTypeName") %>'></asp:HyperLink>
                            </ItemTemplate>
                            </asp:TemplateField>
            
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CFrameManager" HeaderText="מנהל" SortExpression="CFrameManager" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="תיאור" SortExpression="CustEventComment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="LBComment" runat="server" Text='<%# Truncfield("CustEventComment",25) %>'
                        ToolTip='<%# Eval("CustEventComment") & "" %>' Width="160px"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField HeaderText="קישור" />
            <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת רישום"
                HtmlEncode="False" SortExpression="CustEventRegDate" />
            <asp:BoundField DataField="CReporterUserName" HeaderText="על ידי" SortExpression="CReporterUserName">
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
    <asp:SqlDataSource ID="DSEvents" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" SelectCommand="SELECT CustEventID, CustomerID, CustFirstName + ' ' + CustLastName AS name, CustEventTypeName, CustEventRegDate, CustEventDate, CustEventComment, FrameName, CframeManager, CReporterUserName, CustEventGroupName, CustFrameID,CustEventURL FROM vCustEventList WHERE (CustomerRowID = isnull(@RowID,CustomerRowID) AND CustomerID=isnull(@CustomerID,CustomerID)) ORDER BY CustEventDate DESC" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="RowID" QueryStringField="RowID" />
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCutomers" runat="server" CancelSelectOnNullParameter="False"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" DeleteCommand="DELETE FROM [CustomerList] WHERE [RowID] = @RowID"
        InsertCommand="INSERT INTO [CustomerList] ([CustomerID], [CustFirstName], [CustLastName], [CustBirthDate], [CustOriginOfficeID], [CustApotropos1ID], [CustApotroposID2], [CustGender]) VALUES (@CustomerID, @CustFirstName, @CustLastName, @CustBirthDate, @CustOriginOfficeID, @CustApotropos1ID, @CustApotroposID2, @CustGender)"
        SelectCommand="SELECT CustomerID, CustFirstName, CustLastName, CustBirthDate, CustOriginOfficeTypeName, FrameName, CustGender, CustEventDate, CustFrameID, CustEventTypeName, RowID, CustOriginOfficeTypeID, CustOriginOfficeCity, UpdateDate, UserName, UserID, CustApotroposName, CustOriginOfficeName, CustMedCareID, CustomerAddress1, CustomerAddress2, CustomerCity, CustomerZipCode, CustomerPhone, CustomerFax, CustomerCell1, CustomerCell2, CustomerEmail, CustApotroposTypeID, CustApotroposAddress1, CustApotroposAddress2, CustApotroposCity, CustApotroposZipcode, CustApotroposPhone, CustApotroposCell1, CustApotroposFax, CustApotroposCell2, CustApotroposEmail, CustFamilyName, CustFamilyAddress1, CustFamilyAddress2, CustFamilyCity, CustFamilyZioCode, CustFamilyphone, CustFamilyFax, CustFamilyCell1, CustFamilyCell2, CustFamilyEmail, ServiceName, UserFrameID, CustServiceID, PUserID, CustEventGroupOrder, CustMedCareName, Gender, CustApotroposTypeName,CustAddInfo FROM vCustomerList WHERE ((RowID = isnull(@RowID,RowID)) And (CustomerID=isnull(@CID,CustomerID)) And (PUserID=@UserID))"
        UpdateCommand="UPDATE CustomerList SET CustomerID = @CustomerID, CustFirstName = @CustFirstName, CustLastName = @CustLastName, CustBirthDate = @CustBirthDate, CustGender = @CustGender, CustMedCareID = @CustMedCareID, CustApotroposName = @CustApotroposname, CustApotroposAddress1 = @CustApotroposAddress1, CustApotroposAddress2 = @CustApotroposAddress2, CustApotroposPhone = @CustApotroposPhone, CustApotroposFax = @CustApotroposFax, CustomerAddress1 = @CustomerAddress1, CustomerAddress2 = @CustomerAddress2, CustomerCity = @CustomerCity, CustomerZipCode = @CustomerZipCode, CustomerPhone = @CustomerPhone, CustApotroposCity = @CustApotroposCity, CustApotroposZipcode = @CustApotroposZipCode, CustOriginOfficeTypeID = @CustOriginOfficeTypeID, CustOriginOfficeCity = @CustOriginOfficeCity, CustOriginOfficeName = @CustOriginOfficeName, CustomerFax = @CustomerFax, CustomerCell1 = @CustomerCell1, CustomerCell2 = @CustomerCell2, CustomerEmail = @CustomerEmail, CustApotroposCell1 = @CustApotroposCell1, CustApotroposCell2 = @CustApotroposCell1, CustApotroposEmail = @CustApotroposEmail, CustFamilyName = @CustFamilyName, CustFamilyAddress1 = @CustFamilyAddress1, CustFamilyAddress2 = @CustFamilyAddress2, CustFamilyZioCode = @CustFamilyZioCode, CustFamilyCity = @CustFamilyCity, CustFamilyphone = @CustFamilyphone, CustFamilyFax = @CustFamilyFax, CustFamilyCell1 = @CustFamilyCell1, CustFamilyCell2 = @CustFamilyCell2, CustFamilyEmail = @CustFamilyEmail, UpdateDate = GETDATE(), UserID = @UserID WHERE (RowID = isnull(@RowID,RowID) And CustomerID=(@CID,CustomerID))">
        <DeleteParameters>
            <asp:Parameter Name="RowID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustGender" Type="Int32" />
            <asp:Parameter Name="CustMedCareID" />
            <asp:Parameter Name="CustApotroposname" Type="String" />
            <asp:Parameter Name="CustApotroposAddress1" Type="String" />
            <asp:Parameter Name="CustApotroposAddress2" Type="String" />
            <asp:Parameter Name="CustApotroposPhone" Type="String" />
            <asp:Parameter Name="CustApotroposFax" Type="String" />
            <asp:Parameter Name="CustomerAddress1" />
            <asp:Parameter Name="CustomerAddress2" />
            <asp:Parameter Name="CustomerCity" />
            <asp:Parameter Name="CustomerZipCode" />
            <asp:Parameter Name="CustomerPhone" />
            <asp:Parameter Name="CustApotroposCity" />
            <asp:Parameter Name="CustApotroposZipCode" />
            <asp:Parameter Name="CustOriginOfficeTypeID" />
            <asp:Parameter Name="CustOriginOfficeCity" />
            <asp:Parameter Name="CustOriginOfficeName" />
            <asp:Parameter Name="CustomerFax" />
            <asp:Parameter Name="CustomerCell1" />
            <asp:Parameter Name="CustomerCell2" />
            <asp:Parameter Name="CustomerEmail" />
            <asp:Parameter Name="CustApotroposCell1" />
            <asp:Parameter Name="CustApotroposEmail" />
            <asp:Parameter Name="CustFamilyName" />
            <asp:Parameter Name="CustFamilyAddress1" />
            <asp:Parameter Name="CustFamilyAddress2" />
            <asp:Parameter Name="CustFamilyZioCode" />
            <asp:Parameter Name="CustFamilyCity" />
            <asp:Parameter Name="CustFamilyphone" />
            <asp:Parameter Name="CustFamilyFax" />
            <asp:Parameter Name="CustFamilyCell1" />
            <asp:Parameter Name="CustFamilyCell2" />
            <asp:Parameter Name="CustFamilyEmail" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:Parameter Name="RowID" />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="RowID" QueryStringField="RowID" />
            <asp:QueryStringParameter Name="CID" QueryStringField="CID" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" />
            <asp:Parameter Name="CustFirstName" />
            <asp:Parameter Name="CustLastName" />
            <asp:Parameter Name="CustBirthDate" />
            <asp:Parameter Name="CustOriginOfficeID" />
            <asp:Parameter Name="CustApotropos1ID" />
            <asp:Parameter Name="CustApotroposID2" />
            <asp:Parameter Name="CustGender" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSActiveStatus" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" CancelSelectOnNullParameter="false"
        SelectCommand="SELECT CustEventID, CustomerID, CustFirstName, CustLastName, CustEventTypeName, CustEventRegDate, CustEventDate, CustEventComment, FrameName, CframeManager, CustFrameID, ServiceID, CustEventTypeID, CustEventGroupID, CustEventGroupName, CustomerName, CustEventDays, CustomerRowID, CReporterUserName, CustFinalDate FROM dbo.vCustActiveStatus WHERE (CustomerRowID = isnull(@CustomerRowID,CustomerRowID)) And (CustomerID=isnull(@CustomerID,CustomerID))">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerRowID" QueryStringField="RowID" Type="Int32" />
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
