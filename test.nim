# ANDO O SEA QUE PRIMERO SE CREA LA DEFAULT Y LUEGO SE USA
# OJO TUVE QUE MODIFICAR EL RTMIDI_C.H PORQUE ANTES DECADA FUNCON
# TENIA UNA LABEL RTMIDIAPI LO BORRE Y CREO EL RTMIDI_CNIM !!!!
# se compila con nim -C -r 
import rtmidi_c, times , os

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
echo "puertos de salida"

for i in 0 ..< portsout  :
   port = rtmidi_get_port_name(midiout, i)
   echo port
echo ""
echo "puertos de entrada"
for i in 0 ..< portsin  :
   port = rtmidi_get_port_name(midiin, i)
   echo port






