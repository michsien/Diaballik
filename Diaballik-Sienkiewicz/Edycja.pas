{Unit progamu Diaballik.
Obs³uga ekranu z edytorem biê¿¹cego stanu gry.}

unit Edycja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids; 

type
  TEkranEdytora = class(TForm)
    ListaWybierzGracza : TComboBox;
    NapisOpisDzialaniaEdytora : TLabel;
    PlanszaEdytor : TStringGrid;
    NapisNazwaGracza1 : TLabel;
    NapisNazwaGracza2 : TLabel;
    GuzikZagrajOdUstawienia : TButton;
    procedure FormShow(Sender : TObject);
    procedure FormClose(Sender : TObject; var Action : TCloseAction);
    procedure PlanszaEdytorMouseDown(Sender : TObject; Button : TMouseButton;
                                     Shift : TShiftState; X, Y : Integer);
    procedure GuzikZagrajOdUstawieniaClick(Sender : TObject);
    procedure PlanszaEdytorDrawCell(Sender : TObject; ACol, ARow : Integer;
                                    Rect : TRect; State : TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranEdytora : TEkranEdytora;

implementation

uses
  GlownyEkran;

{$R *.dfm}

var
  {dwa kolejne klikniecia zamieniaja pola w edytorze - ta zmienna umozliwia nam
  sprawdzanie ktore to klikniecie}
  PierwszyKlik : Boolean;
  {ustawienie pionkow na planszy edytora}
  PionkiEdytor : TabPlansza;
  {zmienne pamietajace gdzie bylo pierwsze klikniecie z pary}
  Wiersz,Kol : ShortInt;





//procedury odpowiedzialne za to co sie dzieje, gdy ekran sie pojawia/znika

procedure TEkranEdytora.FormShow(Sender : TObject);
var
  i, j : ShortInt;
begin
  EkranGlowny.Enabled:=false;

  {'pobieramy' dane z glownego okna gry}
  for i:=0 to WYMIAR do
    for j:=0 to WYMIAR do
      PionkiEdytor[i,j]:=PionkiObecnie[i,j];
  ListaWybierzGracza.ItemIndex:=-1;
  ListaWybierzGracza.Text:='Wybierz bie¿¹cego gracza';
  ListaWybierzGracza.Items.Delete(0);
  ListaWybierzGracza.Items.Delete(0);
  ListaWybierzGracza.Items.Insert(0,EkranGlowny.NapisNazwaGracza1.Caption);
  ListaWybierzGracza.Items.Insert(1,EkranGlowny.NapisNazwaGracza2.Caption);
  NapisNazwaGracza1.Caption:=EkranGlowny.NapisNazwaGracza1.Caption;
  NapisNazwaGracza2.Caption:=EkranGlowny.NapisNazwaGracza2.Caption;

  {inicjalizujemy zmienna kontrolujaca czy ostatnie klikniecie uzytkownika w
   plansze w edytorze bylo pierwszym czy drugim z pary}
  PierwszyKlik:=true;
end;


procedure TEkranEdytora.FormClose(Sender : TObject; var Action : TCloseAction);
begin
  EkranGlowny.Enabled:=true;
end;




//glowne prcoedury edytora

{obsluga klikniec w plansze - kolejne dwa zamieniaja pola na planszy}
procedure TEkranEdytora.PlanszaEdytorMouseDown(Sender : TObject;  Button
                                               : TMouseButton; Shift
                                               : TShiftState; X, Y: Integer);
begin
  {sprawdzenie czy uzytkownik kliknal lewy przycisk myszy bez shift/ctrl/alt}
  if Shift<>[ssLeft] then
    Exit;

  {zaleznie czy to pierwszy czy drugie kliniecie z pary klikniec, wykonujemy
   adekwatne operacje}
  if PierwszyKlik then
    begin
      Wiersz:=PlanszaEdytor.Row;
      Kol:=PlanszaEdytor.Col;
      PierwszyKlik:=false;
    end
  else
    begin
      ZamienPola(Wiersz,Kol,PlanszaEdytor.Row,PlanszaEdytor.Col,PionkiEdytor);
      PlanszaEdytor.Repaint;
      PierwszyKlik:=true;
    end;
end;


{obsluga guzika 'Zagraj od tego ustawienia'}
procedure TEkranEdytora.GuzikZagrajOdUstawieniaClick(Sender : TObject);
var
  i, j : Integer;
begin
  {sprawdzenie poprawnosci trybu i czy uzytkownik na pewno chce nowa gre}
  if ListaWybierzGracza.ItemIndex=-1 then
    begin
      ShowMessage('Wybrany bie¿¹cy gracz jest niepoprawny!!');
      Exit;
    end
  else if MessageDlg('Obecna gra zostanie stracona!', mtConfirmation,
    [mbOk,mbCancel], 0) = mrCancel then
    Exit;

  {przygotowanie struktur danych i zmiennych do zapisu gry}
  PrzygotujZmienneIStruktury();

  {³adujemy wybrane przez nas ustawienie}
  for i:=0 to WYMIAR do
    for j:=0 to WYMIAR do
      PionkiObecnie[i,j]:=PionkiEdytor[i,j];
  EkranGlowny.Plansza.Repaint;


  {uzupelnienie nazwy biezacego gracza}
    EkranGlowny.WpiszBiezacyGracz.Text:=ListaWybierzGracza.Text;

  {zamykamy edytor}
  EkranEdytora.Close;
  
  {w zaleznosci od tego kto gra nastepny, blokujemy/uaktywniamy komponenty i ew.
   uruchamiamy KolejkaKomputera}
  PrzygotujKomponentyUruchomKomputer();
end;


{procedura rysujaca plansze edytora}
procedure TEkranEdytora.PlanszaEdytorDrawCell(Sender: TObject; ACol, ARow
                                              : Integer; Rect : TRect; State
                                              : TGridDrawState);
begin
  RysujKomorkePlanszy(ACol,ARow,Rect,PlanszaEdytor,PionkiEdytor);
end;

end.
