unit visio_pb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons;

type
  mc = array [1..3,1..3] of integer;
  Tvpb = class(TForm)
    ProgressBar1: TProgressBar;
    Edit1: TEdit;
    StaticText3: TStaticText;
    Ok: TBitBtn;
    Panel1: TPanel;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    Edit2: TEdit;
    Bevel2: TBevel;
    StaticText2: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    StaticText1: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText10: TStaticText;
    Edit4: TEdit;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    cb11: TCheckBox;
    cb31: TCheckBox;
    cb21: TCheckBox;
    cb22: TCheckBox;
    cb33: TCheckBox;
    cb23: TCheckBox;
    cb32: TCheckBox;
    cb12: TCheckBox;
    cb13: TCheckBox;
    procedure OkClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure cb11Click(Sender: TObject);
    procedure cb12Click(Sender: TObject);
    procedure cb13Click(Sender: TObject);
    procedure cb21Click(Sender: TObject);
    procedure cb22Click(Sender: TObject);
    procedure cb23Click(Sender: TObject);
    procedure cb31Click(Sender: TObject);
    procedure cb32Click(Sender: TObject);
    procedure cb33Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  vpb: Tvpb;
  mcb:mc;
  k_old:integer;
  procedure fuflo (a:integer);
  procedure matr;

implementation

uses Visio;

{$R *.dfm}


procedure fuflo(a:integer);
var i:integer;
begin
        vpb.StaticText4.Visible:=True;
        vpb.ProgressBar1.Visible:=true;
        vpb.Ok.Visible:=false;
        with vpb.ProgressBar1 do
        begin
                Visible:=True;
                Min:=0;
                Max:=100;
                for i:=0 to 100 do
                begin
                        Position:=i;
                        vpb.StaticText4.Caption:=IntToStr(i)+'%';
                        vpb.Repaint;
                        sleep(a);
                end;
        end;
        sleep(200);
        vpb.ProgressBar1.Visible:=false;
        vpb.StaticText4.Visible:=False;
        vpb.Ok.Visible:=true;
end;

procedure Tvpb.OkClick(Sender: TObject);
var
        i,j,k,z,o,p:integer;
        m:ar1;
        s,s1,s2:string;
        fff,fff2:textfile;
begin
    k:=0;
    for i:=1 to 3 do for j:=1 to 3 do if mcb[i,j]=1 then k:= k+1;
    if k=3 then
    begin
      if Visio_Form.all2_btn.down then
      begin
        with Visio_Form do
        begin
                AssignFile(fff,ChangeFileExt(Fnn,'.ot4'));
                rewrite(fff);
                writeln(fff,ExtractFileName(fnn));
                opt(m2all2,m);
                m2all2:=m;
                for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        writeln(fff,m2all2[i,j].x);
                        writeln(fff,m2all2[i,j].y);
                end;
                CloseFile(fff);
                fuflo(10);
                set_value:=3;
        end;
//        Visio_Form.save_btn.Enabled:=true;
        vpb.close;
      end
      else
      with Visio_Form do
      begin
        DeleteFile(extractfilename(ChangeFileExt(Fnn,'.ot4')));
        if FileExists(extractfilename(ChangeFileExt(Fnn,'.ot1'))) then
        begin
                AssignFile(fff,ChangeFileExt(Fnn,'.ot1'));
                AssignFile(fff2,ChangeFileExt(Fnn,'.ot3'));
                reset(fff);
                rewrite(fff2);
//копируем имя файла
                readln(fff,s);
                writeln(fff2,s);
//подготовка фрагмента (m2opt)
                for i:=1 to n_napr*n_nagr*n_otr do
                begin
                        m[1,i].X:=0;
                        m[1,i].Y:=0;
                        m[2,i].X:=0;
                        m[2,i].Y:=0;
                end;
                for k:=1 to n_napr do for i:=1 to 2 do for j:=1 to n_napr*n_nagr*n_otr do
                begin
                        readln(fff,s);
                        if k=num_value then m[i,j].X:=strToInt(s);
                        readln(fff,s);
                        if k=num_value then m[i,j].Y:=strToInt(s);
                end;
                closeFile(fff);
                reset(fff);
                readln(fff); //считывание имени файла

                opt(m,m2opt);
                m2all:=m2opt; //для сохранения в файл

//копирование fff -> fff2 со вставкой фрагмента
                for k:=1 to n_napr do
                begin
                        for i:=1 to 2 do
                        begin
                                for j:=1 to n_napr*n_nagr*n_otr do
                                begin
                                        if k=num_value then
                                        begin
                                                readln(fff,s);
                                                writeln(fff2,intToStr(m2opt[i,j].X));
                                                readln(fff,s);
                                                writeln(fff2,intToStr(m2opt[i,j].Y));
                                        end
                                        else
                                        begin
                                                readln(fff,s);
                                                writeln(fff2,s);
                                                readln(fff,s);
                                                writeln(fff2,s);
                                        end;
                                end;
                        end;
                end;
                closeFile(fff);
                closeFile(fff2);
                deleteFile(extractfilename(ChangeFileExt(Fnn,'.ot1')));
                renameFile(extractfilename(ChangeFileExt(Fnn,'.ot3')),extractfilename(ChangeFileExt(Fnn,'.ot1')));
        end;
//        set_value:=1;
      end;
      fuflo(0);
      Vpb.Close;
      Visio_Form.opt_btn.Down:=false;
    end
    else
    begin
        messagedlg('Неверный порядок сведения!',mtError,[mbOK],0);
    end;
end;



procedure Tvpb.Edit1Change(Sender: TObject);
var a:integer;
begin
        //проверка значения коэффициента
        try a:=StrToInt(Edit1.text)
        except on EConvertError do
                begin
                        Edit1.text:='0';
                        a:=0;
                end;
        end;
        if a<0 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit1.text:='0';
        end
        else if a>100 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit1.text:='100';
        end
        else
        begin
                Visio_Form.kfc1:=a;
        end;
end;
procedure Tvpb.FormCreate(Sender: TObject);
var i,j:integer;
begin
        k_old:=0;
        Visio_Form.kfc1:=23;
        Visio_Form.kfc2:=23;
        Visio_Form.itr:=2;
        for i:=1 to 3 do for j:=1 to 3 do mcb[i,j]:=0;

end;

procedure Tvpb.Edit2Change(Sender: TObject);
var a:integer;
begin
        //проверка значения коэффициента
        try a:=StrToInt(Edit2.text)
        except on EConvertError do
                begin
                        Edit2.text:='1';
                        a:=1;
                end;
        end;
        if a<1 then
        begin
                messagedlg('Количество итераций должно быть >0',mtError,[mbOK],0);
                Edit2.text:='1';
        end
        else if a>99 then
        begin
//                messagedlg('Слишком много итераций',mtError,[mbOK],0);
                Edit2.text:='1';
        end
        else
        begin
                Visio_Form.itr:=a;
        end;
end;

procedure Tvpb.Edit3Change(Sender: TObject);
var a:integer;
begin
        //проверка значения коэффициента
        try a:=StrToInt(Edit3.text)
        except on EConvertError do
                begin
                        Edit3.text:='0';
                        a:=0;
                end;
        end;
        if a<0 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit3.text:='0';
        end
        else if a>100 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit3.text:='100';
        end
        else
        begin
                Visio_Form.kfc2:=a;
        end;
end;





procedure Tvpb.Edit4Change(Sender: TObject);
var a:integer;
begin
        //проверка значения коэффициента
        try a:=StrToInt(Edit4.text)
        except on EConvertError do
                begin
                        Edit4.text:='0';
                        a:=0;
                end;
        end;
        if a<0 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit4.text:='0';
        end
        else if a>100 then
        begin
                messagedlg('Значение коэффициента 0..100%',mtError,[mbOK],0);
                Edit4.text:='100';
        end
        else
        begin
                Visio_Form.kfc3:=a;
        end;
end;




procedure Tvpb.cb11Click(Sender: TObject);
begin
        if cb11.Checked then mcb[1,1]:=1 else mcb [1,1]:=0;
        matr;
end;

procedure matr;
var i,j,k:integer;
begin
        for i:=1 to 3 do for j:=1 to 3 do if mcb[i,j]=2 then mcb[i,j]:=0;
        for i:=1 to 3 do for j:=1 to 3 do
        begin
                if mcb[i,j]=1 then
                begin
                        for k:=1 to 3 do
                        begin
                                mcb[i,k]:=2;
                                mcb[k,j]:=2;
                        end;
                        mcb[i,j]:=1;
                end;
        end;
        k:=0;
        for i:=1 to 3 do for j:=1 to 3 do if mcb[i,j]=1 then k:=k+1;
        if k_old=1 then if k=2 then for i:=1 to 3 do for j:=1 to 3 do if mcb[i,j]=0 then mcb[i,j]:=1;
        k_old:=k;
        case mcb[1,1] of
        0:      begin
                        vpb.cb11.Enabled:=true;
                        vpb.cb11.Checked:=false;
                end;
        1:      begin
                        vpb.cb11.Enabled:=true;
                        vpb.cb11.Checked:=true;
                end;
        2:      begin
                        vpb.cb11.Enabled:=false;
                        vpb.cb11.Checked:=false;
                end;
        end;

        case mcb[1,2] of
        0:      begin
                        vpb.cb12.Enabled:=true;
                        vpb.cb12.Checked:=false;
                end;
        1:      begin
                        vpb.cb12.Enabled:=true;
                        vpb.cb12.Checked:=true;
                end;
        2:      begin
                        vpb.cb12.Enabled:=false;
                        vpb.cb12.Checked:=false;
                end;
        end;

        case mcb[1,3] of
        0:      begin
                        vpb.cb13.Enabled:=true;
                        vpb.cb13.Checked:=false;
                end;
        1:      begin
                        vpb.cb13.Enabled:=true;
                        vpb.cb13.Checked:=true;
                end;
        2:      begin
                        vpb.cb13.Enabled:=false;
                        vpb.cb13.Checked:=false;
                end;
        end;

        case mcb[2,1] of
        0:      begin
                        vpb.cb21.Enabled:=true;
                        vpb.cb21.Checked:=false;
                end;
        1:      begin
                        vpb.cb21.Enabled:=true;
                        vpb.cb21.Checked:=true;
                end;
        2:      begin
                        vpb.cb21.Enabled:=false;
                        vpb.cb21.Checked:=false;
                end;
        end;

        case mcb[2,2] of
        0:      begin
                        vpb.cb22.Enabled:=true;
                        vpb.cb22.Checked:=false;
                end;
        1:      begin
                        vpb.cb22.Enabled:=true;
                        vpb.cb22.Checked:=true;
                end;
        2:      begin
                        vpb.cb22.Enabled:=false;
                        vpb.cb22.Checked:=false;
                end;
        end;

        case mcb[2,3] of
        0:      begin
                        vpb.cb23.Enabled:=true;
                        vpb.cb23.Checked:=false;
                end;
        1:      begin
                        vpb.cb23.Enabled:=true;
                        vpb.cb23.Checked:=true;
                end;
        2:      begin
                        vpb.cb23.Enabled:=false;
                        vpb.cb23.Checked:=false;
                end;
        end;

        case mcb[3,1] of
        0:      begin
                        vpb.cb31.Enabled:=true;
                        vpb.cb31.Checked:=false;
                end;
        1:      begin
                        vpb.cb31.Enabled:=true;
                        vpb.cb31.Checked:=true;
                end;
        2:      begin
                        vpb.cb31.Enabled:=false;
                        vpb.cb31.Checked:=false;
                end;
        end;

        case mcb[3,2] of
        0:      begin
                        vpb.cb32.Enabled:=true;
                        vpb.cb32.Checked:=false;
                end;
        1:      begin
                        vpb.cb32.Enabled:=true;
                        vpb.cb32.Checked:=true;
                end;
        2:      begin
                        vpb.cb32.Enabled:=false;
                        vpb.cb32.Checked:=false;
                end;
        end;

        case mcb[3,3] of
        0:      begin
                        vpb.cb33.Enabled:=true;
                        vpb.cb33.Checked:=false;
                end;
        1:      begin
                        vpb.cb33.Enabled:=true;
                        vpb.cb33.Checked:=true;
                end;
        2:      begin
                        vpb.cb33.Enabled:=false;
                        vpb.cb33.Checked:=false;
                end;
        end;

end;

procedure Tvpb.cb12Click(Sender: TObject);
begin
        if cb12.Checked then mcb[1,2]:=1 else mcb[1,2]:=0;
        matr;
end;

procedure Tvpb.cb13Click(Sender: TObject);
begin
        if cb13.Checked then mcb[1,3]:=1 else mcb[1,3]:=0;
        matr;
end;

procedure Tvpb.cb21Click(Sender: TObject);
begin
        if cb21.Checked then mcb[2,1]:=1 else mcb[2,1]:=0;
        matr;
end;

procedure Tvpb.cb22Click(Sender: TObject);
begin
        if cb22.Checked then mcb[2,2]:=1 else mcb[2,2]:=0;
        matr;
end;

procedure Tvpb.cb23Click(Sender: TObject);
begin
        if cb23.Checked then mcb[2,3]:=1 else mcb[2,3]:=0;
        matr;
end;

procedure Tvpb.cb31Click(Sender: TObject);
begin
        if cb31.Checked then mcb[3,1]:=1 else mcb[3,1]:=0;
        matr;
end;

procedure Tvpb.cb32Click(Sender: TObject);
begin
        if cb32.Checked then mcb[3,2]:=1 else mcb[3,2]:=0;
        matr;
end;

procedure Tvpb.cb33Click(Sender: TObject);
begin
        if cb33.Checked then mcb[3,3]:=1 else mcb[3,3]:=0;
        matr;
end;

procedure Tvpb.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        Visio_Form.opt_btn.Down:=false;
end;

end.
