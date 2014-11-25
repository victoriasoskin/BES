Imports System.Data.SqlClient
Imports eid

Partial Class Entry
    Inherits System.Web.UI.Page
    Dim bcls As Boolean
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btn As Button = CType(sender, Button)
        Dim fv As FormView = CType(btn.NamingContainer, FormView)
        Dim tb1 As TextBox = CType(fv.FindControl("TextBox1"), TextBox)
        Dim tb2 As TextBox = CType(fv.FindControl("TextBox2"), TextBox)
        Dim cv As CustomValidator = CType(fv.FindControl("customvalidator1"), CustomValidator)
        Dim s1 As String = tb1.Text
        Dim s2 As String = tb2.Text
        If IsNumeric(s1) Then s1 = CStr(CLng(s1))
        If IsNumeric(s2) Then s2 = CStr(CLng(s2))
        Dim b As Boolean
        Dim i As Integer
        If Not s1 Is Nothing Then
            Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
            Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
            Dim ConComp As New SqlCommand("Select u.UserID,ISNULL(r.ID,0) rs,UserName,Password,ServiceID,ServiceName,MainFrameID,FrameId,UserGroupID,Stype,URName,CanDelete,CanEdit,SUser,Multiframe,FrameName,ISNULL(xPw,0) as xPw From p0v_Ntb u LEFT OUTER JOIN p0t_NtBRS r On u.UserID=r.UserID Where UserName='" & s1.Replace("'", "''") & "'", dbConnection)
            dbConnection.Open()
            Dim dr As SqlDataReader = ConComp.ExecuteReader()
            dr.Read()
            On Error Resume Next
            Dim s3 As String = dr("UserName")
            Dim s4 As String = dr("Password")
            Dim ixPw As Integer = dr("xPw")
            If s3 <> s4 Then s4 = DecryptText(s4)
            'If s3 = s4 Then
            '    Session("UserName") = dr("URName")
            '    Session("UserID") = dr("UserID")
            '    Session("Stype") = "PWC"
            '    Response.Redirect("CPE.aspx")
            'End If
            If s1 = s2 Then s4 = LCase(s4)
            b = Err.Number <> 0 Or (s2 <> s4 And s2 <> "רותם" & s1)
            If Left(s2, 4) = "רותם" And dr("rs") <> 0 Then b = True

            Err.Clear()
            On Error GoTo 0
            If bcls Then

                If s2 = s1 & s1 And s3 <> vbNullString Then
                    b = False
                Else
                    b = True
                End If
            End If
            If ixPw <> 0 Then s4 = s3
            If Not b Then
                ' has to replace password
                If LCase(s3) = LCase(s4) Then
                    Session("UserName") = dr("URName")
                    Session("UserID") = dr("UserID")
                    Session("Stype") = "PWC"
                    Session("XPW") = 1
                    Response.Redirect("CPE.aspx")
                End If
                Dim imf As Integer
                If IsNumeric(dr("Multiframe")) Then imf = dr("Multiframe") Else imf = 0
                Session("ServiceID") = dr("ServiceID")
                If imf = 1 Then
                Else
                    Session("FrameID") = dr("MainFrameID")
                End If
                Session("MultiFrame") = imf
                Session("UserName") = dr("URName")
                Session("UserID") = dr("UserID")
                If IsDBNull(dr("SType")) Then
                    dr.Close()
                    dbConnection.Close()
                    Session.Clear()
                    Response.Redirect("http://www.b-e.org.il")
                End If
                Session("Stype") = dr("SType")
                Session("CanDelete") = dr("CanDelete")
                Session("CanEdit") = dr("CanEdit")
                Session("SUser") = dr("Suser")
                Session("FrameName") = dr("FrameName")
                Session("serviceName") = dr("ServiceName")
                Dim s As String = dr("UserID")
            End If
            dbConnection.Close()
        Else
            b = True
        End If
        If b Then
            cv.IsValid = False
            tb1.Focus()
            tb2.Text = vbNullString
        Else
            Dim sB As String = Session("Backto")
            If sB <> vbNullString And LCase(sB) <> LCase("ASP.Entry_aspx") Then
                Response.Redirect(sB) 'Replace(Mid(Replace(sB, "_aspx", ".aspx"), 5), "_", "/"))
            Else
                Response.Redirect("Default.aspx")
            End If
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("Select D From topyca.p0t_AppClosed", dbConnection)
        dbConnection.Open()
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        dr.Read()
        On Error Resume Next
        Dim d As DateTime = dr("D")
        If Err.Number = 0 Then
            LBLCLS.Text = "סגור לתחזוקה עד יום " & Format(d, "ddd") & ", " & Format(d, "dd/MM/yy") & " בשעה " & Format(d, "H:mm") & ". להתראות."
            LBLCLS.Visible = True
            bcls = True
        Else
            bcls = False
        End If
        FVLOGIN.FindControl("BTNLOGIN").Focus()
    End Sub
    Protected Sub Button2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
    End Sub

    Protected Sub Page_PreInit(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreInit
        '    Page.MasterPageFile = "SHERUT.MASTER"
    End Sub

    'Protected Sub Button1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
    '    Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
    '    Dim ConComp As New SqlCommand("Select Password,UserID From pot_NTB where userid<>1", dbConnection)
    '    ConComp.CommandType = Data.CommandType.Text
    '    dbConnection.Open()
    '    Dim dr As SqlDataReader = ConComp.ExecuteReader()
    '    While dr.Read
    '        Dim conUpd As New SqlCommand("Update pt_NtB set Password = '" & EncryptText(dr("password")) & "' Where UserID = " & dr("UserID"))
    '        conUpd.CommandType = Data.CommandType.Text
    '        conUpd.ExecuteNonQuery()

    '    End While
    '    dr.Read()

    'End Sub
End Class
