<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="TTedupList.aspx.cs" Inherits="TTF.TTedupList" %>
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
                    <td class="rowHeader">מטרה
                    </td>
                    <td colspan="5">
                        <%#Eval("Purpose") %>
                    </td>
                </tr>
                <tr class="phdr">
                    <td colspan="6">הפירוט</td>
                </tr>
                                  <tr class="psubhdr">
                                        <td style="border-bottom: 3px solid gray;width:50px;"></td>
                                        <td style="border-bottom: 3px solid gray;">פירוט</td>
                                        <td style="border-bottom: 3px solid gray;">תקופת התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">תדירות</td>
                                        <td style="border-bottom: 3px solid gray;">משך התמיכה</td>
                                        <td style="border-bottom: 3px solid gray;">ספק התמיכה</td>
                                    </tr>
                 <tr>
                    <td class="rowHeader" style="width: 50px;">יעדים</td>
                    <td class="dataCell" style="width: 550px;">
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
                <tr style="font-weight: bold; font-size: medium; text-align: center; background-color: gray; color: white;"><td colspan="6">המעקבים</td></tr>
            </ItemTemplate>
        </asp:ListView>

<%--    ---------------------------
        רשימת המעקבים 
        -------------------------- ---%>

       <asp:ListView runat="server" ID="lvDetup" DataSourceID="DSDetReport" DataKeyNames="Id" OnItemUpdating="lvDetup_ItemUpdating">
            <LayoutTemplate>
                <table runat="server" id="itemPlaceholderContainer" class="ptbl" style="width: 100%;">
                    <tr class="psubhdr">
                        <td>עמידה ביעד
                        </td>
                        <td>הערות
                        </td>
                        <td>שם המדווח
                        </td>
                        <td>מועד הדיווח
                        </td>
                        <td></td>
                    </tr>
                    <tr runat="server" id="itemPlaceholder">
                    </tr>
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
                    <td style="width: 50px;">
                        <%#Eval("Q4") %>
                    </td>
                    <td style="width:550px;">
                        <%#Eval("Text") %>
                    </td>
                    <td>
                        <%#Eval("URName") %>
                    </td>
                    <td>
                        <%#string.Format("{0:dd/MM/yyyy}",Eval("LoadTime")) %>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="עריכה" CommandName="Edit" Visible='<%#isUpdatable() %>' />
                        <asp:LinkButton runat="server" ID="lnkbDelete" Text="מחיקה" CommandName="Delete" OnClientClick="return confirm('האם למחוק?')" Visible='<%#isUpdatable() %>'></asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>

<%--    ---------------------------
        עריכת מעקב
        -------------------------- ---%>

            <EditItemTemplate>
                <tr class="editbck">
                    <td style="width: 73px;">
                        <asp:HiddenField runat="server" ID="hdnRepId" Value='<%#Eval("Id") %>' />
                        <asp:RadioButtonList runat="server" ID="rblFUDet" RepeatDirection="Horizontal" BackColor="#DDEEFF" SelectedValue='<%#Eval("val") %>' CssClass="rbl" Width="70" Font-Size="10">
                            <asp:ListItem Value="3"><br />כן</asp:ListItem>
                            <asp:ListItem Value="2">חלקי</asp:ListItem>
                            <asp:ListItem Value="1"><br />לא</asp:ListItem>
                        </asp:RadioButtonList>
                        <asp:RequiredFieldValidator runat="server" ID="rfv4" ControlToValidate="rblFUDet" ForeColor="Red" ErrorMessage="בחר תשובה" />

                    </td>
                    <td>
                        <asp:TextBox runat="server" ID="tbFuT" Columns="50" Text='<%#Eval("Text") %>' />
                    </td>
                    <td>
                        <%#Eval("URName") %>
                    </td>
                    <td>
                        <%#string.Format("{0:dd/MM/yyyy}",Eval("LoadTime")) %>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="lnkbEdit" Text="שמירה" CommandName="Update" />
                        <asp:LinkButton runat="server" ID="lnkbDelete" Text="ביטול" CommandName="Cancel"></asp:LinkButton>
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    </div>

<%--    ---------------------------
        שאילתות
        -------------------------- ---%>

    <asp:SqlDataSource runat="server" ID="DSDetReport" ConnectionString="<%$ ConnectionStrings:Book10PE %>"
        SelectCommand="SELECT Id ,FormId ,EventId ,CustomerId ,WpId ,DetailsId ,val4 Val,Q4 ,Text ,UserId ,URName ,LoadTime 
                                                    FROM Book10.dbo.TT_vDetReports
                                                    WHERE  DetailsId = @Id And EventId = @EventId
                                                   ORDER BY LoadTime DESC"
        DeleteCommand="UPDATE TT_WP_Reports SET Status = 1 WHERE Id = @Id"
        UpdateCommand="UPDATE TT_WP_reports SET val=@val,text=@Text,UserId=@UserId,LoadTime=GETDATE() WHERE Id=@Id">
        <SelectParameters>
            <asp:QueryStringParameter Name="Id" QueryStringField="RId" Type="Int32" DefaultValue="1" />
            <asp:QueryStringParameter Name="EventId" QueryStringField="Id" Type="Int32" DefaultValue="1" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="val" Type="Int32" />
            <asp:Parameter Name="Text" Type="String" />
            <asp:SessionParameter Name="UserId" SessionField="UserId" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource runat="server" ID="DSDet" ConnectionString="<%$ ConnectionStrings:Book10PE %>"
        SelectCommand="SELECT cR.Name Range,cS.Name Subject,w.PurposeText Purpose,d.Text,d.Text1,d.Text2,ISNULL(PeriodText,cP.Name) Period,cA.Name Amount,cF.Name Frequency,cL.Name [Length],ISNULL(d.HelperText,cH.Name) Helper,SupporterName
FROM TT_WP_Details d
LEFT OUTER JOIN TT_WP w ON w.Id=d.WPId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cR ON cR.Id = w.RangeId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cS ON cS.Id = w.SubjectId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cP ON cP.Id = d.PeriodId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cA ON cA.Id = d.AmountId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cF ON cF.Id = d.FrequencyID
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cL ON cL.Id = d.LengthId
LEFT OUTER JOIN B10Sec.dbo.TT_Classes cH ON cH.Id = d.HelperId
WHERE d.Id=@RId
">
        <SelectParameters>
            <asp:QueryStringParameter Name="RId" QueryStringField="RId" Type="Int32" DefaultValue="1" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>
