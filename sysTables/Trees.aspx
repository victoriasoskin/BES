<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="Trees.aspx.vb" Inherits="Trees" MaintainScrollPositionOnPostback="true" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	<style type="text/css">
		.style1
		{
			width: 100%;
		}
		.style2
		{
			width: 209px;
		}
	</style>
	<div>
	<asp:Label runat="server" ID="lblhdr" Text="ניהול עץ סעיפים"  Font-Bold="True" 
			Font-Size="X-Large" ForeColor="Blue" />
</div>
<div>
	
<table class="style1">
<tr>
<td class="style2">
	<asp:DropDownList ID="DDLTREES" runat="server" AutoPostBack="True" 
		DataSourceID="XDSTrees" DataTextField="Name" DataValueField="FID">
	</asp:DropDownList>
	<div runat="server" id="divNewFile" style="border">
		<br />
		<table border="1">
			<tr>
				<td colspan="3">
					<asp:Label ID="Label1" runat="server" Text="הגדרת עץ חדש: "></asp:Label>
				</td>
			</tr>
			<tr>
				<td>
					<asp:Label ID="Label2" runat="server" Text="שם העץ: "></asp:Label>
				</td>
				<td>
					<asp:TextBox runat="server" id="TBNEWNAME" ></asp:TextBox>
				</td>
				<td>
					<asp:Button ID="BTNNEWTREE" runat="server" Text="שמור" />
				</td>
			</tr>
		</table>
	</div>
	<asp:XmlDataSource ID="XDSTrees" runat="server" 
		DataFile="~/App_Data/TreesDef.xml"></asp:XmlDataSource>
</td>
<td>
</td>
</tr>
<tr>
	<td class="style2">
		<div runat="server" id="divtree">
				<table class="style1">
					<tr>
						<td>
							<asp:TextBox ID="TbAddNode" runat="server" Visible="False"></asp:TextBox>
						</td>
						<td>
							<asp:Button ID="BTNADDCHILD" runat="server" Text="/+" 
							ToolTip="הוספת סעיף בן לסעיף הנבחר" />
						</td>
						<td>
							<asp:Button ID="BTNADDBLOW" runat="server" Text="|+" 
							ToolTip="הוספת סעיף ברמה הנוכחית מתחת לסעיף הנבחר" CausesValidation="true" />
						</td>
						<td>
						<asp:Button ID="BTNRMVNODE" runat="server" Text="X " 
							ToolTip="מחיקת הסעיף וכל הסעיפים מתחתיו" 
							onclientclick="return confirm('האם למחוק את ההסעיף וכל בניו?');" />
						</td>
						<td>
							<asp:Button ID="BYNMOVEUP" runat="server" Text="^ " ToolTip="הזז אחד למעלה" />
						</td>
						<td>
							<asp:Button ID="BTNMOVEDOWN" runat="server" Text="v" ToolTip="הזז אחד למטה " 
								Font-Size="X-Small" />
						</td>
						<td>
							<asp:Button ID="BTNUPPERLEVEL" runat="server" Text="&lt;" 
							ToolTip="העלה את הסעיף ובניו רמה אחת למעלה" />
						</td>
						<td>
							<asp:Button ID="BTNLOWERLEVEL" runat="server" Text="&gt;" 
							ToolTip="הורד רמה אחת" />
						</td>
						<td>
							<asp:TextBox ID="TBEditNode" runat="server" Visible="False"></asp:TextBox>
						</td>
						<td>
							<asp:Button ID="BTNEDITNODE" runat="server" style="height: 26px" Text="E" 
							ToolTip="עריכת הסעיף הנבחר" />
						</td>
						<td>
						&nbsp;</td>
						</tr>
					</table>
			</div>
	</td>
			<td>
			</td>
		</tr>
		<tr>
			<td class="style2">
			  <asp:Panel runat="server" Height="50%" Width="300" ScrollBars="Auto">
				<div runat="server" id="divlvq" style="vertical-align:top">
					<asp:Label ID="CVVT" runat="server" ForeColor="Red" 
						Text="הטקסט כבר קיים בקבוצה זו" Visible="False"></asp:Label>
					<asp:Button ID="Button1" runat="server" Text="הפצה לבסיס הנתונים" />
					<asp:Label ID="LBLERRWRITE" runat="server" ForeColor="Red" 
						Text="שגיאה בעדכון השורה. נא סגור את האקספורר ונסה שנית." Visible="False"></asp:Label>
					<asp:XmlDataSource ID="XDT" runat="server" EnableCaching="false" >
					</asp:XmlDataSource>
							<asp:TreeView ID="XD" runat="server" DataSourceID="XDT" ShowLines="true" LineImagesFolder="~/TreeImages" ShowCheckBoxes="None">
							<DataBindings>
								<asp:TreeNodeBinding TextField="Text" ValueField="ID" />
							</DataBindings>
							<SelectedNodeStyle BackColor="LightBlue" />
							</asp:TreeView>
				</div>
			</asp:Panel>
			</td>
			<td>
				&nbsp;</td>
		</tr>
	</table>

</div>
</asp:Content>