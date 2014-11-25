<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CEventExpiration.aspx.vb" Inherits="CEE" title="בית אקשטיין - דוח תוקף פעולות" %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
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
        border:2px groove Gray;
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
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח תוקף פעולות" ButtonJava="" />
<asp:Button runat="server" Height="0" ID="stam" style="background-color:#C0C0C0;border:0px solid #C0C0C0;" />

<div style="vertical-align:middle;width:100%">
    <p><input type="button" onclick="fout(this);" value="-" 
            style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
    <table class="tbld" id="tbldef">
             <tr class="blockfooter">
                <td class="tdr">איזור</td>
                <td>&nbsp;&nbsp;
                    <asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" >
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
				<td>
					סוג פעולה
				</td>
				<td>&nbsp;&nbsp;         
					<asp:DropDownList ID="DDLEVENTTYPE" runat="server" Font-Size="Small" AppendDataBoundItems="True" EnableViewState="False" Width="159px" DataSourceID="DSEVENTTYPES" DataTextField="CustEventTypeName" DataValueField="CustEventTypeID">
						<asp:ListItem Text="בחר סוג פעולה" Value=""></asp:ListItem>
					</asp:DropDownList>
				</td>
            <td>
                סינון לקוחות
            </td>
            <td>&nbsp;&nbsp;
               <asp:DropDownList ID="DDLLISTTYPE" runat="server"  >
                    <asp:ListItem Value="0" >הצג את כל השורות עם סוג הפעולה שנבחר</asp:ListItem>
                    <asp:ListItem Value="1">הצג את כל הלקוחות שלא נרשם להם סוג הפעולה שנבחר</asp:ListItem>
                    <asp:ListItem Value="2">הצג לכל לקוח את הפעולה האחרונה מסוג הפעולה שנבחר</asp:ListItem>
                    <asp:ListItem Value="3">הצג את הלקוחות שעבורם פקע תוקף הפעולה מסוג הפעולה שנבחר</asp:ListItem>
                    <asp:ListItem Value="4" Selected="True">הצג את הלקוחות שעבורם יפקע תוקף הפעולה בחודש הקרוב</asp:ListItem>
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
                    ID="btnExcel" runat="server" Text="XL" Height="22px" Width="45px" Visible="false" />
            </td>
        </tr>
    </table>
    </div>
<hr />
<div style="min-width:800px;border:1px solid Silver;">
    <asp:Label runat="server" ID="lblhdr" />
    <asp:GridView ID="GVList" runat="server" AllowSorting="True"
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="CustEventID"
        Font-Size="Small" ForeColor="#333333" PageSize="13" EnableViewState="False" DataSourceID="DSEVENTS">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="ת.ז." SortExpression="CustomerID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("CustomerID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
<%--					<asp:Label runat="server" ID="lblID" Text='<%# Eval("CustomerID") %>' />
--%>                    <asp:Button ID="LNKBID" runat="server" PostBackUrl='<%# "CustEventReport.Aspx?C=" & Eval("CustomerID")  %>'
                        Text='<%# Eval("CustomerID") %>' Height="17px" ToolTip="לחץ כדי לעבור לניהול תיקי לקוחות עבור לקוח זה" Width="80px" Font-Size="X-Small"></asp:Button>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="Name" HeaderText="שם" SortExpression="Name" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="סוג פעולה" SortExpression="CustEventTypeName">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" 
                        NavigateUrl='<%# Eval("CustEventurl") %>' 
                        Text='<%# Eval("CustEventTypeName") %>'></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CustEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת פעולה"
                HtmlEncode="False" SortExpression="custEventDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
           <asp:TemplateField HeaderText="תקף עד" SortExpression="CustEventDate">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("CustFinalDate") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblexp" runat="server" onprerender="lblexp_PreRender" 
                        Text='<%# Bind("CustFinalDate", "{0:dd/MM/yy}") %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
<%--            <asp:TemplateField HeaderText="הערה" SortExpression="CustEventComment">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventComment") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                     <asp:Button ID="btnSA" runat="server" Height="16px" onclick="btnSA_Click" 
                        Text="..." Width="16px" />
                   <asp:Label ID="LBComment" runat="server" Text='<%# Truncfield("CustEventComment",25) %>'
                        ToolTip='<%# Eval("CustEventComment") & "" %>' Width="160px"></asp:Label>
                    <asp:TextBox ID="TBSA" runat="server" Height="75px" ReadOnly="True" 
                        Text='<%# Eval("CustEventComment") %>' TextMode="MultiLine" Visible="False"></asp:TextBox>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
--%>            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
                SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
             <asp:BoundField DataField="CustEventRegDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת רישום"
                HtmlEncode="False" SortExpression="CustEventRegDate" >
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CReporterUserName" HeaderText="על ידי" 
                SortExpression="CReporterUserName" >
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
    <asp:SqlDataSource ID="DSEvents" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        SelectCommand="p2p_CustEventExpiration"
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="CustFrameID" PropertyName="SelectedValue" Type="Int32" DefaultValue=""  />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" Type="Int32" DefaultValue=""  />
            <asp:ControlParameter ControlID="DDLEVENTTYPE" Name="EventTypeID" PropertyName="SelectedValue"  Type="Int32" />
            <asp:ControlParameter ControlID="tbSearch" Name="CustomerName" PropertyName="Text" DefaultValue=" " />
            <asp:Parameter Name="EventDate" DefaultValue='2020-12-31' Type="DateTime" />
            <asp:ControlParameter ControlID="DDLLISTTYPE" Name="ListType" PropertyName="SelectedValue"  DefaultValue="0" Type="Int32" />
        	<asp:Parameter Name="Block" Type="String" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
            
            
        
		SelectCommand="SELECT ServiceName, ServiceID FROM dbo.ServiceList WHERE (1 = CASE WHEN EXISTS (SELECT * FROM p0v_Ntb WHERE ServiceID IS NOT NULL AND (UserID = @UserID)) THEN 0 ELSE 1 END) AND (ServiceID IN (SELECT DISTINCT ServiceID FROM dbo.FrameList WHERE (FrameID IN (SELECT DISTINCT FrameID FROM dbo.EE_FrameUserList)))) OR (ServiceID IN (SELECT DISTINCT ServiceID FROM dbo.p0v_Ntb WHERE (UserID = @UserID))) AND (ServiceID IN (SELECT DISTINCT ServiceID FROM dbo.FrameList AS FrameList_1 WHERE (FrameID IN (SELECT DISTINCT FrameID FROM dbo.EE_FrameUserList AS EE_FrameUserList_1))))">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
            
        
		SelectCommand="SELECT FrameName, FrameID 
FROM FrameList 
WHERE (ServiceID = @ServiceID) 
	AND FrameID in (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE (UserID = @UserID)) 
	AND (FrameID in (Select DISTINCT FrameID FROM EE_FrameUserList))">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlServices" Name="ServiceID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEVENTTYPES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT distinct CustEventTypeName, CustEventTypeID FROM dbo.p0v_EventServiceList WHERE (CustEventServiceID = ISNULL(@CustEventServiceID, CustEventServiceID)) AND (CustEventServiceID = ISNULL(@ServiceID, CustEventServiceID)) AND (ISNULL(CustEventDays, 0) + ISNULL(CustEventMonths, 0) + ISNULL(CustEventYears, 0) &gt; 0)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="CustEventServiceID" SessionField="ServiceID" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="ServiceID" PropertyName="SelectedValue" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
	</div>
</div>
</asp:Content>
