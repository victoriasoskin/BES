Imports System.Data.SqlClient
Imports PageErrors
Partial Class Default3
    Inherits System.Web.UI.Page
    Dim dAccum(0 To 11) As Double
    Protected Sub LBLDT1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        Dim dbl As Double = CType(Mid(lbl.ID, 6), Double)
        Dim ddl As DropDownList = DDLWY
        Dim d As DateTime = ddl.SelectedValue
        lbl.Text = Format(DateAdd(DateInterval.Month, dbl - 1, d), "MMMM")
    End Sub
    Function lVal(ByVal dM As Double, Optional ByVal bTot As Boolean = False) As String
        On Error Resume Next
        Dim iBCID As Integer = Eval("BudgetCategoryID")
        If Err.Number <> 0 Then
            Err.Clear()
            Return vbNullString
        Else
            Dim iFCID As Integer = DDLFRAME.SelectedValue
            Dim d As DateTime = DDLWY.SelectedValue
            Dim d1 As DateTime = d
            If dM > 12 Then
                d1 = DateAdd(DateInterval.Month, 11, d)
            Else
                d = DateAdd(DateInterval.Month, dM - 1, d)
                d1 = d
            End If
            Dim s As String = "~/p3aTrans.aspx?BCID=" & iBCID & "&FCID=" & iFCID & "&RDTF=" & Format(d, "yyyy-MM-dd") & "&RDTT=" & Format(d1, "yyyy-MM-dd")
            Return s
        End If
    End Function
    Function mVal(ByVal sT As String, ByVal dM As Double, Optional ByVal bAll As Boolean = False) As String
        On Error Resume Next
        Dim iBCID As Integer = Eval("BudgetCategoryID")
        If Err.Number <> 0 Then
            Err.Clear()
            Return vbNullString
        Else
            Dim iFCID As Integer
            iFCID = HDNFrameID.Value
            If iFCID = 0 Then iFCID = DDLFRAME.SelectedValue
            Dim sFrame As String = Eval("Frame")
            Dim sBudItem As String = Eval("BudItem")
            Dim subJect As String = Eval("Subject") & vbNullString
            Dim d As DateTime = DDLWY.SelectedValue
            Dim d1 As DateTime
            If dM <= 12 Then
                d = DateAdd(DateInterval.Month, dM - 1, d)
                d1 = d
            Else
                d1 = DateAdd(DateInterval.Month, 12 - 1, d)
            End If
            Dim iSID As Integer
            If sT = "נוספות" Then
                iSID = 500
            ElseIf sT = "משוערות" Then
                iSID = 600
            Else
                iSID = 0
            End If
            Dim s As String
            If bAll Then s = "DetTrans" Else s = "AddTrans"
            s = "~/p3a" & s & ".aspx?BCID=" & iBCID & "&BudItem=" & Server.UrlEncode(sBudItem) & "&FCID=" & iFCID & "&Frame=" & Server.UrlEncode(sFrame) & "&RDTF=" & Format(d, "yyyy-MM-dd") & "&RDTT=" & Format(d1, "yyyy-MM-dd") & "&SID=" & iSID & "&Subject=" & Server.UrlEncode(subJect)
            Return s
        End If
    End Function
    Function tVal(ByVal dm As Double, ByVal s As String, Optional ByVal bAccum As Boolean = False) As String
        Dim sA(0 To 10) As String
        Dim df As DateTime = CType(DDLWY.SelectedValue, DateTime)
        sA = Split(s, "|")
        Dim dbl As Double
        Dim d As DateTime
        Dim i As Integer
        Dim m As Integer
        Dim n As Integer
        Dim k As Integer
        If dm > 12 Then
            m = 1
            n = 12
        Else
            m = dm
            n = dm
        End If
        For k = m To n
            d = DateAdd(DateInterval.Month, CDbl(k) - 1, df)
            For i = 0 To UBound(sA)
                If Len(sA(i)) > 0 Then
                    Dim sGn As String = Left(sA(i), 1)
                    If sGn = "-" Then
                        dbl = dbl - Eval(DatePart(DateInterval.Year, d) & "-" & DatePart(DateInterval.Month, d) & "_" & Mid(sA(i), 2))
                    Else
                        dbl = dbl + Eval(DatePart(DateInterval.Year, d) & "-" & DatePart(DateInterval.Month, d) & "_" & Mid(sA(i), 2))
                    End If
                End If
            Next
        Next
        If bAccum And dm <= 12 Then
            If dm > 1 Then dAccum(Int(dm) - 1) = dAccum(Int(dm) - 2)
            dAccum(Int(dm) - 1) = dAccum(Int(dm) - 1) + dbl
        End If
        Return Format(dbl, "-#,###;#,###")
    End Function

    Protected Sub DDLFRAME_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFRAME.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("bva_FCID") = ddl.SelectedValue
    End Sub
    Protected Sub DDLWY_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLWY.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("bva_WY") = ddl.SelectedValue
    End Sub

	Protected Sub DDLWY_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLWY.PreRender
		Dim s As String
		Dim sqlCom As SqlCommand
		Dim dr As SqlDataReader
		If DDLWY.SelectedIndex <= 0 Then
			If Session("bva_WY") <> vbNullString Then
				DDLWY.SelectedValue = Session("bva_WY")
			Else
				Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
				Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
                If Session("FrameID") IsNot Nothing And IsNumeric(Session("FrameID")) Then
                    sqlCom = New SqlCommand("Select isnull(YearType,'C') as Yeartype from Framelist where FrameID=" & Session("FrameID"), dbConnection)
                    dbConnection.Open()
                    dr = sqlCom.ExecuteReader
                    If dr.Read Then
                        s = LCase(dr("YearType"))
                    Else
                        s = "c"
                    End If
                    dr.Close()
                Else
                    s = "c"
                End If
				If s = "c" Then
					s = CStr(DatePart(DateInterval.Year, Now()))
					Dim li As ListItem = DDLWY.Items.FindByText(s)
					If li IsNot Nothing Then
						DDLWY.ClearSelection()
						li.Selected = True
					End If
				Else
					sqlCom.CommandText = "select WorkYear From p0t_WorkYears where WorkyearFirstdate<='" & Format(Now(), "yyyy-MM-dd") & "' And WorkYearLastDate>='" & Format(Now(), "yyyy-MM-dd") & "' And WYType=1"
					dr = sqlCom.ExecuteReader
					If dr.Read Then
						Dim li As ListItem = DDLWY.Items.FindByText(dr("WorkYear"))
						If li IsNot Nothing Then
							DDLWY.ClearSelection()
							li.Selected = True
						End If
					End If
				End If
			End If
		End If
	End Sub

    Protected Sub DDLFRAME_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFRAME.PreRender
        If Session("bva_FCID") <> vbNullString Then
			DDLFRAME.SelectedValue = Session("bva_FCID")
		Else
		End If
    End Sub
    Protected Sub LBLADIF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        On Error Resume Next
        If Err.Number <> 0 Then
            Err.Clear()
        Else
            Dim lbl As Label = CType(sender, Label)
            If CDbl(lbl.Text) < 0 Then
                lbl.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub
    Function aTot(ByVal dm As Double) As String
        Return Format(dAccum(dm - 1), "-#,###;#,###")
    End Function

    Protected Sub rptbudact_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptbudact.ItemCreated
        Dim i As Integer
        For i = 0 To 11
            dAccum(i) = 0
        Next
    End Sub

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Redirect("Default2.Aspx")
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        On Error Resume Next
        Dim iSFrame As Integer = Session("FrameID")
        If Err.Number <> 0 Then
            Err.Clear()
            iSFrame = 0
        End If
        Dim ifFrame As Integer = DDLFRAME.SelectedValue
        If Err.Number <> 0 Then
            Err.Clear()
            ifFrame = 0
        End If
        On Error GoTo 0
        Dim iReptype As Integer = 4
        Dim s As String = "SELECT     Count(RowID) aS cnt"
        s = s & " FROM p4t_DontShowRep LEFT OUTER JOIN p0t_CoordFrameID ON p4t_DontShowRep.FrameID = p0t_CoordFrameID.SherutFrameID Where (FinanceFrameID=" & ifFrame & " Or SherutFrameID=" & iSFrame & ") And ReptypeID=" & iReptype
        Dim ConCompX As New SqlCommand(s, dbConnection)
        dbConnection.Open()
        Dim drX As SqlDataReader = ConCompX.ExecuteReader()
        drX.Read()
        On Error Resume Next
        Dim i As Integer = drX("cnt")
        drX.Close()
        dbConnection.Close()
        If i > 0 Then
            Response.Redirect("p3aDontShowMessage.aspx")
        End If
        s = Request.QueryString("BudItem")
        If s <> vbNullString Then
            LBLHDR.Text = LBLHDR.Text & " (" & s & ")"
            LNKBBACK.Visible = True
        End If
        On Error Resume Next
        Dim iFID As Integer = Session("FrameID")
        If Err.Number <> 0 Then
            Err.Clear()
            iFID = 0
        End If
        If iFID <> 0 Then
            Dim ConComp As New SqlCommand("Select CategoryID,FrameName From p0v_CoordFrames Where SHERUTFrameID=" & iFID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            Dim iFFid As Integer = dr("CategoryID")
            Dim sFrameName As String = dr("FrameName")
            DDLFRAME.Visible = False
            DDLSERVICES.Visible = False
            LBLFRAMENAME.Text = sFrameName
            'If iFFid = 880 Then
            '    HDNFrameID.Value = 206
            'Else
            HDNFrameID.Value = iFFid
            'End If
        End If
        Dim iSid As Integer = Session("ServiceID")
        If Err.Number <> 0 Then
            Err.Clear()
            iSid = 0
        End If
        HDNServiceID.Value = iSid
    End Sub

    Protected Sub RBLREPTYPE_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLREPTYPE.SelectedIndexChanged
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Session("bva_RT") = rbl.SelectedValue
    End Sub

    Protected Sub RBLDETAILS_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLDETAILS.SelectedIndexChanged
        Dim rbl As RadioButtonList = CType(sender, RadioButtonList)
        Session("bva_DT") = rbl.SelectedValue
    End Sub

    Protected Sub RBLREPTYPE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLREPTYPE.PreRender
        If Session("bva_RT") <> vbNullString Then
            RBLREPTYPE.SelectedValue = Session("bva_RT")
        End If
    End Sub

    Protected Sub RBLDETAILS_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBLDETAILS.PreRender
        If Session("bva_DT") <> vbNullString Then
            RBLDETAILS.SelectedValue = Session("bva_DT")
        End If
    End Sub
    Function backVal() As String
        On Error Resume Next
        Dim i As Integer = CType(Eval("DetRep"), Integer)
        If Err.Number = 0 Then
            Dim s As String = "~/p3aBVAREPM.ASPX?BCID=" & i & "&BudItem=" & Eval("BudItem")
            Return s
        Else
            Err.Clear()
            Return vbNullString
        End If
    End Function

    Protected Sub LNKBBACK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LNKBBACK.Click
        Response.Redirect("~/p3aBVAREPM.aspx")
    End Sub

    Protected Sub DDLSERVICES_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSERVICES.SelectedIndexChanged
        Session("bva_FCID") = vbNullString
        DDLFRAME.ClearSelection()
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Session("bva_SERVICE") = ddl.SelectedValue
    End Sub

	Protected Sub DDLSERVICES_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLSERVICES.PreRender
		DDLSERVICES.ClearSelection()
		If Session("bva_SERVICE") <> vbNullString Then
			Dim li As ListItem = DDLSERVICES.Items.FindByValue(Session("bva_service"))
			If li IsNot Nothing Then li.Selected = True
		End If
	End Sub
    Protected Sub HLDIF_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        On Error Resume Next
        If Err.Number <> 0 Then
            Err.Clear()
        Else
            Dim hl As HyperLink = CType(sender, HyperLink)
            If CDbl(hl.Text) < 0 Then
                hl.ForeColor = Drawing.Color.Red
            End If
        End If
    End Sub

    Protected Sub DSBUDACT_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSBUDACT.Selecting
        If IsNumeric(DDLFRAME.SelectedValue) Then
            If DDLFRAME.SelectedValue = 880 Then
				e.Command.Parameters("@FrameCategoryID").Value = 206
				e.Command.CommandTimeout = 180
            End If
        End If
    End Sub
End Class
