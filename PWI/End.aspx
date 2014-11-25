<%@ Page Title="" Language="C#" MasterPageFile="Site.Master" AutoEventWireup="true" CodeBehind="End.aspx.cs" Inherits="WebPWI1.WebForm1" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div runat="server" id="divFrame">
        <table>
            <tr style="padding-top:10px;">
                <td>
                    <h2>סיכום השאלון</h2>
                </td>
                <td>
                    <asp:Button ID="BacktoBEonline" runat="server" OnClick="backtoBEonline_Click" Style="float: left;"
                        Text="חזרה למערכת הניהול" /></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Chart ID="Chart1" runat="server" Width="950" Height="620" ImageType="Jpeg" ImageStorageMode="UseImageLocation">
                        <Series>
                            <asp:Series Name="Series1" XValueMember="Country" YValueMembers="Column1" ChartType="Column" IsValueShownAsLabel="false">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea BackGradientStyle="LeftRight" Name="ChartArea1" ShadowOffset="5">

                                <AxisY Title="איכות חיים" IsStartedFromZero="false" Minimum="0" Maximum="5" Interval="1">
                                </AxisY>
                                <AxisX Title="מדדים" IsLabelAutoFit="True">
                                    <MajorGrid Enabled="false" />
                                    <LabelStyle Angle="90" Interval="1" />
                                </AxisX>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
            </tr>
        </table>

    </div>
    <br />
    <p>
        <asp:Label ID="ErrorMsg" runat="server" Text="" Font-Bold="true" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>
