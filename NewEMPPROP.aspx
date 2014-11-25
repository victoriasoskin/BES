<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="NewEMPPROP.aspx.vb" Inherits="NewEMPPROP" MaintainScrollPositionOnPostback="true" %>
<%@ Register TagPrefix="topyca" TagName="SelectFrame" Src="~/Controls/SelectFrame.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="CheckID" Src="~/Controls/CheckID.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="TBDate" Src="~/Controls/TBDATE.ascx" %>
<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="~/Controls/TreeDropDown.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="" CausesValidation="false" Visible="false" />
    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <script type="text/javascript">        function IsValid(str) {
            mystring = str;

            if (mystring.match(/^\d{9}\.\d{4}$/)) {
                alert("Valid");
            }
            else {
                alert("Invalid"); 
            }
        }

</script>
<div style="width:500px;">
    <div class="hdrdiv"><asp:Label runat="server" ID="lblhdr" Text="בקשה להכנת הצעת עבודה" Width="500" /></div>
<div>
    <table>
        <tr>
            <td>
                <asp:Label runat="server" ID="stam" hight="1" Width="250" />
                <topyca:SelectFrame runat="server" ID="Sfrm" />
                <asp:Label runat="server" ID="lblerrframe" Text="חובה לבחור מסגרת" Visible="false" ForeColor="Red" />
           </td>
            <td>
                <asp:SqlDataSource runat="server" ID="dsEmpList"
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    
                    SelectCommand="SELECT LastName + ' ' + FirstName AS Name, EmpID FROM p6t_Emps WHERE (Status=1) AND (FrameID = isnull(@FrameID,FrameID)) Order by LastName + ' ' + FirstName" 
                    CancelSelectOnNullParameter="False" >
                    <SelectParameters>
                        <asp:ControlParameter ControlID="Sfrm" Name="FrameID" 
                            PropertyName="SelectedFrame" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DropDownList ID="DDLEMPS" runat="server" AppendDataBoundItems="True"
                    AutoPostBack="True" DataSourceID="dsEmpList" DataTextField="Name" 
                    DataValueField="EmpID" >
                        <asp:ListItem Text="[עובד חדש]" Value="-1" />
                </asp:DropDownList>
            </td>
        </tr>
    </table>
 </div>
<div class="reldiv" style="border-bottom-style:inset">
    <asp:ListView ID="LVEMPS" runat="server" DataKeyNames="EmpID" 
        DataSourceID="DSEMPS" EnableModelValidation="True" 
        InsertItemPosition="FirstItem">
        <EditItemTemplate>
            <td id="Td1" runat="server" style="" valign="top">
                <table>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label12" runat="server" Text="תעודת זהות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                     <topyca:CheckID runat="server" ID="tbcheckid" TableName="p6t_emps" FieldName="EmpID" Text='<%# Eval("EmpID") %>' OnTextChanged="tbcheckid_TextChanged" ValidateNotExist="false" />
                                     <asp:Label runat="server" ID="lblerrempid" Text="חובה להקיש תעודת זהות" ForeColor="Red" Visible="false" />
                                     </td>
                                </tr>
                            </table>
                        </td>
                      <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label13" runat="server" Text="שם פרטי" Width="155" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbFirstName" Text='<%# Eval("FirstName") %>'  />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvFirstName" ForeColor="Red" ControlToValidate="tbFirstName" Display="Dynamic" ErrorMessage="חובה להקיש שם פרטי" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label14" runat="server" Text="שם משפחה" Width="155" />
                                    </td>

                                </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbLastname" Text='<%# Eval("LastName") %>' Width="155" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvlastName" ForeColor="Red" ControlToValidate="tblastName" Display="Dynamic" ErrorMessage="חובה להקיש שם משפחה" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label17" runat="server" Text="תאריך לידה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:TextBox Runat="server" ID="TBBirthdate" text='<%# Eval("BirthDate","{0:dd/MM/yyyy}") %>' Width="80"  />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvtbbirth" ErrorMessage="חובה להקיש תאריך לידה" ForeColor="Red" Display="Dynamic" ControlToValidate="tbbirthdate" />
                                        <asp:RangeValidator runat="server" id="rvbtbbirth" ErrorMessage="תאריך לידה לא בטווח חוקי. חייב להיות בין 1/1/1940 לבין 31/12/1999 " ForeColor="Red" Display="Dynamic" Type="Date" MinimumValue="1940-1-1" MaximumValue="1999-12-31" ControlToValidate="tbbirthdate"/>
                                    </td>
                                </tr>
                            </table>
                       </td>          
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label18" runat="server" Text="כתובת" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbAddress" Text='<%# Eval("Address") %>' Width="155" Rows="3" TextMode="MultiLine"  />
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ForeColor="Red" ControlToValidate="tbAddress" Display="Dynamic" ErrorMessage="חובה להקיש כתובת" />

                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                               <tr>
                                     <td>
                                    </td>
                                </tr>
                            </table>
                       </td>
                   </tr>
                    <tr valign="top">
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label8" runat="server" Text="תאריך תחילת עבודה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                         <topyca:TBDate runat="server" ID="TBxFirstDate" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("FirstDate") %>' />
                                    </td>
                                </tr>
                            </table>
                       </td>          
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label9" runat="server" Text="תפקיד" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                     <td>
                                        <topyca:TreeDropDown ID="tddJob" runat="server" TableName="(Select ID,Name,isnull(Parent,1) as Parent From p6v_Jobs)" InitialText="[בחירת תפקיד]" ValueType="Class" ConnStrName="BEBook10" CategoryID="ID" ParentID="Parent" RootCategoryID="1" TextField="Name" SelectedValue='<%#Eval("JobID") %>'  SelectedText='<%#Eval("JobName") %>' OnSelectionChanged="tdd_SelectionChanged" />
                                        <asp:Label runat="server" ID="lblerrjob" Text="חובה לבחור תפקיד" ForeColor="Red" Visible="false" />
                                        <asp:Label runat="server" ID="lblNewmail" Text="לעובד זה ייפתח מייל ארגוני, שם משתמש וסיסמא ישלח אליך תוך שבוע" ForeColor="Green" Visible="false" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label15" runat="server" Text="היקף משרה" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                               <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbJobtime" Text='<%# Eval("Jobtime") %>' OnPreRender="tbJobtime_PreRender" Width="155" />
                                        <asp:RequiredFieldValidator runat="server"  ForeColor="Red" ID="rfvJOBTIME" ControlToValidate="tbJobTime" ErrorMessage="חובה להקיש היקף משרה" />
                                     </td>
                                </tr>
                            </table>
                       </td>
                   </tr>
                   <tr>
                       <td class="tblcellhdr" colspan="3">
                           ימים ושעות עבודה (לעובדים חודשיים)
                       </td>
                   </tr>
                   <tr>
                       <td colspan="3">
                            <asp:ListView ID="lvwd" runat="server" DataSourceID="DSWD" 
                                EnableModelValidation="True">
                                <AlternatingItemTemplate>
                                    <tr style="">
                                       <td>
                                            <asp:checkbox ID="CBDAY" runat="server" AutoPostBack="true" OnCheckedChanged="CBDAY_CheckedChanged" TabIndex="1" Checked='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                        </td>
                                       <td>
                                            <asp:HiddenField runat="server" ID="hdnWeekDay" Value='<%# Eval("WeekDay") %>' />
                                            <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>' />
                                        </td>
                                        <td></td>
                                       <td>
                                            <asp:Textbox ID="tbsmin" runat="server" Text='<%# ShowT("SMIN") %>' Width="14" TabIndex="3" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvsmin" ForeColor="Red" ControlToValidate="tbsmin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvSMIN" ForeColor="Red" ControlToValidate="tbsmin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbSHR" runat="server" Text='<%# ShowT("SHR") %>' Width="14" TabIndex="2" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvshr" ForeColor="Red" ControlToValidate="tbshr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="RangeValidator1" ForeColor="Red" ControlToValidate="tbshr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                        <td>-</td>
                                       <td>
                                            <asp:Textbox ID="tbemin" runat="server" Text='<%# ShowT("EMIN") %>' Width="14" TabIndex="5" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>' />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvemin" ForeColor="Red" ControlToValidate="tbemin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvemin" ForeColor="Red" ControlToValidate="tbemin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbehr" runat="server" Text='<%#ShowT("EHR") %>' Width="14" TabIndex="4" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvehr" ForeColor="Red" ControlToValidate="tbehr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvehr" ForeColor="Red" ControlToValidate="tbehr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                 </AlternatingItemTemplate>
                                <EditItemTemplate>
                                     <tr style="">
                                       <td>
                                         </td>
                                    </tr>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <table id="Table2" runat="server" style="">
                                        <tr>
                                            <td>
                                                No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <tr style="">
                                       <td>
                                       </td>
                                    </tr>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <tr style="">
                                       <td>
                                            <asp:checkbox ID="CBDAY" runat="server" AutoPostBack="true" OnCheckedChanged="CBDAY_CheckedChanged" TabIndex="1" Checked='<%# Eval("SHR") IsNot DBNULL.Value %>' />
                                        </td>
                                       <td>
                                           <asp:HiddenField runat="server" ID="hdnWeekDay" Value='<%# Eval("WeekDay") %>' />
                                           <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>' />
                                        </t>
                                        <td></td>
                                       <td>
                                            <asp:Textbox ID="tbsmin" runat="server" Text='<%# ShowT("SMIN") %>' Width="14" TabIndex="3" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                           <asp:RequiredFieldValidator runat="server" ID="rfvsmin" ForeColor="Red" ControlToValidate="tbsmin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvSMIN" ForeColor="Red" ControlToValidate="tbsmin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" SetFocusOnError="true" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbSHR" runat="server" Text='<%# ShowT("SHR") %>' Width="14" TabIndex="2" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvshr" ForeColor="Red" ControlToValidate="tbshr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="RangeValidator1" ControlToValidate="tbshr" ForeColor="Red" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                       <td>-</td>
                                       <td>
                                            <asp:Textbox ID="tbEMIN" runat="server" Text='<%# ShowT("EMIN") %>' Width="14" TabIndex="5" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvemin" ForeColor="Red" ControlToValidate="tbemin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvemin" ForeColor="Red" ControlToValidate="tbemin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbehr" runat="server" Text='<%# ShowT("EHR") %>' Width="14" TabIndex="4" OnTextChanged="tbHM_TextChenged" Enabled='<%# Eval("SHR") IsNot DBNULL.Value %>'/>
                                            <asp:RequiredFieldValidator runat="server" ID="rfvehr" ForeColor="Red" ControlToValidate="tbehr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvehr" ControlToValidate="tbehr" ForeColor="Red" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table id="Table3" runat="server">
                                        <tr id="Tr1" runat="server">
                                            <td id="Td4" runat="server">
                                                <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                                    <tr id="Tr2" runat="server" style="">
                                                        <th id="Th1" runat="server" class="tblcellhdr" colspan="2">
                                                            יום</th>
                                                        <th></th>
                                                        <th id="Th2" runat="server" class="tblcellhdr" colspan="3">
                                                            התחלה</th>
                                                        <th></th>
                                                        <th id="Th3" runat="server" class="tblcellhdr" colspan="3">
                                                            סיום</th>
                                                    </tr>
                                                    <tr ID="itemPlaceholder" runat="server">
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="Tr3" runat="server">
                                            <td id="Td5" runat="server" style="">
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <tr style="">
                                        <td></td>
                                    </tr>
                                </SelectedItemTemplate>
                            </asp:ListView>
                       </td>
                   </tr>
                   <tr valign="top">
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label2" runat="server" Text="תעריף לשעה (לעובדים שעתיים)" Width="155" />
                                   </td>
                                </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbtarif" Text='<%# Eval("tarif","{0:0.00}") %>' />
                                        <asp:RangeValidator runat="server" ID="rvtarif" ForeColor="Red" ControlToValidate="tbtarif" Type="Currency" MinimumValue="1.0" MaximumValue="550.0" ErrorMessage="תעריף חייב להיות מספר (ללא אותיות או סימנים אחרים) בטווח שבין 1 ל 550"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label1" runat="server" Text="שכר חודשי (לעובדים חודשיים)" Width="150" />
                                     </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbsalary" Text='<%# Eval("salary","{0:#,##0}") %>' />
                                       <asp:RangeValidator runat="server" ID="rvSalary" ForeColor="Red" ControlToValidate="tbsalary" Type="Currency" MinimumValue="10" MaximumValue="25000" ErrorMessage="תעריף חייב להיות מספר (ללא אותיות או סימנים אחרים) בטווח שבין 10 ל 25000"/>
                                       <asp:Label runat="server" ID="lblerrsalary" Text="חסר סכום השכר. חובה להקליד ערך בשדה 'תעריף לשעה (לעובדים שעתיים)' או  בשדה 'שכר חודשי (לעובדים חודשיים)'." Visible="false" ForeColor="Red" />
                                   </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label19" runat="server" Text="תשלום על נסיעות" Width="75" />
                                    </td>
                                   <td class="tblcellhdr">
                                      <asp:label ID="Label20" runat="server" Text="סכום נסיעות" Width="62" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblTravelCode" RepeatDirection="Vertical" CellPadding="-1"  Width="60" CellSpacing="-1" SelectedValue='<%# Eval("TravelCode") %>' >
                                             <asp:ListItem Text="יומי" Value="0" Selected="True"/>
                                            <asp:ListItem Text="גלובלי" Value="1" />
                                        </asp:RadioButtonList>
                                        </td>
                                        <td valign="top">
                                        <asp:TextBox runat="server" ID="tbTravel" Text='<%# Eval("Travel") %>' Width="70" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvTravel" ForeColor="Red" ControlToValidate="tbtravel" ErrorMessage="חובה להקיש סכום נסיעות" Display="Dynamic" />
                                        <asp:RangeValidator runat="server" ID="rvtravel" ForeColor="Red" ControlToValidate="tbTravel" Type="Double" MinimumValue="0" MaximumValue="200000" ErrorMessage="סכום נסיעות לא חוקי" Display="Dynamic" />
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label3" runat="server" Text="תוספת אחריות/ריכוז" Width="150" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbSalaryAdd" Text='<%# Eval("SalaryAdd","{0:#,##0}") %>' />
                                        <asp:RangeValidator runat="server" ID="rvSalaryAdd"  ForeColor="Red" ControlToValidate="tbSalaryAdd" Type="Double" MinimumValue="10" MaximumValue="200000" ErrorMessage="תוספת אחריות לא חוקית. (חייבת להיות מספר בין 0 ל 10000)"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label4" runat="server" Text="פלאפון" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblCellPhone" RepeatDirection="Horizontal" SelectedValue='<%#Eval("CellPhone") %>'   >
                                            <asp:ListItem Text="לא" Value="0"  Selected="True"/>
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label5" runat="server" Text="קרן השתלמות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblStudyFundID" RepeatDirection="Horizontal" SelectedValue='<%#Eval("StudyFundID") %>' >
                                            <asp:ListItem Text="לא" Value="0" Selected="true" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label11" runat="server" Text="תואר אקדמי" Width="150" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlAcademicDegree" SelectedValue='<%# Eval("AcademicDegree") %>' >
                                            <asp:ListItem Value="">אין</asp:ListItem>
                                            <asp:ListItem Value="1">בוגר</asp:ListItem>
                                            <asp:ListItem Value="2">מוסמך</asp:ListItem>
                                            <asp:ListItem Value="3">בכיר</asp:ListItem>
                                            <asp:ListItem Value="4">BA</asp:ListItem>
                                            <asp:ListItem Value="5">MA</asp:ListItem>
                                        </asp:DropDownList>
                                   </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label44" runat="server" Text="שנות ותק כמוסמך" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbYearsCertified" Text='<%# Eval("YearsCertified") %>' />
                                        <asp:RangeValidator runat="server" ID="YearsCertified" ForeColor="Red" ControlToValidate="tbYearsCertified" Type="Double" MinimumValue="0" MaximumValue="50" ErrorMessage="ותק לא חוקי"/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label45" runat="server" Text="גמולים" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                       <asp:TextBox runat="server" ID="tbRewards" Text='<%# Eval("Rewards","{0:N2}") %>' />
                                        <asp:RangeValidator runat="server" ID="rvRewards" ForeColor="Red" ControlToValidate="tbRewards" Type="Double" MinimumValue="0" MaximumValue="50000" ErrorMessage="מספר לא חוקי"/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label77" runat="server" Text="סוג בית ספר" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblSchool" RepeatDirection="Horizontal" OnPreRender="rbl_PreRender" >
                                            <asp:ListItem Text="יסודי" Value="1" />
                                            <asp:ListItem Text="תיכון" Value="2" />
                                        </asp:RadioButtonList>
                                        <asp:HiddenField runat="server" ID="hdnSchool" value='<%# Eval("School") %>'/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                          <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label25" runat="server" Text="מגיש לבגרות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblMatriculation" RepeatDirection="Horizontal" SelectedValue='<%#Eval("Matriculation") %>' >
                                            <asp:ListItem Text="לא" Value="0" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label6" runat="server" Text="רכב חברה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblCompanyCar" RepeatDirection="Horizontal" SelectedValue='<%#Eval("CompanyCar") %>'  >
                                            <asp:ListItem Text="לא" Value="0" Selected="True" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label78" runat="server" Text="דואר אלקטרוני" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblmail" RepeatDirection="Horizontal" OnPreRender="rbl_PreRender" >
                                            <asp:ListItem Text="לא" Value="0" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                        <asp:HiddenField runat="server" ID="hdnmail" value='<%# Eval("mail") %>'/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                          <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label26" runat="server" Text="" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>&nbsp;
                                      </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label61" runat="server" Text="" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>&nbsp;
                                      </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">               
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label87" runat="server" Text="נדרש אישור לחריגה (מצורף)" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblSMngrAppr" RepeatDirection="Horizontal" SelectedValue='<%#Eval("sMngrAppr") %>'  >
                                            <asp:ListItem Text="לא" Value="0" Selected="true" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label10" runat="server" Text="תאריך" Width="155" />
                                    </td>
                                </tr>
                                <tr> 
                                    <td>
                                       <topyca:TBDate runat="server" ID="TBDate1" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("Loadtime") %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label16" runat="server" Text="שם מנהל" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbmanager" Text='<%# Eval("manager") %>' OnPreRender="tbManager_PreRender" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvmanager" ForeColor="Red" ControlToValidate="tbmanager" ErrorMessage="חובה להקליד שם מנהל" Display="Dynamic" />
                                    </td>
                                </tr>
                            </table>
                         </td>
                     </tr>
                     <tr>
                        <td>
                            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" Text="עדכון" />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                     </tr>
                </table>
            </td>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table style="">
                <tr>
                    <td>
                        No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <td runat="server" style="" valign="top">
                <table>
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label12" runat="server" Text="תעודת זהות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                     <topyca:CheckID runat="server" ID="tbcheckid" TableName="p6t_emps" FieldName="EmpID" Text='<%# Eval("EmpID") %>' OnTextChanged="tbcheckid_TextChanged" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                      <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label13" runat="server" Text="שם פרטי" Width="155" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbFirstName" Text='<%# Eval("FirstName") %>'  />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvFirstName" ForeColor="Red" ControlToValidate="tbFirstName" Display="Dynamic" ErrorMessage="חובה להקיש שם פרטי" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label14" runat="server" Text="שם משפחה" Width="155" />
                                    </td>

                                </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbLastname" Text='<%# Eval("LastName") %>' Width="155" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvlastName" ForeColor="Red" ControlToValidate="tblastName" Display="Dynamic" ErrorMessage="חובה להקיש שם משפחה" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr valign="top">
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label17" runat="server" Text="תאריך לידה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:TextBox Runat="server" ID="TBBirthdate" text='<%# Eval("BirthDate","{0:dd/MM/yyyy}") %>' Width="80"  />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvtbbirth" ErrorMessage="חובה להקיש תאריך לידה" ForeColor="Red" Display="Dynamic" ControlToValidate="tbbirthdate"/>
                                        <asp:RangeValidator runat="server" id="rvbtbbirth" ErrorMessage="תאריך לידה לא בטווח חוקי. חייב להיות בין 1/1/1940 לבין 31/12/1999" ForeColor="Red" Display="Dynamic" Type="Date" MinimumValue="1920-1-1" MaximumValue="2010-1-1" ControlToValidate="tbbirthdate" />
                                   </td>
                                </tr>
                            </table>
                       </td>          
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label18" runat="server" Text="כתובת" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbAddress" Text='<%# Eval("Address") %>' Width="155" Rows="3" TextMode="MultiLine"  />
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ForeColor="Red" ControlToValidate="tbAddress" Display="Dynamic" ErrorMessage="חובה להקיש כתובת" />

                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                               <tr>
                                     <td>
                                    </td>
                                </tr>
                            </table>
                       </td>
                   </tr>
                    <tr valign="top">
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label8" runat="server" Text="תאריך תחילת עבודה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <topyca:TBDate runat="server" ID="TBxFirstDate" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("FirstDate") %>' />
                                    </td>
                                </tr>
                            </table>
                       </td>          
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label9" runat="server" Text="תפקיד" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr>
                                     <td>
                                        <topyca:TreeDropDown ID="tddJob" runat="server" TableName="(Select ID,Name,isnull(Parent,1) as Parent From p6v_Jobs)" InitialText="[בחירת תפקיד]" ValueType="Class" ConnStrName="BEBook10" CategoryID="ID" ParentID="Parent" RootCategoryID="1" TextField="Name" OnSelectionChanged="tdd_SelectionChanged"  />
                                        <asp:Label runat="server" ID="lblerrjob" Text="חובה לבחור תפקיד" ForeColor="Red" Visible="false" />
                                                   
                                    </td>
                                </tr>
                            </table>
                        </td>
                       <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label15" runat="server" Text="היקף משרה" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                               <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbJobtime" Text='<%# Eval("Jobtime") %>' OnPreRender="tbJobtime_PreRender" Width="155" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvJOBTIME" ControlToValidate="tbJobTime" ErrorMessage="חובה להקיש היקף משרה" ForeColor="Red" />
                                    </td>
                                </tr>
                            </table>
                       </td>
                   </tr>
                   <tr>
                       <td class="tblcellhdr" colspan="3">
                           ימים ושעות עבודה (לעובדים חודשיים)
                       </td>
                   </tr>
                   <tr>
                       <td colspan="3">
                            <asp:ListView ID="lvwd" runat="server" DataSourceID="DSWD" 
                                EnableModelValidation="True">
                                <AlternatingItemTemplate>
                                    <tr style="">
                                       <td>
                                            <asp:checkbox ID="CBDAY" runat="server" AutoPostBack="true" OnCheckedChanged="CBDAY_CheckedChanged" TabIndex="1" Checked='<%# Eval("SHR") IsNot DBNULL.Value %>' />
                                        </td>
                                       <td>
                                            <asp:HiddenField runat="server" ID="hdnWeekDay" Value='<%# Eval("WeekDay") %>' />
                                            <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>' />
                                        </td>
                                        <td></td>
                                       <td>
                                            <asp:Textbox ID="tbsmin" runat="server" Text='<%# Eval("SMIN") %>' Width="14" TabIndex="3" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator  ForeColor="Red" runat="server" ID="rfvsmin" ControlToValidate="tbsmin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvSMIN"  ForeColor="Red" ControlToValidate="tbsmin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbSHR" runat="server" Text='<%# Eval("SHR") %>' Width="14" TabIndex="2" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvshr"  ForeColor="Red" ControlToValidate="tbshr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="RangeValidator1"  ForeColor="Red" ControlToValidate="tbshr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                        <td>-</td>
                                       <td>
                                            <asp:Textbox ID="tbemin" runat="server" Text='<%# Eval("EMIN") %>' Width="14" TabIndex="5" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvemin"  ForeColor="Red" ControlToValidate="tbemin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvemin"  ForeColor="Red" ControlToValidate="tbemin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbehr" runat="server" Text='<%# Eval("EHR") %>' Width="14" TabIndex="4" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator  ForeColor="Red" runat="server" ID="rfvehr" ControlToValidate="tbehr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvehr"  ForeColor="Red" ControlToValidate="tbehr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                 </AlternatingItemTemplate>
                                <EditItemTemplate>
                                    <tr style="">
                                       <td>
                                     </tr>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <table id="Table2" runat="server" style="">
                                        <tr>
                                            <td>
                                                No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <tr style="">
                                       <td>
                                        </td>
                                    </tr>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <tr style="">
                                       <td>
                                            <asp:checkbox ID="CBDAY" runat="server" AutoPostBack="true" OnCheckedChanged="CBDAY_CheckedChanged" TabIndex="1" />
                                       </td>
                                       <td>
                                           <asp:HiddenField runat="server" ID="hdnWeekDay" Value='<%# Eval("WeekDay") %>' />
                                           <asp:Label ID="lblDayName" runat="server" Text='<%# Eval("DayName") %>' />
                                        </td>
                                        <td></td>
                                        <td>
                                            <asp:Textbox ID="tbsmin" runat="server" Text='<%# Eval("SMIN") %>' Width="14" TabIndex="3" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvsmin"  ForeColor="Red" ControlToValidate="tbsmin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvSMIN"  ForeColor="Red" ControlToValidate="tbsmin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" SetFocusOnError="true" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbSHR" runat="server" Text='<%# Eval("SHR") %>' Width="14" TabIndex="2" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvshr" ForeColor="Red" ControlToValidate="tbshr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="RangeValidator1" ForeColor="Red" ControlToValidate="tbshr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                       <td>-</td>
                                       <td>
                                            <asp:Textbox ID="tbEMIN" runat="server" Text='<%# Eval("EMIN") %>' Width="14" TabIndex="5" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvemin" ForeColor="Red" ControlToValidate="tbemin" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvemin" ForeColor="Red" ControlToValidate="tbemin" Type="Integer" MinimumValue="0" MaximumValue="59" Display="Dynamic" ErrorMessage="ערך בין 0 ל 59" Enabled="false" />
                                        </td>
                                        <td>:</td>
                                        <td>
                                            <asp:Textbox ID="tbehr" runat="server" Text='<%# Eval("EHR") %>' Width="14" TabIndex="4" Enabled="false" OnTextChanged="tbHM_TextChenged" />
                                            <asp:RequiredFieldValidator runat="server" ID="rfvehr" ForeColor="Red" ControlToValidate="tbehr" ErrorMessage="חובה להקיש ערך" Display="Dynamic" Enabled="false" />
                                            <asp:RangeValidator runat="server" ID="rvehr" ForeColor="Red" ControlToValidate="tbehr" Type="Integer" MinimumValue="0" MaximumValue="24" Display="Dynamic" ErrorMessage="ערך בין 0 ל 24" Enabled="false" />
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table id="Table3" runat="server">
                                        <tr id="Tr1" runat="server">
                                            <td id="Td4" runat="server">
                                                <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                                                    <tr id="Tr2" runat="server" style="">
                                                        <th id="Th1" runat="server" class="tblcellhdr" colspan="2">
                                                            יום</th>
                                                        <th></th>
                                                        <th id="Th2" runat="server" class="tblcellhdr" colspan="3">
                                                            התחלה</th>
                                                        <th></th>
                                                        <th id="Th3" runat="server" class="tblcellhdr" colspan="3">
                                                            סיום</th>
                                                    </tr>
                                                    <tr ID="itemPlaceholder" runat="server">
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr id="Tr3" runat="server">
                                            <td id="Td5" runat="server" style="">
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <tr style="">
                                        <td></td>
                                    </tr>
                                </SelectedItemTemplate>
                            </asp:ListView>
                       </td>
                   </tr>
                   <tr valign="top">
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                       <asp:label ID="Label2" runat="server" Text="תעריף לשעה (לעובדים שעתיים)" Width="155" />
                                   </td>
                                </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbtarif" Text='<%# Eval("tarif") %>' AutoPostBack="true" OnTextChanged="tbtarif_TextChanged" />
                                        <asp:RangeValidator runat="server" ID="rvtarif"  ForeColor="Red" ControlToValidate="tbtarif" Type="Double" MinimumValue="0.1" MaximumValue="550.0" ErrorMessage="תעריף חייב להיות מספר (ללא אותיות או סימנים אחרים) בטווח שבין 1 ל 550"/>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label1" runat="server" Text="שכר חודשי (לעובדים חודשיים)" Width="150" />
                                     </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbsalary" Text='<%# Eval("salary") %>' />
                                       <asp:RangeValidator runat="server" ID="rvSalary" ForeColor="Red" ControlToValidate="tbsalary" Type="Currency" MinimumValue="10" MaximumValue="400000" ErrorMessage="תעריף חייב להיות מספר (ללא אותיות או סימנים אחרים) בטווח שבין 10 ל 25000" Display="Dynamic" />
                                      <asp:CustomValidator runat="server" ControlToValidate="tbsalary" OnServerValidate="cverrsalary_ServerValidate" ID="cverrsalary" ErrorMessage="חובה להקליד סכום או בתעריף או בשכר ולא בשניהם. חובה להקליד ערך בשדה 'תעריף לשעה (לעובדים שעתיים)' או  בשדה 'שכר חודשי (לעובדים חודשיים)'." ForeColor="Red" Display="Dynamic" />
                                       <asp:RequiredFieldValidator runat="server" ID="rflsalary" ControlToValidate="tbsalary" Display="Dynamic" ErrorMessage="חסר סכום השכר. חובה להקליד ערך בשדה 'תעריף לשעה (לעובדים שעתיים)' או  בשדה 'שכר חודשי (לעובדים חודשיים)'." ForeColor="Red" />
                                  </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label runat="server" Text="תשלום על נסיעות" Width="75" />
                                    </td>
                                   <td class="tblcellhdr">
                                      <asp:label runat="server" Text="סכום נסיעות" Width="62" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rbltravelCode" RepeatDirection="Vertical" CellPadding="-1"  Width="60" CellSpacing="-1"  >
                                             <asp:ListItem Text="יומי" Value="0" Selected="True"/>
                                            <asp:ListItem Text="גלובלי" Value="1" />
                                        </asp:RadioButtonList>
                                        </td>
                                        <td valign="top">
                                        <asp:TextBox runat="server" ID="tbTravel" Text='<%# Eval("Travel") %>' Width="70" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvTravel" ForeColor="Red" ControlToValidate="tbtravel" ErrorMessage="חובה להקיש סכום נסיעות" Display="Dynamic" />
                                        <asp:RangeValidator runat="server" ID="rvTravel" ForeColor="Red" ControlToValidate="tbTravel" Type="Double" MinimumValue="0" MaximumValue="10000" ErrorMessage="סכום נסיעות לא חוקי. חייב להיות מספר בין 0 ל 10000)" Display="Dynamic" />
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                   <tr valign="top">
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label3" runat="server" Text="תוספת אחריות/ריכוז" Width="150" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbSalaryAdd" Text='<%# Eval("SalaryAdd") %>' />
                                        <asp:RangeValidator runat="server" ID="rvSalaryAdd" ForeColor="Red" ControlToValidate="tbSalaryAdd" Type="Double" MinimumValue="10" MaximumValue="200000" ErrorMessage="תוספת לא חוקית" Display="Dynamic"/>
                                   </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label4" runat="server" Text="פלאפון" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblCellPhone" RepeatDirection="Horizontal"  >
                                            <asp:ListItem Text="לא" Value="0"  Selected="True"/>
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label5" runat="server" Text="קרן השתלמות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblStudyFundID" RepeatDirection="Horizontal" >
                                            <asp:ListItem Text="לא" Value="0" Selected="true" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                   <tr valign="top">
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label11" runat="server" Text="תואר אקדמי" Width="150" />
                                    </td>
                                 </tr>
                                <tr> 
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlAcademicDegree" SelectedValue='<%# Eval("AcademicDegree") %>' >
                                            <asp:ListItem Value="">אין</asp:ListItem>
                                            <asp:ListItem Value="1">בוגר</asp:ListItem>
                                            <asp:ListItem Value="2">מוסמך</asp:ListItem>
                                            <asp:ListItem Value="3">בכיר</asp:ListItem>
                                        </asp:DropDownList>
                                   </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label44" runat="server" Text="שנות ותק כמוסמך" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbYearsCertified" Text='<%# Eval("YearsCertified") %>' />
                                        <asp:RangeValidator runat="server" ID="YearsCertified" ForeColor="Red" ControlToValidate="tbYearsCertified" Type="Double" MinimumValue="0" MaximumValue="20" ErrorMessage="ותק לא חוקי"/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label45" runat="server" Text="גמולים" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:TextBox runat="server" ID="tbRewards" Text='<%# Eval("YearsCertified") %>' />
                                        <asp:RangeValidator runat="server" ID="rvRewards" ForeColor="Red" ControlToValidate="tbRewards" Type="Double" MinimumValue="0" MaximumValue="50000" ErrorMessage="מספר לא חוקי"/>
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                   <tr valign="top">
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label77" runat="server" Text="סוג בית ספר" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblSchool" RepeatDirection="Horizontal"  >
                                            <asp:ListItem Text="יסודי" Value="1" />
                                            <asp:ListItem Text="תיכון" Value="2" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                           <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label25" runat="server" Text="מגיש לבגרות" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblMatriculation" RepeatDirection="Horizontal" >
                                            <asp:ListItem Text="לא" Value="0" Selected="True"/>
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label6" runat="server" Text="רכב חברה" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblCompanyCar" RepeatDirection="Horizontal" >
                                            <asp:ListItem Text="לא" Value="0" Selected="True" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
						</tr>
					    <tr valign="top">
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label78" runat="server" Text="דואר אלקטרוני" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblmail" RepeatDirection="Horizontal" OnPreRender="rbl_PreRender" >
                                            <asp:ListItem Text="לא" Value="0" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                        <asp:HiddenField runat="server" ID="hdnmail" value='<%# Eval("mail") %>'/>
	<%--									<asp:Label runat="server" ID="lblNewmail" Text="לעובד זה ייפתח מייל ארגוני, שם משתמש וסיסמא ישלח אליך תוך שבוע" ForeColor="Green" Visible="false" />
  --%>                                   </td>
                                </tr>
                            </table>
                        </td>
                          <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label26" runat="server" Text="" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>&nbsp;
                                      </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label61" runat="server" Text="" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>&nbsp;
                                      </td>
                                </tr>
                            </table>
                        </td>
                    </tr>

                   <tr valign="top">               
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label7" runat="server" Text="נדרש אישור לחריגה (מצורף)" Width="155" />
                                    </td>
                                </tr>
                                <tr>
                                     <td>
                                        <asp:RadioButtonList runat="server" ID="rblSMngrAppr" RepeatDirection="Horizontal"  >
                                            <asp:ListItem Text="לא" Value="0" Selected="true" />
                                            <asp:ListItem Text="כן" Value="1" />
                                        </asp:RadioButtonList>
                                     </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                        <asp:label ID="Label10" runat="server" Text="תאריך" Width="155" />
                                    </td>
                                </tr>
                                <tr> 
                                    <td>
                                       <topyca:TBDate runat="server" ID="TBDate1" DateFormat="dd/MM/yyyy" InitDate="Today" SelectedDate='<%# Eval("Loadtime") %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                         <td>
                            <table>
                                <tr>
                                    <td class="tblcellhdr">
                                      <asp:label ID="Label16" runat="server" Text="שם מנהל" Width="155" />
                                    </td>
                                </tr>
                                <tr><td></td></tr>
                                <tr> 
                                    <td>
                                        <asp:TextBox runat="server" ID="tbmanager" Text='<%# Eval("manager") %>'  OnPreRender="tbManager_PreRender" />
                                        <asp:RequiredFieldValidator runat="server" ForeColor="Red" ID="rfvmanager" ControlToValidate="tbmanager" ErrorMessage="חובה להקליד שם מנהל" Display="Dynamic" />
                                    </td>
                                </tr>
                            </table>
                         </td>
                     </tr>
                   <tr>
                        <td>
                            <asp:Label runat="server" ID="lblerrempid" Text="חובה להקיש תעודת זהות" ForeColor="Red" Visible="false" />
                            <asp:Label runat="server" ID="lblDupID" Text="" ForeColor="Red" OnPreRender="lblDupID_PerRender" />
                            <asp:ValidationSummary runat="server" ID="vsall" DisplayMode="List" ForeColor="Red" ShowMessageBox="true"  ShowSummary="true" EnableClientScript="true"  />
                            <asp:Button runat="server" ID="btnAdd" OnClick="btnAdd_Click" Text="הוספה" CausesValidation="false" />
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                     </tr>
                </table>
            </td>
        </InsertItemTemplate>
        <ItemTemplate>
            <td runat="server" style="">
            </td>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server" border="0" style="">
                <tr ID="itemPlaceholderContainer" runat="server">
                    <td ID="itemPlaceholder" runat="server">
                    </td>
                </tr>
            </table>
            <div style="">
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DSEMPS" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        
        SelectCommand="SELECT p6t_Emps.EmpID, p6t_Emps.FirstName, p6t_Emps.LastName, p6t_Emps.JobID, p6t_Emps.Address, p6t_Emps.FirstDate, p6t_Emps.LastDate, p6t_Emps.FrameID, p6t_Emps.Status, p6t_Emps.BirthDate, p6t_Emps.EMEID, CASE isnull(p6t_Emps.CellPhone , 0) WHEN 0 THEN 0 ELSE 1 END AS CellPhone,CASE isnull(p6t_Emps.Mail , 0) WHEN 0 THEN 0 ELSE 1 END AS Mail, p6t_Emps.JobTime, p6t_Emps.Tarif, p6t_Emps.Salary, ISNULL(p6t_Emps.TravelCode, 0) AS TravelCode, p6t_Emps.Travel, p6t_Emps.SalaryAdd, ISNULL(p6t_Emps.StudyFundID, 0) AS StudyFundID, CASE isnull(p6t_Emps.CompanyCar , 0) WHEN 0 THEN 0 ELSE 1 END AS CompanyCaR, CASE isnull(p6t_Emps.SMngrAppr , 0) WHEN 0 THEN 0 ELSE SMngrAppr END AS SMngrAppr, p6t_Emps.Manager, p6t_Emps.LoadTime, p6t_Emps.Signed, p6t_jobs.JobName, p6t_Emps.AcademicDegree, p6t_Emps.YearsCertified,isnull(p6t_Emps.Rewards , 0) AS Rewards,  CASE isnull(p6t_Emps.Matriculation , 0) WHEN 0 THEN 0 ELSE 1 END AS Matriculation,School FROM p6t_Emps LEFT OUTER JOIN p6t_jobs ON p6t_Emps.JobID = p6t_jobs.JobID WHERE (p6t_Emps.EmpID = @EmpID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="EmpID" QueryStringField="E" />
        </SelectParameters>
    </asp:SqlDataSource>
<div>
    <br />
    <asp:SqlDataSource ID="DSWD" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>"                              
        SelectCommand="SELECT w.ID, w.EmpID, d.WeekDay, DATEPART(hh, w.Starthour) AS SHR, cast(DATEPART(minute, w.Starthour) as int) AS SMIN, DATEPART(hh, w.Endhour) AS EHR, cast(DATEPART(minute, w.Endhour) as int) AS EMIN, d.DayName FROM p6t_Days AS d LEFT OUTER JOIN (SELECT ID, EmpID, WeekDay, Starthour, Endhour FROM p6t_WorkDays WHERE (ISNULL(EmpID, 0) = ISNULL(@EmpID, 0))) AS w ON d.WeekDay = w.WeekDay WHERE (d.WeekDay &lt; 7)" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="EmpID" QueryStringField="E" />
        </SelectParameters>
    </asp:SqlDataSource>

</div>



</div>
</div>
</asp:Content>
