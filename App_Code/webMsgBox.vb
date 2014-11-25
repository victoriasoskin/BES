Imports Microsoft.VisualBasic
Imports System.Text
Imports System.Collections
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Namespace WebMsgApp

    Public Class WebMsgBox
        Protected Shared handlerPages As New Hashtable()
        Private Sub New()
        End Sub

        Public Shared Sub Show(ByVal Message As String)
            If Not (handlerPages.Contains(HttpContext.Current.Handler)) Then
                Dim currentPage As Page = DirectCast(HttpContext.Current.Handler, Page)
                If Not ((currentPage Is Nothing)) Then
                    Dim messageQueue As New Queue()
                    messageQueue.Enqueue(Message)
                    handlerPages.Add(HttpContext.Current.Handler, messageQueue)
                    AddHandler currentPage.Unload, New EventHandler(AddressOf CurrentPageUnload)
                End If
            Else
                Dim queue As Queue = DirectCast(handlerPages(HttpContext.Current.Handler), Queue)
                queue.Enqueue(Message)
            End If
        End Sub

        Private Shared Sub CurrentPageUnload(ByVal sender As Object, ByVal e As EventArgs)
            Dim queue As Queue = DirectCast(handlerPages(HttpContext.Current.Handler), Queue)
            If queue IsNot Nothing Then
                Dim builder As New StringBuilder()
                Dim iMsgCount As Integer = queue.Count
                builder.Append("<script language='javascript'>")
                Dim sMsg As String
                While (iMsgCount > 0)
                    iMsgCount = iMsgCount - 1
                    sMsg = System.Convert.ToString(queue.Dequeue())
                    sMsg = sMsg.Replace("""", "'")
                    builder.Append("alert( """ & sMsg & """ );")
                End While
                builder.Append("</script>")
                handlerPages.Remove(HttpContext.Current.Handler)
                HttpContext.Current.Response.Write(builder.ToString())
            End If
        End Sub
    End Class

End Namespace