Imports System.Data.SqlClient
Imports PageErrors
Partial Class Default2
    Inherits System.Web.UI.Page
    Const RowCount As Integer = 9
    Const HistoryMonths As Integer = -3
    Dim cRowStat As New Collection
    Dim cR1 As New Collection
    Dim cR2Y1 As New Collection
    Dim cY2G1 As New Collection
    Dim cG2 As New Collection
    Dim cWeights As New Collection
    Dim dFactor As Double = 0
    Dim dWeights As Double = 0
    Dim iCustCount As Integer
    Dim sYearType As String
    Dim RepDate As String
    Dim bPrint As Boolean = False
    Dim bSaveReport As Boolean = False
    Dim iGeneralStatus As Integer
    Protected Sub btnshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnshow.Click
        If IsReportClosed(ddlWM.SelectedValue) Then
            lblRepc.Visible = True
            LoadClosedReport()
        Else
            ViewState("ServiceID") = DDLServices.SelectedValue
            ViewState("FrameID") = DDLFrames.SelectedValue
            ViewState("RepDate") = ddlWM.SelectedValue
            ShowRep()
        End If

    End Sub
    Function IsReportClosed(D As DateTime) As Boolean
        If ViewState("FrameRep" & D) Is Nothing Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim sql As String = "Select CASE WHEN EXISTS(SELECT * FROM p0t_FrameRepHistory WHERE AsofDate='" & Format(D, "yyyy-MM-dd") & "'"
            If DDLFrames.SelectedValue <> vbNullString Then
                sql &= " AND FrameID=" & DDLFrames.SelectedValue
            ElseIf DDLServices.SelectedValue <> vbNullString Then
                sql &= " AND ServiceID=" & DDLServices.SelectedValue
            End If
            sql &= ") THEN '1' ELSE '0' END as c"
            Dim cD As New SqlCommand(sql, dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            If dr.Read Then
                ViewState("FrameRep" & D) = dr("c")
            Else
                ViewState("FrameRep" & D) = "0"
            End If
            dbConnection.Close()
        End If
        Return ViewState("FrameRep" & D) = "1"
    End Function
    Sub ShowRep()
        Dim d As DateTime
        RepDate = " Cast('" & Format(CDate(ViewState("RepDate")), "yyyy-MM-dd") & "' As Datetime) "
        Dim dRep As DateTime = ViewState("RepDate")

        ' Get "DontShow" List

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select FrameManager,ManagerStartDate,LicenceValidDate,FireFDate,isnull(YearType,'C') As YearType,isnull(ServiceTypeID,0) As ServiceTypeID From FrameList Where  FrameID=0" & ViewState("FrameID"), dbConnection)
        cD.CommandType = Data.CommandType.Text

        If ViewState("FrameID") IsNot Nothing Then


            dbConnection.Open()
            Dim dr As SqlDataReader = cD.ExecuteReader
            ' frame Inforamtion

            If dr.Read Then 'Everything else is done only if a frame was found
                ViewState("ServiceTypeID") = dr("ServiceTypeID")

                ' Row 1 - Framename,Servicename  =============================================================================

                lblFrame.Text = If(DDLFrames.SelectedValue = vbNullString, Request.QueryString("FN"), DDLFrames.SelectedItem.Text)
                lblService.Text = If(DDLServices.SelectedValue = vbNullString, Request.QueryString("SN"), DDLServices.SelectedItem.Text)

                ' Row 2 - FrameNamager =======================================================================================

                lblMNGR.Text = dr("FrameManager")
                lblStartDate.Text = vbNullString
                If dr("ManagerStartDate") IsNot DBNull.Value Then
                    d = dr("ManagerStartDate")
                    lblStartDate.Text = Format(d, "MMM-yyyy")
                    ViewState("ManagerStartDate") = Format(d, "yyyy-MM-dd")
                End If
                sYearType = dr("YearType")
                Dim Startdate As String = Format(If(LCase(sYearType) = "c", DateSerial(DatePart(DateInterval.Year, dRep), 1, 1), DateAdd(DateInterval.Month, -4, DateSerial(DatePart(DateInterval.Year, DateAdd(DateInterval.Month, 4, dRep)), 1, 1))), "yyyy-MM-dd")

                ' Row 3 - License ============================================================================================

                If ShowRow(3) Then
                    tr3.Visible = True
                    If dr("LicenceValidDate") IsNot DBNull.Value Then d = dr("LicenceValidDate") Else d = CDate("2000-1-1")
                    lblLicesnce.Text = If(d = CDate("2000-1-1"), "לא דווח", Format(d, "dd/MM/yy"))
                    SetRamzor(3, DateDiff(DateInterval.Day, dRep, d), , , d)
                Else
                    tr3.Visible = False
                End If

                ' Row 4 - FireF ==============================================================================================

                If ShowRow(4) Then
                    tr4.Visible = True
                    If dr("FireFDate") IsNot DBNull.Value Then d = dr("FireFdate") Else d = CDate("2000-1-1")
                    lblFireF.Text = If(d = CDate("2000-1-1"), "לא דווח", Format(d, "dd/MM/yy"))
                    SetRamzor(4, DateDiff(DateInterval.Day, dRep, d), , , d)
                    SetRamzor(3, DateDiff(DateInterval.Day, dRep, d), , , d)
                Else
                    tr4.Visible = False
                End If

                dr.Close()

                ' Row 5 - Number of Candidates in last 3 months ==============================================================

                If ShowRow(5) Then
                    tr5.Visible = True
                    Dim s As String = "<table>"
                    cD.CommandText = "SELECT RefstatusID,count(DISTINCT customerid) as cnt " & _
                                    " FROM vCustomerList " & _
                                    " WHERE (PUserID = " & Session("UserID") & ") AND " & _
                                    " (UserFrameID = " & ViewState("FrameID") & ") AND " & _
                                    " (UpdateDate  between DATEADD(mm, DATEDIFF(mm,0,dateadd(ms," & HistoryMonths & ",DATEADD(yy, DATEDIFF(yy, 0, " & RepDate & "), 0))), 0) " & _
                                    " And DATEADD(mm, DATEDIFF(mm,0," & RepDate & "), 0)) AND " & _
                                    " (RefStatusID in (2,3)) " & _
                                    " Group by RefstatusID " & _
                                    " Order by RefStatusID"
                    cD.CommandTimeout = 600
                    dr = cD.ExecuteReader
                    While dr.Read
                        s = s & "<tr><td>" & If(dr("RefstatusID") = 2, "חדשים:", "התקבלו:") & "</td><td>" & dr("cnt") & "</td></tr>"
                    End While
                    lblNewCandcnt.Text = s & "</table>"
                    dr.Close()

                    ' Not Saved in history

                Else
                    tr5.Visible = False
                End If

                ' Row 6 - Investments ======================================================================================

                'If ShowRow(6) Then
                '    tr16.Visible = True
                '    lblInv.Text = vbNullString
                '    lblInvPer.Text = vbNullString

                '    cD.CommandText = "select Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End As TType ,-SUM(s) as s from p3v_BudActP where FrameCategoryID=(Select FinanceFrameID From p0t_CoordFrameID Where EType=1 And SherutFrameID=" & ViewState("FrameID") & ") And FDate Between '" & Startdate & "' And " & RepDate & " And BudgetCategoryID not in (-1,206) Group By Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End order by Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End Desc"
                '    cD.CommandType = Data.CommandType.Text
                '    dr = cD.ExecuteReader()
                '    Dim s As String = "<table>"
                '    Dim dbl(0 To 1) As Double
                '    Dim j As Integer = 0
                '    While dr.Read
                '        dbl(j) = dr("S")
                '        s = s & "<tr><td>" & dr("TType") & ":</td><td>" & Format(dbl(j), "#,###") & "</td></tr>"
                '        j += 1
                '    End While
                '    If Len(s) > 10 Then
                '        lblInv.Text = s & "<tr><td>הפרש:</td><td>" & Format(dbl(0) - dbl(1), "#,###") & "</td></tr></table>"
                '        lblInvPer.Text = Format(dbl(1) / dbl(0), "##0%")
                '        SetRamzor(6, dbl(1) / dbl(0), dbl(0), dbl(1))
                '    End If

                '    dr.Close()
                'Else
                '    tr6.Visible = False
                'End If

                ' Row 7 - yaad Lakohot =======================================================================================

                If ShowRow(7) Then
                    tr7.Visible = True
                    lbltarAct.Text = vbNullString
                    lblCustPercnt.Text = vbNull
                    ' get actual

                    ' if Acdemic year and rep is last day of year then use May instead of august

                    Dim dCountCustomersDate As DateTime = If(dRep.Day = 32 And dRep.Month = 8 And sYearType.ToLower = "a", DateAdd(DateInterval.Month, -3, dRep), dRep)
                    Dim sRd As String = dCountCustomersDate.Year & "-" & dCountCustomersDate.Month & "-" & dCountCustomersDate.Day
                    cD.CommandText = "p2p_CustCount"
                    cD.CommandType = Data.CommandType.StoredProcedure
                    cD.Parameters.AddWithValue("@FirstDate", Startdate)
                    cD.Parameters.AddWithValue("@RepDate", sRd)
                    cD.Parameters.AddWithValue("@ServiceID", DBNull.Value)
                    cD.Parameters.AddWithValue("@FrameID", ViewState("FrameID"))
                    cD.Parameters.AddWithValue("@UserID", Session("UserID"))
                    ' Select CustEventtypeID,Count(*) As cnt From CustEventList where CustFrameID=" & ViewState("FrameID") & " and CustEventTypeID in(1,2) and CustEventDate < " & RepDate & " group by CustEventtypeid"
                    dr = cD.ExecuteReader
                    Dim iYm As Integer = 0
                    Dim iY As Integer = 0
                    Dim iAm As Integer = 0
                    Dim iA As Integer = 0
                    Dim iDm As Integer = 0
                    Dim iLast As Integer = DateDiff(DateInterval.Month, CDate(Startdate), dRep)
                    While dr.Read
                        Dim s As String = dr("סוג")
                        Select Case s
                            Case "יעד"
                                For i = 3 To 3 + iLast
                                    iYm += If(IsDBNull(dr(i)), 0, dr(i))
                                Next
                                iY = If(IsDBNull(dr(3 + iLast)), 0, dr(3 + iLast))
                            Case "בפועל"
                                For i = 3 To 3 + iLast
                                    iAm += If(IsDBNull(dr(i)), 0, dr(i))
                                Next
                                iA = If(IsDBNull(dr(3 + iLast)), 0, dr(3 + iLast))
                            Case "הפרש"
                                For i = 3 To 3 + iLast
                                    iDm += If(IsDBNull(dr(i)), 0, dr(i))
                                Next
                        End Select
                    End While

                    dr.Close()


                    lbltarAct.Text = "יעד חודש הדוח: " & iY & ", בפועל חודש הדוח: " & iA & "<br /> הפרש מצטבר: " & iDm
                    Dim dPYL As Double = CDbl(iAm) / CDbl(iYm)
                    lblCustPercnt.Text = Format(dPYL, "##0%")
                    SetRamzor(7, dPYL, CDbl(iYm), CDbl(iAm), , iY, iA)
                Else
                    tr7.Visible = False
                End If

                ' Row 8 - Customer Accepted ==================================================================================

                If ShowRow(8) Then
                    tr8.Visible = True
                    cD.CommandText = "Select Count(*) As cnt From CustEventList where CustFrameID=" & ViewState("FrameID") & " and CustEventTypeID=1 And CustEventDate>=DATEADD(mm," & HistoryMonths & "," & RepDate & ")"
                    cD.CommandType = Data.CommandType.Text
                    dr = cD.ExecuteReader
                    If dr.Read Then
                        lblAccepted.Text = dr("CNT")
                    End If
                    dr.Close()
                    SaveHistory(8, 0, , CDbl(lblAccepted.Text))
                Else
                    tr8.Visible = False
                End If

                ' Row 9 - Customer Left ==================================================================================

                If ShowRow(9) Then
                    tr9.Visible = True
                    cD.CommandText = "Select Count(*) As cnt From CustEventList where CustFrameID=" & ViewState("FrameID") & " and CustEventTypeID=2 And CustEventDate>=DATEADD(mm," & HistoryMonths & "," & RepDate & ")"
                    dr = cD.ExecuteReader
                    If dr.Read Then
                        lblLeft.Text = dr("CNT")
                    End If
                    dr.Close()
                    SaveHistory(9, 0, , CDbl(lblAccepted.Text))
                Else
                    tr9.Visible = False
                End If


                ' Row 10 - Ex Events ======================================================================================

                If ShowRow(10) Then
                    tr10.Visible = True
                    Dim dCnt(3) As Double
                    cD.CommandText = "Select DATEADD(mm, DATEDIFF(mm,0,custEventDate), 0) As D,Count(*) As cnt From CustEventList where CustFrameID=" & ViewState("FrameID") & " and CustEventTypeID=49 And CustEventDate Between DATEADD(mm," & HistoryMonths & "," & RepDate & ") And DATEADD(dd,-1,DATEADD(mm, DATEDIFF(mm,0," & RepDate & "), 0)) Group by DATEADD(mm, DATEDIFF(mm,0,CustEventDate), 0) Order by DATEADD(mm, DATEDIFF(mm,0,CustEventDate), 0)"
                    dr = cD.ExecuteReader
                    Dim s As String = "<table border=""0"">"
                    Dim k As Integer = 1
                    Dim dH As DateTime = DateAdd(DateInterval.Month, HistoryMonths + 1, dRep)
                    While dr.Read
                        d = dr("D")
                        s = s & "<tr><td>" & Format(d, "MMMM") & ":</td><td>" & dr("CNT") & "</td></tr>"
                        dCnt(k) = dr("Cnt")
                        k += 1
                    End While
                    lblExEvent.Text = s & "</table>"

                    dr.Close()
                    SaveHistory(10, 0, dCnt(1), dCnt(2), dH, dCnt(3), 0)

                Else
                    tr10.Visible = False
                End If

                ' Row 11 - SIS ================================================================================================

                If ShowRow(11) Then
                    tr11.Visible = True
                    lblSISCNT.Text = vbNullString
                    lblSISPER.Text = vbNullString
                    Dim dST As Double = 0
                    Dim dSTP As Double = 0
                    cD.CommandText = "[p5p_FormsAvg]"
                    cD.CommandType = Data.CommandType.StoredProcedure
                    cD.Parameters.AddWithValue("@RepType", 1)
                    cD.Parameters.AddWithValue("@ServiceID", ViewState("ServiceID"))
                    cD.Parameters.AddWithValue("@FrameID", ViewState("FrameID"))
                    cD.Parameters.AddWithValue("@UserID", Session("UserID"))
                    cD.Parameters.AddWithValue("@FormTypeID", 3)
                    Try
                        dr = cD.ExecuteReader
                        While dr.Read
                            If dr("שאלונים תקפים") IsNot DBNull.Value Then
                                dST = dr("שאלונים תקפים")
                                lblSISCNT.Text = "שאלונים תקפים: " & dr("שאלונים תקפים")
                            End If
                            If dr("שאלונים תקפים (%)") IsNot DBNull.Value Then
                                dSTP = Left(dr("שאלונים תקפים (%)"), Len(dr("שאלונים תקפים (%)")) - 1)
                                lblSISPER.Text = dr("שאלונים תקפים (%)")
                            End If
                        End While

                        If lblSISPER.Text <> vbNullString Then SetRamzor(11, CDbl(Left(lblSISPER.Text, Len(lblSISPER.Text) - 1)) / 100, CDbl(Mid(lblSISCNT.Text, 15)) / (CDbl(Left(lblSISPER.Text, Len(lblSISPER.Text) - 1)) / 100), CDbl(Mid(lblSISCNT.Text, 15)))
                        dr.Close()
                        If Trim(lblSISCNT.Text) = vbNullString Then tr11.Visible = False
                    Catch ex As Exception

                        lblSISCNT.Text = "&nbsp;"
                        lblSISPER.Text = "&nbsp;"

                    End Try

                Else
                    tr11.Visible = False
                End If

                ' Row 12 - Q ==================================================================================================

                If ShowRow(12) Then
                    tr12.Visible = True
                    lblQCNT.Text = vbNullString
                    lblQPER.Text = vbNullString

                    cD.CommandText = "[p5p_FormsAvg]"
                    cD.CommandType = Data.CommandType.StoredProcedure
                    cD.Parameters.Clear()
                    cD.Parameters.AddWithValue("@RepType", 1)
                    cD.Parameters.AddWithValue("@ServiceID", ViewState("ServiceID"))
                    cD.Parameters.AddWithValue("@FrameID", ViewState("FrameID"))
                    cD.Parameters.AddWithValue("@UserID", Session("UserID"))
                    cD.Parameters.AddWithValue("@FormTypeID", 1)
                    Try
                        dr = cD.ExecuteReader
                        While dr.Read
                            If dr("שאלונים תקפים") IsNot DBNull.Value Then lblQCNT.Text = "שאלונים תקפים: " & dr("שאלונים תקפים")
                            If dr("שאלונים תקפים (%)") IsNot DBNull.Value Then lblQPER.Text = dr("שאלונים תקפים (%)")
                        End While
                        If lblQPER.Text <> vbNullString Then SetRamzor(12, CDbl(Left(lblQPER.Text, Len(lblQPER.Text) - 1)) / 100, CDbl(Mid(lblQCNT.Text, 15)) / (CDbl(Left(lblQPER.Text, Len(lblQPER.Text) - 1)) / 100), CDbl(Mid(lblQCNT.Text, 15)))
                        dr.Close()
                        If lblQCNT.Text = vbNullString Then tr12.Visible = False
                    Catch ex As Exception

                    End Try
                Else
                    tr12.Visible = False
                End If

                ' Row 13 - QP ==================================================================================================

                If ShowRow(13) Then
                    tr13.Visible = True
                    lblQPCNT.Text = vbNullString
                    lblQPPER.Text = vbNullString

                    cD.CommandText = "[p5p_FormsAvg]"
                    cD.CommandType = Data.CommandType.StoredProcedure
                    cD.Parameters.Clear()
                    cD.Parameters.AddWithValue("@RepType", 1)
                    cD.Parameters.AddWithValue("@ServiceID", ViewState("ServiceID"))
                    cD.Parameters.AddWithValue("@FrameID", ViewState("FrameID"))
                    cD.Parameters.AddWithValue("@UserID", Session("UserID"))
                    cD.Parameters.AddWithValue("@FormTypeID", 2)
                    Try
                        dr = cD.ExecuteReader
                        While dr.Read
                            If dr("שאלונים תקפים") IsNot DBNull.Value Then lblQPCNT.Text = "שאלונים תקפים: " & dr("שאלונים תקפים")
                            If dr("שאלונים תקפים (%)") IsNot DBNull.Value Then lblQPPER.Text = dr("שאלונים תקפים (%)")
                        End While
                        If lblQPPER.Text <> vbNullString Then SetRamzor(13, CDbl(Left(lblQPPER.Text, Len(lblQPPER.Text) - 1)) / 100, CDbl(Mid(lblQPCNT.Text, 15)) / (CDbl(Left(lblQPPER.Text, Len(lblQPPER.Text) - 1)) / 100), CDbl(Mid(lblQPCNT.Text, 15)))
                        dr.Close()
                        If lblQPCNT.Text = vbNullString Then tr13.Visible = False

                    Catch ex As Exception

                    End Try
                Else
                    tr13.Visible = False
                End If


                ' Row 14 - MPREP ===============================================================================================

                If ShowRow(14) Then

                    Dim connStrVPS As String = ConfigurationManager.ConnectionStrings("Book10VPSC").ConnectionString
                    Dim dbConnectionVPS As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStrVPS)

                    tr14.Visible = True
                    lblMPCnt.Text = vbNullString
                    lblMPPER.Text = vbNullString
                    lblHdrMPrep.Text = "תקציב כ""א בשעות"

                    Dim sCD As String = "SELECT * FROM FR_fnMPFrameReport(" & ViewState("FrameID") & "," & RepDate & ")"

                    Dim cDVPS As New SqlCommand(vbNullString, dbConnectionVPS)

                    cDVPS.CommandText = sCD '"SELECT DateB,Sum(QT) As QT, sum(QAT) As QAT, sum(difft) As difft FROM p1t_MpRep WHERE (dateB =(Select max(Dateb) as DateB From p1t_MPRep Where DateB<= " & RepDate & ")) AND (HREP = 1) AND (FrameCategoryID = (Select FinanceFrameID From p0t_CoordFrameID Where SherutFrameID=" & ViewState("FrameID") & ")) GROUP BY DateB"
                    '     cD.CommandText = "SELECT DateB,Sum(QT) As QT, sum(QAT) As QAT, sum(difft) As difft FROM p1t_MpRep WHERE (dateB =(Select max(Dateb) as DateB From p1t_MPRep Where DateB<= " & RepDate & ")) AND (HREP = 1) AND (FrameCategoryID = (Select FinanceFrameID From p0t_CoordFrameID Where SherutFrameID=" & ViewState("FrameID") & ")) GROUP BY DateB"
                    cDVPS.CommandType = Data.CommandType.Text
                    dbConnectionVPS.Open()
                    Dim drVPS As SqlDataReader = cDVPS.ExecuteReader()
                    If drVPS.Read Then
                        '          Dim sTak As String = If(Not IsDBNull(drVPS("QT")), If(IsNumeric(drVPS("QT")), Format(drVPS("QT"), "#,###"), vbNullString), vbNullString)
                        If Not IsDBNull(drVPS("QT")) Then
                            If IsNumeric(drVPS("QT")) Then

                                lblMPCnt.Text = "<table><tr><td>תקציב: </td><td>" & Format(drVPS("QT"), "#,###") & "</td></tr><tr><td> בפועל: </td><td>" & Format(drVPS("QAT"), "#,###") & "</td></tr><tr><td> הפרש: </td><td>" & Format(drVPS("DiffT"), "#,###;-#,###") & "</td></tr></table>"

                                lblMPPER.Text = Format((drVPS("QAT") / drVPS("QT")), "##0%")
                                SetRamzor(14, drVPS("QAT") / drVPS("QT"), drVPS("QT"), drVPS("QAT"), d)
                                d = drVPS("DateB")
                                lblHdrMPrep.Text = "תקציב כ""א  (" & Format(d, "MMM-yy") & ")"
                            End If
                        End If
                        drVPS.Close()
                        dbConnectionVPS.Close()
                    Else
                        tr14.Visible = False
                    End If
                End If
                ' Row 15 - NOT PAID ==========================================================================================

                If ShowRow(15) Then
                    tr15.Visible = True
                    lblnotPaid.Text = vbNullString
                    lblNotPaidPER.Text = vbNullString

                    cD.CommandText = "SELECT SUM(CASE isnull(Paid , - 1) WHEN 0 THEN 1 ELSE 0 END) AS CNT FROM p0v_payListNU WHERE (PaymentMonth Between CAST('2008-1-1' AS datetime) AND DATEADD(mm," & HistoryMonths & "," & RepDate & ")) AND (CustFrameID = " & ViewState("FrameID") & ")"
                    cD.CommandType = Data.CommandType.Text
                    dr = cD.ExecuteReader()
                    If dr.Read Then
                        If dr("cNT") IsNot DBNull.Value Then
                            lblnotPaid.Text = dr("Cnt")
                            lblNotPaidPER.Text = "&nbsp;"
                            SetRamzor(15, dr("Cnt"), , dr("Cnt"))
                        End If
                    End If
                    dr.Close()
                Else
                    tr15.Visible = False
                End If


                ' Row 16 - EXPENSES + INVESTMENTS ==========================================================================================

                If ShowRow(16) Then
                    tr16.Visible = True
                    lblExp.Text = vbNullString
                    lblExpPer.Text = vbNullString

                    cD.CommandText = "SELECT CASE TType WHEN 'תקציב' THEN 'תקציב' ELSE 'בפועל' END AS TType ,-SUM(s) AS s FROM p3v_BudActP WHERE RepTypeID IN (1,2) AND FrameCategoryID=(SELECT FinanceFrameID FROM p0t_CoordFrameID WHERE SherutFrameID=" & ViewState("FrameID") & ") AND FDate BETWEEN '" & Startdate & "' AND " & RepDate & " AND BudgetCategoryID NOT IN (-1,206) Group By Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End order by Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End Desc"
                    cD.CommandType = Data.CommandType.Text
                    dr = cD.ExecuteReader()
                    Dim s As String = "<table>"
                    Dim dbl(0 To 1) As Double
                    Dim j As Integer = 0
                    While dr.Read
                        dbl(j) = dr("S")
                        s = s & "<tr><td>" & dr("TType") & ":</td><td>" & Format(dbl(j), "#,###") & "</td></tr>"
                        j += 1
                    End While
                    If Len(s) > 10 Then
                        lblExp.Text = s & "<tr><td>הפרש:</td><td>" & Format(dbl(0) - dbl(1), "#,###") & "</td></tr></table>"
                        lblExpPer.Text = Format(dbl(1) / dbl(0), "##0%")
                        SetRamzor(16, dbl(1) / dbl(0), dbl(0), dbl(1))
                    End If

                    dr.Close()
                Else
                    tr16.Visible = False
                End If

                ' Row 17 - HITZTAIDUT ==========================================================================================

                If ShowRow(17) Then
                    tr17.Visible = True
                    lblHITZ.Text = vbNullString
                    lblHITZPer.Text = vbNullString

                    cD.CommandText = "SELECT CASE TType WHEN 'תקציב' THEN 'תקציב' ELSE 'בפועל' END AS TType ,-SUM(s) AS s FROM p3v_BudActP WHERE RepTypeID = 4 AND FrameCategoryID=(SELECT FinanceFrameID FROM p0t_CoordFrameID WHERE SherutFrameID=" & ViewState("FrameID") & ") AND FDate BETWEEN '" & Startdate & "' AND " & RepDate & " AND BudgetCategoryID NOT IN (-1,206) Group By Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End order by Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End Desc"
                    cD.CommandType = Data.CommandType.Text
                    dr = cD.ExecuteReader()
                    Dim s As String = "<table>"
                    Dim dbl(0 To 1) As Double
                    Dim j As Integer = 0
                    While dr.Read
                        dbl(j) = dr("S")
                        s = s & "<tr><td>" & dr("TType") & ":</td><td>" & Format(dbl(j), "#,###") & "</td></tr>"
                        j += 1
                    End While
                    If Len(s) > 10 Then
                        lblHITZ.Text = s & "<tr><td>הפרש:</td><td>" & Format(dbl(0) - dbl(1), "#,###") & "</td></tr></table>"
                        lblHITZPer.Text = Format(dbl(1) / dbl(0), "##0%")
                        SetRamzor(17, dbl(1) / dbl(0), dbl(0), dbl(1))
                    Else
                        lblHITZ.Text = "&nbsp;"
                        lblHITZPer.Text = "&nbsp;"
                    End If

                    dr.Close()
                Else
                    tr17.Visible = False
                End If

                ' Row 18 - PEIELUYOT LAKOHOT ==========================================================================================

                If ShowRow(18) Then
                    tr18.Visible = True
                    lblPEIL.Text = vbNullString
                    lblPEILPer.Text = vbNullString

                    cD.CommandText = "SELECT CASE TType WHEN 'תקציב' THEN 'תקציב' ELSE 'בפועל' END AS TType ,-SUM(s) AS s FROM p3v_BudActP WHERE RepTypeID = 5 AND FrameCategoryID=(SELECT FinanceFrameID FROM p0t_CoordFrameID WHERE SherutFrameID=" & ViewState("FrameID") & ") AND FDate BETWEEN '" & Startdate & "' AND " & RepDate & " AND BudgetCategoryID NOT IN (-1,206) Group By Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End order by Case TType When 'תקציב' Then 'תקציב' Else 'בפועל' End Desc"
                    cD.CommandType = Data.CommandType.Text
                    dr = cD.ExecuteReader()
                    Dim s As String = "<table>"
                    Dim dbl(0 To 1) As Double
                    Dim j As Integer = 0
                    While dr.Read
                        dbl(j) = dr("S")
                        s = s & "<tr><td>" & dr("TType") & ":</td><td>" & Format(dbl(j), "#,###") & "</td></tr>"
                        j += 1
                    End While
                    If Len(s) > 10 Then
                        lblPEIL.Text = s & "<tr><td>הפרש:</td><td>" & Format(dbl(0) - dbl(1), "#,###") & "</td></tr></table>"
                        lblPEILPer.Text = Format(dbl(1) / dbl(0), "##0%")
                        SetRamzor(18, dbl(1) / dbl(0), dbl(0), dbl(1))
                    Else
                        lblPEIL.Text = "&nbsp;"
                        lblPEILPer.Text = "&nbsp;"
                    End If

                    dr.Close()
                Else
                    tr18.Visible = False
                End If

                'No more rows ================================================================================================
                '             cD.CommandText = "Select Count(*) As cnt From CustEventList where FrameID=" & ViewState("FrameID") & " and 'CustEventTypeID=1 And CustEventDate>=DATEADD(mm," & HistoryMonths & ",getdate())"

            End If
            dbConnection.Close()
        End If

    End Sub
    Function ShowRow(ByVal i As Integer) As Boolean

        Dim j As Integer
        Try
            j = cRowStat(CStr(i))
        Catch ex As Exception
            j = 0
        End Try
        Return j = 0
    End Function

    Protected Sub Page_Error(sender As Object, e As System.EventArgs) Handles Me.Error
        WriteErrorLog()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If DDLServices.SelectedValue <> vbNullString Then ViewState("ServiceID") = DDLServices.SelectedValue
        If DDLFrames.SelectedValue <> vbNullString Then ViewState("FrameID") = DDLFrames.SelectedValue
        If ddlWM.SelectedValue <> vbNullString Then ViewState("RepDate") = ddlWM.SelectedValue
        If Not IsPostBack Then
            Dim ddl As DropDownList = ddlWM
            ddl.Items.Clear()
            Dim d As DateTime = Today
            For i = 0 To 11
                Dim li As New ListItem(Format(d, "dd/MM/yyyy"), d)
                ddl.Items.Add(li)
                If d = Today Then li.Selected = True
                d = DateSerial(Year(d), Month(d), 0)
            Next
        End If
        If Request.QueryString("P") IsNot Nothing Then
            If Request.QueryString("s") IsNot Nothing Then
                DDLServices.ClearSelection()
                DDLServices.SelectedValue = Request.QueryString("S")
                ViewState("ServiceID") = Request.QueryString("S")
            End If
            If Request.QueryString("F") IsNot Nothing Then
                DDLFrames.ClearSelection()
                DDLFrames.SelectedValue = Request.QueryString("F")
                ViewState("FrameID") = Request.QueryString("F")
            End If
            If Request.QueryString("D") IsNot Nothing Then
                ddlWM.ClearSelection()
                ddlWM.SelectedValue = Request.QueryString("D")
                ViewState("RepDate") = Request.QueryString("D")
            End If
        End If
        If Request.QueryString("P") IsNot Nothing Then
            BuildCollections(False)
            ShowRep()
            DDLFrames.Visible = False
            DDLServices.Visible = False
            ddlWM.Visible = False
            btnshow.Visible = False
            Dim tbl As HtmlTable = FindControlRecursive(Page, "tbl")
            '     tbl.Style.Value.
            btnpreprint.Visible = False
            LBLDate.Text = "נכון לתאריך  : " & ViewState("RepDate")
            LBLDate.Visible = True
            bPrint = True
        End If
        If IsNumeric(Session("SUser")) Then
            If Session("SUser") = 1 Then
                divupd.Visible = True
            End If
        End If

    End Sub

    Protected Sub MainImg_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        If IsReportClosed(CDate(ddlWM.SelectedValue)) And Not bSaveReport Then
            ' iGeneralStatus Got its value when thereport was read
        Else
            Dim d As Double = If(dWeights > 0, dFactor / dWeights, 0)
            iGeneralStatus = If(d <= 0, 0, If(d < 1.5, 1, If(d < 2.5, 2, 3)))
            SaveHistory(1, iGeneralStatus)
        End If
        Dim img As Image = CType(sender, Image)
        Dim s As String = If(iGeneralStatus = 0, "~/images/Grey.jpg", If(iGeneralStatus = 1, If(Request.QueryString("p") Is Nothing, "~/images/Red.jpg", "~/images/Red_p.jpg"), _
                                                          If(iGeneralStatus = 2, If(Request.QueryString("p") Is Nothing, "~/images/Yellow.jpg", "~/images/Yellow_p.jpg"), _
                                                                      If(Request.QueryString("p") Is Nothing, "~/images/Green.jpg", "~/images/Green_p.jpg"))))
        img.ImageUrl = s
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
    Sub BuildCollections(bCalcMany As Boolean)
        If ViewState("FrameID") Is Nothing Then Exit Sub
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("Select isnull(ServiceTypeID,0) As ServiceTypeID From FrameList Where  FrameID=0" & ViewState("FrameID"), dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        If dr.Read Then
            hdnServiceTypeID.Value = dr("ServiceTypeID")
            ViewState("ServicetypeID") = dr("ServiceTypeID")
        End If
        dr.Close()
        dbConnection.Close()
        If cRowStat.Count = 0 Or bCalcMany Then
            cRowStat = Nothing
            cR1 = Nothing
            cR2Y1 = Nothing
            cY2G1 = Nothing
            cG2 = Nothing
            cWeights = Nothing
            cRowStat = New Collection
            cR1 = New Collection
            cR2Y1 = New Collection
            cY2G1 = New Collection
            cG2 = New Collection
            cWeights = New Collection
            cRowStat.Add(0, "0")
            cD.CommandText = "Select distinct Coalesce(f3.ServiceTypeID,f2.ServiceTypeID) As ServiceTypeID, " & _
              "Coalesce(f3.ServiceID,f2.ServiceID) As ServiceID, " & _
               "f3.FrameID, " & _
              "f1.RowNumber, " & _
              "f1.Description, " & _
              "Coalesce(f3.DontShow,f2.DontShow,f1.DontShow,0) As DontShow, " & _
              "Coalesce(f3.R1,f2.R1,f1.R1) As R1, " & _
              "Coalesce(f3.R2Y1,f2.R2Y1,f1.R2Y1) As R2Y1, " & _
              "Coalesce(f3.Y2G1,f2.Y2G1,f1.Y2G1) As Y2G1, " & _
              "Coalesce(f3.G2,f2.G2,f1.G2) As G2, " & _
              "Coalesce(f3.Weight,f2.Weight,f1.Weight) As Weight " & _
              "FROM  (Select * From p0t_frameRep Where ServiceTypeID is null and FrameID  is null ) f1  " & _
              "left outer join (Select * From p0t_frameRep where ServiceTypeID=" & ViewState("ServicetypeID") & ") f2 on f1.RowNumber=f2.RowNumber " & _
              "left outer join (Select * from p0t_frameRep Where FrameID=" & ViewState("FrameID") & ") f3 on f1.RowNumber=f3.RowNumber Order by RowNumber"
            cD.CommandType = Data.CommandType.Text

            dbConnection.Open()
            dr = cD.ExecuteReader
            While dr.Read
                If dr("DontShow") = 1 Then
                    cRowStat.Add(dr("DontShow"), CStr(dr("RowNumber")))
                Else
                    If dr("R1") IsNot DBNull.Value Then cR1.Add(dr("R1"), CStr(dr("RowNumber")))
                    If dr("R2Y1") IsNot DBNull.Value Then cR2Y1.Add(dr("R2Y1"), CStr(dr("RowNumber")))
                    If dr("Y2G1") IsNot DBNull.Value Then cY2G1.Add(dr("Y2G1"), CStr(dr("RowNumber")))
                    If dr("G2") IsNot DBNull.Value Then cG2.Add(dr("G2"), CStr(dr("RowNumber")))
                    If dr("Weight") IsNot DBNull.Value Then cWeights.Add(dr("Weight"), CStr(dr("RowNumber")))
                End If

            End While
            dr.Close()
            dbConnection.Close()
        End If
    End Sub
    Sub SetRamzor(ByVal iRow As Integer, ByVal Val As Double, Optional dBudget As Double = 0, Optional dActual As Double = 0, Optional ValidDate As DateTime = #1/1/2000#, Optional dBudgetC As Double = 0, Optional dActualC As Double = 0)
        Dim R1 As Double
        Dim R2Y1 As Double
        Dim Y2G1 As Double
        Dim G2 As Double
        Dim Weight As Double
        Dim factor As Double
        Dim s As String = "images/Grey.jpg"
        factor = 0
        Try
            R1 = cR1(CStr(iRow))
            R2Y1 = cR2Y1(CStr(iRow))
            Y2G1 = cY2G1(CStr(iRow))
            G2 = cG2(CStr(iRow))
        Catch ex As Exception
        End Try
        Try
            Weight = cWeights(CStr(iRow))
        Catch ex As Exception
            Weight = 0
        End Try
        If R1 > R2Y1 Then
            If Val >= R2Y1 And Val < R1 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/Red_p.jpg", "images/Red.jpg")
                factor = 1
            End If
        Else
            If Val >= R1 And Val < R2Y1 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/Red_p.jpg", "images/Red.jpg")
                factor = 1
            End If
        End If

        If R2Y1 > Y2G1 Then
            If Val >= Y2G1 And Val < R2Y1 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/yellow_p.jpg", "images/yellow.jpg")
                factor = 2
            End If
        Else
            If Val >= R2Y1 And Val < Y2G1 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/yellow_p.jpg", "images/yellow.jpg")
                factor = 2
            End If
        End If

        If G2 > Y2G1 Then
            If Val >= Y2G1 And Val < G2 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/green_p.jpg", "images/green.jpg")
                factor = 3
            End If
        Else
            If Val >= G2 And Val < Y2G1 Then
                s = If(Request.QueryString("P") IsNot Nothing, "images/green_p.jpg", "images/green.jpg")
                factor = 3
            End If
        End If
        RamzorLight(iRow, factor, s)
        dWeights += Weight
        dFactor += Weight * factor
        SaveHistory(iRow, CInt(factor), dBudget, dActual, ValidDate, dBudgetC, dActualC)

    End Sub
    Sub RamzorLight(iRow As Integer, factor As Double, s As String, Optional Ofactor As Double = 0)
        Dim img As Image = CType(FindControlRecursive(Page, "Image" & iRow), Image)
        Dim rmzr As Ramzor = CType(FindControlRecursive(Page, "Ramzor" & iRow), Ramzor)
        If CBCorrect.Checked Then
            If rmzr IsNot Nothing Then
                rmzr.Visible = True
                rmzr.SelectedValue = CInt(factor)
                rmzr.OrgSelectedValue = CInt(factor)
                img.ImageUrl = s
            End If
        Else
            If img IsNot Nothing Then
                img.ImageUrl = s
                img.Visible = True
                If rmzr IsNot Nothing Then rmzr.Visible = False
            End If
        End If
        'If CBCorrect.Visible Then
        '    If img IsNot Nothing Then
        '        If Ofactor <> 0 And Ofactor <> factor Then
        '            Dim tr As HtmlTableRow = FindControlRecursive(Page, "tr" & iRow)
        '            tr.Attributes.Add("style", "backgorund:yellow;")
        '        End If
        '    End If
        'End If

    End Sub
    Sub SaveHistory(RowNumber As Integer, iStatus As Integer, Optional dBudget As Double = 0, Optional dActual As Double = 0, Optional ValidDate As DateTime = #1/1/2000#, Optional dBudgetC As Double = 0, Optional dActualC As Double = 0)

        If Not bSaveReport Then Exit Sub

        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        Dim sSql As String = "DELETE FROM p0t_FrameRepHistory WHERE RowNumber =" & RowNumber & " AND FrameID = " & ViewState("FrameID") & " AND AsofDate = '" & Format(CDate(ViewState("RepDate")), "yyyy-MM-dd") & "' " & _
                             "INSERT INTO p0t_FrameRepHistory(RowNumber,FrameID,FrameManager,MngrStartDate,ServiceTypeID,ServiceID,ValidDate,Budget,BudgetC,Actual,ActualC,AsofDate,UserID,SaveType,Status,LogDate) VALUES(" & _
                                             RowNumber & "," & ViewState("FrameID") & ",'" & lblMNGR.Text.Replace("'", "''") & "'," & If(ViewState("ManagerStartDate") = vbNullString, "NULL", "'" & ViewState("ManagerStartDate") & "'") & "," & ViewState("ServiceTypeID") & "," & ViewState("ServiceID") & "," & _
                                             If(ValidDate <= #1/1/2000#, "NULL", "'" & Format(ValidDate, "yyyy-MM-dd") & "'") & "," & dBudget & "," & dBudgetC & "," & dActual & "," & dActualC & ",'" & _
                                             Format(CDate(ViewState("RepDate")), "yyyy-MM-dd") & "'," & Session("UserID") & ",1," & _
                                             iStatus & ",'" & Format(Now(), "yyyy-MM-dd HH:mm") & ":00')"
        'Response.Write(sSql)
        'Response.End()
        cD.CommandText = sSql
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Try
            cD.ExecuteNonQuery()

        Catch ex As Exception
            Response.Write(sSql)
            'Throw ex

        End Try
        dbConnection.Close()
    End Sub

    Protected Sub btnpreprint_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnpreprint.Click
        If DDLFrames.SelectedValue <> vbNullString Then
            Response.Redirect("~/FrameRep.aspx?P=1&F=" & DDLFrames.SelectedValue & "&S=" & DDLServices.SelectedValue & "&D=" & ddlWM.SelectedValue & "&SN=" & DDLServices.SelectedItem.Text & "&FN=" & DDLFrames.SelectedItem.Text)
        End If
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        If Request.QueryString("P") IsNot Nothing Then
            Page.MasterPageFile = "sherutNOMENU.master"
        End If
    End Sub
    Protected Sub PANELPRINT_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles PANELPRINT.PreRender
        Dim pnl As Panel = CType(sender, Panel)
        If bPrint Then pnl.Visible = True Else pnl.Visible = False
    End Sub

    Protected Sub DDLFrames_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLFrames.SelectedIndexChanged
        cRowStat.Clear()
        BuildCollections(False)
    End Sub

    Protected Sub btnMngRep_Click(sender As Object, e As System.EventArgs) Handles btnMngRep.Click
        bSaveReport = True
        ViewState("RepDate") = ddlWM.SelectedValue
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim sql As String = "SELECT FrameID,ServiceID From FrameList Where ServiceID in (1,3,4,8,12,13,14) "
        If IsReportClosed(CDate(ddlWM.SelectedValue)) Then
            If DDLFrames.SelectedValue <> vbNullString Then
                sql &= " AND FrameID=" & DDLFrames.SelectedValue
            ElseIf DDLServices.SelectedValue <> vbNullString Then
                sql &= " AND ServiceID=" & DDLServices.SelectedValue
            End If
        End If

        Dim cD As New SqlCommand(sql, dbConnection)
        dbConnection.Open()
        Dim cFrm As New Collection
        Dim cSrv As New Collection
        Dim dr As SqlDataReader = cD.ExecuteReader
        While dr.Read
            cFrm.Add(dr("FrameID"))
            cSrv.Add(dr("ServiceID"))
        End While
        dbConnection.Close()
        For i = 1 To cFrm.Count
            ViewState("ServiceID") = cSrv(i)
            ViewState("FrameID") = cFrm(i)
            BuildCollections(True)
            ShowRep()
        Next

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As System.EventArgs) Handles btnSave.Click
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand(vbNullString, dbConnection)
        cD.CommandType = Data.CommandType.Text

        dbConnection.Open()
        For i = 1 To 18
            Dim rmzr As Ramzor = FindControlRecursive(Page, "Ramzor" & i)
            If rmzr IsNot Nothing Then
                If rmzr.Visible Then
                    If rmzr.SelectedValue <> rmzr.OrgSelectedValue Then
                        Dim sql As String = "DELETE FROM p0t_FrameRepCorrection WHERE FrameID=" & DDLFrames.SelectedValue & " AND RowNumber=" & i & " AND AsofDate='" & Format(CDate(ddlWM.SelectedValue), "yyyy-MM-dd") & "' "
                        If rmzr.SelectedValue <> 0 Then sql &= "INSERT INTO p0t_FrameRepCorrection (FrameID,RowNumber,AsofDate,Status,UserID,Loadtime) VALUES(" & DDLFrames.SelectedValue & "," & i & ",'" & Format(CDate(ddlWM.SelectedValue), "yyyy-MM-dd") & "'," & rmzr.SelectedValue & "," & Session("UserID") & ",'" & Format(Now(), "yyyy-MM-dd") & "')"
                        cD.CommandText = sql
                        cD.ExecuteNonQuery()
                    End If
                End If
            End If
        Next
        dbConnection.Close()
    End Sub

    Sub LoadClosedReport()
        If DDLFrames.SelectedValue = vbNullString Then Exit Sub
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("SELECT Number, ISNULL(Service_3,Service_2) As FrameName, Service_1 As ServiceName, AsofDate,  FinanceFrameID, FrameID" & _
                                 ", FrameManager, MngrStartDate, FrameOrd, RowNumber, Ord, Description, Status, Budget, Actual, BudgetC, ActualC, Cnt" & _
                                 ", YearType, OrgStatus, ValidDate " & _
                                 "FROM dbo.NumberTable(1,18) " & _
                                 "LEFT OUTER JOIN (SELECT * " & _
                                 "FROM MNGFrameRep " & _
                                 "Where FrameID=" & DDLFrames.SelectedValue & " AND AsofDate='" & Format(CDate(ddlWM.SelectedValue), "yyyy-MM-dd") & "') m ON Number = RowNumber " & _
                                 "ORDER BY  ORD", dbConnection)
        cD.CommandType = Data.CommandType.Text
        dbConnection.Open()
        Dim dr As SqlDataReader = cD.ExecuteReader
        While dr.Read
            If lblFrame.Text = "&nbsp;" And Not IsDBNull(dr("FrameName")) Then
                tr1.Visible = True
                lblFrame.Text = dr("FrameName")
                lblService.Text = dr("ServiceName")
                tr2.Visible = True
                lblMNGR.Text = dr("FrameManager")
                lblStartDate.Text = If(IsDBNull(dr("MngrStartDate")), vbNullString, Format(dr("MngrStartDate"), "MMM-yy"))
            End If

            Select Case dr("NUmber")

                Case 1
                    iGeneralStatus = If(IsDBNull(dr("Status")), 0, dr("Status"))

                Case 2

                Case 3
                    If IsDBNull(dr("RowNumber")) Then
                        tr3.Visible = False
                    Else
                        tr3.Visible = True
                        lblLicesnce.Text = If(IsDBNull(dr("ValidDate")), vbNullString, Format(dr("ValidDate"), "dd/MM/yyyy"))
                        ClosedRamzor(3, dr("Status"), dr("OrgStatus"))
                    End If

                Case 4
                    If IsDBNull(dr("RowNumber")) Then
                        tr4.Visible = False
                    Else
                        tr4.Visible = True
                        lblFireF.Text = If(IsDBNull(dr("ValidDate")), vbNullString, Format(dr("ValidDate"), "dd/MM/yyyy"))
                        ClosedRamzor(4, dr("Status"), dr("OrgStatus"))
                    End If

                Case 5
                    If IsDBNull(dr("RowNumber")) Then
                        tr5.Visible = False
                    Else
                        tr5.Visible = True
                        lblNewCandcnt.Text = If(IsDBNull(dr("Actual")), vbNullString, Format(dr("Actual"), "#,###"))
                        ClosedRamzor(5, dr("Status"), dr("OrgStatus"))
                    End If

                Case 6

                Case 7
                    If IsDBNull(dr("RowNumber")) Then
                        tr7.Visible = False
                    Else
                        tr7.Visible = True
                        Dim iY As Integer = If(IsDBNull(dr("BudgetC")), 0, dr("BudgetC"))
                        Dim iA As Integer = If(IsDBNull(dr("ActualC")), 0, dr("ActualC"))
                        Dim iYM As Integer = If(IsDBNull(dr("Budget")), 0, dr("Budget"))
                        Dim iAM As Integer = If(IsDBNull(dr("Actual")), 0, dr("Actual"))
                        Dim iDm As Integer = iAM - iYM
                        lbltarAct.Text = "יעד חודש הדוח: " & iY & ", בפועל חודש הדוח: " & iA & "<br /> הפרש מצטבר: " & iDm
                        Dim dPYL As Double = CDbl(iAM) / CDbl(iYM)
                        lblCustPercnt.Text = Format(dPYL, "##0%")
                        ClosedRamzor(7, dr("Status"), dr("OrgStatus"))
                    End If

                Case 8
                    If IsDBNull(dr("RowNumber")) Then
                        tr8.Visible = False
                    Else
                        tr8.Visible = True
                        lblAccepted.Text = dr("Actual")
                        ClosedRamzor(8, dr("Status"), dr("OrgStatus"))
                    End If

                Case 9
                    If IsDBNull(dr("RowNumber")) Then
                        tr9.Visible = False
                    Else
                        tr9.Visible = True
                        lblLeft.Text = dr("Actual")
                        ClosedRamzor(9, dr("Status"), dr("OrgStatus"))
                    End If

                Case 10
                    If IsDBNull(dr("RowNumber")) Then
                        tr10.Visible = False
                    Else
                        tr10.Visible = True
                        Dim s As String = "<table border=""0"">"
                        If Not IsDBNull(dr("ValidDate")) Then
                            Dim deX As DateTime = dr("ValidDate")
                            If dr("Budget") > 0 Then s &= "<tr><td>" & Format(deX, "MMMM") & ":</td><td>" & dr("Budget") & "</td></tr>"
                            If dr("Actual") > 0 Then s &= "<tr><td>" & Format(DateAdd(DateInterval.Month, 1, deX), "MMMM") & ":</td><td>" & dr("Actual") & "</td></tr>"
                            If dr("BudgetC") > 0 Then s &= "<tr><td>" & Format(DateAdd(DateInterval.Month, 2, deX), "MMMM") & ":</td><td>" & dr("BudgetC") & "</td></tr>"
                            lblExEvent.Text = s & "</table>"
                        End If
                        ClosedRamzor(10, dr("Status"), dr("OrgStatus"))
                    End If

                Case 11
                    If IsDBNull(dr("RowNumber")) Then
                        tr11.Visible = False
                    Else
                        tr11.Visible = True
                        lblSISCNT.Text = "שאלונים תקפים: " & dr("Actual")
                        lblSISPER.Text = Format(dr("Actual") / dr("Budget"), "#%")
                        ClosedRamzor(11, dr("Status"), dr("OrgStatus"))
                    End If

                Case 12
                    If IsDBNull(dr("RowNumber")) Then
                        tr12.Visible = False
                    Else
                        tr12.Visible = True
                        lblQCNT.Text = "שאלונים תקפים: " & dr("Actual")
                        lblQPER.Text = Format(dr("Actual") / dr("Budget"), "#%")
                        ClosedRamzor(12, dr("Status"), dr("OrgStatus"))
                    End If

                Case 13
                    If IsDBNull(dr("RowNumber")) Then
                        tr13.Visible = False
                    Else
                        tr13.Visible = True
                        lblQPCNT.Text = "שאלונים תקפים: " & dr("Actual")
                        lblQPPER.Text = Format(dr("Actual") / dr("Budget"), "#%")
                        ClosedRamzor(13, dr("Status"), dr("OrgStatus"))
                    End If

                Case 14
                    If IsDBNull(dr("RowNumber")) Then
                        tr14.Visible = False
                    Else
                        tr14.Visible = True
                        lblMPCnt.Text = "<table><tr><td>תקציב: </td><td>" & Format(dr("Budget"), "#,###") & "</td></tr><tr><td> בפועל: </td><td>" & Format(dr("Actual"), "#,###") & "</td></tr><tr><td> הפרש: </td><td>" & Format(dr("Budget") - dr("Actual"), "#,###") & "</td></tr></table>"
                        lblMPPER.Text = Format(dr("Actual") / dr("Budget"), "#0%")
                        lblHdrMPrep.Text = "תקציב כ""א  "
                        If Not IsDBNull(dr("ValidDate")) Then
                            Dim dMP As DateTime = dr("ValidDate")
                            lblHdrMPrep.Text &= "(" & Format(dMP, "MMM-yy") & ")"
                        End If
                        ClosedRamzor(14, dr("Status"), dr("OrgStatus"))
                    End If

                Case 15
                    If IsDBNull(dr("RowNumber")) Then
                        tr15.Visible = False
                    Else
                        tr15.Visible = True
                        lblnotPaid.Text = dr("Actual")
                        lblNotPaidPER.Text = "&nbsp;"
                        ClosedRamzor(15, dr("Status"), dr("OrgStatus"))
                    End If

                Case 16
                    If IsDBNull(dr("RowNumber")) Then
                        tr16.Visible = False
                    Else
                        tr16.Visible = True
                        Dim s As String = "<table>"
                        s &= "<tr><td>תקציב:</td><td>" & Format(dr("Budget"), "#,###") & "</td></tr>"
                        s &= "<tr><td>בפועל:</td><td>" & Format(dr("Actual"), "#,###") & "</td></tr>"
                        lblExp.Text = s & "<tr><td>הפרש:</td><td>" & Format(dr("Budget") - dr("Actual"), "#,###") & "</td></tr></table>"
                        lblExpPer.Text = Format(dr("Actual") / dr("Budget"), "##0%")
                        ClosedRamzor(16, dr("Status"), dr("OrgStatus"))
                    End If

                Case 17
                    If IsDBNull(dr("RowNumber")) Then
                        tr17.Visible = False
                    Else
                        tr17.Visible = True
                        Dim s As String = "<table>"
                        s &= "<tr><td>תקציב:</td><td>" & Format(dr("Budget"), "#,###") & "</td></tr>"
                        s &= "<tr><td>בפועל:</td><td>" & Format(dr("Actual"), "#,###") & "</td></tr>"
                        lblHITZPer.Text = s & "<tr><td>הפרש:</td><td>" & Format(dr("Actual") - dr("Budget"), "#,###") & "</td></tr></table>"
                        lblHITZPer.Text = Format(dr("Actual") / dr("Budget"), "##0%")
                        ClosedRamzor(17, dr("Status"), dr("OrgStatus"))
                    End If

                Case 18
                    If IsDBNull(dr("RowNumber")) Then
                        tr18.Visible = False
                    Else
                        tr18.Visible = True
                        Dim s As String = "<table>"
                        s &= "<tr><td>תקציב:</td><td>" & Format(dr("Budget"), "#,###") & "</td></tr>"
                        s &= "<tr><td>בפועל:</td><td>" & Format(dr("Actual"), "#,###") & "</td></tr>"
                        lblPEIL.Text = s & "<tr><td>הפרש:</td><td>" & Format(dr("Actual") - dr("Budget"), "#,###") & "</td></tr></table>"
                        lblPEILPer.Text = Format(dr("Actual") / dr("Budget"), "##0%")
                        ClosedRamzor(18, dr("Status"), dr("OrgStatus"))
                    End If

            End Select
        End While
        dr.Close()
        dbConnection.Close()

    End Sub
    Sub ClosedRamzor(RowN As Integer, iStat As Integer, OStat As Integer)
        Dim iCS As Integer
        If CBCorrect.Checked Then iCS = OStat Else iCS = iStat
        Dim s As String = vbNullString
        Select Case iCS
            Case 1
                s = If(Request.QueryString("P") IsNot Nothing, "images/Red_p.jpg", "images/Red.jpg")
            Case 2
                s = If(Request.QueryString("P") IsNot Nothing, "images/Yellow_p.jpg", "images/Yellow.jpg")
            Case 3
                s = If(Request.QueryString("P") IsNot Nothing, "images/Green_p.jpg", "images/Green.jpg")

            Case Else
                s = "images/Gray.jpg"

        End Select
        RamzorLight(RowN, iStat, s, OStat)
    End Sub

    Protected Sub btnMngRep_PreRender(sender As Object, e As System.EventArgs) Handles btnMngRep.PreRender
        If CBCorrect.Visible Then
            If IsReportClosed(CDate(ddlWM.SelectedValue)) Then
                btnMngRep.Enabled = False Or CBCorrect.Checked
                btnMngRep.OnClientClick = Nothing
            Else
                btnMngRep.OnClientClick = "return confirm('האם לסגור את הדוח לתאריך שנבחר לכל המסגרות (הפעולה לוקחת מספר דקות)');"
                btnMngRep.Enabled = True
            End If
        End If
    End Sub

    Protected Sub btnSave_PreRender(sender As Object, e As System.EventArgs) Handles btnSave.PreRender
        btnSave.Enabled = CBCorrect.Checked
    End Sub

    Protected Sub CBCorrect_PreRender(sender As Object, e As System.EventArgs) Handles CBCorrect.PreRender
        CBCorrect.Enabled = IsReportClosed(CDate(ddlWM.SelectedValue)) Or CBCorrect.Checked
    End Sub
End Class
