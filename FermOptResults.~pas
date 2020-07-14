unit FermOptResults;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Math,
  StdCtrls, Buttons, Grids, ExtCtrls, Ferm_Dat,FermOptParam,IdGlobal,StrUtils,
  SimplRezFerm;

type
  TFermOptResults_Form = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Gs_Label: TLabel;
    V_Label: TLabel;
    Value_Edt: TEdit;
    FermWeight_Edt: TEdit;
    Precission_Edt: TEdit;
    IterationNumber_Edt: TEdit;
    Areas_Grd: TStringGrid;
    Ok_Btn: TBitBtn;
    Tol_Label: TLabel;
    Image1: TImage;
    Size_Bevel: TBevel;
    StartValue_Edt: TEdit;
    SV_Label: TLabel;
    Bevel2: TBevel;
    Label3: TLabel;
    OK_Bevel: TBevel;
    IterationNumber_Edt2: TEdit;
    Label4: TLabel;
    Precission_Edt2: TEdit;
    Label5: TLabel;
    FermWeight_Edt2: TEdit;
    Label6: TLabel;
    StartValue_Edt2: TEdit;
    Label7: TLabel;
    Value_Edt2: TEdit;
    Size_Bevel2: TBevel;
    Areas_Grd2: TStringGrid;
    Label8: TLabel;
    Image2: TImage;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    saveas:tsavedialog;
    Image3: TImage;
    Label11: TLabel;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 //   procedure Button1Click(fn:string);
    procedure Button1Click(Sender: TObject);
    procedure Emulation(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Ok_BtnClick(Sender: TObject);
  private
    { Private declarations }
    NumOk:boolean; //Была ли включена нумерация ??

  public
    { Public declarations }
  tol:array[1..15] of extended;        // потребные площади
  tol1:array[1..15] of extended;        // потребные площади -без учета
  flg: boolean;
  procedure Execute(fn:string);

  end;

var
  FermOptResults_Form: TFermOptResults_Form;

implementation

uses Main, Ferma_FD, Ferma_M;

{$R *.DFM}

procedure TFermOptResults_Form.Execute(fn:string);
var
  ff:System.text;
  s,s_lin,s_for:string;
  kst,i,it:integer;
  pogr,sv,vm,start_value:extended;
  tol:array[1..15] of extended;        // потребные площади
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
begin
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
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
//  CloseFile(ff);
  vm:=0;
  for i:=1 to kst do vm:=vm+li[i]*tol[i];

  // Вывод данных
  IterationNumber_Edt.Text:=IntToStr(it-1);
  Precission_Edt.Text:=FormatFloat('0.000e+00',pogr);
  Value_Edt.Text:=FormatFloat('0.000e+00',vm);
  FermWeight_Edt.Text:=FormatFloat('0.000e+00',sv);
  Areas_Grd.RowCount:=kst+1;
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
  StartValue_Edt.Text:=FormatFloat('0.000e+00',start_value);
  if kst > 0 then
   begin
    Areas_Grd.FixedRows:=1;
    Areas_Grd.FixedCols:=1;
   end
  else
   begin
    Areas_Grd.FixedCols:=0;
    Areas_Grd.FixedRows:=0;
   end;
  Areas_Grd.RowHeights[0]:=18;
  Areas_Grd.Cells[0,0]:='№ Cтержня';
  Areas_Grd.Cells[1,0]:='        Исходная площадь';
  Areas_Grd.Cells[2,0]:='      Полученная площадь';
  for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do
    begin
      Areas_Grd.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
    end;
  for i:=1 to kst do
    begin
      Areas_Grd.Cells[0,i]:=IntToStr(i);
      Areas_Grd.Cells[2,i]:=FormatFloat('0.000e+00',tol[i]);
    end;

{Здесь сейчас опять будет моё большое хулиганство}

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);
  vm:=0;
  for i:=1 to kst do vm:=vm+li[i]*tol[i];

  {for i := 1 to kst do
        begin
                if mom_in[i] > 0 then
                        tol[i] := tol[i] + pogr*Random;
        end;
   }
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
  Areas_Grd2.Cells[3,0]:='Необх. моменты инерции';
  Label11.Caption:='= '+  FermOptParam.FermOptParam_Form.ljambda_Edt.Text;
  for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do
    begin
      Areas_Grd2.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
    end;
  for i:=1 to kst do
    begin
      Areas_Grd2.Cells[0,i]:=IntToStr(i);
      Areas_Grd2.Cells[2,i]:=FormatFloat('0.000e+00',tol[i]);
      // ищем максимальные моменты инерции из окна с простым расчетом и всовываем их сюда
     if Mom_in[i] > 0.0 then Areas_Grd2.Cells[3,i]:=FormatFloat('0.000e+00',Mom_in[i])


//      if ((SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[10,i] <>'#######') or ( SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[12,i ] <> '#######') or (SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[11,i] <> '#######')) then
{      begin
      if SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[10,i]<>'#######' then
      Areas_Grd2.Cells[3,i]:= SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[10,i];
      if (SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[11,i]<>'#######') and (SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[11,i]> SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[10,i]) then
      Areas_Grd2.Cells[3,i]:= SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[11,i];
      if (SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[12,i]<>'#######') and (SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[12,i]> Areas_Grd2.Cells[3,i]) and (Areas_Grd2.Cells[3,i]<>'') then
      Areas_Grd2.Cells[3,i]:= SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[12,i];
      end
 }
//      Areas_Grd2.Cells[3,i]:=FormatFloat('0.000e+00', SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[ SimplRezFerm.Max_I_Cells[i,1],SimplRezFerm.Max_I_Cells[i,2] ]);
   //   Areas_Grd2.Cells[3,i]:=SimplRezFerm.SimpleFermResult_Form.Param_Grd.Cells[ SimplRezFerm.Max_I_Cells[i,1],SimplRezFerm.Max_I_Cells[i,2] ]


           //   (abs(SimplRezFerm. ps[i,j]*start_S[i])/sd_sg)*(li[i]/strtofloat(lambda_edit.text))*(li[i]/strtofloat(lambda_edit.text))

      else Areas_Grd2.Cells[3,i]:='Нет данных';
    end;

{Вроде всё}

  ShowModal;
end;


procedure TFermOptResults_Form.FormShow(Sender: TObject);
var
 num:integer;
begin
 caption:='Результаты оптимизации площадей методом равнонапряженных конструкций для '+ExtractFileName(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).real_fname);
 NumOk:=True;
 if Main_Form.FermaNumberButton.Down=False then
  begin
   Main_Form.FermaNumberButton.Down:=True;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   NumOk:=False;
  end;
 num:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1;
// Areas_Grd.Height:=num*16+22;
// Size_Bevel.Height:=num*16+22+32;
// Areas_Grd2.Height:=num*16+22;
// Size_Bevel2.Height:=num*16+22+32;
// Bevel1.Height := Size_Bevel.Top + Size_Bevel.Height - Bevel3.Height; //Size_Bevel.Top + Size_Bevel.Height +  90;
// OK_Bevel.Top := {Bevel3.Top + Bevel3.Height + }Bevel1.Top + Bevel1.Height;
//  OK_Btn.Top := OK_Bevel.Top + 20;
//  Panel1.Top :=  OK_Bevel.Top + 5;
  //  Button1.Top := OK_Bevel.Top + 20;

 //FermOptResults_Form.Height := Ok_Btn.Top + OK_Btn.Height + 15;
// FermOptResults_Form.Top:=Round(Screen.Height/2-FermOptResults_Form.Height/2);
// FermOptResults_Form.Left:=Round(Screen.Width/2-FermOptResults_Form.Width/2);
 V_Label.Caption:='Полученный объем материала ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**3]';
 SV_Label.Caption:='Исходный объем материала ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**3]';
 Gs_Label.Caption:='Силовой вес конструкции ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'*'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
 Tol_Label.Caption:='Площади поперечных сечений стержней ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';

 label7.Caption:='Полученный объем материала ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**3]';
 label6.Caption:='Исходный объем материала ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**3]';
 label5.Caption:='Силовой вес конструкции ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'*'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
 label8.Caption:='Площади поперечных сечений стержней ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';
 label12.Caption:='и необходимые моменты инерции ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**4]';



 Emulation(self);
 Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
 end;

procedure TFermOptResults_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if not NumOk then
  begin
   Main_Form.FermaNumberButton.Down:=False;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
  end;
end;


procedure TFermOptResults_Form.Button1Click(Sender: TObject);
     type
     TMethodProc=procedure(Fn:PChar);

 label exit2,exit3;
var
fn,ff1,ff2:string;
  ff:System.text;
  s,s_lin,s_for:string;
  kst,i,it:integer;
  region_x,region_y:extended;
  pogr,sv,vm,start_value:extended;
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
//****************************************************
  d1,dd :  System.text;
  mg,j,i1,jj,k,ka:integer;
  co,sg,fm,sima,s1,s2,s3: single;
  fp: array[1..15] of single;
  sim: array[1..15] of single;
//    li: array[1..15] of single;
  amb: array[1..15,1..2] of single;
//   s_lin,s_for:string[10];
  d:	array[1..15,1..3] of single;
  kob: array[1..18,1..18] of single;
 ITOP: array[1..15,1..2] of integer;                {ТОПOЛOГИЯ CTEPЖHEЙ}
 F:    array[1..15] of single;                      {HAЧAЛЬHЫE ПЛOЩAДИ}
 COR:  array[1..9,1..2] of single;                  {KOOPДИHATЫ УЗЛOB}
 {COR:  array[1..9,1..2] of integer;                  {KOOPДИHATЫ УЗЛOB}
 MS:   array[1..9,1..2] of integer;                 {ЗAKPEПЛEHИЯ УЗЛOB}
 P:    array[1..18,1..3] of single;                 {HAГPУЗKИ}
 NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
 NYZ:integer;                                       {ЧИCЛO УЗЛOB}
 NY:integer;                                        {ЧИCЛO ЗAKPEПЛEHИЙ}
 E:single;                                          {MOДУЛЬ УПPУГOCTИ}
 NSN:integer;                                       {ЧИCЛO CЛУЧAEB HAГPУЖEHИЯ}
 SD,pltn:single;                                         {ДOПУCKAEMOE HAПPЯЖEHИE}
 pltnS: string;
 N1:integer;                                        {ЧИCЛO HEИЗBECTHЫX}
 U:   array[1..18,1..3] of single;                  {ПEPEMEЩEHИЯ УЗЛOB}
 SIGP:array[1..15,1..3] of single;                  {HAПPЯЖEHИЯ B CTEPЖHЯX}
 kgv: single;
  DllName:string;
  sp:TMethodProc;
  LibHandle:THandle;
 rf: TreplaceFlags;// = set of rfIgnoreCase;


begin
// считывание массива площадей полученных стрежней (TOL) из файла с оптимизационным расчетом


fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

//  AssignFile(ff,(ChangeFileExt(fn,'.VYF')));
  ff1:=ChangeFileExt(fn,'.vyf');
 assignfile(ff,Ff1);
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
  for i:=1 to kst do readln(ff,tol1[i]); // без учета - запоминаем
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  for i:=1 to 3 do   readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);
//*** нас интересует тольkо TOL после этого считывания


// *** считываем и тут же пишем новый файл *.old c другими исх площадями
        AssignFile(d1,fn);
        reset(d1);

// ферма 4 - сохранение файлов с результатами - или с учетом или без - разные имена и далее разные массивы.
        ff1:=ChangeFileExt(fn,'');
   if RadioButton1.Checked  then  // разные имена заготавливаются
      begin
        if AnsiContainsStr(fn,'_tmp') then
          ff1:=StringReplace(ff1,'_tmp','_optB.frm',rf)
        else
          ff1:=ff1+'_optB.frm';
      end
   else
      begin
        if AnsiContainsStr(fn,'_tmp') then
          ff1:=StringReplace(ff1,'_tmp','_optS.frm',rf)
        else
          ff1:=ff1+'_optS.frm';
      end;
   saveas.FileName:=ff1;
   if saveas.Execute then
     begin
      ff1:=Saveas.FileName;
      ff1:=ChangeFileExt(ff1,'.frm');

     if fileexists(ff1) then begin
     if MessageDlg('Файл уже существует! Заменить?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
     goto exit2;
     end;

     if not fileexists(ff1) then goto exit2;

     end;
    closefile(d1);
    goto exit3;
       //ферма 4

exit2:
     //   ff1:='d:\my_optS.frm';
     Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
        AssignFile(dd,ff1);
//        showmessage('Пошёл exit2, открыт новый файл: '+ff1);
        rewrite(dd);
//        showmessage('Пошёл exit2, переписан новый файл');


        READln (d1,NST);
        writeln(dd,nst);
        READln (d1,NYZ);
        writeln(dd,nyz);
        READln (d1,NY);
        writeln(dd,ny);
        READln (d1,E);
        if E<>Current_Ferm.e1 then
          writeln(dd,Current_Ferm.e1)
        else
          writeln(dd,e);
        READln (d1,NSN);
        writeln(dd,nsn);
        READln (d1,SD);
        writeln(dd,SD);
        READln (d1,pltn);
        //pltn:=SimpleRoundTo(pltn,-4);
        writeln(dd,pltn);
//      writeln(dd);
//      writeln(dd,'Массив топологий стержней');
        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
          writeln(dd,ITOP[i,1]);
          writeln(dd,ITOP[i,2]);

         end;

  //    writeln(dd);
//      writeln(dd,'Массив координат узлов');
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);
          readln(d1,cor[i,2]);
          writeln(dd,cor[i,1]);
          writeln(dd,cor[i,2]);
         end;

//      writeln(dd);
//      writeln(dd,'Массив начальных площадей'); заменяем на площади полученные после оптимизации
// Ferma_SelectMetod.RadioGroup1.ItemIndex
        for i:=1 to nst do
      begin
           readln(d1,f[i]);
if RadioButton1.Checked  then // это проверка на то чего выводить - с учетом сжатия или без него
        begin
// это просто вывод, только надо выводить в соотвестивии с будущей таблицей имеющихся заготовок- то есть округлять к имеющимся величинам а пока просто округляем до третьего знака.

//             if (( round(tol1[i]*1000) )*10e-4) <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol1[i]:= ( round(tol1[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем
//             if tol1[i] <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol1[i]:= 10e-4;// если угу тогда меняем - то есть округляем


              writeln(dd,tol1[i]);// а теперь по-любому пишем  - даже если не изменили то есть не коруглили.
        end
  else
        begin
 //         writeln(dd,tol[i]);
 //            if (( round(tol[i]*1000) )*10e-4) <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
 //             tol[i]:= ( round(tol[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем

//             if tol[i] <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol[i]:= 10e-4;// если угу тогда меняем - то есть округляем

              writeln(dd,tol[i]);// а теперь по-любому пишем  - даже если не изменили то есть не коруглили.
        end;

      end;


//      writeln(dd);
//      writeln(dd,'Массив закрепления узлов');
        for i:=1 to nyz do
          begin
          readln(d1,ms[i,1]);
          readln(d1,ms[i,2]);
          writeln(dd,ms[i,1]);
          writeln(dd,ms[i,2]);

         end;

//      writeln(dd);
//      writeln(dd,'Массив значений нагрузок');
        for i:=1 to nsn do
          begin
            writeln(dd);
            for i1:=1 to nyz*2 do
              begin
               readln (d1,p[i1,i]);
               writeln(dd,p[i1,i]);
             end;
          end;
          readln(d1,s_lin);
          readln(d1,s_for);
          writeln(dd,s_lin);
          writeln(dd,s_for);
     readln(d1,region_x);
     readln(d1,region_y);
     writeln(dd,region_x);
     write(dd,region_y);


//*** меняем сайм файл
        closefile(dd);
        closefile(d1);
        isParmOpt:=false;
        ShowMessage('Файл с новыми значениями сохранен как '+ff1);
        FermOptResults.FermOptResults_Form.Ok_BtnClick(Sender);
        ff2:=ExtractFileName(ChangeFileExt(ff1,''))+'_tmp'+'.frm';
        CopyFileTo(ff1,ff2);
        TFerma_Form.OpenFile(Self,ff2);
        {with TFerma_Form.OpenFile(Self,ff1) do
         begin
            Show;
         end;}
//        ShowMessage(ff1);
// AssignFile(dd,ChangeFileExt(fn,'.frm'));
exit3:

end;

procedure TFermOptResults_Form.Emulation(Sender: TObject);
     type
     TMethodProc=procedure(Fn:PChar);

 label exit2,exit3;
var
fn,ff1:string;
  ff:System.text;
  s,s_lin,s_for:string;
  kst,i,it:integer;
  region_x,region_y:extended;
  pogr,sv,vm,start_value:extended;
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
//****************************************************
  d1,dd :  System.text;
  mg,j,i1,jj,k,ka:integer;
  co,sg,fm,sima,s1,s2,s3: single;
  fp: array[1..15] of single;
  sim: array[1..15] of single;
//    li: array[1..15] of single;
  amb: array[1..15,1..2] of single;
//   s_lin,s_for:string[10];
  d:	array[1..15,1..3] of single;
  kob: array[1..18,1..18] of single;
 ITOP: array[1..15,1..2] of integer;                {ТОПOЛOГИЯ CTEPЖHEЙ}
 F:    array[1..15] of single;                      {HAЧAЛЬHЫE ПЛOЩAДИ}
 COR:  array[1..9,1..2] of single;                  {KOOPДИHATЫ УЗЛOB}
 {COR:  array[1..9,1..2] of integer;                  {KOOPДИHATЫ УЗЛOB}
 MS:   array[1..9,1..2] of integer;                 {ЗAKPEПЛEHИЯ УЗЛOB}
 P:    array[1..18,1..3] of single;                 {HAГPУЗKИ}
 NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
 NYZ:integer;                                       {ЧИCЛO УЗЛOB}
 NY:integer;                                        {ЧИCЛO ЗAKPEПЛEHИЙ}
 E:single;                                          {MOДУЛЬ УПPУГOCTИ}
 NSN:integer;                                       {ЧИCЛO CЛУЧAEB HAГPУЖEHИЯ}
 SD,pltn:single;                                         {ДOПУCKAEMOE HAПPЯЖEHИE}
 N1:integer;                                        {ЧИCЛO HEИЗBECTHЫX}
 U:   array[1..18,1..3] of single;                  {ПEPEMEЩEHИЯ УЗЛOB}
 SIGP:array[1..15,1..3] of single;                  {HAПPЯЖEHИЯ B CTEPЖHЯX}
 kgv: single;
  DllName:string;
  sp:TMethodProc;
  LibHandle:THandle;



begin
// считывание массива площадей полученных стрежней (TOL) из файла с оптимизационным расчетом
radiobutton2.Checked:=true;

fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

//  AssignFile(ff,(ChangeFileExt(fn,'.VYF')));
  ff1:=ChangeFileExt(fn,'.vyf');
 assignfile(ff,Ff1);
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
  for i:=1 to kst do readln(ff,tol1[i]); // без учета - запоминаем
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);
//*** нас интересует тольkо TOL после этого считывания


// *** считываем и тут же пишем новый файл *.old c другими исх площадями
{        AssignFile(d1,fn);
        reset(d1);

// ферма 4 - сохранение файлов с результатами - или с учетом или без - разные имена и далее разные массивы.
        ff1:=ChangeFileExt(fn,'');
        ff1:=ff1+'_tmp.frm';

   saveas.FileName:=ff1;
//   if saveas.Execute then
//     begin
//      ff1:=Saveas.FileName;
     goto exit2;
//     end;
    closefile(d1);
    goto exit3;
       //ферма 4

exit2:  AssignFile(dd,ff1);
        rewrite(dd);


        READln (d1,NST);
        writeln(dd,nst);
        READln (d1,NYZ);
        writeln(dd,nyz);
        READln (d1,NY);
        writeln(dd,ny);
        READln (d1,E);
        writeln(dd,e);
        READln (d1,NSN);
        writeln(dd,nsn);
        READln (d1,SD);
        writeln(dd,SD);
        READln (d1,pltn);
        //pltn:=SimpleRoundTo(pltn,-4);
        writeln(dd,pltn);
//      writeln(dd);
//      writeln(dd,'Массив топологий стержней');
        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
          writeln(dd,ITOP[i,1]);
          writeln(dd,ITOP[i,2]);

         end;

  //    writeln(dd);
//      writeln(dd,'Массив координат узлов');
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);
          readln(d1,cor[i,2]);
          writeln(dd,cor[i,1]);
          writeln(dd,cor[i,2]);
         end;

//      writeln(dd);
//      writeln(dd,'Массив начальных площадей'); заменяем на площади полученные после оптимизации
// Ferma_SelectMetod.RadioGroup1.ItemIndex
        for i:=1 to nst do
      begin
           readln(d1,f[i]);
if RadioButton1.Checked  then // это проверка на то чего выводить - с учетом сжатия или без него
        begin
// это просто вывод, только надо выводить в соотвестивии с будущей таблицей имеющихся заготовок- то есть округлять к имеющимся величинам а пока просто округляем до третьего знака.

 //            if (( round(tol1[i]*1000) )*10e-4) <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
 //             tol1[i]:= ( round(tol1[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем
 //            if tol1[i] <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
 //             tol1[i]:= 10e-4;// если угу тогда меняем - то есть округляем


              writeln(dd,tol1[i]);// а теперь по-любому пишем  - даже если не изменили то есть не коруглили.
        end
  else
        begin
 //         writeln(dd,tol[i]);
 //            if (( round(tol[i]*1000) )*10e-4) <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
 //             tol[i]:= ( round(tol[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем

//             if tol[i] <= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol[i]:= 10e-4;// если угу тогда меняем - то есть округляем

              writeln(dd,tol[i]);// а теперь по-любому пишем  - даже если не изменили то есть не коруглили.
        end;

      end;


//      writeln(dd);
//      writeln(dd,'Массив закрепления узлов');
        for i:=1 to nyz do
          begin
          readln(d1,ms[i,1]);
          readln(d1,ms[i,2]);
          writeln(dd,ms[i,1]);
          writeln(dd,ms[i,2]);

         end;

//      writeln(dd);
//      writeln(dd,'Массив значений нагрузок');
        for i:=1 to nsn do
          begin
            writeln(dd);
            for i1:=1 to nyz*2 do
              begin
               readln (d1,p[i1,i]);
               writeln(dd,p[i1,i]);
             end;
          end;
          readln(d1,s_lin);
          readln(d1,s_for);
          writeln(dd,s_lin);
          writeln(dd,s_for);
     readln(d1,region_x);
     readln(d1,region_y);
     writeln(dd,region_x);
     write(dd,region_y);


//*** меняем сайм файл
        closefile(dd);
        closefile(d1);}
//        ShowMessage('Файл с новыми значениями сохранен как '+ff1);
exit3:

//типа запускаем простой расчет для нового файла
  DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';
  Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
  DllCall(DllName,fn,Current_Ferm);
  {LibHandle:=LoadLibrary(PChar(DllName));
 if LibHandle=0 then
     begin
          Beep;
          MessageDlg(#13+'Нет библиотеки '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;
        @sp   :=GetProcAddress(LibHandle,'SimpleFerm');
     Cursor:=crHourGlass;
     try
          //sp(PChar(ff1));
          sp(PChar(fn));
     finally
          Cursor:=crDefault;
     end;     }
//SimpleFermResult_Form.Execute(changefileext(ff1,'.vyv'));
SimpleFermResult_Form.Execute(changefileext(fn,'.vyv'));
SimpleFermResult_Form.lambda_edit.Text:=FermOptParam.FermOptParam_Form.ljambda_Edt.Text;
SimpleFermResult_Form.CheckBox1.Checked:=true;
SimpleFermResult_Form.ColorBox.Checked:=true;
with SimpleFermResult_Form do
for i:=1 to kst do
if (Max_I_Cells[i,1]<>-1)and(Max_I_Cells[i,2]<>-1) then
Areas_Grd2.Cells[3,i]:=Param_Grd.cells[Max_I_Cells[i,1],Max_I_Cells[i,2]]
else Areas_Grd2.Cells[3,i]:='нет данных';
SimpleFermResult_Form.Close;
{deletefile(ff1);
deletefile(changefileext(ff1,'.vyv'));
deletefile(changefileext(ff1,'.smp'));
deletefile(changefileext(ff1,'.nmi'));}
end;






procedure TFermOptResults_Form.Button2Click(Sender: TObject);
begin
Emulation(self);
end;


procedure TFermOptResults_Form.Ok_BtnClick(Sender: TObject);
begin
close;
end;

end.
