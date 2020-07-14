unit AddForce;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TAddForce_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    OS_Label: TLabel;
    number: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    OK: TBitBtn;
    cancel: TBitBtn;
    procedure OKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    nf:boolean;
  end;

var
  Addforce_Form: TAddforce_Form;

implementation

uses Main, Ferm_dat, Plast_FD,Plast_M, Forcnode;
var
plast:tplast;
nf:boolean;

{$R *.DFM}

procedure TAddForce_Form.OKClick(Sender: TObject);
label
{1,2,}3;
var i,j,k:integer;
{  nomm,os:array[1..plast_max_for] of integer; // Нагрузки (номер узла, признак нагружения(по X - 11, по Y - 22, по X и Y - 33), по X, по y)
  nom11,nom22:array[1..plast_max_for] of single;
  r,m,s:TPoint;
  i,jx,jy:integer;
   CurrentNode,nz,max_x_coord,max_y_coord:integer;
  ux,uy:single; }
 begin
  try
   strtoint(Number.text)
  except
    Main_Form.StatusBar1.Panels[1].Text := 'Ошибка при задании номера.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите целое положительное число.';
    beep;
    Exit;
  end;
  if strtoint(number.text)<0 then
   begin
    Main_Form.StatusBar1.Panels[1].Text := 'Отрицателный номер.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите целое положительное число.';
    beep;
    Exit;
   end;
   Plast_m.TPlast_Form(main_Form.ActiveMDIChild).CurrentNode:=strtoint(Number.text);
    with Plast_m.TPlast_Form(main_Form.ActiveMDIChild) do
    begin
    if kl=0 then
    begin
      inc(kl);

      inc(Kt[kl]);
      nagruz[kl,kt[kl],1]:=CurrentNode;

      Main_Form.Sn_Cbx.Items.clear;
      for i:=1 to kl do  Main_Form.Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
      main_form.SN_Cbx.ItemIndex:=kl-1;

      if kl<=0 then main_form.Sn_cbx.Enabled:=false
      else  main_form.Sn_cbx.Enabled:=true;
       end
     else
      begin
     for i:= 1 to kt[main_form.SN_Cbx.ItemIndex+1] do if (nagruz[main_form.SN_Cbx.ItemIndex+1,i,1]=CurrentNode) then
     begin
     DeleteNode(CurrentNode,main_form.SN_Cbx.ItemIndex+1);
     repaint;
     end;
     if(kt[main_form.SN_Cbx.ItemIndex+1]=3) then
         Begin
     MessageDlg(#13+'Слишком много нагруженных узлов для этого случая',mtWarning,[mbOk],0);
     exit;
         end;
     inc(kt[main_form.SN_Cbx.ItemIndex+1]);
     nagruz[main_form.SN_Cbx.ItemIndex+1,kt[main_form.SN_Cbx.ItemIndex+1],1]:=CurrentNode;
     end;
     plast.kl1:=0;

    ForceNode_Form.showmodal;
     // Убиваем незакрепленные узлы,теперь это сделать гораздо проще :)
for i:= 1 to kt[main_form.SN_Cbx.ItemIndex+1] do if ((nagruz[main_form.SN_Cbx.ItemIndex+1,i,3]=0)and(nagruz[main_form.SN_Cbx.ItemIndex+1,i,4]=0)) then
     begin
     DeleteNode(nagruz[main_form.SN_Cbx.ItemIndex+1,i,1],main_form.SN_Cbx.ItemIndex+1);
     repaint;
     end;

   {CurrentNode:=Plast_m.TPlast_Form(main_Form.ActiveMDIChild).CurrentNode;

  // нагрузки
        if plast.kx1>=plast.ky1 then
         begin
          jx:=(currentnode-1) div plast.ky1+1;
          jy:= currentnode-plast.ky1*(jx-1);
         end
        else
         begin
          jy:=(currentnode-1) div plast.kx1+1;
          jx:=currentnode-plast.kx1*(jy-1);
         end;
         max_x_coord:=round(plast.xm1[plast.kx1]);
         max_y_coord:=round(plast.ym1[plast.ky1]);

        ux:=50+coord_axis_x+(Plast_m.TPlast_Form(main_Form.ActiveMDIChild).paintbox.width-80-coord_axis_x)/max_x_coord*(plast.xm1[jx]){+31.25};
{        uy:=Plast_m.TPlast_Form(main_Form.ActiveMDIChild).paintbox.height-30-coord_axis_y-(Plast_m.TPlast_Form(main_Form.ActiveMDIChild).paintbox.height-60-coord_axis_y)/max_y_coord*(plast.ym1[jy]);

3:  if CurrentNode=0 then Exit;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  M.x:=Round(ux)+7;
  M.y:=Round(uy)+7;

  r.x:=Round(ux);
  r.y:=Round(uy);

  if CurrentNode=0 then Exit;
  forcenode_form.Top:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).y;
  forcenode_form.Left:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).x;

  if plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).y+forcenode_form.Height>Screen.Height then
   begin
     S.y:=r.y-7-forcenode_form.Height;
     S.x:=r.x+11;
     forcenode_form.Top:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).y;;
     forcenode_form.Left:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).x+forcenode_form.Width>Screen.Width then
   begin
     S.y:=r.y+7;
     S.x:=r.x-7-forcenode_form.Width;
     forcenode_form.Top:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).y;;
     forcenode_form.Left:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).x;
   end;
  if (plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).x+forcenode_form.Width>Screen.Width) and
     (plast_m.tplast_form(main_form.activemdichild).ClientToScreen(M).y+forcenode_form.Height>Screen.Height) then
   begin
     S.y:=r.y-7-forcenode_form.Height;
     S.x:=r.x-7-forcenode_form.Width;
     forcenode_form.Top:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).y;;
     forcenode_form.Left:=plast_m.tplast_form(main_form.activemdichild).ClientToScreen(S).x;
   end;


  if CurrentNode=0 then Exit;
  nz:=0;
  for i:=1 to plast.kl1 do
    if (plast.nomm[i]=CurrentNode)and(i=main_form.Plast_SN_Cbx.ItemIndex+1) then
      begin
        nz:=i;
        Break;
      end;
  if (nz=0) or (caption='Добавить нагружение') then //???????????????
    begin
      if plast.kl1=plast_max_for then
        begin
          MessageDlg('Слишком много нагруженных узлов',mtWarning,[mbOk],0);
          Exit;
        end;
      inc(plast.kl1);
      nz:=plast.kl1;
      plast.nomm[nz]:=CurrentNode;
      Main_Form.Plast_Sn_Cbx.Items.clear;
      for i:=1 to nz do  Main_Form.Plast_Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
      main_form.Plast_SN_Cbx.ItemIndex:=nz-1;
      //?????????????????????????
      if plast.kl1<=0 then main_form.plast_Sn_cbx.Enabled:=false
      else  main_form.plast_Sn_cbx.Enabled:=true;
  plast.os[nz]:=0;      
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
      Plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
        end//;!!!!!!!!!!!!!!!!!!!!!!!!
    else if nz<>main_form.Plast_SN_Cbx.ItemIndex+1 then
     begin
      main_form.Plast_SN_Cbx.ItemIndex:=nz-1;
      Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
      Plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
     end;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nz:=nz;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
   ForceNode_Form.showmodal;
  plast.os[nz]:=33;
  if plast.nom11[nz]=0 then plast.os[nz]:=22;
  if plast.nom22[nz]=0 then plast.os[nz]:=11;

// Убиваем незакрепленные узлы
  nz:=1;
  for i:=1 to plast.kl1 do
    if (plast.nom11[i]<>0)or(plast.nom22[i]<>0) then
      begin
        nom11[nz]:=plast.nom11[i];
        nom22[nz]:=plast.nom22[i];
        nomm[nz]:=plast.nomm[i];
        os[nz]:=plast.os[i];
        inc(nz);
      end
      else
       begin
         Main_Form.Plast_Sn_Cbx.Items.delete(plast.kl1-1);
         Plast_fd_form.Nagr_Nagr_ComboBox.Items.delete(plast.kl1-1);
         Main_Form.Plast_Sn_Cbx.Itemindex:= plast.kl1-2;
         Plast_fd_form.Nagr_Nagr_ComboBox.Itemindex:= plast.kl1-2;
          Plast_fd_form.NNagr_Edit.Text:= inttostr(plast.kl1-1);
       end;
  plast.kl1:=nz-1;
  for i:=1 to plast.kl1 do
    begin
        plast.nom11[i]:=nom11[i];
        plast.nom22[i]:=nom22[i];
        plast.nomm[i]:=nomm[i];
        plast.os[i]:=os[i];
    end;
     //plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
 if plast.kl1=0 then begin
  Main_Form.Plast_Sn_Cbx.clear;
  Main_Form.Plast_Sn_Cbx.Items.Add('Случай нагружения 1');
  Main_Form.Plast_Sn_Cbx.ItemIndex:=0;
 end;
  if plast.kl1<=0 then begin main_form.plast_Sn_cbx.Enabled:=false; end else  begin main_form.plast_Sn_cbx.Enabled:=true; end;
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(plast);
 Main_Form.ActiveMDIChild.RePaint;}
 //Main_Form.PlastNumberButton.Down:=False;
 //Main_Form.PlastNumberButtonClick(Sender);
end;
end;

procedure TAddForce_Form.FormShow(Sender: TObject);
begin
 number.text:='';
 number.SetFocus;
 AddForce_Form.Left:=plast_fd_form.Left+4;
 AddForce_Form.top:=plast_fd_form.top+138;
end;

procedure TAddForce_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if nf then
 begin
 main_form.NodesNum.Checked:=false;
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
 end;
end;

procedure TAddForce_Form.FormDeactivate(Sender: TObject);
begin
 if nf then
 begin
 main_form.NodesNum.Checked:=false;
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
 end;
end;

procedure TAddForce_Form.FormActivate(Sender: TObject);
begin
 nf:=false;
 if not main_form.NodesNum.Checked then
 begin
 //main_form.PlastNumberButtonclick(sender);
 main_form.NodesNum.Checked:=true;
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).repaint;
 nf:=true;
 end;
end;

end.
