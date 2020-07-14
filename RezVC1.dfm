object FermaRezVC1: TFermaRezVC1
  Left = 193
  Top = 153
  BorderStyle = bsSingle
  Caption = 
    'Результаты оптимизационного расчёта для метода Возможных направл' +
    'ений'
  ClientHeight = 329
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 376
    Top = 40
    Width = 85
    Height = 13
    Caption = 'Число итераций '
  end
  object Label2: TLabel
    Left = 376
    Top = 64
    Width = 138
    Height = 13
    Caption = 'Погрешность оптимизации'
  end
  object Label3: TLabel
    Left = 376
    Top = 88
    Width = 131
    Height = 13
    Caption = 'Силовой вес конструкции'
  end
  object Label4: TLabel
    Left = 376
    Top = 112
    Width = 156
    Height = 13
    Caption = 'Полученный объём материала'
  end
  object Label5: TLabel
    Left = 376
    Top = 136
    Width = 95
    Height = 13
    Caption = 'Результат расчета'
  end
  object Label6: TLabel
    Left = 440
    Top = 8
    Width = 221
    Height = 13
    Caption = 'С учётом стержней, работающих на сжатие'
  end
  object Label7: TLabel
    Left = 64
    Top = 8
    Width = 225
    Height = 13
    Caption = 'Без учёта стержней, работающих на сжатие'
  end
  object Label8: TLabel
    Left = 8
    Top = 48
    Width = 85
    Height = 13
    Caption = 'Число итераций '
  end
  object Label9: TLabel
    Left = 8
    Top = 72
    Width = 138
    Height = 13
    Caption = 'Погрешность оптимизации'
  end
  object Label10: TLabel
    Left = 8
    Top = 96
    Width = 131
    Height = 13
    Caption = 'Силовой вес конструкции'
  end
  object Label11: TLabel
    Left = 8
    Top = 120
    Width = 156
    Height = 13
    Caption = 'Полученный объём материала'
  end
  object Label12: TLabel
    Left = 8
    Top = 144
    Width = 95
    Height = 13
    Caption = 'Результат расчета'
  end
  object Edit1: TEdit
    Left = 592
    Top = 40
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object Edit3: TEdit
    Left = 592
    Top = 88
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object Edit4: TEdit
    Left = 592
    Top = 112
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object StringGrid1: TStringGrid
    Left = 376
    Top = 168
    Width = 337
    Height = 120
    ColCount = 2
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 3
    ColWidths = (
      64
      268)
    RowHeights = (
      16
      16
      16
      16
      16)
  end
  object Edit5: TEdit
    Left = 488
    Top = 136
    Width = 225
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object Edit2: TEdit
    Left = 592
    Top = 64
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 5
  end
  object Edit6: TEdit
    Left = 224
    Top = 40
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 6
  end
  object Edit7: TEdit
    Left = 224
    Top = 64
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Edit8: TEdit
    Left = 224
    Top = 88
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 8
  end
  object Edit9: TEdit
    Left = 224
    Top = 112
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 9
  end
  object Edit10: TEdit
    Left = 112
    Top = 136
    Width = 233
    Height = 21
    Enabled = False
    TabOrder = 10
  end
  object StringGrid2: TStringGrid
    Left = 8
    Top = 168
    Width = 337
    Height = 120
    ColCount = 2
    DefaultRowHeight = 16
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 11
    ColWidths = (
      64
      266)
  end
  object BitBtn1: TBitBtn
    Left = 328
    Top = 296
    Width = 75
    Height = 25
    TabOrder = 12
    Kind = bkOK
  end
end
