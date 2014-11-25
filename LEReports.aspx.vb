Imports System.Data.SqlClient
Imports System.Data
Imports System.IO

Partial Class EL_Reports
    Inherits System.Web.UI.Page
    Dim xEL As XElement
    Dim iXlF As Integer
    Dim bExcel As Boolean = False

    Function BldQ() As String
        Dim sCtJoin As String = vbNullString
        Dim sCtField As String = vbNullString
        Dim sNuc As String = "SELECT * FROM vEL_LeavingEmps PIVOT (MAX(VAL) FOR QuestionID IN ("
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
        Dim Query = From q In xEL.Descendants("Question") _
        Select New With { _
            .id = q.Attribute("id").Value, _
            .cdt = If(q.Attribute("Codetable") Is Nothing, vbNullString, q.Attribute("Codetable").Value), _
            .flid = If(q.Attribute("Codefield") Is Nothing, vbNullString, q.Attribute("Codefield").Value), _
            .flnd = If(q.Attribute("Field") Is Nothing, vbNullString, q.Attribute("Field").Value)}

        For Each q In Query
            sNuc &= "[_" & q.id & "], "
            If q.cdt <> vbNullString Then
                sCtJoin &= " LEFT OUTER JOIN " & q.cdt & " AS t" & q.id & " ON x._" & q.id & " = t" & q.id & "." & q.flid
                sCtField &= ", t" & q.id & "." & q.flnd & " AS " & q.flnd & "_" & q.id
            End If
        Next

        Dim s As String = "SELECT x.*" & sCtField & " FROM (" & Left(sNuc, Len(sNuc) - 2) & ")) AS ptv " & ") x " & sCtJoin & " WHERE x.FrameID IN (SELECT FrameID From dbo.p0v_UserFrameList Where UserID=" & Session("UserID") & ")"
 
        ' Build The report filter ---------------------------------------------

        ' Date Range Filter (skip if field

        If tbFromdate.SelectedDate = CDate("2000-1-1") And tbToDate.SelectedDate = CDate("2099-12-31") Then
        Else
            s &= " AND ActualLeavingDate BETWEEN '" & Format(CDate(tbFromdate.SelectedDate), "yyyy-MM-dd") & "' AND '" & Format(CDate(tbToDate.SelectedDate), "yyyy-MM-dd") & "'"
        End If

        ' ServiceFilter

        If ddlServices.SelectedValue <> vbNullString Then
            s &= " AND ServiceID = " & ddlServices.SelectedValue
        End If


        ' FrameFilter

        If ddlFrames.SelectedValue <> vbNullString Then
            s &= " AND FrameID = " & ddlFrames.SelectedValue
        End If

        ' Status Filter

        If ddlStatus.SelectedValue <> 2 Then
            s &= " AND ISNULL(x.Status,0) = " & ddlStatus.SelectedValue
        End If

        ' WL Filter

        If ddlWL.SelectedValue <> vbNullString Then
            s &= " AND x.WLID = " & ddlWL.SelectedValue
        End If

        'Specific Report filter (Selected value of ddlcolumns is build lik 1,2,3,4,5|xxx is not null, where 1,2,3... are the field id from el.xml (Report section), and the text after the | is specific fdiltrer for theis report

        Dim sRepFilster As String = ddlColumns.SelectedValue
        If Right(sRepFilster, 1) <> "|" Then
            sRepFilster = Mid(sRepFilster, InStr(sRepFilster, "|") + 1)
            s &= " AND " & sRepFilster
        End If
        Return s

    End Function

    Sub BuildReport()
        GridView1.Columns.Clear()
        Dim s As String = ddlColumns.SelectedValue
        s = "," & Left(s, InStr(s, "|") - 1) & ","
        If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
        Dim Query = From q In xEL.Descendants("Column") _
        Select New With { _
            .nam = q.Attribute("Name").Value, _
            .hdr = q.Attribute("Header").Value, _
            .fmt = If(q.Attribute("Format") Is Nothing, vbNullString, q.Attribute("Format").Value), _
            .wrp = If(q.Attribute("Wrap") Is Nothing, vbNullString, q.Attribute("Wrap").Value), _
            .n = q.Attribute("n").Value}

        For Each q In Query
            If InStr(s, "," & q.n & ",") > 0 Or s = ",*," Then
                Dim bf As New BoundField
                bf.DataField = q.nam
                bf.DataFormatString = q.fmt
                bf.HeaderText = q.hdr
                GridView1.Columns.Add(bf)
            End If
        Next
    End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        doExcel("Rep.xls", lblhdr, GridView1)
    End Sub
  
    Protected Sub lblDate_PreRender(sender As Object, e As System.EventArgs) Handles lblDate.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Format(Now(), "dd/MM/yyyy")
    End Sub

    Protected Sub lblUsername_PreRender(sender As Object, e As System.EventArgs) Handles lblUsername.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Text = Session("UserName")
    End Sub
    Sub doExcel(sF As String, lblhdr As WebControls.Label, gv As GridView)

        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        'frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
        'gv.DataBind()
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click

        'Build Query

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Response.Write(BldQ())
        'Response.End()
        Dim cD As New SqlCommand("SearchQ", dbConnection)
        cD.CommandType = CommandType.StoredProcedure

        cD.Parameters.AddWithValue("@sql", BldQ())
        cD.Parameters.AddWithValue("@BFLD", "FirstName + ' ' + LastName + ' ' + Cast(EmpID as varchar(10)) + ' ' + FrameName + ' ' + ServiceName")
        cD.Parameters.AddWithValue("@RowID", "RowID")
        cD.Parameters.AddWithValue("@Srch", tbSearch.Text)

        dbConnection.Open()

        Dim da As New SqlDataAdapter(cD)
        Dim dt As New DataTable()


        'Build Report

        BuildReport()

        'Fill Report

        da.Fill(dt)
        GridView1.DataSource = dt
        GridView1.DataBind()
        dbConnection.Close()

    End Sub

    Protected Sub ddlColumns_PreRender(sender As Object, e As System.EventArgs) Handles ddlColumns.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            If xEL Is Nothing Then xEL = XElement.Load(MapPath("App_Data/EL.xml"))
            Dim Query = From q In xEL.Descendants("RepColumns") _
            Select New With { _
                .nam = q.Attribute("name").Value, _
                .val = q.Value, _
                .fltr = If(q.Attribute("filter") Is Nothing, vbNullString, q.Attribute("filter").Value)}

            For Each l In Query
                Dim li As New ListItem(l.nam, l.val & "|" & l.fltr)
                ddl.Items.Add(li)
            Next
        End If

    End Sub
End Class
