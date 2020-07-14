unit FilesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Buttons;

type
  TFilesList_Form = class(TForm)
    FileListBox1: TFileListBox;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    procedure FileListBox1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FilesList_Form: TFilesList_Form;

implementation

{$R *.dfm}

procedure TFilesList_Form.FormResize(Sender: TObject);
begin
  if ClientWidth<400 then ClientWidth:=400;
  if ClientHeight<200 then ClientHeight:=200;
 FileListBox1.Height:=ClientHeight-FileListBox1.Top-40;
 Memo1.Width:=ClientWidth-Memo1.Left-8;
 Memo1.Height:=ClientHeight-Memo1.Top-8;
 BitBtn1.Top:=ClientHeight-33;
end;

procedure TFilesList_Form.FormShow(Sender: TObject);
begin
 ClientWidth:=609;
 ClientHeight:=337;
 FileListBox1.Update;
 FileListBox1.ItemIndex:=0;
 Memo1.Lines.LoadFromFile(FileListBox1.FileName);
end;

procedure TFilesList_Form.FileListBox1Change(Sender: TObject);
begin
 Memo1.Clear;
 if FileListBox1.ItemIndex=-1 then FileListBox1.ItemIndex:=0;
 Memo1.Lines.LoadFromFile(FileListBox1.FileName);
end;


end.
