unit tokAddNagr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TtokAddNagr_Form = class(TForm)
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
  tokAddNagr_Form: TtokAddNagr_Form;

implementation

uses Main, Ferm_dat, tok_FD,tok_M, tokForcenode, ForcNode;
var
tok:ttok;

{$R *.DFM}

procedure TtokAddNagr_Form.OKClick(Sender: TObject);
label
{1,2,}3;
var
  p,m,s:TPoint;
  Xtok,Ytok :integer;      // Координаты узла (передаются в Tok_Fix_Node)
  i,j,nu,ii,nsm1:integer;
   CurrentNode,sn:integer;
  ux,uy:single;
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
    Main_Form.StatusBar1.Panels[2].Text := 'Введите число в пределах границ.';
    beep;
    //repaint;//
    Exit;
   end;

 max_x_coord:=tok.xm[37];
 max_y_coord:=tok.ym[37];
 CurrentNode:=0;
// sn:=main_form.tok_sn_cbx.itemindex+1;
  for i:=1 to 36 do
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

  tokForceNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y;
  tokForceNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x;
  if tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y+ForceNode_Form.Height>Screen.Height then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x+11;
     tokForceNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;;
     tokForceNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width then
   begin
     S.y:=P.y+7;
     S.x:=P.x-7-ForceNode_Form.Width;
     tokForceNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;;
     tokForceNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if (tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).x+tokForceNode_Form.Width>Screen.Width) and
     (tok_m.ttok_form(main_form.activemdichild).ClientToScreen(M).y+tokForceNode_Form.Height>Screen.Height) then
   begin
     S.y:=P.y-7-tokForceNode_Form.Height;
     S.x:=P.x-7-tokForceNode_Form.Width;
     tokForceNode_Form.Top:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).y;
     tokForceNode_Form.Left:=tok_m.ttok_form(main_form.activemdichild).ClientToScreen(S).x;
   end;


 //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  if Xtok>round(max_x_coord) then Xtok:=round(max_x_coord);
  if Xtok<0 then Xtok:=0;
  if Ytok>round(max_y_coord) then Ytok:=round(max_y_coord);
  if Ytok<0 then Ytok:=0;

  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
//end;


  //  нагрузки
 nu:=0;
  for i:={main_form.tok_SN_Cbx.ItemIndex*9+}1 to 36 do
   if CurrentNode<>0 then
    if tok.number[i]=CurrentNode then
      begin
        nu:=i;
        Break;
      end;
  if nu=0 then
    begin
               if tok.nsm = 0 then
                   begin
                   //  Main_Form.tok_Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(1));
                    // Main_Form.tok_Sn_Cbx.Enabled:=true;
                     tok.nsm:=1;
                      main_form.sn_cbx.ItemIndex:=0;
                   end;

            if tok.n_nuz[main_form.sn_cbx.ItemIndex+1]>=tok_max_for then
              begin
                beep;
                MessageDlg('Слишком много нагруженных узлов',mtWarning,[mbOk],0);
                Exit;
              end;
      sn:= main_form.sn_cbx.ItemIndex+1;
     // inc(tok.n_nuz[sn]);
      nu:=(sn-1)*9+tok.n_nuz[sn]+1;//!!!!!!!!!!!!!
      currentnode:=tok.count+1;
      tok.xm[nu]:=Xtok;
      tok.ym[nu]:=Ytok;
      tok.pn[nu,1]:=0;
      tok.pn[nu,2]:=0;
    end
     else
      begin
       Xtok:=round(tok.xm[nu]);
       Ytok:=round(tok.ym[nu]);
      end;
  TokForceNode_Form.XLabel.Caption:='Сила по X  ['+Tok.s_for+']';
  TokForceNode_Form.YLabel.Caption:='Сила по Y  ['+Tok.s_for+']';
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Xtok:=Xtok;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Ytok:=Ytok;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=nu;
  //????????????????????????????????????
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).currentnode:=currentnode;
  TokForceNode_Form.ShowModal;

  ii:=Main_Form.sn_cbx.Itemindex+1;

  for i:=1 to 27 do
    if (tok.pn[i,1]=0)and(tok.pn[i,2]=0)then
     begin
       tok.xm[i]:=0;
       tok.ym[i]:=0;
     end;

   nsm1:=tok.nsm;

   for i:=1 to tok.nsm do
     if (tok.n_nuz[i]=0) and (i<>tok.nsm) then
      begin
       for j:=(i)*9+1 to (i)*9+9{tok.n_nuz[i+1]} do
        begin
         tok.xm[j-9]:=tok.xm[j];
         tok.ym[j-9]:=tok.ym[j];
         tok.pn[j-9,1]:=tok.pn[j,1];
         tok.pn[j-9,2]:=tok.pn[j,2];
         tok.xm[j]:=0;
         tok.ym[j]:=0;
         tok.pn[j,1]:=0;
         tok.pn[j,2]:=0;         
        end;
        if i<ii then dec(ii);
        tok.n_nuz[i]:=tok.n_nuz[i+1];
        tok.n_nuz[i+1]:=0;
        dec(nsm1);
       end
      else if (tok.n_nuz[i]=0) and (i=tok.nsm) then
      begin
       dec(nsm1);
      // dec(ii);
      end;

  //tok.nsm:=nsm1;
  tok.nsm:=0;
  if tok.n_nuz[1]<>0 then inc(tok.nsm);
  if tok.n_nuz[2]<>0 then inc(tok.nsm);
  if tok.n_nuz[3]<>0 then inc(tok.nsm);

  if (tok.n_nuz[2]<>0) and (tok.nsm=1) and ((tok.pn[10,1]<>0)or(tok.pn[10,2]<>0))then
   begin
       for j:=1 to 9 do
        begin
         tok.xm[j]:=tok.xm[j+9];
         tok.ym[j]:=tok.ym[j+9];
         tok.pn[j,1]:=tok.pn[j+9,1];
         tok.pn[j,2]:=tok.pn[j+9,2];
        end;
       tok.n_nuz[1]:=tok.n_nuz[2];
       tok.n_nuz[2]:=0;
       tok.n_nuz[3]:=0;
       dec(ii);
   end;

  for i:=tok.nsm+1 to 3 do
   for j:=(i-1)*9+1 to (i-1)*9+9 do
    begin
         tok.xm[j]:=0;
         tok.ym[j]:=0;
         tok.pn[j,1]:=0;
         tok.pn[j,2]:=0;
    end;

 Main_Form.sn_cbx.Items.Clear;
 for i:=1 to tok.nsm do
  begin
   Main_Form.sn_cbx.Items.Add('Случай нагружения '+IntToStr(i));
  end;
 if tok.nsm=0 then ii:=0;
   Main_Form.sn_cbx.Itemindex:=ii-1;

   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).sn:=Main_Form.sn_cbx.ItemIndex+1;
   if tok.nsm=0 then Main_Form.sn_cbx.Items.Add('Случай нагружения 1');
   if tok.nsm=0 then main_form.sn_cbx.itemindex:=0;
   if tok.nsm<=1 then main_form.sn_cbx.Enabled:=false
     else  main_form.sn_cbx.Enabled:=true;

 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok_number;
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 tok_FD_Form.showD(tok);
 Main_Form.ActiveMDIChild.RePaint;

end;

procedure TtokAddNagr_Form.FormShow(Sender: TObject);
begin
 xm.text:='';
 ym.text:='';
 xm.SetFocus;
 tokAddNagr_Form.Left:=tok_fd_form.Left+4;
 tokAddNagr_Form.top:=tok_fd_form.top+138;

end;

end.
