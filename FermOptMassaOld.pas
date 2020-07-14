unit FermOptMassa1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFerm_opt_massa = class(TForm)
    GroupBox1: TGroupBox;
    Ok_Btn: TBitBtn;
    GroupBox2: TGroupBox;
    MinS_Label: TLabel;
    fmi_Edt: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    maxkit_Edt: TEdit;
    ebsi_Edt: TEdit;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    ComboBox1: TComboBox;
    Edit9: TEdit;
    Button1: TButton;
    Button2: TButton;
    GroupBox6: TGroupBox;
    Label7: TLabel;
    Edit1: TEdit;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    GroupBox9: TGroupBox;
    Label8: TLabel;
    Edit8: TEdit;
    Edit3: TEdit;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ljambda_Edt: TEdit;
    Label11: TLabel;
    BitBtn1: TBitBtn;
    AvtoR: TCheckBox;



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
    procedure BitBtn1Click(Sender: TObject);
    procedure AvtoRClick(Sender: TObject);
    procedure AvtoRClick1(Sender: TObject);
    procedure Edit8Change(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }

    ferma5_kol_uzlov_m1 :array [1..10] of integer; // FERMA 5
    ferma_5_dannie_o_uzlax1:array [1..10,1..5] of integer; // ������ � ������ ���� -  ��������� �����������

    nyz1:integer;
//    Ak_flag :boolean;
//    Ak_num, Ak_Rad  :integer;
  end;

var
  Ferm_opt_massa: TFerm_opt_massa;
  // ������ // ����������� ��������
  Edit8_Wrong: integer;
  // ����� // ����������� ��������

implementation

uses Main, Fix_node, ForcNode, SimplRezFerm,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1, FermOptNode_Uzel, Ferma_M,
  fermoptnode;

{$R *.dfm}







procedure TFerm_opt_massa.Edit3Change(Sender: TObject);
var
j,i,x,y:integer;
begin
x:=strtoint(combobox1.text);  // ����
y:=strtoint(edit3.text); // ������ ������
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
Ferm_opt_node.Ak_flag:=true;
Ferm_opt_node.Ak_num:=x;
Ferm_opt_node.Ak_Rad:=y;
Fermoptmassa.Ferm_opt_massa.ScrollBar1.Position:=y;

  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������

// �� ���� ����� �������� ���� ���� ���� �����- � �� ����� ���������� ��� ������������ �����������
if Fermoptmassa.Ferm_opt_massa.Visible=true then
begin
ferma_5_dannie_o_uzlax1[j,2]:=strtoint(edit3.Text); //������ ������� ������
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
end;

end;



procedure TFerm_opt_massa.ScrollBar1Change(Sender: TObject);
var
Scale:integer;
 label exx1;
begin
 if edit9.text='0' then   // ���� ��� ����� �� ������ ������ ��������
 goto exx1;

Scale:=Fermoptmassa.Ferm_opt_massa.ScrollBar1.Position;
edit3.Text:=IntToStr(scale);
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
exx1:
end;




//������// ������� �.C. - ����� ���������, ��������� ������� ����� ���������
// �����, ����������� ������ � �������.
procedure TFerm_opt_massa.Button1Click(Sender: TObject);
var
  n_uzla:integer;

  ff: System.Text;
  filename:string;
  i,j:integer;
  NST:integer;                                       {��C�O CTEP�HE� �EPM�}
  NYZ:integer;                                       {��C�O ���OB}

  j1,i1:integer;
  s : TStrings; //������ ����������� �����
  k : integer;  //������� ���������� �����
label m303; // ����� ������ �� ���������
begin
  Form4.Edit1.Text:='';   //������� ����� ����� ����� ��� �����������
  Form4.Left :=ferm_opt_massa.left+40;
  Form4.top :=ferm_opt_massa.top+190;

  if Form4.ShowModal<>mrOk then goto m303; // ���� �� ����� ��, �� - �������

   s := TStringlist.create; //������� ������
   s.Delimiter := ';'; //��������� �� ����������� ����� ��������
   s.DelimitedText := form4.Edit1.text ; //��������� ������� � ������������

 // *************
 // ������� ������ �� �������- ���� �� NYZ
    FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
    AssignFile(ff,FileName);
    reset(ff);
    readln(ff,nst);
    readln(ff,nyz);
    CloseFile(ff);
// ���������

  for k:=0 to s.Count-1 do // ������ ����
  begin
    try
      i1:=strtoint(s[k]); // ����� ���� - �������� // ���� ������� �� ����� - � ����������
    except // ���� ��������� ���� �� �����
      Main_Form.StatusBar1.Panels[2].Text :='������� �� �����'; // ���������
      continue; // ������� � ���������� �����
    end;
    i:=0; // ������� ������
    j1:=strtoint(Ferm_opt_massa.Edit9.Text); // ����� ������� ����� ( ������� 1)

    if j1>4 then // ������� // �� ����� 5 �����
      begin
      Main_Form.StatusBar1.Panels[2].Text :='����� ������ ������ 5 ! ';
      continue;
    end;

    if (i1 > nyz) or (i1 <= 0) then //������� �� ����
      begin
        Main_Form.StatusBar1.Panels[2].Text :='�������� ����� ����';
        continue;
      end;

   for j:=1 to j1 do
    begin
      if ferma5_kol_uzlov_m1[j]=i1 then // ���� ����� � �������
      begin
        Main_Form.StatusBar1.Panels[2].Text :='���� ��� ���� � ������ ! ';
        i:=1; break;
      end;
    end;
    if i=1 then continue;

    ///********************
    // ��������  � ���������� ����������� � ����� ����������
    begin
    // Fermoptmassa.Ferm_opt_massa.modalresult:=mrOk;
      Main_Form.StatusBar1.Panels[2].Text :=' ';
      Groupbox6.Visible:=true;
    end;
    // ����������  ������
    ferma5_kol_uzlov_m1[j1+1]:=i1;
    Ferm_opt_massa.Edit9.Text:=inttostr(j1+1);
    Ferm_opt_massa.ComboBox1Click11(sender);// ���������� ����b��
    // ���������� ������� ������� ����
    ferma_5_dannie_o_uzlax1[j1+1,1]:=strtoint(edit1.Text); // ����� ��������� ����
    ferma_5_dannie_o_uzlax1[j1+1,2]:=strtoint(edit3.Text); //������ ������� ������

    if radiobutton1.Checked then
      ferma_5_dannie_o_uzlax1[j1+1,3]:=1;// ��������� ��������� (�� �)
    if radiobutton2.Checked  then
      ferma_5_dannie_o_uzlax1[j1+1,3]:=2;// ��������� ��������� (�� Y)
    if radiobutton3.Checked  then
      ferma_5_dannie_o_uzlax1[j1+1,3]:=3;// ��������� ��������� (�� �Y)

    if Fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true then // ����� ������������� ������
      ferma_5_dannie_o_uzlax1[j1+1,4]:=1
    else
      ferma_5_dannie_o_uzlax1[j1+1,4]:=0;

    if Fermoptmassa.Ferm_opt_massa.AvtoR.Checked=true then // ����� ������������� ������
      ferma_5_dannie_o_uzlax1[j1+1,5]:=1
    else
      ferma_5_dannie_o_uzlax1[j1+1,5]:=0;

    ComboBox1.itemindex:=j1; // �������� ���������
    Ferm_opt_node.Ak_flag:=true; // ���� ���������� ������ ��� ����������� ������� ��������� ����
    if  AvtoR.Checked=true then Ferm_opt_massa.AvtoRClick1(Sender)  ;
    Ferm_opt_massa.ComboBox1Change(Sender);// ����� ������ � ������ ����

  end;
    s.Destroy(); // ����������� ������, ������� ������
    m303:
    
end;
//�����// ������� �.�.




{procedure TFerm_opt_massa.Button1Click(Sender: TObject);
var
n_uzla:integer;
// ���� ��� ��� ��� ������ ��� ���� ���� �������� ��  ��������� NYZ - ���� � ����� ������� � ������ ����� �� ����������
 ff: System.Text;
 filename:string;
 i,j:integer;
 NST:integer;                                       //��C�O CTEP�HE� �EPM�
 NYZ:integer;                                       //��C�O ���OB
// ����� ����������

j1,i1:integer;
 label m303;
begin
Form4.Edit1.Text:='';
 Form4.Left :=ferm_opt_massa.left+40;
 Form4.top :=ferm_opt_massa.top+190;

  if Form4.ShowModal<>mrOk then
  begin
  goto m303;
  end;
  // ���� ����� ��



j1:=strtoint(Ferm_opt_massa.Edit9.Text); // ����� ������� ����� ( ������� 1)

 if j1>4 then
 begin
 Main_Form.StatusBar1.Panels[2].Text :='����� ������ ������ 5 ! ';
 goto m303;
 end;

 i1:=strtoint(form4.Edit1.text); // ����� ���� - ��������

// *************
 // ������� ������ �� �������- ���� �� NYZ
FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

    AssignFile(ff,FileName);
     reset(ff);
     readln(ff,nst);
     readln(ff,nyz);
     CloseFile(ff);
// ���������

i:=0; // priznak o6ibki
if form4.edit1.text='' then form4.edit1.text:='0';

if i1 <= 0 then
 begin
 form4.edit1.text:='1';
 i:=1;// ���� ������
 Main_Form.StatusBar1.Panels[2].Text :='�������� ����� ����';
 end;

if i1 > nyz then
 begin
 Main_Form.StatusBar1.Panels[2].Text :='�������� ����� ����';

 i:=1;
 end;

 if i=0 then Main_Form.StatusBar1.Panels[2].Text :=' ' //���� �� ���� ������
 else
 goto m303;
// **************



for i:=1 to j1 do
begin
 if ferma5_kol_uzlov_m1[i]=i1 then // ���� ����� � �������
  begin
  Main_Form.StatusBar1.Panels[2].Text :='���� ��� ���� � ������ ! ';
  goto m303;
  end;

end;
///********************



// ��������  � ���������� ����������� � ����� ����������
 begin
// Fermoptmassa.Ferm_opt_massa.modalresult:=mrOk;
 Main_Form.StatusBar1.Panels[2].Text :=' ';
 Groupbox6.Visible:=true;


 end;



// ������ ���� ����������  ������
  ferma5_kol_uzlov_m1[j1+1]:=i1;
  Ferm_opt_massa.Edit9.Text:=inttostr(j1+1);
  Ferm_opt_massa.ComboBox1Click11(sender);// ���������� �������
// ���������� ������� ������� ����
  ferma_5_dannie_o_uzlax1[j1+1,1]:=strtoint(edit1.Text); // ����� ��������� ����
  ferma_5_dannie_o_uzlax1[j1+1,2]:=strtoint(edit3.Text); //������ ������� ������

  if radiobutton1.Checked then
  ferma_5_dannie_o_uzlax1[j1+1,3]:=1;// ��������� ��������� (�� �)
  if radiobutton2.Checked  then
  ferma_5_dannie_o_uzlax1[j1+1,3]:=2;// ��������� ��������� (�� Y)
  if radiobutton3.Checked  then
  ferma_5_dannie_o_uzlax1[j1+1,3]:=3;// ��������� ��������� (�� �Y)


  if Fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true then // ����� ������������� ������
  ferma_5_dannie_o_uzlax1[j1+1,4]:=1
  else
  ferma_5_dannie_o_uzlax1[j1+1,4]:=0;

  if Fermoptmassa.Ferm_opt_massa.AvtoR.Checked=true then // ����� ������������� ������
  ferma_5_dannie_o_uzlax1[j1+1,5]:=1
  else
  ferma_5_dannie_o_uzlax1[j1+1,5]:=0;

ComboBox1.itemindex:=j1; // �������� ���������



  Ferm_opt_node.Ak_flag:=true; // ���� ���������� ������ ��� ����������� ������� ��������� ����

  if  AvtoR.Checked=true then Ferm_opt_massa.AvtoRClick1(Sender)  ;

  Ferm_opt_massa.ComboBox1Change(Sender);// ����� ������ � ������ ����




m303:
end; }

procedure TFerm_opt_massa.ComboBox1Click11(Sender: TObject);
var
j,i:integer;
begin
j:=strtoint(Ferm_opt_massa.Edit9.Text); // ����� ������� ����� ( ������� 1)
 Ferm_opt_massa.ComboBox1.Items.Clear;

   for i:=1 to  j  do
//   Ferm_opt_massa.ComboBox1.Items.Add(IntToStr(i));   // ���������� ��� ������� �� ������� ���� �������-  ����
   Ferm_opt_massa.ComboBox1.Items.Add(IntToStr(ferma5_kol_uzlov_m1[i]));   // ���������� ��� ������� �� ������� ���� �������-  ����


Ferm_opt_massa.ComboBox1.itemindex:=0; // �������� ��p���


 ferma_FD_form.showD(f);
 Main_Form.ActiveMDIChild.RePaint;
end;




procedure TFerm_opt_massa.ComboBox1Change(Sender: TObject);
var
i,j:integer;
label exx;
begin
// ��� ������ ������� �������� �������� ��� �������� ������� �������

  j:=0;// ����� ������
if edit9.Text='0' then goto exx;

  for i:=1 to strtoint(Edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������


// ���������� ������
 edit1.text:= inttostr( fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,1]); //������������ ���������� ����� .
  edit3.text:=inttostr( fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,2]); //������ ������� ������


  if fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]=1   then
    fermoptmassa.Ferm_opt_massa.radiobutton1.Checked:=true;
  if fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]=2   then
    fermoptmassa.Ferm_opt_massa.radiobutton2.Checked:=true;
  if fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]=3   then
    fermoptmassa.Ferm_opt_massa.radiobutton3.Checked:=true;


  if   fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,4]=1 then // ����� ������������� ������
  fermoptmassa.Ferm_opt_massa.CheckBox1.Checked:=true
  else
  fermoptmassa.Ferm_opt_massa.CheckBox1.Checked:=false;

 

  if   ferma_5_dannie_o_uzlax1[j,5]=1 then  // ��� ����������
  Avtor.checked:=true
  else
  Avtor.checked:=false;

  //*************************************** zakoncili ��������� ������� ��� ������ ����
// ���������� ������
Edit3Change(Sender);
// ������� ��������� � GroupBox
groupbox6.caption:='���� � '+ (ComboBox1.Text) ;



exx:
end;







procedure TFerm_opt_massa.Button2Click(Sender: TObject);

var
n_uzla:integer;

i,j,j1,i1:integer;
 label m303;
begin

  if Form4.ShowModal<>mrOk then
  begin
  goto m303;
  end;
  // ���� ����� ��
  
    j1:=strtoint(Ferm_opt_massa.Edit9.Text); // ����� ������� ����� ( ������� 1)


 if j1<=0 then // �������� - ���� ��� �����
 begin
  Main_Form.StatusBar1.Panels[2].Text :='��� �� ������ ���� ! ';
  goto m303;
 end;

 if j1=1 then // �������� - ���� ������� ��������� ����
 begin
 Fermoptmassa.Ferm_opt_massa.Ok_Btn.modalresult:=mrCancel;
  Ferm_opt_node.Ak_flag:=false  ; // ������ ������
   Main_Form.ActiveMDIChild.RePaint;

 Main_Form.StatusBar1.Panels[2].Text :='������� ��� ���� ! ';
 Groupbox6.Visible:=false;






 end;

 i1:=strtoint(form4.Edit1.text); // ����� ���� - ��������

// **************
j:=1; // ������� ������
for i:=1 to j1 do
begin
 if ferma5_kol_uzlov_m1[i]=i1 then // ���� ����� � �������
  begin
  j:=0; // ����� - ����� ������
  n_uzla:=i; // �������� ����� � �������
  end;

end;
if j=1 then
 begin
 Main_Form.StatusBar1.Panels[2].Text :='���� �� ������ ����� ��������� ! ';

 goto m303;
 end;


// �������� �� ������� �������������� ����� ���������� ����
for i:=n_uzla to j1-1 do
  ferma5_kol_uzlov_m1[i]:=  ferma5_kol_uzlov_m1[i+1];

// ��� ��������  - ������� ������ ����� �� ���� ������� � ������� �����
  Ferm_opt_massa.Edit9.Text:=inttostr(j1-1);


 // ��������� ������� � ����������� �����������
 // �������� �� ������� �������������� ����� ���������� ����
for i:=n_uzla to j1-1 do
 begin
  ferma_5_dannie_o_uzlax1[i,1]:=ferma_5_dannie_o_uzlax1[i+1,1];
  ferma_5_dannie_o_uzlax1[i,2]:=ferma_5_dannie_o_uzlax1[i+1,2];
  ferma_5_dannie_o_uzlax1[i,3]:=ferma_5_dannie_o_uzlax1[i+1,3];
  ferma_5_dannie_o_uzlax1[i,4]:=ferma_5_dannie_o_uzlax1[i+1,4];
 end;

   Ferm_opt_massa.ComboBox1Click11(sender);// ���������� �������
   Ferm_opt_massa.ComboBox1Change(Sender);// ����� ������ � ������ ����

m303:


end;

procedure TFerm_opt_massa.Edit1Change(Sender: TObject);
var
i,j:integer;
begin

  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������


// ���������� ������� ������� ����

// �� ���� ����� �������� ���� ���� ���� �����- � �� ����� ���������� ��� ������������ �����������
if Fermoptmassa.Ferm_opt_massa.Visible=true then
  ferma_5_dannie_o_uzlax1[j,1]:=strtoint(edit1.Text); // ����� ��������� ����





end;

procedure TFerm_opt_massa.RadioButton3Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������

if Fermoptmassa.Ferm_opt_massa.Visible=true then
          Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]:=3; //������ ������� ������


end;

procedure TFerm_opt_massa.RadioButton1Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������
if Fermoptmassa.Ferm_opt_massa.Visible=true then
            Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]:=1; //������ ������� ������

end;

procedure TFerm_opt_massa.RadioButton2Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������

if Fermoptmassa.Ferm_opt_massa.Visible=true then
 Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[j,3]:=2; //������ ������� ������
end;

procedure TFerm_opt_massa.CheckBox1Click(Sender: TObject);
var
i,j:integer;
begin
  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������

 // �� ���� ����� �������� ���� ���� ���� �����- � �� ����� ���������� ��� ������������ �����������
 if Fermoptmassa.Ferm_opt_massa.Visible=true then

   if Fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true then // ����� ������������� ������
    ferma_5_dannie_o_uzlax1[j,4]:=1
   else
    ferma_5_dannie_o_uzlax1[j,4]:=0;

end;

procedure TFerm_opt_massa.Ok_BtnClick(Sender: TObject);
var
i,j:integer;
label exxx;
begin

if  Fermoptmassa.Ferm_opt_massa.edit9.text=inttostr(0) then
 begin
  Main_Form.StatusBar1.Panels[2].Text :='�� ������ �� ���� ���� ! ';
  Fermoptmassa.Ferm_opt_massa.modalresult:=mrCancel;
  goto exxx;
 end
 else
  Fermoptmassa.Ferm_opt_massa.modalresult:=mrOk;


  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������


  ferma_5_dannie_o_uzlax1[j,1]:=strtoint(edit1.Text); // ����� ��������� ����
  ferma_5_dannie_o_uzlax1[j,2]:=strtoint(edit3.Text); //������ ������� ������

  if radiobutton1.Checked   then
  ferma_5_dannie_o_uzlax1[j,3]:=1;// ��������� ��������� (�� �)
  if radiobutton2.Checked then
  ferma_5_dannie_o_uzlax1[j,3]:=2;// ��������� ��������� (�� Y)
  if radiobutton3.Checked  then
  ferma_5_dannie_o_uzlax1[j,3]:=3;// ��������� ��������� (�� �Y)


  if fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true  then // ����� ������������� ������
  ferma_5_dannie_o_uzlax1[j,4]:=1
  else
  ferma_5_dannie_o_uzlax1[j,4]:=0;

  
exxx:
end;








procedure TFerm_opt_massa.BitBtn1Click(Sender: TObject);
begin
Ferm_opt_massa.Close;
end;

procedure TFerm_opt_massa.AvtoRClick(Sender: TObject);
var
 NST:integer;                                       {��C�O CTEP�HE� �EPM�}
 NYZ:integer;                                       {��C�O ���OB}
rmin:real; //awtoradius
i1,r1,r2,r3:integer;//awtoradius
a,b,c,sina,cosa:real;//awtoradius
i,j:integer;
 // ����� ����������

begin
  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m1[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    
    end;
  end;
  // ������ j - ����� ������� ��������

//*************************************
if  AvtoR.Checked=false then
 begin
 edit3.enabled:=true;
 scrollbar1.enabled:=true;
 ferma_5_dannie_o_uzlax1[j,5]:=0;
 end
else
 begin
 Ferm_opt_massa.AvtoRClick1(sender);
 edit3.enabled:=false;
 scrollbar1.enabled:=false;
 ferma_5_dannie_o_uzlax1[j,5]:=1;
 end;
end;


procedure TFerm_opt_massa.AvtoRClick1(Sender: TObject);
var
 NST:integer;                                       {��C�O CTEP�HE� �EPM�}
 NYZ:integer;                                       {��C�O ���OB}
rmin:real; //awtoradius
i1,r1,r2,r3:integer;//awtoradius
a,b,c,sina,cosa:real;//awtoradius
 // ����� ����������

begin


// *******************************FERMA 6.1 **************
// ����� ���������� - ����������
// ������������� ������������ ������ ����������� ���������� �������� "������" - ����� �������
// ����������� � ���������� ������������� ���������� �� ��������� ���� �� ���������� ����/�������.
// ******************************************************
// �������� ������ - ���-�� �����, ���-�� ��������, ���������� ���� �����, ����� ��������������� ����, �������( ���� ���� �� ������������)
// i1- ����� ��������������� ����
// �����- ��������� ������. rmin
//
//
{
  AssignFile(dd,ff1);.. *.frm
        rewrite(dd);

        READln (d1,NST); // ����� ��������� �����
        READln (d1,NYZ); // ����� �����
        READln (d1,NY);
        READln (d1,E);
        READln (d1,NSN);
        READln (d1,SD);
//      writeln(dd,'������ ��������� ��������');
        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
         end;

//      writeln(dd,'������ ��������� �����');
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);
          readln(d1,cor[i,2]);
         end;
}

// �������� ���� ��� �����.
 i1:=strtoint(ComboBox1.text);
rmin:= abs (sqrt (sqr( Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) ; // ���������� ( �� ������ ) �� ������ ���� �� 1�� ����
 if  rmin=0 then // ���� 1�� ���� � ���� �� ����� 2 - �� �����
  rmin:= abs (sqrt (sqr( Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[2,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[2,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) ; // ���������� ( �� ������ ) �� ������ ���� �� 1�� ����

//rmin:= abs (sqrt (sqr( cor[1,1]-cor[i1,1]) +  sqr(cor[1,2]-cor[i1,2]) )) ; // ���������� ( �� ������ ) �� ������ ���� �� 1�� ����
for r1:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do

 begin
 if r1<>i1 then   // ���� ��� ��� �� ���� �� ��� �� ���������
 if abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) )) < rmin then // ���� ���������� ������ ��� ��� ���� �� ���������� ���
  rmin:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]-Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]) ));
 end;

//����� ����� ���� � ���� �������� ( ������������m �����������)
for  r3:=1  to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1 do

 begin

  r1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.ITOPn[r3,1];
  r2:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.ITOPn[r3,2];

  a:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]) )); // ������� �������� ����

  b:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r1,2]) ));

  c:=abs (sqrt (sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,1]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,1]) +  sqr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i1,2]-  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[r2,2]) ));

 if (a<>0) and (b<>0) and (c<>0) then
 begin

  // a**2=b**2+c**2 - 2*b*c*cos

  cosa:=( sqr(b)+sqr(c)-sqr(a) )/(2*b*c)  ;
  sina:=sqrt( 1- sqr(cosa) );

  // sin/a=sin/b=sin/c  ==> sinB=sinA*b/a

  // ���� ���� ����� �� ������� �������� - ������
  if cosa <=0 then
     if      c*(sina*b/a) < rmin then      rmin:=c*(sina*b/a) // ����� ����� - ���� ���� ��� �����  . �� �������� ���� ������ ��� �������� ������ ��� � ��� ���������.
//     rmin:=a*(sina*b/a) // ����� ����� - ���� ���� ��� �����
  else // ����� ���� ������� �������
   begin
   // ���� ���� ���� �� ���� ���������� ����� - ����� - �� ������ �� ������.  ����� ����� ���� ������
   if  not ( ( (( sqr(c)+sqr(a)-sqr(b) )/(2*a*c ))<0)  or (   (( sqr(a)+sqr(b)-sqr(c) )/(2*a*b) )<0 ))  then // ���� ���� ���� ��� ����� - �����
//    rmin:=c*(sina*b/a); // ����� ����� - ���� ��� ������ �� ������
      if c*(sina*b/a)< rmin then  rmin:=c*(sina*b/a); // ����� ����� - ���� ��� ������ �� ������

   end;


  end;
 end;


 edit3.Text:=inttostr(round(rmin-0.51));




end;





procedure TFerm_opt_massa.Edit8Change(Sender: TObject);
begin
  // ������ // ����������� ��������

try
if strtoint(Edit8.text)<1 then
 begin
    Main_Form.StatusBar1.Panels[2].Text :='�������� ����� �������� �� �����';
    Edit8_Wrong :=1; Edit8.text:='4';
  end
else
  if Edit8_Wrong <> 1 then
    Main_Form.StatusBar1.Panels[2].Text :=''
  else
    Edit8_Wrong := 0;
except
    Main_Form.StatusBar1.Panels[2].Text :='�������� ����� �������� �� �����';
    Edit8_Wrong :=1; Edit8.text:='4'; 
end;


// ����� // ����������� ��������
end;

end.



























































// ������ �������
{
procedure TFerm_opt_massa.Edit3Change(Sender: TObject);
var
j,i,x,y:integer;
n_uzla:integer;
// ���� ��� ��� ��� ������ ��� ���� ���� �������� ��  ��������� NYZ - ���� � ����� ������� � ������ ����� �� ����������
 ff: System.Text;
 filename:string;

 NST:integer;
 NYZ:integer;
// ����� ����������

{
j1,i1:integer;
 label ex;
begin
x:=strtoint(edit1.text);  // ����
y:=strtoint(edit3.text); // ������ ������


FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

    AssignFile(ff,FileName);
     reset(ff);
     readln(ff,nst);
     readln(ff,nyz); // ����� �����
     CloseFile(ff);
// ���������

if (x<0) or (x >nyz)then
begin
FermOptNode.Ferm_opt_node.Ak_flag:=false; // ���� ���������� ������ ��� ����������� ������� ��������� ����
  goto ex;
  end;


if y>200 then y:=200;
if y<0 then y:=0;

ScrollBar1.Position:=y;
FermOptNode.Ferm_opt_node.Ak_flag:=true; // ���� ���������� ������ ��� ����������� ������� ��������� ����
FermOptNode.Ferm_opt_node.Ak_num:=x; // ����� ����
FermOptNode.Ferm_opt_node.Ak_Rad:=y; // ������
{
Ak_flag:=true;
Ak_num:=x;
Ak_Rad:=y;

FermOptNode.Ferm_opt_node.ScrollBar1.Position:=y;

  j:=0;// ����� ������
  for i:=1 to strtoint(edit9.Text) do
  begin
   if ferma5_kol_uzlov_m[i]=strtoint(ComboBox1.Text) then
    begin
    j:=i;
    end;
  end;
  // ������ j - ����� ������� ��������


ferma_5_dannie_o_uzlax[j,2]:=strtoint(edit3.Text); //������ ������� ������}
{
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
 Main_Form.ActiveMDIChild.RePaint;


ex:
end;

procedure TFerm_opt_massa.Edit1Change(Sender: TObject);
begin
Edit3Change(sender);
end;






procedure TFerm_opt_massa.ScrollBar1Change(Sender: TObject);
var
Scale:integer;
// label exx1;
begin
// if edit9.text='0' then   // ���� ��� ����� �� ������ ������ ��������
// goto exx1;

Scale:=ScrollBar1.Position;
edit3.Text:=IntToStr(scale);
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;

    end;

}





