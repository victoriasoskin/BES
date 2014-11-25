<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="ProgTextEditor.aspx.vb" Inherits="ProgTextEditor" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
    <div style="width:300px;font-size:large;color:Blue;">עריכת טקסטים בתוכניות<br /><br /></div>
    <div>
        <asp:DropDownList ID="ddlProgs" runat="server" AutoPostBack="True" AppendDataBoundItems="true" 
            DataSourceID="dsProgs" DataTextField="ProgDesc" DataValueField="ProgramID">
                <asp:ListItem Value="">[בחירת תוכנית]</asp:ListItem>
        </asp:DropDownList>
        <asp:SqlDataSource ID="dsProgs" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT [ProgDesc], [ProgramID] FROM [Programs]">
        </asp:SqlDataSource>
    </div> 
    <div>
        
        <asp:SqlDataSource ID="dsTexts" runat="server" 
            ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
            SelectCommand="SELECT [TextDescription], [textID] FROM [ProgramTexts] WHERE ([ProgramID] = @ProgramID)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProgs" Name="ProgramID" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
            <asp:DropDownList ID="ddltexts" runat="server" 
            AppendDataBoundItems="True" AutoPostBack="True" DataSourceID="dsTexts" 
            DataTextField="TextDescription" DataValueField="textID">
                <asp:ListItem Value="">[בחירת טקסט לעריכה]</asp:ListItem>
            </asp:DropDownList>
        
    </div>
    <div style="width:400px;">
        <table>
            <tr>
                <td valign="top">
                    <asp:ListView ID="lvet" runat="server" DataSourceID="dsEText" 
                        DataKeyNames="TextID">
                         <EditItemTemplate>
                             <tr style="">
                                 <td>
                                     <asp:Button ID="UpdateButton" runat="server" CommandName="Update" 
                                         Text="עדכון" />
                                     <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" 
                                         Text="ביטול" />
                                 </td>
                                 <td>
                                     <asp:Label ID="TextIDLabel1" runat="server" Text='<%# Eval("TextDescription") %>' />
                                 </td>
                        </tr>
                            <tr>
    
                                 <td colspan="2">
                                   <ckeditor:ckeditorcontrol runat="server" ID="ckE" Width="100%" Text='<%# Bind("RFText") %>' EnterMode="BR" ShiftEnterMode="P" />
                                 </td>
                             </tr>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
 <%--                           <table style="" runat="server">
                                <tr>
                                    <td>
                                   </td>
                                </tr>
                            </table>
--%>                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr style="">
                                <td>
                                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="עריכה" />
                                </td>
                                <td>
                                    <asp:Label ID="TextIDLabel" runat="server" Text='<%# Eval("TextDescription") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="RFTextLabel" runat="server" Text='<%# Eval("RFText") %>' Width="350px" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <LayoutTemplate>
                            <table runat="server">
                                <tr runat="server">
                                    <td runat="server">
                                        <table ID="itemPlaceholderContainer" runat="server" border="1" style="">
                                            <tr runat="server" style="background-color:#DDDDDD;width:100%">
                                                <th runat="server" colspan="2">
                                      <button id="btnf" style="width:90px;background:none;border:0;color:#0000ff;text-decoration:underline;cursor:pointer;" onclick="window.open('/RequestPW.aspx', null, 'toolbar=no,location=center,status=yes,menubar=no,scrollbars=no,alwaysRaised=yes,resizable=no,width=400,height=295');return false;">שכחתי סיסמא</button>
                                       </th>
                                            </tr>
                                            <tr ID="itemPlaceholder" runat="server">
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
               </td>
                <td valign="top">
                    <asp:ImageMap ID="ImageMapx" runat="server" ImageUrl="images/forgot.png" HotSpotMode="PostBack" Visible="false" >
                       </asp:ImageMap>
                 </td>
            </tr>
        </table>
     </div>
     <div>
         <asp:SqlDataSource ID="dsEText" runat="server" 
             ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
             DeleteCommand="DELETE FROM [ProgramTexts] WHERE [textID] = @textID" 
             InsertCommand="INSERT INTO [ProgramTexts] ([ProgramID], [TextStyle], [CSSClass], [RFText]) VALUES (@ProgramID, @TextStyle, @CSSClass, @RFText)" 
             SelectCommand="SELECT TextID,[RFText],TextDescription FROM [ProgramTexts] WHERE ([textID] = @textID)" 
             UpdateCommand="UPDATE [ProgramTexts] SET [RFText] = @RFText WHERE [textID] = @textID">
             <DeleteParameters>
                 <asp:Parameter Name="textID" Type="Int32" />
             </DeleteParameters>
             <InsertParameters>
                 <asp:Parameter Name="ProgramID" Type="Int32" />
                 <asp:Parameter Name="TextStyle" Type="String" />
                 <asp:Parameter Name="CSSClass" Type="String" />
                 <asp:Parameter Name="RFText" Type="String" />
             </InsertParameters>
             <SelectParameters>
                 <asp:ControlParameter ControlID="ddlTexts" Name="textID" 
                     PropertyName="SelectedValue" Type="Int32" />
             </SelectParameters>
             <UpdateParameters>
                 <asp:Parameter Name="RFText" Type="String" />
                 <asp:Parameter Name="textID" Type="Int32" />
             </UpdateParameters>
         </asp:SqlDataSource>
     </div>
</div>
</asp:Content>

