unit Ferma_M_Anim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Ferma_m, StdCtrls,Ferm_dat, Buttons,Math,IdGlobal,StrUtils,
  Grids;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    RadioButton1: TRadioButton;
    Button1: TButton;
    Ok_Btn: TBitBtn;
    Button2: TButton;
    Panel2: TPanel;
    RadioButton2: TRadioButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    Button4: TButton;
    Areas_Grd: TStringGrid;
    Coord_Grid: TStringGrid;
    Bevel5: TBevel;
    Bevel4: TBevel;
    Image1: TImage;
    Top_label2: TLabel;
    Bevel3: TBevel;
    Type_of_opt_Label: TLabel;
    saveas: TSaveDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    SV_Label: TLabel;
    ISV_Label: TLabel;
    K_before_Label: TLabel;
    StartValue_Edt: TEdit;
    FermWeight_Edt: TEdit;
    K_before_Edit: TEdit;
    PSV_label: TLabel;
    K_after_Label: TLabel;
    PSV_Edit: TEdit;
    K_after_Edit: TEdit;
    Value_Edt: TEdit;
    V_Label: TLabel;
    Label9: TLabel;
    Tol_Label: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure Ok_BtnClick(Sender: TObject);

  private
   fn,ff1:string;
   ff:System.text;
   d1,dd :  System.text;
   s,s_lin,s_for:string;
   region_x,region_y:extended;
   pogr,sv,vm,start_value:extended;
   ITOP: array[1..15,1..2] of integer;                {���O�O��� CTEP�HE�}
   F:    array[1..15] of single;                      {HA�A��H�E ��O�A��}
   COR:  array[1..9,1..2] of single;                  {KOOP��HAT� ���OB}
   MS:   array[1..9,1..2] of integer;                 {�AKPE��EH�� ���OB}
   P:    array[1..18,1..3] of single;                 {HA�P��K�}
   NST:integer;                                       {��C�O CTEP�HE� �EPM�}
   NYZ:integer;                                       {��C�O ���OB}
   NY:integer;                                        {��C�O �AKPE��EH��}
   E:single;                                          {MO���� ��P��OCT�}
   NSN:integer;                                       {��C�O C���AEB HA�P��EH��}
   SD,pltn:single;                                    {�O��CKAEMOE HA�P��EH�E}
   pltnS:string;
    { Private declarations }
  public
  tol2 : array [1..15] of extended;
  tol21 : array [1..15] of extended;
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses Main, Fix_node, ForcNode, SimplRezFerm, FermOptParam,
     FermOptResults, Ferma_FD, FermaForceNode, CoordNode, FermaPivotTol,
     Plast_FD, TOK_FD, selectMetod, RezVC1, FermOptNode,
     FermOptMassa, FermOptNode_Uzel;
{$R *.dfm}



procedure TForm3.BitBtn2Click(Sender: TObject);
 label exit4,exit5;
 var
 i,i1:integer;
 ff2:String;
 rf: TreplaceFlags;// = set of rfIgnoreCase;
 Current_Ferm:TFerm;
 begin
   fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
   AssignFile(d1,fn);
   reset(d1);
   ff1:=ChangeFileExt(fn,'');
   if AnsiContainsStr(fn,'_tmp') then
     ff1:=StringReplace(ff1,'_tmp','_optUZ.frm',rf)
   else
     ff1:=ff1+'_optUZ.frm';
   saveas.FileName:=ff1;
   if saveas.Execute then
     begin
      if saveas.FileName<>ff1 then // ���� ��� �������� �� �������� *
       begin
        ff1:=ChangeFileExt(saveas.FileName,'');
        ff1:=ChangeFileExt(ff1,'.frm');
       end;
   if fileexists(ff1) then begin
     if MessageDlg('���� ��� ����������! ��������?', mtConfirmation, [mbYes, mbNo], 0) = IDYes then
      goto exit4;
     end;

   if not fileexists(ff1) then goto exit4;

   end;
   closefile(d1);
   goto exit5;

exit4:
        Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
        AssignFile(dd,ff1);
        rewrite(dd);
        READln (d1,NST);
        writeln(dd,nst);
        READln (d1,NYZ);
        writeln(dd,nyz);
        READln (d1,NY);
        writeln(dd,ny);
        READln (d1,E);
        if E<>Current_Ferm.e1 then
          writeln(dd,Current_Ferm.e1)
        else
          writeln(dd,e);
        READln (d1,NSN);
        writeln(dd,nsn);
        READln (d1,SD);
        writeln(dd,SD);
        READln (d1,pltn);
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

        //  ������ ��������� �����
        for i:=1 to nyz do
          begin
          readln(d1,cor[i,1]);     // ������ �� ��� ����� - � �� ���������� �� ����� �����������
          readln(d1,cor[i,2]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,1]);
          writeln(dd,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.corn[i,2]);
         end;

      // ������ ������
      for i:=1 to nst do
       begin
        readln(d1,f[i]);
        writeln(dd,f[i]);
       end;

     // ������ ����������� �����
        for i:=1 to nyz do
          begin
          readln(d1,ms[i,1]);
          readln(d1,ms[i,2]);
          writeln(dd,ms[i,1]);
          writeln(dd,ms[i,2]);

         end;

     //  ������ �������� ��������
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
//*** ������ ���� ����
     closefile(dd);
     closefile(d1);
     ShowMessage('���� � ������ ���������� �������� ��� '+ff1);
     close;
     ff2:=ExtractFileName(ChangeFileExt(ff1,''))+'_tmp'+'.frm';
     CopyFileTo(ff1,ff2);
     TFerma_Form.OpenFile(Self,ff2);
Exit5:
 end;


procedure TForm3.Ok_BtnClick(Sender: TObject);
begin
form3.visible:=false;
end;

end.


















