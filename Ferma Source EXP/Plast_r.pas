unit plast_r;

interface

procedure Plastina(fn:PChar);

implementation

uses

 SysUtils;

procedure Plastina(fn:PChar);

 const rr='.dnp';
label 00,01,02,03,04,11,18,19,22,23,24,33,44,68,69,101,{102,}103,111,122,222,311,322,
      401,402,403,411,422,522,901,902,903,911,912,822,e3,e4,nata1,nata2,
      nata3,e,p,b;
var
  i,j:integer;
  dop,ep: real;
  s_proc : string;
  kit,kl1,kz1,nom,fl:integer;
  os,nom11,nom22,nomm:array[1..10] of integer;
  zak1,zak2,zak3:array[1..10] of integer;
  e1:array[1..2] of real;
  dop1,ton1,ep1:real;
  {xm1,ym1:array[1..50] of real;}
  name,find,name1,name2,name4,name5,maska,name_f,przz:string;
  pr_dot,pr_it, pr_p: integer;
  {Choice: Byte;
  alt: tt;  }
  otv:boolean;
  ff,dopd,f1,f5,f: system.text;
  pyt:shortstring {dirstr};
  imechko:shortstring {namestr};
  razshir :shortstring {extstr};
  vzp_s : longint;
  code : char;
  Nagruz: array [1..3,1..3,1..4] of integer;// ����� ����� �������� ��� ����������� �����.[������ ����,����� ���� � ������ ,���-�� ��������]
  kt: array[1..3] of integer; //���-�� ����������� ����� � ������ ������
  kl: integer; //���-�� ������� ����������


  procedure saprpp2;
label   100,200;
var
h,min,s,ms:Word;
time:real;
sss:string;
kl,km,kn,kb,kx,ky,kz: integer;                            {���譨�}
      kit:                array[1..3] of integer;      {���譨�}
      uq,pq:              array[1..400,1..3] of real;  {���譨�}
      e:                  array[1..2] of real;          {���譨�}
      tm:                 array[1..200] of real;
      xy:                 array[1..250,1..2] of real;
      top:                array[1..200,1..4] of integer;
      ki:integer;                                       {���譨�}
        uk: array[1..400] of real;



procedure sigma4;
const rrr='.vrp';
const rr1='.vop';
 var{ dop,ep: real; }
    w,vvv,f,fff,ffff: system.text;                                {���譨�}
    {  kl,km,kn,kb: integer;                            {���譨�}
    {  kit:                array[1..3] of integer;      {���譨�}
    {  uq,pq:              array[1..400,1..3] of real;  {���譨�}
    {  e:                  array[1..2] of real;          {���譨�}
    {  tm:                 array[1..200] of real;   }
    {  xy:                 array[1..250,1..2] of real; }
    {  top:                array[1..200,1..4] of integer;}
      {ki:integer;                                       {���譨�}
      ns,s1,s2,ss,sem,semm,ve,ves,gf,ges,yyy,ydd,yd,xx: real;
      sis,si,k:           array[1..3,1..3] of real;
      se,yg,yt,xt,n1,n2 : array[1..3] of real;
      c,d,sim :           array[1..3,1..8] of real;
      x,y :               array[1..4] of real;
      b:                  array[1..3,1..6] of real;
      a:                  array[1..6,1..8] of real;
      ue:                 array[1..8,1..3] of real;
      i,j,jj,n,l: integer;
      xn,yn,xyn,sen:      array[1..200,1..3] of real;
      semn:               array[1..200] of real;
      bbb:char;
 label 100,101,102,103,104,105,110,112,212,1003,1,2;

procedure strim; {��砫� strim}
var       i,j,n,l: integer;
          aaa:char;
    label 200;

      begin

        for i:=1 to 3 do
          for j:=1 to 6 do
            b[i,j]:=0;
        for i:=1 to 3 do
          for j:=1 to 8 do
            begin
              c[i,j]:=0;
              d[i,j]:=0;
            end;
        for i:=1 to 3 do
          for j:=1 to 3 do
            si[i,j]:=0;
        s2:=(xt[3]-xt[2])*(yt[2]-yt[1])-(xt[2]-xt[1])*(yt[3]-yt[2]);

          if s2=0 then goto 200;
        s1:=abs(s2)/2;
        b[1,1]:=yt[3]-yt[2];
        b[1,3]:=yt[1]-yt[3];
        b[1,5]:=yt[2]-yt[1];
        b[2,2]:=xt[2]-xt[3];
        b[2,4]:=xt[3]-xt[1];
        b[2,6]:=xt[1]-xt[2];
        b[3,1]:=b[2,2];
        b[3,2]:=b[1,1];
        b[3,3]:=b[2,4];
        b[3,4]:=b[1,3];
        b[3,5]:=b[2,6];
        b[3,6]:=b[1,5];
          for i:=1 to 3 do
            for j:=1 to 6 do
              b[i,j]:=b[i,j]/s2;
          for i:=1 to 3 do
            for j:=1 to 6 do
              for l:=1 to 8 do
                c[i,l]:=b[i,j]*a[j,l]+c[i,l];
          for i:=1 to 3 do
            for j:=1 to 3 do
              for l:=1 to 8 do
                d[i,l]:=k[i,j]*c[j,l]+d[i,l];
        ss:=ss+s1;
          for i:=1 to 3 do
            for j:=1 to 8 do
              sim[i,j]:=sim[i,j]+s1*d[i,j];
200:    end;  {����� strim}

      begin
           if kit[3]=1 then
           name4:=name1+rrr
           else
           name4:=name1+rr1;
      assignfile(vvv,name4);
      append(vvv);{rewrite(vvv);}

      { t:='!';}
      {  fik:='';}
      {��������� ����������}
      ns:=0;
      s1:=0;
      s2:=0;
      {ss:=0;}
      sem:=0;
      semm:=0;
      ve:=0;
      ves:=0;
      gf:=0;
      ges:=0;
      yyy:=0;
      ydd:=0;
      yd:=0;
      xx:=0;
        for i:=1 to 3 do
          for j:=1 to 3 do
            begin
              sis[i,j]:=0;
              {si[i,j]:=0;}
              k[i,j]:=0;
            end;
      {����� ���������}

        s1:=e[1]/(1-e[2]*e[2]);
        k[1,1]:=1;
        k[1,2]:=e[2];
        k[2,1]:=e[2];
        k[2,2]:=1;
        k[3,3]:=(1-e[2])/2;
          for i:=1 to 3 do
            for j:=1 to 3 do
              k[i,j]:=s1*k[i,j];
        ns:=1;
         if kit[3]=1 then //���� ������� ������
         begin
         assignfile(f,name1+'.ww1');rewrite(f);
         assignfile(ff,name1+'.ww2');rewrite(ff);
         assignfile(fff,name1+'.ww3');rewrite(fff);
         end
         else if ki=kit[3] then
         begin
         assignfile(f,name1+'.w1');rewrite(f);
         assignfile(ff,name1+'.w2');rewrite(ff);
         assignfile(fff,name1+'.w3');rewrite(fff);
         end;
          for n:=1 to kn do       {������ ����� 1}
            begin
              j:=kit[1];
                for i:=1 to 50 do       {������ ����� 2}
                  if ki<>j then j:=j+kit[2] {������ ��� �������}
                  else goto 100;        {����� ����� 2}
              goto 101;
    100:        if n=1 then goto 101; {�� ����� ���� ���������� 101 �� 102}
              s2:=n;
              ve:=kl;
              s1:=1+(s2*(ve+2))/(49+ve);
              yyy:=int(s1);
              ydd:=frac(s1);
              yd:=abs(ydd);
                if yyy>0 then
                   begin
                     if yd<=0.5 then xx:=yyy
                     else xx:=yyy+1;
                   end;
              xx:=yyy;

                if xx<>s1 then goto 101;   {���������� CEIL}
              ns:=s1;
 {   102:      goto 73;}
    101:        for i:=1 to 4 do        {������ ����� 3}
                  begin
                    j:=top[n,i];
                    x[i]:=xy[j,1];
                    y[i]:=xy[j,2];
                  end;                  {����� ����� 3}
               for i:=1 to 6 do
                 for jj:=1 to 8 do
                   a[i,jj]:=0;
               for i:=1 to 8 do
                 for jj:=1 to 3 do
                   ue[i,jj]:=0;
               for i:=1 to 3 do
                 for jj:=1 to 8 do
                   sim[i,jj]:=0;
               for i:=1 to 3 do
                 for j:=1 to 3 do
                   sis[i,j]:=0;
               sem:=0;
               ss:=0;


                for i:=1 to 4 do        {������ ����� 4}
                  begin
                    j:=top[n,i];
                      for l:=1 to kl do {������ ����� 5}
                        begin
                          ue[2*i-1,l]:=uq[2*j-1,l];
                          ue[2*i,l]:=uq[2*j,l];
                        end;            {����� ����� 5}
                  end;                  {����� ����� 4}
              xt[3]:=(x[1]+x[2]+x[3]+x[4])/4;
              yt[3]:=(y[1]+y[2]+y[3]+y[4])/4;
              xt[1]:=x[1];
              yt[1]:=y[1];
              xt[2]:=x[2];
              yt[2]:=y[2];
    103:      a[1,1]:=1;
              a[2,2]:=1;
              a[3,3]:=1;
              a[4,4]:=1;
                for i:=1 to 4{7} do        {������ ����� 6}
                  begin
                    a[5,2*(i-1)+1]:=0.25;
                    if i>=4{7} then goto 1;
                 {   i:=i+1;  }
                  end;                  {����� ����� 6}
1:              for j:=2 to 5{8} do         {��砫� 横�� 7}
                  begin
                    a[6,2*(j-1)]:=0.25;
                    if j>=5{8} then goto 2;
                   { j:=j+1; }
                  end;                   {����� 横�� 7}
2:  {***************************************************************}
  {************************��楤�� STRIM************************}
  {***************************************************************}
    104:        for i:=1 to 4 do          {��砫� 横�� 8}
                  for j:=1 to 8 do        {��砫� 横�� 9}
                    a[i,j]:=0;
                                          {����� 横��� 8 � 9}
              a[1,3]:=1;
              a[2,4]:=1;
              a[3,5]:=1;
              a[4,6]:=1;
              xt[1]:=x[2];
              xt[2]:=x[3];
              yt[1]:=y[2];
              yt[2]:=y[3];
              strim;{******�맮� ��楤��� STRIM********}
    1003:       for i:=1 to 4 do
                  for j:=1 to 8 do
                    a[i,j]:=0;
              a[1,5]:=1;
              a[2,6]:=1;
              a[3,7]:=1;
              a[4,8]:=1;
              xt[1]:=x[3];
              xt[2]:=x[4];
              yt[1]:=y[3];
              yt[2]:=y[4];
              strim;{*********�맮� ��楤��� STRIM***********}
    105:        for i:=1 to 4 do
                  for j:=1 to 8 do
                    a[i,j]:=0;
              a[1,7]:=1;
              a[2,8]:=1;
              a[3,1]:=1;
              a[4,2]:=1;
              xt[1]:=x[4];
              xt[2]:=x[1];
              yt[1]:=y[4];
              yt[2]:=y[1];
              strim;{********�맮� ��楤��� STRIM***************}

                for i:=1 to 3 do
                  for j:=1 to 8 do
                    sim[i,j]:=sim[i,j]/ss;


                for i:=1 to 3 do
                  for j:=1 to 8 do
                    for l:=1 to 3 do
                      sis[i,l]:=sim[i,j]*ue[j,l]+sis[i,l];


                if tm[n]<=0 then
                  for i:=1 to 3 do
                    for j:=1 to 3 do
                      sis[i,j]:=0;
                  for l:=1 to kl do       {��砫� 横�� 10}
                  begin
                    s1:=sqr(sis[1,l])+sqr(sis[2,l])-sis[1,l]*sis[2,l]+3*(sqr(sis[3,l]));
                    if ((kit[3]=1)or(ki=kit[3])) and (l=1) then  writeln(f,sis[1,l]:17:5,sis[2,l]:17:5,sis[3,l]:17:5);
                    if ((kit[3]=1)or(ki=kit[3])) and (l=2) then  writeln(ff,sis[1,l]:17:5,sis[2,l]:17:5,sis[3,l]:17:5);
                    if ((kit[3]=1)or(ki=kit[3])) and (l=3) then  writeln(fff,sis[1,l]:17:5,sis[2,l]:17:5,sis[3,l]:17:5);
                    {  s1:=sis[1,l]**2+sis[2,l]**2-sis[1,l]*sis[2,l]+3*sis[3,l]**2;}
                    se[l]:=sqrt(s1);
                    s1:=sis[1,l]-sis[2,l];
                    s2:=sqr(s1);
                    s1:=s2+4*(sqr(sis[3,l]));
                    s2:=0.5*sqrt(s1);
                    s1:=0.5*(sis[1,l]+sis[2,l]);
                    n1[l]:=s1+s2;
                    n2[l]:=s1-s2;

                      if n1[l]<n2[l] then
                        begin
                          s1:=n1[l];
                          n1[l]:=n2[l];
                          n2[l]:=s1;
                        end;
                    s1:=n1[l]-sis[1,l];
                      if abs(s1)<0.05 then
                        begin
                          yg[l]:=0;
                          goto 110;
                        end;
                      if abs(sis[3,l])<0.05 then
                        begin
                          yg[l]:=90;
                          goto 110;
                        end;
                    s2:=s1/4000;
                      if abs(s2-sis[3,l])<0.05 then
                        begin
                          yg[l]:=90;
                          goto 110;
                        end;
                    s2:=s1/sis[3,l];
                    yg[l]:=arctan(s2);
    110:              if se[l]>sem then
                        begin
                          sem:=se[l];
                       {   chlm:=chl[l];}
                        end;
                    n1[l]:=tm[n]*n1[l];
                    n2[l]:=tm[n]*n2[l];
                  end;                          {����� 横�� 10}
                if sem>semm then semm:=sem;
              {write(vvv,'ss=',ss);writeln(vvv);}
              gf:=sem*ss*tm[n];
              ges:=ges+gf;
              ve:=tm[n]*ss;
              ves:=ves+ve;
                for l:=1 to kl do
                  begin
                    xn[n,l]:=sis[1,l];
                    yn[n,l]:=sis[2,l];
                    xyn[n,l]:=sis[3,l];
                    sen[n,l]:=se[l];
                  end;
              semn[n]:=sem;
              j:=kit[1];
                for i:=1 to 50 do
                  if ki<>j then j:=j+kit[2]
                  else goto 112;
              goto 212;
   { 999:      goto31;}
     112:
            {assignfile(w,'w.txt');  }
            if kit[3] > 1 then
            begin
            assignfile(w,name1+'.w'); //���� �����������
             if ki = kit[3] then
              begin
               assignfile(ffff,name1+'.w0');
               append(ffff);
              end; 
            end
            else
            begin
            assignfile(ffff,name1+'.ww0');
            append(ffff);
            assignfile(w,name1+'.ww'); //���� ������� ������
            end;
            append(w);
            writeln(vvv,' ');
            //!!!!!!!!!!!!!!!!!!!!
            writeln(vvv,'tm[',n,']=');
            writeln(vvv,tm[n]);writeln(vvv,'  - �������');
            if ki=kit[3] then
               if ki<>1 then
                  writeln(w,tm[n])
               else writeln(w,sem);
            closefile(w);
            //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    if ((kit[3]=1)or(ki=kit[3])) and (kl=1) then  writeln(ffff,se[1]:17:5);
                    if ((kit[3]=1)or(ki=kit[3])) and (kl=2) then  writeln(ffff,se[1]:17:5,se[2]:17:5);
                    if ((kit[3]=1)or(ki=kit[3])) and (kl=3) then  writeln(ffff,se[1]:17:5,se[2]:17:5,se[3]:17:5);
                    if ((kit[3]=1)or(ki=kit[3])) then closefile(ffff);
                 //!!!!!!!!!!!!!!!!!!!!!!!!
            writeln(vvv,sem);writeln(vvv,'  - ����. ���. ������.');
            writeln(vvv,ve);writeln(vvv,'  - �����');
            writeln(vvv,gf);writeln(vvv,'  - ���. ���');
      212:  tm[n]:=tm[n]*sem/dop;
          end;                        {����� 横�� 1}
        s1:=ves*semm/dop;
        s2:=(s1-ves)*100/s1;

        writeln(vvv);
        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
        writeln(vvv,'����� ��������:');
        writeln(vvv,ki);
        writeln(vvv,'������������ ���. ����������: ');
        writeln(vvv,semm);
        writeln(vvv,'��������� �� ��������� �����: ');
        writeln(vvv,s1);
        writeln(vvv,'����� ����. ���. �����������:');
        writeln(vvv,ves);
        writeln(vvv,'C��. ��� ����. ���. ������.:');
        writeln(vvv,ges);
        writeln(vvv,'����������� ����������� (%): ');
        writeln(vvv,s2);
        writeln(vvv);
        closefile(vvv);
        // if kit[3]=1 then   //���� ������� ������!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        if kit[3]=ki then   //���� ����� ������ (��������� ��������)
         begin
            closefile(fff);
            closefile(ff);
            closefile(f);
         end;


end;{sigma4}




procedure mage3;
const rrr='.vrp';
const rr1='.vop';
  var
      i,g,n,j,p,l,r,s,q,iii,ii: integer;
    { kn,kb,km,kl: integer;                      {���譨�}
    { ep: real;                         {���譨�}
      gc: array[1..8190] of real;
      k: array[1..3,1..3] of real;
    { tm: array[1..200] of single;         {���譨�}
    { top: array[1..200,1..4] of integer;  {���譨�}
    { xy: array[1..250,1..2] of real;   {���譨�}
    { e: array[1..2] of real;           {���譨�}
    { uq,pq: array[1..400,1..3] of real;  ���譨�  400,3}
    { uk: array[1..400] of real;  {���譨�}
      x,y: array[1..4] of real;
      xt,yt: array[1..3] of real;
      a: array[1..6,1..8] of real;
      ks: array[1..8,1..8] of real;
      kp: array[1..8] of integer;
      tol,s1,s2,w,y1,y2: real;
      ks1: array[1..8,1..8] of real;
      ccc: char;
      vvv:system.text;
  label
      1,2,10,11,12;
procedure ktrim;    {��砫� KTRIM}
var   b: array[1..3,1..6] of real;
      kt: array[1..8,1..8] of real;
      c,d: array[1..3,1..8] of real;
      ct: array[1..8,1..3] of real;
      i,j,l:integer;

label 200;
        begin
          for i:=1 to 3 do
            for j:=1 to 6 do
              b[i,j]:=0;
          for i:=1 to 3 do
            for j:=1 to 8 do
              begin
                c[i,j]:=0;
                d[i,j]:=0;
              end;
          for i:=1 to 8 do
            for j:=1 to 8 do
              kt[i,j]:=0;
          for i:=1 to 8 do
            for j:=1 to 3 do
              ct[i,j]:=0;
          s2:=(xt[3]-xt[2])*(yt[2]-yt[1])-(xt[2]-xt[1])*(yt[3]-yt[2]);
          if s2=0 then goto 200;
          s1:=abs(s2)/2;
          b[1,1]:=yt[3]-yt[2];
          b[1,3]:=yt[1]-yt[3];
          b[1,5]:=yt[2]-yt[1];
          b[2,2]:=xt[2]-xt[3];
          b[2,4]:=xt[3]-xt[1];
          b[2,6]:=xt[1]-xt[2];
          b[3,1]:=b[2,2];
          b[3,2]:=b[1,1];
          b[3,3]:=b[2,4];
          b[3,4]:=b[1,3];
          b[3,5]:=b[2,6];
          b[3,6]:=b[1,5];
            for i:=1 to 3 do
              for j:=1 to 6 do
                b[i,j]:=b[i,j]/s2;
            for i:=1 to 3 do
              for j:=1 to 6 do
                for l:=1 to 8 do
                  c[i,l]:=b[i,j]*a[j,l]+c[i,l];
            for i:=1 to 3 do
              for l:=1 to 8 do
                ct[l,i]:=c[i,l];
            for i:=1 to 3 do
              for j:=1 to 3 do
                for l:=1 to 8 do
                  d[i,l]:=k[i,j]*c[j,l]+d[i,l];
            for i:=1 to 8 do
              for j:=1 to 3 do
                for l:=1 to 8 do
                kt[i,l]:=ct[i,j]*d[j,l]+kt[i,l];
    200:    for i:=1 to 8 do
              for j:=1 to 8 do
                ks[i,j]:=s1*kt[i,j]+ks[i,j];
{*************************************************************}
          end;  {����� KTRIM}
{*************************************************************}
      begin
        if kit[3]=1 then
           name4:=name1+rrr
           else
           name4:=name1+rr1;
        assignfile(vvv,name4);
        append(vvv);{rewrite(vvv);  }

        for i:=1 to 8190 do
          gc[i]:=0;
        for i:=1 to 3 do
          for j:=1 to 3 do
            k[i,j]:=0;
        tol:=e[1]/(1-e[2]*e[2]);
        K[1,1]:=1;
        K[1,2]:=e[2];
        K[2,1]:=e[2];
        K[2,2]:=1;
        K[3,3]:=(1-e[2])/2;
        for i:=1 to 3 do
          for j:=1 to 3 do
            k[i,j]:=tol*k[i,j];
        {������ ����� �� ����� ���������}
          for n:=1 to kn do
              begin
                if tm[n]<=ep then tm[n]:=ep;
                for i:=1 to 4 do
                  begin
                    j:=top[n,i];
                    x[i]:=xy[j,1];
                    y[i]:=xy[j,2];
                  end;
                xt[3]:=(x[1]+x[2]+x[3]+x[4])/4;
                yt[3]:=(y[1]+y[2]+y[3]+y[4])/4;
                xt[1]:=x[1];
                yt[1]:=y[1];
                xt[2]:=x[2];
                yt[2]:=y[2];
                for i:=1 to 6 do
                  for ii:=1 to 8 do
                    a[i,ii]:=0;
                for i:=1 to 8 do
                  for ii:=1 to 8 do
                    ks[i,ii]:=0;
                a[1,1]:=1;
                a[2,2]:=1;
                a[3,3]:=1;
                a[4,4]:=1;
                for i:=1 to 4{7} do
                  begin
                    a[5,2*(i-1)+1]:=0.25;
                    {i:=i+1;}
                    if i>=4{7} then goto 1;
                  end;
1:              for i:=2 to 5{8} do
                  begin
                    a[6,2*(i-1)]:=0.25;
                   { i:=i+1;    }
                    if i>=5{8} then goto 2;
                  end;
2:              ktrim;
                for i:=1 to 4 do
                  for j:=1 to 8 do
                    a[i,j]:=0;
                a[1,3]:=1;
                a[2,4]:=1;
                a[3,5]:=1;
                a[4,6]:=1;
                xt[1]:=x[2];
                xt[2]:=x[3];
                yt[1]:=y[2];
                yt[2]:=y[3];
                ktrim;
                for i:=1 to 4 do
                  for j:=1 to 8 do
                    a[i,j]:=0;
                a[1,5]:=1;
                a[2,6]:=1;
                a[3,7]:=1;
                a[4,8]:=1;
                xt[1]:=x[3];
                xt[2]:=x[4];
                yt[1]:=y[3];
                yt[2]:=y[4];
                ktrim;
                for i:=1 to 4 do
                  for j:=1 to 8 do
                    a[i,j]:=0;
                a[1,7]:=1;
                a[2,8]:=1;
                a[3,1]:=1;
                a[4,2]:=1;
                xt[1]:=x[4];
                xt[2]:=x[1];
                yt[1]:=y[4];
                yt[2]:=y[1];
                ktrim;
                for i:=1 to 8 do
                  for ii:=1 to 8 do
                    ks1[i,ii]:=ks[i,ii];

                for i:=1 to 8 do
                  for ii:=1 to 8 do
                    ks[i,ii]:=tm[n]*ks1[i,ii];
                for i:=1 to 4 do
                  begin
                    kp[2*i-1]:=top[n,i]*2-1;
                    kp[2*i]:=top[n,i]*2;
                  end;
                for i:=1 to 8 do
                  for j:=1 to i do
                    begin
                      if kp[i]>=kp[j] then
                         l:=kp[i]*(kb-1)+kp[j]
                         else
                         l:=kp[j]*(kb-1)+kp[i];
                      gc[l]:=gc[l]+ks[i,j];
                    end;
          end;      {����� ����� �� ����� ���������}
          {����������}
          j:=2*km;
          s1:=gc[kb];
          for n:=2 to j do
            begin
              l:=kb*n;
              if s1<gc[l] then s1:=gc[l];
            end;
          s1:=1000*s1;
          for n:=1 to j do
            begin
              l:=kb*n;
              if gc[l]=0 then gc[l]:=s1;
              if uk[n]=0 then gc[l]:=s1;
            end;
          {������� �������}
          {����������� ����������}
          l:=2*km;
          for i:=1 to l do
            begin
              if i>kb then p:=1
                 else
                 p:=kb-i+1;
              r:=i-kb+p;
                for j:=p to kb do
                  begin
                    s:=j-1;
                    q:=kb-j+p;
                    w:=gc[kb*(i-1)+j];
                      for n:=p to s do
                        begin
                          y1:=gc[kb*(i-1)+n];
                          y2:=gc[kb*(r-1)+q];
                          w:=w-y1*y2;
                          q:=q+1;
                        end;
                    if j=kb then
                       if w<=0 then goto 10
                          else gc[kb*i]:=1/sqrt(w)
                       else gc[kb*(i-1)+j]:=w*gc[kb*r];
                    r:=r+1;
                  end;
            end;
          {��������� �����������}
          s:=kb-1;
            for j:=1 to kl do
              begin
              {������ ���}
                for i:=1 to l do
                  begin
                    if i>kb then p:=1
                       else p:=kb-i+1;
                    q:=i;
                    w:=pq[i,j];
                      for n:=s downto p do
                        begin
                          q:=q-1;
                          y1:=gc[kb*(i-1)+n];
                          y2:=y1*uq[q,j];
                          w:=w-y2;
                        end;
                    uq[i,j]:=w*gc[kb*i];
                  end;
              {�������� ���}
                for i:=l downto 1 do
                  begin
                    if (l-i+1)>kb then p:=1
                       else p:=kb-l+i;
                    w:=uq[i,j];
                    q:=i;
                      for n:=s downto p do
                        begin
                          q:=q+1;
                          y1:=gc[kb*(q-1)+n];
                          y2:=y1*uq[q,j];
                          w:=w-y2;
                        end;
                    uq[i,j]:=w*gc[kb*i];
                  end;
            end;
            {������ �����������}
            j:=kit[1];
            for i:=1 to 50 do
              if ki<>j then j:=j+kit[2]
                 else goto 11;
            goto 12;

11:         for l:=1 to kl do
            begin
              writeln(vvv,'�����������, ������ ���������� ',l);
              //!!!!!!!!!!!!!!!!!!!!!!!!!!!
                for j:=1 to km do
                begin
                  writeln(vvv,j,'u');
                  writeln(vvv,uq[2*j-1,l]);
                  writeln(vvv,j,'v');
                  writeln(vvv,uq[2*j,l]);
                end;
            end;
10:    writeln(vvv,'��������� ������');
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       writeln(vvv,'������������ ���-�: ');
       writeln(vvv,gc[kb*i]);
       closefile(vvv);
       {readln(ccc);}
12: end; {mage3}






procedure pr2;

const rr1='.vrp';
const rr2='.vop';
   var  ton:real;
       k:integer;
       { kl,kz,kx,ky,km,kn,kb:integer;}
       { f,sss,www:text;}
        w,f,www,fff,sss,ffff {,fg}:system.text;
        {kz:integer; }
       {k,kit: array[1..3] of integer;}
       { top: array[1..200,1..4] of integer;}
      {  xy: array[1..250,1..2] of real;}
         kk: array[1..3] of integer;
      {  uq,pq: array[1..400,1..3] of real;}
      {  tm: array[1..200] of real;  }
        chl: array[1..3] of integer;
   {  external;}
        xuxu:char;
   var
        kmin,kmax,s,i,j,n,l,m,for0,for1,for2,mg: integer;
        ym,xm: array[1..50] of real;
        kitstr,epstr:string;
        zacr: array[1..5,1..3] of integer;
        narg: array[1..5,1..4] of integer;
        temp: file of byte;

    begin
    for i:=1 to 2 do
      e[i]:=0;
    dop:=0;
    ton:=0;
    ep:=0;
    kz:=0;
    kl:=0;
    kx:=0;
    ky:=0;
    kn:=0;
    km:=0;
    kmin:=0;
    kmax:=0;
    kb:=0;
    s:=0;
    for0:=0;
    for1:=0;
    for2:=0;
      for i:=1 to 250 do
        for j:=1 to 2 do
          xy[i,j]:=0;
      for i:=1 to 3 do
        begin
          kk[i]:=0;
          kit[i]:=0;
        end;
      for i:=1 to 50 do
        begin
          xm[i]:=0;
          ym[i]:=0;
        end;
      for i:=1 to 200 do
        for j:=1 to 4 do
          begin
            top[i,j]:=0;
            tm[i]:=0;
          end;
      for i:=1 to 2 do
        for j:=1 to 3 do
          zacr[i,j]:=0;
      for i:=1 to 3 do
        for j:=1 to 4 do
          narg[i,j]:=0;

    assignfile(fff,'dopdan.dan');
    reset(fff);
    readln(fff,kit[3]); {���-�� ���権}
    readln(fff,ep); {�����⨬�� ⮫騭�}
    closefile(fff);
      if kit[3]>1 then
      begin
      assignfile(w,name1+'.w');  //�����������
      assignfile(ffff,name1+'.w0');
      rewrite(ffff);
      end
         else
         begin
         assignfile(w,name1+'.ww'); //������� ������
         assignfile(ffff,name1+'.ww0');rewrite(ffff);
         end;
      rewrite(w);

          assignfile(temp,name2);
          reset(temp);
          //!!!!!!!!!!!!!!!!!!!!!!!!!!!
                  mg:=filesize(temp);
           closefile(temp);

           assignfile(f,name2);
           reset(f);

        {   readln(f);
          readln(f);}
          readln(f,e[1]);   {����� ��㣮��}
          readln(f,e[2]);   {�����樥�� ���ᮭ�}
          readln(f,dop);{�������⥫쭮� ����殮���}
          readln(f,ton); {��砫쭠� ⮫騭�}

          readln(f,kz); {��᫮ ��砥� ���९�����}
//          readln(f,kl); {��᫮ ��砥� ����㦥���}
  readln(f,kl);   // ����� ������� ����������
  for i:=1 to kl do
  begin
  readln(f,kt[i]);  // ���-�� ����� � 1-�� ������,���-�� ����� �� 2-�� ������,���-�� ����� � 3-�� ������
  end;

          readln(f,kx); {��᫮ 㧫�� �� �}
          writeln(w,kx-1);
          readln(f,ky); {��᫮ 㧫�� �� y}
          writeln(w,ky-1);
          closefile(w);
          //if kit[3]=1 then
           begin
             writeln(ffff,kx-1);
             writeln(ffff,ky-1);
             closefile(ffff);
           end;
        kit[1]:=1;
        kit[2]:=1;
          kk[1]:=kit[1];
          kk[2]:=kit[2];
          kk[3]:=kit[3];
          for i:=1 to 200 do
          tm[i]:=ton;
           if kit[3]=1 then
            name5:=name1+rr1
            else
            name5:=name1+rr2;
          assignfile(www,name5);
          rewrite(www);
          //!!!!!!!!!!!!!!!!!!!!
        WRITELN(www,ExtractFileName(name2),' ',mg,' ',DateTimeToStr(FileDateToDateTime(FileAge(name2))));
          //!!!!!!!!!!!!!!!!!!!!
          writeln(www,kit[3]);
          writeln(www,kx);
          writeln(www,ky);
          writeln(www,kz);//?��� ��� kit[3]?? ������ KZ !!!!!!!!!!!!!!!
          writeln(www,kl);
          for i:=1 to kx do
    begin
          readln(f,xm[i]);    {���न���� 㧫�� �� �}
          writeln(www,xm[i]);
       {   write(www,' ');}
       {   writeln;         }
    end;
          for i:=1 to ky do
    begin
          readln(f,ym[i]);    {���न���� 㧫�� �� y}
          writeln(www,ym[i]);
    end;
          kn:=(ky-1)*(kx-1);
          km:=kx*ky;

          if ky<=kx then
    begin
          kmin:=ky-1;
          kmax:=kx-1;
    end
          else
    begin
          kmin:=kx-1;
          kmax:=ky-1;
    end;
          kb:=2*(kmin+3);
          for n:=1 to kmax do
          for l:=1 to kmin do
    begin
          i:=l+kmin*(n-1);
          top[i,1]:=i+n-1;
          top[i,2]:=i+n;
          top[i,3]:=top[i,2]+kmin+1;
          top[i,4]:=top[i,1]+kmin+1;
    end;
          j:=kmax+1;
          m:=kmin+1;
          for n:=1 to j do
          for l:=1 to m do
    begin
          i:=l+m*(n-1);
          if ky<=kx then
    begin
          xy[i,1]:=xm[n];{write('  pr1,xy  ',xy[i,1]);}
          xy[i,2]:=ym[l];
    end
              else
    begin
          xy[i,1]:=xm[l];
          xy[i,2]:=ym[n];
    end;
    end;
    {*******************ZACR**********************************}
          for i:=1 to 400 do
          for j:=1 to 3 do
    begin
          uk[i]:=9999;
          pq[i,j]:=0;
          uq[i,j]:=0.0;
          {writeln('uq=  ',uq[i,j]);}
    end;
          for i:=1 to kz do
          for j:=1 to 3 do
    begin
          read(f,zacr[i,j]);
          if j=2 then
    begin
          if zacr[i,2]=1 then
          uk[zacr[i,1]*2-1]:=0;
          {writeln(uk[zacr[i,1]*2-1]);}
    end;
          if j=3 then
    begin
          if zacr[i,3]=1 then
          uk[zacr[i,1]*2]:=0;
          {writeln(uk[zacr[i,1]*2]);}
    end;
    end;
   {****************NARG**************************************}
  for j:=1 to kl do
  for i:=1 to kt[j] do
  for k:=1 to 4 do
    begin
    read(f,nagruz[j,i,k]);
    end;
 readln(f);
for j:=1 to kl do
for i:=1 to kt[j] do
begin
chl[i]:=i;
begin
if(nagruz[j,i,2] = 33) then
begin
              pq[nagruz[j,i,1]*2-1,i]:=1000;
              pq[nagruz[j,i,1]*2,i]:=1000;
//              pq[nagruz[j,i,1]*2-1,i]:=nagruz[j,i,3];
//              pq[nagruz[j,i,1]*2,i]:=nagruz[j,i,4];
end;
if(nagruz[j,i,2] = 22) then
begin

//              pq[nagruz[j,i,1]*2,i]:=nagruz[j,i,4];

end;
if(nagruz[j,i,2] = 11) then
begin

//              pq[nagruz[j,i,1]*2-1,i]:=nagruz[j,i,3];

end;


end;
end;
  {    for i:=1 to kl  do
          begin
          s:=0;
          chl[i]:=i;
          for j:=1 to 4 do
              begin
              read(f,narg[i,j]);
              s:=s+1;
              if s=3 then
                 begin
                 if narg[i,2]=33 then
                 for1:=narg[i,3];
                 end;
              if s=4 then
                 begin
                 if narg[i,2]=33 then
                 for2:=narg[i,4]
                 else
                     begin
                     if narg[i,3]=0 then
                     for0:=narg[i,4]
                     else
                     for0:=narg[i,3];
                     end;
                 if narg[i,2]=11 then
                     begin;
//                 writeln(for0);
                     pq[narg[i,1]*2-1,i]:=for0;
                     end;
                 if narg[i,2]=22 then
                    begin
//                    writeln(for0);
                    pq[narg[i,1]*2,i]:=for0;
                    end;
                 if narg[i,2]=33 then
                    begin
                    pq[narg[i,1]*2-1,i]:=for1;
                    pq[narg[i,1]*2,i]:=for2;
                    end;
                 for0:=0;
                 for1:=0;
                 for2:=0;
                 end;
              end;
          end;  }

    closefile(www);
    closefile(f);
    end;{pr1}


            begin  {saprpp2}

            ki:=0;
            pr2;
100:        ki:=ki+1;

    200:    mage3;
            sigma4;
            if ki<kit[3] then
                goto 100;


end; {saprpp2}


begin {main}
     pr_p:=11;
        maska:='*.dnp';
        name_f:= fn;
        name2:=name_f;
         imechko:=name_f;
         delete(imechko,length(imechko)-3,4);
        name1:=imechko;
     przz:='prr';
     saprpp2;
     pr_it:=0;pr_dot:=0;

 e3:  end;




end.
