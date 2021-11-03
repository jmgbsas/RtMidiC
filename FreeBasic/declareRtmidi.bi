'#Include Once "windows.bi" 
#Include once  "file.bi"
#include "mod_rtmidi_c.bi"
#Inclib  "rtmidi"

dim Shared midiin As   RtMidiInPtr 
dim Shared midiout As  RtMidiOutPtr
Declare sub tuplet (cadena As String )
Declare sub noteoff( note As UByte, canal As integer)
Declare Sub noteon	( note As UByte, vel As UByte,canal As integer) 
Declare Sub note2on	( note1 As UByte, note2 As UByte, vel As UByte,canal As integer)
Declare Sub note2off	( note1 As UByte, note2 As UByte, canal As integer)
Declare Sub note3on	( note1 As UByte, note2 As UByte, note3 As UByte, vel As UByte,canal As integer)
Declare Sub note3off	( note1 As UByte, note2 As UByte, note3 As UByte, canal As integer)
Declare Sub note4on	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, vel As UByte,canal As integer)
Declare Sub note4off	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, canal As integer)
Declare Sub note5on	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte, note5 As UByte, vel As UByte, canal As integer)
Declare Sub note5off	( note1 As UByte, note2 As UByte, note3 As UByte, note4 As UByte,note5 As UByte, canal As integer)

Dim Shared message(1 To 21) As UByte ' message output 
' maximo seria para un acorde de 5 por ejemplo
' 5 notas + velocidad y canal = 7 bytes...para note on
' si tomamos 10 dedos de las 2 manos serian 10 notas+ vel + canal = 12
' si agregamos velocidad distinta para cada nota serian
' 20 mas canal = 21 bytes...maximo 
' podriamos agregar presion promedio aftertouch etc pero serin mensajes independientes 
Dim errorString As ZString Ptr
Dim Shared p as UBYTE Ptr = @message(1) 
Dim size As UInteger<64> 
Dim sizeptr As UInteger<64> Ptr = @size
 

On Error Goto errorhandler
