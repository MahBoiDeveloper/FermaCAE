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
FIrstE:PELFerm; //������
LAstE:PELFerm;// ���������
Current:PELFerm; //�������
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



COnstructor Tbuffer.Create(F:TFerm);  // �������������
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.F:=Tferm.Create;
//������ ����������� ����������
 FB^.F.Assign(F);
 FB^.P:=nil;
 FB^.T:=nil;
 // ����� ������� �����������
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.Add(F:TFerm);// ����� ����������� ������� (��������������� �������)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.F:=Tferm.Create;
//������ ����������� ����������
BF^.F.Assign(F);
BF^.P:=nil;
BF^.T:=nil;
 // ����� ������� �����������
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;

COnstructor Tbuffer.CreateP(F:TPlast);  // �������������
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.P:=TPlast.Create;
//������ ����������� ����������
 FB^.P.Assign(F);
 FB^.F:=nil;
 FB^.T:=nil;
 // ����� ������� �����������
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.AddP(F:TPlast);// ����� ����������� ������� (��������������� �������)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.P:=TPlast.Create;
//������ ����������� ����������
BF^.P.Assign(F);
BF^.F:=nil;
BF^.T:=nil;
 // ����� ������� �����������
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;

COnstructor Tbuffer.CreateT(T:TTok);  // �������������
var FB:PELferm;
begin
new(FB);
FB^.Next:=nil;
FB^.Prev:=nil;
FB^.T:=TTok.Create;
//������ ����������� ����������
 FB^.T.Assign(T);
 FB^.F:=nil;
 FB^.P:=nil;
 // ����� ������� �����������
FirstE:=FB;
LASTE:=FB;
CUrrent:=FB;
end;

Procedure Tbuffer.AddT(T:TTok);// ����� ����������� ������� (��������������� �������)
var BF:PELFerm;
begin
Delete();
new(BF);
BF^.T:=TTok.Create;
//������ ����������� ����������
 BF^.T.Assign(T);
 BF^.F:=nil;
 BF^.P:=nil;
 // ����� ������� �����������
BF^.Next:=nil;
BF^.Prev:=Current;
Current^.Next:=BF;
LastE:=BF;
Current:=Current^.Next;
end;


Procedure Tbuffer.Delete(); //������� ��� ����� ����� ������������
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

Procedure Tbuffer.next();//���������
begin
IF Current^.Next<>nil then Current:=Current^.Next;
end;

Procedure Tbuffer.prev();//����������
begin
if Current^.Prev<>nil then Current:=Current^.Prev;
end;

Procedure Tbuffer.first();  //��������� � �����������
begin
Current:=FirstE;
end;

Procedure Tbuffer.Last(); //��������� � ���������� ��������
begin
Current:=LastE;
end;

Destructor Tbuffer.Destroy(); //�������� ������ � �������
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
