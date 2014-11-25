<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyForms.aspx.vb" Inherits="SurveyForms" %>
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
        font-family: Arial;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        font-family: Arial;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        font-family: Arial;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
        font-family: Arial;
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
        font-family: Arial;
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
<topyca:PageHeader runat="server" ID="PageHeader1" Header="הקלדת שאלוני סקר" />
<div style="vertical-align:middle;width:100%">
<p><input type="button" onclick="fout(this);" value="-" 
        style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader"></span></p>
<table class="tbld" id="tbldef">
    <tr style="height:20px;">
    <td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">שם הסקר</td>
    <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
    <asp:DropDownList runat="server" ID="ddlSurveys" CssClass="ddlw" 
    DataSourceID="DSSurveys" DataTextField="survey" DataValueField="SurveyID" 
    AppendDataBoundItems="True" Width="270px" AutoPostBack="True"  >
    <asp:ListItem Value="">בחר סקר</asp:ListItem>
    </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="עבור להקלדה" />
    </td>
    </tr>
    <tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
</table>
</div>
<hr />
    <br /><asp:Label runat="server" ID="lblhdr" text="" />
</div>
    <asp:SqlDataSource ID="DSSurveys" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
        SelectCommand="SELECT Survey + CASE RIGHT(Survey,4) WHEN ShortDescription THEN '' ELSE ' ' + ShortDescription END AS survey, SurveyID FROM SV_Surveys AS s WHERE GETDATE() BETWEEN StartDate AND EndDate ORDER BY SurveyGroupID, ShortDescription">
    </asp:SqlDataSource>
</asp:Content>

