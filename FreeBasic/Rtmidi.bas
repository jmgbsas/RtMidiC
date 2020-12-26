#Include Once "windows.bi"
#Include "declareRtmidi.bi"
' compilar con fbc -s console -arch amd64 -gen gcc
' asi usa md64 y rtmidi de ming64!!!

midiin  = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()

Dim Shared As UInteger portsin, portsout

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
Sleep 50
'nota, velocidad,canal 
noteOn 64,87,1
leng = 3
Sleep 1500
'nota, canal
noteoff  64,1

'result = send_message (midiout, p, leng)
' envio de un acorde dupla, triada, cuaternaria
' acorde2, acorde3, acorde4, acorde5...etc
Sleep 500
note2on  60,64,60,1
Sleep 1000
note2off 60,64,1
Sleep 500
note2on  60,67,90,1
Sleep 1500
note2off 60,67,1
Sleep 1000
note3on 60,64,67,60,1
Sleep 1000
note3off 60,64,67,1
Sleep 3000

note4on 60,64,67,71,60,1
Sleep 1000
note4off 60,64,67,71,1
Sleep 3000

note5on 48,60,64,67,71,60,1
Sleep 1000
note5off 48,60,64,67,71,1
Sleep 3000

' --------------------------------
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

