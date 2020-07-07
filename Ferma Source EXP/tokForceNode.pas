unit tokForceNode;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, tok_M;

type
  TtokForceNode_Form = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    Nagr_Nagr_ComboBox: TComboBox;
    tokForceNode_ForceX_Edit: TEdit;
    tokForceNode_ForceY_Edit: TEdit;
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
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tokForceNode_Form: TtokForceNode_Form;

implementation

uses Main, tok_FD, ferm_dat;

{$R *.DFM}
procedure TtokForceNode_Form.Execute(sn:integer;var fx,fy:extended);
var
  fxo,fyo:single;
begin
  fxo:=fx; fyo:=fy;
  tokForceNode_ForceX_Edit.Text:=FormatFloat('0.######',fx);
  tokForceNode_ForceY_Edit.Text:=FormatFloat('0.######',fy);
  if ShowModal=mrOk then
    begin
      Main_Form.StatusBar1.Panels[1].Text :='';
      Main_Form.StatusBar1.Panels[2].Text :='';
      try
        fx:=StrToFloat(tokForceNode_ForceX_Edit.Text);
        fy:=StrToFloat(tokForceNode_ForceY_Edit.Text);
      except
        fx:=fxo; fy:=fyo;
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ����';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
      end;
    end;
end;




procedure TtokForceNode_Form.FormShow(Sender: TObject);
var
 i,node,sn:integer;
 tok:ttok;
begin
  tok:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
  tok_M.Ttok_Form(Main_Form.ActiveMDIChild).popa:=true;
  
  if tok.nsm>1 then nagr_nagr_combobox.Enabled:=True
   else nagr_nagr_combobox.Enabled:=False;

  LabelNsn.Caption:='�� '+IntToStr(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm);

  node:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).CurrentNode;
  Node_Label.Caption:='���� �'+IntToStr(node)+' ['+inttostr(tok_M.Ttok_Form(Main_Form.ActiveMdiChild).Xtok)+','+inttostr(tok_M.Ttok_Form(Main_Form.ActiveMdiChild).Ytok)+']';
   sn:=Main_Form.Sn_Cbx.ItemIndex+1;
   if sn<=0 then sn:=1;
               ////////////////////////////////////
       for i:= 1 to 9 do
     if (tok.xm[(sn-1)*9+i]=tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu])and(tok.ym[(sn-1)*9+i]=tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu])then
      break;
    //if i=10 then i:=(sn-1)*9+tok.n_nuz[sn]+1;
    if i=10 then i:=tok.n_nuz[sn]+1;
  tok.xm[(sn-1)*9+i]:=tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu];
  tok.ym[(sn-1)*9+i]:=tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu];

  tok.number[(sn-1)*9+i]:=node;
// if node=0 then node:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.count+1;

 tokForceNode_ForceX_Edit.Text:=FormatFloat('0.######',tok.Pn[(sn-1)*9+i,1]);
 tokForceNode_ForceY_Edit.Text:=FormatFloat('0.######',tok.Pn[(sn-1)*9+i,2]);
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=(sn-1)*9+i;

  Nagr_Nagr_ComboBox.Items.Clear;
   for i:=1 to tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm do
    begin
       Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
    end;
   Nagr_Nagr_ComboBox.ItemIndex:=sn-1;

  tokForceNode_ForceX_Edit.SelectAll;
  tokForceNode_ForceX_Edit.SetFocus;
end;




procedure TtokForceNode_Form.Nagr_PmPopup(Sender: TObject);
begin
 If tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm=1 then
   Nagr_PM.Items[1].Enabled:=False
  else Nagr_PM.Items[1].Enabled:=True;
 If tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm=3 then
   Nagr_PM.Items[0].Enabled:=False
  else Nagr_PM.Items[0].Enabled:=True;
end;




procedure TtokForceNode_Form.Nagr_Nagr_ComboBoxChange(Sender: TObject);
var
 node,sn,i,j:integer;
 tok:ttok;
begin
 tok:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
 Main_Form.Sn_CBx.ItemIndex:=Nagr_Nagr_ComboBox.ItemIndex;
  sn:=Main_Form.Sn_Cbx.ItemIndex+1;
  node:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).CurrentNode;
//
                       for i:=1 to 3 do
                        begin
                          tok.n_nuz[i]:=0;
                          for j:=1 to 9 do
                            if (tok.pn[(i-1)*9+j,1]<>0)or(tok.pn[(i-1)*9+j,2]<>0)then inc(tok.n_nuz[i]);
                        end;
    tok.n_nu:=tok.n_nuz[1];
    if tok.n_nuz[2]>tok.n_nu then tok.n_nu:=tok.n_nuz[2];
    if tok.n_nuz[3]>tok.n_nu then tok.n_nu:=tok.n_nuz[3];
    for i:= 1 to 9 do
     if (tok.xm[(sn-1)*9+i]=tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu])and(tok.ym[(sn-1)*9+i]=tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu])then
      break;
    if i=10 then i:=tok.n_nuz[sn]+1;



  tok.xm[(sn-1)*9+i]:=tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu];
  tok.ym[(sn-1)*9+i]:=tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu];

  tok.number[(sn-1)*9+i]:=node;
// if node=0 then node:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.count+1;


 tokForceNode_ForceX_Edit.Text:=FormatFloat('0.######',tok.Pn[(sn-1)*9+i,1]);
 tokForceNode_ForceY_Edit.Text:=FormatFloat('0.######',tok.Pn[(sn-1)*9+i,2]);
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=(sn-1)*9+i;

 tokForceNode_ForceX_Edit.SelectAll;
 tokForceNode_ForceX_Edit.SetFocus;

 tok_FD_form.showD(t);
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).sn:=nagr_nagr_combobox.ItemIndex+1;
 Main_Form.ActiveMDIChild.RePaint;
end;



procedure TtokForceNode_Form.BitBtn1Click(Sender: TObject);
var
 i,j:integer;
 error,flag:boolean;
 tok:ttok;
begin
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

// node:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).CurrentNode;
// if node=0 then node:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.count+1;
// sn:=Main_Form.Tok_Sn_Cbx.ItemIndex+1;

      error:=False;
      try
        tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.Pn[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu,2]:=StrToFloat(tokForceNode_ForceY_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� Y';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        error:=True;
        tokForceNode_ForceY_Edit.SelectAll;
        tokForceNode_ForceY_Edit.SetFocus;
      end;
      try
        tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.Pn[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu,1]:=StrToFloat(tokForceNode_ForceX_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� X';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        Error:=True;
        tokForceNode_ForceX_Edit.SelectAll;
        tokForceNode_ForceX_Edit.SetFocus;
      end;
      tok:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;

  if not error then
   begin
   flag:=false;
    tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
           for i:=1 to 3 do
            for j:=1 to tok.n_nuz[i]-1 do
             if (tok.pn[(i-1)*9+j,1]=0)and(tok.pn[(i-1)*9+j,2]=0)then
                begin
                  tok.pn[(i-1)*9+j,1]:=tok.pn[(i-1)*9+j+1,1];
                  tok.pn[(i-1)*9+j,2]:=tok.pn[(i-1)*9+j+1,2];
                  tok.xm[(i-1)*9+j]:=tok.xm[(i-1)*9+j+1];
                  tok.ym[(i-1)*9+j]:=tok.ym[(i-1)*9+j+1];
                  tok.xm[(i-1)*9+j+1]:=0;
                  tok.ym[(i-1)*9+j+1]:=0;
                  tok.pn[(i-1)*9+j+1,1]:=0;
                  tok.pn[(i-1)*9+j+1,2]:=0;
                  flag:=true;
                end;
                      for i:=1 to 3 do
                        begin
                          tok.n_nuz[i]:=0;
                          for j:=1 to 9 do
                            if (tok.pn[(i-1)*9+j,1]<>0)or(tok.pn[(i-1)*9+j,2]<>0)then inc(tok.n_nuz[i]);
                        end;

    tok.n_nu:=tok.n_nuz[1];
    if tok.n_nuz[2]>tok.n_nu then tok.n_nu:=tok.n_nuz[2];
    if tok.n_nuz[3]>tok.n_nu then tok.n_nu:=tok.n_nuz[3];
     if not flag then
      begin
       tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).xtok;
       tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).ytok;
      end;
      //!!!!!!!!!!!!!!!!!!!!!!!!!
    tok_m.ttok_form(main_form.ActiveMDIChild).sn:= main_form.sn_cbx.itemindex+1;
    tok_FD_form.showD(t);
    //tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok_number;
    Main_Form.ActiveMDIChild.RePaint;
    if flag then close;
   end;
end;

procedure TtokForceNode_Form.OK_BitBtnClick(Sender: TObject);
var
 i,j{,node,sn}:integer;
 error,flag:boolean;
 tok:ttok;
begin
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';

 //node:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).CurrentNode;
// if node=0 then node:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.count+1;
// sn:=Main_Form.Tok_Sn_Cbx.ItemIndex+1;

      error:=False;
      try
        tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.Pn[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu,2]:=StrToFloat(tokForceNode_ForceY_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� Y';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        error:=True;
        tokForceNode_ForceY_Edit.SelectAll;
        tokForceNode_ForceY_Edit.SetFocus;
      end;
      try
        tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.Pn[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu,1]:=StrToFloat(tokForceNode_ForceX_Edit.Text);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� X';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        Error:=True;
        tokForceNode_ForceX_Edit.SelectAll;
        tokForceNode_ForceX_Edit.SetFocus;
      end;
      tok:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;

  if not error then
   begin
    tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
    //!!!!!!!!!!!!!!!!!!!
    flag:=false;
                  for i:=1 to 3 do
            for j:=1 to tok.n_nuz[i]-1 do
             if (tok.pn[(i-1)*9+j,1]=0)and(tok.pn[(i-1)*9+j,2]=0)then
                begin
                  tok.pn[(i-1)*9+j,1]:=tok.pn[(i-1)*9+j+1,1];
                  tok.pn[(i-1)*9+j,2]:=tok.pn[(i-1)*9+j+1,2];
                  tok.xm[(i-1)*9+j]:=tok.xm[(i-1)*9+j+1];
                  tok.ym[(i-1)*9+j]:=tok.ym[(i-1)*9+j+1];
                  tok.xm[(i-1)*9+j+1]:=0;
                  tok.ym[(i-1)*9+j+1]:=0;
                  tok.pn[(i-1)*9+j+1,1]:=0;
                  tok.pn[(i-1)*9+j+1,2]:=0;
                  flag:=true;
                end;
                         //!!!!!!!!!!!!!!!!1
                      for i:=1 to 3 do
                        begin
                          tok.n_nuz[i]:=0;
                          for j:=1 to 9 do
                            if (tok.pn[(i-1)*9+j,1]<>0)or(tok.pn[(i-1)*9+j,2]<>0)then inc(tok.n_nuz[i]);
                        end;
    tok.n_nu:=tok.n_nuz[1];
    if tok.n_nuz[2]>tok.n_nu then tok.n_nu:=tok.n_nuz[2];
    if tok.n_nuz[3]>tok.n_nu then tok.n_nu:=tok.n_nuz[3];
    if not flag then
     begin
       tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).xtok;
       tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).ytok;
     end;
      //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    tok_m.ttok_form(main_form.ActiveMDIChild).sn:= main_form.sn_cbx.itemindex+1;
   { tok_FD_form.showD(t);
    tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok_number;
    Main_Form.ActiveMDIChild.RePaint;}
   end;

end;

procedure TtokForceNode_Form.Plus_NagrClick(Sender: TObject);
var
 i:integer;
begin
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm+1;
// tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Tag:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm;
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 Main_Form.sn_cbx.Items.Clear;
 for i:=1 to tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm do
  begin
   Main_Form.sn_cbx.Items.Add('������ ���������� '+IntToStr(i));
  end;
 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;
    if tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm<=1 then main_form.sn_cbx.Enabled:=false
     else  main_form.sn_cbx.Enabled:=true;
 Main_Form.sn_cbx.ItemIndex:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm-1;
  tok_m.ttok_form(main_form.ActiveMDIChild).sn:= main_form.sn_cbx.itemindex+1;
 Nagr_Nagr_ComboBox.ItemIndex:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm-1;
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=Nagr_Nagr_ComboBox.ItemIndex*9+1;
 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).currentnode:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.count+1;
 tok_FD_form.showD(t);
 repaint;
 Main_Form.ActiveMDIChild.RePaint;

end;

procedure TtokForceNode_Form.Minus_NagrClick(Sender: TObject);
var
 i,i_del,j,xmi,ymi:integer;
 tok:ttok;
begin
 tok:= tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
 i_del:=Nagr_Nagr_Combobox.itemindex+1;
 xmi:=round(tok.xm[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]);
 ymi:=round(tok.ym[tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu]);

  for i:= 1 to 9 do
    begin
     tok.xm[(i_del-1)*9+i]:=0;
     tok.ym[(i_del-1)*9+i]:=0;
     tok.pn[(i_del-1)*9+i,1]:=0;
     tok.pn[(i_del-1)*9+i,2]:=0;
    end;

    tok.n_nuz[i_del]:=0;
    tok.n_nu:=tok.n_nuz[1];
    if tok.n_nuz[2]>tok.n_nu then tok.n_nu:=tok.n_nuz[2];
    if tok.n_nuz[3]>tok.n_nu then tok.n_nu:=tok.n_nuz[3];

 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
 for i:=i_del+1 to tok.nsm do
  begin
   for j:=1 to 9 do
    begin
     tok.xm[(i-2)*9+j]:=tok.xm[(i-1)*9+j];
     tok.ym[(i-2)*9+j]:=tok.ym[(i-1)*9+j];
     tok.pn[(i-2)*9+j,1]:=tok.pn[(i-1)*9+j,1];
     tok.pn[(i-2)*9+j,2]:=tok.pn[(i-1)*9+j,2];
        end;
  end;

 tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm-1;


 Main_Form.sn_cbx.Items.Clear;
 for i:=1 to tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm do
  begin
   Main_Form.sn_cbx.Items.Add('������ ���������� '+IntToStr(i));
  end;
 Nagr_Nagr_ComboBox.Items.Clear;
 for i:=1 to tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok.nsm do
  begin
   Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
  end;

  Main_Form.sn_cbx.ItemIndex:=0;
  Nagr_Nagr_ComboBox.ItemIndex:=0;
   tok_m.ttok_form(main_form.ActiveMDIChild).sn:= main_form.sn_cbx.itemindex+1;


  for i:=1 to tok.n_nuz[1] do
   if (xmi=round(tok.xm[i])) and (ymi=round(tok.ym[i])) then
     tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=i;
   if i=10 then close;
   if i>tok.n_nuz[1] then tok_M.Ttok_Form(Main_Form.ActiveMDIChild).nu:=tok.n_nuz[1]+1;

 tok_FD_form.showD(t);
 Repaint;
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok_number;
 Main_Form.ActiveMDIChild.RePaint;

end;

procedure TtokForceNode_Form.FormDeactivate(Sender: TObject);
begin
// tok_m.ttok_form(main_form.ActiveMDIChild).sn:= main_form.tok_sn_cbx.itemindex+1;
end;

end.
