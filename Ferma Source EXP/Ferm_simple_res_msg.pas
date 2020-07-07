unit Ferm_simple_res_msg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TSimple_ferm_res_msg = class(TForm)
    Label1: TLabel;
    Ok_btn: TBitBtn;
    Cancel_btn: TBitBtn;
    procedure Ok_btnClick(Sender: TObject);
    procedure Cancel_btnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    
  end;

var
  Simple_ferm_res_msg: TSimple_ferm_res_msg;

implementation

uses Ferma_M, Main;

{$R *.dfm}



procedure TSimple_ferm_res_msg.Cancel_btnClick(Sender: TObject);
begin
Simple_ferm_res_msg.Close;
end;

procedure TSimple_ferm_res_msg.Ok_btnClick(Sender: TObject);
begin
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);
Simple_ferm_res_msg.Close;
end;

procedure TSimple_ferm_res_msg.FormShow(Sender: TObject);
begin
  Visible := True;
  BringToFront;
end;

end.
