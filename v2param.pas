unit v2param;

interface

uses
     Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     StdCtrls, Buttons,strfunc;

type
     MyReal=real;
     TParameters = record
          Start:MyReal;
          Tochn:MyReal;
          Iterac:integer;
          solvetype:byte;
          Ves:LongWord;
          FirstStep:MyReal;
          Shtraf:MyReal;
          Bound:MyReal;
          StepDif:MyReal;
          shema:byte;
     end;
     TVC2Form = class(TForm)
               Label1: TLabel;
    par1: TEdit;
               Label2: TLabel;
    par2: TEdit;
               Label3: TLabel;
               Label4: TLabel;
               Label5: TLabel;
               Label6: TLabel;
               Label7: TLabel;
               Label8: TLabel;
               Label9: TLabel;
    par4: TEdit;
    par5: TEdit;
    par6: TEdit;
    par8: TEdit;
               Label10: TLabel;
    par7: TEdit;
               BitBtn1: TBitBtn;
               BitBtn2: TBitBtn;
               par9: TComboBox;
               par3: TComboBox;
               Label11: TLabel;
               XBegin: TEdit;
               procedure BitBtn2Click(Sender: TObject);
               procedure FormClose(Sender: TObject; var Action: TCloseAction);
               procedure BitBtn1Click(Sender: TObject);
          private
               { Private declarations }
          public
               { Public declarations }
     end;

var
     VC2Form: TVC2Form;

implementation
uses Ferma_M, FermOptParam, Main;
{$R *.DFM}

procedure TVC2Form.BitBtn2Click(Sender: TObject);
begin
     Close;
end;

procedure TVC2Form.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Action:=caFree;
     VC2Form:=nil;
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
procedure TVC2Form.BitBtn1Click(Sender: TObject);
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
     if (CheckReal(VC2Form.XBegin.Text,tempstr)) then
     Params.Start:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода начальной точки');
          exit;
     end;

     if (CheckReal(VC2Form.par1.Text,tempstr)) then
     Params.Tochn:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода точности');
          exit;
     end;

     if (CheckInt(VC2Form.par2.Text,tempint)) then
     Params.Iterac:=tempint
     else
     begin
               ShowMessage('Ошибка ввода числа итераций');
               exit;
     end;

     if (CheckInt(VC2Form.par3.Text,tempint))then
     Params.solvetype:=tempint
     else
     begin
          ShowMessage('Ошибка ввода номера способа решения линейных задач');
          exit;
     end;

     if (CheckInt(VC2Form.par4.Text,tempint))then
     Params.Ves:=tempint
     else
     begin
          ShowMessage('Ошибка ввода веса ограничений в условии останова');
          exit;
     end;

     if (CheckReal(VC2Form.par5.Text,tempstr)) then
     Params.FirstStep:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода начального шага');
          exit;
     end;

     if (CheckReal(VC2Form.par6.Text,tempstr))then
     Params.Shtraf:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода коэффициента штрафа');
          exit;
     end;

     if (CheckReal(VC2Form.par7.Text,tempstr))then
     Params.Bound:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода допустимого нарушения штрафа');
          exit;
     end;

     if (CheckReal(VC2Form.par8.Text,tempstr))then
     Params.StepDif:=tempstr
     else
     begin
          ShowMessage('Ошибка ввода шага численного дифференцирования');
          exit;
     end;

     if (CheckInt(VC2Form.par9.Text,tempint))then
     Params.shema:=tempint
     else
     begin
          ShowMessage('Ошибка ввода номера схемы дифференцирования');
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
          i:=ExecDll(ExtractFilePath(Application.ExeName)+'vc2.dll',FileName,material,Params);
          //i:=MoyGemoroy(ExtractFilePath(Application.ExeName)+'vc2.dll',FileName,material,fmi,ebsi,maxkit);
          Case i of
               0: S:='Матрица жесткости вырождена.';
               1: begin
                    S                             :='Достигнуто предельное число итераций.';
                    Main_Form.BitBtn10.Enabled        :=true;
               end;
               2: begin
                    S                             :='Достигнута заданная точность.';
                    Main_Form.BitBtn10.Enabled:=true;
               end;
          else begin
               S                             :='Произошла внутренняя ошибка. Попробуйте повторить операцию (иногда помогает, хе-хе!)';
               Main_Form.BitBtn10.Enabled:=false;
          end;
          end;
          if i in [0..2] then Main_Form.BitBtn10.Enabled:=true
          else Main_Form.BitBtn10.Enabled := false;;
          MessageDlg(#13+'Расчет закончен. '+S,mtInformation,[mbOk],0);
     end;
     close;
end;

end.
