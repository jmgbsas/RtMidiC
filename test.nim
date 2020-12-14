# compile and run>   nim c -r test.nim
# Code test.nim

import rtmidi_c 

var  midiin:   RtMidiInPtr 
var  midiout:  RtMidiOutPtr
var  device:   RtMidiPtr

midiin = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()

var portsin  =  rtmidi_get_port_count (midiin)
var portsout =  rtmidi_get_port_count (midiout)

echo portsin
echo portsout

var port: cstring
echo ""
echo "Output ports: "

for i in 0 ..< portsout  :
   port = rtmidi_get_port_name(midiout, i)
   echo port
echo ""

echo "Input Ports: "
for i in 0 ..< portsin  :
   port = rtmidi_get_port_name(midiin, i)
   echo port
