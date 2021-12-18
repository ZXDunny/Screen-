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

unit ScreenStrings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FastIMG, FastDIB, FastFX, SpeccyScreen, Speccy_DirectDraw, MMSystem,
  Speccy_BASS, ExtCtrls;

type
  TDisplay_Form = class(TForm)
    FastIMG1: TFastIMG;
    Timer1: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure IdleProc(Sender: TObject; var Done: Boolean);
  public
    { Public declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    Procedure NewScreen;
    Procedure BuildPalette(Clrs: Array of TFColor);
    Procedure CloseSaver;
  end;

var
  Display_Form: TDisplay_Form;
  Configure: Boolean = False;

  // Spectrum colours in Delphi-compatible format

  TFSpecBlack:    TFcolor = (b:0;g:0;r:0);
  TFSpecBlue:     TFColor = (b:202;g:0;r:0);
  TFSpecRed:      TFColor = (b:0;g:0;r:202);
  TFSpecMagenta:  TFColor = (b:202;g:0;r:202);
  TFSpecGreen:    TFColor = (b:0;g:202;r:0);
  TFSpecCyan:     TFColor = (b:202;g:202;r:0);
  TFSpecYellow:   TFColor = (b:0;g:202;r:202);
  TFSpecWhite:    TFColor = (b:197;g:197;r:197);
  TFSpecBlueB:    TFColor = (b:255;g:0;r:0);
  TFSpecRedB:     TFColor = (b:0;g:0;r:255);
  TFSpecMagentaB: TFColor = (b:255;g:0;r:255);
  TFSpecGreenB:   TFColor = (b:0;g:255;r:0);
  TFSpecCyanB:    TFColor = (b:255;g:255;r:0);
  TFSpecYellowB:  TFColor = (b:0;g:255;r:255);
  TFSpecWhiteB:   TFColor = (b:255;g:255;r:255);

  // Various variables!

  InternalDIB:    TFastDIB;
  DisplayDIB:     TFastDIB;
  Dx, Dy:         Integer;
  DisplayPalette: TFColorTable;
  SoundBuffer:    Array[0..1023] of Byte;
  ScreenList:     TStringlist;
  Timer:          DWord;
  Closing:        Boolean = False;
  IgnoreMouse:    Boolean = True;
  MouseX, MouseY: Integer;
  PreviewMode:    Boolean;
  PreviewHandle:  THandle;
  PreviewRect:    TRect;
  hndMutex:       THandle;
  DisplayCorners: Boolean;
  Debugging:      Boolean;
  ElapsedFrames:  Integer;


Const

  // The default screen is stored here - it's used when there's no .scr files in the folder, or
  // the folder does not exist.

  Default_Scr: Array [0..6911] of Byte =
     (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0, 255, 255, 0, 0,
      255, 255, 0, 0, 255, 255, 0, 0, 0, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, 30, 255, 255, 0, 30, 128, 1, 232, 225, 128, 1, 232, 225, 255, 255, 0, 225, 255, 255, 0, 224, 224, 1, 232, 1, 0, 0, 232, 0, 0, 0, 0, 0, 0, 1, 232, 30, 128, 0, 0, 224, 255, 254, 128, 225,
      128, 0, 0, 225, 128, 0, 0, 30, 129, 225, 232, 1, 0, 0, 232, 0, 0, 0, 0, 1, 255, 254, 128, 1, 255, 254, 128, 30, 128, 1, 232, 31, 255, 255, 232, 31, 255, 255, 232, 30, 128, 1, 232, 1, 255, 255, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 4, 0, 16, 0, 0, 12, 0, 16, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 31, 0, 1, 0, 31, 0, 0, 224, 31, 0, 0, 224, 30, 0, 1, 224, 0, 1, 31, 0, 0, 0, 0, 0, 1, 0, 1, 0, 30, 128, 0, 8, 225, 128, 1, 232,
      224, 0, 1, 0, 224, 0, 1, 0, 225, 30, 1, 232, 1, 30, 31, 8, 0, 0, 0, 0, 30, 0, 1, 232, 30, 128, 1, 224, 225, 0, 30, 128, 225, 128, 0, 0, 225, 128, 0, 0, 30, 128, 31, 232, 0, 254, 30, 232, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 128, 0, 128, 0, 8, 0, 0, 0,
      8, 0, 0, 0, 8, 0, 128, 0, 8, 0, 1, 224, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 98, 56, 0, 56, 28, 28, 56, 56, 120, 56, 0, 16, 56, 68, 120, 4, 0, 0, 120, 0, 16, 56, 16, 4, 56,
      28, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 128, 1, 0, 1, 128, 31, 0, 1,
      128, 31, 0, 0, 232, 31, 0, 0, 232, 30, 128, 1, 232, 0, 1, 23, 0, 0, 0, 0, 0, 13, 0, 1, 128, 30, 128, 0, 248, 225, 128, 1, 232, 224, 0, 1, 128, 224, 0, 1, 128, 225, 222, 129, 232, 1, 18, 16, 248, 0, 0, 0, 0, 30, 0, 1, 232, 30, 128, 1, 232, 225, 255,
      222, 128, 225, 128, 0, 0, 225, 128, 0, 0, 30, 128, 223, 232, 0, 2, 18, 232, 0, 0, 0, 0, 0, 255, 255, 128, 0, 255, 255, 128, 15, 128, 0, 248, 15, 255, 255, 248, 15, 255, 255, 248, 15, 128, 0, 248, 0, 253, 239, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 68, 0, 64, 32, 32, 68, 68, 68, 64, 0, 24, 68, 68, 68, 60, 0, 48, 68, 0, 24, 68, 16, 60, 68, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 128, 1, 0, 1, 128, 31, 0, 1, 128, 31, 0, 0, 232, 31, 0, 0, 232, 30, 128, 1, 232, 0, 1, 23, 0, 0, 0, 0, 0, 1,
      0, 1, 128, 30, 128, 0, 0, 225, 128, 1, 232, 224, 0, 1, 128, 224, 0, 1, 128, 225, 158, 129, 232, 1, 22, 23, 0, 0, 0, 0, 0, 30, 0, 1, 232, 30, 128, 1, 232, 225, 128, 30, 128, 225, 128, 0, 0, 225, 128, 0, 0, 30, 128, 31, 232, 0, 254, 22, 232, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 74, 68, 0, 56, 32, 32, 120, 120, 68, 56, 0, 16, 68,
      68, 68, 68, 0, 16, 68, 0, 16, 68, 16, 68, 120, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 1, 0, 1, 128, 1, 0, 1, 0, 31, 0, 1, 0, 31, 0, 0, 232, 31, 0, 0, 232, 30, 0, 1, 232, 0, 1, 31, 0, 0, 0, 0, 0, 1, 0, 1, 0, 30, 128, 0, 0, 225, 0, 1, 232, 224, 0, 1, 128, 224, 0, 1, 128, 225, 158, 1, 232, 1, 30, 31, 0, 0, 0, 0, 0, 30, 0, 1, 232,
      30, 0, 1, 232, 225, 128, 30, 0, 225, 0, 0, 0, 225, 0, 0, 0, 30, 128, 31, 232, 0, 254, 30, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 70, 68, 0, 4, 32, 32, 64, 64, 68, 4, 0, 16, 68, 68, 68, 68, 0, 16, 68, 0, 16, 68, 16, 68, 64, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 255, 255, 128, 30, 255, 254, 224, 30, 255, 254, 224, 30, 255, 255, 8, 30, 255, 255, 8, 31, 224, 1, 232, 1, 255, 0, 224, 0, 0, 0, 0, 0, 255,
      254, 224, 30, 128, 0, 0, 224, 255, 254, 8, 225, 255, 255, 128, 225, 255, 255, 128, 225, 129, 225, 232, 1, 0, 0, 224, 0, 0, 0, 0, 1, 255, 254, 8, 1, 255, 254, 8, 225, 128, 1, 224, 224, 255, 255, 224, 224, 255, 255, 224, 30, 128, 1, 232, 1, 0, 0, 232,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 56, 0, 120, 28, 32, 60, 60, 68, 120, 0,
      16, 56, 56, 68, 60, 0, 56, 68, 0, 16, 56, 12, 60, 60, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 30, 0, 0, 128, 30, 0, 2, 232, 30, 0, 2, 232, 30, 0, 0, 248, 30, 0, 0, 248, 31, 232, 1, 232, 1, 255, 0, 232, 0, 0, 0, 0, 0, 0, 2, 232, 30, 128, 0, 0, 224, 255, 254, 248, 225, 0, 0, 128, 225, 0, 0, 128, 225, 141, 233, 232, 1, 0, 0, 232,
      0, 0, 0, 0, 13, 255, 254, 248, 13, 255, 254, 248, 225, 128, 13, 232, 224, 255, 255, 232, 224, 255, 255, 232, 30, 128, 13, 232, 1, 0, 0, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 127, 255, 0, 30, 127, 254, 232, 30, 127, 254, 232, 30, 127, 255, 0, 30, 127, 255, 0, 31, 232, 1, 232, 1, 255,
      0, 232, 0, 0, 0, 0, 0, 255, 254, 232, 30, 128, 0, 0, 224, 255, 254, 128, 225, 127, 255, 0, 225, 127, 255, 0, 225, 129, 233, 232, 1, 0, 0, 232, 0, 0, 0, 0, 1, 255, 254, 128, 1, 255, 254, 128, 225, 128, 1, 232, 224, 255, 255, 232, 224, 255, 255, 232,
      30, 128, 1, 232, 1, 0, 0, 232, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 32, 0, 131, 194, 32, 2, 162, 32, 34, 32, 129, 130, 162, 32, 0, 34, 8, 34, 2, 32, 34, 0, 0, 0, 0, 0, 0, 0, 0, 2, 34, 32, 34, 34, 32, 0, 131, 193, 130, 0, 1, 226, 32, 192, 34,
      32, 128, 128, 2, 1, 1, 2, 34, 34, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 32, 0, 130, 35, 192, 2, 163, 193, 226, 32, 128, 130, 163, 192, 0, 34, 8, 60, 30, 28, 60, 0, 0, 0, 0, 0, 0,
      0, 0, 3, 194, 32, 34, 34, 32, 0, 130, 32, 129, 192, 2, 35, 192, 129, 226, 32, 128, 128, 1, 193, 1, 3, 195, 194, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 32, 0, 130, 34, 0, 2, 162, 2,
      34, 32, 128, 130, 162, 0, 64, 60, 8, 32, 34, 2, 32, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 32, 34, 33, 224, 0, 130, 32, 128, 32, 2, 34, 0, 130, 34, 32, 128, 128, 0, 33, 1, 2, 2, 2, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 1, 242, 32, 0, 98, 33, 224, 2, 161, 225, 226, 32, 97, 194, 161, 224, 64, 32, 6, 30, 30, 60, 30, 0, 0, 0, 0, 0, 0, 0, 0, 1, 226, 33, 33, 192, 32, 0, 98, 33, 195, 192, 1, 225, 224, 129, 225, 192, 96, 96, 3, 192, 225, 1, 225, 226,
      32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 1, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 240, 0, 0, 130, 0, 0, 0, 0, 0, 0, 0, 128, 128, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 0, 0, 0, 130, 0, 128, 0, 0, 32, 0, 96, 0, 0, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 192, 1, 194, 1, 192, 3, 65, 193, 195, 193, 192, 3, 65, 192, 0, 60, 8, 28, 28, 28, 28, 0, 0, 0, 0, 0, 0, 0, 0, 1, 195, 192, 1, 194, 32, 1, 194, 0, 1,
      192, 0, 33, 192, 129, 194, 32, 129, 192, 1, 192, 224, 225, 193, 195, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 254, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 254, 254, 254, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 254, 254, 254, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 254, 254, 254, 254, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 254, 254, 254, 254, 254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 252, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 252, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 252, 252, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 252, 252, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 252, 252, 252, 252, 252, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248,
      248, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248, 248, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 248, 248, 248, 248, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 240, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 240, 240, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 240, 240, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 240, 240, 240, 240, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 224, 224, 224,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 224, 224, 224, 224, 224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192,
      192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 192, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 192, 192, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 192, 192, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 192, 192, 192, 192, 192, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 128, 128, 128, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128, 128, 128, 128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 128, 128, 128, 128, 128, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 7, 7, 56, 56, 7, 7, 56, 56, 7, 7, 56, 56, 7, 7, 56, 56, 7, 7, 56, 56, 56, 56, 56, 56, 56, 7, 56, 56, 56, 56, 56, 56, 7, 7, 56, 56, 56, 56, 56, 7, 56, 56, 56, 7, 7, 7, 56, 7, 7, 7, 56, 7, 56, 56, 56, 56, 7, 7, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 7, 56, 56, 56, 7, 56, 56, 56, 7, 56, 56, 56, 56, 56, 56, 56, 56, 7, 7, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 56, 23, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 23, 50, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 56, 23, 50, 38, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 23, 50, 38, 44, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 56, 23, 50, 38, 44, 5, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 23, 50, 38, 44, 5, 5, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
      56, 56, 56, 23, 50, 38, 44, 5, 5, 5);

  // Used to count the number of bits set in a byte - for use by the "Optimise for loading speed" option

  SetCount: Array [0..255] of Byte =
     (0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3,
      4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 1, 2, 2, 3, 2, 3, 3, 4, 2, 3, 3, 4, 3, 4, 4, 5, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 2, 3, 3, 4, 3, 4,
      4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 2, 3, 3, 4, 3, 4, 4, 5, 3, 4, 4, 5, 4, 5, 5, 6, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 3, 4, 4, 5, 4, 5, 5, 6, 4, 5, 5, 6, 5, 6, 6, 7, 4, 5, 5, 6, 5, 6, 6, 7, 5,
      6, 6, 7, 6, 7, 7, 8);

  Procedure Log(Text: String);

implementation

uses Config;

{$R *.DFM}

Procedure TDisplay_Form.IdleProc(Sender: TObject; var Done: Boolean);
Var
  CurTime: DWord;
  Msg: TMsg;
Begin

  // The idle procedure is where the screensaver runs.
  // Basically, it's a loop which calls Frame(), and then sends the output
  // (graphics and sound) to the display and sound routines.

  // Firstly, ignore mouse movements in preview mode, as it would blank the
  // preview image if the mouse pointer passes over it. IgnoreMouse is set true to prevent
  // the screensaver from exiting before it's had the chance to do anything, so it gets
  // reverted here.

  If Not PreviewMode Then IgnoreMouse := False;

  // InProgress is set while a screen is being generated.
  If InProgress Then Begin

     If Frame Then Begin
        Inc(ElapsedFrames);
        // Send the sound to the soundcard routines.
        If SoundAvailable Then
           SendSamples(@SoundBuffer[0], SoundSize);
        // Display the output. This is double buffered - if the rendering thread is
        // busy, then this frame is tossed out and sent back for another frame.
        // If it's not busy, then this frame is rendered, and the other buffer is used.
        If Not Rendering Then Begin
           InternalDIB.Draw(DisplayDIB.hDc, -Dx, -Dy);
           RenderFrame(DisplayDIB);
        End;
        // Now synchronise - if sound is playing, wait for the buffer that was just
        // created to start playing. If not, then wait for 20ms (1/50th of a second, 1 frame).
        If SoundAvailable Then
           SynchToSound
        Else Begin
           Repeat
              Sleep(1);
              CurTime := GetTickCount;
           Until CurTime - Timer > 20;
           Inc(Timer, 20);
        End;

     End Else Begin

           Repeat
              Sleep(1);
              CurTime := GetTickCount;
           Until CurTime - Timer > 20;
           Inc(Timer, 20);

     End;

  End Else

     // Set up for a new screen.

     If Closing then Begin
        Closing := False;
        Close;
     End Else
        NewScreen;

  If PeekMessage(Msg, Handle, 0, $FFFFFFFF, PM_NOREMOVE) Then
     Done := True
  Else
     Done := False;

End;

procedure TDisplay_Form.CreateParams(var Params: TCreateParams);
begin

  // Used for Preview mode, we set the form to the right size here.

  inherited CreateParams(Params);

  If PreviewMode Then Begin
     If Debugging then Log('Setting window to fit Preview window');
     With Params Do Begin
        Style := WS_CHILD or WS_VISIBLE;
        X := 0;
        Y := 0;
        Width := PreviewRect.Right - PreviewRect.Left;
        Height := PreviewRect.Bottom - PreviewRect.Top;
        WndParent := PreviewHandle;
     End;
     If Debugging then Log('Set window to '+IntToStr(Params.Width)+'x'+IntToStr(Params.Height));
     SetBounds(0, 0, Params.Width, Params.Height);
  End;

End;

procedure TDisplay_Form.FormShow(Sender: TObject);
Var
  Idx, ScanlineIntensity, Dw, Dh: Integer;
  Renderer: TRenderMode;
  Environment: TEnvironmentInfo;
  Aspect: TAspectRatio;
begin

  Randomize;

  // Use the configuration window to load the options.

  ConfigForm.LoadOptions;

  If Not Configure Then Begin

     // Hide the mouse pointer.

     If Debugging Then Log('Remove window cursor');

     FastIMG1.Cursor := crNone;
     Display_Form.Cursor := crNone;

     // Load the options.

     If Debugging Then Log('Implement loaded options');

     If ConfigForm.chkRandomHW.Checked Then Begin
        Idx := Random(5);
        Case Idx of
           0: Environment.HardwareModel := h16k;
           1: Environment.HardwareModel := h48k;
           2: Environment.HardwareModel := h128k;
           3: Environment.HardwareModel := hPlus2;
           4: Environment.HardwareModel := hPlus2a;
           5: Environment.HardwareModel := hPlus3;
        End;
     End Else Begin
        If ConfigForm.rad16K.Checked Then
           Environment.HardwareModel := h16k
        Else If ConfigForm.rad48k.Checked Then
           Environment.HardwareModel := h48k
        Else If ConfigForm.rad128k.Checked Then
           Environment.HardwareModel := h128k
        Else If ConfigForm.radPlus2.Checked Then
           Environment.HardwareModel := hPlus2
        Else If ConfigForm.radPlus2a.Checked Then
           Environment.HardwareModel := hPlus2a
        Else If ConfigForm.radPlus3.Checked Then
           Environment.HardwareModel := hPlus3;
     End;

     Environment.RandomHWAfterReset := ConfigForm.chkRandReset.Checked;

     Case ConfigForm.cmb48kMode.ItemIndex of
        0: Environment.Mode48k := mdRandom;
        1: Environment.Mode48k := mdNone;
        2: Environment.Mode48k := md48BASIC;
        3: Environment.Mode48k := mdSPECTRUM;
        4: Environment.Mode48k := mdUSR0;
     End;
     Random48k := Environment.Mode48k = mdRandom;

     Case ConfigForm.cmbScreenSaverType.ItemIndex of
        0: Environment.Programmer := pgmNone;
        1: Environment.Programmer := pgmProgram;
        2: Environment.Programmer := pgmDirectCommand;
     End;

     Case ConfigForm.cmbResetType.ItemIndex of
        0: Environment.ResetMethod := -1;
        1: Environment.ResetMethod := 0;
        2: Environment.ResetMethod := StrToInt(ConfigForm.edtResetType.Text);
     End;

     If ConfigForm.chkBASIC.Checked Then
        Environment.Looped := StrToInt(ConfigForm.edtBASICScreenCount.Text) -1
     Else
        Environment.Looped := -1;

     If ConfigForm.chkCLS.Checked Then
        Environment.CLS := 1
     Else
        Environment.CLS := 0;

     Environment.PauseLen := ConfigForm.trkPause.Position/4;

     Environment.Chuntey := ConfigForm.chkChuntey.Checked;

     // Create the display buffers - there are two, and the screensaver writes the display
     // to one buffer whilst the other is drawing.

     If Debugging Then Log('Create display buffers');

     BuildPalette([TFSpecBlack, TFSpecBlue,  TFSpecRed,  TFSpecMagenta,  TFSpecGreen,  TFSpecCyan,  TFSpecYellow,  TFSpecWhite,
                   TFSpecBlack, TFSpecBlueB, TFSpecRedB, TFSpecMagentaB, TFSpecGreenB, TFSpecCyanB, TFSpecYellowB, TFSpecWhiteB]);

     Case ConfigForm.cmbBorderSize.ItemIndex of
        0: Begin // No border
              Dw := 256;
              Dh := 192;
              Dy := 56;
           End;
        1: Begin // Small border
              Dw := 264;
              Dh := 200;
              Dy := 52;
           End;
        2: Begin // Partial border
              Dw := 320;
              Dh := 240;
              Dy := 32;
           End;
        3: Begin // Full border
              Dw := 352;
              Dh := 296;
              Dy := 0;
           End;
        Else Begin
           Dw := 352;
           Dh := 296;
           Dy := 0;
        End;
     End;

     Dx := (352 - Dw) Div 2;

     InternalDIB := TFastDIB.Create;
     InternalDIB.SetSize(352, 296, 8);
     InternalDIB.Colors := @DisplayPalette;
     InternalDIB.UpdateColors;

     DisplayDIB := TFastDIB.Create;
     DisplayDIB.SetSize(Dw, Dh, 8);
     DisplayDIB.Colors := @DisplayPalette;
     DisplayDIB.UpdateColors;

     Aspect := arMaintainAspect;
     If ConfigForm.radStretch.Checked Then
        Aspect := arStretch
     Else If ConfigForm.radMaintain.Checked Then
        Aspect := arMaintainAspect
     Else If ConfigForm.radCrop.Checked Then
        Aspect := arCrop;

     Environment.TapeWobble := ConfigForm.chkTapeWobble.Checked;
     Environment.TapeHiss := ConfigForm.chkTapeHiss.Checked;

     Environment.Sound_Enabled := ConfigForm.chkSoundEnable.Checked;
     Environment.Sound_Volume := ConfigForm.TrkVolume.Position;

     If ConfigForm.chkScanlines.Checked Then
        ScanlineIntensity := ConfigForm.trkScanlines.Position
     Else
        ScanlineIntensity := 0;

     DisplayCorners := ConfigForm.chkCorners.Checked;
     Environment.LongFilenames := ConfigForm.chkLongFileNames.Checked;

     // In Preview mode, we use GDI rendering.

     If Not PreviewMode Then Begin
        If ConfigForm.radDirect3D.Checked Then
           Renderer := rmDirect3D
        Else If ConfigForm.radDirectDraw.Checked Then
           Renderer := rmDirectDraw
        Else
           Renderer := rmGDI;
     End Else Begin
        Renderer := rmPreview;
        Environment.Sound_Enabled := False;
        Config.DisplayWidth := PreviewRect.Right - PreviewRect.Left;
        Config.DisplayHeight := PreviewRect.Bottom - PreviewRect.Top;
        Config.DisplayBPP := 0;
     End;

     // Set up the sound if the user has asked for it.

     If Environment.Sound_Enabled Then Begin
        InitSound(Handle, 44100, 8, 0);
        If Not SoundAvailable Then Begin
           MessageBox(Handle, pChar('Failed to initialise sound.'), pChar('Sound Setup Error'), MB_OK or MB_ICONWARNING);
           Close;
           Exit;
        End;
     End;

     // And initialise the graphics engine. The FastIMG1 is the display surface, used by GDI. D3D and
     // DDraw both use the parent of this control (in this case the Form itself) as their initialisation
     // Handle.

     InitGraphics(FastIMG1, Renderer,
                  Config.DisplayWidth, Config.DisplayHeight, Config.DisplayBPP,
                  ScanlineIntensity,
                  DisplayDIB,
                  Aspect,
                  ConfigForm.chkSuperScale.Checked,
                  DisplayCorners);

     // Handle any errors. They're not too explicit, but their main purpose is to exit the screensaver rather than cause
     // errors.

     If Speccy_DirectDraw.DXError <> 0 Then Begin
        If Debugging Then Log('Failed to initialise graphics, "'+Speccy_DirectDraw.DXErrorString+'"');
        MessageBox(Handle, pChar('Failed to set graphics mode.'+#13+Speccy_DirectDraw.DXErrorString), pChar('Graphics Setup Error'), MB_OK or MB_ICONWARNING);
        If Debugging Then Log('Closing application');
        Close;
        Exit;
     End;

     // Initialise the list of screens found.

     If Debugging Then Log('Initialise screenlist');
     ScreenList := TStringlist.Create;
     ScreenList.AddStrings(ConfigForm.Screens);

     // Initialise a high resolution (yeah, right!) timer. Sleep for 100ms to
     // allow the timer to "settle".

     If Debugging Then Log('Set timer to 1 ms');
     TimeBeginPeriod(1);
     Sleep(100);

     Timer := GetTickCount;

     If Debugging Then Log('Initialise Screensaver');
     InitScreenSaver(InternalDIB.Bits, @SoundBuffer[0], @Environment);

     // And load the next screen.

     NewScreen;
     ElapsedFrames := 0;

     // Set the Idle loop procedure to our proc above, and initialise the screensaver.
     // The screensaver needs a display surface (352x296x8) and a sound buffer to dump samples to.

     // The idle proc is only assigned if we're not previewing. If we are, then we use a timer. This prevents
     // the bug in XP's screensaver properties dialog that prevents the screensaver or the dialog from
     // updating until focus is switched.

     If Not PreviewMode Then Begin
        If Debugging Then Log('Set Idle proc');
        Application.OnIdle := IdleProc;
     End Else
      Timer1.Enabled := True;


  End;

End;

Procedure TDisplay_Form.NewScreen;
Var
  Idx, X, Y, Count, CountInverted, Addr: Integer;
  Loader_Header, Loader_Data: TLoaderInfo;
  Bytes, BytesInverted: Array[0..8] of Byte;
  Filename: String;
  FStream: TFileStream;
Begin

  // Sets up a new screen. First, the characteristics of the loading scheme are
  // filled. In this case, we're mimicking the ROM loader.

  // ROM Loader

  If Debugging Then Log('Initialise Headerblock data');
  FillChar(Loader_Header, SizeOf(TLoaderInfo), 0);
  Loader_Header.Pilot_Border_1 := 5;
  Loader_Header.Pilot_Border_2 := 2;
  Loader_Header.Pilot_Repeats := 8064;
  Loader_Header.Pilot_Tone_Length := 2168;
  Loader_Header.Pilot_Loops := 1;
  Loader_Header.Sync1_Length := 667;
  Loader_Header.Sync2_Length := 735;
  Loader_Header.Data_Border_1 := 1;
  Loader_Header.Data_Border_2 := 6;
  Loader_Header.Data_One_Length := 1710;
  Loader_Header.Data_Zero_Length := 835;
  Loader_Header.Data_Pause_Length := 928;
  Loader_Header.PreLoad_Delay := 50 * 2;
  Loader_Header.PreHeader_Delay := 50 * 4;
  Loader_Header.Data_Length := 17;
  Loader_Header.FinalBorder := 2;

  If Debugging Then Log('Initialise Datablock data');
  FillChar(Loader_Data, SizeOf(TLoaderInfo), 0);
  Loader_Data.Pilot_Border_1 := 5;
  Loader_Data.Pilot_Border_2 := 2;
  Loader_Data.Pilot_Repeats := 3220;
  Loader_Data.Pilot_Tone_Length := 2168;
  Loader_Data.Pilot_Loops := 1;
  Loader_Data.Sync1_Length := 667;
  Loader_Data.Sync2_Length := 735;
  Loader_Data.Data_Border_1 := 1;
  Loader_Data.Data_Border_2 := 6;
  Loader_Data.Data_One_Length := 1710;
  Loader_Data.Data_Zero_Length := 835;
  Loader_Data.Data_Pause_Length := 2000;
  Loader_Data.PreLoad_Delay := 20;
  Loader_Data.PreHeader_Delay := 50;
  Loader_Data.Data_Length := 6912;
  Loader_Data.FinalBorder := 7;

  If Debugging Then Log('Clear Screen_Data[]');

  For Idx := 0 To 6911 Do Screen_Data[Idx] := 0;

  // If the screenlist is empty, add the list of screens. This does actually make sense,
  // as will be shown later. For now, check *again* if the screenlist is empty. If so, there's
  // no screens that can be loaded, so use the default screen image.

  If ScreenList.Count = 0 Then
     ScreenList.AddStrings(ConfigForm.Screens);

  If ScreenList.Count = 0 Then Begin

     // Load the default screen

     If Debugging Then Log('No screens, using default.');

     CopyMemory(@Screen_Data[0], @Default_Scr[0], 6912);
     Filename := 'No SCREEN$ found!';

  End Else Begin

     // Now choose a screen at random, and delete it from the list. This ensures that each
     // screen is chosen only once from the list.

     Idx := Random(Screenlist.Count);
     Filename := ScreenList[Idx];
     ScreenList.Delete(Idx);

     // Now load the screen data into our data array, which will be used by the screensaver engine.

     If Debugging Then Log('Using screen '+Filename);

     SetCurrentDir(AppDir);
     FStream := TFileStream.Create(Filename, fmOpenRead or fmShareDenyNone);
     FStream.Read(Screen_Data[0], 6912);
     FStream.Free;

  End;

  // If the user asked for screens to be optimised for loading speed, do this now.
  // Basically, if a character square has more set bits than unset bits, then flip all the bits
  // and swap the ink/paper values. Because zeros load faster than ones, this will speed up
  // the loading process. In theory. By a small insignificant amount.

  If ConfigForm.chkOptimise.Checked Then Begin

     If Debugging Then Log('Optimising screen data for loading speed');

     For Y := 0 To 23 Do
        For X := 0 To 31 Do Begin
           Addr := ScreenAddresses[Y * 8] + X;
           For Idx := 0 To 7 Do Begin
              Bytes[Idx] := Byte(Screen_Data[Addr + (Idx * 256)]);
              BytesInverted[Idx] := Bytes[Idx] Xor 255;
           End;
           Bytes[8] := Byte(Screen_Data[6144 + (Y * 32) + X]);
           BytesInverted[8] := ((Bytes[8] And 7) Shl 3) + ((Bytes[8] And 56) shr 3) + (Bytes[8] And 192);
           Count := 0;
           CountInverted := 0;
           For Idx := 0 To 7 Do Begin
              Inc(Count, SetCount[Bytes[Idx]]);
              Inc(CountInverted, SetCount[BytesInverted[Idx]]);
           End;
           If CountInverted < Count Then Begin
              For Idx := 0 To 7 Do
                 Screen_Data[Addr + (Idx * 256)] := BytesInverted[Idx];
              Screen_Data[6144 + (Y * 32) + X] := BytesInverted[8];
           End;
        End;

  End;

  // Send all our data thus gathered to the screensaver engine.

  NewLoad(Filename, @Loader_Header, @Loader_Data, False);

End;

Procedure TDisplay_Form.BuildPalette(Clrs: Array of TFColor);
Var
  F: Integer;
Begin

  // Creates the default palette.

  If Debugging Then Log('Create default palette');

  For F := 0 To 15 Do begin
     DisplayPalette[F].r := Clrs[F].r;
     DisplayPalette[F].g := Clrs[F].g;
     DisplayPalette[F].b := Clrs[F].b;
  End;

End;

procedure TDisplay_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  // Shut down all the parts of the screensaver that have been
  // created.

  If Debugging Then Log('Releasing Mutex '+IntToStr(hndMutex));

  If hndMutex <> 0 Then
     ReleaseMutex(hndMutex);

end;

procedure TDisplay_Form.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  // If the ESC key is pressed, the screensaver exits immediately. Any other key
  // triggers a D BREAK message, which hangs around for a couple of seconds before
  // exiting.

  If Key = VK_ESCAPE Then Begin
     Closing := True;
     TerminateSaver(True);
  End Else
     If ConfigForm.chkKeyboard.Checked Then
        CloseSaver;

end;

procedure TDisplay_Form.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin

  // In some circumstances (when the user chooses), mouse movements will
  // disrupt the chuntey - or quit the screensaver. Quit operations will only
  // be triggered for large mouse movements of 4 pixels displacement or more.

  If Not IgnoreMouse Then Begin
     If (MouseX <> X) and (MouseY <> Y) Then
        If ConfigForm.cmbMouse.ItemIndex = 0 Then
           DisruptChuntey
        Else
           If ConfigForm.cmbMouse.ItemIndex = 1 Then
              If (Abs(MouseX - X) > 4) or (Abs(MouseY - Y) > 4) Then
                 CloseSaver;
  End;
  MouseX := X;
  MouseY := Y;

end;

Procedure TDisplay_Form.CloseSaver;
Begin

  // Cleanly exit the screensaver, and generate a D BREAK message if loading.

  Closing := True;
  TerminateSaver(False);

End;

procedure TDisplay_Form.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  // Mouse click events always close the screensaver.

  CloseSaver;

end;

procedure TDisplay_Form.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

  // The preview mechanism of the windows screensaver properties page
  // causes multiple quit messages. This section of code ignores all but the first.

  If Not Closing Then Begin

     If Debugging Then Log('Closing application. Setting OnIdle to nil');

     Closing := True;
     Application.OnIdle := nil;
     CanClose := True;

     If Not Configure Then Begin

        If Current_Environment.Sound_Enabled Then
           If SoundAvailable Then Begin
              CloseSound;
           End;
        CloseGraphics;

        If Debugging Then Log('Clearing screen list');

        If ScreenList <> nil Then Begin
           ScreenList.Clear;
           ScreenList.Free;
        End;

        If Debugging Then Log('Freeing display DIB');

        If DisplayDIB <> Nil Then
           DisplayDIB.Free;

        If Debugging Then Log('Freeing internal DIB');

        If InternalDIB <> Nil Then
           InternalDIB.Free;

        If Debugging Then Log('Resetting timer');

        TimeEndPeriod(1);

     End;

  End Else

     CanClose := False;

end;

procedure TDisplay_Form.FormCreate(Sender: TObject);
begin

  // Remove the taskbar button that the application generates. It looks ugly if it
  // is showing when the preview is running.

  If Not Configure Then Begin

     If Debugging Then Log('Active mode selected - removing taskbar button');

     ShowWindow(Application.Handle, SW_HIDE);
     SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
     ShowWindow(Application.Handle, SW_SHOW);

  End;

end;

Procedure Log(Text: String);
Var
  List: TStringlist;
Begin

  List := TStringlist.Create;
  If FileExists('\Screen$.log') Then
     List.LoadFromFile('\Screen$.log');
  List.Add(Text);
  List.SaveToFile('\Screen$.log');
  List.Free;

End;

procedure TDisplay_Form.Timer1Timer(Sender: TObject);
Var
  Done: Boolean;
begin

  IdleProc(Self, Done);

end;

end.


