unit Fix_node;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TFixNode_Form = class(TForm)
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
    procedure Execute(var fx,fy:integer);
  end;

var
  FixNode_Form: TFixNode_Form;

implementation

uses Main, Plast_M,ferm_dat;

{$R *.DFM}

procedure TFixNode_Form.Execute(var fx,fy:integer);
begin
  if (fx=0)and(fy=0) then FixType_RGrp.ItemIndex:=0;
  if (fx=1)and(fy=0) then FixType_RGrp.ItemIndex:=1;
  if (fx=0)and(fy=1) then FixType_RGrp.ItemIndex:=2;
  if (fx=1)and(fy=1) then FixType_RGrp.ItemIndex:=3;
  if ShowModal=mrOk then
    begin
      if FixType_RGrp.ItemIndex=0 then begin fx:=0; fy:=0; end;
      if FixType_RGrp.ItemIndex=1 then begin fx:=1; fy:=0; end;
      if FixType_RGrp.ItemIndex=2 then begin fx:=0; fy:=1; end;
      if FixType_RGrp.ItemIndex=3 then begin fx:=1; fy:=1; end;
    end;



end;





procedure TFixNode_Form.FormActivate(Sender: TObject);
var
i:integer;
x,y:integer;
p:tplast;
begin
p:=plast_M.Tplast_Form(Main_Form.ActiveMdiChild).plast;
i:=plast_M.Tplast_Form(Main_Form.ActiveMdiChild).CurrentNode;
if p.kx1>=p.ky1 then
 begin
  x:=round(int((i-1)/p.ky1)+0.1)+1;
  y:=round(int(i-(x-1)*p.ky1)+0.1);
 end
else
 begin
  y:=round(int((i-1)/p.kx1)+0.1)+1;
  x:=round(int(i-(y-1)*p.kx1)+0.1);
 end;
  Node_Label.Caption:='Óçåë ¹'+IntToStr(i)+' [ '+floattostr(p.xm1[x])+' , '+floattostr(p.ym1[y])+' ]';
end;



end.
