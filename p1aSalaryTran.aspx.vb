Imports System.Data.SqlClient
Partial Class p1aSalaryTran
    Inherits System.Web.UI.Page
    Dim cJobs As New Collection
    Dim dTot(2) As Double
    Dim cCatID As New Collection
    Dim cPeriods As Collection

    Function sVal(sF As String, i As Integer) As String
        Dim d As Double = If(IsDBNull(Eval(sF)), 0, Eval(sF))
        dTot(i) += d
        Return Format(d, "#,###")
    End Function
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'Dim lv As ListView = CType(lvTrans, ListView)
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Dim lbl As Label = Nothing
        'dbConnection.Open()
        'Try
        '    lbl = CType(lv.Controls(0).FindControl("lblFrm"), Label)
        'Catch ex As Exception

        'End Try
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories Where CategoryID=" & Request.QueryString("F"), "Name", vbNullString, dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblJob"), Label)
        'If Request.QueryString("j") <> vbNullString Then If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories Where CategoryID=" & Request.QueryString("J"), "Name", vbNullString, dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblSPeriod"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("SP"), "Period", "MMM-yy", dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblEPeriod"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("EP"), "Period", "MMM-yy", dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblBgt"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories Where CategoryID=" & Request.QueryString("B"), "Name", vbNullString, dbConnection)

        'If Request.QueryString("s") Is Nothing Then
        '    lbl = CType(lv.Controls(0).FindControl("lblAccountName"), Label)
        '    If lbl IsNot Nothing Then lbl.Text = GetName("Select Top 1 AccountName From SL_vActActual Where AccountKey=" & Request.QueryString("A"), "AccountName", vbNullString, dbConnection)

        '    lbl = CType(lv.Controls(0).FindControl("lblAccountKey"), Label)
        '    If lbl IsNot Nothing Then lbl.Text = Request.QueryString("A")
        '    If Request.QueryString("a") = 999999999 Then lv.InsertItemPosition = InsertItemPosition.LastItem
        'End If

        'dbConnection.Close()

    End Sub
    Function GetName(sql As String, sField As String, sFormat As String, dbc As System.Data.IDbConnection) As String
        Dim cI As New SqlCommand(sql, dbc)
        Dim s As String = vbNullString
        Dim dr As SqlDataReader = cI.ExecuteReader
        If dr.Read Then
            If Not IsDBNull(dr(sField)) Then
                s = dr(sField)
                If IsDate(s) Then s = Format(CDate(s), sFormat)
                If IsNumeric(s) Then s = Format(CDate(s), sFormat)
            End If
        End If
        dr.Close()
        Return s
    End Function
    Protected Sub lvTrans_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lvTrans.ItemDataBound
        Dim l As ListViewDataItem = CType(e.Item, ListViewDataItem)
        Dim s As String = If(IsDBNull(l.DataItem("Job_CatID")), vbNullString, l.DataItem("Job_CatID"))
        If s <> vbNullString Then
            Try
                cJobs.Add(s, l.DisplayIndex.ToString)
            Catch ex As Exception
            End Try
        End If
    End Sub

    Protected Sub lvTrans_PreRender(sender As Object, e As System.EventArgs) Handles lvTrans.PreRender
        Dim lv As ListView = CType(sender, ListView)

        Dim li As ListItem
        Dim sAct As String = vbNullString
        For i As Integer = 0 To lv.Items.Count - 1

            Dim lbl As Label = CType(lv.Items(i).FindControl("lblAccountKey"), Label)
            If lbl IsNot Nothing Then
                sAct = If(sAct = vbNullString, lbl.Text, If(sAct <> lbl.Text, "X", sAct))
            End If
            ' Set up ddlJob

            Dim ddl As DropDownList = CType(lv.Items(i).FindControl("ddlJob"), DropDownList)
            If ddl IsNot Nothing Then
                Try
                    li = ddl.Items.FindByValue(cJobs(i.ToString))
                Catch ex As Exception
                    li = ddl.Items(0)
                End Try
                If li IsNot Nothing Then
                    li.Selected = True
                End If
            End If
            If ddl IsNot Nothing Then
                If ddl.SelectedIndex = 0 Then
                    ddl.BackColor = Drawing.Color.Red
                Else
                    ddl.BackColor = Drawing.Color.Transparent
                End If
            End If

        Next

        If lv.Items.Count > 1 And Request.QueryString("s") IsNot Nothing And sAct <> "X" Then
            Dim lbl As Label = CType(lv.Controls(0).FindControl("lblAccountName"), Label)
            Dim lbls As Label = CType(lv.Items(0).FindControl("lblAccountName"), Label)
            If lbl IsNot Nothing And lbls IsNot Nothing Then lbl.Text = lbls.Text

            lbl = CType(lv.Controls(0).FindControl("lblAccountKey"), Label)
            lbls = CType(lv.Items(0).FindControl("lblAccountKey"), Label)
            If lbl IsNot Nothing And lbls IsNot Nothing Then lbl.Text = lbls.Text
        End If
    End Sub

    Protected Sub lblPeiod_PreRenter(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim lv As ListView = CType(lbl.NamingContainer, ListView)
        If lv.Items.Count > 1 Then
            Dim hl As HyperLink = CType(lv.Items(1).FindControl("hlPeriod"), HyperLink)
            If hl IsNot Nothing Then
                If hl.Text = vbNullString Then
                    lbl.Visible = False
                End If
            End If
        End If
    End Sub

     Protected Sub lnkb_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(dTot(CInt(Right(lbl.ID, 1))), "#,###")
    End Sub

    Protected Sub lvTrans_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles lvTrans.SelectedIndexChanged

    End Sub

    Sub SetddlValue(ddl As DropDownList, sVal As String, Optional sText As String = vbNullString)
        Dim li As ListItem = ddl.Items.FindByValue(sVal)
        If li IsNot Nothing Then
            ddl.ClearSelection()
            li.Selected = True
        ElseIf sText <> vbNullString Then
            ddl.ClearSelection()
            li = New ListItem(sText, sVal)
            ddl.Items.Add(li)
            li.Selected = True
        End If
    End Sub

    Function GetPeriod(iPeriodID As Integer) As String
        If cPeriods Is Nothing Then
            cPeriods = New Collection
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT PeriodID, Period FROM p0t_Periods WHERE (Period BETWEEN DATEADD(month, - 22, GETDATE()) AND DATEADD(month, 12, GETDATE())) ORDER BY Period", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            While dr.Read
                cPeriods.Add(dr("Period"), dr("PeriodID").ToString)
            End While
            dr.Close()
            dbConnection.Close()
        End If
        Dim d As DateTime
        Try
            d = cPeriods(iPeriodID.ToString)
        Catch ex As Exception
            d = CDate("1900-1-1")
        End Try
        Return If(d = CDate("1900-1-1"), "NULL", "'" & Format(d, "yyyy-MM-dd") & "'")
    End Function

    Protected Sub lvTrans_DataBinding(sender As Object, e As System.EventArgs) Handles lvTrans.DataBinding
        Dim lv As ListView = CType(lvTrans, ListView)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim lbl As Label = Nothing
        dbConnection.Open()
        Try
            lbl = CType(lv.Controls(0).FindControl("lblFrm"), Label)
        Catch ex As Exception

        End Try
        If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories_besqxl Where CategoryID=" & Request.QueryString("F"), "Name", vbNullString, dbConnection)

        lbl = CType(lv.Controls(0).FindControl("lblJob"), Label)
        If Request.QueryString("j") <> vbNullString Then If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories_besqxl Where CategoryID=" & Request.QueryString("J"), "Name", vbNullString, dbConnection)

        lbl = CType(lv.Controls(0).FindControl("lblSPeriod"), Label)
        If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("SP"), "Period", "MMM-yy", dbConnection)

        lbl = CType(lv.Controls(0).FindControl("lblEPeriod"), Label)
        If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("EP"), "Period", "MMM-yy", dbConnection)

        If Request.QueryString("b") <> vbNullString Then
            lbl = CType(lv.Controls(0).FindControl("lblBgt"), Label)
            If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories_besqxl Where CategoryID=" & Request.QueryString("B"), "Name", vbNullString, dbConnection)
        End If


        If Request.QueryString("s") Is Nothing Then
            lbl = CType(lv.Controls(0).FindControl("lblAccountName"), Label)
            If lbl IsNot Nothing Then lbl.Text = GetName("Select Top 1 AccountName From SL_Accounts Where AccountKey=" & Request.QueryString("A"), "AccountName", vbNullString, dbConnection)

            lbl = CType(lv.Controls(0).FindControl("lblAccountKey"), Label)
            If lbl IsNot Nothing Then lbl.Text = Request.QueryString("A")
        End If

        dbConnection.Close()


    End Sub

    Protected Sub DSJobs_C_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSJobs_C.Selecting
        '    Dim lv As ListView = lvTrans
        '    Dim lvi As ListViewItem = lv.InsertItem
        '    If lvi IsNot Nothing Then
        '        Dim tdd As TreeDropDow = CType(lvi.FindControl("tddFrame_c"), TreeDropDow)
        '        If tdd IsNot Nothing Then
        '            Dim s As String = tdd.SelectedValue
        '            If IsNumeric(s) Then
        '                e.Command.Parameters("@Frm_CatID").Value = s
        '            End If
        '        End If
        '    End If
    End Sub
End Class
