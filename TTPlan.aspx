<%@ Page Title="" Language="VB" MasterPageFile="~/Empty.master" AutoEventWireup="false" CodeFile="TTPlan.aspx.vb" Inherits="TTPlan" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .edt {
            text-align: right;
        }

        .btn {
            white-space: normal;
            text-decoration: none;
            color: Black;
        }

        .wp1 {
            width: 15%; 
        }

        .wp2 {
            width: 25%;
        }

        .wp3 {
            width: 40%;
        }

        .wp4 {
            width: 20%;
        }

        .ansprint {
        }
    </style>
    <script type="text/ecmascript">
        //To cause postback "as" the Button
        function PostBackOnMainPage() {
		<%=GetPostBackScript()%>
	}
        function popup(url) {
            params = 'width=' + screen.width;
            params += ', height=' + screen.height;
            params += ', top=0, left=0'
            params += ', fullscreen=yes';

            newwin = window.open(url, 'windowname4', params);
            if (window.focus) { newwin.focus() }
            return false;
        }
        function DoPrint() {
            document.all("PRINT").style.visibility = "hidden";
            //        document.all("tdbtn0").style.visibility = "hidden";
            //        document.all("tdbtn1").style.visibility = "hidden";
            //        document.all("tdbtn2").style.visibility = "hidden";
            //        
            document.execCommand('print', false, null);
            document.all("PRINT").style.visibility = "visible";
            //        document.all("tdbtn0").style.visibility = "visible";
            //        document.all("tdbtn1").style.visibility = "visible";
            //        document.all("tdbtn2").style.visibility = "visible";

        }
        function myPrint() {

            document.printing.leftMargin = 1.0;

            document.printing.topMargin = 1.0;

            document.printing.rightMargin = 1.0;

            document.printing.bottomMargin = 1.0;

            document.printing.portrait = false;

            document.execCommand('print', false, null); // print without prompt
        }
        function ShowWord(s) {
            var x = document.getElementById('divwordmsg');
            x.style.display = s;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager runat="server" />
    <div runat="server" id="divform" class="pg">
        <topyca:PageHeader runat="server" ID="PageHeader1" Header="" ButtonJava="" />
        <div id="divwordmsg" style="margin-bottom: 20px; border: 4px outset Gray; text-align: center; background-color: #EEEEEE; position: fixed; top: 150px; right: 250px; display: none;">
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;סמן את החלקים שהינך מעוניין להעביר למסמך WORD&nbsp;&nbsp;&nbsp;&nbsp;
		<div style="text-align: right;">
            <asp:CheckBoxList runat="server" ID="cblWord" ForeColor="#3582B9">
                <asp:ListItem Value="1" Selected="True">רקע לניהול תמיכות</asp:ListItem>
                <asp:ListItem Value="2" Selected="True">בניית תוכנית תמיכות</asp:ListItem>
                <asp:ListItem Value="3" Selected="True">תוכנית תמיכות שבועית</asp:ListItem>
            </asp:CheckBoxList>
        </div>
            <asp:Button runat="server" ID="btnpWord" Text="אישור" OnClientClick="ShowWord('none')" /><asp:Button runat="server" ID="btnpcncl" Text="ביטול" OnClientClick="ShowWord('none')" />
            <br />
            <br />

        </div>
        <div runat="server" id="divbuttons">
            <table style="text-align: left;">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="lblCustEventID" BackColor="#EEEEEE" BorderColor="#DDDDDD" BorderStyle="Ridge" />
                        <%--				<asp:ImageButton runat="server" ID="btnSave" ImageUrl="images/diskette.png" CausesValidation="false" Visible="false"
						Height="45px" Width="45px" />			
                        --%>			</td>
                </tr>
                <tr>
                    <td>
                        <asp:ImageButton runat="server" ID="btnWord" CausesValidation="false"
                            Width="35px" Height="35px" ImageUrl="~/images/Microsoft-Word-icon.png" OnClientClick="ShowWord('block'); return false;" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button runat="server" ID="btnBack" CausesValidation="false"
                            Width="55px" Height="35px" Text="חזרה" />
                    </td>
                </tr>
<%--                <tr>
                    <td style="text-align:left">
                        <asp:Button runat="server" ID="btnOldWP" Text="צפיה בתוכנית תמיכות ישנה" OnClick="btnOldWP_Click" />
                    </td>
                </tr>--%>
            </table>
        </div>

        <asp:AlwaysVisibleControlExtender runat="server" TargetControlID="divbuttons" HorizontalOffset="735" VerticalOffset="65" HorizontalSide="Right">
        </asp:AlwaysVisibleControlExtender>
        <div id="divheader">
            <asp:ListView runat="server" ID="lvHdr" DataSourceID="DSCustomer" DataKeyNames="CustomerID">
                <LayoutTemplate>
                    <table id="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width: 100%;">
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <table style="width: 100%; font-size: small;">
                                <tr>
                                    <td style="font-weight: bold;">ת.ז:
                                    </td>
                                    <td>
                                        <%#Eval("CustomerID")%>
                                        <asp:HiddenField runat="server" ID="hdnFormHeader" Value='<%#Eval("FormType") & " " & Eval("Name") %>' OnPreRender="hdn_PreRender" />
                                    </td>
                                    <td style="font-weight: bold;">ת.לידה:
                                    </td>
                                    <td>
                                        <%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold;">מסגרת:
                                    </td>
                                    <td>
                                        <%#Eval("FrameName")%>
                                    </td>
                                    <td style="font-weight: bold;">ת.קליטה:
                                    </td>
                                    <td>
                                        <%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="font-weight: bold;">מעדכן התוכנית:
                                    </td>
                                    <td>
                                        <%#Eval("URName")%>
                                    </td>
                                    <td style="font-weight: bold;">ת.עדכון:
                                    </td>
                                    <td>
                                        <%#Format(Eval("CustEventDate"), "dd/MM/yyyy")%>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
        <hr />
        <div id="divFormQ">
            <asp:ListView runat="server" ID="lvAnswers" DataSourceID="DSAnswers" DataKeyNames="FieldID" EnableViewState="false" ViewStateMode="Disabled">
                <LayoutTemplate>
                    <table id="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width: 100%;">
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <table style="width: 100%" dir="rtl">
                                <tr>
                                    <td></td>
                                    <td runat="server" style='<%#Eval("MainTextStyle") %>'>
                                        <asp:HiddenField runat="server" ID="hdnFieldID" Value='<%#Eval("FieldID") %>' />
                                        <asp:Label runat="server" ID="lblMainText" Text='<%#Eval("MainText") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td runat="server" style='<%#Eval("SubTextStyle") %>'>
                                        <asp:Label runat="server" ID="lblSubText" Text='<%#Eval("SubText") %>' Visible='<%#IsPrinted() %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td runat="server" class="ansprint" style='<%#Eval("TextStyle") & "width:95%;" %>' visible='<%#Eval("AnswerTypeID") = 2 %>'>
                                        <asp:HiddenField runat="server" ID="hdnVal" Value='<%#Bind("Val") %>' />
                                        <asp:RadioButtonList runat="server" ID="rblv" RepeatDirection="Horizontal" RepeatLayout="Table" DataSourceID="DSAnswerSets" DataTextField="Txt" DataValueField="Val" Visible="false" OnPreRender="rbl_PreRender" BackColor="White" />
                                        <asp:Image runat="server" ID="imgrbl" ImageUrl='<%#ValImage("Val") %>' AlternateText='<%#Eval("Val") %>' Width="226px" Height="26px" />
                                    </td>
                                </tr>

                                <tr style="width: 5%">
                                    <td rowspan="2">
                                        <asp:Button runat="server" ID="btnEdit" CommandName="Edit" Text="עריכה" Visible='<%#IsEditable() %>' />
                                    </td>
                                    <td runat="server" class="ansprint" style='<%#Eval("TextStyle") & "width:95%;" %>'>
                                        <%#If(IsDBNull(Eval("Txt")),vbNullString,Eval("Txt").Replace(Environment.NewLine, "<br />")) & "&nbsp;" %>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </ItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <table style="width: 100%" dir="rtl">
                                <tr>
                                    <td rowspan="4" style="width: 7%;">
                                        <asp:Button runat="server" ID="btnUpdate" Text="שמירה" CommandName="Update" />
                                        <asp:Button runat="server" ID="btnCancel" CommandName="Cancel" Text="ביטול" />
                                    </td>
                                    <td runat="server" style='<%#Eval("MainTextStyle") %>'>
                                        <asp:HiddenField runat="server" ID="hdnFieldID" Value='<%#Bind("FieldID") %>' />
                                        <asp:Label runat="server" ID="lblMainText" Text='<%#Eval("MainText") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td runat="server" style='<%#Eval("SubTextStyle") %>'>
                                        <asp:Label runat="server" ID="lblSubText" Text='<%#Eval("SubText") %>' />
                                    </td>
                                </tr>
                                <tr>
                                    <td runat="server" class="ansprint" style='<%#Eval("TextStyle") & "width:93%;" %>' visible='<%#Eval("AnswerTypeID") = 2 %>'>
                                        <asp:HiddenField runat="server" ID="hdnVal" Value='<%#Bind("Val") %>' />
                                        <asp:RadioButtonList runat="server" ID="rblv" RepeatDirection="Horizontal" RepeatLayout="Table" DataSourceID="DSAnswerSets" DataTextField="Txt" DataValueField="Val" Visible='<%#Eval("AnswerTypeID") = 2 %>' OnPreRender="rbl_PreRender" OnSelectedIndexChanged="rbl_SelectedIndexChanged" />
                                    </td>
                                </tr>
                                <tr>
                                    <td runat="server" class="ansprint" style='<%#Eval("TextStyle") & "width:93%;" %>'>
                                        <asp:TextBox runat="server" ID="ckeTxt" Width="100%" Text='<%#Bind("Txt") %>' Rows='<%#Eval("NumberOfRows") %>' TextMode="MultiLine" Font-Names="Arial" />
                                    </td>
                                </tr>
                                <td></td>
                            </table>
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>
            <div style="width: 100%; text-align: left;">
                <asp:Button runat="server" ID="btnprtForm" Text="הדפס" Style="float: left;" CausesValidation="false" /></div>
        </div>
        <div runat="server" id="divhide">
            <div id="divworkplan">
                <hr style="border: 1px solid black;" />
                <span style="font-size: large; font-weight: bold;">תוכנית תמיכות - ישנה</span>

                <hr />
                <asp:UpdatePanel runat="server" ID="UPDp">
                    <ContentTemplate>
                        <asp:ListView runat="server" ID="lvWorkPlan" DataSourceID="DSWorkPlan" DataKeyNames="ID,WpID,FormID" ViewStateMode="Disabled" InsertItemPosition="None" >
                            <LayoutTemplate>
                                <table id="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width: 100%; direction: rtl;">
                                    <thead>
                                        <tr>
                                            <th class="wp1"></th>
                                            <th class="wp2">מטרת התמיכה</th>
                                            <th class="wp3">אופן ביצוע (תדירות, זמן, ספק ופירוק התמיכה בפועל)</th>
                                            <th class="wp4">קריטריונים להצלחה</th>
                                        </tr>
                                    </thead>
                                    <tr id="itemPlaceholder" runat="server">
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td style="white-space: nowrap;">
                                        <%--						<asp:Button runat="server" ID="btnEdit" CommandName="edit" Text="עריכה" CausesValidation="false" Visible='<%#IsEditable() %>'  />
						<asp:Button runat="server" ID="btnDel" CommandName="delete" Text="מחיקה" OnClientClick="return confirm('האם למחוק?');"  Visible='<%#IsEditable() %>' />--%>
                                        <asp:HiddenField runat="server" ID="hdnID" Value='<% #Eval("ID")%>' />
                                        <asp:HiddenField runat="server" ID="hdnWpID" Value='<%#Bind("WpID") %>' />
                                    </td>
                                    <td class="tdxprint" style="background-color: #FFFFFF;">
                                        <asp:Label runat="server" ID="lblPurpose" Text='<%#If(IsDBNull(Eval("Purpose")),vbNullString,Eval("Purpose").Replace(Environment.NewLine, "<br />")) & "&nbsp;"%>' />
                                    </td>
                                    <td class="tdxprint" style="background-color: #FFFFFF;">
                                        <asp:Label runat="server" ID="lblDescription" Text='<%#If(IsDBNull(Eval("Description")),vbNullString,Eval("Description").Replace(Environment.NewLine, "<br />")) & "&nbsp;"%>' />
                                    </td>
                                    <td class="tdxprint" style="background-color: #FFFFFF;">
                                        <%#If(IsDBNull(Eval("Criteria")), vbNullString, Eval("Criteria").Replace(Environment.NewLine, "<br />")) & "&nbsp;"%>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <InsertItemTemplate>
                                <tr>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="btnInsert" CommandName="Insert" Text="הוספה" />
                                        <asp:Button runat="server" ID="btnCancel" CommandName="Cancel" Text="ביטול" CausesValidation="false" />
                                        <asp:HiddenField runat="server" ID="hdnWpID" Value='<%#Bind("WpID") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="ckePurpose" Text='<%#Bind("Purpose") %>' Rows="3" TextMode="MultiLine" />
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="ckeDescription" Text='<%#Bind("Description") %>' Rows="3" TextMode="MultiLine" Width="100%" />
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="ckeCriteria" Text='<%#Bind("Criteria") %>' Rows="3" TextMode="MultiLine" />
                                    </td>
                                </tr>
                            </InsertItemTemplate>
                            <EditItemTemplate>
                                <tr>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="btnInsert" CommandName="update" Text="עדכון" CausesValidation="false" />
                                        <asp:Button runat="server" ID="btnCancel" CommandName="cancel" Text="ביטול" CausesValidation="false" />
                                        <asp:HiddenField runat="server" ID="hdnWpID" Value='<%#Bind("WpID") %>' />
                                    </td>
                                    <td class="tdxprint">
                                        <asp:TextBox runat="server" ID="ckePurpose" Text='<%#Bind("Purpose") %>' Rows="3" TextMode="MultiLine" />
                                    </td>
                                    <td class="tdxprint">
                                        <asp:TextBox runat="server" ID="ckeDescription" Text='<%#Bind("Description") %>' Rows="3" TextMode="MultiLine" Width="100%" />
                                    </td>
                                    <td class="tdxprint">
                                        <asp:TextBox runat="server" ID="ckeCriteria" Text='<%#Bind("Criteria") %>' Rows="3" TextMode="MultiLine" />
                                    </td>
                                </tr>
                            </EditItemTemplate>

                        </asp:ListView>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div style="width: 100%; text-align: left;">
                    <asp:Button runat="server" ID="btnprWP" Text="הדפס" CausesValidation="false" /></div>
            </div>
            <div id="divWeeklytimetable">
                <hr style="border: 1px solid black;" />
                <span style="font-size: large; font-weight: bold;">תוכנית שבועית - ישנה</span>
                <hr />
                <asp:ListView runat="server" ID="LVWeeklyPlan" DataSourceID="DSWeeklyPlan" >
                    <LayoutTemplate>
                        <table id="itemPlaceholderContainer" runat="server" class="lstv" style="width: 100%; direction: rtl;">
                            <thead>
                                <tr>
                                    <th style="width: 15%">א</th>
                                    <th style="width: 14%">ב</th>
                                    <th style="width: 14%">ג</th>
                                    <th style="width: 14%">ד</th>
                                    <th style="width: 14%">ה</th>
                                    <th style="width: 14%">ו</th>
                                    <th style="width: 15%">ש</th>
                                </tr>
                            </thead>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl1" Text='<%#WW(1) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl2" Text='<%#WW(2) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl3" Text='<%#WW(3) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl4" Text='<%#WW(4) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl5" Text='<%#WW(5) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl6" Text='<%#WW(6) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                            <td class="tdxprint" style="white-space: normal; background-color: White; min-height: 40px; vertical-align: top;">
                                <asp:Label runat="server" ID="hl7" Text='<%#WW(7) %>' Width="100%" CausesValidation="false" CssClass="btn" />
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </div>
        </div>
        <div style="width: 100%; text-align: left;">
            <asp:Button runat="server" ID="btnprWWP" Text="הדפס" Style="float: left;" CausesValidation="false" /></div>
        <hr />
        <div style="width: 100%;">
            <table runat="server" id="tblsign">
                <tr style="height: 30px;">
                    <td>חתימת הדייר</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מדריך</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מתאמת</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מנהל</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת משפחה</td>
                    <td>_______________________</td>
                </tr>
            </table>
        </div>
        <asp:SqlDataSource ID="DSAnswers" runat="server" CancelSelectOnNullParameter="false"
            ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" SelectCommand="SELECT * FROM dbo.TT_fnAnswers(@CustEventID) ORDER BY FieldID" UpdateCommand="DECLARE @FormID int
SELECT @FormID=CustRelateID FROM CustEventList WHERE CustEventID = @CustEventID
IF EXISTS(SELECT * FROM TT_Answers WHERE FormID = @FormID AND FieldID = @FieldID AND CustEventID = @CustEventID)
UPDATE TT_Answers SET FieldID=@FieldID,Val=@Val,Txt=@Txt,UserID=@UserID,Loadtime=GETDATE() WHERE FormID = @FormID AND FieldID = @FieldID AND CustEventID = @CustEventID
ELSE
INSERT INTO TT_Answers(FormID,FieldID,Val,Txt,UserID,Loadtime,CustEventID) VALUES(@FormID,@FieldID,@Val,@Txt,@UserID,GETDATE(),@CustEventID)">
            <SelectParameters>
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
                <asp:Parameter Name="FieldID" Type="Int32" />
                <asp:Parameter Name="Val" Type="Int32" />
                <asp:Parameter Name="Txt" Type="String" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="DSCustomer" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:Book10VPSC %>"
            SelectCommand="DECLARE @CustomerID bigint
DECLARE @FrameID int
SELECT @CustomerID = CustomerID,@FrameID = CustFrameID FROM CustEventList WHERE CustEventID = @CustEventID
SELECT e.CustomerID,c.CustFirstName + ' ' + c.CustLastName AS Name, c.CustBirthDate, i.CustEventDate As EnterDate,f.FrameName,e.CustEventDate, u.URName,e.CustRelateID AS FormID,ft.Name AS FormType
FROM CustEventList e
LEFT OUTER JOIN CustomerList c ON c.CustomerID = e.CustomerID
INNER JOIN		(SELECT TOP 1 CustEventDate,CustomerID,CustFrameID 
				 FROM CustEventlist i
				 WHERE CustEventTypeID = 1 AND CustFrameID = @FrameID AND CustEventID IN (	SELECT CusteventID
																							FROM CustStatus
																							WHERE CustomerID = @CustomerID)
				 ORDER BY CustEventDate DESC
				) i ON i.CustomerID = e.CustomerID AND i.CustFrameID = e.CustFrameID
LEFT OUTER JOIN FrameList f ON e.CustFrameID = f.FrameID
LEFT OUTER JOIN p0t_NtB u ON e.UserID = u.UserID
CROSS JOIN (SELECT * FROM TT_FormTypes WHERE ID = @FormTypeID) ft
WHERE CustEventID = @CustEventID">
            <SelectParameters>
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
                <asp:QueryStringParameter Name="FormTypeID" QueryStringField="FT" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource runat="server" ID="DSWorkPlan" CancelSelectOnNullParameter="False"
            ConnectionString="<%$ ConnectionStrings:Book10VPSC %>"
            DeleteCommand="IF EXISTS(SELECT * FROM TT_WorkPlan WHERE ISNULL(WpID,ID) = @WpID AND CustEventID = @CustEventID)
DELETE FROM [TT_WorkPlan] WHERE [ID] = @ID
ELSE
INSERT INTO TT_WorkPlan(WpID,FormID, Purpose, Description, Criteria, CustEventID, LoadTime, UserID,Deleted) VALUES (@WpID,@FormID, @Purpose, @Description, @Criteria, @CustEventID, GETDATE(), @UserID,1)"
            InsertCommand="DECLARE @FormID int 
		SELECT @FormID=CustRelateID From CustEventList WHERE CustEventID=@CustEventID
		INSERT INTO TT_WorkPlan(FormID, Purpose, Description, Criteria, CustEventID, LoadTime, UserID) VALUES (@FormID, @Purpose, @Description, @Criteria, @CustEventID, GETDATE(), @UserID)"
            SelectCommand="SELECT * FROM dbo.TT_fnWorkPlan(@CustEventID)"
            UpdateCommand="IF EXISTS(SELECT * FROM TT_WorkPlan WHERE ISNULL(WpID,ID) = @WpID AND CustEventID = @CustEventID)
UPDATE TT_WorkPlan SET FormID = @FormID, Purpose = @Purpose, Description = @Description, Criteria = @Criteria, CustEventID = @CustEventID, LoadTime = GETDATE(), UserID = @UserID WHERE ISNULL(WpID,ID) = @WpID AND CustEventID = @CustEventID
ELSE
INSERT INTO TT_WorkPlan(WpID, FormID, Purpose, Description, Criteria, CustEventID, LoadTime, UserID) VALUES (@WpID,@FormID, @Purpose, @Description, @Criteria, @CustEventID, GETDATE(), @UserID)">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
                <asp:Parameter Name="WpID" Type="Int32" />
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
                <asp:Parameter Name="FormID" Type="Int32" />
                <asp:Parameter Name="Purpose" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Criteria" Type="String" />
                <asp:SessionParameter Name="UserID" Type="Int32" SessionField="UserID" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="WpID" Type="Int32" />
                <asp:Parameter Name="Purpose" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Criteria" Type="String" />
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
                <asp:SessionParameter Name="UserID" Type="Int32" SessionField="UserID" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="WpID" Type="Int32" />
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
                <asp:Parameter Name="FormID" Type="Int32" />
                <asp:Parameter Name="Purpose" Type="String" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="Criteria" Type="String" />
                <asp:SessionParameter Name="UserID" Type="Int32" SessionField="UserID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSWeeklyPlan" runat="server"
            ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" SelectCommand="SELECT * FROM dbo.TT_fnWeeklyPlan(@CustEventID)">
            <SelectParameters>
                <asp:ControlParameter Name="CustEventID" ControlID="lblCustEventID" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSAnswerSets" runat="server"
            ConnectionString="<%$ ConnectionStrings:Book10VPSC %>" SelectCommand="SELECT Val,Txt FROM TT_AnswerSets WHERE AnswersetID=1 ORDER BY Val DESC"></asp:SqlDataSource>
    </div>
    <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" Style="text-align: right;"></asp:Label><br />
        <br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
    </div>
    <asp:Button ID="btnPostback" runat="server" Visible="false" CausesValidation="false" />
    <input id="PRINT" type="button" value="הדפסה" onclick="DoPrint()" visible="false" />
</asp:Content>

