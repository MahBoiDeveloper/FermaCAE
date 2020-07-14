unit FermaRegionSize;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferma_M, Ferm_Dat, Ferma_Fd;

type
  TFermaRegionSizeForm = class(TForm)
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
    procedure OkSizeBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FermaRegionSizeForm: TFermaRegionSizeForm;
  function isNumber(s:string; xy: string):boolean;

implementation

uses Main;



{$R *.DFM}


function isNumber(s:string; xy: string):boolean;
var
 f:TFerm;
 max_x_coord,max_y_coord:extended;
 i:integer;
begin
 max_x_coord:=0;
 max_y_coord:=0;
 f:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm;
 for i:=1 to f.nyz1 do
  begin
   if f.corn[i,1]>=max_x_coord then max_x_coord:=f.corn[i,1];
   if f.corn[i,2]>=max_y_coord then max_y_coord:=f.corn[i,2];
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

procedure TFermaRegionSizeForm.OkSizeBtnClick(Sender: TObject);
var
 f:Tferm;
 x,y:boolean;
begin
 f:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).ferm;
 x:=isNumber(XSize.Text,'x');
 y:=isNumber(YSize.Text,'y');
 Main_Form.StatusBar1.Panels[1].Text :='';
 Main_Form.StatusBar1.Panels[2].Text :='';
 if x and y then
  begin
   XSize.Text:=FormatFloat('0.##',StrToFloat(XSize.Text));
   YSize.Text:=FormatFloat('0.##',StrToFloat(YSize.Text));
   f.region_x:=StrToFloat(XSize.Text);
   f.region_y:=StrToFloat(YSize.Text);
   Ferma_FD_Form.ShowD(f);
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
  end
 else if x then
  begin
   XSize.Text:=FormatFloat('0.##',StrToFloat(XSize.Text));
   f.region_x:=StrToFloat(XSize.Text);
   Ferma_FD_Form.ShowD(f);
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по Y';
   Main_Form.StatusBar1.Panels[2].Text :='';
   Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
  end
 else if y then
  begin
   YSize.Text:=FormatFloat('0.##',StrToFloat(YSize.Text));
   f.region_y:=StrToFloat(YSize.Text);
   Ferma_FD_Form.ShowD(f);
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).isChanged:=True;
   ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).Caption:=concat(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).real_fname,'*');
   Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Repaint;
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X';
   Main_Form.StatusBar1.Panels[2].Text :='';
   Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Buf.Add(Ferma_M.Tferma_form(Main_Form.ActiveMDIChild).Ferm);
  end
 else
  begin
   Beep;
   Main_Form.StatusBar1.Panels[1].Text :='Ошибка при вводе размера области по X и Y';
   Main_Form.StatusBar1.Panels[2].Text :='';
  end;


end;

procedure TFermaRegionSizeForm.FormShow(Sender: TObject);
begin
XSize.SetFocus;
XSize.SelectAll;
end;

end.
