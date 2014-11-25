Imports System.Data.SqlClient
Partial Class LESM
    Inherits System.Web.UI.Page
    Dim xEL As XElement
    Dim cID As New Collection
#Region "Search"

    Protected Sub btnClear_Click(sender As Object, e As System.EventArgs) Handles btnClear.Click
        tbSearch.Text = Nothing
    End Sub

#End Region

#Region "Form"

    Protected Sub btnFill_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)

        If tbSearch.Enabled = True Then

            'Show only this Row and Disable Search

            Dim lvi As ListViewItem = CType(btn.NamingContainer, ListViewItem)
            Dim lbl As Label = CType(lvi.FindControl("lblEmpID"), Label)
            tbSearch.Text = lbl.Text
            lvi.DataBind()

            tbSearch.Enabled = False
            btnClear.Enabled = False
            btnSearch.Enabled = False

            'Load Manager form

            FVIEW.DataBind()

            'Load Query form

            LoadForm()
        Else

            ' Back to full list

             ClearForm()

        End If

 
    End Sub

    Sub LoadForm()

        ' Load empty form

        Dim iFID As Integer
        LVFORM.Visible = True
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
        Dim Query = From q In xEL.Descendants("Question") _
        Select New With { _
            .id = q.Attribute("id").Value, _
            .txt = q.Element("txt").Value, _
            .style = If(q.Attribute("style") Is Nothing, vbNullString, q.Attribute("style").Value), _
            .cntrl = If(q.Attribute("control") Is Nothing, vbNullString, q.Attribute("control").Value)}
        LVFORM.DataSource = Query
        LVFORM.DataBind()

        ' if it is a closed form - load answers

        Dim s As String = CType(FVIEW.FindControl("hdnFormID"), HiddenField).Value
        If IsNumeric(s) Then
            iFID = CInt(s)
        End If

        Dim cAnswers As New Collection
        Dim cTexts As New Collection

        If iFID <> 0 Then

            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT QuestionID,Val FROM EL_FormAnswers WHERE FormID = " & iFID, dbConnection)
            cD.CommandType = Data.CommandType.Text
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader

            ' Load Integers

            While dr.Read
                cAnswers.Add(dr("val"), CStr(dr("QuestionID")))
            End While
            dr.Close()

            ' Load Texts

            cD.CommandText = "SELECT QuestionID,TText FROM EL_FormTexts WHERE FormID = " & iFID
            dr = cD.ExecuteReader
            While dr.Read
                cTexts.Add(dr("TText"), CStr(dr("QuestionID")))
            End While
            dr.Close()
            dbConnection.Close()

        End If

        For Each lvi As ListViewItem In LVFORM.Items
            Dim hdn As HiddenField = CType(lvi.FindControl("hdnid"), HiddenField)
            Dim rbl As RadioButtonList = CType(lvi.FindControl("rbla_q"), RadioButtonList)
            If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
            Dim Query1 = From q In xEL.Descendants("Answer") _
                        Where q.Parent.Attribute("id").Value = CInt(hdn.value) _
                        Select New With { _
                            .txt = q.Element("txt").Value, _
                            .val = q.Element("val").Value}
            rbl.DataSource = Query1
            rbl.DataBind()

            ' Load answers, if closed form

            If iFID <> 0 Then
                Dim iAns As Integer = 0
                Try
                    iAns = cAnswers(hdn.Value)
                Catch ex As Exception
                End Try

                If iAns <> 0 Then
                    Dim li As ListItem
                    Dim sCtl As String = CType(lvi.FindControl("HDNCNTRL"), HiddenField).Value
                    Select Case sCtl
                        Case "ddl"
                            Dim ddl As DropDownList = CType(lvi.FindControl("ddl"), DropDownList)
                            li = ddl.Items.FindByValue(iAns)
                            If li IsNot Nothing Then
                                rbl.ClearSelection()
                                li.Selected = True
                            End If

                        Case Else
                            li = rbl.Items.FindByValue(iAns)
                            If li IsNot Nothing Then
                                rbl.ClearSelection()
                                li.Selected = True
                            End If

                    End Select
                End If
            End If

            'Load texts

            Dim sText As String = vbNullString
            Try
                sText = cTexts(hdn.Value)
            Catch ex As Exception
            End Try
            If sText <> vbNullString Then
                Dim tb As TextBox = CType(lvi.FindControl("TBDET_S"), TextBox)
                If tb IsNot Nothing Then
                    tb.Text = sText
                End If
            End If
 
        Next

    End Sub

    Protected Sub btncncl_Click(sender As Object, e As System.EventArgs)
        ClearForm()
    End Sub
    Sub ClearForm()
        tbSearch.Text = Nothing
        tbSearch.Enabled = True
        btnClear.Enabled = True
        btnSearch.Enabled = True
        LVEMP.DataBind()
        LVFORM.DataSource = Nothing
        LVFORM.DataBind()
        LVFORM.Visible = False
        lblstatus.Text = vbNullString
        lblid.Text = vbNullString

    End Sub

#End Region

#Region "sql"

    Protected Sub btnSend_Click(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim lv As ListView = CType(btn.NamingContainer, ListView)
        Dim sEmpID As String = tbSearch.Text
        Dim iErr As Integer = 0
        Dim iFormID As Integer = 0
        Dim sSqli As String = vbNullString
        Dim sSqlT As String = vbNullString
        Dim iQuestionID As Integer = 0

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("BEGIN TRANSACTION INSERT INTO EL_Forms(EmpID,LoadTime,UserID) Values(" & sEmpID & ",'" & Format(Now(), "yyyy-MM-dd HH:mm:ss") & "'," & Session("UserID") & ")", dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()

        ' Start transaction and get back formID

        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            Throw ex
            iErr = 1        ' Can not insert New Form
            GoTo Err
        End Try

        ' Get New FormID

        cD.CommandText = "SELECT Top 1 FormID FROM EL_Forms WHERE EmpID = " & sEmpID & " ORDER BY FormID DESC"
        Dim dR As SqlDataReader = cD.ExecuteReader
        If dR.Read Then
            iFormID = dR("FormID")
        Else
            iErr = 2        ' Can not Read New FormID
            GoTo Err
        End If

        ' Prepare Collections With Control Types

        Dim cCntrl As New Collection
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
        Dim Query = From q In xEL.Descendants("Question") _
        Select New With { _
            .id = q.Attribute("id").Value, _
            .cntrl = If(q.Attribute("control") Is Nothing, vbNullString, q.Attribute("control").Value)}
        For Each q In Query
            cCntrl.Add(q.cntrl, q.id)
        Next


        ' Loop Through Listview items and build insert command

        sSqli = "INSERT EL_FormAnswers(FormID,questionID,Val) EXEC('"
        sSqlT = "INSERT EL_FormTexts(FormID,questionID,TText) EXEC('"

        For i As Integer = 0 To lv.Items.Count - 1
            Dim lvi As ListViewItem = lv.Items(i)
            If lvi IsNot Nothing Then
                Dim hdn As HiddenField = CType(lvi.FindControl("hdnid"), HiddenField)
                If hdn IsNot Nothing Then
                    If IsNumeric(hdn.Value) Then
                        Dim cntl As String = cCntrl(hdn.Value)
                        iQuestionID = hdn.Value
                        Select Case cntl

                            Case "ddl"
                                Dim ddl As DropDownList = CType(lvi.FindControl("ddl"), DropDownList)
                                If ddl IsNot Nothing Then
                                    If ddl.SelectedValue <> vbNullString Then
                                        sSqli &= "SELECT " & iFormID & "," & iQuestionID & "," & ddl.SelectedValue & " "
                                    End If
                                End If

                            Case "textbox"
                                Dim tb As TextBox = CType(lvi.FindControl("TBDET_S"), TextBox)
                                If tb IsNot Nothing Then
                                    If tb.Text <> vbNullString Then
                                        sSqlT &= "SELECT " & iFormID & "," & iQuestionID & ",''" & tb.Text.Replace("'", "''''") & "'' "
                                    End If
                                End If

                            Case "label"

                            Case Else
                                Dim rbl As RadioButtonList = CType(lvi.FindControl("rbla_q"), RadioButtonList)
                                If rbl IsNot Nothing Then
                                    If rbl.SelectedValue <> vbNullString Then
                                        sSqli &= "SELECT " & iFormID & "," & iQuestionID & "," & rbl.SelectedValue & " "
                                    End If
                                Else
                                End If

                        End Select
                    End If
                End If
            End If
        Next
        dR.Close()

        If Right(sSqli, 2) <> "('" Then
            sSqli &= "')"
            cD.CommandText = sSqli
            Try
                cD.ExecuteNonQuery()
            Catch ex As Exception
                iErr = 3        ' Can not Write integer answers
                Throw ex
                GoTo Err
            End Try
        Else
            iErr = 1000
            GoTo err
        End If

        If Right(sSqlT, 2) <> "('" Then
            sSqlT &= "')"
            cD.CommandText = sSqlT
            Try
                cD.ExecuteNonQuery()
            Catch ex As Exception
                Throw ex
                iErr = 4        ' Can not Write Text answers
                GoTo Err
            End Try
        End If

        ' Close Manager Form

        cD.CommandText = "UPDATE EL_LeavingEmps SET Status = 1, CUserID = " & Session("UserID") & ", ClosingDate ='" & Format(Now(), "yyyy-MM-dd HH:mm:ss") & "' WHERE EmpID = " & sEmpID
        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            iErr = 5        ' Can not Close Manager Form
            GoTo Err
        End Try

        ' Close Transaction

        cD.CommandText = "COMMIT TRANSACTION"

        Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            iErr = 6        ' Can not Close Transaction
            GoTo Err
        End Try

        'Form Saved inform Customer
        dbConnection.Close()
        scrMsg("הטופס נשמר במערכת", False)
        ClearForm()
        Exit Sub
Err:
        cD.CommandText = "ROLLBACK TRANSACTION"
        cD.ExecuteNonQuery()
        dbConnection.Close()
        Dim sMsg As String
        If iErr < 1000 Then
            sMsg = "תקלה (מספר " & iErr & ") בשמירת הטופס.<br /> נא להודיע לצוות השירות. <br/>תודה וסליחה!"
        Else
            sMsg = "אין אף תשובה מסומנת. לא ניתן לשלוח את הטופס!"
        End If

        scrMsg(sMsg, True)

    End Sub

#End Region

#Region "scrMsg"

    Sub scrMsg(sMsg As String, Optional bErr As Boolean = True, Optional bTowButtons As Boolean = False, Optional sbtnMsgText As String = "אישור", Optional sbtnMsgOnClickText As String = vbNullString, Optional sbtnTwoText As String = "ביטול", Optional sbtnTwoOnClickText As String = vbNullString)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:50%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"
        btnmsg.Text = sbtnMsgText
        If sbtnMsgOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnMsgOnClickText)

        If bTowButtons Then
            btnTwo.Visible = True
            btnTwo.Text = sbtnTwoText
            If sbtnTwoOnClickText <> vbNullString Then btnmsg.Attributes.Add("onclick", sbtnTwoOnClickText)
            Dim i As Integer = If(sbtnMsgText.Length > sbtnTwoText.Length, sbtnMsgText.Length, sbtnTwoText.Length) * 10 + 20
            btnmsg.Width = i
            btnTwo.Width = i
        End If

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click, btnTwo.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
#End Region


    Protected Sub hdnUserName_PreRender(sender As Object, e As System.EventArgs)
        Dim hdn As HiddenField = CType(sender, HiddenField)
        Dim s As String = hdn.Value
        hdn = CType(FVIEW.FindControl("hdnCUserName"), HiddenField)
        If hdn.Value <> vbNullString Then
            s = "פניה סגורה. נפתחה ע""י " & s & ", נסגרה ע""י " & hdn.Value & "."
        Else
            s = "פניה פתוחה. נפתחה ע""י " & s & "."
        End If
        lblstatus.Text = s
        hdn = CType(FVIEW.FindControl("hdnid"), HiddenField)
        lblid.Text = hdn.Value
    End Sub

    Protected Sub LVFORM_PreRender(sender As Object, e As System.EventArgs) Handles LVFORM.PreRender
        Dim lv As ListView = CType(sender, ListView)
        If Mid(lblstatus.Text, 6, 5) = "סגורה" Then
            lv.Enabled = False
        End If
    End Sub
    Protected Sub btnFill_PreRender(sender As Object, e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        If tbSearch.Enabled = True Then
            btn.Text = "טופס"
        Else
            btn.Text = "חזרה"
        End If
    End Sub
End Class
