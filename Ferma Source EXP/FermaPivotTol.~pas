unit FermaPivotTol;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferm_Dat, Ferma_M;

type
  TFermaPivotTol_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Ok_Btn: TBitBtn;
    Cancel_Btn: TBitBtn;
    Bevel3: TBevel;
    Num_Label: TLabel;
    Tol_Label: TLabel;
    Tol_Edit: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ok_BtnClick(Sender: TObject);
    procedure Cancel_BtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PTF:TFerm;
    NumPivot:integer;
  end;

function isRealNumber(s:string):boolean;

var
  FermaPivotTol_Form: TFermaPivotTol_Form;

implementation

uses Main, Ferma_FD;

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

procedure TFermaPivotTol_Form.FormShow(Sender: TObject);
begin
Num_Label.Caption:='Стержень №'+IntToStr(NumPivot);
Tol_Label.Caption:='Площадь сечения стержня ['+PTF.s_lin+'**2]';
Tol_Edit.Text:=FloatToStr(PTF.Fn[NumPivot]);
Tol_Edit.SelectAll;
Tol_Edit.SetFocus;
end;



procedure TFermaPivotTol_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 with  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild) do
  begin
   TolOk:=1;
  end

end;

procedure TFermaPivotTol_Form.Ok_BtnClick(Sender: TObject);
begin
  if isRealNumber(Tol_Edit.Text) then
    begin
     if (StrToFloat(Tol_Edit.Text)>0) then
      begin
       PTF.Fn[NumPivot]:=StrToFloat(Tol_Edit.Text);
       Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
       ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
       Main_Form.F_Save_TBtn.Enabled:=True;
       Main_Form.StatusBar1.Panels[1].Text :='';
       Main_Form.StatusBar1.Panels[2].Text :='';
       ferma_FD_form.showD(PTF);
      end
     else
      begin
       Beep;
       Main_Form.StatusBar1.Panels[1].Text :='Ошибка ввода площади сечения стержня';
       Main_Form.StatusBar1.Panels[2].Text :='Было введено недопустимое значение';
      end;
    end
  else
   begin
    Beep;
    Main_Form.StatusBar1.Panels[1].Text :='Ошибка ввода площади сечения стержня';
    Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
   end;

end;

procedure TFermaPivotTol_Form.Cancel_BtnClick(Sender: TObject);
begin
 Main_Form.StatusBar1.Panels[1].Text := '';
end;

end.
