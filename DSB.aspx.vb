Imports System.Drawing
Imports System.Data.SqlClient
Imports PageErrors
Imports eid
Imports System.Xml.Linq

Partial Class DSB
    Inherits System.Web.UI.Page
    Dim bFullScreen As Boolean = True
    Dim xE As XElement
    Dim h As Double
    Dim w As Double

    Protected Sub Page_DataBinding(sender As Object, e As System.EventArgs) Handles Me.DataBinding
        '       chart1.DataBind()
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            If Request.QueryString("width") = vbNullString Then
                Dim sx As String = Request.Url.AbsoluteUri
                If InStr(LCase(sx), ".aspx?") > 0 Then sx = sx & "&" Else sx = sx & "?"
                Dim sScript As String = "<Script langualge=&quot;javascript&quot;>window.open('" & sx & "width=' + document.documentElement.clientWidth + '&height=' + document.documentElement.clientHeight,'_self');</Script>"
                Page.ClientScript.RegisterClientScriptBlock(Me.GetType, "nnn", sScript)
                Exit Sub
            Else
                If Request.QueryString("ID") IsNot Nothing Then
                    tbl.Visible = False
                    solo.Visible = True
                    ph1.ButtonJava = "window.close();"
                    ph1.ButtonText = "סגור"
                    '   btnBack.Visible = True
                    Dim sParam = vbNullString
                    For i = 0 To 20
                        If Request.QueryString("P" & i) IsNot Nothing Then
                            sParam &= i & "=" & Request.QueryString("P" & i) & "|"
                        End If
                    Next
                    solo.ReportID = Request.QueryString("ID")
                    If sParam <> vbNullString Then solo.Params = Left(sParam, sParam.Length - 1)
                    solo.SubReport = If(Request.QueryString("SID") Is Nothing, vbNullString, Request.QueryString("SID"))
                    solo.Height = Request.QueryString("height") - 100
                    solo.Width = Request.QueryString("width") - 20
                    solo.DataBind()
                Else
                    If Session("UserID") Is Nothing Then Response.Redirect("Entry.Aspx")
                    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                    Dim Cd As New SqlCommand("SELECT ISNULL(u.RowID,0) AS RowID,ISNULL(u.ColumnID,0) AS ColumnID,u.RepID,p.ParamID,p.ParamValue FROM AA_UserCharts u LEFT OUTER JOIN AA_UserChartParams p ON p.DsbID=u.ID WHERE u.UserID=" & Session("UserID") & " ORDER BY u.RowID,u.ColumnID,p.ParamID", dbConnection)
                    dbConnection.Open()
                    Dim dr As SqlDataReader = Cd.ExecuteReader
                    Dim i As Integer = 0
                    Dim j As Integer = 0
                    Dim oldi As Integer = 0
                    Dim oldj As Integer = 0
                    Dim iReps(0 To 2, 0 To 3) As Integer
                    Dim sParam(0 To 2, 0 To 3) As String

                    While dr.Read
                        i = dr("RowID")
                        j = dr("ColumnID")
                        If Not IsDBNull(dr("RepID")) Then
                            iReps(i, j) = dr("RepID")
                            If Not IsDBNull(dr("ParamID")) Then
                                sParam(i, j) &= dr("ParamID") & "=" & If(IsDBNull(dr("ParamValue")), vbNullString, dr("ParamValue")) & "|"
                            End If
                        End If
                    End While
                    dr.Close()
                    dbConnection.Close()

                    For i = 1 To 2
                        For j = 1 To 3
                            If iReps(i, j) <> 0 Then
                                Dim chrt As Controls_GChart = FindControlRecursive(Page, "Chart" & i & j)
                                If chrt IsNot Nothing And iReps(i, j) <> 0 Then
                                    chrt.ReportID = iReps(i, j)
                                    If sParam(i, j) <> vbNullString Then
                                        chrt.Params = Left(sParam(i, j), sParam(i, j).Length - 1)
                                    End If
                                    chrt.DataBind()
                                End If
                            End If
                        Next
                    Next
                End If
            End If
        End If
    End Sub
End Class
