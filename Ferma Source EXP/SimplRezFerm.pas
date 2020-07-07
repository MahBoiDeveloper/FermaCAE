unit SimplRezFerm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids,Math,Main, Ferma_M, Menus,
  ImgList;

type
  TSimpleFermResult_Form = class(TForm)
    Napr_Image: TImage;
    Moves_Image: TImage;
    VisioBox: TGroupBox;
    Param_Grd: TStringGrid;
    visio: TLabel;
    zag4: TLabel;
    zag3: TLabel;
    zag5: TLabel;
    gbParams: TGroupBox;
    DopNapr_Label: TLabel;
    V_Label: TLabel;
    Tok_Label: TLabel;
    Gs_Label: TLabel;
    Label1: TLabel;
    M_label: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image8: TImage;
    Dopnapr_sg_label: TLabel;
    MaxTension_Edt: TEdit;
    Volume_Edt: TEdit;
    FermWeight_Edt: TEdit;
    TOKWeight_Edt: TEdit;
    ves_to_tok: TEdit;
    Mass_edt: TEdit;
    MaxTension_SG_Edt: TEdit;
    gbDop: TGroupBox;
    imL: TImage;
    lambda_edit: TEdit;
    Button1: TButton;
    gbXY: TGroupBox;
    lMoveX: TLabel;
    lMoveY: TLabel;
    Param_Grd2: TStringGrid;
    lNodesXY: TLabel;
    lTitle: TLabel;
    zag1: TButton;
    lTmp: TLabel;
    pmParam_Grd: TPopupMenu;
    mi0: TMenuItem;
    mi1: TMenuItem;
    ilColors: TImageList;
    mi2: TMenuItem;
    mi3: TMenuItem;
    mi4: TMenuItem;
    mi5: TMenuItem;
    mi6: TMenuItem;
    mi7: TMenuItem;
    ColorDialog: TColorDialog;
    CheckBox1: TCheckBox;
    Ok_Btn: TBitBtn;
    peremBox: TCheckBox;
    ColorBox: TCheckBox;
    Button2: TButton;
    procedure Moves_BtnClick(Sender: TObject);
    procedure Sn_CBxChange(Sender: TObject);
    procedure FormStart;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Ok_BtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ColorBoxClick(Sender: TObject);
    procedure DrawCell2(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure zag1Click(Sender: TObject);
    procedure peremBoxClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure mi0Click(Sender: TObject);
    procedure chbZag2Click(Sender: TObject);


  private
    { Private declarations }
    nst,nyz:integer;
    sd:extended;
    p:array[1..9,1..2,1..3] of extended; // перемещения
    ps:array[1..15,1..3] of extended;    // напряжения
    tol:array[1..15] of extended;        // потребные площади
    NumOk:boolean; //Была ли включена нумерация ??
    kmin:array[0..100] of integer;       // потребные площади

    MinSafetyFactorColor, // min коэффициент запаса прочности
    MaxPressureColor,   // максимальные напряжения
    MinPressureColor,  // минимальные напряжения
    SafetyFactorColor, // коэффициент запаса прочности
    CoreAreaColor, // Площади стержней
    InertiaColor,  // моменты инерции
    MaxMovingXColor, // максимальные перемещения по X
    MaxMovingYColor  // максимальные перемещения по Y

              : TColor;

    pLabels,
    pImages,
    pValues   : TList;
    procedure SetBmpColor( aIndex:integer;
                           aColor : TColor;
                           const aCaption : string );
  public
   Max_I_Cells: array[1..20,1..2] of integer;
    { Public declarations }
    procedure Execute(fn:string);
    procedure GridClean(Sender: TObject);

  end;

var
  SimpleFermResult_Form: TSimpleFermResult_Form;
  projectname:string;
  max_cells,max_moves_X,max_moves_Y:array[1..20,1..2] of integer;
  min_cells,Max_S_Cells : array[1..20,1..2] of integer;
  min_K_cells:array[1..60,1..2] of integer;
  K_cells:array[1..60,1..2] of integer;
  Sgim_cells:array[1..20,1..3] of integer;
  start_S: array[1..20] of extended;
  end_S : array[1..20,1..3] of extended;
  node_cords: array[1..20,1..20] of extended;
  sd_sg: extended;
  li: array[1..15] of extended;
  fi:array [0..220] of single;
  flag2:boolean;
  nsn:integer;
  tok_name:string;
  project_changed,lastwaswithouttok:boolean;
  implementation

uses Ferma_FD, Ferm_Dat, FermOptResults;

{$R *.DFM}

var ans : string;
Function  AnsiUpCase( ch : char ) : char;
begin
     ans := ch;
     ans := AnsiUpperCase( ans );
     AnsiUpCase := ans[1];
end;

Function  AnsiPos    ( const SubStr, S : string ) : integer;
begin
     result := SysUtils.AnsiPos( AnsiUpperCase(SubStr), AnsiUpperCase(S) );
end;

Function  AnsiLoCase( ch : char ) : char;
begin
     ans := ch;
     ans := AnsiLowerCase( ans );
     AnsiLoCase := ans[1];
end;

Function  ChangeChar( const s:string; Ch, newCh : Char ) : string;
var  i:integer; ci, un,ln:char; uc:boolean; ws:string;
begin
     ws := s;
     un := AnsiUpCase( newCh );
     ln := AnsiLoCase( newCh );
     for i:=1 to length( ws ) do begin
         ci := ws[i];
         if ci = AnsiUpCase(ci) then uc := true
                                else uc := false;
         if AnsiUpCase( ci ) = AnsiUpCase( ch ) then begin
            if uc then ws[i] := un
                  else ws[i] := ln;
         end;
     end;
     ChangeChar := ws;
end;

function ModifyColor( BaseColor : TColor; DColor : integer ) : TColor;
     function mc( c:byte ):byte;
     begin
          if (c+DColor)<0 then begin
              result := 0;
              exit;
          end;
          if (c+DColor)>255 then begin
              result := 255;
              exit;
          end;
          result := c+DColor;
     end;
var  r,g,b:byte;

begin
     result := BaseColor;
     r      := mc( GetRvalue(BaseColor) );
     g      := mc( GetGvalue(BaseColor) );
     b      := mc( GetBvalue(BaseColor) );
     result := RGB( r, g, b );
end;

procedure TSimpleFermResult_Form.GridClean(Sender: TObject);
var
  hGridRect: TGridRect;
begin
  hGridRect.Top := -1;
  hGridRect.Left := -1;
  hGridRect.Right := -1;
  hGridRect.Bottom := -1;
  (Sender as TStringgrid).Selection := hGridRect;
end;
procedure TSimpleFermResult_Form.mi0Click(Sender: TObject);
var  mi:TMenuItem; i:integer; c:TColor;
begin
     for i:=0 to self.pmParam_Grd.Items.Count - 1 do begin
         mi := pmParam_Grd.Items[i];
         if  mi=Sender then begin
             if  ColorDialog.Execute then begin
                 self.SetBmpColor( i, ColorDialog.Color, ''  );
                 self.Param_Grd .Invalidate;
                 self.Param_Grd2.Invalidate;
             end;
             exit;
         end;
     end;
end;

// Функция расчета Fi представленная полиномом.
Function GetFi(x:integer):extended;
var y,A,B,C,D,E,F:single;
begin

if ((x>=0)and(X<=220)and((x mod 10)=0)) then getFi:=fi[x]
else
   begin
    A:=9.91145807975045E-0001;
    B:=1.16208370729964E-0003;
    C:=-2.74037612808975E-0004;
    D:=2.85629417468708E-0006;
    E:=-1.13690883172656E-0008;
    F:=1.60860812903468E-0011;
    y:=A+B*x+C*x*x+D*x*x*x+E*x*x*x*x+F*x*x*x*x*x;
    GetFi:=y;
    end;
end;
function My_strtofloat(s:string):extended;
begin
if s ='#######'then s:='-1';
My_strtofloat:=strtofloat(s);

end;

procedure TSimpleFermResult_Form.Execute(fn:string);
var
  ff:System.text;
  ny:integer;
  e1,f,tok,vm:extended;
  i,j,ii,ms,i1,i2:integer;
  s_lin, s_for, s_tok, tok_error, tok_s_lin, tok_s_for:string;
  tok_weight:extended;
  flag,error:boolean;
  begin
  if ((projectname = fn)and(not lastwaswithouttok)) then project_changed:=false
  else project_changed:=true;

  if Main_Form.WithTOK.Checked=false then lastwaswithouttok:=true
  else lastwaswithouttok:=false;

  projectname:=fn;
  error:=true;
  if fileexists(changefileext(projectname,'.out')) then begin s_tok:=changefileext(projectname,'.out');error:=false;end
  else if fileexists(changefileext(projectname,'.oup')) then begin s_tok:=changefileext(projectname,'.oup');error:=false;end;
    if Main_Form.WithTOK.Checked=true then   //Checked = true - с запросом, = false - без запроса
      begin
        error:=False;
        s_tok:=Main_Form.TOK_OpenDialog.FileName;
        if s_tok = '' then
        begin
          MessageDLG('Отсутствует файл ТОК', mterror, [mbOK], 0);
          exit;
        end;
        tok_name:=s_tok
      end
    else
      begin
        s_tok:=tok_name;
        error:=error;
  end;


  tok_s_lin:='';
  tok_s_for:='';
  if not error then  //Смотрим ли силовой вес ТОК?
    begin
      AssignFile(ff,s_tok);
      reset(ff);
      ReadLn(ff);
      ReadLn(ff,tok_error);
      ReadLn(ff,tok_weight);
      ReadLn(ff,tok_s_lin);
      ReadLn(ff,tok_s_for);
      CloseFile(ff);
    end;

  AssignFile(ff,fn);
  Reset(ff);
  readln(ff);// Считывание строки для проверки совместимости версий
  readln(ff,nst);
  readln(ff,nyz);
  readln(ff,ny);
  readln(ff,e1);
  readln(ff,nsn);
  readln(ff,sd);
  readln(ff); //readln(ff);
  for i:=1 to nst do
    readln(ff,ms); {Tопология}
  readln(ff); //readln(ff);
  for i:=1 to nyz do
    readln(ff,node_cords[i,1],node_cords[i,2]);{Координаты}
//    readln(ff,f,f);

  readln(ff); //readln(ff);
  for i:=1 to nst do
    readln(ff,start_S[i]);  {Нач. площади}

  readln(ff); //readln(ff);
  for i:=1 to nyz do
    readln(ff,ms); {Закрепления}
  readln(ff); //readln(ff);

  for i:=1 to nsn do   {Нагрузки}
    begin
      //readln(ff);
      for i1:=1 to nyz*2 do readln(ff,fn);
    end;
  readln(ff,s_lin); readln(ff,s_for);
  readln(ff);
  readln(ff,tok);

  for i:=1 to 3 do readln(ff);
  for i:=1 to nst do readln(ff,li[i]);  //Длины стержней
  readln(ff); //readln(ff);
  for i:=1 to nsn do    //  Перемещения узлов
    for ii:=1 to nyz do
      begin
        read(ff,p[ii,1,i]);
        readln(ff,p[ii,2,i]);
      end;

  readln(ff);
  //readln(ff);

  for i2:=1 to nsn do  // напряжения в стержнях
    begin
      for ii:=1 to nst do read(ff,ps[ii,i2]);
      readln(ff);
    end;

  readln(ff);
  readln(ff);

  for ii:=1 to nst do  read(ff,tol[ii]);
  CloseFile(ff);

  vm:=0;
  for i:=1 to nst do vm:=vm+li[i]*tol[i];

  //  А теперь отобразим все это
  if not Error then TOK_Label.Caption:='Силовой вес ТОК ['+tok_s_for+'*'+tok_s_lin+']'
   else TOK_Label.Caption:='Силовой вес ТОК';
  MaxTension_Edt.Text:=FormatFloat('0.000e+00',sd);
  MaxTension_SG_Edt.Text:='нет данных';
//  Volume_Edt.Text:=format('%10.7g',vm);
  FermWeight_Edt.Text:=formatFloat('0.000e+00',tok);
  if Error then TOKWeight_Edt.Text:='Нет данных'
    else TOKWeight_Edt.Text:=formatFloat('0.000e+00',tok_weight);
  if Error then ves_to_tok.Text:='Нет данных'
    else ves_to_tok.Text:=formatFloat('0.000e+00',tok/tok_weight);
fi[0]:=1.00;
fi[10]:=0.977;
fi[20]:=0.910;
fi[30]:=0.830;
fi[40]:=0.758;
fi[50]:=0.676;
fi[60]:=0.588;
fi[70]:=0.470;
fi[80]:=0.359;
fi[90]:=0.287;
fi[100]:=0.235;
fi[110]:=0.197;
fi[120]:=0.167;
fi[130]:=0.145;
fi[140]:=0.126;
fi[150]:=0.110;
fi[160]:=0.099;
fi[170]:=0.089;
fi[180]:=0.081;
fi[190]:=0.073;
fi[200]:=0.067;
fi[210]:=0.062;
fi[220]:=0.057;

  for i:=1 to nsn do
    Moves_BtnClick(Self);

  // Сделаем вывод
//  flag:=true;
{  for i:=1 to nsn do
    for ii:=1 to nst do
       flag:=flag and (abs(ps[ii,i])<sd);
  if flag then Conclusion_Memo.Text:='Конструкция выдержит данные нагрузки'
          else Conclusion_Memo.Text:='К сожалению, ферма разрушится';}
if SimpleFermResult_form.tag = 0 then Show{ my fucking comment Modal};
if SimpleFermResult_form.tag = 1 then
        begin
        formstart;
        OK_btn.Click;
        end;



end;



procedure TSimpleFermResult_Form.Moves_BtnClick(Sender: TObject);
var
  i,k,sn:integer;
  MinV,MaxV,MaxX,MaxY:extended;
  j:integer;
  MaxCol,MaxRow,MinCol,MinRow:integer;
  begin
  //  Перемещения
   begin

    Visio.Caption:='Перемещения узлов';
    MaxTension_SG_Edt.Text:='нет данных';
    Button1.enabled:=false;
    //checkbox1.Enabled:=false;
    lambda_edit.Enabled:=false;

    with Param_Grd2 do
      begin
          param_grd2.colcount:=9;
        RowCount:=nyz+1;
        if nyz > 0 then
         begin
          FixedRows:=1;
          FixedCols:=1;
         end
        else
         begin
          FixedCols:=0;
          FixedRows:=0;
         end;
        Cells[0,0]:='№';
        Cells[1,0]:='       X';
        Cells[2,0]:='       Y';
        Cells[3,0]:=' Случай 1';
        Cells[4,0]:=' Случай 2';
        Cells[5,0]:=' Случай 3';
        Cells[6,0]:=' Случай 1';
        Cells[7,0]:=' Случай 2';
        Cells[8,0]:=' Случай 3';

        MaxV:=0.0;
        MinV:=9999999;
        for j:=1 to nyz do
           begin
           MaxV:=Max(MaxV,node_Cords[j,1]);
           MinV:=Min(MinV,node_cords[j,1]);
           end;
       maxX:=MaxV-MinV;
        MaxV:=0;
        MinV:=9999999;
        for j:=1 to nyz do
           begin
           MaxV:=Max(MaxV,node_Cords[j,2]);
           MinV:=Min(MinV,node_cords[j,2]);
           end;
       maxY:=MaxV-MinV;

        for i:=1 to nyz do
        begin
          Cells[0,i]:=IntToStr(i);
          for j:=1 to nsn do
           begin
            Cells[1,i]:=formatFloat('0.00e+00',Node_cords[i,1]);
            Cells[2,i]:=formatFloat('0.00e+00',Node_cords[i,2]);
          if (peremBox.checked = false) then
            begin
            Cells[j+2,i]:=formatFloat('0.00e+00',p[i,1,j]);
            Cells[j+2+3,i]:=formatFloat('0.00e+00',p[i,2,j]);
            lMoveX.Caption:='Перемещения по Х ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
lMoveY.Caption:='Перемещения по У ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
            end
          else
            begin
            Cells[j+2,i]:=formatFloat('0.00', SimpleRoundTo((p[i,1,j]/maxX)*100)  )+'%';
            Cells[j+2+3,i]:=formatFloat('0.00',SimpleRoundTo((p[i,2,j]/maxY)*100)  )+'%';
            lMoveX.Caption:='Перемещения по Х [%]';
            lMoveY.Caption:='Перемещения по У [%]';
            end;
           end;
              for k:=nsn+1 to 3 do
              begin
              Cells[2+k,i]:='#######';
              Cells[2+k+3,i]:='#######';
              end

        end;


      end;


     //Ищем Максимальные перемещения (по модулю) по X
  if peremBox.Checked = false then
  for i:=1 to nyz do
  with Param_grd2 do
      begin
    if (Cells[4,i]<>'#######')and(Cells[3,i]<>'#######')and(abs(strtofloat(Cells[4,i]))>abs(strtofloat(Cells[3,i]))) then
       if (Cells[5,i]<>'#######')and(abs(strtofloat(Cells[5,i]))>(abs(strtofloat(Cells[4,i])))) then
           MaxCol:=5
         else
           MaxCol:=4
   else
        if (Cells[5,i]<>'#######')and(Cells[3,i]<>'#######')and(abs(strtofloat(Cells[5,i]))>(abs(strtofloat(Cells[3,i])))) then
         MaxCol:=5
          else
         MaxCol:=3;

     MaxRow:=i;
  if (Cells[Maxcol,i]<>'#######')and(strtofloat(Cells[Maxcol,i])<>0) then
           begin
   max_moves_X[i,1]:=Maxcol;
   max_moves_X[i,2]:=Maxrow;
           end
        else
           begin
   max_moves_X[i,1]:=-1;
   max_moves_X[i,2]:=-1;
           end;
      end;

       //Ищем Максимальные перемещения (по модулю) по Y
 if peremBox.Checked = false then
  for i:=1 to nyz do
  with Param_grd2 do
      begin
    if (Cells[7,i]<>'#######')and(Cells[6,i]<>'#######')and(abs(strtofloat(Cells[7,i]))>abs(strtofloat(Cells[6,i]))) then
       if (Cells[8,i]<>'#######')and(abs(strtofloat(Cells[8,i]))>(abs(strtofloat(Cells[7,i])))) then
           MaxCol:=8
         else
           MaxCol:=7
   else
        if (Cells[8,i]<>'#######')and(Cells[6,i]<>'#######')and(abs(strtofloat(Cells[8,i]))>(abs(strtofloat(Cells[6,i])))) then
         MaxCol:=8
          else
         MaxCol:=6;

     MaxRow:=i;
  if (Cells[Maxcol,i]<>'#######')and(strtofloat(Cells[Maxcol,i])<>0) then
           begin
   max_moves_Y[i,1]:=Maxcol;
   max_moves_Y[i,2]:=Maxrow;
           end
        else
           begin
   max_moves_Y[i,1]:=-1;
   max_moves_Y[i,2]:=-1;
           end;
      end;





  end;


// Напряжения
   begin
    param_grd.colcount:=15;
    napr_image.visible:=true;

    Button1.enabled:=true;
    checkbox1.Enabled:=true;
    lambda_edit.Enabled:=true;

    with Param_Grd do
      begin
        RowCount:=nst+1;

        Cells[0,0]:='№';
        Cells[1,0]:='';
        Cells[2,0]:=' Случай 1';
        Cells[3,0]:=' Случай 2';
        Cells[4,0]:=' Случай 3';
        Cells[5,0]:=' Случай 1';
        Cells[6,0]:=' Случай 2';
        Cells[7,0]:=' Случай 3';
        Cells[8,0]:=' Случай 1';
        Cells[9,0]:=' Случай 2';
        Cells[10,0]:=' Случай 3';
        Cells[11,0]:=' Случай 1';
        Cells[12,0]:=' Случай 2';
        Cells[13,0]:=' Случай 3';
        Cells[14,0]:='№';


        for i:=1 to nst do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[14,i]:=IntToStr(i);
            Cells[1,i]:=formatFloat('0.000e+00',start_S[i]);
            for j:=1 to nsn do
               begin
            if flag2 = false then Cells[j+1,i]:=formatFloat('0.00e+00',ps[i,j])
            else Cells[j+1,i]:=formatFloat('0.00e+00',(ps[i,j]*start_S[i]));

                end;

           for j:=nsn+1 to 3 do
                begin
            Cells[j+1,i]:='#######';
            Cells[j+1,i]:='#######';
            Cells[j+1,i]:='#######';
                end;
            for j:=1 to nsn do
               begin
            if (ps[i,j])=0 then Cells[4+j,i]:='#######'
            else Cells[4+j,i]:=formatFloat('0.00e+00',Abs(sd/ps[i,j]));
                           end;

            for j:=nsn+1 to 3 do
               begin
               Cells[4+j,i]:='#######';
               end;

                 for j:=1 to nsn do
                 with Param_grd do
                   Cells[j+7,i]:=formatFloat('0.00e+00',abs(ps[i,j]*start_S[i]/sd));


                 for j:=nsn+1 to 3 do
                 with Param_grd do
                   Cells[j+7,i]:='#######';
{                 for j:=1 to nsn do
                 with Param_grd do
                   Cells[j+7,i]:='';
                 for j:=nsn+1 to 3 do
                 with Param_grd do
                   Cells[j+7,i]:='';       }



                 for j:=1 to 3 do
                 with Param_grd do
                   Cells[j+10,i]:='#######'
          end;

      end;




   // Ищем максимальные и минимальые значения в ячейках по строкам и
//запоминаем их номера

  //Максимальные
  for i:=1 to nst do
  with Param_grd do
      begin
    if (Cells[3,i]<>'#######')and(Cells[2,i]<>'#######')and((strtofloat(Cells[3,i]))>(strtofloat(Cells[2,i]))) then
       if (Cells[4,i]<>'#######')and(strtofloat(Cells[4,i])>(strtofloat(Cells[3,i]))) then
           MaxCol:=4
         else
           MaxCol:=3
   else
        if (Cells[4,i]<>'#######')and(Cells[2,i]<>'#######')and(strtofloat(Cells[4,i])>(strtofloat(Cells[2,i]))) then
         MaxCol:=4
          else
         MaxCol:=2;

     MaxRow:=i;
  if strtofloat(Cells[Maxcol,i])<>0 then
           begin
   max_cells[i,1]:=Maxcol;
   max_cells[i,2]:=Maxrow;
           end
        else
           begin
   max_cells[i,1]:=-1;
   max_cells[i,2]:=-1;
           end;
      end;

    //Минимальные

       for i:=1 to nst do
       with param_grd do
      begin
    if (Cells[3,i]<>'#######')and(Cells[2,i]<>'#######')and(strtofloat(Cells[3,i])<(strtofloat(Cells[2,i]))) then
       if (Cells[4,i]<>'#######')and(strtofloat(Cells[4,i])<(strtofloat(Cells[3,i]))) then
           MinCol:=4
         else
           MinCol:=3
   else
        if (Cells[2,i]<>'#######')and(Cells[4,i]<>'#######')and(strtofloat(Cells[4,i])<(strtofloat(Cells[2,i]))) then
         MinCol:=4
          else
         MinCol:=2;
   MinRow:=i;
       if strtofloat(Cells[Mincol,i])<0 then
           begin
   min_cells[i,1]:=Mincol;
   min_cells[i,2]:=Minrow;
           end
        else
           begin
   min_cells[i,1]:=-1;
   min_cells[i,2]:=-1;
           end;
      end;
   //Все Сжимающие
     for i:=1 to nst do
      for j:=1 to 3 do
            if (param_grd.Cells[j+1,i]<>'#######')and(strtofloat(Param_grd.Cells[j+1,i])<0) then  Sgim_cells[i,j]:=j
            else Sgim_cells[i,j]:=-1;




  //обрабатываем случаи сжатия
if ((strtoint(lambda_edit.text)<50)or(strtoint(lambda_edit.text)>220))
   then
      begin
      MessageDlg('Недопустимое значение', mtError,
      [mbOk],0);
      lambda_edit.text:='50';
      end;
//edit1.Text:=floattostr(GetFi(strtofloat(lambda_edit.text)));

 sd_sg:=sd*GetFi(strtoint(lambda_edit.text));
 //if checkbox1.Checked=true then
    begin
      MaxTension_Edt.Text:=FormatFloat('0.000e+00',sd);
  MaxTension_SG_Edt.Text:=FormatFloat('0.000e+00',sd_sg);

          for i:=1 to nst do
          for j:=1 to 3 do
          with Param_grd do
          begin
  if (Sgim_cells[i,j]<>-1) then
             begin

Cells[Sgim_cells[i,j]+4,i]:=formatFloat('0.00e+00',Abs(sd_sg/ps[i,j]));

Cells[Sgim_cells[i,j]+7,i]:=formatFloat('0.00e+00',abs(ps[i,j]*start_S[i])/sd_sg);

Cells[Sgim_cells[i,j]+10,i]:=formatFloat('0.00e+00',(abs(ps[i,j]*start_S[i])/sd_sg)*(li[i]/strtofloat(lambda_edit.text))*(li[i]/strtofloat(lambda_edit.text)));
             end;

          end;
     end;
  {else
    begin
  MaxTension_Edt.Text:=FormatFloat('0.000e+00',sd);
  MaxTension_SG_Edt.Text:='нет данных';

    end;                                 }    //Samoylenko

       //коэффециенты запаса прочности меньше 1
   k:=0;
   for i:=1 to nst do
   for j:=5 to 7 do
   with param_grd do
      begin
  if (Cells[j,i]<>'#######')and((strtofloat(Cells[j,i])<1)) then
        begin
  inc(k);
  min_K_cells[k,1]:=j;
  min_K_cells[k,2]:=i;
        end;
      end;

      for i:=k+1 to 60 do
        begin
        min_K_cells[i,1]:=-1;
        min_K_cells[i,2]:=-1;
        end;
     //коэффециенты запаса прочности отличается от 1 не более чем на 5%
   k:=0;
   for i:=1 to nst do
   for j:=5 to 7 do
   with param_grd do
      begin
  if (Cells[j,i]<>'#######')and(abs(strtofloat(Cells[j,i])-1)<0.06) then
        begin
  inc(k);
  K_cells[k,1]:=j;
  K_cells[k,2]:=i;
        end;
      end;

      for i:=k+1 to 60 do
        begin
        K_cells[i,1]:=-1;
        K_cells[i,2]:=-1;
        end;

               //Максимальные  площади стержней
  for i:=1 to nst do
  with Param_grd do
      begin
    if ((My_strtofloat(Cells[9,i]))>(My_strtofloat(Cells[8,i]))) then
       if (My_strtofloat(Cells[10,i])>(My_strtofloat(Cells[9,i]))) then
           MaxCol:=10
         else
           MaxCol:=9
   else
        if (My_strtofloat(Cells[10,i])>(My_strtofloat(Cells[8,i]))) then
         MaxCol:=10
          else
         MaxCol:=8;

     MaxRow:=i;
  if strtofloat(Cells[Maxcol,i])<>0 then
           begin
   max_S_cells[i,1]:=Maxcol;
   max_S_cells[i,2]:=Maxrow;
           end
        else
           begin
   max_S_cells[i,1]:=-1;
   max_S_cells[i,2]:=-1;
           end;
      end;


                   //Максимальные  Моменты инерции
  for i:=1 to nst do
  with Param_grd do
      begin
    if (My_strtofloat(Cells[13,i]))>(My_strtofloat(Cells[12,i])) then
       if (My_strtofloat(Cells[13,i])>(My_strtofloat(Cells[11,i]))) then
           MaxCol:=13
         else
           MaxCol:=11
   else
        if (My_strtofloat(Cells[12,i])>(My_strtofloat(Cells[11,i]))) then
         MaxCol:=12
          else
         if (Cells[11,i]<>'#######')then MaxCol:=11
           else MaxCol:=-1;
     MaxRow:=i;
  if (MaxCol<>-1)and(My_strtofloat(Cells[Maxcol,i])<>0) then
           begin
   max_I_cells[i,1]:=Maxcol;
   max_I_cells[i,2]:=Maxrow;
           end
        else
           begin
   max_I_cells[i,1]:=-1;
   max_I_cells[i,2]:=-1;
           end;
      end;



  end;
  GridClean(Param_grd);
  param_grd.Cells[1,0]:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'2';
  self.chbZag2Click( Button2 );
  end;

procedure TSimpleFermResult_Form.Sn_CBxChange(Sender: TObject);
begin
 ferma_FD_form.showD(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm);
 Main_Form.ActiveMDIChild.RePaint;
 Moves_BtnClick(Self);
end;

procedure TSimpleFermResult_Form.FormStart;
var
 num,i:integer;
 Start_Value:extended;
 Current_Ferm:TFerm;
begin
 caption:='Результаты расчета на прочность для '+ExtractFileName(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).real_fname);
 NumOk:=True;
 param_grd.colcount:=15;
 {if Main_Form.FermaNumberButton.Down=False then
  begin
   Main_Form.FermaNumberButton.Down:=True;
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   NumOk:=False;
  end;   }
 if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1>Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 then num:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nst1
  else num:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1;
 Param_Grd.Height:=num*16+20;
 Param_Grd2.Height:=nyz*16+20;
 SimpleFermResult_Form.Top:=Round(Screen.Height/2- SimpleFermResult_Form.Height/2);
 SimpleFermResult_Form.Left:=Round(Screen.Width/2- SimpleFermResult_Form.Width/2);
 DopNapr_Label.Caption:='Доп. напр. растяжения['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'/'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';
 DopNapr_sg_label.Caption:='Доп. напр. сжатия['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'/'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**2]';
 V_Label.Caption:='Объем материала ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'**3]';
 Gs_Label.Caption:='Силовой вес конструкции ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'*'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
 tok_label.Caption:='Силовой вес ТОК ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'*'+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
 M_label.Caption:= 'Масса конструкции '+'[кг]';
  Current_Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;

// Исходный объем материала для ферменной конструкции
  Start_Value:=0;
  for i:=1 to Current_Ferm.nst1 do
   begin
   start_value:=start_value+Current_Ferm.Fn[i]*
    sqrt(
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],1]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],1])+
          (Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])*(Current_Ferm.corn[Current_Ferm.iTopN[i,1],2]-Current_Ferm.corn[Current_Ferm.iTopN[i,2],2])
        );
   end;
  Volume_Edt.Text:=formatFloat('0.000e+00',Start_Value);
  Mass_edt.Text:=formatFloat('0.000e+00',Start_Value*Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.pltn);

  end;

  procedure TSimpleFermResult_Form.FormClose(Sender: TObject; var Action: TCloseAction);
  var
    ff:System.Text;
    i,j:integer;
  begin
  if not NumOk then
  begin
  { Main_Form.FermaNumberButton.Down:=False; }
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
  end;
  assignfile(ff,ChangeFileExt(projectname,'.smp'));
  rewrite(ff);
  writeln(ff,maxtension_Edt.text);
  writeln(ff,Volume_Edt.text);
  writeln(ff,Mass_Edt.text);
  writeln(ff,FermWeight_Edt.text);
  if TokWeight_Edt.text = 'Нет данных' then  writeln(ff,'  ---')
  else writeln(ff,TokWeight_Edt.text);
  if ves_to_tok.text = 'Нет данных' then  writeln(ff,'  ---')
  else writeln(ff,ves_to_tok.text);
  closefile(ff);
  //if SimpleFermResult_Form.CheckBox1.Checked=True then
  begin
    assignfile(ff,ChangeFileExt(projectname,'.nmi'));
    rewrite(ff);
    writeln(ff,'Лямбда');
    writeln(ff,lambda_edit.text);
    writeln(ff,'Необходимые моменты инерции с учетом');
    for i:=1 to nst do
    begin
      for j:=0 to 2 do
      begin
        if Param_Grd.Cells[11+j,i]='#######'then
          writeln(ff,'0,00e+00')
        else
          writeln(ff,Param_Grd.Cells[11+j,i]);
      end;
    end;
   closefile(ff);
  end;
  end;

procedure TSimpleFermResult_Form.Ok_BtnClick(Sender: TObject);
begin
        close;
end;


procedure TSimpleFermResult_Form.FormShow(Sender: TObject);
begin
formstart;
zag1.caption:='Напряжения ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'/'
       +Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'2]';
zag3.Caption:='Необходимые площади ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'2]';
zag4.Caption:='Необх.моменты инерции ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'4]';

lNodesXY.Caption:='Коорд. узлов ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
lMoveX.Caption:='Перемещения по Х ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';
lMoveY.Caption:='Перемещения по У ['+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+']';

ok_btn.SetFocus;
end;

procedure TSimpleFermResult_Form.DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  CharOffset = 3;
 var i,j,col,row:integer;

  begin

  Param_grd.canvas.Pen.Color:=clBtnShadow;
  Param_grd.canvas.Pen.Width:=2;
{
     Begin
Param_grd.canvas.MoveTo(Param_grd.cellrect(2,1).left-1,Param_grd.cellrect(2,1).top);
Param_grd.canvas.LineTo(Param_grd.cellrect(2,Param_grd.rowcount).left-1,Param_grd.cellrect(2,Param_grd.rowcount).top);

Param_grd.canvas.MoveTo(Param_grd.cellrect(5,1).left-1,Param_grd.cellrect(5,1).top);
Param_grd.canvas.LineTo(Param_grd.cellrect(5,Param_grd.rowcount).left-1,Param_grd.cellrect(5,Param_grd.rowcount).top);
Param_grd.canvas.MoveTo(Param_grd.cellrect(8,1).left-1,Param_grd.cellrect(8,1).top);
Param_grd.canvas.LineTo(Param_grd.cellrect(8,Param_grd.rowcount).left-1,Param_grd.cellrect(8,Param_grd.rowcount).top);
Param_grd.canvas.MoveTo(Param_grd.cellrect(11,1).left-1,Param_grd.cellrect(11,1).top);
Param_grd.canvas.LineTo(Param_grd.cellrect(11,Param_grd.rowcount).left-1,Param_grd.cellrect(11,Param_grd.rowcount).top);
Param_grd.canvas.MoveTo(Param_grd.cellrect(14,1).left-1,Param_grd.cellrect(14,1).top);
Param_grd.canvas.LineTo(Param_grd.cellrect(14,Param_grd.rowcount).left-1,Param_grd.cellrect(14,Param_grd.rowcount).top);
     end;
}
Param_grd.canvas.MoveTo(Param_grd.cellrect(14,Param_grd.rowcount).left-1,Param_grd.cellrect(14,Param_grd.rowcount).top);

with Param_grd.canvas do
begin
     case  aCol of
     2..4,8..10 : begin
                      if  aRow>0 then begin
                          brush.Color:= ModifyColor( clWhite, -32 );
                          fillrect( rect );
                          font.color := clBlack;
                          textout(rect.left + CharOffset-1,
                          rect.top + CharOffset-1, Param_grd.Cells[aCol,aRow]);
                      end;
                  end;
     {5..7       : begin
                      if  aCol=kmin[aRow] then begin
                          brush.Color:= MinSafetyFactorColor;
                      end else begin
                          brush.Color:= Param_Grd.Color;
                      end;
                      fillrect( rect );
                      font.color := clBlack;
                      textout(rect.left + CharOffset-1,
                      rect.top + CharOffset-1, Param_grd.Cells[aCol,aRow]);
                  end;}
     end;
end;

  if colorbox.checked=true then
begin


   // Закрашываем максимальные напряжения
  for i:=1 to nst do
       begin
  if (Acol=Max_Cells[i,1])and(Arow = Max_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= MaxPressureColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[Max_Cells[i,1],Max_Cells[i,2]]);
    end;
       end;

// Закрашываем минимальные напряжения
  for i:=1 to nst do
       begin
  if (Acol=Min_Cells[i,1])and(Arow = Min_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= MinPressureColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[Min_Cells[i,1],Min_Cells[i,2]]);
    end;
       end;
// Закрашиваем коэффециенты запаса прочости
if Button2.Caption = 'Коэффициенты запаса прочности' then
  for i:=1 to nst*3+1 do
       begin
  if (Acol=Min_K_Cells[i,1])and(Arow = Min_K_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= SafetyFactorColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[Min_K_Cells[i,1],Min_K_Cells[i,2]]);
    end;
       end;
  // Закрашиваем коэффециенты запаса прочости отличающиеся от 1 не более чем на 5%.
  for i:=1 to nst*3+1 do
       begin
  if (Acol=K_Cells[i,1])and(Arow = K_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= RGB( 202,252, 109);
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[K_Cells[i,1],K_Cells[i,2]]);
    end;
       end;

       // Закрашиваем площади стержней
  for i:=1 to nst do
       begin
  if (Acol=Max_S_Cells[i,1])and(Arow = Max_S_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= CoreAreaColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[Max_S_Cells[i,1],Max_S_Cells[i,2]]);
    end;
       end;
           // Закрашиваем моменты инерции
  for i:=1 to nst do
       begin
  if (Acol=Max_I_Cells[i,1])and(Arow = Max_I_Cells[i,2]) then
  with Param_grd.canvas do
  begin
    brush.Color:= InertiaColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd.Cells[Max_I_Cells[i,1],Max_I_Cells[i,2]]);
    end;
       end;
  if not(Button2.Caption = 'Коэффициенты запаса прочности') then
with Param_grd.canvas do
begin
     case  aCol of
     5..7       : begin
                      if  aCol=kmin[aRow] then begin
                          brush.Color:= MinSafetyFactorColor;
                          fillrect( rect );
                          font.color := clBlack;
                          textout(rect.left + CharOffset-1,
                          rect.top + CharOffset-1, Param_grd.Cells[aCol,aRow]);
                      end;
                  end;
     end;
end;
end;


       end;

procedure TSimpleFermResult_Form.Button2Click(Sender: TObject);
begin
  if Button2.Caption = 'Коэффициенты запаса прочности' then
    Button2.Caption := 'Минимальные коэффициенты запаса прочности'
  else Button2.Caption := 'Коэффициенты запаса прочности';
  chbZag2Click(Sender);
  ok_btn.SetFocus;
end;


procedure TSimpleFermResult_Form.chbZag2Click(Sender: TObject);
var  c,r,code:integer; cr,crmin:extended; s:string;
begin
     for r:=low(kmin) to high(kmin) do begin
         kmin[r] := -100;
     end;
     if  Button2.Caption = 'Коэффициенты запаса прочности' then begin
         Param_Grd.Invalidate;
         exit;
     end;
     for r := Param_Grd.FixedRows to Param_Grd.RowCount - 1 do begin
         crmin := high( integer );
         for c := 5 to 7 do begin
              s := Param_Grd.Cells[c,r];
              s := ChangeChar( s, ',', '.' );
              val( s, cr, code );
              if (cr<crmin) then begin
                  kmin[r] := c;
                  crmin   := cr;
              end;

         end;
     end;
     Param_Grd.Invalidate;
end;

procedure TSimpleFermResult_Form.CheckBox1Click(Sender: TObject);
begin
SimpleFermResult_Form.Moves_BtnClick(self);
ok_btn.SetFocus;
end;

procedure TSimpleFermResult_Form.Button1Click(Sender: TObject);
begin
SimpleFermResult_Form.Moves_BtnClick(self);
ok_btn.SetFocus;
end;

procedure TSimpleFermResult_Form.SetBmpColor( aIndex:integer; aColor : TColor;
                           const aCaption : string );
var  bmp:TBitMap; 
begin
     bmp := TBitmap.Create;
     bmp.Width := ilColors.Width;
     bmp.Height:= ilColors.Height;
     bmp.Canvas.Brush.Color := aColor;
     bmp.Canvas.FillRect( bmp.Canvas.ClipRect );
     ilColors.Delete( aIndex );
     ilColors.Insert( aIndex, bmp, nil  );
     self.pmParam_Grd.Items[aIndex].ImageIndex := aIndex;
     self.pmParam_Grd.Items[aIndex].Visible    := true;
     if  aCaption<>'' then begin
         pmParam_Grd.Items[aIndex].Caption := aCaption;
     end;
     case aIndex of
0: MinSafetyFactorColor := aColor;
1: MaxPressureColor     := aColor;
2: MinPressureColor     := aColor;
3: begin
   SafetyFactorColor    := aColor;
   CoreAreaColor        := aColor;
   InertiaColor         := aColor;
   MaxMovingXColor      := aColor;
   MaxMovingYColor      := aColor;
   end;
{4: CoreAreaColor        := aColor;
5: InertiaColor         := aColor;
6: MaxMovingXColor      := aColor;
7: MaxMovingYColor      := aColor;}
     end;
end;

procedure TSimpleFermResult_Form.FormCreate(Sender: TObject);
     procedure ST( aImage:TImage );
     var  bmp:TBitmap;
     begin
          bmp := aImage.Picture.Bitmap;
          bmp.TransparentColor :=  bmp.Canvas.Pixels[ bmp.Width-1, 0 ];
          bmp.Transparent      := true;
          aImage.Transparent   := true;
     end;
     procedure AddP( aLabel : TLabel; aImage : TImage; aValue : TEdit );
     begin
          pLabels.Add( aLabel );
          pImages.Add( aImage );
          pValues.Add( aValue );
     end;
var  i:integer;
begin
     lambda_edit.text:=inttostr(50);

     for i:= 0 to pmParam_Grd.Items.Count-1 do begin
         self.pmParam_Grd.Items[i].Visible := false;
     end;

     MinSafetyFactorColor  := ModifyColor( clNavy  , 128 );
     MaxPressureColor      := ModifyColor( clGreen , 128 );
     MinPressureColor      := ModifyColor( clNavy  , 128 );
     SafetyFactorColor     := ModifyColor( clMaroon, 128 );
     CoreAreaColor         := ModifyColor( clMaroon, 128 );
     InertiaColor          := ModifyColor( clMaroon, 128 );
     MaxMovingXColor       := ModifyColor( clMaroon, 128 );
     MaxMovingYColor       := ModifyColor( clMaroon, 128 );

     SetBmpColor( 0, MinSafetyFactorColor, 'Минимальный коэффициент запаса прочности' );
     SetBmpColor( 1, MaxPressureColor    , 'Максимальные напряжения' );
     SetBmpColor( 2, MinPressureColor    , 'Минимальные напряжения' );
     SetBmpColor( 3, SafetyFactorColor   , 'Критические параметры' );
{     SetBmpColor( 4, CoreAreaColor       , 'Цвет площади стержней' );
     SetBmpColor( 5, InertiaColor        , 'Цвет моментов инерции' );
     SetBmpColor( 6, MaxMovingXColor     , 'Цвет максимальных перемещений по X' );
     SetBmpColor( 7, MaxMovingYColor     , 'Цвет максимальных перемещений по Y' );}

     ST( Image1 );
     ST( Image2 );
     ST( Image3 );
     ST( Image4 );
     ST( Image5 );
     ST( Image6 );
     ST( imL    );
     ST( Image8 );
     pLabels   := TList.Create;
     pImages   := TList.Create;
     pValues   := TList.Create;
     AddP( self.DopNapr_Label, Image1, self.MaxTension_Edt );
     AddP( self.Dopnapr_sg_label, Image8, self.MaxTension_SG_Edt );
     AddP( self.Gs_Label, Image4, self.FermWeight_Edt );
     AddP( self.Tok_Label, Image5, self.TOKWeight_Edt );
     AddP( self.Label1, Image6, self.ves_to_tok );
     AddP( self.V_Label, Image2, self.Volume_Edt );
     AddP( self.M_label, Image3, self.Mass_edt );
end;

procedure TSimpleFermResult_Form.FormDestroy(Sender: TObject);
begin
    pLabels.free;
    pImages.free;
    pValues.free;
end;

procedure AlignAtVCenter( aDest, aSource : TControl );
begin
     if (aDest=nil) or (aSource=nil) then exit;
     if  aDest.Parent=aSource then begin
         aDest.Top :=               (aSource.Height-aDest.Height) div 2;
     end else begin
         aDest.Top := aSource.Top + (aSource.Height-aDest.Height) div 2;
     end;
end;
procedure AlignAtHCenter( aDest, aSource : TControl );
begin
     if (aDest=nil) or (aSource=nil) then exit;
     if  aDest.Parent=aSource then begin
         aDest.Left :=                (aSource.Width-aDest.Width) div 2;
     end else begin
         aDest.Left := aSource.Left + (aSource.Width-aDest.Width) div 2;
     end;
end;

// Разметка элементов формы и переназначение размеров
procedure TSimpleFermResult_Form.FormResize(Sender: TObject);
var  ll,c,r,w,ww, i : integer;  cr:TRect; l:TLabel; im:TImage; e:TEdit;
begin
     // Формирование верхней части формы
     ll := lTmp.Height;
     lTitle.Top     := ll div 3;
     if self.ClientWidth > 947 + ll * 2 then VisioBox.Width := self.ClientWidth - ll * 2
     else VisioBox.Width := 947;
     VisioBox.Left  := self.ClientWidth - ll - VisioBox.Width;
     Param_Grd.Left := ll;
     Param_Grd.Width:= VisioBox.ClientWidth - 2*Param_Grd.Left;
     AlignAtHCenter( lTitle, VisioBox );
     AlignAtVCenter( Napr_Image, lTitle );
     Napr_Image.Left := lTitle.Left-Napr_Image.Width-ll;
     VisioBox.Top  := lTitle.Top + lTitle.Height+ll div 4;
     
     lTmp.caption := Param_Grd.Cells[0,0];
     Param_Grd.ColWidths[0] := ll * 2;
     Param_Grd.ColWidths[14] := Param_Grd.ColWidths[0];
     w                      := Param_Grd.ColWidths[0]+2;
     lTmp.caption := 'W123456789';
     ww           := lTmp.Width;
     lTmp.caption := zag4.Caption;
     if (lTmp.Width div 3)>ww then ww := lTmp.Width div 3 + 1;
     for c := Param_Grd.FixedCols to Param_Grd.ColCount - 2 do begin
         case c of
1      : begin
             lTmp.caption := 'ЗАДАННЫЕ';
             zag5.width   := lTmp.Width;
             Param_Grd.ColWidths[c] := ww;
             zag5.Left    := w+ll;
             zag5.Height  := 2*ll;
             zag5.Top     := ll;
             Param_Grd.Top:= zag5.Top+zag5.Height;
         end;
2      : begin
             zag1.Left    := zag5.Left+zag5.Width+ll;
             zag1.width   := 3*(lTmp.Width+1)-12;
             zag1.ClientHeight  := lTmp.Height+2;
             AlignAtVCenter( zag1, zag5 );
             Param_Grd.ColWidths[c] := ww;
         end;
5      : begin
             cr := Param_Grd.CellRect( 5, 0 );
             Button2.Left     := ll+cr.Left+3;// zag1.Left+zag1.Width;
             Button2.width    := 3*(ww+1);
             Button2.Top      := ll div 2 + 3;
             lTmp.caption := Button2.Caption;
             //Button2.Width := lTmp.Width+ll*2;
             Param_Grd.Top:= Button2.Top+Button2.Height+ll div 2 - 3;
//             AlignAtVCenter( zag2, zag5 );
             Param_Grd.ColWidths[c] := ww;
         end;
8      : begin
             cr := Param_Grd.CellRect( 8, 0 );
             zag3.Left    := ll+cr.Left;// zag2.Left+zag2.Width;
             zag3.width   := 3*(ww+1);
             AlignAtVCenter( zag3, zag5 );
             Param_Grd.ColWidths[c] := ww;
         end;
11     : begin
             cr := Param_Grd.CellRect( 11, 0 );
             zag4.Left    := ll+cr.Left;// zag3.Left+zag3.Width;
             zag4.width   := 3*(ww+1);
             AlignAtVCenter( zag4, zag5 );
             Param_Grd.ColWidths[c] := ww;
         end else
             Param_Grd.ColWidths[c] := ww;
         end;
         w   := w+Param_Grd.ColWidths[c]+2;
     end;
     w  := Param_Grd.ClientWidth-w;
     {if  w<0 then begin
         self.ClientWidth := ClientWidth - w + 10;
         self.Left        :=(GetSystemMetrics( sm_CXfullScreen )-self.Width) div 2;
     end;}

     for r:=0 to Param_Grd.RowCount-1 do begin
         Param_Grd.RowHeights[r] := lTmp.Height + 2;
     end;

     w := 0;
     ww:= 0;
     for i := 0 to pLabels.Count - 1 do begin
         l := pLabels[i];
         im:= pImages[i];
         lTmp.Caption := l.Caption;
         if lTmp.Width>w   then w:= lTmp.Width;
         if im.Width>ww then ww:= im.Width;
     end;
     w := w+lTmp.Height div 3;
     for i := 0 to pLabels.Count - 1 do begin
         l := pLabels[i];
         im:= pImages[i];
         e := pValues[i];
         l.AutoSize := false;
         l.Width := w;
         l.Left  := ll div 2;
         im.Left := l.Left+w;
         e.Left  := im.Left+ww+ll div 3;
         e.Top   := 2*ll + ll div 3 + (i-1) * (self.MaxTension_Edt.Height+2);
         AlignAtVCenter( im, e );
         AlignAtVCenter( l , e );
     end;
     // Формирование нижней части формы
     gbParams.ClientHeight := self.Mass_edt.Top+Mass_edt.Height+ll div 2;
     gbParams.ClientWidth := w+ww+MaxTension_Edt.Width + ll + ll div 3;
     gbDop.Width          := gbParams.Width;

     imL.Left   := ll;
     lambda_edit.Left := imL.Left+imL.Width;
     CheckBox1.Left   := lambda_edit.Left+lambda_edit.Width+ll div 2;
     CheckBox1.Width  := gbDop.ClientWidth - CheckBox1.Left - ll div 2;
     ColorBox.Width   := CheckBox1.Width;
     Button1.ClientHeight := lTmp.Height+8;
     OK_Btn.ClientHeight := Button1.ClientHeight;
     CheckBox1.Top := 3*ll div 3;
     PeremBox.Top  := ll div 4;
     AlignAtVCenter( lambda_edit, ColorBox );
     AlignAtVCenter( imL, ColorBox );
     Button1.Top  := PeremBox.Top + PeremBox.Height + ll div 4;
     Button1.Left := lambda_edit.Left + lambda_edit.Width + ll div 2;
     AlignAtVCenter( lambda_edit, Button1 );
     AlignAtVCenter( imL, Button1 );
     OK_Btn.Top  := Button1.Top;
     gbDop.ClientHeight := Button1.Top+Button1.Height+ll;


     // Поменял местами gbDop и gbParams
     gbParams.Left := self.ClientWidth  - gbParams.Width  - ll;
     gbParams.Top  := self.ClientHeight - gbParams.Height - ll - Ok_Btn.Height - 11;

     gbDop.Left    := gbParams.Left;
     gbDop.Top     := gbParams.Top - gbDop.Height;
     if self.ClientWidth > 947 + ll * 2 then gbXY.Width := self.ClientWidth - ll * 3 - gbParams.Width
     else gbXY.Width := VisioBox.Width - ll * 1 - gbParams.Width;
     gbXY.Left     := self.ClientWidth - ll * 2 - gbXY.Width - gbParams.Width;
     perembox.Left := gbXY.Left;
     gbXY.Top      := gbDop.Top + ll * 2;
     perembox.Top  := gbXY.Top - perembox.Height - ll div 4;
     gbXY.Height   := self.ClientHeight-gbXY.top-ll;
     //gbXY.Width    := gbDop.Left-gbXY.Left-ll;
     //gbXY.Left    := self.ClientWidth - ll - gbXY.Width;


     ColorBox.Top  := gbXY.Top - visio.height - ll div 4;
     ColorBox.Left := gbXY.left + gbXY.Width - ColorBox.Width + ll;

     visio.Top     := gbXY.Top - visio.height - ll div 4;
     AlignAtHCenter( visio, gbXY );
     AlignAtVCenter( Moves_Image, visio );
     Moves_Image.Left := visio.Left - Moves_Image.Width - ll;

     VisioBox.Height := Visio.Top - VisioBox.Top - ll - ll div 3;

     Param_Grd.Height := VisioBox.ClientHeight-4*ll;

     ww              := Param_Grd.ColWidths[1];
     w               := Param_Grd2.Left+Param_Grd2.ColWidths[0]+2;
     for c:=Param_Grd2.FixedCols to Param_Grd2.ColCount - 1 do begin
         Param_Grd2.ColWidths[c] := ww;
         case c of
0      : begin
             Param_Grd2.ColWidths[c] := ll * 2;
         end;
1      : begin
             lNodesXY.Left    := w;
             lNodesXY.width   := 2*(ww+1);
         end;
3      : begin
             lMoveX.Left    := w;
             lMoveX.width   := 3*(ww+1);
         end;
6      : begin
             lMoveY.Left    := w;
             lMoveY.width   := 3*(ww+1);
         end;
         end;
         w   := w+Param_Grd2.ColWidths[c]+2;
     end;
     Param_Grd2.ColWidths[0] := ll * 2; // starshin 19.11.14
     for r:=0 to Param_Grd2.RowCount-1 do begin
         Param_Grd2.RowHeights[r] := lTmp.Height + 2;
     end;
     lNodesXY.Top     := Zag5.Top;
     lMoveX.Top       := lNodesXY.Top;
     lMoveY.Top       := lNodesXY.Top;
     Param_Grd2.Top   := lNodesXY.Top+ lNodesXY.Height;
     Param_Grd2.Left  := Param_Grd.Left;
     Param_Grd2.Width := gbXY.ClientWidth-2*Param_Grd2.Left;
     Param_Grd2.Height:= gbXY.ClientHeight - Param_Grd2.Top - ll;

     Ok_Btn.Top := self.ClientHeight - Ok_Btn.Height - 11;
     Ok_Btn.Left := gbParams.Left;
     Ok_Btn.Width := gbParams.Width;

end;

procedure TSimpleFermResult_Form.ColorBoxClick(Sender: TObject);
begin
SimpleFermResult_Form.Moves_BtnClick(self);
ok_btn.SetFocus;
end;

procedure TSimpleFermResult_Form.DrawCell2(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  const
  CharOffset = 3;
 var i,j,col,row:integer;
  begin
    begin

  Param_grd2.canvas.Pen.Color:=clBtnShadow;
  Param_grd2.canvas.Pen.Width:=2;
{
  Param_grd2.canvas.MoveTo(Param_grd2.cellrect(3,1).left-1,Param_grd2.cellrect(3,1).top);
  Param_grd2.canvas.LineTo(Param_grd2.cellrect(3,Param_grd2.rowcount).left-1,Param_grd2.cellrect(3,Param_grd2.rowcount).top);


  Param_grd2.canvas.MoveTo(Param_grd2.cellrect(6,1).left-1,Param_grd2.cellrect(6,1).top);
  Param_grd2.canvas.LineTo(Param_grd2.cellrect(6,Param_grd2.rowcount).left-1,Param_grd2.cellrect(6,Param_grd2.rowcount).top);

  Param_grd2.canvas.MoveTo(Param_grd2.cellrect(9,1).left-1,Param_grd2.cellrect(9,1).top);
  Param_grd2.canvas.LineTo(Param_grd2.cellrect(9,Param_grd2.rowcount).left-1,Param_grd2.cellrect(9,Param_grd2.rowcount).top);
}

         // Закрашываем максимальные перемещения по X

     if colorbox.Checked = true then
           begin
  for i:=1 to nyz do
       begin
(*
  if (Acol=Max_moves_X[i,1])and(Arow = Max_moves_X[i,2]) then
  with Param_grd2.canvas do
  begin
    font.color := clMaroon;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd2.Cells[Max_moves_X[i,1],Max_moves_X[i,2]]);
    end;
       end;
           // Закрашываем максимальные перемещения по Y
  for i:=1 to nyz do
       begin
  if (Acol=Max_moves_Y[i,1])and(Arow = Max_moves_Y[i,2]) then
  with Param_grd2.canvas do
  begin
    font.color := clMaroon;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd2.Cells[Max_moves_Y[i,1],Max_moves_Y[i,2]]);
    end;
       end;
           end;

  end;
*)
  if (Acol=Max_moves_X[i,1])and(Arow = Max_moves_X[i,2]) then
  with Param_grd2.canvas do
  begin
    brush.Color:= self.MaxMovingXColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd2.Cells[Max_moves_X[i,1],Max_moves_X[i,2]]);
    end;
       end;
           // Закрашываем максимальные перемещения по Y
  for i:=1 to nyz do
       begin
  if (Acol=Max_moves_Y[i,1])and(Arow = Max_moves_Y[i,2]) then
  with Param_grd2.canvas do
  begin
    brush.Color:= self.MaxMovingYColor;
    fillrect( rect );
    font.color := clBlack;
    textout(rect.left + CharOffset-1,
      rect.top + CharOffset-1, Param_grd2.Cells[Max_moves_Y[i,1],Max_moves_Y[i,2]]);
    end;
       end;
           end;

  end;
  end;


procedure TSimpleFermResult_Form.FormActivate(Sender: TObject);
begin
lambda_edit.SetFocus;
FormResize(Self);
end;

procedure TSimpleFermResult_Form.zag1Click(Sender: TObject);
begin
if Flag2 = false then
       begin
       Flag2:=true;
       zag1.caption:='Силы в стержнях [Н]';
       end
else   begin
       Flag2:=false;
       zag1.caption:='Напряжения '+Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_for+'/'
       +Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.s_lin+'2';
       end;

Moves_BtnClick(Self);
ok_btn.SetFocus;
end;

procedure TSimpleFermResult_Form.peremBoxClick(Sender: TObject);
begin
SimpleFermResult_Form.Moves_BtnClick(self);
ok_btn.SetFocus;
end;



end.
