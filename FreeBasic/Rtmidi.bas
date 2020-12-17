#Include "declareRtmidi.bi"

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

note ("144,64,127")

leng = 3
 

Print "sending some midi"
Sleep (100)
Print "midiout ", midiout
Print "ptr mesg ", p
Print "length msg", leng

result = send_message (midiout, p, leng)
Print "send result on ", result

Sleep (1500)

note ("128,64,40")

result = send_message (midiout, p, leng)
Print "result send mensagge off ", result
Print "midiout ", midiout
Print "ptr mesg ", p
Print "length msg", leng

'test get in

nombre = Allocate( 22 )

*nombre = "E-DSP MIDI Port [BC00]"

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
 Print "Error detectado ", e
 Print Erl, Erfn,Ermn,Err
Sleep 
 
