<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="WelfareReport.aspx.vb" Inherits="WelfareReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
       <asp:SqlDataSource ID="dsReport" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            
        SelectCommand="SELECT w.ID, w.EmployeeID, w.FirstName, w.LastName, w.FrameName, w.Phone, w.OpID, w.OrderDate, w.S, w.discount, w.MatchLevel, w.Status, o.OPName, o.MaxOrders, 1 AS cnt,w.Email FROM WelFareTrans AS w LEFT OUTER JOIN WelFareOPS AS o ON w.OpID = o.OpID WHERE (w.OpID = @opid) ORDER BY w.OrderDate DESC">
           <SelectParameters>
               <asp:QueryStringParameter Name="opid" QueryStringField="OP" />
           </SelectParameters>
    </asp:SqlDataSource>
        <div style="">
        <asp:ListView ID="ListView1" runat="server" DataSourceID="dsReport"  
            DataKeyNames="ID" >
            <EditItemTemplate>
                <tr style="">
                    <td>
                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                            Text="עדכון" />
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                            Text="ביטול" />
                    </td>
                    <td>
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                      <td>
                          <asp:TextBox ID="OrderDateTextBox" runat="server" 
                            Text='<%# Bind("OrderDate","{0:dd/MM/yyyy}") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="EmployeeIDTextBox" runat="server" 
                            Text='<%# Bind("EmployeeID") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="FirstNameTextBox" runat="server" 
                            Text='<%# Bind("FirstName") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="LastNameTextBox" runat="server" 
                            Text='<%# Bind("LastName") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="FrameNameTextBox" runat="server" 
                            Text='<%# Bind("FrameName") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="PhoneTextBox" runat="server" Text='<%# Bind("Phone") %>' />
                    </td>
                <td>
                        <asp:TextBox ID="Emailtextbox" runat="server" Text='<%# Bind("Email") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="STextBox" runat="server" Text='<%# Bind("S","{0:0.00}") %>' />
                    </td>
                </tr>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>
                           אין נתונים להצגה.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <tr style="background-color:#EEEEEE">
                    <td>
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="OrderDateLabel" runat="server" Text='<%# Eval("OrderDate","{0:dd/MM/yyyy}") %>' />
                    </td>
                    <td>
                        <asp:Label ID="EmployeeIDLabel" runat="server" 
                            Text='<%# Eval("EmployeeID") %>' />
                    </td>
                    <td>
                        <asp:Label ID="FirstNameLabel" runat="server" Text='<%# Eval("FirstName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="LastNameLabel" runat="server" Text='<%# Eval("LastName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="FrameNameLabel" runat="server" Text='<%# Eval("FrameName") %>' />
                    </td>
                    <td>
                        <asp:Label ID="PhoneLabel" runat="server" Text='<%# Eval("Phone") %>' />
                    </td>
                    <td>
                        <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("Email") %>' />
                    </td>
                     <td>
                        <asp:HiddenField ID="cnthdn" runat="server" value='<%# val("Cnt",0,"#") %>' />
                        <asp:Label ID="SLabel" runat="server" Text='<%# val("S",1,"#,##0.00") %>' />
                    </td>
              </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <table runat="server">
                    <tr runat="server">
                        <td runat="server">
                            <table ID="itemPlaceholderContainer" runat="server" border="0" style="" cellpadding="4">
                            <tr><td colspan="11" style="font-size:x-large;color:White;font-weight:bolder;background-color:#F17A2A;white-space:nowrap;text-align:center;margin-right:6px;">
                                <asp:Label runat="server" ID="lblhdr" Text="דוח רכישות מבצעים" OnPreRender="lblhdr_PreRender"  />
                            </td></tr>
                                <tr runat="server" style="background-color:#F17A2A;color:White;white-space:nowrap;height:15px;">
                                    <th runat="server" id="th1"><asp:LinkButton runat="server" ID="linkbutton1" Text=" מס'" CommandName="Sort" CommandArgument="ID" /><br /></th>                                    
                                    <th runat="server"><asp:LinkButton runat="server" ID="linkbutton2" Text="תאריך" CommandName="Sort" CommandArgument="OrderDate" /></th>
                                    <th runat="server" id="th2"><asp:LinkButton runat="server" ID="linkbutton3" Text="מספר ת.ז" CommandName="Sort" CommandArgument="EmployeeID" /></th>
                                    <th runat="server" id="th3"><asp:LinkButton runat="server" ID="linkbutton4" Text="שם פרטי" CommandName="Sort" CommandArgument="FirstName" /></th>
                                    <th runat="server"><asp:LinkButton runat="server" ID="linkbutton5" Text="שם משפחה" CommandName="Sort" CommandArgument="LastName" /></th>
                                    <th runat="server"><asp:LinkButton runat="server" ID="linkbutton6" Text="שם המסגרת" CommandName="Sort" CommandArgument="FrameName" /></th>
                                    <th runat="server"><asp:LinkButton runat="server" ID="linkbutton7" Text="טלפון" CommandName="Sort" CommandArgument="Phone" /></th>
                                   <th runat="server"><asp:LinkButton runat="server" ID="linkbutton8" Text="כתובת אימייל" CommandName="Sort" CommandArgument="Email" /></th>
                                   <th runat="server"><asp:LinkButton runat="server" ID="linkbutton9" Text="סכום" CommandName="Sort" CommandArgument="S" /></th>
                                </tr>
                                <tr ID="itemPlaceholder" runat="server">
                                </tr>
                                <tr style="background-color:#F17A2A;color:White;">
                                    <td colspan="6" style="text-align:left;"><b>מספר ההזמנות</b>&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                            <asp:Label ID="CLabel" runat="server" OnPreRender="cTot_PreRender" />
                                     </td>
                                    <td style="text-align:left;"><b>סכום</b>&nbsp;&nbsp;&nbsp;</td>
                                    <td>
                                           <asp:Label ID="SLabel" runat="server" OnPreRender="sTot_PreRender" />
                                     </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr runat="server">
                        <td runat="server" style="">
                        </td>
                    </tr>
                </table>
            </LayoutTemplate>
        </asp:ListView>
    </div>    
</asp:Content>

