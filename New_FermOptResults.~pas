unit New_FermOptResults;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, ExtCtrls, Ferma_M, Ferm_Dat,FermOptParam,SimplRezFerm;

type
  TNewFermOptResults_Form = class(TForm)
    Ok_Btn: TBitBtn;
    Bevel2: TBevel;
    Label3: TLabel;
    OK_Bevel: TBevel;
    Label5: TLabel;
    FermWeight_Edt2: TEdit;
    Size_Bevel2: TBevel;
    Label8: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label10: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    saveas:tsavedialog;
    Label7: TLabel;
    Value_Edt2: TEdit;
    Label6: TLabel;
    StartValue_Edt2: TEdit;
    Label12: TLabel;
    MinS_edt2: TEdit;
    Label4: TLabel;
    Precission_Edt2: TEdit;
    Label13: TLabel;
    lambda_edt2: TEdit;
    Bevel5: TBevel;
    dop21_edt: TEdit;
    dop22_edt: TEdit;
    dop23_edt: TEdit;
    dop21_lab: TLabel;
    dop22_lab: TLabel;
    dop23_lab: TLabel;
    Image2: TImage;
    Areas_Grd2: TStringGrid;
    Bevel1: TBevel;
    Label1: TLabel;
    IterationNumber_Edt2: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 //   procedure Button1Click(fn:string);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    NumOk:boolean; //Была ли включена нумерация ??
  public
    { Public declarations }
  tol:array[1..15] of extended;        // потребные площади
  tol1:array[1..15] of extended;        // потребные площади -без учета
  flg: boolean; 
  rname:string;
    procedure Execute(fn:string);

  end;

var
  NewFermOptResults_Form: TNewFermOptResults_Form;

implementation

uses Main, FermOptResults;

{$R *.DFM}

procedure TNewFermOptResults_Form.Execute(fn:string);
var
  ff:System.text;
  s,s_lin,s_for:string;
  kst,i,it:integer;
  pogr,sv,vm,start_value:extended;
  tol:array[1..15] of extended;        // потребные площади
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
begin
  //DecimalSeparator:=LOCALE_SDECIMAL;//'.';
  rname:=fn;
  AssignFile(ff,fn);
  Reset(ff);
  readln(ff);// Считывание строки для проверки совместимости версий
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='Размерности';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='Число итераций';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  readln(ff,s);
  MinS_edt2.text:=FormatFloat('0.000e+00',strtofloat(s));
  readln(ff);
  readln(ff,s);
  lambda_edt2.text:=FormatFloat('0.',strtofloat(s));
  readln(ff);

      if not eof(ff)=true then
         for i:=1 to kst do readln (ff,Mom_in[i]);

  vm:=0;
  for i:=1 to kst do vm:=vm+li[i]*tol[i];
  // Дополнительные парраметры,если есть...
    if not eof(ff) then
      begin
  dop21_lab.Enabled:=true;
  readln(ff,s);
  dop21_lab.Caption:=s;
  readln(ff,s);
  dop21_edt.Text:=s;
      end;
  if not eof(ff) then
      begin
  dop22_lab.Enabled:=true;
  readln(ff,s);
  dop22_lab.Caption:=s;
  readln(ff,s);
  dop22_edt.Text:=s;
      end;
  if not eof(ff) then
      begin
  dop23_lab.Enabled:=true;
  readln(ff,s);
  dop23_lab.Caption:=s;
  readln(ff,s);
  dop23_edt.Text:=s;
      end;

   CloseFile(ff);


  // Вывод данных
  Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
  Start_Value:=0;
  for i:=1 to Current_Ferm.nst1 do
   begin
   start_value:=start_value+Current_Ferm.Fn[i]*
    sqrt(
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])+
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])
        );
   end;

  // Вывод данных
  IterationNumber_Edt2.Text:=IntToStr(it-1);
  Precission_Edt2.Text:=FormatFloat('0.000e+00',pogr);
  Value_Edt2.Text:=FormatFloat('0.000e+00',vm);
  FermWeight_Edt2.Text:=FormatFloat('0.000e+00',sv);
  Areas_Grd2.RowCount:=kst+1;
  Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
  Start_Value:=0;
  for i:=1 to Current_Ferm.nst1 do
   begin
   start_value:=start_value+Current_Ferm.Fn[i]*
    sqrt(
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])+
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])
        );
   end;
  StartValue_Edt2.Text:=FormatFloat('0.000e+00',start_value);
  if kst > 0 then
   begin
    Areas_Grd2.FixedRows:=1;
    Areas_Grd2.FixedCols:=1;
   end
  else
   begin
    Areas_Grd2.FixedCols:=0;
    Areas_Grd2.FixedRows:=0;
   end;
  Areas_Grd2.RowHeights[0]:=18;
  Areas_Grd2.Cells[0,0]:='№ Cтержня';
  Areas_Grd2.Cells[1,0]:='   Исходная площадь';
  Areas_Grd2.Cells[2,0]:=' Полученная площадь';
  
  for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do
    begin
      Areas_Grd2.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
    end;
  for i:=1 to kst do
    begin
      Areas_Grd2.Cells[0,i]:=IntToStr(i);
      Areas_Grd2.Cells[2,i]:=FormatFloat('0.000e+00',tol[i]);
    end;

{Вроде всё}

  ShowModal;
end;


procedure TNewFermOptResults_Form.FormShow(Sender: TObject);
var
 num:integer;
begin
 caption:='Результаты оптимизационного расчета для '+ExtractFileName(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).real_fname);
 NumOk:=True;
{ if Main_Form.FermaNumberButton.Down=False then
  begin
   Main_Form.FermaNumberButton.Down:=True;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   NumOk:=False;
  end;    }
 num:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1;
 Areas_Grd2.Height:=num*18+22;
 Size_Bevel2.Height:=num*19+22+32;


  OK_Btn.Top := OK_Bevel.Top + 20;
  Panel1.Top :=  OK_Bevel.Top + 5;
  //  Button1.Top := OK_Bevel.Top + 20;

 //FermOptResults_Form.Height := Ok_Btn.Top + OK_Btn.Height + 15;
 FermOptResults_Form.Top:=Round(Screen.Height/2-FermOptResults_Form.Height/2);
 FermOptResults_Form.Left:=Round(Screen.Width/2-FermOptResults_Form.Width/2);

 end;

procedure TNewFermOptResults_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if not NumOk then
  begin
   {Main_Form.FermaNumberButton.Down:=False;  }
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
  end;
end;


procedure TNewFermOptResults_Form.Button1Click(Sender: TObject);
     type
     TMethodProc=procedure(Fn:PChar);


var
  fn,ff1:string;
  ff,d1,dd:System.text;
  NST:integer;                           {ЧИСЛО СТЕРЖНЕЙ }
  NYZ:integer;                           {ЧИCЛO УЗЛOB}
  NY:integer;                            {ЧИCЛO ЗAKPEПЛEHИЙ}
  E:single;                              {MOДУЛЬ УПPУГOCTИ}
  NSN:integer;                           {ЧИCЛO CЛУЧAEB HAГPУЖEHИЯ}
  SD:single;                             {ДOПУCKAEMOE HAПPЯЖEHИE}
  PLTN:single;                           {ПЛОТНОСТЬ МАТЕРИАЛА}
  ITOP: array[1..15,1..2] of integer;    {ТОПOЛOГИЯ CTEPЖHEЙ}
  COR:  array[1..9,1..2] of single;      {KOOPДИHATЫ УЗЛOB}
  Fs,Fp:    array[1..15] of single;         {HAЧAЛЬHЫE ПЛOЩAДИ}
  MS:   array[1..9,1..2] of integer;     {ЗAKPEПЛEHИЯ УЗЛOB}
  P:    array[1..18,1..3] of single;     {HAГPУЗKИ}
  s_lin:string;                          {РАЗМЕРНОСТИ ВЕЛИЧИН}
  s_for:string;                          {РАЗМЕРНОСТИ ВЕЛИЧИН}
  region_x:extended;                     {РАЗМЕРЫ ОБЛАСТИ}
  region_y:extended;                     {РАЗМЕРЫ ОБЛАСТИ}
  s:string;
  i,j,k:integer;
  rf: TreplaceFlags;

begin
fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
        ff1:=ChangeFileExt(fn,'');
        //ff1:=ff1+'_optR.frm';
        ff1:=StringReplace(ff1,'_tmp','_optR.frm',rf);
     saveas.FileName:=ff1;
     if saveas.Execute then
     begin
      ff1:=Saveas.FileName;
     end;
     if fileexists(ff1) then deletefile(ff1);
     if fileexists(changefileext(ff1,'.vyv')) then deletefile(changefileext(ff1,'.vyv'));
          if fileexists(changefileext(ff1,'.smp')) then deletefile(changefileext(ff1,'.smp'));
     CopyFile(Pchar(fn),Pchar(ff1),true);
     assignfile(d1,rname);
     reset(d1);
     readln(d1);
     readln(d1,nst);
     repeat
     readln(d1,s);
     until s='Потребные площади стержней';
     for i:=1 to nst do readln(d1,fp[i]);
     readln(d1,s);
     closefile(d1);

     assignfile(ff,ff1);
     reset(ff);
     Readln (ff,NST);
  Readln (ff,NYZ);
  Readln (ff,NY);
  Readln (ff,E);
  Readln (ff,NSN);
  Readln (ff,SD);
  Readln (ff,pltn);
     for i:=1 to nst do
            begin
          readln(ff,ITOP[i,1]);
          readln(ff,ITOP[i,2]);
            end;
     for i:=1 to nyz do
            begin
          readln(ff,cor[i,1]);
          readln(ff,cor[i,2]);
            end;
     for i:=1 to nst do
            begin
           readln(ff,fs[i]);
            end;
     for i:=1 to nyz do
            begin
          readln(ff,ms[i,1]);
          readln(ff,ms[i,2]);
            end;

     for i:=1 to nsn do
        for j:=1 to nyz*2 do
            begin
               readln (ff,p[j,i]);
            end;
               readln(ff,s_lin);
               readln(ff,s_for);
               readln(ff,region_x);
               readln(ff,region_y);
      closefile(ff);
      rewrite(ff);
      for i:=1 to nst do fs[i]:=fp[i];


  writeln (ff,NST);
  writeln (ff,NYZ);
  writeln (ff,NY);
  writeln (ff,E);
  writeln (ff,NSN);
  writeln (ff,SD);
  writeln (ff,pltn);
     for i:=1 to nst do
            begin
          writeln(ff,ITOP[i,1]);
          writeln(ff,ITOP[i,2]);
            end;
     for i:=1 to nyz do
            begin
          writeln(ff,cor[i,1]);
          writeln(ff,cor[i,2]);
            end;
     for i:=1 to nst do
            begin
           writeln(ff,fs[i]);
            end;
     for i:=1 to nyz do
            begin
          writeln(ff,ms[i,1]);
          writeln(ff,ms[i,2]);
            end;

     for i:=1 to nsn do
        for j:=1 to nyz*2 do
            begin
               writeln (ff,p[j,i]);
            end;
               writeln(ff,s_lin);
               writeln(ff,s_for);
               writeln(ff,region_x);
               writeln(ff,region_y);
    closefile(ff);
    Close;
    with TFerma_Form.OpenFile(Self,ff1) do
         begin
            Show;
         end;
     end;







end.
