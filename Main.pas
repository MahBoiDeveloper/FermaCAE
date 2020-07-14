unit Main;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   Menus, ComCtrls, ToolWin, ExtCtrls, StdCtrls, ImgList, Registry, IdGlobal,
   OleServer, IniFiles, WordXP, Variants, Clipbrd, Buffer, Word2000, StrUtils,
  Buttons, AppEvnts, ActnMan, ActnCtrls, ActnMenus, StdStyleActnCtrls,
  ActnList;

  //const
 // Dev_Height: Integer  = 1024;  // Высота экрана разработчика в пикселях
// Dev_Width:  Integer   = 1280;  // Ширина экрана разработчика в пикселях

type
   TMaterial = record
      MName:    string;
      MModUpr:  extended;
      MDopNapr: extended;
      MKoffPuas:extended;
      MPlotn:extended;
   end;
   TMain_Form = class(TForm)
            StatusBar1: TStatusBar;
            OpenDialog: TOpenDialog;
            MainToolBar_IL: TImageList;
            FermToolBar_IL: TImageList;
            New_PMnu: TPopupMenu;
            New_Btn_PU_Ferma: TMenuItem;
            New_Btn_PU_Plast: TMenuItem;
            PlastToolBar_IL: TImageList;
            Ferma_Graph_Enter_IL: TImageList;
            TOKToolBar_IL: TImageList;
            Plast_Graph_Enter_IL: TImageList;
            TOK_Graph_Enter_IL: TImageList;
            TOK_PM: TPopupMenu;
            TOK_NO_PMI: TMenuItem;
            TOK_OK_PMI: TMenuItem;
            TOK_OpenDialog: TOpenDialog;
            SimpleSolve_List: TPopupMenu;
            Opt_solve_list: TPopupMenu;
            Plast_SimpReztext: TMenuItem;
            N8: TMenuItem;
            SimpleSolve_eq: TMenuItem;
            SimpleSolve_X: TMenuItem;
            SimpleSolve_Y: TMenuItem;
            SimpleSolve_Kas: TMenuItem;
            Plast_OptRezText: TMenuItem;
            N7: TMenuItem;
            Plast_TolRezGraph: TMenuItem;
            New_Btn_PU_TOK: TMenuItem;
            F_new_pmnu: TPopupMenu;
            f_New_Btn_PU_Ferma: TMenuItem;
            f_New_Btn_PU_TOK: TMenuItem;
            f_New_Btn_PU_Plast: TMenuItem;
            p_new_pmnu: TPopupMenu;
            p_New_Btn_PU_Ferma: TMenuItem;
            p_New_Btn_PU_TOK: TMenuItem;
            p_New_Btn_PU_Plast: TMenuItem;
            t_new_pmnu: TPopupMenu;
            t_New_Btn_PU_Ferma: TMenuItem;
            t_New_Btn_PU_TOK: TMenuItem;
            t_New_Btn_PU_Plast: TMenuItem;
            Timer1: TTimer;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    OtrOpenDialog: TOpenDialog;
    OpenDialog1: TOpenDialog;
    WordApplication1: TWordApplication;
    PopupMenu2: TPopupMenu;
    N15: TMenuItem;
    N16: TMenuItem;
    PopupMenu3: TPopupMenu;
    N17: TMenuItem;
    N18: TMenuItem;
    N21: TMenuItem;
    Ferma_Panel: TPageControl;
    Project: TTabSheet;
    GroupBox2: TGroupBox;
    BitBtn4: TBitBtn;
    Save_TBtn: TBitBtn;
    SaveAs: TBitBtn;
    GroupBox3: TGroupBox;
    TubeOpen: TBitBtn;
    OpenFolder: TBitBtn;
    Help: TBitBtn;
    View: TTabSheet;
    GridBox: TGroupBox;
    GridLabelY: TLabel;
    GridLabelX: TLabel;
    FermaGridButton: TCheckBox;
    FermaGridSizeY: TEdit;
    FermaGridIncY: TUpDown;
    FermaGridSizeX: TEdit;
    FermaGridIncX: TUpDown;
    GroupBox4: TGroupBox;
    RulerLabelY: TLabel;
    RulerLabelX: TLabel;
    FermaRulerButton: TCheckBox;
    FermaRulerSizeY: TEdit;
    FermaRulerIncY: TUpDown;
    FermaRulerSizeX: TEdit;
    FermaRulerIncX: TUpDown;
    GroupBox5: TGroupBox;
    NodesNum: TCheckBox;
    SticksNum: TCheckBox;
    Misc: TGroupBox;
    ConstructorShow: TCheckBox;
    PanelConstruction: TCheckBox;
    CalculateF: TTabSheet;
    GroupBox6: TGroupBox;
    BitBtn5: TBitBtn;
    SimpleResult_TB: TBitBtn;
    ToolButton7: TBitBtn;
    WithTOK: TCheckBox;
    GroupBox7: TGroupBox;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    GroupBox8: TGroupBox;
    BitBtn12: TBitBtn;
    B13: TBitBtn;
    GroupBox9: TGroupBox;
    BitBtn15: TBitBtn;
    B16: TBitBtn;
    SelectTOK: TButton;
    CalculateP: TTabSheet;
    GroupBox11: TGroupBox;
    P1: TBitBtn;
    P2: TBitBtn;
    P3: TBitBtn;
    GroupBox12: TGroupBox;
    P4: TBitBtn;
    P5: TBitBtn;
    P6: TBitBtn;
    P7: TButton;
    CalculateT: TTabSheet;
    GroupBox13: TGroupBox;
    T1: TBitBtn;
    T2: TBitBtn;
    BitBtn6: TBitBtn;
    Ferma_Dock: TToolBar;
    ApplicationEvents1: TApplicationEvents;
    Tok_Dock: TToolBar;
    Ferma_Graph_Enter_Panel: TToolBar;
    None_ToolButton: TToolButton;
    ToolButton5: TToolButton;
    DrawPivot_ToolButton: TToolButton;
    DeletePivot_ToolButton: TToolButton;
    DeletePivot12_ToolButton: TToolButton;
    ToolButton4: TToolButton;
    Node_ToolButton: TToolButton;
    NodeDelete_ToolButton: TToolButton;
    ToolButton8: TToolButton;
    Coord_ToolButton: TToolButton;
    Zak_ToolButton: TToolButton;
    Nagr_ToolButton: TToolButton;
    PivotTol_ToolButton: TToolButton;
    Node_Move_ToolButton: TToolButton;
    ToolButton12: TToolButton;
    ToolButton10: TToolButton;
    Size_ToolButton: TToolButton;
    ToolButton33: TToolButton;
    LoadOtr: TToolButton;
    Plast_Dock: TToolBar;
    TOK_Graph_Enter_Panel: TToolBar;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    tok_Zakr_ToolButton: TToolButton;
    tok_Zad_ToolButton: TToolButton;
    tok_Nagr_ToolButton: TToolButton;
    ToolButton27: TToolButton;
    Tok_Inform_Toolbutton: TToolButton;
    ToolButton31: TToolButton;
    Tok_Size_ToolButton: TToolButton;
    SX: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Knum: TCheckBox;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    Back: TBitBtn;
    Windows_Mnu: TTabSheet;
    GroupBox10: TGroupBox;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn11: TBitBtn;
    ListBox1: TComboBox;
    UpDown2: TUpDown;
    PanelTop: TEdit;
    Plast_Graph_Enter_Panel: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Cut_Plast_Toolbutton: TToolButton;
    Del_Cut_Plast_Toolbutton: TToolButton;
    ToolButton28: TToolButton;
    Plast_Zakr_ToolButton: TToolButton;
    Plast_Nagr_ToolButton: TToolButton;
    ToolButton30: TToolButton;
    Inform_Toolbutton: TToolButton;
    ToolButton32: TToolButton;
    plast_Size_ToolButton: TToolButton;
    BitBtn13: TBitBtn;
    Sn_CBx: TComboBox;
    HideMenu: TBitBtn;
            procedure About1Click(Sender: TObject);
            procedure Exit1Click(Sender: TObject);
            procedure Open1Click(Sender: TObject);
            procedure NewFerma_MnuClick(Sender: TObject);
            procedure Sn_CBxChange(Sender: TObject);
            procedure Open_TBtnClick(Sender: TObject);
            procedure Save_TBtnClick(Sender: TObject);
            procedure NewPlast_MnuClick(Sender: TObject);
            procedure FormCreate(Sender: TObject);
            procedure DrawPivot_ToolButtonClick(Sender: TObject);
            procedure None_ToolButtonClick(Sender: TObject);
            procedure Coord_ToolButtonClick(Sender: TObject);
            procedure ToolButton10Click(Sender: TObject);
            procedure Node_ToolButtonClick(Sender: TObject);
            procedure PlastGraphButtonClick(Sender: TObject);
            procedure FormClose(Sender: TObject; var Action: TCloseAction);
            procedure FormShow(Sender: TObject);
            procedure NodeDelete_ToolButtonClick(Sender: TObject);
            procedure Size_ToolButtonClick(Sender: TObject);
            procedure TOK_NO_PMIClick(Sender: TObject);
            procedure TOK_OK_PMIClick(Sender: TObject);
            procedure DeletePivot_ToolButtonClick(Sender: TObject);
            procedure PivotTol_ToolButtonClick(Sender: TObject);
            procedure DeletePivot12_ToolButtonClick(Sender: TObject);
            procedure N5Click(Sender: TObject);
            procedure ToolButton17Click(Sender: TObject);
            procedure ToolButton18Click(Sender: TObject);
            procedure SimpleResult_TBClick(Sender: TObject);
            procedure ToolButton21Click(Sender: TObject);
            procedure ToolButton7Click(Sender: TObject);
            procedure FormResize(Sender: TObject);
            procedure ContentsClick(Sender: TObject);
            procedure PlastNumberButtonClick(Sender: TObject);
            procedure Plast_SN_CbxChange(Sender: TObject);
            procedure tok_sn_cbxChange(Sender: TObject);
            procedure Cut_Plast_ToolbuttonClick(Sender: TObject);
            procedure Del_Cut_Plast_ToolbuttonClick(Sender: TObject);
            procedure Plast_Zakr_ToolButtonClick(Sender: TObject);
            procedure Inform_ToolbuttonClick(Sender: TObject);
            procedure plast_Size_ToolButtonClick(Sender: TObject);
            procedure NewTOK_MnuClick(Sender: TObject);
            procedure TokGraphButtonClick(Sender: TObject);
            procedure SimpleSolveClick(Sender: TObject);
            procedure ToolButton25Click(Sender: TObject);
            procedure Plast_SimpReztextClick(Sender: TObject);
            //procedure SimpleSolve_eqClick(Sender: TObject);
            //procedure SimpleSolve_XClick(Sender: TObject);
            //procedure SimpleSolve_YClick(Sender: TObject);
            //procedure SimpleSolve_KasClick(Sender: TObject);
            procedure Plast_OptRezTextClick(Sender: TObject);
            procedure Plast_TolRezGraphClick(Sender: TObject);
            procedure TokNumberButtonClick(Sender: TObject);
            procedure SimpleRez_textClick(Sender: TObject);
            procedure SimpleRez_grafClick(Sender: TObject);
            procedure OptRez_textClick(Sender: TObject);
            procedure OptRez_grafClick(Sender: TObject);
            procedure Tok_Size_ToolButtonClick(Sender: TObject);
            procedure tok_Zakr_ToolButtonClick(Sender: TObject);
            procedure ToolButton3Click(Sender: TObject);
            procedure ToolButton1Click(Sender: TObject);
            procedure toksolve_btnClick(Sender: TObject);
            procedure tokrez_btnClick(Sender: TObject);
            procedure Tok_Inform_ToolbuttonClick(Sender: TObject);
            procedure Nagr_ToolButtonClick(Sender: TObject);
            procedure Zak_ToolButtonClick(Sender: TObject);
            procedure Plast_Nagr_ToolButtonClick(Sender: TObject);
            procedure tok_Nagr_ToolButtonClick(Sender: TObject);
            procedure tok_Zad_ToolButtonClick(Sender: TObject);
            procedure FormActivate(Sender: TObject);
            procedure Timer1Timer(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure ToolButton33Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure LoadOtrClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure ToolButton35Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure ToolButton37Click(Sender: TObject);
    procedure ToolButton42Click(Sender: TObject);
    procedure ToolButton38Click(Sender: TObject);
    procedure ToolButton43Click(Sender: TObject);
    procedure ToolButton41Click(Sender: TObject);
    procedure PutToAccount(Form: TForm);
    procedure MouseLeft(Form: TForm);
    procedure MouseIsDown(Form: TForm; MX,MY: Integer);
    procedure MouseIsMove(Form: TForm; MX,MY: Integer);
    procedure MouseIsUp(Form: TForm; MX,MY: Integer);
    procedure SelectionMode(Form: TForm; Activate: Boolean);
    procedure N9Click(Sender: TObject);
    procedure LoadProfileClick(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure ModuleExecuteClick(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure Node_Move_ToolButtonClick(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure Sort(Sender: TObject);
    procedure FermaGridButtonClick(Sender: TObject);
    procedure TubeOpenClick(Sender: TObject);
    procedure OpenFolderClick(Sender: TObject);
    procedure SaveAsClick(Sender: TObject);
    procedure ConstructorShowClick(Sender: TObject);
    procedure PanelConstructionClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure SimpleClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure B13Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure B16Click(Sender: TObject);
{    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject); }
    procedure SelectTOKClick(Sender: TObject);
    procedure B4Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure P2Click(Sender: TObject);
    procedure P3Click(Sender: TObject);
    procedure P4Click(Sender: TObject);
    procedure P5Click(Sender: TObject);
    procedure P6Click(Sender: TObject);
    procedure P7Click(Sender: TObject);
    procedure T1Click(Sender: TObject);
    procedure T2Click(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure bbbClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure TOK_Graph_Enter_PanelStartDock(Sender: TObject;
      var DragObject: TDragDockObject);
    procedure Tok_DockUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure TOK_Graph_Enter_PanelEndDock(Sender, Target: TObject; X,
      Y: Integer);
    procedure Ferma_Graph_Enter_PanelEndDock(Sender, Target: TObject; X,
      Y: Integer);
    procedure Ferma_Graph_Enter_PanelStartDock(Sender: TObject;
      var DragObject: TDragDockObject);
    procedure Ferma_DockUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure Plast_Graph_Enter_PanelEndDock(Sender, Target: TObject; X,
      Y: Integer);
    procedure Plast_Graph_Enter_PanelStartDock(Sender: TObject;
      var DragObject: TDragDockObject);
    procedure Plast_DockUnDock(Sender: TObject; Client: TControl;
      NewTarget: TWinControl; var Allow: Boolean);
    procedure WithTOKClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure ListBox1Change(Sender: TObject);
    procedure PanelTopChange(Sender: TObject);
    procedure Ferma_PanelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure HideMenuClick(Sender: TObject);
    procedure Ferma_PanelChange(Sender: TObject);

    // Едокимова Е.А. начало
    protected
      procedure WMDropFiles(var Message:TMessage); message WM_DROPFILES;
    private
      FOnDropFiles:TNotifyEvent;
      FDrop:THandle;
      procedure DoDropFiles(Sender:TObject);
      { Private declarations }
    public
      { Public declarations }
     property Drop:THandle read FDrop write FDrop;
     property OnDropFiles:TNotifyEvent read FOnDropFiles write FOnDropFiles;
     // Едокимова Е.А. конец


         private
           {procedure WM_HotKeyHandler (var Message: TMessage);
           message WM_HOTKEY;} // commented by Берсенёва М.


            { Private declarations }
         public
            { Public declarations }
            User_Height: integer;  //  Высота экрана пользователя в пикселях
            User_Width:  integer;  //  Ширина экрана пользователя в пикселях
            Height_Ratio: real;    // Коэффициент высоты экрана. Определяется
                                   // как отношение высоты экрана разработчика
                                   // к высоте экрана пользователя
            Width_Ratio: real;     // Коэффициент ширины экрана. Определяется
                                   // как отношение ширины экрана разработчика
                                   // к ширине экрана пользователя
            TileWindows: boolean;
            CascadeWindows:boolean; // Упорядочиваем ли мы окна ?
            Exit_Ok:boolean; // Выходим ли мы из программы ? (окончательно)
            Main_Window_Exit:boolean; //Из чего мы запустили процедуру Close
            output_order:integer; // переменная, определяющая порядок расстановки окон
            sorted:boolean;
            {Список Материалов для фермы}
            Ferma_MMaterials:array[1..100] of TMaterial; // Массив материалов для фермы
            Ferma_num_mat:integer;  //Число добавленных пользователем материалов

            {Список Материалов для пластины}
            Plast_MMaterials:array[1..100] of TMaterial; // Массив материалов для пластины
            Plast_num_mat:integer;  //Число добавленных пользователем материалов

            {Список Материалов для TOK}
            TOK_MMaterials:array[1..100] of TMaterial; // Массив материалов для пластины
            TOK_num_mat:integer;  //Число добавленных пользователем материалов

            Num_Nonamed_Ferma:integer; //Номер вновь создаваемого проекта 'Ферма'
            Num_Nonamed_TOK:integer; //Номер вновь создаваемого проекта 'TOK'
            Num_Nonamed_Plast:integer; //Номер вновь создаваемого проекта 'Пластина'


         

   end;

var
   Main_Form: TMain_Form;
   keyid: integer;
   Ini: TIniFile; //Файл для хранения пути к файлу отчета
   DOCFullName: string; //Строка, содержащая полное имя файла отчета
   IniFullName: string; //Строка, содержащая полное имя этого файла
   AddUserInfoVisible: boolean; //Флаг видимости формы создания отчета
   MouseX1,MouseY1,MouseX2,MouseY2: Integer;
   MDown: Boolean;
   Selection: Boolean;
   SelectionIsOK: Boolean;
   SelectionIsCopied: Boolean;
   ControlsArray: array of boolean;
   FormBMP: TBitmap;
   BStyle: TFormBorderStyle;
   BIcons: TBorderIcons;
   FSize: array [0..1] of Integer;
   ASize: Boolean;



   const
   crDeleteElement = 1;    // Курсорчик удаления
   Dev_Height  : Integer  = 1024;   // Высота экрана разработчика в пикселях
   Dev_Width   : Integer  = 1280;  // Ширина экрана разработчика в пикселях

implementation

uses Splash,About, Ferma_M, Plast_M, TOK_M, Ferm_Dat,
   Ferma_FD, FermaRegionSize, SimplRezFerm, DeFormFerma, Plast_FD, Visio,
   PlastRegionSize, TOK_FD, tokRegionSize, About2, TokZad, SelectMetod,
   AddUserInfo, ModuleExecute, ShellAPI;

{$R *.DFM}
{$R FermaPlus.res}

 // Свой файл ресурсов
{procedure TMain_Form.WM_HotKeyHandler (var Message: TMessage);
  var
    idHotKey: integer; //идентификатор, но об этом - позже
    fuModifiers: word; //модификатор MOD_XX
    uVirtKey: word; //код виртуальной клавиши VK_XX
begin
  // параметры сообщения получаем так:
  idHotkey:= Message.wParam;
  fuModifiers:= LOWORD(Message.lParam);
  uVirtKey:= HIWORD(Message.lParam);

  //теперь - небольшая проверочка:
  if (fuModifiers = MOD_CONTROL) AND (uVirtKey = $4C) then
  open1.Click;
  inherited;
end; } // commented by Берсенёва М.

  // Начало Евдокимова
   procedure TMain_Form.WMDropFiles(var Message:TMessage);
   begin
   Drop:=Message.WParam;
   if Assigned(OnDropFiles) then OnDropFiles(Self);
   end;

   procedure TMain_Form.DoDropFiles(Sender:TObject);
   var CB:Integer;filesCount,j:Integer;
     filePath:Array[0..MAX_PATH] of Char;
         str: String;
   begin
    filesCount:=DragQueryFile((Sender as TMain_Form).Drop,$FFFFFFFF,nil,cb);
  //ListBox1.Items.Add(IntToStr(I));
   {For j:=0 to i-1 do
    begin
    FillChar(Str,SizeOf(Str),0);
    DragQueryFile((Sender as TMain_Form).Drop,j,Str,MAX_PATH);
    ListBox1.Items.Add(Str);
    end;}
   for j:=0 to filesCount-1 do begin
     DragQueryFile((Sender as TMain_Form).Drop,j,filePath,MAX_PATH);
     str:=ExtractFileExt(LowerCase(filePath));
     if str ='.frm' then
      begin
         with TFerma_Form.OpenFile(Self,filePath) do
         begin
            Show;
         end;
      end
      else if str='.dnp' then
         begin
            with TPlast_Form.OpenFile(Self,filePath) do
            begin
               Show;
            end;
      end
      else if str='.tok' then
         begin
            with Ttok_Form.OpenFile(Self,filePath) do
            begin
               Show;
            end;
         end
         else begin
            MessageDlg('Неизвестный тип файла.',mtError,[mbOk],0);
         end;
    end;
  end;
  // Конец Евдокимова



procedure TMain_Form.About1Click(Sender: TObject);
begin
   About2_Form.ShowModal;
end;

procedure TMain_Form.Exit1Click(Sender: TObject);
begin
   Close;
end;

procedure TMain_Form.Open1Click(Sender: TObject);
var
    str: String;
    already_open: boolean;
    i,j: integer;
    OpenFiles: array[0..11] of string;
    begin
   //!!!!!!!!!!Logvinov!!!!!!!!!!!!!!!!!!!!!!!!!! OpenDialog.FileName:='';
   if OpenDialog.Execute then
   for i:=0 to OpenDialog.Files.count-1 do begin
      already_open := False;
      for j := MDIChildCount-1 downto 0 do
      begin
        if Main_Form.MDIChildren[j].Caption = ExtractFileName(OpenDialog.Files[i]) then
        already_open := True;
      end;
      if already_open then continue;
      str:=ExtractFileExt(LowerCase(OpenDialog.Files[i]));
      if str ='.frm' then
      begin
         OpenFiles[i]:=ExtractFileName(ChangeFileExt(OpenDialog.Files[i],''))+'_tmp'+'.frm';
         {if fileexists(OpenFiles[i]) then
         begin
            OpenFiles[i]:='';
            continue;
         end;}
         CopyFileTo(OpenDialog.Files[i],OpenFiles[i]);
         with TFerma_Form.OpenFile(Self,OpenFiles[i]) do
         begin
            //if not fileexists(OpenFiles[i]) then
            Show;
         end;
      end
      else if str='.dnp' then
         begin
            with TPlast_Form.OpenFile(Self,OpenDialog.Files[i]) do
            begin
               Show;
            end;
         end
         else if str='.tok' then
            begin
               with Ttok_Form.OpenFile(Self,OpenDialog.Files[i]) do
               begin
                  Show;
               end;
            end
            else begin
               MessageDlg('Неизвестный тип файла.',mtError,[mbOk],0);
            end;
   end;
end;


procedure TMain_Form.NewFerma_MnuClick(Sender: TObject);
var
   F:TFerm;
begin
   //   Новая ферма
   F:=TFerm.Create;
   TFerma_Form.NewFile(Self,F);
end;

procedure TMain_Form.Sn_CBxChange(Sender: TObject);
begin
  if ActiveMDIChild is TFerma_Form then
  begin
    ActiveMDIChild.Tag:=Sn_CBx.ItemIndex+1;
    ferma_FD_form.showD(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm);
    ActiveMDIChild.RePaint;
    if ((Main_Form.DeletePivot12_ToolButton.Down) or (Main_Form.DeletePivot_ToolButton.Down)or(Main_Form.PivotTol_ToolButton.Down)) then Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
  end;
  if ActiveMDIChild is TPlast_Form then
  begin
    Visio_form.num_force:=SN_Cbx.ItemIndex+1;
    Plast_Fd_Form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr:=TRUE;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld:=-1;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld:=-1;
    ActiveMDIChild.RePaint;
    if Main_Form.Del_Cut_Plast_Toolbutton.Down then Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
  end;
  if ActiveMDIChild is Ttok_Form then
  begin
    TOK_Fd_Form.showD(TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).TOK);
    TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).sn:=Main_Form.sn_cbx.ItemIndex+1;
    ActiveMDIChild.RePaint;
  end;
end;

procedure TMain_Form.Open_TBtnClick(Sender: TObject);
begin
   Open1Click(Self);
end;


procedure TMain_Form.Save_TBtnClick(Sender: TObject);
begin
  if ActiveMDIChild is TFerma_Form then
   begin
    (ActiveMDIChild as TFerma_Form).FileSave_MnuClick(Sender);
   end;
  if ActiveMDIChild is TPlast_Form then
   begin
    (ActiveMDIChild as TPlast_Form).FileSave_MnuClick(Sender);
   end;
  if ActiveMDIChild is Ttok_Form then
   begin
    (ActiveMDIChild as Ttok_Form).FileSave_MnuClick(Sender);
   end;;
end;

procedure TMain_Form.NewPlast_MnuClick(Sender: TObject);
var
   p:TPlast;
begin
   p:=TPlast.Create;
   TPlast_Form.NewFile(Self,p);
end;


procedure TMain_Form.FormCreate(Sender: TObject);
//var Reg, Reg1, Reg2, Reg3, Reg4, Reg5, Reg6, Reg7 : TRegistry;
   //   NewForm:TFerma_Form;

begin
   Splash_Form:=TSplash_Form.Create(Self);
   Splash_Form.Show;
   while Splash_Form.Visible do Application.ProcessMessages;
   with Screen do
   begin
     Height_Ratio      := Dev_Height/Height;
     Width_Ratio       := Dev_Width/Width;
     Main_Form.Width   := trunc(800*Width_Ratio);
     Main_Form.Height  := trunc(480*Height_Ratio);
   end;
   Application.HelpFile:=ExtractFilePath(Application.ExeName)+Application.HelpFile;
   Num_Nonamed_Ferma   :=1;
   Num_Nonamed_Plast   :=1;
   Num_Nonamed_TOK     :=1;

   output_order := 1; //прямой порядок вывода
   sorted:=false;
   //Евдокимова Начало
    Main_Form.OnDropFiles:=Self.DoDropFiles;
    DragAcceptFiles(Main_Form.Handle,True);
  //Евдокимова Конец

 {//Инициализация горящих главиш
 keyid:=GlobalAddAtom('My Hotkey'); //создаем атом
 RegisterHotKey(handle,
 // сообщение о HotKey будет получать форма
 keyid, // регистрируем атом как id
 MOD_CONTROL,// модификатор у нас - клавиша Alt
 $4C // вирт. клавиша - F10
); } //commented by Берсенёва М.
end;

procedure TMain_Form.DrawPivot_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crCross;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '[- : -]';
   Main_Form.StatusBar1.Panels[1].Text  := 'Вне пределов области';
   Main_Form.StatusBar1.Panels[2].Text  := 'Переместите курсор в выделенную область';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
      Main_Form.Node_Move_ToolButton.Down:=false;
   end;
end;


procedure TMain_Form.None_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDefault;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
      Main_Form.Node_Move_ToolButton.Down:=false;
   end;
end;


procedure TMain_Form.Coord_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
   Main_Form.Node_Move_ToolButton.Down:=false;
end;

procedure TMain_Form.Zak_ToolButtonClick(Sender: TObject);
begin
   Main_Form.Node_Move_ToolButton.Down:=false;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
end;

procedure TMain_Form.Nagr_ToolButtonClick(Sender: TObject);
begin
   Main_Form.Node_Move_ToolButton.Down:=false;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
end;

procedure TMain_Form.ToolButton10Click(Sender: TObject);
begin
   Main_Form.Node_Move_ToolButton.Down:=false;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHelp;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=TRUE;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
end;


procedure TMain_Form.Node_ToolButtonClick(Sender: TObject);
begin
   Main_Form.Node_Move_ToolButton.Down:=false;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crCross;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '[- : -]';
   Main_Form.StatusBar1.Panels[1].Text  := 'Вне пределов области';
   Main_Form.StatusBar1.Panels[2].Text  := 'Переместите курсор в выделенную область';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
end;


procedure TMain_Form.PlastGraphButtonClick(Sender: TObject);
begin

   if PanelConstruction.Checked = False then
   begin
      Plast_Graph_Enter_Panel.Visible                :=False;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor            :=crDefault;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint          :=False;
      Plast_Graph_Enter_Panel.Buttons[0].Down      :=TRUE;
      StatusBar1.Panels[0].Text                      := '';
      StatusBar1.Panels[1].Text                      := '';
      StatusBar1.Panels[2].Text                      := '';
   end
   else begin
      Plast_Graph_Enter_Panel.Visible                :=TRUE;
   end;

end;

procedure TMain_Form.FormClose(Sender: TObject; var Action: TCloseAction);
var
   I:integer;

   Ferma_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для фермы
   Ferma_mf:System.Text;  // Файл с материалами для фермы

   Plast_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для пластины
   Plast_mf:System.Text;  // Файл с материалами для пластины

   TOK_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для TOK
   TOK_mf:System.Text;  // Файл с материалами для TOK
begin

   //================ Выходим из программы ===========================
   // (Закрываем все что можно закрыть)
   Exit_Ok         :=TRUE;
   Main_Window_Exit:=TRUE;
   Action          :=caFree;

   for I := MDIChildCount-1 downto 0 do
   begin
      Main_Form.MDIChildren[I].Close;
      if not Exit_Ok then break;
   end;

   if not Exit_Ok then
   begin
      Action          :=caNone;
      Main_Window_Exit := False;
      exit;
   end;

   ferma_FD_form.Close;
   Plast_Fd_Form.Close;
   TOK_Fd_Form.Close;
   //=================================================================


   //========== Обработка файла с материалами для фермы ==============
   Ferma_File_Ok:=TRUE;
   {енто мой комментарий!!!
    try
     begin
     AssignFile(Ferma_mf,ExtractFilePath(Application.ExeName)+'fermamaterials.ini');
     Reset(Ferma_mf);
     end;
    except
       Ferma_File_Ok:=False;
    end;
    енто кoнец моего комментария!!!}
   AssignFile(Ferma_mf,ExtractFilePath(Application.ExeName)+'fermamaterials.ini');
   if FileExists(ExtractFilePath(Application.ExeName)+'fermamaterials.ini') then reset(Ferma_mf)
   else Ferma_File_Ok:=False;
   if Ferma_num_mat=0 then // Количество материалов в файле для фермы
   begin
      if Ferma_File_Ok then
      begin CloseFile(Ferma_mf);//Erase(Ferma_mf);
      end;  // Если файл есть, а все дополнительные материалы удалены, то файл стираем
   end
   else begin
      //   if File_Ok then
      //    begin
      rewrite(Ferma_mf);
      writeln(Ferma_mf,Ferma_num_mat);
      for I:=3 to Ferma_num_mat+2 do
      begin
         writeln(Ferma_mf,Ferma_MMaterials[I].MName);
         writeln(Ferma_mf,Ferma_MMaterials[I].MModUpr);
         writeln(Ferma_mf,Ferma_MMaterials[I].MDopNapr);
         writeln(Ferma_mf,Ferma_MMaterials[I].Mplotn);
      end;
      CloseFile(Ferma_mf);
      //   end;
   end;
   //===== Конец обработки файла с материалами для фермы =============

   //========== Обработка файла с материалами для Пластины ==============
   Plast_File_Ok:=TRUE;
   {енто я, любимый, комментю!!!
    try
     AssignFile(Plast_mf,ExtractFilePath(Application.ExeName)+'plastinamaterials.ini');
     Reset(Plast_mf);
    except
       Plast_File_Ok:=False;
    end;
    енто я, любимый, накомментил!!!}
   {енто я, любимый, хулюганю!!!}
   AssignFile(Plast_mf,ExtractFilePath(Application.ExeName)+'plastinamaterials.ini');
   if FileExists(ExtractFilePath(Application.ExeName)+'plastinamaterials.ini') then
   begin
       reset(Plast_mf);
   end
   else Plast_File_Ok:=False;
   { енто я, любимый, нахулюганил!!!}
   if Plast_num_mat=0 then // Количество материалов в файле для пластины
   begin
      if Plast_File_Ok then
      begin CloseFile(Plast_mf);Erase(Plast_mf);
      end;  // Если файл есть, а все дополнительные материалы удалены, то файл стираем
   end
   else begin
      //   if File_Ok then
      //    begin
      rewrite(Plast_mf);
      writeln(Plast_mf,Plast_num_mat);
      for I:=3 to Plast_num_mat+2 do
      begin
         writeln(Plast_mf,Plast_MMaterials[I].MName);
         writeln(Plast_mf,Plast_MMaterials[I].MModUpr);
         writeln(Plast_mf,Plast_MMaterials[I].MDopNapr);
         writeln(Plast_mf,Plast_MMaterials[I].MKoffPuas);
         writeln(Plast_mf,Plast_MMaterials[I].MPlotn);
      end;
      CloseFile(Plast_mf);
      //   end;
   end;
   //===== Конец обработки файла с материалами для Пластины =============


   //========== Обработка файла с материалами для TOK ==============
   TOK_File_Ok:=TRUE;
   {енто я, любимый, комментю!!!
    try
     AssignFile(TOK_mf,ExtractFilePath(Application.ExeName)+'tokmaterials.ini');
     Reset(TOK_mf);
    except
       TOK_File_Ok:=False;
    end;
    енто я, любимый, накомментил!!!}
   {енто я, любимый, хулюганю!!!}
   if FileExists(ExtractFilePath(Application.ExeName)+'tokmaterials.ini') then
   begin
      AssignFile(TOK_mf,ExtractFilePath(Application.ExeName)+'tokmaterials.ini');
      reset(TOK_mf);
   end
   else TOK_File_Ok:=False;
   {енто я, любимый, нахулюганил!!!}
   if TOK_num_mat=0 then // Количество материалов в файле для TOK
   begin
      if TOK_File_Ok then
      begin CloseFile(TOK_mf);Erase(TOK_mf);
      end;  // Если файл есть, а все дополнительные материалы удалены, то файл стираем
   end
   else begin
      //   if File_Ok then
      //    begin
      rewrite(TOK_mf);
      writeln(TOK_mf,TOK_num_mat);
      for I:=3 to TOK_num_mat+2 do
      begin
         writeln(TOK_mf,TOK_MMaterials[I].MName);
         writeln(TOK_mf,TOK_MMaterials[I].MModUpr);
         writeln(TOK_mf,TOK_MMaterials[I].Mplotn);
      end;
      CloseFile(TOK_mf);
      //   end;
   end;
   //===== Конец обработки файла с материалами для ТОК =============


end;


procedure TMain_Form.FormShow(Sender: TObject);
var
   Ferma_mf:System.Text;  // Файл с материалами для фермы
   Ferma_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для фермы
   Plast_mf:System.Text;  // Файл с материалами для Пластины
   Plast_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для Пластины
   TOK_mf:System.Text;  // Файл с материалами для TOK
   TOK_File_Ok:boolean; //Флажочек для проверки наличия файла с материалами
   //   для TOK
   I:integer;
begin
   //Устанавливаем необходимые курсоры из ресурса
   Screen.Cursors[crDeleteElement] := LoadCursor(HInstance, 'DELETEELEMENT');

   //========== Обработка файла с материалами для фермы ==============
   Ferma_File_Ok                  :=TRUE;
   Ferma_num_mat                  :=0;
   // Устанавливаем материалы встроенные в программу (их нельзя удалить)
   Ferma_MMaterials[1].MName      :='Сталь';
   Ferma_MMaterials[1].MModUpr    :=20000000;
   Ferma_MMaterials[1].MDopNapr   :=70000;
   Ferma_MMaterials[2].MName      :='Алюминиевый сплав';
   Ferma_MMaterials[2].MModUpr    :=7000000;
   Ferma_MMaterials[2].MDopNapr   :=30000;
   Ferma_MMaterials[1].MPlotn      :=7.8*0.001;
   Ferma_MMaterials[2].MPlotn      :=2.8*0.001;

   {енто мой комментарий!!!}
   {  try  //Пытаемся прочесть файл с добавленными материалами
     AssignFile(Ferma_mf,ExtractFilePath(Application.ExeName)+'fermamaterials.ini');
     reset(Ferma_mf);
    except
      Ferma_File_Ok:=False;
    end;}
   {енто конец моего комментария!!!}
   if FileExists(ExtractFilePath(Application.ExeName)+'fermamaterials.ini') then
   begin
      AssignFile(Ferma_mf,ExtractFilePath(Application.ExeName)+'fermamaterials.ini');
      reset(Ferma_mf);
   end
   else Ferma_File_Ok:=False;
   if Ferma_File_Ok then  // Если файл есть, то считываем дополнительные материалы
   begin
      readln(Ferma_mf,Ferma_num_mat);
      for I:=3 to Ferma_num_mat+2 do
      begin
         readln(Ferma_mf,Ferma_MMaterials[I].MName,
                 Ferma_MMaterials[I].MModUpr,
                 Ferma_MMaterials[I].MDopNapr,Ferma_MMaterials[I].MPlotn);
      end;
      CloseFile(Ferma_mf);
   end;
   //===== Конец обработки файла с материалами для фермы =============

   //========== Обработка файла с материалами для Пластины ==============
   Plast_File_Ok                :=TRUE;
   Plast_num_mat                :=0;
   // Устанавливаем материалы встроенные в программу (их нельзя удалить)
   Plast_MMaterials[1].MName    :='Сталь';
   Plast_MMaterials[1].MModUpr  :=20000000;
   Plast_MMaterials[1].MDopNapr :=70000;
   Plast_MMaterials[1].MKoffPuas:=0.3;
   Plast_MMaterials[2].MName    :='Алюминиевый сплав';
   Plast_MMaterials[2].MModUpr  :=7000000;
   Plast_MMaterials[2].MDopNapr :=30000;
   Plast_MMaterials[2].MKoffPuas:=0.34;
   Plast_MMaterials[1].MPlotn      :=7.8*0.001;
   Plast_MMaterials[2].MPlotn      :=2.8*0.001;

   {енто мой комментарий!!!!
     try  //Пытаемся прочесть файл с добавленными материалами
      AssignFile(Plast_mf,ExtractFilePath(Application.ExeName)+'plastinamaterials.ini');
      reset(Plast_mf);
     except
       Plast_File_Ok:=False;
     end;
   енто  конец моего комментария!!!!!!}
   if FileExists(ExtractFilePath(Application.ExeName)+'plastinamaterials.ini') then
   begin
      AssignFile(Plast_mf,ExtractFilePath(Application.ExeName)+'plastinamaterials.ini');
      reset(Plast_mf);
   end
   else Plast_File_Ok:=False;
   if Plast_File_Ok then  // Если файл есть, то считываем дополнительные материалы
   begin
      readln(Plast_mf,Plast_num_mat);
      for I:=3 to Plast_num_mat+2 do
      begin
         readln(Plast_mf,Plast_MMaterials[I].MName,
                 Plast_MMaterials[I].MModUpr,
                 Plast_MMaterials[I].MDopNapr,
                 Plast_MMaterials[I].MKoffPuas,Plast_MMaterials[I].Mplotn);

      end;
      CloseFile(Plast_mf);
   end;
   //===== Конец обработки файла с материалами для Пластины =============

   //========== Обработка файла с материалами для TOK ==============
   TOK_File_Ok              :=TRUE;
   TOK_num_mat              :=0;
   // Устанавливаем материалы встроенные в программу (их нельзя удалить)
   TOK_MMaterials[1].MName  :='Сталь';
   TOK_MMaterials[1].MModUpr:=20000000;
   TOK_MMaterials[2].MName  :='Алюминиевый сплав';
   TOK_MMaterials[2].MModUpr:=7000000;
   TOK_MMaterials[1].MPlotn      :=7.8*0.001;
   TOK_MMaterials[2].MPlotn      :=2.8*0.001;
   {енто я, любимый, комментю!!!
     try  //Пытаемся прочесть файл с добавленными материалами
      AssignFile(TOK_mf,ExtractFilePath(Application.ExeName)+'tokmaterials.ini');
      reset(TOK_mf);
     except
       TOK_File_Ok:=False;
     end;
    енто я, любимый, накомментил!!!}
   {енто я, любимый, хулюганю!!! }
   if FileExists(ExtractFilePath(Application.ExeName)+'tokmaterials.ini') then
   begin
      AssignFile(TOK_mf,ExtractFilePath(Application.ExeName)+'tokmaterials.ini');
      reset(TOK_mf);
   end
   else TOK_File_Ok:=False;
   {енто я, любимый, нахулюганил!!!}
   if TOK_File_Ok then  // Если файл есть, то считываем дополнительные материалы
   begin
      readln(TOK_mf,TOK_num_mat);
      for I:=3 to TOK_num_mat+2 do
      begin
         readln(TOK_mf,TOK_MMaterials[I].MName,
                     TOK_MMaterials[I].MModUpr,TOK_MMaterials[I].Mplotn);
      end;
      CloseFile(TOK_mf);
   end;
   //===== Конец обработки файла с материалами для TOK =============



// Проверка на наличие файла с указанием пути к отчету:
  IniFullName:=ExtractFilePath(Application.ExeName)+'PathToDOC.ini';
  if not FileExists(IniFullName) then
   begin
    Ini:=TIniFile.Create(IniFullName);
    Ini.WriteString('Path To DOC','Current',
    ExtractFilePath(Application.ExeName)+'DefaultAccount.doc');
    Ini.Free;
    DOCFullName:=ExtractFilePath(Application.ExeName)+'DefaultAccount.doc';
     if Application.MessageBox('Задан путь к файлу отчета по умолчанию. Хотите изменить'+
      ' его и создать титульный лист? Если нет, то титульный лист не будет'+
       ' создан. Путь к файлу не изменится.',
         'Задан путь к отчету по умолчанию',mb_okcancel)=1 then
      begin
       AddUserInfoVisible:=True;
      end;
   end
  else
   begin
    Ini:=TIniFile.Create(IniFullName);
    DOCFullName:=Ini.ReadString('Path To DOC','Current',
     ExtractFilePath(Application.ExeName)+'DefaultAccount.doc');
    Ini.Free;
   end;
  Main_Form.Ferma_Panel.Pages[1].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
  Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;

end;


procedure TMain_Form.NodeDelete_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDeleteElement;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
   Main_Form.Node_Move_ToolButton.Down:=false;
end;


procedure TMain_Form.Size_ToolButtonClick(Sender: TObject);
var
   I:integer;
   max_x_coord, max_y_coord:extended;
   F:TFerm;
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor               :=crDefault;
   Main_Form.Ferma_Graph_Enter_Panel.Buttons[0].Down:=TRUE;
   F                                                 := Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
   FermaRegionSizeForm.SizeLabel.Caption             :='Размер области  ['+F.S_lin+']';
   max_x_coord                                       :=0;
   max_y_coord                                       :=0;
   for I:=1 to F.nyz1 do
   begin
      if F.corn[I,1]>=max_x_coord then max_x_coord:=F.corn[I,1];
      if F.corn[I,2]>=max_y_coord then max_y_coord:=F.corn[I,2];
   end;
   FermaRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',max_x_coord)+' <=';
   FermaRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',max_y_coord)+' <=';
   if  max_x_coord=0 then FermaRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',max_x_coord)+' <';
   if  max_y_coord=0 then FermaRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',max_y_coord)+' <';
   FermaRegionSizeForm.XSize.Text:=FloatToStr(F.region_x);
   FermaRegionSizeForm.YSize.Text:=FloatToStr(F.region_y);
   FermaRegionSizeForm.ShowModal;
end;


procedure TMain_Form.TOK_NO_PMIClick(Sender: TObject);
begin

   if TOK_NO_PMI.Checked=False then
   begin
      WithTOK.Checked     :=false;
      TOK_NO_PMI.Checked             :=TRUE;
      TOK_OK_PMI.Checked             :=False;
   end;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);

end;


procedure TMain_Form.TOK_OK_PMIClick(Sender: TObject);
begin

   if TOK_OK_PMI.Checked=False then
   begin
      WithTOK.CHecked     :=true;
      TOK_NO_PMI.Checked             :=False;
      TOK_OK_PMI.Checked             :=TRUE;
   end;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);

end;


procedure TMain_Form.DeletePivot_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDeleteElement;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent     :=0;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
   Main_Form.Node_Move_ToolButton.Down:=false;
end;


procedure TMain_Form.PivotTol_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint; 
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent     :=0;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
   Main_Form.Node_Move_ToolButton.Down:=false;
end;


procedure TMain_Form.DeletePivot12_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDeleteElement;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotX2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY1        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).pivotY2        :=-1;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent     :=0;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
   Main_Form.Node_Move_ToolButton.Down:=false;
end;


procedure TMain_Form.N5Click(Sender: TObject);
begin
   if not sorted then
     Main_Form.Sort(Sender);
   CascadeWindows:=TRUE;
   Cascade;
   CascadeWindows:=False;
   //n5.Checked:=true;
   //n13.Checked:=false;
   //n14.Checked:=false;
end;


procedure TMain_Form.ToolButton17Click(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Sender);
end;


procedure TMain_Form.ToolButton18Click(Sender: TObject);
begin
    if Ferma_SelectMetod=nil then
     Ferma_SelectMetod:=TFerma_SelectMetod.Create(self);
     //Ferma_SelectMetod.Close;
     Ferma_SelectMetod.Show;
end;


procedure TMain_Form.SimpleResult_TBClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);
end;


procedure TMain_Form.ToolButton21Click(Sender: TObject);
begin
  case Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).last_opt_type of
    1:
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N10Click(Sender);
    2:
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Sender);
    3:
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N11Click(Sender);
    4:
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N13Click(Sender);
  end;
end;


procedure TMain_Form.ToolButton7Click(Sender: TObject);
var
   FileName,Fname:string;
   Version_VYV,tmp:string;
   f1:System.Text;
   ff:File of Byte;
   mg:integer;

   begin
   FileName:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
   // Проверка на существование файла расчета
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
      Beep;
      MessageDlg(#13+'Файл с простым расчетом не найден.',mtError,[mbOk],0);
      exit;
   end;

   // Проверка на совместимость версий файлов данных и простого рассчета
   if FileExists(FileName) then
   begin
      AssignFile(ff,FileName);
      reset(ff);
      mg:=filesize(ff);
      CloseFile(ff);
   end
   else begin
      Beep;
      MessageDlg('Несовпадение версий файлов с данными и простого расчета.'+#13+'Произведите простой расчет для данной ферменной конструкции.',mtError,[mbOk],0);
      exit;
   end;
   if not AnsiContainsStr(Version_VYV,'_tmp') then
        begin
         Fname:= ExtractFileName(FileName);
         Delete(Fname,Pos('_tmp',Fname),4);
         tmp:= (Fname+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))))
        end
     else
        tmp:=(ExtractFileName(FileName)+' '+IntToStr(mg)+' '+DateTimeToStr(FileDateToDateTime(FileAge(FileName))));
   if ((Version_VYV)<> tmp) or (Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged=TRUE) then
   begin
      Beep;
      MessageDlg('Несовпадение версий файлов с данными и простого расчета.'+#13+'Произведите простой расчет для данной ферменной конструкции.',mtError,[mbOk],0);
      exit;
   end;
   //
   if DeForm_Form.Num_Color=0 then DeForm_Form.Num_Color:=5;
   //DeForm_Form.ShowModal;
   DeForm_Form.Show;
end;


procedure TMain_Form.FormResize(Sender: TObject);
begin
   if Width<800 then Width:=800;
   if Height<450 then Height:=450;
end;


procedure TMain_Form.ContentsClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_FINDER,0);
end;

procedure TMain_Form.PlastNumberButtonClick(Sender: TObject);
var
   I:integer;
begin
   for I:=MDIChildCount-1 downto 0 do
      Main_Form.MDIChildren[I].RePaint;
end;


procedure TMain_Form.Plast_SN_CbxChange(Sender: TObject);
begin
   {  If PlastGraphButton.Down = False then Plast_Graph_Enter_CoolBar.Visible:=False
    else Plast_Graph_Enter_CoolBar.Visible:=True; }

   Visio_form.num_force:=sn_cbx.ItemIndex+1;
   Plast_Fd_Form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr:=TRUE;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld:=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld:=-1;
   ActiveMDIChild.RePaint;
   //if visio_form.Visible then visio_form.Repaint;
   {if visio_color.Visible then visio_color.Repaint;
       if visio_color_2.Visible then visio_color_2.Repaint;}
   if Main_Form.Del_Cut_Plast_Toolbutton.Down then Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';        
end;


procedure TMain_Form.tok_sn_cbxChange(Sender: TObject);
begin
   TOK_Fd_Form.showD(TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).TOK);
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).sn:=Main_Form.sn_cbx.ItemIndex+1;
   ActiveMDIChild.RePaint;
end;


procedure TMain_Form.Cut_Plast_ToolbuttonClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crCross;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;      
   end;
end;


procedure TMain_Form.Del_Cut_Plast_ToolbuttonClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDeleteElement;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;        
   end;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutX1_x        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutX2_x        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutY1_x        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutY2_x        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutX1_y        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutX2_y        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutY1_y        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutY2_y        :=-1;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent       :=''; 
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
end;


procedure TMain_Form.Plast_Zakr_ToolButtonClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;
   end;
end;

procedure TMain_Form.Plast_Nagr_ToolButtonClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHandPoint;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;
   end;
end;

procedure TMain_Form.Inform_ToolbuttonClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crHelp;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=TRUE;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;     
   end;
end;


procedure TMain_Form.plast_Size_ToolButtonClick(Sender: TObject);
var
   max_x_coord, max_y_coord:extended;
   p:TPlast;
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;
   end;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor               :=crDefault;
   Main_Form.Plast_Graph_Enter_Panel.Buttons[0].Down:=TRUE;
   p                                                 := Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
   plastRegionSizeForm.SizeLabel.Caption             :='Размеры области  ['+p.S_lin+']';
   max_x_coord                                       :=p.xm1[p.kx1];
   max_y_coord                                       :=p.ym1[p.ky1];
   if (p.xm1[p.kx1-1]<>0) then plastRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',p.xm1[p.kx1-1])+' <';
   if (p.ym1[p.ky1-1]<>0) then plastRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',p.ym1[p.ky1-1])+' <';
   if  max_x_coord=0 then plastRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',max_x_coord)+' <';
   if  max_y_coord=0 then plastRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',max_y_coord)+' <';
   plastRegionSizeForm.XSize.Text :=FloatToStr(p.xm1[p.kx1]);
   plastRegionSizeForm.YSize.Text :=FloatToStr(p.ym1[p.ky1]);
   // PlastRegionSizeForm.razm_label.caption:= p.s_lin;
   plastRegionSizeForm.nt_edt.Text:=FloatToStr(p.ton1);
   if (p.kz1=0)and(p.kl1=0) then plastRegionSizeForm.ShowModal
   else begin
      MessageDlg('Невозможно изменить размер области.'+#10+#13+'Присутствует закрепление и/или сила.'+#10+#13+'Может быть изменена только толщина.',mtwarning{error},[mbOk],0);
      plastRegionSizeForm.XSize.enabled:=False;
      plastRegionSizeForm.YSize.enabled:=False;
      plastRegionSizeForm.ShowModal ;
      plastRegionSizeForm.XSize.enabled:=TRUE;
      plastRegionSizeForm.YSize.enabled:=TRUE;
      // exit;
   end;

end;


procedure TMain_Form.NewTOK_MnuClick(Sender: TObject);
var
   t:Ttok;
begin
   // Создание новой ТОК
   {my comment
    New_TBtn.ImageIndex:=5;
    New_TBtn.Hint:='Создать проект '+#39+'ТОК'+#39;
    New_TBtn.OnClick:=NewTOK_MnuClick;
    New_Btn_PU_TOK.Checked:=True;
    New_Btn_PU_Ferma.Checked:=False;
    New_Btn_PU_Plast.Checked:=False;
   end of my comment}
   t:=Ttok.Create;
   Ttok_Form.NewFile(Self,t);
end;


procedure TMain_Form.TokGraphButtonClick(Sender: TObject);
begin

   if PanelConstruction.Checked = False then
   begin
      TOK_Graph_Enter_Panel.Visible :=False;
      Plast_Dock.Visible := False;
      TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor          :=crDefault;
      TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint        :=False;
      TOK_Graph_Enter_Panel.Buttons[0].Down  :=TRUE;
      StatusBar1.Panels[0].Text                := '';
      StatusBar1.Panels[1].Text                := '';
      StatusBar1.Panels[2].Text                := '';
   end
   else begin
      TOK_Graph_Enter_Panel.Visible :=TRUE;
      Tok_Dock.Visible := true;
   end;
end;


procedure TMain_Form.SimpleSolveClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Sender);
end;


procedure TMain_Form.ToolButton25Click(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SolveOpt_MnuClick(Sender);
end;


procedure TMain_Form.Plast_SimpReztextClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).s_text_mnuClick(Sender);
end;


{procedure TMain_Form.SimpleSolve_eqClick(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_form.ActiveMDIChild).eq_mnuClick(Sender);
end;   }


{procedure TMain_Form.SimpleSolve_XClick(Sender: TObject);
begin
 Plast_M.TPlast_Form(Main_form.ActiveMDIChild).X_mnuClick(Sender);
end;  }


{procedure TMain_Form.SimpleSolve_YClick(Sender: TObject);
begin
 Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Y_mnuClick(Sender);
end;}


{procedure TMain_Form.SimpleSolve_KasClick(Sender: TObject);
begin
 Plast_M.TPlast_Form(Main_form.ActiveMDIChild).Kas_mnuClick(Sender);
end;}


procedure TMain_Form.Plast_OptRezTextClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).o_text_mnuClick(Sender);
end;


procedure TMain_Form.Plast_TolRezGraphClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Sender);
end;

procedure TMain_Form.TokNumberButtonClick(Sender: TObject);
var
   I:integer;
begin
   for I := MDIChildCount-1 downto 0 do
      Main_Form.MDIChildren[I].RePaint;
end;





procedure TMain_Form.SimpleRez_textClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).s_text_mnuClick(Sender);
end;

procedure TMain_Form.SimpleRez_grafClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Sender);
end;

procedure TMain_Form.OptRez_textClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).o_text_mnuClick(Sender);
end;

procedure TMain_Form.OptRez_grafClick(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Sender);
end;

procedure TMain_Form.Tok_Size_ToolButtonClick(Sender: TObject);
var
   I:integer;
   max_x_coord, max_y_coord:extended;
   t:Ttok;
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint                :=False;
   Main_Form.StatusBar1.Panels[0].Text              := '';
   Main_Form.StatusBar1.Panels[1].Text              := '';
   Main_Form.StatusBar1.Panels[2].Text              := '';
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor                  :=crDefault;
   Main_Form.TOK_Graph_Enter_Panel.Buttons[0].Down:=TRUE;
   t                                                := TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).TOK;
   tokRegionSizeForm.SizeLabel.Caption              :='Размеры области  ['+t.S_lin+']';
   max_x_coord                                      :=0;
   max_y_coord                                      :=0;
   for I:= 1 to 36 do
   begin
      if t.xm[I]>max_x_coord then max_x_coord:=t.xm[I];
      if t.ym[I]>max_y_coord then max_y_coord:=t.ym[I];
   end;
   tokRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',max_x_coord)+' <=';
   tokRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',max_y_coord)+' <=';
   if  max_x_coord=0 then tokRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',max_x_coord)+' <';
   if  max_y_coord=0 then tokRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',max_y_coord)+' <';
   tokRegionSizeForm.XSize.Text:=FloatToStr(t.xm[37]);
   tokRegionSizeForm.YSize.Text:=FloatToStr(t.ym[37]);

   tokRegionSizeForm.ShowModal


end;

procedure TMain_Form.tok_Zakr_ToolButtonClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor    :=crHandPoint;
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint  :=False;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
end;

procedure TMain_Form.tok_Zad_ToolButtonClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor    :=crHandPoint;
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint  :=False;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
   TokZad_Form.ShowModal;
end;

procedure TMain_Form.tok_Nagr_ToolButtonClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor    :=crHandPoint;
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint  :=False;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
end;

procedure TMain_Form.ToolButton3Click(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor    :=crDefault;
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint  :=False;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
end;

procedure TMain_Form.ToolButton1Click(Sender: TObject);
begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDefault;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if((Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent<>'')or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld<>-1)or(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld<>-1)) then
   begin
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).RePaint;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).cutIdent:='';
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld    :=-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr    :=TRUE;        
   end;
end;

procedure TMain_Form.toksolve_btnClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Sender);
end;

procedure TMain_Form.tokrez_btnClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).N1Click(Sender);
end;

procedure TMain_Form.Tok_Inform_ToolbuttonClick(Sender: TObject);
begin
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor    :=crHelp;
   TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint  :=TRUE;
   Main_Form.StatusBar1.Panels[0].Text := '';
   Main_Form.StatusBar1.Panels[1].Text := '';
   Main_Form.StatusBar1.Panels[2].Text := '';
end;

procedure TMain_Form.FormActivate(Sender: TObject);
begin
   //showmessage(string(ParamStr(1)));
   if Main_Form.Active then TFerma_Form.OpenFile(Main_Form,ParamStr(1));
   if pos(string(ParamStr(1)), '.frm') <> 0 then
   begin
      showmessage('fuck');
      TFerma_Form.OpenFile(Self,ParamStr(1));
   end;
   if Timer1<>nil then Timer1.enabled := TRUE;
end;

procedure TMain_Form.Timer1Timer(Sender: TObject);
begin
   if pos('frm',LowerCase(ParamStr(1))) <> 0 then                TFerma_Form.OpenFile(Self,LowerCase(ParamStr(1)));
   if pos('dnp',LowerCase(ParamStr(1))) <> 0 then                TPlast_Form.OpenFile(Self,LowerCase(ParamStr(1)));
   if pos('tok',LowerCase(ParamStr(1))) <> 0 then                Ttok_Form.OpenFile(Self,LowerCase(ParamStr(1)));
   Timer1.Destroy;

end;


procedure TMain_Form.newClick(Sender: TObject);
begin
    if Ferma_SelectMetod=nil then
     Ferma_SelectMetod:=TFerma_SelectMetod.Create(self);
     //Ferma_SelectMetod.Close;
     Ferma_SelectMetod.Show;
end;

procedure TMain_Form.ToolButton33Click(Sender: TObject);
begin
       Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResultsVC1_MnuClick(Sender);
end;

procedure TMain_Form.N3Click(Sender: TObject);
begin
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Sender);
end;

procedure TMain_Form.N4Click(Sender: TObject);
begin
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResultsVC1_MnuClick(Sender);
end;

procedure TMain_Form.LoadOtrClick(Sender: TObject);
begin
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).LoadOtrData;
end;

procedure TMain_Form.N15Click(Sender: TObject);
begin
 if Ferma_Panel.Visible then Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PutToAccount;
end;

procedure TMain_Form.N16Click(Sender: TObject);
begin
PutToAccount(Main_Form);
end;

procedure TMain_Form.ToolButton35Click(Sender: TObject);
begin
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PutToAccount;
end;

procedure TMain_Form.N17Click(Sender: TObject);
begin
 if N17.Checked then
  N17.Checked:=False
 else
  N17.Checked:=True;
end;

procedure TMain_Form.ToolButton37Click(Sender: TObject);
begin
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PrepareForModule;
end;

procedure TMain_Form.ToolButton42Click(Sender: TObject);
begin
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).PutToAccount;
end;

procedure TMain_Form.ToolButton38Click(Sender: TObject);
begin
 Tok_M.Ttok_Form(Main_Form.ActiveMDIChild).PutToAccount;

end;

procedure TMain_Form.ToolButton43Click(Sender: TObject);
begin
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PrepareForModule;

end;

procedure TMain_Form.ToolButton41Click(Sender: TObject);
begin
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PrepareForModule;

end;

procedure TMain_Form.PutToAccount(Form: TForm);
var
 OleFileName,OleUnit,OleExtend: OleVariant;
 Bmp: TBitmap;
begin
 Bmp:=TBitmap.Create;

 Bmp.Canvas.CopyMode:=cmSrcCopy;
 if SelectionIsOK then
  begin
   Bmp.Width:=MouseX2-MouseX1;
   Bmp.Height:=MouseY2-MouseY1;
   Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
    FormBMP.Canvas,Rect(MouseX1+1,MouseY1+1,MouseX2,MouseY2));
  end
 else
  begin
   if Form=Main_Form then
    begin
     Bmp.Width:=Form.ClientWidth;
     Bmp.Height:=Form.ClientHeight-49;
     Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
      Form.Canvas,Rect(0,26,Bmp.Width,Bmp.Height+26));
    end
   else
    begin
     Bmp.Width:=Form.ClientWidth;
     Bmp.Height:=Form.ClientHeight;
     Bmp.Canvas.CopyRect(Rect(0,0,Bmp.Width,Bmp.Height),
      Form.Canvas,Rect(0,0,Bmp.Width,Bmp.Height));
    end;
  end;

 OleFileName:=DOCFullName;
 OleUnit:=wdStory;
 OleExtend:=wdMove;

 WordApplication1.Connect;

 WordApplication1.Documents.Open(OleFileName,EmptyParam,EmptyParam,EmptyParam,
  EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
   EmptyParam,);
 WordApplication1.Visible:=True;
 WordApplication1.Options.CheckSpellingAsYouType:=False;
 WordApplication1.Options.CheckGrammarAsYouType:=False;

// Копирование содержимого формы в отчет:
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

 SelectionIsCopied:=True;
 SelectionIsOK:=False;

 Form.Repaint;
end;

// Обработчики щелчков мыши при режиме расширенной вставки ---------------------
procedure TMain_Form.MouseLeft(Form: TForm);
begin
 Form.Repaint;
 Form.Canvas.CopyRect(Rect(0,0,FormBMP.Width,FormBMP.Height),
  FormBMP.Canvas,Rect(0,0,FormBMP.Width,FormBMP.Height));
end;

procedure TMain_Form.MouseIsDown(Form: TForm; MX,MY: Integer);
begin
 MDown:=True;
 MouseX1:=MX;
 MouseY1:=MY;
 Form.Canvas.Pen.Color:=clBlue;
 MouseLeft(Form);
end;

procedure TMain_Form.MouseIsMove(Form: TForm; MX,MY: Integer);
begin
 if MDown then
  begin
   Form.Repaint;
   with Form.Canvas do
    begin
     CopyRect(Rect(0,0,FormBMP.Width,FormBMP.Height),
      FormBMP.Canvas,Rect(0,0,FormBMP.Width,FormBMP.Height));
     MoveTo(MouseX1,MouseY1);
     LineTo(MX,MouseY1);
     LineTo(MX,MY);
     LineTo(MouseX1,MY);
     LineTo(MouseX1,MouseY1);
    end;
  end;
end;

procedure TMain_Form.MouseIsUp(Form: TForm; MX,MY: Integer);
var
 Temp: Integer;
begin
 MDown:=False;
 MouseX2:=MX;
 MouseY2:=MY;
 if MouseX2<MouseX1 then
  begin
   Temp:=MouseX1;
   MouseX1:=MouseX2;
   MouseX2:=Temp;
  end;
 if MouseY2<MouseY1 then
  begin
   Temp:=MouseY1;
   MouseY1:=MouseY2;
   MouseY2:=Temp;
  end;
 if (MouseX1<>MouseX2) or (MouseY1<>MouseY2) then SelectionIsOK:=True
 else SelectionIsOK:=False;
end;


// Обработчик переключения режима расширенной встравки -------------------------
procedure TMain_Form.SelectionMode(Form: TForm; Activate: Boolean);
var
 BMP: TBitmap;
 i,j: Integer;
begin
// Если включаем режим:
 if Activate then
  begin
    if Form.AutoSize then
     begin
      Form.AutoSize:=False;
      ASize:=True;
     end
    else
     ASize:=False;
   BMP:=TBitmap.Create;
   BMP.Width:=Form.ClientWidth;
   BMP.Height:=Form.ClientHeight;
   FormBMP.Width:=BMP.Width;
   FormBMP.Height:=BMP.Height;
   BMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),Form.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   SetLength(ControlsArray,Form.ControlCount);
   for i:=0 to Form.ControlCount-1 do
    begin
     if Form.Controls[i].Visible then
      begin
       Form.Controls[i].Visible:=False;
       ControlsArray[i]:=True;
      end
     else ControlsArray[i]:=False;
    end;
   FSize[0]:=Form.Width;
   FSize[1]:=Form.Height;
   BStyle:=Form.BorderStyle;
   Form.BorderStyle:=bsSingle;
   BIcons:=Form.BorderIcons;
   Form.BorderIcons:=[biSystemMenu];
   Form.Width:=FSize[0];
   Form.Height:=FSize[1];
   Form.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   FormBMP.Canvas.CopyRect(Rect(0,0,BMP.Width,BMP.Height),BMP.Canvas,
    Rect(0,0,BMP.Width,BMP.Height));
   BMP.Free;
  end
// Или же если выключаем:
 else
  begin
   for i:=0 to Form.ControlCount-1 do
    begin
     if ControlsArray[i]=True then
      begin
       Form.Controls[i].Visible:=True;
      end;
    end;
   Form.Repaint;
   FormBMP.Width:=0;
   FormBMP.Height:=0;
   SetLength(ControlsArray,0);
   FSize[0]:=Form.Width;
   FSize[1]:=Form.Height;
   Form.BorderStyle:=BStyle;
   Form.BorderIcons:=BIcons;
   Form.Width:=FSize[0];
   Form.Height:=FSize[1];
    if ASize then
     begin
      Form.AutoSize:=True;
      ASize:=False;
     end;
  end;
end;

procedure TMain_Form.N9Click(Sender: TObject);
begin
 AddUserInfo_form.ShowModal;
end;

procedure TMain_Form.LoadProfileClick(Sender: TObject);
var
 Ini: TIniFile;
begin
 if (OpenDialog1.Execute) then
  begin
   DOCFullName:=OpenDialog1.FileName;
   Application.MessageBox('Указанный файл назначен файлом отчета.','Отчет задан');

   Ini:=TIniFile.Create(IniFullName);
   Ini.EraseSection('Path To DOC');
   Ini.WriteString('Path To DOC','Current',DOCFullName);
   Ini.Free;
  end;
end;

procedure TMain_Form.N11Click(Sender: TObject);
var
 OleFileName: OleVariant;
begin
 OleFileName:=DOCFullName;

 WordApplication1.Connect;

 WordApplication1.Documents.Open(OleFileName,EmptyParam,EmptyParam,EmptyParam,
  EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
   EmptyParam);
 WordApplication1.Visible:=True;
 WordApplication1.Options.CheckSpellingAsYouType:=False;
 WordApplication1.Options.CheckGrammarAsYouType:=False;

 WordApplication1.Disconnect;

end;

procedure TMain_Form.ModuleExecuteClick(Sender: TObject);
begin
ModuleExecute_Form.ShowModal;
end;

procedure TMain_Form.N14Click(Sender: TObject);
begin
 if not sorted then
   Main_Form.Sort(Sender);
 TileWindows:=True;
 TileMode:=tbVertical;
 Tile;
 TileWindows:=False;
 //n14.Checked:=true;
 //n5.Checked:=false;
 //n13.Checked:=false;
end;

procedure TMain_Form.N13Click(Sender: TObject);
begin
 if not sorted then
   Main_Form.Sort(Sender);
 TileWindows:=True;
 TileMode:=tbHorizontal;
 Tile;
 TileWindows:=False;
 //n13.Checked:=true;
 //n5.Checked:=false;
 //n14.Checked:=false;
end;

procedure TMain_Form.N19Click(Sender: TObject);
var
i,j: integer;
s,ss: string;
t: TStringList;
found: integer;
begin
t := TStringList.Create;
for i:=1 to Main_form.MDIChildCount do begin

  t.Add(Main_form.MDIChildren[i-1].Caption);
end;

 t.Sort;
 s:='';
 ss:='list:';
 if output_order=1 then
 begin
   for j:=0 to t.Count-1 do begin
     ss:= ss+  ' '+t.Strings[j];
   end;

   for j:=0 to t.Count-1 do begin
    for i:=1 to Main_form.MDIChildCount do begin
      found:=0;
      if (found=0) then begin
        if (Main_form.MDIChildren[i-1].Caption=t.Strings[j]) then begin
          Main_form.MDIChildren[i-1].SetFocus;
          found:=1;
        end;
      end;
    end;
   end;
   output_order:=2;
 end
 else begin
   for j:=t.Count-1 downto 0 do begin
     for i:=1 to Main_form.MDIChildCount do begin
       found:=0;
       if (found=0) then begin
         if (Main_form.MDIChildren[i-1].Caption=t.Strings[j]) then  begin
           Main_form.MDIChildren[i-1].SetFocus;
           found:=1;
         end;
       end;
     end;
   end;
   output_order:=1;
 end;

//if n5.Checked then n5.Click;
//if n13.Checked then n13.Click;
//if n14.Checked then n14.Click;

{if not n5.Checked then begin
 if not n13.Checked then begin
  if not n14.Checked then begin
   n5.Click;
  end;
 end;
end;}

end;

procedure TMain_Form.Node_Move_ToolButtonClick(Sender: TObject);
begin
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor  :=crDefault;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint:=False;
   Main_Form.StatusBar1.Panels[0].Text  := '';
   Main_Form.StatusBar1.Panels[1].Text  := '';
   Main_Form.StatusBar1.Panels[2].Text  := '';
   if(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent<>0) then
   begin
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).RePaint;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).PivotIdent:=0;
   end;

end;

procedure TMain_Form.N20Click(Sender: TObject);
var
  i,k,nc,num_ferm: integer;
begin
   for I := MDIChildCount-1 downto 0 do
   begin
      Main_Form.MDIChildren[I].Close;
   end;
   //Main_Form.My_menu.Items[0].Enabled     :=false;
   Ferma_Fd_Form.first_show_FD_form         :=true;
   Plast_Fd_Form.first_show_FD_form         :=true;
   TOK_Fd_Form.first_show_FD_form         :=true;
   Ferma_Fd_Form.Close;
   Plast_Fd_Form.Close;
   Tok_Fd_Form.Close;
   Main_Form.PanelConstruction.Checked     :=false;
   Main_Form.NodesNum.Checked    :=false;
   Main_Form.PanelConstruction.Checked     :=false;
   Main_Form.NodesNum.Checked    :=false;
   Main_Form.WithTOK.CHecked:=false;
   Main_Form.TOK_OK_PMI.Checked        :=false;
   Main_Form.TOK_NO_PMI.Checked        :=true;
   Main_Form.Caption:='Ферма';
end;

procedure TMain_Form.Sort(Sender: TObject);
var
i,j: integer;
s,ss: string;
t: TStringList;
found: integer;
begin
t := TStringList.Create;
for i:=1 to Main_form.MDIChildCount do begin
  t.Add(Main_form.MDIChildren[i-1].Caption);
end;
t.Sort;
found:=0;
for j:=0 to t.Count-1 do begin
  for i:=1 to Main_form.MDIChildCount do begin
    if (found=0) then begin
      if (Main_form.MDIChildren[i-1].Caption=t.Strings[j]) then  begin
               Main_form.MDIChildren[i-1].SetFocus;
               found:=1;
        end;
      end;
    end;
    sorted:=true;
end;
end;

procedure TMain_Form.FermaGridButtonClick(Sender: TObject);
var
   I:integer;
begin
   for I := MDIChildCount-1 downto 0 do
      Main_Form.MDIChildren[I].RePaint;
end;

// Открытие Tube Selector
procedure TMain_Form.TubeOpenClick(Sender: TObject);
begin
WinExec(PAnsiChar('Tube_Selector.exe'),sw_Show);
end;

// Открыть папку текущего проекта
procedure TMain_Form.OpenFolderClick(Sender: TObject);
begin
  DOCFullName := '';
  if ActiveMDIChild is TFerma_Form then
   begin
    DOCFullName := ExtractFileDir(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName);
   end;
  if ActiveMDIChild is TPlast_Form then
   begin
    DOCFullName := ExtractFileDir(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).FileName);
   end;
  if ActiveMDIChild is Ttok_Form then
   begin
    DOCFullName := ExtractFileDir(TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).FileName);
   end;
   if DOCFullName = '' then
   begin
    MessageDLG('Проект не сохранен',mtWarning,[mbOk],0);
    exit;
   end;
   ShellExecute(0, 'open', PAnsiChar(DOCFullName), nil, nil, SW_SHOWNORMAL);
end;

// Сохранить как... активный проект
procedure TMain_Form.SaveAsClick(Sender: TObject);
begin
  if ActiveMDIChild is TFerma_Form then
   begin
    (ActiveMDIChild as TFerma_Form).FileSaveAs_MnuClick(Sender);
   end;
  if ActiveMDIChild is TPlast_Form then
   begin
    (ActiveMDIChild as TPlast_Form).FileSaveAs_MnuClick(Sender);
   end;
  if ActiveMDIChild is Ttok_Form then
   begin
    (ActiveMDIChild as Ttok_Form).FileSaveAs_MnuClick(Sender);
   end;;
end;

// Отобразить форму конструктора
procedure TMain_Form.ConstructorShowClick(Sender: TObject);
begin
   if ConstructorShow.Checked = False then
   begin
    if ActiveMDIChild is TFerma_Form then Ferma_FD_form.Visible:=False;
    if ActiveMDIChild is TPlast_Form then Plast_Fd_Form.Visible:=False;
    if ActiveMDIChild is Ttok_Form then TOK_Fd_Form.Visible:=False;
   end
   else
   begin
    if ActiveMDIChild is TFerma_Form then Ferma_FD_form.Visible:=True;
    if ActiveMDIChild is TPlast_Form then Plast_Fd_Form.Visible:=True;
    if ActiveMDIChild is Ttok_Form then TOK_Fd_Form.Visible:=True;
   end;
end;

procedure TMain_Form.PanelConstructionClick(Sender: TObject);
begin
   if PanelConstruction.Checked = False then
   begin
    if ActiveMDIChild is TFerma_Form then
    begin
      Ferma_Graph_Enter_Panel.Visible :=False;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.Cursor :=crDefault;
      Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint :=False;
      Ferma_Graph_Enter_Panel.Buttons[0].Down:=TRUE;
    end;
    if ActiveMDIChild is TPlast_Form then
    begin
      Plast_Graph_Enter_Panel.Visible :=False;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.Cursor :=crDefault;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint :=False;
      Plast_Graph_Enter_Panel.Buttons[0].Down :=TRUE;
    end;
    if ActiveMDIChild is Ttok_Form then
    begin
      TOK_Graph_Enter_Panel.Visible :=False;
      Tok_Dock.Visible := true;
      TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.Cursor :=crDefault;
      TOK_M.Ttok_Form(Main_Form.ActiveMDIChild).paintbox.ShowHint :=False;
      TOK_Graph_Enter_Panel.Buttons[0].Down :=TRUE;
    end;
   end else
   begin
    if ActiveMDIChild is TFerma_Form then
    begin
      Ferma_Graph_Enter_Panel.Visible :=TRUE;
      Ferma_Dock.Visible := true
    end;
    if ActiveMDIChild is TPlast_Form then
    begin
      Plast_Graph_Enter_Panel.Visible :=TRUE;
      Plast_Dock.Visible := true;
    end;
    if ActiveMDIChild is Ttok_Form then
    begin
      TOK_Graph_Enter_Panel.Visible :=TRUE;
      Tok_Dock.Visible := true;
    end;
   end;
   StatusBar1.Panels[0].Text := '';
   StatusBar1.Panels[1].Text := '';
   StatusBar1.Panels[2].Text := '';
end;


procedure TMain_Form.BitBtn5Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.SimpleClick(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.BitBtn9Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).SolveOpt_Mnu1Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.BitBtn10Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.BitBtn12Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N9Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.B13Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N11Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.BitBtn15Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N12Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.B16Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N13Click(Main_Form.ActiveMDIChild);
end;

{procedure TMain_Form.Button1Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N18Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.Button2Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).N19Click(Main_Form.ActiveMDIChild);
end; }

procedure TMain_Form.SelectTOKClick(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).TOKClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.B4Click(Sender: TObject);
begin
  Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ChangeTOKClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P1Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P2Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).s_text_mnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P3Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SimpleResults_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P4Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).SolveOpt_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P5Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).o_text_mnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P6Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).OptResults_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.P7Click(Sender: TObject);
begin
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).N3Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.T1Click(Sender: TObject);
begin
  TOK_M.TTok_Form(Main_Form.ActiveMDIChild).SimpleSolve_MnuClick(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.T2Click(Sender: TObject);
begin
  TOK_M.TTok_Form(Main_Form.ActiveMDIChild).N1Click(Main_Form.ActiveMDIChild);
end;

procedure TMain_Form.HelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_FINDER,0);
end;

procedure TMain_Form.bbbClick(Sender: TObject);
begin
  SendMessage(GetForegroundWindow,WM_SYSCOMMAND,SC_MINIMIZE,0);
end;

procedure TMain_Form.ApplicationEvents1Idle(Sender: TObject;
  var Done: Boolean);
var i,j :word;
begin
  if (MDIChildCount = 0) then
  begin
    Main_Form.Caption :='Ferma - Версия 7.1.10 для Windows';
    ListBox1.clear;
    ListBox1.Visible := False;
    Sn_CBx.Visible := False;
    Main_Form.Ferma_Panel.Pages[1].TabVisible := False;
    Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
    Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
    Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;
    Main_Form.Ferma_Panel.Pages[5].TabVisible := False;
    Save_TBtn.Enabled := False;
    SaveAs.Enabled := False;
    OpenFolder.Enabled := False;
    HideMenu.Visible := False;
    Ferma_Panel.Height := 122;
  end
  else
  begin
    ListBox1.Visible := True;
    Sn_CBx.Visible := True;
    Main_Form.Ferma_Panel.Pages[1].TabVisible := True;
    Main_Form.Ferma_Panel.Pages[5].TabVisible := True;
    Save_TBtn.Enabled := True;
    OpenFolder.Enabled := True;
    SaveAs.Enabled := True;
    HideMenu.Visible := True;
  end;
  if not(MDIChildCount = ListBox1.Items.Count) then
  begin
    ListBox1.clear;
    for i:= 0 to MDIChildCount - 1 do
      ListBox1.Items.Add(MDIChildren[i].Caption);
    ListBox1.ItemIndex := 0;
    Sn_CBx.Visible := False;
  end;
  if (MDIChildCount > 0) then
  for i:= 0 to MDIChildCount - 1 do
  begin
    if not(ListBox1.Items[i] = MDIChildren[i].Caption) then
    begin
      ListBox1.clear;
      for j:= 0 to MDIChildCount - 1 do
        ListBox1.Items.Add(MDIChildren[j].Caption);
      ListBox1.ItemIndex := 0;
    end;
  end;
    if (MDIChildCount > 0) then Windows_Mnu.Enabled := True
      else Windows_Mnu.Enabled := False;
    if (MDIChildCount > 0) and (ActiveMDIChild.WindowState = wsMaximized) then
      Back.Visible := true
    else
      Back.Visible := false;

    if ActiveMDIChild is TFerma_Form then
    begin
      Main_Form.Caption := 'Ferma - подсистема '+#39+'Ферменная конструкция'+#39;
      Main_Form.Ferma_Panel.Pages[2].TabVisible:=True;
      Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;
      if Ferma_Graph_Enter_Panel.Visible = False then
      begin
        PanelConstruction.Checked := False;
        Ferma_Dock.Visible := False;
      end;
    end;
    if ActiveMDIChild is TPlast_Form then
    begin
      Main_Form.Caption := 'Ferma - подсистема '+#39+'Пластина'+#39;
      Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[3].TabVisible:=True;
      Main_Form.Ferma_Panel.Pages[4].TabVisible:=False;
      SticksNum.Visible := False;
      Knum.Visible := True;
      if Plast_Graph_Enter_Panel.Visible = False then
      begin
        PanelConstruction.Checked := False;
        Plast_Dock.Visible := False;
      end;
    end else
    begin
      SticksNum.Visible := True;
      Knum.Visible := False;
    end;
    if ActiveMDIChild is Ttok_Form then
    begin
      Main_Form.Caption := 'Ferma - подсистема '+#39+'ТОК'+#39;
      SticksNum.Visible := False;
      Knum.Visible := False;
      Main_Form.Ferma_Panel.Pages[2].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[3].TabVisible:=False;
      Main_Form.Ferma_Panel.Pages[4].TabVisible:=True;
      if Tok_Graph_Enter_Panel.Visible = False then
      begin
        PanelConstruction.Checked := False;
        Tok_Dock.Visible := False;
      end;
    end;
end;


procedure TMain_Form.TOK_Graph_Enter_PanelStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  Tok_Dock.Visible := true;
end;

procedure TMain_Form.Tok_DockUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  Tok_Dock.Visible := false;
end;

procedure TMain_Form.TOK_Graph_Enter_PanelEndDock(Sender, Target: TObject;
  X, Y: Integer);
begin
  if TOK_Graph_Enter_Panel.Parent = Tok_Dock then
    Tok_Dock.Visible := true else Tok_Dock.Visible := false;
end;



procedure TMain_Form.Ferma_Graph_Enter_PanelEndDock(Sender,
  Target: TObject; X, Y: Integer);
begin
  if Ferma_Graph_Enter_Panel.Parent = Ferma_Dock then
    Ferma_Dock.Visible := true else Ferma_Dock.Visible := false;
end;

procedure TMain_Form.Ferma_Graph_Enter_PanelStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  Ferma_Dock.Visible := true;
end;

procedure TMain_Form.Ferma_DockUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  Ferma_Dock.Visible := false;
end;

procedure TMain_Form.Plast_Graph_Enter_PanelEndDock(Sender,
  Target: TObject; X, Y: Integer);
begin
  if Plast_Graph_Enter_Panel.Parent = Plast_Dock then
    Plast_Dock.Visible := true else Plast_Dock.Visible := false;
end;

procedure TMain_Form.Plast_Graph_Enter_PanelStartDock(Sender: TObject;
  var DragObject: TDragDockObject);
begin
  Plast_Dock.Visible := true;
end;

procedure TMain_Form.Plast_DockUnDock(Sender: TObject; Client: TControl;
  NewTarget: TWinControl; var Allow: Boolean);
begin
  Plast_Dock.Visible := false;
end;

procedure TMain_Form.WithTOKClick(Sender: TObject);
begin
  CalculateF.SetFocus;
end;

procedure TMain_Form.BackClick(Sender: TObject);
begin
      ActiveMDIChild.ClientWidth :=360;
      ActiveMDIChild.ClientHeight:=240;
      If ActiveMDIChild.Top < 0 then ActiveMDIChild.Top := 0;
      If ActiveMDIChild.Left < 0 then ActiveMDIChild.Left := 0;
      ActiveMDIChild.WindowState := wsNormal;
end;

procedure TMain_Form.ListBox1Change(Sender: TObject);
begin
  MDIChildren[ListBox1.ItemIndex].Show();
end;

procedure TMain_Form.PanelTopChange(Sender: TObject);
begin
  case strtoint(PanelTop.Text) of
  3:
  begin
    Ferma_Dock.Align := alNone;
    Plast_Dock.Align := alNone;
    Tok_Dock.Align := alNone;
    Ferma_Dock.Left := 510;
    Ferma_Dock.Top := 0;
    Ferma_Dock.Width := 340;
    Ferma_Dock.Height :=24;
    Plast_Dock.Left := 510;
    Plast_Dock.Top := 0;
    Plast_Dock.Width := 340;
    Plast_Dock.Height :=24;
    Tok_Dock.Left := 510;
    Tok_Dock.Top := 0;
    Tok_Dock.Width := 340;
    Tok_Dock.Height :=24;
    Ferma_Graph_Enter_Panel.Width := 400;
    Ferma_Graph_Enter_Panel.Height := 22;
    Plast_Graph_Enter_Panel.Width := 400;
    Plast_Graph_Enter_Panel.Height := 22;
    Tok_Graph_Enter_Panel.Width := 400;
    Tok_Graph_Enter_Panel.Height := 22;
  end;
  2:
  begin
    Ferma_Dock.Align := alLeft;
    Plast_Dock.Align := alLeft;
    Tok_Dock.Align := alLeft;
    Ferma_Dock.Width := 26;
    Ferma_Dock.Height := 300;
    Plast_Dock.Width := 26;
    Plast_Dock.Height := 300;
    Tok_Dock.Width := 26;
    Tok_Dock.Height :=300;
    Ferma_Graph_Enter_Panel.Width := 26;
    Ferma_Graph_Enter_Panel.Height := 300;
    Plast_Graph_Enter_Panel.Width := 26;
    Plast_Graph_Enter_Panel.Height := 300;
    Tok_Graph_Enter_Panel.Width := 26;
    Tok_Graph_Enter_Panel.Height := 300;
  end;
  1:
  begin
    Ferma_Dock.Align := alRight;
    Plast_Dock.Align := alRight;
    Tok_Dock.Align := alRight;
    Ferma_Graph_Enter_Panel.Width := 26;
    Ferma_Graph_Enter_Panel.Height := 300;
    Plast_Graph_Enter_Panel.Width := 26;
    Plast_Graph_Enter_Panel.Height := 300;
    Tok_Graph_Enter_Panel.Width := 26;
    Tok_Graph_Enter_Panel.Height := 300;
  end;
  0:
  begin
    Ferma_Dock.Align := alBottom;
    Plast_Dock.Align := alBottom;
    Tok_Dock.Align := alBottom;
    Ferma_Graph_Enter_Panel.Width := 400;
    Ferma_Graph_Enter_Panel.Height := 22;
    Plast_Graph_Enter_Panel.Width := 400;
    Plast_Graph_Enter_Panel.Height := 22;
    Tok_Graph_Enter_Panel.Width := 400;
    Tok_Graph_Enter_Panel.Height := 22;
  end;
  end;
end;

procedure TMain_Form.Ferma_PanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Ferma_Panel.Height := 122;
end;

procedure TMain_Form.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MDIChildCount > 0 then
    Ferma_Panel.Height := 32
  else
    Ferma_Panel.Height := 122;
end;

procedure TMain_Form.HideMenuClick(Sender: TObject);
begin
  if Ferma_Panel.Height = 122 then
    Ferma_Panel.Height := 32
  else
    Ferma_Panel.Height := 122;
end;

procedure TMain_Form.Ferma_PanelChange(Sender: TObject);
begin
    Ferma_Panel.Height := 122;
end;

end.
