Imports Microsoft.VisualBasic
Imports System.Xml
Imports System.Xml.linq
Public Class SXML
    Sub cXML(ByRef el As XmlNode, ByVal sName As String, ByVal sTxt As String, Optional ByVal iVal As Integer = 0)
        If el.Name = "txt" Or el.Name = "val" Then
            sTxt = el.InnerText
        Else
            sName = el.Name
        End If

        If el.FirstChild.InnerXml <> vbNullString Then
            cXML(el.FirstChild, sName, sTxt, iVal)
        Else
            el = el.NextSibling
            While Not el Is Nothing
                If el.InnerXml <> vbNullString Then
                    cXML(el, sName, sTxt, iVal)
                End If
                If Not el Is Nothing Then el = el.NextSibling
            End While
        End If
    End Sub


End Class
