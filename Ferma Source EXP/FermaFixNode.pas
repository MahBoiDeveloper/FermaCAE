unit FermaFixNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferm_Dat;

type
  TFermaFixNode_Form = class(TForm)
    Bevel1: TBevel;
    FermaFixType_RGrp: TRadioGroup;
    FermaFixNodeOkBtn: TBitBtn;
    FermaFixNodeCancelBtn: TBitBtn;
    Bevel2: TBevel;
    Node_Label: TLabel;
    
    procedure FermaFixNodeOkBtnClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
   
  private
    { Private declarations }
    GlobalIndex:integer;
  public
    { Public declarations }
  end;

var
  FermaFixNode_Form: TFermaFixNode_Form;

implementation

uses Main,Ferma_M, Ferma_FD;

{$R *.DFM}


procedure TFermaFixNode_Form.FermaFixNodeOkBtnClick(Sender: TObject);
var
i:integer;
begin
i:=ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).CurrentNode;
if FermaFixType_RGrp.ItemIndex=0 then begin ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,1]:=0; ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,2]:=0; end;
if FermaFixType_RGrp.ItemIndex=1 then begin ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,1]:=1; ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,2]:=0; end;
if FermaFixType_RGrp.ItemIndex=2 then begin ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,1]:=0; ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,2]:=1; end;
if FermaFixType_RGrp.ItemIndex=3 then begin ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,1]:=1; ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,2]:=1; end;
if GlobalIndex<>FermaFixType_RGrp.ItemIndex then
 begin
  ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).isChanged:=True;
  ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
  Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
  ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Repaint;
  ferma_FD_form.showD(ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Ferm);
 end;
end;



procedure TFermaFixNode_Form.FormActivate(Sender: TObject);
var
i,fx,fy:integer;
begin
  i:=ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).CurrentNode;
  Node_Label.Caption:='Óçåë ¹'+IntToStr(i);  
  fx:=ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,1];
  fy:=ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.msn[i,2];
  if (fx=0)and(fy=0) then FermaFixType_RGrp.ItemIndex:=0;
  if (fx=1)and(fy=0) then FermaFixType_RGrp.ItemIndex:=1;
  if (fx=0)and(fy=1) then FermaFixType_RGrp.ItemIndex:=2;
  if (fx=1)and(fy=1) then FermaFixType_RGrp.ItemIndex:=3;
  FermaFixType_RGrp.SetFocus;
  GlobalIndex:=FermaFixType_RGrp.ItemIndex;
end;

end.
