Imports Microsoft.VisualBasic
Imports System.Web
Imports BesConst

Public Class WRCookies
'    Shared Sub WriteCookie(sSubs As String, sKey As String, sVal As String, Optional iTimeOut As Integer = SurveySessionTimeout)
    Shared Sub WriteCookie(sSubs As String, sKey As String, sVal As String)
       HttpContext.Current.Session(sKey) = sVal

        HttpContext.Current.Response.Cookies(sSubs)(sKey) = sVal
        If sVal IsNot Nothing Then
            HttpContext.Current.Response.Cookies(sSubs)(sKey).GetHashCode()
            HttpContext.Current.Response.Cookies(sSubs).Expires = DateAdd(DateInterval.Minute, SurveySessionTimeout, Now())
'            HttpContext.Current.Response.Cookies(sSubs).Expires = DateAdd(DateInterval.Minute, iTimeOut, Now())
            HttpContext.Current.Response.Cookies(sSubs).HttpOnly = False
        End If

    End Sub
    Shared Function ReadCookie(sSubs As String, sKey As String) As String
        Dim s As String = vbNullString
        If HttpContext.Current.Session(sKey) Is Nothing Then
            If HttpContext.Current.Request.Cookies(sSubs) IsNot Nothing Then
                If HttpContext.Current.Request.Cookies(sSubs)(sKey) IsNot Nothing Then
                    s = HttpContext.Current.Request.Cookies(sSubs)(sKey)
                    HttpContext.Current.Session(sKey) = s
                End If
            End If
        Else
            s = HttpContext.Current.Session(sKey)
        End If
        Return s
    End Function
    Shared Sub clearCookie(sSubs As String)
        HttpContext.Current.Response.Cookies(sSubs).Value = Nothing
        HttpContext.Current.Session.Clear()
    End Sub

    Shared Sub WriteCookie_S(sKey As String, sValue As String)
        Dim sKeyU As String = sKey & "_" & HttpContext.Current.Session("UserID")
        HttpContext.Current.Response.Cookies(sKeyU).Value = sValue
        HttpContext.Current.Response.Cookies(sKeyU).GetHashCode()
        HttpContext.Current.Response.Cookies(sKeyU).Expires = DateAdd(DateInterval.Month, 1, Now())
        HttpContext.Current.Response.Cookies(sKeyU).HttpOnly = False
        HttpContext.Current.Session(sKeyU) = sValue
    End Sub
    Shared Function ReadCookie_S(sKey As String, Optional bUrlEncode As Boolean = False) As String
        Dim sKeyU As String = sKey & "_" & HttpContext.Current.Session("UserID")
        Dim s As String = vbNullString
        If HttpContext.Current.Session(sKeyU) IsNot Nothing Then
            s = HttpContext.Current.Session(sKeyU)
        Else
            If HttpContext.Current.Request.Cookies() IsNot Nothing Then
                If HttpContext.Current.Request.Cookies(sKeyU) IsNot Nothing Then
                    s = HttpContext.Current.Request.Cookies(sKeyU).Value
                End If
            End If
        End If
        Return s
    End Function
End Class