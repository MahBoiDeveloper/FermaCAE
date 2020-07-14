{САПР "Ферма", система сельскохозяйственного назначения
для расчета площадей под пастбища оптимального
удоя. Абсолютно точно рассчитывает оптимальное количество
крупного рогатого скота на квадратный метролитр.

Терь серьезно ;)
Система формирования силовых схем разработана
by yCat, 2004. Обещаю нормальную глюкавую работу системы
со всеми вариантами заданий. Если вдруг найдете задание,
с которым система не глючит, пишите:

yCat@pisem.net
icq #9975327
С наилучшими, //yCat

з.ы.
если кому-то вздумается рассказать об этих комментариях В.А.Столярчуку,
помните, что вся ответственность за это ляжет на вас! }

unit Visio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, ToolWin, Buttons, ImgList, Math, Ferm_Dat,
  Menus;

const
        n_napr=6;        //к-во видов напряжения + толщина
                         // Самойленко А.Е. 11.11.07 было n_napr=5
        n_nagr=4;        //к-во случаев нагружения
        n_otr=15;        //макс. к-во отрезков на одном изображении
        DefaultPos=50;   //позиция скролла по умолчанию


type
   TArr = array [1..2] of single;
  ar1 = array[1..2,1..n_napr*n_nagr*n_otr]of Tpoint;
 { TOtrezok = record
    N: integer;         //N отрезка на данном изображении
    Napr: integer;      //Вид напряжения (цвет отрезка)
    Nagr: integer;      //Случай нагружения
    P1: TPoint;         //начало отрезка
    P2: TPoint;         //конец отрезка
  end;}

  TVisio_Form = class(TForm)
    PaintBox: TPaintBox;
    Bevel: TBevel;
    Napr_Toolbar_IL: TImageList;
    Panel: TPanel;
    Minus_Sbtn: TSpeedButton;
    Plus_Sbtn: TSpeedButton;
    Panel_TB: TPanel;
    Napr_ToolBar: TToolBar;
    ToolButton3: TToolButton;
    eq_Napr_Btn: TToolButton;
    X_Napr_Btn: TToolButton;
    Y_Napr_Btn: TToolButton;
    Kas_Napr_Btn: TToolButton;
    deform_TB: TToolBar;
    ScrollBar: TScrollBar;
    Scale_Edit: TEdit;
    ToolButton4: TToolButton;
    all_ToolBar: TToolBar;
    snCB: TComboBox;
    ToolButton2: TToolButton;
    ToolButton: TToolButton;
    All_toolbar_IL: TImageList;
    colorYNo: TToolBar;
    Dote_Rez_Btn: TToolButton;
    Color_Rez_Btn: TToolButton;
    colorYNo_IL: TImageList;
    Main_Napr_Btn: TToolButton;
    Panel1: TPanel;
    instr_panel_IL: TImageList;
    ToolBar3: TToolBar;
    ToolButton7: TToolButton;
    draw_btn: TToolButton;
    del_btn: TToolButton;
    save_btn: TToolButton;
    PaintBox1: TPaintBox;
    delall_btn: TToolButton;
    all_btn: TToolButton;
    opt_btn: TToolButton;
    ToolButton10: TToolButton;
    ToolButton6: TToolButton;
    SaveDialog1: TSaveDialog;
    Napr_PaintBox: TPaintBox;
    delall2_btn: TToolButton;
    all2_btn: TToolButton;
    ToolButton9: TToolButton;
    show_btn: TToolButton;
    hinter: TStaticText;
    ToolButton5: TToolButton;
    ukaz_btn: TToolButton;
    ToolButton8: TToolButton;
    optSize_mnu: TPopupMenu;
    N1: TMenuItem;
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure LoadData(fnn:string);
    procedure LoadDataSmall(fnn:string);
    procedure LoadDataper(fnn:string);
    procedure LoadDataBig(fnn:string);
    procedure Max_EQ_Napr_BtnClick(Sender: TObject);
    procedure X_Napr_BtnClick(Sender: TObject);
    procedure Y_Napr_BtnClick(Sender: TObject);
    procedure Kas_Napr_BtnClick(Sender: TObject);
    procedure Dote_Rez_BtnClick(Sender: TObject);
    procedure Color_Rez_BtnClick(Sender: TObject);
    procedure snCBChange(Sender: TObject);
    procedure eq_Napr_BtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Minus_SbtnClick(Sender: TObject);
    procedure Plus_SbtnClick(Sender: TObject);
    procedure Napr_PaintBoxPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Main_Napr_BtnClick(Sender: TObject);
    procedure ukaz_btnClick(Sender: TObject);
    procedure draw_btnClick(Sender: TObject);
    procedure del_btnClick(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure save_btnClick(Sender: TObject);
    procedure load_btnClick(s:string);
    procedure delall_btnClick(Sender: TObject);
    procedure opt_btnClick(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure all_btnClick(Sender: TObject);
    procedure bound_draw_for_otr(x_max,y_max:integer;mas_x,mas_y:single);
    procedure force_draw_for_otr(x_max,y_max:integer;mas_x,mas_y:single);
    procedure delall2_btnClick(Sender: TObject);
    procedure all2_btnClick(Sender: TObject);
    procedure Main_Napr_BtnClick_old(Sender: TObject);
    procedure show_btnClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    

  private
    { Private declarations }


  public


    { Public declarations }
    // Переменные для считывания параметров пластины из файла
    dop1,ton1:single;            // Доп. напряжение и нач. толщина
    kz1,kl1:integer;             // Число закреплений и сил(а не случаев нагружения)
                                 // Q: случай нагружния всегда один ?!!!
    kx1,ky1,Xp:integer;             // Количество узлов по X и Y
    e1:array[1..2] of single;    // Модуль упругости и коэффициент Пуассона
    xm1,ym1:array[1..15] of single; // Координаты узлов
    zak1,zak2,zak3:array[1..20] of integer; // Закрепления (номер узла, X и Y)
    nomm,os,nom11,nom22:array[1..10] of integer; // Нагрузки (номер узла, признак нагружения(по X - 11, по Y - 22, по X и Y - 33), по X, по y)
    s_lin,s_for,sss:string;      // размерности
    Nagruz: array [1..3,1..3,1..4] of integer;// здесь будут хранится все нагруженные точки.[случай нагр,точка нагр в случае ,хар-ки нагрузки]
    kt: array[1..3] of integer; //кол-во нагруженных точек в каждом случае
    kl: integer; //кол-во случаев нагружения
    fnn:string;
    isChanged:boolean;
    ff:boolean; // Флаг для ScrollBar-а

    // Параметры для Visio_Color
    num_color:integer;   // Количество уровней цветов (2 - 7)
    min_value,max_value:single; // Интервал значений отображаемого параметра
    pluscolor,minuscolor,points:array[1..7] of longint;
    value:array[1..1000] of single;
    num_force:integer; // Случай нагружения (1,2,3)
    num_value:integer; // Что смотрим (max_or_tol - 0, x - 1, y - 2, кас - 3, напр. глав. - 5, толщина -6)
    num_rast:integer; // Вид рассчета (0 - простой, 1 - оптимизация)
    h_or_w_color:integer; // Вид полоски (шкалы) цветов (кол-ва точек)  (0 - верт., 1 - гориз.)
    to_read_or_not_to_read:boolean; //надо ли считывать данные из файла?


// параметры редактора отрезков
    flag:boolean; //если 0, то первая точка, если 1 - вторая
    flag2:boolean;
    x_1,y_1:integer; // для запоминания первой точки при рисовании отрезков
    i_1,j_1:integer; // для запоминания индексов текущего узла
    m1:array[1..n_napr,1..n_nagr,1..n_otr]of integer; //строки - вид напряжения, столбцы - случай нагружения
                                //3 изм. - номера отрезков для данного нагружения и напряжения
    m2:ar1;//array[1..2,1..n_napr*n_nagr*n_otr]of Tpoint; //массив координат конечных узлов отрезков
    m2opt:ar1;//array[1..2,1..n_napr*n_nagr*n_otr]of Tpoint;//массив координат оптимизированной конструкции
    m2all:ar1; //то же, что m2, только упорядоченное по блокам: 1й блок - напряжение по Х, 2й - по У и т.д. Используется при нажатии all_btn
    m2all2:ar1; //матрица с результатами всех расчетов для общего алгоритма, используется в ALL при set_value:=3
    present_num:integer; //№ текущего отрезка
    set_value: integer; //индикатор кнопок массовок
    old_value: integer; //запоминалка для вида напряжения
    old_x,old_y: integer; //запоминалка координат для резиновой нити
    bitmap:Tbitmap; // Запоминалка paintbox при рисовании резиновой линии
    bitmap2:Tbitmap;// Используется, чтобы картинка не "прыгала" при стирании резиновой нити
    flag3:boolean; // для исключения ошибки "Появление новых стержней при выполнении операции resize"
    flag4:boolean; // нужен при очистке выделения концов стержней (Shift)
    scrollPos:array[1..n_napr]of integer; //массив позиций скролла для каждого вида напряжения
    kfc1,kfc2,kfc3:integer; //коэффициенты сведения
    itr:integer; //кол-во итераций при сведении
    max_x_coord,max_y_coord: extended; //область построений
    plast:TPlast; //для передачи параметров пластины (для рисования нагрузок и закреплений) из Plast_M
    save_stat:integer;//для статуса сохранения. Если 0, то конструкция не изменялась. Нужно для выдачи таблички на выходе
    function Node_cord(var n:integer):TArr;
  end;

var
  Visio_Form: TVisio_Form;
  perx,pery: array[1..3,1..225] of extended; //перемещения узлов
  en: array[1..3,1..196] of extended; //эквивалентные напряжения
  nx: array[1..4,1..196] of extended; //напр. по Х
  ny: array[1..4,1..196] of extended; //напр. по Y
  kas: array[1..4,1..196] of extended; // касательные напряжения
  tol: array[1..196] of extended; // толщина (после оптимизации)
  scale,num_F:integer;
  maxpx:extended;
  function Max2(x1,x2:integer): integer;
  function Min2(x1,x2:integer): integer;
  function cross_otr(x1,y1,x2,y2,x3,y3,x4,y4:integer):TPoint;
  function cross_line(x1,y1,x2,y2,x3,y3,x4,y4:integer):TPoint;
  procedure opt(m:ar1; var m2opt:ar1);
  procedure opt_A(var m2opt:ar1; zzz:real);  //Координатная оптимизация
  procedure opt_B(var m2opt:ar1; zzz2:real);  //Угловая оптимизация
  procedure opt_C(var m2opt:ar1; zzz:real);  //Сведение узлов


implementation

uses Plast_M, Main, Plast_FD, {ferm_dat,} visio_pb, Ferma_M;

{$R *.DFM}




procedure TVisio_Form.LoadDataper(fnn:string); // Считываем перемещения из файла
var
str1:string;
ff:system.text; // файловая переменная
kx,ky,kl,nit,kit,i,j:integer;
begin
 str1:='';
 maxpx:=0;
 //maxpy:=0;

  if num_rast=0 then
  begin
    assignfile(ff,ChangeFileExt(fnn,'.vrp'));
 reset(ff);
 readln(ff);
  readln(ff{,kit});
   readln(ff,kx);
    readln(ff,ky);
     readln(ff);
      readln(ff,kl);
   while str1<> 'Перемещения, случай нагружения 1' do readln(ff,str1);
  end
  else
    begin
    assignfile(ff,ChangeFileExt(FNn,'.vop'));
 reset(ff);
 readln(ff);
  readln(ff,kit);
   readln(ff,kx);
    readln(ff,ky);
     readln(ff);
      readln(ff,kl);
       nit:=-1;
       str1:='';

       while nit<>kit-1 do
       begin
        while str1<> 'Номер итерации:' do readln(ff,str1);
        readln(ff,nit);
        readln(ff,str1);
       end;
   while str1<> 'Перемещения, случай нагружения 1' do readln(ff,str1);
  end;

   for i:=1 to kl do
   begin
    if i<>1 then readln(ff);
    for j:=1 to kx*ky do
     begin
      readln(ff);
      readln(ff,perx[i,j]);
      if abs(perx[i,j])>maxpx then maxpx:=perx[i,j];
      readln(ff);
      readln(ff,pery[i,j]);
      if abs(pery[i,j])>maxpx then maxpx:=pery[i,j];
     end;
   end;
  if maxpx=0 then maxpx:=0;
 closefile(ff);

end;


procedure TVisio_Form.LoadData(fnn:string);
var
  ff: System.Text;
  sender:TObject;
  {FileName:string;    }
  i,j,k:integer;
begin
  {FileName:='Plast1.dnp'; // Файл с данными о пластине  }
  {FNn:=Plast_Form.FileName;  }
  {AssignFile(ff,Plast_Form.FileName); }

//
        for i:=1 to n_napr do begin
                for j:=1 to n_nagr do begin
                        for k:=1 to n_otr do m1[i,j,k]:=0;
                end;
        end;
        for i:=1 to n_otr*n_nagr*n_napr do begin
                for j:=1 to 2 do
                begin
                        m2[j,i].x:=0;
                        m2[j,i].y:=0;
                end;
        end;
        load_btnClick(extractfilename(fnn));
        set_value:=0;
        //инициализация кнопок нижней панели
        draw_btn.Enabled:=True;
        del_btn.Enabled:=True;
        delall_btn.Enabled:=True;
        all_btn.down:=false;
        opt_btn.down:=false;
        opt_btn.Enabled:=false;
        draw_btn.down:=false;
        del_btn.down:=false;
        delall_btn.Down:=false;
        delall2_btn.Enabled:=false;
        show_btn.Down:=false;
        show_btn.Enabled:=true;
        save_stat:=0;
        Hinter.Hide;
        Save_btn.Hint:='Сохранение схем силовых линий';
        ukaz_btn.Down:=true;

        all2_btn.Enabled:=false;
        all2_btn.Down:=false;

  begin
  Assignfile(ff,fnn);
  Reset(ff) ;

  readln(ff,e1[1]); // мод. упругости
  readln(ff,e1[2]); // коэфф. Пуассона
  readln(ff,dop1);  // Доп. напр.
  readln(ff,ton1);  // нач. толщина
  readln(ff,kz1);   // число закреплений
  readln(ff,kl);   // число случаев нагружения
  for i:=1 to kl do
  begin
  readln(ff,kt[i]);           // Кол-во точек в 1-ом случае,Кол-во точек во 2-ом случае,Кол-во точек в 3-ем случае
  end;

  readln(ff,kx1);   // число разбиений по Х
  readln(ff,ky1);   // число разбиений по Y

  for j:=1 to kx1 do readln(ff,xm1[j]);
  for j:=1 to ky1 do readln(ff,ym1[j]);
  for i:=1 to kz1 do
    begin
      read(ff,zak1[i]);
      read(ff,zak2[i]);
      readln(ff,zak3[i]);
    end;
{ for j:=1 to plast.kl1 do
begin
      read(ff,plast.nomm[j]);
      read(ff,plast.os[j]);
      read(ff,plast.nom11[j]);
      readln(ff,plast.nom22[j]);
end;}
  for j:=1 to kl do
  for i:=1 to kt[j] do
  for k:=1 to 4 do
    begin
    read(ff,nagruz[j,i,k]);
    end;
 readln(ff);
kl1:=kl;
//Создаем одну общую пластину
k:=0;
for j:=1 to kl do
for i:=1 to kt[j] do
    begin
    k:=k+1;
    nomm[k]:= nagruz[j,i,1];
    os[k]:=nagruz[j,i,2];
    nom11[k]:=nagruz[j,i,3];
    nom22[k]:=nagruz[j,i,4];
end;

  s_lin:='';
  s_for:='';
  readln(ff);
  readln(ff,s_lin);
  readln(ff,s_for);
  CloseFile(ff);
  end;

  {  AssignFile(ff,fnn);
  Reset(ff);
  readln(ff,e1[1]);
  readln(ff,e1[2]);
  readln(ff,dop1);
  readln(ff,ton1);
  readln(ff,kz1);
  readln(ff,kl1);
  readln(ff,kx1);
  readln(ff,ky1);
  e1[1]:=plast.e1[1];
  e1[2]:=plast.e1[2];
  dop1:=plast.dop1;
  ton1:=plast.ton1;
  kz1:=plast.kz1;
  kl1:=plast.kl1;
  kx1:=plast.kx1;
  ky1:=plast.ky1;
  for j:=1 to kx1 do readln(ff,xm1[j]);
  for j:=1 to ky1 do readln(ff,ym1[j]);
//  for J:=1 to kx1

  for i:=1 to kz1 do
    begin
      read(ff,zak1[i]);
      read(ff,zak2[i]);
      readln(ff,zak3[i]);
    end;
  for j:=1 to kl1 do
    begin
      read(ff,nomm[j]);
      read(ff,os[j]);
      read(ff,nom11[j]);
      readln(ff,nom22[j]);
    end;
  s_lin:='';
  s_for:='';
  readln(ff);
  readln(ff,s_lin);
  readln(ff,s_for);

  CloseFile(ff); }
  bitmap:=TBitmap.create;
  bitmap:=getFormImage;   //основание для картинки под резиновую нить
  bitmap2:=TBitmap.create;
  bitmap2:=getFormImage;   //основание для картинки под резиновую нить
end;

{*************************************************************************}
 function max(a1,a2,a3:extended;kl:integer):extended;
  begin
        Result:=0;
     if kl=1 then Result:=a1;
     if kl=2 then
        if abs(a1)>abs(a2)then Result:= a1
        else Result:= a2;
     if kl=3 then
      begin
        if abs(a1)>abs(a2)then a2:= a1;
        if abs(a3)>abs(a2)then result:= a3
        else Result:= a2;
      end;
//     else result:= a2;


end;
{*************************************************************************}


// Считывание толщин для оптимизации или max.экв.напряжения для простого расчета
procedure TVisio_Form.LoadDataSmall(fnn:string);
var
  ff: System.Text;
  FileName,imechko:string;
  x,y,i:integer;
begin
     imechko:=fnn;   {Plast_Form.FileName}
         delete(imechko,length(imechko)-3,4);
  if num_rast=1 then FileName:=imechko+'.w'
  else FileName:=imechko+'.ww';
  max_value:=0;
  min_value:=0;
  AssignFile(ff,FileName);
  Reset(ff);
  readln(ff,x);
  readln(ff,y);
  for i:=1 to x*y do
   begin
     readln(ff,tol[i]);
    // if value[i]>=max_value then max_value:=value[i];
    // if value[i]<=min_value then min_value:=value[i];
   end;
  CloseFile(ff);
end;

// Считывание x,y,кас. напряжения
procedure TVisio_Form.LoadDataBig(fnn:string);
var
  ff,w,w1,w2,w3: System.Text;
  FileName,imechko:string;
  x,y,i,code:integer;
  s,s1:string;
begin
 imechko:=fnn;{Plast_Form.FileName}
         delete(imechko,length(imechko)-3,4);
  if num_rast=1 then FileName:=imechko+'.w'
  else FileName:=imechko+'.ww';
  max_value:=0;
  min_value:=0;
  AssignFile(ff,FileName);
  Reset(ff);
  readln(ff,x);
  readln(ff,y);
  CloseFile(ff);



  AssignFile(w1,ChangeFileExt(FNn,'.ww1'));
   AssignFile(w2,ChangeFileExt(FNn,'.ww2'));
    AssignFile(w3,ChangeFileExt(FNn,'.ww3'));

  Reset(w1);
  Reset(w2);
  Reset(w3);

  for i:=1 to x*y do
   begin
     readln(w1,s);
      s1:=copy(s,1,17);
     val(s1,nx[1,i],code);
     s1:=copy(s,18,17);
     val(s1,ny[1,i],code);
     s1:=copy(s,35,17);
     val(s1,kas[1,i],code);
          readln(w2,s);
          s1:=copy(s,1,17);
          val(s1,nx[2,i],code);
          s1:=copy(s,18,17);
          val(s1,ny[2,i],code);
          s1:=copy(s,35,17);
          val(s1,kas[2,i],code);
              readln(w3,s);
              s1:=copy(s,1,17);
              val(s1,nx[3,i],code);
              s1:=copy(s,18,17);
              val(s1,ny[3,i],code);
              s1:=copy(s,35,17);
              val(s1,kas[3,i],code);
                  kas[4,i]:=max(kas[1,i],kas[2,i],kas[3,i],kl1);
                  nx[4,i]:=max(nx[1,i],nx[2,i],nx[3,i],kl1);
                  ny[4,i]:=max(ny[1,i],ny[2,i],ny[3,i],kl1);
   end;
  CloseFile(w1);
    CloseFile(w2);
      CloseFile(w3);


  AssignFile(w,ChangeFileExt(FNn,'.ww0'));

  Reset(w);
  readln(w);
    readln(w);
  for i:=1 to x*y do
   begin
     readln(w,s);
      s1:=copy(s,1,17);
     val(s1,en[1,i],code);
      s1:=copy(s,18,17);
     val(s1,en[2,i],code);
      s1:=copy(s,35,17);
     val(s1,en[3,i],code);

   end;
  CloseFile(w);

end;

procedure TVisio_Form.FormResize(Sender: TObject);
begin

    if Width<440 then Width:=440;
    if height < 240 then height:=240;
   bitmap:=getFormImage;   //основание для картинки под резиновую нить, выставление высоты и ширины
   bitmap2:=getFormImage;   //основание для картинки под резиновую нить, выставление высоты и ширины
   flag3:=false;
end;
{************************************************************************}

// Процедура рисования различных параметров для пластины после расчета
procedure TVisio_Form.FormPaint(Sender: TObject);
const
hh=28; //высота toolbar

var
  x_max,y_max, //Размеры графической области
  step_int,i,j,a,b,x_int,y_int,nn,k,num_point,l,m,x_ran,y_ran,
  num_b_x,num_b_y,
  iii:integer;
  n_of_step:integer;
  step,
  mas_x,mas_y,   //Масштабирующие коэффициенты
  x,y,x_del,y_del:single;
  number:string;
  dopd:system.text;
  pro:integer;
  str_del:single;
  s:string;
  plast:TPlast;
  //Параметры отступов от краев области рисования
   Coord_Axis_X,Coord_Axis_X1,Coord_Axis_Y,Coord_Axis_Y1:integer;
   //Массивы номеров узлов образующих вертикальные и горизонтальные деления
   Vert_Line,Gor_Line: array[1..15,1..15] of integer;
   Num_Node, Start_Node:integer;

   //x_int,y_int:integer;
  // x,y:extended;
  x1,y1,x2,y2,xx,yy,xa,ya:integer;
  pp,alf,min:real;

begin
 Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
{********* Если отображение направлений главных усилий ***********}
{ if (num_value=5) and not((toolbutton.ImageIndex=1) and (num_rast=0)) then
  begin
  Visio_Form.Main_Napr_BtnClick(Sender);
  exit;
 end;
{*****************************************************************}
if to_read_or_not_to_read then
begin
 if num_rast=0 then    //  простой расчет
     LoadDataBig(fnn)
       else
     LoadDataSmall(fnn);  // оптимизационный расчет
     Loaddataper(fnn);
        try
         i:=round(50*plast.xm1[plast.kx1]/paintbox.Width/abs(maxpx));
        except
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
        end;
        try
         j:=round(50*plast.ym1[plast.ky1]/paintbox.height/abs(maxpx));
        except
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
        end;
        if j>i then i:=j;
          scrollbar.max:=i;
        {if i=0 then begin
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
        end;}
          //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
     if scrollbar.max<10 then scrollbar.max:=10;
     if round(scrollbar.max/10)>32767 then
      scrollbar.LargeChange:=32767
     else
      scrollbar.LargeChange:=round(scrollbar.max/10);
end;
    to_read_or_not_to_read:=false;
    ff:=True;

if num_rast=1 then   // Самойленко А.Е. 11.11.07
    all_ToolBar.Visible:=false;  // Самойленко А.Е. 11.11.07

if (toolbutton.ImageIndex=1) and (num_rast=0) then
begin


  with paintbox.Canvas do
  begin


   x_max:=paintbox.width;
   y_max:=paintbox.height;
   max_x_coord:=0;
   max_y_coord:=0;


   for i:=1 to plast.kx1 do
   begin
    if plast.xm1[i]>=max_x_coord then max_x_coord:=plast.xm1[i];
   end;
 for i:=1 to plast.ky1 do
  begin
   if plast.ym1[i]>=max_y_coord then max_y_coord:=plast.ym1[i];
  end;


  {Рисуем Координатные Оси}
      Pen.Mode:=pmCopy;

      Pen.color:=clGray;
      Pen.width:=1;

      
      coord_axis_x:=60;
      coord_axis_y:=60;
      coord_axis_x1:=60;
      coord_axis_y1:=60;

      mas_x:=(x_max-50-coord_axis_x1-coord_axis_x)/max_x_coord; //Масштабирующие коэффициенты
      mas_y:=(y_max-coord_axis_y1-coord_axis_y)/max_y_coord;

      MoveTo(coord_axis_x+50,coord_axis_y1);LineTo(x_max-coord_axis_x1+1,coord_axis_y1); // верх. горизонталь
      MoveTo(x_max-coord_axis_x1,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1,coord_axis_y1); // правая вертикаль
      MoveTo(coord_axis_x+43,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+15,y_max-coord_axis_y); // Ось X
      LineTo(x_max-coord_axis_x1+10,y_max+5-coord_axis_y);
      MoveTo(x_max-coord_axis_x1+15,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+10,y_max-5-coord_axis_y);
      MoveTo(coord_axis_x+50,y_max-coord_axis_y+10);LineTo(coord_axis_x+50,coord_axis_y1-15); // Ось Y
      LineTo(coord_axis_x+45,coord_axis_y1-10);
      MoveTo(coord_axis_x+50,coord_axis_y1-15);LineTo(coord_axis_x+55,coord_axis_y1-10);

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
      TextOut(27,y_max-18,'0');
      {if round(max_x_coord/50)*50=max_x_coord then  // Ось X
        begin
          step:=50;
          n_of_step:=round(max_x_coord/50);
          for i:=1 to n_of_step do
          begin
            str((max_x_coord-step*(i-1)):5:1,number);
            TextOut(x_max-coord_axis_x1-22-round(mas_x*step*(i-1)),y_max-18,number);
            MoveTo(x_max-coord_axis_x1-round(mas_x*step*(i-1)),y_max-coord_axis_y);
            LineTo(x_max-coord_axis_x1-round(mas_x*step*(i-1)),y_max+10-coord_axis_y);
          end;
        end
      else}
        begin
          step:=max_x_coord/4;
          step_int:=round((x_max-coord_axis_x-coord_axis_x1-50)/4);
          for i:=1 to 4 do
          begin
            str((max_x_coord-step*(i-1)):5:1,number);
            TextOut(x_max-coord_axis_x1-22-step_int*(i-1),y_max-18,number);
            MoveTo(x_max-coord_axis_x1-step_int*(i-1),y_max-coord_axis_y);
            LineTo(x_max-coord_axis_x1-step_int*(i-1),y_max+10-coord_axis_y);
          end;
        end;

      {if round(max_y_coord/50)*50=max_x_coord then   // Ось Y
        begin
          step:=50;
          n_of_step:=round(max_y_coord/50);
          for i:=1 to n_of_step do
          begin
            str((max_y_coord-step*(i-1)):5:1,number);
            TextOut(5,coord_axis_y1-7+round(mas_y*50*(i-1)),number);
            MoveTo(43+coord_axis_x,coord_axis_y1+round(mas_y*50*(i-1)));
            LineTo(50+coord_axis_x,coord_axis_y1+round(mas_y*50*(i-1)));
          end;
        end
      else }
        begin
          step:=max_y_coord/4;
          step_int:=round((y_max-60-coord_axis_Y)/4);
          for i:=1 to 4 do
          begin
            str((max_y_coord-step*(i-1)):5:1,number);
            TextOut(5,coord_axis_y1-7+step_int*(i-1),number);
            MoveTo(43+coord_axis_x,coord_axis_y1+step_int*(i-1));
            LineTo(50+coord_axis_x,coord_axis_y1+step_int*(i-1));
          end;
        end;

        
  {Рисуем исходную пластину}

      Pen.Color:=clBlack;
      Pen.width:=2;
      
      for i:=1 to Plast.kx1 do
       begin
        MoveTo(50+coord_axis_x+round(mas_x*plast.xm1[i]),y_max-coord_axis_y-round(mas_y*plast.ym1[1]));
        LineTo(50+coord_axis_x+round(mas_x*plast.xm1[i]),y_max-coord_axis_y-round(mas_y*plast.ym1[plast.ky1]));
       end;
      for i:=1 to Plast.ky1 do
       begin
        MoveTo(50+coord_axis_x+round(mas_x*plast.xm1[1]),y_max-coord_axis_y-round(mas_y*plast.ym1[i]));
        LineTo(50+coord_axis_x+round(mas_x*plast.xm1[plast.kx1]),y_max-coord_axis_y-round(mas_y*plast.ym1[i]));
       end;

       {force_draw_for_plast(x_max,y_max,mas_x,mas_y); //Нагрузки
       bound_draw_for_plast(x_max,y_max,mas_x,mas_y);   //Закрепления}

  {Рисуем деформированную пластину}
//====================================================================
  //Это надо сделать за пределами OnPaint!!!!!!!!
   // Определяем номера узлов по горизонтали и вертикали

    //Scale:=10000; //Масштаб перемещений
    //Num_F:=2; //Случай нагружения

    if plast.kx1>=plast.ky1 then
     begin

       Num_Node:=1;
       for i:=1 to plast.kx1 do
        begin
         for j:=1 to plast.ky1 do
          begin
           Vert_Line[i,j]:=Num_Node;
           Num_Node:=Num_Node+1;
          end;
        end;

       Start_Node:=1;
       for i:=1 to plast.ky1 do
        begin
         Num_Node:=Start_Node;
         for j:=1 to plast.kx1 do
          begin
           Gor_Line[i,j]:=Num_Node;
           Num_Node:=Num_Node+Plast.ky1;
          end;
         Start_Node:=Start_Node+1;
        end;

     end
    else
     begin

       Num_Node:=1;
       for i:=1 to plast.ky1 do
        begin
         for j:=1 to plast.kx1 do
          begin
           Gor_Line[i,j]:=Num_Node;
           Num_Node:=Num_Node+1;
          end;
        end;

       Start_Node:=1;
       for i:=1 to plast.kx1 do
        begin
         Num_Node:=Start_Node;
         for j:=1 to plast.ky1 do
          begin
           Vert_Line[i,j]:=Num_Node;
           Num_Node:=Num_Node+Plast.kx1;
          end;
         Start_Node:=Start_Node+1;
        end;

     end;
//=====================================================================

  Pen.Color:=clRed;

  {Рисуем горизонтальные линии}
  for i:=1 to plast.ky1 do
   begin
   for j:=1 to plast.kx1-1 do
    begin

    if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (Gor_Line[i,j] mod plast.ky1)=0 then
         begin
          x_int:=Gor_Line[i,j] div plast.ky1;
          x:=plast.xm1[(Gor_Line[i,j] div plast.ky1)];

         end
         else
          begin
           x_int:=(Gor_Line[i,j] div plast.ky1)+1;
           x:=plast.xm1[(Gor_Line[i,j] div plast.ky1)+1];

          end;
       y:=plast.ym1[Gor_Line[i,j]-plast.ky1*(x_int-1)];

     end
    else
     begin

     if (Gor_Line[i,j] mod plast.kx1)=0 then
         begin
          y_int:=Gor_Line[i,j] div plast.kx1;
          y:=plast.ym1[(Gor_Line[i,j] div plast.kx1)];
         end
         else
          begin
           y_int:=(Gor_Line[i,j] div plast.kx1)+1;
           y:=plast.ym1[(Gor_Line[i,j] div plast.kx1)+1];
          end;
       x:=plast.xm1[Gor_Line[i,j]-plast.kx1*(y_int-1)];

    end;
  if snCB.ItemIndex<> plast.kl1 then    MoveTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Gor_Line[i,j]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Gor_Line[i,j]])))
  else
   MoveTo(50+coord_axis_x+round(mas_x*(x+scale*max(perx[1,Gor_Line[i,j]],perx[2,Gor_Line[i,j]],perx[3,Gor_Line[i,j]],plast.kl1))),y_max-coord_axis_y-round(mas_y*(y+scale*max(pery[1,Gor_Line[i,j]],pery[2,Gor_Line[i,j]],pery[3,Gor_Line[i,j]],plast.kl1))));
  if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (Gor_Line[i,j+1] mod plast.ky1)=0 then
         begin
          x_int:=Gor_Line[i,j+1] div plast.ky1;
          x:=plast.xm1[(Gor_Line[i,j+1] div plast.ky1)];

         end
         else
          begin
           x_int:=(Gor_Line[i,j+1] div plast.ky1)+1;
           x:=plast.xm1[(Gor_Line[i,j+1] div plast.ky1)+1];

          end;
       y:=plast.ym1[Gor_Line[i,j+1]-plast.ky1*(x_int-1)];

     end
    else
     begin

     if (Gor_Line[i,j+1] mod plast.kx1)=0 then
         begin
          y_int:=Gor_Line[i,j+1] div plast.kx1;
          y:=plast.ym1[(Gor_Line[i,j+1] div plast.kx1)];
         end
     else
          begin
           y_int:=(Gor_Line[i,j+1] div plast.kx1)+1;
           y:=plast.ym1[(Gor_Line[i,j+1] div plast.kx1)+1];
          end;
       x:=plast.xm1[Gor_Line[i,j+1]-plast.kx1*(y_int-1)];

    end;
   // LineTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Gor_Line[i,j+1]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Gor_Line[i,j+1]])));
 if snCB.ItemIndex<> plast.kl1 then
  LineTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Gor_Line[i,j+1]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Gor_Line[i,j+1]])))
 else
  LineTo(50+coord_axis_x+round(mas_x*(x+scale*max(perx[1,Gor_Line[i,j+1]],perx[2,Gor_Line[i,j+1]],perx[3,Gor_Line[i,j+1]],plast.kl1))),y_max-coord_axis_y-round(mas_y*(y+scale*max(pery[1,Gor_Line[i,j+1]],pery[2,Gor_Line[i,j+1]],pery[3,Gor_Line[i,j+1]],plast.kl1))));

    end;
   end;

  {Рисуем вертикальные линии}
  for i:=1 to plast.kx1 do
   begin
    for j:=1 to plast.ky1-1 do
     begin
    if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (Vert_Line[i,j] mod plast.ky1)=0 then
         begin
          x_int:=Vert_Line[i,j] div plast.ky1;
          x:=plast.xm1[(Vert_Line[i,j] div plast.ky1)];

         end
         else
          begin
           x_int:=(Vert_Line[i,j] div plast.ky1)+1;
           x:=plast.xm1[(Vert_Line[i,j] div plast.ky1)+1];

          end;
       y:=plast.ym1[Vert_Line[i,j]-plast.ky1*(x_int-1)];

     end
    else
     begin

     if (Vert_Line[i,j] mod plast.kx1)=0 then
         begin
          y_int:=Vert_Line[i,j] div plast.kx1;
          y:=plast.ym1[(Vert_Line[i,j] div plast.kx1)];
         end
         else
          begin
           y_int:=(Vert_Line[i,j] div plast.kx1)+1;
           y:=plast.ym1[(Vert_Line[i,j] div plast.kx1)+1];
          end;
       x:=plast.xm1[Vert_Line[i,j]-plast.kx1*(y_int-1)];

    end;
  //  MoveTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Vert_Line[i,j]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Vert_Line[i,j]])));
 if snCB.ItemIndex<> plast.kl1 then
  MoveTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Vert_Line[i,j]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Vert_Line[i,j]])))
 else
  MoveTo(50+coord_axis_x+round(mas_x*(x+scale*max(perx[1,Vert_Line[i,j]],perx[2,Vert_Line[i,j]],perx[3,Vert_Line[i,j]],plast.kl1))),y_max-coord_axis_y-round(mas_y*(y+scale*max(pery[1,Vert_Line[i,j]],pery[2,Vert_Line[i,j]],pery[3,Vert_Line[i,j]],plast.kl1))));

  if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (Vert_Line[i,j+1] mod plast.ky1)=0 then
         begin
          x_int:=Vert_Line[i,j+1] div plast.ky1;
          x:=plast.xm1[(Vert_Line[i,j+1] div plast.ky1)];

         end
         else
          begin
           x_int:=(Vert_Line[i,j+1] div plast.ky1)+1;
           x:=plast.xm1[(Vert_Line[i,j+1] div plast.ky1)+1];

          end;
       y:=plast.ym1[Vert_Line[i,j+1]-plast.ky1*(x_int-1)];

     end
    else
     begin

     if (Vert_Line[i,j+1] mod plast.kx1)=0 then
         begin
          y_int:=Vert_Line[i,j+1] div plast.kx1;
          y:=plast.ym1[(Vert_Line[i,j+1] div plast.kx1)];
         end
         else
          begin
           y_int:=(Vert_Line[i,j+1] div plast.kx1)+1;
           y:=plast.ym1[(Vert_Line[i,j+1] div plast.kx1)+1];
          end;
       x:=plast.xm1[Vert_Line[i,j+1]-plast.kx1*(y_int-1)];

    end;
  //    LineTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Vert_Line[i,j+1]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Vert_Line[i,j+1]])));
  if snCB.ItemIndex<> plast.kl1 then
  LineTo(50+coord_axis_x+round(mas_x*(x+scale*perx[num_force,Vert_Line[i,j+1]])),y_max-coord_axis_y-round(mas_y*(y+scale*pery[num_force,Vert_Line[i,j+1]])))
  else
  LineTo(50+coord_axis_x+round(mas_x*(x+scale*max(perx[1,Vert_Line[i,j+1]],perx[2,Vert_Line[i,j+1]],perx[3,Vert_Line[i,j+1]],plast.kl1))),y_max-coord_axis_y-round(mas_y*(y+scale*max(pery[1,Vert_Line[i,j+1]],pery[2,Vert_Line[i,j+1]],pery[3,Vert_Line[i,j+1]],plast.kl1))));

     end;
   end;



 end;
end

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
else
 begin


if (num_rast=0)and(num_value=0) then visio_form.caption:='Макс. экв. напряжение для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=0)and(num_value=4) then visio_form.caption:='Эквивалентное напр. для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=0)and(num_value=1) then visio_form.caption:='Напряжение по Х для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=0)and(num_value=2) then visio_form.caption:='Напряжение по Y для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=0)and(num_value=3) then visio_form.caption:='Касательное напряжение для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=0)and(num_value=5) then visio_form.caption:='Направления главных усилий для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (num_rast=1) then visio_form.caption:='Толщина для '+extractfilename(fnn)+'  , ['+s_lin+']';
if (set_value=1) then visio_form.caption:='Все силовые линии для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (set_value=2) then visio_form.caption:='Оптимизация для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';
if (set_value=3) then visio_form.caption:='Общая оптимизация для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';


  with PaintBox.Canvas do
    begin
      brush.Color:=clBtnFace;
      FillRect(Rect(0,0,width,height));
      x_max:=paintbox.width;//width-80;
      y_max:=paintbox.height-10;//height-31-hh;
      max_x_coord:=0;
      max_y_coord:=0;
      nn:=1;
      {num_rast:=0; // Вид рассчета (0-1) }
    {  num_value:=0;} // Что выводим (0-4)
      //num_force:=1; // Случай нагружения (1-3)
     // num_color:=7; // Число уровней цвета (1-7)
     // h_or_w_color:=0; // Вид полоски (шкалы) цветов (кол-ва точек)  (0 - верт., 1 - гориз.)



      for i:=1 to kx1 do
       begin
         if  xm1[i]>=max_x_coord then max_x_coord:= xm1[i];
       end;
      for i:=1 to  ky1 do
       begin
         if  ym1[i]>=max_y_coord then max_y_coord:= ym1[i];
       end;


      {рисуем закрепления и нагрузки}
{                force_draw_for_ferma(x_max,y_max,num_force,mas_x,mas_y);
          bound_draw_for_ferma(x_max,y_max,mas_x,mas_y);}

//      ferma_Form.force_draw_for_ferma(400,200,3,1,1);


      {Рисуем Координатные Оси}
      Pen.color:=clBlack;
      Pen.width:=1;
      mas_x:=(x_max-80-15)/max_x_coord; //Масштабирующие коэффициенты
      mas_y:=(y_max-60)/max_y_coord;
      MoveTo(43+15,30);LineTo(x_max-30,30);
      MoveTo(x_max-30,y_max-30);LineTo(x_max-30,30);
      MoveTo(43+15,y_max-30);LineTo(x_max-15,y_max-30);
      LineTo(x_max-20,y_max-35);
      MoveTo(x_max-15,y_max-30);LineTo(x_max-20,y_max-25);
      MoveTo(50+15,y_max-20);LineTo(50+15,15);
      LineTo(55+15,20);
      MoveTo(50+15,15);LineTo(45+15,20);

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
      TextOut(25+15,y_max-16,'0');

      {if round(max_x_coord/50)*50=max_x_coord then  // Ось X
        begin
          step:=50;
          n_of_step:=round(max_x_coord/50);
          for i:=1 to n_of_step do
          begin
            str((max_x_coord-step*(i-1)):5:2,number);
            TextOut(x_max-47-round(mas_x*step*(i-1)),y_max-16,number);
            MoveTo(x_max-30-round(mas_x*step*(i-1)),y_max-20);
            LineTo(x_max-30-round(mas_x*step*(i-1)),y_max-30);
          end;
        end
      else }
        begin
          step:=max_x_coord/4;
          step_int:=round((x_max-80-15)/4);
          for i:=1 to 4 do
          begin
            str((max_x_coord-step*(i-1)):5:2,number);
            TextOut(x_max-47-step_int*(i-1),y_max-16,number);
            MoveTo(x_max-30-step_int*(i-1),y_max-20);
            LineTo(x_max-30-step_int*(i-1),y_max-30);
          end;
        end;

      {if round(max_y_coord/50)*50=max_y_coord then  // Ось Y
        begin
          step:=50;
          n_of_step:=round(max_y_coord/50);
          for i:=1 to n_of_step do
          begin
            str((max_y_coord-step*(i-1)):5:2,number);
            TextOut(3,23+round(mas_y*50*(i-1)),number);
            MoveTo(43+15,30+round(mas_y*50*(i-1)));
            LineTo(50+15,30+round(mas_y*50*(i-1)));
          end;
        end
      else }
        begin
          step:=max_y_coord/4;
          step_int:=round((y_max-60)/4);
          for i:=1 to 4 do
            begin
              str((max_y_coord-step*(i-1)):5:2,number);
              TextOut(3,23+step_int*(i-1),number);
              MoveTo(43+15,30+step_int*(i-1));
              LineTo(50+15,30+step_int*(i-1));
            end;
        end;

if (set_value=0) then
begin
      {Рисуем пластину}
      Pen.width:=1;
      //mas_x:=(x_max-80-15)/max_x_coord; //Масштабирующие коэффициенты
      //mas_y:=(y_max-60)/max_y_coord;
      if Color_Rez_Btn.Down then  // Цветографическое представление
       begin
        for i:=1 to  kx1 do
         begin
          MoveTo(50+15+round(mas_x* xm1[i]),y_max-30-round(mas_y* ym1[1]));
          LineTo(50+15+round(mas_x* xm1[i]),y_max-30-round(mas_y* ym1[ ky1]));
         end;
        for i:=1 to  ky1 do
         begin
          MoveTo(50+15+round(mas_x* xm1[1])+1,y_max-30-round(mas_y* ym1[i]));
          LineTo(50+15+round(mas_x* xm1[ kx1])+1,y_max-30-round(mas_y* ym1[i]));
         end;
          case Num_Color of // Переопределяем цвета
            7: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
                pluscolor[6]:=9934847;
                minuscolor[6]:=16695190;
                pluscolor[7]:=11449853;
                minuscolor[7]:=16769486;
               end;
             6: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
                pluscolor[6]:=9934847;
                minuscolor[6]:=16695190;
               end;
             5: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
               end;
             4: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
               end;
             3: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
               end;
             2: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
               end;
            end;
       end
      else  // Точечное представление
       begin
        PaintBox.Canvas.Brush.Color:=clBtnFace;
        PaintBox.Canvas.FillRect(Rect(51,y_max-30,x_max-31,30));;
        Pen.Width:=2;
        MoveTo(50+15+round(mas_x* xm1[kx1]),y_max-30-round(mas_y* ym1[1]));
        LineTo(50+15+round(mas_x* xm1[kx1]),y_max-30-round(mas_y* ym1[ ky1])+1);
        MoveTo(50+15+round(mas_x* xm1[1]),y_max-30-round(mas_y* ym1[ky1])+1);
        LineTo(50+15+round(mas_x* xm1[ kx1]),y_max-30-round(mas_y* ym1[ky1])+1);
        MoveTo(50+15+round(mas_x* xm1[1]),y_max-30-round(mas_y* ym1[1]));
        LineTo(50+15+round(mas_x* xm1[1]),y_max-30-round(mas_y* ym1[ky1])+1);
        MoveTo(50+15+round(mas_x* xm1[1]),y_max-30-round(mas_y* ym1[1]));
        LineTo(50+15+round(mas_x* xm1[kx1]),y_max-30-round(mas_y* ym1[1]));
        Pen.Width:=1;


        case Num_Color of // Переопределяем количество точек
            7: begin
                points[1]:=1600;
                points[2]:=1334;
                points[3]:=1067;
                points[4]:=800;
                points[5]:=534;
                points[6]:=267;
                points[7]:=100;
               end;
             6: begin
                points[1]:=1600;
                points[2]:=1300;
                points[3]:=1000;
                points[4]:=700;
                points[5]:=400;
                points[6]:=100;
               end;
             5: begin
                points[1]:=1600;
                points[2]:=1200;
                points[3]:=800;
                points[4]:=400;
                points[5]:=100;
               end;
             4: begin
                points[1]:=1600;
                points[2]:=1100;
                points[3]:=600;
                points[4]:=100;
               end;
             3: begin
                points[1]:=1600;
                points[2]:=800;
                points[3]:=100;
               end;
             2: begin
                points[1]:=1000;
                points[2]:=100;
               end;
            end;
       end;

      // Рисуем разнообразные графические представления
      if num_rast=0 then // простой расчет
        if snCB.ItemIndex=kl1 then // максимальные значения
         for i:=1 to (kx1-1)*(ky1-1) do
          case num_value of
        1: value[i]:=max(nx[1,i],nx[2,i],nx[3,i],kl1);
        2: value[i]:=max(ny[1,i],ny[2,i],ny[3,i],kl1);
        3: value[i]:=max(kas[1,i],kas[2,i],kas[3,i],kl1);
        4: value[i]:=max(en[1,i],en[2,i],en[3,i],kl1);
        5: value[i]:=max(en[1,i],en[2,i],en[3,i],kl1);
          end
        else // i-ый случай нагружения
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
         //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         if num_force=0 then num_force:=1;
          case num_value of
        1: value[i]:=nx[num_force,i];
        2: value[i]:=ny[num_force,i];
        3: value[i]:=kas[num_force,i];
        4: value[i]:=en[num_force,i];
        5: value[i]:=en[num_force,i];
          end;
        end
      else  //оптимизация
         for i:=1 to (kx1-1)*(ky1-1) do
          value[i]:=tol[i];

          min_value:=0;
          max_value:=0;
        for i:=1 to (kx1-1)*(ky1-1) do
        begin
         if value[i]>=max_value then max_value:=value[i];
         if value[i]<=min_value then min_value:=value[i];
        end;

      // Определяем для каждого конечного элемента
      //  координаты его левого нижнего узла
        if kx1>=ky1 then
         begin
          num_b_x:=kx1;
          num_b_y:=ky1;
         end
        else
         begin
          num_b_x:=ky1;
          num_b_y:=kx1;
         end;

         for i:=1 to num_b_x-1 do
          begin
           a:=i*num_b_y-(num_b_y-1);
           b:=i*num_b_y-(num_b_y-1)+num_b_y-2;
           for j:=a to b do
            begin

             if kx1>=ky1 then        // Определение координат узла от его номера
              begin
               if (j mod ky1)=0 then
                begin
                  x_int:=j div ky1;
                  x:=xm1[j div ky1];
                end
               else
                begin
                 x_int:=(j div ky1)+1;
                 x:=xm1[(j div ky1)+1];
                end;
                y:=ym1[j-ky1*(x_int-1)];

               end
              else
               begin

                if (j mod kx1)=0 then
                 begin
                   y_int:=j div kx1;
                   y:=ym1[j div kx1];
                 end
                else
                 begin
                  y_int:=(j div kx1)+1;
                  y:=ym1[(j div kx1)+1];
                end;
                  x:=xm1[j-kx1*(y_int-1)];

             end;
       // Координаты определены

             if Color_Rez_Btn.Down then
              begin

               for k:=1 to num_color do
                begin
                 if value[nn]>=0 then
                  begin
                   if value[nn]<=max_value-(k-1)*max_value/num_color then brush.color:=pluscolor[k];
                  end
                 else
                  begin
                   if value[nn]>=min_value-(k-1)*min_value/num_color then brush.color:=minuscolor[k];
                  end;
                end;
                nn:=nn+1;
                x_del:=0;
                y_del:=0;
                for l:=1 to kx1 do
                   begin
                    if xm1[l]=x then x_del:=xm1[l+1]-xm1[l];
                   end;
                for m:=1 to ky1 do
                   begin
                    if ym1[m]=y then y_del:=ym1[m+1]-ym1[m];
                   end;
                FillRect(Rect(50+round(mas_x*x)+1+15,y_max-30-round(mas_y*(y+y_del))+1,50+round(mas_x*(x+x_del))+15,y_max-30-round(mas_y*y)));
              end
             else
              begin
                for k:=1 to num_color do
                 begin
                  if value[nn]>=0 then
                  begin
                   if value[nn]<=max_value-(k-1)*max_value/num_color then num_point:=points[k];
                  end
                 else
                  begin
                   if value[nn]>=min_value-(k-1)*min_value/num_color then num_point:=points[k];
                  end;
                 end;
                 nn:=nn+1;

                 x_del:=0;
                 y_del:=0;

                // Уравниваем количество точек от разрешения и размера конечного элемента
                for l:=1 to kx1 do
                   begin
                    if xm1[l]=x then x_del:=xm1[l+1]-xm1[l];
                   end;
                   for m:=1 to ky1 do
                   begin
                    if ym1[m]=y then y_del:=ym1[m+1]-ym1[m];
                   end;
                num_point:=round(num_point*mas_x*mas_y*x_del*y_del/1800);

                for k:=1 to num_point do
                 begin

                  for l:=1 to kx1 do
                   begin
                    if xm1[l]=x then x_del:=xm1[l+1]-xm1[l];
                   end;
                   for m:=1 to ky1 do
                   begin
                    if ym1[m]=y then y_del:=ym1[m+1]-ym1[m];
                   end;
                  x_ran:=random(round(x_del*mas_x));
                  y_ran:=random(round(y_del*mas_y));
                  pixels[50+15+round(mas_x*x)+x_ran,y_max-30-round(mas_y*y)-y_ran]:=clBlack;
                 end;

              end;

            end;
          end;
//      brush.color:=clBtnFace;
//      font.name:='times new roman';
//      font.Style:=[fsBold];
//      font.size:=10;
//      //step:=max_y_coord/5;
      //step_int:=round((y_max-60)/5);
//      step:=50;
//      n_of_step:=round(max_y_coord/50);
//      for i:=1 to n_of_step do
//       begin
//        str((max_y_coord-step*(i-1)):5:2,number);
        {//TextOut(3,23+step_int*(i-1),number);
        //MoveTo(43+15,30+step_int*(i-1));
        //LineTo(50+15,30+step_int*(i-1));}
//        TextOut(3,23+round(mas_y*50*(i-1)),number);
//        MoveTo(43+15,30+round(mas_y*50*(i-1)));
//        LineTo(50+15,30+round(mas_y*50*(i-1)));
//       end;
    end;




 //Рисование стрелок (направлений главных усилий)
    if (num_value=5)and not(all_btn.Down)and not(show_btn.Down) then
    begin
      // Рисуем графическое представление направлений главных усилий
      if num_rast=0 then // простой расчет
{         if snCB.ItemIndex=kl1 then // максимальные значения
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
                value[i]:=sqrt(sqr(max(nx[1,i],nx[2,i],nx[3,i],kl1))+sqr(max(ny[1,i],ny[2,i],ny[3,i],kl1))+2*sqr(max(kas[1,i],kas[2,i],kas[3,i],kl1)));
         end
         else // i-ый случай нагружения}
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
                value[i]:=sqrt(sqr(nx[num_force,i])+sqr(ny[num_force,i])+2*sqr(kas[num_force,i]));
         end;
         min_value:=0;
         max_value:=0;
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
               if value[i]>=max_value then max_value:=value[i];
               if value[i]<=min_value then min_value:=value[i];
         end;

      // Определяем для каждого конечного элемента
      //  координаты его левого нижнего узла
         if kx1>=ky1 then
         begin
                num_b_x:=kx1;
                num_b_y:=ky1;
         end
         else
         begin
                num_b_x:=ky1;
                num_b_y:=kx1;
         end;
//         paintbox.Canvas.FillRect(rect(0,0,paintbox.Width,paintbox.Height));
         for i:=1 to num_b_x-1 do
         begin
                 a:=i*num_b_y-(num_b_y-1);
                 b:=i*num_b_y-(num_b_y-1)+num_b_y-2;
                 for j:=a to b do
                 begin
                         if kx1>=ky1 then        // Определение координат узла от его номера
                         begin
                                if (j mod ky1)=0 then
                                begin
                                        x_int:=j div ky1;
                                        x:=xm1[j div ky1];
                                end
                                else
                                begin
                                        x_int:=(j div ky1)+1;
                                        x:=xm1[(j div ky1)+1];
                                end;
                                y:=ym1[j-ky1*(x_int-1)];

                         end
                         else
                         begin
                                if (j mod kx1)=0 then
                                begin
                                        y_int:=j div kx1;
                                        y:=ym1[j div kx1];
                                end
                                else
                                begin
                                        y_int:=(j div kx1)+1;
                                        y:=ym1[(j div kx1)+1];
                                end;
                                x:=xm1[j-kx1*(y_int-1)];
                         end;
       // Координаты определены
                         nn:=j-a+1+(num_b_y-1)*(i-1);
//                         begin
                         for k:=1 to num_color do
                         begin
                                 if value[nn]>=0 then
                                 begin
                                         if value[nn]<=max_value-(k-1)*max_value/num_color then brush.color:=pluscolor[k];
                                 end
                         end;
                         x_del:=0;
                         y_del:=0;
                         for l:=1 to kx1 do
                         begin
                                 if xm1[l]=x then x_del:=xm1[l+1]-xm1[l];
                         end;
                         for m:=1 to ky1 do
                         begin
                                 if ym1[m]=y then y_del:=ym1[m+1]-ym1[m];
                         end;
                { координаты противолежащих углов элемента}
                         x1:=50+round(mas_x*x)+1+15;
                         y1:=y_max-30-round(mas_y*(y+y_del))+1;
                         x2:=50+round(mas_x*(x+x_del))+15;
                         y2:=y_max-30-round(mas_y*y);
//                         FillRect(Rect(x1,y1,x2,y2));
                         xx:=round((x1+x2)/2);  { xx, yy - координаты центра элемента}
                         yy:=round((y1+y2)/2);

              { alf -  угол наклона к оси x }

                         if snCB.Text='<Максимальное>' then
                         begin
                                iii:=num_force;
                                num_force:=4;
                         end;
                         alf:=(ArcTan((2*kas[num_force,nn])/(ny[num_force,nn]-nx[num_force,nn])))/2;
                         min:=(nx[num_force,nn]+ny[num_force,nn])/2-sqrt(sqr(nx[num_force,nn]-ny[num_force,nn])+4*sqr(kas[num_force,nn]))/2;

                         if abs(alf)>= 1.570795 then { если угол > 90 градусов }
                         begin
                                pp:=(x1-xx)/cos(alf);
                         end
                         else
                         begin
                                pp:=(x2-xx)/cos(alf);
                         end;
{ pp - max расстояние от центра до границ эл-та при движении под заданным углом}
                         if (yy+pp*sin(abs(alf)))<=y2 then
                         begin
                                pp:=3*pp/4;
                         end
                         else
                         begin
                                pp:=3*(y2-yy)/(4*sin(abs({bet}alf)));
                         end;
                         pen.color:=clWhite;
                         pen.Width:=2;
 // Рисуем стрелки, указывающие направление силы
  { xa, ya - координаты точки на отрезке до которой доходит оперение стрелки}
                         xa:=round((xx-round(pp*cos({bet}alf))+1.5*(xx+round(pp*cos({bet}alf))))/2.5);
                         ya:=round((yy-round(pp*sin(alf))+1.5*(yy+round(pp*sin(alf))))/2.5);
                         MoveTo(xx-round(pp*cos({bet}alf)),yy-round(pp*sin({bet}alf)));
                         LineTo(xx+round(pp*cos({bet}alf)),yy+round(pp*sin({bet}alf)));
                         LineTo(round(xa+(ya-(yy+round(pp*sin({bet}alf))))*0.3),round(ya+(xx+round(pp*cos({bet}alf))-xa)*0.3));
                         MoveTo(xx+round(pp*cos({bet}alf)),yy+round(pp*sin({bet}alf)));
                         LineTo(round(xa-(ya-(yy+round(pp*sin({bet}alf))))*0.3),round(ya-(xx+round(pp*cos({bet}alf))-xa)*0.3));
                         if snCB.Text='<Максимальное>' then num_force:=iii;
                 end;
         end;
      end;
//      pen.color:=clblack;
//      brush.color:=clBtnFace;
//     font.name:='times new roman';
//      font.Style:=[fsBold];
//      font.size:=10;
//      step:=max_y_coord/5;
//      step_int:=round((y_max-60)/5);
//      for i:=1 to 5 do
//      begin
//        str((max_y_coord-step*(i-1)):5:2,number);
//        TextOut(3, (23+step_int*(i-1)),number);
//        MoveTo(43+15,30+step_int*(i-1));
//       LineTo(50+15,30+step_int*(i-1));
//       end;
    end;
// стрелки нарисованы





     if ToolButton.ImageIndex=0 then
      begin
        if set_value=0 then Napr_PaintBox.Repaint;
        //else Napr_PaintBox.Visible:=False; // panel:=Visible:=False; //Samoyl
        with paintbox.Canvas do bitmap.Canvas.copyrect(rect(0,0,width,height),canvas,rect(0,0,width,height));
        PaintBox1Paint(Self);
        if set_value=0 then
        begin
                bound_draw_for_otr(x_max,y_max+15,mas_x,mas_y);
                force_draw_for_otr(x_max,y_max+15,mas_x,mas_y);
        end;
      end
     else
      Napr_PaintBox.Visible:=True;
    end;
//end;
end;


procedure TVisio_Form.Max_EQ_Napr_BtnClick(Sender: TObject);
begin
       num_value:=0;//мах. экв. напряжение
       num_rast:=0; //простой расчет

       X_Napr_Btn.Down:=false;
       Y_Napr_Btn.Down:=false;
       Kas_Napr_Btn.Down:=false;
       Main_Napr_Btn.Down:=false;    //***************************
       visio_form.Repaint;



end;

procedure TVisio_Form.X_Napr_BtnClick(Sender: TObject);
begin
       num_value:=1;//напряжение по X
       num_rast:=0; //простой расчет
       if set_value<>0 then set_value:=1;
       eq_Napr_Btn.Down:=false;
       Y_Napr_Btn.Down:=false;
       Kas_Napr_Btn.Down:=false;
       Main_Napr_Btn.Down:=false;   //********************
       all2_btn.Down:=false;
       if set_value=3 then set_value:=old_value;
       if not all_btn.Down then visio_form.Repaint else all_btnClick(Self);
       if show_btn.Down then show_btnClick(Self);
end;

procedure TVisio_Form.Y_Napr_BtnClick(Sender: TObject);
begin
       num_value:=2;//напряжение по Y
       num_rast:=0; //простой расчет
       if set_value<>0 then set_value:=1;
       eq_Napr_Btn.Down:=false;
       X_Napr_Btn.Down:=false;
       all2_btn.Down:=false;
       Kas_Napr_Btn.Down:=false;
       Main_Napr_Btn.Down:=false;  //*********************
       if set_value=3 then set_value:=old_value;       
       if not all_btn.Down then visio_form.Repaint else all_btnClick(Self);
       if show_btn.Down then show_btnClick(Self);
end;

procedure TVisio_Form.Kas_Napr_BtnClick(Sender: TObject);
begin
       num_value:=3;//касательное напряжение
       num_rast:=0; //простой расчет
       if set_value<>0 then set_value:=1;
       X_Napr_Btn.Down:=false;
       Y_Napr_Btn.Down:=false;
       eq_Napr_Btn.Down:=false;
       all2_btn.Down:=false;
       Main_Napr_Btn.Down:=false; //*******************
       if set_value=3 then set_value:=old_value;
       if not all_btn.Down then visio_form.Repaint else all_btnClick(Self);
       if show_btn.Down then show_btnClick(Self);       
end;

procedure TVisio_Form.Dote_Rez_BtnClick(Sender: TObject);
begin
//Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Point_View_Mnu.Checked:=true;
//Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Color_View_Mnu.Checked:=false;
Color_Rez_Btn.down:=false;
Dote_Rez_Btn.down:=true;
visio_form.Repaint;

end;

procedure TVisio_Form.Color_Rez_BtnClick(Sender: TObject);
begin
//Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Point_View_Mnu.Checked:=true;
//Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Color_View_Mnu.Checked:=false;
Color_Rez_Btn.down:=true;
Dote_Rez_Btn.down:=false;
visio_form.Repaint;
end;

procedure TVisio_Form.snCBChange(Sender: TObject);
begin
if snCB.ItemIndex<>kl1 then Main_Form.Plast_Sn_Cbx.ItemIndex:=snCB.ItemIndex;
//if snCB.ItemIndex<>kl1 then
num_force:= snCB.ItemIndex+1;
//if snCB.ItemIndex<>kl1 then num_f:= snCB.ItemIndex+1;
visio_form.repaint;
plast_FD_form.showD(plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast);
 Main_Form.ActiveMDIChild.RePaint;
{if visio_color.Visible then visio_color.repaint
else if visio_color_2.Visible then visio_color_2.repaint;}
end;



procedure TVisio_Form.eq_Napr_BtnClick(Sender: TObject);
begin
       num_value:=4;//эквивалентное напряжение
       num_rast:=0; //простой расчет
       if set_value<>0 then set_value:=1;
       EQ_Napr_Btn.Down:=true;
       X_Napr_Btn.Down:=false;
       Y_Napr_Btn.Down:=false;
       Kas_Napr_Btn.Down:=false;
       all2_btn.Down:=false;
       if set_value=3 then set_value:=old_value;
       if not all_btn.Down then visio_form.Repaint else all_btnClick(Self);
       if show_btn.Down then show_btnClick(Self);
end;

procedure TVisio_Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        num_force:=1;
        ToolButton.ImageIndex:=0;
        ff:=False;
        ScrollBar.Position:=0;
        panel.Show;
        panel_TB.Show;
        if save_stat=1 then
        if messagedlg('Схемы силовых линий изменены. Сохранить?',mtWarning,[mbYes,mbNo],0)=6 then save_btnClick(Self) else close;
end;

procedure TVisio_Form.FormCreate(Sender: TObject);
begin
ToolButton.hint:='Деформация пластины';
 num_color:=5;
 // Num_f:=1;
 Scale:=1;
  panel_TB.Height:=30;
  DeForm_TB.Top:=2;
  DeForm_TB.visible:=false;
end;

procedure TVisio_Form.Minus_SbtnClick(Sender: TObject);
begin
Num_Color:=Num_Color-1;
if Num_Color-1=1 then Minus_Sbtn.Enabled:=False;
if Num_Color=6 then Plus_Sbtn.Enabled:=True;
{PaintBox.Repaint;
Napr_PaintBox.Repaint;}
visio_form.Repaint;
end;

procedure TVisio_Form.Plus_SbtnClick(Sender: TObject);
begin
Num_Color:=Num_Color+1;
if Num_Color+1=8 then Plus_Sbtn.Enabled:=False;
if Num_Color=3 then Minus_Sbtn.Enabled:=True;
{PaintBox.Repaint;
Napr_PaintBox.Repaint;}
visio_form.Repaint;
end;

procedure TVisio_Form.Napr_PaintBoxPaint(Sender: TObject);
var
  x_max,y_max, //Размеры графической области
  i,j,{a,b,}num_point,x_ran,y_ran
 {// num_b_x,num_b_y}:integer;
  {max_x_coord,max_y_coord,  }
 // step,
 { mas_x,mas_y,}   //Масштабирующие коэффициенты
 { x,y,x_del,}y_del:single;
  {number:string; }
  {dopd:system.text; }
  pro:integer;
  str_del:single;
  s:string;

begin
   if num_value<7 then  // Самойленко А.Е. 11.11.07 (было <6)
   begin
//     Napr_PaintBox.Height:=Panel.Height-22;
//     Plus_SBtn.Top:=Napr_PaintBox.Height+3;
//     Minus_SBtn.Top:=Napr_PaintBox.Height+3;
     with Napr_PaintBox.Canvas do
          begin
               brush.Color:=clBtnFace;
               font.name:='small font';
               pen.Width:=1;
               font.Color:=clBLack;
               font.size:=7;
               x_max:=Napr_PaintBox.width-11;
               y_max:=Napr_PaintBox.height-50;
               FillRect(Rect(1,1,x_max+10,y_max+30));
               if min_value>=0 then
                  begin
                       y_del:=y_max/num_color;
                       str_del:=max_value/num_color;
                       for i:=1 to num_color do
                           begin
                                if Color_Rez_Btn.Down then
                                   begin
                                        brush.color:=pluscolor[i];
                                        FillRect(Rect(5,10+round(y_del*(i-1)),25,10+round(y_del*i)));

                                   end
                                else
                                    begin
                                         num_point:=points[i];
                                         x_ran:=round(25-5);
                                         y_ran:=round(y_del*i-y_del*(i-1));
                                         num_point:=round(y_ran*x_ran*num_point/1800);
                                         for j:=1 to num_point do
                                             begin
                                                  x_ran:=random(round(25-5));
                                                  y_ran:=random(round(y_del*i-y_del*(i-1)));
                                                  pixels[5+x_ran,10+round(y_del*(i-1))+y_ran]:=clBlack;
                                             end;
                                    end; {else}
            str(max_value-(i-1)*str_del:7:3,s);
            brush.color:=clBtnFace;
            textout(30,4+round(y_del*(i-1)),s);
         end;
           textout(30,4+round(y_del*(i-1)),'0');
       end
      else
       begin
         y_del:=y_max/2/num_color;
         str_del:=visio_form.max_value/visio_form.num_color;
        for i:=1 to num_color do
         begin
          if Color_Rez_Btn.Down then
           begin
            brush.color:=pluscolor[i];
            FillRect(Rect(5,10+round(y_del*(i-1)),25,10+round(y_del*i)));
           end
          else
           begin
             num_point:=points[i];
             x_ran:=round(25-5);
             y_ran:=round(y_del*i-y_del*(i-1));
             num_point:=round(y_ran*x_ran*num_point/1800);
             for j:=1 to num_point do
              begin
               x_ran:=random(round(25-5));
               y_ran:=random(round(y_del*i-y_del*(i-1)));
               pixels[5+x_ran,10+round(y_del*(i-1))+y_ran]:=clBlack;
              end;
           end;
            str(max_value-(i-1)*str_del:7:3,s);
            brush.color:=clBtnFace;
            textout(30,4+round(y_del*(i-1)),s);
         end;
         brush.color:=clBtnFace;
         textout(30,4+round(y_del*(i-1)),'0');
         pro:=round(y_del*(i-1));
         str_del:=min_value/num_color;
        for i:=1 to visio_form.num_color do
         begin
          if Color_Rez_Btn.Down then
           begin
            brush.color:=minuscolor[num_color-(i-1)];
            FillRect(Rect(5,pro+10+round(y_del*(i-1)),25,pro+10+round(y_del*i)));

           end
          else
           begin
            num_point:=points[num_color-(i-1)];
            x_ran:=round(25-5);
            y_ran:=round(y_del*i-y_del*(i-1));
            num_point:=round(y_ran*x_ran*num_point/1800);
             for j:=1 to num_point do
              begin
               x_ran:=random(round(25-5));
               y_ran:=random(round(y_del*i-y_del*(i-1)));
               pixels[5+x_ran,pro+10+round(y_del*(i-1))+y_ran]:=clBlack;
              end;
           end;
           str(min_value-(num_color-i)*str_del:7:3,s);
            brush.color:=clBtnFace;
            textout(30,4+pro+round(y_del*i),s);
         end;
         brush.color:=clBtnFace;
          str(min_value:7:3,s);
         textout(30,4+pro+round(y_del*(i-1)),s);
       end;
    end;
   end;
end;



procedure TVisio_Form.FormActivate(Sender: TObject);
var
 i{,j}:integer;
 //plast:tplast;
begin
//   scrollbar.Position:=0;
   DeForm_TB.visible:=false;
   napr_toolbar.Visible:=true;
   colorYNo.Visible:=true;
   panel.Visible:=true;
   Napr_PaintBox.Visible:=True;
   if num_color<>2 then Minus_Sbtn.Enabled:=true;
   if num_color<>7 then Plus_Sbtn.Enabled:=true;
   snCB.Items.Clear;
   toolbutton.ImageIndex:=0;
   if num_rast=0 then
   begin
   snCB.enabled:=true;
  // Max_EQ_Napr_Btn.enabled:=true;
   EQ_Napr_Btn.enabled:=true;
   X_Napr_Btn.enabled:=true;
   Y_Napr_Btn.enabled:=true;
   Main_Napr_Btn.enabled:=true;  //*********************
   Kas_Napr_Btn.enabled:=true;
   for i:=1 to kl1 do snCB.Items.Add('Случай нагружения '+IntToStr(i));
   snCB.Items.Add('<Максимальное>');
   snCB.ItemIndex:=Main_Form.Plast_Sn_Cbx.ItemIndex;
   num_force:=snCB.ItemIndex+1; //случай нагружения
   end
   else
   begin
   snCB.enabled:=false;
   X_Napr_Btn.enabled:=false;
   Y_Napr_Btn.enabled:=false;
   Kas_Napr_Btn.enabled:=false;
   EQ_Napr_Btn.enabled:=false;
   Main_Napr_Btn.enabled:=false;
   end;
    if (num_rast=0) and (num_value=0) then
   begin
      snCB.Items.Clear;
         snCB.text:='';
   snCB.enabled:=false;
   end;


   //  Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
    {  try
      i:=round(50*plast.xm1[plast.kx1]/paintbox.Width/abs(maxpx));
      except
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
        //close;
        end;
        try
         j:=round(50*plast.ym1[plast.ky1]/paintbox.height/abs(maxpx));
        except
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
         // close;
        end;
           if j>i then i:=j;
          scrollbar.max:=i;
        if i=0 then begin
         messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
         exit;
        end;
     if scrollbar.max<10 then scrollbar.max:=10;
     scrollbar.LargeChange:=round(scrollbar.max/10);   }
     if num_rast=0 then
     begin
      toolbutton.Enabled:=true;
      Napr_ToolBar.Visible:=true;
      if not all_btn.down and not show_btn.Down then all_ToolBar.Visible:=true;
     end
     else
     begin
      toolbutton.Enabled:=false;
      Napr_ToolBar.Visible:=false;
      all_ToolBar.Visible:=false;
      toolbar3.Visible:=true;  // Самойленко А.Е. 11.11.07
     end;
    Visio_Form.N1Click(self);
end;

procedure TVisio_Form.ToolButtonClick(Sender: TObject);
var
 plast:TPlast;
 //g:integer;  //**********************
begin
 plast:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
 if (maxpx>Plast.xm1[Plast.kx1])or(maxpx>Plast.ym1[Plast.ky1]) then
 begin
  beep;
  messagedlg('Слишком большие перемещения.'+#10+#13+'Пластина представляет собой механизм или разрушается.',mtError,[mbOK],0);
  exit;
 end;

 if ToolButton.ImageIndex=0 then
  begin
   panel1.Hide;
   Hinter.Hide;
   visio_Form.Caption:='Деформация пластины';
   ToolButton.Hint:='Напряженное состояние пластины';
   Scale:=scrollbar.Position;
   Scale_Edit.Text:='Масштаб перемещений ['+IntToStr(scale)+':1]';
   ToolButton.ImageIndex:=1;
   DeForm_TB.Visible:=True;
   Napr_ToolBar.Visible:=False;
   colorYNo.Visible:=False;
   Panel.Visible:=False;
   //visio_form.Repaint;
  end
 else
  begin
   panel1.Show;
   ToolButton.Hint:='Деформация пластины';
   ToolButton.ImageIndex:=0;
   DeForm_TB.Visible:=False;
   Napr_ToolBar.Visible:=True;
   colorYNo.Visible:=true;
   Panel.Visible:=True;
{**** Если выводинись напр. гл. ус. - перерисовка цветографич. ****}
//   if num_value=5 then
//   begin
//    visio_form.Repaint;
//   end;
{******************************************************************}
  end;
  Visio_Form.FormResize(self);
  end;

procedure TVisio_Form.ScrollBarChange(Sender: TObject);
begin
 scale:=ScrollBar.Position;
 Scale_Edit.Text:='Масштаб перемещений ['+IntToStr(scale)+':1]';
 Scale_Edit.ShowHint:=True;
 Scale_Edit.Hint:='Масштаб перемещений ['+IntToStr(scale)+':1]';
 if ff then visio_form.Repaint;
end;

procedure TVisio_Form.FormShow(Sender: TObject);
begin
 maxpx:=0;
 if not FileExists(extractfilename(ChangeFileExt(Fnn,'.ot2'))) then DeleteFile(extractfilename(ChangeFileExt(Fnn,'.ot1'))); 
end;


const hh=28;
procedure TVisio_Form.FormKeyPress(Sender: TObject; var Key: Char);
begin
//     if key = 'F1' then
  Application.HelpCommand(HELP_FINDER,0);
end;

//end.

procedure TVisio_Form.Main_Napr_BtnClick(Sender: TObject);
begin
        num_value:=5;
        num_rast:=0; //простой расчет
        if set_value<>0 then set_value:=1;
        Main_Napr_Btn.Down:=true;
        EQ_Napr_Btn.Down:=false;
        X_Napr_Btn.Down:=false;
        Y_Napr_Btn.Down:=false;
        Kas_Napr_Btn.Down:=false;
        all2_btn.Down:=false;
        if set_value=3 then set_value:=old_value;
        if not all_btn.Down then visio_form.Repaint else all_btnClick(Self);
        if show_btn.Down then show_btnClick(Self);
end;

procedure TVisio_Form.Main_Napr_BtnClick_old(Sender: TObject);
var
  x_max,y_max, //Размеры графической области
  step_int,i,j,a,b,x_int,y_int,k,nn,num_point,l,m,x_ran,y_ran,
  xx, yy, x1,x2,y1,y2, xa,ya, num_b_x, num_b_y:integer;
  max_x_coord,max_y_coord,
  step,
  mas_x,mas_y,   //Масштабирующие коэффициенты
  x,y,x_del,y_del:single;
  number:string;
  alf, pp, min:real;
//  bet:real; FERMA 5 - изза этого была ошибка - поэтому закоментил эту строку  итам где оно считалось.
  ss:string[11];
  dopd:system.text;
  pro:integer;
  str_del:single;
  s:string;
  cl:TColor;
  plast:TPlast;
  //Параметры отступов от краев области рисования
   Coord_Axis_X,Coord_Axis_X1,Coord_Axis_Y,Coord_Axis_Y1:integer;
   //Массивы номеров узлов образующих вертикальные и горизонтальные деления
   Vert_Line,Gor_Line: array[1..15,1..15] of integer;
   Num_Node, Start_Node:integer;


begin
       Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
       num_value:=5;
       X_Napr_Btn.Down:=false;
       Y_Napr_Btn.Down:=false;
       Kas_Napr_Btn.Down:=false;
       eq_Napr_Btn.Down:=false;

 visio_form.caption:='Направления главных усилий для '+extractfilename(fnn)+'  , ['+s_for+'/'+s_lin+'**2]';

  with PaintBox.Canvas do
    begin
{      color:=clBackGround;
      fillrect(rect(0,0,width,height));
      color:=cldefault;}
      x_max:=width-100;//-80;
      y_max:=height-105;//-31-hh;
      max_x_coord:=60;
      max_y_coord:=60;

      for i:=1 to kx1 do
       begin
         if  xm1[i]>=max_x_coord then max_x_coord:= xm1[i];
       end;
      for i:=1 to  ky1 do
       begin
         if  ym1[i]>=max_y_coord then max_y_coord:= ym1[i];
       end;

      {Рисуем Координатные Оси}
      Pen.color:=clBlack;
      Pen.width:=1;
      MoveTo(43+15,30);LineTo(x_max-30,30);
      MoveTo(x_max-30,y_max-30);LineTo(x_max-30,30);
      MoveTo(43+15,y_max-30);LineTo(x_max-15,y_max-30);
      LineTo(x_max-20,y_max-35);
      MoveTo(x_max-15,y_max-30);LineTo(x_max-20,y_max-25);
      MoveTo(50+15,y_max-20);LineTo(50+15,15);
      LineTo(55+15,20);
      MoveTo(50+15,15);LineTo(45+15,20);

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
      TextOut(25+15,y_max-16,'0');
      step:=max_x_coord/5;
      step_int:=round((x_max-80-15)/5);
      for i:=1 to 5 do
       begin
        str((max_x_coord-step*(i-1)):5:2,number);
        TextOut(x_max-47-step_int*(i-1),y_max-16,number);
        MoveTo(x_max-30-step_int*(i-1),y_max-20);
        LineTo(x_max-30-step_int*(i-1),y_max-30);
       end;
      step:=max_y_coord/5;
      step_int:=round((y_max-60)/5);
      for i:=1 to 5 do
       begin
        str((max_y_coord-step*(i-1)):5:2,number);
        TextOut(3,23+step_int*(i-1),number);
        MoveTo(43+15,30+step_int*(i-1));
        LineTo(50+15,30+step_int*(i-1));
       end;

      {Рисуем пластину}
      Pen.width:=1;
      mas_x:=(x_max-80-15)/max_x_coord; //Масштабирующие коэффициенты
      mas_y:=(y_max-60)/max_y_coord;
      // Цветографическое представление
       begin
        for i:=1 to  kx1 do
         begin
          MoveTo(50+15+round(mas_x* xm1[i]),y_max-30-round(mas_y* ym1[1]));
          LineTo(50+15+round(mas_x* xm1[i]),y_max-30-round(mas_y* ym1[ ky1]));
         end;
        for i:=1 to  ky1 do
         begin
          MoveTo(50+15+round(mas_x* xm1[1])+1,y_max-30-round(mas_y* ym1[i]));
          LineTo(50+15+round(mas_x* xm1[ kx1])+1,y_max-30-round(mas_y* ym1[i]));
         end;
          case Num_Color of // Переопределяем цвета
            7: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
                pluscolor[3]:=202;
                pluscolor[4]:=225;
                pluscolor[5]:=5724159;
                pluscolor[6]:=9934847;
                pluscolor[7]:=11449853;
               end;
             6: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
                pluscolor[3]:=202;
                pluscolor[4]:=225;
                pluscolor[5]:=5724159;
                pluscolor[6]:=9934847;
               end;
             5: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
                pluscolor[3]:=202;
                pluscolor[4]:=225;
                pluscolor[5]:=5724159;
               end;
             4: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
                pluscolor[3]:=202;
                pluscolor[4]:=225;
               end;
             3: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
                pluscolor[3]:=202;
               end;
             2: begin
                pluscolor[1]:=87;
                pluscolor[2]:=153;
               end;
            end;
       end;


      // Рисуем графическое представление направлений главных усилий
      if num_rast=0 then // простой расчет
        if snCB.ItemIndex=kl1 then // максимальные значения
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
         value[i]:=sqrt(sqr(max(nx[1,i],nx[2,i],nx[3,i],kl1))+sqr(max(ny[1,i],ny[2,i],ny[3,i],kl1))+2*sqr(max(kas[1,i],kas[2,i],kas[3,i],kl1)));
          end
        else // i-ый случай нагружения
         for i:=1 to (kx1-1)*(ky1-1) do
         begin
         //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
         value[i]:=sqrt(sqr(nx[num_force,i])+sqr(ny[num_force,i])+2*sqr(kas[num_force,i]));
          end;
          min_value:=0;
          max_value:=0;
        for i:=1 to (kx1-1)*(ky1-1) do
        begin
         if value[i]>=max_value then max_value:=value[i];
         if value[i]<=min_value then min_value:=value[i];
        end;

      // Определяем для каждого конечного элемента
      //  координаты его левого нижнего узла
        if kx1>=ky1 then
        begin
          num_b_x:=kx1;
          num_b_y:=ky1;
         end
        else
         begin
          num_b_x:=ky1;
          num_b_y:=kx1;
         end;

         for i:=1 to num_b_x-1 do
          begin
           a:=i*num_b_y-(num_b_y-1);
           b:=i*num_b_y-(num_b_y-1)+num_b_y-2;
           for j:=a to b do
            begin

             if kx1>=ky1 then        // Определение координат узла от его номера
              begin
               if (j mod ky1)=0 then
                begin
                  x_int:=j div ky1;
                  x:=xm1[j div ky1];
                end
               else
                begin
                 x_int:=(j div ky1)+1;
                 x:=xm1[(j div ky1)+1];
                end;
                y:=ym1[j-ky1*(x_int-1)];

               end
              else
               begin

                if (j mod kx1)=0 then
                 begin
                   y_int:=j div kx1;
                   y:=ym1[j div kx1];
                 end
                else
                 begin
                  y_int:=(j div kx1)+1;
                  y:=ym1[(j div kx1)+1];
                end;
                  x:=xm1[j-kx1*(y_int-1)];

             end;
       // Координаты определены
              nn:=j-a+1+(num_b_y-1)*(i-1);
              begin

               for k:=1 to num_color do
                begin
                 if value[nn]>=0 then
                  begin
                   if value[nn]<=max_value-(k-1)*max_value/num_color then brush.color:=pluscolor[k];
                  end
                end;
                x_del:=0;
                y_del:=0;
                for l:=1 to kx1 do
                   begin
                    if xm1[l]=x then x_del:=xm1[l+1]-xm1[l];
                   end;
                for m:=1 to ky1 do
                   begin
                    if ym1[m]=y then y_del:=ym1[m+1]-ym1[m];
                   end;
                { координаты противолежащих углов элемента}
                x1:=50+round(mas_x*x)+1+15;
                y1:=y_max-30-round(mas_y*(y+y_del))+1;
                x2:=50+round(mas_x*(x+x_del))+15;
                y2:=y_max-30-round(mas_y*y);
                FillRect(Rect(x1,y1,x2,y2));
                xx:=round((x1+x2)/2);  { xx, yy - координаты центра элемента}
                yy:=round((y1+y2)/2);
              { alf -  угол наклона к оси x }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//это полная жопа!!! руки бы поотрывал тому, кто это писал. При выборе максимального случая нагружения
//параметр num_value не изменяется, т.е. расчет векторов для этого случая отсутствует, как таковой!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

              if num_force<>4 then begin //временная заплатка
                alf:=(ArcTan((2*kas[num_force,nn])/(ny[num_force,nn]-nx[num_force,nn])))/2;
min:=(nx[num_force,nn]+ny[num_force,nn])/2-sqrt(sqr(nx[num_force,nn]-ny[num_force,nn])+4*sqr(kas[num_force,nn]))/2;
//                bet:=alf-ArcSin(min/value[nn]); /// FERMA 5 - изза этого была ошибка иногда- но это же вроде не используется нигде так что я ТОЛЬКО эту строку закомментил.
              end;
                if abs({bet}alf)>= 1.570795 then { если угол > 90 градусов }
                 begin pp:=(x1-xx)/cos({bet}alf); end
                else
                  begin pp:=(x2-xx)/cos({bet}alf); end;
{ pp - max расстояние от центра до границ эл-та при движении под заданным углом}
                if (yy+pp*sin(abs({bet}alf)))<=y2 then
                 begin pp:=3*pp/4; end
                else
                  begin pp:=3*(y2-yy)/(4*sin(abs({bet}alf)));end;
                pen.color:=clwhite;
 // Рисуем стрелки, указывающие направление силы
  { xa, ya - координаты точки на отрезке до которой доходит оперение стрелки}
                xa:=round((xx-round(pp*cos({bet}alf))+1.5*(xx+round(pp*cos({bet}alf))))/2.5);
                ya:=round((yy-round(pp*sin({bet}alf))+1.5*(yy+round(pp*sin({bet}alf))))/2.5);
                MoveTo(xx-round(pp*cos({bet}alf)),yy-round(pp*sin({bet}alf)));
                LineTo(xx+round(pp*cos({bet}alf)),yy+round(pp*sin({bet}alf)));
                LineTo(round(xa+(ya-(yy+round(pp*sin({bet}alf))))*0.3),round(ya+(xx+round(pp*cos({bet}alf))-xa)*0.3));
                MoveTo(xx+round(pp*cos({bet}alf)),yy+round(pp*sin({bet}alf)));
                LineTo(round(xa-(ya-(yy+round(pp*sin({bet}alf))))*0.3),round(ya-(xx+round(pp*cos({bet}alf))-xa)*0.3));
              end
            end;
          end;
      pen.color:=clblack;
      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
         step:=max_y_coord/5;
      step_int:=round((y_max-60)/5);
      for i:=1 to 5 do
       begin
        str((max_y_coord-step*(i-1)):5:2,number);
        TextOut(3, (23+step_int*(i-1)),number);
        MoveTo(43+15,30+step_int*(i-1));
        LineTo(50+15,30+step_int*(i-1));
       end;
    end;
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    Napr_PaintBoxPaint(Sender);

end;

procedure TVisio_Form.ukaz_btnClick(Sender: TObject);
begin
        if ukaz_btn.Down then
        begin
                draw_btn.Down:=false;
                draw_btn.Enabled:=true;
                del_btn.Down:=false;
                del_btn.Enabled:=true;
                delall_btn.Down:=false;
                delall_btn.Enabled:=true;
                show_btn.Down:=false;
                show_btn.Enabled:=true;
                all_btn.Down:=false;
                all_btn.Enabled:=true;

                opt_btn.Down:=false;
                opt_btn.Enabled:=false;
                delall2_btn.Down:=false;
                delall2_btn.Enabled:=false;

                all2_btn.Enabled:=false;
                all2_btn.Down:=false;
                save_btn.Down:=false;
                save_btn.Enabled:=true;
                save_btn.Hint:='Сохранение схем силовых линий';

                Panel.Show;
                hinter.Hide;
                All_ToolBar.Show;
                ColorYNo.Show;

                set_value:=0;
                FormPaint(Self);
                PaintBox1Paint(Self);
        end
        else ukaz_btn.Down:=true;




end;

procedure TVisio_Form.draw_btnClick(Sender: TObject);
var
        x,y,x1,y1: integer;
        button:TMouseButton;
begin
        ukaz_btn.Down:=false;
        del_btn.Down:=false;
        draw_btn.Down:=true;
        cursor:=crCross;
end;

procedure TVisio_Form.del_btnClick(Sender: TObject);
begin
        ukaz_btn.Down:=false;
        del_btn.Down:=true;
        draw_btn.Down:=false;
        cursor:=crCross;
end;


procedure TVisio_Form.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
        koef_x,koef_y:real;
        iii:integer;
begin
        koef_x:=paintBox1.Width/403;
        koef_y:=paintBox1.Height/220;
         //ограничитель поля рисования
        if (x<5*Koef_x) then x:=round(5*Koef_x);
        if (x>PaintBox1.Width-5*Koef_x) then x:=round(paintBox1.Width-5*Koef_x);
        if (y<5*Koef_y) then y:=round(5*Koef_y);
        if (y>PaintBox1.Height-10*Koef_y) then y:=round(paintBox1.Height-10*Koef_y);

        flag3:=true;
        if snCB.Text='<Максимальное>' then
        begin
                iii:=num_force;
                num_force:=4;
        end;
        if (draw_btn.Down)and(m1[num_value,num_force,n_otr]=0)and not(ssShift in Shift) then
        begin
                flag:=true;
                x_1:=x;
                y_1:=y;
                with paintbox.Canvas do bitmap2.Canvas.copyrect(rect(0,0,width,height),canvas,rect(0,0,width,height));
        end
        else if (del_btn.Down and flag2) then
        begin
                m2[1,m1[num_value,num_force,present_num]].X:=0;
                m2[1,m1[num_value,num_force,present_num]].Y:=0;
                m2[2,m1[num_value,num_force,present_num]].X:=0;
                m2[2,m1[num_value,num_force,present_num]].Y:=0;
                m1[num_value,num_force,present_num]:=0;
                //конструкция изменена
                delall2_btnClick(Self);
                save_stat:=1;
                Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
                paintbox1paint(self);
        end;
        if snCB.Text='<Максимальное>' then num_force:=iii;
end;

procedure TVisio_Form.PaintBox1Paint(Sender: TObject);
var
        i,iii,j,k,z:integer;
        koef_x,koef_y:real;

begin
   if (ToolButton.ImageIndex=0){and(num_rast=0) Самойленко А.Е. 11.11.07} then     //исключение прорисовки отрезков на форме "Деформация пластины"
   begin
        panel1.Show;
        //масштабирующие коэффициенты
        if snCB.Text='<Максимальное>' then
        begin
                iii:=num_force;
                num_force:=4;
        end;
        paintbox1.canvas.pen.width:=round(0.015*paintBox1.Height);
        koef_x:=paintBox1.Width/403;
        koef_y:=paintBox1.Height/220;

        with paintbox1.Canvas do
        begin
                case num_value of
                                1: pen.Color:=clAqua;  //по Х
                                2: pen.Color:=clBlack;  //по У
                                3: pen.Color:=clLime;  //касательное
                                4: pen.color:=clYellow;//эквив.
                                5: pen.Color:=clBlue; //вектора
                                6: pen.Color:=clGreen; // толщина - Самойленко А.Е. 11.11.07
                end;
                if set_value=0 then
                begin
                   for i:=1 to n_otr do
                   begin
                        if m1[num_value,num_force,i]<>0 then
                        begin
                                moveTo(round(m2[1,m1[num_value,num_force,i]].X*koef_x),round(m2[1,m1[num_value,num_force,i]].Y*koef_Y));
                                LineTo(round(m2[2,m1[num_value,num_force,i]].X*koef_X),round(m2[2,m1[num_value,num_force,i]].Y*koef_y));
                        end;
                   end;
                end
                else if set_value=1 then
                begin
                        for i:=1 to n_napr*n_nagr*n_otr do
                        begin
                                moveTo(round(m2all[1,i].X*koef_x),round(m2all[1,i].Y*koef_y));
                                LineTo(round(m2all[2,i].X*koef_x),round(m2all[2,i].Y*koef_y));
                        end;
                end
  {              else if set_value=2 then
                begin

                                for i:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        if not ((m2opt[1,i].X=0) and (m2opt[1,i].Y=0) and (m2opt[2,i].X=0) and (m2opt[2,i].Y=0)) then
                                        begin
                                                moveTo(round(m2opt[1,i].X*koef_x),round(m2opt[1,i].Y*koef_Y));
                                                LineTo(round(m2opt[2,i].X*koef_x),round(m2opt[2,i].Y*koef_Y));
                                        end;
                                end;
                end}
                else if set_value=3 then
                begin
                        pen.Color:=clRed;
                        for j:=1 to n_napr*n_nagr*n_otr do
                        begin
                                MoveTo(round(m2all2[1,j].X*koef_x),round(m2all2[1,j].Y*koef_y));
                                LineTo(round(m2all2[2,j].X*koef_x),round(m2all2[2,j].Y*koef_y));
                        end;
                end;
        end;
        if snCB.Text='<Максимальное>' then num_force:=iii;
        bound_draw_for_otr(PaintBox.Width,PaintBox.Height+5,(PaintBox.Width-95)/max_x_coord,(PaintBox.Height-70)/max_y_coord);
        force_draw_for_otr(PaintBox.Width,PaintBox.Height+5,(PaintBox.Width-95)/max_x_coord,(PaintBox.Height-70)/max_y_coord);
   end
   else panel1.Hide;
end;
function Max2(x1,x2:integer):integer;
begin
        if x1>x2 then max2:=x1 else max2:=x2;
end;
function Min2(x1,x2:integer):integer;
begin
        if x1<x2 then min2:=x1 else min2:=x2;
end;
procedure TVisio_Form.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
        iii,i,j,k,x1,x2,y1,y2,x_j,y_j,delta,d1:integer;
        koef_x,koef_y,a,a1:real;
        usl:boolean;

begin

        koef_x:=0.0;
        koef_y:=0.0;
        paintbox1.Canvas.Pen.width:=round(0.015*paintBox1.Height);
        koef_x:=paintBox1.Width/403;
        koef_y:=paintBox1.Height/220;

         //ограничитель поля рисования
        if (x<5*Koef_x) then x:=round(5*Koef_x);
        if (x>PaintBox1.Width-5*Koef_x) then x:=round(paintBox1.Width-5*Koef_x);
        if (y<5*Koef_y) then y:=round(5*Koef_y);
        if (y>PaintBox1.Height-10*Koef_y) then y:=round(paintBox1.Height-10*Koef_y);

   if num_value<7 then
   begin
        if snCB.Text='<Максимальное>' then
        begin
                iii:=num_force;
                num_force:=4;
        end;
        if ((draw_btn.Down)and not(ssShift in Shift)) then
        begin
           if flag4 then
           begin
                   Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
                   paintbox1paint(self);
                   flag4:=false;
           end;
           if flag then
           begin
                with paintbox.Canvas do
                begin
                        Canvas.copyrect(rect(0,0,width,height),bitmap2.canvas,rect(0,0,width,height));
                        paintbox1paint(self);
                end;
                with paintbox1.canvas do
                begin
                        pen.width:=round(0.0035*height);
                        if color_rez_btn.Down then pen.Color:=clSilver else pen.Color:=clWhite;
                        moveTo(x_1,y_1);
                        LineTo(x,y);
                end;
           end;
        end
        else if (draw_btn.Down)and(ssShift in Shift)and not (ssLeft in Shift) then
        begin
                d1:=round(paintbox1.Height*0.025);
                i:=0;
                repeat
                        i:=i+1;
                        j:=0;
                        repeat
                                j:=j+1;
                                x_j:=-1000;
                                y_j:=-1000;

                                if (m1[num_value,num_force,j]<>0) then
                                begin
                                        x_j:=round(m2[i,m1[num_value,num_force,j]].X*koef_x);
                                        y_j:=round(m2[i,m1[num_value,num_force,j]].y*koef_y);
                                end;
                        until ((abs(x_j-x)<d1) and (abs(y_j-y)<d1))or(j=n_otr);
                until ((abs(x_j-x)<d1) and (abs(y_j-y)<d1))or(i=2);
                if ((x_j<>x_1)or(y_j<>y_1)) then
                begin
                        Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
                        paintbox1paint(self);
                        flag4:=false; //флаг, показывающий, нарисован ли кружок
                end;
                if (x_j>0)and(y_j>0)then with paintbox1.Canvas do
                begin
                        pen.width:=round(0.0035*height);
                        pen.Color:=clYellow;
                        brush.Style:=bsClear;
                        moveTo(x_j,y_j);
                        delta:=round(0.015*height);
                        ellipse(x_j-delta,y_j-delta,x_j+delta,y_j+delta);
                        flag4:=true;
                end;
                x_1:=x_j;//сохранение координат текущего узла
                y_1:=y_j;
                i_1:=i; //сохранение индексов узла
                j_1:=j;
        end
        else if (draw_btn.Down)and(ssShift in Shift)and(ssLeft in Shift) then
        begin
                if (x_1>0)and(y_1>0)then
                begin

                        m2[i_1,m1[num_value,num_force,j_1]].x:=round(x/koef_x);
                        m2[i_1,m1[num_value,num_force,j_1]].y:=round(y/koef_y);

                        //исключение появления горизонтальных и вертикальных линий
                        if i_1=1 then
                        begin
                                if m2[2,m1[num_value,num_force,j_1]].x=m2[i_1,m1[num_value,num_force,j_1]].x then m2[i_1,m1[num_value,num_force,j_1]].x:=round(x/koef_x)+1;
                                if m2[2,m1[num_value,num_force,j_1]].y=m2[i_1,m1[num_value,num_force,j_1]].y then m2[i_1,m1[num_value,num_force,j_1]].y:=round(y/koef_y)+1;
                        end
                        else
                        begin
                                if m2[1,m1[num_value,num_force,j_1]].x=x then m2[i_1,m1[num_value,num_force,j_1]].x:=round(x/koef_x)+1;
                                if m2[1,m1[num_value,num_force,j_1]].y=y then m2[i_1,m1[num_value,num_force,j_1]].y:=round(y/koef_y)+1;
                        end;
                        Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
                        paintbox1paint(self);
                        //конструкция изменена
                        delall2_btnClick(Self);
                        save_stat:=1;
                end;
        end

        else if del_btn.Down then
        begin
                flag2:=false; //если правда, то курсор рядом с отрезком
                for i:=1 to n_otr do
                        begin
                        if m1[num_value,num_force,i]<>0 then
                        begin
                           with paintbox1.canvas do
                           begin
                                x1:=round(m2[1,m1[num_value,num_force,i]].X*koef_x);
                                x2:=round(m2[2,m1[num_value,num_force,i]].X*koef_x);
                                y1:=round(m2[1,m1[num_value,num_force,i]].y*koef_y);
                                y2:=round(m2[2,m1[num_value,num_force,i]].y*koef_y);
                                usl:=false;

                                        //при вычислении приближений к вертикальным и горизонтальным стержням
                                        //этот параметр должен быть больше, чем при приближении к наклонным
                                        if (abs(x1-x2)<20*koef_x)or(abs(y1-y2)<20*koef_y) then a:=8*koef_y else a:=0.04*koef_y;
                                        if  (x2<>x1) and (y2<>y1) then
                                          begin
                                            if  ((abs((x-x1)/(x2-x1)-(y-y1)/(y2-y1))<a)and
                                            ((x<=max2(x1,x2)+3)and(x>=min2(x1,x2)-3))and
                                            ((y<=max2(y1,y2)+3)and(y>=min2(y1,y2)-3)))
                                             then usl:=true;
                                          end
                                        else
                                            if  (((x<=max2(x1,x2)+3)and(x>=min2(x1,x2)-3))and
                                            ((y<=max2(y1,y2)+3)and(y>=min2(y1,y2)-3)))
                                            then usl:=true;

                                if usl then
                                begin
                                           //     Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
                                           //     paintbox1paint(self);
                                                flag2:=true;
                                                present_num:=i;
                                                pen.color:=clWhite;
                                                moveTo(x1,y1);
                                                lineTo(x2,y2);
                                end
                                else if not usl then
                                begin
                                     case num_value of
                                        1: pen.Color:=clAqua;  //по Х
                                        2: pen.Color:=clBlack;  //по У
                                        3: pen.Color:=clLime;  //касательное
                                        4: pen.color:=clYellow;//эквив.
                                        5: pen.Color:=clBlue; //вектора
                                        6: pen.Color:=clGreen; // толщина - Самойленко А.Е. 11.11.07
                                     end;
                                     moveTo(x1,y1);
                                     lineTo(x2,y2);
                                end;
                           end;
                        end;
                end;


        end;
        if snCB.Text='<Максимальное>' then num_force:=iii;
   end;

end;

//        if snCB.ItemIndex=kl1 then num_force:=4;

///////////////////////
//////////////////////
function TVisio_Form.Node_cord(var n:integer):TArr;
 var
 x_int,y_int:integer;
 x,y: single;
 begin
//jk.jk.
 if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (n mod plast.ky1)=0 then
         begin
          x_int:=n div plast.ky1;
          x:=plast.xm1[(n div plast.ky1)];

         end
         else
          begin
           x_int:=(n div plast.ky1)+1;
           x:=plast.xm1[(n div plast.ky1)+1];

          end;
       y:=plast.ym1[n-plast.ky1*(x_int-1)];
     end
 else
     begin

     if (n mod plast.kx1)=0 then
         begin
          y_int:=n div plast.kx1;
          y:=plast.ym1[(n div plast.kx1)];
         end
         else
          begin
           y_int:=(n div plast.kx1)+1;
           y:=plast.ym1[(n div plast.kx1)+1];
          end;
       x:=plast.xm1[n-plast.kx1*(y_int-1)];

    end;

 node_cord[1]:=x;
 node_cord[2]:=y;
 end;

//////////////////////
//////////////////////


procedure TVisio_Form.save_btnClick(Sender: TObject);
var
        fff: textfile;
        i,j,k:integer;
begin
        if set_value=0 then
        begin
                AssignFile(fff,ChangeFileExt(Fnn,'.ot2'));
                rewrite(fff);
                writeln(fff,extractfilename(fnn));
//                writeln(fff,'ferma7');
                for i:=1 to n_napr do
                        for j:=1 to n_nagr do
                                for k:=1 to n_otr do writeln(fff,inttostr(m1[i,j,k]));
                        writeln(fff);
                        for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                        begin
                                writeln(fff,inttostr(m2[i,j].X));
                                writeln(fff,inttostr(m2[i,j].Y));
                        end;
                closefile(fff);
                Save_stat:=0;
                messagedlg('Схемы силовых линий сохранены.',mtInformation,[mbOk],0);
        end

        else begin
                SaveDialog1.DefaultExt:='.pwl';
                SaveDialog1.Filter := 'Файл силовых линий (*.pwl)|*.pwl';
                SaveDialog1.FileName:=ChangeFileExt(extractfilename(fnn),'');
                if SaveDialog1.Execute then
                begin
                        if set_value=3 then
                        begin
                                assignFile(fff,SaveDialog1.FileName);
                                rewrite(fff);
                                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        //записываем файл с абсолютными координатами
                                        writeln(fff,round(m2all2[i,j].x*max_x_coord/403));
                                        writeln(fff,round(m2all2[i,j].y*max_y_coord/221));
                                end;


                                //количество закрепленных узлов
                                writeln(fff,plast.kz1);

                                //записываем координаты закреплений
                               for k:=1 to kz1 do
                               begin
//                                        for i:=1 to plast.kx1 do for j:=1 to plast.ky1 do
//                                        begin
//                                                if zak1[k]=j+ky1*(i-1) then

                                             begin
                                                        writeln(fff,round(node_cord(zak1[k])[1]));
                                                        writeln(fff,round(node_cord(zak1[k])[2]));
                                             end;

//                                end;
                                end;

                                //записываем тип закреплений
                                for i:=1 to kz1 do
                                begin
                                        writeln(fff,zak2[i]);  // Х-коорд.
                                        writeln(fff,zak3[i]);  // Y-коорд.
                                end;

                                //записываем размеры области
                                writeln(fff,round(xm1[kx1]));
                                writeln(fff,round(ym1[ky1]));

                                //количество нагрузок
                                writeln(fff,kl1);

                                //записываем координаты нагруженных узлов
                                for k:=1 to kl1 do
                                begin
//                                        for i:=1 to plast.kx1 do for j:=1 to plast.ky1 do
//                                        begin
//                                                if nomm[k]=j+ky1*(i-1) then
                                                begin
                                                        writeln(fff,round(node_cord(nomm[k])[1]));
                                                        writeln(fff,round(node_cord(nomm[k])[2]));
                                                end;
//                                        end;
                                end;

                                //записываем значения нагрузок
                                for i:=1 to kl1 do
                                begin
                                        writeln(fff,nom11[i]);
                                        writeln(fff,nom22[i]);
                              end;


                                closeFile(fff);
                        end
                        else
                        begin
                                assignFile(fff,SaveDialog1.FileName);
                                rewrite(fff);
                                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        //записываем файл с абсолютными координатами
                                        writeln(fff,round(m2all[i,j].x*max_x_coord/403));
                                        writeln(fff,round(m2all[i,j].y*max_y_coord/221));
                                end;

                                //количество закрепленных узлов
                                writeln(fff,plast.kz1);

                                //записываем координаты закреплений
                                for k:=1 to kz1 do
                                begin
//                                        for i:=1 to plast.kx1 do for j:=1 to plast.ky1 do
//                                        begin
//                                                if zak1[k]=j+ky1*(i-1) then

                                                begin
                                                        writeln(fff,round(node_cord(zak1[k])[1]));
                                                        writeln(fff,round(node_cord(zak1[k])[2]));
                                                end;
//                                        end;
                                end;

                                //записываем тип закреплений
                                for i:=1 to kz1 do
                                begin
                                        writeln(fff,zak2[i]);  // Х-коорд.
                                        writeln(fff,zak3[i]);  // Y-коорд.
                                end;

                                //записываем размеры области
                                writeln(fff,round(xm1[kx1]));
                                writeln(fff,round(ym1[ky1]));

                                //количество нагрузок
                                writeln(fff,kl1);

                                //записываем координаты нагруженных узлов
                                for k:=1 to kl1 do
                                begin
//                                writeln(fff,'Че за хуйня?');
                                writeln(fff,round(node_cord(nomm[k])[1]));
                                writeln(fff,round(node_cord(nomm[k])[2]));
                                end;

                                //записываем значения нагрузок
                                for i:=1 to kl1 do
                                begin
                                        writeln(fff,nom11[i]);
                                        writeln(fff,nom22[i]);
                                end;


                                closeFile(fff);
                        end;
                end;
        end;

end;
procedure TVisio_Form.load_btnClick(s:string);
var
        fff: textfile;
        i,j,k,napr:integer;
        a:string;
begin
   a:=ChangeFileExt(s,'.ot2');
   if fileExists(a) then
   begin
        AssignFile(fff,a);
        reset(fff);
        readln(fff,a);
{        readln(fff,a);
        if a='ferma7' then
          napr:=n_napr+1
        else
          napr:=n_napr; }
        for i:=1 to n_napr do
                for j:=1 to n_nagr do
                        for k:=1 to n_otr do begin
                                readln(fff,a);
                                m1[i,j,k]:=strToInt(a);
                        end;
        readln(fff);
        for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        readln(fff,a);
                        m2[i,j].X:=strToInt(a);
                        readln(fff,a);
                        m2[i,j].Y:=strToInt(a);
                end;
        closefile(fff);
   end;
//   else showmessage('жопа 2');

end;

procedure TVisio_Form.delall_btnClick(Sender: TObject);
var iii,i,j,k:integer;
begin
     ukaz_btn.Down:=false;
     if snCB.Text='<Максимальное>' then
      begin
        iii:=num_force;
        num_force:=4;
      end;
     if num_value<7 then
       begin
        for i:=1 to n_otr do
        begin
                if m1[num_value,num_force,i]<>0 then
                begin
                        m2[1,m1[num_value,num_force,i]].X:=0;
                        m2[1,m1[num_value,num_force,i]].Y:=0;
                        m1[num_value,num_force,i]:=0;
                end;
        end;
     end
     else if num_value>=7 then
     begin
        for i:=1 to n_napr do
                for j:=1 to n_nagr do
                        for k:=1 to n_otr do m1[i,j,k]:=0;
        for i:=1 to 2 do
        begin
                for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        m2[i,j].x:=0;
                        m2[i,j].y:=0;
                end;
        end;
     end;
     //конструкция изменена
     delall2_btnClick(Self);
     save_stat:=1;
     Canvas.copyrect(rect(0,0,width,height),bitmap.canvas,rect(0,0,width,height));
     if snCB.Text='<Максимальное>' then num_force:=iii;
     paintbox1paint(self);
end;



function cross_otr(x1,y1,x2,y2,x3,y3,x4,y4:integer):TPoint;
var x0,y0:integer;
begin
//исключение вертикали/горизонтали
   if x1=x2 then x1:=x1+1;
   if x3=x4 then x3:=x3+1;
   if y2=y1 then y1:=y1+1;
//исключение параллельных линий
   if ((y2-y1)/(x2-x1))<>((y4-y3)/(x4-x3)) then
   begin
        //нахождение точки пересечения линий (x0,y0)
        y0:=round(((x3-x1)*(y2-y1)*(y4-y3)+y1*(x2-x1)*(y4-y3)-y3*(y2-y1)*(x4-x3))/((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3)));
        x0:=round((((y0-y1)*(x2-x1))/(y2-y1))+x1);
        //проверка на истинность пересечения отрезков, если не пересекаются, то значения отрицательные
        if ((x1<x0)and(x2<x0))or((y1<y0)and(y2<y0))or((x1>x0)and(x2>x0))or((y1>y0)and(y2>y0)) then
        begin
                cross_otr.X:=-1;
                cross_otr.Y:=-1;
        end
        else if ((x3<x0)and(x4<x0))or((y3<y0)and(y4<y0))or((x3>x0)and(x4>x0))or((y3>y0)and(y4>y0)) then
        begin
                cross_otr.X:=-1;
                cross_otr.Y:=-1;
        end
        else
        begin
                cross_otr.X:=x0;
                cross_otr.Y:=y0;
        end;
   end
   else
   begin
        cross_otr.X:=-1;
        cross_otr.Y:=-1;
   end;
end;

function cross_line(x1,y1,x2,y2,x3,y3,x4,y4:integer):TPoint;
var x0,y0:integer;
begin
//исключение вертикали/горизонтали
   if x1=x2 then x1:=x1+1;
   if x3=x4 then x3:=x3+1;
   if y2=y1 then y1:=y1+1;
//исключение параллельных линий
   if ((y2-y1)/(x2-x1))<>((y4-y3)/(x4-x3)) then
   begin
        //нахождение точки пересечения линий (x0,y0)
        y0:=round(((x3-x1)*(y2-y1)*(y4-y3)+y1*(x2-x1)*(y4-y3)-y3*(y2-y1)*(x4-x3))/((x2-x1)*(y4-y3)-(y2-y1)*(x4-x3)));
        x0:=round((((y0-y1)*(x2-x1))/(y2-y1))+x1);
        cross_line.X:=x0;
        cross_line.Y:=y0;
   end
   else
   begin
        cross_line.X:=-1;
        cross_line.Y:=-1;
   end;
end;


procedure TVisio_Form.opt_btnClick(Sender: TObject);
begin
        ukaz_btn.Down:=false;
        vpb.ShowModal;

        //Вывод результата

        panel_TB.Show;
        colorYNo.Hide;
        //panel.Hide;
        draw_btn.Enabled:=false;
        del_btn.Enabled:=false;
        delall_btn.Enabled:=false;
        formPaint(Self);
        paintbox1Paint(Self);
end;

procedure TVisio_Form.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
        iii,i,j:integer;
        koef_x,koef_y: real;
begin
  if snCB.Text='<Максимальное>' then
  begin
        iii:=num_force;
        num_force:=4;
  end;

 //масштабирующие коэффициенты
 koef_x:=403/paintBox1.Width;
 koef_y:=220/paintBox1.Height;

 //ограничитель поля рисования
 if (x<5/Koef_x) then x:=round(5/Koef_x);
 if (x>PaintBox1.Width-5/Koef_x) then x:=round(paintBox1.Width-5/Koef_x);
 if (y<5/Koef_y) then y:=round(5/Koef_y);
 if (y>PaintBox1.Height-10/Koef_y) then y:=round(paintBox1.Height-10/Koef_y);

 if (flag3)and not((x_1=x)and(y_1=y)) then
 begin
   if x_1=x then x_1:=x+round(1/koef_x);
   if y_1=y then y_1:=y+round(1/koef_y);
   if (m1[num_value,num_force,n_otr]=0)and(draw_btn.Down)and not(ssShift in Shift) then
   begin
        with paintbox1.Canvas do
        begin
                        pen.width:=round(0.015*paintBox1.Height);
                        case num_value of
                                1: pen.Color:=clAqua;  //по Х
                                2: pen.Color:=clBlack;  //по У
                                3: pen.Color:=clLime;  //касательное
                                4: pen.color:=clYellow; //эквив.
                                5: pen.Color:=clBlue;  //вектора
                                6: pen.Color:=clGreen; // толщина - Самойленко А.Е. 11.11.07
                        end;
                        moveTo(x_1,y_1);
                        lineTo(x,y);
        end;

                        i:=0;
                        //запись данных в массив отрезков
                        repeat
                                i:=i+1;
                        until m1[num_value,num_force,i]=0;  //нашли свободную ячейку в m1
                        j:=0;
                        repeat
                             j:=j+1;
                        until ((m2[1,j].x=0)and(m2[1,j].y=0)and(m2[2,j].x=0)and(m2[2,j].y=0));
                        //нашли свободную ячейку в m2


                        //записываем данные
                        m1[num_value,num_force,i]:=j;
                        m2[1,j].X:=round(x_1*koef_x);
                        m2[1,j].Y:=round(y_1*koef_y);
                        m2[2,j].X:=round(x*koef_x);
                        m2[2,j].Y:=round(y*koef_y);
                 //       if x_1=x then m2[2,j].X:=round(x*koef_x)+1;
                   //     if y_1=y then m2[2,j].Y:=round(y*koef_y)+1;
                        flag:=false;
                        //конструкция изменена
                        delall2_btnClick(Self);
                        save_stat:=1;
                        flag3:=false;
   end;
 end
 else flag:=false;
 if snCB.Text='<Максимальное>' then num_force:=iii;
end;

procedure opt_A(var m2opt:ar1;zzz:real);
var
        i,j,p,k,l,
        x0,y0,x1,x2,x3,x4,y1,y2,y3,y4,par:integer;
        a1,a2:real;

begin

        //Координатная оптимизация
        //Сведение 2х к одному при разнице координат не более значения zzz

        for i:=1 to n_napr*n_nagr*n_otr do
        begin
             if not((m2opt[1,i].X=0) and (m2opt[1,i].Y=0) and (m2opt[2,i].X=0) and (m2opt[2,i].Y=0)) then
             begin
                for j:=1 to n_napr*n_nagr*n_otr do
                begin
                   if ((not((m2opt[1,j].X=0) and (m2opt[1,j].Y=0) and (m2opt[2,j].X=0) and (m2opt[2,j].Y=0)))and(i<>j)) then
                   begin
                        if ((abs(m2opt[1,i].x-m2opt[1,j].x)<zzz) and (abs(m2opt[1,i].y-m2opt[1,j].y)<zzz) and
                        (abs(m2opt[2,i].x-m2opt[2,j].x)<zzz) and (abs(m2opt[2,i].y-m2opt[2,j].y)<zzz)) then
                        begin
                                m2opt[1,i].x:=round((m2opt[1,i].x+m2opt[1,j].x)/2);
                                m2opt[1,i].y:=round((m2opt[1,i].y+m2opt[1,j].y)/2);
                                m2opt[2,i].x:=round((m2opt[2,i].x+m2opt[2,j].x)/2);
                                m2opt[2,i].y:=round((m2opt[2,i].y+m2opt[2,j].y)/2);
                                m2opt[1,j].X:=0;
                                m2opt[1,j].Y:=0;
                                m2opt[2,j].X:=0;
                                m2opt[2,j].Y:=0;
                        end
                        else if ((abs(m2opt[1,i].x-m2opt[2,j].x)<zzz) and (abs(m2opt[1,i].y-m2opt[2,j].y)<zzz) and
                        (abs(m2opt[2,i].x-m2opt[1,j].x)<zzz) and (abs(m2opt[2,i].y-m2opt[1,j].y)<zzz)) then
                        begin
                                m2opt[1,i].x:=round((m2opt[1,i].x+m2opt[2,j].x)/2);
                                m2opt[1,i].y:=round((m2opt[1,i].y+m2opt[2,j].y)/2);
                                m2opt[2,i].x:=round((m2opt[2,i].x+m2opt[1,j].x)/2);
                                m2opt[2,i].y:=round((m2opt[2,i].y+m2opt[1,j].y)/2);
                                //исключение горизонтальных и вертикальных линий
                                if m2opt[1,i].x=m2opt[2,i].x then m2opt[2,i].x:=m2opt[2,i].x+1;
                                if m2opt[1,i].y=m2opt[2,i].y then m2opt[2,i].y:=m2opt[2,i].y+1;

                                m2opt[1,j].X:=0;
                                m2opt[1,j].Y:=0;
                                m2opt[2,j].X:=0;
                                m2opt[2,j].Y:=0;
                        end;
                   end;
                end;
             end
        end;
end;

procedure opt_B(var m2opt:ar1;zzz2:real);
var
        i,j,p,k,l,
        x0,y0,x1,x2,x3,x4,y1,y2,y3,y4,par:integer;
        a1,a2:real;
        cp:TPoint;
begin

        //Угловая оптимизация
        //Сведение 2х к одному при разнице углов наклона не более значения zzz2

        for i:=1 to n_napr*n_nagr*n_otr do
        begin
             if not((m2opt[1,i].X=0) and (m2opt[1,i].Y=0) and (m2opt[2,i].X=0) and (m2opt[2,i].Y=0)) then
             begin
                for j:=1 to n_napr*n_nagr*n_otr do
                begin
                   if ((not((m2opt[1,j].X=0) and (m2opt[1,j].Y=0) and (m2opt[2,j].X=0) and (m2opt[2,j].Y=0)))and(i<>j)) then
                   begin
                        //упорядочивание всех отрезков в массиве вправо (т.е. x1<x2 для любого отрезка)
                        for k:=1 to n_napr*n_nagr*n_otr do
                        begin
                                if m2opt[1,k].X>m2opt[2,k].X then
                                begin
                                     cp:=m2opt[1,k];
                                     m2opt[1,k]:=m2opt[2,k];
                                     m2opt[2,k]:=cp;
                                end;
                        end;

                        //угловая оптимизация по Х
                        x1:=m2opt[1,i].x;
                        y1:=m2opt[1,i].y;
                        x2:=m2opt[2,i].x;
                        y2:=m2opt[2,i].y;
                        x3:=m2opt[1,j].x;
                        y3:=m2opt[1,j].y;
                        x4:=m2opt[2,j].x;
                        y4:=m2opt[2,j].y;
                        if (cross_otr(x1,y1,x2,y2,x3,y3,x4,y4).x>0)and(cross_otr(x1,y1,x2,y2,x3,y3,x4,y4).Y>0) then
                        begin
                                //убираем горизонталь/вертикаль
                                if x2=x1 then x1:=x1+1;
                                if x3=x4 then x3:=x3+1;

                                a1:=(RadToDeg(ArcTan((y2-y1)/(x2-x1))));
                                a2:=(RadToDeg(ArcTan((y4-y3)/(x4-x3))));
                                if (abs(a1-a2)<zzz2) then
                                begin
                                        if (a1<45)and(a1>-45) then
                                        begin
                                                if x1>x3 then m2opt[1,i].X:=x3 else m2opt[1,i].X:=x1;
                                                if x2>x4 then m2opt[2,i].X:=x2 else m2opt[2,i].X:=x4;
                                                m2opt[1,i].y:=round((y1+y3)/2);
                                                m2opt[2,i].y:=round((y2+y4)/2);
                                        end
                                        else
                                        begin
                                                //упорядочивание всех отрезков в массиве вверх (т.е. y1<y2 для любого отрезка)
                                                for k:=1 to n_napr*n_nagr*n_otr do
                                                begin
                                                        if m2opt[1,k].Y>m2opt[2,k].Y then
                                                        begin
                                                             cp:=m2opt[1,k];
                                                             m2opt[1,k]:=m2opt[2,k];
                                                             m2opt[2,k]:=cp;
                                                        end;
                                                end;
                                                x1:=m2opt[1,i].x;
                                                y1:=m2opt[1,i].y;
                                                x2:=m2opt[2,i].x;
                                                y2:=m2opt[2,i].y;
                                                x3:=m2opt[1,j].x;
                                                y3:=m2opt[1,j].y;
                                                x4:=m2opt[2,j].x;
                                                y4:=m2opt[2,j].y;
                                                //запись результата
                                                if y1>y3 then m2opt[1,i].y:=y3 else m2opt[1,i].y:=y1;
                                                if y2>y4 then m2opt[2,i].y:=y2 else m2opt[2,i].y:=y4;
                                                m2opt[1,i].x:=round((x1+x3)/2);
                                                m2opt[2,i].x:=round((x2+x4)/2);
                                        end;
                                        m2opt[1,j].x:=0;
                                        m2opt[2,j].x:=0;
                                        m2opt[1,j].y:=0;
                                        m2opt[2,j].y:=0;
                                end
                                //оптимизация по У для прямых А и В, где tgA ~ 90, tgB ~ -90
                                else if (90-abs(a1)<zzz2)and(90-abs(a2)<zzz2)and(a1*a2<0) then
                                begin
                                        m2opt[1,i].x:=round((x2+x3)/2);
                                        m2opt[2,i].x:=round((x1+x4)/2);
                                        m2opt[1,i].y:=max2(max2(y1,y2),max2(y3,y4));
                                        m2opt[2,i].y:=min2(min2(y1,y2),min2(y3,y4));
                                        m2opt[1,j].x:=0;
                                        m2opt[2,j].x:=0;
                                        m2opt[1,j].y:=0;
                                        m2opt[2,j].y:=0;
                                end;
                                //исключение горизонтальных и вертикальных линий
                                if m2opt[1,i].x=m2opt[2,i].x then m2opt[2,i].x:=m2opt[2,i].x+1;
                                if m2opt[1,i].y=m2opt[2,i].y then m2opt[2,i].y:=m2opt[2,i].y+1;
                        end;
                    end;
                end;
             end;
        end;

end;

procedure opt_C(var m2opt:ar1;zzz:real);
var
        i,j,p,k,l,
        x0,y0,x1,x2,x3,x4,y1,y2,y3,y4,par:integer;
        a1,a2:real;
begin

        //сведение близких узлов к одному

        for i:=1 to n_napr*n_nagr*n_otr do
        begin
             if not((m2opt[1,i].X=0) and (m2opt[1,i].Y=0) and (m2opt[2,i].X=0) and (m2opt[2,i].Y=0)) then
             begin
                   for j:=1 to n_napr*n_nagr*n_otr do
                   begin
                        if ((not((m2opt[1,j].X=0) and (m2opt[1,j].Y=0) and (m2opt[2,j].X=0) and (m2opt[2,j].Y=0)))and(i<>j)) then
                        begin
                                for k:=1 to 2 do
                                begin
                                        for l:=1 to 2 do
                                        begin
                                                if ((abs(m2opt[k,i].x-m2opt[l,j].x)<zzz)and
                                                    (abs(m2opt[k,i].y-m2opt[l,j].y)<zzz)) then
                                                begin
                                                        m2opt[k,i].X:=round((m2opt[k,i].X+m2opt[l,j].X)/2);
                                                        m2opt[l,j].X:=round((m2opt[k,i].X+m2opt[l,j].X)/2);
                                                        m2opt[k,i].Y:=round((m2opt[k,i].Y+m2opt[l,j].Y)/2);
                                                        m2opt[l,j].Y:=round((m2opt[k,i].Y+m2opt[l,j].Y)/2);
                                                end;
                                        end;
                                end;
                        end;
                   end;
             end;
        end;

end;





procedure opt(m:ar1;var m2opt:ar1);
var
        i,j,p,k,l,o,
        x0,y0,x1,x2,x3,x4,y1,y2,y3,y4,par:integer;
        zzz,zzz2,zzz3,a1,a2:real;
        cp:TPoint;
        f,f2:boolean;
        mz:ar1;
begin
 if Visio_Form.itr<>0 then
 begin
   for i:=1 to 2 do
   begin
        for j:=1 to n_napr*n_nagr*n_otr do
        begin
                m2opt[i,j].X:=m[i,j].X;
                m2opt[i,j].Y:=m[i,j].Y;
        end;
   end;
   p:=1;
{   if (Visio_Form.set_value=1)or(Visio_Form.set_value=2) then
   begin
        zzz:=25;//Visio_Form.ScrollBar1.position;   //коэфф. для коорд. оптимизации (расстояние) 0..220
        zzz2:=(zzz*90)/220;                    //коэфф. для угловой оптимизации (угол) 0..90 град.
        zzz3:=zzz;
   end
   else
   begin}
   zzz:=Visio_Form.kfc1*4;
   zzz2:=Visio_Form.kfc2*0.9;
   zzz3:=Visio_Form.kfc3*4;


{   if Visio_Form.set_value=3 then
   begin}
           o:=0;
           repeat
                if vpb.cb11.Checked then
                begin
                        if vpb.cb22.Checked then
                        begin
                                opt_A(m2opt,Visio_Form.kfc1);
                                opt_B(m2opt,Visio_Form.kfc2);
                                opt_C(m2opt,Visio_Form.kfc3);
                        end
                        else
                        begin
                                opt_A(m2opt,Visio_Form.kfc1);
                                opt_C(m2opt,Visio_Form.kfc3);
                                opt_B(m2opt,Visio_Form.kfc2);
                        end;
                end
                else if vpb.cb21.Checked then
                begin
                        if vpb.cb12.Checked then
                        begin
                                opt_B(m2opt,Visio_Form.kfc2);
                                opt_A(m2opt,Visio_Form.kfc1);
                                opt_C(m2opt,Visio_Form.kfc3);
                        end
                        else
                        begin
                                opt_B(m2opt,Visio_Form.kfc2);
                                opt_C(m2opt,Visio_Form.kfc3);
                                opt_A(m2opt,Visio_Form.kfc1);
                        end;
                end
                else if vpb.cb31.Checked then
                begin
                        if vpb.cb12.Checked then
                        begin
                                opt_C(m2opt,Visio_Form.kfc3);
                                opt_A(m2opt,Visio_Form.kfc1);
                                opt_B(m2opt,Visio_Form.kfc2);
                        end
                        else
                        begin
                                opt_C(m2opt,Visio_Form.kfc3);
                                opt_B(m2opt,Visio_Form.kfc2);
                                opt_A(m2opt,Visio_Form.kfc1);
                        end;
                end;
                o:=o+1;
           until o=Visio_Form.itr;
 end;
end;
procedure TVisio_Form.all_btnClick(Sender: TObject);
var
        m,m0:ar1;
        k,i,j,z,o,p:integer;
        s:string;
        fff: textfile;

begin
        ukaz_btn.Down:=false;
        if all_btn.Down then
        begin
         //  if ((Save_Stat=0) or ((Save_stat=1) and (messagedlg('Схемы силовых линий изменены.'+#10+#13+'Перед расчетами требуется '+#10+#13+'сохранить схемы.'+#10+#13+#10+#13+'Сохранить?',mtWarning,[mbYes,mbNo],0)=6))) then
         //  begin


                if save_stat=1 then
                begin
                        old_value:=set_value;
                        set_value:=0;
                        save_btnClick(Self);
                        set_value:=old_value;
                end;
                if set_value<>3 then set_value:=1;
                show_btn.Down:=false;
                draw_btn.Down:=false;
                del_btn.Down:=false;
                delall_btn.Down:=false;
                opt_btn.Enabled:=true;
                panel_TB.Show;
                colorYNo.Hide;
                all_ToolBar.Hide;
                draw_btn.Enabled:=false;
                del_btn.Enabled:=false;
                delall_btn.Enabled:=false;
                delall2_btn.Enabled:=true;
                all2_btn.Enabled:=true;
                Save_btn.Hint:='Сохранение текущего изображения в файл .pwl';
                {panel.Hide;
                panel.Visible:=false;}
                Hinter.Hide;
                Hinter.Caption:='';
                Napr_PaintBox.Visible:=false;
                Minus_Sbtn.Visible:=false;
                Plus_Sbtn.Visible:=false;
                Visio_Form.Repaint;


//!!!!!!!!!!!!!!!!!!!!! A !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


                if not FileExists(extractfilename(ChangeFileExt(Fnn,'.ot1'))) then
                begin
                        AssignFile(fff,ChangeFileExt(Fnn,'.ot1'));
                        rewrite(fff);
                        writeln(fff,extractfilename(fnn));
                        for k:=1 to n_napr do
                        begin
                                for i:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        m[1,i].X:=0;
                                        m[1,i].Y:=0;
                                        m[2,i].X:=0;
                                        m[2,i].Y:=0;
                                end;
                                for i:=1 to n_nagr do for j:=1 to n_otr do
                                begin
                                        z:=m1[k,i,j];
                                        if z<>0 then
                                        begin
                                                m[1,z]:=m2[1,z];
                                                m[2,z]:=m2[2,z];
                                        end;
                                end;
                                for i:=1 to 2 do
                                begin
                                        for j:=1 to n_napr*n_nagr*n_otr do
                                        begin
                                                writeln(fff,intToStr(m[i,j].X));
                                                writeln(fff,intToStr(m[i,j].Y));
                                        end;
                                end;
                        end;
                        closeFile(fff);
                end;

             if set_value<3 then
             begin
                AssignFile(fff,ChangeFileExt(Fnn,'.ot1'));
                reset(fff);
                readln(fff);
                for i:=1 to n_napr*n_nagr*n_otr do
                begin
                        m2all[1,i].X:=0;
                        m2all[1,i].Y:=0;
                        m2all[2,i].X:=0;
                        m2all[2,i].Y:=0;
                end;
                for k:=1 to n_napr do
                begin
                        for i:=1 to 2 do
                        begin
                                for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        readln(fff,s);
                                        if k=num_value then m2all[i,j].X:=strToInt(s);
                                        readln(fff,s);
                                        if k=num_value then m2all[i,j].Y:=strToInt(s);
                                end;
                        end;
                end;
                closeFile(fff);
                m2opt:=m2all;
             end
             else
             begin
                //сливаем результаты всех расчетов из файла .ot1 в матрицу m2all2,
                //после чего выводим
                AssignFile(fff,ChangeFileExt(Fnn,'.ot1'));
                reset(fff);
                readln(fff); //имя файла
                for i:=1 to 2 do
                begin
                        for j:=1 to n_nagr*n_napr*n_otr do
                        begin
                                m2all2[i,j].X:=0;
                                m2all2[i,j].Y:=0;
                        end;
                end;

                for k:=1 to n_napr do
                begin
                o:=n_nagr*n_otr*(k-1);
                        for i:=1 to 2 do
                        begin
                        p:=1;
                                for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        readln(fff,s);
                                        if s<>'0' then
                                        begin
                                                m2all2[i,p+o].X:=StrToInt(s);
                                                readln(fff,s);
                                                m2all2[i,p+o].Y:=StrToInt(s);
                                                p:=p+1;
                                        end
                                        else readln(fff,s);
                                end;
                        end;
                end;
                CloseFile(fff);
             end;

                //Вывод результата
                Panel_TB.Show;
                colorYNo.Hide;
                //panel.Hide;
                draw_btn.Enabled:=false;
                del_btn.Enabled:=false;
                delall_btn.Enabled:=false;


//!!!!!!!!!!!!!!!!!!!! end A !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                formPaint(Self);
                paintbox1Paint(Self);
           //end
           //else all_btn.Down:=false;
        end
        else if not all_btn.Down then
        begin
                set_value:=0;
                Napr_PaintBox.Visible:=True;
                Minus_Sbtn.Visible:=True;
                Plus_Sbtn.Visible:=True;
                hinter.Hide;
                opt_btn.Down:=false;
                opt_btn.Enabled:=false;
                colorYNo.Show;
                All_ToolBar.Show;
                //panel.Show;
                draw_btn.Enabled:=true;
                del_btn.Enabled:=true;
                delall_btn.Enabled:=true;
                delall2_btn.Enabled:=false;
                all2_btn.Enabled:=false;
                all2_btn.Down:=false;
                Save_btn.Hint:='Сохранение схем силовых линий';

                formPaint(Self);
                if set_value=0 then Napr_PaintBoxPaint(Self);
                PaintBox1Paint(Self);
        end;
end;



// Процедура рисования закреплений для отрезков
procedure TVisio_Form.bound_draw_for_otr(x_max,y_max:integer;mas_x,mas_y:single);
var
 i,j,x_int,y_int,sh_x:integer;
 x,y:single;
begin
   with PaintBox.Canvas do
    begin
     pen.Width:=2;
     pen.Color:=clBlue;
     brush.color:=clWhite;
   for i:=1 to plast.kz1 do          // Здесь можно поправить !!!
    begin

      if plast.kx1>=plast.ky1 then        // Определение координат узла от его номера
     begin
     if (plast.zak1[i] mod plast.ky1)=0 then
         begin
          x_int:=plast.zak1[i] div plast.ky1;
          x:=plast.xm1[(plast.zak1[i] div plast.ky1)];

         end
         else
          begin
           x_int:=(plast.zak1[i] div plast.ky1)+1;
           x:=plast.xm1[(plast.zak1[i] div plast.ky1)+1];

          end;
       y:=plast.ym1[plast.zak1[i]-plast.ky1*(x_int-1)];

     end
    else
     begin

     if (plast.zak1[i] mod plast.kx1)=0 then
         begin
          y_int:=plast.zak1[i] div plast.kx1;
          y:=plast.ym1[(plast.zak1[i] div plast.kx1)];
         end
         else
          begin
           y_int:=(plast.zak1[i] div plast.kx1)+1;
           y:=plast.ym1[(plast.zak1[i] div plast.kx1)+1];
          end;
       x:=plast.xm1[plast.zak1[i]-plast.kx1*(y_int-1)];

    end;

     sh_x:=34;
     if (plast.zak2[i]=1) or (plast.zak3[i]=1) then
      begin
       if (plast.zak2[i]=1) and (plast.zak3[i]=1) then
        begin
         MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
         LineTo(sh_x+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

         MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
         LineTo(sh_x+round(mas_x*x)+4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

         MoveTo(sh_x+round(mas_x*x)-8+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);
         LineTo(sh_x+round(mas_x*x)+8+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

         Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,sh_x+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);

         pen.Width:=1;
         for j:=-2 to 2 do
          begin
           MoveTo(sh_x+round(mas_x*x)+j*4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);
           LineTo(sh_x+round(mas_x*x)+j*4-2+coord_axis_x,y_max-30-round(mas_y*y)+15-coord_axis_y);
          end;
         pen.Width:=2;
        end;

       if (plast.zak2[i]=1) and (plast.zak3[i]=0) then
        begin
         MoveTo(sh_x+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)-8-coord_axis_y);
         LineTo(sh_x+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)+8-coord_axis_y);
         Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,sh_x+round(mas_x*x)+5+coord_axis_x,y_max-30-round(mas_y*y)+5-coord_axis_y);
         pen.Width:=1;
         for j:=-2 to 2 do
          begin
           MoveTo(sh_x+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)-j*4-coord_axis_y);
           LineTo(sh_x+round(mas_x*x)-9+coord_axis_x,y_max-30-round(mas_y*y)-j*4+2-coord_axis_y);
         end;
         pen.Width:=2;
        end;

       if (plast.zak2[i]=0) and (plast.zak3[i]=1) then
        begin
         MoveTo(sh_x+round(mas_x*x)-8+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
         LineTo(sh_x+round(mas_x*x)+8+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
         Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,sh_x+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
         pen.Width:=1;
         for j:=-2 to 2 do
          begin
           MoveTo(sh_x+round(mas_x*x)+j*4+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
           LineTo(sh_x+round(mas_x*x)+j*4-2+coord_axis_x,y_max-30-round(mas_y*y)+9-coord_axis_y);
         end;
         pen.Width:=2;
        end;
     end;
   end;
 end;
end; // закрываем процедуру


//Процедура рисования нагружений для отрезков
procedure TVisio_Form.force_draw_for_otr(x_max,y_max:integer;mas_x,mas_y:single); //Рисуем нагружения
var
        i,x_int,y_int,ii,iii,sh_x:integer;
        x,y:single;
        k:integer;
        flag_draw:array[1..1000,1..2] of integer;
begin
 //       if snCB.Text='<Максимальное>' then num_force:=4;
        with PaintBox.Canvas do
        begin
                Pen.color:=clBlue;
                Pen.width:=2;
                brush.color:=clWhite;
                if plast.kl1=0 then exit;  //если нет сил
{    ii:=Visio_form.num_force;
    if ii>plast.kl1 then ii:=kl1;
    if num_force=kl1+1 then iii:=1 else iii:=ii;
    if (all_btn.Down)or(show_btn.Down) then
                begin
                        ii:=kl1;
                        iii:=1;
                end;}
   ii:=1;
   iii:=0;
   if ((Visio_form.num_force>1)and(Visio_form.num_force<4)) then for k:=1 to (Visio_form.num_force-1) do ii:=ii+kt[k];
   if (Visio_form.num_force=4) then for k:=1 to 3 do iii:=iii+kt[k]
   else iii:=(ii+kt[Visio_form.num_force]-1);

   for i:=ii to  iii do
                begin
                        if plast.nom11[i]<=0 then
                        begin
                                flag_draw[i,1]:=0;
                                if plast.nom11[i]<0 then
                                begin
                                        flag_draw[i,1]:=-25;
                                end;
                        end
                        else
                        begin
                                flag_draw[i,1]:=25;
                        end;
                        if plast.nom22[i]<=0 then
                        begin
                                flag_draw[i,2]:=0;
                                if plast.nom22[i]<0 then
                                begin
                                        flag_draw[i,2]:=-25;
                                end;
                        end
                        else
                        begin
                                flag_draw[i,2]:=25;
                        end;
                end;

 {ii:=Visio_form.num_force;
 if ii>plast.kl1 then ii:=1;}
// for i:=1 to ii do // изменено в ферма 4
 ii:=1;
   iii:=0;
   if ((Visio_form.num_force>1)and(Visio_form.num_force<4)) then for k:=1 to (Visio_form.num_force-1) do ii:=ii+kt[k];
   if (Visio_form.num_force=4) then for k:=1 to 3 do iii:=iii+kt[k]
   else iii:=(ii+kt[Visio_form.num_force]-1);

                for i:=ii to iii do
                begin

                        if plast.kx1>=plast.ky1 then
                        begin
                                if (plast.nomm[i] mod plast.ky1)=0 then
                                begin
                                        x_int:=plast.nomm[i] div plast.ky1;
                                        x:=plast.xm1[(plast.nomm[i] div plast.ky1)];
                                end
                                else
                                begin
                                        x_int:=(plast.nomm[i] div plast.ky1)+1;
                                        x:=plast.xm1[(plast.nomm[i] div plast.ky1)+1];
                                end;
                                y:=plast.ym1[plast.nomm[i]-plast.ky1*(x_int-1)];
                        end
                        else
                        begin
                                if (plast.nomm[i] mod plast.kx1)=0 then
                                begin
                                        y_int:=plast.nomm[i] div plast.kx1;
                                        y:=plast.ym1[(plast.nomm[i] div plast.kx1)];
                                end
                                else
                                begin
                                        y_int:=(plast.nomm[i] div plast.kx1)+1;
                                        y:=plast.ym1[(plast.nomm[i] div plast.kx1)+1];
                                end;
                                x:=plast.xm1[plast.nomm[i]-plast.kx1*(y_int-1)];
                        end;
                        sh_x:=35;
                        if (plast.os[i]=11) or (plast.os[i]=33) then
                        begin
                                MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
                                MoveTo(sh_x+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)+5);
                                MoveTo(sh_x+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)-5);
                                Pen.color:=clRed; // Самойленко А.Е. 11.11.07
                                Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,sh_x+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
                        end;
                        if (plast.os[i]=22) or (plast.os[i]=33) then
                        begin
                                Pen.color:=clBlue;  // Самойленко А.Е. 11.11.07
                                MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
                                MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)+5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
                                MoveTo(sh_x+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
                                LineTo(sh_x+round(mas_x*x)-5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
                                Pen.color:=clRed;  // Самойленко А.Е. 11.11.07
                                Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,sh_x+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
                        end;
                        Pen.color:=clBlue;
                end;
                         // Выделение красным узлов, к которым приложены силы
                        // независимо от случая нагружения
                       // Самойленко А.Е. 15.12.07 НАЧАЛО
                       if Color_Rez_Btn.Down=true then
                         Pen.Color:=clBlue
                       else
                         Pen.Color:=clRed;
                       for i:=1 to kt[1]+kt[2]+kt[3] do
                       begin
                         if (plast.os[i]=11) or (plast.os[i]=22) or (plast.os[i]=33) then
                           begin
                           if plast.kx1>=plast.ky1 then
                             begin
                             if (plast.nomm[i] mod plast.ky1)=0 then
                               begin
                                 x_int:=plast.nomm[i] div plast.ky1;
                                 x:=plast.xm1[(plast.nomm[i] div plast.ky1)];
                               end
                             else
                               begin
                                 x_int:=(plast.nomm[i] div plast.ky1)+1;
                                 x:=plast.xm1[(plast.nomm[i] div plast.ky1)+1];
                               end;
                             y:=plast.ym1[plast.nomm[i]-plast.ky1*(x_int-1)];
                             end
                           else
                             begin
                             if (plast.nomm[i] mod plast.kx1)=0 then
                               begin
                                 y_int:=plast.nomm[i] div plast.kx1;
                                 y:=plast.ym1[(plast.nomm[i] div plast.kx1)];
                               end
                             else
                               begin
                                 y_int:=(plast.nomm[i] div plast.kx1)+1;
                                 y:=plast.ym1[(plast.nomm[i] div plast.kx1)+1];
                               end;
                               x:=plast.xm1[plast.nomm[i]-plast.kx1*(y_int-1)];
                             end;
                             Ellipse(sh_x+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,sh_x+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
                            end;
                       end;
                       Pen.color:=clBlue;
                       // Самойленко А.Е. 15.12.07 Конец
        end;
end;

procedure TVisio_Form.delall2_btnClick(Sender: TObject);
var
        m:ar1;
        fff,fff2:textfile;
        i,j,k,z:integer;
        s:string;
begin
        ukaz_btn.Down:=false;
        if ((set_value<>3) and (FileExists(extractfilename(ChangeFileExt(Fnn,'.ot1')))))then
        begin
                if FileExists(extractfilename(ChangeFileExt(Fnn,'.ot4'))) then DeleteFile(extractfilename(ChangeFileExt(Fnn,'.ot4')));
                assignFile (fff,(extractfilename(ChangeFileExt(Fnn,'.ot1'))));
                assignFile (fff2,(extractfilename(ChangeFileExt(Fnn,'.ot3'))));
                reset(fff);
                rewrite(fff2);
                readln(fff,s);
                writeln(fff2,s);
                for k:=1 to n_napr do
                begin

                        for i:=1 to 2 do for j:=1 to n_nagr*n_napr*n_otr do
                        begin
                                m2all[i,j].X:=0;
                                m2all[i,j].Y:=0;
                        end;
                        //формирование фрагмента для последующей вставки
                        for i:=1 to n_nagr do for j:=1 to n_otr do
                        begin
                                z:=m1[k,i,j];
                                if z<>0 then
                                begin
                                        m2all[1,z]:=m2[1,z];
                                        m2all[2,z]:=m2[2,z];
                                end;
                        end;

                        for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                        begin
                                readln(fff,s);
                                if k<>num_value then writeln(fff2,s)
                                else writeln(fff2,inttostr(m2all[i,j].x));
                                readln(fff,s);
                                if k<>num_value then writeln(fff2,s)
                                else writeln(fff2,inttostr(m2all[i,j].Y));
                        end;

                end;
                closeFile(fff);
                closeFile(fff2);
                DeleteFile(extractfilename(ChangeFileExt(Fnn,'.ot1')));
                RenameFile(extractfilename(ChangeFileExt(Fnn,'.ot3')),extractfilename(ChangeFileExt(Fnn,'.ot1')));
                all_btnClick(Self);
        end
        else if set_value=3 then
        begin
                if FileExists(extractfilename(ChangeFileExt(Fnn,'.ot4'))) then DeleteFile(extractfilename(ChangeFileExt(Fnn,'.ot4')));
                all2_btnClick(Self);
        end;


end;

procedure TVisio_Form.all2_btnClick(Sender: TObject);
var
        fff,fff2:textfile;
        i,j,k,p,o:integer;
        s:string;
begin
    if all2_btn.Down then
    begin
      eq_Napr_btn.Down:=false;
      X_Napr_Btn.Down:=false;
      Y_Napr_Btn.Down:=false;
      Kas_Napr_Btn.Down:=false;
      Main_Napr_Btn.Down:=false;
      if all_btn.Down then
      begin
        if not FileExists(extractfilename(ChangeFileExt(Fnn,'.ot4'))) then
        begin
                assignFile(fff2,extractfilename(ChangeFileExt(Fnn,'.ot4')));
                rewrite(fff2);
                //сливаем результаты всех расчетов из файла .ot1 в матрицу m2all2,
                //после чего заливаем m2all2 в файл .ot4 и выводим
                AssignFile(fff,ChangeFileExt(Fnn,'.ot1'));
                reset(fff);
                readln(fff,s); //имя файла
                writeln(fff2,s);
                for i:=1 to 2 do
                begin
                        for j:=1 to n_nagr*n_napr*n_otr do
                        begin
                                m2all2[i,j].X:=0;
                                m2all2[i,j].Y:=0;
                        end;
                end;

                for k:=1 to n_napr do
                begin
                o:=n_nagr*n_otr*(k-1);
                        for i:=1 to 2 do
                        begin
                        p:=1;
                                for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        readln(fff,s);
                                        if s<>'0' then
                                        begin
                                                m2all2[i,p+o].X:=StrToInt(s);
                                                readln(fff,s);
                                                m2all2[i,p+o].Y:=StrToInt(s);
                                                p:=p+1;
                                        end
                                        else readln(fff,s);
                                end;
                        end;
                end;
                //m2all2 -> .ot4

                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        writeln(fff2,m2all2[i,j].x);
                        writeln(fff2,m2all2[i,j].y);
                end;
                CloseFile(fff2);
                CloseFile(fff);
        end
        else
        // если файл .ot4 существует, считываем матрицу m2all2 и выводим
        begin
                assignFile(fff,extractfilename(ChangeFileExt(Fnn,'.ot4')));
                reset(fff);
                readln(fff); //имя файла
                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        readln(fff,s);
                        m2all2[i,j].x:=StrToInt(s);
                        readln(fff,s);
                        m2all2[i,j].y:=StrToInt(s);
                end;
                closeFile(fff);
        end;
      end
      else
      if show_btn.Down then
      begin
                old_value:=set_value;
                set_value:=3;
                show_btnClick(Self);
                set_value:=old_value;
      end;
      old_value:=set_value;
      set_value:=3;
      Visio_Form.Repaint;
      paintBox1Paint(Self);
    end
    else all2_btn.Down:=true;
end;

procedure TVisio_Form.show_btnClick(Sender: TObject);
var
        i,j,k,z,p:integer;
begin
        ukaz_btn.Down:=false;
        if show_btn.Down then
        begin
                if set_value<>3 then set_value:=1;
                draw_btn.Down:=false;
                del_btn.Down:=false;
                delall_btn.Down:=false;
                all_btn.Down:=false;
                draw_btn.Enabled:=false;
                del_btn.Enabled:=false;
                delall_btn.Enabled:=false;
                delall2_btn.Enabled:=false;
                opt_btn.Enabled:=false;
                all2_btn.Enabled:=true;
                all_ToolBar.Hide;
                ColorYNo.Hide;
                Save_btn.Hint:='Сохранение текущего изображения в файл .pwl';
                Napr_PaintBox.Visible:=false;
                Minus_Sbtn.Visible:=False;
                Plus_Sbtn.Visible:=False;
                Hinter.Hide;
                Hinter.Caption:='';
                if set_value<3 then
                begin
                        for k:=1 to n_napr do
                        begin
                                for i:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        m2all[1,i].X:=0;
                                        m2all[1,i].Y:=0;
                                        m2all[2,i].X:=0;
                                        m2all[2,i].Y:=0;
                                end;
                        end;
                        for i:=1 to n_nagr do for j:=1 to n_otr do
                        begin
                                z:=m1[num_value,i,j];
                                if z<>0 then
                                begin
                                        m2all[1,z]:=m2[1,z];
                                        m2all[2,z]:=m2[2,z];
                                end;
                        end;
                end
                else if set_value=3 then
                begin
                        p:=1;
                        for i:=1 to 2 do
                        begin
                                for j:=1 to n_nagr*n_napr*n_otr do
                                begin
                                        m2all2[i,j].X:=0;
                                        m2all2[i,j].Y:=0;
                                end;
                        end;
                        for k:=1 to n_napr do
                        begin
                                for i:=1 to n_nagr do
                                begin
                                        for j:=1 to n_otr do
                                        begin
                                                z:=m1[k,i,j];
                                                if z<>0 then
                                                begin
                                                        if not ((m2[1,z].X=0) and (m2[1,z].Y=0) and (m2[2,z].X=0) and (m2[2,z].Y=0)) then
                                                        begin
                                                                m2all2[1,p]:=m2[1,z];
                                                                m2all2[2,p]:=m2[2,z];
                                                                p:=p+1;
                                                        end;
                                                end;
                                        end;
                                end;
                        end;
                end;
        end
        else
        begin
                set_value:=0;
                Hinter.Hide;
                panel.Show;
                draw_btn.Enabled:=true;
                del_btn.Enabled:=true;
                delall_btn.Enabled:=true;
                all_btn.Enabled:=true;
                all2_btn.Enabled:=false;
                Napr_PaintBox.Visible:=True;
                Minus_Sbtn.Visible:=True;
                Plus_Sbtn.Visible:=True;
                all_ToolBar.Show;
                ColorYNo.Show;
                Save_btn.Hint:='Сохранение схем силовых линий';
        end;
        Visio_Form.Repaint;

end;
procedure TVisio_Form.N1Click(Sender: TObject);
var plast:Tplast;
h,w,th,tw:integer;
begin
Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
//plast.xm1[plast.kx1]>plast.ym1[plast.ky1];
    if ((plast.ym1[plast.ky1] < plast.xm1[plast.kx1])and(plast.xm1[plast.kx1]/plast.ym1[plast.ky1]>=1.75)) then w:=560
    else w:=440;

    if visio_Form.Caption = 'Деформация пластины' then
      begin
//    w:=440;

    if plast.ym1[plast.ky1]<plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*1.05);
    if plast.ym1[plast.ky1]>plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*0.68);
    if plast.ym1[plast.ky1]=plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*0.8);
      end
    else
         begin
//    w:=386;
   if plast.ym1[plast.ky1]<plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*1.05);
   if plast.ym1[plast.ky1]>plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*0.72);
   if plast.ym1[plast.ky1]=plast.xm1[plast.kx1] then h:=round(((plast.ym1[plast.ky1])/(plast.xm1[plast.kx1]))*w*0.85);

         end;
WindowState :=wsNormal;
ClientWidth :=w;
ClientHeight:=h;
end;


end.