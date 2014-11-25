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


Public Class BalanceRow
    Private _CFDate As DateTime

    Public Property CFDate() As DateTime
        Get
            Return _CFDate
        End Get
        Set(ByVal value As DateTime)
            _CFDate = value
        End Set
    End Property

    Private _TotalBalance As Double

    Public Property TotalBalance() As Double
        Get
            Return _totalbalance
        End Get
        Set(ByVal value As Double)
            _totalbalance = value
        End Set
    End Property
    Private _BankID As Integer
    Public Property BankID() As Integer
        Get
            Return _BankID
        End Get
        Set(ByVal value As Integer)
            _BankID = value
        End Set
    End Property

    'Public Sub New()

    '    '
    '    ' TODO: Add constructor logic here
    '    '
    'End Sub

    Public Sub New(ByVal TotalBalance As Double, ByVal TotalObligo As Double)

        _CFDate = CFDate
        _TotalBalance = TotalBalance
        _BankID = BankID
    End Sub
End Class

