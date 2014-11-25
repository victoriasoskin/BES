<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" title="תזרים - דף כניסה" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table align="center" style="height: 162px" width="100%">
        <tr>
            <td style="width: 579px">
            </td>
            <td style="width: 579px">
            </td>
        </tr>
        <tr>
            <td align="center" style="width: 579px; height: 51px" valign="middle">
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl=""
                    Width="100%" /></td>
            <td align="center" style="width: 579px; height: 51px" valign="middle">
                <asp:Login ID="Login1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderPadding="4"
                    BorderStyle="Solid" BorderWidth="1px" FailureText="ההתחברות לא הצליחה. נסה שנית!"
                    Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333" LoginButtonText="התחבר"
                    PasswordLabelText="סיסמא:" PasswordRequiredErrorMessage="חובה להקיש סיסמא" RememberMeText="זכור את הסיסמא"
                    TitleText="" UserNameLabelText="שם משתמש:" UserNameRequiredErrorMessage="חובה להקיש שם משתמש">
                    <TitleTextStyle BackColor="#507CD1" Font-Bold="True" Font-Size="0.9em" ForeColor="White"
                        Wrap="False" />
                    <CheckBoxStyle Wrap="False" />
                    <InstructionTextStyle Font-Italic="True" ForeColor="Black" Wrap="False" />
                    <TextBoxStyle Font-Size="0.8em" />
                    <LoginButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px"
                        Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                    <LabelStyle Wrap="False" />
                    <FailureTextStyle Wrap="False" />
                    <HyperLinkStyle Wrap="False" />
                </asp:Login>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td style="width: 579px; height: 31px">
            </td>
            <td style="width: 579px; height: 31px">
            </td>
        </tr>
    </table>
</asp:Content>

 