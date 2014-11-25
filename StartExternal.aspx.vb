Imports System.Data.SqlClient
Partial Class StartExternal
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not IsNumeric(Session("UserID")) Then Response.Redirect("Entry.aspx")
        If IsNumeric(Request.QueryString("ID")) Then
            Response.Redirect("ShowOno.Aspx?E=" & Request.QueryString("ID"))
        End If
        If Not IsNumeric(Session("lastCustID")) Then Response.Redirect("CustEventReport.aspx")
        If Not IsNumeric(Session("FrameID")) Then Response.Redirect("CustEventReport.aspx")

        Dim iCustEventTypeID As Integer = If(IsNumeric(Request.QueryString("O")), CInt(Request.QueryString("O")), 130)
        Dim lCustomerID As Long = Session("lastCustID")
        Dim iFrameID As Integer = Session("FrameID")
        Dim d As DateTime = Now
        Dim iUT As Integer
        Dim sFM As String = vbNullString
        Dim sComment As String = "-"
        Dim iCustEventID As Integer = 0

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        cD.CommandType = Data.CommandType.Text
        cD.CommandText = "DECLARE @FM nvarchar(50) " & vbCrLf & _
            "Declare @UT int " & vbCrLf & _
            "Select @FM = ISNULL(FrameManager,'') FROM FrameList WHERE FrameID=" & iFrameID & vbCrLf & _
            "SELECT @UT = CustEventUpdateTypeID FROM CustEventTypes WHERE CustEventTypeID = " & iCustEventTypeID & vbCrLf & _
            "SELECT @UT UT,@FM FM"

        dbConnection.Open()
        Dim dr As SqlDataReader = Nothing

        Try
            dr = cD.ExecuteReader()
            If dr.Read() Then
                sFM = If(IsDBNull(dr("FM")), vbNullString, dr("FM"))
                iUT = If(IsDBNull(dr("UT")), 4, dr("UT"))
            End If
        Catch ex As Exception
            dbg("כתיבת פעולה נכשלה (1) <br />" & ex.Message)
        Finally
            If dr IsNot Nothing Then dr.Close()
        End Try

        Dim sql As String = "EXEC Cust_AddEvent	" & lCustomerID & "," & vbCrLf & _
                       iCustEventTypeID & "," & vbCrLf & _
                       "'" & Format(d, "yyyy-MM-dd HH:mm:ss") & "'," & vbCrLf & _
                       "'" & Format(d, "yyyy-MM-dd") & "'," & vbCrLf & _
                       "'" & sComment & "'," & vbCrLf & _
                       iFrameID & "," & vbCrLf & _
                       "'" & sFM & "'," & vbCrLf & _
                       Session("UserID") & "," & vbCrLf & _
                       iUT
        cD.CommandText = sql
         Try
            cD.ExecuteNonQuery()
        Catch ex As Exception
            dbg("כתיבת פעולה נכשלה (2) <br />" & ex.Message)
        End Try

        sql = "SELECT CustEventID FROM CustEventList WHERE CustEventTypeID = " & iCustEventTypeID & " AND CustomerID = " & lCustomerID & " AND CustEventRegDate = '" & Format(d, "yyyy-MM-dd HH:mm:ss") & "'"
        cD.CommandText = sql

        Try
            dr = cD.ExecuteReader
            If dr.Read Then
                iCustEventID = dr("CustEventID")
            End If
        Catch ex As Exception
            dbg("כתיבת פעולה נכשלה (3) <br />" & ex.Message)
        End Try
        dbConnection.Close()
        Dim sUrl As String = "/pwi/default.Aspx?ID=" & lCustomerID & "&E=" & iCustEventID
        If sUrl <> vbNullString Then
            'Response.Write(sUrl)
            'Response.End()
            Response.Redirect(sUrl)
        End If
        ''Dim sUrl As String = "<script>window.open('/pwi/default.Aspx?ID=" & lCustomerID & "&E=" & iCustEventID & "', '_blank', 'toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,alwaysRaised=yes,resizable=yes,top=0,height=750,width=1200');window.open('CustEventReport.aspx','_self');</script>"

        'If sUrl <> vbNullString Then
        '    Dim csm As ClientScriptManager = Page.ClientScript
        '    csm.RegisterClientScriptBlock(Me.GetType(), "", sUrl)
        'End If
    End Sub
    Sub dbg(s As String, Optional bError As Boolean = True, Optional NewID As Integer = 0)
        Response.Write("<div style=""border:2px solid " & _
                       If(bError, "Red", "Blue") & ";border-top:6px solid xxxx;background-color:#DDDDDD;color:Black;width:350px;" & _
                       "position:absolute;top:30%;right:30%;text-align:center;padding:5px 5px 5px 5px;font-family:Arial;"">" & _
                       "<b>" & If(bError, "תקלת פיתוח", "הודעה") & "</b><br/><br />" & s & _
                       "<br /><br /><br /><input type='button' value='אישור' onclick=""" & If(NewID = 0, "window.close();", "window.open('TTPlan.aspx?FT=1&ID=" & NewID & "','_self')") & """ /></div>")
        Response.Redirect("CustEventReport.Aspx")
    End Sub
End Class
