unit VC1Form1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
     MyReal=real;
     TParameters = record
          Start:MyReal;
          LBound:MyReal;
          RBound:MyReal;
          Dvoy:MyReal;
          Tochn:MyReal;
          Iterac:integer;
          solvetype:byte;
          Ves:MyReal;
          Napr:MyReal;
          FirstStep:MyReal;
          Shtraf:MyReal;
          StepDif:MyReal;
          shema:byte;
          NumStepPr:integer;
          Podrob:integer;
     end;
  TVC1Form = class(TForm)
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
    XBegin: TEdit;
    LBound: TEdit;
    RBound: TEdit;
    Dvoy: TEdit;
    Par1: TEdit;
    Par2: TEdit;
    par4: TComboBox;
    par5: TEdit;
    par6: TEdit;
    par7: TEdit;
    par8: TEdit;
    par9: TEdit;
    par10: TComboBox;
    par11: TEdit;
    par12: TComboBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ShowForm(ver:byte);
  private
    { Private declarations }
  public
//      procedure ShowForm(ver:byte);
    { Public declarations }
  end;

var
  VC1Form: TVC1Form;
  version:byte;
implementation

uses Main, v2param,strfunc,Ferma_M;

{$R *.DFM}

procedure TVC1Form.ShowForm(ver:byte);
begin
    version:= ver;
    VC1Form.showmodal;
end;
function ExecDll(DllName,FileName,material:string;Params:TParameters):integer;
type
     TMethodProc=function(Fn:PChar;material:string;ini_file:string;Params:TParameters;version:byte):integer;
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
          i            :=sp(PChar(FileName),material,ini_file,Params,version);
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
procedure TVC1Form.BitBtn1Click(Sender: TObject);
var
     i:integer;
//     fmi,ebsi:single;
//     maxkit:integer;
     material:string;
     S:string;
     Params:TParameters;
     tempstr:MyReal;
     tempint:integer;
begin
     if (CheckReal(VC1Form.XBegin.Text,tempstr)) then
     Params.Start:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода начальной точки');
          exit;
     end;
     if (CheckReal(VC1Form.LBound.Text,tempstr)) then
     Params.LBound:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода левой границы');
          exit;
     end;
     if (CheckReal(VC1Form.RBound.Text,tempstr)) then
     Params.RBound:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода правой границы');
          exit;
     end;
     if (CheckReal(VC1Form.Dvoy.Text,tempstr)) then
     Params.Dvoy:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода значений двойственных переменных');
          exit;
     end;
     if (CheckReal(VC1Form.par1.Text,tempstr)) then
     Params.Tochn:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода точности');
          exit;
     end;

     if (CheckInt(VC1Form.par2.Text,tempint)) then
     Params.Iterac:=tempint
     else
     begin
               ShowMessage('Ошибка ввода числа итераций');
               exit;
     end;

     if (CheckInt(VC1Form.par4.Text,tempint))then
     Params.solvetype:=tempint
     else
     begin
          ShowMessage('Ошибка ввода номера версии метода');
          exit;
     end;
     if (CheckReal(VC1Form.par5.Text,tempstr))then
     Params.Ves:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода веса ограничений в условии останова');
          exit;
     end;
     if (CheckReal(VC1Form.par6.Text,tempstr)) then
     Params.Napr:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода параметра для выбора направления движения');
          exit;
     end;
     if (CheckReal(VC1Form.par7.Text,tempstr)) then
     Params.FirstStep:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода начального шага');
          exit;
     end;

     if (CheckReal(VC1Form.par8.Text,tempstr))then
     Params.Shtraf:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода допустимого нарушения ограничений');
          exit;
     end;

     if (CheckReal(VC1Form.par9.Text,tempstr))then
     Params.StepDif:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода шага численного дифференцирования');
          exit;
     end;

     if (CheckInt(VC1Form.par10.Text,tempint))then
     Params.shema:=tempint
     else
     begin
          ShowMessage('Ошибка ввода номера схемы дифференцирования');
          exit;
     end;
     if (CheckInt(VC1Form.par11.Text,tempint))then
     Params.NumStepPr:=tempint
     else
     begin
          ShowMessage('Ошибка ввода числа шагов для вывода информации');
          exit;
     end;
     if (CheckInt(VC1Form.par12.Text,tempint))then
     Params.Podrob:=tempint
     else
     begin
          ShowMessage('Ошибка ввода степени подробности информации');
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
          i:=ExecDll(ExtractFilePath(Application.ExeName)+'vc1.dll',FileName,material,Params);
          //i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'vc2.dll',FileName,material,fmi,ebsi,maxkit);
          if i in [0..2] then
            begin
              N8.Enabled:=true;
              N10.Enabled:=true;
              last_opt_type:=1;
            end
          else N10.Enabled := false;;
          MessageDlg(#13+'Расчет закончен. '+S,mtInformation,[mbOk],0);
     end;
     close;
end;


procedure TVC1Form.BitBtn2Click(Sender: TObject);
begin
    Close;
end;

procedure TVC1Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
     VC1Form:=nil;
end;

end.
