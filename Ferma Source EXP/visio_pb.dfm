object vpb: Tvpb
  Left = 595
  Top = 330
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1054#1073#1097#1080#1081' '#1072#1083#1075#1086#1088#1080#1090#1084' '#1089#1074#1077#1076#1077#1085#1080#1103
  ClientHeight = 342
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    256
    342)
  PixelsPerInch = 120
  TextHeight = 16
  object Bevel2: TBevel
    Left = 0
    Top = 64
    Width = 255
    Height = 3
    Anchors = [akLeft, akTop, akRight]
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 256
    Height = 342
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 6
    object GroupBox1: TGroupBox
      Left = 16
      Top = 8
      Width = 225
      Height = 153
      Caption = #1050#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1099' '#1089#1074#1077#1076#1077#1085#1080#1103': '
      TabOrder = 2
      object StaticText10: TStaticText
        Left = 63
        Top = 88
        Width = 98
        Height = 20
        Caption = #1091#1079#1083#1086#1074#1086#1081' Ks3 = '
        TabOrder = 0
      end
    end
    object StaticText2: TStaticText
      Left = 40
      Top = 40
      Width = 134
      Height = 20
      Caption = #1082#1086#1086#1088#1076#1080#1085#1072#1090#1085#1099#1081' Ks1 ='
      TabOrder = 0
    end
    object StaticText6: TStaticText
      Left = 81
      Top = 68
      Width = 93
      Height = 20
      Caption = #1091#1075#1083#1086#1074#1086#1081' Ks2 ='
      TabOrder = 1
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 176
      Width = 225
      Height = 105
      Caption = #1055#1086#1088#1103#1076#1086#1082' '#1089#1074#1077#1076#1077#1085#1080#1103
      TabOrder = 3
      object StaticText1: TStaticText
        Left = 40
        Top = 27
        Width = 99
        Height = 20
        Caption = #1050#1086#1086#1088#1076#1080#1085#1072#1090#1085#1086#1077
        TabOrder = 0
      end
      object StaticText9: TStaticText
        Left = 148
        Top = 10
        Width = 61
        Height = 20
        Caption = '1      2      3'
        TabOrder = 1
      end
      object StaticText12: TStaticText
        Left = 79
        Top = 76
        Width = 61
        Height = 20
        Caption = #1059#1079#1083#1086#1074#1086#1077
        TabOrder = 2
      end
      object cb11: TCheckBox
        Left = 144
        Top = 28
        Width = 17
        Height = 17
        TabOrder = 3
        OnClick = cb11Click
      end
      object cb31: TCheckBox
        Left = 144
        Top = 76
        Width = 17
        Height = 17
        Caption = 'cb31'
        TabOrder = 9
        OnClick = cb31Click
      end
      object cb21: TCheckBox
        Left = 144
        Top = 52
        Width = 17
        Height = 17
        Caption = 'cb21'
        TabOrder = 6
        OnClick = cb21Click
      end
      object cb22: TCheckBox
        Left = 168
        Top = 52
        Width = 17
        Height = 17
        Caption = 'cb22'
        TabOrder = 7
        OnClick = cb22Click
      end
      object cb33: TCheckBox
        Left = 192
        Top = 76
        Width = 17
        Height = 17
        Caption = 'cb33'
        TabOrder = 11
        OnClick = cb33Click
      end
      object cb23: TCheckBox
        Left = 192
        Top = 52
        Width = 17
        Height = 17
        Caption = 'cb23'
        TabOrder = 8
        OnClick = cb23Click
      end
      object cb32: TCheckBox
        Left = 168
        Top = 76
        Width = 17
        Height = 17
        Caption = 'cb32'
        TabOrder = 10
        OnClick = cb32Click
      end
      object cb12: TCheckBox
        Left = 168
        Top = 28
        Width = 17
        Height = 17
        Caption = 'cb12'
        TabOrder = 4
        OnClick = cb12Click
      end
      object cb13: TCheckBox
        Left = 192
        Top = 28
        Width = 17
        Height = 17
        Caption = 'cb13'
        TabOrder = 5
        OnClick = cb13Click
      end
    end
    object StaticText8: TStaticText
      Left = 96
      Top = 227
      Width = 59
      Height = 20
      Caption = #1059#1075#1083#1086#1074#1086#1077
      TabOrder = 4
    end
  end
  object ProgressBar1: TProgressBar
    Left = 16
    Top = 304
    Width = 185
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 0
    Visible = False
  end
  object Edit1: TEdit
    Left = 176
    Top = 36
    Width = 30
    Height = 24
    TabOrder = 1
    Text = '23'
    OnChange = Edit1Change
  end
  object StaticText3: TStaticText
    Left = 208
    Top = 38
    Width = 16
    Height = 20
    Caption = '%'
    TabOrder = 4
  end
  object Ok: TBitBtn
    Left = 100
    Top = 300
    Width = 70
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 11
    OnClick = OkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object StaticText4: TStaticText
    Left = 212
    Top = 304
    Width = 4
    Height = 4
    TabOrder = 7
  end
  object StaticText5: TStaticText
    Left = 46
    Top = 123
    Width = 130
    Height = 20
    Caption = #1050#1086#1083'-'#1074#1086' '#1080#1090#1077#1088#1072#1094#1080#1081' i ='
    TabOrder = 8
  end
  object Edit2: TEdit
    Left = 176
    Top = 120
    Width = 22
    Height = 24
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 5
    Text = '2'
    OnChange = Edit2Change
  end
  object StaticText7: TStaticText
    Left = 208
    Top = 68
    Width = 16
    Height = 20
    Caption = '%'
    TabOrder = 9
  end
  object Edit3: TEdit
    Left = 176
    Top = 64
    Width = 30
    Height = 24
    TabOrder = 2
    Text = '23'
    OnChange = Edit3Change
  end
  object StaticText11: TStaticText
    Left = 208
    Top = 96
    Width = 16
    Height = 20
    Caption = '%'
    TabOrder = 10
  end
  object Edit4: TEdit
    Left = 176
    Top = 92
    Width = 30
    Height = 24
    TabOrder = 3
    Text = '23'
    OnChange = Edit4Change
  end
end
