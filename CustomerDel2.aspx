<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustomerUpd2.aspx.vb" Inherits="CustomerAdd2" title="בית אקשטיין - עדכון לקוח" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="Label1" runat="server" Font-Size="Large" Text="מחיקת לקוח" Width="536px"></asp:Label></td>
        </tr>
        <tr>
            <td valign="top" style="height: 360px">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="CustomerID" DataSourceID="DSCutomers"
                    DefaultMode="Edit">
                    <EditItemTemplate>
                       <table>
                            <tr> 
                                <td bgcolor="#37a5ff" width="150">
                                    <asp:Label ID="Label2" runat="server" Text="ת.ז. / דרכון" Width="91px"></asp:Label></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBID" runat="server" Text='<%# Bind("CustomerID") %>' Width="80px" Enabled="False"></asp:TextBox></td>
                                <td style="width: 100px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                                    <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="*" MaximumValue="999999999999" MinimumValue="0"
                                        Type="Double"></asp:RangeValidator></td>
                                <td style="width: 100px">
                                    &nbsp;
                                </td>
                                <td style="width: 100px">
                                    &nbsp; &nbsp;&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" width="150">
                                    שם משפחה</td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="TBLastName" runat="server" Text='<%# Bind("CustLastName") %>' Width="180px" Enabled="False"></asp:TextBox></td>
                                <td>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TBLastName"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                <td >
                                </td>
                                <td >
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" >
                                    שם פרטי</td>
                                <td>
                                    <asp:TextBox ID="TBFirstName" runat="server" OnTextChanged="TextBox1_TextChanged"
                                        Text='<%# Bind("CustFirstName") %>' Width="180px" Enabled="False"></asp:TextBox></td>
                                <td >
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TBFirstName"
                                        Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator></td>
                                <td >
                                </td>
                                <td >
                                </td>
                            </tr>
                        </table>
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Delete"
                            Text="מחיקה"></asp:LinkButton>
                        &nbsp; &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="חזור לרשימת הלקוחות" PostBackUrl="~/CustomerList.aspx"></asp:LinkButton>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Cancel"
                            PostBackUrl="~/CustEventReport.aspx" Text="חזור לעדכון סטטוס לקוח"></asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                    </InsertItemTemplate>
                </asp:FormView>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSCutomers" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [CustomerList] WHERE [CustomerID] = @CustomerID" InsertCommand="INSERT INTO [CustomerList] ([CustomerID], [CustFirstName], [CustLastName], [CustBirthDate], [CustOriginOfficeID], [CustApotropos1ID], [CustApotroposID2], [CustGender]) VALUES (@CustomerID, @CustFirstName, @CustLastName, @CustBirthDate, @CustOriginOfficeID, @CustApotropos1ID, @CustApotroposID2, @CustGender)"
        SelectCommand="SELECT * FROM [CustomerList]  &#13;&#10;Where CustomerID=@CustomerID&#13;&#10;ORDER BY [CustLastName]" UpdateCommand="UPDATE CustomerList SET CustomerID = @CustomerID, CustFirstName = @CustFirstName, CustLastName = @CustLastName, CustBirthDate = @CustBirthDate, CustOriginOfficeID = @CustOriginOfficeID, CustApotropos1ID = @CustApotropos1ID, CustApotroposID2 = @CustApotroposID2, CustGender = @CustGender, CustApotroposName = @CustApotroposname, CustApotroposTypeID = @CustApotroposTypeID, CustApotroposAddress1 = @CustApotroposAddress1, CustApotroposAddress2 = @CustApotroposAddress2, CustApotroposPhone = @CustApotroposPhone, CustApotroposFax = @CustApotroposFax WHERE (CustomerID = @CustomerID)">
        <DeleteParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustOriginOfficeID" Type="Int32" />
            <asp:Parameter Name="CustApotropos1ID" Type="Int32" />
            <asp:Parameter Name="CustApotroposID2" Type="Int32" />
            <asp:Parameter Name="CustGender" Type="Int32" />
            <asp:Parameter Name="CustApotroposname" Type="String" />
            <asp:Parameter Name="CustApotroposTypeID" />
            <asp:Parameter Name="CustApotroposAddress1" Type="String" />
            <asp:Parameter Name="CustApotroposAddress2" Type="String" />
            <asp:Parameter Name="CustApotroposPhone" Type="String" />
            <asp:Parameter Name="CustApotroposFax" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustOriginOfficeID" Type="Int32" />
            <asp:Parameter Name="CustApotropos1ID" Type="Int32" />
            <asp:Parameter Name="CustApotroposID2" Type="Int32" />
            <asp:Parameter Name="CustGender" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CustomerID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSOriginOffice" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustOriginOfficeName] AS CustOriginOfficeTypeName, [CustOriginOfficeID] FROM [CustOriginofficeList] ORDER BY [CustOriginOfficeName]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSApotropos" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustApotroposName], [CustApotroposID] FROM [CustApotroposList] WHERE ([CustApotroposMulti] = @CustApotroposMulti) ORDER BY [CustApotroposName]">
        <SelectParameters>
            <asp:Parameter DefaultValue="True" Name="CustApotroposMulti" Type="Boolean" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSApotroposType" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustApotroposTypeName], [CustApotroposTypeID] FROM [CustApotroposTypes]">
    </asp:SqlDataSource>
</asp:Content>

