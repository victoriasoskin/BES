Imports System.Data.SqlClient
Imports PageErrors
Partial Class CustomerAdd2
    Inherits System.Web.UI.Page

    Protected Sub TextBox1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim fv As FormView = CType(tb.NamingContainer, FormView)
        Dim cv As CustomValidator = CType(fv.FindControl("CVID"), CustomValidator)
        Dim rfv As RequiredFieldValidator = CType(fv.FindControl("RFVID"), RequiredFieldValidator)
        Dim lb As Label = CType(fv.FindControl("LBRowID"), Label)
        Dim i As Integer = Val(lb.Text)
        Dim l As Int64 = Val(tb.Text)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select RowID,CustomerID From CustomerList Where CustomerID=" & l, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        Dim s As String = dr("RowID")
        If Err.Number = 0 Then
            If i <> Val(s) Then
                cv.ErrorMessage = "המספר " + tb.Text + " כבר קיים ברשומת לקוח אחר במערכת"
                rfv.ErrorMessage = "המספר " + tb.Text + " כבר קיים ברשומת לקוח אחר במערכת"
                cv.IsValid = False
                tb.Text = vbNullString
                tb.Focus()
            End If
        Else
            Err.Clear()
        End If
        dbConnection.Close()

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

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
        tb.Text = s
        tb = CType(fv.FindControl("TBORIGINNAME"), TextBox)
        tb.Focus()
    End Sub
    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TextBox11_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBAD2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub TBAPTAD1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub FormView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView1.DataBound
        Dim fv As FormView = CType(sender, FormView)
        Dim tb As TextBox = CType(fv.FindControl("TBID"), TextBox)
        Session("lastCustID") = tb.Text

    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		If Not IsNumeric(Session("ServiceID")) Then
			Response.Redirect("ErrMessage.aspx?m=אין למשתמש זה אפשרות לעדכן נתוני לקוחות, משום שאינו מוגדר כשייך למסגרת")
        End If
        If Request.QueryString("CAND") = "1" Then
            LBLHDR.Text = "עדכון מועמד"

        End If

	End Sub
End Class
