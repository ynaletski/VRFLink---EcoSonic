unit report;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, CheckLst, ComCtrls, ExtCtrls, Math, Buttons;

type
  TFormForReports = class(TForm)
    pRaport: TPanel;
    rgArchType: TRadioGroup;
    mcSelect: TMonthCalendar;
    clParamList: TCheckListBox;
    sgArchive: TStringGrid;
    sgEvent: TStringGrid;
    sgAlarm: TStringGrid;
    GroupBox1: TGroupBox;
    lCountData: TLabel;
    lCountEvent: TLabel;
    lCountAlarm: TLabel;
    eIdentif: TEdit;
    BitBtn1: TBitBtn;
    procedure sgArchiveDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgEventDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgAlarmDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure clParamListClick(Sender: TObject);
    procedure rgArchTypeClick(Sender: TObject);
    procedure mcSelectClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ViewArchiveTable;
  end;

var
  FormForReports: TFormForReports; max_data,max_event,max_alarm,max_col:integer;

implementation

{$R *.DFM}
uses FormForView,Main;

var dtStart,dtStop:TDateTime; date_calendar:TDate;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure ClearTable(table:TStringGrid);
var i,j:integer;
begin
  for i:=0 to table.ColCount-1 do for j:=0 to table.RowCount-1 do
  table.Cells[i,j]:='';
end;
//---------------------------------------------------//

procedure TFormForReports.ViewArchiveTable;
const
name_glv:array[0..1]of string[20]=('Параметр','Дата/Время/Единицы');

str_evt:array[0..4]of string[30]=('Дата и время','Старое знач',
             'Новое знач','Параметр/список или действие','Идентификатор');

str_alm:array[0..3]of string[25]=('Дата и время',
                      'Установка/сброс','Значение','Тип аларма');
                      
var i,j,size,num_rec,flg_res,num_str:integer;Year,Month,Day:word;
    dtCur:TDateTime;num_list,ind_ident:byte;
begin
  sgArchive.Width:=855;
  sgArchive.DefaultColWidth:=100;
  sgArchive.RowHeights[0]:=sgArchive.DefaultRowHeight*2;
  sgArchive.ColWidths[0]:=120;
  size:=0;
  ClearTable(sgArchive);
  ClearTable(sgEvent);
  ClearTable(sgAlarm);
  for i:=0 to Length(name_glv)-1 do sgArchive.Cells[0,i]:=name_glv[i];
  for i:=0 to Length(str_evt)-1 do sgEvent.Cells[i,0]:=str_evt[i];
  for i:=0 to Length(str_alm)-1 do sgAlarm.Cells[i,0]:=str_alm[i];
  sgEvent.Width:=855;
  sgEvent.DefaultColWidth:=155;
  sgEvent.ColWidths[3]:=225;
  sgEvent.ColWidths[0]:=120;
  {sgEvent.ColWidths[4]:=150;}
  sgAlarm.Width:=855;
  sgAlarm.DefaultColWidth:=155;
  sgAlarm.ColWidths[0]:=120;
  {sgAlarm.ColWidths[1]:=155;}
  sgAlarm.ColWidths[3]:=250;
  if clParamList.Items.Count>0 then for i:=0 to clParamList.Items.Count-1 do
  if (size<7)and(clParamList.Checked[i]) then
  begin
    sgArchive.Cells[size+1,0]:=clParamList.Items.Strings[i];
    sgArchive.Cells[size+1,1]:=units_report[i];
    size:=size+1;
  end;max_col:=size;
  case rgArchType.ItemIndex of
    0:
    try
      dtStart:=Floor(mcSelect.Date)-1+EncodeTime(contract,0,1,0);
      dtStop:=Floor(mcSelect.Date)+EncodeTime(contract,0,0,0);
    except on EConvertError do Exit;end;
    1:
    try
      DecodeDate(mcSelect.Date,Year,Month,Day);
      dtStart:=EncodeDate(Year,Month,1)+EncodeTime(contract,0,1,0);
      Month:=Month+1;
      if Month>12 then begin Month:=1;Year:=Year+1;end;
      dtStop:=EncodeDate(Year,Month,1)+EncodeTime(contract,0,0,0);
    except on EConvertError do Exit;end;
  end;
  num_rec:=0;
  num_str:=0;
  AssignFile(f_arc,namea);
  {$I-}Reset(f_arc);
  {$I+} flg_res:=IOResult;
  if flg_res = 0 then
  begin
    while Eof(f_arc)=false do with d_arc do
    begin
      Seek(f_arc,num_rec);
      Read(f_arc,d_arc);
      if rgArchType.ItemIndex=a_type then
        if (a_time>dtStart)and(a_time<=dtStop)then
      begin
        sgArchive.Cells[0,num_str+sgArchive.FixedRows]:=DateToStr(a_time)+'  '+
                        TimeToStr(a_time);size:=0;
        if clParamList.Items.Count>0 then for i:=0 to clParamList.Items.Count-1 do
        if (size<7)and(clParamList.Checked[i]) then
        begin
          sgArchive.Cells[size+1,num_str+sgArchive.FixedRows]:=
          FloatToStrF(a_data[i],ffGeneral,6,5);
          size:=size+1;
        end;
        num_str:=num_str+1;
      end;
      num_rec:=num_rec+1;
    end;
    CloseFile(f_arc);
    sgArchive.RowCount:=num_str+sgArchive.FixedRows+1;
  end;
  max_data:=num_str;
  lCountData.Caption:=IntToStr(max_data);

  if max_data<=0 then
    begin
      MainForm.MainMenu.Items.Items[7].Items[2].Enabled:=false;
      MainForm.MainMenu.Items.Items[7].Items[3].Enabled:=false;
    end
  else
    begin
      MainForm.MainMenu.Items.Items[7].Items[2].Enabled:=true;
      MainForm.MainMenu.Items.Items[7].Items[3].Enabled:=true;
    end;

  sgArchive.FixedCols:=1;
  num_rec:=0;
  num_str:=0;
  AssignFile(f_event,namet);
  {$I-}Reset(f_event);
  {$I+} flg_res:=IOResult;
  if flg_res = 0 then
  begin
    while Eof(f_event)=false do with d_event do
    begin
      Seek(f_event,num_rec);
      Read(f_event,d_event);
      try
        dtCur:=EncodeDate(a_event[0]+2000,a_event[1],a_event[2])+
               EncodeTime(a_event[3],a_event[4],a_event[5],0);
      except on EconvertError do;end;
      if (dtCur>dtStart)and(dtCur<=dtStop)then
      begin
        FormForVariablesView.ViewOnEvent(d_event.a_event,sgEvent,0,num_str+sgEvent.FixedRows);
        num_list:=d_event.a_event[15] and $f;
        ind_ident:=d_event.a_event[15] and $f0;
        if (num_list=9)or(ind_ident>16) then
        sgEvent.Cells[4,num_str+sgEvent.FixedRows]:='' else if ind_ident=0 then
        sgEvent.Cells[4,num_str+sgEvent.FixedRows]:='Коммуникационный порт' else
        if ind_ident=16 then sgEvent.Cells[4,num_str+sgEvent.FixedRows]:='Терминал';
        num_str:=num_str+1;
      end;
      num_rec:=num_rec+1;
    end;
    CloseFile(f_event);
    sgEvent.RowCount:=num_str+sgEvent.FixedRows+1;
  end;
  max_event:=num_str;
  lCountEvent.Caption:=IntToStr(max_event);
  num_rec:=0;
  num_str:=0;
  AssignFile(f_event,namer);
  {$I-}Reset(f_event);
  {$I+} flg_res:=IOResult;
  if flg_res = 0 then
  begin
    while Eof(f_event)=false do with d_event do
    begin
      Seek(f_event,num_rec);
      Read(f_event,d_event);
      try
        dtCur:=EncodeDate(a_event[0]+2000,a_event[1],a_event[2])+
               EncodeTime(a_event[3],a_event[4],a_event[5],0);
      except on EconvertError do;
      end;
      if (dtCur>dtStart)and(dtCur<=dtStop)then
      begin
        FormForVariablesView.ViewOnAlarm(d_event.a_event,sgAlarm,num_str+sgAlarm.FixedRows,0);
        num_str:=num_str+1;
      end;
      num_rec:=num_rec+1;
    end;
    CloseFile(f_event);
    sgAlarm.RowCount:=num_str+sgAlarm.FixedRows+1;
  end;
  max_alarm:=num_str;
  lCountAlarm.Caption:=IntToStr(max_alarm);
end;
//---------------------------------------------------//

procedure TFormForReports.sgArchiveDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if State=[gdSelected]then with sgArchive do
  begin
    Canvas.Font.Color:=Font.Color;
    Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (State=[gdFixed])and(ARow=0)and(ACol>1) then with sgArchive do
  begin
    FormForVariablesView.StrToStrings(Cells[ACol, ARow]);
    Canvas.FillRect(Rect);
    case Length(str_massive)of
      1:
      Canvas.TextOut(Rect.Left+2,Rect.Top,str_massive[0]);
      2:
      begin
        Canvas.TextOut(Rect.Left+2,Rect.Top,str_massive[0]);
        Canvas.TextOut(Rect.Left+2,Rect.Top+DefaultRowHeight,str_massive[1]);
      end;
      3:
      begin
        Canvas.TextOut(Rect.Left+2,Rect.Top,str_massive[0]+' '+str_massive[1]);
        Canvas.TextOut(Rect.Left+2,Rect.Top+DefaultRowHeight,str_massive[2]);
      end;
      4:
      begin
        Canvas.TextOut(Rect.Left+2,Rect.Top,str_massive[0]+' '+str_massive[1]);
        Canvas.TextOut(Rect.Left+2,Rect.Top+DefaultRowHeight,str_massive[2]+' '+
                       str_massive[3]);
      end;
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormForReports.sgEventDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if State=[gdSelected]then with sgEvent do
  begin
    Canvas.Font.Color:=Font.Color;
    Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];
    Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
end;
//---------------------------------------------------//

procedure TFormForReports.sgAlarmDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if State=[gdSelected]then with sgAlarm do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
end;
//---------------------------------------------------//

procedure TFormForReports.clParamListClick(Sender: TObject);
begin
  ViewArchiveTable;
end;
//---------------------------------------------------//

procedure TFormForReports.rgArchTypeClick(Sender: TObject);
begin
  ViewArchiveTable;
end;
//---------------------------------------------------//

procedure TFormForReports.mcSelectClick(Sender: TObject);
begin
  date_calendar:=mcSelect.Date; ViewArchiveTable; BitBtn1.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormForReports.BitBtn1Click(Sender: TObject);
var i,j,flg_res:integer; list:TStringList; num:byte;
str,str_event,str_month,str_alarm:string;
begin  {сохранение таблиц в текстовых файлах для распечатки}
  BitBtn1.Enabled:=false;
  list:=TStringList.Create; list.Clear; num:=0;

  //24.11.2021 YN
  MainForm.SaveDialog1.Title:='Сохранение В ТХТ файле';
  MainForm.SaveDialog1.FilterIndex:=6;
  MainForm.SaveDialog1.DefaultExt:='txt';
  MainForm.SaveDialog1.FileName:=DateToStr(date_calendar);
  if MainForm.SaveDialog1.Execute then
  begin
    str:=MainForm.SaveDialog1.FileName;
    str_event:=Copy(str,1,Length(str)-4) + '_gas_event.txt';
    str_month:=Copy(str,1,Length(str)-4) + '_gas_month.txt';
    str_alarm:=Copy(str,1,Length(str)-4) + 'gas_alarm.txt';
  end;
  if str = '' then
  begin
    str:='c:\Мои документы\'+DateToStr(date_calendar)+'.txt'; {имя файла}
    str_event:='c:\Мои документы\gas_event.txt';
    str_month:='c:\Мои документы\gas_month.txt';
    str_alarm:='c:\Мои документы\gas_alarm.txt';
  end;

  for i:=0 to clParamList.Count-1 do if clParamList.Checked[i] then
  num:=num+1;
  if rgArchType.ItemIndex=0 then
  begin
    list.Add(IntToStr(num)); list.Add(IntToStr(max_data));
    list.Add(IntToStr(max_event)); list.Add(IntToStr(max_alarm));
  end;
  for i:=0 to num do for j:=0 to max_data+1 do list.Add(sgArchive.Cells[i,j]);
  if rgArchType.ItemIndex=0 then list.SaveToFile(str);

  if rgArchType.ItemIndex=1 then list.SaveToFile(str_month);

  if (rgArchType.ItemIndex=1)and(max_event>0) then
  begin
    list.Clear;
    for i:=0 to sgEvent.ColCount-1 do
    for j:=0 to max_event do list.Add(sgEvent.Cells[i,j]);
    if rgArchType.ItemIndex=1 then list.SaveToFile(str_event);
  end; list.Clear;
  if (rgArchType.ItemIndex=1)and(max_alarm>0) then
  begin
    list.Clear;
    for i:=0 to sgAlarm.ColCount-1 do for j:=0 to max_alarm do
    list.Add(sgAlarm.Cells[i,j]);
    if rgArchType.ItemIndex=1 then list.SaveToFile(str_alarm);
  end; list.Free;
  if rgArchType.ItemIndex=1 then
  begin
    AssignFile(f_conf,Fname);{$I-} Reset(f_conf);{$I+} flg_res:=IOResult;
    if flg_res=0 then
    begin {сохранение числа парам и чисел строк таблиц для часового и сут архивов}
  {  if rgArchType.ItemIndex=0 then
    begin
      d_conf.c_byte[20]:=num; d_conf.c_byte[21]:=Hi(max_data);
      d_conf.c_byte[22]:=Lo(max_data); d_conf.c_byte[23]:=Hi(max_event);
      d_conf.c_byte[24]:=Lo(max_event); d_conf.c_byte[25]:=Hi(max_alarm);
      d_conf.c_byte[26]:=Lo(max_alarm);
    end; }

      begin
        d_conf.c_byte[27]:=num; d_conf.c_byte[28]:=Hi(max_data);
        d_conf.c_byte[29]:=Lo(max_data); d_conf.c_byte[30]:=Hi(max_event);
        d_conf.c_byte[31]:=Lo(max_event); d_conf.c_byte[32]:=Hi(max_alarm);
        d_conf.c_byte[33]:=Lo(max_alarm);
      end; Write(f_conf,d_conf); CloseFile(f_conf);
    end;
  end;
end;
//---------------------------------------------------//

end.
