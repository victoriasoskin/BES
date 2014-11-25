Imports System
Imports System.Data.SqlClient
Imports System.Data
Class TreeDropDown
    Inherits System.Web.UI.UserControl
    'Dim ta As DataTable
    Dim cPath As New Collection
    Protected Sub zzzbtnshowtree_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles zzzbtnshowtree.Click
        PShowTree()
    End Sub
    Sub PShowTree()

        If zzztvDropDown.Visible = True And zzztvDropDown.Nodes.Count > 0 Then
            zzztvDropDown.Visible = False
            zzzlblCurrentSelectionText.Visible = True
            If zzztvDropDown.SelectedNode IsNot Nothing Then
                SelectedText = zzztvDropDown.SelectedNode.Text
                SelectedValue = zzztvDropDown.SelectedNode.Value
            End If
            Exit Sub
        End If

        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStrName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlCom As New SqlCommand("", dbConnection)
        zzztvDropDown.Visible = True
        zzzlblCurrentSelectionText.Visible = False

        ' Get Depth if filtering

        If LCase(ValueType()) = "filter" Then GetDepth()

        ' '' ''If Not IsNumeric(zzzhdnDepth.Value) Then
        ' '' ''    Dim s As String = "Select " & CategoryID() & "," & ParentID() & ",NULL as Depth into #Temp From " & TableName() _
        ' '' ''      & " update #Temp set Depth=0 where " & ParentID & "=0 " _
        ' '' ''      & " WHILE EXISTS (SELECT * FROM #Temp WHERE Depth Is Null) " _
        ' '' ''      & " UPDATE T SET T.depth = P.Depth + 1 " _
        ' '' ''      & " FROM #Temp AS T " _
        ' '' ''      & " INNER JOIN #Temp AS P ON (T." & ParentID() & " = P." & CategoryID() & ")" _
        ' '' ''      & " WHERE(P.Depth >= 0)" _
        ' '' ''      & " AND T.Depth Is Null " _
        ' '' ''      & " Select MAX(Depth) as Depth From #Temp " _
        ' '' ''      & " Drop Table #Temp"
        ' '' ''    dbConnection.Open()
        ' '' ''    sqlCom.CommandText = s
        ' '' ''    Dim dr As SqlDataReader = sqlCom.ExecuteReader
        ' '' ''    If dr.Read Then
        ' '' ''        zzzhdnDepth.Value = dr("Depth")
        ' '' ''        zzzlblCurrentSelectionText.Text = dr("depth")
        ' '' ''    End If
        ' '' ''    dr.Read()
        ' '' ''    dbConnection.Close()
        ' '' ''End If

        '' '' '' Make Label of selecedvalue invisible and load the top level of the tree
        ' '' ''Depth = zzzhdnDepth.Value

        zzzlblCurrentSelectionText.Visible = False
        zzzlblCurrentSelectionText.Enabled = True
        PopulateRootLevel()

        ' Select And Show SelectedValue

        If SelectedValue <> vbNullString Then
            Dim sPath As String = vbNullString
            BPath(SelectedValue)
            For i As Integer = cPath.Count To 1 Step -1
                sPath = sPath & "/" & cPath(i)
                Dim n As TreeNode = zzztvDropDown.FindNode(Mid(sPath, 2))
                If n IsNot Nothing Then
                    If i > 1 Then
                        n.Expand()
                    Else
                        n.Selected = True
                        SelectedValue = n.Value
                        SelectedText = n.Text
                    End If
                End If
            Next
        End If

    End Sub
    Sub BPath(ByVal sN As String)
        If sN <> RootCategoryID() Then
            cPath.Add(sN)
            Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStrName).ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim sqlCom As New SqlCommand("Select " & ParentID() & " From " & TableName() & " As x Where " & CategoryID() & "=" & sN, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = sqlCom.ExecuteReader
            If dr.Read Then
                Dim sx As String = dr(ParentID())
                If sx <> RootCategoryID Then
                    dr.Close()
                    dbConnection.Close()
                    BPath(sx)
                End If
                dr.Close()
                dbConnection.Close()
            End If
            dr.Close()
            dbConnection.Close()
        End If
    End Sub
    Private Sub PopulateRootLevel()
        zzztvDropDown.Nodes.Clear()
        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStrName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim objCommand As New SqlCommand("select " & CategoryID() & " As CategoryID," & TextField() & " as title,(select count(*) FROM " & TableName() & " As x " _
    & " WHERE " & ParentID() & " = y." & CategoryID() & ") As childnodecount FROM " & TableName() & " As y where " & ParentID() & " = " & RootCategoryID() & _
    If(AdditionalFilter = vbNullString, vbNullString, " And " & AdditionalFilter) & If(itemOrder() Is Nothing, vbNullString, " ORDER BY " & itemOrder()) _
    , dbConnection)

        Dim da As New SqlDataAdapter(objCommand)
        Dim dt As New DataTable()
        da.Fill(dt)

        ' Add Default Node

        If DeleteClassText <> vbNullString Then
            Dim tn As New TreeNode()
            tn.Text = DeleteClassText()
            tn.Value = -2
            zzztvDropDown.Nodes.Add(tn)
            tn = Nothing
            tn = New TreeNode()
            tn.Text = "[לא שייך]"
            tn.Value = -1
            zzztvDropDown.Nodes.Add(tn)

        End If

        PopulateNodes(dt, zzztvDropDown.Nodes)
    End Sub
    Private Sub PopulateNodes(ByVal dt As DataTable, _
     ByVal nodes As TreeNodeCollection)

        For Each dr As DataRow In dt.Rows
            Dim tn As New TreeNode()
            tn.Text = dr("title").ToString()
            tn.Value = dr("CategoryID").ToString()
            nodes.Add(tn)

            'If node has child nodes, then enable on-demand populating
            tn.PopulateOnDemand = (CInt(dr("childnodecount")) > 0)
        Next
    End Sub
    Private Sub PopulateSubLevel(ByVal pid As Integer, _
     ByVal parentNode As TreeNode)
        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStrName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        'Dim objCommand As New SqlCommand("select CategoryID,title,(select count(*) FROM Survey_Profiles " _
        '  & "WHERE parentid=sc.Categoryid  AND SurveyID=@SurveyID) as childnodecount FROM Survey_Profiles As sc where parentID=@parentID AND SurveyID=@SurveyID", _
        '  dbConnection)
        Dim objCommand As New SqlCommand("select " & CategoryID() & " As CategoryID," & TextField() & " as title,(select count(*) FROM " & TableName() & " As x " _
    & " WHERE " & ParentID() & " = y." & CategoryID() & ") As childnodecount FROM " & TableName() & " As y where  " & ParentID() & " = " & pid & _
    If(AdditionalFilter = vbNullString, vbNullString, " And " & AdditionalFilter) & If(itemOrder() Is Nothing, vbNullString, " ORDER BY " & itemOrder()) _
          , dbConnection)

        Dim da As New SqlDataAdapter(objCommand)
        Dim dt As New DataTable()
        Try
            da.Fill(dt)
        Catch ex As Exception
            Exit Sub
        End Try
        PopulateNodes(dt, parentNode.ChildNodes)
    End Sub
    Protected Sub zzzTreeDropDown_TreeNodePopulate(ByVal sender As Object, _
     ByVal e As System.Web.UI.WebControls.TreeNodeEventArgs) Handles zzztvDropDown.TreeNodePopulate
        PopulateSubLevel(CInt(e.Node.Value), e.Node)
    End Sub
    Private _TableName As String    ' Table Or View Name. Should have CategoryID,Title,ParentID Fields (not specifically these names)
    Public Property TableName() As String
        Get
            '  If _TableName = vbNullString Then _TableName = zzzSaveTableName.Value
            If _TableName = vbNullString Then _TableName = ViewState("TableName")
            Return _TableName
        End Get
        Set(ByVal Value As String)
            _TableName = Value
            '            zzzSaveTableName.Value = Value
            ViewState("TableName") = Value
            If ShowTree Then PShowTree()
        End Set
    End Property
    Private _TextField As String    ' title Field - the text of the tree
    Public Property TextField() As String
        Get
            Return _TextField
        End Get
        Set(ByVal Value As String)
            _TextField = Value
        End Set
    End Property
    Private _CategoryID As String   ' the CategoryID Field 
    Public Property CategoryID() As String
        Get
            Return _CategoryID
        End Get
        Set(ByVal Value As String)
            _CategoryID = Value
        End Set
    End Property
    Private _itemOrder As String   ' the CategoryID Field 
    Public Property itemOrder() As String
        Get
            Return _itemOrder
        End Get
        Set(ByVal Value As String)
            _itemOrder = Value
        End Set
    End Property
    Private _ParentID As String ' The ParentID Field
    Public Property ParentID() As String
        Get
            Return _ParentID
        End Get
        Set(ByVal Value As String)
            _ParentID = Value
        End Set
    End Property
    Private _InitialText As String ' The Initial Text appearing
    Public Property InitialText() As String
        Get
            Return _InitialText
        End Get
        Set(ByVal Value As String)
            _InitialText = Value
        End Set
    End Property
    Private _DeleteClassText As String ' The Initial Text appearing
    Public Property DeleteClassText() As String
        Get
            Return _DeleteClassText
        End Get
        Set(ByVal Value As String)
            _DeleteClassText = Value
        End Set
    End Property
    Dim _ConnStrName As String  ' The Name of the connection string
    Public Property ConnStrName() As String
        Get
            Return _ConnStrName
        End Get
        Set(ByVal Value As String)
            _ConnStrName = Value
        End Set
    End Property
    Dim _ValueType As String    'if "Class" - Selected CategoryID, "Filter" - output is cocat of all levels of tree with | as separtor
    Public Property ValueType() As String
        Get
            Return _ValueType
        End Get
        Set(ByVal Value As String)
            _ValueType = Value
        End Set
    End Property
    Dim _AdditionalFilter As String
    Public Property AdditionalFilter() As String
        Get
            Return _AdditionalFilter
        End Get
        Set(ByVal Value As String)
            _AdditionalFilter = Value
        End Set
    End Property
    Dim _SelectedValue As String    ' 
    Public Property SelectedValue() As String
        Get
            If _SelectedValue = vbNullString Then
                _SelectedValue = ViewState(Me.ID & "SelectedValue")
            End If
            Return _SelectedValue
        End Get
        Set(ByVal Value As String)
            _SelectedValue = Value
            ViewState(Me.ID & "SelectedValue") = Value
            zzzhdnCurrentSelectionValue.Value = Value
        End Set
    End Property
    Dim _SelectedText As String    ' 
    Public Property SelectedText() As String
        Get
            If _SelectedText = vbNullString Then
                _SelectedText = ViewState(Me.ID & "SelectedText")
            End If
            Return _SelectedText
        End Get
        Set(ByVal Value As String)
            _SelectedText = Value
            ViewState(Me.ID & "SelectedText") = Value
            zzzlblCurrentSelectionText.Text = Value
            zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
        End Set
    End Property
    Private _RootCategoryID As Integer ' Root Caategry ID
    Public Property RootCategoryID() As Integer
        Get
            Return _RootCategoryID
        End Get
        Set(ByVal Value As Integer)
            _RootCategoryID = Value
        End Set
    End Property
    Private _Depth As Integer
    Public Property Depth() As Integer
        Get
            Return _Depth
        End Get
        Set(ByVal Value As Integer)
            _Depth = Value
        End Set
    End Property
    Private _Enabled As Boolean
    Public Property Enabled() As Boolean
        Get
            Return _Enabled
        End Get
        Set(ByVal Value As Boolean)
            _Enabled = Value
            zzzlblCurrentSelectionText.Enabled = _Enabled
            zzzbtnshowtree.Enabled = _Enabled
            If Not Enabled Then
                zzzlblCurrentSelectionText.Text = InitialText()
                zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
                SelectedValue = vbNullString
            End If
        End Set
    End Property
    Private _ShowTree As Boolean
    Public Property ShowTree() As Boolean
        Get
            Return _ShowTree
        End Get
        Set(ByVal Value As Boolean)
            _ShowTree = Value
        End Set
    End Property
    Private _TreeVisible As Boolean
    Public ReadOnly Property TreeVisible() As Boolean
        Get
            _TreeVisible = zzzbtnshowtree.Visible
            Return _TreeVisible
        End Get
    End Property
    Private m_Items As ListItemCollection
    Public Overridable ReadOnly Property Items() As ListItemCollection
        Get
            If Me.m_Items Is Nothing Then
                Me.m_Items = New ListItemCollection()
            End If

            Return Me.m_Items
        End Get
    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If TableName = vbNullString Then
            zzztvDropDown.CollapseAll()
            Exit Sub
        End If
        If ViewState(Me.ID & "SelectedValue") = vbNullString Then
            zzzlblCurrentSelectionText.Text = InitialText
            zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
        Else
            zzzhdnCurrentSelectionValue.Value = ViewState(Me.ID & "SelectedValue")
            SelectedValue = zzzhdnCurrentSelectionValue.Value
            zzzlblCurrentSelectionText.Text = ViewState(Me.ID & "SelectedText")
            zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
            SelectedText = zzzlblCurrentSelectionText.Text
            '    '   zzzlblCurrentSelectionText.Text = SelectedText
        End If
        ' ''If Enabled() Then
        ''	zzzlblCurrentSelectionText.Enabled = True
        ''Else
        ''	zzztvDropDown.Visible = False
        ''	zzzlblCurrentSelectionText.Visible = True
        ''	zzzlblCurrentSelectionText.Enabled = False
        ''End If
        If ShowTree() Then If zzztvDropDown.Visible = False Then PShowTree()
    End Sub
    Protected Sub zzztvDropDown_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzztvDropDown.SelectedNodeChanged
        Dim n As TreeNode = zzztvDropDown.SelectedNode
        n.ToggleExpandState()
        If n.ChildNodes.Count > 0 Then
            n.Expand()
            Exit Sub
        End If
        Dim sVType As String = LCase(ValueType())
        Dim s As String = vbNullString
        Dim sT As String = vbNullString

        Select Case sVType
            Case "filter"
                s = If(n.Value = DeleteClassText, "0", n.Value)
                sT = n.Text
                's = n.Text
                'If s = DeleteClassText Then
                '    zzzlblCurrentSelectionText.Text = s
                '    s = vbNullString
                'Else
                '    zzzlblCurrentSelectionText.Text = s
                'End If
                'Dim i As Integer = 0
                'If s <> vbNullString Then
                '    While n.Depth > 0
                '        n = n.Parent
                '        s = n.Text & "|" & s
                '        i += 1
                '    End While
                'While zzzhdnDepth.Value - 1 > i
                '    s += "|"
                '    i += 1
                'End While
                'End If

            Case "class"
                s = If(n.Value = DeleteClassText, "0", n.Value)
                sT = n.Text

        End Select

        zzzhdnCurrentSelectionValue.Value = s
        zzztvDropDown.CollapseAll()
        zzztvDropDown.Visible = False
        zzzlblCurrentSelectionText.Visible = True
        SelectedValue = s
        SelectedText = sT
        ViewState(Me.ID & "SelectedValue") = s
        ViewState(Me.ID & "SelectedText") = sT
        OnSelectionChanged(New System.EventArgs)
    End Sub
    Public Sub ClearSelection()
        zzzlblCurrentSelectionText.Text = InitialText
        zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
        zzzhdnCurrentSelectionValue.Value = vbNullString
        ViewState(Me.ID & "SelectValue") = vbNullString
        ViewState(Me.ID & "SelectText") = InitialText
        SelectedValue = vbNullString
        zzzlblCurrentSelectionText.Visible = True
        zzztvDropDown.Visible = False
    End Sub
    Protected Sub zzzhdnCurrentSelectionValue_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzzhdnCurrentSelectionValue.PreRender
        zzzhdnCurrentSelectionValue.Value = SelectedValue
        ' ViewState(Me.ID & "SelectValue") = SelectedValue
    End Sub
    Protected Sub zzzlblCurrentSelectionText_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles zzzlblCurrentSelectionText.PreRender
        If zzzlblCurrentSelectionText.Text = vbNullString Or zzzlblCurrentSelectionText.Text <> SelectedText Then
            zzzlblCurrentSelectionText.Text = If(SelectedText = vbNullString, InitialText, SelectedText)
            zzzlblCurrentSelectionText.Width = zzzlblCurrentSelectionText.Text.Length * 6
            ' ViewState(Me.ID & "SelectText") = zzzlblCurrentSelectionText.Text
        End If
    End Sub
    Private Sub GetDepth()
        Dim connStr As String = ConfigurationManager.ConnectionStrings(ConnStrName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sqlCom As New SqlCommand("", dbConnection)

        ' Get Depth

        If Not IsNumeric(zzzhdnDepth.Value) Then
            Dim s As String = "if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[#Temp]') and OBJECTPROPERTY(id, N'IsTable') = 1) " _
            & " drop table #Temp " _
            & " Select " & CategoryID() & "," & ParentID() & ",NULL as Depth into #Temp From " & TableName() _
              & " update #Temp set Depth=0 where " & ParentID & "=0 " _
              & " WHILE EXISTS (SELECT * FROM #Temp WHERE Depth Is Null) " _
              & " UPDATE T SET T.depth = P.Depth + 1 " _
              & " FROM #Temp AS T " _
              & " INNER JOIN #Temp AS P ON (T." & ParentID() & " = P." & CategoryID() & ")" _
              & " WHERE(P.Depth >= 0)" _
              & " AND T.Depth Is Null " _
              & " Select MAX(Depth) as Depth From #Temp " _
              & " Drop Table #Temp"
            dbConnection.Open()
            sqlCom.CommandText = s
            Dim dr As SqlDataReader
            Try
                dr = sqlCom.ExecuteReader
                If dr.Read Then
                    zzzhdnDepth.Value = dr("Depth")
                End If
                dr.Close()
            Catch ex As Exception

            End Try
            dbConnection.Close()
        End If

        ' Make Label of selecedvalue invisible and load the top level of the tree

        Depth = "0" & zzzhdnDepth.Value

    End Sub
    Public Event SelectionChanged As System.EventHandler
    Protected Overridable Sub OnSelectionChanged(ByVal e As System.EventArgs)
        RaiseEvent SelectionChanged(zzztvDropDown, e)
    End Sub
End Class