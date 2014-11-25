<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false" CodeFile="HREmpList.aspx.vb" Inherits="HREmpList" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
	<style type="text/css">
		.edt
		{
		    text-align:right;
		}
	</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ScriptManager runat="server">
</asp:ScriptManager>
<asp:Label runat="server" ID="lblSingleFrame" />	 
<div runat="server" id="divform" class="pg" style="width:850px;">
	<div id="divworkplan">
		<span style="font-size:large;font-weight:bold;">רשימת עובדים</span>
		<hr />
		<table>
			<tr>
				<td>בחירת מסגרת
				</td>
				<td>
					<asp:DropDownList runat="server" ID="ddlFrameList" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="true">
						<asp:ListItem Value="">כל המסגרות</asp:ListItem>
					</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td>חתך על פי שם
				</td>
				<td>
					<asp:TextBox runat="server" ID="tbSearch" />
				</td>
			</tr>
			<tr>
				<td>בחירת רשימה
				</td>
				<td>
					<asp:DropDownList ID="DDLEmpListTypes" runat="server" 
							DataSourceID="DSEMpListTypes" DataTextField="Name" DataValueField="ID" 
							AppendDataBoundItems="true">
								<asp:ListItem Value="">כל הרשימות</asp:ListItem>
						</asp:DropDownList>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center;">
				<asp:Button runat="server" ID="btnShow" Text="הצג" />
			</td>
			</tr>
		</table>
		<asp:ListView runat="server" ID="lvWorkPlan" DataSourceID="DSEmployeeList" InsertItemPosition="None" 
			DataKeyNames="OrgEmpID">
			<LayoutTemplate>
				<table ID="itemPlaceholderContainer" runat="server" border="0" class="lstv">
					<thead>
						<tr>
							<th></th>
							<th><asp:LinkButton runat="server" ID="lnkbID" Text="ת.ז." CommandName="Sort" CommandArgument="EmployeeID" /></th>
							<th><asp:LinkButton runat="server" ID="lnkbName" Text="שם" CommandName="Sort" CommandArgument="EmployeeID" /></th>
							<th><asp:LinkButton runat="server" ID="lnkbJob" Text="תפקיד" CommandName="Sort" CommandArgument="EmployeeID" /></th>
							<th><asp:LinkButton runat="server" ID="lnkbFrame" Text="מסגרת" CommandName="Sort" CommandArgument="EmployeeID" /></th>
							<th><asp:LinkButton runat="server" ID="lnkbGen" Text="רשימה" CommandName="Sort" CommandArgument="EmpListType" /></th>
							<th><asp:LinkButton runat="server" ID="lnkScndn" Text="מראיין שני" CommandName="Sort" CommandArgument="SecondManager" OnPreRender="lnkbH_PreRender" /></th>
						</tr>
					</thead>
					<tr ID="itemPlaceholder" runat="server">
					</tr>
				</table>
			</LayoutTemplate>
			<ItemTemplate>
				<tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnEdit" CommandName="Edit" Text="עריכה" />
					</td>
					<td>
					<asp:label runat="server" id="lblEmployeeID"	text='<%#Eval("EmployeeID")%>' />
					</td>
					<td>
						<asp:Label runat="server" ID="lblPurpose" Text='<%#Eval("EmployeeName")%>' />
					</td>
					<td>
						<%#Eval("JobName")%>
					</td>
					<td>
						<%#Eval("FrameName")%>
					</td>
					<td>
						<asp:Label runat="server" ID="lblGen" Text='<%#Eval("EmpListType") %>' />
					</td>
					<td>
						<asp:CheckBox runat="server" ID="cbSM" Checked='<%# Eval("SecondManager") %>'  OnPreRender="CB_PreRender" OnCheckedChanged="CB_CheckedChanged" AutoPostBack="true" />
					</td>
				</tr>
			</ItemTemplate>
			<EditItemTemplate>
				<tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnUpdate" CommandName="Update" Text="שמירה" />
						<asp:Button runat="server" ID="btnCancel" CommandName="Cancel" Text="ביטול" />
					</td>
				<td>
						<asp:TextBox runat="server" ID="tbID" Text='<%#Bind("EmployeeID")%>' Width="70" />
					</td>
					<td>
						<asp:TextBox runat="server" ID="tbNane" Text='<%#Bind("EmployeeName")%>' />
					</td>
					<td>
						<asp:TextBox runat="server" ID="tbJobName" Text='<%#Bind("JobName")%>' />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlFrame" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" SelectedValue='<%#Bind("FrameID")%>' AppendDataBoundItems="true">
							<asp:ListItem Value="">בחר מסגרת</asp:ListItem>
						</asp:DropDownList>
					</td>
					<td>
						<asp:DropDownList ID="DDLEmpListTypes" runat="server" SelectedValue='<%#Bind("EmpListTypeID") %>'
							DataSourceID="DSEMpListTypes" DataTextField="Name" DataValueField="ID" 
							AppendDataBoundItems="true">
								<asp:ListItem Value="">כל הרשימות</asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
			</EditItemTemplate>
			<InsertItemTemplate>
				<tr>
					<td style="white-space:nowrap;">
						<asp:Button runat="server" ID="btnInsert" CommandName="Insert" Text="הוספה" />
						<asp:Button runat="server" ID="btnCancel" CommandName="Update" Text="ביטול" />
					</td>
					<td>
						<asp:TextBox runat="server" ID="tbID" Text='<%#Bind("EmployeeID")%>' Width="70" />
					</td>
					<td>
						<asp:TextBox runat="server" ID="tbName" Text='<%#Bind("EmployeeName")%>' />
					</td>
					<td>
						<asp:TextBox runat="server" ID="tbJobName" Text='<%#Bind("JobName")%>' />
					</td>
					<td>
						<asp:DropDownList runat="server" ID="ddlFrame" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" SelectedValue='<%#Bind("FrameID")%>' AppendDataBoundItems="true" >
							<asp:ListItem Value="">בחר מסגרת</asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
			</InsertItemTemplate>
		</asp:ListView>
	</div>
	<div id="divbuttons" style="text-align:center;">
		<asp:Button runat="server" ID="btnOK" Text="אישור" />
	</div>
</div>
<asp:SqlDataSource runat="server" ID="DSEmployeeList" CancelSelectOnNullParameter="False"
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 	
		SelectCommand="WITH CTE (EmployeeID,ParentID,Depth)
AS
(SELECT EmployeeID,ParentID,1
FROM HR_Hierarchy
WHERE Parentid!=1
UNION ALL
SELECT h.EmployeeID,CTE.ParentID,Depth + 1
FROM HR_Hierarchy h
JOIN CTE ON h.ParentID = CTE.EmployeeID
),CTE_Frames AS (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE UserID=@UserID),CTE_FramList AS (SELECT FrameID,FrameName FROM FrameList)

SELECT e.OrgEmpID, e.EmployeeID, e.EmployeeName, e.JobName, e.FrameID, f.FrameName, ISNULL(s.EmpListTypeID,1) AS EmpListTypeID,ISNULL(st.Name,'לא ברשימה') AS EmpListType,SecondManager 
FROM (SELECT * 
		FROM HR_vEmpList 
		WHERE  JobID NOT IN (44,45) 
				AND  ((FrameID = ISNULL(@FrameID, FrameID))) 
				AND CASE @SType WHEN 'Admin' THEN 1 ELSE CASE WHEN (FrameID IN (SELECT FrameID FROM CTE_Frames)) THEN 1 ELSE 0 END END = 1
				AND (1 = CASE WHEN @EmployeeName IS NULL THEN 1 ELSE CASE WHEN EmployeeName LIKE '%' + @EmployeeName + '%' THEN 1 ELSE 0 END END)
				 ) AS e 
LEFT OUTER JOIN CTE_FramList AS f ON e.FrameID = f.FrameID
LEFT OUTER JOIN (
SELECT c1.EmployeeID,CASE c2.ParentID WHEN -99 THEN 4 ELSE CASE u.UserGroupID WHEN 6 THEN 2 ELSE 3 end end AS EmpListTypeID
FROM 
(SELECT EmployeeID,MAX(Depth) AS DEPTH
FROM CTE GROUP BY EmployeeID) c1
JOIN CTE c2 ON c1.EmployeeID=c2.EmployeeID AND CASE WHEN c1.Depth &gt; 1 THEN c1.DEPTH-1 ELSE c1.DEPTH END =c2.Depth
LEFT OUTER JOIN p0t_NtB u ON u.EmployeeID=c2.ParentID) s ON s.EmployeeID=e.EmployeeID
LEFT OUTER JOIN HR_EmpListTypes st ON st.ID=s.EmpListTypeID
--WHERE ISNULL(s.EmpListTypeID,1)=COALESCE(@EmpListTypeID,s.EmpListTypeID,1)
 ORDER BY f.FrameName, e.EmployeeName" 
		UpdateCommand="IF EXISTS(SELECT * FROM HR_EmpListCorrections WHERE OrgEmpID=@OrgEmpID)
UPDATE    HR_EmpListCorrections
SET              EmployeeID = CASE @EmployeeID WHEN e.EmployeeID THEN NULL ELSE @EmployeeID END, 
                      EmployeeName = CASE @EmployeeName WHEN e.EmployeeName THEN NULL ELSE @EmployeeName END, 
                      FrameID = CASE @FrameID WHEN e.FrameID THEN NULL ELSE @FrameID END, JobName = CASE @JobName WHEN e.JobName THEN NULL ELSE @JobName END,
                       UserID = @UserID, LoadTime = GETDATE()
FROM         HR_EmpListCorrections RIGHT OUTER JOIN
                      dbo.tf_HR_EmpList() AS e ON HR_EmpListCorrections.OrgEmpID = e.EmployeeID
WHERE     (HR_EmpListCorrections.OrgEmpID = @OrgEmpID)
ELSE
INSERT INTO HR_EmpListCorrections(OrgEmpID,EmployeeID,EmployeeName,FrameID,JobName,UserID,LoadTime)
SELECT @OrgEmpID,
	CASE @EmployeeID WHEN e.EmployeeID THEN NULL ELSE @EmployeeID END,
		CASE @EmployeeName WHEN e.EmployeeName THEN NULL ELSE @EmployeeName END,
 CASE @FrameID WHEN e.FrameID THEN NULL ELSE @FrameID END,
	CASE @JobName WHEN e.JobName THEN NULL ELSE @JobName END,
	@UserID,
	GETDATE()
FROM dbo.tf_HR_EmpList() e
WHERE   EmployeeID = @OrgEmpID

IF EXISTS(SELECT * FROM HR_Hierarchy WHERE EmployeeID=@EmployeeID)
UPDATE    HR_Hierarchy
SET       ParentID = CASE s.EmpListTypeID WHEN 1 THEN NULL WHEN 2 THEN u.EmployeeID WHEN 3 THEN 57163412 ELSE -99 END
FROM      HR_Hierarchy LEFT OUTER JOIN
                      HR_vEmpList AS e ON e.EmployeeID = HR_Hierarchy.EmployeeID LEFT OUTER JOIN
                          (SELECT     FrameID, EmployeeID
                            FROM          p0t_NtB
                            WHERE      (UserGroupID = 6)) AS u ON e.FrameID = u.FrameID
                           	OUTER APPLY(SELECT * FROM dbo.HR_fnEmpListType(HR_Hierarchy.EmployeeID)) s
WHERE HR_Hierarchy.EmployeeID = @EmployeeID
ELSE
INSERT HR_Hierarchy(EmployeeID,ParentID,RootID) 
SELECT e.EmployeeID, CASE ISNULL(s.EmpListTypeID,1) WHEN 1 THEN NULL WHEN 2 THEN u.EmployeeID WHEN 3 THEN 57163412 ELSE -99 END, 1
FROM     HR_vEmpList AS e 
LEFT OUTER JOIN (SELECT     FrameID, EmployeeID
                 FROM          p0t_NtB
                 WHERE      (UserGroupID = 6)) AS u ON e.FrameID = u.FrameID
OUTER APPLY(SELECT * FROM dbo.HR_fnEmpListType(e.EmployeeID)) s
WHERE e.EmployeeID = @EmployeeID" >
		<SelectParameters>
			<asp:ControlParameter ControlID="ddlFrameList" Name="FrameID" 
				PropertyName="SelectedValue" />
			<asp:ControlParameter ControlID="DDLEmpListTypes" Name="EmpListTypeID" 
				PropertyName="SelectedValue" />
			<asp:ControlParameter ControlID="tbSearch" Name="EmployeeName" 
				PropertyName="Text" />
			<asp:SessionParameter SessionField="UserID" Name="UserID" Type="Int32" />
			<asp:SessionParameter SessionField="Stype" Name="SType" Type="String" />
		</SelectParameters>
		<UpdateParameters>
			<asp:Parameter Name="OrgEmpID" Type="Int32" />
			<asp:Parameter Name="EmployeeID" Type="Int32" />
			<asp:Parameter Name="EmployeeName" Type="String" />
			<asp:Parameter Name="FrameID" Type="Int32" />
			<asp:Parameter Name="JobName" Type="String" />
			<asp:SessionParameter SessionField="UserID" Name="UserID" Type="int32" />
		</UpdateParameters>
	</asp:SqlDataSource>
<asp:SqlDataSource runat="server" ID="DSFrames" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE FrameID IN (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE UserID=@UserID) ORDER BY [FrameName]"><SelectParameters>
		<asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
		</SelectParameters></asp:SqlDataSource>
	<asp:SqlDataSource ID="DSEMpListTypes" runat="server" 
		ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" 
		SelectCommand="SELECT [Name], [ID] FROM [HR_EmpListTypes]">
	</asp:SqlDataSource>
</asp:Content>

