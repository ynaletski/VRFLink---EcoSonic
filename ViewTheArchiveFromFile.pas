unit ViewTheArchiveFromFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls;

type
  TFormArchFromFile = class(TForm)
    sgTable: TStringGrid;
    cbType: TComboBox;
    cbTypeTable: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure cbTypeChange(Sender: TObject);
    procedure cbTypeTableChange(Sender: TObject);
    procedure sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormArchFromFile: TFormArchFromFile;

implementation

{$R *.dfm}
uses Main,report;
const str_tab:array[0..2]of string=('??????? ??????','??????? ???????',
                                    '??????? ???????');

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}
                                    
procedure TFormArchFromFile.FormCreate(Sender: TObject);
begin
  cbType.ItemIndex:=0; cbTypeTable.ItemIndex:=0;
end;
//---------------------------------------------------//

procedure ClearTable;
var i,j:integer;
begin
  for i:=0 to FormArchFromFile.sgTable.ColCount-1 do
    for j:=0 to FormArchFromFile.sgTable.RowCount-1 do FormArchFromFile.sgTable.Cells[i,j]:=' ';
end;
//---------------------------------------------------//

procedure ViewTableArchive;
var i,j:integer; list:TStringList; name_file:string;
begin
  list:=TStringList.Create; list.Clear; ClearTable;
  case FormArchFromFile.cbType.ItemIndex of
    0:
    begin
      MainForm.OpenDialog1.FilterIndex:=4;
      MainForm.OpenDialog1.Title:='??????? ??? ????????? ?????';
      if MainForm.OpenDialog1.Execute then
      begin
        name_file:=MainForm.OpenDialog1.FileName;
        try  list.LoadFromFile(name_file);
        except on EFOpenError do
        begin ClearTable; ShowMessage('?????? ???????? ????? ??????!');Exit;end;end;
        try max_col:=StrToInt(list.Strings[0]);
            max_data:=StrToInt(list.Strings[1]);
            max_event:=StrToInt(list.Strings[2]);
            max_alarm:=StrToInt(list.Strings[3]);
        except on EConvertError do
        begin ClearTable; ShowMessage('?????? ??????? ????? ??????!');Exit;end;end;
        FormArchFromFile.sgTable.RowCount:=max_data+2; FormArchFromFile.sgTable.ColCount:=max_col+1;
        FormForReports.lCountEvent.Caption:=IntToStr(max_event);
        FormForReports.lCountAlarm.Caption:=IntToStr(max_alarm);
        FormArchFromFile.sgTable.FixedRows:=2; FormArchFromFile.sgTable.DefaultColWidth:=75;
        FormArchFromFile.sgTable.ColWidths[0]:=151;
        if list.Count>2 then for i:=0 to FormArchFromFile.sgTable.ColCount-1 do
          for j:=0 to FormArchFromFile.sgTable.RowCount-1 do
        FormArchFromFile.sgTable.Cells[i,j]:=list.Strings[i*FormArchFromFile.sgTable.RowCount+j+4];
        list.Free; Exit;
      end else Exit;
    end;
    1:
    begin
      max_col:=s_byte[27]; max_data:=s_byte[28]*256+s_byte[29];
      max_event:=s_byte[30]*256+s_byte[31]; max_alarm:=s_byte[32]*256+s_byte[33];
      FormForReports.lCountEvent.Caption:=IntToStr(max_event);
      FormForReports.lCountAlarm.Caption:=IntToStr(max_alarm);  
    end;
  end;
  if FormArchFromFile.cbType.ItemIndex=1 then
  begin
    case FormArchFromFile.cbTypeTable.ItemIndex of
      0:
      if max_data>0 then
      begin
        FormArchFromFile.sgTable.RowCount:=max_data+2;
        FormArchFromFile.sgTable.FixedRows:=2; FormArchFromFile.sgTable.DefaultColWidth:=75;
        FormArchFromFile.sgTable.ColWidths[0]:=151; FormArchFromFile.sgTable.ColCount:=max_col+1;
        try list.LoadFromFile(sNameMonth);
        except on EFOpenError do
        begin ClearTable; ShowMessage('???? ?????? ?? ??????!');Exit;end;end;
        if list.Count>0 then for i:=0 to FormArchFromFile.sgTable.ColCount-1 do
        for j:=0 to FormArchFromFile.sgTable.RowCount-1 do
        FormArchFromFile.sgTable.Cells[i,j]:=list.Strings[i*FormArchFromFile.sgTable.RowCount+j];
      end;
      1:
      if max_event>0 then
      begin
        FormArchFromFile.sgTable.FixedRows:=1; FormArchFromFile.sgTable.ColCount:=5;
        FormArchFromFile.sgTable.DefaultColWidth:=115; FormArchFromFile.sgTable.ColWidths[0]:=151;
        FormArchFromFile.sgTable.ColWidths[3]:=201; FormArchFromFile.sgTable.ColWidths[4]:=75;
        FormArchFromFile.sgTable.RowCount:=max_event+2;
        try list.LoadFromFile(sNameEvt);
        except on EFOpenError do
        begin ShowMessage('???? ??????? ?? ??????!');Exit;end;end;
        if list.Count>0 then for i:=0 to FormArchFromFile.sgTable.ColCount-1 do
        for j:=0 to max_event do
        FormArchFromFile.sgTable.Cells[i,j]:=list.Strings[i*(max_event+1)+j];
      end;
      2:
      if max_alarm>0 then
      begin
        FormArchFromFile.sgTable.FixedRows:=1; FormArchFromFile.sgTable.ColCount:=4;
        FormArchFromFile.sgTable.DefaultColWidth:=115; FormArchFromFile.sgTable.ColWidths[0]:=151;
        FormArchFromFile.sgTable.ColWidths[3]:=201; FormArchFromFile.sgTable.RowCount:=max_alarm+2;
        try list.LoadFromFile(sNameAlm);
        except on EFOpenError do
        begin ShowMessage('???? ??????? ?? ??????!');Exit;end;end;
        if list.Count>0 then for i:=0 to FormArchFromFile.sgTable.ColCount-1 do
        for j:=0 to max_alarm do
        begin FormArchFromFile.sgTable.Cells[i,j]:=list.Strings[i*(max_alarm+1)+j];end;
      end;
    end;
  end; list.Free;
end;
//---------------------------------------------------//

procedure TFormArchFromFile.cbTypeChange(Sender: TObject);
var i,j:integer; list:TStringList; name_file:string;
begin
  cbTypeTable.Clear; 
  if cbType.ItemIndex=0 then cbTypeTable.Items.Add(str_tab[0]) else
  if cbType.ItemIndex=1 then for i:=0 to Length(str_tab)-1 do
  cbTypeTable.Items.Add(str_tab[i]); cbTypeTable.ItemIndex:=0;
  ViewTableArchive;
end;
//---------------------------------------------------//

procedure TFormArchFromFile.cbTypeTableChange(Sender: TObject);
begin  ViewTableArchive;end;
//---------------------------------------------------//

procedure TFormArchFromFile.sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if State=[gdSelected]then with sgTable do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
end;
//---------------------------------------------------//

end.
