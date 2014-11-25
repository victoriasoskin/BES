Imports System.Xml.XPath
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Net.Mail.MailMessage
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Net.Configuration
Imports System.Data
Imports MessageBox

Partial Class Surveys
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
    Dim SurveyID As Integer
    Dim CustRate As String
    Dim sMode As String
    Dim sLimit As String
    Dim cFrames As New Collection
    Dim sBTNCLS As String
    Dim bz As Boolean = False
    Dim exc As Exception
    Dim bLog As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("SurveyEntry.aspx")
        WLog(35)
        If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
        Dim iFtype = rootElement.Attribute("ID").Value
        sMode = rootElement.Attribute("mode").Value
        If sMode = "surveynoid" Then divSelectFrame.Visible = True
        sLimit = rootElement.Attribute("limit").Value
        If sMode = "vote" Then
            sBTNCLS = "שליחת ההצבעות"
        Else
            sBTNCLS = "שליחה למערכת"
        End If

        BTNCLS.Text = sBTNCLS
        btncls0.Text = sBTNCLS
        SurveyID = iFtype
        Dim dr As SqlDataReader
        Dim dED As DateTime
        Dim iJobID As Integer = 0
        Dim iSenID As Integer = 0
        Dim db As New BES2DataContext
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        If Session("FrameID") IsNot Nothing Then
            Dim v() As String = Split(Session("FrameID"), "|")
            For i As Integer = 1 To v.Count()
                cFrames.Add(v(i - 1), v(i - 1) & vbNullString)
            Next
        ElseIf sMode <> "surveynoid" Then
            '    SendMail("שורה 63 " & FormNo & " " & sMode)
            '    Response.Redirect("SessionEnded.aspx")
            'Else
            Exit Sub
        End If

        If IsPostBack Then
            Try
                FormNo = Session("FormNO")
            Catch ex As Exception
                FormNo = 0
            End Try
            If FormNo = 0 Then
                Dim ComDC As New SqlCommand("Select isnull(Done,0) as FormNo  From vSurveyIDList Where ID=" & Session("LastCustID"), dbConnection)
                dbConnection.Open()
                Dim trDC As SqlDataReader = ComDC.ExecuteReader
                Try
                    If trDC.Read Then
                        FormNo = trDC("FormNo")
                        Session("FormNo") = FormNo
                    End If
                Catch ex As Exception
                    FormNo = 0
                    exc = ex
                End Try
                LBLERR.Text = "תקלה - הטופס לא נשמר. נא לדווח לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה."
                LBLERR.Visible = True
                SendMail(LBLERR.Text + exc.ToString)
                trDC.Close()
                dbConnection.Close()
                SendMail("שורה 93 " & FormNo)
                Response.Redirect("MALFUNCTION.aspx")
                Exit Sub
            End If
            CustRate = ViewState("CustRate")
        Else
            Dim cI As New SqlCommand("", dbConnection)
            dbConnection.Open()
            Try
                If Session("LastCustID") Is Nothing Then
                    SendMail("שורה 102 " & FormNo)
                    Response.Redirect("SessionEnded.aspx")
                End If
                cI.CommandText = "Select isnull(Done,0) as done,isnull(JobID,'') as JobID,StartDate,isnull(SeniorityID,0) as senid From vSurveyIDList Where ID=" & Session("LastCustID") & If(sMode = "surveynoid" Or Session("SurveyPWD") IsNot Nothing, "", " And FrameID = " & cFrames(1)) & " And SurveyID = " & iFtype
                dr = cI.ExecuteReader
                If dr.Read Then
                    FormNo = dr("Done")
                    Session("FormNo") = FormNo
                    iJobID = dr("JobID")
                    iSenID = dr("senid")
                    dr.Close()
                Else
                    dr.Close()
                    dbConnection.Close()
                    LBLERR.Text = "תקלה באיתור פעולת הטופס. נא לדווח לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה"
                    LBLERR.Visible = True
                    SendMail(LBLERR.Text & " FrameID = " & cFrames(1))
                    Exit Sub
                End If
            Catch ex As Exception
                LBLERR.Text = "תקלה מספר 94.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
                LBLERR.Visible = True
                SendMail(LBLERR.Text & "<br /> " & cI.CommandText & "<BR />" & ex.Message)
            End Try

            If Session("FormNo") <> 0 Then

                ' Get Form Number and date from event list

            Else

                ' Create a new form
                If Session("LastCustID") Is Nothing Then
                    SendMail(" שורה 134 " & FormNo)
                    Response.Redirect("SessionEnded.aspx")
                End If
                If Session("Mode") = "survey" Then
                    cI.CommandText = "Select JobID,isnull(SeniorityID,0) as SeniorityID From vSurveyIDList Where ID=" & Session("LastCustID") & " And FrameID = " & cFrames(1) & " And SurveyID = " & iFtype
                    dr = cI.ExecuteReader
                    If dr.Read Then
                        iJobID = dr("JobID")
                        iSenID = dr("SeniorityID")
                    End If
                    dr.Close()
                End If
                iStatus = 0
                If Session("LastCustID") Is Nothing Then
                    SendMail("שורה 150 " & FormNo)
                    Response.Redirect("SessionEnded.aspx")
                End If
                CustID = Session("lastcustid")
                If CustID = 0 And Session("UserID") <> 32111 Then
                    Session("Forms") = -1
                    'Response.Redirect("custeventreport.aspx")
                End If
                dED = Now()

                cI.CommandText = "insert into Survey_Forms(SurveyID,FrameID,JobID,SenID,loadTime) Values(" & iFtype & " ," & cFrames(1) & "," & iJobID & "," & iSenID & ",'" & Format(dED, "yyyy-MM-dd HH:mm:ss") & "')"
                cI.CommandType = Data.CommandType.Text
                cI.ExecuteNonQuery()

                'Get new form FormID
                cI.CommandText = "Select FormID From Survey_Forms where SurveyID = " & iFtype & " And loadTime = '" & Format(dED, "yyyy-MM-dd HH:mm:ss") & "' and JobID = " & iJobID & " and Senid = " & iSenID & " and frameID=" & cFrames(1)
                dr = cI.ExecuteReader
                If dr.Read Then
                    FormNo = dr("FormID")
                    Session("FormNo") = FormNo
                Else
                    dr.Close()
                    LBLERR.Text = "תקלה בפתיחת טופס חדש. נא לדווח לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה"
                    LBLERR.Visible = True
                    SendMail(LBLERR.Text)
                    dbConnection.Close()
                    Exit Sub
                End If
                dr.Close()
                If Session("LastCustID") Is Nothing Then
                    SendMail(" שורה 179 " & FormNo)
                    Response.Redirect("SessionEnded.aspx")
                End If

                Dim s As String = "Update SurveyIDList set Done = " & FormNo & " Where ID=" & Session("LastCustID") & " And SurveyID = " & iFtype
                If Session("SurveyPWD") Is Nothing Then If Session("Mode") = "survey" Then s = s & " And FrameID = " & cFrames(1)
                cI.CommandText = s
                Try
                    cI.ExecuteNonQuery()
                Catch ex As Exception
                End Try

                Dim query = From qE In rootElement.Descendants("Question") _
                   Where qE.Attribute("id").Value <> 0 _
                   Select New With {.id = qE.Attribute("id").Value, _
                                    .mf = If(qE.Attribute("perframe") Is Nothing, "no", qE.Attribute("perframe").Value)}
                cI.CommandType = Data.CommandType.Text
                Try
                    For Each q In query
                        'Select Case q.mf
                        '    Case "no"
                        cI.CommandText = "insert into Survey_Answers(FormID,QuestionID) Values(" & FormNo & "," & q.id & ")"
                        '        Case "yes"
                        '    cI.CommandText = "insert into Survey_Answers(FormID,QuestionID,FrameID) Select " & FormNo & " As FormID," & q.id & " As QuestionID, FrameID From eFrameList Where FormID=" & FormNo
                        '    End Select
                        cI.ExecuteNonQuery()
                    Next
                    query = Nothing
                Catch ex As Exception
                    LBLERR.Text = "תקלה מספר 163.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
                    LBLERR.Visible = True
                    SendMail(LBLERR.Text & "<br /> " & cI.CommandText & "<BR />" & ex.Message)
                End Try
            End If
        End If
        dbConnection.Close()
        db.Dispose()
        System.GC.Collect()
        WLog(207)
    End Sub
    Protected Sub TVGROUPS_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.SelectedNodeChanged
        WLog(210)
        ssD()
        WLog(212)
    End Sub

    Protected Sub rbla_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        WLog(216)
        Dim db As New BES2DataContext
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        If rbl.Items.Count = 0 Then
            'Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
            'Dim lv As ListView = CType(lvi.NamingContainer, ListView)
            'Dim s As String = Right(lv.ID, 1)
            '         Dim hdn As HiddenField = CType(lvi.FindControl("hdnid_" & s), HiddenField)
            '	If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
            '         Dim qR = From p In rootElement.Descendants("Question").Descendants("Answer") _
            '            Join f In db.vEFrameLists On p.Parent.Parent.Parent.Attribute("ID").Value Equals f.SurveyID _
            '             Where p.Parent.Attribute("id").Value = hdn.Value And f.FormID = Session("FormNo") And If(p.Parent.Attribute("mult") Is Nothing, "0", p.Parent.Attribute("mult").Value) = "1" _
            '             Order By f.FrameID, p.Descendants("val").Value Descending _
            '            Select txt = "[" & p.Descendants("val").Value & "_" & f.framename & "] " & (p.Descendants("txt").Value & " ").PadRight(20, Chr(160)), _
            '            Val = p.Descendants("val").Value
            Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
            Dim lv As ListView = CType(lvi.NamingContainer, ListView)
            Dim s As String = Right(lv.ID, 1)
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnid_" & s), HiddenField)
            If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
            Dim qR = From p In rootElement.Descendants("Question").Descendants("Answer") _
               Where p.Parent.Attribute("id").Value = hdn.Value _
               Select txt = (p.Descendants("txt").Value & " ").PadRight(20, Chr(160)), _
               Val = p.Descendants("val").Value
            'Select txt = "[" & p.Descendants("val").Value & "] " & (p.Descendants("txt").Value & " ").PadRight(20, Chr(160)), _
            '    Pass the result to the LinqDataSource
            rbl.DataSource = qR
            rbl.DataBind()
            qR = Nothing
        End If
        db.Dispose()
        System.GC.Collect()
        WLog(245)
    End Sub

    Protected Sub XDGROUPS_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles XDGROUPS.Init
        WLog(249)
        Dim dsx As XmlDataSource = CType(sender, XmlDataSource)
        dsx.DataFile = MapPath("App_Data/" & Request.QueryString("F"))
    End Sub

    Protected Sub lblQ_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        WLog(255)
        Dim lbl As Label = CType(sender, Label)
        If lbl.Text = sParent Then
            lbl.Visible = False
            Dim lvi As ListViewItem = CType(lbl.NamingContainer, ListViewItem)
            lvi.FindControl("divrow").Visible = False
        End If
        sParent = lbl.Text
    End Sub

    Protected Sub lblgrouphdr_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblgrouphdr.PreRender
        WLog(266)
        Try
            lblgrouphdr.Text = TVGROUPS.SelectedValue ' TVGROUPS.SelectedNode.Parent.Value & " >> " & TVGROUPS.SelectedValue
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click, Button1A.Click
        WLog(274)
        LBLERR.Visible = False
        Dim Nd As TreeNode = TVGROUPS.Nodes(0)
        tvs0(Nd)
        ssD()
        WLog(279)
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

        ' if url is defined for this group go to url

        If parentElement.Attribute("url") IsNot Nothing Then Response.Redirect(parentElement.Attribute("url").Value)

        sType = parentElement.Attribute("stype")
        FormNo = Session("FormNo")
        If Session("FrameID") IsNot Nothing Then Dim iFrameID As Integer = cFrames(1)
        ' Select the descendant employees in the branch/department   Dim query = From employeeElement In parentElement.Descendants("Employee") _ 
        'Dim query = From qElement In parentElement.Descendants("Question") _
        '            Select New With { _
        '            .txt = qElement.Attribute("txt").Value}

        Dim query = From qElement In parentElement.Descendants("Question") _
         Group Join p In db.vSurvey_Answers _
         On qElement.Attribute("id").Value Equals p.QuestionID _
         Into xT = Group _
         From pd In xT.DefaultIfEmpty _
         Where If(pd Is Nothing, FormNo, pd.FormID) = FormNo _
         Select New With {.parent = qElement.Parent.Element("txt").Value, _
         .id = If(qElement.Attribute("id").Value <> "0", qElement.Attribute("id").Value, " "), _
         .style = qElement.Elements("style").Value, _
         .tb = qElement.Elements("textbox").Value, _
         .txt = If(pd Is Nothing, "", If(pd.FrameName Is DBNull.Value, "", "<u><font color=""blue"">" & pd.FrameName & "</font></u><br/>")) & qElement.Elements("txt").Value & _
         If(If(qElement.Attribute("must") Is Nothing, "no", qElement.Attribute("must").Value) = "yes", "<br/><u><b><font color=""red"">שאלת חובה</font></b></u>", ""), _
         .ans = If(pd Is Nothing, Nothing, pd.Val), _
         .textdet = If(pd Is Nothing, Nothing, pd.TextDET), _
         .ansid = If(pd Is Nothing, Nothing, pd.AnswerID), _
         .fid = If(pd Is Nothing, Nothing, pd.FormID), _
         .FrameID = If(pd Is Nothing, Nothing, pd.FrameID), _
         .control = If(qElement.Attribute("control") Is Nothing, "radiobuttonlist", qElement.Attribute("control").Value)}
        ''Dim query = From qElement In parentElement.Descendants("Question") _
        '' Group Join p In db.vSurvey_Answers _
        '' On qElement.Attribute("id").Value Equals p.QuestionID _
        '' Into xT = Group _
        '' From pd In xT.DefaultIfEmpty _
        '' Where If(pd Is Nothing, FormNo, pd.FormID) = FormNo _
        '' Select New With {.parent = qElement.Parent.Element("txt").Value, _
        '' .id = qElement.Attribute("id").Value, _
        '' .style = qElement.Elements("style").Value, _
        '' .tb = qElement.Elements("textbox").Value, _
        '' .txt = qElement.Elements("txt").Value, _
        '' .ans = If(pd Is Nothing, Nothing, pd.Val), _
        '' .textdet = If(pd Is Nothing, Nothing, pd.TextDET), _
        '' .ansid = If(pd Is Nothing, Nothing, pd.AnswerID), _
        '' .fid = If(pd Is Nothing, Nothing, pd.FormID)}
        Dim i As Integer = 0
        'For Each q In query
        '	Response.Write(q.fid & " ")
        '	i = i + 1
        'Next
        'Response.Write("<br /> " & i)
        'Response.End()

        Select Case sType
            Case "lqResults"

                'Dim s As String = "tab_" & SurveyID & "_1.xml"
                'Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))

                ''Dim ddd = From fg In tabx.Descendants("Sgrade") _
                ''            Where fg.Attribute("Grade").Value = 24 _
                ''                    And fg.Parent.Attribute("ID").Value = "70>" _
                ''                    And fg.Parent.Parent.Attribute("Name") = "שביעות רצון" _
                ''Select New With {.rrt = fg.Attribute("Percentage").Value}



                ''For Each xtt In ddd
                ''    Response.Write(xtt.rrt)
                ''Next

                ''Response.End()

                'Dim query4 = From qE In rootElement.Descendants("Question") _
                '  Join p In db.vSurvey_Answers _
                '  On qE.Attribute("id").Value Equals p.QuestionID _
                '  Where qE.Attribute("txt") <> "הנחיות" And qE.Attribute("txt") <> "תוצאות" And p.FormID = FormNo _
                '   Group By gp = qE.Parent.Element("txt").Value, id = qE.Parent.Attribute("gid").Value _
                '   Into xT = Sum(p.Val) _
                '  Select New With {.FormID = FormNo, _
                ' .grp = gp, _
                ' .gid = id, _
                ' .sumg = xT, _
                ' .stan = xT, _
                ' .perc = (From t3 In tabx.Descendants("Sgrade") _
                '  Where t3.Attribute("Grade").Value = xT _
                ' And (t3.Parent.Attribute("ID").Value = CustRate) _
                ' And t3.Parent.Parent.Attribute("Name") = gp _
                ' Select t3.Attribute("Percentage").Value).Take(1).FirstOrDefault}

                'If Session("Closing") = 2 Then
                '    updResults(True, query4)
                '    Session("Closing") = 1
                'End If

                'divlvq.Visible = False
                'divlvs.Visible = False
                'divlvp.Visible = False
                'divrsis.Visible = False
                'divrlq.Visible = True
                'lvr_r.DataSource = query4
                'lvr_r.DataBind()

            Case "Para"
                divlvq.Visible = False
                'divlvs.Visible = False
                divlvp.Visible = True
                'divrlq.Visible = False
                'divrsis.Visible = False
                lv_p.DataSource = query
                lv_p.DataBind()
            Case "Question"
                divlvq.Visible = True
                divlvp.Visible = False
                'divlvs.Visible = False
                'divrlq.Visible = False
                'divrsis.Visible = False
                lv_q.DataSource = query
                lv_q.DataBind()
            Case "Subgroup"
                divlvq.Visible = False
                'divlvp.Visible = False
                'divrsis.Visible = False
                'divrlq.Visible = False
                'divlvs.Visible = True
                'lv_s.DataSource = query
                'lv_s.DataBind()
            Case "sisResults"

                'rx = rootElement.Descendants("Title").First
                'Dim t62 As XElement = XElement.Load(MapPath("app_data/tab_3_1.xml"))
                'Dim query1 = From qElement In rx.Descendants("Question") _
                '  Join p In db.vSurvey_Answers _
                ' On qElement.Attribute("id").Value Equals p.QuestionID _
                ' Where p.FormID = FormNo _
                ' Group By gp = qElement.Parent.Parent.Element("txt").Value, id = qElement.Parent.Parent.Attribute("gid").Value _
                ' Into xT = Sum(p.Val) _
                '  Select New With {.FormID = FormNo, _
                ' .grp = gp, _
                ' .gid = id, _
                ' .sumg = xT, _
                ' .stan = (From t2 In t62.Descendants.Elements _
                '   Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
                '  Select t2.Attribute("standard").Value).Take(1).SingleOrDefault, _
                ' .perc = (From t2 In t62.Descendants.Elements _
                '   Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
                '  Select t2.Attribute("percentage").Value).Take(1).SingleOrDefault}
                'If Session("Closing") = 2 Then
                '    updResults(True, query1)
                '    Session("Closing") = 1
                'End If
                'cSIS = New Collection
                'For Each q In query1
                '    Try
                '        cSIS.Add(q.stan)
                '    Catch ex As Exception
                '    End Try
                'Next


                'rx = rootElement.Descendants("Title").ElementAtOrDefault(1)
                'Dim query2 = (From qElement In rx.Descendants("Question") _
                '   Join p In db.vSurvey_Answers _
                '  On qElement.Attribute("id").Value Equals p.QuestionID _
                ' Where p.FormID = FormNo _
                ' Group By gp = qElement.Parent.Element("txt").Value _
                '  Into xT = Sum(p.Val) _
                '  Order By xT Descending _
                '   Select New With {.sgrpnam = gp, _
                '  .sumg = xT}).Take(4)

                'rx = rootElement.Descendants("Title").ElementAtOrDefault(2)
                'Dim query3 = From qElement In rx.Descendants("Question") _
                ' Join p In db.vSurvey_Answers _
                '   On qElement.Attribute("id").Value Equals p.QuestionID _
                '   Where p.FormID = FormNo _
                '   Group By gp = qElement.Parent.Parent.Element("txt").Value _
                '   Into sT = Sum(p.Val), cT = Sum(If(p.Val > 0, 1, 0)) _
                ' Select New With {.grp = gp, _
                '   .sumg = sT, _
                '   .L5 = If(sT > 5, "כן", "לא"), _
                '   .M2 = If(cT > 1, "כן", "לא")}


                ''divlvq.Visible = False
                'divlvs.Visible = False
                'divlvp.Visible = False
                'divrsis.Visible = True
                'lvsis.DataSource = query1
                'lvsis.DataBind()
                'lvsis2.DataSource = query2
                'lvsis2.DataBind()
                'For Each q In query3
                '    Select Case q.grp
                '        Case "תמיכות רפואיות נדרשות"
                '            lblmed1.Text = q.sumg
                '            lblmed2.Text = q.L5
                '            lblmed3.Text = q.M2
                '        Case "תמיכות התנהגותיות נדרשות"
                '            lblbeh1.Text = q.sumg
                '            lblbeh2.Text = q.L5
                '            lblbeh3.Text = q.M2
                '    End Select
                'Next

        End Select
        query = Nothing
        System.GC.Collect()
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click, Button2A.Click
        WLog(575)
        LBLERR.Visible = False
        Dim Nd As TreeNode = TVGROUPS.SelectedNode
        If Nd.ChildNodes.Count > 0 Then
            tvs0(Nd, 1)
        Else
            tvsm1(Nd)
        End If
        If TVGROUPS.SelectedNode.ChildNodes.Count = 0 Then ssD()
        WLog(584)
    End Sub


    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click, Button3A.Click
        WLog(589)
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
        WLog(609)
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
        WLog(622)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        rbl.CssClass = "rblbrdr"
        If sMode = "vote" Or rbl.Items.Count > 5 Then
            rbl.RepeatDirection = RepeatDirection.Vertical
            rbl.Font.Size = FontSize.XLarge
        End If
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
        WLog(646)
    End Sub
    Protected Sub rbla_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        WLog(649)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim up As UpdatePanel = CType(lvi.FindControl("up_q"), UpdatePanel)
        If Session("Mode") = "vote" Then
            If Not LegalVote(rbl.SelectedValue) Then
                rbl.SelectedIndex = -1
                Dim script As String = "alert('!אי אפשר לבחור פרויקט של המסגרת שלך');"
                ScriptManager.RegisterStartupScript(Me, Me.GetType(), "בחירה", script, True)
                Exit Sub

            End If
        End If
        Dim s As String = Right(lv.ID, 1)
        Dim hdnaid As HiddenField = CType(lvi.FindControl("HDNAID_" & s), HiddenField)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdnfrmid As HiddenField = CType(lvi.FindControl("HDNFRMID_" & s), HiddenField)
        'Dim lbl As Label = CType(lvi.FindControl("lblQ"), Label)
        'Dim sG As String = lbl.Text
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim sz As String = hdnaid.Value
        If sz = vbNullString Or sz = "0" Then
            Try
                Dim ConCompI As New SqlCommand("delete from Survey_Answers where QuestionID=" & hdnid.Value & " AND FormID=" & FormNo & If(hdnfrmid.Value = vbNullString, "", " And FrameID=" & hdnfrmid.Value), dbConnection)
                ConCompI.CommandType = Data.CommandType.Text
                ConCompI.ExecuteNonQuery()
                ConCompI.CommandText = "insert into Survey_Answers (FormID,QuestionID,val,FramID) values(" & FormNo & "," & hdnid.Value & "," & rbl.SelectedValue & "," & If(hdnfrmid.Value = vbNullString, "NULL", hdnfrmid.Value) & ")"
                ConCompI.ExecuteNonQuery()
            Catch ex As Exception

                LBLERR.Text = "תקלה מספר 594.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
                LBLERR.Visible = True
                SendMail(LBLERR.Text & "<br /> " & ex.Message)
            End Try
        Else
            Try
                Dim conCompU As New SqlCommand("update Survey_Answers set Val=" & rbl.SelectedValue & " Where FormID=" & FormNo & " And QuestionID=" & hdnid.Value & If(hdnfrmid.Value = vbNullString, "", " And FrameID=" & hdnfrmid.Value), dbConnection)
                conCompU.CommandType = Data.CommandType.Text
                conCompU.ExecuteNonQuery()
            Catch ex As Exception
                LBLERR.Text = "תקלה מספר 94.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
                LBLERR.Visible = True
                SendMail(LBLERR.Text & "<BR />" & ex.Message)
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
        WLog(716)
    End Sub
    Protected Sub tb_OnTextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        WLog(719)
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
            Dim ConCompI As New SqlCommand("delete from Survey_Texts where QuestionID=" & hdnid.Value & " AND FormID=" & FormNo, dbConnection)
            ConCompI.CommandType = Data.CommandType.Text
            ConCompI.ExecuteNonQuery()
            ConCompI.CommandText = "insert into Survey_texts (FormID,QuestionID,textdet) values(" & FormNo & "," & hdnid.Value & ",'" & Replace(tb.Text, "'", "''") & "')"
            ConCompI.ExecuteNonQuery()
            ConCompI.CommandText = "Select AnswerID From Survey_Answers Where FormID =" & FormNo & " And QuestionID = " & hdnid.Value
            Dim dR As SqlDataReader = ConCompI.ExecuteReader
            If Not dR.Read() Then
                dR.Close()
                ConCompI.CommandText = "insert into Survey_answers(Formid,QuestionID) Values(" & FormNo & "," & hdnid.Value & ")"
                ConCompI.ExecuteNonQuery()
            End If
        Catch ex As Exception
            LBLERR.Text = "תקלה מספר 651.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
            LBLERR.Visible = True
            SendMail(LBLERR.Text & "<br /> " & "<BR />" & ex.Message)
        End Try
        dbConnection.Close()
        WLog(750)
    End Sub

    Protected Sub TVGROUPS_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.DataBound
        WLog(754)
        If Not IsPostBack Then
            Dim Nd As TreeNode = TVGROUPS.Nodes(0)
            tvs0(Nd, iStatus)
            ssD()
        End If
        WLog(760)
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
    Function LegalVote(ByVal iAns As Integer) As Boolean
        'If rootElement Is Nothing Then rootElement = XElement.Load(MapPath("App_Data/" & Request.QueryString("F")))
        'Dim query = From qElement In rootElement.Descendants("Answer") _
        ' Where qElement.Descendants("val").Value = iAns _
        ' Select qElement.Descendants("frame").Value
        'Dim s As String = vbNullString
        'For Each q In query
        '    Try
        '        s = cFrames(q & vbNullString)
        '    Catch ex As Exception

        '    End Try
        '    Return s = vbNullString
        'Next
    End Function
    Protected Sub BTNCLS_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNCLS.Click
        System.GC.Collect()
        bLog = True
        WLog(842)
        Dim s As String = vbNullString
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
        cU.CommandText = "Select count(*) as cnt from EFrameList Where FormID=" & FormNo
        cU.CommandType = CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cU.ExecuteReader
        Dim iFrameSelected As Integer
        If dr.Read Then
            iFrameSelected = If(dr("cnt") > 0, 0, 1)
        Else
            iFrameSelected = 0
        End If
        dr.Close()
        dbConnection.Close()

        Dim sComment As String = "טופס מס " & FormNo
        Dim tcount = From qElement In rootElement.Descendants("Question") _
          Join p In db.vSurvey_Answers _
         On qElement.Attribute("id").Value Equals p.QuestionID _
         Where p.FormID = FormNo And qElement.Element("Answer") IsNot Nothing _
         Group By gp = rootElement _
         Into cT = Sum(If(p.Val Is Nothing, 1, 0)) _
          Select cT
        Dim itcount As Integer = tcount(0)
        tcount = Nothing
        System.GC.Collect()
        Dim mustCount = From qElement In rootElement.Descendants("Question") _
  Join p In db.vSurvey_Answers _
 On qElement.Attribute("id").Value Equals p.QuestionID _
 Where p.FormID = FormNo And qElement.Element("Answer") IsNot Nothing And If(qElement.Attribute("must") Is Nothing, "no", qElement.Attribute("must").Value) = "yes" _
 Group By gp = rootElement.Parent _
 Into cT = Sum(If(p.Val Is Nothing, 1, 0)) _
  Select cT
        Dim mustc As Integer = mustCount(0)
        mustCount = Nothing
        System.GC.Collect()

        If (itcount > 0 And Left(LBLERR.Text, 2) <> "יש") Or (mustc + iFrameSelected > 0) Then
            'Dim UnAns = From qElement In rootElement.Descendants("Question") _
            '  Join p In db.vSurvey_Answers _
            ' On qElement.Attribute("id").Value Equals p.QuestionID _
            ' Where p.FormID = FormNo And qElement.Element("Answer") IsNot Nothing _
            ' Group By gp = If(qElement.Parent.Name = "Group", qElement.Parent, qElement.Parent.Parent) _
            ' Into cT = Sum(If(p.Val Is Nothing, 1, 0)) _
            '  Select gp, cT
            Dim s2 As String = vbNullString
            If mustc + iFrameSelected > 0 Then s2 = "יש עוד " & CStr(mustc + iFrameSelected) & " שאלות חובה שלא נענו<br/>"
            Dim s1 As String = vbNullString '= "יש עוד " & itcount & " שאלות שלא נענו<br/>"
            s = "יש עוד " & itcount & " שאלות שלא נענו(מסומנות עם רקע סגול). <br/>באפשרותך לחזור לפרקים הקודמים ולהשלים את תשובותיך: <br/>"
            'For Each qt In UnAns
            '    If qt.cT > 0 Then
            '        s = s & "ב'" & qt.gp.Attribute("txt").Value & "' - " & qt.cT & " שאלות - המסומנות כעת עם רקע ורוד<br/>"
            '    End If
            'Next
            'UnAns = Nothing
            '  s1 = s1 & s & "אם ברצונך לסיים למרות זאת, יש ללחוץ שנית על '" & sBTNCLS & "'"
            s1 = s2 & s1 & s '& sBTNCLS & "'"
            MessageBox.Show(Replace(s1, "<br/>", "\n"))
            LBLERR.Text = s1
            LBLERR.Visible = True
            'TVGROUPS.ExpandAll()
            ViewState("Err") = -1
            bauto = True
            db.Dispose()
            System.GC.Collect()
            Exit Sub
        Else
            LBLERR.Visible = False
            ViewState("Err") = Nothing
            db.Dispose()
            System.GC.Collect()
        End If
        ' '' ''Try
        ' '' ''			s = "tab_" & SurveyID & "_1.xml"
        ' '' ''			Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
        ' '' ''			Dim qR = (From p In tabx.Descendants("Group").Elements("Ctype") _
        ' '' ''			 Where Len(p.Attribute("ID").Value) > 0 _
        ' '' ''			   Select p.Attribute("ID").Value).Distinct
        ' '' ''			ViewState("isCR") = qR.Count
        ' '' ''		Catch ex As Exception
        ' '' ''			ViewState("isCR") = 0
        ' '' ''		End Try

        ' '' ''		cU.CommandText = "select CustRate From Survey_Forms where FormID=" & FormNo

        ' '' ''		dbConnection.Open()
        ' '' ''		Dim dr As SqlDataReader
        ' '' ''		Try
        ' '' ''			dr = cU.ExecuteReader
        ' '' ''			If dr.Read Thenpw
        ' '' ''				CustRate = dr("CustRate")
        ' '' ''				ViewState("CustRate") = CustRate
        ' '' ''			End If
        ' '' ''		Catch ex As Exception
        ' '' ''		End Try
        ' '' ''		dr.Close()
        ' '' ''		dbConnection.Close()


        ' '' ''		If ViewState("isCR") > 0 And ViewState("CustRate") = vbNullString Then
        ' '' ''			LBLERR.Text = "לא נבחרה רמת משכל"
        ' '' ''			LBLERR.Visible = True
        ' '' ''			TVGROUPS.ExpandAll()
        ' '' ''			ViewState("Err") = -1
        ' '' ''			Exit Sub
        ' '' ''		End If
        ' '' ''		sStat = "1"
        ' '' ''		sComment = sComment & " (סגור)"
        ' '' ''		Session("Closing") = 2
        ' '' ''	Case "פתיחה"
        ' '' ''		Session("Closing") = 0
        ' '' ''		sStat = "NULL"
        ' '' ''		sComment = sComment & " (פתוח)"
        ' '' ''		updResults(True)
        ' '' ''End Select
        cU.CommandText = "Update Survey_Forms set status = 1 where formid = " & FormNo
        cU.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try
        If sMode = "surveynoid" Then
            cU.CommandText = "Update SurveyIDList set Done = NULL where Done = " & FormNo
        Else
            cU.CommandText = "Update SurveyIDList set Done = -1 where Done = " & FormNo
        End If
        cU.CommandType = Data.CommandType.Text
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
            LBLERR.Text = "תקלה מספר 847.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
            LBLERR.Visible = True
            SendMail(LBLERR.Text & "*****************<br /> " & cU.CommandText & "<BR />" & ex.Message)
            Response.Redirect("SurveyThanks.aspx")
        End Try
        dbConnection.Close()


        '' ''cU.CommandText = "Cust_UPDEVENTP"
        '' ''cU.CommandType = Data.CommandType.StoredProcedure
        '' ''If Request.QueryString("ID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventID", Request.QueryString("ID"))
        '' ''cU.Parameters.AddWithValue("@CustRelateID", FormNo)
        '' ''If Session("CustEventTypeID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
        '' ''cU.Parameters.AddWithValue("@CustEventComment", sComment)
        '' ''cU.ExecuteNonQuery()
        ' 
        '' '' ''	If sStat = "1" Then
        '' '' ''		lblstatus.Text = Chr(160) & Chr(160) & "(סגור)"
        '' '' ''		btn.Text = "פתיחה"
        '' '' ''		tbdate.Enabled = False
        '' '' ''	Else
        '' '' ''		lblstatus.Text = Chr(160) & Chr(160) & "(פתוח)"
        '' '' ''		btn.Text = "שליחה למערכת"
        '' '' ''		tbdate.Enabled = True
        '' '' ''	End If
        '' '' ''Catch ex As Exception
        '' '' ''	Throw ex
        '' '' ''End Try
        '' '' '' '' '' '' ''If sStat = "1" Then
        '' '' ''dbConnection.Close()
        '' '' '' '' '' '' ''    bauto = True
        '' '' '' '' '' '' ''    Response.Redirect("CustEventReport.aspx")
        '' '' '' '' '' '' ''Else
        '' '' ''Dim j As Integer = Session("CustEventTypeID")
        ' '' '' ''Dim qEvent = From eV In db.CustEventLists _
        ' '' '' ''               Where eV.CustRelateID = FormNo And eV.CustEventTypeID = j _
        ' '' '' ''               Select eV.CustEventID
        '' '' ''Dim qEvent = From eV In db.CustEventLists _
        '' '' ''   Where eV.CustRelateID = FormNo And eV.CustEventTypeID = j _
        '' '' ''   Select eV.CustEventID, eV.CustEventTypeID, eV.CustRelateID
        '' '' ''For Each x In qEvent
        '' '' ''	l = x.CustEventID
        '' '' ''Next
        ' '' '' ''  l = qEvent(0)
        '' '' ''s = "Surveys.aspx?F=" & Request.QueryString("F") & "&ID=" & l
        Session("FormNo") = Nothing
        '' '' ''bauto = True
        If sMode <> "surveynoid" Then
            Response.Redirect("~/SurveyThanks.aspx")
        Else
            Session("FrameID") = Nothing
            Session("FormNo") = Nothing
            Session("framename") = Nothing

            Response.Redirect("Surveys.aspx?f=" & Request.QueryString("f"))
        End If
        '' '' '' ''End If
        WLog(1032)
    End Sub

    Protected Sub BTNCNCL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNCNCL.Click
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim db As New BES2DataContext
        dbConnection.Open()

        Dim cU As New SqlCommand("Delete from Survey_Forms  where formid = " & FormNo, dbConnection)
        cU.CommandType = Data.CommandType.Text
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from Survey_Answers  where formid = " & FormNo
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from Survey_Texts  where formid = " & FormNo
        Try
            cU.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        cU.CommandText = "Delete from Survey_FormResults  where formid = " & FormNo
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

        'cU.CommandText = "Cust_DelEvent"
        'cU.CommandType = Data.CommandType.StoredProcedure
        'cU.Parameters.AddWithValue("CustEventID", i)
        'Try
        '	cU.ExecuteNonQuery()
        'Catch ex As Exception
        'End Try
        'dbConnection.Close()

        ''Response.Redirect("CustEventReport.aspx")

    End Sub
    Protected Sub tbdate_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tbdate.TextChanged
        'Dim db As New BES2DataContext
        'Dim tb As TextBox = CType(sender, TextBox)
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'If tb.Text = vbNullString Then Exit Sub
        'dbConnection.Open()
        'Dim cU As New SqlCommand("Cust_UPDEVENTP", dbConnection)
        'cU.CommandType = Data.CommandType.StoredProcedure
        'If Request.QueryString("ID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventID", Request.QueryString("ID"))
        'cU.Parameters.AddWithValue("@CustRelateID", FormNo)
        'If Session("CustEventTypeID") IsNot Nothing Then cU.Parameters.AddWithValue("@CustEventTypeID", Session("CustEventTypeID"))
        'cU.Parameters.AddWithValue("@CustEventDate", CDate(tb.Text))
        'Try
        '    cU.ExecuteNonQuery()
        '    Dim qEvent = From eV In db.CustEventLists _
        '     Where eV.CustRelateID = FormNo And eV.CustEventTypeID = CType(Session("CustEventTypeID"), Integer) _
        '     Select eV.CustEventID
        '    'ViewState("CustEventID") = qEvent

        'Catch ex As Exception
        '    LBLERR.Text = "תקלה מספר 978.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
        '    LBLERR.Visible = True
        '    SendMail(LBLERR.Text & "<br /> " & cU.CommandText & "<BR />" & ex.Message)
        'End Try
        'dbConnection.Close()
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
        Session.Timeout = 2000
        'Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        'If rbl.Items.Count = 0 Then
        '    Dim s As String = "tab_" & SurveyID & "_1.xml"
        '    Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
        '    Dim qR = (From p In tabx.Descendants("Group").Elements("Ctype") _
        '     Where Len(p.Attribute("ID").Value) > 0 _
        '       Select p.Attribute("ID").Value).Distinct
        '    '    Pass the result to the LinqDataSource
        '    rbl.DataSource = qR
        '    rbl.DataBind()
        '    ViewState("isCR") = qR.Count
        'End If

    End Sub
    Protected Sub rblcr_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        'Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        'Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Dim cU As New SqlCommand("update Survey_Forms set CustRate='" & rbl.SelectedValue & "' Where FormID=" & FormNo, dbConnection)
        'dbConnection.Open()
        'Try
        '    cU.ExecuteNonQuery()
        '    CustRate = rbl.SelectedValue
        '    ViewState("CustRate") = CustRate
        'Catch ex As Exception
        '    LBLERR.Text = "תקלה מספר 1037.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
        '    LBLERR.Visible = True
        '    SendMail(LBLERR.Text & "<br /> " & "<BR />" & ex.Message)
        'End Try
        'dbConnection.Close()
        'LBLERR.Visible = False
        'ssD()
    End Sub

    Protected Sub lblsprc_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim lbl As Label = CType(sender, Label)
        'CustRate = ViewState("CustRate")
        'Dim s As String = "tab_" & SurveyID & "_2.xml"
        'Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
        'Dim qR = (From p In tabx.Descendants("Sgrade") _
        ' Where p.Attribute("Grade").Value = tot _
        ' And (CustRate = vbNullString Or p.Parent.Attribute("ID") = CustRate) _
        '   Select New With {.FormID = FormNo, _
        '  .grp = "סיכום", _
        '  .gid = 99, _
        '  .sumg = tot, _
        '  .stan = tot, _
        '  .perc = p.Attribute("Percentage").Value})
        'If Session("Closing") = 1 Then updResults(False, qR)
        'Session("Closing") = 0
        'For Each q In qR
        '    lbl.Text = q.perc
        'Next
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
            Dim cD As New SqlCommand("delete from Survey_FormResults Where FormID=" & FormNo, dbConnection)
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

    End Sub
    Sub SendMail(ByVal sBody As String)
        WLog(1251)
        Dim configurationFile As Configuration = WebConfigurationManager.OpenWebConfiguration("~/web.config")
        Dim mailSettings As MailSettingsSectionGroup = configurationFile.GetSectionGroup("system.net/mailSettings")
        If Not mailSettings Is Nothing Then
            Dim password As String = mailSettings.Smtp.Network.Password
            Dim username As String = mailSettings.Smtp.Network.UserName
            Dim dd As SmtpClient = New SmtpClient()
            dd.Credentials = New System.Net.NetworkCredential(username, password)
            Dim m As New MailMessage()
            m.IsBodyHtml = True
            Dim sDetails As String = "<br />מספר טופס:"
            sDetails = sDetails & FormNo
            If exc IsNot Nothing Then sDetails = sDetails & "<br />" & exc.ToString
            If sBody <> vbNullString Then
                m.Body = sBody & sDetails
            End If

            Dim Sid As String = vbNullString
            If Session("LastCustID") IsNot Nothing Then
                Sid = Session("LastCustID")
            End If

            m.Subject = "תקלה בסקר תז: " & Sid & " מספר טופס:" & FormNo
            m.To.Add(New MailAddress("ariel@topyca.com"))
            m.From = New MailAddress("Survey@be-online.org")

            Try
                dd.Send(m)
            Catch ex As Exception
                LBLERR.Text = "תקלה מספר 1142.  אנא, הודע לרותם. או התקשר לטלפון 050-7242664 "
                LBLERR.Visible = True
                SendMail(LBLERR.Text & "<br /> " & ex.Message)
            End Try

        End If
        WLog(1287)

    End Sub

    'Protected Sub lblframe_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblframe.PreRender
    '	If Not IsPostBack Then
    '		If Session("FrameID") IsNot Nothing Then
    '			Dim lbl As Label = CType(sender, Label)
    '			Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
    '			Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
    '			Dim sqlCom As New SqlCommand("Select Framename from Survey_FrameList where where SurveyFrameID=" & Session("FrameID"), dbConnection)
    '			dbConnection.Open()
    '			Dim dr As SqlDataReader = sqlCom.ExecuteReader
    '			If dr.Read Then
    '				lbl.Text = dr("FrameName")
    '			End If
    '		End If
    '	End If
    'End Sub

    Protected Sub ddlframe_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlframe.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedIndex > 0 Then
            Session("FrameID") = ddl.SelectedValue
            Session("frameName") = ddl.SelectedItem.Text
            Response.Redirect("Surveys.aspx?f=" & Request.QueryString("f"))
        End If
    End Sub

    Protected Sub ddlservice_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlservice.SelectedIndexChanged
        Session("ServiceID") = ddlservice.SelectedValue
    End Sub

    Protected Sub ddlservice_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlservice.PreRender

        'If Not IsDBNull(Session("ServiceID")) Then
        '	Dim ddl As DropDownList = CType(sender, DropDownList)
        '	ddl.ClearSelection()
        '	Dim li As ListItem = ddl.Items.FindByValue(Session("ServiceID"))
        '	If li IsNot Nothing Then li.Selected = True
        'End If
    End Sub

    Protected Sub ddlframe_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlframe.PreRender
        'If Not IsDBNull(Session("FrameID")) Then
        '	Dim ddl As DropDownList = CType(sender, DropDownList)
        '	ddl.ClearSelection()
        '	Dim li As ListItem = ddl.Items.FindByValue(Session("FrameID"))
        '	If li IsNot Nothing Then li.Selected = True
        'End If
    End Sub

    Protected Sub lblframe_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblframe.PreRender
        lblframe.Text = Session("framename")
    End Sub

    Protected Sub lblformid_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblformid.PreRender
        If IsNumeric(Session("FormNo")) Then
            lblformid.Text = Session("formno")
        End If
    End Sub
    Dim sFramesL As String
    Protected Sub tvframes_TreeNodeDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs)
        WLog(2350)
        If e.Node.Depth = 2 Then
            e.Node.ShowCheckBox = True
            If sFramesL = vbNullString Then
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim cD As New SqlCommand("Select FrameID From eFrameList Where FormID=" & FormNo, dbConnection)
                dbConnection.Open()
                Dim dr As SqlDataReader = cD.ExecuteReader
                sFramesL = "|"
                While dr.Read
                    sFramesL &= (dr("FrameID")) & "|"
                End While
            End If
            e.Node.Checked = InStr(sFramesL, "|" & e.Node.Value & "|")

        Else
            e.Node.ShowCheckBox = False
        End If

        WLog(1370)
    End Sub

    Protected Sub tvframes_TreeNodeCheckChanged(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs)
        WLog(1374)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("", dbConnection)
        If e.Node.Checked = True Then
            cD.CommandText = "Insert Into EFrameList(FormID,FrameID) Values(" & FormNo & "," & e.Node.Value & ")"
            EFrame_q(e.Node.Value, True)
        Else
            cD.CommandText = "Delete From EFrameList Where FrameID=" & e.Node.Value & " And FormID=" & FormNo
            EFrame_q(e.Node.Value, False)
        End If
        dbConnection.Open()
        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            '  Throw ex
            Response.Write(cD.CommandText)
            Response.End()
        End Try
        dbConnection.Close()
        WLog(1396)
    End Sub

    Protected Sub TVFrames_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tv As TreeView = CType(sender, TreeView)
        Dim lvi As ListViewItem = CType(tv.NamingContainer, ListViewItem)
        Dim rbl As RadioButtonList = CType(lvi.FindControl("rbla_q"), RadioButtonList)
        If rbl.Items.Count > 0 Then tv.Visible = False
    End Sub

    Protected Sub lblNF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblNF.PreRender
        Dim lbl As Label = CType(sender, Label)
        If Session("SurveyPWD") IsNot Nothing Then
            lbl.Text = "מספר הסקר שלך הוא: " & Session("LastCustID")
        End If
    End Sub
    Sub EFrame_q(ByVal iFrameID As Integer, Optional ByVal bAdd As Boolean = True)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cI As New SqlCommand("", dbConnection)
        Dim query = From qE In rootElement.Descendants("Question") _
   Where qE.Attribute("id").Value <> 0 And If(qE.Attribute("perframe") Is Nothing, "no", qE.Attribute("perframe").Value) = "yes" _
   Select New With {.id = qE.Attribute("id").Value}
        cI.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Try
            For Each q In query
                cI.CommandText = "delete from Survey_Answers where FormID=" & FormNo & " And questionID=" & q.id & " And isnull(FrameID," & iFrameID & ")=" & iFrameID
                cI.ExecuteNonQuery()
                If bAdd Then
                    cI.CommandText = "insert into Survey_Answers(FormID,QuestionID,FrameID) Values(" & FormNo & "," & q.id & "," & iFrameID & ")"
                    cI.ExecuteNonQuery()
                End If
            Next
        Catch ex As Exception
            LBLERR.Text = "תקלה מספר 1335.  אנא, הודע לרותם. ברשותך, יתכן ונתקשר אליך כדי להעזר בך בטיפול בתקלה "
            LBLERR.Visible = True
            SendMail(LBLERR.Text & "<br /> " & cI.CommandText & "<BR />" & ex.Message)
        End Try
        dbConnection.Close()
        query = Nothing
    End Sub

    '    Protected Sub lv_q_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lv_q.ItemCreated
    '        Dim lvi As ListViewItem = e.Item
    '        Dim myRow As DataRow
    '        Dim myRowView As DataRowView
    '        myRowView = CType(e.Item.DataItem, DataRowView)


    '        Dim s As String = e.Item.ItemType

    '        Dim lbl As Label = CType(lvi.FindControl("lblxtt"), Label)
    '        lbl.Text = s
    '    End Sub

    Protected Sub Button2_PreRender(sender As Object, e As System.EventArgs) Handles Button2.PreRender, Button2A.PreRender
        Dim btn As Button = CType(sender, Button)
        If TVGROUPS.SelectedNode.Value = "הנחיות" Then btn.Enabled = False Else btn.Enabled = True
    End Sub
    Protected Sub Button3_PreRender(sender As Object, e As System.EventArgs) Handles Button3.PreRender, Button3A.PreRender
        Dim btn As Button = CType(sender, Button)
        If TVGROUPS.SelectedNode.Value = "שאלון אחרון" Then
            btncls0.Visible = True
            btn.Enabled = False
        Else
            btncls0.Visible = False
            btn.Enabled = True
        End If
    End Sub

    Protected Sub btncls0_PreRender(sender As Object, e As System.EventArgs) Handles btncls0.PreRender
        Dim btn As Button = CType(sender, Button)
        If TVGROUPS.SelectedNode.Value = "שאלון אחרון" Then btn.Visible = True Else btn.Visible = False

    End Sub

    Protected Sub TVGROUPS_PreRender(sender As Object, e As System.EventArgs) Handles TVGROUPS.PreRender
        TVGROUPS.CollapseAll()
    End Sub
    Sub WLog(r As Integer)
        'bLog = True
        'If bLog Then
        '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '    Dim cI As New SqlCommand("insert into Log(d,r)values(getdate()," & r & ") ", dbConnection)
        '    cI.CommandType = CommandType.Text
        '    dbConnection.Open()
        '    cI.ExecuteNonQuery()
        '    dbConnection.Close()
        'End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As System.EventArgs) Handles Me.PreInit
        WLog(1492)
    End Sub

    Protected Sub Page_Unload(sender As Object, e As System.EventArgs) Handles Me.Unload
        WLog(1496)
    End Sub
End Class
