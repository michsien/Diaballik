object EkranGlowny: TEkranGlowny
  Left = 259
  Top = 179
  Width = 856
  Height = 585
  Caption = 'Diaballik'
  Color = clWhite
  Constraints.MaxHeight = 585
  Constraints.MaxWidth = 856
  Constraints.MinHeight = 585
  Constraints.MinWidth = 856
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MenuGlowne
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object NapisWybierzTryb: TLabel
    Left = 528
    Top = 16
    Width = 199
    Height = 16
    Caption = 'Choose your preferred gamemode:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nasalization'
    Font.Style = []
    ParentFont = False
  end
  object NapisI: TLabel
    Left = 696
    Top = 56
    Width = 27
    Height = 16
    Caption = 'AND'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Nasalization'
    Font.Style = []
    ParentFont = False
  end
  object NapisBiezacyGracz: TLabel
    Left = 536
    Top = 160
    Width = 102
    Height = 16
    Caption = 'Current player:'
    Font.Charset = EASTEUROPE_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza1: TLabel
    Left = 192
    Top = 24
    Width = 64
    Height = 20
    Caption = 'Player1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza2: TLabel
    Left = 192
    Top = 440
    Width = 64
    Height = 20
    Caption = 'Player2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisA: TLabel
    Left = 32
    Top = 72
    Width = 7
    Height = 13
    Caption = 'A'
  end
  object NapisB1: TLabel
    Left = 32
    Top = 123
    Width = 7
    Height = 13
    Caption = 'B'
  end
  object NapisC: TLabel
    Left = 32
    Top = 174
    Width = 7
    Height = 13
    Caption = 'C'
  end
  object NapisD: TLabel
    Left = 32
    Top = 225
    Width = 8
    Height = 13
    Caption = 'D'
  end
  object NapisE: TLabel
    Left = 32
    Top = 276
    Width = 7
    Height = 13
    Caption = 'E'
  end
  object NapisF: TLabel
    Left = 32
    Top = 327
    Width = 6
    Height = 13
    Caption = 'F'
  end
  object NapisG: TLabel
    Left = 32
    Top = 378
    Width = 8
    Height = 13
    Caption = 'G'
  end
  object Napis1: TLabel
    Left = 80
    Top = 419
    Width = 6
    Height = 13
    Caption = '1'
  end
  object Napis2: TLabel
    Left = 131
    Top = 419
    Width = 6
    Height = 13
    Caption = '2'
  end
  object Napis3: TLabel
    Left = 182
    Top = 419
    Width = 6
    Height = 13
    Caption = '3'
  end
  object Napis4: TLabel
    Left = 233
    Top = 419
    Width = 6
    Height = 13
    Caption = '4'
  end
  object Napis5: TLabel
    Left = 284
    Top = 419
    Width = 6
    Height = 13
    Caption = '5'
  end
  object Napis6: TLabel
    Left = 325
    Top = 419
    Width = 6
    Height = 13
    Caption = '6'
  end
  object Napis7: TLabel
    Left = 386
    Top = 419
    Width = 6
    Height = 13
    Caption = '7'
  end
  object Ramka: TShape
    Left = 504
    Top = 144
    Width = 313
    Height = 273
    Brush.Style = bsClear
  end
  object NapisWybraneRuchy: TLabel
    Left = 536
    Top = 224
    Width = 159
    Height = 13
    Caption = 'Chosen moves (a shift or a pass) :'
  end
  object Napis1_Z: TLabel
    Left = 512
    Top = 256
    Width = 52
    Height = 16
    Caption = '1. From'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisDO1: TLabel
    Left = 648
    Top = 256
    Width = 20
    Height = 16
    Caption = 'To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Napis2_Z: TLabel
    Left = 512
    Top = 288
    Width = 52
    Height = 16
    Caption = '2. From'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisDO2: TLabel
    Left = 648
    Top = 288
    Width = 20
    Height = 16
    Caption = 'To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Napis3_Z: TLabel
    Left = 512
    Top = 320
    Width = 52
    Height = 16
    Caption = '3. From'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisDO3: TLabel
    Left = 648
    Top = 320
    Width = 20
    Height = 16
    Caption = 'To'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisPodania: TLabel
    Left = 536
    Top = 192
    Width = 112
    Height = 16
    Caption = '1 pass remaining.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
    Visible = False
  end
  object GuzikZagraj: TButton
    Left = 728
    Top = 40
    Width = 75
    Height = 30
    Caption = 'Play!'
    TabOrder = 0
    OnClick = GuzikZagrajClick
  end
  object Plansza: TStringGrid
    Left = 56
    Top = 48
    Width = 361
    Height = 361
    Color = clSilver
    ColCount = 7
    DefaultColWidth = 50
    DefaultRowHeight = 50
    Enabled = False
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    TabOrder = 1
    OnDrawCell = PlanszaDrawCell
    OnMouseDown = PlanszaMouseDown
  end
  object ListaWyborTrybu: TComboBox
    Left = 528
    Top = 48
    Width = 161
    Height = 21
    ItemHeight = 13
    TabOrder = 2
    Text = 'Choose a gamemode'
    Items.Strings = (
      'Human vs Human'
      'Human vs Computer'
      'Computer vs Human'
      'Computer vs Computer')
  end
  object WpiszBiezacyGracz: TEdit
    Left = 656
    Top = 160
    Width = 81
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object GuzikUsunRuchy: TButton
    Left = 680
    Top = 368
    Width = 129
    Height = 33
    Caption = 'Erase all moves'
    Enabled = False
    TabOrder = 4
    OnClick = GuzikUsunRuchyClick
  end
  object GuzikZakonczKolejke: TButton
    Left = 536
    Top = 368
    Width = 105
    Height = 33
    Caption = 'End this turn'
    Enabled = False
    TabOrder = 5
    OnClick = GuzikZakonczKolejkeClick
  end
  object WpiszRuch1_1: TEdit
    Left = 568
    Top = 255
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 6
  end
  object WpiszRuch1_2: TEdit
    Left = 680
    Top = 255
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 7
  end
  object WpiszRuch2_1: TEdit
    Left = 568
    Top = 287
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 8
  end
  object WpiszRuch3_1: TEdit
    Left = 568
    Top = 319
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 9
  end
  object WpiszRuch2_2: TEdit
    Left = 680
    Top = 287
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 10
  end
  object WpiszRuch3_2: TEdit
    Left = 680
    Top = 319
    Width = 73
    Height = 21
    Color = clWhite
    Enabled = False
    TabOrder = 11
  end
  object GuzikHint: TButton
    Left = 504
    Top = 480
    Width = 313
    Height = 33
    Caption = 'Hint - use it on your own responsibility!!!'
    Enabled = False
    TabOrder = 12
    OnClick = GuzikHintClick
  end
  object GuzikX1: TButton
    Left = 768
    Top = 255
    Width = 25
    Height = 21
    Caption = 'X'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = GuzikX1Click
  end
  object GuzikX2: TButton
    Left = 768
    Top = 287
    Width = 25
    Height = 21
    Caption = 'X'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    OnClick = GuzikX2Click
  end
  object GuzikX3: TButton
    Left = 768
    Top = 319
    Width = 25
    Height = 21
    Caption = 'X'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    OnClick = GuzikX3Click
  end
  object GuzikZatrzymajKomputer: TButton
    Left = 504
    Top = 440
    Width = 145
    Height = 33
    Caption = 'Stop the computer'#39's turn'
    Enabled = False
    TabOrder = 16
    OnClick = GuzikZatrzymajKomputerClick
  end
  object GuzikWznowKomputer: TButton
    Left = 664
    Top = 440
    Width = 153
    Height = 33
    Caption = 'Resume the computer'#39's turn'
    Enabled = False
    TabOrder = 17
    OnClick = GuzikWznowKomputerClick
  end
  object MenuGlowne: TMainMenu
    Left = 80
    object MenuZapiszWczytaj: TMenuItem
      Caption = 'Save/Load Game'
      object GuzikZapisz: TMenuItem
        Caption = 'Save Game'
        OnClick = GuzikZapiszClick
      end
      object GuzikWczytaj: TMenuItem
        Caption = 'Load Game'
        OnClick = GuzikWczytajClick
      end
    end
    object MenuEdytor: TMenuItem
      Caption = 'Game Editor'
      object GuzikEdytor: TMenuItem
        Caption = 'Run Editor'
        OnClick = GuzikEdytorClick
      end
    end
    object MenuHistoria: TMenuItem
      Caption = 'Game Replay'
      object GuzikHistoria: TMenuItem
        Caption = 'Replay'
        OnClick = GuzikHistoriaClick
      end
    end
    object MenuPomoc: TMenuItem
      Caption = 'Help'
      object GuzikZasady: TMenuItem
        Caption = 'Rules'
        OnClick = GuzikZasadyClick
      end
      object GuzikEdycjaHistoria: TMenuItem
        Caption = 'Editing and Replaying'
        OnClick = GuzikEdycjaHistoriaClick
      end
    end
  end
end
