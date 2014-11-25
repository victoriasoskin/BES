<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" CodeFile="p3aBVAREPM.aspx.vb" Inherits="Default3" title="אגף כספים - תקן הוצאות והשקעות" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="width:1000px;">
    <table>
        <tr>
            <td colspan="4">
    <asp:Label ID="LBLHDR" runat="server" Text="עמידה בתקציב הוצאות שוטפות והשקעות" Width="281px" Font-Bold="True" 
                    Font-Size="Medium" ForeColor="#0033CC" BorderStyle="None"></asp:Label>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr> 
        <tr>
            <td colspan="2">
                <asp:Label ID="LBLFRAMENAME" runat="server" Font-Bold="True" 
                    Font-Underline="True" ForeColor="#0033CC" Width="150px"></asp:Label>
           </td>
            <td>
                <asp:HiddenField ID="HDNFrameID" runat="server" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                <asp:HiddenField ID="HDNServiceID" runat="server" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DDLSERVICES" runat="server" AppendDataBoundItems="True" 
                    AutoPostBack="True" DataSourceID="DSSERVICES" DataTextField="Service" 
                    DataValueField="Service">
                    <asp:ListItem Value="">&lt;בחר שירות&gt;</asp:ListItem>
                </asp:DropDownList>
           </td>
            <td>
    <asp:DropDownList ID="DDLFRAME" runat="server" AutoPostBack="True" 
        DataSourceID="DSFrames" DataTextField="Frame" DataValueField="CategoryID" 
                    AppendDataBoundItems="True" EnableViewState="False">
        <asp:ListItem Value="">&lt;בחר מסגרת&gt;</asp:ListItem>
    </asp:DropDownList>
           </td>
            <td>
    <asp:DropDownList ID="DDLWY" runat="server" DataSourceID="DSWY" 
        DataTextField="Workyear" DataValueField="WorkyearFirstDate" 
        AutoPostBack="True" AppendDataBoundItems="True">
        <asp:ListItem Value="">&lt;בחר שנת עבודה&gt;</asp:ListItem>
    </asp:DropDownList>
            </td>
            <td>
                <asp:RadioButtonList ID="RBLREPTYPE" runat="server" AppendDataBoundItems="True" 
                    AutoPostBack="True" DataSourceID="DSREPTYPES" DataTextField="RepType" 
                    DataValueField="RepTypeID" RepeatDirection="Horizontal" 
                    BorderColor="#0033CC" BorderStyle="Solid" BorderWidth="1px">
                    <asp:ListItem Value="" Selected="True">&lt;הכל&gt;</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>
                <asp:RadioButtonList ID="RBLDETAILS" runat="server" AutoPostBack="True" 
                    BorderColor="#0000CC" BorderStyle="Solid" BorderWidth="1px" 
                    RepeatDirection="Horizontal">
                    <asp:ListItem Selected="True" Value="0">ריכוז</asp:ListItem>
                    <asp:ListItem Value="1">פרוט</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td>
                <asp:LinkButton ID="LNKBBACK" runat="server" Visible="False">חזרה</asp:LinkButton>
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSREPTYPES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT [RepType], [RepTypeID] FROM [p4t_RepTypes] WHERE ([ReptypeGroupID] = 1) ORDER BY [RepTypeID]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSERVICES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        
        
        SelectCommand="SELECT [שירות_-_1] As Service, CategoryID FROM p4v_ServiceList WHERE (UserID = @UserID)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        
        
        
        SelectCommand="SELECT Frame, CategoryID, Service FROM p4v_FrameList WHERE (UserID = @UserID) AND (Service = @Service) " 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" />
            <asp:ControlParameter ControlID="DDLSERVICES" Name="Service" 
                PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSWY" runat="server" 
        ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
        SelectCommand="SELECT [Workyear], [WorkyearFirstDate] FROM [p0t_WorkYears]"></asp:SqlDataSource>
<asp:Repeater runat="server" ID="rptbudact" DataSourceID="dsbudact" ViewStateMode="Disabled">
    <ItemTemplate>
        <table border="1">
            <tr>
                <td style="background-color:#6699FF"><asp:Label ID="LBLTITLE1" runat="server" Text='<%# Eval("HDRTYP") %>' Width="83px" />
                </td>
                <td colspan="13" style="background-color:#6699FF">
                    <asp:HyperLink ID="Label2" runat="server" Text='<%# Eval("BudItem") %>'   
                        Width="180px" NavigateUrl='<%# backVal() %>'></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                    נושא</td>
                <td colspan="13">
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Subject") %>' 
                        Width="200px"></asp:Label>
                </td>
            </tr>
            <tr style="background-color:#CCCCCC">
                <td>
                </td>
                <td>
                    <asp:Label ID="LBLDT1" runat="server" onprerender="LBLDT1_PreRender" ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT2" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT3" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT4" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT5" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT6" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT7" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT8" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT9" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT10" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT11" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLDT12" runat="server" onprerender="LBLDT1_PreRender"  ViewStateMode="Disabled"
                        Text="Label" Width="50px"></asp:Label>
                </td>
                <td>
                    <asp:Label ID="LBLTOT" runat="server"   ViewStateMode="Disabled"
                        Text='סה"כ'  Width="50px"></asp:Label>
                </td>
            </tr>
            <tr style="background-color:#EEEEBB">
                <td>
                    תקציב</td>
                <td >
                    <asp:HyperLink ID="HLBUD1" Text='<%# tVal(1,"|+תקציב") %>' runat="server" ViewStateMode="Disabled"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD2" Text='<%# tVal(2,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD3" Text='<%# tVal(3,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD4" Text='<%# tVal(4,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD5" Text='<%# tVal(5,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ID="HLBUD6" ViewStateMode="Disabled" Text='<%# tVal(6,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD7" Text='<%# tVal(7,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ID="HLBUD8" ViewStateMode="Disabled" Text='<%# tVal(8,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD9" Text='<%# tVal(9,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD10" Text='<%# tVal(10,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD11" Text='<%# tVal(11,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD12" Text='<%# tVal(12,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLBUD13" Text='<%# tVal(13,"|+תקציב") %>' runat="server"></asp:HyperLink>
                </td>
            </tr>
                 <tr style="background-color:#EEEEBB">
                <td>בפועל</td>
                    <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT1" Text='<%# tVal(1,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",1,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT2" Text='<%# tVal(2,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",2,TRUE) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT3" Text='<%# tVal(3,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",3,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT4" Text='<%# tVal(4,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",4,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT5" Text='<%# tVal(5,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",5,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT6" Text='<%# tVal(6,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",6,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT7" Text='<%# tVal(7,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",7,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT8" Text='<%# tVal(8,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",8,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT9" Text='<%# tVal(9,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",9,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT10" Text='<%# tVal(10,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",10,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT11" Text='<%# tVal(11,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",11,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT12" Text='<%# tVal(12,"|+משוערות|+נוספות|+הנהח") %>' NavigateUrl='<%# mval("",12,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                 </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLTOT13" Text='<%# tVal(13,"|+משוערות|+נוספות|+הנהח") %>'  NavigateUrl='<%# mval("",13,true) %>' Target="_blank" runat="server"></asp:HyperLink>
                 </td>
            </tr>
            <tr>
                <td>
                    הפרש</td>
                     <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF1" Text='<%# tVal(1,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF2" Text='<%# tVal(2,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF3" Text='<%# tVal(3,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF4" Text='<%# tVal(4,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF5" Text='<%# tVal(5,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF6" Text='<%# tVal(6,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF7" Text='<%# tVal(7,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF8" Text='<%# tVal(8,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF9" Text='<%# tVal(9,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF10" Text='<%# tVal(10,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF11" Text='<%# tVal(11,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                </td>
                <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF12" Text='<%# tVal(12,"|-משוערות|-נוספות|-הנהח|+תקציב",true) %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                 </td>
               <td>
                    <asp:HyperLink ViewStateMode="Disabled" ID="HLDIF13" Text='<%# tVal(13,"|-משוערות|-נוספות|-הנהח|+תקציב") %>' runat="server" onprerender="HLDIF_PreRender"></asp:HyperLink>
                 </td>
           </tr>
           <tr style="background-color:#EEEEBB">
           <td>
           הפרש מצטבר
           </td>
           <td><asp:Label ViewStateMode="Disabled" runat="server" id="LBLADIF1" Text='<%# aTot(1) %>'  OnPreRender="LBLADIF_prerender"></asp:Label></td>
           <td><asp:Label ViewStateMode="Disabled" runat="server" id="LBLADIF2" Text='<%# aTot(2) %>'  OnPreRender="LBLADIF_prerender"></asp:Label></td>
           <td><asp:Label ViewStateMode="Disabled" runat="server" id="LBLADIF3" Text='<%# aTot(3) %>'  OnPreRender="LBLADIF_prerender"></asp:Label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF4" Text='<%# aTot(4) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF5" Text='<%# aTot(5) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF6" Text='<%# aTot(6) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF7" Text='<%# aTot(7) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF8" Text='<%# aTot(8) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF9" Text='<%# aTot(9) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF10" Text='<%# aTot(10) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:label ViewStateMode="Disabled" runat="server" id="LBLADIF11" Text='<%# aTot(11) %>'  OnPreRender="LBLADIF_prerender"></asp:label></td>
           <td><asp:Label ViewStateMode="Disabled" runat="server" id="LBLADIF12" Text='<%# aTot(12) %>'  OnPreRender="LBLADIF_prerender"></asp:Label></td>
           <td><asp:Label ViewStateMode="Disabled" runat="server" id="LBLADIF13" Text='<%# aTot(12) %>'  OnPreRender="LBLADIF_prerender"></asp:Label></td>

           </tr>
    </table>
    </ItemTemplate>
</asp:Repeater>
    <br />
    <asp:SqlDataSource ID="DSBUDACT" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="p3p_PivotBudgetL" SelectCommandType="StoredProcedure" 
        CancelSelectOnNullParameter="False">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLFRAME" Name="FrameCategoryID" PropertyName="SelectedValue" Type="Int32" />
            <asp:Parameter Name="SumN" Type="String" DefaultValue="S" />
            <asp:ControlParameter ControlID="DDLWY" Name="FirstDate" Type="DateTime" PropertyName="SelectedValue" />
            <asp:ControlParameter ControlID="RBLREPTYPE" Name="RepTypeID" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:ControlParameter ControlID="RBLDETAILS" Name="RepDetails" 
                PropertyName="SelectedValue" Type="Int32" />
            <asp:QueryStringParameter Name="BudgetCategoryID" QueryStringField="BCID" 
                Type="Int32" />
            <asp:ControlParameter ControlID="HDNFrameID" Name="FCID" PropertyName="Value" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>
</asp:Content>

