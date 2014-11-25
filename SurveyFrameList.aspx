<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyFrameList.aspx.vb" Inherits="SurveyFrameList" MaintainScrollPositionOnPostback="true" %>
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
<topyca:PageHeader runat="server" ID="PageHeader1" Header="מסגרות הסקר וסטטוס" />
<div style="vertical-align:middle;width:100%">
<p><input type="button" onclick="fout(this);" value="-" 
        style="width:15px;height:20px;background:transparent;font-size:medium;"  />&nbsp;<span class="blockHeader"></span></p>
<table class="tbld" id="tbldef">
    <tr style="height:20px;">
    <td style="height:20px;padding:0px 10px 0px 0px;vertical-align:middle;">שם הסקר</td>
    <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
		<asp:Panel runat="server" ID="pnl" ScrollBars="Vertical" Height="70" Width="420">
			<asp:CheckBoxList runat="server" ID="ddlSurveys" CssClass="ddlw" width="400"
			DataSourceID="DSSurveys" DataTextField="survey" DataValueField="SurveyID">
			</asp:CheckBoxList>
		</asp:Panel>
	    <asp:Button ID="Button0" runat="server" Text="הפקה" />
	    <asp:Button ID="Button1" runat="server" Text="xl" />
    </td>
<%--    <td colspan="3" style="height:20px;vertical-align:middle;margin:0px;">&nbsp;&nbsp;
    <asp:DropDownList runat="server" ID="ddlSurveys" CssClass="ddlw" 
    DataSourceID="DSSurveys" DataTextField="survey" DataValueField="SurveyID" 
    AppendDataBoundItems="True" Width="270px" AutoPostBack="True"  >
    <asp:ListItem Value="">בחר סקר</asp:ListItem>
    </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="xl" />
    </td>
--%>    </tr>
    <tr><td colspan="4" style="padding-right:0px;"><hr /></td></tr>
</table>
</div>
<hr />
<div>

    <asp:ListView ID="ListView1" runat="server" DataSourceID="DSCOUNT" DataKeyNames="ID">
         <EditItemTemplate>
            <tr  style="background-color:#CCCCCC;">
                <td class="tdq">
                    <asp:Label ID="NameLabel" runat="server" 
                        Text='<%# Eval("Name") %>' />
                </td>
                 <td class="tdq">
                    <asp:TextBox ID="cntTextBox" runat="server" Text='<%# Bind("cnt") %>' Width="50" CssClass="tbw" />
                    <asp:RangeValidator runat="server" ID="rvcnt" ControlToValidate="cntTextBox" Type="Integer" MinimumValue="0" MaximumValue="999" ErrorMessage="לא חוקי" ForeColor="Red" Display="Dynamic" />
                </td>
                <td class="tdq">
                    <asp:Label ID="acntTextBox" runat="server" Text='<%# Eval("acnt") %>' />
                </td>
                <td class="tdq"
                    <asp:Label ID="prcTextBox" runat="server" Text='<%# if(ISDBNULL(Eval("prc")),VBNullString,IF(Eval("prc")<0.005,vbnullstring,Eval("Prc","{0:#%}"))) %>' />
                </td>
                <td class="tdq">
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                        Text="עדכון" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="ביטול" />
                </td>
             </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>
                        אין נתונים להצגה.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" 
                        Text="Insert" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                        Text="Clear" />
                </td>
                <td>
                    <asp:TextBox ID="NTextBox" runat="server" Text='<%# Bind("N") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ServiceIDTextBox" runat="server" 
                        Text='<%# Bind("ServiceID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ServiceNameTextBox" runat="server" 
                        Text='<%# Bind("ServiceName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="FrameIDTextBox" runat="server" Text='<%# Bind("FrameID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="FrameNameTextBox" runat="server" 
                        Text='<%# Bind("FrameName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="SurveyIDTextBox" runat="server" 
                        Text='<%# Bind("SurveyID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="ordTextBox" runat="server" Text='<%# Bind("ord") %>' />
                </td>
                <td>
                    <asp:TextBox ID="cntTextBox" runat="server" Text='<%# Bind("cnt") %>' />
                </td>
                <td>
                    <asp:TextBox ID="acntTextBox" runat="server" Text='<%# Bind("acnt") %>' />
                </td>
                <td>
                    <asp:TextBox ID="prcTextBox" runat="server" Text='<%# Bind("prc") %>' />
                </td>
                <td>
                    <asp:TextBox ID="AsOfTextBox" runat="server" Text='<%# Bind("AsOf") %>' />
                </td>
                <td>
                    <asp:TextBox ID="UserIDTextBox" runat="server" Text='<%# Bind("UserID") %>' />
                </td>
                <td>
                    <asp:TextBox ID="UserNameTextBox" runat="server" 
                        Text='<%# Bind("UserName") %>' />
                </td>
                <td>
                    <asp:TextBox ID="UpdateDateTextBox" runat="server" 
                        Text='<%# Bind("UpdateDate") %>' />
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">

                <td class="tdq">
                    <asp:Label ID="FrameNameLabel" runat="server" Text='<%# if(ISDBNULL(Eval("Name")),"&nbsp;",Eval("Name"))  %>' Font-Bold='<%#Eval("Gord") = 1 OR Eval("Gord") = 3  %>' />
                </td>
                <td class="tdq">
                    <asp:Label ID="cntLabel" runat="server" Text='<%# if(ISDBNULL(Eval("cnt")),"&nbsp;",Eval("cnt")) %>' />
                </td>
                <td class="tdq">
                    <asp:Label ID="acntLabel" runat="server" Text='<%# if(ISDBNULL(Eval("acnt")),"&nbsp;",Eval("acnt")) %>' />
                </td>
                <td class="tdq">
                    <asp:Label ID="prcLabel" runat="server" Text='<%# If(IsDBNull(Eval("prc")), "&nbsp;", If(Eval("prc") < 0.005, "&nbsp;", Eval("Prc", "{0:#%}"))) %>' />
                </td>
                <td class="tdq">
                    <asp:button runat="server" ID="btnUPDCOUNT" Text="עדכון כמות" CommandName="Edit" Visible='<%# ActionVisible() %>' /> &nbsp;
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
                                    מסגרת</th>
                                 <th runat="server">
                                    כמות כוללת</th>
                                <th runat="server">
                                    שאלונים</th>
                                <th runat="server">
                                    %</th>
                                <th runat="server" ><asp:Label runat="server" ID="lblActions" OnPreRender="lblActions_PreRender" /></th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                             <tr runat="server" style="background-color:#EEEEEE;" >
                                <td runat="server" class="tbq">
                                    <b>סה"כ ארגוני</b>
                                </td>
                                <td runat="server" class="tbq">
                                    <asp:Label runat="server" ID="totcntLabel" OnPreRender="totcntLabel_PreRender" />
                                </td>
                              <td runat="server" class="tbq">
                                    <asp:Label runat="server" ID="totacntLabel"  OnPreRender="totacntLabel_PreRender"/>
                                </td>
                               <td runat="server" class="tbq">
                                    <asp:Label runat="server" ID="totprcLabel"  OnPreRender="totprcLabel_PreRender"/>
                                </td>
                                <td runat="server" class="tbq"></td>
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
    <br /><asp:Label runat="server" ID="lblhdr" text="" />
</div>
    <asp:SqlDataSource ID="DSSurveys" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
        SelectCommand="SELECT Survey + CASE RIGHT(Survey,4) WHEN ShortDescription THEN '' ELSE ' ' + ShortDescription END AS survey, SurveyID FROM dbo.SV_Surveys AS s ORDER BY SurveyGroupID, ShortDescription">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCOUNT" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10VPS %>" 
        SelectCommand="SV_pSurvey_CurrentCount" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False" 
        UpdateCommand="UPDATE dbo.SV_Survey_Frames SET UserID = @UserID, UpdateDate = GETDATE(), AsOF = NULL, cnt = @cnt WHERE (SurveyID = @SurveyID) AND (FrameID = @ID)">
        <SelectParameters>
            <asp:Parameter Name="SurveyIDs" Type="String" />
            <asp:Parameter Name="AsOf" Type="DateTime" DefaultValue="2050-12-31" />
        </SelectParameters>
        <UpdateParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" type="int32" />
            <asp:Parameter Name="cnt" />
            <asp:ControlParameter Name="SurveyID" ControlID="ddlSurveys" PropertyName="SelectedValue" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

