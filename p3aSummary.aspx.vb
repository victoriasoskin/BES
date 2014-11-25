Imports System.Data.SqlClient
Partial Class p3aSummary
    Inherits System.Web.UI.Page
    Dim xTot(0 To 6) As Double
    Function sVal(ByVal fn As String, ByVal fs As String, ByVal i As Integer) As String
        xTot(i) += Eval(fn)
        Return Format(CDbl(Eval(fn)), fs)
    End Function
    Function sTot(ByVal fs As String, ByVal i As Integer) As String
        Return Format(xTot(i), fs)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        On Error Resume Next
        LBLTODAY.Text = Format(Now(), "dd/MM/yy")
        Dim iFID As Integer = Session("FrameID")
        If Err.Number <> 0 Then
            Err.Clear()
            iFID = 0
        End If
        If iFID <> 0 Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select CategoryID,FrameName From p0v_CoordFrames Where FrameID=" & iFID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            Dim iFFid As Integer = dr("CategoryID")
            Dim sFrameName As String = dr("FrameName")
            DDLFRAME.Visible = False
            DDLSERVICES.Visible = False
            LBLFRAMENAME.Text = sFrameName
            HDNFrameID.Value = iFFid
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
