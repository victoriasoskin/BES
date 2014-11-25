Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports WebMsgApp
Imports eid
Public Class ProgTexts
    Shared Sub InsertTexts(iProg As Integer, pg As Page)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select CSSClass,TextStyle,RFText,TextControlID,TextStyleControlID,iSNULL(TextType,1) AS TextType From ProgramTexts Where ProgramID=" & iProg, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        While dr.Read
            Dim sStyle As String = If(IsDBNull(dr("TextStyle")), vbNullString, dr("TextStyle"))
            Dim sCss As String = If(IsDBNull(dr("CSSClass")), vbNullString, dr("CSSClass"))
            Dim sText As String = If(IsDBNull(dr("RFText")), vbNullString, dr("RFText"))
            Dim sTextc As String = If(IsDBNull(dr("TextControlID")), vbNullString, dr("TextControlID"))
            Dim sStylec As String = If(IsDBNull(dr("TextStyleControlID")), vbNullString, dr("TextStyleControlID"))
            Dim iTType As Integer = dr("TextType")
            ' Set Style or Css

            If sStylec <> vbNullString Then
                Dim cS As Control = FindControlRecursive(pg, sStylec)
                If cS IsNot Nothing Then
                    If sStyle <> vbNullString Then
                        SetStl(cS, sStyle, iTType)
                    ElseIf sCss <> vbNull Then

                    End If

                End If
            End If

            ' Set Text

            If sTextc <> vbNullString Then
                Dim cS As Control = FindControlRecursive(pg, sTextc)
                If cS IsNot Nothing Then
                    SetVal(cS, sText, iTType)
                End If
            End If

        End While
        dr.Close()
        dbConnection.Close()

    End Sub
    Private Shared Sub SetVal(cS As Control, sT As String, Optional iTyp As Integer = 1)
        Dim ty As String = cS.GetType.ToString
        Try
            Select Case ty
                Case "System.Web.UI.WebControls.Label"
                    CType(cS, Label).Text = tTypec(iTyp, sT)
                Case "System.Web.UI.WebControls.Button"
                    CType(cS, Button).Text = tTypec(iTyp, sT)
                Case "System.Web.UI.WebControls.HiddenField"
                    CType(cS, System.Web.UI.WebControls.HiddenField).Value = tTypec(iTyp, sT)
                Case Else
                    WebMsgBox.Show(ty)
            End Select
        Catch ex As Exception
            WebMsgBox.Show("תכונה לא נתמכת: m:Text " & ty & "\n" & sT)
        End Try
    End Sub
    Private Shared Sub SetStl(cS As Control, sT As String, Optional iTyp As Integer = 1)
        Dim ty As String = cS.GetType.ToString
        Try
            cS.GetHashCode()
            Select Case ty
                Case "System.Web.UI.HtmlControls.HtmlGenericControl"
                    CType(cS, System.Web.UI.HtmlControls.HtmlGenericControl).Attributes.Add("style", tTypec(iTyp, sT))
                Case "System.Web.UI.WebControls.TableCell"
                    CType(cS, System.Web.UI.WebControls.TableCell).Attributes.Add("style", tTypec(iTyp, sT))
                Case "System.Web.UI.WebControls.TableRow"
                    CType(cS, System.Web.UI.WebControls.TableRow).Attributes.Add("style", tTypec(iTyp, sT))
                Case "System.Web.UI.WebControls.Table"
                    CType(cS, System.Web.UI.WebControls.Table).Attributes.Add("style", tTypec(iTyp, sT))
                Case Else
                    WebMsgBox.Show(ty)
            End Select
        Catch ex As Exception
            WebMsgBox.Show("תכונה לא נתמכת: m:Style " & ty & "\n" & sT)
        End Try
    End Sub
    Private Shared Sub SetCss(cS As Control, sT As String)
        Dim ty As String = cS.GetType.ToString
        Try
            Select Case ty
                Case "System.Web.UI.HtmlControls.HtmlGenericControl"
                    CType(cS, System.Web.UI.HtmlControls.HtmlGenericControl).Attributes.Add("style", sT)
                Case Else
                    WebMsgBox.Show(ty)
            End Select
        Catch ex As Exception
            WebMsgBox.Show("תכונה לא נתמכת: m:Css " & ty & "\n" & sT)
        End Try
    End Sub
    Private Shared Function tTypec(i As Integer, s As String) As String
        Dim sR As String = vbNullString
        Select Case i
            Case 1      ' html
                sR = s
            Case 2      ' style
                sR = s
            Case 3      ' alert
                sR = s '.Replace("&nbsp;", " ").Replace("<br />", "\n")
            Case 4      ' email subject
                sR = s
            Case 5      ' email body
                sR = s
            Case Else
                sR = s
        End Select
        Return sR
    End Function
End Class
