Imports System.Data.SqlClient
Imports WRCookies
Imports PageErrors
Partial Class p1aSalary
    Inherits System.Web.UI.Page
    Dim startTime As Date = Date.Now

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("Default2.Aspx")
        tddFrame.TableName = "(SELECT CategoryID,Name,Parent,itemOrder FROM (SELECT 1 As CategoryID,'שירות' as Name,0 as Parent,0 as itemOrder UNION ALL SELECT CategoryID,Name,parent,itemOrder " & _
        " FROM Categories_besqxl " & _
         " WHERE CategoryID IN " & _
  "	(SELECT CategoryID  " & _
       " FROM ttrHeirarchy " & _
  "	WHERE Parent IN (SELECT CategoryID FROM p0t_NtbRowB WHERE UserID=" & Session("UserID") & ")) " & _
        " UNION ALL " & _
  "	SELECT CategoryID,Name,1 as parent,itemOrder " & _
        " FROM Categories_besqxl " & _
         " WHERE CategoryID IN " & _
  "	(SELECT CategoryID  " & _
       " FROM p0t_NtbRowB WHERE UserID=" & Session("UserID") & ")) x )"
        Dim sNewSystem As String = ReadCookie_S("p1aSalaryAspx")
        If sNewSystem = vbNullString Then
            scrMsg("<div style='font-size:small;text-align:right;'>משתמשים יקרים,<br /><br />" & _
                   "התוכנית <b>עמידה בתקציב כח אדם</b> הוחלפה. <br /><br />" & _
                   "הפונקציונליות של התוכנית לא השתנתה.<br />" & _
                   "אנו מאמינים שהתוכנית החדשה תהיה טובה יותר מהקודמת.<br />" & _
                   "יחד עם זאת, זו תוכנית חדשה, ויתכן מאוד שתהיינה בעיות הנובעות מ'חבלי לידה'. <br/>" & _
                   "נשמח עם תספרו לנו על כל בעיה שאתם נתקלים בה.<br /><br />" & _
                   "תודה על שיתוף הפעולה, <br />" & _
                   "שגית, אריאל וכל צוות כספים.</div>", False)
        End If
    End Sub
    Dim TotalColvalue(0 To 16) As Decimal
    Function GetColValue(ByVal sF As String, ByVal i As Integer) As String
        Dim d As Double = If(IsDBNull(Eval(sF)), 0, Eval(sF))
        TotalColvalue(i) += d
        Return Format(d, "#,###")
    End Function
    Function bBold() As Boolean
        Return False
    End Function

    Function GetTotal(ByVal i As Integer) As String
        Return Format(TotalColvalue(i), "#,###")
    End Function

    Protected Sub tdd_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        WriteCookie_S("p1aSalarytddFrame_V", tddFrame.SelectedValue)
        WriteCookie_S("p1aSalarytddFrame_T", Server.UrlEncode(tddFrame.SelectedText))
    End Sub
    Protected Sub tdd_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
            tddFrame.SelectedValue = ReadCookie_S("p1aSalarytddFrame_V")
            tddFrame.SelectedText = Server.UrlDecode(ReadCookie_S("p1aSalarytddFrame_T", True))
    End Sub

    Protected Sub DDLPeriods_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles DDLPeriods.SelectedIndexChanged
        WriteCookie_S("p1aSalaryddlPeriods_V", DDLPeriods.SelectedValue)

    End Sub

    Protected Sub DDLPeriods_PreRender(sender As Object, e As System.EventArgs) Handles DDLPeriods.PreRender
        Dim s As String = vbNullString
        Dim li As ListItem
        Try
            s = ReadCookie_S("p1aSalaryddlPeriods_V")

        Catch ex As Exception

        End Try

        If s = vbNullString Then
            s = Format(DateAdd(DateInterval.Month, -1, Today), "MMM-yy")
            li = DDLPeriods.Items.FindByText(s)
        Else
            li = DDLPeriods.Items.FindByValue(s)
        End If
        If li IsNot Nothing Then
            DDLPeriods.ClearSelection()
            li.Selected = True
        End If

    End Sub

    Protected Sub TD_Load(sender As Object, e As System.EventArgs)
        Dim o As Control = CType(sender, Control)
        Dim s As String = "שעות"
        Dim s1 As String = Right(o.ID, 2)
        Select Case s
            Case "שעות"
                o.Visible = "_q" = LCase(s1)
            Case "סכומים"
                o.Visible = "_s" = LCase(s1)
            Case "שניהם"
                o.Visible = True
        End Select
    End Sub

    Protected Sub lbl_PreRender(sender As Object, e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim i As Integer = CInt(lbl.ID.Substring(4))
        lbl.Text = GetTotal(i)
    End Sub

    Protected Sub LVREP_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.ListViewItemEventArgs) Handles LVREP.ItemDataBound
        Dim lvi As ListViewItem = CType(e.Item, ListViewItem)
        Dim b As Boolean = True

        Dim lbl As Label = CType(lvi.FindControl("MQLabel"), Label)
        If lbl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        lbl = CType(lvi.FindControl("MQBLabel_Q"), Label)
        If lbl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        Dim hl As HyperLink = CType(lvi.FindControl("MQAHL_Q"), HyperLink)
        If hl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        lbl = CType(lvi.FindControl("MQDLabel_Q"), Label)
        If lbl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        lbl = CType(lvi.FindControl("AQBLabel_Q"), Label)
        If lbl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        hl = CType(lvi.FindControl("AQAHl_Q"), HyperLink)
        If hl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        lbl = CType(lvi.FindControl("AQDLabel_Q"), Label)
        If lbl IsNot Nothing Then b = lbl.Text.Replace("0", vbNullString) = vbNullString And b

        lvi.Visible = Not b
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
        WriteCookie_S("p1aSalaryAspx", "1")
    End Sub

End Class
