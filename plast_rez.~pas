unit plast_rez;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Grids, ExtCtrls;

type
  TPlast_Rez_Form = class(TForm)
    Plast_rez_PageControl: TPageControl;
    KE_TabSheet: TTabSheet;
    Node_TabSheet: TTabSheet;
    Bevel3: TBevel;
    Visio: TLabel;
    Bevel_Grd: TBevel;
    Param_Grd: TStringGrid;
    Label6: TLabel;
    Sn_Cbx: TComboBox;
    Nst_Label: TLabel;
    Maxeq_Napr_Label: TLabel;
    Maxeq_Edt: TEdit;
    V_Edt: TEdit;
    V_Label: TLabel;
    Vtok_Label: TLabel;
    Vtok_Edt: TEdit;
    Fwtok_Edt: TEdit;
    fwTok_Label: TLabel;
    Bevel4: TBevel;
    Popt_Label: TLabel;
    Popt_edt: TEdit;
    Kit_label: TLabel;
    Kit_Edt: TEdit;
    Label2: TLabel;
    KE_Grd: TStringGrid;
    Bevel5: TBevel;
    Label1: TLabel;
    sn_ke_cbx: TComboBox;
    iz_label: TLabel;
    Bevel1: TBevel;
    r: TLabel;
    NachT: TLabel;
    Bevel2: TBevel;
    Bevel6: TBevel;
    maxnapr_Label: TLabel;
    Label3: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    vse_Label: TLabel;

    procedure Sn_CbxChange(Sender: TObject);
    procedure Sn_ke_CbxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  //  procedure ScrollBar_keScroll(Sender: TObject; ScrollCode: TScrollCode;
     // var ScrollPos: Integer);
 //   procedure ScrollBar_uzScroll(Sender: TObject; ScrollCode: TScrollCode;
   //   var ScrollPos: Integer);
   // procedure FormCreate(Sender: TObject);


  private
  NumOk:boolean; //Была ли включена нумерация ??
    { Private declarations }
  public
   procedure Execute(fn,fe:string);
    { Public declarations }
  end;

const
 up=63;

var
  Plast_Rez_Form: TPlast_Rez_Form;
  perx,pery: array[1..3,1..225] of extended; //перемещения узлов
  kx,ky:integer;
  s,s1,fee: string;
  code:integer;
  tm: array[1..196] of extended; // толщина КЭ
  sem:array[1..196] of extended; // макс экв напр КЭ
  ve: array[1..196] of extended; // объем КЭ
  gf: array[1..196] of extended; // сил вес КЭ
  en: array[1..3,1..196] of extended; //эквивалентные напряжения
  nx: array[1..3,1..196] of extended; //напр. по Х
  ny: array[1..3,1..196] of extended; //напр. по Y
  kas: array[1..3,1..196] of extended; // касательные напряжения
  sn,sn1,kit,kz,kl,nit:integer;

  flag:boolean;
  w,w1,w2,w3:system.text;
implementation

uses Main,Plast_M, Plast_FD, Visio;

{$R *.DFM}


procedure TPlast_Rez_Form.Execute(fn,fe:string);
label exit;
var
  ff:system.text;
  dk:extended;//диагональный коэффициент
  counter,i,ii,ms,i1,i2,j:integer;
  s_lin, str1, s_for, s_tok, tok_error, tok_s_lin, tok_s_for:string;
  li: array[1..15] of extended;
  tok_weight,men,vtok,fwtok,potrv,pogr:extended;
  flag, error:boolean;


begin
 str1:='';
 fee:=fe;

  if fe='.vrp' then
  begin
    assignfile(ff,ChangeFileExt(FN,'.vrp'));
 reset(ff);
 readln(ff);
  readln(ff,kit);
   readln(ff,kx);
    readln(ff,ky);
     readln(ff,kz);
      readln(ff,kl);
       Caption:='Результаты простого расчета для '+extractfilename(ChangeFileExt(FN,'.dnp')) ;
   while str1<> 'Перемещения, случай нагружения 1' do readln(ff,str1);
  end
  else
    begin
    assignfile(ff,ChangeFileExt(FN,'.vop'));
 reset(ff);
 readln(ff);
  readln(ff,kit);
   readln(ff,kx);
    readln(ff,ky);
     readln(ff,kz);
      readln(ff,kl);
       Caption:='Результаты оптимизации для '+extractfilename(ChangeFileExt(FN,'.dnp')) ;
       nit:=-1;
       str1:='';

       while nit<>kit-1 do
       begin
        while str1<> 'Номер итерации:' do readln(ff,str1);
        readln(ff,nit);
        readln(ff,str1);
       end;
   while str1<> 'Перемещения, случай нагружения 1' do readln(ff,str1);
  end;

   for i:=1 to kl do
   begin
    if i<>1 then readln(ff);
    for j:=1 to kx*ky do
     begin
      readln(ff);
      readln(ff,perx[i,j]);
      readln(ff);
      readln(ff,pery[i,j]);
     end;
   end;
  readln(ff);
      readln(ff);
   readln(ff,dk);

   for i:=1 to (kx-1)*(ky-1) do
    begin
     readln(ff);
     readln(ff);
     readln(ff,tm[i]);
     readln(ff);
     readln(ff,sem[i]);
     readln(ff);
     readln(ff,ve[i]);
     readln(ff);
     readln(ff,gf[i]);
     readln(ff);  // сил вес
    end;

    readln(ff);
    readln(ff);
    readln(ff);
     readln(ff);
    readln(ff,MEN);
   readln(ff);
    readln(ff,potrv);
    readln(ff);
    readln(ff,vtok);
    readln(ff);
    readln(ff,FWtok);
    readln(ff);
    readln(ff,pogr);
    closefile(ff);

   Sn_ke_CBx.Items.Clear;
  if kl=1 then Sn_ke_CBx.Enabled:=False else Sn_ke_CBx.Enabled:=True;
  for i:=1 to kl do
    Sn_ke_CBx.Items.Add(IntToStr(i));
      Sn_ke_CBx.Items.Add('<Max.>');
     Sn_ke_CBx.ItemIndex := Main_Form.plast_Sn_CBx.ItemIndex;
      sn1:=Sn_ke_CBx.ItemIndex+1;
  if fe='.vrp' then
  begin
  AssignFile(w1,ChangeFileExt(FN,'.ww1'));
   AssignFile(w2,ChangeFileExt(FN,'.ww2'));
    AssignFile(w3,ChangeFileExt(FN,'.ww3'));
  end
  else
  begin
  AssignFile(w1,ChangeFileExt(FN,'.w1'));
   AssignFile(w2,ChangeFileExt(FN,'.w2'));
    AssignFile(w3,ChangeFileExt(FN,'.w3'));
  end;
  Reset(w1);
  Reset(w2);
  Reset(w3);
  for i:=1 to (kx-1)*(ky-1) do
   begin
     readln(w1,s);
      s1:=copy(s,1,17);
     val(s1,nx[1,i],code);
     s1:=copy(s,18,17);
     val(s1,ny[1,i],code);
     s1:=copy(s,35,17);
     val(s1,kas[1,i],code);
          readln(w2,s);
          s1:=copy(s,1,17);
          val(s1,nx[2,i],code);
          s1:=copy(s,18,17);
          val(s1,ny[2,i],code);
          s1:=copy(s,35,17);
          val(s1,kas[2,i],code);
              readln(w3,s);
              s1:=copy(s,1,17);
              val(s1,nx[3,i],code);
              s1:=copy(s,18,17);
              val(s1,ny[3,i],code);
              s1:=copy(s,35,17);
              val(s1,kas[3,i],code);
   end;
  CloseFile(w1);
    CloseFile(w2);
      CloseFile(w3);

  if fe='.vrp' then
  AssignFile(w,ChangeFileExt(FN,'.ww0'))
  else
  AssignFile(w,ChangeFileExt(FN,'.w0'));
  Reset(w);
  readln(w);
    readln(w);
  for i:=1 to (kx-1)*(ky-1) do
   begin
     readln(w,s);
      s1:=copy(s,1,17);
     val(s1,en[1,i],code);
      s1:=copy(s,18,17);
     val(s1,en[2,i],code);
      s1:=copy(s,35,17);
     val(s1,en[3,i],code);

   end;
  CloseFile(w);

    //Отображение

    Sn_CBx.Items.Clear;
  if kl=1 then Sn_CBx.Enabled:=False else Sn_CBx.Enabled:=True;
  for i:=1 to kl do
    Sn_CBx.Items.Add(IntToStr(i));
      Sn_CBx.Items.Add('<Max.>');
     Sn_CBx.ItemIndex:=Main_Form.plast_Sn_CBx.ItemIndex;


with Param_Grd do
      begin
        RowCount:=kx*ky+1;

          FixedRows:=1;
          FixedCols:=1;

        RowHeights[0]:=17;
        Cells[0,0]:='№ Узла';
        Cells[1,0]:='Перемещение по X '+'['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
        Cells[2,0]:='Перемещение по Y '+'['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
        sn:=Sn_CBx.ItemIndex+1;
        for i:=1 to kx*ky do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',perx[sn,i]));
            Cells[2,i]:=(formatfloat('0.########',pery[sn,i]));
          end;
     end;


     with KE_Grd do
      begin
        RowCount:=(kx-1)*(ky-1)+1;
          FixedRows:=1;
          FixedCols:=1;
        RowHeights[0]:=17;
        Cells[0,0]:='№ КЭ';
        Cells[1,0]:='Толщина';//+' ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']' ;
        Cells[2,0]:='Экв. напр.';//+' ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
        Cells[3,0]:='Напр. по X';//+' ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
        Cells[4,0]:='Напр. по Y';//+' ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
        Cells[5,0]:='Кас. напр.';//+' ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
        for i:=1 to (kx-1)*(ky-1) do

          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',tm[i]));
            Cells[2,i]:=(formatfloat('0.###',en[sn1,i]));
            Cells[3,i]:=(formatfloat('0.###',nx[sn1,i]));
            Cells[4,i]:=(formatfloat('0.###',ny[sn1,i]));
            Cells[5,i]:=(formatfloat('0.###',kas[sn1,i]));
          end;
      end;
     r.Caption:='  Размерности: ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +','+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin +']  ';
     iz_label.Caption:='  из '+floattostr(kl)+'  ';
     Nst_Label.Caption:='  из '+floattostr(kl)+'  ';
     Visio.Caption:='  Перемещения узлов ['+ Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']  ';
    if kit>1 then
     begin
     Bevel2.visible:=true;
     nacht.visible:=true;
     nacht.caption:='  Начальная толщина: '+floattostr(Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1)+' '+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'  ';
     bevel2.Width:=nacht.Width+2;
     Kit_label.Caption:='Количество итераций';
     Maxeq_Napr_Label.caption:='Макс. экв. напряжение ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
     V_Label.caption:='Объем пластины до оптимизации ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**3]';
     Vtok_Label.caption:='Объем пластины после оптимизации ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**3]';
     fwTok_Label.caption:='Силовой вес пластины ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'*'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
     Popt_Label.caption:='Погрешность оптимизации';

     Kit_Edt.text:=floattostr(kit);
     Maxeq_Edt.text:=formatfloat('0.000e+00',men);
     V_Edt.text:=formatfloat('0.000e+00',Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1*Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.xm1[Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kx1]*Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ym1[Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ky1]);
     Vtok_Edt.text:=formatfloat('0.000e+00',vtok);
     Fwtok_Edt.text:=formatfloat('0.000e+00',fwtok);
       Popt_edt.text:=formatfloat('0.000e+00',pogr)+' %';
     // else Popt_edt.text:='-------------------------------------------------------------------------------------------------------------';
    end
   else
      begin
     Kit_label.Caption:='Макс. экв. напряжение ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'/'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**2]' ;
     Maxeq_Napr_Label.caption:='Объем пластины ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+'**3]';
     V_Label.caption:='Силовой вес пластины ['+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_for +'*'+Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.s_lin+']';
     Vtok_Label.visible:=false;
     fwTok_Label.visible:=false;
     Popt_Label.visible:=false;

     Kit_Edt.text:=formatfloat('0.000e+00',men);
     Maxeq_Edt.text:=formatfloat('0.000e+00',Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ton1*Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.xm1[Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.kx1]*Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ym1[Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).Plast.ky1]);
     V_Edt.text:=formatfloat('0.000e+00',fwtok);
     Vtok_Edt.visible:=false;
     Fwtok_Edt.visible:=false;
       Popt_edt.visible:=false;
     // else Popt_edt.text:='-------------------------------------------------------------------------------------------------------------';
    end;
   ShowModal;
exit:
end;



procedure TPlast_Rez_Form.Sn_CbxChange(Sender: TObject);

 function max(a1,a2,a3:extended;kl:integer):extended;
  begin
        max:=0;
     if kl=1 then max:=a1;
     if kl=2 then
        if abs(a1)>abs(a2)then max:= a1
        else max:= a2;
     if kl=3 then
      begin
        if abs(a1)>abs(a2)then a2:= a1;
        if abs(a3)>abs(a2)then max:= a3
        else max:= a2;
      end
//     else
//      result:= a3;
  end;

var
i,sn:integer;
begin
 Sn_ke_Cbx.ItemIndex:=Sn_Cbx.ItemIndex;
 if Sn_Cbx.ItemIndex<>kl then visio_form.num_force:=Sn_Cbx.ItemIndex+1; 
 if Sn_Cbx.ItemIndex<>kl then
  begin
 Main_Form.plast_Sn_CBx.ItemIndex:=Sn_Cbx.ItemIndex;
 plast_FD_form.showD(plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast);
 Main_Form.ActiveMDIChild.RePaint;
  end;

 if Sn_Cbx.ItemIndex=kl then
  begin
          bevel8.Visible:=true;
        bevel6.Visible:=true;
        vse_label.Visible:=true;
        maxnapr_Label.Visible:=true;
 with KE_Grd do
      begin
       sn1:=sn_ke_cbx.itemindex+1;
        for i:=1 to (kx-1)*(ky-1) do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',tm[i]));
            Cells[2,i]:=(formatfloat('0.###',max(en[1,i],en[2,i],en[3,i],kl)));
            Cells[3,i]:=(formatfloat('0.###',max(nx[1,i],nx[2,i],nx[3,i],kl)));
            Cells[4,i]:=(formatfloat('0.###',max(ny[1,i],ny[2,i],ny[3,i],kl)));
            Cells[5,i]:=(formatfloat('0.###',max(kas[1,i],kas[2,i],kas[3,i],kl)));
          end;
      end;

      with Param_Grd do
      begin

        {sn:=Sn_CBx.ItemIndex+1;}
        for i:=1 to kx*ky do
          begin
            Cells[0,i]:= IntToStr(i); //IntToStr(i+ScrollBar_uz.Position);
            Cells[1,i]:=(formatfloat('0.########',max(perx[1,i],perx[2,i],perx[3,i],kl)));
            Cells[2,i]:=(formatfloat('0.########',max(pery[1,i],pery[2,i],pery[3,i],kl)));
          end;
     end;
   end

   else
    begin
with Param_Grd do
      begin
      bevel8.Visible:=false;
        bevel6.Visible:=false;
        vse_label.Visible:=false;
        maxnapr_Label.Visible:=false;

        sn:=Sn_CBx.ItemIndex+1;
        for i:=1 to kx*ky do
          begin
            Cells[0,i]:= IntToStr(i); //IntToStr(i+ScrollBar_uz.Position);
            Cells[1,i]:=(formatfloat('0.########',perx[sn,i{+ScrollBar_uz.Position}]));
            Cells[2,i]:=(formatfloat('0.########',pery[sn,i{+ScrollBar_uz.Position}]));
          end;
     end;

     with KE_Grd do
      begin
       sn1:=sn_ke_cbx.itemindex+1;
        for i:=1 to (kx-1)*(ky-1) do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',tm[i]));
            Cells[2,i]:=(formatfloat('0.###',en[sn1,i]));
            Cells[3,i]:=(formatfloat('0.###',nx[sn1,i]));
            Cells[4,i]:=(formatfloat('0.###',ny[sn1,i]));
            Cells[5,i]:=(formatfloat('0.###',kas[sn1,i]));
          end;
      end;
  end;
end;



procedure TPlast_Rez_Form.Sn_ke_CbxChange(Sender: TObject);

 function max(a1,a2,a3:extended;kl:integer):extended;
  begin
        result:= 0 ;
     if kl=1 then result:=a1;
     if kl=2 then
        if abs(a1)>abs(a2)then result:= a1
        else result:= a2;
     if kl=3 then
      begin
        if abs(a1)>abs(a2)then a2:= a1;
        if abs(a3)>abs(a2)then result:= a3
        else result:= a2;
      end
//     else
//      result:= a3;
  end;

var
i,sn:integer;
begin
 Sn_CBx.ItemIndex:=Sn_ke_Cbx.ItemIndex;
 if Sn_ke_Cbx.ItemIndex<>kl then visio_form.num_force:=Sn_ke_Cbx.ItemIndex+1;
 if Sn_ke_Cbx.ItemIndex<>kl then
  begin
 Main_Form.plast_Sn_CBx.ItemIndex:=Sn_ke_Cbx.ItemIndex;
 plast_FD_form.showD(plast_M.Tplast_Form(Main_Form.ActiveMDIChild).plast);
 Main_Form.ActiveMDIChild.RePaint;
  end;
 // ScrollBar_uz.Position:=0;

 if Sn_ke_Cbx.ItemIndex=kl then
  begin
          bevel8.Visible:=true;
        bevel6.Visible:=true;
        vse_label.Visible:=true;
        maxnapr_Label.Visible:=true;
 with KE_Grd do
      begin
       sn1:=sn_ke_cbx.itemindex+1;
        for i:=1 to (kx-1)*(ky-1) do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',tm[i]));
            Cells[2,i]:=(formatfloat('0.###',max(en[1,i],en[2,i],en[3,i],kl)));
            Cells[3,i]:=(formatfloat('0.###',max(nx[1,i],nx[2,i],nx[3,i],kl)));
            Cells[4,i]:=(formatfloat('0.###',max(ny[1,i],ny[2,i],ny[3,i],kl)));
            Cells[5,i]:=(formatfloat('0.###',max(kas[1,i],kas[2,i],kas[3,i],kl)));
          end;
      end;

      with Param_Grd do
      begin

     //   sn:=Sn_CBx.ItemIndex+1;
        for i:=1 to kx*ky do
          begin
            Cells[0,i]:= IntToStr(i); //IntToStr(i+ScrollBar_uz.Position);
            Cells[1,i]:=(formatfloat('0.########',max(perx[1,i],perx[2,i],perx[3,i],kl)));
            Cells[2,i]:=(formatfloat('0.########',max(pery[1,i],pery[2,i],pery[3,i],kl)));
          end;
     end;
   end

  else
     begin
     bevel8.Visible:=false;
        bevel6.Visible:=false;
        vse_label.Visible:=false;
        maxnapr_Label.Visible:=false;
 with KE_Grd do
      begin
       sn1:=sn_ke_cbx.itemindex+1;
        for i:=1 to (kx-1)*(ky-1) do
          begin
            Cells[0,i]:=IntToStr(i);
            Cells[1,i]:=(formatfloat('0.########',tm[i]));
            Cells[2,i]:=(formatfloat('0.###',en[sn1,i]));
            Cells[3,i]:=(formatfloat('0.###',nx[sn1,i]));
            Cells[4,i]:=(formatfloat('0.###',ny[sn1,i]));
            Cells[5,i]:=(formatfloat('0.###',kas[sn1,i]));
          end;
      end;

      with Param_Grd do
      begin

        sn:=Sn_CBx.ItemIndex+1;
        for i:=1 to kx*ky do
          begin
            Cells[0,i]:= IntToStr(i); //IntToStr(i+ScrollBar_uz.Position);
            Cells[1,i]:=(formatfloat('0.########',perx[sn,i{+ScrollBar_uz.Position}]));
            Cells[2,i]:=(formatfloat('0.########',pery[sn,i{+ScrollBar_uz.Position}]));
          end;
     end;
   end;
end;




procedure TPlast_Rez_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if fee='.vrp' then
  begin
    KE_Grd.top:=KE_Grd.top+up;
    KE_Grd.height:=KE_Grd.height-up;
    Bevel5.top:=Bevel5.top+up;
    Bevel5.height:=Bevel5.height-up;
    Bevel1.top:=Bevel1.top+up;
    Bevel1.height:=Bevel1.height-up;
    label2.top:=label2.top+up;
    label1.top:=label1.top+up;
    iz_label.top:=iz_label.top+up;
    sn_ke_cbx.top:=sn_ke_cbx.top+up;
    r.top:=r.top+up;
    maxnapr_Label.top:=maxnapr_Label.top+up;
    bevel6.top:=bevel6.top+up;
  end;
     bevel2.visible:=false;
     NachT.visible:=false;
     Kit_label.visible:=true;
     Maxeq_Napr_Label.visible:=true;
     V_Label.visible:=true;
     Vtok_Label.visible:=true;
     fwTok_Label.visible:=true;
     Popt_Label.visible:=true;

     Kit_Edt.visible:=true;
     Maxeq_Edt.visible:=true;
     V_Edt.visible:=true;
     Vtok_Edt.visible:=true;
     Fwtok_Edt.visible:=true;
       Popt_edt.visible:=true;
       Param_Grd.ColWidths[1]:=159;
       Param_Grd.ColWidths[2]:=159;
        ke_Grd.ColWidths[2]:=70;
        ke_Grd.ColWidths[3]:=70;
        ke_Grd.ColWidths[4]:=70;
        ke_Grd.ColWidths[5]:=70;
        bevel8.Visible:=false;
        bevel6.Visible:=false;
        vse_label.Visible:=false;
        maxnapr_Label.Visible:=false;
         if not NumOk then
  begin
  { Main_Form.plastNumberButton.Down:=False;
   plast_M.Tplast_Form(Main_Form.ActiveMDIChild).Repaint;}
  end;
end;

procedure TPlast_Rez_Form.FormShow(Sender: TObject);
begin
 if fee='.vrp' then
  begin
    NumOk:=True;
 {if Main_Form.plastNumberButton.Down=False then
  begin
   Main_Form.plastNumberButton.Down:=True;
   plast_M.Tplast_Form(Main_Form.ActiveMDIChild).Repaint;
   NumOk:=False;
  end;}
    KE_Grd.top:=KE_Grd.top-up;
    KE_Grd.height:=KE_Grd.height+up;
    Bevel5.top:=Bevel5.top-up;
    Bevel5.height:=Bevel5.height+up;
    Bevel1.top:=Bevel1.top-up;
    Bevel1.height:=Bevel1.height+up;
    label2.top:=label2.top-up;
    label1.top:=label1.top-up;
    iz_label.top:=iz_label.top-up;
    sn_ke_cbx.top:=sn_ke_cbx.top-up;
    r.top:=r.top-up;
    maxnapr_Label.top:=maxnapr_Label.top-up;
    bevel6.top:=bevel6.top-up;
  end;
 if kx*ky<=19 then Param_Grd.ColWidths[1]:=167;
 if kx*ky<=19 then Param_Grd.ColWidths[2]:=167;
  if ((kx-1)*(ky-1)<=10) and (fee='.vop') then ke_Grd.ColWidths[2]:=74;
  if ((kx-1)*(ky-1)<=10) and (fee='.vop') then ke_Grd.ColWidths[3]:=74;
  if ((kx-1)*(ky-1)<=10) and (fee='.vop') then ke_Grd.ColWidths[4]:=74;
  if ((kx-1)*(ky-1)<=10) and (fee='.vop') then ke_Grd.ColWidths[5]:=74;
  if ((kx-1)*(ky-1)<=14) and (fee='.vrp') then ke_Grd.ColWidths[2]:=74;
  if ((kx-1)*(ky-1)<=14) and (fee='.vrp') then ke_Grd.ColWidths[3]:=74;
  if ((kx-1)*(ky-1)<=14) and (fee='.vrp') then ke_Grd.ColWidths[4]:=74;
  if ((kx-1)*(ky-1)<=14) and (fee='.vrp') then ke_Grd.ColWidths[5]:=74;

  end;

end.
