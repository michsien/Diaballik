{Program Diaballik autorstwa Micha³a Sienkiewicza.
Opis modu³ów znajduje siê w g³ównym unicie - GlownyEkran.
Ostatnia aktualizacja 19/06/2013}

program Diaballik;

uses
  Forms,
  GlownyEkran in 'GlownyEkran.pas' {EkranGlowny},
  Edycja in 'Edycja.pas' {EkranEdytora},
  Pomoc_Zasady in 'Pomoc_Zasady.pas' {EkranZasad},
  Pomoc_Edytor_Historia in 'Pomoc_Edytor_Historia.pas' {EkranFunkcji},
  HistoriaGry in 'HistoriaGry.pas' {EkranHistorii},
  Zapisywanie in 'Zapisywanie.pas' {EkranZapisu},
  Wczytywanie in 'Wczytywanie.pas' {EkranWczytywania},
  Algorytmy_Komputera in 'Algorytmy_Komputera.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TEkranGlowny, EkranGlowny);
  Application.CreateForm(TEkranZasad, EkranZasad);
  Application.CreateForm(TEkranFunkcji, EkranFunkcji);
  Application.CreateForm(TEkranHistorii, EkranHistorii);
  Application.CreateForm(TEkranZapisu, EkranZapisu);
  Application.CreateForm(TEkranEdytora, EkranEdytora);
  Application.CreateForm(TEkranWczytywania, EkranWczytywania);
  Application.Run;
end.
