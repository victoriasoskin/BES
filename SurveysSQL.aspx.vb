Imports System.Xml.XPath
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.Net.Mail.MailMessage
Imports System.Configuration
Imports System.Web.Configuration
Imports System.Net.Configuration
Imports System.Data
Imports MessageBox
Imports WRCookies
Imports BesConst
Imports TreeViewSqlTable
Imports SurveysUtil
Imports PageErrors

Partial Class SurveysSQL
    Inherits System.Web.UI.Page
#Region "Definitions"
    'Dim rootElement As XElement
    '   Dim parentElement As XElement
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
    Dim sType As String
    Dim sTreeTable As String
    Dim cPageType As Collection
    Dim sSurveyName As String = vbNullString
    Dim sShortDesc As String = vbNullString
    Dim dSartDate As DateTime
    Dim dEndDate As DateTime
    Dim iLastAnswerGroup As Integer
    Dim dtAnswers As DataTable
    Dim iScroll As Integer = 0
#End Region

#Region "Form Setup"

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog(True)
        Server.ClearError()
        Try2reload()
    End Sub
    Sub Try2reload()
        If ReadCookie(SurveyCookiesKey, SurveyCookieFormID) IsNot Nothing Then
            Response.Redirect("SurveysSql.Aspx?s=" & Request.QueryString("S") & "&l=" & Request.QueryString("L") & "&ID=" & ReadCookie(SurveyCookiesKey, SurveyCookieFormID))
        Else
            SystemError("לצערנו המערכת נתקלה בבעיה ולא ניתן לשמור את הסקר,<br /> הודעה נשלחה לצוות המערכת", "הטופס נעלם")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        '' if no Survey in querystring

        If Request.QueryString("S") Is Nothing Then
            Response.Redirect("http://www.b-e.org.il")
        End If

        SurveyID = CInt(If(IsNumeric(Request.QueryString("S")), Request.QueryString("S"), "0"))
        Dim LanguageID As Integer = If(Request.QueryString("L") Is Nothing, "1", Request.QueryString("L"))
        If LanguageID = 2 Then
            divlvq.Attributes.Add("dir", "ltr")
            divlvq.Attributes.Add("style", "text-align:left;")
        End If

        ' Return Error Address

        Dim sUrl As String = vbNullString
        sUrl &= Request.ServerVariables("PATH_INFO")
        sUrl = Left(sUrl, InStrRev(sUrl, "/")) & "SurveyLogin.aspx?s=" & Request.QueryString("s") & "&L=" & LanguageID

        ' Entry information OK

        ' if Not Post back

        If Not IsPostBack Then

            ' Check if password Supplied

            If Request.QueryString("ID") IsNot Nothing Or Request.QueryString("ID") <> vbNullString Then
                Dim sPW As String = If(Session("PWD") Is Nothing, vbNullString, Session("PWD"))
                If sPW = vbNullString Then Response.Redirect("http://www.b-e.org.il")
                divrebkd.Visible = True
            End If

            '++++++       Session.Timeout = 2

            ' read survey definition

            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            SetSurveyCookies(SurveyID, sSurveyName, sShortDesc, dSartDate, dEndDate, LanguageID, "Book10VPS")

            ' Setup header

            SurHDR.Header = sSurveyName & " -" & sShortDesc


            '  Create Form new form

            If Request.QueryString("ID") Is Nothing Then
                Dim ConComp As New SqlCommand("SV_pSurveys_CreateForm", dbConnection)
                ConComp.CommandType = CommandType.StoredProcedure
                ConComp.Parameters.AddWithValue("SurveyID", SurveyID)
                If Request.QueryString("L") IsNot Nothing Then ConComp.Parameters.AddWithValue("LanguageID", Request.QueryString("L"))
                Dim df As New SqlParameter("FormID", Data.SqlDbType.Int)
                df.Direction = Data.ParameterDirection.Output
                ConComp.Parameters.Add(df)
                dbConnection.Open()
                Try
                    ConComp.ExecuteNonQuery()
                    FormNo = df.Value
                Catch ex As Exception
                    Throw ex
                    FormNo = -9
                End Try
                dbConnection.Close()
            Else
                FormNo = Request.QueryString("ID")
            End If

            ' New Form Creation Failed - Start login process again

            If FormNo <= 0 Then
                SystemError("שגיאת מערכת מס 100 . נסה שנית בבקשה.<br /><br />אם הבעיה חוזרת, אנא הודע מיד, בכל שעה,<br /> לאריאל בטלפון 050-6379121, תודה!", "לא נוצר טופס")
                Exit Sub
            End If

            WriteCookie(SurveyCookiesKey, SurveyCookieFormID, FormNo.ToString)

            ' writh FormID to Header

            SurHDR.FormNumber = FormNo.ToString

            ' Populate Form Tree View

            sTreeTable = "(SELECT gid,txt,Parent,ord FROM SV_vSurGroups where SurveyID=" & SurveyID & ")"

            PopulateRootLevel(TVGROUPS, "gid", "txt", sTreeTable, "Parent", -1, "ord", "Book10VPS")
            PopulateSubLevel(0, TVGROUPS.Nodes(0), "gid", "txt", sTreeTable, "Parent", -1, "ord", "Book10VPS")

            ' SHow FirstPage

            SelectListView(1)

        Else
            divrebkd.Visible = False

            ' Check if Session is Alive

            If ReadCookie(SurveyCookiesKey, SurveyCookieFormID) Is Nothing Then
                SystemError("עקב אי שימוש ממושך או כניסה לא חוקית, נתוני הסקר לא נשמרו", "יציאה לא חוקית ", , , "window.open('', '_self', ''); window.close();")
                Exit Sub


            End If

        End If

    End Sub

    Protected Sub dslvq_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles dslvq.Selecting
        If Not IsPostBack Then
            e.Command.Parameters("@Grp").Value = 1
        End If

        If WhichPage() = "Header" Then
            e.Command.Cancel()
        Else
            SelectListView(e.Command.Parameters("@Grp").Value)
        End If
        If e.Command.Parameters("@FormID").Value Is Nothing Then
            e.Command.Parameters("@FormID").Value = SurHDR.FormNumber   'ReadCookie(SurveyCookiesKey, SurveyCookieFormID)
        End If
    End Sub
    Protected Sub lv_q_ItemCreated(sender As Object, e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles lv_q.ItemCreated
        Dim item As ListViewDataItem = CType(e.Item, ListViewDataItem)

        Dim drv As System.Data.DataRowView = CType(item.DataItem, System.Data.DataRowView)
        Dim hdn As HiddenField = CType(e.Item.FindControl("hdnControl"), HiddenField)
        Dim lv As ListView = CType(e.Item.FindControl("lvframes"), ListView)
        Dim cb As CheckBox = CType(e.Item.FindControl("cbYes"), CheckBox)
        lv.Visible = False
        lv.DataSourceID = Nothing
        If item.DataItem IsNot Nothing Then
            If item.DataItem.Item("Control").ToString = "listview" Then
                lv.Visible = True
                lv.DataSourceID = "DSSERVICES"
            End If
            If item.DataItem.Item("Control").ToString = "checkbox" Then
                cb.Visible = True
            End If
        End If
    End Sub
    Sub SelectListView(i As Integer)
        If i = 0 Then Exit Sub
        Dim s As String = PageSType(SurveyID, i)
        Select Case s
            Case "Para"
                divlvp.Visible = True
                divlvq.Visible = False
                lv_p.DataBind()
            Case "Question"
                divlvp.Visible = False
                divlvq.Visible = True
                lv_q.DataBind()
        End Select

    End Sub
#End Region

#Region "Answers"
    Protected Sub rbla_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim LBL As Label
        If rbl.Items.Count = 0 Then
            Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
            Dim lv As ListView = CType(lvi.NamingContainer, ListView)
            Dim s As String = Right(lv.ID, 1)
            'Dim hdn As HiddenField = CType(lvi.FindControl("hdnid_" & s), HiddenField)
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnAnsGroup"), HiddenField)
            If IsNumeric(hdn.Value) Then
                If hdn.Value > 0 Then
                    If iLastAnswerGroup <> hdn.Value Then
                        iLastAnswerGroup = hdn.Value
                        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
                        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                        Dim ConComp As New SqlCommand("SELECT ISNULL(l.AnswerText,a.AnswerText) as txt,a.val FROM SV_SurAnswers a LEFT OUTER JOIN (SELECT ID,AnswerText FROM SV_SurAnswers_L WHERE LanguageID=" & If(Request.QueryString("L") Is Nothing, "1", Request.QueryString("L")) & ") l ON l.ID=a.ID Where a.SurveyID=" & Request.QueryString("S") & " AND a.AnsGroup=" & hdn.Value & " ORDER BY ISNULL(a.ord,0),a.Val", dbConnection)
                        Dim da As New SqlDataAdapter(ConComp)
                        dtAnswers = New DataTable()
                        da.Fill(dtAnswers)
                    End If
                    rbl.DataSource = dtAnswers
                    rbl.CssClass = "rblbrdr"
                    Dim btn As Button = CType(lvi.FindControl("btnCancel"), Button)
                    LBL = CType(lvi.FindControl("lblCancel"), Label)
                    btn.Visible = True
                    LBL.Visible = False
                    If dtAnswers.Rows.Count > 5 Then
                        rbl.RepeatDirection = RepeatDirection.Vertical
                        '    rbl.Font.Size = FontSize.XLarge
                    End If
                End If
            End If
        End If
    End Sub
    Protected Sub rbla_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        'rbl.CssClass = "rblbrdr"
        'If rbl.Items.Count > 5 Then
        '    rbl.RepeatDirection = RepeatDirection.Vertical
        '    rbl.Font.Size = FontSize.XLarge
        'End If
        rbl.BackColor = Drawing.Color.Transparent
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdn As HiddenField = CType(lvi.FindControl("HDNANS_" & s), HiddenField)
        If rbl.SelectedIndex < 0 And hdn.Value IsNot Nothing And hdn.Value <> vbNullString Then
            rbl.SelectedValue = hdn.Value
        End If
        If ViewState("Err") IsNot Nothing And ViewState("Err") = -1 Then
            If iScroll > 0 And iScroll + 2 = lvi.DisplayIndex Then
                rbl.Focus()
                iScroll = -1
            End If
            If rbl.Items.Count > 0 And rbl.SelectedIndex < 0 Then
                rbl.BackColor = Drawing.Color.Plum
                If iScroll >= 0 Then
                    If iScroll = 0 Then
                        iScroll = lvi.DisplayIndex
                    End If
                End If
            End If
        End If
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
    Protected Sub rbla_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Dim lvi As ListViewItem = CType(rbl.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdnfrmid As HiddenField = CType(lvi.FindControl("HDNFRMID_" & s), HiddenField)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim ConCompI As New SqlCommand("SV_pSurvey_UpdateAnswer", dbConnection)
        ConCompI.CommandType = Data.CommandType.StoredProcedure

        ConCompI.Parameters.AddWithValue("FormID", ReadCookie(SurveyCookiesKey, SurveyCookieFormID))
        If IsNumeric(hdnfrmid.Value) Then ConCompI.Parameters.AddWithValue("FrameID", hdnfrmid.Value)
        ConCompI.Parameters.AddWithValue("QuestionID", hdnid.Value)
        ConCompI.Parameters.AddWithValue("Val", rbl.SelectedValue)
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        ConCompI.Parameters.Add(df)

        Try
            ConCompI.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                            "תשובה לא נקלטה <br/>" & _
                            "ErrCode = " & i & "<br />" & _
                            "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                            "Question = " & hdnid.Value & "<br />" & _
                            "Val = " & rbl.SelectedValue)
            End If
        Catch ex As Exception
            SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                          "תשובה לא נקלטה <br/>" & _
                          " Message Text ='" & ex.ToString & "'<br/" & _
                           "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                          "Question = " & hdnid.Value & "<br />" & _
                          "Val = " & rbl.SelectedValue)

        End Try
        dbConnection.Close()
    End Sub
    Protected Sub cbYes_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdnfrmid As HiddenField = CType(lvi.FindControl("HDNFRMID_" & s), HiddenField)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim ConCompI As New SqlCommand("SV_pSurvey_UpdateAnswer", dbConnection)
        ConCompI.CommandType = Data.CommandType.StoredProcedure

        ConCompI.Parameters.AddWithValue("FormID", ReadCookie(SurveyCookiesKey, SurveyCookieFormID))
        If IsNumeric(hdnfrmid.Value) Then ConCompI.Parameters.AddWithValue("FrameID", hdnfrmid.Value)
        ConCompI.Parameters.AddWithValue("QuestionID", hdnid.Value)
        ConCompI.Parameters.AddWithValue("Val", If(cb.Checked, 1, 0))
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        ConCompI.Parameters.Add(df)

        Try
            ConCompI.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                            "תשובה לא נקלטה <br/>" & _
                            "ErrCode = " & i & "<br />" & _
                            "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                            "Question = " & hdnid.Value & "<br />" & _
                            "Val = " & If(cb.Checked, 1, 0))
            End If
        Catch ex As Exception
            SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                          "תשובה לא נקלטה <br/>" & _
                          " Message Text ='" & ex.ToString & "'<br/" & _
                           "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                          "Question = " & hdnid.Value & "<br />" & _
                          "Val = " & If(cb.Checked, 1, 0))

        End Try
        dbConnection.Close()
    End Sub

    Protected Sub tb_OnTextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tb As TextBox = CType(sender, TextBox)
        Try
            Dim stxt As String = tb.Text.Replace("<", " ").Replace(">", " ").Replace("&lt;", " ").Replace("&gt;", " ")
        Catch ex As Exception
            Throw ex
        End Try
        Dim lvi As ListViewItem = CType(tb.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdnfrmid As HiddenField = CType(lvi.FindControl("HDNFRMID_" & s), HiddenField)
        FormNo = ReadCookie(SurveyCookiesKey, SurveyCookieFormID)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConCompI As New SqlCommand("SV_pSurvey_UpdateText", dbConnection)

        dbConnection.Open()
        ConCompI.CommandType = Data.CommandType.StoredProcedure

        ConCompI.Parameters.AddWithValue("FormID", FormNo)
        If IsNumeric(hdnfrmid.Value) Then ConCompI.Parameters.AddWithValue("FrameID", hdnfrmid.Value)
        ConCompI.Parameters.AddWithValue("QuestionID", hdnid.Value)
        Dim dfTxt As New SqlParameter("Txt", System.Data.SqlDbType.NVarChar, 1000)
        dfTxt.Value = tb.Text.Replace("<", " ").Replace(">", " ").Replace("&lt;", " ").Replace("&gt;", " ")
         ConCompI.Parameters.Add(dfTxt)
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        ConCompI.Parameters.Add(df)
        Try
            ConCompI.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("הטקסט שהקלדת לא נקלט, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                            "טקסט לא נקלט <br/>" & _
                            "ErrCode = " & i & "<br />" & _
                            "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                            "Question = " & hdnid.Value & "<br />" & _
                            "Val = '" & tb.Text & "'")
            End If
        Catch ex As Exception
            SystemError("הטקסט שהקלדת לא נקלט, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                        "טקסט לא נקלט <br/>" & _
                        " Message Text ='" & ex.ToString & "'<br/" & _
                           "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                        "Question = " & hdnid.Value & "<br />" & _
                        "Val = '" & tb.Text & "'")
        End Try
        dbConnection.Close()
    End Sub
#End Region

#Region "Save Form"
    Protected Sub BTNCLS_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        bLog = True
        Dim s As String = vbNullString
        If bauto Then
            bauto = False
            Exit Sub
        End If


        ' Check Form State

        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        FormNo = ReadCookie(SurveyCookiesKey, SurveyCookieFormID)

        ' Check if Answers rows Exist, if not - Problem!

        Dim cU As New SqlCommand("IF  EXISTS(SELECT * FROM SV_Survey_Answers WHERE FormID = @FormID) Select 1", dbConnection)
        cU.CommandType = CommandType.Text
        cU.Parameters.AddWithValue("FormID", FormNo)
        dbConnection.Open()

        Dim dr As SqlDataReader = cU.ExecuteReader
        If Not dr.Read Then
            SystemError("תקלת מערכת. הטופס לא נשמר (מספר " & FormNo & ")<br />אנא הודע לאריאל. טלפון 050-6379121", "לא נשמרו תשובות לטופס מספר  " & FormNo)
            dr.Close()
            dbConnection.Close()
            Exit Sub
        End If
        dr.Close()

        ' Check if Form is Full otherwise tell user

        cU.CommandText = "SELECT g.[gid],g.[Group],COUNT(a.QuestionID) AS c,COUNT(q.Must) AS m " & _
                                 "FROM SV_Survey_Answers a " & _
                                 "LEFT OUTER JOIN SV_Survey_Forms f ON f.FormID=a.FormID " & _
                                 "LEFT OUTER JOIN	SV_SurQuestions q ON q.QuestionID=a.QuestionID AND q.SurveyID=f.SurveyID " & _
                                 "LEFT OUTER JOIN SV_SurGroup g ON q.QuestionGrp=g.gid and q.SurveyID=g.SUrveyID " & _
                                 "WHERE(a.FormID = @FormID AND a.Val IS NULL AND q.AnswerGroup IS NOT NULL) " & _
                                 " GROUP BY [Group],gid "

        dr = cU.ExecuteReader
        Dim sE As String = vbNullString
        Dim bMustNotCompleted As Boolean = False
        ViewState("TVGMUST") = vbNullString ' Remember first page with Must ununswerwed question
        ViewState("TVG") = vbNullString ' Remember first page with ununswerwed question
        While dr.Read
            If sE = vbNullString Then
                sE = "<table border='1'><tr><td colspan='3' style='text-decoration:underline;text-align:center;'>יש שאלות שלא נענו</td></tr><tr><td>שם הפרק</td><td>לא נענו</td><td>מתוכם חובה</td></tr>"
            End If
            bMustNotCompleted = bMustNotCompleted Or (dr("M") > 0)
            If ViewState("TVGMUST") = vbNullString And bMustNotCompleted Then ViewState("TVGMUST") = dr("gid")
            If ViewState("TVG") = vbNullString And dr("C") > 0 Then ViewState("TVG") = dr("gid")
            sE &= "<tr><td>" & dr("Group") & "</td><td>" & If(dr("C") = 0, "&nbsp;", dr("C")) & "</td><td>" & If(dr("M") = 0, "&nbsp;", dr("M")) & "</td></tr>"
        End While

        ' if not all questions where answered

        If sE <> vbNullString Then

            If bMustNotCompleted Then sE &= "<tr><td colspan='3' style='font-weight:bold;'>לא ניתן לסגור שאלון אם יש שאלות חובה שלא נענו</td></tr>"
            sE &= "</table>"
            ViewState("Err") = -1

            If bMustNotCompleted Then

                ' Not all "must" questions answered - do not allow closing

                scrMsg(sE, True, , "חזור לשאלה הראשונה שלא נענתה", , , , "BackToAnswer")

            Else

                ' if there are questions not answered the user can close the form or go back and complete answers

                scrMsg(sE, True, True, "שלח את השאלון למערכת", , "חזור לשאלה הראשונה שלא נענתה", , "saveform", "BackToAnswer")

            End If

        Else

            SaveForm()

        End If

    End Sub
    Sub BackToAnswer()
        Dim nd As TreeNode = TVGROUPS.FindNode("0/" & If(ViewState("TVGMUST") <> vbNullString, ViewState("TVGMUST"), ViewState("TVG")))
        If nd IsNot Nothing Then
            nd.Select()
            TVGROUPS_SelectedNodeChanged(TVGROUPS, Nothing)
        End If
    End Sub
    Sub SaveForm()
        FormNo = ReadCookie(SurveyCookiesKey, SurveyCookieFormID)
        Dim b As Boolean = True
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

        ' Check if Answers rows Exist, if not - Problem!

        Dim cU As New SqlCommand("SV_pSurvey_CloseForm", dbConnection)
        cU.CommandType = CommandType.StoredProcedure
        cU.Parameters.AddWithValue("FormID", FormNo)
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        cU.Parameters.Add(df)

        dbConnection.Open()
        Try
            cU.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("הוספת השאלון נכשלה!<br />. אנא התקשר לאריאל, טלפון: 050-6379121", _
                           "שאלון לא נסגר <br/>" & _
                           "ErrCode = " & i & "<br />" & _
                           "Form = " & FormNo & "<br />")
                b = False
            Else

            End If
        Catch ex As Exception
            SystemError("הוספת השאלון נכשלה!<br />. אנא התקשר לאריאל, טלפון: 050-6379121", _
                           "שאלון לא נסגר <br/>" & _
                             " Message Text ='" & ex.ToString & "'<br/" & _
                           "Form = " & FormNo & "<br />")
            b = False
        End Try
        dbConnection.Close()

        If b Then Response.Redirect("SurveyThanks.aspx?s=" & Request.QueryString("S"))

    End Sub

#End Region

#Region "Frames"
    Dim cFrameList As Collection
    Protected Sub DL_DataBinding(sender As Object, e As System.EventArgs)
        Dim dl As DataList = CType(sender, DataList)
        Dim s As String = Right(dl.ID, 1)
        s = "SID" & s & "hiddenField"
        Dim hdn As HiddenField = CType(CType(dl.NamingContainer, ListViewItem).FindControl(s), HiddenField)
        If hdn IsNot Nothing AndAlso IsNumeric(hdn.Value) Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("SELECT FrameID,FrameName FROM SV_vSurvey_Frames Where SurveyID=" & Request.QueryString("S") & " AND ServiceID=" & hdn.Value & " Order by ISNULL(ord,0)", dbConnection)
            Dim da As New SqlDataAdapter(ConComp)
            Dim dt As New DataTable()
            da.Fill(dt)
            dl.DataSource = dt
        End If
    End Sub
    Protected Sub lblSingleFrame_PreRender(sender As Object, e As System.EventArgs) Handles lblSingleFrame.PreRender
        Dim s As String = "<script type='text/javascript'>function SingleSelect(regex, current) {"

        If ReadCookie(SurveyCookiesKey, SurveyCookieSingleFrameFlag) <> 0 Then
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
        End If

        s &= " }</script>"

        lblSingleFrame.Text = s
    End Sub
    Sub lblMaxCount_PreRender(sender As Object, e As System.EventArgs)
        Dim s As String
        Dim iCnt As Integer = 0
        Dim lbl As Label = CType(sender, Label)
        If lbl.Text = vbNullString Then
            s = vbNullString
        Else
            Dim lvi As ListViewItem = CType(lbl.NamingContainer, ListViewItem)
            Dim lv As ListView = CType(lvi.NamingContainer, ListView)
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnID_q"), HiddenField)
            s = hdn.Value
            Dim i As Integer = lvi.DisplayIndex
            For j As Integer = i + 1 To lv.Items.Count - 1
                hdn = CType(lv.Items(j).FindControl("hdnID_q"), HiddenField)
                If IsNumeric(hdn.Value) Then
                    If CStr(CInt(hdn.Value / 100)) = s Then
                        hdn = CType(lv.Items(j).FindControl("hdnAns_q"), HiddenField)
                        If hdn.Value = "1" Then iCnt += 1
                    Else
                        Exit For
                    End If
                End If
            Next
            s = "<script type='text/javascript'>" & vbCrLf & _
                "var iMax" & s & " = " & lbl.Text & ";" & vbCrLf & _
                "var iCur" & s & " = " & iCnt & ";" & vbCrLf & _
              "function countClicks" & s & "(current) {" & vbCrLf & _
                "   if (current.checked) { iCur" & s & "++; } else { iCur" & s & " = iCur" & s & " - 1; };" & vbCrLf & _
                "   if (iCur" & s & " > iMax" & s & ") {" & vbCrLf & _
                "	    alert('אין לסמן יותר מ ' + iMax" & s & " + ' אפשרויות ');" & vbCrLf & _
                "	    iCur" & s & " = iCur" & s & " - 1;" & vbCrLf & _
                "       current.checked = false;" & vbCrLf & _
                "	}" & vbCrLf & _
                "}" & vbCrLf & _
                "</script>"
        End If
        lbl.Text = s
    End Sub

    Protected Sub LVFRAMES_PreRender(sender As Object, e As System.EventArgs)
        Dim lv As ListView = CType(sender, ListView)
        Dim lvitd As ListViewItem = CType(lv.NamingContainer, ListViewItem)
        Dim dv As HtmlGenericControl = CType(lvitd.FindControl("divFrames"), HtmlGenericControl)

        ' Prepare list of Frames

        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("SELECT FrameID FROM SV_Survey_EFrameList Where FormID=" & ReadCookie(SurveyCookiesKey, SurveyCookieFormID), dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader
        Dim cFormFrames As New Collection
        While dr.Read
            cFormFrames.Add(dr("FrameID"))
        End While
        For Each lvi As ListViewItem In lv.Items
            For j As Integer = 1 To 2
                Dim dl As DataList = CType(lvi.FindControl("dl" & j), DataList)
                If dl IsNot Nothing Then
                    For Each itm As DataListItem In dl.Items
                        Dim hdn As HiddenField = CType(itm.FindControl("hdn"), HiddenField)
                        Dim cb As CheckBox = CType(itm.FindControl("cbf"), CheckBox)
                        If hdn IsNot Nothing Then
                            If IsNumeric(hdn.Value) Then
                                Dim k As Integer = hdn.Value
                                For i As Integer = 1 To cFormFrames.Count
                                    If k = cFormFrames(i) Then
                                        cb.Checked = True
                                    End If
                                Next
                            End If
                        End If
                    Next
                End If
            Next
        Next

        If ViewState("Err") IsNot Nothing And ViewState("Err") = -1 Then
            If cFormFrames.Count <= 0 Then
                dv.Attributes.Add("style", "background-Color:#DDA0DD;")
                If iScroll = 0 Then iScroll = lvitd.DisplayIndex
            Else
                dv.Attributes.Add("style", "background-Color:transparent;")
            End If
        End If
    End Sub
    Protected Sub cb_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim lvi As ListViewItem = CType(cb.NamingContainer.NamingContainer.NamingContainer.NamingContainer.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdn As HiddenField = CType(CType(cb.NamingContainer, DataListItem).FindControl("hdn"), HiddenField)
        EFrame_q(hdn.Value, cb.Checked, hdnid.Value)
    End Sub
    Sub EFrame_q(ByVal iFrameID As Integer, bAdd As Boolean, iQuestionID As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cI As New SqlCommand("SV_pSurvey_UpdateEFrames", dbConnection)
        cI.CommandType = Data.CommandType.StoredProcedure

        cI.Parameters.AddWithValue("SurveyID", Request.QueryString("S"))
        cI.Parameters.AddWithValue("FormID", ReadCookie(SurveyCookiesKey, SurveyCookieFormID))
        cI.Parameters.AddWithValue("FrameID", iFrameID)
        cI.Parameters.AddWithValue("QuestionID", iQuestionID)
        cI.Parameters.AddWithValue("ADD", bAdd)
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        cI.Parameters.Add(df)
        dbConnection.Open()
        Try
            cI.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("הוספת מסגרת נכשלה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                           "מסגרת לא נקלטה <br/>" & _
                           "ErrCode = " & i & "<br />" & _
                           "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                           "Val = '" & iFrameID & "'")
            End If
        Catch ex As Exception
            SystemError("הוספת מסגרת נכשלה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                        "מסגרת לא נקלטה <br/>" & _
                              " Message Text ='" & ex.ToString & "'<br/" & _
                            "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                          "Val = '" & iFrameID & "'")
        End Try
        dbConnection.Close()
    End Sub
#End Region

#Region "Form Navigation"
    Protected Sub TVGROUPS_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.DataBound
        If TVGROUPS.Nodes.Count = 0 Then Exit Sub
        If Not IsPostBack Then
            Dim Nd As TreeNode = TVGROUPS.Nodes(0)
            tvs0(Nd, iStatus)
        End If
    End Sub
    Protected Sub TVGROUPS_PreRender(sender As Object, e As System.EventArgs) Handles TVGROUPS.PreRender
        If TVGROUPS.SelectedNode Is Nothing Then
            Dim n As TreeNode = TVGROUPS.FindNode("0/1")
            If n IsNot Nothing Then n.Selected = True
        End If
    End Sub
    Protected Sub Button2_PreRender(sender As Object, e As System.EventArgs) Handles Button2A.PreRender
        Dim btn As Button = CType(sender, Button)
        btn.Enabled = WhichPage() <> "First"
    End Sub
    Protected Sub Button3_PreRender(sender As Object, e As System.EventArgs) Handles Button3A.PreRender
        Dim btn As Button = CType(sender, Button)
        btn.Enabled = WhichPage() <> "Last"
        btncls0.Visible = Not btn.Enabled
        If iScroll > 0 Then
            btn.Focus()
            iScroll = -1
        End If
    End Sub
    Protected Sub TVGROUPS_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TVGROUPS.SelectedNodeChanged

        Dim n As TreeNode = TVGROUPS.SelectedNode

        ' if first page then 1) go to first page
        '                    2) Toggle expand/colleps

        If WhichPage() = "Header" Then
            n = TVGROUPS.FindNode("0/1")
            If n IsNot Nothing Then n.Selected = True
            If n.Expanded Then
                TVGROUPS.CollapseAll()
            Else
                TVGROUPS.ExpandAll()
            End If
        End If

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
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1A.Click
        Dim Nd As TreeNode = TVGROUPS.Nodes(0)
        tvs0(Nd)
    End Sub
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2A.Click
        Dim Nd As TreeNode = TVGROUPS.SelectedNode
        If Nd.ChildNodes.Count > 0 Then
            tvs0(Nd, 1)
        Else
            tvsm1(Nd)
        End If
        If TVGROUPS.SelectedNode.ChildNodes.Count = 0 Then SelectListView(TVGROUPS.SelectedValue)
    End Sub
    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3A.Click
        Dim Nd As TreeNode
        Try
            Nd = TVGROUPS.SelectedNode
            Dim s As String = Nd.Value
            If Nd.ChildNodes.Count > 0 Then
                tvs0(Nd)
                Exit Sub
            End If
        Catch ex As Exception

            tvs0(TVGROUPS.Nodes(0))
            Exit Sub
        End Try
        tvs1(Nd)
    End Sub
    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4A.Click
        Dim Nd As TreeNode = TVGROUPS.Nodes(0)
        tvs0(Nd, 1)
    End Sub
    Function PageSType(iSurveyID As Integer, iGrp As Integer) As String
        If cPageType IsNot Nothing AndAlso cPageType.Count > 0 Then
        Else
            cPageType = New Collection
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cI As New SqlCommand("SELECT SType,gid From SV_SurGroup WHERE SurveyID=" & iSurveyID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cI.ExecuteReader
            While dr.Read
                cPageType.Add(dr("sType"), dr("gid").ToString)
            End While
        End If

        Dim s As String = vbNullString
        Try
            s = cPageType(iGrp.ToString)
        Catch ex As Exception
        End Try
        Return s
    End Function
    Function WhichPage() As String ' Header="Feader",First = "First",Last="Last", Middle = Numeric 
        Dim s As String = vbNullString
        If TVGROUPS.SelectedNode IsNot Nothing Then
            Dim sL As String = TVGROUPS.Nodes(0).ChildNodes.Count.ToString
            s = TVGROUPS.SelectedNode.ValuePath
            s = Mid(s, InStr(s, "/") + 1)
            Select Case s
                Case "0"
                    s = "Header"
                Case "1"
                    s = "First"
                Case sL
                    s = "Last"
            End Select
        Else
            s = "First"
        End If
        Return s
    End Function
#End Region

#Region "scrMsg"
    Sub SystemError(sMsg As String, sMailMsg As String, Optional bTwoButtons As Boolean = False, Optional sbtnMsgText As String = "אישור", Optional sbtnMsgOnClickText As String = vbNullString, Optional sbtnTwoText As String = "ביטול", Optional sbtnTwoOnClickText As String = vbNullString)
        WriteErrorLog(True)
        scrMsg(sMsg, True, bTwoButtons, sbtnMsgText, sbtnMsgOnClickText, sbtnTwoText, sbtnTwoOnClickText)
        SendMail(sMailMsg)
    End Sub
    Sub scrMsg(sMsg As String, bErr As Boolean, Optional bTowButtons As Boolean = False, Optional sbtnMsgText As String = "אישור", Optional sbtnMsgOnClickText As String = vbNullString, Optional sbtnTwoText As String = "ביטול", Optional sbtnTwoOnClickText As String = vbNullString, Optional ByVal btn1SrvrAction As String = vbNullString, Optional ByVal btn2SrvrAction As String = vbNullString)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:10%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"
        btnmsg.Text = sbtnMsgText
        If sbtnMsgOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnMsgOnClickText)
        hdn1SrvrAction.Value = btn1SrvrAction
        hdn2SrvrAction.Value = btn2SrvrAction

        If bTowButtons Then
            btnTwo.Visible = True
            btnTwo.Text = sbtnTwoText
            If sbtnTwoOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnTwoOnClickText)
            Dim i As Integer = If(sbtnMsgText.Length > sbtnTwoText.Length, sbtnMsgText.Length, sbtnTwoText.Length) * 10 + 20
            btnmsg.Width = i
            btnTwo.Width = i
        End If

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Blue", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click, btnTwo.Click
        Dim btn As Button = CType(sender, Button)
        Dim s As String
        Select Case LCase(btn.ID)
            Case "btnmsg"
                s = hdn1SrvrAction.Value
                If s IsNot Nothing Then
                    Select Case LCase(s)
                        Case "saveform"
                            SaveForm()
                        Case "backtoanswer"
                            BackToAnswer()
                    End Select
                End If
            Case "btntwo"
                s = hdn2SrvrAction.Value
                If s IsNot Nothing Then
                    Select Case LCase(s)
                        Case "saveform"
                            SaveForm()
                        Case "backtoanswer"
                            BackToAnswer()
                    End Select
                End If

        End Select
        divmsg.Visible = False
        divform.Disabled = False
        lv_q.DataBind()
    End Sub
#End Region

#Region "Mail"

    Sub SendMail(ByVal sBody As String)
        WriteErrorLog(True)
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
            If ReadCookie("survey", "LastCustID") IsNot Nothing Then
                Sid = ReadCookie("survey", "LastCustID")
            End If

            m.Subject = "תקלה בסקר תז: " & Sid & " מספר טופס:" & FormNo
            m.To.Add(New MailAddress("ariel@topyca.com"))
            m.From = New MailAddress("Survey@be-online.org")

            Try
                dd.Send(m)
            Catch ex As Exception
                scrMsg("בעיה במשלוח דורר מהמערכת. <br />אנא, התקשר לאריאל בלכ שעה. טל' 050-6379121, תודה", True)
            End Try

        End If
    End Sub

#End Region

    Protected Sub cbYes_PreRender(sender As Object, e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
        Dim hdn As HiddenField = CType(lvi.FindControl("HDNParent"), HiddenField)
        If hdn.Value IsNot Nothing Then
            Dim s As String = hdn.Value
            cb.Attributes.Add("onclick", "countClicks" & s & "(this);")
            hdn = CType(lvi.FindControl("HDNAns_q"), HiddenField)
            If hdn.Value <> vbNullString Then
                If hdn.Value = 1 Then
                    cb.InputAttributes.Add("onloadeddata", "loadCount" & s & "();")
                End If
            End If
        End If
    End Sub
    Protected Sub rev_PreRender(sender As Object, e As System.EventArgs)
        '    Dim rev As RegularExpressionValidator = CType(sender, RegularExpressionValidator)
        '    rev.ValidationExpression = ""
    End Sub
    Protected Sub btnCancel_Click(sender As Object, e As System.EventArgs)
        Dim cb As Button = CType(sender, Button)
        Dim lvi As ListViewItem = CType(cb.NamingContainer, ListViewItem)
        Dim lv As ListView = CType(lvi.NamingContainer, ListView)
        Dim s As String = Right(lv.ID, 1)
        Dim hdnid As HiddenField = CType(lvi.FindControl("HDNID_" & s), HiddenField)
        Dim hdnfrmid As HiddenField = CType(lvi.FindControl("HDNFRMID_" & s), HiddenField)
        Dim rbla As RadioButtonList = CType(lvi.FindControl("rbla_q"), RadioButtonList)
        Dim hdnans As HiddenField = CType(lvi.FindControl("HDNANS_q"), HiddenField)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPS").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim ConCompI As New SqlCommand("SV_pSurvey_UpdateAnswer", dbConnection)
        ConCompI.CommandType = Data.CommandType.StoredProcedure

        ConCompI.Parameters.AddWithValue("FormID", ReadCookie(SurveyCookiesKey, SurveyCookieFormID))
        If IsNumeric(hdnfrmid.Value) Then ConCompI.Parameters.AddWithValue("FrameID", hdnfrmid.Value)
        ConCompI.Parameters.AddWithValue("QuestionID", hdnid.Value)
        ConCompI.Parameters.AddWithValue("Val", DBNull.Value)
        Dim df As New SqlParameter("ErrCODE", Data.SqlDbType.Int)
        df.Direction = Data.ParameterDirection.Output
        ConCompI.Parameters.Add(df)

        Try
            ConCompI.ExecuteNonQuery()
            Dim i As Integer = df.Value
            If i <> 0 Then
                SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                            "תשובה לא נקלטה <br/>" & _
                            "ErrCode = " & i & "<br />" & _
                            "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                            "Question = " & hdnid.Value & "<br />" & _
                            "Val = NULL")
            End If
        Catch ex As Exception
            SystemError("התשובה לשאלה לא נקלטה, אנא, נסה שנית!<br />. אם הבעיה חוזרת, אנא התקשר לאריאל, טלפון: 050-6379121", _
                          "תשובה לא נקלטה <br/>" & _
                          " Message Text ='" & ex.ToString & "'<br/" & _
                           "Form = " & ReadCookie(SurveyCookiesKey, SurveyCookieFormID) & "<br />" & _
                          "Question = " & hdnid.Value & "<br />" & _
                          "Val = NULL")

        End Try
        rbla.ClearSelection()
        hdnans.Value = Nothing
        dbConnection.Close()
        lv.DataBind()
    End Sub
End Class