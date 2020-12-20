Sub tuplet(cadena As String ) 'no se usa 
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
	Dim leng As UInteger <8>
	Dim result As Integer
	If canal= 1 Then
		 modo = 128
	Else
	  modo = 128 + canal
	EndIf
	
 message(1) = modo 
 message(2) = note
 message(3) = 0
 leng=3
result = send_message (midiout, p, leng)

End sub
Sub noteon	( note As UByte, vel As UByte,canal As integer)
	' canal 1
	Dim modo As UByte
	Dim leng As UInteger <8>
	Dim result As Integer
	If canal= 1 Then
		 modo = 144
	Else
	  modo = 144 + canal
	EndIf
	
 message(1) = modo 
 message(2) = note
 message(3) = vel
 leng=3
result = send_message (midiout, p, leng)

End Sub
Sub note2on	( note1 As UByte, note2 As UByte, vel As UByte,canal As integer)
	noteon note1,vel, canal
	noteon note2,vel, canal
 
End Sub
Sub note2off	( note1 As UByte, note2 As UByte, canal As integer)
noteoff note1,canal
noteoff note2,canal
 
End Sub
Sub note3on	( note1 As UByte, note2 As UByte, note3 As UByte, vel As UByte,canal As integer)
	noteon note1,vel, canal
	noteon note2,vel, canal
	noteon note3,vel, canal
 
End Sub
Sub note3off	( note1 As UByte, note2 As UByte, note3 As UByte, canal As integer)
noteoff note1,canal
noteoff note2,canal
noteoff note3,canal
 
End Sub
Sub note4on	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, vel As UByte,canal As integer)
	noteon note1,vel, canal
	noteon note2,vel, canal
	noteon note3,vel, canal
	noteon note4,vel, canal
 
End Sub
Sub note4off	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, canal As integer)
noteoff note1,canal
noteoff note2,canal
noteoff note3,canal
noteoff note4,canal
 
End Sub
Sub note5on	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, note5 As UByte, vel As UByte, canal As integer)
	noteon note1,vel, canal
	noteon note2,vel, canal
	noteon note3,vel, canal
	noteon note4,vel, canal
	noteon note5,vel, canal
 
End Sub
Sub note5off	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte,note5 As UByte, canal As integer)
noteoff note1,canal
noteoff note2,canal
noteoff note3,canal
noteoff note4,canal
noteoff note5,canal
 
End Sub
