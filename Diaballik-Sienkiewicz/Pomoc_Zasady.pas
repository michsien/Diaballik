{Unit progamu Diaballik.
Obs³uga ekranu z pomoc¹ dot. zasad gry.}

unit Pomoc_Zasady;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TEkranZasad = class(TForm)
    OpisZasad : TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EkranZasad : TEkranZasad;

implementation

{$R *.dfm}

end.
