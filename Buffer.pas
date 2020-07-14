unit Buffer;

interface
 uses Ferm_DAt;
//PFerm=^Tferm;
type

PELFerm = ^ElFerm;
ElFerm=record
Next:PElferm;
Prev:PElferm;
F:TFerm;
P:TPlast;
T:Ttok;

end;


Tbuffer=Class(TObject)
public
FIrstE:PELFerm; //Первый
LAstE:PELFerm;// Последний
Current:PELFerm; //Текущий
constructor Create(F:Tferm);
procedure Add(F:Tferm);
constructor CreateP(F:TPlast);
procedure AddP(F:TPlast);
constructor CreateT(T:TTok);
procedure AddT(T:Ttok);
procedure Delete();
procedure next();
procedure prev();
procedure first();
procedure Last();
Destructor Destroy();
end;

implementation



COnstructor Tbuffer.Create(F:TFerm);  // инициализация
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.F:=Tferm.Create;
//Раздел копирования эллементов
 FB^.F.Assign(F);
 FB^.P:=nil;
 FB^.T:=nil;
 // Конец раздела копирования
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.Add(F:TFerm);// Нынче вставленный элемент (Непосредственно вставка)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.F:=Tferm.Create;
//Раздел копирования эллементов
BF^.F.Assign(F);
BF^.P:=nil;
BF^.T:=nil;
 // Конец раздела копирования
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;

COnstructor Tbuffer.CreateP(F:TPlast);  // инициализация
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.P:=TPlast.Create;
//Раздел копирования эллементов
 FB^.P.Assign(F);
 FB^.F:=nil;
 FB^.T:=nil;
 // Конец раздела копирования
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.AddP(F:TPlast);// Нынче вставленный элемент (Непосредственно вставка)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.P:=TPlast.Create;
//Раздел копирования эллементов
BF^.P.Assign(F);
BF^.F:=nil;
BF^.T:=nil;
 // Конец разЂдела копирования
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;

COnstructor Tbuffer.CreateT(T:TTok);  // инициализация
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.T:=TTok.Create;
//Раздел копирования эллементов
 FB^.T.Assign(T);
 FB^.F:=nil;
 FB^.P:=nil;
 // Конец раздела копирования
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.AddT(T:TTok);// Нынче вставленный элемент (Непосредственно вставка)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.T:=TTok.Create;
//Раздел копирования эллементов
 BF^.T.Assign(T);
 BF^.F:=nil;
 BF^.P:=nil;
 // Конец разЂдела копирования
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;


Procedure Tbuffer.Delete(); //Удаляем все после нынче вставленного
 var BF:PELFerm;
begin
BF:=Current^.Next;
Current^.Next:=nil;
if BF<>nil then BF^.Prev:=nil;
while BF<>nil do begin
if BF^.Prev<>nil then Dispose(BF^.Prev);
BF:=BF^.Next;
                   end;
Dispose(BF);

end;

Procedure Tbuffer.next();//Следующий
begin
IF Current^.Next<>nil then Current:=Current^.Next;
end;

Procedure Tbuffer.prev();//Предыдущий
begin
if Current^.Prev<>nil then Current:=Current^.Prev;
end;

Procedure Tbuffer.first();  //Переходим к последненму
begin
Current:=FirstE;
end;

Procedure Tbuffer.Last(); //Переходим к последнему элементу
begin
Current:=LastE;
end;

Destructor Tbuffer.Destroy(); //Удаление данных и объекта
 var BF:PELFerm;
begin
BF:=FirstE;
BF^.Prev:=nil;
while BF<>nil do begin
if BF^.Prev<>nil then Dispose(BF^.Prev);
BF:=BF^.Next;
                   end;
Dispose(BF);
end;

end.
