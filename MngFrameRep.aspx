<%@ Page Title="נהול דף למסגרת" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="MngFrameRep.aspx.vb" Inherits="MngFrameRep" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="hdrdiv">ניהול דף למסגרת</div>
<div class="reldiv">
<div>
    <asp:SqlDataSource ID="DSSERVICETYPES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [ServiceType], [ServiceTypeID] FROM [p5t_ServiceType]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="DSFRAMES" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        
        SelectCommand="SELECT [FrameName], [FrameID] FROM [FrameList] WHERE ([ServiceTypeID] = isnull(@ServiceTypeID,ServiceTypeID))" 
        CancelSelectOnNullParameter="False">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlServiceTypes" Name="ServiceTypeID" 
                PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
    <table> 
        <tr>
            <td>
                <asp:DropDownList ID="ddlServiceTypes" runat="server" DataSourceID="DSSERVICETYPES" 
                        DataTextField="ServiceType" DataValueField="ServiceTypeID" 
                        AutoPostBack="True" AppendDataBoundItems="True">
                    <asp:ListItem Value="">[כל סוגי השירות]</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="ddlframes" runat="server" style="margin-bottom: 0px" 
                        DataSourceID="DSFRAMES" DataTextField="FrameName" 
                    DataValueField="FrameID" AppendDataBoundItems="True" 
                    EnableViewState="False">
                    <asp:ListItem Value="">[כל המסגרות]</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <asp:Button ID="btnshow" runat="server" Text="הצג" />
            </td>
        </tr>
    </table>
    </div>
    <div>
    
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="DSFRAMEREP" EnableModelValidation="True" 
            DataKeyNames="RowNumber">
            <Columns>
                <asp:CommandField CancelText="ביטול" EditText="עריכה" ShowEditButton="True" 
                    UpdateText="עדכון" />
                <asp:BoundField DataField="RowNumber" HeaderText="שורה" 
                    SortExpression="RowNumber" />
                <asp:BoundField DataField="Description" HeaderText="תאור" ReadOnly="true"
                    SortExpression="Description" />
                <asp:CheckBoxField DataField="DontShow" HeaderText="לא להציג"
                    SortExpression="DontShow" />
                <asp:BoundField DataField="R1" HeaderText="אדום נמוך" 
                    SortExpression="R1" />
                <asp:BoundField DataField="R2Y1" HeaderText="אדום גבוה צהוב נמוך" 
                    SortExpression="R2Y1" />
                <asp:BoundField DataField="Y2G1" HeaderText="צהוב גבוה ירוק נמוך" 
                    SortExpression="Y2G1" />
                <asp:BoundField DataField="G2" HeaderText="ירוק גבוה"  
                    SortExpression="G2" />
                <asp:BoundField DataField="Weight" HeaderText="משקל" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="DSFRAMEREP" runat="server" 
            CancelSelectOnNullParameter="False" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
            SelectCommand="SELECT DISTINCT COALESCE (f3.ServiceTypeID, f2.ServiceTypeID) AS ServiceTypeID, COALESCE (f3.ServiceID, f2.ServiceID) AS ServiceID, f3.FrameID, f1.RowNumber, f1.Description, COALESCE (f3.DontShow, f2.DontShow, f1.DontShow) AS DontShow, COALESCE (f3.R1, f2.R1, f1.R1) AS R1, COALESCE (f3.R2Y1, f2.R2Y1, f1.R2Y1) AS R2Y1, COALESCE (f3.Y2G1, f2.Y2G1, f1.Y2G1) AS Y2G1, COALESCE (f3.G2, f2.G2, f1.G2) AS G2, COALESCE (f3.Weight, f2.Weight, f1.Weight) AS Weight, f1.Ord FROM (SELECT ID, RowNumber, Description, FrameID, ServiceTypeID, ServiceID, DontShow, R1, R2Y1, Y2G1, G2, Weight, Ord FROM p0t_FrameRep WHERE (ServiceTypeID IS NULL) AND (FrameID IS NULL)) AS f1 LEFT OUTER JOIN (SELECT ID, RowNumber, Description, FrameID, ServiceTypeID, ServiceID, DontShow, R1, R2Y1, Y2G1, G2, Weight, Ord FROM p0t_FrameRep AS p0t_FrameRep_2 WHERE (ServiceTypeID = @ServiceTypeID)) AS f2 ON f1.RowNumber = f2.RowNumber LEFT OUTER JOIN (SELECT ID, RowNumber, Description, FrameID, ServiceTypeID, ServiceID, DontShow, R1, R2Y1, Y2G1, G2, Weight, Ord FROM p0t_FrameRep AS p0t_FrameRep_1 WHERE (FrameID = @FrameID)) AS f3 ON f1.RowNumber = f3.RowNumber ORDER BY f1.Ord" 
            UpdateCommand="UPDFrameRep" UpdateCommandType="StoredProcedure">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlServiceTypes" Name="ServiceTypeID" 
                    PropertyName="SelectedValue" Type="Int32" />
                <asp:ControlParameter ControlID="ddlframes" Name="FrameID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="RowNumber" Type="Int32" />
                <asp:ControlParameter ControlID="ddlServiceTypes"  Name="ServiceTypeID" Type="Int32" />
                <asp:ControlParameter ControlID="ddlFrames" Name="FrameID" Type="Int32" />
                <asp:Parameter Name="DontShow" Type="Boolean" />
                <asp:Parameter Name="R1" Type="Double" />
                <asp:Parameter Name="R2Y1" Type="Double" />
                <asp:Parameter Name="Y2G1" Type="Double" />
                <asp:Parameter Name="G2" Type="Double" />
                <asp:Parameter Name="Weight" Type="Double" />
            </UpdateParameters>
        </asp:SqlDataSource>
    
    </div>
</div>
    
</asp:Content>

