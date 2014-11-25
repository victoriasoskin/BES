Imports System.Data.SqlClient
Imports PageErrors
Partial Class HREmpList
    Inherits System.Web.UI.Page
    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
        Dim cD184 As New SqlCommand(vbNullString, dbConnection184)

        Dim sWorkPlanID As String = vbNullString

        For Each lvi As ListViewItem In lvWorkPlan.Items
            Dim cb As CheckBox = CType(lvi.FindControl("cbf"), CheckBox)
            If cb IsNot Nothing Then
                If cb.Checked Then
                    Dim hdn As HiddenField = CType(lvi.FindControl("hdnID"), HiddenField)
                    sWorkPlanID = hdn.Value
                    Exit For
                End If
            End If
        Next

        Dim s As String = Request.QueryString("WP")
        Dim sql As String = vbNullString
        If s <> vbNullString Then sql = "DELETE FROM TT_WeeklyPlan WHERE ID = " & Left(s, Len(s) - 5) & vbCrLf

        If sWorkPlanID <> vbNullString And sWorkPlanID <> -99 Then sql &= "INSERT INTO TT_WeeklyPlan(FormID,DayID,WorkPlanID) VALUES(" & Request.QueryString("ID") & ",'" & Request.QueryString("D") & "'," & sWorkPlanID & ")"

        If sql <> vbNullString Then
            cD184.CommandText = sql
            cD184.CommandType = Data.CommandType.Text
            dbConnection184.Open()
            Try
                cD184.ExecuteNonQuery()
            Catch ex As Exception
                dbConnection184.Close()
                dbg("כתיבה/עדכון פעולה בתוכנית שבועית נכשלה<br />" & ex.Message)
            End Try
            dbConnection184.Close()
        End If
        Dim csm As ClientScriptManager = Page.ClientScript
        csm.RegisterClientScriptBlock(Me.GetType(), "", "<script>window.close();</script>")
    End Sub
    Sub dbg(s As String, Optional bError As Boolean = True)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""window.close();"" /></div>")
        Response.End()
    End Sub


    Protected Sub DSEmployeeList_Updating(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEmployeeList.Updating
        'For i = 0 To e.Command.Parameters.Count - 1
        '    Response.Write(e.Command.Parameters(i).ToString & " = " & e.Command.Parameters(i).Value & "<br />")
        'Next
        'Response.Write(e.Command.CommandText)
        'Response.End()


    End Sub
    Protected Sub CB_CheckedChanged(sender As Object, e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
        Dim lbl As Label = CType(lvi.FindControl("lblEmployeeID"), Label)
        If IsNumeric(lbl.Text) Then
            Dim sql As String = "DELETE FROM HR_SecondManager WHERE EmployeeID=" & lbl.Text & vbCrLf
            If cb.Checked Then
                sql &= "INSERT INTO HR_SecondManager(EmployeeID) VALUES(" & lbl.Text & ")"
            End If
            Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
            Dim cD184 As New SqlCommand(sql, dbConnection184)
            dbConnection184.Open()
            cD184.ExecuteNonQuery()
            dbConnection184.Close()
        End If
    End Sub
    Protected Sub CB_PreRender(sender As Object, e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        If Session("SType") = "Admin" Then cb.Visible = True Else cb.Visible = False

    End Sub
    Protected Sub lnkbH_PreRender(sender As Object, e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        If Session("SType") = "Admin" Then lnkb.Visible = True Else lnkb.Visible = False
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

    End Sub
End Class
