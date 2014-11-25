Imports Microsoft.VisualBasic

Public Class BesConst

    ' Defs

    Public Const AppAddress As String = vbNullstring

    ' Surveys

    Public Const SurveySessionTimeout = 240                              ' Session Max Length in Minutes
    Public Const SurveyCookiesKey As String = "survey"                  ' Coockie Collection key Name
    Public Const SurveyCookiePWD As String = "PWD"                      ' Coockie Password key Name"PWDSupplied"
    Public Const SurveyCookiePWDSupplied As String = "PWDSupplied"      ' Coockie Password key Name"PWDSupplied"
    Public Const SurveyCookieName As String = "SurveyName"              ' Coockie Password key Name"PWDSupplied"
    Public Const SurveyCookieShort As String = "ShortDescription"       ' Coockie Password key Name"PWDSupplied"
    Public Const SurveyCookieFormID As String = "FormNO"                ' Coockie Password key Name"PWDSupplied"
    Public Const SurveyCookieSingleFrameFlag As String = "SingleFrame"  ' If in this survey you can select one frame or many
    Public Const SurveyLastSurvey As String = "LastSurvey"              'Last Survey that was  Reported

    ' Printing Variables

    Public Const MasterStyleSheetLink As String = "<link rel='StyleSheet' Href='App_Themes/Master.CSS' Type='text/css' />"
    Public Const PrintingTitleStyle As String = "text-align:center;font-size:x-large; font-weight:bold; color:#AAAAAA;text-align:center;vertical=align:top;"
    Public Const PrintingSubtitleStyle As String = "color:#AAAAAA;text-align:center;vertical=align:top;"
    Public Const PrintingDateUserStyle As String = "text-align:right;vertical=align:top;"

End Class
