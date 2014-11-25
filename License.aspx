<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="License.aspx.vb" Inherits="License" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="hdrdiv">
תוקף רישיון המסגרת
</div>
<div class="phdrdiv">
    
    <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="dsframe" 
        DefaultMode="Edit" EnableModelValidation="True" Height="50px" 
        Width="413px" HeaderText="הזן את תאריכי פקיעת תוקף הרישיונות במסגרת" 
        AutoGenerateRows="False" Font-Size="Small">
        <Fields>
           <asp:TemplateField HeaderText="מסגרת">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("FrameName") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField> 
            <asp:TemplateField HeaderText="תאריך פקיעת הרישיון">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" 
                        Text='<%# Bind("LicenceValidDate", "{0:d}") %>' Width="118px" ToolTip="הזן תאריך במבנה dd/mm/yyyy"></asp:TextBox>
                    
                    <asp:RangeValidator ID="RangeValidator1" runat="server" 
                        ControlToValidate="TextBox1" Display="Dynamic" ErrorMessage="תאריך לא חוקי" 
                        MaximumValue='<%#  Format(DateAdd(DateInterval.Year, 3, Today()), "dd/MM/yyyy") %>' MinimumValue='<%# Format(Today(),"dd/MM/yyyy") %>' Type="Date"></asp:RangeValidator>
                    
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="תאריך פקיעת כיבוי אש">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" 
                        Text='<%# Bind("FireFDate", "{0:d}") %>' Width="118px" ToolTip="הזן תאריך במבנה dd/mm/yyyy"></asp:TextBox>
                    
                    <asp:RangeValidator ID="RangeValidator2" runat="server" 
                        ControlToValidate="TextBox2" Display="Dynamic" ErrorMessage="תאריך לא חוקי" 
                        MaximumValue='<%#  Format(DateAdd(DateInterval.Year, 3, Today()), "dd/MM/yyyy") %>' MinimumValue='<%# Format(Today(),"dd/MM/yyyy") %>' Type="Date"></asp:RangeValidator>
                    
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField CancelText="ביטול" ShowEditButton="True" UpdateText="עדכון" />
        </Fields>
    </asp:DetailsView>
    
    <asp:SqlDataSource ID="dsframe" runat="server" 
        ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
        SelectCommand="SELECT [FrameName], [LicenceValidDate],FireFDate FROM [FrameList] WHERE ([FrameID] = @FrameID)" 
        
        UpdateCommand="UPDATE FrameList SET LicenceValidDate = @LicenceValidDate, AlertMailSent=0,FireFDate=@FireFDate,FFAlertmailSent=0 WHERE (FrameID = @FrameID)">
        <SelectParameters>
            <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="LicenceValidDate" Type="DateTime" />
            <asp:Parameter Name="FireFDate" Type="DateTime" />
             <asp:SessionParameter Name="FrameID" SessionField="FrameID" Type="Int32" />
       </UpdateParameters>
    </asp:SqlDataSource>
    
</div>
</asp:Content>

