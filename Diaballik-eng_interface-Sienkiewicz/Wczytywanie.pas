{Unit progamu Diaballik.
Obs³uga ekranu wczytywania.}

unit Wczytywanie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEkranWczytywania = class(TForm)
    WpiszPlikGry : TEdit;
    GuzikWybierzPlikGry : TButton;
    GuzikWczytajGre : TButton;
    WyborPlikuGry : TOpenDialog;
    NapisSciezka : TLabel;
    Label1 : TLabel;
    procedure GuzikWybierzPlikGryClick(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure GuzikWczytajGreClick(Sender : TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranWczytywania : TEkranWczytywania;

implementation

uses
  GlownyEkran;

{$R *.dfm}





//3 male procedurki- pojawienie/znikniecie ekranu, wybor pliu z gra

procedure TEkranWczytywania.FormShow(Sender : TObject);
begin
  EkranGlowny.Enabled:=false;
end;


procedure TEkranWczytywania.FormClose(Sender : TObject;
  var Action : TCloseAction);
begin
  EkranGlowny.Enabled:=true;
end;


procedure TEkranWczytywania.GuzikWybierzPlikGryClick(Sender : TObject);
begin
  if WyborPlikuGry.Execute then
    WpiszPlikGry.Text:=WyborPlikuGry.FileName;
end;





//glowna procedura - wczytywanie gry

{wczytujemy gre ze wskazanego pliku. pelna obsluga bledow oprocz analizy
'glupich' ruchow w historii - tzn. ruchow ktore sa niezgodne z regulami gry,
ale nie zagrazaja dzialaniu programu}
procedure TEkranWczytywania.GuzikWczytajGreClick(Sender : TObject);

  {reakcja na niepoprawny plik z gra}
  procedure Blad();
  begin
    Gramy:=false;
    EkranGlowny.ListaWyborTrybu.ItemIndex:=0;
    EkranGlowny.GuzikZagrajClick(GuzikWczytajGre);
    ShowMessage('This is not a game file so a classic game was chosen instead;)');
    EkranWczytywania.Close;
  end;

  {pomocnicza procedura do wczytywania napisow, ktore powinny byc na poczatku
  pliku}
  procedure WczytajNapis(var Plik : TextFile; var Zle : Boolean;
                         var Tekst1 : String; const Tekst2, Tekst3 : String);
  begin
    if not Zle then
      begin
        {$i-}
        Readln(Plik,Tekst1);
        {$i+}
        if IOresult<>0 then
          Zle:=true
        else if (Tekst1<>Tekst2) and (Tekst1<>Tekst3) then
          Zle:=true;
      end
  end;

var
  Plik : TextFile;
  i, j, IlePION_1, IlePION_2, IlePILKA_1, IlePILKA_2 : Longint;
  Napis, Napis2, Napis3 : String;
  Znak : Char;
  Zle : Boolean;
  Pom : Lista;
begin
  AssignFile(Plik,WpiszPlikGry.Text);
  {$i-}
  Reset(Plik);
  {$i+}
  {obs³uga b³êdnej œcie¿ki}
  if IOresult<>0 then
    begin
      ShowMessage('The path is invalid.');
      Exit;
    end;

  {wczytywanie pliku i przygotowanie gry}

  Zle:=false;
  
  {przygotowanie struktur danych i zmiennych do zapisu gry}
  PrzygotujZmienneIStruktury();

  {wczytywanie graczy i biezacego gracza}
  WczytajNapis(Plik,Zle,Napis,CZLOWIEK_1,KOMPUTER_1);
  WczytajNapis(Plik,Zle,Napis2,CZLOWIEK_2,KOMPUTER_2);
  WczytajNapis(Plik,Zle,Napis3,Napis,Napis2);

  {reakcja na ew. bledy}
  if Zle then
     begin
       Blad();
       Exit;
     end;

  {ladujemy wczytwane dane ze zmiennych pomocniczych (duzo krotszych;))}
  EkranGlowny.NapisNazwaGracza1.Caption:=Napis;
  EkranGlowny.NapisNazwaGracza2.Caption:=Napis2;
  EkranGlowny.WpiszBiezacyGracz.Text:=Napis3;

  {wczytywanie obecnej planszy}
  IlePION_1:=0;
  IlePION_2:=0;
  IlePILKA_1:=0;
  IlePILKA_2:=0;
  for i:=0 to WYMIAR do
    begin
      if Zle then
        Break;
      for j:=0 to WYMIAR do
        begin
          if Zle then
            Break;
          {$i-}
          Read(Plik,Znak);
          {$i+}
          if IOresult<>0 then
            Zle:=true
          else if Znak=PION_1 then
            Inc(IlePION_1)
          else if Znak=PION_2 then
            Inc(IlePION_2)
          else if Znak=PILKA_1 then
            Inc(IlePILKA_1)
          else if Znak=PILKA_2 then
            Inc(IlePILKA_2)
          else if (Znak<>' ') then
            Zle:=true;
          if not Zle then
            PionkiObecnie[i,j]:=Znak;
        end;
      {$i-}
      Readln(Plik);
      {$i+}
      if IOresult<>0 then
        Zle:=true
    end;

  {wczytywanie licznika ruchow}
  {$i-}
  Readln(Plik,LicznikRuchow);
  {$i+}
  if IOresult<>0 then
    Zle:=true
  else if LicznikRuchow<0 then
    Zle:=true;

  {reakcja na ew. bledy}
  if Zle or (IlePION_1<>WYMIAR) or (IlePION_2<>WYMIAR) or (IlePILKA_1<>1) or
    (IlePILKA_2<>1) then
    begin
      Blad();
      Exit;
    end;

  {wczytywanie historii ruchow}
  for i:=1 to LicznikRuchow do
    begin
      if Zle then Break;
      New(Pom);
      Pom.Poprz:=Historia;
      Historia.Nast:=Pom;
      Historia:=Pom;
      Historia.Nast:=nil;
      {$i-}
      Readln(Plik,Historia.Wiersz1,Historia.Kol1,Historia.Wiersz2,Historia.Kol2);
      {$i+}
      if IOresult<>0 then
        Zle:=true
      else if (Historia.Wiersz1<0) or (Historia.Kol1<0) or (Historia.Wiersz2<0)
        or (Historia.Kol2<0) or (Historia.Wiersz1>WYMIAR) or (Historia.Kol1>WYMIAR)
        or (Historia.Wiersz2>WYMIAR) or (Historia.Kol2>WYMIAR)  or
        ((Historia.Wiersz1=Historia.Wiersz2) and (Historia.Kol1=Historia.Kol2))
        then
        Zle:=true;
    end;

  {reakcja na ew. bledy}
  if Zle then
    begin
      Blad();
      Exit;
    end;

  {zamykamy Plik, zamykamy ekran wczytywania i odswiezamy plansze}
  CloseFile(Plik);
  EkranWczytywania.Close;
  EkranGlowny.Plansza.Repaint;

  {w zaleznosci od tego kto gra nastepny, blokujemy/uaktywniamy komponenty i ew.
  uruchamiamy KolejkaKomputera}
  PrzygotujKomponentyUruchomKomputer();


end;

end.
