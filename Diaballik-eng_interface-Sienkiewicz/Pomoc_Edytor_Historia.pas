{Unit progamu Diaballik.
Obs�uga ekranu z pomoc� dot. edytora, przegl�dania historii.}

unit Pomoc_Edytor_Historia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEkranFunkcji = class(TForm)
    OpisFunkcji : TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranFunkcji : TEkranFunkcji;

implementation

{$R *.dfm}

end.
