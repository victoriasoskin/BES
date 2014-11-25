<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="True" CodeBehind="TTfup.aspx.cs" Inherits="TTF.TTfup" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .rbl {
            width: 100%;
        }

            .rbl td {
                width: 33.33%;
                text-align: center;
                white-space: pre-wrap;
            } 
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#input:radio').each(function () {
                alert($(this).attr('name'));
            });
        });

       
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%--    ---------------------------
        כפתור חזרה למערכת הניהול
        -------------------------- ---%>

    <div style="position: fixed; top: 0px; right: 9px; z-index: 888;">
        <asp:LinkButton runat="server" ID="lnkbback" PostBackUrl="~/CustEventReport.Aspx" Text="חזרה" CausesValidation="false" />
        <asp:HyperLink runat="server" ID="hlprint" Text="הדפסה" CausesValidation="false" OnPreRender="hlprint_PreRender" Target="_blank" />
    </div>

    <%--    ---------------------------
        קודים נשמרים
        -------------------------- ---%>

    <asp:HiddenField runat="server" ID="hdnItemHandled" />
    <asp:HiddenField runat="server" ID="hdnCurrentWpId" />
    <asp:HiddenField runat="server" ID="hdnForm132" />
    <asp:HiddenField runat="server" ID="hdnDate132" />
    <asp:HiddenField runat="server" ID="hdnCurrentEventId" />

    <%--    ---------------------------
        כותרת הדף (fixed)
        -------------------------- ---%>

    <div id="divheader" class="divHeader">
        <asp:ListView runat="server" ID="lvHdr" OnDataBinding="lvHdr_DataBind">
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
                                    <span style="font-size: xx-large; font-weight: bold;"><%#"מעקב תמיכות - " + Eval("Name") %></span>

                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; width: 100px;">ת.ז:
                                </td>
                                <td>
                                    <%#Eval("CustomerID")%>
                                    <asp:HiddenField runat="server" ID="hdnFormHeader" Value='<%#"תוכנית תמיכות דיור " + Eval("Name") %>' />
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



    <div style="position: absolute; top: 108px; right: 0px; padding-right: 5px; width: 950px; z-index: 555;">
        <asp:Button runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; right: 5px; width:100px; background-color:darkgrey ; font-weight:bold"  />
<%--        
    <asp:LinkButton runat="server" ID="lnkbBacktoMainChart" Visible="false" OnClick="backTomainChart_Click" CausesValidation="false" Text="חזרה לגרף הראשי" Style="position: absolute; top: 0px; left: 0px;" />--%>

        <asp:Chart ID="Chart1" runat="server" Width="940px" Height="500px" DataSourceID="DSGraph" BorderlineColor="gray"  BackColor="#74a3e6" OnPrePaint="chrt_OnPrePaint" OnClick="chrt_Drill">
            <Titles>
                <asp:Title Text="סיכום מעקבים" Font="Arial, 18pt, style=Bold, Italic">
                </asp:Title>
            </Titles>
            <Series>
                <asp:Series Name="Series1" XValueMember="m" YValueMembers="av" BorderWidth="3" IsValueShownAsLabel="true" LabelFormat="{0:0.00}" Color="DarkBlue" PostBackValue="#VALX">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX Interval="1">
                        <MajorGrid Enabled="false" />

                    </AxisX>
                    <AxisY Minimum="-2" Maximum="2" Interval="1" />
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>



        <%--    ---------------------------
        תוכנית אב
        -------------------------- ---%>
        <div style="display: none;">
            <asp:ListView runat="server" ID="lvMP" DataSourceID="DSMP" OnPreRender="lvMP_PreRender">
                <LayoutTemplate>
                    <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                        <thead>
                            <tr>
                                <td colspan="10" style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;">תוכנית תמיכות
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
                            <asp:Label runat="server" ID="lblD132" OnPreRender="lblDxxx_PreRnder" />

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
                            
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>

        <%--    ---------------------------
        תוכנית תמיכות
        -------------------------- ---%>

        <asp:ListView runat="server" ID="lvWP" DataSourceID="DSWP" OnItemEditing="lv_ItemEditing" OnItemCanceling="lv_ItemCanceling" OnPreRender="lvWP_PreRender">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                    <thead>
                        <tr>
                            <td colspan="5" style="font-weight: bold; font-size: medium; text-align: center;background-color:#A5C3DE;  color: black;">מעקב תמיכות
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
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="ptbl">
                            <tr>
                                <td class="rowHeader" style="width: 50px;">תחום
                                </td>
                                <td class="dataCell">
                                    <%#Eval("Range") %>
                                </td>
                                <tr>
                                    <td class="rowHeader">נושא
                                    </td>
                                    <td class="dataCell">
                                        <%#Eval("Subject") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeader">מטרת על
                                    </td>
                                    <td class="dataCell">
                                        <asp:HiddenField runat="server" ID="hdnTargetId" Value='<%#Eval("TargetId") %>' />
                                        <%#Eval("Purpose") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeader" style="width: 50px;">דרגת חשיבות</td>
                                    <td style="padding-right: 5px;">
                                        <%#Eval("Weight") %></td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <th colspan="2" style="text-align: left; font-size: 10px">לחץ לעדכון המעקב</th>

                            </tr>
                            <tr>
                                <td>
                                    <asp:ListView runat="server" ID="lvIndexes" OnPreRender="lvIdexes_PreRender">
                                        <LayoutTemplate>
                                            <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td class="rowHeader" style="direction: ltr; width: 50px; text-align: right;">
                                                    <asp:Label runat="server" ID="lblIndexName" Text='<%#Eval("Name") %>' OnPreRender="lblIndexName_PreRender" />
                                                </td>
                                                <td class="dataCell" style="width: 1010px;">
                                                    <asp:Label runat="server" ID="lblIndex" Text='<%#Eval("Text") %>' />
                                                    <asp:HiddenField runat="server" ID="hdnIndexId" Value='<%#Eval("IndexId") %>' />
                                                </td>
                                                <td style="background-color: lightblue">
                                                    <asp:RadioButton runat="server" ID="rb" GroupName="grp" OnPreRender="rb_PreRender" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                            </tr>

                        </table>

                        <table>
                            <tr>
                                <td class="rowHeader" style="width: 50px; text-align: right;">
                                    <asp:Label runat="server" ID="lblReportDet" Text="פירוט"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="TextBXDetReport" Width="820px" MaxLength="350" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="שדה חובה" ControlToValidate="TextBXDetReport" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                                <td>
                                    <asp:LinkButton ID="lnkbSaveRep" runat="server" Text="שמירה" OnClick="lnkbSaveRep_Click" Style="float: left;" ValidationGroup='<%#"DepReport" + Eval("Id").ToString() %>'></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--יצירת גרף המעקב אחרי התמיכה--%>
                <tr>
                    <td>
                        <asp:Chart ID="Chart2" runat="server" Width="940px" Height="150px" OnPreRender="MiniGraph_PreRender" BorderlineColor="gray" BackColor= "#A5C3DE">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Line" XValueMember="fdate" YValueMembers="val" Color="#000099" BorderWidth="2">
                                </asp:Series>
                                <%-- <asp:Series Name="Average"ChartType="Line" XValueMember="Month" YValueMembers="Average" ></asp:Series>--%>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Interval="1" />
                                    <AxisY Minimum="-2" Maximum="2"></AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </td>
                </tr>

                <%--    ---------------------------
            דיווח מעקב ברמת התמיכה
            -------------------------- ---%>

                <tr>
                    <td>
                        <tr class="psubhdr">
                            <td colspan="6" style="text-align: left; border-bottom: 3px solid;">
<%--                                <asp:Button ID="hlDetRep" runat="server" Text="הצג את רשימת המעקבים" target="_blank" OnClick="hlDetRep_Click"/> --%>
                                <asp:HyperLink runat="server" ID="hlDetRep" Text="הצג את רשימת המעקבים" Target="_blank" NavigateUrl='<%# reDir("TTdfupList.aspx","id") %>' />
                            </td>
                        </tr>

                    </td>
                </tr>
                <%--<tr class="psubhdr">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>--%>


                <tr>
                    <td>

                        <%--    ---------------------------
             פירוטים לתמיכות
            -------------------------- ---%>

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" style="width: 100%">
                                    <tr class="psubhdr">
                                        <td style="border-bottom: 3px solid gray;"></td>
                                        <td style="border-bottom: 3px solid gray; width: 400px;">פירוט</td>
                                        <td style="border-bottom: 3px solid gray;">תקופת התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">תדירות</td>
                                        <td style="border-bottom: 3px solid gray;">משך התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">ספק התמיכה</td>
                                        <%--<td style="border-bottom: 3px solid gray; width: 100px; background-color: lightblue; text-align: center; vertical-align: bottom;">
                                            <asp:Label runat="server" ID="lblhreport" OnPreRender="lblhreport_PreRender" />
                                        </td>--%>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder" ></tr>
                                </table>
                            </LayoutTemplate>

                            <%--    ---------------------------
                                הצגת פירוטים לתמיכה     
                                -------------------------- ---%>
                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td class="rowHeader">פירוט</td>
                                    <td class="dataCell">
                                        <asp:HiddenField runat="server" ID="hdnDetId" Value='<%#Eval("Id") %>' />
                                        <%#Eval("Text") %>
                                    </td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("Period") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("length") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("Helper") %></td>

                                    <%--    ---------------------------
                                      דיווח מעקב ברמת פירוט תמיכה
                                     -------------------------- ---%>


                                    <%--<td rowspan="1" style="background-color: lightblue;">
                                        <asp:RadioButtonList runat="server" ID="rblFUDet" RepeatDirection="Horizontal" Font-Size="smaller" CssClass="rbl" BackColor="#DDEEFF" Visible='<%#isUpdatable() %>'>
                                            <asp:ListItem Value="3"><br />כן</asp:ListItem>
                                            <asp:ListItem Value="2">חלקי</asp:ListItem>
                                            <asp:ListItem Value="1"><br />לא</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:RequiredFieldValidator runat="server" ID="rfv4" ControlToValidate="rblFUDet" ForeColor="Red" ErrorMessage="בחר תשובה" ValidationGroup='<%#"DepReport" + Eval("Id").ToString() %>' />
                                        <asp:TextBox runat="server" ID="tbFuT" Columns="15" TextMode="MultiLine" Rows="3" Text="פרט במידת הצורך" ForeColor="Gray" Font-Italic="true" onfocus="if(this.value == 'פרט במידת הצורך') {this.value=''; this.style.color = 'black'; this.style.fontStyle = 'normal'; }" Visible='<%#isUpdatable() %>' />

                                        <asp:LinkButton runat="server" ID="lnkbSaveRep" Text="שמירה" OnClick="SaveDRep_Click" Style="float: left;" ValidationGroup='<%#"DepReport" + Eval("Id").ToString() %>' Visible='<%#isUpdatable() %>' />
                                    </td>--%>
                                </tr>

                                <%--<tr class="psubhdr">
                                    <td colspan="7" style="text-align: left; border-bottom: 3px solid gray;">
                                        <asp:HyperLink runat="server" ID="hlDetRep" Text="הצג את רשימת המעקבים" Target="_blank" NavigateUrl='<%# reDir("TTedupList.aspx","id")  %>' />
                                    </td>
                                   
                                </tr>--%>
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color:#A5C3DE">
                    <td></td>
                </tr>
            </ItemTemplate>
           <%-- *************************************************************************************************************************
            -------------------------------------------------------------------------------------------------------------------------
            ************************************************************************************************************************--%>
            <AlternatingItemTemplate>

                <tr class="phdrAlternate">
                    <td colspan="2">תמיכה מספר <%#Eval("Ln") %>
                        <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="ptblAlternate">
                            <tr>
                                <td class="rowHeaderAlternate" style="width: 50px;">תחום
                                </td>
                                <td class="dataCell">
                                    <%#Eval("Range") %>
                                </td>
                                <tr>
                                    <td class="rowHeaderAlternate">נושא
                                    </td>
                                    <td class="dataCell">
                                        <%#Eval("Subject") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeaderAlternate">מטרת על
                                    </td>
                                    <td class="dataCell">
                                        <asp:HiddenField runat="server" ID="hdnTargetId" Value='<%#Eval("TargetId") %>' />
                                        <%#Eval("Purpose") %>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="rowHeaderAlternate" style="width: 50px;">דרגת חשיבות</td>
                                    <td style="padding-right: 5px;">
                                        <%#Eval("Weight") %></td>
                                </tr>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table>
                            <tr>
                                <th colspan="2" style="text-align: left; font-size: 10px">לחץ לעדכון המעקב</th>

                            </tr>

                      <%--      *****************************************************************************************
                          <tr>
                                <td>
                                    <asp:ListView runat="server" ID="lvIndexes" OnPreRender="lvIdexes_PreRender">
                                        <LayoutTemplate>
                                            <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td class="rowHeader" style="direction: ltr; width: 50px; text-align: right;">
                                                    <asp:Label runat="server" ID="lblIndexName" Text='<%#Eval("Name") %>' OnPreRender="lblIndexName_PreRender" />
                                                </td>
                                                <td class="dataCell" style="width: 1010px;">
                                                    <asp:Label runat="server" ID="lblIndex" Text='<%#Eval("Text") %>' />
                                                    <asp:HiddenField runat="server" ID="hdnIndexId" Value='<%#Eval("IndexId") %>' />
                                                </td>
                                                <td style="background-color: lightblue">
                                                    <asp:RadioButton runat="server" ID="rb" GroupName="grp" OnPreRender="rb_PreRender" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                            </tr>
                            **************************************************************************************--%>


                            <tr>
                                <td>
                                    <asp:ListView runat="server" ID="lvIndexes" OnPreRender="lvIdexes_PreRender">
                                        <LayoutTemplate>
                                            <table runat="server" id="itemPlaceholderContainer" class="ptblAlternate">
                                                <tr runat="server" id="itemPlaceholder"></tr>
                                            </table>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <tr>
                                                <td class="rowHeaderAlternate" style="direction: ltr; width: 50px; text-align: right;">
                                                    <asp:Label runat="server" ID="lblIndexName" Text='<%#Eval("Name") %>' OnPreRender="lblIndexName_PreRender" />
                                                </td>
                                                <td class="dataCell" style="width: 1010px;">
                                                    <asp:Label runat="server" ID="lblIndex" Text='<%#Eval("Text") %>' />
                                                    <asp:HiddenField runat="server" ID="hdnIndexId" Value='<%#Eval("IndexId") %>' />
                                                </td>
                                                <td style="background-color: #8FDCF1">
                                                    <asp:RadioButton runat="server" ID="rb" GroupName="grp" OnPreRender="rb_PreRender" />
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:ListView>
                                </td>
                            </tr>

                        </table>

                        <table>
                            <tr>
                                <td class="rowHeaderAlternate" style="width: 50px; text-align: right;">
                                    <asp:Label runat="server" ID="lblReportDet" Text="פירוט"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="TextBXDetReport" Width="820px" MaxLength="350" onkeypress="if (this.value.length==350) alert('לא ניתן להקליד עוד')"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="שדה חובה" ControlToValidate="TextBXDetReport" ForeColor="Red"></asp:RequiredFieldValidator>

                                </td>
                                <td>
                                    <asp:LinkButton ID="lnkbSaveRep" runat="server" Text="שמירה" OnClick="lnkbSaveRep_Click" Style="float: left;" ValidationGroup='<%#"DepReport" + Eval("Id").ToString() %>'></asp:LinkButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%--יצירת גרף המעקב אחרי התמיכה--%>
                <tr>
                    <td>
                        <asp:Chart ID="Chart2" runat="server" Width="940px" Height="150px" OnPreRender="MiniGraph_PreRender" BorderlineColor="gray" BackColor= " #8FDCF1">
                            <Series>
                                <asp:Series Name="Series1" ChartType="Line" XValueMember="fdate" YValueMembers="val" Color="#000099" BorderWidth="2">
                                </asp:Series>
                                <%-- <asp:Series Name="Average"ChartType="Line" XValueMember="Month" YValueMembers="Average" ></asp:Series>--%>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Interval="1" />
                                    <AxisY Minimum="-2" Maximum="2"></AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                    </td>
                </tr>

                <%--    ---------------------------
            דיווח מעקב ברמת התמיכה
            -------------------------- ---%>

                <tr>
                    <td>
                        <tr class="psubhdrAlternate">
                            <td colspan="6" style="text-align: left; border-bottom: 3px solid;">
<%--                                <asp:Button ID="hlDetRep" runat="server" Text="הצג את רשימת המעקבים" target="_blank" OnPreRender="hlDetRep_PreRender" />     --%>
                                <asp:HyperLink runat="server" ID="hlDetRep" Text="הצג את רשימת המעקבים" Target="_blank" NavigateUrl='<%# reDir("TTdfupList.aspx","id") %>' />
                            </td>
                        </tr>

                    </td>
                </tr>
                <%--<tr class="psubhdr">
                    <td>פירוט התוכנית, יעדים ומדדים להצלחה</td>
                </tr>--%>


                <tr>
                    <td>

                        <%--    ---------------------------
             פירוטים לתמיכות
            -------------------------- ---%>

                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender">
                            <LayoutTemplate>
                                <table runat="server" id="itemPlaceholderContainer" style="width: 100%">
                                    <tr class="psubhdrAlternate">
                                        <td style="border-bottom: 3px solid gray;"></td>
                                        <td style="border-bottom: 3px solid gray; width: 400px;">פירוט</td>
                                        <td style="border-bottom: 3px solid gray;">תקופת התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">תדירות</td>
                                        <td style="border-bottom: 3px solid gray;">משך התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">ספק התמיכה</td>
                                        <%--<td style="border-bottom: 3px solid gray; width: 100px; background-color: lightblue; text-align: center; vertical-align: bottom;">
                                            <asp:Label runat="server" ID="lblhreport" OnPreRender="lblhreport_PreRender" />
                                        </td>--%>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder" ></tr>
                                </table>
                            </LayoutTemplate>

                            <%--    ---------------------------
                                הצגת פירוטים לתמיכה     
                                -------------------------- ---%>
                            <ItemTemplate>
                                <tr style="vertical-align: top;">
                                    <td class="rowHeaderAlternate">פירוט</td>
                                    <td class="dataCell">
                                        <asp:HiddenField runat="server" ID="hdnDetId" Value='<%#Eval("Id") %>' />
                                        <%#Eval("Text") %>
                                    </td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("Period") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                        <%#"ב" + Eval("Frequency") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("length") %></td>
                                    <td rowspan="1" class="tdLastRow"><%#Eval("Helper") %></td>

                                   
                                </tr>

                              
                            </ItemTemplate>
                        </asp:ListView>
                    </td>
                </tr>
                <tr style="width: 100%; height: 20px; background-color:#8FDCF1">
                    <td></td>
                </tr>
            </AlternatingItemTemplate>
        </asp:ListView>
    </div>

    <%--    ---------------------------
            שאילתות
            -------------------------- ---%>

    <asp:SqlDataSource ID="DSMP" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" 
        SelectCommand="SELECT * FROM Book10.dbo.TT_EduMP(@CustomerID,@EventID)" CancelSelectOnNullParameter="false" OnSelecting="DS_Selecting">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="CID" Type="Int32" />
            <asp:Parameter Name="EventId" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSWP" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" 
        SelectCommand="SELECT * FROM Book10.dbo.TT_EduWP_(@CustomerID,@EventID,@FormTypeId) ORDER BY [Ord]" 
        CancelSelectOnNullParameter="false" 
        OnSelecting ="DSWP_Selecting" >
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="CID" Type="Int32" />
            <asp:Parameter Name="EventId" />
            <asp:Parameter Name="FormTypeId"  />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSGRAPH" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>"


        SelectCommand="select round(avg(cast(wpr.Val as float)),2) av , book10.dbo.Month_Number_To_Word(month(wpr.LoadTime)) m from [Book10].[dbo].[TT_WP_Reports] wpr
            inner join (select * from book10.dbo.TT_Forms where formtypeId = @FormTypeId) w on w.Id= wpr.FormId 
            where (wpr.CustomerId = @CustomerId) and status = 0 group by MONTH(wpr.LoadTime) "
        CancelSelectOnNullParameter="False" OnSelecting="DSGRAPH_Selecting">
        <SelectParameters>
            <%--<asp:Parameter Name="@MonthP" />--%>
            <asp:Parameter Name="CustomerId" />
             <asp:QueryStringParameter Name="FormTypeId"  QueryStringField="FT" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSWeeklyPlan" runat="server"
        ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM dbo.TT_fnWeeklyPlan(@EventID)">
        <SelectParameters>
            <asp:Parameter Name="EventID" />
        </SelectParameters>
    </asp:SqlDataSource>


    <asp:SqlDataSource ID="DSMiniGraph" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select CONVERT(varchar, wpr.LoadTime,103) fdate  , wpr.val val from [Book10].[dbo].[TT_WP_Reports] wpr where (wpr.WpId = @WpId) and (wpr.EventId = @EventId) order by wpr.LoadTime asc">
        <SelectParameters>
            <asp:Parameter Name="WpId" />
            <asp:Parameter Name="EventId" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>


<%--select CONVERT(varchar, wpr.LoadTime,103) fdate  , wpr.val val from [Book10].[dbo].[TT_WP_Reports] wpr where (wpr.WpId = @WpId) and (wpr.EventId = @EventId) order by wpr.LoadTime asc--%>