Sub note(cadena As String ) 

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
       message(in) = CUBYTE(num) 
        Print ">",message(in),in
       num = "" 
   EndIf   
Next
in=in +1
message(in) = CUByte(num)
Print ">", message(in),in

End sub
