unit NewCut;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TNew_Cut_Form = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    OS_Label: TLabel;
    coord: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    OK: TBitBtn;
    cancel: TBitBtn;
    procedure OKClick(Sender: TObject);
    procedure Add_StepCut(MODE: integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  New_Cut_Form: TNew_Cut_Form;

implementation

uses Main, Ferm_dat, Plast_FD,Plast_M;
var
plast:tplast;

{$R *.DFM}

//      ******************************
//процедура добавляет разбиение с заданным шагом
procedure TNew_Cut_Form.Add_StepCut(MODE:integer);
label
1,2;
var
  i_step,i,j,nn,{What_Do,}ii,iii,jj,jjj,stepNumber:integer;
  cz:array[1..plast_max_zak,1..2] of extended;//координаты закреплений
  cf:array[1..plast_max_for,1..2] of extended;//координаты нагрузок
  RealX,RealY,step:extended;
begin
 //MODE=0, значит разбиение по X,иначе Y
 plast:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).plast;
 stepNumber:= strtoint(coord.text);
 realx:=0;
 realy:=0;
 if (MODE=0) then
 begin
  if (stepNumber+plast.kx1)>12 then
  begin
    Main_Form.StatusBar1.Panels[1].Text := 'Слишком большое число разбиений';
    Main_Form.StatusBar1.Panels[2].Text := 'Уменьшите количество разбиений';
    beep;
    repaint;
    exit;
  end;
 end
 else
 begin
  if (stepNumber+plast.ky1)>12 then
  begin
    Main_Form.StatusBar1.Panels[1].Text := 'Слишком большое число разбиений';
    Main_Form.StatusBar1.Panels[2].Text := 'Уменьшите количество разбиений';
    beep;
    repaint;
    exit;
  end;
 end;

 for i_step:=1 to stepNumber do
 begin
   if MODE=0 then
   //разбиение по X
    begin
     step:=(plast.xm1[plast.kx1] / (stepNumber+1));
     realx:=realx+step;
     realy:= -5;
    end
   else
   //разбиение по Y
    begin
     step:=plast.ym1[plast.ky1] / (stepNumber+1);
     realx:= -5;
     realy:=realy+step;
    end;
    // проверка на существование
   for i:=1 to plast.kx1 do
      for j:=1 to plast.ky1 do
       if (round(realX*100)=round(plast.xm1[i]*100))or(round(realY*100)=round(plast.ym1[j]*100))then
        begin
         Main_Form.StatusBar1.Panels[1].Text := 'Невозможно. Разбиение уже существует.';
         Main_Form.StatusBar1.Panels[2].Text := 'Задайте другую координату.';
         beep;
         repaint;//
         Exit;
        end; //конец проверки на существование
     Main_Form.StatusBar1.Panels[1].Text := '';
     Main_Form.StatusBar1.Panels[2].Text := '';
   //Запоминаем координаты
   iii:=1;
   jjj:=1;
   if plast.kx1>=plast.ky1 then  //если нумерация по вертикали
    begin
    for ii:=1 to plast.kz1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.zak1[ii]=nn then
          begin
          cz[iii,1]:=plast.xm1[i];
          cz[iii,2]:=plast.ym1[j];
          iii:=iii+1;
          end;
         end;

    for jj:=1 to plast.kl1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.nomm[jj]=nn then
          begin
          cf[jjj,1]:=plast.xm1[i];
          cf[jjj,2]:=plast.ym1[j];
          jjj:=jjj+1;
          end;
          end;
        end

   else        // если нумерация по горизонтали
     begin
       for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if plast.zak1[ii]=nn then
             begin
              cz[iii,1]:=plast.xm1[j];
              cz[iii,2]:=plast.ym1[i];
              iii:=iii+1;
             end;
           end;

         for jj:=1 to plast.kl1 do
          for i:=1 to plast.ky1 do
           for j:=1 to plast.kx1 do
            begin
             nn:=(i-1)*plast.kx1+j;
              if plast.nomm[jj]=nn then
               begin
                cf[jjj,1]:=plast.xm1[j];
                cf[jjj,2]:=plast.ym1[i];
                jjj:=jjj+1;
               end;
              end;
         end;
//Запомнили координаты


//Формируем новые разбиения
 if (realX>0) and(realX<plast.xm1[plast.kx1])then //Если по X
 begin
  if plast.kx1=12 then begin  //проверка на мах разбиений
    Main_Form.StatusBar1.Panels[1].Text := 'Достигнуто максимальное число разбиений.';
    Main_Form.StatusBar1.Panels[2].Text := 'Дальнейшее разбиение по Х невозможно.';
    beep;
    repaint;//

    if plast.ky1=12 then
    begin
      Main_form.ToolButton1.Down := True;
      Main_form.Cut_Plast_Toolbutton.Enabled:=false;
      cursor:=crarrow;//default;
    end;  //ky=15
    exit;
  end; //kx=15     //конец проверки на мах разбиений
  plast.kx1:=plast.kx1+1;
  plast.xm1[plast.kx1]:=plast.xm1[plast.kx1-1];
  for i:=plast.kx1 downto 3 do
    if (RealX < plast.xm1[i]) and (RealX > plast.xm1[i-2]) then
    begin
      plast.xm1[i-1]:=RealX;
      goto 1;
      end
    else
      plast.xm1[i-1]:=plast.xm1[i-2];
    end;
1:
 if (realY>0) and(realY<plast.ym1[plast.ky1])then //Если по Y
 begin
 if plast.ky1=12 then begin  //проверка на мах разбиений
    Main_Form.StatusBar1.Panels[1].Text := 'Достигнуто максимальное число разбиений.';
    Main_Form.StatusBar1.Panels[2].Text := 'Дальнейшее разбиение по Y невозможно.';
    if plast.kx1=12 then begin
      Main_form.ToolButton1.Down := True;
      Main_form.Cut_Plast_Toolbutton.Enabled:=false;
      cursor:=crdefault;
      end;    //kx=15
    exit;
  end; //ky=15      //конец проверки на мах разбиений
  plast.ky1:=plast.ky1+1;
  plast.ym1[plast.ky1]:=plast.ym1[plast.ky1-1];
   for i:=plast.ky1 downto 3 do
    if (RealY < plast.ym1[i]) and (RealY > plast.ym1[i-2]) then
     begin
     plast.ym1[i-1]:=RealY;
     goto 2;
     end
     else
     plast.ym1[i-1]:=plast.ym1[i-2];
  end;
2:
 //Особенным узлам - новые номера
 iii:=1;
 jjj:=1;
 if plast.kx1>=plast.ky1 then //если нумерация по вертикали
    begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cz[ii,1]*100)=round(plast.xm1[i]*100)) and (round(cz[ii,2]*100)=round(plast.ym1[j]*100)) then
              begin
               plast.zak1[iii]:=nn;
               iii:=iii+1;
              end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cf[jj,1]*100)=round(plast.xm1[i]*100)) and (round(cf[jj,2]*100)=round(plast.ym1[j]*100)) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
           end;
    end
 else                   //если нумерация по горизонтали
      begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
             if (round(cz[ii,1]*100)=round(plast.xm1[j]*100)) and (round(cz[ii,2]*100)=round(plast.ym1[i]*100)) then
               begin
                plast.zak1[iii]:=nn;
                iii:=iii+1;
               end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if (round(cf[jj,1]*100)=round(plast.xm1[j]*100)) and (round(cf[jj,2]*100)=round(plast.ym1[i]*100)) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
            end ;
   end ;
  // razbit:=true; //пластину только что разбили
 //Перерисовываем пластинку в соответствии с новыми данными
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Main_Form.P_Save_TBtn.Enabled:=true;
 Plast_FD_Form.showD(plast);
 //Main_Form.ActiveMDIChild.RePaint;

{end;
end;}
end;
end;


procedure TNew_Cut_Form.OKClick(Sender: TObject);
label
1,2;
var
  i,j,nn,{What_Do,}ii,iii,jj,jjj:integer;
  cz:array[1..plast_max_zak,1..2] of extended;//координаты закреплений
  cf:array[1..plast_max_for,1..2] of extended;//координаты нагрузок
  RealX,RealY:extended;
begin
 plast:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).plast;

  try
   strtofloat(coord.text)
  except
    Main_Form.StatusBar1.Panels[1].Text := 'Ошибка при задании координаты.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите положительное число.';
    beep;
    //repaint;//
    Exit;
  end;
  if strtofloat(coord.text)<0 then
   begin
    Main_Form.StatusBar1.Panels[1].Text := 'Отрицательная координата.';
    Main_Form.StatusBar1.Panels[2].Text := 'Введите положительное число.';
    beep;
    //repaint;//
    Exit;
   end;
   if OS_Label.Caption='Количество узлов по X' then
   begin
     Add_StepCut(0);
     exit;
   end;
   if OS_Label.Caption='Количество узлов по Y' then
   begin
     Add_StepCut(1);
     exit;
   end;

   if OS_Label.Caption='Координата по X' then
   //kara// за такую проверку авторам убить себя обязательно
   //kara// разбиение по X
    begin
     realx:= strtofloat(coord.text);
     realy:= -5;
    end
   else
   //kara// разбиение по Y
    begin
     realy:= strtofloat(coord.text);
     realx:= -5;
    end;
    if (realx>plast.xm1[plast.kx1]) or (realy>plast.ym1[plast.ky1])then
     begin
      Main_Form.StatusBar1.Panels[1].Text := 'Вне пределов области.';
      Main_Form.StatusBar1.Panels[2].Text := 'Введите координату в пределах области.';
      beep;
      //repaint;//
      Exit;
     end;


    // проверка на существование
   for i:=1 to plast.kx1 do
      for j:=1 to plast.ky1 do
       if (round(realX*100)=round(plast.xm1[i]*100))or(round(realY*100)=round(plast.ym1[j]*100))then
        begin
         Main_Form.StatusBar1.Panels[1].Text := 'Невозможно. Разбиение уже существует.';
         Main_Form.StatusBar1.Panels[2].Text := 'Задайте другую координату.';
         beep;
         repaint;//
         Exit;
        end; //конец проверки на существование


     Main_Form.StatusBar1.Panels[1].Text := '';
     Main_Form.StatusBar1.Panels[2].Text := '';
                  //Запоминаем координаты
   iii:=1;
   jjj:=1;
   if plast.kx1>=plast.ky1 then  //если нумерация по вертикали
    begin
    for ii:=1 to plast.kz1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.zak1[ii]=nn then
          begin
          cz[iii,1]:=plast.xm1[i];
          cz[iii,2]:=plast.ym1[j];
          iii:=iii+1;
          end;
         end;

    for jj:=1 to plast.kl1 do
        for i:=1 to plast.kx1 do
         for j:=1 to plast.ky1 do
         begin
         nn:=(i-1)*plast.ky1+j;
         if plast.nomm[jj]=nn then
          begin
          cf[jjj,1]:=plast.xm1[i];
          cf[jjj,2]:=plast.ym1[j];
          jjj:=jjj+1;
          end;
          end;
        end

   else        // если нумерация по горизонтали
     begin
       for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if plast.zak1[ii]=nn then
             begin
              cz[iii,1]:=plast.xm1[j];
              cz[iii,2]:=plast.ym1[i];
              iii:=iii+1;
             end;
           end;

         for jj:=1 to plast.kl1 do
          for i:=1 to plast.ky1 do
           for j:=1 to plast.kx1 do
            begin
             nn:=(i-1)*plast.kx1+j;
              if plast.nomm[jj]=nn then
               begin
                cf[jjj,1]:=plast.xm1[j];
                cf[jjj,2]:=plast.ym1[i];
                jjj:=jjj+1;
               end;
              end;
         end;
//Запомнили координаты


//Формируем новые разбиения
 if (realX>0) and(realX<plast.xm1[plast.kx1])then //Если по X
 begin
  if plast.kx1=12 then begin  //проверка на мах разбиений
    Main_Form.StatusBar1.Panels[1].Text := 'Достигнуто максимальное число разбиений.';
    Main_Form.StatusBar1.Panels[2].Text := 'Дальнейшее разбиение по Х невозможно.';
      if plast.ky1=12 then
   begin
      Main_form.ToolButton1.Down := True;
      Main_form.Cut_Plast_Toolbutton.Enabled:=false;
      cursor:=crarrow;//default;
 {Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(plast);
 Main_Form.ActiveMDIChild.RePaint; }



    end;  //ky=15
    exit;
  end; //kx=15     //конец проверки на мах разбиений
  plast.kx1:=plast.kx1+1;
  plast.xm1[plast.kx1]:=plast.xm1[plast.kx1-1];
   for i:=plast.kx1 downto 3 do
    if (RealX < plast.xm1[i]) and (RealX > plast.xm1[i-2]) then
     begin
     plast.xm1[i-1]:=RealX;
     goto 1;
     end
     else
     plast.xm1[i-1]:=plast.xm1[i-2];
  end;
1:
 if (realY>0) and(realY<plast.ym1[plast.ky1])then //Если по Y
 begin
 if plast.ky1=12 then begin  //проверка на мах разбиений
    Main_Form.StatusBar1.Panels[1].Text := 'Достигнуто максимальное число разбиений.';
    Main_Form.StatusBar1.Panels[2].Text := 'Дальнейшее разбиение по Y невозможно.';
    if plast.kx1=12 then begin
      Main_form.ToolButton1.Down := True;
      Main_form.Cut_Plast_Toolbutton.Enabled:=false;
      cursor:=crdefault;
{ Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Plast_FD_Form.showD(plast);
 Main_Form.ActiveMDIChild.RePaint; }


      end;    //kx=15
    exit;
  end; //ky=15      //конец проверки на мах разбиений
  plast.ky1:=plast.ky1+1;
  plast.ym1[plast.ky1]:=plast.ym1[plast.ky1-1];
   for i:=plast.ky1 downto 3 do
    if (RealY < plast.ym1[i]) and (RealY > plast.ym1[i-2]) then
     begin
     plast.ym1[i-1]:=RealY;
     goto 2;
     end
     else
     plast.ym1[i-1]:=plast.ym1[i-2];
  end;
2:
 //Особенным узлам - новые номера
 iii:=1;
 jjj:=1;
 if plast.kx1>=plast.ky1 then //если нумерация по вертикали
    begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cz[ii,1]*100)=round(plast.xm1[i]*100)) and (round(cz[ii,2]*100)=round(plast.ym1[j]*100)) then
              begin
               plast.zak1[iii]:=nn;
               iii:=iii+1;
              end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.kx1 do
          for j:=1 to plast.ky1 do
           begin
            nn:=(i-1)*plast.ky1+j;
             if (round(cf[jj,1]*100)=round(plast.xm1[i]*100)) and (round(cf[jj,2]*100)=round(plast.ym1[j]*100)) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
           end;
    end
 else                   //если нумерация по горизонтали
      begin
        for ii:=1 to plast.kz1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
             if (round(cz[ii,1]*100)=round(plast.xm1[j]*100)) and (round(cz[ii,2]*100)=round(plast.ym1[i]*100)) then
               begin
                plast.zak1[iii]:=nn;
                iii:=iii+1;
               end;
            end;

       for jj:=1 to plast.kl1 do
         for i:=1 to plast.ky1 do
          for j:=1 to plast.kx1 do
           begin
            nn:=(i-1)*plast.kx1+j;
            if (round(cf[jj,1]*100)=round(plast.xm1[j]*100)) and (round(cf[jj,2]*100)=round(plast.ym1[i]*100)) then
              begin
               plast.nomm[jjj]:=nn;
               jjj:=jjj+1;
              end;
            end ;
   end ;
  // razbit:=true; //пластину только что разбили
 //Перерисовываем пластинку в соответствии с новыми данными
 Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).isChanged:=true;
 Main_Form.P_Save_TBtn.Enabled:=true;
 Plast_FD_Form.showD(plast);
 //Main_Form.ActiveMDIChild.RePaint;

{end;
end;}


end;

procedure TNew_Cut_Form.FormShow(Sender: TObject);
begin
plast:=Plast_M.TPlast_Form(Main_Form.ActiveMDIChild).plast;
 coord.text:='';
 coord.SetFocus;
 if OS_Label.Caption='Координата по X' then
  label3.Caption:= '< '+floattostr(plast.xm1[plast.kx1]);
 if OS_Label.Caption='Координата по Y' then
  label3.Caption:= '< '+floattostr(plast.ym1[plast.ky1]);
 if OS_Label.Caption='Количество узлов по Y' then
  label3.Caption:= '<='+inttostr(12-plast.ky1);
  label2.Caption:= '1<=';
 if OS_Label.Caption='Количество узлов по X' then
  label3.Caption:= '<='+inttostr(12-plast.kx1);
  label2.Caption:= '1<=';

end;

end.
