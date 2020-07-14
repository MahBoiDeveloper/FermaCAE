object FilesList_Form: TFilesList_Form
  Left = 171
  Top = 179
  Width = 617
  Height = 371
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  Caption = #1057#1087#1080#1089#1086#1082' '#1092#1072#1081#1083#1086#1074' '#1088#1072#1089#1095#1077#1090#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 140
    Height = 13
    Caption = #1057#1087#1080#1089#1086#1082' '#1076#1086#1089#1090#1091#1087#1085#1099#1093' '#1092#1072#1081#1083#1086#1074':'
  end
  object Label2: TLabel
    Left = 184
    Top = 8
    Width = 87
    Height = 13
    Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1092#1072#1081#1083#1072':'
  end
  object FileListBox1: TFileListBox
    Left = 8
    Top = 24
    Width = 161
    Height = 273
    FileType = [ftReadOnly, ftHidden, ftSystem, ftArchive, ftNormal]
    ItemHeight = 16
    ShowGlyphs = True
    TabOrder = 0
    OnChange = FileListBox1Change
  end
  object Memo1: TMemo
    Left = 176
    Top = 24
    Width = 425
    Height = 305
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 304
    Width = 161
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    Kind = bkClose
  end
end
