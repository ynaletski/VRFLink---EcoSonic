object FormArchFromFile: TFormArchFromFile
  Left = 687
  Top = 226
  Width = 640
  Height = 400
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1072#1088#1093#1080#1074#1085#1086#1081' '#1090#1072#1073#1083#1080#1094#1099' '#1080#1079' '#1092#1072#1081#1083#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sgTable: TStringGrid
    Left = 16
    Top = 48
    Width = 601
    Height = 301
    TabOrder = 0
    OnDrawCell = sgTableDrawCell
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object cbType: TComboBox
    Left = 16
    Top = 16
    Width = 165
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = cbTypeChange
    Items.Strings = (
      #1040#1088#1093#1080#1074' '#1095#1072#1089#1086#1074#1086#1081
      #1040#1088#1093#1080#1074' '#1089#1091#1090#1086#1095#1085#1099#1081
      #1040#1088#1093#1080#1074' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103)
  end
  object cbTypeTable: TComboBox
    Left = 216
    Top = 16
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    OnChange = cbTypeTableChange
    Items.Strings = (
      '')
  end
end
