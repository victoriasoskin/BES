<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CSTCOUNT.aspx.vb" Inherits="CSTCOUNT" EnableEventValidation="false" %>

<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<%--<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>--%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .p {
            width: 200px;
            padding-right: 10px;
        } 

        .pg {
            position: absolute;
            background-color: #C0C0C0;
            width: 800px;
            border: 2px groove Gray;
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
        }

        .tbw {
            background-color: #ececec;
            font-family: verdana;
            width: 120px;
        }

        .divid {
            background-color: #ececec;
            font-family: verdana;
            width: 104px;
        }

        .divemail {
            background-color: #ececec;
            font-family: verdana;
            width: 126px;
        }

        .ddlw {
            background-color: #ececec;
            font-family: verdana;
            width: 125px;
            border-style: groove;
        }

        .tdr {
            padding-right: 10px;
            padding-top: 5px;
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
            font-family: verdana;
            border: 2px inset;
            color: Gray;
            padding-right: 2px;
            padding-left: 2px;
        }
    </style>
    <script src="jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        //$(document).ready(function () {
        //    $('.gv tr').css("background-color", "white");
        //    $('.gv tr').last().css("background-color", "lightgray");
        //});
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
    <style type="text/css">
        .gv th {
            background-color: #DDDDDD;
        }

        .gv td {
            direction: rtl;
            text-align: right;
        }
        .kitot {
            border-left:2px solid blue;
            border-right:2px solid blue;
            direction:ltr;
        }
    </style>
    <div runat="server" id="divform" class="pg">
        <topyca:PageHeader runat="server" ID="PageHeader1" Header="עמידה ביעד לקוחות" ButtonJava="" />
        <div style="padding-right: 190px">
            <h2>
                <asp:Label runat="server" ID="lblSubLabel" OnPreRender="lblSubLabel_PreRender" />
                נכון ל 
        <asp:Label ID="LBLTODAY" runat="server" OnPreRender="LBLTODAY_PreRender"></asp:Label></h2>
        </div>
        <div>
            <hr />

            <div style="vertical-align: middle; width: 100%">
                    <input type="button" onclick="fout(this);" value="-"
                        style="width: 15px; height: 20px; background: transparent; font-size: medium;" />&nbsp;<span class="blockHeader">הגדרת הדוח</span>
                <table class="tbld" id="tbldef">
                    <tr>
                        <td style="height: 20px; padding: 0px 10px 0px 0px;"><asp:Label runat="server" ID="Label1"  Text="סוג דוח:" OnPreRender="lblReg_PreRender" ></asp:Label></td>
                        <td style="height: 20px; margin: 0px;">&nbsp;&nbsp;
            <asp:RadioButtonList runat="server" ID="rblR" RepeatDirection="Horizontal" AutoPostBack="true" OnPreRender="rblR_PreRender">
                <asp:ListItem Value="0">ספירת לקוחות</asp:ListItem>
                <asp:ListItem Value="1">ספירת כיתות ותלמידים</asp:ListItem>
            </asp:RadioButtonList>
                        </td>
                        <td style="width: 80px;"><asp:Label runat="server" ID="lblReg"  Text="אזור:" OnPreRender="lblReg_PreRender" ></asp:Label>
                        </td>
                        <td style="width: 285px;">&nbsp;&nbsp;
            <asp:DropDownList runat="server" ID="ddlRegions" DataSourceID="DSRegions" DataValueField="Id" DataTextField="Name" AppendDataBoundItems="true" OnPreRender="ddlRegions_PreRender" AutoPostBack="true">
                <asp:ListItem Value="">בחר איזור</asp:ListItem>
            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 80px;">שנה:
                        </td>
                        <td style="width: 285px;">&nbsp;&nbsp;
            <asp:DropDownList runat="server" ID="ddlYears" DataSourceID="DSYears" DataValueField="WorkyearFirstDate" DataTextField="Workyear" AppendDataBoundItems="true" EnableViewState="false" OnPreRender="ddlYears_PreRender" AutoPostBack="true">
                <asp:ListItem Value="">בחר שנה</asp:ListItem>
            </asp:DropDownList>
                        </td>
                        <td style="width: 55px;">
                        </td>
                        <td>&nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-right: 0px;">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center;">
                            <asp:Button runat="server" ID="btnShow" Text="הפקה" OnPreRender="btnShow_PreRender" />
                            <asp:Button runat="server" ID="btnXl" Text="XL" OnPreRender="btnXl_PreRender" />

                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="width: 100%;">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" ShowFooter="True" EnableTheming="false" CssClass="gv">
                                <RowStyle Wrap="False" BorderWidth="1px" BackColor="White"/>
                                <FooterStyle BackColor="LightGray"/>
                <HeaderStyle BackColor="LightGray" Wrap="false" />
                <%--                <SelectedRowStyle Wrap="False" />--%>

                <Columns>
                    <asp:TemplateField HeaderText="מסגרת">
                        <%--                       
                        --%>
                        <ItemTemplate><b>
                            <asp:Label ID="LBLFRAME" runat="server" Text='<%# Bind("מסגרת") %>' OnPreRender="LBLFRAME_PreRender"></asp:Label></b>
                        </ItemTemplate>
                        <FooterTemplate>
                            סה"כ
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="סוג">
                        <ItemTemplate>
                            <asp:Label ID="LBLTYPE" runat="server" Text='<%# Bind("סוג") %>'></asp:Label>
                        </ItemTemplate>
                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>יעד</td>
                                    <%--style="width: 100px"--%>
                                </tr>
                                <tr>
                                    <td>בפועל</td>
                                </tr>
                                <tr>
                                    <td>הפרש</td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                         <ItemStyle CssClass="kitot" BackColor="LightBlue" />
                         <HeaderStyle CssClass="kitot" />
                         <FooterStyle CssClass="kitot" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD0" OnPreRender="LBLD0_PreRender" />
                        </HeaderTemplate>
                        <ItemTemplate>
                        </ItemTemplate>
                        <FooterTemplate>
                            <table dir="ltr">
                                <tr>
                                    <td><asp:Label ID="LBLT0" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td> <asp:Label ID="LBLT1" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td> <asp:Label ID="LBLT2" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                      <asp:TemplateField>
                                                <ItemStyle HorizontalAlign="Right" />
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD1" Text='<%# hdrt(1) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS1" runat="server" Text='<%# vald(1,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>
                        <%--                       
                        --%>
                        <FooterTemplate>
                            <table dir="ltr">
                                <tr>
                                    <td><%--style="width: 100px">--%>
                                        <asp:Label ID="LBLST1" runat="server" Text='<%# GetTotal(1,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT1" runat="server" Text='<%# GetTotal(1,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT1" runat="server" Text='<%# GetTotal(1,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD2" Text='<%# hdrt(2) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS2" runat="server" Text='<%# vald(2,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>
                        <%--                       
                        --%>
                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST2" runat="server" Text='<%# GetTotal(2,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT2" runat="server" Text='<%# GetTotal(2,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT2" runat="server" Text='<%# GetTotal(2,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>

                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD3" Text='<%# hdrt(3) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS3" runat="server" Text='<%# vald(3,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST3" runat="server" Text='<%# GetTotal(3,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT3" runat="server" Text='<%# GetTotal(3,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT3" runat="server" Text='<%# GetTotal(3,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD4" Text='<%# hdrt(4) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS4" runat="server" Text='<%# vald(4,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST4" runat="server" Text='<%# GetTotal(4,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT4" runat="server" Text='<%# GetTotal(4,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT4" runat="server" Text='<%# GetTotal(4,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD5" Text='<%# hdrt(5) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS5" runat="server" Text='<%# vald(5,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST5" runat="server" Text='<%# GetTotal(5,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT5" runat="server" Text='<%# GetTotal(5,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT5" runat="server" Text='<%# GetTotal(5,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD6" Text='<%# hdrt(6) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS6" runat="server" Text='<%# vald(6,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST6" runat="server" Text='<%# GetTotal(6,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT6" runat="server" Text='<%# GetTotal(6,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT6" runat="server" Text='<%# GetTotal(6,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD7" Text='<%# hdrt(7) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS7" runat="server" Text='<%# vald(7,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST7" runat="server" Text='<%# GetTotal(7,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT7" runat="server" Text='<%# GetTotal(7,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT7" runat="server" Text='<%# GetTotal(7,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD8" Text='<%# hdrt(8) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS8" runat="server" Text='<%# vald(8,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST8" runat="server" Text='<%# GetTotal(8,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT8" runat="server" Text='<%# GetTotal(8,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT8" runat="server" Text='<%# GetTotal(8,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD9" Text='<%# hdrt(9) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS9" runat="server" Text='<%# vald(9,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST9" runat="server" Text='<%# GetTotal(9,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT9" runat="server" Text='<%# GetTotal(9,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT9" runat="server" Text='<%# GetTotal(9,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD10" Text='<%# hdrt(10) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS10" runat="server" Text='<%# vald(10,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST10" runat="server" Text='<%# GetTotal(10,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT10" runat="server" Text='<%# GetTotal(10,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT10" runat="server" Text='<%# GetTotal(10,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD11" Text='<%# hdrt(11) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS11" runat="server" Text='<%# vald(11,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST11" runat="server" Text='<%# GetTotal(11,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT11" runat="server" Text='<%# GetTotal(11,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT11" runat="server" Text='<%# GetTotal(11,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="LBLD12" Text='<%# hdrt(12) %>' />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="LBLS12" runat="server" Text='<%# vald(12,Eval("סוג")) %>'></asp:Label>
                        </ItemTemplate>


                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLST12" runat="server" Text='<%# GetTotal(12,"יעד") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLAT12" runat="server" Text='<%# GetTotal(12,"בפועל") %>'></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLDT12" runat="server" Text='<%# GetTotal(12,"הפרש") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="הפרש מצטבר">
                        <ItemTemplate>
                            <asp:Label ID="LBLSUMDIFF" runat="server" OnPreRender="LBLSUMDIFF_PreRender" Width="35px"></asp:Label>
                        </ItemTemplate>

                        <FooterTemplate>
                            <table>
                                <tr>
                                    <td>
                                </tr>
                                <tr>
                                    <td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="LBLSUMDIFFT" runat="server" OnPreRender="LBLSUMDIFFT_PreRender" Width="35px"></asp:Label></td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </div>
    <asp:SqlDataSource runat="server" ID="DSRegions" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="Select ServiceId Id,ServiceName Name
FROM ServiceList
WHERE ServiceID in (1,3,4,17)
		AND 
	  ServiceID IN (SELECT Distinct ServiceId
					FROM Framelist f 
					INNER JOIN (SELECT FrameID 
					FROM p0v_UserFrameList
					WHERE UserID = @UserID) u ON u.FrameID=f.FrameID)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource runat="server" ID="DSYears" ConnectionString="<%$ ConnectionStrings:BEBook10 %>" SelectCommand="SELECT Workyear,WorkyearFirstDate
FROM p0t_WorkYears
WHERE WYType = @R AND WorkyearFirstDate &gt;= CASE @R WHEN 1 THEN '2012-9-1' ELSE '2000-1-1' END">
        <SelectParameters>
            <asp:ControlParameter ControlID="rblR" Name="R" PropertyName="SelectedValue" />
        </SelectParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSvA" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="" SelectCommandType="StoredProcedure" CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLYEARS" Name="FirstDate" PropertyName="SelectedValue"
                Type="DateTime" />
            <asp:ControlParameter ControlID="LBLTODAY" Name="RepDate" PropertyName="Text" Type="DateTime" />
            <asp:ControlParameter ControlID="DDLRegions" Name="ServiceID" PropertyName="SelectedValue"
                Type="Int32" />
            <asp:Parameter DefaultValue="" Name="FrameID" Type="Int32" />
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

