unit tokRegionSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, tok_M, Ferm_Dat, tok_Fd;

type
  TtokRegionSizeForm = class(TForm)
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
    razm_label: TLabel;
    procedure OkSizeBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  tokRegionSizeForm: TtokRegionSizeForm;
  function isNumber(s:string; xy: string):boolean;

implementation

uses Main, Buffer;



{$R *.DFM}


function isNumber(s:string; xy: string):boolean;
var
 t:Ttok;
 max_x_coord,max_y_coord:extended;
 i:integer;
begin

 t:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
 max_x_coord:=0;
 max_y_coord:=0;
  for i:= 1 to 36 do
   begin
    if t.xm[i]>max_x_coord then max_x_coord:=t.xm[i];
    if t.ym[i]>max_y_coord then max_y_coord:=t.ym[i];
   end;
  Result:=true;
  try
    StrToFloat(s);
  except
    Result:=false;
  end;

  if Result=True then
   begin
         if xy='x' then
     begin
      if (StrToFloat(s)<max_x_coord) or (StrToFloat(s)=0) then Result:=False;
     end
    else
     begin
      if (StrToFloat(s)<max_y_coord) or (StrToFloat(s)=0) then Result:=False;
     end;

     if (StrToFloat(s)>9999.99) then Result:=False;

   end;

end;

procedure TtokRegionSizeForm.OkSizeBtnClick(Sender: TObject);
var
 t:Ttok;
 x,y:boolean;
begin
 t:=tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok;
 x:=isNumber(XSize.Text,'x');
 y:=isNumber(YSize.Text,'y');
 if x and y  then
  begin
   t.xm[37]:=StrToFloat(XSize.Text);
   t.ym[37]:=StrToFloat(YSize.Text);
   tok_FD_Form.ShowD(t);
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.T_Save_TBtn.Enabled:=true;
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Repaint;
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
  end
 else if x  then
  begin
   t.xm[37]:=StrToFloat(XSize.Text);
   tok_FD_Form.ShowD(t);
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.T_Save_TBtn.Enabled:=true;
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Repaint;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по Y';
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
  end
 else if y {and (t.ym1[t.ky1-1]<StrToFloat(YSize.Text))} then
  begin
   t.ym[37]:=StrToFloat(YSize.Text);
   tok_FD_Form.ShowD(t);
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   Main_Form.T_Save_TBtn.Enabled:=true;
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).Repaint;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X';
   tok_M.Ttok_Form(Main_Form.ActiveMDIChild).buf.AddT(tok_M.Ttok_Form(Main_Form.ActiveMDIChild).tok);
  end

  else
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X и Y';

end;

end.
