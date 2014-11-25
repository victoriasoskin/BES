Imports System.Data.SqlClient
Partial Class CompareSal2Trans
    Inherits System.Web.UI.Page
    Protected Sub ddlgirsa_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlgirsa.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("CP_Version") = ddl.SelectedValue
    End Sub

    Protected Sub ddlgirsa_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlgirsa.DataBound
        If Session("CP_Version") IsNot Nothing Then
            Dim li As ListItem = ddlgirsa.Items.FindByText(Session("CP_Version"))
            If li IsNot Nothing Then
                ddlgirsa.ClearSelection()
                li.Selected = True
            End If
        End If
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        '    Dim btn As Button = CType(sender, Button)
        '    Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        '    Dim hdnQA_T As HiddenField = CType(gvr.FindControl("hdnQA_T"), HiddenField)
        '    Dim hdnQAT_T As HiddenField = CType(gvr.FindControl("hdnQAT_T"), HiddenField)
        '    Dim hdnFID As HiddenField = CType(gvr.FindControl("hdnFID"), HiddenField)
        '    Dim hdnJID As HiddenField = CType(gvr.FindControl("hdnJID"), HiddenField)
        '    Dim hdnQ As HiddenField = CType(gvr.FindControl("hdnQ"), HiddenField)
        '    Dim hdnQT As HiddenField = CType(gvr.FindControl("hdnQT"), HiddenField)
        '    Dim hdnDateB As HiddenField = CType(gvr.FindControl("hdnDateB"), HiddenField)
        '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        '    Dim ConComp As New SqlCommand("Update p1t_MPRep set QA=" & "0" & hdnQA_T.Value & ", QAT = " & "0" & hdnQAT_T.Value & ",diffM= " & CStr(CDbl(hdnQ.Value) - CDbl("0" & hdnQA_T.Value)) & ", diffT = " & CStr(CDbl(hdnQT.Value) - CDbl("0" & hdnQAT_T.Value)) & " Where FrameCategoryID=" & hdnFID.Value & " And JobCategoryID = " & hdnJID.Value & " And DateB = '" & Format(CDate(hdnDateB.Value), "yyyy-MM-dd") & "'", dbConnection)

        '    dbConnection.Open()
        '    ConComp.ExecuteNonQuery()
        '    dbConnection.Close()
        '    GridView1.DataBind()
    End Sub
    Function salparams(ByVal d As DateTime, ByVal f As Integer) As Boolean
        Session("VERSION") = ddlgirsa.SelectedValue
        Session("DATEB") = Format(d, "dd/MM/yyyy" & " 00:00:00")
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim comP As New SqlCommand("Select [שירות_-_1] as service,isnull([שירות_-_3],[שירות_-_2]) as frame From SHERUT_BEsqxl Where CategoryID=" & f, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = comP.ExecuteReader
        If dr.Read Then
            Session("FRAME") = dr("Frame")
            Session("SERVICE") = dr("Service")
            Return True
        Else
            Return False
        End If

    End Function

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim hdnFID As HiddenField = CType(gvr.FindControl("hdnFID"), HiddenField)
        Dim hdnDateB As HiddenField = CType(gvr.FindControl("hdnDateB"), HiddenField)
        If salparams(hdnDateB.Value, hdnFID.Value) Then Response.Redirect("Salary.aspx")
    End Sub
End Class
