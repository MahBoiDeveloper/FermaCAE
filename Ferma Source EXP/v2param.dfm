object VC2Form: TVC2Form
  Left = 547
  Top = 122
  Width = 432
  Height = 354
  Caption = #1052#1077#1090#1086#1076' '#1051#1080#1085#1077#1072#1088#1080#1079#1072#1094#1080#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 40
    Width = 98
    Height = 13
    Caption = #1058#1086#1095#1085#1086#1089#1090#1100' '#1056#1077#1096#1077#1085#1080#1103':'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 194
    Height = 13
    Caption = #1052#1072#1082#1089#1080#1084#1072#1083#1100#1085#1086#1077' '#1082#1086#1083#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1090#1077#1088#1072#1094#1080#1081
  end
  object Label3: TLabel
    Left = 8
    Top = 88
    Width = 255
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1087#1086#1089#1086#1073#1072' '#1088#1077#1096#1077#1085#1080#1103' '#1083#1080#1085#1077#1081#1085#1099#1093' '#1079#1072#1076#1072#1095' (1 '#1080#1083#1080' 2)'
  end
  object Label4: TLabel
    Left = 8
    Top = 112
    Width = 204
    Height = 13
    Caption = #1042#1077#1089' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081' '#1074' '#1091#1089#1083#1086#1074#1080#1080' '#1086#1089#1090#1072#1085#1086#1074#1072' >0'
  end
  object Label5: TLabel
    Left = 8
    Top = 168
    Width = 225
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1103' '#1082#1086#1101#1092#1092#1080#1094#1080#1077#1085#1090#1072' '#1096#1090#1088#1072#1092#1072
  end
  object Label6: TLabel
    Left = 8
    Top = 144
    Width = 117
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1081' '#1096#1072#1075' '#1089#1087#1091#1089#1082#1072
  end
  object Label7: TLabel
    Left = 8
    Top = 192
    Width = 176
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1076#1086#1087#1091#1089#1090#1080#1084#1086#1075#1086' '
  end
  object Label8: TLabel
    Left = 8
    Top = 240
    Width = 190
    Height = 13
    Caption = #1064#1072#1075' '#1095#1080#1089#1083#1077#1085#1085#1086#1075#1086' '#1076#1080#1092#1092#1077#1088#1077#1085#1094#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Label9: TLabel
    Left = 8
    Top = 264
    Width = 240
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1089#1093#1077#1084#1099' '#1095#1080#1089#1083#1077#1085#1085#1086#1075#1086' '#1076#1080#1092#1092#1077#1088#1077#1085#1094#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Label10: TLabel
    Left = 120
    Top = 216
    Width = 122
    Height = 13
    Caption = #1085#1072#1088#1091#1096#1077#1085#1080#1103' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1081
  end
  object Label11: TLabel
    Left = 8
    Top = 16
    Width = 171
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093
  end
  object par1: TEdit
    Left = 272
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '0.1e-7'
  end
  object par2: TEdit
    Left = 272
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '100'
  end
  object par3: TComboBox
    Left = 272
    Top = 88
    Width = 121
    Height = 21
    ItemHeight = 13
    MaxLength = 2
    Sorted = True
    TabOrder = 2
    Text = '2'
    Items.Strings = (
      '1'
      '2')
  end
  object par4: TEdit
    Left = 272
    Top = 112
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '1000000'
  end
  object par5: TEdit
    Left = 272
    Top = 136
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '0.05'
  end
  object par6: TEdit
    Left = 272
    Top = 160
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '10000000.0'
  end
  object par8: TEdit
    Left = 272
    Top = 240
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '0.5'
  end
  object par9: TComboBox
    Left = 272
    Top = 264
    Width = 121
    Height = 21
    ItemHeight = 13
    MaxLength = 2
    Sorted = True
    TabOrder = 7
    Text = '1'
    Items.Strings = (
      '1'
      '2')
  end
  object par7: TEdit
    Left = 272
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 8
    Text = '0.0001'
  end
  object BitBtn1: TBitBtn
    Left = 96
    Top = 288
    Width = 105
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 9
    OnClick = BitBtn1Click
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
  object BitBtn2: TBitBtn
    Left = 224
    Top = 288
    Width = 107
    Height = 25
    TabOrder = 10
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object XBegin: TEdit
    Left = 272
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 11
    Text = '0.01'
  end
end
