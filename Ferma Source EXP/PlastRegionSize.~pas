unit PlastRegionSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Plast_M, Ferm_Dat, Plast_Fd;

type
  TPlastRegionSizeForm = class(TForm)
    Bevel1: TBevel;
    XSize: TEdit;
    YSize: TEdit;
    MinX_L: TLabel;
    MaxX_L: TLabel;
    MinY_L: TLabel;
    MaxY_L: TLabel;
    OkSizeBtn: TBitBtn;
    CancelSizeBtn: TBitBtn;
    Bevel2: TBevel;
    SizeLabel: TLabel;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    nt_edt: TEdit;
    razm_label: TLabel;
    Label4: TLabel;
    procedure OkSizeBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  PlastRegionSizeForm: TPlastRegionSizeForm;
  function isNumber(s:string; xy: string):boolean;

implementation

uses Main;



{$R *.DFM}


function isNumber(s:string; xy: string):boolean;
begin
  Result:=true;
  try
    StrToFloat(s);
  except
    Result:=false;
  end;
  if Result=True then
   begin

    if (xy='z') and ((StrToFloat(s)<=0) or (StrToFloat(s)>9999.99)) then Result:=False;
     if (StrToFloat(s)>9999.99) then Result:=False;

   end;

end;

procedure TPlastRegionSizeForm.OkSizeBtnClick(Sender: TObject);
var
 p:TPlast;
 x,y,z:boolean;
begin
 p:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast;
 Main_Form.StatusBar1.Panels[1].Text :='';
 x:=isNumber(XSize.Text,'x');
 y:=isNumber(YSize.Text,'y');
 z:=isNumber(YSize.Text,'z');
 if z and x and y and (p.xm1[p.kx1-1]<StrToFloat(XSize.Text)) and (p.ym1[p.ky1-1]<StrToFloat(YSize.Text)) then
  begin
   p.xm1[p.kx1]:=StrToFloat(XSize.Text);
   p.ym1[p.ky1]:=StrToFloat(YSize.Text);
   p.ton1:=StrToFloat(nt_edt.Text);
   Plast_FD_Form.ShowD(p);
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.P_Save_TBtn.Enabled:=true;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Repaint;
  end
 else if x and (p.xm1[p.kx1-1]<StrToFloat(XSize.Text)) then
  begin
   p.xm1[p.kx1]:=StrToFloat(XSize.Text);
   Plast_FD_Form.ShowD(p);
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.P_Save_TBtn.Enabled:=true;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Repaint;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по Y';
  end
 else if y and (p.ym1[p.ky1-1]<StrToFloat(YSize.Text)) then
  begin
   p.ym1[p.ky1]:=StrToFloat(YSize.Text);
   Plast_FD_Form.ShowD(p);
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.P_Save_TBtn.Enabled:=true;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Repaint;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X';
  end
  else if x and (p.xm1[p.kx1-1]>=StrToFloat(XSize.Text)) then
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка! Исчезает разбиение по X'
  else if y and (p.ym1[p.ky1-1]>=StrToFloat(YSize.Text)) then
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка! Исчезает разбиение по Y'
  else if not z then
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе начальной толщины'
  else
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X и Y';

end;

end.
