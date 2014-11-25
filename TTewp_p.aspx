<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" CodeBehind="TTewp_p.aspx.cs" Inherits="TTF.TTewp_p" AutoEventWireup="true" EnableEventValidation="false" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .wkshow {
            width: 640px;
            background-color: #EEEEEE;
            border: 3px outset gray; 
        }

        .dayw {
            width: 114px;
            min-height: 40px;
            background-color: white;
            white-space: normal;
            font-size: 11px;
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

        @media print {
            .header, .hide {
                visibility: hidden;
            }
        }
    </style>
    <script type="text/javascript">
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="width: 640px">

        <div class="header">

            <%--    ---------------------------
        כפתור סגירה
        -------------------------- ---%>

            <asp:LinkButton runat="server" ID="lnkbClose" OnClientClick="window.open('', '_self', ''); window.close();" Style="position: fixed; top: 15px; right: 15px; z-index: 888; background-color: #EEEEEE;">סגירה</asp:LinkButton>
            <asp:LinkButton runat="server" ID="lnkbPrint" OnClientClick="javascript:window.focus();window.print();window.open('', '_self', ''); window.close();" Style="position: fixed; top: 15px; right: 55px; z-index: 888; background-color: #EEEEEE;">הדפסה</asp:LinkButton>
            <asp:LinkButton runat="server" ID="lnkbword" OnClick="W_Click" Style="position: fixed; top: 33px; right: 15px; z-index: 888; background-color: #EEEEEE;">Word</asp:LinkButton>
            <asp:LinkButton runat="server" ID="lnkbexcel" OnClick="E_Click" Style="position: fixed; top: 33px; right: 55px; z-index: 888; background-color: #EEEEEE;">Excel</asp:LinkButton>

        </div>

        <%--    ---------------------------
        קודים נשמרים
        -------------------------- ---%>

        <asp:HiddenField runat="server" ID="hdnItemHandled" />
        <asp:HiddenField runat="server" ID="hdnCurrentWpId" />
        <asp:HiddenField runat="server" ID="hdnForm127" />
        <asp:HiddenField runat="server" ID="hdnDate127" />
        <asp:HiddenField runat="server" ID="hdnWeekShow" Value="wkhide" />


        <%--    ---------------------------
        כותרת הדף
        -------------------------- ---%>

        <div id="divheader">
            <asp:ListView runat="server" ID="lvHdr" OnDataBinding="lvHdr_DataBind" Style="top: 0px; right: 5px">
                <LayoutTemplate>
                    <table id="itemPlaceholderContainer" runat="server" style="width: 640px; background-color: #EEEEEE; border: 1px solid gray; font-size: 11px;">
                        <tr id="itemPlaceholder" runat="server">
                        </tr>
                    </table>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td colspan="6" style="text-align: center;">
                            <asp:Label runat="server" ID="lblName" Style="font-size: xx-large; font-weight: bold;" Text='<%#"תוכנית אב - " + Eval("Name") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold; width: 100px;">ת.ז:
                        </td>
                        <td style="text-align: right; width: 300px;">
                            <%#Eval("CustomerID")%>
                        </td>
                        <td style="width: 40px;"></td>
                        <td style="width: 40px;"></td>
                        <td style="font-weight: bold; text-align: left; width: 80px;">ת.לידה:
                        </td>
                        <td style="text-align: left; width: 80px;">
                            <%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">מסגרת:
                        </td>
                        <td colspan="3" style="text-align: right;">
                            <%#Eval("FrameName")%>
                        </td>
                        <td style="font-weight: bold; text-align: left;">ת.קליטה:
                        </td>
                        <td style="text-align: left;">
                            <asp:Label runat="server" ID="lblStart" Text='<%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>' />
                        </td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;">מעדכן התוכנית:
                        </td>
                        <td colspan="3" style="text-align: right;">
                            <%#Eval("URName")%>
                        </td>
                        <td style="font-weight: bold; text-align: left;">ת.פתיחה:
                        </td>
                        <td style="text-align: left;">
                            <%#Eval("OpenDate", "{0:dd/MM/yyyy}")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>

        <%--    ---------------------------
            תוכנית אב
            -------------------------- ---%>

        <div style="width: 640px;">
            <asp:ListView runat="server" ID="lvMP" DataSourceID="DSMP">
                <LayoutTemplate>
                    <table runat="server" id="itemPlaceholderContainer" class="ptbl" style="width: 640px;">
                        <tr runat="server" id="itemPlaceholder">
                        </tr>
                    </table>
                </LayoutTemplate>

                <%--    ---------------------------
            תוכנית אב תצוגה
            -------------------------- ---%>

                <ItemTemplate>
                    <tr>
                        <td class="rowHeader">שם מתאם תמיכות
                        </td>
                        <td class="dataCell">
                            <%#Eval("SupportCoordinator") %>
                        </td>
                        <td class="rowHeader">שם מדריך
                        </td>
                        <td colspan="3" class="dataCell">
                            <%#Eval("Supporter") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="rowHeader">מילוי שאלון איכות חיים
                        </td>
                        <td class="dataCell">
                            <asp:Label runat="server" ID="lblD51" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                        <td class="rowHeader">מילוי שאלון כלי לניהול תמיכות
                        </td>
                        <td colspan="3" class="dataCell">
                            <asp:Label runat="server" ID="lblD127" OnPreRender="lblDxxx_PreRnder" />
                        </td>
                    </tr>
                    <tr class="psubhdr" style="font-weight: bold;">
                        <td colspan="6">רקע
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
                    </tr>
                    <tr>
                        <td class="rowHeader">מצב משפחתי</td>
                        <td class="dataCell">
                            <%#Eval("FamilyStatus") %>
                        </td>
                        <td class="rowHeader">כיתה</td>
                        <td colspan="3" class="dataCell" style="white-space: nowrap;">
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

                        <td colspan="6">
                            <div style="position: relative;">

                                <asp:Chart ID="Chart1" runat="server" Width="630" Height="500px" DataSourceID="DSGRAPH" BorderlineColor="gray" BackColor="LightGray" OnPrePaint="chrt_OnPrePaint">
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
                                            <AxisY Minimum="0" Maximum="4" Interval="1" />
                                        </asp:ChartArea>
                                    </ChartAreas>
                                </asp:Chart>
                            </div>
                        </td>
                    </tr>
                </ItemTemplate>

            </asp:ListView>

            <%--    ---------------------------
        תוכנית תמיכות
        -------------------------- ---%>
            <div style="page-break-before: always;">

                <%--    ---------------------------
        כותרת הדף
        -------------------------- ---%>

                <div style="page-break-after: avoid;">
                    <asp:ListView runat="server" ID="lvHdr1" OnDataBinding="lvHdr_DataBind" Style="top: 0px; right: 5px">
                        <LayoutTemplate>
                            <table id="itemPlaceholderContainer" runat="server" style="width: 640px; background-color: #EEEEEE; border: 1px solid gray; font-size: 11px;">
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td colspan="6" style="text-align: center;">
                                    <asp:Label runat="server" ID="lblName" Style="font-size: xx-large; font-weight: bold;" Text='<%#"תוכנית תמיכות - " + Eval("Name") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; width: 100px;">ת.ז:
                                </td>
                                <td style="text-align: right; width: 300px;">
                                    <%#Eval("CustomerID")%>
                                </td>
                                <td style="width: 40px;"></td>
                                <td style="width: 40px;"></td>
                                <td style="font-weight: bold; text-align: left; width: 80px;">ת.לידה:
                                </td>
                                <td style="text-align: left; width: 80px;">
                                    <%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;">מסגרת:
                                </td>
                                <td colspan="3" style="text-align: right;">
                                    <%#Eval("FrameName")%>
                                </td>
                                <td style="font-weight: bold; text-align: left;">ת.קליטה:
                                </td>
                                <td style="text-align: left;">
                                    <asp:Label runat="server" ID="lblStart" Text='<%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>' />
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold;">מעדכן התוכנית:
                                </td>
                                <td colspan="3" style="text-align: right;">
                                    <%#Eval("URName")%>
                                </td>
                                <td style="font-weight: bold; text-align: left;">ת.עדכון:
                                </td>
                                <td style="text-align: left;">
                                    <%#Eval("CustEventDate", "{0:dd/MM/yyyy}")%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
                <div style="width: 640px">

                    <asp:ListView runat="server" ID="lvWP" DataSourceID="DSWP">
                        <LayoutTemplate>
                            <table runat="server" id="itemPlaceholderContainer" style="width: 640px;">
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <%--                                    <td colspan="6" style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;">תוכנית תמיכות
                                    </td>--%>
                                </tr>
                                <tr runat="server" id="itemPlaceholder">
                                </tr>
                            </table>

                        </LayoutTemplate>

                        <%--    ---------------------------
            תוכנית תמיכות תצוגה
            -------------------------- ---%>

                        <ItemTemplate>
                            <tr>
                                <td colspan="6" style="border: none;">
                                    <div style='<%#printingStyle("Ln") %>'></div>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; font-size: 20px; text-decoration: underline; height: 40px;">תמיכה מספר <%#Eval("Ln") %>
                                    <asp:HiddenField runat="server" ID="hdnWPId" Value='<%#Eval("Id") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <div style="width: 640px">
                                        <table class="ptbl">
                                            <tr>
                                                <td class="rowHeader" style="width: 40px;">תחום
                                                </td>
                                                <td colspan="5" style="width: 600px;">
                                                    <%#Eval("Range") %>
                                                </td>
                                                <tr>
                                                    <td class="rowHeader">נושא
                                                    </td>
                                                    <td colspan="5">
                                                        <%#Eval("Subject") %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="rowHeader">מטרה
                                                    </td>
                                                    <td colspan="5">
                                                        <%#Eval("Purpose") %>
                                                    </td>
                                                </tr>
                                            </tr>
                                        </table>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td style="font-weight: bold; font-size: 16px;">פירוט התוכנית, יעדים ומדדים להצלחה</td>
                            </tr>
                            <tr>
                                <td>

                                    <%--    ---------------------------
                                    פירוטים לתמיכה - בתצוגה
                                    -------------------------- ---%>
                                    <div style="width: 640px">
                                        <asp:ListView runat="server" ID="dlDetails" OnPreRender="dlDetails_PreRender">
                                            <LayoutTemplate>
                                                <table runat="server" id="itemPlaceholderContainer" class="ptbl">
                                                    <tr class="psubhdr">
                                                        <td style="border-bottom: 3px solid gray; width: 40px;"></td>
                                                        <td style="border-bottom: 3px solid gray; width: 300px;">פירוט</td>
                                                        <td style="border-bottom: 3px solid gray; width: 75px;">תקופת התמיכה</td>
                                                        <td style="border-bottom: 3px solid gray; width: 75px;">תדירות</td>
                                                        <td style="border-bottom: 3px solid gray; width: 75px;">משך התמיכה</td>
                                                        <td style="border-bottom: 3px solid gray; width: 70px;">ספק התמיכה</td>
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
                                                    <td class="dataCell">
                                                        <%#Eval("Text") %>
                                                    </td>
                                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("Period") %></td>
                                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#(Eval("Amount").ToString().Trim() == "1" ? "פעם" : (Eval("Amount").ToString().Trim() == "2"? "פעמיים" : Eval("Amount") + " פעמים")) %><br />
                                                        <%#"ב" + Eval("Frequency") %></td>
                                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("length") %></td>
                                                    <td rowspan="3" class="tdLastRow" style="border-bottom: 3px solid gray;"><%#Eval("Helper") %><br />
                                                        <%#Eval("SupporterName") %><br />
                                                    </td>
                                                </tr>
                                                <tr style="vertical-align: top;">
                                                    <td class="rowHeader">יעדים</td>
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
                                    </div>

                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>
        </div>
        <%--    ---------------------------
            תוכנית שבועית
            -------------------------- ---%>
        <span></span>
        <div id="divWeeklytimetable" runat="server" class="wkhide" style="page-break-before: always;">
            <div id="div2">
                <asp:ListView runat="server" ID="lvHdr2" OnDataBinding="lvHdr_DataBind" Style="top: 0px; right: 5px">
                    <LayoutTemplate>
                        <table id="itemPlaceholderContainer" runat="server" style="width: 640px; background-color: #EEEEEE; border: 1px solid gray; font-size: 11px;">
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>

                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr>
                            <td colspan="6" style="text-align: center;">
                                <asp:Label runat="server" ID="lblName" Style="font-size: xx-large; font-weight: bold;" Text='<%#"תוכנית שבועית - " + Eval("Name") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold; width: 100px;">ת.ז:
                            </td>
                            <td style="text-align: right; width: 300px;">
                                <%#Eval("CustomerID")%>
                            </td>
                            <td style="width: 40px;"></td>
                            <td style="width: 40px;"></td>
                            <td style="font-weight: bold; text-align: left; width: 80px;">ת.לידה:
                            </td>
                            <td style="text-align: left; width: 80px;">
                                <%#Eval("CustBirthDate", "{0:dd/MM/yyyy}")%>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">מסגרת:
                            </td>
                            <td colspan="3" style="text-align: right;">
                                <%#Eval("FrameName")%>
                            </td>
                            <td style="font-weight: bold; text-align: left;">ת.קליטה:
                            </td>
                            <td style="text-align: left;">
                                <asp:Label runat="server" ID="lblStart" Text='<%#Eval("EnterDate", "{0:dd/MM/yyyy}")%>' />
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold;">מעדכן התוכנית:
                            </td>
                            <td colspan="3" style="text-align: right;">
                                <%#Eval("URName")%>
                            </td>
                            <td style="font-weight: bold; text-align: left;">ת.עדכון:
                            </td>
                            <td style="text-align: left;">
                                <%#Eval("CustEventDate", "{0:dd/MM/yyyy}")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
            </div>
            <asp:ListView runat="server" ID="LVWeeklyPlan" DataSourceID="DSWeeklyPlan">
                <LayoutTemplate>
                    <table id="itemPlaceholderContainer" runat="server" class="lstv" style="width: 640px; direction: rtl;">
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

                    <div style="width: 700px;">
                        <table runat="server" id="tblsign">
                            <tr style="height: 30px;">
                                <td>חתימת התלמיד/ה</td>
                                <td>_______________________</td>
                            </tr>
                            <tr style="height: 30px;">
                                <td>חתימת מדריכ/ה</td>
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
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td class="dayw">
                            <%#WW(1) %>
                        </td>
                        <td class="dayw">
                            <%#WW(2) %>
                        </td>
                        <td class="dayw">
                            <%#WW(3) %>
                        </td>
                        <td class="dayw">
                            <%#WW(4) %>
                        </td>
                        <td class="dayw">
                            <%#WW(5) %>
                        </td>
                        <td class="dayw">
                            <%#WW(6) %>
                        </td>
                        <td class="dayw">
                            <%#WW(7) %>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>
        </div>
        <br />
        <br />

        <%--    ---------------------------
            שאילתות
            -------------------------- ---%>
    </div>
    <asp:SqlDataSource ID="DSMP" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM Book10.dbo.TT_EduMP(@CustomerID,@EventID)" CancelSelectOnNullParameter="false">
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerId" QueryStringField="CID" Type="Int32" />
            <asp:QueryStringParameter Name="EventId" QueryStringField="ID" Type="Int32" />
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

    <asp:SqlDataSource ID="DSWeeklyPlan" runat="server"
        ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM dbo.TT_fnWeeklyPlan_N(@EventID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="EventID" QueryStringField="ID" DefaultValue="73286" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
