unit FermOptParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferma_M, Grids, ComCtrls, ToolWin, ImgList;

type
  TFermOptParam_Form = class(TForm)
    fmi_Edt: TEdit;
    ebsi_Edt: TEdit;
    maxkit_Edt: TEdit;
    MinS_Label: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Ok_Btn: TBitBtn;
    Cancel_Btn: TBitBtn;
    OptTol_Grd: TStringGrid;
    ImageList: TImageList;
    ljambda_Edt: TEdit;
    Label1: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Visio_Tol_SBtnClick(Sender: TObject);


    //procedure Ok_BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute(var fmi,ebsi:single;var maxkit,ljambda:integer):boolean;
  end;

var
  FermOptParam_Form: TFermOptParam_Form;

implementation

uses Main, Fix_node, ForcNode, SimplRezFerm,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1;

//uses Main, Ferma_FD;

{$R *.DFM}

function TFermOptParam_Form.Execute(var fmi,ebsi:single; var maxkit,ljambda:integer):boolean;

var
l11:real;
begin
  Result:=(ShowModal=mrOk);
  if Result then
   begin

    try
      fmi:=StrToFloat(fmi_Edt.Text);
      ebsi:=StrToFloat(ebsi_Edt.Text);
      maxkit:=StrToInt(maxkit_Edt.Text);
      ljambda:=StrToInt(ljambda_Edt.Text);
    except
      Beep;
      MessageDlg('Ошибка ввода параметров оптимизации.'+#13+'Один из параметров задан неверно. Введено не число.',mtError,[mbOk],0);
      Result:=false;
      exit;
    end;
    if fmi<0 then
     begin
      Beep;
      MessageDlg('Ошибка ввода минимальной площади сечения стержня.'+#13+'Введено отрицательное значение.',mtError,[mbOk],0);
      Result:=false;
      exit;
     end;
    if (ebsi>=1)or(ebsi<=0) then
     begin
      Beep;
      MessageDlg('Ошибка ввода точности.'+#13+'Введено значение вне допустимого диапазона.',mtError,[mbOk],0);
      Result:=false;
      exit;
     end;
    if (maxkit<1) or (maxkit>1000) then
     begin
      Beep;
      MessageDlg('Ошибка ввода числа итераций.'+#13+'Введено значение вне допустимого диапазона.',mtError,[mbOk],0);
      Result:=false;
      exit;
     end;
//        l11:= 3.14*sqrt(   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.e1 / abs(  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.sd1)); // проверка на условие по новому алгоритму  столярчука

     if (ljambda<50) or (ljambda>210) then
     begin
      Beep;
      MessageDlg(('Ошибка ввода коэффициента сжатых стрежней.'+#13+'Введено значение вне допустимого диапазона. (50 - 210)'),mtError,[mbOk],0);
      Result:=false;
      exit;
     end;


  end;

end;

procedure TFermOptParam_Form.FormCreate(Sender: TObject);

begin
 fmi_Edt.Text:=floattostr(0.0000000001);
 ebsi_Edt.Text:=floattostr(0.00001);
 maxkit_Edt.Text:=IntToStr(100);
 ljambda_Edt.Text:=IntToStr(50);

end;

procedure TFermOptParam_Form.FormShow(Sender: TObject);
var
 i:integer;
begin
 //SV_TBtn.Left := Bevel2.Width - SV_TBtn.Width;
 MinS_Label.Caption:='Минимальная площадь стержней ['+ Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';
 OptTol_Grd.Cells[0,0]:='№ Стержня';
 OptTol_Grd.Cells[1,0]:='           Начальная площадь cечения стержня ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';
 OptTol_Grd.Height:=(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1)*18+22;
 OptTol_Grd.RowCount:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1+1;
 //Bevel2.Height := OK_Btn.Top + 15;
 //Bevel1.Height := OptTol_Grd.Top + OptTol_Grd.Height;
 FermOptParam_Form.Height := Bevel1.Top + Bevel1.Height;
 if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 >= 1 then
    begin
     OptTol_Grd.FixedRows:=1;
     OptTol_Grd.FixedCols:=1;
     OptTol_Grd.Enabled:=True;
    end
   else
    begin
     OptTol_Grd.FixedCols:=0;
     OptTol_Grd.FixedRows:=0;
     OptTol_Grd.Enabled:=False;
    end;
   for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do OptTol_Grd.Cells[0,i]:=' '+IntToStr(i);
   for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do
    begin
     OptTol_Grd.Cells[1,i]:=FloatToStr({FormatFloat('0.######',}Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
    end;
 if OptTol_Grd.Visible then
  begin
   FermOptParam_Form.Height:=OptTol_Grd.Height+144+4;
  end
 else
  begin
   FermOptParam_Form.Height := Bevel2.Top + Bevel2.Height;
  end;
 FermOptParam_Form.Top:=Round(Screen.Height/2-(OptTol_Grd.Height+144+4)/2);
 FermOptParam_Form.Left:=Round(Screen.Width/2-FermOptParam_Form.Width/2);
end;

procedure TFermOptParam_Form.Visio_Tol_SBtnClick(Sender: TObject);
begin
 if not OptTol_Grd.Visible then
  begin
   OptTol_Grd.Visible:=True;
   FermOptParam_Form.Height:=OptTol_Grd.Height+144+4;
  end
 else
  begin
   OptTol_Grd.Visible:=False;
   FermOptParam_Form.Height:=139;
  end;

end;

end.
