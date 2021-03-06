unit Ferma_M;
interface

uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Menus, ExtCtrls, Ferm_Dat, FermaFixNode, StdCtrls,IdGlobal, OleServer,
     WordXP, Variants, Math, Clipbrd, ShellAPI, buffer, Word2000,StrUtils;
const
//��� ��������� ������ .otr
        n_napr=6;        //�-�� ����� ���������� + ������� ���������� 13.11.07  (���� n_napr=5)
        n_nagr=4;        //�-�� ������� ����������
        n_otr=15;        //����. �-�� �������� �� ����� �����������
type
     ar1= array[1..2,1..n_napr*n_nagr*n_otr] of TPoint;
     TFerma_Form = class(TForm)
               PaintBox: TPaintBox;
               Bevel1: TBevel;
               Ferma_PopM: TPopupMenu;
               Fix_Menu: TMenuItem;
               Force_Menu: TMenuItem;
               SaveDialog: TSaveDialog;
               N3: TMenuItem;
    simple_panel: TPanel;
    V_pic: TImage;
    SG_pic: TImage;
    SGtok_pic: TImage;
    KS_pic: TImage;
    V_Edit: TEdit;
    Sg_edit: TEdit;
    Sgtok_edit: TEdit;
    Ks_edit: TEdit;
    E_pic: TImage;
    E_edit: TEdit;
    M_pic: TImage;
    M_edit: TEdit;
    WordApplication1: TWordApplication;
    Real_Coord_PUM: TPopupMenu;
    real_size: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    N17: TMenuItem; // ������ "������" � ������� "��������" � �������� ����.

               procedure FormClose(Sender: TObject; var Action: TCloseAction);
               procedure FormCreate(Sender: TObject);
               procedure FormPaint(Sender: TObject);
               procedure FileClose_MnuClick(Sender: TObject);
               procedure FileOpen_MnuClick(Sender: TObject);
               procedure FormResize(Sender: TObject);
               procedure FileNewFerm_MnuClick(Sender: TObject);
               procedure FormActivate(Sender: TObject);
               procedure FormDeactivate(Sender: TObject);
               procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
               Shift: TShiftState; X, Y: Integer);
               procedure Fix_MenuClick(Sender: TObject);
               procedure Force_MenuClick(Sender: TObject);
               procedure FileSave_MnuClick(Sender: TObject);
               procedure FileSaveAs_MnuClick(Sender: TObject);
               procedure SimpleSolve_MnuClick(Sender: TObject);
               procedure SolveOpt_MnuClick(Sender: TObject);
               procedure SolveOpt_Mnu1Click(Sender: TObject);
               procedure SimpleResults_MnuClick(Sender: TObject);
               procedure OptResults_MnuClick(Sender: TObject);
               procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
               Y: Integer);
               procedure FormShow(Sender: TObject);
               procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
               Shift: TShiftState; X, Y: Integer);
               procedure ViewConstr_MnuClick(Sender: TObject);
               procedure N3Click(Sender: TObject);
               procedure TOKClick(Sender: TObject);
               procedure ViewGraph_MnuClick(Sender: TObject);
               procedure N7Click(Sender: TObject);
               procedure N1Click(Sender: TObject);
               procedure N16Click(Sender: TObject);
               procedure real_sizeClick(Sender: TObject);
               procedure Real_Coord_PUMPopup(Sender: TObject);
               procedure OptResultsVC1_MnuClick(Sender: TObject);
    procedure optClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Click1(Sender: TObject);
    procedure LoadOtrData;
    procedure simple_panel_Draw(Sender: TObject);
    procedure ItemClick(Sender: TObject);
    procedure Old_sizeClick(Sender: TObject);

    procedure MouseLeft;
    procedure MouseIsDown(MX,MY: Integer);
    procedure MouseIsMove(MX,MY: Integer);
    procedure MouseIsUp(MX,MY: Integer);
    procedure SelectionMode(Activate: Boolean);
    procedure PutToAccount;
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure N17Click(Sender: TObject);

    procedure PrepareForModule;
    procedure CopyDirectoryTree(AHandle: HWND;
 const AFromDirectory, AToDirectory: string);
    procedure MenuItem2Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure ChangeTOKClick(Sender: TObject);
    procedure FileVersionCheck(Sender: TObject);
    procedure HighLightPivot(Sender:  TObject; PivNum: Integer);

          private
               { Private declarations }

           fMouseX1,fMouseY1,fMouseX2,fMouseY2: Integer;
           fMDown: Boolean;
           fSelection: Boolean;
           fSelectionIsOK: Boolean;
           fSelectionIsCopied: Boolean;
           fControlsArray: array of boolean;
           fFormBMP: TBitmap;
           fBStyle: TFormBorderStyle;
           fBIcons: TBorderIcons;
           fFSize: array [0..1] of Integer;
           fASize: Boolean;
           opt_type: array [0..1] of Integer;

               Procedure LoadData;
               procedure SaveData;
               procedure SaveFile(FName:string);
               procedure OtrPaint;
          { procedure WM_HotKeyHandler (var Message: TMessage);
           message WM_HOTKEY;} // commented by ��������� �.
          public
               { Public declarations }

               m2opt:ar1; // �������, ���. ����������� �� �������� (from plast)
               Buf:Tbuffer;//����� ������ ��� �������� ���������......
               kz1:integer; //���������� ������������ ����� (from plast)
               zak1,      //���������� ������������ ����� (from plast)
               zak2:array[1..2,1..Ferm_dat.plast_max_zak]of integer; // ��� ������������ ����� (from plast)
               reg_X,reg_Y:integer; //������� ������� (from plast)
               kl1:integer; //���������� ����������� �����
               frc1,        //���������� ����������� �����
               frc2: array[1..2,1..Ferm_dat.plast_max_for]of integer;//�������� ��������
               CW,CH: integer;

               TolOk:Integer;
//               ferma5_kol_uzlov:integer;// FERMA 5
//               ferma5_kol_uzlov_m :array [1..10] of integer; // FERMA 5
 //              tol2: array[1..15] of extended;

               CurrentNode:Integer;     // ����, �� ������� ������� ��������� ���
               FileName:string;         // ��� ����� � �������
               real_fname: string;
               FilePath:string;
               Ferm:TFerm;              // ��������� �����
               isChanged:boolean;       // ���� ��������� � ����� ?
               isSolved:boolean;         // ��� �� ������ �� ��������� ?
               isNamed:boolean;         // ����� ���� ������� ��� ?
               SaveCancel:boolean;       // �������� �� �� ���������� ?
               globalX,globalY:Integer;   //
               coord_axis_X, coord_axis_Y:Integer;
               Other_MDopNapr,Other_MModUpr:extended;    // ���������� ��� �������� ������������(����������) ���������
               Other_Ok:boolean;

               Old_Window_Width, Old_Window_Height:Integer;

               //������// ������� �.�.
               MCurrentNode:Integer;   //����� ���� �������
               //����� // ������� �.�.

               {��������� �������}
               Origin, MovePt: TPoint;
               Drawing,           // True - ������ ��������
               MouseUpNone,EllipseOk:boolean;
               Node1, Node2:Integer; // ��������� � �������� ����
               Node1x,Node1y,
               Node2x,Node2y:extended;

               {�������� �������}
               PivotX1, PivotX2,
               PivotY1, PivotY2 :Integer;
               PivotIdent:Integer;
               {+ ����}
               PNode1, PNode2:Integer;


               {��������� ����}
               NodeX, NodeY:extended;
               NodeOk:boolean;

               {�������� ����}
               NodeDelete:Integer;
               last_opt_type:integer; //��� ��������� ����������� ����������� 1-�������������� ������� ��, 2-��������������� ������� ��, 3-�������, 4-����������

               procedure DrawPivot(TopLeft, BottomRight: TPoint; AMode: TPenMode);
               {��������� ����������� � ����������}
               procedure force_draw_for_ferma(x_max,y_max,num_force:Integer;mas_x,mas_y:single);
               procedure bound_draw_for_ferma(x_max,y_max:Integer;mas_x,mas_y:single);
               {�������� ����}
               procedure Recursia(Sender: TObject);
               procedure DeletePivot(i_pivot: Integer);
               procedure RecursiaPivot(Node:Integer);
               procedure GraphPanelRepaint(Sender: TObject);
               //procedure DllCall(DllName,FileName:string;Ferm:TFerm);
               constructor NewFile(Owner:TComponent;F:TFerm);
               constructor OpenFile(Owner:TComponent;Fn:string);

 end;

var
     Ferma_Form: TFerma_Form;
     List:TStringList;  // ������ ��������� ������������ dll � �������� �����������
     Items:array [0..9] of TmenuItem;
     project_name:string;
     w_old,h_old:integer;
     isParmOpt:boolean;       // ���� �� ��������������� �����������?
     function MoyGemoroy(DllName,FileName:string;Ferm:TFerm;material:string;fmi,ebsi:single;maxkit,ljambda:Integer):integer;
     function TestParams(Sender:TFerma_Form):boolean;
     function DllCall(DllName,FileName:string;Ferm:TFerm):integer;

implementation

uses Main, Fix_node, ForcNode, SimplRezFerm, FermOptParam,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1, Ferma_M_Anim, FermOptNode,
     FermOptMassa, FermOptNode_Uzel,FermOptMassaRez, New_FermOptResults,NewOptParam,
     FilesList, Ferm_simple_res_msg;

{$R *.DFM}

{procedure TFerma_Form.WM_HotKeyHandler (var Message: TMessage);
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
  FileSaveas_Mnu.Click;
  inherited;
end;
} //commented by ��������� �.

function DllCall;
type
     TMethodProc=function(Fn:PChar):Integer;
var
     LibHandle:THandle;
     sp:TMethodProc;
     w,k,i,Flag,j,FH:Integer;
     f1,f2,f3:System.Text;
     Version_VYV,tmpStr,buf:string;
begin

          if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');
     try
     j     :=sp(PChar(FileName));
     finally

     //          Cursor:=crDefault;
     end;
     AssignFile(f1,ChangeFileExt(filename,'.vyv'));
             reset(f1);
             {$I-}
             Reset(f1);
             {$I+}
             if IOResult <> 0 then
               begin
               MessageDlg('File access error', mtWarning, [mbOk], 0);
               exit;
             end;

             readln(f1,Version_VYV);
             Delete(Version_VYV,Pos('_tmp',Version_VYV),4);
             //FileCreate(ChangeFileExt(FN,'.vyv'));
             AssignFile(f2,ChangeFileExt(filename,'.tvyv'));
             rewrite(f2);
             writeln(f2,Version_VYV);
             i:=0;
             while not SeekEof(f1) do
             begin
                i:=i+1;
                readln(f1,tmpStr);
                if i=4 then
                  begin
                    if tmpStr<>FloatToStr(Ferm.e1) then
                    writeln(f2,Ferm.e1);
                  end
                else
                  writeln(f2,tmpStr);
             end;
             CloseFile(f1);
             CloseFile(f2);
             DeleteFile(ChangeFileExt(filename,'.vyv'));
             RenameFile(changefileext(filename,'.tvyv'),changefileext(filename,'.vyv'));
     Result:=j;
end;

procedure ScanDir(StartDir: string; Mask: string; List: TStringList);
var
  SearchRec: TSearchRec;
begin
  if Mask = '' then
    Mask := '*.*';
  if StartDir[Length(StartDir)] <> '\' then
    StartDir := StartDir + '\';
  if FindFirst(StartDir + Mask, faAnyFile, SearchRec) = 0 then
  begin
    repeat Application.ProcessMessages;
      if (SearchRec.Attr and faDirectory) <> faDirectory then
        List.Add(StartDir + SearchRec.Name)
      else if (SearchRec.Name <> '..') and (SearchRec.Name <> '.')then begin
        List.Add(StartDir + SearchRec.Name + '\');
      ScanDir(StartDir + SearchRec.Name + '\', Mask, List);
  end;
until FindNext(SearchRec) <> 0;
FindClose(SearchRec);
end;
end;



constructor TFerma_Form.NewFile(Owner:TComponent;F:TFerm);
begin
     Create(Owner);
     Ferm                       :=F;

     // �������� �� ��������� ��� ����� �����
     Ferm.nst1                  :=0;
     Ferm.nyz1                  :=0;
     Ferm.ny1                   :=0;
     Ferm.e1                    :=7000000;
     Ferm.nsn1                  :=1;
     Ferm.sd1                   :=30000;
     Ferm.pltn                  :=0.0028;
     Ferm.s_lin                 :='��';
     Ferm.s_for                 :='�';
     Ferm.region_x              :=200;
     Ferm.region_y              :=200;

     FileName                   :='noname'+IntToStr(Main_Form.Num_Nonamed_Ferma)+'.frm';
     real_fname                 :=ExtractFileName(FileName);
     FilePath                   :=ExpandFileName(FileName);
     Main_Form.Num_Nonamed_Ferma:=Main_Form.Num_Nonamed_Ferma+1;
     Caption                    :=ExtractFileName(FileName);

     Tag                        :=1;            // ������ ����������
     last_opt_type              :=0;

     FormActivate(Self);
     isChanged                        :=true;
     Caption                          :=concat('*',real_fname);
     isSolved                         :=false;
     isParmOpt                        :=false;
     {my insert}
     isNamed                          :=false;
     Main_Form.SimpleResult_TB.Enabled:=false;
     Main_Form.ToolButton7.Enabled    :=false;
     //SimpleResults_Mnu.Enabled        :=false;
     //N8.Enabled                       :=false;
     //N7.Enabled                       :=false;
     Main_Form.B13.Enabled                      :=false;
     Main_Form.B16.Enabled                      :=false;
     Main_Form.BitBtn10.Enabled   :=false;
     {end of my insert}
     Buf:=Tbuffer.Create(Ferm); // ����������� �.�.
end;

constructor TFerma_Form.OpenFile(Owner:TComponent;Fn:string);
begin
     //FileName:=Fn;
     FileName:=ExpandFileName(Fn);
     FilePath:=ExpandFileName(Fn);
     Delete(Fn,Pos('_tmp',Fn),4);
     real_fname:=Fn;
     if fileexists(changefileext(Fn,'.smp')) then
             CopyFileTo(changefileext(Fn,'.smp'),changefileext(FileName,'.smp'));
     if fileexists(changefileext(Fn,'.vyv')) then
             CopyFileTo(changefileext(Fn,'.vyv'),changefileext(FileName,'.vyv'));
     if fileexists(changefileext(Fn,'.vyf')) then
             CopyFileTo(changefileext(Fn,'.vyf'),changefileext(FileName,'.vyf'));
     if fileexists(changefileext(Fn,'.nmi')) then
             CopyFileTo(changefileext(Fn,'.nmi'),changefileext(FileName,'.nmi'));

     Create(Owner);
     Ferm    :=TFerm.Create;
     LoadData;
     Caption:=Fn;
     Tag    :=1;            // ������ ����������
     last_opt_type              :=0;
     FormActivate(Self);
     isChanged:=false;
     real_fname:=ExtractFileName(FileName);
     Delete(real_fname,Pos('_tmp',real_fname),4);
     Caption:=real_fname;
     isSolved:=false;
     isParmOpt:=false;
     isNamed  :=true;
     {my insert}
     if not FileExists(ChangeFileExt(FileName,'.vyv')) then
     begin
          Main_Form.SimpleResult_TB.Enabled:=false;
          Main_Form.ToolButton7.Enabled    :=false;
          //SimpleResults_Mnu.Enabled        :=false;
          //N7.Enabled                       :=false;
     end;
     if not FileExists(ChangeFileExt(FileName,'.vyf')) then
     begin
          Main_Form.BitBtn10.Enabled                      :=false;
     end;
     {end of my insert}

     //N8.Enabled                       :=false;
     //N10.Enabled                      :=false;
     Main_Form.B13.Enabled                      :=false;
     Main_Form.B16.Enabled                      :=false;

     Buf:=Tbuffer.Create(Ferm); // ����������� �.�.
end;

procedure TFerma_Form.SaveData;
var
     ff: System.Text;
     i,j:Integer;
begin
     AssignFile(ff,FileName);
     rewrite(ff);
     writeln(ff,Ferm.nst1);
     writeln(ff,Ferm.nyz1);
     writeln(ff,Ferm.ny1);
     writeln(ff,Ferm.e1);
     writeln(ff,Ferm.nsn1);
     writeln(ff,Ferm.sd1);
     Writeln(ff,Ferm.pltn);
     for i:=1 to Ferm.nst1 do
     begin
          writeln(ff,Ferm.ITOPn[i,1]);
          writeln(ff,Ferm.ITOPn[i,2]);
     end;
     for i:=1 to Ferm.nyz1 do
     begin
          writeln(ff,Ferm.corn[i,1]); writeln(ff,Ferm.corn[i,2]);
     end;
     for i:=1 to Ferm.nst1 do writeln(ff,Ferm.Fn[i]);
     for i:=1 to Ferm.nyz1 do
     begin
          if Ferm.msn[i,1]=1 then writeln(ff,0)
          else writeln(ff,1);
          if Ferm.msn[i,2]=1 then writeln(ff,0)
          else writeln(ff,1);
     end;
     for i:=1 to Ferm.nsn1 do
          for j:=1 to Ferm.nyz1*2 do  writeln(ff,Ferm.pn[j,i]);
     writeln(ff,Ferm.s_lin);
     writeln(ff,Ferm.s_for);
     writeln(ff,Ferm.region_x);
     writeln(ff,Ferm.region_y);
     CloseFile(ff);
     //isChanged:=false;
end;

procedure TFerma_Form.LoadData;
var
     ff: System.Text;
     i,j,k:Integer;
     s:string;
     old:boolean;
     b:boolean;
     tmp:real;
     begin
     AssignFile(ff,FileName);
     reset(ff);
     readln(ff,Ferm.nst1);
     readln(ff,Ferm.nyz1);
     readln(ff,Ferm.ny1);
     readln(ff,Ferm.e1);
     readln(ff,Ferm.nsn1);
     readln(ff,Ferm.sd1);
//     readln(ff,Ferm.pltn);
     readln(ff,tmp);
//     readln(ff,s);
     tmp:=SimpleRoundTo(tmp,-4);
     s:=floattostr(tmp);
     b:=TryStrToint(s,i);
     if (b = true)and(i>0)and(i<10) then
         begin
      k:=2;
      Ferm.ITOPn[1,1]:=i;
      readln(ff,Ferm.ITOPn[1,2]);
      Ferm.pltn:=0;
      old:=true;
         end
      else
         begin
         K:=1;
         Ferm.pltn:=StrToFloat(s);
         old:=false;
         end;
     for i:=k to Ferm.nst1 do
     begin
          readln(ff,Ferm.ITOPn[i,1]);
          readln(ff,Ferm.ITOPn[i,2]);
     end;
     for i:=1 to Ferm.nyz1 do
     begin
          readln(ff,Ferm.corn[i,1]); readln(ff,Ferm.corn[i,2]);
     end;
     for i:=1 to Ferm.nst1 do readln(ff,Ferm.Fn[i]);
     for i:=1 to 9 do
     begin
          Ferm.msn[i,1]:=0;Ferm.msn[i,2]:=0;
     end;
     for i:=1 to Ferm.nyz1 do
     begin
          readln(ff,Ferm.msn[i,1]); readln(ff,Ferm.msn[i,2]);
     end;
     for j:=1 to Ferm.nyz1 do
     begin
          if Ferm.msn[j,2]=0 then Ferm.msn[j,2]:=1
          else Ferm.msn[j,2]:=0;
          if Ferm.msn[j,1]=0 then Ferm.msn[j,1]:=1
          else Ferm.msn[j,1]:=0;
     end;
     for i:=1 to Ferm.nsn1 do
          for j:=1 to Ferm.nyz1*2 do  readln(ff,Ferm.pn[j,i]);
     Ferm.s_lin:='';
     Ferm.s_for:='';
     readln(ff,Ferm.s_lin);
     readln(ff,Ferm.s_for);
     readln(ff,Ferm.region_x);
     readln(ff,Ferm.region_y);
     CloseFile(ff);

if old = true then savedata;//��� ������������� �� ������� �������� ������,���� ����� ����������� � ����� �������...����� ��� ��������� ����� �������� :)

     end;


procedure TFerma_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
     Flag, i,j, num_ferm,FS,SD:Integer;
     FN,s,s1,fp:string;
     decs: char;
     N,N1:real;
     ff,ff1: textfile;
begin
//     List.free;

     DecimalSeparator:='.';
     Flag:=mrNO;
     if Main_Form.Main_Window_Exit then Action:=caNone
     else Action:=caFree;
     Main_Form.Exit_Ok:=true;

     if isParmOpt then
      begin
       Flag:=MessageDlg(chr(13)+'��� �������� ��������������� ������, ��������� ���������� ?' ,mtWarning,mbYesNoCancel,0);
       if Flag=mrCancel then
        begin
           Main_Form.Exit_Ok:=false;
           Action           :=caNone;
           exit;
        end;
          if Flag=mrYes then
            begin
             Main_Form.ToolButton21Click(Sender);
             exit;
            end;
      end;
     if isNamed then
     begin
      FN:=filename;
      if fileexists(FN) then
      begin
        Delete(FN,Pos('_tmp',FN),4);
        assignfile(ff,Fn);
        assignfile(ff1,Filename);
        reset(ff);
        reset(ff1);
      while (not SeekEof(ff)) do
       begin
        readln(ff,s);
        readln(ff1,s1);
        if s1='' then readln(ff1,s1);
        begin
         if not SameText(s,s1) then
          begin
            n:=StrToFloat(s);
            n1:=StrToFloat(s1);
            if n<>n1 then
             begin
              isChanged:=true;
              Caption:=concat('*',real_fname);
              break;
             end;
          end;
        end;
       end;
       closefile(ff);
       closefile(ff1);
     end;
   end;

     if isChanged then
     begin
     Flag:=MessageDlg(chr(13)+'��������� ��������� � ����� ?' ,mtWarning,mbYesNoCancel,0);
          if Flag=mrNo then
          begin

          end;
          if Flag=mrCancel then
          begin
           Main_Form.Exit_Ok:=false;
           Action:=caNone;
           exit;
          end;
          if Flag=mrYes then
          FileSave_MnuClick(Sender);
          //FileSaveAs_MnuClick(Sender);
            if SaveCancel then
               begin
                    Main_Form.Exit_Ok:=false;
                    Action           :=caNone;
                    exit;
               end;

     end;

     if not Main_Form.Main_Window_Exit then
     begin

          num_ferm:=0;
          for i := Main_Form.MDIChildCount-1 downto 0 do
          begin
               if (Main_Form.MDIChildren[i] is TFerma_Form) then num_ferm:=num_ferm+1;
               if num_ferm>=2 then break;
          end;

          if num_ferm=1 then
          begin
               //Main_Form.My_menu.Items[0].Enabled     :=false;
               //Main_Form.Caption                        :='����� - ������ 7.0 ��� Windows'; // tarshin 12.11.14
               Main_Form.Ferma_Graph_Enter_Panel.Visible:=false;
               Ferma_Fd_Form.first_show_FD_form         :=true;
               Ferma_Fd_Form.Close;
               Main_Form.Ferma_Dock.Visible := False;
               Main_Form.WithTOK.Checked:=false;
               Main_Form.TOK_OK_PMI.Checked        :=false;
               Main_Form.TOK_NO_PMI.Checked        :=true;
          end;
               {Main_Form.Ferma_Panel.Pages[1].TabVisible:=False;
               Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
               Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
               Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;}


     end;

     Main_Form.StatusBar1.Panels[0].Text :='';
     Main_Form.StatusBar1.Panels[1].Text :='';
     Main_Form.StatusBar1.Panels[2].Text :='';

     if fileexists(changefileext(FilePath,'.smp')) and AnsiContainsStr(filename,'_tmp') then
       begin
        if isSolved then
         begin
             FN:=filename;
             Delete(FN,Pos('_tmp',FN),4);
             DeleteFile(changefileext(FN,'.smp'));
             CopyFileTo(changefileext(filename,'.smp'),changefileext(FN,'.smp'));
             DeleteFile(changefileext(FN,'.nmi'));
             CopyFileTo(changefileext(filename,'.nmi'),changefileext(FN,'.nmi'));
         end;
             deletefile(changefileext(filename,'.smp'));
       end;
     if fileexists(changefileext(FilePath,'.vyv')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.vyv'));
       end;
     if fileexists(changefileext(FilePath,'.vyf')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.vyf'));
       end;
      if fileexists(changefileext(FilePath,'.nmi')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.nmi'));
       end;
      if fileexists(changefileext(FilePath,'.ro1')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.ro1'));
       end;
      if fileexists(changefileext(FilePath,'.rw1')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.rw1'));
       end;
      if fileexists(changefileext(FilePath,'.vc1')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.vc1'));
       end;
      if fileexists(changefileext(FilePath,'.sbl')) and AnsiContainsStr(filename,'_tmp') then
       begin
         deletefile(changefileext(FilePath,'.sbl'));
       end;
     if fileexists(FilePath) and AnsiContainsStr(filename,'_tmp') then
       deletefile(FilePath);
     // ��� ��� ����� ��� ������� �� �������, ���� ������ - �����?
     // ����� ������ �������� ������, ���� � ��� ��� ��� ��������
     //FileVersionCheck(Sender);
     //Buf.Destroy;
end;

procedure TFerma_Form.FormCreate(Sender: TObject);

  var i:integer;
    begin
     isChanged:=false;
     real_fname:=FileName;
     Delete(real_fname,Pos('_tmp',real_fname),4);
     Caption:=real_fname;
     isParmOpt:=false;
     Other_Ok :=true;
     Resize;
    List:= TStringList.Create;
    ScanDir(ExtractFilePath(Application.ExeName)+'\plugins','*.dll',List);
    for i:= 0 to list.Count-1 do
        begin
     Items[i]:=TmenuItem.Create(self);
     Items[i].Caption:=Ferma_SelectMetod.Get_dll_name(list[i]);
     Items[i].Hint:=Ferma_SelectMetod.Get_dll_ext(list[i]);

     //N8.Insert(2,Items[i]);
     Items[i].OnClick:= ItemClick;
        end;

 {  //������������� ������� ������
 keyid:=GlobalAddAtom('My Hotkey'); //������� ����
 RegisterHotKey(handle,
 // ��������� � HotKey ����� �������� �����
 keyid, // ������������ ���� ��� id
 MOD_CONTROL,// ����������� � ��� - ������� ctrl
 $53 // ����. ������� - F10
  ); } // commented by ��������� �.
     end;

procedure TFerma_Form.bound_draw_for_ferma(x_max,y_max:Integer;mas_x,mas_y:single);
var
     i,j:Integer;
     ak_x,ak_y,ak_r: Integer;
     ux,uy,ux1,uy1:integer;
     pCol, bCol: Tcolor;
     bStl: TBrushStyle;

begin
     with PaintBox.Canvas do
     begin
          pen.Width  :=2;
          pen.Color  :=clRed;
          brush.Color:=clWhite;
          for i:=1 to Ferm.nyz1 do
          begin
               if (Ferm.msn[i,1]=1) or (Ferm.msn[i,2]=1) then
               begin
                    if (Ferm.msn[i,1]=1) and (Ferm.msn[i,2]=1) then
                    begin
                         MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                         LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+10);

                         MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                         LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+10);

                         MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-8,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+10);
                         LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+8,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+10);

                         Ellipse(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-3,coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+5);


         {***************************************************}
                       if (Ferm_opt_node.Ak_flag=true) and (i=Ferm_opt_node.Ak_num) then
               begin
                 ak_x:=coord_axis_X+50+round(mas_x*Ferm.corn[i,1]);
                 ak_y:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]);
                 ak_r:=Ferm_opt_node.Ak_Rad;
                 pCol:=pen.Color;
                 bCol:=brush.Color;
                 bStl:=brush.Style;
                 brush.Color:=clNone;
                 brush.Style:=bsDiagCross;
                 pen.Color:=clGreen;
                 Ellipse(ak_x-round(Ferm_opt_node.Ak_Rad*mas_x), ak_y-round(Ferm_opt_node.Ak_Rad*mas_y), ak_x+round(Ferm_opt_node.Ak_Rad*mas_x), ak_y+round(Ferm_opt_node.Ak_Rad*mas_y));
                 brush.Color:=bCol;
                 pen.Color:=pCol;
                 brush.Style:=bStl;
             end;

          {***************************************************}



                         pen.Width:=1;
                         for j:=-2 to 2 do
                         begin
                              MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+j*4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+10);
                              LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+j*4-2,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+15);
                         end;
                         pen.Width:=2;
                    end;

                    if (Ferm.msn[i,1]=1) and (Ferm.msn[i,2]=0) then
                    begin
                         MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-8);
                         LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+8);
                         Ellipse(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-3,coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+5);
         {***************************************************}
               if (Ferm_opt_node.Ak_flag=true) and (i=Ferm_opt_node.Ak_num) then
               begin
                 ak_x:=coord_axis_X+50+round(mas_x*Ferm.corn[i,1]);
                 ak_y:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]);
                 ak_r:=Ferm_opt_node.Ak_Rad;
                 pCol:=pen.Color;
                 bCol:=brush.Color;
                 bStl:=brush.Style;
                 brush.Color:=clNone;
                 brush.Style:=bsDiagCross;
                 pen.Color:=clGreen;
                 Ellipse(ak_x-round(Ferm_opt_node.Ak_Rad*mas_x), ak_y-round(Ferm_opt_node.Ak_Rad*mas_y), ak_x+round(Ferm_opt_node.Ak_Rad*mas_x), ak_y+round(Ferm_opt_node.Ak_Rad*mas_y));
                 brush.Color:=bCol;
                 pen.Color:=pCol;
                 brush.Style:=bStl;
             end;

          {***************************************************}
                         pen.Width:=1;
                         for j:=-2 to 2 do
                         begin
                              MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-j*4);
                              LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-9,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-j*4+2);
                         end;
                         pen.Width:=2;
                    end;

                    if (Ferm.msn[i,1]=0) and (Ferm.msn[i,2]=1) then
                    begin
                         MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-8,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+4);
                         LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+8,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+4);
                         Ellipse(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-3,coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+5);



         {***************************************************}
               if (Ferm_opt_node.Ak_flag=true) and (i=Ferm_opt_node.Ak_num) then
               begin
                 ak_x:=coord_axis_X+50+round(mas_x*Ferm.corn[i,1]);
                 ak_y:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]);
                 ak_r:=Ferm_opt_node.Ak_Rad;
                 pCol:=pen.Color;
                 bCol:=brush.Color;
                 bStl:=brush.Style;
                 brush.Color:=clNone;
                 brush.Style:=bsDiagCross;
                 pen.Color:=clGreen;
                 Ellipse(ak_x-round(Ferm_opt_node.Ak_Rad*mas_x), ak_y-round(Ferm_opt_node.Ak_Rad*mas_y), ak_x+round(Ferm_opt_node.Ak_Rad*mas_x), ak_y+round(Ferm_opt_node.Ak_Rad*mas_y));
                 brush.Color:=bCol;
                 pen.Color:=pCol;
                 brush.Style:=bStl;
             end;

          {***************************************************}

                         pen.Width:=1;
                         for j:=-2 to 2 do
                         begin
                              MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+j*4,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+4);
                              LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+j*4-2,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+9);
                         end;
                         pen.Width:=2;
                    end;
               end;

               if (Ferm.msn[i,1]=0) and (Ferm.msn[i,2]=0) then
               begin
if (ferm.pn[i*2,1]<>0)or(ferm.pn[i*2,2]<>0)or(ferm.pn[i*2,3]<>0)or
   (ferm.pn[i*2-1,1]<>0)or(ferm.pn[i*2-1,2]<>0)or(ferm.pn[i*2-1,3]<>0) then pen.Color:=clRed
else pen.Color:=clBlue;
//��������� �����
//   frc1[i,1]
//   frc1[i,2]

          Ellipse(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-3,coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])+5);
         {***************************************************}
                       if (Ferm_opt_node.Ak_flag=true) and (i=Ferm_opt_node.Ak_num) then
               begin
                 ak_x:=coord_axis_X+50+round(mas_x*Ferm.corn[i,1]);
                 ak_y:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]);
                 ak_r:=Ferm_opt_node.Ak_Rad;
                 pCol:=pen.Color;
                 bCol:=brush.Color;
                 bStl:=brush.Style;
                 brush.Color:=clNone;
                 brush.Style:=bsDiagCross;
                 pen.Color:=clGreen;
                 Ellipse(ak_x-round(Ferm_opt_node.Ak_Rad*mas_x), ak_y-round(Ferm_opt_node.Ak_Rad*mas_y), ak_x+round(Ferm_opt_node.Ak_Rad*mas_x), ak_y+round(Ferm_opt_node.Ak_Rad*mas_y));
                 brush.Color:=bCol;
                 pen.Color:=pCol;
                 brush.Style:=bStl;
             end;


          {***************************************************}
                    pen.Color:=clRed;
               end;
          end;
     end;
end;

//��������� ��������� ����������
procedure TFerma_Form.force_draw_for_ferma(x_max,y_max,num_force:Integer;mas_x,mas_y:single); //������ ����������
var
     i:Integer;
     flag_draw:array[1..9,1..4] of Integer;
begin
     with PaintBox.Canvas do
     begin
          pen.Color:=clBlue;
          pen.Width:=2;
          for i:=1 to Ferm.nyz1 do
          begin
               if Ferm.pn[i*2-1,num_force]<=0 then
               begin
                    flag_draw[i,1]:=0;
                    flag_draw[i,2]:=0;
                    if Ferm.pn[i*2-1,num_force]<0 then
                    begin
                         flag_draw[i,1]:=1;
                         flag_draw[i,2]:=-25;
                    end
               end
               else begin
                    flag_draw[i,1]:=1;
                    flag_draw[i,2]:=25;
               end;
               if Ferm.pn[i*2,num_force]<=0 then
               begin
                    flag_draw[i,3]:=0;
                    flag_draw[i,4]:=0;
                    if Ferm.pn[i*2,num_force]<0 then
                    begin
                         flag_draw[i,3]:=1;
                         flag_draw[i,4]:=-25;
                    end
               end
               else begin
                    flag_draw[i,3]:=1;
                    flag_draw[i,4]:=25;
               end;
          end;

          for i:=1 to Ferm.nyz1 do
          begin
               if flag_draw[i,1]=1 then
               begin
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+flag_draw[i,2],y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+flag_draw[i,2],y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+flag_draw[i,2]-flag_draw[i,2] div 3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]+5));
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+flag_draw[i,2],y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+flag_draw[i,2]-flag_draw[i,2] div 3,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]-5));
               end;
               if flag_draw[i,3]=1 then
               begin
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]));
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-flag_draw[i,4]);
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-flag_draw[i,4]);
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])+5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-flag_draw[i,4]+flag_draw[i,4] div 3);
                    MoveTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-flag_draw[i,4]);
                    LineTo(coord_axis_X+50+round(mas_x*Ferm.corn[i,1])-5,y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2])-flag_draw[i,4]+flag_draw[i,4] div 3);
               end;
          end;

     end;
end;


procedure TFerma_Form.FormPaint(Sender: TObject);
var
  x_max,y_max, //������� ����������� �������
  step_int,i,x1,x2,y1,y2,yline,xtop,xbot,ytop,ybot,Xp,
  num_force:Integer; // ������ ����������
  max_x_coord,max_y_coord,step,mas_x,mas_y:extended;     //�������������� ������������
  n_of_step: integer;
  number:string;
begin
  if Ferm=nil then exit;
  with PaintBox.Canvas do
  begin
    num_force   :=Tag; // ������ ����������
    x_max       :=PaintBox.Width;
    y_max       :=PaintBox.height;
    //������ ������� ����� (���� ��� ���������)
    OtrPaint;
    max_x_coord :=Ferm.region_x;
    max_y_coord :=Ferm.region_y;
    {������ ������������ ���}
    pen.Color   :=clGray;
    pen.Width   :=1;
    coord_axis_X:=30;
    coord_axis_Y:=15;
    MoveTo(coord_axis_X+43,30);
    LineTo(x_max-29,30); // ����. �����������
    MoveTo(x_max-30,y_max-30-coord_axis_Y);
    LineTo(x_max-30,30); // ������ ���������
    MoveTo(coord_axis_X+43,y_max-30-coord_axis_Y);
    LineTo(x_max-15,y_max-30-coord_axis_Y); // ��� X
    LineTo(x_max-20,y_max-35-coord_axis_Y);
    MoveTo(x_max-15,y_max-30-coord_axis_Y);
    LineTo(x_max-20,y_max-25-coord_axis_Y);
    MoveTo(coord_axis_X+50,y_max-20-coord_axis_Y);
    LineTo(coord_axis_X+50,15); // ��� Y
    LineTo(coord_axis_X+45,20);
    MoveTo(coord_axis_X+50,15);
    LineTo(coord_axis_X+55,20);
    brush.Color:=clBtnFace;
    font.name  :='times new roman';
    font.Style :=[fsBold];
    font.size  :=10;
    // ��������� �����������
    if Main_Form.FermaRulerButton.Checked = true then
    begin
      TextOut(35,y_max-30,'['+Ferm.s_lin+']');
    end;
    // ��������� ��� X
    if Main_Form.FermaRulerButton.Checked = true then
    begin
      step:=max_x_coord/strtoint(Main.Main_Form.FermaRulerSizeX.Text);
      n_of_step:=round(max_x_coord/step);
      step_int:=round((x_max-80-coord_axis_X)/n_of_step);
      for i:=1 to n_of_step do
      begin
        str((max_x_coord-step*(i-1)):5:1,number);
        TextOut(x_max-45-step_int*(i-1),y_max-28,number);
        MoveTo(x_max-30-step_int*(i-1),y_max-20-coord_axis_Y);
        LineTo(x_max-30-step_int*(i-1),y_max-30-coord_axis_Y);
      end;
    end;
    // ��������� ������������ ����� �����
    step:=max_x_coord/strtoint(Main.Main_Form.FermaGridSizeX.Text);
    n_of_step:=round(max_x_coord/step);
    step_int:=round((x_max-80-coord_axis_X)/n_of_step);
    for i:=1 to n_of_step do
    begin
      if Main_Form.FermaGridButton.Checked = true then
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
      step_int:=round((y_max-60-coord_axis_Y)/n_of_step);
      for i:=1 to n_of_step do
      begin
        str((max_y_coord-step*(i-1)):5:1,number);
        TextOut(30,23+step_int*(i-1),number);
        MoveTo(43+coord_axis_X,30+step_int*(i-1));
        LineTo(50+coord_axis_X,30+step_int*(i-1));
      end;
    end;
    // ��������� �������������� ����� �����
    step:=max_y_coord/strtoint(Main.Main_Form.FermaGridSizeY.Text);
    n_of_step:=round(max_y_coord/step);
    step_int:=round((y_max-60-coord_axis_Y)/n_of_step);
    for i:=1 to n_of_step do
    begin
      if Main_Form.FermaGridButton.Checked = true then
      begin
        MoveTo(50+coord_axis_X,30+step_int*(i-1));
        LineTo(x_max-60+coord_axis_X,30+step_int*(i-1));
      end;
    end;
    {������ �����}
    pen.Color:=clBlack;
    pen.Width:=strtoint(Main_Form.SX.Text);
    pen.Style:=psDot;
    if Ferm.nyz1=0 then
    begin
      max_x_coord:=1;max_y_coord:=1
    end;
    mas_x:=(x_max-80-coord_axis_X)/max_x_coord; //�������������� ������������
    mas_y:=(y_max-60-coord_axis_Y)/max_y_coord;
    for i:=1 to Ferm.nst1 do
    begin
      MoveTo(50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,1],1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,1],2]));
      LineTo(50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,2],1]),y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,2],2]));
    end;
    force_draw_for_ferma(x_max,y_max,num_force,mas_x,mas_y);
    bound_draw_for_ferma(x_max,y_max,mas_x,mas_y);

          //��������� ���������
          //if Main_Form.FermaNumberButton.Down = true then
          //begin
               brush.Color:=clWhite;
               font.name  :='small font';
               pen.Width  :=1;
               pen.Style:=psSolid;
               pen.Color  :=clBlue;
               font.Color :=clGreen;
               font.size  :=7;
               if Main_Form.NodesNum.Checked = true then
               begin
               for i:=1 to Ferm.nyz1 do   // �������� ����
               begin
                    x1         :=50+coord_axis_X+round(mas_x*Ferm.corn[i,1]);
                    y1         :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[i,2]);
                    brush.Style:=bsClear;
                    font.size  :=10;
                    TextOut(x1+6,y1-14,IntToStr(i));
                    font.size  :=7;
                    brush.Style:=bsSolid;
               end;
               end;

               if Main_Form.SticksNum.Checked = true then
               begin
               for i:=1 to Ferm.nst1 do  //�������� �������
               begin
                    x1:=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,1],1]);
                    y1:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,1],2]);
                    x2:=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,2],1]);
                    y2:=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,2],2]);

                    if x1>=x2 then
                    begin xtop:=x1;xbot:=x2;
                    end
                    else begin xtop:=x2;xbot:=x1;
                    end;
                    if y1>=y2 then
                    begin ytop:=y1;ybot:=y2;
                    end
                    else begin ytop:=y2;ybot:=y1;
                    end;

//// ��������� ������� ��������
                    if x1<>x2 then
                    begin
                         if y1=y2 then
                         begin
                              yline      :=round((xbot+(xtop-xbot)/2-x1)*(y2-y1)/(x2-x1))+y1;
                              brush.Style:=bsSolid;
                              Rectangle(xbot+round((xtop-xbot)/2)-6,yline-6,xbot+round((xtop-xbot)/2)+7,yline+5);
                              brush.Style:=bsClear;
                              if i<=9 then Xp:=2
                              else Xp:=4;
                              TextOut(xbot-Xp+round((xtop-xbot)/2),yline-6,IntToStr(i));
                         end
                         else begin
                              yline      :=round((xbot+(xtop-xbot)/3-x1)*(y2-y1)/(x2-x1))+y1;
                              brush.Style:=bsSolid;
                              Rectangle(xbot+round((xtop-xbot)/3)-6,yline-6,xbot+round((xtop-xbot)/3)+7,yline+5);
                              brush.Style:=bsClear;
                              if i<=9 then Xp:=2
                              else Xp:=4;
                              TextOut(xbot-Xp+round((xtop-xbot)/3),yline-6,IntToStr(i));
                         end;
                    end
                    else begin
                         brush.Style:=bsSolid;
                         Rectangle(x1-6,ybot+round((ytop-ybot)/2)-6,x2+7,ybot+round((ytop-ybot)/2)+5);
                         brush.Style:=bsClear;
                         if i<=9 then x1:=x1-2
                         else x1:=x1-4;
                         TextOut(x1,ybot+round((ytop-ybot)/2)-6,IntToStr(i));
                    end;
               end; // ����� For
               end;
               font.Color:=clBlack;
          //end; // ����� Numering

     end;

     Case TolOk of   // ������� ��� ��������� ��������� ������� ��� ������ � ������� ��������� ������� ������� �������
          2,3: begin
               PaintBox.Canvas.pen.Mode :=pmNotXor;
               PaintBox.Canvas.pen.Color:=clBlue;
               PaintBox.Canvas.pen.Width:=3;
               PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
               PaintBox.Canvas.LineTo(PivotX2, PivotY2);
               PaintBox.Canvas.pen.Width:=1;
               PaintBox.Canvas.pen.Mode :=pmCopy;
          end;
          1: begin
               PivotIdent:=0;
               TolOk     :=4;
          end;
     end; //����� Case of

simple_panel_draw(Sender);
end;

procedure TFerma_Form.FileClose_MnuClick(Sender: TObject);
begin
     Main_Form.Exit1Click(Self);
end;

procedure TFerma_Form.FileOpen_MnuClick(Sender: TObject);
begin
     Main_Form.Open1Click(Self);
end;

procedure TFerma_Form.FormResize(Sender: TObject);
begin
 globalX:=5;
 globalY:=5;

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

// ������ // ����������� ��������
 if (WindowState<>wsNormal) then
 begin
  if ((Left>=0) and (Top<0)) then Top:=0;
  if ((Left<0) and (Top>=0)) then Left:=0;
 end;
// ����� // ����������� ��������

 end;

procedure TFerma_Form.FileNewFerm_MnuClick(Sender: TObject);
begin
     // ����� �����
     Main_Form.NewFerma_MnuClick(Sender);
end;

procedure TFerma_Form.GraphPanelRepaint(Sender: TObject);
begin
     if Ferm.nst1>0 then
     begin
          if Ferm.nst1=15 then
          begin
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[2].Enabled:=false;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[3].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[4].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[10].Enabled:=true;
          end
          else begin
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[2].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[3].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[4].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[10].Enabled:=true;
          end;
     end
     else begin
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[2].Enabled:=true;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[3].Enabled:=false;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[4].Enabled:=false;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[10].Enabled:=false;
     end;


     if Ferm.nyz1>0 then
     begin
          if Ferm.nyz1=9 then
          begin
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[6].Enabled:=false;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[7].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[9].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[11].Enabled:=true
          end
          else begin
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[6].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[7].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[9].Enabled:=true;
               Main_Form.Ferma_Graph_Enter_Panel.Buttons[11].Enabled:=true;
          end;
     end
     else begin
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[6].Enabled:=true;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[7].Enabled:=false;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[9].Enabled:=false;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[11].Enabled:=false;
     end;


     end;


procedure TFerma_Form.simple_panel_Draw(Sender: TObject);
var ff:system.text;
s:string;
begin
 if fileexists(changefileext(filename,'.smp')) and (isChanged=false and isSolved=true) then
  begin
     assignfile(ff,changefileext(filename,'.smp'));
     reset(ff);
     readln(ff,s);
     E_edit.Text:=s;
     readln(ff,s);
     V_edit.Text:=s;
     readln(ff,s);
     M_edit.Text:=s;
     readln(ff,s);
     Sg_edit.Text:=s;
     readln(ff,s);
     sgtok_edit.Text:=s;
     readln(ff,s);
     ks_edit.Text:=s;
     closefile(ff);
 end
     else
     begin
     if (isChanged=true)and(fileexists(changefileext(filename,'.smp'))) then deletefile(changefileext(filename,'.smp'));
     E_edit.Text:='  ---';
     V_edit.Text:='  ---';
     M_edit.Text:='  ---';
     Sg_edit.Text:='  ---';
     sgtok_edit.Text:='  ---';
     ks_edit.text:='  ---';
     end;
end;




procedure TFerma_Form.FormActivate(Sender: TObject);
var
     i,j:Integer;
     active_page :Boolean;
begin
     active_page := False;
     if (Main_Form.Ferma_Panel.ActivePageIndex = 3)
       or (Main_Form.Ferma_Panel.ActivePageIndex = 4) then
         active_page := true;
     real_fname:=ExtractFileName(FileName);
     Delete(real_fname,Pos('_tmp',real_fname),4);
     if Ferm=nil then exit;
     //Main_Form.Caption :='����� - ���������� '+#39+'��������� �����������'+#39;
     Main_Form.Ferma_Panel.Pages[1].TabVisible:=True;
     Main_Form.Ferma_Panel.Pages[2].TabVisible:=True;
     Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
     Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;
     if active_page then
         Main_Form.Ferma_Panel.ActivePageIndex := 2;
     Main_Form.Plast_Graph_Enter_Panel.Visible:=false;
     Main_Form.Plast_Dock.Visible := false;
     Plast_FD_Form.Visible                    :=false;

     Main_Form.TOK_Graph_Enter_Panel.Visible  :=false;
     Main_Form.Tok_Dock.Visible := False;
     TOK_FD_Form.Visible                      :=false;
     //Main_Form.My_menu.Items[0].Enabled     :=true;

     if Main_Form.ConstructorShow.Checked then Ferma_Fd_Form.Visible :=true;

     if Main_Form.PanelConstruction.Checked then
     begin
          Main_Form.Ferma_Graph_Enter_Panel.Visible:=true;
          if Main_Form.Ferma_Graph_Enter_Panel.Parent = Main_Form.Ferma_Dock then
            Main_Form.Ferma_Dock.Visible := true else Main_Form.Ferma_Dock.Visible := false;
     end;

     // ��������� ComboBox �� �������� ����������
     Main_Form.Sn_Cbx.Items.Clear;
     for i:=1 to Ferm.nsn1 do
     begin
          Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
     end;
     if Tag>Ferm.nsn1 then Tag:=Ferm.nsn1;
     Main_Form.Sn_Cbx.ItemIndex:=Tag-1;

     if Ferm.nsn1=1 then Main_Form.Sn_Cbx.Enabled:=false
     else Main_Form.Sn_Cbx.Enabled:=true;

     PaintBox.Cursor                                   :=crDefault;
     PaintBox.ShowHint                                 :=false;
     Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
     for j:=1 to Main_Form.Ferma_Graph_Enter_Panel.ButtonCount-1 do Main_Form.Ferma_Graph_Enter_Panel.Buttons[j].Down:=false;
     if not FileExists(ChangeFileExt(FileName,'.vyv')) then
     begin
          Main_Form.SimpleResult_TB.Enabled:=false;
          Main_Form.ToolButton7.Enabled    :=false;
          //SimpleResults_Mnu.Enabled        :=false;
          //N7.Enabled                       :=false;
     end
     else begin
          Main_Form.SimpleResult_TB.Enabled:=true;
          Main_Form.ToolButton7.Enabled    :=true;
          //SimpleResults_Mnu.Enabled        :=true;
          //N7.Enabled                       :=true;
     end;
     if last_opt_type=0 then
        Main_Form.BitBtn10.Enabled:=false
     else
        Main_Form.BitBtn10.Enabled:=true;

     project_name:=FileName;
     Ferma_Fd_Form.showD(Ferm);
     end;




     procedure TFerma_Form.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
     M,P,S:TPoint;
     ux,uy:extended;
     i,what_do,i_node,j:Integer;
     max_x_coord,max_y_coord:extended;
begin

     what_do:=0;
     for i:=0 to Main.Main_Form.Ferma_Graph_Enter_Panel.ButtonCount-1 do
     begin
          if Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Down = true then what_do:=Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Tag;
     end;

     max_x_coord:=Ferm.region_x;
     max_y_coord:=Ferm.region_y;

     CurrentNode:=0;
     for i:=1 to Ferm.nyz1 do
     begin
          ux:=50+coord_axis_X+(PaintBox.Width-80-coord_axis_X)/max_x_coord*(Ferm.corn[i,1]);
          uy:=PaintBox.height-30-coord_axis_Y-(PaintBox.height-60-coord_axis_Y)/max_y_coord*Ferm.corn[i,2];
          if (X>ux-10)and(X<ux+10)and(Y>uy-10)and(Y<uy+10) then
              begin
               CurrentNode:=i;
               break;
          end;
     end;
     Case what_do of
          {9:  //������� �������
           begin
            if PivotIdent<>0 then
             begin
              FermaPivotTol_Form.PTF:=Ferm;
              FermaPivotTol_Form.NumPivot:=PivotIdent;
                Paintbox.Canvas.Pen.Mode:=pmNotXor;
                Paintbox.Canvas.Pen.Color:=clBlue;
                Paintbox.Canvas.Pen.Width:=3;
                Paintbox.Canvas.MoveTo(PivotX1, PivotY1);
                Paintbox.Canvas.LineTo(PivotX2, PivotY2);
                Paintbox.Canvas.Pen.Width:=1;
                Paintbox.Canvas.Pen.Mode:=pmCopy;
              FermaPivotTol_Form.ShowModal;
              PivotIdent:=0;
              PivotX1:=-1;
              PivotX2:=-1;
              PivotY1:=-1;
              PivotY1:=-1;
             end;
           end; // ����� Case '9' (������� �������) }
          //������// ������� �.�.
           12: begin
               if Button=mbLeft then
               begin
                    Drawing:=true;
                    MCurrentNode:=CurrentNode;
               end;
               end;
        //����� // ������� �.�.

          1: begin
               if Button=mbRight then
               begin
                    M.X:=X;
                    M.Y:=Y;
                    Real_Coord_PUM.Popup(ClientToScreen(M).X,ClientToScreen(M).Y);
               end; 
          end;
          10: begin   // �����������, ����������, ����������

               M.X:=round(ux)+7;
               M.Y:=round(uy)+7;

               P.X:=round(ux);
               P.Y:=round(uy);

               if CurrentNode=0 then exit;
               FermaFixNode_Form.Top   :=ClientToScreen(M).Y;
               FermaFixNode_Form.Left  :=ClientToScreen(M).X;
               FermaForceNode_Form.Top :=ClientToScreen(M).Y;
               FermaForceNode_Form.Left:=ClientToScreen(M).X;
               if ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X+11;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width then
               begin
                    S.Y                    :=P.Y+7;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height) then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X+11;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width then
               begin
                    S.Y                  :=P.Y+7;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height) then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               Fix_MenuClick(Sender);
          end;

          8: begin   // �����������, ����������, ����������

               M.X:=round(ux)+7;
               M.Y:=round(uy)+7;

               P.X:=round(ux);
               P.Y:=round(uy);

               if CurrentNode=0 then exit;
               FermaFixNode_Form.Top   :=ClientToScreen(M).Y;
               FermaFixNode_Form.Left  :=ClientToScreen(M).X;
               FermaForceNode_Form.Top :=ClientToScreen(M).Y;
               FermaForceNode_Form.Left:=ClientToScreen(M).X;
               if ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X+11;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width then
               begin
                    S.Y                    :=P.Y+7;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height) then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X+11;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width then
               begin
                    S.Y                  :=P.Y+7;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height) then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               N3Click(Sender);
          end;

          11: begin   // �����������, ����������, ����������

               M.X:=round(ux)+7;
               M.Y:=round(uy)+7;

               P.X:=round(ux);
               P.Y:=round(uy);

               if CurrentNode=0 then exit;
               FermaFixNode_Form.Top   :=ClientToScreen(M).Y;
               FermaFixNode_Form.Left  :=ClientToScreen(M).X;
               FermaForceNode_Form.Top :=ClientToScreen(M).Y;
               FermaForceNode_Form.Left:=ClientToScreen(M).X;
               if ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X+11;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width then
               begin
                    S.Y                    :=P.Y+7;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaForceNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaForceNode_Form.height>Screen.height) then
               begin
                    S.Y                    :=P.Y-7-FermaForceNode_Form.height;
                    S.X                    :=P.X-7-FermaForceNode_Form.Width;
                    FermaForceNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaForceNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X+11;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width then
               begin
                    S.Y                  :=P.Y+7;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               if (ClientToScreen(M).X+FermaFixNode_Form.Width>Screen.Width) and
                  (ClientToScreen(M).Y+FermaFixNode_Form.height>Screen.height) then
               begin
                    S.Y                  :=P.Y-7-FermaFixNode_Form.height;
                    S.X                  :=P.X-7-FermaFixNode_Form.Width;
                    FermaFixNode_Form.Top:=ClientToScreen(S).Y;;
                    FermaFixNode_Form.Left:=ClientToScreen(S).X;
               end;
               Force_MenuClick(Sender);
          end;

          2: begin // ������ ��������

               if (X<=PaintBox.Width-15) and (X>=25+coord_axis_X) and (Y<=PaintBox.height-15-coord_axis_Y) and (Y>=15) then
               begin
                    if (X>=PaintBox.Width-30) then X:= PaintBox.Width-30;
                    if (X<=50+coord_axis_X) then X:=50+coord_axis_X;
                    if (Y>=PaintBox.height-30-coord_axis_Y) then Y:=PaintBox.height-30-coord_axis_Y;
                    if (Y<=30) then Y:=30;



                    MouseUpNone:=true;
                    EllipseOk  :=false;
                    Drawing    := true;
                    PaintBox.Canvas.MoveTo(X, Y);
                    Origin := Point(X, Y);
                    MovePt := Origin;

                    if (CurrentNode=0)and(Ferm.nyz1<=8) then
                    begin
                         with PaintBox.Canvas do
                         begin
                              pen.Mode   :=pmNotXor;
                              pen.Width  :=2;
                              pen.Color  :=clBlue;
                              brush.Color:=clWhite;
                              pen.Mode   :=pmNotXor;
                              Ellipse(X-3,Y-3,X+5,Y+5);
                              EllipseOk  :=true;
                              pen.Width  :=1;
                              pen.Color  :=clBlack;
                              brush.Color:=clSilver;
                         end;
                    end;

                    if CurrentNode=0 then
                    begin
                         Node1:=Ferm.nyz1+1;
                         Node2:=Ferm.nyz1+1;
                    end
                    else begin
                         Node1:=CurrentNode;
                         Node2:=CurrentNode;
                    end;

                    if (Ferm.nyz1=9) and (CurrentNode=0) then Drawing:=false;

                    Node1x:=round((X-50-coord_axis_X)*max_x_coord/(PaintBox.Width-80-coord_axis_X));
                    Node1y:=round((PaintBox.height-Y-30-coord_axis_Y)*max_y_coord/(PaintBox.height-60-coord_axis_Y));

               end
          end;
          6: begin   // ������� ����
               if CurrentNode<>0 then
               begin
                    NodeDelete:=CurrentNode;
                    i_node    :=NodeDelete;

                    for i:=i_node+1 to Ferm.nyz1 do
                    begin
                         Ferm.corn[i-1,1]:=Ferm.corn[i,1];
                         Ferm.corn[i,1]  :=0;
                         Ferm.corn[i-1,2]:=Ferm.corn[i,2];
                         Ferm.corn[i,2]  :=0;
                    end;
                    for i:=i_node+1 to Ferm.nyz1 do
                    begin
                         Ferm.msn[i-1,1]:=Ferm.msn[i,1];
                         Ferm.msn[i,1]  :=0;
                         Ferm.msn[i-1,2]:=Ferm.msn[i,2];
                         Ferm.msn[i,2]  :=0;
                    end;
                    for j:=1 to Ferm.nsn1 do
                    begin
                         for i:=i_node+1 to Ferm.nyz1 do
                         begin
                              Ferm.pn[(i-1)*2-1,j] :=Ferm.pn[i*2-1,j];
                              Ferm.pn[i*2-1,j]:=0;
                              Ferm.pn[(i-1)*2,j]   :=Ferm.pn[i*2,j];
                              Ferm.pn[i*2,j]  :=0;
                         end;
                    end;



                    Ferm.nyz1:=Ferm.nyz1-1;

                    Recursia(Self); // ������� �������, ��������� � ��������� �����

                    for i:=1 to Ferm.nst1 do  // ���������������� ���� ��������
                    begin
                         if Ferm.ITOPn[i,1]>i_node then Ferm.ITOPn[i,1]:=Ferm.ITOPn[i,1]-1;
                         if Ferm.ITOPn[i,2]>i_node then Ferm.ITOPn[i,2]:=Ferm.ITOPn[i,2]-1;
                    end;

                    if Ferm.nyz1=0 then
                    begin
                         Ferm.msn[1,1]:=0;
                         Ferm.msn[1,2]:=0;
                         for j:=1 to Ferm.nsn1 do
                         begin
                              Ferm.pn[1,j]:=0;
                              Ferm.pn[2,j]:=0;
                         end;
                    end
                    else if (Ferm.nyz1+1)=NodeDelete then
                         begin
                              Ferm.msn[NodeDelete,1]:=0;
                              Ferm.msn[NodeDelete,2]:=0;
                              for j:=1 to Ferm.nsn1 do
                              begin
                                   Ferm.pn[NodeDelete*2-1,j]:=0;
                                   Ferm.pn[NodeDelete*2,j]  :=0;
                              end;
                         end;

                    // ������ �� ���������� � ���� �����������
                    if Ferm.nyz1=0 then
                    begin
                         PaintBox.Cursor                                   :=crDefault;
                         Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
                         Main_Form.StatusBar1.Panels[1].Text               :='';
                    end;

                    isChanged:=true;
                    Caption:=concat('*',real_fname);
                    Ferma_Fd_Form.showD(Ferm);
                    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
                    Repaint;

               end;
          end; // ����� Case '6'

          3: begin // ������� ��������
               if PivotIdent<>0 then
               begin

                    DeletePivot(PivotIdent);
                    Ferm.nst1 :=Ferm.nst1-1;
                    isChanged :=true;
                    Caption:=concat('*',real_fname);
                    PivotIdent:=0;
                    if Ferm.nst1=0 then
                    begin
                         PaintBox.Cursor                                   :=crDefault;
                         Main_Form.StatusBar1.Panels[1].Text               := '';
                         Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
                    end;

                    Repaint;
                    Ferma_Fd_Form.showD(Ferm);
                    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);

               end;
          end; // ����� Case '3' (�������� �������)

          4: begin // �������� ������� + ����
               if PivotIdent<>0 then
               begin

                    if (PNode1=-1) and (PNode2=-1) then
                    begin
                         DeletePivot(PivotIdent);
                         Ferm.nst1:=Ferm.nst1-1;
                    end;
                    if PNode1<>-1 then
                    begin
                         i_node:=PNode1;

                         for i:=i_node+1 to Ferm.nyz1 do
                         begin
                              Ferm.corn[i-1,1]:=Ferm.corn[i,1];
                              Ferm.corn[i,1]  :=0;
                              Ferm.corn[i-1,2]:=Ferm.corn[i,2];
                              Ferm.corn[i,2]  :=0;
                         end;
                         for i:=i_node+1 to Ferm.nyz1 do
                         begin
                              Ferm.msn[i-1,1]:=Ferm.msn[i,1];
                              Ferm.msn[i,1]  :=0;
                              Ferm.msn[i-1,2]:=Ferm.msn[i,2];
                              Ferm.msn[i,2]  :=0;
                         end;
                         for j:=1 to Ferm.nsn1 do
                         begin
                              for i:=i_node+1 to Ferm.nyz1 do
                              begin
                                   Ferm.pn[(i-1)*2-1,j] :=Ferm.pn[i*2-1,j];
                                   Ferm.pn[i*2-1,j]:=0;
                                   Ferm.pn[(i-1)*2,j]   :=Ferm.pn[i*2,j];
                                   Ferm.pn[i*2,j]  :=0;
                              end;
                         end;

                         Ferm.nyz1:=Ferm.nyz1-1;

                         RecursiaPivot(PNode1); // ������� �������, ��������� � ��������� �����

                         for i:=1 to Ferm.nst1 do  // ���������������� ���� ��������
                         begin
                              if Ferm.ITOPn[i,1]>i_node then Ferm.ITOPn[i,1]:=Ferm.ITOPn[i,1]-1;
                              if Ferm.ITOPn[i,2]>i_node then Ferm.ITOPn[i,2]:=Ferm.ITOPn[i,2]-1;
                         end;

                         if Ferm.nyz1=0 then
                         begin
                              Ferm.msn[1,1]:=0;
                              Ferm.msn[1,2]:=0;
                              for j:=1 to Ferm.nsn1 do
                              begin
                                   Ferm.pn[1,j]:=0;
                                   Ferm.pn[2,j]:=0;
                              end;
                         end
                         else if (Ferm.nyz1+1)=i_node then
                              begin
                                   Ferm.msn[i_node,1]:=0;
                                   Ferm.msn[i_node,2]:=0;
                                   for j:=1 to Ferm.nsn1 do
                                   begin
                                        Ferm.pn[i_node*2-1,j]:=0;
                                        Ferm.pn[i_node*2,j]  :=0;
                                   end;
                              end;
                    end;

                    if PNode2<>-1 then
                    begin
                         if (PNode1<>-1) and (PNode1<PNode2) then i_node:=PNode2-1
                         else i_node:=PNode2;

                         for i:=i_node+1 to Ferm.nyz1 do
                         begin
                              Ferm.corn[i-1,1]:=Ferm.corn[i,1];
                              Ferm.corn[i,1]  :=0;
                              Ferm.corn[i-1,2]:=Ferm.corn[i,2];
                              Ferm.corn[i,2]  :=0;
                         end;
                         for i:=i_node+1 to Ferm.nyz1 do
                         begin
                              Ferm.msn[i-1,1]:=Ferm.msn[i,1];
                              Ferm.msn[i,1]  :=0;
                              Ferm.msn[i-1,2]:=Ferm.msn[i,2];
                              Ferm.msn[i,2]  :=0;
                         end;
                         for j:=1 to Ferm.nsn1 do
                         begin
                              for i:=i_node+1 to Ferm.nyz1 do
                              begin
                                   Ferm.pn[(i-1)*2-1,j] :=Ferm.pn[i*2-1,j];
                                   Ferm.pn[i*2-1,j]:=0;
                                   Ferm.pn[(i-1)*2,j]   :=Ferm.pn[i*2,j];
                                   Ferm.pn[i*2,j]  :=0;
                              end;
                         end;

                         Ferm.nyz1:=Ferm.nyz1-1;

                         RecursiaPivot(i_node); // ������� �������, ��������� � ��������� �����

                         for i:=1 to Ferm.nst1 do  // ���������������� ���� ��������
                         begin
                              if Ferm.ITOPn[i,1]>i_node then Ferm.ITOPn[i,1]:=Ferm.ITOPn[i,1]-1;
                              if Ferm.ITOPn[i,2]>i_node then Ferm.ITOPn[i,2]:=Ferm.ITOPn[i,2]-1;
                         end;

                         if Ferm.nyz1=0 then
                         begin
                              Ferm.msn[1,1]:=0;
                              Ferm.msn[1,2]:=0;
                              for j:=1 to Ferm.nsn1 do
                              begin
                                   Ferm.pn[1,j]:=0;
                                   Ferm.pn[2,j]:=0;
                              end;
                         end
                         else if (Ferm.nyz1+1)=i_node then
                              begin
                                   Ferm.msn[i_node,1]:=0;
                                   Ferm.msn[i_node,2]:=0;
                                   for j:=1 to Ferm.nsn1 do
                                   begin
                                        Ferm.pn[i_node*2-1,j]:=0;
                                        Ferm.pn[i_node*2,j]  :=0;
                                   end;
                              end;
                    end;

                    isChanged :=true;
                    Caption:=concat('*',real_fname);
                    PivotIdent:=0;
                    if Ferm.nst1=0 then
                    begin
                         PaintBox.Cursor                                   :=crDefault;
                         Main_Form.StatusBar1.Panels[1].Text               := '';
                         Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
                    end;
                    Repaint;
                    Ferma_Fd_Form.showD(Ferm);
                    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
               end;
          end; // ����� Case '4' (�������� ������� + ����)
     end;

end;

procedure TFerma_Form.RecursiaPivot(Node:Integer);
var
     i:Integer;
begin
     for i:=1 to F.nst1 do
     begin
          if (F.ITOPn[i,1]=Node) or (F.ITOPn[i,2]=Node) then
          begin
               DeletePivot(i);
               F.nst1:=F.nst1-1;
               RecursiaPivot(Node);
               break;
          end;
     end;
end;

procedure TFerma_Form.Fix_MenuClick(Sender: TObject);
var
     i:Integer;
begin
     if CurrentNode=0 then exit;

     FermaFixNode_Form.ShowModal;
     // FixNode_Form.Execute(ferm.msn[CurrentNode,1],ferm.msn[CurrentNode,2]);
     // ������� ���������� ������������ �����
     Ferm.ny1:=0;
     for i:=1 to Ferm.nyz1 do
          if (Ferm.msn[i,1] or Ferm.msn[i,2])<>0 then inc(Ferm.ny1);
     //  RePaint;
      ferma_FD_form.showD(ferm);
end;

procedure TFerma_Form.Force_MenuClick(Sender: TObject);
begin
     if CurrentNode=0 then exit;
     FermaForceNode_Form.XLabel.Caption:='���� �� X  ['+Ferm.s_for+']';
     FermaForceNode_Form.YLabel.Caption:='���� �� Y  ['+Ferm.s_for+']';
     FermaForceNode_Form.ShowModal;
     //  FermaForceNode_Form.Execute(Tag,ferm.Pn[CurrentNode*2-1,Tag],ferm.Pn[CurrentNode*2,Tag]);
     Repaint;
     Ferma_Fd_Form.showD(Ferm);
end;

procedure TFerma_Form.FileSave_MnuClick(Sender: TObject);
var
  Fn:string;
begin
     if not isNamed then FileSaveAs_MnuClick(Self)
     else begin
          SaveData;
          Fn:=filename;
          if AnsiContainsStr(Fn,'_tmp') then
          begin
            Delete(Fn,Pos('_tmp',Fn),4);
            deletefile(Fn);
            CopyFileTo(filename,Fn);
          end;
          if isSolved then
           begin
            if fileexists(changefileext(filename,'.smp')) and AnsiContainsStr(filename,'_tmp') then
              begin
               DeleteFile(changefileext(FN,'.smp'));
               CopyFileTo(changefileext(filename,'.smp'),changefileext(FN,'.smp'));
              end;
            if fileexists(changefileext(filename,'.vyv')) and AnsiContainsStr(filename,'_tmp') then
              begin
               DeleteFile(changefileext(FN,'.vyv'));
               CopyFileTo(changefileext(filename,'.vyv'),changefileext(FN,'.vyv'));
              end;
            if fileexists(changefileext(filename,'.vyf')) and AnsiContainsStr(filename,'_tmp') then
              begin
               DeleteFile(changefileext(FN,'.vyf'));
               CopyFileTo(changefileext(filename,'.vyf'),changefileext(FN,'.vyf'));
              end;
            if fileexists(changefileext(filename,'.nmi')) and AnsiContainsStr(filename,'_tmp') then
              begin
               DeleteFile(changefileext(FN,'.nmi'));
               CopyFileTo(changefileext(filename,'.nmi'),changefileext(FN,'.nmi'));
              end;
           end;
          isChanged:=false;
          //real_fname:=FileName;
          //Delete(real_fname,Pos('_tmp',real_fname),4);
          Caption:=real_fname;
     end;
end;

procedure TFerma_Form.FileSaveAs_MnuClick(Sender: TObject);
var
  i: integer;
  fhandle: THandle;
  old_FileName,s,Fn_to_Save: string;
  ff: System.text;
  ff1: textfile;
begin
     old_FileName:=FileName;


      if isChanged then
       begin
        if fileexists(changefileext(old_FileName,'.smp')) then
           deletefile(changefileext(old_FileName,'.smp'));
        if fileexists(changefileext(old_FileName,'.vyv')) then
           deletefile(changefileext(old_FileName,'.vyv'));
        if fileexists(changefileext(old_FileName,'.vyf')) then
           deletefile(changefileext(old_FileName,'.vyf'));
        if fileexists(changefileext(old_FileName,'.nmi')) then
           deletefile(changefileext(old_FileName,'.nmi'));
       end;
     Fn_to_Save := FileName;
     if AnsiContainsStr(Fn_to_Save,'_tmp') then
        Delete(Fn_to_Save,Pos('_tmp',Fn_to_Save),4);
     SaveCancel         :=true;
     SaveDialog.FileName:=Fn_to_Save;
     if SaveDialog.Execute then
     begin
          FileName:=SaveDialog.FileName;
          Caption :=ExtractFileName(FileName);
          real_fname:=Caption;
          SaveData;
          isNamed   :=true;
          isChanged :=false;
          //real_fname:=FileName;
          //Delete(real_fname,Pos('_tmp',real_fname),4);
          //Caption:=real_fname;
          SaveCancel:=false;

      {if FileName <> old_FileName then
      begin
       if fileexists(changefileext(old_FileName,'.smp')) then
        begin
          assignfile(ff,changefileext(old_FileName,'.smp'));
          assignfile(ff1,changefileext(FileName,'.smp'));
          rewrite(ff1);
          reset(ff);
          for i:=1 to 6 do
            begin
             readln(ff,s);
             writeln(ff1,s);
            end;
          closefile(ff);
          closefile(ff1);
        end;
      end;}

      if fileexists(changefileext(old_FileName,'.smp')) and AnsiContainsStr(old_FileName,'_tmp') then
         begin
           CopyFileTo(changefileext(old_filename,'.smp'),changefileext(FileName,'.smp'));
           deletefile(changefileext(old_FileName,'.smp'));
         end;
      if fileexists(changefileext(old_FileName,'.vyv')) and AnsiContainsStr(old_FileName,'_tmp') then
         begin
           CopyFileTo(changefileext(old_filename,'.vyv'),changefileext(FileName,'.vyv'));
           deletefile(changefileext(old_FileName,'.vyv'));
         end;
      if fileexists(changefileext(old_FileName,'.vyf')) and AnsiContainsStr(old_FileName,'_tmp') then
         begin
           CopyFileTo(changefileext(old_filename,'.vyf'),changefileext(FileName,'.vyf'));
           deletefile(changefileext(old_FileName,'.vyf'));
         end;
      if fileexists(changefileext(old_FileName,'.nmi')) and AnsiContainsStr(old_FileName,'_tmp') then
         begin
           CopyFileTo(changefileext(old_filename,'.nmi'),changefileext(FileName,'.nmi'));
           deletefile(changefileext(old_FileName,'.nmi'));
         end;
            if fileexists(old_FileName) and AnsiContainsStr(old_FileName,'_tmp') then
              deletefile(old_FileName);
     end;
end;

procedure TFerma_Form.SimpleSolve_MnuClick(Sender: TObject);
type
     TMethodProc=procedure(Fn:PChar);
var
     LibHandle:THandle;
     DllName:string;
     sp:TMethodProc;
     w,k,i,Flag,j,FH:Integer;
     Fn:string;
     f1,f2,f3:System.Text;
     Version_VYV,tmpStr,buf,s:string;
begin
     isSolved:=true;
     if Ferm.nyz1=0 then
     begin
          //Beep;
          MessageDlg(chr(13)+'���������� ���������� �������������� �����������!' ,mtError,[mbOk],0);
          exit;
     end;

     //�������� �� ������������ ���� (�� ������������� �� ������ �������)
     for i:=1 to Ferm.nyz1 do
     begin
          Flag:=-1;
          for j:=1 to Ferm.nst1 do
          begin
               if (Ferm.ITOPn[j,1]=i) or (Ferm.ITOPn[j,2]=i) then
               begin
                    Flag:=0;
                    break;
               end;
          end;
          if (Flag=-1) then break;
     end;
     if Flag=-1 then Flag:=MessageDlg(chr(13)+'� ������ ����������� ���� ����/���� �� ������������� �� ������ �������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;

     k:=0;
     for i:=1 to Ferm.nyz1 do
     begin
          k:=k+Ferm.msn[i,1]+Ferm.msn[i,2];
     end;
     w:=2*Ferm.nyz1-Ferm.nst1-k;
     if w>0 then Flag:=MessageDlg(chr(13)+'������ ����������� ������������ ����� ��������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;

     DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';

     if isChanged then
       begin
         Flag:=MessageDlg(chr(13)+'����������� ���� ��������! ����� �������� ��������� ����� ���������. ����������?' ,mtWarning,[mbYes,mbNo],0);
         if Flag=mrYes then
           Main_Form.Save_TBtnClick(Sender);
         if Flag=mrNo then exit;
         SaveData;
         isChanged:=false;
         //real_fname:=FileName;
         //Delete(real_fname,Pos('_tmp',real_fname),4);
         Caption:=real_fname;
       end;
     Main_Form.Save_TBtnClick(Sender);
     if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');
     Cursor:=crHourGlass;
     try
          sp(PChar(FileName));
     finally
          Cursor:=crDefault;
     end;

     Main_Form.SimpleResult_TB.Enabled:=true;
     Main_Form.ToolButton7.Enabled    :=true;
     //SimpleResults_Mnu.Enabled        :=true;
     //N7.Enabled                       :=true;
     //SimpleFermResult_form.tag:= 1;
     //if isChanged then isChanged:=false;
     //SimpleResults_Mnu.Click;
     //SimpleFermResult_form.tag:= 0;
     Simple_panel_draw(Sender);
     Fn:=filename;
          if AnsiContainsStr(Fn,'_tmp') then
          begin
            Delete(Fn,Pos('_tmp',Fn),4);
            deletefile(Fn);
            CopyFileTo(filename,Fn);
          end;

          if fileexists(changefileext(filename,'.smp')) and AnsiContainsStr(filename,'_tmp') then
             CopyFileTo(changefileext(filename,'.smp'),changefileext(FN,'.smp'));
          if fileexists(changefileext(filename,'.vyv')) and AnsiContainsStr(filename,'_tmp') then
           begin

             AssignFile(f1,ChangeFileExt(filename,'.vyv'));
             reset(f1);
             {$I-}
             Reset(f1);
             {$I+}
             if IOResult <> 0 then
               begin
               MessageDlg('File access error', mtWarning, [mbOk], 0);
               exit;
             end;

             readln(f1,Version_VYV);
             Delete(Version_VYV,Pos('_tmp',Version_VYV),4);
             //FileCreate(ChangeFileExt(FN,'.vyv'));
             AssignFile(f2,ChangeFileExt(FN,'.vyv'));
             rewrite(f2);
             writeln(f2,Version_VYV);
             i:=0;
             while not SeekEof(f1) do
             begin
                i:=i+1;
                readln(f1,tmpStr);
                if i=4 then
                  begin
                    if tmpStr<>FloatToStr(Ferm.e1) then
                    writeln(f2,Ferm.e1);
                  end
                else
                  writeln(f2,tmpStr);
             end;
             CloseFile(f1);
             CloseFile(f2);
             DeleteFile(ChangeFileExt(filename,'.vyv'));
             CopyFileTo(changefileext(FN,'.vyv'),changefileext(filename,'.vyv'));
           end
          else
           Begin // ��������� �� ����� .vyv ��� � ���� .tmp ����� ������ �����.

            //FH:=FileCreate(changefileext(filename,'.tmp'));
             AssignFile(f1,ChangeFileExt(filename,'.vyv'));
             AssignFile(f3,ChangeFileExt(filename,'.tmp'));
             reset(f1);
             rewrite(f3);
             i:=0;
             while not SeekEof(f1) do
             begin
                i:=i+1;
                readln(f1,tmpStr);
                if i=5 then
                  begin
                    if tmpStr<>FloatToStr(Ferm.e1) then
                    writeln(f3,Ferm.e1);
                  end
                else
                  writeln(f3,tmpStr);
             end;
              {begin
                 readln(f1,tmpStr);
                 writeln(f3,tmpStr);
              end;}

               CloseFile(f1);
               CloseFile(f3);

            // ������ ���� .vyv � ������� �������� � ������� ����� �� .tmp
             DeleteFile(ChangeFileExt(filename,'.vyv'));
             RenameFile(changefileext(filename,'.tmp'),changefileext(FN,'.vyv'));
             //DeleteFile(ChangeFileExt(filename,'.tmp'));
           end;

          if fileexists(changefileext(filename,'.vyf')) and AnsiContainsStr(filename,'_tmp') then
             CopyFileTo(changefileext(filename,'.vyf'),changefileext(FN,'.vyf'));
          if fileexists(changefileext(filename,'.nmi')) and AnsiContainsStr(filename,'_tmp') then
             CopyFileTo(changefileext(filename,'.nmi'),changefileext(FN,'.nmi'));


     Flag:=MessageDlg(chr(13)+'������ ��������. �������� ����������?',mtInformation,[mbYes,mbNo],0);
     SimpleFermResult_form.tag:= 1;
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);
     SimpleFermResult_form.tag:= 0;
     Simple_panel_draw(Sender);
     
     if Flag=mrNo then
      begin
       //isChanged:=true;
       exit;
      end;
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);
end;


procedure TFerma_Form.SolveOpt_Mnu1Click(Sender: TObject);
var
  Flag: integer;
begin
     if isChanged then
       begin
         //Flag:=MessageDlg(chr(13)+'����������� ���� ��������! ����� ������������ ��������� ����� ���������. ����������?',mtWarning,mbOkCancel,0);
         //if Flag=mrOk then
         //  FileSave_MnuClick(Sender);
         //if Flag=mrCancel then exit;
         SaveData;
       end;

     if Ferma_SelectMetod=nil then
     Ferma_SelectMetod:=TFerma_SelectMetod.Create(self);
     //Ferma_SelectMetod.Close;
     Ferma_SelectMetod.Show;
     //Main_Form.BitBtn10.Enabled := true;
end;

procedure TFerma_Form.SolveOpt_MnuClick(Sender: TObject);
var
     i:Integer;
     fmi,ebsi:single;
     maxkit,ljambda,Flag:Integer;
     material:string;
     S:string;
begin
     if Ferm.nyz1=0 then
     begin
          //Beep;
          MessageDlg(chr(13)+'���������� ���������� �������������� �����������!' ,mtError,[mbOk],0);
          exit;
     end;
     if not FermOptParam_Form.Execute(fmi,ebsi,maxkit,ljambda) then exit;

     //if isChanged then FileSave_MnuClick(nil);
     //if SaveCancel then exit;


     for i:=1 to Main_Form.Ferma_num_mat+2 do
          if (Main_Form.Ferma_MMaterials[i].MModUpr = Ferm.e1) and
             (Main_Form.Ferma_MMaterials[i].MDopNapr = Ferm.sd1) then
          begin
               material := Main_Form.Ferma_MMaterials[i].MName;
          end;
     i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'opt_f.dll',FileName,Ferm,material,fmi,ebsi,maxkit,ljambda);
     Case i of
          0: S:='������� ��������� ���������.';
          1: begin
               S                             :='���������� ���������� ����� ��������.';
               Main_Form.BitBtn10.Enabled:=true;
          end;
          2: begin
               S                             :='���������� �������� ��������.';
               Main_Form.BitBtn10.Enabled:=true;
          end;
     else begin
          S                             :='��������� ���������� ������. ���������� ��������� �������� (������ ��������, ��-��!)';
          Main_Form.BitBtn10.Enabled:=false;
     end;
     end;
     if i in [0..2] then
       begin
        //N8.Enabled            :=true;
        Main_Form.BitBtn10.Enabled:=true;
        last_opt_type         :=2;
        isParmOpt:=true;
       end
     else
       Main_Form.BitBtn10.Enabled := false;
       //MessageDlg(#13+'������ ��������. '+S,mtInformation,[mbOk],0);
       if i=2 then
       begin
         Flag:=MessageDlg(chr(13)+'������ ��������. ���������� �������� ��������. �������� ����������?' ,mtInformation,[mbYes,mbNo],0);
         if flag=mrNo then
           exit;
         if FileExists(ChangeFileExt(FileName,'.vyf')) then
           //Ferma_Form.OptResults_MnuClick(Sender)
           FermOptResults_Form.Execute(ChangeFileExt(FileName,'.vyf'))
         else if FileExists(ChangeFileExt(FileName,'.rw1')) then
           //Ferma_Form.OptResultsVC1_MnuClick(Sender);
       end
       else
       Main_Form.StatusBar1.Panels[2].Text:= '������ ��������. '+S;

end;









function TestParams;
var
     i,k,w,Flag,j:Integer;
begin
     with Sender do
     begin
          //�������� �� ������������ ���� (�� ������������� �� ������ �������)
          for i:=1 to Ferm.nyz1 do
          begin
               Flag:=-1;
               for j:=1 to Ferm.nst1 do
               begin
                    if (Ferm.ITOPn[j,1]=i) or (Ferm.ITOPn[j,2]=i) then
                    begin
                         Flag:=0;
                         break;
                    end;
               end;
               if (Flag=-1) then break;
          end;
          if Flag=-1 then Flag:=MessageDlg(chr(13)+'� ������ ����������� ���� ����/���� �� ������������� �� ������ �������! ����������?' ,mtWarning,[mbYes,mbNo],0);
          if Flag=mrNo then
          begin
               Result:=false;
               exit;
          end;
          k:=0;
          for i:=1 to Ferm.nyz1 do
          begin
               k:=k+Ferm.msn[i,1]+Ferm.msn[i,2];
          end;
          w:=2*Ferm.nyz1-Ferm.nst1-k;
          if w>0 then Flag:=MessageDlg(chr(13)+'������ ����������� ������������ ����� ��������! ����������?' ,mtWarning,[mbYes,mbNo],0);
          if Flag=mrNo then
          begin
               Result:=false;
               exit;
          end;
     end;
     Result:=true;
end;
function MoyGemoroy;
type
     TMethodProc=function(Fn:PChar;material:string;ini_file:string;fmi,ebsi:single;maxkit,ljambda:Integer):Integer;
var
     LibHandle:THandle;
     ini_file:string;
     sp:TMethodProc;
     i,j:Integer;
     Fn:string;
     f1,f2,f3:System.Text;
     Version_VYF,tmpStr,buf:string;
begin
     if not FileExists(DllName) then
     begin
          ShowMessage('�� ������� DLL ����������'+#13+DllName);
          exit;
     end;
     if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+DllName+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp          :=GetProcAddress(LibHandle,'OptFerm');
     Screen.Cursor:=crHourGlass;
     ini_file     := ExtractFilePath(Application.ExeName); //�������� ���� ini-����� � phi
     try
          j            :=sp(PChar(FileName),material,ini_file,fmi,ebsi,maxkit,ljambda);
     finally
          Screen.Cursor:=crDefault;
     end;
     AssignFile(f1,ChangeFileExt(filename,'.vyf'));
             reset(f1);
             {$I-}
             Reset(f1);
             {$I+}
             if IOResult <> 0 then
               begin
               MessageDlg('File access error', mtWarning, [mbOk], 0);
               exit;
             end;

             readln(f1,Version_VYF);
             Delete(Version_VYF,Pos('_tmp',Version_VYF),4);
             //FileCreate(ChangeFileExt(FN,'.vyv'));
             AssignFile(f2,ChangeFileExt(filename,'.tvyf'));
             rewrite(f2);
             writeln(f2,Version_VYF);
             i:=0;
             while not SeekEof(f1) do
             begin
                i:=i+1;
                readln(f1,tmpStr);
                if i=4 then
                  begin
                    if tmpStr<>FloatToStr(Ferm.e1) then
                      if tmpStr<>' ' then writeln(f2,Ferm.e1);
                  end
                else
                  if tmpStr<>' ' then writeln(f2,tmpStr);
             end;
             CloseFile(f1);
             CloseFile(f2);
             DeleteFile(ChangeFileExt(filename,'.vyf'));
             RenameFile(changefileext(filename,'.tvyf'),changefileext(filename,'.vyf'));
     Result:=j;
     FreeLibrary(LibHandle);
end;

procedure TFerma_Form.SimpleResults_MnuClick(Sender: TObject);
var
     Version_VYV,tmp,Fname: string;
     f1:System.Text;
     ff:File of Byte;
     mg:Integer;
begin

     // �������� �� ������������� ����� �������
     if FileExists(ChangeFileExt(FileName,'.vyv')) then
     begin
          AssignFile(f1,ChangeFileExt(FileName,'.vyv'));
          reset(f1);
          readln(f1,Version_VYV);
          CloseFile(f1);
     end
     else Version_VYV:='Error';

     if Version_VYV='Error' then
     begin
          //Beep;
          MessageDlg(#13+'���� � ������� �������� �� ������.',mtError,[mbOk],0);
          exit;
     end;

     // �������� �� ������������� ������ ������ ������ � �������� ��������
     if FileExists(FileName) then
     begin
          AssignFile(ff,FileName);
          reset(ff);
          mg:=filesize(ff);
          CloseFile(ff);
     end
     else begin
          //Beep;
          MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#13+'����������� ������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
          exit;
     end;
     if not AnsiContainsStr(Version_VYV,'_tmp') then
        begin
         Fname:= ExtractFileName(FileName);
         Delete(Fname,Pos('_tmp',Fname),4);
         tmp:= (Fname+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))))
        end
     else
      tmp:= (ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))));
     if ((Version_VYV)<>tmp) or (isChanged=true) then
         begin
           //Beep;
           MessageDlg('������������ ������ ������ � ������� � �������� �������.'+#13+'����������� ������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
           exit;
         end;
     // ����� ����������� �������� �������
       SimpleFermResult_Form.Execute(ChangeFileExt(FileName,'.vyv'));
     //SimpleFermResult_Form.Moves_BtnClick(Self);
end;

procedure TFerma_Form.OptResultsVC1_MnuClick(Sender: TObject);
var
     Version_VC1:string;
     f1:System.Text;
     ff:File of Byte;
     mg:Integer;
begin
     // �������� �� ������������� ����� �������
     if FileExists(ChangeFileExt(FileName,'.rw1')) then
     begin
          AssignFile(f1,ChangeFileExt(FileName,'.rw1'));
          reset(f1);
          readln(f1,Version_VC1);
          CloseFile(f1);
     end
     else Version_VC1:='Error';

     if Version_VC1='Error' then
     begin
          //Beep;
          MessageDlg(#13+'���� � ��������������� ��������'+#13+'�� ������.(� ������ ��������, ���������� �� ������)',mtError,[mbOk],0);
          exit;
     end;
     if FileExists(ChangeFileExt(FileName,'.ro1')) then
     begin
          AssignFile(f1,ChangeFileExt(FileName,'.ro1'));
          reset(f1);
          readln(f1,Version_VC1);
          CloseFile(f1);
     end
     else Version_VC1:='Error';

     if Version_VC1='Error' then
     begin
          //Beep;
          MessageDlg(#13+'���� � ��������������� �������� �� ������.'+#13+'(��� ����� ��������, ���������� �� ������)',mtError,[mbOk],0);
          exit;
     end;

{     // �������� �� ������������� ������ ������ ������ � ���������������� �������
     if FileExists(FileName) then
     begin
          AssignFile(ff,FileName);
          reset(ff);
          mg:=filesize(ff);
          CloseFile(ff);
     end
     else begin
          //Beep;
          MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
          exit;
     end;

     if ((Version_VYF)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
         or (isChanged=true) then
     begin
          //Beep;
          MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
          exit;
     end;  }
     FermaRezVC1.Execute(ChangeFileExt(FileName,'.rw1'),ChangeFileExt(FileName,'.ro1'));
end;


procedure TFerma_Form.OptResults_MnuClick(Sender: TObject);
var
     Version_VYF,tmp,Fname:string;
     f1:System.Text;
     ff:File of Byte;
     mg:Integer;
begin
     // �������� �� ������������� ����� �������
     if FileExists(ChangeFileExt(FileName,'.vyf')) then
     begin
          AssignFile(f1,ChangeFileExt(FileName,'.vyf'));
          reset(f1);
          readln(f1,Version_VYF);
          CloseFile(f1);
     end
     else Version_VYF:='Error';

     if Version_VYF='Error' then
     begin
          //Beep;
          MessageDlg(#13+'���� � ��������������� �������� �� ������.',mtError,[mbOk],0);
          exit;
     end;

     // �������� �� ������������� ������ ������ ������ � ���������������� �������
     if FileExists(FileName) then
     begin
          AssignFile(ff,FileName);
          reset(ff);
          mg:=filesize(ff);
          CloseFile(ff);
     end
     else begin
          //Beep;
          MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
          exit;
     end;

     if not AnsiContainsStr(Version_VYF,'_tmp') then
        begin
         Fname:= ExtractFileName(FileName);
         Delete(Fname,Pos('_tmp',Fname),4);
         tmp:= (Fname+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))))
        end
     else
      tmp:= (ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))));

     if ((Version_VYF)<> tmp) or (isChanged=true) then
     begin
          //Beep;
          MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
          exit;
     end;
     FermOptResults_Form.Execute(ChangeFileExt(FileName,'.vyf'));
end;



//============================================================================//
procedure TFerma_Form.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
     ux,uy,RealXReal,RealYReal:extended;
     i,j,flg,what_do,RealX,RealY,x1,y1,x2,y2,xtop,ytop,xbot,ybot,x_max,y_max:Integer;
     yline,PivotOk:Integer;
     max_x_coord,max_y_coord,mas_x,mas_y:extended;
     NodeStr,HelpStr, Node_Str:string;
     Node1Ok, Node2Ok:boolean;
     Node1Ok_, Node2Ok_:boolean;
     PNode1_, PNode2_:Integer;
begin
     if Active then
     begin

          what_do:=0;
          // ����� ������ ������ ?
          for i:=0 to Main.Main_Form.Ferma_Graph_Enter_Panel.ButtonCount-1 do
          begin
               if Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Down = true then what_do:=Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Tag;
          end;

          // ��� ����� ����� ��������� ������ ?
          max_x_coord:=Ferm.region_x;
          max_y_coord:=Ferm.region_y;
          CurrentNode:=0;
          for i:=1 to Ferm.nyz1 do
          begin
               ux:=50+coord_axis_X+(PaintBox.Width-80-coord_axis_X)/max_x_coord*(Ferm.corn[i,1]);
               uy:=PaintBox.height-30-coord_axis_Y-(PaintBox.height-60-coord_axis_Y)/max_y_coord*Ferm.corn[i,2];
               if (X>ux-10)and(X<ux+10)and(Y>uy-10)and(Y<uy+10) then
                  begin
                    CurrentNode:=i;
                    break;
               end;
          end;

          Case what_do of
               7: begin //���������� � ��������
                    if CurrentNode=0 then Application.CancelHint;
                    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PaintBox.Hint:='���� � '+IntToStr(CurrentNode);
               end;

               //������// ������� �.�.
              12: begin // ����������� �������
               if Drawing then
               begin
                    RealX    :=round((X-50-coord_axis_X)*max_x_coord/(PaintBox.Width-80-coord_axis_X));
                    RealY    :=round((PaintBox.height-Y-30-coord_axis_Y)*max_y_coord/(PaintBox.height-60-coord_axis_Y));

                    RealXReal:=RealX;
                    RealYReal:=RealY;

                    if RealX>max_x_coord then RealXReal:=max_x_coord;
                    if RealX<0 then RealXReal:=0;
                    if RealY<0 then RealYReal:=0;
                    if RealY>max_y_coord then RealYReal:=max_y_coord;

                    if (X>PaintBox.Width-30) or
                    (X<50+coord_axis_X) or
                    (Y>PaintBox.height-30-coord_axis_Y) or
                    (Y<30) then Flg:=-1
                    else flg:=0;

                    NodeX:=RealXReal;
                    NodeY:=RealYReal;

                    if (flg=-1) then
                    begin
                //         NodeOk                             :=false;
                         Main_Form.StatusBar1.Panels[0].Text:='[- : -]';
                         Main_Form.StatusBar1.Panels[1].Text:='��� �������� �������';
                         Main_Form.StatusBar1.Panels[2].Text :='����������� ������ � ���������� �������';
                    end
                    else begin
                         Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal]);
                         Main_Form.StatusBar1.Panels[1].Text := NodeStr;
                         Main_Form.StatusBar1.Panels[2].Text := HelpStr;
                    end;
                    if (MCurrentNode>0) then
                     begin
                      Ferm.corn[MCurrentNode,1]:=NodeX;
                      Ferm.corn[MCurrentNode,2]:=NodeY;
                      Repaint;
                     end;
               end;
               end;
                //����� // ������� �.�.

               9: begin //������� �������
                    PivotOk:=0;

                    for i:=1 to Ferm.nst1 do
                    begin
                         x_max:=PaintBox.Width;
                         y_max:=PaintBox.height;
                         mas_x:=(x_max-80-coord_axis_X)/max_x_coord; //�������������� ������������
                         mas_y:=(y_max-60-coord_axis_Y)/max_y_coord;
                         x1   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,1],1]);
                         y1   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,1],2]);
                         x2   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,2],1]);
                         y2   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,2],2]);

                         if x1>=x2 then
                         begin xtop:=x1;xbot:=x2;
                         end
                         else begin xtop:=x2;xbot:=x1;
                         end;
                         if y1>=y2 then
                         begin ytop:=y1;ybot:=y2;
                         end
                         else begin ytop:=y2;ybot:=y1;
                         end;

                         if (X>=xbot-2) and (X<=xtop+2) and (Y>=ybot-2) and (Y<=ytop+2) then
                         begin
                              if x1<>x2 then
                              begin
                                   yline:=round((X-x1)*(y2-y1)/(x2-x1))+y1;
                                   if (Y<=yline+2) and (Y>=yline-2) then
                                   begin
                                        Main_Form.StatusBar1.Panels[1].Text := 'C������� �'+IntToStr(i)+' ['+FloatToStr(Ferm.Fn[i])+' '+Ferm.s_lin+'**2]';
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end
                              else begin
                                   if (X<=X+2) and (X>=X-2) then
                                   begin
                                        Main_Form.StatusBar1.Panels[1].Text := 'C������� �'+IntToStr(i)+' ['+FloatToStr(Ferm.Fn[i])+' '+Ferm.s_lin+'**2]';
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end;
                         end;  // ����� IF � �������� �� �� � ������� ������������ ������ �������

                    end; // ����� ����� �� �������� � �������� �� ��� ?

                    PaintBox.Canvas.pen.Mode :=pmNotXor;
                    PaintBox.Canvas.pen.Color:=clBlue;
                    PaintBox.Canvas.pen.Width:=3;
                    if TolOk>=3 then TolOk:=0;
                    if (PivotOk=1) and (PivotIdent<>0) then
                    begin
                         if PivotIdent<>i then
                         begin
                              PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                              PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                              PaintBox.Canvas.MoveTo(x1, y1);
                              PaintBox.Canvas.LineTo(x2, y2);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end;
                         if TolOk=1 then
                         begin
                              TolOk:=3;
                         end;
                    end
                    else if (PivotOk=1) and (PivotIdent=0) then
                         begin
                              PaintBox.Canvas.MoveTo(x1, y1);
                              PaintBox.Canvas.LineTo(x2, y2);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end
                         else if (PivotOk=0) and (PivotIdent<>0) then
                              begin
                                   PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                                   PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                                   PivotIdent                         :=0;
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end
                              else begin
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end;

                    PaintBox.Canvas.pen.Width:=1;
                    PaintBox.Canvas.pen.Mode :=pmCopy;

               end;
               3: begin // �������� �������
                    PivotOk:=0;

                    for i:=1 to Ferm.nst1 do
                    begin
                         x_max:=PaintBox.Width;
                         y_max:=PaintBox.height;
                         mas_x:=(x_max-80-coord_axis_X)/max_x_coord; //�������������� ������������
                         mas_y:=(y_max-60-coord_axis_Y)/max_y_coord;
                         x1   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,1],1]);
                         y1   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,1],2]);
                         x2   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,2],1]);
                         y2   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,2],2]);

                         if x1>=x2 then
                         begin xtop:=x1;xbot:=x2;
                         end
                         else begin xtop:=x2;xbot:=x1;
                         end;
                         if y1>=y2 then
                         begin ytop:=y1;ybot:=y2;
                         end
                         else begin ytop:=y2;ybot:=y1;
                         end;

                         if (X>=xbot-2) and (X<=xtop+2) and (Y>=ybot-2) and (Y<=ytop+2) then
                         begin
                              if x1<>x2 then
                              begin
                                   yline:=round((X-x1)*(y2-y1)/(x2-x1))+y1;
                                   if (Y<=yline+2) and (Y>=yline-2) then
                                   begin
                                        Main_Form.StatusBar1.Panels[1].Text := '������� �������� �'+IntToStr(i);
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end
                              else begin
                                   if (X<=X+2) and (X>=X-2) then
                                   begin
                                        Main_Form.StatusBar1.Panels[1].Text := '������� �������� �'+IntToStr(i);
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end;
                         end;  // ����� IF � �������� �� �� � ������� ������������ ������ �������

                    end; // ����� ����� �� �������� � �������� �� ��� ?

                    PaintBox.Canvas.pen.Mode :=pmNotXor;
                    PaintBox.Canvas.pen.Color:=clBlue;
                    PaintBox.Canvas.pen.Width:=3;
                    if (PivotOk=1) and (PivotIdent<>0) then
                    begin
                         if PivotIdent<>i then
                         begin
                              PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                              PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                              PaintBox.Canvas.MoveTo(x1, y1);
                              PaintBox.Canvas.LineTo(x2, y2);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end;
                    end
                    else if (PivotOk=1) and (PivotIdent=0) then
                         begin
                              PaintBox.Canvas.MoveTo(x1, y1);
                              PaintBox.Canvas.LineTo(x2, y2);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end
                         else if (PivotOk=0) and (PivotIdent<>0) then
                              begin
                                   PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                                   PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                                   PivotIdent                         :=0;
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end
                              else begin
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end;

                    PaintBox.Canvas.pen.Width:=1;
                    PaintBox.Canvas.pen.Mode :=pmCopy;
               end;// ����� Case '3'

               4: begin // �������� ������� + ����
                    PivotOk:=0;

                    for i:=1 to Ferm.nst1 do
                    begin
                         x_max:=PaintBox.Width;
                         y_max:=PaintBox.height;
                         mas_x:=(x_max-80-coord_axis_X)/max_x_coord; //�������������� ������������
                         mas_y:=(y_max-60-coord_axis_Y)/max_y_coord;
                         x1   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,1],1]);
                         y1   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,1],2]);
                         x2   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[i,2],1]);
                         y2   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[i,2],2]);

                         if x1>=x2 then
                         begin xtop:=x1;xbot:=x2;
                         end
                         else begin xtop:=x2;xbot:=x1;
                         end;
                         if y1>=y2 then
                         begin ytop:=y1;ybot:=y2;
                         end
                         else begin ytop:=y2;ybot:=y1;
                         end;

                         if (X>=xbot-2) and (X<=xtop+2) and (Y>=ybot-2) and (Y<=ytop+2) then
                         begin
                              if x1<>x2 then
                              begin
                                   yline:=round((X-x1)*(y2-y1)/(x2-x1))+y1;
                                   if (Y<=yline+2) and (Y>=yline-2) then
                                   begin
                                        PNode1 :=-1;
                                        PNode2 :=-1;
                                        PNode1 :=Ferm.ITOPn[i,1];
                                        PNode2 :=Ferm.ITOPn[i,2];
                                        Node1Ok:=true;
                                        Node2Ok:=true;
                                        for j:=1 to Ferm.nst1 do
                                        begin
                                             if j<>i then
                                             begin
                                                  if (Ferm.ITOPn[j,1]=PNode1) or (Ferm.ITOPn[j,2]=PNode1) then Node1Ok:=false;
                                                  if (Ferm.ITOPn[j,1]=PNode2) or (Ferm.ITOPn[j,2]=PNode2) then Node2Ok:=false;
                                             end;
                                        end;

                                        Node_Str:=' + ���� �'+IntToStr(PNode1)+', �'+IntToStr(PNode2);
                                        if (not Node1Ok) and (not Node2Ok) then
                                        begin
                                             PNode1  :=-1;
                                             PNode2  :=-1;
                                             Node_Str:='';
                                        end;
                                        if Node1Ok  and (not Node2Ok) then
                                        begin
                                             PNode2  :=-1;
                                             Node_Str:=' + ���� �'+IntToStr(PNode1);
                                        end;
                                        if Node2Ok  and (not Node1Ok) then
                                        begin
                                             PNode1  :=-1;
                                             Node_Str:=' + ���� �'+IntToStr(PNode2);
                                        end;

                                        Main_Form.StatusBar1.Panels[1].Text := '������� �������� �'+IntToStr(i)+Node_Str;
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end
                              else begin
                                   if (X<=X+2) and (X>=X-2) then
                                   begin
                                        PNode1 :=-1;
                                        PNode2 :=-1;
                                        PNode1 :=Ferm.ITOPn[i,1];
                                        PNode2 :=Ferm.ITOPn[i,2];
                                        Node1Ok:=true;
                                        Node2Ok:=true;
                                        for j:=1 to Ferm.nst1 do
                                        begin
                                             if j<>i then
                                             begin
                                                  if (Ferm.ITOPn[j,1]=PNode1) or (Ferm.ITOPn[j,2]=PNode1) then Node1Ok:=false;
                                                  if (Ferm.ITOPn[j,1]=PNode2) or (Ferm.ITOPn[j,2]=PNode2) then Node2Ok:=false;
                                             end;
                                        end;

                                        Node_Str:=' + ���� �'+IntToStr(PNode1)+', �'+IntToStr(PNode2);
                                        if (not Node1Ok) and (not Node2Ok) then
                                        begin
                                             PNode1  :=-1;
                                             PNode2  :=-1;
                                             Node_Str:='';
                                        end;
                                        if Node1Ok  and (not Node2Ok) then
                                        begin
                                             PNode2  :=-1;
                                             Node_Str:=' + ���� �'+IntToStr(PNode1);
                                        end;
                                        if Node2Ok  and (not Node1Ok) then
                                        begin
                                             PNode1  :=-1;
                                             Node_Str:=' + ���� �'+IntToStr(PNode2);
                                        end;
                                        Main_Form.StatusBar1.Panels[1].Text := '������� �������� �'+IntToStr(i)+Node_Str;
                                        PivotOk                            :=1;
                                        break;
                                   end;
                              end;
                         end;  // ����� IF � �������� �� �� � ������� ������������ ������ �������

                    end; // ����� ����� �� �������� � �������� �� ��� ?

                    //=================== ����� ��� ���������, ��������� �����======================
                    if PivotIdent<>0 then
                    begin
                         PNode1_ :=Ferm.ITOPn[PivotIdent,1];
                         PNode2_ :=Ferm.ITOPn[PivotIdent,2];
                         Node1Ok_:=true;
                         Node2Ok_:=true;
                         for j:=1 to Ferm.nst1 do
                         begin
                              if j<>PivotIdent then
                              begin
                                   if (Ferm.ITOPn[j,1]=PNode1_) or (Ferm.ITOPn[j,2]=PNode1_) then Node1Ok_:=false;
                                   if (Ferm.ITOPn[j,1]=PNode2_) or (Ferm.ITOPn[j,2]=PNode2_) then Node2Ok_:=false;
                              end;
                         end;
                    end;
                    //==============================================================================

                    PaintBox.Canvas.pen.Mode :=pmNotXor;
                    PaintBox.Canvas.pen.Color:=clBlue;
                    PaintBox.Canvas.pen.Width:=3;
                    if (PivotOk=1) and (PivotIdent<>0) then
                    begin
                         if PivotIdent<>i then
                         begin
                              PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                              if Node1Ok_ then       PaintBox.Canvas.Ellipse(PivotX1-3,PivotY1-3,PivotX1+5,PivotY1+5);
                              PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                              if Node2Ok_ then       PaintBox.Canvas.Ellipse(PivotX2-3,PivotY2-3,PivotX2+5,PivotY2+5);
                              PaintBox.Canvas.MoveTo(x1, y1);
                              if Node1Ok then       PaintBox.Canvas.Ellipse(x1-3,y1-3,x1+5,y1+5);
                              PaintBox.Canvas.LineTo(x2, y2);
                              if Node2Ok then       PaintBox.Canvas.Ellipse(x2-3,y2-3,x2+5,y2+5);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end;
                    end
                    else if (PivotOk=1) and (PivotIdent=0) then
                         begin
                              PaintBox.Canvas.MoveTo(x1, y1);
                              if Node1Ok then     PaintBox.Canvas.Ellipse(x1-3,y1-3,x1+5,y1+5);
                              PaintBox.Canvas.LineTo(x2, y2);
                              if Node2Ok then     PaintBox.Canvas.Ellipse(x2-3,y2-3,x2+5,y2+5);
                              PivotIdent:=i;
                              PivotX1   :=x1;PivotX2   :=x2;PivotY1   :=y1;PivotY2   :=y2;
                         end
                         else if (PivotOk=0) and (PivotIdent<>0) then
                              begin
                                   PaintBox.Canvas.MoveTo(PivotX1, PivotY1);
                                   if Node1Ok_ then     PaintBox.Canvas.Ellipse(PivotX1-3,PivotY1-3,PivotX1+5,PivotY1+5);
                                   PaintBox.Canvas.LineTo(PivotX2, PivotY2);
                                   if Node2Ok_ then     PaintBox.Canvas.Ellipse(PivotX2-3,PivotY2-3,PivotX2+5,PivotY2+5);
                                   PivotIdent                         :=0;
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end
                              else begin
                                   Main_Form.StatusBar1.Panels[1].Text := '';
                              end;

                    PaintBox.Canvas.pen.Width:=1;
                    PaintBox.Canvas.pen.Mode :=pmCopy;
               end;// ����� Case '4'
               2: begin   //������ c�������
                    if Drawing then  // ��������� ����� (�������� �� ������)
                    begin
                         MouseUpNone:=false;
                         DrawPivot(Origin, MovePt, pmNotXor);//
                         MovePt := Point(X, Y);              // ������ ��������
                         DrawPivot(Origin, MovePt, pmNotXor);//

                         // �������� ���������� ������� ����
                         RealX    :=round((X-50-coord_axis_X)*max_x_coord/(PaintBox.Width-80-coord_axis_X));
                         RealY    :=round((PaintBox.height-Y-30-coord_axis_Y)*max_y_coord/(PaintBox.height-60-coord_axis_Y));
                         RealXReal:=RealX;
                         RealYReal:=RealY;
                         if (RealX>round(max_x_coord)) or (RealX<0) or (RealY<0) or (RealY>round(max_y_coord)) then
                         begin
                              if RealX>round(max_x_coord) then
                              begin
                                   RealX    :=round(max_x_coord);
                                   RealXReal:=max_x_coord;
                                   X        :=PaintBox.Width-30
                              end;
                              if RealX<0 then
                              begin
                                   RealX    :=0;
                                   RealXReal:=0;
                                   X        :=50+coord_axis_X;
                              end;
                              if RealY<0 then
                              begin
                                   RealY    :=0;
                                   RealYReal:=0;
                                   Y        :=PaintBox.height-30-coord_axis_Y;
                              end;
                              if RealY>round(max_y_coord) then
                              begin
                                   RealY    :=round(max_y_coord);
                                   RealYReal:=max_y_coord;
                                   Y        :=30;
                              end;
                              CurrentNode:=0;
                              for i:=1 to Ferm.nyz1 do
                              begin
                                   ux:=50+coord_axis_X+(PaintBox.Width-80-coord_axis_X)/max_x_coord*(Ferm.corn[i,1]);
                                   uy:=PaintBox.height-30-coord_axis_Y-(PaintBox.height-60-coord_axis_Y)/max_y_coord*Ferm.corn[i,2];
                                   if (X>ux-4)and(X<ux+4)and(Y>uy-4)and(Y<uy+4) then
                                   begin
                                        CurrentNode:=i;
                                        break;
                                   end;
                              end;
                         end;

                         if CurrentNode<>0 then NodeStr:='�������� � ���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]', [Ferm.corn[CurrentNode,1], Ferm.corn[CurrentNode,2]])
                         else NodeStr:='';

                         if (Ferm.nyz1=9) and (CurrentNode=0) then
                         begin
                              NodeStr    :='����������. ������������ ���������� ����� �������';
                              HelpStr    :='������� �� ��������� ����';
                              MouseUpNone:=true;
                         end
                         else if (Ferm.nyz1=8) and (Node1=9) and (CurrentNode=0) then
                              begin
                                   NodeStr    :='����������. ������������ ���������� ����� �������';
                                   HelpStr    :='������� �� ��������� ����';
                                   MouseUpNone:=true;
                              end
                              else begin
                                   HelpStr:='';
                              end;

                         if( CurrentNode=0) and (Node1>Ferm.nyz1) then Node2:=Ferm.nyz1+2
                         else if (CurrentNode=0) and (Node1<=Ferm.nyz1) then Node2:=Ferm.nyz1+1
                              else Node2:=CurrentNode;

                         Node2x:=RealXReal;
                         Node2y:=RealYReal;

                         if (X>Origin.X-4) and (Y>Origin.Y-4) and (X<Origin.X+4) and (Y<Origin.Y+4) then
                         begin
                              NodeStr    :='����������. ��������� ���� ��������� � ��������';
                              HelpStr    :='������� ������ ��� ����� ����';
                              MouseUpNone:=true;
                         end;

                         if (Node1<=Ferm.nyz1) and (Node2<=Ferm.nyz1) then
                         begin
                              for i:=1 to Ferm.nst1 do
                              begin
                                   if ((Ferm.ITOPn[i,1]=Node1) and (Ferm.ITOPn[i,2]=CurrentNode)) or ((Ferm.ITOPn[i,2]=Node1) and (Ferm.ITOPn[i,1]=CurrentNode)) then
                                   begin
                                        NodeStr    :='����������. �������� ��� ����������';
                                        HelpStr    :='������� ������ ��� ����� ����';
                                        MouseUpNone:=true;
                                   end;
                              end;
                         end;

                         //������� ����������
                         Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal]);
                         Main_Form.StatusBar1.Panels[1].Text := NodeStr;
                         Main_Form.StatusBar1.Panels[2].Text := HelpStr;

                    end

                    else begin // ������ �� ������ (�������� ��� �� ������)
                         if CurrentNode<>0 then NodeStr:='�������� � ���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]', [Ferm.corn[CurrentNode,1], Ferm.corn[CurrentNode,2]])
                         else NodeStr:='';

                         RealX    :=round((X-50-coord_axis_X)*max_x_coord/(PaintBox.Width-80-coord_axis_X));
                         RealY    :=round((PaintBox.height-Y-30-coord_axis_Y)*max_y_coord/(PaintBox.height-60-coord_axis_Y));

                         RealXReal:=RealX;
                         RealYReal:=RealY;

                         if RealX>max_x_coord then
                         begin
                              RealXReal:=max_x_coord;
                         end;
                         if RealX<0 then
                         begin
                              RealXReal:=0;
                         end;
                         if RealY<0 then
                         begin
                              RealYReal:=0;
                         end;
                         if RealY>max_y_coord then
                         begin
                              RealYReal:=max_y_coord;
                         end;
                         if X>PaintBox.Width-30 then
                         begin
                              RealX:=-1;
                         end;
                         if X<50+coord_axis_X then
                         begin
                              RealX:=-1;
                         end;
                         if Y>PaintBox.height-30-coord_axis_Y then
                         begin
                              RealY:=-1;
                         end;
                         if Y<30 then
                         begin
                              RealY:=-1;
                         end;
                         if (Ferm.nyz1=9) and (CurrentNode=0) then
                         begin
                              NodeStr:='����������. ������������ ���������� ����� �������';
                              HelpStr:='������� �� ��������� ����';
                         end
                         else HelpStr:='';


                         if ((RealX=-1) or (RealY=-1)) then
                         begin
                              Main_Form.StatusBar1.Panels[0].Text:='[- : -]';
                              Main_Form.StatusBar1.Panels[1].Text:='��� �������� �������';
                              Main_Form.StatusBar1.Panels[2].Text :='����������� ������ � ���������� �������';
                         end
                         else begin
                              Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal]);
                              Main_Form.StatusBar1.Panels[1].Text := NodeStr;
                              Main_Form.StatusBar1.Panels[2].Text := HelpStr;
                         end;

                    end; // ����� 'If Drawing Then ... Else ...'

               end; // ����� Case '2'


               5: begin  // �������� ����
                    NodeOk:=true;
                    if CurrentNode<>0 then
                    begin
                         NodeStr:='���� ��� ����������: �'+IntToStr(CurrentNode)+Format(' [%g : %g]', [Ferm.corn[CurrentNode,1], Ferm.corn[CurrentNode,2]]);
                         HelpStr:='������� ����� ����';
                         NodeOk :=false;
                    end
                    else NodeStr:='';

                    RealX    :=round((X-50-coord_axis_X)*max_x_coord/(PaintBox.Width-80-coord_axis_X));
                    RealY    :=round((PaintBox.height-Y-30-coord_axis_Y)*max_y_coord/(PaintBox.height-60-coord_axis_Y));

                    RealXReal:=RealX;
                    RealYReal:=RealY;

                    if RealX>max_x_coord then RealXReal:=max_x_coord;
                    if RealX<0 then RealXReal:=0;
                    if RealY<0 then RealYReal:=0;
                    if RealY>max_y_coord then RealYReal:=max_y_coord;

                    if (X>PaintBox.Width-30) or
                    (X<50+coord_axis_X) or
                    (Y>PaintBox.height-30-coord_axis_Y) or
                    (Y<30) then Flg:=-1
                    else flg:=0;

                    NodeX:=RealXReal;
                    NodeY:=RealYReal;

                    if (flg=-1) then
                    begin
                //         NodeOk                             :=false;
                         Main_Form.StatusBar1.Panels[0].Text:='[- : -]';
                         Main_Form.StatusBar1.Panels[1].Text:='��� �������� �������';
                         Main_Form.StatusBar1.Panels[2].Text :='����������� ������ � ���������� �������';
                    end
                    else begin
                         Main_Form.StatusBar1.Panels[0].Text := Format('[%g : %g]', [RealXReal, RealYReal]);
                         Main_Form.StatusBar1.Panels[1].Text := NodeStr;
                         Main_Form.StatusBar1.Panels[2].Text := HelpStr;
                    end;

               end; // ����� Case '5'

               6: begin
                    // ������� ����
                    if CurrentNode<>0 then
                    begin
                         NodeStr:='������� ���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]', [Ferm.corn[CurrentNode,1], Ferm.corn[CurrentNode,2]]);
                         NodeOk :=false;
                    end
                    else NodeStr:='';

                    Main_Form.StatusBar1.Panels[1].Text := NodeStr;

               end;  // ����� Case '6'

               8: begin   // �����������, ����������, ����������
                    if CurrentNode<>0 then
                    begin
                         NodeStr:='���� �'+IntToStr(CurrentNode)+Format(' [%g : %g]', [Ferm.corn[CurrentNode,1], Ferm.corn[CurrentNode,2]]);
                         NodeOk :=false;
                    end
                    else NodeStr:='';

                    //  RealX:=Round((X-50-coord_axis_x)*max_x_coord/(PaintBox.Width-80-coord_axis_x));
                    //  RealY:=Round((PaintBox.Height-Y-30-coord_axis_y)*max_y_coord/(PaintBox.Height-60-coord_axis_y));

                    //  RealXReal:=RealX;
                    //  RealYReal:=RealY;

                    //  if RealX>max_x_coord then RealXReal:=max_x_coord;
                    // if RealX<0 then RealXReal:=0;
                    // if RealY<0 then RealYReal:=0;
                    // if RealY>max_y_coord then RealYReal:=max_y_coord;

                    // if X>PaintBox.Width-30 then RealX:=-1;
                    // if X<50+coord_axis_x then RealX:=-1;
                    // if Y>PaintBox.Height-30-coord_axis_y then RealY:=-1;
                    // if Y<30 then RealY:=-1;

                    //  if ((RealX=-1) or (RealY=-1)) then
                    //   begin
                    //    Main_Form.StatusBar1.Panels[0].Text:='[- : -]';
                    //    Main_Form.StatusBar1.Panels[1].Text:='��� �������� �������';
                    //    Main_Form.StatusBar1.Panels[2].Text :='����������� ������ � ���������� �������';
                    //  end
                    // else
                    //  begin
                    Main_Form.StatusBar1.Panels[1].Text := NodeStr;
                    //  end;
               end;
          end; // ����� Case of
     end;  // ����� 'Aktive'
end;   // ����� '���������'
//============================================================================//



//============================================================================//
// ������ �������� �����
procedure TFerma_Form.DrawPivot(TopLeft, BottomRight: TPoint; AMode: TPenMode);
begin

     with PaintBox.Canvas do
     begin
          pen.Mode := AMode;
          pen.Color:=clBlack;
          pen.Width:=1;
          MoveTo(TopLeft.X, TopLeft.Y);
          if BottomRight.X>PaintBox.Width-30 then BottomRight.X:=PaintBox.Width-30;
          if BottomRight.X<50+coord_axis_X then BottomRight.X:=50+coord_axis_X;
          if BottomRight.Y>PaintBox.height-30-coord_axis_Y then BottomRight.Y:=PaintBox.height-30-coord_axis_Y;
          if BottomRight.Y<30 then BottomRight.Y:=30;
          LineTo(BottomRight.X, BottomRight.Y);
     end;

end;


procedure TFerma_Form.PaintBoxMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
     i,what_do:Integer;
begin
     what_do:=0;
     // ����� ������ ������ ?
     for i:=0 to Main.Main_Form.Ferma_Graph_Enter_Panel.ButtonCount-1 do
          if Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Down = true then what_do:=Main.Main_Form.Ferma_Graph_Enter_Panel.Buttons[i].Tag;

     Case what_do of

          //������// ������� �.�.
          12: begin
               if Button=mbLeft then
                 begin
                    Drawing:=false;
                    MCurrentNode:=0;
                    isChanged :=true;
                    Caption:=concat('*',real_fname);
                    Repaint;
                    if CurrentNode<>0 then
                    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
                    Ferma_Fd_Form.showD(Ferm);
                 end;
              end;
         //����� // ������� �.�.

          9: begin  // ������� �������
               if PivotIdent<>0 then
               begin
                    TolOk                      :=2;
                    FermaPivotTol_Form.PTF     :=Ferm;
                    FermaPivotTol_Form.NumPivot:=PivotIdent;
                    FermaPivotTol_Form.ShowModal;
               end;
          end;

          2: begin  // ������ ��������

               if Drawing then
               begin

                    if not MouseUpNone then
                    begin
                         DrawPivot(Origin, Point(X, Y), pmNotXor);
                         PaintBox.Canvas.pen.Mode:=pmCopy;
                         Drawing                 := false;

                         if (Node1>Ferm.nyz1) and (Node2 >Ferm.nyz1) then
                         begin
                              Ferm.corn[Node1,1]       :=Node1x;Ferm.corn[Node1,2]       :=Node1y;
                              Ferm.corn[Node2,1]       :=Node2x;Ferm.corn[Node2,2]       :=Node2y;
                              Ferm.ITOPn[Ferm.nst1+1,1]:=Node1;Ferm.ITOPn[Ferm.nst1+1,2] :=Node2;
                              Ferm.Fn[Ferm.nst1+1]     :=0.1;
                              Ferm.nyz1                :=Ferm.nyz1+2;
                              Ferm.nst1                :=Ferm.nst1+1;
                              isChanged                :=true;
                              Caption                  :=concat('*',real_fname);
                         end
                         else if (Node1>Ferm.nyz1) and (Node2<=Ferm.nyz1) then
                              begin
                                   Ferm.corn[Node1,1]       :=Node1x;Ferm.corn[Node1,2]       :=Node1y;
                                   Ferm.ITOPn[Ferm.nst1+1,1]:=Node1;Ferm.ITOPn[Ferm.nst1+1,2] :=Node2;
                                   Ferm.Fn[Ferm.nst1+1]     :=0.1;
                                   Ferm.nst1                :=Ferm.nst1+1;
                                   Ferm.nyz1                :=Ferm.nyz1+1;
                                   isChanged                :=true;
                                   Caption                  :=concat('*',real_fname);
                              end
                              else if (Node1<=Ferm.nyz1) and (Node2>Ferm.nyz1) then
                                   begin
                                        Ferm.corn[Node2,1]       :=Node2x;Ferm.corn[Node2,2]       :=Node2y;
                                        Ferm.ITOPn[Ferm.nst1+1,1]:=Node1;Ferm.ITOPn[Ferm.nst1+1,2]:=Node2;
                                        Ferm.Fn[Ferm.nst1+1]     :=0.1;
                                        Ferm.nst1                :=Ferm.nst1+1;
                                        Ferm.nyz1                :=Ferm.nyz1+1;
                                        isChanged                :=true;
                                        Caption                  :=concat('*',real_fname);
                                   end
                                   else if (Node1<=Ferm.nyz1) and (Node2<=Ferm.nyz1) and (Ferm.nyz1<>0) then
                                        begin
                                             Ferm.ITOPn[Ferm.nst1+1,1]:=Node1;Ferm.ITOPn[Ferm.nst1+1,2]:=Node2;
                                             Ferm.Fn[Ferm.nst1+1]     :=0.1;
                                             Ferm.nst1                :=Ferm.nst1+1;
                                             isChanged                :=true;
                                             Caption                  :=concat('*',real_fname);
                                        end;


                         if (Ferm.nst1=15) then
                         begin
                              PaintBox.Cursor                                   :=crDefault;
                              Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
                              Main_Form.StatusBar1.Panels[0].Text               := '';
                              Main_Form.StatusBar1.Panels[1].Text               := '';
                              Main_Form.StatusBar1.Panels[2].Text               := '';
                         end;

                         //     GraphPanelRepaint(Self);

                         Repaint;
                         Ferma_Fd_Form.showD(Ferm);
                         Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
                    end
                    else begin
                         Drawing:=false;
                         DrawPivot(Origin, Point(X, Y), pmNotXor);
                         if EllipseOk then
                         begin
                              PaintBox.Canvas.pen.Width  :=2;
                              PaintBox.Canvas.pen.Color  :=clBlue;
                              PaintBox.Canvas.brush.Color:=clWhite;
                              PaintBox.Canvas.Ellipse(Origin.X-3,Origin.Y-3,Origin.X+5,Origin.Y+5);
                              PaintBox.Canvas.pen.Width  :=1;
                              PaintBox.Canvas.pen.Color  :=clBlack;
                              PaintBox.Canvas.brush.Color:=clSilver;
                         end;
                         PaintBox.Canvas.pen.Mode:=pmCopy;
                    end;

               end; // ����� If Drawing
          end; // ����� Case '2'
          5: begin   //�������� ����
               if NodeOk then
               begin
                    Ferm.nyz1             :=Ferm.nyz1+1;
                    isChanged             :=true;
                    Caption               :=concat('*',real_fname);
                    Ferm.corn[Ferm.nyz1,1]:=NodeX;Ferm.corn[Ferm.nyz1,2]:=NodeY;
                    if Ferm.nyz1=9 then
                    begin
                         PaintBox.Cursor                                   :=crDefault;
                         Main_Form.StatusBar1.Panels[0].Text               := '';
                         Main_Form.StatusBar1.Panels[1].Text               := '';
                         Main_Form.StatusBar1.Panels[2].Text               := '';
                         Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
                    end;
               end;

               //   GraphPanelRepaint(Self);

               Repaint;
               Ferma_Fd_Form.showD(Ferm);
               Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
          end; // ����� Case '5'

     end; // ����� Case of
end; // ����� ���������



procedure TFerma_Form.FormDeactivate(Sender: TObject);
begin
     PaintBox.Cursor  :=crDefault;
     PaintBox.ShowHint:=false;
     if ((Main_Form.DeletePivot12_ToolButton.Down) or (Main_Form.DeletePivot_ToolButton.Down) or (Main_Form.PivotTol_ToolButton.Down)) then
     begin
          // PivotIdent:=0;
          Repaint;
     end;
     Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
     Main_Form.StatusBar1.Panels[0].Text               :='';
     Main_Form.StatusBar1.Panels[1].Text               :='';
     Main_Form.StatusBar1.Panels[2].Text               :='';
     //Main_Form.Caption :='����� - ������ 7.0 ��� Windows';
end;

procedure TFerma_Form.FormShow(Sender: TObject);
begin
     Width  := Ceil(360*Main_Form.Width_Ratio);
     Height := Ceil(260*Main_Form.Height_Ratio);
end;

procedure TFerma_Form.ViewConstr_MnuClick(Sender: TObject);
begin
     if Main_Form.WithTOK.Checked = true then
     begin
          Ferma_Fd_Form.Visible        :=false;
          Main_Form.ConstructorShow.Checked := false;
     end
     else begin
          Ferma_Fd_Form.Visible        :=true;
          Main_Form.ConstructorShow.Checked := true;
     end;
end;



procedure TFerma_Form.N3Click(Sender: TObject);
begin
     if CurrentNode=0 then exit;
     Ferma_FD.Coord_Node_Pm:=CurrentNode;
     CoordNode_Form.ShowModal;
end;


// ������� �������� �������
procedure TFerma_Form.DeletePivot(i_pivot: Integer);
var
     i:Integer;
begin

     for i:=i_pivot+1 to Ferm.nst1 do
     begin
          Ferm.ITOPn[i-1,1]:=Ferm.ITOPn[i,1];
          Ferm.ITOPn[i,1]  :=0;
          Ferm.ITOPn[i-1,2]:=Ferm.ITOPn[i,2];
          Ferm.ITOPn[i,2]  :=0;
     end;
     for i:=i_pivot+1 to Ferm.nst1 do
     begin
          Ferm.Fn[i-1]:=Ferm.Fn[i];
          Ferm.Fn[i]  :=0;
     end;

end;

// ����������� ��������� ��� �������� ��������, ��������� �
//   ��������� �����
procedure TFerma_Form.Recursia(Sender: TObject);
var
     i:Integer;
begin
     for i:=1 to Ferm.nst1 do
     begin
          if (Ferm.ITOPn[i,1]=NodeDelete) or (Ferm.ITOPn[i,2]=NodeDelete) then
          begin
               DeletePivot(i);
               Ferm.nst1:=Ferm.nst1-1;
               Recursia(Self);
               break;
          end;
     end;
end;


procedure TFerma_Form.TOKClick(Sender: TObject);
begin
 if  Main_Form.WithTOK.Checked then begin
  //Main_Form.B4.Enabled:=false;
            Main_Form.WithTOK.Checked:=false;
          Main_Form.TOK_OK_PMI.Checked        :=false;
          Main_Form.TOK_NO_PMI.Checked        :=true;
  end
 else
  begin
  //Main_Form.B4.Enabled:=true;
          Main_Form.WithTOK.CHecked:=true;
          Main_Form.TOK_OK_PMI.Checked        :=true;
          Main_Form.TOK_NO_PMI.Checked        :=false;

     if Main_Form.TOK_OpenDialog.Execute then
       begin
      if (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.out')or
         (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.oup')then
        begin

        end;
       end;
 end;
end;

procedure TFerma_Form.ViewGraph_MnuClick(Sender: TObject);
begin
     if Main_Form.PanelConstruction.Checked = true then
     begin
          Main_Form.Ferma_Graph_Enter_Panel.Visible         :=false;
          Main_Form.PanelConstruction.Checked               := false;
          Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=true;
          PaintBox.Cursor                                   :=crDefault;
          PaintBox.ShowHint                                 :=false;
          Main_Form.StatusBar1.Panels[0].Text               := '';
          Main_Form.StatusBar1.Panels[1].Text               := '';
          Main_Form.StatusBar1.Panels[2].Text               := '';
     end
     else begin
          Main_Form.Ferma_Graph_Enter_Panel.Visible:=true;
          Main_Form.PanelConstruction.Checked      := true;
     end;
end;



procedure TFerma_Form.N7Click(Sender: TObject);
begin
     Main_Form.ToolButton7Click(Sender);
end;


procedure TFerma_Form.N1Click(Sender: TObject);
begin
     //   ����� TOK
     Main_Form.NewTOK_MnuClick(Sender);
end;


procedure TFerma_Form.N16Click(Sender: TObject);
begin
     // ����� ��������
     Main_Form.NewPlast_MnuClick(Sender);
end;



procedure TFerma_Form.real_sizeClick(Sender: TObject);
var
     w,h:Integer;
begin

     w_old:=ClientWidth;
     h_old:=Clientheight;

     {if ferm.region_x>ferm.region_y then
      begin
        w:=Round((ClientHeight-75)*ferm.region_x/ferm.region_y)+123;
        if w<360 then
         begin
          w:=360;
          h:=Round((360-123)*ferm.region_y/ferm.region_X)+75;
         end;
      end
     else
      begin
       h:=Round((ClientWidth-123)*ferm.region_y/ferm.region_X)+75;
       if h<260 then
        begin
         h:=260;
         w:=Round((260-75)*ferm.region_x/ferm.region_y)+123;
        end;
      end; }
     if Ferm.region_x>Ferm.region_y then
     begin
          h:=260;
          w:=round((h-75)*Ferm.region_x/Ferm.region_y)+123;
          if w<360 then w:=360;
          h:=round((w-123)*Ferm.region_y/Ferm.region_x)+75;
     end
     else begin
          w:=360;
          h:=round((w-123)*Ferm.region_y/Ferm.region_x)+75;
     end;
     WindowState :=wsNormal;
     if (ClientWidth=w) and (ClientHeight=h) then exit
     else
       begin
        CW:=ClientWidth;
        CH:=ClientHeight;
        ClientWidth:=w;
        ClientHeight:=h;
       end
     //Main_Form.StatusBar1.Panels[1].Text :='W= '+IntToStr(w-123)+' H= '+IntToStr(h-75);
end;


procedure TFerma_Form.Real_Coord_PUMPopup(Sender: TObject);
var
     w,h:Integer;
begin

     //w:=ClientWidth;
     // h:=Clientheight;
     {if F.region_x>F.region_y then
      begin
        w:=Round((ClientHeight-75)*F.region_x/F.region_y)+123;
        if w<360 then
         begin
          w:=360;
          h:=Round((360-123)*F.region_y/F.region_X)+75;
         end;
      end
     else
      begin
       h:=Round((ClientWidth-123)*F.region_y/F.region_X)+75;
       if h<260 then
        begin
         h:=260;
         w:=Round((260-75)*F.region_x/F.region_y)+123;
        end;
      end;}

     if Ferm.region_x>Ferm.region_y then
     begin
          h:=260;
          w:=round((h-75)*Ferm.region_x/Ferm.region_y)+123;
          if w<360 then w:=360;
          h:=round((w-123)*Ferm.region_y/Ferm.region_x)+75;
     end
     else begin
          w:=360;
          h:=round((w-123)*Ferm.region_y/Ferm.region_x)+75;
     end;

     if (w>Screen.Width) or (h>Screen.height) then Real_Coord_PUM.Items[0].Enabled:=false
     else Real_Coord_PUM.Items[0].Enabled:=true;

end;

procedure TFerma_Form.optClick(Sender: TObject);
begin
    if Ferma_SelectMetod=nil then
     Ferma_SelectMetod:=TFerma_SelectMetod.Create(self);
     //Ferma_SelectMetod.Close;
     Ferma_SelectMetod.Show;
end;

procedure TFerma_Form.N11Click(Sender: TObject);
begin
//���������� �.�. 15.12.07 {


  if opt_type[0] = 1 then
   begin
    if fermoptnode.Ferm_opt_node.RadioButton5.Checked=true then
      form3.Label9.Caption:='�� �����'
    else
       form3.Label9.Caption:='�� �������� ����';

    form3.Caption:=('���������� ����������� ��������� ����� ��� ' + real_fname);
    form3.show;
   end
  else
   MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
   //���������� �.�. 15.12.07 }
end;


procedure TFerma_Form.N13Click(Sender: TObject);
begin
//���������� �.�. 15.12.07 {
 if opt_type[1] = 1 then
  begin
   FermOptMassaRez_form.K_before_Edit.Visible:=false;
   FermOptMassaRez_form.K_after_Edit.Visible:=false;
   FermOptMassaRez_form.K_before_Label.Enabled:=false;
   FermOptMassaRez_form.K_after_Label.Enabled:=false;
   FermOptMassaRez_form.Label9.Visible:=true;
   FermOptMassaRez.FermOptMassaRez_form.Caption:=('���������� ���������� ����������� ��� '  + real_fname );
   FermOptMassaRez_form.show;
 end
 else
   MessageDlg('������������ ������ ������ � ������� � ���������������� �������.'+#13+'����������� ��������������� ������ ��� ������ ��������� �����������.',mtError,[mbOk],0);
      // ���������� �.�. 9.12.07 }
end;


procedure TFerma_Form.N9Click(Sender:TObject);
//***************************************************************************
//*************************** ������ ����������� ��������� �����*************

type
     TMethodProc=procedure(Fn:PChar);
var
     LibHandle:THandle;
     DllName:string;
     sp:TMethodProc;
     i,w:Integer;
     fmi,ebsi:single;
     k,maxkit,ljambda:Integer;
     material:string;
// www ��� ���������� :
 uchet:integer ;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0)
  fn3,ff1:string;
  ff:System.text;
  s,s_lin,s_for:string;
  region_x,region_y:extended;
  tol1:array[1..15] of extended;        // ��������� ������� -��� �����
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
//****************************************************
  d1,dd :  System.text;
  mg,j,i1,jj,ka:integer;
  co,sg,fm,sima,s1,s2,s3: single;
 ITOPn: array[1..15,1..2] of integer;                {���O�O��� CTEP�HE�}
 Fn:    array[1..15] of single;                      {HA�A��H�E ��O�A��}
 CORn:  array[1..9,1..2] of single;                  {KOOP��HAT� ���OB}
 corTemp:single;
 MSn:   array[1..9,1..2] of integer;                 {�AKPE��EH�� ���OB}
 P:    array[1..18,1..3] of single;                 {HA�P��K�}
 NST1:integer;                                       {��C�O CTEP�HE� �EPM�}
 NYZ1:integer;                                       {��C�O ���OB}
 NY1:integer;                                        {��C�O �AKPE��EH��}
 E1:single;                                          {MO���� ��P��OCT�}
 NSN1:integer;                                       {��C�O C���AEB HA�P��EH��}
 SD1:single;                                         {�O��CKAEMOE HA�P��EH�E}
 N1:integer;                                        {��C�O HE��BECTH�X}
 U:   array[1..18,1..3] of single;                  {�EPEME�EH�� ���OB}
 SIGP:array[1..15,1..3] of single;                  {HA�P��EH�� B CTEP�H�X}
 kgv: single;


  f1f:extended;
  ii,ms1:integer;
  s_tok, tok_error, tok_s_lin, tok_s_for:string;
  tok_weight:extended;
//*******
fr1 :  System.text;// ��� ���� � ������� �� ����������� ����� - �� ������������� ���������� ������������� ����������� �����
   rezou_2:array [1..500] of integer; // ������ ��� ���������� ������ � ����� �� ������
   rezou_1:array [2..1000] of real; // ������ ��� ���������� ������ � ����� �� ������
nr,k6:integer;
      fw1: TFerm;

  error:boolean;


//FERMA 5
ferma5_kol_uzlov:integer; // ���������� �������������� �����
//ferma5_kol_uzlov_m:array [1..10] of integer; // ������ �������������� �����
ferma5_num :integer; // ����� �������� - �������� �� 1 �� 4.
ferma5_num1:integer;//���������
ferma_5_dannie_o_uzlax_d: array [1..10] of real; // ��� �  �������� ������ ������� ������� � ������� ferma_5_dannie_o_uzlax
ferma_5_dannie_o_uzlax_d1: array [1..10,1..2] of single; // ��� ��� �������� "������" - ������ ��������� ��������� - �� ������ ������������ ������� ����
// ****


//************

     h :real; // ���
     r,r1:integer; // ����� ��������������� ����
     k7 : integer; // ��� ����������� ���������� ������
     l,maxkit2:integer; // ���������� ����� ��� ������
     sv,svs:real; // ������� ��� - � ������ � ����� �����
     x,x1,y,y1 : real; // ���������� ���� - ������ � "��������"
     flag:integer;// ��������������� ����������
     leng,x_old,y_old:real; // x_old,y_old - ��� ���������� �������� ����- ��� �������� "������" ������
     xh1,xh2,xh3:integer;
     svs2,svs1,sv0,massa:real;// ������ ��� �������� � ������������.
     label m0,m1,m2,m3,mex;




begin

 { FERMA 5!!!!!!!
        for i:=1 to Ferm.nst1 do // ���� ����� �������� �������� �� �� ������� ���
          begin
           if (Ferm.ITOPn[i,1]=r)or (Ferm.ITOPn[i,2]=r) then // �������� �������� ��� ���� ?
           leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
              if flag=0 then
               begin
               leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
               h:=leng;
               flag:=1;
               end;
           if  leng<h then
           h:=leng; // �����
          end;

// ������ ��� � ���� � ����������� ����������� ����
h:=h/2;
flag:=round(h);// ���������� � ������������
FermOptNode.Ferm_opt_node.Edit3.Text:=floattostr(flag);
}
opt_type[0]:=1; // ���������� �.�.
FermOptNode.Ferm_opt_node.ScrollBar1.min:=1; // ������ ��� ���������
FermOptNode.Ferm_opt_node.ScrollBar1.Max:=200;
FermOptNode.Ferm_opt_node.ScrollBar1.position:=15;
FermOptNode.Ferm_opt_node.Edit9.Text:='0'; // ����� ���������� �������������� �����
FermOptNode.Ferm_opt_node.OptNodeEdt.Text:='';
FermOptNode.Ferm_opt_node.Groupbox6.Visible:=false;
 Ferm_opt_node.ComboBox1Click11(sender);
ferma5_kol_uzlov:=strtoint(FermOptNode.Ferm_opt_node.Edit9.Text); // ������� ������� ����� ��� ������������
//�������� ������ �����.
//ferma5_num1:=1; // ���� ����� �������
//xh1:=1; // �������� ����� ���� ����� ������ ������� 1
//Ferm_opt_node.ferma5_kol_uzlov_m[1]:=xh1; // ������ ��� ������� ��� ����������������� �����������
// ��� ��������
//fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[1,1]:=4; //������������ ���������� ����� .
//fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[1,2]:=15; //������ ������� ������
//fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[1,2]:=1; //���������� ��������
//fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[1,2]:=0; //����� �������� ������

//Ferm_opt_node.ComboBox1Click11(sender);// ���������� �������
//Ferm_opt_node.groupbox6.caption:='���� � '+ (Ferm_opt_node.ComboBox1.Text) ;

//FermOptNode.Ferm_opt_node.Ak_flag:=true; // ���� ���������� ������ ��� ����������� ������� ��������� ����
//FermOptNode.Ferm_opt_node.Ak_num:=xh1; // ����� ����
//FermOptNode.Ferm_opt_node.Ak_Rad:=15; // ������
FermOptNode.Ferm_opt_node.Ak_flag:=false; // ���� ���������� ������ ��� ����������� ������� ��������� ����
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;// ������� ��� ������ � �������� ���� � ��� �����������
//Ferm_opt_node.ComboBox1Change(Sender);// ����� ������ � ������ ����
{
if FermOptNode.Ferm_opt_node.checkbox2.checked=true then
 begin
 ferma5_num1:=ferma5_num1+1;
 ferma5_kol_uzlov_m[ferma5_num1]:=StrToInt(FermOptNode.Ferm_opt_node.edit4.text);
 end;
 }
// ����� ������ � �������� � ����������� �������
// ������ ���� ����������� ���� : ���������� ������ �� ����� ������� �������� ���� ����. � ��� 4 ����.
//FermOptNode.Ferm_opt_node.ShowModal;// ���� ������ � ����������� ���������� ����������� ��� ������� ����������� ��������� ����

  if FermOptNode.Ferm_opt_node.ShowModal<>mrOk then
  begin
   FermOptNode.Ferm_opt_node.Ak_flag:=false;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
   Main_Form.PlastNumberButtonClick(sender); // ����� ��������� �������- ���� ���� �������
   exit;
  end;
// begin
   FermOptNode.Ferm_opt_node.Ak_flag:=false;
   Main_Form.PlastNumberButtonClick(sender); // ����� ��������� �������- ���� ���� �������
{
     try
//      xh1:=StrToint(FermOptNode.Ferm_opt_node.edit2.Text);
      xh2:=StrToint(FermOptNode.Ferm_opt_node.edit1.Text);
      h:=StrToInt(FermOptNode.Ferm_opt_node.edit3.Text);
    except
      //Beep;
      MessageDlg('������ ����� ���������� �����������.'+#13+'���� �� ���������� ����� �������. ������� �� �����.',mtError,[mbOk],0);
      exit;
    end;


     if (xh1>15)or(xh1<=0) then
     begin
      //Beep;
      MessageDlg('������ ����� ������ ����.',mtError,[mbOk],0);
      exit;
     end;

     if (xh2>15)or(xh2<=0) then
     begin
      //Beep;
      MessageDlg('������ ����� ���������� �����.',mtError,[mbOk],0);
      exit;
     end;
     if (h>200)or(h<1) then
     begin
      //Beep;
      MessageDlg('������ ����� ������� (1-200).',mtError,[mbOk],0);
      exit;
     end;
 end;
}

// FermOptNode.Ferm_opt_node.Ok_BtnClick(Sender);
 FermOptNode.Ferm_opt_node.close;
 FermOptNode.Ferm_opt_node.Visible:=false;
  //  if not FermOptNode.Ferm_opt_Node.Execute(xh:integer) then exit;
 //FermOptNode.Ferm_opt_node.Visible:=true;
//FermOptParam_Form.GroupBox1.Visible:=true;
//     if not FermOptParam_Form.Execute(fmi,ebsi,maxkit) then exit;
// FermOptParam_Form.GroupBox1.Visible:=false; // ��� �������� ���� � ����� ���� ��� ������ �� ����������

// ���� ���������� ��� �����������

//uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0)

fn3:=filename + '.bak'; // �������� �������� ���� ��� ���
  CopyFileTo(filename,fn3);

sv0:=0; // ������� ��� ��� �����������
massa:=0; // ����� ��� �����������

// �������� ����� ��������� ��� ��������� �����������

  for i:=1 to Ferm.nst1 do
   begin
   massa:=massa+ferm.Fn[i]*
    sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
          (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
        );
   end;
//form3.Grd.Cells[1,3]:=FormatFloat('0.00000E+00',massa);  ���������� �.�. 18.12.07
  Ferma_M_Anim.form3.StartValue_Edt.Text:=FormatFloat('0.00000E+00',massa);




// ����� �������� �������� ������� ( ���� �� �������� �� ������) ���� ��������� �� � ������� �������� � � ��������� , �������
// �������� ��������� ���������� ����� � �������������� ������-� ����� ��������� ��������� ����� � ����.
for ferma5_num1:=1 to strtoint(Ferm_opt_node.Edit9.Text) do // ���� �� ���� ��������� �����
    begin
//    fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]
    ferma_5_dannie_o_uzlax_d1[ferma5_num1,1]:=Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1],1];  // X
    ferma_5_dannie_o_uzlax_d1[ferma5_num1,2]:=Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1],2];  // Y
    end;


// ����� ������� ��� ������� ��� � ������ ������:
for ferma5_num1:=1 to strtoint(Ferm_opt_node.Edit9.Text) do // ���� �� ���� ��������� �����
    begin
//    fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]
    ferma_5_dannie_o_uzlax_d[ferma5_num1]:=(fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]); //�������� �������!!!! ��� ������ �������
    end;



for ferma5_num:=1 to StrToInt(FermOptNode.Ferm_opt_node.edit8.text) do // ����� ��������
for ferma5_num1:=1 to strtoint(Ferm_opt_node.Edit9.Text) do // ���� �� ���� ��������� �����
begin
//Ferm_opt_node.ComboBox1.text:=inttostr(Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1]);
//FermOptNode.Ferm_opt_node.Edit2.text:=inttostr(Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1]);

//////////FERMA 5 end
{
������ ��� - ������� ���� ��������  ����������� ��� ������ ���� - ������ ����� ��
������������ ��� - ��� �������� ����� - �� �� ����� ����������� �� !
�� � ������ ����������� ��� �����- ������ �� �������� � ������ �� ����� ���������.
� �  ������ �������� ������ ������ �������� ������� - ������ �� ������� � ����������� ��� �������� ����.
� ��� ���������- ��� ��� ����� H(h) - ����� ��� ���� ��������� �� ���� � ����� ������
�� ����������� �������� . ��� ���� �������� ��� ������ ���������. - ��� �����������
��� ��� maxkit2=1 ������� ��- ����� ����� ����� ������ ����� ��� �� ����� ��� � �����������
��������� ���������� ���� - � ����� �� �����. ����� �������� �� ����� ���� ����� � ���������
 ��� �� �� ������e�( �� ���� ������� �� �����) � ������� ��� ���� ���� ���  - ��� ��� ��� ���������.

}
 r:=(Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1]); // ������������ ���� �����

 maxkit2:=  fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,1]; //������������ ���������� ����� .
 if  maxkit2=0 then   goto m3; // ���� ��� ������� ���� ������� ������ ��� �� ��� - ���� ���� �� �������������� ������ - ��� ���� ���������� ������������ ��������� ��������� ����
 fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,1]:=fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,1]-1;

// h:=fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]; //������ ������� ������ !!!!!
 h:=ferma_5_dannie_o_uzlax_d[ferma5_num1];
    ferma_5_dannie_o_uzlax_d[ferma5_num1]:=ferma_5_dannie_o_uzlax_d[ferma5_num1]/2; // �  �������� ��� ��������� ������� ���
    // ����� ������ �� ( ���� ������ ����� ��� ��� goto ) ���������� ��� ��������� � ���������� ��� ������ ����
  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,3]=1   then
    fermoptnode.Ferm_opt_node.radiobutton1.Checked:=true;
  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,3]=2   then
    fermoptnode.Ferm_opt_node.radiobutton2.Checked:=true;
  if fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,3]=3   then
    fermoptnode.Ferm_opt_node.radiobutton3.Checked:=true;
  if   fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,4]=1 then // ����� ������������� ������
  fermoptnode.Ferm_opt_node.CheckBox1.Checked:=true
  else
  fermoptnode.Ferm_opt_node.CheckBox1.Checked:=false;
//*************************************** zakoncili ��������� ������� ��� ������ ����




/// �������������� ������� ������ - ���� ��������� ������� ��������
     savedata; // ��������� ����� �������� ������� ���������
     Main_form.Refresh  ; // ���������� - ��� ���� ����� ���� ����� ����� - ��� ���� ��� ���������.
loaddata;
screen.Cursor:=crHourGlass;
begin

     //�������� �� ������������ ���� (�� ������������� �� ������ �������)
     for i:=1 to Ferm.nyz1 do
     begin
          Flag:=-1;
          for j:=1 to Ferm.nst1 do
          begin
               if (Ferm.ITOPn[j,1]=i) or (Ferm.ITOPn[j,2]=i) then
               begin
                    Flag:=0;
                    break;
               end;
          end;
          if (Flag=-1) then break;
     end;
     if Flag=-1 then Flag:=MessageDlg(chr(13)+'� ������ ����������� ���� ����/���� �� ������������� �� ������ �������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;

     k:=0;
     for i:=1 to Ferm.nyz1 do
     begin
          k:=k+Ferm.msn[i,1]+Ferm.msn[i,2];
     end;
     w:=2*Ferm.nyz1-Ferm.nst1-k;
     if w>0 then Flag:=MessageDlg(chr(13)+'������ ����������� ������������ ����� ��������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;


            DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';
            DllCall(DllName,FileName,Ferm);
     {
     if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');
     try
          sp(PChar(FileName));
     finally

     //          Cursor:=crDefault;
     end; }
end;
// ������� ������ ������� !

//     if isChanged then FileSave_MnuClick(nil);
//     if SaveCancel then exit;
{
     for i:=1 to Main_Form.Ferma_num_mat+2 do
          if (Main_Form.Ferma_MMaterials[i].MModUpr = Ferm.e1) and
             (Main_Form.Ferma_MMaterials[i].MDopNapr = Ferm.sd1) then
          begin
               material := Main_Form.Ferma_MMaterials[i].MName;
          end;

     i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'opt_f.dll',FileName,material,fmi,ebsi,maxkit,ljambda);
     // ���� ��� ��� ������ ������ --  ���� ������� � ��� �� ��� ��� ���� �� �� ������� ����������� �����
     // ������ ���� ������� �����  ��������� ��������- ������� �� ����������� �������� ���� .
     // ���� ���� ��������� ���������� ������� ���� ��� ������������ � ������� ����� � ������� ������������� ���������� ����� � ��������� ����
     // �� �������� ������� �������� �����������,  �������� ����, � ���
     Case i of
          0: S:='������� ��������� ���������.';
          1: begin
               S                             :='���������� ���������� ����� ��������.';
          end;
          2: begin
               S                             :='���������� �������� ��������.';

          end;
     else begin
          S                             :='��������� ���������� ������. ���������� ��������� �������� (������ ��������, ��-��!)';
     end;
     end;
}
     // �������� ������� � ��������� �������� ��������� ���� ����
// ���� ���������� � ��������� ���������. �������������� ��� ���� ���
// �������� : ��� ���� ����� ����� ����� �� ����� 5.
// � ��� ��� ��� �������� - ��������� ���������� ����� 0.1 ( �������� ����... �� ����� ���� 0.01 �� �������� ����� ��������� �� 2 �����)

// ���������� �� ����� FRM ���������� ��������������� ���� � ������ � �������� �������� ���� ���������� ������ ��� ��� ������� (*.vyf)

//uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0)

{
// *** ��������� � ��� �� ����� ����� ���� � ������� ��� �������
        AssignFile(fr1,'rezlt.ou');
        rewrite(fr1);
        writeln(fr1,'# ���� � ������������ ������� �����������');
        writeln(fr1,filename);

        x:=Ferm.corn[r,1];
        y:=Ferm.corn[r,2];

        // *****����� ������� ����� ������ ��������� � ���� � ������������ �����������- �������� ��������� - ��� ����������� ������������ �����������
        writeln(fr1,Ferm.nst1);
        writeln(fr1,Ferm.nyz1);
        writeln(fr1,Ferm.ny1);
//      writeln(fr1,'������ ��������� ��������');
        for i:=1 to Ferm.nst1 do
          begin
          writeln(fr1,Ferm.ITOPn[i,1]);
          writeln(fr1,Ferm.ITOPn[i,2]);
         end;
//      writeln(fr1,'������ ��������� �����');
        for i:=1 to Ferm.nyz1 do
          begin
          writeln(fr1,Ferm.corn[i,1]);
          writeln(fr1,Ferm.corn[i,2]);
         end;
//      writeln(fr1,'������ ��������� ��������'); �������� �� ������� ���������� ����� �����������
        for i:=1 to Ferm.nst1 do
      begin
           writeln(fr1,Ferm.fn[i]);
      end;
//      writeln(fr1,'������ ����������� �����');
        for i:=1 to Ferm.nyz1 do
          begin
          if Ferm.msn[i,1]=1 then writeln(fr1,0)
          else writeln(fr1,1);
          if Ferm.msn[i,2]=1 then writeln(fr1,0)
          else writeln(fr1,1);
         end;
// ��������� ������ ������
      writeln(fr1,'# ����� ��������������� ����');
// ��������� ����� ��������������� ����
      writeln(fr1,r);
      }

//********************************************************************************
// �  ������ VYV ��������� ��� ��������� �������� ����- ������� ��������
  fn3:=ChangeFileExt(filename,'.vyv');
  AssignFile(ff,fn3);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,Ferm.nst1);
  readln(ff,Ferm.nyz1);
  readln(ff,Ferm.ny1);
  readln(ff,Ferm.e1);
  readln(ff,Ferm.nsn1);
  readln(ff,Ferm.sd1);
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nst1 do
    readln(ff,ms1); {T��������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,f1f,f1f); {����������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nst1 do
    readln(ff,f1f);  {���. �������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,ms1); {�����������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nsn1 do   {��������}
    begin
      //readln(ff);
      for i1:=1 to Ferm.nyz1*2 do readln(ff,f1f);
    end;
  readln(ff,s_lin); readln(ff,s_for);
  readln(ff);
  readln(ff,sv);  // ������ 3 ������� ����
  CloseFile(ff);
if sv0=0 then sv0:=sv ; // ��� �����������

if fermoptnode.Ferm_opt_node.RadioButton5.Checked=true then // ���� ���������� �� �����
    begin
    massa:=0;
    for i:=1 to Ferm.nst1 do
       begin
       massa:=massa+ferm.Fn[i]*
       sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
           (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
         );
       end;
    sv:=massa; // ��������
    end;

//    writeln(fr1,sv);
//*** ��� ���������� ����k� SV ����� ����� ����������


  // ���� ����� ��� ���������� ����������� SV �� ����� � ��������������� ��������
{
 assignfile(ff,Ferm.fn);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='�����������';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='����� ��������';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
if uchet=0 then
  readln(ff,sv) // ���������� SV � �� SVS !!!!!! ��� ����� ������ �������� �� ������
  else
  readln(ff,leng);
//  readln(ff,sv);
  readln(ff);
//     uchet:=0;// ����������  ����������� �� �� ��������� �� �� ������ - NO(0)
  for i:=1 to kst do readln(ff,tol1[i]); // ��� ����� - ����������
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
// uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1)
if uchet=1 then
  readln(ff,sv) // ���������� SV � �� SVS !!!!!!
  else
  readln(ff,leng);
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);

}
// *** ����� ������ ��� ��������� �������� SV  � ��� - ��� ������������



// �������� �������� ��������������� ����- ����� ����� ���������� ������ ������ �������- ���� ����� ���� �� ����� �� "������" ������.
//        x_old:=Ferm.corn[r,1];
//        y_old:=Ferm.corn[r,2];// ���������
        x_old:=ferma_5_dannie_o_uzlax_d1[ferma5_num1,1]; // FERMA 5.1 - ��������
        y_old:=ferma_5_dannie_o_uzlax_d1[ferma5_num1,2];//FERMA 5.1 - ��������



     Main_Form.StatusBar1.Panels[2].Text :='����������� ����������� ...';

// ��������� ��������� ��������


//        h:=5; // ��� - ������ ����� �������� �������� ����������� � ������� ���� � ���� ������ �� ������ ��������� - �� ��� �� ����� ���..
//        r:=5; // ����� ������������ ���� ����� 2 ����� ��� ����� ���������
//        uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0) ������ � ���������
//        nr:=2; // ��������������� ������� ��� ������� ���������� ������ ��� ������ � ������������
      flag:=0;// ���� ������ ������� ������� - ��� ���������� ������
      l:=0;  //������� �����  // FERMA 5
//          l:=1;  // FERMA 5
//        maxkit2:=5; //������������ ���������� ����� . ����� 5 ����� ����� ���� ��������
{
        for i:=1 to Ferm.nst1 do // ���� ���� �������� �������� �� �� ���
          begin
           if (Ferm.ITOPn[i,1]=r)or (Ferm.ITOPn[i,2]=r) then // �������� �������� ��� ���� ?
           leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
              if flag=0 then
               begin
               leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
               h:=leng;
               flag:=1;
               end;
           if  leng<h then
           h:=leng;
          end;

}


// ����� �������� ��������� ��������
m0:     h:=h/2;
m1:     k7:=1;
m2:  k6:=k6+1;
     if k7=1 then
       // x1=x+1 y1=y
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,1]=0 then // �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptNode.Ferm_opt_node.RadioButton3.Checked=true) or (FermOptNode.Ferm_opt_node.RadioButton1.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        Ferm.corn[r,1]:=Ferm.corn[r,1]+h;

       end
     else if k7=2 then
       // x1=x-1 y1=y
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,1]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptNode.Ferm_opt_node.RadioButton3.Checked=true) or (FermOptNode.Ferm_opt_node.RadioButton1.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
         begin
         Ferm.corn[r,1]:=Ferm.corn[r,1]-h;
         end;
       end
     else if k7=3 then
       // x1=x y1=y+1
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,2]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptNode.Ferm_opt_node.RadioButton3.Checked=true) or (FermOptNode.Ferm_opt_node.RadioButton2.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        Ferm.corn[r,2]:=Ferm.corn[r,2]+h;
       end
     else
       // x1=x y1=y-1
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,2]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptNode.Ferm_opt_node.RadioButton3.Checked=true) or (FermOptNode.Ferm_opt_node.RadioButton2.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        begin
        Ferm.corn[r,2]:=Ferm.corn[r,2]-h;
        end;
       end;

// �������� �� ���
         if (Ferm.corn[r,1]<0)  then
           begin
           Ferm.corn[r,1]:=0; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
         if (ferm.corn[r,1]>ferm.region_x) then
           begin
           Ferm.corn[r,1]:=ferm.region_x; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
           // �������� �� ���� ���� - ��� ��� ���������
         if (Ferm.corn[r,2]<0)  then
           begin
           Ferm.corn[r,2]:=0; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
         // �������� �� ���� ����� - ���� ���� ���������
         if  (ferm.corn[r,2]>ferm.region_y) then
           begin
           Ferm.corn[r,2]:=ferm.region_y; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
// �������� �� ��� ���������

// �������� ������ ������� - �� ������� ��������� �� ������ - ����� �� ����� �� "������" - ���� ������� �� �����������!

         if sqrt(sqr(x_old-Ferm.corn[r,1])+sqr(y_old-Ferm.corn[r,2]))>fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2] then // �������� �� ������
          begin
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ ������� ������.';
              //  sleep(800);
          // ���������� ���������� �������� - ������ ��� �� ��� ������ �� ������� ��������  - ��� ��� ���� ������� �� �� "�������"
          if k7=1 then
          // x1=x+1 y1=y
           begin
           Ferm.corn[r,1]:=Ferm.corn[r,1]-h;
           end
          else if k7=2 then
          // x1=x-1 y1=y
           begin
           Ferm.corn[r,1]:=Ferm.corn[r,1]+h;
           end
          else if k7=3 then
           // x1=x y1=y+1
           begin
           Ferm.corn[r,2]:=Ferm.corn[r,2]-h;
           end
          else
          // x1=x y1=y-1
           begin
           Ferm.corn[r,2]:=Ferm.corn[r,2]+h;
           end;

          end;
      // ��������� ��������� �����


//************ ������������ ��� ���� � ������ ������������ (��������)

        ff1:=ChangeFileExt(filename,'');
        ff1:=ff1+'.temp';
        RenameFile(filename,ff1); // ����������������� �� ��� � ����
         // �� ������� TEMp   - � ��� ��������� ������ �� �������� �� ���� ����
        savedata;




//*****************************************************
// ��������� ����� �������� �������� ���� ��� ���������� ����������� ��� ��������
// ��������� ������� ������ - ������ ����


            DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';
            DllCall(DllName,FileName,Ferm);
 {
//     if isChanged then FileSave_MnuClick(Sender);
 //    if SaveCancel then exit;

     if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;

     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');

     try
          sp(PChar(FileName));
     finally
     //     Cursor:=crDefault;
//     DateTime := Time;  // store the current date and time
//  str := TimeToStr(DateTime);

//writeln(fr1,k7,' ',svs,' ',h ,' �����',str);
     end; }
//end;
// ������� ������ ������� !
// ��������������� ������

//     i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'opt_f.dll',FileName,material,fmi,ebsi,maxkit,ljambda);

     // � ����� �������� svs (������� ��� ���� ����� ��������) � ����� ����� - ������ ��� ���������� ��������� �����������

//Ferma.fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

//???????/
// �  ������ VYV
  fn3:=ChangeFileExt(filename,'.vyv');
    AssignFile(ff,fn3);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,Ferm.nst1);
  readln(ff,Ferm.nyz1);
  readln(ff,Ferm.ny1);
  readln(ff,Ferm.e1);
  readln(ff,Ferm.nsn1);
  readln(ff,sd1);
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nst1 do
    readln(ff,ms1); {T��������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,f1f,f1f); {����������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nst1 do
    readln(ff,f1f);  {���. �������}
  readln(ff); //readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,ms1); {�����������}
  readln(ff); //readln(ff);

  for i:=1 to Ferm.nsn1 do   {��������}
    begin
      //readln(ff);
      for i1:=1 to Ferm.nyz1*2 do readln(ff,f1f);
    end;
  readln(ff,s_lin); readln(ff,s_for);
  readln(ff);
  readln(ff,svs); // �������������!!!!! ��� ���������-��������� ����
  CloseFile(ff);  // ���������� SVS � �� SV !!!!!!

  svs1:=svs; // ��� ������������

  if fermoptnode.Ferm_opt_node.RadioButton5.Checked=true then // ���� ���������� �� �����
    begin
    massa:=0;
    for i:=1 to Ferm.nst1 do
       begin
       massa:=massa+ferm.Fn[i]*
       sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
           (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
         );
       end;
    svs:=massa; // �������
    end;

{
���� ����� ��� ������ � �������� ���������������� ������� � �� ��������
  Ferma.fn:=ChangeFileExt(filename,'.vyf');
 assignfile(ff,Ferma.fn);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='�����������';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='����� ��������';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  // uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1)
if uchet=1 then
  readln(ff,svs) // ���������� SVS � �� SV !!!!!!
  else
  readln(ff,leng);
//  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol1[i]); // ��� ����� - ����������
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
// uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1)
      if uchet=0 then
  readln(ff,svs) // ���������� SVS � �� SV !!!!!!
   else
   readln(ff,leng);
//  readln(ff,svs); // ���������� SVS � �� SV !!!!!!
  readln(ff);
  for i:=1 to kst do readln(ff,tol[i]);
  for i:=1 to 3 do  readln(ff);
  for i:=1 to kst do readln (ff,li[i]);
  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);
}


  //*** ��� ���������� ����k� SVS ����� ����� ����������

 if sv > svs then // ���� ���� �� �� ����� ������ � ������ �������� ������� �����...
//   if abs(sv-svs)>0.00000000000002 then // ���� ������� ��� � �������� ������� ������ �������� �� ������� ��� ��������� ������� � ������ ��� �������
   begin
// if abs(sv-svs)>0.00000000002 then // �������� �� �������� ����   ����� ������ ������� �������
//   writeln(fr1,'k6=',k6,' Svs=',svs,' L=',l,' H=',h,' k7=', k7);
//   writeln(fr1,k7,' ',svs,' ',h );
     Main_Form.StatusBar1.Panels[1].Text :='���� � ' +  inttostr(Ferm_opt_node.ferma5_kol_uzlov_m[ferma5_num1]) + ': (' + FormatFloat('0.##',x1) +' ; '+ FormatFloat('0.##',y1) +') -> ('+ FormatFloat('0.##',Ferm.corn[r,1]) +' ; '+ FormatFloat('0.##',Ferm.corn[r,2]) +')';
     Main_Form.StatusBar1.Panels[0].Text :='SG='+FormatFloat('0.00000E+00',sv);
     Ferma_Fd_Form.showD(Ferm);
     Repaint;
     Main_form.Refresh;
     Ferma_FD_Form.refresh;
     if fermoptnode.Ferm_opt_node.CheckBox1.Checked=true then sleep(1000); // �������� ��� �������������� ������������� ������������� ������

   sv:=svs;
   svs2:=svs1;
//   rezou_2[(nr div 2 )]:=k7;
//   rezou_1[nr]:=svs;
//   rezou_1[nr+1]:=h;
//   nr:=nr+2;
//   x:=x1; ���� � ����� ��� �������� - ����� ��� � ���������. ���� ���� ���� ����� �������. ����� � ���� ��  ������ ������
//   y:=y1;

   deletefile(ff1);// ������� TEMP
   goto m1;
   end
  else
   begin
        deletefile(filename);// ������� �������- � ��� ���������� ��������
        RenameFile( ff1,filename); // ���������� ����� ������ FRM ( �� ����� ����  - ������ TEMP)
   end;

 if k7=4 then // k=4 ?
   begin
    if l<maxkit2 then // maxkit2 - ���������� ����� ��� ������� �� �������
     begin
     l:=l+1;

     loaddata;
     Ferma_Fd_Form.showD(Ferm);
     Repaint;
     Main_Form.StatusBar1.Panels[2].Text :='����������� �����������...';
     Main_form.Refresh  ;
     Ferma_FD_Form.refresh;
     goto m3; // FERMA 5 !!!!!! ��� ����� ���������  ��� ������ � ����� ������. �������� �� ���� �� ����� ����
     goto m0;
     end
   else goto m3 // ���� L ����� ���������� �� �����
   end
 else
  begin
   Ferm.corn[r,1]:=x1;//FERMA 4 - ������� ��������� ��������
   Ferm.corn[r,2]:=y1;// FERMA 4
   k7:=k7+1;
   goto m2;
  end;

 m3: // �����




 loaddata;
 Ferma_Fd_Form.showD(Ferm);
 Repaint;
// Main_Form.StatusBar1.Panels[1].Text :=' (' + FormatFloat('0.##',x) +' ; '+ FormatFloat('0.##',y) +') => ('+ FormatFloat('0.##',Ferm.corn[r,1]) +' ; '+ FormatFloat('0.##',Ferm.corn[r,2]) +')';
//     Main_Form.StatusBar1.Panels[2].Text :='��������� '+inttostr(l)+' ����� ������';
     Main_Form.StatusBar1.Panels[1].Text :=' ';
     Main_Form.StatusBar1.Panels[2].Text :='����������� ����� ���������';     //������� ����������� ���������
     //Beep;
     if fermoptnode.Ferm_opt_node.CheckBox1.Checked=true then sleep(1000); // �������� ��� �������������� ������������� ������������� ������
     screen.Cursor:=crDefault;
     Main_Form.B13.Enabled:=true;
     Main_Form.BitBtn10.Enabled   :=true;
     last_opt_type              :=3;

// MessageDlg(#13+'������ ��������� ���� � '+ inttostr(r)+ ' ��������. ',mtInformation,[mbOk],0);


     //end;

end;
mex:

 fn3:=filename + '.bak'; // ������������ ��� ���� �� ����
 assignfile(ff,fn3);
 deletefile(filename);
 rename(ff,filename);

 isChanged             :=true;
 Caption               :=concat('*',real_fname);




// ����� ������ ��� ������������
// ������ � �������

//form3.Grd.RowHeights[1]:=18;
//form3.Grd.Cells[0,1]:='������� ���:';
//form3.Grd.Cells[1,1]:=FormatFloat('0.00000E+00',sv0);
//if svs2=0 then svs2:=sv0; // ���� �� ���� ��������� ����� - �� �� ������� � ��������� ��� - �� ���������� ��� � �� ��������������
//form3.Grd.Cells[2,1]:=FormatFloat('0.00000E+00',svs2) ;
//form3.Grd.Cells[2,1]:=form3.Grd.Cells[2,1]+formatfloat('0.0000E+00',svs2/sv0);

//form3.Grd.RowHeights[1]:=20;
//form3.Grd.RowHeights[2]:=20;

// C��������� �.�. 9.12.07 {SAE
Ferma_M_Anim.form3.FermWeight_Edt.Text:=FormatFloat('0.00000E+00',sv0);
if svs2=0 then svs2:=sv0; // ���� �� ���� ��������� ����� - �� �� ������� � ��������� ��� - �� ���������� ��� � �� ��������������
Ferma_M_Anim.form3.PSV_Edit.Text:=FormatFloat('0.00000E+00',svs2);
// SAE}

// form3.Grd.Cells[0,2]:='  ����� :';
// form3.Grd.Cells[1,2]:=FormatFloat('0.00000E+00',massa);
//massa:=0;
//for i:=1 to nst1 do massa:=massa+li[i]*tol1[i];
//form3.Grd.Cells[2,2]:=FormatFloat('0.00000E+00',sv);
// ��� ���� �����. (�� ���� ����� �� ��� �������: �����=�����*��������� ��� ��������� �����) ��� �������� ����������� MASSA � �� ������� ��� ���  � ������ ����� !!!!!!!!!!!!!!!!!!

massa:=0; // ����� ��� �����������

  for i:=1 to Ferm.nst1 do
   begin
   massa:=massa+ferm.Fn[i]*
    sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
          (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
        );
   end;



//form3.Grd.Cells[0,3]:='����� ���������';
//form3.Grd.Cells[1,3]:=('-');
form3.Value_Edt.Text:=FormatFloat('0.00000E+00',massa);  // C��������� �.�. 18.12.07

// ������� ��� ������ � ���������- ���������� � - ��������� ������� �����
// ��������� ����������� � ��� - � ��� ��������� ���� ����������! �� ��� ������� � �������� ��������
//form3.Grd.Cells[0,2]:='K (Sg / TOK)';
 if  Main_Form.WithTOK.Checked=true     then // ���� ��� ����
  begin

//************
   if Main_Form.TOK_OpenDialog.Execute then
     begin
      if (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.out')or
         (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.oup')then
        begin
         error:=False;
         s_tok:=Main_Form.TOK_OpenDialog.FileName;
        end;
     end;

  if not error then  //������� �� ������� ��� ���?
    begin
      AssignFile(ff,s_tok);
      reset(ff);
      ReadLn(ff);
      ReadLn(ff);
      ReadLn(ff,tok_weight);
      ReadLn(ff);
      ReadLn(ff);
      CloseFile(ff);
    end
    else
    tok_weight:=0;



//  svs:=(svs2/strtofloat(simplrezferm.SimpleFermResult_Form.TOKWeight_Edt.Text));
  svs:=(svs2/tok_weight);
//  form3.Grd.Cells[2,2]:=FormatFloat('0.00000',svs);
  form3.K_after_Edit.Text:=FormatFloat('0.00000',svs); // C��������� �.�. 18.12.07
//  svs:=(sv0/strtofloat(simplrezferm.SimpleFermResult_Form.TOKWeight_Edt.Text));
  svs:=(sv0/tok_weight);
//  form3.Grd.Cells[1,2]:=FormatFloat('0.00000',svs);
  form3.K_before_Edit.Text:=FormatFloat('0.00000',svs); // C��������� �.�. 18.12.07
  end
 else
  begin
   form3.K_before_Edit.Text:='��� ������';
   form3.K_after_Edit.Text:='��� ������';
  end;
 // ����������� ������� ������� ��������
 Ferma_M_Anim.form3.Areas_Grd.Cells[0,0]:='� C������';
 Ferma_M_Anim.form3.Areas_Grd.Cells[1,0]:='    ������� �������';
 Ferma_M_Anim.form3.Areas_Grd.Cells[2,0]:='';
 // ����������� ������� ������� ���������
 Ferma_M_Anim.form3.Coord_Grid.Cells[0,0]:='� ����';
 Ferma_M_Anim.form3.Coord_Grid.Cells[1,0]:='    �� ����������� ';
 Ferma_M_Anim.form3.Coord_Grid.Cells[2,0]:='    ����� �����������';

 
  // ������� ������� ��������
  for i:=1 to Ferm.nst1 do
      begin
        Ferma_M_Anim.form3.Areas_Grd.Cells[1,i]:='';
        Ferma_M_Anim.form3.Areas_Grd.Cells[2,i]:='';
        Ferma_M_Anim.form3.Areas_Grd.Cells[0,i]:='';
      end;
   // ������� ������� �����
  for i:=1 to Ferm.nyz1 do
      begin
        Ferma_M_Anim.form3.Coord_Grid.Cells[1,i]:='';
        Ferma_M_Anim.form3.Coord_Grid.Cells[2,i]:='';
        Ferma_M_Anim.form3.Coord_Grid.Cells[0,i]:='';
      end;
  // ������� �������
  for i:=1 to Ferm.nst1 do
      begin
        Ferma_M_Anim.form3.Areas_Grd.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
        Ferma_M_Anim.form3.Areas_Grd.Cells[0,i]:=IntToStr(i);
      end;
      
 // ������� ����������
for i:=1 to strtoint(Ferm_opt_node.Edit9.Text) do // ������� ������� ����� ������� ���������������
 begin
 // ������ � �������
  Ferma_M_Anim.form3.Coord_Grid.Cells[0,i]:=inttostr(Ferm_opt_node.ferma5_kol_uzlov_m[i]);
  Ferma_M_Anim.form3.Coord_Grid.Cells[1,i]:='(' + FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,1])                  +' ; '+ FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,2])+')';
  Ferma_M_Anim.form3.Coord_Grid.Cells[2,i]:='(' + FormatFloat('0.##',Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[i],1])+' ; '+ FormatFloat('0.##',Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[i],2])+')';

 end;
{
form3.Grd.Cells[0,4]:='���� � ';
for i:=1 to strtoint(Ferm_opt_node.Edit9.Text) do // ������� ������� ����� ������� ���������������
 begin
 // ������ � �������
  form3.Grd2.Cells[0,i+4]:=inttostr(Ferm_opt_node.ferma5_kol_uzlov_m[i]);
  form3.Grd2.Cells[0,i+4]:='(' + FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,1])                  +' ; '+ FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,2])+')';
  form3.Grd2.Cells[0,i+4]:='(' + FormatFloat('0.##',Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[i],1])+' ; '+ FormatFloat('0.##',Ferm.corn[Ferm_opt_node.ferma5_kol_uzlov_m[i],2])+')';

 end;
}
Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);

 Flag:=MessageDlg(chr(13)+'����������� ����� ���������. �������� ����������?' ,mtInformation,[mbYes,mbNo],0);
 if flag=mrNo then
   exit;
 if FileExists(ChangeFileExt(FileName,'.vyv')) then
   begin
     if opt_type[0] = 1 then
    begin
     if fermoptnode.Ferm_opt_node.RadioButton5.Checked=true then
       form3.Label9.Caption:='�� �����'
     else
        form3.Label9.Caption:='�� �������� ����';
        form3.Caption:=('���������� ����������� ��������� ����� ��� ' + real_fname);
        form3.show;
    end;
   end;
end;
//END**************www************* ������ ����������� ��������� �����*************



// ferma 5 ����������� �� �����

//************************************************************************** *****

// ferma 5 ����������� �� �����




procedure TFerma_Form.N12Click(Sender: TObject);// ferma 5 ����������� �� �����
type
     TMethodProc=procedure(Fn:PChar);

var
     LibHandle:THandle;
     DllName:string;
     sp:TMethodProc;
     i,w:Integer;
     fmi,ebsi:single;
     k,maxkit,ljambda:Integer;
     material:string;
// www ��� ���������� :
 uchet:integer ;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0)
fn3,ff1:string;

{
  kst,i,it:integer;
  pogr,sv,vm,start_value:extended;
  tol:array[1..15] of extended;        // ��������� �������
  li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
 }

  ff:System.text;
  s,s_lin,s_for:string;
  pogr,region_x,region_y:extended;
  tol1:array[1..15] of extended;        // ��������� ������� -��� �����
  tol:array[1..15] of extended;        // ��������� �������
//  tol2:array[1..15] of extended;        // ������� ����� ����� ������� - ��� ������ �� ������ ��������.
  li1,li, Mom_in: array[1..15] of extended;
  current_ferm:TFerm;
//****************************************************
  d1,dd :  System.text;
  it,kst,mg,j,i1,jj,ka:integer;
  co,sg,fm,sima,s1,s2,s3: single;
 ITOPn: array[1..15,1..2] of integer;                {���O�O��� CTEP�HE�}
 Fn:    array[1..15] of single;                      {HA�A��H�E ��O�A��}
 CORn:  array[1..9,1..2] of single;                  {KOOP��HAT� ���OB}
 corTemp:single;
 MSn:   array[1..9,1..2] of integer;                 {�AKPE��EH�� ���OB}
 P:    array[1..18,1..3] of single;                 {HA�P��K�}
 NST1:integer;                                       {��C�O CTEP�HE� �EPM�}
 NYZ1:integer;                                       {��C�O ���OB}
 NY1:integer;                                        {��C�O �AKPE��EH��}
 E1:single;                                          {MO���� ��P��OCT�}
 NSN1:integer;                                       {��C�O C���AEB HA�P��EH��}
 SD1:single;                                         {�O��CKAEMOE HA�P��EH�E}
 N1:integer;                                        {��C�O HE��BECTH�X}
 U:   array[1..18,1..3] of single;                  {�EPEME�EH�� ���OB}
 SIGP:array[1..15,1..3] of single;                  {HA�P��EH�� B CTEP�H�X}
 kgv: single;

  f1f:extended;
  ii,ms1:integer;
   s_tok, tok_error, tok_s_lin, tok_s_for:string;
  tok_weight:extended;
//*******
fr1 :  System.text;// ��� ���� � ������� �� ����������� ����� - �� ������������� ���������� ������������� ����������� �����
   rezou_2:array [1..500] of integer; // ������ ��� ���������� ������ � ����� �� ������
   rezou_1:array [2..1000] of real; // ������ ��� ���������� ������ � ����� �� ������
nr,k6:integer;
      fw1: TFerm;

     ferma5_num :integer; // ����� �������� - �������� �� 1 �� 4.
ferma5_num1:integer;//���������
ferma_5_dannie_o_uzlax_d: array [1..10] of real; // ��� �  �������� ������ ������� ������� � ������� ferma_5_dannie_o_uzlax
ferma_5_dannie_o_uzlax_d1: array [1..10,1..2] of single; // ��� ��� �������� "������" - ������ ��������� ��������� - �� ������ ������������ ������� ����


//************

     h :real; // ���
     r,r1:integer; // ����� ��������������� ����
     k7 : integer; // ��� ����������� ���������� ������
     l,maxkit2:integer; // ���������� ����� ��� ������
     sv,svs,sv2,sv3,sv31,sv1:real; // ������� ��� - � ������ � ����� �����
     massa,massa2:real;// �� ����� ����� �� ������� ��� ������������� �����
     leng,x_old,y_old:real; // x_old,y_old - ��� ���������� �������� ����- ��� �������� "������" ������
     x,x1,y,y1 : real; // ���������� ���� - ������ � "��������"
     flag:integer;// ��������������� ����������
     xh1,xh2,xh3:integer;
     sv0,sv21:real;// ������ ��� �������� � ������������.
     label nn,m0,m1,m2,m3,m4;


begin
  opt_type[1]:=1; // ���������� �.�.
  Fermoptmassa.Ferm_opt_massa.ScrollBar1.min:=1; // ������ ��� ���������
  Fermoptmassa.Ferm_opt_massa.ScrollBar1.Max:=200;
  Fermoptmassa.Ferm_opt_massa.ScrollBar1.position:=15;
  Fermoptmassa.Ferm_opt_massa.Edit9.Text:='0'; // ����� ���������� �������������� �����
  Fermoptmassa.Ferm_opt_massa.Groupbox6.Visible:=false;
  Fermoptmassa.Ferm_opt_massa.OptNodeEdt.Text:='';
  Ferm_opt_massa.ComboBox1Click11(sender);
//  ferma5_kol_uzlov:=strtoint(Fermoptmassa.Ferm_opt_massa.Edit9.Text); // ������� ������� ����� ��� ������������
  Ferm_opt_node.Ak_flag:=false; // ���� ���������� ������ ��� ����������� ������� ��������� ����
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;// ������� ��� ������ � �������� ���� � ��� �����������
  Main_Form.StatusBar1.Panels[2].Text :='���� ������ ��� ����������� �� �����';
  Ferm_opt_massa.Caption:='���������� �����������- ������ ' +  ExtractFileName(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName) ;


  if Ferm_opt_massa.ShowModal<>mrOk then
  begin
   Main_Form.StatusBar1.Panels[2].Text :='����� �� ���������� �����������';
   Fermoptnode.Ferm_opt_node.Ak_flag:=false; // ���� ���������� ������
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
   goto nn;
  end
  else
  Main_Form.StatusBar1.Panels[2].Text :='���������� �����������.';
  FermOptNode.Ferm_opt_node.Ak_flag:=false; // ���� ���������� ������
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;

  // �������� DLL � �������� �� ���������
   /// ������ ����� DLL.  ���� ��� ��� ������� - ��� ������ :(



   //////////////////////////////////////////////////////////////////

        try
      fmi:=StrTofloat(FermOptmassa.Ferm_opt_massa.fmi_edt.text);
      ebsi:=StrTofloat(FermOptmassa.Ferm_opt_massa.ebsi_edt.text);
      maxkit:=StrToInt(FermOptmassa.Ferm_opt_massa.maxkit_edt.text);
      ljambda:=StrToInt(FermOptmassa.Ferm_opt_massa.ljambda_Edt.text);
    except
      //Beep;
      MessageDlg('������ ����� ���������� �����������.'+#13+'���� �� ���������� ����� �������. ������� �� �����.',mtError,[mbOk],0);
      exit;
    end;

     if fmi<0 then
     begin
      //Beep;
      MessageDlg('������ ����� ����������� ������� ������� �������.'+#13+'������� ������������� ��������.',mtError,[mbOk],0);
//      Result:=false;
      exit;
     end;
    if (ebsi>=1)or(ebsi<=0) then
     begin
      //Beep;
      MessageDlg('������ ����� ��������.'+#13+'������� �������� ��� ����������� ���������.',mtError,[mbOk],0);
//      Result:=false;
      exit;
     end;
    if (maxkit<1) or (maxkit>1000) then
     begin
      //Beep;
      MessageDlg('������ ����� ����� ��������.'+#13+'������� �������� ��� ����������� ���������.',mtError,[mbOk],0);
//      Result:=false;
      exit;
     end;
//        l11:= 3.14*sqrt(   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.e1 / abs(  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.sd1)); // �������� �� ������� ����� �� ������ ���������  ����������  �� �� ������ ������ 50 �������� � �� �������.

     if (ljambda<50 ) or (ljambda>210) then
     begin
      //Beep;
      MessageDlg(('������ ����� ������������ ������ ��������.'+#13'������� �������� ��� ����������� ���������. (50 - 210)'),mtError,[mbOk],0);
//      Result:=false;
      exit;
     end;

  {

      // *************
      // ������� ������ �� �������- ���� �� NYZ
      FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
      AssignFile(ff,FileName);
      reset(ff);
      readln(ff,nst1);
      readln(ff,nyz1);
      CloseFile(ff);
     // ���������

     if (xh1>nyz1)or(xh1<=0) then
     begin
      //Beep;
      MessageDlg('������ ����� ������ ����.',mtError,[mbOk],0);
      exit;
      end;
r:=xh1;// ����
     if (xh2>15)or(xh2<=0) then
     begin
      //Beep;
      MessageDlg('������ ����� ���������� �����.',mtError,[mbOk],0);
      exit;
     end;
maxkit2:=xh2; // ����
     if (h>200)or(h<1) then
     begin
      //Beep;
      MessageDlg('������ ����� ������� (1-200).',mtError,[mbOk],0);
      exit;
     end;


   }



  fn3:=filename + '.bak'; // �������� �������� ���� ��� ���
  CopyFileTo(filename,fn3);

 /// �������������� ������� ������ - ���� ��������� ������� ��������
     savedata; // ��������� ����� �������� ������� ���������
     Main_form.Refresh  ; // ���������� - ��� ���� ����� ���� ����� ����� - ��� ���� ��� ���������.
loaddata;
screen.Cursor:=crHourGlass;


for i:=1 to Ferm.nst1 do // ������� � ����� ����������� ������ �������� w konze
fermoptmassaRez.FermOptMassaRez_form.tol21[i]:=ferm.fn[i];

sv0:=0; // ������� ��� ��� �����������

massa:=0; // ����� ��� �����������

// ��� ������ ������������ ��������� �������


//      FermOptMassaRez.FermOptMassaRez_form.IterationNumber_Edt.Text:=IntToStr(it-1);
//      FermOptMassaRez.FermOptMassaRez_form.Precission_Edt.Text:=FormatFloat('0.000e+00',pogr);
//      FermOptMassaRez.FermOptMassaRez_form.Value_Edt.Text:=FormatFloat('0.000e+00',vm);
//      FermOptMassaRez.FermOptMassaRez_form.FermWeight_Edt.Text:=FormatFloat('0.000e+00',sv);

      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.RowHeights[0]:=18;
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.RowHeights[0]:=18;
      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[0,0]:='� C������';
      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[1,0]:='    �������� �������';
      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[2,0]:='    ���������� �������';
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[0,0]:='� C������';
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[1,0]:='  �������� �������';
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[2,0]:='  ���������� �������';
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[3,0]:='  ������ �������';


// �������� ����� ��������� ��� ��������� ����������� ��� ������������ - ������ ���� ��� ������� ���� ����� ���� �������( � ���  ���������� � ����� ������)

    // ������� ������� ��������
  for i:=1 to Ferm.nst1 do
      begin
        FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[1,i]:='';
        FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[2,i]:='';
        FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[0,i]:='';
      end;
   // ������� ������� ���������
  for i:=1 to Ferm.nyz1 do
      begin
        FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[0,i]:='';
        FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[1,i]:='';
        FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[2,i]:='';
      end;
   // ������� �������
    for i:=1 to Ferm.nst1 do
      begin
// ������� ��� ������������ ����� ������� ���� ��� ������������ ���
      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[0,i]:=IntToStr(i);

//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[1,i]:=FormatFloat('0.000e+00',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Fn[i]);
//      FermOptMassaRez.FermOptMassaRez_form.Areas_Grd2.Cells[0,i]:=IntToStr(i);

      massa:=massa+ferm.Fn[i]*
      sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
          (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
        );
    end;

//    form3.Grd2.Cells[1,2]  :=FormatFloat('0.00000E+00',massa); ���������� �.�. 15.12.07

    FermOptMassaRez.FermOptMassaRez_form.StartValue_Edt.Text:=FormatFloat('0.000e+00',massa); //���������� �.�. 15.12.0
//    FermOptMassaRez.FermOptMassaRez_form.StartValue_Edt2.Text:=FormatFloat('0.000e+00',massa);




// ������������ ��������������
// ����� �������� �������� ������� ( ���� �� �������� �� ������) ���� ��������� �� � ������� �������� � � ��������� , �������
// �������� ��������� ���������� ����� � �������������� ������-� ����� ��������� ��������� ����� � ����.
for ferma5_num1:=1 to strtoint(Ferm_opt_massa.Edit9.Text) do // ���� �� ���� ��������� �����
    begin
//    fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]
    ferma_5_dannie_o_uzlax_d1[ferma5_num1,1]:=Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[ferma5_num1],1];  // X
    ferma_5_dannie_o_uzlax_d1[ferma5_num1,2]:=Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[ferma5_num1],2];  // Y
    end;
// ����� ������� ��� ������� ��� � ������ ������:
for ferma5_num1:=1 to strtoint(Ferm_opt_massa.Edit9.Text) do // ���� �� ���� ��������� �����
    begin
//    fermoptnode.Ferm_opt_node.ferma_5_dannie_o_uzlax[ferma5_num1,2]
    ferma_5_dannie_o_uzlax_d[ferma5_num1]:=(fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,2]); //�������� �������!!!! ��� ������ �������
    end;


// ��� ��� � � ���������� ����������� ��� �����- �������- �� �������� , ���������� �� ����� � �������.
for ferma5_num:=1 to StrToInt(Fermoptmassa.Ferm_opt_massa.edit8.text) do // ����� ��������
for ferma5_num1:=1 to strtoint(Ferm_opt_massa.Edit9.Text) do // ���� �� ���� ��������� �����
begin
{
������ ��� - ������� ���� ��������  ����������� ��� ������ ���� - ������ ����� ��
������������ ��� - ��� �������� ����� - �� �� ����� ����������� �� !
�� � ������ ����������� ��� �����- ������ �� �������� � ������ �� ����� ���������.
� �  ������ �������� ������ ������ �������� ������� - ������ �� ������� � ����������� ��� �������� ����.
� ��� ���������- ��� ��� ����� H(h) - ����� ��� ���� ��������� �� ���� � ����� ������
�� ����������� �������� . ��� ���� �������� ��� ������ ���������. - ��� �����������
��� ��� maxkit2=1 ������� ��- ����� ����� ����� ������ ����� ��� �� ����� ��� � �����������
��������� ���������� ���� - � ����� �� �����. ����� �������� �� ����� ���� ����� � ���������
 ��� �� �� ������e�( �� ���� ������� �� �����) � ������� ��� ���� ���� ���  - ��� ��� ��� ���������.




}
//      xh1:=StrToint(FermOptmassa.Ferm_opt_massa.edit1.Text); // ����� ����
//      xh2:=StrToint(FermOptmassa.Ferm_opt_massa.edit2.Text);// ����� ���������
//      h:=StrToInt(FermOptmassa.Ferm_opt_massa.edit3.Text);  // ��� - �������

       xh1:=(Ferm_opt_massa.ferma5_kol_uzlov_m1[ferma5_num1]); // ������������ ���� �����
       r:=xh1;// ����

 xh2:=  Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,1]; //������������ ���������� ����� .
 maxkit2:=xh2; // ����
 if  xh2=0 then   goto m3; // ���� ��� ������� ���� ������� ������ ��� �� ��� - ���� ���� �� �������������� ������ - ��� ���� ���������� ������������ ��������� ��������� ����
 Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,1]:=Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,1]-1;

// h:=Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,2]; //������ ������� ������ !!!!!
 h:=ferma_5_dannie_o_uzlax_d[ferma5_num1];
    ferma_5_dannie_o_uzlax_d[ferma5_num1]:=ferma_5_dannie_o_uzlax_d[ferma5_num1]/2; // �  �������� ��� ��������� ������� ���
    // ����� ������ �� ( ���� ������ ����� ��� ��� goto ) ���������� ��� ��������� � ���������� ��� ������ ����



  if Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,3]=1   then
    Fermoptmassa.Ferm_opt_massa.radiobutton1.Checked:=true;
  if Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,3]=2   then
    Fermoptmassa.Ferm_opt_massa.radiobutton2.Checked:=true;
  if Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,3]=3   then
    Fermoptmassa.Ferm_opt_massa.radiobutton3.Checked:=true;


  if   Fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,4]=1 then // ����� ������������� ������
  Fermoptmassa.Ferm_opt_massa.CheckBox1.Checked:=true
  else
  Fermoptmassa.Ferm_opt_massa.CheckBox1.Checked:=false;
//*************************************** zakoncili ��������� ������� ��� ������ ����




//begin

     //�������� �� ������������ ���� (�� ������������� �� ������ �������)
     for i:=1 to Ferm.nyz1 do
     begin
          Flag:=-1;
          for j:=1 to Ferm.nst1 do
          begin
               if (Ferm.ITOPn[j,1]=i) or (Ferm.ITOPn[j,2]=i) then
               begin
                    Flag:=0;
                    break;
               end;
          end;
          if (Flag=-1) then break;
     end;
     if Flag=-1 then Flag:=MessageDlg(chr(13)+'� ������ ����������� ���� ����/���� �� ������������� �� ������ �������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;

     k:=0;
     for i:=1 to Ferm.nyz1 do
     begin
          k:=k+Ferm.msn[i,1]+Ferm.msn[i,2];
     end;
     w:=2*Ferm.nyz1-Ferm.nst1-k;
     if w>0 then Flag:=MessageDlg(chr(13)+'������ ����������� ������������ ����� ��������! ����������?' ,mtWarning,[mbYes,mbNo],0);
     if Flag=mrNo then exit;


            DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';
            DllCall(DllName,FileName,Ferm);

     {if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');
     try
          sp(PChar(FileName));
     finally

     //          Cursor:=crDefault;
     end;   }

// ������� ������ ������� !




//     if isChanged then FileSave_MnuClick(nil);
//     if SaveCancel then exit;

     for i:=1 to Main_Form.Ferma_num_mat+2 do
          if (Main_Form.Ferma_MMaterials[i].MModUpr = Ferm.e1) and
             (Main_Form.Ferma_MMaterials[i].MDopNapr = Ferm.sd1) then
          begin
               material := Main_Form.Ferma_MMaterials[i].MName;
          end;


     i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'opt_f.dll',FileName,Ferm,material,fmi,ebsi,maxkit,ljambda);
     // ���� ��� ��� ������ ������ --  ���� ������� � ��� �� ��� ��� ���� �� �� ������� ����������� �����
     // ������ ���� ������� �����  ��������� ��������- ������� �� ����������� �������� ���� .
     // ���� ���� ��������� ���������� ������� ���� ��� ������������ � ������� ����� � ������� ������������� ���������� ����� � ��������� ����
     // �� �������� ������� �������� �����������,  �������� ����, � ���
     Case i of
          0: S:='������� ��������� ���������.';
          1: begin
               S                             :='���������� ���������� ����� ��������.';
          end;
          2: begin
               S                             :='���������� �������� ��������.';

          end;
     else begin
          S                             :='��������� ���������� ������. ���������� ��������� �������� (������ ��������, ��-��!)';
     end;
     end;

  Main_Form.StatusBar1.Panels[2].Text :=''+ S;
     // �������� ������� � ��������� �������� ��������� ���� ����


//���� ����� ��� ������ � �������� ���������������� ������� � �� ��������

  fn3:=ChangeFileExt(filename,'.vyf');
//  Ferma.fn:=ChangeFileExt(filename,'.vyf');
 assignfile(ff,fn3);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='�����������';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='����� ��������';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);

  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv � LI
   readln(ff,svs) //!  ��� �����
  else
   readln(ff,sv1);

  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv
   for i:=1 to kst do readln(ff,tol1[i]) // ��� ����� - ����������
  else
   for i:=1 to kst do readln(ff,tol[i]); // ��� ����� - ����������

  for i:=1 to 3 do  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv
   for i:=1 to kst do readln (ff,li[i])
  else
   for i:=1 to kst do readln (ff,li1[i]);

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);

  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   readln(ff,sv1) //  SV !!!!!!
  else
   readln(ff,svs);

  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   for i:=1 to kst do readln(ff,tol[i])
  else
   for i:=1 to kst do readln(ff,tol1[i]);

  for i:=1 to 3 do  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   for i:=1 to kst do readln (ff,li1[i])
  else
   for i:=1 to kst do readln (ff,li[i]);

  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);


if sv0=0 then
begin
 sv0:=svs ; // ��� �����������
 sv2:=svs; // ��� �� ��� ����������� ��������� ��� �� ���������.
 sv21:=svs;
end;
// ��� ��� ���������� ����� �����- �� ��� ��� �������- ���� ��������� - ������� :
massa:=0;
for i:=1 to kst do massa:=massa+li1[i]*tol[i];
// ��� ���� �����. (�� ���� ����� �� ��� �������: �����=�����*��������� ��� ��������� �����) ��� �������� ����������� MASSA � �� ������� ��� ���  � ������ ����� !!!!!!!!!!!!!!!!!!
// � ����� ���� ������ �� ������ ��������� ������ SV �����
sv:=massa; /// �� ���������������� ��� �� ������� ���- ��� ���� ���  �� ������� ������� ����� ����



// ��������� ���� ����� - �� ����� � ������ ���������
Click1(Sender);
// ���� ���������� � ��������� ���������. �������������� ��� ���� ���
// ��������� ��������� ��������
//     x_old:=Ferm.corn[r,1];// ��� ��� ������� ������ - ���������� �������������� ���������� ����� ����
//     y_old:=Ferm.corn[r,2];
     x_old:=ferma_5_dannie_o_uzlax_d1[ferma5_num1,1]; // FERMA 5.1 - ��������
     y_old:=ferma_5_dannie_o_uzlax_d1[ferma5_num1,2];//FERMA 5.1 - ��������
//        h:=5; // ��� - ������ ����� �������� �������� ����������� � ������� ���� � ���� ������ �� ������ ��������� - �� ��� �� ����� ���..
//        r:=5; // ����� ������������ ���� ����� 2 ����� ��� ����� ���������
//        uchet:=1;// ����������  ����������� �� �� ��������� �� �� ������(1) ��� ���(0) ������ � ���������
//        nr:=2; // ��������������� ������� ��� ������� ���������� ������ ��� ������ � ������������
//        flag:=0;// ���� ������ ������� ������� - ��� ���������� ������

      l:=0;  //������� �����
k6:=0;
 //        maxkit2:=5; //������������ ���������� ����� . ����� 5 ����� ����� ���� ��������
{
        for i:=1 to Ferm.nst1 do // ���� ���� �������� �������� �� �� ���
          begin
           if (Ferm.ITOPn[i,1]=r)or (Ferm.ITOPn[i,2]=r) then // �������� �������� ��� ���� ?
           leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
              if flag=0 then
               begin
               leng:=sqrt(sqr(Ferm.corn[(Ferm.ITOPn[i,2]),1]-Ferm.corn[(Ferm.ITOPn[i,1]),1])+sqr(Ferm.corn[(Ferm.ITOPn[i,2]),2]-Ferm.corn[(Ferm.ITOPn[i,1]),2]));
               h:=leng;
               flag:=1;
               end;
           if  leng<h then
           h:=leng;
          end;

}


// ����� �������� ��������� ��������
m0:     h:=h/2;
m1:     k7:=1;
m2:  k6:=k6+1;
     if k7=1 then
       // x1=x+1 y1=y
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,1]=0 then // �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptmassa.Ferm_opt_massa.RadioButton3.Checked=true) or (FermOptmassa.Ferm_opt_massa.RadioButton1.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        Ferm.corn[r,1]:=Ferm.corn[r,1]+h;

       end
     else if k7=2 then
       // x1=x-1 y1=y
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,1]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptmassa.Ferm_opt_massa.RadioButton3.Checked=true) or (FermOptmassa.Ferm_opt_massa.RadioButton1.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
         begin
         Ferm.corn[r,1]:=Ferm.corn[r,1]-h;
         end;
       end
     else if k7=3 then
       // x1=x y1=y+1
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,2]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptmassa.Ferm_opt_massa.RadioButton3.Checked=true) or (FermOptmassa.Ferm_opt_massa.RadioButton2.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        Ferm.corn[r,2]:=Ferm.corn[r,2]+h;
       end
     else
       // x1=x y1=y-1
       begin
        x1:=Ferm.corn[r,1];
        y1:=Ferm.corn[r,2];
//        if Ferm.msn[r,2]=0 then// �������� �� ����������� ����. ������ �������� ��������!!!!
        if (FermOptmassa.Ferm_opt_massa.RadioButton3.Checked=true) or (FermOptmassa.Ferm_opt_massa.RadioButton2.Checked=true)  then // �������� �� ����������� ����. �����3= �� , �����1=� ����� �����2= �� �. ���� ��� 1 ��� 3 ������� �� �
        begin
        Ferm.corn[r,2]:=Ferm.corn[r,2]-h;
        end;
       end;


// �������� �� ���
         if (Ferm.corn[r,1]<0)  then
           begin
           Ferm.corn[r,1]:=0; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
         if (ferm.corn[r,1]>ferm.region_x) then
           begin
           Ferm.corn[r,1]:=ferm.region_x; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
           // �������� �� ���� ���� - ��� ��� ���������
         if (Ferm.corn[r,2]<0)  then
           begin
           Ferm.corn[r,2]:=0; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
         // �������� �� ���� ����� - ���� ���� ���������
         if  (ferm.corn[r,2]>ferm.region_y) then
           begin
           Ferm.corn[r,2]:=ferm.region_y; // ���� ��� ����������� ���������� ����� ������ ����- �� ���� �� ��� ���������- ����� !! ������ ����� ������. ������ ������ ����.
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ � �������.';
           end;
// �������� �� ��� ���������


 // �������� ������ ������� - �� ������� ��������� �� ������ - ����� �� ����� �� "������" - ���� ������� �� �����������!
         if sqrt(sqr(x_old-Ferm.corn[r,1])+sqr(y_old-Ferm.corn[r,2]))>fermoptmassa.Ferm_opt_massa.ferma_5_dannie_o_uzlax1[ferma5_num1,2] then // �������� �� ������
          begin
           Main_Form.StatusBar1.Panels[2].Text :='���� ������ ������� ������.';
          // ���������� ���������� �������� - ������ ��� �� ��� ������ �� ������� ��������  - ��� ��� ���� ������� �� �� "�������"
          if k7=1 then
          // x1=x+1 y1=y
           begin
           Ferm.corn[r,1]:=Ferm.corn[r,1]-h;
           end
          else if k7=2 then
          // x1=x-1 y1=y
           begin
           Ferm.corn[r,1]:=Ferm.corn[r,1]+h;
           end
          else if k7=3 then
           // x1=x y1=y+1
           begin
           Ferm.corn[r,2]:=Ferm.corn[r,2]-h;
           end
          else
          // x1=x y1=y-1
           begin
           Ferm.corn[r,2]:=Ferm.corn[r,2]+h;
           end;

          end;
      // ��������� ��������� �����



//************ ������������ ��� ���� � ������ ������������ (��������)

        ff1:=ChangeFileExt(filename,'');
        ff1:=ff1+'.temp';
        RenameFile(filename,ff1); // ����������������� �� ��� � ����
         // �� ������� TEMp   - � ��� ��������� ������ �� �������� �� ���� ����
        savedata;




//*****************************************************
// ��������� ����� �������� �������� ���� ��� ���������� ����������� ��� ��������
// ��������� ������� ������ - ������ ����

   
            DllName:=ExtractFilePath(Application.ExeName)+'simple_f.dll';
            DllCall(DllName,FileName,Ferm);

//     if isChanged then FileSave_MnuClick(Sender);
 //    if SaveCancel then exit;
     {
     if not FileExists(FileName) then
     begin
          //Beep;
          MessageDlg('���� � ������� ��������� ��� �����������.'+#13+'��������� ������ ����� ��������.',mtError,[mbOk],0);
          exit;
     end;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          //Beep;
          MessageDlg(#13+'��� ���������� '+#39+'Simple_F.dll'+#39,mtError,[mbOk],0);
          exit;
     end;

     @sp   :=GetProcAddress(LibHandle,'SimpleFerm');

     try
          sp(PChar(FileName));
     finally
     //     Cursor:=crDefault;
//     DateTime := Time;  // store the current date and time
//  str := TimeToStr(DateTime);

//writeln(fr1,k7,' ',svs,' ',h ,' �����',str);
     end;}
//end;
// ������� ������ ������� !
// ��������������� ������

     i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'opt_f.dll',FileName,Ferm,material,fmi,ebsi,maxkit,ljambda);

     // � ����� �������� svs (������� ��� ���� ����� ��������) � ����� ����� - ������ ��� ���������� ��������� �����������

//Ferma.fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

// ������� ��������� - ������������ ��������� � �������� �������������

{
// �  ������ VYV
  fn3:=ChangeFileExt(filename,'.vyv');
    AssignFile(ff,fn3);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,Ferm.nst1);
  readln(ff,Ferm.nyz1);
  readln(ff,Ferm.ny1);
  readln(ff,Ferm.e1);
  readln(ff,Ferm.nsn1);
  readln(ff,sd1);
  readln(ff); readln(ff);
  for i:=1 to Ferm.nst1 do

    readln(ff,ms1); //{T��������
  readln(ff); readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,f1f,f1f); //{����������
  readln(ff); readln(ff);
  for i:=1 to Ferm.nst1 do
    readln(ff,f1f);  //{���. �������
  readln(ff); readln(ff);
  for i:=1 to Ferm.nyz1 do
    readln(ff,ms1); //�����������
  readln(ff); readln(ff);

  for i:=1 to Ferm.nsn1 do   //��������
    begin
      readln(ff);
      for i1:=1 to Ferm.nyz1*2 do readln(ff,f1f);
    end;
  readln(ff,s_lin); readln(ff,s_for);
  readln(ff);
  readln(ff,svs); // �������������!!!!! ��� ���������-��������� ����
  CloseFile(ff);  // ���������� SVS � �� SV !!!!!!
  }




//���� ����� ��� ������ � �������� ���������������� ������� � �� ��������
  fn3:=ChangeFileExt(filename,'.vyf');
 assignfile(ff,fn3);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='�����������';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='����� ��������';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);



//*****************
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv � LI
   readln(ff,svs) //!  ��� �����
  else
   readln(ff,sv1);

  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv
   for i:=1 to kst do readln(ff,tol1[i]) // ��� ����� - ����������
  else
   for i:=1 to kst do readln(ff,tol[i]); // ��� ����� - ����������

  for i:=1 to 3 do  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then   // ��������� ���� ���� ������ TOL1 � SVS � ��� ������� �� ����� ��������� � ������ TOL � sv
   for i:=1 to kst do readln (ff,li[i])
  else
   for i:=1 to kst do readln (ff,li1[i]);

  readln(ff);
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);

  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
  //  readln(ff,svs); // ���������� SVS � �� SV !!!!!! ����� - �� ������ �������� -  ��� ����� ����������
   readln(ff,sv1) //  SV !!!!!!
  else
   readln(ff,svs);

  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   for i:=1 to kst do readln(ff,tol[i])
  else
   for i:=1 to kst do readln(ff,tol1[i]);

  for i:=1 to 3 do  readln(ff);
  if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   for i:=1 to kst do readln (ff,li1[i])
  else
   for i:=1 to kst do readln (ff,li[i]);

  readln(ff);
  for i:=1 to kst do readln (ff,Mom_in[i]);
  CloseFile(ff);




// ��� ��� ���������� ����� �����- �� ��� ��� �������- ���� ��������� - ������� :

massa:=0;
for i:=1 to kst do massa:=massa+li1[i]*tol[i];

//massa2:=0;
//for i:=1 to kst do massa2:=massa2+li1[i]*tol[i];

// ��� ���� �����. ��� �������� ����������� � �� ������� ��� ���  � ������ �����
//form4.edit1.text:=floattostr(massa);

 sv3:=svs; // �������� �������� �������� ���� - ��� ������������ ������ � ����������� - � ���.
//sv31:=sv1;
svs:=massa; // ������� ��������- ��� ����� !!!





  //*** ��� ���������� ����k� SVS ����� ����� ����������


if sv > svs then // ���� ���� �� �� ����� ������ � ������ �������� ������� �����... ��� ���� ������
 //   if abs(sv-svs)>0.00000000000002 then // ���� ������� ��� � �������� ������� ������ �������� �� ������� ��� ��������� ������� � ������ ��� �������
   begin
// if abs(sv-svs)>0.00000000002 then // �������� �� �������� ����   ����� ������ ������� �������
//   writeln(fr1,'k6=',k6,' Svs=',svs,' L=',l,' H=',h,' k7=', k7);
//   writeln(fr1,k7,' ',svs,' ',h );
     Main_Form.StatusBar1.Panels[1].Text :='(' + FormatFloat('0.##',x1) +' ; '+ FormatFloat('0.##',y1) +') -> ('+ FormatFloat('0.##',Ferm.corn[r,1]) +' ; '+ FormatFloat('0.##',Ferm.corn[r,2]) +')';
     Main_Form.StatusBar1.Panels[0].Text :='V='+FormatFloat('######.#',sv);
     Ferma_Fd_Form.showD(Ferm);
     Repaint;
     Main_form.Refresh;
     Ferma_FD_Form.refresh;
     if fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true then sleep(300); // �������� ��� �������������� ������������� ������������� ������



// ���������� ����� �������� � �������� �������������
   sv:=svs;
   sv21:=sv31;
   sv2:=sv3;// �������� ������ �������� ������� ���� ����� �����������

// ��������� ���� ����� - �� ����� � ������ ��������� �� �� ������� ��� �����
   Click1(Sender);

   //   x:=x1; ���� � ����� ��� �������� - ����� ��� � ���������. ���� ���� ���� ����� �������. ����� � ���� ��  ������ ������
   //   y:=y1;
   deletefile(ff1);// ������� TEMP
   goto m1;
   end
  else
   begin
        deletefile(filename);// ������� �������- � ��� ���������� ��������
        RenameFile( ff1,filename); // ���������� ����� ������ FRM ( �� ����� ����  - ������ TEMP)
   end;

 if k7=4 then // k=4 ?
   begin
//    Main_Form.StatusBar1.Panels[2].Text :='����������� '+inttostr(l)+' ��� ������';
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;

    if l<maxkit2 then // maxkit2 - ���������� ����� ��� ������� �� �������
     begin
     l:=l+1;

     loaddata;
     Ferma_Fd_Form.showD(Ferm);
     Repaint;
     Main_Form.StatusBar1.Panels[2].Text :='����������� �����������...';
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
     Main_form.Refresh  ;
     Ferma_FD_Form.refresh;
     goto m3;   // FERMA 5 !!!!!! ��� ����� ���������  ��� ������ � ����� ������. �������� �� ���� �� ����� ����
     goto m0;
     end
   else goto m3
   end
 else
  begin
   Ferm.corn[r,1]:=x1;//FERMA 4 - ������� ��������� ��������
   Ferm.corn[r,2]:=y1;// FERMA 4
   k7:=k7+1;
   goto m2;
  end;



 m3: // �����   //���������� ����������� ���������

 loaddata;
 Ferma_Fd_Form.showD(Ferm);
 Repaint;
     Main_Form.StatusBar1.Panels[1].Text :=' ';
     Main_Form.StatusBar1.Panels[2].Text :='���������� ����������� ���������';
     //Beep;
     if fermoptmassa.Ferm_opt_massa.CheckBox1.Checked=true then sleep(700); // �������� ��� �������������� ������������� ������������� ������
     screen.Cursor:=crDefault;
     Main_Form.B16.Enabled:=true;
     Main_Form.BitBtn10.Enabled   :=true;
     last_opt_type              :=4;
     //end;

end;





 fn3:=filename + '.bak'; // ������������ ��� ���� �� ����
 deletefile(filename);
 assignfile(ff,fn3);
 rename(ff,filename);
 isChanged             :=true;
 Caption               :=concat('*',real_fname);





// ����� ������ ��� ������������
// ������ � �������
{form3.Grd2.Cells[0,1]:='������� ���';
form3.Grd2.Cells[1,1]:=FormatFloat('0.00000E+00',sv0);
form3.Grd2.Cells[2,1]:=FormatFloat('0.00000E+00',sv2);
form3.Grd2.Cells[0,2]:='����� ���������';}
//form3.Grd2.Cells[1,2]:=FormatFloat('0.00000E+00',massa);
massa:=0; // ����� ��� �����������
//massa2:=0;

// �������� ������ � ����������� �������
  for i:=1 to Ferm.nst1 do
  begin
  fermoptmassaRez.FermOptMassaRez_form.tol2[i]:=tol1[i];
  end;


// �������� ����� ��������� ��� ��������� �����������
  for i:=1 to Ferm.nst1 do
   begin
   massa:=massa+fermoptmassaRez.FermOptMassaRez_form.tol2[i]*
    sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
          (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
        );

   massa2:=massa2+fermoptmassaRez.FermOptMassaRez_form.tol21[i]*
    sqrt(
          (Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])*(Ferm.corn[Ferm.iTopN[i,1],1]-Ferm.corn[Ferm.iTopN[i,2],1])+
          (Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])*(Ferm.corn[Ferm.iTopN[i,1],2]-Ferm.corn[Ferm.iTopN[i,2],2])
        );

   end;
//form3.Grd2.Cells[2,2]:=FormatFloat('0.00000E+00',massa); ���������� �.�. 15.12.07

//form3.Grd2.RowHeights[1]:=20;
//form3.Grd2.RowHeights[2]:=20;
//form3.Grd2.Cells[0,3]:='���� � ';
{ ���������� �.�. 15.12.07 ��������������� ����
for i:=1 to strtoint(Ferm_opt_massa.Edit9.Text) do // ������� ������� ����� ������� ���������������
 begin
 // ������ � �������
  form3.Grd2.Cells[0,i+3]:=inttostr(Ferm_opt_massa.ferma5_kol_uzlov_m1[i]);
  form3.Grd2.Cells[1,i+3]:='(' + FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,1])                  +' ; '+ FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,2])+')';
  form3.Grd2.Cells[2,i+3]:='(' + FormatFloat('0.##',Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[i],1])+' ; '+ FormatFloat('0.##',Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[i],2])+')';

 end;
 ���������� �.�. 15.12.07}

//**** ����� ����������� ����������� �������� �� �������� �
// ������� ����� FermOptMassaRez    ���������� �.�. SAE{
      FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[0,0]:='� ����';
      FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[1,0]:='    �� ����������� ';
      FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[2,0]:='    ����� �����������';

/// ���������� �.�. 15.12.07 {
for i:=1 to strtoint(Ferm_opt_massa.Edit9.Text) do // ������� ������� ����� ������� ���������������
 begin
 // ������ � �������
  FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[0,i]:=inttostr(Ferm_opt_massa.ferma5_kol_uzlov_m1[i]);
  FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[1,i]:='(' + FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,1])                  +' ; '+ FormatFloat('0.##',ferma_5_dannie_o_uzlax_d1[i,2])+')';
  FermOptMassaRez.FermOptMassaRez_form.Coord_Grid.Cells[2,i]:='(' + FormatFloat('0.##',Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[i],1])+' ; '+ FormatFloat('0.##',Ferm.corn[Ferm_opt_massa.ferma5_kol_uzlov_m1[i],2])+')';
end;
// ���������� �.�. 15.12.07 }

// ������ �������
//form3.Ok_Btn.Enabled:=true;
//FermOptMassaRez.FermOptMassaRez_form.Caption:=('���������� ���������� ����������� ��� '  + Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname ); //���������� �.�. 15.12.07

for i:=1 to Ferm.nst1 do
ferm.Fn[i]:=fermoptmassaRez.FermOptMassaRez_form.tol21[i];
ferma_fd_form.ShowD(f);
//ferma_fd_form.
ferma_fd_form.Repaint;


for i:=1 to Ferm.nst1 do
begin
   FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[2,i]:=FormatFloat('0.000e+00',fermoptmassaRez.FermOptMassaRez_form.tol2[i]);
end;
{f Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=false  then
   begin
// ********************************* ���������� ������ �������� �������������� ****************** 3 ������� ����������������
//   FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[3,0]:='  ������ �������';
//   if Mom_in[i] > 0.0 then FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[3,i]:=FormatFloat('0.000e+00',Mom_in[i])
//  else FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[3,i]:='��� ������';
   end
else
  begin
  FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[3,0]:=' ';
  FermOptMassaRez.FermOptMassaRez_form.Areas_Grd.Cells[3,i]:=' ';
  end;
end; }
//// ���������� �.�. 9.12.07 {
if Fermoptmassa.Ferm_opt_massa.RadioButton11.Checked=true  then
   FermOptMassaRez.FermOptMassaRez_form.Label9.Caption:=' ��� ����� ������������ ��������'
else
   FermOptMassaRez.FermOptMassaRez_form.Label9.Caption:=' � ������ ������������ ��������';

FermOptMassaRez.FermOptMassaRez_form.Value_Edt.Text:=FormatFloat('0.000e+00',massa);
FermOptMassaRez.FermOptMassaRez_form.PSV_Edit.Text:=FormatFloat('0.00000E+00',sv2);
FermOptMassaRez.FermOptMassaRez_form.FermWeight_Edt.Text:=FormatFloat('0.00000E+00',sv0);
// ���������� �.�. 9.12.07 }

Flag:=MessageDlg(chr(13)+'���������� ����������� ���������. �������� ����������?' ,mtInformation,[mbYes,mbNo],0);
 if flag=mrNo then
   exit;
 if FileExists(ChangeFileExt(FileName,'.vyf')) then
 begin
 if opt_type[1] = 1 then
  begin
   FermOptMassaRez_form.K_before_Edit.Visible:=false;
   FermOptMassaRez_form.K_after_Edit.Visible:=false;
   FermOptMassaRez_form.K_before_Label.Enabled:=false;
   FermOptMassaRez_form.K_after_Label.Enabled:=false;
   FermOptMassaRez_form.Label9.Visible:=true;
   FermOptMassaRez.FermOptMassaRez_form.Caption:=('���������� ���������� ����������� ��� '  + real_fname );
   FermOptMassaRez_form.show;
 end;
 end;

nn:
 Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);

end;



//*******************************��������������� �������
// ����������� �� FermOptResults  -������ ���������


procedure TFerma_Form.Click1(Sender: TObject);
//procedure m.Button1Click(Sender: TObject);
 label exit2,exit3;
var
fn,ff1:string;
  ff:System.text;
  s,s_lin,s_for:string;
  kst,i,it:integer;
  region_x,region_y:extended;
  pogr,sv,vm,start_value:extended;
  tol:array[1..15] of extended;        // ��������� �������
  tol1:array[1..15] of extended;        // ��������� ������� -��� �����
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
 ITOP: array[1..15,1..2] of integer;                {���O�O��� CTEP�HE�}
 F:    array[1..15] of single;                      {HA�A��H�E ��O�A��}
 COR:  array[1..9,1..2] of single;                  {KOOP��HAT� ���OB}
 {COR:  array[1..9,1..2] of integer;                  {KOOP��HAT� ���OB}
 MS:   array[1..9,1..2] of integer;                 {�AKPE��EH�� ���OB}
 P:    array[1..18,1..3] of single;                 {HA�P��K�}
 NST:integer;                                       {��C�O CTEP�HE� �EPM�}
 NYZ:integer;                                       {��C�O ���OB}
 NY:integer;                                        {��C�O �AKPE��EH��}
 E,pltn:single;                                          {MO���� ��P��OCT�}
 pltnS:string;
 NSN:integer;                                       {��C�O C���AEB HA�P��EH��}
 SD:single;                                         {�O��CKAEMOE HA�P��EH�E}
 N1:integer;                                        {��C�O HE��BECTH�X}
 U:   array[1..18,1..3] of single;                  {�EPEME�EH�� ���OB}
 SIGP:array[1..15,1..3] of single;                  {HA�P��EH�� B CTEP�H�X}
 kgv: single;




begin
// ���������� ������� �������� ���������� �������� (TOL) �� ����� � ��������������� ��������


fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;

//  AssignFile(ff,(ChangeFileExt(fn,'.VYF')));
  ff1:=ChangeFileExt(fn,'.vyf');
 assignfile(ff,Ff1);
  Reset(ff);
  readln(ff);// ���������� ������ ��� �������� ������������� ������
  readln(ff,kst);
  repeat
    readln(ff,s);
  until s='�����������';
  readln(ff,s_lin);
  readln(ff,s_for);
  repeat
    readln(ff,s);
  until s='����� ��������';
  readln(ff,it);
  readln(ff);
  readln(ff,pogr);
  readln(ff);
  readln(ff,sv);
  readln(ff);
  for i:=1 to kst do readln(ff,tol1[i]); // ��� ����� - ����������
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
//*** ��� ���������� ����k� TOL ����� ����� ����������


// *** ��������� � ��� �� ����� ����� ����  *.temp  c ������� ��� ���������
        AssignFile(d1,fn);
        reset(d1);

        ff1:=ChangeFileExt(fn,'');
        ff1:=ff1+'.temp1';

{
   if  fermoptmassa.Ferm_opt_massa.RadioButton1.Checked  then  // ������ ����� ���������������
        ff1:=ff1+'_optB.frm'
   else
        ff1:=ff1+'_optS.frm';

   saveas.FileName:=ff1;
   if saveas.Execute then
     begin
      ff1:=Saveas.FileName;
     goto exit2;
     end;
    closefile(d1);
    goto exit3;

}
exit2:  AssignFile(dd,ff1);
        rewrite(dd);


        READln (d1,NST);
        writeln(dd,nst);
        READln (d1,NYZ);
        writeln(dd,nyz);
        READln (d1,NY);
        writeln(dd,ny);
        READln (d1,E);
        if E<>Ferm.e1 then
          writeln(dd,Ferm.e1)
        else
          writeln(dd,e);
        READln (d1,NSN);
        writeln(dd,nsn);
        READln (d1,SD);
        writeln(dd,SD);
        Readln(d1,pltn);
        //pltn:=SimpleRoundTo(pltn,-4);
        writeln(dd,pltn);
//      writeln(dd);
//      writeln(dd,'������ ��������� ��������');
        for i:=1 to nst do
          begin
          readln(d1,ITOP[i,1]);
          readln(d1,ITOP[i,2]);
          writeln(dd,ITOP[i,1]);
          writeln(dd,ITOP[i,2]);

         end;

  //    writeln(dd);
//      writeln(dd,'������ ��������� �����');
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);
          readln(d1,cor[i,2]);
          writeln(dd,cor[i,1]);
          writeln(dd,cor[i,2]);
         end;

//      writeln(dd);
//      writeln(dd,'������ ��������� ��������'); �������� �� ������� ���������� ����� �����������
// Ferma_SelectMetod.RadioGroup1.ItemIndex
        for i:=1 to nst do
      begin
           readln(d1,f[i]);
if fermoptmassa.Ferm_opt_massa.RadioButton11.Checked  then // ��� �������� �� �� ���� �������� - � ������ ������ ��� ��� ����
        begin
// ��� ������ �����, ������ ���� �������� � ������������ � ������� �������� ��������� ���������- �� ���� ��������� � ��������� ��������� � ���� ������ ��������� �� �������� �����.

//             if (( round(tol1[i]*1000) )*10e-4) >= 0.001 then // �������� ��� ���������� �� ����������� ��������- ����� �� �������� �������� � �� �������� 0 ������ ������ �����
//              tol1[i]:= ( round(tol1[i]*1000) )*10e-4;// ���� ��� ����� ������ - �� ���� ���������

              writeln(dd,tol1[i]);// � ������ ��-������ �����  - ���� ���� �� �������� �� ���� �� ���������.
        end
  else
        begin
 //         writeln(dd,tol[i]);
 //            if (( round(tol[i]*1000) )*10e-4) >= 0.001 then // �������� ��� ���������� �� ����������� ��������- ����� �� �������� �������� � �� �������� 0 ������ ������ �����
 //             tol[i]:= ( round(tol[i]*1000) )*10e-4;// ���� ��� ����� ������ - �� ���� ���������

              writeln(dd,tol[i]);// � ������ ��-������ �����  - ���� ���� �� �������� �� ���� �� ���������.
        end;

      end;


//      writeln(dd);
//      writeln(dd,'������ ����������� �����');
        for i:=1 to nyz do
          begin
          readln(d1,ms[i,1]);
          readln(d1,ms[i,2]);
          writeln(dd,ms[i,1]);
          writeln(dd,ms[i,2]);

         end;

//      writeln(dd);
//      writeln(dd,'������ �������� ��������');
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


//*** ������ ���� ���� ������� FRM<->TEMP
        closefile(d1); // .frm
        closefile(dd); //ff1 .temp
        deletefile(fn);
        renamefile(ff1,fn);// FRM<-TEMP

exit3:
end;





///***************************************************************************


Procedure TFerma_Form.LoadOtrData;
var
        fff: textfile;
        i,j,k:integer;
        koef_x,koef_y:integer;
        s:string;
begin
        if Main.Main_Form.OtrOpenDialog.Execute then
        begin
                assignFile(fff,Main.Main_Form.OtrOpenDialog.FileName);
                reset(fff);
                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        readln(fff,s);
                        m2opt[i,j].x:=StrToInt(s);
                        readln(fff,s);
                        m2opt[i,j].y:=StrToInt(s);
                end;

                //��������� ���������� � ������������ � ��������
                readln(fff,s);
                kz1:=StrToInt(s);
                for i:=1 to kz1 do
                begin
                        readln(fff,s);
                        zak1[1,i]:=StrToInt(s);
                        readln(fff,s);
                        zak1[2,i]:=StrToInt(s);
                end;
                for i:=1 to kz1 do
                begin
                        readln(fff,s);
                        zak2[1,i]:=StrToInt(s);
                        readln(fff,s);
                        zak2[2,i]:=StrToInt(s);
                end;
                readln(fff,s);
                reg_X:=StrToInt(s);
                readln(fff,s);
                reg_Y:=StrToInt(s);

                //��������� ���������� � ����������� � ��������
                readln(fff,s);
                kl1:=StrToInt(s);
                for i:=1 to kl1 do
                begin
                        readln(fff,s);
                        frc1[1,i]:=StrToInt(s);
                        readln(fff,s);
                        frc1[2,i]:=StrToInt(s);
                end;
                for i:=1 to kl1 do
                begin
                        readln(fff,s);
                        frc2[1,i]:=StrToInt(s);
                        readln(fff,s);
                        frc2[2,i]:=StrToInt(s);
                end;

                closeFile(fff);
                paintbox.Canvas.Pen.Color:=clRed;
                paintbox.Canvas.Pen.Width:=2;
                formpaint(self);
        end;
end;


Procedure TFerma_Form.OtrPaint;
var
        i,j,k:integer;
        mas_x,mas_y:real;
        flag_draw:array[1..9,1..4] of Integer;

begin
        if (ferm<>nil) then
        begin

                if not((reg_x=0)or(reg_y=0)) then
                begin
                        Ferm.region_X:=Reg_x;
                        Ferm.region_Y:=Reg_y;
                end;

                mas_x:=(PaintBox.Width-110)/Ferm.region_X;
                mas_y:=(PaintBox.Height-75)/Ferm.region_Y;

                with paintbox.Canvas do
                begin
                        pen.Width:=1;
                        pen.Style:=psDot;
                        pen.Color:=clBlack;
                        brush.Color:=clScrollBar;
                        //������ ������� �����
                        for j:=1 to n_napr*n_nagr*n_otr do
                        begin
                                if not((m2opt[1,j].X=0) and (m2opt[1,j].Y=0) and (m2opt[2,j].X=0) and (m2opt[2,j].Y=0)) then
                                begin
                                        moveTo(round(80+mas_x*m2opt[1,j].X),round(30+mas_y*m2opt[1,j].Y));
                                        lineTo(round(80+mas_x*m2opt[2,j].X),round(30+mas_y*m2opt[2,j].Y));
                                end;
                        end;


                        //������ ����������� (from plast)
                        pen.Style:=psSolid;

                        for i:=1 to kz1 do
                        begin
                                if (zak2[1,i]=1) and (zak2[2,i]=1) then
                                begin
                                        MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i]));
                                        LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])-4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+10);

                                        MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i]));
                                        LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])+4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+10);

                                        MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])-8,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+10);
                                        LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])+8,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+10);

                                        Ellipse(coord_axis_X+50+round(mas_x*zak1[1,i])-3,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-3,coord_axis_X+50+round(mas_x*zak1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+5);

                                        for j:=-2 to 2 do
                                        begin
                                                MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])+j*4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+10);
                                                LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])+j*4-2,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+15);
                                        end;
                                end;

                                if (zak2[1,i]=1) and (zak2[2,i]=0) then
                                begin
                                        MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])-4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-8);
                                        LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])-4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+8);
                                        Ellipse(coord_axis_X+50+round(mas_x*zak1[1,i])-3,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-3,coord_axis_X+50+round(mas_x*zak1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+5);
                                        for j:=-2 to 2 do
                                        begin
                                                MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])-4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-j*4);
                                                LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])-9,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-j*4+2);
                                        end;
                                end;

                                if (zak2[1,i]=0) and (zak2[2,i]=1) then
                                begin
                                        MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])-8,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+4);
                                        LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])+8,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+4);
                                        Ellipse(coord_axis_X+50+round(mas_x*zak1[1,i])-3,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])-3,coord_axis_X+50+round(mas_x*zak1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+5);
                                        for j:=-2 to 2 do
                                        begin
                                                MoveTo(coord_axis_X+50+round(mas_x*zak1[1,i])+j*4,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+4);
                                                LineTo(coord_axis_X+50+round(mas_x*zak1[1,i])+j*4-2,PaintBox.Height-30-coord_axis_Y-round(mas_y*zak1[2,i])+9);
                                        end;
                                end;
                        end;


                        //������ �������� (from plast)

                        for i:=1 to kl1 do
                        begin
                                if frc2[1,i]<=0 then
                                begin
                                        flag_draw[i,1]:=0;
                                        flag_draw[i,2]:=0;
                                        if frc2[1,i]<0 then
                                        begin
                                                flag_draw[i,1]:=1;
                                                flag_draw[i,2]:=-15;
                                        end
                                end
                                else begin
                                        flag_draw[i,1]:=1;
                                        flag_draw[i,2]:=15;
                                end;
                                if frc2[2,i]<=0 then
                                begin
                                        flag_draw[i,3]:=0;
                                        flag_draw[i,4]:=0;
                                        if frc2[2,i]<0 then
                                        begin
                                                flag_draw[i,3]:=1;
                                                flag_draw[i,4]:=-15;
                                        end
                                end
                                else begin
                                        flag_draw[i,3]:=1;
                                        flag_draw[i,4]:=15;
                                end;
                        end;

                        for i:=1 to kl1 do
                        begin
                        if flag_draw[i,1]=1 then
                        begin
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]));
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i])+flag_draw[i,2],PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]));
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i])+flag_draw[i,2],PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]));
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i])+flag_draw[i,2]-flag_draw[i,2] div 2,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]+5));
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i])+flag_draw[i,2],PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]));
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i])+flag_draw[i,2]-flag_draw[i,2] div 2,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]-5));
                                Ellipse(coord_axis_X+50+round(mas_x*frc1[1,i])-3,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-3,coord_axis_X+50+round(mas_x*frc1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])+5);
                        end;
                        if flag_draw[i,3]=1 then
                        begin
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i]));
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-flag_draw[i,4]);
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-flag_draw[i,4]);
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-flag_draw[i,4]+flag_draw[i,4] div 2);
                                MoveTo(coord_axis_X+50+round(mas_x*frc1[1,i]),PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-flag_draw[i,4]);
                                LineTo(coord_axis_X+50+round(mas_x*frc1[1,i])-5,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-flag_draw[i,4]+flag_draw[i,4] div 2);
                                Ellipse(coord_axis_X+50+round(mas_x*frc1[1,i])-3,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])-3,coord_axis_X+50+round(mas_x*frc1[1,i])+5,PaintBox.Height-30-coord_axis_Y-round(mas_y*frc1[2,i])+5);
                        end;
                end;
          end;
     end;
end;




procedure TFerma_Form.ItemClick(Sender: TObject);
 var ff:system.text;
     str:string;
 begin
       if not fileexists(ChangeFileExt(filename,(Sender as TMenuItem).hint)) then
       MessageDlg('���� � ������������ ������ �� ������', mtInformation,
      [mbOk], 0)
         else
           begin
             assignfile(ff,ChangeFileExt(filename,(Sender as TMenuItem).hint));
             reset(ff);
             readln(ff,str);
             closefile(ff);
             if str<>DateTimeToStr(FileDateToDateTime(FileAge(filename))) then
             MessageDlg('������������ ������ ������ � ������ � ����������� �����������', mtError,[mbOk], 0)
             else NewFermOptResults_Form.Execute(ChangeFileExt(filename,(Sender as TMenuItem).hint))
           end;
 end;

procedure TFerma_Form.Old_sizeClick(Sender: TObject);
begin
     ClientWidth:=w_old;
     Clientheight:=h_old;

end;

// ����������� ������� ���� ��� ������ ����������� ������� ---------------------
procedure TFerma_Form.MouseLeft;
begin
 Repaint;
 Canvas.CopyRect(Rect(0,0,fFormBMP.Width,fFormBMP.Height),
  fFormBMP.Canvas,Rect(0,0,fFormBMP.Width,fFormBMP.Height));
end;


procedure TFerma_Form.MouseIsDown(MX,MY: Integer);
begin
 fMDown:=True;
 fMouseX1:=MX;
 fMouseY1:=MY;
 Canvas.Pen.Color:=clBlue;
 MouseLeft;
end;

procedure TFerma_Form.MouseIsMove(MX,MY: Integer);
begin
 if fMDown then
  begin
   Repaint;
   with Canvas do
    begin
     CopyRect(Rect(0,0,fFormBMP.Width,fFormBMP.Height),
      fFormBMP.Canvas,Rect(0,0,fFormBMP.Width,fFormBMP.Height));
     MoveTo(fMouseX1,fMouseY1);
     LineTo(MX,fMouseY1);
     LineTo(MX,MY);
     LineTo(fMouseX1,MY);
     LineTo(fMouseX1,fMouseY1);
    end;
  end;
end;

procedure TFerma_Form.MouseIsUp(MX,MY: Integer);
var
 Temp: Integer;
begin
 fMDown:=False;
 fMouseX2:=MX;
 fMouseY2:=MY;
 if fMouseX2<fMouseX1 then
  begin
   Temp:=fMouseX1;
   fMouseX1:=fMouseX2;
   fMouseX2:=Temp;
  end;
 if fMouseY2<fMouseY1 then
  begin
   Temp:=fMouseY1;
   fMouseY1:=fMouseY2;
   fMouseY2:=Temp;
  end;
 if (fMouseX1<>fMouseX2) or (fMouseY1<>fMouseY2) then fSelectionIsOK:=True
 else fSelectionIsOK:=False;
end;


// ���������� ������������ ������ ����������� �������� -------------------------
procedure TFerma_Form.SelectionMode(Activate: Boolean);
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
      fASize:=True;
     end
    else
     fASize:=False;
   BMP:=TBitmap.Create;
   BMP.Width:=ClientWidth;
   BMP.Height:=ClientHeight;
   fFormBMP.Width:=BMP.Width;
   fFormBMP.Height:=BMP.Height;
   BMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   SetLength(fControlsArray,ControlCount);
   for i:=0 to ControlCount-1 do
    begin
     if Controls[i].Visible then
      begin
       Controls[i].Visible:=False;
       fControlsArray[i]:=True;
      end
     else fControlsArray[i]:=False;
    end;
   fFSize[0]:=Width;
   fFSize[1]:=Height;
   fBStyle:=BorderStyle;
   BorderStyle:=bsSingle;
   fBIcons:=BorderIcons;
   BorderIcons:=[biSystemMenu];
   Width:=fFSize[0];
   Height:=fFSize[1];
   Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   fFormBMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   BMP.Free;
   PopupMenu:=Real_Coord_PUM;
  end
// ��� �� ���� ���������:
 else
  begin
   for i:=0 to ControlCount-1 do
    begin
     if fControlsArray[i]=True then
      begin
       Controls[i].Visible:=True;
      end;
    end;
   Repaint;
   fFormBMP.Width:=0;
   fFormBMP.Height:=0;
   SetLength(fControlsArray,0);
   fFSize[0]:=Width;
   fFSize[1]:=Height;
   BorderStyle:=fBStyle;
   BorderIcons:=fBIcons;
   Width:=fFSize[0];
   Height:=fFSize[1];
    if fASize then
     begin
      AutoSize:=True;
      fASize:=False;
     end;
   PopupMenu:=nil;
  end;
end;

// ������� � ����� -------------------------------------------------------------
procedure TFerma_Form.PutToAccount;
var
 OleFileName,OleUnit,OleExtend: OleVariant;
 Bmp: TBitmap;
begin
 Bmp:=TBitmap.Create;

 Bmp.Canvas.CopyMode:=cmSrcCopy;
 if fSelectionIsOK then
  begin
   Bmp.Width:=fMouseX2-fMouseX1;
   Bmp.Height:=fMouseY2-fMouseY1;
   Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
    fFormBMP.Canvas,Rect(fMouseX1+1,fMouseY1+1,fMouseX2,fMouseY2));
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

 fSelectionIsCopied:=True;
 fSelectionIsOK:=False;

 Repaint;
end;


// ���������� ������� ----------------------------------------------------------
procedure TFerma_Form.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (fSelection) and (Button=mbRight) then
  MouseIsDown(X,Y);
 if (fSelection) and (Button=mbLeft) then
  MouseLeft;
end;

procedure TFerma_Form.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 if fSelection then
  MouseIsMove(X,Y);
end;

procedure TFerma_Form.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (fSelection) and (Button=mbRight) then
  MouseIsUp(X,Y);
end;

procedure TFerma_Form.N17Click(Sender: TObject);
begin
 if not N17.Checked then
  begin
   fSelection:=True;
   SelectionMode(True);
   N17.Checked:=True;
   real_size.Enabled:=False;
  end
 else
  begin
   fSelection:=False;
   SelectionMode(False);
   N17.Checked:=False;
   real_size.Enabled:=True;
  end;
end;

procedure TFerma_Form.PrepareForModule;
var
 AFromDir, AToDir: string; //������ � ������� ��� �����������
 FSearchRec,DSearchRec: TSearchRec;
 FindResult: Integer;
begin
try
 AFromDir:=ExtractFilePath(FileName)+'*.*';
 AToDir:=ExtractFilePath(Application.ExeName)+'Modules\CurFerma\';

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
     AToDir+'CurFerma'+ExtractFileExt(AToDir+FSearchRec.Name));
    FindResult:=FindNext(FSearchRec);
   end;
 finally
  FindClose(FSearchRec);
 end;
 Application.MessageBox('������ ������������!','�������� ���������');
  if Main_Form.N17.Checked then
   begin
    FilesList_Form.Caption:='������ ������ ��������, ��������: "'+Copy(Caption,0,Length(Caption)-4)+'"';
    FilesList_Form.FileListBox1.ApplyFilePath(ExtractFilePath(Application.ExeName)+'Modules\CurFerma\');
    FilesList_Form.Show;
   end;
except
 Application.MessageBox('��������� ����������� ������!','������');
end;
end;


procedure TFerma_Form.CopyDirectoryTree(AHandle: HWND;
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




procedure TFerma_Form.MenuItem2Click(Sender: TObject);
begin
PutToAccount;
end;

procedure TFerma_Form.N10Click(Sender: TObject);
begin
Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResultsVC1_MnuClick(Sender);
end;

procedure TFerma_Form.N14Click(Sender: TObject);
var
temps: string;
begin
if IsNamed then begin
if MessageDlg('�� �������? ������ ����� ����� ������������!!!', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
begin
temps := FilePath;
DeleteFile(temps);

temps[length(temps)-2]:='v';
temps[length(temps)-1]:='y';
temps[length(temps)]:='v';


if FileExists(temps) then
Deletefile(temps);

temps[length(temps)-2]:='v';
temps[length(temps)-1]:='y';
temps[length(temps)]:='f';

if FileExists(temps) then
Deletefile(temps);

close;

end;
end;
end;
procedure TFerma_Form.N18Click(Sender: TObject);
begin

Buf.prev;
Ferm.Assign(Buf.Current^.F);
ferma_FD_form.showD(Ferm);
Repaint;

end;

procedure TFerma_Form.N19Click(Sender: TObject);
begin

Buf.next;
Ferm.Assign(Buf.Current^.F);
ferma_FD_form.showD(Ferm);
Repaint;

end;

procedure TFerma_Form.MenuItem1Click(Sender: TObject);
begin
ClientWidth :=CW;
ClientHeight:=CH;
If Top < 0 then Top := 0;
If Left < 0 then Left := 0;
WindowState := wsNormal;
end;

procedure TFerma_Form.ChangeTOKClick(Sender: TObject);
begin
  Main_Form.WithTOK.Checked:=true;
          Main_Form.TOK_OK_PMI.Checked        :=true;
          Main_Form.TOK_NO_PMI.Checked        :=false;

     if Main_Form.TOK_OpenDialog.Execute then
       begin
      if (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.out')or
         (ExtractFileExt(Main_Form.TOK_OpenDialog.FileName)='.oup')then
        begin

        end;
       end;
end;

procedure TFerma_Form.SaveFile(FName:string);
var
     ff: System.Text;
     i,j:Integer;
begin
     AssignFile(ff,FName);
     rewrite(ff);
     writeln(ff,Ferm.nst1);
     writeln(ff,Ferm.nyz1);
     writeln(ff,Ferm.ny1);
     writeln(ff,Ferm.e1);
     writeln(ff,Ferm.nsn1);
     writeln(ff,Ferm.sd1);
     Writeln(ff,Ferm.pltn);
     for i:=1 to Ferm.nst1 do
     begin
          writeln(ff,Ferm.ITOPn[i,1]);
          writeln(ff,Ferm.ITOPn[i,2]);
     end;
     for i:=1 to Ferm.nyz1 do
     begin
          writeln(ff,Ferm.corn[i,1]); writeln(ff,Ferm.corn[i,2]);
     end;
     for i:=1 to Ferm.nst1 do writeln(ff,Ferm.Fn[i]);
     for i:=1 to Ferm.nyz1 do
     begin
          if Ferm.msn[i,1]=1 then writeln(ff,0)
          else writeln(ff,1);
          if Ferm.msn[i,2]=1 then writeln(ff,0)
          else writeln(ff,1);
     end;
     for i:=1 to Ferm.nsn1 do
          for j:=1 to Ferm.nyz1*2 do  writeln(ff,Ferm.pn[j,i]);
     writeln(ff,Ferm.s_lin);
     writeln(ff,Ferm.s_for);
     writeln(ff,Ferm.region_x);
     writeln(ff,Ferm.region_y);

     CloseFile(ff);
end;
procedure TFerma_Form.FileVersionCheck(Sender: TObject);
var
   FileName:string;
   Version_VYV,tmp:string;
   f1:System.Text;
   ff:File of Byte;
   mg:integer;

   begin
   FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
   Delete(FileName,Pos('_tmp',FileName),4);
   // �������� �� ������������� ����� �������
   if FileExists(ChangeFileExt(FileName,'.vyv')) then
   begin
      AssignFile(f1,ChangeFileExt(FileName,'.vyv'));
      reset(f1);
      readln(f1,Version_VYV);
      CloseFile(f1);
   end
   else Version_VYV:='Error';

   if Version_VYV='Error' then
     exit;

   // �������� �� ������������� ������ ������ ������ � �������� ��������
   if FileExists(FileName) then
   begin
      AssignFile(ff,FileName);
      reset(ff);
      mg:=filesize(ff);
      CloseFile(ff);
   end
   else
      exit;

   tmp:=(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))));
   if ((Version_VYV)<>(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName)))))
       or (Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged=TRUE) then
   begin
     deletefile(changefileext(FileName,'.vyv'));
     deletefile(changefileext(FileName,'.smp'));
     exit;
   end;
end;
procedure TFerma_Form.HighLightPivot(Sender:  TObject; PivNum: Integer);
var
  x1,x2,y1,y2,x_max,y_max: Integer;
  max_x_coord,max_y_coord,mas_x,mas_y:extended;
  begin
    PaintBox.Canvas.pen.Mode  :=pmNotXor;
    PaintBox.Canvas.pen.Color :=clBlue;
    PaintBox.Canvas.pen.Width :=3;
    begin
       x_max:=PaintBox.Width;
       y_max:=PaintBox.height;
       mas_x:=(x_max-80-coord_axis_X)/max_x_coord; //�������������� ������������
       mas_y:=(y_max-60-coord_axis_Y)/max_y_coord;
       x1   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[PivNum,1],1]);
       y1   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[PivNum,1],2]);
       x2   :=50+coord_axis_X+round(mas_x*Ferm.corn[Ferm.ITOPn[PivNum,2],1]);
       y2   :=y_max-30-coord_axis_Y-round(mas_y*Ferm.corn[Ferm.ITOPn[PivNum,2],2]);
       PaintBox.Canvas.MoveTo(x1, y1);
       PaintBox.Canvas.LineTo(x2, y2);
    end;
  end;

end.



