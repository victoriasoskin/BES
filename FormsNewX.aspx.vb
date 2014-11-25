Imports System.Xml.XPath
Imports System.Data.SqlClient
Imports eid
Imports System.Xml.Linq
Imports System.Data
Imports System.Web.UI.DataVisualization.Charting
Imports System.Drawing
Imports WRCookies
Imports PageErrors
Imports sqlOps

Partial Class FormsNew_
    Inherits System.Web.UI.Page
    Dim rootElement As XElement
    Dim parentElement As XElement
    Dim tot As Integer
    Public sParent As String
    Dim FormNo As Integer
    Dim iStatus As Integer
    Dim CustID As Long
    Dim bauto As Boolean = False
    Dim sStatus As String
    Dim custLid As Int64
    Dim FormTypeID As Integer
    Dim CustRate As String
    Dim bLastPage As Boolean
    Dim dtRbl As New DataTable()

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then WriteCookie_S("LastCustID", Session("LastCustID"))
        If rootElement Is Nothing Then
            If Request.QueryString("F") IsNot Nothing Then
                rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
            Else
                Response.Redirect("Default.aspx")
            End If
        End If

        Dim iFtype = rootElement.Attribute("ID").Value
        FormTypeID = iFtype
        Dim dr As SqlDataReader
        Dim sFrameName As String
        Dim sFrameManager As String
        Dim sCName As String
        Dim dED As DateTime
        Dim db As New BES2DataContext
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        If IsPostBack Then
            Try
                FormNo = lblNo.Text
                WriteCookie_S("Frm_" & ReadCookie_S("LastCustID"), FormNo)
            Catch ex As Exception
                Try
                    FormNo = ReadCookie_S("Frm_" & ReadCookie_S("LastCustID"))
                    lblNo.Text = FormNo
                Catch ex1 As Exception
                    FormNo = 0
                End Try
            End Try
            If FormNo = 0 Then
                LBLERR.Text = "תקלה - השאלון לא נשמר. נא לדווח לרותם"
                LBLERR.Visible = True
                Exit Sub
            End If
            CustRate = ViewState("CustRate")
        Else

            Dim cI As New SqlCommand("", dbConnection)
            dbConnection.Open()

            If Request.QueryString("ID") IsNot Nothing Then

                ' Get Form Number and date from event list

                Try
                    cI.CommandText = "Select CustEventDate,CustRelateID,CustEventtypeID,customerid From CustEventList Where CustEventID=" & Request.QueryString("ID")
                    dr = cI.ExecuteReader
                    If dr.Read Then
                        dED = dr("CustEventDate")
                        FormNo = dr("CustRelateID")
                        WriteCookie_S("Frm_" & ReadCookie_S("LastCustID"), FormNo)
                        Session("CustEventTypeID") = dr("CustEventTypeID")
                        custLid = dr("customerid")
                        dr.Close()
                    Else
                        dr.Close()
                        dbConnection.Close()
                        LBLERR.Text = "תקלה באיתור פעולת השאלון. נא לדווח לרותם"
                        LBLERR.Visible = True
                        Exit Sub
                    End If
                Catch ex As Exception
                    Dim sBody As String = "UserID = " & Session("UserID") & "<br/>"
                    sBody = sBody & "Current Date Value = '" & If(dr("CustEventDate") Is DBNull.Value, vbNullString, dr("CustEventDate")) & "'<br/>"
                    sBody = sBody & "CustomerID = " & If(dr("CustomerID") Is DBNull.Value, vbNullString, dr("CustomerID")) & "<br />"
                    sBody = sBody & "CustEventID= " & Request.QueryString("ID") & "<br />"
                    sBody = sBody & "FormID= " & If(dr("CustRelateID") Is DBNull.Value, vbNullString, dr("CustRelateID")) & "<br />"

                    SendErrMail("נתון דפוק בשאלון, שורה 71", sBody + ex.Message)
                    Response.Redirect("ge.aspx")
                    Throw ex
                End Try

                cI.CommandText = "Select ISNULL(status,0) AS status,ISNULL(CustRate,'') AS CurRate From p5t_Forms Where FormID=" & FormNo
                Try
                    dr = cI.ExecuteReader
                    If dr.Read Then
                        Try
                            ViewState("iStatus") = dr("status")
                        Catch ex As Exception
                            ViewState("iStatus") = 0
                        End Try
                        Try
                            CustRate = dr("CustRate")
                        Catch ex As Exception
                            CustRate = vbNullString
                        End Try
                        ViewState("CustRate") = CustRate

                        dr.Close()
                    Else
                        ViewState("iStatus") = 0
                        CustRate = vbNullString
                        dr.Close()
                        dbConnection.Close()
                        Exit Sub
                    End If
                    dr.Close()
                Catch ex As Exception
                    ViewState("iStatus") = 0
                    CustRate = vbNullString
                End Try
                Dim ss As String = ViewState("CustRate")
                If ViewState("CustRate") = vbNullString Then ViewState("CustRate") = CustRate
            Else

                ' Create a new form

                Try
                    ViewState("iStatus") = 0
                    CustID = ReadCookie_S("lastcustid")
                    If CustID = 0 Then
                        Session("Forms") = -1
                        Response.Redirect("custeventreport.aspx")
                    End If

                    dED = Now()

                    cI.CommandText = "insert into p5t_Forms(FormTypeID,loadTime,UserID) Values(" & iFtype & " ,'" & Format(dED, "yyyy-MM-dd HH:mm:ss") & "'," & Session("UserID") & ")"
                    cI.CommandType = Data.CommandType.Text
                    cI.ExecuteNonQuery()
                Catch ex As Exception
                    Throw ex
                End Try

                'Get new form FormID
                Try
                    cI.CommandText = "Select FormID From p5t_Forms where FormtypeID = " & iFtype & " And loadTime = '" & Format(dED, "yyyy-MM-dd HH:mm:ss") & "' And UserID = " & Session("UserID")
                    dr = cI.ExecuteReader
                Catch ex As Exception
                    Throw ex
                End Try

                If dr.Read Then
                    FormNo = dr("FormID")
                    WriteCookie_S("Frm_" & ReadCookie_S("LastCustID"), FormNo)
                Else
                    dr.Close()
                    LBLERR.Text = "תקלה בפתיחת שאלון חדש. נא לדווח לרותם"
                    LBLERR.Visible = True
                    dbConnection.Close()
                    Exit Sub
                End If
                dr.Close()

                If Session("FrameID") Is Nothing Then
                    dbConnection.Close()
                    LBLERR.Text = "לא ניתן לפתוח שאלון חדש כזה למשתמש זה. <br /> יש להיות משויך למסגרת כדי לפתוח שאלון זה."
                    Exit Sub
                End If
                Try
                    cI.CommandText = "Select Framename,FrameManager From FrameList Where FrameID = " & Session("FrameID")
                    dr = cI.ExecuteReader
                Catch ex As Exception
                    Throw ex
                End Try

                If dr.Read Then
                    sFrameName = dr("FrameName")
                    sFrameManager = dr("FrameManager")
                Else
                    dr.Close()
                    dbConnection.Close()
                    LBLERR.Text = "תקלה באיתור פרטי המסגרת. נא לדווח לרותם"
                    LBLERR.Visible = True
                    Exit Sub
                End If
                dr.Close()
                If ViewState("iStatus") = 0 Then sStatus = " (פתוח)" Else sStatus = " (סגור)"
                Try
                    cI.CommandText = "Cust_AddEvent"
                    cI.CommandType = Data.CommandType.StoredProcedure
                    cI.Parameters.AddWithValue("@CustomerID", CustID)
                    cI.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
                    cI.Parameters.AddWithValue("@CustEventRegDate", dED)
                    cI.Parameters.AddWithValue("@CustEventDate", dED)
                    cI.Parameters.AddWithValue("@CustEventComment", "שאלון מס' " & FormNo & " (פתוח)")
                    cI.Parameters.AddWithValue("@CustFrameID", Session("FrameID"))
                    cI.Parameters.AddWithValue("@CFrameManager", sFrameManager)
                    cI.Parameters.AddWithValue("@UserID", Session("UserID"))
                    cI.Parameters.AddWithValue("@CustEventUpdateTypeID", 4)
                    cI.Parameters.AddWithValue("@CustRelateID", FormNo)
                    cI.ExecuteNonQuery()
                Catch ex As Exception
                    Throw ex
                End Try

                Dim sql As String = vbNullString

                Dim query = From qE In rootElement.Descendants("Question") _
                   Where qE.Attribute("id").Value <> 0 _
                   Select New With {.id = qE.Attribute("id").Value}
                cI.CommandType = Data.CommandType.Text
                For Each q In query
                    sql &= "insert into p5t_Answers(FormID,QuestionID) Values(" & FormNo & "," & q.id & ")" & vbCrLf
                Next
                Try
                    cI.CommandText = sql
                    cI.ExecuteNonQuery()
                Catch ex As Exception
                    Throw ex
                End Try
                query = Nothing
            End If

            cI.CommandType = Data.CommandType.Text
            If custLid = 0 Then If ReadCookie_S("LastCustID") IsNot Nothing Then custLid = ReadCookie_S("LastCustID")
            cI.CommandText = "Select CustFirstName,CustLastName,CustBirthDate From CustomerList Where CustomerID=" & custLid
            dr = cI.ExecuteReader
            If dr.Read Then
                sCName = dr("CustFirstName") & " " & dr("CustLastName")
                lblName.Text = sCName
                tbdate.Text = Format(dED, "dd/MM/yy")
                lblNo.Text = FormNo
                If ViewState("iStatus") = 0 Then
                    lblstatus.Text = " (פתוח)"
                    BTNCLS.Text = "סגירת שאלון"
                    BTNCLS.OnClientClick = "return confirm('האם לסגור את השאלון?');"
                    tbdate.Enabled = True
                Else
                    tbdate.Enabled = False
                    lblstatus.Text = " (סגור)"
                    BTNCLS.Text = "פתיחת שאלון"
                    BTNCLS.OnClientClick = "return confirm('האם לפתוח את השאלון הסגור?');"
                End If
                dr.Close()
            Else
                dr.Close()
                dbConnection.Close()
                LBLERR.Text = "תקלה באיתור פרטי לקוח. נא לדווח לרותם"
                LBLERR.Visible = True
                Exit Sub
            End If
        End If
        dbConnection.Close()
        If Not IsPostBack Then
            hdnCurrentPage.Value = "חברתי - קבוצת השווים"
            ssD()
        End If
    End Sub
    'Protected Sub TVGROUPS_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.SelectedNodeChanged
    '    ssD()
    'End Sub

    Protected Sub rbla_Load(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    'Protected Sub XDGROUPS_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles XDGROUPS.Init
    '    Dim dsx As XmlDataSource = CType(sender, XmlDataSource)
    '    dsx.DataFile = MapPath("App_Data/" & Request.QueryString("F"))
    'End Sub

    Protected Sub lblQ_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        If lbl.Text = sParent Then
            lbl.Visible = False
            Dim lvi As ListViewItem = CType(lbl.NamingContainer, ListViewItem)
            lvi.FindControl("divrow").Visible = False
        End If
        sParent = lbl.Text
    End Sub

    Protected Sub lblgrouphdr_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblgrouphdr.PreRender
        Try
            lblgrouphdr.Text = "שאלון לניהול תמיכות" & " >> " & hdnCurrentPage.Value
        Catch ex As Exception
        End Try
    End Sub

    Sub tvs0(ByVal xD As TreeNode, Optional ByVal iType As Integer = 0)
        Dim j As Integer
        If iType = 0 Then j = 0 Else j = xD.ChildNodes.Count - 1
        If xD.ChildNodes.Count > 0 Then
            tvs0(xD.ChildNodes(j), iType)
        Else
            xD.Selected = True
        End If
    End Sub
    Sub tvs1(ByVal xD As TreeNode)
        Dim i As Integer
        Try
            i = xD.Parent.ChildNodes.IndexOf(xD)
            If i + 1 < xD.Parent.ChildNodes.Count Then
                xD = xD.Parent.ChildNodes(i + 1)
                If xD.ChildNodes.Count = 0 Then
                    xD.Selected = True
                Else
                    tvs0(xD)
                End If
            Else
                Try
                    i = xD.Parent.Parent.ChildNodes.IndexOf(xD.Parent)
                    xD = xD.Parent.Parent.ChildNodes(i + 1)
                    tvs0(xD)
                Catch ex1 As Exception

                End Try
            End If
        Catch ex As Exception
        End Try
    End Sub
    Sub tvsm1(ByVal xD As TreeNode)
        Dim i As Integer
        Try
            i = xD.Parent.ChildNodes.IndexOf(xD)
            If i - 1 >= 0 Then
                xD = xD.Parent.ChildNodes(i - 1)
                xD.Selected = True
            Else
                Try
                    i = xD.Parent.Parent.ChildNodes.IndexOf(xD.Parent)
                    xD = xD.Parent.Parent.ChildNodes(i - 1)
                    tvs0(xD, 1)
                Catch ex1 As Exception

                End Try
            End If
        Catch ex As Exception
        End Try
    End Sub
    Sub ssD(Optional ByVal xE As XElement = Nothing)
        Dim sql As String = "SELECT g.sType,q.Questionid As Id,q.style,ISNULL(q.AnswerGroupId,0) AnswerGroupId,q.tb,q.txt,a.val ans,t.TextDET,a.AnswerID As ansId,ISNULL(q.sumGroup,'') sumGrp,q.FirstQuestion fQ,q.LastQuestion lQ" & vbCrLf & _
                            "FROM p5t_FormQuestionGroups g " & vbCrLf & _
                            "LEFT OUTER JOIN p5t_FormsQuestions q ON q.gid=g.gid AND q.EventTypeId=q.EventTypeID" & vbCrLf & _
                            "LEFT OUTER JOIN (SELECT * FROM p5t_Answers WHERE FormID=" & FormNo & ") a ON a.QuestionID=q.QuestionID" & vbCrLf & _
                            "LEFT OUTER JOIN (SELECT * FROM p5t_Texts WHERE FormID=" & FormNo & ") t ON t.QuestionID=q.QuestionID" & vbCrLf & _
                            "WHERE g.EventTypeId = 127 And g.Name = '" & hdnCurrentPage.Value & "'" & vbCrLf & _
                            "ORDER BY q.Ord"

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(sql, dbConnection)
        Dim dt As New DataTable()
        Dim da As New SqlDataAdapter()
        da.SelectCommand = cD
        da.Fill(dt)

        Dim sType As String = dt.Rows(0)("sType")

        Select Case sType
            Case "Question"
                diveduResults.Visible = False
                btnVersions.Enabled = False
                divlvq.Visible = True
                lv_q.DataSource = dt
                lv_q.DataBind()
            Case "eduResults"
                btnVersions.Enabled = True
                divlvq.Visible = False
                dbConnection.Open()
                Dim sSql As String = vbNullString
                Dim sSqlVersions As String = vbNullString
                Dim sSqlOrder As String = vbNullString

                '    If Session("Closing") <> 0 Then
                sSql = "DELETE FROM p5t_FormResults WHERE FormID = " & FormNo & _
                    " INSERT INTO p5t_FormResults(FormID,grp,perc,gid) " & _
                    " SELECT " & FormNo & ",Name, Weight/MAX(Weight) OVER() * a.Val , Grp " & _
                  " FROM FR_FormCalc c " & _
                      " OUTER APPLY (SELECT AVG(CAST(Val AS float)) As Val FROM p5t_Answers WHERE FormID=" & FormNo & " AND QuestionID Between c.firstQuestion AND c.lastQuestion) a " & _
                      " WHERE(FormTypeID = 4) " & _
                      " ORDER BY Grp " & _
                      " INSERT INTO p5t_FormResults(FormID,grp,perc,gid) " & _
                      " SELECT " & FormNo & ",'ממוצע',Avg(perc),99 " & _
                      "FROM p5t_FormResults WHERE FormID= " & FormNo
                cD.CommandText = sSql
                cD.ExecuteNonQuery()
                Session("Colsing") = 0
                '     End If
                '
                sSql = "SELECT grp, perc, Ld FROM (" & _
                    " SELECT grp,perc,gid,LoadTime As Ld FROM p5t_Forms f " & _
                    " LEFT OUTER JOIN p5t_FormResults r ON r.FormID = f.FormID " & _
                    " WHERE f.FormID = " & FormNo

                If btnVersions.Text = "הצג גם גרסאות קודמות" And IsPostBack Then sSqlVersions = " UNION ALL " & _
                        " SELECT grp,perc,gid,LoadTime AS Ld FROM p5t_Forms_Versions f " & _
                        " LEFT OUTER JOIN p5t_FormResults_Versions v ON f.FormID = v.FormID " & _
                        " WHERE OrgFormID = " & FormNo

                sSqlOrder = ") x ORDER BY Ld Desc,gid "

                cD.CommandText = sSql & sSqlOrder
                da = New SqlDataAdapter(cD)
                dt = New DataTable()
                da.Fill(dt)
                diveduResults.Visible = True
                lveduResults.DataSource = dt
                lveduResults.DataBind()

                cD.CommandText = sSql & sSqlVersions & sSqlOrder
                dt.Clear()
                da = New SqlDataAdapter(cD)
                da.Fill(dt)
                ShowChart(dt)
                dbConnection.Close()
        End Select
        'db.Dispose()

    End Sub
    Sub SqlUpdReSult(lv As ListView)

    End Sub
    Sub ShowChart(dt As DataTable, Optional ByVal sCharType As String = "Column", Optional ByVal sURL As String = vbNullString)
        Dim cCharType As SeriesChartType
        If sCharType = "Column" Then cCharType = SeriesChartType.Column
        If sCharType = "Bar" Then cCharType = SeriesChartType.Bar

        ' Build Color schema

        Dim c(0 To 30) As Drawing.Color
        Dim s As String = vbNullString

        c(0) = Color.DarkBlue ' Color.Goldenrod
        c(1) = Color.DeepSkyBlue
        c(2) = Color.LightGray
        c(3) = Color.DarkOrange
        c(4) = Color.Gray
        c(5) = Color.Chartreuse
        c(6) = Color.DarkSlateBlue
        c(7) = Color.DarkSeaGreen
        c(8) = Color.Brown
        c(9) = Color.Firebrick
        c(10) = Color.Green
        c(11) = Color.Blue
        c(12) = Color.Crimson
        c(13) = Color.DarkOrange
        c(14) = Color.Gray
        c(15) = Color.Chartreuse
        c(16) = Color.DarkSlateBlue
        c(17) = Color.DarkSeaGreen
        c(18) = Color.Brown
        c(19) = Color.Firebrick
        c(20) = Color.Green
        c(21) = Color.Blue
        c(22) = Color.Crimson
        c(23) = Color.DarkOrange
        c(24) = Color.Gray
        c(25) = Color.Chartreuse
        c(26) = Color.DarkSlateBlue
        c(27) = Color.DarkSeaGreen
        c(28) = Color.Brown
        c(29) = Color.Firebrick
        c(30) = Color.Green

        'Buid Chart

        chrtG.Series.Clear()
        chrtG.ChartAreas.Clear()
        chrtG.ChartAreas.Add("UNO")
        chrtG.Legends.Clear()
        chrtG.Legends.Add("ff")
        chrtG.Legends(0).Docking = Docking.Bottom
        chrtG.Legends(0).Alignment = StringAlignment.Near

        Dim iCnt As Integer = 0
        Dim dTot As Double = 0

        Dim i As Integer = 0        ' Color table index

        Dim Firstver As String = vbNullString

        For Each mRow As DataRow In dt.Rows

            ' Build Series of gid

            Dim sName As String = If(IsDBNull(mRow.Item(0)), vbNullString, mRow.Item(0)) ' Gid Name of Group
            Dim sVer = Format(mRow.Item(2), "dd/MM/yyyy")
            s = "s" & sVer
            If Firstver = vbNullString Then Firstver = s

            Dim srs As ChartNamedElement = Nothing
            Try
                srs = chrtG.Series(s)
            Catch ex As Exception
            End Try

            If srs Is Nothing Then
                chrtG.Series.Add(s)                             ' Add Series
                chrtG.Series(s).ChartType = cCharType
                chrtG.Series(s)("DrawingStyle") = "Emboss"
                chrtG.Series(s).IsVisibleInLegend = True
                chrtG.Series(s).LegendText = sVer
                chrtG.Series(s).Color = c(i)
                i = i + 1
            End If

            ' Add Data


            Dim dK As Double = If(IsDBNull(mRow.Item(1)), 0, mRow.Item(1)) ' Get Numeric Value

            chrtG.Series(s).Points.AddXY(sName, dK)                                            ' Add Point

            ' Add Column label

            If s = Firstver Then chrtG.Series(s).Points.Last.Label = Format(dK, "0.00")

            ' 
        Next

        For i = 0 To chrtG.Series.Count - 1
            chrtG.Series(i).Points.Last.BackHatchStyle = ChartHatchStyle.BackwardDiagonal
        Next

        ' General Properties of Chart

        chrtG.ChartAreas(0).AxisY.MajorGrid.Interval = 1
        chrtG.ChartAreas(0).AxisY.Interval = 1
        chrtG.ChartAreas(0).AxisX.IsReversed = True
        chrtG.ChartAreas(0).AxisY.MajorGrid.LineColor = Color.Gray
        chrtG.ChartAreas(0).AxisY.MajorGrid.LineDashStyle = DataVisualization.Charting.ChartDashStyle.Dot
        chrtG.ChartAreas(0).AxisX.MajorGrid.LineWidth = 0
        chrtG.ChartAreas(0).AxisY.Maximum = 4
        chrtG.ChartAreas(0).AxisY.Minimum = 0

        '  SaveSlide()

    End Sub

    Function vF(ByVal s As String) As Boolean
        Dim s1 As String = Eval(s)
        vF = s1 = "yes"
    End Function
    Protected Sub rbla_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        rbl.BackColor = Drawing.Color.Transparent
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdn As HiddenField = CType(lvi.FindControl("HDNANS_" & s), HiddenField)
        If rbl.SelectedIndex < 0 And hdn.Value IsNot Nothing And hdn.Value <> vbNullString Then
            rbl.SelectedValue = hdn.Value
        End If
        If lblstatus.Text = " (סגור)" Then
            Dim rv As RangeValidator = CType(lvi.FindControl("rvrbl"), RangeValidator)
            rv.Enabled = True
        End If
        If ViewState("Err") IsNot Nothing And ViewState("Err") = -1 Then
            If rbl.SelectedIndex < 0 Then
                rbl.BackColor = Drawing.Color.Plum
            End If
        End If
        If IsMaximum(rbl) Then
            rbl.BackColor = Color.Violet
        Else
            rbl.BackColor = Color.Transparent
        End If
    End Sub
    Protected Sub rbla_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnaid As HiddenField = CType(lvi.FindControl("HDNAID_" & s), HiddenField)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        'Dim lbl As Label = CType(lvi.FindControl("lblQ"), Label)
        'Dim sG As String = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim sz As String = hdnaid.Value
        If sz = vbNullString Or sz = "0" Then
            Try
                Dim ConCompI As New SqlCommand("delete from p5t_Answers where QuestionID=" & hdnid.Value & " AND FormID=" & FormNo, dbConnection)
                ConCompI.CommandType = Data.CommandType.Text
                ConCompI.ExecuteNonQuery()
                ConCompI.CommandText = "insert into p5t_Answers (FormID,QuestionID,val) values(" & FormNo & "," & hdnid.Value & "," & rbl.SelectedValue & ")"
                ConCompI.ExecuteNonQuery()
            Catch ex As Exception

                Dim sBody As String = "UserID = " & Session("UserID") & "<br/>"
                sBody = sBody & "CustomerID = " & If(ReadCookie_S("lastcustid") Is Nothing, vbNullString, ReadCookie_S("lastcustid")) & "<br />"
                sBody = sBody & "CustEventID= " & Request.QueryString("ID") & "<br />"
                sBody = sBody & "FormID= " & FormNo & "<br />"

                SendErrMail("נתון דפוק בתשובות, שורה 645", sBody + ex.Message)
                Response.Redirect("ge.aspx")
                Throw ex
            End Try
        Else
            Try
                Dim conCompU As New SqlCommand("update p5t_Answers set Val=" & rbl.SelectedValue & " Where FormID=" & FormNo & " And QuestionID=" & hdnid.Value, dbConnection)
                conCompU.CommandType = Data.CommandType.Text
                conCompU.ExecuteNonQuery()
            Catch ex As Exception
                Throw ex
            End Try
        End If
        dbConnection.Close()
    End Sub
    Function val(ByVal sF As String) As Integer
        Dim i As Integer = Eval(sF)
        tot = tot + i
        Return i
    End Function
    Protected Sub BTNCLS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNCLS.Click
        System.GC.Collect()
        Dim s As String
        If bauto Then
            bauto = False
            Exit Sub
        End If
        Dim db As New BES2DataContext
        If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
        Dim btn As Button = CType(sender, Button)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cU As New SqlCommand("", dbConnection)
        Dim sStat As String
        Dim l As Long
        Dim sComment As String = "שאלון מס " & FormNo
        Dim iNV As Integer = 0
        Select Case ViewState("iStatus")
            Case 0
                Dim tcount = From qElement In rootElement.Descendants("Question") _
                                        Join p In db.p5v_Answers _
                                          On qElement.Attribute("id").Value Equals p.QuestionID _
                                          Where p.FormID = FormNo And qElement.Element("Answer") IsNot Nothing _
                                          Group By gp = rootElement _
                                          Into cT = Sum(If(p.Val Is Nothing, 1, 0)) _
                                           Select cT

                If tcount(0) > 0 Then
                    Dim UnAns = From qElement In rootElement.Descendants("Question") _
                                        Join p In db.p5v_Answers _
                                          On qElement.Attribute("id").Value Equals p.QuestionID _
                                          Where p.FormID = FormNo And qElement.Element("Answer") IsNot Nothing _
                                          Group By gp = If(qElement.Parent.Name = "Group", qElement.Parent, qElement.Parent.Parent) _
                                          Into cT = Sum(If(p.Val Is Nothing, 1, 0)) _
                                           Select gp, cT

                    s = "יש עוד " & tcount(0) & " שאלות שלא נענו. יש להשלים את התשובות לפני סגירת השאלון. <br/>עמודים עם שאלות שלא נענו: <br/>"
                    For Each qt In UnAns
                        If qt.cT > 0 Then
                            s = s & qt.gp.Attribute("txt").Value & " - " & qt.cT & " שאלות<br/>"
                        End If
                    Next
                    LBLERR.Text = s
                    LBLERR.Visible = True
                    'TVGROUPS.ExpandAll()
                    ViewState("Err") = -1

                    Exit Sub
                Else
                    LBLERR.Visible = False
                    ViewState("Err") = Nothing
                End If
                Try
                    s = "tab_" & FormTypeID & "_1.xml"
                    Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
                    Dim qR = (From p In tabx.Descendants("Group").Elements("Ctype") _
                              Where Len(p.Attribute("ID").Value) > 0 _
                                Select p.Attribute("ID").Value).Distinct
                    ViewState("isCR") = qR.Count
                Catch ex As Exception
                    ViewState("isCR") = 0
                End Try

                cU.CommandText = "select CustRate From p5t_Forms where FormID=" & FormNo

                dbConnection.Open()
                Dim dr As SqlDataReader
                Try
                    dr = cU.ExecuteReader
                    If dr.Read Then
                        CustRate = dr("CustRate")
                        ViewState("CustRate") = CustRate
                    End If
                Catch ex As Exception
                End Try
                dr.Close()
                dbConnection.Close()


                sStat = "1"
                iNV = CopyVersion(FormNo, True)
                sComment = sComment & " (סגור) " & If(iNV > 0, "/ " & iNV + 1 & " גרסאות", vbNullString)
                Session("Closing") = 2

            Case 1
                Session("Closing") = 0
                sStat = "NULL"
                iNV = CopyVersion(FormNo, False)
                sComment = sComment & " (פתוח) " & If(iNV > 0, "/ " & iNV + 1 & " גרסאות", vbNullString)
                updResults(True)
                '   ViewState("iStatus") = 0  '27/10/2012

        End Select
        cU.CommandText = "Update p5t_Forms set status = " & sStat & ",LoadTime = GETDATE(),UserID = " & Session("UserID") & " where formid = " & FormNo
        cU.CommandType = Data.CommandType.Text
        Try
            dbConnection.Open()
            cU.ExecuteNonQuery()

            cU.CommandText = "Cust_UPDEVENTP"
            cU.CommandType = Data.CommandType.StoredProcedure
            If Request.QueryString("ID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventID", Request.QueryString("ID"))
            cU.Parameters.AddWithValue("@CustRelateID", FormNo)
            If Session("CustEventTypeID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
            cU.Parameters.AddWithValue("@CustEventComment", sComment)
            cU.ExecuteNonQuery()
            ' 
            If ViewState("iStatus") = 0 Then
                lblstatus.Text = Chr(160) & Chr(160) & "(סגור)"
                btn.Text = "פתיחת שאלון"
                btn.ToolTip = "תיפתח גרסה חדשה של השאלון העדכני"
                tbdate.Enabled = False
            Else
                lblstatus.Text = Chr(160) & Chr(160) & "(פתוח)"
                btn.Text = "סגירת שאלון"
                btn.ToolTip = "השאלון יישמר, יהיה בסטאטוס סגור, מעבר אוטומטית לגרף התוצאות"
                tbdate.Enabled = True
            End If
        Catch ex As Exception
            Dim sBody As String = "UserID = " & Session("UserID") & "<br/>"
            sBody = sBody & "CustEventTypeID = " & If(Session("CustEventTypeID") Is Nothing, vbNullString, Session("CustEventTypeID")) & "<br />"
            sBody = sBody & "CustEventID= " & If(Request.QueryString("ID") Is Nothing, vbNullString, Request.QueryString("ID")) & "<br />"
            sBody = sBody & "FormID= " & FormNo & "<br />"

            SendErrMail("נתון דפוק בשאלון, שורה 882", sBody + ex.Message)
            Response.Redirect("ge.aspx")
            Throw ex
        End Try
        '' '' '' ''If sStat = "1" Then
        dbConnection.Close()
        '' '' '' ''    bauto = True
        '' '' '' ''    Response.Redirect("CustEventReport.aspx")
        '' '' '' ''Else
        Dim j As Integer = Session("CustEventTypeID")
        'Dim qEvent = From eV In db.CustEventLists _
        '               Where eV.CustRelateID = FormNo And eV.CustEventTypeID = j _
        '               Select eV.CustEventID
        Dim qEvent = From eV In db.CustEventLists _
                       Where eV.CustRelateID = FormNo And eV.CustEventTypeID = j _
                       Select eV.CustEventID, eV.CustEventTypeID, eV.CustRelateID
        For Each x In qEvent
            l = x.CustEventID
        Next
        '  l = qEvent(0)
        s = "FormsNew.aspx?F=" & Request.QueryString("F") & "&ID=" & l
        bauto = True
        Response.Redirect(s)
        '' '' '' ''End If
    End Sub

    Protected Sub BTNCNCL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNCNCL.Click
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim db As New BES2DataContext
        dbConnection.Open()

        Dim cU As New SqlCommand("Delete from p5t_Forms  where formid = " & FormNo, dbConnection)
        cU.CommandType = Data.CommandType.Text
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from p5t_Answers  where formid = " & FormNo
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from p5t_Texts  where formid = " & FormNo
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from p5t_FormResults  where formid = " & FormNo
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        If Request.QueryString("ID") IsNot Nothing Then
            cU.CommandText = "Select max(CustEventID) as c From CustEventList Where CustEventID=" & Request.QueryString("ID")
        Else
            cU.CommandText = "Select max(CustEventID) as c From CustEventList Where CustRelateID=" & FormNo & " And CustEventTypeID=" & Session("CustEventTypeID")
        End If
        Dim ss As String = cU.CommandText
        Dim dr As SqlDataReader = cU.ExecuteReader
        Dim i As Integer = 0
        If dr.Read Then
            Try
                i = dr("c")
            Catch ex As Exception
                i = 0
            End Try
        End If
        dr.Close()

        cU.CommandText = "Cust_DelEvent"
        cU.CommandType = Data.CommandType.StoredProcedure
        cU.Parameters.AddWithValue("CustEventID", i)
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try
        dbConnection.Close()

        Response.Redirect("CustEventReport.aspx")

    End Sub
    Protected Sub tbdate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tbdate.TextChanged
        Dim db As New BES2DataContext
        Dim tb As TextBox = CType(sender, TextBox)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        If tb.Text = vbNullString Then Exit Sub
        dbConnection.Open()
        Dim cU As New SqlCommand("Cust_UPDEVENTP", dbConnection)
        cU.CommandType = Data.CommandType.StoredProcedure
        If Request.QueryString("ID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventID", Request.QueryString("ID"))
        cU.Parameters.AddWithValue("@CustRelateID", FormNo)
        If Session("CustEventTypeID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
        cU.Parameters.AddWithValue("@CustEventDate", CDate(tb.Text))
        Try
            cU.ExecuteNonQuery()
            Dim qEvent = From eV In db.CustEventLists _
             Where eV.CustRelateID = FormNo And eV.CustEventTypeID = CType(Session("CustEventTypeID"), Integer) _
             Select eV.CustEventID
            'ViewState("CustEventID") = qEvent

        Catch ex As Exception
            Throw ex
        End Try
        dbConnection.Close()
    End Sub
    Protected Sub rv_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rv As RangeValidator = CType(sender, RangeValidator)
        Dim s As String = rv.ControlToValidate
        Dim lvi As ListViewItem = CType(rv.NamingContainer, ListViewItem)
        Dim rbl As RadioButtonList = CType(lvi.FindControl(s), RadioButtonList)
        If rbl.SelectedItem IsNot Nothing Then
            Dim i As Integer = rbl.SelectedValue
            rv.MinimumValue = i
            rv.MaximumValue = i
        End If
    End Sub
    Protected Sub lblsdrg1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = tot
    End Sub
    Protected Sub rblcr_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)

        If CustRate <> vbNullString Then rbl.SelectedValue = CustRate
        'Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        'If lblstatus.Text = " (סגור)" Then
        '    Dim rv As RangeValidator = CType(lvi.FindControl("rvrbl"), RangeValidator)
        '    rv.Enabled = True
        'End If
        rbl.Visible = ViewState("iStatus") <> 1

    End Sub
    Protected Sub rblcr_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        If rbl.Items.Count = 0 Then
            Dim s As String = "tab_" & FormTypeID & "_1.xml"
            Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
            Dim qR = (From p In tabx.Descendants("Group").Elements("Ctype") _
                      Where Len(p.Attribute("ID").Value) > 0 _
                        Select p.Attribute("ID").Value).Distinct
            '    Pass the result to the LinqDataSource
            rbl.DataSource = qR
            rbl.DataBind()
            ViewState("isCR") = qR.Count
        End If

    End Sub
    Protected Sub rblcr_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cU As New SqlCommand("update p5t_Forms set CustRate='" & rbl.SelectedValue & "' Where FormID=" & FormNo, dbConnection)
        dbConnection.Open()
        Try
            cU.ExecuteNonQuery()
            CustRate = rbl.SelectedValue
            ViewState("CustRate") = CustRate
        Catch ex As Exception
            Throw ex
        End Try
        dbConnection.Close()
        LBLERR.Visible = False
        ssD()
    End Sub
    Sub updResults(Optional ByVal bDel As Boolean = False, Optional ByVal qR As Object = Nothing)
        If bDel Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("delete from p5t_FormResults Where FormID=" & FormNo, dbConnection)
            dbConnection.Open()
            Try
                cD.ExecuteNonQuery()
            Catch ex As Exception

            End Try
            dbConnection.Close()
        End If
        Dim db As New BES2DataContext
        If qR IsNot Nothing Then
            Dim r As New p5t_FormResult
            For Each q In qR

                r.FormID = q.FormID
                r.grp = q.grp
                r.perc = CDbl(q.perc)
                r.sumg = q.sumg
                r.stan = CDbl(q.stan)
                r.gid = CInt(q.gid)
                db.p5t_FormResults.InsertOnSubmit(r)
                db.SubmitChanges()
                r = Nothing
                r = New p5t_FormResult
            Next
        End If
        db.Dispose()
        System.GC.Collect()
    End Sub
    Protected Sub lblSumGroup_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim lvi As ListViewItem = CType(lbl.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("hdnfQ"), HiddenField)
        Dim sF As String = hdn.Value
        hdn = CType(lvi.FindControl("hdnlQ"), HiddenField)
        Dim sL As String = hdn.Value
        If IsNumeric(sF) And IsNumeric(sL) Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT SUM(val) AS val FROM p5t_Answers Where FormID=" & FormNo & " AND QuestionID BETWEEN " & sF & " AND " & sL, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                If Not IsDBNull(dr("val")) Then
                    lbl.Text = dr("val")
                Else
                    lbl.Text = vbNullString
                End If
            Else
                lbl.Text = vbNullString
            End If
            dr.Close()
            dbConnection.Close()
        Else
            lbl.Text = vbNullString
        End If
    End Sub
    Function CopyVersion(FormID As Integer, bCountOnly As Boolean) As Integer
        Dim iVN As Integer
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("CopyFormVersion", dbConnection)
        cD.CommandType = CommandType.StoredProcedure
        cD.Parameters.AddWithValue("@FormID", FormID)
        cD.Parameters.AddWithValue("@UserID", Session("UserID"))
        cD.Parameters.AddWithValue("@CountOnly", If(bCountOnly, 1, 0))
        Dim nv As New SqlParameter("@NumberOfVersions", DbType.Int32)
        nv.Direction = ParameterDirection.Output
        cD.Parameters.Add(nv)
        dbConnection.Open()
        cD.ExecuteNonQuery()
        iVN = nv.Value
        dbConnection.Close()

        Return iVN

    End Function

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        ssD()
    End Sub

    Protected Sub lblpleaseclose_PreRender(sender As Object, e As System.EventArgs) Handles lblpleaseclose.PreRender
        Dim B As Boolean = True
        If lblstatus.Text.Trim = "(פתוח)" Then
            If ViewState("bLastPage") Then
                lblpleaseclose.Text = "לסגירת השאלון ושמירה בבסיס הנתונים לחץ על 'סגור שאלון'"
                lblpleaseclose.BackColor = Color.LightGray
                B = False
            End If
        End If
        If B Then
            lblpleaseclose.Text = vbNullString
            lblpleaseclose.BackColor = Color.Transparent
        End If

    End Sub

    Protected Sub btnVersions_Click(sender As Object, e As System.EventArgs) Handles btnVersions.Click
        ssD()
        If btnVersions.Text = "הצג גם גרסאות קודמות" Then
            btnVersions.Text = "הצג גרסה אחרונה"
        Else
            btnVersions.Text = "הצג גם גרסאות קודמות"
        End If
    End Sub
    Protected Sub btnSave_PreRender(sender As Object, e As System.EventArgs) Handles btnSave.PreRender, BTNCNCL.PreRender
        Dim btn As Button = CType(sender, Button)
        If lblstatus.Text.Trim = "(סגור)" Then btn.Enabled = False Else btn.Enabled = True
    End Sub

    Protected Sub btnVersions_PreRender(sender As Object, e As System.EventArgs) Handles btnVersions.PreRender
        If hdnCurrentPage.Value = "תוצאות" Then btnVersions.Enabled = True Else btnVersions.Enabled = False
    End Sub

    Protected Sub BTNCLS_Unload(sender As Object, e As System.EventArgs) Handles BTNCLS.Unload
        If ViewState("bLastPage") Then BTNCLS.Enabled = True Else BTNCLS.Enabled = False
    End Sub
    Sub RemoveRblDupItems(ByRef rbl As RadioButtonList)
        Dim cItems As New Microsoft.VisualBasic.Collection
        Dim cItems2Delete As New Microsoft.VisualBasic.Collection
        For i As Integer = 0 To rbl.Items.Count - 1
            Try
                cItems.Add(rbl.Items(i).Value, rbl.Items(i).Value)
            Catch ex As Exception
                cItems2Delete.Add(i)
            End Try
        Next
        For i = cItems2Delete.Count To 1 Step -1
            rbl.Items.RemoveAt(cItems2Delete(i))
        Next
    End Sub
    Protected Sub rbla_DataBinding(sender As Object, e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("hdnAnswerGroupId"), HiddenField)
        If rbl.Items.Count = 0 Then
            Dim b As Boolean = rbl.Items.Count = 0
            If Not b Then b = b Or hdn.Value <> dtRbl.Rows(0)("AnswerGroupId")
            If b Then
                dtRbl = New DataTable()
                Dim lv As ListView = CType(lvi.NamingContainer, ListView)
                Dim s As String = Right(lv.ID, 1)
                Dim sql As String = "SELECT '[' + CAST(val AS nvarchar(4)) + '] ' + txt txt,val,AnswerGroupId" & vbCrLf & _
                                    "FROM p5t_FormsAnswerGruops " & vbCrLf & _
                                    "WHERE EventTypeID=127 AND AnswerGroupId = " & hdn.Value
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim cD As New SqlCommand(sql, dbConnection)
                Dim da As New SqlDataAdapter(cD)
                da.Fill(dtRbl)
            End If
            rbl.DataSource = dtRbl
        End If
        If rbl.Items.Count > 0 Then
            hdn = CType(lvi.FindControl("hdnAns"), HiddenField)
            Dim li As ListItem = rbl.Items.FindByValue(hdn.Value)
            If li IsNot Nothing Then
                rbl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub
    Protected Sub btngid_PreRender(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        If hdnCurrentPage.Value = btn.ToolTip Then
            btn.BackColor = Drawing.ColorTranslator.FromHtml("#EEEEEE")
        Else
            btn.BackColor = Drawing.ColorTranslator.FromHtml("#C0C0C0")
        End If
    End Sub
    Protected Sub btngid_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        hdnCurrentPage.Value = btn.ToolTip
        ssD()
        lblgrouphdr.Text = "שאלון לניהול תמיכות >> " & btn.ToolTip
    End Sub

    Private Function IsMaximum(rbl As RadioButtonList) As Boolean
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        If rbl.SelectedValue <> vbNullString Then
            Dim val As Integer = 0
            Dim ind As Integer = -1
            For Each lvi In lv.Items
                Dim rbli As RadioButtonList = CType(lvi.FindControl("rbla_q"), RadioButtonList)
                If rbli IsNot Nothing Then
                    If rbli.SelectedValue <> vbNullString Then
                        If rbli.SelectedValue > val Then val = rbli.SelectedValue
                    End If
                End If
            Next
            Return rbl.SelectedValue >= val
        End If
        Return False
    End Function

End Class
