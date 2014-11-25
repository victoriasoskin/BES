Imports Microsoft.VisualBasic
Imports System.IO
Imports OperaConst

Public Class Printing
    Public Shared Sub GridViewPrint(pg As Page, GV As GridView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        GV.UseAccessibleHeader = True
        GV.HeaderRow.TableSection = TableRowSection.TableHeader
        GV.FooterRow.TableSection = TableRowSection.TableFooter
        GV.Attributes("style") = "border-collapse:separate"
        For Each row As GridViewRow In GV.Rows
            If row.RowIndex Mod If(row.RowIndex = 1, PgSize - 6, PgSize) = 0 AndAlso row.RowIndex <> 0 Then
                row.Attributes("style") = "page-break-after:auto;"
            End If
        Next
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        GV.RenderControl(hw)
        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.onload = new function(){")
        sb.Append("var printWin = window.open('', '', 'right=0")
        sb.Append(",top=0,width=1000,height=600,status=0');")
        sb.Append("printWin.document.write(""")
        Dim style As String = "<style type = 'text/css'>thead {display:table-header-group;} td {font-size:xx-small;direction:rtl;text-align:right;border:1px dotted Gray;}</style>"
        ' sb.Append(MasterStyleSheetLink & PrintedReportHeader(sTitle, sSubtitle) & style & gridHTML)
        sb.Append(PrintedReportHeader(sTitle, sSubtitle) & style & gridHTML)
        sb.Append(""");")
        sb.Append("printWin.document.close();")
        sb.Append("printWin.focus();")
        sb.Append("printWin.print();")
        sb.Append("printWin.close();")
        sb.Append("};")
        sb.Append("</script>")
        pg.ClientScript.RegisterStartupScript(pg.[GetType](), "GridPrint", sb.ToString())
        GV.DataBind()
    End Sub
    Public Shared Sub ListViewPrint(pg As Page, LV As ListView, sTitle As String, Optional sSubtitle As String = vbNullString, Optional PgSize As Integer = 40)
        '  LV.Attributes("style") = "border-collapse:separate"
        'For i = 1 To LV.Items.Count
        '    Dim lvi As ListViewItem = LV.Items(i)
        '    If i Mod If(i = 1, PgSize - 6, PgSize) = 0 AndAlso i <> 0 Then
        '        Dim tr As TableRow=CType.lvri
        '        lvi.Attributes("style") = "page-break-after:auto;"
        '    End If
        'Next
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)
        LV.RenderControl(hw)
        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.onload = new function(){")
        sb.Append("var printWin = window.open('', '', 'right=0")
        sb.Append(",top=0,width=1000,height=600,status=0');")
        sb.Append("printWin.document.write(""")
        Dim style As String = "<style type = 'text/css'>table {border:1px dotted Gray;} th {border:1px dotted Gray;} thead {display:table-header-group;border:1px dotted Gray;} td {display:table-cell;font-size:xx-small;direction:rtl;text-align:right;border:1px dotted Gray;}</style>"
        '       sb.Append(MasterStyleSheetLink & PrintedReportHeader(sTitle, sSubtitle) & style & gridHTML) ' & "<script src='App_Script/jquery-1.7.1.js' type='text/javascript'></script><script type='text/javascript'>$(document).ready(function() {       $('td:empty').html('&nbsp;');     });</script>")
        sb.Append(PrintedReportHeader(sTitle, sSubtitle) & style & gridHTML) ' & "<script src='App_Script/jquery-1.7.1.js' type='text/javascript'></script><script type='text/javascript'>$(document).ready(function() {       $('td:empty').html('&nbsp;');     });</script>")
        sb.Append(""");")
        sb.Append("printWin.document.close();")
        sb.Append("printWin.focus();")
        sb.Append("printWin.print();")
        sb.Append("printWin.close();")
        sb.Append("};")
        sb.Append("</script>")
        pg.ClientScript.RegisterStartupScript(pg.[GetType](), "GridPrint", sb.ToString())
        LV.DataBind()
    End Sub
    Private Shared Function PrintedReportHeader(sTitle As String, sSubtitle As String) As String
        'Dim s As String = "<Table style='width:100%'><tr><td style='width:20%'></td><td style='width:64%;" & PrintingTitleStyle & "'><h1>" & sTitle & "</h1></td>" & _
        '    "<td style='vertical-align:top;width:8%;" & PrintingDateUserStyle & "'>תאריך:<br />משתמש:</td><td style='vertical-align:top;width:8%" & PrintingDateUserStyle & "'>" & Format(Today, "dd/MM/yy") & "<br/>" & _
        '    HttpContext.Current.Session("UserName") & "</td></tr><tr><td></td><td style=" & PrintingSubtitleStyle & "><h2>" & sSubtitle & "</h2></td style='" & PrintingDateUserStyle & "'><td></td><td></td></tr></table>"
     End Function


End Class
