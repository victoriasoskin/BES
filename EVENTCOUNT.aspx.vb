Imports System.Data.SqlClient
Partial Class EVENTCOUNT
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim s As String
        On Error Resume Next
        s = Session("ServiceID")
        If Err.Number <> 0 Then
            Err.Clear()
            s = vbNullString
        End If
        On Error GoTo 0
        If s <> vbNullString And s <> "3" Then Response.Redirect("Default.aspx")
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sD As String = Format(DateAdd(DateInterval.Year, 1, Today()), "yyyy-MM-dd")
        ' Read WorkYear to display
        Dim ConComp As New SqlCommand("Select Workyear From p0t_WorkYears Where WYType = 1 And WorkYearFirstDate<='" & sD & "'  And WorkYearLastDate>='" & sD & "' Order by WorkyearFirstDate DESC", dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        s = dr.Item("WorkYear")
        LBLWY.Text = "לקראת שנת " & Left(s, Len(s) - 1) & """" & Right(s, 1)
        'Read Workyear to Filter with
        sD = Format(Today(), "yyyy-MM-dd")
        dr.Close()
        Dim ConComp1 As New SqlCommand("Select Workyear From p0t_WorkYears Where WYType = 1 And WorkYearFirstDate<='" & sD & "'  And WorkYearLastDate>='" & sD & "' Order by WorkyearFirstDate DESC", dbConnection)
        dr = ConComp1.ExecuteReader()
        dr.Read()
        s = dr.Item("WorkYear")
        HDNWY.Value = s
        dbConnection.Close()
        LBLHDR.Text = "דוח מועמדים לחינוך"
        LBLDT.Text = Format(Today(), "dd/MM/yy")
    End Sub
End Class
