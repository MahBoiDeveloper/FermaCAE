unit TokNewMat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, tok_FD, tok_M;

type
  TtokNewMatForm = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    tokNewMatName: TEdit;
    Label1: TLabel;
    tokNewMatModUpr: TEdit;
    MUL: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  tokNewMatForm: TtokNewMatForm;

implementation

uses Main;

{$R *.DFM}


procedure TtokNewMatForm.FormShow(Sender: TObject);
begin
 if tok_Fd_Form.Material_ComboBox.Items[tok_Fd_Form.Material_ComboBox.ItemIndex]='<другой>' Then
  begin
    tokNewMatName.Text:='<другой>';
    tokNewMatName.SetFocus;
    tokNewMatName.SelectAll;
    tokNewMatModUpr.Text:=tok_Fd_Form.ModUpr_Edit.Text;
  end
 else
  begin
    tokNewMatName.Text:='';
    tokNewMatModUpr.Text:='';
    tokNewMatName.SetFocus;
  end;
  MUL.Caption:='Модуль упругости ['+tok_M.Ttok_Form(Main_Form.ActiveMdiChild).tok.s_for+'/'+
                                    tok_M.Ttok_Form(Main_Form.ActiveMdiChild).tok.s_lin+'**2]';
  end;

procedure TtokNewMatForm.BitBtn1Click(Sender: TObject);
var
 i:integer;
 error:boolean;
begin
error:=False;
// Проверка на имя
 if  tokNewMatName.Text='' then
  begin
//    error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка. Не задано имя материала';
    exit;
  end;
 if  tokNewMatName.Text='<другой>' then
  begin
//    error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка. Зарезервированное слово в названии';
    exit;
  end;
 for i:=1 to Main_Form.tok_num_mat+2 do
  begin
   if tokNewMatName.Text=Main_Form.tok_MMaterials[i].MName then
    begin
    // error:=True;
     Beep;
     Main_Form.StatusBar1.Panels[1].text:='Ошибка. Существует материал с введенным названием';
     exit;

    end;
  end;

   try
    StrToFloat(tokNewMatModUpr.Text);
   except
  //  Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка при вводе модуля упругости';
    exit;
   end;
  for i:=1 to Main_Form.tok_num_mat+2 do
    begin  // Существует ли материал с введенными характеристиками
    if (FloatToStr(StrToFloat(tokNewMatModUpr.Text)/tok_fd.s_num)=FloatToStr(Main_Form.tok_MMaterials[i].MModUpr))  then
       begin
         Main_Form.StatusBar1.Panels[1].text:='Существует материал с данными характеристиками';
         Main_Form.StatusBar1.Panels[2].text:='Выберите материал ['+Main_Form.tok_MMaterials[i].MName+']';
         Error:=True;
         beep;
         break;
       end;
    end;
   if not Error then // Создаем новый материал
    begin
     Main_Form.tok_num_mat:=Main_Form.tok_num_mat+1;
     Main_Form.tok_MMaterials[Main_Form.tok_num_mat+2].MModUpr:=StrToFloat(tokNewMatModUpr.Text)/tok_fd.s_num;
     Main_Form.tok_MMaterials[Main_Form.tok_num_mat+2].MName:=tokNewMatName.Text;
     tok_Fd_Form.ShowD(tok_M.Ttok_Form(Main_Form.ActiveMdiChild).tok);
    end;

end;

end.
