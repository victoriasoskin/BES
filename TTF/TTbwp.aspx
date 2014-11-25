<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="TTbwp.aspx.cs" Inherits="TTF.TTbwp" MaintainScrollPositionOnPostback="true" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .wkhide {
            position: fixed;
            top: 120px;
            left: 100px;
            width: 820px;
            background-color: red;
            border: 3px outset gray;
            height: 400px;
            overflow: scroll;
            display: none;   
        }

        .wkshow {  
            position: fixed;   
            top: 120px;
            left: 100px;
            width: 820px;
            background-color: #EEEEEE;
            border: 3px outset gray;  
            height: 400px;
            overflow: scroll;
            display: block;
        }
             
        .dayw {
            width: 114px;
            min-height: 40px;
            background-color: white;
            white-space: normal;
            font-size: 14px;
            background-color: white;
            border: 2px outset lightgray;
            cursor: pointer;
            vertical-align: top;
            position: relative;
        }

        .delbtn {
            height: 20px;
            width: 20px;
            position: absolute;
            bottom: 0px;
            left: 0px;
        }
    
    </style>
    <script type="text/javascript">
        //test start
        
        //test end
        $("#HyperLink1").click(function () {
            window.open(this.attr);
        })

        var param = '';
        function OpenPopUP(x) {
            param = x;
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            alert("openPopup");
            z.className = 'wkshow';
        }
        function hideweek() {
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            //alert("hide");
            z.className = 'wkhide';
        }
        function showweek() {
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            alert("show");
            z.className = 'wkshow';
            
        }
        function delweek(x, p) {
            if (confirm('למחוק?')) {
                var y = parseInt(x / 100000);
                window.open('delweek.aspx?id=' + y,'_blank');
                //            __doPostBack('+_+week', 'd|א|' + y);
            }
        }

        function CheckLength(textBox, maxLength) {
            if (textBox.value.length > maxLength) {
                alert("Max characters allowed are " + maxLength);
                textBox.value = textBox.value.substr(0, maxLength);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--    ---------------------------
        כפתור חזרה, הדפסה, וורד, אקסל למערכת הניהול
        -------------------------- ---%>
    
    <div style="position: fixed; top: 0px; right: 9px; z-index: 888;">
        <asp:Button runat="server" ID="lnkbback" PostBackUrl="~/CustEventReport.Aspx"  Text="חזור&nbsp;↻" Font-Bold="true" BorderStyle="Solid" CausesValidation="false" />
        <asp:Button runat="server" ID="HyperLink1" Text="הדפסה " Font-Bold="true" BorderStyle="Solid"  OnClientClick="<%HyperLink1_Click()%>"   />
       <%-- <asp:HyperLink runat="server" ID="hlprint" Text="הדפסה" CausesValidation="false" OnPreRender="hlprint_PreRender" Target="_blank" />--%>
    </div>

    <%--    ---------------------------
        קודים נשמרים
        -------------------------- ---%>

    <asp:HiddenField runat="server" ID="hdnCurrentEventId" />
    <asp:HiddenField runat="server" ID="hdnItemHandled" />
    <asp:HiddenField runat="server" ID="hdnCurrentWpId" />
    <asp:HiddenField runat="server" ID="hdnForm139" />
    <asp:HiddenField runat="server" ID="hdnDate139" />
    <asp:HiddenField runat="server" ID="hdnWeekShow" Value="wkhide" />

    <%--    ---------------------------
        כותרת הדף (fixed)
        -------------------------- ---%>

    <div id="divheader" class="divHeader">
        <asp:ListView runat="server" ID="lvHdr" OnDataBinding="lvHdr_DataBind" Style="top: 0px; right: 5px">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0" class="lstv lvHeader">
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <table style="width: 100%; font-size: small;">
                            <tr>
                                <td colspan="6" style="text-align: center;">
                                    <span style="font-size: xx-large; font-weight: bold;"><%#"תוכנית תמיכות - " + Eval("Name") %></span>

                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; width: 100px;">ת.ז:
                                </td>
                                <td>
                                    <%#Eval("CustomerID")%>
                                    <asp:HiddenField runat="server" ID="hdnFormHeader" Value='<%#"תוכנית תמיכות חינוך " + Eval("Name") %>' />
                                </td>
                                <td style="font-weight: bold;">ת.לידה:
                                </td>
                                <td>
                                    <%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;">מסגרת:
                                </td>
                                <td>
                                    <%#Eval("FrameName")%>
                                </td>
                                <td style="font-weight: bold; width: 60Px;">ת.קליטה:
                                </td>
                                <td style="width: 60px;">
                                    <asp:Label runat="server" ID="lblStart" Text='<%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>' />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;">מעדכן התוכנית:
                                </td>
                                <td>
                                    <%#Eval("URName")%>
                                </td>
                                <td style="font-weight: bold;">ת.פתיחה:
                                </td>
                                <td>
                                    <%#Eval("OpenDate", "{0:dd/MM/yyyy}")%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <div style="position: absolute; top: 108px; right: 0px; padding-right: 5px; width: 950px;">

        <%--    ---------------------------
        תוכנית אב
        -------------------------- ---%>
        <div style="display: none;">

            <asp:ListView runat="server" ID="lvMP" DataSourceID="DSMP" OnItemEditing="lv_ItemEditing" OnItemCanceling="lv_ItemCanceling" OnPreRender="lvMP_PreRender" InsertItemPosition="FirstItem">
                <LayoutTemplate>
                    <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                        <thead>
                            <tr>
                                <td colspan="10" style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;">בניית תוכנית תמיכות
                                </td>
                            </tr>
                        </thead>
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </table>
                </LayoutTemplate>

                <%--    ---------------------------
            תוכנית אב תצוגה
            -------------------------- ---%>

                <ItemTemplate>
                    <tr class="phdr">
                        <td colspan="10">תוכנית אב
                        <asp:Button runat="server" ID="lnkbEdit" Text="עריכה" CssClass="btns" CommandName="edit" CausesValidation="false" Visible='<%#isUpdatable() %>'></asp:Button>
                            <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">שם מתאם תמיכות
                        </td>
                        <td class="dataCell">
                            <%#Eval("SupportCoordinator") %>
                        </td>
                        <td class="rowHeader">שם מדריך
                        </td>
                        <td colspan="7" class="dataCell">
                            <%#Eval("Supporter") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">מילוי שאלון איכות חיים
                        </td>
                        <td class="dataCell">
                            <asp:Label runat="server" ID="lblD51" OnPreRender="lblDxxx_PreRnder" />
                            <asp:HiddenField runat="server" ID="hdnGraphForm" Value='<%#Eval("E127") %>' />
                        </td>
                        <td class="rowHeader">מילוי שאלון כלי לניהול תמיכות
                        </td>
                        <td colspan="7" class="dataCell">
                            <asp:Label runat="server" ID="lblD139" OnPreRender="lblDxxx_PreRnder" />

                            <%--                        <%# string.Format("{0:dd/MM/yyyy}", (DateTime)Eval("D51")) %>--%>
                        </td>
                    </tr>
                    <tr class="psubhdr">
                        <td colspan="10">רקע
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">גיל</td>
                        <td class="dataCell">
                            <asp:Label runat="server" ID="lblAge" OnPreRender="lblAge_PreRender" />
                        </td>
                        <td class="rowHeader">שנת קבלה למסגרת</td>
                        <td class="dataCell">
                            <asp:Label runat="server" ID="lblStartYear" OnPreRender="lblStart_Prerender"></asp:Label>
                        </td>
                        <td class="rowHeader">מקום מגורים</td>
                        <td class="dataCell">
                            <%#Eval("Location") %>
                        </td>
                        <td class="rowHeader">מצב משפחתי</td>
                        <td class="dataCell">
                            <%#Eval("FamilyStatus") %>
                        </td>
                        <td class="rowHeader">כיתה</td>
                        <td class="dataCell" style="white-space: nowrap;">
                            <%#Eval("Class") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">חוזקות
                        </td>
                        <td colspan="9" class="dataCell">
                            <%#Eval("Strength") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">פעילות פנאי
                        </td>
                        <td colspan="9" class="dataCell">
                            <%#Eval("Hobby") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">מסגרת קודמת
                        </td>
                        <td colspan="9" class="dataCell">
                            <%#Eval("PreviousFrame") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">מידע נוסף

                        </td>
                        <td colspan="9" class="dataCell">
                            <%#Eval("OtherInfo") %>
                        </td>
                    </tr>
                    <tr>

                        <%--    ---------------------------
                        תוכנית אב - גרף
                        -------------------------- ---%>

                        <td colspan="10">
                            <%--<div style="position: relative;">
                                <asp:LinkButton runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; left: 0px;" />
                                <asp:Chart ID="Chart1" runat="server" Width="940px" Height="500px" DataSourceID="DSGRAPH" BorderlineColor="gray" BackColor="LightGray" OnPrePaint="chrt_OnPrePaint" OnClick="chrt_Drill">
                                    <Titles>
                                        <asp:Title Text="תוצאות השאלון העדכני לניהול תמיכות" Font="Arial, 18pt, style=Bold, Italic">
                                        </asp:Title>
                                    </Titles>
                                    <Series>
                                        <asp:Series Name="Series1" ChartType="Column" XValueMember="Grp" YValueMembers="perc" BorderWidth="3" IsValueShownAsLabel="true" LabelFormat="{0:0.00}" Color="DarkBlue" PostBackValue="#VALX">
                                        </asp:Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1">
                                            <AxisX IsReversed="true">
                                                <MajorGrid Enabled="false" />

                                            </AxisX>
                                            <AxisY Minimum="0" Maximum="4" Interval="1" />
                                        </asp:ChartArea>
                                    </ChartAreas>
                                </asp:Chart>
                            </div>--%>
                        </td>
                    </tr>
                </ItemTemplate>

                <%--    ---------------------------
        תוכנית אב - הוספה
        -------------------------- ---%>

                <InsertItemTemplate>
                    <tr>
                        <td colspan="10" class="pEhdr">תוכנית אב חדשה
                        <asp:Button runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:Button>
                            <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button>
                            <asp:HiddenField runat="server" ID="hdnMPId" Value='<%#Eval("Id") %>' />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td colspan="2">מתאם תמיכות
                        </td>
                        <td colspan="2">
                            <asp:TextBox runat="server" ID="tbSuppCoord" MaxLength="150" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="tbSuppCoord" Display="Dynamic" ErrorMessage="יש להקליד מתאם תמיכות" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                        <td colspan="2">מדריך
                        </td>
                        <td colspan="4">
                            <asp:TextBox runat="server" ID="tbInstr" MaxLength="20" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מתאם תמיכות" ValidationGroup="MP" ForeColor="Red" />
                        </td>

                    </tr>
                    <tr class="editbck">
                        <td colspan="2">מילוי שאלון איכות חיים
                        </td>
                        <td colspan="2">
                            <asp:Label runat="server" ID="lblD139" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                        <td colspan="2">מילוי שאלון כלי לניהול תמיכות
                        </td>
                        <td colspan="4">
                            <asp:Label runat="server" ID="lblD51" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                    </tr>
                    <tr class="pEsubhdr">
                        <td colspan="10">רקע
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>גיל</td>
                        <td>
                            <asp:Label runat="server" ID="lblAge" OnPreRender="lblAge_PreRender" />
                        </td>
                        <td>שנת קבלה למסגרת</td>
                        <td>
                            <asp:Label runat="server" ID="lblStartYear" OnPreRender="lblStart_Prerender"></asp:Label>
                        </td>
                        <td>מקום מגורים</td>
                        <td>
                            <asp:TextBox runat="server" ID="tbLocation" MaxLength="20" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מקום מגורים" ValidationGroup="MP" ForeColor="Red" />
                        </td>
                        <td>מצב משפחתי</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlFamState" AppendDataBoundItems="true" Width="150" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="ddlFamState" Display="Dynamic" ErrorMessage="יש לבחור מצב משפחתי" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                        <td>כיתה</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlLayer" AppendDataBoundItems="true" Width="70" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="ddlLayer" Display="Dynamic" ErrorMessage="יש לבחור בשכבה" ForeColor="Red" ValidationGroup="MP" />
                            <asp:DropDownList runat="server" ID="ddlClass" AppendDataBoundItems="true" Width="70" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlClass" Display="Dynamic" ErrorMessage="יש לבחור במספר כיתה" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>חוזקות
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbStrength" Width="600" MaxLength="150" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>פעילות פנאי
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbHobby" Width="600" MaxLength="150" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>מסגרת קודמת
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbPreviousFrame" Width="600" MaxLength="150" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>מידע נוסף

                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbOtherInfo" Width="600" MaxLength="150"  />
                        </td>
                    </tr>
                    <tr>

                        <%--    ---------------------------
                    תוכנית אב - גרף בהוספה
                    -------------------------- ---%>

                        <td colspan="10">
                            <div style="position: relative;">
                                <asp:Button  runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; left: 0px;"/>
<%--                                <asp:LinkButton runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; left: 0px;" />--%>
                                <asp:Chart ID="Chart1" runat="server" Width="940px" Height="500px" DataSourceID="DSGRAPH" BorderlineColor="gray" BackColor="LightGray" OnPrePaint="chrt_OnPrePaint" OnClick="chrt_Drill">

                                    <Titles>
                                        <asp:Title Text="תוצאות השאלון העדכני לניהול תמיכות" Font="Arial, 18pt, style=Bold, Italic">
                                        </asp:Title>
                                    </Titles>
                                    <Series>
                                        <asp:Series Name="Series1" ChartType="line" XValueMember="Grp" YValueMembers="perc" BorderWidth="3" IsValueShownAsLabel="true" LabelFormat="{0:0.00}" Color="DarkBlue" PostBackValue="#VALX">
                                        </asp:Series>
                                    </Series>
                                    <ChartAreas>
                                        <asp:ChartArea Name="ChartArea1">
                                            <AxisX IsReversed="true" Interval="1">
                                                <MajorGrid Enabled="false" />

                                            </AxisX>
                                            <AxisY Minimum="-1" Maximum="4" Interval="1" />
                                        </asp:ChartArea>
                                    </ChartAreas>
                                </asp:Chart>
                            </div>

                        </td>
                    </tr>
                </InsertItemTemplate>

                <%--    ---------------------------
                תוכנית אב - עריכה
                -------------------------- ---%>

                <EditItemTemplate>
                    <tr>
                        <td colspan="10" class="pEhdr">עריכת תוכנית אב
                        <asp:Button runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:Button>
                            <%--                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:LinkButton>--%>
                            <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button>
                            <asp:HiddenField runat="server" ID="hdnMPId" Value='<%#Eval("Id") %>' />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td colspan="2">מתאם תמיכות
                        </td>
                        <td colspan="2">
                            <asp:TextBox runat="server" ID="tbSuppCoord" Text='<%# Eval("SupportCoordinator") %>' />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="tbSuppCoord" Display="Dynamic" ErrorMessage="יש להקליד מתאם תמיכות" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                        <td colspan="2">מדריך
                        </td>
                        <td colspan="4">
                            <asp:TextBox runat="server" ID="tbInstr" Text='<%# Eval("Supporter") %>' MaxLength="150" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מדריך" ValidationGroup="MP" ForeColor="Red" />
                        </td>

                    </tr>
                    <tr class="editbck">
                        <td colspan="2">מילוי שאלון איכות חיים
                        </td>
                        <td colspan="2">
                            <asp:Label runat="server" ID="lblD139" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                        <td colspan="2">מילוי שאלון כלי לניהול תמיכות
                        </td>
                        <td colspan="4">
                            <asp:Label runat="server" ID="lblD51" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                    </tr>
                    <tr class="pEsubhdr">
                        <td colspan="10">רקע
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>גיל</td>
                        <td>
                            <asp:Label runat="server" ID="lblAge" OnPreRender="lblAge_PreRender" />
                        </td>
                        <td>שנת קבלה למסגרת</td>
                        <td>
                            <asp:Label runat="server" ID="lblStartYear" OnPreRender="lblStart_Prerender"></asp:Label>
                        </td>
                        <td>מקום מגורים</td>
                        <td>
                            <asp:TextBox runat="server" ID="tbLocation" Text='<%# Eval("Location") %>' MaxLength="20" />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מקום מגורים" Text='<%# Eval("Location") %>' ValidationGroup="MP" ForeColor="Red" />
                        </td>
                        <td>מצב משפחתי</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlFamState" AppendDataBoundItems="true" Width="150" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding" SelecetedValue='<%# Eval("FamilyStatusId") %>'>
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hdnFamState" Value='<%# Eval("FamilyStatusId") %>' />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="tbLocation" Display="Dynamic" ErrorMessage="יש לבחור מצב משפחתי" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                        <td>כיתה</td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlLayer" AppendDataBoundItems="true" Width="70" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding" SelecetedValue='<%# Eval("LayerId") %>'>
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hdnLayer" Value='<%# Eval("LayerId") %>' />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="ddlLayer" Display="Dynamic" ErrorMessage="יש לבחור בשכבה" ForeColor="Red" ValidationGroup="MP" />
                            <asp:DropDownList runat="server" ID="ddlClass" AppendDataBoundItems="true" Width="70" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding" SelecetedValue='<%# Eval("ClassId") %>'>
                            </asp:DropDownList>
                            <asp:HiddenField runat="server" ID="hdnClass" Value='<%# Eval("ClassId") %>' />
                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator8" ControlToValidate="ddlClass" Display="Dynamic" ErrorMessage="יש לבחור במספר כיתה" ForeColor="Red" ValidationGroup="MP" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>חוזקות
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbStrength" Width="600" Text='<%# Eval("Strength") %>' MaxLength="150" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>פעילות פנאי
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbHobby" Width="600" Text='<%# Eval("Hobby") %>' MaxLength="150" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')"/>
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>מסגרת קודמת
                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbPreviousFrame" Width="600" Text='<%# Eval("PreviousFrame") %>' MaxLength="150" onkeypress="if (this.value.length==100) alert('לא ניתן להקליד עוד')" />
                        </td>
                    </tr>
                    <tr class="editbck">
                        <td>מידע נוסף

                        </td>
                        <td colspan="9">
                            <asp:TextBox runat="server" ID="tbOtherInfo" Width="600" Text='<%# Eval("OtherInfo") %>' MaxLength="150" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')"/>
                        </td>
                    </tr>
                   

                        <%--    ---------------------------
                תוכנית אב - גרף בעריכה
                -------------------------- ---%>

                       
                   
                </EditItemTemplate>
            </asp:ListView>
        </div>

        <div>
            <asp:Button runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; right: 5px; width:100px; background-color:darkgrey ; font-weight:bold"/>
<%--            <asp:LinkButton runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; left: 0px;" />--%>
            <asp:Chart ID="Chart1" runat="server" Width="940px" Height="500px" DataSourceID="DSGRAPH" BorderlineColor="#A5C3DE" BorderlineWidth="2" BackColor="#A5C3DE" OnPrePaint="chrt_OnPrePaint" OnClick="chrt_Drill">
                <Titles>
                    <asp:Title Text="תוצאות כלי לניהול תמיכות" Font="Arial, 18pt, style=Bold, Italic">
                    </asp:Title>
                </Titles>
                <Series>
                    <asp:Series Name="Series1" ChartType="column" XValueMember="Grp" YValueMembers="perc" BorderWidth="3" IsValueShownAsLabel="true"  LabelFormat="{0:0.00}" Color="DarkBlue" PostBackValue="#VALX">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisX IsReversed="true" interval="1">
                            <MajorGrid Enabled="false" />

                        </AxisX>
                        <AxisY Minimum="0" Maximum="4" Interval="1" />
                    </asp:ChartArea>
                </ChartAreas>
            </asp:Chart>
        </div>
        <%--    ---------------------------
        תוכנית תמיכות
        -------------------------- ---%>

        <asp:ListView runat="server" ID="lvWP" DataSourceID="DSWP" OnItemEditing="lv_ItemEditing" OnItemCanceling="lv_ItemCanceling" InsertItemPosition="FirstItem" OnLoad="lvWP_Load" OnPreRender="lvWP_PreRender" OnItemDeleting="lvWP_ItemDeleting">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl" >
                    <thead>
                        <tr>
                            <td colspan="5" style="font-weight: bold; font-size: medium; text-align: center; background-color: #74a3e6; color: black; font-weight:bold; font-style:italic;font-size:x-large">בניית תוכנית תמיכות
                                <asp:Button runat="server" ID="lnkbShowAdd" Text="הוספת תמיכה חדשה" CssClass="btns" ForeColor="black" OnPreRender="lnkbShowAdd_PreRender" Font-Bold="true" OnClick="lnkbShowAdd_Click"></asp:Button>
                            </td>
                        </tr>
                    </thead>
                    <tr runat="server" id="itemPlaceholder">
                    </tr>
                </table>
            </LayoutTemplate>

            <%--    ---------------------------
            תוכנית תמיכות תצוגה
            -------------------------- ---%>

            <ItemTemplate >
               
                <tr class="phdr" >
                    <td colspan="2">תמיכה מספר <%#Eval("Ln") %>
                        <asp:Label runat="server" ID="TT_Creation_Date" > :תאריך פתיחה  <%#Eval("LoadTime","{0:dd/MM/yyyy}") %></asp:Label>
                        <asp:Button runat="server" ID="lnkbEdit" Text="עריכה"  Font-Bold="true" CssClass="btns" CommandName="edit" CausesValidation="false" Visible='<%#isUpdatable() %>'></asp:Button>
                        <asp:Button runat="server" ID="lnkbDelete" Text="מחיקה" Font-Bold="true" CssClass="btns" OnClientClick="return confirm('האם למחוק?');" CausesValidation="false" CommandName="delete" Visible='<%#isUpdatable() %>'></asp:Button>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="ptbl">
                            <tr>
                                <td class="rowHeader" style="width: 50px;">תחום
                                </td>
                                <td class="rowsColor">
                                    <%#Eval("Range") %>
                                </td>
                                <tr>
                                    <td class="rowHeader" style="width: 50px;">נושא
                                    </td>
                                    <td class="rowsColor">
                                        <%#Eval("Subject") %>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="rowHeader" rowspan="2">מטרת על
                                    </td>
                                    <td class="rowsColor">
                                        <%#Eval("Purpose") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowsColor">
                                        <asp:HiddenField runat="server" ID="hdnTargetId" Value='<%#Eval("TargetId") %>' />
                                        <%#Eval("Target") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeader" style="width: 50px;">דרגת חשיבות
                                    </td>
                                    <td class="rowsColor">
                                        <%#Eval("Weight") %>
                                    </td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>

                        <%--אינדקסים - תצוגה בתצוגה של תמיכה--%>

                        <asp:ListView runat="server" ID="lvIndexes" OnPreRender="lvIdexes_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="rowHeader" style="direction: ltr; width: 22px; text-align: right;">
                                        <asp:Label runat="server" ID="lblIndexName" Text='<%#Eval("Name") %>' OnPreRender="lblIndexName_PreRender" />
                                    </td>
                                    <td class="rowsColor" style="width: 400px;">
                                        <asp:Label runat="server" ID="lblIndex" Text='<%#Eval("Text") %>' />
                                        <asp:HiddenField runat="server" ID="hdnIndexId" Value='<%#Eval("IndexId") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>

                </tr>

                <tr class="psubhdr">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>
                <tr>
                    <td>
             

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="psubhdr">
                                        <td>תיאור</td>
                                        <td>תקופת התמיכה</td>
                                        <td>תדירות</td>
                                        <td>משך התמיכה</td>
                                        <td>ספק התמיכה</td>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td class="rowsColor" style="width: 550px;">
                                        <%#Eval("Text") %>
                                    </td>
                                    <td class="rowsColor"><%#Eval("Period") %></td>
                                    <td class="rowsColor"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td class="rowsColor"><%#Eval("length") %></td>
                                    <td class="rowsColor"><%#Eval("Helper") %> <br />
                                        <a href='<%# string.Format("javascript:OpenPopUP({0});", Eval("Id")) %>'>הוסף לשבוע</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>




                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color: #A5C3DE;">
                    <td>
                        <input type="button" id="showWeekBTN"  value="הצגת תוכנית שבועית" style="color:black ; font-weight:bold; background-color: lightgray " onclick="showweek();"/>
                        <%--<a href="javascript:showweek();" style="color: black; font-weight:bold">הצגת תוכנית שבועית</a>--%>
                    </td>
                </tr>
                     
            </ItemTemplate>
            <AlternatingItemTemplate>
                <tr class="phdrAlternate">
                    <td colspan="2">תמיכה מספר <%#Eval("Ln") %>
                        <asp:Label runat="server" ID="TT_Creation_Date" > :תאריך פתיחה  <%#Eval("LoadTime","{0:dd/MM/yyyy}") %></asp:Label>
                        <asp:Button runat="server" ID="lnkbEdit" Text="עריכה"  Font-Bold="true" CssClass="btns" CommandName="edit" CausesValidation="false" Visible='<%#isUpdatable() %>'></asp:Button>
                        <asp:Button runat="server" ID="lnkbDelete" Text="מחיקה" Font-Bold="true" CssClass="btns" OnClientClick="return confirm('האם למחוק?');" CausesValidation="false" CommandName="delete" Visible='<%#isUpdatable() %>'></asp:Button>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="ptblAlternate">
                            <tr>
                                <td class="rowHeaderAlternate" style="width: 50px;">תחום
                                </td>
                                <td class="rowsColorAlternate">
                                    <%#Eval("Range") %>
                                </td>
                                <tr>
                                    <td class="rowHeaderAlternate" style="width: 50px;">נושא
                                    </td>
                                    <td class="rowsColorAlternate">
                                        <%#Eval("Subject") %>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="rowHeaderAlternate" rowspan="2">מטרת על
                                    </td>
                                    <td class="rowsColorAlternate">
                                        <%#Eval("Purpose") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowsColorAlternate">
                                        <asp:HiddenField runat="server" ID="hdnTargetId" Value='<%#Eval("TargetId") %>' />
                                        <%#Eval("Target") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeaderAlternate" style="width: 50px;">דרגת חשיבות
                                    </td>
                                    <td class="rowsColorAlternate">
                                        <%#Eval("Weight") %>
                                    </td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>

                        <%--אינדקסים - תצוגה בתצוגה של תמיכה--%>

                        <asp:ListView runat="server" ID="lvIndexes" OnPreRender="lvIdexes_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptblAlternate">
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr>
                                    <td class="rowHeaderAlternate" style="direction: ltr; width: 22px; text-align: right;">
                                        <asp:Label runat="server" ID="lblIndexName" Text='<%#Eval("Name") %>' OnPreRender="lblIndexName_PreRender" />
                                    </td>
                                    <td class="rowsColorAlternate" style="width: 400px;">
                                        <asp:Label runat="server" ID="lblIndex" Text='<%#Eval("Text") %>' />
                                        <asp:HiddenField runat="server" ID="hdnIndexId" Value='<%#Eval("IndexId") %>' />
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>

                </tr>

                <tr class="psubhdrAlternate">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>
                <tr>
                    <td>
             

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="psubhdrAlternate">
                                        <td>תיאור אינדקסים - תצוגה בתצוגה של תמיכה</td>
                                        <td>תקופת התמיכה</td>
                                        <td>תדירות</td>
                                        <td>משך התמיכה</td>
                                        <td>ספק התמיכה</td>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td class="rowsColorAlternate" style="width: 550px;">
                                        <%#Eval("Text") %>
                                    </td>
                                    <td class="rowsColorAlternate"><%#Eval("Period") %></td>
                                    <td class="rowsColorAlternate"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td class="rowsColorAlternate"><%#Eval("length") %></td>
                                    <td class="rowsColorAlternate"><%#Eval("Helper") %> <br />
                                        <a href='<%# string.Format("javascript:OpenPopUP({0});", Eval("Id")) %>'>הוסף לשבוע</a>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>




                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color: #8FDCF1;">
                    <td><input type="button" id="showWeekBTN"  value="הצגת תוכנית שבועית" style="color:black ; font-weight:bold; background-color: lightgray " onclick="showweek();"/>
                    </td>
                </tr>

            </AlternatingItemTemplate>
            <%--    ---------------------------
        תוכנית תמיכות - הוספה
        -------------------------- ---%>

            <InsertItemTemplate>
                <tr>
                    <td colspan="5" class="NewSuppPhdr">תמיכה חדשה
                        <asp:Button runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbWP_Click"></asp:Button>
                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה והוספת פירוט" CssClass="btns" OnClick="lnkbWP_Click"></asp:Button>
<%--                        <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false" />--%>
                      <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>
                        <table class="ptbl">
                            <tr>
                                <td class="NewTTLable" style="width: 50px;">תחום
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlRange" AppendDataBoundItems="true" AutoPostBack="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="150" OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="rfvRange" ControlToValidate="ddlRange" ErrorMessage="יש לבחור בתחום" ForeColor="Red" Display="Dynamic" />
                                </td>
                                <tr>
                                    <td class="NewTTLable">נושא
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSubject" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="150" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding"></asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvSubject" ControlToValidate="ddlSubject" ErrorMessage="יש לבחור בנושא" ForeColor="Red" Display="Dynamic" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="NewTTLable" rowspan="2">מטרת על
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPurpose" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="150" OnPreRender="ddl_PreRender">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvPurpose" ControlToValidate="ddlPurpose" ErrorMessage="יש לבחור במטרה" ForeColor="Red" Display="Dynamic" />

                                        <br />
                                        <asp:TextBox runat="server" ID="tbPurpose" Columns="50" MaxLength="50" Style="display: none;" OnPreRender="tbOther_PreRender" />
                                        <%--                                       <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="tbPurpose" ErrorMessage="כאשר בוחרים ב 'אחר (...)' יש להקליד מטרה" ForeColor="Red" Display="Dynamic" />--%>

                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlTarget" AppendDataBoundItems="true" AutoPostBack="true" OnDataBinding="ddl_DataBinding" Width="150" OnPreRender="ddl_PreRender" OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="ddlTarget" ErrorMessage="יש לבחור ביעד" ForeColor="Red" Display="Dynamic" />
                                    </td>
                                </tr>
                            </tr>
                            <tr>
                                <td class="NewTTLable" style="width: 50px;">דרגת חשיבות</td>
                                <td  style="padding-right: 5px;">
                                    <asp:DropDownList runat="server" ID="ddlWeight" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="150" OnPreRender="ddl_PreRender">
                                    </asp:DropDownList><br />
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="ddlWeight" ErrorMessage="יש לבחור בדרגת חשיבות" ForeColor="Red" Display="Dynamic" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="NewSupPsubhdr">
                    <td>יעדים ומדדים</td>
                </tr>
                <tr>
                    <td colspan="2">

                        <%--אינדקיסים בתוך הוספת תמיכה--%>
                        <table class="ptbl" id="indexTbl" runat="server">

                            <tr> <%--'+2'--%>
                                <td class="NewTTLable" style="width: 50px;">
                                    <asp:Label runat="server" ID="lblNumIndexp2" Text="+2"></asp:Label></td>
                                <td style="padding-right: 5px;"  class="editbck">
                                    <asp:TextBox runat="server" ID="tbTxtIndexm2" MaxLength="150" onkeypress="if (this.value.length==150) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="שדה חובה" ControlToValidate="tbTxtIndexm2" ForeColor="Red"></asp:RequiredFieldValidator>
                                </td>
                            </tr>

                            <tr ><%-- '+1'--%>
                                <td  class="NewTTLable" style="width: 50px;">
                                    <asp:Label runat="server" ID="lblNumIndexp1" Text="+1"></asp:Label></td>
                                <td style="padding-right: 5px;" class="editbck">
                                    <asp:TextBox runat="server" ID="tbTxtIndexm1" MaxLength="150" onkeypress="if (this.value.length==150) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="שדה חובה" ControlToValidate="tbTxtIndexm1" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                            </tr>

                            <tr ><%--0--%>
                                <td class="NewTTLable" style="width: 50px;" id="td_shimur_lable" runat="server">
                                    <asp:Label runat="server" ID="lblNumIndex00" Text="0"></asp:Label></td>
                                <td style="padding-right: 5px;" id="td_shimur" >
                                    <asp:TextBox runat="server" ID="tbTxtIndex00" MaxLength="150" onkeypress="if (this.value.length==150) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="שדה חובה" ControlToValidate="tbTxtIndex00" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                            </tr>

                            <tr ><%--'-1'--%>
                                <td class="NewTTLable" style="width: 50px;"  id="td_shipur_label" runat="server">
                                    <asp:Label runat="server" ID="lblNumIndexm1" Text="-1"></asp:Label></td>
                                <td style="padding-right: 5px;"  id="td_shipur"  >
                                    <asp:TextBox runat="server" ID="tbTxtIndexp1" MaxLength="150" onkeypress="if (this.value.length==150) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="שדה חובה" ControlToValidate="tbTxtIndexp1" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                            </tr>

                            <tr > <%-- '-2'--%>
                                <td class="NewTTLable" style="width: 50px;">
                                    <asp:Label runat="server" ID="lblNumIndexm2" Text="-2"></asp:Label></td>
                                <td style="padding-right: 5px;"  class="editbck">
                                    <asp:TextBox runat="server" ID="tbTxtIndexp2" MaxLength="150" onkeypress="if (this.value.length==150) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="שדה חובה" ControlToValidate="tbTxtIndexp2" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                            </tr>
                        </table>

                    </td>
                </tr>
                <tr class="NewSupPsubhdr">
                    <td>פרטי התוכנית</td>
                </tr>
                <tr>
                    <td>
                        <%--פירוטים בתוך הוספת תמיכה--%>
                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender" InsertItemPosition="FirstItem" OnItemInserting="Det_Inserting" OnItemEditing="lv_ItemEditing" OnItemUpdating="Det_Updating">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="NewSupPsubhdr">
                                        <td>תיאור פירוטים בתוך הוספת תמיכה</td>
                                        <td>תקופת התמיכה</td>
                                        <td>תדירות</td>
                                        <td>משך התמיכה</td>
                                        <td>ספק התמיכה</td>
                                        <td></td>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>

                            <%--תצוגה של פירוטים בהוספת תמיכה--%>

                            <ItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td style="width: 550px;">
                                        <%#Eval("Text") %>
                                    </td>
                                    <td><%#Eval("Period") %></td>
                                    <td><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td><%#Eval("length") %></td>
                                    <td><%#Eval("Helper") %></td>
                                    <td>
                                        <%--                                        <asp:Literal runat="server" ID="litDetails_Edit" OnPreRender="lit_Prerender" Text="עריכה" />
                                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="מחיקה" CssClass="btns" CommandName="delete"></asp:LinkButton>--%>
                                    </td>
                                </tr>
                            </ItemTemplate>

                            <%--הוספה של פירוטים בהוספת תמיכה--%>

                            <InsertItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td style="">
<%--                                        <textarea runat="server" id="tbDetails" maxlength="20" rows="4"   onprerender="tbDetails_PreRender" >bxhui1</textarea>--%>
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="350" TextMode="MultiLine" Rows="4" Columns="49"  onkeyup="if (this.value.length==350) alert('לא ניתן להקליד עוד')" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbDetails" ValidationExpression="^[\s\S]{0,350}$" ErrorMessage="טקסט ארוך מדי"></asp:RegularExpressionValidator>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="90" OnPreRender="ddl_PreRender"></asp:DropDownList>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="20" TextMode="MultiLine" Style="display: none;" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==20) alert('לא ניתן להקליד עוד')"/>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="20" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==20) alert('לא ניתן להקליד עוד')" /></td>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="insert"></asp:Button>
                                        <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button></td>
                                </tr>
                            </InsertItemTemplate>

                            <%--עדכון של פירוטים בהוספת תמיכה--%>

                            <EditItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td style="">
                                        <asp:HiddenField runat="server" ID="hdnId" Value='<%#Eval("Id") %>' /> bxhui4
                                       
                                         <asp:TextBox runat="server" ID="tbDetails" MaxLength="150" TextMode="MultiLine" Rows="4" Columns="49" Text='<%#Eval("Text") %>'  onkeyup="if (this.value.length==350) alert('לא ניתן להקליד עוד')"/>
                                         <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbDetails" ValidationExpression="^[\s\S]{0,350}$" ErrorMessage="טקסט ארוך מדי"></asp:RegularExpressionValidator>

                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="90" OnPreRender="ddl_PreRender" SelectedValue='<%#Eval("PeriodId") %>'></asp:DropDownList>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" TextMode="MultiLine" Text='<%#Eval("PeriodText") %>' Style="display: none;" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')"/>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("AmountId") %>'>
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("FrequencyId") %>'>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("LengthId") %>'>
                                        </asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("HelperId") %>'>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" Text='<%#Eval("HelperText") %>' OnPreRender="tbOther_PreRender" /></td>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="update"></asp:Button>

                                        <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button></td>
                                </tr>
                            </EditItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color: gray;">
                    <td></td>
                </tr>
            </InsertItemTemplate>

            <%--    ---------------------------
                עריכת תמיכה
                -------------------------- ---%>

            <EditItemTemplate>
                <tr>
                    <td colspan="5" class="pEhdr">עריכת תמיכה מספר <%#Eval("Ln") %>
                      <asp:Button runat="server" ID="lnkbSaveClose" Text="שמירה וסגירה" CommandName="Cancel" CssClass="btns"></asp:Button>
                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns"></asp:Button>
                        <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" CausesValidation="false"></asp:Button></td>
                </tr>
                <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                </td>
                </tr>
                                <tr>
                                    <td>
                                        <table class="editPtbl">
                                            <tr>
                                                <td class="EditrowHeader" style="width: 50px;">תחום
                                                </td>
                                                <td>
                                                    <%#Eval("Range") %>
                                                </td>
                                                <tr>
                                                    <td class="EditrowHeader" style="width: 50px;">נושא
                                                    </td>
                                                    <td>
                                                        <%#Eval("Subject") %>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td class="EditrowHeader" rowspan="2">מטרת על
                                                    </td>
                                                    <td>
                                                        <%#Eval("Purpose") %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:HiddenField runat="server" ID="hdnTargetId" Value='<%#Eval("TargetId") %>' />
                                                        <%#Eval("Target") %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="EditrowHeader" style="width: 50px;">דרגת חשיבות
                                                    </td>
                                                    <td>
                                                        <%#Eval("Weight") %>
                                                    </td>
                                                </tr>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                <tr class="EditpEsubhdr">
                    <td>פרטי התוכנית</td>
                </tr>
                <tr class="editbck">
                    <td>


                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender" InsertItemPosition="LastItem" DataKeyNames="Id" OnItemEditing="lv_ItemEditing" OnItemCanceling="lv_ItemCanceling" OnItemUpdating="Det_Updating">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="editPtbl">
                                    <tr class="NewSupPsubhdr">
                                        <td>תיאור</td>
                                        <td>תקופת התמיכה</td>
                                        <td>תדירות</td>
                                        <td>משך התמיכה</td>
                                        <td>ספק התמיכה</td>
                                        <td></td>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>
                            <%--תצוגה של פרטים בתוך עדכון תמיכה--%>
                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td style="width: 550px;">
                                        <asp:HiddenField runat="server" ID="hdnDetId" Value='<%#Eval("Id") %>' />
                                        <%#Eval("Text") %>
                                    </td>
                                    <td><%#Eval("Period") %></td>
                                    <td><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td><%#Eval("length") %></td>
                                    <td><%#Eval("Helper") %></td>
                                    <td>
                                        <asp:Literal runat="server" ID="litDetails_Edit" OnPreRender="lit_Prerender" Text="עריכה" />
                                        <asp:Button runat="server" ID="lnkbDelete" Text="מחיקה" CssClass="btns" OnClientClick="return confirm('האם למחוק?');" OnClick="lnkbDelete_Click"></asp:Button></td>
                                </tr>
                            </ItemTemplate>
                            <%--הוספה של פרטים בתוך עדכון תמיכה--%>
                            <InsertItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="350" TextMode="MultiLine" Rows="4" Columns="49" onkeyup="if (this.value.length==350) alert('לא ניתן להקליד עוד')" />
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbDetails" ValidationExpression="^[\s\S]{0,350}$" ErrorMessage="טקסט ארוך מדי"></asp:RegularExpressionValidator>

                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90"></asp:DropDownList>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" /></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')"/></td>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" OnClick=" InsertDetails"></asp:Button>
                                        <asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button></td>
                                </tr>
                            </InsertItemTemplate>
                            <%--עדכון של פרטים בתוך עדכון תמיכה--%>
                            <EditItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td style="">
                                        <asp:HiddenField runat="server" ID="hdnId" Value='<%#Eval("Id") %>' />
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="150" TextMode="MultiLine" Rows="4" Columns="49" Text='<%#Eval("Text") %>'  onkeyup="if (this.value.length==350) alert('לא ניתן להקליד עוד')"/>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbDetails" ValidationExpression="^[\s\S]{0,350}$" ErrorMessage="טקסט ארוך מדי"></asp:RegularExpressionValidator>

                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" SelectedValue='<%#Eval("PeriodId") %>' Width="90"></asp:DropDownList>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" /></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("AmountId") %>'>
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" SelectedValue='<%#Eval("FrequencyId") %>' AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("LengthId") %>'>
                                        </asp:DropDownList></td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("HelperId") %>'>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')" /></td>
                                    <td style="white-space: nowrap;">
                                        <asp:Button runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="update">

                                        </asp:Button><asp:Button runat="server" ID="lnkbCancel" Text="ביטול" CommandName="cancel" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:Button></td>
                                </tr>
                            </EditItemTemplate>
                        </asp:ListView>


                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color: gray;">
                    <td></td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>

        <%--    ---------------------------
            חתימות להדפסה
            -------------------------- ---%>

        <div style="width: 100%; text-align: left;">
        </div>
        <div style="width: 100%; display: none;">
            <table runat="server" id="tblsign">
                <tr style="height: 30px;">
                    <td>חתימת הדייר</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מדריך</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מתאמת</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מנהל</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת משפחה</td>
                    <td>_______________________</td>
                </tr>
            </table>
        </div>
    </div>

    <%--    ---------------------------
            תוכנית שבועית
            -------------------------- ---%>

    <div id="divWeeklytimetable" runat="server" class="wkhide" enableviewstate="false">
        <img src="Close.png" onclick="javascript:hideweek();" alt="סגור" style="position: absolute; top: 0px; left: 0px;" />
        <span style="font-size: large; font-weight: bold;">תוכנית שבועית</span>
        <hr />
        <asp:ListView runat="server" ID="LVWeeklyPlan" DataSourceID="DSWeeklyPlan" EnableViewState="false" >
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" class="lstv" style="width: 800px; direction: rtl;">
                    <thead>
                        <tr style="background-color: #C0C0C0;">
                            <th style="width: 15%">א</th>
                            <th style="width: 14%">ב</th>
                            <th style="width: 14%">ג</th>
                            <th style="width: 14%">ד</th>
                            <th style="width: 14%">ה</th>
                            <th style="width: 14%">ו</th>
                            <th style="width: 15%">ש</th>
                        </tr>
                    </thead>
                    <tr id="itemPlaceholder" runat="server">
                    </tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td onclick="__doPostBack('+_+week', param + '|א|<%#Eval("א") %>')" class="dayw" id="d1">
                        <%#WW(1) %>
                        <%#DB("א") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ב|<%#Eval("ב") %>')" class="dayw" id="d2">
                        <%#WW(2) %>
                        <%#DB("ב") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ג|<%#Eval("ג") %>')" class="dayw" id="d3">
                        <%#WW(3) %>
                        <%#DB("ג") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ד|<%#Eval("ד") %>')" class="dayw">
                        <%#WW(4) %>
                        <%#DB("ד") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ה|<%#Eval("ה") %>')" class="dayw">
                        <%#WW(5) %>
                        <%#DB("ה") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ו|<%#Eval("ו") %>')" class="dayw">
                        <%#WW(6) %>
                        <%#DB("ו") %>
                    </td>
                    <td onclick="__doPostBack('+_+week', param + '|ש|<%#Eval("ש") %>')" class="dayw">
                        <%#WW(7) %>
                        <%#DB("ש") %>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:ListView>
    </div>

    <%--    ---------------------------
            שאילתות
            -------------------------- ---%>

    <asp:SqlDataSource ID="DSMP" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM Book10.dbo.TT_EduMP(@CustomerID,@EventID)" CancelSelectOnNullParameter="false" OnSelecting="DS_Selecting">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="CID" Type="Int32" />
            <asp:Parameter Name="EventId" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSWP" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM Book10.dbo.TT_EduWP_(@CustomerID,@EventID,@FormTypeId) ORDER BY [Ord]" CancelSelectOnNullParameter="false" OnSelecting="DS_Selecting">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="CID" Type="Int32" />
            <asp:Parameter Name="EventId" />
            <asp:Parameter Name="FormTypeId" />
        </SelectParameters>
    </asp:SqlDataSource>

    <%--SelectCommand="
        SELECT grp, perc, gid 
        FROM (SELECT grp,perc,gid,LoadTime As Ld 
		        FROM Book10_21.dbo.p5t_Forms f 
                LEFT OUTER JOIN Book10_21.dbo.p5t_FormResults r ON r.FormID = f.FormID
                WHERE f.FormID = @FormId) x
        ORDER BY Ld Desc,gid        
        "--%>
    <asp:SqlDataSource ID="DSGRAPH" runat="server" 
        ConnectionString="<%$ ConnectionStrings:Book10PE %>"
        OnSelecting="DSGRAPH_Selecting"
        SelectCommand="SELECT grp, perc, gid FROM  Book10_21.dbo.p5t_FormResults  WHERE FormID = (select l1.CustRelateID 
									 from Book10_21.dbo.CustEventList l1 
									 where l1.CustEventID = (select   MAX(l.CustEventID)
															  from Book10_21.dbo.CustEventList l 
															  where l.CustomerID=@CustomerId and l.CustEventTypeID=@EventTypeId)) ORDER BY gid"
        CancelSelectOnNullParameter="False">
        
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="cid" />
            <asp:Parameter Name="EventTypeId" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSWeeklyPlan" runat="server" OnSelecting="DSWeeklyPlan_Selecting"
        ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM dbo.TT_fnWeeklyPlan_N(@EventID)">
        <SelectParameters>
            <asp:Parameter Name="EventID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
