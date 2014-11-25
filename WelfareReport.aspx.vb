Imports System.Data.SqlClient
Imports MessageBox
Partial Class WelfareReport
    Inherits System.Web.UI.Page
    Dim tot(1) As Double
    Function val(sF As String, ind As Integer, sFormat As String) As String
        Dim d As Double= Eval(sF)
        tot(ind) += d
        Return Format(d, sFormat)
    End Function
    Function vtot(ind As Integer, sFormat As String) As String
        Return Format(tot(ind), sFormat)
    End Function

    Protected Sub sTot_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = "<b>" & Format(tot(1), "#,##0.00") & "</b>"
    End Sub
    Protected Sub cTot_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = "<b>" & Format(tot(0), "#") & "</b>"
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load



        If Request.QueryString("OP") Is Nothing Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("Select top 1 opid,OpName From WelFareOps Where Active=1 Order by OpID desc", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                Response.Redirect("WelfareReport.aspx?OP=" & dr("OpID") & "&N=" & dr("OPName"))
            Else
                MessageBox.Show("אין מבצע פעיל")
            End If
        Else
        End If
 
    End Sub
    Protected Sub lblhdr_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = "דוח רכישות מבצעים<br /><span style='font-size:medium;'><i>" & Request.QueryString("n") & "</i></span>"
    End Sub
End Class
