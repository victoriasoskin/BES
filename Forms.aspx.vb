Imports System.Xml.XPath
Imports System.Data.SqlClient
Imports eid
Imports System.Xml.Linq
Imports System.Data
Imports System.Web.UI.DataVisualization.Charting
Imports System.Drawing
Imports PageErrors

Partial Class Forms
    Inherits System.Web.UI.Page
    Dim rootElement As XElement
    Dim parentElement As XElement
    Dim tot As Integer
    Public sParent As String
    Dim cSIS As Collection
    Dim FormNo As Integer
    Dim iStatus As Integer
    Dim CustID As Long
    Dim bauto As Boolean = False
    Dim sStatus As String
    Dim custLid As Int64
    Dim FormTypeID As Integer
    Dim CustRate As String

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("F") Is Nothing Then Response.Redirect("Default.aspx")
        If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
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
            Catch ex As Exception
                FormNo = 0
            End Try
            If FormNo = 0 Then
                LBLERR.Text = "תקלה - הטופס לא נשמר. נא לדווח לרותם"
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
                        Session("CustEventTypeID") = dr("CustEventTypeID")
                        custLid = dr("customerid")
                        dr.Close()
                    Else
                        dr.Close()
                        dbConnection.Close()
                        LBLERR.Text = "תקלה באיתור פעולת הטופס. נא לדווח לרותם"
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

                cI.CommandText = "Select status,CustRate From p5t_Forms Where FormID=" & FormNo
                Try
                    dr = cI.ExecuteReader
                    If dr.Read Then
                        Try
                            iStatus = dr("status")
                        Catch ex As Exception
                            iStatus = 0
                        End Try
                        Try
                            CustRate = dr("CustRate")
                        Catch ex As Exception
                            CustRate = vbNullString
                        End Try
                        ViewState("CustRate") = CustRate

                        dr.Close()
                    Else
                        iStatus = 0
                        CustRate = vbNullString
                        dr.Close()
                        dbConnection.Close()
                        Exit Sub
                    End If
                    dr.Close()
                Catch ex As Exception
                    iStatus = 0
                    CustRate = vbNullString
                End Try
                Dim ss As String = ViewState("CustRate")
                If ViewState("CustRate") = vbNullString Then ViewState("CustRate") = CustRate
            Else

                ' Create a new form

                Try
                    iStatus = 0
                    CustID = Session("lastcustid")
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
                Else
                    dr.Close()
                    LBLERR.Text = "תקלה בפתיחת טופס חדש. נא לדווח לרותם"
                    LBLERR.Visible = True
                    dbConnection.Close()
                    Exit Sub
                End If
                dr.Close()

                If Session("FrameID") Is Nothing Then
                    dbConnection.Close()
                    LBLERR.Text = "לא ניתן לפתוח טופס חדש כזה למשתמש זה. <br /> יש להיות משויך למסגרת כדי לפתוח טופס זה."
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
                ViewState("STATUS") = iStatus
                If iStatus = 0 Then sStatus = " (פתוח)" Else sStatus = " (סגור)"
                Try
                    cI.CommandText = "Cust_AddEvent"
                    cI.CommandType = Data.CommandType.StoredProcedure
                    cI.Parameters.AddWithValue("@CustomerID", CustID)
                    cI.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
                    cI.Parameters.AddWithValue("@CustEventRegDate", dED)
                    cI.Parameters.AddWithValue("@CustEventDate", dED)
                    cI.Parameters.AddWithValue("@CustEventComment", "טופס מס' " & FormNo & " (פתוח)")
                    cI.Parameters.AddWithValue("@CustFrameID", Session("FrameID"))
                    cI.Parameters.AddWithValue("@CFrameManager", sFrameManager)
                    cI.Parameters.AddWithValue("@UserID", Session("UserID"))
                    cI.Parameters.AddWithValue("@CustEventUpdateTypeID", 4)
                    cI.Parameters.AddWithValue("@CustRelateID", FormNo)
                    cI.ExecuteNonQuery()
                Catch ex As Exception
                    Throw ex
                End Try

                'Dim qEvent = From eV In db.CustEventLists _
                ' Where eV.CustRelateID = FormNo And eV.CustEventTypeID = CType(Session("CustEventTypeID"), Integer) _
                ' Select eV.CustEventID

                'ViewState("CustEventID") = CType(qEvent, Integer)


                Dim query = From qE In rootElement.Descendants("Question") _
                   Where qE.Attribute("id").Value <> 0 _
                   Select New With {.id = qE.Attribute("id").Value}
                cI.CommandType = Data.CommandType.Text
                Try
                    For Each q In query
                        cI.CommandText = "insert into p5t_Answers(FormID,QuestionID) Values(" & FormNo & "," & q.id & ")"
                        cI.ExecuteNonQuery()
                    Next
                Catch ex As Exception
                    Throw ex
                End Try
                query = Nothing
            End If

            cI.CommandType = Data.CommandType.Text
            If Session("LASTCUSTID") IsNot Nothing Then custLid = Session("LASTCUSTID")
            cI.CommandText = "Select CustFirstName,CustLastName,CustBirthDate From CustomerList Where CustomerID=" & custLid
            dr = cI.ExecuteReader
            If dr.Read Then
                sCName = dr("CustFirstName") & " " & dr("CustLastName")
                lblName.Text = sCName
                tbdate.Text = Format(dED, "dd/MM/yy")
                lblNo.Text = FormNo
                If iStatus = 0 Then
                    lblstatus.Text = " (פתוח)"
                    BTNCLS.Text = "סגירה"
                    BTNCLS.OnClientClick = "return confirm('האם לסגור את הטופס?');"
                    tbdate.Enabled = True
                Else
                    tbdate.Enabled = False
                    lblstatus.Text = " (סגור)"
                    BTNCLS.Text = "פתיחה"
                    BTNCLS.OnClientClick = "return confirm('האם לפתוח את הטופס הסגור?');"
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
        db.Dispose()
        System.GC.Collect()

    End Sub
    Protected Sub TVGROUPS_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.SelectedNodeChanged
        ssD()
    End Sub

    Protected Sub rbla_Load(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        If rbl.Items.Count = 0 Then
            Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
            Dim lv As ListView = CType(lvi.NamingContainer, ListView)
            Dim s As String = Right(lv.ID, 1)
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnid_" & s), HiddenField)
            If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
            Dim qR = From p In rootElement.Descendants("Question").Descendants("Answer") _
                        Where p.Parent.Attribute("id").Value = hdn.Value _
                        Select txt = "[" & p.Descendants("val").Value & "] " & (p.Descendants("txt").Value & " ").PadRight(20, Chr(160)), _
                        Val = p.Descendants("val").Value
            '    Pass the result to the LinqDataSource
            rbl.DataSource = qR
            rbl.DataBind()
            qR = Nothing
            System.GC.Collect()
        End If

    End Sub

    Protected Sub XDGROUPS_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles XDGROUPS.Init
        Dim dsx As XmlDataSource = CType(sender, XmlDataSource)
        dsx.DataFile = MapPath("App_Data/" & Request.QueryString("F"))
    End Sub

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
            lblgrouphdr.Text = TVGROUPS.SelectedNode.Parent.Value & " >> " & TVGROUPS.SelectedValue
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click, Button1A.Click
        LBLERR.Visible = False
        Dim Nd As TreeNode = TVGROUPS.Nodes(0)
        tvs0(Nd)
        ssD()
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
        System.GC.Collect()
        If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
        Dim db As New BES2DataContext
        db.ObjectTrackingEnabled = False
        Dim rx As XElement
        Dim xPathQuery As String
        Dim sType As String
        If xE Is Nothing Then

            ' The fist two conditions are necessary, because this procedure
            ' can be called e.g. during page loading (that means the
            ' TreeView hasn't been loaded yet) or when no TreeNode
            ' is selected
            If TVGROUPS IsNot Nothing AndAlso TVGROUPS.SelectedNode IsNot Nothing AndAlso Not TVGROUPS.SelectedNode.Equals(TVGROUPS.Nodes(0)) Then
                ' Get the XPath address of the selected branch/department
                xPathQuery = TVGROUPS.SelectedNode.DataPath

                ' Cut the root element path from the XPath query
                Dim rootElementXPath As String = TVGROUPS.Nodes(0).DataPath
                xPathQuery = xPathQuery.Substring(rootElementXPath.Length)

                ' Get the element representing the selected group
                parentElement = rootElement.XPathSelectElement(xPathQuery)
                'parentElement = parentElement.ElementsAfterSelf.First
            Else

                ' When no department/branch is (can be) selected, we will
                ' browse records in the root element
                parentElement = rootElement
                Exit Sub
            End If
        Else
            parentElement = xE
        End If
        sType = parentElement.Attribute("stype")

        ' Select the descendant employees in the branch/department   Dim query = From employeeElement In parentElement.Descendants("Employee") _ 
        'Dim query = From qElement In parentElement.Descendants("Question") _
        '            Select New With { _
        '            .txt = qElement.Attribute("txt").Value}

        Dim query = From qElement In parentElement.Descendants("Question") _
                           Group Join p In db.p5v_Answers _
                           On qElement.Attribute("id").Value Equals p.QuestionID _
                           Into xT = Group _
                           From pd In xT.DefaultIfEmpty _
                           Where If(pd Is Nothing, FormNo, pd.FormID) = FormNo _
                           Select New With {.parent = qElement.Parent.Element("txt").Value, _
                                             .id = qElement.Attribute("id").Value, _
                                             .style = qElement.Elements("style").Value, _
                                             .tb = qElement.Elements("textbox").Value, _
                                             .txt = qElement.Elements("txt").Value, _
                                             .ans = If(pd Is Nothing, Nothing, pd.Val), _
                                             .textdet = If(pd Is Nothing, Nothing, pd.TextDET), _
                                             .ansid = If(pd Is Nothing, Nothing, pd.AnswerID), _
                                            .sumGrp = If(qElement.Attribute("sumGroup") Is Nothing, vbNullString, qElement.Attribute("sumGroup").Value), _
                                            .fQ = If(qElement.Attribute("firstQuestion") Is Nothing, vbNullString, qElement.Attribute("firstQuestion").Value), _
                                            .lQ = If(qElement.Attribute("lastQuestion") Is Nothing, vbNullString, qElement.Attribute("lastQuestion").Value) _
                                           }

        Select Case sType
            Case "lqResults"

                Dim s As String = "tab_" & FormTypeID & "_1.xml"
                Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))

                'Dim ddd = From fg In tabx.Descendants("Sgrade") _
                '            Where fg.Attribute("Grade").Value = 24 _
                '                    And fg.Parent.Attribute("ID").Value = "70>" _
                '                    And fg.Parent.Parent.Attribute("Name") = "שביעות רצון" _
                'Select New With {.rrt = fg.Attribute("Percentage").Value}



                'For Each xtt In ddd
                '    Response.Write(xtt.rrt)
                'Next

                'Response.End()

                Dim query4 = From qE In rootElement.Descendants("Question") _
                              Join p In db.p5v_Answers _
                              On qE.Attribute("id").Value Equals p.QuestionID _
                              Where qE.Attribute("txt") <> "הנחיות" And qE.Attribute("txt") <> "תוצאות" And p.FormID = FormNo _
                               Group By gp = qE.Parent.Element("txt").Value, id = qE.Parent.Attribute("gid").Value _
                               Into xT = Sum(p.Val) _
                                 Select New With {.FormID = FormNo, _
                                                  .grp = gp, _
                                                  .gid = id, _
                                                  .sumg = xT, _
                                                  .stan = xT, _
                                                  .perc = (From t3 In tabx.Descendants("Sgrade") _
                                                            Where t3.Attribute("Grade").Value = xT _
                                                                    And (t3.Parent.Attribute("ID").Value = CustRate) _
                                                                    And t3.Parent.Parent.Attribute("Name") = gp _
                                                           Select t3.Attribute("Percentage").Value).Take(1).FirstOrDefault}
                If Session("Closing") = 2 Then
                    updResults(True, query4)
                    Session("Closing") = 1
                End If
                diveduResults.Visible = False
                divlvq.Visible = False
                divlvs.Visible = False
                divlvp.Visible = False
                divrsis.Visible = False
                divrlq.Visible = True
                lvr_r.DataSource = query4
                lvr_r.DataBind()
                query4 = Nothing

            Case "Para"
                diveduResults.Visible = False
                divlvq.Visible = False
                divlvs.Visible = False
                divlvp.Visible = True
                divrlq.Visible = False
                divrsis.Visible = False
                lv_p.DataSource = query
                lv_p.DataBind()
            Case "Question"
                diveduResults.Visible = False
                divlvq.Visible = True
                divlvp.Visible = False
                divlvs.Visible = False
                divrlq.Visible = False
                divrsis.Visible = False
                lv_q.DataSource = query
                lv_q.DataBind()
            Case "Subgroup"
                diveduResults.Visible = False
                divlvq.Visible = False
                divlvp.Visible = False
                divrsis.Visible = False
                divrlq.Visible = False
                divlvs.Visible = True
                lv_s.DataSource = query
                lv_s.DataBind()
            Case "sisResults"

                rx = rootElement.Descendants("Title").First
                Dim t62 As XElement = XElement.Load(MapPath("app_data/tab_3_1.xml"))
                Dim query1 = From qElement In rx.Descendants("Question") _
                                 Join p In db.p5v_Answers _
                                   On qElement.Attribute("id").Value Equals p.QuestionID _
                                   Where p.FormID = FormNo _
                                   Group By gp = qElement.Parent.Parent.Element("txt").Value, id = qElement.Parent.Parent.Attribute("gid").Value _
                                   Into xT = Sum(p.Val) _
                                    Select New With {.FormID = FormNo, _
                                                     .grp = gp, _
                                                     .gid = id, _
                                                     .sumg = xT, _
                                                     .stan = (From t2 In t62.Descendants.Elements _
                                                             Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
                                                            Select t2.Attribute("standard").Value).Take(1).SingleOrDefault, _
                                                     .perc = (From t2 In t62.Descendants.Elements _
                                                             Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
                                                            Select t2.Attribute("percentage").Value).Take(1).SingleOrDefault}
                If Session("Closing") = 2 Then
                    updResults(True, query1)
                    Session("Closing") = 1
                End If
                cSIS = New Collection
                For Each q In query1
                    Try
                        cSIS.Add(q.stan)
                    Catch ex As Exception
                    End Try
                Next

                diveduResults.Visible = False
                divlvq.Visible = False
                divlvs.Visible = False
                divlvp.Visible = False
                divrsis.Visible = True
                lvsis.DataSource = query1
                lvsis.DataBind()

                query1 = Nothing
                System.GC.Collect()

                rx = rootElement.Descendants("Title").ElementAtOrDefault(1)
                Dim query2 = (From qElement In rx.Descendants("Question") _
                   Join p In db.p5v_Answers _
                  On qElement.Attribute("id").Value Equals p.QuestionID _
                    Where p.FormID = FormNo _
                    Group By gp = qElement.Parent.Element("txt").Value _
                  Into xT = Sum(p.Val) _
                  Order By xT Descending _
                   Select New With {.sgrpnam = gp, _
                     .sumg = xT}).Take(4)

                lvsis2.DataSource = query2
                lvsis2.DataBind()
                query2 = Nothing
                System.GC.Collect()

                rx = rootElement.Descendants("Title").ElementAtOrDefault(2)
                Dim query3 = From qElement In rx.Descendants("Question") _
                                         Join p In db.p5v_Answers _
                                           On qElement.Attribute("id").Value Equals p.QuestionID _
                                           Where p.FormID = FormNo _
                                           Group By gp = qElement.Parent.Parent.Element("txt").Value _
                                           Into sT = Sum(p.Val), cT = Sum(If(p.Val > 0, 1, 0)) _
                                            Select New With {.grp = gp, _
                                                             .sumg = sT, _
                                                             .L5 = If(sT > 5, "כן", "לא"), _
                                                             .M2 = If(cT > 1, "כן", "לא")}


                For Each q In query3
                    Select Case q.grp
                        Case "תמיכות רפואיות נדרשות"
                            lblmed1.Text = q.sumg
                            lblmed2.Text = q.L5
                            lblmed3.Text = q.M2
                        Case "תמיכות התנהגותיות נדרשות"
                            lblbeh1.Text = q.sumg
                            lblbeh2.Text = q.L5
                            lblbeh3.Text = q.M2
                    End Select
                Next
                query3 = Nothing
                System.GC.Collect()
            Case "eduResults"
                divlvq.Visible = False
                divrsis.Visible = False
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim cD As New SqlCommand("SELECT Grp,Name,Weight/MAX(Weight) OVER() * a.Val As RT " & _
                  " FROM FR_FormCalc c " & _
                      " OUTER APPLY (SELECT AVG(CAST(Val AS float)) As Val FROM p5t_Answers WHERE FormID=" & FormNo & " AND QuestionID Between c.firstQuestion AND c.lastQuestion) a " & _
                      " WHERE(FormTypeID = 4) " & _
                      " ORDER BY Grp", dbConnection)

                dbConnection.Open()
                Dim da As New SqlDataAdapter(cD)
                Dim dt As New DataTable()
                da.Fill(dt)
                diveduResults.Visible = True
                lveduResults.DataSource = dt
                lveduResults.DataBind()
                dbConnection.Close()
                ShowChart()

        End Select
        db.Dispose()
        query = Nothing
        System.GC.Collect()

    End Sub
    Sub ShowChart(Optional ByVal sCharType As String = "Column", Optional ByVal sURL As String = vbNullString)
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

        ChrtG.Series.Clear()
        ChrtG.ChartAreas.Clear()
        ChrtG.ChartAreas.Add("test")
        '        ChrtG.Legends.Clear()
        '        ChrtG.Legends.Add("ff")

        Dim i As Integer
        Dim j As Integer
        Dim l As Integer = 0

        Dim lv As ListView = lveduResults


        s = "s" & l
        chrtG.Series.Add(s)

        chrtG.Series(s).ChartType = cCharType
        Dim iCnt As Integer = 0
        Dim dTot As Double = 0
        For i = 0 To lv.Items.Count - 1

            Dim lvi As ListViewItem = lv.Items(i)
            Dim lbl As Label = CType(lvi.FindControl("lblName"), Label)
            Dim sName As String = lbl.Text


            chrtG.Series(s)("DrawingStyle") = "Emboss"
            '            chrtG.Series(s).IsVisibleInLegend = True
            '                chrtG.Series(s).LegendText = gvr.Cells(0).Text
            '              chrtG.Legends(0).Docking = Docking.Bottom
            '             chrtG.Legends(0).Alignment = StringAlignment.Near

            '      chrtG.Series(s).Color = c(l)


            ' Add Data


            'l = l + 1  ' Column Index

            lbl = CType(lvi.FindControl("lblRT"), Label)
            Dim dK As Double = If(IsNumeric(lbl.Text), CDbl(lbl.Text), 0) ' Get Numeric Value
            iCnt += 1
            dTot += dK
  
            chrtG.Series(s).Points.AddXY(sName, dK)                                            ' Add Point

            ' Add Column label

            '    chrtG.Series(s).Points(i - 1).Label = Format(dK, "0.00")



            chrtG.ChartAreas(0).AxisX.IsReversed = True

            chrtG.ChartAreas(0).AxisY.MajorGrid.LineColor = Color.Gray
            chrtG.ChartAreas(0).AxisY.MajorGrid.Interval = 1
            chrtG.ChartAreas(0).AxisY.Interval = 1
            chrtG.ChartAreas(0).AxisY.MajorGrid.LineDashStyle = DataVisualization.Charting.ChartDashStyle.Dot
            chrtG.ChartAreas(0).AxisX.MajorGrid.LineWidth = 0

            ' 
        Next
        chrtG.Series(s).Points.AddXY("ממוצע עוצמת התמיכות", dTot / CDbl(iCnt)) ' Add Point
        chrtG.Series(s).Points.Last.Color = c(1)
        chrtG.ChartAreas(0).AxisX.IsReversed = True
        chrtG.ChartAreas(0).AxisY.MajorGrid.LineColor = Color.Gray
        chrtG.ChartAreas(0).AxisY.MajorGrid.LineDashStyle = DataVisualization.Charting.ChartDashStyle.Dot
        chrtG.ChartAreas(0).AxisX.MajorGrid.LineWidth = 0
        chrtG.ChartAreas(0).AxisY.Maximum = 4
        chrtG.ChartAreas(0).AxisY.Minimum = 0
        '  SaveSlide()
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click, Button2A.Click
        LBLERR.Visible = False
        Dim Nd As TreeNode = TVGROUPS.SelectedNode
        If Nd.ChildNodes.Count > 0 Then
            tvs0(Nd, 1)
        Else
            tvsm1(Nd)
        End If
        If TVGROUPS.SelectedNode.ChildNodes.Count = 0 Then ssD()
    End Sub


    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click, Button3A.Click
        LBLERR.Visible = False
        Dim Nd As TreeNode
        Try
            Nd = TVGROUPS.SelectedNode
            Dim s As String = Nd.Value
            If Nd.ChildNodes.Count > 0 Then
                tvs0(Nd)
                ssD()
                Exit Sub
            End If
        Catch ex As Exception

            tvs0(TVGROUPS.Nodes(0))
            ssD()
            Exit Sub
        End Try
        tvs1(Nd)
        ssD()
    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click, Button4A.Click
        LBLERR.Visible = False
        Dim Nd As TreeNode = TVGROUPS.Nodes(0)
        tvs0(Nd, 1)
        ssD()
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
                sBody = sBody & "CustomerID = " & If(Session("lastcustid") Is Nothing, vbNullString, Session("lastcustid")) & "<br />"
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
        'Dim lbl1 As Label
        'Dim j As Integer = 0
        'Dim b As Boolean = False
        'For Each lvi1 In lv.Items
        '    lbl = CType(lvi1.FindControl("lblQ" & s), Label)
        '    If lbl.Text = sG Then
        '        If Not b Then
        '            lbl1 = CType(lvi.FindControl("lbltot_" & s), Label)
        '            b = True
        '        End If
        '        rbl = CType(lvi1.FindControl("rbla_" & s), RadioButtonList)
        '        j = j + rbl.SelectedValue
        '    End If
        'Next
        'lbl.Text = j
    End Sub
    Protected Sub tb_OnTextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Dim lvi As ListViewItem = CType(tb.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnaid As HiddenField = CType(lvi.FindControl("HDNAID_" & s), HiddenField)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim rbl As RadioButtonList = CType(lvi.FindControl("rbla_" & s), RadioButtonList)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Try
            Dim ConCompI As New SqlCommand("delete from p5t_Texts where QuestionID=" & hdnid.Value & " AND FormID=" & FormNo, dbConnection)
            ConCompI.CommandType = Data.CommandType.Text
            ConCompI.ExecuteNonQuery()
            ConCompI.CommandText = "insert into p5t_texts (FormID,QuestionID,textdet) values(" & FormNo & "," & hdnid.Value & ",'" & Replace(tb.Text, "'", "''") & "')"
            ConCompI.ExecuteNonQuery()
            ConCompI.CommandText = "Select AnswerID From p5t_Answers Where FormID =" & FormNo & " And QuestionID = " & hdnid.Value
            Dim dR As SqlDataReader = ConCompI.ExecuteReader
            If Not dR.Read() Then
                dR.Close()
                ConCompI.CommandText = "insert into p5t_answers(Formid,QuestionID) Values(" & FormNo & "," & hdnid.Value & ")"
                ConCompI.ExecuteNonQuery()
            End If
        Catch ex As Exception
            Throw ex
        End Try
        dbConnection.Close()
    End Sub

    Protected Sub TVGROUPS_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.DataBound
        If Not IsPostBack Then
            Dim Nd As TreeNode = TVGROUPS.Nodes(0)
            tvs0(Nd, iStatus)
            ssD()
        End If
    End Sub
    Function val(ByVal sF As String) As Integer
        Dim i As Integer = Eval(sF)
        tot = tot + i
        Return i
    End Function
    Function tval() As Integer
        Return tot
    End Function
    Protected Sub lblsums_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = tot
    End Sub

    Protected Sub lblindex_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim t63 As XElement = XElement.Load(MapPath("app_data/tab_3_2.xml"))
        Dim query = From q In t63.Elements _
                     Where q.Attribute("standard").Value = tot _
                    Select New With {.formid = FormNo, _
                                     .grp = "סיכום", _
                                     .gid = 99, _
                                     .sumg = tot, _
                                     .stan = q.Attribute("index").Value, _
                                     .perc = q.Attribute("percentage").Value}
        If Session("Closing") = 1 Then updResults(False, query)
        Session("Closing") = 0
        For Each q In query
            lbl.Text = q.stan
            cSIS.Add(q.stan)
        Next
        Dim lv As ListView = CType(lbl.NamingContainer, ListView)
        lbl = CType(lv.FindControl("lblspercent"), Label)
        For Each q In query
            lbl.Text = q.perc
        Next
        query = Nothing
        System.GC.Collect()
    End Sub
    Protected Sub lblb1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        If lbl.Text = "_" Then lbl.ForeColor = Drawing.Color.White
        Dim s As String = lbl.ID
        Dim i As Integer = Int(Right(s, 3))
        Dim j As Integer = Int(Mid(s, 10, 2))
        Dim c As Drawing.Color
        If j = 7 Then c = Drawing.Color.Goldenrod Else c = Drawing.Color.Gold
        Try
            If i <= cSIS(j) Then
                lbl.BackColor = c
                If lbl.Text = "_" Then lbl.ForeColor = c
            End If
        Catch ex As Exception

        End Try

    End Sub
    Function bF(ByVal sF As String) As Boolean
        Dim s As String = Eval(sF)
        Dim b As Boolean = s = sParent
        Return b
    End Function
    Function sF() As String
        sParent = Eval("parent")
        Return sParent
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
        Dim sComment As String = "טופס מס " & FormNo
        Select Case btn.Text
            Case "סגירה"
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

                    s = "יש עוד " & tcount(0) & " שאלות שלא נענו. יש להשלים את התשובות לפני סגירת הטופס. <br/>עמודים עם שאלות שלא נענו: <br/>"
                    For Each qt In UnAns
                        If qt.cT > 0 Then
                            s = s & qt.gp.Attribute("txt").Value & " - " & qt.cT & " שאלות<br/>"
                        End If
                    Next
                    LBLERR.Text = s
                    LBLERR.Visible = True
                    TVGROUPS.ExpandAll()
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


                If ViewState("isCR") > 0 And ViewState("CustRate") = vbNullString Then
                    LBLERR.Text = "לא נבחרה רמת משכל"
                    LBLERR.Visible = True
                    TVGROUPS.ExpandAll()
                    ViewState("Err") = -1
                    Exit Sub
                End If
                sStat = "1"
                sComment = sComment & " (סגור)"
                Session("Closing") = 2
            Case "פתיחה"
                Session("Closing") = 0
                sStat = "NULL"
                sComment = sComment & " (פתוח)"
                updResults(True)
        End Select
        cU.CommandText = "Update p5t_Forms set status = " & sStat & " where formid = " & FormNo
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
            If sStat = "1" Then
                lblstatus.Text = Chr(160) & Chr(160) & "(סגור)"
                btn.Text = "פתיחה"
                tbdate.Enabled = False
            Else
                lblstatus.Text = Chr(160) & Chr(160) & "(פתוח)"
                btn.Text = "סגירה"
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
        s = "Forms.aspx?F=" & Request.QueryString("F") & "&ID=" & l
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
        rbl.Visible = iStatus <> 1

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

    Protected Sub lblsprc_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        CustRate = ViewState("CustRate")
        Dim s As String = "tab_" & FormTypeID & "_2.xml"
        Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
        Dim qR = (From p In tabx.Descendants("Sgrade") _
                  Where p.Attribute("Grade").Value = tot _
                        And (CustRate = vbNullString Or p.Parent.Attribute("ID") = CustRate) _
                    Select New With {.FormID = FormNo, _
                                     .grp = "סיכום", _
                                     .gid = 99, _
                                     .sumg = tot, _
                                     .stan = tot, _
                                     .perc = p.Attribute("Percentage").Value})
        If Session("Closing") = 1 Then updResults(False, qR)
        Session("Closing") = 0
        For Each q In qR
            lbl.Text = q.perc
        Next
        qR = Nothing
    End Sub
    Protected Sub lblcr_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        CustRate = ViewState("CustRate")
        lbl.Text = CustRate
        lbl.Visible = iStatus = 1
    End Sub
    Protected Sub lblcri_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim lv As ListView = CType(lbl.NamingContainer, ListView)
        Dim rbl As RadioButtonList = CType(lv.FindControl("rblcr"), RadioButtonList)
        lbl.Visible = rbl IsNot Nothing
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
End Class
