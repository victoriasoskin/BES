<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="Test3.aspx.cs" Inherits="WebPWI1.Test3" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
    <span id="VoiceDummy"></span>
    <asp:ScriptManager runat="server" ID="scrpt" />
    <asp:UpdatePanel runat="server" ID="upd">
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
                    <asp:ImageButton ID="Voice" runat="server" OnClientClick="Play();return false;" ImageUrl="voice.png" />
                </div>
                <table id="tblfaces" runat="server">
                    <tr>
                        <td>
                            <asp:ImageButton ID="HappyA1" runat="server" OnClick="Face_Click" Height="207px" ImageUrl="PWI/Faces/happy.jpg" Width="207px" BorderWidth="10" OnPreRender="ibtn_PreRender" />
                        </td>
                        <td>
                            <asp:ImageButton ID="NonoA1" runat="server" OnClick="Face_Click" Height="207px" ImageUrl="PWI/Faces/nono.jpg" Width="207px" BorderWidth="10" OnPreRender="ibtn_PreRender" />
                        </td>
                        <td>
                            <asp:ImageButton ID="SadA1" runat="server" OnClick="Face_Click" Height="207px" ImageUrl="PWI/Faces/sad.jpg" Width="207px" BorderWidth="10" OnPreRender="ibtn_PreRender" />
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




    <%--<script type="text/javascript">
    function Play() {
        var filename_prefix = "PWI/Voice/orig_00";
        var filename_suffix = ".wav";
        var QuestionStr = '<%= Session["QuestionID"] %>';
        var Q = parseInt(QuestionStr) + 1;
        var filename = Q;
        var surl = filename_prefix.concat(filename).concat(filename_suffix);
        //     alert(surl);
        document.getElementById("VoiceDummy").innerHTML = "<embed src='" + surl + "' hidden=true autostart=true loop=false>";

        return false;
    }
</script>
   <br />
   <div class="wrapper">
     <h1>  ?<asp:Label ID="QuestionTxt" runat="server" Text="Label"></asp:Label></h1>
   <asp:ImageButton ID="Hint" runat="server"  Height="100px" ImageUrl="hint.png"      Width="100px" style="float:left;"  /> 
      <asp:ImageButton ID="Voice" runat="server"  OnClientClick="Play();return false;" Height="70px" ImageUrl="voice.png"      Width="70px" style="float:right;" CssClass=voiceButton />
       <span id="VoiceDummy"></span>
     </div>   
     <p>
         <div class="wrapper">
          <asp:ImageButton ID="SadA1" runat="server"  onclick="Face_Click" Height="100px" ImageUrl="PWI/Faces/sad.jpg"      Width="100px" CssClass=faceButton  OnPreRender="ibtn_PreRender"/>
        <asp:ImageButton ID="NonoA1" runat="server" onclick="Face_Click" Height="100px"   ImageUrl="PWI/Faces/nono.jpg" Width="100px" CssClass=faceButton OnPreRender="ibtn_PreRender"/>
        <asp:ImageButton ID="HappyA1" runat="server" onclick="Face_Click" Height="100px"  ImageUrl="PWI/Faces/happy.jpg" Width="100px" CssClass=faceButton  OnPreRender="ibtn_PreRender"/>
         
            
                      <br />
         
            
                      <asp:Label ID="Feedback" runat="server" Text="" Font-Bold=true ForeColor=Red></asp:Label>
         </div>  
     <div class="next">
        <asp:ImageButton ID="NextClick" runat="server"  ImageUrl="PWI/Next.png" Height="80px"  Width="80px"  onclick="Next_Click" style="text-align: right" />
        <asp:ImageButton ID="BackClick" runat="server"  ImageUrl="PWI/Back.png" Height="80px"  Width="80px"  onclick="Back_Click" style="text-align: right" />
</div>
    </p>
 

&nbsp;--%>
</asp:Content>
