object EkranZasad: TEkranZasad
  Left = 310
  Top = 221
  Width = 440
  Height = 380
  Caption = 'Rules of Diaballik'
  Color = clBtnFace
  Constraints.MaxHeight = 380
  Constraints.MaxWidth = 440
  Constraints.MinHeight = 380
  Constraints.MinWidth = 440
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OpisZasad: TMemo
    Left = 16
    Top = 16
    Width = 385
    Height = 313
    Enabled = False
    Lines.Strings = (
      'Based on: http://www.diaballik.com/EN/Rules.html'
      ''
      
        'Goal: Pass your ball to your player at the opponent'#39's side of th' +
        'e board'
      'Team: 7 pawns, one of them holds a ball.'
      ''
      
        'One after the other, players make between 1 and 3 moves and end ' +
        'their turns'
      
        'clicking '#39'End this turn'#39'. During one turn, a player can make up ' +
        'to 2 shifts and up'
      
        'to 1 pass. A pawn can be shifted 1 field forward, backward, left' +
        ' or right as long'
      
        'as the destination field is empty. The pawn that holds a ball ca' +
        'nnot be shifted,'
      
        'but it can pass the ball to another pawn. A pass can be of any l' +
        'ength, but the'
      
        'pawn catching the ball has to be on the same vertical/horizontal' +
        '/diagonal line'
      'as the pawn passing the ball.'
      ''
      
        'There is another way to win a game besides a '#39'touchdown'#39'. If opp' +
        'onent'#39's pawns'
      
        'created a blocking line - i.e. such a line that the player'#39's paw' +
        'ns cannot get to '
      
        'the other side - and at least 3 of the player'#39's pawns '#39'face'#39' opp' +
        'onent'#39's pawns '
      
        '(two pawns face each other if they are in the same column and in' +
        ' two '
      
        'neighbouring rows), then the player would win. If both players c' +
        'reated blocking '
      
        'lines and there are 3 pawns of one player facing pawns of the ot' +
        'her player, then '
      'the player who made the last move would lose.')
    TabOrder = 0
  end
end
