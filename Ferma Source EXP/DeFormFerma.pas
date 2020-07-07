unit DeFormFerma;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Ferm_Dat, Ferma_M, ComCtrls, ToolWin, StdCtrls, Buttons,
  ImgList, Menus;

type
  TDeForm_Form = class(TForm)
    DeForm_PaintBox: TPaintBox;
    Bevel: TBevel;
    ImageList: TImageList;
    Panel: TPanel;
    Napr_PaintBox: TPaintBox;
    Plus_Sbtn: TSpeedButton;
    Minus_Sbtn: TSpeedButton;
    Panel_TB: TPanel;
    DeForm_TB: TToolBar;
    Scale_Edit: TEdit;
    Sep2: TToolButton;
    ScrollBar: TScrollBar;
    Napr_TB: TToolBar;
    Perem_ChB: TCheckBox;
    All_ToolBar: TToolBar;
    Sn_Cbx: TComboBox;
    Sep1: TToolButton;
    Sep3: TToolButton;
    ToolButton: TToolButton;
    dfrm_mnu: TPopupMenu;
    N1: TMenuItem;
    procedure FermPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScrollBarChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Sn_CbxChange(Sender: TObject);
    procedure ToolButtonClick(Sender: TObject);
    procedure Plus_SbtnClick(Sender: TObject);
    procedure Minus_SbtnClick(Sender: TObject);
    procedure Napr_PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Perem_ChBClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    
  private
    { Private declarations }
    nst,nyz,scale:integer;
    sd:extended;
    p:array[1..9,1..2,1..3] of extended; // перемещения
    ps:array[1..15,1..3] of extended;    // напряжения
    tol:array[1..15] of extended;        // потребные площади
    pluscolor,minuscolor:array[1..7] of longint;
  public
    { Public declarations }
    Num_Color:integer;// Количество уровней цветов (2 - 7)
  end;

var
  DeForm_Form: TDeForm_Form;

implementation

uses Main, Ferma_FD;

{$R *.DFM}


procedure TDeForm_Form.FermPaint(Sender: TObject);
var
  x_max,y_max, //Размеры графической области
  step_int,i,j,x1,x2,y1,y2,yline,xtop,xbot,ytop,ybot,Xp,YPlus,
  nf:integer; // Случай нагружения
  max_x_coord,max_y_coord,
  step,
  mas_x,mas_y:extended;     //Масштабирующие коэффициенты
  number:string;
  ferm:Tferm;
  Coord_Axis_X, Coord_Axis_Y:integer;
  Coord_Axis_X1, Coord_Axis_Y1:integer;
  max_value,min_value:extended;
  minus_Flag, plus_Flag:boolean;
  Scale_Len, Scale_Step:extended;
  _string,_format:string;
  Current_Value,aa,bb,cc,dd:extended;
  xxx,yyy:integer;
begin
Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
if Ferm=nil then Exit;
//Razm.caption:='  ['+{ferm.s_for+', '+}ferm.s_lin+']';
if ToolButton.ImageIndex=1 then
 begin
  with DeForm_PaintBox.Canvas do
    begin

      nf:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag; // Случай нагружения


      x_max:=DeForm_PaintBox.width;
      y_max:=DeForm_PaintBox.height;


      max_x_coord:=ferm.region_x;
      max_y_coord:=ferm.region_y;

      {Рисуем Координатные Оси}
      Pen.Mode:=pmCopy;
      Pen.color:=clGray;
      Pen.width:=1;
      
      coord_axis_x:=50;
      coord_axis_y:=60;
      coord_axis_x1:=50;
      coord_axis_y1:=50;

      MoveTo(coord_axis_x+50,coord_axis_y1);LineTo(x_max-coord_axis_x1+1,coord_axis_y1); // верх. горизонталь
      MoveTo(x_max-coord_axis_x1,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1,coord_axis_y1); // правая вертикаль
      MoveTo(coord_axis_x+43,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+15,y_max-coord_axis_y); // Ось X
      LineTo(x_max-coord_axis_x1+10,y_max+5-coord_axis_y);
      MoveTo(x_max-coord_axis_x1+15,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+10,y_max-5-coord_axis_y);
      MoveTo(coord_axis_x+50,y_max-coord_axis_y+10);LineTo(coord_axis_x+50,coord_axis_y1-15); // Ось Y
      LineTo(coord_axis_x+45,coord_axis_y1-10);
      MoveTo(coord_axis_x+50,coord_axis_y1-15);LineTo(coord_axis_x+55,coord_axis_y1-10);

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
      TextOut(27,y_max-18,'0');
      step:=max_x_coord/4;
      step_int:=round((x_max-coord_axis_x1-50-coord_axis_x)/4);    // Ось X
      for i:=1 to 5 do
       begin
        str((max_x_coord-step*(i-1)):5:2,number);
        TextOut(x_max-coord_axis_x1-22-step_int*(i-1),y_max-18,number);
        MoveTo(x_max-coord_axis_x1-step_int*(i-1),y_max-coord_axis_y);
        LineTo(x_max-coord_axis_x1-step_int*(i-1),y_max+10-coord_axis_y);
       end;
      step:=max_y_coord/4;                           // Ось Y
      step_int:=round((y_max-coord_axis_y1-coord_axis_y)/4);
      for i:=1 to 5 do
       begin
        str((max_y_coord-step*(i-1)):5:2,number);
        TextOut(5,coord_axis_y1-7+step_int*(i-1),number);
        MoveTo(43+coord_axis_x,coord_axis_y1+step_int*(i-1));
        LineTo(50+coord_axis_x,coord_axis_y1+step_int*(i-1));
       end;

      {Рисуем Ферму}
      Pen.Color:=clBlack;
      Pen.width:=2;
      if ferm.nyz1=0 then begin max_x_coord:=1;max_y_coord:=1 end;
      mas_x:=(x_max-50-coord_axis_x1-coord_axis_x)/max_x_coord; //Масштабирующие коэффициенты
      mas_y:=(y_max-coord_axis_y1-coord_axis_y)/max_y_coord;
      for i:=1 to ferm.nst1 do
       begin
        MoveTo(50+coord_axis_x+round(mas_x*ferm.corn[ferm.itopn[i,1],1]),y_max-coord_axis_y-round(mas_y*ferm.corn[ferm.itopn[i,1],2]));
        LineTo(50+coord_axis_x+round(mas_x*ferm.corn[ferm.itopn[i,2],1]),y_max-coord_axis_y-round(mas_y*ferm.corn[ferm.itopn[i,2],2]));
       end;

      //Рисуем деформированную ферму
      Pen.Color:=clRed;
      for i:=1 to ferm.nst1 do
       begin
          MoveTo(50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,1],1]+scale*p[ferm.itopn[i,1],1,nf])),y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,1],2]+scale*p[ferm.itopn[i,1],2,nf])));
          LineTo(50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,2],1]+scale*p[ferm.itopn[i,2],1,nf])),y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,2],2]+scale*p[ferm.itopn[i,2],2,nf])));
       end;

//Нумерация элементов
      brush.color:=clWhite;
      font.name:='small font';
      pen.Width:=1;
      pen.color:=clBlue;
      font.Color:=clGreen;
      font.size:=7;

      for i:=1 to ferm.nyz1 do   // Нумеруем узлы
       begin
        X1:=50+coord_axis_x+round(mas_x*ferm.corn[i,1]);
        Y1:=y_max-coord_axis_y-round(mas_y*ferm.corn[i,2]);
        brush.Style:=bsClear;
        font.size:=8;
        TextOut(X1+4,Y1-14,inttostr(i));
        font.size:=7;
        brush.Style:=bsSolid;
       end;

      for i:=1 to ferm.nst1 do  //Нумеруем стержни
       begin
        x1:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,1],1]+scale*p[ferm.itopn[i,1],1,nf]));
        y1:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,1],2]+scale*p[ferm.itopn[i,1],2,nf]));
        x2:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,2],1]+scale*p[ferm.itopn[i,2],1,nf]));
        y2:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,2],2]+scale*p[ferm.itopn[i,2],2,nf]));

        if x1>=x2 then begin xtop:=x1;xbot:=x2;end else begin xtop:=x2;xbot:=x1;end;
        if y1>=y2 then begin ytop:=y1;ybot:=y2;end else begin ytop:=y2;ybot:=y1;end;

        if X1<>X2 then
         begin
          if Y1=Y2 then
           begin
            YLine:=Round((XBot+(XTop-XBot)/2-X1)*(Y2-Y1)/(X2-X1))+Y1;
            brush.Style:=bsSolid;
            Rectangle(XBot+Round((xtop-xbot)/2)-6,YLine-6,XBot+Round((xtop-xbot)/2)+7,YLine+5);
            brush.Style:=bsClear;
            if i<=9 then Xp:=2 else Xp:=4;
            TextOut(XBot-Xp+Round((XTop-XBot)/2),YLine-6,inttostr(i));
           end
          else
           begin
            YLine:=Round((XBot+(XTop-XBot)/3-X1)*(Y2-Y1)/(X2-X1))+Y1;
            brush.Style:=bsSolid;
            Rectangle(XBot+Round((XTop-XBot)/3)-6,YLine-6,XBot+Round((XTop-XBot)/3)+6,YLine+7);
            brush.Style:=bsClear;
            if i<=9 then Xp:=2 else Xp:=4;
            TextOut(XBot-Xp+Round((XTop-XBot)/3),YLine-6,inttostr(i));
           end;
         end
        else
         begin
           brush.Style:=bsSolid;
           Rectangle(X1-6,YBot+Round((YTop-YBot)/2)-6,X2+8,YBot+Round((YTop-YBot)/2)+6);
           brush.Style:=bsClear;
           if i<=9 then X1:=X1-2 else X1:=X1-4;
           TextOut(X1,YBot+Round((YTop-YBot)/2)-6,inttostr(i));
         end;
      end; // Конец For
      Font.Color:=clBlack;
// Конец Numering

 end;
end // Рисовали деформации

 else // Рисуем напряженно-деформированное состояние
  begin
  case Num_Color of // Переопределяем цвета
            7: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
                pluscolor[6]:=9934847;
                minuscolor[6]:=16695190;
                pluscolor[7]:=11449853;
                minuscolor[7]:=16769486;
               end;
             6: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
                pluscolor[6]:=9934847;
                minuscolor[6]:=16695190;
               end;
             5: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
                pluscolor[5]:=5724159;
                minuscolor[5]:=16620377;
               end;
             4: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
                pluscolor[4]:=225;
                minuscolor[4]:=16548655;
               end;
             3: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
                pluscolor[3]:=202;
                minuscolor[3]:=15097604;
               end;
             2: begin
                pluscolor[1]:=87;
                minuscolor[1]:=8664578;
                pluscolor[2]:=153;
                minuscolor[2]:=12209411;
               end;
            end;

  with DeForm_PaintBox.Canvas do
    begin

      nf:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag; // Случай нагружения

      x_max:=DeForm_PaintBox.width;
      y_max:=DeForm_PaintBox.height;

      max_x_coord:=ferm.region_x;
      max_y_coord:=ferm.region_y;

      {Рисуем Координатные Оси}
      Pen.Mode:=pmCopy;
      Pen.color:=clGray;
      Pen.width:=1;

      coord_axis_x:=30;
      coord_axis_y:=30;
      coord_axis_x1:=30;
      coord_axis_y1:=40;

      MoveTo(coord_axis_x+50,coord_axis_y1);LineTo(x_max-coord_axis_x1+1,coord_axis_y1); // верх. горизонталь
      MoveTo(x_max-coord_axis_x1,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1,coord_axis_y1); // правая вертикаль
      MoveTo(coord_axis_x+43,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+15,y_max-coord_axis_y); // Ось X
      LineTo(x_max-coord_axis_x1+10,y_max+5-coord_axis_y);
      MoveTo(x_max-coord_axis_x1+15,y_max-coord_axis_y);LineTo(x_max-coord_axis_x1+10,y_max-5-coord_axis_y);
      MoveTo(coord_axis_x+50,y_max-coord_axis_y+10);LineTo(coord_axis_x+50,coord_axis_y1-15); // Ось Y
      LineTo(coord_axis_x+45,coord_axis_y1-10);
      MoveTo(coord_axis_x+50,coord_axis_y1-15);LineTo(coord_axis_x+55,coord_axis_y1-10);  

      brush.color:=clBtnFace;
      font.name:='times new roman';
      font.Style:=[fsBold];
      font.size:=10;
      TextOut(27,y_max-18,'0');
      step:=max_x_coord/4;
      step_int:=round((x_max-coord_axis_x1-50-coord_axis_x)/4);    // Ось X
      for i:=1 to 5 do
       begin
        str((max_x_coord-step*(i-1)):5:2,number);
        TextOut(x_max-coord_axis_x1-22-step_int*(i-1),y_max-18,number);
        MoveTo(x_max-coord_axis_x1-step_int*(i-1),y_max-coord_axis_y);
        LineTo(x_max-coord_axis_x1-step_int*(i-1),y_max+10-coord_axis_y);
       end;
      step:=max_y_coord/4;                           // Ось Y
      step_int:=round((y_max-coord_axis_y1-coord_axis_y)/4);
      for i:=1 to 5 do
       begin
        str((max_y_coord-step*(i-1)):5:2,number);
        TextOut(5,coord_axis_y1-7+step_int*(i-1),number);
        MoveTo(43+coord_axis_x,coord_axis_y1+step_int*(i-1));
        LineTo(50+coord_axis_x,coord_axis_y1+step_int*(i-1));
       end;

      {Рисуем Ферму}
      Pen.Color:=clBlack;
      Pen.width:=3;
      if ferm.nyz1=0 then begin max_x_coord:=1;max_y_coord:=1 end;
      mas_x:=(x_max-50-coord_axis_x1-coord_axis_x)/max_x_coord; //Масштабирующие коэффициенты
      mas_y:=(y_max-coord_axis_y1-coord_axis_y)/max_y_coord;

      //Рисуем напряженно-деформированную ферму
      min_Value:=0;
      max_Value:=0;
      for i:=1 to ferm.nst1 do
       begin
        if ps[i,nf]>=0 then
         begin
          if ps[i,nf]>=max_Value then max_Value:=ps[i,nf];
         end
        else
         begin
          if ps[i,nf]<min_Value then min_Value:=ps[i,nf];
         end;
       end;
      minus_Flag:=True;
      plus_Flag:=True;
      if max_value=0 then plus_flag:=False;
      if min_value=0 then minus_flag:=False;


{Рисуем Шкалу}
Napr_PaintBox.Height:=Panel.Height-22;
Plus_SBtn.Top:=Napr_PaintBox.Height+3;
Minus_SBtn.Top:=Napr_PaintBox.Height+3;
  with Napr_PaintBox.Canvas do
   begin
    if (not minus_flag) or (not plus_flag) then
      Scale_Len:=(Napr_PaintBox.Height-12)
     else
      Scale_Len:=(Napr_PaintBox.Height-12)/2;
    Scale_Step:=Scale_Len/Num_Color;


      brush.color:=clBtnFace;
      font.name:='small font';
      pen.Width:=1;
      font.Color:=clBLack;
      font.size:=7;

    if minus_Flag then
    begin
     //Сжатие
     for i:=1 to Num_Color do
      begin
       Brush.color:=minuscolor[i];
       FillRect(Rect(3,6+Round(Scale_Step*(i-1)),19,6+Round(Scale_Step*i)));
       brush.color:=clBtnFace;
       Current_Value:=min_value-(min_value/num_color)*(i-1);
       if (abs(Current_Value)<1) then _format:='#.####E+#'
        else _format:='#.##';
       _string:=FormatFloat(_format,Current_Value);
       textout(20,1+Round(Scale_Step*(i-1)),_string);
      end;
      brush.Color:=clBtnFace;
      textout(20,1+Round(Scale_Step*(i-1)),'0');
    end;

    if plus_flag then
     begin
      //Растяжение
      if not minus_flag then Scale_Len:=1;
      brush.color:=clBtnFace;
      textout(20,1+Round(Scale_Len),'0');
      for i:=1 to Num_Color do
       begin
        Brush.color:=pluscolor[Num_Color+1-i];
        FillRect(Rect(3,6+Round(Scale_Len+Scale_Step*(i-1)),19,6+Round(Scale_Len+Scale_Step*i)));
        brush.color:=clBtnFace;
        Current_Value:=max_value-(max_value/num_color)*(num_color-i);
        if Current_Value<1 then _format:='#.####E+#'
         else _format:='#.##';
        _string:=FormatFloat(_format,Current_Value);
        textout(20,1+Round(Scale_Len+Scale_Step*(i)),_string);
       end;
     end;

     if (not plus_flag) and (not minus_flag) then
      begin
        Brush.color:=pluscolor[Num_Color];
        FillRect(Rect(3,6,19,Napr_PaintBox.Height-6));
        brush.color:=clBtnFace;
        textout(20,Round(Napr_PaintBox.Height/2),'0');
        Minus_Sbtn.Enabled:=False;
        Plus_Sbtn.Enabled:=False;
      end;

   end;

//Рисуем стержни
      for i:=1 to ferm.nst1 do
       begin

          //Определяем цвет стержня
          for j:=1 to Num_Color do
           begin
            if ps[i,nf]>=0 then
             begin
              if ps[i,nf]<=max_value-(max_value/num_color)*(j-1) then
               pen.color:=pluscolor[j];
             end
            else
             begin
              if ps[i,nf]>=min_value-(min_value/num_color)*(j-1) then
               pen.color:=minuscolor[j];
             end;
           end;

          xxx:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,1],1]+scale*p[ferm.itopn[i,1],1,nf]));
          yyy:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,1],2]+scale*p[ferm.itopn[i,1],2,nf]));

          MoveTo(xxx,yyy);
          aa:=ferm.corn[ferm.itopn[i,2],1];
          bb:=scale*p[ferm.itopn[i,2],1,nf];
          cc:=mas_x*(aa+bb);
          xxx:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,2],1]+scale*p[ferm.itopn[i,2],1,nf]));
          yyy:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,2],2]+scale*p[ferm.itopn[i,2],2,nf]));
          LineTo(xxx,yyy);

          {if X1<>X2 then
           begin
            if XBot=X1 then YPlus:=Y1 else YPlus:=Y2;
            YLine:=Round((XBot+(XTop-XBot)/2.5-X1)*(Y2-Y1)/(X2-X1))+Y1;
            MoveTo(XBot,YPlus);
            LineTo(XBot+Round((XTop-XBot)/2.5),YLine);
            if XTop=X1 then YPlus:=Y1 else YPlus:=Y2;
            YLine:=Round((XTop-(XTop-XBot)/2.5-X1)*(Y2-Y1)/(X2-X1))+Y1;
            MoveTo(XTop,YPlus);
            LineTo(XTop-Round((XTop-XBot)/2.5),YLine);
           end
          else
           begin
            MoveTo(X1,YBot);
            LineTo(X1,YBot+Round((YTop-YBot)/3));
            MoveTo(X1,YTop);
            LineTo(X1,YTop-Round((YTop-YBot)/3));
           end;}
    end; // Конец Цикла по стержням

    //Нумерация элементов
      brush.color:=clWhite;
      font.name:='small font';
      pen.Width:=1;
      pen.color:=clBlue;
      font.Color:=clGreen;
      font.size:=7;

      for i:=1 to ferm.nyz1 do   // Нумеруем узлы
       begin
        X1:=50+coord_axis_x+round(mas_x*ferm.corn[i,1]);
        Y1:=y_max-coord_axis_y-round(mas_y*ferm.corn[i,2]);
        brush.Style:=bsClear;
        font.size:=8;
        TextOut(X1+4,Y1-14,inttostr(i));
        font.size:=7;
        brush.Style:=bsSolid;
       end;

      for i:=1 to ferm.nst1 do  //Нумеруем стержни
       begin
        x1:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,1],1]+scale*p[ferm.itopn[i,1],1,nf]));
        y1:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,1],2]+scale*p[ferm.itopn[i,1],2,nf]));
        x2:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,2],1]+scale*p[ferm.itopn[i,2],1,nf]));
        y2:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,2],2]+scale*p[ferm.itopn[i,2],2,nf]));

        if x1>=x2 then begin xtop:=x1;xbot:=x2;end else begin xtop:=x2;xbot:=x1;end;
        if y1>=y2 then begin ytop:=y1;ybot:=y2;end else begin ytop:=y2;ybot:=y1;end;

        if X1<>X2 then
         begin
          if Y1=Y2 then
           begin
            YLine:=Round((XBot+(XTop-XBot)/2-X1)*(Y2-Y1)/(X2-X1))+Y1;
            brush.Style:=bsSolid;
            Rectangle(XBot+Round((xtop-xbot)/2)-6,YLine-6,XBot+Round((xtop-xbot)/2)+7,YLine+5);
            brush.Style:=bsClear;
            if i<=9 then Xp:=2 else Xp:=4;
            TextOut(XBot-Xp+Round((XTop-XBot)/2),YLine-6,inttostr(i));
           end
          else
           begin
            YLine:=Round((XBot+(XTop-XBot)/3-X1)*(Y2-Y1)/(X2-X1))+Y1;
            brush.Style:=bsSolid;
            Rectangle(XBot+Round((XTop-XBot)/3)-6,YLine-6,XBot+Round((XTop-XBot)/3)+6,YLine+7);
            brush.Style:=bsClear;
            if i<=9 then Xp:=2 else Xp:=4;
            TextOut(XBot-Xp+Round((XTop-XBot)/3),YLine-6,inttostr(i));
           end;
         end
        else
         begin
           brush.Style:=bsSolid;
           Rectangle(X1-6,YBot+Round((YTop-YBot)/2)-6,X2+8,YBot+Round((YTop-YBot)/2)+6);
           brush.Style:=bsClear;
           if i<=9 then X1:=X1-2 else X1:=X1-4;
           TextOut(X1,YBot+Round((YTop-YBot)/2)-6,inttostr(i));
         end;
      end; // Конец For
      Font.Color:=clBlack;
      // Конец Numering
    for i:=1 to ferm.nst1 do
     begin
      if abs(ps[i,nf])>ferm.sd1 then
         begin
          X1:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,1],1]+scale*p[ferm.itopn[i,1],1,nf]));
          Y1:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,1],2]+scale*p[ferm.itopn[i,1],2,nf]));
          X2:=50+coord_axis_x+round(mas_x*(ferm.corn[ferm.itopn[i,2],1]+scale*p[ferm.itopn[i,2],1,nf]));
          Y2:=y_max-coord_axis_y-round(mas_y*(ferm.corn[ferm.itopn[i,2],2]+scale*p[ferm.itopn[i,2],2,nf]));

          if x1>=x2 then begin xtop:=x1;xbot:=x2;end else begin xtop:=x2;xbot:=x1;end;
          if y1>=y2 then begin ytop:=y1;ybot:=y2;end else begin ytop:=y2;ybot:=y1;end;

          Pen.Color:=clYellow;
          Pen.Width:=2;

          if X1<>X2 then
         begin
          if Y1=Y2 then
           begin
            YLine:=Round((XBot+(XTop-XBot)/4-X1)*(Y2-Y1)/(X2-X1))+Y1;
            MoveTo(XBot+Round((xtop-xbot)/4)-6,YLine-6);
            LineTo(XBot+Round((xtop-xbot)/4)+7,YLine+5);
            MoveTo(XBot+Round((xtop-xbot)/4)-6,YLine+6);
            LineTo(XBot+Round((xtop-xbot)/4)+7,YLine-5);
           end
          else
           begin
            YLine:=Round((XBot+(XTop-XBot)/2-X1)*(Y2-Y1)/(X2-X1))+Y1;
            MoveTo(XBot+Round((xtop-xbot)/2)-6,YLine-6);
            LineTo(XBot+Round((xtop-xbot)/2)+7,YLine+5);
            MoveTo(XBot+Round((xtop-xbot)/2)-6,YLine+6);
            LineTo(XBot+Round((xtop-xbot)/2)+7,YLine-5);
           end;
         end
        else
         begin
           MoveTo(X1-6,YBot+Round((YTop-YBot)/4)-6);
           LineTo(X2+7,YBot+Round((YTop-YBot)/4)+5);
           MoveTo(X1-6,YBot+Round((YTop-YBot)/4)+6);
           LineTo(X2+7,YBot+Round((YTop-YBot)/4)-5);
         end;
       end;
     end;
      Pen.Color:=clYellow;
      Pen.Width:=2;
      MoveTo(20-6,12-6);
      LineTo(20+7,12+5);
      MoveTo(20-6,12+6);
      LineTo(20+7,12-5);
      brush.color:=clBtnFace;
      font.name:='times new roman cyr';
      font.Charset := RUSSIAN_CHARSET;
      font.Style:=[];
      textout(30,3,'- превышение допускаемого напряжения в стержне');
  end;

end;

end;



procedure TDeForm_Form.FormShow(Sender: TObject);
var
  ff:System.text;
  fn:string;
  ny,nsn,ms:integer;
  e1,tok,f:extended;
  i,ii,i1,i2:integer;
  li: array[1..15] of extended;
  s_lin, s_for:string;
begin
  if Num_Color>2 then Minus_Sbtn.Enabled:=True;
  if Num_Color<7 then Plus_Sbtn.Enabled:=True;
  fn:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).FileName;
  AssignFile(ff,ChangeFileExt(fn,'.vyv'));
  Reset(ff);
  readln(ff);// Считывание строки для проверки совместимости версий
  readln(ff,nst);
  readln(ff,nyz);
  readln(ff,ny);
  readln(ff,e1);
  readln(ff,nsn);
  readln(ff,sd);
  readln(ff); //readln(ff);
  for i:=1 to nst do
    readln(ff,ms); {Tопология}
  readln(ff); //readln(ff);
  for i:=1 to nyz do
    readln(ff,f,f); {Координаты}
  readln(ff); //readln(ff);
  for i:=1 to nst do
    readln(ff,fn);  {Нач. площади}
  readln(ff); //readln(ff);
  for i:=1 to nyz do
    readln(ff,ms); {Закрепления}
  readln(ff); //readln(ff);

  for i:=1 to nsn do   {Нагрузки}
    begin
      //readln(ff);
      for i1:=1 to nyz*2 do readln(ff,fn);
    end;
  readln(ff,s_lin); readln(ff,s_for);
  readln(ff);
  readln(ff,tok);

  for i:=1 to 3 do readln(ff);
  for i:=1 to nst do readln(ff,li[i]);
  readln(ff);//readln(ff);
  for i:=1 to nsn do
    for ii:=1 to nyz do
      begin
        p[ii,1,i]:=0;
        p[ii,2,i]:=0;
      end;
  for i:=1 to nsn do
    for ii:=1 to nyz do
      begin
        read(ff,p[ii,1,i]);
        readln(ff,p[ii,2,i]);
      end;

  readln(ff);
  //readln(ff);

  for i2:=1 to nsn do
    begin
      for ii:=1 to nst do read(ff,ps[ii,i2]);
      readln(ff);
    end;

  readln(ff);
  readln(ff);

  for ii:=1 to nst do  read(ff,tol[ii]);
  CloseFile(ff);

  if Perem_ChB.Showing then
   begin
    if Perem_ChB.Checked then scale:=1 else scale:=0;
   end
  else
   scale:=1;

  Sn_CBx.Items.Clear;
  if nsn=1 then Sn_CBx.Enabled:=False else Sn_CBx.Enabled:=True;
  for i:=1 to nsn do
    Sn_CBx.Items.Add('Случай нагружения '+IntToStr(i));
  Sn_CBx.ItemIndex:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag-1;
  Scale_Edit.Text:='Масштаб перемещений [1:1]';
  ScrollBar.Position:=1;
  DeForm_Form.N1Click(self);
  end;

procedure TDeForm_Form.ScrollBarChange(Sender: TObject);
begin
scale:=ScrollBar.Position;
Scale_Edit.Text:='Масштаб перемещений ['+IntToStr(scale)+':1]';
DeForm_PaintBox.Repaint;
end;

procedure TDeForm_Form.FormResize(Sender: TObject);
begin
  if Width<432 then Width:=432;
  if Height<244 then Height:=244;
end;

procedure TDeForm_Form.Sn_CbxChange(Sender: TObject);
begin
 {if ToolButton.ImageIndex=1 then
  begin
   Scale_Edit.Text:='Масштаб перемещений [1:1]';
   ScrollBar.Position:=1;
  end;}
 Main_Form.Sn_CBx.ItemIndex:=Sn_Cbx.ItemIndex;
 Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag:=Sn_Cbx.ItemIndex+1;
 ferma_FD_form.showD(Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm);
 Main_Form.ActiveMDIChild.RePaint;
 DeForm_PaintBox.Repaint;
end;

procedure TDeForm_Form.ToolButtonClick(Sender: TObject);
begin
 if ToolButton.ImageIndex=0 then
  begin
   DeForm_Form.Caption:='Деформация ферменной конструкции';
   ToolButton.Hint:='Напряженно-деформированное состояние конструкции';
   Scale:=ScrollBar.Position;
   Scale_Edit.Text:='Масштаб перемещений ['+IntToStr(scale)+':1]';
   ToolButton.ImageIndex:=1;
   DeForm_TB.BringToFront;
   DeForm_TB.Visible:=True;
   Napr_TB.Visible:=False;
   Panel.Visible:=False;
   DeForm_PaintBox.Repaint;
  end
 else
  begin
   DeForm_Form.Caption:='Напряженно-деформированное состояние конструкции';
   ToolButton.Hint:='Деформация ферменной конструкции';
   if Perem_ChB.Checked then scale:=1 else scale:=0;
   ToolButton.ImageIndex:=0;
   DeForm_TB.Visible:=False;
   Napr_TB.Visible:=True;
   Panel.Visible:=True;
   DeForm_PaintBox.Repaint;
  end;
  DeForm_Form.N1Click(self);
  end;

procedure TDeForm_Form.Plus_SbtnClick(Sender: TObject);
begin
Num_Color:=Num_Color+1;
if Num_Color+1=8 then Plus_Sbtn.Enabled:=False;
if Num_Color=3 then Minus_Sbtn.Enabled:=True;
DeForm_PaintBox.Repaint;
Napr_PaintBox.Repaint;
end;

procedure TDeForm_Form.Minus_SbtnClick(Sender: TObject);
begin
Num_Color:=Num_Color-1;
if Num_Color-1=1 then Minus_Sbtn.Enabled:=False;
if Num_Color=6 then Plus_Sbtn.Enabled:=True;
DeForm_PaintBox.Repaint;
Napr_PaintBox.Repaint;
end;

procedure TDeForm_Form.Napr_PaintBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
 min_value,max_value:extended;
 minus_flag, plus_flag:boolean;
 i,nf:integer;
 ferm:TFerm;
 Scale_len,Scale_Step:extended;
 Scale_Hint:string;

begin
Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;
nf:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Tag; // Случай нагружения

      min_Value:=0;
      max_Value:=0;
      for i:=1 to ferm.nst1 do
       begin
        if ps[i,nf]>=0 then
         begin
          if ps[i,nf]>=max_Value then max_Value:=ps[i,nf];
         end
        else
         begin
          if ps[i,nf]<min_Value then min_Value:=ps[i,nf];
         end;
       end;
      minus_Flag:=True;
      plus_Flag:=True;
      if max_value=0 then plus_flag:=False;
      if min_value=0 then minus_flag:=False;

    if (not minus_flag) or (not plus_flag) then
      Scale_Len:=(Napr_PaintBox.Width-6)
     else
      Scale_Len:=(Napr_PaintBox.Width-6)/2;
    Scale_Step:=Scale_Len/Num_Color;

    if minus_Flag then
    begin
     //Сжатие
     for i:=1 to Num_Color do
      begin
       if (x>=3+Round(Scale_Step*(i-1))) and (x<=3+Round(Scale_Step*i))
        then Scale_Hint:=FloatToStr(min_value-(min_value/num_color)*(i-1));
      end;
    end;
//Napr_PaintBox.Hint:=Scale_hint;
//Napr_PaintBox.ShowHint:=True;
//Application.CancelHint;
  {  if plus_flag then
     begin
      //Растяжение
      if not minus_flag then Scale_Len:=3;
      brush.color:=clBtnFace;
      textout(3+Round(Scale_Len)-2,25,'0');
      for i:=1 to Num_Color do
       begin
        Brush.color:=pluscolor[Num_Color+1-i];
        FillRect(Rect(3+Round(Scale_Len+Scale_Step*(i-1)),3,3+Round(Scale_Len+Scale_Step*i),23));
       end;
      brush.color:=clBtnFace;
      _string:=FormatFloat('#.##',max_value);
      width_string:=textwidth(_string);
      textout(3+Round(Scale_Len+Scale_Step*(i-1))-width_string,25,_string);
     end; }
end;

procedure TDeForm_Form.FormCreate(Sender: TObject);
begin
  panel_TB.Height:=30;
  DeForm_TB.Top:=2;
end;

procedure TDeForm_Form.Perem_ChBClick(Sender: TObject);
begin
if Perem_ChB.Checked then scale:=1 else scale:=0;
DeForm_PaintBox.Repaint;
end;

procedure TDeForm_Form.N1Click(Sender: TObject);
var ferm:Tferm;
h,w:integer;
begin
Ferm:=Ferma_M.TFerma_Form(Main_Form.ActiveMDIChild).Ferm;

if  DeForm_Form.Caption <>'Деформация ферменной конструкции' then
begin
w:=432;
     if  Ferm.region_y > Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*0.65);
     if  Ferm.region_y < Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*0.9);
     if  Ferm.region_y = Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*0.75);
end
else
begin
w:=432;
     if  Ferm.region_y > Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*0.77);
     if  Ferm.region_y < Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*1.1);
     if  Ferm.region_y = Ferm.region_x then  h:=round((Ferm.region_y)/(Ferm.region_x)*w*0.88);

end;


     WindowState :=wsNormal;
     ClientWidth :=w;
     ClientHeight:=h;
;

//     Main_Form.StatusBar1.Panels[1].Text :='W= '+IntToStr(w-123)+' H= '+IntToStr(h-75);


end;


procedure TDeForm_Form.FormActivate(Sender: TObject);
begin
DeForm_PaintBox.Repaint;
FermPaint(Sender);
Napr_PaintBox.Repaint;
end;

end.
