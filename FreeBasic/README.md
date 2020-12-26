# Notas acerca de MIDI 
```
Hay  16 canales(n), 1 - 16 (en decimal), 0 - F (en hexa). 
Nota off = 8n, desde 80 to 8F hexa, 8 = note off (128 a 143 decimal)
Nota on  = 9n, desde 90 to 9F hexa, 9 = note on  (144 a 159 decimal)
Polyphonic aftertouch = An
Control change =        Bn
Program change =        Cn
Channel aftertouch =    Dn
Pitch wheel =           En
noteon  3 bytes: 8n + note + vel
noteoff 3 bytes: 9n + note + vel
Input Real de teclado (por programa se puede usar todo)
No Podemos probar lo que recibe la Pc son los 17 bytes del teclado
pero los convierte a 24 ¿?...Si imprimo el input desde un teclado de un acorde
y veo todos los 6, 12 ,18 o 24 bytes para notas en simultaneo de 1, 2, 3, o 4 notas 
es que el sistema los convirtio. Sino deberiamos ver, 5, 9, 13, 17 bytes
Acorde  6 * 4 = 24 byes pero solo 17 bytes se usan para input real
noteoff = noteon con vel=0
nota sola  = 9n + note + vel / note +vel=0 = 5 bytes
4 notas acorde on  = 9n + note1 + vel1 + note2 + vel2 + note3 +vel3 + note4 + vel4 = 9 bytes
4 notas acorde off =      note1 + vel0 + note2 + vel0 + note3 +vel0 + note4 + vel0 = 8 bytes
el byte 17  es note on, 9n al comienzo, antes de los  16 bytes.
Se ahorran  8 bytes.
Nots desde 0 to 127, hay 11 octavas (C-2,C-1,C0,C1,C2,C3,C4,C5,C6,C7,C8).
C central, nota C3 = 60, 6ta octava.
Para simplificar suponemos acorde con la misma  velocidad en todas sus notas
4 notes chord on  = 9n + note1 + note2 + note3 + note4 + vel  = 6 bytes
4 notes chord off =      note1 + note2 + note3 + note4 + vel0 = 5 bytes
en el programa solo 'on' es necesario como entrada = 6 bytes
cadena= note1, note2, note3, note4
9n y vel0 se deducen 



```
- Debuguear en 64 bits,Fbdebug tiene alguna dificultad, yo no he podido debuguear pero 
  encontré que se puede usar Visual Studio, solo hay que generar el archivo pdb, como freebasic
  con gcc usa un estilo parecido al de D language DWARF al grabar los simbolos, yo he usado 
  el extractor de simbolos cv2pdb para D (el cual ya conocia) extraje el pdb con cv2pdb archivo.exe, 
  y lo puse al lado del mismo en Visual Studio (uso version 8) se abre como proyecto 
  al ejecutable y luego se abre el archivo fuente (no como proyecto ),luego al dar F5 empieza a 
  debuguear no es perfecto pero algo sirve,,  https://github.com/rainers/cv2pdb/releases/tag/v0.38
  En el menu de Visual Studio hay ajustes que he hecho , Herramientas OPciones, Depuracion
  simbolos, puse el path donde estan mis objetos, habilite depuracion nativa en todas partes
  donde encontré esa opcion, en General hay otras opciones para probar.


  