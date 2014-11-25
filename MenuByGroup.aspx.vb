
Partial Class Default4
    Inherits System.Web.UI.Page

	Protected Sub ddlg_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlg.SelectedIndexChanged
		Dim ddl As DropDownList = CType(sender, DropDownList)
		If ddl.SelectedIndex > 0 Then
			Menu2.Visible = True
			SiteMapDataSource2.SiteMapProvider = ddl.SelectedValue
			SiteMapDataSource2.DataBind()
		End If
	End Sub

End Class
