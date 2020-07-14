unit FermaNewPivot;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferma_M, Ferm_Dat;

type
  TFermaNewPivot_Form = class(TForm)
    BevelMain: TBevel;
    NewPivot_Btn: TBitBtn;
    NextPivot_Btn: TBitBtn;
    CancelPivot_Btn: TBitBtn;
    Bevel1: TBevel;
    PivotName: TLabel;
    Bevel2: TBevel;
    Node_1_Edit: TEdit;
    Node_2_Edit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormRepaint(Sender: TObject);
    procedure NewPivot_BtnClick(Sender: TObject);
    procedure NextPivot_BtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FermaNewPivot_Form: TFermaNewPivot_Form;

implementation

uses Main, Ferma_FD;

{$R *.DFM}

procedure TFermaNewPivot_Form.FormRepaint(Sender: TObject);
var
FP:TFerm;
i,j,h:integer;
KomOk:boolean;
begin
 FP:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm;
 PivotName.Caption:='Стержень №'+IntToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1+1);

  if FP.nst1+1=15 then
   begin
    NextPivot_Btn.Default:=False;
    NewPivot_Btn.Default:=True;
    NextPivot_Btn.Enabled:=False;
   end
  else
   begin
    NextPivot_Btn.Default:=True;
    NewPivot_Btn.Default:=False;
    NextPivot_Btn.Enabled:=True;
   end;
  if ((FP.nst1+1=Round((FP.nyz1-1)*FP.nyz1/2)) and
     (FP.nst1+1<>15)) or
     ((FP.nst1+1=Round((FP.nyz1-1)*FP.nyz1/2)) and
     (FP.nst1+1=15))then
   begin
    NextPivot_Btn.Default:=False;
    NewPivot_Btn.Default:=True;
    NextPivot_Btn.Enabled:=False;
    for i:=1 to FP.nyz1 do
     begin
      for j:=1 to FP.nyz1 do
       begin
        if i<>j then
         begin
          KomOk:=False;
          for h:=1 to FP.nst1 do
           begin
            if ((FP.iTopN[h,1]=i) and (FP.iTopN[h,2]=j)) or ((FP.iTopN[h,1]=j) and (FP.iTopN[h,2]=i)) then KomOk:=True;
           end;
          if not KomOk then
           begin
            Node_1_Edit.Text:=IntToStr(j);
            Node_2_Edit.Text:=IntToStr(i);
            Node_1_Edit.Enabled:=False;
            Node_2_Edit.Enabled:=False;
            NewPivot_Btn.SetFocus;
           Break;
          end;
         end;
       end;
       
     end;

   end;

end;

procedure TFermaNewPivot_Form.NewPivot_BtnClick(Sender: TObject);
var
 Error1, Error2:boolean;
 Str_Error, Str_Help:string;
 i:Integer;
 FP:TFerm;
begin
 FP:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm;
   Main_Form.StatusBar1.Panels[1].Text :='';
   Main_Form.StatusBar1.Panels[2].Text :='';

  Error1:=False;
  try
    StrToInt(Node_2_Edit.Text);
  except
    Error1:=True;
    str_error:='Ошибка ввода номера конечного узла';
    str_help:='Было введено не число';
  end;
  Error2:=False;
  try
    StrToInt(Node_1_Edit.Text);
  except
    Error2:=True;
    str_error:='Ошибка ввода номера начального узла';
    str_help:='Было введено не число';
  end;
 if Error1 or Error2 then
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
   Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
   exit;
  end;

 if (StrToInt(Node_1_Edit.Text)<=0) or
    (StrToInt(Node_2_Edit.Text)<=0) or
    (StrToInt(Node_1_Edit.Text)>FP.nyz1) or
    (StrToInt(Node_2_Edit.Text)>FP.nyz1) then
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Ввод недопустимых значений';
   Main_Form.StatusBar1.Panels[2].Text :='Не существует узла с введенным номером';
   exit;
  end;

 if StrToInt(Node_1_Edit.Text)=StrToInt(Node_2_Edit.Text) then
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Ввод недопустимых значений';
   Main_Form.StatusBar1.Panels[2].Text :='Начальный узел совпадает с конечным';
   exit;
  end;

 Error1:=False;
 for i:=1 to FP.nst1 do
  begin
   if((FP.iTopN[i,1]=StrToInt(Node_1_Edit.Text)) and (FP.iTopN[i,2]=StrToInt(Node_2_Edit.Text))) or ((FP.iTopN[i,1]=StrToInt(Node_2_Edit.Text)) and (FP.iTopN[i,2]=StrToInt(Node_1_Edit.Text))) then begin error1:=True; break; end;
  end;
 if Error1 then
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Стержень уже существует';
   Main_Form.StatusBar1.Panels[2].Text :='';
   exit;
  end
 else
  begin
   FP.nst1:=FP.nst1+1;
   FP.iTopN[FP.nst1,1]:=StrToInt(Node_1_Edit.Text);
   FP.iTopN[FP.nst1,2]:=StrToInt(Node_2_Edit.Text);
   FP.Fn[FP.nst1]:=0.1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
   ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
   ferma_FD_form.showD(f);
   Main.Main_Form.ActiveMDIChild.Repaint;
  end;

end;

procedure TFermaNewPivot_Form.NextPivot_BtnClick(Sender: TObject);
var
 Error1, Error2:boolean;
 Str_Error, Str_Help:string;
 i:Integer;
 FP:TFerm;
begin
 FP:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm;
   Main_Form.StatusBar1.Panels[1].Text :='';
   Main_Form.StatusBar1.Panels[2].Text :='';

  Error2:=False;
  try
    StrToInt(Node_2_Edit.Text);
  except
    Error2:=True;
    Node_2_Edit.SetFocus;
    Node_2_Edit.SelectAll;
    str_error:='Ошибка ввода номера конечного узла';
    str_help:='Было введено не число';
  end;
  Error1:=False;
  try
    StrToInt(Node_1_Edit.Text);
  except
    Error1:=True;
    Node_1_Edit.SetFocus;
    Node_1_Edit.SelectAll;
    str_error:='Ошибка ввода номера начального узла';
    str_help:='Было введено не число';
  end;
 if Error1 or Error2 then
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
   Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
   exit;
  end;

 if (StrToInt(Node_1_Edit.Text)<=0) or
    (StrToInt(Node_1_Edit.Text)>FP.nyz1) then
  begin
   Beep;
   Node_1_Edit.SetFocus;
   Node_1_Edit.SelectAll;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Ввод недопустимых значений';
   Main_Form.StatusBar1.Panels[2].Text :='Не существует узла с введенным номером';
   exit;
  end;

 if (StrToInt(Node_2_Edit.Text)<=0) or
    (StrToInt(Node_2_Edit.Text)>FP.nyz1) then
  begin
   Beep;
   Node_2_Edit.SetFocus;
   Node_2_Edit.SelectAll;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Ввод недопустимых значений';
   Main_Form.StatusBar1.Panels[2].Text :='Не существует узла с введенным номером';
   exit;
  end;

 if StrToInt(Node_1_Edit.Text)=StrToInt(Node_2_Edit.Text) then
  begin
   Beep;
   Node_1_Edit.SetFocus;
   Node_1_Edit.SelectAll;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Ввод недопустимых значений';
   Main_Form.StatusBar1.Panels[2].Text :='Начальный узел совпадает с конечным';
   exit;
  end;

 Error1:=False;
 for i:=1 to FP.nst1 do
  begin
   if((FP.iTopN[i,1]=StrToInt(Node_1_Edit.Text)) and (FP.iTopN[i,2]=StrToInt(Node_2_Edit.Text))) or ((FP.iTopN[i,1]=StrToInt(Node_2_Edit.Text)) and (FP.iTopN[i,2]=StrToInt(Node_1_Edit.Text))) then begin error1:=True; break; end;
  end;
 if Error1 then
  begin
   Beep;
   Node_1_Edit.SetFocus;       
   Node_1_Edit.SelectAll;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка. Стержень уже существует';
   Main_Form.StatusBar1.Panels[2].Text :='';
   exit;
  end
 else
  begin
   FP.nst1:=FP.nst1+1;
   FP.iTopN[FP.nst1,1]:=StrToInt(Node_1_Edit.Text);
   FP.iTopN[FP.nst1,2]:=StrToInt(Node_2_Edit.Text);
   FP.Fn[FP.nst1]:=0.1;   
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
   ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
   ferma_FD_form.showD(f);
   Main.Main_Form.ActiveMDIChild.Repaint;
   Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
   Node_1_Edit.Enabled:=True;
   Node_2_Edit.Enabled:=True;
   Node_1_Edit.SetFocus;
   Node_1_Edit.Text:='';
   Node_2_Edit.Text:='';
   FormRepaint(Self);
  end;

end;

procedure TFermaNewPivot_Form.FormShow(Sender: TObject);
begin
 Node_1_Edit.Enabled:=True;
 Node_2_Edit.Enabled:=True;
 Node_1_Edit.SetFocus;
 Node_1_Edit.Text:='';
 Node_2_Edit.Text:='';
 FormRepaint(Self);
end;

end.
