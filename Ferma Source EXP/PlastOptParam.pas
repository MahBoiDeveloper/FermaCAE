unit PlastOptParam;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TPlastOptParam_Form = class(TForm)
    ebsi_Edt: TEdit;
    maxkit_Edt: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Ok_Btn: TBitBtn;
    Cancel_Btn: TBitBtn;
    ton2_label: TLabel;
    Ton1_Edit: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Execute(var ebsi:single;var maxkit:integer):boolean;
  end;

var
  PlastOptParam_Form: TPlastOptParam_Form;

implementation

uses Main,plast_m;

{$R *.DFM}

function TPlastOptParam_Form.Execute(var ebsi:single; var maxkit:integer):boolean;
begin
  Label2.Caption:='Допустимая толщина ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
  ton2_label.Caption:='Начальная толщина ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
  ton1_edit.Text:=floattostr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1);
  Result:=(ShowModal=mrOk);
  if Result then
    try
      ebsi:=StrToFloat(ebsi_Edt.Text);
      maxkit:=StrToInt(maxkit_Edt.Text);
      if maxkit>20 then begin maxkit:=20;end;
    except
      MessageDlg('Ошибка во введенных данных',mtError,[mbOk],0);
      Result:=false;
    end;
end;

procedure TPlastOptParam_Form.FormCreate(Sender: TObject);
begin
ebsi_Edt.Text:=floattostr(0.0);
maxkit_Edt.Text:= inttostr(2);
end;

end.
