{G³ówny unit programu Diaballik.
Kod programu podzielony jest na unity odpowiadaj¹ce oknom wyœwietlanym na
ekranie.
GlownyEkran - obs³uga g³ównego ekranu gry i komunikacji z pozosta³ymi
HistoriaGry - obs³uga ekranu umo¿liwiaj¹cego przêgladanie historii rozgrywki
Edycja - obs³uga ekranu z edytorem biê¿¹cego stanu gry
Wczytywanie, Zapisywanie - ekrany tym czynnoœciom s³u¿ace
Pomoc_Edytor_Historia, Pomoc_Zasady - ekrany z tesktami z pomoc¹ na dany temat

Dodatkowo jest jeszcze unit zawieraj¹cy algorytmy u¿ywane do wyliczenia ruchów
komputerowego gracza oraz podania u¿ytownika hinta - Algorytmy_Komputera

Co do konwencji zapisu:
1. je¿eli wymieniam zmienne danego typu to po ',' jest spacja, w innych
   przypadkach(jak po przecinkach miêdzy argumentami, gdy wywo³ujê procedurê)
   spacji nie ma.
2. komentarze zaczynaj¹ce siê od // kod na sekcje procedur (pogrupowa³em w
   czêœci unitów w ten sposób procedury, by ³atwiej by³o siê odnaleŸæ), a
   komentarze typu zaczynaj¹ce siê od { s³u¿¹ do typowego komenotowania.

Autor : Micha³ Sienkiewicz
Ostatnia aktualizacja : 19/06/2013}

unit GlownyEkran;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Menus, ExtCtrls, Grids, jpeg;

const
  {wymiar planszy gry (wierze i kol numerowne 0...WYMIAR), oznaczenia pionkow
   graczy 1 i 2 na tablicy przechowujacej plansze}
  WYMIAR=6;
  MAX_RUCHOW=3;
  PION_1='1';
  PION_2='2';
  PILKA_1='p';
  PILKA_2='q';
  {polozenie pionka wzgledem lewego gornego rogu jego pola}
  POZYCJA=13;
  {stale potrzebne by RysujKomorkePlanszy wiedziala gdzie rysowac pionki}
  SKOK_WIERSZ=51;
  SKOK_KOL=51;
  {teksty wyswietlane graczowi}
  MA_PODANIE='1 pass remaining.';
  NIE_MA_PODAN='No passes remaining.!';
  CZLOWIEK_1='Human1';
  CZLOWIEK_2='Human2';
  KOMPUTER_1='Computer1';
  KOMPUTER_2='Computer2';

type
  TEkranGlowny = class(TForm)
    MenuGlowne : TMainMenu;
    MenuZapiszWczytaj : TMenuItem;
    MenuEdytor : TMenuItem;
    GuzikEdytor : TMenuItem;
    MenuHistoria : TMenuItem;
    MenuPomoc : TMenuItem;
    GuzikZasady : TMenuItem;
    GuzikEdycjaHistoria : TMenuItem;
    GuzikHistoria : TMenuItem;
    GuzikZapisz : TMenuItem;
    GuzikWczytaj : TMenuItem;
    GuzikZagraj : TButton;
    Plansza : TStringGrid;
    NapisWybierzTryb : TLabel;
    NapisI : TLabel;
    ListaWyborTrybu : TComboBox;
    NapisBiezacyGracz : TLabel;
    WpiszBiezacyGracz : TEdit;
    GuzikUsunRuchy : TButton;
    GuzikZakonczKolejke : TButton;
    NapisNazwaGracza1 : TLabel;
    NapisNazwaGracza2 : TLabel;
    NapisA : TLabel;
    NapisB1 : TLabel;
    NapisC : TLabel;
    NapisD : TLabel;
    NapisE : TLabel;
    NapisF : TLabel;
    NapisG : TLabel;
    Napis1 : TLabel;
    Napis2 : TLabel;
    Napis3 : TLabel;
    Napis4 : TLabel;
    Napis5 : TLabel;
    Napis6 : TLabel;
    Napis7 : TLabel;
    Ramka : TShape;
    NapisWybraneRuchy : TLabel;
    Napis1_Z : TLabel;
    NapisDO1 : TLabel;
    Napis2_Z : TLabel;
    NapisDO2 : TLabel;
    Napis3_Z : TLabel;
    NapisDO3 : TLabel;
    WpiszRuch1_1 : TEdit;
    WpiszRuch1_2 : TEdit;
    WpiszRuch2_1 : TEdit;
    WpiszRuch3_1 : TEdit;
    WpiszRuch2_2 : TEdit;
    WpiszRuch3_2 : TEdit;
    GuzikHint : TButton;
    GuzikX1 : TButton;
    GuzikX2 : TButton;
    GuzikX3 : TButton;
    NapisPodania : TLabel;
    GuzikZatrzymajKomputer : TButton;
    GuzikWznowKomputer : TButton;
    {obs³uga guzików menu}
    procedure GuzikEdytorClick(Sender : TObject);
    procedure GuzikZasadyClick(Sender : TObject);
    procedure GuzikEdycjaHistoriaClick(Sender : TObject);
    procedure GuzikZapiszClick(Sender : TObject);
    procedure GuzikWczytajClick(Sender : TObject);
    procedure GuzikHistoriaClick(Sender : TObject);
    {procedury pozosta³e}
    procedure GuzikZagrajClick(Sender : TObject);
    procedure GuzikUsunRuchyClick(Sender : TObject);
    procedure PlanszaMouseDown(Sender : TObject; Button : TMouseButton;
                               Shift : TShiftState; X, Y : Integer);
    procedure PlanszaDrawCell(Sender : TObject; ACol, ARow : Integer;
                              Rect : TRect; State : TGridDrawState);
    procedure FormCreate(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure GuzikX1Click(Sender : TObject);
    procedure GuzikX2Click(Sender : TObject);
    procedure GuzikX3Click(Sender : TObject);
    procedure GuzikZakonczKolejkeClick(Sender : TObject);
    procedure GuzikWznowKomputerClick(Sender : TObject);
    procedure GuzikZatrzymajKomputerClick(Sender : TObject);
    procedure GuzikHintClick(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  {typ potrzebny by przechowywac uklad pionkow na planszy}
  TabPlansza=array[0..WYMIAR,0..WYMIAR] of Char;
  {typy potrzebne by przechowywac ruchy gracza wybrane w danej kolejce}
  RekordRuch=record
               Uzyty : Boolean;
               Wiersz1, Kol1, Wiersz2, Kol2 : ShortInt;
             end;
  TabRuchy=array[1..MAX_RUCHOW] of RekordRuch;
  {typy potrzebne by przechowywac historie gry jako liste ruchow}
  Lista=^ElemListy;
  ElemListy=record
              Poprz,Nast : Lista;
              Wiersz1,Kol1,Wiersz2,Kol2 : ShortInt;
            end;

procedure ZamienPola(const Wiersz1, Kol1, Wiersz2, Kol2 : ShortInt;
                     var Pionki : TabPlansza);
procedure RysujKomorkePlanszy(ACol, ARow : Integer; var Rect : TRect;
                              var  Plansza : TStringGrid; Pionki : TabPlansza);
procedure PrzygotujKomponentyUruchomKomputer();
procedure PrzygotujZmienneIStruktury();
function CzyWygrana(Gracz: ShortInt; Pionki : TabPlansza) : Boolean;
function CzyWygranaPrzezBlokade(Gracz : ShortInt; Pionki : TabPlansza;
                                var Linia : Boolean) : Boolean;



var
  EkranGlowny : TEkranGlowny;
  {ustawienie pionkow na planszy}
  PionkiObecnie : TabPlansza;
  {licznik ruchow - potrzebny by mozna bylo przegladac historie wygodnie}
  LicznikRuchow : Longint;
  {lista z historia gry oraz wskaznik na poczatek tej listy - ulatwia zapis}
  Historia, HistoriaPocz : Lista;
  {Gramy - pamieta czy jakas gra jest w toku}
  Gramy : Boolean;
  {tablica z wybranymi przez gracza ruchami}
  ObecneRuchy : TabRuchy;

implementation

uses
  Edycja, Pomoc_Zasady, Pomoc_Edytor_Historia, HistoriaGry, Zapisywanie,
  Wczytywanie, Math, Algorytmy_Komputera;

var
  {zmienna pamietajaca w ktorym ruchu gracz robil podanie - w przypadku
  wycofania przez gracza ruchow, musimy wiedziec czy znowu ma dostepne podanie}
  NrRuchuZPodaniem : ShortInt;
  {bitmapy, na ktore wczytujemy obrazki pionkow}
  ObrazekPionek1, ObrazekPionek2, ObrazekPilka1, ObrazekPilka2 : TBitMap;
  {PoczatekRuchu - pamieta czy nastepnym kliknieciem gracz zacznie/skoczny ruch,
  ByloPodanie - pamieta czy gracz wykorzystal juz podanie}
  PoczatekRuchu, ByloPodanie : Boolean;


{$R *.dfm}





//Procedury pomocnicze - wyodrebnione albo dlatego, ze ich kod by sie powtarzal
//albo po to, aby nie tworzyc monstrualnych konstrukcji kodu


{przygotowuje historie go zapisu gry, tworzy atrape na poczatku historii, by
dopisywanie ruchow zawsze odbywalo sie tak samo}
procedure PrzygotujHistorie();
begin
  {atrapa do listy z historia}
  New(Historia);
  Historia.Poprz:=nil;
  Historia.Nast:=nil;
  HistoriaPocz:=Historia;
end;


{czysci liste z historia}
procedure CzyscHistorie();
var
  Pom : Lista;
begin
  while Historia<>nil do
    begin
      Pom:=Historia;
      Historia:=Historia.Poprz;
      Dispose(Pom);
    end;
end;

{zamienia wspolrzedne pola na opis przystepny uzytkownikowi typu 'B6'}
function WspolNaOpis() : String;
var
  Pom : integer;
  Wiersz : String;
begin
  Pom:=EkranGlowny.Plansza.Row;
  Wiersz:=Chr(Ord('A')+Pom);
  WspolNaOpis:=Wiersz+IntToStr(EkranGlowny.Plansza.Col+1);
end;


{procedura zamieniajaca pionki w danej tablicy przechowujacej uklad pionkow}
procedure ZamienPola(const Wiersz1, Kol1, Wiersz2, Kol2 : ShortInt;
                     var Pionki : TabPlansza);
var Pom : Char;
begin
  Pom:=Pionki[Wiersz1,Kol1];
  Pionki[Wiersz1,Kol1]:=Pionki[Wiersz2,Kol2];
  Pionki[Wiersz2,Kol2]:=Pom;
end;


{sprawdza czy ruch pomiedzy danymi polami jest dozwolony}
function DozwolonyRuch(const NrRuch, Wiersz2, Kol2 : ShortInt; const Pion : Char)
                       : Boolean;
var
  KrokKol, KrokWiersz, RozWiersz, RozKol, Wiersz1, Kol1, i : ShortInt;
  Znaczek : Char;
begin
  {wyliczenie zmiennych pomocniczych}
  Wiersz1:=ObecneRuchy[NrRuch].Wiersz1;
  Kol1:=ObecneRuchy[NrRuch].Kol1;
  Znaczek:=PionkiObecnie[Wiersz1,Kol1];

  {sprawdzanie poprawnosci ruchu, gdy jest to przesuniecie pionka - sprawdzamy
   czy pole jest wolne i czy jest obok naszego pionka}
  if Znaczek=Pion then
    if PionkiObecnie[Wiersz2,Kol2]<>' ' then
      DozwolonyRuch:=false
    else
      DozwolonyRuch:=(abs(Wiersz1-Wiersz2)+abs(Kol1-Kol2)=1)

  {sprawdzanie poprawnosci ruchu, gdy jest to podanie pilki}
  else
    {sprawdzamy czy podajemy do swojego pionka}
    if PionkiObecnie[Wiersz2,Kol2]<>Pion then
      DozwolonyRuch:=false
    else
      begin
        DozwolonyRuch:=false;
        RozWiersz:=Wiersz2-Wiersz1;
        RozKol:=Kol2-Kol1;

        {sprawdzamy czy zadany ruch jest po prostej lub przekatnej}
        if abs(RozWiersz)<>abs(RozKol) then
          if not((RozWiersz=0) or (RozKol=0)) then
            Exit;

        {sprawdzamy czy na linii podania nie ma przeciwnikow}
        if RozWiersz=0 then
          KrokWiersz:=0
        else
          KrokWiersz:=RozWiersz div abs(RozWiersz);
        if RozKol=0 then
          KrokKol:=0
        else
          KrokKol:=RozKol div abs(RozKol);
        for i:=1 to max(abs(RozWiersz),abs(RozKol))-1 do
          begin
            Wiersz1:=Wiersz1+KrokWiersz;
            Kol1:=Kol1+KrokKol;
            if not ((PionkiObecnie[Wiersz1,Kol1]=Pion) or
              (PionkiObecnie[Wiersz1,Kol1]=' ')) then
              Exit;
          end;
        DozwolonyRuch:=true;
      end;
end;


{usuniecie danego ruchu z ObecneRuchy i wycofanie go z planszy jesli byl
skonczony (czyli Uzyty=true) - tzn. jesli uzytkownik podal SKAD i DOKAD ma byc
ruch}
procedure CzyscRuch(Nr : ShortInt);
begin
  if ObecneRuchy[Nr].Uzyty then
    begin
      ZamienPola(ObecneRuchy[Nr].Wiersz1,ObecneRuchy[Nr].Kol1,
                 ObecneRuchy[Nr].Wiersz2,ObecneRuchy[Nr].Kol2,PionkiObecnie);
      if ByloPodanie and (NrRuchuZPodaniem=Nr) then
        begin
          ByloPodanie:=false;
          EkranGlowny.NapisPodania.Caption:=MA_PODANIE;
        end;
    end;
  ObecneRuchy[Nr].Uzyty:=false;
  EkranGlowny.Plansza.Repaint;
  PoczatekRuchu:=true;
end;


{sprawdzenie czy dany gracz wygral w sposob klasyczny - przez przylozenie}
function CzyWygrana(Gracz: ShortInt; Pionki : TabPlansza) : Boolean;
var
  Pilka : Char;
  WierszDocelowy, i : ShortInt;
begin
  CzyWygrana:=true;

  {sprawdzamy czy pilka zostala doprowadzona na strone przeciwnika}
  if Gracz=1 then
    begin
      Pilka:=PILKA_1;
      WierszDocelowy:=WYMIAR;
    end
  else
    begin
      Pilka:=PILKA_2;
      WierszDocelowy:=0;
    end;
  for i:=0 to WYMIAR do
    if Pionki[WierszDocelowy,i]=Pilka then
      Exit;

  CzyWygrana:=false;
end;


{sprawdzenie czy dany gracz wygral przez wpadniecie na blokade. Zmienna Linia
mowi czy istnieje w ogole linia blokujaca, ta informacja przydaje sie funkcji
Ocen w algorytmach komputera}
function CzyWygranaPrzezBlokade(Gracz : ShortInt; Pionki : TabPlansza;
                                var Linia : Boolean) : Boolean;
var
  PionGracza, PilkaGracza, PionPrzeciwnika, PilkaPrzeciwnika : Char;
  Sasiedzi, i, Wiersz : ShortInt;
begin
  CzyWygranaPrzezBlokade:=false;
  Linia:=false;

  {wyliczamy zmienne pomocnicze}
  if Gracz=1 then
    begin
      PionGracza:=PION_1;
      PilkaGracza:=PILKA_1;
      PionPrzeciwnika:=PION_2;
      PilkaPrzeciwnika:=PILKA_2;
    end
  else
    begin
      PionGracza:=PION_2;
      PilkaGracza:=PILKA_2;
      PionPrzeciwnika:=PION_1;
      PilkaPrzeciwnika:=PILKA_1;
    end;

  {szukamy pionka przeciwnika w pierwszej kolumnie}
  Wiersz:=WYMIAR+1;
  for i:=0 to WYMIAR do
    if (Pionki[i,0]=PionPrzeciwnika) or
      (Pionki[i,0]=PilkaPrzeciwnika) then
      Wiersz:=i;
  if  Wiersz>WYMIAR then
    Exit;

  {zaczynajac od znalezionego pionka, szukamy linii blokujacej i liczymy pionki
   gracza stykajace sie z nia}
  Sasiedzi:=0;
  for i:=0 to WYMIAR do
    begin
      {liczymy sasiadujace z linia pionki gracza}
      if Wiersz>0 then
        if (Pionki[Wiersz-1,i]=PionGracza) or
          (Pionki[Wiersz-1,i]=PilkaGracza) then
          Inc(Sasiedzi);
      if Wiersz<WYMIAR then
        if (Pionki[Wiersz+1,i]=PionGracza) or
          (Pionki[Wiersz+1,i]=PilkaGracza) then
          Inc(Sasiedzi);
      {szukamy kontynuacji linii w nastepnej kolumnie}
      if i<WYMIAR then
        begin
          if (Pionki[Wiersz,i+1]=PionPrzeciwnika) or
            (Pionki[Wiersz,i+1]=PilkaPrzeciwnika) then
             Continue;
          if Wiersz>0 then
            if (Pionki[Wiersz-1,i+1]=PionPrzeciwnika) or
              (Pionki[Wiersz-1,i+1]=PilkaPrzeciwnika) then
              begin
                Dec(Wiersz);
                Continue;
              end;
          if Wiersz<WYMIAR then
            if (Pionki[Wiersz+1,i+1]=PionPrzeciwnika) or
              (Pionki[Wiersz+1,i+1]=PilkaPrzeciwnika) then
              begin
                Inc(Wiersz);
                Continue;
              end;
          Exit;
        end;
    end;

  Linia:=true;
  if Sasiedzi>=3 then CzyWygranaPrzezBlokade:=true;
end;


{blokujemy komponenty (na czas gry komputera). procedura odwrotna do
UaktywnijKomponenty}
procedure ZablokujKomponenty();
begin
  EkranGlowny.Plansza.Enabled:=false;
  EkranGlowny.GuzikX1.Enabled:=false;
  EkranGlowny.GuzikX2.Enabled:=false;
  EkranGlowny.GuzikX3.Enabled:=false;
  EkranGlowny.GuzikUsunRuchy.Enabled:=false;
  EkranGlowny.GuzikZakonczKolejke.Enabled:=false;
  EkranGlowny.GuzikHint.Enabled:=false;
end;


{uaktywniamy komponenty na czas gry czlowieka, uzywana zarowno po zakonczeniu
kolejki komputera jak i przy rozpoczynaniu rozgrywki. procedura odwrotna do
ZablokujKomponenty}
procedure UaktywnijKomponenty();
begin
  EkranGlowny.Plansza.Enabled:=true;
  EkranGlowny.GuzikX1.Enabled:=true;
  EkranGlowny.GuzikX2.Enabled:=true;
  EkranGlowny.GuzikX3.Enabled:=true;
  EkranGlowny.GuzikUsunRuchy.Enabled:=true;
  EkranGlowny.GuzikZakonczKolejke.Enabled:=true;
  EkranGlowny.GuzikHint.Enabled:=true;
end;


{na wybranej planszy i zgodnie z wybrana tablica pionkow, funkcja ta koloruje
komorki i rysuje pionki uzywajac autorskich rysunkow pionkow}
procedure RysujKomorkePlanszy(ACol, ARow : Integer; var Rect : TRect;
                              var  Plansza : TStringGrid; Pionki : TabPlansza);
var
  Bitmap : TBitMap;
  Znaczek : Char;
begin
  {malujemy tlo pola planszy}
  Plansza.Canvas.Brush.Color:=clSilver;
  Plansza.Canvas.FillRect(Rect);

  {zgodnie z PionkiObecnie rysujemy odpowiedni pionek na danym polu}
  if Gramy then
    begin
      Znaczek:=Pionki[ARow,ACol];
      if (Znaczek=PION_1) or (Znaczek=PION_2) or (Znaczek=PILKA_1) or
        (Znaczek=PILKA_2) then
        begin
          Case Znaczek of
            PION_1 : Bitmap:=ObrazekPionek1;
            PION_2 : Bitmap:=ObrazekPionek2;
            PILKA_1 : Bitmap:=ObrazekPilka1;
            PILKA_2 : Bitmap:=ObrazekPilka2;
          end;
          Plansza.Canvas.Draw(POZYCJA+SKOK_KOL*ACol,POZYCJA+SKOK_WIERSZ*ARow,
                              Bitmap);
        end
    end;
end;


{w zaleznosci od tego kto gra nastepny, blokujemy/uaktywniamy komponenty i ew.
uruchamiamy KolejkaKomputera}
procedure PrzygotujKomponentyUruchomKomputer();
begin
  if (EkranGlowny.WpiszBiezacyGracz.Text=KOMPUTER_1) or
    (EkranGlowny.WpiszBiezacyGracz.Text=KOMPUTER_2) then
    begin
      ZablokujKomponenty();
      EkranGlowny.NapisPodania.Visible:=false;
      KolejkaKomputera();
    end
  else
    begin
      UaktywnijKomponenty();
      EkranGlowny.GuzikZatrzymajKomputer.Enabled:=false;
      EkranGlowny.GuzikWznowKomputer.Enabled:=false;
      EkranGlowny.NapisPodania.Visible:=true;
    end;
end;


{przygotowanie struktur danych i zmiennych do zapisu gry}
procedure PrzygotujZmienneIStruktury();
var
  i : ShortInt;
begin
  Gramy:=true;
  PoczatekRuchu:=true;
  ByloPodanie:=false;
  LicznikRuchow:=0;
  CzyscHistorie();
  PrzygotujHistorie();
  for i:=1 to MAX_RUCHOW do
    ObecneRuchy[i].Uzyty:=false;
  EkranGlowny.GuzikUsunRuchyClick(EkranGlowny.GuzikUsunRuchy);
end;





//Procedury odpowiedzialne za to co sie dzieje przy wlaczeniu/wylaczeniu gry

procedure TEkranGlowny.FormCreate(Sender : TObject);
begin
  {zmienna Gramy mowi o tym czy jakas gra jest rozpoczeta, by wyswietlaly sie
  pionki i mozna bylo wykonywac ruchy Gramy musi byc true. gdy Gramy=true, przy
  probie zagrania w nowa gre wyskakuje ostrzezenie}
  Gramy:=false;
  PrzygotujHistorie();

  {ladowanie obrazkow pionkow}
  ObrazekPionek1:=TBitmap.Create;
  ObrazekPionek1.LoadFromfile('./obrazki/ObrazekPionek1.bmp');
  ObrazekPionek2:=TBitmap.Create;
  ObrazekPionek2.LoadFromfile('./obrazki/ObrazekPionek2.bmp');
  ObrazekPilka1:=TBitmap.Create;
  ObrazekPilka1.LoadFromfile('./obrazki/ObrazekPilka1.bmp');
  ObrazekPilka2:=TBitmap.Create;
  ObrazekPilka2.LoadFromfile('./obrazki/ObrazekPilka2.bmp');

  {uruchamiamy maszyne losujaca uzywaca przez komputerowego gracza}
  randomize;
end;


procedure TEkranGlowny.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  with ObrazekPionek1, ObrazekPionek2, ObrazekPilka1, ObrazekPilka2 do
    Free;
  CzyscHistorie();
  EkranZasad.Free;
  EkranFunkcji.Free;
  EkranHistorii.Free;
  EkranEdytora.Free;
  EkranZapisu.Free;
  EkranWczytywania.Free;
end;





//Glowne procedury odpowiedzialne za logikê dzia³ania g³ównego okna programu


{procedura reagujaca na klikniecie przez uzytkownika na plansze. Jesli uzytkow-
nikowi wolno teraz klikac w plansze (nie gra komputer, gracz ma dostepne
ruchy) i jest to poprawne klikniecie - to jego pionek/pionek moze taki ruch
wykonac to aktualizujemy ObecneRuchy, aktualizujemy plansze i okienka z ruchami}
procedure TEkranGlowny.PlanszaMouseDown(Sender : TObject; Button : TMouseButton;
                                        Shift : TShiftState; X, Y : Integer);
var
  Pom : String;
  Pion, Pilka : Char;
  NrRuch, i : ShortInt;
  Wiersz, Kol : Integer;
begin
  {sprawdzenie czy uzytkownik kliknal lewy przycisk myszy bez shift/ctrl/alt}
  if Shift<>[ssLeft] then
    Exit;

  {sprawdzanie czy uzytkownik 'ma prawo' klikac w plansze obecnie}
  if (not Gramy) or (WpiszBiezacyGracz.Text=KOMPUTER_1) or
    (WpiszBiezacyGracz.Text=KOMPUTER_2)  then
    Exit;

  {sprawdzamy czy jest dostepny ruch}
  NrRuch:=0;
  for i:=1 to MAX_RUCHOW do
    if ObecneRuchy[i].Uzyty=false then
      begin
        NrRuch:=i;
        Break;
      end;
  if NrRuch=0 then
    Exit;

  {ustalamy warotsci pomocniczych zmiennych}
  if WpiszBiezacyGracz.Text=CZLOWIEK_1 then
    begin
      Pion:=PION_1;
      Pilka:=PILKA_1;
    end
  else
    begin
      Pion:=PION_2;
      Pilka:=PILKA_2;
    end;
   Wiersz:=Plansza.Row;
   Kol:=Plansza.Col;

  {Jezeli klikniecie w to konkretne pole jest dozowolone to aktualizujemy
   ObecneRuchy i,jesli to klikniecie finalizujace ruch,to tez ustawienie pionkow}
  if PoczatekRuchu then
    begin
      if (PionkiObecnie[Wiersz,Kol]<>Pion) and (PionkiObecnie[Wiersz,Kol]<>Pilka)
        then
        Exit;
      if PionkiObecnie[Wiersz,Kol]=Pion then
        if (NrRuch=3) and (not ByloPodanie) then
          Exit;
      if (PionkiObecnie[Wiersz,Kol]=Pilka) and ByloPodanie then
        Exit;
      ObecneRuchy[NrRuch].Wiersz1:=Wiersz;
      ObecneRuchy[NrRuch].Kol1:=Kol;
      PoczatekRuchu:=false
    end
  else
    begin
      if not DozwolonyRuch(NrRuch,Wiersz,Kol,Pion) then
        Exit;
      ObecneRuchy[NrRuch].Uzyty:=true;
      ObecneRuchy[NrRuch].Wiersz2:=Wiersz;
      ObecneRuchy[NrRuch].Kol2:=Kol;
      ZamienPola(ObecneRuchy[NrRuch].Wiersz1,ObecneRuchy[NrRuch].Kol1,Wiersz,
                 Kol,PionkiObecnie);
      PoczatekRuchu:=true;
      {jesli wykonano pelny,poprawny ruch, blokujemy  odpowiedni przycisk 'X'
       oraz jesli wykonano podanie to to zapisujemy}
      if NrRuch=2 then GuzikX1.Enabled:=false;
      if NrRuch=3 then GuzikX2.Enabled:=false;
      if PionkiObecnie[Wiersz,Kol]=Pilka then
        begin
          ByloPodanie:=true;
          NrRuchuZPodaniem:=NrRuch;
          NapisPodania.Caption:=NIE_MA_PODAN;
        end;
    end;

  {wpisujemy wspolrzednie kliknietego pola w odpowiednie okienko na ekranie}
  Pom:=WspolNaOpis();
  if WpiszRuch1_1.Text='' then
    WpiszRuch1_1.Text:=Pom
  else if WpiszRuch1_2.Text='' then
    WpiszRuch1_2.Text:=Pom
  else if WpiszRuch2_1.Text='' then
    WpiszRuch2_1.Text:=Pom
  else if WpiszRuch2_2.Text='' then
    WpiszRuch2_2.Text:=Pom
  else if WpiszRuch3_1.Text='' then
    WpiszRuch3_1.Text:=Pom
  else if WpiszRuch3_2.Text='' then
    WpiszRuch3_2.Text:=Pom;

  Plansza.Repaint;
end;


{uzywajac pomocniczej funkcji RysujKomorkePlanszy, rysuje plansze gry}
procedure TEkranGlowny.PlanszaDrawCell(Sender : TObject; ACol, ARow : Integer;
                                       Rect : TRect; State : TGridDrawState);
begin
  RysujKomorkePlanszy(ACol,ARow,Rect,Plansza,PionkiObecnie);
end;


{procedura rozpoczynajaca rozgrywke w wybranym trybie. przygotowuje struktury
do zapisu gry, ustawia standardowy poczatkowy uklad pionkow, aktualizuje napisy
z nazwami graczy + uaktywnienie/blokada odpowiednich komponentow zaleznie czy
nastepny gra czlowiek/komputer}
procedure TEkranGlowny.GuzikZagrajClick(Sender: TObject);
var
  i,j : Integer;
begin
  {sprawdzenie poprawnosci trybu i czy uzytkownik na pewno chce nowa gre}
  if ListaWyborTrybu.ItemIndex=-1 then
    begin
      ShowMessage('Invalid Mode!!');
      Exit;
    end
  else if Gramy then
    if MessageDlg('Current game will be lost!', mtConfirmation,
      [mbOk,mbCancel], 0) = mrCancel   then
      Exit;

  {przygotowanie struktur danych i zmiennych do zapisu gry}
  PrzygotujZmienneIStruktury();

  {standardowe ropoczecie}
  for i:=0 to WYMIAR do
    begin
      PionkiObecnie[0,i]:=PION_1;
      for j:=1 to WYMIAR-1 do
        PionkiObecnie[j,i]:=' ';
      PionkiObecnie[WYMIAR,i]:=PION_2;
    end;
  PionkiObecnie[0,WYMIAR div 2]:=PILKA_1;
  PionkiObecnie[WYMIAR,WYMIAR div 2]:=PILKA_2;
  Plansza.Repaint;


  {uzupelnienie nazw graczy i biezacego gracza}
  Case ListaWyborTrybu.ItemIndex of
    0 : begin
          NapisNazwaGracza1.Caption:=CZLOWIEK_1;
          NapisNazwaGracza2.Caption:=CZLOWIEK_2;
          WpiszBiezacyGracz.Text:=CZLOWIEK_1
        end;
    1 : begin
          NapisNazwaGracza1.Caption:=CZLOWIEK_1;
          NapisNazwaGracza2.Caption:=KOMPUTER_2;
          WpiszBiezacyGracz.Text:=CZLOWIEK_1
        end;
    2 : begin
          NapisNazwaGracza1.Caption:=KOMPUTER_1;
          NapisNazwaGracza2.Caption:=CZLOWIEK_2;
          WpiszBiezacyGracz.Text:=KOMPUTER_1
        end;
    3 : begin
          NapisNazwaGracza1.Caption:=KOMPUTER_1;
          NapisNazwaGracza2.Caption:=KOMPUTER_2;
          WpiszBiezacyGracz.Text:=KOMPUTER_1
        end;
  end;

  {w zaleznosci od tego kto gra nastepny, blokujemy/uaktywniamy komponenty i ew.
   uruchamiamy KolejkaKomputera}
  PrzygotujKomponentyUruchomKomputer();
end;


{procedura wykonujaca czynnosci finalizujace kolejke - aktualizacja historii,
sprawdzanie czy jest zwyciezca, czyszczenie ObecneRuchy i okienek, aktualizacja
zmiennych typu LicznikRuchow,ByloPodanie,PoczatekRuchu, uaktywnienie/blokada
odpowiednich komponentow zaleznie czy nastepny gra czlowiek/komputer}
procedure TEkranGlowny.GuzikZakonczKolejkeClick(Sender : TObject);
var
  IleRuchow, i, Gracz, Przeciwnik : ShortInt;
  Pom : Lista;
  NazwaGracz, NazwaPrzeciwnik : String;
  Linia : Boolean;
begin
  {liczymy wykonane ruchy}
  IleRuchow:=0;
  for i:=1 to MAX_RUCHOW do
    if ObecneRuchy[i].Uzyty then Inc(IleRuchow);
  if IleRuchow=0 then
    begin
      ShowMessage('No moves have been made!');
      Exit;
    end;

  {aktualizacja historii ruchow}
  Inc(LicznikRuchow,IleRuchow);
  for i:=1 to IleRuchow do
    begin
       New(Pom);
       Pom.Poprz:=Historia;
       Historia.Nast:=Pom;
       Historia:=Pom;
       Historia.Nast:=nil;
       Historia.Wiersz1:=ObecneRuchy[i].Wiersz1;
       Historia.Kol1:=ObecneRuchy[i].Kol1;
       Historia.Wiersz2:=ObecneRuchy[i].Wiersz2;
       Historia.Kol2:=ObecneRuchy[i].Kol2;
    end;

  {sprawdzamy czy jest zwyciezca}
  if (WpiszBiezacyGracz.Text=CZLOWIEK_1) or (WpiszBiezacyGracz.Text=KOMPUTER_1)
    then
    begin
      Gracz:=1;
      NazwaGracz:=NapisNazwaGracza1.Caption;
      Przeciwnik:=2;
      NazwaPrzeciwnik:=NapisNazwaGracza2.Caption;
    end
  else
    begin
      Gracz:=2;
      NazwaGracz:=NapisNazwaGracza2.Caption;
      Przeciwnik:=1;
      NazwaPrzeciwnik:=NapisNazwaGracza1.Caption;
    end;
    
  if CzyWygrana(Gracz,PionkiObecnie) then
    begin
      ShowMessage('Touchdown! The winner is '+NazwaGracz+' !!');
      ZablokujKomponenty;
      Exit;
    end;
  if CzyWygranaPrzezBlokade(Przeciwnik,PionkiObecnie,Linia) then
    begin
      ShowMessage(NazwaGracz+' created a blocking line! The winner is '+
                  NazwaPrzeciwnik+' !!');
      ZablokujKomponenty();
      Exit;
    end;
  if CzyWygranaPrzezBlokade(Gracz,PionkiObecnie,Linia) then
    begin
      ShowMessage(NazwaGracz+' encountered a blocking line! The winner is '+
                  NazwaGracz+' !!');
      ZablokujKomponenty();
      Exit;
    end;

  {zmieniamy biezacego gracza,czyscimy ObecneRuchy,okienka z ruchami,
   aktualizujemy zmienne}
  if WpiszBiezacyGracz.Text=NapisNazwaGracza1.Caption then
     WpiszBiezacyGracz.Text:=NapisNazwaGracza2.Caption
  else
    WpiszBiezacyGracz.Text:=NapisNazwaGracza1.Caption;
  for i:=1 to IleRuchow do
    ObecneRuchy[i].Uzyty:=false;
  GuzikUsunRuchyClick(Sender);
  PoczatekRuchu:=true;
  ByloPodanie:=false;
  NapisPodania.Caption:=MA_PODANIE;

  {w zaleznosci od tego kto gra nastepny, blokujemy/uaktywniamy komponenty i ew.
   uruchamiamy KolejkaKomputera}
  PrzygotujKomponentyUruchomKomputer();
end;





//procedury obs³uguj¹ce przyciski czyszcz¹ce ruchy

procedure TEkranGlowny.GuzikX1Click(Sender: TObject);
begin
  WpiszRuch1_1.Text:='';
  WpiszRuch1_2.Text:='';
  CzyscRuch(1);
end;

procedure TEkranGlowny.GuzikX2Click(Sender: TObject);
begin
  WpiszRuch2_1.Text:='';
  WpiszRuch2_2.Text:='';
  CzyscRuch(2);
  GuzikX1.Enabled:=true;
end;

procedure TEkranGlowny.GuzikX3Click(Sender: TObject);
begin
  WpiszRuch3_1.Text:='';
  WpiszRuch3_2.Text:='';
  CzyscRuch(3);
  GuzikX2.Enabled:=true;
end;

procedure TEkranGlowny.GuzikUsunRuchyClick(Sender: TObject);
begin
  GuzikX3Click(Sender);
  GuzikX2Click(Sender);
  GuzikX1Click(Sender);
end;





//Procedury obs³uguj¹ce guziki menu glownego (na gorze okna), ktore
//umo¿liwiaj¹ dostep do reszty funkcji programu (edytor, historia itd.)

procedure TEkranGlowny.GuzikEdytorClick(Sender : TObject);
begin
  if not Gramy then
    begin
      ShowMessage('Run a game and then use the editor!');
      Exit;
    end;
  EkranEdytora.Visible:=true;
end;

procedure TEkranGlowny.GuzikZasadyClick(Sender : TObject);
begin
  EkranZasad.Visible:=true;
end;

procedure TEkranGlowny.GuzikEdycjaHistoriaClick(Sender : TObject);
begin
  EkranFunkcji.Visible:=true;
end;

procedure TEkranGlowny.GuzikZapiszClick(Sender : TObject);
begin
  if not Gramy then
    begin
      ShowMessage('You need to play first to have something to save.');
      Exit;
    end;
  EkranZapisu.Visible:=true;
end;

procedure TEkranGlowny.GuzikWczytajClick(Sender: TObject);
begin
  EkranWczytywania.Visible:=true;
end;

procedure TEkranGlowny.GuzikHistoriaClick(Sender: TObject);
begin
  if not Gramy then
    begin
      ShowMessage('Play first and then replay!');
      Exit;
    end;
  EkranHistorii.Visible:=true;
end;





// procedury obslugujace przyciski zwiazane z algorytmami komputera

procedure TEkranGlowny.GuzikWznowKomputerClick(Sender: TObject);
begin
  KolejkaKomputera();
end;

procedure TEkranGlowny.GuzikZatrzymajKomputerClick(Sender: TObject);
begin
  KomputerGraj:=false;
  GuzikWznowKomputer.Enabled:=true;
end;

procedure TEkranGlowny.GuzikHintClick(Sender: TObject);
begin
  if (WpiszBiezacyGracz.Text=KOMPUTER_1) or
    (WpiszBiezacyGracz.Text=KOMPUTER_2) then
    begin
      ShowMessage('The player is a computer. Hints are for human players.');
      Exit;
    end
  else if MessageDlg('The computer will suggest moves that you can make during'
    +' your turn. As a "punishment", the application may not respond to clicks'+
    ' for a momemnt. Ok?', mtConfirmation, [mbOk,mbCancel], 0) = mrCancel
    then
    Exit;

  {komputer wylicza ruchy dla gracza i wypisuje je za pomoca ShowMessage}
  DajHinta();
end;

end.
