<%@ Page Title="" Language="VB" MasterPageFile="~/Sherut.master" AutoEventWireup="false" CodeFile="SurveyRep.aspx.vb" Inherits="Default4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
	
	<asp:Button ID="Button2" runat="server" Height="31px" Text="הצג גרף" />
	
	<asp:Button ID="Button1" runat="server" Text="הצג דוח" />
	<asp:GridView ID="GVREP" runat="server">
	</asp:GridView>
	    
     <asp:Chart ID="ChrtG" runat="server" Visible="False" Width="700px" Height="200"  
         RightToLeft="Yes"> 
       <Series> 
       </Series> 
        <ChartAreas> 
          <asp:ChartArea Name="MainChartArea"> 
         
          </asp:ChartArea> 
       </ChartAreas> 
    </asp:Chart> 
    
        
</asp:Content>

