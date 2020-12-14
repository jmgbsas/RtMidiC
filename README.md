# RtMidiC
Nim Calling C++ Rtmidi Library, with C Interface rtmidi_c.h (no objects, simple)

The process was simple take rtmidi_c.h and converte with c2nim tool getting rtmin_c.nim.
The only change in rtmini_c.h necesary for me was to delete the label RTMIDIAPI in all the text.
After That we can use the binding to rtmidi.dll in windows or any other pltaform, without object.
- c2nim is a Tool in https://github.com/nim-lang/c2nim, 
- RtMidi project  in https://github.com/thestk/rtmidi
I add rtmidi.dll library for windows to test, in the file rtmidi_c.h or rtmidi_c.nim converted,
you can find the names of the rtmidi library for Mac and Linux.
- Mac -> "librtmidi.dylib"
- Linux-> "librtmidi.so"
- Example, compile and run>   nim c -r test.nim,  Code test.nim
'
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
'
