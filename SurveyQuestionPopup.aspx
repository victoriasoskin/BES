<%@ Page Language="VB" AutoEventWireup="false" CodeFile="SurveyQuestionPopup.aspx.vb" Inherits="SurveyQuestionPopup" enableViewStateMac="false" validateRequest="false" enableEventValidation="false" viewStateEncryptionMode ="Never" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" dir="rtl">
<head runat="server">
    <title>שאלות הסקר</title>
	<style type="text/css">
 	body
 	{
 	    font-family:Arial (Hebrew);
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
        wdith:150px;
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
 	   .style2
		{
			height: 20px;
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
</head>
<body>
<form id="form1" runat="server">
 <div runat="server" id="divform" class="pg">
<topyca:PageHeader runat="server" ID="PageHeader1" Header="שאלות הסקר" />
		<div>	
			   <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
				   ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
				   SelectCommand="SELECT        QuestionID AS קוד, Question AS שאלה
FROM            SV_SurQuestions
WHERE        (SurveyID = @SurveyID) 
			AND (ISNULL(QuestionID, 0) &lt;&gt; 0) 
ORDER BY ISNULL(ord, 0), קוד">
				   <SelectParameters>
					   <asp:QueryStringParameter Name="SurveyID" QueryStringField="s" Type="Int32" />
				   </SelectParameters>
			   </asp:SqlDataSource>
	<div>		<asp:Label ID="lblhdr" runat="server"  style="font-weight: 700; font-size: large;"/><br /></div>
								<asp:GridView ID="gvq" runat="server" DataSourceID="SqlDataSource1" Width="100%" CellPadding="4"
				   AutoGenerateColumns="False">
				<Columns>
					<asp:BoundField DataField="קוד" HeaderText="קוד" SortExpression="קוד" />
					<asp:BoundField DataField="שאלה" HeaderText="שאלה" SortExpression="שאלה" ControlStyle-Width="100%" />
				</Columns>
				<RowStyle BorderColor="#666699" BorderStyle="Dotted" />
			</asp:GridView>
		
		</div>
		<div>
		</div>
    </div>
    </form>
</body>
</html>
