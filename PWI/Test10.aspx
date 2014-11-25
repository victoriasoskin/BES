<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Test10.aspx.cs" Inherits="WebPWI1.Test10" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<div class="header">
       שאלון סקלה 10  
    </div>--%>
    <style type="text/css">
        .style1 {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        function Play() {
            var filename_prefix = "PWI/Voice/orig_00";
            var filename_suffix = ".wav";
            var x = document.getElementById('<%= QID.ClientID %>')
            var QuestionStr = x.innerHTML;
            var Q = parseInt(QuestionStr) + 1;
            var filename = Q;
            var surl = filename_prefix.concat(filename).concat(filename_suffix);
            //     alert(surl);
            document.getElementById("VoiceDummy").innerHTML = "<embed src='" + surl + "' hidden=true autostart=true loop=false>";

            return false;
        }
    </script> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Literal runat="server" ID="litStyle" />
    <span id="VoiceDummy"></span>
    <asp:ScriptManager runat="server" ID="scrpt" />
    <asp:UpdatePanel runat="server" ID="upd" UpdateMode="Conditional">
        <ContentTemplate>
            <div runat="server" id="divFrame">
                <div id="divnextback" runat="server">
                    <asp:ImageButton ID="BackClick" runat="server" ImageUrl="PWI/Back.png" OnClick="Back_Click" />
                    <asp:ImageButton ID="NextClick" runat="server" ImageUrl="PWI/Next.png" OnClick="Next_Click" />
                    <asp:Label ID="Feedback" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
                </div>
                <div id="divQuestion" runat="server">
                    <asp:Label ID="QuestionTxt" runat="server" Text="Label"></asp:Label><asp:Label runat="server" ID="QID" Text="0" Style="visibility: hidden;"></asp:Label>
                </div>
                <div runat="server" id="divHint">
                    <asp:ImageButton ID="Hint" runat="server" ImageUrl="hint.png" CssClass="btnHintClass" OnPreRender="hint_PreRender" />
                </div>
                <div id="divVoice" runat="server">
                    <asp:ImageButton ID="Voice" runat="server" OnClientClick="Play();" ImageUrl="voice.png" />
                </div>
                <table id="tblfaces" runat="server">
                    <tr>
                        <td style="width:100%;">
                            <table style="width:100%;">
                                <tr style="width:100%;">
                                    <td style="width:9%;">מרוצה מאוד</td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:9%;"></td>
                                    <td style="width:10%;">לא מרוצה כלל</td>
                                </tr>
                            </table>
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" 
                                RepeatLayout="Table" CssClass="rbl"
                                RepeatDirection="Horizontal" 
                                OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" OnPreRender="rbl_PreRender">
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="9">9</asp:ListItem>
                                <asp:ListItem Value="8">8</asp:ListItem>
                                <asp:ListItem Value="7">7</asp:ListItem>
                                <asp:ListItem Value="6">6</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="0">0</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                </table>
                <div runat="server" id="divhintimg">
                    <asp:Image runat="server" ID="ImgHint" AlternateText="?" ImageUrl="~/PWI/Hints/2.jpg" />
                    <img src="PWI/close.png" style="position: absolute; left: 0px; top: 0px;" alt="X" onclick="hidehintimg('<%= divhintimg.ClientID %>');" />
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
