object Display_Form: TDisplay_Form
  Left = 107
  Top = 53
  BorderStyle = bsNone
  Caption = 'Display_Form'
  ClientHeight = 296
  ClientWidth = 352
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FastIMG1: TFastIMG
    Left = 0
    Top = 0
    Width = 352
    Height = 296
    Transparent = False
    Picture = '(None)'
    AutoSize = False
    SizeMode = smGDI
    DrawStyle = dsDraw
    DIBLeft = 0
    DIBTop = 0
    Align = alClient
    OnMouseDown = FormMouseDown
    OnMouseMove = FormMouseMove
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 15
    OnTimer = Timer1Timer
    Left = 36
    Top = 4
  end
end
