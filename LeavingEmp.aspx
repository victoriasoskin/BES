<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="LeavingEmp.aspx.vb" Inherits="LeavingEmp" EnableEventValidation="false" %>
<%@ Register TagPrefix="topyca" TagName="CheckID" Src="~/Controls/CheckID.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
<%@ Register TagPrefix="topyca" TagName="Phone" Src="~/Controls/Phone.ascx" %>
<%@ Register TagPrefix="topyca" TagName="TBEmail" Src="~/Controls/TBEmail.ascx" %>
<%@ Register TagPrefix="ajaxtoolkit" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="scrp" />
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
        border:2px groove Gray;
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
        font-family:Arial;
        background-color: White;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        width:120px;
    }
    .divemail
    {
        background-color: #ececec;
        width:126px;
        white-space:nowrap;
    }
    .ddlw121231
    {
        background-color: #ececec;
        width:125px;
        border-style:groove;
        border-color:Gray;
    }
    .tdr
    {
        padding-right:10px;
        padding-top:5px;
    }
    .tdro
    {
        border-bottom:1px groove #AAAAAA;
        white-space:nowrap;
    }
    .shf
    {
        background-color: #eaeaea;
        width:104px;
        border:2px inset #EEEEEE;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
     .ddl
     {
         border:2px inset #EEEEEE;
     }
</style>
<script type="text/javascript">
    function raiseHelpDivTimer(SenderID, Msg) {
        var obj = document.getElementById(SenderID);
        var objpos = findPos(obj);
        var HelpDiv = document.getElementById('HelpDiv');
        HelpDiv.style.top = objpos[1] - 55 + 'px';
        HelpDiv.style.left = objpos[0] - obj.offsetWidth/2 + 'px';
        HelpDiv.innerHTML = Msg;
        HelpDiv.style.display = 'block';
        setTimeout(function() {HelpDiv.style.display = 'none'},5000);
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
    function Count(sid,long) 
    {
        var maxlength = new Number(long); // Change number to your max length
        if (sid.value.length > maxlength) {
            sid.value = sid.value.substring(0, maxlength);
            alert(" עד " + long + " תווים");
        }
    }
</script>
<%--<asp:UpdatePanel runat="server" ID="UPD" ><ContentTemplate>
--%><div runat="server" id="divform" class="pg">
<table style="width:100%;">
    <tr>
        <td colspan="5" style="text-align:center;">
            <span class="h1">טופס סיום עבודה</span>
        </td>
    </tr>
    <tr>
        <td style="font-weight:bold;text-decoration:underline;width:70px;padding-right:10px;">
            סטטוס:
        </td>
        <td style="width:260px;">
            <asp:Label runat="server" ID="lblstatus">פניה חדשה.</asp:Label>
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

<asp:FormView ID="FVIEW" runat="server" DataKeyNames="RowID" DataSourceID="DSLE" 
            DefaultMode="Insert" >
    <EmptyDataTemplate>
        <div style="width:800px;text-align:center">
            <hr />
             <br /><br /><br /><br /><br /><br />
            <hr />
            אין נתונים להצגה&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button id="bck" style="background-color:White;" onclick="history.back();">חזור</button>
            <hr />
            </div>
    </EmptyDataTemplate>
    <%-- הוספת רשומת עובד --%>
    
    <InsertItemTemplate>
        <table class="el_table">
            <tr><td colspan="6"><hr /></td></tr>

    <%-- פרטי המסגרת --%>

            <tr class="blockHeader" >
                <td colspan="6" class="tdr">
                  פרטי המסגרת
                </td>
            </tr>
            <tr class="blockfooter">
                <td class="tdr">איזור</td>
                <td>
                    <asp:DropDownList runat="server" ID="ddlServices" DataSourceID="DSServices" TabIndex="3" DataTextField="ServiceName" DataValueField="ServiceID" AppendDataBoundItems="true" AutoPostBack ="true" CssClass="ddl">
                        <asp:ListItem Value="">בחר איזור</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label runat="server" ID="lblService" CssClass="shf" Width="120" Height="18" Visible="false" />
                </td>
                <td class="tdr">מסגרת</td>
                <td colspan="3">
                    <asp:RequiredFieldValidator runat="server" ForeColor="Red" ID="rfvFrame" ControlToValidate="ddlFrames" ErrorMessage="יש לבחור במסגרת"   Display="Dynamic" />
                   <asp:DropDownList runat="server" ID="ddlFrames" DataSourceID="DSFrames" TabIndex="5" DataTextField="FrameName" DataValueField="FrameID" AppendDataBoundItems="true" EnableViewState="false"  CssClass="ddl">
                        <asp:ListItem Value="">בחר מסגרת</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label runat="server" ID="lblFrame" CssClass="shf" Width="220" Height="18" Visible="false"  />
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
                <td>
                    <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="RFVID" ControlToValidate="tbcheckid$zzztbid" ErrorMessage="יש להקיש תעודת זהות" Display="Dynamic" />
                    <topyca:CheckID runat="server" autopostback="true" ID="tbcheckid" TableName="emplist" FieldName="מספר זהות" Text='<%# Eval("EmpID") %>' ValidateNotExist="false" TabIndex="7" OnTextChanged="tbcheckid_TextChanged" OnTBFocus="raiseHelpDivTimer(this.id,'לחץ על הכפתור בהמשך השורה לאחר הזנת תעודת הזהות.');" />
                </td>
                <td></td>
                <td colspan="3">
                    <asp:Button runat="server" ID="btnCID" Text="לאחר הקלדת תעודת הזהות, לחץ להצבת פרטי העובד בטופס" ToolTip="בדוק והצג נתוני העובד" CausesValidation="false" OnClick="btnCID_Click" TabIndex="10" Width="370" />
                </td>
            </tr>
        
            <tr>
                <td class="tdr">
                    שם פרטי<span style="color:Red;">*</span>
                </td>
                <td>
                    <asp:RequiredFieldValidator runat="server" ForeColor="Red" ID="rfvFirstName" ControlToValidate="tbFirstName" Display="Dynamic" EnableClientScript="true" ErrorMessage="יש להקיש שם פרטי"  />
                    <asp:TextBox runat="server" ID="tbFirstName" CssClass="tbw"  Text='<%# Eval("FirstName") %>' TabIndex="20" />
                </td>
                <td class="tdr">
                    שם משפחה<span style="color:Red;">*</span>
                </td>
                <td>
                    <asp:RequiredFieldValidator runat="server" ForeColor="Red" ID="rfvlastname" ControlToValidate="tbLastName" Display="Dynamic" EnableClientScript="true" ErrorMessage="יש להקיש שם משפחה" />
                    <asp:TextBox runat="server" ID="tbLastName" CssClass="tbw"  Text='<%# Eval("LastName") %>'  TabIndex="30" />
                </td>
                <td colspan="2"></td>
            </tr>

            <tr>
                <td class="tdr">
                מס' טלפון
                </td>
                <td>
                    <topyca:Phone runat="server" Required="false" ID="tbphone"  CssClass="tbw" Text='<%# Eval("Phone") %>' Width="120" TabIndex="40" PhoneType="Line" />
                </td>
                <td class="tdr">
                    מס' סלולארי<span style="font-size:x-small;">(ארגון)</span>
                </td>
                <td>
                    <topyca:Phone runat="server" Required="false" ID="tbWorkCell"  CssClass="tbw" Text='<%# Eval("Phone") %>' Width="120" TabIndex="50" PhoneType="Cell" />
                </td>
                <td class="tdr">
                    מס טלפון<span style="color:Red;">*</span><span style="font-size:x-small;">(פרטי)</span>
                </td>
                <td>
                     <asp:RequiredFieldValidator ForeColor="Red" runat="server" ID="rfvPrivateCell" ControlToValidate="tbPrivateCell$zzztbPhone" Display="Dynamic" EnableClientScript="true" ErrorMessage="יש להקיש טלפון פרטי" />
                     <topyca:Phone runat="server" Required="true" ID="tbPrivateCell"  CssClass="tbw" Text='<%# Eval("Phone") %>' Width="120" TabIndex="60" EnableViewState="true" />
               </td>
           </tr>
            
            <tr>
                <td class="tdr">
                    כתובת Email
                </td>
                <td>
                    <topyca:TBEmail runat="server" ID="tbEmail" Width="120" Domain="b-e.org.il" TabIndex="70" Text='<%# Eval("Email") %>' />         
                </td>
                <td class="tdr">
                    תפקיד<span style="color:Red;">*</span>
                </td>
                <td>
                    <asp:RequiredFieldValidator ID="rvfJob" runat="server"  ForeColor="Red"
                        ControlToValidate="ddlJobs" Display="Dynamic" ErrorMessage="יש לבחור בתפקיד" />
                    <asp:DropDownList ID="ddlJobs" runat="server" AppendDataBoundItems="true" 
                        DataSourceID="dsJobs" DataTextField="Job" 
                        DataValueField="JobID" SelectedValue='<%# Eval("JobID") %>' TabIndex="80"  CssClass="ddl">
                        <asp:ListItem Value="">בחר תפקיד</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    &nbsp
                </td>
                <td>
                   &nbsp
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
                <td colspan="3">
                    <asp:RequiredFieldValidator runat="server" ID="RFVWL" ControlToValidate="ddlWL" ErrorMessage="יש לבחור בסיבת עזיבה"  ForeColor="Red"  Display="Dynamic" />
                    <asp:DropDownList runat="server" ID="ddlWL" DataSourceID="dsWL" DataTextField="WLDescription" DataValueField="WLID" AppendDataBoundItems="true" SlectedValue='<%# Eval("WLID") %>' Width="270" TabIndex="90"  CssClass="ddl">
                        <asp:ListItem Value="">בחר סיבה</asp:ListItem>
                    </asp:DropDownList>
               </td>
                <td class="tdr">
                    אופי המשרה<span style="color:Red;">*</span>
                </td>
                <td>
                    <asp:RequiredFieldValidator runat="server" ID="rfvJC" ControlToValidate="ddlJobCharacteristics" Display="Dynamic" ErrorMessage="יש לבחור באופי משרה" ForeColor="Red" />
                    <asp:DropDownList runat="server" ID="ddlJobCharacteristics" DataSourceID="DSJobCharac" DataTextField="JobCharacteristics" DataValueField="JobCharacteristicsID" AppendDataBoundItems="true" AutoPostBack="true"  SelectedValue='<%# Eval("JobCharacteristicID") %>' TabIndex="100"  CssClass="ddl">
                        <asp:ListItem Value="">בחר אופי משרה</asp:ListItem>
                    </asp:DropDownList>
                 </td>
            </tr>

            <tr>
                <td class="tdr">
                    תאריך תחילת עבודה<span style="color:Red;">*</span>
                </td>
                <td>
                    <asp:RequiredFieldValidator runat="server" ID="RDVST" ControlToValidate="tbStartdate$zzztbdate" ErrorMessage="יש להקליד תאריך התחלה"  ForeColor="Red"  Display="Dynamic" />
                    <topyca:TBDate runat="server" ID="tbStartdate" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("StartDate") %>' TabIndex="110" />
               </td>
                <td class="tdr">
                    פיטורין לאלתר
                </td>
                <td colspan="3">
                    <asp:CheckBox runat="server" ID="CBLeaveImmediatly"  Checked='<%# Eval("LeaveImmediatly") %>' TabIndex="120" AutoPostBack="true" />
                </td>
             </tr>

            <tr>
                <td class="tdr">
                    תאריך הודעת פיטורים/בקשת עזיבה<span style="color:Red;">*</span>
                </td>
                <td>
                  <asp:RequiredFieldValidator runat="server" ID="rfvRL" ControlToValidate="tbLeaveRequestDate$zzztbdate" ErrorMessage="יש להקליד תאריך בקשת עזיבה/הודעת פיטורין"  ForeColor="Red"  Display="Dynamic" />
                  <asp:CompareValidator runat="server" ID="CMPRVRLST" ControlToValidate="tbLeaveRequestDate$zzztbdate" ForeColor="Red" ControlToCompare="tbStartdate$zzztbdate" Display="Dynamic" ErrorMessage="תאריך בקשת עזיבה/ הודעת פיטורין צריך להיות גדול מתאריך התחלה" Operator="GreaterThanEqual" Type="Date" />
                  <topyca:TBDate runat="server" ID="tbLeaveRequestDate" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("LeaveRequestDate") %>' TabIndex="130" />
                 </td>
                <td class="tdr">
                    תאריך סיום עבודה עפ"י חוק
                </td>
                <td>
                    <asp:Label runat="server" ID="lblCalculatedLeavingDate" OnPreRender="lblCalculatedLeavingDate_PreRender"  CssClass="shf" Width="120" Height="18" />
                </td>
                <td class="tdr">
                    תאריך סיום עבודה בפועל
                </td>
                <td>
                   <asp:RequiredFieldValidator runat="server" ID="RVFAL" ControlToValidate="tbActualLeavingDate$zzztbdate" ErrorMessage="יש להקליד תאריך עזיבה בפועל"   Display="Dynamic" ForeColor="Red" />
                   <asp:CompareValidator runat="server" ForeColor="Red" ID="COMPVALBL" ControlToValidate="tbActualLeavingDate$zzztbdate" ValueToCompare="2000-1-1" Display="Dynamic" ErrorMessage="תאריך עזיבה בפועל צריך להיות גדול מתאריך לפי חוק" Operator="GreaterThanEqual" Type="Date" />
                   <topyca:TBDate runat="server" ID="tbActualLeavingDate" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("ActualLeavingDate") %>' TabIndex="140" OnPreRender="tbActualLeavingDate_PreRender" OnTBFocus="raiseHelpDivTimer(this.id,'לא פחות מתאריך סיום עבודה עפ&quot;י חוק.');" OnTextChanged="tbActualLeavingDate_TextChanged" />
                </td>
            </tr>
 
            <tr><td colspan="6"><hr /></td></tr>

            <tr>
                <td id="tdt1" class="tdr">
                    טלפון נייד של בית אקשטיין
                </td>
                <td id="tdt2">
                    <asp:CheckBox runat="server" ID="CBHasCompanyCell" AutoPostBack="true" OnCheckedChanged="CBHasCompanyCell_CheckedChanged" TabIndex="150" />  
                </td>
                <td class="tdr"  id="tdt3">
                    <asp:Label runat="server" ID="Label4" Text="מס טלפון<span style='color:Red;'>*</span>" Enabled='<%# CType(FVIEW.FindControl("CBHasCompanyCell"),Checkbox).Checked %>' />
                </td>
                <td  id="tdt4">
                    <asp:RequiredFieldValidator runat="server" ID="RFVWF" ForeColor="Red" ControlToValidate="tbWorkCellV$zzztbPhone" Display="Dynamic" ErrorMessage="יש להקליד טלפון"  Enabled='<%# CType(FVIEW.FindControl("CBHasCompanyCell"),Checkbox).Checked %>' />
                    <topyca:Phone runat="server" Required="true" ID="tbWorkCellV"  CssClass="tbw" Text='<%# Eval("Phone") %>' Width="120" TabIndex="160" PhoneType="Cell" />
               </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        
            <tr>
                <td class="tdr" id="tdm1">
                    מייל ארגוני
                </td>
                <td id="tdm2">
                    <asp:CheckBox runat="server" ID="CBWorkEmail" AutoPostBack="true" OnCheckedChanged="CBWorkEmail_CheckedChanged" TabIndex="170" />  
                </td>
                <td class="tdr" id="tdm3">
                    <asp:Label runat="server" ID="Label2" Text="מייל<span style='color:Red;'>*</span><span style='font-size:x-small;'>(ארגון)</span>" Enabled="false" />
                </td>
                <td  id="tdm4">
                    <asp:requiredfieldvalidator runat="server" ID="rfvworkemail" ControlToValidate="tbWorkEmail$zzztbemail1" ErrorMessage="יש להקליד כתובת אימייל"  Enabled="false" Display="Dynamic" ForeColor="Red" />
                    <topyca:TBEmail runat="server" ID="tbWorkEmail" Width="120" Domain="b-e.org.il" TabIndex="180" Text='<%# Eval("Workmail") %>' OnPreRender="tbWorkEmail_PreRender" />         
                  </td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td class="tdr"  id="tdm5">
                    <asp:Label runat="server" ID="label1" text="טיפול במייל<span style='color:Red;'>*</span>"  Enabled='<%# CType(FVIEW.FindControl("CBWorkEmail"),Checkbox).Checked %>' />
                </td>
                <td id="tdm6">
                    <asp:RequiredFieldValidator runat="server" ID="rfvMailAction" ControlToValidate="rblAction" Display="Dynamic" ErrorMessage="יש לבחור באופן הטיפול בכתובת הדואר האלקטרוני" ForeColor="Red" Enabled="false" />
                    <asp:RadioButtonList runat="server" ID="rblAction" RepeatDirection="vertical"  Enabled='<%# CType(FVIEW.FindControl("CBWorkEmail"),Checkbox).Checked %>' TabIndex="190" >
                        <asp:ListItem Value="1">הקפאה</asp:ListItem>
                        <asp:ListItem Value="2">סגירה</asp:ListItem>
                    </asp:RadioButtonList>

                </td>
            </tr>
           <tr>
              <td class="tdr">
                  הערות נוספות
              </td>
              <td colspan="5" class="tdr">
                 <asp:TextBox runat="server" ID="tbComment" Rows="2" Columns="100" TextMode="MultiLine" Width="600" CssClass="tbw" onKeyUp="javascript:Count(this,200);" onChange="javascript:Count(this,200);" />
              </td>
           </tr>

<%-- כפתור שליחה למערכת --%>

            <tr><td colspan="6"><hr /></td></tr>

            <tr>
                <td colspan="6" style="text-align:center">
                    <asp:Button runat="server" ID="btnSend" Text="שלח טופס" CommandName="Insert" TabIndex="200" OnClick="btnSend_Click" />
                    <asp:Button runat="server" ID="btncncl" Text="ביטול" Width="82" CommandName="Cancel" TabIndex="210" CausesValidation="false" Font-Names="Arial" />
                </td>
             </tr>
        </table>
    </InsertItemTemplate>

    <%-- הצגת פניה  --%>


    <ItemTemplate>
        <table class="el_table">
            <tr><td colspan="6"><hr /></td></tr>

 <%-- פרטי המסגרת --%>

            <tr class="blockHeader" >
                <td colspan="6" class="tdr">
                    פרטי המסגרת
                   <asp:HiddenField runat="server" ID="hdnUserName" Value='<%# Eval("UserName") %>' OnPreRender="hdnUserName_PreRender" />
                   <asp:HiddenField runat="server" ID="hdnCuserName" Value='<%# Eval("CUserName") %>' />
                   <asp:HiddenField runat="server" ID="hdnid" Value='<%# Eval("RowID") %>' />
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
              </td>
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
                    <asp:CheckBox runat="server" ID="CBHasCompanyCell" AutoPostBack="true" OnCheckedChanged="CBHasCompanyCell_CheckedChanged" Checked='<%# NOT IsDBNull(Eval("WorkCell")) %>' Enabled="false" />  
                </td>
                <td class="tdr"  id="tdt3">
                    <asp:Label runat="server" ID="Label4" Text="מס טלפון<span style='color:Red;'>*</span>" Enabled='<%# NOT IsDBNull(Eval("WorkCell")) %>' />
                </td>
                <td  id="tdt4" class="tdr">
                     <asp:Label runat="server" ID="tbWorkCell1"  Enabled='<%#  NOT IsDBNull(Eval("WorkCell")) %>'  Text='<%# Eval("WorkCell") %>' CssClass="shf" Width="120"  />
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
                    <asp:CheckBox runat="server" ID="CBWorkEmail" AutoPostBack="true" OnCheckedChanged="CBWorkEmail_CheckedChanged" Checked='<%#  NOT IsDBNull(Eval("WorkEmail"))  %>' Enabled="false" />  
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
                    <asp:RadioButtonList runat="server" ID="rblAction" RepeatDirection="Horizontal" Enabled="false" SelectedValue='<%# if(isdbnull(Eval("WorkMailActionID")),"2",Eval("WorkMailActionID")) %>' >
                        <asp:ListItem Value="1">הקפאה</asp:ListItem>
                        <asp:ListItem Value="2" Selected="True">סגירה</asp:ListItem>
                    </asp:RadioButtonList>

                </td>
            </tr>
           <tr>
              <td class="tdr">
                  הערות נוספות
              </td>
              <td colspan="5" class="tdr">
                 <asp:Label runat="server" ID="lblComment" Text='<% #Eval("Comment") %>' />
              </td>
           </tr>

<%-- כפתור שליחה למערכת --%>
*
            <tr><td colspan="6"><hr /></td></tr>

            <tr>
                <td colspan="6" style="text-align:center;height:20px;">
                    <button id="bck" style="background-color:White;" onclick="history.back();">חזור</button>
                </td>
             </tr>
        </table>
    </ItemTemplate>
</asp:FormView>
    
     <asp:SqlDataSource ID="DSLE" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        InsertCommand="INSERT INTO [EL_LeavingEmps] ([EmpID], [FirstName], [LastName], [FrameID], [JobID], [Phone], [WorkCell], [WorkCellV], [PrivateCell], [WLID], [StartDate], [JobCharacteristicsID], [LeaveRequestDate], [CalculatedLeavingDate], [ActualLeavingDate], [LeaveImmediatly], [Email], [WorkEmail], [WorkMailActionID],[Loadtime],[UserID],Comment) VALUES (@EmpID, @FirstName, @LastName, @FrameID, @JobID, @Phone, @WorkCell, @WorkCellV,@PrivateCell, @WLID, @StartDate, @JobCharacteristicsID, @LeaveRequestDate, @CalculatedLeavingDate, @ActualLeavingDate, @LeaveImmediatly, @Email, @WorkEmail, @WorkMailActionID,GETDATE(),@UserID,@Comment)" 
        SelectCommand="SELECT e.RowID, e.EmpID, e.FirstName, e.LastName, e.FrameID, e.JobID, j.Job, e.Phone, e.WorkCell, e.WorkCell,e.PrivateCell, e.WLID, w.WLDescription As WL, e.StartDate, e.JobCharacteristicsID, jc.JobCharacteristics, e.LeaveRequestDate, e.CalculatedLeavingDate, e.ActualLeavingDate, e.LeaveImmediatly, e.Email, e.WorkEmail, e.WorkMailActionID, e.Loadtime, e.UserID, e.Status, f.FrameName, s.ServiceName, w.WLDescription, ISNULL(u.URName,u.UserName) AS UserName, ISNULL(cu.URName,cu.UserName) AS CUsername,e.Comment FROM EL_LeavingEmps AS e LEFT OUTER JOIN FrameList AS f ON f.FrameID = e.FrameID LEFT OUTER JOIN ServiceList AS s ON s.ServiceID = f.ServiceID LEFT OUTER JOIN EL_WL AS w ON w.WLID = e.WLID LEFT OUTER JOIN p0t_NtB AS u ON u.UserID = e.UserID LEFT OUTER JOIN p0t_NtB AS cu ON cu.UserID = e.cUserID LEFT OUTER JOIN  EL_JobCharacteristics jc on jc.JobCharacteristicsID = e.JobCharacteristicsID LEFT OUTER JOIN EL_Jobs j on j.JobID = e.JobID WHERE (e.EmpID = @EmpID) AND e.FrameID IN (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE UserID = @UserID)" >
      <InsertParameters>
          <asp:Parameter Name="EmpID" Type="Int32" />
          <asp:Parameter Name="FirstName" Type="String" />
          <asp:Parameter Name="LastName" Type="String" />
          <asp:Parameter Name="FrameID" Type="Int32" />
          <asp:Parameter Name="JobID" Type="Int32" />
          <asp:Parameter Name="Phone" Type="String" />
          <asp:Parameter Name="WorkCell" Type="String" />
          <asp:Parameter Name="WorkCellV" Type="String" />
          <asp:Parameter Name="PrivateCell" Type="String" />
          <asp:Parameter Name="WLID" Type="Int32" />
          <asp:Parameter Name="StartDate" Type="DateTime" />
          <asp:Parameter Name="JobCharacteristicsID" Type="Int32" />
          <asp:Parameter Name="LeaveRequestDate" Type="DateTime" />
          <asp:Parameter Name="CalculatedLeavingDate" Type="DateTime" />
          <asp:Parameter Name="ActualLeavingDate" Type="DateTime" />
          <asp:Parameter Name="LeaveImmediatly" Type="Boolean" />
          <asp:Parameter Name="Email" Type="String" />
          <asp:Parameter Name="WorkEmail" Type="String" />
          <asp:Parameter Name="WorkMailActionID" Type="Int32" />
          <asp:Parameter Name="UserID" Type="Int32" />
          <asp:Parameter Name="Comment" Type="string" />
     </InsertParameters>
      <SelectParameters>
          <asp:QueryStringParameter Name="EmpID" QueryStringField="E" Type="Int32" />
          <asp:SessionParameter Name="UserID" SessionField="UserID" />
      </SelectParameters>
    </asp:SqlDataSource>
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
 <asp:SqlDataSource ID="dsJobCharac" runat="server"
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [JobCharacteristics], [JobCharacteristicsID] FROM [EL_JobCharacteristics]">
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="DSFrames" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            SelectCommand="SELECT FrameName, FrameID FROM FrameList WHERE (ServiceID = @ServiceID) AND FrameID in (SELECT FrameID FROM dbo.p0v_UserFrameList WHERE (UserID = @UserID))">
            <SelectParameters>
                <asp:Parameter Name="ServiceID" />
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
    <asp:ValidationSummary ID="VS" runat="server" ShowMessageBox="true" ShowSummary="false" />
    <asp:SqlDataSource ID="dsJobs" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [Job], [JobID] FROM [EL_Jobs] ORDER BY [Job]">
    </asp:SqlDataSource>
</div>
<div runat="server" id="divmsg" visible="false">
    <asp:Label runat="server" ID="lblmsg" style="text-align:right;"></asp:Label><br /><br />
    <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" /><asp:Button runat="server" ID="btnTwo" Text="ביטול" CausesValidation="false" Visible="false" />
</div>
<div id="HelpDiv" style="display:none;background:#FFFFC1;width:150px;height:50px;position:absolute;border:1px solid Gray; padding:2px;">
</div>
<%--</ContentTemplate></asp:UpdatePanel>
--%>    <%-- הוספת רשומת עובד --%>
</asp:Content>

