# RtMidiC
Binding, Nim Calling C++ Rtmidi Library, with C Interface rtmidi_c.h 
This is a test while I am learning a little of Nim, and want to apply in freebasic too the 
interoperability learned. The 3 languages are compilers run with MSYS2/ming64 
and all can build with gcc. I believe the performance will be similar, the dll is done in C++.

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
- A binary version of rtmidi.dll for .Net: a fork project of rtmidi, run ok,has 820k of size https://github.com/micdah/RtMidi.Core/tree/master/RtMidi.Core , rename rtmidi.dll as rtmidilib.dll
- In FreeBasic folder are the elements for that language,freebasic can do graphics aplications too
(but here is only console windows ...and you need to add in the compilation command or in the ide -lrtmidil.dll ...
to test in console I use fbc -s console -arch amd64 -l rtmidi.dll ).
More easy is to install rtmidi for MSYS2 with pacman -S mingw-w64-i686-rtmidi
and compile with  fbc -g -s console. 
 and compilation run in 32 or 64 bits  
- Freebasic run in windows and linux and exe files are 10 times smaller in size.
- Another place to download rtmidi and Tutorial https://www.music.mcgill.ca/~gary/rtmidi/index.html#download
```
#include "C:\IT64\FbEdit\Inc\rtmidi_c.bi"
#Inclib  "rtmidi.dll" 
There is 2 functions that the tool swig do a bad convertion in Freebasic case.
sub rtmidi_in_set_callback      and
function rtmidi_in_get_message
for that reason both had an apostrophe when I started (comment in basic)
The rtmidi_in_get_message and both callback lines in rtmidi_c.bi, I could fixed, but not test it yet.
There is amakefile inside folder freebasic is the way to run swig in windows in a shell of Msy2 interminal or
command if Msys2 isin teh PATH ,,and run
$ make rtmidi_c.h     --> and hit enter
the rtmidi_c.bi will be generated, edit it and see the erros comparing with the fixed here.
Warning after the line text with  "all :" in makefile,  the following lines must begin with a Tab,
if not swig will fail. Swig.swg is configuration file come with swig.exe.
Download Swig.exe and modify makefile to your environment. Download rtmidi project and build rtmidi.dll o download
a binary from some place. I did use version 4.0.0 and rtmidi_c.h is for that version. 
if you download another version, convert the rtmidi_c.h from that version.

```
- Freebasic https://sourceforge.net/projects/fbc/files/
- Nim language https://nim-lang.org/
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

