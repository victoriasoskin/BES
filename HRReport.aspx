<%@ Page Title="דוח הערכת עובדים" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="HRReport.aspx.vb" Inherits="HRReport" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
     .p 
    {
        width:200px;
        padding-right:10px;
    }
    .pg
    {
        position:absolute;
        background-color:#C0C0C0;
        width:800px;
        border-style:outset;
    } 
    .blockHeader
    {
        font-size:medium;
        color:ButtonText;
        font-weight:bolder;
        height:25px;   
        padding-right:10px;     
    }
    .blockfooter
    {
        padding-right:10px;        
    }
    .tbw
    {
        background-color: #ececec;
        font-family: verdana;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        font-family: verdana;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        font-family: verdana;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
        font-family: verdana;
        width:125px;
        border-style:groove;
    }
    .tdr
    {
        padding-right:10px;
        padding-top:5px;
    }
    .tbl
    {
        padding:10px;
        width:100%;
    }
    th
    {
        background-color:#AAAAAA;
        border-bottom:1px solid black;
    }
    .tbld
    {
        width:100%;
    }
    .tbld td
    {
        padding-right:10px;
    }
    .tdid
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
        width:20px;
    }
    .tdq
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
    }
    .tda
    {
        border-bottom:1px outset #AAAAAA;
        width:300px;
    }
    .shf
    {
        background-color: #eaeaea;
        font-family: verdana;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
 </style>
<script src="jquery-1.7.1.js" type="text/javascript"></script>
<script  type="text/javascript">
    function fout(t) {
        if (t.value == '-') {
            $('#tbldef').fadeOut('slow');
            t.value = '+';
        }
        else {
            $('#tbldef').fadeIn('slow');
            t.value = '-';
        }
    }
 </script>
<div runat="server" id="divform" class="pg">
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח הערכת עובדים" ButtonJava="" />
<input type="hidden" id="scroll" />
<div style="vertical-align:middle;width:100%">
<p><input type="button" onclick="fout(this);" value="-" 
        style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
<table class="tbld" id="tbldef">
        <tr style="height:20px;">
            <td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">סוג דוח</td>
            <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
               <asp:RadioButtonList runat="server" ID="rbExReport" RepeatDirection="Horizontal" AutoPostBack="true">
				<asp:ListItem Value="1">לפי אזור</asp:ListItem>
				<asp:ListItem Value="2" Selected="True">לפי מסגרת</asp:ListItem>
				<asp:ListItem Value="3">לפי עובד</asp:ListItem>
			   </asp:RadioButtonList>
            </td>
        </tr>
         <tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
        <tr>
            <td style="width:120px;">
                טווח תאריכים: מתאריך
            </td>
            <td style="width:285px;">&nbsp;&nbsp;
                <asp:DropDownList ID="DDLFDATE" runat="server">
                </asp:DropDownList>
            </td>
            <td style="width:55px;">
                עד תאריך
            </td>
            <td>&nbsp;&nbsp;
                <asp:DropDownList ID="DDLTDATE" runat="server" >
                </asp:DropDownList>
            </td>
        </tr>
        <tr class="blockfooter">
           <td class="tdr">איזור</td>
           <td>&nbsp;&nbsp;
                <asp:DropDownList ID="DDLServices" runat="server" AppendDataBoundItems="True" 
                    AutoPostBack="True" DataSourceID="DSSERVICES" DataTextField="ServiceName" 
                    DataValueField="ServiceID">
                    <asp:ListItem Value="">כל האזורים</asp:ListItem>
                </asp:DropDownList>
            </td>
        <td class="tdr">מסגרת</td>
        <td>&nbsp;&nbsp;
                <asp:DropDownList ID="DDLFRAME" runat="server" AppendDataBoundItems="True" 
                    DataSourceID="DSFRAMES" DataTextField="FrameName" 
                    DataValueField="FrameID" EnableTheming="True" EnableViewState="False">
                    <asp:ListItem Value="">כל המסגרות</asp:ListItem>
                </asp:DropDownList>
        </td>
    </tr>
         <tr>
            <td>מראיין</td>
            <td>&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="ddlinterviewer" AppendDataBoundItems="true" DataSourceID="DSIntvr" DataTextField="EmployeeName" DataValueField="EmployeeID" Enabled="false" >
					<asp:ListItem Value="">כל המראיינים</asp:ListItem>
               </asp:DropDownList>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
<%--        <tr>
            <td>
                סוג שאלון
            </td>
            <td>&nbsp;&nbsp;
                      <asp:DropDownList runat="server" ID="ddlET1" CssClass="ddlw" DataSourceID="DSET1" DataTextField="EventType" DataValueField="ID" AppendDataBoundItems="true" Width="270" AutoPostBack="true"  >
                        <asp:ListItem Value="">כל הסיווגים</asp:ListItem>
                    </asp:DropDownList>
            </td>
            <td>
                סיווג משני
            </td>
            <td>&nbsp;&nbsp;
                     <asp:DropDownList runat="server" ID="ddlET2" CssClass="ddlw" DataSourceID="DSET2" DataTextField="EventType" DataValueField="ID" AppendDataBoundItems="true" Width="270"  >
                        <asp:ListItem Value="">כל הסיווגים</asp:ListItem>
                    </asp:DropDownList>
           </td>

        </tr>
--%>       <tr>
       <td>
            איתור עובד 
       </td>
            <td colspan="2">&nbsp;&nbsp;
                <asp:TextBox runat="server" ID="tbSearch" CssClass="tbw" Width="157" Enabled="false" />&nbsp;
            </td>
            <td></td>
        </tr>
        <tr>
            <td colspan="4" style="text-align:center;">
                <asp:Button runat="server" ID="btnSearch" Text="הפקה" Height="22" />&nbsp;<asp:Button 
                    ID="btnExcel" runat="server" Text="XL" Height="22px" Width="45px" />
       </td>
    </tr>
</table>
</div>
<hr />
<asp:Label ID="LBLSUMMARY" runat="server" Width="143px"></asp:Label>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT ServiceList.ServiceName, ServiceList.ServiceID FROM FrameList LEFT OUTER JOIN dbo.p0v_UserFrameList ON FrameList.FrameID = dbo.p0v_UserFrameList.FrameID RIGHT OUTER JOIN ServiceList ON FrameList.ServiceID = ServiceList.ServiceID WHERE (dbo.p0v_UserFrameList.UserID = CASE @UserID WHEN 59 THEN 48 ELSE @UserID END) GROUP BY ServiceList.ServiceName, ServiceList.ServiceID ORDER BY ServiceList.ServiceID" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSREPS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [RepName], [RepID] FROM [ExReplist]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSREPDATA" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="HR_pStatus" SelectCommandType="StoredProcedure"
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="rbExReport" Name="RepType" 
				PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDLFDATE" Name="FromDate" 
                PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="DDLTDATE" Name="ToDate" 
				PropertyName="SelectedValue" Type="DateTime" />
            <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDLFRAME" Name="FrameID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="ddlinterviewer" Name="InterviewerID" 
				PropertyName="SelectedValue" Type="Int32" />
			<asp:ControlParameter ControlID="tbSearch" Type="String" Name="Empn" 
				PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br /><asp:Label runat="server" ID="lblhdr" text="" />
    <asp:GridView ID="GridView1" runat="server"
        CellPadding="4" ShowFooter="false">
        <RowStyle Width="400px" Wrap="False" />
        <FooterStyle BackColor="gray" />
        <EmptyDataRowStyle Font-Size="x-Large" />
    </asp:GridView>
<%--    <asp:SqlDataSource ID="DSREPHEADER" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [RepHeader] FROM [ExReplist] WHERE ([RepID] = @RepID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="RBLREPTYPE" Name="RepID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
--%>    <asp:SqlDataSource ID="DSFRAMES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        SelectCommand="SELECT FrameList.FrameName, FrameList.FrameID, p0v_UserFrameList.UserID, FrameList.ServiceID FROM FrameList LEFT OUTER JOIN p0v_UserFrameList ON FrameList.FrameID = p0v_UserFrameList.FrameID WHERE (p0v_UserFrameList.UserID = CASE isnull(@UserID , dbo.p0v_UserFrameList.UserID) WHEN 59 THEN 48 ELSE @UserID END) AND (FrameList.ServiceID = @ServiceID)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSIntvr" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
        SelectCommand="SELECT EmployeeID,EmployeeName FROM dbo.tf_HR_EmpList() WHERE EmployeeID IN (SELECT ParentID FROM HR_Hierarchy UNION ALL SELECT EmployeeID FROM HR_SecondManager) ORDER BY EmployeeName">
     </asp:SqlDataSource>
</div>
</asp:Content>

