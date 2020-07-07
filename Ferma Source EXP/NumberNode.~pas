unit NumberNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm2 = class(TForm)
    numNode: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);

    procedure FormShow(Sender: TObject);

  private
      { Private declarations }
  public
   procedure Recursia(Sender: TObject);
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Main, Ferma_FD,Ferma_M;

{$R *.DFM}
 //Начало// Евдокимова Елена
 procedure TForm2.FormShow(Sender: TObject);
  begin
   Form2.Button1.Default:=True;
   Form2.numNode.SetFocus;
  end;
//Конец// Евдокимова Елена

procedure DeletePivot(i_pivot: integer);
var
 i:integer;
begin

 for i:=i_pivot+1 to F.nst1 do
  begin
     F.iTopN[i-1,1]:=F.iTopN[i,1];
     F.iTopN[i,1]:=0;
     F.iTopN[i-1,2]:=F.iTopN[i,2];
     F.iTopN[i,2]:=0;
  end;
 for i:=i_pivot+1 to F.nst1 do
  begin
     F.Fn[i-1]:=F.Fn[i];
     F.Fn[i]:=0;
  end;

end;

procedure TForm2.Recursia(Sender: TObject);
var
 i:integer;
begin
  for i:=1 to F.nst1 do
  begin
   if (F.iTopN[i,1]=Coord_Node_Pm) or (F.iTopN[i,2]=Coord_Node_Pm) then
    begin
     DeletePivot(i);
     F.nst1:=F.nst1-1;
     Recursia(self);
     Break;
    end;
  end;
end;


procedure TForm2.Button1Click(Sender: TObject);
var
    i_node,i,j:integer;
    ik:integer;
begin
        ik:=StrToInt(Form2.numNode.Text);
       if (ik>0) and (ik<=F.nyz1) then
       begin
         i_node:=ik;

 for i:=i_node+1 to F.nyz1 do
  begin
     F.Corn[i-1,1]:=F.Corn[i,1];
     F.Corn[i,1]:=0;
     F.Corn[i-1,2]:=F.Corn[i,2];
     F.Corn[i,2]:=0;
     // Начало // Евдокимова Елена
        Form2.numNode.Text:='';
    // Конец // Евдокимова Елена
  end;
 for i:=i_node+1 to F.nyz1 do
  begin
     F.msn[i-1,1]:=F.msn[i,1];
     F.msn[i,1]:=0;
     F.msn[i-1,2]:=F.msn[i,2];
     F.msn[i,2]:=0;
  end;
 for j:=1 to F.nsn1 do
  begin
   for i:=i_node+1 to F.nyz1 do
    begin
     F.Pn[(i-1)*2-1,j]:=F.Pn[i*2-1,j];
     F.Pn[i*2-1,j]:=0;
     F.Pn[(i-1)*2,j]:=F.Pn[i*2,j];
     F.Pn[i*2,j]:=0;
    end;
  end;

 F.nyz1:=F.nyz1-1;

 Recursia(self); // Удаляем стержни, связанные с удаляемым узлом

 for i:=1 to F.nst1 do  // Перенумеровываем узлы стержней
  begin
   if F.iTopN[i,1]>i_node then F.iTopN[i,1]:=F.iTopN[i,1]-1;
   if F.iTopN[i,2]>i_node then F.iTopN[i,2]:=F.iTopN[i,2]-1;
  end;

 if F.nyz1=0 then
  begin
     F.msn[1,1]:=0;
     F.msn[1,2]:=0;
     for j:=1 to F.nsn1 do
     begin
      F.Pn[1,j]:=0;
      F.Pn[2,j]:=0;
     end;
  end
  else if (F.nyz1+1)=i_node then
  begin
     F.msn[i_node,1]:=0;
     F.msn[i_node,2]:=0;
     for j:=1 to F.nsn1 do
     begin
      F.Pn[i_node*2-1,j]:=0;
      F.Pn[i_node*2,j]:=0;
     end;
  end;

 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
 Main_Form.F_Save_TBtn.Enabled:=True;
 ferma_FD_form.showD(f);
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
 Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm); 



 end;
end;
end.
