'  #################
' # plug-alsa.bas #
'#################
#include "plug.bi"
#include "plug-alsa.bi"

#define MAX_BUFFERS 256
type ALSA
  as FBS_PLUG      Plug
  as snd_pcm_t ptr hDevice
  as zstring * 128 LastError
end type

dim shared _Me as ALSA

sub _init() constructor
  dprint("alsa:()")
  _Me.Plug.Plugname="ALSA"
end sub

sub _exit() destructor
  dprint("alsa:~")
end sub

private _
function AlsaWrite() as integer
  dim as integer ret,nFrames,Framesize,nErrors
  dim as any ptr lpBuffer
  ' that should never hapent
  if _Me.hDevice             = NULL then exit function
  if _Me.Plug.lpCurentBuffer = NULL then exit function
  if _Me.Plug.Buffersize     =    0 then exit function

  nFrames   =_Me.Plug.nFrames
  Framesize =_Me.Plug.Framesize
  lpBuffer  =_Me.Plug.lpCurentBuffer

  while (nFrames>0) and (nErrors<4)
    ret = snd_pcm_writei(_Me.hDevice,lpBuffer,nFrames)
    if ret<0 then
      select case ret
        case EAGAIN:sleep 1
        case EPIPE  ' overun+=1
          ret = snd_pcm_prepare(_Me.hDevice)
          if (ret < 0) then
             nErrors+=1
             _Me.LastError="alsa:write warning can't recovery from underrun."
             dprint(_Me.LastError)
          end if
        case ESTRPIPE ' suspend+=1
          do
            ret = snd_pcm_resume(_Me.hDevice)
            if ret=EAGAIN then sleep 1
          loop while ret= EAGAIN
          if (ret < 0) then
            ret = snd_pcm_prepare(_Me.hDevice)
            if (ret < 0) then 
              nErrors+=1
              _Me.LastError="alsa:write warning can't rsume from suspend."
              dprint(_Me.LastError)
            end if
          end if
        case EBADFD,EIO
          nErrors+=1
          _Me.LastError= "alsa:write fatal error: I/O or file descriptor in bad state!"
          dprint(_Me.LastError)
        case else
          nErrors+=1
          if snd_pcm_prepare(_Me.hDevice) < 0 then 
            _Me.LastError= "alsa:write unknow error! "+str(ret)
            dprint(_Me.LastError)
          end if
      end select
    else
      nFrames-=ret:ret*=Framesize:lpBuffer+=ret
    end if
  wend
  return 1
end function

private _
sub Thread(_B unused as integer)
  dim as integer BufferCounter,ThreadID,ret,lpArg
  lpArg=cint(@_Me.Plug)
  _Me.Plug.lpCurentBuffer=_Me.Plug.lpBuffers[BufferCounter]
  _Me.Plug.FillBuffer(lpArg)
  while _Me.Plug.ThreadExit=false
    ret=AlsaWrite()
    BufferCounter+=1
    if BufferCounter=_Me.Plug.nBuffers then BufferCounter=0
    _Me.Plug.lpCurentBuffer=_Me.Plug.lpBuffers[BufferCounter]
    _Me.Plug.FillBuffer(lpArg)
  wend
end sub

private _
function NumOfDeviceNames() as integer
  return 3
end function

private _
function GetDeviceName(_B index as integer) as string
  select case index
    case 1
      return "hw:1,0"
    case 2
      return "hw:0,0"
    case else
      return "default"
  end select
end function

function _
plug_error() as string export
  dim tmp as string
  tmp=_Me.LastError
  return tmp
end function

function _
plug_isany(_R Plug as FBS_PLUG) as fbsboolean export
  dim as integer ret,i,j
  dim as snd_pcm_t ptr tmp
  dprint("alsa:isany+")
  Plug.Plugname=_Me.Plug.Plugname
  _Me.Plug.DeviceName=""

  for i=0 to NumOfDeviceNames()-1
    ' open device in non blocking mode
    ret = snd_pcm_open(@tmp,GetDeviceName(i), SND_PCM_STREAM_PLAYBACK, NONBLOCK)
    ' device aviable but in use
    if (ret = EAGAIN) then
      for j=1 to 5 ' try 5 seconds
        sleep 1000,1
        ret = snd_pcm_open(@tmp,GetDeviceName(i), SND_PCM_STREAM_PLAYBACK, NONBLOCK)
        if ret>-1 then exit for
      next
    end if
    if ret>-1 then 
      _Me.Plug.DeviceName=GetDeviceName(i)
         Plug.DeviceName=_Me.Plug.DeviceName
      exit for
    end if
  next
  if _Me.Plug.DeviceName="" then 
    _Me.LastError="alsa:plug_isany error can't get any aviable device!"
    dprint(_Me.LastError)
    return false
  end if
  snd_pcm_close tmp
  dprint("alsa:isany-")
  return true
end function

function _
plug_start() as fbsboolean export
  dprint("alsa:start")
  if _Me.hDevice=NULL then 
    _Me.LastError="alsa:plug_start error no device!"
    dprint(_Me.LastError)
    return false
  end if
  ' plug is running
  if _Me.Plug.ThreadID<>NULL then 
    _Me.LastError="alsa:plug_start warning thread is running."
    dprint(_Me.LastError)
    return false
  end if
  _Me.Plug.ThreadExit=false
  _Me.Plug.ThreadID=ThreadCreate(cptr(any ptr,@Thread))

  if _Me.Plug.ThreadID=NULL then 
    _Me.LastError="alsa:plug_start error can't create thread!"
    dprint(_Me.LastError)
    return false
  end if

  return true
end function

function plug_stop () as fbsboolean export
  dprint("alsa:stop")
  if _Me.hDevice=NULL then 
    _Me.LastError="alsa:plug_stop error no open device!"
    dprint(_Me.LastError)
    return false
  end if
  if _Me.Plug.ThreadID=NULL then
    _Me.LastError="alsa:plug_stop warning no thread to stop."
    dprint(_Me.LastError)
    return true
  end if
  _Me.Plug.ThreadExit=true
  Threadwait _Me.Plug.ThreadID
  _Me.Plug.ThreadID=NULL
  'snd_pcm_drain _Me.hDevice
  function=true
end function

function plug_exit () as fbsboolean export
  dim as integer i
  dprint("alsa:exit")
  if _Me.hDevice=NULL then
    _Me.LastError="alsa:plug_exit warning no open device."
    dprint(_Me.LastError)
    return true
  end if
  if _Me.Plug.ThreadID<>NULL then plug_stop()
  snd_pcm_close _Me.hDevice
  _Me.hDevice=NULL
  if _Me.Plug.lpBuffers<>NULL then
    if _Me.Plug.nBuffers>0 then
      for i=0 to _Me.Plug.nBuffers-1
        if _Me.Plug.lpBuffers[i]<>NULL then 
          deallocate _Me.Plug.lpBuffers[i]
          _Me.Plug.lpBuffers[i]=NULL
        end if
      next
    end if
    deallocate _Me.Plug.lpBuffers
    _Me.Plug.lpBuffers=NULL
    _Me.Plug.lpCurentBuffer=NULL
  end if
  function=true
end function

function  plug_init(_R Plug as FBS_PLUG) as fbsboolean export
  dim as snd_pcm_hw_params_t ptr hw
  dim as snd_pcm_sw_params_t ptr sw
  dim as integer ret,Value,nFrames,BufferSizeInFrames
  dprint("alsa:init")
  ' !!! fix it !!!!
  if _Me.hDevice<>NULL then
    _Me.LastError="alsa:plug_init error device is open!"
    dprint(_Me.LastError)
    return false
  end if

  'Overwrite device name
  if Plug.Index<-1 then Plug.Index=-1

  if Plug.Index<>-1 then
      _Me.Plug.DeviceName=GetDeviceName(Plug.Index)
      Plug.DeviceName=_Me.Plug.DeviceName
  end if
  dprint("device:" & _Me.Plug.DeviceName)

  ret = snd_pcm_open(@_Me.hDevice,_Me.Plug.DeviceName, SND_PCM_STREAM_PLAYBACK, NONBLOCK)
  if ret<0 then 
    _Me.LastError="alsa: error can't open device [" + _Me.Plug.DeviceName + "]!"
    dprint(_Me.LastError)
    _Me.hDevice=NULL
    return false
  end if

  ' !!! for ever !!!
  Plug.fmt.nBits=16
  Plug.fmt.Signed=true

  if Plug.fmt.nRate<6000  then Plug.fmt.nRate=6000
  if Plug.fmt.nRate>96000 then Plug.fmt.nRate=96000
  if Plug.fmt.nChannels<1 then Plug.fmt.nChannels=1
  if Plug.fmt.nChannels>2 then Plug.fmt.nChannels=2

  ' qwery hardware param
  snd_pcm_hw_params_malloc(@hw)
  ret = snd_pcm_hw_params_any(_Me.hDevice,hw)
  if (ret < 0) then
    snd_pcm_hw_params_free hw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    _Me.LastError="alsa: error can't allocate hardware resources!"
    dprint(_Me.LastError)
    return false
  end if

  ' set read access mode
  ret = snd_pcm_hw_params_set_access(_Me.hDevice, hw, SND_PCM_ACCESS_RW_INTERLEAVED)
  if (ret < 0) then
    _Me.LastError="alsa: error: can't set interleaved mode!"
    dprint(_Me.LastError)
    snd_pcm_hw_params_free hw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  ' set 16 bit
  ret = snd_pcm_hw_params_set_format(_Me.hDevice,hw,SND_PCM_FORMAT_S16_LE)
  if (ret < 0) then
    _Me.LastError="alsa: error: can't set 16 bit mode!"
    dprint(_Me.LastError)
    snd_pcm_hw_params_free hw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  'set mono
  if Plug.fmt.nChannels=1 then
    ret = snd_pcm_hw_params_set_channels(_Me.hDevice,hw,Plug.fmt.nChannels)
    'not all devices can play in mono
    if (ret < 0) then 
      Plug.fmt.nChannels=2
      _Me.LastError="alsa: warning: can't set 1 channel trying 2 channels."
      dprint(_Me.LastError)
    end if
  end if ' Plug.fmt.nChannels=1

  'set stereo
  if Plug.fmt.nChannels=2 then
    ret = snd_pcm_hw_params_set_channels(_Me.hDevice,hw,Plug.fmt.nChannels)
    if (ret < 0) then
      _Me.LastError="alsa: error: can't set 2 channels!"
      dprint(_Me.LastError)
      snd_pcm_hw_params_free hw
      snd_pcm_close _Me.hDevice
      _Me.hDevice=NULL
      return false
    end if ' trying 1 channel
  end if ' can't set 2 channels

  Plug.Framesize=(Plug.Fmt.nBits shr 3) shl (Plug.Fmt.nChannels-1)

  value=Plug.fmt.nRate 'set speed
  ret = snd_pcm_hw_params_set_rate_near(_Me.hDevice,hw,@value,NULL)
  if (ret < 0) then
     _Me.LastError="alsa: error can't set sample rate to [" + str(Plug.fmt.nRate) + "]!"
     dprint(_Me.LastError)
     snd_pcm_hw_params_free hw
     snd_pcm_close _Me.hDevice
     _Me.hDevice=NULL
     return false
  end if
  if value<>Plug.fmt.nRate then 
    _Me.LastError="alsa: warning: set sample rate from " + str(Plug.fmt.nRate) +" to " + str(value) + "."
    dprint(_Me.LastError)
    Plug.fmt.nRate=Value
  end if

  'now device is open with an usable format
  _Me.Plug.Fmt.nRate    =Plug.fmt.nRate
  _Me.Plug.Fmt.nBits    =Plug.fmt.nBits
  _Me.Plug.Fmt.nChannels=Plug.fmt.nChannels
  _Me.Plug.Fmt.Signed   =Plug.fmt.Signed
  _Me.Plug.FrameSize    =Plug.FrameSize

  if Plug.nBuffers<1 then
     Plug.nBuffers=1
  elseif Plug.nBuffers>max_buffers then
     Plug.nBuffers=max_buffers
  end if

  BufferSizeInFrames=Plug.nFrames*Plug.nBuffers

  ' new method
  ret=snd_pcm_hw_params_set_buffer_size(_Me.hDevice,hw,BufferSizeInFrames)
  if (ret<0) then 
    _Me.LastError="alsa: NEW warning: can't set set buffersize to " & str(BufferSizeInFrames)
    dprint(_Me.LastError)
    Value=BufferSizeInFrames
    ret=snd_pcm_hw_params_set_buffer_size_near(_Me.hDevice,hw,@Value)
    if (ret<0) then
      _Me.LastError="alsa: NEW error: can't set set buffersize near to " & str(BufferSizeInFrames)
      dprint(_Me.LastError)
      snd_pcm_hw_params_free hw
      snd_pcm_close _Me.hDevice
      _Me.hDevice=NULL
      return false
    else
      if (Value<>BufferSizeInFrames) then
        _Me.LastError="alsa: NEW warning: buffersize was changed from " & str(BufferSizeInFrames) & " to " & str(Value)
        dprint(_Me.LastError)
        BufferSizeInFrames=Value
      end if
    end if
  end if

  ret=snd_pcm_hw_params_set_period_size(_Me.hDevice,hw,Plug.nFrames,0)
  if (ret<0) then 
    _Me.LastError="alsa: NEW warning: can't set set periodsize to " & str(Plug.nFrames)
    dprint(_Me.LastError)
    Value=Plug.nFrames
    ret=snd_pcm_hw_params_set_period_size_near(_Me.hDevice,hw,@Value,0)
    if (ret<0) then
      _Me.LastError="alsa: NEW error: can't set set periodsize near to " & str(Plug.nFrames)
      dprint(_Me.LastError)
      snd_pcm_hw_params_free hw
      snd_pcm_close _Me.hDevice
      _Me.hDevice=NULL
      return false
    else
      if (Value<>Plug.nFrames) then
        plug.nFrames=Value
      end if
    end if
  end if

#if 0
  if ret<0 then
    Value=Plug.nBuffers
    ret=snd_pcm_hw_params_set_periods(_Me.hDevice,hw,Plug.nBuffers, 0)
    if (ret < 0) then
      _Me.LastError="alsa:plug_init warning: can't set set periods (nBuffers) to " & str(Plug.nBuffers)
      dprint(_Me.LastError)
      ret=snd_pcm_hw_params_set_periods_near(_Me.hDevice, hw,@Value, 0)
      if ret<0 then
        Value=Plug.nBuffers
        ret=snd_pcm_hw_params_get_periods(hw,@Value, 0)
        if ret<0 then
          _Me.LastError="alsa:plug_init error can't set/get any periods (nBuffers)!"
          dprint(_Me.LastError)
          snd_pcm_hw_params_free hw
          snd_pcm_close _Me.hDevice
          _Me.hDevice=NULL
          return false
        end if
      end if
    end if
    if Value<>Plug.nBuffers then
      _Me.LastError="alsa:plug_init warning: periods (nBuffers) was changed from " + str(Plug.nBuffers) + " to " + str(Value)
      dprint(_Me.LastError)
      Plug.nBuffers=Value
    end if

    if Plug.nFrames<64 then Plug.nFrames=64
    Value=Plug.nFrames
    ret = snd_pcm_hw_params_set_period_size_near(_Me.hDevice, hw, @Value,0)
    if (ret < 0) then
      _Me.LastError="alsa:plug_init error: can't set period size (nFrames) to [" + str(Plug.nFrames) + "]!"
      dprint(_Me.LastError)
      snd_pcm_hw_params_free hw
      snd_pcm_close _Me.hDevice
      _Me.hDevice=NULL
      return false
    end if

    if Value<>Plug.nFrames then 
      _Me.LastError="alsa:plug_init warning: set nFrames from " + str(Plug.nFrames) + " to " + str(Value) + "."
      dprint(_Me.LastError)
      Plug.nFrames=Value
    end if
  end if
#endif

  Plug.nBuffers     =BufferSizeInFrames\Plug.nFrames
  if Plug.nBuffers>MAX_BUFFERS then Plug.nBuffers=MAX_BUFFERS
  Plug.Buffersize   =Plug.nFrames*Plug.Framesize

  _Me.Plug.nBuffers  =Plug.nBuffers
  _Me.Plug.nFrames   =Plug.nFrames
  _Me.Plug.Framesize =Plug.Framesize
  _Me.Plug.Buffersize=Plug.Buffersize
  dprint("nBuffers   : " & str(_Me.Plug.nBuffers  ))
  dprint("nFrames    : " & str(_Me.Plug.nFrames   ))
  dprint("nFramesize : " & str(_Me.Plug.FrameSize ))
  dprint("nBuffersize: " & str(_Me.Plug.BufferSize))
  dprint("wholesize  : " & str(_Me.Plug.Buffersize*_Me.Plug.nBuffers) )
  ' use curent config
  ret = snd_pcm_hw_params(_Me.hDevice,hw)
  if (ret < 0) then
    _Me.LastError="alsa: error can't set new hardware config!"
    dprint(_Me.LastError)
    snd_pcm_hw_params_free hw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL 
    return false
  end if
  snd_pcm_hw_params_free hw
#if 0
  ret = snd_pcm_sw_params_malloc(@sw)
  if (ret<0) then 
    _Me.LastError="alsa: error can't allocate software parameters structure"
    dprint(_Me.LastError)
    snd_pcm_sw_params_free sw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  ret=snd_pcm_sw_params_current(_Me.hDevice,sw)
  if ret<0 then 
    _Me.LastError="alsa: error can't initialize software parameters structure"
    dprint(_Me.LastError)
    snd_pcm_sw_params_free sw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  ret=snd_pcm_sw_params_set_start_threshold(_Me.hDevice,sw, _Me.Plug.nFrames*2)
  if ret<0 then
    _Me.LastError="alsa: error can't set start mode"
    dprint(_Me.LastError)
    snd_pcm_sw_params_free sw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  ret=snd_pcm_sw_params_set_avail_min(_Me.hDevice,sw,_Me.Plug.nFrames)
  if ret<0 then
    _Me.LastError="alsa: error can't set minimum available count"
    dprint(_Me.LastError)
    snd_pcm_sw_params_free sw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if  


  ret=snd_pcm_sw_params(_Me.hDevice,sw)
  if ret<0 then 
    _Me.LastError="alsa: error can't set software parameters"
    dprint(_Me.LastError)
    snd_pcm_sw_params_free sw
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false 
  end if

  snd_pcm_sw_params_free sw
#endif

  ' prepare output
  ret = snd_pcm_prepare(_Me.hDevice)
  if (ret < 0) then
    _Me.LastError="alsa: error can't prepare device!"
    dprint(_Me.LastError)
    snd_pcm_close _Me.hDevice
    _Me.hDevice=NULL
    return false
  end if

  _Me.Plug.lpBuffers=callocate(_Me.Plug.nBuffers*4)
  Plug.lpBuffers=_Me.Plug.lpBuffers
  for Value=0 to _Me.Plug.nBuffers-1
    _Me.Plug.lpBuffers[Value]=callocate(_Me.Plug.Buffersize)
    Plug.lpBuffers[Value]=_Me.Plug.lpBuffers[Value]
  next
  _Me.Plug.FillBuffer=Plug.FillBuffer
  return true ' i like it
end function
