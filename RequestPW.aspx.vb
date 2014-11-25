Imports System.Data.SqlClient
Imports ProgTexts
Imports eid
Imports WebMsgApp
Imports MessageBox
Partial Class RequestPW
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            InsertTexts(1, Page)
 
        End If
    End Sub
    Protected Sub btnsnd_ClicK(sender As Object, e As System.EventArgs) Handles btnsnd.Click
        Dim sEmail As String = (tbemail2.Text & "@" & tbemail1.Text).Replace("'", "''").Replace(" ", vbNullString)
        If sEmail <> "@" Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("Select UserID,UserName,URName,Password,isnull(xpw,0) as xpw From P0T_NtB Where UEmail='" & sEmail & "'", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                Dim iUserID As Integer = dr("UserID")
                Dim r As New Random()
                Dim sPw As String = CStr(r.Next(100000, 999999))
                Dim sUn As String = dr("UserName")
                Dim sURn As String = dr("URName")
                Dim ixpw As Integer = dr("xpw")
                Dim sOldPw = DecryptText(dr("Password"))
                dr.Close()
                If ixpw = 0 Then
                    cD.CommandText = "UPDATE p0t_Ntb SET Password='" & EncryptText(sPw) & "', Xpw = 1  Where UserID=" & iUserID
                    cD.ExecuteNonQuery()
                Else
                    sPw = sOldPw
                End If
                Dim sSubj = hdnsubj.Value
                sSubj = sSubj.Replace("#username#", sUn)
                Dim sBody = hdnBody.Value
                sBody = sBody.Replace(LCase("#username#"), sUn).Replace("#password#", sPw).Replace("#urname#", sURn)
                dbConnection.Close()
                InsertLog(1, iUserID, vbNullString)
                SendErrMail(sSubj, sBody, sEmail, vbNullString, "Admin@be-Online.org")
                '           WebMsgBox.Show(hdnSuccess.Value)
                divmsgok.Visible = True
                dbConnection.Close()
            Else
                dr.Close()
                InsertLog(1, 0, sEmail)
                If ViewState("Err") Is Nothing Then
                    divmsgerr.Visible = True
                    ViewState("Err") = "1"
                Else
                    divmsgerr2.Visible = True
                End If

                '             WebMsgBox.Show(hdnError.Value)
                dbConnection.Close()
            End If

        End If
    End Sub

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnerr.Click
        divmsgerr.Visible = False
    End Sub
    Protected Sub btnOK2_Click(sender As Object, e As System.EventArgs) Handles btnerr2.Click
        divmsgerr2.Visible = False
    End Sub
    'Protected Sub btnOK1_Click(sender As Object, e As System.EventArgs) Handles btnok.Click
    '    divmsgok.Visible = False
    'End Sub
End Class
