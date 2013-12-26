object EkranWczytywania: TEkranWczytywania
  Left = 442
  Top = 188
  Width = 730
  Height = 200
  Caption = 'Load Game'
  Color = clBtnFace
  Constraints.MaxHeight = 200
  Constraints.MaxWidth = 730
  Constraints.MinHeight = 200
  Constraints.MinWidth = 730
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
  object NapisSciezka: TLabel
    Left = 144
    Top = 56
    Width = 25
    Height = 13
    Caption = 'Path:'
  end
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 455
    Height = 16
    Caption = 'Remember to save your current game before loading another one.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object WpiszPlikGry: TEdit
    Left = 144
    Top = 72
    Width = 505
    Height = 21
    TabOrder = 0
  end
  object GuzikWybierzPlikGry: TButton
    Left = 24
    Top = 67
    Width = 105
    Height = 25
    Caption = 'Choose a game file'
    TabOrder = 1
    OnClick = GuzikWybierzPlikGryClick
  end
  object GuzikWczytajGre: TButton
    Left = 24
    Top = 104
    Width = 105
    Height = 33
    Caption = 'LOAD GAME'
    TabOrder = 2
    OnClick = GuzikWczytajGreClick
  end
  object WyborPlikuGry: TOpenDialog
    Filter = '.txt|*.txt'
    Left = 272
    Top = 120
  end
end
