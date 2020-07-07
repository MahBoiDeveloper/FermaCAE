unit vc8Param;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;
type
     MyReal=real;
     TParameters = record
          Start:MyReal;
          a:MyReal;
          b:MyReal;
          p:MyReal;
          Tochn:MyReal;
          Iterac:integer;
          Gold:MyReal;
          Activ:MyReal;
          ZnActiv:MyReal;
          MinDV:MyReal;
          StepGr:MyReal;
          solvetype:byte;
          StepGes:MyReal;
          shema:byte;
     end;
type
  TVC8Form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Xbegin: TEdit;
    a: TEdit;
    b: TEdit;
    p: TEdit;
    Label17: TLabel;
    par1: TEdit;
    par2: TEdit;
    Label18: TLabel;
    par4: TEdit;
    par5: TEdit;
    par6: TEdit;
    par7: TEdit;
    par8: TEdit;
    par9: TComboBox;
    par10: TEdit;
    Label19: TLabel;
    Label20: TLabel;
    par11: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
//    procedure bChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VC8Form: TVC8Form;

implementation

uses Ferma_M, FermOptParam,Main;

{$R *.DFM}

procedure TVC8Form.BitBtn2Click(Sender: TObject);
begin
Close;
end;

procedure TVC8Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
VC8Form:=nil;
end;
function ExecDll(DllName,FileName,material:string;Params:TParameters):integer;
type
     TMethodProc=function(Fn:PChar;material:string;ini_file:string;Params:TParameters):integer;
var
     LibHandle:THandle;
     ini_file:string;
     sp:TMethodProc;
     i:integer;
begin
     Result:=-1;
     LibHandle:=LoadLibrary(PChar(DllName));
     if LibHandle=0 then
     begin
          Beep;
          MessageDlg(#13+'Нет библиотеки '+#39+DllName+#39,mtError,[mbOk],0);
          exit;
     end;
     @sp          :=GetProcAddress(LibHandle,'OptFerm');
     Screen.Cursor:=crHourGlass;
     ini_file     := ExtractFilePath(Application.ExeName); //передаем путь ini-файла с phi
     try
          i            :=sp(PChar(FileName),material,ini_file,Params);
     finally
          Screen.Cursor:=crDefault;
     end;
     Result:=i;
     FreeLibrary(LibHandle);
end;
Function CheckInt(s:String; Var Value:integer):boolean;
Var
     e : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     Val(s,Value,e);
     If e<>0 Then If Value=0 Then e:=1;
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть целым числом больше 0');
          Result:=False
     End
     Else Result:=True
End;
Function CheckReal(s:String; Var Value:MyReal):boolean;
Var
     e    : integer;
     Show : boolean;
Begin
     if Value=0 then Show:=false else Show:=true;
     e:=Pos(',',s);
     If e<>0 Then s[e]:='.';
     Val(s,Value,e);
     If e<>0 Then
     Begin
          if Show then ShowMessage('Это должно быть вещественным числом');
          Result:=False
     End
     Else Result:=True
End;


procedure TVC8Form.BitBtn1Click(Sender: TObject);
var
     i:integer;
     fmi,ebsi:single;
     maxkit:integer;
     material:string;
     S:string;
     Params:TParameters;
     tempstr:MyReal;
     tempint:integer;
begin
     //ShowMessage(Main_Form.ActiveMDIChild.Name);
     if (CheckReal(VC8Form.XBegin.Text,tempstr)) then
     Params.Start:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода начальной точки');
          exit;
     end;

     if (CheckReal(VC8Form.a.Text,tempstr)) then
        Params.a:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода левых границ');
          exit;
     end;
     if (CheckReal(VC8Form.b.Text,tempstr)) then
        Params.b:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода правых границ');
          exit;
     end;
          if (CheckReal(VC8Form.p.Text,tempstr)) then
        Params.p:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода Двойственных переменных');
          exit;
     end;

     if (CheckReal(VC8Form.par1.Text,tempstr)) then
     Params.Tochn:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода точности');
          exit;
     end;

     if (CheckInt(VC8Form.par2.Text,tempint)) then
     Params.Iterac:=tempint
     else
     begin
               ShowMessage('Ошибка ввода числа итераций');
               exit;
     end;

     if (CheckReal(VC8Form.par4.Text,tempstr))then
     Params.Gold:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода мажоранты Голдстейна');
          exit;
     end;

     if (CheckReal(VC8Form.par5.Text,tempstr))then
     Params.Activ:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода параметра выделения активных ограничений');
          exit;
     end;

     if (CheckReal(VC8Form.par6.Text,tempstr)) then
     Params.ZnActiv:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода значения, присваемого двойственным переменным #13 начальные значения которых малы');
          exit;
     end;

     if (CheckReal(VC8Form.par7.Text,tempstr))then
     Params.MinDV:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода:#13 Минимальное значение двойственной переменной , #13 при котором ограничение ещё считается активным');
          exit;
     end;

     if (CheckReal(VC8Form.par8.Text,tempstr))then
     Params.StepGr:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода:#13 Шаг численного вычисления градиента');
          exit;
     end;

     if (CheckInt(VC8Form.par9.Text,tempint))then
     Params.solvetype:=tempint
     else
     begin
          ShowMessage('Ошибка ввода: #13 номер метода численного вычисления градиента');
          exit;
     end;

     if (CheckReal(VC8Form.par10.Text,tempstr))then
     Params.StepGes:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода:#13 Шаг численного вычисления Гессиана');
          exit;
     end;

     if (CheckInt(VC8Form.par11.Text,tempint))then
     Params.shema:=tempint
     else
     begin
          ShowMessage('Ошибка ввода: #13 номер разностной схемы численного вычисления Гессиана');
          exit;
     end;


     with (Main_Form.ActiveMDIChild as TFerma_Form) do
     begin
          if Ferm.nyz1=0 then
          begin
               Beep;
               MessageDlg(chr(13)+'Невозможно рассчитать несуществующую конструкцию!' ,mtError,[mbOk],0);
               exit;
          end;

          if isChanged then FileSave_MnuClick(nil);
          if SaveCancel then exit;
          for i:=1 to Main_Form.Ferma_num_mat+2 do
               if (Main_Form.Ferma_MMaterials[i].MModUpr = Ferm.e1) and
                  (Main_Form.Ferma_MMaterials[i].MDopNapr = Ferm.sd1) then
               begin
                    material := Main_Form.Ferma_MMaterials[i].MName;
               end;
          i:=ExecDll(ExtractFilePath(Application.ExeName)+'vc6.dll',FileName,material,Params);
          //i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'vc2.dll',FileName,material,fmi,ebsi,maxkit);
          Case i of
               0: S:='Матрица жесткости вырождена.';
               1: begin
                    S                             :='Достигнуто предельное число итераций.';
                    Main_Form.toolbutton21.Enabled:=true;
                    OptResults_Mnu.Enabled        :=true;
               end;
               2: begin
                    S                             :='Достигнута заданная точность.';
                    Main_Form.toolbutton21.Enabled:=true;
               end;
          else begin
               S                             :='Произошла внутренняя ошибка. Попробуйте повторить операцию (иногда помогает, хе-хе!)';
               Main_Form.toolbutton21.Enabled:=false;
          end;
          end;
          if i in [0..2] then OptResults_Mnu.Enabled:=true
          else OptResults_Mnu.Enabled := false;;
          MessageDlg(#13+'Расчет закончен. '+S,mtInformation,[mbOk],0);
     end;
     close;
end;

end.
