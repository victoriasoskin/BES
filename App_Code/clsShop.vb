Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Namespace myShop
	Public Class clsShop
		Public Function p0pProp(ByVal iType As Integer) As Boolean
			Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
			Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
			Dim comP As New SqlCommand("Update p0t_properties set p2_ClassChanged =1", dbConnection)
            Select Case iType
                Case 0
                    comP.CommandText = "Update p0t_properties set p2_ClassChanged=1"
                Case 1
                    comP.CommandText = "Update p0t_properties set p1_ClassChanged=1"
                Case 2
                    comP.CommandText = "Update p0t_properties set p1_TransAdded=1"
            End Select
			comP.CommandType = Data.CommandType.Text
			dbConnection.Open()
			comP.ExecuteNonQuery()
			If Err.Number <> 0 Then Err.Clear()
			dbConnection.Close()
			Return True
		End Function
        Public Shared Function PeriodID(ByVal dPeriod As DateTime, Optional ByVal ProjectID As Integer = 1, Optional ByVal bReBuild As Boolean = False) As Integer
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim iPeriodID As Integer
            Static cPeriod As Collection
            If bReBuild Then
                cPeriod = Nothing
                Return True
            End If
            Dim b As Boolean
            If cPeriod Is Nothing Then
                cPeriod = New Collection
                Dim comSql As New SqlCommand("Select Period,PeriodID,Isnull(p1,0) as p1,Isnull(p2,0) as p2,Isnull(p3,0) as p3,Isnull(p4,0) as p4,Isnull(p5,0) as p5,Isnull(p6,0) as p6 from p0t_periods", dbConnection)
                dbConnection.Open()
                Dim dr As SqlDataReader = comSql.ExecuteReader
                While dr.Read()
                    Dim s As String
                    s = CStr(dr("Periodid"))
                    Dim i As Integer
                    For i = 1 To 6
                        s = s & "|" & If(dr("p" & i) = vbNullString, "0", dr("p" & i))
                    Next
                    cPeriod.Add(s, Format(dr("Period"), "yyyy-MM-dd"))
                End While
                dr.Close()
                dbConnection.Close()
            End If
            Dim s1 As String
            Try
                s1 = cPeriod(Format(dPeriod, "yyyy-MM-dd"))
            Catch ex As Exception
                s1 = vbNullString
            End Try
            If s1.Length > 0 Then
                Dim v() As String = Split(s1, "|")
                iPeriodID = v(0)
                b = v(ProjectID) <> "0"
            Else
                iPeriodID = 0
                b = False
            End If
            If b Then
                Return iPeriodID
            Else
                Return -iPeriodID
            End If
        End Function
	End Class
End Namespace

