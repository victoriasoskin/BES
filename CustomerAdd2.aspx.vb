Imports System.Data.SqlClient
Imports MessageBox
Partial Class CustomerAdd2
    Inherits System.Web.UI.Page
    Dim bEvent As Boolean = False

    Protected Sub TextBox1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not IsNumeric(Session("ServiceID")) Then
			Response.Redirect("ErrMessage.aspx?m=אין למשתמש זה אפשרות להוסיף לקוחות, משום שאינו מוגדר כשייך למסגרת")
		End If
		Dim i As Integer = Session("ServiceID")
		On Error Resume Next
		Dim j As Integer = Request.QueryString("CAND")
		If Err.Number = 0 And j = 1 Then
			LBLHDR.Text = Replace(LBLHDR.Text, "לקוח", "מועמד")
			Dim fv As FormView = FormView1
			Dim btn As Button = CType(fv.FindControl("BTNCOPYCUSTTOAPT"), Button)
			btn.Text = Replace(btn.Text, "לקוח", "מועמד")
			Dim lbl As Label = CType(fv.FindControl("LBLADDRESSHDR"), Label)
			lbl.Text = Replace(lbl.Text, "לקוח", "מועמד")
			lbl = CType(fv.FindControl("LBLHD1"), Label)
			lbl.Text = Replace(lbl.Text, "לקוח", "מועמד")
			Dim lnkb As LinkButton = CType(fv.FindControl("InsertCancelButton"), LinkButton)
			lnkb.Visible = False
			lnkb = CType(fv.FindControl("LnkBADDNGO"), LinkButton)
			lnkb.Text = "הוספה ומעבר לניהול מועמדים"
			Page.Title = Replace(Page.Title, "לקוח", "מועמד")
			lnkb = CType(fv.FindControl("InsertButton"), LinkButton)
			lnkb.Visible = False
		Else
			Err.Clear()
		End If
	End Sub

    Protected Sub TBID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim fv As FormView = CType(tb.NamingContainer, FormView)
        Dim cv As CustomValidator = CType(fv.FindControl("CVID"), CustomValidator)
        Dim rfv As RequiredFieldValidator = CType(fv.FindControl("RFVID"), RequiredFieldValidator)
        Dim tb1 As TextBox = CType(fv.FindControl("TBLastName"), TextBox)

        Dim l As Int64 = Val(tb.Text)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select CustomerID,RowID From CustomerList Where CustomerID=" & l, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        Dim s As String = dr("CustomerID")
        If Err.Number = 0 Then
            Dim ir As Integer = dr("RowID")
            If Request.QueryString("CAND") = "1" Then Response.Redirect("CustomerUpd2.aspx?CAND=1&RowID=" & ir) Else Response.Redirect("CustomerUpd2.aspx?RowID=" & ir)
            cv.ErrorMessage = "המספר " + tb.Text + " כבר קיים במערכת"
            rfv.ErrorMessage = "המספר " + tb.Text + " כבר קיים במערכת"
            cv.IsValid = False
            tb.Text = vbNullString
            tb.Focus()
        Else
            Session("LastCustID") = tb.Text
            Err.Clear()
            tb.Focus()
        End If
        dbConnection.Close()
    End Sub

    Protected Sub ListBox1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lsb As ListBox = CType(sender, ListBox)

    End Sub

    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TextBox11_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBAD2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBAPTAD1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBORIGINCITY_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim fv As FormView = CType(ddl.NamingContainer, FormView)
        If ddl.SelectedValue <> vbNullString Then
            Dim i As Integer = ddl.SelectedValue
            ddl = CType(fv.FindControl("DDLCUSTCITY"), DropDownList)
            If ddl.SelectedValue = vbNullString Then
                ddl.SelectedValue = i
            End If
        End If
    End Sub

    Protected Sub BTNCOPYCUSTTOAPT_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        'Dim ddl As DropDownList = CType(fv.FindControl("DDLCUSTCITY"), DropDownList)
        'If ddl.SelectedValue <> vbNullString Then
        '    i = ddl.SelectedValue
        '    ddl = CType(fv.FindControl("DDLAPTCITY"), DropDownList)
        '    ddl.SelectedValue = i
        'End If

        Dim tbS As TextBox = CType(fv.FindControl("TBCUSTAD1"), TextBox)
        Dim tbT As TextBox = CType(fv.FindControl("TBAPTAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTCity"), TextBox)
        tbT = CType(fv.FindControl("TBAPTCity"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTAD1"), TextBox)
        tbT = CType(fv.FindControl("TBAPTAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTAD2"), TextBox)
        tbT = CType(fv.FindControl("TBAPTAD2"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTAD1"), TextBox)
        tbT = CType(fv.FindControl("TBAPTAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTZIP"), TextBox)
        tbT = CType(fv.FindControl("TBAPTZIP"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTPHONE"), TextBox)
        tbT = CType(fv.FindControl("TBAPTPHONE"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTCELL1"), TextBox)
        tbT = CType(fv.FindControl("TBAPTCELL1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTCELL2"), TextBox)
        tbT = CType(fv.FindControl("TBAPTCELL2"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBCUSTEMAIL"), TextBox)
        tbT = CType(fv.FindControl("TBAPTEMAIL"), TextBox)
        tbT.Text = tbS.Text

    End Sub

    Protected Sub BTNCOPYAPTTOFAM_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        'Dim ddl As DropDownList = CType(fv.FindControl("DDLAPTCITY"), DropDownList)
        'If ddl.SelectedValue <> vbNullString Then
        '    i = ddl.SelectedValue
        '    ddl = CType(fv.FindControl("DDLFAMCITY"), DropDownList)
        '    ddl.SelectedValue = i
        'End If

        Dim tbS As TextBox = CType(fv.FindControl("TBAPTAD1"), TextBox)
        Dim tbT As TextBox = CType(fv.FindControl("TBFAMAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTCITY"), TextBox)
        tbT = CType(fv.FindControl("TBFAMCITY"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTNAME"), TextBox)
        tbT = CType(fv.FindControl("TBFAMNAME"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTAD1"), TextBox)
        tbT = CType(fv.FindControl("TBFAMAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTAD2"), TextBox)
        tbT = CType(fv.FindControl("TBFAMAD2"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTAD1"), TextBox)
        tbT = CType(fv.FindControl("TBFAMAD1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTZIP"), TextBox)
        tbT = CType(fv.FindControl("TBFAMZIP"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTPHONE"), TextBox)
        tbT = CType(fv.FindControl("TBFAMPHONE"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTFAX"), TextBox)
        tbT = CType(fv.FindControl("TBFAMFAX"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTCELL1"), TextBox)
        tbT = CType(fv.FindControl("TBFAMCELL1"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTCELL2"), TextBox)
        tbT = CType(fv.FindControl("TBFAMCELL2"), TextBox)
        tbT.Text = tbS.Text

        tbS = CType(fv.FindControl("TBAPTEMAIL"), TextBox)
        tbT = CType(fv.FindControl("TBFAMEMAIL"), TextBox)
        tbT.Text = tbS.Text

    End Sub

    Protected Sub DDLORIGINOFFICE_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBORIGINOFFICECITY_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim fv As FormView = CType(tb.NamingContainer, FormView)
        Dim s As String = tb.Text
        tb = CType(fv.FindControl("tbCUSTCITY"), TextBox)
        'tb.Text = s
        tb = CType(fv.FindControl("TBORIGINNAME"), TextBox)
        tb.Focus()
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        bEvent = True
    End Sub

    Protected Sub DSCutomers_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSCutomers.Inserted
        If bEvent Then
            On Error Resume Next
            Dim j As Integer = Request.QueryString("CAND")
            If Err.Number = 0 And j = 1 Then
                Response.Redirect("~/EDU.aspx")
            Else
                Err.Clear()
                Response.Redirect("~/CustEventReport.aspx")
            End If
        End If
        bEvent = False
    End Sub

 End Class
