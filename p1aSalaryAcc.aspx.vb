Imports System.Data.SqlClient
Partial Class p1aSalaryAcc
    Inherits System.Web.UI.Page
    Dim cJobs As New Collection
    Dim dTot(2) As Double
    Dim cCatID As New Collection

    Function sVal(sF As String, i As Integer) As String
        Dim d As Double = If(IsDBNull(Eval(sF)), 0, Eval(sF))
        dTot(i) += d
        Return Format(d, "#,###")
    End Function
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        'Dim lv As ListView = CType(lvACT, ListView)
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        'dbConnection.Open()

        'Dim lbl As Label = CType(lv.Controls(0).FindControl("lblFrm"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories Where CategoryID=" & Request.QueryString("F"), "Name", vbNullString, dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblJob"), Label)
        'If Request.QueryString("J") IsNot Nothing Then If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories Where CategoryID=" & Request.QueryString("J"), "Name", vbNullString, dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblSPeriod"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("SP"), "Period", "MMM-yy", dbConnection)

        'lbl = CType(lv.Controls(0).FindControl("lblEPeriod"), Label)
        'If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("EP"), "Period", "MMM-yy", dbConnection)

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
    Protected Sub lvACT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lvACT.ItemDataBound
        Dim l As ListViewDataItem = CType(e.Item, ListViewDataItem)
        Dim s As String = l.DataItem("Job_CatID")
        cJobs.Add(s, l.DisplayIndex.ToString)
    End Sub

    Protected Sub lvACT_PreRender(sender As Object, e As System.EventArgs) Handles lvACT.PreRender
        Dim lv As ListView = CType(sender, ListView)

        Dim li As ListItem
        Dim iCnt As Integer = 0
        For i As Integer = 0 To lv.Items.Count - 1

            ' if each row reperesnt only one transactiob redirect to Trans

            Dim hdn As HiddenField = CType(lv.Items(i).FindControl("hdnCnt"), HiddenField)
            If hdn IsNot Nothing Then
                If IsNumeric(hdn.Value) Then
                    iCnt = If(hdn.Value > 1, 2, 1)
                End If
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

        '     If iCnt = 1 Then Response.Redirect(Replace(Request.Url.AbsoluteUri, "p1aSalaryAcc", "p1aSalaryTran") & "&s=1")

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

    Protected Sub tdd_PreRender(sender As Object, e As System.EventArgs)
    End Sub
    Protected Sub lnkb_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(dTot(CInt(Right(lbl.ID, 1))), "#,###")
    End Sub

    Protected Sub DSACT_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSACT.Selected
        '    If e.AffectedRows = 1 Then Response.Redirect(Replace(Request.Url.AbsoluteUri, "p1aSalaryAcc", "p1aSalaryTran") & "&s=1")
    End Sub

    Protected Sub DSACT_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSACT.Selecting
        'For i = 0 To e.Command.Parameters.Count - 1
        '    Response.Write(e.Command.Parameters(i).ToString & " = " & e.Command.Parameters(i).Value & "<BR />")
        'Next
        'Response.End()
    End Sub

    Protected Sub lvACT_DataBinding(sender As Object, e As System.EventArgs) Handles lvACT.DataBinding
        Dim lv As ListView = CType(lvACT, ListView)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        dbConnection.Open()
        Dim lbl As Label = Nothing
        If Request.QueryString("f") <> vbNullString Then
            lbl = CType(lv.Controls(0).FindControl("lblFrm"), Label)
            If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories_besqxl Where CategoryID=" & Request.QueryString("F"), "Name", vbNullString, dbConnection)
        End If

        lbl = CType(lv.Controls(0).FindControl("lblJob"), Label)
        If Request.QueryString("J") IsNot Nothing Then If lbl IsNot Nothing Then lbl.Text = GetName("Select Name From Categories_besqxl Where CategoryID=" & Request.QueryString("J"), "Name", vbNullString, dbConnection)

        lbl = CType(lv.Controls(0).FindControl("lblSPeriod"), Label)
        If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("SP"), "Period", "MMM-yy", dbConnection)

        lbl = CType(lv.Controls(0).FindControl("lblEPeriod"), Label)
        If lbl IsNot Nothing Then lbl.Text = GetName("Select Period From p0t_Periods Where PeriodID=" & Request.QueryString("EP"), "Period", "MMM-yy", dbConnection)

        dbConnection.Close()


    End Sub

End Class
