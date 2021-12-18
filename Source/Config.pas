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

unit Config;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, SpinImageView, ExtCtrls, ComCtrls, Buttons, FolderBrowser,
  FileCtrl, System.ImageList;

type

  TConfigForm = class(TForm)
    PageControl1: TPageControl;
    tbsOperation: TTabSheet;
    tbsDisplay: TTabSheet;
    imlIcons: TImageList;
    Button1: TButton;
    Button2: TButton;
    tbsSound: TTabSheet;
    lblResolution: TLabel;
    cmbResolution: TComboBox;
    lblRenderer: TLabel;
    bvlRenderer: TBevel;
    lblDisplay: TLabel;
    bvlDisplay: TBevel;
    radDirect3D: TRadioButton;
    radDirectDraw: TRadioButton;
    radGDI: TRadioButton;
    chkSuperScale: TCheckBox;
    chkScanlines: TCheckBox;
    trkScanlines: TTrackBar;
    lblScanlines: TLabel;
    Label1: TLabel;
    edtScreens: TEdit;
    btnFolderList: TSpeedButton;
    Bevel2: TBevel;
    TabSheet1: TTabSheet;
    lblSpectrum: TLabel;
    imv48K: TSpinImageView;
    imv128K: TSpinImageView;
    imvPlus2: TSpinImageView;
    imvPlus2A: TSpinImageView;
    imvPlus3: TSpinImageView;
    imv16K: TSpinImageView;
    bvlSpectrum: TBevel;
    rad48K: TRadioButton;
    rad128K: TRadioButton;
    radPlus2: TRadioButton;
    radPlus2A: TRadioButton;
    radPlus3: TRadioButton;
    rad16K: TRadioButton;
    chkRandReset: TCheckBox;
    TabSheet2: TTabSheet;
    lblAutomation: TLabel;
    lblScreensaverType: TLabel;
    lblAfterBASIC1: TLabel;
    lblAfterBASIC2: TLabel;
    bvlAutomation: TBevel;
    lbl48kMode: TLabel;
    cmbScreenSaverType: TComboBox;
    chkBASIC: TCheckBox;
    chkCLS: TCheckBox;
    edtBASICScreenCount: TEdit;
    udBASICScreenCount: TUpDown;
    cmb48kMode: TComboBox;
    lblResetType2: TLabel;
    lblResetType1: TLabel;
    lblResetType: TLabel;
    edtResetType: TEdit;
    udResetType: TUpDown;
    cmbResetType: TComboBox;
    TabSheet3: TTabSheet;
    lblUserInteraction: TLabel;
    lblMouse: TLabel;
    bvlUserInteraction: TBevel;
    cmbMouse: TComboBox;
    chkRandomHW: TCheckBox;
    lblResetting: TLabel;
    Bevel1: TBevel;
    FileListBox1: TFileListBox;
    SpinImageView1: TSpinImageView;
    SpinImageView2: TSpinImageView;
    SpinImageView3: TSpinImageView;
    Panel1: TPanel;
    Label2: TLabel;
    Bevel3: TBevel;
    radStretch: TRadioButton;
    radMaintain: TRadioButton;
    radCrop: TRadioButton;
    Bevel4: TBevel;
    Label3: TLabel;
    chkTapeWobble: TCheckBox;
    chkTapeHiss: TCheckBox;
    chkSoundEnable: TCheckBox;
    TrkVolume: TTrackBar;
    lblVolume: TLabel;
    Label4: TLabel;
    Bevel5: TBevel;
    lblVolume1: TLabel;
    chkOptimise: TCheckBox;
    Label5: TLabel;
    Bevel6: TBevel;
    chkChuntey: TCheckBox;
    chkKeyboard: TCheckBox;
    Label6: TLabel;
    trkPause: TTrackBar;
    lblPause2: TLabel;
    lblPause: TLabel;
    chkCorners: TCheckBox;
    chkLongFileNames: TCheckBox;
    cmbBorderSize: TComboBox;
    lblBorder: TLabel;
    dlgFolderSelect: TFolderBrowser;
    procedure FormShow(Sender: TObject);
    procedure imv16KClick(Sender: TObject);
    procedure chkRandomHWClick(Sender: TObject);
    procedure cmbResolutionChange(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnFolderListClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpinImageView1Click(Sender: TObject);
  private
    { Private declarations }
    ScreenList: TStringlist;
    Procedure GetScreenList;
    Procedure UpdateForm;
    Procedure GetAppDir;
  public
    { Public declarations }
    Screens: TStringlist;
    Procedure LoadOptions;
    Procedure SaveOptions;
  end;

var
  ConfigForm: TConfigForm;
  DisplayWidth: Integer;
  DisplayHeight: Integer;
  DisplayBPP: Integer;

  AppDIR: String;
  INI: TStringlist;

  function  GetDisplayModes: Boolean;

  Function  FloatToStrEx(Number: Extended): String;

  Function  INIFindSection(Section: String): Integer;
  Function  INIFindEntry(Section, Entry: String): Integer;

  Function  INIRead(Section, Entry: String; Default: Boolean): Boolean; Overload;
  Function  INIRead(Section, Entry: String; Default: Extended): Extended; Overload;
  Function  INIRead(Section, Entry: String; Default: String): String; Overload;
  Function  INIRead(Section, Entry: String; Default: Integer): Integer; OverLoad;
  Function  INIRead(Section, Entry: String; Default: DWord): DWord; OverLoad;
  Function  INIRead(Section, Entry: String; Default: Word): Word; OverLoad;

  Procedure INIWrite(Section, Entry: String; Value: Boolean); OverLoad;
  Procedure INIWrite(Section, Entry: String; Value: String); Overload;
  Procedure INIWrite(Section, Entry: String; Value: Integer); Overload;
  Procedure INIWrite(Section, Entry: String; Value: Extended); Overload;
  Procedure INIWrite(Section, Entry: String; Value: DWord); Overload;
  Procedure INIWrite(Section, Entry: String; Value: Word); Overload;

implementation

{$R *.DFM}

Uses ScreenStrings;

Procedure TConfigForm.GetAppDir;
Begin

  // Returns the directory that the screensaver resides in.

  If Debugging Then Log('Getting AppDIR');
  AppDir := ExtractFilePath(Application.Exename);
  While Copy(AppDir, Length(AppDir), 1) = '\' Do
     AppDir := Copy(AppDir, 1, Length(AppDir)-1);

  If Debugging Then Log('AppDIR = '+AppDIR);

End;

Procedure TConfigForm.LoadOptions;
Var
  Idx: Integer;
  DirName: String;
Begin

  // Load options. These are in a .ini file, and are read by the INIRead procedures.
  // Controls are directly set up with their values here.

  GetAppDir;
  PageControl1.ActivePageIndex := 0;

  INI := TStringlist.Create;
  If FileExists(AppDIR+'\Screen$.ini') Then
     INI.LoadFromFile(AppDIR+'\Screen$.ini');

  If Debugging Then Begin
     If INI.Count = 0 Then
        Log('No INI file has been loaded! Using default values')
     Else
        For Idx := 0 To INI.Count -1 Do
           Log('Config: '+INI[Idx]);
  End;

  // Hardware

  Idx := INIRead('Hardware', 'Model', 1);
  Case Idx of
     0: Rad16k.Checked := True;
     1: Rad48k.Checked := True;
     2: Rad128k.Checked := True;
     3: RadPlus2.Checked := True;
     4: RadPlus2A.Checked := True;
     5: RadPlus3.Checked := True;
  End;

  chkRandomHW.Checked := INIRead('Hardware', 'RandomHW', False);
  chkRandReset.Checked := INIRead('Hardware', 'RandReset', False);

  // Automation

  cmbScreenSaverType.ItemIndex := INIRead('Automation', 'ScreenSaverType', 0);
  chkCLS.Checked := INIRead('Automation', 'CLS', False);
  chkBASIC.Checked := INIRead('Automation', 'BASIC', False);
  Idx := INIRead('Automation', 'BASICCount', 10);
  udBASICScreenCount.Position := Idx;
  edtBASICScreenCount.Text := IntToStr(Idx);
  cmb48kMode.ItemIndex := INIRead('Automation', '48kMode', 0);
  cmbResetType.ItemIndex := INIRead('Automation', 'ResetType', 0);
  Idx := INIRead('Automation', 'ResetCount', 20);
  udResetType.Position := Idx;
  edtResetType.Text := IntToStr(Idx);
  cmbMouse.ItemIndex := INIRead('Interaction', 'Mouse', 1);
  chkChuntey.Checked := INIRead('Interaction', 'RandomChuntey', False);
  chkKeyboard.Checked := INIRead('Interaction', 'Keyboard', True);
  trkPause.Position := INIRead('Automation', 'Pause', 4);

  // Display settings

  Idx := INIRead('Display', 'Renderer', 0);

  Case Idx of

     0: radDirect3D.Checked := True;
     1: radDirectDraw.Checked := True;
     2: radGDI.Checked := True;

  End;

  Idx := INIRead('Display', 'Aspect', 2);

  Case Idx of

     0: radStretch.Checked := True;
     1: radMaintain.Checked := True;
     2: radCrop.Checked := True;

  End;

  DisplayWidth := INIRead('Display', 'Width', 0);
  DisplayHeight := INIRead('Display', 'Height', 0);
  DisplayBpp := INIRead('Display', 'Bpp', 0);

  chkSuperScale.Checked := INIRead('Display', 'SuperScale', True);
  chkScanlines.Checked := INIRead('Display', 'Scanlines', True);
  trkScanlines.Position := INIRead('Display', 'ScanlinesTrk', 128);
  chkCorners.Checked := INIRead('Display', 'Corners', True);
  cmbBorderSize.ItemIndex := INIRead('Display', 'Border', 3);

  edtScreens.Text := INIRead('Screens', 'ScrFolder', AppDir + '\Scr\');
  chkLongFileNames.Checked := INIRead('Screens', 'Longfilenames', True);

  If Debugging Then Log('Screen folder is '+edtScreens.Text);

  // Get the display resolutions available

  ScreenList := TStringList.Create;

  cmbResolution.Items.Clear;
  GetScreenList;
  cmbResolution.Items.AddStrings(ScreenList);

  If (Config.DisplayWidth = 0) and (Config.DisplayHeight = 0) and (Config.DisplayBpp = 0) Then
     cmbResolution.ItemIndex := 0
  Else
     cmbResolution.ItemIndex := cmbResolution.Items.IndexOf(IntToStr(Config.DisplayWidth)+'x'+IntToStr(Config.DisplayHeight)+'x'+IntToStr(Config.DisplayBpp));

  If cmbResolution.ItemIndex = -1 Then
     cmbResolution.ItemIndex := 0;

  If Debugging Then Log('Using screen mode: '+cmbResolution.Items[cmbResolution.ItemIndex]);

  // Get the screen list

  Screens := TStringlist.Create;

  SetCurrentDir(AppDir);
  If DirectoryExists(edtScreens.Text) Then Begin

     If Debugging Then Log('Screen folder exists.');

     FileListBox1.Directory := edtScreens.Text;
     FileListBox1.Update;

     DirName := edtScreens.Text;
     If Copy(DirName, Length(DirName), 1) <> '\' Then
        DirName := DirName + '\';

     For Idx := 0 To FileListBox1.Items.Count -1 Do
        Screens.Add(DirName + FileListBox1.Items[Idx]);

     If Debugging Then Log('Got '+IntToStr(Screens.Count)+' screens.');

  End;

  chkTapeWobble.Checked := INIRead('Tape', 'Wobble', True);
  chkTapeHiss.Checked := INIRead('Tape', 'Hiss', True);

  chkSoundEnable.Checked := INIRead('Sound', 'Enabled', False);
  trkVolume.Position := INIRead('Sound', 'Volume', 64);
  chkOptimise.Checked := INIRead('Tape', 'Optimise', False);

  UpdateForm;

  INI.Free;

End;

Procedure TConfigForm.UpdateForm;
Begin

  // Some controls affect the state of others - for example, disabling the sound
  // will disable the volume control too. This proc is responsible for that.

  rad16k.Enabled := not chkRandomHW.Checked;
  rad48k.Enabled := not chkRandomHW.Checked;
  rad128k.Enabled := not chkRandomHW.Checked;
  radPlus2.Enabled := not chkRandomHW.Checked;
  radPlus2a.Enabled := not chkRandomHW.Checked;
  radPlus3.Enabled := not chkRandomHW.Checked;

  lblResetType1.Enabled := cmbResetType.ItemIndex = 2;
  edtResetType.Enabled := cmbResetType.ItemIndex = 2;
  lblResetType2.Enabled := cmbResetType.ItemIndex = 2;
  udResetType.Enabled := cmbResetType.ItemIndex = 2;

  chkRandReset.Enabled := cmbResetType.ItemIndex > 0;

  If cmbScreenSaverType.ItemIndex > 0 Then Begin
     If chkRandomHW.Checked Then
        cmb48kMode.Enabled := True
     Else
        If rad48k.Checked or rad16k.Checked Then
           cmb48kMode.Enabled := False
        Else
           cmb48kMode.Enabled := True;
  End Else
     cmb48kMode.Enabled := False;

  lbl48kMode.Enabled := cmb48kMode.Enabled;
  chkBASIC.Enabled := cmbScreenSaverType.ItemIndex > 0;
  lblPause.Enabled := trkPause.Enabled;
  lblPause2.Enabled := trkPause.Enabled;
  If lblPause2.Enabled Then Begin
     If trkPause.Position = 0 Then
        lblPause2.Caption := '1 Frame'
     Else
        lblPause2.Caption := FloatToStr(trkPause.Position/4) + ' Seconds'
  End Else
     lblPause2.Caption := '';

  lblAfterBASIC1.Enabled := (cmbScreenSaverType.ItemIndex > 0) and (chkBASIC.Enabled and chkBASIC.Checked);
  edtBASICScreenCount.Enabled := (cmbScreenSaverType.ItemIndex > 0) and (chkBASIC.Enabled and chkBASIC.Checked);
  udBASICScreenCount.Enabled := (cmbScreenSaverType.ItemIndex > 0) and (chkBASIC.Enabled and chkBASIC.Checked);
  lblAfterBASIC2.Enabled := (cmbScreenSaverType.ItemIndex > 0) and (chkBASIC.Enabled and chkBASIC.Checked);

  chkSuperScale.Enabled := radDirect3D.Checked or radDirectDraw.Checked;
  lblScanlines.Enabled := chkScanlines.Checked;
  trkScanlines.Enabled := chkScanlines.Checked;
  If lblScanlines.Enabled Then
     lblScanlines.Caption := IntToStr(trkScanlines.Position)
  Else
     lblScanlines.Caption := '';

  lblVolume.Enabled := chkSoundEnable.Checked;
  trkVolume.Enabled := chkSoundEnable.Checked;
  lblVolume1.Enabled:= chkSoundEnable.Checked;
  If lblVolume.Enabled Then
     lblVolume.Caption := IntToStr(trkVolume.Position)
  Else
     lblVolume.Caption := '';

End;

Procedure TConfigForm.SaveOptions;
Var
  Idx: Integer;
Begin

  // Generates a .ini file holding the options based on the states of the controls
  // on the configuration form.

  GetAppDir;
  SetCurrentDir(AppDIR);

  INI := TStringlist.Create;

  // Hardware

  Idx := 0;

  If Rad16k.Checked then Idx := 0;
  If Rad48k.Checked Then Idx := 1;
  If Rad128k.Checked Then Idx := 2;
  If RadPlus2.Checked Then Idx := 3;
  If RadPlus2a.Checked Then Idx := 4;
  If RadPlus3.Checked Then Idx := 5;

  INIWrite('Hardware', 'Model', Idx);

  INIWrite('Hardware', 'RandomHW', chkRandomHW.Checked);
  INIWrite('Hardware', 'RandReset', chkRandReset.Checked);

  // Automation

  INIWrite('Automation', 'ScreenSaverType', cmbScreenSaverType.ItemIndex);
  INIWrite('Automation', 'CLS', chkCLS.Checked);
  INIWrite('Automation', 'BASIC', chkBASIC.Checked);
  INIWrite('Automation', 'BASICCount', StrToInt(edtBASICScreenCount.Text));
  INIWrite('Automation', '48kMode', cmb48kMode.ItemIndex);
  INIWrite('Automation', 'ResetType', cmbResetType.ItemIndex);
  INIWrite('Automation', 'ResetCount', StrToInt(edtResetType.Text));
  INIWrite('Automation', 'Pause', trkPause.Position);

  INIWrite('Interaction', 'Mouse', cmbMouse.ItemIndex);
  INIWrite('Interaction', 'RandomChuntey', chkChuntey.Checked);
  INIWrite('Interaction', 'Keyboard', chkKeyboard.Checked);

  // Display settings

  If radDirect3D.Checked Then Idx := 0;
  If radDirectDraw.Checked Then Idx := 1;
  If radGDI.Checked Then Idx := 2;

  INIWrite('Display', 'Renderer', Idx);

  INIWrite('Display', 'Width', DisplayWidth);
  INIWrite('Display', 'Height', DisplayHeight);
  INIWrite('Display', 'Bpp', DisplayBpp);

  INIWrite('Display', 'SuperScale', chkSuperScale.Checked);
  INIWrite('Display', 'Scanlines', chkScanlines.Checked);
  INIWrite('Display', 'ScanlinesTrk', trkScanlines.Position);
  INIWrite('Display', 'Corners', chkCorners.Checked);
  INIWrite('Display', 'Border', cmbBorderSize.ItemIndex);

  INIWrite('Screens', 'ScrFolder', edtScreens.Text);
  INIWrite('Screens', 'Longfilenames', chkLongFileNames.Checked);

  If radStretch.Checked Then Idx := 0;
  If radMaintain.Checked Then Idx := 1;
  If radCrop.Checked Then Idx := 2;

  INIWrite('Display', 'Aspect', Idx);

  INIWrite('Tape', 'Wobble', chkTapeWobble.Checked);
  INIWrite('Tape', 'Hiss', chkTapeHiss.Checked);
  INIWrite('Tape', 'Optimise', chkOptimise.Checked);

  INIWrite('Sound', 'Enabled', chkSoundEnable.Checked);
  INIWrite('Sound', 'Volume', trkVolume.Position);

  If Debugging Then Log('Saving config file to '+AppDir+'\Screen$.ini');
  INI.SaveToFile(AppDir + '\Screen$.ini');
  INI.Free;

End;

Function FloatToStrEx(Number: Extended): String;
Var
  Idx: Integer;
Begin

  // Converts a floating point number into a "xxx.yyy" string.
  // converts commas and such from various localisations into decimal points.

  Result := FloatToStr(Number);

  If Result <> '' Then
     For Idx := 1 To Length(Result) Do
        If Not (Result[Idx] in ['0'..'9', '-']) Then
           Result[Idx] := '.';

End;

// Here follows the procedures that read and write to and from an ini file.
// INIRead and INIWrite are overloaded for the various types of data that need to be
// handled.

Function INIFindSection(Section: String): Integer;
Begin
  Result := 0;
  While (Result < INI.Count) and (Lowercase(INI[Result]) <> '['+Lowercase(Section)+']') Do Inc(Result);
  If Result = INI.Count Then Begin
     If Result <> 0 Then Begin
        INI.Add(' ');
        Inc(Result);
     End;
     INI.Add('['+Section+']');
  End;
End;

Function INIFindEntry(Section, Entry: String): Integer;
Var
  SavedPosition: Integer;
Begin
  Result := INIFindSection(Section)+1;
  SavedPosition := Result;
  If Result = INI.Count Then Dec(Result);
  While Result < INI.Count Do Begin
     If Copy(INI[Result], 1, 1) <> '[' Then Begin
        If LowerCase(Copy(INI[Result], 1, Length(Entry)+1)) = Lowercase(Entry+'=') Then
           Exit
        Else
           Inc(Result);
     End Else Break;
  End;
  If Result = INI.Count Then Begin
     Result := SavedPosition;
     INI.Insert(Result, Entry+'=');
  End Else If Copy(INI[Result], 1, 1) = '[' Then Begin
     Result := SavedPosition;
     INI.Insert(Result, Entry+'=');
  End;
End;

Function INIRead(Section, Entry: String; Default: Boolean): Boolean;
Var
  EntryPos: Integer;
  Value: String;
Begin
  Result := False;
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '1' Then Result := True;
  If Value = '0' Then Result := False;
  If Value = '' Then Begin
     Result := Default;
     If Result Then
        INI[EntryPos] := INI[EntryPos] + '1'
     Else
        INI[EntryPos] := INI[EntryPos] + '0';
  End;
End;

Function INIRead(Section, Entry: String; Default: String): String;
Var
  EntryPos: Integer;
  Value: String;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '' Then Begin
     Result := Default;
     INI[EntryPos] := INI[EntryPos] + Default;
  End Else Result := Value;
End;

Function INIRead(Section, Entry: String; Default: Extended): Extended;
Var
  EntryPos: Integer;
  Value: String;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '' Then Begin
     Result := Default;
     INI[EntryPos] := INI[EntryPos] + FloatToStrEx(Default);
  End Else Result := StrToFloat(Value);
End;

Function INIRead(Section, Entry: String; Default: Integer): Integer;
Var
  EntryPos: Integer;
  Value: String;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '' Then Begin
     Result := Default;
     INI[EntryPos] := INI[EntryPos] + IntToStr(Default);
  End Else Result := StrToIntDef(Value, 0);
End;

Function INIRead(Section, Entry: String; Default: DWord): DWord;
Var
  EntryPos: Integer;
  Value: String;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '' Then Begin
     Result := Default;
     INI[EntryPos] := INI[EntryPos] + IntToStr(Default);
  End Else Result := StrToIntDef(Value, 0);
End;

Function INIRead(Section, Entry: String; Default: Word): Word;
Var
  EntryPos: Integer;
  Value: String;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  Value := Copy(INI[EntryPos], Length(Entry)+2, 999999);
  If Value = '' Then Begin
     Result := Default;
     INI[EntryPos] := INI[EntryPos] + IntToStr(Default);
  End Else Result := StrToIntDef(Value, 0);
End;

Procedure INIWrite(Section, Entry: String; Value: Boolean);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  If Value Then
    INI[EntryPos] := INI[EntryPos] + '1'
  Else
    INI[EntryPos] := INI[EntryPos] + '0';
End;

Procedure INIWrite(Section, Entry: String; Value: String);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  INI[EntryPos] := INI[EntryPos] + Value;
End;

Procedure INIWrite(Section, Entry: String; Value: Integer);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  INI[EntryPos] := INI[EntryPos] + IntToStr(Value);
End;

Procedure INIWrite(Section, Entry: String; Value: DWord);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  INI[EntryPos] := INI[EntryPos] + IntToStr(Value);
End;

Procedure INIWrite(Section, Entry: String; Value: Word);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  INI[EntryPos] := INI[EntryPos] + IntToStr(Value);
End;

Procedure INIWrite(Section, Entry: String; Value: Extended);
Var
  EntryPos: Integer;
Begin
  EntryPos := INIFindEntry(Section, Entry);
  INI[EntryPos] := INI[EntryPos] + FloatToStrEx(Value);
End;

procedure TConfigForm.FormShow(Sender: TObject);
begin

  // Load the options when the form is shown.

  ConfigForm.LoadOptions;
  PageControl1.ActivePageIndex := 0;

  // And centre the form on the screen.

  Left := (Screen.Width - Width) Div 2;
  Top := (Screen.Height - Height) Div 2;

end;

Procedure TConfigForm.GetScreenList;
Var
  F: Integer;
  S: String;
Begin

  // Format a list of screen modes into readable text.

  If Debugging Then Log('Getting screen list');

  ScreenList.Clear;
  GetDisplayModes;
  ScreenList.Sort;

  If Debugging Then Log('Found '+IntToStr(Screenlist.Count)+' screen modes available');

  For F := 0 To ScreenList.Count -1 Do Begin
     S := ScreenList[F];
     While S[1] = '0' Do S := Copy(S, 2, 9999);
     While Pos('x0', S) > 0 Do S := Copy(S, 1, Pos('x0', S))+Copy(S, Pos('x0', S)+2, 9999);
     ScreenList[F] := S;
  End;
  ScreenList.Insert(0, 'Use Desktop resolution');

End;

function GetDisplayModes: Boolean;
var
  DevMode: TDevMode;
  Count: Integer;
  TempStr, Str: String;
begin
  Count := 0;
  Result := False;
  While EnumDisplaySettings(nil, Count, DevMode) Do Begin
     If DevMode.dmPelsHeight >= 240 Then Begin
        TempStr := IntToStr(DevMode.dmPelsWidth);
        While Length(TempStr) < 4 Do TempStr := '0'+TempStr;
        Str := TempStr;

        TempStr := IntToStr(DevMode.dmPelsHeight);
        While Length(TempStr) < 4 Do TempStr := '0'+TempStr;
        Str := Str + 'x' + TempStr;

        TempStr := IntToStr(DevMode.dmBitsPerPel);
        While Length(TempStr) < 4 Do TempStr := '0'+TempStr;
        Str := Str + 'x' + TempStr;

        If DevMode.dmBitsPerPel >= 8 Then
           If ConfigForm.ScreenList.IndexOf(Str) = -1 Then
              ConfigForm.ScreenList.Add(Str);
     End;
     Inc(Count) ;
  End;
  If ConfigForm.Screenlist.Count > 0 Then
     Result := True;
End;

procedure TConfigForm.imv16KClick(Sender: TObject);
begin

  // If the user clicks an image control, this sends that click onto the
  // appropriate radiobutton.

  Case (Sender As TControl).Tag of

     0: rad16k.Checked := True;
     1: rad48k.Checked := True;
     2: rad128k.Checked := True;
     3: radPlus2.Checked := True;
     4: radPlus2A.Checked := True;
     5: radPlus3.Checked := True;

  End;

  // Remember to update the form - some hardware affects other controls.
  // For example, you cannot use USR0, SPECTRUM or the 48k menu option if you're
  // simulating a 16k or 48k Spectrum.

  UpdateForm;

end;

procedure TConfigForm.chkRandomHWClick(Sender: TObject);
begin

  UpdateForm;

end;

procedure TConfigForm.cmbResolutionChange(Sender: TObject);
Var
  S: String;
begin

  // When the user selects a screenmode from the dropdown menu, we
  // need to decode that into a width, height and depth.

  S := cmbResolution.Items[cmbResolution.ItemIndex];
  If cmbResolution.ItemIndex = 0 Then Begin
     DisplayWidth := 0;
     DisplayHeight := 0;
     DisplayBpp := 0;
  End Else Begin
     DisplayWidth := StrToIntDef(Copy(S, 1, Pos('x', S)-1), 640);
     S := Copy(S, Pos('x', S)+1, 9999);
     DisplayHeight := StrToIntDef(Copy(S, 1, Pos('x', S)-1), 480);
     S := Copy(S, Pos('x', S)+1, 9999);
     DisplayBpp := StrToIntDef(S, 16);
  End;

end;

procedure TConfigForm.Button2Click(Sender: TObject);
begin

  // Okay button clicked. Save the options and exit.

  SaveOptions;
  Close;

end;

procedure TConfigForm.Button1Click(Sender: TObject);
begin

  // Cancel clicked - just quit, do not save options.

  Close;

end;

procedure TConfigForm.btnFolderListClick(Sender: TObject);
Var
  TempStr: String;
  Dir: String;
begin

  // Use a folder browser to get a folder that may (or may not) contain a load
  // of .scr files.

  Dir := GetCurrentDir;
  SetCurrentDir(AppDir);
  TempStr := ExpandFilename(edtScreens.Text);
  SetCurrentDir(Dir);

   dlgFolderSelect.Title := 'Select Screens (.scr) folder.';
   dlgFolderSelect.Folder := TempStr;

   If (dlgFolderSelect.Execute) Then
      edtScreens.Text := dlgFolderSelect.Folder;

end;

procedure TConfigForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  // Tidy up on exit.

  If ScreenList <> nil Then
     ScreenList.Free;
  If Screens <> nil Then
     Screens.Free;

end;

procedure TConfigForm.SpinImageView1Click(Sender: TObject);
begin

  // As for the hardware images, this is for the aspect ratio graphics. Passes
  // the click onto the relevant radiobutton.

  Case (Sender As TControl).Tag of

     0: radStretch.Checked := True;
     1: radMaintain.Checked := True;
     2: radCrop.Checked := True;

  End;

end;

end.
