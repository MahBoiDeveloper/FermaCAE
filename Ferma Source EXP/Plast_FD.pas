unit Plast_FD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Plast_M, {Ferma_M,} Ferm_Dat, Grids, DBGrids,
  Buttons, Menus;   

type
  TPlast_FD_Form = class(TForm)
    PageControl_FD: TPageControl;
    Region_TabSheet: TTabSheet;
    Cut_by_X_TabSheet: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    Zakr_TabSheet: TTabSheet;
    Cut_by_x_coords: TStringGrid;
    Zakr_Grd_FD: TStringGrid;
    Zakr_ComboBox_FD: TComboBox;
    Nagr_TabSheet: TTabSheet;
    Edit_NCut_by_x: TEdit;
    Cut_by_Y_TabSheet: TTabSheet;
    Cut_by_y_coords: TStringGrid;
    NNagr_Edit: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Bevel4: TBevel;
    Zakr_Edit_ZNNode: TEdit;
    Label5: TLabel;
    Zakr_Edit_NNode: TEdit;
    Label6: TLabel;
    Nagr_Grd_FD: TStringGrid;
    Nagr_Nagr_ComboBox: TComboBox;
    GroupBox1: TGroupBox;
    Region_X_Edit: TEdit;
    Region_Y_Edit: TEdit;
    X_Label: TLabel;
    Y_Label: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LineMeasure_ComboBox: TComboBox;
    ForceMeasure_ComboBox: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    Material_ComboBox: TComboBox;
    ModUpr_Edit: TEdit;
    DopNapr_Edit: TEdit;
    Bevel5: TBevel;
    Edit_NCut_by_y: TEdit;
    ModUpr_Label: TLabel;
    DopNapr_Label: TLabel;
    PlastSizeSBtn: TSpeedButton;
    Bevel7: TBevel;
    Plus_Mat: TSpeedButton;
    Minus_Mat: TSpeedButton;
    KoefPuass_Edt: TEdit;
    Label11: TLabel;
    Bevel6: TBevel;
    Label7: TLabel;
    Label_NNode: TLabel;
    Bevel10: TBevel;
    Label13: TLabel;
    ton1_edt: TEdit;
    ton1_l: TLabel;
    X_PM: TPopupMenu;
    Add_x: TMenuItem;
    Y_PM: TPopupMenu;
    Add_y: TMenuItem;
    DelX_PM: TPopupMenu;
    DelY_PM: TPopupMenu;
    dely: TMenuItem;
    Delx: TMenuItem;
    Add_Zak_PM: TPopupMenu;
    Add_Zak: TMenuItem;
    Add_xg: TMenuItem;
    N1: TMenuItem;
    Add_yg: TMenuItem;
    N2: TMenuItem;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button5: TButton;
    Label12: TLabel;
    Button6: TButton;
    Button7: TButton;
    Label14: TLabel;
    Button8: TButton;
    Button9: TButton;
    GroupBox4: TGroupBox;
    add_button: TButton;
    del_button: TButton;
    Label8: TLabel;
    ADD_STEPCUTX_BUTTON: TButton;
    Label15: TLabel;
    ADD_STEPCUTY_BUTTON: TButton;
    Label16: TLabel;
    procedure ShowD(Plast: TPlast);
    procedure Form_FD_Exit(Sender: TObject);

    procedure Coord_Grd_FDKeyPress(Sender: TObject; var Key: Char);
    procedure Coord_Grd_FDSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure Coord_Grd_FDEnter(Sender: TObject);
    procedure Coord_Grd_FDExit(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure Zakr_Grd_FDMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Zakr_ComboBox_FDChange(Sender: TObject);
    procedure Zakr_Grd_FDMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Nagr_Nagr_ComboBoxChange(Sender: TObject);
    procedure LineMeasure_ComboBoxChange(Sender: TObject);
    procedure ForceMeasure_ComboBoxChange(Sender: TObject);
    procedure PageControl_FDChange(Sender: TObject);
    procedure Material_ComboBoxChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PlastSizeSBtnClick(Sender: TObject);
    procedure Minus_MatClick(Sender: TObject);
    procedure CreateS_Num(Sender: TObject);

    procedure Plus_MatClick(Sender: TObject);
    procedure Cut_by_x_coordsEnter(Sender: TObject);
    procedure Cut_by_x_coordsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure Cut_by_x_coordsGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure Cut_by_x_coordsExit(Sender: TObject);
    procedure Cut_by_x_coordsKeyPress(Sender: TObject; var Key: Char);
    procedure Cut_by_x_coordsSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure Cut_by_y_coordsEnter(Sender: TObject);
    procedure Cut_by_y_coordsExit(Sender: TObject);
    procedure Cut_by_y_coordsGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure Cut_by_y_coordsKeyPress(Sender: TObject; var Key: Char);
    procedure Cut_by_y_coordsSelectCell(Sender: TObject; Col, Row: Integer;
      var CanSelect: Boolean);
    procedure Cut_by_y_coordsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure ton1_edtKeyPress(Sender: TObject; var Key: Char);
    procedure ton1_edtExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Add_xClick(Sender: TObject);
    procedure Add_yClick(Sender: TObject);
    procedure Cut_by_y_coordsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure delyClick(Sender: TObject);
    procedure Del_Cut(xory:char;num : integer);
    procedure Cut_by_x_coordsMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DelxClick(Sender: TObject);
    procedure Add_ZakClick(Sender: TObject);
    procedure Add_ForceClick(Sender: TObject);
    procedure Del_NagrClick(Sender: TObject);
    procedure Add_xgClick(Sender: TObject);
    procedure Add_ygClick(Sender: TObject);
    procedure Nagr_Grd_FDEnter(Sender: TObject);
    procedure Nagr_Grd_FDExit(Sender: TObject);
    procedure Nagr_Grd_FDGetEditText(Sender: TObject; ACol,
      ARow: Integer; var Value: String);
    procedure Nagr_Grd_FDKeyPress(Sender: TObject;
      var Key: Char);
    procedure Nagr_Grd_FDSelectCell(Sender: TObject; Col,
      Row: Integer; var CanSelect: Boolean);
    procedure Nagr_Grd_FDSetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: String);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure del_buttonClick(Sender: TObject);
    procedure add_buttonClick(Sender: TObject);
    procedure chg_buttonClick(Sender: TObject);
    procedure ADD_STEPCUTX_BUTTONClick(Sender: TObject);
    procedure ADD_STEPCUTY_BUTTONClick(Sender: TObject);

  private
    { Private declarations }
   // OtherOk:boolean;
//   procedure Del_Cut(xory : string ;num : integer);
  public
    { Public declarations }
    first_show_FD_form:boolean;
end;

function isNumber(s:string):boolean;
//procedure Del_Cut(xory:string;num:integer);

var
  Plast_FD_Form: TPlast_FD_Form;
  {���������� ��������� ���� ��������}
      p: TPlast;

  {���������� ���������� ��� ������� ��������� �����}
      Coord_Grd_Value:string; // C��������� ������������� ������
      Coord_Grd_Key:char;     // ������� ��������� �������
      Coord_Grd_Acol,Coord_Grd_Arow:integer;
      Coord_Grd_SetEdit:Boolean;

  {���������� ���������� ��� ������� ����������� �����}
      Zakr_Grd_X,Zakr_Grd_Y:integer;
      Zakr_Grd_Acol,Zakr_Grd_ARow:integer;
      Zakr_Grd_ACol_Hint,Zakr_Grd_ARow_Hint:integer;

  {���������� ���������� ��� �������}
      s_num:extended;

       ACol1,ARow1:integer; // ������� � ������� ���������� ���������
{�� ������������}
  {���������� ���������� ��� ������� ���������� �����}
      Nagr_Grd_Value:string; // C��������� ������������� ������
      Nagr_Grd_Key:char;     // ������� ��������� �������
      Nagr_Grd_Acol,Nagr_Grd_Arow:integer;
      Nagr_Grd_SetEdit:Boolean;
      Nagr_Grd_ACol_Hint,Nagr_Grd_ARow_Hint:integer;
{����� ����� ������������}
      l_dimension,f_dimension:string;
      l_factor:real;
      f_factor:integer;

implementation

uses Main, PlastRegionSize, PlastNewMat, NewCut, AddZak, AddForce,
  ForcNode;

{$R *.DFM}
// ������� ��� ������� ����� (��������� �����)
function isNumber(s:string):boolean;
begin

  Result:=true;
  try
    StrToFloat(s);
  except
    Result:=false;
  end;
  if result=true then
   begin
    if Strtofloat(s)<0 then   Result:=false;
   end;

end;


procedure TPlast_FD_Form.ShowD(Plast: Tplast);
Label
33;
var
 form:TPlast_Form;
 i,j,code:integer;
 max_x_coord,max_y_coord,a,b,c:extended;
 mat_live:boolean;
 kx,ky:integer;
begin
//exit;
    p:=Plast;
    l_dimension:=p.s_lin;
    f_dimension:=p.s_for;
    form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
   if (plast.kx1>=12) and (plast.ky1>=12) then
    begin
     Main_Form.Cut_Plast_Toolbutton.Enabled:=false;
     Main_form.ToolButton1.Down := True;
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).PaintBox.Cursor:=crDefault;
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr:=True;
    end
   else
    begin
     Main_Form.Cut_Plast_Toolbutton.Enabled:=true;
    end;

    {if plast.kl1=0 then Nagr_Grd_FD.Visible:=false
    else Nagr_Grd_FD.Visible:=true;
    if plast.kz1=0 then Zakr_Grd_FD.Visible:=false
    else Zakr_Grd_FD.Visible:=true; }
    if p.kx1<12 then Add_x.Enabled:=True
    else Add_x.Enabled:=false;
    if p.ky1<12 then Add_y.Enabled:=True
    else Add_y.Enabled:=false;
    if p.kx1<12 then Add_xg.Enabled:=True
    else Add_xg.Enabled:=false;
    if p.ky1<12 then Add_yg.Enabled:=True
    else Add_yg.Enabled:=false;
    //�������
    for i:=0 to 2 do
     if LineMeasure_ComboBox.Items[i]=Plast.s_lin then LineMeasure_ComboBox.ItemIndex:=i;

    for i:=0 to 1 do
     if ForceMeasure_ComboBox.Items[i]=Plast.s_for then ForceMeasure_ComboBox.ItemIndex:=i;

    X_Label.Caption:='������ �� X  ['+Plast.s_lin+']';
    Y_Label.Caption:='������ �� Y  ['+Plast.s_lin+']';
    if Plast<>nil then
    begin
        kx:=Plast.kx1;
        ky:=Plast.ky1;
        Region_X_Edit.Text:=FloatToStr(Plast.Xm1[kx]);
        Region_Y_Edit.Text:=FloatToStr(Plast.Ym1[ky]);
    end;
    ton1_edt.Text:= FloatToStr(Plast.ton1);
    ton1_l.Caption:='���. ������� ['+Plast.s_lin+']';
    max_x_coord:=0;
    max_y_coord:=0;
    for i:=1 to p.kx1 do // for i:=1 to f.nyz1 do
     begin
      if p.xm1[i]>=max_x_coord then max_x_coord:=p.xm1[i];
     end;
         for i:=1 to p.ky1 do // for i:=1 to f.nyz1 do
     begin
      if p.ym1[i]>=max_y_coord then max_y_coord:=p.ym1[i];
     end;
    if (max_y_coord=9999.99) and (max_x_coord=9999.99) then
     PlastSizeSBtn.Enabled:=False
    else
     PlastSizeSBtn.Enabled:=True;
       // ��������
     CreateS_Num(Self);

    Material_ComboBox.Items.Clear;
    for i:=1 to 2+Main_Form.plast_num_mat do
      Material_ComboBox.Items.Add(Main_Form.plast_mmaterials[i].MName);
      {Material_ComboBox.Items[i-1]:=Main_Form.plast_mmaterials[i].MName; ��� �������}

    mat_live:=false;
    for i:=1 to 2+Main_Form.plast_num_mat do
     begin
     a:=Main_Form.plast_mmaterials[i].MModUpr*s_num;
     b:=Main_Form.plast_mmaterials[i].MDopNapr*s_num;
     c:=Main_Form.plast_mmaterials[i].MKoffPuas;
      if (FloatToStr(Plast.e1[1])=FloatToStr(a)) and (FloatToStr(Plast.dop1)=FloatToStr(b)) and (FloatToStr(Plast.e1[2])=FloatToStr(c)) then
             begin
              Mat_Live:=True;
              Material_ComboBox.ItemIndex:=i-1;
              break;
             end;
      end;

       if not mat_live then
        begin
           Material_ComboBox.Items[3+Main_Form.plast_num_mat-1]:='<������>';
           Material_ComboBox.ItemIndex:=3+Main_Form.plast_num_mat-1;
           Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MModUpr:=plast.e1[1]/s_num;
           Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MDopNapr:=plast.dop1/s_num;
        end;

    if (Material_ComboBox.ItemIndex<=1) or (Material_ComboBox.Items.Count>Main_Form.plast_num_mat+2)  then minus_mat.Enabled:=False
     else minus_mat.Enabled:=True;

    ModUpr_Label.Caption:='������ ��������� ['+Plast.s_for+'/'+Plast.s_lin+'**2]';
    DopNapr_Label.Caption:='����������� ���������� ['+Plast.s_for+'/'+Plast.s_lin+'**2]';
    ModUpr_Edit.Text:=FloatToStr(Plast.e1[1]);
    KoefPuass_Edt.Text:=FloatToStr(Plast.e1[2]);
    DopNapr_Edit.Text:=FloatToStr(Plast.dop1);

    // ��������� (��������� �� �)
    Edit_NCut_by_x.text:=IntToStr(Plast.kx1);

    Cut_by_x_coords.Cells[0,0]:='� ����.';
    Cut_by_x_coords.Cells[1,0]:='�����.��������� �� X, '+Plast.s_lin;
    Cut_by_x_coords.RowCount:=Plast.kx1+1;
    Cut_by_x_coords.Height:=(Plast.kx1)*18+22;
    for i:=1 to Plast.kx1 do Cut_by_x_coords.Cells[0,i]:=' '+IntToStr(i);

      for i:=1 to Plast.kx1 do
          Cut_by_x_coords.Cells[1,i]:=FloatToStr(Plast.xm1[i]);


   //����������� �����
   Zakr_Edit_NNode.text:=IntToStr(Plast.kx1*Plast.ky1);
   Zakr_Edit_ZNNode.text:=IntToStr(plast.kz1);
   Zakr_Grd_FD.RowHeights[0]:=17;
   Zakr_Grd_FD.Cells[0,0]:='� ����';
   Zakr_Grd_FD.Cells[1,0]:='           ��� �����������';
   Zakr_Grd_FD.RowCount:=Plast.kz1+1;
   if plast.kz1=0 then Zakr_Grd_FD.RowCount:=2;
   if Plast.kz1 > 0 then
    begin
     Zakr_Grd_FD.Enabled:=True;
     Zakr_Grd_FD.FixedRows:=1;
     Zakr_Grd_FD.FixedCols:=1;
     Zakr_Grd_FD.RowHeights[0]:=17;
    end
   else
    begin
     Zakr_Grd_FD.FixedCols:=0;
     Zakr_Grd_FD.FixedRows:=0;
     Zakr_Grd_FD.Enabled:=true{False};
    end;
   Zakr_Grd_FD.Height:=(plast.kz1)*22+22;
   if plast.kz1=0 then Zakr_Grd_FD.Height:=26;
   for i:=1 to plast.kz1 do Zakr_Grd_FD.Cells[0,i]:=' '+IntToStr(plast.zak1[i]);

   for i:=1 to plast.kz1 do
    begin
     if (plast.zak2[i]=1) and (plast.zak3[i]=1) then Zakr_Grd_FD.Cells[1,i]:='��������� �� X � Y';
     if (plast.zak2[i]=1) and (plast.zak3[i]=0) then Zakr_Grd_FD.Cells[1,i]:='��������� �� X';
     if (plast.zak2[i]=0) and (plast.zak3[i]=1) then Zakr_Grd_FD.Cells[1,i]:='��������� �� Y';
    end;

   //���������� (����������� ����)
   if (plast.kl1>=0) then NNagr_Edit.Text:=IntToStr(plast.kl1);
   //???????????????????????????????????????????????????
   //if plast.kl1=0 then NNagr_Edit.Text:=IntToStr(1);
   //????????????????????????????????????????????????
   Nagr_Nagr_ComboBox.Enabled:=true;
    if plast.kl1<=1 then Nagr_Nagr_ComboBox.Enabled:=false;
   Nagr_Nagr_ComboBox.Items.Clear;
   for i:=1 to plast.kl1 do
    begin
       Nagr_Nagr_ComboBox.Items.Add(IntToStr(i));
    end;
   Nagr_Nagr_ComboBox.ItemIndex:=Main_Form.Sn_Cbx.ItemIndex;
   if Nagr_Nagr_ComboBox.ItemIndex=-1 then begin
  Nagr_Nagr_ComboBox.Items.clear;
  Nagr_Nagr_ComboBox.Items.Add('1');
  Nagr_Nagr_ComboBox.ItemIndex:=0;
  end;
   //????????????????????????????????????????????????????????????
  if plast.kl1=0 then begin
  Nagr_Nagr_ComboBox.Items.clear;
  Nagr_Nagr_ComboBox.Items.Add('1');
  Nagr_Nagr_ComboBox.ItemIndex:=0;
  end;
  //??????????????????????????????????????????
   Nagr_Grd_FD.Cells[0,0]:='� ����';
   Nagr_Grd_FD.Cells[1,0]:='���� �� X ['+Plast.s_for+']';
   Nagr_Grd_FD.Cells[2,0]:='���� �� Y ['+Plast.s_for+']';
  { Nagr_Grd_FD.RowCount:=plast.kl1+1;
   Nagr_Grd_FD.Height:=(plast.kl1)*18+22;}
   Nagr_Grd_FD.RowCount:=1+3;

   Nagr_Grd_FD.Height:=19+19+19+19;

          if plast.kl1=0 {Nagr_Nagr_ComboBox.ItemIndex=-1} then
          begin
          //Nagr_Grd_FD.row.delete(1);
          Nagr_Grd_FD.Cells[0,1]:='';
          Nagr_Grd_FD.Cells[1,1]:='';
          Nagr_Grd_FD.Cells[2,1]:='';
          goto 33; //���� ��� ���
          end;
          for i:=1 to 3 do
          Begin
          Nagr_Grd_FD.Cells[0,i]:='';
          Nagr_Grd_FD.Cells[1,i]:='';
          Nagr_Grd_FD.Cells[2,i]:='';
          end;
          for i:=1 to form.kt[Nagr_Nagr_ComboBox.ItemIndex+1] do
          Begin
          Nagr_Grd_FD.Cells[0,i]:=' '+IntToStr(form.Nagruz[Nagr_Nagr_ComboBox.ItemIndex+1,i,1]);
          Nagr_Grd_FD.Cells[1,i]:=inttostr(form.Nagruz[Nagr_Nagr_ComboBox.ItemIndex+1,i,3]);
          Nagr_Grd_FD.Cells[2,i]:=inttostr(form.Nagruz[Nagr_Nagr_ComboBox.ItemIndex+1,i,4]);
          end;
          if plast.kl1=0 then Nagr_Grd_FD.Height:=22;
 33: //??????????????
 if plast.kl1 > 0 then
    begin
     Nagr_Grd_FD.FixedRows:=1;
     Nagr_Grd_FD.FixedCols:=1;
{my comment+insert}
//     Nagr_Grd_FD.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine{,goEditing}]
//     Nagr_Grd_FD.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine,goEditing]
{end of my comment+insert}
    end
   else
    begin
     Nagr_Grd_FD.FixedCols:=0;
     Nagr_Grd_FD.FixedRows:=0;
     Nagr_Grd_FD.Height:=22;
//     Nagr_Grd_FD.Options:=[goFixedVertLine,goFixedHorzLine,goVertLine,goHorzLine]
    end;


   // ��������� (��������� �� �)
    Edit_NCut_by_y.text:=IntToStr(Plast.ky1);

    Cut_by_y_coords.Cells[0,0]:='� ����.';
    Cut_by_y_coords.Cells[1,0]:='�����.��������� �� Y, '+plast.s_lin;
    Cut_by_y_coords.RowCount:=Plast.ky1+1;
    Cut_by_y_coords.Height:=(Plast.ky1)*18+22;
    for i:=1 to Plast.ky1 do Cut_by_y_coords.Cells[0,i]:=' '+IntToStr(i);

      for i:=1 to Plast.ky1 do
          Cut_by_y_coords.Cells[1,i]:=FloatToStr(Plast.ym1[i]);
      end;

procedure TPlast_FD_Form.Form_FD_Exit(Sender: TObject);
begin
if Main_Form.ActiveMDIChild is TPlast_Form then
 begin
  Main_Form.ConstructorShow.Checked := False;
 end;
end;




procedure TPlast_FD_Form.Coord_Grd_FDKeyPress(Sender: TObject;
  var Key: Char);
begin
 Coord_Grd_Key:=Key;
end;



procedure TPlast_FD_Form.Coord_Grd_FDSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
  if not Coord_Grd_SetEdit then
   begin
    Plast_FD_Form.showD(p);
    Coord_Grd_SetEdit:=True;
   end;
end;



procedure TPlast_FD_Form.Coord_Grd_FDEnter(Sender: TObject);
begin
 Coord_Grd_SetEdit:=True;
end;



procedure TPlast_FD_Form.Coord_Grd_FDExit(Sender: TObject);
begin
Plast_FD_Form.showD(p);
end;



procedure TPlast_FD_Form.FormDeactivate(Sender: TObject);
begin
{Coord_Grd_FD.EditorMode:=False;}
Zakr_Combobox_FD.Visible:=False;
end;



procedure TPlast_FD_Form.Zakr_Grd_FDMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
//X,Y:Integer;
Acol,ARow:Integer;
Zakr_Rect:TRect;
begin
if shift=[ssLeft] then
 begin
Zakr_Grd_X:=X;Zakr_Grd_Y:=Y;
Application.CancelHint;
Zakr_Grd_FD.MouseToCell(Zakr_Grd_X,Zakr_Grd_Y,ACol,ARow);
Zakr_Rect:=Zakr_Grd_FD.CellRect(ACol,ARow);
Zakr_Grd_ACol:=ACol;Zakr_Grd_ARow:=ARow;
if (ACol>0) and (ARow>0) then
begin
 if Zakr_Grd_FD.Cells[ACol,ARow]='�� ���������' then  Zakr_Combobox_FD.ItemIndex:=0;
 if Zakr_Grd_FD.Cells[ACol,ARow]='��������� �� X' then Zakr_Combobox_FD.ItemIndex:=1;
 if Zakr_Grd_FD.Cells[ACol,ARow]='��������� �� Y' then Zakr_Combobox_FD.ItemIndex:=2;
 if Zakr_Grd_FD.Cells[ACol,ARow]='��������� �� X � Y' then Zakr_Combobox_FD.ItemIndex:=3;
Zakr_Combobox_FD.Visible:=True;
Zakr_Combobox_FD.Top:=Zakr_Rect.Top+Zakr_Grd_FD.Top+2;
Zakr_ComboBox_FD.Left:=Zakr_Rect.Left+Zakr_Grd_FD.Left+2;
end;
end;
end;




procedure TPlast_FD_Form.Zakr_ComboBox_FDChange(Sender: TObject);
label
zzz;
var
i,j:integer;
begin
 Zakr_Grd_FD.Cells[Zakr_Grd_ACol, Zakr_Grd_ARow]:=Zakr_ComboBox_FD.items[Zakr_ComboBox_FD.ItemIndex];

 if Zakr_Grd_FD.Cells[Zakr_Grd_ACol,Zakr_Grd_ARow]='�� ���������' then
 begin
 p.kz1:= p.kz1-1;
 if Zakr_Grd_FD.Cells[1,Zakr_Grd_ARow+1]='��������� �� X' then Zakr_Combobox_FD.ItemIndex:=1;
 if Zakr_Grd_FD.Cells[1,Zakr_Grd_ARow+1]='��������� �� Y' then Zakr_Combobox_FD.ItemIndex:=2;
 if Zakr_Grd_FD.Cells[1,Zakr_Grd_ARow+1]='��������� �� X � Y' then Zakr_Combobox_FD.ItemIndex:=3;
    for i:=1 to p.kz1 do
     if p.zak1[i]=strtoint(Zakr_Grd_FD.Cells[0,Zakr_Grd_ARow]) then
      begin
       for j:=i to p.kz1 do
        begin
        Zakr_Grd_FD.Cells[1,j]:=Zakr_Grd_FD.Cells[1,j+1];
         p.zak1[j]:=p.zak1[j+1];
          p.zak2[j]:=p.zak2[j+1];
           p.zak3[j]:=p.zak3[j+1];
        end;
        goto zzz;
       end;
  end;
 zzz:
 if Zakr_Grd_FD.Cells[Zakr_Grd_ACol,Zakr_Grd_ARow]='��������� �� X' then begin p.zak2[Zakr_Grd_ARow]:=1;p.zak3[Zakr_Grd_ARow]:=0; end;
 if Zakr_Grd_FD.Cells[Zakr_Grd_ACol,Zakr_Grd_ARow]='��������� �� Y' then begin p.zak2[Zakr_Grd_ARow]:=0;p.zak3[Zakr_Grd_ARow]:=1; end;
 if Zakr_Grd_FD.Cells[Zakr_Grd_ACol,Zakr_Grd_ARow]='��������� �� X � Y' then begin p.zak2[Zakr_Grd_ARow]:=1;p.zak3[Zakr_Grd_ARow]:=1; end;


 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(p);
 Zakr_ComboBox_FD.Visible:=false;
 Main_Form.ActiveMDIChild.RePaint;
end;



procedure TPlast_FD_Form.Zakr_Grd_FDMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
Acol,ARow:Integer;
begin

Zakr_Grd_FD.MouseToCell(X,Y,ACol,ARow);

if (ARow<>Zakr_Grd_ARow_Hint) or (ACol<>Zakr_Grd_ACol_Hint) then
 begin
  Zakr_Grd_FD.ShowHint:=True;
  Application.CancelHint;
 end;
Zakr_Grd_ACol_Hint:=ACol;
Zakr_Grd_ARow_Hint:=ARow;

end;



procedure TPlast_FD_Form.Nagr_Nagr_ComboBoxChange(Sender: TObject);
begin
 Main_Form.Sn_CBx.ItemIndex:=Nagr_Nagr_ComboBox.ItemIndex;
 Plast_FD_Form.showD(p);
 Main_Form.ActiveMDIChild.RePaint;
end;

procedure TPlast_FD_Form.CreateS_Num(Sender: TObject);
var
i,j:integer;
begin
 if p.s_lin='��' then
    s_num:=0.01
 else if p.s_lin='��' then
    s_num:=1
 else
   s_num:=10000;

  if p.s_for='�' then
    s_num:=s_num*1
  else
    s_num:=s_num*0.1;
end;


procedure TPlast_FD_Form.LineMeasure_ComboBoxChange(Sender: TObject);
var
i:integer;
begin

 if p.s_lin<>LineMeasure_ComboBox.Items[LineMeasure_ComboBox.ItemIndex] then
  begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
   p.s_lin:=LineMeasure_ComboBox.Items[LineMeasure_ComboBox.ItemIndex];
   CreateS_Num(Self);

   if p.s_lin='��' then
    begin
      if l_dimension='��' then
       l_factor:=10;
      if l_dimension='M' then
       l_factor:=1000;
      if l_dimension='��' then
       l_factor:=1;
    end
   else if p.s_lin='��' then
    begin
      if l_dimension='��' then
       l_factor:=0.1;
      if l_dimension='M' then
       l_factor:=100;
      if l_dimension='��' then
       l_factor:=1;
    end
   else
    begin
     if l_dimension='��' then
       l_factor:=0.001;
     if l_dimension='��' then
       l_factor:=0.01;
     if l_dimension='M' then
       l_factor:=1;
  end;
   for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kx1 do
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.xm1[i]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.xm1[i]*l_factor;
   for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ky1 do
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ym1[i]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ym1[i]*l_factor;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1*l_factor;

   if Material_ComboBox.ItemIndex<=Main_Form.plast_num_mat+1 then
    begin
     p.e1[1]:=Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MModUpr*s_num;
     p.dop1:=Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MDopNapr*s_num;
    end
   else
    begin
     p.e1[1]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MModUpr*s_num;
     p.dop1:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MDopNapr*s_num;
    end;
   Plast_FD_Form.showD(p);
   Main_Form.ActiveMDIChild.RePaint;
  end;

end;

procedure TPlast_FD_Form.ForceMeasure_ComboBoxChange(Sender: TObject);
var
i,j,k:integer;
begin

 if p.s_for<>ForceMeasure_ComboBox.Items[ForceMeasure_ComboBox.ItemIndex] then
  begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
   p.s_for:=ForceMeasure_ComboBox.Items[ForceMeasure_ComboBox.ItemIndex];
   CreateS_Num(Self);
   if Material_ComboBox.ItemIndex<=Main_Form.plast_num_mat+1 then
    begin
     p.e1[1]:=Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MModUpr*s_num;
     p.dop1:=Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MDopNapr*s_num;
    end
   else
    begin
     p.e1[1]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MModUpr*s_num;
     p.dop1:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MDopNapr*s_num;
    end;

   if p.s_for='�' then
   begin
    if f_dimension='��' then
      begin
        for j:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl do
        for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kt[j] do
        for k:=3 to 4 do
           Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nagruz[j,i,k]:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nagruz[j,i,k]*10;
      end;
   end
  else
    begin
     if f_dimension='�' then
      begin
        for j:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl do
        for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kt[j] do
        for k:=3 to 4 do
           Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nagruz[j,i,k]:=round(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).nagruz[j,i,k]/10);
      end;
    end;

   Plast_FD_Form.showD(p);
   Main_Form.ActiveMDIChild.RePaint;
  end;

end;

procedure TPlast_FD_Form.PageControl_FDChange(Sender: TObject);
begin
Zakr_ComboBox_FD.Visible:=False;
end;

procedure TPlast_FD_Form.Material_ComboBoxChange(Sender: TObject);
begin

 if Material_ComboBox.Items[Material_ComboBox.ItemIndex]<>'<������>' then
  begin
   ModUpr_Edit.Text:=FloatToStr(Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MModUpr*s_num);
   DopNapr_Edit.Text:=FloatToStr(Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MDopNapr*s_num);
   KoefPuass_Edt.Text:=FloatToStr(Main_Form.plast_mmaterials[Material_ComboBox.ItemIndex+1].MKoffPuas);
   if Material_ComboBox.ItemIndex<=1 then Minus_Mat.Enabled:=False
    else Minus_Mat.Enabled:=True;
  end
 else
  begin
   ModUpr_Edit.Text:=FloatToStr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MModUpr*s_num);
   DopNapr_Edit.Text:=FloatToStr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MDopNapr*s_num);
   KoefPuass_Edt.Text:=FloatToStr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Other_MKoefPuass);
   Minus_Mat.Enabled:=False;
  end;

  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
  p.e1[1]:=StrToFloat(ModUpr_Edit.Text);
  p.e1[2]:=StrToFloat(KoefPuass_Edt.Text);
  p.dop1:=StrToFloat(DopNapr_Edit.Text);

end;

procedure TPlast_FD_Form.FormShow(Sender: TObject);
begin
 if first_show_FD_form then
  begin
   Top:=Main_Form.Top+30;
   Left:=Main_Form.Left+Main_Form.Width-Width-8;
   first_show_FD_form:=false;
  end;
end;



procedure TPlast_FD_Form.PlastSizeSBtnClick(Sender: TObject);
var
 i:integer;
 max_x_coord, max_y_coord:extended;
begin
 PlastRegionSizeForm.SizeLabel.Caption:='������� �������  ['+p.S_lin+']';
 max_x_coord:=0;
 max_y_coord:=0;
 for i:=1 to p.kx1 do
  begin
   if p.xm1[i]>=max_x_coord then max_x_coord:=p.xm1[i];
  end;
   for i:=1 to p.ky1 do
  begin
   if p.ym1[i]>=max_y_coord then max_y_coord:=p.ym1[i];
  end;
 if (p.xm1[p.kx1-1]<>0) then PlastRegionSizeForm.MinX_L.Caption:=FormatFloat('0.##',p.xm1[p.kx1-1])+' <';
 if (p.ym1[p.ky1-1]<>0) then PlastRegionSizeForm.MinY_L.Caption:=FormatFloat('0.##',p.ym1[p.ky1-1])+' <';
 PlastRegionSizeForm.nt_edt.Text:=ton1_edt.Text;
 PlastRegionSizeForm.XSize.Text:=Region_X_Edit.Text;
 PlastRegionSizeForm.YSize.Text:=Region_Y_Edit.Text;
 if (p.kz1=0)and(p.kl1=0)then
 PlastRegionSizeForm.ShowModal
 else
 begin
 messagedlg('���������� �������� ������ �������.'+#10+#13+'������������ ����������� �/��� ����.'+#10+#13+'����� ���� �������� ������ �������.',mtwarning{error},[mbOk],0);
 PlastRegionSizeForm.XSize.enabled:=false;
 PlastRegionSizeForm.YSize.enabled:=false;
 PlastRegionSizeForm.ShowModal ;
 PlastRegionSizeForm.XSize.enabled:=true;
 PlastRegionSizeForm.YSize.enabled:=true;
 end;
end;

procedure TPlast_FD_Form.Minus_MatClick(Sender: TObject);
var
 I_Del,i:integer;
begin

  I_Del:=Material_ComboBox.ItemIndex+1;
  Material_ComboBox.Items.Delete(Material_ComboBox.ItemIndex);
  Material_ComboBox.ItemIndex:=0;
  ModUpr_Edit.Text:=FloatToStr(Main_Form.Plast_MMaterials[1].MModUpr*s_num);
  DopNapr_Edit.Text:=FloatToStr(Main_Form.Plast_MMaterials[1].MDopNapr*s_num);
  KoefPuass_Edt.Text:=FloatToStr(Main_Form.Plast_MMaterials[1].MKoffPuas);
  p.e1[1]:=StrToFloat(ModUpr_Edit.Text);
  p.e1[2]:=StrToFloat(KoefPuass_Edt.Text);
  p.dop1:=StrToFloat(DopNapr_Edit.Text);
  for i:=I_Del+1 to Main_Form.Plast_num_mat+2 do
   begin
    Main_Form.Plast_MMaterials[i-1].MName:=Main_Form.Plast_MMaterials[i].MName;
    Main_Form.Plast_MMaterials[i-1].MDopNapr:=Main_Form.Plast_MMaterials[i].MDopNapr;
    Main_Form.Plast_MMaterials[i-1].MModUpr:=Main_Form.Plast_MMaterials[i].MModUpr;
    Main_Form.Plast_MMaterials[i-1].MKoffPuas:=Main_Form.Plast_MMaterials[i].MKoffPuas;
   end;
  Main_Form.Plast_num_mat:=Main_Form.Plast_num_mat-1;
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=True;
  Plast_FD_form.showD(p);

end;





procedure TPlast_FD_Form.Plus_MatClick(Sender: TObject);
begin
 PlastNewMatForm.ShowModal;
end;



procedure TPlast_FD_Form.Cut_by_x_coordsEnter(Sender: TObject);
begin
 Coord_Grd_SetEdit:=True;
end;

procedure TPlast_FD_Form.Cut_by_x_coordsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
 if  Coord_GRD_Key=chr(13) then begin
  if isNumber(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow]) then
     if(Coord_Grd_ARow<>1)and(Coord_Grd_ARow<>p.kx1)and(StrToFloat(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow])<StrToFloat(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow+1]))and(StrToFloat(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow])>StrToFloat(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow-1])) then
     begin
     p.xm1[Coord_Grd_ARow]:=StrToFloat(Cut_by_x_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow]);
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
     Main.Main_Form.ActiveMDIChild.Repaint;
     Plast_FD_form.showD(p);
     Coord_Grd_SetEdit:=True;
     end
     else
      Plast_FD_form.showD(p)
  else
   begin
    Plast_FD_form.showD(p);
   end
end;
end;



procedure TPlast_FD_Form.Cut_by_x_coordsGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
 Coord_Grd_Value:=Value;
 Coord_Grd_ACol:=ACol;
 Coord_Grd_ARow:=ARow;
 Coord_Grd_SetEdit:=False;
end;

procedure TPlast_FD_Form.Cut_by_x_coordsExit(Sender: TObject);
begin
 Plast_FD_form.showD(p);
end;

procedure TPlast_FD_Form.Cut_by_x_coordsKeyPress(Sender: TObject;
  var Key: Char);
begin
 Coord_Grd_Key:=Key;
end;

procedure TPlast_FD_Form.Cut_by_x_coordsSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
  if not Coord_Grd_SetEdit then
   begin
    Plast_FD_form.showD(p);
    Coord_Grd_SetEdit:=True;
   end;
end;

procedure TPlast_FD_Form.FormActivate(Sender: TObject);
begin

If main_form.PanelConstruction.Checked = False then main_form.Plast_Graph_Enter_Panel.Visible:=False
 else main_form.Plast_Graph_Enter_Panel.Visible:=True;

 if Main_Form.Del_Cut_Plast_Toolbutton.Down or Main_Form.Cut_Plast_Toolbutton.Down then
  begin
    Main_Form.ActiveMDIChild.RePaint;
  end;
 if Main_Form.ActiveMDIChild.Active then
  begin
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).PaintBox.Cursor:=crDefault;
   Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).PaintBox.ShowHint:=False;
   Main_Form.Plast_Graph_Enter_Panel.Buttons[0].Down:=True;
   Main_Form.StatusBar1.Panels[0].Text :='';
   Main_Form.StatusBar1.Panels[1].Text :='';
   Main_Form.StatusBar1.Panels[2].Text :='';
  end;

  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Zagr:=True;
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).XOld:=-1;
  Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).YOld:=-1;

end;

procedure TPlast_FD_Form.Cut_by_y_coordsEnter(Sender: TObject);
begin
 Coord_Grd_SetEdit:=True;
end;

procedure TPlast_FD_Form.Cut_by_y_coordsExit(Sender: TObject);
begin
 Plast_FD_form.showD(p);
end;

procedure TPlast_FD_Form.Cut_by_y_coordsGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
Coord_Grd_Value:=Value;
 Coord_Grd_ACol:=ACol;
 Coord_Grd_ARow:=ARow;
 Coord_Grd_SetEdit:=False;
end;

procedure TPlast_FD_Form.Cut_by_y_coordsKeyPress(Sender: TObject;
  var Key: Char);
begin
Coord_Grd_Key:=Key;
end;

procedure TPlast_FD_Form.Cut_by_y_coordsSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
  if not Coord_Grd_SetEdit then
   begin
    Plast_FD_form.showD(p);
    Coord_Grd_SetEdit:=True;
   end;
end;

procedure TPlast_FD_Form.Cut_by_y_coordsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
if  Coord_GRD_Key=chr(13) then begin
  if isNumber(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow]) then
   if(Coord_Grd_ARow<>1)and(Coord_Grd_ARow<>p.ky1)and(StrToFloat(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow])<StrToFloat(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow+1]))and(StrToFloat(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow])>StrToFloat(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow-1])) then
    begin
     p.ym1[Coord_Grd_ARow]:=StrToFloat(Cut_by_y_coords.Cells[Coord_Grd_ACol,Coord_Grd_ARow]);
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
     Main.Main_Form.ActiveMDIChild.Repaint;
     Plast_FD_form.showD(p);
     Coord_Grd_SetEdit:=True;
    end
     else
    Plast_FD_form.showD(p)
  else
   begin
    Plast_FD_form.showD(p);
   end
end;
end;




procedure TPlast_FD_Form.ton1_edtKeyPress(Sender: TObject; var Key: Char);
begin
   if key=chr(13)then
   if isNumber(ton1_edt.text) then
   if(strtofloat(ton1_edt.text)>0)and(strtofloat(ton1_edt.text)<9999.99) then
    begin
     p.ton1:=StrToFloat(ton1_edt.text);
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
     Main.Main_Form.ActiveMDIChild.Repaint;
     Plast_FD_form.showD(p);
    end
     else
    Plast_FD_form.showD(p)
  else
    Plast_FD_form.showD(p);
end;


procedure TPlast_FD_Form.ton1_edtExit(Sender: TObject);
begin
if isNumber(ton1_edt.text) then
   if(strtofloat(ton1_edt.text)>0)and(strtofloat(ton1_edt.text)<9999.99) then
    begin
     p.ton1:=StrToFloat(ton1_edt.text);
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
     Main.Main_Form.ActiveMDIChild.Repaint;
     Plast_FD_form.showD(p);
    end
     else
    Plast_FD_form.showD(p)
  else
    Plast_FD_form.showD(p);
end;

procedure TPlast_FD_Form.FormCreate(Sender: TObject);
begin
 first_show_FD_form:=true;
end;

procedure TPlast_FD_Form.Add_xClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� �� X';
 New_Cut_Form.caption:='����� ��������� �� X';
 New_Cut_Form.Showmodal;
end;

procedure TPlast_FD_Form.Add_yClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� �� Y';
 New_Cut_Form.caption:='����� ��������� �� Y';
 New_Cut_Form.Showmodal;
end;



procedure Tplast_fd_form.Del_Cut(xory:char ; num:integer);
 //�������� ��������
var
  i,j,nn,ii,iii,jj,jjj:integer;
  cz:array[1..plast_max_zak,1..2] of extended;//���������� �����������
  cf:array[1..plast_max_for,1..2] of extended;//���������� ��������
   currentnx,currentny : integer;
begin
     CurrentNx:=0;
     CurrentNy:=0;
     if xory='X' then CurrentNx:=num;
     if xory='Y' then CurrentNy:=num;
     Main_Form.StatusBar1.Panels[1].Text := '';
     Main_Form.StatusBar1.Panels[2].Text := '';

        if currentnx<>0 then
        begin
        //�������� �����������

         for i:=1 to p.kz1 do
         begin
          if   (p.kx1>=p.ky1) and (p.zak1[i]>=(currentnx-1)*p.ky1+1) and (p.zak1[i]<= (currentnx)*p.ky1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
            for j:=1 to p.ky1 do
            if   (p.kx1<p.ky1) and (p.zak1[i]=(p.kx1)*(j-1)+currentnx) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
           end;
          //�������� ���
         for i:=1 to p.kl1 do
         begin
          if   (p.kx1>=p.ky1) and (p.nomm[i]>=(currentnx-1)*p.ky1+1) and (p.Nomm[i]<= (currentnx)*p.ky1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
            for j:=1 to p.ky1 do
           if   (p.kx1<p.ky1) and (p.nomm[i]=(p.kx1)*(j-1)+currentnx) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
           end;
          end;// currentnx<>0

           if currentny<>0 then
        begin
        //�������� �����������
         for i:=1 to p.kz1 do
         begin
          for j:=1 to p.kx1 do
          if   (p.kx1>=p.ky1) and (p.zak1[i]=(p.ky1)*(j-1)+currentny) then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
            if   (p.kx1<p.ky1) and (p.zak1[i]>=(currentny-1)*p.kx1+1) and (p.zak1[i]<= (currentny)*p.kx1)then
            begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ �����������.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
           end;
          //�������� ���
         for i:=1 to p.kl1 do
         begin
          for j:=1 to p.kx1 do
          if   (p.kx1>=p.ky1) and (p.Nomm[i]=(p.ky1)*(j-1)+currentny) then
               begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
             if   (p.kx1<p.ky1) and (p.nomm[i]>=(currentny-1)*p.kx1+1) and (p.nomm[i]<= (currentny)*p.kx1)then
           begin
              Main_Form.StatusBar1.Panels[1].Text := '�� ����� ��������� ������������ ����.';
              Main_Form.StatusBar1.Panels[2].Text := '�������� ������ �����.';
              beep;
              Exit;
            end;
           end;
          end;// currentny<>0
          //����� ��������
                  //���������� ����������
   iii:=1;
   jjj:=1;
   if p.kx1>=p.ky1 then  //���� ��������� �� ���������
    begin
    for ii:=1 to p.kz1 do
        for i:=1 to p.kx1 do
         for j:=1 to p.ky1 do
         begin
         nn:=(i-1)*p.ky1+j;
         if p.zak1[ii]=nn then
          begin
          cz[iii,1]:=p.xm1[i];
          cz[iii,2]:=p.ym1[j];
          iii:=iii+1;
          end;
         end;

    for jj:=1 to p.kl1 do
        for i:=1 to p.kx1 do
         for j:=1 to p.ky1 do
         begin
         nn:=(i-1)*p.ky1+j;
         if p.nomm[jj]=nn then
          begin
          cf[jjj,1]:=p.xm1[i];
          cf[jjj,2]:=p.ym1[j];
          jjj:=jjj+1;
          end;
          end;
        end

   else        // ���� ��������� �� �����������
     begin
       for ii:=1 to p.kz1 do
         for i:=1 to p.ky1 do
          for j:=1 to p.kx1 do
           begin
            nn:=(i-1)*p.kx1+j;
            if p.zak1[ii]=nn then
             begin
              cz[iii,1]:=p.xm1[j];
              cz[iii,2]:=p.ym1[i];
              iii:=iii+1;
             end;
           end;

         for jj:=1 to p.kl1 do
          for i:=1 to p.ky1 do
           for j:=1 to p.kx1 do
            begin
             nn:=(i-1)*p.kx1+j;
              if p.nomm[jj]=nn then
               begin
                cf[jjj,1]:=p.xm1[j];
                cf[jjj,2]:=p.ym1[i];
                jjj:=jjj+1;
               end;
              end;
         end;
//��������� ����������

//��������� ����� ���������
if currentnx<>0 then
begin
 for i:=2 to p.kx1-1 do
  if i>=currentnx then
   p.xm1[i]:=p.xm1[i+1];
 dec(p.kx1);
end;

if currentny<>0 then
begin
 for i:=2 to p.ky1-1 do
  if i>=currentny then
   p.ym1[i]:=p.ym1[i+1];
 dec(p.ky1);
end;
// ������������!

 //��������� ����� - ����� ������
 iii:=1;
 jjj:=1;
 if p.kx1>=p.ky1 then //���� ��������� �� ���������
    begin
        for ii:=1 to p.kz1 do
         for i:=1 to p.kx1 do
          for j:=1 to p.ky1 do
           begin
            nn:=(i-1)*p.ky1+j;
             if (round(cz[ii,1])=round(p.xm1[i])) and (round(cz[ii,2])=round(p.ym1[j])) then
              begin
               p.zak1[iii]:=nn;
               iii:=iii+1;
              end;
            end;

       for jj:=1 to p.kl1 do
         for i:=1 to p.kx1 do
          for j:=1 to p.ky1 do
           begin
            nn:=(i-1)*p.ky1+j;
             if (round(cf[jj,1])=round(p.xm1[i])) and (round(cf[jj,2])=round(p.ym1[j])) then
              begin
               p.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
           end;
    end
 else                   //���� ��������� �� �����������
      begin
        for ii:=1 to p.kz1 do
         for i:=1 to p.ky1 do
          for j:=1 to p.kx1 do
           begin
            nn:=(i-1)*p.kx1+j;
             if (round(cz[ii,1])=round(p.xm1[j])) and (round(cz[ii,2])=round(p.ym1[i])) then
               begin
                p.zak1[iii]:=nn;
                iii:=iii+1;
               end;
            end;

       for jj:=1 to p.kl1 do
         for i:=1 to p.ky1 do
          for j:=1 to p.kx1 do
           begin
            nn:=(i-1)*p.kx1+j;
            if (round(cf[jj,1])=round(p.xm1[j])) and (round(cf[jj,2])=round(p.ym1[i])) then
              begin
               p.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
            end ;
   end ;
 //�������������� ��������� � ������������ � ������ �������
 plast_M.Tplast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 plast_FD_Form.showD(p);
 Main_Form.Cut_plast_Toolbutton.Enabled:=true;
 Main_Form.ActiveMDIChild.RePaint;
 cursor:=crdefault;


end;  //����� ��������



procedure Tplast_FD_Form.Cut_by_y_coordsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
// ACol,ARow:integer;
 M:TPoint;
begin
dely.Enabled:=true;
//================ ������ ����������� PopUp ���� =================
 if Shift=[ssRight] then
  begin
   Cut_by_y_coords.MouseToCell(X,Y,ACol1,ARow1);
    if (ARow1=0) then exit;
      Main_Form.StatusBar1.Panels[0].Text := '';
      Main_Form.StatusBar1.Panels[1].Text := '';
      Main_Form.StatusBar1.Panels[2].Text := '';
    if (ARow1=1) or (ARow1=p.ky1) then
     begin
      //Main_Form.StatusBar1.Panels[1].Text := '���������� ������� ��������� ���������.';
      //Main_Form.StatusBar1.Panels[2].Text := '�������� ������ ���������.';
      //beep;
      //exit;
       dely.Enabled:=false;
     end;

   M.x:=X+6;
   M.y:=Y+74;
   DelY_PM.Popup(ClientToScreen(M).X,ClientToScreen(M).Y);
   //DelY_PM.Popup(x,y);
  end;
end;

procedure Tplast_FD_Form.delyClick(Sender: TObject);
begin
 Del_Cut('Y',ARow1);
end;

procedure TPlast_FD_Form.Cut_by_x_coordsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
// ACol,ARow:integer;
 M:TPoint;
begin
 delx.Enabled:=true;
//================ ������ ����������� PopUp ���� =================
 if Shift=[ssRight] then
  begin
   Cut_by_x_coords.MouseToCell(X,Y,ACol1,ARow1);
    if (ARow1=0) then exit;
     Main_Form.StatusBar1.Panels[0].Text := '';
     Main_Form.StatusBar1.Panels[1].Text := '';
     Main_Form.StatusBar1.Panels[2].Text := '';
    if (ARow1=1) or (ARow1=p.kx1) then
     begin
      //Main_Form.StatusBar1.Panels[1].Text := '���������� ������� ��������� ���������.';
      //Main_Form.StatusBar1.Panels[2].Text := '�������� ������ ���������.';
     // beep;
      //exit;
       delx.Enabled:=false;
     end;
   M.x:=X+6;
   M.y:=Y+74;
   DelX_PM.Popup(ClientToScreen(M).X,ClientToScreen(M).Y);
   //DelY_PM.Popup(x,y);
  end;

end;

procedure TPlast_FD_Form.DelxClick(Sender: TObject);
begin
  Del_Cut('X',ARow1);
end;

procedure TPlast_FD_Form.Add_ZakClick(Sender: TObject);
begin
 Plast_FD_Form.Button1Click(Sender);
end;

procedure TPlast_FD_Form.Add_ForceClick(Sender: TObject);
begin
 if p.kl1=plast_max_for then
        begin
          MessageDlg('������� ����� ����������� �����',mtWarning,[mbOk],0);
          Exit;
        end;
 addforce_form.Caption:='�������� ����������';
 addforce_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
 addforce_form.number.text:='';
{ inc(p.kl1);}
 addforce_form.ShowModal;
end;

procedure TPlast_FD_Form.Del_NagrClick(Sender: TObject);
begin
 addforce_form.number.text:= Nagr_Grd_FD.Cells[0,1];
 addforce_form.Caption:='�������� ����������';
 addforce_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
 addforce_form.ShowModal;
end;

procedure TPlast_FD_Form.Add_xgClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� �� X';
 New_Cut_Form.caption:='����� ��������� �� X';
 New_Cut_Form.Showmodal;
end;

procedure TPlast_FD_Form.Add_ygClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� �� Y';
 New_Cut_Form.caption:='����� ��������� �� Y';
 New_Cut_Form.Showmodal;
end;

{����������, ����������� ����}
procedure TPlast_FD_Form.Nagr_Grd_FDEnter(Sender: TObject);
begin
 Nagr_Grd_SetEdit:=True;
end;
{����� ����������� ���� ����������}

{����������, ����������� ����}
procedure TPlast_FD_Form.Nagr_Grd_FDExit(Sender: TObject);
begin
Plast_FD_form.showD(p);
end;
{����� ����������� ���� ����������}

{����������, ����������� ����}
procedure Tplast_FD_Form.Nagr_Grd_FDGetEditText(Sender: TObject; ACol,
  ARow: Integer; var Value: String);
begin
 Nagr_Grd_Value:=Value;
 Nagr_Grd_ACol:=ACol;
 Nagr_Grd_ARow:=ARow;
 Nagr_Grd_SetEdit:=False;
end;
{����� ����������� ���� ����������}

{����������, ����������� ����}
procedure TPlast_FD_Form.Nagr_Grd_FDKeyPress(Sender: TObject;
  var Key: Char);
begin
 Nagr_Grd_Key:=Key;
end;
{����� ����������� ���� ����������}

{����������, ����������� ����}
{����� ����������� ���� ����������}

{����������, ����������� ����}
procedure TPlast_FD_Form.Nagr_Grd_FDSelectCell(Sender: TObject; Col,
  Row: Integer; var CanSelect: Boolean);
begin
  if not Nagr_Grd_SetEdit then
   begin
    plast_FD_form.showD(p);
    Nagr_Grd_SetEdit:=True;
   end;
end;
{����� ����������� ���� ����������}

{����������, ����������� ����}
{����� ����������� ���� ����������}

procedure TPlast_FD_Form.Nagr_Grd_FDSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
{var
   {sn : integer;}
   {error : boolean;}
  {nomm,os:array[1..plast_max_for] of integer;} // �������� (����� ����, ������� ����������(�� X - 11, �� Y - 22, �� X � Y - 33), �� X, �� y)
  {nom11,nom22:array[1..plast_max_for] of single;}
begin
{ sn:=strtoint(Nagr_Nagr_ComboBox.Text);
      error:=False;
      try
        Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom22[sn]:=StrToFloat(Nagr_Grd_FD.Cells[1,1]);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� X';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        error:=true;

      end;
      try
        Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.nom11[sn]:=StrToFloat(Nagr_Grd_FD.Cells[2,1]);
      except
        Beep;
        Main_Form.StatusBar1.Panels[1].Text :='������ ��� ����� ���� �� Y';
        Main_Form.StatusBar1.Panels[2].Text :='���� ������� �� �����';
        error:=true;
      end;}

 if  Nagr_GRD_Key=chr(13) then begin
  if isNumber(Nagr_Grd_FD.Cells[Nagr_Grd_ACol,Nagr_Grd_ARow]) then
     if(nagr_Grd_ARow<>1)and(nagr_Grd_ARow<>p.kx1)and(StrToFloat(Nagr_Grd_FD.Cells[Nagr_Grd_ACol,Nagr_Grd_ARow])<StrToFloat(Nagr_Grd_FD.Cells[nagr_Grd_ACol,nagr_Grd_ARow+1]))and(StrToFloat(Nagr_Grd_FD.Cells[Nagr_Grd_ACol,Nagr_Grd_ARow])>StrToFloat(Nagr_Grd_FD.Cells[Nagr_Grd_ACol,Nagr_Grd_ARow-1])) then
     begin
// my     p.xm1[nagr_Grd_ARow]:=StrToFloat(Nagr_Grd_FD.Cells[Nagr_Grd_ACol,Nagr_Grd_ARow]);
p.xm1[nagr_Grd_ARow]:= StrToFloat(Nagr_Grd_FD.Cells[1,1]);
p.ym1[nagr_Grd_ARow]:= StrToFloat(Nagr_Grd_FD.Cells[2,1]);
     Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
     Main.Main_Form.ActiveMDIChild.Repaint;
     Plast_FD_form.showD(p);
     Nagr_Grd_SetEdit:=True;
     end
{test}
//          Nagr_Grd_FD.Cells[1,1]:=FormatFloat('0.##',plast.nom11[Nagr_Nagr_ComboBox.ItemIndex+1]);
//          Nagr_Grd_FD.Cells[2,1]:=FormatFloat('0.##',plast.nom22[Nagr_Nagr_ComboBox.ItemIndex+1]);
{end of test}
     else
      Plast_FD_form.showD(p)
  else
   begin
    Plast_FD_form.showD(p);
   end
  end;

end;

procedure TPlast_FD_Form.Button1Click(Sender: TObject);
begin
  AddZak_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
  AddZak_form.ShowModal;
end;

procedure TPlast_FD_Form.Button2Click(Sender: TObject);
begin
ShowMessage('�������� ��� ����������� �� "�� ���������"');
end;

procedure TPlast_FD_Form.Button3Click(Sender: TObject);
var i,j:integer;
begin
  if p.kl1=3 then
    begin
      MessageDlg('������� ����� ������� ����������',mtWarning,[mbOk],0);
      Exit;
    end;
  addforce_form.Caption:='�������� ������ ����������';
  addforce_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
  addforce_form.number.text:='';
  inc(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl);
  Main_Form.Sn_Cbx.Items.clear;
      for i:=1 to Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl do  Main_Form.Sn_Cbx.Items.Add('������ ���������� '+IntToStr(i));
      main_form.SN_Cbx.ItemIndex:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl-2;
      inc(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).plast.kl1);
      main_form.Sn_cbx.Enabled:=true;
//      close;
Main_Form.Sn_Cbx.Itemindex:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).kl-1;
Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Repaint;
Hide;
Show;

 { inc(p.kl1);}
// addforce_form.ShowModal;

end;

procedure TPlast_FD_Form.Button4Click(Sender: TObject);
begin
     addforce_form.number.text:= Nagr_Grd_FD.Cells[0,1];
     addforce_form.Caption:='�������� ����������';
     addforce_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
     addforce_form.ShowModal;
end;

procedure TPlast_FD_Form.Button5Click(Sender: TObject);
var   form:TPlast_Form;
begin
form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
//ShowMessage('��� �������� ������� �� ������ "��������"'+#10#13+'����� �������� � ���� � � ����������� ���� �������� �������� ��������');
form.deleteVar(Nagr_nagr_combobox.ItemIndex+1);
Hide;
Show;
end;

procedure TPlast_FD_Form.Button6Click(Sender: TObject);
begin
      New_Cut_Form.OS_Label.caption:='���������� �� Y';
      New_Cut_Form.caption:='����� ��������� �� Y';
      New_Cut_Form.Showmodal;
end;

procedure TPlast_FD_Form.Button7Click(Sender: TObject);
begin
ShowMessage('������� ������ ������ ����, �� ��������� ��������� '+#10#13+'� �������� ����� "�������".'+#10#13+' �������� ��������, ������ ���� � ������� ��������� �� ��������� �������� � �����������!');
end;

procedure TPlast_FD_Form.Button8Click(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� �� X';
 New_Cut_Form.caption:='����� ��������� �� X';
 New_Cut_Form.Showmodal;
end;

procedure TPlast_FD_Form.Button9Click(Sender: TObject);
begin
  ShowMessage('������� ������ ������ ����, �� ��������� ��������� '+#10#13+'� �������� ����� "�������".'+#10#13+' �������� ��������, ������ ���� � ������� ��������� �� ��������� �������� � �����������!');
end;

procedure TPlast_FD_Form.del_buttonClick(Sender: TObject);
var CurrentNode:integer;
form:TPlast_Form;
code :integer;
begin
form:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild);
val(Nagr_Grd_FD.Cells[0,Nagr_Grd_FD.Row],CurrentNode,code);
form.deletenode(CurrentNode,Nagr_Nagr_ComboBox.ItemIndex+1);
Hide;
Show;
end;

procedure TPlast_FD_Form.add_buttonClick(Sender:TObject);
begin
//Main_Form.PlastNumberButton.Down:=True;
//Main_Form.PlastNumberButtonClick(Sender);
AddForce_form.Label3.Caption:='<= '+inttostr(p.kx1*p.ky1);
AddForce_form.number.text:='';
addforce_form.ShowModal;
//hide;
show;
end;

procedure TPlast_FD_Form.chg_buttonClick(Sender: TObject);
begin
//Main_Form.Plast_Nagr_ToolButton.Click;
end;

procedure TPlast_FD_Form.ADD_STEPCUTX_BUTTONClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� ����� �� X';
 New_Cut_Form.caption:='����� ��������� �� X';
 New_Cut_Form.Label3.Caption  :='<=12';
 New_Cut_Form.Showmodal;
end;

procedure TPlast_FD_Form.ADD_STEPCUTY_BUTTONClick(Sender: TObject);
begin
 New_Cut_Form.OS_Label.caption:='���������� ����� �� Y';
 New_Cut_Form.caption:='����� ��������� �� Y';
 New_Cut_Form.Label3.Caption  :='<=12';
 New_Cut_Form.Showmodal;
end;

end.
