unit NewOptParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Math;

type
  TNewFermOptParam_form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label1: TLabel;
    Bevel3: TBevel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



     type Optimiz_parameters=Record
     name: array[0..20] of Pchar;
     val: array [0..20] of extended;
  end;


  type
     TMethodProc=procedure(pnt:pointer);
     TMethodFunc=function():pointer;
     TMethodProc2=procedure();



  var
  NewFermOptParam_form: TNewFermOptParam_form;
   LibHandle:THandle;
   sf:TMethodFunc;
   sp:TMethodProc;
     r:real;
     i:integer;
     path:string;
     par:^Optimiz_parameters;
     ps:pchar;
    dop_lab:array [0..20] of Tlabel;
    dop_edt:array [0..20] of TEdit;
    dop_val:array [0..20] of extended;
    par_count:integer;
     index:integer;
     implementation
     uses Ferma_M,main,SelectMetod;
{$R *.DFM}
procedure TNewFermOptParam_form.FormCreate(Sender: TObject);
begin
  ////////////////
end;

procedure TNewFermOptParam_form.FormActivate(Sender: TObject);
var i,j,k:integer;
begin

    path:=list[index-3];
    LibHandle:=LoadLibrary(PChar(path));
    @sf   :=GetProcAddress(LibHandle,'Get_Opt_Param');
           try
    par:=sf;
//    dop_lab[1].Caption:=par^[1];
       except
     MessageDlg('Ошибка в библиотеке',mtError,[mbOk],0);
       end;
par_count:=0;
    for i:=0 to 20 do if par.name[i]<>'' then inc(par_count);


  for i:=0 to par_count-1 do
     begin
  dop_lab[i]:= Tlabel.Create(Self);
  dop_lab[i].Left := 8;
  dop_lab[i].width := 171;
  dop_lab[i].Top := 35+(i)*24;
  dop_lab[i].caption:='Значение какой нибудь величины';
  dop_lab[i].Parent := self as TWinControl;
  dop_lab[i].Show;

  dop_edt[i]:= TEdit.Create(Self);
  dop_edt[i].Left := 216;
  dop_edt[i].width :=112;
  dop_edt[i].Top := 34+(i)*24;
  dop_edt[i].text:='123456789';
  dop_edt[i].Ctl3D:=false;;
  dop_edt[i].Parent := self as TWinControl;
  dop_edt[i].Show;
      end;
  bevel2.height:=10+par_count*24;
  bevel3.Top:=bevel2.Top+bevel2.Height+2;
  button1.top:=bevel3.Top+7;
    for i:=0 to par_count-1 do dop_lab[i].caption:=par^.name[i];
    for i:=0 to par_count-1 do dop_edt[i].text:=floattostr(par^.val[i]);


//    FreeLibrary(LibHandle);
  end;



procedure TNewFermOptParam_form.Button1Click(Sender: TObject);
type
   THelloWorld = procedure(fn:pchar);
var
     LibHandle:THandle;
     i:integer;
     sp1:THelloWorld;
 begin
   begin
    for i:=0 to par_count-1 do dop_val[i]:=strtofloat(dop_edt[i].text);

     LibHandle:=LoadLibrary(Pchar(path));
         @sp:=GetProcAddress(LibHandle,'Set_Opt_Param');
        try
    sp(@dop_val);
        except
     MessageDlg('Ошибка в библиотеке',mtError,[mbOk],0);
        end;

     @sp1:=GetProcAddress(LibHandle,'say_hallo');

        try
     sp1(Pchar(Project_Name));
        except
     MessageDlg('Ошибка в библиотеке',mtError,[mbOk],0);
        end;
//     FreeLibrary(LibHandle);
   end;
//   FreeLibrary(LibHandle);
    NewFermOptParam_form.Close;
 end;

procedure TNewFermOptParam_form.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var i:integer;
  begin
  i:=0;
  for i:=0 to par_count-1 do
  begin
  dop_lab[i].free;
  dop_edt[i].free;
  end ;

   end;

end.
