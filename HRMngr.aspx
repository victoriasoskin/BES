<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="HRMngr.aspx.vb" Inherits="HRMngr" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>
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
	<topyca:PageHeader runat="server" ID="PageHeader1" Header="הערכת עובדים" />
	<div>
		<asp:Button runat="server" ID="btnEmpList" Text="ניהול רשימת עובדים" Visible="false" />
	</div>
	<hr />
	<div>	
		<asp:ListView ID="LVTREE" runat="server" DataSourceID="DSTree" DataKeyNames="UserID" Visible="false">					
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" >
							<tr>
								<td style="background-color:darkgray;font-weight:bold;">הכנה להערכת עובדים</td>
							</tr>
							<tr>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbHEmployeeID" CommandName="sort" CommandArgument="URName" Text="שם מנהל"></asp:LinkButton>
								</th>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbFrameName" CommandName="sort" CommandArgument="FrameName" Text="מסגרת"></asp:LinkButton>
								</th>
							</tr>
							<tr ID="itemPlaceholder" runat="server">
							</tr>

						</table>
					</LayoutTemplate>
					<ItemTemplate>
						<tr>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:hyperlink runat="server" ID="lnkbEmployeeName" Text='<%#Eval("UrName") & If(IsDBNull(Eval("EmployeeID"))," - חסרה תעודת זהות",vbnullstring) %>' NavigateUrl='<%# TLink() %>' />							 
							</td>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:Label runat="server" ID="lblFrameName" Text='<%#Eval("FrameName") %>' />
							</td>

						</tr>
					</ItemTemplate>
		</asp:ListView>
<hr />
		<asp:ListView ID="LVEMPS" runat="server" DataSourceID="DSEMPS" DataKeyNames="EmployeeID" OnPreRender="LVEMPS_PreRender">					
					<LayoutTemplate>
						<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv" >
							<tr>
								<td style="background-color:darkgray;font-weight:bold;">הערכת עובדים</td>
							</tr>
							<tr>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbHEmployeeID" CommandName="sort" CommandArgument="EmployeeName" Text="שם העובד"></asp:LinkButton>
								</th>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbHInterviewer1" CommandName="sort" CommandArgument="Interviewer1" Text="מראיין I"></asp:LinkButton>
								</th>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbHInterviewer2" CommandName="sort" CommandArgument="Interviewer2" Text="מראיין II"></asp:LinkButton>
								</th>
								<th style="background-color:Gray;font-weight:bold;">
									<asp:LinkButton runat="server" ID="lnkbFrameName" CommandName="sort" CommandArgument="FrameName" Text="מסגרת"></asp:LinkButton>
								</th>
								<th style="background-color:Gray;font-weight:bold;">
									ארכיון
								</th>
							</tr>
							<tr ID="itemPlaceholder" runat="server">
							</tr>
						</table>
					</LayoutTemplate>
					<ItemTemplate>
						<tr>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:hyperlink runat="server" ID="lnkbEmployeeName" Text='<%#Eval("EmployeeName") %>' NavigateUrl='<%# Flink() %>' />							 
							</td>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:Label runat="server" ID="lblInterviewer1" Text='<%#Eval("Interviewer1") %>' />
							</td>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:Label runat="server" ID="lblInterviewer2" Text='<%#Eval("Interviewer2") %>' />
							</td>
							<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:Label runat="server" ID="lblFrameName" Text='<%#Eval("FrameName") %>' />
							</td>
						<td style="margin:5px 5px 5px 5px; border:1px dotted Gray;">
								<asp:hyperlink runat="server" ID="Hyperlink1" Text="שנה קודמת" NavigateUrl='<%# Flink(Eval("EventID")) %>' Visible='<%#Eval("EventID") <> 0%>' />							 
							</td>
							</tr>
					</ItemTemplate>
		</asp:ListView>		

	</div>
	<hr />
	<div>
		<asp:Label runat="server" ID="lblMissingID" Text="רשימת עובדים שאין להם תעודת זהות ברשימת המשתמשים" Font-Bold="true" Font-Size="Small" BackColor="Gray" Visible="false"/>
		<asp:ListView runat="server" ID="lvMissingID" DataSourceID="DSMissingID" Visible="false">
			<EmptyDataTemplate>
				<table runat="server" style="">
					<tr>
						<td>
							אין נתונים להצגה.</td>
					</tr>
				</table>
			</EmptyDataTemplate>
			<ItemTemplate>
				<tr style="">
					<td>
						<asp:Label ID="EmployeeIDLabel" runat="server" 
							Text='<%# Eval("EmployeeID") %>' />
					</td>
					<td>
						<asp:Label ID="EmployeeNameLabel" runat="server" 
							Text='<%# Eval("EmployeeName") %>' />
					</td>
					<td>
						<asp:Label ID="JobNameLabel" runat="server" Text='<%# Eval("JobName") %>' />
					</td>
					<td>
						<asp:Label ID="FrameNameLabel" runat="server" Text='<%# Eval("FrameName") %>' />
					</td>
				</tr>
			</ItemTemplate>
			<LayoutTemplate>
				<table runat="server">
					<tr runat="server">
						<td runat="server">
							<table ID="itemPlaceholderContainer" runat="server" border="0" style="">
								<tr runat="server" style="">
									<th runat="server">
										תעודת זהות</th>
									<th runat="server">
										שם העובד</th>
									<th runat="server">
										תפקיד</th>
									<th runat="server">
										מסגרת</th>
								</tr>
								<tr ID="itemPlaceholder" runat="server">
								</tr>
							</table>
						</td>
					</tr>
					<tr runat="server">
						<td runat="server" style="">
						</td>
					</tr>
				</table>
			</LayoutTemplate>
		</asp:ListView>
	</div>
</div>

<asp:SqlDataSource runat="server" ID="DSTree" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="
		SELECT * FROM (SELECT UserID,URName,EmPloyeeID,u.FrameID,f.FrameName
FROM P0t_NtB u
LEFT OUTER JOIN FrameList f ON f.FrameID=u.FrameID
WHERE (f.ServiceID not in (16,17)) AND u.FrameID IN (SELECT FrameID
					FROM dbo.p0v_UserFramelist WHERE UserID = @UserID)
					AND (UserGroupID = 6)
UNION ALL
SELECT UserID,'מטה' AS URName,EmPloyeeID,u.FrameID,f.FrameName
FROM P0t_NtB u
LEFT OUTER JOIN FrameList f ON f.FrameID=u.FrameID
WHERE UserID=69 AND EXISTS(SELECT * FROM p0t_NtB WHERE UserID=@UserID AND UserGroupID in (2,13,22))) x
ORDER BY URName">
	<SelectParameters>
		<asp:SessionParameter Name="UserID" SessionField="UserID" />
	</SelectParameters>
	</asp:SqlDataSource>
<asp:SqlDataSource runat="server" ID="DSEMPS" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" SelectCommand="DECLARE @Intrvr1 int
		DECLARE @UG int
		DECLARE @Frm int
		SELECT @Intrvr1 = EmployeeID,@UG = UserGroupID,@Frm = FrameID FROM p0t_NtB WHERE UserID = @UserID;

		WITH ret AS(
  		SELECT	*
    	FROM	HR_Hierarchy
    	WHERE	EmployeeID IN (@Intrvr1)
    	UNION ALL
    	SELECT	t.*
    	FROM	HR_Hierarchy t INNER JOIN
    			ret r ON t.ParentID = r.EmployeeID
)
SELECT * FROM (
SELECT 1 as Ord,ret.EmployeeID,e.EmployeeName,h.EmployeeName AS Interviewer1, m.EmployeeName as Interviewer2,FrameName,h.EmployeeID as intr1ID,m.EmployeeID as intr2ID,ISNULL(oe.EventID,0) EventID
FROM    ret
LEFT OUTER JOIN dbo.tf_HR_EmpList() e ON e.EmployeeID=ret.EmployeeID
LEFT OUTER JOIN HR_EmpListCorrections c ON c.OrgEmpID=e.EmployeeID
LEFT OUTER JOIN dbo.tf_HR_EmpList() h ON h.EmployeeID=ret.ParentID
LEFT OUTER JOIN HR_SecondManagerList s ON s.EmployeeID=ret.EmployeeID
LEFT OUTER JOIN dbo.tf_HR_EmpList() m ON m.EmployeeID=s.ParentID
LEFT OUTER JOIN FrameList f ON f.FrameID=ISNULL(c.FrameID,e.FrameID)
LEFT OUTER JOIN (SELECT * FROM HR_Events WHERE PeriodId=(Select ActivePeriodId-1 FROM HR_ActivePeriod)) oe ON oe.EmpID = e.EmployeeID 
WHERE ret.EmployeeID!=-99 and ret.ParentID!=-99 AND h.EmployeeName IS NOT NULL AND e.EmployeeName IS NOT NULL AND ret.EmployeeID!=@Intrvr1
	AND ret.ParentID = CASE @UG WHEN 6 THEN ret.ParentID ELSE @Intrvr1 END
UNION ALL
SELECT 2 As ord,sm.EmployeeID,e.EmployeeName,m.EmployeeName AS Interviewer1, h.EmployeeName as Interviewer2,FrameName,m.EmployeeID as intr1ID,m.EmployeeID as intr2ID,ISNULL(oe.EventID,0) EventID
FROM    (SELECT * FROM HR_SecondManagerList where ParentID = @Intrvr1) sm
LEFT OUTER JOIN dbo.tf_HR_EmpList() e ON e.EmployeeID=sm.EmployeeID
LEFT OUTER JOIN HR_EmpListCorrections c ON c.OrgEmpID=e.EmployeeID
LEFT OUTER JOIN dbo.tf_HR_EmpList() h ON h.EmployeeID=sm.ParentID
LEFT OUTER JOIN HR_Hierarchy s ON s.EmployeeID=sm.EmployeeID
LEFT OUTER JOIN dbo.tf_HR_EmpList() m ON m.EmployeeID=s.ParentID
LEFT OUTER JOIN FrameList f ON f.FrameID=ISNULL(c.FrameID,e.FrameID)
LEFT OUTER JOIN (SELECT * FROM HR_Events WHERE PeriodId=(Select ActivePeriodId-1 FROM HR_ActivePeriod)) oe ON oe.EmpID = e.EmployeeID 
WHERE f.FrameID!=@Frm AND h.EmployeeName IS NOT NULL AND e.EmployeeName IS NOT NULL) a
ORDER BY Ord,CASE WHEN intr1ID=@Intrvr1 THEN '1' WHEN intr2ID=@Intrvr1 THEN '2' ELSE Interviewer1 END, EmployeeName">
	<SelectParameters>
		<asp:SessionParameter Name="UserID" SessionField="UserID" />
	</SelectParameters>
	</asp:SqlDataSource>
<asp:SqlDataSource runat="server" ID="DSMissingID" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		
		SelectCommand="SELECT [EmployeeID], [EmployeeName], [JobName], [FrameName] FROM [HR_vMissingEmployeeID]"></asp:SqlDataSource>
</asp:Content>


