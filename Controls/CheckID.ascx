<%@ Control Language="VB" AutoEventWireup="false" CodeFile="CheckID.ascx.vb" Inherits="Controls_CheckID" %>
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
<div>
    <asp:UpdatePanel runat="server" ID="zzzUPD" UpdateMode="Conditional" ><ContentTemplate>
     <asp:TextBox ID="zzztbid" runat="server" AutoPostBack="true" CausesValidation="true" ValidationGroup="zzzCheckID" Width="120px" BackColor="White" />
        <asp:Button ID="zzzbtnShwrec" runat="server" Text="הצג" ForeColor="Red" Visible="false" CausesValidation="false"  />
			<asp:CustomValidator ID="zzzcvid" runat="server" ClientValidationFunction="ValidID" ForeColor="Red"
				ControlToValidate="zzztbid" Display="Dynamic" 
				ErrorMessage="מספר תעודת זהות לא חוקי" SetFocusOnError="true" ValidationGroup="zzzCheckID" EnableClientScript="true"  />
	 <asp:CustomValidator ID="zzzCVEMPIDU" runat="server" ControlToValidate="zzztbid"  OnServerValidate="zzzCVEMPIDU_validate" ForeColor="Red"
											    Display="Dynamic" ErrorMessage="תעודת הזהות כבר קיימת ברשימה" SetFocusOnError="true" ValidationGroup="zzzCheckID"  />
										    <asp:RequiredFieldValidator ID="zzzrfvid" runat="server" ForeColor="Red"
											    ControlToValidate="zzztbid" Display="Dynamic" 
											    ErrorMessage="חובה להקיש תעודת זהות" ValidationGroup="zzzCheckID" />
    <asp:ValidationSummary runat="server" ID="zzzvs" ShowMessageBox="true" ShowSummary="false" ForeColor="Red" OnPreRender="zzzvs_PreRender" ValidationGroup="zzzCheckID" />
    </ContentTemplate></asp:UpdatePanel>
</div>