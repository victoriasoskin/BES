<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="MAint.aspx.vb" Inherits="MAint" %>
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
<script type="text/ecmascript">
</script>
<div runat="server" id="divform" class="pg">
<topyca:pageheader runat="server" ID="PageHeader1" Header="פעולות תחזוקה" ButtonJava="" />
<div>
	<table>
		<tr>
			<td style="border:1px solid black;">
				מחיקת ארוע חריג
			</td>
			<td style="border:1px solid black;">

				<table>
					<tr>
						<td>
							מספר ארוע
						</td>
						<td>
							<asp:TextBox runat="server" ID="tbExID">
							</asp:TextBox>
							<asp:RequiredFieldValidator runat="server" ID="rfvEID" ControlToValidate="tbExID" ErrorMessage="חובה להקיש ערך" Display="Dynamic"/>
							<asp:RangeValidator runat="server" ID="rvEID" ControlToValidate="tbExID" ErrorMessage="ערך לא חוקי" MinimumValue="1" MaximumValue="100000"  Display="Dynamic" Type="Integer"/>
						</td>
					</tr>
					<tr>
						<td>
							תעודת זהות
						</td>
						<td>
							<asp:TextBox runat="server" ID="tbCID">
							</asp:TextBox>
							<asp:RequiredFieldValidator runat="server" ID="rfvCID" ControlToValidate="tbCID" ErrorMessage="חובה להקיש ערך" Display="Dynamic"/>
							<asp:RangeValidator runat="server" ID="rvCID" ControlToValidate="tbCID" ErrorMessage="ערך לא חוקי" MinimumValue="1000000" MaximumValue="999999999"  Display="Dynamic" Type="Integer"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="text-align:center;">
							<asp:Button runat="server" ID="btnDel" Text="אישור" OnClientClick="return confirm('האם למחוק?');" />
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>
</div>
</asp:Content>

