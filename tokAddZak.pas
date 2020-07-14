unit tokAddZak;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TtokAddZak_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    OS_Label: TLabel;
    xm: TEdit;
    xm1: TLabel;
    xml: TLabel;
    Bevel3: TBevel;
    OK: TBitBtn;
    cancel: TBitBtn;
    ym: TEdit;
    ym1: TLabel;
    yml: TLabel;
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tokAddZak_Form: TtokAddZak_Form;

implementation

uses Main, Ferm_dat, tok_FD,tok_M, tokFix_node;
var
tok:ttok;

{$R *.DFM}

procedure TtokAddZak_Form.OKClick(Sender: TObject);
label
{1,2,}3;
var
  p,m,s:TPoint;
  Xtok,Ytok :integer;      // Координаты узла (передаются в Tok_Fix_Node)
  i,nz:integer;
  CurrentNode:integer;
  ux,uy:single;
  {z1,}z2,z3,z4,z5:array[1..tok_max_zak] of extended; // Закрепления (номер узла, X и Y)
  uxx,uyy,max_x_coord,max_y_coord:extended;
begin
 tok:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
 uxx:=0;
 uyy:=0;
  try
   strtofloat(xm.text)
  except
    Main_Form.StatusBar1.Panels[1].Text := 'Ошибка при задании координаты по Х.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите положительное число.';
    beep;
    //repaint;//
    Exit;
  end;
  if (strtofloat(xm.text)<0) or (strtofloat(xm.text)>tok.xm[37]) then
   begin
    Main_Form.StatusBar1.Panels[1].Text := 'Вне пределов области.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите число в пределах границ.';
    beep;
    //repaint;//
    Exit;
   end;

     try
   strtofloat(ym.text)
  except
    Main_Form.StatusBar1.Panels[1].Text := 'Ошибка при задании координаты по Х.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите положительное число.';
    beep;
    //repaint;//
    Exit;
  end;
  if (strtofloat(ym.text)<0) or (strtofloat(ym.text)>tok.ym[37]) then
   begin
    Main_Form.StatusBar1.Panels[1].Text := 'Вне пределов области.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите положительное число в пределах границ.';
    beep;
    //repaint;//
    Exit;
   end;

 max_x_coord:=tok.xm[37];
 max_y_coord:=tok.ym[37];
 CurrentNode:=0;
  for i:=28{1} to 36 do
      begin
        ux:=50+coord_axis_x+(tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.width-80-coord_axis_x)/max_x_coord*(tok.xm[i]);
        uy:=tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.height-30-coord_axis_y-(tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.height-60-coord_axis_y)/max_y_coord*(tok.ym[i]);

        if (round(tok.xm[i]*100)=round(strtofloat(xm.text)*100))and (round(tok.ym[i]*100)=round(strtofloat(ym.text)*100)) and ((round(tok.pn[i,1])<>0)or(round(tok.pn[i,2])<>0)) then
          begin
            tok_m.Ttok_Form(main_form.ActiveMDIChild).CurrentNode:=tok.number[i];
            CurrentNode:=tok.number[i];
            uxx:=tok.xm[i];
            uyy:=tok.ym[i];
            Break;
          end;
      end;
  if CurrentNode<>0 then
  Main_Form.StatusBar1.Panels[1].Text :='Узел №'+IntToStr(CurrentNode)+Format(' [%g : %g]',[uxx, uyy]);
   Xtok:=round(strtofloat(xm.text));
  Ytok:=round(strtofloat(ym.text));

   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if CurrentNode=0 then
   begin
    ux:=50+coord_axis_x+(tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.width-80-coord_axis_x)/max_x_coord*(strtofloat(xm.text));
    uy:=tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.height-30-coord_axis_y-(tok_m.Ttok_Form(main_form.ActiveMDIChild).paintbox.height-60-coord_axis_y)/max_y_coord*(strtofloat(ym.text));
   end;

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  P.x:=Round(ux);
  P.y:=Round(uy);


  tokFixNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y;
  tokFixNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x;

  if tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x+11;
     tokFixNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;;
     tokFixNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;;
     tokFixNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if (tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x+tokFixNode_Form.Width>Screen.Width) and
     (tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y+tokFixNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokFixNode_Form.Height;
     S.x:=P.x-7-tokFixNode_Form.Width;
     tokFixNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;;
     tokFixNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if Xtok>round(max_x_coord) then Xtok:=round(max_x_coord);
  if Xtok<0 then Xtok:=0;
  if Ytok>round(max_y_coord) then Ytok:=round(max_y_coord);
  if Ytok<0 then Ytok:=0;

  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;


  // Закрепления и нагрузки
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
          MessageDlg('Слишком много закрепленных узлов',mtWarning,[mbOk],0);
          Exit;
        end;
      inc(tok.n_zu);
      nz:=tok.n_zu+27;    //!!!!!!!!!!
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
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Xtok:=Xtok;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Ytok:=Ytok;
  //tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nz:=nz;

  tokFixNode_Form.Execute(tok.pn[nz,1],tok.pn[nz,2]);
// Убиваем незакрепленные узлы
  nz:=1;
   for i:=1 to tok.n_zu do
    if (tok.pn[i+27,1]<>0)or(tok.pn[i+27,2]<>0) then
      begin
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
    tok.pn[i+27,1]:=z2[i];
    tok.pn[i+27,2]:=z3[i];
    tok.xm[i+27]:=z4[i];
    tok.ym[i+27]:=z5[i];
   end;

 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok_number;
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 tok_FD_Form.showD(tok);
 Main_Form.ActiveMDIChild.RePaint;

end;

procedure TtokAddZak_Form.FormShow(Sender: TObject);
begin
 xm.text:='';
 ym.text:='';
 xm.SetFocus;
 tokAddZak_Form.Left:=tok_fd_form.Left+4;
 tokAddZak_Form.top:=tok_fd_form.top+138;

end;

end.
