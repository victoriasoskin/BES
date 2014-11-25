<%@ Page Language="VB" MasterPageFile="~/Sherut.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="CustomerList.aspx.vb" EnableEventValidation="false" Inherits="Default2" title="בית אקשטיין - רשימת לקוחות" %>
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
<%-- <asp:ScriptManager runat="server" ID="scrpt" />
--%><div runat="server" id="divform" class="pg">
<%--<asp:UpdatePanel runat="server" ID="upd"><ContentTemplate>
--%><asp:Label runat="server" ID="lblhdr" />
<topyca:PageHeader runat="server" ID="PageHeader1" Header="רשימת לקוחות" />
<asp:Button runat="server" Height="0" ID="stam" style="background-color:#C0C0C0;border:0px solid #C0C0C0;" />
<div style="vertical-align:middle;width:100%">
    <p><input type="button" onclick="fout(this);" value="-" 
            style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
    <table class="tbld" id="tbldef">
        <tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
              <tr class="blockfooter">
                <td class="tdr">איזור</td>
                <td>&nbsp;&nbsp;
                    <asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" >
                        <asp:ListItem Value="">בחר איזור</asp:ListItem>
                    </asp:DropDownList>
                 </td>
                <td class="tdr">מסגרת</td>
                <td>&nbsp;&nbsp;
                   <asp:DropDownList runat="server" ID="ddlFrames" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="true" EnableViewState="false" >
                        <asp:ListItem Value="">בחר מסגרת</asp:ListItem>
                    </asp:DropDownList>
                 </td>
            </tr>
         <tr style="height:20px;">
            <td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">סוג דוח</td>
            <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
				<asp:RadioButtonList runat="server" ID="rblList" RepeatDirection="Vertical" 
					style="white-space:nowrap;" Width="380px">
								<asp:ListItem Value="0" Selected="True">הצג את לקוחות המסגרת ואת המסגרות הנוספות שהם שייכים אליהן</asp:ListItem>
								<asp:ListItem Value="1">הצג את לקוחות המסגרת בלבד</asp:ListItem>
								<asp:ListItem Value="2">הצג את הלקוחות שעזבו את המסגרת ואת המועמדים</asp:ListItem>
				</asp:RadioButtonList>
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
		<tr>
                        <td style="width: 100px; height: 18px" valign="bottom" colspan="4">
                            <asp:DataList ID="DataList1" runat="server" DataSourceID="DSTOTCNT">
                                <ItemTemplate>
                                    <asp:Label ID="Column1Label" runat="server" Text='<%# "ברשימה " & Eval("CNT") & " לקוחות." %>' width="250"></asp:Label>
                                </ItemTemplate>
                            </asp:DataList></td>
		</tr>

    </table>
    </div>
<hr />
<div style="min-width:800px;border:1px solid Silver;">
    <asp:GridView ID="GVCustomersList" runat="server" AllowSorting="True" OnPreRender="GVCustomersList_PreRender" 
        AutoGenerateColumns="False" CellPadding="4" DataSourceID="DSCustomers" 
                    ForeColor="#333333" DataKeyNames="CustomerID" PageSize="14">
        <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <Columns>
             <asp:HyperLinkField DataNavigateUrlFields="RowID" DataNavigateUrlFormatString="CustomerUpd2.ASPX?RowID={0}"
                Text="עריכה" />
            <asp:HyperLinkField DataNavigateUrlFields="RowID" DataNavigateUrlFormatString="CustStatus.ASPX?RowID={0}"
                Text="פרטים" />
            <asp:TemplateField HeaderText="ת.ז." SortExpression="CustomerID">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustomerID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="LNKBID" runat="server" Font-Size="X-Small" Height="17px" OnClick="LNKBID_Click"
                        Text='<%# Eval("CustomerID") %>' ToolTip="לחץ כדי לעבור לניהול תיקי לקוחות עבור לקוח זה"
                        Width="80px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CustLastName" HeaderText="משפחה" SortExpression="CustLastName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustFirstName" HeaderText="שם" SortExpression="CustFirstName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustBirthDate" DataFormatString="{0:dd/MM/yy}" HeaderText="ת לידה"
                HtmlEncode="False" SortExpression="CustBirthDate" />
            <asp:BoundField DataField="CustOrignOfficeID" HeaderText="COrignOfficeID" SortExpression="CustOrignOfficeID"
                Visible="False" />
            <asp:BoundField DataField="CustGender" DataFormatString="{0:ז;;נ}" HeaderText="מין"
                HtmlEncode="False" SortExpression="CustGender" />
            <asp:BoundField DataField="FrameID" HeaderText="FrameID" SortExpression="FrameID"
                Visible="False" />
            <asp:BoundField DataField="CustOriginOfficeTypeName" HeaderText="גורם מפנה" SortExpression="CustOriginOfficeTypeName" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CustOriginofficecity" HeaderText="סניף" SortExpression="CustOriginofficecity" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="FrameName" HeaderText="מסגרת" SortExpression="FrameName" >
                <ItemStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="custEventDate" DataFormatString="{0:dd/MM/yy}" HeaderText="הצטרף בת'"
                HtmlEncode="False" ReadOnly="True" SortExpression="custEventDate" >
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="RowID" ReadOnly="True" Visible="False" />
            <asp:BoundField DataField="ShortRefStatus" HeaderText="סטטוס" ReadOnly="True" 
                SortExpression="ShortRefStatus" />
        </Columns>
        <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
        <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
        <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
        <AlternatingRowStyle BackColor="White" />
    </asp:GridView>
</div>
</div>
        <asp:SqlDataSource ID="DSCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        
            SelectCommand="SELECT distinct c.CustomerID, c.CustFirstName, c.CustLastName, c.CustBirthDate, c.CustOriginOfficeTypeName, c.FrameName, c.CustGender, c.CustEventDate, c.CustEventTypeName, c.RowID, c.CustOriginOfficeCity, r.ShortRefStatus FROM dbo.ft_CustomerList(@UseriD,@FrameID,@SHOWALL) c LEFT OUTER JOIN RefStatus r ON c.RefStatusID = r.RefSatausID WHERE ISNULL(CustFrameID,0)=CASE @SHOWALL WHEN 0 THEN COALESCE(CustFrameID,0) WHEN 1 THEN COALESCE(@FrameID,CustFrameID,0) ELSE ISNULL(CustFrameID,0) END AND c.RefStatusID = CASE @SHOWALL WHEN 2 THEN c.RefStatusID ELSE 1 END AND (c.CustFirstName + ' ' + c.CustLastName LIKE '%' + @CustM + '%') ORDER BY c.CustLastName, c.CustFirstName" 
            DeleteCommand="DeleteCustomer" 
            DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserID" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="FrameID" 
                PropertyName="SelectedValue" DefaultValue="" />
            <asp:ControlParameter ControlID="rblList" Name="SHOWALL" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="tbSearch" Name="CustM" PropertyName="Text" 
				DefaultValue=" " />
      </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSTOTCNT" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        
            SelectCommand="SELECT COUNT(DISTINCT CustomerID) AS CNT FROM dbo.ft_CustomerList(@UserID,@FrameID,@SHOWALL) c WHERE ISNULL(CustFrameID,0)=CASE @SHOWALL WHEN 0 THEN COALESCE(@FrameID,CustFrameID,0) WHEN 1 THEN COALESCE(@FrameID,CustFrameID,0) ELSE ISNULL(CustFrameID,0) END AND c.RefStatusID = CASE @SHOWALL WHEN 2 THEN c.RefStatusID ELSE 1 END AND (c.CustFirstName + ' ' + c.CustLastName LIKE '%' + @CustM + '%')" 
            DeleteCommand="DeleteCustomer" 
            DeleteCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="userID" SessionField="UserID" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="FrameID" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="rblList" Name="SHOWALL" 
                PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="tbSearch" Name="CustM" PropertyName="Text" 
				DefaultValue=" " />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSServices" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            
        SelectCommand="SELECT ServiceName, ServiceID FROM ServiceList WHERE 1 = CASE WHEN EXISTS(SELECT * FROM p0v_Ntb WHERE ServiceID is not null and (UserID = @userID))  THEN 0 ELSE 1 END OR ServiceID IN (SELECT DISTINCT ServiceID FROM p0v_Ntb WHERE (UserID = @UserID)) ">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
        SelectCommand="SELECT FrameName, FrameID FROM FrameList WHERE (ServiceID = @ServiceID) AND FrameID in (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE (UserID = @UserID))">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlServices" Name="ServiceID" PropertyName="SelectedValue" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
	</asp:Content>

