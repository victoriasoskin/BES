
Partial Class Default3
    Inherits System.Web.UI.Page
	Dim t(2) As Single
	Function val(ByVal sF As String, ByVal i As Integer) As Single
		Dim sI As Single = Eval(sF)
		t(i) += sI
		Return sI
	End Function
	Function tval(ByVal i As Integer) As Single
        Return t(i)
	End Function
	Function pval(ByVal i As Integer, ByVal j As Integer) As String
		Return Format(t(i) / t(j), "0.0%")
	End Function
End Class
