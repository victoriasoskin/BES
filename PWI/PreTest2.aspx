<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="PreTest2.aspx.cs" Inherits="WebPWI1.PreTest2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <span id="VoiceDummy"></span>
<%--    <asp:ScriptManager runat="server" ID="scrpt" />
    <asp:UpdatePanel runat="server" ID="upd">
        <ContentTemplate>--%>
            <div runat="server" id="divFrame">
                <div id="divnextback" runat="server">
                    <asp:ImageButton ID="BackClick" runat="server" ImageUrl="PWI/Back.png" OnClientClick="history.back();" />
                    <asp:ImageButton ID="NextClick" runat="server" ImageUrl="PWI/Next.png" OnClick="Next_Click" />
                    <asp:Label ID="Feedback" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                </div>
                <div id="divQuestion" runat="server">
                    <asp:Label ID="PreQuestionTxt" runat="server" Text="Label"></asp:Label><asp:Label runat="server" ID="QID" Text="0" Style="visibility: hidden;"></asp:Label>
                </div>
                <table id="tblfaces" runat="server">
                    <tr>
                        <td>
                            <asp:ImageButton ID="HappyA1" runat="server" OnClick="Face_Click" Height="300px" ImageUrl="PWI/Faces/happy.jpg" Width="300px" BorderWidth="10" />
                        </td>
                        <td>
                            <asp:ImageButton ID="SadA1" runat="server" OnClick="Face_Click" Height="300px" ImageUrl="PWI/Faces/sad.jpg" Width="300px" BorderWidth="10" />
                        </td>
                    </tr>
                </table>
            </div>
<%--        </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
