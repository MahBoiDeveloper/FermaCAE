unit RezVC1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons,Ferma_M, Ferm_Dat;

type
  TFermaRezVC1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    StringGrid1: TStringGrid;
    Label5: TLabel;
    Edit5: TEdit;
    Edit2: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit6: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    StringGrid2: TStringGrid;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(fn:string;fn1:string);
  end;

var
  FermaRezVC1: TFermaRezVC1;

implementation

uses Main;



{$R *.DFM}

procedure TFermaRezVC1.Execute;
var
    mg : integer;
    str: string;
    ff:System.text;
    it,n,i:integer;
    pog,ves,x:real;
    current_ferm:TFerm;
    sg:real;
Begin
   // ShowMessage(fn);
    AssignFile(ff,fn);
    reset(ff);
    mg:=filesize(ff);
    Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
    if mg<>0 then
    begin
        readln(ff,str);
        FermaRezVC1.Edit5.Text:=str;
        readln(ff,n);
        readln(ff,it);
        FermaRezVC1.Edit1.Text:=IntToStr(it);
        readln(ff,pog);
        FermaRezVC1.Edit2.Text:=FormatFloat('0.000e+00',pog);
        FermaRezVC1.StringGrid1.Cells[0,0]:='Номер';
        FermaRezVC1.StringGrid1.Cells[1,0]:='Полученная площадь';
        FermaRezVC1.StringGrid1.RowCount:=n+1;
        sg:=0;
        for i:=1 to n do
        begin
            readln(ff,x);
            FermaRezVC1.StringGrid1.Cells[0,i]:=IntToStr(i);

            FermaRezVC1.StringGrid1.Cells[1,i]:=FormatFloat('0.000e+00',x);
         //   sg:=sg+
        end ;
        readln(ff,ves);
        FermaRezVC1.Edit4.Text:=FormatFloat('000.000e+00',ves);
        readln(ff,sg);
        FermaRezVC1.Edit3.Text:=FormatFloat('000.000e+00',sg);
    end;
    CloseFile(ff);
    AssignFile(ff,fn1);
    reset(ff);
    mg:=filesize(ff);
    if mg<>0 then
    begin
          readln(ff,str);
        FermaRezVC1.Edit10.Text:=str;
        readln(ff,n);
        readln(ff,it);
        FermaRezVC1.Edit6.Text:=IntToStr(it);
        readln(ff,pog);
        FermaRezVC1.Edit7.Text:=FormatFloat('0.000e+00',pog);
        FermaRezVC1.StringGrid2.Cells[0,0]:='Номер';
        FermaRezVC1.StringGrid2.Cells[1,0]:='Полученная площадь';
        FermaRezVC1.StringGrid2.RowCount:=n+1;
        for i:=1 to n do
        begin
            readln(ff,x);
            FermaRezVC1.StringGrid2.Cells[0,i]:=IntToStr(i);

            FermaRezVC1.StringGrid2.Cells[1,i]:=FormatFloat('0.000e+00',x);
        end ;
        readln(ff,ves);
        FermaRezVC1.Edit9.Text:=FormatFloat('000.000e+00',ves);
        readln(ff,sg);
        FermaRezVC1.Edit8.Text:=FormatFloat('000.000e+00',sg);
    end;
    CloseFile(ff);
    ShowModal;
end;


end.
