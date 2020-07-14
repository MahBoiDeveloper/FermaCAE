unit NewNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Main, Ferma_M;

type
  TFermaNewNode_Form = class(TForm)
    Bevel1: TBevel;
    NodeName: TLabel;
    NewNode_Btn: TBitBtn;
    NextNode_Btn: TBitBtn;
    CancelNode_Btn: TBitBtn;
    Coord_X_Edit: TEdit;
    Coord_Y_Edit: TEdit;
    LabelX: TLabel;
    LabelY: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Max_X: TLabel;
    Max_Y: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure FormShow(Sender: TObject);
    procedure NewNode_BtnClick(Sender: TObject);
    procedure CancelNode_BtnClick(Sender: TObject);
    procedure NextNode_BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function isRealNumber(s:string):boolean;

var
  FermaNewNode_Form: TFermaNewNode_Form;

implementation

uses Ferma_FD;


{$R *.DFM}

// Функция проверки: число ли это с плавающей точкой?
function isRealNumber(s:string):boolean;
begin
  Result:=true;
  try
    StrToFloat(s);
  except
    Result:=false;
  end;
end;


procedure TFermaNewNode_Form.FormShow(Sender: TObject);
begin
  LabelX.Caption:='Координата X  ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
  LabelY.Caption:='Координата Y  ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
  NodeName.Caption:='Узел №'+IntToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1);
  Max_X.Caption:=' <= '+FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_X);
  Max_Y.Caption:=' <= '+FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_Y);
  if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nyz1=8 then
   begin
    NextNode_Btn.Default:=False;
    NewNode_Btn.Default:=True;
    NextNode_Btn.Enabled:=False;
   end
  else
   begin
    NextNode_Btn.Default:=True;
    NewNode_Btn.Default:=False;
    NextNode_Btn.Enabled:=True;
   end;
  Coord_X_Edit.SetFocus;

end;

procedure TFermaNewNode_Form.NewNode_BtnClick(Sender: TObject);
var
 str_error,str_help:string;
 error:boolean;
 i:integer;
begin
  str_error:='';
  str_help:='';
  error:=False;

   if isRealNumber(Coord_Y_Edit.Text) then
    begin
     if  StrToFloat(Coord_Y_Edit.Text)<0 then
      begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено отрицательное значение';
       error:=True;
      end
     else if  StrToFloat(Coord_Y_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_Y then
      begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено значение вне области';
       error:=True;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено не число';
       error:=True;
    end;

   if isRealNumber(Coord_X_Edit.Text) then
    begin
     if  StrToFloat(Coord_X_Edit.Text)<0 then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено отрицательное значение';
       error:=True;
      end
     else if  StrToFloat(Coord_X_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_X then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено значение вне области';
       error:=True;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено не число';
       error:=True;
    end;

   if Error then
    begin
     Beep;
     Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
     Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
    end
   else
    begin
     for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do
      begin
       if (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,1])=Coord_X_Edit.Text) and
          (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,2])=Coord_Y_Edit.Text) then
          begin
           error:=True;
           break
          end;
      end;
      if Error then
       begin
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Узел с данными координатами уже существует';
        Main_Form.StatusBar1.Panels[2].Text :='Задайте другие значения для координат';
       end
      else
       begin
        Coord_X_Edit.Text:=FormatFloat('0.##',StrToFloat(Coord_X_Edit.Text));
        Coord_Y_Edit.Text:=FormatFloat('0.##',StrToFloat(Coord_Y_Edit.Text));
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1,1]:=StrToFloat(Coord_X_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1,2]:=StrToFloat(Coord_Y_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1;
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
        ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
        Main_Form.F_Save_TBtn.Enabled:=True;
        ferma_FD_form.showD(f);
        Main.Main_Form.ActiveMDIChild.Repaint;
        Coord_X_Edit.Text:='';
        Coord_Y_Edit.Text:='';
        Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
        Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
        Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
       end;

    end;

end;

procedure TFermaNewNode_Form.CancelNode_BtnClick(Sender: TObject);
begin
 Coord_X_Edit.Text:='';
 Coord_Y_Edit.Text:='';
end;

procedure TFermaNewNode_Form.NextNode_BtnClick(Sender: TObject);
var
 str_error,str_help:string;
 error:boolean;
 i:integer;
begin
  str_error:='';
  str_help:='';
  error:=False;
  Coord_X_Edit.SetFocus;  
   if isRealNumber(Coord_Y_Edit.Text) then
    begin
     if  StrToFloat(Coord_Y_Edit.Text)<0 then
      begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено отрицательное значение';
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
       error:=True;
      end
     else if  StrToFloat(Coord_Y_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_Y then
      begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено значение вне области';
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
       error:=True;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено не число';
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
       error:=True;
    end;

   if isRealNumber(Coord_X_Edit.Text) then
    begin
     if  StrToFloat(Coord_X_Edit.Text)<0 then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено отрицательное значение';
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
       error:=True;
      end
     else if  StrToFloat(Coord_X_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_X then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено значение вне области';
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
       error:=True;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено не число';
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
       error:=True;
    end;


   if Error then
    begin
     Beep;
     Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
     Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
    end
   else
    begin
     for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do
      begin
       if (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,1])=Coord_X_Edit.Text) and
          (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,2])=Coord_Y_Edit.Text) then
          begin
           error:=True;
           break
          end;
      end;
      if Error then
       begin
        Beep;
        Coord_X_Edit.SelectAll;
        Coord_X_Edit.SetFocus;
        Main_Form.StatusBar1.Panels[1].Text :='Узел с данными координатами уже существует';
        Main_Form.StatusBar1.Panels[2].Text :='Задайте другие значения для координат';
       end
      else
       begin
        Coord_X_Edit.Text:=FormatFloat('0.##',StrToFloat(Coord_X_Edit.Text));
        Coord_Y_Edit.Text:=FormatFloat('0.##',StrToFloat(Coord_Y_Edit.Text));       
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1,1]:=StrToFloat(Coord_X_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1,2]:=StrToFloat(Coord_Y_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1;
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
        ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
        Main_Form.F_Save_TBtn.Enabled:=True;
        ferma_FD_form.showD(f);
        Main.Main_Form.ActiveMDIChild.Repaint;
        Coord_X_Edit.Text:='';
        Coord_Y_Edit.Text:='';
        Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
        Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
        Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
       end;

    end;
  NodeName.Caption:='Узел №'+IntToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1+1);
  if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nyz1=8 then
   begin
    NextNode_Btn.Default:=False;
    NewNode_Btn.Default:=True;
    NextNode_Btn.Enabled:=False;
   end
  else
   begin
    NextNode_Btn.Default:=True;
    NewNode_Btn.Default:=False;
    NextNode_Btn.Enabled:=True;
   end;

end;

end.
