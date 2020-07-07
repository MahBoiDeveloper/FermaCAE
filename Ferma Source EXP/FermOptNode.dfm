object Ferm_opt_node: TFerm_opt_node
  Left = 575
  Top = 125
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103' '#1087#1086#1083#1086#1078#1077#1085#1080#1103' '#1091#1079#1083#1086#1074
  ClientHeight = 481
  ClientWidth = 265
  Color = clBtnFace
  Constraints.MaxHeight = 519
  Constraints.MaxWidth = 281
  Constraints.MinHeight = 519
  Constraints.MinWidth = 281
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox7: TGroupBox
    Left = 5
    Top = 0
    Width = 255
    Height = 41
    TabOrder = 0
    object Label2: TLabel
      Left = 70
      Top = 0
      Width = 118
      Height = 13
      Caption = #1050#1088#1080#1090#1077#1088#1080#1081' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1080
    end
    object RadioButton4: TRadioButton
      Left = 25
      Top = 18
      Width = 89
      Height = 17
      Caption = #1057#1080#1083#1086#1074#1086#1081' '#1074#1077#1089
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButton5: TRadioButton
      Left = 140
      Top = 18
      Width = 65
      Height = 17
      Caption = #1052#1072#1089#1089#1072
      TabOrder = 1
    end
  end
  object GroupBox5: TGroupBox
    Left = 5
    Top = 44
    Width = 255
    Height = 110
    Caption = #1042#1099#1073#1086#1088' '#1086#1087#1090#1080#1084#1080#1079#1080#1088#1091#1077#1084#1086#1075#1086' '#1091#1079#1083#1072
    TabOrder = 1
    object Label4: TLabel
      Left = 10
      Top = 22
      Width = 160
      Height = 13
      Caption = #1050#1086#1083'-'#1074#1086' '#1086#1087#1090#1080#1084#1080#1079#1080#1088#1091#1084#1099#1093' '#1091#1079#1083#1086#1074
    end
    object Label5: TLabel
      Left = 10
      Top = 45
      Width = 160
      Height = 26
      Caption = #1053#1086#1084#1077#1088#1072' '#1086#1087#1090#1080#1084#1080#1079#1080#1088#1091#1077#1084#1099#1093' '#1091#1079#1083#1086#1074' ('#1095#1077#1088#1077#1079' '#1079#1072#1087#1103#1090#1091#1102')'
      WordWrap = True
    end
    object Edit9: TEdit
      Left = 180
      Top = 20
      Width = 60
      Height = 21
      Enabled = False
      TabOrder = 0
      Text = 'Edit9'
    end
    object Button1: TButton
      Left = 10
      Top = 80
      Width = 100
      Height = 20
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 140
      Top = 80
      Width = 100
      Height = 20
      Caption = #1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = Button2Click
    end
    object OptNodeEdt: TEdit
      Left = 180
      Top = 50
      Width = 60
      Height = 21
      TabOrder = 3
    end
  end
  object GroupBox6: TGroupBox
    Left = 5
    Top = 157
    Width = 255
    Height = 230
    TabOrder = 2
    Visible = False
    object Label1: TLabel
      Left = 53
      Top = 53
      Width = 117
      Height = 13
      Caption = #1063#1080#1089#1083#1086' '#1076#1088#1086#1073#1083#1077#1085#1080#1081' '#1096#1072#1075#1072
    end
    object Label6: TLabel
      Left = 110
      Top = 23
      Width = 60
      Height = 13
      Caption = #1053#1086#1084#1077#1088' '#1091#1079#1083#1072
    end
    object GroupBox2: TGroupBox
      Left = 5
      Top = 77
      Width = 245
      Height = 70
      Caption = #1056#1072#1076#1080#1091#1089' '#1086#1073#1083#1072#1089#1090#1080' '#1087#1086#1080#1089#1082#1072
      TabOrder = 0
      object Edit3: TEdit
        Left = 175
        Top = 18
        Width = 60
        Height = 21
        TabOrder = 0
        Text = '15'
        OnChange = Edit3Change
      end
      object ScrollBar1: TScrollBar
        Left = 10
        Top = 20
        Width = 155
        Height = 17
        Max = 200
        Min = 1
        PageSize = 0
        Position = 15
        TabOrder = 1
        OnChange = ScrollBar1Change
      end
      object CheckBox2: TCheckBox
        Left = 80
        Top = 45
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
      Left = 5
      Top = 150
      Width = 245
      Height = 50
      Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1091#1079#1083#1086#1074
      TabOrder = 1
      object RadioButton1: TRadioButton
        Left = 90
        Top = 20
        Width = 75
        Height = 17
        Caption = #1087#1086' '#1061
        TabOrder = 0
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 170
        Top = 20
        Width = 70
        Height = 17
        Caption = #1087#1086' Y'
        TabOrder = 1
        OnClick = RadioButton2Click
      end
      object RadioButton3: TRadioButton
        Left = 10
        Top = 20
        Width = 75
        Height = 17
        Caption = #1087#1086' X '#1080' Y'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = RadioButton3Click
      end
    end
    object CheckBox1: TCheckBox
      Left = 10
      Top = 205
      Width = 185
      Height = 17
      Caption = #1042#1099#1074#1086#1076' '#1087#1088#1086#1084#1077#1078#1091#1090#1086#1095#1085#1099#1093' '#1076#1072#1085#1085#1099#1093
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object Edit1: TEdit
      Left = 180
      Top = 50
      Width = 60
      Height = 21
      TabOrder = 3
      Text = '4'
      OnChange = Edit1Change
    end
    object ComboBox1: TComboBox
      Left = 180
      Top = 20
      Width = 60
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      OnChange = ComboBox1Change
    end
  end
  object GroupBox4: TGroupBox
    Left = 5
    Top = 391
    Width = 255
    Height = 52
    Caption = #1052#1085#1086#1075#1086#1091#1079#1083#1086#1074#1072#1103' '#1086#1087#1090#1080#1084#1080#1079#1072#1094#1080#1103
    TabOrder = 3
    object Label3: TLabel
      Left = 38
      Top = 23
      Width = 131
      Height = 13
      Caption = #1063#1080#1089#1083#1086' '#1080#1090#1077#1088#1072#1094#1080#1081' '#1087#1086' '#1091#1079#1083#1072#1084
    end
    object Edit8: TEdit
      Left = 180
      Top = 20
      Width = 60
      Height = 21
      TabOrder = 0
      Text = '4'
    end
  end
  object Ok_Btn: TBitBtn
    Left = 5
    Top = 450
    Width = 120
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 2
    TabOrder = 4
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
  object BitBtn1: TBitBtn
    Left = 139
    Top = 450
    Width = 120
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 5
    OnClick = BitBtn1Click
    Kind = bkCancel
  end
end
