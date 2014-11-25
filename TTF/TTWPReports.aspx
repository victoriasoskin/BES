<%@ Page Title="" Language="C#" MasterPageFile="~/TTFSite.Master" AutoEventWireup="true" CodeBehind="TTWPReports.aspx.cs" Inherits="TTF.TTWPReports"  EnableEventValidation="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            width: 82px;
        }
        .auto-style2 {
            width: 14px;
        }
        .auto-style4 {
            height: 30px;
        }
    </style>
    <link href="design.css" rel="design" type="text/css" /> 
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link href="design.css" rel="design" type="text/css" />
    <div style="width:800px;height:50px;background-color:lightgray; text-align :center " >
    <h1> דוחות מערכת חינוך</h1>
<div style="position:fixed;top:30px;right:30px;"><asp:Button runat="server" ID="btnback" PostBackUrl="~/default.Aspx" CausesValidation="false" Text="חזרה לתפריט ראשי" /></div>
</div>
    <div style="background-color:lightgray ; width:800px ;">
    
    <table id="TableReports" >
        <tr>
            <td class="col" >
                <asp:Label ID="LBLMainLvlRep" runat="server" Text="בחר דוח :"></asp:Label>
            </td>
            <td class="col" >
               
                 <asp:DropDownList ID="DDLMainLvlRep" runat="server"  AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSMainLevelReportsEducation" DataTextField="name" DataValueField="id" OnSelectedIndexChanged="DDLMainLvlRep_SelectedIndexChanged">
                 <asp:ListItem Value="" >בחר דוח:</asp:ListItem>
                 </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Font-Bold="true" ForeColor="Red" ControlToValidate ="DDLMainLvlRep" runat="server" ErrorMessage="* שדה חובה "></asp:RequiredFieldValidator>
          
                    </td>
            <td class="col" >
                <asp:Label ID="LBLSecLvlRep" runat="server" Text="בחר דוח משנה  :">

                </asp:Label></td>
          
            <td class="col"  > 
                <asp:DropDownList ID="DDLSecLvlRep" runat="server" AutoPostBack="True" DataSourceID="DSSecLevelReportsEducation" DataTextField="Name" DataValueField="Id" OnSelectedIndexChanged="DDLSecLvlRep_SelectedIndexChanged" AppendDataBoundItems="True" EnableViewState="False">
                <asp:ListItem Value="" >בחר דוח:</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Font-Bold="true"  ForeColor="Red" ControlToValidate ="DDLSecLvlRep" runat="server" ErrorMessage="* שדה חובה "></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
          
        <br />
    <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal" >
        <asp:ListItem Text="כמותי" Value="0"  />
        <asp:ListItem Text="שמי" Value="1" />
        <asp:ListItem Text="פרטני" Value="2" />
       
    </asp:RadioButtonList>     
    <asp:RequiredFieldValidator runat="server" ErrorMessage="חובה לבחור סוג דוח" Font-Bold="true"  ControlToValidate ="RadioButtonList1" ForeColor ="Red"></asp:RequiredFieldValidator>

    <br />
        
    <table >
       
        <tr>
            <td><asp:Label ID="LBLCustID" runat="server" Text="ת.ז. :"  Visible="false" Width="100px" ></asp:Label></td>
            <td>
                <asp:TextBox ID="TBXClientId" runat="server" Width="90px"  Visible="false"></asp:TextBox>
            </td>
            <td><asp:Label ID="LBLCustLastName" runat="server" Text="שם משפחה :"  Visible="false"></asp:Label></td>
            <td>
                <asp:TextBox ID="TXBClientLastName" runat="server" Width="90px"  Visible="false"></asp:TextBox>
            </td>
            <td><asp:Label ID="LBLCustFirstName" runat="server" Text="שם פרטי:" Visible="false"></asp:Label></td>
            <td>
                <asp:TextBox ID="TXBClientFirstName" runat="server" Width="90px"  Visible="false"> </asp:TextBox>
            </td>
  
        </tr>
        <tr>
            <td><asp:Label ID="LBLRegions" runat="server" Text="בחר איזור:" Visible="false"></asp:Label></td>
           
            <td>
                <asp:DropDownList ID="DDLRegions" Visible="false" runat="server" AutoPostBack="True" DataSourceID="DSRegions" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True" EnableViewState="False">
                    <asp:ListItem Value="" >בחר איזור :</asp:ListItem>
                </asp:DropDownList>
            </td>

            <td class="auto-style1"><asp:Label ID="LBLFrames" runat="server" Text="בחר מסגרת:" Visible="false"></asp:Label></td>
            <td>
                <asp:DropDownList ID="DDLFrames" runat="server" AutoPostBack="True" Visible="false" DataSourceID="DSFrames" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True" EnableViewState="False">
                    <asp:ListItem Value="" >בחר מסגרת :</asp:ListItem>
                </asp:DropDownList>
            </td>
            </tr>
        <tr>
            <td><asp:Label ID="LBLClass" runat="server" Text="בחר שכבה:" Visible="false"></asp:Label></td>
            <td>
                <asp:DropDownList ID="DDLClass" runat="server" AutoPostBack="True" DataSourceID="DSClassLevel" Visible="false" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True" EnableViewState="False">
                    <asp:ListItem Value="" >בחר שכבה :</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
               <asp:Label ID="LBLClassNumber" runat="server" Text="בחר כיתה:" Visible="false"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="DDLClassNumber" runat="server" DataSourceID="DSClassNumber" Visible="false" DataTextField="Name" DataValueField="Id" AppendDataBoundItems="True" EnableViewState="False">
                    <asp:ListItem Value="" >בחר כיתה:</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LBLRange" runat="server" Text="בחר תחום:" Visible="false"></asp:Label> </td>
            <td>
            <asp:DropDownList ID="DDLRange" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSRanges" DataTextField="Name" DataValueField="Id" EnableViewState="False" Visible="false">
                <asp:ListItem Value="" >בחר תחום:</asp:ListItem>
            </asp:DropDownList>
            </td>
            <td>   <asp:Label ID="LBLSubject" runat="server" Text="בחר נושא:" Visible="false"></asp:Label> </td>
            <td>
                <asp:DropDownList ID="DDLSubject" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="DSSubjects" DataTextField="Name" DataValueField="Id" EnableViewState="False" Visible="false">
                    <asp:ListItem Value="" >בחר נושא :</asp:ListItem>
                </asp:DropDownList>
            </td>
         </tr>
         <tr>
            <td>
                 <asp:Label ID="LBLQuestions" runat="server" Text="בחר שאלה:" Visible="false"></asp:Label> 
            </td>
            <td>
                <asp:DropDownList ID="DDLQuestions" runat="server" AppendDataBoundItems="True" Visible="False" DataSourceID="DSQuestions" DataTextField="Question" DataValueField="questionId" style="margin-bottom: 0px">
                    <asp:ListItem Value="" >בחר שאלה:</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><asp:Label ID="LBLFromDate" runat="server" Text="מתאריך:" Visible="false"></asp:Label></td>
            <td style="width:100px">
               <asp:TextBox ID="FromDateTXB" runat="server" Width="70px" Visible="false" ></asp:TextBox>
                <asp:Button ID="FROMDateBTN" runat="server" Text="..." Width="20px" Height="20px" OnClick="FROMDateBTN_Click"  Visible="false" />
                <asp:Calendar ID="Calendar2" runat="server" Visible="False" BackColor="White" BorderColor="#3366CC" OnSelectionChanged="Calendar2_SelectionChanged" BorderWidth="1px" CellPadding="0" DayNameFormat="Shortest" EnableViewState="False" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="150px" Width="150px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#3366FF" />
                </asp:Calendar>
            </td>
            <td><asp:Label ID="LBLToDate" runat="server" Text="עד תאריך:" Visible="false"></asp:Label></td>
            <td style ="width:100px">
                <asp:TextBox ID="ToDateTXB" runat="server"  Width="70px" Visible="false"></asp:TextBox>
                <asp:Button ID="ToDateBTN" runat="server" Text="..." Width="20px" Height="20px"  Visible="false" OnClick="ToDateBTN_Click" />
                <asp:Calendar ID="Calendar1" runat="server" Visible="False" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" OnSelectionChanged="Calendar1_SelectionChanged" CellPadding="0" DayNameFormat="Shortest" EnableViewState="False" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" Height="150px" Width="150px">
                    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                    <OtherMonthDayStyle ForeColor="#999999" />
                    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                    <WeekendDayStyle BackColor="#0066FF" />
                </asp:Calendar>
            </td>
        </tr>
        
    </table>
    
    
    <br />
        <div style="width:100% ;text-align:right">
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="בצע" Visible="false" />
            </div>
    <br />
    <br />
        </div>
<div runat="server" id ="UCBtn" visible="false">
<table>
    <tr>
        <td>
            <asp:ImageButton ID="ToExcelBtn" runat="server" Height="30px " Width =" 30px" ImageUrl="~/Pictures/ExcellImg.bmp" OnClick="ToExcelBtn_Click"/>
        </td>
        <td>
            <asp:ImageButton ID="ToWordBtn" runat="server" Height="30px " Width =" 30px" ImageUrl="~/Pictures/word.jpg" OnClick="ToWordBtn_Click"/>
        </td>
         <td>
            <asp:ImageButton ID="BTNTableToChart" runat="server" Height="30px " Width =" 30px" OnClick="BTNTableToChart_Click" ImageUrl="~/Pictures/images.jpg" />
        </td>
        <td class="auto-style2">
            <asp:ImageButton ID="PrintBtn" runat="server" Height="30px " Width =" 30px" ImageUrl="~/Pictures/PrintImg.png" />
        </td>
       
    </tr>
</table>

    <h2><asp:Label ID="ReportLBL" runat="server" Text="Label"></asp:Label></h2>
    <h3><asp:Label ID="SubReportLBL" runat="server" Text="Label"></asp:Label></h3>

  </div>
  <div  style="overflow-x:auto;width:800px;overflow-y:auto"> 
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" OnPreRender="GridView1_PreRender"  ForeColor="#333333"  Visible="true"  OnPageIndexChanging="GridView1_PageIndexChanging" >
            <AlternatingRowStyle BackColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
       
   </div> 
    

        <asp:Chart ID="Chart1" runat="server" Visible ="False" DataSourceID="SqlDataSource1" BorderlineColor="Blue" width="650px" OnPrePaint="Chart1_PrePaint" OnLoad="Chart1_Load" OnClick="ChartDrill" >
            <Series>
                <asp:Series Name="Series1" ChartType ="Column" XValueMember= "Range" YValueMembers="CountCustomersInRanges" PostBackValue =" #VALX" >

                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
   
    <asp:ImageButton ID="goBackBtn" runat="server"  ImageUrl="~/Pictures/goBackBtn.png" Width=" 50px" Height="50px" Visible="false" OnClick="goBackBtn_Click"/>
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>"  CancelSelectOnNullParameter="False" OnSelecting="SqlDataSource1_Selecting" ></asp:SqlDataSource>
   
    <br />

    <asp:SqlDataSource ID="DSMainLevelReportsEducation" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select c.id, c.name from B10Sec.[dbo].TT_Classes c where parent = 322 order by c.val"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSecLevelReportsEducation" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select * from B10Sec.dbo.TT0_Classes(@IdRep)" >
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLMainLvlRep" Name="IdRep" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSRegions" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM Book10_21.dbo.tf_Frames (@UserId,NULL,NULL,NULL,1)">
        <SelectParameters>
            <asp:SessionParameter Name="UserId" SessionField="UserId" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFrames" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM Book10_21.dbo.tf_Frames (@UserID,@Parent,NULL,NULL,2)">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserId" />
            <asp:ControlParameter ControlID="DDLRegions" Name="Parent" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSResults" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="SELECT * FROM [AA_ASPDOTNETKnowLedgeBase]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSClassLevel" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select Id, Name from B10Sec.dbo.TT_Classes where Parent = 278"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSClassNumber" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select  Id, Name from B10Sec.dbo.TT_Classes where  Parent = 291"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSRanges" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select Id,Name from B10Sec.dbo.TT_Classes where parent = 199"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSSubjects" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select * from B10Sec.dbo.SubjectsByRanges(@Range)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLRange" Name="Range" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSQuestions" runat="server" ConnectionString="<%$ ConnectionStrings:Book10PE %>" SelectCommand="select * from book10_21.dbo.Select_Questions_by_Subject(@Subject)" OnSelecting="DSQuestions_Selecting">
        <SelectParameters>
            <asp:ControlParameter ControlID="DDLRange" Name="Subject" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
