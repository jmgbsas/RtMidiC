#Include "declareRtmidi.bi"
' compilar con fbc -s console -arch amd64 -gen gcc
' asi usa md64 y rtmidi de ming64!!!

midiin  = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()

Dim As UInteger portsin, portsout

portsin  =  port_count (midiin)
portsout =  port_count (midiout)
Print portsin
Print portsout

Dim nombre As ZString ptr

Print ""
Print  "Output port"

Dim i As INTeger
for i = 0 to portsout -1 
   nombre = port_name(midiout, i)
   print *nombre
Next   
Print ""
print "Input port "

for i = 0 to  portsin -1  
   nombre = port_name(midiin, i)
   print *nombre
Next

Dim leng As UInteger <8>
Dim result As Integer

portsout = 0
*nombre = ""
open_port (midiout,portsout, nombre)
Sleep (50)
'nota, velocidad,canal 
noteOn 64,127,1
leng = 3
Sleep (100)
result = send_message (midiout, p, leng)

Sleep (1500)
'nota, canal
noteoff  64,1

result = send_message (midiout, p, leng)

'nombre no se llena solo el port
open_port (midiin, portsout, nombre)
get_message(midiin, p, sizeptr )

For i = 1 To 10
 Print message (i)
Next

close_port(midiout)
out_free(midiout) 
close_port(midiin)

Sleep

End
#Include "subRtmidi.bi"

errorhandler:
Dim e As Integer 
e = Err
 Print "Error detected ", e
 Print Erl, Erfn,Ermn,Err
Sleep 
 
