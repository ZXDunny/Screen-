object ConfigForm: TConfigForm
  Left = 220
  Top = 150
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Configure SCREEN$'
  ClientHeight = 452
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    373
    452)
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 12
    Top = 12
    Width = 349
    Height = 392
    ActivePage = TabSheet1
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Hardware'
      ImageIndex = 3
      DesignSize = (
        341
        364)
      object lblSpectrum: TLabel
        Left = 8
        Top = 12
        Width = 92
        Height = 13
        Caption = 'Spectrum Model'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object imv48K: TSpinImageView
        Tag = 1
        Left = 68
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum 48K, Sinclair 1982'
        ImageIndex = 0
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object imv128K: TSpinImageView
        Tag = 2
        Left = 124
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum 128K, Sinclair 1986'
        ImageIndex = 1
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object imvPlus2: TSpinImageView
        Tag = 3
        Left = 180
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum +2. Amstrad 1986'
        ImageIndex = 2
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object imvPlus2A: TSpinImageView
        Tag = 4
        Left = 236
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum +2A, Amstrad 1987'
        ImageIndex = 3
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object imvPlus3: TSpinImageView
        Tag = 5
        Left = 292
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum +3, Amstrad 1987'
        ImageIndex = 4
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object imv16K: TSpinImageView
        Left = 12
        Top = 68
        Width = 32
        Height = 32
        Hint = 'Spectrum 48K, Sinclair 1982'
        ImageIndex = 0
        ImageList = imlIcons
        Transparent = True
        OnClick = imv16KClick
      end
      object bvlSpectrum: TBevel
        Left = 8
        Top = 28
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblResetType2: TLabel
        Left = 116
        Top = 201
        Width = 37
        Height = 13
        Caption = 'screens'
      end
      object lblResetType1: TLabel
        Left = 28
        Top = 201
        Width = 28
        Height = 13
        Caption = 'After '
      end
      object lblResetType: TLabel
        Left = 12
        Top = 157
        Width = 61
        Height = 13
        Caption = 'Reset mode:'
      end
      object lblResetting: TLabel
        Left = 8
        Top = 128
        Width = 79
        Height = 13
        Caption = 'Reset Options'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Bevel1: TBevel
        Left = 8
        Top = 144
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object Bevel4: TBevel
        Left = 8
        Top = 276
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object Label3: TLabel
        Left = 8
        Top = 260
        Width = 74
        Height = 13
        Caption = 'Tape Options'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object rad48K: TRadioButton
        Left = 68
        Top = 96
        Width = 41
        Height = 17
        Caption = '&48K'
        TabOrder = 0
        OnClick = chkRandomHWClick
      end
      object rad128K: TRadioButton
        Left = 124
        Top = 96
        Width = 49
        Height = 17
        Caption = '&128K'
        TabOrder = 1
        OnClick = chkRandomHWClick
      end
      object radPlus2: TRadioButton
        Left = 180
        Top = 96
        Width = 33
        Height = 17
        Caption = '+&2'
        TabOrder = 2
        OnClick = chkRandomHWClick
      end
      object radPlus2A: TRadioButton
        Left = 236
        Top = 96
        Width = 49
        Height = 17
        Caption = '+2A'
        TabOrder = 3
        OnClick = chkRandomHWClick
      end
      object radPlus3: TRadioButton
        Left = 292
        Top = 96
        Width = 41
        Height = 17
        Caption = '+&3'
        TabOrder = 4
        OnClick = chkRandomHWClick
      end
      object rad16K: TRadioButton
        Left = 12
        Top = 96
        Width = 41
        Height = 17
        Caption = '16K'
        Checked = True
        TabOrder = 5
        TabStop = True
        OnClick = chkRandomHWClick
      end
      object chkRandReset: TCheckBox
        Left = 12
        Top = 228
        Width = 189
        Height = 17
        Caption = ' Randomise hardware after Reset '
        TabOrder = 6
      end
      object edtResetType: TEdit
        Left = 61
        Top = 198
        Width = 32
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 7
        Text = '1'
      end
      object udResetType: TUpDown
        Left = 93
        Top = 198
        Width = 16
        Height = 21
        Associate = edtResetType
        Min = 1
        Max = 9999
        Position = 1
        TabOrder = 8
        Thousands = False
      end
      object cmbResetType: TComboBox
        Left = 12
        Top = 173
        Width = 249
        Height = 21
        Style = csDropDownList
        TabOrder = 9
        OnChange = chkRandomHWClick
        Items.Strings = (
          'Never'
          'At random'
          'After x screens')
      end
      object chkRandomHW: TCheckBox
        Left = 12
        Top = 40
        Width = 173
        Height = 17
        Caption = ' Random hardware at startup  '
        TabOrder = 10
        OnClick = chkRandomHWClick
      end
      object chkTapeWobble: TCheckBox
        Left = 12
        Top = 292
        Width = 133
        Height = 17
        Caption = ' Wobbly old tape deck '
        TabOrder = 11
      end
      object chkTapeHiss: TCheckBox
        Left = 12
        Top = 312
        Width = 97
        Height = 17
        Caption = ' Old tape hiss '
        TabOrder = 12
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Automation'
      ImageIndex = 4
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        341
        364)
      object lblAutomation: TLabel
        Left = 8
        Top = 12
        Width = 67
        Height = 13
        Caption = 'Automation'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lblScreensaverType: TLabel
        Left = 12
        Top = 44
        Width = 89
        Height = 13
        Caption = 'Screensaver type:'
      end
      object lblAfterBASIC1: TLabel
        Left = 36
        Top = 193
        Width = 28
        Height = 13
        Caption = 'After '
      end
      object lblAfterBASIC2: TLabel
        Left = 116
        Top = 193
        Width = 37
        Height = 13
        Caption = 'screens'
      end
      object bvlAutomation: TBevel
        Left = 8
        Top = 28
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lbl48kMode: TLabel
        Left = 12
        Top = 92
        Width = 123
        Height = 13
        Caption = '48k Mode in 128k models:'
      end
      object lblPause2: TLabel
        Left = 136
        Top = 224
        Width = 121
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblPause: TLabel
        Left = 12
        Top = 224
        Width = 117
        Height = 13
        Caption = 'Pause after each screen'
      end
      object cmbScreenSaverType: TComboBox
        Left = 12
        Top = 60
        Width = 249
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = chkRandomHWClick
        Items.Strings = (
          'Constant LOADing'
          'Program'
          'Direct Command')
      end
      object chkBASIC: TCheckBox
        Left = 12
        Top = 168
        Width = 145
        Height = 17
        Caption = ' Return to BASIC '
        TabOrder = 1
        OnClick = chkRandomHWClick
      end
      object chkCLS: TCheckBox
        Left = 12
        Top = 144
        Width = 145
        Height = 17
        Caption = ' CLS Between screens '
        TabOrder = 2
      end
      object edtBASICScreenCount: TEdit
        Left = 65
        Top = 190
        Width = 32
        Height = 21
        BiDiMode = bdLeftToRight
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 3
        Text = '1'
      end
      object udBASICScreenCount: TUpDown
        Left = 97
        Top = 190
        Width = 16
        Height = 21
        Associate = edtBASICScreenCount
        Min = 1
        Max = 9999
        Position = 1
        TabOrder = 4
        Thousands = False
      end
      object cmb48kMode: TComboBox
        Left = 12
        Top = 108
        Width = 249
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        Items.Strings = (
          'Random'
          'No 48k mode'
          'Via menu option'
          'SPECTRUM'
          'USR 0')
      end
      object trkPause: TTrackBar
        Left = 6
        Top = 241
        Width = 256
        Height = 22
        Anchors = [akTop, akRight]
        Max = 240
        PageSize = 1
        Frequency = 8
        TabOrder = 6
        ThumbLength = 11
        TickMarks = tmTopLeft
        OnChange = chkRandomHWClick
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Interaction'
      ImageIndex = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        341
        364)
      object lblUserInteraction: TLabel
        Left = 8
        Top = 12
        Width = 82
        Height = 13
        Caption = 'Mouse options'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object lblMouse: TLabel
        Left = 12
        Top = 44
        Width = 84
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Mouse movement'
      end
      object bvlUserInteraction: TBevel
        Left = 8
        Top = 28
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object Label6: TLabel
        Left = 32
        Top = 132
        Width = 198
        Height = 13
        Caption = '(ESC always terminates the screensaver)'
      end
      object cmbMouse: TComboBox
        Left = 12
        Top = 60
        Width = 249
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        TabOrder = 0
        Items.Strings = (
          'Disrupts chuntey'
          'Quits the screensaver'
          'Does nothing')
      end
      object chkChuntey: TCheckBox
        Left = 12
        Top = 92
        Width = 173
        Height = 17
        Caption = ' Disrupt Chuntey at random '
        TabOrder = 1
        OnClick = chkRandomHWClick
      end
      object chkKeyboard: TCheckBox
        Left = 12
        Top = 112
        Width = 261
        Height = 17
        Caption = ' Keyboard causes D BREAK error and quits '
        TabOrder = 2
        OnClick = chkRandomHWClick
      end
    end
    object tbsOperation: TTabSheet
      Caption = 'Screens'
      DesignSize = (
        341
        364)
      object Label1: TLabel
        Left = 8
        Top = 8
        Width = 75
        Height = 13
        Caption = 'Screen folder'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object btnFolderList: TSpeedButton
        Left = 304
        Top = 40
        Width = 21
        Height = 21
        Anchors = [akTop, akRight]
        Glyph.Data = {
          A6020000424DA6020000000000003600000028000000100000000D0000000100
          18000000000070020000130B0000130B00000000000000000000020CCC020CCC
          020CCC0000000000000000000000000000000000000000000000000000000000
          00000000000000000000020CCC020CCC808080A0A0A080808080808080808080
          8080808080808080808080808080808080808080000000000000020CCC020CCC
          B0B0B0CFC8CF00F8FFC0C0C000F8FFC0C0C000F8FFC0C0C000F8FFC0C0C000F8
          FF808080000000000000020CCCA0A0A0DFD8DF00F8FFC0C0C000F8FFC0C0C000
          F8FFC0C0C000F8FFC0C0C000F8FFB0B0B0404040808080000000020CCCA0A0A0
          EFE8EFC0C0C000F8FFC0C0C000F8FFC0C0C000F8FFC0C0C000F8FFC0C0C08080
          80000000808080000000909090EFE8EFC0C0C030E8EFC0C0C030E8EFC0C0C000
          F8FFC0C0C030E8EFC0C0C030C8CF004040808080808080000000A0A0A0DFD8DF
          DFD8DFDFD8DFDFD8DFDFD8DFDFD8DFDFD8DFDFD8DFDFD8DFDFD8DF9090902020
          20A0A0A080808000000080808080808080808080808080808080808080808080
          808080808080808080808080808080808020D8DF808080000000020CCCA0A0A0
          DFD8DFB0B0B000F8FFC0C0C000F8FFC0C0C000F8FFC0C0C000F8FFC0C0C060D8
          DF90C8CF808080000000020CCCA0A0A0DFD8DF00F8FFC0C0C000F8FFC0C0C000
          F8FFC0C0C0DFD8DFFFF8FFFFF8FFFFF8FFFFF8FFA0A0A0000000020CCCA0A0A0
          DFD8DFC0C0C000F8FFC0C0C000F8FFC0C0C0CFC8CFA0A0A0A0A0A0A0A0A0A0A0
          A0A0A0A0808080020CCC020CCC020CCCA0A0A0FFF8FFDFD8DFFFF8FFEFE8EFDF
          D8DF909090020CCC020CCC020CCC020CCC020CCC020CCC020CCC020CCC020CCC
          020CCCA0A0A0A0A0A0A0A0A0A0A0A0909090020CCC020CCC020CCC020CCC020C
          CC020CCC020CCC020CCC}
        Layout = blGlyphRight
        OnClick = btnFolderListClick
      end
      object Bevel2: TBevel
        Left = 8
        Top = 24
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object Label5: TLabel
        Left = 8
        Top = 80
        Width = 89
        Height = 13
        Caption = 'Loading options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel6: TBevel
        Left = 8
        Top = 96
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object edtScreens: TEdit
        Left = 12
        Top = 40
        Width = 286
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        ReadOnly = True
        TabOrder = 0
      end
      object chkOptimise: TCheckBox
        Left = 12
        Top = 112
        Width = 205
        Height = 17
        Caption = ' Optimise data for loading speed '
        TabOrder = 1
      end
      object chkLongFileNames: TCheckBox
        Left = 12
        Top = 136
        Width = 205
        Height = 17
        Caption = ' Allow long filenames '
        TabOrder = 2
      end
    end
    object tbsDisplay: TTabSheet
      Caption = 'Display'
      ImageIndex = 1
      DesignSize = (
        341
        364)
      object lblResolution: TLabel
        Left = 12
        Top = 98
        Width = 86
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Screen Resolution'
        FocusControl = cmbResolution
      end
      object lblRenderer: TLabel
        Left = 8
        Top = 8
        Width = 81
        Height = 13
        Caption = 'Rendering API'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object bvlRenderer: TBevel
        Left = 8
        Top = 24
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblDisplay: TLabel
        Left = 8
        Top = 68
        Width = 129
        Height = 13
        Caption = 'Display Characteristics'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object bvlDisplay: TBevel
        Left = 8
        Top = 84
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblScanlines: TLabel
        Left = 136
        Top = 180
        Width = 121
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '0%'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object SpinImageView1: TSpinImageView
        Left = 8
        Top = 315
        Width = 32
        Height = 32
        Hint = 'Spectrum 48K, Sinclair 1982'
        Anchors = [akLeft, akBottom]
        ImageIndex = 5
        ImageList = imlIcons
        Transparent = True
        OnClick = SpinImageView1Click
      end
      object SpinImageView2: TSpinImageView
        Tag = 1
        Left = 116
        Top = 315
        Width = 32
        Height = 32
        Hint = 'Spectrum 48K, Sinclair 1982'
        Anchors = [akLeft, akBottom]
        ImageIndex = 6
        ImageList = imlIcons
        Transparent = True
        OnClick = SpinImageView1Click
      end
      object SpinImageView3: TSpinImageView
        Tag = 2
        Left = 224
        Top = 315
        Width = 32
        Height = 32
        Hint = 'Spectrum 48K, Sinclair 1982'
        Anchors = [akLeft, akBottom]
        ImageIndex = 7
        ImageList = imlIcons
        Transparent = True
        OnClick = SpinImageView1Click
      end
      object Label2: TLabel
        Left = 8
        Top = 283
        Width = 72
        Height = 13
        Anchors = [akLeft, akBottom]
        Caption = 'Aspect Ratio'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Bevel3: TBevel
        Left = 8
        Top = 299
        Width = 321
        Height = 3
        Anchors = [akLeft, akBottom]
      end
      object lblBorder: TLabel
        Left = 12
        Top = 226
        Width = 54
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Border Size'
        FocusControl = cmbBorderSize
      end
      object cmbResolution: TComboBox
        Left = 12
        Top = 115
        Width = 245
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        TabOrder = 0
        OnChange = cmbResolutionChange
        Items.Strings = (
          '640x480'
          '800x600'
          '1024x768'
          '1280x1024')
      end
      object radDirect3D: TRadioButton
        Left = 12
        Top = 36
        Width = 113
        Height = 17
        Caption = ' Direct3D '
        TabOrder = 1
        OnClick = chkRandomHWClick
      end
      object radDirectDraw: TRadioButton
        Left = 104
        Top = 36
        Width = 113
        Height = 17
        Caption = ' DirectDraw '
        TabOrder = 2
        OnClick = chkRandomHWClick
      end
      object radGDI: TRadioButton
        Left = 204
        Top = 36
        Width = 113
        Height = 17
        Caption = ' GDI '
        TabOrder = 3
        OnClick = chkRandomHWClick
      end
      object chkSuperScale: TCheckBox
        Left = 12
        Top = 140
        Width = 217
        Height = 17
        Caption = ' Reduce bilinear filtering artifacts '
        TabOrder = 4
      end
      object chkScanlines: TCheckBox
        Left = 12
        Top = 179
        Width = 177
        Height = 17
        Caption = ' Enable Scanlines '
        TabOrder = 5
        OnClick = chkRandomHWClick
      end
      object trkScanlines: TTrackBar
        Left = 6
        Top = 197
        Width = 256
        Height = 22
        Anchors = [akTop, akRight]
        Max = 255
        PageSize = 1
        Frequency = 8
        TabOrder = 6
        ThumbLength = 11
        TickMarks = tmTopLeft
        OnChange = chkRandomHWClick
      end
      object Panel1: TPanel
        Left = 8
        Top = 339
        Width = 325
        Height = 22
        Anchors = [akLeft, akBottom]
        BevelOuter = bvNone
        TabOrder = 7
        object radStretch: TRadioButton
          Left = 0
          Top = 4
          Width = 61
          Height = 17
          Caption = 'Stretch'
          TabOrder = 0
        end
        object radMaintain: TRadioButton
          Left = 108
          Top = 4
          Width = 105
          Height = 17
          Caption = 'Maintain Aspect'
          TabOrder = 1
        end
        object radCrop: TRadioButton
          Left = 216
          Top = 4
          Width = 113
          Height = 17
          Caption = 'Crop'
          TabOrder = 2
        end
      end
      object chkCorners: TCheckBox
        Left = 12
        Top = 160
        Width = 217
        Height = 17
        Caption = ' Rounded display corners '
        TabOrder = 8
      end
      object cmbBorderSize: TComboBox
        Left = 12
        Top = 243
        Width = 245
        Height = 21
        Style = csDropDownList
        Anchors = [akTop, akRight]
        TabOrder = 9
        OnChange = cmbResolutionChange
        Items.Strings = (
          'None (zx32)'
          'Small (VBSpec)'
          'Partial (4:3 Ratio)'
          'Full (Spectrum)')
      end
    end
    object tbsSound: TTabSheet
      Caption = 'Sound'
      ImageIndex = 2
      DesignSize = (
        341
        364)
      object lblVolume: TLabel
        Left = 136
        Top = 64
        Width = 121
        Height = 13
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = '0%'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 8
        Top = 8
        Width = 80
        Height = 13
        Caption = 'Sound Volume'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
      end
      object Bevel5: TBevel
        Left = 8
        Top = 24
        Width = 321
        Height = 3
        Anchors = [akLeft, akTop, akRight]
      end
      object lblVolume1: TLabel
        Left = 12
        Top = 64
        Width = 34
        Height = 13
        Caption = 'Volume'
      end
      object chkSoundEnable: TCheckBox
        Left = 12
        Top = 39
        Width = 177
        Height = 17
        Caption = ' Enable Sound '
        TabOrder = 0
        OnClick = chkRandomHWClick
      end
      object TrkVolume: TTrackBar
        Left = 6
        Top = 81
        Width = 256
        Height = 22
        Anchors = [akTop, akRight]
        Max = 255
        PageSize = 1
        Frequency = 8
        TabOrder = 1
        ThumbLength = 11
        TickMarks = tmTopLeft
        OnChange = chkRandomHWClick
      end
    end
  end
  object Button1: TButton
    Left = 286
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 200
    Top = 415
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Okay'
    TabOrder = 2
    OnClick = Button2Click
  end
  object FileListBox1: TFileListBox
    Left = 80
    Top = 412
    Width = 109
    Height = 29
    ItemHeight = 13
    Mask = '*.scr'
    TabOrder = 3
    Visible = False
  end
  object imlIcons: TImageList
    BlendColor = clWhite
    BkColor = 13154717
    Height = 32
    Width = 32
    Left = 48
    Top = 412
    Bitmap = {
      494C0101080009001000200020009DB9C800FF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000008000000060000000010020000000000000C0
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D000000000000000000C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D003E3E3E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D007A7A7A000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656005656
      5600565656005656560056565600565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00C8B99D00C8B99D00898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      89008989890089898900C8B99D00C8B99D00C8B99D00C8B99D00898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      89008989890089898900C8B99D00C8B99D00C8B99D00C8B99D00898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      89008989890089898900C8B99D00C8B99D007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E0092DC000092DC000092DC
      000092DC000092DC000092DC00000E0E0E00C8B99D0089898900D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D00C8B99D0089898900D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D00C8B99D0089898900D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E005656560056565600565656000E0E0E0025FFFF0025FFFF0025FF
      FF0025FFFF0025FFFF0025FFFF000E0E0E00FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600898989007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000000FF000000FF000000
      FF000000FF000000FF000000FF000E0E0E00FFFFFF00D6D6D600D6D6D600D6D6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00D6D6D600D6D6D600D6D6D600898989007A7A7A00565656000E0E0E005656
      5600565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E0056565600565656000E0E0E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D600898989007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E00565656000E0E0E000000B9003E3E3E000000
      B9000000B9003E3E3E000000B9000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D600898989007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E003E3E3E000000B9003E3E
      3E000000B9000000B9003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D600898989007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000000B9000000B9000000
      B9000000B9003E3E3E000000B9000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D600898989007A7A7A000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E0056565600565656000E0E0E003E3E3E000000B9003E3E
      3E000000B9000000B9003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D600898989007A7A7A0062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D600898989007A7A7A000000FF000000FF000000
      FF000000FF000000FF000000FF003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D600898989007A7A7A003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D600898989007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A003E3E3E00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF0000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      89000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      FF00FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900000000000000000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF
      0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF000000000000000000000000
      0000FFFFFF00D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D6008989
      8900FFFF0000FFFF0000FFFF0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      0000FFFFFF00D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D600D6D6
      D600898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900898989008989890089898900898989008989890089898900898989008989
      8900D6D6D600D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D60089898900FFFFFF00D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D00C8B99D00FFFFFF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D00C8B99D00FFFFFF00D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6D600D6D6
      D600D6D6D600D6D6D60089898900C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C8B99D00C8B99D00C8B99D00C8B99D00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E00C8B99D00C8B99D00C8B99D00C8B99D003E3E3E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E00929292004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A003E3E3E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E007A7A7A007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E
      3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E
      3E007A7A7A003E3E3E007A7A7A007A7A7A002525FF007A7A7A007A7A7A00FFFF
      00000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      560056565600565656005656560056565600565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C2006E6E6E00929292006E6E
      6E00929292006E6E6E00929292006E6E6E00929292006E6E6E00929292009292
      9200929292009292920092929200929292006E6E6E00929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E0092929200929292009292
      92009292920092929200929292004A4A4A007A7A7A000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656005656
      5600565656005656560056565600565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E009E9E9E009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A
      7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A
      7A009E9E9E007A7A7A009E9E9E009E9E9E007A7A7A009E9E9E009E9E9E007A7A
      7A000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E002525FF0000FF
      FF0092DC00000E0E0E000E0E0E000E0E0E00C2C2C2006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E0092929200565656009292
      92005656560092929200565656004A4A4A007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E007A7A7A000E0E0E007A7A
      7A000E0E0E007A7A7A000E0E0E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A
      7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A
      7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A007A7A7A0025FF
      2500B9B90000C8B99D00C8B99D00C8B99D007A7A7A0056565600565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E005656560056565600565656000E0E0E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C200929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E6E009292
      92006E6E6E009292920092929200929292006E6E6E0056565600929292005656
      56009292920056565600929292004A4A4A007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E005656560056565600565656000E0E0E000E0E0E007A7A7A000E0E
      0E007A7A7A000E0E0E007A7A7A000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E003E3E3E009E9E9E007A7A7A009E9E9E007A7A7A009E9E
      9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E
      9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E009E9E9E007A7A
      7A007AB90000C8B99D00C8B99D00C8B99D007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E00323232003232
      3200323232000E0E0E000E0E0E000E0E0E00C2C2C2006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E0092929200929292009292
      92009292920092929200929292004A4A4A007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E
      3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E
      3E007A7A7A003E3E3E007A7A7A003E3E3E003E3E3E003E3E3E002525FF0048FF
      FF0000B90000C8B99D00C8B99D00C8B99D007A7A7A0056565600565656000E0E
      0E0056565600565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E0056565600565656000E0E0E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C200929292006E6E6E009292
      9200929292006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E
      6E00929292006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E
      6E00929292006E6E6E0092929200929292006E6E6E0092DC000092DC000092DC
      000092DC000092DC000092DC00004A4A4A007A7A7A00565656000E0E0E005656
      5600565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E0056565600565656000E0E0E0092DC000092DC000092DC
      000092DC000092DC000092DC00000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A
      7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A
      7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E003E3E3E003E3E3E002525
      FF0000B9B900C8B99D00C8B99D00C8B99D007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E00565656000E0E0E00323232003232
      3200323232000E0E0E000E0E0E000E0E0E00C2C2C2006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E00929292006E6E6E0000AAFF0000AAFF0000AA
      FF0000AAFF0000AAFF0000AAFF004A4A4A007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E00565656000E0E0E0000AAFF0000AAFF0000AA
      FF0000AAFF0000AAFF0000AAFF000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A
      7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E007A7A
      7A003E3E3E007A7A7A003E3E3E007A7A7A003E3E3E003E3E3E003E3E3E003E3E
      3E0000009600C8B99D00C8B99D00C8B99D007A7A7A0056565600565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C200929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E6E009292
      92006E6E6E00929292006E6E6E00929292006E6E6E0062626200626262006262
      62006262620062626200626262004A4A4A007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E0062626200626262006262
      62006262620062626200626262000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E
      9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A009E9E
      9E007A7A7A009E9E9E007A7A7A009E9E9E007A7A7A003E3E3E003E3E3E003E3E
      3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E00323232003232
      3200323232000E0E0E000E0E0E000E0E0E00C2C2C2006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E
      6E006E6E6E006E6E6E006E6E6E006E6E6E006E6E6E0062626200626262006262
      62006262620062626200626262004A4A4A007A7A7A000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E
      0E000E0E0E000E0E0E000E0E0E000E0E0E000E0E0E0062626200626262006262
      62006262620062626200626262000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E0E005656
      56000E0E0E00565656000E0E0E0056565600565656000E0E0E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C2006E6E6E00929292006E6E
      6E00929292006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E
      6E00929292006E6E6E00929292006E6E6E00929292006E6E6E00929292006E6E
      6E00929292006E6E6E0092929200929292006E6E6E0062626200626262006262
      62006262620062626200626262004A4A4A007A7A7A000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E00565656000E0E0E00565656000E0E0E00565656000E0E
      0E00565656000E0E0E0056565600565656000E0E0E0062626200626262006262
      62006262620062626200626262000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A0062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200323232003232
      3200323232000E0E0E000E0E0E000E0E0E00C2C2C20056565600565656005656
      5600565656005656560056565600565656005656560056565600565656005656
      5600565656005656560056565600565656005656560056565600565656005656
      5600565656005656560056565600565656009292920092929200929292009292
      92009292920092929200929292004A4A4A007A7A7A0062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262006262620062626200626262006262
      6200626262006262620062626200626262003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A000000FF000000FF000000FF000000FF003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A000000FF000000FF000000
      FF000000FF000000FF000000FF003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E00626262006262620062626200C2C2C2000000FF000000FF000000
      FF000000FF000000FF000000FF00929292009292920092929200929292009292
      9200929292009292920092929200929292009292920092929200929292009292
      92009292920092929200929292009292920092929200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200929292004A4A4A007A7A7A000000FF000000FF000000
      FF000000FF000000FF000000FF003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A003E3E3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A
      7A003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E000E0E0E00C8B99D00C8B99D00C8B99D007A7A7A003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E000E0E0E000E0E0E000E0E0E00C2C2C20092929200929292009292
      9200929292009292920092929200929292009292920092929200929292009292
      9200929292009292920092929200929292009292920092929200929292009292
      9200929292009292920092929200929292009292920092929200929292009292
      92009292920092929200929292004A4A4A007A7A7A003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E3E003E3E
      3E003E3E3E003E3E3E003E3E3E000E0E0E00C8B99D00C8B99D00C8B99D00C8B9
      9D007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A00C8B99D00C8B99D00C8B99D00C8B99D007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A00C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2C200C2C2
      C200C2C2C200C2C2C200C2C2C200929292007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A7A007A7A
      7A007A7A7A007A7A7A007A7A7A003E3E3E00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B99D00C8B9
      9D00C8B99D00C8B99D00C8B99D00C8B99D00424D3E000000000000003E000000
      2800000080000000600000000100010000000000000600000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FFFFFFFFFFFFFFFFFFFFFFFF
      00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000C0000003C0000003C0000003
      0000000080000001800000018000000100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF000000000000000000000000
      FFFFFFFF000000000000000000000000FFFFFFFF800000018000000180000001
      FFFFFFFFC0000003C0000003C0000003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      F000000F000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000E0000007000000000000000000000000
      E0000007000000000000000000000000F000000F000000000000000000000000
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object dlgFolderSelect: TFolderBrowser
    BrowseFlags = []
    Title = 'Select .scr screens folder'
    Left = 16
    Top = 408
  end
end
