object Ferm_opt_node: TFerm_opt_node
  Left = 663
  Top = 66
  Width = 266
  Height = 580
  Caption = #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1091#1079#1083#1086#1074
  Color = clBtnFace
  Constraints.MaxHeight = 580
  Constraints.MaxWidth = 266
  Constraints.MinHeight = 580
  Constraints.MinWidth = 266
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 32
    Top = 8
    Width = 188
    Height = 13
    Caption = #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1091#1079#1083#1086#1074
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 96
    Width = 257
    Height = 449
    Caption = ' '#1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1080' '#1091#1079#1083#1072'  '
    TabOrder = 0
    object Ok_Btn: TBitBtn
      Left = 11
      Top = 424
      Width = 110
      Height = 22
      Caption = 'OK'
      Default = True
      ModalResult = 2
      TabOrder = 0
      OnClick = Ok_BtnClick
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
    object GroupBox5: TGroupBox
      Left = 8
      Top = 32
      Width = 233
      Height = 105
      Caption = #1042#1099#1073#1086#1088' '#1086#1087#1090#1080#1084#1080#1079#1080#1088#1091#1077#1084#1086#1075#1086' '#1091#1079#1083#1072
      TabOrder = 1
      object Label4: TLabel
        Left = 8
        Top = 24
        Width = 150
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086' '#1086#1087#1090#1080#1084#1080#1079#1080#1088#1091#1084#1099#1093' '#1091#1079#1083#1086#1074
      end
      object Label5: TLabel
        Left = 8
        Top = 48
        Width = 70
        Height = 13
        Caption = #1042#1099#1073#1088#1072#1090#1100' '#1091#1079#1077#1083
      end
      object ComboBox1: TComboBox
        Left = 176
        Top = 48
        Width = 41
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
      end
      object Edit9: TEdit
        Left = 176
        Top = 24
        Width = 41
        Height = 21
        Enabled = False
        TabOrder = 1
        Text = 'Edit9'
      end
      object Button1: TButton
        Left = 32
        Top = 80
        Width = 73
        Height = 17
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 128
        Top = 80
        Width = 73
        Height = 17
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 3
        OnClick = Button2Click
      end
    end
    object GroupBox6: TGroupBox
      Left = 8
      Top = 144
      Width = 233
      Height = 209
      Caption = #1059#1079#1077#1083' '#8470'  '
      TabOrder = 2
      Visible = False
      object Label1: TLabel
        Left = 8
        Top = 24
        Width = 117
        Height = 13
        Caption = #1063#1080#1089#1083#1086' '#1076#1088#1086#1073#1083#1077#1085#1080#1081' '#1096#1072#1075#1072
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 48
        Width = 217
        Height = 81
        Caption = #1056#1072#1076#1080#1091#1089' '#1086#1073#1083#1072#1089#1090#1080' '#1087#1086#1080#1089#1082#1072
        TabOrder = 0
        object Edit3: TEdit
          Left = 176
          Top = 20
          Width = 25
          Height = 21
          TabOrder = 0
          Text = '15'
          OnChange = Edit3Change
        end
        object ScrollBar1: TScrollBar
          Left = 8
          Top = 24
          Width = 145
          Height = 17
          Max = 200
          Min = 1
          PageSize = 0
          Position = 15
          TabOrder = 1
          OnChange = ScrollBar1Change
        end
        object CheckBox2: TCheckBox
          Left = 64
          Top = 56
          Width = 89
          Height = 17
          Caption = #1040#1074#1090#1086#1056#1072#1076#1080#1091#1089
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = CheckBox2Click
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 136
        Width = 217
        Height = 41
        Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1091#1079#1083#1086#1074
        TabOrder = 1
        object RadioButton1: TRadioButton
          Left = 96
          Top = 16
          Width = 49
          Height = 17
          Caption = #1087#1086' '#1061
          TabOrder = 0
          OnClick = RadioButton1Click
        end
        object RadioButton2: TRadioButton
          Left = 160
          Top = 16
          Width = 41
          Height = 17
          Caption = #1087#1086' Y'
          TabOrder = 1
          OnClick = RadioButton2Click
        end
        object RadioButton3: TRadioButton
          Left = 8
          Top = 16
          Width = 65
          Height = 17
          Caption = #1087#1086' X '#1080' Y'
          Checked = True
          TabOrder = 2
          TabStop = True
          OnClick = RadioButton3Click
        end
      end
      object CheckBox1: TCheckBox
        Left = 8
        Top = 184
        Width = 185
        Height = 17
        Caption = #1042#1099#1074#1086#1076' '#1087#1088#1086#1084#1077#1078#1091#1090#1086#1095#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object Edit1: TEdit
        Left = 184
        Top = 16
        Width = 25
        Height = 21
        TabOrder = 3
        Text = '4'
        OnChange = Edit1Change
      end
    end
    object GroupBox4: TGroupBox
      Left = 8
      Top = 360
      Width = 233
      Height = 57
      Caption = #1052#1085#1086#1075#1086#1091#1079#1083#1086#1074#1072#1103' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103
      TabOrder = 3
      object Label3: TLabel
        Left = 14
        Top = 28
        Width = 131
        Height = 13
        Caption = #1063#1080#1089#1083#1086' '#1080#1090#1077#1088#1072#1094#1080#1081' '#1087#1086' '#1091#1079#1083#1072#1084
      end
      object Edit8: TEdit
        Left = 184
        Top = 20
        Width = 33
        Height = 21
        TabOrder = 0
        Text = '4'
      end
    end
    object BitBtn1: TBitBtn
      Left = 131
      Top = 424
      Width = 110
      Height = 22
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      TabOrder = 4
      OnClick = BitBtn1Click
      Kind = bkCancel
    end
  end
  object GroupBox7: TGroupBox
    Left = 0
    Top = 40
    Width = 257
    Height = 41
    Caption = #1042#1099#1073#1086#1088' '#1082#1088#1080#1090#1077#1088#1080#1103' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1080
    TabOrder = 1
    object RadioButton4: TRadioButton
      Left = 24
      Top = 16
      Width = 89
      Height = 17
      Caption = #1057#1080#1083#1086#1074#1086#1081' '#1074#1077#1089
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton5: TRadioButton
      Left = 136
      Top = 16
      Width = 65
      Height = 17
      Caption = #1052#1072#1089#1089#1072
      TabOrder = 1
    end
  end
end
