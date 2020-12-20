Sub tuplet(cadena As String ) 
cadena="144," + cadena ' canal 1 (9n)
'esto servira para un tuplet de los demas lenguajes
' siempre parten de una string de modo que 
' lo haga el lenguje o lo haga uno no deberia ser 
' tan distinto con los procesdores de ahora
Dim leng As integer
leng = Len(cadena)
Dim i As Integer
Dim cha As string
Dim num As String
Dim in As Integer 

in=0
For i= 1 To leng
  cha = Mid(cadena,i,1)
   If  (cha <> (",")) Then
        num = num + cha
   Else 
      in = in + 1
       message(in) = CUByte(num) 
        Print ">",message(in),in
       num = "" 
   EndIf   
Next
in=in +1
message(in) = CUByte(num)
Print ">", message(in),in

End sub
Sub noteoff( note As UByte, canal As integer) 
' canal 1
	Dim modo As UByte
	If canal= 1 Then
		 modo = 128
	EndIf
	
 message(1) = modo 
 message(2) = note
 message(3) = 0


End sub
Sub noteon	( note As UByte, vel As UByte,canal As integer)
	' canal 1
	Dim modo As UByte
	If canal= 1 Then
		 modo = 144
	EndIf
	
 message(1) = modo 
 message(2) = note
 message(3) = vel


End Sub
