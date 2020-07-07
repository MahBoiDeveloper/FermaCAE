unit FermOptMassaRez;

interface


uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Grids, ExtCtrls,Math, Ferm_Dat,ferma_m,IdGlobal,StrUtils;

type
  TFermOptMassaRez_form = class(TForm)
    Size_Bevel: TBevel;
    Bevel1: TBevel;
    V_Label: TLabel;
    Tol_Label: TLabel;
    Image1: TImage;
    SV_Label: TLabel;
    Bevel3: TBevel;
    Label9: TLabel;
    Value_Edt: TEdit;
    FermWeight_Edt: TEdit;
    StartValue_Edt: TEdit;
    Panel1: TPanel;
    Button1: TButton;
    saveas: TSaveDialog;
    Areas_Grd: TStringGrid;
    Ok_Btn: TBitBtn;
    RadioButton1: TRadioButton;
    Bevel2: TBevel;
    Bevel4: TBevel;
    ISV_Label: TLabel;
    PSV_label: TLabel;
    PSV_Edit: TEdit;
    Coord_Grid: TStringGrid;
    Top_label2: TLabel;
    K_before_Label: TLabel;
    K_before_Edit: TEdit;
    K_after_Label: TLabel;
    K_after_Edit: TEdit;
    Type_of_opt_Label: TLabel;
    Bevel5: TBevel;
    
    procedure Button1Click(Sender: TObject);
    procedure Ok_BtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
  fn,ff1,ff2:string;
  ff:System.text;
  d1,dd :  System.text;
  s,s_lin,s_for:string;
  region_x,region_y:extended;
  pogr,sv,vm,start_value:extended;
  ITOP: array[1..15,1..2] of integer;                {ТОПOЛOГИЯ CTEPЖHEЙ}
  F:    array[1..15] of single;                      {HAЧAЛЬHЫE ПЛOЩAДИ}
  COR:  array[1..9,1..2] of single;                  {KOOPДИHATЫ УЗЛOB}
  MS:   array[1..9,1..2] of integer;                 {ЗAKPEПЛEHИЯ УЗЛOB}
  P:    array[1..18,1..3] of single;                 {HAГPУЗKИ}
  NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
  NYZ:integer;                                       {ЧИCЛO УЗЛOB}
  NY:integer;                                        {ЧИCЛO ЗAKPEПЛEHИЙ}
  E:single;                                          {MOДУЛЬ УПPУГOCTИ}
  NSN:integer;                                       {ЧИCЛO CЛУЧAEB HAГPУЖEHИЯ}
  SD,pltn:single;                                    {ДOПУCKAEMOE HAПPЯЖEHИE}
  pltnS:string;
    { Private declarations }
  public
  tol2 : array [1..15] of extended;
  tol21 : array [1..15] of extended;
    { Public declarations }
  end;

var
  FermOptMassaRez_form: TFermOptMassaRez_form;


implementation
uses Main, Fix_node, ForcNode, SimplRezFerm, FermOptParam,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1, FermOptNode,
     FermOptMassa, FermOptNode_Uzel;
{$R *.dfm}


procedure TFermOptMassaRez_form.Button1Click(Sender: TObject);

  label exit2,exit3;
var
  kst,i,it,Flag:integer;
  tol:array[1..15] of extended;        // потребные площади
  tol1:array[1..15] of extended;        // потребные площади -без учета
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
//****************************************************
  mg,j,i1,jj,k,ka:integer;
  co,sg,fm,sima,s1,s2,s3: single;
  fp: array[1..15] of single;
  sim: array[1..15] of single;
//    li: array[1..15] of single;
  amb: array[1..15,1..2] of single;
//   s_lin,s_for:string[10];
  d:	array[1..15,1..3] of single;
  kob: array[1..18,1..18] of single;
 N1:integer;                                        {ЧИCЛO HEИЗBECTHЫX}
 U:   array[1..18,1..3] of single;                  {ПEPEMEЩEHИЯ УЗЛOB}
 SIGP:array[1..15,1..3] of single;                  {HAПPЯЖEHИЯ B CTEPЖHЯX}
 kgv: single;
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
  for i:=1 to 3 do  readln(ff);
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

RadioButton1.Checked:=true; // zdes wsegda DA

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
      if saveas.FileName<>ff1 then // если имя изменили то прилипло *
//      ff1:=Saveas.FileName;
      begin
      ff1:=ChangeFileExt(saveas.FileName,'');
      ff1:=ChangeFileExt(ff1,'.frm');
      end;

     if fileexists(ff1) then begin
     if MessageDlg('Файл уже существует! Заменить?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
     goto exit2;
     end;

     if not fileexists(ff1) then goto exit2;

     end;
    closefile(d1);
    goto exit3;


exit2:
        Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
        AssignFile(dd,ff1);
        rewrite(dd);
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

        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
          writeln(dd,ITOP[i,1]);
          writeln(dd,ITOP[i,2]);
          end;

        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);     // массив не тот пишем - а то координаты не будут учитываться
          readln(d1,cor[i,2]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,1]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,2]);
         end;

//      writeln(dd);
//      writeln(dd,'Массив начальных площадей'); заменяем на площади полученные после оптимизации
// Ferma_SelectMetod.RadioGroup1.ItemIndex

// подменим массив
        for i:=1 to nst do
      begin
        tol1[i]:=fermoptmassaRez.FermOptMassaRez_form.tol2[i];
      end;


        for i:=1 to nst do
      begin
           readln(d1,f[i]);
if RadioButton1.Checked  then // это проверка на то чего выводить - с учетом сжатия или без него
        begin
// это просто вывод, только надо выводить в соотвестивии с будущей таблицей имеющихся заготовок- то есть округлять к имеющимся величинам а пока просто округляем до третьего знака.

//             if (( round(tol1[i]*1000) )*10e-4) >= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol1[i]:= ( round(tol1[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем

              writeln(dd,tol1[i]);// а теперь по-любому пишем  - даже если не изменили то есть не коруглили.
        end
  else
        begin
 //         writeln(dd,tol[i]);
//             if (( round(tol[i]*1000) )*10e-4) >= 0.001 then // проверка при округлении на минимальное значение- чтобы не потерять значения и не получить 0 вместо малого числа
//              tol[i]:= ( round(tol[i]*1000) )*10e-4;// если угу тогда меняем - то есть округляем

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
        //Flag:=MessageDlg(chr(13)+'Файл с новыми значениями сохранен как '+ff1+'Открыть его?' ,mtInformation,mbOkCancel,0);
        //if Flag=mrOk then
        FermOptMassaRez_form.Ok_BtnClick(Sender);
        ShowMessage('Файл с новыми значениями сохранен как '+ff1);
        ff2:=ExtractFileName(ChangeFileExt(ff1,''))+'_tmp'+'.frm';
        CopyFileTo(ff1,ff2);
        TFerma_Form.OpenFile(Self,ff2);
//        ShowMessage(ff1);
// AssignFile(dd,ChangeFileExt(fn,'.frm'));
exit3:
end;

procedure TFermOptMassaRez_form.Ok_BtnClick(Sender: TObject);
begin
FermOptMassaRez_form.visible:=false;
end;

// Процедура сохранения результатов узловой оптимизации. Самойленко А.Е. 19.12.07
// Ferma 7
procedure TFermOptMassaRez_form.Button2Click(Sender: TObject);
 label exit4,exit5;
 var
 i,i1:integer;
 Current_Ferm:TFerm;
 begin
   fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
   AssignFile(d1,fn);
   reset(d1);
   ff1:=ChangeFileExt(fn,'');
   ff1:=ff1+'_optUZ.frm';
   saveas.FileName:=ff1;
   if saveas.Execute then
     begin
      if saveas.FileName<>ff1 then // если имя изменили то прилипло *
       begin
        ff1:=ChangeFileExt(saveas.FileName,'');
        ff1:=ChangeFileExt(ff1,'.frm');
       end;
   if fileexists(ff1) then begin
     if MessageDlg('Файл уже существует! Заменить?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
      goto exit4;
     end;

   if not fileexists(ff1) then goto exit4;

   end;
   closefile(d1);
   goto exit5;

exit4:
        Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
        AssignFile(dd,ff1);
        rewrite(dd);
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

        //  Массив координат узлов
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);     // массив не тот пишем - а то координаты не будут учитываться
          readln(d1,cor[i,2]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,1]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,2]);
         end;

      // Массив толщин
      for i:=1 to nst do
       begin
        readln(d1,f[i]);
        writeln(dd,f[i]);
       end;

     // Массив закрепления узлов
        for i:=1 to nyz do
          begin
          readln(d1,ms[i,1]);
          readln(d1,ms[i,2]);
          writeln(dd,ms[i,1]);
          writeln(dd,ms[i,2]);

         end;

     //  Массив значений нагрузок
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
     ShowMessage('Файл с новыми значениями сохранен как '+ff1);
Exit5:
 end;
end.



