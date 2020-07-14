unit ModuleExecute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Buttons, ShellAPI, Menus;

type
  TModuleExecute_Form = class(TForm)
    Label1: TLabel;
    FileListBox1: TFileListBox;
    Label2: TLabel;
    Memo1: TMemo;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormPaint(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N2Click(Sender: TObject);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure FileListBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ModuleExecute_Form: TModuleExecute_Form;

implementation

uses
 Main;

{$R *.dfm}

procedure TModuleExecute_Form.Button2Click(Sender: TObject);
begin
 Close;
end;

procedure TModuleExecute_Form.FormShow(Sender: TObject);
begin
 if not DirectoryExists(ExtractFilePath(Application.ExeName)+'Modules\') then
  CreateDir(ExtractFilePath(Application.ExeName)+'Modules\');
 FileListBox1.ApplyFilePath(ExtractFilePath(Application.ExeName)+'Modules\');
 FileListBox1.ItemIndex:=0;
 Memo1.Clear;
  if FileExists(Copy(FileListBox1.FileName,0,
   Length(FileListBox1.FileName)-3)+'txt') then
   begin
    Memo1.Lines.LoadFromFile(Copy(FileListBox1.FileName,0,
     Length(FileListBox1.FileName)-3)+'txt');
   end;
end;


procedure TModuleExecute_Form.BitBtn3Click(Sender: TObject);
begin
 Close;
end;

procedure TModuleExecute_Form.BitBtn2Click(Sender: TObject);
begin
 if not DirectoryExists(ExtractFilePath(Application.ExeName)+'Modules\') then
  CreateDir(ExtractFilePath(Application.ExeName)+'Modules\');
 FileListBox1.ApplyFilePath(ExtractFilePath(Application.ExeName)+'Modules\');
 FileListBox1.Update;
 FileListBox1.ItemIndex:=0;
 Memo1.Clear;
  if FileExists(Copy(FileListBox1.FileName,0,
   Length(FileListBox1.FileName)-3)+'txt') then
   begin
    Memo1.Lines.LoadFromFile(Copy(FileListBox1.FileName,0,
     Length(FileListBox1.FileName)-3)+'txt');
   end;
end;

procedure TModuleExecute_Form.BitBtn1Click(Sender: TObject);
begin
 if FileExists(FileListBox1.FileName) then
 ShellExecute(ModuleExecute_Form.Handle,Nil,PAnsiChar(FileListBox1.FileName),
  Nil,Nil,SW_ShowNormal);
end;

procedure TModuleExecute_Form.FileListBox1Change(Sender: TObject);
begin
 Memo1.Clear;
  if FileExists(Copy(FileListBox1.FileName,0,
   Length(FileListBox1.FileName)-3)+'txt') then
   begin
    Memo1.Lines.LoadFromFile(Copy(FileListBox1.FileName,0,
     Length(FileListBox1.FileName)-3)+'txt');
   end;
end;

procedure TModuleExecute_Form.N1Click(Sender: TObject);
begin
 Main_Form.PutToAccount(ModuleExecute_Form);
end;

procedure TModuleExecute_Form.FormMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (Selection) and (Button=mbRight) then
  Main_Form.MouseIsDown(ModuleExecute_Form,X,Y);
 if (Selection) and (Button=mbLeft) then
  Main_Form.MouseLeft(ModuleExecute_Form);
end;

procedure TModuleExecute_Form.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
 if Selection then
  Main_Form.MouseIsMove(ModuleExecute_Form,X,Y);
end;

procedure TModuleExecute_Form.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if (Selection) and (Button=mbRight) then
  Main_Form.MouseIsUp(ModuleExecute_Form,X,Y);
end;


procedure TModuleExecute_Form.N2Click(Sender: TObject);
begin
 if not N2.Checked then
  begin
   Selection:=True;
   Main_Form.SelectionMode(ModuleExecute_Form,True);
   N2.Checked:=True;
  end
 else
  begin
   Selection:=False;
   Main_Form.SelectionMode(ModuleExecute_Form,False);
   N2.Checked:=False;
  end;
end;


procedure TModuleExecute_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if Selection then
  begin
   Selection:=False;
   Main_Form.SelectionMode(ModuleExecute_Form,False);
   N2.Checked:=False;
  end;
end;

procedure TModuleExecute_Form.FormPaint(Sender: TObject);
begin
 if SelectionIsCopied and Selection then
  begin
   SelectionIsCopied:=False;
   Selection:=False;
   Main_Form.SelectionMode(ModuleExecute_Form,False);
   N2.Checked:=False;
  end;
end;

end.
