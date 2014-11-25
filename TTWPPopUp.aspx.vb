Imports System.Data.SqlClient
Partial Class TTWPPopup
    Inherits System.Web.UI.Page
    Const CustEventTypeID As Integer = 128
    Protected Sub lblSingleFrame_PreRender(sender As Object, e As System.EventArgs) Handles lblSingleFrame.PreRender
        Dim s As String = "<script type='text/javascript'>function SingleSelect(regex, current) {"
        s &= " re = new RegExp(regex); " & _
                    "     for (i = 0; i < document.forms[0].elements.length; i++) {" & vbCrLf & _
                    "         elm = document.forms[0].elements[i];" & vbCrLf & _
                    "         if (elm.type == 'checkbox') {" & vbCrLf & _
                    "            //        //        if (re.test(elm.name)) {" & vbCrLf & _
                    "            elm.checked = false; " & vbCrLf & _
                    "            //        //        } " & vbCrLf & _
                    "        }" & vbCrLf & _
                    "    }" & vbCrLf & _
                    "    current.checked = true;" & vbCrLf

        s &= " }</script>"

        lblSingleFrame.Text = s
    End Sub
    Protected Sub cb_PreRender(sender As Object, e As System.EventArgs)
        If Not IsPostBack Then
            If Request.QueryString("WP") IsNot Nothing Then
                Dim cb As CheckBox = CType(sender, CheckBox)
                Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
                Dim hdn As HiddenField = CType(lvi.FindControl("hdnID"), HiddenField)
                If Request.QueryString("WP") <> vbNullString And hdn.Value <> vbNullString Then
                    If hdn.Value = CInt(Request.QueryString("WP")) Mod 100000 Then
                        cb.Checked = True
                    Else
                        cb.Checked = False
                    End If
                End If
            End If
        End If

    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim iCanUpdate As Integer = 0
        PlanStatus(i, j, iCanUpdate)
        ViewState("iCanUpdate") = iCanUpdate
        If Not IsPostBack Then
            If IsNumeric(Request.QueryString("WP")) Then
                Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
                Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
                Dim cD184 As New SqlCommand("SELECT Comment FROM TT_WeeklyPlan WHERE CustEventID=" & Request.QueryString("ID") & " AND ISNULL(WwID,ID)=" & CInt(CInt(Request.QueryString("WP")) / 100000), dbConnection184)
                dbConnection184.Open()
                Dim dr As SqlDataReader = cD184.ExecuteReader
                If dr.Read Then
                    If Not IsDBNull(dr("Comment")) Then
                        tbComment.Text = dr("Comment")
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub btnOK_Click(sender As Object, e As System.EventArgs) Handles btnOK.Click
        Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
        Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
        Dim cD184 As New SqlCommand(vbNullString, dbConnection184)

        ' Find New WorkPlanID (if any)

        Dim sWorkPlanID As String = "NULL"

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

        If sWorkPlanID = vbNullString And tbComment.Text = vbNullString Then Exit Sub

        ' if SWorkPlanID <> 999999 -> UPDATE

        Dim sql As String = vbNullString

        If sWorkPlanID <> "999999" Then
            sql = "IF EXISTS(SELECT * FROM TT_WeeklyPlan WHERE CustEventID=" & Request.QueryString("ID") & " AND ISNULL(WwID,ID)=" & CInt(CInt("0" & Request.QueryString("WP")) / 100000) & ")" & vbCrLf & _
            "UPDATE TT_WeeklyPlan SET WorkPlanID=" & sWorkPlanID & ",Comment=" & If(tbComment.Text = vbNullString, "NULL", "'" & tbComment.Text.Replace("'", "''") & "'") & ",LoadTime=GETDATE(),UserID=" & Session("UserID") & " WHERE ISNULL(WwID,ID)=" & CInt(CInt("0" & Request.QueryString("WP")) / 100000) & " AND CustEventID=" & Request.QueryString("ID") & vbCrLf & _
            "ELSE" & vbCrLf & _
            "INSERT INTO TT_WeeklyPlan (WwID,FormID,CustEventID,DayID,WorkPlanID,Comment,LoadTime,UserID) " & vbCrLf & _
            "VALUES(" & If(Not IsNumeric(Request.QueryString("WP")), "NULL", CStr(CInt(CInt(Request.QueryString("WP")) / 100000))) & "," & Request.QueryString("F") & "," & Request.QueryString("ID") & ",'" & Request.QueryString("D") & "'," & sWorkPlanID & "," & If(tbComment.Text = vbNullString, "NULL", "'" & tbComment.Text.Replace("'", "''") & "'") & ",GETDATE()," & Session("UserID") & ")"
        Else
            sql = "IF EXISTS(SELECT * FROM TT_WeeklyPlan WHERE CustEventID=" & Request.QueryString("ID") & " AND ISNULL(WwID,ID)=" & CInt(CInt(Request.QueryString("WP")) / 100000) & ")" & vbCrLf & _
            "DELETE TT_WeeklyPlan WHERE ISNULL(WwID,ID)=" & CInt(CInt(Request.QueryString("WP")) / 100000) & " AND CustEventID=" & Request.QueryString("ID") & vbCrLf & _
            "ELSE" & vbCrLf & _
            "INSERT INTO TT_WeeklyPlan (WwID,FormID,CustEventID,DayID,WorkPlanID,Comment,LoadTime,UserID,Deleted) " & vbCrLf & _
            "VALUES(" & CInt(CInt(Request.QueryString("WP")) / 100000) & "," & Request.QueryString("F") & "," & Request.QueryString("ID") & ",'" & Request.QueryString("D") & "',NULL,NULL,GETDATE()," & Session("UserID") & ",1)"
        End If

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
    Sub PlanStatus(ByRef iCustEventID As Integer, ByRef iCustRelateID As Integer, ByRef iCanUpdate As Integer)
        iCustEventID = 0
        iCustRelateID = 0
        iCanUpdate = 0
        If IsNumeric(Session("LastCustID")) And IsNumeric(Session("FrameID")) And IsNumeric(Session("UserID")) Then
            Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
            Dim cd As New SqlCommand("SELECT CustRelateID,CustEventID,CanUpdate FROM dbo.TT_fnPlanstatus(" & Session("LastCustID") & "," & Session("UserID") & "," & Session("FrameID") & "," & CustEventTypeID & "," & Request.QueryString("ID") & ")", dbConnection184)
            dbConnection184.Open()
            Dim dr As SqlDataReader = cd.ExecuteReader
            If dr.Read Then
                If Not IsDBNull(dr("CustEventID")) Then iCustEventID = dr("CustEventID")
                If Not IsDBNull(dr("CustRelateID")) Then iCustRelateID = dr("CustRelateID")
                iCanUpdate = If(dr("CanUpdate"), 1, 0)
            End If
            dr.Close()
            dbConnection184.Close()
        End If

    End Sub

End Class
