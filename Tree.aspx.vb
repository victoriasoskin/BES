Imports System.Data.SqlClient
Imports System.Data
Imports WRCookies

Partial Class Tree
    Inherits System.Web.UI.Page
    Dim sql As String = vbNullString
    Const ConnStringName As String = "Book10VPSC"
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            WriteCookie_S("HRTree_UserID", Session("UserID"))
            If Request.QueryString("F") <> vbNullString Then
                Dim s As String = CheckFrameManager()
                If s <> vbNullString Then dbg(s, False)
            End If
            If Request.QueryString("T") = 5 Then
                Dim connStr184 As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
                Dim dbConnection184 As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr184)
                Dim cD As New SqlCommand("HR_pHQEmpList", dbConnection184)
                cD.CommandType = CommandType.StoredProcedure
                dbConnection184.Open()
                cD.ExecuteNonQuery()
                dbConnection184.Close()
            End If
        End If
        If ReadCookie_S("HRTree_UserID") Is Nothing Then dbg("חל ניתוק מהמערכת. יש להכנס מחדש", False)
        If Request.QueryString("T") IsNot Nothing Then
            UpdateTree()
        End If
    End Sub
    Sub UpdateTree()
        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStringName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        Dim sql As String = "SELECT Name,Query,TreeTable,KeyField,ParentField,RootField,NameField FROM TV_List WHERE ID = " & Request.QueryString("T")
        cD.CommandText = sql
        cD.CommandType = CommandType.Text
        Dim sQuery As String = vbNullString
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            PageHeader1.Header = dr("Name")
            sQuery = dr("Query")
            ViewState("TreeTable") = dr("TreeTable")
            ViewState("KeyField") = dr("KeyField")
            ViewState("ParentField") = dr("ParentField")
            ViewState("RootField") = dr("RootField")
            ViewState("NameField") = dr("NameField")
        End If
        dr.Close()

        sql = "SELECT ParamName,QString FROM TV_Params WHERE  TV_ListID = " & Request.QueryString("T")
        cD.CommandText = sql
        dr = cD.ExecuteReader
        While dr.Read
            Dim sParamName As String = LCase(dr("ParamName"))
            Dim sQString As String = dr("Qstring")
            If Request.QueryString(sQString) IsNot Nothing Then
                Dim sDlmtr As String = If(IsNumeric(Request.QueryString(sQString)), vbNullString, "'")
                Dim sVal As String = sDlmtr & Request.QueryString(sQString).Replace("'", "''") & sDlmtr
                sQuery = LCase(sQuery).Replace(sParamName, sVal)
            End If
        End While
        dr.Close()

        If Not ViewState("SecondManager") Then
            sql = "DECLARE @UserID int " & vbCrLf & _
              "SET @UserID = " & ReadCookie_S("HRTree_UserID") & vbCrLf & _
              "DECLARE @Q nvarchar(MAX) " & vbCrLf & _
              "DECLARE @N nvarchar(200) " & vbCrLf & _
              "SELECT @Q = Query FROM TV_List WHERE ID = " & Request.QueryString("T") & vbCrLf & _
               "EXEC TV_pXMLTree '" & sQuery.Replace("'", "''") & "',@UserID"

            cD.CommandText = sql
            Try
                dr = cD.ExecuteReader
            Catch ex As Exception
                dr.Close()
                dbConnection.Close()
                dbg("תקלת נתונים, יש להודיע לתמיכה")
            End Try
            If dr.Read Then
                Try
                    XMLDS.Data = dr(0)
                    TV.DataBind()
                Catch ex As Exception
                    dr.Close()
                    dbConnection.Close()
                    Dim s As String = "תקלת נתונים, יש להודיע לתמיכה"
                    dbg(s, False)
                End Try
            End If
            dr.Close()
            dbConnection.Close()
        End If


    End Sub
    Function CheckFrameManager() As String
        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStringName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        Dim sql As String = "SELECT UserName,FrameName from P0T_nTB u LEFT OUTER JOIN FrameList f ON f.FrameID=u.FrameID WHERE UserGroupID = 6 AND u.FrameID = " & Request.QueryString("F")
        cD.CommandText = sql
        cD.CommandType = CommandType.Text
        dbConnection.Open()
        sql = "למסגרת "
        Dim dr As SqlDataReader = cD.ExecuteReader
        Dim i As Integer = 0
        While dr.Read
            sql &= If(i = 0, dr("FrameName") & " מסומן יותר ממשתמש אחד כמנהל מסגרת", vbNullString) & "<br /><b>" & dr("UserName") & "</b>"
            i = i + 1
        End While
        If i > 1 Then sql &= "<br />יש לתקן בטבלת משתמשים כך שרק אחד יהיה מסומן כמנהל המסגרת" Else sql = vbNullString
        dr.Close()
        dbConnection.Close()
        Return sql
    End Function

    Protected Sub btnSave_Click(sender As Object, e As System.Web.UI.ImageClickEventArgs) Handles btnSave.Click
        If sql <> vbNullString Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStringName).ConnectionString()
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand(sql, dbConnection)
            dbConnection.Open()
            cD.ExecuteNonQuery()
            dbConnection.Close()
            sql = vbNullString
            UpdateTree()
        End If
        TV.ShowCheckBoxes = TreeNodeTypes.None
        ViewState("bSecondManger") = Nothing
        LVSM.SelectedIndex = -1
     End Sub
    Protected Sub TV_CheckChanged(sender As Object, e As TreeNodeEventArgs)
        If e.Node.Checked Then
            If ViewState("bSecondManger") Then
                sql &= "DELETE FROM HR_SecondManagerList WHERE EmployeeID = " & e.Node.Value & vbCrLf
                If LVSM.SelectedValue > 0 Then sql &= "INSERT INTO HR_SecondManagerList(ParentID,EmployeeID) Values(" & LVSM.SelectedValue & "," & e.Node.Value & ")" & vbCrLf
            Else
                sql &= "UPDATE " & ViewState("TreeTable") & " SET " & ViewState("ParentField") & " = " & ViewState("Parent") & " WHERE " & ViewState("KeyField") & " = " & e.Node.Value & vbCrLf
            End If
        End If
    End Sub
    Protected Sub TV_SelectedNodeChanged(sender As Object, e As System.EventArgs) Handles TV.SelectedNodeChanged
        ViewState("bSecondManger") = Nothing
        LVSM.SelectedIndex = -1
        TV.ShowCheckBoxes = TreeNodeTypes.All
        ViewState("Parent") = TV.SelectedNode.Value
        TV.SelectedNode.ShowCheckBox = False
        Dim sPath As String = TV.SelectedNode.ValuePath
        Dim s As String() = sPath.Split("/")
        Dim sX As String = vbNullString
        For i As Integer = 0 To s.Length - 1
            sX &= s(i) & "/"
            Dim n As TreeNode = TV.FindNode(Left(sX, sX.Length - 1))
            If n IsNot Nothing Then n.ShowCheckBox = False
        Next
        '   TV.Nodes(0).ShowCheckBox = False
    End Sub

    Sub lnkb_Click(sender As Object, e As System.EventArgs)
        TV.ShowCheckBoxes = TreeNodeTypes.All
        TV.Nodes(0).ShowCheckBox = False
        ViewState("bSecondManger") = True
     End Sub
    Sub dbg(s As String, Optional bError As Boolean = True, Optional NewID As Integer = 0)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""" & If(NewID = 0, "window.close();", "window.open('TTPlan.aspx?FT=1&ID=" & NewID & "','_self')") & """ /></div>")
        Response.End()
    End Sub

End Class
