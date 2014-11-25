Imports System.Data.SqlClient
Partial Class CandReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LBLDate.Text = Format(Now(), "dd/MM/yy")
        HDNWYEAR.Value = CDate(DatePart("yyyy", Now()) & "-1-1")

        ' Build GridviewColumns

        Dim gv As GridView = gvpivot

        Dim f As New BoundField
        On Error Resume Next
        Dim IG As Integer = If(DDLGROUP.SelectedValue = vbNullString, "2", DDLGROUP.SelectedValue)
        If Err.Number = 0 Then
            Dim i As Integer
            ' First Clear All
            Dim k As Integer = gv.Columns.Count
            For i = k To 1 Step -1
                gv.Columns.RemoveAt(i)
                If Err.Number <> 0 Then Err.Clear()
            Next
            'Columns

            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select Hdr1,Hdr2,Hdr3,Hdr4 From p0t_RepColumns Where RepID = 6 Order By Ord", dbConnection)
            dbConnection.Open()
            i = 1
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            While dr.Read()
                Dim s As String = dr("CustEventTypeName")
                f = New BoundField
                f.DataField = "Col" & i
                Dim j As Integer
                Dim s1 As String

                s = dr("Hdr1")
                Err.Clear()
                For j = 2 To 4
                    s1 = dr("Hdr" & j)
                    If Err.Number <> 0 Then
                        Err.Clear()
                        Exit For
                    End If
                    s = s & ", " & s1
                Next

                f.HeaderText = s
                f.DataFormatString = "{0:#}"
                If Err.Number <> 0 Then MsgBox(Err.Description)
                f.HeaderStyle.VerticalAlign = VerticalAlign.Top
                f.HeaderStyle.HorizontalAlign = HorizontalAlign.Right
                Dim c As DataControlField = f
                gv.Columns.Add(c)
                i = i + 1
            End While
        Else
            Err.Clear()
        End If


    End Sub

	Protected Sub DSPIVOT_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSPIVOT.Selecting
		e.Command.CommandTimeout = 180
	End Sub

    Protected Sub DDLSERVICE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSERVICE.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.Count = 2 Then
            ddl.SelectedIndex = 1
        End If

    End Sub
End Class

