<%@ Page Title="דוח ארועים חריגים" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="WEXReports.aspx.vb" Inherits="WEX_Reports" %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<%@ Register TagPrefix="topyca" TagName="NTreeDropDown" Src="~/Controls/NTreeDropDown.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <style type="text/css">
    .h1 
    {
        font-size:xx-large;
        font-weight:bolder; 
        width:600px;
        padding-right:10px;
    } 
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
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
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
        width:104px;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
</style>
<script src="jquery-1.7.1.js" type="text/javascript"></script>
<script  type="text/javascript">
    function fout(t) {
        if (t.value=='-') {
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
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח ארועים חריגים" />
<asp:Button runat="server" Height="0" ID="stam" style="background-color:#C0C0C0;border:0px solid #C0C0C0;" />
<div style="vertical-align:middle;width:100%">
    <p><input type="button" onclick="fout(this);" value="-" 
            style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
    <table class="tbld" id="tbldef">
        <tr style="height:20px;">
            <td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">סוג דוח</td>
            <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
                <asp:RadioButton runat="server" ID="rbWexReports" Text="רשימה" GroupName="rept" AutoPostBack="true"  Checked="true" />
                <asp:RadioButton runat="server" ID="rbExReport" Text="ניתוח" GroupName="rept" AutoPostBack="true" />
           </td>
        </tr>
        <tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
        <tr>
            <td>
                העמודות בדוח
            </td>
            <td colspan="3">&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="ddlColumns" DataTextField="nam" DataValueField="val" >
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                טווח תאריכים: מתאריך
            </td>
            <td>
                <topyca:TBDate runat="server" ID="tbFromdate" DateFormat="dd/MM/yyyy" InitDate='<%#New DateTime(DatePart(DateInterval.Year, Today()),1,1) %>' />
            </td>
            <td>
                עד תאריך
            </td>
            <td>
                    <topyca:TBDate runat="server" ID="tbToDate" DateFormat="dd/MM/yyyy" InitDate='<%#Today() %>'  />
            </td>
        </tr>
		<tr class="blockfooter">
			<td class="tdr">סוג שירות</td>
			<td>&nbsp;&nbsp;
				<asp:DropDownList runat="server" ID="ddlServiceTypes" DataSourceID="DSServiceTypes" DataTextField="Name" DataValueField="ID" AppendDataBoundItems="true" AutoPostBack ="true" Enabled='<%# Session("MultiFrame") = 1 %>' >
					<asp:ListItem Value="">כל סוגי השירות</asp:ListItem>
				</asp:DropDownList>
				</td>
			<td class="tdr">לקות</td>
			<td>&nbsp;&nbsp;
				<asp:DropDownList runat="server" ID="ddlLakuyot" DataSourceID="DSLakut" DataTextField="Lakut" DataValueField="LakutID" AppendDataBoundItems="true" EnableViewState="false" AutoPostBack="true"  Enabled='<%# Session("MultiFrame") = 1 %>'>
					<asp:ListItem Value="">כל הלקויות</asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr class="blockfooter">
			<td class="tdr">יחידה ארגונית</td>
			<td>&nbsp;&nbsp;
				<asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" EnableViewState="false" >
					<asp:ListItem Value="">כל האזורים</asp:ListItem>
				</asp:DropDownList>
				</td>
			<td class="tdr">מסגרת</td>
			<td>&nbsp;&nbsp;
				<asp:DropDownList runat="server" ID="ddlFrames" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="true" EnableViewState="false" >
					<asp:ListItem Value="">כל המסגרות</asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
         <tr>
            <td>סטטוס</td>
            <td>&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem Value="0">הכל</asp:ListItem>
                    <asp:ListItem Value="1">בהכנה</asp:ListItem>
                    <asp:ListItem Value="2">פתוח</asp:ListItem>
                    <asp:ListItem Value="3">סגור</asp:ListItem>
               </asp:DropDownList>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
                סיווג ראשי
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
       <tr>
       <td>
            איתור לקוח 
       </td>
            <td colspan="2">&nbsp;&nbsp;
                <asp:TextBox runat="server" ID="tbSearch" CssClass="tbw" Width="157" />&nbsp;
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
<div style="min-width:800px;border:1px solid Silver;">
    <asp:Label runat="server" ID="lblhdr" />
       <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
        CellPadding="4" ShowFooter="True">
        <RowStyle Width="400px" Wrap="False" />
        <FooterStyle BackColor="gray" />
        <EmptyDataRowStyle Font-Size="x-Large" />
    </asp:GridView>

</div>
   <asp:SqlDataSource ID="DSServiceTypes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT  [ID],[Name] FROM p5t_ServiceTypes_H">
    </asp:SqlDataSource>
   <asp:SqlDataSource ID="DSLakut" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT  [LakutID],[Lakut] FROM p5t_Lakut">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSET2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT  [ID],[EventType] FROM [ExEventType] WHERE [Parent]=@Parent ORDER BY ORD">
        <SelectParameters>
            <asp:ControlParameter Name="Parent" ControlID="DDLET1" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSET1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT  [ID],[EventType] FROM [ExEventType] WHERE [Parent]=1 ORDER BY ORD">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
		SelectCommand="SELECT ServiceName, ServiceID 
FROM dbo.ServiceList 
WHERE ((1 = CASE WHEN EXISTS (SELECT * FROM p0v_Ntb WHERE ServiceID IS NOT NULL AND (UserID = @UserID)) THEN 0 ELSE 1 END) 
		OR (ServiceID IN (SELECT DISTINCT ServiceID FROM dbo.p0v_Ntb WHERE (UserID = @UserID)))) 
		AND (ServiceID IN (SELECT ServiceID FROM FrameList f WHERE (ServiceTypeID IN (SELECT ServiceTypeID FROM p5t_ServiceType p WHERE (p.ServiceTypeHID = ISNULL(@ServiceTypeHID, p.ServiceTypeHID))))))
		AND (ServiceID IN (SELECT ServiceID FROM FrameList f WHERE (LakutID = ISNULL(@LakutID,LakutID))))" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="int32" />
			<asp:ControlParameter ControlID="ddlServiceTypes" Name="ServiceTypeHID" 
				PropertyName="SelectedValue" Type="int32" />
        	<asp:ControlParameter ControlID="ddlLakuyot" Name="LakutID" 
				PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
            
        SelectCommand="SELECT FrameName, FrameID 
FROM FrameList
WHERE (ServiceID = @ServiceID) 
	   AND FrameID in (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE (UserID = @UserID))
	   AND ServiceTypeID IN (SELECT ServiceTypeID
							FROM p5t_ServiceType
							WHERE ServiceTypeHID = ISNULL(@ServiceTypeHID,ServiceTypeHID))
	  AND LakutID = ISNULL(@LakutID,LakutID)" CancelSelectOnNullParameter="False" 
		EnableViewState="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlServices" Name="ServiceID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        	<asp:ControlParameter ControlID="ddlServiceTypes" Name="ServiceTypeHID" 
				PropertyName="SelectedValue" />
			<asp:ControlParameter ControlID="ddlLakuyot" Name="LakutID" 
				PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
  </div>

</asp:Content>

