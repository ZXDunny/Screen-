// Copyright (C) 2009 Paul Dunn
//
// This file is part of the SCREEN$ screensaver.
//
// SCREEN$ is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// SCREEN$ is distributed in the hope that it will be entertaining,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with SCREEN$.  If not, see <http://www.gnu.org/licenses/>.

unit Speccy_BASS;

interface

Uses Windows, SysUtils, BASS;

  Procedure INITSound(Handle: hWnd; Frequency, Bits, Stereo: DWord);
  Procedure SendSamples(BufferPtr: Pointer; SampleSize: DWord);
  Procedure SynchToSound;
  Procedure CloseSound;

Var

  NextBufferPos, LastSampleSize: Integer;
  Stream: HStream;
  SoundAvailable:   Boolean = False;

implementation

Uses SpeccyScreen;

Procedure INITSound(Handle: hWnd; Frequency, Bits, Stereo: DWord);
Var
  Info: BASS_INFO;
  BASS_Err: Integer;
  Buffer: Array[0..8819] of Byte;
Begin

  SoundAvailable := False;

  // Initialise BASS.

  BASS_SetConfig(BASS_CONFIG_DEV_DEFAULT, 1);

  {$IFDEF LINUX}
  BASS_Init(-1, Frequency, 0, 0, 0);
  {$ELSE}
  BASS_Init(-1, Frequency, 0, 0, nil);
  {$ENDIF}

  BASS_Err := BASS_ErrorGetCode;
  If BASS_Err = 0 Then Begin

    // Open the streaming buffer

    BASS_SetConfig(BASS_CONFIG_BUFFER, 1000);
    Stream := BASS_StreamCreate(Frequency, Stereo +1, BASS_SAMPLE_8BITS * Ord(Bits = 8), STREAMPROC_PUSH, nil);

    ZeroMemory(@Buffer[0], 8820);
    BASS_StreamPutData(Stream, @Buffer[0], 882*4);
    NextBufferPos := 0;
    LastSampleSize := 0;

    BASS_Err := BASS_ErrorGetCode;
    If BASS_Err = 0 Then
      SoundAvailable := True;

  End;

End;

Procedure SendSamples(BufferPtr: Pointer; SampleSize: DWord);
Begin

  BASS_StreamPutData(Stream, BufferPtr, SampleSize);
  Inc(NextBufferPos, LastSampleSize);
  LastSampleSize := SampleSize;
  BASS_ChannelPlay(Stream, False);

End;

Procedure SynchToSound;
Var
  Position: DWord;
Begin

  Position := BASS_ChannelGetPosition(Stream, BASS_POS_BYTE);
  While Position < NextBufferPos Do Begin
    Sleep(1);
    Position := BASS_ChannelGetPosition(Stream, BASS_POS_BYTE);
  End;

End;

Procedure CloseSound;
Begin

  BASS_Stop;
  BASS_StreamFree(Stream);

End;

end.
