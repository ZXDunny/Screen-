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

unit Speccy_DirectSound;

interface

Uses Windows, MMSystem, SysUtils, WinAPI.DirectSound;

Var

  WaveFormat:       TWaveFormatEx;
  DSObject:         IDirectSound = nil;
  BufferDesc:       TDSBufferDesc;
  PrimaryBuffer,
  SecondaryBuffer:  IDirectSoundBuffer;
  DSoundCaps:       TDSCaps;

  DXErrorString:    String;
  SoundAvailable:   Boolean = False;
  SoundBufferSize:  DWord;
  SoundBufferPos:   DWord;
  BufferPos1,
  BufferPos2,
  BufferSize1,
  BufferSize2,
  SecondaryPos:     DWord;

  DXError:          hResult;

  Procedure         INITSound(Handle: hWnd; Frequency, Bits, Stereo: DWord);
  Procedure         CheckSoundDeviceCaps(Var Frequency, Bits, Stereo: DWord);
  Procedure         AlterSoundSettings(Frequency, Bits, Stereo: DWord);
  Function          SetFormat(Hz, Bits: DWord; Stereo, Primary: Boolean): HResult;
  Procedure         ClearBuffer;
  Procedure         SendSamples(BufferPtr: Pointer; SampleSize: DWord);
  Procedure         SynchToSound;
  Procedure         CloseSound;

implementation

Uses ScreenStrings;

Procedure INITSound(Handle: hWnd; Frequency, Bits, Stereo: DWord);
Begin

  SoundAvailable := False;

  If Debugging Then Log('Create DirectSound Object');
  DXError := DirectSoundCreate(Nil, DSObject, Nil);

  If DXError = DS_OK Then Begin

     CheckSoundDeviceCaps(Frequency, Bits, Stereo);
     If Debugging Then Log('Set Cooperative level');
     DXError := DSObject.SetCooperativeLevel(Handle, DSSCL_EXCLUSIVE);

     If DXError = DS_OK Then Begin

        BufferDesc.dwSize := SizeOf(TDSBufferDesc);
        BufferDesc.dwFlags := DSBCAPS_PRIMARYBUFFER or DSBCAPS_GETCURRENTPOSITION2;

        If Debugging Then Log('Create primary soundbuffer');
        DXError := DSObject.CreateSoundBuffer(BufferDesc, PrimaryBuffer, Nil);

        If DXError = DS_OK Then Begin

           SoundAvailable := True;
           AlterSoundSettings(Frequency, Bits, Stereo);

        End Else Begin

           DXErrorString := 'DirectSound could not create the Primary Buffer.'#13'Sound is unavailable.';

        End;

     End Else Begin

        DXErrorString := 'DirectSound could not set the cooperative level.'#13'Sound is unavailable.';

     End;

  End Else Begin

     DXErrorString := 'DirectSound could not be initialised.'#13'Sound is unavailable.';

  End;

  If Debugging Then Log('Sound Initialisation done - '+DXErrorString);

End;

Procedure CheckSoundDeviceCaps(Var Frequency, Bits, Stereo: DWord);
Begin

  FillChar(DSoundCaps, SizeOf(TDSCaps), 0);
  DSoundCaps.dwSize := SizeOf(TDSCaps);
  DSObject.GetCaps(DSoundCaps);

  If 11025 > Frequency Then
     Frequency := 11025;

  If DSoundCaps.dwMaxSecondarySampleRate < Frequency Then
     Frequency := DSoundCaps.dwMaxSecondarySampleRate;

  If (Bits = 16) and Not (DSoundCaps.dwFlags and DSCAPS_Secondary16Bit <> 0) Then
     If DSoundCaps.dwFlags or DSCAPS_Secondary8Bit <> 0 Then Begin
        Bits := 8
     End Else Begin
        DXErrorString := 'DirectSound does not support 8 or 16 bit Sound.'#13'Sound is unavailable.';
        SoundAvailable := False;
        Exit;
     End;

  If (Bits = 8) and Not (DSoundCaps.dwFlags or DSCAPS_Secondary8bit <> 0) Then
     If DSoundCaps.dwFlags or DSCAPS_Secondary16Bit <> 0 Then Begin
        Bits := 16
     End Else Begin
        DXErrorString := 'DirectSound does not support 8 or 16 bit sound.'#13'Sound is unavailable.';
        SoundAvailable := False;
        Exit;
     End;

  If (Stereo <> 0) and Not (DSoundCaps.dwFlags or DSCAPS_SecondaryStereo <> 0) Then
     If DSoundCaps.dwFlags or DSCAPS_SecondaryMono <> 0 Then Begin
        Stereo := 0
     End Else Begin
        DXErrorString := 'DirectSound does not support mono or stereo sound.'#13'Sound is unavailable.';
        SoundAvailable := False;
        Exit;
     End;

  If (Stereo = 0) and Not (DSoundCaps.dwFlags or DSCAPS_SecondaryMono <> 0) Then
     If DSoundCaps.dwFlags or DSCAPS_SecondaryStereo <> 0 Then Begin
        Stereo := 1
     End Else Begin
        DXErrorString := 'DirectSound does not support mono or stereo sound.'#13'Sound is unavailable.';
        SoundAvailable := False;
        Exit;
     End;

End;

Procedure AlterSoundSettings(Frequency, Bits, Stereo: DWord);
Begin

  If SoundAvailable Then Begin

     SoundAvailable := False;

     If Debugging Then Log('Setting sound format - '+IntToStr(Frequency)+' Hz, '+IntToStr(Bits)+' Bits, '+IntToStr(Stereo)+' Channels');
     DXError := SetFormat(Frequency, Bits, Stereo <> 0, True);

     If DXError = DS_OK Then Begin

        DXError := SetFormat(Frequency, Bits, Stereo <> 0, False);

        If DXError = DS_Ok Then Begin

          If Debugging Then Log('Commence playing the secondary buffer');
          DXError := SecondaryBuffer.Play(0, 0, DSBPLAY_LOOPING);

          If DXError = DS_OK Then Begin

             SoundAvailable := True;

          End Else Begin

             DXErrorString := 'DirectSound could not start playing.'#13'Sound is unavailable.';
             SoundAvailable := False;

          End;

        End;

     End Else Begin

        DXErrorString := 'DirectSound could not create the Secondary Buffer.'#13'Sound is unavailable.';
        SoundAvailable := False;

     End;

  End;

End;

Function SetFormat(Hz, Bits: DWord; Stereo, Primary: Boolean): HResult;
Begin

  With WaveFormat Do begin

     wFormatTag := WAVE_FORMAT_PCM;
     If Stereo Then
        nChannels := 2
     Else
        nChannels := 1;
     nSamplesPerSec := Hz;
     wBitsPerSample := Bits;
     nBlockAlign := wBitsPerSample * nChannels div 8;
     nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
     cbSize := 0;

  End;

  If Primary Then Begin

     If Debugging Then Log('Setting primary buffer format');
     Result := PrimaryBuffer.SetFormat(@WaveFormat);

  End Else Begin

     SoundBufferSize :=  1024 * 4;

     BufferDesc.dwFlags := DSBCAPS_GETCURRENTPOSITION2 or DSBCAPS_GLOBALFOCUS;
     BufferDesc.dwBufferBytes := SoundBufferSize;
     BufferDesc.lpwfxFormat := @WaveFormat;

     SecondaryBuffer := nil;
     If Debugging Then Log('Creating secondary sound buffer');
     Result := DSObject.CreateSoundBuffer(BufferDesc, SecondaryBuffer, Nil);
     ClearBuffer;

  End;

End;

Procedure CloseSound;
Begin

  ClearBuffer;

  If SecondaryBuffer <> Nil Then
     SecondaryBuffer := Nil;

  If PrimaryBuffer <> Nil Then
     PrimaryBuffer := Nil;

  If DSObject <> Nil then
     DSObject := Nil;

End;

Procedure ClearBuffer;
Var
  Pointer1, Pointer2: Pointer;
  BytesLocked1, BytesLocked2: DWord;
  DXError: HResult;
Begin

  Pointer1 := nil;
  Pointer2 := nil;

  If Debugging Then Log('Clearing sound buffer - locking...');
  DXError := SecondaryBuffer.Lock(0, SoundBufferSize, Pointer1, @BytesLocked1, Pointer2, @BytesLocked2, 0);

  If DXError = DS_OK Then Begin

     If Debugging Then Log('Success, locked '+IntToStr(Byteslocked1)+' and '+IntToStr(Byteslocked2)+' bytes.');
     ZeroMemory(Pointer1, BytesLocked1);
     ZeroMemory(Pointer2, BytesLocked2);

     If Debugging Then Log('Unlocking secondary buffer...');
     SecondaryBuffer.Unlock(Pointer1, BytesLocked1, Pointer2, BytesLocked2);
     If Debugging Then Log('secondary buffer unlocked.');

  End;

End;

Procedure SendSamples(BufferPtr: Pointer; SampleSize: DWord);
Var
  Pointer1, Pointer2: Pointer;
  BytesLocked1, BytesLocked2: DWord;
  DXError: HResult;
Begin

  DXError := SecondaryBuffer.Lock(SoundBufferPos, SampleSize, Pointer1, @BytesLocked1, Pointer2, @BytesLocked2, 0);

  If DXError = DS_OK Then Begin

     If SoundBufferPos + SampleSize < SoundBufferSize Then Begin
        BufferPos1 := SoundBufferPos;
        BufferSize1 := SampleSize;
        BufferPos2 := DWord(-1);
        BufferSize2 := DWord(-1);
     End Else Begin
        BufferPos1 := SoundBufferPos;
        BufferSize1 := SoundBufferSize - SampleSize;
        BufferPos2 := 0;
        BufferSize2 := SampleSize - BufferSize1;
     End;

     CopyMemory(Pointer1, BufferPtr, BytesLocked1);
     Inc(DWord(BufferPtr), BytesLocked1);
     CopyMemory(Pointer2, BufferPtr, BytesLocked2);

     SecondaryBuffer.Unlock(Pointer1, BytesLocked1, Pointer2, BytesLocked2);

     Inc(SoundBufferPos, SampleSize);
     While SoundBufferPos >= SoundBufferSize Do
        Dec(SoundBufferPos, SoundBufferSize);

  End;

End;

Procedure SynchToSound;
Begin

  While 1 = 1 Do Begin

     Sleep(1);
     SecondaryBuffer.GetCurrentPosition(nil, @SecondaryPos);

     If (SecondaryPos >= BufferPos1) And (SecondaryPos < BufferPos1 + BufferSize1) Then
        Break
     Else
        If Integer(BufferPos2) >= 0 Then
           If (SecondaryPos >= BufferPos2) And (SecondaryPos < BufferPos2 + BufferSize2) Then
              Break;

  End;

End;

end.
