object FormIOModulesSetting: TFormIOModulesSetting
  Left = 348
  Top = 269
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1084#1086#1076#1091#1083#1077#1081' '#1074#1074#1086#1076#1072'/'#1074#1099#1074#1086#1076#1072
  ClientHeight = 358
  ClientWidth = 713
  Color = clBtnFace
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object tcPageICP: TTabControl
    Left = 0
    Top = 0
    Width = 711
    Height = 357
    TabOrder = 0
    Tabs.Strings = (
      #1052#1086#1076#1091#1083#1100' '#1087#1077#1088#1074#1099#1081
      #1052#1086#1076#1091#1083#1100' '#1074#1090#1086#1088#1086#1081
      #1052#1086#1076#1091#1083#1100' '#1090#1088#1077#1090#1080#1081
      #1052#1086#1076#1091#1083#1100' '#1095#1077#1090#1074#1105#1088#1090#1099#1081)
    TabIndex = 0
    OnChange = tcPageICPChange
    object Label1: TLabel
      Left = 16
      Top = 52
      Width = 90
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1084#1086#1076#1091#1083#1103
    end
    object Label11: TLabel
      Left = 16
      Top = 86
      Width = 71
      Height = 13
      Caption = #1040#1076#1088#1077#1089' '#1084#1086#1076#1091#1083#1103
    end
    object Label10: TLabel
      Left = 16
      Top = 124
      Width = 82
      Height = 13
      Caption = #1060#1086#1088#1084#1072#1090' '#1076#1072#1085#1085#1099#1093
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 16
      Top = 160
      Width = 59
      Height = 13
      Caption = #1058#1080#1087' '#1084#1086#1076#1091#1083#1103
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 16
      Top = 234
      Width = 94
      Height = 13
      Caption = #1056#1077#1078#1077#1082#1094#1080#1103'/'#1053#1072#1082#1083#1086#1085
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 196
      Width = 54
      Height = 13
      Caption = #1058#1080#1087'  '#1074#1093#1086#1076#1072
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lIdentModul: TLabel
      Left = 16
      Top = 24
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object eNameMod: TEdit
      Left = 120
      Top = 48
      Width = 140
      Height = 21
      TabStop = False
      Color = 14215660
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object Edit5: TEdit
      Left = 120
      Top = 81
      Width = 140
      Height = 21
      Hint = #1044#1083#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1072#1076#1088#1077#1089#1072' '#1084#1086#1076#1091#1083#1103
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnDblClick = Edit5DblClick
      OnKeyPress = Edit1KeyPress
    end
    object cbDataType: TComboBox
      Left = 120
      Top = 119
      Width = 140
      Height = 21
      Hint = #1044#1086#1083#1078#1085#1099' '#1073#1099#1090#1100' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1080#1077' '#1077#1076#1080#1085#1080#1094#1099
      Style = csDropDownList
      Color = 14215660
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = cbDataTypeChange
      Items.Strings = (
        '')
    end
    object ComboBox2: TComboBox
      Left = 120
      Top = 155
      Width = 140
      Height = 21
      Style = csDropDownList
      Color = 14215660
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        #1053#1086#1088#1084#1072#1083#1100#1085#1099#1081
        #1057#1082#1086#1088#1086#1089#1090#1085#1086#1081)
    end
    object cbFilter: TComboBox
      Left = 120
      Top = 230
      Width = 140
      Height = 21
      Hint = #1042' '#1089#1086#1086#1090#1074#1077#1090#1089#1090#1074#1080#1080' '#1089' '#1095#1072#1089#1090#1086#1090#1086#1081' '#1089#1077#1090#1080' '#1087#1080#1090#1072#1085#1080#1103
      Style = csDropDownList
      Color = 14215660
      ItemHeight = 13
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnChange = cbFilterChange
      Items.Strings = (
        '60 '#1043#1094
        '50 '#1043#1094)
    end
    object cbInputType: TComboBox
      Left = 120
      Top = 192
      Width = 140
      Height = 21
      Style = csDropDownList
      Color = 14215660
      ItemHeight = 13
      TabOrder = 5
      OnChange = cbInputTypeChange
    end
    object bCallibr: TBitBtn
      Left = 288
      Top = 295
      Width = 150
      Height = 25
      Caption = #1050#1072#1083#1080#1073#1088#1086#1074#1082#1072' '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = bCallibrClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
    end
    object bWrite: TBitBtn
      Left = 450
      Top = 295
      Width = 150
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100'!'
      Enabled = False
      TabOrder = 7
      OnClick = bWriteClick
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000C40E0000C40E00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333333333FFFFFFFFF333333300000
        0000333333777777777F33333330888888803333337FFFFFFF7F330333307777
        777033F333777777777F33903330FFFFFFF0337F337F3F3FFF7F33990330F9F0
        00F03377F37F7377737F99999030FFFFFFF077777F7F3333337F99999900FFFF
        FFF07777777F3FFFFF7F99999030F40004F07777737F77777F7F30990330F000
        00F03377337F7F337F7F30903330F00000F03373337F7FFF7F7F30033330F400
        04F03333337F7777737F33333330FFFFFFF03333337FFFFFFF7F333333300000
        0000333333777777777333333333333333333333333333333333}
      NumGlyphs = 2
    end
    object pCallibrAin: TPanel
      Left = 7
      Top = 264
      Width = 695
      Height = 81
      BevelInner = bvRaised
      BevelOuter = bvNone
      TabOrder = 8
      Visible = False
      object Label4: TLabel
        Left = 16
        Top = 32
        Width = 36
        Height = 13
        Caption = 'ggggg'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 16
        Top = 8
        Width = 36
        Height = 13
        Caption = 'aaaaa'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 16
        Top = 56
        Width = 21
        Height = 13
        Caption = 'rrrrr'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bExecute: TBitBtn
        Left = 512
        Top = 24
        Width = 75
        Height = 25
        TabOrder = 0
        OnClick = bExecuteClick
        Kind = bkOK
      end
      object BitBtn2: TBitBtn
        Left = 600
        Top = 24
        Width = 75
        Height = 25
        TabOrder = 1
        Kind = bkCancel
      end
      object pCallibrAout: TPanel
        Left = 248
        Top = 8
        Width = 251
        Height = 71
        BevelOuter = bvNone
        TabOrder = 2
        Visible = False
        object GroupBox1: TGroupBox
          Left = 96
          Top = 0
          Width = 155
          Height = 61
          Caption = #1055#1086#1076#1089#1090#1088#1086#1081#1082#1072' '
          TabOrder = 0
          object bMinusMinus: TBitBtn
            Left = 16
            Top = 24
            Width = 25
            Height = 25
            Hint = #1043#1088#1091#1073#1086
            Caption = '- -'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = bMinusMinusClick
          end
          object bMinus: TBitBtn
            Left = 48
            Top = 24
            Width = 25
            Height = 25
            Hint = #1058#1086#1095#1085#1086
            Caption = '- '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = bMinusClick
          end
          object bPlus: TBitBtn
            Left = 80
            Top = 24
            Width = 25
            Height = 25
            Hint = #1058#1086#1095#1085#1086
            Caption = '+'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = bPlusClick
          end
          object bPlusPlus: TBitBtn
            Left = 112
            Top = 24
            Width = 25
            Height = 25
            Hint = #1043#1088#1091#1073#1086
            Caption = '++'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlue
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = bPlusPlusClick
          end
        end
        object cbSelectChan: TComboBox
          Left = 8
          Top = 16
          Width = 75
          Height = 21
          Hint = #1042#1099#1073#1086#1088' '#1082#1072#1083#1080#1073#1088#1091#1077#1084#1086#1075#1086' '#1082#1072#1085#1072#1083#1072
          Style = csDropDownList
          Color = 14215660
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ItemHeight = 13
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
    end
    object pTable: TPanel
      Left = 272
      Top = 40
      Width = 435
      Height = 221
      BevelOuter = bvNone
      TabOrder = 9
      object sgTable: TStringGrid
        Left = 2
        Top = 7
        Width = 425
        Height = 205
        DefaultColWidth = 76
        DefaultRowHeight = 19
        FixedColor = 14215660
        RowCount = 9
        TabOrder = 0
        OnDrawCell = sgTableDrawCell
        OnSelectCell = sgTableSelectCell
        RowHeights = (
          19
          19
          19
          19
          19
          19
          19
          19
          19)
      end
    end
    object pCounters: TPanel
      Left = 8
      Top = 104
      Width = 257
      Height = 145
      TabOrder = 10
      Visible = False
      object Label5: TLabel
        Left = 16
        Top = 16
        Width = 82
        Height = 13
        Caption = #1057#1073#1088#1086#1089' '#1082#1072#1085#1072#1083#1072'    '
      end
      object Label6: TLabel
        Left = 16
        Top = 56
        Width = 74
        Height = 13
        Caption = 'ON/OFF '#1082#1072#1085#1072#1083
      end
      object Label7: TLabel
        Left = 24
        Top = 96
        Width = 3
        Height = 13
      end
      object cbSelChan: TComboBox
        Left = 112
        Top = 16
        Width = 129
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        OnChange = cbSelChanChange
        Items.Strings = (
          #1055#1077#1088#1074#1099#1081
          #1042#1090#1086#1088#1086#1081)
      end
      object cbSelChanStart: TComboBox
        Left = 112
        Top = 48
        Width = 129
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemHeight = 13
        ParentFont = False
        TabOrder = 1
        OnChange = cbSelChanChange
        Items.Strings = (
          #1055#1077#1088#1074#1099#1081
          #1042#1090#1086#1088#1086#1081)
      end
    end
  end
end
