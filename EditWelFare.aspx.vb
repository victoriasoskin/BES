Imports CKEditor.NET
Imports System.Data.SqlClient
Partial Class EditWelFare
    Inherits System.Web.UI.Page

    Protected Sub btnedit_Click(sender As Object, e As System.EventArgs)
        'Dim btn As Button = CType(sender, Button)
        'Dim sID = Mid(btn.ID, InStr(btn.ID, "_"))
        'Dim lbl As Label = CType(divTBL.FindControl("lblText" & sID), Label)

        'If btn.Text = "ערוך" Then
        '    If sID.ToLower = "_header" Then 
        '        cke_Header.Visible = True
        '        cke_Header.Text = lbl.Text
        '    Else
        '        cke_Footer.Visible = True
        '        cke_Footer.Text = lbl.Text
        '    End If
        '    lbl.Visible = False
        '    btn.Text = "שמור"
        'Else
        '    lbl.Visible = True
        '    If sID.ToLower = "_header" Then
        '        lbl.Text = cke_Header.Text
        '        cke_Header.Visible = False
        '        SavePage("OP_Header", lbl.Text)
        '    Else
        '        lbl.Text = cke_Footer.Text
        '        cke_Footer.Visible = False
        '        SavePage("OP_Footer", lbl.Text)
        '    End If
        '    btn.Text = "ערוך"
        'End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Session("pwbe") = "1234"
        Response.Redirect("WelfareZbuy_1.aspx?OP=2&AG=True")
        'If Not IsPostBack Then
        '    If Request.QueryString("op") <> vbNullString Then
        '        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '        Dim cD As New SqlCommand("SELECT OP_Header,OP_Footer,btnOrdText FROM WelFareOps Where OpID = " & Request.QueryString("OP"), dbConnection)
        '        cD.CommandType = Data.CommandType.Text
        '        dbConnection.Open()
        '        Dim dr As SqlDataReader = cD.ExecuteReader
        '        If dr.Read Then
        '            If Not IsDBNull(dr("OP_Header")) Then lblText_HEADER.Text = dr("OP_Header")
        '            If Not IsDBNull(dr("OP_Footer")) Then lblText_FOOTER.Text = dr("OP_Footer")
        '            If Not IsDBNull(dr("btnOrdText")) Then btnord.Text = dr("btnOrdText")
        '        End If
        '        dr.Close()
        '        dbConnection.Close()
        '    End If
        'End If
    End Sub
    Sub SavePage(sF As String, sText As String)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Update WelFareOps set " & sF & " = '" & sText.Replace("'", "''") & "' Where OpID = " & Request.QueryString("OP"), dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        cD.ExecuteNonQuery()
        dbConnection.Close()
    End Sub
    Protected Sub cbAgreerequired_Prerender(sender As Object, e As System.EventArgs)
        If Not IsPostBack Then
            Dim cb As CheckBox = CType(sender, CheckBox)
            cb.Visible = Request.QueryString("AG") = "True"
        End If
    End Sub
    Protected Sub cbAgreerequiredflag_Prerender(sender As Object, e As System.EventArgs)
        If Not IsPostBack Then
            Dim cb As CheckBox = CType(sender, CheckBox)
            cb.Checked = Request.QueryString("AG") = "True"
        End If
    End Sub

    'Protected Sub btnHideEdit_Click(sender As Object, e As System.EventArgs) Handles btnHideEdit.Click
    '    Dim btn As Button = CType(sender, Button)
    '    If btn.text = "הסתר עמוד עריכה" Then
    '        btnedit_HEADER.Visible = Not btnedit_HEADER.Visible
    '        btnedit_FOOTER.Visible = Not btnedit_FOOTER.Visible
    '    End If
    'End Sub

    Protected Sub btnAgree_Click(sender As Object, e As System.EventArgs) Handles btnAgree.Click
        Dim btn As Button = CType(sender, Button)
        If btn.Text = "ערוך" Then
            cbAgreeRequiredflag.Visible = True
            cbAgreeRequiredflag.Checked = Request.QueryString("AG") = "True"
            btn.Text = "שמור"
        Else
            Dim b As Boolean = cbAgreeRequiredflag.Checked
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("Update WelFareOps set AgreeRequired = " & If(b, "1", "0") & " Where OpID = " & Request.QueryString("OP"), dbConnection)
            cD.CommandType = Data.CommandType.Text
            dbConnection.Open()
            cD.ExecuteNonQuery()
            dbConnection.Close()
            Response.Redirect("EditWelfare.aspx?OP=" & Request.QueryString("OP") & "&AG=" & If(b, "True", "False"))
        End If
    End Sub

    Protected Sub btnOKTexts_Click(sender As Object, e As System.EventArgs) Handles btnOKTexts.Click
        Dim btn As Button = CType(sender, Button)
        If btn.Text = "ערוך" Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT BTNordText,OKmsg FROM WelFareOps Where OpID = " & Request.QueryString("OP"), dbConnection)
            cD.CommandType = Data.CommandType.Text
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                If Not IsDBNull(dr("BTNordText")) Then tbbnordtext.Text = dr("BTNordText")
                If Not IsDBNull(dr("OKmsg")) Then tbbtnOKmsgText.Text = dr("OKmsg")
            End If
            dr.Close()
            dbConnection.Close()
            lblbnordtext.Visible = True
            tbbnordtext.Visible = True
            lblbtnOKmsgText.Visible = True
            tbbtnOKmsgText.Visible = True
            divbtntext.Visible = True

            btn.Text = "שמור"
        Else
            Dim b As Boolean = cbAgreeRequiredflag.Checked
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("Update WelFareOps set BTNordText = '" & tbbnordtext.Text & "',OKmsg = '" & tbbtnOKmsgText.Text & "' Where OpID = " & Request.QueryString("OP"), dbConnection)
            cD.CommandType = Data.CommandType.Text
            dbConnection.Open()
            cD.ExecuteNonQuery()
            dbConnection.Close()
            Response.Redirect("EditWelfare.aspx?OP=" & Request.QueryString("OP") & "&AG=" & Request.QueryString("AG"))
        End If

    End Sub

    Protected Sub btncancel_Click(sender As Object, e As System.EventArgs) Handles btncancel.Click
        Response.Redirect("EditWelfare.aspx?OP=" & Request.QueryString("OP") & "&AG=" & Request.QueryString("AG"))
    End Sub
End Class
