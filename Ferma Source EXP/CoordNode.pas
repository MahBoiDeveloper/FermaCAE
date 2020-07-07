unit CoordNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, StdCtrls, Ferma_M, Ferma_Fd;

type
  TCoordNode_Form = class(TForm)
    Bevel1: TBevel;
    NodeName: TLabel;
    OK_Btn: TBitBtn;
    Cancel_Btn: TBitBtn;
    Pred_SBtn: TSpeedButton;
    Next_SBtn: TSpeedButton;
    Bevel2: TBevel;
    Coord_X_Edit: TEdit;
    Coord_Y_Edit: TEdit;
    LabelX: TLabel;
    LabelY: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Max_X: TLabel;
    Max_Y: TLabel;
    Bevel3: TBevel;
    Izm_Btn: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ReShow(Sender: TObject);
    procedure Next_SBtnClick(Sender: TObject);
    procedure Pred_SBtnClick(Sender: TObject);
    procedure Izm_BtnClick(Sender: TObject);
    procedure OK_BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RealNode:integer;
  end;
function isRealNumber(s:string):boolean;
var
  CoordNode_Form: TCoordNode_Form;

implementation

uses Main;

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

procedure TCoordNode_Form.ReShow(Sender: TObject);
begin
  NodeName.Caption:='Узел №'+IntToStr(RealNode);
  Coord_X_Edit.Text:=FloatToStr(Ferma_FD.f.corn[RealNode,1]);
  Coord_Y_Edit.Text:=FloatToStr(Ferma_FD.f.corn[RealNode,2]);
  if RealNode=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nyz1 then
   begin
    if (Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nyz1=1) then
     begin
      Next_SBtn.Enabled:=False;
      Pred_SBtn.Enabled:=False;
     end
    else
     begin
      Next_SBtn.Enabled:=False;
      Pred_SBtn.Enabled:=True;
     end
   end
  else if RealNode=1 then
   begin
    Next_SBtn.Enabled:=True;
    Pred_SBtn.Enabled:=False;
   end
  else
   begin
    Next_SBtn.Enabled:=True;
    Pred_SBtn.Enabled:=True;
   end;
  Coord_X_Edit.SetFocus;
  Coord_X_Edit.SelectAll;
end;

procedure TCoordNode_Form.FormShow(Sender: TObject);
begin

  LabelX.Caption:='Координата X  ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
  LabelY.Caption:='Координата Y  ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
  Max_X.Caption:=' <= '+FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_X);
  Max_Y.Caption:=' <= '+FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_Y);
  RealNode:=Ferma_FD.Coord_Node_Pm;
  ReShow(self);

end;

procedure TCoordNode_Form.Next_SBtnClick(Sender: TObject);
begin
 RealNode:=RealNode+1;
 ReShow(Self);
end;

procedure TCoordNode_Form.Pred_SBtnClick(Sender: TObject);
begin
 RealNode:=RealNode-1;
 ReShow(Self);
end;

procedure TCoordNode_Form.Izm_BtnClick(Sender: TObject);
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
       error:=True;
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
      end
     else if  StrToFloat(Coord_Y_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_Y then
      begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено значение вне области';
       error:=True;
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты Y';
       str_help:='Было введено не число';
       error:=True;
       Coord_Y_Edit.SelectAll;
       Coord_Y_Edit.SetFocus;
    end;

   if isRealNumber(Coord_X_Edit.Text) then
    begin
     if  StrToFloat(Coord_X_Edit.Text)<0 then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено отрицательное значение';
       error:=True;
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
      end
     else if  StrToFloat(Coord_X_Edit.Text)>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Region_X then
      begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено значение вне области';
       error:=True;
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
      end;
    end
   else
    begin
       str_error:='Ошибка ввода координаты X';
       str_help:='Было введено не число';
       error:=True;
       Coord_X_Edit.SelectAll;
       Coord_X_Edit.SetFocus;
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
          (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,2])=Coord_Y_Edit.Text) and
          (RealNode<>i)then
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
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[RealNode,1]:=StrToFloat(Coord_X_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[RealNode,2]:=StrToFloat(Coord_Y_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
        ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
        ferma_FD_form.showD(f);
        Main.Main_Form.ActiveMDIChild.Repaint;
        Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
        Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
        Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
       end;

    end;
    


end;

procedure TCoordNode_Form.OK_BtnClick(Sender: TObject);
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
          (FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[i,2])=Coord_Y_Edit.Text) and
          (RealNode<>i)then
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
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[RealNode,1]:=StrToFloat(Coord_X_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Corn[RealNode,2]:=StrToFloat(Coord_Y_Edit.Text);
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=true;
        ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
        ferma_FD_form.showD(f);
        Main.Main_Form.ActiveMDIChild.Repaint;
        Main_Form.StatusBar1.Panels[1].Text :=Str_Error;
        Main_Form.StatusBar1.Panels[2].Text :=Str_Help;
        Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
       end;

    end;

end;

end.
