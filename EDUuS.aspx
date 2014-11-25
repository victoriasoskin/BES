<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="EDUuS.aspx.vb" Inherits="EDU_S" title="בית אקשטיין - ניהול מועמדים" MaintainScrollPositionOnPostback="true" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
  <div runat="server" id="divmsg" visible="false">
        <asp:Label runat="server" ID="lblmsg" Height="55" style="text-align:right;"></asp:Label><br /><br />
        <asp:Button runat="server" ID="btnmsg" Text="אישור" CausesValidation="false" />
    </div>
  <div id="divform" runat="server">      
        <table>
        <tr>
            <td style="width: 280px">
                 <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="רשימת הפניות/מועמדים" Width="551px"></asp:Label></td>
            <td style="width: 100px">
                <asp:Label ID="LBLDATE" runat="server" Text="Label" Width="97px"></asp:Label></td>
        </tr> 
        <tr>
            <td>
                <asp:Label ID="LBLFRAMENAME"  runat="server" Text="Label" Width="165px"></asp:Label><asp:DropDownList ID="DDLFRAMES" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                    DataSourceID="DSFRAMES" DataTextField="FrameName" DataValueField="FrameID" Visible="false">
                    <asp:ListItem Value="" Selected="True">&lt;בחר מסגרת&gt;</asp:ListItem>
                </asp:DropDownList>
                <asp:DropDownList ID="DDLGROUPID" runat="server" AutoPostBack="True" 
                    DataSourceID="DSGROUPTYPE" DataTextField="CustEventGroupName" 
                    DataValueField="CustEventGroupID" AppendDataBoundItems="True">
                    <asp:ListItem Value="">&lt;בחר מיון&gt;</asp:ListItem>
                  
                </asp:DropDownList>
                <asp:LinkButton ID="LNKBADDCAND" runat="server" 
                    PostBackUrl="~/CustomerAdd2.aspx?CAND=1" Visible="false"
                    ToolTip="לחץ כאן להוספת מועמד שאינו מופיע ברשימה">מועמד חדש</asp:LinkButton>
                <asp:SqlDataSource ID="DSGROUPTYPE" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    
                    
                    
                    SelectCommand="SELECT CustEventGroupName, CustEventGroupID FROM CustEventGroups WHERE (CustEventGroupSort = 1) or(CustEventGroupSort = 1) AND (@MF = 1)">
                    <SelectParameters>
                        <asp:SessionParameter Name="MF" SessionField="MultiFrame" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td colspan="2" >
                <asp:Panel ID="Panel1" runat="server" BorderColor="#3333CC" 
                    BorderStyle="Dotted" BorderWidth="1px" Font-Size="X-Small" Height="140px" 
                    Visible="false">
                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Small" 
                        Font-Underline="True" ForeColor="#0033CC" Text="הוראות הפעלה"></asp:Label>
                    <br />
                    1. בחר במועמד מרשימת המועמדים.<br />
                    2. לפניך&nbsp; מצב המועמדות שלו.<br />
					3.&nbsp; <span style="color: #FF0000"><b>חובה לסמן&nbsp; פעולות המסומנות ב * בעמודת 
                    &quot;חובה&quot; כדי שהמועמד יופיע בדוח מועמדים</b></span><br />
					3. לדיווח
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; א. בחר בתאריך (ברירת מחדל - היום) ניתן לשנות&nbsp; את התאריך בהקלדה&nbsp; בתיבה או 
                    שינוי בתאריכון (נפתח באמצעות הכפתור ליד התאריך)&nbsp;
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ב. הקלד הערה בעמודת הערה (אם יש)<br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ג. לחץ על&nbsp; הכפתור בשורה בעמודה שכותרתה &quot;בוצע&quot;&nbsp; (כן / יש / התקיים.)<br />
                    4. לביטול סימון: בשורה שבוצעה לחץ על הכפתור בעמודה &quot;לא בוצע&quot;&nbsp; (לא / אין / לא 
					התקיים)
					<br />
					5. לחץ על מחק אם ברצונך לבטל את הדיווח.<br />
                </asp:Panel>
                                <asp:Button ID="btnhlp" runat="server" Text="הצג הוראות הפעלה" />
                <asp:CheckBox ID="CBALLCAND" runat="server" AutoPostBack="True" 
                    Text="הצג גם מועמדים שנדחו (מסומנים ב *)" />
                <asp:CheckBox ID="CBCORRECT" runat="server" Text="הצג את כל הלקוחות (כדי להציג/לתקן נתוני המועמדות)" AutoPostBack="true" />
            </td>
        </tr>
        <tr>
            <td valign="top" colspan="2">
                <table>
                    <tr>
                        <td valign="top">
                <asp:ListBox ID="LSBCUST" runat="server" AutoPostBack="True" DataSourceID="DSCustomers"
                    DataTextField="CustomerName" DataValueField="CustomerID" Height="198px" Width="180px">
                </asp:ListBox></td>
                        <td valign="top">
                            <span style="font-size: 2px"></span>
                            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="DSSELECTEDCUST"
                                Height="198px" Width="480px" BackColor="#003399">
                                <Fields>
                                    <asp:BoundField DataField="ת.ז." HeaderText="ת.ז." SortExpression="ת.ז.">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="שם" HeaderText="שם" ReadOnly="True" SortExpression="שם">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="תאריך לידה" DataFormatString="{0:dd/MM/yy}" HeaderText="תאריך לידה"
                                        SortExpression="תאריך לידה">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="מין" HeaderText="מין" ReadOnly="True" SortExpression="מין">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="כתובת" HeaderText="כתובת" SortExpression="כתובת">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="כתובת1" SortExpression="כתובת1">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="עיר" HeaderText="עיר" SortExpression="עיר">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="טלפון" HeaderText="טלפון" SortExpression="טלפון">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Fields>
                                <HeaderStyle Width="30%" />
                            </asp:DetailsView>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="2" valign="top">
<%--             <asp:UpdatePanel runat="server" ID="updt" UpdateMode="Always"><ContentTemplate>
--%>                <asp:Label runat="server" ID="lblerr" Text="יש פעולות חובה שלא סומנו" Font-Bold="true" ForeColor="Red" Font-Size="Larger" Visible="false" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    DataSourceID="DSEVENTTypes" CellPadding="2" 
                     DataKeyNames="CustEventID,CCEID">
                    <Columns>
                        <asp:TemplateField HeaderText="הפעולה" SortExpression="CustEventTypeName">
                            <ItemTemplate>
                                <asp:Label ID="LBLEVENTTYPE" runat="server" Text='<%# Eval("CustEventTypeName") %>' 
                                    ToolTip='<%# Eval("CustEventTypeComment") %>' 
                                    ForeColor='<%# dpr("CustEventDate") %>' onprerender="LBLEVENTTYPE_PreRender"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="חובה">
                            <ItemTemplate>
                            <asp:Label ID="CBMUST" runat="server" forecolor="Red"
                                    Text='<%# if(eval("custeventtypemust"),"*","") %>' Font-Bold="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מה דווח?" SortExpression="CustEventResult">
                            <ItemTemplate>
                                <asp:Label ID="LBLRESULT" runat="server" Text='<%# eval("CustEventResult") %>'  ForeColor='<%# dpr("CustEventDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="בתאריך" SortExpression="CustEventDate">
                             <ItemTemplate>
                                <asp:Label ID="TBDATE" runat="server"  Text='<%# Eval("CustEventDate", "{0:dd/MM/yy}") %>'
                                    Width="57px" />
                            </ItemTemplate>
                            <ItemStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="הערה" SortExpression="CustEventComment">
                           <ItemTemplate>
                                <asp:Label ID="TextBox3" runat="server" Width="349px" Text='<%# Eval("CustEventComment") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
<%--               </ContentTemplate></asp:UpdatePanel>
--%>                 
              </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSSELECTEDCUST" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT CustomerID AS [ת.ז.], CustLastName + N' ' + CustFirstName AS שם, CustBirthDate AS [תאריך לידה], Gender AS מין, CustomerAddress1 AS כתובת, CustomerAddress2 AS כתובת, CustomerCity AS עיר, CustomerPhone AS טלפון FROM vCustomerList WHERE (CustomerID = @CustomerID)">
        <SelectParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" PropertyName="SelectedValue"
                Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSCustomers" runat="server" 
		ConnectionString="<%$ ConnectionStrings:bebook10 %>" CancelSelectOnNullParameter="False"
            SelectCommand="CANDTable" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
            <asp:ControlParameter ControlID="CBALLCAND" Name="RejectedToo" 
                PropertyName="Checked" Type="Boolean" />
            <asp:ControlParameter ControlID="CBCORRECT" Name="ALLCust" 
                PropertyName="Checked" Type="Boolean" />
            <asp:ControlParameter ControlID="DDLFRAMES" Name="SFrameID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAMES" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
		SelectCommand="pFrameList" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter Name="UserID" SessionField="UserID" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNEVENTGROUPID" runat="server" Value="2" />
    <asp:SqlDataSource ID="DSEVENTTypes" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        
        SelectCommand="pCandList" 
        DeleteCommand="DELETE FROM CustEventList WHERE (CustEventID = @CCEID)" 
        UpdateCommand="Cust_UPDEvent" UpdateCommandType="StoredProcedure" 
            SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" PropertyName="SelectedValue" Type="Int64" />
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
            <asp:ControlParameter ControlID="DDLGROUPID" Name="EventGroupID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="CCEID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:ControlParameter ControlID="LSBCUST" Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
            <asp:controlParameter ControlID="LBLDATE" Name="CustEventRegDate" Type="DateTime" />
            <asp:Parameter Name="CustEventDate" type="DateTime"/>
            <asp:Parameter Name="CustEventComment" Type="String" />
            <asp:SessionParameter SessionField="FrameID" Name="CustFrameID" Type="Int32" />
            <asp:ControlParameter ControlID="HDNMANAGER" Name="CFramemanager" Type="String" />
            <asp:sessionParameter SessionField="UserID" Name="userID" Type="Int32" />
            <asp:Parameter Name="CustEventUpdateTypeID" Type="Int32" />
            <asp:Parameter Name="CustEventID" />
       	 <asp:Parameter Name="CustEventResult" Type="Int32" />
			<asp:Parameter Name="CustRelateID" Type="Int32" />
            <asp:Parameter Name="CCEID"  />
       </UpdateParameters>
    </asp:SqlDataSource>
    <asp:HiddenField ID="HDNSERVICEID" runat="server" Value="3" />
    <asp:HiddenField ID="HDNMANAGER" runat="server" /> 

        <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</div>     
</asp:Content>

