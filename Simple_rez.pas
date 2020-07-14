unit Simple_rez;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TSimple_rez_form = class(TForm)
    l1: TLabel;
    l2: TLabel;
    l3: TLabel;
    l4: TLabel;
    l5: TLabel;
    l6: TLabel;
    BitBtn1: TBitBtn;
    Bevel1: TBevel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Simple_rez_form: TSimple_rez_form;

implementation

{$R *.DFM}

procedure TSimple_rez_form.BitBtn1Click(Sender: TObject);
begin
Simple_rez_form.hide;
end;

end.
