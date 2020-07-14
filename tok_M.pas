unit Tok_M;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Ferm_Dat, StdCtrls, OleServer, WordXP, Variants, Clipbrd,
  ShellAPI, Buffer, Math, Word2000;



type
 Ttok_Form = class(TForm)
    PaintBox: TPaintBox;
    Bevel1: TBevel;
    tok_PopUp: TPopupMenu;
    ForceNode_PMnu: TMenuItem;
    FixNode_PMnu: TMenuItem;
    SaveDialog: TSaveDialog;
    Razm: TLabel;
    N5: TMenuItem;
    zad_pmnu: TMenuItem;
    WordApplication1: TWordApplication;
    Real_Coord_PUM: TPopupMenu;
    real_size: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    N10: TMenuItem;
    Panel1: TPanel;
    Tok_Label: TLabel;
    TOK_Edit: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure FileSave_MnuClick(Sender: TObject);
    procedure FileSaveAs_MnuClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SimpleSolve_MnuClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure zad_pmnuClick(Sender: TObject);
    procedure FixNode_PMnuClick(Sender: TObject);
    procedure ForceNode_PMnuClick(Sender: TObject);
    procedure Real_Coord_PUMPopup(Sender: TObject);
    procedure real_sizeClick(Sender: TObject);



    procedure N10Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure MouseLeft;
    procedure MouseIsDown(MX,MY: Integer);
    procedure MouseIsMove(MX,MY: Integer);
    procedure MouseIsUp(MX,MY: Integer);
    procedure SelectionMode(Activate: Boolean);
    procedure PutToAccount;
    procedure PrepareForModule;
    procedure CopyDirectoryTree(AHandle: HWND;
    const AFromDirectory, AToDirectory: string);
    procedure N6Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N8Click(Sender: TObject);


  private
           tMouseX1,tMouseY1,tMouseX2,tMouseY2: Integer;
           tMDown: Boolean;
           tSelection: Boolean;
           tSelectionIsOK: Boolean;
           tSelectionIsCopied: Boolean;
           tControlsArray: array of boolean;
           tFormBMP: TBitmap;
           tBStyle: TFormBorderStyle;
           tBIcons: TBorderIcons;
           tFSize: array [0..1] of Integer;
           tASize: Boolean;

           {procedure WM_HotKeyHandler (var Message: TMessage);
           message WM_HOTKEY;} //commented by �������� �.

    procedure LoadData;
    procedure SaveData;
  public
    { Public declarations }
    tok:Ttok;
    buf:Tbuffer;
    FileName:string;         // ��� ����� � �������
    isChanged:boolean;
    isNamed:boolean;
    SaveCancel:boolean;       // �������� �� �� ���������� ?
    CurrentNode:integer;     // ����, �� ������� �������� ��������� ���
    Xtok,Ytok :integer;      // ���������� ���� (���������� � Tok_Fix_Node)
    popa:boolean;            // ���� �� ���������� PopUp ?
    CW,CH: integer;
    Other_MDopNapr,Other_MModUpr,Other_MKoefPuass:extended;    // ���������� ��� �������� ������������(����������) ���������
    Xold,yold:integer;  //������ ���������� ��������������� �����
    razbit:boolean; //=true, ���� �������� ������ ��� ���������
    zagr:boolean; //=true, ���� ������ �� �������� �������� � ������
    nu:integer;  //����� �������� ������������ ����
    sn:integer; // ������ ����������

    constructor NewFile(Owner:TComponent;t:Ttok);
    constructor OpenFile(Owner:TComponent;Fn:string);

    procedure force_draw_for_tok(x_max,y_max:integer;mas_x,mas_y:single);
    procedure bound_draw_for_tok(x_max,y_max:integer;mas_x,mas_y:single);
    procedure tok_number;


  end;

 const
      coord_axis_x=30;
      coord_axis_y=15;

var
  tok_Form: Ttok_Form;


implementation

uses Main, Visio, Fix_node, ForcNode, PlastOptParam, Plast_FD, plast_rez, Ferma_FD, TOK_FD,
  TOK_Rez, TokZad, tokFix_node, tokForceNode, FilesList;

{$R *.DFM}
{procedure TToK_Form.WM_HotKeyHandler (var Message: TMessage);
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
  FileSaveas_Mnu.click;
  inherited;
end; } //commented by �������� �.

constructor Ttok_Form.NewFile(Owner:TComponent;t:Ttok);
var
i: integer;
begin
  Create(Owner);
  Tok:=t;
  FileName:='noname.tok';
  Caption:=ExtractFileName(FileName);
//  Tag:=1;            // ������ ����������
    t.nx:=6;   // ��������� �� �
    t.ny:=6;   // ��������� �� Y
    t.nsm:=0;  // ������� ����������
    t.eu:=7000000; //������ ���������
    t.zad[1]:=0;
    t.zad[2]:=0;
    t.zad[3]:=0;
    t.zad[4]:=0;
    t.n_nu:=0; // ����� ����������� �����
    t.n_nuz[1]:=0; // ����� ����������� �����, ������ 1
    t.n_nuz[2]:=0; // ����� ����������� �����, ������ 2
    t.n_nuz[3]:=0; // ����� ����������� �����, ������ 3
    t.n_zu:=0; // ����� ������������ �����
    t.xm[37]:=200;
    t.ym[37]:=200;
       for i:=1 to 36 do
        begin
         t.xm[i]:=0;
         t.ym[i]:=0;
         t.pn[i,1]:=0;
         t.pn[i,2]:=0;
        end;
    t.s_lin:='��';
    t.s_for:='�';
  FileName:='noname'+IntToStr(Main_Form.Num_Nonamed_tok)+'.tok';
  Main_Form.Num_Nonamed_tok:=Main_Form.Num_Nonamed_tok+1;
  Caption:=ExtractFileName(FileName);
  Main_Form.T2.Enabled:=false;
  FormActivate(Self);
  isChanged:=true;
  isNamed:=false;
  sn:=0;
  buf:=Tbuffer.CreateT(tok);
end;

constructor Ttok_Form.OpenFile(Owner:TComponent;Fn:string);
begin
  Create(Owner);
  tok:=Ttok.Create;
  FileName:=Fn;
  LoadData;
  Caption:=ExtractFileName(FileName);
  if not FileExists(ChangeFileExt(FileName,'.out')) then
  begin
  Main_FOrm.T2.Enabled:=false;
  end
  else begin
  Main_Form.T2.Enabled:=true;
  end;
  FormActivate(Self);
  isChanged:=false;
  isNamed:=true;
  buf:=Tbuffer.CreateT(tok);
end;



procedure Ttok_Form.FileSave_MnuClick(Sender: TObject);
begin

  if not isNamed then FileSaveAs_MnuClick(Self)
   else
    begin
     SaveData;
     isChanged:=false;
    end;

end;



procedure Ttok_Form.FileSaveAs_MnuClick(Sender: TObject);
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



procedure Ttok_Form.LoadData;
var
  ff: System.Text;
  i,j:integer;
  s,s1,s2:string;
begin
  AssignFile(ff,FileName);
  Reset(ff);
  readln(ff,tok.nx);
  readln(ff,tok.ny);
  readln(ff,tok.nsm);
  readln(ff,tok.eu);
  readln(ff,tok.zad[1]);
  readln(ff,tok.zad[2]);
  readln(ff,tok.zad[3]);
  readln(ff,tok.zad[4]);
  readln(ff,tok.n_nu);
  readln(ff,tok.n_zu);

  for j:=1 to 37 do begin
  read (ff,tok.xm[j]);readln(ff,tok.ym[j]);end;
  for i:=1 to 36 do begin
  readln(ff,s);
  s1:=copy(s,1,10);val(s1,tok.pn[i,1],j);
  s2:=copy(s,11,10);val(s2,tok.pn[i,2],j);
  end;
  tok.s_lin:='';
  tok.s_for:='';
  readln(ff,tok.s_lin);
  readln(ff,tok.s_for);
  CloseFile(ff);

  for i:=1 to 3 do
   tok.n_nuz[i]:=0;
  for i:=1 to 3 do
   for j:=1 to 9 do
    if (tok.pn[(i-1)*9+j,1]<>0) or (tok.pn[(i-1)*9+j,2]<>0) then
     tok.n_nuz[i]:=tok.n_nuz[i]+1;

end;



procedure Ttok_Form.SaveData;
var
  ff: System.Text;
  {i,}j:integer;
begin
  AssignFile(ff,FileName);
  Rewrite(ff);
  writeln(ff,tok.nx);
  writeln(ff,tok.ny);
  writeln(ff,tok.nsm);
  writeln(ff,tok.eu);
  writeln(ff,tok.zad[1]);
  writeln(ff,tok.zad[2]);
  writeln(ff,tok.zad[3]);
  writeln(ff,tok.zad[4]);
  writeln(ff,tok.n_nu);
  writeln(ff,tok.n_zu);
  for j:=1 to 37 do writeln(ff,tok.xm[j],tok.ym[j]);
  for j:=1 to 36 do writeln(ff,tok.pn[j,1]:10,tok.pn[j,2]:10);
  writeln(ff,tok.s_lin);
  writeln(ff,tok.s_for);

  CloseFile(ff);
end;




procedure Ttok_Form.FormCreate(Sender: TObject);
{var
i: integer;}
begin
    main_form.Tok_Inform_Toolbutton.down:=false;
     Main_Form.Sn_Cbx.ItemIndex:=0;
     tok_fd_form.Nagr_Nagr_ComboBox.ItemIndex:=0;
     sn:=0{1};
  isChanged:=false;
  Resize;
 {     //������������� ������� ������
 keyid:=GlobalAddAtom('My Hotkey'); //������� ����
 RegisterHotKey(handle,
 // ��������� � HotKey ����� �������� �����
 keyid, // ������������ ���� ��� id
 MOD_CONTROL,// ����������� � ��� - ������� Alt
 $53 // ����. ������� - F10
); } //commented by �������� �.
  end;

procedure Ttok_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
 Flag, i, num_TOK:Integer;
begin
 Flag:=mrNO;
 if Main_Form.Main_Window_Exit then Action:=caNone else Action:=caFree;
 Main_Form.Exit_Ok:=True;
 //Main_Form.Sn_Cbx.ItemIndex := -1;

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

   num_TOK:=0;
   for i := Main_Form.MDIChildCount-1 downto 0 do
    begin
     if (Main_Form.MDIChildren[I] is TTOK_Form) then num_TOK:=num_TOK+1;
     if num_TOK>=2 then break;
    end;

   if num_TOK=1 then
     begin
//starshin
      //if Main_Form.MDIChildCount=1 then
      //Main_Form.My_menu.Items[0].Enabled:=False;
      //Main_Form.Caption:='����� - ������ 7.0 ��� Windows';
      {Main_Form.Ferma_Panel.Pages[1].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[4].TabVisible:=False; }
      Main_Form.TOK_Graph_Enter_Panel.Visible:=False;
      Main_Form.Tok_Dock.Visible := False;
      TOK_FD_Form.first_show_FD_form:=True;
      TOK_FD_Form.Close;
     end;

end;

 Main_Form.StatusBar1.Panels[0].Text :='';
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

end;

// ��������� ��������� ����������� ��� �������
procedure Ttok_Form.bound_draw_for_tok(x_max,y_max:integer;mas_x,mas_y:single);
var
 i,j,{x_int,y_int,}num:integer;
 x,y:single;
begin
 with PaintBox.Canvas do
  begin
  pen.color:=clred;
   if tok.zad[1]=1 then   //�����
    begin
     num:=round((y_max-60-coord_axis_y)/4);
     pen.Width:=1;
         for j:=0 to num do
          begin
           MoveTo(50+coord_axis_x-2,30+j*4);
           LineTo(50+coord_axis_x-5-2,30+j*4+5);
          end;
    end;
    if tok.zad[4]=1 then         //������
    begin
     num:=round((y_max-60-coord_axis_y)/4);
     pen.Width:=1;
         for j:=0 to num do
          begin
           MoveTo(x_max-30+2,30+j*4);
           LineTo(x_max-30+5+2,30+j*4-5);
          end;
    end;
    if tok.zad[2]=1 then          //������
    begin
     num:=round((x_max-80-coord_axis_x)/4);
     pen.Width:=1;
         for j:=0 to num do
          begin
           MoveTo(50+coord_axis_x+j*4,y_max-30-coord_axis_y+2);
           LineTo(50+coord_axis_x+j*4-5,y_max-30-coord_axis_y+5+2);
          end;
    end;
    if tok.zad[3]=1 then          //�������
    begin
     num:=round((x_max-80-coord_axis_x)/4);
     pen.Width:=1;
         for j:=0 to num do
          begin
           MoveTo(50+coord_axis_x+j*4,30-2);
           LineTo(50+coord_axis_x+j*4+5,30-5-2);
          end;
    end;


   pen.Width:=2;
   pen.Color:=clRed;
   brush.color:=clWhite;

   for i:=28 to 28+tok.n_zu-1 do          // ����� ����� ��������� !!!
    begin
     x:=tok.xm[i];
     y:=tok.ym[i];


     if (tok.pn[i,1]=1) or (tok.pn[i,2]=1) then
      begin
       if (tok.pn[i,1]=1) and (tok.pn[i,2]=1) then
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

       if (tok.pn[i,1]=1) and (tok.pn[i,2]=0) then
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

       if (tok.pn[i,1]=0) and (tok.pn[i,2]=1) then
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


//��������� ��������� ���������� ��� �������
procedure Ttok_Form.force_draw_for_tok(x_max,y_max:integer;mas_x,mas_y:single); //������ ����������
var
 i{,x_int,y_int}:integer;
 x,y:single;
 flag_draw:array[1..1000,1..2] of integer;
begin
 with PaintBox.Canvas do
  begin
   Pen.color:=clBlue;
   Pen.width:=2;
   brush.color:=clWhite;
     if (tok.n_nu=0) {!!!!!!!!!} or (tok.nsm=0) then exit;  //���� ��� ���
   {if Main_Form.Sn_Cbx.ItemIndex<0 then Main_Form.Sn_Cbx.ItemIndex:=0;
}   if Sn<=0 then exit;

  { for i:=Main_Form.Sn_Cbx.ItemIndex*9+1  to Main_Form.Sn_Cbx.ItemIndex*9+tok.n_nu  do //
}   for i:=(Sn-1)*9+1  to (Sn-1)*9+tok.{n_nu}n_nuz[sn]  do
    begin
      if tok.pn[i,1]<=0 then
        begin
         flag_draw[i,1]:=0;
         if tok.pn[i,1]<0 then
          begin
           flag_draw[i,1]:=-25;
          end
        end
      else
       begin
        flag_draw[i,1]:=25;
      end;
      if tok.pn[i,2]<=0 then
       begin
        flag_draw[i,2]:=0;
        if tok.pn[i,2]<0 then
         begin
          flag_draw[i,2]:=-25;
         end
       end
     else
      begin
       flag_draw[i,2]:=25;
     end;
   end;

    for i:=1 to 27{36} {Main_Form.Sn_Cbx.ItemIndex*9+1  to Main_Form.Sn_Cbx.ItemIndex*9+tok.n_nu } do //n_nu ���!
    begin
    x:=tok.xm[i];
    y:=tok.ym[i];

    if (tok.pn[i,1]<>0) then
    if (i<{Main_Form.Sn_Cbx.ItemIndex}(sn-1)*9+1) or (i>{Main_Form.Sn_Cbx.ItemIndex}(sn-1)*9+tok.n_nu)then
      Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y)
    else
      begin
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       MoveTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)+5);
       MoveTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+flag_draw[i,1]+coord_axis_x-flag_draw[i,1] div 3,y_max-coord_axis_y-30-round(mas_y*y)-5);
       pen.Color:=clRed;
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
       pen.Color:=clBlue;
        end;
     if (tok.pn[i,2]<>0) then
      if (i<(sn-1)*9+1) or (i>{Main_Form.Sn_Cbx.ItemIndex*9} (sn-1)*9+tok.n_nu)then
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y)
     else
      begin
      MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-coord_axis_y);
       LineTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       LineTo(50+round(mas_x*x)+5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
       MoveTo(50+round(mas_x*x)+coord_axis_x,y_max-30-round(mas_y*y)-flag_draw[i,2]-coord_axis_y);
       LineTo(50+round(mas_x*x)-5+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-flag_draw[i,2]+flag_draw[i,2] div 3);
       pen.Color:=clRed;
       Ellipse(50+round(mas_x*x)-3+coord_axis_x,y_max-coord_axis_y-30-round(mas_y*y)-3,50+coord_axis_x+round(mas_x*x)+5,y_max-30-round(mas_y*y)+5-coord_axis_y);
       pen.Color:=clBlue;

    end;
    end;

  end;
end;

procedure Ttok_Form.FormPaint(Sender: TObject);

var
  x_max,y_max, //������� ����������� �������
  step_int,i:integer;
  max_x_coord,max_y_coord,
  step,
  mas_x,mas_y:single; //�������������� ������������
  number,sss:string;
  n_of_step: integer;
begin

  if tok=nil then Exit;

  with PaintBox.Canvas do
    begin
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 brush.Color:=paintbox.color;
 pen.mode:=pmcopy;
 FillRect(Rect(10,20,width-10,height-30));      //?????
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    x_max:=PaintBox.width;
    y_max:=PaintBox.height;


  //    if tok.nsm=0 then main_form.Sn_cbx.Enabled:=false
  //     else  main_form.Sn_cbx.Enabled:=true;

      razm.caption:='  ['+tok.s_lin+']';

      max_x_coord:=tok.xm[37];
      max_y_coord:=tok.ym[37];


      {������ ������������ ���}
      pen.Color := clGray;
      Pen.width:=1;
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
      // ��������� ��� X
      if Main_Form.FermaRulerButton.Checked = true then
      begin
        TextOut(35,y_max-30,'['+tok.s_lin+']');
        step:=max_x_coord/strtoint(Main.Main_Form.FermaRulerSizeX.Text);
        n_of_step:=round(max_x_coord/step);
        step_int:=round((x_max-80-coord_axis_x)/n_of_step);
        for i:=1 to n_of_step do
        begin
          str((max_x_coord-step*(i-1)):5:1,number);
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
          str((max_y_coord-step*(i-1)):5:1,number);
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
      {������ ��������� �������}

      mas_x:=(x_max-80-coord_axis_x)/max_x_coord; //�������������� ������������
      mas_y:=(y_max-60-coord_axis_y)/max_y_coord;

      Pen.width:=3;
     { Pen.color:=clBlack;  }
      pen.mode:=pmCopy;
      pen.style:=psSolid;

        MoveTo(50+coord_axis_x,y_max-30-coord_axis_y);
        LineTo(50+coord_axis_x,30);
        LineTo(x_max-30,30);
        LineTo(x_max-30,y_max-30-coord_axis_y);
        LineTo(50+coord_axis_x,y_max-30-coord_axis_y);

       force_draw_for_tok(x_max,y_max,mas_x,mas_y); //��������
       bound_draw_for_tok(x_max,y_max,mas_x,mas_y); //�����������
    end;
    //���������
with PaintBox.Canvas do
  begin
    if Main_Form.NodesNum.Checked then
     begin
        brush.Style:=bsClear;
        font.name:='small font';
        Pen.Width:=1;
        font.Color:=clGreen;
        font.size:=8;
        Font.Style:=[fsBold];
      for i:=1 to 36 do
       if (tok.pn[i,1]<>0) or (tok.pn[i,2]<>0) then
        begin
          sss:=inttostr(tok.number[i]);
          if strtoint(sss) <> -1 then TextOut(54+round(mas_x*tok.xm[i])+coord_axis_x,y_max-45-round(mas_y*tok.ym[i])-coord_axis_y,sss);
        end;
      end;
    end;
     font.Color:=clBlack;
end;

procedure Ttok_Form.FormResize(Sender: TObject);
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


procedure Ttok_Form.N15Click(Sender: TObject);
begin
//   ����� �����
 Main_Form.NewFerma_MnuClick(Sender);
end;

procedure Ttok_Form.N17Click(Sender: TObject);
begin
  Main_Form.Open1Click(Self);
end;

procedure Ttok_Form.N22Click(Sender: TObject);
begin
  Main_Form.Exit1Click(Self);
end;


procedure Ttok_Form.FormActivate(Sender: TObject);
label 1;
var
  i{,ii},j:integer;
  active_page :Boolean;
begin
  active_page := False;
  popa:=true;
  if (Main_Form.Ferma_Panel.ActivePageIndex = 2)
       or (Main_Form.Ferma_Panel.ActivePageIndex = 3) then
         active_page := true;
 if tok=nil then Exit;
  Xold:=-1;
  yold:=-1;

 { Main_Form.tok_ToolBar.Left:=86;
  Main_Form.tok_ToolBar.Top:=2; }
  //Main_Form.Caption:='����� - ���������� '+#39+'���'+#39;
  Main_Form.Ferma_Panel.Pages[1].TabVisible:=True;
  Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[4].TabVisible:=True;
  if active_page then
    Main_Form.Ferma_Panel.ActivePageIndex := 4;
//  Main_Form.Save_TBtn.Enabled:=true; my comment


//  Main_Form.Ferm_ToolBar.Visible:=false; my comment
  Main_Form.Ferma_Graph_Enter_Panel.Visible:=False;
  Main_Form.Ferma_Dock.Visible := False;
  Ferma_FD_Form.Visible:=False;
//  Main_Form.Plast_ToolBar.Visible:=false; my comment
  Main_Form.Plast_Graph_Enter_Panel.Visible:=False;
  Main_Form.Plast_Dock.Visible := False;
  Plast_FD_Form.Visible:=False;

  Main_Form.Save_TBtn.Enabled:=true;
  //Main_Form.Caption:='����� - ���������� '+#39+'���'+#39;

//  Main_Form.TOK_ToolBar.Visible:=true; my comment
  //Main_Form.My_menu.Items[0].Enabled:=True;

  PaintBox.Cursor:=crDefault;
  PaintBox.ShowHint:=False;
  Main_Form.tok_Graph_Enter_Panel.Buttons[0].Down:=True;
{my insert}
  for j:=1 to Main_Form.tok_Graph_Enter_Panel.ButtonCount-1 do
      Main_Form.tok_Graph_Enter_Panel.Buttons[j].down:=false;
{end of my insert}
if Main_Form.ConstructorShow.Checked then
   begin
    TOK_Fd_Form.Visible:=True;
   end;
  if Main_Form.PanelConstruction.Checked then
   begin
   Main_Form.TOK_Graph_Enter_Panel.Visible:=True;
   if Main_Form.TOK_Graph_Enter_Panel.Parent = Main_Form.Tok_Dock then
      Main_Form.Tok_Dock.Visible := true else Main_Form.Tok_Dock.Visible := false;
   end
  else
  if Main_Form.ConstructorShow.Checked then
   begin
    TOK_Fd_Form.Visible:=True;
   end
  else

  if TOK_Edit.Text = '' then TOK_Edit.Text := '��� ������';

if (Main_Form.Sn_Cbx.ItemIndex = -1) {!!!!} or( Main_Form.Sn_Cbx.Items.Count<>tok.nsm ) then
  begin  //{}
  Main_Form.Sn_Cbx.clear;
  for i:=1 to tok.nsm do
    begin
      Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
    end;
  end;      // {}

    {if Main_Form.Sn_Cbx.ItemIndex = -1 then
       Main_Form.Sn_Cbx.ItemIndex:=0;}
  if tok.nsm=0 then begin
  Main_Form.Sn_Cbx.clear;
  Main_Form.Sn_Cbx.Items.Add('������ ���������� 1');
  Main_Form.Sn_Cbx.ItemIndex:=0;
  end;

     if Sn<=0 then
       Main_Form.Sn_Cbx.ItemIndex:=0
       else
       Main_Form.Sn_Cbx.ItemIndex:=sn-1;

       if (sn=0) and (tok.nsm>0) then sn:=1;

    if tok.nsm<=1 then main_form.Sn_cbx.Enabled:=false
     else  main_form.Sn_cbx.Enabled:=true;

           //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
           tok.count:=0;
           tok_number;
 //???????????????

  if not FileExists(ChangeFileExt(FileName,'.out')) then
  begin
  Main_Form.T2.Enabled:=false;
  end
  else begin
  Main_Form.T2.Enabled:=true;
  end;
  TOK_FD_form.showD(tok);



end;


procedure Ttok_Form.tok_number;
label 1;
var
i,j,ii:integer;
begin
    for i:=1 to 36 do tok.number[i]:=-1;
    for i:=1 to 36 do
      if (round(tok.pn[i,1])<>0) or (round(tok.pn[i,2])<>0) then
       begin
        tok.number[i]:=1;
        goto 1;
       end;
       tok.count:=0;
       exit;
1:    ii:=2;
    for i:=1 to 36 do
     if (round(tok.pn[i,1])<>0) or (round(tok.pn[i,2])<>0) then
      for j:=1 to i-1 do
        if (tok.xm[i]=tok.xm[j])and(tok.ym[i]=tok.ym[j]){and(tok.number[j]<>-1)} then
         tok.number[i]:=tok.number[j]
        else if (tok.number[i]=-1)and (j=i-1) then
         begin
          tok.number[i]:=ii;
          ii:=ii+1;
         end;
     tok.count:=ii-1;
end;


procedure Ttok_Form.FormShow(Sender: TObject);
begin
  // width:=360;height:=260;
  Width  := Ceil(360*Main_Form.Width_Ratio);
  Height := Ceil(260*Main_Form.Height_Ratio);
  Main_Form.tok_Graph_Enter_Panel.Buttons[0].Down:=True;
end;

procedure Ttok_Form.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
 var
  ux,uy,uxx,uyy,RealXReal,RealYReal:extended;
  What_Do,RealX,RealY,x_max,y_max:integer;
  max_x_coord,max_y_coord,mas_x,mas_y:extended;
  p:TPoint;
  i:integer;
begin
if Active then
 begin
 {Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';  }

  What_Do:=0;
  // ����� ������ ������ ?
  for i:=0 to main.Main_Form.tok_Graph_Enter_Panel.ButtonCount-1 do
   begin
   if main.Main_Form.tok_Graph_Enter_Panel.Buttons[i].Down = true then
    begin
    What_Do:=i;
    break;
    end;
   end;

  // ��� ����� ����� ��������� ������ ?
  p.x:=X;
  p.y:=Y;
  max_x_coord:=tok.xm[37];
  max_y_coord:=tok.ym[37];
  uxx:=0;
  uyy:=0;
  CurrentNode:=0;
  for i:=1 to 36 do
      begin
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(tok.xm[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(tok.ym[i]);

        if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4)and( (round(tok.pn[i,1])<>0) or (round(tok.pn[i,2])<>0) ) then
          begin
            CurrentNode:=tok.number[i];
            uxx:=tok.xm[i];
            uyy:=tok.ym[i];
            Break;
          end;
      end;
      if (CurrentNode<>0) and (what_do<>0) then
      Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);


//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
      //������� ����������
    RealX:=Round((X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));
    RealY:=Round((PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));
    RealXReal:=RealX;
    RealYReal:=RealY;
    if (what_do<>0) and (what_do<>4) then
     begin
      if (RealXReal>=0) and (RealYReal>=0) and (RealXReal<=tok.xm[37]) and (RealYReal<=tok.ym[37]) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal])
      else if (RealXReal<=tok.xm[37]) and (RealXReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[%g : -]', [RealXReal])
      else if (RealYReal<=tok.ym[37]) and (RealYReal>=0) then
       Main_Form.StatusBar1.Panels[0].Text := Format('[- : %g]', [RealYReal])
      else
       Main_Form.StatusBar1.Panels[0].Text := '[- : -]';
     end
    else
      Main_Form.StatusBar1.Panels[0].Text := '';

      case What_Do of


0: //�������
   begin
     with paintbox.canvas do begin
      showhint:=false;
     end;
      cursor:=crDefault;
   end;

2:
   begin
      cursor:=crHandPoint;
   end;


// my comment 4:   // ���������� �� ����
{my change}
6:   // ���������� �� ����
{end of my change}
 begin
 Main_Form.StatusBar1.Panels[0].Text :=''; if CurrentNode=0 then application.CancelHint;
  tok_M.Ttok_Form(Main_form.ActiveMDIChild).paintbox.Hint:='���� � '+inttostr(CurrentNode);
    x_max:=PaintBox.width;
    y_max:=PaintBox.height;
    mas_x:=(x_max-80-coord_axis_x)/max_x_coord; //�������������� ������������
    mas_y:=(y_max-60-coord_axis_y)/max_y_coord;


 if (X>50+round(mas_x*tok.xm[37])+coord_axis_x)or(X<50+{round(mas_x*tok.xm[1])+}coord_axis_x)or(Y<y_max-30-round(mas_y*tok.ym[37])-coord_axis_y)or(Y>y_max-30{-round(mas_y*plast.ym1[1])})then
    //Main_Form.StatusBar1.Panels[1].Text := '';
end;

 end;  // ����� Case
end;  // ����� 'Aktive'
//============================================================================//



end; // ����� '���������'


procedure Ttok_Form.SimpleSolve_MnuClick(Sender: TObject);
type
  TMethodProc=procedure(fn:PChar);
var
  LibHandle:THandle;
  DllName:string;
  sp:TMethodProc;
begin

  DllName:=ExtractFilePath(Application.ExeName)+'tok_r.dll';

    if isChanged then FileSave_MnuClick(Sender);
  if SaveCancel then exit;
  if not FileExists(FileName) then
   begin
    Beep;
    MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
    Exit;
   end;

  LibHandle:=LoadLibrary(PChar(DllName));
  if LibHandle=0 then
    begin
     beep;
      MessageDlg('��� ���������� TOK_R.dll',mtError,[mbOk],0);
      Exit;
    end;
  @sp:=GetProcAddress(LibHandle,'tok1');
  Cursor:=crHourGlass;
  try
    sp(PChar(FileName));
 { finally
    Cursor:=crDefault;}
  except
    messagedlg('������ � ��������� ������.'+#10+#13+'��� ����������� ������ ������������� �������.',mtError,[mbok],0);
  end;
  Cursor:=crDefault;
//  MessageDlg('������ ��������'+#10+#13+'Gs��� = '+floattostr(gv)+' '+s_for+'/'+s_lin+'**2'+#10+#13+'���������� � ����� '+name2,mtInformation,[mbOk],0);

  //MessageDlg(chr(13)+'������ ��������.',mtInformation,[mbOk],0);
  Tok_M.Ttok_Form(Main_Form.ActiveMDIChild).N1Click(Sender);
  Main_Form.T2.Enabled:=true;
end;

procedure Ttok_Form.N1Click(Sender: TObject);
var
fff:system.text;
gv:extended;
 Version_VYV:string;
 f1:System.text;
 ff:File of Byte;
 mg:integer;
begin

// �������� �� ������������� ������ �������
  if FileExists(ChangeFileExt(FileName,'.out')) then
    begin
      AssignFile(f1,ChangeFileExt(FileName,'.out'));
      Reset(f1);
      ReadLn(f1,Version_VYV);
      CloseFile(f1);
    end
  else Version_VYV:='Error';

  if Version_VYV='Error' then
   begin
    Beep;
    MessageDlg(#13+'���� � �������� �������� ���� ��� �� ������.',mtError,[mbOk],0);
    exit;
   end;

// �������� �� ������������� ������ ������ ������ � �������
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
    MessageDlg('������������ ������ ������ � ������� � �������.'+#10+#13+'����������� ������ �������� ���� ��� ��� ������ �������.',mtError,[mbOk],0);
    exit;
 end;

 if ((Version_VYV)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
     or (isChanged=True) then
  begin
    Beep;
    MessageDlg('������������ ������ ������ � ������� � �������.'+#10+#13+'����������� ������ �������� ���� ��� ��� ������ �������.',mtError,[mbOk],0);
    exit;
  end;

  assignfile(fff,changefileext(filename,'.out'));
  reset(fff);
  readln(fff);
  readln(fff);
  readln(fff,gv);
  closefile(fff);
{ // Tok_Rez_Form.TOK_Edit.text:=floattostr(gv);}Tok_Rez_Form.TOK_Edit.text:=(formatfloat('0.00000e+00',gv));
  Tok_Rez_Form.TOK_Label.caption:='������� ��� ���, ['+tok.s_for+'*'+tok.s_lin+']:';
  Tok_Rez_Form.caption:='��������� ������� �������� ���� ��� ��� '+extractfilename(Filename);
  TOK_Edit.text:=(formatfloat('0.00000e+00',gv));
  Tok_Rez_Form.showmodal;

//  MessageDlg('������ ��������'+#10+#13+'Gs��� = '+floattostr(gv)+' '+tok.s_for+'/'+tok.s_lin+'**2'+#10+#13+'���������� � ����� '+changefileext(filename,'.out'),mtInformation,[mbOk],0);
  //changefileext(filename,'.tok');
end;

procedure Ttok_Form.FormDeactivate(Sender: TObject);
begin
 PaintBox.Cursor:=crDefault;
 PaintBox.ShowHint:=False;
 Main_Form.TOK_Graph_Enter_Panel.Buttons[0].Down:=True;
 Main_Form.StatusBar1.Panels[0].Text :='';
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';
 //Main_Form.Caption:='����� - ������ 7.0 ��� Windows';

 sn:= main_form.sn_cbx.itemindex+1;
 if tok.nsm=0 then sn:=0;
 
end;

procedure Ttok_Form.N16Click(Sender: TObject);
begin
// ����� ��������
 Main_Form.NewPlast_MnuClick(Sender);
end;

procedure Ttok_Form.N4Click(Sender: TObject);
begin
//   ����� TOK
 Main_Form.NewTOK_MnuClick(Sender);
end;

procedure Ttok_Form.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
label
1,2;
var
  p,m,s:TPoint;
  ux,uy,uxx,uyy:extended;
  i,What_Do:integer;
   max_x_coord,max_y_coord:single;

begin
  Main_Form.StatusBar1.Panels[1].Text :='';
  Main_Form.StatusBar1.Panels[2].Text :='';
  p.x:=X;
  p.y:=Y;
  max_x_coord:=tok.xm[37];
  max_y_coord:=tok.ym[37];
  uxx:=0;
  uyy:=0;
  Xtok:=Round((X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));
  Ytok:=Round((PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));

     What_Do:=0;
  // ����� ������ ������ ?
  for i:=0 to main.Main_Form.TOK_Graph_Enter_Panel.ButtonCount-1 do
   begin
   if main.Main_Form.tok_Graph_Enter_Panel.Buttons[i].Down = true then
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
2:   // ����������� � ��������
 begin
   CurrentNode:=0;
  for i:=1 to 36 do
      begin
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(tok.xm[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(tok.ym[i]);

        if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) and ((round(tok.pn[i,1])<>0)or(round(tok.pn[i,2])<>0)) then
          begin
            CurrentNode:=tok.number[i];
            uxx:=tok.xm[i];
            uyy:=tok.ym[i];
            Break;
          end;
      end;
  if CurrentNode<>0 then
  Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);

  if popa then
   begin
// my comment    tok_PopUp.Popup(ClientToScreen(p).x,ClientToScreen(p).y);
{my insert}
   FixNode_PMnuClick(sender);
{end of my insert}
//    popa:=false; my comment
   end
  else
   popa:=true;

   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if CurrentNode=0 then
   begin
    //  CurrentNode:=tok.count+1;
    ux:=x;
    uy:=y;
   end;

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);


  tokFixNode_Form.Top:=ClientToScreen(M).y;
  tokFixNode_Form.Left:=ClientToScreen(M).x;
  tokForceNode_Form.Top:=ClientToScreen(M).y;
  tokForceNode_Form.Left:=ClientToScreen(M).x;
  if ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x+11;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x-7-tokForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x+11;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if Xtok>round(max_x_coord) then Xtok:=round(max_x_coord);
  if Xtok<0 then Xtok:=0;
  if Ytok>round(max_y_coord) then Ytok:=round(max_y_coord);
  if Ytok<0 then Ytok:=0;

  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
end;
//end;

3:   // ����������� � ��������
 begin
   CurrentNode:=0;
  for i:=1 to 36 do
      begin
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(tok.xm[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(tok.ym[i]);

        if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) and ((round(tok.pn[i,1])<>0)or(round(tok.pn[i,2])<>0)) then
          begin
            CurrentNode:=tok.number[i];
            uxx:=tok.xm[i];
            uyy:=tok.ym[i];
            Break;
          end;
      end;
  if CurrentNode<>0 then
  Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);

  if popa then
   begin
// my comment    tok_PopUp.Popup(ClientToScreen(p).x,ClientToScreen(p).y);
{my insert}
    zad_pmnuClick(sender);
{end of my insert}
//    popa:=false; my comment
   end
  else
   popa:=true;

   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if CurrentNode=0 then
   begin
    //  CurrentNode:=tok.count+1;
    ux:=x;
    uy:=y;
   end;

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);


  tokFixNode_Form.Top:=ClientToScreen(M).y;
  tokFixNode_Form.Left:=ClientToScreen(M).x;
  tokForceNode_Form.Top:=ClientToScreen(M).y;
  tokForceNode_Form.Left:=ClientToScreen(M).x;
  if ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x+11;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x-7-tokForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x+11;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if Xtok>round(max_x_coord) then Xtok:=round(max_x_coord);
  if Xtok<0 then Xtok:=0;
  if Ytok>round(max_y_coord) then Ytok:=round(max_y_coord);
  if Ytok<0 then Ytok:=0;

  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
end;
//end;
4:   // ����������� � ��������
 begin
   CurrentNode:=0;
  for i:=1 to 36 do
      begin
        ux:=50+coord_axis_x+(paintbox.width-80-coord_axis_x)/max_x_coord*(tok.xm[i]);
        uy:=paintbox.height-30-coord_axis_y-(paintbox.height-60-coord_axis_y)/max_y_coord*(tok.ym[i]);

        if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) and ((round(tok.pn[i,1])<>0)or(round(tok.pn[i,2])<>0)) then
          begin
            CurrentNode:=tok.number[i];
            uxx:=tok.xm[i];
            uyy:=tok.ym[i];
            Break;
          end;
      end;
  if CurrentNode<>0 then
  Main_Form.StatusBar1.Panels[1].Text :='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);

  if popa then
   begin
// my insert    tok_PopUp.Popup(ClientToScreen(p).x,ClientToScreen(p).y);
{my insert}
ForceNode_PMnuClick(sender);
{end of my insert}
//    popa:=false; my comment
   end
  else
   popa:=true;

   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if CurrentNode=0 then
   begin
    //  CurrentNode:=tok.count+1;
    ux:=x;
    uy:=y;
   end;

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);


  tokFixNode_Form.Top:=ClientToScreen(M).y;
  tokFixNode_Form.Left:=ClientToScreen(M).x;
  tokForceNode_Form.Top:=ClientToScreen(M).y;
  tokForceNode_Form.Left:=ClientToScreen(M).x;
  if ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x+11;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x-7-tokForceNode_Form.Width;
     tokForceNode_Form.Top:=ClientToScreen(S).y;;
     tokForceNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x+11;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
  if (ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width) and
     (ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=ClientToScreen(S).y;;
     tokFixNode_Form.Left:=ClientToScreen(S).x;
   end;
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if Xtok>round(max_x_coord) then Xtok:=round(max_x_coord);
  if Xtok<0 then Xtok:=0;
  if Ytok>round(max_y_coord) then Ytok:=round(max_y_coord);
  if Ytok<0 then Ytok:=0;

  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
end;
end;
end;



procedure Ttok_Form.zad_pmnuClick(Sender: TObject);
begin
 tokzad_form.showmodal;
 repaint;
end;

procedure Ttok_Form.FixNode_PMnuClick(Sender: TObject);
label
1;
var
  i,nz:integer;
  z4,z5,z2,z3:array[1..tok_max_zak] of extended; // ����������� (����� ����, X � Y)
begin
 // if CurrentNode=0 then Exit;
  nz:=0;
  for i:=1 to 36{tok.count} do
    if tok.number[i]=CurrentNode then
      begin
        nz:=i;
        Break;
      end;
  if nz=0 then
    begin
      if tok.n_zu=tok_max_zak then
        begin
        beep;
          MessageDlg(#13+'������� ����� ������������ �����.',mtWarning,[mbOk],0);
          popa:=true;
          Exit;
        end;
      inc(tok.n_zu);
      nz:=tok.n_zu+27;    //!!!!!!!!!!!!!!
      tok.xm[nz]:=Xtok;
      tok.ym[nz]:=Ytok;
      tok.pn[nz,1]:=0;
      tok.pn[nz,2]:=0;
    end
     else
      begin
       Xtok:=round(tok.xm[nz]);
       Ytok:=round(tok.ym[nz]);
      end;
      if ((xtok=0) and (tok.zad[1]=1)) or ((xtok=tok.xm[37]) and (tok.zad[4]=1)) or ((ytok=0) and (tok.zad[2]=1)) or ((ytok=tok.ym[37]) and (tok.zad[3]=1)) then
       begin
        Main_Form.StatusBar1.Panels[1].Text := '���� ����� �� ���������� �������.';
        Main_Form.StatusBar1.Panels[2].Text := '�������� ������ ����.';
        popa:=true;
        goto 1;//exit;
       end;
  tokFixNode_Form.Execute(tok.pn[nz,1],tok.pn[nz,2]);
// ������� �������������� ����
1:  nz:=1;
  //for i:=1 to tok.n_zu do
   for i:=1 to tok.n_zu do
    if (tok.pn[i+27,1]<>0)or(tok.pn[i+27,2]<>0) then
      begin
      //  z1[nz]:=plast.zak1[i];
        z2[nz]:=tok.pn[i+27,1];
        z3[nz]:=tok.pn[i+27,2];
        z4[nz]:=tok.xm[i+27];
        z5[nz]:=tok.ym[i+27];
        inc(nz);
      end;
  tok.n_zu:=nz-1;
  if nz<=9 then
   begin
    tok.pn[27+nz,1]:=0;
    tok.pn[27+nz,2]:=0;
    tok.xm[27+nz]:=0;
    tok.ym[27+nz]:=0;
   end;
  for i:=1 to tok.n_zu do
    begin
     // plast.zak1[i]:=z1[i];
      tok.pn[i+27,1]:=z2[i];
      tok.pn[i+27,2]:=z3[i];
      tok.xm[i+27]:=z4[i];
      tok.ym[i+27]:=z5[i];
    end;
    tok_number;
//  RePaint;
    Tok_FD_form.showD(Tok);
  isChanged:=true;
end;

procedure Ttok_Form.ForceNode_PMnuClick(Sender: TObject);
var
  i,{sn,}j,ii,nsm1:integer;
 begin
 // if CurrentNode=0 then Exit;
  nu:=0;
  for i:={main_form.SN_Cbx.ItemIndex*9+}1 to 36 do
   if CurrentNode<>0 then
    if tok.number[i]=CurrentNode then
      begin
        nu:=i;
        Break;
      end;
  if nu=0 then
    begin
               if tok.nsm = 0 then
                   begin
                   //  Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(1));
                   //  Main_Form.Sn_Cbx.Enabled:=true;
                     tok.nsm:=1;
                     //TokForceNode_Form.Nagr_Nagr_ComboBox.Items.Add(IntToStr(1));
                     main_form.SN_Cbx.ItemIndex:=0;
                   end;

            if tok.n_nuz[main_form.SN_Cbx.ItemIndex+1]>=tok_max_for then
              begin
                beep;
                MessageDlg(#13+'������� ����� ����������� �����.',mtWarning,[mbOk],0);
                Exit;
              end;
      sn:= main_form.SN_Cbx.ItemIndex+1;
     // inc(tok.n_nuz[sn]);
      nu:=(sn-1)*9+tok.n_nuz[sn]+1;//!!!!!!!!!!!!!
      currentnode:=tok.count+1;
      tok.xm[nu]:=Xtok;
      tok.ym[nu]:=Ytok;
      tok.pn[nu,1]:=0;
      tok.pn[nu,2]:=0;
    end
     else
      begin
       Xtok:=round(tok.xm[nu]);
       Ytok:=round(tok.ym[nu]);
      end;
  TokForceNode_Form.XLabel.Caption:='���� �� X  ['+Tok.s_for+']';
  TokForceNode_Form.YLabel.Caption:='���� �� Y  ['+Tok.s_for+']';

  TokForceNode_Form.ShowModal;

  ii:=Main_Form.Sn_Cbx.Itemindex+1;

  for i:=1 to 27 do
    if (tok.pn[i,1]=0)and(tok.pn[i,2]=0)then
     begin
       tok.xm[i]:=0;
       tok.ym[i]:=0;
     end;

   nsm1:=tok.nsm;

   for i:=1 to tok.nsm do
     if (tok.n_nuz[i]=0) and (i<>tok.nsm) then
      begin
       for j:=(i)*9+1 to (i)*9+9{tok.n_nuz[i+1]} do
        begin
         tok.xm[j-9]:=tok.xm[j];
         tok.ym[j-9]:=tok.ym[j];
         tok.pn[j-9,1]:=tok.pn[j,1];
         tok.pn[j-9,2]:=tok.pn[j,2];
         tok.xm[j]:=0;
         tok.ym[j]:=0;
         tok.pn[j,1]:=0;
         tok.pn[j,2]:=0;
        end;
        if i<ii then dec(ii);
        tok.n_nuz[i]:=tok.n_nuz[i+1];
        tok.n_nuz[i+1]:=0;
        dec(nsm1);
       end
      else if (tok.n_nuz[i]=0) and (i=tok.nsm) then
      begin
       dec(nsm1);
       //dec(ii);
      end;
  //tok.nsm:=nsm1;
  tok.nsm:=0;
  if tok.n_nuz[1]<>0 then inc(tok.nsm);
  if tok.n_nuz[2]<>0 then inc(tok.nsm);
  if tok.n_nuz[3]<>0 then inc(tok.nsm);

  if (tok.n_nuz[2]<>0) and (tok.nsm=1) and ((tok.pn[10,1]<>0)or(tok.pn[10,2]<>0))then
   begin
       for j:=1 to 9 do
        begin
         tok.xm[j]:=tok.xm[j+9];
         tok.ym[j]:=tok.ym[j+9];
         tok.pn[j,1]:=tok.pn[j+9,1];
         tok.pn[j,2]:=tok.pn[j+9,2];
        end;
       tok.n_nuz[1]:=tok.n_nuz[2];
       tok.n_nuz[2]:=0;
       tok.n_nuz[3]:=0;
       dec(ii);
   end;
   
  for i:=tok.nsm+1 to 3 do
   for j:=(i-1)*9+1 to (i-1)*9+9 do
    begin
     tok.xm[j]:=0;
     tok.ym[j]:=0;
     tok.pn[j,1]:=0;
     tok.pn[j,2]:=0;
    end;

 Main_Form.Sn_Cbx.Items.Clear;
 for i:=1 to tok.nsm do
  begin
   Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
  end;

 if tok.nsm=0 then ii:=0;
   Main_Form.Sn_Cbx.Itemindex:=ii-1;
   sn:= main_form.sn_cbx.itemindex+1;
   if tok.nsm=0 then Main_Form.Sn_Cbx.Items.Add('������ ���������� 1');
   if tok.nsm=0 then main_form.sn_cbx.itemindex:=0;
   if tok.nsm<=1 then main_form.Sn_cbx.Enabled:=false
     else  main_form.Sn_cbx.Enabled:=true;
  tok_number;

 { if tok.nsm=0 then main_form.sn_cbx.Enabled:=false
   else  main_form.Sn_cbx.Enabled:=true;  }

  Tok_FD_form.showD(Tok);
  RePaint;
end;

procedure Ttok_Form.Real_Coord_PUMPopup(Sender: TObject);
var
 w,h:integer ;
 max_x_coord,max_y_coord:extended;
begin

 max_x_coord:=tok.xm[37];
  max_y_coord:=tok.ym[37];


 if (max_x_coord>max_y_coord) then
  begin
    h:=260;
    w:=Round((h-75)*max_x_coord/max_y_coord)+123;
    if w<360 then w:=360;
    h:=Round((w-123)*max_y_coord/max_x_coord)+75;
  end
 else
  begin
    w:=360;
    h:=Round((w-123)*max_y_coord/max_x_coord)+75;
  end;

 if (w>screen.Width) or (h>screen.Height)then
  Real_Coord_PUM.Items[0].Enabled:=False
 else
  Real_Coord_PUM.Items[0].Enabled:=True;

end;

procedure Ttok_Form.real_sizeClick(Sender: TObject);
var
 w,h:integer ;
 max_x_coord,max_y_coord:extended;
begin


 max_x_coord:=tok.xm[37];
  max_y_coord:=tok.ym[37];


 if (max_x_coord>max_y_coord) then
  begin
    h:=260;
    w:=Round((h-75)*max_x_coord/max_y_coord)+123;
    if w<360 then w:=360;
    h:=Round((w-123)*max_y_coord/max_x_coord)+75;
  end
 else
  begin
    w:=360;
    h:=Round((w-123)*max_y_coord/max_x_coord)+75;
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

// ����������� ������� ���� ��� ������ ����������� ������� ---------------------
procedure Ttok_Form.MouseLeft;
begin
 Repaint;
 Canvas.CopyRect(Rect(0,0,tFormBMP.Width,tFormBMP.Height),
  tFormBMP.Canvas,Rect(0,0,tFormBMP.Width,tFormBMP.Height));
end;


procedure Ttok_Form.MouseIsDown(MX,MY: Integer);
begin
 tMDown:=True;
 tMouseX1:=MX;
 tMouseY1:=MY;
 Canvas.Pen.Color:=clBlue;
 MouseLeft;
end;


procedure Ttok_Form.MouseIsMove(MX,MY: Integer);
begin
 if tMDown then
  begin
   Repaint;
   with Canvas do
    begin
     CopyRect(Rect(0,0,tFormBMP.Width,tFormBMP.Height),
      tFormBMP.Canvas,Rect(0,0,tFormBMP.Width,tFormBMP.Height));
     MoveTo(tMouseX1,tMouseY1);
     LineTo(MX,tMouseY1);
     LineTo(MX,MY);
     LineTo(tMouseX1,MY);
     LineTo(tMouseX1,tMouseY1);
    end;
  end;
end;


procedure Ttok_Form.MouseIsUp(MX,MY: Integer);
var
 Temp: Integer;
begin
 tMDown:=False;
 tMouseX2:=MX;
 tMouseY2:=MY;
 if tMouseX2<tMouseX1 then
  begin
   Temp:=tMouseX1;
   tMouseX1:=tMouseX2;
   tMouseX2:=Temp;
  end;
 if tMouseY2<tMouseY1 then
  begin
   Temp:=tMouseY1;
   tMouseY1:=tMouseY2;
   tMouseY2:=Temp;
  end;
 if (tMouseX1<>tMouseX2) or (tMouseY1<>tMouseY2) then tSelectionIsOK:=True
 else tSelectionIsOK:=False;
end;


// ���������� ������������ ������ ����������� �������� -------------------------
procedure Ttok_Form.SelectionMode(Activate: Boolean);
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
      tASize:=True;
     end
    else
     tASize:=False;
   BMP:=TBitmap.Create;
   BMP.Width:=ClientWidth;
   BMP.Height:=ClientHeight;
   tFormBMP.Width:=BMP.Width;
   tFormBMP.Height:=BMP.Height;
   BMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   SetLength(tControlsArray,ControlCount);
   for i:=0 to ControlCount-1 do
    begin
     if Controls[i].Visible then
      begin
       Controls[i].Visible:=False;
       tControlsArray[i]:=True;
      end
     else tControlsArray[i]:=False;
    end;
   tFSize[0]:=Width;
   tFSize[1]:=Height;
   tBStyle:=BorderStyle;
   BorderStyle:=bsSingle;
   tBIcons:=BorderIcons;
   BorderIcons:=[biSystemMenu];
   Width:=tFSize[0];
   Height:=tFSize[1];
   Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   tFormBMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   BMP.Free;
   PopupMenu:=Real_Coord_PUM;
  end
// ��� �� ���� ���������:
 else
  begin
   for i:=0 to ControlCount-1 do
    begin
     if tControlsArray[i]=True then
      begin
       Controls[i].Visible:=True;
      end;
    end;
   Repaint;
   tFormBMP.Width:=0;
   tFormBMP.Height:=0;
   SetLength(tControlsArray,0);
   tFSize[0]:=Width;
   tFSize[1]:=Height;
   BorderStyle:=tBStyle;
   BorderIcons:=tBIcons;
   Width:=tFSize[0];
   Height:=tFSize[1];
    if tASize then
     begin
      AutoSize:=True;
      tASize:=False;
     end;
   PopupMenu:=nil;
  end;
end;


// ������� � ����� -------------------------------------------------------------
procedure Ttok_Form.PutToAccount;
var
 OleFileName,OleUnit,OleExtend: OleVariant;
 Bmp: TBitmap;
begin
 Bmp:=TBitmap.Create;

 Bmp.Canvas.CopyMode:=cmSrcCopy;
 if tSelectionIsOK then
  begin
   Bmp.Width:=tMouseX2-tMouseX1;
   Bmp.Height:=tMouseY2-tMouseY1;
   Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
    tFormBMP.Canvas,Rect(tMouseX1+1,tMouseY1+1,tMouseX2,tMouseY2));
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

 tSelectionIsCopied:=True;
 tSelectionIsOK:=False;

 Repaint;
end;


// ���������� ������� ----------------------------------------------------------

procedure Ttok_Form.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (tSelection) and (Button=mbRight) then
  MouseIsDown(X,Y);
 if (tSelection) and (Button=mbLeft) then
  MouseLeft;
end;

procedure Ttok_Form.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if tSelection then
  MouseIsMove(X,Y);
end;

procedure Ttok_Form.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (tSelection) and (Button=mbRight) then
  MouseIsUp(X,Y);
end;

procedure Ttok_Form.N10Click(Sender: TObject);
begin
 if not N10.Checked then
  begin
   tSelection:=True;
   SelectionMode(True);
   N10.Checked:=True;
   real_size.Enabled:=False;
  end
 else
  begin
   tSelection:=False;
   SelectionMode(False);
   N10.Checked:=False;
   real_size.Enabled:=True;
  end;
end;

// ���������� � ������ ---------------------------------------------------------
procedure TTok_Form.PrepareForModule;
var
 AFromDir, AToDir: string; //������ � ������� ��� �����������
 FSearchRec,DSearchRec: TSearchRec;
 FindResult: Integer;
begin
try
 AFromDir:=ExtractFilePath(FileName)+'*.*';
 AToDir:=ExtractFilePath(Application.ExeName)+'Modules\CurTOK\';

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
     AToDir+'CurTOK'+ExtractFileExt(AToDir+FSearchRec.Name));
    FindResult:=FindNext(FSearchRec);
   end;
 finally
  FindClose(FSearchRec);
 end;
 Application.MessageBox('������ ������������!','�������� ���������');
  if Main_Form.N17.Checked then
   begin
    FilesList_Form.Caption:='������ ������ ��������, ��������: "'+Copy(Caption,0,Length(Caption)-4)+'"';
    FilesList_Form.FileListBox1.ApplyFilePath(ExtractFilePath(Application.ExeName)+'Modules\CurTOK\');
    FilesList_Form.Show;
   end;
except
 Application.MessageBox('��������� ����������� ������!','������');
end;
end;

procedure TTok_Form.CopyDirectoryTree(AHandle: HWND;
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

procedure Ttok_Form.N6Click(Sender: TObject);
begin
PutToAccount;
end;

procedure Ttok_Form.N11Click(Sender: TObject);
var
temps: string;
begin
if IsNamed then begin
if MessageDlg('�� �������? ������ ����� ����� ������������!!!', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
begin
temps := filename;
Deletefile(temps);

temps[length(temps)-2]:='o';
temps[length(temps)-1]:='u';
temps[length(temps)]:='t';


if FileExists(temps) then
Deletefile(temps);

close;

end;
end;

end;


procedure Ttok_Form.N18Click(Sender: TObject);
begin
Buf.prev;
tok.Assign(Buf.Current^.T);
tok_FD_Form.showD(Tok);
Repaint;
end;

procedure Ttok_Form.N19Click(Sender: TObject);
begin
Buf.Next;
Tok.Assign(Buf.Current^.T);
tok_FD_Form.showD(Tok);
Repaint;
end;

procedure Ttok_Form.N8Click(Sender: TObject);
begin
ClientWidth :=CW;
ClientHeight:=CH;
end;

end.
