# RtMidiC
Nim Calling Rtmidi Library form C++ with C Interface (no objects, simple)

The process was simple take rtmidi_c.h andconverte with c2nim tool getting rtmin_c.nim.
The only change in rtmini_c.h ws to delete the label RTMIAAPI.
After That we cn use the binding to rtmidi.dll in windowsforexmple or any other pltaform
Example 
# compile and run>   nim c -r test.nim
Code test.nim

import rtmidi_c 

var  midiin:   RtMidiInPtr 
var  midiout:  RtMidiOutPtr
var  device: RtMidiPtr

midiin = rtmidi_in_create_default()
midiout = rtmidi_out_create_default()

var portsin  =  rtmidi_get_port_count (midiin)
var portsout =  rtmidi_get_port_count (midiout)

echo portsin
echo portsout

var port: cstring
echo ""
echo "puertos de salida"

for i in 0 ..< portsout  :
   port = rtmidi_get_port_name(midiout, i)
   echo port
echo ""

echo "puertos de entrada"
for i in 0 ..< portsin  :
   port = rtmidi_get_port_name(midiin, i)
   echo port
