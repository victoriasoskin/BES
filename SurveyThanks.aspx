<%@ Page Title="" Language="VB" MasterPageFile="~/Surveys.master" AutoEventWireup="false" CodeFile="SurveyThanks.aspx.vb" Inherits="SurveyThanks" %>
<%@ Register TagPrefix="topyca" TagName="SurveyHeader" Src="~/Controls/SurveyHeader.ascx" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        border-top-width:1px;
        border-style:outset;
        border-color:#DDDDDD;
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
    .tdg
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

        if (t.value == 'הסתרה') {
            $('#insdiv').fadeOut('slow');
            t.value = 'הוספה';
        }
        else {
            $('#insdiv').fadeIn('slow');
            t.value = 'הסתרה';
        }
    }
 </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="pg">
        <topyca:SurveyHeader runat="server" ID="PageHeader1" Header="מערכת סקרים" />
        <div style="width:100%;height:550px;vertical-align:middle;text-align:center;">
            <asp:Label runat="server" ID="lblSurveyName" Font-Size="X-Large" Font-Bold="true" />
            <BR />
            <BR />
            <BR />
            <BR />
            <BR />
            <div runat="server" id="byebye" >
                     <asp:Label runat="server" ID="lblBye" Text="תודה שהקדשת מזמנך למילוי השאלון. תשובותיך נשלחו למאגר נתוני הסקר." Font-Size="Medium" />
                     <br />
                     <br />
                     <br />
                     <br />
                     <asp:button runat="server" ID="cls" Text="סגור" OnClientClick="window.open('', '_self', ''); window.close();" />
            </div>

        </div>
    </div>
</asp:Content>

