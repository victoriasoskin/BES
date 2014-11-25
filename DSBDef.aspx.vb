Imports System.Drawing
Imports System.Data.SqlClient
Imports PageErrors
Imports eid
Imports System.Data
Imports System.Linq
Imports System.Xml.Linq

Partial Class DSBDef
    Inherits System.Web.UI.Page
    Dim xE As XElement
    Dim h As Double
    Dim w As Double

    Protected Sub ddlChrt_Load(sender As Object, e As System.EventArgs) Handles ddlChrt.Load
        Dim ddl As DropDownList = CType(sender, DropDownList)

        If xE Is Nothing Then xE = XElement.Load(HttpContext.Current.Server.MapPath("~/" & solo.XMLDataSource))

        Dim Query = From l In xE.Elements("Chart") _
                    Where l.Attribute("SubID").Value = vbNullString _
                    Select New With { _
                        .id = l.Attribute("ID").Value, _
                        .title = l.Attribute("Title").Value}
        For Each l In Query
            Dim s As String = l.title
        Next

        ddl.DataSource = Query
        ddl.DataBind()

        '' Clear params

        'For Each itm As ListItem In ddl.Items
        '    itm.Text = Regex.Replace(Regex.Replace(Regex.Replace(itm.Text, "[0-9]", "."), "[{]", "."), "[}]", ".")
        'Next

        RemoveDDLDupItems(ddl)
        If Not IsPostBack Then
            LoadInitialChart()
        End If

    End Sub

    Protected Sub btnSHow_Click(sender As Object, e As System.EventArgs) Handles btnShow.Click
        Dim sParams As String = vbNullString
        For i = 0 To 5
            Dim ddl As DropDownList = FindControlRecursive(Page, "ddlp" & i)
            If ddl IsNot Nothing AndAlso ddl.Visible Then
                sParams &= i & "=" & ddl.SelectedValue & "|"
            End If
        Next
        Try
            If ddlChrt.SelectedValue IsNot Nothing Then
                solo.ReportID = "0" & ddlChrt.SelectedValue
                If sParams IsNot Nothing Then
                    If sParams.Length > 0 Then solo.Params = Left(sParams, sParams.Length - 1)
                    solo.DataBind()
                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        If IsNumeric(ddlChrt.SelectedValue) Then
            Dim sSql As String = "BEGIN TRANSACTION" & vbCrLf & _
                "BEGIN TRY" & vbCrLf & _
                "DECLARE @Id int" & vbCrLf & _
                "SELECT @Id = Id FROM  AA_UserCharts WHERE UserID = " & Session("UserID") & " AND RowID = " & Request.QueryString("R") & " AND ColumnID = " & Request.QueryString("C") & vbCrLf & _
                "IF @Id IS NOT NULL" & vbCrLf & _
                "BEGIN" & vbCrLf & _
                "   DELETE FROM AA_UserCharts WHERE ID = @Id" & vbCrLf & _
                "   DELETE FROM AA_UserChartParams WHERE DsbId=@Id" & vbCrLf & _
                "END" & vbCrLf & _
                "INSERT AA_UserCharts(UserID,RowID,ColumnID,RepID) VALUES(" & Session("UserID") & "," & Request.QueryString("R") & "," & Request.QueryString("C") & "," & ddlChrt.SelectedValue & ")" & vbCrLf & _
                "SELECT TOP 1 @Id = Id FROM AA_UserCharts WHERE UserID=" & Session("UserID") & " AND RowID=" & Request.QueryString("R") & " AND ColumnID=" & Request.QueryString("C") & " AND RepID =" & ddlChrt.SelectedValue & vbCrLf

            For i = 0 To 5
                Dim ddl As DropDownList = FindControlRecursive(Page, "ddlp" & i)
                If ddl IsNot Nothing Then
                    If ddl.Visible Then
                        sSql &= "INSERT AA_UserChartParams(DsbID,ParamID,ParamValue) VALUES(@Id," & i & "," & If(ddl.SelectedValue = vbNullString, "NULL", "'" & ddl.SelectedValue.Replace("'", "''") & "'") & ")"
                    End If
                End If
            Next

            sSql &= "COMMIT TRANSACTION" & vbCrLf & _
                "SELECT 1 AS ReturnValue" & vbCrLf & _
                "END TRY" & vbCrLf & _
                "BEGIN CATCH" & vbCrLf & _
                "ROLLBACK TRANSACTION" & vbCrLf & _
                "SELECT 0 AS ReturnValue" & vbCrLf & _
                "END CATCH"
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim Cd As New SqlCommand(sSql, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = Cd.ExecuteReader
            Dim bSuccess As Boolean = True
            If dr.Read Then
                bSuccess = dr(0) <> 0
            End If
            dbConnection.Close()
            If bSuccess Then
                Response.Redirect("Dsb.Aspx")
            Else
                lblErr.Visible = True
            End If
        End If
    End Sub
    Protected Sub Page_DataBinding(sender As Object, e As System.EventArgs) Handles Me.DataBinding
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim Cd As New SqlCommand(vbNullString, dbConnection)
        If xE Is Nothing Then xE = XElement.Load(HttpContext.Current.Server.MapPath("~/" & solo.XMLDataSource))
        dbConnection.Open()
        If ddlChrt.SelectedValue IsNot Nothing Then
            Dim Query = From l In xE.Descendants("Param") _
                       Where l.Parent.Parent.Attribute("ID").Value = ddlChrt.SelectedValue And l.Parent.Parent.Attribute("SubID").Value = vbNullString _
                       Select New With { _
                           .q = l.Value, _
                           .hdr = l.Attribute("hdr").Value, _
                           .id = l.Attribute("ID").Value}

            For Each l In Query
                Dim lbl As Label = FindControlRecursive(Page, "lblp" & l.id)
                If lbl IsNot Nothing Then
                    lbl.Visible = True
                    lbl.Text = l.hdr
                End If
                Dim ddl As DropDownList = FindControlRecursive(Page, "ddlp" & l.id)
                If ddl IsNot Nothing Then
                    ddl.Visible = True
                    Cd.CommandText = l.q
                    Dim da As New SqlDataAdapter
                    Dim dt As New DataTable
                    da.SelectCommand = Cd
                    da.Fill(dt)
                    ddl.DataSource = dt
                    ddl.DataBind()
                    da.Dispose()
                    dt.Dispose()
                End If
            Next
            dbConnection.Close()

        End If
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        If Not (IsNumeric(Request.QueryString("R")) And IsNumeric(Request.QueryString("C"))) Then
            Response.Redirect("Default.aspx")
        End If
        Dim lbl As Label = FindControlRecursive(Page, "lbl" & Request.QueryString("R") & Request.QueryString("C"))
        If lbl IsNot Nothing Then
            lbl.ForeColor = Color.Blue
            lbl.BackColor = Color.Yellow
        End If
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ddlChrt_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlChrt.SelectedIndexChanged
        For i = 0 To 5
            Dim ddl As DropDownList = FindControlRecursive(Page, "ddlp" & i)
            If ddl IsNot Nothing Then ddl.Visible = False
            Dim lbl As Label = FindControlRecursive(Page, "lblp" & i)
            If lbl IsNot Nothing Then lbl.Visible = False
        Next

        Page.DataBind()
    End Sub
    Sub LoadInitialChart()
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim Cd As New SqlCommand(vbNullString, dbConnection)
        Dim sSql As String = "SELECT u.RepID,ISNULL(p.ParamID,0) ParamID,ISNULL(p.ParamValue,0) ParamValue" & vbCrLf & _
            "FROM AA_UserCharts u" & vbCrLf & _
            "LEFT OUTER JOIN AA_UserChartParams p ON p.DsbID=u.ID" & vbCrLf & _
            "WHERE (UserID = " & Session("UserID") & " AND RowID = " & Request.QueryString("R") & " AND ColumnID = " & Request.QueryString("C") & ")"
        Cd.CommandText = sSql
        Dim li As ListItem
        dbConnection.Open()
        Dim dr As SqlDataReader = Cd.ExecuteReader
        Dim bFirstTime As Boolean = True
        While dr.Read
            If bFirstTime Then
                Dim RepID As String = dr("RepID")
                li = ddlChrt.Items.FindByValue(RepID)
                If li IsNot Nothing Then
                    ddlChrt.ClearSelection()
                    li.Selected = True
                    ddlChrt_SelectedIndexChanged(ddlChrt, Nothing)
                End If
                bFirstTime = False
            End If
            Dim sID As String = dr("ParamID")
            Dim ddl As DropDownList = FindControlRecursive(Page, "ddlp" & sID)
            If ddl IsNot Nothing Then
                li = ddl.Items.FindByValue(dr("ParamValue"))
                If li IsNot Nothing Then
                    li.Selected = True
                End If
            End If
        End While
        dr.Close()
        dbConnection.Close()
        If Not bFirstTime Then btnSHow_Click(btnShow, Nothing)
    End Sub
    Shared Sub RemoveDDLDupItems(ByRef ddl As DropDownList)
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

End Class
