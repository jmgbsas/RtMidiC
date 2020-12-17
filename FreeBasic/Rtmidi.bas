#include "C:\IT64\FbEdit\Inc\mod_rtmidi_c.bi"
' the path to yout installation 
#Inclib  "rtmidi.dll"

dim midiin As   RtMidiInPtr 
dim midiout As  RtMidiOutPtr
Dim device As RtMidiPtr
On Error Goto errorhandler

midiin  = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()


Dim As UInteger portsin, portsout

 portsin  =  rtmidi_get_port_count (midiin)
 portsout =  rtmidi_get_port_count (midiout)
Print portsin
Print portsout

Dim nombre As ZString ptr

Print ""
Print  "outut ports"
Dim i As INTeger
for i = 0 to portsout -1 
   nombre = rtmidi_get_port_name(midiout, i)
   print *nombre
Next   
Print ""
print "input ports"
for i = 0 to  portsin -1  
   nombre = rtmidi_get_port_name(midiin, i)
   print *nombre
Next
' (byval device as RtMidiOutPtr, byval message as ubyte ptr, byval length as integer) as integer

Dim message(1 To 3) As UBYTE 
Dim leng As UInteger <8>


Dim result As Integer

portsout = 0
nombre = Allocate( 25 )
' here the name and port, are hard coded manually but you can do it 
' asking to select one output and port
*nombre = "CoolSoft VirtualMIDISynth"
' *nombre = "Microsoft GS WavetableSynth"
rtmidi_open_port (midiout,portsout, nombre)
Sleep (50)
'sending  message
 
message(1) = 144
message(2) = 64
message(3) = 127
dim p as UBYTE ptr = @message(1)
leng = 3
 

Print "sending some midi "
Sleep (100)
Print "midiout ", midiout
Print "ptr mesg ", p
Print "length msg", leng

result = rtmidi_out_send_message (midiout, p, leng)
Print "result for on ", result

Sleep (1500)

message(1) = 128
message(2) = 64
message(3) = 40

result = rtmidi_out_send_message (midiout, p, leng)
Print "send mensagge off ", result
Print "midiout ", midiout
Print "ptr mesg ", p
Print "length msg", leng

'code for  get in message
Dim size As UInteger<64> 
Dim sizeptr As UInteger<64> Ptr = @size
nombre = Allocate( 22 )
*nombre = "E-DSP MIDI Port [BC00]" ' hrdcoded for now you first midi in dev

rtmidi_open_port (midiin, portsout, nombre)
rtmidi_in_get_message(midiin, p, sizeptr )
For i = 1 To 10
 Print message (i)
Next
rtmidi_close_port(midiout)
rtmidi_out_free(midiout) 
rtmidi_close_port(midiin)
rtmidi_out_free(midiin) 

Sleep
End

errorhandler:
Dim e As Integer 
' this routine do not run rtmidi_error(Rtmidierr, errorString) , butFreBasic manage for itself
e = Err
Print "Error detected ", e
Print Erl, Erfn,Ermn,Err

Sleep
