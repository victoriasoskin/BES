Imports System.Data.SqlClient
Imports PageErrors
Partial Class TTPlanReport
    Inherits System.Web.UI.Page
    Const InitialMaximumTextLength As Integer = 100
    Const LnegthoFVisibleText As Integer = 60

    Protected Sub DDL_PreRender(sender As Object, e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        For i As Integer = 0 To ddl.Items.Count - 1
            ddl.Items(i).Text = sText(ddl.Items(i).Text)
        Next
        If ddl.SelectedValue = vbNullString Then
            Dim lvi As ListViewItem = CType(ddl.NamingContainer, ListViewItem)
            Dim hdn As HiddenField = CType(lvi.FindControl("HdnWorkPlanID"), HiddenField)
            If hdn IsNot Nothing Then
                ddl.ClearSelection()
                Dim li As ListItem = ddl.Items.FindByValue(hdn.Value)
                If li IsNot Nothing Then
                    li.Selected = True
                End If
            End If
        End If
    End Sub
    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack And Request.QueryString("U") Is Nothing Then
            Dim sRed As String = Request.Url.AbsoluteUri
            sRed &= If(InStr(sRed, "?") > 0, "&", "?")
            sRed &= "U=" & Session("UserID") & "&C=" & Session("LastCustID") & "&F=" & Session("FrameID")
            Response.Redirect(sRed)
        End If

        Dim connStr As String = ConfigurationManager.ConnectionStrings("beBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        ' First Entry

        If Not IsPostBack Then

            'New Form

            If Request.QueryString("ID") Is Nothing Then

                ' see if EveryThing Needed is Present

                If Request.QueryString("FT") Is Nothing Then dbg("אין סוג תוכנית")
                cD.CommandText = "TT_pAddReport"
                cD.CommandType = Data.CommandType.StoredProcedure
                Dim RetVal As New SqlParameter("@RetVal", Data.SqlDbType.Int)
                RetVal.Direction = Data.ParameterDirection.Output
                cD.Parameters.Add(RetVal)
                cD.Parameters.AddWithValue("@FormTypeID", Request.QueryString("FT"))
                cD.Parameters.AddWithValue("@UserID", Request.QueryString("U"))
                cD.Parameters.AddWithValue("@CustomerID", Request.QueryString("C"))
                cD.Parameters.AddWithValue("@CustFrameID", Request.QueryString("F"))
                cD.Parameters.AddWithValue("@CustEventDate", Today)
                dbConnection.Open()
                Try
                    cD.ExecuteNonQuery()
                    ViewState("CustEventID") = RetVal.Value
                    If ViewState("CustEventID") < 0 Then
                        dbConnection.Close()
                        dbg("שגיאה בפתיחת ארוע " & ViewState("CustEventID"))
                    End If
                Catch ex As Exception
                    dbg(ex.Message)
                End Try
                dbConnection.Close()
            Else
                cD.CommandText = "SELECT CustFrameID FROM custEventList Where CustEventID = " & Request.QueryString("ID")
                dbConnection.Open()
                Dim dr As SqlDataReader = cD.ExecuteReader
                If dr.Read Then
                    Dim sFrm As String = dr("CustFrameID")
                    If sFrm <> Session("FrameID") Then
                        dr.Close()
                        dbConnection.Close()
                        dbg("המעקב אינו שייך למסגרת שלך", False)
                    End If
                End If
                dr.Close()
                dbConnection.Close()
            End If
        ElseIf Request.QueryString("ID") IsNot Nothing Then
            ViewState("CustEventID") = Request.QueryString("ID")
        End If
    End Sub
    Protected Sub hdn_PreRender(sender As Object, e As System.EventArgs)
        Dim hdn As HiddenField = CType(sender, HiddenField)
        PageHeader1.Header = hdn.Value
    End Sub
    Sub dbg(s As String, Optional bError As Boolean = True)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""window.close();"" /></div>")
        Response.End()
    End Sub
    Protected Sub DSWorkPlanReport_DB(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSWorkPlanReport.Inserting, DSWorkPlanReport.Selecting
        If e.Command.Parameters("@CustEventID") IsNot Nothing Then
            If e.Command.Parameters("@CustEventID").Value = Nothing Then
                Dim sCustEventID As String = ViewState("CustEventID")
                If Not IsNumeric(sCustEventID) Then dbg("מספר פעולה לא חוקי")
                e.Command.Parameters("@CustEventID").Value = sCustEventID
            End If

        End If
    End Sub

    Protected Sub DSWorkPlan_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSWorkPlan.Selecting
        If e.Command.Parameters("@CstpID").Value = Nothing Then
            e.Command.Parameters("@CstpID").Value = FindPlanCustEventID()
        End If
    End Sub
    Function FindPlanCustEventID() As Integer
        Dim s As String = lblCustEventID.Text
        If Not IsNumeric(s) Then
            'try to set up
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT CustEventID FROM CustEventList WHERE CustEventTypeID=128 AND CustFrameID=" & Request.QueryString("F") & " AND CustEventID IN (SELECT CustEventID FROM CustStatus WHERE CustomerID=" & Request.QueryString("C") & ")", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = Nothing
            Try
                dr = cD.ExecuteReader
            Catch ex As Exception

                ' 2013-3-11

                If dr IsNot Nothing Then dr.Close()
                dbConnection.Close()

                WriteErrorLog(, cD.CommandText)
                Page.ClientScript.RegisterClientScriptBlock(Me.GetType(), "aa", "<script>window.open('','_self');window.close();</script>")
                Return 0
                Exit Function
            End Try
            If dr.Read Then
                lblCustEventID.Text = dr("CustEventID")
                s = lblCustEventID.Text
            End If
            dr.Close()
            dbConnection.Close()
            'If Not IsNumeric(s) Then
            '    DeleteReoprt()
            '    'dbg("לא קיימת תוכנית תמיכות", False)
            'End If
        End If

        Return 0 & s
    End Function

    Protected Sub DDL_SelectedIndexChanged(sender As Object, e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedValue = vbNullString Then
            Dim lvi As ListViewItem = CType(ddl.NamingContainer, ListViewItem)
            Dim lbl As Label = CType(lvi.FindControl("lblDescription"), Label)
            lbl.Text = vbNullString
            lbl = CType(lvi.FindControl("lblCriteria"), Label)
            lbl.Text = vbNullString
            lbl = CType(lvi.FindControl("lblPurpose"), Label)
            lbl.Text = vbNullString
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnWorkPlanID"), HiddenField)
            hdn.Value = Nothing
        Else
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT * FROM dbo.TT_fnWorkPlan(" & lblCustEventID.Text & ") WHERE WPID = " & ddl.SelectedValue, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                Dim lvi As ListViewItem = CType(ddl.NamingContainer, ListViewItem)
                Dim lbl As Label = CType(lvi.FindControl("lblDescription"), Label)
                lbl.Text = If(IsDBNull(dr("Description")), vbNullString, dr("Description"))
                lbl = CType(lvi.FindControl("lblCriteria"), Label)
                lbl.Text = If(IsDBNull(dr("Criteria")), vbNullString, dr("Criteria"))
                lbl = CType(lvi.FindControl("lblPurpose"), Label)
                lbl.Text = If(IsDBNull(dr("Purpose")), vbNullString, dr("Purpose"))

            End If
        End If
    End Sub

    Protected Sub btnDel_Click(sender As Object, e As System.EventArgs) Handles btnDel.Click
        DeleteReoprt()
        dbg("הדיווח נמחק", False)
    End Sub
    Sub DeleteReoprt()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        cD.CommandType = Data.CommandType.Text
        Dim s As String = If(ViewState("CustEventID") Is Nothing, Request.QueryString("ID"), ViewState("CustEventID"))
        Dim sql2 As String = "EXEC Cust_DelEvent " & s
        cD.CommandText = sql2
        dbConnection.Open()
        Try
            '        cD.ExecuteNonQuery()
        Catch ex As Exception
            dbg("מחיקת הפעולה נכשלה <br />" & ex.Message)
        End Try
        dbConnection.Close()

        ' Close window

    End Sub

    Protected Sub DSCustomer_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSCustomer.Selecting
        If e.Command.Parameters("@CustEventID").Value = Nothing Then
            e.Command.Parameters("@CustEventID").Value = FindPlanCustEventID()
        End If

    End Sub
    Function ShowText(sF As String) As String
        Dim sID As String = Eval("ID")
        Dim s As String = If(IsDBNull(Eval(sF)), vbNullString, Eval(sF))
        If Len(s) > InitialMaximumTextLength Then
            Dim sx As String = Mid(s, LnegthoFVisibleText, InitialMaximumTextLength)
            Dim i As Integer = InStr(sx, ":")
            If i = 0 Then i = InStr(sx, ".")
            If i = 0 Then i = InStr(sx, ",")
            If i = 0 Then i = InStr(sx, " ")
            i += LnegthoFVisibleText
            s = Left(s, i) & "<span id='spn" & sF & sID & "' style='display:none;'>" & Mid(s, i + 1) & "</span><input id='inp" & sF & sID & "' type='button' style='vertical-align:top;height:17px;' value=':::' onclick='flipShow(this," & sID & ");' />"
        End If
        Return s
    End Function
    Function sText(s As String) As String
        '       s = If(Len(s) > 30, Left(s, 30 - 3) & "...", s)
        Return s
    End Function
    Protected Sub btnUpdate_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lvi As ListViewItem = CType(btn.NamingContainer, ListViewItem)
        Dim ddl As DropDownList = CType(lvi.FindControl("ddlWP"), DropDownList)
        If ddl IsNot Nothing Then
            If IsNumeric(ddl.SelectedValue) Then
                DSWorkPlanReport.UpdateParameters("WorkPlanID").DefaultValue = ddl.SelectedValue

            End If
        End If
    End Sub

    Protected Sub DSWorkPlanReport_DB(sender As Object, e As SqlDataSourceSelectingEventArgs) Handles DSWorkPlanReport.Selecting
        For i As Integer = 0 To e.Command.Parameters.Count - 1
            Dim s As String = e.Command.Parameters(i).ToString()
            Dim sv As String = e.Command.Parameters(i).Value
        Next
    End Sub
End Class


