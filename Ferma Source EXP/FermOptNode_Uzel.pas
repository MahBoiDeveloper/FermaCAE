unit FermOptNode_Uzel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    Ok_Btn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses FermOptMassa,Main;

{$R *.dfm}

procedure TForm4.FormShow(Sender: TObject);
begin
Edit1.Text:=Ferm_Opt_Massa.ComboBox1.Text;
Height := round(160*Main_Form.Height_Ratio);
Width  := round(200*Main_Form.Width_Ratio);
end;

end.
