unit ForcNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Menus;

type
  TForceNode_Form = class(TForm)
    Label1: TLabel;
    Sn_Lbl: TLabel;
    XLabel: TLabel;
    YLabel: TLabel;
    ForceX_Edt: TEdit;
    ForceY_Edt: TEdit;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Ok_Btn: TBitBtn;
    Cancel_Btn: TBitBtn;
    Bevel4: TBevel;
    Node_Label: TLabel;
    BitBtn1: TBitBtn;
    Nagr_Nagr_ComboBox: TComboBox;
    Nagr_Pm: TPopupMenu;
    Plus_Nagr: TMenuItem;
    Minus_Nagr: TMenuItem;
    Nagr_Nagr_Label: TLabel;
    BitBtn2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Nagr_Nagr_ComboBoxChange(Sender: TObject);
//    procedure BitBtn1Click(Sender: TObject);  Убрана за ненадобностью
    procedure Plus_NagrClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Ok_BtnClick(Sender: TObject);
    procedure Nagr_PmPopup(Sender: TObject);
    procedure Minus_NagrClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
    procedure Execute(sn:integer;var fx,fy:extended);
  end;

var
  ForceNode_Form: TForceNode_Form;


implementation

uses
Plast_M, Main, Ferm_dat, Plast_FD;

var
plast:TPlast;
nz:integer;

{$R *.DFM}

procedure TForceNode_Form.Execute(sn:integer;var fx,fy:extended);
var
  fxo,fyo:single;

begin

  Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
  fxo:=fx; fyo:=fy;
 ForceX_Edt.Text:='';
 ForceY_Edt.Text:='';
//  ForceX_Edt.Text:=FormatFloat('0.##',fx);
//  ForceY_Edt.Text:=FormatFloat('0.##',fy);
  Sn_Lbl.Caption:='из '+IntToStr(plast_M.Tplast_Form(Main_Form.ActiveMdiChild).kl);
  if ShowModal=mrOk then
    begin
      try
        fx:=StrToFloat(ForceX_Edt.Text);
        fy:=StrToFloat(ForceY_Edt.Text);
      except
        fx:=fxo; fy:=fyo;
        MessageDlg('Ошибка во введенных данных',mtError,[mbOk],0);
      end;
    end;
end;

procedure TForceNode_Form.FormActivate(Sender: TObject);
var
i:integer;
x,y:integer;
p:tplast;
begin
p:=plast_M.Tplast_Form(Main_Form.ActiveMdiChild).plast;
i:=plast_M.Tplast_Form(Main_Form.ActiveMdiChild).CurrentNode;
if p.kx1>=p.ky1 then
 begin
  x:=round(int((i-1)/p.ky1)+0.1)+1;
  y:=round(int(i-(x-1)*p.ky1)+0.1);
 end
else
 begin
  y:=round(int((i-1)/p.kx1)+0.1)+1;
  x:=round(int(i-(y-1)*p.kx1)+0.1);
 end;
  Node_Label.Caption:='Узел №'+IntToStr(i)+' [ '+floattostr(p.xm1[x])+' , '+floattostr(p.ym1[y])+' ]';
end;

procedure TForceNode_Form.FormShow(Sender: TObject);
//var
{i:integer; }
begin
{ Nagr_Nagr_ComboBox.Items.Clear;
   for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1 do
    begin
       Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
    end;
   Nagr_Nagr_ComboBox.ItemIndex:=Main_Form.Plast_Sn_Cbx.ItemIndex;}
      ForceX_Edt.SetFocus;

      Nagr_Nagr_Label.caption:=inttostr(Main_Form.Sn_Cbx.ItemIndex+1);

end;

procedure TForceNode_Form.Nagr_Nagr_ComboBoxChange(Sender: TObject);
var
 {node,}sn:integer;
begin
 Main_Form.Sn_CBx.ItemIndex:=Nagr_Nagr_ComboBox.ItemIndex;
// Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag:=Nagr_Nagr_ComboBox.ItemIndex+1;

{ node:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).CurrentNode;}
 sn:=Nagr_Nagr_ComboBox.ItemIndex+1;
 ForceX_Edt.Text:=FormatFloat('0.##',Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom11[sn]);
 ForceY_Edt.Text:=FormatFloat('0.##',Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom22[sn]);
 Node_Label.Caption:='Узел №'+IntToStr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nomm[sn]);
 ForceX_Edt.SelectAll;
 ForceX_Edt.SetFocus;

// plast_FD_form.showD(plast);
 Main_Form.ActiveMDIChild.RePaint;

end;

// И зачем кнопке "изменить" свой обработчик Onclick,если она делает то же самое,что и кнопка OK?
//procedure TForceNode_Form.BitBtn1Click(Sender: TObject);
{var
 {node,}{sn:integer;
 error:boolean;
  i,nz:integer;
  nomm,os:array[1..plast_max_for] of integer; // Нагрузки (номер узла, признак нагружения(по X - 11, по Y - 22, по X и Y - 33), по X, по y)
  nom11,nom22:array[1..plast_max_for] of single;
  begin
{ Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

 {node:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).CurrentNode;}
 //sn:=Nagr_Nagr_ComboBox.ItemIndex+1;
{ sn:=strtoint(Nagr_Nagr_Label.caption);

      error:=False;
      try
        Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom22[sn]:=StrToFloat(ForceY_Edt.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по Y';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        ForceY_Edt.SelectAll;
        ForceY_Edt.SetFocus;
      end;
      try
        Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom11[sn]:=StrToFloat(ForceX_Edt.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по X';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        ForceX_Edt.SelectAll;
        ForceX_Edt.SetFocus;
      end;
  if not error then
   begin
    plast.os[sn]:=33;
   if plast.nom11[sn]=0 then plast.os[sn]:=22;
   if plast.nom22[sn]=0 then plast.os[sn]:=11;
   if (plast.nom22[sn]=0) and (plast.nom11[sn]=0) then plast.os[sn]:=0;
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
        nom11[nz]:=plast.nom11[i];
        nom22[nz]:=plast.nom22[i];
        nomm[nz]:=plast.nomm[i];
        os[nz]:=plast.os[i];
        inc(nz);{
         Main_Form.Plast_Sn_Cbx.Items.delete(plast.kl1-1);
         Plast_fd_form.Nagr_Nagr_ComboBox.Items.delete(plast.kl1-1);
         Main_Form.Plast_Sn_Cbx.Itemindex:= plast.kl1-2;
         Plast_fd_form.Nagr_Nagr_ComboBox.Itemindex:= plast.kl1-2;
          Plast_fd_form.NNagr_Edit.Text:= inttostr(plast.kl1-1);
       }{end;
  plast.kl1:=nz-1; }
  {for i:=1 to plast.kl1 do
    begin
        plast.nom11[i]:=nom11[i];
        plast.nom22[i]:=nom22[i];
        plast.nomm[i]:=nomm[i];
        plast.os[i]:=os[i];
    end;
     plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
     Main_Form.ActiveMDIChild.RePaint;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
    {Plast_FD_form.showD(plast);
    Main_Form.ActiveMDIChild.RePaint;}
   {end;
//????????????????????????????????????????????????????
   if plast.kl1<=0 then main_form.plast_Sn_cbx.Enabled:=false
  else  main_form.plast_Sn_cbx.Enabled:=true;


  end;}

procedure TForceNode_Form.Plus_NagrClick(Sender: TObject);
var
 i:integer;
begin
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1+1;
{ Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Tag:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kz1;}
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 Main_Form.Sn_Cbx.Items.Clear;
 for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1 do
  begin
   Main_Form.Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
  end;
 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1 do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;
 nagr_nagr_label.Caption:=floattostr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1);
 Main_Form.Sn_Cbx.ItemIndex:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1-1;
{ Nagr_Nagr_ComboBox.ItemIndex:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Tag-1;}
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nomm[Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).currentnode;
 {Plast_FD_form.showD(Plast);}
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nz:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kl1;
 //repaint;
 Plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
 //Main_Form.ActiveMDIChild.RePaint;

end;



procedure TForceNode_Form.FormPaint(Sender: TObject);
var  form:TPlast_Form;
begin
form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
nz:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nz;
 Plast:= Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
//fxo:=fx; fyo:=fy;
//  ForceX_Edt.Text:=FormatFloat('0.##',plast.nom11[nz]{fx});
//  ForceY_Edt.Text:=FormatFloat('0.##',plast.nom22[nz]{fy});
    ForceY_edt.Text:=inttostr(form.old2);
    ForceX_edt.Text:=inttostr(form.old1);
    form.old1:=0;
    form.old2:=0;
Sn_Lbl.Caption:='из '+IntToStr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl);
end;

procedure TForceNode_Form.Ok_BtnClick(Sender: TObject);
var
 {node,}sn:integer;
 error:boolean;
  i,nz,code:integer;
  nomm,os:array[1..plast_max_for] of integer; // Нагрузки (номер узла, признак нагружения(по X - 11, по Y - 22, по X и Y - 33), по X, по y)
  nom11,nom22:array[1..plast_max_for] of single;
  form:TPlast_Form;
begin
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';


 {node:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).CurrentNode;}
 //sn:=Nagr_Nagr_ComboBox.ItemIndex+1;
//sn:=strtoint(Nagr_Nagr_Label.caption);
//sn:=0;
//for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl do sn:=sn+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kt[i];
form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
//kl:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl;
//for i:=i to 3 do kt[i]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kt[i];


      error:=False;
      try
        val(ForceY_Edt.Text,form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],4],code);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по Y';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        ForceY_Edt.SelectAll;
        ForceY_Edt.SetFocus;
      end;
      try
        val(ForceX_Edt.Text,form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],3],code);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по X';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        ForceX_Edt.SelectAll;
        ForceX_Edt.SetFocus;
      end;
  if not error then
   begin
    form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],2]:=33;
    if form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],3]=0 then form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],2]:=22;
    if form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],4]=0 then form.nagruz[main_form.SN_Cbx.ItemIndex+1,form.kt[main_form.SN_Cbx.ItemIndex+1],2]:=11;
   form.initialize;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;


{   // Убиваем незакрепленные узлы
ВО ПЕРВЫХ НЕ НАГРУЖЕННЫЕ УЗЛЫ.
ВОТ ВТОРЫХ   ЧТО ОПЯТЬ? МЫ ЖЕ ИХ СРАЗУ ПОСЛЕ ВОЗВРАТА УПРАВЛЕНИЯ ДОЧЕРНЕМУ ОКНУ СНОВА УБИВАЕМ.....КАКИЕ ЖИВУЧИЕ УЗЛЫ!!!! :)))
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
        nom11[nz]:=plast.nom11[i];
        nom22[nz]:=plast.nom22[i];
        nomm[nz]:=plast.nomm[i];
        os[nz]:=plast.os[i];
        inc(nz);
       end;
  {plast.kl1:=nz-1; }
{  for i:=1 to plast.kl1 do
    begin
        plast.nom11[i]:=nom11[i];
        plast.nom22[i]:=nom22[i];
        plast.nomm[i]:=nomm[i];
        plast.os[i]:=os[i];
    end;
     plast_FD_form.showD(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast);
     Main_Form.ActiveMDIChild.RePaint;
    Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
    {Plast_FD_form.showD(plast);
    Main_Form.ActiveMDIChild.RePaint;}
   end;

end;

procedure TForceNode_Form.Nagr_PmPopup(Sender: TObject);
begin
 If plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1=1 then
   Nagr_PM.Items[1].Enabled:=False
  else Nagr_PM.Items[1].Enabled:=True;
 If plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1=3 then
   Nagr_PM.Items[0].Enabled:=False
  else Nagr_PM.Items[0].Enabled:=True;
end;



procedure TForceNode_Form.Minus_NagrClick(Sender: TObject);
var
 i,i_del,{j,}xmi{,ymi}:integer;
 plast:tplast;
begin
 plast:= plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast;
 i_del:=strtoint(Nagr_Nagr_label.caption);
{ xmi:=round(plast.xm1[plast_M.Tplast_Form(Main_Form.ActiveMDIChild).nz]);
 ymi:=round(plast.ym1[plast_M.Tplast_Form(Main_Form.ActiveMDIChild).nz]);}


     plast.nomm[i_del]:=0;
     plast.os[i_del]:=0;
     xmi:= plast.nomm[i_del];
    // ymi:= plast.nom22[i_del];
     plast.nom11[i_del]:=0;
     plast.nom22[i_del]:=0;
 plast_M.Tplast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 for i:=i_del to plast.kl1-1 do
  begin
     plast.nomm[i]:=plast.nomm[i+1];
     plast.os[i]:=plast.os[i+1];
     plast.nom11[i]:=plast.nom11[i+1];
     plast.nom22[i]:=plast.nom22[i+1];

  end;

  for i:=plast.kl1 to plast_max_for do
  begin
     plast.nomm[i]:=0;
     plast.os[i]:=0;
     plast.nom11[i]:=0;
     plast.nom22[i]:=0;

  end;

 plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1:=plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1-1;


 Main_Form.Sn_Cbx.Items.Clear;
 for i:=1 to plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1 do
  begin
   Main_Form.Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
  end;
 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast.kl1 do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;

  Main_Form.Sn_Cbx.ItemIndex:=0;
  Nagr_Nagr_ComboBox.ItemIndex:=0;

   if (xmi=plast.nomm[1]) then
     plast_M.Tplast_Form(Main_Form.ActiveMDIChild).nz:=plast.nomm[1]
   else close;

plast_FD_form.showD(plast);
 Repaint;
    Main_Form.ActiveMDIChild.RePaint;


end;

procedure TForceNode_Form.BitBtn2Click(Sender: TObject);
var   form:TPlast_Form;
begin
form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
forceY_Edt.Text:='0';
forceX_Edt.Text:='0';
Ok_btn.Click;
end;

end.
