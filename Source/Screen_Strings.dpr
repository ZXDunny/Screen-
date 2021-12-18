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

program Screen_Strings;

uses
  Forms,
  Windows,
  SysUtils,
  ScreenStrings in 'ScreenStrings.pas' {Display_Form},
  Config in 'Config.pas' {ConfigForm},
  Speccy_BASS in 'Speccy_BASS.pas';

{$R *.RES}
{$R WindowsXP.res}
//{$E scr}

Var
  HandleString: String;
  Idx: Integer;

begin

  // The /l parameter (which should never be passed by windows) enables logging.

  Debugging := False;
  If Pos('l', LowerCase(ParamStr(1))) <> 0 Then
     Debugging := True;

  If Debugging Then
     If FileExists('\Screen$.log') Then
        DeleteFile('\Screen$.log');

  // Check for a mutex - if one exists, then this must be another copy of the screensaver.
  // If so, exit.

  If Debugging then Log('Check Mutexes...');

  If OpenMutex(MUTEX_ALL_ACCESS, False, Pchar('SaverActiveMode')) > 0 then Exit;
  If OpenMutex(MUTEX_ALL_ACCESS, False, Pchar('SaverConfigMode')) > 0 then Exit;
  If OpenMutex(MUTEX_ALL_ACCESS, False, Pchar('SaverPreviewMode')) > 0 then Exit;

  If Debugging then Log('No instances found.');

  // Check for a /c parameter, which indicates that configuration mode is active

  Configure := Pos('c', LowerCase(ParamStr(1))) <> 0;

  If Debugging then
     If Configure Then
        Log('Configuration Mode selected via /c Command line');

  Application.Initialize;

  // Check for a /p parameter, which indicates that we're in preview mode.

  PreviewMode := False;
  If Not Configure Then Begin
     If Pos('p', LowerCase(ParamStr(1))) <> 0 Then Begin
        // The /p parameter supplies a window handle next in the command line.
        // If it exists, then go get it:
        If ParamCount > 1 Then Begin
           HandleString := '';
           Idx := 1;
           // Only take the numbers
           While Idx <= Length(ParamStr(2)) do Begin
              If ParamStr(2)[Idx] in ['0'..'9'] Then
                 HandleString := HandleString + ParamStr(2)[Idx];
              Inc(Idx);
           End;
           // And convert to an integer, so we can check if the window actually exists
           PreviewHandle := StrToInt(HandleString);
           If IsWindow(PreviewHandle) Then Begin
              // Success! Set the screensaver to preview mode, and get the size of the
              // Preview window.
              PreviewMode := True;
              GetWindowRect(PreviewHandle, PreviewRect);
              If Debugging then Log('Preview mode selected with valid window handle');
           End Else Begin
              If Debugging then Log('Preview mode selected with no valid window handle, quitting.');
              Exit;
           End;
        End;
     End;
     // Now create a mutex which will, with the code above, prevent multiple instances
     // from running.
     If Debugging then Log('Creating Mutex...');
     If PreviewMode Then
        hndMutex := CreateMutex(nil, False, PChar('SaverPreviewMode'))
     Else
        hndMutex := CreateMutex(nil, False, PChar('SaverActiveMode'));
     // If the mutex failed to create, then exit.
     If hndMutex = 0 Then Begin
        If Debugging then Log('Unable to create active mode Mutex');
        Exit;
     End;
     Application.Title := 'SCREEN$';

     If Debugging then Log('Creating main form');
     Application.CreateForm(TDisplay_Form, Display_Form);
  Application.CreateForm(TConfigForm, ConfigForm);
  End Else Begin

     // Create a mutex for the configuration mode.
     hndMutex := CreateMutex(nil, False, PChar('SaverConfigMode'));
     If hndMutex = 0 Then Begin
        If Debugging then Log('Unable to create config mode Mutex');
        Exit;
     End;

  End;

  If Debugging then Log('Creating Config form');
  Application.CreateForm(TConfigForm, ConfigForm);

  If Debugging then Log('Commencing application');
  Application.Run;

end.
