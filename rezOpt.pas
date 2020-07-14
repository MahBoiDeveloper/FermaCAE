unit rezOpt;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,Ferma_M;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.FormShow(Sender: TObject);
begin
    showmessage(  Ferma_Form.FileName);
 //   AssignFile(f,filename)
 //   AssignFile(dd,ChangeFileExt(filename,'.vc1'));
end;

end.
