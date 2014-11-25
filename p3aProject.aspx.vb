Imports System.Data.SqlClient
Partial Class p3a_Project
    Inherits System.Web.UI.Page
    Dim iLastRoot As Integer
    Dim iCurrentRoot As Integer
    Protected Sub DVAddproj_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVAddproj.Load
        Dim dv As DetailsView = CType(sender, DetailsView)
        If IsPostBack Then
            dv.DefaultMode = DetailsViewMode.ReadOnly
        End If
    End Sub

    Protected Sub DVAddproj_ItemInserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DetailsViewInsertedEventArgs) Handles DVAddproj.ItemInserted
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim ConComp As New SqlCommand("select max(ProjID) as projID From p3t_projectsHeaders", dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        Dim i As Integer = dr.Item("projID")
        Session("ProjID") = i
        HDNPID.Value = i
        dr.Close()
        dbConnection.Close()
    End Sub
    Protected Sub DDLF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim s As String = Mid(ddl.ID, 5)
        ddl.SelectedValue = Session("UAD_" & s)
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        DVNewRow.Visible = True
    End Sub
    Protected Sub LinkButton1_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        DVNewRow.Visible = False
    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        DVNewRow.Visible = True
    End Sub

    Protected Sub DSRows_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSRows.Updated
        DVNewRow.Visible = True
    End Sub

    Protected Sub DSRows_Inserting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSRows.Inserting
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim i As Integer = HDNPID.Value
        Dim ConComp As New SqlCommand("select max(isnull(RowOrder,0)) as RowOrder From p3t_projRows Where projID=" & i, dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        i = dr.Item("RowOrder")
        If Err.Number <> 0 Then
            Err.Clear()
            i = 0
        End If
        dr.Close()
        dbConnection.Close()
        DSRows.InsertParameters.Clear()
        DSRows.InsertParameters("RowOrder").DefaultValue = i + 1
    End Sub

    Protected Sub LBLROWORD_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        On Error Resume Next
        Dim i As Integer
        If Err.Number <> 0 Then
            Err.Clear()
            i = 0
        Else
            i = HDNPID.Value
        End If
        Dim ConComp As New SqlCommand("select max(isnull(RowOrder,0)) as RowOrder From p3t_projRows Where projID=" & i, dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        i = dr.Item("RowOrder")
        If Err.Number <> 0 Then
            Err.Clear()
            i = 0
        End If
        dr.Close()
        dbConnection.Close()
        lbl.Text = i + 1
    End Sub

    Protected Sub LNKBUP_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        MoveRow(lnkb)
    End Sub
    Sub MoveRow(ByVal lnkb As LinkButton)
        Dim gvr As GridViewRow = CType(lnkb.NamingContainer, GridViewRow)
        Dim gv As GridView = CType(gvr.NamingContainer, GridView)
        Dim lbl As Label = CType(gvr.FindControl("lblroword"), Label)
        Dim iOrd As Integer = CType(lbl.Text, Integer)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNRid"), HiddenField)
        Dim iRid As Integer = CType(hdn.Value, Integer)
        Dim ilim As Integer
        Dim iinc As Integer
        Dim b As Boolean
        If LCase(lnkb.ID) = "lnkbup" Then
            ilim = 1
            iinc = -1
            b = iOrd + iinc >= ilim
        Else
            iinc = 1
            ilim = gv.Rows.Count + 1
            b = iOrd + iinc < ilim
        End If
        If b Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            dbConnection.Open()
            Dim i As Integer
            Dim ConComp As New SqlCommand("update p3t_projRows set RowOrder=" & iOrd + iinc & " Where ROwID=" & iRid, dbConnection)
            ConComp.CommandType = Data.CommandType.Text
            ConComp.ExecuteNonQuery()
            i = gvr.RowIndex
            gvr = CType(gv.Rows(i + iinc), GridViewRow)
            hdn = CType(gvr.FindControl("HDNRid"), HiddenField)
            iRid = hdn.Value
            Dim ConComp1 As New SqlCommand("update p3t_projRows set RowOrder=" & iOrd & " Where ROwID=" & iRid, dbConnection)
            ConComp1.CommandType = Data.CommandType.Text
            ConComp1.ExecuteNonQuery()
            dbConnection.Close()
            gv.DataBind()
        End If
    End Sub

    Protected Sub LNKBDOWN_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        MoveRow(lnkb)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim i As Integer
        On Error Resume Next
        i = Request.QueryString("ProjID")
        If i <> 0 Then
            HDNPID.Value = i
            Session("ProjID") = i
            DVAddproj.DefaultMode = DetailsViewMode.ReadOnly
            LBLHDR.Text = "הצגת מצב פרויקט"
            DVAddproj.HeaderText = "כותרת הפרויקט"
            Page.Title = "מעקב אחזקה - הצגת מצב פרויקט"
            LNKBBACK.Visible = True
            If Session("SType") <> "MAINT" Then
                DVNewRow.Visible = False
                LNKBNEWFB.Visible = True
            End If
        End If
    End Sub

    Protected Sub LNKB_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        If Session("SType") <> "MAINT" Then
            lnkb.Visible = False
        End If
    End Sub

    Protected Sub LNKBNEWFB_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LNKBNEWFB.Click
        Dim lbl As Label = CType(DVAddproj.FindControl("LBLProjName"), Label)
        Dim sName As String = lbl.Text
        Dim i As Integer = HDNPID.Value
        Response.Redirect("~/p3aFeedBack.aspx?ProjID=" & i & "&ProjName=" & sName & "&RootID=0")
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim lbl As Label = CType(gvr.FindControl("LBLFBT"), Label)
        Dim b As Boolean = btn.Text = "+"
        lbl.Visible = b
        If b Then btn.Text = "-" Else btn.Text = "+"
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim b As Boolean = cb.Checked
        Dim gvr As GridViewRow = CType(cb.NamingContainer, GridViewRow)
        Dim hdn As HiddenField = CType(gvr.FindControl("HDNFBID"), HiddenField)
        Dim ifbid As Integer = hdn.Value
        FBRead(b, ifbid)
    End Sub
    Sub FBRead(ByVal b As Boolean, ByVal ifbid As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        dbConnection.Open()
        Dim ConComp As New SqlCommand("update p3t_Feedback set FBRead=" & CInt(b) & " Where FBID=" & ifbid, dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
    End Sub

    Protected Sub CheckBox1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        '    Dim cb As CheckBox = CType(sender, CheckBox)
        '    Dim gvr As GridViewRow = CType(cb.NamingContainer, GridViewRow)
        '    Dim hdb As HiddenField = CType(gvr.FindControl("HDNUserID"), HiddenField)
        '    If HDNPID.Value = Session("userid") Then
        '        cb.Enabled = False
        '    End If
    End Sub

    Protected Sub LinkButton4_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim lnkb As LinkButton = CType(sender, LinkButton)
        'Dim gvr As GridViewRow = CType(lnkb.NamingContainer, GridViewRow)
        'Dim hdn As HiddenField = CType(gvr.FindControl("HDNFBID"), HiddenField)
        'Dim i As Integer = hdn.Value
        'Response.Redirect("`/p3aProject.aspx?FBID=" & i)
    End Sub

    Protected Sub LinkButton1_Click2(ByVal sender As Object, ByVal e As System.EventArgs)
        DVNewRow.Visible = False
    End Sub

    Protected Sub LinkButton1_Click3(ByVal sender As Object, ByVal e As System.EventArgs)
        DVNewRow.Visible = True
    End Sub

    Protected Sub LinkButton2_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub DSprojHeaders_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles DSprojHeaders.Updated
        DVNewRow.Visible = True
    End Sub

    Protected Sub LNKBBACK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LNKBBACK.Click
        Response.Redirect("~/p3aProjRep.aspx")
    End Sub
End Class
