<%@ Page Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="CustomerUpd2.aspx.vb" Inherits="CustomerAdd2" title="בית אקשטיין - עדכון לקוח" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 	<script type="text/javascript">

		// DEFINE RETURN VALUES
		var R_ELEGAL_INPUT = -1;
		var R_NOT_VALID = -2;
		var R_VALID = 1;

		function ValidID(sender, args) {
			//args.IsValid = true;
			args.IsValid = (ValidateID(args.Value) == R_VALID);
			return;
		}

		function ValidateID(str) {
			//INPUT VALIDATION
 
			// Just in case -> convert to string
			var IDnum = String(str);

			// Validate correct input
			if ((IDnum.length > 9) || (IDnum.length < 5))
				return R_ELEGAL_INPUT;
			if (isNaN(IDnum))
				return R_ELEGAL_INPUT;

			// The number is too short - add leading 0000
			if (IDnum.length < 9) {
				while (IDnum.length < 9) {
					IDnum = '0' + IDnum;
				}
			}

			// CHECK THE ID NUMBER
			var mone = 0, incNum;
			for (var i = 0; i < 9; i++) {
				incNum = Number(IDnum.charAt(i));
				incNum *= (i % 2) + 1;
				if (incNum > 9)
					incNum -= 9;
				mone += incNum;
			}
			if (mone % 10 == 0)
				return R_VALID;
			else
				return R_NOT_VALID;
		}
 
	</script> 
   <table>
        <tr>
            <td style="width: 100px">
                <asp:Label ID="LBLHDR" runat="server" Font-Size="Large" Text="עדכון לקוח" Width="536px"></asp:Label></td>
        </tr>
        <tr>
            <td valign="top" style="height: 359px">
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="RowID" DataSourceID="DSCutomers"
                    DefaultMode="Edit" BorderWidth="1px">
                    <EditItemTemplate>
                       <table>
                           <tr>
                               <td bgcolor="#37a5ff" colspan="4" style="text-align: center" >
                                   <span style="font-size: 12pt">פרטים אישיים</span></td>
                              
                               <td bgcolor="#37a5ff" colspan="2" style="text-align: center" >
                                   <span style="font-size: 12pt">פרטי האפוטרופוס</span></td>
                                <td bgcolor="#37a5ff" colspan="2" style="text-align: center" >
                                   <span style="font-size: 12pt">פרטי המשפחה</span></td>
                           </tr>
                            <tr>
                                <td bgcolor="#37a5ff" >
                                    <asp:Label ID="Label3" runat="server" Text="ת.ז. / דרכון" Width="68px"></asp:Label></td>
                                <td>
                                    <asp:TextBox ID="TBID" runat="server" Text='<%# Bind("CustomerID") %>' Width="80px" OnTextChanged="TBID_TextChanged" TabIndex="10" ToolTip='<%#if(request.querystring("CAND")=1,"הקלד את תעודת הזהות של הלקוח","הקלד את תעודת הזהות של המועמד") %>' AutoPostBack="True"></asp:TextBox></td>
                                <td style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RFVID" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="חובה להקיש מספר ת.ז." Width="247px"></asp:RequiredFieldValidator><asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="TBID"
                                        Display="Dynamic" ErrorMessage="מס' ת.ז. לא חוקי" MaximumValue="999999999999" MinimumValue="0"
                                        Type="Double" Width="213px"></asp:RangeValidator><asp:CustomValidator ID="CVID" runat="server" ControlToValidate="TBID" Display="Dynamic"
                                        ErrorMessage="מס ת.ז. זה כבר קיים אצל לקוח אחר במערכת" Width="287px"></asp:CustomValidator></td>
   										<asp:CustomValidator ID="CvIDvalidID" runat="server" ClientValidationFunction="ValidID" 
											ControlToValidate="tbid" Display="Dynamic" 
											ErrorMessage="מספר תעודת זהות לא חוקי" />
                               <td style="width: 100px">
                                    &nbsp;
                                </td>
                                <td bgcolor="#37a5ff" colspan="2">
                                    <asp:Button ID="BTNCOPYCUSTTOAPT" runat="server" CausesValidation="False" OnClick="BTNCOPYCUSTTOAPT_Click"
                                        Text='<%#if(request.querystring("CAND")=1,"העתקת כתובת המועמד לכתובת האפוטרופוס","העתקת כתובת הלקוח לכתובת האפוטרופוס") %>' Width="250px" ToolTip='לחיצה על הכפתור מעתיקה מפרטי הלקוח לפרטי האפוטרופוס את השדות הבאים: כתובת, עיר, מיקוד, טלפון, טלפון סלולרי,  ודוא"ל.' />
                                    </td>
                                <td bgcolor="#37a5ff" colspan="2">
                                    <asp:Button ID="BTNCOPYAPTTOFAM" runat="server" CausesValidation="False" OnClick="BTNCOPYAPTTOFAM_Click"
                                        Text="העתקת פרטי האפוטרופוס לפרטי המשפחה" Width="250px" ToolTip='לחיצה על הכפתור מעתיקה מפרטי האפוטרופוס לפרטי המשפחה את השדות הבאים: שם, כתובת, עיר, מיקוד, טלפון , פקס,  טלפון סלולרי, ודוא"ל.' /></td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px">
                                    שם משפחה</td>
                                <td style="width: 197px">
                                    <asp:TextBox ID="TBLastName" runat="server" Text='<%# Bind("CustLastName") %>' Width="110px" TabIndex="20"></asp:TextBox></td>
                                <td style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="TBLastName"
                                        Display="Dynamic" ErrorMessage="חובה להקיש שם משפחה" Width="225px"></asp:RequiredFieldValidator></td>
                                <td style="width: 100px">
                                </td>
                                <td style="width: 112px" bgcolor="#37a5ff" >
                                    שם</td>
                                    <td style="width: 39px">
                                    <asp:TextBox ID="TBAPTNAME" runat="server" Text='<%# Bind("CustApotroposName") %>'
                                        Width="160px" TabIndex="240"></asp:TextBox></td><td bgcolor="#37a5ff" style="width: 213px">
                                    שם</td>
                                <td>
                                    <asp:TextBox ID="TBFAMNAME" runat="server" Width="160px" Text='<%# Bind("CustFamilyName") %>' TabIndex="400"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px; " >
                                    שם פרטי</td>
                                <td style="width: 197px; ">
                                    <asp:TextBox ID="TBFirstName" runat="server" OnTextChanged="TextBox1_TextChanged"
                                        Text='<%# Bind("CustFirstName") %>' Width="110px" TabIndex="30"></asp:TextBox></td>
                                <td >
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TBFirstName"
                                        Display="Dynamic" ErrorMessage="חובה להקיש שם פרטי" Width="234px"></asp:RequiredFieldValidator></td>
                                <td style="width: 100px; ">
                                </td>
                                <td style="width: 112px" bgcolor="#37a5ff" >
                                   סוג</td>
                                <td style="width: 39px" >
                                    <asp:DropDownList ID="DDLAPTType" runat="server" DataSourceID="DSApotroposType"
                                        DataTextField="CustApotroposTypeName" AppendDataBoundItems="true" DataValueField="CustApotroposTypeID" SelectedValue='<%# Bind("CustApotroposTypeID") %>' TabIndex="250">
                                        <asp:ListItem Text="<בחר סוג>" Value="" />
                                    </asp:DropDownList></td>
                                <td bgcolor="#37a5ff" style="width: 213px">
                                    <asp:Label ID="Label4" runat="server" Width="69px"></asp:Label></td>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td bgcolor="#37a5ff" style="width: 113px">
                                    תאריך לידה</td>
                                <td style="width: 197px" >
                                    <table>
                                        <tr>
                                            <td colspan="1">
                                    <asp:TextBox ID="TBBirthDate" runat="server" Text='<%# Bind("CustBirthDate", "{0:dd/MM/yyyy}") %>'
                                        Width="80px" TabIndex="40" ToolTip="הקלד את תאריך הלידה במבנה d/m/y כאשר d - היום בחודש m = החודש  y = שנת הלידה"></asp:TextBox></td>
                                            <td>
                                    <asp:RadioButtonList ID="RBLGENDER" runat="server" AppendDataBoundItems="True" RepeatDirection="Horizontal" SelectedValue='<%# Bind("CustGender") %>' TabIndex="50">
                                        <asp:ListItem Text="ז" Value="1" Selected=True></asp:ListItem>
                                        <asp:ListItem Text="נ" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList></td>
                                        </tr>
                                    </table>
                                </td>
                                <TD style="width: 290px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="TBBirthDate"
                                        Display="Dynamic" ErrorMessage="חובה להקיש תאריך לידה"  Width="207px"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator4" runat="server"
                                            ControlToValidate="TBBirthDate" Display="Dynamic" ErrorMessage="תאריך לידה לא חוקי" MaximumValue="1/1/2021"
                                            MinimumValue="1/1/1911" Type="Date" Width="220px"></asp:RangeValidator>
                                </td>
                                <td style="width: 100px">
                                </td>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 112px">
                                    כתובת</td>
                                <td style="width: 213px">
                                    <asp:TextBox ID="TBAPTAD1" runat="server" Text='<%# Bind("CustApotroposAddress1") %>'
                                       Width="160px" TabIndex="260" OnTextChanged="TBAPTAD1_TextChanged"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 213px">
                                    כתובת</td>
                                <td style="width: 213px">
                                    <asp:TextBox ID="TBFAMAD1" runat="server" Width="160px" Text='<%# Bind("CustFamilyAddress1") %>' TabIndex="410"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td bgcolor="#0099cc" style=" width: 113px; border-right: gray thin dotted; border-top: gray thin dotted;" bordercolordark="#000099" >                                    
                                    <strong>גורם מפנה</strong></td>
                                <td style="width: 197px; border-top: gray thin dotted; border-left: gray thin dotted;" bordercolordark="#000099">
                                    <asp:DropDownList ID="DDLORIGINOFFICE" runat="server" AppendDataBoundItems="True" SelectedValue='<%# Bind("CustOriginOfficeTypeID") %>' DataSourceID="DSOriginOffice" DataTextField="CustOriginOfficeTypeName" DataValueField="CustOriginOfficeTypeID" TabIndex="60" ToolTip="בחר בגורם המפנה מתוך הרשימה" OnSelectedIndexChanged="DDLORIGINOFFICE_SelectedIndexChanged">
                                        <asp:ListItem text="[ללא גורם מפנה]" Value=""></asp:ListItem>
                                    </asp:DropDownList></td>
                                <td style=" width: 290px;">
                                </td>
                                <td style="width: 100px; ">
                                </td><td style="width: 39px; ">
                                    <asp:TextBox ID="TBAPTAD2" runat="server" Text='<%# Bind("CustApotroposAddress2") %>'
                                       Width="160px" TabIndex="270"></asp:TextBox></td>
                                <td style="width: 213px; ">
                                    <asp:TextBox ID="TBFAMAD2" runat="server" Width="160px" Text='<%# Bind("CustFamilyAddress2") %>' TabIndex="420"></asp:TextBox></td>
                            </tr>
                           <tr>
                               <td bgcolor="#0099cc" rowspan="1" style="width: 113px;  border-right: gray thin dotted; " bordercolordark="#000099">
                                   עיר</td>
                               <td style="width: 197px; border-left: gray thin dotted;" bordercolordark="#000099">
                                   <asp:TextBox ID="TBORIGINOFFICECITY" runat="server" AutoPostBack="True" OnTextChanged="TBORIGINOFFICECITY_TextChanged"
                                       TabIndex="62" Text='<%# Bind("CustOriginOfficeCity") %>'></asp:TextBox></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px; ">
                               </td>
                                <td style=" width: 112px;" bgcolor="#37a5ff">
                                    עיר</td>
                                    <td style="width: 39px; ">
                                        <asp:TextBox ID="TBAPTCITY" runat="server" TabIndex="280" Text='<%# Bind("CustApotroposCity") %>'></asp:TextBox></td>
                                <td bgcolor="#37a5ff" style="width: 213px; ">
                                    עיר</td>
                                <td style="width: 213px; ">
                                    <asp:TextBox ID="TBFAMCITY" runat="server" TabIndex="430" Text='<%# Bind("CustFamilyCity") %>'></asp:TextBox></td>
                           </tr>
                           <tr>
                               <td bgcolor="#0099cc" rowspan="1" style="width: 113px; border-right: gray thin dotted; border-bottom: gray thin dotted;" bordercolordark="#000099">
                                   שם הסניף</td>
                               <td style="width: 197px; border-left: gray thin dotted; border-bottom: gray thin dotted;" bordercolordark="#000099">
                                   <asp:TextBox ID="TBORIGINNAME" runat="server" Width="160px" Text='<%# Bind("CustOriginOfficeName") %>' TabIndex="64" ToolTip="הקלד את שם הסניף של הגורם המפנה. לדוגמא, הגורם המפנה הוא הביטוח הלאומי, העיר היא חיפה והסניף הוא כרמל."></asp:TextBox></td>
                               <td style="width: 290px; ">
                               </td>
                               <td style="width: 100px; ">
                               </td>
                               <td bgcolor="#37a5ff" style="width: 112px; ">
                                   מיקוד</td>
                               <td style="width: 39px; ">
                                   <asp:TextBox ID="TBAPTZIP" runat="server" Width="70px" TabIndex="290" Text='<%# Bind("CustApotroposZipcode") %>'></asp:TextBox><asp:RangeValidator ID="RangeValidator5" runat="server" ControlToValidate="TBAPTZIP"
                                       Display="Dynamic" ErrorMessage="מיקוד חייב להיות מספר בן 5 ספרות" Type="Integer" MaximumValue="99999" MinimumValue="10000" Width="179px"></asp:RangeValidator></td>
                               <td bgcolor="#37a5ff" style="width: 213px">
                                   מיקוד</td>
                               <td style="width: 213px; ">
                                   <asp:TextBox ID="TBFAMZIP" runat="server" OnTextChanged="TextBox11_TextChanged"
                                       Width="70px" Text='<%# Bind("CustFamilyZioCode") %>' TabIndex="440"></asp:TextBox>
                                   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="TBFAMZIP"
                                       Display="Dynamic" ErrorMessage="מיקוד חייב להיות מספר בן 5 ספרות" MaximumValue="99999"
                                       MinimumValue="10000" Type="Integer" Width="179px"></asp:RangeValidator></td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" rowspan="1" style="height: 26px" >
                                   מבטח רפואי</td>
                               <td style="width: 197px; height: 26px;">
                                   <asp:DropDownList ID="DDLMEDCARE" runat="server" AppendDataBoundItems="True" DataSourceID="DSMEDCARE" DataTextField="CustMedCareName" DataValueField="CustMedCareID" TabIndex="66" SelectedValue='<%# Bind("CustMedCareID") %>'>
                                       <asp:ListItem  Value="" Selected="True">&lt;בחר מבטח רפואי&gt;</asp:ListItem>
                                   </asp:DropDownList></td>
                               <td style="width: 290px; height: 26px;">
                               </td>
                               <td style="width: 100px; height: 26px;">
                               </td>
                               <td bgcolor="#37a5ff" style="width: 112px; height: 26px;">
                                   טלפון</td>
                               <td style="width: 39px; height: 26px;">
                                   <asp:TextBox ID="TBAPTPHONE" runat="server" Text='<%# Bind("CustApotroposPhone") %>'
                                       Width="100px" TabIndex="300"></asp:TextBox></td>
                               <td bgcolor="#37a5ff" style="width: 213px; height: 26px;">
                                   טלפון</td>
                               <td style="width: 213px; height: 26px;">
                                   <asp:TextBox ID="TBFAMPHONE" runat="server" Width="100px" Text='<%# Bind("CustFamilyphone") %>' TabIndex="450"></asp:TextBox></td>
                           </tr>
                            <tr>
                                <td bgcolor="#37a5ff" rowspan="2" style="width: 113px">
                                    כתובת</td>
                                <td style="height: 26px" >
                                    <asp:TextBox ID="TBCUSTAD1" runat="server" TabIndex="70" Text='<%# Bind("CustomerAddress1") %>' Width="160px"></asp:TextBox></td>
                                <td style="height: 26px" >
                                </td>
                                <td style="height: 26px; width: 100px;" >
                                </td>
                               <td bgcolor="#37a5ff" style="width: 112px; height: 26px;">
                                   פקס</td>
                               <td style="width: 39px; height: 26px;">
                                   <asp:TextBox ID="TBAPTFAX" runat="server" TabIndex="310" Text='<%# Bind("CustApotroposFax") %>'
                                       Width="100px"></asp:TextBox></td>
                               <td bgcolor="#37a5ff" style="width: 213px; height: 26px;">
                                   פקס</td>
                               <td style="width: 213px; height: 26px;">
                                   <asp:TextBox ID="TBFAMFAX" runat="server" Width="100px" Text='<%# Bind("CustFamilyFax") %>' TabIndex="460"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td style="height: 26px">
                                    <asp:TextBox ID="TBCUSTAD2" runat="server" TabIndex="80" Text='<%# Bind("CustomerAddress2") %>' Width="160px" OnTextChanged="TBAD2_TextChanged"></asp:TextBox></td>
                                <td style="height: 26px">
                                </td>
                                <td style="width: 100px; height: 26px;">
                                </td>
                                <td bgcolor="#37a5ff" style="width: 112px; height: 26px;">
                                    טלפון סלולרי</td>
                                    <td style="width: 39px; height: 26px;" >
                                        <asp:TextBox ID="TBAPTCELL1" runat="server" TabIndex="320" Text='<%# Bind("CustApotroposCell1") %>'
                                            Width="100px"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" style="height: 26px" >
                                    טלפון סלולרי</td>
                                <td style="height: 26px">
                                    <asp:TextBox ID="TBFAMCELL1" runat="server" Width="100px" Text='<%# Bind("CustFamilyCell1") %>' TabIndex="470"></asp:TextBox></td>
                            </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px; ">
                                   עיר</td>
                               <td style="height: 6px">
                                   <asp:TextBox ID="TBCUSTCITY" runat="server" TabIndex="90" AutoCompleteType="Search" Text='<%# Bind("CustomerCity") %>'></asp:TextBox></td>
                               <td style="height: 6px">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="TBCUSTCITY"
                                        Display="Dynamic" ErrorMessage="חובה לבחור עיר" Enabled='<%# int(Session("ServiceID"))<>5 %>'  Width="93px"></asp:RequiredFieldValidator></td>
                               <td style="width: 100px; ">
                               </td>
                                <td bgcolor="#37a5ff" style="width: 112px">
                                    טלפון סלולרי</td>
                                    <td style="width: 39px">
                                        <asp:TextBox ID="TBAPTCELL2" runat="server" TabIndex="330" Text='<%# Bind("CustApotroposCell2") %>'
                                            Width="100px"></asp:TextBox></td>
                                <td bgcolor="#37a5ff" style="width: 213px">
                                    טלפון סלולרי</td>
                                <td style="width: 213px">
                                    <asp:TextBox ID="TBFAMCELL2" runat="server" Width="100px" Text='<%# Bind("CustFamilyCell2") %>' TabIndex="480"></asp:TextBox></td>
                           </tr>
                           <tr>
                               <td style="width: 113px; " bgcolor="#37a5ff">
                                   מיקוד</td>
                               <td style="width: 197px; ">
                                    <asp:TextBox ID="TBCUSTZIP" runat="server" Width="57px" TabIndex="120" Text='<%# Bind("CustomerZipCode") %>'></asp:TextBox></td>
                               <td style="width: 290px; ">
                                   &nbsp;<asp:RangeValidator ID="RangeValidator6" runat="server" ControlToValidate="TBCUSTZIP"
                                        Display="Dynamic" ErrorMessage="מיקוד חייב להיות מספר בן 5 ספרות" Type="Integer" MaximumValue="99999" MinimumValue="10000" Width="183px"></asp:RangeValidator></td>
                               <td style="width: 100px; "></td>
                               <td style="width: 112px; " bgcolor="#37a5ff">
                                   דוא"ל</td>
                                   <td style="width: 39px; ">
                                   <asp:TextBox ID="TBAPTEMAIL" runat="server" Text='<%# Bind("CustApotroposEmail") %>'
                                       Width="160px" TabIndex="340"></asp:TextBox>
                                       <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="TBAPTEMAIL"
                                           Display="Dynamic" ErrorMessage="כתובת אי-מייל לא חוקית" SetFocusOnError="True"
                                           ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Width="160px"></asp:RegularExpressionValidator></td>
                               <td bgcolor="#37a5ff" style="width: 213px; ">
                                   דוא"ל</td>
                               <td style="width: 213px; ">
                                   <asp:TextBox ID="TBFAMEMAIL" runat="server" Width="160px" Text='<%# Bind("CustFamilyEmail") %>' TabIndex="490"></asp:TextBox>
                                   <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ControlToValidate="TBFAMEMAIL"
                                       Display="Dynamic" ErrorMessage="כתובת אי-מייל לא חוקית" SetFocusOnError="True"
                                       ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px; height: 26px;">
                                   טלפון</td>
                               <td style="width: 197px; height: 26px;">
                                   <asp:TextBox ID="TBCUSTPHONE" runat="server" Text='<%# Bind("CustomerPhone") %>' Width="98px" TabIndex="130"></asp:TextBox></td>
                               <td style="width: 290px; height: 26px;">
                                    </td>
                               <td style="width: 100px; height: 26px;">
                               </td>
                               <td style="width: 112px; height: 26px;" bgcolor="#37a5ff">
                               </td>
                               <td style="height: 26px;" bgcolor="#37a5ff" colspan="3">
                                   הערות / מידע נוסף</td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px; height: 24px;">
                                   טלפון סלולרי</td>
                               <td style="width: 197px; height: 24px;">
                                   <asp:TextBox ID="TBCUSTCELL1" runat="server" Width="98px" Text='<%# Bind("CustomerCell1") %>' TabIndex="140"></asp:TextBox></td>
                               <td style="width: 290px; height: 24px;">
                                   </td>
                               <td style="width: 100px; height: 24px;">
                               </td>
                               <td style="width: 112px; height: 24px;" bgcolor="#37a5ff">
                               </td>
                               <td colspan="3" rowspan="3">
                                   <asp:TextBox ID="TextBox1" runat="server" Height="75px" Text='<%# Bind("CustAddInfo") %>'
                                       TextMode="MultiLine" Width="420px"></asp:TextBox>
                               </td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff" style="width: 113px; height: 26px;">
                                   טלפון סלולרי</td>
                               <td style="width: 197px; height: 26px;">
                                   <asp:TextBox ID="TBCUSTCELL2" runat="server" Width="98px" Text='<%# Bind("CustomerCell2") %>' TabIndex="150"></asp:TextBox></td>
                               <td style="width: 290px; height: 26px;">
                               </td>
                               <td style="width: 100px; height: 26px;">
                               </td>
                               <td style="width: 112px; height: 26px;" bgcolor="#37a5ff">
                               </td>
                           </tr>
                           <tr>
                               <td bgcolor="#37a5ff">
                                   דוא"ל</td>
                               <td>
                                   <asp:TextBox ID="TBCUSTEMAIL" runat="server" Width="160px" Text='<%# Bind("CustomerEmail") %>' TabIndex="160"></asp:TextBox><asp:RegularExpressionValidator
                                       ID="RegularExpressionValidator1" runat="server" ControlToValidate="TBCUSTEMAIL"
                                       Display="Dynamic" ErrorMessage="כתובת אי-מייל לא חוקית" SetFocusOnError="True"
                                       ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
                               <td>
                                   <asp:Label ID="LBRowID" runat="server" Text='<%# Eval("RowID") %>' Visible="False"></asp:Label></td>
                               <td>
                               </td>
                               <td bgcolor="#37a5ff">
                                   <asp:Label ID="Label2" runat="server" Width="68px"></asp:Label></td>
                           </tr>
                        </table>
                       <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text='<%#if(request.querystring("CAND")=1,"עדכון והוספה למועמדים","עדכון") %>' TabIndex="30"></asp:LinkButton>
                        &nbsp; &nbsp;&nbsp;
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="עבור לרשימת הלקוחות" PostBackUrl="~/CustomerList.aspx" TabIndex="32"></asp:LinkButton>
                        &nbsp; &nbsp; &nbsp;<asp:LinkButton ID="LNKBMANAGE" runat="server" CausesValidation="False" CommandName="Cancel"
                            PostBackUrl='<%#if(request.querystring("CAND")=1,"~/EDU.aspx","~/CustEventReport.aspx") %>' Text='<%#if(request.querystring("CAND")=1,"עבור לניהול מועמדים","עבור לניהול תיקי לקוחות") %>' TabIndex="34"></asp:LinkButton>
                        &nbsp; &nbsp; &nbsp; &nbsp;
                        <asp:Label ID="Label7" runat="server" Text="עדכון אחרון ב " Width="72px"></asp:Label><asp:Label ID="Label5" runat="server" Text='<%# Eval("UpdateDate", "{0:dd/MM/yy}") %>'
                                       Width="55px"></asp:Label><asp:Label
                                ID="Label8" runat="server" Text="על ידי" Width="35px"></asp:Label><asp:Label ID="Label6" runat="server" Text='<%# Eval("UserName") %>' Width="87px"></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                    </InsertItemTemplate>
                </asp:FormView>
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:SqlDataSource ID="DSCutomers" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        DeleteCommand="DELETE FROM [CustomerList] WHERE [RowID] = @RowID" InsertCommand="INSERT INTO [CustomerList] ([CustomerID], [CustFirstName], [CustLastName], [CustBirthDate], [CustOriginOfficeID], [CustApotropos1ID], [CustApotroposID2], [CustGender]) VALUES (@CustomerID, @CustFirstName, @CustLastName, @CustBirthDate, @CustOriginOfficeID, @CustApotropos1ID, @CustApotroposID2, @CustGender)"
        
        SelectCommand="SELECT c.*,u.UserName FROM [CustomerList] c LEFT OUTER JOIN P0t_NTB u ON u.UserId=c.UserID &#13;&#10;Where (c.RowID=@RowID) OR (c.CustomerID=@CustomerID)&#13;&#10;ORDER BY c.[CustLastName]" 
        UpdateCommand="UPDATE CustomerList SET CustomerID = @CustomerID, CustFirstName = @CustFirstName, CustLastName = @CustLastName, CustBirthDate = @CustBirthDate, CustGender = @CustGender, CustMedCareID = @CustMedCareID, CustApotroposName = @CustApotroposname, CustApotroposAddress1 = @CustApotroposAddress1, CustApotroposAddress2 = @CustApotroposAddress2, CustApotroposPhone = @CustApotroposPhone, CustApotroposFax = @CustApotroposFax, CustomerAddress1 = @CustomerAddress1, CustomerAddress2 = @CustomerAddress2, CustomerCity = @CustomerCity, CustomerZipCode = @CustomerZipCode, CustomerPhone = @CustomerPhone, CustApotroposCity = @CustApotroposCity, CustApotroposZipcode = @CustApotroposZipCode, CustOriginOfficeTypeID = @CustOriginOfficeTypeID, CustOriginOfficeCity = @CustOriginOfficeCity, CustoriginofficeName = @CustOriginOfficeName, CustomerFax = @CustomerFax, CustomerCell1 = @CustomerCell1, CustomerCell2 = @CustomerCell2, CustomerEmail = @CustomerEmail, CustApotroposCell1 = @CustApotroposCell1, CustApotroposCell2 = @CustApotroposCell1, CustApotroposEmail = @CustApotroposEmail, CustFamilyName = @CustFamilyName, CustFamilyAddress1 = @CustFamilyAddress1, CustFamilyAddress2 = @CustFamilyAddress2, CustFamilyZioCode = @CustFamilyZioCode, CustFamilyCity = @CustFamilyCity, CustFamilyphone = @CustFamilyphone, CustFamilyFax = @CustFamilyFax, CustFamilyCell1 = @CustFamilyCell1, CustFamilyCell2 = @CustFamilyCell2, CustFamilyEmail = @CustFamilyEmail, UpdateDate = GETDATE(), UserID = @UserID, CustAddInfo = @CustAddInfo, CustApotroposTypeID = @CustApotroposTypeID WHERE (RowID = @RowID)" 
        CancelSelectOnNullParameter="False">
        <DeleteParameters>
            <asp:Parameter Name="RowID" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="CustomerID" Type="Int64" />
            <asp:Parameter Name="CustFirstName" Type="String" />
            <asp:Parameter Name="CustLastName" Type="String" />
            <asp:Parameter Name="CustBirthDate" Type="DateTime" />
            <asp:Parameter Name="CustGender" Type="Int32" />
            <asp:Parameter Name="CustMedCareID" />
            <asp:Parameter Name="CustApotroposname" Type="String" />
            <asp:Parameter Name="CustApotroposAddress1" Type="String" />
            <asp:Parameter Name="CustApotroposAddress2" Type="String" />
            <asp:Parameter Name="CustApotroposPhone" Type="String" />
            <asp:Parameter Name="CustApotroposFax" Type="String" />
            <asp:Parameter Name="CustomerAddress1" />
            <asp:Parameter Name="CustomerAddress2" />
            <asp:Parameter Name="CustomerCity" />
            <asp:Parameter Name="CustomerZipCode" />
            <asp:Parameter Name="CustomerPhone" />
            <asp:Parameter Name="CustApotroposCity" />
            <asp:Parameter Name="CustApotroposZipCode" />
            <asp:Parameter Name="CustOriginOfficeTypeID" />
            <asp:Parameter Name="CustOriginOfficeCity" />
            <asp:Parameter Name="CustOriginOfficeName" />
            <asp:Parameter Name="CustomerFax" />
            <asp:Parameter Name="CustomerCell1" />
            <asp:Parameter Name="CustomerCell2" />
            <asp:Parameter Name="CustomerEmail" />
            <asp:Parameter Name="CustApotroposCell1" />
            <asp:Parameter Name="CustApotroposEmail" />
            <asp:Parameter Name="CustFamilyName" />
            <asp:Parameter Name="CustFamilyAddress1" />
            <asp:Parameter Name="CustFamilyAddress2" />
            <asp:Parameter Name="CustFamilyZioCode" />
            <asp:Parameter Name="CustFamilyCity" />
            <asp:Parameter Name="CustFamilyphone" />
            <asp:Parameter Name="CustFamilyFax" />
            <asp:Parameter Name="CustFamilyCell1" />
            <asp:Parameter Name="CustFamilyCell2" />
            <asp:Parameter Name="CustFamilyEmail" />
            <asp:SessionParameter Name="UserID" SessionField="UserID"/>
            <asp:Parameter Name="CustAddInfo" />
            <asp:Parameter Name="CustApotroposTypeID" />
            <asp:Parameter Name=RowID />
        </UpdateParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="RowID" QueryStringField="RowID" />
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CustomerID" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="CustomerID" />
            <asp:Parameter Name="CustFirstName" />
            <asp:Parameter Name="CustLastName" />
            <asp:Parameter Name="CustBirthDate" />
            <asp:Parameter Name="CustOriginOfficeID" />
            <asp:Parameter Name="CustApotropos1ID" />
            <asp:Parameter Name="CustApotroposID2" />
            <asp:Parameter Name="CustGender" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSOriginOffice" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [CustOriginOfficeTypeName], [CustOriginOfficeTypeID] FROM [CustOriginOfficeTypes]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSApotroposType" runat="server" ConnectionString="<%$ ConnectionStrings:BEBook10 %>"
        SelectCommand="SELECT [CustApotroposTypeName], [CustApotroposTypeID] FROM [CustApotroposTypes]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="DSMEDCARE" runat="server" ConnectionString="<%$ ConnectionStrings:bebook10 %>"
        SelectCommand="SELECT [CustMedCareName], [CustMedCareID] FROM [CustMedCare]"></asp:SqlDataSource>
</asp:Content>

