unit PlastNewMat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, plast_FD, plast_M;

type
  TplastNewMatForm = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    plastNewMatName: TEdit;
    Label1: TLabel;
    plastNewMatModUpr: TEdit;
    plastNewMatDopNapr: TEdit;
    MUL: TLabel;
    DNL: TLabel;
    plastNewMatKoefPuas: TEdit;
    KPL: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  plastNewMatForm: TplastNewMatForm;

implementation

uses Main;

{$R *.DFM}


procedure TplastNewMatForm.FormShow(Sender: TObject);
begin
 if plast_Fd_Form.Material_ComboBox.Items[plast_Fd_Form.Material_ComboBox.ItemIndex]='<������>' Then
  begin
    plastNewMatName.Text:='<������>';
    plastNewMatName.SetFocus;
    plastNewMatName.SelectAll;
    plastNewMatModUpr.Text:=plast_Fd_Form.ModUpr_Edit.Text;
    plastNewMatDopNapr.Text:=plast_Fd_Form.DopNapr_Edit.Text;
    plastNewMatKoefPuas.Text:=plast_Fd_Form.KoefPuass_Edt.Text;
  end
 else
  begin
    plastNewMatName.Text:='';
    plastNewMatModUpr.Text:='';
    plastNewMatDopNapr.Text:='';
    plastNewMatKoefPuas.Text:='';
    plastNewMatName.SetFocus;
  end;
  MUL.Caption:='������ ��������� ['+plast_M.Tplast_Form(Main_Form.ActiveMdiChild).Plast.s_for+'/'+
                                    plast_M.Tplast_Form(Main_Form.ActiveMdiChild).Plast.s_lin+'**2]';
  DNL.Caption:='����������� ���������� ['+plast_M.Tplast_Form(Main_Form.ActiveMdiChild).Plast.s_for+'/'+
                                          plast_M.Tplast_Form(Main_Form.ActiveMdiChild).Plast.s_lin+'**2]';
end;

procedure TplastNewMatForm.BitBtn1Click(Sender: TObject);
var
 i:integer;
 error:boolean;
begin
error:=False;
// �������� �� ���
 if  plastNewMatName.Text='' then
  begin
   // error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='������. �� ������ ��� ���������';
    exit;
  end;
 if  plastNewMatName.Text='<������>' then
  begin
   // error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='������. ����������������� ����� � ��������';
    exit;
  end;
 for i:=1 to Main_Form.plast_num_mat+2 do
  begin
   if plastNewMatName.Text=Main_Form.plast_mmaterials[i].MName then
    begin
    // error:=True;
     Beep;
     Main_Form.StatusBar1.Panels[1].text:='������. ���������� �������� � ��������� ���������';
     exit;

    end;
  end;

   try
    StrToFloat(plastNewMatModUpr.Text);
   except
 //   Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='������ ��� ����� ������ ���������';
    exit;
   end;
   try
    StrToFloat(plastNewMatDopNapr.Text);
   except
   // Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='������ ��� ����� ������������ ����������';
    exit;
   end;

   try
    StrToFloat(plastNewMatKoefPuas.Text);
   except
   // Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='������ ��� ����� ������������ ��������';
    exit;
   end;

  for i:=1 to Main_Form.plast_num_mat+2 do
    begin  // ���������� �� �������� � ���������� ����������������
    if (FloatToStr(StrToFloat(plastNewMatModUpr.Text)/plast_fd.s_num)=FloatToStr(Main_Form.plast_mmaterials[i].MModUpr)) and
       (FloatToStr(StrToFloat(plastNewMatDopNapr.Text)/plast_fd.s_num)=FloatToStr(Main_Form.plast_mmaterials[i].MDopNapr))and
       (FloatToStr(StrToFloat(plastNewMatKoefPuas.Text))=FloatToStr(Main_Form.plast_mmaterials[i].MKoffPuas))then
       begin
         Main_Form.StatusBar1.Panels[1].text:='���������� �������� � ������� ����������������';
         Main_Form.StatusBar1.Panels[2].text:='�������� �������� ['+Main_Form.plast_mmaterials[i].MName+']';
         error:=true;
         beep;
         break;
       end;
    end;
   if not error then // ������� ����� ��������
    begin
     Main_Form.plast_num_mat:=Main_Form.plast_num_mat+1;
     Main_Form.plast_mmaterials[Main_Form.plast_num_mat+2].MModUpr:=StrToFloat(plastNewMatModUpr.Text)/plast_fd.s_num;
     Main_Form.plast_mmaterials[Main_Form.plast_num_mat+2].MDopNapr:=StrToFloat(plastNewMatDopNapr.Text)/plast_fd.s_num;
     Main_Form.plast_mmaterials[Main_Form.plast_num_mat+2].MKoffPuas:=StrToFloat(plastNewMatKoefPuas.Text);
     Main_Form.plast_mmaterials[Main_Form.plast_num_mat+2].MName:=plastNewMatName.Text;
     plast_Fd_Form.ShowD(plast_M.Tplast_Form(Main_Form.ActiveMdiChild).Plast);
    end;

end;

end.
