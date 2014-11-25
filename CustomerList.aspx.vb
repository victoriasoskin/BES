Imports System.Data.SqlClient
Imports PageErrors
Imports System.IO

Partial Class Default2
    Inherits System.Web.UI.Page
    Protected Sub GVCustomersList_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridView = CType(sender, GridView)
        Dim gvr As GridViewRow
        Dim LidO As Long = 0
        Dim i As Integer

        For Each gvr In gv.Rows
            Dim lnkb As Button = CType(gvr.FindControl("LNKBID"), Button)
            If CLng(lnkb.Text) = LidO Then
                For i = 0 To gvr.Cells.Count - 3
                    gvr.Cells(i).Enabled = False
                Next
            End If
            LidO = CLng(lnkb.Text)
        Next
    End Sub
    Public Function TruncField(ByVal sfn As String, ByVal i As Integer) As String
        Dim s As String = Eval(sfn) & ""
        If Len(s) > i - 3 Then
            Return (Left(s, i - 3) & "...")
        Else
            Return (s)
        End If
    End Function

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub LNKBID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As Button = CType(sender, Button)
        Session("lastCustID") = lnkb.Text
        Response.Redirect("CustEventReport.aspx")
    End Sub

    Protected Sub DDLFRAMES_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFrames.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            If Session("FrameID") IsNot Nothing Then
                If Not IsDBNull(Session("FrameID")) Then
                    Dim lm As ListItem = ddl.Items.FindByValue(Session("FrameID"))
                    If Not lm Is Nothing Then
                        ddl.ClearSelection()
                        lm.Selected = True
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub DDLServices_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlServices.PreRender
        If Not IsPostBack Then
            Dim ddl As DropDownList = CType(sender, DropDownList)
            If Session("ServiceID") IsNot Nothing Then
                If Not IsDBNull(Session("ServiceID")) Then
                    Dim lm As ListItem = ddl.Items.FindByValue(Session("ServiceID"))
                    If Not lm Is Nothing Then
                        ddl.ClearSelection()
                        lm.Selected = True
                    End If
                End If
            End If
        End If
    End Sub

    Protected Sub DSCustomers_Selecting(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSCustomers.Selecting, DSTOTCNT.Selecting
        If Session("FrameID") Is Nothing Then
            If ddlFrames.SelectedValue <> vbNullString Then
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim ConComp As New SqlCommand("Select UserID From p0t_NtB Where FrameID=" & ddlFrames.SelectedValue & " AND UserGroupID = 6", dbConnection)
                dbConnection.Open()
                Dim dr As SqlDataReader = ConComp.ExecuteReader()
                If dr.Read() Then
                    e.Command.Parameters("@UserID").Value = dr("UserID")
                End If
                dbConnection.Close()
            End If
        End If
    End Sub
#Region "Excel"
    Sub doExcel(sF As String, gv As GridView)
        gv.Columns(0).Visible = False
        gv.Columns(1).Visible = False
        gv.Columns(2).Visible = False
        For Each gvr As GridViewRow In gv.Rows
            Dim btn As Button = CType(gvr.FindControl("LNKBID"), Button)
            If btn IsNot Nothing Then
                gvr.Cells(3).Text = btn.Text
                btn.Visible = False
            End If
        Next
        Dim tw As New StringWriter()
        Dim hw As New System.Web.UI.HtmlTextWriter(tw)
        Dim frm As HtmlForm = New HtmlForm()
        Response.ContentType = "application/vnd.ms-excel"
        Response.AddHeader("content-disposition", "attachment;filename=" & sF)
        Response.Charset = ""
        EnableViewState = False
        Controls.Add(frm)
        lblhdr.Text = "<span style=""font-size:Large;"">רשימת לקוחות</span><br />" & ViewState("lblhdr")
        frm.Controls.Add(lblhdr)
        frm.Controls.Add(gv)
        frm.RenderControl(hw)
        Response.Write(tw.ToString())
        Response.End()
    End Sub
#End Region

    Protected Sub btnExcel_Click(sender As Object, e As System.EventArgs) Handles btnExcel.Click
        doExcel("Rep.xls", GVCustomersList)
    End Sub
End Class
