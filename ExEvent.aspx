<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" CodeFile="ExEvent.aspx.vb" Inherits="ExEvent" title="בית אקשטיין - טופס ארוע חריג" EnableEventValidation ="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<style type="text/css">
	.rcell
	{
	    background-color:#99ccff;
	    padding:2px 2px 2px 2px;
	    border:1px solid #999999;
	}
	.lcell
	{
	    padding:2px 2px 2px 2px;	    
	    border:1px solid #999999;
	}
</style>
    <script type="text/javascript">
function DoPrint() 
{
document.all("PRINT").style.visibility = "hidden";
document.all("CLOSE").style.visibility = "hidden";
window.print();
document.all("PRINT").style.visibility = "visible";
document.all("CLOSE").style.visibility = "visible";
}
function pshow() {
document.all("PRINT").style.visibility = "visible";
document.all("CLOSE").style.visibility = "visible";
}
</script>
<asp:ScriptManager runat="server" ID="scrpt" />
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" Height="55" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
    </div>
<div runat="server" id="divform">
<asp:SqlDataSource ID="DSEXEvents" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT ExEventID, ExEventHeader, ExEventLocationID, EventLocation, ExEventLocationDescrption, ExEventReporterJob, ExEventBodyInjury, ExEventpropertyDamages, ExEventStory, ExEventTypeID, lvl1, lvl2, ExEventimmediateActions, ExEventRequiredActions, ExEventStatusID, Status, ExEventWhyNotClosed, ExEventAsClosingDate, ExEventSeverityID, Reported, RepID, CustomerID, CustFirstName, CustLastName, CustEventTypeName, CustEventRegDate, CustEventDate, CustEventComment, FrameName, CframeManager, CustFrameID, ServiceID, CustEventTypeID, CustEventGroupID, CustEventGroupName, CustomerName, CReporterUserName, CustBirthDate, CustEventID, ShortSatatus, Severity FROM p0v_EXEventList WHERE (ExEventID = @ExEventID)" 
        InsertCommand="p0p_INSEXEVENT" InsertCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter Name="ExEventID" QueryStringField="ID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:sessionParameter sessionfield="CustEventTypeID" Name="CustEventTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" Type="DateTime" />
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:sESSIONParameter Name="CustFrameID" sessionfield="FrameID" Type="Int32" />
            <asp:Parameter Name="CframeManager" Type="String" />
            <asp:Parameter Name="CReporterUserName" Type="String" />
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="MSum" Type="Decimal" />
            <asp:Parameter Name="PCustEventID" Type="Int32" />
            <asp:Parameter Name="CustEventResult" Type="Int32" />
            <asp:Parameter Name="ExEventHeader" Type="String" />
            <asp:Parameter Name="ExEventLocationID" Type="Int32" />
            <asp:Parameter Name="ExEventLocationDescrption" Type="String" />
            <asp:Parameter Name="ExEventReporterJob" Type="String" />
            <asp:Parameter Name="ExEventBodyInjury" Type="String" />
            <asp:Parameter Name="ExEventpropertyDamages" Type="String" />
            <asp:Parameter Name="ExEventStory" Type="String" />
            <asp:Parameter Name="ExEventTypeID" Type="Int32" />
            <asp:Parameter Name="ExEventimmediateActions" Type="String" />
            <asp:Parameter Name="ExEventRequiredActions" Type="String" />
            <asp:Parameter Name="ExEventStatusID" Type="Int32" />
            <asp:Parameter Name="ExEventWhyNotClosed" Type="String" />
            <asp:Parameter Name="ExEventAsClosingDate" Type="DateTime" />
            <asp:Parameter Name="ExEventSeverityID" Type="Int32" />
            <asp:Parameter Name="ExEventReportedTo" Type="String" />
            <asp:Parameter Name="CustRelateID" Type="Int32" />
            <asp:Parameter Name="ActType" Type="Int32" />
            <asp:Parameter Name="CustEventID" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" ForeColor="Black"
        Text="דיווח על ארוע חריג                   - טופס מס' 1"></asp:Label>
    <br />
    <div runat="server" id="divrstr" visible="false">
        <asp:Label runat="server" ID="lblx" Text="שחזור של ארוע חריג שהזנתו הסתיימה ללא שמירה בבסיס הנתונים:?" ForeColor="Red" />
        <asp:RadioButtonList runat="server" ID="rblrst" ForeColor="Red" RepeatDirection="Vertical" OnSelectedIndexChanged="rblrst_SelectedIndexChanged" AutoPostBack="true" >
            <asp:ListItem Value="0" Text="מחיקת הארוע וחזרה לניהול תיקי לקוחות" />
            <asp:ListItem Value="1" Text="שחזור הארוע והמשך הטיפול בו" />
        </asp:RadioButtonList>
    </div>
    <asp:UpdatePanel runat="server" ID="updx" ><ContentTemplate>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="ExEventID" DataSourceID="DSEXEvents" DefaultMode="Insert" RowStyle-Wrap="true">
        <InsertItemTemplate>
            <table border="1">
                <tr>
                    <td style="width: 100px">
                        <table>
                            <tr>
                                <td bgcolor="lightgrey">
                                    <asp:Label ID="Label2" runat="server" Width="120px"></asp:Label>
                                </td>
                                <td bgcolor="lightgrey" style="width: 100px">
                                    <asp:Label ID="Label6" runat="server" Text="פרטים כלליים" Width="400px" Font-Size="Medium"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שם מסגרת
                                </td>
                                <td style="width: 100px">
                                    <asp:HiddenField ID="HDNEVENTTYPEID" runat="server" />
                                    <asp:HiddenField ID="HDNFRAMEID" runat="server" 
                                        Value='<%# BIND("CustFrameID") %>' />
                                    <asp:Label ID="LBFRAME" runat="server" Text='<%# Eval("FrameName") %>' 
                                        Width="400px"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שם מנהל
                            </td>
                            <td style="width: 100px">
                                <asp:Label ID="CUSTFRAMEMANAGER" runat="server" Height="20px" 
                                    Text='<%# Bind("FrameManager") %>' Width="400px"></asp:Label>
                                <asp:Label ID="CUSTFrameID" runat="server" Text='<%# Bind("FramID") %>' 
                                    Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px; height: 13px">
                                תאריך טופס
                            </td>
                            <td style="width: 100px; height: 13px">
                                <asp:Label ID="CustEventRegDate" runat="server" 
                                    Text='<%# Bind("ExEventFormDate") %>' Width="400px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px; height: 20px">
                                 שם הלקוח / הנפגע
                            </td>
                            <td style="width: 100px; height: 20px">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="LBCUSTOMER" runat="server" Text='<%# Eval("CustomerName") %>' 
                                                Width="250px"></asp:Label>
                                        </td>
                                        <td>
                                            ת.ז.
                                        </td>
                                        <td>
                                            <asp:Label ID="LBCustomerID" runat="server" Text='<%# Bind("CustomerID") %>' 
                                                Visible="true"></asp:Label>
                                            <asp:Button ID="Button1" runat="server" Text="הוספת לקוח" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px">
                                שם הדוח</td>
                            <td style="width: 100px">
                                     <asp:TextBox ID="TBEXEVENTHEADER" runat="server"
                                            Text='<%# Bind("ExEventHeader") %>' Width="400px" AutoPostBack="true" OnTextChanged="tb_TextChanged"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                        ControlToValidate="TBEXEVENTHEADER" Display="Dynamic" ErrorMessage="חובה להזין שם לדוח"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px">
                                 תאריך לידה   </td>
                            <td style="width: 100px">
                                <asp:Label ID="LBBDATE" runat="server" Text='<%# Eval("CustBirthDate") %>' 
                                    Width="400px"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px">
                                גיל</td>
                            <td style="width: 100px">
                                <asp:Label ID="LBAGE" runat="server" Width="400px"></asp:Label>
                            </td>
                        </tr>
                       <tr>
                            <td bgcolor="#99ccff" style="width: 340px; height: 218px;">
                                תאריך הארוע</td>
                            <td style="width: 100px; height: 218px;">
                                <asp:Calendar ID="CALEVENTDATE" runat="server" BackColor="White" 
                                    BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                                    DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                                    ForeColor="#003399" Height="200px" OnLoad="CALEVENT_Load" 
                                    onprerender="CALEVENTDATE_PreRender" Width="220px" TabIndex="10">
                                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                    <WeekendDayStyle BackColor="#CCCCFF" />
                                    <OtherMonthDayStyle ForeColor="#999999" />
                                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" 
                                        Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                </asp:Calendar>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px">
                                שעת הארוע</td>
                            <td style="width: 100px">
                                &nbsp;<asp:DropDownList ID="DDLHOUR" runat="server" 
                                    SelectedValue='<%# Bind("ExEventDate") %>' TabIndex="20">
                                    <asp:ListItem>00:00</asp:ListItem>
                                    <asp:ListItem>00:15</asp:ListItem>
                                    <asp:ListItem>00:30</asp:ListItem>
                                    <asp:ListItem>00:45</asp:ListItem>
                                    <asp:ListItem>01:00</asp:ListItem>
                                    <asp:ListItem>01:15</asp:ListItem>
                                    <asp:ListItem>01:30</asp:ListItem>
                                    <asp:ListItem>01:45</asp:ListItem>
                                    <asp:ListItem>02:00</asp:ListItem>
                                    <asp:ListItem>02:15</asp:ListItem>
                                    <asp:ListItem>02:30</asp:ListItem>
                                    <asp:ListItem>02:45</asp:ListItem>
                                    <asp:ListItem>03:00</asp:ListItem>
                                    <asp:ListItem>03:15</asp:ListItem>
                                    <asp:ListItem>03:30</asp:ListItem>
                                    <asp:ListItem>03:45</asp:ListItem>
                                    <asp:ListItem>04:00</asp:ListItem>
                                    <asp:ListItem>04:15</asp:ListItem>
                                    <asp:ListItem>04:30</asp:ListItem>
                                    <asp:ListItem>04:45</asp:ListItem>
                                    <asp:ListItem>05:00</asp:ListItem>
                                    <asp:ListItem>05:15</asp:ListItem>
                                    <asp:ListItem>05:30</asp:ListItem>
                                    <asp:ListItem>05:45</asp:ListItem>
                                    <asp:ListItem>06:00</asp:ListItem>
                                    <asp:ListItem>06:15</asp:ListItem>
                                    <asp:ListItem>06:30</asp:ListItem>
                                    <asp:ListItem>06:45</asp:ListItem>
                                    <asp:ListItem>07:00</asp:ListItem>
                                    <asp:ListItem>07:15</asp:ListItem>
                                    <asp:ListItem>07:30</asp:ListItem>
                                    <asp:ListItem>07:45</asp:ListItem>
                                    <asp:ListItem>08:00</asp:ListItem>
                                    <asp:ListItem>08:15</asp:ListItem>
                                    <asp:ListItem>08:30</asp:ListItem>
                                    <asp:ListItem>08:45</asp:ListItem>
                                    <asp:ListItem>09:00</asp:ListItem>
                                    <asp:ListItem>09:15</asp:ListItem>
                                    <asp:ListItem>09:30</asp:ListItem>
                                    <asp:ListItem>09:45</asp:ListItem>
                                    <asp:ListItem>10:00</asp:ListItem>
                                    <asp:ListItem>10:15</asp:ListItem>
                                    <asp:ListItem>10:30</asp:ListItem>
                                    <asp:ListItem>10:45</asp:ListItem>
                                    <asp:ListItem>11:00</asp:ListItem>
                                    <asp:ListItem>11:15</asp:ListItem>
                                    <asp:ListItem>11:30</asp:ListItem>
                                    <asp:ListItem>11:45</asp:ListItem>
                                    <asp:ListItem Selected="true">12:00</asp:ListItem>
                                    <asp:ListItem>12:15</asp:ListItem>
                                    <asp:ListItem>12:30</asp:ListItem>
                                    <asp:ListItem>12:45</asp:ListItem>
                                    <asp:ListItem>13:00</asp:ListItem>
                                    <asp:ListItem>13:15</asp:ListItem>
                                    <asp:ListItem>13:30</asp:ListItem>
                                    <asp:ListItem>13:45</asp:ListItem>
                                    <asp:ListItem>14:00</asp:ListItem>
                                    <asp:ListItem>14:15</asp:ListItem>
                                    <asp:ListItem>14:30</asp:ListItem>
                                    <asp:ListItem>14:45</asp:ListItem>
                                    <asp:ListItem>15:00</asp:ListItem>
                                    <asp:ListItem>15:15</asp:ListItem>
                                    <asp:ListItem>15:30</asp:ListItem>
                                    <asp:ListItem>15:45</asp:ListItem>
                                    <asp:ListItem>16:00</asp:ListItem>
                                    <asp:ListItem>16:15</asp:ListItem>
                                    <asp:ListItem>16:30</asp:ListItem>
                                    <asp:ListItem>16:45</asp:ListItem>
                                    <asp:ListItem>17:00</asp:ListItem>
                                    <asp:ListItem>17:15</asp:ListItem>
                                    <asp:ListItem>17:30</asp:ListItem>
                                    <asp:ListItem>17:45</asp:ListItem>
                                    <asp:ListItem>18:00</asp:ListItem>
                                    <asp:ListItem>18:15</asp:ListItem>
                                    <asp:ListItem>18:30</asp:ListItem>
                                    <asp:ListItem>18:45</asp:ListItem>
                                    <asp:ListItem>19:00</asp:ListItem>
                                    <asp:ListItem>19:15</asp:ListItem>
                                    <asp:ListItem>19:30</asp:ListItem>
                                    <asp:ListItem>19:45</asp:ListItem>
                                    <asp:ListItem>20:00</asp:ListItem>
                                    <asp:ListItem>20:15</asp:ListItem>
                                    <asp:ListItem>20:30</asp:ListItem>
                                    <asp:ListItem>20:45</asp:ListItem>
                                    <asp:ListItem>21:00</asp:ListItem>
                                    <asp:ListItem>21:15</asp:ListItem>
                                    <asp:ListItem>21:30</asp:ListItem>
                                    <asp:ListItem>21:45</asp:ListItem>
                                    <asp:ListItem>22:00</asp:ListItem>
                                    <asp:ListItem>22:15</asp:ListItem>
                                    <asp:ListItem>22:30</asp:ListItem>
                                    <asp:ListItem>22:45</asp:ListItem>
                                    <asp:ListItem>23:00</asp:ListItem>
                                    <asp:ListItem>23:15</asp:ListItem>
                                    <asp:ListItem>23:30</asp:ListItem>
                                    <asp:ListItem>23:45</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px; color: #FF0000;">
                               ס<span style="color: #FF0000">סיווג הארוע</span></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="DDLEVENTSUBTYPE" runat="server" 
                                    AppendDataBoundItems="True" DataSourceID="DSSUBTYPE" DataTextField="lvl2" 
                                    DataValueField="ID" 
                                    OnSelectedIndexChanged="DDLEVENTSUBTYPE_SelectedIndexChanged" 
                                    SelectedValue='<%# Bind("ExEventTypeID") %>' TabIndex="30">
                                    <asp:ListItem Text="&lt;בחר סיווג&gt;" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                    ControlToValidate="DDLEVENTSUBTYPE" Display="Dynamic" ErrorMessage="חובה לבחור סיווג לארוע"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px; color: #FF0000;">
                                חומרת הארוע</td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="DDLSEVERITY" runat="server" AppendDataBoundItems="True" 
                                    DataSourceID="DSSEVERITY" DataTextField="SEVERITY" DataValueField="SEVERITYID" 
                                    SelectedValue='<%# Bind("ExEventSEVERITYID") %>' TabIndex="40">
                                    <asp:ListItem Text="&lt;בחר דרגת חומרה&gt;" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                    ControlToValidate="DDLSEVERITY" Display="Dynamic" ErrorMessage="חובה לבחור רמת חומרה לארוע"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td bgcolor="#99ccff" style="width: 340px; color: #FF0000;">
                                מקום הארוע</td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="DDLLOCATION" runat="server" AppendDataBoundItems="True" 
                                    DataSourceID="DSLOCATION" DataTextField="EventLocation" DataValueField="ID" 
                                    SelectedValue='<%# Bind("ExEventLocationID") %>' TabIndex="50">
                                    <asp:ListItem Text="&lt;בחר מקום&gt;" Value=""></asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                    ControlToValidate="DDLLOCATION" Display="Dynamic" ErrorMessage="חובה לבחור מיקום לארוע"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                     </table>
                </td>
            </tr>
            <tr>
                 <td style="width: 100px">
                      <table>
                          <tr>
                              <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label3" runat="server" Width="120px" text=""></asp:Label></td>
                              <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label5" runat="server" Text="תיאור מפורט" 
                                        Width="400px" Font-Size="Medium"></asp:Label></td>
                          </tr>
                          <tr>
                               <td bgcolor="#99ccff" style="width: 100px">
                                    תאור מקום הארוע</td>
                               <td style="width: 100px">
                                        <asp:TextBox ID="TBExEventLocationDescrption" runat="server" Text='<%# Bind("ExEventLocationDescrption") %>'
                                            Width="400px" onprerender="TB_PreRender" 
                                            ontextchanged="TB_TextChanged" TabIndex="60" AutoPostBack="true"></asp:TextBox>
                                </td>
                           </tr>
                           <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    איש הצוות הראשון לדעת על הארוע (שם ותפקיד)</td>
                                <td style="width: 100px">

                                        <asp:TextBox ID="TBExEventReporterJob" runat="server" Text='<%# Bind("ExEventReporterJob") %>'
                                            Width="400px" onprerender="TB_PreRender" 
                                            ontextchanged="TB_TextChanged" TabIndex="70" AutoPostBack="true"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    נזקי גוף</td>
                                <td style="width: 100px">

                                        <asp:TextBox ID="TBExEventBodyInjury" runat="server" Rows="2" TextMode="MultiLine" 
                                            Width="400px" Text='<%# Bind("ExEventBodyInjury") %>' 
                                            onprerender="TB_PreRender" ontextchanged="TB_TextChanged" TabIndex="80" AutoPostBack="true"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    נזקי רכוש</td>
                                <td style="width: 100px">

                                        <asp:TextBox ID="TBExEventpropertyDamages" runat="server" Rows="2" 
                                            TextMode="MultiLine" Width="400px" 
                                            Text='<%# Bind("ExEventpropertyDamages") %>' onprerender="TB_PreRender" 
                                            ontextchanged="TB_TextChanged" TabIndex="90" AutoPostBack="true"></asp:TextBox>
 
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <span lang="he">תאור מפורט של הארוע (שמות לקוחות ואנשי צוות העדים לארוע, מצבו הנפשי/פיזי
                                        של הלקוח לפני הארוע, השתלשלות הארוע, תוצאות הארוע) </span>
                                </td>
                                <td style="width: 100px">

                                        <asp:TextBox ID="TBExEventStory" runat="server" Rows="8" Text='<%# Bind("ExEventStory") %>'
                                            TextMode="MultiLine" Width="400px" 
                                            onprerender="TB_PreRender" ontextchanged="TB_TextChanged" TabIndex="100" AutoPostBack="true"></asp:TextBox>

                                 </td>
                             </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <table>
                            <tr>
                                <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label4" runat="server" Width="120px"></asp:Label></td>
                                <td bgcolor="gainsboro" style="width: 103px">
                                    <asp:Label ID="Label7" runat="server" Font-Size="Medium" Text="ניהול הארוע" Width="400px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px; height: 40px;">
                                    פעולות מידיות שננקטו</td>
                                <td style="width: 103px; height: 40px;">

                                           <asp:TextBox ID="TBExEventimmediateActions" runat="server" Rows="2" Text='<%# Bind("ExEventimmediateActions") %>'
                                                TextMode="MultiLine" Width="400px" 
                                                onprerender="TB_PreRender" ontextchanged="TB_TextChanged" TabIndex="110" AutoPostBack="true"></asp:TextBox>

                               </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    פעולות לביצוע בהמשך</td>
                                <td style="width: 103px">
 
                                         <asp:TextBox ID="TBExEventRequiredActions" runat="server" Rows="2" Text='<%# Bind("ExEventRequiredActions") %>'
                                            TextMode="MultiLine" Width="400px" 
                                            onprerender="TB_PreRender" ontextchanged="TB_TextChanged" TabIndex="120" AutoPostBack="true"></asp:TextBox>
 
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    למי דווח</td>
                                <td style="width: 103px">
                                    <asp:CheckBoxList ID="CBReportedTo" runat="server" DataSourceID="DSREPORTED" DataTextField="Reported"
                                        DataValueField="RepID" RepeatDirection="Horizontal" 
                                        SelectedValue='<%# Bind("ExEventReportedTo") %>' Font-Size="X-Small" 
                                        RepeatColumns="4" Width="400px" TabIndex="130">
                                    </asp:CheckBoxList>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    סטטוס</td>
                                <td style="width: 103px">
                                    <asp:DropDownList ID="DDLSTATUS" runat="server" 
                                        SelectedValue='<%# Bind("ExEventStatusID") %>' DataSourceID="DSSTATUS" 
                                        DataTextField="Status" DataValueField="StatusID" TabIndex="140">
                                   </asp:DropDownList>                                     <asp:HiddenField runat="server" ID="HDNCLOSINGDate" />
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <asp:Label ID="Label8" runat="server" Text="מדוע הארוע לא נסגר?" Visible="False"
                                        Width="120px"></asp:Label></td>
                                <td style="width: 103px">

                                            <asp:TextBox ID="TBExEventWhyNotClosed" runat="server" Text='<%# Bind("ExEventWhyNotClosed") %>'
                                             TextMode="MultiLine" Visible="False" Width="400px" TabIndex="150" AutoPostBack="true" OnTextChanged="tb_TextChanged"></asp:TextBox>

                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <asp:Label ID="LBDateNotClosed" runat="server" Text="תאריך סגירה צפוי" Visible="False"
                                        Width="120px"></asp:Label></td>
                                <td style="width: 103px">
                                    <asp:Calendar ID="CALCOLSINGDATE" runat="server" BackColor="White" BorderColor="#3366CC"
                                        BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana"
                                        Font-Size="8pt" ForeColor="#003399" Height="200px"
                                        Visible="False" Width="220px" SelectedDate='<%# Bind("ExEventAsClosingDate") %>'>
                                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                        <WeekendDayStyle BackColor="#CCCCFF" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                            Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                    </asp:Calendar>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="gainsboro" style="width: 100px">
                                </td>
                                <td bgcolor="gainsboro" style="width: 103px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <asp:LinkButton ID="LNKBINSERT" runat="server" OnClick="LNKBINSERT_Click" ToolTip="לחץ לכתיבת הארוע לבסיס הנתונים">שליחה למערכת</asp:LinkButton></td>
                                    <asp:ValidationSummary runat="server" ID="VSUM" ShowSummary="true" ShowMessageBox="true" DisplayMode="BulletList" />
                                <td style="width: 103px">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel" PostBackUrl="CustEventReport.aspx">חזרה</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <EditItemTemplate>
            <table border="1">
                <tr>
                    <td style="width: 100px">
                        <table>
                            <tr>
                                <td bgcolor="lightgrey">
                                    <asp:Label ID="Label2" runat="server" Width="120px"></asp:Label></td>
                                <td bgcolor="lightgrey" style="width: 100px">
                                
                                    <table >
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label9" runat="server" Font-Size="Medium" Text="פרטים כלליים" 
                                                    Width="200px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label00" runat="server" Text="טופס מספר" Width="100px"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label11" runat="server" Text='<%# Eval("ExEventID") & " (" & Eval("ShortSatatus") & ")" %>' 
                                                    Width="100px"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                
                                
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שם מסגרת</td>
                                <td style="width: 100px">
                                    <asp:Label ID="LBFRAME" runat="server" Text='<%# Eval("FrameName") %>' Width="400px"></asp:Label>
                                    <asp:HiddenField ID="HDNCUSTEVENTID" runat="server" 
                                        Value='<%# Eval("CustEventID") %>' />
                                    <asp:HiddenField ID="HDNEVENTTYPEID" runat="server" 
                                        Value='<%# Eval("CustEventTypeID") %>' />
                                    <asp:HiddenField runat="server" ID="HDNFRAMEID" Value='<%# BIND("CustFrameID") %>' /></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שם מנהל</td>
                                <td style="width: 100px">
                                    <asp:Label ID="CUSTFRAMEMANAGER" runat="server" Height="20px" Text='<%# Bind("CFrameManager") %>' Width="400px"></asp:Label>
                                    <asp:Label ID="CUSTFrameID" runat="server" Text='<%# Bind("custFrameID") %>' Visible="False"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px; height: 13px" >
                                    תאריך טופס</td>
                                <td style="width: 100px; height: 13px">
                                    <asp:Label ID="CustEventRegDate" runat="server" 
                                        Text='<%# Bind("CustEventRegDate", "{0:g}") %>' Width="400px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px; height: 20px">
                                    שם הלקוח / הנפגע</td>
                                <td style="width: 100px; height: 20px">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="LBCUSTOMER" runat="server" Text='<%# Eval("CustomerName") %>' Width="250px"></asp:Label>
                                        </td>
                                        <td>ת.ז. </td>
                                        <td>
                                            <asp:Label ID="LBCustomerID" runat="server" Text='<%# Bind("CustomerID") %>' Visible="true"></asp:Label>
                                            <asp:Button ID="Button1" runat="server" Text="הוספת לקוח" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                               </td>
                                  
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שם הדוח</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBEXEVENTHEADER" runat="server" Text='<%# Bind("ExEventHeader") %>'
                                        Width="400px"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                            runat="server" ErrorMessage="*" ControlToValidate="TBEXEVENTHEADER" Display="Dynamic"></asp:RequiredFieldValidator></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    תאריך לידה</td>
                                <td style="width: 100px">
                                    <asp:Label ID="LBBDATE" runat="server" 
                                        Text='<%# Eval("CustBirthDate", "{0:d}") %>' Width="400px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    גיל</td>
                                <td style="width: 100px">
                                    <asp:Label ID="LBAGE" runat="server" Width="400px" 
                                        onprerender="LBAGE_PreRender"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px; height: 218px;">
                                    תאריך הארוע</td>
                                <td style="width: 100px; height: 218px;">
                                    <asp:Calendar ID="CALEVENTDATE" runat="server" BackColor="White" 
                                        BorderColor="#3366CC" BorderWidth="1px" CellPadding="1" 
                                        DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" 
                                        ForeColor="#003399" Height="200px" Width="220px" OnLoad="CALEVENT_Load" 
                                        onprerender="CALEVENTDATE_PreRender" 
                                        SelectedDate='<%# cdate(format(Eval("CustEventDate"),"dd/MM/yy")) %>' 
                                        VisibleDate='<%# cdate(format(Eval("CustEventDate"),"dd/MM/yy")) %>'>
                                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                        <WeekendDayStyle BackColor="#CCCCFF" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                            Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                    </asp:Calendar>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    שעת הארוע</td>
                                <td style="width: 100px">
                                    &nbsp;<asp:DropDownList ID="DDLHOUR" runat="server" 
                                        onprerender="DDLHOUR_PreRender" SelectedValue='<%# ttm("CustEventDate") %>'>
                                        <asp:ListItem>00:00</asp:ListItem>
                                        <asp:ListItem>00:15</asp:ListItem>
                                        <asp:ListItem>00:30</asp:ListItem>
                                        <asp:ListItem>00:45</asp:ListItem>
                                        <asp:ListItem>01:00</asp:ListItem>
                                        <asp:ListItem>01:15</asp:ListItem>
                                        <asp:ListItem>01:30</asp:ListItem>
                                        <asp:ListItem>01:45</asp:ListItem>
                                        <asp:ListItem>02:00</asp:ListItem>
                                        <asp:ListItem>02:15</asp:ListItem>
                                        <asp:ListItem>02:30</asp:ListItem>
                                        <asp:ListItem>02:45</asp:ListItem>
                                        <asp:ListItem>03:00</asp:ListItem>
                                        <asp:ListItem>03:15</asp:ListItem>
                                        <asp:ListItem>03:30</asp:ListItem>
                                        <asp:ListItem>03:45</asp:ListItem>
                                        <asp:ListItem>04:00</asp:ListItem>
                                        <asp:ListItem>04:15</asp:ListItem>
                                        <asp:ListItem>04:30</asp:ListItem>
                                        <asp:ListItem>04:45</asp:ListItem>
                                        <asp:ListItem>05:00</asp:ListItem>
                                        <asp:ListItem>05:15</asp:ListItem>
                                        <asp:ListItem>05:30</asp:ListItem>
                                        <asp:ListItem>05:45</asp:ListItem>
                                        <asp:ListItem>06:00</asp:ListItem>
                                        <asp:ListItem>06:15</asp:ListItem>
                                        <asp:ListItem>06:30</asp:ListItem>
                                        <asp:ListItem>06:45</asp:ListItem>
                                        <asp:ListItem>07:00</asp:ListItem>
                                        <asp:ListItem>07:15</asp:ListItem>
                                        <asp:ListItem>07:30</asp:ListItem>
                                        <asp:ListItem>07:45</asp:ListItem>
                                        <asp:ListItem>08:00</asp:ListItem>
                                        <asp:ListItem>08:15</asp:ListItem>
                                        <asp:ListItem>08:30</asp:ListItem>
                                        <asp:ListItem>08:45</asp:ListItem>
                                        <asp:ListItem>09:00</asp:ListItem>
                                        <asp:ListItem>09:15</asp:ListItem>
                                        <asp:ListItem>09:30</asp:ListItem>
                                        <asp:ListItem>09:45</asp:ListItem>
                                        <asp:ListItem>10:00</asp:ListItem>
                                        <asp:ListItem>10:15</asp:ListItem>
                                        <asp:ListItem>10:30</asp:ListItem>
                                        <asp:ListItem>10:45</asp:ListItem>
                                        <asp:ListItem>11:00</asp:ListItem>
                                        <asp:ListItem>11:15</asp:ListItem>
                                        <asp:ListItem>11:30</asp:ListItem>
                                        <asp:ListItem>11:45</asp:ListItem>
                                        <asp:ListItem>12:00</asp:ListItem>
                                        <asp:ListItem>12:15</asp:ListItem>
                                        <asp:ListItem>12:30</asp:ListItem>
                                        <asp:ListItem>12:45</asp:ListItem>
                                        <asp:ListItem>13:00</asp:ListItem>
                                        <asp:ListItem>13:15</asp:ListItem>
                                        <asp:ListItem>13:30</asp:ListItem>
                                        <asp:ListItem>13:45</asp:ListItem>
                                        <asp:ListItem>14:00</asp:ListItem>
                                        <asp:ListItem>14:15</asp:ListItem>
                                        <asp:ListItem>14:30</asp:ListItem>
                                        <asp:ListItem>14:45</asp:ListItem>
                                        <asp:ListItem>15:00</asp:ListItem>
                                        <asp:ListItem>15:15</asp:ListItem>
                                        <asp:ListItem>15:30</asp:ListItem>
                                        <asp:ListItem>15:45</asp:ListItem>
                                        <asp:ListItem>16:00</asp:ListItem>
                                        <asp:ListItem>16:15</asp:ListItem>
                                        <asp:ListItem>16:30</asp:ListItem>
                                        <asp:ListItem>16:45</asp:ListItem>
                                        <asp:ListItem>17:00</asp:ListItem>
                                        <asp:ListItem>17:15</asp:ListItem>
                                        <asp:ListItem>17:30</asp:ListItem>
                                        <asp:ListItem>17:45</asp:ListItem>
                                        <asp:ListItem>18:00</asp:ListItem>
                                        <asp:ListItem>18:15</asp:ListItem>
                                        <asp:ListItem>18:30</asp:ListItem>
                                        <asp:ListItem>18:45</asp:ListItem>
                                        <asp:ListItem>19:00</asp:ListItem>
                                        <asp:ListItem>19:15</asp:ListItem>
                                        <asp:ListItem>19:30</asp:ListItem>
                                        <asp:ListItem>19:45</asp:ListItem>
                                        <asp:ListItem>20:00</asp:ListItem>
                                        <asp:ListItem>20:15</asp:ListItem>
                                        <asp:ListItem>20:30</asp:ListItem>
                                        <asp:ListItem>20:45</asp:ListItem>
                                        <asp:ListItem>21:00</asp:ListItem>
                                        <asp:ListItem>21:15</asp:ListItem>
                                        <asp:ListItem>21:30</asp:ListItem>
                                        <asp:ListItem>21:45</asp:ListItem>
                                        <asp:ListItem>22:00</asp:ListItem>
                                        <asp:ListItem>22:15</asp:ListItem>
                                        <asp:ListItem>22:30</asp:ListItem>
                                        <asp:ListItem>22:45</asp:ListItem>
                                        <asp:ListItem>23:00</asp:ListItem>
                                        <asp:ListItem>23:15</asp:ListItem>
                                        <asp:ListItem>23:30</asp:ListItem>
                                        <asp:ListItem>23:45</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    סיווג הארוע</td>
                                <td style="width: 100px">
                                    <asp:DropDownList ID="DDLEVENTSUBTYPE" runat="server" AppendDataBoundItems=True 
                                        DataSourceID="DSSUBTYPE" DataTextField="lvl2"
                                        DataValueField="ID" SelectedValue='<%# Bind("ExEventTypeID") %>' 
                                        OnSelectedIndexChanged="DDLEVENTSUBTYPE_SelectedIndexChanged">
                                        <asp:ListItem Text="&lt;בחר סיווג&gt;" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="DDLEVENTSUBTYPE"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                            </tr>
                             <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    חומרת הארוע</td>
                                <td style="width: 100px">
                                    <asp:DropDownList ID="DDLSEVERITY" runat="server" AppendDataBoundItems="True" DataSourceID="DSSEVERITY" DataTextField="SEVERITY"
                                        DataValueField="SEVERITYID" SelectedValue='<%# Bind("EXEVENTSEVERITYID") %>'>
                                        <asp:ListItem Text="&lt;בחר דרגת חומרה&gt;" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="DDLSEVERITY"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                            </tr>
                           <tr>
                                <td bgcolor="#99ccff" style="width: 340px">
                                    מקום הארוע</td>
                                <td style="width: 100px">
                                    <asp:DropDownList ID="DDLLOCATION" runat="server" AppendDataBoundItems=True DataSourceID="DSLOCATION" DataTextField="EventLocation"
                                        DataValueField="ID" SelectedValue='<%# Bind("ExEventLocationID") %>'>
                                        <asp:ListItem Text="&lt;בחר מקום&gt;" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="DDLLOCATION"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <table>
                            <tr>
                                <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label3" runat="server" Width="120px" text=""></asp:Label></td>
                                <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label5" runat="server" Text="תיאור מפורט" 
                                        Width="400px" Font-Size="Medium"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    תאור מקום הארוע</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBExEventLocationDescrption" runat="server" Text='<%# Bind("ExEventLocationDescrption") %>'
                                        Width="400px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    איש הצוות הראשון לדעת על הארוע (שם ותפקיד)</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBExEventReporterJob" runat="server" Text='<%# Bind("ExEventReporterJob") %>'
                                        Width="400px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    נזקי גוף</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBExEventBodyInjury" runat="server" Rows="2" TextMode="MultiLine" Width="400px" Text='<%# Bind("ExEventBodyInjury") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    נזקי רכוש</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBExEventpropertyDamages" runat="server" Rows="2" TextMode="MultiLine" Width="400px" Text='<%# Bind("ExEventpropertyDamages") %>'></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <span lang="he">תאור מפורט של הארוע (שמות לקוחות ואנשי צוות העדים לארוע, מצבו הנפשי/פיזי
                                        של הלקוח לפני הארוע, השתלשלות הארוע, תוצאות הארוע) </span>
                                </td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBExEventStory" runat="server" Rows="8" Text='<%# Bind("ExEventStory") %>'
                                        TextMode="MultiLine" Width="400px"></asp:TextBox></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px">
                        <table>
                            <tr>
                                <td bgcolor="gainsboro" style="width: 100px">
                                    <asp:Label ID="Label4" runat="server" Width="120px"></asp:Label></td>
                                <td bgcolor="gainsboro" style="width: 103px">
                                    <asp:Label ID="Label7" runat="server" Font-Size="Medium" Text="ניהול הארוע" Width="400px"></asp:Label></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px; height: 40px;">
                                    פעולות מידיות שננקטו</td>
                                <td style="width: 103px; height: 40px;">
                                    <asp:TextBox ID="TBExEventimmediateActions" runat="server" Rows="2" Text='<%# Bind("ExEventimmediateActions") %>'
                                        TextMode="MultiLine" Width="400px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    פעולות לביצוע בהמשך</td>
                                <td style="width: 103px">
                                    <asp:TextBox ID="TBExEventRequiredActions" runat="server" Rows="2" Text='<%# Bind("ExEventRequiredActions") %>'
                                        TextMode="MultiLine" Width="400px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    למי דווח</td>
                                <td style="width: 103px">
                                    <asp:CheckBoxList ID="CBReportedTo" runat="server" DataSourceID="DSREPORTED" DataTextField="Reported"
                                        DataValueField="RepID" RepeatDirection="Horizontal" Font-Size="X-Small" 
                                        RepeatColumns="4" Width="400px" onprerender="CBReportedTo_PreRender" 
                                        onselectedindexchanged="CBReportedTo_SelectedIndexChanged">
                                    </asp:CheckBoxList></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    סטטוס</td>
                                <td style="width: 103px">
                                    <asp:Label ID="Label24" runat="server" Text='<%# Eval("ShortSatatus") %>' 
                                        Visible='<%# Eval("ExEventStatusID")=3 %>'></asp:Label>
                                    <asp:DropDownList ID="DDLSTATUS" runat="server" 
                                        SelectedValue='<%# Bind("ExEventStatusID") %>' DataSourceID="DSSTATUS" 
                                        DataTextField="Status" DataValueField="StatusID" 
                                        Visible='<%# Eval("ExEventStatusID")<>3 %>'>
                                   </asp:DropDownList>                                     <asp:HiddenField runat="server" ID="HDNCLOSINGDate" />
</td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <asp:Label ID="Label8" runat="server" Text="מדוע הארוע לא נסגר?" Visible="False"
                                        Width="120px"></asp:Label></td>
                                <td style="width: 103px">
                                    <asp:TextBox ID="TBExEventWhyNotClosed" runat="server" Text='<%# Bind("ExEventWhyNotClosed") %>'
                                        TextMode="MultiLine" Visible='<%# Eval("ExEventStatusID")=2 %>' Width="400px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#99ccff" style="width: 100px">
                                    <asp:Label ID="LBDateNotClosed" runat="server" Text="תאריך סגירה צפוי" Visible="False"
                                        Width="120px"></asp:Label></td>
                                <td style="width: 103px">
                                    <asp:Calendar ID="CALCOLSINGDATE" runat="server" BackColor="White" BorderColor="#3366CC"
                                        BorderWidth="1px" CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana"
                                        Font-Size="8pt" ForeColor="#003399" Height="200px"
                                        Visible="False" Width="220px" >
                                        <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                        <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                        <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                        <WeekendDayStyle BackColor="#CCCCFF" />
                                        <OtherMonthDayStyle ForeColor="#999999" />
                                        <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                        <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                        <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                            Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                                    </asp:Calendar>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="gainsboro" style="width: 100px">
                                </td>
                                <td bgcolor="gainsboro" style="width: 103px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                    <asp:LinkButton ID="LNKBINSERT" runat="server" OnClick="LNKBINSERT_Click" 
                                        ToolTip="לחץ לכתיבת הארוע לבסיס הנתונים" 
                                        Visible='<%# Eval("ExEventStatusID")<>3 %>'>שליחה למערכת</asp:LinkButton></td>
                                <td style="width: 103px">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="Cancel" PostBackUrl="CustEventReport.aspx">חזרה</asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <ItemTemplate>
			<table style="width:530px;">
				<tr style="background-color:#DDDDDD;border-color:#DDDDDD;">
					<td style="width:20%;padding:2px 2px 2px 2px;"></td>
					<td style="width:20%;font-size:medium;padding:2px 2px 2px 2px;">פרטים כללים</td>
					<td style="width:20%;padding:2px 2px 2px 2px;">טופס מספר</td>
					<td style="width:40%;padding:2px 2px 2px 2px;">
						<asp:Label ID="Label11" runat="server" Text='<%# Eval("ExEventID") & " (" & Eval("ShortSatatus") & ")" %>' 
														Width="100px"></asp:Label>
					 </td> 
				</tr>
				<tr>
					<td class="rcell">
						שם המסגרת
					</td>
					<td class="lcell" colspan="3">
					                <asp:Label ID="LBFRAME" runat="server" Text='<%# Eval("FrameName") %>' Width="390" />
                                    <asp:HiddenField ID="HDNCUSTEVENTID" runat="server" 
                                        Value='<%# Eval("CustEventID") %>' />
                                    <asp:HiddenField ID="HDNEVENTTYPEID" runat="server" 
                                        Value='<%# Eval("CustEventTypeID") %>' />
                                    <asp:HiddenField runat="server" ID="HDNFRAMEID" Value='<%# BIND("CustFrameID") %>' />
					</td>
				</tr>
				<tr>
					<td class="rcell">
						שם המנהל
					</td>
					<td class="lcell" colspan="3">
                         <asp:Label ID="CUSTFRAMEMANAGER" runat="server" Height="20px" Text='<%# Bind("CFrameManager") %>'></asp:Label>
                          <asp:Label ID="CUSTFrameID" runat="server" Text='<%# Bind("custFrameID") %>' Visible="False"></asp:Label>
				    </td>
				</tr>
				<tr>
					<td class="rcell">
						תאריך הטופס
					</td>
					<td class="lcell" colspan="3">
                                    <asp:Label ID="CustEventRegDate" runat="server" 
                                        Text='<%# Bind("CustEventRegDate", "{0:g}") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						שם הלקוח/הנפגע
					</td>
					<td class="lcell">
						<asp:Label ID="LBCUSTOMER" runat="server" Text='<%# Eval("CustomerName") %>'></asp:Label>
					</td>
					<td class="lcell" style="text-align:left;">
						ת.ז.
					</td>
					<td class="lcell">
                        <asp:Label ID="LBCustomerID" runat="server" Text='<%# Bind("CustomerID") %>' Visible="true"></asp:Label>
 					</td>
				</tr>
				<tr>
					<td class="rcell">
						שם הדוח
					</td>
					<td class="lcell" colspan="3">
                       <asp:Label ID="LBLHDR" runat="server" Text='<%# Eval("ExEventHeader") %>' ></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						תאריך לידה
					</td>
					<td class="lcell" colspan="3">
                                    <asp:Label ID="LBBDATE" runat="server" 
                                        Text='<%# Eval("CustBirthDate", "{0:d}") %>' />
					</td>
				</tr>
				<tr>
					<td class="rcell">
						גיל
					</td>
					<td class="lcell" colspan="3">
                        <asp:Label ID="LBAGE" runat="server" onprerender="LBAGE_PreRender"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						תאריך ושעת הארוע
					</td>
  					<td class="lcell" colspan="3">
                        <asp:Label ID="LBLEXDATE" runat="server" 
                                        Text='<%# Bind("CustEventDate", "{0:g}") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						סיווג הארוע
					</td>
					<td class="lcell" colspan="3">
                          <asp:HiddenField ID="HDNEVENTTYPE" runat="server" 
                                  Value='<%# Eval("ExEventTypeID") %>' />
                          <asp:Label ID="Label14" runat="server" Text='<%# Eval("lvl2") %>' Width="400px"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						חומרת הארוע
					</td>
					<td class="lcell" colspan="3">
                         <asp:HiddenField ID="HDNSEVERITYID" runat="server" 
                                        Value='<%# Eval("ExEventSeverityID") %>' />
                         <asp:Label ID="Label15" runat="server" Text='<%# Eval("Severity") %>' 
                                        ></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						מקום הארוע
					</td>
					<td class="lcell" colspan="3">
                        <asp:HiddenField ID="HDNLOCATIONID" runat="server" 
                                        Value='<%# Eval("ExEventLocationID") %>' />
                        <asp:Label ID="Label16" runat="server" Text='<%# Eval("EventLocation") %>' 
                                        ></asp:Label>
					</td>
				</tr>
				<tr style="background-color:#DDDDDD;">
					<td>
					</td>
					<td style="font-size:medium;padding:2px 2px 2px 2px;" colspan="3">
						תיאור מפורט
					</td>
				</tr>
				<tr>
					<td class="rcell">
						תאור מקום הארוע
					</td>
					<td class="lcell" colspan="3">
                          <asp:Label ID="LBLLOCDESC" runat="server" 
                                        Text='<%# Eval("ExEventLocationDescrption") %>'></asp:Label>
 					</td>
				</tr>
				<tr>
					<td class="rcell">
						איש הצוות הראשון לדעת על הארוע (שם ותפקיד)
					</td>
					<td class="lcell" colspan="3">
                        <asp:Label ID="LBLFIRST" runat="server" Text='<%# Eval("ExEventReporterJob") %>' ></asp:Label>
  					</td>
				</tr>
				<tr>
					<td class="rcell">
						נזקי גוף
					</td>
					<td class="lcell" colspan="3">
                        <asp:Label ID="LBLBODYINJURY" runat="server" Text='<%# Eval("ExEventBodyInjury") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						נזקי רכוש
					</td>
					<td class="lcell" colspan="3">
						 <asp:Label ID="LBLPROPERTYDAMAGE" runat="server" Text='<%# Eval("ExEventpropertyDamages") %>' ></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						תאור מפורט של הארוע (שמות לקוחות ואנשי צוות העדים לארוע, מצבו הנפשי/פיזי של הלקוח לפני הארוע, השתלשלות הארוע, תוצאות הארוע)
					</td>
					<td class="lcell" colspan="3">
                        <asp:Label ID="LBLSTORY" runat="server" Text='<%# Eval("ExEventStory") %>' ></asp:Label>
					</td>
				</tr>
				<tr style="background-color:#DDDDDD;">
					<td></td>
					<td style="font-size:medium;padding:2px 2px 2px 2px;" colspan="3">ניהול הארוע</td>
				</tr>
				<tr>
					<td class="rcell">
						פעולות מידיות שננקטו
					</td>
					<td class="lcell" colspan="3">
                         <asp:Label ID="LBLIMMEDIAT" runat="server" 
                                        Text='<%# Eval("ExEventimmediateActions") %>'></asp:Label>
  					</td>
				</tr>
				<tr>
					<td class="rcell">
						פעולות לביצוע בהמשך
					</td>
					<td class="lcell" colspan="3">
                         <asp:Label ID="LBLREQUIRED" runat="server" 
                                        Text='<%# Eval("ExEventRequiredActions") %>'></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						למי דווח
					</td>
					<td class="lcell" colspan="3">
						<asp:Label runat="server" ID="lblReported" OnPreRender="lblReported_PreRender" />
						<div style="display:none;">
							<asp:CheckBoxList ID="CBReportedTo" runat="server" DataSourceID="DSREPORTED" DataTextField="Reported" Height="1" Width="1"
                                        DataValueField="RepID" RepeatDirection="Horizontal" Font-Size="X-Small" 
                                        RepeatColumns="4" onprerender="CBReportedTo_PreRender" 
                                        onselectedindexchanged="CBReportedTo_SelectedIndexChanged" Enabled="False">
							</asp:CheckBoxList>
						</div>
					</td>
				</tr>
				<tr>
					<td class="rcell">
						סטטוס
					</td>
					<td runat="server" id="tdststus" class="lcell" colspan="3">
                        <asp:Label ID="Label24" runat="server" Text='<%# Eval("ShortSatatus") %>' 
                            Visible='<%# Eval("ExEventStatusID")=3 %>' ></asp:Label>
                        <asp:Label ID="Label25" runat="server" 
                            Text='<%# Eval("ExEventAsClosingDate", "{0:g}") %>' 
                            Visible='<%# Eval("ExEventStatusID")=3 or bPrint %>' ></asp:Label>
                        <asp:DropDownList ID="DDLSTATUS" runat="server" 
                                        SelectedValue='<%# Bind("ExEventStatusID") %>' DataSourceID="DSSTATUS" 
                                        DataTextField="Status" DataValueField="StatusID" 
                                        Visible='<%# Eval("ExEventStatusID")<>3 and not bprint %>'>
                        </asp:DropDownList>                                     
					</td>
				</tr>
				<tr runat="server" id="tdlast">
                    <td class="rcell">
                                    <asp:LinkButton ID="LNKBINSERT" runat="server" OnClick="LNKBINSERT_Click" 
                                        ToolTip="לחץ לכתיבת הארוע לבסיס הנתונים" 
                                        Visible='<%# Eval("ExEventStatusID")<>3 and not bprint %>'>שליחה למערכת</asp:LinkButton>
					</td>
                    <td class="lcell" colspan="3">
                                    <asp:LinkButton ID="LinkButton2" runat="server" Visible='<%# not bprint %>' CommandName="Cancel" PostBackUrl="CustEventReport.aspx">חזרה</asp:LinkButton>
                    </td>
				</tr>
			</table>
        </ItemTemplate>
    </asp:FormView>
    </ContentTemplate></asp:UpdatePanel>
    <asp:Panel runat="server" ID="PANELPRINT" >
        <input id="PRINT" type="button" value="הדפסה" onclick="DoPrint()" visible="false" />
        <input id="CLOSE" type="button" value="חזרה"  onclick="history.back()" visible="false" />
    </asp:Panel>
    <asp:Button ID="PREPRINT" runat="server" Text="הכנה להדפסה" Visible='<%# not bprint %>' />
    <asp:SqlDataSource ID="DSSUBTYPE" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [lvl2], [ID] FROM [p0v_EXEventType]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSLOCATION" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [EventLocation], [ID] FROM [ExEventLocation]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSREPORTED" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [Reported], [RepID] FROM [ExEventReportedTo]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSEVERITY" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [Severity], [SeverityID] FROM [ExSeverity]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSTATUS" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [Status], [StatusID] FROM [ExEventStatus]"></asp:SqlDataSource>
</div>
<div runat="server" id="divbuttons">
	<table style="text-align:center;">
		<tr>
			<td>
				<asp:ImageButton runat="server" ID="btnWord" CausesValidation="false" 
					Width="35px" Height="35px"  ImageUrl="~/images/Microsoft-Word-icon.png" />
			</td>
		</tr>
	</table>							
	<asp:AlwaysVisibleControlExtender runat="server" TargetControlID="divbuttons" HorizontalOffset="650" VerticalOffset="3" HorizontalSide="Right">
			</asp:AlwaysVisibleControlExtender>
</div>
</asp:Content>

