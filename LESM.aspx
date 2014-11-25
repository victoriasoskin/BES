<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="LESM.aspx.vb" Inherits="LESM" %>
<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="~/Controls/TreeDropDown.ascx"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="scrp" />
    <script src="jquery-1.7.1.js" type="text/javascript">
 </script><style type="text/css">
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
        border-style:outset
        ;
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
    .tbl  td
    {
        padding-right:10px;
    }
    th
    {
        background-color:#AAAAAA;
        border-bottom:1px solid black;
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
        width:330px;
    }
    .shf
    {
        background-color: #eaeaea;
        width:104px;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
        min-height:15px;
     }
   
</style>
<script type="text/javascript">
    function raiseHelpDivTimer(SenderID, Msg) {
        var obj = document.getElementById(SenderID);
        var objpos = findPos(obj);
        var HelpDiv = document.getElementById('HelpDiv');
        HelpDiv.style.top = objpos[1] - 85 + 'px';
        HelpDiv.style.left = objpos[0] + 'px';
        HelpDiv.innerHTML = Msg;
        HelpDiv.style.display = 'block';
        setTimeout(function () { HelpDiv.style.display = 'none' }, 5000);
    }
    function findPos(obj) {
        var curleft = curtop = 0;
        if (obj.offsetParent) {
            curleft = obj.offsetLeft
            curtop = obj.offsetTop
            while (obj = obj.offsetParent) {
                curleft += obj.offsetLeft
                curtop += obj.offsetTop
            }
        }
        return [curleft, curtop];
    }
    function shp()
    {
        $("p", "#divfvform").fadeOut(1000);
    } 
</script>
<%--<asp:UpdatePanel runat="server" ID="UPD" ><ContentTemplate></ContentTemplate></asp:UpdatePanel>
--%><div runat="server" id="divform" class="pg">
<table style="width:100%;">
    <tr>
        <td colspan="5" style="text-align:center;">
            <span class="h1">טופס סיכום ראיון סיום עבודה</span>
        </td>
    </tr>
    <tr>
        <td style="font-weight:bold;text-decoration:underline;width:70px;padding-right:10px;">
            סטטוס:
        </td>
        <td style="width:260px;">
            <asp:Label runat="server" ID="lblstatus"></asp:Label>
        </td>
        <td style="width:160px;">
            &nbsp
        </td>
       <td style="width:70px;">
            תאריך:
        </td>
        <td style="width:50px;">
            <%=Format(Now(),"dd/MM/yyyy") %>
        </td>
      </tr>
    <tr>
        <td style="font-weight:bold;text-decoration:underline;padding-right:10px;">
            מספר פניה:
        </td>
        <td>
            <asp:Label runat="server" ID="lblid" />
        </td>
        <td>
        </td>
        <td>
           שם משתמש:
        </td>

       <td>
            <%= Session("UserName") %>
        </td>
      </tr>
 </table>
<hr />
<div style="vertical-align:middle;width:100%">
    <table style="width:100%">
        <tr>
            <td>
                &nbsp;<asp:TextBox runat="server" ID="tbSearch" CssClass="tbw" Width="300" />&nbsp;<asp:Button runat="server" ID="btnSearch" Text="חפש" Height="22" />&nbsp;<asp:Button runat="server" ID="btnClear" Text="הכל" Height="22" Width="35" />
            </td>
            <td style="width:110px;font-weight:bold;">בחר סטטוס בקשה:</td>
            <td style="width:60px;">
                <asp:DropDownList runat="server" ID="ddlStatus" AutoPostBack="true"  style="float:left;">
                    <asp:ListItem Value="0">פתוח</asp:ListItem>
                    <asp:ListItem Value="1">סגור</asp:ListItem>
                    <asp:ListItem Value="2">הכל</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    </div>
<hr />
<asp:SqlDataSource ID="DSEMPS" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SearchEL" CancelSelectOnNullParameter="False" 
            SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:ControlParameter ControlID="tbSearch" Name="Str" PropertyName="Text" 
            Type="String" />
        <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        <asp:ControlParameter ControlID="ddlStatus" Name="Status" 
            PropertyName="SelectedValue" Type="Int32" />
    </SelectParameters>
        </asp:SqlDataSource>

<asp:ListView ID="LVEMP" runat="server" DataSourceID="DSEMPS">
    <LayoutTemplate>
        <table class="tbl">
            <thead>
                <th></th>
                <th>
                    <asp:LinkButton runat="server" ID="Linkbutton1" CommandName="Sort" CommandArgument="FirstName" style="color:Black;">שם פרטי</asp:LinkButton>
                </th>
                <th>
                    <asp:LinkButton runat="server" ID="Linkbutton2" CommandName="Sort" CommandArgument="LAstName" style="color:Black;">שם משפחה</asp:LinkButton>
                </th>
                <th>
                    <asp:LinkButton runat="server" ID="Linkbutton3" CommandName="Sort" CommandArgument="EmpID" style="color:Black;">תעודת זהות</asp:LinkButton>
                </th>
                <th>
                    <asp:LinkButton runat="server" ID="Linkbutton4" CommandName="Sort" CommandArgument="FrameName" style="color:Black;">מסגרת</asp:LinkButton>
                </th>
               <th>
                    <asp:LinkButton runat="server" ID="Linkbutton5" CommandName="Sort" CommandArgument="Status" style="color:Black;">סטטוס</asp:LinkButton>
                </th>
            </thead>
            <tr ID="itemPlaceholder" runat="server">
            </tr>
        </table>
    </LayoutTemplate>
    <ItemTemplate>
        <tr>
            <td style="width:20px;padding-right:0px;">
                <asp:Button runat="server" ID="btnFill" Text="טופס" OnClick="btnFill_Click" Height="20" Font-Size="Smaller" OnPreRender="btnFill_PreRender" />
            </td>
            <td>
                 <asp:Label runat="server" ID="lblFirstName" Text='<%# Eval("FirstName") %>' />
           </td>
             <td>
                <asp:Label runat="server" ID="lblLastName" Text='<%# Eval("LastName") %>' />
            </td>
            <td>
               <asp:Label runat="server" ID="lblEmpID" Text='<%# Eval("EmpID") %>' />
             </td>
            <td>
                <asp:Label runat="server" ID="lblFrameName" Text='<%# Eval("FrameName") %>' />
            </td>
            <td>
                <asp:Label runat="server" ID="Label3" Text='<%# Eval("Status") %>' />
            </td>
        </tr>
    </ItemTemplate>
    <EmptyDataTemplate>
        אין נתונים להצגה
    </EmptyDataTemplate>
</asp:ListView>

<div style="width:100%;height:2px;background:White;"></div>

<asp:FormView ID="FVIEW" runat="server" DataKeyNames="RowID" DataSourceID="DSLE" 
            DefaultMode="ReadOnly" >
 
<%-- הצגת פניה  --%>


    <ItemTemplate>
        <table class="el_table">

 <%-- פרטי המסגרת --%>

            <tr class="blockHeader" >
                <td colspan="6" class="tdr">
                    פרטי המסגרת
                   <asp:HiddenField runat="server" ID="hdnUserName" Value='<%# Eval("UserName") %>' OnPreRender="hdnUserName_PreRender" />
                   <asp:HiddenField runat="server" ID="hdnCuserName" Value='<%# Eval("CUserName") %>' />
                   <asp:HiddenField runat="server" ID="hdnid" Value='<%# Eval("RowID") %>' />
                   <asp:HiddenField runat="server" ID="hdnFormID" Value='<%# Eval("FormID") %>' />
              </td>
            </tr>
            <tr class="blockfooter">
                <td class="tdr">
                    אזור
                 </td>
                <td class="tdr">
                     <asp:Label runat="server" ID="lblServiceName" Text='<%# Eval("ServiceName") %>' CssClass="shf" Width="120"  />
                 </td>
                <td class="tdr">
                    מסגרת
                </td>
                <td class="tdr" colspan="3">
                    <asp:Label runat="server" ID="lblFrameName" Text='<%# Eval("FrameName") %>' CssClass="shf" Width="280"   />
                </td>
             </tr>
            <tr><td colspan="6"><hr /></td></tr>
 
 <%-- פרטי העובד --%>

            <tr class="blockHeader" >
                <td colspan="6" class="tdr">
                   פרטי העובד
                </td>
            </tr>
 
            <tr>
                <td class="tdr">
                    ת.ז.<span style="color:Red;">*</span><span style="font-size:smaller;">(כולל ספרת בקורת)</span>
                </td>
                <td class="tdr">
                    <asp:Label runat="server" ID="tbcheckid" Text='<%# Eval("EmpID") %>'  CssClass="shf" Width="120"  />
                </td>
             </tr>
             <tr>
                <td class="tdr">
                    שם פרטי<span style="color:Red;">*</span>
                </td>
                <td class="tdr">
                    <asp:Label runat="server" ID="tbFirstName" CssClass="shf" Width="120" Text='<%# Eval("FirstName") %>' />
                </td>
                <td class="tdr">
                    שם משפחה<span style="color:Red;">*</span>
                </td>
                <td class="tdr">
                    <asp:Label runat="server" ID="tbLastName" CssClass="shf" Width="120" Text='<%# Eval("LastName") %>' />
                </td>
                <td colspan="2"></td>
             </tr>
        
            <tr>
                <td class="tdr">
                    מס' טלפון
                </td>
                <td class="tdr">
                    <asp:Label runat="server" ID="tbPhone" Text='<%# Eval("Phone") %>' CssClass="shf" Width="120" />
                </td>
                <td class="tdr">
                    מס' סלולארי<span style="font-size:x-small;">(ארגון)</span>
                </td>
                <td class="tdr">
                    <asp:Label runat="server" ID="orkCell" Text='<%# Eval("WorkCell") %>' CssClass="shf" Width="120"   />
                </td>
                <td class="tdr">
                    מס' סלולארי<span style="color:Red;">*</span><span style="font-size:x-small;">(פרטי)</span>
                </td>
                <td class="tdr">
                     <asp:Label runat="server" ID="tbPrivateCell" Text='<%# Eval("PrivateCell") %>'  CssClass="shf" Width="120"  />
               </td>
           </tr>

           <tr>
              <td class="tdr">
                  כתובת Email
              </td>
              <td class="tdr">
                   <asp:Label runat="server" ID="tbemail1_1" Text='<%# Eval("Email") %>'  CssClass="shf" Width="120" style="direction:ltr;" />
              <td class="tdr">
                  תפקיד<span style="color:Red;">*</span>
              </td>
              <td class="tdr">
                    <asp:Label runat="server" ID="ddlJobs" Text='<%# Eval("Job") %>'  CssClass="shf" Width="120"  />
               </td>
              <td>
                  &nbsp;
              </td>
              <td>
                  &nbsp;
              </td>
            </tr>
            <tr><td colspan="6"><hr /></td></tr>

 <%-- מועד סיום עבודה  --%>
 
            <tr>
                <td colspan="6" class="blockHeader">
                    מועד סיום עבודה
                </td>
            </tr>

            <tr>
                <td class="tdr">
                    סיבת עזיבה<span style="color:Red;">*</span>
                </td>
                <td class="tdr" colspan="3">
                    <asp:Label runat="server" ID="tddWL" Text='<%# Eval("WL") %>'  CssClass="shf" />
                 </td>
                  <td class="tdr">
                    אופי המשרה<span style="color:Red;">*</span>
                </td>
                <td class="tdr">
                     <asp:Label runat="server" ID="ddlJobCharacteristics" Text='<%# Eval("JobCharacteristics") %>'  CssClass="shf" Width="120"   />
                </td>
            </tr>

            <tr>
               <td class="tdr">
                    תאריך תחילת עבודה<span style="color:Red;">*</span>
                </td>
                <td class="tdr">
                   <asp:Label runat="server" ID="tbStartdate" Text='<%# Eval("StartDate","{0:dd/MM/yyyy}") %>'  CssClass="shf" Width="120"  />
               </td>
                <td class="tdr">
                    פיטורין לאלתר
                </td>
                <td colspan="3" class="tdr">
                    <asp:CheckBox runat="server" ID="CBLeaveImmediatly"  Checked='<%# Eval("LeaveImmediatly") %>' Enabled="false"  />
                </td>
            </tr>
 
            <tr>
                  <td class="tdr">
                    תאריך הודעת פיטורים/בקשת עזיבה<span style="color:Red;">*</span>
                </td>
                <td class="tdr">
                   <asp:Label runat="server" ID="tbLeaveRequestDate" Text='<%# Eval("LeaveRequestDate","{0:dd/MM/yyyy}") %>' CssClass="shf" Width="120"  />
                 </td>
                <td class="tdr">
                    תאריך סיום עבודה עפ"י חוק
                </td>
                <td class="tdr">
                   <asp:Label runat="server" ID="lblCalculatedLeavingDate" Text='<%# Eval("CalculatedLeavingDate","{0:dd/MM/yyyy}") %>' CssClass="shf" Width="120"   />
                </td>
                <td class="tdr">
                    תאריך סיום עבודה בפועל
                </td>
                <td class="tdr">
                   <asp:Label runat="server" ID="tbActualLeavingDate" Text='<%# Eval("ActualLeavingDate","{0:dd/MM/yyyy}") %>' CssClass="shf" Width="120"  />
                </td>
            </tr>

            <tr><td colspan="6"><hr /></td></tr>

            <tr>
                <td id="tdt1" class="tdr">
                    טלפון נייד של בית אקשטיין
                </td>
                <td id="tdt2" class="tdr">
                    <asp:CheckBox runat="server" ID="CBHasCompanyCell" AutoPostBack="true" Checked='<%# NOT IsDBNull(Eval("WorkCellV")) %>' Enabled="false" />  
                </td>
                <td class="tdr"  id="tdt3">
                    <asp:Label runat="server" ID="Label4" Text="מס טלפון<span style='color:Red;'>*</span>" Enabled='<%# NOT IsDBNull(Eval("WorkCellV")) %>' />
                </td>
                <td  id="tdt4" class="tdr">
                     <asp:Label runat="server" ID="tbWorkCell1"  Enabled='<%#  NOT IsDBNull(Eval("WorkCellV")) %>'  Text='<%# Eval("WorkCellV") %>' CssClass="shf" Width="120"  />
               </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        
            <tr>
                <td class="tdr"id="tdm1">
                    מייל ארגוני
                </td>
                <td id="tdm2" class="tdr">
                    <asp:CheckBox runat="server" ID="CBWorkEmail" AutoPostBack="true" Checked='<%#  NOT IsDBNull(Eval("WorkEmail"))  %>' Enabled="false" />  
                </td>
                <td class="tdr" id="tdm3">
                    <asp:Label runat="server" ID="Label2" Text="מייל<span style='color:Red;'>*</span><span style='font-size:x-small;'>(ארגון)</span>" Enabled='<%# NOT IsDBNull(Eval("WorkEmail")) %>'  />
                </td>
                <td  id="tdm4" class="tdr">
                   <asp:Label runat="server" ID="tbemail2_2" Text='<%# Eval("WorkEmail") %>' CssClass="shf" Width="120"  style="direction:ltr;"  />
                 </td>
                <td class="tdr"  id="tdm5">
                    <asp:Label runat="server" ID="label1" text="פעולה<span style='color:Red;'>*</span>" Enabled='<%# NOT IsDBNull(Eval("WorkEmail")) %>' />
                </td>
                <td id="tdm6" class="tdr">
                    <asp:RadioButtonList runat="server" ID="rblAction" RepeatDirection="Horizontal" Enabled="false" SelectedValue='<%# If(ISDBNull(Eval("WorkMailActionID")),2,Eval("WorkMailActionID")) %>' >
                        <asp:ListItem Value="1">הקפאה</asp:ListItem>
                        <asp:ListItem Value="2" Selected="True">סגירה</asp:ListItem>
                    </asp:RadioButtonList>

                </td>
            </tr>
           <tr>
                <td id="tdm1" class="tdr">
                    הערות נוספות
                </td>
                <td id="tdm2" class="tdr" colspan="5">
                    <asp:Label runat="server" ID="lblComment" Text='<%#Eval("Comment") %>' Height="36" Width="681" CssClass="shf" />
                </td>           
            </tr>
         </table>
    </ItemTemplate>
</asp:FormView>

<div style="width:100%;height:2px;background:White;border-bottom:1px inset;"></div>

<asp:ListView ID="LVFORM" runat="server" Visible="false" >
    <LayoutTemplate>
        <table class="tbl">

            <thead>
            <tr>
                <td colspan="3" class="blockHeader" style="padding-right:20px;">
                    סיכום הראיון
                </td>
            </tr>
                <tr>
                    <td colspan="3" style="font-weight:bold;text-decoration:underline;border-bottom:1px outset #AAAAAA;height:30px;">
                        לפני תחילת השיחה: האם העברת מכתב התפטרות או קבלת מכתב פיטורין?
                    </td>
                </tr>
              </thead>
            <tr ID="itemPlaceholder" runat="server">
            </tr>
            <tr>
                 <td colspan="3" style="text-align:center">
                    <asp:Button runat="server" ID="btnSend" Text="שלח טופס" TabIndex="220" OnClick="btnSend_Click" />
                    <asp:Button runat="server" ID="btncncl" Text="ביטול" Width="82" TabIndex="230" CausesValidation="false" OnClick="btncncl_Click" />
                </td>
            </tr>
        </table>
    </LayoutTemplate>
    <ItemTemplate>
        <tr>
            <td class="tdid">
                <asp:label runat="server" ID="lblid" text='<%#Format(Cint(Eval("id")),"#") %>' />
                <asp:HiddenField runat="server" ID="hdnid" Value='<%#Eval("id")%>' />
            </td>
            <td class="tdq">
                <%#Eval("txt")%>
            </td>
            <td class="tda">
                <asp:HiddenField runat="server" ID="HDNCNTRL" Value='<%# Eval("cntrl") %>' />
                <asp:RadioButtonList ID="rbla_q" onclick='thisrow(this)'  AutoPostBack="false" AppendDataBoundItems="true" runat="server" RepeatDirection="Horizontal" DataTextField="txt" Font-Size="X-Small" RepeatLayout="Table" DataValueField="val"  >
                </asp:RadioButtonList>
   		        <asp:TextBox ID="TBDET_S" AutoPostBack="false"   runat="server" TextMode="MultiLine" Rows="2" Visible='<%#Eval("cntrl") = "textbox" %>' width="300"></asp:TextBox>
                <asp:DropDownList runat="server" ID="ddl" CssClass="ddlw" DataSourceID="dsWL" DataTextField="WLDescription" DataValueField="WLID" AppendDataBoundItems="true" Width="270" TabIndex="90" Visible='<%#Eval("cntrl") = "ddl" %>'  >
                    <asp:ListItem Value="">בחר סיבה</asp:ListItem>
                </asp:DropDownList>
                <asp:Label runat="server" ID="lblDsc" Visible='<%#Eval("cntrl") = "label" %>' Text='<%#Eval("txt") %>' />
            </td>
        </tr>
    </ItemTemplate>
    <EmptyDataTemplate>
    </EmptyDataTemplate>
</asp:ListView>

<asp:SqlDataSource ID="DSLE" runat="server"  CancelSelectOnNullParameter="true"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
         SelectCommand="SELECT e.RowID, e.EmpID, e.FirstName, e.LastName, e.FrameID, e.JobID, j.Job, e.Phone, e.WorkCell, e.WorkCellV,e.PrivateCell, e.WLID, w.WLDescription As WL, e.StartDate, e.JobCharacteristicsID, jc.JobCharacteristics, e.LeaveRequestDate, e.CalculatedLeavingDate, e.ActualLeavingDate, e.LeaveImmediatly, e.Email, e.WorkEmail, e.WorkMailActionID, e.Loadtime, e.UserID, e.Status, f.FrameName, s.ServiceName, w.WLDescription, ISNULL(u.URName,u.UserName) AS UserName, ISNULL(cu.URName,cu.UserName) AS CUsername, frm.FormID,e.Comment FROM EL_LeavingEmps AS e LEFT OUTER JOIN EL_Forms AS frm ON frm.EmpID = e.EmpID LEFT OUTER JOIN FrameList AS f ON f.FrameID = e.FrameID LEFT OUTER JOIN ServiceList AS s ON s.ServiceID = f.ServiceID LEFT OUTER JOIN EL_WL AS w ON w.WLID = e.WLID LEFT OUTER JOIN p0t_NtB AS u ON u.UserID = e.UserID LEFT OUTER JOIN p0t_NtB AS cu ON cu.UserID = e.cUserID LEFT OUTER JOIN  EL_JobCharacteristics jc on jc.JobCharacteristicsID = e.JobCharacteristicsID LEFT OUTER JOIN EL_Jobs j on j.JobID = e.JobID WHERE (e.EmpID = CASE ISNUMERIC(@EmpID) WHEN 1 THEN CAST(@EmpID AS int) ELSE NULL END) AND e.FrameID IN (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE UserID = @UserID)" >
    <SelectParameters>
        <asp:ControlParameter Name="EmpID" ControlID="tbSearch" Type="String" PropertyName="Text" />
        <asp:SessionParameter Name="UserID" SessionField="UserID" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="DSWL" runat="server" 
    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
    SelectCommand="SELECT [WLID],[WLDescription] FROM [EL_WL] WHERE Parent&gt;1 order by WLID">
</asp:SqlDataSource>

<div id="HelpDiv" style="display:none;background:#FFFFC1;width:150px;height:50px;position:absolute;border:1px solid Gray; padding:2px;">
</div>
</div>
<div runat="server" id="divmsg" visible="false">
    <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
    <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" /><asp:Button runat="server" ID="btnTwo" Text="ביטול" CausesValidation="false" Visible="false" />
</div>
</asp:Content>



