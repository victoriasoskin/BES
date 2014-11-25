Imports System.Data.SqlClient
Partial Class Controls_SelectFrame
    Inherits System.Web.UI.UserControl
    Private _SelectedFrame As String ' Root Caategry ID
    Public Property SelectedFrame() As String
        Get
            If _SelectedFrame = vbNullString Then _SelectedFrame = ViewState(Me.ID & "SelectedFrame")
            Return _SelectedFrame
        End Get
        Set(ByVal Value As String)
            _SelectedFrame = Value
            ViewState(Me.ID & "SelectedFrame") = Value
        End Set
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("FrameID") Is Nothing Then
            zzzlblFrame.Visible = False
            tdd.Visible = True
            Dim s As String = "(Select 1000000+ServiceID as CategoryID,ServiceName As Name,1 As Parent " & _
                            " From ServiceList " & _
                            " Where ServiceID in (Select Distinct ServiceID From framelist " & _
                            " Where FrameID in (Select FrameID From dbo.p0v_UserFrameList Where UserID = " & _
                            Session("UserID") & ")) " & _
                            " UNION ALL  " & _
                            " select 2000000+frameid as CategoryID,Framename As Name,1000000 + ServiceID as parent  " & _
                            " from framelist " & _
                            " Where FrameID in (Select FrameID From dbo.p0v_UserFrameList Where UserID = " & Session("UserID") & "))"
            tdd.TableName = s
            If SelectedFrame IsNot Nothing Then
                Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
                Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                Dim sqlCom As New SqlCommand("Select FrameName From FrameList Where FrameID=" & SelectedFrame, dbConnection)
                dbConnection.Open()

                Dim dr As SqlDataReader = sqlCom.ExecuteReader
                If dr.Read Then
                    tdd.SelectedText = dr("FrameName")
                End If
            End If
        Else
            tdd.Visible = False
            zzzlblFrame.Visible = True
            zzzlblFrame.Text = If(IsDBNull(Session("FrameName")), vbNullString, Session("FrameName"))
            SelectedFrame = Session("FrameID")
            ViewState(Me.ID & "SelectedFrame") = SelectedFrame

        End If

    End Sub
    Protected Sub tdd_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim tdd As TreeView = CType(sender, TreeView)
        SelectedFrame = tdd.SelectedValue Mod 2000000
        ViewState(Me.ID & "SelectedFrame") = SelectedFrame
    End Sub

End Class
