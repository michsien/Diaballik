object EkranHistorii: TEkranHistorii
  Left = 538
  Top = 77
  Width = 608
  Height = 647
  Caption = 'Historia gry'
  Color = clWhite
  Constraints.MaxHeight = 647
  Constraints.MaxWidth = 608
  Constraints.MinHeight = 647
  Constraints.MinWidth = 608
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object NapisHistoriaZawiera: TLabel
    Left = 40
    Top = 16
    Width = 116
    Height = 16
    Caption = 'Historia zawiera '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisRuchow: TLabel
    Left = 256
    Top = 16
    Width = 53
    Height = 16
    Caption = 'ruch'#243'w.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisPrezentowanaSytuacja: TLabel
    Left = 40
    Top = 56
    Width = 261
    Height = 16
    Caption = 'Prezentowana sytuacja to sytuacja po'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisRuchach: TLabel
    Left = 384
    Top = 56
    Width = 59
    Height = 16
    Caption = 'ruchach.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza1: TLabel
    Left = 248
    Top = 184
    Width = 49
    Height = 16
    Caption = 'Gracz1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza2: TLabel
    Left = 248
    Top = 580
    Width = 49
    Height = 16
    Caption = 'Gracz2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object WpiszLiczbaRuchow: TEdit
    Left = 160
    Top = 16
    Width = 89
    Height = 21
    Enabled = False
    TabOrder = 0
    Text = '0'
  end
  object WpiszNumerRuchu: TEdit
    Left = 304
    Top = 56
    Width = 73
    Height = 21
    Enabled = False
    TabOrder = 1
    Text = '0'
  end
  object GuzikSkocz1Tyl: TButton
    Left = 40
    Top = 88
    Width = 105
    Height = 33
    Caption = 'Skocz o 1 do ty'#322'u'
    TabOrder = 2
    OnClick = GuzikSkocz1TylClick
  end
  object GuzikSkocz1Przod: TButton
    Left = 40
    Top = 128
    Width = 105
    Height = 33
    Caption = 'Skocz o 1 do przodu'
    TabOrder = 3
    OnClick = GuzikSkocz1PrzodClick
  end
  object GuzikSkoczTyl: TButton
    Left = 168
    Top = 88
    Width = 97
    Height = 33
    Caption = 'Skocz do ty'#322'u o:'
    TabOrder = 4
    OnClick = GuzikSkoczTylClick
  end
  object GuzikSkoczPrzod: TButton
    Left = 168
    Top = 128
    Width = 97
    Height = 33
    Caption = 'Skocz do przodu o:'
    TabOrder = 5
    OnClick = GuzikSkoczPrzodClick
  end
  object WpiszSkokTyl: TEdit
    Left = 272
    Top = 96
    Width = 73
    Height = 21
    TabOrder = 6
    Text = '0'
  end
  object WpiszSkokPrzod: TEdit
    Left = 272
    Top = 136
    Width = 73
    Height = 21
    TabOrder = 7
    Text = '0'
  end
  object GuzikOdtwarzaj: TButton
    Left = 392
    Top = 120
    Width = 81
    Height = 41
    Caption = 'Odtwarzaj'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = GuzikOdtwarzajClick
  end
  object GuzikZatrzymaj: TButton
    Left = 480
    Top = 120
    Width = 81
    Height = 41
    Caption = 'Zatrzymaj'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = GuzikZatrzymajClick
  end
  object PlanszaHistoria: TStringGrid
    Left = 104
    Top = 208
    Width = 361
    Height = 361
    Color = clSilver
    ColCount = 7
    DefaultColWidth = 50
    DefaultRowHeight = 50
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    TabOrder = 10
    OnDrawCell = PlanszaHistoriaDrawCell
  end
  object GuzikSkoczDoPoczatku: TButton
    Left = 392
    Top = 88
    Width = 169
    Height = 25
    Caption = 'Skocz do pocz'#261'tku'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = GuzikSkoczDoPoczatkuClick
  end
end
