unit TokZad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TTokZad_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    ok_btn: TBitBtn;
    cancel_btn: TBitBtn;
    r_zad: TCheckBox;
    L_zad: TCheckBox;
    D_zad: TCheckBox;
    U_zad: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure ok_btnClick(Sender: TObject);
    procedure cancel_btnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TokZad_Form: TTokZad_Form;

implementation

uses Main, ferm_dat, tok_m;

  var
   tok: ttok;



{$R *.DFM}

procedure TTokZad_Form.FormActivate(Sender: TObject);
begin
tok_M.Ttok_Form(Main_Form.ActiveMDIChild).popa:=true;
 tok:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
   if tok.zad[1]=1 then L_zad.checked:=true
    else L_zad.checked:=false;
   if tok.zad[2]=1 then D_zad.checked:=true
    else d_zad.checked:=false;
   if tok.zad[3]=1 then U_zad.checked:=true
    else U_zad.checked:=false;
   if tok.zad[4]=1 then R_zad.checked:=true
    else R_zad.checked:=false;
end;

procedure TTokZad_Form.ok_btnClick(Sender: TObject);
begin
   if L_zad.checked=true then tok.zad[1]:=1
    else tok.zad[1]:=0;
   if D_zad.checked=true then tok.zad[2]:=1
    else tok.zad[2]:=0;
   if U_zad.checked=true then tok.zad[3]:=1
    else tok.zad[3]:=0;
   if R_zad.checked=true then tok.zad[4]:=1
    else tok.zad[4]:=0;
   close;
end;

procedure TTokZad_Form.cancel_btnClick(Sender: TObject);
begin
 close;
end;

end.
