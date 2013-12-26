object EkranFunkcji: TEkranFunkcji
  Left = 527
  Top = 238
  Width = 345
  Height = 290
  Caption = 'Editing and Replaying'
  Color = clBtnFace
  Constraints.MaxHeight = 290
  Constraints.MaxWidth = 345
  Constraints.MinHeight = 290
  Constraints.MinWidth = 345
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OpisFunkcji: TMemo
    Left = 16
    Top = 24
    Width = 297
    Height = 193
    Enabled = False
    Lines.Strings = (
      'Editing'
      'You can access the editor at any time once a game has been'
      'started. It allows you to choose an initial setup and choose '
      'the'
      'current player. If you edit a game, then all the recorded moves'
      
        'will be lost - i.e. you will not be able to replay them any more' +
        '.'
      ''
      ''
      'Replaying'
      'You can replay your game starting at any chosen point in your'
      'game. You can also watch it move by move using the buttons'
      #39'Go back 1 move'#39' and '#39'Go forward 1 move'#39'.')
    TabOrder = 0
  end
end
