<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" CodeFile="Reports.aspx.vb" Inherits="Reports" title="בית אקשטיין - דוחות" MaintainScrollPositionOnPostback="true" %>

<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="~/Controls/TreeDropDown.ascx"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script type='text/javascript'>
        function popup(url) {
            params = 'width=' + screen.width;
            params += ', height=' + screen.height;
            params += ', top=0, left=0'
            params += ', fullscreen=yes';

            newwin = window.open(url, 'windowname4', params);
            if (window.focus) { newwin.focus() }
            return false;
        }
         function thiscolumn(n, m) 
    { 
//        if (m != 1) {
//            var str2 = '00' + (m - 1);
//            str2 = str2.substring(str2.length - 2);
//            for (i = 1; i <= n; i = i + 1) {
//                var str1 = '00' + i;
//                str1 = str1.substring(str1.length - 2);
//                var str3 = 'ctl00_ContentPlaceHolder1_gv_ctl' + str1 + '_ctl' + str2;
//                var str4 = 'ctl00_ContentPlaceHolder1_gv_ctl' + str1 + '_ctl00';
//                var cel = document.getElementById(str3);
//                if (cel != null) {
//                    if (cel.style.backgroundColor == 'yellow') {
//                        var ccel = document.getElementById(str4);
//                        cel.style.backgroundColor = ccel.style.backgroundColor;
//                    }
//                    else {
//                        cel.style.backgroundColor = 'yellow';
//                    }
//                }
//            }
//        }
//        else {
//            duphdr(n);
//        }
    }
    function hidecolumns() {
//        var st = '';
//        for (i = 1; i <= 30; i = i + 1) {
//            var str1 = '00' + (i - 1);
//            str1 = str1.substring(str1.length - 2);
//            var str3 = 'ctl00_ContentPlaceHolder1_gv_ctl02_ctl' + str1;
//            var cel = document.getElementById(str3);
//            if (cel != null) {
//                if (cel.style.backgroundColor == 'yellow') {
//                    st = st +'|' + i;
//                }
//            }
//        }
//        if (st.length>0)
//        {
//            window.open("p4asadin.aspx?h=" + st, "_self", "");
//        } 
   }
    function DoPrint()
    {
        document.all("PRINT").style.visibility = "hidden";
        document.all("tdbtn0").style.visibility = "hidden";
        document.all("tdbtn1").style.visibility = "hidden";
        document.all("tdbtn2").style.visibility = "hidden";
        
//        document.all('<%= DDLREPTYPE.ClientID %>').style.visibility = "hidden";
//        document.all('<%= btnshow.ClientID %>').style.visibility = "hidden";
//        document.all('<%= btnexcel.ClientID %>').style.visibility = "hidden";
//        document.all('<%= CBDVLP.ClientID %>').style.visibility = "hidden";
//        document.all("btnhidecols").style.visibility = "hidden";
//        document.all('<%= BTNCATEGORYLIST.ClientID %>').style.visibility = "hidden";
        document.execCommand('print', false, null);
        document.all("PRINT").style.visibility = "visible";
        document.all("tdbtn0").style.visibility = "visible";
        document.all("tdbtn1").style.visibility = "visible";
        document.all("tdbtn2").style.visibility = "visible";

//        document.all('<%= DDLREPTYPE.ClientID %>').style.visibility = "visible";
//        document.all('<%= btnshow.ClientID %>').style.visibility = "visible";
//        document.all('<%= btnexcel.ClientID %>').style.visibility = "visible";
//        document.all('<%= CBDVLP.ClientID %>').style.visibility = "visible";
//        document.all("btnhidecols").style.visibility = "visible";
//        document.all('<%= BTNCATEGORYLIST.ClientID %>').style.visibility = "visible";
    }
    function duphdr(x) {
//        var tab = document.getElementById('<%= gv.ClientID %>');
//        var root = tab.getElementsByTagName('tr')[0].parentNode; //the TBODY
//        var clone = tab.getElementsByTagName('tr')[0].cloneNode(true); //the clone of the first row
//        var trgt = x.parentNode.previousSibling;
//        trgt.style.pageBreakAfter = 'always'
//        trgt.insertBefore(clone);
    }
    function myPrint() {

        document.printing.leftMargin = 1.0;

        document.printing.topMargin = 1.0;

        document.printing.rightMargin = 1.0;

        document.printing.bottomMargin = 1.0;

        document.printing.portrait = false;

        document.execCommand('print', false, null); // print without prompt
    }
 
</script>
    <table style="background-color:#EEEEEE;" border="0">
        <tr style="background-color:#EEEEEE;border-color:#EEEEEE;">
            <td>    
                <asp:Label ID="lblhdr" runat="server" ForeColor="Blue" 
                    Text="" Font-Bold="True" Font-Size="Large"></asp:Label>

                &nbsp;</td>
            <td colspan="2">
                <asp:Label ID="LBLWY" runat="server" Text="תחילת שנת התקציב" Width="150px" 
                    Visible="False"></asp:Label>
            </td>
            <td>
                <asp:Label ID="LBLFDATE" runat="server" Width="60px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="6">
                <table border="0">
                    <tr valign="top">
                        <td valign="top" id="tdbtn0">
                            &nbsp;</td>
                        <td>
                <table border="2">
                    <tr>
                        <td>
                            <asp:label runat="server" ID="lblver1_2" text="גרסאות ראשיות" Visible="false" Width="100px" />
                        </td>
                        <td style="border-color:#EEEEEE;">
<%--                        <asp:Label runat="server" ID="lblWrap" Height="1" /><br />
--%>                            <asp:SqlDataSource ID="DSVERSION" runat="server" 
                                ConnectionString="Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
                                SelectCommand="">
                            </asp:SqlDataSource>
                            <asp:DropDownList ID="DDLVERSION1" runat="server" AppendDataBoundItems="True" 
                                AutoPostBack="True" DataSourceID="DSVERSION" DataTextField="VERSION" 
                                DataValueField="CategoryID">
                                <asp:ListItem value="">[בחר גרסה 1]</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                              <asp:Label ID="Label3" runat="server" Width="447px"></asp:Label>
                              <asp:DropDownList ID="DDLVERSION2" runat="server" AppendDataBoundItems="True" 
                                  DataSourceID="DSVERSION" DataTextField="VERSION" 
                                DataValueField="CategoryID" visible="False">
                                <asp:ListItem value="">[בחר גרסה 2]</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                             <asp:label runat="server" ID="lblver3_4" text="גרסאות משנה"  Visible="false" Width="100px" />
                       </td>
                        <td>
                            <asp:DropDownList ID="DDLVERSION3" runat="server" AppendDataBoundItems="True" 
                                DataSourceID="DSVERSION" DataTextField="VERSION" 
                                DataValueField="CategoryID" visible="False">
                                <asp:ListItem value="">[בחר גרסה 3]</asp:ListItem>
                            </asp:DropDownList>
                         </td>
                        <td>
                             <asp:DropDownList ID="DDLVERSION4" runat="server" AppendDataBoundItems="True" 
                                 DataSourceID="DSVERSION" DataTextField="VERSION" 
                                DataValueField="CategoryID" visible="False">
                                <asp:ListItem value="">[בחר גרסה 4]</asp:ListItem>
                            </asp:DropDownList>
                         </td>
                     </tr>
                     <tr>
                        <td>
                        </td>
                        <td>
                            <div runat="server" id="divSelectFrame" visible="false">
                                <topyca:TreeDropDown ID="tdd" runat="server" InitialText="[בחירת_מסגרת]" ValueType="Class" ConnStrName="BEBook10" CategoryID="CategoryID"
    ParentID="Parent" itemOrder="itemOrder" RootCategoryID="1" TextField="Name"  />
                            </div>
                        </td>
                        <td style="vertical-align:top;width:100%;">
 <%--               <asp:DropDownList ID="DDLREPTYPE" runat="server" AutoPostBack="True" >
                </asp:DropDownList>
 --%>
                    <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" RepeatColumns="4" ID="DDLREPTYPE" RepeatLayout="Table" CssClass="rblrep" style="vertical-align:top;width:100%;" width="300px"/>
                       </td>
                     </tr>
                </table>
             </td>
                        <td valign="top" id="tdbtn1">
                <asp:SqlDataSource ID="dsdates" runat="server" 
                    ConnectionString="Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
                    SelectCommand="SELECT FirstDate As [DL] FROM Versions">
                </asp:SqlDataSource>
                <asp:DropDownList ID="DDLDATES" runat="server" 
                    AppendDataBoundItems="True" AutoPostBack="True" 
                    DataTextFormatString="{0:MMM-yy}" >
                    <asp:ListItem Value="">[בחירת תאריך]</asp:ListItem>
                </asp:DropDownList>
            </td>
                        <td valign="top"><div id="tdbtn2">
                <asp:Button ID="btnshow" runat="server" Text="הצג" />
                <asp:Button ID="btnexcel" runat="server" Text="XL" Visible="false" />
                            <asp:CheckBox ID="CBDVLP" runat="server" Text="הצגת מספר עמודה" Visible="false" />
                            <br />
<%--                <button id="btnhidecols" onclick="hidecolumns()" >הסתר עמודות שנבחרו</button>
 --%>               <asp:Button ID="BTNCATEGORYLIST" runat="server" Text="רשימת מסגרות" Visible="false" />
                     </div></td>
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr style="vertical-align:top;">
            <td colspan="8" style="height: 163px">
                <asp:GridView ID="gv" runat="server" EnableViewState="true"
                    AutoGenerateColumns="false" CellPadding="2" ShowFooter="True" 
                    Font-Size="X-Small" EnableModelValidation="False">
                    <HeaderStyle VerticalAlign="Top" Wrap="false" />
                    <AlternatingRowStyle Wrap="False" />
                    <FooterStyle Wrap="false" />
                    <RowStyle Wrap="False" />
                    <SortedAscendingCellStyle Wrap="False" />
                </asp:GridView>
                <asp:Label ID="lbldate" runat="server" Visible="false" ></asp:Label>
                <asp:Label ID="lblsubhdr" runat="server" Visible="false"  ></asp:Label>
                <asp:Label ID="lblComment" runat="server" Visible="false"  ></asp:Label>
             </td>
        </tr>
        <tr style="vertical-align:top;">
            <td colspan="8"><asp:GridView ID="gvComments" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="dscomments" Visible="False">
                    <Columns>
                        <asp:TemplateField >
                            <HeaderTemplate>הערות</HeaderTemplate>
                            <ItemTemplate>
                                <%# Eval("Comment")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView><br />
               <asp:Chart ID="ChrtG" runat="server" Visible="false"
                     RightToLeft="Yes"> 
                   <Series>
                   </Series> 
                    <ChartAreas> 
 				         <asp:ChartArea Name="MainChartArea" >
						</asp:ChartArea> 
                   </ChartAreas> 
                </asp:Chart>
                <br /><input id="PRINT" type="button" value="הדפסה" onclick="DoPrint()" visible="false" />
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="dscomments" runat="server" 
    ConnectionString="Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
    
        SelectCommand="SELECT Comment FROM ReportComments 
                        WHERE (Report = @Report) AND (PageID = @PageID) 
                            AND (Comment IS NOT NULL) 
                            AND (COALESCE (VersionCategoryID, @VersionCategoryID, 0) = COALESCE (@VersionCategoryID, VersionCategoryID, 0)) 
                            AND (COALESCE (FrameCategoryID, @FrameCategoryID, 0) = COALESCE (@FrameCategoryID, FrameCategoryID, 0))" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:QueryStringParameter Name="Report" QueryStringField="r" Type="Int32" />
            <asp:ControlParameter ControlID="DDLREPTYPE" Name="PageID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="DDLVERSION1" Name="VersionCategoryID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="tdd" Name="FrameCategoryID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
</asp:SqlDataSource>
</asp:Content>
