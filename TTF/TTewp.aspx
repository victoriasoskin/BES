<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="TTewp.aspx.cs" Inherits="TTF.TTewp" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .wkhide {
            position: fixed;
            top: 120px;
            left: 100px;
            width: 820px;
            background-color: #EEEEEE;
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
            display: none;
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
    <script src="Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        var param = '';
        function OpenPopUP(x) {
            param = x;
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            z.style.display = 'block';
        }
        function hideweek() {
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            z.style.display = 'none';
        }
        function showweek() {
            var z = document.getElementById('<%=divWeeklytimetable.ClientID%>');
            z.style.display = 'block';
        }
        function delweek(x, p)
        {
            if (confirm('למחוק?')) {
                var y = parseInt(x / 100000);
                window.open('delweek.aspx?id=' + y,'_blank');
     //            __doPostBack('+_+week', 'd|א|' + y);
            }
            
        }

        function checkInputLength(prop, length) {
            var  t = documentgetElementById(prop);

            if (t.value.length == length) alert('לא ניתן להקליד עוד')
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%--    ---------------------------
        כפתור חזרה, הדפסה, וורד, אקסל למערכת הניהול
        -------------------------- ---%>

    <div style="position: fixed; top: 0px; right: 9px; z-index: 888;">
        <asp:LinkButton runat="server" ID="lnkbback" PostBackUrl="~/CustEventReport.Aspx" Text="חזרה" CausesValidation="false" />
        <asp:HyperLink runat="server" ID="hlprint" Text="הדפסה" CausesValidation="false" OnPreRender="hlprint_PreRender" Target="_blank" />
    </div>

    <%--    ---------------------------
        קודים נשמרים
        -------------------------- ---%>

    <asp:HiddenField runat="server" ID="hdnCurrentEventId" />
    <asp:HiddenField runat="server" ID="hdnItemHandled" />
    <asp:HiddenField runat="server" ID="hdnCurrentWpId" />
    <asp:HiddenField runat="server" ID="hdnForm127" />
    <asp:HiddenField runat="server" ID="hdnDate127" />
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
                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="עריכה" CssClass="btns" CommandName="edit" CausesValidation="false" Visible='<%#isUpdatable() %>'></asp:LinkButton>
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
                        <asp:Label runat="server" ID="lblD127" OnPreRender="lblDxxx_PreRnder" />

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
                        <div style="position: relative;">
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
                        </div>
                    </td>
                </tr>
            </ItemTemplate>

            <%--    ---------------------------
        תוכנית אב - הוספה
        -------------------------- ---%>

            <InsertItemTemplate>
                <tr>
                    <td colspan="10" class="pEhdr">תוכנית אב חדשה
                        <asp:LinkButton runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton>
                        <asp:HiddenField runat="server" ID="hdnMPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td colspan="2">מתאם תמיכות
                    </td>
                    <td colspan="2">
                        <asp:TextBox runat="server" ID="tbSuppCoord" />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="tbSuppCoord" Display="Dynamic" ErrorMessage="יש להקליד מתאם תמיכות" ForeColor="Red" ValidationGroup="MP" />
                    </td>
                    <td colspan="2">מדריך
                    </td>
                    <td colspan="4">
                        <asp:TextBox runat="server" ID="tbInstr" />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מתאם תמיכות" ValidationGroup="MP" ForeColor="Red" />
                    </td>

                </tr>
                <tr class="editbck">
                    <td colspan="2">מילוי שאלון איכות חיים
                    </td>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lblD127" OnPreRender="lblDxxx_PreRnder" />
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
                        <asp:TextBox runat="server" ID="tbLocation" />
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
                        <asp:TextBox runat="server" ID="tbStrength" Width="600" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד 1')" />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>פעילות פנאי
                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbHobby" Width="600" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד 1')" />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>מסגרת קודמת
                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbPreviousFrame" Width="600"  onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד 1')"/>
                    </td>
                </tr>
                <tr class="editbck">
                    <td>מידע נוסף

                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbOtherInfo" Width="600" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד 1')"/>
                    </td>
                </tr>
                <tr>

                    <%--    ---------------------------
                    תוכנית אב - גרף בהוספה
                    -------------------------- ---%>

                    <td colspan="10">
                        <div style="position: relative;">
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
                        <asp:LinkButton runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:LinkButton>
                        <%--                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" OnClick="lnkbMP_Click" ValidationGroup="MP"></asp:LinkButton>--%>
                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton>
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
                        <asp:TextBox runat="server" ID="tbInstr" Text='<%# Eval("Supporter") %>' />
                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="tbInstr" Display="Dynamic" ErrorMessage="יש להקליד מדריך" ValidationGroup="MP" ForeColor="Red" />
                    </td>

                </tr>
                <tr class="editbck">
                    <td colspan="2">מילוי שאלון איכות חיים
                    </td>
                    <td colspan="2">
                        <asp:Label runat="server" ID="lblD127" OnPreRender="lblDxxx_PreRnder" />
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
                        <asp:TextBox runat="server" ID="tbLocation" Text='<%# Eval("Location") %>' />
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
                        <asp:TextBox runat="server" ID="tbStrength" Width="600" Text='<%# Eval("Strength") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>פעילות פנאי
                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbHobby" Width="600" Text='<%# Eval("Hobby") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>מסגרת קודמת
                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbPreviousFrame" Width="600" Text='<%# Eval("PreviousFrame") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>מידע נוסף

                    </td>
                    <td colspan="9">
                        <asp:TextBox runat="server" ID="tbOtherInfo" Width="600" Text='<%# Eval("OtherInfo") %>' />
                    </td>
                </tr>
                <tr>

                    <%--    ---------------------------
                תוכנית אב - גרף בעריכה
                -------------------------- ---%>

                    <td colspan="10">
                        <div>
                            <asp:Chart ID="Chart1" runat="server" Width="940px" Height="500px" DataSourceID="DSGRAPH" BorderlineColor="gray" BackColor="LightGray" OnPrePaint="chrt_OnPrePaint">

                                <Titles>
                                    <asp:Title Text="תוצאות השאלון העדכני לניהול תמיכות" Font="Arial, 18pt, style=Bold, Italic">
                                    </asp:Title>
                                </Titles>
                                <Series>
                                    <asp:Series Name="Series1" ChartType="Column" XValueMember="Grp" YValueMembers="perc" BorderWidth="3" IsValueShownAsLabel="true" LabelFormat="{0:0.00}" Color="DarkBlue">
                                    </asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1">
                                        <AxisX IsReversed="true">
                                            <MajorGrid Enabled="false" />

                                        </AxisX>
                                        <AxisY Minimum="0" Maximum="4" />
                                    </asp:ChartArea>
                                </ChartAreas>
                            </asp:Chart>
                        </div>

                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>

        <%--    ---------------------------
        תוכנית תמיכות
        -------------------------- ---%>

        <asp:ListView runat="server" ID="lvWP" DataSourceID="DSWP" OnItemEditing="lv_ItemEditing" OnItemCanceling="lv_ItemCanceling" InsertItemPosition="FirstItem" OnPreRender="lvWP_PreRender" OnItemDeleting="lvWP_ItemDeleting">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                    <thead>
                        <tr>
                            <td colspan="5" style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;">בניית תוכנית תמיכות
                                <asp:LinkButton runat="server" ID="lnkbShowAdd" Text="הוספת תמיכה חדשה" CssClass="btns" ForeColor="White" OnPreRender="lnkbShowAdd_PreRender" OnClick="lnkbShowAdd_Click"  ></asp:LinkButton>
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

            <ItemTemplate>
                <tr class="phdr">
                    <td colspan="2">תמיכה מספר <%#Eval("Ln") %>
                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="עריכה" CssClass="btns" CommandName="edit" CausesValidation="false" Visible='<%#isUpdatable() %>'></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnkbDelete" Text="מחיקה" CssClass="btns" OnClientClick="return confirm('האם למחוק?');" CausesValidation="false" CommandName="delete" Visible='<%#isUpdatable() %>'></asp:LinkButton>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="ptbl">
                            <tr>
                                <td class="rowHeader" style="width: 50px;">תחום
                                </td>
                                <td>
                                    <%#Eval("Range") %>
                                </td>
                                <tr>
                                    <td class="rowHeader">נושא
                                    </td>
                                    <td>
                                        <%#Eval("Subject") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeader">מטרה
                                    </td>
                                    <td>
                                        <%#Eval("Purpose") %>
                                    </td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr class="psubhdr">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>
                <tr>
                    <td>

                        <%--    ---------------------------
                פירוטים לתמיכה - בתצוגה
                -------------------------- ---%>

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender" OnItemInserting="Det_Inserting">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="psubhdr">
                                        <td style="border-bottom: 3px solid gray;"></td>
                                        <td style="border-bottom: 3px solid gray;">פירוט</td>
                                        <td style="border-bottom: 3px solid gray;">תקופת התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">תדירות</td>
                                        <td style="border-bottom: 3px solid gray;">משך התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">ספק התמיכה</td>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </LayoutTemplate>

                            <%--    ---------------------------
                            פירוטים לתמיכה - תצוגה, בתצוגה של תמיכה
                            -------------------------- ---%>

                            <ItemTemplate>
                                <tr>
                                    <td class="rowHeader">פירוט</td>
                                    <td class="dataCell" style="width: 550px;">
                                        <%#Eval("Text") %>
                                    </td>
                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("Period") %></td>
                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("length") %></td>
                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("Helper") %><br />
                                        <%#Eval("SupporterName") %><br />
                                        <a href='<%# string.Format("javascript:OpenPopUP({0});", Eval("Id")) %>'>הוסף לשבוע</a>
                                    </td>
                                </tr>
                                <tr style="vertical-align: top; font-size: smaller;">
                                    <td class="rowHeader" style="width: 50px;">יעדים</td>
                                    <td class="dataCell">
                                        <%#Eval("Text1") %>
                                    </td>
                                </tr>
                                <tr style="border-bottom: 3px solid gray; vertical-align: top;">
                                    <td class="rowHeaderb" style="border-bottom: 3px solid gray;">מדדים</td>
                                    <td class="tdLastRow" style="border-bottom: 3px solid gray;">
                                        <%#Eval("Text2") %>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color: gray;">
                    <td><a href="javascript:showweek();" style="color: white;">הצגת תוכנית שבועית</a>
                    </td>
                </tr>
            </ItemTemplate>

            <%--    ---------------------------
        תוכנית תמיכות - הוספה
        -------------------------- ---%>

            <InsertItemTemplate>
                <tr>
                    <td colspan="5" class="pEhdr">תמיכה חדשה
                        <asp:LinkButton runat="server" ID="lnkbSaveNClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbWP_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה והוספת פירוט" CssClass="btns" OnClick="lnkbWP_Click"></asp:LinkButton>
                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr class="editbck">
                    <td>
                        <table class="ptbl">
                            <tr>
                                <td style="width: 50px;">תחום
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlRange" AppendDataBoundItems="true" AutoPostBack="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="250" OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="rfvRange" ControlToValidate="ddlRange" ErrorMessage="יש לבחור בתחום" ForeColor="Red" Display="Dynamic" />
                                </td>
                                <tr>
                                    <td>נושא
                                    </td>
                                    <td>
                                        <asp:DropDownList runat="server" ID="ddlSubject" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="250" OnPreRender="ddl_PreRender" OnDataBinding="ddl_DataBinding"></asp:DropDownList>
                                        <asp:RequiredFieldValidator runat="server" ID="rfvSubject" ControlToValidate="ddlSubject" ErrorMessage="יש לבחור בנושא" ForeColor="Red" Display="Dynamic" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>מטרה
                                    </td>
                                    <td>
                                        <asp:TextBox runat="server" ID="tbPurpose" Columns="100" MaxLength="260" onkeypress="if (this.value.length==250) alert('לא ניתן להקליד עוד ')" />
                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="tbPurpose" ErrorMessage="יש להקליד מטרה" ForeColor="Red" Display="Dynamic" />

                                    </td>
                                </tr>
                        </table>
                    </td>
                </tr>
                <tr class="pEsubhdr">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>
                <tr>
                    <td>

                        <%--    ---------------------------
                    פירוטים לתמיכה בתוך הוספת תמיכה
                    -------------------------- ---%>

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender" InsertItemPosition="FirstItem" OnItemInserting="Det_Inserting" OnItemEditing="lv_ItemEditing" OnItemDeleting="dlDetails_ItemDeleting" OnItemUpdating="Det_Updating">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="pEsubhdr">
                                        <td></td>
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

                            <%--    ---------------------------
                                    פירוטים לתמיכה - תצוגה בתוך הוספת תמיכה
                                    -------------------------- ---%>

                            <ItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>פירוט</td>
                                    <td style="width: 550px;">
                                        <asp:HiddenField runat="server" ID="hdnDetId" Value='<%#Eval("Id") %>' />
                                        <%#Eval("Text") %>
                                    </td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#Eval("Period") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#Eval("length") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#Eval("Helper") %><br />
                                        <%#Eval("SupporterName") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <%--                                        <asp:Literal runat="server" ID="litDetails_Edit" OnPreRender="lit_Prerender" Text="עריכה" />
                                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="מחיקה" CssClass="btns" CommandName="delete" CausesValidation="false" OnClientClick="return confirm('האם למחוק?');"></asp:LinkButton>--%>
                                    </td>
                                </tr>
                                <tr class="editbck">
                                    <td>יעדים</td>
                                    <td class="dataCell">
                                        <%#Eval("Text1") %>
                                    </td>
                                </tr>
                                <tr class="editbck">
                                    <td style="border-bottom: 3px solid gray;">מדדים</td>
                                    <td class="tdLastRow" style="border-bottom: 3px solid gray;">
                                        <%#Eval("Text2") %>
                                    </td>
                                </tr>
                            </ItemTemplate>

                            <%--    ---------------------------
                                    פירוטים לתמיכה - הוספה בתוך הוספת תמיכה
                                    -------------------------- ---%>

                            <InsertItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>פירוט
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="100" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                        <asp:RequiredFieldValidator runat="server" ID="rfvDet" ControlToValidate="tbDetails" Display="Dynamic" ErrorMessage="יש להקליד פירוט" ForeColor="Red" ValidationGroup="addDet" />
                                    </td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="90" OnPreRender="ddl_PreRender"></asp:DropDownList>
                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="ddlPeriod" Display="Dynamic" ErrorMessage="יש לבחור בתקופה" ForeColor="Red" ValidationGroup="addDet" />
                                       <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="50" TextMode="MultiLine" Style="display: none;" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==50) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList><br />
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="ddlFrequesncy_1" Display="Dynamic" ErrorMessage="יש לבחור במספר פעמים"  ForeColor="Red" ValidationGroup="addDet"/>
                                       <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlFrequesncy_2" Display="Dynamic" ErrorMessage="יש לבחור בתדירות"  ForeColor="Red" ValidationGroup="addDet"/>
                                    </td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList></td>
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlLasting" Display="Dynamic" ErrorMessage="יש לבחור במשך הזמן"  ForeColor="Red" ValidationGroup="addDet"/>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="ddlHelper" Display="Dynamic" ErrorMessage="יש לבחור בספק"  ForeColor="Red" ValidationGroup="addDet"/>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />
                                        <br />
                                        <asp:TextBox runat="server" ID="tbSupporterName" Width="85" MaxLength="40" TextMode="MultiLine" Text="שם הספק" ForeColor="Gray" Font-Italic="true" onfocus="if(this.value == 'שם הספק') {this.value=''; this.style.color = 'black'; this.style.fontStyle = 'normal'; }" />
                                    </td>
                                    <td rowspan="3" style="white-space: nowrap; border-bottom: 3px solid gray;">
                                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="insert" OnPreRender="lnkbSave_PreRender" ValidationGroup="addDet"></asp:LinkButton>
                                        <asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton></td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>יעדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText1" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                           <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator13" ControlToValidate="tbText1" Display="Dynamic" ErrorMessage="יש להקליד יעדים" ForeColor="Red" ValidationGroup="addDet" />
                                   </td>
                                    <tr style="vertical-align: top;" class="editbck">
                                        <td style="border-bottom: 3px solid gray;">מדדים
                                        </td>
                                        <td style="border-bottom: 3px solid gray;">
                                            <asp:TextBox runat="server" ID="tbText2" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                           <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ControlToValidate="tbText2" Display="Dynamic" ErrorMessage="יש להקליד מדדים" ForeColor="Red" ValidationGroup="addDet" />
                                        </td>
                            </InsertItemTemplate>

                            <%--    ---------------------------
                                    פירוטים לתמיכה - עריכה בתוך הוספת תמיכה
                                    -------------------------- ---%>

                            <EditItemTemplate>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>פירוט</td>
                                    <td style="">
                                        <asp:HiddenField runat="server" ID="hdnId" Value='<%#Eval("Id") %>' />
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="400" TextMode="MultiLine" Rows="4" Columns="49" Text='<%#Eval("Text") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="90" OnPreRender="ddl_PreRender" SelectedValue='<%#Eval("PeriodId") %>'></asp:DropDownList>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" TextMode="MultiLine" Text='<%#Eval("PeriodText") %>' Style="display: none;" OnPreRender="tbOther_PreRender"  onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')"/>
                                        />
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("AmountId") %>'>
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("FrequencyId") %>'>
                                        </asp:DropDownList>
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("LengthId") %>'>
                                        </asp:DropDownList></td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("HelperId") %>'>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" Text='<%#Eval("HelperText") %>' OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />
                                        <br />
                                        <asp:TextBox runat="server" ID="tbSupporterName" Width="85" MaxLength="40" TextMode="MultiLine" Text='<%#Eval("SupporterName") %>' onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />

                                    </td>
                                    <td rowspan="3" style="white-space: nowrap;">
                                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="update"></asp:LinkButton><asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton></td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>יעדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText1" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" Text='<%#Eval("text1") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                </tr>
                                <tr style="vertical-align: top;">
                                    <td>מדדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText2" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" Text='<%#Eval("text2") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
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
                    <td colspan="5" class="pEhdr">עריכת תמיכה מספר <%#Eval("Ln") %><asp:LinkButton runat="server" ID="lnkbSaveClose" Text="שמירה וסגירה" CssClass="btns" OnClick="lnkbWP_Click"></asp:LinkButton><asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" OnClick="lnkbWP_Click"></asp:LinkButton><asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" CommandName="cancel" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton></td>
                </tr>
                <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                </td>
                </tr>
                <tr class="editbck">
                    <td>
                        <table class="ptbl">
                            <td style="width: 50px;">תחום
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlRange" AppendDataBoundItems="true" AutoPostBack="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="250" SelectedValue='<%#Eval("RangeId") %>' OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <tr>
                                <td>נושא
                                </td>
                                <td>
                                    <asp:DropDownList runat="server" ID="ddlSubject" AppendDataBoundItems="true" OnSelectedIndexChanged="ddl_SelectedIndexChanged" Width="250" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender"></asp:DropDownList>
                                    <asp:HiddenField runat="server" ID="hdnSubject" Value='<%#Eval("SubjectId") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>מטרה
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="tbPurpose" Columns="100" MaxLength="250" Text='<%#Eval("Purpose") %>'  onkeypress="if (this.value.length==250) alert(' לא ניתן להקליד עוד')"/>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="tbPurpose" ErrorMessage="יש להקליד מטרה" ForeColor="Red" Display="Dynamic" />

                                </td>
                            </tr>

                        </table>
                    </td>
                </tr>
                <tr class="pEsubhdr">
                    <td>פרטי התוכנית</td>
                </tr>
                <tr class="editbck">
                    <td>

                        <%--    ---------------------------
                        פירוטים לתמיכה - בתוך עריכת תמיכה
                        -------------------------- ---%>

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender" InsertItemPosition="LastItem" DataKeyNames="Id" OnItemEditing="lv_ItemEditing" OnItemDeleting="dlDetails_ItemDeleting" OnItemInserting="Det_Inserting" OnItemCanceling="lv_ItemCanceling" OnItemUpdating="Det_Updating">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                    <tr class="pEsubhdr">
                                        <td></td>
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

                            <%--    ---------------------------
                                    פירוטים לתמיכה - תצוגה בתוך עריכת תמיכה
                                    -------------------------- ---%>

                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td>פירוט</td>
                                    <td>
                                        <asp:HiddenField runat="server" ID="hdnDetId" Value='<%#Eval("Id") %>' />
                                        <%#Eval("Text") %>
                                    </td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#Eval("Period") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray; font-size: smaller;"><%#Eval("length") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;"><%#Eval("Helper") %><br />
                                        <%#Eval("SupporterName") %></td>
                                    <td rowspan="3" style="border-bottom: 3px solid gray;">
                                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="עריכה" CausesValidation="false" CommandName="Edit" />
                                        <asp:LinkButton runat="server" ID="lnkbDelete" Text="מחיקה" CausesValidation="false" OnClientClick="return confirm('האם למחוק את הפירוט?');" OnClick="lnkbDelete_Click" />
                                    </td>
                                </tr>
                                <tr style="vertical-align: top;">
                                    <td>יעדים</td>
                                    <td>
                                        <%#Eval("Text1") %>
                                    </td>
                                </tr>
                                <tr style="vertical-align: top; border-bottom: 3px solid gray;">
                                    <td style="border-bottom: 3px solid gray;">מדדים</td>
                                    <td style="border-bottom: 3px solid gray;">
                                        <%#Eval("Text2") %>
                                    </td>
                                </tr>
                            </ItemTemplate>

                            <%--    ---------------------------
                                    פירוטים לתמיכה - הוספה בתוך עריכת תמיכה
                                    -------------------------- ---%>

                            <InsertItemTemplate>
                                <tr class="pEsubhdr">
                                    <td colspan="7">הוספת פירוט</td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>פירוט
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                         <asp:RequiredFieldValidator runat="server" ID="rfvDet" ControlToValidate="tbDetails" Display="Dynamic" ErrorMessage="יש להקליד פירוט"  ForeColor="Red" ValidationGroup="addDet" />
                                   </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" Width="90" OnPreRender="ddl_PreRender"></asp:DropDownList>
                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="ddlPeriod" Display="Dynamic" ErrorMessage="יש לבחור בתקופה"  ForeColor="Red" ValidationGroup="addDet"/>
                                        <asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" TextMode="MultiLine" Style="display: none;" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList><br />
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator9" ControlToValidate="ddlFrequesncy_1" Display="Dynamic" ErrorMessage="יש לבחור במספר פעמים"  ForeColor="Red" ValidationGroup="addDet"/>                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                         </asp:DropDownList>
                                         <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator10" ControlToValidate="ddlFrequesncy_2" Display="Dynamic" ErrorMessage="יש לבחור בתדירות"  ForeColor="Red" ValidationGroup="addDet"/>
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList></td>
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator11" ControlToValidate="ddlLasting" Display="Dynamic" ErrorMessage="יש לבחור במשך הזמן"  ForeColor="Red" ValidationGroup="addDet"/>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                          <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator12" ControlToValidate="ddlHelper" Display="Dynamic" ErrorMessage="יש לבחור בספק"  ForeColor="Red" ValidationGroup="addDet"/>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />
                                        <br />
                                        <asp:TextBox runat="server" ID="tbSupporterName" Width="85" MaxLength="40" TextMode="MultiLine" Text="שם הספק" ForeColor="Gray" Font-Italic="true" onfocus="if(this.value == 'שם הספק') {this.value=''; this.style.color = 'black'; this.style.fontStyle = 'normal'; }" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />

                                    </td>
                                    <td rowspan="3" style="white-space: nowrap;">
                                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="insert"  ValidationGroup="addDet"></asp:LinkButton><asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CssClass="btns" OnClick="lnkbCancel_Click" CausesValidation="false"></asp:LinkButton></td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>יעדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText1" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                           <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator13" ControlToValidate="tbText1" Display="Dynamic" ErrorMessage="יש להקליד יעדים"  ForeColor="Red" ValidationGroup="addDet"/>
                                    </td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>מדדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText2" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator14" ControlToValidate="tbText2" Display="Dynamic" ErrorMessage="יש להקליד מדדים"  ForeColor="Red" ValidationGroup="addDet"/>
                                   </td>
                                </tr>
                            </InsertItemTemplate>

                            <%--    ---------------------------
                                    פירוטים לתמיכה - עריכה בתוך עריכת תמיכה
                                    -------------------------- ---%>

                            <EditItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td>פירוט</td>
                                    <td style="">
                                        <asp:HiddenField runat="server" ID="hdnId" Value='<%#Eval("Id") %>' />
                                        <asp:TextBox runat="server" ID="tbDetails" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" Text='<%#Eval("Text") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlPeriod" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" SelectedValue='<%#Eval("PeriodId") %>' Width="90"></asp:DropDownList><asp:TextBox runat="server" ID="tbPeriod" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender" onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" /></td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_1" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("AmountId") %>'>
                                        </asp:DropDownList><br />
                                        <asp:DropDownList runat="server" ID="ddlFrequesncy_2" SelectedValue='<%#Eval("FrequencyId") %>' AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90">
                                        </asp:DropDownList>
                                    </td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlLasting" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("LengthId") %>'>
                                        </asp:DropDownList></td>
                                    <td rowspan="3">
                                        <asp:DropDownList runat="server" ID="ddlHelper" AppendDataBoundItems="true" OnDataBinding="ddl_DataBinding" OnPreRender="ddl_PreRender" Width="90" SelectedValue='<%#Eval("HelperId") %>'>
                                        </asp:DropDownList>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbHelper" Width="85" MaxLength="40" Style="display: none;" TextMode="MultiLine" OnPreRender="tbOther_PreRender"  onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')"/>
                                        <br />
                                        <asp:TextBox runat="server" ID="tbSupporterName" Width="85" MaxLength="40" TextMode="MultiLine" Text='<%#Eval("SupporterName") %>' onkeypress="if (this.value.length==40) alert('לא ניתן להקליד עוד')" />

                                    </td>
                                    <td rowspan="3" style="white-space: nowrap;">
                                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CssClass="btns" CommandName="update"></asp:LinkButton><asp:LinkButton runat="server" ID="lnkbCancel" Text="ביטול" CommandName="cancel" CssClass="btns" OnClick="lnkbCancel_Click"></asp:LinkButton></td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>יעדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText1" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" Text='<%#Eval("Text1") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
                                </tr>
                                <tr style="vertical-align: top;" class="editbck">
                                    <td>מדדים
                                    </td>
                                    <td style="">
                                        <asp:TextBox runat="server" ID="tbText2" MaxLength="400" TextMode="MultiLine" Rows="2" Columns="49" Text='<%#Eval("Text2") %>' onkeypress="if (this.value.length==400) alert('לא ניתן להקליד עוד')" />
                                    </td>
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
                    <td>חתימת התלמיד/ה</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מדריך</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת המורה</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת רכז/ת שכבה</td>
                    <td>_______________________</td>
                </tr>
                <tr style="height: 30px;">
                    <td>חתימת מנהל/ת</td>
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
        <img src="Close.png" onclick="hideweek();" alt="סגור" style="position: absolute; top: 0px; left: 0px;" />
        <span style="font-size: large; font-weight: bold;">תוכנית שבועית</span>
        <hr />
        <asp:ListView runat="server" ID="LVWeeklyPlan" DataSourceID="DSWeeklyPlan" EnableViewState="false">
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


    <asp:SqlDataSource ID="DSGRAPH" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>"
        SelectCommand="
SELECT grp, perc, Ld 
FROM (SELECT grp,perc,gid,LoadTime As Ld 
		FROM Book10_21.dbo.p5t_Forms f 
        LEFT OUTER JOIN Book10_21.dbo.p5t_FormResults r ON r.FormID = f.FormID
        WHERE f.FormID = @FormId) x
ORDER BY Ld Desc,gid        
        "
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter Name="FormId" ControlID="hdnForm127" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSWeeklyPlan" runat="server" OnSelecting="DSWeeklyPlan_Selecting"
        ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM dbo.TT_fnWeeklyPlan_N(@EventID)">
        <SelectParameters>
            <asp:Parameter Name="EventID" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
