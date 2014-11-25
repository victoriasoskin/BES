<%@ Page EnableEventValidation="false" Title="תוצאות סקר" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyAVG.aspx.vb" Inherits="SurveyAvg" %>
<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="Controls/TreeDropDown.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
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
    .pgg
    {
        position:absolute;
        background-color:#C0C0C0;
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
			margin-right: 40px;
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
     .dtselect
     {
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
 <div runat="server" id="divform" class="pg" >
 <table style="width:100%"><tr><td>
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דוח סקרים" />
	</td></tr></table>
<div runat="server" id="divhdr">
<div style="vertical-align:middle;width:100%;min-height:500px;" id="divdef">
<p><input type="button" onclick="fout(this);" value="-" id="btndef" style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">תפריט הגדרת דוח</span></p>

	<table class="tbld" id="tbldef">
		<tr>
			<td style="width:50px;">
			סקר&nbsp;
			</td>
			<td style="width:200px;">
			<asp:DropDownList ID="DDLSurveys" runat="server" DataSourceID="DSSurveys"  Width="250px"
			DataTextField="SurveyGroup" DataValueField="SurveyGroupID" 
			AutoPostBack="true" AppendDataBoundItems="true">
			<asp:ListItem Value="">בחר סקר</asp:ListItem>
			</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td style="direction: rtl;">
			שנה&nbsp;
			</td>
			<td>
				<asp:DropDownList runat="server" ID="ddlSY" Width="100px"
				AutoPostBack="True" DataSourceID="DSSY" DataTextField="ShortDescription" 
				DataValueField="Sub" >
				</asp:DropDownList>
			</td>
		</tr>
		<tr style="height:20px;">
			<td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">דוח</td>
			<td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">
			<asp:DropDownList runat="server" ID="ddlreptype" AutoPostBack="true" Width="400px"
			AppendDataBoundItems="True" ><asp:ListItem Value="">בחר דוח&nbsp;</asp:ListItem></asp:DropDownList>
		</td>
		</tr>
		<tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
		<tr class="blockfooter">
			<td colspan="2"><asp:Label runat="server" ID="lblTitle1" Text="יחידה ארגונית" Font-Bold="true" Font-Size="Medium" Visible="false" /></td>
		</tr>
		<tr class="blockfooter">
			<td class="tdr"><asp:Label runat="server" ID="lblServices" Text="אזור" Visible="false" /></td>
			<td class="dtselect">
			<asp:DropDownList ID="DDLServices" runat="server"  Width="150px"
			DataSourceID="DSServices" DataTextField="ServiceName" 
			DataValueField="ServiceID" AutoPostBack="true" EnableTheming="True" 
					Enabled="False">
			</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdr"><asp:Label runat="server" ID="lblFrames" Text="מסגרת" Visible="false" /></td>
			<td class="dtselect">
			<asp:DropDownList ID="DDLFrames" runat="server" DataSourceID="DSFrames" width="250px"
			DataTextField="FrameName" DataValueField="FrameID" 
			AutoPostBack="True" Enabled="False">
			</asp:DropDownList>
			</td>
		</tr>
		<tr><td colspan="4" style="padding-right:0px;" runat="server" id="trHR2" visible="false"><hr /></td></tr>
		<tr><td colspan="2"><asp:Label runat="server" ID="lblTitle2" Text="חתכים לפי מאפייני הנסקרים" Font-Bold="true" Font-Size="Medium" Visible="false" /></td></tr>
		<tr>
			<td><asp:Label runat="server" ID="lblST" Text="שירות" Visible="false" /></td>
			<td class="dtselect">
				<asp:DropDownList ID="DDLST" runat="server" DataSourceID="DSST" AppendDataBoundItems="true" Visible="false" Width="100px"
						
				DataTextField="ServiceType" DataValueField="ServiceTypeID" Enabled="False" >
				</asp:DropDownList>
				
			</td>
		</tr>
		<tr>
			<td>
			<asp:Label runat="server" ID="lblLAKUT"  Visible="false" Text="לקות" /></td>
			<td class="dtselect">
				<asp:DropDownList ID="DDLLAKUT" runat="server"  AppendDataBoundItems="true" Width="100px"
				DataSourceID="DSLAKUT" DataTextField="LAKUT" 
				DataValueField="LakutID" Enabled="False" Visible="false">
				</asp:DropDownList>
				
			</td>
		</tr>
		<tr>
			<td><asp:Label runat="server" ID="lblJob" Text="תפקיד"  Visible="false" /></td>
			<td class="dtselect">
				<asp:DropDownList ID="DDLJob" runat="server" DataSourceID="DSJob" AppendDataBoundItems="true" Width="400px"
						
				DataTextField="AnswerText" DataValueField="ID" Enabled="False" Visible="false" >
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td>
			<asp:Label runat="server" ID="lblSEN" text="ותק" Visible="false" /></td>
			<td class="dtselect">
				<asp:DropDownList ID="DDLSEN" runat="server"  AppendDataBoundItems="true" Width="150px"
				DataSourceID="DSSEN" DataTextField="AnswerText" 
				DataValueField="Val" Enabled="False" Visible="false">
				</asp:DropDownList>
				
			</td>
		</tr>
		<tr>
			<td>
			<asp:Label runat="server" ID="lblAGE" text="גיל" Visible="false" /></td>
			<td  class="dtselect">
				<asp:DropDownList ID="DDLAGE" runat="server"  AppendDataBoundItems="true" Width="100px"
				DataSourceID="DSAGE" DataTextField="Age" DataValueField="AgeID" Enabled="False" Visible="false">
				</asp:DropDownList>                        
			</td>
		</tr>
		<tr>
			<td>
			<asp:Label runat="server" ID="lblGender" text="מגדר" Visible="false" /></td>
			<td  class="dtselect">
				<asp:DropDownList ID="DDLGender" runat="server"  AppendDataBoundItems="true" Width="100px"
				DataSourceID="DSGender" DataTextField="AnswerText" DataValueField="ID" Enabled="False" Visible="false">
				</asp:DropDownList>                        
				
 			</td>
		</tr>
		<tr><td colspan="4" style="padding-right:0px;" runat="server" id="trHR3" visible="false"><hr /></td></tr>
		<tr><td colspan="2"><asp:Label runat="server" ID="lblTitle3" Text="חתכים לפי מימדים ושאלות" Font-Bold="true" Font-Size="Medium" Visible="false" /></td></tr>
		<tr>
			<td>
			<asp:Label runat="server" ID="lblProfiles" text="מימד" Visible="false" />
			</td>
			<td class="dtselect">
				<asp:DropDownList ID="DDLProfiles" runat="server" DataSourceID="DSProfiles" AppendDataBoundItems="true" Width="200px"
						
				DataTextField="Title" DataValueField="CategoryID" Enabled="False" visible="false">
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
		<td><asp:Label runat="server" ID="lblQ" text="שאלות" Visible="false" /></td>
		<td colspan="3" class="dtselect">
			<asp:ListBox ID="LSBQ" runat="server" SelectionMode="Multiple" width="720px"
			DataSourceID="DSQuestions" DataTextField="Question" DataValueField="QuestionID" 
						Enabled="False" Visible="false">
			</asp:ListBox>
		</td>
		</tr>
		<tr><td colspan="4" style="padding-right:0px;" runat="server" id="trHR4" visible="false"><hr /></td></tr>
		<tr>
			<td colspan="4" style="text-align:center;">
			<asp:Button runat="server" ID="btnShow" Text="הפקה" Height="22" />&nbsp;<asp:Button 
			ID="btnExcel" runat="server" Text="מצגת" Height="22px" Width="45px" />
				<asp:Label ID="lblDL" runat="server" Visible="false"></asp:Label>
			</td>
		</tr>
	</table>
</div>
<hr />
</div>
<div id="divchrt">
<table style="width:100%"><tr><td><asp:Label runat="server" ID="lblRepName" Visible="False" Font-Size="Large" 
                    Font-Bold="True"  Width="599px" />
                 <asp:HiddenField ID="hdnavgtype" runat="server" />
  </td></tr></table>
                
                <div style="text-align:right"><asp:Label runat="server" ID="lblcomment" Width="500" Visible="false" ForeColor="White" BackColor="Navy" /></div> 
                 <asp:Image ID="ImgChart" runat="server" Visible="false"  Width='<%# If(Request.QueryString("width") <> vbNullString, CInt(Request.QueryString("width")) - 300, 800) %>' AlternateText="אין נתונים להצגה"  />
                 <asp:Chart ID="ChrtG" runat="server" Visible="False" RightToLeft="Yes" AlternateText="אין נתונים להצגה"> 
                   <Series>
                   </Series> 
                    <ChartAreas> 
 				         <asp:ChartArea Name="MainChartArea" >
						</asp:ChartArea> 
                   </ChartAreas> 
                </asp:Chart> 
    
        <asp:SqlDataSource ID="DSREPTYPEAS" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT RepName, RepID FROM p5t_repTypes WHERE (RepGroup = 1)">
        </asp:SqlDataSource>
         <div>
              <asp:Button ID="btng" runat="server" Text="עדכן גרף" Visible="False" />
         </div>      
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
            CellPadding="4">
       </asp:GridView>
</div>
<div id="divsql">
        <asp:SqlDataSource ID="DSServices" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Book10VPS %>"     
			SelectCommand="">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            	<asp:ControlParameter ControlID="DDLSurveys" Name="SUrveyGroupID" 
					PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSFrames" runat="server"
            ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
 			SelectCommand="">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
				<asp:Parameter Name="ServiceID" DefaultValue="" />
<%--                <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                    PropertyName="SelectedValue" Type="Int32" />
--%>            </SelectParameters>
        </asp:SqlDataSource>
       <asp:SqlDataSource ID="DSJob" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
            
            SelectCommand="SELECT 0 AS ID, 'כל התפקידים'  AS AnwerText
			 UNION ALL SELECT ID, [AnwerTextPlural] AS AnswerText
                            FROM  [SV_SurAnswers]
                            Where ExcludeFromList = 0 AND ID in (Select Val From (Select val,count(*) Over(Partition by val) as c From Survey_Answers_8 Where QuestionID=91 And FrameID=Coalesce(@FrameID,@FrameIDD,'99999')) x) " 
            CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:Parameter Name="SurveyID" />
                <asp:SessionParameter Name="FrameID" SessionField="FrameID" />
               <asp:ControlParameter Name="FrameIDD" ControlID="DDLFrames" PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSSEN" runat="server" 
            ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
            SelectCommand="SELECT 'כל רמות הותק' AS AnswerText,0 AS Val UNION ALL SELECT [SEN] AS AnswerText, [SenID] AS Val FROM [Survey_Sen]">
        </asp:SqlDataSource>
<%--        <asp:SqlDataSource ID="DSPROFILES" runat="server" 
			ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
			SelectCommand="SELECT [Profile_T], [Profile_V] FROM [vSurvey_Profiles] WHERE ([SurveyID] = @SurveyID) ORDER BY [ItemOrder]">
			<SelectParameters>
				<asp:ControlParameter ControlID="DDLSurveys" Name="SurveyID" 
					PropertyName="SelectedValue" Type="Int32" />
			</SelectParameters>
		</asp:SqlDataSource>--%>
        <asp:SqlDataSource ID="dsTvprofiles" runat="server"></asp:SqlDataSource>
        <asp:SqlDataSource ID="DSAGE" runat="server" 
			ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
			SelectCommand="SELECT 'כל הגילאים' AS Age,0 AS AgeID UNION ALL SELECT [Age], [AgeID] FROM [p0t_Age]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="DSGender" runat="server" 
			ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
			SelectCommand="SELECT 0 AS ID, 'שני המינים' AS AnswerText UNION ALL SELECT Val AS ID,AnwerTextPlural AS AnswerText
					FROM SV_SurAnswers 
					WHERE SurveyID=8 AND AnsGroup=4"></asp:SqlDataSource>
        <asp:SqlDataSource ID="DSProfiles" runat="server" 
			ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
			SelectCommand=""></asp:SqlDataSource>
        <asp:SqlDataSource ID="DSSY" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
            SelectCommand="SELECT 'בחר שנה'  AS ShortDescription,NULL AS Sub UNION ALL SELECT [ShortDescription], [SurveyID] + [SubGroup]*1000  As Sub FROM [SV_Surveys] WHERE ([SurveyGroupID] = @SurveyGroupID) And  StartDate&gt;+'2010-1-1' And ISNULL(ShowReports,0)!=0 ORDER BY [ShortDescription] DESC">
            <SelectParameters>
                <asp:ControlParameter ControlID="DDLSurveys" Name="SurveyGroupID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSQuestions" runat="server" 
			ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
			
			
			
			
			SelectCommand="SELECT * FROM (SELECT 'כל השאלות' AS Question,NULL AS QuestionID,-10 AS Ord UNION ALL SELECT '[' + CAST(QuestionID AS varchar(5)) + '] ' + Question AS Question, QuestionID,Ord FROM SV_SurQuestions WHERE (SurveyID = CAST(RIGHT (@SurveyID, 3) AS int)) AND (QuestionID &lt;&gt; 0) AND (NOT EXISTS (SELECT ID FROM SV_QLink WHERE (MSurveyID = CAST(RIGHT (@SurveyID, 3) AS int)))) OR (SurveyID = CAST(RIGHT (@SurveyID, 3) AS int)) AND (QuestionID &lt;&gt; 0) AND (QuestionID IN (SELECT MQuestionID FROM SV_QLink AS SV_QLink_1 WHERE (ISNULL(InAvg, 0) &lt;&gt; 0) AND (MSurveyID = CAST(RIGHT (@SurveyID, 3) AS int))))) x ORDER BY ISNULL(ord,0), QuestionID">
			<SelectParameters>
				<asp:ControlParameter ControlID="ddlSY" Name="SurveyID" 
					PropertyName="SelectedValue" Type="Int32" />
			</SelectParameters>
		</asp:SqlDataSource>
        <asp:SqlDataSource ID="DSSurveys" runat="server" 
            ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
            SelectCommand="SELECT [SurveyGroup], [SurveyGroupID] FROM [SV_SurveyGroups]
Where Active!=0 ">
            <SelectParameters>
                <asp:SessionParameter Name="SType" SessionField="SType" />
            </SelectParameters>
        </asp:SqlDataSource>
		<asp:SqlDataSource ID="DSST" runat="server" 
			ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
			SelectCommand="SELECT 'כל סוגי השירות' AS [ServiceType],0 As [ServiceTypeID] UNION ALL SELECT [ServiceType], [ServiceTypeID] FROM [p5t_ServiceType]"></asp:SqlDataSource>
		<asp:SqlDataSource ID="DSLAKUT" runat="server" 
			ConnectionString="<%$ ConnectionStrings:book10VPS %>" 
			SelectCommand="SELECT 'כל הלקויות' AS [Lakut],0 As [LakutID] UNION ALL SELECT [Lakut], [LakutID] FROM [p5t_Lakut]">
		</asp:SqlDataSource>
		<asp:HiddenField ID="hdnmaxy" runat="server" />
		<asp:HiddenField ID="hdncoltooltip" runat="server" />
		<asp:HiddenField ID="hdnminy" runat="server" />		
    </div>
</div>
      <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" /><asp:Button runat="server" ID="btnTwo" Text="ביטול" CausesValidation="false" Visible="false" />
    </div>

</asp:Content>