object EkranZasad: TEkranZasad
  Left = 512
  Top = 227
  Width = 440
  Height = 380
  Caption = 'Zasady gry Diaballik'
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
    Left = 24
    Top = 16
    Width = 377
    Height = 313
    Enabled = False
    Lines.Strings = (
      'Na podstawie zasad ze strony '
      'http://www.diaballik.com/EN/Rules.html'
      '(tam te'#380' znajduj'#261' si'#281' ilustracje, je'#347'li by'#322'yby komu'#347' potrzebne).'
      ''
      'Cel gry: doprowadzi'#263' swoj'#261' pi'#322'k'#281' do linii startowej przeciwnika.'
      'Dru'#380'yna gracza: 7 pionk'#243'w, z czego jeden trzyma pi'#322'k'#281'.'
      ''
      
        'Gracze na zmian'#281' wykonuj'#261' od 1 do 3 ruch'#243'w i naciskaj'#261'c '#39'Zako'#324'cz' +
        ' Kolejk'#281#39
      
        'ko'#324'cz'#261' swoj'#261' kolejk'#281'. W jednej kolejce gracz ma dost'#281'pne dwa prz' +
        'esuni'#281'cia'
      
        'oraz jedno podanie. Przesun'#261#263' pionek mo'#380'na w prz'#243'd, ty'#322' albo w b' +
        'ok o 1 pole'
      
        '(o ile pole, na kt'#243're przesuni'#281'ty ma by'#263' pionek, jest puste). Pi' +
        'onek, kt'#243'ry ma '
      
        'pi'#322'k'#281', nie mo'#380'e by'#263' przesuni'#281'ty, ale mo'#380'e wykona'#263' podanie do inn' +
        'ego pionka.'
      
        'Podanie mo'#380'e by'#263' dowolnej d'#322'ugo'#347'ci, o ile jest po prostej lub pr' +
        'zek'#261'tnej i na '
      'drodze podania nie ma pionk'#243'w przeciwnika.'
      ''
      
        'Wygra'#263' mo'#380'na nie tylko doprowadzaj'#261'c pi'#322'k'#281' do linii startowej pr' +
        'zeciwnika'
      
        '(wykonuj'#261'c '#39'przy'#322'o'#380'enie'#39'). Je'#347'li pionki przeciwnika tworz'#261' lini'#281 +
        ' blokuj'#261'ca - tzn.'
      
        'tak'#261', na kt'#243'rej drug'#261' stron'#281' pionek gracza nie mo'#380'e si'#281' przedost' +
        'a'#263' - i 3 pionki'
      
        'gracza zetk'#261' si'#281' '#39'twarzami'#39'  z pionkami przeciwnika (pionki si'#281' ' +
        'stykaj'#261' je'#347'li s'#261' w'
      
        'tej samej kolumnie i w kolejnych dw'#243'ch wierszach)  to gracz wygr' +
        'ywa. Je'#347'li'
      
        'obaj gracze stworzyli linie blokuj'#261'ce i pionki si'#281' zetkn'#281#322'y to p' +
        'rzegrywa gracz,'
      'kt'#243'ry wykonywa'#322' obecnie ruchy.')
    TabOrder = 0
  end
end
