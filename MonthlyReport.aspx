<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="MonthlyReport.aspx.vb" Inherits="MonthlyReport" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Font-Size="Large" ForeColor="Blue" Text="דוח חודשי למסגרת"></asp:Label><br />
    <asp:Wizard ID="Wizard1" runat="server" CancelButtonText="ביטול" FinishCompleteButtonText="סיום"
        FinishPreviousButtonText="הקודם" StartNextButtonText="הבא" StepNextButtonText="הבא"
        StepPreviousButtonText="הקודם" Width="100%" ActiveStepIndex="0" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderWidth="1px" Font-Bold="True" Font-Names="Verdana" Font-Size="10pt" ForeColor="#CC0033" FinishDestinationPageUrl="~/Default.aspx">
        <WizardSteps>
            <asp:WizardStep runat="server" StepType="Start" Title="פתיחה">
                <span style="font-size: 10pt; color: #0000cc">
                    <asp:Label ID="Label3" runat="server" BackColor="#C0C0FF" Font-Bold="True" Font-Size="14pt"
                        Font-Underline="True" Text="פתיחה"></asp:Label>
                    &nbsp;&nbsp;&nbsp;<br />
                    </span>&nbsp;&nbsp;<table>
                    <tr>
                        <td style="width: 170px" valign="middle">
                <asp:Label ID="Label10" runat="server" Text="שם מסגרת" Width="71px"></asp:Label>
                            &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;
                            <asp:DropDownList ID="DropDownListFrames" runat="server" DataSourceID="AccessDataSourceFrames"
                                DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="True" AutoPostBack="True">
                                <asp:ListItem Value="0">(בחר מסגרת)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="width: 100px">
                        </td>
                    </tr> 
                        <tr>
                            <td valign="top" width="50%">
                                <span style="font-size: 11pt; color: #3300cc; text-decoration: underline">רשימת דוחות</span></td>
                            <td style="width: 100px" valign="top">
                            </td>
                        </tr>
                    <tr>
                        <td valign="top" width="50%">
                            <asp:GridView ID="GridView7" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px"
                                CellPadding="4" DataKeyNames="ReportID" DataSourceID="AccessDataSourceReports"
                                ForeColor="#333333" GridLines="None" HorizontalAlign="Left" Width="247px">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                OnClick="LinkButton1_Click" OnDataBinding="LinkButton1_DataBinding" Text="בחירה" PostBackUrl="~/MonthlyReport.aspx"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="מספר הדוח" InsertVisible="False" SortExpression="ReportID">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("ReportID") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="LabelRepNo" runat="server" Text='<%# Bind("ReportID") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ReportDate" DataFormatString="{0:dd/MM/yy}" HeaderText="תאריך הדוח"
                                        HtmlEncode="False" SortExpression="ReportDate" />
                                    <asp:TemplateField HeaderText="סגור" SortExpression="ReportClosed">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ReportClosed") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("ReportClosed") %>'
                                                Enabled="False" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                        <td style="width: 100px" valign="top">
                            <asp:DetailsView ID="DetailsView4" runat="server" AutoGenerateRows="False" BorderColor="Blue"
                                BorderStyle="Solid" BorderWidth="2px" CellPadding="4" DataKeyNames="ReportID"
                                DataSourceID="AccessDataSourceReports" DefaultMode="Insert" ForeColor="#333333"
                                GridLines="None" HeaderText="הוספת דוח חדש" Height="86px" Width="125px">
                                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                                <AlternatingRowStyle BackColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                                <EditRowStyle BackColor="#2461BF" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <Fields>
                                    <asp:BoundField DataField="ReportID" HeaderText="מספר הדוח" InsertVisible="False"
                                        ReadOnly="True" SortExpression="ReportID" />
                                    <asp:TemplateField HeaderText="תאריך הדוח" SortExpression="ReportDate">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ReportDate") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="Black"
                                                DayNameFormat="Shortest" Font-Names="Times New Roman" Font-Size="10pt" ForeColor="Black"
                                                Height="207px" NextPrevFormat="FullMonth" SelectedDate='<%# Bind("ReportDate") %>'
                                                TitleFormat="Month" Width="195px">
                                                <SelectedDayStyle BackColor="#CC3333" ForeColor="White" />
                                                <TodayDayStyle BackColor="#CCCC99" />
                                                <SelectorStyle BackColor="#CCCCCC" Font-Bold="True" Font-Names="Verdana" Font-Size="8pt"
                                                    ForeColor="#333333" Width="1%" />
                                                <DayStyle Width="14%" />
                                                <OtherMonthDayStyle ForeColor="#999999" />
                                                <NextPrevStyle Font-Size="8pt" ForeColor="White" />
                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" ForeColor="#333333"
                                                    Height="10pt" />
                                                <TitleStyle BackColor="Black" Font-Bold="True" Font-Size="13pt" ForeColor="White"
                                                    Height="14pt" />
                                            </asp:Calendar>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ReportDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField CancelText="" InsertText="הוספה" ShowInsertButton="True" />
                                </Fields>
                            </asp:DetailsView>
                        </td>
                    </tr>
                </table>
                <br />
                &nbsp;<span style="font-size: 10pt; color: #0000ff">&nbsp;&nbsp;<br />
                </span>&nbsp;<br />
                &nbsp;&nbsp;</asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Step" Title="דוח לקוחות">
                <asp:Label ID="Label2" runat="server" BackColor="#C0C0FF" Font-Bold="True" Font-Size="14pt"
                    Font-Underline="True" ForeColor="Blue" Text="דוח לקוחות"></asp:Label>
                <table width="100%">
                    <tr>
                        <td colspan="2" style="height: 18px" valign="top">
                            &nbsp;<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                DataSourceID="AccessDataSourceReport1" ForeColor="#333333" GridLines="None" Width="100%">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:CommandField CancelText="ביטול" EditText="עריכה" ShowEditButton="True" UpdateText="עדכון" />
                                    <asp:BoundField DataField="ItemName" ReadOnly="True" SortExpression="ItemName">
                                        <ControlStyle BackColor="#8080FF" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField SortExpression="ItemValue">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemValue") %>' Width="250px"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle Width="250px" />
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("ItemValue") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                            &nbsp;</td>
                    </tr>
                </table>
                <strong><span style="color: #cc0033"></span></strong></asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Step" Title="דוח עובדים">
                &nbsp;<asp:Label ID="Label4" runat="server" BackColor="#C0C0FF" Font-Bold="True"
                    Font-Size="14pt" Font-Underline="True" ForeColor="#0000CC" Text="דוח עובדים"></asp:Label>
                <table bordercolor="blue">
                    <tr>
                        <td style="width: 100px" valign="top">
                            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                DataSourceID="AccessDataSourceReport2" ForeColor="#333333" GridLines="None" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="FrameID" HeaderText="FrameID" SortExpression="FrameID"
                                        Visible="False" />
                                    <asp:BoundField DataField="ReportDate" HeaderText="ReportDate" SortExpression="ReportDate"
                                        Visible="False" />
                                    <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" Visible="False" />
                                    <asp:BoundField DataField="ItemName" SortExpression="ItemName" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField SortExpression="ItemValue">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemValue") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemValue") %>'></asp:TextBox>
                                        </ItemTemplate>
                                        <ControlStyle Width="150px" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                            <asp:Label ID="Label8" runat="server" BackColor="#C0C0FF" Font-Bold="True" Font-Size="12pt"
                                Font-Underline="True" ForeColor="#0000CC" Text="עובדים שעזבו"></asp:Label>
                        </td>
                        <td style="width: 151px" valign="top">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px; height: 298px" valign="top">
                            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" DataSourceID="AccessDataSourceEmpl"
                                ForeColor="#333333" GridLines="None" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" ShowDeleteButton="True"
                                        ShowEditButton="True" UpdateText="עדכון" />
                                    <asp:BoundField DataField="RowID" HeaderText="RowID" InsertVisible="False" SortExpression="RowID"
                                        Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="EmpName" HeaderText="שם העובד" SortExpression="EmpName" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="EmpJob" HeaderText="תפקיד" SortExpression="EmpJob" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="EmpStartDate" DataFormatString="{0:dd/MM/yy}" HeaderText="תאריך תחילת העבודה"
                                        HtmlEncode="False" SortExpression="EmpStartDate" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="סיבת העזיבה" SortExpression="Reason">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="AccessDataSourceReasons"
                                                DataTextField="Reason" DataValueField="ReasonID">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle Wrap="False" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                            <span style="color: #cc0033">מיכל ויואב<br />
                                המסך הזה אחיד לכל המסגרות.</span> &nbsp;<br />
                            <span style="color: #cc0033">עברו למסך הבא...</span></td>
                        <td style="width: 151px; height: 298px" valign="top">
                            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4"
                                DataSourceID="AccessDataSourceEmpl" DefaultMode="Insert" ForeColor="#333333"
                                GridLines="None" HeaderText="הוספת עובד לרשימה" Height="50px" Width="125px" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                                <AlternatingRowStyle BackColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                                <EditRowStyle BackColor="#2461BF" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <Fields>
                                    <asp:BoundField DataField="RowID" HeaderText="RowID" InsertVisible="False" SortExpression="RowID"
                                        Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="EmpName" HeaderText="שם העובד" SortExpression="EmpName" />
                                    <asp:BoundField DataField="EmpJob" HeaderText="תפקיד" SortExpression="EmpJob" />
                                    <asp:BoundField DataField="EmpStartDate" HeaderText="תאריך תחילת העבודה" SortExpression="EmpStartDate" />
                                    <asp:TemplateField HeaderText="סיבת העזיבה" SortExpression="Reason">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Reason") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="AccessDataSourceReasons"
                                                DataTextField="Reason" DataValueField="ReasonID">
                                            </asp:DropDownList>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("Reason") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField CancelText="ביטול" InsertText="הוספה" ShowInsertButton="True" />
                                </Fields>
                            </asp:DetailsView>
                        </td>
                    </tr>
                </table>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="משרות פתוחות" StepType="Step">
                &nbsp;<asp:Label ID="Label5" runat="server" BackColor="#C0C0FF" Font-Size="14pt"
                    Font-Underline="True" ForeColor="Blue" Text="משרות פתוחות"></asp:Label>
                <table>
                    <tr>
                        <td style="width: 100px; height: 298px" valign="top">
                            <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="OpenJobID" DataSourceID="AccessDataSourceOpenJobs"
                                ForeColor="#333333" GridLines="None" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                                        ShowDeleteButton="True" ShowEditButton="True" UpdateText="עדכון" />
                                    <asp:BoundField DataField="OpenJobID" HeaderText="OpenJobID" InsertVisible="False"
                                        ReadOnly="True" SortExpression="OpenJobID" Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="OpenJob" HeaderText="תאור המשרה" SortExpression="OpenJob" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                        <td style="width: 100px; height: 298px" valign="top">
                            <asp:DetailsView ID="DetailsView2" runat="server" AutoGenerateRows="False" CellPadding="4"
                                DataKeyNames="OpenJobID" DataSourceID="AccessDataSourceOpenJobs" DefaultMode="Insert"
                                ForeColor="#333333" GridLines="None" HeaderText="הוספת משרה חדשה" Height="50px" Width="125px" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                                <AlternatingRowStyle BackColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                                <EditRowStyle BackColor="#2461BF" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <Fields>
                                    <asp:BoundField DataField="OpenJobID" HeaderText="OpenJobID" InsertVisible="False"
                                        ReadOnly="True" SortExpression="OpenJobID" Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="OpenJob" HeaderText="תאור המשרה" SortExpression="OpenJob" />
                                    <asp:CommandField CancelText="ביטול" InsertText="הוספה" ShowInsertButton="True" />
                                </Fields>
                            </asp:DetailsView>
                        </td>
                    </tr>
                </table>
                <span style="color: #cc0033">מיכל ויואב<br />
                    המסך הזה אחיד לכל המסגרות<br />
                    עברו למסך הבא...<br />
                </span>
            </asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Step" Title="נתוני תמיכות">
                <table>
                    <tr>
                        <td style="width: 100px; height: 420px;" valign="top">
                            &nbsp;<asp:Label ID="Label6" runat="server" BackColor="#C0C0FF" Font-Size="14pt"
                                Font-Underline="True" ForeColor="Blue" Text="נתוני תמיכות" Width="100%"></asp:Label>
                            <asp:GridView ID="GridView5" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" DataKeyNames="SupportID" DataSourceID="AccessDataSourceSupport"
                                ForeColor="#333333" GridLines="None" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" UpdateText="עדכון" />
                                    <asp:BoundField DataField="SupportID" HeaderText="SupportID" InsertVisible="False"
                                        ReadOnly="True" SortExpression="SupportID" Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="CustomerName" HeaderText="שם הדייר" SortExpression="CustomerName" >
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="isSISDone" HeaderText="האם מולא SIS החודש" SortExpression="isSISDone" />
                                    <asp:CheckBoxField DataField="isLifeQualityDonw" HeaderText="האם מולא שאלון איכות חיים"
                                        SortExpression="isLifeQualityDonw" />
                                    <asp:CheckBoxField DataField="IsSupportPlaneDone" HeaderText="האם הוכנה תוכנית תמיכות החודש?"
                                        SortExpression="IsSupportPlaneDone" />
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                        <td style="width: 100px; height: 420px;" valign="top">
                            <span style="font-size: 14pt">&nbsp;</span><br />
                            <asp:DetailsView ID="DetailsView3" runat="server" AutoGenerateRows="False" CellPadding="4"
                                DataKeyNames="SupportID" DataSourceID="AccessDataSourceSupport" DefaultMode="Insert"
                                ForeColor="#333333" GridLines="None" HeaderText="הוספת שורה חדשה" Height="50px"
                                Width="300px" BorderColor="Blue" BorderStyle="Solid" BorderWidth="2px">
                                <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                                <AlternatingRowStyle BackColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                                <EditRowStyle BackColor="#2461BF" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <Fields>
                                    <asp:BoundField DataField="SupportID" HeaderText="SupportID" InsertVisible="False"
                                        ReadOnly="True" SortExpression="SupportID" Visible="False" />
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="CustomerName" HeaderText="שם דייר" SortExpression="CustomerName" >
                                        <HeaderStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="isSISDone" HeaderText="האם מולא SIS החודש" SortExpression="isSISDone" />
                                    <asp:CheckBoxField DataField="isLifeQualityDonw" HeaderText="האם מולא שאלון איכות חיים החודש"
                                        SortExpression="isLifeQualityDonw" />
                                    <asp:CheckBoxField DataField="IsSupportPlaneDone" HeaderText="האם הוכנה תוכנית תמיכות החודש"
                                        SortExpression="IsSupportPlaneDone" />
                                    <asp:CommandField CancelText="ביטול" InsertText="הוספה" ShowInsertButton="True" />
                                </Fields>
                            </asp:DetailsView>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="height: 15px" valign="top">
                            &nbsp;<asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" BorderColor="Blue"
                                BorderStyle="Solid" BorderWidth="2px" CellPadding="4" DataSourceID="AccessDataSourceReport4"
                                ForeColor="#333333" GridLines="None">
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <AlternatingRowStyle BackColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <Columns>
                                    <asp:BoundField DataField="ReportID" HeaderText="ReportID" SortExpression="ReportID"
                                        Visible="False" />
                                    <asp:BoundField DataField="FrameID" HeaderText="FrameID" SortExpression="FrameID"
                                        Visible="False" />
                                    <asp:BoundField DataField="ReportDate" HeaderText="ReportDate" SortExpression="ReportDate"
                                        Visible="False" />
                                    <asp:BoundField DataField="ItemID" HeaderText="ItemID" SortExpression="ItemID" Visible="False" />
                                    <asp:BoundField DataField="ItemName" SortExpression="ItemName" />
                                    <asp:TemplateField SortExpression="ItemValue">
                                        <EditItemTemplate>
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("ItemValue") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("ItemValue") %>'></asp:TextBox>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
                <span style="color: #cc0033">מיכל ויואב<br />
                    תאריכי מפגשי ההנחיה מוקלדים כטקסט חופשי.<br />
                    המסך הזה אחיד לכל המסגרות<br />
                    עברו למסך הבא...</span></asp:WizardStep>
            <asp:WizardStep runat="server" StepType="Finish" Title="סיום">
                <asp:Label ID="Label7" runat="server" BackColor="#C0C0FF" Font-Size="14pt" Font-Underline="True"
                    ForeColor="Blue" Text="סיום"></asp:Label>
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <br />
                <asp:CheckBox ID="CheckBox1" runat="server" Text="הדוח הושלם ומוכן להפצה" ForeColor="Blue" />
                <br />
                <br />
                <br />
                <br />
                <span style="color: #cc0033">מיכל ויואב<br />
                    בדומה לסטטוס של הטופס הראשון כאן מציין המנהל מתי גמר להכין את הדוח והוא מוכן להעברה
                    אליכם.<br />
                    זהו.. הכנה לפגישתנו.<br />
                <br />
                </span>
            </asp:WizardStep>
        </WizardSteps>
        <StepStyle Font-Size="0.8em" ForeColor="#333333" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
        <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
            Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
    </asp:Wizard>
    &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;
    <asp:AccessDataSource ID="AccessDataSourceReports" runat="server" DataFile="~/App_Data/Sherut.mdb"
        InsertCommand="INSERT INTO [MR_Reports] ([FrameID], [ReportDate]) VALUES (?, ?)"
        SelectCommand="SELECT [ReportID], [FrameID], [ReportDate],  [ReportClosed] FROM [MR_Reports] WHERE ([FrameID] = ?)" >
        <InsertParameters>
            <asp:ControlParameter ControlID="Wizard1$DropDownListFrames" DefaultValue="999" Name="FrameID"
                PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="ReportDate" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="Wizard1$DropDownListFrames" DefaultValue="999" Name="FrameID"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceFrames" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceReport2" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT vMR_CustomersReport.ReportID, vMR_CustomersReport.FrameID, vMR_CustomersReport.ReportDate, vMR_CustomersReport.ItemID, vMR_CustomersReport.ItemName, vMR_CustomersReport.ItemValue&#13;&#10;FROM vMR_CustomersReport&#13;&#10;WHERE ((((vMR_CustomersReport.ReportID)=1)OR (((vMR_CustomersReport.ReportID) Is Null)) AND ((vMR_CustomersReport.FrameID)=1)) AND ((vMR_CustomersReport.ReportTypeID)=2)) ;&#13;&#10;">
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceEmpl" runat="server" DataFile="~/App_Data/Sherut.mdb"
        DeleteCommand="Delete From MR_EmpLeavingList Where RowID=?" InsertCommand="Insert Into MR_EmpLeavingList(ReportID,EmpName, EmpJob,EmpStartDate, ReasonID) Values(?,?,?,?,?)"
        SelectCommand="SELECT MR_EmpLeavingList.RowID, MR_EmpLeavingList.ReportID, MR_EmpLeavingList.EmpName, MR_EmpLeavingList.EmpJob, MR_EmpLeavingList.EmpStartDate, MR_EmpLeavingList.ReasonID, MR_EmpReasonList.Reason FROM (MR_EmpLeavingList LEFT OUTER JOIN MR_EmpReasonList ON MR_EmpLeavingList.ReasonID = MR_EmpReasonList.ReasonID)"
        UpdateCommand="Update MR_EmpLeavingList Set  MR_EmpLeavingList.EmpName= ?, MR_EmpLeavingList.EmpJob=?, MR_EmpLeavingList.EmpStartDate=?, MR_EmpLeavingList.ReasonID=?&#13;&#10;Where RowID=?">
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceReasons" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT [ReasonID], [Reason] FROM [MR_EmpReasonList]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceOpenJobs" runat="server" DataFile="~/App_Data/Sherut.mdb"
        DeleteCommand="DELETE FROM [MR_OpenJobs] WHERE [OpenJobID] = ?" InsertCommand="INSERT INTO [MR_OpenJobs] ([OpenJobID], [ReportID], [OpenJob]) VALUES (?, ?, ?)"
        SelectCommand="SELECT [OpenJobID], [ReportID], [OpenJob] FROM [MR_OpenJobs]"
        UpdateCommand="UPDATE [MR_OpenJobs] SET [ReportID] = ?, [OpenJob] = ? WHERE [OpenJobID] = ?">
        <DeleteParameters>
            <asp:Parameter Name="OpenJobID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ReportID" Type="Int32" />
            <asp:Parameter Name="OpenJob" Type="String" />
            <asp:Parameter Name="OpenJobID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="OpenJobID" Type="Int32" />
            <asp:Parameter Name="ReportID" Type="Int32" />
            <asp:Parameter Name="OpenJob" Type="String" />
        </InsertParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceSupport" runat="server" DataFile="~/App_Data/Sherut.mdb"
        DeleteCommand="DELETE FROM [MR_SupportActivities] WHERE [SupportID] = ?" InsertCommand="INSERT INTO [MR_SupportActivities] ([SupportID], [ReportID], [CustomerName], [isSISDone], [isLifeQualityDonw], [IsSupportPlaneDone]) VALUES (?, ?, ?, ?, ?, ?)"
        SelectCommand="SELECT [SupportID], [ReportID], [CustomerName], [isSISDone], [isLifeQualityDonw], [IsSupportPlaneDone] FROM [MR_SupportActivities]"
        UpdateCommand="UPDATE [MR_SupportActivities] SET [ReportID] = ?, [CustomerName] = ?, [isSISDone] = ?, [isLifeQualityDonw] = ?, [IsSupportPlaneDone] = ? WHERE [SupportID] = ?">
        <DeleteParameters>
            <asp:Parameter Name="SupportID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ReportID" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="isSISDone" Type="Boolean" />
            <asp:Parameter Name="isLifeQualityDonw" Type="Boolean" />
            <asp:Parameter Name="IsSupportPlaneDone" Type="Boolean" />
            <asp:Parameter Name="SupportID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="SupportID" Type="Int32" />
            <asp:Parameter Name="ReportID" Type="Int32" />
            <asp:Parameter Name="CustomerName" Type="String" />
            <asp:Parameter Name="isSISDone" Type="Boolean" />
            <asp:Parameter Name="isLifeQualityDonw" Type="Boolean" />
            <asp:Parameter Name="IsSupportPlaneDone" Type="Boolean" />
        </InsertParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceReport1" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT vMR_CustomersReport.ReportID, vMR_CustomersReport.FrameID, vMR_CustomersReport.ReportDate, vMR_CustomersReport.ItemID, vMR_CustomersReport.ItemName, vMR_CustomersReport.ItemValue&#13;&#10;FROM vMR_CustomersReport&#13;&#10;WHERE (((vMR_CustomersReport.ReportID)=?)OR (((vMR_CustomersReport.ReportID) Is Null)) AND ((vMR_CustomersReport.FrameID)=?) AND ((vMR_CustomersReport.ReportTypeID)=1))&#13;&#10;Order by vMR_CustomersReport.ItemID&#13;&#10;"
        UpdateCommand="Update MR_CustomersRecords Set ReportID=@ReportID, TextValue=IIf(vMR_ReportedR.DataTypeID=1,@ItemValue,NULL),     NumberValue=IIf(vMR_ReportedR.DataTypeID=2,@ItemValue,0),      DateValue=IIf(vMR_ReportedR.DataTypeID=3,@ItemValue,NULL),     DoubleValue=IIf(vMR_ReportedR.DataTypeID=4,@ItemValue,0) Where RowID=@RowID">
        <SelectParameters>
            <asp:ControlParameter ControlID="Wizard1$GridView7" DefaultValue="999999" Name="ReportID" PropertyName="Selectedvalue" />
            <asp:ControlParameter ControlID="Wizard1$DropDownListFrames" DefaultValue="999" Name="FrameID"
                PropertyName="SelectedValue" />
        </SelectParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="Wizard1$GridView7" DefaultValue="999999" Name="ReportID" PropertyName="Selectedvalue" />
            <asp:Parameter Name="Itemvalue" Type=string />
        </UpdateParameters>
    </asp:AccessDataSource>
    <asp:AccessDataSource ID="AccessDataSourceReport4" runat="server" DataFile="~/App_Data/Sherut.mdb"
        SelectCommand="SELECT vMR_CustomersReport.ReportID, vMR_CustomersReport.FrameID, vMR_CustomersReport.ReportDate, vMR_CustomersReport.ItemID, vMR_CustomersReport.ItemName, vMR_CustomersReport.ItemValue&#13;&#10;FROM vMR_CustomersReport&#13;&#10;WHERE( (((vMR_CustomersReport.ReportID)=1)OR (((vMR_CustomersReport.ReportID) Is Null))) AND ((vMR_CustomersReport.FrameID)=1) AND ((vMR_CustomersReport.ReportTypeID)=4)) ;&#13;&#10;">
    </asp:AccessDataSource>
    <span style="color: #cc0033"></span>
</asp:Content>

