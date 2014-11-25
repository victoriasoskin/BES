<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Phone.ascx.vb" Inherits="Phone" %>
<div  style="white-space:nowrap;"  >
    <asp:RequiredFieldValidator ForeColor="Red" runat="server" ControlToValidate="zzztbPhone" ErrorMessage="יש להקליד מספר טלפון" ValidationGroup="zzzPhone" Display="Dynamic" ID="zzzRFVPhone" />
    <asp:rangevalidator runat="server" ForeColor="Red" ControlToValidate="zzztbPhone" ErrorMessage="רק ספרות מ 0 עד 9, 7 ספרות" ValidationGroup="zzzPhone" Display="Dynamic" ID="zzzzrvPhone" Type="Integer" MinimumValue="1000000" MaximumValue="9999999" />
    <asp:RequiredFieldValidator runat="server" ForeColor="Red" ControlToValidate="zzzEH" ErrorMessage="יש לבחור בקדומת" ValidationGroup="zzzPhone" Display="Dynamic" ID="rfvEH" />
    <asp:TextBox runat="server" ID="zzztbPhone" Width="50px" style="border:2px inset #EEEEEE;" />
    <asp:DropDownList runat="server" ID="zzzEH" DataSourceID="zzzDSEH" DataTextField="Eh" >
    </asp:DropDownList>
    <asp:SqlDataSource runat="server" ID="zzzdsEH" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>"  CancelSelectOnNullParameter="false"
        SelectCommand="SELECT [Eh] FROM [Phone_EH] WHERE ([Typ] = ISNULL(@Typ,Typ)) ORDER BY [Eh]">
        <SelectParameters>
            <asp:Parameter Name="Typ" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</div>