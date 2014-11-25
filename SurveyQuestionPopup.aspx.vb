Imports System.Data.SqlClient
Imports SurveysUtil
Imports System.Xml.Linq
Imports System.Linq
Partial Class SurveyQuestionPopup
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        PageHeader1.ButtonJava = "window.location.href = 'SurveyAvg.aspx'; return false;"


        ' Checked if logged in

        If Session("UserID") IsNot Nothing Then

            If IsNumeric(Session("UserID")) Then
                '               LoadLSBQuestions(CInt(Request.QueryString("s")), Request.QueryString("g"))
            Else
                CloseWindow()
            End If
        Else
            CloseWindow()
        End If

    End Sub
    Sub CloseWindow()
    End Sub
    Sub LoadLSBQuestions(ByVal iSurveyGroupID As Integer, iSubGroup As Integer)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select top 1 SurveyID,isnull(xmlfile,'') as xmlfile From Surveys Where SurveyGroupID=" & iSurveyGroupID & " And SubGroup=" & iSubGroup & " Order by ShortDescription Desc", dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader()
        If dr.Read Then
            Dim s As String = dr("xmlfile")
            dr.Close()
            dbConnection.Close()
            If s <> vbNullString Then
                Dim x As XElement = XElement.Load(MapPath("~/App_Data/" & s))
                Dim q = From l In x.Descendants("Question") _
                  Where l.Attribute("id").Value <> 0 _
                 Select New With { _
                .מס = l.Attribute("id").Value, _
                .שאלה = Regex.Replace(l.Element("txt").Value, "<.*?>", " ")}
                'For Each l In q
                '	Dim sI As String = l.id
                '	li = New ListItem("[" & If(CInt(sI) <= 9, " ", "") & sI & "] " & Left(l.txt, iQuestionLen) & "...", sI)
                '	Try
                '		LSBQ.Items.Add(li)
                '	Catch ex As Exception
                '		Throw ex
                '	End Try
                'Next
                'For Each iTm As ListItem In LSBQ.Items
                '	'Response.Write(iTm.Text & "=" & iTm.Value & "<br />")

                gvq.DataSource = q
                gvq.DataBind()
                'Next
                'Response.End()
            End If
        End If



        '	End If
    End Sub

    Protected Sub gvq_PreRender(sender As Object, e As System.EventArgs) Handles gvq.PreRender
        Dim gv As GridView = CType(sender, GridView)
        For Each gvr As GridViewRow In gv.Rows
            If gvr.Cells.Count > 1 Then
                gvr.Cells(1).Text = Regex.Replace(gvr.Cells(1).Text, "&lt;.*?&gt;", " ")
            End If
        Next
    End Sub

    Protected Sub lblhdr_PreRender(sender As Object, e As System.EventArgs) Handles lblhdr.PreRender
        lblhdr.Text = SurveyName(Request.QueryString("s"), "")
    End Sub
End Class
