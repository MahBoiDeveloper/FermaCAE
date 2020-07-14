unit FermaNewMat;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, Ferma_FD, Ferma_M, Grids, Ferm_Dat;

type
  TFermaNewMatForm = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    FermaNewMatName: TEdit;
    Label1: TLabel;
    FermaNewMatModUpr: TEdit;
    FermaNewMatDopNapr: TEdit;
    MUL: TLabel;
    DNL: TLabel;
    Bevel4: TBevel;
    StringGrid1: TStringGrid;
    NM_Plotn_edit: TEdit;
    pltn: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FermaNewMatForm: TFermaNewMatForm;

implementation

uses Main;

{$R *.DFM}


procedure TFermaNewMatForm.FormShow(Sender: TObject);
var i : integer;
begin
 StringGrid1.Cells[0,0] := 'Lambda';
 StringGrid1.Cells[1,0] := 'Phi';
 for i := 1 to 21 do StringGrid1.Cells[0,i] := inttostr((i-1) * 10);
 if Ferma_Fd_Form.Material_ComboBox.Items[Ferma_Fd_Form.Material_ComboBox.ItemIndex]='<другой>' Then
  begin
    FermaNewMatName.Text:='<другой>';
    FermaNewMatName.SetFocus;
    FermaNewMatName.SelectAll;
    FermaNewMatModUpr.Text:=Ferma_Fd_Form.ModUpr_Edit.Text;
    FermaNewMatDopNapr.Text:=Ferma_Fd_Form.DopNapr_Edit.Text;
  end
 else
  begin
    FermaNewMatName.Text:='';
    FermaNewMatModUpr.Text:='';
    FermaNewMatDopNapr.Text:='';
    FermaNewMatName.SetFocus;
  end;
  MUL.Caption:='Модуль упругости ['+Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.s_for+'/'+
                                    Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.s_lin+'**2]';
  DNL.Caption:='Допускаемое напряжение ['+Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.s_for+'/'+
                                          Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.s_lin+'**2]';
  PLTN.Caption:='Плотность материала ['+'Кг'+'/'+
                                          Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm.s_lin+'**3]';


                                          end;

procedure TFermaNewMatForm.BitBtn1Click(Sender: TObject);
var
 i:integer;
 error:boolean;
 Phi : Phi_Table;
 Phi_File : file of Phi_Table;
 Ferma_num_mat:integer;
 ff:System.Text;
 begin
          {AssignFile(Phi_File,'Phi.ini');
          filemode := 2;
          Reset(Phi_File);
          while not EOF(Phi_File) do read(Phi_File, Phi);
          Phi.Material := FermaNewMatName.Text;
          for i := 1 to 21 do
                begin
                        Phi.Lambda := (i - 1) * 10;
                        Phi.Phi := strtofloat(FermaNewMatForm.StringGrid1.cells[1,i]);
                        write(Phi_File, Phi);
                end;
          CloseFile(Phi_File);}
error:=False;
// Проверка на имя
 if  FermaNewMatName.Text='' then
  begin
//    error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка. Не задано имя материала';
    exit;
  end;
 if  FermaNewMatName.Text='<другой>' then
  begin
//    error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка. Зарезервированное слово в названии';
    exit;
  end;
 for i:=1 to Main_Form.Ferma_num_mat+2 do
  begin
   if FermaNewMatName.Text=Main_Form.Ferma_MMaterials[i].MName then
    begin
  //   error:=True;
     Beep;
     Main_Form.StatusBar1.Panels[1].text:='Ошибка. Существует материал с введенным названием';
     exit;

    end;
  end;

   try
    StrToFloat(FermaNewMatModUpr.Text);
   except
//    Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка при вводе модуля упругости';
    exit;
   end;
   try
    StrToFloat(FermaNewMatDopNapr.Text);
   except
//    Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка при вводе допускаемого напряжения';
    exit;
   end;

    try
    StrToFloat(NM_plotn_edit.Text);
   except
//    Error:=True;
    beep;
    Main_Form.StatusBar1.Panels[1].text:='Ошибка при вводе допускаемой плотности';
    exit;
   end;


  for i:=1 to Main_Form.Ferma_num_mat+2 do
    begin  // Существует ли материал с введенными характеристиками
    if (FloatToStr(StrToFloat(FermaNewMatModUpr.Text)/ferma_fd.s_num)=FloatToStr(Main_Form.Ferma_MMaterials[i].MModUpr)) and
       (FloatToStr(StrToFloat(FermaNewMatDopNapr.Text)/ferma_fd.s_num)=FloatToStr(Main_Form.Ferma_MMaterials[i].MDopNapr)) then
       begin
         Main_Form.StatusBar1.Panels[1].text:='Существует материал с данными характеристиками';
         Main_Form.StatusBar1.Panels[2].text:='Выберите материал ['+Main_Form.Ferma_MMaterials[i].MName+']';
         Error:=True;
         beep;
         break;
       end;
    end;
   if not Error then // Создаем новый материал
    begin
     Main_Form.Ferma_num_mat:=Main_Form.Ferma_num_mat+1;
     Main_Form.Ferma_MMaterials[Main_Form.Ferma_num_mat+2].MModUpr:=StrToFloat(FermaNewMatModUpr.Text)/ferma_fd.s_num;
     Main_Form.Ferma_MMaterials[Main_Form.Ferma_num_mat+2].MDopNapr:=StrToFloat(FermaNewMatDopNapr.Text)/ferma_fd.s_num;

     Main_Form.Ferma_MMaterials[Main_Form.Ferma_num_mat+2].MPlotn:=StrToFloat(NM_plotn_Edit.Text)/ferma_fd.s_num;
     if f.s_lin = 'M' then Main_Form.Ferma_MMaterials[Main_Form.Ferma_num_mat+2].MPlotn:=StrToFloat(NM_plotn_Edit.Text)*ferma_fd.pltn_num;



     Main_Form.Ferma_MMaterials[Main_Form.Ferma_num_mat+2].MName:=FermaNewMatName.Text;


//          AssignFile(Phi_File,'phi.ini');
//          filemode := 2;
//         reset(phi_file);

{          while not EOF(Phi_File) do read(Phi_File, Phi);
          Phi.Material := FermaNewMatName.Text;}

          {          for i := 1 to 21 do
                begin
                        Phi.Lambda := (i - 1) * 10;
                        Phi.Phi := strtofloat(FermaNewMatForm.StringGrid1.cells[1,i]);
                        write(Phi_File, Phi);
                end;}

//    CloseFile(Phi_File);
//      CloseFile(ff);
     Ferma_Fd_Form.ShowD(Ferma_M.TFerma_Form(Main_Form.ActiveMdiChild).ferm);
    end;

end;

end.
