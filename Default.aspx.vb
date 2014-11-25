Imports System.Data.SqlClient
Imports eid
Imports PageErrors
Partial Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then Response.Redirect("Exit.aspx")
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim Cr As New SqlCommand("p2p_CustEventExpiration", dbConnection)
        'Cr.CommandType = Data.CommandType.StoredProcedure 
        Dim i As Integer
        'If Session("FrameID") IsNot Nothing Then
        '    Try
        '        i = Session("FrameID")

        '    Catch ex As Exception
        '        i = 0
        '    End Try
        '    If i > 0 Then Cr.Parameters.AddWithValue("FrameID", i)
        'End If

        'If Session("ServiceID") IsNot Nothing Then
        '    Try
        '        i = Session("FrameID")

        '    Catch ex As Exception
        '        i = 0
        '    End Try
        '    If i > 0 Then Cr.Parameters.AddWithValue("ServiceID", i)
        'End If

        'Cr.Parameters.AddWithValue("ListType", 5)
        dbConnection.Open()
        'Dim dr As SqlDataReader
        ''Try
        'dr = Cr.ExecuteReader
        'If dr.Read Then
        '    If dr("cnt") > 0 Then
        '        '   hle.Visible = True
        '        '    hle.ForeColor = Drawing.Color.Red
        '    Else

        '        hle.Visible = False

        '    End If
        'Else
        '    hle.Visible = False
        'End If
        'dr.Close()
        'Catch ex As Exception
        'Throw ex
        'End Try

        Cr.CommandText = "Select isnull(LicenceValidDate,Cast('2000-1-1' as datetime)) As LicenceValidDate, isnull(FireFDate,Cast('2000-1-1' as datetime)) As FireFDate, isnull(LicenseAlert,0) As LicenseAlert,isnull(Email,'') As Email,isnull(AlertMailSent,0) as AlertMailSent,isnull(FFAlertmailSent,0) as FFAlertmailSent From FrameList f Left outer join dbo.p0t_CustProperties p on p.ServicetypeID = f.ServicetypeID Where FrameID=0" & Session("FrameID")
        Cr.CommandType = Data.CommandType.Text
        Dim dr1 As SqlDataReader = Cr.ExecuteReader

        If dr1.Read Then

            '������ ������

            If dr1("LicenceValidDate") <> CDate("2000-1-1") Then

                i = -DateDiff(DateInterval.Day, dr1("LicenceValidDate"), Today())
                Dim k As Integer = dr1("LicenseAlert")
                Dim sBody As String = "<div  style=""text-align:right;direction:rtl"">����/� ����� ���/�, <br /><br />���� ������ ������ ���, ��� ������ ������ ������, ���� �����.<br/>�� ����� ��������. ��� ����� ����.<br/><br />�����,<br />���� ����� ������</div>"
                If i < k And i > k / 4 Then
                    If dr1("Email") <> vbNullString Then
                        If dr1("AlertMailSent") < 1 Then
                            SendErrMail("���� ������ ������ ���� ���� ���� " & i & " ����", sBody, dr1("Email"), , "beAlert@be-online.org")
                            Dim cu As New SqlCommand("update framelist set AlertMailSent = " & dr1("AlertMailSent") + 1 & " Where FrameID=0" & Session("frameID"), dbConnection)
                            cu.CommandType = Data.CommandType.Text
                            dr1.Close()
                            Try
                                cu.ExecuteNonQuery()
                            Catch ex As Exception
                                Throw ex
                            End Try

                        End If
                    Else
                        LBLLICALERT.Text = "������ ������ ���� ���� ���� " & i & " ����"
                        LBLLICALERT.ForeColor = Drawing.Color.Black
                    End If
                ElseIf i <= k / 4 And i > 0 Then
                    LBLLICALERT.Text = "������ ������ ���� ���� ���� " & i & " ����. ���� ����� �����!"
                    LBLLICALERT.ForeColor = Drawing.Color.Brown
                ElseIf i < 0 Then
                    LBLLICALERT.Text = "������ ������ �� ����  " & -i & " ����. ���� ����� �����!"
                    LBLLICALERT.ForeColor = Drawing.Color.Red
                End If
            End If

            ' ������ ����� ��

            If dr1("FireFDate") <> CDate("2000-1-1") Then

                i = -DateDiff(DateInterval.Day, dr1("FireFDate"), Today())
                Dim k As Integer = dr1("LicenseAlert")
                Dim sBody As String = "<div  style=""text-align:right;direction:rtl"">����/� ����� ���/�, <br /><br />���� ������ ����� �� ���, ��� ������ ������ ������, ���� �����.<br/>�� ����� ��������. ��� ����� ����.<br/><br />�����,<br />���� ����� ������</div>"
                If i < k And i > k / 4 Then
                    If dr1("Email") <> vbNullString Then
                        If dr1("FFAlertMailSent") < 1 Then
                            SendErrMail("���� ������ ����� �� ���� ���� ���� " & i & " ����", sBody, dr1("Email"), , "beAlert@be-online.org")
                            Dim cu As New SqlCommand("update framelist set FFAlertMailSent = " & dr1("FFAlertMailSent") + 1 & " Where FrameID=0" & Session("frameID"), dbConnection)
                            cu.CommandType = Data.CommandType.Text
                            dr1.Close()
                            Try
                                cu.ExecuteNonQuery()
                            Catch ex As Exception
                                Throw ex
                            End Try

                        End If
                    Else
                        LBLFFALERT.Text = "������ ����� �� ���� ���� ���� " & i & " ����"
                        LBLFFALERT.ForeColor = Drawing.Color.Black
                    End If
                ElseIf i <= k / 4 And i > 0 Then
                    LBLFFALERT.Text = "������ ����� �� ���� ���� ���� " & i & " ����. ���� ����� �����!"
                    LBLFFALERT.ForeColor = Drawing.Color.Brown
                ElseIf i < 0 Then
                    LBLFFALERT.Text = "������ ����� �� �� ����  " & -i & " ����. ���� ����� �����!"
                    LBLFFALERT.ForeColor = Drawing.Color.Red
                End If
            End If

        End If

        If dr1 IsNot Nothing Then dr1.Close()
        dbConnection.Close()
    End Sub
    Function bS() As Boolean
        Dim i As Integer
        Try
            i = Eval("cnt")

        Catch ex As Exception
            i = 0
        End Try
        return(i > 0)
    End Function
  
End Class
