'  ##############
' # fbsdsp.bas #
'##############
' FBSOUND digital signal math

#include "fbsdsp.bi"

#define M_LN2      0.693147180559945309417
'#define Sinh(x) (exp(x) - exp(-x)) * 0.5f



const NPI2       as single =-PI2
const E          as single = 2.718281828459045


' fast forier transformation
const FFTSHIFT   as integer = 10 ' 8=256,9=512,10=1024 ...
const FFTSIZE    as integer = 1 shl FFTSHIFT
const FFTOSSHIFT as integer = 3  ' 1=2,2=4,3=8 ...
const FFTOS      as integer = 1 shl FFTOSSHIFT
const FFTSS      as integer = FFTSIZE shr FFTOSSHIFT
const FFTFL      as integer = FFTSIZE-FFTSS
const FFTEXPD    as single  = (PI2*FFTSS)/FFTSIZE

public _
function fbs_Pow(_B x as double, _
            _B y as double) as double export
  return x^y
end function

public _
function fbs_Rad2Deg(_B r as double) as double export
  return r*Rad2Deg
end function

public _
function fbs_Deg2Rad(_B d as double) as double export
  return d*Deg2Rad
end function


public _
function fbs_Volume_2_DB(_B volume as single) as single export
  return 20.0f*log(volume)/Log(10)
end function

public _
function fbs_DB_2_Volume(_B dB as single) as single export
  return 10.0f ^ (dB * 0.05f)
end function

private _
sub _FFT(_B b as single ptr, _
         _B s as integer )
  static as single co(FFTSHIFT-1),si(FFTSHIFT-1)
  static as integer sw(FFTSIZE),Init
  static as integer ptr lpSW,lpInit
  dim    as single  tmpr,tmpi,ur,ui,vr,vi
  dim    as single ptr p1,p2,p1r,p1i,p2r,p2i
  dim    as integer    i,j,k,le,le2

  if Init=0 then
    co(0)=cos(PI)
    si(0)=sin(PI)
    j=2
    for i=1 to FFTSHIFT-1
      co(i)=cos(PI/j)
      si(i)=sin(PI/j)
      j shl=1
    next
    lpSW=@sw(0)
    lpInit=@Init
    asm
    mov esi,2 '=i
    mov edx,[lpSW]
    mov edi,(FFTSIZE shl 1)
    sub edi,3
    push ebp     ' make it free
    mov ebp,edi  ' = 2*n-3
    ri_get_swap_loop:
      add ebp,3      ' 2*n
      xor edi,edi
      mov ebx,2
      ri_get_shift_loop: ' do
        mov eax,esi  ' i
        and eax,ebx
        jz ri_get_shift
        inc edi      ' j+=1
        ri_get_shift:
        shl edi,1    ' j*=2
        shl ebx,1
        cmp ebx,ebp
      jl ri_get_shift_loop 'loop while (shift<n*2)
      sub ebp,3
      cmp esi,edi ' if i<j then
      jnl ri_get_swap_next
      ' save swappositions
        mov ecx,esi ' save esi
        shl esi,2 ' * sizeof(single)
        shl edi,2 ' * sizeof(single)
        mov [edx  ],esi ' index i
        mov [edx+4],edi ' index j
        mov esi,ecx ' restorte esi
        add edx,8   ' next table index
      ri_get_swap_next:
      add esi,2 'i+=2
      cmp esi,ebp
    jl ri_get_swap_loop
    pop ebp        ' get it back
    sub edx,8      ' remove last table entrys
    mov eax,edx    ' eax=last  entry
    mov edx,[lpSW] ' edx=first entry
    sub eax,edx
    shr eax,3      ' (last-first)\8=number of entrys
    mov edx,[lpInit]
    mov [edx],eax  ' init=number of entrys to swap
    end asm
  end if

  ' swap real and imag parts
  asm 
  mov ecx,[init] ' number of items to swap
  mov edx,[lpSW] ' table
  mov ebx,[b]    ' buffer
  push ebp       ' make it free
  ri_swap_loop:
    mov esi,[edx  ]     ' i
    mov edi,[edx+4]     ' j
    mov eax,[ebx+esi]   ' b[i]
    mov ebp,[ebx+edi]   ' b[j]
    mov [ebx+edi],eax   ' b[j]=b[i]
    mov [ebx+esi],ebp   ' b[i]=b[j]
    mov eax,[ebx+esi+4] ' b[i+1]
    mov ebp,[ebx+edi+4] ' b[j+1]
    mov [ebx+edi+4],eax ' b[j+1]=b[i+1]
    mov [ebx+esi+4],ebp ' b[i+1]=b[j+1]
    add edx,8           ' lpSwap+=2 entrys 
    dec ecx
  jnz ri_swap_loop
  pop ebp        ' get it back
  end asm

  le2=2
  for k=0 to FFTSHIFT-1
    le=le2 shl 1
    ur=1.0:vr=co(k)
    ui=0.0:vi=si(k)*s

#define _p1r ESI
#define _p1i _p1r + 4
#define _p2r EDI
#define _p2i _p2r + 4

    for j=0 to le2-1 step 2
    asm
    'xor ecx,ecx
    'fft_loop1:
      mov esi,[j] 'ecx
      shl esi,2
      add esi,[b]
      mov edi,[le2]
      shl edi,2
      add edi,esi
      'push ecx
      'cmp ecx,[nm2]
      'jge fft_loop2_end

      mov ecx,[j]
      fft_loop2:
      'for i=j to 2*n-1 step le
        ' ti=(p2r*ui)+(p2i+ur)
        fld  dword ptr [_p2r] 
        fmul dword ptr [ui] 
        fld  dword ptr [_p2i]
        fmul dword ptr [ur]
        faddp                  ' ti

        ' tr=(p2r*ur)-(p2i*ui)
        fld  dword ptr [_p2r] 
        fmul dword ptr [ur] 
        fld  dword ptr [_p2i]
        fmul dword ptr [ui]
        fsubp                 ' tr,ti

        fld  dword ptr [_p1r] ' p1r,tr,ti

        ' p2r = p1r - tr
        fsub st(0),st(1)      ' p1r-tr,tr,ti
        fstp dword ptr [_p2r] ' tr,ti
        fxch                  ' ti,tr

        ' p2i = p1i - ti 
        fld  dword ptr [_p1i] ' p1i,ti,tr
        fsub st(0),st(1)      ' p1i-ti,ti,tr
        fstp dword ptr [_p2i] ' ti,tr

        ' p1i += ti
        fld  dword ptr [_p1i] ' p1i,ti,tr
        faddp                 ' p1i+ti,tr
        fstp dword ptr [_p1i] ' tr
        ' p1r += tr
        fld  dword ptr [_p1r] ' p1r,tr
        faddp                 ' p1r+tr
        fstp dword ptr [_p1r]

        mov eax,[le]
        add ecx,eax
        shl eax,2
        add esi,eax           ' p1r+=le
        add edi,eax
        mov eax,(FFTSIZE shl 1)
        cmp ecx,eax
      jl fft_loop2

      fft_loop2_end:
      'pop ecx

      'tr = ur*vr - ui*vi
      fld  dword ptr [ur] 
      fmul dword ptr [vr]
      fld  dword ptr [ui] 
      fmul dword ptr [vi]
      fsubp               ' tr !!!
      'ui = ur*vi + ui*vr
      fld  dword ptr [ur]
      fmul dword ptr [vi]
      fld  dword ptr [ui]
      fmul dword ptr [vr]
      faddp               ' ui,tr
      fstp dword ptr [ui] ' tr
      'ur = tr
      fstp dword ptr [ur]

      'add ecx,2 ' j+=2
      'mov eax,[le2]
      'dec eax
      'cmp ecx,eax
    'jl fft_loop1
    end asm
    next
    le2 shl=1
  next
end sub

private _
sub _FFT_Win_Input( _
  _B lpFFT as single ptr, _
  _B lpSMP as single ptr, _
  _B lpCOS as single ptr)
  asm
  mov ecx,FFTSIZE
  mov edi,[lpFFT]
  mov esi,[lpSMP]
  mov ebx,[lpCOS]
  xor eax,eax
  sub edi,8
  sub esi,4
  sub ebx,4
  ' real=input*wincos
  ' imag=0.0
  _FFT_Win_Input_Loop:
    fld  dword ptr [esi+ecx*4] ' input
    fld  dword ptr [ebx+ecx*4] ' input,wincos
    fmulp                      ' input*wincos
    fstp dword ptr [edi+ecx*8] ' real=input*wincos
    mov [edi+ecx*8+4],eax      ' imag=0.0
    dec ecx
  jnz _FFT_Win_Input_Loop
  end asm
end sub


private _
sub _FFT_Phase_Magnetude( _
  _B lpPhase as single ptr, _
  _B lpMagn  as single ptr, _
  _B lpFFT   as single ptr)
  asm
  mov ecx,FFTSIZE
  shr ecx,1
  mov esi,[lpFFT]
  mov edi,[lpPhase]
  mov ebx,[lpMagn]
  sub esi,8
  sub edi,4
  sub ebx,4
  ' Phase     =atan2(real,imag)
  ' Magnetude =2.0*sqr(Imag*Imag+Real*Real)  
  _FFT_Phase_Magnetude_Loop:
    fld  dword ptr [esi+ecx*8]   ' real
    fld st(0)                    ' real,real
    fld st(0)                    ' real,real,real
    fld  dword ptr [esi+ecx*8+4] ' imag,real,real,real
    fld st(0)                    ' imag,imag,real,real,real
    fld st(0)                    ' imag,imag,imag,real,real,real
    fxch st(3)                   ' real,imag,imag,imag,real,real
    fpatan                       ' atan2(real,imag),imag,imag,real,real
    fstp dword ptr [edi+ecx*4]   ' imag,imag,real,real
    fmulp                        ' imag*imag,real,real
    fxch  st(2)                  ' real,real,imag*imag
    fmulp                        ' real*real,imag*imag
    faddp                        ' real*real+imag*imag 
    fsqrt                        ' magnetude
    fld st(0)                    ' magnetude,magnetude
    faddp                        ' 2.0*sqr(real*real+imag*imag)
    fstp dword ptr [ebx+ecx*4]   ' free fpu stack
    dec ecx
  jnz _FFT_Phase_Magnetude_Loop
  end asm
end sub


private _
sub _FFT_Magnetude_Phase( _
  _B lpFFT   as single ptr, _
  _B lpMagn  as single ptr, _
  _B lpPhase as single ptr)
  asm
  mov ecx,FFTSIZE
  shr ecx,1
  mov edi,[lpFFT]
  mov esi,[lpMagn]
  mov ebx,[lpPhase]
  sub esi,4
  sub ebx,4
  sub edi,8
  ' real=magnetude*cos(phase)
  ' imag=magnetude*sin(phase)  
  _FFT_Magnetude_Phase_Loop:
    fld  dword ptr [ebx+ecx*4]   ' phase
    fld  st(0)                   ' phase,phase
    fld  dword ptr [esi+ecx*4]   ' magn,phase,phase
    fld  st(0)                   ' magn,magn,phase,phase
    fxch st(2)                   ' phase,magn,magn,phase
    fcos                         ' cos(phase),magn,magn,phase
    fmulp                        ' cos(phase)*magn,magn,phase
    fstp dword ptr [edi+ecx*8]   ' magn,phase
    fxch                         ' phase,magn
    fsin                         ' sin(phase),magn
    fmulp                        ' sin(phase)*magn
    fstp dword ptr [edi+ecx*8+4] ' free fpu stack
    dec ecx
  jnz _FFT_Magnetude_Phase_Loop
  end asm
end sub


private _
sub _FFT_Win_Output( _
  _B lpSMP as single ptr, _
  _B lpCOS as single ptr, _
  _B lpFFT as single ptr, _
  _B d     as single)
  asm
  mov ecx,FFTSIZE
  mov edi,[lpSMP]
  mov esi,[lpCOS]
  mov ebx,[lpFFT]
  sub edi,4
  sub esi,4
  sub ebx,8
  fld dword ptr [d]            ' d
  ' out+=2*coswin*(real/d)
  _FFT_Win_Output_Loop:
    fld  st(0)                 ' d,d
    fld  dword ptr [ebx+ecx*8] ' real,d,d
    fxch
    fdivp                      ' real/d,d
    fld  dword ptr [esi+ecx*4] ' coswin,real/d,d
    fmulp                      ' coswin*(real/d),d
    fld st(0)
    faddp                      ' 2*coswin*(real/d),d
    fld  dword ptr [edi+ecx*4] ' out,2*coswin*(real/d),d
    faddp                      ' out+2*coswin*(real/d),d
    fstp dword ptr [edi+ecx*4] ' d
    dec ecx
  jnz _FFT_Win_Output_Loop
  fstp st(0)                   ' free fpu stack
  end asm
end sub


private _
sub _PitchShiftMono_asm( _
  _B d as short ptr, _
  _B s as short ptr, _
  _B v as single  , _
  _B r as single  , _
  _B n as integer  )

  ' fft buffer
  static as single FFT  (FFTSIZE shl 1)
  ' in fifo
  static as single I(FFTSIZE)
  ' out fifo
  static as single O(FFTSIZE)
  ' accumulator
  static as single A(FFTSIZE shl 1)
  ' magnetude
  static as single M(FFTSIZE shr 1)
  ' phase
  static as single P(FFTSIZE shr 1)
  ' old phase
  static as single LP(FFTSIZE shr 1)
  ' summ phase
  static as single SP(FFTSIZE shr 1)
  ' cosin window
  static as single CW(FFTSIZE)
  ' analyse frequency
  static as single AF(FFTSIZE)
  ' analyse magnetude
  static as single AM(FFTSIZE)
  ' synthese frequency
  static as single SF(FFTSIZE)
  ' synthese magnetude
  static as single SM(FFTSIZE)
  static as integer RD,ID,QPD,Init,J,k
  static as single FPB,TMP

  ' initialize
  if (Init=0)  then
    FPB=R/FFTSIZE
    RD=FFTFL
    for j=0 to FFTSIZE-1
      CW(j)=-.5*cos(PI2*j/FFTSIZE)+.5
    next
    Init=1
  end if
  
  ' loop over all samples
  for j = 0 to n-1
    ' short to single -1.0 to 1.0
    I(RD) = s[j]*(1.0f/32768.0f)
    d[j] = O(RD-FFTFL)*32767.0f
    RD+=1
    ' now we have enough data
    if (RD >= FFTSIZE) then 
      RD= FFTFL
      ' do windowing, transform and calc phase and magnetude
      _FFT_Win_Input(@FFT(0),@I(0),@cw(0))
      _FFT(@FFT(0),-1)
      _FFT_Phase_Magnetude(@P(0),@AM(0),@FFT(0))

      ' this is the analysis step
      for k = 0 to (FFTSIZE shr 1)
        ' compute phase delta
        tmp = P(k)-LP(k)
        LP(k)=P(k)
        ' subtract expected phase difference
        tmp -=k*FFTEXPD
        ' map delta phase into +/- Pi interval
        qpd = tmp/PI
        if (qpd<0) then
          qpd-=qpd and 1
        else
          qpd+=qpd and 1
        end if
        tmp-=PI*qpd
        ' get deviation from bin frequency from the +/- Pi interval
        tmp = FFTOS*tmp/PI2
        ' compute the k-th partials frequency 
         tmp = k*FPB + tmp*FPB
        ' store frequency in analysis arrays
        AF(k)=tmp
      next

      ' pitch shift
      zero(@SM(0),FFTSIZE shl 2)
      for k=0 to (FFTSIZE shr 1)-1
        ID=k/v
        if (ID<=(FFTSIZE shr 1)) then
          SM(k)+= AM(ID)
          SF(k) = AF(ID) * v
        end if
      next

      for k=0 to (FFTSIZE shr 1)
        tmp =SF(k)
        ' subtract bin mid frequency
        tmp-=k*FPB
        ' get bin deviation from freq deviation
        tmp/=FPB
        ' take OS into account
        tmp =PI2*tmp/FFTOS
        ' add the overlap phase
        tmp+=k*FFTEXPD
        ' accumulate delta phase to get bin phase
        SP(k)+=tmp
      next
      _FFT_Magnetude_Phase(@FFT(0),@SM(0),@SP(0))

      ' zero negative frequencies
      zero(@FFT(FFTSIZE+2),((FFTSIZE shl 1)-(FFTSIZE+2)) shl 2)
      ' do inverse transform, windowing and add to output
      _FFT(@FFT(0),1)
      _FFT_Win_Output(@A(0),@CW(0),@FFT(0),(FFTSIZE shr 1) shl FFTOSSHIFT)
      copy(@O(0),@A(0)    ,FFTSS    shl 2)
      copy(@A(0),@A(FFTSS),FFTSIZE  shl 2)
      copy(@I(0),@I(FFTSS),FFTFL    shl 2)
    end if
  next
end sub

private _
sub _PitchShiftStereo_asm( _
  _B d as short ptr, _
  _B s as short ptr, _
  _B v as single  , _
  _B r as single  , _
  _B n as integer  )

  ' fft buffer
  static as single FFT(FFTSIZE shl 1)
  ' in fifo
  static as single I(FFTSIZE)
  static as single RI(FFTSIZE)
  ' out fifo
  static as single O(FFTSIZE)
  static as single RO(FFTSIZE)
  ' accumulator
  static as single A(FFTSIZE shl 1)
  static as single RA(FFTSIZE shl 1)
  ' magnetude
  static as single M(FFTSIZE shr 1)
  ' phase
  static as single P(FFTSIZE shr 1)
  ' old phase left,right
  static as single LP(FFTSIZE shr 1)
  static as single RLP(FFTSIZE shr 1)
  ' summ phase left,right
  static as single SP(FFTSIZE shr 1)
  static as single RSP(FFTSIZE shr 1)
  ' cosin window
  static as single CW(FFTSIZE)
  ' analyse frequency
  static as single AF(FFTSIZE)
  ' analyse magnetude
  static as single AM(FFTSIZE)
  ' synthese frequency
  static as single SF(FFTSIZE)
  ' synthese magnetude
  static as single SM(FFTSIZE)
  static as integer RD,ID,QPD,Init,J,k
  static as single  FPB,TMP

  ' initialize
  if (Init = 0)  then
    FPB=R/FFTSIZE
    RD=FFTFL
    for j=0 to FFTSIZE-1
      ' in range -0.5 to +0.5
      CW(j)=-.5*cos(PI2*j/FFTSIZE)+.5
    next
    Init=1
  end if
  
  ' loop over all  samples
  for j = 0 to n-1
    ' short to single -1.0 to 1.0
     I(RD) = s[j*2  ]*(1.0f/32768.0f)
    RI(RD) = s[j*2+1]*(1.0f/32768.0f)
    d[j*2  ] =  O(RD-FFTFL)*32767.0f
    d[j*2+1] = RO(RD-FFTFL)*32767.0f
    RD+=1
    ' now we have enough data
    if (RD >= FFTSIZE) then 
      RD=FFTFL
      ' do left windowing, transform and calc phase and magnetude
      _FFT_Win_Input(@FFT(0),@I(0),@cw(0))
      _FFT(@FFT(0),-1)
      _FFT_Phase_Magnetude(@P(0),@AM(0),@FFT(0))

      ' this is the analysis step
      for k = 0 to (FFTSIZE shr 1)
        ' compute phase delta
        tmp = P(k)-LP(k)
        LP(k)=P(k)
        ' subtract expected phase difference
        tmp -=k*FFTEXPD
        ' map delta phase into +/- Pi interval
        qpd = tmp/PI
        if (qpd<0) then
          qpd-=qpd and 1
        else
          qpd+=qpd and 1
        end if
        tmp-=PI*qpd
        ' get deviation from bin frequency from the +/- Pi interval
        tmp = FFTOS*tmp/PI2
        ' compute the k-th partials frequency 
         tmp = k*FPB + tmp*FPB
        ' store frequency in analysis arrays
        AF(k)=tmp
      next

      ' left pitch shift
      zero(@SM(0),FFTSIZE shl 2)
      for k=0 to (FFTSIZE shr 1)-1
        ID=k/v
        if (ID<=(FFTSIZE shr 1)) then
          SM(k)+= AM(ID)
          SF(k) = AF(ID) * v
        end if
      next

      for k=0 to (FFTSIZE shr 1)
        tmp =SF(k)
        ' subtract bin mid frequency
        tmp-=k*FPB
        ' get bin deviation from freq deviation
        tmp/=FPB
        ' take OS into account
        tmp =PI2*tmp/FFTOS
        ' add the overlap phase
        tmp+=k*FFTEXPD
        ' accumulate delta phase to get bin phase
        SP(k)+=tmp
      next
      _FFT_Magnetude_Phase(@FFT(0),@SM(0),@SP(0))

      ' zero negative frequencies
      zero(@FFT(FFTSIZE+2),((FFTSIZE shl 1)-(FFTSIZE+2)) shl 2)
      ' do inverse transform, windowing and add to output
      _FFT(@FFT(0),1)
      _FFT_Win_Output(@A(0),@CW(0),@FFT(0),(FFTSIZE shr 1) shl FFTOSSHIFT)
      copy(@O(0),@A(0),FFTSS shl 2)
      copy(@A(0),@A(FFTSS),FFTSIZE shl 2)
      copy(@I(0),@I(FFTSS),FFTFL   shl 2)

      ' do right windowing, transform and calc phase and magnetude
      _FFT_Win_Input(@FFT(0),@RI(0),@cw(0))
      _FFT(@FFT(0),-1)
      _FFT_Phase_Magnetude(@P(0),@AM(0),@FFT(0))

      ' right analysis step
      for k = 0 to (FFTSIZE shr 1)
        ' compute phase delta
        tmp = P(k)-RLP(k)
        RLP(k)=P(k)
        ' subtract expected phase difference
        tmp -=k*FFTEXPD
        ' map delta phase into +/- Pi interval
        qpd = tmp/PI
        if (qpd<0) then
          qpd-=qpd and 1
        else
          qpd+=qpd and 1
        end if
        tmp-=PI*qpd
        ' get deviation from bin frequency from the +/- Pi interval
        tmp = FFTOS*tmp/PI2
        ' compute the k-th partials frequency 
         tmp = k*FPB + tmp*FPB
        ' store frequency in analysis arrays
        AF(k)=tmp
      next

      ' pitch shift
      zero(@SM(0),FFTSIZE shl 2)
      for k=0 to (FFTSIZE shr 1)-1
        ID=k/v
        if (ID<=(FFTSIZE shr 1)) then
          SM(k)+= AM(ID)
          SF(k) = AF(ID) * v
        end if
      next

      for k=0 to (FFTSIZE shr 1)
        tmp =SF(k)
        ' subtract bin mid frequency
        tmp-=k*FPB
        ' get bin deviation from freq deviation
        tmp/=FPB
        ' take OS into account
        tmp =PI2*tmp/FFTOS
        ' add the overlap phase
        tmp+=k*FFTEXPD
        ' accumulate delta phase to get bin phase
        RSP(k)+=tmp
      next
      _FFT_Magnetude_Phase(@FFT(0),@SM(0),@RSP(0))

      ' zero negative frequencies
      zero(@FFT(FFTSIZE+2),((FFTSIZE shl 1)-(FFTSIZE+2)) shl 2)
      ' do right inverse transform, windowing and add to output
      _FFT(@FFT(0),1)
      _FFT_Win_Output(@RA(0),@CW(0),@FFT(0),(FFTSIZE shr 1) shl FFTOSSHIFT)
      copy(@RO(0),@RA(0)    ,FFTSS   shl 2)
      copy(@RA(0),@RA(FFTSS),FFTSIZE shl 2)
      copy(@RI(0),@RI(FFTSS),FFTFL   shl 2)
    end if
  next
end sub

private _
sub _Set_EQFilter(_B lpFilter as fbs_filter ptr, _
                  _B Center   as single       , _
                  _B dB       as single = 0.0 , _
                  _B Octave   as single = 1.0 , _
                  _B Rate     as single = 44100.0)

  dim as single Phase,Scale,SinPhase,SinhTerm,e1,e2,Speed,SmS,SdS,SS

  Phase = PI2 * (Center / Rate)
  Scale = fbs_DB_2_Volume(dB)
  SinPhase=sin(Phase)
  SinhTerm=Phase / SinPhase
  SinhTerm=0.34657359f * Octave * SinhTerm
  e1=exp( sinhterm)
  e2=exp(-sinhterm)
  sinhterm=(e1-e2)*0.5
  Speed = SinPhase * sinhterm
  
  SmS = Speed*Scale
  SdS = Speed/Scale
  SS = 1.0f / (1.0f + SdS)

  lpFilter->Center=Center
  lpFilter->dB=dB
  lpFilter->Octave=Octave
  lpFilter->Rate=Rate
  lpFilter->Scale=Scale
  lpFilter->b0 = SS*( 1.0f + SmS)
  lpFilter->b1 = SS*(-2.0f * cos(Phase))
  lpFilter->b2 = SS*( 1.0f - SmS)
  lpFilter->a1 = -(lpFilter->b1)
  lpFilter->a2 = SS*((SdS) - 1.0f)
  lpFilter->x1_l=0.0f
  lpFilter->x2_l=0.0f
  lpFilter->y1_l=0.0f
  lpFilter->y2_l=0.0f
  lpFilter->x1_r=0.0f
  lpFilter->x2_r=0.0f
  lpFilter->y1_r=0.0f
  lpFilter->y2_r=0.0f
end sub

'###########################################################################
'# out(t) = b0*in(t) + b1*in(t-1) + b2*in(t-2) + a1*out(t-1) + a2*out(t-2) #
'# in(t-2)=in(t-1):in(t-1)=in(t)         Out(t-2)=Out(t-1):Out(t-1)=Out(t) #
'###########################################################################
private _
sub _Filter_Mono_asm16( _
  _B d as any ptr, _
  _B s as any ptr, _
  _B f as fbs_filter ptr, _
  _B n as integer)

  asm

  mov ebx,[f]
  mov edi,[d]
  mov esi,[s]
  mov ecx,[n]
  shr ecx,1     ' bytes to words mono

  fld dword ptr [ebx + _b0]
  fld dword ptr [ebx + _b1]
  fld dword ptr [ebx + _b2]
  fld dword ptr [ebx + _a1]
  fld dword ptr [ebx + _a2]

  filter_mono_asm16_loop:
    fld  st(0)                     ' a2,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _y2_l]   ' a2*y2,a2,a1,b2,b1,b0
    fld  st(2)                     ' a1,a2*y2,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _y1_l]   ' y1,a1,a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y2_l]   ' f->y2=f->y1
    fmulp                          ' y1*a1,a2*y2,a2,a1,b2,b1,b0
    faddp                          ' y1*a1+a2*y2,a2,a1,b2,b1,b0
    fld st(3)                      ' b2,y1*a1+a2*y2,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _x2_l]   ' b2*x2,a1*y1+a2*y2,a2,a1,b2,b1,b0
    faddp                          ' b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fld  st(4)                     ' b1,b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _x1_l]   ' x1,b1,b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x2_l]   ' f->x2=f->x1
    fmulp                          ' x1*b1,b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    faddp                          ' x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fld st(5)                      ' b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fild  word ptr [esi]           ' in(t),b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x1_l]   ' f->x1=in(t)
    fmulp                          ' in(t)*b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    faddp                          ' in(t)*b0+x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y1_l]   ' f->y1=out
    fistp word ptr [edi]           ' out(t)=out                      ,a2,a1,b2,b1,b0
    add edi,2
    add esi,2
  dec ecx
  jnz filter_mono_asm16_loop

  ffree st(4)
  ffree st(3)
  ffree st(2)
  ffree st(1)
  ffree st(0)
 end asm
end sub

private _
sub _Filter_Stereo_asm16(_B d as any ptr, _
                         _B s as any ptr, _
                         _B f as fbs_filter ptr, _
                         _B n as integer)
  asm

  mov ebx,[f]
  mov ecx,[n]
  shr ecx,2     ' bytes to words stereo

  mov edi,[d]   ' first left sample target
  mov esi,[s]   ' first left sample source

  fld dword ptr [ebx + _b0]
  fld dword ptr [ebx + _b1]
  fld dword ptr [ebx + _b2]
  fld dword ptr [ebx + _a1]
  fld dword ptr [ebx + _a2]

  filter_stereo_left_asm16_loop:
    fld  st(0)                     ' a2                              ,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _y2_l]   ' a2*y2                           ,a2,a1,b2,b1,b0
    fld  st(2)                     ' a1,a2*y2                        ,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _y1_l]   ' y1,a1,a2*y2                     ,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y2_l]   ' f->y2=f->y1
    fmulp                          ' y1*a1,a2*y2                     ,a2,a1,b2,b1,b0
    faddp                          ' y1*a1+a2*y2                     ,a2,a1,b2,b1,b0
    fld st(3)                      ' b2,y1*a1+a2*y2                  ,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _x2_l]   ' b2*x2,a1*y1+a2*y2               ,a2,a1,b2,b1,b0
    faddp                          ' b2*x2+a1*y1+a2*y2               ,a2,a1,b2,b1,b0
    fld  st(4)                     ' b1,b2*x2+a1*y1+a2*y2            ,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _x1_l]   ' x1,b1,b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x2_l]   ' f->x2=f->x1
    fmulp                          ' x1*b1,b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    faddp                          ' x1*b1+b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    fld st(5)                      ' b0,x1*b1+b2*x2+a1*y1+a2*y2      ,a2,a1,b2,b1,b0
    fild  word ptr [esi]           ' in(t),b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x1_l]   ' f->x1=in(t)
    fmulp                          ' in(t)*b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    faddp                          ' in(t)*b0+x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y1_l]   ' f->y1=out
    fistp word ptr [edi]           ' out(t)=out                      ,a2,a1,b2,b1,b0
    add edi,4                      ' jump over left channel
    add esi,4                      ' jump over right channel
  dec ecx
  jnz filter_stereo_left_asm16_loop

  'ffree st(4)
  'ffree st(3)
  'ffree st(2)
  'ffree st(1)
  'ffree st(0)

  mov ecx,[n]
  shr ecx,2     ' bytes to words stereo

  mov edi,[d]
  add edi,2    ' first right sample target
  mov esi,[s]
  add esi,2    ' first right sample source

  'fld dword ptr [ebx + _b0]
  'fld dword ptr [ebx + _b1]
  'fld dword ptr [ebx + _b2]
  'fld dword ptr [ebx + _a1]
  'fld dword ptr [ebx + _a2]

  filter_stereo_right_asm16_loop:
    fld  st(0)                     ' a2                              ,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _y2_r]   ' a2*y2                           ,a2,a1,b2,b1,b0
    fld  st(2)                     ' a1,a2*y2                        ,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _y1_r]   ' y1,a1,a2*y2                     ,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y2_r]   ' f->y2=f->y1
    fmulp                          ' y1*a1,a2*y2                     ,a2,a1,b2,b1,b0
    faddp                          ' y1*a1+a2*y2                     ,a2,a1,b2,b1,b0
    fld st(3)                      ' b2,y1*a1+a2*y2                  ,a2,a1,b2,b1,b0
    fmul dword ptr [ebx + _x2_r]   ' b2*x2,a1*y1+a2*y2               ,a2,a1,b2,b1,b0
    faddp                          ' b2*x2+a1*y1+a2*y2               ,a2,a1,b2,b1,b0
    fld  st(4)                     ' b1,b2*x2+a1*y1+a2*y2            ,a2,a1,b2,b1,b0
    fld  dword ptr [ebx + _x1_r]   ' x1,b1,b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x2_r]   ' f->x2=f->x1
    fmulp                          ' x1*b1,b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    faddp                          ' x1*b1+b2*x2+a1*y1+a2*y2         ,a2,a1,b2,b1,b0
    fld st(5)                      ' b0,x1*b1+b2*x2+a1*y1+a2*y2      ,a2,a1,b2,b1,b0
    fild  word ptr [esi]           ' in(t),b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _x1_r]   ' f->x1=in(t)
    fmulp                          ' in(t)*b0,x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    faddp                          ' in(t)*b0+x1*b1+b2*x2+a1*y1+a2*y2,a2,a1,b2,b1,b0
    fst  dword ptr [ebx + _y1_r]   ' f->y1=out
    fistp word ptr [edi]           ' out(t)=out                      ,a2,a1,b2,b1,b0
    add edi,4                      ' jump over left channel
    add esi,4                      ' jump over right channel
  dec ecx
  jnz filter_stereo_right_asm16_loop

  ffree st(4)
  ffree st(3)
  ffree st(2)
  ffree st(1)
  ffree st(0)
 end asm
end sub
