unit FermOptNode;

interface

uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Menus, ExtCtrls, Ferm_Dat, FermaFixNode, StdCtrls , Buttons;

type
  TFerm_opt_node = class(TForm)
    GroupBox7: TGroupBox;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label2: TLabel;
    GroupBox5: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Edit9: TEdit;
    Button1: TButton;
    Button2: TButton;
    OptNodeEdt: TEdit;
    GroupBox6: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    ScrollBar1: TScrollBar;
    CheckBox2: TCheckBox;
    GroupBox3: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    Edit8: TEdit;
    Ok_Btn: TBitBtn;
    BitBtn1: TBitBtn;
//    procedure Button1Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Click11(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Ok_BtnClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox2Click1(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
//    ferma5_kol_uzlov:integer;// FERMA 5
    ferma5_kol_uzlov_m :array [1..10] of integer; // FERMA 5
    ferma_5_dannie_o_uzlax:array [1..10,1..5] of integer; // данные о каждом узле -  параметры оптимизации

    nyz1:integer;
    Ak_flag :boolean;
    check :boolean;
    Ak_num, Ak_Rad  :integer;

//     procedure Ok_BtnClick(Sender: TObject);
    //     function Execute1(var xh:integer):boolean;
  end;

var
  Ferm_opt_node: TFerm_opt_node;

implementation

uses Main, Fix_node, ForcNode, SimplRezFerm,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1, FermOptNode_Uzel, Ferma_M
  ;
{$R *.dfm}
{
procedure TFerm_opt_node.Button1Click(Sender: TObject);
var
xh,x:integer;
begin
Ferm_opt_node.Visible:=False;
Ferm_opt_node.Execute(xh);
//Ferma_M.Ferma_Form.N90Click(Sender);
end;
 }
procedure TFerm_opt_node.Edit3Change(Sender: TObject);
var
j,i,x,y:integer;
begin
x:=strtoint(combobox1.text);  // узел
y:=strtoint(edit3.text); // радиус поиска
 { with Ferma_M.Ferma_Form.PaintBox.Canvas do
                         begin
                              pen.Mode   :=pmNotXor;
                              pen.Width  :=2;
                              pen.Color  :=clBlue;
                              brush.Color:=clWhite;
                              pen.Mode   :=pmNotXor;
                             // Ellipse(x,y/2,+5,+5);
Ellipse(round(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[x,1]-round(y/2)), round(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[x,2]+y/2),round(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[x,1]+y/2),round(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[x,2]-y/2));
end;
  }

if y>200 then y:=200;
Ak_flag:=true;
Ak_num:=x;
Ak_Rad:=y;
FermOptNode.Ferm_opt_node.ScrollBar1.Position:=y;

  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента

ferma_5_dannie_o_uzlax[j,2]:=strtoint(edit3.Text); //радиус области поиска
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;


end;



procedure TFerm_opt_node.ScrollBar1Change(Sender: TObject);
var
Scale:integer;
 label exx1;
begin
 if edit9.text='0' then   // если нет узлов то нельзя ничего рисовать
 goto exx1;

Scale:=FermOptNode.Ferm_opt_node.ScrollBar1.Position;
edit3.Text:=IntToStr(scale);
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
exx1:
end;







procedure TFerm_opt_node.Button1Click(Sender: TObject);
var
  n_uzla:integer;
  ff: System.Text;
  filename:string;
  i,j:integer;
  NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
  NYZ:integer;                                       {ЧИCЛO УЗЛOB}
  rmin:real; //awtoradius
  r0,r1,r2,r3:integer;//awtoradius
  a,b,c,sina,cosa:real;//awtoradius
  s : TStrings; //список добавляемых узлов
  ss: string;
  k : integer;  //счетчик добавления узлов
  j1,i1:integer;
label m303;
begin

  Form4.Label1.Caption:='Введите номер одного или номера';
  Form4.Label2.Caption:='нескольких узлов через запятую';
  Form4.Edit1.Text:='';
  Form4.Left :=ferm_opt_node.left+30;
  Form4.top :=ferm_opt_node.top+175;

  //if Form4.ShowModal<>mrOk then goto m303; // если нажат ОК
  s := TStringlist.create; //создаем список
  s.Delimiter := ','; //указывает на разделитель между строками
  s.DelimitedText := OptNodeEdt.text;
  //s.DelimitedText := form4.Edit1.text ; //заполняем текстом с разделителем
  //j1:=strtoint(Ferm_opt_node.Edit9.Text); // всего сколько узлов ( минимум 1)
  //i1:=strtoint(form4.Edit1.text); // новый узел - проверим

  // считаем данные из файлика- тока до NYZ
  FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
  AssignFile(ff,FileName);
  reset(ff);
  readln(ff,nst);
  readln(ff,nyz);
  CloseFile(ff);
  // закончили

  for k:=0 to s.Count-1 do // вводим узлы
  begin
    try
      i1:=strtoint(s[k]); // новый узел - проверим // если введено не число - в исключение
    except // если очередной узел не число
      Main_Form.StatusBar1.Panels[2].Text :='Введено не число'; // сообщение
      continue; // переход к следующему числу
    end;
    i:=0; // признак ошибки
    j1:=strtoint(Ferm_opt_node.Edit9.Text); // всего сколько узлов ( минимум 1)

    if j1>4 then // условие // не более 5 узлов
      begin
      Main_Form.StatusBar1.Panels[2].Text :='Узлов нельзя больше 5 ! ';
      continue;
    end;

    if (i1 > nyz) or (i1 <= 0) then //условие на узлы
      begin
        Main_Form.StatusBar1.Panels[2].Text :='Неверный номер узла';
        continue;
      end;

   for j:=1 to j1 do
    begin
      if ferma5_kol_uzlov_m[j]=i1 then // ищем такой в массиве
      begin
        Main_Form.StatusBar1.Panels[2].Text :='Узел уже есть в списке ! ';
        i:=1; break;
      end;
    end;
    if i=1 then continue;


    // проверка  и разрешение оптимизации и вывод параметров
    begin
      Main_Form.StatusBar1.Panels[2].Text :=' ';
      Groupbox6.Visible:=true;
    end;
    // добавление  данных
    ferma5_kol_uzlov_m[j1+1]:=i1;
    Ferm_opt_node.Edit9.Text:=inttostr(j1+1);
    Ferm_opt_node.ComboBox1Click11(sender);// заполнение листbох
    // заполнение свойств данного узла
    ferma_5_dannie_o_uzlax[j1+1,1]:=strtoint(edit1.Text); // число дроблений шага
    ferma_5_dannie_o_uzlax[j1+1,2]:=strtoint(edit3.Text); //радиус области поиска

    if radiobutton1.Checked then
      ferma_5_dannie_o_uzlax[j1+1,3]:=1;// изменение координат (по Х)
    if radiobutton2.Checked  then
      ferma_5_dannie_o_uzlax[j1+1,3]:=2;// изменение координат (по Y)
    if radiobutton3.Checked  then
      ferma_5_dannie_o_uzlax[j1+1,3]:=3;// изменение координат (по ХY)

    if fermoptnode.Ferm_opt_node.CheckBox1.Checked=true then // вывод промежуточных данных
      ferma_5_dannie_o_uzlax[j1+1,4]:=1
    else
      ferma_5_dannie_o_uzlax[j1+1,4]:=0;

    if checkbox2.Checked=true then // вкл авторадиус
      ferma_5_dannie_o_uzlax[j1+1,5]:=1
    else
      ferma_5_dannie_o_uzlax[j1+1,5]:=0;

    ComboBox1.itemindex:=j1; // выбираем последний
    Ferm_opt_node.ComboBox1Change(Sender);// вывод кружка и номера узла

    // AWTORADIUS замена значения радиуса !

    if  checkbox2.Checked=true then Ferm_opt_node.CheckBox2Click1(Sender)  ;
    //***** end of  AwtoRadius ********************

  end;
  j:=ComboBox1.itemindex;
  OptNodeEdt.Text:='';
  ComboBox1.itemindex:=0;
  ss:=ComboBox1.Text;
  for i:=1 to StrToInt(Edit9.Text)-1 do
    begin
      ss:=Concat(ss,',');
      ComboBox1.itemindex:=i;
      ss:=Concat(ss,ComboBox1.Text);
    end;
  //OptNodeEdt.Text:=ss;
  ComboBox1.itemindex:=j;
  s.Destroy(); // освобождаем память, удаляем список

m303:
end;

procedure TFerm_opt_node.ComboBox1Click11(Sender: TObject);
var
j,i:integer;
begin
j:=strtoint(Ferm_opt_node.Edit9.Text); // всего сколько узлов ( минимум 1)
 Ferm_opt_node.ComboBox1.Items.Clear;

   for i:=1 to  j  do
//   Ferm_opt_node.ComboBox1.Items.Add(IntToStr(i));   // запихиваем при нажатии на листбох туда цифирки-  узлы
   Ferm_opt_node.ComboBox1.Items.Add(IntToStr(ferma5_kol_uzlov_m[i]));   // запихиваем при нажатии на листбох туда цифирки-  узлы


Ferm_opt_node.ComboBox1.itemindex:=0; // выбираем пеpвый


 ferma_FD_form.showD(f);
 Main_Form.ActiveMDIChild.RePaint;
end;




procedure TFerm_opt_node.ComboBox1Change(Sender: TObject);
var
i,j:integer;
label exx;
begin
// при выборе другого элемента грузятся ЕГО свойства заместо текущих

  j:=0;// поиск номера
if edit9.Text='0' then goto exx;

  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента



// запихиваем данные
 edit1.text:= inttostr( fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,1]); //максимальное количество шагов .
  edit3.text:=inttostr( fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,2]); //радиус области поиска


  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,3]=1   then
    fermoptnode.Ferm_opt_node.radiobutton1.Checked:=true;
  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,3]=2   then
    fermoptnode.Ferm_opt_node.radiobutton2.Checked:=true;
  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,3]=3   then
    fermoptnode.Ferm_opt_node.radiobutton3.Checked:=true;


  if   fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[j,4]=1 then // вывод промежуточных данных
  fermoptnode.Ferm_opt_node.CheckBox1.Checked:=true
  else
  fermoptnode.Ferm_opt_node.CheckBox1.Checked:=false;

  if   ferma_5_dannie_o_uzlax[j,5]=1 then  // вкл авторадиус
  checkbox2.checked:=true
  else
  checkbox2.checked:=false;

  //*************************************** zakoncili изменение дданных для нового узла
// перерисуем кружок
Edit3Change(Sender);
// номерок проставим в GroupBox
//groupbox6.caption:='Узел № '+ (ComboBox1.Text) ;



exx:
end;




procedure TFerm_opt_node.Button2Click(Sender: TObject);

var
n_uzla:integer;
ss: string;
i,j,j1,i1:integer;
 label m303;
begin
  Form4.Label1.Caption:='';
  Form4.Label2.Caption:='            Введите номер узла';
  //if Form4.ShowModal<>mrOk then goto m303; // если нажат ОК

  j1:=strtoint(Ferm_opt_node.Edit9.Text); // всего сколько узлов ( минимум 1)


 if j1<=0 then // проверка - если нет узлов
 begin
  Main_Form.StatusBar1.Panels[2].Text :='Нет ни одного узла ! ';
  goto m303;
 end;

 if j1=1 then // проверка - если удаляем ПОСЛЕДНИЙ УЗЕЛ
 begin
 Fermoptnode.Ferm_opt_node.Ok_Btn.modalresult:=mrCancel;
  Ak_flag:=false  ; // уберем кружок
   Main_Form.ActiveMDIChild.RePaint;

 Main_Form.StatusBar1.Panels[2].Text :='Удалены все узлы ! ';
 Groupbox6.Visible:=false;

 end;

 i1:=strtoint(OptNodeEdt.text); // новый узел - проверим

// **************
j:=1; // признак ошибки
for i:=1 to j1 do
begin
 if ferma5_kol_uzlov_m[i]=i1 then // ищем такой в массиве
  begin
  j:=0; // нашли - сняли ошибку
  n_uzla:=i; // запомним номер в массиве
  end;

end;
if j=1 then
 begin
 Main_Form.StatusBar1.Panels[2].Text :='Узел не найден в списке ! ';

 goto m303;
 end;


// удаление из массива оптимизируемых узлов указанного узла
for i:=n_uzla to j1-1 do
  ferma5_kol_uzlov_m[i]:=  ferma5_kol_uzlov_m[i+1];

// все заменили  - сдвинув массив влево на одну позицию с нужного места
  Ferm_opt_node.Edit9.Text:=inttostr(j1-1);


 // обработка массива с параметрами оптимизации
 // удаление из массива оптимизируемых узлов указанного узла
for i:=n_uzla to j1-1 do
 begin
  ferma_5_dannie_o_uzlax[i,1]:=ferma_5_dannie_o_uzlax[i+1,1];
  ferma_5_dannie_o_uzlax[i,2]:=ferma_5_dannie_o_uzlax[i+1,2];
  ferma_5_dannie_o_uzlax[i,3]:=ferma_5_dannie_o_uzlax[i+1,3];
  ferma_5_dannie_o_uzlax[i,4]:=ferma_5_dannie_o_uzlax[i+1,4];
  ferma_5_dannie_o_uzlax[i,5]:=ferma_5_dannie_o_uzlax[i+1,5];
 end;

  Ferm_opt_node.ComboBox1Click11(sender);// заполнение листбох
  Ferm_opt_node.ComboBox1Change(Sender);// вывод кружка и номера узла
  j:=ComboBox1.itemindex;
  OptNodeEdt.Text:='';
  ComboBox1.itemindex:=0;
  ss:=ComboBox1.Text;
  for i:=1 to StrToInt(Edit9.Text)-1 do
    begin
      ss:=Concat(ss,',');
      ComboBox1.itemindex:=i;
      ss:=Concat(ss,ComboBox1.Text);
    end;
  //OptNodeEdt.Text:=ss;
  ComboBox1.itemindex:=j;
 m303:
 end;

procedure TFerm_opt_node.Edit1Change(Sender: TObject);
var
i,j:integer;
begin

  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента


// заполнение свойств данного узла
  ferma_5_dannie_o_uzlax[j,1]:=strtoint(edit1.Text); // число дроблений шага

end;




procedure TFerm_opt_node.RadioButton3Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента

ferma_5_dannie_o_uzlax[j,3]:=3; //радиус области поиска

end;

procedure TFerm_opt_node.RadioButton1Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента

ferma_5_dannie_o_uzlax[j,3]:=1; //радиус области поиска
end;

procedure TFerm_opt_node.RadioButton2Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента

ferma_5_dannie_o_uzlax[j,3]:=2; //радиус области поиска
end;




procedure TFerm_opt_node.CheckBox1Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента


  if fermoptnode.Ferm_opt_node.CheckBox1.Checked=true then // вывод промежуточных данных
  ferma_5_dannie_o_uzlax[j,4]:=1
  else
  ferma_5_dannie_o_uzlax[j,4]:=0;

end;



procedure TFerm_opt_node.Ok_BtnClick(Sender: TObject);
var
i,j:integer;
label exxx;
begin

if edit9.text='0' then
 begin
  Main_Form.StatusBar1.Panels[2].Text :='Не введен ни один узел ! ';
  goto exxx;
 end
 else
  Fermoptnode.Ferm_opt_node.modalresult:=mrOk;


  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента


  ferma_5_dannie_o_uzlax[j,1]:=strtoint(edit1.Text); // число дроблений шага
  ferma_5_dannie_o_uzlax[j,2]:=strtoint(edit3.Text); //радиус области поиска

  if radiobutton1.Checked   then
  ferma_5_dannie_o_uzlax[j,3]:=1;// изменение координат (по Х)
  if radiobutton2.Checked then
  ferma_5_dannie_o_uzlax[j,3]:=2;// изменение координат (по Y)
  if radiobutton3.Checked  then
  ferma_5_dannie_o_uzlax[j,3]:=3;// изменение координат (по ХY)


  if fermoptnode.Ferm_opt_node.CheckBox1.Checked=true  then // вывод промежуточных данных
  ferma_5_dannie_o_uzlax[j,4]:=1
  else
  ferma_5_dannie_o_uzlax[j,4]:=0;

  if fermoptnode.Ferm_opt_node.CheckBox2.Checked=true  then // вывод промежуточных данных
  ferma_5_dannie_o_uzlax[j,5]:=1
  else
  ferma_5_dannie_o_uzlax[j,5]:=0;


exxx:
end;



procedure TFerm_opt_node.CheckBox2Click1(Sender: TObject);
var
 NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
 NYZ:integer;                                       {ЧИCЛO УЗЛOB}
rmin:real; //awtoradius
i1,r1,r2,r3:integer;//awtoradius
a,b,c,sina,cosa:real;//awtoradius
 // канец переменных
   label m111;
begin


// *******************************FERMA 6.1 **************
// Новый инструмент - АвтоРадиус
// автоматически производится расчет максимально допустимой величины "кружка" - путем анализа
// конструкции и вычисления миниимального расстояния от заданного узла до ближайшего узла/стержня.
// ******************************************************
// исходные данные - кол-во узлов, кол-во стержней, координаты всех узлов, номер оптимизируемого узла, стержни( пары узов их составляющих)
// i1- номер оптимизируемого узла
// выход- найденный радиус. rmin
//
//
{
  AssignFile(dd,ff1);.. *.frm
        rewrite(dd);

        READln (d1,NST); // число стрержней фермы
        READln (d1,NYZ); // число узлов
        READln (d1,NY);
        READln (d1,E);
        READln (d1,NSN);
        READln (d1,SD);
//      writeln(dd,'Массив топологий стержней');
        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
         end;

//      writeln(dd,'Массив координат узлов');
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);
          readln(d1,cor[i,2]);
         end;
}

// проверка всех пар узлов.
 i1:=strtoint(ComboBox1.text);
rmin:= abs (sqrt (sqr( Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) ; // расстояние ( по модулю ) от нашего узла до 1го узла
 if  rmin=0 then // если 1ый узел и есть то берем 2 - от балды
  rmin:= abs (sqrt (sqr( Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[2,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[2,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) ; // расстояние ( по модулю ) от нашего узла до 1го узла

//rmin:= abs (sqrt (sqr( cor[1,1]-cor[i1,1]) +  sqr(cor[1,2]-cor[i1,2]) )) ; // расстояние ( по модулю ) от нашего узла до 1го узла
for r1:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do

 begin
 if r1<>i1 then   // если это наш же узел то его не учитываем
 if abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) < rmin then // если расстояние меньше чем наш рмин то запомниаем его
  rmin:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) ));
 end;

//поиск среди узла и всех стержней ( рассматриваеm реугольники)
for  r3:=1  to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do

 begin

  r1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.ITOPn[r3,1];
  r2:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.ITOPn[r3,2];

  a:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]) )); // сторона напротив угла

  b:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]) ));

  c:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,2]) ));

 if (a<>0) and (b<>0) and (c<>0) then
 begin

  // a**2=b**2+c**2 - 2*b*c*cos

  cosa:=( sqr(b)+sqr(c)-sqr(a) )/(2*b*c)  ;
  if (1-sqr(cosa))<0 then goto m111 else sina:=sqrt( 1- sqr(cosa) );

  // sin/a=sin/b=sin/c  ==> sinB=sinA*b/a
   m111:
  // если угол тупой то искомая величина - высота
  if cosa <=0 then
     if      c*(sina*b/a) < rmin then      rmin:=c*(sina*b/a) // нашли ответ - если угол был тупой  . Но заменяем если только это значение меньше чем у нас запомнено.
//     rmin:=a*(sina*b/a) // нашли ответ - если угол был тупой
  else // иначе если острыйф смотрим
   begin
   // если хоть один из двух оставшихся углов - тупой - то ничего не делаем.  иначе опять таки высота
   if  not ( ( (( sqr(c)+sqr(a)-sqr(b) )/(2*a*c ))<0)  or (   (( sqr(a)+sqr(b)-sqr(c) )/(2*a*b) )<0 ))  then // хоть один угол был тупой - ребро
//    rmin:=c*(sina*b/a); // нашли ответ - если оба острые то высота
      if c*(sina*b/a)< rmin then  rmin:=c*(sina*b/a); // нашли ответ - если оба острые то высота

   end;


  end;
 end;


 edit3.Text:=inttostr(round(rmin-0.51));




end;





procedure TFerm_opt_node.CheckBox2Click(Sender: TObject);
var
 NST:integer;                                       {ЧИCЛO CTEPЖHEЙ ФEPMЫ}
 NYZ:integer;                                       {ЧИCЛO УЗЛOB}
rmin:real; //awtoradius
i1,r1,r2,r3:integer;//awtoradius
a,b,c,sina,cosa:real;//awtoradius
i,j:integer;
 // канец переменных

begin
  j:=0;// поиск номера
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // теперь j - номер нужного элемента

//*************************************
if  checkbox2.Checked=false then
 begin
 edit3.enabled:=true;
 scrollbar1.enabled:=true;
 ferma_5_dannie_o_uzlax[j,5]:=0;
 end
else
 begin
 Ferm_opt_node.CheckBox2Click1(sender);
 edit3.enabled:=false;
 scrollbar1.enabled:=false;
 ferma_5_dannie_o_uzlax[j,5]:=1;
 end;
end;


procedure TFerm_opt_node.BitBtn1Click(Sender: TObject);
begin
Ferm_opt_node.Close;
end;

procedure TFerm_opt_node.FormActivate(Sender: TObject);
begin
  if Main_Form.NodesNum.Checked then
  begin
    check := true
  end
  else
  begin
    check := false;
    Main_Form.NodesNum.Checked := True;
  end;
end;

procedure TFerm_opt_node.FormDeactivate(Sender: TObject);
begin
  if check then
    Main_Form.NodesNum.Checked := True
  else
    Main_Form.NodesNum.Checked := False;
end;

procedure TFerm_opt_node.FormDestroy(Sender: TObject);
begin
  if check then
    Main_Form.NodesNum.Checked := True
  else
    Main_Form.NodesNum.Checked := False;
end;

end.
