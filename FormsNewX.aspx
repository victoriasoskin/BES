<%@ Page Title="" Language="VB" Debug="true" MasterPageFile="~/Sherut.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="FormsNewX.aspx.vb" Inherits="FormsNew_" %>

<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.WebControls" TagPrefix="asp" %>
<%@ Register Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .h1 {
            font-size: xx-large;
            font-weight: bolder;
            width: 600px;
            padding-right: 10px;
        }

        .p {
            width: 200px;
            padding-right: 10px;
        } 

        .pg {
            position: absolute;
            top: 0px;
            background-color: #C0C0C0;
            width: 800px;
            border: 2px groove #EEEEEE;
            right: 165px;
        }

        .blockHeader {
            font-size: medium;
            color: ButtonText;
            font-weight: bolder;
            height: 25px;
            padding-right: 10px;
        }

        .blockfooter {
            padding-right: 10px;
            width: 60px;
        }

        .tbw {
            background-color: #ececec;
            width: 120px;
        }

        .divid {
            background-color: #ececec;
            width: 104px;
        }

        .divemail {
            background-color: #ececec;
            width: 126px;
        }

        .ddlw {
            background-color: #ececec;
            width: 125px;
            border-style: groove;
        }

        .tdr {
            padding-right: 10px;
            padding-top: 5px;
            max-width: 30px;
        }

        .tbl {
            padding: 10px;
            width: 100%;
        }

        th {
            background-color: #AAAAAA;
            border-bottom: 1px solid black;
        }

        .tbld {
            width: 100%;
        }

            .tbld td {
                padding-right: 10px;
            }

        .tdid {
            border-left: 1px outset #AAAAAA;
            border-bottom: 1px outset #AAAAAA;
            width: 20px;
        }

        .tdq {
            border-left: 1px outset #AAAAAA;
            border-bottom: 1px outset #AAAAAA;
        }

        .tda {
            border-bottom: 1px outset #AAAAAA;
            width: 300px;
        }

        .shf {
            background-color: #eaeaea;
            width: 104px;
            border: 2px inset;
            color: Gray;
            padding-right: 2px;
            padding-left: 2px;
        }
    </style>
    <script src="jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
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
    <div runat="server" id="divform" class="pg" style="background-color:lightblue;">
        <topyca:PageHeader runat="server" ID="PageHeader1" Header="שאלון לניהול תמיכות"
            ButtonJava="" />
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        </div>
        <div style="vertical-align: middle;">
            <input type="button" onclick="fout(this);" value="-"
                style="width: 15px; height: 20px; background: transparent; font-size: medium; display: none" /><span class="blockHeader"></span>
            <table class="tbld" id="tbldef">
                <tr class="blockfooter">
                    <td class="tdr" style="width: 12%; font-weight: bold;">שם הלקוח</td>
                    <td style="width: 15%">&nbsp;&nbsp;
						<asp:Label runat="server" Text="Label" ID="lblName"></asp:Label>
                        <asp:Label runat="server" ID="lblh1" Width="1" Visible="false"></asp:Label>
                    </td>
                    <td class="tdr" style="width: 12%; font-weight: bold;">
                        <asp:Label runat="server" ID="lblh3">תאריך השאלון</asp:Label>
                    </td>
                    <td style="width: 61%">&nbsp;&nbsp;
									<asp:TextBox runat="server" ID="tbdate" Text="" Width="60" AutoPostBack="True"
                                        ToolTip="לשינוי התאריך הקש תאריך במבנה dd/mm/yy והקש enter" />
                        <asp:RangeValidator ID="RangeValidator1" runat="server"
                            ControlToValidate="tbdate" Display="Dynamic" ErrorMessage="תאריך לא חוקי"
                            MaximumValue="2015-12-31" MinimumValue="2000-1-1" Type="Date"></asp:RangeValidator>
                    </td>
                </tr>
                <tr>
                    <td style="font-weight: bold;">מספר השאלון
                    </td>
                    <td>&nbsp;&nbsp;  
						<asp:Label ID="lblNo" runat="server" Text="Label"></asp:Label>
                    </td>
                    <td style="font-weight: bold;">סטטוס
                    </td>
                    <td>&nbsp;&nbsp;
					<asp:Label runat="server" ID="lblstatus"
                        Text="Label"></asp:Label>&nbsp;&nbsp;<asp:Label runat="server" ID="lblpleaseclose" Text="-" />
                    </td>
                </tr>
            </table>
            <asp:Label ID="LBLERR" runat="server" ForeColor="Red"
                Text="הגדרת שאלון לא חוקית" Visible="False" Width="400px"></asp:Label>
        </div>

        <asp:Panel runat="server" Style="max-height: 570px;" Width="800px" ScrollBars="Auto">
            <asp:UpdatePanel runat="server" ID="up_q">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblgrouphdr" runat="server" Font-Size="Large" Font-Bold="true" BackColor="Gray" Width="785px"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField runat="server" ID="hdnCurrentPage" />
                    <div runat="server" id="divlvq" style="vertical-align: top">
                        <asp:ListView ID="lv_q" runat="server">
                            <LayoutTemplate>
                                <table cellpadding="4" runat="server" id="itemPlaceHolderContainer">
                                    <tr runat="server" id="itemPlaceHolder">
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td style="background-color: Silver; border: 1px dotted Gray;">
                                        <asp:Label ID="lblid_q" runat="server" Text='<%#Eval("id")%>' Width="10px"></asp:Label>
                                    </td>
                                    <td style="background-color: Silver; border-top: 1px dotted black; border-bottom: 1px dotted black;">
                                        <asp:Label ID="lbltxt_q" runat="server" Text='<%#"<div>" & Eval("txt") & "</div>"%>' Width="120px"></asp:Label>
                                    </td>
                                    <td style='<%#Eval("style")%>'>
                                        <asp:Label runat="server" ID="lblSumGroup" Visible='<%# Eval("sumGrp")="sum" %>' OnPreRender="lblSumGroup_PreRender" Style="float: left;" />
                                        <asp:HiddenField runat="server" ID="hdnAnswerGroupId" Value='<%# Eval("AnswerGroupId")%>' />
                                        <asp:HiddenField runat="server" ID="hdnfQ" Value='<%# Eval("fQ") %>' />
                                        <asp:HiddenField runat="server" ID="hdnlQ" Value='<%# Eval("lQ") %>' />
                                        <asp:HiddenField ID="HDNANS_q" Value='<%#Eval("ans") %>' runat="server" />
                                        <asp:HiddenField runat="server" ID="hdnid_q" Value='<%#Eval("id")%>' />
                                        <asp:HiddenField runat="server" ID="HDNAID_q" Value='<%#Eval("ansID") %>' />
                                        <asp:RadioButtonList ID="rbla_q" AutoPostBack="true" OnSelectedIndexChanged="rbla_SelectedIndexChanged" CausesValidation="true" OnPreRender="rbla_PreRender" OnDataBinding="rbla_DataBinding" CssClass="rbl" AppendDataBoundItems="true" runat="server" OnLoad="rbla_Load" RepeatDirection="Horizontal" DataTextField="txt" Font-Size="X-Small" RepeatLayout="Table" DataValueField="val" CellPadding="4" CellSpacing="2" Width="620">
                                        </asp:RadioButtonList>
                                        <asp:RangeValidator runat="server" ID="rvrbl" OnPreRender="rv_PreRender" ControlToValidate="rbla_q" SetFocusOnError="true" ErrorMessage="לא ניתן לשנות ערכים בשאלון סגור" Display="Dynamic" Type="Integer" MaximumValue="-5" MinimumValue="-5" Enabled="false" />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div runat="server" id="diveduResults" visible="false">
                        <table>
                            <tr>
                                <td>
                                    <asp:ListView runat="server" ID="lveduResults">
                                        <LayoutTemplate>
                                            <table>
                                                <thead style="background-color: Gray; font-weight: bold;">
                                                    <tr>
                                                        <td>תחום</td>
                                                        <td>רמת תמיכה</td>
                                                    </tr>
                                                </thead>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                                <tr>
                                                </tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td style="border: 1px dotted Gray;">
                                                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("grp")%>' /></td>
                                                <td style="background-color: #EEEEEE;">
                                                    <asp:Label runat="server" ID="lblRT" Text='<%# Eval("perc", "{0:0.00}")%>' /></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                                <td style="vertical-align: bottom;"></td>
                            </tr>
                        </table>
                        <asp:Chart runat="server" ID="chrtG" Width="795px" Height="350px">
                        </asp:Chart>
                    </div>
                    <div style="padding-left: 30px;">
                        <asp:ListView runat="server" ID="lvbuttons" DataSourceID="dsbuttons" DataKeyNames="gid">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceHolderContainer" style="float: left;">
                                    <tr>
                                        <td runat="server" id="itemPlaceHolder">
                                            <td>&nbsp;&nbsp;</td>

                                        </td>
                                    </tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <td>
                                    <asp:Button runat="server" ID="btngid" Text='<%# Eval("sName")%>' BackColor="#C0C0C0" ToolTip='<%# Eval("Name")%>' OnClick="btngid_Click" OnPreRender="btngid_PreRender" /></td>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div>
                        <table>
                            <tr>
                                <td style="width: 200px;"></td>
                                <td style="background-color: #EEEEEE; padding: 5px  0px 5px 0px;">
                                    <asp:Button runat="server" ID="btnVersions" Text="הצג גם גרסאות קודמות" Style="float: left;" /></td>
                                <td style="background-color: #EEEEEE; padding: 5px  0px 5px 0px;">
                                    <asp:Button ID="btnSave" runat="server" Text="שמירת שאלון" Width="90px" ToolTip="השאלון יישמר, יהיה בסטאטוס פתוח וניתן לחזור אליו להמשך עדכון" />
                                </td>
                                <td style="background-color: #EEEEEE;">
                                    <asp:Button runat="server" Text="סגירת שאלון" Width="90px" ID="BTNCLS" OnClick="BTNCLS_Click" ToolTip="השאלון יישמר, יהיה בסטאטוס סגור, מעבר אוטומטית לדף התוצאות" />
                                </td>
                                <td style="background-color: #EEEEEE;">
                                    <asp:Button runat="server" Text="מחיקת שאלון" Width="90px" ID="BTNCNCL" OnClientClick="return confirm('האם למחוק את השאלון?');" CausesValidation="False" />
                                </td>
                                <td style="background-color: #EEEEEE;">
                                    <asp:Button ID="btnBACK" runat="server" PostBackUrl="~/CustEventReport.aspx" Text="חזרה לתיקי לקוחות" Width="120px" ToolTip="חזרה לעמוד ניהול תיק לקוח" />
                                </td>
                            </tr>
                        </table>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>


    </div>
    <asp:SqlDataSource ID="dsbuttons" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT [gid], ISNULL(ShortName,[Name]) sName,Name FROM [p5t_FormQuestionGroups] WHERE ([EventTypeId] = @EventTypeId)">
        <SelectParameters>
            <asp:Parameter DefaultValue="127" Name="EventTypeId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

