Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports PageErrors

Partial Class WEX_Reports
    Inherits System.Web.UI.Page
    Dim xEL As XElement
    Dim iXlF As Integer
    Dim bExcel As Boolean = False
    Dim sQstory As String = vbNullString
#Region "sql"
    Function BldQ() As String
        Dim sCtJoin As String = vbNullString
        Dim sCtField As String = vbNullString
        Dim sNuc As String = "SELECT * FROM vExEventLst "
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/WEX.xml"))
        'Dim Query = From q In xEL.Descendants("Question") _
        'Select New With { _
        '    .id = q.Attribute("id").Value, _
        '    .cdt = If(q.Attribute("Codetable") Is Nothing, vbNullString, q.Attribute("Codetable").Value), _
        '    .flid = If(q.Attribute("Codefield") Is Nothing, vbNullString, q.Attribute("Codefield").Value), _
        '    .flnd = If(q.Attribute("Field") Is Nothing, vbNullString, q.Attribute("Field").Value)}

        'For Each q In Query
        '    sNuc &= "[_" & q.id & "], "
        '    If q.cdt <> vbNullString Then
        '        sCtJoin &= " LEFT OUTER JOIN " & q.cdt & " AS t" & q.id & " ON x._" & q.id & " = t" & q.id & "." & q.flid
        '        sCtField &= ", t" & q.id & "." & q.flnd & " AS " & q.flnd & "_" & q.id
        '    End If
        'Next

        Dim s As String = sNuc & " WHERE [קוד] IN (SELECT FrameID From dbo.p0v_UserFrameList Where UserID=" & Session("UserID") & ")" '= "SELECT x.*" & sCtField & " FROM (" & Left(sNuc, Len(sNuc) - 2) & ")) AS ptv " & ") x " & sCtJoin & " WHERE x.FrameID IN (SELECT FrameID From dbo.p0v_UserFrameList Where UserID=" & Session("UserID") & ")"
        sQstory &= "<b><u>תכולת הדוח: כל הארועים על פי המגבלות הבאות:</u></b><br />נתונים מורשים של " & Session("UserName") & ".<br />"
        ' Build The report filter ---------------------------------------------

        ' Date Range Filter (skip if field
        If Not IsDate(tbFromdate.SelectedDate) Then tbFromdate.SelectedDate = CDate("2000-1-1")
        If Not IsDate(tbToDate.SelectedDate) Then tbToDate.SelectedDate = CDate("2099-12-31")
        If tbFromdate.SelectedDate = CDate("2000-1-1") And tbToDate.SelectedDate = CDate("2099-12-31") Then
        Else
            s &= " AND [תאריך הארוע] BETWEEN '" & Format(CDate(tbFromdate.SelectedDate), "yyyy-MM-dd") & " 00:00:00' AND '" & Format(CDate(tbToDate.SelectedDate), "yyyy-MM-dd") & " 23:59:59'"
            sQstory &= "<b>תאריך הארוע:</b> " & Format(CDate(tbFromdate.SelectedDate), "dd/MM/yy") & " עד " & Format(CDate(tbToDate.SelectedDate), "dd/MM/yyyy") & "<br />"
        End If

        ' ServiceTypeFilter

        If ddlServiceTypes.SelectedValue <> vbNullString Then
            s &= " AND ServiceTypeHID = " & ddlServiceTypes.SelectedValue
            sQstory &= "<b>סוג שירות</b>: " & ddlServiceTypes.SelectedItem.Text & "<br />"
        End If


        ' LakutFilter

        If ddlLakuyot.SelectedValue <> vbNullString Then
            s &= " AND LakutID = " & ddlLakuyot.SelectedValue
            sQstory &= "<b>לקות</b>: " & ddlLakuyot.SelectedItem.Text & "<br />"
        End If


        ' ServiceFilter

        If ddlServices.SelectedValue <> vbNullString Then
            s &= " AND ServiceID = " & ddlServices.SelectedValue
            sQstory &= "<b>אזור</b>: " & ddlServices.SelectedItem.Text & "<br />"
        End If


        ' FrameFilter

        If IsNumeric(ddlFrames.SelectedValue) Then
            s &= " AND [קוד] = " & ddlFrames.SelectedValue
            sQstory &= "<b>מסגרת:</b> " & ddlFrames.SelectedItem.Text & "<br />"
        End If

        ' Status Filter

        If ddlStatus.SelectedValue <> 0 Then
            s &= " AND ISNULL(ExEventStatusID,0) = " & ddlStatus.SelectedValue
            sQstory &= "<b>סטטוס:</b> " & ddlStatus.SelectedItem.Text & "<br/>"
        End If

        ' EXET1 Filter

        If ddlET1.SelectedValue <> vbNullString Then
            s &= " AND parent = " & ddlET1.SelectedValue
            sQstory &= "<b>סוג ראשי:</b> " & ddlET1.SelectedItem.Text & "<br/>"
        End If

        ' EXET2 Filter

        If ddlET2.SelectedValue <> vbNullString Then
            s &= " AND [קוד סוג] = " & ddlET2.SelectedValue
            sQstory &= "<b>סוג משני:</b> " & ddlET2.SelectedItem.Text & "<br/>"
        End If

        'Specific Report filter (Selected value of ddlcolumns is build lik 1,2,3,4,5|xxx is not null, where 1,2,3... are the field id from el.xml (Report section), and the text after the | is specific fdiltrer for theis report

        Dim sRepFilster As String = ddlColumns.SelectedValue
        If Right(sRepFilster, 1) <> "|" Then
            sRepFilster = Mid(sRepFilster, InStr(sRepFilster, "|") + 1)
            s &= " AND " & sRepFilster
        End If
        Return s

    End Function
#End Region

#Region "Report"
    Sub BuildReport()
        'lblfltr.Text = sQstory
        'lblfltr.Visible = True
        GridView1.Columns.Clear()
        Dim s As String = ddlColumns.SelectedValue
        s = "," & Left(s, InStr(s, "|") - 1) & ","
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/WEX.xml"))
        Dim Query = From q In xEL.Descendants("Column") _
        Select New With { _
            .nam = q.Attribute("Name").Value, _
            .hdr = q.Attribute("Header").Value, _
            .fmt = If(q.Attribute("Format") Is Nothing, vbNullString, q.Attribute("Format").Value), _
            .wrp = If(q.Attribute("Wrap") Is Nothing, vbNullString, q.Attribute("Wrap").Value), _
            .lnk = If(q.Attribute("Link") Is Nothing, vbNullString, q.Attribute("Link").Value), _
            .n = q.Attribute("n").Value}

        For Each q In Query
            If InStr(s, "," & q.n & ",") > 0 Or s = ",*," Then
                If q.lnk = vbNullString Then
                    Dim bf As New BoundField
                    bf.DataField = q.nam
                    bf.DataFormatString = q.fmt
                    bf.HeaderText = q.hdr
                    bf.ControlStyle.BorderStyle = BorderStyle.Solid
                    bf.ControlStyle.BorderColor = Drawing.Color.Black
                    bf.ControlStyle.BorderWidth = 1

                    GridView1.Columns.Add(bf)
                Else
                    Dim hl As New HyperLinkField
                    hl.DataTextField = q.nam
                    hl.DataTextFormatString = q.fmt
                    hl.HeaderText = q.hdr
                    hl.DataNavigateUrlFields = Split(q.lnk, "|")
                    hl.DataNavigateUrlFormatString = "{0}"
                    GridView1.Columns.Add(hl)
                End If
            End If
        Next
    End Sub
    Protected Sub GridView1_PreRender(sender As Object, e As System.EventArgs) Handles GridView1.PreRender
        For Each gvr As GridViewRow In GridView1.Rows
            For i As Integer = 0 To gvr.Cells.Count - 1
                gvr.Cells(i).BorderColor = Drawing.Color.Silver
            Next
        Next
    End Sub
#End Region

#Region "Excel"
    Sub doExcel(sF As String, gv As GridView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        lblhdr.Text = "<span style=""font-size:Large;"">רשימת ארועים חריגים</span><br />" & ViewState("lblhdr")
        'Dim lbl As Label = CType(dlist.Items(0).FindControl("LBLREPH"), Label)
        'lbl.Text = "<span style=""font-size:Large;"">" & lbl.Text & "</span><br />"
        'frm.Controls.Add(lbl)
        'lblhdr.Text = ViewState("lblhdr")
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
        'gv.DataBind()
    End Sub

#End Region

#Region "ReportFilters"
    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click

        'Build Query

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Response.Write(BldQ())
        'Response.End()
        Dim cD As New SqlCommand("SearchQ", dbConnection)
        cD.CommandType = CommandType.StoredProcedure
        cD.Parameters.AddWithValue("@sql", BldQ())
        cD.Parameters.AddWithValue("@BFLD", "[שם פרטי] + ' ' + [שם משפחה] + ' ' + Cast([תז] as varchar(10))")
        cD.Parameters.AddWithValue("@RowID", "[מספר]")
        cD.Parameters.AddWithValue("@Srch", tbSearch.Text)

        sQstory &= If(tbSearch.Text = vbNullString, vbNullString, "<b>שם הלקוח או ת. זהות שלו מכילים: </b>" & tbSearch.Text)
        ViewState("lblhdr") = sQstory

        cD.CommandTimeout = 300

        dbConnection.Open()

        Dim da As New SqlDataAdapter(cD)
        Dim dt As New DataTable()


        'Build Report

        BuildReport()

        'Fill Report

        Try
            da.Fill(dt)
            GridView1.DataSource = dt
            GridView1.DataBind()
        Catch ex As Exception
            If Left(ex.Message, Len("Could not allocate")) = "Could not allocate" Then
                scrMsg("כמות הנתונים גדולה מידי.<br />יש לצמצם את אוכלוסיית הדוח.", True)
            Else
                WriteErrorLog()
            End If
        End Try
        dbConnection.Close()

    End Sub
    Protected Sub ddlColumns_PreRender(sender As Object, e As System.EventArgs) Handles ddlColumns.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/WEX.xml"))
            Dim Query = From q In xEL.Descendants("RepColumns") _
            Select New With { _
                .nam = q.Attribute("Name").Value, _
                .val = q.Value, _
                .fltr = If(q.Attribute("filter") Is Nothing, vbNullString, q.Attribute("filter").Value)}

            For Each l In Query
                Dim li As New ListItem(l.nam, l.val & "|" & l.fltr)
                ddl.Items.Add(li)
            Next
        End If

    End Sub

    Protected Sub ddlServices_DataBound(sender As Object, e As System.EventArgs) Handles ddlServices.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.Count = 2 Then
            ddl.Items.RemoveAt(0)
            ddlFrames.Items.Clear()
        End If

    End Sub

    Protected Sub ddlFrames_DataBound(sender As Object, e As System.EventArgs) Handles ddlFrames.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If Session("MultiFrame") = 1 Then
            Dim li As New ListItem("כל המסגרות", vbNullString, True)
            ddl.Items.Insert(0, li)
            ddl.Items(0).Value = vbNullString
        End If
        RemoveDDLDupItems(ddl)
    End Sub

    Protected Sub rbExReport_CheckedChanged(sender As Object, e As System.EventArgs) Handles rbExReport.CheckedChanged, rbWexReports.CheckedChanged
        Dim rb As RadioButton = CType(sender, RadioButton)
        If rb.Checked Then Response.Redirect(Mid(rb.ID, 3) & ".aspx")
    End Sub

    Protected Sub tbSearch_PreRender(sender As Object, e As System.EventArgs) Handles tbSearch.PreRender
        Dim tb As TextBox = CType(sender, TextBox)
    End Sub
#End Region

#Region "Load&General"

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            tbFromdate.InitDate = New DateTime(DatePart(DateInterval.Year, Today), 1, 1)
            tbToDate.InitDate = Today
        End If
    End Sub
#End Region

    Protected Sub btnExcel_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        doExcel("Rep.xls", GridView1)
    End Sub
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
    Sub scrMsg(sMsg As String, bErr As Boolean)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub
End Class
