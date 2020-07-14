unit AddUserInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleServer, ComObj, WordXP, Clipbrd, ComCtrls,
  IniFiles, Menus, Word2000;

type
  TAddUserInfo_form = class(TForm)
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    Label1: TLabel;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    Button3: TButton;
    SaveDialog1: TSaveDialog;
    RadioGroup1: TRadioGroup;
    ProgressBar1: TProgressBar;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    WordApplication1: TWordApplication;
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LabeledEdit10Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AddUserInfo_form: TAddUserInfo_form;
  CanCreate: Boolean;

implementation

{$R *.dfm}

uses
  Main;


procedure TAddUserInfo_form.Button3Click(Sender: TObject);
begin
 if (SaveDialog1.Execute) then LabeledEdit10.Text:=SaveDialog1.FileName;
end;


procedure TAddUserInfo_form.Button1Click(Sender: TObject);
var
 i: integer;
 OleFileName, SaveChanges: OleVariant;
 Ini: TIniFile;
begin
 CanCreate:=True;

 DOCFullName:=LabeledEdit10.Text;
 OleFileName:=DOCFullName;
 SaveChanges:=wdDoNotSaveChanges;

// Проверка на наличие файла отчета:
 if FileExists(DOCFullName) then
  begin
   if Application.MessageBox('Файл уже существует. Перезаписать?',
    'Перезаписать существующий файл?',mb_okcancel)=1 then
    begin
     if not DeleteFile(DOCFullName) then
      begin
       CanCreate:=False;
       ShowMessage('Нет доступа к файлу. Возможно, он занят другим приложением. Документ НЕ создан.');
      end;
    end
   else
    begin
     CanCreate:=False;
     ShowMessage('Документ НЕ создан.');
    end;
  end;

// Продолжаем, если с файлом разобрались:
 if CanCreate=True then
  begin
   Button1.Enabled:=False;
   Button2.Enabled:=False;
   Button3.Enabled:=False;
// Открытие приложения Word и создание нового документа:
   WordApplication1.Connect;
   WordApplication1.Documents.Add(EmptyParam,EmptyParam,EmptyParam,EmptyParam);
   WordApplication1.Visible:=False;
   WordApplication1.Options.CheckSpellingAsYouType:=False;
   WordApplication1.Options.CheckGrammarAsYouType:=False;
    if RadioGroup1.ItemIndex=0 then WordApplication1.Visible:=True;
   ProgressBar1.StepIt;
// Создание титульного листа:
   with WordApplication1.Selection do
    begin
     //ParagraphFormat.;
     ParagraphFormat.SpaceBefore:=0;
     ParagraphFormat.SpaceAfter:=0;
     Font.Name:='Arial';
     Font.Size:=18;
     Font.Bold:=1;
     ParagraphFormat.Alignment:=wdAlignParagraphCenter;
     TypeText('Московский Авиационный Институт');
     TypeParagraph;
     Font.Bold:=0;
     TypeText('(государственный технический университет)');
     TypeParagraph;
     Font.Size:=12;
     TypeText('Факультет: '+LabeledEdit4.Text+' ('+LabeledEdit5.Text+')');
     TypeParagraph;
     TypeText('Кафедра: '+LabeledEdit6.Text+ ' ('+LabeledEdit7.Text+')');
    ProgressBar1.StepIt;
      for i:=1 to 5 do TypeParagraph;
     Font.Size:=26;
     Font.Bold:=1;
     TypeText('ОТЧЕТ');
     TypeParagraph;
     Font.Size:=16;
     TypeText('по лабораторной работе');
      for i:=1 to 3 do TypeParagraph;
     TypeText('на тему:');
     TypeParagraph;
     Font.Bold:=0;
     TypeText('"'+LabeledEdit9.Text+'"');
    ProgressBar1.StepIt;
     Font.Size:=12;
      for i:=1 to 12 do TypeParagraph;
     Font.Bold:=1;
     ParagraphFormat.Alignment:=wdAlignParagraphRight;
     TypeText('Выполнил студент группы '+LabeledEdit8.Text+':');
     TypeParagraph;
     Font.Italic:=1;
     Font.Bold:=0;
     TypeText(LabeledEdit1.Text);
      for i:=1 to 3 do TypeParagraph;
     Font.Italic:=0;
     Font.Bold:=1;
     TypeText('Руководитель:');
    ProgressBar1.StepIt;
     TypeParagraph;
     Font.Italic:=1;
     Font.Bold:=0;
     TypeText(LabeledEdit11.Text);
      for i:=1 to 9 do TypeParagraph;
     Font.Italic:=0;
     ParagraphFormat.Alignment:=wdAlignParagraphCenter;
     TypeText('Москва, МАИ, '+DateToStr(Date()));
    end;

   ProgressBar1.StepIt;

// Сохранение документа (и закрытие приложения):
   {WordApplication1.ActiveDocument.SaveAs(OleFileName,EmptyParam,EmptyParam,
    EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
     EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
      EmptyParam);       }
      WordApplication1.ActiveDocument.SaveAs(OleFileName,EmptyParam,EmptyParam,
    EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,EmptyParam,
     EmptyParam,EmptyParam);
    if RadioGroup1.ItemIndex=0 then
     begin
      WordApplication1.Disconnect;
     end
    else
     begin
      WordApplication1.ActiveDocument.Close(SaveChanges,EmptyParam,EmptyParam);
      WordApplication1.Disconnect;
      WordApplication1.Quit;
     end;

   Ini:=TIniFile.Create(IniFullName);
   Ini.EraseSection('Path To DOC');
   Ini.WriteString('Path To DOC','Current',DOCFullName);
   Ini.Free;

   ProgressBar1.StepIt;

   Close;
  end;

{
// Наполнение титульного листа:
 WordDocument1.Range.Font.Name:='Arial';
 WordDocument1.Range.Font.Size:=12;

 WordDocument1.Range.InsertAfter('Московский Авиационный Институт');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter('(государственный технический университет)');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter('Факультет: '+LabeledEdit4.Text+' ('+LabeledEdit5.Text+')');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter('Кафедра: '+LabeledEdit6.Text+ ' ('+LabeledEdit7.Text+')');
 for i:=1 to 7 do
  begin
   WordDocument1.Range.InsertParagraphAfter;
  end;
 WordDocument1.Range.InsertAfter('ОТЧЕТ');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter('по лабораторной работе');
 for i:=1 to 3 do
  begin
   WordDocument1.Range.InsertParagraphAfter;
  end;
 WordDocument1.Range.InsertAfter('на тему:');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter('"'+LabeledEdit9.Text+'"');
 for i:=1 to 7 do
  begin
   WordDocument1.Range.InsertParagraphAfter;
  end;
 WordDocument1.Range.InsertAfter('Выполнил студент группы '+LabeledEdit8.Text+':');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter(LabeledEdit1.Text+' '+LabeledEdit2.Text+' '+LabeledEdit3.Text);
 for i:=1 to 3 do
  begin
   WordDocument1.Range.InsertParagraphAfter;
  end;
 WordDocument1.Range.InsertAfter('Руководитель:');
 WordDocument1.Range.InsertParagraphAfter;
 WordDocument1.Range.InsertAfter(LabeledEdit11.Text);
 for i:=1 to 3 do
  begin
   WordDocument1.Range.InsertParagraphAfter;
  end;
 WordDocument1.Range.InsertAfter('Москва, МАИ, '+DateToStr(Date()));
}
// Форматирование титульного листа:
{
 a:=0;
 b:=31;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=1;
 WordDocument1.Range(a,b).Font.Size:=18;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 a:=32;
 b:=73;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=0;
 WordDocument1.Range(a,b).Font.Size:=18;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 a:=74;
 b:=143;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=0;
 WordDocument1.Range(a,b).Font.Size:=12;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 a:=149;
 b:=154;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=1;
 WordDocument1.Range(a,b).Font.Size:=26;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 a:=155;
 b:=188;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=1;
 WordDocument1.Range(a,b).Font.Size:=14;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 a:=189;
 b:=232;
 cursor:=wdCollapseEnd;
 WordDocument1.Range(a,b).Font.Bold:=0;
 WordDocument1.Range(a,b).Font.Size:=14;
 WordDocument1.Range(a,b).Select;
 WordParagraphFormat1.ConnectTo(WordApplication1.Selection.ParagraphFormat);
 WordParagraphFormat1.Alignment:=wdAlignParagraphCenter;
 WordApplication1.Selection.Collapse(cursor);

 WordApplication1.Selection.Font:=
}

{
// Копирование содержимого формы в отчет:
 WordApplication1.Selection.TypeParagraph;
 Clipboard();
 Clipboard.Assign(AddUserInfo_form.GetFormImage);
 WordApplication1.Selection.Paste;
 Clipboard.Clear;
}


end;


procedure TAddUserInfo_form.Button2Click(Sender: TObject);
begin
 Close;
end;


procedure TAddUserInfo_form.FormCreate(Sender: TObject);
begin
 if AddUserInfoVisible=true then ShowModal;
end;


procedure TAddUserInfo_form.LabeledEdit10Change(Sender: TObject);
begin
 if (LabeledEdit10.Text='') or (Length(LabeledEdit10.Text)<3) then
  Button1.Enabled:=False
 else
  Button1.Enabled:=True;
end;


procedure TAddUserInfo_form.FormShow(Sender: TObject);
begin
 LabeledEdit10.Text:=DOCFullName;
 ProgressBar1.Position:=0;

 Button1.Enabled:=True;
 Button2.Enabled:=True;
 Button3.Enabled:=True;

 CanCreate:=True;
end;


procedure TAddUserInfo_form.N1Click(Sender: TObject);
begin
 Main_Form.PutToAccount(AddUserInfo_Form);
end;

end.
