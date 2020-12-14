 {.deadCodeElim: on.}
when defined(windows):
  const
    rtmididll* = "rtmidi.dll"
elif defined(macosx):
  const
    rtmididll* = "librtmidi.dylib"
else:
  const
    rtmididll* = "librtmidi.so"
## **********************************************************************
## ! \defgroup C-interface
##     @{
##
##     \brief C interface to realtime MIDI input/output C++ classes.
##
##     RtMidi offers a C-style interface, principally for use in binding
##     RtMidi to other programming languages.  All structs, enums, and
##     functions listed here have direct analogs (and simply call to)
##     items in the C++ RtMidi class and its supporting classes and
##     types
##
## **********************************************************************
## !
##   \file rtmidi_c.h
##

##
## #if defined(RTMIDI_EXPORT)
## #if defined _WIN32 || defined __CYGWIN__
## #define RTMIDIAPI __declspec(dllexport)
## #else
## #define RTMIDIAPI __attribute__((visibility("default")))
## #endif
## #else
## #define RTMIDIAPI //__declspec(dllimport)
## #endif
##
## #ifdef __cplusplus
## extern "C" {
## #endif
##
## ! \brief Wraps an RtMidi object for C function return statuses.

type
  RtMidiWrapper* {.bycopy.} = object
    `ptr`*: pointer            ## ! The wrapped RtMidi object.
    data*: pointer             ## ! True when the last function call was OK.
    ok*: bool                  ## ! If an error occured (ok != true), set to an error message.
    msg*: cstring


## ! \brief Typedef for a generic RtMidi pointer.

type
  RtMidiPtr* = ptr RtMidiWrapper

## ! \brief Typedef for a generic RtMidiIn pointer.

type
  RtMidiInPtr* = ptr RtMidiWrapper

## ! \brief Typedef for a generic RtMidiOut pointer.

type
  RtMidiOutPtr* = ptr RtMidiWrapper

## ! \brief MIDI API specifier arguments.  See \ref RtMidi::Api.

type
  RtMidiApi* {.size: sizeof(cint).} = enum
    RTMIDI_API_UNSPECIFIED,   ## !< Search for a working compiled API.
    RTMIDI_API_MACOSX_CORE,   ## !< Macintosh OS-X CoreMIDI API.
    RTMIDI_API_LINUX_ALSA,    ## !< The Advanced Linux Sound Architecture API.
    RTMIDI_API_UNIX_JACK,     ## !< The Jack Low-Latency MIDI Server API.
    RTMIDI_API_WINDOWS_MM,    ## !< The Microsoft Multimedia MIDI API.
    RTMIDI_API_RTMIDI_DUMMY,  ## !< A compilable but non-functional API.
    RTMIDI_API_NUM            ## !< Number of values in this enum.


## ! \brief Defined RtMidiError types. See \ref RtMidiError::Type.

type
  RtMidiErrorType* {.size: sizeof(cint).} = enum
    RTMIDI_ERROR_WARNING,     ## !< A non-critical error.
    RTMIDI_ERROR_DEBUG_WARNING, ## !< A non-critical error which might be useful for debugging.
    RTMIDI_ERROR_UNSPECIFIED, ## !< The default, unspecified error type.
    RTMIDI_ERROR_NO_DEVICES_FOUND, ## !< No devices found on system.
    RTMIDI_ERROR_INVALID_DEVICE, ## !< An invalid device ID was specified.
    RTMIDI_ERROR_MEMORY_ERROR, ## !< An error occured during memory allocation.
    RTMIDI_ERROR_INVALID_PARAMETER, ## !< An invalid parameter was specified to a function.
    RTMIDI_ERROR_INVALID_USE, ## !< The function was called incorrectly.
    RTMIDI_ERROR_DRIVER_ERROR, ## !< A system driver error occured.
    RTMIDI_ERROR_SYSTEM_ERROR, ## !< A system error occured.
    RTMIDI_ERROR_THREAD_ERROR ## !< A thread error occured.


## ! \brief The type of a RtMidi callback function.
##
##  \param timeStamp   The time at which the message has been received.
##  \param message     The midi message.
##  \param userData    Additional user data for the callback.
##
##  See \ref RtMidiIn::RtMidiCallback.
##

type
  RtMidiCCallback* = proc (timeStamp: cdouble; message: ptr cuchar; messageSize: csize;
                        userData: pointer) {.cdecl.}

##  RtMidi API
## ! \brief Determine the available compiled MIDI APIs.
##
##  If the given `apis` parameter is null, returns the number of available APIs.
##  Otherwise, fill the given apis array with the RtMidi::Api values.
##
##  \param apis  An array or a null value.
##  \param apis_size  Number of elements pointed to by apis
##  \return number of items needed for apis array if apis==NULL, or
##          number of items written to apis array otherwise.  A negative
##          return value indicates an error.
##
##  See \ref RtMidi::getCompiledApi().
##

proc rtmidi_get_compiled_api*(apis: ptr RtMidiApi; apis_size: cuint): cint {.cdecl,
    importc: "rtmidi_get_compiled_api", dynlib: rtmididll.}
## ! \brief Return the name of a specified compiled MIDI API.
## ! See \ref RtMidi::getApiName().

proc rtmidi_api_name*(api: RtMidiApi): cstring {.cdecl, importc: "rtmidi_api_name",
    dynlib: rtmididll.}
## ! \brief Return the display name of a specified compiled MIDI API.
## ! See \ref RtMidi::getApiDisplayName().

proc rtmidi_api_display_name*(api: RtMidiApi): cstring {.cdecl,
    importc: "rtmidi_api_display_name", dynlib: rtmididll.}
## ! \brief Return the compiled MIDI API having the given name.
## ! See \ref RtMidi::getCompiledApiByName().

proc rtmidi_compiled_api_by_name*(name: cstring): RtMidiApi {.cdecl,
    importc: "rtmidi_compiled_api_by_name", dynlib: rtmididll.}
## ! \internal Report an error.

proc rtmidi_error*(`type`: RtMidiErrorType; errorString: cstring) {.cdecl,
    importc: "rtmidi_error", dynlib: rtmididll.}
## ! \brief Open a MIDI port.
##
##  \param port      Must be greater than 0
##  \param portName  Name for the application port.
##
##  See RtMidi::openPort().
##

proc rtmidi_open_port*(device: RtMidiPtr; portNumber: cuint; portName: cstring) {.
    cdecl, importc: "rtmidi_open_port", dynlib: rtmididll.}
## ! \brief Creates a virtual MIDI port to which other software applications can
##  connect.
##
##  \param portName  Name for the application port.
##
##  See RtMidi::openVirtualPort().
##

proc rtmidi_open_virtual_port*(device: RtMidiPtr; portName: cstring) {.cdecl,
    importc: "rtmidi_open_virtual_port", dynlib: rtmididll.}
## ! \brief Close a MIDI connection.
##  See RtMidi::closePort().
##

proc rtmidi_close_port*(device: RtMidiPtr) {.cdecl, importc: "rtmidi_close_port",
    dynlib: rtmididll.}
## ! \brief Return the number of available MIDI ports.
##  See RtMidi::getPortCount().
##

proc rtmidi_get_port_count*(device: RtMidiPtr): cuint {.cdecl,
    importc: "rtmidi_get_port_count", dynlib: rtmididll.}
## ! \brief Return a string identifier for the specified MIDI input port number.
##  See RtMidi::getPortName().
##

proc rtmidi_get_port_name*(device: RtMidiPtr; portNumber: cuint): cstring {.cdecl,
    importc: "rtmidi_get_port_name", dynlib: rtmididll.}
##  RtMidiIn API
##
## ! \brief Create a default RtMidiInPtr value, with no initialization.

proc rtmidi_in_create_default*(): RtMidiInPtr {.cdecl,
    importc: "rtmidi_in_create_default", dynlib: rtmididll.}
## ! \brief Create a  RtMidiInPtr value, with given api, clientName and queueSizeLimit.
##
##   \param api            An optional API id can be specified.
##   \param clientName     An optional client name can be specified. This
##                         will be used to group the ports that are created
##                         by the application.
##   \param queueSizeLimit An optional size of the MIDI input queue can be
##                         specified.
##
##  See RtMidiIn::RtMidiIn().
##

proc rtmidi_in_create*(api: RtMidiApi; clientName: cstring; queueSizeLimit: cuint): RtMidiInPtr {.
    cdecl, importc: "rtmidi_in_create", dynlib: rtmididll.}
## ! \brief Free the given RtMidiInPtr.

proc rtmidi_in_free*(device: RtMidiInPtr) {.cdecl, importc: "rtmidi_in_free",
    dynlib: rtmididll.}
## ! \brief Returns the MIDI API specifier for the given instance of RtMidiIn.
## ! See \ref RtMidiIn::getCurrentApi().

proc rtmidi_in_get_current_api*(device: RtMidiPtr): RtMidiApi {.cdecl,
    importc: "rtmidi_in_get_current_api", dynlib: rtmididll.}
## ! \brief Set a callback function to be invoked for incoming MIDI messages.
## ! See \ref RtMidiIn::setCallback().

proc rtmidi_in_set_callback*(device: RtMidiInPtr; callback: RtMidiCCallback;
                            userData: pointer) {.cdecl,
    importc: "rtmidi_in_set_callback", dynlib: rtmididll.}
## ! \brief Cancel use of the current callback function (if one exists).
## ! See \ref RtMidiIn::cancelCallback().

proc rtmidi_in_cancel_callback*(device: RtMidiInPtr) {.cdecl,
    importc: "rtmidi_in_cancel_callback", dynlib: rtmididll.}
## ! \brief Specify whether certain MIDI message types should be queued or ignored during input.
## ! See \ref RtMidiIn::ignoreTypes().

proc rtmidi_in_ignore_types*(device: RtMidiInPtr; midiSysex: bool; midiTime: bool;
                            midiSense: bool) {.cdecl,
    importc: "rtmidi_in_ignore_types", dynlib: rtmididll.}
## ! Fill the user-provided array with the data bytes for the next available
##  MIDI message in the input queue and return the event delta-time in seconds.
##
##  \param message   Must point to a char* that is already allocated.
##                   SYSEX messages maximum size being 1024, a statically
##                   allocated array could
##                   be sufficient.
##  \param size      Is used to return the size of the message obtained.
##                   Must be set to the size of \ref message when calling.
##
##  See RtMidiIn::getMessage().
##

proc rtmidi_in_get_message*(device: RtMidiInPtr; message: ptr cuchar; size: ptr csize): cdouble {.
    cdecl, importc: "rtmidi_in_get_message", dynlib: rtmididll.}
##  RtMidiOut API
##
## ! \brief Create a default RtMidiInPtr value, with no initialization.

proc rtmidi_out_create_default*(): RtMidiOutPtr {.cdecl,
    importc: "rtmidi_out_create_default", dynlib: rtmididll.}
## ! \brief Create a RtMidiOutPtr value, with given and clientName.
##
##   \param api            An optional API id can be specified.
##   \param clientName     An optional client name can be specified. This
##                         will be used to group the ports that are created
##                         by the application.
##
##  See RtMidiOut::RtMidiOut().
##

proc rtmidi_out_create*(api: RtMidiApi; clientName: cstring): RtMidiOutPtr {.cdecl,
    importc: "rtmidi_out_create", dynlib: rtmididll.}
## ! \brief Free the given RtMidiOutPtr.

proc rtmidi_out_free*(device: RtMidiOutPtr) {.cdecl, importc: "rtmidi_out_free",
    dynlib: rtmididll.}
## ! \brief Returns the MIDI API specifier for the given instance of RtMidiOut.
## ! See \ref RtMidiOut::getCurrentApi().

proc rtmidi_out_get_current_api*(device: RtMidiPtr): RtMidiApi {.cdecl,
    importc: "rtmidi_out_get_current_api", dynlib: rtmididll.}
## ! \brief Immediately send a single message out an open MIDI output port.
## ! See \ref RtMidiOut::sendMessage().

proc rtmidi_out_send_message*(device: RtMidiOutPtr; message: ptr cuchar; length: cint): cint {.
    cdecl, importc: "rtmidi_out_send_message", dynlib: rtmididll.}
## ! }@
