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

unit Speccy_DirectDraw;

interface

Uses Controls, Forms, Math, WinAPI.DirectDraw, WinAPI.Direct3D, Windows, FastIMG,
     FastDIB, FastFX, FastSize, FastDraw, Classes, SysUtils;

Type

  TRenderMode = (rmGDI, rmDirectDraw, rmDirect3D, rmPreview);
  TAspectRatio = (arStretch, arMaintainAspect, arCrop);

  TRenderThread = Class(TThread)
     Procedure Execute; Override;
  End;

Var

  DD:               IDirectDraw7;
  D3D:              IDirect3D7;
  D3DDevice:        IDirect3DDevice7;
  D3DViewPort:      TD3DViewPort7;
  D3DMatrix:        TD3DMatrix;
  D3DScanlinesPoly: Array[0..5] of TD3DTLVertex;
  D3DDisplayPoly:   Array[0..5] of TD3DTLVertex;
  D3DScalePoly:     Array[0..5] of TD3DTLVertex;
  D3DCornerTL:      Array[0..5] of TD3DTLVertex;
  D3DCornerBL:      Array[0..5] of TD3DTLVertex;
  D3DCornerTR:      Array[0..5] of TD3DTLVertex;
  D3DCornerBR:      Array[0..5] of TD3DTLVertex;
  sDescB,
  sDescO, sDescC,
  sDescP, sDescR,
  sDescT, sDescS:   TDDSurfaceDesc2;
  sBackBuffer, sTemp,
  sOriginal, sCorner,
	sPrimary, sRender,
  sTexture, sScan:  IDirectDrawSurface7;
  DPal:             IDirectDrawPalette;
	DClip:				IDirectDrawClipper;
  ddCaps:           TDDCaps;
  ddsCaps:          TDDsCaps;
  DDraw_Handle:     hWnd;
  GDI_Handle:       hWnd;
  Original_Width,
  Original_Height,
  Screen_Width,
  Screen_Height,
  Screen_Bpp,
  Surface_Width,
  Surface_Height,
  Surface_BPP:      Integer;
  ScaleDIB:         TFastDIB;
  DDraw_16bppDIB:   TFastDIB;
  ScanlinesDIB:     TFastDIB;
  DepthDIB:         TFastDIB;
  PreviewDIB:       TFastDIB;
  DXError:          HResult;
  DXErrorString:    String;
  BltFx:            TDDBltFx;
  DDCooperative:    Boolean;
  DDScreen:         Boolean;

  Aspect_OffX,
  Aspect_OffY,
  Aspect_Width,
  Aspect_Height:    Integer;
  dRct, sRct:       TRect;
  GDI_OffX,
  GDI_OffY,
  GDI_TriW,
  GDI_TriH:         Integer;
  Enable_Corners:   Boolean;
  CornerDIBs:       Array[0..3] of TFastDIB;
  CornerSize:       Integer;
  Enable_Scanlines: Boolean;

  Scanline_Scale:   Integer;
  Rendering_API:    TRenderMode;

  GDI_Display:      TFastIMG;
  ColourTable:      Array[0..255] of DWord;

  RenderThread:     TRenderThread;
  RenderThreadDead: Boolean;
  RenderDIB:        TFastDIB;
  Rendering:        Boolean;
  CurAspect:        TAspectRatio;
  Red_Mask,
  Green_Mask,
  Blue_Mask:        DWord;

  ScanlinesLUT:     Array of Word;
  Scanlines16_5LUT: Array of Byte;
  Scanlines16_6LUT: Array of Byte;

Procedure InitGraphics(Control: TControl; RenderMode: TRenderMode; Width, Height, Bpp, Scanline: Integer; SrcDIB: TFastDIB; Aspect: TAspectRatio; SuperScale, Corners: Boolean);
Procedure SetColourTables(SrcDIB: TFastDIB);
Procedure SetAspect(Aspect: TAspectRatio; Width, Height, Bpp: Integer; SuperScale: Boolean; SrcDIB: TFastDIB);
Procedure CreateScanlinesDIB;
Function  InitD3D(Handle: hWnd; Width, Height, Bpp: Integer): HResult;
Function  InitDDraw(Handle: hWnd; Width, Height, Bpp: Integer): HResult;
Function  InitGDI(Img: TFastIMG; Width, Height, Bpp: Integer): HResult;
Function  InitPreview(Img: TFastIMG; Width, Height, Bpp: Integer; DIB: TFastDIB): HResult;
Procedure CloseGraphics;
Procedure ShutDown_DirectDraw(Handle: hWnd);
Procedure ShutDown_GDI;
Procedure DoRender(DIB: TFastDIB);
Procedure RenderFrame(DIB: TFastDIB);
Procedure ColourDump8bit(Src, Dest: Pointer; Pitch: DWord);
Procedure ColourDump16bit(Src, Dest: Pointer; Pitch: DWord);
Procedure ColourDump24bit(Src, Dest: Pointer; Pitch: DWord);
Procedure ColourDump32bit(Src, Dest: Pointer; Pitch: DWord);
Procedure MakeScanlinesLUTs(SrcDIB: TFastDIB; Intensity: Byte);
Procedure ApplyScanlines8(Src, Dest: Pointer; Height, Pitch: DWord);
Procedure ApplyScanlines(Src, Dest: Pointer; Height, Pitch: DWord);

implementation

Uses ScreenStrings;

Procedure PutDWord(WordPtr: Pointer; Value: DWord);
Asm
  mov dword [eax], edx
End;

// The render thread - by running this when a new frame of graphics has been generated,
// and only allowing it to run in idle time (such as when we're waiting for sound sync)
// we get a nice frameskip effect.

Procedure TRenderThread.Execute;
Begin

  // Idle priority means it only runs when the main
  // thread is sleeping

  Priority := TpNormal;
  FreeOnTerminate := True;

  While Not Terminated Do Begin
     If Rendering Then Begin
        DoRender(RenderDIB);
        Rendering := False;
     End Else Begin
        Sleep(1);
     End;
  End;

End;

Procedure InitGraphics(Control: TControl; RenderMode: TRenderMode; Width, Height, Bpp, Scanline: Integer; SrcDIB: TFastDIB; Aspect: TAspectRatio; SuperScale, Corners: Boolean);
Begin

  If Debugging Then Log('Initialising graphics...');

  RenderThread := TRenderThread.Create(False);

  // Initialise the graphics routines.
  // If any parameters are 0, then they inherit their values from the desktop.

  If Width = 0 Then Width := Screen.Width;
  If Height = 0 Then Height := Screen.Height;
  If Bpp = 0 Then Bpp := GetDeviceCaps(GetDc(GetDesktopWindow), BITSPIXEL);

  Rendering_API := RenderMode;

  Screen_BPP := Bpp;
  Screen_Width := Width;
  Screen_Height := Height;

  Original_Width := SrcDIB.Width;
  Original_Height := SrcDIB.Height;

  Enable_Corners := Corners;
  Enable_Scanlines := Scanline <> 0;

  Scanline_Scale := Min(Max(0, ScanLine), 255);

  // Set the requested aspect ratio - this will be set as a rectangle by
  // Aspect_OffX,OffY,Width,Height. It will likely differ from the size of the requested
  // screen resolution.

  SetAspect(Aspect, Screen_Width, Screen_Height, Screen_Bpp, SuperScale, SrcDIB);

  // If we're rendering in D3D or DDraw, then we need to attach them to the window
  // that contains the FastIMG we were supplied with, so find the parent until
  // we get a TForm.

  If RenderMode in [rmDirect3D, rmDirectDraw] Then Begin
     If Debugging Then Log('Hiding the image control for fullscreen DirectX');
     (Control As TFastIMG).Visible := False;
     While Not (Control Is TForm) Do
        Control := Control.Parent;
  End;

  Case RenderMode of

     rmDirect3D:
        Begin
           DXError := InitD3D((Control As TForm).Handle, Screen_Width, Screen_Height, Screen_Bpp);
        End;

     rmDirectDraw:
        Begin
           DXError := InitDDraw((Control As TForm).Handle, Screen_Width, Screen_Height, Screen_Bpp);
        End;

     rmGDI:
        Begin
           DXError := InitGDI((Control As TFastIMG), Screen_Width, Screen_Height, Screen_Bpp);
        End;

     rmPreview:
        Begin
           DXError := InitPreview((Control As TFastIMG), Screen_Width, Screen_Height, Screen_Bpp, SrcDIB);
        End;

  End;

  SetColourTables(SrcDIB);
  MakeScanlinesLUTS(SrcDIB, Scanline_Scale);

End;

Procedure CreateScanlinesDIB;
Var
  Y, X: Integer;
  ColourA, ColourB: TFColorA;
Begin

  If Debugging Then Log('Creating scanlines image');

  // Creates an image which is alphablended onto the
  // GDI and DDraw surfaces. GDI is faster than DDraw for this, as
  // DDraw needs to do a GetDC() every frame.

  ScanlinesDIB := TFastDIB.Create;
  ScanlinesDIB.SetSize(Screen_Width, Screen_Height, 32);

  ColourA := FRGBA(0, 0, 0, Scanline_Scale);
  ColourB := FRGBA(0, 0, 0, 255);

  Y := 0;
  While Y < Screen_Height Do Begin
     X := 0;
     While X < Screen_Width Do Begin
        If Y Mod 1 = 0 Then Begin
           ScanlinesDIB.Pixels32[Y, X] := ColourA;
        End Else Begin
           ScanlinesDIB.Pixels32[Y, X] := ColourB;
        End;
        Inc(X);
     End;
     Inc(Y, 2);
  End;

End;

Procedure SetColourTables(SrcDIB: TFastDIB);
Var
  Clr: TFColorA;
  Idx: Integer;
Begin

  // Build the colour tables - 8bpp is all very well, but later routines
  // need the colours in 16/24 bit mode.

  If Debugging Then Log('Creating colour tables');

  For Idx := 0 To 255 Do Begin

     Clr := SrcDIB.Colors[Idx];
     ColourTable[Idx] := (Round((Red_mask * (Clr.r+1)) / 256) And Red_mask) +
                         (Round((Green_mask * (Clr.g+1)) / 256) And Green_mask) +
                         (Round((Blue_mask * (Clr.b+1)) / 256) And Blue_mask);

  End;

End;

Procedure SetAspect(Aspect: TAspectRatio; Width, Height, Bpp: Integer; SuperScale: Boolean; SrcDIB: TFastDIB);
Var
  X, Y, X1, Y1, Idx, R: Integer;
  CornerScale, SrcHeight: Integer;
Begin

  // The scaledib is the surface that the graphical output of your app is rendered to,
  // with stretching if necessary.

  ScaleDIB := TFastDIB.Create;
  ScaleDIB.UseGDI := True;

  // Constrain the display size to match the aspect type selected

  Case Aspect of

     arStretch:
        Begin

           // Stretching just deforms the bitmap to fit the current screen res.

           If Debugging Then Log('Aspect is stretched mode, '+IntToStr(Width)+'x'+IntToStr(Height));

           Aspect_OffX := 0;
           Aspect_OffY := 0;
           Aspect_Width := Width;
           Aspect_Height := Height;

        End;

     arMaintainAspect:
        Begin

           // Maintaining the aspect ratio adds black bars to the left/right of
           // the display, scaling to the shortest edge of the display.

           If SrcDIB.Width/SrcDIB.AbsHeight <> Width/Height Then Begin

              If SrcDIB.Width/SrcDIB.AbsHeight < Width/Height Then Begin

                 Aspect_Height := Height;
                 Aspect_Width := Round(Aspect_Height * (SrcDIB.Width/SrcDIB.AbsHeight));

              End Else Begin

                 Aspect_Width := Width;
                 Aspect_Height := Round(Aspect_Width * (SrcDIB.AbsHeight/SrcDIB.Width));

              End;

              Aspect_OffX := (Width - Aspect_Width) Div 2;
              Aspect_OffY := (Height - Aspect_Height) Div 2;

           End Else Begin

              Aspect_OffX := 0;
              Aspect_OffY := 0;
              Aspect_Width := Width;
              Aspect_Height := Height;

           End;

           If Debugging Then Log('Aspect is maintained mode, '+IntToStr(Aspect_OffX)+', '+IntToStr(Aspect_OffY)+', '+IntToStr(Aspect_Width)+'x'+IntToStr(Aspect_Height));

        End;

     arCrop:
        Begin

           // Cropping fills the whole screen, but subtracts from the top and bottom
           // to do so, maintaining aspect at the expense of some graphics

           If SrcDIB.Width/SrcDIB.AbsHeight <> Width/Height Then Begin

              If SrcDIB.Width/SrcDIB.AbsHeight > Width/Height Then Begin

                 SrcHeight := Height;
                 Aspect_Height := Height;
                 Aspect_Width := Round(Aspect_Height * (SrcDIB.Width/SrcDIB.AbsHeight));

              End Else Begin

                 Aspect_Width := Width;
                 Aspect_Height := Round(Aspect_Width * (SrcDIB.AbsHeight/SrcDIB.Width));
                 SrcHeight := Round(Aspect_Width * ((192 + 48 + 48)/SrcDIB.Width));

              End;

              Aspect_OffX := (Width - Aspect_Width) Div 2;
              Aspect_OffY := (Height - SrcHeight) Div 2;

           End Else Begin

              Aspect_OffX := 0;
              Aspect_OffY := 0;
              Aspect_Width := Width;
              Aspect_Height := Height;

           End;

           If Debugging Then Log('Aspect is cropped mode, '+IntToStr(Aspect_OffX)+', '+IntToStr(Aspect_OffY)+', '+IntToStr(Aspect_Width)+'x'+IntToStr(Aspect_Height));

        End;

  End;

  // Set the characteristics of the surface that we'll stretch to -
  // Superscale will be very large indeed and is not recommended for
  // GDI or DDraw modes, but it will reduce Bilinear artifacts nicely.

  If SuperScale Then Begin

     Surface_Width := (Aspect_Width Div SrcDIB.Width) * SrcDIB.Width;
     Surface_Height := (Aspect_Height Div SrcDIB.AbsHeight) * SrcDIB.AbsHeight;

     If Debugging Then Log('Superscaling to ' + IntToStr(Surface_Width)+'x'+IntToStr(Surface_Height));

  End Else Begin

     Surface_Width := SrcDIB.Width;
     Surface_Height := SrcDIB.AbsHeight;

     If Debugging Then Log('Scaling to source dib dimensions');

  End;

  ScaleDIB.SetSize(Surface_Width, Surface_Height, Bpp);

  // Now that we have the Aspect ratio sorted (and thus the dimensions of the displayable surface),
  // we can create the image of a rounded corner that will be mirrored to all 4 corners of the screen.

  If Screen_Width/44 > Screen_Height/37 Then
     CornerSize := 2*Round(Screen_Width/44)
  Else
     CornerSize := 2*Round(Screen_Height/37);
  If CornerSize < 16 Then
     CornerSize := 16;

  If Debugging Then Log('Corner size is '+IntToStr(CornerSize)+' pixels');

  // Now we know how big it should be, create the image.

  For Idx := 0 To 3 Do Begin
     CornerDIBs[Idx] := TFastDIB.Create;
     CornerDIBs[Idx].SetSize(CornerSize, CornerSize, 32);
     CornerDIBs[Idx].Clear(tfBlack);
  End;

  If Rendering_API in [rmDirectDraw, rmGDI, rmPreview] Then Begin

     // DDraw and GDI don't get antialiased corners.

     For X := 0 to CornerSize -1 do Begin
        Y := Round(Sqrt(((CornerSize -1) * (CornerSize -1)) - (X * X)));
        For y1 := 0 To Y Do Begin
           CornerDIBs[0].Pixels32[Y1, (CornerSize -1) - X] := TfColorToTfColorA(TfWhite);
           CornerDIBs[1].Pixels32[Y1, X] := TfColorToTfColorA(TfWhite);
           CornerDIBs[2].Pixels32[(CornerSize -1) - Y1, (CornerSize -1) - X] := TfColorToTfColorA(TfWhite);
           CornerDIBs[3].Pixels32[(CornerSize -1) - Y1, X] := TfColorToTfColorA(TfWhite);
        End;

     End;

  End Else Begin

     // Whereas D3D gets lovely antialised goodness.
     // D3D also only needs *one* DIB to hold the image as a texture.

     CornerScale := 16;
     CornerDIBs[1].SetSize(CornerSize * CornerScale, CornerSize * CornerScale, 32);
     For X := 0 to (CornerSize * CornerScale) -1 do Begin
        Y := Round(Sqrt((((CornerSize * CornerScale) -1) * ((CornerSize * CornerScale) -1)) - (X * X)));
        For y1 := 0 To Y Do
           CornerDIBs[1].Pixels32[Y1, ((CornerSize * CornerScale) -1) - X] := TfColorToTfColorA(TfWhite);
     End;

     Y1 := 0;
     While Y1 < CornerSize * CornerScale Do Begin
        X1 := 0;
        While X1 < CornerSize * CornerScale Do Begin
           R := 0;
           For Y := Y1 To Y1 + CornerScale -1 Do
              For X := X1 To X1 + CornerScale -1 Do
                 Inc(R, CornerDIBs[1].Pixels32[Y, X].r);
           CornerDIBs[0].Pixels32[Y1 Div CornerScale, X1 Div CornerScale].r := R Div (CornerScale * CornerScale);
           CornerDIBs[0].Pixels32[Y1 Div CornerScale, X1 Div CornerScale].g := R Div (CornerScale * CornerScale);
           CornerDIBs[0].Pixels32[Y1 Div CornerScale, X1 Div CornerScale].b := R Div (CornerScale * CornerScale);
           Inc(X1, CornerScale);
        End;
        Inc(Y1, CornerScale);
     End;

  End;

End;

Function InitD3D(Handle: hWnd; Width, Height, Bpp: Integer): HResult;
Var
  Error: HResult;
  TriW, TriH, OffX, OffY: Extended;
  DDMemFlags, ColourA, ColourB: DWord;
  Y, X: Integer;
  Dest: Pointer;
  Scale: Extended;
Begin

  If Debugging Then Log('Initialising D3D - '+IntToStr(Width)+'x'+IntToStr(Height)+', '+IntToStr(Bpp)+' Bpp');

  DDCooperative := False;
  DDScreen := False;
  DDraw_Handle := Handle;

  // Create the DirectDraw Object

  If Debugging Then Log('Create DirectDraw');

  Error := DirectDrawCreateEx(nil, DD, IID_IDirectDraw7, nil);
  If Error = DD_OK Then Begin

     // Get the capabilities of the DirectDraw Device

     FillChar(DDCaps, SizeOf(TDDCaps), 0);
     ddCaps.dwSize := SizeOf(TDDCaps);

     Error := DD.GetCaps(@ddCaps, nil);

     If Error = DD_OK Then Begin

        // Set the cooperative level for fullscreen

        If Debugging Then Log('Set DirectDraw Cooperative level');
        Error := DD.SetCooperativeLevel(Handle, DDSCL_FULLSCREEN or DDSCL_EXCLUSIVE or DDSCL_MULTITHREADED);

        If Error = DD_OK Then Begin

           DDCooperative := True;

           // Set the displaymode

           If Debugging Then Log('Set display mode');
           Error := DD.SetDisplayMode(Screen_Width, Screen_Height, Bpp, 0, 0);

           If Error = DD_OK Then Begin

              DDScreen := True;

              // Create the primary surface

              FillChar(sDescP, SizeOf(TDDSurfaceDesc2), 0);
              sDescP.dwSize := SizeOf(TDDSurfaceDesc2);
              sDescP.dwFlags := DDSD_CAPS;
              sDescP.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_VIDEOMEMORY;

              Repeat
                 Sleep(100);
                 If Debugging Then Log('Create Primary surface');
                 Error := DD.CreateSurface(sDescP, sPrimary, nil);
                 If Error = DDERR_NODIRECTDRAWHW Then
                    sDescP.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_SYSTEMMEMORY;
              Until (Error <> DDERR_NOEXCLUSIVEMODE) And (Error <> DDERR_NODIRECTDRAWHW);

              If Error = DD_OK Then Begin

                 // Get the primary surface description - this may be different to what we're expecting.

                 sPrimary.GetSurfaceDesc(sDescP);

                 If (sDescP.dwHeight <> Height) or (sDescP.dwWidth <> Width) or (sDescP.ddpfPixelFormat.dwRGBBitCount <> Bpp) Then Begin

                    If Debugging Then Log('Primary surface mismatch - '+IntToStr(sDescP.dwWidth)+'x'+IntToStr(sDescP.dwHeight)+', '+IntToStr(sDescP.ddpfPixelFormat.dwRGBBitCount));

                    // If there is a difference, then set our properties to match what we actually got.

                    Screen_Bpp := sDescP.ddpfPixelFormat.dwRGBBitCount;

                 End;

                 // Create the render target

                 FillChar(sDescR, SizeOf(TDDSurfaceDesc2), 0);
                 sDescR.dwSize := SizeOf(TDDSurfaceDesc2);
                 sDescR.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
                 sDescR.dwWidth := Screen_Width;
                 sDescR.dwHeight := Screen_Height;

                 If ddCaps.dwCaps And DDCAPS_BLTSTRETCH <> 0 Then
                    DDMemFlags := DDSCAPS_VIDEOMEMORY
                 Else
                    DDMemFlags := DDSCAPS_SYSTEMMEMORY;

                 DDMemFlags := DDMemFlags or DDSCAPS_OFFSCREENPLAIN or DDSCAPS_LOCALVIDMEM or DDSCAPS_3DDEVICE;
                 sDescR.ddsCaps.dwCaps := DDMemFlags;

                 If Debugging Then Log('Create render target surface');
                 Error := DD.CreateSurface(sDescR, sRender, nil);

                 If Error <> DD_OK Then Begin

                    If DDMemFlags And DDSCAPS_VIDEOMEMORY <> 0 Then Begin
                       DDMemFlags := DDSCAPS_SYSTEMMEMORY;
                       DDMemFlags := DDMemFlags or DDSCAPS_OFFSCREENPLAIN or DDSCAPS_3DDEVICE;
                       sDescR.ddsCaps.dwCaps := DDMemFlags;

                       If Debugging Then Log('Cannot use video memory, creating render target in system memory');
                       Error := DD.CreateSurface(sDescR, sRender, nil);

                    End;

                 End Else Begin

                    // Create the original surface that will be used to hold the speccy graphics

                    FillChar(sDescO, SizeOf(TDDSurfaceDesc2), 0);
                    sDescO.dwSize := SizeOf(TDDSurfaceDesc2);
                    sDescO.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT or DDSD_TEXTURESTAGE;
                    sDescO.dwWidth := Original_Width;
                    sDescO.dwHeight := Original_Height;
                    sDescO.ddsCaps.dwCaps := DDSCAPS_VIDEOMEMORY or DDSCAPS_TEXTURE or DDSCAPS_3DDEVICE;
                    sDescO.dwTextureStage := 0;

                    If Debugging Then Log('Create Original surface');
                    Error := DD.CreateSurface(sDescO, sOriginal, nil);

                    If Error = DD_OK Then Begin


                       // Set the colour masks - these will be used by the colourtables function.

                       sOriginal.GetSurfaceDesc(sDescO);
                       Red_Mask := sDescO.ddpfPixelFormat.dwRBitMask;
                       Green_Mask := sDescO.ddpfPixelFormat.dwGBitMask;
                       Blue_Mask := sDescO.ddpfPixelFormat.dwBBitMask;
                       If Debugging then Begin
                          Log('Original Surface Bitdepth is '+IntToStr(sDescO.ddpfPixelFormat.dwRGBBitCount));
                          Log('Red Mask is '+IntToHex(Red_Mask, 8));
                          Log('Green Mask is '+IntToHex(Green_Mask, 8));
                          Log('Blue Mask is '+IntToHex(Blue_Mask, 8));
                       End;

                       If sDescO.ddpfPixelFormat.dwRGBBitCount <> Screen_Bpp Then Begin

                          If Debugging Then Log('Mismatch in requested bit depth ('+IntToStr(Screen_Bpp)+') and obtained depth ('+IntToStr(sDescO.ddpfPixelFormat.dwRGBBitCount)+')');

                          Screen_Bpp := sDescO.ddpfPixelFormat.dwRGBBitCount;

                       End;

                       // Create the Texture surface - we draw to this surface, and it will be
                       // used as a texture on a polygon which is rendered to the render surface.

                       FillChar(sDescT, SizeOf(TDDSurfaceDesc2), 0);
                       sDescT.dwSize := SizeOf(TDDSurfaceDesc2);
                       sDescT.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT or DDSD_PIXELFORMAT or DDSD_TEXTURESTAGE;
                       sDescT.dwWidth := Surface_Width;
                       sDescT.dwHeight := Surface_Height;
                       sDescT.ddsCaps.dwCaps := DDSCAPS_VIDEOMEMORY or DDSCAPS_TEXTURE or DDSCAPS_3DDEVICE;
                       sDescT.dwTextureStage := 0;

                       sDescT.ddpfPixelFormat.dwFlags := DDPF_RGB;
                       sDescT.ddpfPixelFormat.dwRGBBitCount := 32;
                       sDescT.ddpfPixelFormat.dwRBitMask := $FF0000;
                       sDescT.ddpfPixelFormat.dwGBitMask := $FF00;
                       sDescT.ddpfPixelFormat.dwBBitMask := $FF;

                       If Debugging Then Log('Create Texture surface');
                       Error := DD.CreateSurface(sDescT, sTexture, nil);

                    End;

                    If Error = DD_OK Then Begin

                       // Create the Corner texture surface. This will be used for all four corners.

                       FillChar(sDescC, SizeOf(TDDSurfaceDesc2), 0);
                       sDescC.dwSize := SizeOf(TDDSurfaceDesc2);

                       sDescC.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH or DDSD_PIXELFORMAT or DDSD_TEXTURESTAGE;
                       sDescC.ddpfPixelFormat.dwFlags := DDPF_RGB Or DDPF_ALPHAPIXELS;
                       sDescC.ddpfPixelFormat.dwRGBBitCount := 32;
                       sDescC.ddpfPixelFormat.dwRGBAlphaBitMask := $FF000000;
                       sDescC.ddpfPixelFormat.dwRBitMask := $FF0000;
                       sDescC.ddpfPixelFormat.dwGBitMask := $FF00;
                       sDescC.ddpfPixelFormat.dwBBitMask := $FF;
                       sDescC.ddsCaps.dwCaps := DDSCAPS_TEXTURE;
                       sDescC.ddsCaps.dwCaps2 := DDSCAPS2_TEXTUREMANAGE;
                       sDescC.dwAlphaBitDepth := 8;
                       sDescC.dwWidth := CornerSize;
                       sDescC.dwHeight := CornerSize;

                       If Debugging Then Log('Create corner texture');
                       Error := DD.CreateSurface(sDescC, sCorner, nil);

                       If Error = DD_OK Then Begin

                          // Render an alpha-enabled texture from CornerDIBs[0] that we set up earlier
                          // when setting the aspect ratio

                          If Debugging Then Log('Lock corner surface');
                          Error := sCorner.Lock(nil, sDescC, DDLOCK_SURFACEMEMORYPTR or DDLOCK_WRITEONLY, 0);

                          If Error = DD_OK Then Begin

                             If Debugging Then Log('Dump corner image to corner surface');
                             Dest := sDescC.lpSurface;

                             For Y := 0 To CornerSize -1 Do Begin
                                For X := 0 To CornerSize -1 Do Begin
                                   PutDWord(Dest, DWord((255 - CornerDIBs[0].Pixels32[CornerSize - 1 - Y, X].r) Shl 24));
                                   Inc(DWord(Dest), 4);
                                End;
                                Inc(DWord(Dest), DWord(sDescC.lPitch) - (sDescC.dwWidth * 4));
                             End;

                             If Debugging Then Log('Unlock corner surface');
                             sCorner.Unlock(Nil);

                          End;

                       End;

                    End;

                    If Error = DD_OK Then Begin

                       // Create the Scanlines texture surface

                       FillChar(SDescS, SizeOf(TDDSurfaceDesc2), 0);
                       SDescS.dwSize := SizeOf(TDDSurfaceDesc2);

                       sDescS.dwFlags := DDSD_CAPS or DDSD_HEIGHT or DDSD_WIDTH or DDSD_PIXELFORMAT or DDSD_TEXTURESTAGE;
                       sDescS.ddpfPixelFormat.dwFlags := DDPF_RGB Or DDPF_ALPHAPIXELS;
                       sDescS.ddpfPixelFormat.dwRGBBitCount := 32;
                       sDescS.ddpfPixelFormat.dwRGBAlphaBitMask := $FF000000;
                       sDescS.ddpfPixelFormat.dwRBitMask := $FF0000;
                       sDescS.ddpfPixelFormat.dwGBitMask := $FF00;
                       sDescS.ddpfPixelFormat.dwBBitMask := $FF;
                       sDescS.ddsCaps.dwCaps := DDSCAPS_TEXTURE;
                       sDescS.ddsCaps.dwCaps2 := DDSCAPS2_TEXTUREMANAGE;
                       sDescS.dwAlphaBitDepth := 8;
                       sDescS.dwWidth := 64;
                       sDescS.dwHeight := 64;

                       If Debugging Then Log('Create scanlines texture');
                       Error := DD.CreateSurface(sDescS, sScan, nil);

                       If Error = DD_OK Then Begin

                          // Render the Scanlines to the texture surface

                          If Debugging Then Log('Lock scanlines surface');
                          Error := sScan.Lock(nil, sDescS, DDLOCK_SURFACEMEMORYPTR or DDLOCK_WRITEONLY, 0);

                          If Error = DD_OK Then Begin

                             If Debugging Then Log('Render scanlines to scanlines texture');
                             Dest := sDescS.lpSurface;

                             ColourA := $00FFFFFF;
                             ColourB := Byte(ScanLine_Scale) Shl 24;

                             For Y := 0 To 31 Do Begin

                                For X := 0 To 63 Do Begin

                                   PutDWord(Dest, ColourA);
                                   Inc(DWord(Dest), 4);

                                End;

                                For X := 0 To 63 Do Begin

                                   PutDWord(Dest, ColourB);
                                   Inc(DWord(Dest), 4);

                                End;

                             End;

                             Error := sScan.Unlock(nil);

                          End;

                       End;

                       If Error = DD_OK Then Begin

                          // Create the clipper

                          If Debugging Then Log('Create clipper');
                          Error := DD.CreateClipper(0, DClip, nil);

                          If Error = DD_OK Then Begin

                             DClip.SetHWnd(0, Handle);
                             If Debugging Then Log('Set clipper to primary surface');
                             sPrimary.SetClipper(DClip);
                             If Debugging Then Log('Release clipper');
                             DClip._Release;

                             // Create the D3D Interface

                             If Debugging Then Log('Query interface for D3D');
                             Error := DD.QueryInterface(IID_IDirect3D7, D3D);

                             If Error = DD_OK Then Begin

                                // Create the actual D3D Device

                                If Debugging Then Log('Create D3D TnL device');
                                Error := D3D.CreateDevice(IID_IDirect3DTnLHalDevice, sRender, D3DDevice);

                                If Error = D3D_OK Then Begin

                                   // Set the viewport

                                   D3DViewport.dwX := 0;
                                   D3DViewport.dwY := 0;
                                   D3DViewport.dwWidth := Screen_Width;
                                   D3DViewport.dwHeight := Screen_Height;
                                   D3DViewport.dvMinZ := 0.0;
                                   D3DViewport.dvMaxZ := 1.0;

                                   If Debugging Then Log('Set viewport');
                                   Error := D3DDevice.SetViewport(D3DViewport);

                                   If Error = D3D_OK Then Begin

                                      If Debugging Then Log('Create polygons');
                                      // Create the polygon for rendering

                                      TriW := Aspect_Width + Aspect_OffX;
                                      TriH := Aspect_Height + Aspect_OffY;

                                      OffX := Aspect_OffX;
                                      OffY := Aspect_OffY;

                                      Scale := 1;

                                      D3DDisplayPoly[0].sx := OffX; D3DDisplayPoly[0].sy := OffY; D3DDisplayPoly[0].sz := 0; // Top Left
                                      D3DDisplayPoly[0].Color := $FFFFFFFF;
                                      D3DDisplayPoly[0].tu := 0; D3DDisplayPoly[0].tv := 0;

                                      D3DDisplayPoly[1].sx := TriW; D3DDisplayPoly[1].sy := OffY; D3DDisplayPoly[1].sz := 0; // Top Right
                                      D3DDisplayPoly[1].Color := $FFFFFFFF;
                                      D3DDisplayPoly[1].tu := Scale; D3DDisplayPoly[1].tv := 0;

                                      D3DDisplayPoly[2].sx := OffX; D3DDisplayPoly[2].sy := TriH; D3DDisplayPoly[2].sz := 0; // Bottom Left
                                      D3DDisplayPoly[2].Color := $FFFFFFFF;
                                      D3DDisplayPoly[2].tu := 0; D3DDisplayPoly[2].tv := Scale;

                                      D3DDisplayPoly[3].sx := TriW; D3DDisplayPoly[3].sy := TriH; D3DDisplayPoly[3].sz := 0; // Bottom Right
                                      D3DDisplayPoly[3].Color := $FFFFFFFF;
                                      D3DDisplayPoly[3].tu := Scale; D3DDisplayPoly[3].tv := Scale;

                                      // Create the Scanlines polygon

                                      OffX := 0;
                                      OffY := 0;
                                      TriW := Screen_Width;
                                      TriH := ((Screen_Height Div 64) + 1)*64;
                                      Scale := TriH / 64;

                                      D3DScanlinesPoly[0].sx := OffX; D3DScanlinesPoly[0].sy := OffY; D3DScanlinesPoly[0].sz := 0; // Top Left
                                      D3DScanlinesPoly[0].Color := $FFFFFFFF;
                                      D3DScanlinesPoly[0].tu := 0; D3DScanlinesPoly[0].tv := 0;

                                      D3DScanlinesPoly[1].sx := TriW; D3DScanlinesPoly[1].sy := OffY; D3DScanlinesPoly[1].sz := 0; // Top Right
                                      D3DScanlinesPoly[1].Color := $FFFFFFFF;
                                      D3DScanlinesPoly[1].tu := 1; D3DScanlinesPoly[1].tv := 0;

                                      D3DScanlinesPoly[2].sx := OffX; D3DScanlinesPoly[2].sy := TriH; D3DScanlinesPoly[2].sz := 0; // Bottom Left
                                      D3DScanlinesPoly[2].Color := $FFFFFFFF;
                                      D3DScanlinesPoly[2].tu := 0; D3DScanlinesPoly[2].tv := Scale;

                                      D3DScanlinesPoly[3].sx := TriW; D3DScanlinesPoly[3].sy := TriH; D3DScanlinesPoly[3].sz := 0; // Bottom Right
                                      D3DScanlinesPoly[3].Color := $FFFFFFFF;
                                      D3DScanlinesPoly[3].tu := 1; D3DScanlinesPoly[3].tv := Scale;

                                      // Create the superscale polygon

                                      D3DScalePoly[0].sx := 0; D3DScalePoly[0].sy := 0; D3DScalePoly[0].sz := 0; // Top Left
                                      D3DScalePoly[0].Color := $FFFFFFFF;
                                      D3DScalePoly[0].tu := 0; D3DScalePoly[0].tv := 0;

                                      D3DScalePoly[1].sx := Surface_Width; D3DScalePoly[1].sy := 0; D3DScalePoly[1].sz := 0; // Top Right
                                      D3DScalePoly[1].Color := $FFFFFFFF;
                                      D3DScalePoly[1].tu := 1; D3DScalePoly[1].tv := 0;

                                      D3DScalePoly[2].sx := 0; D3DScalePoly[2].sy := Surface_Height; D3DScalePoly[2].sz := 0; // Bottom Left
                                      D3DScalePoly[2].Color := $FFFFFFFF;
                                      D3DScalePoly[2].tu := 0; D3DScalePoly[2].tv := 1;

                                      D3DScalePoly[3].sx := Surface_Width; D3DScalePoly[3].sy := Surface_Height; D3DScalePoly[3].sz := 0; // Bottom Right
                                      D3DScalePoly[3].Color := $FFFFFFFF;
                                      D3DScalePoly[3].tu := 1; D3DScalePoly[3].tv := 1;

                                      // Create the Top-left corner polygon

                                      If Aspect_Offx < 0 Then OffX := -0.5 Else OffX := Aspect_OffX -0.5;
                                      If Aspect_Offy < 0 Then OffY := -0.5 Else OffY := Aspect_OffY -0.5;
                                      If Aspect_Offx + Aspect_Width > Screen_Width Then TriW := Screen_Width -0.5 Else TriW := Aspect_Width + Aspect_Offx -0.5;
                                      If Aspect_Offy + Aspect_Height > Screen_Height Then TriH := Screen_Height -0.5 Else TriH := Aspect_Height + Aspect_Offy -0.5;

                                      D3DCornerTL[0].sx := OffX; D3DCornerTL[0].sy := OffY; D3DCornerTL[0].sz := 0; // Top Left
                                      D3DCornerTL[0].Color := $FFFFFFFF;
                                      D3DCornerTL[0].tu := 0; D3DCornerTL[0].tv := 0;

                                      D3DCornerTL[1].sx := OffX + CornerSize; D3DCornerTL[1].sy := OffY; D3DCornerTL[1].sz := 0; // Top Right
                                      D3DCornerTL[1].Color := $FFFFFFFF;
                                      D3DCornerTL[1].tu := 1; D3DCornerTL[1].tv := 0;

                                      D3DCornerTL[2].sx := OffX; D3DCornerTL[2].sy := OffY + CornerSize; D3DCornerTL[2].sz := 0; // Bottom Left
                                      D3DCornerTL[2].Color := $FFFFFFFF;
                                      D3DCornerTL[2].tu := 0; D3DCornerTL[2].tv := 1;

                                      D3DCornerTL[3].sx := OffX + CornerSize; D3DCornerTL[3].sy := OffY + CornerSize; D3DCornerTL[3].sz := 0; // Bottom Right
                                      D3DCornerTL[3].Color := $FFFFFFFF;
                                      D3DCornerTL[3].tu := 1; D3DCornerTL[3].tv := 1;

                                      // Create the Top-right corner polygon

                                      D3DCornerTR[0].sx := TriW - CornerSize; D3DCornerTR[0].sy := OffY; D3DCornerTR[0].sz := 0; // Top Left
                                      D3DCornerTR[0].Color := $FFFFFFFF;
                                      D3DCornerTR[0].tu := 1; D3DCornerTR[0].tv := 0;

                                      D3DCornerTR[1].sx := TriW; D3DCornerTR[1].sy := OffY; D3DCornerTR[1].sz := 0; // Top Right
                                      D3DCornerTR[1].Color := $FFFFFFFF;
                                      D3DCornerTR[1].tu := 0; D3DCornerTR[1].tv := 0;

                                      D3DCornerTR[2].sx := TriW - CornerSize; D3DCornerTR[2].sy := OffY + CornerSize; D3DCornerTR[2].sz := 0; // Bottom Left
                                      D3DCornerTR[2].Color := $FFFFFFFF;
                                      D3DCornerTR[2].tu := 1; D3DCornerTR[2].tv := 1;

                                      D3DCornerTR[3].sx := TriW; D3DCornerTR[3].sy := OffY + CornerSize; D3DCornerTR[3].sz := 0; // Bottom Right
                                      D3DCornerTR[3].Color := $FFFFFFFF;
                                      D3DCornerTR[3].tu := 0; D3DCornerTR[3].tv := 1;

                                      // Create the Bottom-left corner polygon

                                      D3DCornerBL[0].sx := OffX; D3DCornerBL[0].sy := TriH - CornerSize; D3DCornerBL[0].sz := 0; // Top Left
                                      D3DCornerBL[0].Color := $FFFFFFFF;
                                      D3DCornerBL[0].tu := 0; D3DCornerBL[0].tv := 1;

                                      D3DCornerBL[1].sx := OffX + CornerSize; D3DCornerBL[1].sy := TriH - CornerSize; D3DCornerBL[1].sz := 0; // Top Right
                                      D3DCornerBL[1].Color := $FFFFFFFF;
                                      D3DCornerBL[1].tu := 1; D3DCornerBL[1].tv := 1;

                                      D3DCornerBL[2].sx := OffX; D3DCornerBL[2].sy := TriH; D3DCornerBL[2].sz := 0; // Bottom Left
                                      D3DCornerBL[2].Color := $FFFFFFFF;
                                      D3DCornerBL[2].tu := 0; D3DCornerBL[2].tv := 0;

                                      D3DCornerBL[3].sx := OffX + CornerSize; D3DCornerBL[3].sy := TriH; D3DCornerBL[3].sz := 0; // Bottom Right
                                      D3DCornerBL[3].Color := $FFFFFFFF;
                                      D3DCornerBL[3].tu := 1; D3DCornerBL[3].tv := 0;

                                      // Create the Bottom-Right corner polygon

                                      D3DCornerBR[0].sx := TriW - CornerSize; D3DCornerBR[0].sy := TriH - CornerSize; D3DCornerBR[0].sz := 0; // Top Left
                                      D3DCornerBR[0].Color := $FFFFFFFF;
                                      D3DCornerBR[0].tu := 1; D3DCornerBR[0].tv := 1;

                                      D3DCornerBR[1].sx := TriW; D3DCornerBR[1].sy := TriH - CornerSize; D3DCornerBR[1].sz := 0; // Top Right
                                      D3DCornerBR[1].Color := $FFFFFFFF;
                                      D3DCornerBR[1].tu := 0; D3DCornerBR[1].tv := 1;

                                      D3DCornerBR[2].sx := TriW - CornerSize; D3DCornerBR[2].sy := TriH; D3DCornerBR[2].sz := 0; // Bottom Left
                                      D3DCornerBR[2].Color := $FFFFFFFF;
                                      D3DCornerBR[2].tu := 1; D3DCornerBR[2].tv := 0;

                                      D3DCornerBR[3].sx := TriW; D3DCornerBR[3].sy := TriH; D3DCornerBR[3].sz := 0; // Bottom Right
                                      D3DCornerBR[3].Color := $FFFFFFFF;
                                      D3DCornerBR[3].tu := 0; D3DCornerBR[3].tv := 0;

                                      // Set the scaling and filtering parameters

                                      If Debugging Then Log('Set scaling and filtering parameters');
                                      D3DDevice.SetRenderState(D3DRENDERSTATE_ALPHABLENDENABLE, 1);
                                      D3DDevice.SetRenderState(D3DRENDERSTATE_SRCBLEND, DWord(D3DBLEND_SRCALPHA));
                                      D3DDevice.SetRenderState(D3DRENDERSTATE_DESTBLEND, DWord(D3DBLEND_INVSRCALPHA));
                                      D3DDevice.SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);

                                      If Debugging Then Log('Clear render target');
                                      D3DDevice.Clear(0, nil, D3DCLEAR_TARGET, 0, 0, 0);

                                   End;

                                End;

                             End;

                          End;

                       End;

                    End;

                 End;

              End;

           End;

        End;

     End;

  End;

  Result := Error;
  DXErrorString := DDErrorString(Error);

  If Debugging Then Log('D3D Init done - '+DXErrorString);

End;

Function InitDDraw(Handle: hWnd; Width, Height, Bpp: Integer): HResult;
Var
  Error: HResult;
  DDMemFlags: DWord;
  BltFX: TDDBLTFX;
  ddsCaps: TDDSCaps2;
  X, Y: Integer;
Begin

  If Debugging Then Log('Initialising DDraw - '+IntToStr(Width)+'x'+IntToStr(Height)+', '+IntToStr(Bpp)+' Bpp');

  DDCooperative := False;
  DDScreen := False;
  DDraw_Handle := Handle;

  // StretchBlt() has a big which prevents 8bpp depths being converted to
  // 16bpp with correct colours. Solve this by using an internal DIB to do the
  // conversion to first.

  If (Bpp = 16) And ((ScaleDIB.Width > Original_Width) or (ScaleDIB.AbsHeight > Original_Height)) Then Begin
     DDraw_16bppDIB := TFastDIB.Create;
     DDraw_16bppDIB.SetSize(Original_Width, Original_Height, 16);
  End Else
     DDraw_16bppDIB := nil;

  // Create the DirectDraw Object

  If Debugging Then Log('Create Directdraw object');
  Error := DirectDrawCreateEx(nil, DD, IID_IDirectDraw7, nil);
  If Error = DD_OK Then Begin

     // Get the capabilities of the DirectDraw Device

     FillChar(DDCaps, SizeOf(TDDCaps), 0);
     ddCaps.dwSize := SizeOf(TDDCaps);

     Error := DD.GetCaps(@ddCaps, nil);

     If Error = DD_OK Then Begin

        // Set the cooperative level for fullscreen

        If Debugging Then Log('Set DDraw cooperative level');
        Error := DD.SetCooperativeLevel(Handle, DDSCL_FULLSCREEN or DDSCL_EXCLUSIVE or DDSCL_MULTITHREADED);

        If Error = DD_OK Then Begin

           DDCooperative := True;

           // Set the displaymode

           If Debugging Then Log('Set display mode');
           Error := DD.SetDisplayMode(Screen_Width, Screen_Height, Bpp, 0, 0);

           If Error = DD_OK Then Begin

              DDScreen := True;

              // Create the primary surface

              FillChar(sDescP, SizeOf(TDDSurfaceDesc2), 0);
              sDescP.dwSize := SizeOf(TDDSurfaceDesc2);
              sDescP.dwFlags := DDSD_CAPS or DDSD_BACKBUFFERCOUNT;
              sDescP.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_VIDEOMEMORY or DDSCAPS_FLIP or DDSCAPS_COMPLEX;
              sDescP.dwBackBufferCount := 1;

              Repeat
                 Sleep(100);
                 If Debugging Then Log('Create primary surface');
                 Error := DD.CreateSurface(sDescP, sPrimary, nil);
                 If Error = DDERR_NODIRECTDRAWHW Then
                    sDescP.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE or DDSCAPS_SYSTEMMEMORY;
              Until (Error <> DDERR_NOEXCLUSIVEMODE) And (Error <> DDERR_NODIRECTDRAWHW);

              If Error = DD_OK Then Begin

                 // Get the primary surface description - this may be different to what we're expecting.

                 sPrimary.GetSurfaceDesc(sDescP);
                 If (sDescP.dwHeight <> Height) or (sDescP.dwWidth <> Width) or (sDescP.ddpfPixelFormat.dwRGBBitCount <> Bpp) Then Begin

                    If Debugging Then Log('Primary surface mismatch - '+IntToStr(sDescP.dwWidth)+'x'+IntToStr(sDescP.dwHeight)+', '+IntToStr(sDescP.ddpfPixelFormat.dwRGBBitCount));

                    // If there is a difference, then set our properties to match what we actually got.

                    Screen_Bpp := sDescP.ddpfPixelFormat.dwRGBBitCount;
                    Bpp := Screen_Bpp;
                    ScaleDIB.SetSize(ScaleDIB.Width, ScaleDIB.Height, Bpp);

                 End;

                 FillChar(ddsCaps, SizeOf(TDDSCaps2), 0);
                 ddsCaps.dwCaps := DDSCAPS_BACKBUFFER;
                 If Debugging Then Log('Get backbuffer attached surface');
                 sPrimary.GetAttachedSurface(ddsCaps, sBackBuffer);

                 // Clear the Backbuffer

                 FillMemory(@BltFX, SizeOf(TDDBLTFX), 0);
                 BltFx.dwSize := SizeOf(TDDBLTFX);
                 BltFx.dwFillColor := 0;
                 Error := sBackBuffer.Blt(Nil, Nil, Nil, DDBLT_COLORFILL or DDBLT_WAIT, @BltFx);

                 // Create the scanlines temporary surface in system memory

                 If Enable_Scanlines Then Begin

                    FillChar(sDescT, SizeOf(TDDSurfaceDesc2), 0);
                    sDescT.dwSize := SizeOf(TDDSurfaceDesc2);
                    sDescT.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
                    sDescT.dwWidth := Screen_Width;
                    sDescT.dwHeight := Screen_Height;
                    sDescT.ddsCaps.dwCaps := DDSCAPS_SYSTEMMEMORY or DDSCAPS_OFFSCREENPLAIN;

                    If Debugging Then Log('Create Temporary surface');
                    Error := DD.CreateSurface(sDescT, sTemp, nil);

                 End;

                 If Error = DD_OK Then Begin

                    // Create the drawing buffer

                    FillChar(sDescR, SizeOf(TDDSurfaceDesc2), 0);
                    sDescR.dwSize := SizeOf(TDDSurfaceDesc2);
                    sDescR.dwFlags := DDSD_CAPS or DDSD_WIDTH or DDSD_HEIGHT;
                    sDescR.dwWidth := Surface_Width;
                    sDescR.dwHeight := Surface_Height;

                    If ddCaps.dwCaps And DDCAPS_BLTSTRETCH <> 0 Then
                       DDMemFlags := DDSCAPS_VIDEOMEMORY
                    Else
                       DDMemFlags := DDSCAPS_SYSTEMMEMORY;

                    DDMemFlags := DDMemFlags or DDSCAPS_OFFSCREENPLAIN or DDSCAPS_LOCALVIDMEM;
                    sDescR.ddsCaps.dwCaps := DDMemFlags;

                    If Debugging Then Log('Create Rendering surface');
                    Error := DD.CreateSurface(sDescR, sRender, nil);

                    If Error <> DD_OK Then Begin

                       If DDMemFlags And DDSCAPS_VIDEOMEMORY <> 0 Then Begin
                          DDMemFlags := DDSCAPS_SYSTEMMEMORY;
                          DDMemFlags := DDMemFlags or DDSCAPS_OFFSCREENPLAIN;
                          sDescR.ddsCaps.dwCaps := DDMemFlags;

                          If Debugging Then Log('Cannot use video memory, creating render surface in system memory');
                          Error := DD.CreateSurface(sDescR, sRender, nil);

                       End;

                    End;

                 End;

                 If Error = DD_OK Then Begin

                    // Get the pixel format's bitmasks

                    sRender.GetSurfaceDesc(sDescR);
                    Red_Mask := sDescR.ddpfPixelFormat.dwRBitMask;
                    Green_Mask := sDescR.ddpfPixelFormat.dwGBitMask;
                    Blue_Mask := sDescR.ddpfPixelFormat.dwBBitMask;
                    If Debugging then Begin
                       Log('Render Surface Bitdepth is '+IntToStr(sDescO.ddpfPixelFormat.dwRGBBitCount));
                       Log('Red Mask is '+IntToHex(Red_Mask, 8));
                       Log('Green Mask is '+IntToHex(Green_Mask, 8));
                       Log('Blue Mask is '+IntToHex(Blue_Mask, 8));
                       Log('ScaleDIB Bitdepth is '+IntToStr(ScaleDIB.Bpp));
                       Log('Red Mask is '+IntToHex(ScaleDIB.Info.RMask, 8));
                       Log('Green Mask is '+IntToHex(ScaleDIB.Info.GMask, 8));
                       Log('Blue Mask is '+IntToHex(ScaleDIB.Info.BMask, 8));
                    End;

                    // Create the clipper

                    If Debugging Then Log('Create clipper');
                    Error := DD.CreateClipper(0, DClip, nil);

                    If Error = DD_OK Then Begin

                       DClip.SetHWnd(0, Handle);
                       If Debugging Then Log('Setting clipper to primary surface');
                       sPrimary.SetClipper(DClip);
                       If Debugging Then Log('Releasing clipper');
                       DClip._Release;

                    End;

                 End;

              End;

           End;

        End;

     End;

  End;

  CreateScanlinesDIB;

  // Sometimes the Aspect ratio settings will mean that we need to render to
  // a rectangle that is larger than the screen - particularly for the arCrop variation.
  // This is no good if we position the rounded corners at the corners of the rendered
  // Image - so constrain them to screen dimensions if necessary.

  If Aspect_Offx < 0 Then GDI_OffX := 0 Else GDI_OffX := Aspect_OffX;
  If Aspect_Offy < 0 Then GDI_OffY := 0 Else GDI_OffY := Aspect_OffY;
  If Aspect_Offx + Aspect_Width > Screen_Width Then GDI_TriW := Screen_Width Else GDI_TriW := Aspect_Width + Aspect_Offx;
  If Aspect_Offy + Aspect_Height > Screen_Height Then GDI_TriH := Screen_Height Else GDI_TriH := Aspect_Height + Aspect_Offy;

  If Aspect_OffY >= 0 Then Begin
     dRct := Rect(Aspect_OffX, Aspect_OffY, Aspect_OffX + Aspect_Width, Aspect_OffY + Aspect_Height);
     sRct := Rect(0, 0, Surface_Width, Surface_Height);
  End Else Begin
     dRct := Rect(0, 0, Screen_Width, Screen_Height);
     X := Round(Abs(Aspect_OffX/Aspect_Width)*Surface_Width);
     Y := Round(Abs(Aspect_OffY/Aspect_Height)*Surface_Height);
     sRct := Rect(X, Y, X + Round((Screen_Width/Aspect_Width)*Surface_Width), Y + Round((Screen_Height/Aspect_Height)*Surface_Height));
  End;

  FillChar(sDescT, SizeOf(TDDSurfaceDesc2), 0);
  sDescT.dwSize := SizeOf(TDDSurfaceDesc2);
  FillChar(sDescB, SizeOf(TDDSurfaceDesc2), 0);
  sDescB.dwSize := SizeOf(TDDSurfaceDesc2);

  Result := Error;
  DXErrorString := DDErrorString(Error);

  If Debugging Then Log('DDraw initialisation done - '+DXErrorString);

End;

Function InitGDI(Img: TFastIMG; Width, Height, Bpp: Integer): HResult;
Var
  DevMode: _DeviceModeW;
  Control: TControl;
Begin

  // Set up fullscreen mode, without touching DirectDraw

  If Debugging Then Log('Initialising GDI - '+IntToStr(Width)+'x'+IntToStr(Height)+', '+IntToStr(Bpp)+' Bpp');

  FillChar(DevMode, SizeOf(_DeviceModeW), 0);
  DevMode.dmSize := SizeOf(_DeviceModeW);
  DevMode.dmPelsWidth := Width;
  DevMode.dmPelsHeight := Height;
  DevMode.dmBitsPerPel := Bpp;
  DevMode.dmFields := DM_BITSPERPEL or DM_PELSWIDTH or DM_PELSHEIGHT;

  If Debugging Then Log('Change display settings');

  Result := Windows.ChangeDisplaySettings(DevMode, CDS_FULLSCREEN);

  If Result = DISP_CHANGE_SUCCESSFUL Then Begin

     // The FastIMG supplied is our rendering target, so make sure it's
     // visible and fills the whole form.

     If Debugging Then Log('Set GDI parameters');

     GDI_Display := Img;
     GDI_Display.Align := alClient;
     GDI_Display.Bmp.SetSize(Width, Height, Bpp);
     GDI_Display.Visible := True;

     // Now step through the parents of the FastIMG, until we find the form
     // that it lives on.

     If Debugging Then Log('Find parent control');
     Control := Img As TControl;
     While Not (Control Is TForm) Do
        Control := Control.Parent;

     // Set the window to the size of the screen.

     If Debugging Then Log('Set parent form to correct size');
     Control.SetBounds(0, 0, Width, Height);
     CreateScanlinesDIB;

  End;

  // See InitDDraw() for an explanation of this next part.

  If Aspect_Offx < 0 Then GDI_OffX := 0 Else GDI_OffX := Aspect_OffX;
  If Aspect_Offy < 0 Then GDI_OffY := 0 Else GDI_OffY := Aspect_OffY;
  If Aspect_Offx + Aspect_Width > Screen_Width Then GDI_TriW := Screen_Width Else GDI_TriW := Aspect_Width + Aspect_Offx;
  If Aspect_Offy + Aspect_Height > Screen_Height Then GDI_TriH := Screen_Height Else GDI_TriH := Aspect_Height + Aspect_Offy;

  If Debugging Then Log('GDI Initialisation done');

End;

Function InitPreview(Img: TFastIMG; Width, Height, Bpp: Integer; DIB: TFastDIB): HResult;
Begin

  If Debugging Then Log('Initialising Preview - '+IntToStr(Width)+'x'+IntToStr(Height)+', '+IntToStr(Bpp)+' Bpp');

  // rmPreview is for drawing our output to a window. It's very similar to GDI mode.
  // Only useful for very small windows, as there's no real filtering here.

  If Debugging Then Log('Set GDI parameters');

  GDI_Display := Img;
  GDI_Display.Align := alClient;
  GDI_Display.Bmp.SetSize(Width, Height, Bpp);
  GDI_Display.Visible := True;
  CreateScanlinesDIB;

  // Doesn't use fullscreen or DDraw cooperative levels,
  // so no need to reset them on exit - these flags prevent that.

  DDScreen := False;
  DDCooperative := False;

  // DepthDIB is an image which we use to coax GDI into performing colour depth
  // conversion for us.

  If Debugging Then Log('Create Depth conversion DIB');

  DepthDIB := TFastDIB.Create;
  DepthDIB.SetSize(DIB.Width, DIB.Height, 32);

  // PreviewDIB is a smaller image that's the same size as the window we're rendering to.

  If Debugging Then Log('Create Preview DIB');

  PreviewDIB := TFastDIB.Create;
  PreviewDIB.SetSize(Aspect_Width, Aspect_Height, 32);

  // As for InitDDraw(), we set the positions for the rounded corners here.

  If Aspect_Offx < 0 Then GDI_OffX := 0 Else GDI_OffX := Aspect_OffX;
  If Aspect_Offy < 0 Then GDI_OffY := 0 Else GDI_OffY := Aspect_OffY;
  If Aspect_Offx + Aspect_Width > Screen_Width Then GDI_TriW := Screen_Width Else GDI_TriW := Aspect_Width + Aspect_Offx;
  If Aspect_Offy + Aspect_Height > Screen_Height Then GDI_TriH := Screen_Height Else GDI_TriH := Aspect_Height + Aspect_Offy;

  Result := 0;

  If Debugging Then Log('Preview Initialisation done');

End;

Procedure CloseGraphics;
Var
  Idx: Integer;
Begin

  If Debugging Then Log('Shutting down graphics');

  // Shutdown the graphics systems.

  RenderThread.Terminate;
  Sleep(100);

  If Debugging Then Log('Free DIBs (scale and corners)');
  If ScaleDIB <> nil Then ScaleDIB.Free;
  For Idx := 0 To 3 Do
     If CornerDIBs[Idx] <> Nil Then
        CornerDIBs[Idx].Free;

  Case Rendering_API Of

     rmDirect3D, rmDirectDraw:
        Shutdown_DirectDraw(DDraw_Handle);

     rmGDI, rmPreview:
        Begin
           Shutdown_GDI;
        End;

  End;

End;

Procedure ShutDown_DirectDraw(Handle: hWnd);
Begin

  // Restore the desktop

  If Debugging Then Log('Shutting down DirectDraw');

  If Rendering_API = rmDirectDraw Then Begin
     If Debugging Then Log('Deleting backbuffer');
     sPrimary.DeleteAttachedSurface(0, sBackBuffer);
     sBackBuffer := nil;
     If DDraw_16bppDIB <> nil Then
        DDraw_16bppDIB.Free;
  End;

  If Debugging Then Log('Freeing DIBs');
  If ScanlinesDIB <> nil Then ScanlinesDIB.Free;
  If DDScreen Then Begin
     If Debugging Then Log('Restore display mode');
     DD.RestoreDisplayMode;
  End;
  If DDCooperative Then Begin
     If Debugging Then Log('Setting cooperative level to DDSCL_NORMAL');
     DD.SetCooperativeLevel(Handle, DDSCL_NORMAL);
  End;

End;

Procedure ShutDown_GDI;
Var
  DevMode: _DeviceModeW;
Begin

  // Restore the desktop.

  If Debugging Then Log('Shutting down GDI');

  If Debugging Then Log('Freeing Scanlines DIB');
  If ScanlinesDIB <> nil Then ScanlinesDIB.Free;
  If DDScreen Then Begin
     If Debugging Then Log('Change display settings to desktop');
     FillChar(DevMode, SizeOf(_DeviceModeW), 0);
     Windows.ChangeDisplaySettings(DevMode, 0);
  End;
  If Rendering_API = rmPreview Then Begin
     If Debugging Then Log('Freeing Preview DIBs');
     DepthDIB.Free;
     PreviewDIB.Free;
  End;

End;

Procedure RenderFrame(DIB: TFastDIB);
Begin

  // If we're not in rmPreview mode, then launch a thread that renders the display
  // in idle time. If we are in rmPreview, then just draw the bugger.

  RenderDIB := DIB;

  If Rendering_API <> rmPreview Then Begin

     // Set the blocking flag - only run it when it's set false. This way it can take as
     // long as it likes.

     Rendering := True;

  End Else

     DoRender(DIB);

End;

Procedure DoRender(DIB: TFastDIB);
Var
  DXError:    HResult;
  Rct:        TRect;
  Dst, Src:   Pointer;
  Y: Integer;
  hWnd:       hDc;
Begin

  // Perform the render of the graphics.

  Case Rendering_API of

     rmDirect3D:
        Begin

           // Direct3D rendering - the only mode recommended by the author. This does *everything* in hardware
           // Alpha-blended scanlines, anti-aliased corners and bilinear filtering reduction.

           DXError := sOriginal.Lock(nil, sDescO, DDLOCK_SURFACEMEMORYPTR or DDLOCK_WRITEONLY, 0);

           If DXError = DD_OK Then Begin

              // Convert the graphics from 8bit to our selected colour depth.

              Case Screen_Bpp of

                  8:  ColourDump8Bit(DIB.Bits, sDescO.lpSurface, sDescO.lPitch);
                 16: ColourDump16Bit(DIB.Bits, sDescO.lpSurface, sDescO.lPitch);
                 24: ColourDump24Bit(DIB.Bits, sDescO.lpSurface, sDescO.lPitch);
                 32: ColourDump32Bit(DIB.Bits, sDescO.lpSurface, sDescO.lPitch);

              End;

              sOriginal.Unlock(nil);

              If DXError = DD_OK Then Begin

                 D3DDevice.BeginScene;

                    If DIB.Width < ScaleDIB.Width Then Begin

                       // Render to a texture - the superscale size one. Don't use any filtering,
                       // so we get nice square, sharp pixels.

                       D3DDevice.SetRenderTarget(sTexture, 0);
                       D3DViewport.dwWidth := Surface_Width;
                       D3DViewport.dwHeight := Surface_Height;
                       D3DDevice.SetViewPort(D3DViewPort);

                       D3DDevice.SetTextureStageState(0, D3DTSS_MAGFILTER, DWord(D3DTFG_POINT));
                       D3DDevice.SetTextureStageState(0, D3DTSS_MINFILTER, DWord(D3DTFG_POINT));
                       D3DDevice.SetTexture(0, sOriginal);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DScalePoly[0], 4, 0);

                    End;

                    // Now render to the proper backbuffer, which will (because of the larger texture used earlier)
                    // use only minimal bilinear filtering.

                    D3DDevice.SetRenderTarget(sRender, 0);
                    D3DViewport.dwWidth := Screen_Width;
                    D3DViewport.dwHeight := Screen_Height;
                    D3DDevice.SetViewPort(D3DViewPort);

                    D3DDevice.SetTextureStageState(0, D3DTSS_MAGFILTER, DWord(D3DTFG_LINEAR));
                    D3DDevice.SetTextureStageState(0, D3DTSS_MINFILTER, DWord(D3DTFG_LINEAR));

                    If DIB.Width < ScaleDIB.Width Then
                       D3DDevice.SetTexture(0, sTexture)
                    Else
                       D3DDevice.SetTexture(0, sOriginal);

                    D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DDisplayPoly[0], 4, 0);
                    D3DDevice.SetTexture(0, nil);

                    // Apply the scanlines - alpha blended across the screen in strips.

                    If Enable_Scanlines Then Begin

                       D3DDevice.SetTextureStageState(0, D3DTSS_MAGFILTER, DWord(D3DTFG_POINT));
                       D3DDevice.SetTextureStageState(0, D3DTSS_MINFILTER, DWord(D3DTFG_POINT));
                       D3DDevice.SetTexture(0, sScan);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DScanlinesPoly[0], 4, 0);
                       D3DDevice.SetTexture(0, nil);

                    End;

                    // And draw the corners (alpha blended for a nice antialiasing effect).

                    If Enable_Corners Then Begin

                       D3DDevice.SetTexture(0, sCorner);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DCornerTL[0], 4, 0);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DCornerTR[0], 4, 0);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DCornerBL[0], 4, 0);
                       D3DDevice.DrawPrimitive(D3DPT_TRIANGLESTRIP, D3DFVF_TLVERTEX, D3DCornerBR[0], 4, 0);
                       D3DDevice.SetTexture(0, nil);

                    End;

                 D3DDevice.EndScene;

                 sPrimary.Blt(nil, sRender, nil, DDBLT_DONOTWAIT, nil);

              End;

           End;

        End;

     rmDirectDraw:
        Begin

           // Not a recommended mode unless you absolutely cannot use the Direct3D option. This
           // does scaling in hardware, but that's about all. The alpha-blended scanlines and display corners
           // are all done in software, as is the bilinear filtering reduction.

           // Slow.

           Rct := Rect(0, 0, ScaleDIB.Width, ScaleDIB.Height);

           DXError := sRender.Lock(@Rct, sDescR, DDLOCK_SURFACEMEMORYPTR, 0);
           If DXError = DDERR_SURFACELOST Then Begin

              sRender._Restore;
              DXError := sRender.Lock(@Rct, sDescR, DDLOCK_SURFACEMEMORYPTR, 0);

           End;

           If DXError = DD_OK Then Begin

              If (ScaleDIB.Width = Original_Width) and (ScaleDIB.Height = Original_Height) Then Begin

                 // If we're not superscaling, then use our own nice, fast depth conversion
                 // routine...

                 Case Screen_Bpp of

                     8:  ColourDump8Bit(DIB.Bits, sDescR.lpSurface, sDescR.lPitch);
                    16: ColourDump16Bit(DIB.Bits, sDescR.lpSurface, sDescR.lPitch);
                    24: ColourDump24Bit(DIB.Bits, sDescR.lpSurface, sDescR.lPitch);
                    32: ColourDump32Bit(DIB.Bits, sDescR.lpSurface, sDescR.lPitch);

                 End;

              End Else Begin

                 // ...Otherwise scale up using GDI. We can't use DDraw to do it, as it will
                 // always filter if we use hardware assistance, and we want to avoid filtering at this
                 // stage. This also performs a depth conversion...

                 If DDraw_16bppDIB <> nil Then Begin
                    // ... which is very broken in all versions of windows for converting between a
                    // GDI surface depth and DDraw depth, for 16bpp. Hence, my own solution here:
                    ColourDump16Bit(DIB.Bits, DDraw_16bppDIB.Bits, DDraw_16bppDIB.BWidth);
                    DDraw_16bppDIB.Stretch(ScaleDIB.hDc, 0, 0, ScaleDIB.Width, ScaleDIB.Height);
                 End Else
                    // ... But other depths (8, 24, 32bpp) are fine.
                    DIB.Stretch(ScaleDIB.hDc, 0, 0, ScaleDIB.Width, ScaleDIB.Height);

                 // Now copy the image data over to the DDraw surface.

                 Dst := sDescR.lpSurface;
                 Src := ScaleDIB.Bits;

                 For Y := 0 To ScaleDIB.AbsHeight -1 Do Begin
                    CopyMemory(Dst, Src, ScaleDIB.Width * (ScaleDIB.Bpp Shr 3));
                    Inc(DWord(Dst), sDescR.lPitch);
                    Inc(DWord(Src), ScaleDIB.BWidth);
                 End;

              End;

              DXError := sRender.Unlock(Nil);

              If DXError = DD_OK Then Begin

                 // Now stretch the finished image to the backbuffer.

                 sBackBuffer.Blt(@dRct, sRender, @sRct, DDBLT_DONOTWAIT, nil);

                 If Enable_Scanlines Then Begin

                    If Scanline_Scale < 255 Then Begin
                       sTemp.Blt(nil, sBackBuffer, nil, DDBLT_DONOTWAIT, nil);
                       Rct := Rect(0, 0, Screen_Width, Screen_Height);
                       sTemp.Lock(Nil, sDescT, DDLOCK_SURFACEMEMORYPTR or DDLOCK_NOSYSLOCK or DDLOCK_READONLY, 0);
                       DXError := sBackBuffer.Lock(Nil, sDescB, DDLOCK_SURFACEMEMORYPTR or DDLOCK_NOSYSLOCK or DDLOCK_WRITEONLY, 0);
                       If DXError = DD_OK Then Begin
                          ApplyScanlines(sDescT.lpSurface, sDescB.lpSurface, sDescT.dwHeight, sDescT.lPitch);
                          sBackBuffer.Unlock(Nil);
                          sTemp.Unlock(Nil);
                       End;
                    End Else Begin
                       FillChar(sDescB, SizeOf(TDDSurfaceDesc2), 0);
                       sDescB.dwSize := SizeOf(TDDSurfaceDesc2);
                       DXError := sBackBuffer.Lock(Nil, sDescB, DDLOCK_SURFACEMEMORYPTR or DDLOCK_NOSYSLOCK, 0);
                       If DXError = DD_OK Then Begin
                          ApplyScanlines(sDescB.lpSurface, sDescB.lpSurface, sDescB.dwHeight, sDescB.lPitch);
                          sBackBuffer.Unlock(Nil)
                       End;
                    End;

                 End;

                 If Enable_Corners Then Begin
                    sBackBuffer.GetDC(hWnd);
                    CornerDIBs[0].TransDraw(hWnd, GDI_OffX, GDI_OffY, TfWhite);
                    CornerDIBs[1].TransDraw(hWnd, GDI_TriW - CornerSize, GDI_OffY, TfWhite);
                    CornerDIBs[2].TransDraw(hWnd, GDI_OffX, GDI_TriH - CornerSize, TfWhite);
                    CornerDIBs[3].TransDraw(hWnd, GDI_TriW - CornerSize, GDI_TriH - CornerSize, TfWhite);
                    sBackBuffer.ReleaseDC(hWnd);
                 End;

                 sPrimary.Flip(nil, 0);

              End;

           End;

        End;

     rmGDI, rmPreview:
        Begin

           // Not recommended at all, this mode, as everything is done in software. It's really only
           // useful for debugging. However, with effects turned on, it can be faster than
           // DDraw mode! Also there is no scaling filtering at all in GDI Mode, and it looks
           // ugly.

           Flop(DIB);

           If Rendering_API = rmPreview Then Begin
              DIB.Draw(DepthDIB.hDc, 0, 0);
              Bilinear(DepthDIB, PreviewDIB);
              PreviewDIB.Draw(GDI_Display.Bmp.hDc, Aspect_OffX, Aspect_OffY);
           End Else
              DIB.Stretch(GDI_Display.Bmp.hDc, Aspect_OffX, Aspect_OffY, Aspect_Width, Aspect_Height);

           If Enable_Corners Then Begin
              CornerDIBs[0].TransDraw(GDI_Display.Bmp.hDc, GDI_OffX, GDI_OffY, TfWhite);
              CornerDIBs[1].TransDraw(GDI_Display.Bmp.hDc, GDI_TriW - CornerSize, GDI_OffY, TfWhite);
              CornerDIBs[2].TransDraw(GDI_Display.Bmp.hDc, GDI_OffX, GDI_TriH - CornerSize, TfWhite);
              CornerDIBs[3].TransDraw(GDI_Display.Bmp.hDc, GDI_TriW - CornerSize, GDI_TriH - CornerSize, TfWhite);
           End;

           If Enable_Scanlines Then
              Case GDI_Display.Bmp.Bpp Of
                 8:          ApplyScanlines8(GDI_Display.Bmp.Bits, GDI_Display.Bmp.Bits, GDI_Display.Bmp.AbsHeight, GDI_Display.Bmp.BWidth);
                 16, 24, 32: ApplyScanlines(GDI_Display.Bmp.Bits, GDI_Display.Bmp.Bits, GDI_Display.Bmp.AbsHeight, GDI_Display.Bmp.BWidth);
              End;

           GDI_Display.Repaint;

        End;

  End;

End;

// The colourdump routines are specifically tailored for
// performing depth conversions from one 8bpp surface to
// another of the same size but different bitdepth.

Procedure ColourDump8bit(Src, Dest: Pointer; Pitch: DWord);
Var
  lpDest, lpSrc:  Pointer;
  lPitch:  DWord;
Begin
  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;
  asm
        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]

        push  Original_Height

@loop1: push  esi
        push  edi

@loop2: mov   ecx, Original_Width
        shr   ecx, 2

        rep   movsd

        pop   edi
        pop   esi

        inc   edx
        add   esi, Original_Width
        add   edi, [lPitch]
        dec   dword [esp]
        jnz   @loop1
        add   esp, 4

        popad

  end;

End;

Procedure ColourDump16bit(Src, Dest: Pointer; Pitch: DWord);
Var
  lpDest, lpSrc:  Pointer;
  lPitch:  DWord;
Begin
  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;

     asm
        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]

        push  Original_Height

@loop1: push  edi
        push  esi

        mov   ecx, Original_Width
        shr   ecx, 2
        push  ecx

@loop2: mov   ebx, [esi]
        add   esi, 4

        movzx eax, bh
        mov   ecx, dword [ColourTable+eax*4]
        movzx eax, bl
        shl   ecx, 16

        shr   ebx, 16
        mov   cx, word [ColourTable+eax*4]
        movzx eax, bh
        mov   [edi], ecx

        mov   ecx, dword [ColourTable+eax*4]
        movzx eax, bl
        shl   ecx, 16

        mov   cx, word [ColourTable+eax*4]
        mov   [edi+4], ecx
        add   edi, 8

        dec   dword [esp]
        jnz   @loop2
        add   esp, 4

        pop   esi
        pop   edi

        inc   edx
        add   esi, Original_Width
        add   edi, [lPitch]

        dec   dword [esp]
        jnz   @loop1
        add   esp, 4

        popad

     end;

End;

Procedure ColourDump24bit(Src, Dest: Pointer; Pitch: DWord);
Var
  lpDest, lpSrc:  Pointer;
  lPitch:  DWord;
Begin
  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;

  asm
        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]

        push  Original_Height

@loop1: push  edi
        push  esi

        mov   ecx, Original_Width
        shr   ecx, 2
        push  ecx

@loop2: mov   ebx, [esi]
        add   esi, 4

        movzx eax, bl
        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        mov   [edi], ecx

        movzx eax, bl
        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        mov   [edi+3], ecx

        movzx eax, bl
        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        mov   [edi+6], ecx

        movzx eax, bl
        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        mov   [edi+9], ecx

        add   edi, 12
        dec   dword [esp]
        jnz   @loop2
        add   esp, 4

        pop   esi
        pop   edi

        inc   edx
        add   esi, Original_Width
        add   edi, [lPitch]

        dec   dword [esp]
        jnz   @loop1
        add   esp, 4

        popad

  end;

End;

Procedure ColourDump32bit(Src, Dest: Pointer; Pitch: DWord);
Var
  lpDest, lpSrc:  Pointer;
  lPitch:  DWord;
Begin
  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;

  asm
        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]

        push  Original_Height

@loop1: push  edi
        push  esi
        mov   ecx, Original_Width
        shr   ecx, 2
        push  ecx

@loop2: mov   ebx, [esi]
        add   esi, 4

        movzx eax, bl
        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        movzx eax, bl
        mov   [edi], ecx

        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        movzx eax, bl
        mov   [edi+4], ecx

        shr   ebx, 8
        mov   ecx, dword [ColourTable+eax*4]
        movzx eax, bl
        mov   [edi+8], ecx

        mov   ecx, dword [ColourTable+eax*4]
        dec   dword [esp]
        mov   [edi+12], ecx

        lea   edi, [edi+16]
        jnz   @loop2
        add   esp, 4

        pop   esi
        pop   edi

        inc   edx
        add   esi, Original_Width
        add   edi, [lPitch]
        dec   dword [esp]
        jnz   @loop1
        add   esp, 4

        popad

  end;

End;

Procedure MakeScanlinesLUTs(SrcDIB: TFastDIB; Intensity: Byte);
Var
  Idx, i: Integer;
  Clr: TFColorA;
Begin

  For Idx := 0 To 127 Do Begin
     Clr := SrcDIB.Colors[Idx];
     Clr.r := Word(Clr.r * (255 - Intensity)) Shr 8;
     Clr.g := Word(Clr.g * (255 - Intensity)) Shr 8;
     Clr.b := Word(Clr.b * (255 - Intensity)) Shr 8;
     SrcDIB.Colors[Idx +128] := Clr;
  End;
  SrcDIB.UpdateColors;

  i := 255 - Intensity;
  SetLength(ScanlinesLUT, 65536);
  For Idx := 0 To 65535 Do Begin
     If Screen_Bpp in [24, 32] Then
        ScanlinesLUT[Idx] := (Word((Idx And 255) * i) Shr 8) + ((Word((Idx Shr 8) * i) Shr 8) Shl 8)
     Else
        If Screen_Bpp = 16 Then
           If Green_Mask Shr 5 = $31 Then
              ScanlinesLUT[Idx] := (((Idx And 31) * i) Shr 8) +
                                   (((((Idx Shr 5) And 31) * i) Shr 8) Shl 5) +
                                   (((((Idx Shr 10) And 31) * i) Shr 8) Shl 10)
           Else
              ScanlinesLUT[Idx] := (((Idx And 31) * i) Shr 8) +
                                   (((((Idx Shr 5) And 63) * i) Shr 8) Shl 5) +
                                   (((((Idx Shr 11) And 31) * i) Shr 8) Shl 11);
  End;

End;

Procedure ApplyScanlines8(Src, Dest: Pointer; Height, Pitch: DWord);
Var
  lpSrc, lpDest:  Pointer;
  lPitch, lHeight:  DWord;
Begin

  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;
  lHeight := Height;

  asm
        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]

        mov   edx, lHeight
        shr   edx, 1
        Push  edx

        mov   edx, lPitch
        xor   eax, eax
        Shr   edx, 2

  @Loop:

        mov   ebx, [esi]

        or    ebx, $80808080

        mov   [edi], ebx
        add   esi, 4
        add   edi, 4

        Dec   edx
        jnz   @Loop

        mov   edx, lpitch
        Add   esi, edx
        shr   edx, 2

        dec   dword [esp]
        jnz   @loop

        add   esp, 4

        popad

  end;

End;

Procedure ApplyScanlines(Src, Dest: Pointer; Height, Pitch: DWord);
Var
  lpSrc, lpDest:  Pointer;
  lPitch, lHeight:  DWord;
Begin

  lpSrc := Src;
  lpDest := Dest;
  lPitch := Pitch;
  lHeight := Height;

  If Scanline_Scale = 255 Then Begin
     Asm

        Pushad
        mov   edi, [lpDest]
        mov   esi, [lpSrc]

        mov   edx, lHeight
        shr   edx, 1
        Push  edx

        mov   edx, lPitch
        xor   eax, eax
        Shr   edx, 2

  @Loop:

        mov   [edi], eax
        add   edi, 4

        Dec   edx
        jnz   @Loop

        mov   edx, lpitch
        Add   edi, edx
        shr   edx, 2

        dec   dword [esp]
        jnz   @loop

        add   esp, 4

        popad

     End

  End Else Begin

     asm

        pushad

        mov   esi, [lpSrc]
        mov   edi, [lpDest]
        mov   ecx, ScanlinesLUT

        mov   edx, lHeight
        shr   edx, 1
        Push  edx

        mov   edx, lPitch
        xor   eax, eax
        Shr   edx, 2

  @Loop:

        mov   ebx, [esi]

        mov   ax, bx
        mov   bx, [ecx + eax * 2]
        ror   ebx, 16

        mov   ax, bx
        mov   bx, [ecx + eax * 2]
        ror   ebx, 16

        mov   [edi], ebx
        add   esi, 4
        add   edi, 4

        Dec   edx
        jnz   @Loop

        mov   edx, lpitch
        Add   esi, edx
        Add   edi, edx
        shr   edx, 2

        dec   dword [esp]
        jnz   @loop

        add   esp, 4

        popad

     end;

  End;

End;

end.
