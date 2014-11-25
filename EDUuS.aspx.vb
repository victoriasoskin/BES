Imports System.Data.SqlClient
Partial Class EDU_S
    Inherits System.Web.UI.Page
    Const sTextMust1 As String = "יש פעולות חובה שלא סומנו"
    Const sTextMust2 As String = "פעולת הסיכום לא סומנה"
    Dim bErr As Boolean = False

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim iFrameID As Integer
        If IsNumeric(Session("FrameID")) Then
            iFrameID = Int(Session("FrameID"))
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select FrameName,FrameManager From FrameList Where FrameID=" & iFrameID, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            LBLFRAMENAME.Text = dr("FrameName")
            HDNMANAGER.Value = dr("Framemanager")
            dbConnection.Close()
        Else
            DDLFRAMES.Visible = True
            LBLFRAMENAME.Visible = False
        End If
        LBLDATE.Text = Format(Now(), "dd/MM/yy  hh:mm")
        'If Not IsPostBack And IsNumeric(Session("lastCustID")) Then
        '    On Error Resume Next
        '    Dim lsb As ListBox = CType(LSBCUST, ListBox)
        '    Dim li As ListItem = lsb.Items(CType(Session("LastCustID"), Int64))
        '    If li IsNot Nothing Then
        '        lsb.ClearSelection()
        '        lsb.SelectedValue = Session("lastCustID")
        '        DetailsView1.DataBind()
        '    End If
        'End If

    End Sub

    Protected Sub LSBCUST_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles LSBCUST.SelectedIndexChanged
        'If IsNumeric(Session("FrameID")) Then
        '	DSEVENTTypes.SelectParameters.Add("@FrameID", Session("FrameID"))
        'Else
        '	DSEVENTTypes.SelectParameters.Add("@FrameID", DDLFRAMES.SelectedValue)

        'End If
        Dim ddl As DropDownList = DDLGROUPID
        If ddl.SelectedValue = vbNullString Then
            scrMsg("יש לבחור סוג מיון", True)
        End If
        Dim b As Boolean = CheckMust()

    End Sub
    Function CheckMust(Optional ByVal sT As String = vbNullString) As Boolean
        Dim b As Boolean
        If lblerr.Visible And (sT = vbNullString Or sT = lblerr.Text) Then

        End If
        Return b
    End Function
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim gvr As GridViewRow = CType(btn.NamingContainer, GridViewRow)
        Dim cal As Calendar = CType(gvr.FindControl("CALEVENT"), Calendar)
        cal.Visible = Not (cal.Visible)
    End Sub

    Protected Sub CALEVENT_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cal As Calendar = CType(sender, Calendar)
        Dim gvr As GridViewRow = CType(cal.NamingContainer, GridViewRow)
        Dim tb As TextBox = CType(gvr.FindControl("TBDATE"), TextBox)
        tb.Text = Format(cal.SelectedDate, "dd/MM/yy")
        cal.Visible = False
        tb.Focus()
    End Sub

    Protected Sub TextBox3_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub LBLEVENTTYPE_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)

    End Sub
    Function dpr(ByVal s As String) As Drawing.Color
        If Not IsDate(Eval(s)) Then
            dpr = Drawing.Color.DeepSkyBlue
        End If
    End Function

    Protected Sub LNKBADD_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        Dim gvr As GridViewRow = CType(lnkb.NamingContainer, GridViewRow)
        Dim gv As GridView = CType(gvr.NamingContainer, GridView)
        Dim bLastRow As Boolean = gv.Rows.Count - 1 = gvr.RowIndex
        Dim s As String = LCase(Right(lnkb.ID, 1))
        If s = "p" Then
            ' Check if all must have been signed

            If bLastRow And lblerr.Text = sTextMust1 And lblerr.Visible = True Then
                scrMsg("לא ניתן לסמן את הפעולה", True)
                bErr = True
                Dim b As Boolean = CheckMust()
            Else
                DSEVENTTypes.UpdateParameters("CustEventResult").DefaultValue = 1
                bErr = False

            End If
        ElseIf s = "n" Then
            DSEVENTTypes.UpdateParameters("CustEventResult").DefaultValue = 0
            bErr = False
        Else
            bErr = True
        End If
    End Sub

    Protected Sub DSEVENTTypes_Updating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceCommandEventArgs) Handles DSEVENTTypes.Updating
        Dim bOK As Boolean = True
        If bErr Then
            e.Cancel = True
            scrMsg("הפעולה לא תתבצע" & "<br />" & lblerr.Text, True)
        Else
            For k As Integer = 0 To e.Command.Parameters.Count = 1
                Dim s As String = e.Command.Parameters(k).ToString
                Select Case s
                    Case "@CustomerID", "@CustEventTypeID", "@CustFrameID", "@UserID"
                        Dim sV As String = e.Command.Parameters(k).Value
                        bOK = sV <> vbNullString
                End Select
            Next
            If Not bOK Then
                scrMsg("הפעולה לא תתבצע" & "<br />" & "חסרים נתונים", True)
                e.Cancel = True
            End If
        End If
    End Sub

    Protected Sub LSBCUST_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles LSBCUST.PreRender
        If Not IsPostBack And IsNumeric(Session("lastCustID")) Then
            On Error Resume Next
            Dim lsb As ListBox = CType(LSBCUST, ListBox)
            Dim k As Int64 = Session("LastCustID")
            Dim li As ListItem = lsb.Items.FindByValue(k)
            If li IsNot Nothing Then
                lsb.ClearSelection()
                lsb.SelectedValue = k
                DetailsView1.DataBind()
            End If
        End If
    End Sub

    Protected Sub btnhlp_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnhlp.Click
        Dim btn As Button = CType(sender, Button)
        If btn.Text = "הצג הוראות הפעלה" Then
            btn.Text = "הסתר הוראות הפעלה"
            Panel1.Visible = True
        Else
            btn.Text = "הצג הוראות הפעלה"
            Panel1.Visible = False
        End If
    End Sub

    Protected Sub DSEVENTTypes_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles DSEVENTTypes.Selecting
        If Not IsNumeric(Session("FrameID")) Then If IsNumeric(DDLFRAMES.SelectedValue) Then e.Command.Parameters("@FrameID").Value = DDLFRAMES.SelectedValue
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim gv As GridView = CType(sender, GridView)
        Dim gvr As GridViewRow
        Dim b As Boolean = False
        If gv.Rows.Count > 1 Then
            For i As Integer = 0 To gv.Rows.Count - 2
                gvr = gv.Rows(i)
                b = bMustrow(gvr) Or b
            Next
            If b Then
                lblerr.Text = sTextMust1
                lblerr.Visible = True
            Else
                gvr = gv.Rows(gv.Rows.Count - 1)
                If bMustrow(gv.Rows(gv.Rows.Count - 1)) Then
                    lblerr.Text = sTextMust2
                    lblerr.Visible = True
                Else
                    lblerr.Visible = False
                End If
            End If
            If b Then
            End If
        End If
    End Sub
    Function bMustrow(ByVal gvr As GridViewRow) As Boolean
        Dim b As Boolean = False
        Dim lbl As Label = CType(gvr.FindControl("CBMUST"), Label)
        If lbl IsNot Nothing Then
            If lbl.Text = "*" Then
                lbl = CType(gvr.FindControl("LBLRESULT"), Label)
                If lbl IsNot Nothing Then
                    If lbl.ForeColor = Drawing.Color.DeepSkyBlue Then
                        b = True
                    End If
                End If
            End If
        End If
        Return b
    End Function
    Sub scrMsg(sMsg As String, bErr As Boolean)
        Dim sStyle = "border:2px solid xxxx;border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;position:absolute;top:50%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"

        divmsg.Visible = True
        divmsg.Attributes.Add("style", sStyle.Replace("xxxx", If(bErr, "Red", "Blue")))
        lblmsg.Text = sMsg
        divform.Disabled = True
    End Sub

    Protected Sub btnmsg_Click(sender As Object, e As System.EventArgs) Handles btnmsg.Click
        divmsg.Visible = False
        divform.Disabled = False
    End Sub

    Protected Sub DDLGROUPID_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles DDLGROUPID.SelectedIndexChanged
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.SelectedValue <> vbNullString Then
            Session("EDU" & ddl.ID & "_V") = ddl.SelectedValue
            Response.Cookies("EDU" & ddl.ID & "_V").Value = ddl.SelectedValue
            Response.Cookies("EDU" & ddl.ID & "_V").GetHashCode()
            Response.Cookies("EDU" & ddl.ID & "_V").Expires = DateAdd(DateInterval.Month, 1, Now())
            Response.Cookies("EDU" & ddl.ID & "_V").HttpOnly = False
        End If

    End Sub

    Protected Sub DDLGROUPID_PreRender(sender As Object, e As System.EventArgs) Handles DDLGROUPID.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        Dim li As ListItem = Nothing
        If Session("EDU" & ddl.ID & "_V") <> vbNullString Then
            li = ddl.Items.FindByValue(Session("EDU" & ddl.ID & "_V"))
        ElseIf Request.Cookies() IsNot Nothing Then
            If Request.Cookies("EDU" & ddl.ID & "_V") IsNot Nothing Then
                Dim s As String = Request.Cookies("EDU" & ddl.ID & "_V").Value
                li = ddl.Items.FindByValue(s)
            End If
        End If
        If Not IsNothing(li) Then
            ddl.ClearSelection()
            li.Selected = True
        End If
    End Sub

End Class
