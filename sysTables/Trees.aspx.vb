Imports System.Xml
Imports System.Data.SqlClient
Partial Class Trees
	Inherits System.Web.UI.Page
	Dim xmlD As New XmlDocument
	Dim SNode As String
	Const sTreeDef As String = "TreesDef.xml"
	Const sTreesFolder As String = "~/App_Data/"
	Const Tprefix As String = "p1t_"
	Const iIndent As Integer = 4


	Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

		If Request.QueryString("T") Is Nothing Then
			Dim xE As XElement = XElement.Load(MapPath(sTreesFolder & sTreeDef))
			Dim query = From q In xE.Descendants("Tree") Select q.Attribute("FID").Value Take (1)
			Dim s As String = query.First
			Response.Redirect("~/systables/Trees.aspx?T=" & s)
		End If

		Dim b As Boolean = Request.QueryString("T") <> vbNullString
		divNewFile.Visible = Not b
		divtree.Visible = b

		If CurrentTree() <> vbNullString And XDT.DataFile <> CurrentTree() And XD.SelectedNode Is Nothing Then
			XDT.DataFile = CurrentTree()
			XD.DataBind()
		Else
			If CurrentTree() = vbNullString Then XD.DataSourceID = vbNullString
		End If

		If b Then xmlD.Load(CurrentTree)

		'buttonCheck.Attributes.CssStyle("visibility") = "hidden"
		'XD.Attributes.Add("onclick", String.Format("document.getElementById('{0}').click();", buttonCheck.ClientID))

	End Sub

	Protected Sub BTNADDCHILD_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNADDCHILD.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			TbAddNode.Visible = True
			TbAddNode.Focus()
			ViewState("iAddType") = 1
		End If
	End Sub

	Protected Sub BTNRMVNODE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNRMVNODE.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
			Try
				sN.ParentNode.RemoveChild(sN)
			Catch ex As Exception

			End Try
			XDDataBind(XD.SelectedNode)
		End If
	End Sub
	Function NewNode(ByVal s As String, Optional ByVal sNNode As String = "Node", Optional ByRef xmlNF As XmlDocument = Nothing) As XmlNode
		Dim xmlI As XmlDocument
		If xmlNF Is Nothing Then xmlI = xmlD Else xmlI = xmlNF
		Dim nNew As XmlElement
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10_C").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
		Dim ConComp As New SqlCommand("Insert into p4t_CatID(Text) Values('" & s & "')", dbConnection)
		ConComp.CommandType = Data.CommandType.Text
		dbConnection.Open()
		Try
			ConComp.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try
		ConComp.CommandText = "select top 1 ID from p4t_CatID order by ID desc"
		Dim dR As SqlDataReader = ConComp.ExecuteReader
		If dR.Read Then
			Dim k As Integer = dR("ID")
			nNew = xmlI.CreateElement(sNNode)
			Dim TextAttr As XmlAttribute = xmlI.CreateAttribute("Text")
			TextAttr.Value = s
			Dim IDAttr As XmlAttribute = xmlI.CreateAttribute("ID")
			IDAttr.Value = k
			nNew.SetAttributeNode(TextAttr)
			nNew.SetAttributeNode(IDAttr)
			dR.Close()
			dbConnection.Close()
		Else
		End If
		Return nNew
	End Function

	Protected Sub TbAddNode_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TbAddNode.TextChanged
		CVVT.Visible = False
		Dim tb As TextBox = CType(sender, TextBox)
		Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
		If ViewState("iAddType") = 1 Then
			If CheckValidText(tb.Text, sN) Then
				sN.AppendChild(NewNode(tb.Text))
				CVVT.Visible = False
			Else
				CVVT.Visible = True
				Exit Sub
			End If
		ElseIf ViewState("iAddType") = 2 Then
			If CheckValidText(tb.Text, sN.ParentNode) Then
				sN.ParentNode.InsertAfter(NewNode(tb.Text), sN)
				CVVT.Visible = False
			Else
				CVVT.Visible = True
				Exit Sub
			End If
		End If
		XDDataBind(XD.SelectedNode)
		tb.Text = Nothing
		tb.Visible = False
	End Sub

	Protected Sub BYNMOVEUP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BYNMOVEUP.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
			Dim pN As XmlNode = sN.PreviousSibling
			If pN IsNot Nothing Then
				sN.ParentNode.InsertBefore(sN, pN)
				XDDataBind(XD.SelectedNode)
			End If
		End If
	End Sub

	Protected Sub BTNEDITNODE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNEDITNODE.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			TBEditNode.Visible = True
			TBEditNode.Text = XD.SelectedNode.Text
			TBEditNode.Focus()
		End If
	End Sub

	Protected Sub TBEditNode_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TBEditNode.TextChanged
		CVVT.Visible = False
		Dim tb As TextBox = CType(sender, TextBox)
		Dim n As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
		If CheckValidText(tb.Text, n.ParentNode) Then
			n.Attributes("Text").Value = tb.Text
			XDDataBind(XD.SelectedNode)
			tb.Text = Nothing
			tb.Visible = False
		Else
			CVVT.Visible = True
			Exit Sub
		End If
	End Sub

	Protected Sub BTNADDBLOW_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNADDBLOW.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			TbAddNode.Visible = True
			TbAddNode.Focus()
			ViewState("iAddType") = 2
		End If
	End Sub

	Protected Sub BTNMOVEDOWN_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNMOVEDOWN.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
			Dim nN As XmlNode = sN.NextSibling
			If nN IsNot Nothing Then
				sN.ParentNode.InsertAfter(sN, nN)
				XDDataBind(XD.SelectedNode)
			End If
		End If
	End Sub

	Protected Sub BTNUPPERLEVEL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNUPPERLEVEL.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
			Dim pN As XmlNode = sN.ParentNode
			If pN IsNot Nothing And pN.ParentNode IsNot Nothing Then
				If CheckValidText(sN.Attributes("Text").Value, sN.ParentNode.ParentNode) Then
					pN.ParentNode.InsertAfter(sN, pN)
					XDDataBind(XD.SelectedNode)
					CVVT.Visible = False
				Else
					CVVT.Visible = True
					Exit Sub
				End If
			End If
		End If
	End Sub

	Protected Sub BTNLOWERLEVEL_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNLOWERLEVEL.Click
		CVVT.Visible = False
		If XD.SelectedNode IsNot Nothing Then
			Dim sN As XmlNode = xmlD.SelectSingleNode(XD.SelectedNode.DataPath)
			Dim pN As XmlNode = sN.PreviousSibling
			If pN IsNot Nothing Then
				If CheckValidText(sN.Attributes("Text").Value, pN) Then
					Dim cN As XmlNode = pN.LastChild
					If cN IsNot Nothing Then
						pN.InsertAfter(sN, cN)
					Else
						pN.AppendChild(sN)
					End If
					XDDataBind(XD.SelectedNode)
				Else
					CVVT.Visible = True
					Exit Sub
				End If
			End If
		End If
	End Sub
	Sub XDDataBind(ByVal n As TreeNode)
		If Not CVVT.Visible Then
			Dim s As String = n.ValuePath
			Try
				xmlD.Save(CurrentTree())
			Catch ex As Exception
				LBLERRWRITE.Visible = True
				Exit Sub
			End Try
			XDT.DataFile = CurrentTree()
			XD.DataBind()
			Dim ssN As TreeNode = XD.FindNode(s)
			If ssN IsNot Nothing Then ssN.Selected = True
		End If
	End Sub

	Protected Sub XDT_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles XDT.DataBinding
	End Sub

	Protected Sub DDLTREES_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLTREES.SelectedIndexChanged
		CVVT.Visible = False
		Dim ddl As DropDownList = CType(sender, DropDownList)
		Response.Redirect("~/systables/Trees.aspx?T=" & ddl.SelectedValue)

	End Sub

	Protected Sub BTNNEWTREE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNNEWTREE.Click
		CVVT.Visible = False
		If TBNEWNAME.Text IsNot Nothing Then
			Dim NxmlD As New XmlDocument
			NxmlD.AppendChild(NxmlD.CreateXmlDeclaration("1.0", "utf-8", vbNullString))

			Dim xN As XmlNode = NewNode(TBNEWNAME.Text, "Tree", NxmlD)
			Dim sF As String = xN.Attributes("ID").Value
			Dim k As Integer = CInt(sF)
			Dim xmlFL As New XmlDocument
			xmlFL.Load(MapPath(sTreesFolder & sTreeDef))
			Dim xR As XmlNode = xmlFL.SelectSingleNode("Trees")
			Dim x As XmlNode = xR.LastChild()
			Dim xTF As XmlElement = xmlFL.CreateElement("Tree")
			Dim NameAttr As XmlAttribute = xmlFL.CreateAttribute("Name")
			NameAttr.Value = TBNEWNAME.Text
			Dim FNAttr As XmlAttribute = xmlFL.CreateAttribute("FID")
			FNAttr.Value = sF
			xTF.SetAttributeNode(NameAttr)
			xTF.SetAttributeNode(FNAttr)

			xR.InsertBefore(xTF, x)
			xmlFL.Save(MapPath(sTreesFolder & sTreeDef))

			NxmlD.AppendChild(xN)
			Dim s As String = xN.Attributes("ID").Value
			NxmlD.Save(MapPath(sTreesFolder & "T" & s & ".xml"))

			Response.Redirect("~/systables/Trees.aspx?T=" & s)
		End If
	End Sub
	Function CurrentTree() As String
		Dim s As String = vbNullString
		If Request.QueryString("T") IsNot Nothing Then
			If Request.QueryString("T") <> vbNullString Then
				s = MapPath(sTreesFolder & "T" & Request.QueryString("T") & ".xml")
			End If
		End If
		Return s
	End Function

	Protected Sub DDLTREES_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLTREES.PreRender
		Dim ddl As DropDownList = CType(sender, DropDownList)
		ddl.SelectedValue = Request.QueryString("T")
	End Sub

	Protected Sub XD_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles XD.SelectedNodeChanged
		TbAddNode.Text = Nothing
		TBEditNode.Visible = False
		TBEditNode.Text = Nothing
		TbAddNode.Visible = False
		CVVT.Visible = False
	End Sub
	Function CheckValidText(ByVal ST As String, ByVal TargetParentNode As XmlNode) As Boolean
		Dim bV As Boolean = True
		If ST <> vbNullString Then
			Dim nC As XmlNodeList = TargetParentNode.ChildNodes
			If nC.Count > 0 Then
				For i = 0 To nC.Count - 1
					Dim n As XmlNode = nC(i)
					If n.Attributes("Text").Value = ST Then
						bV = False
						Exit For
					End If
				Next
			End If
		End If
		Return bV
	End Function
	Sub WriteTables()

		' ---------------Write Categorties

		Dim xDoc As XDocument = XDocument.Load(CurrentTree)
		Dim db As New BES2DataContext
		Dim iIndex As Integer = 0 ' initialize itemorder index
		Dim iRoot As Integer = CInt(Request.QueryString("T")) ' get root

		' Delete old records

		Dim cD = From x In db.p1t_Categories _
		 Where x.Root = iRoot _
	   Select x
		db.p1t_Categories.DeleteAllOnSubmit(cD)
		db.SubmitChanges()

		' Write root record

		Dim f = (From q In xDoc.Elements() _
		Select New p1t_Category With { _
		   .CategoryID = iRoot, _
		   .ItemOrder = ind(iIndex), _
		   .CatAttributes = "קוד מיון|קבוצת מיון|חשבון|שם חשבון", _
		   .CategoryType = 2, _
		   .Name = q.Attribute("Text").Value, _
		   .Root = iRoot, _
		   .Parent = 0, _
		  .UPD = 0}).Take(1)

		db.p1t_Categories.InsertAllOnSubmit(f)
		db.SubmitChanges()

		' Write All Categories

		Dim Q1 = From q In xDoc.Descendants("Node") _
		  Select New p1t_Category With { _
		   .CategoryID = q.Attribute("ID").Value, _
		   .ItemOrder = ind(iIndex), _
		   .CategoryType = 2, _
		   .Name = q.Attribute("Text").Value, _
		   .Root = iRoot, _
		   .Parent = q.Parent.Attribute("ID").Value, _
		  .UPD = 0, _
		  .IsParent = q.HasElements}

		db.p1t_Categories.InsertAllOnSubmit(Q1)
		db.SubmitChanges()

		'-----------Write RH table

		Dim cMat As New Collection
		Dim iDepth As Integer = 0

		'Find maximum depth and table name

		Dim xR As New XmlTextReader(CurrentTree)
		Dim sTreeName As String = vbNullString
		While (xR.Read)
			If CInt(xR.Depth.ToString) > iDepth Then iDepth = CInt(xR.Depth.ToString)
			If sTreeName = vbNullString Then sTreeName = xR.GetAttribute("Text")
		End While
		Dim stabName As String = "[dbo]." & Tprefix & "RH" & iRoot

		' Build table creation sql

		Dim sQl As String
		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)

		sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'" & stabName & "') AND type in ('U')) DROP TABLE " & stabName

		dbConnection.Open()
		Dim comSql As New SqlCommand(sQl, dbConnection)
		comSql.CommandType = Data.CommandType.Text
		Try
			comSql.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		sQl = "Create Table " & stabName & "([CategoryID] [int] NULL,[ItemOrder] [int] NULL, [IsParent] [int] NULL, [" & sTreeName & "] [varchar](255) NULL,"
		Dim sQL1 As String = "([CategoryID],[ItemOrder],[IsParent],[" & sTreeName & "],"
		For i = 1 To iDepth
			sQl = sQl & "[" & sTreeName & " - " & i & "] [varchar](255) Null,"
			sQL1 = sQL1 & "[" & sTreeName & " - " & i & "],"
		Next
		sQl = sQl + "[ענף " & sTreeName & "] [varchar](255) Null) ON [PRIMARY]  "
		sQL1 = sQL1 + "[ענף " & sTreeName & "])"

		comSql.CommandText = sQl
		Try
			comSql.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		'Create ANAF and IsParent Collection

		sQl = "Select CategoryID,Name,Parent,IsParent From p1t_Categories where Root=" & iRoot & " order by itemorder"
		comSql.CommandText = sQl
		Dim dR As SqlDataReader = comSql.ExecuteReader

		Dim cAnaf As New Collection
		Dim cAnafR As New Collection
		Dim cIsPaernt As New Collection
		While dR.Read
			Dim sA As String = dR("Name")
			Dim iPar As String = dR("parent")
			Dim iCat As Integer = dR("CategoryID")

			cIsPaernt.Add(dR("IsParent"), CStr(iCat))
iAgain:
			Try
				cAnaf.Add(iCat, sA)
			Catch ex As Exception
				Dim sP As String = cAnafR.Item(iPar)
				sA = sP & " - " & sA
				Try
					cAnaf.Add(iCat, sA)
				Catch ex1 As Exception
				End Try
			End Try
			Try
				cAnafR.Add(sA, CStr(iCat))
			Catch ex As Exception

			End Try
		End While
		dR.Close()


		sQL1 = "insert into " & stabName & sQL1 & "Values("
		sQl = vbNullString
		xR = Nothing
		xR = New XmlTextReader(CurrentTree)
		Dim iOrd As Integer = 1
		While (xR.Read)
			Dim t As String = xR.GetAttribute("Text")
			Dim sL As String = xR.Depth.ToString
			Dim iD As Integer = xR.GetAttribute("ID")
			If t <> vbNullString And t <> sTreeName Then
				sQl = iD & "," & iOrd & "," & cIsPaernt.Item(CStr(iD)) & ",'" & sTreeName & "',"
				iOrd = iOrd + 1
				Try
					cMat.Add(t, sL)
				Catch ex As Exception
					For i = CInt(sL) To iDepth
						Try
							cMat.Remove(CStr(i))

						Catch ex2 As Exception
						End Try
					Next
					Try
						cMat.Add(t, sL)
					Catch ex1 As Exception
						Throw ex1
					End Try
				End Try
				For j = 1 To iDepth
					Dim sU As String
					Try
						sU = cMat(CStr(j))
					Catch ex As Exception
						sU = vbNullString
					End Try
					If sU = vbNullString Then
						sQl = sQl + "NULL,"
					Else
						sQl = sQl + "'" & Replace(sU, "'", "''") & "',"
					End If
				Next
				sQl = sQL1 + sQl + "'" & cAnafR(CStr(iD)) + "')"
				comSql.CommandText = sQl
				Try
					comSql.ExecuteNonQuery()
				Catch ex As Exception
					Throw ex
				End Try
			End If
		End While

		' CategoriesAdd table

		sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'" & Tprefix & "CategoriesAdd') AND type in ('U')) DROP TABLE " & Tprefix & "CategoriesAdd"

		comSql.CommandText = sQl
		Try
			comSql.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		sQl = "Create Table " & Tprefix & "CategoriesAdd([CategoryID] int, [ענף " & sTreeName & "] varchar(255) NULL) ON [PRIMARY]  "

		comSql.CommandText = sQl
		Try
			comSql.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		sQL1 = "insert into " & Tprefix & "CategoriesAdd([CategoryID], [ענף " & sTreeName & "]) Values("
		For i = 1 To cAnafR.Count
			Dim sk As String = cAnaf(i)
			sQl = sk & ",'" & Replace(cAnafR.Item(sk), "'", "''") & "')"
			sQl = sQL1 + sQl
			comSql.CommandText = sQl
			Try
				comSql.ExecuteNonQuery()
			Catch ex As Exception
				Throw ex
			End Try
		Next

		' BuildAll Procedure

		'' ''comSql.CommandText = "Select * From p0t_AppCatAttParamList where ApptID=1"
		'' ''dR = comSql.ExecuteReader
		'' ''Dim sPrefix As String
		'' ''Dim sTableName As String
		'' ''Dim stDate As String
		'' ''Dim sDetFieldList As String
		'' ''If dR.Read Then
		'' ''	sPrefix = dR("Prefix")
		'' ''	sTableName = dR("TableName")
		'' ''	stDate = dR("stDate")
		'' ''	sDetFieldList = dR("DetFieldList")
		'' ''	dR.Close()
		'' ''	comSql.CommandText = "v2_CREATEASDCATATT"
		'' ''	comSql.CommandType = Data.CommandType.StoredProcedure
		'' ''	comSql.Parameters.AddWithValue("@prefix", sPrefix)
		'' ''	comSql.Parameters.AddWithValue("@Table", sTableName)
		'' ''	comSql.Parameters.AddWithValue("@stDate", stDate)
		'' ''	comSql.Parameters.AddWithValue("@DetFieldList", sDetFieldList)
		'' ''	Try
		'' ''		comSql.ExecuteNonQuery()
		'' ''	Catch ex As Exception
		'' ''		Throw ex
		'' ''	End Try
		'' ''End If
		'' ''dR.Close()

		'Add Drop down  query

		sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'" & Tprefix & "vRH" & iRoot & "') AND type in ('V')) DROP VIEW " & Tprefix & "vRH" & iRoot
		Dim comSql1 As New SqlCommand(sQl, dbConnection)
		comSql1.CommandType = Data.CommandType.Text
		Try
			comSql1.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		Dim sQl2 As String = "[" & sTreeName & " - 1],"
		sQl = "CREATE VIEW " & Tprefix & "vRH" & iRoot & " As SELECT "
		For i = iDepth To 2 Step -1
			sQl = sQl & "CASE WHEN [" & sTreeName & " - " & i & "] IS NULL THEN "
		Next
		sQl = sQl & "[" & sTreeName & " - 1] "
		For i = 2 To iDepth
			sQl = sQl + "ELSE Replicate(Char(160)," & iIndent * (i - 1) & ") + " & "[" & sTreeName & " - " & i & "] END "
			sQl2 = sQl2 & "[" & sTreeName & " - " & i & "],"
		Next
		Dim sql4 = "t.[" & sTreeName & "],"
		sQl = sQl + " + Case IsParent When 0 then '' Else ' >' END AS CATNAME,CategoryID,ItemOrder, " & iRoot & " As Root From " & Tprefix & "RH" & iRoot & " Where [" & sTreeName & " - 1] IS NOT NULL "
		comSql1.CommandText = sQl
		Try
			comSql1.ExecuteNonQuery()
		Catch ex As Exception
			Throw ex
		End Try

		' Create Q2 And Q2D

		'' ''sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'" & Tprefix & "AllTrans_Q2') AND type in ('V')) DROP VIEW " & Tprefix & "AllTrans_Q2"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		'' ''sQl = "Create View " & Tprefix & "AllTrans_Q2 As Select t.*,"
		'' ''Dim sql3 As String = "Case When SourceID < 0 then 'תקופה קודמת' when SourceID between 1 and 800 then 'הנהח' Else 'פקודות נוספות' End As RepCol,"
		'' ''sql3 = sql3 & "Case When SourceID < 0 then 1 when SourceID between 1 and 800 then 2 Else 3 End As RepColOrd "
		'' ''sQl = sQl + sQl2 + sql3 + " From [dbo].[" & Tprefix & "AllTrans_Q1] t Left outer Join " & Tprefix & "RH" & iRoot & " p On t.Cat1 = p.CategoryID"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		'' ''sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'" & Tprefix & "AllTrans_Q2D') AND type in ('V')) DROP VIEW " & Tprefix & "AllTrans_Q2D"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		'' ''sQl = "Create View " & Tprefix & "AllTrans_Q2D As Select t.*,"
		'' ''sQl = sQl + sQl2 + sql3 + " From [dbo].[" & Tprefix & "AllTrans_Q1D] t Left outer Join " & Tprefix & "RH" & iRoot & " p On t.Cat1 = p.CategoryID"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		' '' '' Create view TCP

		'' ''sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'p1v_PreTCP') AND type in ('V')) DROP VIEW p1v_PreTCP"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try
		'' ''sQl = "Create View p1v_PreTCP As SELECT  |[Company],[CompanyID],[SourceID],[SortGroup],[SortGroupName],[ACTID],[AccountKey],[accountname],[Cutoff],[MtransDate],ItemOrder,"

		'' ''sQl = sQl + sQl2 + sql4 + sql3 + ",Sum([LCAmount]) As LCAmount,Sum([QUANT]) As Quant From [dbo].[p1t_AllTrans_Q1] t Left outer Join " & Tprefix & "RH" & iRoot & " p On t.Cat1 = p.CategoryID Group by " & Mid(sQl, InStr(sQl, "|") + 1) & sql4 & Left(sQl2, Len(sQl2) - 1)
		'' ''comSql1.CommandText = Replace(sQl, "|", "")
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		' '' '' Create view TTP

		'' ''sQl = "IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'p1v_PreTTP') AND type in ('V')) DROP VIEW p1v_PreTTP"
		'' ''comSql1.CommandText = sQl
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try
		'' ''sQl = "Create View p1v_PreTTP As SELECT  t.OrgRowID,[Company],[CompanyID],[SourceID],[SortGroup],[SortGroupName],[ACTID],[AccountKey],[accountname],[Cutoff],[MtransDate],"
		'' ''sQl = sQl + sQl2 + "Case Cat1 when -1 then '<לא שייך>' Else " + Left(sql4, Len(sql4) - 1) + " End  As [דוח_כספי]," + sql3 + ",LCAmount,QUANT,"
		'' ''sQl = sQl + "Factor1,Fdate1,Tdate1 "
		'' ''sQl = sQl + " From [dbo].[p1t_AllTrans_Q2D] t"
		'' ''comSql1.CommandText = Replace(sQl, "|", "")
		'' ''Try
		'' ''	comSql1.ExecuteNonQuery()
		'' ''Catch ex As Exception
		'' ''	Throw ex
		'' ''End Try

		dbConnection.Close()

	End Sub
	Function ind(ByRef i As Integer) As Integer
		i = i + 1
		Return i
	End Function
	Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
		WriteTables()
	End Sub
End Class
