{Unit progamu Diaballik.
Unit zawieraj�cy algorytmy u�ywane do wyliczenia ruch�w komputerowego gracza
oraz podania u�ytownika hinta.}

unit Algorytmy_Komputera;

interface

uses
  SysUtils, Forms, Dialogs;

procedure KolejkaKomputera();
procedure DajHinta();  

var
  {zmienna, ktora kontrolujemy czy komputer ma obliczac i grac dalej czy gracz
  nacisnal 'Zatrzymaj' i mamy przerwac obliczenia}
  KomputerGraj : Boolean;

implementation

uses
  GlownyEkran, Math;

const
  {czas pomiedzy wykonywaniem kolejnych ruchow przez komputer}
  PRZERWA_MIEDZY_RUCHAMI=800;
  {liczba zamian pionkow w tablicy MojePionki po wyszukaniu ich na planszy
   - powoduje ich losowe ustawienie w tablicy i wprowadza pewna okreslona
   losowosc w ruchach komputera - zeby np. nie ruszal do przodu ciagle pionka
   pierwszego od lewej, bo go pierwszego znajdzie tylko rozne}
  LICZBA_LOSOWAN=150;
  {skrajne wartosci oceny sytuacji na planszy}
  PRZEGRANA=-1000;
  WYGRANA=1000;
  NIE_MA_RUCHU=-2000;
  {stala sluzaca zmuszeniu komputera, by, po wykonaniu pewnej liczby ruchow,
   w nastepnych ruchach dbal o to, zeby nie przegrac przez blokade}
  OGRANICZENIE_ANTYBLOKADOWE=10;
  {o tyle bardziej wartosciowa jest pilka w danym wierszu niz zwykly pionek}
  MNOZNIK_ZA_PILKE=3;





//procedury blokujace i odblokowujace czesci interfejsu w czasie kolejki
//komputera (guzik Zatrzymaj wtedy odblokowuje)

procedure ZablokujMenuIZagraj();
begin
  EkranGlowny.MenuZapiszWczytaj.Enabled:=false;
  EkranGlowny.MenuEdytor.Enabled:=false;
  EkranGlowny.MenuHistoria.Enabled:=false;
  EkranGlowny.MenuPomoc.Enabled:=false;
  EkranGlowny.GuzikZagraj.Enabled:=false;
end;

procedure OdblokujMenuIZagraj();
begin
  EkranGlowny.MenuZapiszWczytaj.Enabled:=true;
  EkranGlowny.MenuEdytor.Enabled:=true;
  EkranGlowny.MenuHistoria.Enabled:=true;
  EkranGlowny.MenuPomoc.Enabled:=true;
  EkranGlowny.GuzikZagraj.Enabled:=true;
end;





//procedury pomocnicze do KolejkaKomputera (oprocz SzukajRuchu-osobna sekcja)

{inicjalizujemy zmienne, kopiujemy obecny uklad pionkow - przy czym
je�li biezacy gracz to nie CZLOWIEK_1/KOMPUTER_1 to odwracamy uklad pionkow
by to zasymulowac - ulatwia obliczenia jesli zawsze zakladamy ze gra Gracz1}
procedure Przygotowanie(var Podalem : Boolean; var Gracz, NumerRuchu : ShortInt;
                        var Sytuacja : Longint; var PionkiKopia : TabPlansza);
var
  i, j : ShortInt;
begin
  {inicjalizacja zmiennych}
  Sytuacja:=PRZEGRANA;
  NumerRuchu:=0;
  Podalem:=false;

  {sprawdzamy kto gra i na tej podstawie robimy odpowiednia kopie PionkiObecnie}
  if (EkranGlowny.WpiszBiezacyGracz.Text=CZLOWIEK_1) or
    (EkranGlowny.WpiszBiezacyGracz.Text=KOMPUTER_1) then
    Gracz:=1
  else
    Gracz:=2;
  if Gracz=1 then
    for i:=0 to WYMIAR do
      for j:=0 to WYMIAR do
        PionkiKopia[i,j]:=PionkiObecnie[i,j]
  else
    for i:=0 to WYMIAR do
      for j:=0 to WYMIAR do
        if PionkiObecnie[i,j]=PION_1 then
          PionkiKopia[WYMIAR-i,j]:=PION_2
        else if PionkiObecnie[i,j]=PION_2 then
          PionkiKopia[WYMIAR-i,j]:=PION_1
        else if PionkiObecnie[i,j]=PILKA_1 then
          PionkiKopia[WYMIAR-i,j]:=PILKA_2
        else if PionkiObecnie[i,j]=PILKA_2 then
          PionkiKopia[WYMIAR-i,j]:=PILKA_1
        else
          PionkiKopia[WYMIAR-i,j]:=' ';
end;


{zapisujemy ruch i zapisujemy jesli bylo to podanie}
procedure ZakonczenieRuchu(const WybranyRuch : RekordRuch; var Podalem : Boolean;
                           const NumerRuchu : ShortInt; var Sytuacja : Longint;
                           const Ocena : Longint; var PionkiKopia : TabPlansza);
begin
  {jezeli zaden ruch nie zostal znaleziony - mozliwe gry to trzeci ruch
  i musialby byc podaniem albo gdy po tym ruchu mielibysmy przegrana sytuacje
  (PRZEGRANA) a po poprzednim nie mielismy to porzucamy ruch}
  if (Ocena=NIE_MA_RUCHU) or ((Ocena=PRZEGRANA) and (Ocena<Sytuacja)) then
    Exit;

  {zapisujemy ruch i zapisujemy jesli ten ruch to podanie}
  if PionkiKopia[WybranyRuch.Wiersz1,WybranyRuch.Kol1]=PILKA_1 then
    Podalem:=true;
  ObecneRuchy[NumerRuchu].Uzyty:=true;
  ObecneRuchy[NumerRuchu].Wiersz1:=WybranyRuch.Wiersz1;
  ObecneRuchy[NumerRuchu].Kol1:=WybranyRuch.Kol1;
  ObecneRuchy[NumerRuchu].Wiersz2:=WybranyRuch.Wiersz2;
  ObecneRuchy[NumerRuchu].Kol2:=WybranyRuch.Kol2;
  ZamienPola(WybranyRuch.Wiersz1,WybranyRuch.Kol1,WybranyRuch.Wiersz2,
             WybranyRuch.Kol2,PionkiKopia);

  {zapisujemy najnowsza ocene sytuacji}
  Sytuacja:=Ocena;
end;


{wykonujemy na planszy ruchy wybrane przez komputer}
procedure WykonajRuchy(const Gracz : ShortInt; var IleWykonano : ShortInt);
var
  i, Numer : ShortInt;
begin
  {jesli potrzeba to przerabiamy ruchy spowrotem - tzn. jesli przerabialismy
  na poczatku ustawienie pionkow by zasymulowac ze Gracz=1 i ulatwic obliczenia}
  if Gracz=2 then
    for i:=1 to MAX_RUCHOW do
      if ObecneRuchy[i].Uzyty then
        begin
          ObecneRuchy[i].Wiersz1:=WYMIAR-ObecneRuchy[i].Wiersz1;
          ObecneRuchy[i].Wiersz2:=WYMIAR-ObecneRuchy[i].Wiersz2;
        end;

  {wykonujemy ruchy}
  Numer:=0;
  while not Application.Terminated do
    begin
      Inc(Numer);
      if Numer>MAX_RUCHOW then Break;
      if not ObecneRuchy[Numer].Uzyty then Break;
      ZamienPola(ObecneRuchy[Numer].Wiersz1,ObecneRuchy[Numer].Kol1,
                 ObecneRuchy[Numer].Wiersz2,ObecneRuchy[Numer].Kol2,
                 PionkiObecnie);
      EkranGlowny.Plansza.Repaint;
      Inc(IleWykonano);

      {robimy przerwe przed wykonaniem kolejnego ruchu (sprawdzamy tez czy
      ktos nie wcisnal 'Zatrzymaj')}
      Application.ProcessMessages;
      if not KomputerGraj then Exit;
      Sleep(PRZERWA_MIEDZY_RUCHAMI div 2);
      Application.ProcessMessages;
      if not KomputerGraj then Exit;
      Sleep(PRZERWA_MIEDZY_RUCHAMI div 2)
    end;
end;





//szukanie ruchu


{analizujac ustawienie na PionkiOcena (ustawienie po wykonaniu danego ruchu)
funkcja zwraca ocene ruchu}
function Ocen(const PionkiOcena : TabPlansza) : Longint;
var
  i, j : ShortInt;
  PomOcena, SumaWspolWiersz : LongInt;
  Linia : Boolean;
begin
  {sprawdzamy czy gracz nie ma wygranej}
   if CzyWygrana(1,PionkiOcena) or CzyWygranaPrzezBlokade(1,PionkiOcena,Linia)
     then
     begin
       Ocen:=WYGRANA;
       Exit;
     end;

   {sprawdzamy czy nie ma sytuacji od razu dajacej przegrana przez blokade lub
    jest duza szansa ze przeciwnik moze wykorzystac to, ze stworzylismy linie
    blokujaca}
  if CzyWygranaPrzezBlokade(2,PionkiOcena,Linia) then
    begin
       Ocen:=PRZEGRANA;
       Exit;
    end;
  if Linia then
    begin
      SumaWspolWiersz:=0;
      for i:=0 to WYMIAR do
        for j:=0 to WYMIAR do
          if (PionkiOcena[i,j]=PION_1) or(PionkiOcena[i,j]=PILKA_1) then
             SumaWspolWiersz:=SumaWspolWiersz+i;
      if SumaWspolWiersz>=OGRANICZENIE_ANTYBLOKADOWE then
        begin
          Ocen:=PRZEGRANA+1;
          Exit;
        end
    end;
  
  {jezeli ani gracz nie ma wygranej, ani nie ma sytuacji, gdzie przeciwnik
   moze od razu wygrac to oceniamy na podstawie wspolrzednych pionkow i pilki}
  PomOcena:=0;
  for i:=0 to WYMIAR do
    for j:=0 to WYMIAR do
      if PionkiOcena[i,j]=PILKA_1 then
        PomOcena:=PomOcena+i*MNOZNIK_ZA_PILKE
      else if PionkiOcena[i,j]=PION_1 then
        PomOcena:=PomOcena+i;
  Ocen:=PomOcena;
end;


{oceniamy dany ruch i zaleznie od wysokosci oceny aktualizujemy lub nie
WybranyRuch}
procedure ZdecydujCoZRuchem(const Wiersz1,Kol1,Wiersz2,Kol2 : ShortInt;
                            var WybranyRuch : RekordRuch; var Ocena : Longint;
                            const PionkiKopia : TabPlansza);
var
  NowaOcena, i, j : Longint;
  PionkiOcena : TabPlansza;
begin
  {oceniamy ruch}
  for i:=0 to WYMIAR do
    for j:=0 to WYMIAR do
      PionkiOcena[i,j]:=PionkiKopia[i,j];
  ZamienPola(Wiersz1,Kol1,Wiersz2,Kol2,PionkiOcena);
  NowaOcena:=Ocen(PionkiOcena);

  {jesli nowa ocena jest wyzsza od dotychczas najlepszej to zapisujemy nowy ruch}
  if NowaOcena>Ocena then
    begin
      Ocena:=NowaOcena;
      WybranyRuch.Wiersz1:=Wiersz1;
      WybranyRuch.Kol1:=Kol1;
      WybranyRuch.Wiersz2:=Wiersz2;
      WybranyRuch.Kol2:=Kol2;
    end
end;


{probujemy podania od pionka z Wiersz1,Kol1 do pionka z Wiersz2,Kol2 -
analizujemy czy to podanie jest dozwolone i oceniamy taki ruch}
procedure SprobujPodania(const Wiersz1, Kol1, Wiersz2, Kol2 : ShortInt;
                         var WybranyRuch : RekordRuch; var Ocena : Longint;
                         const PionkiKopia : TabPlansza);
var
  RozWiersz, RozKol, KrokWiersz, KrokKol, i, PomWiersz, PomKol : ShortInt;
begin
  RozWiersz:=Wiersz2-Wiersz1;
  RozKol:=Kol2-Kol1;

  {sprawdzamy czy zadany ruch jest po prostej lub przekatnej}
  if abs(RozWiersz)<>abs(RozKol) then
    if not((RozWiersz=0) or (RozKol=0)) then
      Exit;

  {sprawdzamy czy na linii podania nie ma przeciwnikow}
  PomWiersz:=Wiersz1;
  PomKol:=Kol1;
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
      PomWiersz:=PomWiersz+KrokWiersz;
      PomKol:=PomKol+KrokKol;
      if not ((PionkiKopia[PomWiersz,PomKol]=PION_1) or
        (PionkiKopia[PomWiersz,PomKol]=' ')) then
        Exit;
    end;

  {wyceniamy ruch i jesli jest odpowiednio dobry to zapisujemy jako WybranyRuch}
  ZdecydujCoZRuchem(Wiersz1,Kol1,Wiersz2,Kol2,WybranyRuch,Ocena,PionkiKopia);
end;


{probujemy przesuniecia pionka w dana strone - analizujemy czy to dozwolone
i oceniamy taki ruch}
procedure SprobujPrzesuniecia(const Wiersz1, Kol1, PrzesWiersz, PrzesKol
                              : ShortInt; var WybranyRuch : RekordRuch; var Ocena
                              : Longint; const PionkiKopia : TabPlansza);
begin
  {sprawdzamy czy ruch jest dozwolony}
  if ((Wiersz1+PrzesWiersz)>WYMIAR) or ((Wiersz1+PrzesWiersz)<0) or
    ((Kol1+PrzesKol)>WYMIAR) or ((Kol1+PrzesKol)<0) then
    Exit;
  if PionkiKopia[Wiersz1+PrzesWiersz,Kol1+PrzesKol]<>' ' then
    Exit;

  {wyceniamy ruch i jesli jest odpowiednio dobry to zapisujemy jako WybranyRuch}
  ZdecydujCoZRuchem(Wiersz1,Kol1,Wiersz1+PrzesWiersz,Kol1+PrzesKol,WybranyRuch,
                    Ocena,PionkiKopia);
end;

{procedura znajdujaca najwyzej oceniany przez funkcje Ocen ruch w danym momencie,
by wprowadzic pewna okreslona losowosc, po znalezieniu pionkow gracza ich
kolejnosc w tablicy MojePionki jest losowo zamieniana}
procedure SzukajRuchu(var WybranyRuch : RekordRuch; var  Podalem : Boolean;
                      var NumerRuchu : ShortInt; var Ocena : Longint;
                      const PionkiKopia : TabPlansza);
var
  NrPionka, PomWiersz, PomKol, Pionek1, Pionek2 : LongInt;
  i, j, Wiersz1, Kol1, Wiersz2, Kol2 : Longint;
  MojePionki : array[0..WYMIAR,0..1] of ShortInt;
begin
  {bazowa ocena-nie znaleziono ruchu, aktualizujemy NumerRuchu}
  Ocena:=NIE_MA_RUCHU;
  Inc(NumerRuchu);

  {znajdujemy pionki gracza i ustawiamy je losowo}
   NrPionka:=0;
   for i:=0 to WYMIAR do
     for j:=0 to WYMIAR do
       if (PionkiKopia[i,j]=PION_1) or (PionkiKopia[i,j]=PILKA_1) then
         begin
           MojePionki[NrPionka,0]:=i;
           MojePionki[NrPionka,1]:=j;
           Inc(NrPionka);
         end;

   for i:=1 to LICZBA_LOSOWAN do
     begin
       Pionek1:=random(WYMIAR+1);
       Pionek2:=random(WYMIAR+1);
       PomWiersz:=MojePionki[Pionek1,0];
       PomKol:=MojePionki[Pionek1,1];
       MojePionki[Pionek1,0]:=MojePionki[Pionek2,0];
       MojePionki[Pionek1,1]:=MojePionki[Pionek2,1];
       MojePionki[Pionek2,0]:=PomWiersz;
       MojePionki[Pionek2,1]:=PomKol;
     end;

  {po kolei dla pionkow z MojePionki szukamy ruchow}
  for i:=0 to WYMIAR do
    begin
      Wiersz1:=MojePionki[i,0];
      Kol1:=MojePionki[i,1];
      if PionkiKopia[Wiersz1,Kol1]=PILKA_1 then
        begin
          {jesli bylo juz podanie to idziemy do nastepnego pionka,
           jesli nie to probujemy podan do innych pionkow - probowanie
           zawiera analize czy ruch jest dozwolony i ocene ruchu}
          if not Podalem then
            for j:=0 to WYMIAR do
              if i<>j then
                begin
                  Wiersz2:=MojePionki[j,0];
                  Kol2:=MojePionki[j,1];
                  SprobujPodania(Wiersz1,Kol1,Wiersz2,Kol2,WybranyRuch,Ocena,
                                 PionkiKopia)
                end
        end
      else
        {o ile nie jest to sytuacja trzeciego ruchu, gdzie w poprzednich
        nie bylo podania to probujemy przesuniec we wszystkich kierunkach
        -probowanie zawiera analize czy ruch jest dozwolony i ocene ruchu}
        if (NumerRuchu<3) or Podalem then
          begin
            SprobujPrzesuniecia(Wiersz1,Kol1,1,0,WybranyRuch,Ocena,PionkiKopia);
            SprobujPrzesuniecia(Wiersz1,Kol1,0,1,WybranyRuch,Ocena,PionkiKopia);
            SprobujPrzesuniecia(Wiersz1,Kol1,0,-1,WybranyRuch,Ocena,PionkiKopia);
            SprobujPrzesuniecia(Wiersz1,Kol1,-1,0,WybranyRuch,Ocena,PionkiKopia);
          end
    end;
end;





//2 glowne procedury unitu uzywajace pozostalych (powyzej)

{procedura odpowiedzialna za symulowanie gracza, ruchy zapisywane sa na
ObecneRuchy - tak samo jak zwyklego gracza - by ZakonczKolejke zadzialalo}
procedure KolejkaKomputera();
var
  {Gracz-1 lub 2 (zaleznie po ktorej stronie planszy 'siedzi'; NumerRuchu -
  numer obecnie wyliczanego ruchu, IleWykonano-ile komputer wykonal ruchow zanim
  gracz nacisnal 'Zatrzymaj'}
  i, Pom, Gracz, NumerRuchu, IleWykonano : ShortInt;
  {przy wyliczaniu danego ruchu, przetrzymuje ruch obecnie oceniony jako
  najlepszy}
  WybranyRuch : RekordRuch;
  {pamieta czy w wyliczonych ruchach pojawilo sie juz podanie}
  Podalem : Boolean;
  {Sytuacja - przetrzymuje ocene pozycji po wyliczonych juz ruchach, Ocena -
  przetrzymuje Ocene WybranyRuch (znajdujemy kolejne mozliwe ruchy, je tez
  oceniamy i porownujac oceny ew. aktualizujemy WybranyRuch)}
  Sytuacja, Ocena : Longint;
  {na poczatku zapisujemy na tej tablicy kopie obecnego ukladu pionkow na
  planszy, a potem jak wybierzemy ruch to zapisujemy to na tej tablicy}
  PionkiKopia : TabPlansza;
begin
  {inicjalizacja zmiennych, blokujemy interfejs,ale uaktywniamy guzik
  umozliwiajcy zatrzymanie obliczen komputera}
  KomputerGraj:=true;
  IleWykonano:=0;
  ZablokujMenuIZagraj();
  EkranGlowny.GuzikZatrzymajKomputer.Enabled:=true;
  EkranGlowny.GuzikWznowKomputer.Enabled:=false;

  {przygotowanie struktur do szukania ruchu dla komputera}
  Przygotowanie(Podalem,Gracz,NumerRuchu,Sytuacja,PionkiKopia);

  {wybieranie kolejnych ruchow przez komputer}
  for i:=1 to 3 do
    begin
      Application.ProcessMessages;
      if not KomputerGraj then Break;

      if Sytuacja=PRZEGRANA then
        begin
          {znajduje najwyzej oceniony ruch przez funkcje Ocen}
          SzukajRuchu(WybranyRuch,Podalem,NumerRuchu,Ocena,PionkiKopia);
          {zapisuje wybrany ruch na ObecneRuchy, zapisuje jesli bylo podanie}
          ZakonczenieRuchu(WybranyRuch,Podalem,NumerRuchu,Sytuacja,Ocena,
                           PionkiKopia);
        end
      else if Sytuacja<WYGRANA then
        begin
          Pom:=Random(4);
          if Pom<3 then
            begin
              SzukajRuchu(WybranyRuch,Podalem,NumerRuchu,Ocena,PionkiKopia);
              ZakonczenieRuchu(WybranyRuch,Podalem,NumerRuchu,Sytuacja,Ocena,
                               PionkiKopia);
            end
        end;
    end;

  if Application.Terminated then Exit;

  {jesli nie nacisnieto Zatrzymaj to wykonujemy ruchy (ew. najpierw przerabiamy
   je jesli Gracz=2)}
  if KomputerGraj then
      WykonajRuchy(Gracz,IleWykonano);

  if Application.Terminated then Exit;

  {jesli nie nacisnieto Zatrzymaj to puszczamy ZakonczKolejke}
  if KomputerGraj then
      EkranGlowny.GuzikZakonczKolejkeClick(EkranGlowny.GuzikZakonczKolejke)
  else
    {jesli nacisnieto Zatrzymaj to wycofujemy ruchy}
    begin
      for i:=IleWykonano downto 1 do
        ZamienPola(ObecneRuchy[i].Wiersz1,ObecneRuchy[i].Kol1,
                   ObecneRuchy[i].Wiersz2,ObecneRuchy[i].Kol2,
                   PionkiObecnie);
      EkranGlowny.Plansza.Repaint;
      for i:=1 to MAX_RUCHOW do
        ObecneRuchy[i].Uzyty:=false;
    end;


  {odblokowujemy interfejs}
  OdblokujMenuIZagraj();
  EkranGlowny.GuzikZatrzymajKomputer.Enabled:=false;
end;


{uzywajac algorytmow komputerowego gracza wyliczamy hinta dla czlowieka}
procedure DajHinta();

  {zamienia wspolrzedne komorki na opis typu 'A4'}
  function WspolrzedneNaOpis(Wiersz,Kol : ShortInt) : String;
  begin
    WspolrzedneNaOpis:=Chr(Ord('A')+Wiersz)+IntToStr(Kol+1);
  end;
  
var
  {zmienne analogiczne do tych z KolejkaKomputera + ObcneRuchyKopia czyli
  tablica pamietajaca ruchy wybrane przez gracza na czas obliczen komputera i
  IleRuchow czyli ile ruchow wybral komuter}
  WybranyRuch : RekordRuch;
  Podalem : Boolean;
  Sytuacja, Ocena : Longint;
  PionkiKopia : TabPlansza;
  ObecneRuchyKopia : TabRuchy;
  i, IleRuchow, Gracz, NumerRuchu : ShortInt;
  Hint : String;
begin
  EkranGlowny.Enabled:=false;

  {na czas obliczen, zrzucamy ruchy gracza z ObecneRuchy na kopie (algorytmy
  komputera wykorzystuja ObecneRuchy). wycofujemy tez na czas obliczen ruchy
  z PionkiObecnie - komputer potrzebuje sytuacji z poczatku kolejki}
  for i:=MAX_RUCHOW downto 1 do
    begin
      if ObecneRuchy[i].Uzyty then
        ZamienPola(ObecneRuchy[i].Wiersz1,ObecneRuchy[i].Kol1,
                   ObecneRuchy[i].Wiersz2,ObecneRuchy[i].Kol2,PionkiObecnie);
      ObecneRuchyKopia[i].Uzyty:=ObecneRuchy[i].Uzyty;
      ObecneRuchyKopia[i].Wiersz1:=ObecneRuchy[i].Wiersz1;
      ObecneRuchyKopia[i].Kol1:=ObecneRuchy[i].Kol1;
      ObecneRuchyKopia[i].Wiersz2:=ObecneRuchy[i].Wiersz2;
      ObecneRuchyKopia[i].Kol2:=ObecneRuchy[i].Kol2;
    end;

  {przygotowanie struktur do szukania ruchu dla gracza}
  Przygotowanie(Podalem,Gracz,NumerRuchu,Sytuacja,PionkiKopia);

  {wybieramy ruchy dla gracza}
  for i:=1 to 3 do
    if Sytuacja<WYGRANA then
      begin
        SzukajRuchu(WybranyRuch,Podalem,NumerRuchu,Ocena,PionkiKopia);
        ZakonczenieRuchu(WybranyRuch,Podalem,NumerRuchu,Sytuacja,Ocena,
                         PionkiKopia);
      end;

  {zrzucamy wybrane ruchy na string}
  IleRuchow:=0;
  for i:=1 to MAX_RUCHOW do
    if ObecneRuchy[i].Uzyty then
      Inc(IleRuchow);
  Hint:='Make '+IntToStr(IleRuchow)+' move(s).';
  for i:=1 to MAX_RUCHOW do
    if ObecneRuchy[i].Uzyty then
      Hint:=Hint+' From '
            +WspolrzedneNaOpis(ObecneRuchy[i].Wiersz1,ObecneRuchy[i].Kol1)+' to '
            +WspolrzedneNaOpis(ObecneRuchy[i].Wiersz2,ObecneRuchy[i].Kol2) +'.';

  {ruchy z kopii spowrotem na ObecneRuchy}
  for i:=1 to MAX_RUCHOW do
    begin
      if ObecneRuchyKopia[i].Uzyty then
        ZamienPola(ObecneRuchyKopia[i].Wiersz1,ObecneRuchyKopia[i].Kol1,
                   ObecneRuchyKopia[i].Wiersz2,ObecneRuchyKopia[i].Kol2,
                   PionkiObecnie);
      ObecneRuchy[i].Uzyty:=ObecneRuchyKopia[i].Uzyty;
      ObecneRuchy[i].Wiersz1:=ObecneRuchyKopia[i].Wiersz1;
      ObecneRuchy[i].Kol1:=ObecneRuchyKopia[i].Kol1;
      ObecneRuchy[i].Wiersz2:=ObecneRuchyKopia[i].Wiersz2;
      ObecneRuchy[i].Kol2:=ObecneRuchyKopia[i].Kol2;
    end;

  {podajemy podpowiedz}
  ShowMessage(Hint);
  EkranGlowny.Enabled:=true;
end;

end.
