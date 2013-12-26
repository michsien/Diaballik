object EkranEdytora: TEkranEdytora
  Left = 651
  Top = 126
  Width = 543
  Height = 578
  Caption = 'Game Editor'
  Color = clWhite
  Constraints.MaxHeight = 578
  Constraints.MaxWidth = 543
  Constraints.MinHeight = 578
  Constraints.MinWidth = 543
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
  object NapisOpisDzialaniaEdytora: TLabel
    Left = 24
    Top = 72
    Width = 458
    Height = 16
    Caption = 
      'You can exchange two fields by clicking on them one after anothe' +
      'r.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza1: TLabel
    Left = 224
    Top = 112
    Width = 54
    Height = 16
    Caption = 'Player1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object NapisNazwaGracza2: TLabel
    Left = 224
    Top = 504
    Width = 54
    Height = 16
    Caption = 'Player2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListaWybierzGracza: TComboBox
    Left = 24
    Top = 24
    Width = 177
    Height = 21
    ItemHeight = 13
    TabOrder = 0
    Text = 'Choose the current player'
    Items.Strings = (
      'Player1'
      'Player2')
  end
  object PlanszaEdytor: TStringGrid
    Left = 72
    Top = 136
    Width = 361
    Height = 361
    Color = clSilver
    ColCount = 7
    DefaultColWidth = 50
    DefaultRowHeight = 50
    FixedCols = 0
    RowCount = 7
    FixedRows = 0
    TabOrder = 1
    OnDrawCell = PlanszaEdytorDrawCell
    OnMouseDown = PlanszaEdytorMouseDown
  end
  object GuzikZagrajOdUstawienia: TButton
    Left = 312
    Top = 16
    Width = 169
    Height = 33
    Caption = 'Use this as the initial setup'
    TabOrder = 2
    OnClick = GuzikZagrajOdUstawieniaClick
  end
end
