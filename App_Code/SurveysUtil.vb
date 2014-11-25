Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports WRCookies
Imports BesConst
Public Class SurveysUtil
    Shared Sub SetSurveyCookies(iSurvewyID As Integer, ByRef sSurveyName As String, ByRef sShortDesc As String, ByRef dStartDate As DateTime, ByRef dEndDate As DateTime, Optional LanguageID As Integer = 1, Optional sConnName As String = "BeBook10")
        Dim iSingleFrame As Integer = 0
        Dim connStr As String = ConfigurationManager.ConnectionStrings(sConnName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("SELECT ISNULL(l.Survey,s.Survey) as Survey ,ShortDescription,PWD,StartDate,EndDate,ISNULL(SingleFrame,0) As SingleFrame From SV_Surveys s LEFT OUTER JOIN (Select SurveyID,Survey From SV_Surveys_L Where LanguageID=" & LanguageID & ") l on l.SurveyID=s.SurveyID Where s.SurveyID = " & iSurvewyID, dbConnection)
        dbConnection.Open()
        Try
            Dim dr As SqlDataReader = ConComp.ExecuteReader
            If dr.Read Then

                ' Read Password (if present), otherwise do nothing 

                If Not IsDBNull(dr("PWD")) Then

                    WriteCookie(SurveyCookiesKey, SurveyCookiePWD, dr("PWD"))
                    '                 HttpContext.Current.Session("PWD") = dr("pwd")

                    sSurveyName = dr("Survey")
                    sShortDesc = dr("ShortDescription")
                    dStartDate = dr("StartDate")
                    dEndDate = dr("EndDate")
                    iSingleFrame = dr("SingleFrame")


                    WriteCookie(SurveyCookiesKey, SurveyCookieShort, sShortDesc)
                    WriteCookie(SurveyCookiesKey, SurveyCookieName, sSurveyName)
                    WriteCookie(SurveyCookiesKey, SurveyCookieSingleFrameFlag, iSingleFrame.ToString)

                End If
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Shared Function SurveyName(iSurveyID As Integer, AltName As String, Optional sConnName As String = "BeBook10") As String
        Dim sSG As String = vbNullString, sSD As String = vbNullString
        Dim connStr As String = ConfigurationManager.ConnectionStrings(sConnName).ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim cD As New SqlCommand("SELECT ShortDescription, SurveyGroup FROM SV_Surveys s LEFT OUTER JOIN SV_SurveyGroups g on g.SurveyGroupID = s.SurveyGroupID WHERE s.SurveyID = " & iSurveyID, dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader
        Try
            dr = cD.ExecuteReader
            If dr.Read Then
                sSG = dr("SurveyGroup")
                sSD = dr("ShortDescription")
            End If
        Catch ex As Exception
        End Try
        If dr IsNot Nothing Then dr.Close()
        dbConnection.Close()
        If sSD = vbNullString Then sSD = AltName Else sSD = sSG & " - " & sSD
        Return sSD
    End Function



End Class
