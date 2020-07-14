unit numberST;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    number: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject); // Евдокимова Елена
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Main, Ferma_FD, ferma_m;

{$R *.DFM}
//Начало// Евдокимова Елена
procedure TForm1.FormShow(Sender: TObject);
begin
  Form1.Button1.Default:=True;
  Form1.number.SetFocus;
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
     Form1.number.Text:='';   // Евдокимова Елена
  end;
 for i:=i_pivot+1 to F.nst1 do
  begin
     F.Fn[i-1]:=F.Fn[i];
     F.Fn[i]:=0;
  end;

end;
procedure TForm1.Button1Click(Sender: TObject);
var
    i:integer;
begin
    i:=StrToInt(Form1.number.Text);
    if  ((i<=F.nst1)and(i>0))  then
     begin
        DeletePivot(i);
        F.nst1:=F.nst1-1;
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
        ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
        ferma_FD_form.showD(f);
        Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
     end
    else
     begin
      Main_Form.StatusBar1.Panels[1].Text := 'Несуществующий номер.';
      Beep;
     end;
end;


end.
