<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="p5aFormAVG.aspx.vb" Inherits="Default6" %>
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
    .tao td
    {
        border:1px dotted #666666;
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
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח שאלונים" ButtonJava="" />
    <div>
    &nbsp;<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="DSServices" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            SelectCommand="SELECT ServiceList.ServiceName, ServiceList.ServiceID FROM FrameList LEFT OUTER JOIN dbo.p0v_UserFrameList ON FrameList.FrameID = dbo.p0v_UserFrameList.FrameID RIGHT OUTER JOIN ServiceList ON FrameList.ServiceID = ServiceList.ServiceID WHERE (dbo.p0v_UserFrameList.UserID = isnull(@UserID,dbo.p0v_UserFrameList.UserID)) GROUP BY ServiceList.ServiceName, ServiceList.ServiceID ORDER BY ServiceList.ServiceID">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSFrames" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            
            SelectCommand="SELECT FrameList.FrameName, FrameList.FrameID, dbo.p0v_UserFrameList.UserID, FrameList.ServiceID FROM FrameList LEFT OUTER JOIN dbo.p0v_UserFrameList ON FrameList.FrameID = dbo.p0v_UserFrameList.FrameID WHERE (dbo.p0v_UserFrameList.UserID = @UserID) AND (FrameList.ServiceID = @ServiceID)">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSLAKUT" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT [Lakut], [LakutID] FROM [p5t_Lakut]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSServiceType" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT [ServiceType], [ServiceTypeID] FROM [p5t_ServiceType]">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSFormTypes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT [FormName], [FormID] FROM [p5t_FormTypes]">
        </asp:SqlDataSource>
    <asp:SqlDataSource ID="dslq" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT grp, AVG(perc) AS perc, FormTypeID FROM p5v_FormResults WHERE (UserID = @UserID) GROUP BY grp, ord,FormTypeID HAVING (FormTypeID = 1) order by ord">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSREP" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="p5p_FormsAvg" SelectCommandType="StoredProcedure" 
            CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="rbltype" Name="RepType" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DDLFrames" Name="FrameID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
                <asp:ControlParameter ControlID="DDLFORMS" Name="FormTypeID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DDLLAKUT" Name="LakutID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="DDLSERVICETYPES" Name="ServiceTypeID" 
                    PropertyName="SelectedValue" Type="Int32" />
            	<asp:ControlParameter ControlID="CBPY" Name="PY" PropertyName="Checked" 
					Type="Int32" />
				<asp:ControlParameter ControlID="hdnRound" Name="Rnd" PropertyName="Value" />
            </SelectParameters>
        </asp:SqlDataSource>
<div style="vertical-align:middle;width:100%">
    <p><input type="button" onclick="fout(this);" value="-" 
            style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
    <table class="tbld" id="tbldef">
             <tr class="blockfooter">
                <td class="tdr" style="width:15%"><asp:label runat="server" ID="lblServices" Text="איזור" /></td>
                <td style="width:25%">&nbsp;&nbsp;
                    <asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" >
                        <asp:ListItem Value="">כל האזורים</asp:ListItem>
                    </asp:DropDownList>
                 </td>
                <td class="tdr" style="width:15%"><asp:label runat="server" ID="lblFrames" Tetx="מסגרת" /></td>
                <td style="width:45%">&nbsp;&nbsp;
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
					<asp:DropDownList ID="DDLFORMS" runat="server" Font-Size="Small" AppendDataBoundItems="True" EnableViewState="False" Width="159px" DataSourceID="DSFormTypes" DataTextField="FormName" DataValueField="FormID">
						<asp:ListItem Text="בחר סוג פעולה" Value=""></asp:ListItem>
					</asp:DropDownList>
				</td>
            <td>
				<asp:Label runat="server" ID="lblREPType" Text="סוג דוח" />
            </td>
            <td>&nbsp;&nbsp;
               <asp:DropDownList  runat="server" ID="rbltype" 
                    DataSourceID="DSREPTYPEAS" DataTextField="RepName" 
                    DataValueField="RepID">
                </asp:DropDownList>
             </td>
        </tr>
		<tr>
				<td>
					<asp:Label runat="server" ID="lblLAKUT" Text="סוג לקות" />
				</td>
				<td>&nbsp;&nbsp;         
               <asp:DropDownList ID="DDLLAKUT" runat="server" DataSourceID="DSLAKUT" AppendDataBoundItems="true"
                    DataTextField="Lakut" DataValueField="LakutID">
                        <asp:ListItem Text="כל הלקויות" Value="" />
                </asp:DropDownList>
			</td>
            <td>
              <asp:Label runat="server" ID="lblSerivicetype" Text="סוג שירות" />
            </td>
            <td>&nbsp;&nbsp;
                <asp:DropDownList ID="DDLSERVICETYPES" runat="server" AppendDataBoundItems="true"
                    DataSourceID="DSServiceType" DataTextField="ServiceType" 
                    DataValueField="ServiceTypeID">
                        <asp:ListItem Text="כל סוגי השירות" Value="" />
                </asp:DropDownList>
             </td>
        </tr>
       <tr>
       <td>
<%--            איתור לקוח 
--%>       </td>
            <td colspan="2">&nbsp;&nbsp;
 <%--               <asp:TextBox runat="server" ID="tbSearch" CssClass="tbw" Width="157" />&nbsp;
--%>            </td>
            <td></td>
        </tr>
		<tr>
				<td>
					כולל שנים קודמות
				</td>
				<td>&nbsp;&nbsp;         
                	<asp:CheckBox ID="CBPY" runat="server" />
			</td>
            <td>
             <asp:Label runat="server" ID="lblNONFORMFRAMES" Text="מסגרות ללא שאלונים תקפים" />
            </td>
			<td>&nbsp;&nbsp;
         	<asp:CheckBox ID="CBNF" runat="server"  />
            </td>
        </tr>
        <tr>
            <td colspan="4" style="text-align:center;">
                <asp:Button runat="server" ID="btnshow" Text="הפקת דוח" Height="22" />&nbsp;
				<asp:Button ID="Button1" runat="server" Text="הצגת גרף" Height="22"/>&nbsp;
				<asp:Button ID="Button2" runat="server" Text="?"  Height="22"/>&nbsp;              
				<asp:Button ID="btnExcel" runat="server" Text="XL" Height="22px" Width="45px" Visible="false" />
            </td>
        </tr>
    </table>
    </div>
<hr />
</div>
<div style="min-width:800px;border:1px solid Silver;">
    <asp:Label runat="server" ID="lblhdr" />
 </div>
 <div runat="server" id="Help" visible="false">
		<p>
		הדוח מציג שאלונים תקפים לתאריך.&nbsp; ניתן להציג גם את רשימת המסגרות שאין להן אף דוח&nbsp; 
			תקף, נכון ליום הפקת הדוח.</p>
        <p style="text-decoration: underline">
    
            <b>הצגת דוח</b></p>
        <p>
    
            בחר את&nbsp; מאפייני הדוח: </p>
		<p>
    
            א. סוג טופס, איזור, מסגרת, לקות וסוג שירות. </p>
		<p>
    
            ב. האם להציג נתוני שנים קודמות.</p>
		<p>
    
            ג. האם להציג רשימת מסגרות שאין להן שאלונים תקפים.</p>
		<p>
    
            ד. לחץ על 
            הכפתור &quot;הצג דוח&quot;</p>
        <p style="text-decoration: underline">
    
            <b>הצגת גרף</b></p>
        <p>
    
            הכן דוח על פי צרכיך כמתואר בסעיף &quot;הצגת דוח&quot; לעיל.</p>
        <p>
    
            סמן את השורות שאתה רוצה שיופיעו בגרף על ידי סימון בתיבת הסימון המוצגת בתחילת כל 
            שורה</p>
        <p>
    
            לחץ על הכפתור &quot;הצג גרף&quot;.&nbsp; צבע העמודה בגרף הוא כצבע הרקע של תיבת 
            הסימון בשורה.</p>
        <p style="text-decoration: underline">
    
            &nbsp;</p>
    </div>
        <div>
    
                 <asp:Chart ID="ChrtG" runat="server" Visible="False" Width="700px" Height="200" 
                     RightToLeft="Yes"> 
                   <Series> 
                   </Series> 
                    <ChartAreas> 
                      <asp:ChartArea Name="MainChartArea"> 
                     
                      </asp:ChartArea> 
                   </ChartAreas> 
                </asp:Chart> 
    
        <asp:SqlDataSource ID="DSREPTYPEAS" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT RepName, RepID FROM p5t_repTypes WHERE (RepGroup = 1)">
        </asp:SqlDataSource>
    
        <asp:GridView ID="GridView1" runat="server" 
            CellPadding="4" AutoGenerateColumns="False">
            <Columns>
            </Columns>
       </asp:GridView>
        <br />
        </div>
        <div>
			
        <br />
    
    		<asp:SqlDataSource ID="DSNOFORMS" runat="server" 
				ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
				
				
				SelectCommand="SELECT ServiceList.ServiceID, ServiceList.ServiceName, FrameList.FrameID, FrameList.FrameName FROM FrameList RIGHT OUTER JOIN ServiceList ON FrameList.ServiceID = ServiceList.ServiceID LEFT OUTER JOIN dbo.p0v_UserFrameList AS u ON u.FrameID = FrameList.FrameID WHERE (@CBNF = 1) AND (ServiceList.ServiceID = ISNULL(@ServiceID, ServiceList.ServiceID)) AND (FrameList.FrameID = ISNULL(@FrameID, FrameList.FrameID)) AND (ISNULL(FrameList.LakutID, 0) = ISNULL(@LakutID, ISNULL(FrameList.LakutID, 0))) AND (ISNULL(FrameList.ServiceTypeID, 0) = ISNULL(@ServiceTypeID, ISNULL(FrameList.ServiceTypeID, 0))) AND (FrameList.FrameID NOT IN (SELECT DISTINCT isnull(FrameID,0) FROM p5v_FormResults AS f WHERE (FormTypeID = @FormTypeID) AND (EventFinaldate &gt;= GETDATE()))) AND (ServiceList.ServiceID NOT IN (5, 11, 8)) AND (u.UserID = @UserID) ORDER BY FrameList.ServiceID, FrameList.FrameName" 
				CancelSelectOnNullParameter="False">
				<SelectParameters>
					<asp:ControlParameter ControlID="CBNF" Name="CBNF" PropertyName="Checked" />
					<asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="DDLFrames" Name="FrameID" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="DDLLAKUT" Name="LakutID" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="DDLSERVICETYPES" Name="ServiceTypeID" 
						PropertyName="SelectedValue" />
					<asp:ControlParameter ControlID="DDLFORMS" Name="FormTypeID" 
						PropertyName="SelectedValue" />
					<asp:SessionParameter Name="UserID" SessionField="userID" />
				</SelectParameters>
			</asp:SqlDataSource>
                 <asp:Label ID="lblhdr2" runat="server" Font-Bold="True" Font-size="Large" 
                    ForeColor="Blue" Text="מסגרות ללא שאלונים תקפים" Width="261px" 
				Visible="False" />
    		<br />
			<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
				DataSourceID="DSNOFORMS" Visible="False">
				<Columns>
					<asp:BoundField DataField="ServiceName" HeaderText="איזור" 
						SortExpression="ServiceName" />
					<asp:BoundField DataField="FrameName" HeaderText="מסגרת" 
						SortExpression="FrameName" />
				</Columns>
			</asp:GridView>
			<asp:HiddenField runat="server" ID="hdnRound" />
    </div>
</div>

</asp:Content>

