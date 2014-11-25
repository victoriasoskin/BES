Imports System.Data.SqlClient
Imports System.Linq
Imports System.Xml.Linq
Imports System.Data
'Imports Microsoft.Office.Interop.Excel
Imports System.Globalization
Imports System.IO
Imports WebMsgApp
Imports System.Web.UI.DataVisualization.Charting
Imports System.Drawing
Imports System.Math
Imports Printing

Partial Class Reports
    Inherits System.Web.UI.Page
    Dim tt(0 To 12) As Double
    Dim ttr As Double = 0
    Dim ttrt As Double = 0
    Dim xE As XElement
    Dim cookies As System.Net.CookieContainer
    Dim bShow As Boolean = False
    Dim cCols As New Collection
    Dim cCalc As New Collection
    Dim cFunc As New Collection
    Dim cCalcType As New Collection
    Dim cTopText As New Collection
    Dim cInText As New Collection
    Dim c_Ptots As New Collection
    Dim c_tots As New Collection
    Dim ptots() As Double
    Dim ctots() As Double
    Dim cFormulas As New Collection
    Dim sTottxt As String
    Dim iSpecial As Integer = 0

    Function vbold() As Boolean
        Dim i As Integer = Eval("lvl")
        Return i = 0 Or i = 2
    End Function
    Function vfore() As System.Drawing.Color
        Dim i As Integer = Eval("lvl")
        If i = 0 Or i = 2 Then
            Return System.Drawing.Color.Blue
        Else
            Return System.Drawing.Color.Black
        End If
    End Function
    Function vfn(ByVal i As Integer) As String
        Dim fd As DateTime = CType(LBLFDATE.Text, DateTime)
        Dim dt As Date = DateAdd(DateInterval.Month, i - 1, fd)
        Dim s As String = Format(dt, "yyyy-M")
        On Error Resume Next
        Dim d As Double
        Dim j As Integer = Eval("lvl")
        If j <> 0 Then
            d = Eval(s)
            ttr += d
        Else
            Return vbNullString
        End If
        If j = 1 Then
            tt(i - 1) += d
            ttrt += d
        End If
        Return Format(d, "#,###;(#,###)")
    End Function
    Function vhd(ByVal i As Integer) As String
        Dim fd As DateTime = CType(LBLFDATE.Text, DateTime)
        Dim dt As Date = DateAdd(DateInterval.Month, i - 1, fd)
        Return Format(dt, "yyyy-M")
    End Function
    Function vtr() As String
        Dim s As String = Format(ttr, "#,###;(#,###)")
        tt(12) += ttrt
        ttr = 0
        ttrt = 0
        Return s
    End Function
    Function vtc(ByVal i As Integer) As String
        Dim s As String = Format(tt(i - 1), "#,###;(#,###)")
        Return s
    End Function

    Protected Sub DDLVERSION_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLVERSION1.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        WriteCoockie(ddl)
        If DDLDATES.Visible = True Then
            DDLDATES.Items.Clear()
            Dim li As New ListItem("[בחר תאריך]", "")
            DDLDATES.Items.Add(li)

            DDLDATES.DataSourceID = "DSDATES"
            DDLDATES.DataTextField = "DL"
            DDLDATES.DataValueField = "DL"
            DDLDATES.DataBind()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write("<div dir='rtl'><br /><br /> <p style='direction:rtl;font-size:Large;font-weight:bold;color:Red;'>תקלה זמנית בדוח. התקלה תתוקן בשעות הקרובות.</p><input type='button' onclick='history.back();' value='חזרה'/></div>")
        'Response.End()
        'Exit Sub
        Response.Redirect("Default2.Aspx")

        '      If IsNumeric(Session("FrameID")) And Not IsNumeric(Session("FFrameID")) Then
        If Session("UserID") Is Nothing Then Response.Redirect("Entry.aspx")
        Dim connStr As String = "Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim cD As New SqlCommand("SELECT CategoryID,Name, Count(*) Over() As Cnt FROM (SELECT CategoryID,Name " & _
        " FROM Categories_besqxl " & _
         " WHERE CategoryID IN " & _
  "	(SELECT CategoryID  " & _
       " FROM ttrHeirarchy " & _
  "	WHERE Parent IN (SELECT CategoryID FROM p0t_NtbRowB WHERE UserID=" & Session("UserID") & ") " & _
       " UNION ALL " & _
  "	SELECT CategoryID FROM p0t_NtbRowB WHERE UserID=" & Session("UserID") & ")) x ", dbConnection)
        cD.CommandType = CommandType.Text
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            If dr("Cnt") < 2 Then
                tdd.SelectedText = dr("Name")
                tdd.SelectedValue = dr("CategoryID")
                Session("FFrameID") = dr("CategoryID")
            End If
        End If
        dr.Close()
        dbConnection.Close()

        '      End If
        tdd.TableName = "(SELECT CategoryID,Name,Parent,itemOrder FROM (SELECT 1 As CategoryID,'שירות' as Name,0 as Parent,0 as itemOrder UNION ALL SELECT CategoryID,Name,parent,itemOrder " & _
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

        Dim li As ListItem
        ' Load RepList
        Dim s As String = MapPath("App_Data/Reports.xml")
        If DDLREPTYPE.Items.Count = 0 Then
            If xE Is Nothing Then xE = XElement.Load(MapPath("App_Data/Reports.xml"))
            'li = New ListItem("[בחירת דוח]", vbNullString)
            'DDLREPTYPE.Items.Add(li)
            Dim q = From l In xE.Descendants("Page") _
                    Where l.Parent.Attribute("ID").Value = Request.QueryString("r") _
                    Select New With { _
                        .nam = l.Attribute("Name").Value, _
                        .Val = l.Attribute("PID").Value}
            For Each l In q
                li = New ListItem(l.nam, l.Val)
                DDLREPTYPE.Items.Add(li)
            Next
        End If
        ReadCookie(DDLREPTYPE)
        If tdd.SelectedValue = vbNullString Then
            If Session("tddframe_v") <> vbNullString Then
                tdd.SelectedValue = Session("tddframe_v")
                tdd.SelectedText = Session("tddframe_t")
            End If
        End If

        If DDLDATES.Visible = True Then
            DDLDATES.DataSourceID = "DSDATES"
            DDLDATES.DataTextField = "DL"
            DDLDATES.DataValueField = "DL"
            DDLDATES.DataBind()
        End If
        If Request.QueryString("h") <> vbNullString And Not bShow Then
            btnshow.Text = "בטל הסתרת עמודות"
        End If
        'Try
        '    Dim sWrap As String = tdd.SelectedText
        '    lblWrap.Width = sWrap.Length * 6 + 50
        'Catch ex As Exception

        'End Try

    End Sub
    Dim cNumberFormats As New Collection
    Dim cNumberStyles As New Collection
    Dim cRowTypes As New Collection
    Dim cFtexts As New Collection
    Dim cRtexts As New Collection
    Protected Sub btn_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click, btnexcel.Click
        If DDLVERSION1.SelectedValue = vbNullString Then
            WebMsgApp.WebMsgBox.Show("יש לבחור בגרסה")
            Exit Sub
        End If
        If tdd.Visible Then
            If tdd.SelectedValue = vbNullString Then
                WebMsgApp.WebMsgBox.Show("יש לבחור במסגרת")
                Exit Sub
            End If
        End If
        If DDLREPTYPE.SelectedValue = vbNullString Then
            WebMsgApp.WebMsgBox.Show("יש לבחור בדוח")
            Exit Sub
        End If
        Dim btn As System.Web.UI.WebControls.Button = CType(sender, System.Web.UI.WebControls.Button)
        gvComments.Visible = True
        gvComments.DataBind()
        If btn.Text = "בטל הסתרת עמודות" Then
            For i As Integer = 0 To gv.Columns.Count - 1
                Try
                    gv.Columns(i).Visible = True
                Catch ex As Exception
                End Try
            Next
            bShow = True
            btn.Text = "הצג"
        End If
        Session("tddframe_v") = tdd.SelectedValue
        Session("tddframe_t") = tdd.SelectedText
        ShowSadin(btn.Text = "XL")
        Try

            Dim q3 = From l In xE.Descendants("Chart") _
              Where l.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue _
              Select New With { _
                  .typ = l.Attribute("Type").Value, _
                  .wdt = l.Attribute("Width").Value, _
                  .fc = l.Attribute("FirstColumn").Value, _
                  .lc = l.Attribute("LastColumn").Value}
            If q3.Count > 0 Then
                For Each l In q3
                    ShowChart(l.typ, vbNullString, l.wdt, l.fc, l.lc)
                Next
            Else
                ChrtG.Visible = False
            End If
        Catch ex As Exception

        End Try
    End Sub
    Sub ShowSadin(b As Boolean)
        Dim s As String
        Dim j As Integer
        If DDLDATES.Visible = True Then If DDLDATES.SelectedIndex = 0 Then Exit Sub
        If DDLVERSION1.SelectedIndex = 0 Then Exit Sub
        If DDLVERSION2.Visible = True Then If DDLVERSION2.SelectedIndex = 0 Then Exit Sub
        If DDLVERSION3.Visible = True Then If DDLVERSION3.SelectedIndex = 0 Then Exit Sub
        If DDLVERSION4.Visible = True Then If DDLVERSION4.SelectedIndex = 0 Then Exit Sub
        If DDLREPTYPE.SelectedValue = vbNullString Then Exit Sub
        Dim sFormat As String
        Dim sStyle As String
        Dim sRowHdr As String
        Dim sSeperator As String
        Dim sWidth As String = vbNullString
        Dim sComment As String = vbNullString
        Dim sRepName As String

        ' write a coockie to remember params


        If DDLVERSION1.Visible = True Then WriteCoockie(DDLVERSION1)
        If DDLVERSION2.Visible = True Then WriteCoockie(DDLVERSION2)
        If DDLVERSION3.Visible = True Then WriteCoockie(DDLVERSION3)
        If DDLVERSION4.Visible = True Then WriteCoockie(DDLVERSION4)
        If DDLDATES.Visible = True Then WriteCoockie(DDLDATES)

        If xE Is Nothing Then xE = XElement.Load(MapPath("App_Data/Reports.xml"))
        Dim q1 = From l In xE.Descendants("Txt") _
        Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue And l.Parent.Name = "Query" _
        Select New With {.val = l.Value, .nam = l.Parent.Parent.Attribute("Name").Value}
        Dim sQuery As String

        For Each l In q1
            sQuery = l.val
            sRepName = l.nam
        Next

        lblhdr.Text = sRepName
        ViewState("RepName") = sRepName
        ' Read Query Params From xml

        Dim q2 = From l In xE.Descendants("Param") _
            Where l.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") _
        Select New With {.Nam = l.Attribute("Name").Value, .Val = l.Value}

        For Each l In q2
            s = l.Nam
            Dim sv As String = l.Val
            Select Case s
                Case "@VersionCategoryID1"
                    sQuery = sQuery.Replace(s, CStr(DDLVERSION1.SelectedValue))
                Case "@VersionCategoryID2"
                    sQuery = sQuery.Replace(s, CStr(DDLVERSION2.SelectedValue))
                Case "@VersionCategoryID3"
                    sQuery = sQuery.Replace(s, CStr(DDLVERSION3.SelectedValue))
                Case "@VersionCategoryID4"
                    sQuery = sQuery.Replace(s, CStr(DDLVERSION4.SelectedValue))
                Case "@DateB"
                    sQuery = sQuery.Replace(s, "'" & Format(CDate(DDLDATES.SelectedValue), "yyyy-MM-dd") & "'")
                Case "@FrameID"
                    sQuery = sQuery.Replace(s, tdd.SelectedValue)
                Case Else
                    sQuery = sQuery.Replace(s, sv)
            End Select

        Next

        ' Create Temporary View

        Dim rc As New Random()
        Dim r As Integer = rc.Next


        Dim sTVName = "vfx_" & r


        Dim connStr As String = "Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim Cd As New SqlCommand("Drop View " & sTVName, dbConnection)

        Try
            Cd.ExecuteNonQuery()
        Catch ex As Exception
        End Try

        Cd.CommandText = "Create View " & sTVName & " As " & sQuery
        Try
            Cd.ExecuteNonQuery()
        Catch ex As Exception
            '    Throw ex
            '  Response.Write(289 & Cd.CommandText)
            dbConnection.Close()
            '      Throw ex
            gvComments.Visible = False
            WebMsgBox.Show("אין נתונים להצגה")
            Exit Sub
        End Try

        ' Prepare Procedure Call

        Cd.CommandText = "PivotT"
        Cd.CommandTimeout = 300
        Cd.CommandType = Data.CommandType.StoredProcedure
        Cd.Parameters.Clear()

        ' Build Param List

        Dim q3 = From l In xE.Descendants("PivotParams") _
           Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue And l.Parent.Name = "Pivot" _
           Select New With { _
              .RowFields = l.Attribute("RowFields").Value, _
             .RowOrderFields = l.Attribute("RowOrderFields").Value, _
             .ColumnField1 = l.Attribute("ColumnField1").Value, _
             .ColumnOrderFields = l.Attribute("ColumnOrderFields").Value, _
              .DataFields = l.Attribute("DataFields").Value, _
             .Tottxt = l.Attribute("Tottxt").Value, _
             .ColType = l.Attribute("ColType").Value,
              .hdn = If(l.Attribute("HiddenRowField") Is Nothing, vbNullString, l.Attribute("HiddenRowField").Value)}

        Dim tabnam As New SqlParameter("@Tabnam", Data.SqlDbType.NVarChar, 50)
        tabnam.Direction = Data.ParameterDirection.Output
        Cd.Parameters.Add(tabnam)

        Cd.Parameters.AddWithValue("@Table", sTVName)
        Dim sRowFields As String
        For Each ll In q3
            sRowFields = ll.RowFields
            sTottxt = ll.Tottxt
            Cd.Parameters.AddWithValue("@RowFields", sRowFields)
            If ll.hdn <> vbNullString Then Cd.Parameters.AddWithValue("@HiddenRowField", ll.hdn) Else Cd.Parameters.AddWithValue("@HiddenRowField", DBNull.Value)
            Cd.Parameters.AddWithValue("@RowOrderFields", ll.RowOrderFields)
            Cd.Parameters.AddWithValue("@ColumnField1", ll.ColumnField1)
            Cd.Parameters.AddWithValue("@ColumnField2", DBNull.Value)
            Cd.Parameters.AddWithValue("@ColumnOrderFields", ll.ColumnOrderFields)
            Cd.Parameters.AddWithValue("@DataFields", ll.DataFields)
            Cd.Parameters.AddWithValue("@Tottxt", sTottxt)
            Cd.Parameters.AddWithValue("@ColType", ll.ColType)
        Next
        Dim s1() As String = sRowFields.Split("|")
        Dim iRowFieldCount = s1.Length

        ' Call Procedure

        For i = 0 To Cd.Parameters.Count - 1
            Dim sp As String = Cd.Parameters(i).ToString
            Dim sv As String = If(IsDBNull(Cd.Parameters(i).Value), vbNullString, Cd.Parameters(i).Value)
        Next

        Dim iAllowtry As Integer = 0

TryAgain:

        Try
            iAllowtry += 1
            Cd.ExecuteNonQuery()
        Catch ex As Exception
            If iAllowtry < 3 Then
                GoTo TryAgain
            Else
                dbConnection.Close()
                Throw ex
            End If
        End Try

        ' Get Temporary table Name

        Dim sTabNam As String = Convert.ToString(tabnam.Value)

        ' Drop Temporary View

        Cd.CommandText = "Drop View " & sTVName

        Try
            Cd.ExecuteNonQuery()
        Catch ex As Exception

        End Try

        '  Find output table Column Names And Build query and populate Gridview

        ' table Column structure: (iP variable help follow where  we are

        ' (0) Sort Columns, until ColHdDr1
        ' (1) ColHdr1
        ' (2) Original Row Fields
        ' (3) Value Columns

        Dim sSql As String = "Select "
        Dim sqlOrderby As String = " Order by "
        Cd.CommandText = "select column_name, data_type, character_maximum_length from information_schema.columns where table_name = '" & sTabNam & "' order by Ordinal_Position"
        Cd.CommandType = Data.CommandType.Text
        Dim dr As SqlDataReader = Cd.ExecuteReader()

        ' Get Links From XML

        q3 = Nothing

        ' Get Formating from xml

        Dim q5 = From l In xE.Descendants("Formats").Elements _
Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue _
Select New With { _
.Nam = l.Name, _
.Val = l.Value, _
.Ftext = If(l.Attribute("Ftext") IsNot Nothing, l.Attribute("Ftext").Value, vbNullString), _
.RowT = If(l.Attribute("RowType") IsNot Nothing, l.Attribute("RowType").Value, vbNullString), _
.Rtext = If(l.Attribute("Rtext") IsNot Nothing, l.Attribute("Rtext").Value, vbNullString), _
.Style = If(l.Attribute("style") IsNot Nothing, l.Attribute("style").Value, vbNullString)}

        For Each ll In q5
            Select Case ll.Nam
                Case "RowHdr"
                    sRowHdr = ll.Val
                Case "NumberFormat"
                    If ll.Ftext = vbNullString And ll.Rtext = vbNullString Then
                        sFormat = ll.Val
                        sStyle = ll.Style
                    Else
                        cNumberFormats.Add(ll.Val)
                        cNumberStyles.Add(ll.Style)
                        cFtexts.Add(ll.Ftext)
                        cRtexts.Add(ll.Rtext)
                        cRowTypes.Add(ll.RowT)
                    End If
                Case "Seperator"
                    sSeperator = ll.Val
                Case "Width"
                    sWidth = ll.Val
                Case "Comments"
                    sComment = ll.Val
                    lblComment.Text = sComment
            End Select
        Next

        Dim iP As Integer = 0 ' iP = 0 - Before Colhdr1, iP = 1 
        Dim sF As String
        gv.Columns.Clear()
        j = iRowFieldCount
        While dr.Read
            sF = dr("Column_name")
            Select Case iP
                Case 0  ' All Sort Fields
                    If LCase(sF) <> "rowhdr" Then
                        sqlOrderby += "[" + sF + "],"
                    Else
                        sSql += "[" + sF + "],"
                        iP = 1
                    End If
                Case 1 ' RowFields - skip
                    j = j - 1
                    If j = 0 Then iP = 2
                Case 2 ' Value Fields
                    sSql += "[" + sF + "],"
            End Select
        End While

        dr.Close()

        sSql = Left(sSql, sSql.Length - 1) + " From " + sTabNam + " WHERE LEN(RowHdr)>0 AND RowHdr!='" + sTottxt + "' " + Left(sqlOrderby, sqlOrderby.Length - 1)

        Cd.CommandText = sSql

        Dim da As New SqlDataAdapter(Cd)
        Dim dt As New System.Data.DataTable()
        Try
            da.Fill(dt)

        Catch ex As Exception
            ' Response.Write(460 & Cd.CommandText)
            dbConnection.Close()
            gv.DataBind()
            gvComments.Visible = False
            WebMsgBox.Show("אין נתונים להצגה")
            Exit Sub
        End Try

        gv.DataSource = dt
        dbConnection.Close()
        If dt.Rows.Count <= 0 Then
            ' Response.Write(471 & Cd.CommandText)
            dt = Nothing
            gv.DataBind()
            gvComments.Visible = False
            WebMsgBox.Show("אין נתונים להצגה")
            Exit Sub
        End If

        gv.Columns.Clear()
        For i = 0 To dt.Columns.Count - 1
            Dim bf As BoundField
            bf = New BoundField
            bf.DataField = dt.Columns(i).ColumnName
            If i = 0 Then
                bf.HeaderText = sRowHdr & If(CBDVLP.Checked, " {--" & i & "--}", vbNullString)
            Else
                bf.HeaderText = If(IsDate(dt.Columns(i).ColumnName), Format(CDate(dt.Columns(i).ColumnName), "MMMM"), dt.Columns(i).ColumnName) & If(CBDVLP.Checked, " {--" & i & "--}", vbNullString)
            End If
            bf.ItemStyle.Wrap = False
            If i = 0 Then
                bf.ItemStyle.BackColor = System.Drawing.Color.LightBlue
            Else
                '      bf.DataFormatString = "{0:#,##0.00;-#,000.000}"
                bf.ItemStyle.Wrap = False
                bf.HeaderStyle.Wrap = True
                bf.ItemStyle.Width = 100
            End If
            gv.Columns.Add(bf)
        Next


        ' Post Operations

        ' AdditionalColumns

        Dim q4 = From l In xE.Descendants("AdditionalColumns").Elements _
            Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue _
            Select New With { _
               .Colhdr = l.Attribute("Name").Value, _
              .SumText = l.Attribute("Sumtext").Value}

        Dim iOrgColCount = gv.Columns.Count

        Dim cAddCols As New Collection
        For Each ll In q4
            Dim bf As New BoundField
            bf.HeaderText = ll.Colhdr

            bf.ItemStyle.Wrap = False
            bf.HeaderStyle.Wrap = True
            gv.Columns.Add(bf)

            Dim i As Integer = gv.Columns.Count - 1
            cAddCols.Add(ll.SumText & "|" & ll.Colhdr & "|" & i)
            bf.HeaderText = ll.Colhdr & If(CBDVLP.Checked, " {--" & i & "--}", vbNullString)

        Next

        Dim q6 = From l In xE.Descendants("Links").Elements _
             Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue And l.Parent.Name = "Links"
           Select l.Attribute("Type").Value

        If q6.Count > 0 Then
            Dim btf As New ButtonField
            btf.Text = "   "
            btf.HeaderText = "קישור"
            btf.Text = "תבנית"
            btf.ButtonType = ButtonType.Link
            btf.CommandName = "select"
            gv.Columns.Add(btf)
        End If

        Dim tots() As Double

        gv.DataBind()
        BuildColFOrmulasCollections()

        If b Then '--------------------------------------------------------------------------------------------------- b = true = excel

            BiuldExcelRowFormulas(gv.Columns.Count)

            For iR As Integer = 0 To gv.Rows.Count - 1

                Dim gvr As GridViewRow = gv.Rows(iR)

                ' Fill Additional Columns

                For Each c As String In cAddCols
                    Dim sV() As String = c.Split("|")
                    Dim sFormula As String = "=SUM("
                    For j = 1 To iOrgColCount - 1
                        s = If(InStr(gv.Columns(j).HeaderText, sV(0)) = 0, "", "RC" & j & ",")
                        sFormula += s
                    Next
                    gvr.Cells(CInt(sV(2))).Text = Left(sFormula, sFormula.Length - 1) & ")"
                Next

                ' Insert row formulas
                If IsNumeric(gvr.Cells(1).Text) Then
                    For i = 1 To cFormulas.Count
                        Dim sFoc() As String = cFormulas(i).Split("|")
                        gvr.Cells(CInt(sFoc(1))).Text = sFoc(0)
                    Next
                End If

                ' Build Subtotals and Colunmn Functions

                Dim sH As String = gvr.Cells(0).Text
                If (Not IsNumeric(gvr.Cells(1).Text) And Trim(sH).Length > 0) Or (InStr(sH, sTottxt) > 0) Then

                    For i As Integer = 1 To gvr.Cells.Count

                        ' Find and collect Group Headers

                        If InStr(sH, sTottxt.Replace("""", "&quot;")) = 0 Then

                            c_tots.Add(sH & "|" & i & "|" & c_tots.Count & "|" & iR, sH & "|" & i)

                        Else

                            sH = sH.Replace(sTottxt.Replace("""", "&quot;"), vbNullString)
                            Dim sFunc As String
                            Try
                                sFunc = cFunc(CStr(i))
                            Catch ex As Exception
                                sFunc = "SUM"
                            End Try
                            Try
                                Dim vs() As String = c_tots(sH & "|" & cCols(i)).ToString.Split("|")
                                c_tots.Remove(sH & "|" & i)
                                Select Case sFunc
                                    Case "AVG"
                                        gvr.Cells(i).Text = "=SUBTOTAL(101,R[" & CStr(CInt(vs(3)) - iR) & "]C:R[-1]C)"
                                    Case "SUM"
                                        gvr.Cells(i).Text = "=SUBTOTAL(109,R[" & CStr(CInt(vs(3)) - iR) & "]C:R[-1]C)"
                                End Select
                            Catch ex As Exception
                            End Try

                        End If
                    Next
                End If

            Next
            lbldate.Visible = True

            lbldate.Text = "הופק ב: " & Format(Now(), "dd/MM/yyyy hh:mm")
            s = "<table>"
            If DDLVERSION1.Visible = True Then s &= "<tr><td>" & DDLVERSION1.SelectedItem.Text & "</td>"
            If DDLVERSION2.Visible = True Then s &= "<td>" & DDLVERSION2.SelectedItem.Text & "</td></tr>"
            If DDLVERSION3.Visible = True Then s &= "<tr><td>" & DDLVERSION3.SelectedItem.Text & "</td>"
            If DDLVERSION4.Visible = True Then s &= "<td>" & DDLVERSION4.SelectedItem.Text & "</td></tr>"
            If DDLDATES.Visible = True Then s &= "<td>" & DDLDATES.SelectedItem.Text & "</td></tr>"
            lblsubhdr.Text = s + "</table>"
            lbldate.Visible = True
            doExcel("sadin.xls", lblhdr, lblsubhdr, lbldate, gv)

        Else  '------------------------------------------------------------------------------------------------------ b = false = screen
            Dim rn As Integer = gv.Rows.Count - 1

            Dim q8 = From l In xE.Descendants("Rows").Elements _
                Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue _
                    Select New With { _
                        .Txt = If(l.Attribute("Text") IsNot Nothing, l.Attribute("Text").Value, vbNullString), _
                       .Stl = If(l.Attribute("Style") IsNot Nothing, l.Attribute("Style").Value, vbNullString), _
                       .Vis = If(l.Attribute("Visible") IsNot Nothing, l.Attribute("Visible").Value, "True"), _
                       .Ntx = If(l.Attribute("NewText") IsNot Nothing, l.Attribute("NewText").Value, vbNullString), _
                      .Clr = If(l.Attribute("Clear") IsNot Nothing, l.Attribute("Clear").Value, "False")}

            Dim cRowsTexts As New Collection
            Dim cRowsVisible As New Collection
            Dim cRowsClear As New Collection
            Dim cRowsStyle As New Collection
            Dim cRowsNewText As New Collection
            For Each l In q8
                If l.Txt <> vbNullString Then
                    cRowsTexts.Add(l.Txt)
                    cRowsVisible.Add(l.Vis)
                    cRowsClear.Add(l.Clr)
                    cRowsStyle.Add(l.Stl)
                    cRowsNewText.Add(l.Ntx)
                End If
            Next

            ReDim tots(gv.Columns.Count)
            Dim imW() As Integer
            ReDim imW(gv.Columns.Count)

            For Each gvr As GridViewRow In gv.Rows

                ' Fill Additional Columns


                For Each c As String In cAddCols
                    Dim sV() As String = c.Split("|")
                    Dim t As Double = 0
                    For j = 1 To iOrgColCount - 1
                        s = If(InStr(gv.Columns(j).HeaderText, sV(0)) = 0, "0", gvr.Cells(j).Text)
                        t += If(IsNumeric(s), CDec(s), 0)
                    Next
                    gvr.Cells(CInt(sV(2))).Text = t
                Next

                ' Make Calculations

                MakeCalculations(gvr, sTottxt, iRowFieldCount)

                ' Reformat numbers and others

                gvr.Cells(0).Attributes.Add("onmouseup", "duphdr(this);")
                Dim bSubtot As Boolean = Left(gvr.Cells(0).Text.Replace("""", "&quot;"), Len(sTottxt.Replace("""", "&quot;"))) = sTottxt.Replace("""", "&quot;")


                For i = 1 To gv.Columns.Count - 1
                    If gv.Columns(i).HeaderText <> "קישור" Then

                        gvr.Cells(i).Attributes.Add("onmouseup", "thiscolumn(" & rn & "," & i & ",'" & gvr.Cells(i).ClientID & "');")
                        s = gvr.Cells(i).Text
                        If s <> "&nbsp;" Then
                            Dim c As Double = If(IsNumeric(s), CDec(s), 0)
                            If Not bSubtot Then tots(i) += c
                            gvr.Cells(i).Text = FormatNumber(c, gv.Columns(i).HeaderText, sFormat, If(bSubtot, "subtotal", "normal"), gvr.Cells(0).Text, sStyle)
                        End If
                        Separator(sSeperator, i, gvr, "border-left-width:thin;")
                        If bSubtot Then
                            gvr.Cells(i).Attributes.Add("Style", "font-weight:bolder;background-color:LightBlue;height:30px;white-space: nowrap;border-bottom-width:thick;border-bottom-color:White;")
                            Separator(sSeperator, i, gvr, "font-weight:bolder;background-color:LightBlue;border-left-width:thin;border-bottom-width:thick;border-bottom-color:White;")
                        End If
                    End If
                    If bSubtot Or (Not IsNumeric(gvr.Cells(i - 1).Text)) Or Right(gvr.Cells(0).Text, 1) = Chr(159) Then
                        If gv.Columns(i).HeaderText = "קישור" Then
                            gvr.Cells(i).Controls(0).Visible = False
                        End If
                        If bSubtot Then
                            gvr.Cells(i).Attributes.Add("Style", "font-weight:bolder;background-color:LightBlue;height:30px;white-space: nowrap;border-bottom-width:thick;border-bottom-color:White;")
                            Separator(sSeperator, i, gvr, "font-weight:bolder;background-color:LightBlue;border-left-width:thin;border-bottom-width:thick;border-bottom-color:White;")
                        End If

                    End If

                Next
                If gvr.Cells(1).Text = "&nbsp;" Then
                    gvr.Cells(0).Attributes.Add("Style", "font-weight:bolder;font-size:14;")
                End If
                If bSubtot Then gvr.Cells(0).Attributes.Add("Style", "font-weight:bolder;background-color:LightBlue;height:30px;white-space: nowrap;border-bottom-width:thick;border-bottom-color:White;")

                ' Special Row Treatment

                For i As Integer = 1 To cRowsTexts.Count
                    If Replace(gvr.Cells(0).Text, "&#160;", vbNullString) = Replace(cRowsTexts(i), """", "&quot;") Then
                        gvr.Visible = cRowsVisible(i) = "True"
                        If cRowsClear(i) = "True" Then
                            For j = 0 To gvr.Cells.Count - 1
                                gvr.Cells(j).Text = "&nbsp;"
                            Next
                        End If
                        If cRowsStyle(i) <> vbNullString Then
                            gvr.Attributes.Remove("style")
                            gvr.Attributes.Add("style", cRowsStyle(i))
                            For j = 0 To gvr.Cells.Count - 1
                                gvr.Cells(j).Attributes.Add("style", cRowsStyle(i))
                            Next
                        End If
                        If cRowsNewText(i) <> vbNullString Then
                            gvr.Cells(0).Text = cRowsNewText(i)
                        End If
                        Exit For
                    End If
                Next

            Next

            gv.FooterRow.Cells(0).Text = sTottxt & " לדוח"


            '  Footer

            ' Footer initial values( total of every column)

            Dim sN As String
            For i = 1 To gv.Columns.Count - 1
                gv.FooterRow.Cells(i).Text = tots(i)
            Next

            ' footer calculate  calculated cells

            MakeCalculations(gv.FooterRow, sTottxt, iRowFieldCount)

            ' Footer format cells

            For i = 1 To gv.Columns.Count - 1
                If IsNumeric(gv.FooterRow.Cells(i).Text) Then
                    gv.FooterRow.Cells(i).Text = FormatNumber(CDbl(gv.FooterRow.Cells(i).Text), gv.Columns(i).HeaderText, sFormat, "footer", sStyle)
                    '  gv.Columns(i).ItemStyle.Width = 120   '---------------------------------------------------------------------------------------
                End If
            Next

            ' Other Calculation Types

            For i = 1 To gv.Columns.Count - 1
                Dim sI As String = vbNullString
                Try
                    sI = cCalcType(CStr(i))
                    Select Case sI
                        Case "Percent"
                            PercentColumn(i, cTopText(CStr(i)))
                    End Select
                Catch ex As Exception
                End Try
            Next

            'Special CalCulations

            If iSpecial <> 0 Then SpecialReportCalc(gv, iSpecial)

            ' try avoid wrapping of numbers

            gv.Columns(0).AccessibleHeaderText = sRowHdr
            gv.HeaderStyle.Wrap = True
            gv.FooterStyle.Wrap = False
            If sWidth <> "Auto" Then
                gv.Columns(0).AccessibleHeaderText = sRowHdr
                Dim iNx As Integer

                For j = 1 To gv.Columns.Count - 1
                    For Each gvr In gv.Rows
                        iNx = GetActualTextLength(gvr.cells(j).text)
                        imW(j) = If(imW(j) < iNx, iNx, imW(j))

                    Next
                    iNx = GetActualTextLength(gv.FooterRow.Cells(j).Text)
                    imW(j) = If(imW(j) < iNx, iNx, imW(j))
                    Dim s160 As String = "<font color='#37A5FF'>"
                    For k As Integer = 1 To imW(j)
                        s160 &= "_"
                    Next
                    If InStr(gv.Columns(j).HeaderText, "גידול") > 0 Then s160 &= "_"
                    s160 &= "</font>"
                    gv.HeaderRow.Cells(j).Text = s160 & " " & gv.Columns(j).HeaderText
                Next
            Else
                For j = 1 To gv.Columns.Count - 1
                    gv.HeaderRow.Cells(j).Text = Replace(Replace(gv.Columns(j).HeaderText, "&lt;", "<"), "&gt;", ">")
                Next
            End If

            ' Hide columns

            If Request.QueryString("h") <> vbNullString And Not bShow Then
                Dim sl() As String = Request.QueryString("h").Split("|")
                For ij As Integer = 1 To sl.Length - 1
                    If CInt(sl(ij)) < gv.Columns.Count Then gv.Columns(CInt(sl(ij))).Visible = False
                Next
            End If

        End If

    End Sub
    Sub Separator(sSeperator As String, i As Integer, gvr As GridViewRow, sStyle As String)
        If sSeperator <> vbNullString Then
            If Left(sSeperator, 1) = "_" Then
                If i = CInt(Mid(sSeperator, 2)) Then gvr.Cells(i).Attributes.Add("Style", sStyle)
            Else
                If InStr(gv.Columns(i).HeaderText, sSeperator) > 0 Then gvr.Cells(i).Attributes.Add("Style", sStyle)
            End If

        End If
    End Sub
    Function NumberStyle(c As Double, sStyle As String) As String
        If sStyle = vbNullString Then
            Return vbNullString
        Else
            Dim sSty() As String = sStyle.Split("|")
            Dim isSt As Integer = If(c > 0, 0, If(c < 0, 1, 2))
            Return sSty(isst)
        End If
    End Function
    Function FormatNumber(c As Double, hdrTxt As String, sformat As String, Optional sRowType As String = "normal", Optional RowHdr As String = vbNullString, Optional sStle As String = vbNullString) As String
        Dim s As String = sformat
        Dim sStyl As String = NumberStyle(c, sStle)
        For j = 1 To cFtexts.Count
            If InStr(hdrTxt, cFtexts(j)) > 0 And cRowTypes(j) = vbNullString Then
                s = cNumberFormats(j)
                sStyl = NumberStyle(c, cNumberStyles(j))
                GoTo FormatFound
            ElseIf InStr(hdrTxt, cFtexts(j)) > 0 And cRowTypes(j) = sRowType Then
                s = cNumberFormats(j)
                sStyl = NumberStyle(c, cNumberStyles(j))
                GoTo FormatFound
            ElseIf cFtexts(j) = "*" And cRowTypes(j) = sRowType Then
                s = cNumberFormats(j)
                sStyl = NumberStyle(c, cNumberStyles(j))
                GoTo FormatFound
            End If
        Next
FormatFound:
        s = Format(c, s)
        Return If(sStle <> vbNullString, "<span style=""" & sStyl & """>", vbNullString) & s & If(sStle <> vbNullString, "</span>", vbNullString)
    End Function

    Sub BuildColFOrmulasCollections()
        If cCols.Count = 0 Then
            Dim q6 = From l In xE.Descendants("Calculations").Elements _
         Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue _
         Select New With { _
             .Nam = l.Name, _
             .Typ = If(l.Attribute("Type") Is Nothing, "Row", l.Attribute("Type").Value), _
             .TopT = If(l.Attribute("TopText") Is Nothing, vbNullString, l.Attribute("TopText").Value), _
             .inTxt = If(l.Attribute("InText") Is Nothing, vbNullString, l.Attribute("InText").Value), _
            .Col = If(l.Attribute("N") Is Nothing, "0", l.Attribute("N").Value), _
           .Calc = If(l.Attribute("F") Is Nothing, vbNullString, l.Attribute("F").Value), _
            .Func = If(l.Attribute("SF") IsNot Nothing, l.Attribute("SF").Value, vbNullString)}
            For Each l In q6
                Select Case l.Nam
                    Case "Column"
                        cCols.Add(l.Col, l.Col)
                        cCalc.Add(l.Calc, l.Col)
                        cFunc.Add(l.Func, l.Col)
                        cCalcType.Add(l.Typ, l.Col)
                        cTopText.Add(l.TopT, l.Col)
                        cInText.Add(l.inTxt, l.Col)
                    Case "Special"
                        iSpecial = l.Calc
                End Select
            Next
            ReDim ptots(100)
            ReDim ctots(100)
        End If
    End Sub
    Sub MakeCalculations(gvr As GridViewRow, stottxt As String, iRowFieldCount As Integer)
        Dim sH As String = gvr.Cells(0).Text

        For i As Integer = 1 To cCols.Count
            Select Case cCalcType(i)
                Case "Row"
                    If Not IsNumeric(gvr.Cells(1).Text) And Trim(sH).Length > 0 Then
                        If cFunc(i) <> vbNullString Then
                            c_tots.Add(sH & "|" & cCols(i) & "|" & c_tots.Count, sH & "|" & cCols(i))
                        End If
                    End If
                    Dim s As String
                    Dim d As Double
                    Dim opd1 As Double
                    Dim opd2 As Double
                    Dim iCol As Integer = cCols(i)
                    If iCol <= gv.Columns.Count - 1 Then
                        If IsNumeric(gvr.Cells(iCol).Text) Then

                            Dim sP() As String = cCalc(i).Split("|")
                            If (sP.Length > 1) Then
                                For kl As Integer = sP.Length - 1 To 0 Step -3
                                    If kl = sP.Length - 1 Then
                                        If Mid(sP(kl), 2, 1) = "_" Then
                                            s = gvr.Cells(CInt(Mid(sP(kl), 3))).Text
                                            d = If(IsNumeric(s), CDec(s), 0)
                                            opd2 = If(Left(sP(kl), 1) = "+", 1, -1) * d
                                        Else
                                            opd2 = CDec(sP(kl))
                                        End If
                                    End If
                                    If Mid(sP(kl - 1), 2, 1) = "_" Then
                                        s = gvr.Cells(CInt(Mid(sP(kl - 1), 3))).Text
                                        d = If(IsNumeric(s), CDec(s), 0)
                                        opd1 = If(Left(sP(kl - 1), 1) = "+", 1, -1) * d
                                    Else
                                        opd1 = CDec(sP(kl - 1))
                                    End If
                                    Select Case sP(kl - 2)
                                        Case "D"
                                            opd2 = If(opd2 = 0, 0, opd1 / opd2)
                                        Case "A"
                                            opd2 = opd1 + opd2
                                        Case "M"
                                            opd2 = opd1 * opd2
                                    End Select
                                Next
                                gvr.Cells(iCol).Text = opd2
                            End If
                            Dim t1 As Double = gvr.Cells(iCol).Text
                            If InStr(gvr.Cells(0).Text, stottxt.Replace("""", "&quot;")) = 0 Then
                                If cFunc(i) <> vbNullString Then
                                    For j As Integer = 1 To c_tots.Count
                                        Dim vS() As String = c_tots(j).ToString.Split("|")
                                        If CInt(vS(1)) = iCol Then
                                            ctots(CInt(vS(2))) += t1
                                            ptots(CInt(vS(2))) += 1
                                        End If
                                    Next
                                End If
                            Else
                                sH = sH.Replace(stottxt.Replace("""", "&quot;"), vbNullString)
                                Try
                                    Dim vs() As String = c_tots(sH & "|" & cCols(i)).ToString.Split("|")
                                    t1 = ctots(CInt(vs(2)))
                                    Dim t2 As Double = ptots(CInt(vs(2)))
                                    ctots(CInt(vs(2))) = 0
                                    ptots(CInt(vs(2))) = 0
                                    c_tots.Remove(sH & "|" & cCols(i))
                                    Select Case cFunc(i)
                                        Case "AVG"
                                            gvr.Cells(iCol).Text = (t1 / t2)
                                        Case "SUM"
                                            gvr.Cells(iCol).Text = t1
                                    End Select
                                Catch ex As Exception

                                End Try
                            End If
                        End If
                    End If
            End Select
        Next

    End Sub
    Sub BiuldExcelRowFormulas(igvColsCount As Integer)

        For i As Integer = 1 To cCols.Count
            Dim sOpd1 As String
            Dim sOpd2 As String
            Dim iCol As Integer = cCols(i)

            If iCol <= igvColsCount - 1 Then

                Dim sForm As String = vbNullString
                Dim sCol As String
                Dim sP() As String = cCalc(i).Split("|")
                If (sP.Length > 1) Then
                    For kl As Integer = sP.Length - 1 To 0 Step -3
                        sCol = vbNullString
                        If kl = sP.Length - 1 Then
                            If Mid(sP(kl), 2, 1) = "_" Then
                                sOpd2 = If(Left(sP(kl), 1) = "+", "+", "-")
                                sCol = "(" & sOpd2 & "RC" & CStr(CInt(Mid(sP(kl), 3) + 1)) & ")"
                            Else
                                sCol = "(" & sP(kl) & ")"
                            End If
                            sForm = sCol
                        End If
                        If Mid(sP(kl - 1), 2, 1) = "_" Then
                            sOpd1 = If(Left(sP(kl - 1), 1) = "+", "+", "-")
                            sCol = "(" & sOpd1 & "RC" & CStr(CInt(Mid(sP(kl - 1), 3) + 1)) & ")"
                        Else
                            sCol = "(" & sP(kl - 1) & ")"
                        End If
                        Select Case sP(kl - 2)
                            Case "D"
                                sForm = "(if(" & sForm & "=0,0," & sCol & "/" & sForm & "))"
                            Case "A"
                                sForm = "(" & sCol & "+" & sForm & ")"
                            Case "M"
                                sForm = "(" & sCol & "*" & sForm & ")"
                        End Select
                    Next
                    cFormulas.Add("=" & sForm & "|" & CStr(iCol), CStr(iCol))
                End If
            End If
        Next

    End Sub
    Sub doExcel(sF As String, lblhdr As WebControls.Label, lblsubhdr As WebControls.Label, lblDate As WebControls.Label, gv As GridView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(lblsubhdr)
        frm.Controls.Add(gv)
        frm.Controls.Add(lblDate)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
        'gv.DataBind()
    End Sub
    Function XCell(ByVal iRow As Integer, ByVal iCol As Integer) As String
        Return Chr(65 + iCol) & iRow
    End Function

    Protected Sub DDLREPTYPE_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLREPTYPE.SelectedIndexChanged
        Dim ddl As RadioButtonList = CType(sender, RadioButtonList)
        WriteCoockie(ddl)
        initCriterionArea(ddl)
        gvComments.Visible = False
    End Sub
    Sub initCriterionArea(ddl As RadioButtonList)

        If Not IsPostBack Then

            If xE Is Nothing Then xE = XElement.Load(MapPath("App_Data/Reports.xml"))
            Dim q = From l In xE.Descendants("Versions") _
        Where l.Parent.Attribute("ID").Value = Request.QueryString("r") _
    Select l.Value
            For Each l In q
                DSVERSION.SelectCommand = l
                DDLVERSION1.Items.Clear()
                Dim li1 As New ListItem("[בחר גרסה 1]", "")
                DDLVERSION1.Items.Add(li1)
                DDLVERSION1.DataBind()

                DDLVERSION2.Items.Clear()
                Dim li2 As New ListItem("[בחר גרסה 2]", "")
                DDLVERSION2.Items.Add(li2)
                DDLVERSION2.DataBind()

                DDLVERSION3.Items.Clear()
                Dim li3 As New ListItem("[בחר גרסה 3]", "")
                DDLVERSION3.Items.Add(li3)
                DDLVERSION3.DataBind()

                DDLVERSION4.Items.Clear()
                Dim li4 As New ListItem("[בחר גרסה 4]", "")
                DDLVERSION4.Items.Add(li4)
                DDLVERSION4.DataBind()
            Next
            lblver1_2.Visible = False
            lblver3_4.Visible = False
            DDLVERSION1.Visible = False
            DDLVERSION2.Visible = False
            DDLVERSION3.Visible = False
            DDLVERSION4.Visible = False
            DDLDATES.Visible = False
            DDLDATES.DataSourceID = Nothing
            DDLDATES.DataTextField = Nothing
            DDLDATES.DataValueField = Nothing

            Dim qFrm = From l In xE.Descendants("Frames") _
        Where l.Parent.Attribute("ID").Value = Request.QueryString("r") _
        Select l.Value
            If qFrm.Count = 0 Then
                tdd.TableName = "(SELECT CategoryID,Name,Parent,itemOrder FROM (SELECT 1 As CategoryID,'שירות' as Name,0 as Parent,0 as itemOrder UNION ALL SELECT CategoryID,Name,parent,itemOrder " & _
                " FROM Categories_besqxl " & _
                 " WHERE CategoryID IN " & _
          "	(SELECT CategoryID  " & _
               " FROM ttrHeirarchy " & _
          "	WHERE Parent IN (SELECT CategoryID FROM p0t_NtbRow WHERE UserID=" & Session("UserID") & ")) " & _
                " UNION ALL " & _
          "	SELECT CategoryID,Name,1 as parent,itemOrder " & _
                " FROM Categories_besqxl " & _
                 " WHERE CategoryID IN " & _
          "	(SELECT CategoryID  " & _
               " FROM p0t_NtbRow WHERE UserID=" & Session("UserID") & ")) x )"
                If tdd.SelectedValue = vbNullString Then
                End If
            Else
                For Each l In qFrm
                    tdd.TableName = l.Replace("@UserID", Session("UserID"))
                Next
            End If
            tdd.DataBind()
            If Session("tddframe_v") <> vbNullString Then
                tdd.SelectedValue = Session("tddframe_v")
                tdd.SelectedText = Session("tddframe_t")
            End If

            Dim q2 = From l In xE.Descendants("Param") _
                 Where l.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") _
             Select New With {.Nam = l.Attribute("Name").Value, .Val = l.Value}

            For Each l In q2
                Dim s As String = l.Nam
                Dim sv As String = l.Val
                Select Case s
                    Case "@VersionCategoryID1"
                        DDLVERSION1.Visible = True
                        ReadCookie(DDLVERSION1)
                    Case "@VersionCategoryID2"
                        DDLVERSION2.Visible = True
                        lblver1_2.Visible = True
                        ReadCookie(DDLVERSION2)
                    Case "@VersionCategoryID3"
                        lblver3_4.Visible = True
                        DDLVERSION3.Visible = True
                        ReadCookie(DDLVERSION3)
                    Case "@VersionCategoryID4"
                        DDLVERSION4.Visible = True
                        ReadCookie(DDLVERSION4)
                    Case "@DateB"
                        DDLDATES.Visible = True
                        DDLDATES.Items.Clear()
                        Dim li As New ListItem("[בחר תאריך]", "")
                        DDLDATES.Items.Add(li)
                        If sv <> vbNullString Then
                            dsdates.SelectCommand = sv
                            '                         HDNDATES.Value = sv
                        End If
                        DDLDATES.DataSourceID = "dsdates"
                        DDLDATES.DataTextField = "dl"
                        DDLDATES.DataValueField = "dl"
                        If li IsNot Nothing Then li.Selected = True
                    Case "@FrameID"
                        divSelectFrame.Visible = True
                    Case Else
                End Select

            Next
            Try
                lblhdr.Text = DDLREPTYPE.SelectedItem.Text
            Catch ex As Exception

            End Try
        End If

    End Sub
    Protected Sub DDLVERSION_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLVERSION1.PreRender, DDLVERSION2.PreRender, DDLVERSION3.PreRender, DDLVERSION4.PreRender, DDLDATES.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedIndex = 0 Or Not IsPostBack Then
            ReadCookie(ddl)
            If ddl.ID = "DDLVERSION1" Then
                If DDLDATES.Visible = True Then
                    If DDLDATES.SelectedIndex <= 0 Then
                        DDLDATES.Items.Clear()
                        Dim li As New ListItem("[בחר תאריך]", "")
                        DDLDATES.Items.Add(li)
                        '                     If HDNDATES.Value IsNot Nothing Then dsdates.SelectCommand = HDNDATES.Value
                        DDLDATES.DataSourceID = "dsdates"
                        DDLDATES.DataTextField = "dl"
                        DDLDATES.DataValueField = "dl"
                        If li IsNot Nothing Then li.Selected = True

                    End If
                End If
            End If
        End If
    End Sub
    Sub ReadCookie(ByVal obj As Object)
        Dim sKey As String
        Dim s As String
        Dim sT As String
        If obj.ID = "DDLREPTYPE" Then
            sKey = "REPORT" & Request.QueryString("r") & "DDLREPTYPE" & obj.ID & "_V"
            obj = CType(obj, RadioButtonList)
        Else
            sKey = "REPORT" & Request.QueryString("r") & obj.ID & "_V"
            obj = CType(obj, DropDownList)
        End If
        If obj.items.count > 0 Then
            If obj.SelectedValue = vbNullString Then 'Or Left(obj.Selecteditem.Text, 1) = "[" Then
                If Request.Cookies() IsNot Nothing Then
                    If Request.Cookies(sKey) IsNot Nothing Then
                        s = Request.Cookies(sKey).Value
                        sT = Request.Cookies(sKey.Replace("_V", "_T")).Value
                        Dim li As ListItem = Nothing
                        li = obj.Items.FindByValue(Trim(s))
                        If li IsNot Nothing Then
                            obj.ClearSelection()
                            li.Selected = True
                        ElseIf obj.ID <> "DDLDATES" Then
                            li = New ListItem(s, sT)
                            obj.ClearSelection()
                            'Dim li1 As New ListItem("יש קוקימספר האיטמס=" & ddl.Items.Count & "קוקי=" & s, "777")
                            obj.Items.Add(li)
                            li.Selected = True
                        End If
                    Else
                        '    Dim li1 As New ListItem("אין קוקי", "888")
                        '    ddl.Items.Add(li1)
                    End If
                End If

            End If
        End If


    End Sub
    Sub WriteCoockie(ByVal obj As Object)
        If obj.ID = "DDLREPTYPE" Then
            Dim rbl As RadioButtonList = CType(obj, RadioButtonList)
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_V").Value = rbl.SelectedValue
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_V").GetHashCode()
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_V").Expires = DateAdd(DateInterval.Month, 1, Now())
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_V").HttpOnly = False

            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_T").Value = rbl.SelectedItem.Text
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_T").GetHashCode()
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_T").Expires = DateAdd(DateInterval.Month, 1, Now())
            Response.Cookies("REPORT" & Request.QueryString("r") & "DDLREPTYPE" & rbl.ID & "_T").HttpOnly = False
        Else
            Dim ddl As DropDownList = CType(obj, DropDownList)
            Dim s As String = obj.ID
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_V").Value = ddl.SelectedValue
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_V").GetHashCode()
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_V").Expires = DateAdd(DateInterval.Month, 1, Now())
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_V").HttpOnly = False

            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_T").Value = ddl.SelectedItem.Text
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_T").GetHashCode()
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_T").Expires = DateAdd(DateInterval.Month, 1, Now())
            Response.Cookies("REPORT" & Request.QueryString("r") & ddl.ID & "_T").HttpOnly = False
        End If
    End Sub

    Protected Sub btnshow_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.PreRender
        If Not IsPostBack And ((Request.QueryString("h") <> vbNullString And Not bShow) Or (Request.QueryString("show") = 1)) Then
            gvComments.Visible = True
            ShowSadin(False)
        End If
    End Sub

    Protected Sub DDLREPTYPE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLREPTYPE.PreRender
        Dim ddl As RadioButtonList = CType(sender, RadioButtonList)
        ReadCookie(ddl)
        initCriterionArea(ddl)
    End Sub

    Protected Sub DDLDATES_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDATES.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        WriteCoockie(ddl)
    End Sub

    Protected Sub BTNCATEGORYLIST_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNCATEGORYLIST.Click
        Dim sScript As String = "<Script langualge=&quot;javascript&quot;>window.open ('SadinExcludeCategories.aspx?S=" & DDLREPTYPE.SelectedValue & "&amp;R=1','mywindow','resizable=yes,scrollbars=yes');</Script>"
        Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", sScript)
    End Sub

    Protected Sub gv_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gv.SelectedIndexChanged
        '       Response.Redirect("http://srv/be/App_Doc/T48615.htm")
        Dim gv As GridView = CType(sender, GridView)
        Dim gvr As GridViewRow = gv.Rows(gv.SelectedIndex)
        Dim sFrame As String = vbNullString
        Dim sVersion As String = vbNullString
        Dim sBudget1 As String = vbNullString
        Dim sBudget2 As String = vbNullString
        Dim sBudget As String = vbNullString
        Dim sSubject As String = vbNullString
        Dim sType As String = vbNullString
        Dim sLocation As String = vbNullString
        Dim connStr As String = "Data Source=vds;Initial Catalog=Book10;Persist Security Info=True;User ID=sa;Password=karlosthe1st"
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("", dbConnection)
        cD.CommandType = CommandType.Text
        Dim dr As SqlDataReader
        Dim sb(2) As String
        If xE Is Nothing Then xE = XElement.Load(MapPath("App_Data/Reports.xml"))
        Dim q6 = From l In xE.Descendants("Links").Elements _
              Where l.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue And l.Parent.Name = "Links"
            Select New With { _
                .qry = l.Value, _
                .frm = l.Attribute("Frame").Value, _
                .ver = l.Attribute("Version").Value, _
                .bgt1 = If(l.Attribute("Budget_1") Is Nothing, vbNullString, l.Attribute("Budget_1").Value), _
                .bgt2 = If(l.Attribute("Budget_2") Is Nothing, vbNullString, l.Attribute("Budget_2").Value), _
                .bgt = l.Attribute("Budget").Value, _
                .sbj = l.Attribute("Subject").Value, _
                .typ = l.Attribute("Type").Value, _
                .loc = l.Attribute("Location").Value}
        For Each l In q6
            If l.frm = "tdd" Then
                sFrame = tdd.SelectedValue
            End If
            If l.frm = "reprow" Then
                sFrame = gvr.Cells(0).Text.Replace("&#160;", vbNullString)
                If InStr(sFrame, ":") > 0 Then
                    sSubject = Mid(sFrame, InStr(sFrame, ":"))
                    sFrame = Left(sFrame, InStr(sFrame, ":") - 1)
                End If
                cD.CommandText = "SELECT CategoryID FROM SHERUT_besqxl WHERE ISNULL([שירות_-_3],[שירות_-_2])='" & sFrame & "'"
                dbConnection.Open()
                dr = cD.ExecuteReader
                If dr.Read Then
                    sFrame = dr("CategoryID")
                End If
                dr.Close()
                dbConnection.Close()
            End If

            If l.ver = "DDLVERSION1" Then
                sVersion = DDLVERSION1.SelectedValue
            End If
            sBudget1 = l.bgt1
            sBudget2 = l.bgt2
            sBudget = l.bgt
            If sBudget = "column0" Then sBudget = gvr.Cells(0).Text
            Dim i As Integer = If(sBudget2 = "_", 0, CountCharacter(sBudget, "&#160;"))
            Dim s As String = If(sBudget1 = vbNullString, "0", "1") & If(sBudget2 = vbNullString, "0", "1") & If(Right(sBudget, 1) = "_", 1, i)
            sb(0) = sBudget1
            sb(1) = If(sBudget2 = "_", vbNullString, sBudget2)
            sb(2) = vbNullString
            sBudget = sBudget.Replace("&#160;", vbNullString)
            Select Case s
                Case "000"
                    sb(0) = sBudget
                Case "004"
                    sb(1) = If(Right(sBudget, 1) = sBudget2, sBudget.Replace(sBudget2, vbNullString), sBudget)
                Case "008"
                    sb(2) = sBudget
                Case "100"
                    sb(1) = If(Right(sBudget, 1) = sBudget2, sBudget.Replace(sBudget2, vbNullString), sBudget)
                Case "104"
                    sb(2) = sBudget
                Case "110"
                    sb(2) = sBudget
                Case "111"
                    sb(1) = If(Right(sBudget, 1) = sBudget2, sBudget.Replace(sBudget2, vbNullString), sBudget)
            End Select
            If l.sbj = "column0" Then
                sSubject = gvr.Cells(0).Text.Replace("&quot;", """")
            Else
                sSubject = l.sbj
            End If
            sType = l.typ
            sLocation = l.loc
        Next


        '  Dim cD As New SqlCommand("SELECT  [מספר תבנית] As t,count(*) over() As Cnt  From (Select distinct [מספר תבנית],VersionCategoryID,FrameCategoryID,[תקציב - 1],[תקציב - 2],[תקציב - 3] From BEBudget Where [מספר תבנית]<10000000 " & _
        cD.CommandText = "SELECT  [מספר תבנית] As t,count(*) over() As Cnt  From (Select distinct [מספר תבנית],VersionCategoryID,FrameCategoryID,BudgetCategoryID,JobCategoryID,[תקציב - 1],[תקציב - 2],[תקציב - 3] From BEBudget b " & _
                                 "LEFT OUTER JOIN BUDGET_besqxl d on d.CategoryID=b.BudgetCategoryID  " & _
                                 " Where [מספר תבנית]<10000000 " & _
                            "AND VersionCategoryID = " & sVersion & _
                            " AND FrameCategoryID = " & sFrame & _
                            If(sb(0) <> vbNullString, " AND [תקציב_-_1] = '" & sb(0).Replace("&#39;", "''").Replace("&quot;", """") & "'", vbNullString) & _
                            If(sb(1) <> vbNullString, " AND [תקציב_-_2] = '" & sb(1).Replace("&#39;", "''").Replace("&quot;", """") & "'", vbNullString) & _
                            If(sb(2) <> vbNullString, " AND [תקציב_-_3] = '" & sb(2).Replace("&#39;", "''").Replace("&quot;", """") & "'", vbNullString) & _
                            If(sSubject <> vbNullString, " AND [נושא] = '" & sSubject.Replace("&#39;", "''") & "'", vbNullString) & _
                            ") As x"
        dbConnection.Open()
        dr = cD.ExecuteReader
        While dr.Read
            If dr("Cnt") > 1 Then
                dbConnection.Close()
                Response.Redirect("MultiTemplate.aspx?b1=" & sb(0) & "&b2=" & sb(1) & "&b3=" & sb(2) & "&s=" & sSubject.Replace("&quot;", vbNullString) & "&v=" & sVersion & "&f=" & sFrame)
            End If
            Dim sTemplt As String = dr("t")
            If IsNumeric(sTemplt) Then
                Dim sFullname = sLocation & sTemplt & ".htm"
                If IsURLValid(sFullname) Then
                    Try
                        dbConnection.Close()
                        Response.Redirect(sFullname)
                        '                Dim sScript As String = "<Script langualge=&quot;javascript&quot;>window.open ('" & sLocation & sTemplt & ".htm','mywindow','" & sType & "','resizable=yes,scrollbars=yes');</Script>"
                        'Dim sScript As String = "<Script langualge=&quot;javascript&quot;>popup('" & sFullname & "');" ' "','mywindow','" & sType & "');</Script>" ','resizable=yes,scrollbars=yes'
                        'Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", sScript)
                    Catch ex As Exception
                        WebMsgApp.WebMsgBox.Show("לא ניתן להציג קישור זה " & vbCrLf & sFullname)
                    End Try
                Else
                    WebMsgApp.WebMsgBox.Show("לא ניתן להציג קישור זה " & vbCrLf & sFullname)
                End If
            Else
                WebMsgApp.WebMsgBox.Show(" לא ניתן להציג קישור זה" & vbCrLf & sTemplt)
            End If
        End While
        dr.close()
        dbConnection.Close()


    End Sub
    Function CountCharacter(ByVal value As String, ByVal ch As String) As Integer
        Dim cnt As Integer = 0
        For i As Integer = 1 To value.Length Step ch.Length
            If ch = Mid(value, i, ch.Length) Then cnt += 1
        Next
        Return cnt
    End Function


    Function IsURLValid(ByVal sUrl As String) As Boolean
        Dim b As Boolean
        Dim url As New System.Uri(sUrl)
        Dim req As System.Net.WebRequest
        req = System.Net.WebRequest.Create(url)
        Dim resp As System.Net.WebResponse
        Try
            resp = req.GetResponse()
            resp.Close()
            req = Nothing
            b = True
        Catch ex As Exception
            req = Nothing
            b = False
        End Try
        Return b
    End Function
    Sub ShowChart(Optional ByVal sCharType As String = "Column", Optional ByVal sURL As String = vbNullString, Optional ByVal iWidth As Integer = 500, Optional ByRef iFirstColumn As Integer = 0, Optional ByVal iLastColumn As Integer = 30)


        Dim cCharType As SeriesChartType
        If sCharType = "Column" Then cCharType = SeriesChartType.Column
        If sCharType = "Bar" Then cCharType = SeriesChartType.Bar
        If sCharType = "StackedArea" Then cCharType = SeriesChartType.StackedArea

        Dim c(0 To 30) As Color
        Dim s As String
        c(0) = Color.Silver 'Color.LightBlue ' Color.Goldenrod
        c(1) = Color.DeepSkyBlue
        c(2) = Color.Crimson
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
        c(14) = Color.LightBlue
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

        ChrtG.Visible = True
        ChrtG.Series.Clear()
        ChrtG.ChartAreas.Clear()
        ChrtG.ChartAreas.Add("test")
        ChrtG.Legends.Add("ff")
        Dim i As Integer
        Dim j As Integer
        Dim l As Integer = 0
        If gv.Columns.Count < 2 Or gv.Rows.Count > 30 Then
            ErrCatch()
            Exit Sub
        End If
        For i = 0 To gv.Rows.Count - 1
            Dim gvr As GridViewRow = gv.Rows(i)
            Dim tc As TableCell = gvr.Cells(1)
            s = "s" & l
            ChrtG.Series.Add(s)
            ChrtG.Series(s).ChartType = cCharType
            ChrtG.Series(s)("DrawingStyle") = "Emboss"
            ChrtG.Series(s).IsVisibleInLegend = True
            ChrtG.Series(s).LegendText = gvr.Cells(0).Text
            ChrtG.Legends(0).Docking = Docking.Bottom
            ChrtG.Legends(0).Alignment = StringAlignment.Near
            ChrtG.Series(s).Color = c(l)
            ChrtG.Series(s).BorderColor = Color.Black
            ChrtG.Series(s).BorderWidth = 2
            ChrtG.Series(s).IsValueShownAsLabel = True
            l = l + 1
            For j = iFirstColumn To If(iLastColumn <= gv.Columns.Count - 1, iLastColumn, gv.Columns.Count - 1)
                Dim dK As Double = If(IsNumeric(gvr.Cells(j).Text), CDbl(gvr.Cells(j).Text), 0)
                Dim sH As String = gv.Columns(j).HeaderText
                ChrtG.Series(s).Points.AddXY(sH, dK)
            Next
        Next
        ChrtG.Width = 1000
        ChrtG.ChartAreas(0).AxisX.IsReversed = True
        ChrtG.ChartAreas(0).AxisY.MajorGrid.LineColor = Color.Gray
        ChrtG.ChartAreas(0).AxisY.MajorGrid.LineDashStyle = DataVisualization.Charting.ChartDashStyle.Dot
        ChrtG.ChartAreas(0).AxisX.MajorGrid.LineWidth = 0
        ChrtG.ChartAreas(0).AxisX.LabelStyle.Angle = -60
        ChrtG.ChartAreas(0).AxisX.Interval = 1
        ChrtG.Width = CType(iWidth, System.Web.UI.WebControls.Unit)

    End Sub
    Sub ErrCatch()
    End Sub

    Protected Sub gvComments_PreRender(sender As Object, e As System.EventArgs) Handles gvComments.PreRender
        Dim gv As GridView = CType(sender, GridView)
        If gv.Rows.Count <= 0 Then gv.Visible = False
    End Sub
    Sub PercentColumn(iColp As Integer, sTT As String)

        ' Find Columns indexes

        If iColp > gv.Columns.Count Then iColp = gv.Columns.Count - 2

        Dim iColD As Integer = iColp - 1
        Dim d As Double = 0

        If iColp = 0 Or iColD = 0 Then Exit Sub

        Dim sMc As Double = 0

        ' Find The Tot Total 

        If sTT IsNot Nothing Then
            If gv.FooterRow.Cells(0).Text = sTT Then
                sMc = If(IsNumeric(gv.FooterRow.Cells(iColD).Text), CDbl(gv.FooterRow.Cells(iColD).Text), 0)
            Else
                For i As Integer = 0 To gv.Rows.Count - 1
                    If gv.Rows(i).Cells(iColp).Text = sTT Then
                        sMc = If(IsNumeric(gv.Rows(i).Cells(iColD).Text), CDbl(gv.Rows(i).Cells(iColD).Text), 0)
                        Exit For
                    End If
                Next
            End If
        End If

        ' Calc Percent in footer line

        gv.FooterRow.Cells(iColp).Text = sForDbl(gv.FooterRow.Cells(iColD).Text, sMc)

        ' Calc Percent In Rows

        CalcPerc(gv.Rows.Count - 1, iColp, iColD, sMc, 0)

    End Sub
    Sub CalcPerc(iRow As Integer, iColP As Integer, iColD As Integer, sMc As Double, iOdep As Integer)
        Dim cSMC As New Collection
        cSMC.Add(sMc, "0")
        For i As Integer = iRow To 0 Step -1
            Dim gvr As GridViewRow = gv.Rows(i)
            Dim iDepth As Integer = Depth(gvr.Cells(0).Text)                ' Depth of row
            If Mid(Replace(gvr.Cells(0).Text, "&quot;", """"), iDepth * 4 + 1, Len(sTottxt)) = sTottxt Then ' if subtotal row, take total
                sMc = cSMC(CStr(iDepth))
                gv.Rows(i).Cells(iColP).Text = sForDbl(gv.Rows(i).Cells(iColD).Text, sMc)
                Try
                    cSMC.Remove(CStr(iDepth + 1))
                Catch ex As Exception
                End Try
                cSMC.Add(sMc, CStr(iDepth + 1))
                sMc = dsD(gvr.Cells(iColD).Text)
            Else
                gv.Rows(i).Cells(iColP).Text = sForDbl(gv.Rows(i).Cells(iColD).Text, sMc)
            End If
        Next
    End Sub

    Function dsD(s As String) As Double
        Dim sx As String = Replace(Replace(Replace(s, ",", vbNullString), ")", vbNullString), "(", "-")
        Return If(IsNumeric(sx), CDbl(sx), 0)
    End Function

    Function sForDbl(s As String, dSc As Double) As String
        If dSc = 0 Then Return vbNullString
        Dim d As Double = dsD(s)
        Return If(d <> 0, Format(Abs(d / dSc), "#%"), vbNullString)
    End Function
    Function Depth(s As String) As Integer
        Dim sT As String = Replace(s, "&#160;&#160;&#160;&#160;", "|")

        Dim cA() As Char = sT.ToCharArray
        Dim iDepth As Integer = 0
        For j = 0 To cA.Length - 1
            If cA(j) <> "|" Then Exit For
            iDepth += 1
        Next
        Return iDepth
    End Function
    Sub SpecialReportCalc(gv As GridView, i As Integer)
        Select Case i

            Case 1                      '     ID="6" Name="דוחות הנהלה"  PID="1" Name="מנהלי מסגרות סוף שנה" Footer Row
                Dim tCnt(25) As Double
                Dim pCnt(25) As Double
                For Each gvr As GridViewRow In gv.Rows
                    For j As Integer = 1 To gv.Columns.Count - 1
                        tCnt(j) += If(InStr(gvr.Cells(j).Text, ">V<") > 0 Or InStr(gvr.Cells(j).Text, ">X<") > 0, 1, 0)
                        pCnt(j) += If(InStr(gvr.Cells(j).Text, ">V<") > 0, 1, 0)
                    Next
                Next
                gv.FooterRow.Cells(2).Text = Format(pCnt(1) / tCnt(1), "0%")
                If gv.Columns.Count > 4 Then gv.FooterRow.Cells(4).Text = Format(pCnt(3) / tCnt(3), "0%")
                If gv.Columns.Count > 6 Then gv.FooterRow.Cells(6).Text = Format(pCnt(5) / tCnt(5), "0%")
                If gv.Columns.Count > 8 Then gv.FooterRow.Cells(8).Text = Format(pCnt(7) / tCnt(7), "0%")
                If gv.Columns.Count > 10 Then gv.FooterRow.Cells(10).Text = Format(pCnt(9) / tCnt(9), "0%")
                If gv.Columns.Count > 11 Then gv.FooterRow.Cells(12).Text = Format(pCnt(11) / tCnt(11), "0%")

            Case 2 'דוח מרכז ודוח סיכום חישוב אחוזים

                Dim smc As Double = 0
                gv.FooterRow.Cells(0).Text = "רווח אחרי השקעות"
                Dim gvrk As GridViewRow = Nothing
                For k = 0 To 2
                    Dim t As Double = 0
                    Dim l As Integer = If(k = 0, 2, If(k = 1, 4, If(k = 2, 7, 0)))
                    For Each gvr As GridViewRow In gv.Rows

                        If gvr.Cells(0).Text = "רווח אחרי השקעות" Then
                            gvrk = gvr
                            Exit For
                        End If
                        If gvr.Cells(0).Text = "סה&quot;כ הכנסות" Then
                            If l >= gvr.Cells.Count - 1 Then l = gvr.Cells.Count - 2
                            smc = If(IsNumeric(gvr.Cells(l).Text), CDbl(gvr.Cells(l).Text), 0)
                        End If
                        If smc <> 0 Then
                            If l >= gvr.Cells.Count - 1 Then l = gvr.Cells.Count - 2
                            Dim d As Double = If(IsNumeric(Replace(gvr.Cells(l).Text, ",", vbNullString)), Abs(CDbl(gvr.Cells(l).Text) / smc), 0)
                            gvr.Cells(l + 1).Text = sForDbl(gvr.Cells(l).Text, smc)
                        End If
                        If gvr.Visible Then
                            Dim s As String = gvr.Cells(0).Text
                            If l >= gvr.Cells.Count - 1 Then l = gvr.Cells.Count - 2
                            If s = "רווח גולמי" Or s = "השקעות" Or s = "סה&quot;כ השקעות" Then t = t + If(IsNumeric(Replace(gvr.Cells(l).Text, ",", vbNullString)), CDbl(Replace(gvr.Cells(l).Text, ",", vbNullString)), 0)
                        End If
                    Next
                    If gv.FooterRow.Cells.Count - 1 = 6 Then l = 5
                    gv.FooterRow.Cells(l).Text = Format(t, "#,###;(#,###); - ")
                    gv.FooterRow.Cells(l + 1).Text = Format(Abs(t / smc), "#%")

                    ' חישוב אחוזי שכר

                    SpecPerc(l, "&#160;&#160;&#160;&#160;שכר בסיסי", "סה&quot;כ שכר", 0, gv.Rows.Count - 1)

                    ' חישוב אחוזי השקעות

                    SpecPerc(l, "סה&quot;כ השקעות", "השקעות", gv.Rows.Count - 1, 0)

                    'חישוב אחוזי הכנסות

                    SpecPerc(l, "&#160;&#160;&#160;&#160;סה&quot;כ הכנסות חינוך", "&#160;&#160;&#160;&#160;הכנסות חינוך", gv.Rows.Count - 1, 0)
                Next

                If gvrk IsNot Nothing Then
                    For i = 0 To gvrk.Cells.Count - 1
                        gvrk.Cells(i).Text = gv.FooterRow.Cells(i).Text
                    Next
                    gv.FooterRow.Visible = False
                End If

            Case 4              'דוח כח אדם כמותי

                Dim d As Double = 0
                For i = gv.Rows.Count - 1 To 0 Step -1
                    Dim gvr As GridViewRow = gv.Rows(i)
                    If gvr.Visible And (gvr.Cells(0).Text = "סה&quot;כ עלות חודשית" Or gvr.Cells(0).Text = "הפחתת חשבוניות") Then
                        d += If(IsNumeric(Replace(Replace(Replace(gvr.Cells(3).Text, ",", vbNullString), "(", "-"), ")", vbNullString)), CDbl(gvr.Cells(3).Text), 0)
                    End If
                    If Not IsNumeric(gvr.Cells(4).Text) Then gvr.Cells(5).Text = vbNullString
                Next
                gv.FooterRow.Cells(3).Text = Format(d, "#,###")
                gv.FooterRow.Cells(5).Text = vbNullString
        End Select
    End Sub
    Sub SpecPerc(l As Integer, sStart As String, sEnd As String, iFirst As Integer, iLast As Integer)
        Dim b As Boolean = False
        Dim bE As Boolean = False
        Dim dS As Double
        Dim iStep As Integer = If(iFirst < iLast, 1, -1)
        For i = iFirst To iLast Step iStep
            If Not b Then b = gv.Rows(i).Cells(0).Text = sStart
            If b Then
                dS = dsD(gv.Rows(i).Cells(l).Text)
                bE = True
                b = False
            End If
            If bE Then
                If gv.Rows(i).Cells(0).Text = sEnd Then Exit For
                gv.Rows(i).Cells(l + 1).Text = sForDbl(gv.Rows(i).Cells(l).Text, dS)
            End If
        Next
    End Sub

    Function GetActualTextLength(s As String) As Integer
        Dim ar() As Char = s.ToCharArray
        Dim k As Integer = 0
        Dim l As Integer = ar.Length
        For i = 0 To ar.Length - 1
            If ar(i) = ">" Then k = i
            If ar(i) = "<" Then l = i
            If l - k > 1 Then Exit For
        Next
        Return l - k
    End Function

    'Protected Sub btnprnt_Click1(sender As Object, e As System.EventArgs) Handles btnprnt.Click
    '    If gv.Columns.Count < 3 Then Exit Sub
    '    Dim bUserName As Boolean = True
    '    Dim sHdr As String = vbNullString
    '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
    '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
    '    Dim cD As New SqlCommand("", dbConnection)
    '    cD.CommandType = CommandType.Text
    '    Dim dr As SqlDataReader
    '    dbConnection.Open()

    '    gv.BorderStyle = BorderStyle.None

    '    ' Build Header

    '    If xE Is Nothing Then xE = XElement.Load(MapPath("App_Data/Reports.xml"))
    '    Dim q6 = From l In xE.Descendants("Title").Elements _
    '          Where l.Parent.Parent.Parent.Parent.Attribute("ID").Value = Request.QueryString("r") And l.Parent.Parent.Parent.Attribute("PID").Value = DDLREPTYPE.SelectedValue And l.Parent.Parent.Name = "Print"
    '        Select New With { _
    '            .Nam = l.Value, _
    '            .Stl = If(l.Attribute("Style") Is Nothing, vbNullString, l.Attribute("Style").Value), _
    '            .Usr = If(l.Parent.Attribute("UserName") Is Nothing, "True", l.Parent.Attribute("UserName").Value)}

    '    For Each l In q6
    '        bUserName = l.Usr = "True"
    '        Select Case l.Nam
    '            Case "Service"
    '                cD.CommandText = "Select [שירות_-_1] From SHerut_Besqxl Where CategoryID=" & tdd.SelectedValue
    '                dr = cD.ExecuteReader
    '                If dr.Read Then
    '                    sHdr = "<span style='" & l.Stl & "'>" & dr("שירות_-_1") & "</span><br >"
    '                End If
    '                dr.Close()
    '            Case "Frame"
    '                sHdr &= "<span style='" & l.Stl & "'>" & Replace(tdd.SelectedText, """", "&quot;") & "</span><br >"
    '            Case "Version"
    '                cD.CommandText = "Select [ענף_גרסה] From Girsa_Besqxl Where CategoryID=" & DDLVERSION1.SelectedValue
    '                dr = cD.ExecuteReader
    '                If dr.Read Then
    '                    sHdr &= "<span style='" & l.Stl & "'>" & Replace(dr("ענף_גרסה"), """", "&quot;") & "</span><br >"
    '                End If
    '                dr.Close()
    '            Case "Report"
    '                sHdr &= "<span style='" & l.Stl & "'>" & lblhdr.Text & "</span>"
    '        End Select
    '    Next
    '    dbConnection.Close()
    '    lbldate.Visible = True
    '    GridViewPrint(Page, gv, sHdr, lblComment, , bUserName, gvComments)

    'End Sub
    Public Overrides Sub VerifyRenderingInServerForm(control As Control)
        'Verifies that the control is rendered 
    End Sub
End Class
