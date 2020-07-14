unit Plast_M;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Ferm_Dat, StdCtrls , Math, OleServer, WordXP, Variants, Clipbrd,
  ShellAPI, Word2000;



type
 TPlast_Form = class(TForm)
    PaintBox: TPaintBox;
    Bevel1: TBevel;
    Plast_PopUp: TPopupMenu;
    ForceNode_PMnu: TMenuItem;
    FixNode_PMnu: TMenuItem;
    FixAxes_PMnu: TMenuItem;
    SaveDialog: TSaveDialog;
    Razm: TLabel;
    WordApplication1: TWordApplication;
    Real_Coord_PUM: TPopupMenu;
    real_size: TMenuItem;
    N8: TMenuItem;
    MenuItem1: TMenuItem;
    N10: TMenuItem;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure OptResults_MnuClick(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FixNode_PMnuClick(Sender: TObject);
    procedure ForceNode_PMnuClick(Sender: TObject);
    procedure FileSave_MnuClick(Sender: TObject);
    procedure FileSaveAs_MnuClick(Sender: TObject);
    procedure SimpleSolve_MnuClick(Sender: TObject);
    procedure SolveOpt_MnuClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure s_text_mnuClick(Sender: TObject);
    procedure o_text_mnuClick(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure SimpleResults_MnuClick(Sender: TObject);
    procedure Real_Coord_PUMPopup(Sender: TObject);
    procedure real_sizeClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure deleteNode(node,ng:integer);
    procedure MouseLeft;
    procedure MouseIsDown(MX,MY: Integer);
    procedure MouseIsMove(MX,MY: Integer);
    procedure MouseIsUp(MX,MY: Integer);
    procedure SelectionMode(Activate: Boolean);
    procedure N10Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);

    procedure PrepareForModule;
    procedure PutToAccount;

    procedure CopyDirectoryTree(AHandle: HWND;
 const AFromDirectory, AToDirectory: string);
    procedure MenuItem1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);


   //��������� �������� �����
  private
    { Private declarations }

   pMouseX1,pMouseY1,pMouseX2,pMouseY2: Integer;
           pMDown: Boolean;
           pSelection: Boolean;
           pSelectionIsOK: Boolean;
           pSelectionIsCopied: Boolean;
           pControlsArray: array of boolean;
           pFormBMP: TBitmap;
           pBStyle: TFormBorderStyle;
           pBIcons: TBorderIcons;
           pFSize: array [0..1] of Integer;
           pASize: Boolean;

           procedure WM_HotKeyHandler (var Message: TMessage);
           message WM_HOTKEY;
  public

    { Public declarations }
    Plast:TPlast;
    FileName,rez_name:string; // ��� ����� � �������
    CurrentNode:integer;     // ����, �� ������� �������� ��������� ���
    isChanged:boolean;
    isNamed:boolean;
    SaveCancel:boolean;       // �������� �� �� ���������� ?
    CW,CH: integer;
    Other_MDopNapr,Other_MModUpr,Other_MKoefPuass:extended;    // ���������� ��� �������� ������������(����������) ���������
    Xold,yold:integer;  //������ ���������� ��������������� �����
    razbit:boolean; //=true, ���� �������� ������ ��� ���������
    zagr:boolean;   //=true, ���� ������ �� �������� �������� � ������
    nz: integer;    // ����� ������ ���������� ��� �����������
    ng :integer;    // ����� ������ ����������
    Nagruz: array [1..3,1..3,1..4] of integer;// ����� ����� �������� ��� ����������� �����.[������ ����,����� ���� � ������ ,���-�� ��������]
    kt: array[1..3] of integer;               //���-�� ����������� ����� � ������ ������
    kl: integer;                              //���-�� ������� ����������
    old1,old2:integer; //������ �������� ���� ��� ��������� �����
    {�������� ���������}
     cutX1_x, cutX2_x,
     cutY1_x, cutY2_x:integer;
     cutX1_y, cutX2_y,
     cutY1_y, cutY2_y:integer;
     cutIdent:string;
    procedure deleteVar(ngr:integer);     //��������� �������� ������ ���������� �� ����� ��� �������
    procedure LoadData;                   // �������� ������ �� ����� � ��������� �������
    procedure SaveData;                   //���������� ������ � �����
    procedure initialize;                 //������������� �������� ������� �� Nagruz
    constructor NewFile(Owner:TComponent;P:TPlast);
    constructor OpenFile(Owner:TComponent;Fn:string);

    procedure force_draw_for_plast(x_max,y_max:integer;mas_x,mas_y:single);
    procedure bound_draw_for_plast(x_max,y_max:integer;mas_x,mas_y:single);
  end;


 const
      coord_axis_x=30;
      coord_axis_y=15;

var
  Plast_Form: TPlast_Form;


implementation

uses Main, Visio, Fix_node, ForcNode, PlastOptParam, Plast_FD, plast_rez, FermaFixNode, Ferma_FD, TOK_FD,
  FilesList;

{$R *.DFM}
procedure TPlast_Form.WM_HotKeyHandler (var Message: TMessage);
  var
    idHotKey: integer; //�������������, �� �� ���� - �����
    fuModifiers: word; //����������� MOD_XX
    uVirtKey: word; //��� ����������� ������� VK_XX
begin
  // ��������� ��������� �������� ���:
  idHotkey:= Message.wParam;
  fuModifiers:= LOWORD(Message.lParam);
  uVirtKey:= HIWORD(Message.lParam);
  //������ - ��������� ����������:
  if (fuModifiers = MOD_CONTROL) AND (uVirtKey = $53) then
  FileSaveAs_MnuClick(Self);
  inherited;
end;

constructor TPlast_Form.NewFile(Owner:TComponent;P:TPlast);
var i,j,k:integer;
begin
  Create(Owner);
  Plast:=P;

    p.kx1:=2;
    p.ky1:=2;
    p.kl1:=0;
    p.kz1:=0;
    p.xm1[p.kx1]:=200;
    p.ym1[p.ky1]:=200;
    p.ton1:=1;
    p.e1[1]:=7000000;
    p.e1[2]:=0.34;
    p.dop1:=30000;
    p.s_lin:='��';
    p.s_for:='�';

  FileName:='noname'+IntToStr(Main_Form.Num_Nonamed_Plast)+'.dnp';
  Main_Form.Num_Nonamed_Plast:=Main_Form.Num_Nonamed_Plast+1;

  Caption:=ExtractFileName(FileName);

  main_form.P2.Enabled:=false;
  main_form.P3.Enabled:=false;
  main_form.P5.Enabled:=false;
  main_form.P6.Enabled:=false;
  FormActivate(Self);
  isChanged:=true;
  isNamed:=false;
  kl:=0;
  for i:= 1 to 3 do Kt[i]:=0;            // ��������� ���� ���������� � �����������
  for i:= 1 to 3 do                      //
  for j:=1 to 3 do                       //
  for k:=1 to 4 do                       //
  nagruz[i,j,k]:=0;                      //
  end;

constructor TPlast_Form.OpenFile(Owner:TComponent;Fn:string);
var i,j,k:integer;
begin
  for i:= 1 to 3 do Kt[i]:=0;            // ��������� ���� ���������� � �����������
  for i:= 1 to 3 do                      //
  for j:=1 to 3 do                       //
  for k:=1 to 4 do                       //
  nagruz[i,j,k]:=0;isNamed:=true;
  Create(Owner);
  Plast:=TPlast.Create;
  FileName:=Fn;
  LoadData;
     if plast.kl1=0 then begin
  Main_Form.Sn_Cbx.clear;
  Main_Form.Sn_Cbx.Items.Add('������ ���������� 1');
  Main_Form.Sn_Cbx.ItemIndex:=0;
  end;
 if plast.kl1<=0 then begin main_form.Sn_cbx.Enabled:=false; end
 else  begin main_form.Sn_cbx.Enabled:=true; end;

  Caption:=ExtractFileName(FileName);
 // Tag:=1;            // ������ ����������
//my insert
  if not FileExists(ChangeFileExt(FileName,'.vrp')) then
  begin
  main_form.P2.Enabled:=false;
  main_form.P3.Enabled:=false;
  end
  else begin
  main_form.P5.Enabled:=true;
  main_form.P6.Enabled:=true;
  end;
  if not FileExists(ChangeFileExt(FileName,'.vop')) then
  begin
  main_form.P5.Enabled:=false;
  main_form.P6.Enabled:=false;
  end
  else begin
  main_form.P5.Enabled:=true;
  main_form.P6.Enabled:=true;
  end;
//end of my insert
  FormActivate(Self);
  isChanged:=false;
  end;
procedure TPlast_form.initialize();
var i,j,k:integer;
begin
plast.kl1:=kl;
k:=0;
for j:=1 to kl do
for i:=1 to kt[j] do
    begin
    k:=k+1;
    plast.nomm[k]:= nagruz[j,i,1];
    plast.os[k]:=nagruz[j,i,2];
    plast.nom11[k]:=nagruz[j,i,3];
    plast.nom22[k]:=nagruz[j,i,4];
end;
end;

procedure TPlast_Form.deleteVar(ngr:integer);
var i,j,k,t:integer;
 begin
   if (kl=0) then exit;
   t:=1;
   j:=ngr;
   while(t<=3-j) do
   begin
     for k:=1 to 4 do
       for i:=1 to max(kt[j-1+t],kt[j+t]) do
       begin
         nagruz[j-1+t,i,k]:=nagruz[j+t,i,k];
         nagruz[j+t,i,k]:=0;
       end;
       kt[j-1+t]:=kt[j+t];
       kt[j+t]:=0;
       inc(t);
   end;
 dec(kl);
 initialize;
 repaint;
end;

  procedure TPlast_Form.deleteNode(node,ng:integer); //�������� ����� Node �� ������ ���������� Ngr
var i,j,k,t:integer;
begin

for i:=1 to kt[ng] do
begin
if (nagruz[ng,i,1]=node) then
begin
old1:=nagruz[ng,i,3];
old2:=nagruz[ng,i,4];
t:=1;
while (t<=kt[ng]-i)do
begin
for k:=1 to 4 do nagruz[ng,i+t-1,k]:=nagruz[ng,i+t,k];
inc(t);
end;
dec(kt[ng]);
initialize;
repaint;
exit;
end;
end;
end;


procedure TPlast_Form.LoadData;
label 99;
var
  ff: System.Text;
  i,j,k:integer;

  begin
  if FileExists(FileName) then
  begin
  AssignFile(ff,FileName);
  Reset(ff);
  {readln(ff);
  readln(ff);  }
  readln(ff,plast.e1[1]); // ���. ���������
  readln(ff,plast.e1[2]); // �����. ��������
  readln(ff,plast.dop1);  // ���. ����.
  readln(ff,plast.ton1);  // ���. �������
  readln(ff,plast.kz1);   // ����� �����������
//readln(ff,plast.kl1); // ����������
  readln(ff,kl);   // ����� ������� ����������
  for i:=1 to kl do
  begin
  readln(ff,kt[i]);           // ���-�� ����� � 1-�� ������,���-�� ����� �� 2-�� ������,���-�� ����� � 3-�� ������
  if (kt[1]>3) then
  begin
  plast.kx1:=kt[1];
  kt[1]:=1;
  kt[2]:=1;
  kt[3]:=1;
  goto 99;
  end;
  end;
  readln(ff,plast.kx1);       // ����� ��������� �� �
99:  readln(ff,plast.ky1);   // ����� ��������� �� Y

  for j:=1 to plast.kx1 do readln(ff,plast.xm1[j]);
  for j:=1 to plast.ky1 do readln(ff,plast.ym1[j]);
  for i:=1 to plast.kz1 do
    begin
      read(ff,plast.zak1[i]);
      read(ff,plast.zak2[i]);
      readln(ff,plast.zak3[i]);
    end;
{ for j:=1 to plast.kl1 do           //������ ������ ������ �� �� ������ � plast,� �������
begin                                � ������ nagruz,� ������ ��� �������������� Plast �������
      read(ff,plast.nomm[j]);        �� nagruz
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
if (kl<>0)then readln(ff);
//������� ���� ������� �������� � 9-� ������� ����.
initialize;

  plast.s_lin:='';
  plast.s_for:='';
  readln(ff);
  readln(ff,plast.s_lin);
  readln(ff,plast.s_for);
  CloseFile(ff);
  end;
end;

procedure TPlast_Form.FormCreate(Sender: TObject);
{var
i: integer; }
begin
     visio_form.num_color:=5; //���������� ������� ������
     visio_form.num_force:=1; //������ ����������
     visio_form.num_value:=0; //������� ���. ���. ����������
     visio_form.h_or_w_color:=0; //������������ ����� ������
      Main_Form.Sn_Cbx.clear;
//      visio_form.Dote_Rez_Btn.down:=true;
         razbit:=false; // �������� ������ ��� �� ��������� !
      zagr:=true; //������ �� �������� �������� � �����
     Main_Form.Sn_Cbx.clear; Main_Form.sn_cbx.Items.Add('������ ���������� 1');
     Main_Form.Sn_Cbx.ItemIndex:=0;
     Plast_fd_form.Nagr_Nagr_ComboBox.ItemIndex:=0;
     main_form.Cut_Plast_Toolbutton.Enabled:=true;
  isChanged:=false;
  Resize;
    //������������� ������� ������
 keyid:=GlobalAddAtom('My Hotkey'); //������� ����
 RegisterHotKey(handle,
 // ��������� � HotKey ����� �������� �����
 keyid, // ������������ ���� ��� id
 MOD_CONTROL,// ����������� � ��� - ������� Alt
 $53 // ����. ������� - F10
);

  end;

procedure TPlast_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
 Flag, i, num_Plast:Integer;
begin
 Flag:=mrNO;
 if Main_Form.Main_Window_Exit then Action:=caNone else Action:=caFree;
 Main_Form.Exit_Ok:=True;
 if isChanged then
  begin
   Flag:=MessageDlg(chr(13)+'��������� ��������� � ����� "' + Caption + '"?     ' ,mtWarning,mbYesNoCancel,0);
   if Flag=mrCancel then begin Main_Form.Exit_Ok:=False;Action:=caNone;exit; end;
   if Flag=mrYes then
    begin
     FileSave_MnuClick(Sender);
     if SaveCancel then
      begin
       Main_Form.Exit_Ok:=False;
       Action:=caNone;
       exit;
      end
   end;
 end;

if not Main_Form.Main_Window_Exit then
begin
      {Main_Form.Ferma_Panel.Pages[1].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;}

   num_Plast:=0;
   for i := Main_Form.MDIChildCount-1 downto 0 do
    begin
     if (Main_Form.MDIChildren[I] is TPlast_Form) then num_Plast:=num_Plast+1;
     if num_Plast>=2 then break;
    end;

   if num_Plast=1 then
     begin
      //Main_Form.My_menu.Items[0].Enabled:=False;
      //Main_Form.Caption:='����� - ������ 7.0 ��� Windows'; // tarshin 12.11.14
      Main_Form.Plast_Graph_Enter_Panel.Visible:=False;
      Main_Form.Plast_Dock.Visible := False;
      Plast_Fd_Form.first_show_FD_form:=True;
      Plast_FD_Form.Close;
     end;



end;

 Main_Form.StatusBar1.Panels[0].Text :='';
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

end;




// ��������� ��������� ����������� ��� ��������
procedure TPlast_Form.bound_draw_for_plast(x_max,y_max:integer;mas_x,mas_y:single);
var
 i,j,x_int,y_int:integer;
 x,y:single;
begin
 with PaintBox.Canvas do
  begin
   pen.Width:=2;
   pen.Color:=clRed;
   brush.color:=clWhite;

   for i:=1 to plast.kz1 do          // ����� ����� ��������� !!!
     begin

      if plast.kx1>=plast.ky1 then        // ����������� ��������� ���� �� ��� ������
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

      if (plast.zak2[i]=1) or (plast.zak3[i]=1) then
        begin
          if (plast.zak2[i]=1) and (plast.zak3[i]=1) then
            begin
              MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
              LineTo(50+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

              MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
              LineTo(50+round(mas_x*x)+4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

              MoveTo(50+round(mas_x*x)-8+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);
              LineTo(50+round(mas_x*x)+8+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);

              Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);

             pen.Width:=1;
             for j:=-2 to 2 do
              begin
               MoveTo(50+round(mas_x*x)+j*4+coord_axis_x,y_max-30-round(mas_y*y)+10-coord_axis_y);
               LineTo(50+round(mas_x*x)+j*4-2+coord_axis_x,y_max-30-round(mas_y*y)+15-coord_axis_y);
              end;
              pen.Width:=2;
            end;

          if (plast.zak2[i]=1) and (plast.zak3[i]=0) then
          begin
            MoveTo(50+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)-8-coord_axis_y);
            LineTo(50+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)+8-coord_axis_y);
            Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,50+round(mas_x*x)+5+coord_axis_x,y_max-30-round(mas_y*y)+5-coord_axis_y);
            pen.Width:=1;
            for j:=-2 to 2 do
            begin
              MoveTo(50+round(mas_x*x)-4+coord_axis_x,y_max-30-round(mas_y*y)-j*4-coord_axis_y);
              LineTo(50+round(mas_x*x)-9+coord_axis_x,y_max-30-round(mas_y*y)-j*4+2-coord_axis_y);
            end;
            pen.Width:=2;
          end;

          if (plast.zak2[i]=0) and (plast.zak3[i]=1) then
          begin
            MoveTo(50+round(mas_x*x)-8+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
            LineTo(50+round(mas_x*x)+8+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
            Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-30-round(mas_y*y)-3-coord_axis_y,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
            pen.Width:=1;
            for j:=-2 to 2 do
            begin
              MoveTo(50+round(mas_x*x)+j*4+coord_axis_x,y_max-30-round(mas_y*y)+4-coord_axis_y);
              LineTo(50+round(mas_x*x)+j*4-2+coord_axis_x,y_max-30-round(mas_y*y)+9-coord_axis_y);
            end;
           pen.Width:=2;
          end;
     end;

   end;
 end; // ��������� with do
end; // ��������� ���������


//��������� ��������� ���������� ��� ��������
procedure TPlast_Form.force_draw_for_plast(x_max,y_max:integer;mas_x,mas_y:single); //������ ����������
var
 i,x_int,y_int,ii:integer;
 x,y:single;
 k:integer;
 flag_draw:array[1..1000,1..2] of integer;
begin
 with PaintBox.Canvas do
  begin
   Pen.color:=clBlue;
   Pen.width:=2;
   brush.color:=clWhite;
    if plast.kl1=0 then exit;  //���� ��� ���
  if Main_Form.Sn_Cbx.ItemIndex>=0 then Visio_form.num_force:=Main_Form.Sn_Cbx.ItemIndex+1;
  ii:=1;
  if (Visio_form.num_force>1) then for k:=1 to (Visio_form.num_force-1) do ii:=ii+kt[k];

//  if ii>plast.kl1 then ii:=1;
//  for i:=1 to ii do // �������� � ����� 4- ��� ��� ��� ������ �������� ���������� �� 1 �� ���������� ������ ���������� ��� �������� � ���� �� ������ ���������.
// � ������ �� ������ ������ �� ����� ��������,������� ��������� � �������� ������ ����������
   for i:=ii to (ii+kt[Visio_form.num_force]-1) do
    begin
      if plast.nom11[i]<=0 then
        begin
         flag_draw[i,1]:=0;
         if plast.nom11[i]<0 then
          begin
           flag_draw[i,1]:=-25;
          end
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
         end
       end
      else
       begin
        flag_draw[i,2]:=25;
       end;
    end;
  ii:=1;

  if (Visio_form.num_force>1) then for k:=1 to (Visio_form.num_force-1) do ii:=ii+kt[k];
// ii:=Visio_form.num_force;
// if ii>plast.kl1 then ii:=1;
// for i:=1 to ii do // �������� � ����� 4
// � ������ �� ������ ������ �� ����� ��������,������� ��������� � �������� ������ ����������
  for i:=ii to (ii+kt[Visio_form.num_force]-1) do
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

         if (plast.os[i]=11) or (plast.os[i]=33) then
     begin
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       MoveTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)+5);
       MoveTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)-5);
       Pen.color:=clRed; // ���������� �.�. 11.11.07
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
     end;
     if (plast.os[i]=22) or (plast.os[i]=33) then
       Pen.color:=clBlue;  // ���������� �.�. 11.11.07
      begin
      MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       LineTo(50+round(mas_x*x)+5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       LineTo(50+round(mas_x*x)-5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
       Pen.color:=clRed;  // ���������� �.�. 11.11.07
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);

      end;
    Pen.color:=clBlue;     // ���������� �.�. 11.11.07
   end;
  // ��������� ������� �����, � ������� ��������� ����
  // ���������� �� ������ ����������
  // ���������� �.�. 15.12.07 ������
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
       Pen.color:=clRed;
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
     end;
   end;
   // ���������� �.�. 15.12.07 �����
  end;
end;

procedure TPlast_Form.FormPaint(Sender: TObject);
var
  x_max,y_max, //������� ����������� �������
  step_int,i,j,Xp{,coord_axis_x,coord_axis_y}:integer;
  max_x_coord,max_y_coord,
  step,
  mas_x,mas_y:single;     //�������������� ������������
  number,sss:string;
  n_of_step:integer;
begin
  //if plast=nil then Exit; if plast.kl1=0 then main_form.st1.visible:=true else  main_form.st1.visible:=false;
  with PaintBox.Canvas do
    begin
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 brush.Color:=paintbox.color;
 pen.mode:=pmcopy;
 FillRect(Rect(50,5,width-10,height-30));    //????
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    x_max:=PaintBox.width;
    y_max:=PaintBox.height;
    max_x_coord:=0;
    max_y_coord:=0;

      razm.caption:='  ['+plast.s_lin+']';

      for i:=1 to plast.kx1 do
       begin
         if plast.xm1[i]>=max_x_coord then max_x_coord:=plast.xm1[i];
       end;
      for i:=1 to plast.ky1 do
       begin
         if plast.ym1[i]>=max_y_coord then max_y_coord:=plast.ym1[i];
       end;

      {������ ������������ ���}
      Pen.color:=clgray;
      Pen.width:=1;

      mas_x:=(x_max-80-coord_axis_x)/max_x_coord; //�������������� ������������
      mas_y:=(y_max-60-coord_axis_y)/max_y_coord;

      MoveTo(coord_axis_x+43,30);LineTo(x_max-30,30);
      MoveTo(x_max-30,y_max-30-coord_axis_y);LineTo(x_max-30,30);
      MoveTo(coord_axis_x+43,y_max-30-coord_axis_y);LineTo(x_max-15,y_max-30-coord_axis_y);
      LineTo(x_max-20,y_max-35-coord_axis_y);
      MoveTo(x_max-15,y_max-30-coord_axis_y);LineTo(x_max-20,y_max-25-coord_axis_y);
      MoveTo(coord_axis_x+50,y_max-20-coord_axis_y);LineTo(coord_axis_x+50,15);
      LineTo(coord_axis_x+55,20);
      MoveTo(coord_axis_x+50,15);LineTo(coord_axis_x+45,20);

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.color:=clBlack;
      font.size:=10;

      // ��������� �����������
      if Main_Form.FermaRulerButton.Checked = true then
      begin
        TextOut(35,y_max-30,'['+plast.s_lin+']');
      end;
      // ��������� ��� X
      if Main_Form.FermaRulerButton.Checked = true then
        begin
          step:=max_x_coord/strtoint(Main.Main_Form.FermaRulerSizeX.Text);
          n_of_step:=round(max_x_coord/step);
          step_int:=round((x_max-80-coord_axis_X)/n_of_step);
          for i:=1 to n_of_step do
            begin
              str((max_x_coord-step*(i-1)):5:2,number);
              TextOut(x_max-45-step_int*(i-1),y_max-28,number);
              MoveTo(x_max-30-step_int*(i-1),y_max-20-coord_axis_y);
              LineTo(x_max-30-step_int*(i-1),y_max-30-coord_axis_y);
            end;
        end;
        // ��������� ������������ ����� �����
        if Main_Form.FermaGridButton.Checked = true then
        begin
          step:=max_x_coord/strtoint(Main.Main_Form.FermaGridSizeX.Text);
          n_of_step:=round(max_x_coord/step);
          step_int:=round((x_max-80-coord_axis_X)/n_of_step);
          for i:=1 to n_of_step do
          begin
            MoveTo(x_max-30-step_int*(i-1),y_max-30-coord_axis_Y);
            LineTo(x_max-30-step_int*(i-1),30);
          end;
        end;
        // ��������� ��� Y
        if Main_Form.FermaRulerButton.Checked = true then
        begin
          step:=max_y_coord/strtoint(Main.Main_Form.FermaRulerSizeY.Text);
          n_of_step:=round(max_y_coord/step);
          step_int:=round((y_max-60-coord_axis_y)/n_of_step);
          for i:=1 to n_of_step do
            begin
              str((max_y_coord-step*(i-1)):5:2,number);
              TextOut(30,23+step_int*(i-1),number);
              MoveTo(43+coord_axis_x,30+step_int*(i-1));
              LineTo(50+coord_axis_x,30+step_int*(i-1));
            end;
        end;
        // ��������� �������������� ����� �����
        if Main_Form.FermaGridButton.Checked = true then
        begin
          step:=max_y_coord/strtoint(Main.Main_Form.FermaGridSizeY.Text);
          n_of_step:=round(max_y_coord/step);
          step_int:=round((y_max-60-coord_axis_Y)/n_of_step);
          for i:=1 to n_of_step do
          begin
            MoveTo(50+coord_axis_X,30+step_int*(i-1));
            LineTo(x_max-60+coord_axis_X,30+step_int*(i-1));
          end;
        end;
      {������ ��������}

      pen.Width:=strtoint(Main_Form.SX.Text);
      pen.Style:=psDot;
      pen.mode:=pmcopy;
      Pen.color:=clblack;
      for i:=1 to plast.kx1 do
       begin
        MoveTo(50+coord_axis_x+round(mas_x*plast.xm1[i]),y_max-30-coord_axis_y-round(mas_y*plast.ym1[1]));
        LineTo(50+coord_axis_x+round(mas_x*plast.xm1[i]),y_max-30-coord_axis_y-round(mas_y*plast.ym1[plast.ky1]));
       end;
      for i:=1 to plast.ky1 do
       begin
        MoveTo(50+coord_axis_x+round(mas_x*plast.xm1[1]),y_max-coord_axis_y-30-round(mas_y*plast.ym1[i]));
        LineTo(50+coord_axis_x+round(mas_x*plast.xm1[plast.kx1]),y_max-coord_axis_y-30-round(mas_y*plast.ym1[i]));
       end;

//======== �������� (�����������) =====
   Pen.color:=clGreen;
   pen.style:=pssolid;
   Pen.width:=1;
   brush.color:=clWhite;
   for i:=1 to plast.kx1 do
    for j:=1 to plast.ky1 do
      Ellipse(50+coord_axis_x+round(mas_x*plast.xm1[i])-2,y_max-30-coord_axis_y-round(mas_y*plast.ym1[j])-2,50+coord_axis_x+round(mas_x*plast.xm1[i])+4,y_max-30-coord_axis_y-round(mas_y*plast.ym1[j])+4);
   Pen.color:=clBlack;
//======== ����� ��������� ============

       force_draw_for_plast(x_max,y_max,mas_x,mas_y); //��������
       bound_draw_for_plast(x_max,y_max,mas_x,mas_y); //�����������

  end;

 //��������� ���������
 with PaintBox.Canvas do
  begin
    if Main_Form.NodesNum.Checked or Main_Form.Knum.Checked then
     begin
      brush.color:=clWhite;
      font.name:='small font';
      Pen.Width:=1;
      pen.color:=clBlue;
      font.Color:=clGreen;
      font.size:=7;
      if plast.ky1>plast.kx1 then //�������� �� �����������
      begin
      for i:=1 to plast.ky1 do
       begin
           for j:=1 to plast.kx1 do
            begin
        Font.Style:=[fsBold];
        sss:=inttostr((i-1)*plast.kx1+j);
        font.size:=7;
        if (j<plast.kx1) and (i<plast.ky1) then
         begin
          brush.color:=clWhite;
         brush.Style:=bsSolid;
         if ((i-1)*(plast.kx1-1)+j)<=99 then
         if Main_Form.Knum.Checked then
          Rectangle(round(mas_x*(plast.xm1[j]+plast.xm1[j+1])/2)-6+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[i]+plast.ym1[i+1])/2)-7-coord_axis_y,round(mas_x*(plast.xm1[j]+plast.xm1[j+1])/2)+10+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[i]+plast.ym1[i+1])/2)+6-coord_axis_y)
         else
         if Main_Form.Knum.Checked then
           Rectangle(round(mas_x*(plast.xm1[j]+plast.xm1[j+1])/2)-6+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[i]+plast.ym1[i+1])/2)-7-coord_axis_y,round(mas_x*(plast.xm1[j]+plast.xm1[j+1])/2)+15+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[i]+plast.ym1[i+1])/2)+6-coord_axis_y);
            brush.Style:=bsClear;
            if ((i-1)*(plast.kx1-1)+j)<=9 then Xp:=0 else Xp:=3;
            if Main_Form.Knum.Checked then
            TextOut(-Xp+round(mas_x*(plast.xm1[j]+plast.xm1[j+1])/2)+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[i]+plast.ym1[i+1])/2)-6-coord_axis_y,inttostr((i-1)*(plast.kx1-1)+j));
         end;

        brush.Style:=bsClear;
        font.size:=8;
        if Main_Form.NodesNum.Checked then
        TextOut(54+round(mas_x*plast.xm1[j])+coord_axis_x,y_max-45-round(mas_y*plast.ym1[i])-coord_axis_y,sss);

        end;
         end;
          end
     else //�������� �� ���������
      begin
      for i:=1 to plast.kx1 do
       begin
           for j:=1 to plast.ky1 do
            begin
        sss:=inttostr((i-1)*plast.ky1+j);
        font.size:=7;
        if (j<plast.ky1) and (i<plast.kx1) then
         begin
          brush.color:=clWhite;
        brush.Style:=bsSolid;
        if ((i-1)*(plast.ky1-1)+j)<=99 then
        if Main_Form.Knum.Checked then
            Rectangle(round(mas_x*(plast.xm1[i]+plast.xm1[i+1])/2)-6+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[j]+plast.ym1[j+1])/2)-7-coord_axis_y,round(mas_x*(plast.xm1[i]+plast.xm1[i+1])/2)+10+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[j]+plast.ym1[j+1])/2)+6-coord_axis_y)
        else
        if Main_Form.Knum.Checked then
             Rectangle(round(mas_x*(plast.xm1[i]+plast.xm1[i+1])/2)-6+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[j]+plast.ym1[j+1])/2)-7-coord_axis_y,round(mas_x*(plast.xm1[i]+plast.xm1[i+1])/2)+15+50+coord_axis_x,y_max-30-round(mas_y*(plast.ym1[j]+plast.ym1[j+1])/2)+6-coord_axis_y);
            brush.Style:=bsClear;
            if ((i-1)*(plast.ky1-1)+j)<=9 then Xp:=0 else Xp:=3;
            if Main_Form.Knum.Checked then
            TextOut(-Xp+coord_axis_x+round(mas_x*(plast.xm1[i]+plast.xm1[i+1])/2)+50,y_max-30-round(mas_y*(plast.ym1[j]+plast.ym1[j+1])/2)-6-coord_axis_y,inttostr((i-1)*(plast.ky1-1)+j));
         end;
        brush.Style:=bsClear;
        Font.Style:=[fsBold];
        font.size:=8;
        if Main_Form.NodesNum.Checked then
        TextOut(54+round(mas_x*plast.xm1[i])+coord_axis_x,y_max-45-round(mas_y*plast.ym1[j])-coord_axis_y,sss);

            end;
       end;
       end;
       end;
       end;

 font.Color:=clBlack;

end;

procedure TPlast_Form.FormResize(Sender: TObject);
begin

  Xold:=-1;
  yold:=-1;

if not Main_Form.TileWindows then
 begin
  if ClientWidth<360 then ClientWidth:=360;
  if ClientHeight<260 then ClientHeight:=260;
  if Main_Form.CascadeWindows then
   begin
    ClientWidth:=360;
    ClientHeight:=260;
   end;
 end
else
 begin
  if Main_Form.MDIChildCount<=3 then
   begin
    if Main_Form.TileMode=tbVertical then ClientHeight:=260;
    if Main_Form.TileMode=tbHorizontal then ClientWidth:=360;
   end;
 end;
 end;


procedure TPlast_Form.N15Click(Sender: TObject);
begin
//   ����� �����
  Main_Form.NewFerma_MnuClick(Self);
end;

procedure TPlast_Form.N17Click(Sender: TObject);
begin
  Main_Form.Open1Click(Self);
end;

procedure TPlast_Form.N22Click(Sender: TObject);
begin
  Main_Form.Exit1Click(Self);
end;

procedure TPlast_Form.FormActivate(Sender: TObject);
var
  i,j:integer;
  active_page :Boolean;
begin
  active_page := False;
  if (Main_Form.Ferma_Panel.ActivePageIndex = 2)
       or (Main_Form.Ferma_Panel.ActivePageIndex = 4) then
         active_page := true;
  if plast=nil then Exit;
  Xold:=-1;
  Yold:=-1;
 { Main_Form.Plast_ToolBar.Left:=86;
  Main_Form.Plast_ToolBar.Top:=2;}
  //Main_Form.Caption:='����� - ���������� '+#39+'��������'+#39;
  Main_Form.Ferma_Panel.Pages[1].TabVisible:=True;
  Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[3].TabVisible:=True;
  Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;
  if active_page then
    Main_Form.Ferma_Panel.ActivePageIndex := 3;
//  Main_Form.Save_TBtn.Enabled:=true; my comment

  Main_Form.Ferma_Graph_Enter_Panel.Visible:=False;

  Main_Form.Ferma_Dock.Visible := False;
  Ferma_FD_Form.Visible:=False;
  Main_Form.TOK_Graph_Enter_Panel.Visible:=False;
  Main_Form.Tok_Dock.Visible := False;
  TOK_FD_Form.Visible:=False;
  //Main_Form.My_menu.Items[0].Enabled:=True;

  if (plast.kx1>=12) and (plast.ky1>=12) then
   Main_Form.Cut_Plast_Toolbutton.Enabled:=false
  else
   Main_Form.Cut_Plast_Toolbutton.Enabled:=true;
  //Main_Form.Cut_Plast_Toolbutton.Enabled:=true;
 PaintBox.Cursor:=crDefault;
 PaintBox.ShowHint:=False;
 Main_Form.Plast_Graph_Enter_Panel.Buttons[0].Down:=True;
{my insertochka}
 for j:=1 to Main_Form.Plast_Graph_Enter_Panel.ButtonCount-1 do
     Main_Form.Plast_Graph_Enter_Panel.Buttons[j].down:=false;
{end of my insertochka}
  if Main_Form.ConstructorShow.Checked then
   begin
    Plast_Fd_Form.Visible:=True;
   end;
 if Main_Form.PanelConstruction.Checked then
   begin
    Main_Form.Plast_Graph_Enter_Panel.Visible:=True;
    if Main_Form.Plast_Graph_Enter_Panel.Parent = Main_Form.Plast_Dock then
      Main_Form.Plast_Dock.Visible := true else Main_Form.Plast_Dock.Visible := false;
   end
  else
  if (Main_Form.Sn_Cbx.ItemIndex = -1)or( Main_Form.Sn_Cbx.Items.Count<>plast.kl1 ) then
  begin
  Main_Form.SN_Cbx.clear;
  for i:=1 to plast.kl1 do
    begin
      Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
    end;
  end;
    if Main_Form.Sn_Cbx.ItemIndex = -1 then
       Main_Form.Sn_Cbx.ItemIndex:=0
       else
               begin
  plast_FD_form.showD(plast);
  Main_Form.Sn_Cbx.ItemIndex:=plast_fd_form.Nagr_Nagr_ComboBox.ItemIndex;
               end;
   if plast.kl1=0 then begin
  Main_Form.Sn_Cbx.clear;
  Main_Form.Sn_Cbx.Items.Add('������ ���������� 1');
  Main_Form.Sn_Cbx.ItemIndex:=0;
  end;
 if plast.kl1<=0 then begin main_form.Sn_cbx.Enabled:=false; end else  begin main_form.Sn_cbx.Enabled:=true; end;

//my insert
  if not FileExists(ChangeFileExt(FileName,'.vrp')) then
  begin

  main_form.P2.Enabled:=false;
  main_form.P3.Enabled:=false;
  end
  else begin

  main_form.P2.Enabled:=true;
  main_form.P3.Enabled:=true;
  end;
  if not FileExists(ChangeFileExt(FileName,'.vop')) then
  begin

  main_form.P5.Enabled:=false;
  main_form.P6.Enabled:=false;
  end
  else begin

  main_form.P2.Enabled:=true;
  main_form.P3.Enabled:=true;
  end;
//end of my insert
  plast_FD_form.showD(plast);
end;

procedure TPlast_Form.OptResults_MnuClick(Sender: TObject);
var
Version_VYV:string;
 f1:System.text;
 ff:File of Byte;
 mg:integer;
begin
Visio_Form.plast:=plast; // ���������� �.�. 11.11.07
// �������� �� ������������� ������ �������
  if FileExists(ChangeFileExt(FileName,'.vop'))and FileExists(ChangeFileExt(FileName,'.w0'))and FileExists(ChangeFileExt(FileName,'.w1'))and FileExists(ChangeFileExt(FileName,'.w2'))and FileExists(ChangeFileExt(FileName,'.w')) then
    begin
      AssignFile(f1,ChangeFileExt(FileName,'.vop'));
      Reset(f1);
      ReadLn(f1,Version_VYV);
      CloseFile(f1);
    end
  else Version_VYV:='Error';

  if Version_VYV='Error' then
   begin
    Beep;
    MessageDlg(#13+'����� � ��������������� �������� �� �������.',mtError,[mbOk],0);
    exit;
   end;

// �������� �� ������������� ������ ������ ������ � ���������������� ��������
if FileExists(FileName) then
 begin
  Assignfile(ff,FileName);
  Reset(ff);
  mg:=filesize(ff);
  CloseFile(ff);
 end
else
 begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#10+#13+'����������� ��������������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
 end;

 if ((Version_VYV)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
     or (isChanged=True) then
  begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#10+#13+'����������� ��������������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
  end;

  Visio_Form.num_value:=6;//������� Visio_Form.num_rast:=1; //�����������
  Visio_Form.num_rast:=1; //�����������
  Visio_Form.LoadData(Filename);
  Visio_Form.fnn:=FileName;
  Visio_Form.X_Napr_Btn.Down:=false;
  Visio_Form.Y_Napr_Btn.Down:=false;
  Visio_Form.Kas_Napr_Btn.Down:=false;
  Visio_Form.eq_Napr_Btn.Down:=false;
  //Visio_Form.Panel1.Visible:=true;
  Visio_Form.to_read_or_not_to_read:=true;
  //visio_form.Napr_PaintBox.Repaint;
  Visio_Form.ShowModal;


end;

procedure TPlast_Form.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
label
1,2,3,4;
var
  p,m,s:TPoint;
  ux,uy:single;
  i,j,nn,What_Do,RealX,RealY,ii,iii,jj,jjj:integer;
  RealRealX,RealRealY:extended;
  cz:array[1..plast_max_zak,1..2] of extended;//���������� �����������
  cf:array[1..plast_max_for,1..2] of extended;//���������� ��������
  max_x_coord,max_y_coord:single;
  currentnx,currentny : integer;
begin
  p.x:=X;
  p.y:=Y;
  max_x_coord:=0;
  max_y_coord:=0;
  ux:=0;
  uy:=0;

  for i:=1 to plast.kx1 do
    begin
      if plast.xm1[i]>=max_x_coord then max_x_coord:=plast.xm1[i];
    end;
  for i:=1 to plast.ky1 do
    begin
      if plast.ym1[i]>=max_y_coord then max_y_coord:=plast.ym1[i];
    end;

     What_Do:=0;
  // ����� ������ ������ ?
  for i:=0 to main.Main_Form.Plast_Graph_Enter_Panel.ButtonCount-1 do
   begin
   if main.Main_Form.Plast_Graph_Enter_Panel.Buttons[i].Down = true then
    What_Do:=i;
   end;

case What_Do of
0:
 begin
  if Button=mbRight then
   begin
    M.x:=X;
    M.y:=Y;
    Real_Coord_PUM.Popup(ClientToScreen(M).X,ClientToScreen(M).Y);
   end;
 end;
5:   // ����������� � ��������
 begin
  CurrentNode:=0;
  for i:=1 to plast.kx1 do
    for j:=1 to plast.ky1 do
      begin
        if plast.kx1>=plast.ky1 then nn:=j+(i-1)*plast.ky1
                                else nn:=i+(j-1)*plast.kx1;
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(plast.xm1[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(plast.ym1[j]);

       if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) then
          begin
            CurrentNode:=nn;
            goto 3;
          end;
      end;
3:  if CurrentNode=0 then Exit;
// my comment  Plast_PopUp.Popup(ClientToScreen(p).x,ClientToScreen(p).y);
{��� ���������}
  FixNode_PMnuClick(sender);
{����� ���� ���������}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);

  if CurrentNode=0 then Exit;
  FixNode_Form.Top:=ClientToScreen(M).y;
  FixNode_Form.Left:=ClientToScreen(M).x;
  ForceNode_Form.Top:=ClientToScreen(M).y;
  ForceNode_Form.Left:=ClientToScreen(M).x;
  if ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-ForceNode_Form.Height;
     S.x:=P.x+11;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+ForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+ForceNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-ForceNode_Form.Height;
     S.x:=P.x-7-ForceNode_Form.Width;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).y+FixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-FixNode_Form.Height;
     S.x:=P.x+11;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+FixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-FixNode_Form.Width;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+FixNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+FixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-FixNode_Form.Height;
     S.x:=P.x-7-FixNode_Form.Width;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;

end;

6:   // ����������� � ��������
 begin
  CurrentNode:=0;
  for i:=1 to plast.kx1 do
    for j:=1 to plast.ky1 do
      begin
        if plast.kx1>=plast.ky1 then nn:=j+(i-1)*plast.ky1
                                else nn:=i+(j-1)*plast.kx1;
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(plast.xm1[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(plast.ym1[j]);

       if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) then
          begin
            CurrentNode:=nn;
            goto 4;
          end;
      end;
4:  if CurrentNode=0 then Exit;
// my comment  Plast_PopUp.Popup(ClientToScreen(p).x,ClientToScreen(p).y);
{my insert}
  ForceNode_PMnuClick(sender);
{end of my insert}
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);

  if CurrentNode=0 then Exit;
  FixNode_Form.Top:=ClientToScreen(M).y;
  FixNode_Form.Left:=ClientToScreen(M).x;
  ForceNode_Form.Top:=ClientToScreen(M).y;
  ForceNode_Form.Left:=ClientToScreen(M).x;
  if ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-ForceNode_Form.Height;
     S.x:=P.x+11;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+ForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+ForceNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-ForceNode_Form.Height;
     S.x:=P.x-7-ForceNode_Form.Width;
     ForceNode_Form.Top:=ClientToScreen(S).y;;
     ForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).y+FixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-FixNode_Form.Height;
     S.x:=P.x+11;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+FixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-FixNode_Form.Width;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+FixNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+FixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-FixNode_Form.Height;
     S.x:=P.x-7-FixNode_Form.Width;
     FixNode_Form.Top:=ClientToScreen(S).y;;
     FixNode_Form.Left:=ClientToScreen(S).x;
   end;

end;
3: //�������� ��������
begin
     CurrentNx:=0;
     CurrentNy:=0;
  for i:=2 to plast.kx1-1 do
     begin
        ux:=50+coord_axis_x+(width-91-coord_axis_x)/max_x_coord*(plast.xm1[i]);
        if (X>ux-4)and(X<ux+4) then
          begin
            CurrentNx:=i;
            Break;
          end;
      end;

    for j:=2 to plast.ky1-1 do
      begin
        uy:=height-61-coord_axis_y-(height-91-coord_axis_y)/max_y_coord*(plast.ym1[j]);
        if (Y>uy-4)and(Y<uy+4) then
          begin
            CurrentNy:=j;
            Break;
          end;
      end;
       if (currentnx=0)and(currentny=0)then exit;// �����, ���� �� �������
        if currentnx<>0 then
        begin
        //�������� �����������
         for i:=1 to plast.kz1 do
         begin
        //  for j=1 to plast.kx1 do
          if   (Plast.kx1>=plast.ky1) and (plast.zak1[i]>=(currentnx-1)*plast.ky1+1) and (plast.zak1[i]<= (currentnx)*plast.ky1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
            for j:=1 to plast.ky1 do
            if   (Plast.kx1<plast.ky1) and (plast.zak1[i]=(plast.kx1)*(j-1)+currentnx) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
           end;
          //�������� ���
         for i:=1 to plast.kl1 do
         begin
          if   (Plast.kx1>=plast.ky1) and (plast.nomm[i]>=(currentnx-1)*plast.ky1+1) and (plast.Nomm[i]<= (currentnx)*plast.ky1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
            for j:=1 to plast.ky1 do
           if   (Plast.kx1<plast.ky1) and (plast.nomm[i]=(plast.kx1)*(j-1)+currentnx) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
           end;
          end;// currentnx<>0

           if currentny<>0 then
        begin
        //�������� �����������
         for i:=1 to plast.kz1 do
         begin
          for j:=1 to plast.kx1 do
          if   (Plast.kx1>=plast.ky1) and (plast.zak1[i]=(plast.ky1)*(j-1)+currentny) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
            if   (Plast.kx1<plast.ky1) and (plast.zak1[i]>=(currentny-1)*plast.kx1+1) and (plast.zak1[i]<= (currentny)*plast.kx1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
           end;
          //�������� ���
         for i:=1 to plast.kl1 do
         begin
          for j:=1 to plast.kx1 do
          if   (Plast.kx1>=plast.ky1) and (plast.Nomm[i]=(plast.ky1)*(j-1)+currentny) then
               begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
             if   (Plast.kx1<plast.ky1) and (plast.nomm[i]>=(currentny-1)*plast.kx1+1) and (plast.nomm[i]<= (currentny)*plast.kx1)then
           begin
              Main_Form.StatusBar1.Panels[1].Text := '����������. ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
              Exit;
            end;
           end;
          end;// currentny<>0
          //����� ��������
                  //���������� ����������
   iii:=1;
   jjj:=1;
   if plast.kx1>=plast.ky1 then  //���� ��������� �� ���������
    begin
    for ii:=1 to plast.kz1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.zak1[ii]=nn then
          begin
          cz[iii,1]:=plast.xm1[i];
          cz[iii,2]:=plast.ym1[j];
          iii:=iii+1;
          end;
         end;
    for jj:=1 to plast.kl1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.nomm[jj]=nn then
          begin
          cf[jjj,1]:=plast.xm1[i];
          cf[jjj,2]:=plast.ym1[j];
          jjj:=jjj+1;
          end;
          end;
        end
   else        // ���� ��������� �� �����������
     begin
       for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if plast.zak1[ii]=nn then
             begin
              cz[iii,1]:=plast.xm1[j];
              cz[iii,2]:=plast.ym1[i];
              iii:=iii+1;
             end;
           end;

         for jj:=1 to plast.kl1 do
          for i:=1 to plast.ky1 do
           for j:=1 to plast.kx1 do
            begin
             nn:=(i-1)*plast.kx1+j;
              if plast.nomm[jj]=nn then
               begin
                cf[jjj,1]:=plast.xm1[j];
                cf[jjj,2]:=plast.ym1[i];
                jjj:=jjj+1;
               end;
              end;
         end;
//��������� ����������
//��������� ����� ���������
if currentnx<>0 then
begin
 for i:=2 to plast.kx1-1 do
  if i>=currentnx then
   plast.xm1[i]:=plast.xm1[i+1];
 dec(plast.kx1);
end;

if currentny<>0 then
begin
 for i:=2 to plast.ky1-1 do
  if i>=currentny then
   plast.ym1[i]:=plast.ym1[i+1];
 dec(plast.ky1);
end;
// ������������!

 //��������� ����� - ����� ������
 iii:=1;
 jjj:=1;
 if plast.kx1>=plast.ky1 then //���� ��������� �� ���������
    begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cz[ii,1])=round(plast.xm1[i])) and (round(cz[ii,2])=round(plast.ym1[j])) then
              begin
               plast.zak1[iii]:=nn;
               iii:=iii+1;
              end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cf[jj,1])=round(plast.xm1[i])) and (round(cf[jj,2])=round(plast.ym1[j])) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
           end;
    end
 else                   //���� ��������� �� �����������
      begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
             if (round(cz[ii,1])=round(plast.xm1[j])) and (round(cz[ii,2])=round(plast.ym1[i])) then
               begin
                plast.zak1[iii]:=nn;
                iii:=iii+1;
               end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if (round(cf[jj,1])=round(plast.xm1[j])) and (round(cf[jj,2])=round(plast.ym1[i])) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
            end ;
   end ;
 //�������������� ��������� � ������������ � ������ �������
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(plast);
 Main_Form.Cut_Plast_Toolbutton.Enabled:=true;
 Main_Form.ActiveMDIChild.RePaint;
 cutIdent:='';


end;  //����� ��se3


2: //�������� ��������
begin
 RealX:=Round((X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));
 RealY:=Round((PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));
 RealRealX:=(X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x);
 RealRealY:=(PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y);

 if ((RealRealX<Plast.xm1[plast.kx1])and(RealRealX>0)) or ((RealRealY<Plast.ym1[plast.ky1])and(RealRealY>0)) then //���� ������ � ������ �������
  begin
    // �������� �� �������������
   if (RealRealX<Plast.xm1[plast.kx1])and(RealRealX>0) then
   for i:=1 to plast.kx1 do
    if (realX=round(plast.xm1[i])) then
     begin
      Main_Form.StatusBar1.Panels[1].Text := '���������� ������� �������� � ���� �����.';
      Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
      Exit;
     end; //����� �������� �� �������������
   if ((RealRealY<Plast.ym1[plast.ky1])and(RealRealY>0)) then
      for j:=1 to plast.ky1 do
       if (realY=round(plast.ym1[j]))then
        begin
         Main_Form.StatusBar1.Panels[1].Text := '���������� ������� �������� � ���� �����.';
         Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
         Exit;
        end; //����� �������� �� �������������


     Main_Form.StatusBar1.Panels[1].Text := '';
     Main_Form.StatusBar1.Panels[2].Text := '';
                  //���������� ����������
   iii:=1;
   jjj:=1;
   if plast.kx1>=plast.ky1 then  //���� ��������� �� ���������
    begin
    for ii:=1 to plast.kz1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.zak1[ii]=nn then
          begin
          cz[iii,1]:=plast.xm1[i];
          cz[iii,2]:=plast.ym1[j];
          iii:=iii+1;
          end;
         end;

    for jj:=1 to plast.kl1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.nomm[jj]=nn then
          begin
          cf[jjj,1]:=plast.xm1[i];
          cf[jjj,2]:=plast.ym1[j];
          jjj:=jjj+1;
          end;
          end;
        end

   else        // ���� ��������� �� �����������
     begin
       for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if plast.zak1[ii]=nn then
             begin
              cz[iii,1]:=plast.xm1[j];
              cz[iii,2]:=plast.ym1[i];
              iii:=iii+1;
             end;
           end;

         for jj:=1 to plast.kl1 do
          for i:=1 to plast.ky1 do
           for j:=1 to plast.kx1 do
            begin
             nn:=(i-1)*plast.kx1+j;
              if plast.nomm[jj]=nn then
               begin
                cf[jjj,1]:=plast.xm1[j];
                cf[jjj,2]:=plast.ym1[i];
                jjj:=jjj+1;
               end;
              end;
         end;
//��������� ����������

end // ����� "���� ������ � ������ �������"

  else
     begin
         Main_Form.StatusBar1.Panels[1].Text := '���������� ������� �������� � ���� �����.';
         Main_Form.StatusBar1.Panels[2].Text := '����������� ������.';
         Exit;
        end;

    //���������...

//��������� ����� ���������
 if (realX>0) and(realX<plast.xm1[plast.kx1])then //���� �� X
 begin
  if plast.kx1=12 then
  begin  //�������� �� ��� ���������
    Main_Form.StatusBar1.Panels[0].Text := '';
    Main_Form.StatusBar1.Panels[1].Text := '���������� ������������ ����� �����.';
    Main_Form.StatusBar1.Panels[2].Text := '���������� ��������� �� � ����������.';
    if plast.ky1=12 then
     begin
       Main_form.ToolButton1.Down := True;
       Main_form.Cut_Plast_Toolbutton.Enabled:=false;
       PaintBox.Cursor:=crDefault;//default;
       Main_Form.StatusBar1.Panels[0].Text := '';
       Main_Form.StatusBar1.Panels[1].Text := '';
       Main_Form.StatusBar1.Panels[2].Text := '';
       //XOld:=-1;
       //YOld:=-1;
      zagr:=True;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
      Plast_FD_Form.showD(plast);
      Main_Form.ActiveMDIChild.RePaint;
     end;
    exit;
  end; //kx=15     //����� �������� �� ��� ���������
  plast.kx1:=plast.kx1+1;
  plast.xm1[plast.kx1]:=plast.xm1[plast.kx1-1];
   for i:=plast.kx1 downto 3 do
    if (RealX < plast.xm1[i]) and (RealX > plast.xm1[i-2]) then
     begin
     plast.xm1[i-1]:=RealX;
     goto 1;
     end
     else
     plast.xm1[i-1]:=plast.xm1[i-2];
  end;
1:
 if (realY>0) and(realY<plast.ym1[plast.ky1])then //���� �� Y
 begin
 if plast.ky1=12 then begin  //�������� �� ��� ���������
    Main_Form.StatusBar1.Panels[1].Text := '���������� ������������ ����� �����.';
    Main_Form.StatusBar1.Panels[2].Text := '���������� ��������� �� Y ����������.';
    if plast.kx1=12 then begin
      Main_form.ToolButton1.Down := True;
      Main_form.Cut_Plast_Toolbutton.Enabled:=false;
      PaintBox.Cursor:=crDefault;
      Main_Form.StatusBar1.Panels[0].Text := '';
      Main_Form.StatusBar1.Panels[1].Text := '';
      Main_Form.StatusBar1.Panels[2].Text := '';
      //XOld:=-1;
      //YOld:=-1;
      Zagr:=True;   
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
      Plast_FD_Form.showD(plast);
      Main_Form.ActiveMDIChild.RePaint;
    end;    //kx=15
    exit;
  end; //ky=15      //����� �������� �� ��� ���������
  plast.ky1:=plast.ky1+1;
  plast.ym1[plast.ky1]:=plast.ym1[plast.ky1-1];
   for i:=plast.ky1 downto 3 do
    if (RealY < plast.ym1[i]) and (RealY > plast.ym1[i-2]) then
     begin
     plast.ym1[i-1]:=RealY;
     goto 2;
     end
     else
     plast.ym1[i-1]:=plast.ym1[i-2];
  end;
2:
 //��������� ����� - ����� ������
 iii:=1;
 jjj:=1;
 if plast.kx1>=plast.ky1 then //���� ��������� �� ���������
    begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cz[ii,1])=round(plast.xm1[i])) and (round(cz[ii,2])=round(plast.ym1[j])) then
              begin
               plast.zak1[iii]:=nn;
               iii:=iii+1;
              end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cf[jj,1])=round(plast.xm1[i])) and (round(cf[jj,2])=round(plast.ym1[j])) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
           end;
    end
 else                   //���� ��������� �� �����������
      begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
             if (round(cz[ii,1])=round(plast.xm1[j])) and (round(cz[ii,2])=round(plast.ym1[i])) then
               begin
                plast.zak1[iii]:=nn;
                iii:=iii+1;
               end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if (round(cf[jj,1])=round(plast.xm1[j])) and (round(cf[jj,2])=round(plast.ym1[i])) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
            end ;
   end ;
   razbit:=true; //�������� ������ ��� �������
 //�������������� ��������� � ������������ � ������ �������
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(plast);
 Main_Form.ActiveMDIChild.RePaint;

end;
end;
end;


procedure TPlast_Form.FixNode_PMnuClick(Sender: TObject);
var
  i,nz:integer;
  z1,z2,z3:array[1..plast_max_zak] of integer; // ����������� (����� ����, X � Y)
begin
  if CurrentNode=0 then Exit;
  nz:=0;
  for i:=1 to plast.kz1 do
    if plast.zak1[i]=CurrentNode then
      begin
        nz:=i;
        Break;
      end;
  if nz=0 then
    begin
      if plast.kz1=plast_max_zak then
        begin
          MessageDlg(#13+'������� ����� ������������ �����.',mtWarning,[mbOk],0);
          Exit;
        end;
      inc(plast.kz1);
      nz:=plast.kz1;
      plast.zak1[nz]:=CurrentNode;
      plast.zak2[nz]:=0;
      plast.zak3[nz]:=0;
    end;
  FixNode_Form.Execute(plast.zak2[nz],plast.zak3[nz]);
// ������� �������������� ����
  nz:=1;
  for i:=1 to plast.kz1 do
    if (plast.zak2[i]<>0)or(plast.zak3[i]<>0) then
      begin
        z1[nz]:=plast.zak1[i];
        z2[nz]:=plast.zak2[i];
        z3[nz]:=plast.zak3[i];
        inc(nz);
      end;
  plast.kz1:=nz-1;
  for i:=1 to plast.kz1 do
    begin
      plast.zak1[i]:=z1[i];
      plast.zak2[i]:=z2[i];
      plast.zak3[i]:=z3[i];
    end;
    plast_fd_form.ShowD(plast);
  RePaint;
  isChanged:=true;
end;
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
///////////////// ���������� ����� ������ ���������� //////////////////
///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
procedure TPlast_Form.ForceNode_PMnuClick(Sender: TObject);
var
  i,j,k,t:integer;
  nomm,os:array[1..plast_max_for] of integer; // �������� (����� ����, ������� ����������(�� X - 11, �� Y - 22, �� X � Y - 33), �� X, �� y)
  nom11,nom22:array[1..plast_max_for] of single;
  max_x_coord,max_y_coord:single;
  flg:boolean;
  begin
  if CurrentNode=0 then Exit;
//������ ��� �������� ������ �� �������
//nz:=0;
//  for i:=1 to plast.kl1 do
//    if (plast.nomm[i]=CurrentNode)and(i=main_form.SN_Cbx.ItemIndex+1) then
//      begin
//        nz:=i;
//        Break;
//      end;
//  if nz=0 then
//           if plast.kl1=plast_max_for then
//        begin
//          MessageDlg(#13+'������� ����� ����������� �����.',mtWarning,[mbOk],0);
//          Exit;
//        end;
    if kl=0 then
      begin
        inc(kl);

        inc(Kt[kl]);
        nagruz[kl,kt[kl],1]:=CurrentNode;

        Main_Form.Sn_Cbx.Items.clear;
          for i:=1 to kl do  Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
            main_form.SN_Cbx.ItemIndex:=kl-1;
           if kl<=0 then main_form.Sn_cbx.Enabled:=false
           else  main_form.Sn_cbx.Enabled:=true;
      end
    else
      begin
        for i:= 1 to kt[main_form.SN_Cbx.ItemIndex+1] do if (nagruz[main_form.SN_Cbx.ItemIndex+1,i,1]=CurrentNode) then
          begin
            DeleteNode(CurrentNode,main_form.SN_Cbx.ItemIndex+1);
            repaint;
          end;
        if(kt[main_form.SN_Cbx.ItemIndex+1]=3) then
          Begin
            MessageDlg(#13+'������� ����� ����������� ����� ��� ����� ������',mtWarning,[mbOk],0);
            exit;
          end;
        inc(kt[main_form.SN_Cbx.ItemIndex+1]);
        nagruz[main_form.SN_Cbx.ItemIndex+1,kt[main_form.SN_Cbx.ItemIndex+1],1]:=CurrentNode;
     end;
     plast.kl1:=0;
    ForceNode_Form.showmodal;

// ������� �������������� ����,������ ��� ������� ������� ����� :)
for i:= 1 to kt[main_form.SN_Cbx.ItemIndex+1] do if ((nagruz[main_form.SN_Cbx.ItemIndex+1,i,3]=0)and(nagruz[main_form.SN_Cbx.ItemIndex+1,i,4]=0)) then
     begin
     DeleteNode(nagruz[main_form.SN_Cbx.ItemIndex+1,i,1],main_form.SN_Cbx.ItemIndex+1);
     repaint;
     end;
{  // ������� �������������� ����
  nz:=1;
  for i:=1 to plast.kl1 do
    if (plast.nom11[i]<>0)or(plast.nom22[i]<>0) then
      begin
        nom11[nz]:=plast.nom11[i];
        nom22[nz]:=plast.nom22[i];
        nomm[nz]:=plast.nomm[i];
        os[nz]:=plast.os[i];
        inc(nz);
      end
      else
       begin
         Main_Form.Sn_Cbx.Items.delete(plast.kl1-1);
         Plast_fd_form.Nagr_Nagr_ComboBox.Items.delete(plast.kl1-1);
         Main_Form.Sn_Cbx.Itemindex:= plast.kl1-2;
         Plast_fd_form.Nagr_Nagr_ComboBox.Itemindex:= plast.kl1-2;
          Plast_fd_form.NNagr_Edit.Text:= inttostr(plast.kl1-1);
       end;
  plast.kl1:=nz-1;
  for i:=1 to plast.kl1 do
    begin
        plast.nom11[i]:=nom11[i];
        plast.nom22[i]:=nom22[i];
        plast.nomm[i]:=nomm[i];
        plast.os[i]:=os[i];
    end;
  for i:=plast.kl1+1 to 3 do
    begin
        plast.nom11[i]:=0;
        plast.nom22[i]:=0;
        plast.nomm[i]:=0;
        plast.os[i]:=0;
    end;
 plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);


  isChanged:=true;

  Main_Form.Plast_Nagr_ToolButton.Down:=True;
  Cursor:=crHandPoint;
}
//================= ��� ���� ��� �� ���� ? =====================================

 max_x_coord:=0;
 max_y_coord:=0;

 if plast.kl1<=0 then main_form.Sn_cbx.Enabled:=false
  else  main_form.Sn_cbx.Enabled:=true;

       for i:=1 to plast.kx1 do
       begin
         if plast.xm1[i]>=max_x_coord then max_x_coord:=plast.xm1[i];
       end;
      for i:=1 to plast.ky1 do
       begin
         if plast.ym1[i]>=max_y_coord then max_y_coord:=plast.ym1[i];
       end;

 if (Main_Form.Sn_Cbx.ItemIndex = -1)or( Main_Form.Sn_Cbx.Items.Count<>plast.kl1 ) then
  begin
   Main_Form.Sn_Cbx.clear;
   for i:=1 to plast.kl1 do
    begin
      Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
    end;
  end;

 if Main_Form.Sn_Cbx.ItemIndex = -1 then
  Main_Form.Sn_Cbx.ItemIndex:=0
 else
  Main_Form.Sn_Cbx.ItemIndex:=plast_fd_form.Nagr_Nagr_ComboBox.ItemIndex;
//==============================================================================
  if plast.kl1=0 then begin
  Main_Form.Sn_Cbx.clear;
  Main_Form.Sn_Cbx.Items.Add('������ ���������� 1');
  Main_Form.Sn_Cbx.ItemIndex:=0;
  end;
  Visio_Form.num_force:=Main_Form.Sn_Cbx.ItemIndex+1;
 if Plast_FD_Form.Visible=true then Plast_FD_Form.ShowD(plast);

  end;

procedure TPlast_Form.SaveData;
var
  ff: System.Text;
  i,j,k,ii:integer;
begin
//��������� �������� ���� �������
 begin
  AssignFile(ff,FileName);
  Rewrite(ff);
  writeln(ff,plast.e1[1]);
  writeln(ff,plast.e1[2]);
  writeln(ff,plast.dop1);
  writeln(ff,plast.ton1);
  writeln(ff,plast.kz1);
//writeln(ff,plast.kl1);
  writeln(ff,kl);   // ����� ������� ����������
  for i:=1 to kl do
  begin
  writeln(ff,kt[i]);           // ���-�� ����� � 1-�� ������,���-�� ����� �� 2-�� ������,���-�� ����� � 3-�� ������
  end;
  writeln(ff,plast.kx1);
  writeln(ff,plast.ky1);

  for j:=1 to plast.kx1 do writeln(ff,plast.xm1[j]);
  for j:=1 to plast.ky1 do writeln(ff,plast.ym1[j]);
  for i:=1 to plast.kz1 do
    begin
      write(ff,plast.zak1[i],' ');
      write(ff,plast.zak2[i],' ');
      writeln(ff,plast.zak3[i]);
    end;
//Plast - ������������ ������ ��� ����������� ���,��� ������ � ����� ����� � ������� nagruz
//  for j:=1 to plast.kl1 do
//    begin
//      write(ff,plast.nomm[j],' ');
//      write(ff,plast.os[j],' ');
//     write(ff,formatfloat('0',plast.nom11[j]),' ');   //iaa?ocea ii O
//      writeln(ff,formatfloat('0',plast.nom22[j]));  //iaa?ocea ii Y
//    end;
  for j:=1 to kl do
  for i:=1 to kt[j] do
  begin
  for k:=1 to 4 do
    begin
    write(ff,nagruz[j,i,k]);
    write(ff,' ');
    end;
  writeln(ff);
  end;

  writeln(ff,'�����������:');
  writeln(ff,plast.s_lin);
  writeln(ff,plast.s_for);

  CloseFile(ff);
end;
end;

procedure TPlast_Form.FileSave_MnuClick(Sender: TObject);
begin
  if not isNamed then FileSaveAs_MnuClick(Self)
   else
    begin
     SaveData;
     isChanged:=false;
    end; 
end;




procedure TPlast_Form.FileSaveAs_MnuClick(Sender: TObject);
begin
SaveCancel:=True;
SaveDialog.FileName:=FileName;
  if SaveDialog.Execute then
    begin
      FileName:=SaveDialog.FileName;
      Caption:=ExtractFileName(FileName);
      SaveData;
      isNamed:=true;
      isChanged:=false;
      SaveCancel:=False;
    end;
end;

procedure TPlast_Form.SimpleSolve_MnuClick(Sender: TObject);
type
  TMethodProc=procedure(fn:PChar);
var
  LibHandle:THandle;
  DllName:string;
  sp:TMethodProc;
  dopd,f5: system.text;
  ebsi:single;
  maxkit:integer;
  i,k,Flag:integer;

begin

  if (plast.kl1 = 0) or (plast.kz1 = 0) then
   begin
    Beep;
    MessageDlg('����������� ����������� �/��� ����.'+#10+#13+'������ ����������.',mtError,[mbOk],0);
    Exit;
   end;

  FileSave_MnuClick(Sender);
  if SaveCancel then exit;
  if not FileExists(Filename) then
   begin
    Beep;
    MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
    Exit;
   end;
        assignfile(f5,Filename);
        reset(f5);
        for i:=1 to 3 do
        readln(f5);
        readln(f5,ebsi);
        closefile(f5);
        assignfile(dopd,'dopdan.dan');
        rewrite(dopd);
        maxkit:=1;
        writeln(dopd,maxkit);
        writeln(dopd,ebsi);
        closefile(dopd);
  DllName:=ExtractFilePath(Application.ExeName)+'Plastina_r.dll';

  LibHandle:=LoadLibrary(PChar(DllName));
  if LibHandle=0 then
    begin
    beep;
      MessageDlg('��� ���������� Plastina_r.dll',mtError,[mbOk],0);
      Exit;
    end;
  @sp:=GetProcAddress(LibHandle,'Plastina');
  Cursor:=crHourGlass;
  try
    sp(PChar(Filename));
 { finally
    Cursor:=crDefault; }
  except
    messagedlg('������ � ��������� ������.'+#10+#13+'��� ����������� ������ ������������� �������.',mtError,[mbok],0);
  end;
   Cursor:=crDefault;
     erase(dopd);
  main_form.P2.Enabled:=true;
  main_form.P3.Enabled:=true;
//end of my insert
  //MessageDlg(chr(13)+'������ ��������.',mtInformation,[mbOk],0);
  Flag:=MessageDlg(chr(13)+'������ ��������. �������� ����������?' ,mtInformation,[mbYes,mbNo],0);
  if Flag=mrNo then
      begin
       //isChanged:=true;
       exit;
      end;
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).s_text_mnuClick(Sender);
  end;

 // end;


procedure TPlast_Form.SolveOpt_MnuClick(Sender: TObject);
type
  TMethodProc=procedure(fn:PChar);
var
  LibHandle:THandle;
  DllName:string;
  sp:TMethodProc;
  ebsi:single;
  maxkit,Flag:integer;
  dopd: system.text;
begin

 if (plast.kl1 = 0) or (plast.kz1 = 0) then
   begin
    Beep;
    MessageDlg('����������� ����������� �/��� ����.'+#10+#13+'������ ����������.',mtError,[mbOk],0);
    Exit;
   end;

   if isChanged then FileSave_MnuClick(Sender);
  if SaveCancel then exit;
  if not FileExists(FileName) then
   begin
    Beep;
    MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
    Exit;
   end;

  if not PlastOptParam_Form.Execute(ebsi,maxkit) then Exit;
       assignfile(dopd,'dopdan.dan');
        rewrite(dopd);
        writeln(dopd,maxkit);
        writeln(dopd,ebsi);

        closefile(dopd);

  DllName:=ExtractFilePath(Application.ExeName)+'plastina_r.dll';


  LibHandle:=LoadLibrary(PChar(DllName));
  if LibHandle=0 then
    begin
    beep;
      MessageDlg('��� ���������� plastina_r.dll',mtError,[mbOk],0);
      Exit;
    end;
  @sp:=GetProcAddress(LibHandle,'Plastina');
  Cursor:=crHourGlass;
  try
  sp(PChar(FileName));
 { finally
    Cursor:=crDefault; }
  except
    messagedlg('������ � ��������� ������.'+#10+#13+'��� ����������� ������ ������������� �������.',mtError,[mbok],0);
  end;
  Cursor:=crDefault;
  //MessageDlg(chr(13)+'������ ��������.',mtInformation,[mbOk],0);
  Flag:=MessageDlg(chr(13)+'������ ��������. �������� ����������?' ,mtInformation,[mbYes,mbNo],0);
  if Flag=mrNo then
      begin
       //isChanged:=true;
       exit;
      end;
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).o_text_mnuClick(Sender);
  main_form.P5.Enabled:=true;
  main_form.P6.Enabled:=true;

     erase(dopd);
end;

procedure TPlast_Form.FormDeactivate(Sender: TObject);
begin
 PaintBox.Cursor:=crDefault;
 PaintBox.ShowHint:=False;
 if Main_form.Del_Cut_Plast_Toolbutton.Down or Main_Form.Cut_Plast_Toolbutton.Down then
  begin
   RePaint;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr:=True;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld:=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld:=-1;
  end;

 Main_Form.Plast_Graph_Enter_Panel.Buttons[0].Down:=True;
 Main_Form.StatusBar1.Panels[0].Text :='';
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';
 //Main_Form.Caption:='����� - ������ 7.0 ��� Windows';
end;



//=====================================================
procedure TPlast_Form.PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  ux,uy,uxx,uyy,RealXReal,RealYReal:extended;
  What_Do,{x1,y1,}x2,y2,xtop,ytop,xbot,ybot,x_max,y_max:integer;
  RealX,RealY,RealX0,Realy0:extended;
  YLine:integer;
  max_x_coord,max_y_coord,mas_x,mas_y:extended;
  NodeStr,HelpStr:string;
  p:TPoint;
  i,j,nn:integer;
  x1_x,x2_x,y1_x,y2_x,cutOk_:integer;
  x1_y,x2_y,y1_y,y2_y:integer;
  cutIdent_,cut_msg:string;
begin

if Active then
 begin


  What_Do:=0;
  // ����� ������ ������ ?
  for i:=0 to main.Main_Form.Plast_Graph_Enter_Panel.ButtonCount-1 do
   begin
   if main.Main_Form.Plast_Graph_Enter_Panel.Buttons[i].Down = true then
    What_Do:=i;
   end;

  // ��� ����� ����� ��������� ������ ?
  p.x:=X;
  p.y:=Y;
  max_x_coord:=0;
  max_y_coord:=0;
  uxx:=0;
  uyy:=0;

  for i:=1 to plast.kx1 do
    begin
      if plast.xm1[i]>=max_x_coord then max_x_coord:=plast.xm1[i];
    end;
  for i:=1 to plast.ky1 do
    begin
      if plast.ym1[i]>=max_y_coord then max_y_coord:=plast.ym1[i];
    end;

  CurrentNode:=0;
  for i:=1 to plast.kx1 do
    for j:=1 to plast.ky1 do
      begin
        if plast.kx1>=plast.ky1 then nn:=j+(i-1)*plast.ky1
                                else nn:=i+(j-1)*plast.kx1;
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(plast.xm1[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(plast.ym1[j]);

        if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) then
          begin
            CurrentNode:=nn;
            uxx:=plast.xm1[i];
            uyy:=plast.ym1[j];
            Break;
          end;
      end;
       if (what_do<>0) then
      begin
         Main_Form.StatusBar1.Panels[1].Text :='';
         Main_Form.StatusBar1.Panels[2].Text :='';
      end;
      if (CurrentNode<>0) and (what_do<>0) then
      Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);

case What_Do of


0: //�������
   begin
     with paintbox do begin
      showhint:=false;
     end;
      cursor:=crDefault;

   end;

8:   // ���������� �� ���� (� �������� ��������)
begin
    Main_Form.StatusBar1.Panels[0].Text :='';
    Main_Form.StatusBar1.Panels[1].Text :='';
    if CurrentNode=0 then application.CancelHint;
    if CurrentNode<>0 then  {��� ��������}
      Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]) // ���������� �.�. 11.11.07
      {����� ���� ��������}// Plast_M.TPlast_Form(Main_form.ActiveMDIChild).paintbox.Hint:='���� � '+inttostr(CurrentNode);
    else      // ���������� �.�. 11.11.07
     begin   // ���������� �.�. 11.11.07
      x_max:=PaintBox.width;
      y_max:=PaintBox.height;
      mas_x:=(x_max-80-coord_axis_x)/max_x_coord; //�������������� ������������
      mas_y:=(y_max-60-coord_axis_y)/max_y_coord;
      {mas_x:=(x_max-80)/max_x_coord; //�������������� ������������
      mas_y:=(y_max-60)/max_y_coord; }
      for i:=1 to plast.kx1-1 do
      for j:=1 to plast.ky1-1 do
      begin
       if (X>=50+round(mas_x*plast.xm1[i])+coord_axis_x)and(X<=50+round(mas_x*plast.xm1[i+1])+coord_axis_x)and(Y<=y_max-30-round(mas_y*plast.ym1[j])-coord_axis_y)and(Y>=y_max-30-round(mas_y*plast.ym1[j+1])-coord_axis_y)then
        begin
         if plast.kx1>=plast.ky1 then nn:=j+(i-1)*(plast.ky1-1)
          else nn:=i+(j-1)*(plast.kx1-1);
          Main_Form.StatusBar1.Panels[1].Text := '�������� ������� �'+inttostr(nn);
          break;
       end;
     end; // ���������� �.�. 11.11.07
 end;
 //if (X>50+round(mas_x*plast.xm1[plast.kx1])+coord_axis_x)or(X<50+round(mas_x*plast.xm1[1])+coord_axis_x)or(Y<y_max-30-round(mas_y*plast.ym1[plast.ky1])-coord_axis_y)or(Y>y_max-30-round(mas_y*plast.ym1[1]))then
 //Main_Form.StatusBar1.Panels[1].Text := '';   ��������������� ���������� �.�. 11.11.07. ������ ������� ��
 // ��������� ������ '8:' ��� ������������ ���� �����.
end;



2:   //������ ��������������� ����� ��������
 begin

 // �������� ���������� ������� ����

    RealX:=(X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x);
    RealY:=(PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y);
    RealX0:=(Xold-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x);           //������
    RealY0:=(PaintBox.Height-Yold-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y);

    RealXReal:=Round(RealX);
    RealYReal:=Round(RealY);
    with PaintBox.canvas do
     begin
    pen.style:=psDash;
    pen.width:=1;
    pen.mode:=pmnotxor;
    pen.color:=clBlack;

    //!!! ������� ����� �� ������ �� ������� �������� !!!!!!!!!
    if (x<50) or (x>width-25) or (y<15) or (y>height-50) and (not zagr) then
        if (RealX0 <= max_x_coord) and (RealY0 <= max_y_coord) and (RealY0 >= 0) and (RealX0 >= 0) then
    begin
      moveto(Xold,PaintBox.Height-30-coord_axis_y);
      lineto(Xold,30);
      moveto(50+coord_axis_x,Yold);
      lineto(PaintBox.Width-30,Yold);
      xold:=-1;
      yold:=-1;
      zagr:=true;
      exit;
      end
      else if ((RealX0 > max_x_coord) or (RealX0 < 0))and((RealY0 <= max_y_coord) and (RealY0 >= 0)) then
      begin
        moveto(50+coord_axis_x,Yold);
      lineto(PaintBox.Width-30,Yold);
       xold:=-1;
      yold:=-1;
      zagr:=true;
            exit;
      end
      else if ((RealY0 > max_Y_coord) or (RealY0 < 0))and((RealX0 <= max_x_coord) and (RealX0 >= 0)) then
      begin
      moveto(Xold,PaintBox.Height-30-coord_axis_y);
      lineto(Xold,30);
       xold:=-1;
      yold:=-1;
      zagr:=true;
            exit;
      end;


    if (x<50) or (x>width-25) or (y<15) or (y>height-50) and (zagr) then
    begin
        xold:=-1;
        yold:=-1;
        exit;
    end;


  //c������ ������ �����
    if (RealX0 <= max_x_coord) and (RealY0 <= max_y_coord) and (RealY0 >= 0) and (RealX0 >= 0) and (not razbit) then
    begin
      moveto(Xold,PaintBox.Height-30-coord_axis_y);
      lineto(Xold,30);
      moveto(50+coord_axis_x,Yold);
      lineto(PaintBox.Width-30,Yold);
      end
      else if ((RealX0 > max_x_coord) or (RealX0 < 0))and((RealY0 <= max_y_coord) and (RealY0 >= 0)) and (not razbit) then
      begin
        moveto(50+coord_axis_x,Yold);
      lineto(PaintBox.Width-30,Yold);
      end
      else if ((RealY0 > max_Y_coord) or (RealY0 < 0))and((RealX0 <= max_x_coord) and (RealX0 >= 0)) and (not razbit) then
      begin
      moveto(Xold,PaintBox.Height-30-coord_axis_y);
      lineto(Xold,30);
      end;
      //������ ����� �����
      //if (x>10)and(x<width-10)and(y>10)and(y<Height-10)then

      if (RealX <= max_x_coord) and (RealY <= max_y_coord) and (RealY >= 0) and (RealX >= 0) then
    begin
      moveto(X,PaintBox.Height-30-coord_axis_y);
      lineto(X,30);
      moveto(50+coord_axis_x,Y);
      lineto(PaintBox.Width-30,Y);
      end
      else if ((RealX > max_x_coord) or (RealX < 0))and((RealY <= max_y_coord) and (RealY >= 0)) then
      begin
        moveto(50+coord_axis_x,Y);
      lineto(PaintBox.Width-30,Y);
      end
      else if ((RealY > max_Y_coord) or (RealY < 0))and((RealX <= max_x_coord) and (RealX >= 0)) then
      begin
      moveto(X,PaintBox.Height-30-coord_axis_y);
      lineto(X,30);
      end;
     pen.mode:=pmcopy;
     end;
     Xold:=x;
     yold:=y;
     razbit:=false;
     zagr:=false;

      //������� ����������

      if (RealXReal>=0) and (RealYReal>=0) and (RealXReal<=plast.xm1[plast.kx1]) and (RealYReal<=plast.ym1[plast.ky1]) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal])
      else if (RealXReal<=plast.xm1[plast.kx1]) and (RealXReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : -]', [RealXReal])
      else if (RealYReal<=plast.ym1[plast.ky1]) and (RealYReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[- : %g]', [RealYReal])
      else
       Main_Form.StatusBar1.Panels[0].Text := '[- : -]';


   end; // ����� Case '2'


  3: //������� ��������
  begin
RealX:=Round((X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));
    RealY:=Round((PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));
    //RealX0:=Round((Xold-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));           //������
    //RealY0:=Round((PaintBox.Height-Yold-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));

    RealXReal:=RealX;
    RealYReal:=RealY;

    x_max:=PaintBox.width;
    y_max:=PaintBox.height;
    mas_x:=(x_max-80-coord_axis_x)/max_x_coord; //�������������� ������������
    mas_y:=(y_max-60-coord_axis_y)/max_y_coord;

//========== ������� �������� ==============
    j:=0;
    cutOk_:=0;
    cutIdent_:='';
    cut_msg:='';
    x1_x:=-1;
    x2_x:=-1;
    y1_x:=-1;
    y2_x:=-1;
     for i:=2 to plast.kx1-1 do
     begin
        //� ��������� �� ����������� ������������� ???
        ux:=50+coord_axis_x+(width-91-coord_axis_x)/max_x_coord*(plast.xm1[i]);
        if (X>ux-4)and(X<ux+4) then
          begin
            //Cursor:=crhandpoint;
            cutIdent_:=inttostr(i)+'x';
            cutOk_:=1;
            cut_msg:='������� ���� �� X ['+FloatToStr(plast.xm1[i])+' : -]';
            x1_x:=50+coord_axis_x+round(mas_x*plast.xm1[i]);
            x2_x:=50+coord_axis_x+round(mas_x*plast.xm1[i]);
            y1_x:=y_max-30-coord_axis_y-round(mas_y*plast.ym1[plast.ky1]);
            y2_x:=y_max-30-coord_axis_y;
            //inc(j);
            Break;
          end;
      end;

    x1_y:=-1;
    x2_y:=-1;
    y1_y:=-1;
    y2_y:=-1;
    //i:=j;
    for j:=2 to plast.ky1-1 do
      begin
        //� ��������� �� ����������� ������������� ???
        uy:=height-61-coord_axis_y-(height-91-coord_axis_y)/max_y_coord*(plast.ym1[j]);
        if (Y>uy-4)and(Y<uy+4) then
          begin
            //Cursor:=crhandpoint;
            cutIdent_:=inttostr(j)+'y'+cutIdent_;
            cutOk_:=1;
            if cut_msg='' then
             cut_msg:='������� ���� �� Y [- :'+FloatToStr(plast.ym1[j])+']'
            else
             cut_msg:='������� ���� �� XY ['+FloatToStr(plast.xm1[i])+' : '+FloatToStr(plast.ym1[j])+']';
            x1_y:=50+coord_axis_x+round(mas_x*plast.xm1[plast.kx1]);
            x2_y:=50+coord_axis_x;
            y1_y:=y_max-30-coord_axis_y-round(mas_y*plast.ym1[j]);
            y2_y:=y_max-30-coord_axis_y-round(mas_y*plast.ym1[j]);
            //inc(i);
            Break;
          end;
      end;
     //if i=0 then Cursor:=crdefault;
//===================== C������� �������� ==================

      if (RealXReal>=0) and (RealYReal>=0) and (RealXReal<=plast.xm1[plast.kx1]) and (RealYReal<=plast.ym1[plast.ky1]) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal])
      else if (RealXReal<=plast.xm1[plast.kx1]) and (RealXReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : -]', [RealXReal])
      else if (RealYReal<=plast.ym1[plast.ky1]) and (RealYReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[- : %g]', [RealYReal])
      else
       Main_Form.StatusBar1.Panels[0].Text := '[- : -]';

Main_Form.StatusBar1.Panels[1].Text:=cut_msg;

Paintbox.Canvas.Pen.Mode:=pmNotXor;
Paintbox.Canvas.Pen.Color:=clBlue;
Paintbox.Canvas.Pen.Width:=3;
  if (cutOk_=1) and (cutIdent<>'')  then
   begin
    if cutIdent<>cutIdent_ then
     begin
      Paintbox.Canvas.MoveTo(cutX1_x, cutY1_x);
      Paintbox.Canvas.LineTo(cutX2_x, cutY2_x);
      Paintbox.Canvas.MoveTo(X1_x, Y1_x);
      Paintbox.Canvas.LineTo(X2_x, Y2_x);
      Paintbox.Canvas.MoveTo(cutX1_y, cutY1_y);
      Paintbox.Canvas.LineTo(cutX2_y, cutY2_y);
      Paintbox.Canvas.MoveTo(X1_y, Y1_y);
      Paintbox.Canvas.LineTo(X2_y, Y2_y);
      cutIdent:=cutIdent_;
      cutX1_x:=X1_x;cutX2_x:=X2_x;cutY1_x:=Y1_x;cutY2_x:=Y2_x;
      cutX1_y:=X1_y;cutX2_y:=X2_y;cutY1_y:=Y1_y;cutY2_y:=Y2_y;
     end;
   end
  else if (cutOk_=1) and (cutIdent='') then
   begin
    Paintbox.Canvas.MoveTo(X1_x, Y1_x);
    Paintbox.Canvas.LineTo(X2_x, Y2_x);
    Paintbox.Canvas.MoveTo(X1_y, Y1_y);
    Paintbox.Canvas.LineTo(X2_y, Y2_y);
    cutIdent:=cutIdent_;
    cutX1_x:=X1_x;cutX2_x:=X2_x;cutY1_x:=Y1_x;cutY2_x:=Y2_x;
    cutX1_y:=X1_y;cutX2_y:=X2_y;cutY1_y:=Y1_y;cutY2_y:=Y2_y;
   end
  else if (cutOk_=0) and (cutIdent<>'') then
   begin
    Paintbox.Canvas.MoveTo(cutX1_x, cutY1_x);
    Paintbox.Canvas.LineTo(cutX2_x, cutY2_x);
    Paintbox.Canvas.MoveTo(cutX1_y, cutY1_y);
    Paintbox.Canvas.LineTo(cutX2_y, cutY2_y);
    cutIdent:='';
    Main_Form.StatusBar1.Panels[1].Text := '';
   end
  else
   begin
    Main_Form.StatusBar1.Panels[1].Text := '';
   end;

Paintbox.Canvas.Pen.Width:=1;
Paintbox.Canvas.Pen.Mode:=pmCopy;

 end; // ����� Case '3'

 end;  // ����� Case
end;  // ����� 'Aktive'
//============================================================================//

end; // ����� '���������'




procedure TPlast_Form.FormShow(Sender: TObject);
begin
 //width:=360;height:=260;
 Width  := Ceil(360*Main_Form.Width_Ratio);
 Height := Ceil(260*Main_Form.Height_Ratio);
end;

procedure TPlast_Form.s_text_mnuClick(Sender: TObject);
var
 nf:boolean;
 Version_VYV:string;
 f1:System.text;
 ff:File of Byte;
 mg:integer;
begin

// �������� �� ������������� ������ �������
  if FileExists(ChangeFileExt(FileName,'.vrp'))and FileExists(ChangeFileExt(FileName,'.ww0'))and FileExists(ChangeFileExt(FileName,'.ww1'))and FileExists(ChangeFileExt(FileName,'.ww2'))and FileExists(ChangeFileExt(FileName,'.ww')) then
    begin
      AssignFile(f1,ChangeFileExt(FileName,'.vrp'));
      Reset(f1);
      ReadLn(f1,Version_VYV);
      CloseFile(f1);
    end
  else Version_VYV:='Error';

  if Version_VYV='Error' then
   begin
    Beep;
    MessageDlg(#13+'����� � ������� �������� �� �������.',mtError,[mbOk],0);
    exit;
   end;

// �������� �� ������������� ������ ������ ������ � �������� ��������
if FileExists(FileName) then
 begin
  Assignfile(ff,FileName);
  Reset(ff);
  mg:=filesize(ff);
  CloseFile(ff);
 end
else
 begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#10+#13+'����������� ������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
 end;

 if ((Version_VYV)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
     or (isChanged=True) then
  begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#10+#13+'����������� ������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
  end;

 // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 nf:=false;
 if not main_form.NodesNum.Checked then
 begin
  repaint;
 nf:=true;
 end;
 plast_rez_Form.Execute(FileName,'.vrp');
  if nf then begin main_form.NodesNum.Checked:=false;  repaint; end;
end;

procedure TPlast_Form.o_text_mnuClick(Sender: TObject);
var
{f:system.text;
imechko,str1,str2,str3:string;  }
nf:boolean;
 Version_VYV:string;
 f1:System.text;
 ff:File of Byte;
 mg:integer;
begin

// �������� �� ������������� ������ �������
  if FileExists(ChangeFileExt(FileName,'.vop'))and FileExists(ChangeFileExt(FileName,'.w0'))and FileExists(ChangeFileExt(FileName,'.w1'))and FileExists(ChangeFileExt(FileName,'.w2'))and FileExists(ChangeFileExt(FileName,'.w')) then
    begin
      AssignFile(f1,ChangeFileExt(FileName,'.vop'));
      Reset(f1);
      ReadLn(f1,Version_VYV);
      CloseFile(f1);
    end
  else Version_VYV:='Error';

  if Version_VYV='Error' then
   begin
    Beep;
    MessageDlg(#13+'����� � ��������������� �������� �� �������.',mtError,[mbOk],0);
    exit;
   end;

// �������� �� ������������� ������ ������ ������ � ���������������� ��������
if FileExists(FileName) then
 begin
  Assignfile(ff,FileName);
  Reset(ff);
  mg:=filesize(ff);
  CloseFile(ff);
 end
else
 begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#10+#13+'����������� ��������������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
 end;

 if ((Version_VYV)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
     or (isChanged=True) then
  begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#10+#13+'����������� ��������������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
  end;

   nf:=false;
 if not main_form.NodesNum.Checked then
 begin
  //main_form.PlastNumberButtonClick(sender);
  main_form.NodesNum.Checked:=true;
  repaint;
  nf:=true;
 end;
 plast_rez_Form.Execute(FileName,'.vop');
  if nf then begin main_form.NodesNum.Checked:=false;  repaint; end;

end;

procedure TPlast_Form.N16Click(Sender: TObject);
begin
  // ����� ��������
  Main_Form.NewPlast_MnuClick(Sender);
end;

procedure TPlast_Form.N4Click(Sender: TObject);
begin
//   ����� TOK
 Main_Form.NewTOK_MnuClick(Sender);
end;

procedure TPlast_Form.SimpleResults_MnuClick(Sender: TObject);
 var
Version_VYV:string;
 f1:System.text;
 ff:File of Byte;
 mg,k:integer;
begin
begin
  Visio_Form.plast:=plast;
  // �������� �� ������������� ������ �������
  if FileExists(ChangeFileExt(Filename,'.vrp'))and FileExists(ChangeFileExt(Filename,'.ww0'))and FileExists(ChangeFileExt(Filename,'.ww1'))and FileExists(ChangeFileExt(Filename,'.ww2'))and FileExists(ChangeFileExt(Filename,'.ww')) then
    begin
      AssignFile(f1,ChangeFileExt(Filename,'.vrp'));
      Reset(f1);
      ReadLn(f1,Version_VYV);
      CloseFile(f1);
    end
  else Version_VYV:='Error';

  if Version_VYV='Error' then
   begin
    Beep;
    MessageDlg(#13+'����� � ������� �������� �� �������.',mtError,[mbOk],0);
    exit;
   end;

// �������� �� ������������� ������ ������ ������ � �������� ��������
if FileExists(Filename) then
 begin
  Assignfile(ff,Filename);
  Reset(ff);
  mg:=filesize(ff);
  CloseFile(ff);
 end
else
 begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#10+#13+'����������� ������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
 end;

 if ((Version_VYV)<>(ExtractFilename(Filename)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(Filename)))))
     or (isChanged=True) then
  begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#10+#13+'����������� ������� ������ ��� ������ ��������.',mtError,[mbOk],0);
    exit;
  end;

  Visio_Form.num_value:=4;// ������������� ����������
  Visio_Form.num_rast:=0; //������� ������
  Visio_Form.ToolButton.ImageIndex:=0;
  Visio_Form.ff:=False;
  Visio_Form.LoadData(Filename);

       main_form.SimpleSolve_eq.Checked:=true;
       main_form.SimpleSolve_x.Checked:=false;
       main_form.SimpleSolve_y.Checked:=false;
       main_form.SimpleSolve_kas.Checked:=false;
       Visio_Form.panel1.Enabled:=True;
       Visio_Form.Panel1.Visible:=True;
       Visio_Form.fnn:=Filename;
       Visio_Form.to_read_or_not_to_read:=true;// ������ �������� �����
       Visio_Form.ShowModal
end;
end;

procedure TPlast_Form.Real_Coord_PUMPopup(Sender: TObject);
var
 w,h:integer;
begin


 if (plast.xm1[plast.kx1]>plast.ym1[plast.ky1]) then
  begin
    h:=260;
    w:=Round((h-75)*plast.xm1[plast.kx1]/plast.ym1[plast.ky1])+123;
    if w<360 then w:=360;
    h:=Round((w-123)*plast.ym1[plast.ky1]/plast.xm1[plast.kx1])+75;
  end
 else
  begin
    w:=360;
    h:=Round((w-123)*plast.ym1[plast.ky1]/plast.xm1[plast.kx1])+75;
  end;

 if (w>screen.Width) or (h>screen.Height)then
  Real_Coord_PUM.Items[0].Enabled:=False
 else
  Real_Coord_PUM.Items[0].Enabled:=True;



end;

procedure TPlast_Form.real_sizeClick(Sender: TObject);
var
 w,h:integer;
begin


 if (plast.xm1[plast.kx1]>plast.ym1[plast.ky1]) then
  begin
    h:=260;
    w:=Round((h-75)*plast.xm1[plast.kx1]/plast.ym1[plast.ky1])+123;
    if w<360 then w:=360;
    h:=Round((w-123)*plast.ym1[plast.ky1]/plast.xm1[plast.kx1])+75;
  end
 else
  begin
    w:=360;
    h:=Round((w-123)*plast.ym1[plast.ky1]/plast.xm1[plast.kx1])+75;
  end;
WindowState:=wsNormal;
if (ClientWidth=w) and (ClientHeight=h) then exit
else
 begin
  CW:=ClientWidth;
  CH:=ClientHeight;
  ClientWidth:=w;
  ClientHeight:=h;
 end
end;

procedure TPlast_Form.N3Click(Sender: TObject);
var
        fff:System.text;
        s1,s:string;
begin
//������ ������� ��� ��� ������� �� .oup ������ �������� �� .vrp

        if FileExists(ChangeFileExt(FileName,'.vrp')) then
        begin
                AssignFile(fff,ChangeFileExt(FileName,'.vrp'));
                reset(fff);
     repeat
                readln(fff,s1);
if (s1 = 'C��. ��� ����. ���. ������.:') then readln(fff,s);

     until(eof(fff)=true);
//                readln(fff);
//                readln(fff,s);
                messageDlg('������� ��� ����������� �����'+#10+#13+#10+#13+'P ='+s+' [�*��]',mtInformation,[mbOk],0);


                CloseFile(fff);
        end
        else    messageDlg('��������� ���������� ������� ������ ��������',mtError,[mbOk],0);

end;

// ����������� ������� ���� ��� ������ ����������� ������� ---------------------
procedure TPlast_Form.MouseLeft;
begin
 Repaint;
 Canvas.CopyRect(Rect(0,0,pFormBMP.Width,pFormBMP.Height),
  pFormBMP.Canvas,Rect(0,0,pFormBMP.Width,pFormBMP.Height));
end;


procedure TPlast_Form.MouseIsDown(MX,MY: Integer);
begin
 pMDown:=True;
 pMouseX1:=MX;
 pMouseY1:=MY;
 Canvas.Pen.Color:=clBlue;
 MouseLeft;
end;

procedure TPlast_Form.MouseIsMove(MX,MY: Integer);
begin
 if pMDown then
  begin
   Repaint;
   with Canvas do
    begin
     CopyRect(Rect(0,0,pFormBMP.Width,pFormBMP.Height),
      pFormBMP.Canvas,Rect(0,0,pFormBMP.Width,pFormBMP.Height));
     MoveTo(pMouseX1,pMouseY1);
     LineTo(MX,pMouseY1);
     LineTo(MX,MY);
     LineTo(pMouseX1,MY);
     LineTo(pMouseX1,pMouseY1);
    end;
  end;
end;

procedure TPlast_Form.MouseIsUp(MX,MY: Integer);
var
 Temp: Integer;
begin
 pMDown:=False;
 pMouseX2:=MX;
 pMouseY2:=MY;
 if pMouseX2<pMouseX1 then
  begin
   Temp:=pMouseX1;
   pMouseX1:=pMouseX2;
   pMouseX2:=Temp;
  end;
 if pMouseY2<pMouseY1 then
  begin
   Temp:=pMouseY1;
   pMouseY1:=pMouseY2;
   pMouseY2:=Temp;
  end;
 if (pMouseX1<>pMouseX2) or (pMouseY1<>pMouseY2) then pSelectionIsOK:=True
 else pSelectionIsOK:=False;
end;


// ���������� ������������ ������ ����������� �������� -------------------------
procedure TPlast_Form.SelectionMode(Activate: Boolean);
var
 BMP: TBitmap;
 i,j: Integer;
begin
// ���� �������� �����:
 if Activate then
  begin
    if AutoSize then
     begin
      AutoSize:=False;
      pASize:=True;
     end
    else
     pASize:=False;
   BMP:=TBitmap.Create;
   BMP.Width:=ClientWidth;
   BMP.Height:=ClientHeight;
   pFormBMP.Width:=BMP.Width;
   pFormBMP.Height:=BMP.Height;
   BMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   SetLength(pControlsArray,ControlCount);
   for i:=0 to ControlCount-1 do
    begin
     if Controls[i].Visible then
      begin
       Controls[i].Visible:=False;
       pControlsArray[i]:=True;
      end
     else pControlsArray[i]:=False;
    end;
   pFSize[0]:=Width;
   pFSize[1]:=Height;
   pBStyle:=BorderStyle;
   BorderStyle:=bsSingle;
   pBIcons:=BorderIcons;
   BorderIcons:=[biSystemMenu];
   Width:=pFSize[0];
   Height:=pFSize[1];
   Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   pFormBMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   BMP.Free;
   PopupMenu:=Real_Coord_PUM;
  end
// ��� �� ���� ���������:
 else
  begin
   for i:=0 to ControlCount-1 do
    begin
     if pControlsArray[i]=True then
      begin
       Controls[i].Visible:=True;
      end;
    end;
   Repaint;
   pFormBMP.Width:=0;
   pFormBMP.Height:=0;
   SetLength(pControlsArray,0);
   pFSize[0]:=Width;
   pFSize[1]:=Height;
   BorderStyle:=pBStyle;
   BorderIcons:=pBIcons;
   Width:=pFSize[0];
   Height:=pFSize[1];
    if pASize then
     begin
      AutoSize:=True;
      pASize:=False;
     end;
   PopupMenu:=nil;
  end;
end;

// ������� � ����� -------------------------------------------------------------
procedure TPlast_Form.PutToAccount;
var
 OleFileName,OleUnit,OleExtend: OleVariant;
 Bmp: TBitmap;
begin
 Bmp:=TBitmap.Create;

 Bmp.Canvas.CopyMode:=cmSrcCopy;
 if pSelectionIsOK then
  begin
   Bmp.Width:=pMouseX2-pMouseX1;
   Bmp.Height:=pMouseY2-pMouseY1;
   Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
    pFormBMP.Canvas,Rect(pMouseX1+1,pMouseY1+1,pMouseX2,pMouseY2));
  end
 else
  begin
   Bmp.Width:=ClientWidth;
   Bmp.Height:=ClientHeight+20;
   Bmp.Canvas.CopyRect(Rect(0,20,Bmp.Width,Bmp.Height),
    Canvas,Rect(0,0,Bmp.Width,Bmp.Height-20));
   Bmp.Canvas.Brush.Color:=clBtnFace;
   Bmp.Canvas.FillRect(Rect(0,0,Bmp.Width,20));
   Bmp.Canvas.TextOut(7,3,Caption);
  end;

 OleFileName:=DOCFullName;
 OleUnit:=wdStory;
 OleExtend:=wdMove;

 WordApplication1.Connect;

 WordApplication1.Documents.Open(OleFileName,EmptyParam,EmptyParam,EmptyParam,
  EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
   EmptyParam);
 WordApplication1.Visible:=True;
 WordApplication1.Options.CheckSpellingAsYouType:=False;
 WordApplication1.Options.CheckGrammarAsYouType:=False;

// ����������� ����������� ����� � �����:
 WordApplication1.Selection.EndOf(OleUnit,OleExtend);
 WordApplication1.Selection.TypeParagraph;
 WordApplication1.Selection.TypeParagraph;
 Clipboard();
 Clipboard.Assign(Bmp);
 WordApplication1.Selection.Paste;
 Clipboard.Clear;
 Clipboard.Free;

 Bmp.Free;

 WordApplication1.ActiveDocument.Save;
 WordApplication1.Disconnect;

 pSelectionIsCopied:=True;
 pSelectionIsOK:=False;

 Repaint;
end;


// ���������� ������� ----------------------------------------------------------
procedure TPlast_Form.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (pSelection) and (Button=mbRight) then
  MouseIsDown(X,Y);
 if (pSelection) and (Button=mbLeft) then
  MouseLeft;
end;

procedure TPlast_Form.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Main_Form.Ferma_Panel.Height := 32;
end;

procedure TPlast_Form.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (pSelection) and (Button=mbRight) then
  MouseIsUp(X,Y);
end;

procedure TPlast_Form.N10Click(Sender: TObject);
begin
 if not N10.Checked then
  begin
   pSelection:=True;
   SelectionMode(True);
   N10.Checked:=True;
   real_size.Enabled:=False;
  end
 else
  begin
   pSelection:=False;
   SelectionMode(False);
   N10.Checked:=False;
   real_size.Enabled:=True;
  end;
end;

//------
procedure TPlast_Form.PrepareForModule;
var
 AFromDir, AToDir: string; //������ � ������� ��� �����������
 FSearchRec,DSearchRec: TSearchRec;
 FindResult: Integer;
begin
try
 AFromDir:=ExtractFilePath(FileName)+'*.*';
 AToDir:=ExtractFilePath(Application.ExeName)+'Modules\CurPlast\';

// ���� � ����� ��� ������� �����-���� �����, �� ������� �� ���:
 FindResult:=FindFirst(AToDir+'*.*',faAnyFile+faHidden+
  faSysFile+faArchive+faReadOnly,FSearchRec);
 try
  while FindResult=0 do
   begin
    DeleteFile(AToDir+FSearchRec.Name);
    FindResult:=FindNext(FSearchRec);
   end;
 finally
  FindClose(FSearchRec);
 end;

// �������� ����� �������� ������� � ���� �����:
 CopyDirectoryTree(Handle,AFromDir,AToDir);

// ��������������� �����:
 FindResult:=FindFirst(AToDir+'*.*',faAnyFile+faHidden+
  faSysFile+faArchive+faReadOnly,FSearchRec);
 try
  while FindResult=0 do
   begin
    RenameFile(AToDir+FSearchRec.Name,
     AToDir+'CurPlast'+ExtractFileExt(AToDir+FSearchRec.Name));
    FindResult:=FindNext(FSearchRec);
   end;
 finally
  FindClose(FSearchRec);
 end;
 Application.MessageBox('������ ������������!','�������� ���������');
  if Main_Form.N17.Checked then
   begin
    FilesList_Form.Caption:='������ ������ ��������, ��������: "'+Copy(Caption,0,Length(Caption)-4)+'"';
    FilesList_Form.FileListBox1.ApplyFilePath(ExtractFilePath(Application.ExeName)+'Modules\CurPlast\');
    FilesList_Form.Show;
   end;
except
 Application.MessageBox('��������� ����������� ������!','������');
end;
end;

procedure TPlast_Form.CopyDirectoryTree(AHandle: HWND;
 const AFromDirectory, AToDirectory: string);
var
 SHFileOpStruct: TSHFileOpStruct;
 FromDir: PChar;
 ToDir: PChar;
begin
 GetMem(FromDir,Length(AFromDirectory)+2);
 try
  GetMem(ToDir,Length(AToDirectory)+2);
  try

   FillChar(FromDir^,Length(AFromDirectory)+2,0);
   FillChar(ToDir^,Length(AToDirectory)+2,0);

   StrCopy(FromDir,PChar(AFromDirectory));
   StrCopy(ToDir,PChar(AToDirectory));

   with SHFileOpStruct do
    begin
     Wnd:=AHandle;
     wFunc:=FO_COPY;
     pFrom:=FromDir;
     pTo:=ToDir;
     fFlags:=FOF_NOCONFIRMATION or FOF_RENAMEONCOLLISION;
     fAnyOperationsAborted:=False;
     hNameMappings:=nil;
     lpszProgressTitle:=nil;
      if SHFileOperation(SHFileOpStruct)<>0 then RaiseLastWin32Error;
    end;
  finally
   FreeMem(ToDir,Length(AToDirectory)+2);
  end;
 finally
  FreeMem(FromDir,Length(AFromDirectory)+2);
 end;
end;

procedure TPlast_Form.MenuItem1Click(Sender: TObject);
begin
PutToAccount;
end;
procedure TPlast_Form.N8Click(Sender: TObject);
begin
ClientWidth :=CW;
ClientHeight:=CH;
end;

end.
