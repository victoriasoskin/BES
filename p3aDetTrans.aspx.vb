Imports System.Data.SqlClient
Partial Class p3a_DetTrans
    Inherits System.Web.UI.Page
    Dim dTot As Double
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Session("p3_BudInd") <> 1 Then
        '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '    Dim ConComp As New SqlCommand("p3p_BudInd", dbConnection)
        '    ConComp.CommandType = Data.CommandType.StoredProcedure
        '    dbConnection.Open()
        '    ConComp.ExecuteNonQuery() 
        '    dbConnection.Close()
        '    Session("p3_budind") = 1
        'End If
    End Sub
    Function dVal(ByVal s As String) As String
        Dim dbl As Double = Eval(s)
        dTot = dTot + dbl
        Return Format(dbl, "-#,###;#,###")
    End Function
    Function dTVal() As String
        Return Format(dTot, "-#,###;#,###")
    End Function
    Protected Sub LBLDET_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LBLDET.PreRender
        If Not Request.QueryString("FCID") Is Nothing Then
            If Request.QueryString("FCID") <> 880 Then
                Dim lbl As Label = CType(sender, Label)
                Dim s As String = "מסגרת: " & Request.QueryString("Frame")
                s = s & ", סעיף: " & Request.QueryString("BudItem")
                s = s & ", נושא: " & Request.QueryString("Subject")
                lbl.Text = s
            Else
                Dim lbl As Label = CType(sender, Label)
                Dim s As String = "סעיף: " & Request.QueryString("Frame")
                s = s & ", מסגרת: " & Request.QueryString("BudItem")
                s = s & ", נושא: " & Request.QueryString("Subject")
                lbl.Text = s
            End If
        End If
    End Sub

    Protected Sub DSTrans_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSTrans.Selecting
        If Not Request.QueryString("FCID") Is Nothing Then
            If Request.QueryString("FCID") = 880 Then
                e.Command.Parameters("@FCID").Value = 206
            End If
        End If
    End Sub
End Class
