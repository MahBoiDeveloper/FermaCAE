unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TSplash_Form = class(TForm)
    Splash_Timer: TTimer;
    Image1: TImage;
    Label2: TLabel;
    Label6: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Splash_TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Splash_Form: TSplash_Form;

implementation
 uses Main;
{$R *.DFM}

procedure TSplash_Form.Image1Click(Sender: TObject);
begin
  Close;
end;


procedure TSplash_Form.FormShow(Sender: TObject);
begin
  Splash_Form.Width   := 328;
  Splash_Form.Height  := 248;

end;

procedure TSplash_Form.Splash_TimerTimer(Sender: TObject);
begin
Close;
end;

end.















