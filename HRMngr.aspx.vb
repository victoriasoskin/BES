Imports System.Data.SqlClient
Imports UtilVB

Imports PageErrors
Partial Class HRMngr
    Inherits System.Web.UI.Page


    Function Elink() As String
        Dim s As String = vbNullString
        s = "HRMngr.Aspx" & If(Request.QueryString("F") = "2", "?F=2", vbNullString) & If(Request.QueryString("M") = "2", "&M=2", vbNullString)
        s = "javascript: window.open('HREmpList.aspx', '_blank', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=750,width=875');window.open('" & s & "','_self');"
        Return s
    End Function
    Function Flink(Optional ev As Integer = 0) As String
        Dim s As String = vbNullString
        Dim s1 As String = vbNullString
        If Not IsDBNull(Eval("EmployeeID")) Then
            s = "HRMngr.Aspx" & If(Request.QueryString("F") = "2", "?F=2", vbNullString) & If(Request.QueryString("M") = "2", "&M=2", vbNullString)
            s1 = "javascript: window.open('FormEditor.aspx?"
            If ev <> 0 Then
                s1 &= "ID=" & ev & "&B=" & s & "', '_self')"
            Else
                s1 &= "E=" & Eval("EmployeeID") & "&U=" & Session("UserID") & "&B=" & s & "', '_self')" ', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=750,width=825');window.open('" & s & "','_self');"
            End If
        End If
        Return s1
    End Function
    Function Tlink() As String
        Dim s As String = vbNullString
        If Not IsDBNull(Eval("EmployeeID")) Then
            s = "HRMngr.Aspx" & If(Request.QueryString("F") = "2", "?F=2", vbNullString) & If(Request.QueryString("M") = "2", "&M=2", vbNullString)
            Return "javascript: window.open('Tree.aspx?T=" & If(Eval("EmployeeID") = 57163412, "5", "4") & "&E=" & Eval("EmployeeID") & "&F=" & Eval("FrameID") & "', '_blank', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=750,width=825');window.open('" & s & "','_self');"
        End If
        Return s
    End Function

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        '  If Not IsNumeric(Session("UserID")) Then Response.Redirect("Entry.aspx")
        If Request.QueryString("f") = "2" Then
            btnEmpList.Visible = True
            LVTREE.Visible = True
        Else
            Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim cD As New SqlCommand("SELECT CASE WHEN EXISTS(SELECT * FROM HR_Hierarchy WHERE ParentID IN (SELECT EmployeeID FROM p0t_NtB WHERE UserID=0" & Session("UserID") & ")) THEN 0 ELSE 1 END b", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                If dr("b") = 1 Then
                    dr.Close()
                    dbConnection.Close()
                    Response.Redirect("Default.aspx")
                End If
            Else
                dr.Close()
                dbConnection.Close()
                Response.Redirect("Default.aspx")
            End If
            dr.Close()
            dbConnection.Close()
        End If
        If Request.QueryString("M") = "2" Then
            lblMissingID.Visible = True
            lvMissingID.Visible = True
        End If
    End Sub

    Protected Sub btnEmpList_PreRender(sender As Object, e As System.EventArgs) Handles btnEmpList.PreRender
        btnEmpList.PostBackUrl = Elink()
    End Sub

    Protected Sub LVEMPS_PreRender(sender As Object, e As EventArgs)
        Dim u As New UtilVB()
        Dim b As Integer = u.selectDBScalar("select case when exists(select * from book10.dbo.hr_Periods where getdate() between startDate and EndDate ) then 1 else 0 end")
        Dim lv As ListView = CType(sender, ListView)
        lv.Visible = b = 1

    End Sub
End Class
