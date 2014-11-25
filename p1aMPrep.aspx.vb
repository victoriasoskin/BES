Imports System.Data.SqlClient
Partial Class Default6
    Inherits System.Web.UI.Page
    Dim xTot(0 To 6) As Double
    Function sVal(ByVal fn As String, ByVal fs As String, ByVal i As Integer) As String
        xTot(i) += Eval(fn)
        Return Format(CDbl(Eval(fn)), fs)
    End Function
    Function sTot(ByVal fs As String, ByVal i As Integer) As String
        Return Format(xTot(i), fs)
    End Function
    Function fColor(ByRef fs As String) As Drawing.Color
        If Eval(fs) < 0 Then
            Return Drawing.Color.Red
        End If
    End Function
    Function tColor(ByVal i As Integer) As Drawing.Color
        If xTot(i) < 0 Then
            Return Drawing.Color.Red
        End If
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        ' On Error Resume Next
        Dim iReptype As Integer = 3
        Dim iFFid As Integer
        Dim sFrameName As String
        On Error Resume Next
        Dim iFID As Integer = Session("FrameID")
        If Err.Number <> 0 Then
            Err.Clear()
            iFID = 0
        End If
        If iFID <> 0 Then
            Dim ConComp As New SqlCommand("Select CategoryID,FrameName From p0v_CoordFrames Where SherutFrameID=" & iFID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            iFFid = dr("CategoryID")
            sFrameName = dr("FrameName")
            DDLFRAME.Visible = False
            DDLSERVICES.Visible = False
            LBLFRAMENAME.Text = sFrameName
            HDNFrameID.Value = iFFid
            dr.Close()
        End If
        Dim isID As Integer = Session("ServiceID")
        If Err.Number <> 0 Then
            Err.Clear()
            isID = 0
        End If
        If isID <> 0 Then
            Dim ConComp As New SqlCommand("Select FinanceServiceID From p0t_CoordServieID Where SherutServiceID=" & iSID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            iFFid = dr("FinanceServiceID")
            HDNServiceID.Value = iSid
            dr.Close()
        End If
        If iFFid = 0 Then
            On Error Resume Next
            iFFid = DDLFRAME.SelectedValue
            If Err.Number <> 0 Then
                Err.Clear()
                iFFid = 0
            End If
        End If
        Dim s As String = "SELECT     COUNT(dbo.p4t_DontShowRep.RowID) AS cnt"
        s = s & " FROM         dbo.SHERUT_besqxl RIGHT OUTER JOIN"
        s = s & " dbo.p0t_CoordFrameID ON dbo.SHERUT_besqxl.CategoryID = dbo.p0t_CoordFrameID.FinanceFrameID RIGHT OUTER JOIN"
        s = s & "dbo.p4t_DontShowRep ON dbo.p0t_CoordFrameID.SherutFrameID = dbo.p4t_DontShowRep.FrameID"
        's = s & " WHERE     (dbo.p4t_DontShowRep.RepTypeID =" & iReptype & ") AND (ISNULL(dbo.SHERUT_besqxl.[שירות_-_3], dbo.SHERUT_besqxl.[שירות_-_2])='" & sFrameName & "')"
        s = s & " WHERE     (dbo.p4t_DontShowRep.RepTypeID =3) AND (ISNULL(dbo.SHERUT_besqxl.[שירות_-_3], dbo.SHERUT_besqxl.[שירות_-_2])='מעון כרמל')"

        Dim ConCompX As New SqlCommand(s, dbConnection)
        Dim drX As SqlDataReader = ConCompX.ExecuteReader()
        drX.Read()
        'On Error Resume Next
        Dim i As Integer = drX("cnt")
        drX.Close()
        dbConnection.Close()
        If i > 0 Then
            Response.Redirect("p3aDontShowMessage.aspx")
        End If

    End Sub

    Protected Sub DDLFROM_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLWY.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.ClearSelection()
        Dim d As DateTime = Session("DateS")
        Dim lm As ListItem = ddl.Items.FindByValue(Session("DateS"))
        If Not lm Is Nothing Then lm.Selected = True

    End Sub

    Protected Sub DDLTO_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLTO.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.ClearSelection()
        Dim lm As ListItem = ddl.Items.FindByValue(Session("DateB"))
        If Not lm Is Nothing Then lm.Selected = True

    End Sub

    Protected Sub DDLFRAME_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFRAME.DataBound
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.ClearSelection()
        Dim lm As ListItem = ddl.Items.FindByText(Session("Frame"))
        If Not lm Is Nothing Then lm.Selected = True
    End Sub
End Class
