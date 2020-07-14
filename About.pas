unit About;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TAbout_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Version_Lbl: TLabel;
    Build_Lbl: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About_Form: TAbout_Form;

implementation

{$R *.DFM}

procedure TAbout_Form.FormCreate(Sender: TObject);
type
  verinfo = record
              dwSignature:longint;
              dwStrucVersion:longint;
              dwFileVersionMS:longint;
              dwFileVersionLS:longint;
              dwProductVersionMS:longint;
              dwProductVersionLS:longint;
              dwFileFlagsMask:longint;
              dwFileFlags:longint;
              dwFileOS:longint;
              dwFileType:longint;
              dwFileSubtype:longint;
              dwFileDateMS:longint;
              dwFileDateLS:longint;
            end;
var
  p:pointer;
  pi:^verinfo;
  FName:PChar;
  {i,}len:longint;
  i1 : cardinal;
begin
  FName:=StrAlloc(Length(Application.EXEName)+1);
  StrPCopy(FName,Application.EXEName);
  len := GetFileVersionInfoSize(FName, i1);
  GetMem(p,len);
  GetFileVersionInfo(FName,0,len,p);
  VerQueryValue(p,'\',pointer(pi),i1);
  Version_Lbl.Caption:='Версия '+IntToStr(HiWord(pi^.dwFileVersionMS))+'.'+
                                  IntToStr(LoWord(pi^.dwFileVersionMS));
  Build_Lbl.Caption:='Build '+IntToStr(HiWord(pi^.dwFileVersionLS))+'.'+
                              IntToStr(LoWord(pi^.dwFileVersionLS));
  StrDispose(FName);
  FreeMem(p);
end;



end.
