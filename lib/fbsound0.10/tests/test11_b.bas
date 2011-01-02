'  ################
' # test11_b.bas #
'################

' example for:
' fbs_GetStreamBuffer(@lpBuffer,@nChannels,@nSamples)

#libpath "../lib"
#include "../inc/fbsound.bi"

const plug_path = "../lib/"
const data_path = "../data/"

' only if not same as exe path
fbs_Set_PlugPath(plug_path)

dim as FBSBOOLEAN ok
ok=fbs_Init()
if ok=false then
  ? "error: fbs_Init() !"
  ? fbs_Get_PlugError()
  beep:sleep:end 1
end if

ok=fbs_Create_MP3Stream(data_path & "legends.mp3")
if ok=false then
  ? "error: fbs_Create_MP3Stream !"
  beep:sleep:end 1
end if

dim as FBS_SAMPLE ptr lpBuffer,lpOld
dim as integer        index,x_max,x,r_max,l_max,nChannels,nSamples
dim as FBS_SAMPLE     l,r

ok=fbs_Play_MP3Stream()
if ok=true then
  while fbs_Get_PlayingStreams()=0
    sleep 10
  wend
else
  ? "error: fbs_Play_Stream() !"
  beep:sleep:end 1
end if

screenres 512,480

while inkey<>chr(27) and (fbs_Get_PlayingStreams>0)
  ok=fbs_Get_StreamBuffer(@lpBuffer,@nChannels,@nSamples)
  if (ok=true) then
    ' plot only an new buffer
    if lpOld<>lpBuffer then
      l_max=0:r_max=0
      if nSamples<512 then 
        x_max=nSamples-1
      else
        x_max=511
      end if
      screenlock:cls
      line (x_max,240)-(0,240),15
      index=0
      for x=0 to x_max
        l=lpBuffer[index]:index+=nChannels
        l_max+=abs(l)
        l shr=7
        line -(x,240+l),1
      next
      l_max shr=13
      line (0,459)-step(l_max,8),3,bf

      if nChannels=2 then
        index=1:pset(0,240),15
        for x=0 to x_max
          r=lpBuffer[index]:index+=nChannels
          r_max+=abs(r)
          r shr=7
          line -(x,240+r),4
        next
        r_max shr=13
        line (0,469)-step(r_max,8),4,bf
      end if
      screenunlock
      lpOld=lpBuffer
    else
      sleep 10
    end if
  else
    ? "error: fbs_GetStreamBuffer() !"
    beep:sleep:exit while
  end if
wend
end
