{Unit progamu Diaballik.
Obs�uga ekranu zapisu.}

unit Zapisywanie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEkranZapisu = class(TForm)
    WyborPlikuZapisu : TSaveDialog;
    WpiszPlikZapisu : TEdit;
    GuzikPlikZapisu : TButton;
    GuzikZapisz : TButton;
    NapisSciezka : TLabel;
    NapisPamietaj : TLabel;
    procedure GuzikPlikZapisuClick(Sender : TObject);
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure GuzikZapiszClick(Sender : TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranZapisu : TEkranZapisu;

implementation

uses
  GlownyEkran;

{$R *.dfm}




//3 mniejsze procedurki - pojawienie/znikniecie ekranu i wybor pliku zapisu

procedure TEkranZapisu.GuzikPlikZapisuClick(Sender : TObject);
begin
  if WyborPlikuZapisu.Execute then
    WpiszPlikZapisu.Text:=WyborPlikuZapisu.FileName;
end;


procedure TEkranZapisu.FormShow(Sender : TObject);
begin
  EkranGlowny.Enabled:=false;
end;


procedure TEkranZapisu.FormClose(Sender : TObject;
  var Action : TCloseAction);
begin
  EkranGlowny.Enabled:=true;
end;





//glowna procedura - zapisywanie gry


{zapisywanie gry zgodnie ze schematem: gracz1, gracz2, biezacy gracz, obecny
uklad pionkow, licznik ruchow, historia ruchow}
procedure TEkranZapisu.GuzikZapiszClick(Sender : TObject);
var
  Plik : TextFile;
  i, j : Longint;
  WskNaHistorie : Lista;
begin
  AssignFile(Plik,WpiszPlikZapisu.Text);
  {$i-}
  Rewrite(Plik);
  {$i+}
  {obs�uga b��dnej �cie�ki}
  if IOresult<>0 then
    begin
      ShowMessage('�cie�ka jest niepoprawna');
      Exit;
    end;

  {zapisujemy tryb i biezacego gracza}
  Writeln(Plik,EkranGlowny.NapisNazwaGracza1.Caption);
  Writeln(Plik,EkranGlowny.NapisNazwaGracza2.Caption);
  Writeln(Plik,EkranGlowny.WpiszBiezacyGracz.Text);

  {zapisujemy obecna plansze}
  for i:=0 to WYMIAR do
    begin
      for j:=0 to WYMIAR do
        Write(Plik,PionkiObecnie[i,j]);
      Writeln(Plik);
    end;

  {zapisujemy liczbe ruchow i historie}
  Writeln(Plik,LicznikRuchow);
  WskNaHistorie:=HistoriaPocz;
  for i:=1 to LicznikRuchow do
    begin
      WskNaHistorie:=WskNaHistorie.Nast;
      Writeln(Plik,WskNaHistorie.Wiersz1,' ',WskNaHistorie.Kol1,' ',
              WskNaHistorie.Wiersz2,' ',WskNaHistorie.Kol2);
    end;

  CloseFile(Plik);
  ShowMessage('Zapisano gr�. Mo�esz gra� dalej');
  EkranZapisu.Close;
end;

end.
