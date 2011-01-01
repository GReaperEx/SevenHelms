DEFINT A-Z
'$DYNAMIC
DECLARE SUB CFade (MusicChannel AS INTEGER, FadeStart AS INTEGER, FadeEnd AS INTEGER, FadeSpeed AS INTEGER)
DECLARE SUB CPan (MusicChannel AS INTEGER, PanStart AS INTEGER, PanEnd AS INTEGER, PanSpeed AS INTEGER)
DECLARE SUB GetFBMOD (MusicChannel AS INTEGER, TotalLength AS LONG, CurrentOrder AS INTEGER, CurrentRow AS INTEGER)
DECLARE SUB GetFBMP3 (MusicChannel AS INTEGER, TotalLength AS LONG, CurrentPos AS LONG)
DECLARE SUB InitDS4QB ()
DECLARE SUB LoadMusic (MusicName AS STRING, MusicType AS INTEGER, MusicChannel AS INTEGER, Repeat AS INTEGER, Enable3D AS INTEGER)
DECLARE SUB LoadSample ()
DECLARE FUNCTION LongBreak% (LongVar AS LONG, IntNum AS INTEGER)
DECLARE FUNCTION LongMake& (IntVar1 AS INTEGER, IntVar2 AS INTEGER)
DECLARE SUB PlaySample (SFXT%)
DECLARE SUB RemoveMusic (Channel AS INTEGER)
DECLARE SUB Set3D (MusicChannel AS INTEGER, PX AS SINGLE, PY AS SINGLE, PZ AS SINGLE, VX AS SINGLE, VY AS SINGLE, VZ AS SINGLE)
DECLARE SUB SetChannel (MusicChannel AS INTEGER, Frequency AS LONG, Volume AS INTEGER, Panning AS INTEGER)
DECLARE SUB SetEAX (EaxCode AS INTEGER)
DECLARE SUB SetPos (MusicChannel AS INTEGER, MP3Position AS LONG, MODOrder AS INTEGER, MODRow AS INTEGER)
DECLARE SUB SetVolume (MODVol%, SAMVol%, MP3Vol%)
DECLARE SUB ShutdownDS4QB ()
DECLARE SUB WaitforDMA0 ()
DECLARE SUB PauseMusic (MusicChannel AS INTEGER)
DECLARE SUB ResumeMusic (MusicChannel AS INTEGER)

