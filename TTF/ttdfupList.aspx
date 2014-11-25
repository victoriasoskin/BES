<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="ttdfupList.aspx.cs" Inherits="TTF.ttdfupList" %>
<%--<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="TTemupList.aspx.cs" Inherits="TTF.TTemupList" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css"></style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<%--    ---------------------------
        כפתור סגירה
        -------------------------- ---%>

    <a href="javascript:window.open('', '_self', ''); window.close();" style="position:fixed;top:0px;right:9px;z-index:888;" >סגירה</a>

<%--    ---------------------------
        קודים נשמרים
        -------------------------- ---%>

        <asp:HiddenField runat="server" ID="hdnItemHandled" /> 
        <asp:HiddenField runat="server" ID="hdnCurrentWpId" />
        <asp:HiddenField runat="server" ID="hdnForm127" />
        <asp:HiddenField runat="server" ID="hdnDate127" />

<%--    ---------------------------
        כותרת הדף (fixed)
        -------------------------- ---%>

    <div id="divheader">
        <asp:ListView runat="server" ID="lvHdr" OnDataBinding="lvHdr_DataBind" Style="top: 0px; right: 5px">
            <LayoutTemplate>
                <table id="itemPlaceholderContainer" runat="server" border="0" class="lstv" style="width: 950px; position: fixed; top: 0px; right: 5px; background-color: #EEEEEE; border: 1px solid gray; ">
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
        <asp:HyperLink runat="server" ID="hlback" NavigateUrl="~/CustEventReport.aspx" />
    </div>

<%--    ---------------------------
        נתוני התמיכה
        -------------------------- ---%>

    <div style="position: absolute; top: 108px; right: 0px; padding-right: 5px; width: 950px;">
        <asp:ListView runat="server" ID="lvDdetHdr" DataSourceID="DSDet">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl" style="width: 950px;">
                    <tr runat="server" id="itemPlaceholder"></tr>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr class="phdr">
                    <td colspan="6">התמיכה</td>
                </tr>

                <tr>
                    <td class="rowHeader" style="width: 50px;">תחום
                    </td>
                    <td colspan="5">
                        <%#Eval("Range") %>
                    </td>
                </tr>
                <tr>
                    <td class="rowHeader">נושא
                    </td>
                    <td colspan="5">
                        <%#Eval("Subject") %>
                    </td>
                </tr>
                <tr>
                    <td class="rowHeader">מטרת על 
                    </td>
                    <td colspan="5">
                        <%#Eval("Purpose") %>
                    </td>
                </tr>
                <tr>
                    <td class="rowHeader">מטרה 
                    </td>
                    <td colspan="5">
                        <%#Eval("purposeText") %>
                    </td>
                </tr>
                <tr>
                    <td class="rowHeader">חשיבות 
                    </td>
                    <td colspan="5">
                        <%#Eval("weight") %>
                    </td>
                </tr>
                <tr style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;">
                    <td colspan="6">המעקבים</td>
                </tr>
            </ItemTemplate>
        </asp:ListView>

<%--    ---------------------------
        רשימת המעקבים 
        -------------------------- ---%>

        <asp:ListView runat="server" ID="lvMainReports" DataSourceID="DSReport" DataKeyNames="Id" OnItemUpdating="lvRep_ItemUpdating">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl" style="width: 100%;">
                    <tr class="psubhdr">
                        <td>פירוט</td>
                        <%--<td>באיזה מידה מומשה מטרת התוכנית</td>
                        <td>האם המטרה רלוונטית</td>--%>
                        <td>שם המדווח</td>
                        <td>מועד הדיווח</td>
                        <td></td>
                    </tr>
                    <tr runat="server" id="itemPlaceholder"></tr>
                </table>
            </LayoutTemplate>
            <EmptyDataTemplate>
               <div>אין מעקבים להצגה</div>
           </EmptyDataTemplate>

<%--    ---------------------------
        הצגת המעקבים 
        -------------------------- ---%>

           <ItemTemplate>
                <tr>
                    <td>
                        <%#Eval("text") %>
                       <%-- <asp:HiddenField runat="server" ID="hdnRepId" Value='<%#Eval("Id") %>' />--%>
                    </td>
                    
                    <td><%#Eval("UserName") %></td>
                    <td><%#string.Format("{0:dd/MM/yyyy}",Eval("LoadTime")) %></td>
                    <td style="white-space: nowrap;">
                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="עריכה" CommandName="edit" Visible='<%#isUpdatable() %>' />
                        <%--OnClick="lnkbEdit_Click"/>--%>
                        <asp:LinkButton runat="server" ID="lnkbDelete" Text="מחיקה" CommandName="delete" OnClientClick="return confirm('האם למחוק?');" Visible='<%#isUpdatable() %>' />
                    </td>
                </tr>
            </ItemTemplate>

<%--    ---------------------------
        עריכת מעקב
        -------------------------- ---%>

            <EditItemTemplate>
                <tr class="editbck">
                    <td>
                        <asp:RadioButtonList runat="server" ID="rbl1" RepeatDirection="Vertical" SelectedValue='<%#Eval("val1") %>'>
                            <asp:ListItem Value="2">כן</asp:ListItem>
                            <asp:ListItem Value="1">לא</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ID="rfv1" ControlToValidate="rbl1" Display="Dynamic" ErrorMessage="בחר תשובה" ValidationGroup='<%#"MainReport" + Eval("Id").ToString() %>' ForeColor="Red" />

                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="rbl2" RepeatDirection="Vertical" SelectedValue='<%#Eval("val2") %>'>
                            <asp:ListItem Value="4">במידה מלאה</asp:ListItem>
                            <asp:ListItem Value="3">במידה רבה</asp:ListItem>
                            <asp:ListItem Value="2">במידה מועטה</asp:ListItem>
                            <asp:ListItem Value="1">בכלל לא</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ID="rfv2" ControlToValidate="rbl2" Display="Dynamic" ErrorMessage="בחר תשובה" ValidationGroup='<%#"MainReport" + Eval("Id").ToString() %>' ForeColor="Red" />
                    </td>
                    <td>
                        <asp:RadioButtonList runat="server" ID="rbl3" RepeatDirection="Vertical" SelectedValue='<%#Eval("val3") %>'>
                            <asp:ListItem Value="2">כן</asp:ListItem>
                            <asp:ListItem Value="1">לא</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ID="rfv3" ControlToValidate="rbl3" Display="Dynamic" ErrorMessage="בחר תשובה" ValidationGroup='<%#"MainReport" + Eval("Id").ToString() %>' ForeColor="Red" />
                    </td>
                    <td><%#Eval("URName") %></td>
                    <td><%#string.Format("{0:dd/MM/yyyy}",Eval("LoadTime")) %></td>
                    <td style="white-space: nowrap;">
                        <asp:LinkButton runat="server" ID="lnkbSave" Text="שמירה" CommandName="Update" />
                        <asp:LinkButton runat="server" ID="lnkbMainCancel" Text="ביטול" CommandName="cancel" CausesValidation="false" />
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    </div>

<%--    ---------------------------
        שאילתות
        -------------------------- ---%>

    <asp:SqlDataSource runat="server" ID="DSReport" ConnectionString="<%$ ConnectionStrings:Book10PE %>" 
        SelectCommand="SELECT r.Id, r.WpId , r.text,r.LoadTime ,u.UserName
                       FROM Book10.dbo.TT_WP_Reports r
                       LEFT OUTER JOIN BOOK10_21.dbo.p0t_NtB u on u.userId= r.userID
                       WHERE r.WpId=@Id AND r.UserId is NOT NULL AND r.EventId = @EventId
                       ORDER BY r.LoadTime DESC"
        DeleteCommand="UPDATE    TT_WP_Reports
                        SET              Status = 1
                        FROM         TT_WP_Reports INNER JOIN
                                                  (SELECT     Id, FormId, EventId, CustomerId, WpId, DetailsId, QUestionId, val, Text, Status, Frm_CatId, PeriodKey, LoadTime, UserId
                                                    FROM          TT_WP_Reports AS TT_WP_Reports_1
                                                    WHERE      (Id = @Id)) AS x ON x.UserId = TT_WP_Reports.UserId AND x.LoadTime = TT_WP_Reports.LoadTime AND TT_WP_Reports.WpId = x.WpId
                        WHERE     (TT_WP_Reports.DetailsId = 0)"
        UpdateCommand="UPDATE    TT_WP_Reports
                        SET              val = CASE y.QuestionId WHEN 1 THEN @val1 WHEN 2 THEN @val2 WHEN 3 THEN @val3 END
                        FROM         TT_WP_Reports
                        INNER JOIN (SELECT     Id, QUestionId, WpId, LoadTime, UserId
                            FROM          TT_WP_Reports AS TT_WP_Reports_1
                            WHERE      (Id = @Id)) AS y ON TT_WP_Reports.WpId = y.WpId AND TT_WP_Reports.LoadTime = y.LoadTime AND y.UserId = TT_WP_Reports.UserId">
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="RId" Type="Int32" DefaultValue="1" />
             <asp:QueryStringParameter Name="EventId" QueryStringField="Id" Type="Int32" DefaultValue="1" />
       </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="val1" Type="Int32" />
            <asp:Parameter Name="val2" Type="Int32" />
            <asp:Parameter Name="val3" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="DSDet" ConnectionString="<%$ ConnectionStrings:Book10PE %>"
        SelectCommand="SELECT cR.Name Range,cS.Name Subject,Cp.Name Purpose,W.PurposeText purposeText,cw.Name weight,u.URName Helper
FROM book10.dbo.TT_WP w 
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cR ON cR.Id = w.RangeId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cS ON cS.Id = w.SubjectId
LEFT OUTER JOIN Book10.DBO.p0t_NtB u on u.UserID=w.UserId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes Cp on Cp.Id=w.PurposeId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cH ON cH.Id = w.UserId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cW ON cW.Id=w.WeightId
WHERE w.Id=@Rid
">
        <SelectParameters>
            <asp:QueryStringParameter Name="RId" QueryStringField="Rid" Type="Int32" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>


