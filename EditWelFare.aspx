<%@ Page Title="" Language="VB" MasterPageFile="~/Welfare.master" AutoEventWireup="false" CodeFile="EditWelFare.aspx.vb" Inherits="EditWelFare" MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:toolkitscriptmanager ID="TSM1" runat="server" /> 
    <script type="text/javascript">
        function testmsg() {
            var alrt = document.getElementById('<%= tbbtnOKmsgText.ClientID %>');
            alert(alrt.value); 
        }
    </script>
    <div style="text-align:center;" runat="server" id="divTBL">
        <table style="margin-right:auto;margin-left:auto;empty-cells:show;text-align:right;width:650px;">
        <tr>
            <td>
                <asp:Label runat="server" ID="lblText_HEADER_1" text="החלק העליון של הדף 1" Width="100%" />
                <CKEditor:CKEditorControl runat="server" ID="cke_Header_1" Visible="false" Width="100%" />
            </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:Silver;">
                <asp:Button runat="server" ID="btnedit_HEADER_1" Text="ערוך" CausesValidation="false" OnClick="btnedit_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblText_HEADER_2" text="החלק העליון של הדף 2" Width="100%" />
                <CKEditor:CKEditorControl runat="server" ID="cke_Header_2" Visible="false" Width="100%" />
            </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:Silver;">
                <asp:Button runat="server" ID="btnedit_HEADER_2" Text="ערוך" CausesValidation="false" OnClick="btnedit_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblText_HEADER_3" text="החלק העליון של הדף 3" Width="100%" />
                <CKEditor:CKEditorControl runat="server" ID="cke_Header_3" Visible="false" Width="100%" />
            </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:Silver;">
                <asp:Button runat="server" ID="btnedit_HEADER_3" Text="ערוך" CausesValidation="false" OnClick="btnedit_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <div style="background-color:#EEEEEE;">
                    <table style="font-size:small;">
                        <tr>
                            <td>
                                שם פרטי&nbsp;<span style="color:Red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="tbfname" Width="120" AutoCompleteType="None" TabIndex="10"/>
<%--                                <asp:RequiredFieldValidator runat="server" ID="rfvfname" ControlToValidate="tbfname" Display="Dynamic" ErrorMessage="חובה להקליד שם פרטי" ForeColor="Red" />
--%>                            </td>
                            <td>
                                שם משפחה&nbsp;<span style="color:Red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="tblname" Width="120" AutoCompleteType="None" TabIndex="20" />
 <%--                               <asp:RequiredFieldValidator runat="server" ID="rfvlname" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד שם משפחה" ForeColor="Red"/>
 --%>                           </td>
                        </tr>
                        <tr>
                            <td>
                                תעודת זהות&nbsp;<span style="color:Red;">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="tbid" Width="120" TabIndex="30" />
 <%--                               <asp:RequiredFieldValidator runat="server" ID="rfvtb" ControlToValidate="tblname" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" ForeColor="Red"/>
                                <asp:RangeValidator runat="server" ID="rvid" ControlToValidate="tbid" Display="Dynamic" ErrorMessage="חובה להקליד תעודת זהות" Type="Integer" MinimumValue="111111" MaximumValue="999999999" ForeColor="Red"/>
 --%>                           </td>
                                <td>
                                <asp:Label runat="server" ID="lblphone" Text="טלפון" AutoCompleteType="Disabled"  />
                            </td>
                            <td>
                                <asp:TextBox runat="server" ID="tbphone" Width="120" TabIndex="40" />
 <%--                               <asp:RequiredFieldValidator runat="server" ID="rfvphone" ControlToValidate="tbphone" Display="Dynamic" ErrorMessage="חובה להקליד מספר טלפון" ForeColor="Red"/>
 --%>                           </td>
                        </tr>
                            <tr>
                            <td>
                                <asp:Label runat="server" ID="lblfrm" Text="שם המסגרת" AutoCompleteType="None" />
                            </td>
                            <td colspan="3">
                                <asp:TextBox runat="server" ID="tbfrm" Width="120" TabIndex="50" />
 <%--                               <asp:RequiredFieldValidator runat="server" ID="rfv" ControlToValidate="tbfrm" Display="Dynamic" ErrorMessage="חובה להקליד שם מסגרת" ForeColor="Red"/>
 --%>                           </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label runat="server" ID="lblemail" Text="דואר אלקטרוני" AutoCompleteType="Disabled"  />
                            </td>
                            <td colspan="3">
                                <span style="text-align:left;direction:ltr;"><asp:TextBox runat="server" ID="tbemail1" Width="100" TabIndex="70"/></span>@<asp:TextBox runat="server" ID="tbemail2" Width="70" TabIndex="60" />
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:#333333;">&nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblText_FOOTER" text="החלק התחתון של הדף" Width="100%" />
                <CKEditor:CKEditorControl runat="server" ID="cke_Footer" Visible="false" Width="100%" />
            </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:Silver;">
                <asp:Button runat="server" ID="btnedit_FOOTER" Text="ערוך" CausesValidation="false" OnClick="btnedit_Click" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:CheckBox runat="server" ID="cbAgree" Text="אני מאשר/ת" OnPreRender="cbAgreerequired_Prerender" />
                <asp:CheckBox runat="server" ID="cbAgreeRequiredflag" Text="סמנו כאן אם נדרשת הסכמה לתנאי המבצע" OnPreRender="cbAgreerequiredflag_Prerender" Visible="false" />
           </td>
            <td style="border-right-style:dotted;border-right-width:thin;border-right-color:#333333;">
              <asp:Button runat="server" ID="btnAgree" Text="ערוך" CausesValidation="false" />
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Button runat="server" ID="btnord" Text="הזמן/הזמיני"  /><br /><asp:Label runat="server" ID="lblbnordtext" Visible="false">טקסט כפתור האישור:</asp:Label><br />
                <asp:TextBox runat="server" ID="tbbnordtext" Text="הזמן/הזמיני" Visible="false" /><br /><asp:Label runat="server" ID="lblbtnOKmsgText" Visible="false">טקסט הודעת הסיכום:</asp:Label><br />
                <asp:TextBox runat="server" ID="tbbtnOKmsgText" Visible="false" Width="400" TextMode="MultiLine" Rows="7" Text="ההזמנה נרשמה. תודה" />
                <div runat="server" id="divbtntext" visible="false"><button id="btntext" onclick="testmsg();">בדיקת ההודעה</button></div>
            </td>
           <td style="border-right-style:dotted;border-right-width:thin;border-right-color:Silver;" valign="top">
                <asp:Button runat="server" ID="btnOKTexts" Text="ערוך" CausesValidation="false" />
            </td>
            </tr>
         </table>
         <div style="margin-right:auto;margin-left:auto;text-align:left;width:650px"><asp:Button runat="server" ID="btncancel" Text="ביטול" CausesValidation="false" BackColor="LightBlue" CommandName="Cancel" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:LinkButton runat="server" ID="btnHideEdit" Text="חזרה" CausesValidation="false" BackColor="LightBlue" PostBackUrl="~/WelfareDefs.aspx" />&nbsp;&nbsp;</div>
  </div>
</asp:Content>

