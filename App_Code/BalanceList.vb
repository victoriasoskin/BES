Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Collections
Imports System.Collections.Generic
Public Class BalanceList

    Public Sub New()
        '
        ' TODO: Add constructor logic here 
        '
    End Sub

    Public Function GetBalances() As List(Of BalanceRow)

        Dim connStr As String = ConfigurationManager.ConnectionStrings("Book10ConnectionString").ConnectionString
        Dim s As SqlDataSource = New SqlDataSource(connStr, "select Company,BankID,Bank,CFDate,TotalBalance,TotalObligo,CompanyBalance,CompanyObligo,BankBalance,BankObligo from vCFBalancesAndObligos")
        Dim rows As IEnumerable = s.Select(DataSourceSelectArguments.Empty)
        Dim LastDate As DateTime
        Dim CurrentDate As DateTime
        Dim TBalance As Double
        'Dim BankID As Integer
        Dim row As DataRowView
        Dim list As New List(Of BalanceRow)
        For Each row In rows
            CurrentDate = row("CFDate")
            TBalance = row("TotalBalance")
            If CurrentDate <> LastDate Then
                '  list.Add(New BalanceRow(CurrentDate), TBalance))
                LastDate = CurrentDate
            End If
        Next
        Return list
    End Function


End Class
