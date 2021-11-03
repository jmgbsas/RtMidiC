# compile and run>   nim c -r test.nim
# Code test.nim

import rtmidic, times , os

var  midiin:   RtMidiInPtr 
var  midiout:  RtMidiOutPtr

midiin = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()
var  device: RtMidiPtr
var portsin  =  rtmidi_get_port_count (midiin)
var portsout =  rtmidi_get_port_count (midiout)
echo portsin
echo portsout

var port: cstring
echo ""
echo "Output ports "

var name: cstring

for i in 0 ..< portsout  :
   port = rtmidi_get_port_name(midiout, i)
   echo port
   if i == 0 :
     name = port
     echo name
   echo ""

echo "Input ports"


for i in 0 ..< portsin  :
   port = rtmidi_get_port_name(midiin, i)
   echo port

rtmidi_open_port(midiout, 0, name)

var msg: array[3, cuchar]
var p: ptr cuchar = addr(msg[0])


msg[0] = 144.cuchar
msg[1] = 64.cuchar
msg[2] = 90.cuchar

var rta:cint
  
 
var leng : cint
leng = 3
rta = rtmidi_out_send_message(midiout, p , leng)
sleep(1500)

# Note Off: 128, 64, 40
msg[0] = 128.cuchar
msg[1] = 64.cuchar
msg[2] = 40.cuchar

rta =  rtmidi_out_send_message(midiout, p, leng) 

rtmidi_close_port(midiout)
rtmidi_out_free(midiout)
