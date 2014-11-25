<%@ Page Title="" Language="VB" Debug="true" MasterPageFile="~/Surveys.master" AutoEventWireup="false" CodeFile="SurveysSQLTemp.aspx.vb" Inherits="SurveysSQLTemp" enableViewStateMac="false" validateRequest="false" enableEventValidation="false" viewStateEncryptionMode ="Never"  %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.WebControls" tagprefix="asp" %>
<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI" tagprefix="asp" %>
<%@ Register TagPrefix="topyca" TagName="SurveyHeader" Src="~/Controls/SurveyHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server" >
	<div class="pg">				
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
        width:930px;
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
        font-family:Arial;
        width:120px;
        font-size:11px;
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
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
</style>

<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<script type="text/javascript">
    function thisrow(x) {
    x.style.backgroundColor = 'transparent';
    }
</script>
<div runat="server" id="divmsg" visible="false">
    <asp:HiddenField runat="server" ID="hdn1SrvrAction" />
    <asp:HiddenField runat="server" ID="hdn2SrvrAction" />
    <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
    <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" /><asp:Button runat="server" ID="btnTwo" Text="ביטול" CausesValidation="false" Visible="false" />
</div>
<div runat="server" id="divform" >
<topyca:SurveyHeader runat="server" ID="SurHDR" Header="" />
<div runat="server" id="divlvq" style="vertical-align:top;width:100%" visible="false">
 <asp:ListView ID="lv_q" runat="server" DataSourceID="dslvq" >
    <LayoutTemplate>
        <table  cellpadding="4">
            <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
        </table>
    </LayoutTemplate>
    <ItemTemplate>
        <tbody>
            <tr>
                <td runat="server" style='<%# "border-top:1px Gray solid;vertical-align:text-top;background-color:Silver;width:3%;" & Eval("IDstyle") %>' visible='<%# If(Eval("IsGroupHeader")=0,True,False) %>' >
                    <%#Eval("ID") %>
                </td>
                <td runat="server" colspan='<%#If(Eval("IsGroupHeader")=0,if(Eval("FullWidthQuestion")=0,1,3),4) %>' style='<%# "border-top:1px Gray solid;background-color:Silver;width:33%;vertical-align:text-top;" & Eval("style") %>' >
                    <%#Eval("txt")%>
                </td>
                <td runat="server" style='<%# Eval("Answerstyle") & "width:70%;" & "border-top:1px Gray solid;" %>' visible='<%#If(Eval("IsGroupHeader")=0,True,False) %>' >
 <%--                   <asp:UpdatePanel runat="server" ID="up_q" UpdateMode="Always" >
                        <ContentTemplate>
--%>                            <asp:HiddenField ID="HDNANS_q" Value='<%#Eval("ans") %>' runat="server" />
                            <asp:HiddenField runat="server" ID="hdnid_q" value='<%#Eval("id")%>' />
                            <asp:HiddenField runat="server" ID="HDNAID_q" Value='<%#Eval("ansID") %>' />
                            <asp:HiddenField runat="server" ID="HDNFRMID_q" Value='<%#Eval("FrameID") %>' />
                            <asp:HiddenField runat="server" ID="hdnAnsGroup" Value='<%#Eval("AnswerGroup") %>' />
                           <asp:HiddenField runat="server" ID="hdnPerFrame" Value='<%#Eval("PerFrame")%>' />
                             <asp:HiddenField runat="server" ID="hdnControl" Value='<%#Eval("control")%>' />
							<div runat="server" id="divFrames" onclick='thisrow(this)' >
                            <asp:ListView ID="LVFRAMES" runat="server" Visible="false" OnPreRender="LVFRAMES_PreRender" ><%--DataSourceID="DSSERVICES"--%> 
                                <ItemTemplate>
                                    <tr style="">
                                        <td style="vertical-align:top;">
                                            <asp:Hiddenfield ID="SID1HiddenField" runat="server" Value='<%# Eval("SID1") %>' />
                                            <asp:Label ID="SN1Label" runat="server" Text='<%# Eval("SN1") %>' BackColor="#AAAAAA" Height="25" Width="100%" style="padding-right:5Px;" />
                                            <asp:DataList runat="server" ID="DL1" OnDataBinding="DL_DataBinding">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="cbf" Text='<%# Eval("FrameName") %>' OnCheckedChanged="cb_CheckedChanged" />
                                                    <asp:HiddenField runat="server" ID="hdn" Value='<%# Eval("FrameID") %>' />
                                                </ItemTemplate>
                                            </asp:DataList>
										</td>
                                       <td style="vertical-align:top;">
                                            <asp:Hiddenfield ID="SID2HiddenField" runat="server" Value='<%# Eval("SID2") %>'/>
                                            <asp:Label ID="SN2Label" runat="server" Text='<%# Eval("SN2") %>'  BackColor="#AAAAAA" Height="25" Width="100%" style="padding-right:5Px;" />
                                           <asp:DataList runat="server" ID="DL2" OnDataBinding="DL_DataBinding">
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="cbf" Text='<%# Eval("FrameName") %>' OnCheckedChanged="cb_CheckedChanged" />
                                                    <asp:HiddenField runat="server" ID="hdn" Value='<%# Eval("FrameID") %>' />
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table id="Table1" runat="server">
                                        <tr id="Tr1" runat="server">
                                            <td id="Td1" runat="server">
                                                <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                                    <tr ID="itemPlaceholder" runat="server">
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="Tr2" runat="server">
                                            <td id="Td2" runat="server" style="">
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                           </asp:ListView>
						</div>
                           <asp:RadioButtonList ID="rbla_q" onclick='thisrow(this)'  AutoPostBack="false" OnSelectedIndexChanged="rbla_SelectedIndexChanged" CausesValidation="true" OnPreRender="rbla_PreRender" CssClass="rbl" AppendDataBoundItems="true" runat="server" OnDataBinding="rbla_DataBinding" RepeatDirection="Horizontal" DataTextField="txt" RepeatLayout="Table" DataValueField="val" CellPadding="8" CellSpacing="6" >
                            </asp:RadioButtonList>
                            <asp:RangeValidator runat="server" ID="rvrbl" OnPreRender="rv_PreRender" ControlToValidate="rbla_q" SetFocusOnError="true" ErrorMessage="לא ניתן לשנות ערכים בטופס סגור" Display="Dynamic" Type="Integer" MaximumValue="-5" MinimumValue="-5" Enabled="false" />
                            <asp:TextBox ID="TBDET_S" AutoPostBack="false"  OnTextChanged="tb_OnTextChanged" runat="server" CssClass="tbw" TextMode="MultiLine" Rows="4" Width="450px" Visible='<%#Eval("tb") <> vbnullstring %>' Text='<%#Eval("textdet") %>'></asp:TextBox>
                            <asp:Button ID="btndtsave" runat="server" Text="שמירת הטקסט החופשי" Visible="false" /> 
<%--                        </ContentTemplate>
                    </asp:UpdatePanel>
--%>                </td>
               <td runat="server" style='<%# Eval("Answerstyle") & "border-top:1px Gray solid;width:5%" %>' visible='<%#If(Eval("IsGroupHeader")=1 Or Eval("FullWidthQuestion")=1,False,True) %>' >
                            <asp:Button ID="btnCancel" runat="server" Text="בטל" Visible="false" OnClick="btnCancel_Click" />
							 <asp:Label runat="server" ID="lblCancel" Text='<%# Chr(160) %>' visible='<%#If(Eval("IsGroupHeader")=1 Or Eval("FullWidthQuestion")=1,False,True) %>' /> </div>
				 </td>
            </tr>
        </tbody>
    </ItemTemplate>
</asp:ListView>
</div>
<div runat="server" id="divlvp" visible="false">
    <asp:ListView ID="lv_p" runat="server" DataSourceID="dslvq">
        <LayoutTemplate>
            <table width="100%">
                <asp:PlaceHolder ID="itemPlaceHolder" runat="server" />
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tbody>
                <tr>
                    <td style='<%#Eval("style") %>'>
                        <asp:Label ID="lbltxt" runat="server" Text='<%#Eval("txt")%>' Width="100%" ></asp:Label>
                    </td>
                </tr>
            </tbody>
        </ItemTemplate>
    </asp:ListView>  
</div>   
 <%-- </asp:Panel>
 --%> <div>
    <table width="100%">
        <tr>
            <td width="100%" />
            <td>
                <asp:Button ID="Button1A" runat="server" Text="הפרק הראשון" Visible="false" />
            </td>
            <td>
                <asp:Button ID="Button2A" runat="server" Text="הפרק הקודם" Visible="true" />
            </td>
            <td>
                <asp:Button ID="Button3A" runat="server" Text="הפרק הבא" Visible="true" />
            </td>
            <td>
                <asp:Button ID="Button4A" runat="server" Text="הפרק האחרון" Visible="false" />
            </td>
            <td>
               <asp:Button runat="server" Text="שליחה למערכת"  ID="btncls0" Height="35"  
                    Font-Bold="true" Font-Size="Medium" ForeColor="Black" BackColor="#AAAAAA"
                      onclick="BTNCLS_Click" />
            </td>
        </tr>
    </table>
  </div>
</div>
  <div>
    <asp:TreeView ID="TVGROUPS" runat="server"
        RootNodeStyle-Font-Size="XX-Small" RootNodeStyle-ForeColor="Transparent"  RootNodeStyle-Font-Bold="true" ShowExpandCollapse="false" ForeColor="Transparent" Font-Size="XX-small"
        AutoGenerateDataBindings="false" ExpandDepth="0">
                <RootNodeStyle Font-Size="XX-Small"></RootNodeStyle>
        <NodeStyle Font-Underline="false" />
    </asp:TreeView>
    <asp:SqlDataSource ID="dslvq" runat="server" 
    ConnectionString="<%$ ConnectionStrings:Book10VPS %>" SelectCommand="SV_lvqblk" 
        SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="FormID" SessionField="FormNO" />
            <asp:QueryStringParameter Name="SurveyID" QueryStringField="S" />
            <asp:ControlParameter ControlID="TVGROUPS" Name="grp" 
                PropertyName="SelectedValue" Type="string" />
        </SelectParameters>
</asp:SqlDataSource>
  <asp:SqlDataSource ID="DSSERVICES" runat="server" 
    ConnectionString="<%$ ConnectionStrings:Book10VPS %>" SelectCommand="SELECT x.ServiceID as SID1,x.ServiceName AS SN1,z.ServiceID AS SID2,z.ServiceName as SN2
                                                                        FROM (SELECT * FROM (
                                                                        Select ServiceID,ServiceName,ROW_NUMBER() OVER(Order by ServiceID) as N
                                                                        From ServiceList
                                                                        WHERE ServiceID in (SELECT DISTINCT ServiceID From SV_vSurvey_Frames Where SurveyID=@SurveyID) ) a
                                                                        WHERE  n % 2 = 1) x
                                                                        left outer join (
                                                                        SELECT * FROM ( SELECT * FROM (
                                                                        Select ServiceID,ServiceName,ROW_NUMBER() OVER(Order by ServiceID) as N
                                                                        From ServiceList
                                                                        WHERE ServiceID in (SELECT DISTINCT ServiceID From SV_vSurvey_Frames Where SurveyID=@SurveyID) ) a
                                                                        WHERE  n % 2 = 0) y )z ON z.N=x.N+1">
    <SelectParameters>
        <asp:QueryStringParameter DefaultValue="8" Name="SurveyID" 
            QueryStringField="S" />
    </SelectParameters>
</asp:SqlDataSource>
</div>
 </div>
 <input type="button" value="חזרה למערכת" onclick="window.open('default.aspx','_self');" style="position:fixed;top:20px;right:830px;" />
 </asp:Content>

