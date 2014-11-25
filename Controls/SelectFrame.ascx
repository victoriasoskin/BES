<%@ Control Language="VB" AutoEventWireup="false" CodeFile="SelectFrame.ascx.vb" Inherits="Controls_SelectFrame" %>
<%@ Register TagPrefix="topyca" TagName="TreeDropDown" Src="~/Controls/TreeDropDown.ascx" %>
<div>
    <asp:Label runat="server" ID="zzzlblFrame" Font-Bold="true" /><asp:HiddenField runat="server" ID="zzzhdnFrameID" />
    <topyca:TreeDropDown ID="tdd" runat="server" TableName="" InitialText="[בחירת מסגרת]" ValueType="Class" ConnStrName="BEBook10" CategoryID="CategoryID"
    ParentID="Parent" RootCategoryID="1" TextField="Name" OnSelectionChanged="tdd_SelectionChanged"  />
</div>