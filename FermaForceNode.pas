unit FermaForceNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, Ferma_M;

type
  TFermaForceNode_Form = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Nagr_Nagr_ComboBox: TComboBox;
    FermaForceNode_ForceX_Edit: TEdit;
    FermaForceNode_ForceY_Edit: TEdit;
    XLabel: TLabel;
    YLabel: TLabel;
    Cancel_BitBtn: TBitBtn;
    OK_BitBtn: TBitBtn;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Nagr_Pm: TPopupMenu;
    Plus_Nagr: TMenuItem;
    Minus_Nagr: TMenuItem;
    BitBtn1: TBitBtn;
    LabelNSN: TLabel;
    Node_Label: TLabel;
    procedure Execute(sn:integer;var fx,fy:extended);
    procedure FormShow(Sender: TObject);
    procedure Nagr_PmPopup(Sender: TObject);
    procedure Nagr_Nagr_ComboBoxChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure OK_BitBtnClick(Sender: TObject);
    procedure Plus_NagrClick(Sender: TObject);
    procedure Minus_NagrClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FermaForceNode_Form: TFermaForceNode_Form;

implementation

uses Main, Ferma_FD;

{$R *.DFM}
procedure TFermaForceNode_Form.Execute(sn:integer;var fx,fy:extended);
var
  fxo,fyo:single;
begin
  fxo:=fx; fyo:=fy;
  FermaForceNode_ForceX_Edit.Text:=FormatFloat('0.######',fx);
  FermaForceNode_ForceY_Edit.Text:=FormatFloat('0.######',fy);
  if ShowModal=mrOk then
    begin
      Main_Form.StatusBar1.Panels[1].Text :='';
      Main_Form.StatusBar1.Panels[2].Text :='';
      try
        fx:=StrToFloat(FermaForceNode_ForceX_Edit.Text);
        fy:=StrToFloat(FermaForceNode_ForceY_Edit.Text);
      except
        fx:=fxo; fy:=fyo;
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
      end;
    end;
end;

procedure TFermaForceNode_Form.FormShow(Sender: TObject);
var
 i,node,sn:integer;
begin

  LabelNsn.Caption:='из '+IntToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1);

  node:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).CurrentNode;
  Node_Label.Caption:='Узел №'+IntToStr(node);
  sn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag;
  FermaForceNode_ForceX_Edit.Text:={FormatFloat('0.######',}FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2-1,sn]);
  FermaForceNode_ForceY_Edit.Text:={FormatFloat('0.######',}FloatToStr(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2,sn]);

  Nagr_Nagr_ComboBox.Items.Clear;
   for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nsn1 do
    begin
       Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
    end;
   Nagr_Nagr_ComboBox.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;

 if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1=1 then Nagr_Nagr_ComboBox.Enabled:=False
  else Nagr_Nagr_ComboBox.Enabled:=True;
     
  FermaForceNode_ForceX_Edit.SelectAll;
  FermaForceNode_ForceX_Edit.SetFocus;
end;

procedure TFermaForceNode_Form.Nagr_PmPopup(Sender: TObject);
begin
 If Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nsn1=1 then
   Nagr_PM.Items[1].Enabled:=False
  else Nagr_PM.Items[1].Enabled:=True;
 If Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm.nsn1=3 then
   Nagr_PM.Items[0].Enabled:=False
  else Nagr_PM.Items[0].Enabled:=True;
end;

procedure TFermaForceNode_Form.Nagr_Nagr_ComboBoxChange(Sender: TObject);
var
 node,sn:integer;
begin
 Main_Form.Sn_CBx.ItemIndex:=Nagr_Nagr_ComboBox.ItemIndex;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag:=Nagr_Nagr_ComboBox.ItemIndex+1;

 node:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).CurrentNode;
 sn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag;
 FermaForceNode_ForceX_Edit.Text:=FormatFloat('0.######',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2-1,sn]);
 FermaForceNode_ForceY_Edit.Text:=FormatFloat('0.######',Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2,sn]);

 FermaForceNode_ForceX_Edit.SelectAll;
 FermaForceNode_ForceX_Edit.SetFocus;

 ferma_FD_form.showD(f);
 Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
 Main_Form.ActiveMDIChild.RePaint;
end;



procedure TFermaForceNode_Form.BitBtn1Click(Sender: TObject);
var
 node,sn:integer;
 error:boolean;
begin
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

 node:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).CurrentNode;
 sn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag;

      error:=False;
      try
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2,sn]:=StrToFloat(FermaForceNode_ForceY_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по Y';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        FermaForceNode_ForceY_Edit.SelectAll;
        FermaForceNode_ForceY_Edit.SetFocus;
      end;
      try
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2-1,sn]:=StrToFloat(FermaForceNode_ForceX_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по X';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=true;
        FermaForceNode_ForceX_Edit.SelectAll;
        FermaForceNode_ForceX_Edit.SetFocus;
      end;
  if not error then
   begin
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
    ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
    ferma_FD_form.showD(f);
    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
    Main_Form.ActiveMDIChild.RePaint;
   end;

end;

procedure TFermaForceNode_Form.OK_BitBtnClick(Sender: TObject);
var
 node,sn:integer;
 error:boolean;
begin
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

 node:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).CurrentNode;
 sn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag;

      error:=False;
      try
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2,sn]:=StrToFloat(FermaForceNode_ForceY_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по Y';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        error:=True;
        FermaForceNode_ForceY_Edit.SelectAll;
        FermaForceNode_ForceY_Edit.SetFocus;
      end;
      try
        Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[node*2-1,sn]:=StrToFloat(FermaForceNode_ForceX_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе силы по X';
        Main_Form.StatusBar1.Panels[2].Text :='Было введено не число';
        Error:=True;
        FermaForceNode_ForceX_Edit.SelectAll;
        FermaForceNode_ForceX_Edit.SetFocus;
      end;

  if not error then
   begin
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
    ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
    ferma_FD_form.showD(f);
    Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
    Main_Form.ActiveMDIChild.RePaint;
   end;
         
end;

procedure TFermaForceNode_Form.Plus_NagrClick(Sender: TObject);
var
 i:integer;
begin
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1+1;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');

 Main_Form.Sn_Cbx.Items.Clear;
 for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1 do
  begin
   Main_Form.Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
  end;
  if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1=1 then  Main_Form.Sn_Cbx.Enabled:=False
   else Main_Form.Sn_Cbx.Enabled:=True;

 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1 do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;
 if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1=1 then Nagr_Nagr_ComboBox.Enabled:=False
  else Nagr_Nagr_ComboBox.Enabled:=True;

 Main_Form.Sn_Cbx.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;
 Nagr_Nagr_ComboBox.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;

 ferma_FD_form.showD(f);
 repaint;
 Main_Form.ActiveMDIChild.RePaint;

end;

procedure TFermaForceNode_Form.Minus_NagrClick(Sender: TObject);
var
 i,i_del,j:integer;
begin
 i_del:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
 for i:=i_del+1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1 do
  begin
   for j:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do
    begin
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2-1,i-1]:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2-1,i];
     Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2,i-1]:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2,i];
    end;
  end;

  for j:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nyz1 do
   begin
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2-1,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1]:=0;
    Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.Pn[j*2,Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1]:=0;
   end;

 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1-1;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag:=1;
 Main_Form.Sn_Cbx.Items.Clear;
 
 for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1 do
  begin
   Main_Form.Sn_Cbx.Items.Add('Случай нагружения '+IntToStr(i));
  end;
  if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1=1 then  Main_Form.Sn_Cbx.Enabled:=False
   else Main_Form.Sn_Cbx.Enabled:=True;

 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1 do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;
 if Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm.nsn1=1 then Nagr_Nagr_ComboBox.Enabled:=False
  else Nagr_Nagr_ComboBox.Enabled:=True;
  
 Main_Form.Sn_Cbx.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;
 Nagr_Nagr_ComboBox.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;

 ferma_FD_form.showD(f);
 Repaint;
 Main_Form.ActiveMDIChild.RePaint;

end;

end.
