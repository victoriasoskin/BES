Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Data.SqlClient
Imports System.Data
Imports System.Xml
Imports System.Web.UI.DataVisualization.Charting
Imports WebMsgApp
Imports eid
Imports WRCookies
Imports SurveysUtil
Imports System.IO
Imports Microsoft.Office.Interop.PowerPoint
Imports System.Xml.Linq
Imports System.Linq

Partial Class SurveyAvg
    Inherits System.Web.UI.Page
    Dim bFMNGR As Boolean
    Dim xRepList As XElement
    Const iQuestionLen As Integer = 30
    Dim dMinY As Double
    Dim dMaxY As Double
    Dim cCriterion As Microsoft.VisualBasic.Collection
    Dim cCurrentCriterionChanges As New Microsoft.VisualBasic.Collection
#Region "Load"
    'Function ReadCookie_S(s As String) As String
    '    Return vbNullString
    'End Function
    'Sub WriteCookie_S(s As String, ss As String)

    'End Sub
    'Function surveyName(s As String, ss As String) As String
    '    Return vbNullString
    'End Function
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("ConnectionString") Is Nothing Then Session("ConnectionString") = "BEBook10"
        If Request.QueryString("Rep") <> vbNullString Then
            Session("ddlrep") = Request.QueryString("Rep")
        Else
            Session("ddlrep") = ddlreptype.SelectedItem.Text
        End If
        If Request.QueryString("width") = vbNullString Then
            Dim sx As String = Request.Url.AbsoluteUri
            If InStr(sx, ".aspx?") > 0 Then sx = sx & "&" Else sx = sx & "?"
            Dim sScript As String = "<Script langualge=&quot;javascript&quot;>window.open('" & sx & "width=' + document.documentElement.clientWidth + '&height=' + document.documentElement.clientHeight,'_self');</Script>"
            Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", sScript)
        End If
        bFMNGR = Session("MultiFrame") = 0
        If Not IsPostBack Then
            disablaDDls()
        End If
        If Not IsPostBack Then
            ddlreptype.DataBind()
        End If
    End Sub

    Protected Sub Page_PreRenderComplete(sender As Object, e As System.EventArgs) Handles Me.PreRenderComplete
        Dim b1 As Boolean = DDLServices.Visible Or DDLFrames.Visible
        Dim b2 As Boolean = DDLAGE.Visible Or DDLGender.Visible Or DDLJob.Visible Or DDLLAKUT.Visible Or DDLSEN.Visible Or DDLST.Visible
        Dim b3 As Boolean = LSBQ.Visible Or lblProfiles.Visible

        lblTitle1.Visible = b1
        trHR2.Visible = b1 And b2
        lblTitle2.Visible = b2
        trHR3.Visible = b2 And b3
        lblTitle3.Visible = b3
        trHR4.Visible = b1 Or b2 Or b3
    End Sub
#End Region
#Region "Setup Survey/Report Selection Area"
#Region "DDLSurveys"
    Protected Sub DDLSurveys_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSurveys.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            If ReadCookie_S("DDLSurveys_LastSurvey") IsNot Nothing Then
                Dim s1 As String = ReadCookie_S("DDLSurveys_LastSurvey")
                Dim s2 As String = ReadCookie_S("DDLSurveys_SubGroup")
                Dim li As ListItem = ddl.Items.FindByValue(s1)
                If li IsNot Nothing Then
                    ddl.ClearSelection()
                    li.Selected = True
                End If
            End If
        End If
    End Sub
    Protected Sub DDLSurveys_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSurveys.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)

        ' Remember Last Survey used

        WriteCookie_S("DDLSurveys_LastSurvey", ddl.SelectedValue)
        ddlSY.ClearSelection()

        WriteCookie_S("DDLSurveys_SubGroup", vbNullString)
        WriteCookie_S("DDLSurveys_LastSY", vbNullString)
        ddlSY.DataBind()
        For i = ddlreptype.Items.Count - 1 To 1 Step -1
            ddlreptype.Items.RemoveAt(i)
        Next


        Dim s1 As String = ddl.SelectedValue
        Dim s2 As String = vbNullString

        disablaDDls()
        ClearReportArea()
      End Sub

#End Region
#Region "DDLSY"
    Protected Sub ddlSY_DataBinding(sender As Object, e As System.EventArgs) Handles ddlSY.DataBinding
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.Items.Clear()
    End Sub
    Protected Sub ddlSY_PreRender(sender As Object, e As System.EventArgs) Handles ddlSY.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim sy As String = ReadCookie_S("DDLSurveys_LastSY")
        If IsNumeric(sy) Then
            Dim li As ListItem = ddl.Items.FindByValue(sy)
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
        RemoveDDLDupItems(ddl)
    End Sub
    Protected Sub ddlSY_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlSY.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)

        ' Remember Last Survey used

        Dim sy As String = ddlSY.SelectedValue
        Dim s1 As String = DDLSurveys.SelectedValue
        Dim s2 As String = If(Len(sy) < 4, vbNullString, Left(sy, Len(sy) - 3))
        WriteCookie_S("DDLSurveys_SubGroup", s2)
        WriteCookie_S("DDLSurveys_LastSY", sy)

        disablaDDls()
        ClearReportArea()
        ddlreptype.DataBind()

    End Sub
#End Region
#Region "DDLREPTYPE"
    Protected Sub ddlreptype_DataBinding(sender As Object, e As System.EventArgs) Handles ddlreptype.DataBinding
        Dim s1 As String = ReadCookie_S("DDLSurveys_LastSurvey")
        Dim s2 As String = ReadCookie_S("DDLSurveys_SubGroup")
        loadRepList(s1, s2)
    End Sub
    Protected Sub ddlreptype_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlreptype.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedValue = vbNullString Then
            Dim s1 As String = Session("ddlrep")
            Dim li As ListItem = ddl.Items.FindByText(s1)
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
        RemoveDDLDupItems(ddl)

        ' If report is selected - set up criterions
        If ddlreptype.SelectedValue <> vbNullString Then
            showRepCriterions()
        End If
    End Sub
    Protected Sub ddlreptype_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlreptype.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("ddlrep") = ddl.SelectedItem.Text
        showRepCriterions()
        ClearReportArea()
    End Sub
#End Region
    Sub loadRepList(ByVal sSurveyGroupID As String, sSubGroup As String, Optional ByVal bAlways As Boolean = True)

        If sSurveyGroupID = vbNullString Or sSubGroup = vbNullString Then Exit Sub

        Dim li As ListItem

        '  Session("ddlrep") = ddlreptype.SelectedItem.Text    'Keep Last report

        If bAlways Or (Not IsPostBack) Then             ' Have to load replist
            Dim ddl As DropDownList = ddlreptype

            ddl.Items.Clear()

            li = New ListItem("בחר דוח", vbNullString)
            ddl.Items.Add(li)

            ' Read From XML

            If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
            Dim q = From l In xRepList.Descendants("Chart") _
            Where l.Parent.Attribute("SurveyGroupID").Value = sSurveyGroupID And l.Parent.Attribute("SubGroup").Value = sSubGroup And LCase(l.Attribute("UserGroups").Value) Like "*" & LCase(Session("SType")) & "*" _
            Select New With { _
            .txt = l.Element("Name").Value, _
            .val = l.Element("Query").Value, _
            .vis = If(l.Attribute("Visible") Is Nothing, "true", l.Attribute("Visible").Value), _
            .Conn = If(l.Parent.Attribute("ConnectionString") Is Nothing, "BEBook10", l.Parent.Attribute("ConnectionString").Value)}

            For Each l In q
                li = New ListItem(l.txt, l.val)
                If l.vis <> "true" Then li.Enabled = False
                ddl.Items.Add(li)
                Session("ConnectionString") = l.Conn
            Next

            ' If Called by QueryString

            If Request.QueryString("Rep") IsNot Nothing Then

                li = ddlreptype.Items.FindByText(Request.QueryString("Rep"))
                If li IsNot Nothing Then
                    li.Enabled = True
                    ddlreptype.ClearSelection()
                    li.Selected = True
                End If

                divhdr.Visible = False
                lblRepName.Text = Request.QueryString("Rep") & ": " & Request.QueryString("P")
                btnBack(True)
                loadRep()

            End If
        Else
            ClearReportArea()
        End If

        ' Select the report from the beginning

        li = ddlreptype.Items.FindByText(Session("ddlrep"))
        If li IsNot Nothing Then li.Selected = True


    End Sub
#End Region
#Region "Setup Survey"
    Sub LoadCriterions()
        Dim sSurveyGroupID As String, sSubGroup As String
        sSurveyGroupID = ReadCookie_S("DDLSurveys_LastSurvey")
        sSubGroup = ReadCookie_S("DDLSurveys_SubGroup")
        If sSubGroup = vbNullString Or sSurveyGroupID = vbNullString Then Exit Sub
        If cCriterion Is Nothing Then
            cCriterion = New Microsoft.VisualBasic.Collection
            If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
            Dim q = From l In xRepList.Descendants("Criterion") _
            Where l.Parent.Parent.Attribute("SurveyGroupID").Value = sSurveyGroupID And l.Parent.Parent.Attribute("SubGroup").Value = sSubGroup _
            Select New With { _
            .Nam = l.Attribute("Name").Value, _
            .Val = l.Value}
            For Each ll In q
                cCriterion.Add(ll.Val, ll.Nam)
            Next
        End If

    End Sub
    Sub LoadSelectionControls(Optional ByVal ctrlDSID As String = vbNullString)
        Dim sSurveyGroupID As String = ReadCookie_S("DDLSurveys_LastSurvey")
        Dim sSubGroup As String = ReadCookie_S("DDLSurveys_SubGroup")

        If sSubGroup = vbNullString Or sSurveyGroupID = vbNullString Then Exit Sub

        Dim iSVy As Integer = CInt("0" & Right(ReadCookie_S("DDLSurveys_LastSY"), 3))
        If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
        Dim q2 = From ll In xRepList.Descendants("SelectionControls").Elements("Control") _
             Where ll.Parent.Parent.Attribute("SurveyGroupID").Value = sSurveyGroupID And ll.Parent.Parent.Attribute("SubGroup").Value = sSubGroup And ll.Attribute("ID").Value = If(ctrlDSID = vbNullString, ll.Attribute("ID").Value, ctrlDSID) And If(ll.Attribute("SurveyID") Is Nothing, 0, CInt(ll.Attribute("SurveyID").Value)) = If(ll.Attribute("SurveyID") Is Nothing, 0, iSVy) _
          Select New With { _
          .Typ = ll.Attribute("Type").Value, _
          .Nam = ll.Attribute("ID").Value, _
           .Que = ll.Value, _
          .Root = If(ll.Attribute("Root") Is Nothing, vbNullString, ll.Attribute("Root").Value), _
         .sc = If(ll.Attribute("Scontrol") Is Nothing, vbNullString, ll.Attribute("Scontrol").Value), _
         .Svy = If(ll.Attribute("SurveyID") Is Nothing, vbNullString, ll.Attribute("SurveyID").Value)}

        For Each ll In q2
            Select Case ll.Typ
                Case "sql"
                    Dim ds As SqlDataSource = CType(FindControlRecursive(Page, ll.Nam), SqlDataSource)
                    If ds IsNot Nothing Then
                        ds.ConnectionString = ConfigurationManager.ConnectionStrings(Session("ConnectionString")).ConnectionString
                        Dim sOld As String = ds.SelectCommand
                        ds.SelectCommand = ll.Que
                        If ll.Que <> sOld Then
                            cCurrentCriterionChanges.Add(1, ll.sc)
                            Dim ddl As DropDownList = CType(FindControlRecursive(Page, ll.sc), DropDownList)
                            ddl.DataBind()
                        End If
                    End If
            End Select
        Next
    End Sub

#End Region
#Region "Setup Report Filter Area"
    Sub disablaDDls()
        If ChrtG.Visible = False Then
            DisableSelection(DDLAGE, lblAGE)
            DisableSelection(DDLGender, lblGender)
            DisableSelection(DDLST, lblST)
            DisableSelection(DDLLAKUT, lblLAKUT)
            DisableSelection(DDLFrames, lblFrames)
            DisableSelection(DDLServices, lblServices)
            DisableSelection(DDLJob, lblJob)
            DisableSelection(DDLSEN, lblSEN)
            DisableSelection(DDLProfiles, lblProfiles)
            DisableSelection(LSBQ, lblQ)
        End If
    End Sub
    Sub showRepCriterions()
        Dim ddl As DropDownList = ddlreptype
        Session("ddlrep") = ddl.SelectedItem.Text
        disablaDDls()
        btnBack(False)
        Dim s1 As String = ReadCookie_S("DDLSurveys_LastSurvey")
        Dim s2 As String = ReadCookie_S("DDLSurveys_SubGroup")

        If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
        Dim q1 = From l In xRepList.Descendants("Chart").Elements("Params").Elements("Param") _
         Where l.Parent.Parent.Parent.Attribute("SurveyGroupID").Value = DDLSurveys.SelectedValue And l.Parent.Parent.Parent.Attribute("SubGroup").Value = s2 And l.Parent.Parent.Element("Name").Value = ddlreptype.SelectedItem.Text _
         And LCase(l.Parent.Parent.Attribute("UserGroups").Value) Like "*" & LCase(Session("SType")) & "*" _
         Select New With {
             .nam = l.Attribute("Name").Value, _
             .must = If(l.Attribute("MustSelect") Is Nothing, "false", l.Attribute("MustSelect").Value)}


        For Each m In q1
            Select Case m.nam
                Case "@Services"
                    EnableSelection(DDLServices, lblServices)
                    ViewState("MustSelectService") = m.must
                Case "@Frames"
                    EnableSelection(DDLFrames, lblFrames)
                    If DDLFrames.Items.Count > 1 Then ViewState("MustSelectFrame") = m.must
                Case "@Jobs"
                    EnableSelection(DDLJob, lblJob)
                Case "@Sen"
                    EnableSelection(DDLSEN, lblSEN)
                Case "@Age"
                    EnableSelection(DDLAGE, lblAGE)
                Case "@Gender"
                    EnableSelection(DDLGender, lblGender)
                Case "@ServiceType"
                    EnableSelection(DDLST, lblST)
                Case "@Lakut"
                    EnableSelection(DDLLAKUT, lblLAKUT)
                Case "@Profiles"
                    EnableSelection(DDLProfiles, lblProfiles)
                Case "@Profilen"
                    'EnableSelection(DDLProfiles, lblProfiles)
                    'DDLProfiles.DataBind()
                    'If DDLProfiles.Items.Count <= 1 Then DDLProfiles.Enabled = False Else If m.must = "true" And DDLProfiles.Items(0).Value = 0 Then DDLProfiles.Items.RemoveAt(0)
                Case "@Questions"
                    EnableSelection(LSBQ, lblQ)
                Case "@ServiceID"
                    EnableSelection(DDLServices, lblServices)
                Case Else
            End Select
        Next
        GridView1.Visible = False
    End Sub
    Protected Sub DDLSelection_DataBinding(sender As Object, e As System.EventArgs) Handles DDLSEN.DataBinding, DDLGender.DataBinding, DDLAGE.DataBinding, DDLJob.DataBinding, DDLFrames.DataBinding, DDLServices.DataBinding, DDLST.DataBinding, DDLLAKUT.DataBinding, DDLProfiles.DataBinding
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Try
            If cCurrentCriterionChanges(ddl.ID) = 1 Then
                ddl.Items.Clear()
            End If
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub DDLSelection_PreRender(sender As Object, e As System.EventArgs) Handles DDLSEN.PreRender, DDLGender.PreRender, DDLAGE.PreRender, DDLJob.PreRender, DDLFrames.PreRender, DDLServices.PreRender, DDLST.PreRender, DDLLAKUT.PreRender, DDLProfiles.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        RemoveDDLDupItems(ddl)
        If ddl.Items.Count <= 1 Then
            DisableSelection(ddl, Nothing)
        ElseIf (ddl.Items.Count = 2 And ddl.Items(0).Value = 0) Then
            DisableSelection(ddl, Nothing)
        End If

        Dim s As String = ReadCookie_S("DDLSurveys_" & ddl.ID)
        If s <> vbNullString Then
            Dim li As ListItem = ddl.Items.FindByValue(s)
            If li IsNot Nothing Then
                ddl.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub
    Protected Sub DDLSelection_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles DDLSEN.SelectedIndexChanged, DDLGender.SelectedIndexChanged, DDLAGE.SelectedIndexChanged, DDLJob.SelectedIndexChanged, DDLFrames.SelectedIndexChanged, DDLServices.SelectedIndexChanged, DDLST.SelectedIndexChanged, DDLLAKUT.SelectedIndexChanged, DDLProfiles.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        WriteCookie_S("DDLSurveys_" & ddl.ID, ddl.SelectedValue)
    End Sub
    Protected Sub DSJob_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSJob.Selecting
        e.Command.Parameters("@SurveyID").Value = If(ReadCookie_S("DDLSurveys_LastSY") <> vbNullString, CInt(Right(ReadCookie_S("DDLSurveys_LastSY"), 3)), 0)
        Dim s As String = ReadCookie_S("DDLSurveys_DDLFrames")
        If s = "0" Then s = vbNullString
        e.Command.Parameters("@FrameIDD").Value = If(s <> vbNullString, s, DDLFrames.SelectedValue)
        'For i = 0 To e.Command.Parameters.Count - 1
        '    Response.Write(e.Command.Parameters(i).ToString & " = " & e.Command.Parameters(i).Value & "<br/>")

        'Next
        'Response.Write(e.Command.CommandText)

    End Sub

    Protected Sub DSFrames_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSFrames.Selecting
        If e.Command.Parameters("@ServiceID").Value Is Nothing Then e.Command.Parameters("@ServiceID").Value = If(ReadCookie_S("DDLSurveys_DDLServices") Is Nothing, DDLServices.SelectedValue, ReadCookie_S("DDLSurveys_DDLServices"))
    End Sub
#Region "LSBQ"
    Protected Sub LSBQ_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LSBQ.PreRender
        Dim lsb As ListBox = CType(sender, ListBox)
        If LSBQ.Enabled = True Then
            If lsb.SelectedIndex <= 0 Then
                Dim li As ListItem = lsb.Items.FindByText("כל השאלות")
                If li IsNot Nothing Then
                    li.Selected = True
                End If
            End If
            For Each li As ListItem In lsb.Items
                If li.Text IsNot Nothing Then li.Text = Regex.Replace(li.Text, "<.*?>", " ")
            Next
        End If
    End Sub
#End Region
#Region "DDLJobs"
    Protected Sub DDLJob_PreRender(sender As Object, e As System.EventArgs) Handles DDLJob.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        RemoveDDLDupItems(ddl)
    End Sub
#End Region
#Region "DDLSEN"
    Protected Sub DDLSEN_PreRender(sender As Object, e As System.EventArgs) Handles DDLSEN.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        RemoveDDLDupItems(ddl)
    End Sub

#End Region
#End Region
#Region "Setup Report"
    'Protected Sub lblhdrhdr_PreRender(sender As Object, e As System.EventArgs) Handles lblhdrhdr.PreRender
    '    lblhdrhdr.Width = If(Request.QueryString("width") <> vbNullString, CInt(Request.QueryString("width")) - 200, 1000)
    'End Sub
    Function AddSqlCriterion(ByVal sName As String, ByVal o As Object, Optional sPrefix As String = vbNullString, Optional TypeN As String = vbNullString) As String
        Dim s As String = vbNullString
        If cCriterion Is Nothing Then LoadCriterions()
        If TypeN = "N" Then
            Try
                s = o.ToString
            Catch ex As Exception
                Return "ERROR"
            End Try
        Else
            If o IsNot Nothing Then
                Dim sV As String = o.ToString
                If sV <> vbNullString Then
                    s = cCriterion(sName)
                    s = LCase(s).Replace(LCase(sName), sV).Replace(LCase("Prefix."), If(sPrefix = vbNullString, vbNullString, sPrefix & "."))
                End If
            End If
        End If
        Return s
    End Function
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btng.Click
        ShowChart()
    End Sub
#End Region
#Region "Show Report"
    Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShow.Click
        loadRep()
    End Sub
    Sub loadRep()
        Dim sRepType As String = vbNullString
        Dim sURL As String = vbNullString
        Dim sRep As String = Session("ddlrep")

        If ddlreptype.SelectedIndex <= 0 Then Exit Sub

        Dim gv As GridView

        If ddlreptype.SelectedIndex > 0 Then

            Dim ddl As DropDownList = CType(DDLSurveys, DropDownList)
            If ReadCookie_S("DDLSurveys_LastSurvey") IsNot Nothing Then
                Dim i As Integer = ReadCookie_S("DDLSurveys_LastSurvey")

                If ddlSY.SelectedValue = vbNullString And ReadCookie_S("DDLSurveys_LastSY") = vbNullString Then Exit Sub

                Dim iSubg As Integer = If(IsNumeric(ddlSY.SelectedValue), CInt(CInt(ddlSY.SelectedValue) / 1000), CInt(ReadCookie_S("DDLSurveys_SubGroup")))

                Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("ConnectionString")).ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim cD As New SqlCommand(vbNullString, dbConnection)

                ' Read Rep query and other data

                If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
                Dim q = From l In xRepList.Descendants("Chart") _
                Where (l.Parent.Attribute("SurveyGroupID").Value = i) And (l.Parent.Attribute("SubGroup").Value = iSubg) And l.Element("Name").Value = ddlreptype.SelectedItem.Text _
                 And LCase(l.Attribute("UserGroups").Value) Like "*" & LCase(Session("SType")) & "*" _
                 Select New With { _
                            .key = If(l.Element("Query").Attribute("keyColumn") Is Nothing, Nothing, l.Element("Query").Attribute("keyColumn").Value), _
                            .nam = If(l.Element("Query").Attribute("pivotNameColumn") Is Nothing, Nothing, l.Element("Query").Attribute("pivotNameColumn").Value), _
                            .val = If(l.Element("Query").Attribute("pivotValueColumn") Is Nothing, Nothing, l.Element("Query").Attribute("pivotValueColumn").Value), _
                            .add = If(l.Element("Query").Attribute("AdditionalHeaderTextColumn") Is Nothing, Nothing, l.Element("Query").Attribute("AdditionalHeaderTextColumn").Value), _
                            .MinY = If(l.Element("Query").Attribute("MinY") Is Nothing, vbNullString, l.Element("Query").Attribute("MinY").Value), _
                            .MaxY = If(l.Element("Query").Attribute("MinY") Is Nothing, vbNullString, l.Element("Query").Attribute("MaxY").Value), _
                            .lbf = If(l.Element("Query").Attribute("LabelFormat") Is Nothing, vbNullString, l.Element("Query").Attribute("LabelFormat").Value), _
                            .AvgType = If(l.Element("Query").Attribute("AvgType") Is Nothing, Nothing, l.Element("Query").Attribute("AvgType").Value), _
                            .url = If(l.Element("Query").Attribute("URL") Is Nothing, Nothing, l.Element("Query").Attribute("URL").Value), _
                            .Der = l.Attribute("UserGroups").Value, _
                            .Typ = l.Element("Type").Value, _
                            .Comm = If(l.Element("Comment") Is Nothing, vbNullString, l.Element("Comment").Value)}

                Dim sKey As String = vbNullString
                Dim sName As String = vbNullString
                Dim sVal As String = vbNullString
                Dim sAdd As String = vbNullString

                For Each l In q

                    If l.key IsNot Nothing Then sKey = l.key
                    If l.nam IsNot Nothing Then sName = l.nam
                    If l.val IsNot Nothing Then sVal = l.val
                    If l.add IsNot Nothing Then sAdd = l.add

                    hdnminy.Value = l.MinY
                    hdnmaxy.Value = l.MaxY

                    ViewState("LabelFormat") = l.lbf

                    If l.AvgType IsNot Nothing Then hdnavgtype.Value = l.AvgType
                    If l.url IsNot Nothing Then sURL = l.url

                    sRepType = l.Typ

                    Dim sComm As String = If(l.Comm Is Nothing, vbNullString, l.Comm)

                    If sComm <> vbNullString Then
                        lblcomment.Text = "<br/>" & sComm
                        lblcomment.Visible = True
                    End If
                Next

                ' Read Report Params

                Dim sRepN As String = If(ddlreptype.SelectedItem.Text Is Nothing, Request.QueryString("Rep"), ddlreptype.SelectedItem.Text)


                Dim q1 = From l In xRepList.Descendants("Chart").Elements("Params").Elements("Param") _
                Where l.Parent.Parent.Parent.Attribute("SurveyGroupID").Value = i And l.Parent.Parent.Parent.Attribute("SubGroup").Value = iSubg _
                And l.Parent.Parent.Element("Name").Value = sRepN _
                And LCase(l.Parent.Parent.Attribute("UserGroups").Value) Like "*" & LCase(Session("SType")) & "*" _
                Select New With { _
                    .nam = l.Attribute("Name").Value, _
                    .pref = If(l.Attribute("Prefix") Is Nothing, vbNullString, l.Attribute("Prefix").Value), _
                    .repl = If(l.Attribute("Repl") Is Nothing, "1", l.Attribute("Repl").Value), _
                    .conc = If(l.Attribute("Conc") Is Nothing, " And ", l.Attribute("Conc").Value), _
                     .typ = If(l.Attribute("Type") Is Nothing, vbNullString, l.Attribute("Type").Value), _
                   .inttxt = l.Value}


                Dim sCriterions(0 To 10) As String
                Dim s As String = vbNullString
                Dim sHdr As String = vbNullString
                Dim kk As Integer = LSBQ.Items.Count - 1
                Dim sConc As String = vbNullString

                Dim sFID As String = vbNullString
                Dim sFNM As String = vbNullString

                ' if the user is frame manager 

                If Not IsDBNull(Session("FrameName")) Then
                    sFID = Session("FrameID")
                    sFNM = Session("FrameName")
                    sHdr &= sHeader("מסגרת", vbNullString, sFID, sFNM)

                End If

                For Each m In q1

                    Dim sM As String = m.nam
                    Dim iRepl As Integer = m.repl
                    Dim sPrefix As String = m.pref
                    Dim sTypeN As String = m.typ

                    sConc = m.conc


                    Select Case sM

                        Case "@Services"
                            s = DDLServices.SelectedValue
                            If s <> vbNullString Then If s = 0 Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix, sTypeN)
                            If s = "ERROR" Then
                                scrMsg("יש לבחור באיזור", False)
                                Exit Sub
                            End If
                            If s <> vbNullString And sFID = vbNullString Then sHdr &= sHeader(vbNullString, m.inttxt, s, DDLServices.SelectedItem.Text)

                        Case "@Frames"
                            s = If(sFID <> vbNullString, sFID, DDLFrames.SelectedValue)
                            If s <> vbNullString Then If s = 0 Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix, sTypeN)
                            Try
                                If s <> vbNullString And sFID = vbNullString Then sHdr &= sHeader("מסגרת", m.inttxt, If(sFID <> vbNullString, sFID, DDLFrames.SelectedValue), If(sFID <> vbNullString, sFNM, DDLFrames.SelectedItem.Text))
                            Catch ex As Exception
                                ErrCatch(2)
                                Exit Sub
                            End Try

                        Case "@FrameQ"
                            s = AddSqlCriterion(sM, Request.QueryString("F"), sPrefix, sTypeN)
                            sHdr &= sHeader("מסגרת", m.inttxt, Request.QueryString("FN"), Request.QueryString("FN"))

                        Case "@Jobs"
                            s = DDLJob.SelectedValue
                            If s <> vbNullString Then If s = 0 Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("תפקיד", m.inttxt, s, DDLJob.SelectedItem.Text)

                        Case "@JobQ"
                            s = If(Request.QueryString("J") = 0, vbNullString, Request.QueryString("j"))
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("תפקיד", m.inttxt, Request.QueryString("JN"), Request.QueryString("JN"))

                        Case "@Age"
                            s = DDLAGE.SelectedValue
                            If s = "0" Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("גיל", m.inttxt, s, DDLAGE.SelectedItem.Text)

                        Case "@Gender"
                            s = DDLGender.SelectedValue
                            If s = "0" Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("מין", m.inttxt, s, DDLGender.SelectedItem.Text)

                        Case "@ServiceType"
                            s = DDLST.SelectedValue
                            If s = "0" Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("שירות", m.inttxt, s, DDLST.SelectedItem.Text)

                        Case "@Lakut"
                            s = DDLLAKUT.SelectedValue
                            If s = "0" Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("לקות", m.inttxt, s, DDLLAKUT.SelectedItem.Text)

                        Case "@Sen"
                            s = DDLSEN.SelectedValue
                            If s <> vbNullString Then If s = 0 Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("ותק", m.inttxt, s, DDLSEN.SelectedItem.Text)

                        Case "@Profiles"
                            s = DDLProfiles.SelectedValue
                            If s = "0" Then s = vbNullString
                            s = AddSqlCriterion(sM, s, sPrefix)
                            If s <> vbNullString Then sHdr &= sHeader("מימד", m.inttxt, s, DDLProfiles.SelectedItem.Text)
                            's = AddSqlCriterion(sM, tdd.SelectedValue, sPrefix)
                            'If s <> vbNullString Then
                            '    Dim s1() As String = tdd.SelectedValue.Split("|")
                            '    For j = 0 To s1.Length - 1
                            '        If s1(j) <> vbNullString Then
                            '            s = s.Replace("@Profile_" & j + 1, "'" & s1(j).Replace("'", "''") & "'")
                            '        Else
                            '            s = s.Replace("@Profile_" & j + 1, "NULL")
                            '        End If
                            '    Next
                            '    sHdr &= sHeader("פרופיל", m.inttxt, tdd.SelectedText, tdd.SelectedText)
                            'End If

                        Case "@Questions"
                            s = vbNullString
                            For k = 1 To kk
                                If LSBQ.Items(k).Selected = True Then
                                    s = s & LSBQ.Items(k).Value & ","
                                End If
                            Next
                            If s <> vbNullString Then
                                s = AddSqlCriterion(sM, "(" & Left(s, s.Length - 1) & ")", sPrefix)
                                For k As Integer = 1 To LSBQ.Items.Count - 1
                                    If LSBQ.Items(k).Selected Then
                                        sHdr &= sHeader("שאלה", m.inttxt, LSBQ.Items(k).Value, LSBQ.Items(k).Text)
                                    End If
                                Next
                            End If

                        Case "@UserID"

                            s = AddSqlCriterion(sM, Session("UserID"), sPrefix, sTypeN)

                        Case "@FrameID"
                            s = AddSqlCriterion(sM, Session("FrameID"), sPrefix)

                        Case "@ServiceID"
                            s = AddSqlCriterion(sM, DDLServices.SelectedValue, sPrefix, sTypeN)
                            If s <> vbNullString Then sHdr &= sHeader(vbNullString, m.inttxt, s, DDLServices.SelectedItem.Text)

                        Case "@ExcludeFrameID"
                            s = AddSqlCriterion(sM, If(DDLFrames.SelectedValue = vbNullString, Session("FrameID"), DDLFrames.SelectedValue), sPrefix)

                        Case "@SurveyGroupID"
                            s = AddSqlCriterion(sM, DDLSurveys.SelectedValue, sPrefix)

                        Case "@SurveyID"
                            s = AddSqlCriterion(sM, ddlSY.SelectedItem.Text, sPrefix)

                        Case "@RSurveyID"
                            s = AddSqlCriterion(sM, Right(ReadCookie_S("DDLSurveys_LastSY"), 3), sPrefix)

                        Case "@SurveyGroupName"
                            s = AddSqlCriterion(sM, DDLSurveys.SelectedItem.Text, sPrefix)

                        Case "@Profilen"
                            If Request.QueryString("P") IsNot Nothing Then
                                s = AddSqlCriterion(sM, "'" & Request.QueryString("P").Replace("'", "''") & "'", sPrefix)
                                sHdr &= sHeader("מימד", m.inttxt, Request.QueryString("P"), Request.QueryString("P"))
                            Else
                                s = DDLProfiles.SelectedValue
                                If s <> vbNullString Then If s = 0 Then s = vbNullString
                                s = AddSqlCriterion(sM, s, sPrefix)
                                If s <> vbNullString Then sHdr &= sHeader("מימד", m.inttxt, s, DDLProfiles.SelectedItem.Text)
                                'If tdd.SelectedText = vbNullString Then
                                '    s = AddSqlCriterion(sM, "'x'", sPrefix)
                                'Else
                                '    s = AddSqlCriterion(sM, "'" & tdd.SelectedText.Replace("'", "''") & "'", sPrefix)
                                'End If
                            End If

                    End Select

                    If s <> vbNullString Then sCriterions(iRepl) = sCriterions(iRepl) & s & sConc

                Next

                ' bBuild Query With params

                s = ddlreptype.SelectedValue
                For i = 1 To 10
                    If sCriterions(i) <> vbNullString Then s = s.Replace(i & "=" & i, Left(sCriterions(i), sCriterions(i).Length - sConc.Length))
                Next

                'Prepare AllFor Reading

                Dim dr As SqlDataReader
                If sRepType <> "URL" Then
                    cD.CommandText = s
                    dbConnection.Open()
                    cD.CommandTimeout = 180
                    lblRepName.Text = ddlreptype.SelectedItem.Text & sHdr
                 End If

                ' Act By RepType

                SetReportArea(sRepType)

                Select Case sRepType

                    ' Charts 

                    Case "Column", "Bar"

                        Dim da As SqlDataAdapter
                        Dim dx As New System.Data.DataTable
                        Try
                            da = New SqlDataAdapter(cD)
                            da.Fill(dx)
                         Catch ex As Exception
                            da = Nothing
                            dbConnection.Close()
                            '          Throw ex
                            ErrCatch(5)
                            Exit Sub
                        End Try
                        Dim dt As System.Data.DataTable = CrossTab(dx, sKey, sName, sVal, sAdd)
                        BuildGrid(GridView1, dt)
                        da = Nothing

                        If GridView1.Rows.Count < 1 Then
                            scrMsg("אין נתונים להצגה בחתך זה.<br /> שנה את הגדרת החתכים בדוח ונסה שוב.", False)
                            ClearReportArea()
                            Exit Sub
                        End If

                        GridView1.Visible = False
                        dbConnection.Close()
                        i = ddlreptype.SelectedItem.Text.Length
                        i = i * (55 - i)
                        ShowChart(sRepType, sURL)
                        ' PageHeader1.Header = SurveyName(CInt("0" & Right(ReadCookie_S("DDLSurveys_LastSY"), 3)), "דוח סקרים")
                        divform.Attributes("class") = ""
                        divform.Attributes.Add("style", "position:absolute;width:" & ChrtG.Width.ToString & ";background-color:#C0C0C0;border-style:outset;")
                        divhdr.Visible = False
                        btnBack(True)

                        ' PowerPoint

                    Case "PPT"

                        dr = cD.ExecuteReader()
                        If dr.Read Then
                            Dim sPPt As String = dr("url")
                            dr.Close()
                            dbConnection.Close()
                            Response.Redirect(sPPt)
                        End If

                        '  Image

                    Case "Img"
                        dr = cD.ExecuteReader()
                        Dim sfN As String = vbNullString
                        If dr.Read Then
                            sfN = dr("FileName").trim
                            dr.Close()
                            dbConnection.Close()
                            SaveSlide(sfN)
                        End If
                        ImgChart.ImageUrl = sfN
                        ' PageHeader1.Header = SurveyName(CInt("0" & Right(ReadCookie_S("DDLSurveys_LastSY"), 3)), "דוח סקרים")
                        divform.Attributes("class") = ""
                        divform.Attributes.Add("style", "position:absolute;width:" & ChrtG.Width.ToString & ";background-color:#C0C0C0;border-style:outset;")
                        divhdr.Visible = False
                        btnBack(True)

                        ' URL

                    Case "URL"
                        Response.Redirect(s.Trim)
                End Select

            End If
        End If
    End Sub
    Sub SetReportArea(sRepType As String)
        Select Case LCase(sRepType)
            Case "bar", "column"
                lblRepName.Visible = True
                '  lblcomment.Visible = True
                ImgChart.Visible = False
                ChrtG.Visible = True

            Case "url"
                lblRepName.Visible = False
                lblcomment.Visible = False
                ImgChart.Visible = False
                ChrtG.Visible = False

            Case "ppt"
                lblRepName.Visible = False
                lblcomment.Visible = False
                ImgChart.Visible = False
                ChrtG.Visible = False

            Case "img"
                lblRepName.Visible = True
                '    lblcomment.Visible = False
                ImgChart.Visible = True
                ChrtG.Visible = False

        End Select

    End Sub
    Sub ClearReportArea()
        lblRepName.Visible = False
        lblcomment.Visible = False
        ImgChart.Visible = False
        ChrtG.Visible = False
     End Sub

    Protected Sub lblRepName_PreRender(sender As Object, e As System.EventArgs) Handles lblRepName.PreRender
        'If lblRepName.Text = vbNullString Then
        '    If ddlreptype.Items.Count > 0 Then
        '        If ddlreptype.SelectedValue <> vbNullString Then
        '            ErrCatch(1)
        '        End If
        '    End If
        'End If
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
        ChrtG.Legends.Clear()
        ChrtG.Legends.Add("ff")

        Dim i As Integer
        Dim j As Integer
        Dim l As Integer = 0

        Dim gv As GridView = GridView1

        If gv.Columns.Count < 1 Or gv.Rows.Count > 30 Then
            ErrCatch(3)
            Exit Sub
        End If

        Dim cHText As New Microsoft.VisualBasic.Collection
        BuildToolTipCollection(gv, cHText)
        ' Build chart

        For i = 0 To gv.Rows.Count - 1

            Dim gvr As GridViewRow = gv.Rows(i)
            If gvr.Cells(0).Text <> "&nbsp;" Then
                s = "s" & l

                ChrtG.Series.Add(s)
                ChrtG.Series(s).ChartType = cCharType

                ChrtG.Series(s)("DrawingStyle") = "Emboss"
                ChrtG.Series(s).IsVisibleInLegend = True
                ChrtG.Series(s).LegendText = gvr.Cells(0).Text
                ChrtG.Legends(0).Docking = Docking.Bottom
                ChrtG.Legends(0).Alignment = StringAlignment.Near

                ChrtG.Series(s).Color = c(l)
                gvr.Cells(0).BackColor = c(l)

                ' Add Data

                l = l + 1  ' Column Index

                For j = gv.Columns.Count - 1 To 1 Step -1

                    Dim dK As Double = If(IsNumeric(gvr.Cells(j).Text), CDbl(gvr.Cells(j).Text), 0) ' Get Numeric Value
                    Dim sH As String = gv.Columns(j).HeaderText ' Get Column Header
                    If Left(sH, 6) = "Column" Then sH = " "
                    sH = Left(Regex.Replace(sH, "<.*?>", " "), 70)

                    ChrtG.Series(s).Points.AddXY(sH, dK)                                            ' Add Point

                    ' Add Column label

                    If dK <> 0 And dK < CDbl(If(hdnmaxy.Value = vbNullString, "999", hdnmaxy.Value)) Then
                        ChrtG.Series(s).Points(gv.Columns.Count - j - 1).Label = Format(dK, ViewState("LabelFormat"))

                        ' Add URL

                        If sURL <> vbNullString Then
                            Dim SFID As String
                            Dim sFN As String
                            If Session("FrameID") IsNot Nothing And Session("FrameName") IsNot Nothing Then
                                SFID = Session("FrameID")
                                sFN = Session("FrameName")
                            Else
                                SFID = DDLFrames.SelectedValue
                                sFN = DDLFrames.SelectedValue
                            End If

                            ChrtG.Series(s).Points(gv.Columns.Count - j - 1).Url = sURL.Replace("#ColHdr#", sH).Replace("#JobID#", DDLJob.SelectedValue).Replace("#JobName#", DDLJob.SelectedItem.Text).Replace("#FrameID#", SFID).Replace("#FrameName#", sFN) & "&width=" & Request.QueryString("width") & "&height=" & Request.QueryString("height")
                        End If
                    End If

                    If cHText.Count > 0 Then ChrtG.Series(s).Points(gv.Columns.Count - j - 1).ToolTip = AddToolTip(gv, i, j, cHText)
                Next
            End If
        Next

        ' Addition formating

        If s <> vbNullString Then

            If cCharType = SeriesChartType.Column Then
                If ChrtG.Series(s).Points.Count > 9 Then ChrtG.ChartAreas(0).AxisX.LabelStyle.Angle = -60 ' if many columns And Column chart, rotate the text at the botton
                ChrtG.Height = AvailableHeight()
            End If


            If cCharType = SeriesChartType.Bar Then
                Dim dChartCalculatedHeight As Double = (ChrtG.Series(s).Points.Count + 1) * gv.Rows.Count * 20
                Dim dAvailableHeight As Double = AvailableHeight()

                If dChartCalculatedHeight < dAvailableHeight Then
                    ChrtG.Height = dAvailableHeight
                Else
                    ChrtG.Height = dChartCalculatedHeight
                    ChrtG.ChartAreas("test").AxisX.LabelAutoFitStyle = LabelAutoFitStyles.None
                    ChrtG.ChartAreas("test").AxisX.LabelStyle.Font = New System.Drawing.Font("Arial", 16, System.Drawing.FontStyle.Regular)
                End If
                'If ChrtG.Series(s).Points.Count > 7 Then
                'End If
            End If

            ChrtG.Width = dAvailableWidth()                   ' Calculate Chart width

            '      ViewState("jheight") = 0

            ChrtG.ChartAreas(0).AxisX.Interval = 1

            If hdnminy.Value <> vbNullString Then ChrtG.ChartAreas(0).AxisY.Minimum = hdnminy.Value Else ChrtG.ChartAreas(0).AxisY.IntervalAutoMode = IntervalAutoMode.VariableCount
            If hdnmaxy.Value <> vbNullString Then ChrtG.ChartAreas(0).AxisY.Maximum = hdnmaxy.Value

            Dim sl As New StripLine()

            ChrtG.ChartAreas(0).AxisX.IsReversed = True
            ChrtG.ChartAreas(0).AxisY.MajorGrid.LineColor = Color.Gray
            ChrtG.ChartAreas(0).AxisY.MajorGrid.LineDashStyle = DataVisualization.Charting.ChartDashStyle.Dot
            ChrtG.ChartAreas(0).AxisX.MajorGrid.LineWidth = 0

        End If
        SaveSlide()
    End Sub
    Sub BuildGrid(gv As GridView, dt As System.Data.DataTable)
        gv.Visible = True
        gv.Columns.Clear()
        gv.DataSource = dt
        If dt IsNot Nothing Then
            For i = 0 To dt.Columns.Count - 1
                Dim bf As New BoundField
                bf.DataField = dt.Columns(i).ColumnName
                bf.HeaderText = dt.Columns(i).ColumnName
                gv.Columns.Add(bf)
            Next
        End If
        gv.DataBind()
    End Sub
    Sub BuildToolTipCollection(gv As GridView, cHText As Microsoft.VisualBasic.Collection)
        If gv.Columns.Count > 2 Then
            If Left(gv.Columns(2).HeaderText, 1) = "*" Then

                For i = 0 To gv.Rows.Count - 1
                    For j = 0 To gv.Columns.Count - 1
                        If Left(gv.Columns(j).HeaderText, 1) = "*" Then cHText.Add(gv.Rows(i).Cells(j).Text, Mid(gv.Columns(j).HeaderText, 2) & "|" & gv.Rows(i).Cells(1).Text)
                    Next
                Next
            End If

            For i = gv.Columns.Count - 1 To 1 Step -1
                If Left(gv.Columns(i).HeaderText, 1) = "*" Then gv.Columns.RemoveAt(i)
            Next
        End If
        gv.DataBind()
    End Sub
    Function AddToolTip(gv As GridView, iRow As Integer, jCol As Integer, cHtext As Microsoft.VisualBasic.Collection) As String
        Dim sa As String = vbNullString
        If cHtext IsNot Nothing Then
            If cHtext.Count > 0 Then
                Try
                    sa = cHtext(gv.Columns(jCol).HeaderText & "|" & gv.Rows(iRow).Cells(1).Text)
                Catch ex As Exception
                End Try
            End If
        End If
        Return sa.Replace("&nbsp;", vbNullString)
    End Function
#End Region
#Region "Utilities"
    Private Shared Function FindControlRecursive(ByVal Root As Control, ByVal Id As String) As Control
        If LCase(Root.ID) = LCase(Id) Then
            Return Root
        End If
        For Each Ctl As Control In Root.Controls
            Dim FoundCtl As Control = FindControlRecursive(Ctl, Id)
            If FoundCtl IsNot Nothing Then
                Return FoundCtl
            End If
        Next
        Return Nothing
    End Function
    Sub RemoveDDLDupItems(ByRef ddl As DropDownList)
        Dim cItems As New Microsoft.VisualBasic.Collection
        Dim cItems2Delete As New Microsoft.VisualBasic.Collection
        For i As Integer = 0 To ddl.Items.Count - 1
            Try
                cItems.Add(ddl.Items(i).Value, ddl.Items(i).Value)
            Catch ex As Exception
                cItems2Delete.Add(i)
            End Try
        Next
        For i = cItems2Delete.Count To 1 Step -1
            ddl.Items.RemoveAt(cItems2Delete(i))
        Next
    End Sub
    Sub scrMsg(sMsg As String, bErr As Boolean, Optional bTowButtons As Boolean = False, Optional sbtnMsgText As String = "אישור", Optional sbtnMsgOnClickText As String = vbNullString, Optional sbtnTwoText As String = "ביטול", Optional sbtnTwoOnClickText As String = vbNullString)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"
        btnmsg.Text = sbtnMsgText
        If sbtnMsgOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnMsgOnClickText)

        If bTowButtons Then
            btnTwo.Visible = True
            btnTwo.Text = sbtnTwoText
            If sbtnTwoOnClickText <> vbNullString Then btnTwo.Attributes.Add("onclick", sbtnTwoOnClickText)
            Dim i As Integer = If(sbtnMsgText.Length > sbtnTwoText.Length, sbtnMsgText.Length, sbtnTwoText.Length) * 10 + 20
            btnmsg.Width = i
            btnTwo.Width = i
        Else : btnTwo.Visible = False
        End If

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Blue", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click, btnTwo.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
    Sub ErrCatch(i As Integer)
        Dim s As String = "<font color=red>לא ניתן להפיק דוח זה בחתך זה(" & i & "). "
        If DDLServices.Enabled = True Then
            If DDLServices.Items.Count > 0 And DDLServices.SelectedValue = vbNullString Then
                s &= " יש לבחור באזור."
            Else
                If DDLFrames.Enabled = True Then
                    s &= " יש לבחור במסגרת."
                End If
            End If
        Else
            If DDLFrames.Enabled = True Then
                s &= " יש לבחור במסגרת."
            End If
        End If
        s = s & "</font>"
        scrMsg(s, True)
        GridView1.Visible = False
    End Sub
    Sub btnBack(b As Boolean)
        '   If b Then PageHeader1.ButtonJava = "window.history.back(-3);" Else PageHeader1.ButtonJava = vbNullString
    End Sub
    Sub EnableSelection(ctl As Object, lbl As Label)
        If lbl Is Nothing Then
            lbl = FindControlRecursive(Page, "lbl" & Mid(ctl.ID, 4))
        End If
        ctl.Enabled = True
        ctl.visible = True
        If lbl IsNot Nothing Then lbl.Visible = True
        LoadSelectionControls("DS" & ctl.ID.substring(3))
    End Sub
    Sub DisableSelection(ctl As Object, lbl As Label)
        If lbl Is Nothing Then
            lbl = FindControlRecursive(Page, "lbl" & Mid(ctl.ID, 4))
        End If
        ctl.Enabled = False
        ctl.visible = False
        ctl.ClearSelection()
        'If Not ctl.Equals(tdd) Then ctl.BackColor = Color.Transparent
        If lbl IsNot Nothing Then lbl.Visible = False
    End Sub
    Function AvailableHeight() As Double
        Dim j As Double = Regex.Matches(lblRepName.Text, Regex.Escape("<br/>")).Count
        Dim i As Double = Request.QueryString("height") - 140 - j * 16
        Return i
    End Function
    Function dAvailableWidth() As Double
        Dim i As Double = If(Request.QueryString("width") <> vbNullString, CDbl(Request.QueryString("width")) - 180, 1000)
        Return i
    End Function
    Public Function CrossTab(ByVal dtS As System.Data.DataTable, ByVal leftColumn As String, ByVal topField As String, ByVal dataValue As String, Optional dataValue2 As String = vbNullString, Optional ByVal pFix As String = vbNullString) As System.Data.DataTable
        If dtS Is Nothing Then
            Return Nothing
        End If


        Dim dtOut As New System.Data.DataTable
        Dim dtRowTitle As New System.Data.DataTable
        Dim dtColHeader As New System.Data.DataTable

        dtRowTitle = dtS.DefaultView.ToTable(True, dtS.Columns(leftColumn).ColumnName)
        dtColHeader = dtS.DefaultView.ToTable(True, dtS.Columns(topField).ColumnName)

        Dim dColx As New DataColumn
        dColx.ColumnName = leftColumn
        dColx.Caption = leftColumn
        dtOut.Columns.Add(dColx)

        For Each drow As DataRow In dtColHeader.Rows
            Dim dCol As New DataColumn
            dCol.ColumnName = pFix & drow.Item(topField).ToString.Trim
            dtOut.Columns.Add(dCol)
            If dataValue2 <> vbNullString Then
                dCol = New DataColumn
                If drow.Item(topField).ToString.Trim <> vbNullString Then
                    dCol.ColumnName = "*" & pFix & drow.Item(topField).ToString.Trim
                    dtOut.Columns.Add(dCol)
                End If
            End If
        Next

        Dim drowx As DataRow
        For Each drow As DataRow In dtRowTitle.Rows
            drowx = dtOut.NewRow()
            drowx.Item(0) = drow.Item(leftColumn)
            dtOut.Rows.Add(drowx)
        Next

        Dim xVal As Int32 = 0
        Dim yVal As Int32 = 0

        For Each mRow As DataRow In dtS.Rows
            Dim xRowVal As String = mRow.Item(leftColumn).ToString
            Dim dataVal As String = mRow.Item(dataValue).ToString
            Dim dataVal2 As String
            If dataValue2 <> vbNullString Then dataVal2 = mRow.Item(dataValue2).ToString

            Dim yColVal As String = mRow.Item(topField).ToString.Trim
            For Each nRow As DataRow In dtOut.Rows
                If xRowVal = nRow.Item(0).ToString Then
                    For xVal = 0 To nRow.Table.Columns.Count() - 1
                        If nRow.Table.Columns(xVal).ColumnName = pFix & yColVal Then
                            Dim rIndex As Int32 = dtOut.Rows.IndexOf(nRow)
                            dtOut.Rows(rIndex).Item(xVal) = dataVal
                            If dataValue2 <> vbNullString Then dtOut.Rows(rIndex).Item(xVal + 1) = dataVal2
                            Exit For
                        End If
                    Next
                    Exit For
                End If
            Next
        Next

        '  dtOut.DefaultView.Sort = dtOut.Columns(0).ColumnName

        Return dtOut
    End Function
#End Region
#Region "Functions"
    Function sHeader(sCrit As String, sInttxt As String, sVal As String, sTxt As String) As String
        '    ViewState("jheight") = ViewState("jheight") + 12
        Return If(sVal <> vbNullString, If(sInttxt <> vbNullString, "<br/><font size=2>" & sInttxt.Replace("[P]", sTxt) & "</font>", "<br/><font size=2>" & If(sCrit <> vbNullString, sCrit & ": ", vbNullString) & sTxt & "</font>"), vbNullString)
    End Function
#End Region
#Region "PowerPoint"

    Sub SaveSlide(Optional sFileName As String = vbNullString)

        ' if file name is not nothing it is an pre prepared image

        Dim b As Boolean = sFileName = vbNullString

        Dim buffer As Byte() = Nothing

        If sFileName = vbNullString Then
            Dim imgByte As Byte() = Nothing
            Dim stream As New MemoryStream
            ChrtG.SaveImage(stream)
            buffer = stream.ToArray()
        End If


        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("ConnectionString")).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("INSERT INTO SV_SurveyImages(SurveyID,UserID,HeaderText," & If(b, "img", "FileName") & ") VALUES(@SurveyID,@UserID,@HeaderText," & If(b, "@Img", "@FileName") & ")", dbConnection)
        cD.Parameters.AddWithValue("@SurveyID", CInt(Right(ReadCookie_S("DDLSurveys_LastSY"), 3)))
        cD.Parameters.AddWithValue("@UserID", Session("UserID"))
        cD.Parameters.AddWithValue("@HeaderText", Regex.Replace(lblRepName.Text, "<.*?>", "|").Replace("||", "|"))
        If b Then
            cD.Parameters.AddWithValue("@Img", buffer)
        Else
            cD.Parameters.AddWithValue("@FileName", sFileName)
        End If

        dbConnection.Open()
        cD.ExecuteNonQuery()
        dbConnection.Close()
    End Sub

    Protected Sub btnExcel_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        Dim s As String = vbNullString
        Dim connStr As String = ConfigurationManager.ConnectionStrings(Session("ConnectionString")).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        cD.CommandType = CommandType.Text

        ' Check if Email address is available in the user record

        cD.CommandText = "Select UEmail From P0t_Ntb WHERE UserID = " & Session("UserID")
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            s = If(IsDBNull(dr("UEmail")), vbNullString, dr("UEmail"))
        End If
        dr.Close()
        dbConnection.Close()

        If s = vbNullString Then
            scrMsg("לא ניתן לשלוח אליך מצגת משום שחסרה בהגדרת המשתמש כתובת אימייל.<br/> נא לעדכן את הכתובת באמצעות צוות מערכת הניהול.<br/> תודה!", False)
        Else
            Session("SqlCommand") = "IF NOT EXISTS(SELECT * FROM sv_sENDPPT WHERE UserID=" & Session("UserID") & " AND SentTime IS NULL) insert into   sv_sENDPPT(UserID,LogTime) VALUES(" & Session("UserID") & ",'" & Format(DateAdd(DateInterval.Minute, -4, Now), "yyyy-MM-dd HH:mm:ss") & "')"
            scrMsg("מצגת פאורפוינט, ובה הגרפים שצפית בהם עד עתה,<br/> תשלח אליך בעוד מספר דקות.<br/> האם לשלוח את המצגת עכשיו?", False,
                    True, "כן", "window.open('ProcessSql.aspx','_blank');", _
                    "לא", "window.history.back(-3);")
        End If

    End Sub
#End Region
End Class