Imports System.Drawing
Imports System.Drawing.Imaging
Imports System.Data.SqlClient
Imports PageErrors

Partial Class Default6
    Inherits System.Web.UI.Page
    Dim bFMNGR As Boolean


    Protected Sub GridView1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.Load
        Dim gv As GridView = CType(sender, GridView)

    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim gv As GridView = CType(sender, GridView)
        For i = 0 To gv.Rows.Count - 1
            Dim gvr As GridViewRow = gv.Rows(i)
            Dim tc As TableCell = gvr.Cells(0)
            If Not IsNumeric(gvr.Cells(2).Text) Then
                tc.Controls.Clear()
            End If
        Next
        '     Button2.Visible = True
    End Sub
    Sub Cleargv(ByRef gv As GridView)
        Dim i As Integer
        If gv.Columns.Count > 1 Then
            For i = gv.Columns.Count - 1 To 1 Step -1
                gv.Columns.RemoveAt(i)
            Next
        End If
        End Sub
    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
    End Sub
    Protected Sub GridView1_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBinding

    End Sub
    Protected Sub DSREP_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSREP.Selecting
        If bFMNGR Then
            e.Command.Parameters("@RepType").Value = 8
        End If
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
		bFMNGR = Session("MultiFrame") = 0
		'If Not IsPostBack Then CloseAll()

    End Sub
    Protected Sub rbltype_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rbltype.PreRender
        Dim rbl As DropDownList = CType(sender, DropDownList)
        If rbl.SelectedIndex < 0 Then rbl.SelectedValue = 1
        rbl.Visible = Not bFMNGR
    End Sub
    Protected Sub DDL_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLServices.PreRender, DDLFrames.PreRender, DDLLAKUT.PreRender, DDLSERVICETYPES.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        ddl.Visible = Not bFMNGR

    End Sub
    Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
        Dim gv As GridView = GridView1
        'Cleargv(gv)
        gv.Columns.Clear()
        Dim bf As New BoundField
        bf.DataField = "מבנה ארגוני"
        bf.ItemStyle.BackColor = Drawing.Color.LightBlue
        gv.Columns.Add(bf)
        gv.Columns(0).ItemStyle.Wrap = False

        If DDLFORMS.SelectedValue = vbNullString Then Exit Sub

        Dim iFrm As Integer = DDLFORMS.SelectedValue

        Dim qR = Nothing

        Dim s As String = "tab_" & iFrm & "_1.xml"
        Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
        qR = (From p In tabx.Elements("Group") _
                    Select New With { _
                        .nam = p.Attribute("Name").Value, _
                        .rnd = If(p.Parent.Attribute("Round") Is Nothing, "0", p.Parent.Attribute("Round").Value)}).Distinct

        Dim sRnd As String = "0"
        For Each q In qR
            s = q.nam
            sRnd = q.rnd
            bf = New BoundField
            bf.DataField = s
            bf.HeaderText = s
            gv.Columns.Add(bf)
        Next

        hdnRound.Value = sRnd

        Dim sKM As String = If(iFrm = 4, "ממוצע", "סיכום")
        bf = New BoundField
        bf.DataField = sKM
        bf.HeaderText = sKM
        gv.Columns.Add(bf)

        bf = New BoundField
        bf.DataField = "שאלונים תקפים"
        bf.HeaderText = "שאלונים תקפים"
        bf.ItemStyle.BackColor = Drawing.Color.LightBlue
        gv.Columns.Add(bf)

        bf = New BoundField
        bf.DataField = "שאלונים תקפים (%)"
        bf.HeaderText = "שאלונים תקפים (%)"
        bf.ItemStyle.BackColor = Drawing.Color.LightBlue
        gv.Columns.Add(bf)

        gv.DataSource = DSREP
        gv.DataBind()


    End Sub
    Protected Sub ChrtG_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChrtG.PreRender

    End Sub
    Protected Sub CB_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cb As CheckBox = CType(sender, CheckBox)
        Dim gvr As GridViewRow = CType(cb.NamingContainer, GridViewRow)
        Dim tc As TableCell = gvr.Cells(0)
        If Not IsNumeric(gvr.Cells(2).Text) Then
            tc.Controls.Clear()
        End If

    End Sub
 
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            Dim tc As TableCell = e.Row.Cells(0)
            If Not IsNumeric(e.Row.Cells(2).Text) Then
                tc.Controls.Clear()
            End If

        Catch ex As Exception

        End Try
    End Sub
    Protected Sub GridView1_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowCreated
        Dim tc As TableCell = New TableCell
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim cb As CheckBox = New CheckBox
            cb.ID = "cb"
            cb.Visible = True
            cb.AutoPostBack = False
            tc.Controls.Add(cb)
        End If
        e.Row.Cells.AddAt(0, tc)
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        Dim c(0 To 10) As Drawing.Color
        c(0) = Color.Goldenrod
        c(1) = Color.Blue
        c(2) = Color.Crimson
        c(3) = Color.DarkOrange
        c(4) = Color.Gray
        c(5) = Color.Chartreuse
        c(6) = Color.DarkSlateBlue
        c(7) = Color.DarkSeaGreen
        c(8) = Color.Brown
        c(9) = Color.Firebrick
        c(10) = Color.Green

        ChrtG.Visible = True
        ChrtG.Series.Clear()
        Dim i As Integer
        Dim j As Integer
        Dim l As Integer = 0

        Dim gv As GridView = GridView1
		For i = 0 To gv.Rows.Count - 1
			Dim gvr As GridViewRow = gv.Rows(i)
			Dim tc As TableCell = gvr.Cells(0)
			Dim cb As CheckBox = CType(tc.FindControl("cb"), CheckBox)
			If cb IsNot Nothing Then
				If cb.Checked Then
					Dim s As String = "s" & l
					ChrtG.Series.Add(s)
					ChrtG.Series(s).Color = c(l)
					cb.BackColor = c(l)
					gvr.Cells(0).BackColor = c(l)
					l = l + 1
					For j = gv.Columns.Count - 2 To 2 Step -1
                        Dim k As Double = CDbl(gvr.Cells(j).Text)
						Dim sH As String = gv.Columns(j - 1).HeaderText
						ChrtG.Series(s).Points.AddXY(sH, k)

					Next
				Else
					gvr.Cells(0).BackColor = Color.White
					cb.BackColor = Color.White

				End If
			End If
		Next
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Help.Visible = Not Help.Visible
    End Sub

    Protected Sub Button1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.PreRender
        'Dim btn As Button = CType(sender, Button)
        'btn.Visible = GridView1.Rows.Count > 0
	End Sub

	Sub CloseAll()
		Dim rootElement As XElement
		Dim rx As XElement
		Dim db As New BES2DataContext
		Dim iFT As Integer
		Dim ifn As Integer
		Dim custrate As Integer
		Dim tot As Double

		Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
		Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select FormID,FormTypeID,CustRate From dbo.[ClosedFormswithNoResults]", dbConnection)
		dbConnection.Open()
		Dim dr As SqlDataReader = cD.ExecuteReader()

		While dr.Read()

			ifn = dr("FormID")
			iFT = dr("FormTypeID")
			Try
				custrate = dr("Custrate")
			Catch ex As Exception
			End Try

			Select Case iFT
				Case 1, 2

					Dim s As String = "tab_" & iFT & "_1.xml"
					Dim tabx As XElement = XElement.Load(MapPath("App_Data/" & s))
					If iFT = 1 Then
						rootElement = XElement.Load(MapPath("App_Data/lq.xml"))
					Else
						rootElement = XElement.Load(MapPath("App_Data/lqp.xml"))
					End If

					'Dim ddd = From fg In tabx.Descendants("Sgrade") _
					'            Where fg.Attribute("Grade").Value = 24 _
					'                    And fg.Parent.Attribute("ID").Value = "70>" _
					'                    And fg.Parent.Parent.Attribute("Name") = "שביעות רצון" _
					'Select New With {.rrt = fg.Attribute("Percentage").Value}



					'For Each xtt In ddd
					'    Response.Write(xtt.rrt)
					'Next

					'Response.End()

					Dim query4 = From qE In rootElement.Descendants("Question") _
					  Join p In db.p5v_Answers _
					  On qE.Attribute("id").Value Equals p.QuestionID _
					  Where qE.Attribute("txt") <> "הנחיות" And qE.Attribute("txt") <> "תוצאות" And p.FormID = ifn _
					   Group By gp = qE.Parent.Element("txt").Value, id = qE.Parent.Attribute("gid").Value _
					   Into xT = Sum(p.Val) _
					  Select New With {.FormID = ifn, _
					 .grp = gp, _
					 .gid = id, _
					 .sumg = xT, _
					 .stan = xT, _
					 .perc = (From t3 In tabx.Descendants("Sgrade") _
					  Where t3.Attribute("Grade").Value = xT _
					 And (t3.Parent.Attribute("ID").Value = custrate) _
					 And t3.Parent.Parent.Attribute("Name") = gp _
					 Select t3.Attribute("Percentage").Value).Take(1).FirstOrDefault}

					Dim ii As Integer = query4.Count

					For Each q In query4
						Dim sj As String = q.FormID	' & "==" & q.gid & "==" & q.grp & "==" & q.perc & "==" & q.stan & q.sumg
					Next

					updResults(ifn, True, query4)

					custrate = ViewState("CustRate")
					s = "tab_" & iFT & "_2.xml"
					tabx = XElement.Load(MapPath("App_Data/" & s))
					Dim qR = (From p In tabx.Descendants("Sgrade") _
					 Where p.Attribute("Grade").Value = tot _
					 And (custrate = vbNullString Or p.Parent.Attribute("ID").Value = custrate) _
					   Select New With {.FormID = ifn, _
					  .grp = "סיכום", _
					  .gid = 99, _
					  .sumg = tot, _
					  .stan = tot, _
					  .perc = p.Attribute("Percentage").Value})
					updResults(ifn, False, qR)


				Case 3 'SIS
					If custrate <> 0 Then
						rootElement = XElement.Load(MapPath("App_Data/SIS.xml"))

						rx = rootElement.Descendants("Title").First
						Dim t62 As XElement = XElement.Load(MapPath("app_data/tab_3_1.xml"))
						Dim query1 = From qElement In rx.Descendants("Question") _
						  Join p In db.p5v_Answers _
						 On qElement.Attribute("id").Value Equals p.QuestionID _
						 Where p.FormID = ifn _
						 Group By gp = qElement.Parent.Parent.Element("txt").Value, id = qElement.Parent.Parent.Attribute("gid").Value _
						 Into xT = Sum(p.Val) _
						  Select New With {.FormID = ifn, _
						 .grp = gp, _
						 .gid = id, _
						 .sumg = xT, _
						 .stan = (From t2 In t62.Descendants.Elements _
						   Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
						  Select t2.Attribute("standard").Value).Take(1).SingleOrDefault, _
						 .perc = (From t2 In t62.Descendants.Elements _
						   Where (t2.Parent.Attribute("Name").Value = gp) And (xT >= t2.Attribute("min").Value) And (xT <= t2.Attribute("max").Value) _
						  Select t2.Attribute("percentage").Value).Take(1).SingleOrDefault}

						updResults(ifn, True, query1)

						Dim t63 As XElement = XElement.Load(MapPath("app_data/tab_3_2.xml"))
						Dim query = From q In t63.Elements _
						 Where q.Attribute("standard").Value = tot _
						   Select New With {.formid = ifn, _
						  .grp = "סיכום", _
						  .gid = 99, _
						  .sumg = tot, _
						  .stan = q.Attribute("index").Value, _
						  .perc = q.Attribute("percentage").Value}
						updResults(ifn, False, query)
					End If

			End Select

		End While

	End Sub
	Sub updResults(ByVal ifn As Integer, Optional ByVal bDel As Boolean = False, Optional ByVal qR As Object = Nothing)
		If bDel Then
			Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
			Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
			Dim cD As New SqlCommand("delete from p5t_FormResults Where FormID=" & ifn, dbConnection)
			dbConnection.Open()
			Try
				cD.ExecuteNonQuery()
			Catch ex As Exception

			End Try
			dbConnection.Close()
		End If
		Dim db As New BES2DataContext
		If qR IsNot Nothing Then
			Dim r As New p5t_FormResult
			For Each q In qR

				r.FormID = q.FormID
				r.grp = q.grp
				r.perc = CDbl(q.perc)
				r.sumg = q.sumg
				r.stan = CDbl(q.stan)
				r.gid = CInt(q.gid)
				db.p5t_FormResults.InsertOnSubmit(r)
				db.SubmitChanges()
				r = Nothing
				r = New p5t_FormResult
			Next
		End If

	End Sub

	Protected Sub CBNF_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CBNF.CheckedChanged
		lblhdr2.Visible = Not lblhdr2.Visible
		GridView2.Visible = Not GridView2.Visible
	End Sub

	Protected Sub CBNF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles CBNF.PreRender
		Dim cb As CheckBox = CType(sender, CheckBox)
		cb.Visible = Not bFMNGR
	End Sub

    Protected Sub lblFM_PreRender(sender As Object, e As System.EventArgs) Handles lblSerivicetype.PreRender, lblFrames.PreRender, lblLAKUT.PreRender, lblNONFORMFRAMES.PreRender, lblREPType.PreRender, lblServices.PreRender
        Dim lbl As Label = CType(sender, Label)
        lbl.Visible = Not bFMNGR
    End Sub
End Class