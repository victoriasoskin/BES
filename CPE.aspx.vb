Imports System.Data.SqlClient
Imports System
Imports System.IO
Imports System.Xml
Imports System.Text
Imports System.Security.Cryptography

Partial Class Default3
    Inherits System.Web.UI.Page
    Dim b As Boolean = False

    Protected Sub Page_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("USERID") = 1 Then Button2.Visible = True
    End Sub

    Protected Sub SqlDataSource1_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Updated
        Response.Redirect("Exit.aspx")
    End Sub
    Protected Sub lblhtcol_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Label = CType(sender, Label)
        If Session("XPW") = 1 Then
            lbl.Text = "סיסמא זמנית"
        End If

    End Sub
    Protected Sub DVPW_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVPW.Unload
    End Sub

    Protected Sub DVPW_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DVPW.DataBound
    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
    End Sub
    Public Function PCC(ByVal pt As String, ByVal key As String) As String
        'Plaintext Chaining Cipher
        '(c) David M. Lewis, 2007, All Rights Reserved.
        'stmdk@hotmail.com
        'This is another SIMPLE cipher using plaintext chaining.  The key byte is
        'pre-altered by the previous byte of plaintext, via xor, before it's applied
        'to the next byte of plaintext, via xor.  For added strength we use the
        'output to alter the key preminately for the next chunk of data passed to the
        'encryption function.  This function is symmetrical.
        '
        'You are free to use this code for any non-profit purpose.  Please provide me
        'with credits in your software, should you use it.


        Dim ptloop As Integer 'byte counter
        Dim key_byte As Integer 'Decimal (ASCII) value of key byte
        Dim pt_byte As Integer 'Decimal value of the plaintext (input) byte
        Dim ci_byte As Integer 'Decimal value of the cipher byte (output)
        Dim pr_byte As Integer 'Decimal value of the previous plaintext byte.
        Dim init_key As Integer 'length of key passed
        Dim PCCt As String
        PCCt = vbNullString

        init_key = Len(key) 'save the length for later.
        '^^ Change max key length here.

        For ptloop = 1 To Len(pt) 'One byte at a time.

            pt_byte = Asc(Mid(pt, ptloop, 1)) 'Grab dec value of pt byte.
            key_byte = Asc(Mid(key, ptloop, 1)) 'Grab dec value of key byte.
            key_byte = key_byte Xor pr_byte ' Chain plaintext to key.
            key = key & Chr(key_byte) ' the chained key is appended to key string.
            ci_byte = pt_byte Xor key_byte ' XOR encrypt pt with key.
            PCCt = PCCt & Chr(ci_byte) 'Store encrypted/decrypted byte

        Next ptloop
        key = Right(key, init_key) 'We'r not keeping the original key
        Return PCCt
    End Function

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkb As LinkButton = CType(sender, LinkButton)
        Dim dv As DetailsView = CType(lnkb.NamingContainer, DetailsView)
        Dim tb As TextBox = CType(dv.FindControl("NEWPW2"), TextBox)
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim ConComp As New SqlCommand("update p0t_Ntb set Password = '" & EncryptText(tb.Text) & "',xPw=0 Where UserID = " & Session("UserID"), dbConnection)
        ConComp.CommandType = Data.CommandType.Text

        dbConnection.Open()
        ConComp.ExecuteNonQuery()
        dbConnection.Close()
        Session("XPW") = Nothing
        Response.Redirect("Exit.aspx")
    End Sub
    ' Encrypt the text
    Public Shared Function EncryptText(ByVal strText As String) As String
        Return Encrypt(strText, "&%#@?,:*")
    End Function

    'Decrypt the text 
    Public Shared Function DecryptText(ByVal strText As String) As String
        Return Decrypt(strText, "&%#@?,:*")
    End Function

    'The function used to encrypt the text
    Private Shared Function Encrypt(ByVal strText As String, ByVal strEncrKey _
             As String) As String
        Dim byKey() As Byte = {}
        Dim IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}

        Try
            byKey = System.Text.Encoding.UTF8.GetBytes(Left(strEncrKey, 8))

            Dim des As New DESCryptoServiceProvider()
            Dim inputByteArray() As Byte = Encoding.UTF8.GetBytes(strText)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, des.CreateEncryptor(byKey, IV), CryptoStreamMode.Write)
            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()
            Return Convert.ToBase64String(ms.ToArray())

        Catch ex As Exception
            Return ex.Message
        End Try

    End Function

    'The function used to decrypt the text
    Private Shared Function Decrypt(ByVal strText As String, ByVal sDecrKey _
               As String) As String
        Dim byKey() As Byte = {}
        Dim IV() As Byte = {&H12, &H34, &H56, &H78, &H90, &HAB, &HCD, &HEF}
        Dim inputByteArray(strText.Length) As Byte

        Try
            byKey = System.Text.Encoding.UTF8.GetBytes(Left(sDecrKey, 8))
            Dim des As New DESCryptoServiceProvider()
            inputByteArray = Convert.FromBase64String(strText)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, des.CreateDecryptor(byKey, IV), CryptoStreamMode.Write)

            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()
            Dim encoding As System.Text.Encoding = System.Text.Encoding.UTF8

            Return encoding.GetString(ms.ToArray())

        Catch ex As Exception
            Return ex.Message
        End Try

    End Function

    Protected Sub Button1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim connStr As String = ConfigurationManager.ConnectionStrings("BEBook10").ConnectionString
        Dim dbConnection As System.Data.IDbConnection = New System.Data.SqlClient.SqlConnection(connStr)
        Dim uid As Integer = 0
        dbConnection.Open()
ex1:
        Dim ConComp As New SqlCommand("Select top 1 Password,UserID From p0t_NTB where userid>" & uid, dbConnection)
        ConComp.CommandType = Data.CommandType.Text
        Dim dr As SqlDataReader = ConComp.ExecuteReader()
        If Not dr.Read Then GoTo exxe
        uid = dr("UserID")
        Dim s As String = EncryptText(dr("PassWord"))
        dr.Close()

        Dim conUpd As New SqlCommand("Update p0t_NtB set Password = '" & s & "' Where UserID = " & uid, dbConnection)
        conUpd.CommandType = Data.CommandType.Text
        conUpd.ExecuteNonQuery()

        GoTo ex1
exxe:
        dbConnection.Close()
    End Sub

    Protected Sub Button2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.PreRender

    End Sub
End Class
