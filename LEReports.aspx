<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="LEReports.aspx.vb" Inherits="EL_Reports" %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
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
        if (t.value=='-') {
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
<table style="width:100%;">
    <tr>
        <td colspan="5" style="text-align:center;">
            <asp:Label runat="server" ID="lblhdr" Text="&lt;span class='h1'&gt;דוח טפסי עזיבת עובדים&lt;/span&gt;" />
        </td>
    </tr>
    <tr>
        <td style="font-weight:bold;text-decoration:underline;width:70px;padding-right:10px;">
            
        </td>
        <td style="width:260px;">
            
        </td>
        <td style="width:160px;">
            &nbsp
        </td>
       <td style="width:70px;">
            תאריך:
        </td>
        <td style="width:50px;">
            <asp:Label runat="server" ID="lblDate" />
        </td>
      </tr>
    <tr>
        <td style="font-weight:bold;text-decoration:underline;padding-right:10px;">
           
        </td>
        <td>
        </td>
        <td>
        </td>
        <td>
           שם משתמש:
        </td>

       <td>
            <asp:Label runat="server" ID="lblUsername" />
        </td>
      </tr>
 </table>
<hr />
<div style="vertical-align:middle;width:100%">
    <p><input type="button" onclick="fout(this);" value="-" 
            style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader">הגדרת הדוח</span></p>
    <table class="tbld" id="tbldef">
        <tr>
            <td>
                העמודות בדוח
            </td>
            <td colspan="3">&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="ddlColumns" DataTextField="nam" DataValueField="val" >
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                טווח תאריכים: מתאריך
            </td>
            <td>
                    <topyca:TBDate runat="server" ID="tbFromdate" DateFormat="dd/MM/yyyy" InitDate="01/01/2000"  />
            </td>
            <td>
                עד תאריך
            </td>
            <td>
                    <topyca:TBDate runat="server" ID="tbToDate" DateFormat="dd/MM/yyyy" InitDate="31/12/2099"  />
            </td>
        </tr>
             <tr class="blockfooter">
                <td class="tdr">איזור</td>
                <td>&nbsp;&nbsp;
                    <asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" >
                        <asp:ListItem Value="">כל האזורים</asp:ListItem>
                    </asp:DropDownList>
                 </td>
                <td class="tdr">מסגרת</td>
                <td>&nbsp;&nbsp;
                   <asp:DropDownList runat="server" ID="ddlFrames" DataSourceID="DSFrames" DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="true" EnableViewState="false" >
                        <asp:ListItem Value="">כל המסגרות</asp:ListItem>
                    </asp:DropDownList>
                 </td>
            </tr>
         <tr>
            <td>סטטוס</td>
            <td>&nbsp;&nbsp;
                <asp:DropDownList runat="server" ID="ddlStatus">
                    <asp:ListItem Value="2">הכל</asp:ListItem>
                    <asp:ListItem Value="0">פתוח</asp:ListItem>
                    <asp:ListItem Value="1">סגור</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                סיבות עזיבה
            </td>
            <td>&nbsp;&nbsp;
                      <asp:DropDownList runat="server" ID="ddlWL" CssClass="ddlw" DataSourceID="dsWL" DataTextField="WLDescription" DataValueField="WLID" AppendDataBoundItems="true" Width="270"  >
                        <asp:ListItem Value="">כל הסיבות</asp:ListItem>
                    </asp:DropDownList>
            </td>
        </tr>
       <tr>
       <td>
        איתור עובד 
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
    </table>
    </div>
<hr />
<div style="min-width:800px;">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
        <EmptyDataRowStyle Font-Size="x-Large" />
    </asp:GridView>
</div>
</div>
    <asp:SqlDataSource ID="DSWL" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [WLID],[WLDescription] FROM [EL_WL] WHERE Parent&gt;1 order by WLID">
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

