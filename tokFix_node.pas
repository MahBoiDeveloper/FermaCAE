unit tokFix_node;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TtokFixNode_Form = class(TForm)
    FixType_RGrp: TRadioGroup;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Node_Label: TLabel;
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(var fx,fy:extended);
  end;

var
  tokFixNode_Form: TtokFixNode_Form;

implementation

uses Main, tok_M;

{$R *.DFM}

procedure TtokFixNode_Form.Execute(var fx,fy:extended);
begin
  if (round(fx)=0)and(round(fy)=0) then FixType_RGrp.ItemIndex:=0;
  if (round(fx)=1)and(round(fy)=0) then FixType_RGrp.ItemIndex:=1;
  if (round(fx)=0)and(round(fy)=1) then FixType_RGrp.ItemIndex:=2;
  if (round(fx)=1)and(round(fy)=1) then FixType_RGrp.ItemIndex:=3;
  if ShowModal=mrOk then
    begin
      if FixType_RGrp.ItemIndex=0 then begin fx:=0; fy:=0; end;
      if FixType_RGrp.ItemIndex=1 then begin fx:=1; fy:=0; end;
      if FixType_RGrp.ItemIndex=2 then begin fx:=0; fy:=1; end;
      if FixType_RGrp.ItemIndex=3 then begin fx:=1; fy:=1; end;
    end;



end;





procedure TtokFixNode_Form.FormActivate(Sender: TObject);
var
i:integer;
begin
tok_M.Ttok_Form(Main_Form.ActiveMDIChild).popa:=true;
i:=tok_M.Ttok_Form(Main_Form.ActiveMdiChild).CurrentNode;
if i=0 then i:=tok_M.Ttok_Form(Main_Form.ActiveMdiChild).tok.count+1;
  Node_Label.Caption:='Óçåë ¹'+IntToStr(i)+' ['+inttostr(tok_M.Ttok_Form(Main_Form.ActiveMdiChild).Xtok)+','+inttostr(tok_M.Ttok_Form(Main_Form.ActiveMdiChild).Ytok)+']';
end;

end.
