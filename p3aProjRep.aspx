<%@ Page Language="VB" MasterPageFile="~/SHERUT.master" AutoEventWireup="false" MaintainScrollPositionOnPostback="true" CodeFile="p3aProjRep.aspx.vb" Inherits="p3a_Trans" title="מעקב תחזוקה - דוח פרויקטים" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
                           <asp:HiddenField ID="HDNTOP" runat="server" />
    <table style="width: 100%">
        <tr>
            <td>
                <table style="width: 100%">
                    <tr>
                        <td style="height: 25px">
                <asp:Label ID="Label2" runat="server" Width="197px" Font-Size="Large" ForeColor="#003399" 
                    Text="דוח פרויקטים"></asp:Label>
                         </td>
                        <td style="height: 25px">
                            &nbsp;</td>
                        <td style="height: 25px">
                            <asp:LinkButton ID="LNKBSHOWALL" runat="server">נקה מסננים</asp:LinkButton>
                        </td> 
                        <td style="height: 25px">
                        </td>
                        <td style="height: 25px">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    CellPadding="2" DataSourceID="DSProj" AllowSorting="True" 
                    AllowPaging="True" PageSize="28" Font-Size="X-Small" ShowFooter="True">
                    <Columns>


                        <asp:HyperLinkField DataNavigateUrlFields="ProjID" 
                            DataNavigateUrlFormatString="~/p3aProject.aspx?ProjID={0}" 
                            DataTextField="ProjID" DataTextFormatString="הצג" />


                        <asp:BoundField DataField="ProjID" HeaderText="ProjID" SortExpression="ProjID" 
                            Visible="False" />
                        <asp:TemplateField HeaderText="שם הפרויקט" SortExpression="ProjName">
                           <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("ProjName") %>'></asp:Label>
                            </ItemTemplate>
                        <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="ProjName" ID="LNKHProjName" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">שם הפרויקט</asp:LinkButton><br />
                                    <asp:TextBox runat="server" ID="TBFPROJNAME" Font-Size="X-Small" Width="90" AutoPostBack="true" OnPreRender="TBF_PreRender" OnTextChanged="TBF_TextChanged" />
                                  <asp:LinkButton ID="LNKBCFPROJNAME" runat="server" Font-Size="X-Small" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                      </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="כתובת" SortExpression="ProjAddress">
                            <ItemTemplate>
                                <asp:Label ID="Label16" runat="server" Text='<%# Bind("ProjAddress") %>'></asp:Label>
                            </ItemTemplate>
                       <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="ProjAddress" ID="LNKHProjAddress" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">כתובת</asp:LinkButton><br />
                                    <asp:TextBox runat="server" ID="TBFPROJAddress" Font-Size="X-Small" Width="90" AutoPostBack="true" OnPreRender="TBF_PreRender" OnTextChanged="TBF_TextChanged" />
                                  <asp:LinkButton ID="LNKBCFPROJAddress" runat="server" Font-Size="X-Small" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                      </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="התחלה" SortExpression="Projdate">
                            <ItemTemplate>
                                <asp:Label ID="Label17" runat="server" Text='<%# Bind("Projdate", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                        <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="ProjDATE" ID="LNKHprojDATE" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">התחלה</asp:LinkButton><br />
                                <asp:SqlDataSource ID="DSFprojDATE" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
                                    SelectCommand="SELECT DISTINCT [MprojDATE] FROM p3v_ProjList WHERE MprojDATE IS NOT NULL ORDER BY MprojDATE ">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLFprojDATE" runat="server" AutoPostBack="True" DataSourceID="DSFprojDATE"
                                     DataTextField="MprojDATE" DataValueField="MprojDATE" 
                                    AppendDataBoundItems="True" Font-Size="X-Small" 
                                    OnSelectedIndexChanged="DDLF_SelectedIndexChanged" BackColor="#C0C0FF" 
                                    OnPreRender="DDLF_PreRender" DataTextFormatString="{0:MMM-yy}" >
                                     <items><asp:ListItem text="הכל" Value=""/></items>
                                 </asp:DropDownList>
                                 <asp:LinkButton ID="LNKBCFprojDATE" Font-Size="X-Small" runat="server" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                        </HeaderTemplate>
                       </asp:TemplateField>
                        <asp:TemplateField HeaderText="תיאור השלב הנוכחי" SortExpression="ProjDesc">
                            <ItemTemplate>
                                <asp:Label ID="Label19" runat="server" Text='<%# Bind("ProjDesc") %>'></asp:Label>
                            </ItemTemplate>
                        <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="ProjDesc" ID="LNKHProjDesc" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">תיאור השלב הנוכחי</asp:LinkButton><br />
                                    <asp:TextBox runat="server" ID="TBFPROJdesc" Font-Size="X-Small" Width="90" AutoPostBack="true" OnPreRender="TBF_PreRender" OnTextChanged="TBF_TextChanged" />
                                  <asp:LinkButton ID="LNKBCFPROJdesc" runat="server" Font-Size="X-Small" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                      </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="סיום מתוכנן" SortExpression="PlannedEndDate">
                            <ItemTemplate>
                                <asp:Label ID="Label20" runat="server" Text='<%# Bind("PlannedEndDate", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                        <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="PlannedEndDATE" ID="LNKHPlannedEndDATE" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">סיום מתוכנן</asp:LinkButton><br />
                                <asp:SqlDataSource ID="DSFPlannedEndDATE" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
                                    SelectCommand="SELECT DISTINCT [MPlannedEndDATE] FROM p3v_ProjList WHERE MPlannedEndDATE IS NOT NULL ORDER BY MPlannedEndDATE ">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLFPlannedEndDATE" runat="server" AutoPostBack="True" DataSourceID="DSFPlannedEndDATE"
                                     DataTextField="MPlannedEndDATE" DataValueField="MPlannedEndDATE" 
                                    AppendDataBoundItems="True" Font-Size="X-Small" 
                                    OnSelectedIndexChanged="DDLF_SelectedIndexChanged" BackColor="#C0C0FF" 
                                    OnPreRender="DDLF_PreRender" DataTextFormatString="{0:MMM-yy}" >
                                     <items><asp:ListItem text="הכל" Value=""/></items>
                                 </asp:DropDownList>
                                 <asp:LinkButton ID="LNKBCFPlannedEndDATE" Font-Size="X-Small" runat="server" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                        </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="סטטוס" SortExpression="StatusName">
                            <ItemTemplate>
                                <asp:Label ID="Label21" runat="server" Text='<%# Bind("StatusName") %>'></asp:Label>
                            </ItemTemplate>
                        <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="STATUSNAME" ID="LNKHSTATUSNAME" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">סטטוס</asp:LinkButton><br />
                                <asp:SqlDataSource ID="DSFSTATUSNAME" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
                                    SelectCommand="SELECT DISTINCT [STATUSNAME] FROM p3v_ProjList Where STATUSNAME is not NULL Order By STATUSNAME">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLFSTATUSNAME" runat="server" AutoPostBack="True" DataSourceID="DSFSTATUSNAME"
                                     DataTextField="STATUSNAME" DataValueField="STATUSNAME" 
                                    AppendDataBoundItems="True" Font-Size="X-Small" 
                                    OnSelectedIndexChanged="DDLF_SelectedIndexChanged" BackColor="#C0C0FF" 
                                    OnPreRender="DDLF_PreRender" >
                                     <items><asp:ListItem text="הכל" Value=""/>
                                         <asp:ListItem>&lt;--&gt;</asp:ListItem>
                                     </items>
                                 </asp:DropDownList>
                                 <asp:LinkButton ID="LNKBCFSTATUSNAME" Font-Size="X-Small" runat="server" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                        </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="מסגרת" SortExpression="FrameName">
                            <ItemTemplate>
                                <asp:Label ID="Label22" runat="server" Text='<%# Bind("FrameName") %>'></asp:Label>
                            </ItemTemplate>
                         <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="FRAMENAME" ID="LNKHFRAMENAME" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">מסגרת</asp:LinkButton><br />
                                <asp:SqlDataSource ID="DSFFRAMENAME" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:BEBook10 %>" 
                                    SelectCommand="SELECT DISTINCT [FRAMENAME] FROM p3v_projlist Where FRAMENAME is not NULL Order By FRAMENAME">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLFFRAMENAME" runat="server" AutoPostBack="True" DataSourceID="DSFFRAMENAME"
                                     DataTextField="FRAMENAME" DataValueField="FRAMENAME" 
                                    AppendDataBoundItems="True" Font-Size="X-Small" 
                                    OnSelectedIndexChanged="DDLF_SelectedIndexChanged" BackColor="#C0C0FF" 
                                    OnPreRender="DDLF_PreRender" >
                                     <items><asp:ListItem text="הכל" Value=""/>
                                         <asp:ListItem>&lt;--&gt;</asp:ListItem>
                                     </items>
                                 </asp:DropDownList>
                                 <asp:LinkButton ID="LNKBCFFRAMENAME" Font-Size="X-Small" runat="server" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                        </HeaderTemplate>
                       </asp:TemplateField>
                        <asp:TemplateField SortExpression="NewFB">
                         <HeaderTemplate>
                                <asp:LinkButton CommandName="SORT" CommandArgument="NEWFB" ID="LNKHNEWFB" 
                                    runat="server" ForeColor="WHITE" Font-Size="X-Small">משוב</asp:LinkButton><br />
                                <asp:SqlDataSource ID="DSFNEWFB" runat="server" 
                                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                                    
                                    SelectCommand="SELECT DISTINCT [NEWFB] FROM p3v_projlist Where NEWFB IS NOT NULL Order By NEWFB">
                                </asp:SqlDataSource>
                                <asp:DropDownList ID="DDLFNEWFB" runat="server" AutoPostBack="True" DataSourceID="DSFNEWFB"
                                     DataTextField="NEWFB" DataValueField="NEWFB" 
                                    AppendDataBoundItems="True" Font-Size="X-Small" 
                                    OnSelectedIndexChanged="DDLF_SelectedIndexChanged" BackColor="#C0C0FF" 
                                    OnPreRender="DDLF_PreRender" EnableViewState="False" >
                                     <items><asp:ListItem text="הכל" Value=""/>
                                         <asp:ListItem>&lt;--&gt;</asp:ListItem>
                                     </items>
                                 </asp:DropDownList>
                                 <asp:LinkButton ID="LNKBCFNEWFB" Font-Size="X-Small" runat="server" ForeColor="WHITE" OnClick="LNKBCF_Click">נקה מסנן</asp:LinkButton>
                        </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("NewFB") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                   </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="DSProj" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:bebook10 %>" 
                    
                    SelectCommand="SELECT ProjID, RowOrder, ProjName, ProjAddress, FrameID, Projdate, StatusID, ProjDesc, PlannedEndDate, Comments, StatusName, FrameName, MProjDate, MPlannedEndDate, NewFB FROM p3v_ProjList WHERE (ProjName LIKE '%' + ISNULL(@ProjName, ProjName) + '%') AND (ProjAddress LIKE '%' + ISNULL(@ProjAddress, ProjAddress) + '%') AND (ProjDesc LIKE '%' + ISNULL(@ProjDesc, ProjDesc) + '%') AND (MPlannedEndDate = ISNULL(@MPlannedEndDate, MPlannedEndDate)) AND (StatusName = ISNULL(@StatusName, StatusName)) AND (FrameName = ISNULL(@FrameName, FrameName)) AND (MProjDate = ISNULL(@Projdate, MProjDate)) AND (ISNULL(NewFB, '') = ISNULL(@NEWFB, ISNULL(NewFB, '')))" 
                    CancelSelectOnNullParameter="False">
                    <SelectParameters>
                        <asp:SessionParameter Name="ProjName" SessionField="UAD_ProjName" 
                            Type="String" />
                        <asp:SessionParameter Name="ProjAddress" SessionField="UAD_ProjAddress" 
                            Type="String" />
                        <asp:SessionParameter Name="ProjDesc" SessionField="UAD_ProjDesc" 
                            Type="String" />
                        <asp:SessionParameter Name="MPlannedEndDate" SessionField="UAD_MPlannedEndDate" 
                            Type="DateTime" />
                        <asp:SessionParameter Name="StatusName" SessionField="UAD_StatusName" 
                            Type="String" />
                        <asp:SessionParameter Name="FrameName" SessionField="UAD_FrameName" 
                            Type="String" />
                        <asp:SessionParameter Name="Projdate" SessionField="UAD_ProjDate" 
                            Type="DateTime" />
                        <asp:SessionParameter Name="NEWFB" SessionField="UAD_NEWFB" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </td>
        </tr>
    </table>
    <asp:Label ID="LBLBTM" runat="server" Width="315px"></asp:Label>
    
    

    
    </asp:Content>

