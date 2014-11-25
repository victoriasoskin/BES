<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyTexts.aspx.vb" Inherits="SurveyTexts" %>
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
 <div runat="server" id="divform" class="pg">
<topyca:PageHeader runat="server" ID="PageHeader1" Header="טקסטים חופשיים" />
<div style="vertical-align:middle;width:100%" id="divdef">
<p><input type="button" onclick="fout(this);" value="-" id="btndef" style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
	<table class="tbld" id="tbldef">
		<tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
		<tr class="blockfooter">
			<td style="width:50px;">איזור</td>
			<td style="width:350px;">&nbsp;&nbsp;
			<asp:DropDownList ID="DDLServices" runat="server" width="100%"
			DataSourceID="DSServices" DataTextField="ServiceName" 
			DataValueField="ServiceID" AutoPostBack="true" EnableTheming="True">
			</asp:DropDownList>
			</td>
			<td style="width:50px;">מסגרת</td>
			<td style="width:350px;">&nbsp;&nbsp;
			<asp:DropDownList ID="DDLFrames" runat="server" DataSourceID="DSFrames" width="100%"
			DataTextField="FrameName" DataValueField="FrameID" 
			>
			</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="text-align:center;">
<%--             <asp:LinkButton runat="server" ID="lnkbck" Text="חזרה לדוח סקרים" PostBackUrl="SurveyAvg.aspx" style="float:right;" />
--%>			<asp:Button runat="server" ID="btnShow" Text="הפקה" Height="22" />&nbsp;<asp:Button 
			ID="btnExcel" runat="server" Text="XL" Height="22px" Width="45px" Visible="false" />
			</td>
		</tr>
	</table>
</div>
<hr />
<div runat="server" id="divhdr">
   <div>
        <div style="text-align:right;"><asp:Label ID="lblhdr" runat="server" Text="Label" 
					style="font-weight: 700; font-size: large;"></asp:Label> <br />                      
<asp:Label ID="lblrephdr" runat="server" Text="" 
					style="font-weight: 700; font-size: medium;" width="600"></asp:Label></div>
     	<asp:GridView ID="gvtexts" runat="server" AutoGenerateColumns="False" 
			DataSourceID="dstexts" CellPadding="4">
			<RowStyle BorderColor="#666699" BorderStyle="Dotted" />
			<Columns>
				<asp:BoundField DataField="TextClass" HeaderText="מיון" 
					SortExpression="TextClass" HtmlEncode="False" HtmlEncodeFormatString="False"  
					ItemStyle-Font-Bold="true" ItemStyle-ForeColor="Blue" >
<ItemStyle Font-Bold="True" ForeColor="Blue"></ItemStyle>
				</asp:BoundField>
				<asp:BoundField DataField="Question" HeaderText="שאלה" 
					SortExpression="Question" />
				<asp:TemplateField HeaderText="טקסט" SortExpression="TextDet">
                     <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("TextDet") %>' Width="500px"></asp:Label>
                    </ItemTemplate>
                    <HeaderStyle Width="500px" />
                    <ItemStyle Width="500px" />
                </asp:TemplateField>
			</Columns>
		</asp:GridView>
		                   <asp:SqlDataSource ID="dstexts" runat="server"
					   ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 			   			  			   
					   SelectCommand="SELECT QuestionID, Question, x, TextDet, TextClass, c, r FROM dbo.SV_fnSurveyTexts(@SurveyID, @FrameID, @QuestionID) AS SV_fnSurveyTexts_1 ORDER BY CASE TextClass WHEN 'שונות' THEN 0 ELSE c END DESC, x, r" 
					   CancelSelectOnNullParameter="False">
					   <SelectParameters>
						   <asp:QueryStringParameter Name="SurveyID" QueryStringField="S" Type="Int32" />
						   <asp:ControlParameter ControlID="DDLFrames" Name="FrameID" 
							   PropertyName="SelectedValue" type="Int32"/>
					   	   <asp:QueryStringParameter Name="QuestionID" QueryStringField="Q" Type="Int32" />
					   </SelectParameters>
				   </asp:SqlDataSource>
				   <asp:SqlDataSource ID="DSServices" runat="server" CancelSelectOnNullParameter="false"
            ConnectionString="<%$ ConnectionStrings:book10VPS %>"     
			SelectCommand="">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID"/>
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSFrames" runat="server" CancelSelectOnNullParameter="false"
            ConnectionString="<%$ ConnectionStrings:book10VPS %>" 		
			SelectCommand=" ">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>

    </div>

</div>
</div>
</asp:Content>

