<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustEventTypes.aspx.vb" Inherits="CustEventTypes" title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label2" runat="server" Font-Size="Large" Text="טבלת סוגי פעולות" Width="259px"></asp:Label></td>
            <td style="width: 100px">
            </td>
        </tr>
        <tr>
            <td style="width: 100px; height: 253px;" valign="top">
    <asp:GridView ID="GridView1" runat="server" AllowSorting="True"
        AutoGenerateColumns="False" DataKeyNames="CustEventTypeID" DataSourceID="DSEventType"
        EmptyDataText="There are no data records to display.">
        <Columns>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה" NewText="חדש" SelectText="בחירה" UpdateText="עדכון" >
                <ItemStyle Wrap="False" />
            </asp:CommandField>
            <asp:BoundField DataField="CustEventTypeID" HeaderText="מס'" ReadOnly="True" SortExpression="CustEventTypeID" />
            <asp:BoundField DataField="CustEventTypeName" HeaderText="פעולה" SortExpression="CustEventTypeName">
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="סוג טיפול" SortExpression="CustEventupdateType">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="DSUpdateType" DataTextField="CustEventupdateType"
                        DataValueField="CustEventUpdateTypeID" SelectedValue='<%# Bind("CustEventUpdateTypeID") %>'>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("CustEventupdateType") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="קבוצה" SortExpression="CustEventGroupName">
                <EditItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DSEVENTGROUPS" DataTextField="CustEventGroupName"
                        DataValueField="CustEventGroupID" SelectedValue='<%# Bind("CustEventGroupID") %>' AppendDataBoundItems="True" AutoPostBack="True">
                                    <asp:ListItem Text="&lt;כל השירותים&gt;"></asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("CustEventGroupName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Wrap="False" />
                <HeaderStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="ServiceName" HeaderText="שירות" ReadOnly="True"
                SortExpression="ServiceName" />
            <asp:BoundField DataField="CustEventURL" HeaderText="קישור" SortExpression="CustEventURL">
                <ItemStyle Wrap="False" Width="40px" />
                <HeaderStyle Wrap="False" />
                <ControlStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventDays" HeaderText="ימים לפעולה" SortExpression="CustEventDays">
                <HeaderStyle Wrap="False" />
                <ControlStyle Width="40px" />
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventmonths" HeaderText="חודשים לפעולה" SortExpression="CustEventmonths">
                <ControlStyle Width="40px" />
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventYears" HeaderText="שנים לפעולה" SortExpression="CustEventYears">
                <ControlStyle Width="40px" />
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustCount" HeaderText="ספירה" SortExpression="CustCount">
                <ControlStyle Width="40px" />
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventOrder" HeaderText="סדר" SortExpression="CustEventOrder">
                <ControlStyle Width="40px" />
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:BoundField DataField="CustEventTypeComment" HeaderText="הערה" 
                SortExpression="CustEventTypeComment" />
            <asp:CheckBoxField DataField="CustEventTypeMust" HeaderText="חובה?" 
                SortExpression="CustEventTypeMust" />
            <asp:TemplateField HeaderText="סוג תשובה">
                <EditItemTemplate>
                    <asp:DropDownList ID="DDLANSWERTYPE" runat="server" AppendDataBoundItems="True" 
                        DataSourceID="DSANSWERTYPE" DataTextField="AnswerType" 
                        DataValueField="AnswerTypeID" SelectedValue='<%# Bind("CustEventAnswerID") %>'>
                        <asp:ListItem Value="">&lt;לא מוגדר&gt;</asp:ListItem>
                    </asp:DropDownList>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("Answertype") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CheckBoxField DataField="CandReport" HeaderText="דוח מועמדים?" />
        </Columns>
    </asp:GridView>
            </td>
            <td style="width: 100px; height: 253px;" valign="top">
                <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="CustEventTypeID"
                    DataSourceID="DSEventType" DefaultMode="Insert" 
                    HeaderText="הוספת סוג פעולה" Height="48px"
                    Width="125px">
                    <RowStyle Wrap="False" />
                    <Fields>
                        <asp:BoundField DataField="CustEventTypeID" HeaderText="CustEventTypeID" InsertVisible="False"
                            ReadOnly="True" SortExpression="CustEventTypeID" Visible="False" />
                        <asp:BoundField DataField="CustEventTypeName" HeaderText="פעולה" SortExpression="CustEventTypeName">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="סוג טיפול">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="DSUpdateType" DataTextField="CustEventupdateType"
                                    DataValueField="CustEventUpdateTypeID" SelectedValue='<%# Bind("CustEventUpdateTypeID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="קבוצה" SortExpression="CustEventgroupName">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventGroupID") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" AppendDataBoundItems="True" DataSourceID="DSEVENTGROUPS"
                                    DataTextField="CustEventGroupName" DataValueField="CustEventGroupID" SelectedValue='<%# Bind("CustEventGroupID") %>' AutoPostBack="True">
                                </asp:DropDownList>
                            </InsertItemTemplate>
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# eval("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="שירות" SortExpression="ServiceName">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("ServiceName") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# eval("ServiceName") %>'></asp:Label>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventURL" HeaderText="קישור" SortExpression="CustEventURL">
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="ימים לפעולה" SortExpression="CustEventTypeID">
                            <EditItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("CustEventTypeID") %>'></asp:Label>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("CustEventDays") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <HeaderStyle Wrap="False" />
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("CustEventTypeID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CustEventmonths" HeaderText="חודשים לפעולה" SortExpression="CustEventmonths" />
                        <asp:BoundField DataField="CustEventYears" HeaderText="שנים לפעולה" SortExpression="CustEventYears" />
                        <asp:BoundField DataField="CustCount" HeaderText="ספירה" SortExpression="CustCount" />
                        <asp:BoundField DataField="CustEventOrder" HeaderText="סדר" SortExpression="CustEventOrder" />
                        <asp:BoundField DataField="CustEventTypeComment" HeaderText="הערה" 
                            SortExpression="CustEventTypeComment" />
                        <asp:CheckBoxField DataField="CustEventTypeMust" HeaderText="חובה?" 
                            SortExpression="CustEventTypeMust" />
                        <asp:TemplateField HeaderText="סוג תשובה">
                            <InsertItemTemplate>
                                <asp:DropDownList ID="DDLANSWWERTYPE" runat="server" 
                                    DataSourceID="DSANSWERTYPE" DataTextField="AnswerType" 
                                    DataValueField="AnswerTypeID" SelectedValue='<%# Bind("CustEventAnswerID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField CancelText="ביטול" DeleteText="מחיקה" EditText="עריכה" InsertText="הוספה"
                            NewText="חדש" SelectText="בחירה" ShowInsertButton="True" UpdateText="עדכון" />
                        <asp:CheckBoxField DataField="CandReport" HeaderText="דוח מועמדים?" 
                            SortExpression="CandReport" />
                    </Fields>
                </asp:DetailsView>
            </td>
        </tr>
    </table>
<asp:SqlDataSource ID="DSANSWERTYPE" runat="server" 
    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
    
        SelectCommand="SELECT [AnswerTypeID], [AnswerPositive] + '\' +  [AnswerNegative] As AnswerType FROM [AnswerTypes]">
</asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEventType" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [CustEventTypes] WHERE [CustEventTypeID] = @CustEventTypeID"
        InsertCommand="INSERT INTO CustEventTypes(CustEventTypeName, CustEventGroupID, CustEventURL, CustEventUpdateTypeID, CustEventDays, CustEventmonths, CustEventYears, CustCount, CustEventOrder,CustEventTypeComment, CustEventAnswerID, CustEventTypeMust,CandReport) VALUES (@CustEventTypeName, @CustEventgroupID, @CustEventURL, @CustEventupdateTypeID, @CustEventDays, @CustEventMonths, @CustEventYears, @CustCount, @CustEventOrder,@CustEventTypeComment, @CustEventAnswerID, @CustEventTypeMust,@CandReport)"
        ProviderName="<%$ ConnectionStrings:BEBook10.ProviderName %>"
        SelectCommand="SELECT CustEventTypes.CustEventTypeID, CustEventTypes.CustEventTypeName, CustEventTypes.CustEventURL, ServiceList.ServiceName, CustEventTypes.CustEventGroupID, CustEventGroups.CustEventGroupName, CustEventTypes.CustEventDays, CustEventTypes.CustEventUpdateTypeID, CustEventUpdateType.CustEventupdateType, CustEventTypes.CustEventmonths, CustEventTypes.CustEventYears, CustEventTypes.CustCount, CustEventTypes.CustEventOrder, CustEventTypes.CustEventTypeComment, CustEventTypes.CustEventAnswerID, CustEventTypes.CustEventTypeMust, AnswerTypes.AnswerPositive + '/' + AnswerTypes.AnswerNegative AS Answertype, CustEventTypes.CandReport FROM AnswerTypes RIGHT OUTER JOIN CustEventTypes ON AnswerTypes.AnswerTypeID = CustEventTypes.CustEventAnswerID LEFT OUTER JOIN CustEventUpdateType ON CustEventTypes.CustEventUpdateTypeID = CustEventUpdateType.CustEventUpdateTypeID LEFT OUTER JOIN ServiceList RIGHT OUTER JOIN CustEventGroups ON ServiceList.ServiceID = CustEventGroups.CustEventServiceID ON CustEventTypes.CustEventGroupID = CustEventGroups.CustEventGroupID"
        
        
        
        UpdateCommand="UPDATE CustEventTypes SET CustEventTypeName = @CustEventTypeName, CustEventGroupID = @CustEventGroupID, CustEventURL = @CustEventURL, CustEventUpdateTypeID = @CustEventupdateTypeID, CustEventDays = @CustEventDays, CustEventmonths = @CustEventMonths, CustEventYears = @CustEventYears, CustCount = @CustCount, CustEventOrder = @CustEventOrder, CustEventTypeComment=@CustEventTypeComment, CustEventAnswerID=@CustEventAnswerID,CandReport=@CandReport, CustEventTypeMust=@CustEventTypeMust WHERE (CustEventTypeID = @CustEventTypeID)">
        <DeleteParameters>
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustEventTypeName" Type="String" />
            <asp:Parameter Name="CustEventGroupID" Type="Int32" />
            <asp:Parameter Name="CustEventURL" Type="String" />
            <asp:Parameter Name="CustEventupdateTypeID" />
            <asp:Parameter Name="CustEventDays" />
            <asp:Parameter Name="CustEventMonths" />
            <asp:Parameter Name="CustEventYears" />
            <asp:Parameter Name="CustCount" />
            <asp:Parameter Name="CustEventOrder" />
            <asp:Parameter Name="CustEventTypeComment" />
            <asp:Parameter Name="CustEventAnswerID" />
            <asp:Parameter Name="CandReport" />
            <asp:Parameter Name="CustEventTypeMust" />
            <asp:Parameter Name="CustEventTypeID" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustEventTypeName" />
            <asp:Parameter Name="CustEventgroupID" />
            <asp:Parameter Name="CustEventURL" Type="String" />
            <asp:Parameter Name="CustEventupdateTypeID" />
            <asp:Parameter Name="CustEventDays" />
            <asp:Parameter Name="CustEventMonths" />
            <asp:Parameter Name="CustEventYears" />
            <asp:Parameter Name="CustCount" />
            <asp:Parameter Name="CustEventOrder" />
            <asp:Parameter Name="CustEventTypeComment" />
            <asp:Parameter Name="CustEventAnswerID" />
            <asp:Parameter Name="CustEventTypeMust" />
            <asp:Parameter Name="CandReport" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSEVENTGROUPS" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustEventGroupName], [CustEventGroupID] FROM [CustEventGroups]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSUpdateType" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustEventupdateType], [CustEventUpdateTypeID] FROM [CustEventUpdateType]">
    </asp:SqlDataSource>
</asp:Content>

