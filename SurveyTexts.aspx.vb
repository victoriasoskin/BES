Imports SurveysUtil
Imports System.Xml.Linq
Imports System.Linq
Partial Class SurveyTexts
    Inherits System.Web.UI.Page
    Dim xRepList As XElement

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim sSG As String = vbNullString, sSD As String = vbNullString
        If Not IsPostBack Then
            LoadSelectionControls(Request.QueryString("SG"), Request.QueryString("SB"))
            lblhdr.Text = SurveyName(Request.QueryString("s"), "")
            PageHeader1.ButtonJava = "window.location.href = 'SurveyAvg.aspx'; return false;"
        End If
    End Sub
    Sub LoadSelectionControls(ByVal iSurveyGroupID As Integer, ByVal iSubGroup As Integer, Optional SID As String = vbNullString)
        If xRepList Is Nothing Then xRepList = XElement.Load(MapPath("~/App_Data/SurveyReps.xml"))
        Dim q2 = From ll In xRepList.Descendants("SelectionControls").Elements("Control") _
         Where ll.Parent.Parent.Attribute("SurveyGroupID").Value = iSurveyGroupID And ll.Parent.Parent.Attribute("SubGroup").Value = iSubGroup And If(SID = vbNullString Or ll.Attribute("Scontrol") Is Nothing, vbNullString, ll.Attribute("Scontrol").Value) = SID _
          Select New With { _
          .Typ = ll.Attribute("Type").Value, _
          .Nam = ll.Attribute("ID").Value, _
          .Que = ll.Value, _
          .sco = ll.Attribute("Scontrol").Value}

        For Each ll In q2
            Select Case ll.Typ
                Case "sql"
                    Dim ddl As DropDownList = CType(FindControlRecursive(Page, ll.sco), DropDownList)
                    If ddl IsNot Nothing Then ddl.Items.Clear()
                    Dim ds As SqlDataSource = CType(FindControlRecursive(Page, ll.Nam), SqlDataSource)
                    If ds IsNot Nothing Then
                        ds.SelectCommand = ll.Que
                        ds.DataBind()
                    End If
            End Select
        Next
    End Sub
    Private Shared Function FindControlRecursive(ByVal Root As Control, ByVal Id As String) As Control
        If Root.ID = Id Then
            Return Root
        End If
        For Each Ctl As Control In Root.Controls
            Dim FoundCtl As Control = FindControlRecursive(Ctl, Id)
            If FoundCtl IsNot Nothing Then
                Return FoundCtl
            End If
        Next
        Return Nothing
    End Function
    Protected Sub gvtexts_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvtexts.PreRender
        Dim gv As GridView = CType(sender, GridView)
        gv.RowStyle.Wrap = True
        Dim i As Integer
        For i = 0 To gvtexts.Columns.Count - 1
            If gv.Columns(i).HeaderText = "שאלה" Then
                Exit For
            End If
        Next
        For Each gvr As GridViewRow In gv.Rows
            gvr.Cells(i).Text = Regex.Replace(gvr.Cells(i).Text, "&lt;.*?&gt;", " ")
        Next
    End Sub
    Sub ErrCatch()
        Dim s As String = "<font color=red>לא ניתן להפיק דוח זה בחתך זה. "
        If DDLServices.Items.Count > 0 And DDLServices.SelectedValue = vbNullString Then
            s &= " יש לבחור באזור."
        Else
            If DDLFrames.Items.Count > 0 And DDLFrames.SelectedValue = vbNullString Then
                s &= " יש לבחור במסגרת."
            End If
        End If
        lblrephdr.Text = s & "</font>"
    End Sub

    Protected Sub DDLFrames_DataBinding(sender As Object, e As System.EventArgs) Handles DDLFrames.DataBinding
        If DSFrames.SelectCommand.Trim = vbNullString Then
            LoadSelectionControls(Request.QueryString("sg"), Request.QueryString("sb"), "DDLFrames")
        End If
    End Sub
    Protected Sub btnShow_Click(sender As Object, e As System.EventArgs) Handles btnShow.Click
        If DDLFrames.SelectedValue <> vbNullString Then lblrephdr.Text = DDLFrames.SelectedItem.Text
        gvtexts.DataBind()
    End Sub

    Protected Sub DDL_PreRender(sender As Object, e As System.EventArgs) Handles DDLServices.PreRender, DDLFrames.PreRender
        Dim ddl As DropDownList = CType(sender, DropDownList)
        If ddl.Items.Count = 2 Then
            ddl.Items(1).Selected = True
        End If
    End Sub
End Class
