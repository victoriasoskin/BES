<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="FrameRep.aspx.vb" Inherits="Default2" %>
<%@ Register TagPrefix="topyca" TagName="Ramzor" Src="~/Controls/Ramzor.ascx"  %>
<%@ Register TagPrefix="topyca" TagName="PageHeader" Src="~/Controls/PageHeader.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager runat="server" ID="scrp" />

    <style type="text/css">
     .p 
    {
        width:200px;
        padding-right:10px;
    }
    .pg
    {
        position:absolute; 
        background-color:#C0C0C0;
        width:800px;
        border-style:outset;
            top: 52px;
            right: 165px;
        }
    .blockHeader
    {
        font-size:medium;
        color:ButtonText;
        font-weight:bolder;
        height:25px;   
        padding-right:10px;     
    }
    .blockfooter
    {
        padding-right:10px;        
    }
    .tbw
    {
        background-color: #ececec;
        font-family: verdana;
        width:120px;
    }
    .divid
    {
        background-color: #ececec;
        font-family: verdana;
        width:104px;
    }
    .divemail
    {
        background-color: #ececec;
        font-family: verdana;
        width:126px;
    }
    .ddlw
    {
        background-color: #ececec;
        font-family: verdana;
        width:125px;
        border-style:groove;
    }
    .tdr
    {
        padding-right:10px;
        padding-top:5px;
    }
    .tbl
    {
        padding:10px;
        width:100%;
    }
    th
    {
        background-color:#AAAAAA;
        border-bottom:1px solid black;
    }
    .tbld td
    {
        padding-right:10px;
    }
    .tdid
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
        width:20px;
    }
    .tdq
    {
        border-left:1px outset #AAAAAA;
        border-bottom:1px outset #AAAAAA;
    }
    .tda
    {
        border-bottom:1px outset #AAAAAA;
        width:300px;
    }
    .shf
    {
        background-color: #eaeaea;
        font-family: verdana;
        border:2px inset;
        color:Gray;
        padding-right:2px;
        padding-left:2px;
     }
 </style>
<script src="jquery-1.7.1.js" type="text/javascript"></script>
<script  type="text/javascript">
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
<div runat="server" id="divform" class="pg">
<topyca:PageHeader runat="server" ID="PageHeader1" Header="דף ריכוז למסגרת" />
<script type="text/javascript">
        function DoPrint() {
            document.all("PRINT").style.visibility = "hidden";
            document.all("CLOSE").style.visibility = "hidden";
            window.print();
            document.all("PRINT").style.visibility = "visible";
            document.all("CLOSE").style.visibility = "visible";
        }
        function pshow() {
            document.all("PRINT").style.visibility = "visible";
            document.all("CLOSE").style.visibility = "visible";
        }
</script>
<div>
       <asp:SqlDataSource ID="DSServices" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            
			SelectCommand="Select ServiceName,ServiceID
				            From ServiceList s
				            Where ServiceID in (1,3,4,8,12,13,14) AND ServiceID in (Select distinct ServiceID 
                                                From FrameList where FrameID in (Select FrameID
                                                                                From dbo.p0v_UserFrameList
                                                                                Where UserID=@UserID))">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
            </SelectParameters>
        </asp:SqlDataSource>
       <asp:SqlDataSource ID="DSFrames" runat="server"
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
 			SelectCommand="SELECT FrameName, FrameID
				            FROM FrameList
				            Where FrameID in(Select FrameID From dbo.p0v_userFrameList Where UserID=@UserID) And ServiceID=@ServiceID">
            <SelectParameters>
                <asp:SessionParameter Name="UserID" SessionField="UserID" />
                <asp:ControlParameter ControlID="DDLServices" Name="ServiceID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
<table runat="server" id="tbl" class="tblcells">
    <tr runat="server" id="tr0">
           <td>
                <asp:Label runat="server" ID="LBLDate" Visible="false" />
                <asp:DropDownList ID="DDLServices" runat="server" AppendDataBoundItems="True" 
                    DataSourceID="DSServices" DataTextField="ServiceName" 
                    DataValueField="ServiceID" AutoPostBack="true" EnableTheming="True">
                    <asp:ListItem Value="">[כל האיזורים]</asp:ListItem>
                </asp:DropDownList>
            </td>
           <td>
            <asp:UpdatePanel runat="server" ID="updf" UpdateMode="Conditional">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="DDLServices" />
            </Triggers>
            <ContentTemplate>
                <asp:DropDownList ID="DDLFrames" runat="server" DataSourceID="DSFrames" AppendDataBoundItems="True"
                    DataTextField="FrameName" DataValueField="FrameID" 
                    EnableViewState="False" AutoPostBack="True">
                        <asp:ListItem Text="[כל המסגרות]" Value="" />
                </asp:DropDownList>
                <asp:HiddenField runat="server" ID="hdnServiceTypeID" />
             </ContentTemplate>
            </asp:UpdatePanel>
           </td>
           <td>
            <asp:DropDownList runat="server" ID="ddlWM" AutoPostBack="true" >
            </asp:DropDownList>
           </td>
           <td>
            <asp:Label runat="server" ID="lblRepc" Text="דוח סגור" Visible="false" />
           </td>
           <td>
                <asp:Button runat="server" ID="btnshow" Text="הצג" />
            </td>
            <td>
                <div runat="server" id="divupd" visible="false">
                    <asp:Button ID="btnMngRep" runat="server" Text="סגירת דוח לתאריך" /><br />
                    <asp:CheckBox ID="CBCorrect" runat="server" Text="אפשר שינוי תוצאות" AutoPostBack="true" /><br />
                    <asp:Button runat="server" ID="btnSave" Text="שמור שינויים" />
                </div>
           </td>
    </tr>
</table>
<hr />
<table runat="server" id="Table1" class="tblcells">


    <tr runat="server" id="tr1" >
        <td style="background-color:Silver; height: 20px;">שם המסגרת</td>
        <td  class="shf" style="width:300px;">
            <asp:Label runat="server" ID="lblFrame">&nbsp;</asp:Label>
        </td>
        <td  class="shf">
            <asp:Label runat="server" ID="lblService" Width="110px">&nbsp;</asp:Label>
        </td>
        <td rowspan="2" class="shf" style="text-align:center;width:70px;" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image1" OnPreRender="MainImg_PreRender" />
            <topyca:Ramzor runat="server" ID="Ramzor1" Visible="false" />
        </td>
    </tr>


   <tr runat="server" id="tr2" >
        <td style="background-color:Silver">מנהל</td>
        <td class="shf">
            <asp:Label runat="server" ID="lblMNGR">&nbsp;</asp:Label>
        </td>
        <td  class="shf">
            <asp:Label runat="server" ID="lblStartDate">&nbsp;</asp:Label>
        </td>
     </tr>
    <tr style="background-color:Silver; height: 5px;"><td colspan="4" /></tr>
   <tr runat="server" id="tr3">
        <td style="background-color:Silver">תוקף רישיון</td>
        <td  class="shf">
            <asp:Label runat="server" ID="lblLicesnce">&nbsp;</asp:Label>
        </td>
         <td  class="shf">&nbsp;</td>
        <td style="text-align:center;"  class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image3"  />
            <topyca:Ramzor runat="server" ID="Ramzor3" Visible="false" />
       </td>
    </tr>


   <tr runat="server" id="tr4">
        <td style="background-color:Silver">תוקף כיבוי אש</td>
        <td  class="shf">
            <asp:Label runat="server" ID="lblFireF">&nbsp;</asp:Label>
        </td>
        <td  class="shf">&nbsp;</td>
        <td style="text-align:center;" class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image4"  />
            <topyca:Ramzor runat="server" ID="Ramzor4" Visible="false" />
        </td>
    </tr>
 
 
   <tr runat="server" id="tr5">
        <td style="background-color:Silver">מועמדים</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblNewCandcnt">&nbsp;</asp:Label>
       </td>
        <td   class="shf">
              <asp:Label runat="server" ID="Label4">&nbsp;</asp:Label>
       </td>
         <td style="text-align:center;"   class="shf" >
            &nbsp;
       </td>
    </tr>


   <tr runat="server" id="tr7">
        <td style="background-color:Silver">יעד לקוחות נוכחי</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lbltarAct">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblCustPercnt">&nbsp;</asp:Label>
        </td>
        <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image2"  Visible="false" />
            <topyca:Ramzor runat="server" ID="Ramzor2" Visible="false" />
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image7"  />
            <topyca:Ramzor runat="server" ID="Ramzor7" Visible="false" />
        </td>
    </tr>


   <tr runat="server" id="tr8">
        <td style="background-color:Silver">לקוחות שהתקבלו</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblAccepted">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="Label8">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >&nbsp;</td>
     </tr>


    <tr runat="server" id="tr9">
        <td style="background-color:Silver">לקוחות שעזבו</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblLeft">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="Label10">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >&nbsp;</td>
     </tr>


   <tr runat="server" id="tr15" style="background-color:Yellow;">
        <td style="background-color:Silver">חודשים לא משולמים</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblnotPaid">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblNotPaidPER">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;" class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image15" CssClass="img"  />
             <topyca:Ramzor runat="server" ID="Ramzor15" Visible="false" />
        </td>
    </tr>
  <tr runat="server" id="tr10">
        <td style="background-color:Silver">ארועים חריגים</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblExEvent">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="Label9">&nbsp;</asp:Label>
        </td>
        <td style="text-align:center;"   class="shf" >&nbsp;</td>
     </tr>
   <tr runat="server" id="tr11">
        <td style="background-color:Silver">סולם עוצמת תמיכות</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblSISCNT">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblSISPER">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image11" />
              <topyca:Ramzor runat="server" ID="Ramzor11" Visible="false" />
       </td>
      </tr>
   <tr runat="server" id="tr12">
        <td style="background-color:Silver">איכות חיים</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblQCNT">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblQPER">&nbsp;</asp:Label>
        </td>
  
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image12"  />
             <topyca:Ramzor runat="server" ID="Ramzor12" Visible="false" />
       </td>
     </tr>
   <tr runat="server" id="tr13">
        <td style="background-color:Silver">איכות חיים לתלמיד</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblQPCNT">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblQPPER">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image13" />
             <topyca:Ramzor runat="server" ID="Ramzor13" Visible="false" />
       </td>
      </tr>
   <tr runat="server" id="tr14">
        <td style="background-color:Silver"><asp:Label runat="server" ID="lblHdrMPrep">תקציב כ"א</asp:Label>&nbsp;בשעות</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblMPCnt">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblMPPER">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image14"  />
            <topyca:Ramzor runat="server" ID="Ramzor14" Visible="false" />
        </td>
    </tr>
  <tr runat="server" id="tr16">
        <td style="background-color:Silver">תקציב הוצאות והשקעות</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblExp">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblExpPer">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;" class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image16" /><br />
              <topyca:Ramzor runat="server" ID="Ramzor16" Visible="false" />
        </td>
    </tr>
  <tr runat="server" id="tr17">
        <td style="background-color:Silver">תקציב הצטיידות</td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblHITZ">&nbsp;</asp:Label>
        </td>
        <td   class="shf">
            <asp:Label runat="server" ID="lblHITZPer">&nbsp;</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image17" />
            <topyca:Ramzor runat="server" ID="Ramzor17" Visible="false" />
          </td>
    </tr>
  <tr runat="server" id="tr18">
        <td style="background-color:Silver">פעילויות לקוחות</td>
        <td class="shf">
            <asp:Label runat="server" ID="lblPEIL">&nbsp</asp:Label>
        </td>
        <td class="shf">
            <asp:Label runat="server" ID="lblPEILPer">&nbsp</asp:Label>
        </td>
       <td style="text-align:center;"   class="shf" >
            <asp:Image runat="server" ImageUrl="~/images/Grey.jpg" ID="Image18" />
            <topyca:Ramzor runat="server" ID="Ramzor18" Visible="false" SelectedValue="3" />
         </td>
    </tr>
</table>
    <asp:Panel runat="server" ID="PANELPRINT" >
        <input id="PRINT" type="button" value="הדפסה" onclick="DoPrint()" visible="false" />
        <input id="CLOSE" type="button" value="חזרה" onclick="history.back()" visible="false" />
    </asp:Panel>
<asp:Button runat="server" ID="btnpreprint" Text="הכנה להדפסה" />
 </div>
 </div>
</asp:Content>

