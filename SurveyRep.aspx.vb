Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing

Partial Class Default4
	Inherits System.Web.UI.Page
	Function pivot(ByVal dataValues As IDataReader, ByVal keyColumn As String, ByVal pivotNameColumn As String, ByVal pivotValueColumn As String) As DataTable
		Dim tmp As New DataTable()
		Dim r As DataRow
		Dim LastKey As String = "//dummy//"
        Dim i As Integer, pValIndex As Integer, pNameIndex As Integer
		Dim s As String
		Dim FirstRow As Boolean = True

		' Add non-pivot columns to the data table:

		pValIndex = dataValues.GetOrdinal(pivotValueColumn)
		pNameIndex = dataValues.GetOrdinal(pivotNameColumn)

		For i = 0 To dataValues.FieldCount - 1
			If i <> pValIndex AndAlso i <> pNameIndex Then
				tmp.Columns.Add(dataValues.GetName(i), dataValues.GetFieldType(i))
			End If
		Next

		r = tmp.NewRow()

		' now, fill up the table with the data:
		While dataValues.Read()
			' see if we need to start a new row
			If dataValues(keyColumn).ToString() <> LastKey Then
				' if this isn't the very first row, we need to add the last one to the table
				If Not FirstRow Then
					tmp.Rows.Add(r)
				End If
				r = tmp.NewRow()
				FirstRow = False
				' Add all non-pivot column values to the new row:
				For i = 0 To dataValues.FieldCount - 3
					r(i) = dataValues(tmp.Columns(i).ColumnName)
				Next
				LastKey = dataValues(keyColumn).ToString()
			End If
			' assign the pivot values to the proper column; add new columns if needed:
			s = dataValues(pNameIndex).ToString()
			If Not tmp.Columns.Contains(s) Then
				tmp.Columns.Add(s, dataValues.GetFieldType(pValIndex))
			End If
			r(s) = dataValues(pValIndex)
		End While


		' add that final row to the datatable:
		tmp.Rows.Add(r)

		' Close the DataReader
		dataValues.Close()


		' and that's it!
		Return tmp
	End Function

	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

	End Sub

	Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim cD As New SqlCommand("SELECT   ServiceName,Profiles_1,shortdescription,round(avg(cast([Val] as float)),2) as rslt FROM [BES1].[dbo].[vSurvey_Results_2] where Profiles_1 is not null group by ServiceName,Profiles_1,shortdescription order by ServiceName,avg(cast([Val] as float)) desc", dbConnection)
		dbConnection.Open()
		Dim reader As SqlDataReader = cD.ExecuteReader()
		GVREP.DataSource = pivot(reader, "ServiceName", "Profiles_1", "rslt")
		GVREP.DataBind()
	End Sub

	Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
		Dim c(0 To 10) As Drawing.Color
		c(0) = Color.Goldenrod
		c(1) = Color.Blue
		c(2) = Color.Crimson
		c(3) = Color.DarkOrange
		c(4) = Color.Gray
		c(5) = Color.Chartreuse
		c(6) = Color.DarkSlateBlue
		c(7) = Color.DarkSeaGreen
		c(8) = Color.Brown
		c(9) = Color.Firebrick
		c(10) = Color.Green

		ChrtG.Visible = True
		ChrtG.Series.Clear()
		Dim i As Integer
		Dim j As Integer
		Dim l As Integer = 0

		Dim gv As GridView = GVREP
		For i = 0 To gv.Rows.Count - 1
			Dim gvr As GridViewRow = gv.Rows(i)
			Dim tc As TableCell = gvr.Cells(0)
			Dim s As String = "s" & l
			ChrtG.Series.Add(s)
			ChrtG.Series(s).Color = c(l)
			gvr.Cells(0).BackColor = c(l)
			l = l + 1
			For j = gv.Columns.Count - 2 To 2 Step -1
				Dim k As Integer = CInt(gvr.Cells(j).Text)
				Dim sH As String = gv.Columns(j - 1).HeaderText
				ChrtG.Series(s).Points.AddXY(sH, k)

			Next
		Next

	End Sub
End Class
