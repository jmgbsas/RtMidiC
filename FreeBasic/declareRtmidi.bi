'#Include Once "windows.bi" 
#Include once  "file.bi"
#include "mod_rtmidi_c.bi"
#Inclib  "rtmidi.dll"

dim Shared midiin As   RtMidiInPtr 
dim Shared midiout As  RtMidiOutPtr
Declare sub tuplet (cadena As String )
Declare sub noteoff( note As UByte, canal As integer)
Declare Sub noteon	( note As UByte, vel As UByte,canal As integer) 

Dim Shared message(1 To 4096) As UByte
Dim errorString As ZString Ptr
Dim p as UBYTE Ptr = @message(1) 
Dim size As UInteger<64> 
Dim sizeptr As UInteger<64> Ptr = @size
 

On Error Goto errorhandler
