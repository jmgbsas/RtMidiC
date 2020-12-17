# RtMidiC
Binding, Nim Calling C++ Rtmidi Library, with C Interface rtmidi_c.h 
This is a test while I am learning a little of Nim, but too Rust, and want to apply in freebasic the 
interoperability learned. The 3 languages are compilers run with MSYS2/ming64 
and all are using gcc in my case. I believe that the performance will be similar, the dll is done in C++.

The process was simple take rtmidi_c.h and I did convertion with c2nim tool getting rtmin_c.nim.
The only change in rtmini_c.h necesary for me was to delete the label RTMIDIAPI in all the text.
After That we can use the binding to rtmidi.dll in windows or any other plataform. Perhaps to delete that identifier 
could break some funcionality,,this is only a test.

- c2nim is a Tool in https://github.com/nim-lang/c2nim, 
- RtMidi project  in https://github.com/thestk/rtmidi
I add rtmidi.dll library for test it in windows, in the file rtmidi_c.h or rtmidi_c.nim converted,
you can find the names of the rtmidi library for Mac and Linux.
- Mac -> "librtmidi.dylib"
- Linux-> "librtmidi.so"
- Example, compile and run>   nim c -r test.nim,  Code test.nim
- In FreeBasic folder are the elements for that language,freebasic can do graphics aplications too
(but here is only console windows ...and you need to add in the compilation command or in the ide -lrtmidil.dll ...
to test in console I use fbc -s console -arch amd64 -l rtmidi.dll ), I use only rtmidi_c.bi in the Include
(no the mod..)
```
#include "C:\IT64\FbEdit\Inc\rtmidi_c.bi"
#Inclib  "rtmidi.dll" 
There is 2 functions that the tool swig do a bad convertion in Freebasic case,I will search in the future
they are in rtmidi_c.bi commented.
sub rtmidi_in_set_callback      and
function rtmidi_in_get_message
for that reason both had an apostrophe (comment in basic)
The rtmidi_in_get_message I could fixed, but not test it yet,
only callback will be commented, i will try to fix in these days.

```
- The SWIG FB Wrapper to download https://www.freebasic-portal.de/downloads/kommandozeilentools/swig-fb-wrapper-70.html

#code example in nim very basic, I send some midi signals in the file test.nim. 
```
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
```

