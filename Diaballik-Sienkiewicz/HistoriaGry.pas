{Unit progamu Diaballik.
Obs�uga ekranu umo�liwiaj�cego prz�gladanie historii rozgrywki.}

unit HistoriaGry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TEkranHistorii = class(TForm)
    NapisHistoriaZawiera : TLabel;
    NapisRuchow : TLabel;
    WpiszLiczbaRuchow : TEdit;
    NapisPrezentowanaSytuacja : TLabel;
    WpiszNumerRuchu : TEdit;
    NapisRuchach : TLabel;
    GuzikSkocz1Tyl : TButton;
    GuzikSkocz1Przod : TButton;
    GuzikSkoczTyl : TButton;
    GuzikSkoczPrzod : TButton;
    WpiszSkokTyl : TEdit;
    WpiszSkokPrzod : TEdit;
    GuzikOdtwarzaj : TButton;
    GuzikZatrzymaj : TButton;
    PlanszaHistoria : TStringGrid;
    NapisNazwaGracza1 : TLabel;
    NapisNazwaGracza2 : TLabel;
    GuzikSkoczDoPoczatku : TButton;
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure PlanszaHistoriaDrawCell(Sender : TObject; ACol, ARow : Integer;
                                      Rect : TRect; State : TGridDrawState);
    procedure GuzikSkocz1TylClick(Sender : TObject);
    procedure GuzikSkocz1PrzodClick(Sender : TObject);
    procedure GuzikSkoczTylClick(Sender : TObject);
    procedure GuzikSkoczPrzodClick(Sender : TObject);
    procedure GuzikZatrzymajClick(Sender : TObject);
    procedure GuzikOdtwarzajClick(Sender : TObject);
    procedure GuzikSkoczDoPoczatkuClick(Sender : TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranHistorii : TEkranHistorii;


implementation

uses
  GlownyEkran;

{$R *.dfm}

const
  {czas pomiedzy odtworzeniem kolejnych ruchow}
  OPOZNIENIE=500;
  
var
  {ustawienie pionkow na planszy w ekranie historii}
  PionkiHistoria : TabPlansza;
  {numer ruchu, po ktorym obecie pokazywana jest sytuacja}
  NumerRuchu : Longint;
  {wskaznik ktorym sie przesuwamy po liscie z historia}
  ObecnyRuch : Lista;
  {Zmienne kontrolujace to czy odtwarzana jest gra i czy kliknieto 'Zatrzymaj'}
  Odtwarzamy, Zatrzymano : Boolean;





//procedury pomocnicze


{przesuwa pokazywana sytuacje o Skok w historii i atualizuje NumerRuchu}
procedure Skocz(Skok : Longint);
var
  i : Longint;
begin
  {przesuwamy sie o Skok w historii}
  if Skok=0 then
    Exit;
  for i:=1 to abs(Skok) do
    if Skok>0 then
      begin
        ObecnyRuch:=ObecnyRuch.Nast;
        ZamienPola(ObecnyRuch.Wiersz1,ObecnyRuch.Kol1,ObecnyRuch.Wiersz2,
                   ObecnyRuch.Kol2,PionkiHistoria);
      end
    else
      begin
        ZamienPola(ObecnyRuch.Wiersz1,ObecnyRuch.Kol1,ObecnyRuch.Wiersz2,
                   ObecnyRuch.Kol2,PionkiHistoria);
        ObecnyRuch:=ObecnyRuch.Poprz;
      end;

  {aktualizacja numeru ruchu, po ktorym pokazywana jest sytuacja i planszy}
  NumerRuchu:=NumerRuchu+Skok;
  EkranHistorii.WpiszNumerRuchu.Text:=IntToStr(NumerRuchu);
  EkranHistorii.PlanszaHistoria.Repaint;
end;


{pomaga obsluzyc okienka, w ktore uzytkownik wpisuje o ile chce skoczyc}
procedure SkoczWielokrotnie(Napis : String; Odwroc : Boolean);
var
  Skok, Kod : Longint;
begin
  Val(Napis,Skok,Kod);
  if Kod<>0 then
    begin
      ShowMessage('Drogi graczu, to nie jest liczba ca�kowita.');
      Exit;
    end;
  if Odwroc then Skok:=Skok*(-1);
  if (NumerRuchu+Skok>LicznikRuchow) or (NumerRuchu+Skok<0) then
      ShowMessage('Takim skokiem wyszliby�my poza histori� gry.')
  else
    Skocz(Skok)
end;


{blokowanie guzikow, ktoe maja byc nieaktywne w trakcie odtwarzania rozgrywki}
procedure ZablokujGuziki();
begin
  EkranHistorii.GuzikSkocz1Przod.Enabled:=false;
  EkranHistorii.GuzikSkocz1Tyl.Enabled:=false;
  EkranHistorii.GuzikSkoczPrzod.Enabled:=false;
  EkranHistorii.GuzikSkoczTyl.Enabled:=false;
  EkranHistorii.GuzikSkoczDoPoczatku.Enabled:=false;
end;


{uaktywnienie guzikow, ktore sa blokowane w trakcie odtwarzania rozgrywki}
procedure UaktywnijGuziki();
begin
  EkranHistorii.GuzikSkocz1Przod.Enabled:=true;
  EkranHistorii.GuzikSkocz1Tyl.Enabled:=true;
  EkranHistorii.GuzikSkoczPrzod.Enabled:=true;
  EkranHistorii.GuzikSkoczTyl.Enabled:=true;
  EkranHistorii.GuzikSkoczDoPoczatku.Enabled:=true;
end;





//procedury odpowiedzialne za to co sie dzieje gdy ekran sie pojawia/znika i
//za rysowanie planszy

{pobiera dane z glownego ekranu do przegladania historii, uaktywnia guziki
w ekranie historii, ustawia wejsciowe wartosci zmiennych}
procedure TEkranHistorii.FormShow(Sender : TObject);
var
  i, j : ShortInt;
begin
  EkranGlowny.Enabled:=false;

  {pobieramy dane do przegladania historii}
  for i:=0 to WYMIAR do
    for j:=0 to WYMIAR do
      PionkiHistoria[i,j]:=PionkiObecnie[i,j];
  NapisNazwaGracza1.Caption:=EkranGLowny.NapisNazwaGracza1.Caption;
  NapisNazwaGracza2.Caption:=EkranGLowny.NapisNazwaGracza2.Caption;
  NumerRuchu:=LicznikRuchow;
  WpiszNumerRuchu.Text:=IntToStr(NumerRuchu);
  WpiszLiczbaRuchow.Text:=IntToStr(NumerRuchu);
  ObecnyRuch:=Historia;

  {uaktywniamy guziki w ekranie historii, ustawiamy wejsciowe wartosci zmiennych}
  UaktywnijGuziki();
  WpiszSkokPrzod.Text:='0';
  WpiszSkokTyl.Text:='0';
  Odtwarzamy:=false;
  Zatrzymano:=false;
end;


{uaktywnia glowny ekran}
procedure TEkranHistorii.FormClose(Sender : TObject; var Action: TCloseAction);
begin
  EkranGlowny.Enabled:=true;
end;


{uzywajac pomocniczej procedury, rysuje plansze w ekranie histori}
procedure TEkranHistorii.PlanszaHistoriaDrawCell(Sender : TObject; ACol, ARow
                                                 : Integer; Rect: TRect; State
                                                 : TGridDrawState);
begin
  RysujKomorkePlanszy(ACol,ARow,Rect,PlanszaHistoria,PionkiHistoria);
end;




//Procedury obslugujace guziki do skakania przod/tyl po historii

procedure TEkranHistorii.GuzikSkocz1TylClick(Sender : TObject);
begin
  if NumerRuchu>0 then Skocz(-1)
  else ShowMessage('To ju� jest sytuacja pocz�tkowa.');
end;


procedure TEkranHistorii.GuzikSkocz1PrzodClick(Sender : TObject);
begin
  if NumerRuchu<LicznikRuchow then
    Skocz(1)
  else
    ShowMessage('To ju�  jest sytuacja po ostatnim ruchu w historii.');
end;


procedure TEkranHistorii.GuzikSkoczTylClick(Sender : TObject);
var
  Odwroc : Boolean;
begin
  Odwroc:=true;
  SkoczWielokrotnie(WpiszSkokTyl.Text,Odwroc)
end;


procedure TEkranHistorii.GuzikSkoczPrzodClick(Sender : TObject);
var
  Odwroc : Boolean;
begin
   Odwroc:=false;
   SkoczWielokrotnie(WpiszSkokPrzod.Text,Odwroc)
end;





// Procedury obslugujace guziki zwiazane z odtwarzaniem rozgrywki (i skoczeniem
// do poczatku rozgrywki)

procedure TEkranHistorii.GuzikZatrzymajClick(Sender : TObject);
begin
  if Odtwarzamy then
    begin
      Zatrzymano:=true;
      UaktywnijGuziki();
    end
end;


procedure TEkranHistorii.GuzikOdtwarzajClick(Sender : TObject);
var
  i : Longint;
begin
  if NumerRuchu=LicznikRuchow then
    begin
      ShowMessage('Cofnij si� w historii, by by�o co� do odtwarzania;)');
      Exit;
    end;
  Odtwarzamy:=true;
  ZablokujGuziki();
  for i:=NumerRuchu+1 to LicznikRuchow do
    begin
      Application.ProcessMessages;
      if not EkranHistorii.Showing then
        Exit;
      if Zatrzymano then
        begin
          Odtwarzamy:=false;
          Zatrzymano:=false;
          Exit;
        end;
      Skocz(1);
      Sleep(OPOZNIENIE);
    end;
  Odtwarzamy:=false;
  UaktywnijGuziki();
end;


procedure TEkranHistorii.GuzikSkoczDoPoczatkuClick(Sender : TObject);
var
  Pom : Longint;
begin
  Pom:=StrToInt(WpiszNumerRuchu.Text);
  if Pom=0 then
    ShowMessage('Bardziej do pocz�tku to ju� nie skoczymy;)')
  else
    Skocz(-Pom)
end;

end.
