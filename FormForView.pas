unit FormForView;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, Grids, Spin, Math;

type
  TFormForVariablesView = class(TForm)
    sgTable: TStringGrid;
    Image1: TImage;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ViewWndEvents;
    procedure ViewWndArchive;
    procedure ViewWndMonutor;
    procedure ViewWndAlarms;
    procedure ViewWndNst;
    procedure ViewWndMonutorExp;
    procedure ViewEvents;
    procedure ViewAlarms;
    procedure ViewNst;
    procedure GoStep(Sender: TObject);
    procedure ClearTable(sg:TStringGrid);
    function SetDotFloat(value:single):byte;
    procedure ViewMonutor;
    procedure ViewMonutorExp;
    procedure ViewArchive(number,size:byte);
    procedure ViewArchiveMinute(number,size:byte);
    procedure StrToStrings(str:string);
    procedure ViewOnEvent(buf:array of byte;sg:TStringGrid;ofs,ind:integer);
    procedure ViewOnAlarm(buf:array of byte;sg:TStringGrid;ind,ofs:integer);
  end;

var
  FormForVariablesView: TFormForVariablesView;bStep: TBitBtn;str_massive:array of string;

implementation

{$R *.DFM}
uses Main, ConfigurationSettings, InOutModulesSetting;

const
   str_pnt:array[1..8]of string[12]=(', Базовый #1',', Базовый #2',', Базовый #3',
      ', Базовый #4',', Дополнител',', ',', Модули',', Общий');

var flg_color:boolean;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure TFormForVariablesView.StrToStrings(str:string);
var buf:string;i,num:integer;
begin
  if str='' then begin SetLength(str_massive,0);Exit;end;
  str:=str+' ';num:=0;
  for i:=1 to Length(str) do  if Ord(str[i])<>$20 then buf:=buf+str[i] else
  begin SetLength(str_massive,num+1);str_massive[num]:=buf;buf:='';num:=num+1;end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndArchive;
const head_str:array[0..1,0..1]of string[20]=(('','Параметр'),
               ('№ зап.','Дата / Единицы'));
var i,j,col:integer;
begin
  if (Length(Arch)=0)or(Length(ArchBasicSet)=0) then Exit;
  ClearTable(sgTable);sgTable.RowCount:=3;
  sgTable.Visible:=true;sgTable.FixedCols:=2;sgTable.FixedRows:=2;
  sgTable.Color:=clWindow;sgTable.FixedColor:=$00D8E9EC;
  sgTable.DefaultColWidth:=81;sgTable.ColWidths[0]:=35;col:=2;
  sgTable.DefaultRowHeight:=19;sgTable.RowHeights[0]:=sgTable.DefaultRowHeight*2;
  bStep.Height:=sgTable.RowHeights[0];
  for i:=0 to Length(head_str)-1 do for j:=0 to Length(head_str[i])-1 do
  sgTable.Cells[i,j]:=head_str[j,i];PRT.number_arc:=0;
  if Length(Arch)>0 then for i:=0 to Length(Arch)-1 do 
  case Arch[i].pnt of
    1:for j:=0 to Length(ArchBasicSet)-1 do
      if Arch[i].num=ArchBasicSet[j].addr then
      begin
        if ArchBasicSet[j].name<Length(dyn_all)then
        sgTable.Cells[col,0]:=dyn_all[ArchBasicSet[j].name];
        if (Arch[i].offset=4)or(Arch[i].offset=6)then
        sgTable.Cells[col,0]:=sgTable.Cells[col,0]+name_expand[Arch[i].offset];
        sgTable.Cells[col,0]:=sgTable.Cells[col,0]+pnt_str[Arch[i].logn];
        if ArchBasicSet[j].units<Length(units_all_bis) then
        sgTable.Cells[col,1]:=units_all_bis[ArchBasicSet[j].units];col:=col+1;
        PRT.number_arc:=PRT.number_arc+1;Break;
      end;
    2:for j:=0 to Length(ArchExpandSet)-1 do
      if Arch[i].num=ArchExpandSet[j].addr then
      begin
        if ArchExpandSet[j].name<Length(dyn_all)then
        sgTable.Cells[col,0]:=dyn_all[ArchExpandSet[j].name];
        if (Arch[i].offset=4)or(Arch[i].offset=6)then
        sgTable.Cells[col,0]:=sgTable.Cells[col,0]+name_expand[Arch[i].offset];
        sgTable.Cells[col,0]:=sgTable.Cells[col,0]+' Доп';
        if ArchExpandSet[j].units<Length(units_all_bis) then
        sgTable.Cells[col,1]:=units_all_bis[ArchExpandSet[j].units];col:=col+1;
        PRT.number_arc:=PRT.number_arc+1;Break;
      end;
  end;
  sgTable.ColCount:=col;PRT.size_arc:=PRT.number_arc*4+7;
  sgTable.Width:=780;sgTable.Height:=441;row:=2;PRT.count_str:=0;
  bStep.Width:=sgTable.ColWidths[0];sgTable.ColWidths[1]:=109;
  sgTable.ScrollBars:=ssBoth;Top:=MainForm.Top+75;Left:=MainForm.Left+8;
  Autosize:=true;FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndEvents;
const str_evt:array[0..5]of string[30]=('№ зап.','Дата и время','Старое значение',
             'Новое значение','Параметр/список или действие','Идентификатор');
var i,j:byte;
begin
  ClearTable(sgTable);AutoScroll:=false;bStep.Visible:=true;
  sgTable.Visible:=true;sgTable.Height:=441;
  sgTable.FixedCols:=1;sgTable.Width:=771;
  sgTable.FixedColor:=$00D8E9EC;sgTable.Color:=clWindow;
  sgTable.Font.Style:=[];sgTable.Font.Size:=8;
  sgTable.FixedRows:=1;sgTable.ScrollBars:=ssVertical;
  sgTable.ColCount:=6;sgTable.RowCount:=2;row:=1;sgTable.DefaultRowHeight:=19;
  sgTable.DefaultColWidth:=155;sgTable.ColWidths[0]:=35;
  bStep.Height:=sgTable.RowHeights[0];bStep.Width:=sgTable.ColWidths[0];
  sgTable.ColWidths[1]:=109;sgTable.ColWidths[4]:=205;sgTable.ColWidths[5]:=85;
  for i:=0 to Length(str_evt)-1 do sgTable.Cells[i,0]:=str_evt[i];
  AutoSize:=true;FormForVariablesView.Top:=MainForm.Top+75;FormForVariablesView.Left:=MainForm.Left+15;
  FormForVariablesView.FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndAlarms;
const str_alm:array[0..4]of string[25]=('№ зап.','Дата и время',
                      'Установка/сброс','Значение','Тип аларма');
var i,j:byte;
begin
  ClearTable(sgTable);AutoScroll:=false;bStep.Visible:=true;
  sgTable.Visible:=true;sgTable.Height:=441;sgTable.Width:=641;
  sgTable.FixedCols:=1;sgTable.FixedColor:=$00D8E9EC;sgTable.Color:=clWindow;
  sgTable.Font.Style:=[];sgTable.Font.Size:=8;
  sgTable.FixedRows:=1;sgTable.ScrollBars:=ssVertical;
  sgTable.ColCount:=5;sgTable.RowCount:=2;row:=1;sgTable.DefaultRowHeight:=19;
  sgTable.DefaultColWidth:=130;sgTable.ColWidths[0]:=35;
  bStep.Height:=sgTable.RowHeights[0];bStep.Width:=sgTable.ColWidths[0];
  sgTable.ColWidths[1]:=109;sgTable.ColWidths[4]:=215;
  for i:=0 to Length(str_alm)-1 do sgTable.Cells[i,0]:=str_alm[i];
  AutoSize:=true;FormForVariablesView.Top:=MainForm.Top+75;FormForVariablesView.Left:=MainForm.Left+75;
  FormForVariablesView.FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndNst;
const str_nst:array[0..3]of string[25]=('№ зап.','Дата и время',
                      'Установка/сброс','Тип нештатной ситуации');
var i,j:byte;
begin
  ClearTable(sgTable);AutoScroll:=false;bStep.Visible:=true;
  sgTable.Visible:=true;sgTable.Height:=441;sgTable.Width:=641;
  sgTable.FixedCols:=1;sgTable.FixedColor:=$00D8E9EC;sgTable.Color:=clWindow;
  sgTable.Font.Style:=[];sgTable.Font.Size:=8;
  sgTable.FixedRows:=1;sgTable.ScrollBars:=ssVertical;
  sgTable.ColCount:=Length(str_nst);sgTable.RowCount:=2;
  row:=1;sgTable.DefaultRowHeight:=19;sgTable.DefaultColWidth:=130;
  sgTable.ColWidths[0]:=35;sgTable.ColWidths[3]:=321;
  bStep.Height:=sgTable.RowHeights[0];bStep.Width:=sgTable.ColWidths[0];
  for i:=0 to Length(str_nst)-1 do sgTable.Cells[i,0]:=str_nst[i];
  AutoSize:=true;FormForVariablesView.Top:=MainForm.Top+75;FormForVariablesView.Left:=MainForm.Left+75;
  FormForVariablesView.FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewArchiveMinute(number,size:byte);
var i,j,p:byte;val:single;
begin
  Pntr.minute:=recive[8];
  if recive[7]>0 then for i:=0 to recive[7]-1 do
  begin
    try
      sgTable.Cells[1,row]:=DateToStr(EncodeDate(recive[13+i*size]+2000,
          recive[14+i*size],recive[15+i*size]))+'  '+TimeToStr(EncodeTime
          (recive[16+i*size],recive[17+i*size],recive[18+i*size],0));
    except on EConvertError do;end;
    for j:=0 to number-1 do
    begin
      if MainForm.ConvToFloat(recive[19+i*size+j*4],recive[20+i*size+j*4],
                     recive[21+i*size+j*4],recive[22+i*size+j*4],val)then
      sgTable.Cells[j+2,row]:=FloatToStrF(val,ffGeneral,6,5);
    end;PRT.count_str:=PRT.count_str+1;
    sgTable.Cells[0,row]:=IntToStr(PRT.count_str);row:=row+1;
    Pntr.cnt_arch:=Pntr.cnt_arch+1;sgTable.RowCount:=sgTable.RowCount +1;
  end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewArchive(number,size:byte);
var i,j,p:byte;val:single;
begin
  Pntr.page:=recive[8];Pntr.archive:=recive[9]*256+recive[10];
//ShowMessage('страница: '+IntToStr(Pntr.page)+' указатель: '+IntToStr(Pntr.archive)+' конец: '+IntToStr(recive[11]));
  if recive[7]>0 then for i:=0 to recive[7]-1 do
  begin   //ShowMessage('');
    try
      sgTable.Cells[1,row]:=DateToStr(EncodeDate(recive[13+i*size]+2000,
          recive[14+i*size],recive[15+i*size]))+'  '+TimeToStr(EncodeTime
          (recive[16+i*size],recive[17+i*size],recive[18+i*size],0));
    except on EConvertError do;end;
    for j:=0 to number-1 do
    begin
      if MainForm.ConvToFloat(recive[19+i*size+j*4],recive[20+i*size+j*4],
                        recive[21+i*size+j*4],recive[22+i*size+j*4],val)then
      sgTable.Cells[j+2,row]:=FloatToStrF(val,ffGeneral,6,5);
    end;PRT.count_str:=PRT.count_str+1;
    sgTable.Cells[0,row]:=IntToStr(PRT.count_str);row:=row+1;
    Pntr.cnt_arch:=Pntr.cnt_arch+1;sgTable.RowCount:=sgTable.RowCount +1;
  end;if recive[11]=1 then PRT.flg_end:=true else PRT.flg_end:=false;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndMonutor;
const name_mtr:array[0..4]of string[25]=('Параметр/Номер списка','Первый',
   'Второй','Третий','Четвёртый');
var i,j,k:integer;s:string;
begin
  Caption:='Монитор параметров базовых списков';bStep.Visible:=false;
  AutoScroll:=false;
  if Length(Dyn)=0 then Exit;ClearTable(sgTable);sgTable.FixedColor:=$00D8E9EC;
  sgTable.ColCount:=Length(name_mtr);sgTable.RowCount:=Length(Dyn)+1;
  sgTable.DefaultColWidth:=101;sgTable.Color:=$00D8E9EC;sgTable.Height:=421;
  sgTable.ColWidths[0]:=201;sgTable.FixedCols:=1;sgTable.FixedRows:=1;j:=0;
  sgTable.ScrollBars:=ssVertical;
  for i:=0 to sgTable.ColCount-1 do
    begin j:=j+sgTable.ColWidths[i];sgTable.Cells[i,0]:=name_mtr[i];end;
  sgTable.Width:=j+25;
  for i:=0 to Length(Dyn)-1 do
  begin
    if Dyn[i].name<Length(dyn_all) then
    if Typ_task<>6 then
      s:=dyn_all[Dyn[i].name]+name_expand[Dyn[i].size] else
      s:=dyn_all[Dyn[i].name]+name_expand_oil[Dyn[i].size];
    if Dyn[i].units<=Length(units_all) then s:=s+units_all[Dyn[i].units];
    sgTable.Cells[0,i+1]:=s;
  end;AutoSize:=true;Top:=MainForm.Top+75;Left:=MainForm.Left+75;
  FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure IncrementTable(var col,row:integer);
begin
  row:=row+1;
  if row>=FormForVariablesView.sgTable.RowCount-1 then begin col:=col+1;row:=0;end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewWndMonutorExp;
const name_mtr:array[0..5]of string[25]=('Имя параметра','Значение',
   'Имя параметра','Значение','Имя параметра','Значение');
   num_col:array[0..2]of byte=(0,2,4);
var i,j,k,n:integer;s:string;
begin
  Caption:='Монитор дополнительного списка параметров ';
  if Length(DynExp)=0 then Exit; ClearTable(sgTable); bStep.Visible:=false;
  sgTable.FixedColor:=$00D8E9EC; j:=0; sgTable.ScrollBars:=ssVertical;
  sgTable.ColCount:=Length(name_mtr);
  for i:=0 to Length(DynExp)-1 do
  begin
    if DynExp[i].typ=2 then k:=DynExp[i].size else k:=1; j:=j+k;
  end; j:=Floor(j/3)+1; sgTable.RowCount:=j+1;
  sgTable.DefaultColWidth:=99; sgTable.Color:=$00D8E9EC;
  sgTable.FixedCols:=0; sgTable.FixedRows:=1; j:=0;
  for i:=0 to sgTable.ColCount-1 do
    begin j:=j+sgTable.ColWidths[i]; sgTable.Cells[i,0]:=name_mtr[i];end;
  sgTable.Width:=j+25; n:=0; k:=0;
  for i:=0 to Length(DynExp)-1 do
  begin
    if (DynExp[i].name<Length(dyn_all))and(DynExp[i].name>0)then
      s:=dyn_all[DynExp[i].name] else s:=IntToStr(i+1);
    if DynExp[i].typ=2 then for j:=0 to Length(name_expand)-1 do
    begin
      sgTable.Cells[num_col[k],n+1]:=s+name_expand[j];
      IncrementTable(k,n);
    end else if (DynExp[i].typ=1)or(DynExp[i].typ=3) then
    begin sgTable.Cells[num_col[k],n+1]:=s; IncrementTable(k,n);end else
    if DynExp[i].typ=4 then for j:=0 to 4 do
    begin
      sgTable.Cells[num_col[k],n+1]:=s+IntToStr(j+1);
      IncrementTable(k,n);
    end;
  end;Top:=MainForm.Top+75;Left:=MainForm.Left+75;FormStyle:=fsStayOnTop;Visible:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewMonutor;
var i:integer;
begin
  if Length(Disp)>0 then for i:=0 to Length(Disp)-1 do
  sgTable.Cells[Load.step+1,i+1]:=FloatToStrF(Disp[i],ffGeneral,6,5);
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewMonutorExp;
const num_col:array[0..2]of byte=(1,3,5);
var i,k,n:integer;
begin
  k:=0;n:=0;
  if Length(Disp)>0 then for i:=0 to Length(Disp)-1 do
  begin
    sgTable.Cells[num_col[k],n+1]:=FloatToStrF(Disp[i],ffGeneral,6,5);
    IncrementTable(k,n);
  end;
end;
//---------------------------------------------------//

function TFormForVariablesView.SetDotFloat(value:single):byte;
var dot:byte;
begin
  value:=Abs(value);
  if value<1 then dot:=6 else if value<10 then dot:=5 else
  if value<100 then dot:=4 else if value<1000 then dot:=3 else
  if value<10000 then dot:=2 else if value<1000000 then dot:=1 else
  if value>1000000 then dot:=0;Result:=dot;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewNst;
const typ_nst:array[0..1]of string[25]=('Ситуация прекратилась',
                                        'Ситуация установилась');
      num_nst:array[1..49]of string[60]=('EcoSonic #1 не отвечает на запросы',
      'EcoSonic #2 не отвечает на запросы','EcoSonic #3 не отвечает на запросы',
      'EcoSonic #4 не отвечает на запросы','Модуль В/В #1 не отвечает на запросы',
      'Модуль В/В #2 не отвечает на запросы','Модуль В/В #3 не отвечает на запросы',
      'Модуль В/В #4 не отвечает на запросы',
      'Терминал оператора не отвечает на запросы',

      'Диаметр трубопровода или СУ вне допуска, Базовый #1',
      'Состав газа или теплоноситель вне допуска, Базовый #1',
      'Давление, темпер. или рабочий расход вне допуска, Базовый #1',
      'Размер СУ вне допуска, Базовый #1',
      'Параметры среды за пределами метода, Базовый #1',
      ' ',' ',' ','Неверное переключение  дифманометров, Базовый #1',' ',

      'Диаметр трубопровода или СУ вне допуска, Базовый #2',
      'Состав газа или теплоноситель вне допуска, Базовый #2',
      'Давление, темпер. или рабочий расход вне допуска, Базовый #2',
      'Размер СУ вне допуска, Базовый #2',
      'Параметры среды за пределами метода, Базовый #2',
      ' ',' ',' ','Неверное переключение  дифманометров, Базовый #2',' ',

      'Диаметр трубопровода или СУ вне допуска, Базовый #3',
      'Состав газа или теплоноситель вне допуска, Базовый #3',
      'Давление, темпер. или рабочий расход вне допуска, Базовый #3',
      'Размер СУ вне допуска, Базовый #3',
      'Параметры среды за пределами метода, Базовый #3',
      ' ',' ',' ','Неверное переключение  дифманометров, Базовый #3',' ',

      'Диаметр трубопровода или СУ вне допуска, Базовый #4',
      'Состав газа или теплоноситель вне допуска, Базовый #4',
      'Давление, темпер. или рабочий расход вне допуска, Базовый #4',
      'Размер СУ вне допуска, Базовый #4',
      'Параметры среды за пределами метода, Базовый #4',
      ' ',' ',' ','Неверное переключение  дифманометров, Базовый #4',' ');
   num_nst_oil:array[1..17]of string[60]=(' ','Массомер не отвечает на запросы',
      ' ',' ','Модуль В/В #1 не отвечает на запросы',
      'Модуль В/В #2 не отвечает на запросы','Модуль В/В #3 не отвечает на запросы',
      'Модуль В/В #4 не отвечает на запросы',
      'Терминал оператора не отвечает на запросы',
      'Уставка плотности нефти вне допуска','Уставка плотности воды вне допуска',
      'Температура от массомера вне допуска','Плотность от массомера вне допуска',
      ' ',' ',' ',' ');
var i:byte;
begin
  Pntr.event:=recive[8]*256+recive[9];
  if recive[7]>0 then for i:=0 to recive[7]-1 do
  begin
    try
      sgTable.Cells[1,row]:=DateToStr(EncodeDate(recive[11+i*16]+2000,
                recive[12+i*16],recive[13+i*16]))+'  '+TimeToStr(EncodeTime
                (recive[14+i*16],recive[15+i*16],recive[16+i*16],0));
    except on EConvertError do end;
    if recive[11+i*16+10]<2 then
      sgTable.Cells[2,row]:=typ_nst[recive[11+i*16+10]];
    if PRT.typ_task<4 then
    begin
      if recive[11+i*16+13]<44 then
      sgTable.Cells[3,row]:=num_nst[recive[11+i*16+13]];
    end else if PRT.typ_task=6 then
    begin
      if recive[11+i*16+13]<20 then
      sgTable.Cells[3,row]:=num_nst_oil[recive[11+i*16+13]];
    end;
    PRT.count_str:=PRT.count_str+1;
    sgTable.Cells[0,row]:=IntToStr(PRT.count_str);row:=row+1;
    Pntr.cnt_event:=Pntr.cnt_event+1;sgTable.RowCount:=sgTable.RowCount+1;
  end;if recive[10]=1 then PRT.flg_end:=true else PRT.flg_end:=false;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewOnAlarm(buf:array of byte;sg:TStringGrid;ind,ofs:integer);
const typ_alm:array[0..1]of string[20]=('Аларм сброшен','Аларм установлен');
      str_pnt:array[0..23]of string[15]=(', Базовая #1',', Базовая #2',', Базовая #3',
                     ', Базовая #4',', EcoSonic #1',', EcoSonic #2',', EcoSonic #3',', EcoSonic #4',
                     ', AIN #1',', AIN #2',', AIN #3',', AIN #4',', AIN #5',
                     ', AIN #6',', AIN #7',', AIN #8',', AIN #9',', AIN #10',
                     ', AIN #11',', AIN #12',', AIN #13',', AIN #14',', AIN #15',
                     ', AIN #16');
      num_alm_ai:array[0..3]of string[25]=('Нижний (Lo)','Верхний (Hi)',
            'Ниже Нижнего (LoLo)','Выше Верхнего (HiHi)');
var val:single;str:string;
begin
  try
      sg.Cells[ofs,ind]:=DateToStr(EncodeDate(buf[0]+2000,buf[1],buf[2]))+'  '+
                            TimeToStr(EncodeTime(buf[3],buf[4],buf[5],0));
    except on EConvertError do end;
    if buf[10]<2 then sg.Cells[ofs+1,ind]:=typ_alm[buf[10]];
    MainForm.ConvToFloat(buf[6],buf[7],buf[8],buf[9],val);
    sg.Cells[ofs+2,ind]:=FloatToStrF(val,ffGeneral,6,5);
    if (buf[13]<8)and(buf[14]<Length(ind_prm_alm)) then
      str:=conf_all[ind_prm_alm[buf[14]]] else
    if (buf[13]>7)and(buf[13]<24)and(buf[14]<4)then str:=num_alm_ai[buf[14]];
    if buf[13]<24 then sg.Cells[ofs+3,ind]:=str+str_pnt[buf[13]];
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewAlarms;
var i,j:byte;buffer:array[0..size_event-1]of byte;
begin
  Pntr.event:=recive[8]*256+recive[9];
  if recive[7]>0 then for i:=0 to recive[7]-1 do
  begin
    for j:=0 to size_event-1 do buffer[j]:=recive[11+i*16+j];
    ViewOnAlarm(buffer,sgTable,row,1);
    PRT.count_str:=PRT.count_str+1;
    sgTable.Cells[0,row]:=IntToStr(PRT.count_str);row:=row+1;
    Pntr.cnt_event:=Pntr.cnt_event+1;sgTable.RowCount:=sgTable.RowCount+1;
  end;if recive[10]=1 then PRT.flg_end:=true else PRT.flg_end:=false;
end;
//---------------------------------------------------//

procedure ViewExpandEvent(num_pnt,ofs,ind:integer;Conf:array of TSetConfigPrm;
                          buffer:array of byte;sgTable:TstringGrid);
var j,k:integer;num,s:string;val:single;
begin
  j:=buffer[14];if j<Length(Conf) then
  case Conf[j].typ of
    4:
    begin
      MainForm.ConvToFloat(buffer[6],buffer[7],buffer[8],buffer[9],val);
      sgTable.Cells[ofs+1,ind]:=FloatToStrF(val,ffGeneral,6,5);
      MainForm.ConvToFloat(buffer[10],buffer[11],buffer[12],buffer[13],val);
      sgTable.Cells[ofs+2,ind]:=FloatToStrF(val,ffGeneral,6,5);
    end;
    12:
    begin
      if buffer[6]<Length(units_all_bis) then
      sgTable.Cells[ofs+1,ind]:=units_all_bis[buffer[6]];
      if buffer[10]<Length(units_all_bis) then
      sgTable.Cells[ofs+2,ind]:=units_all_bis[buffer[10]];
    end;
    14:if Conf[j].size>0 then
    begin
      s:='';for k:=0 to Conf[j].size-1 do s:=s+IntToStr(buffer[6+k])+'/';
      sgTable.Cells[ofs+1,ind]:=s;s:='';
      for k:=0 to Conf[j].size-1 do s:=s+IntToStr(buffer[10+k])+'/';
      sgTable.Cells[ofs+2,ind]:=s;
    end;
  end;
  if Conf[j].num<128 then num:=IntToStr(Conf[j].num)else num:='';
  if Conf[j].name<Length(conf_all) then
  sgTable.Cells[ofs+3,ind]:=conf_all[Conf[j].name]+num+str_pnt[num_pnt];
end;
//---------------------------------------------------//

procedure ViewConfigEvent(num_pnt,ofs,ind:integer;Conf:array of TSetConfigPrm;
                          Sel:array of TConfigSelect;buffer:array of byte;
                          sgTable:TStringGrid);
const
   str_baud:array[0..7]of string[6]=('1200','2400','4800','9600','19200',
                                     '38400','57600','115200');
   str_data:array[0..1]of string[3]=('/8','/7');
   str_stop:array[0..1]of string[3]=('/1','/2');
   str_parity:array[0..2]of string[6]=('/нет','/нечёт','/чёт');
   str_ta:array[0..7]of string[9]=('/150 мс','/250 мс','/350 мс','/500 мс',
          '/750 мс','/1000 мс','/1500 мс','/2500 мс');
   modbus_sel:array[0..3]of string[10]=('Отключен','СОМ2','СОМ3','COM1');
   modbus_host:array[0..1]of string[10]=('/Host','/Slave');
   modbus_pool:array[0..1]of string[10]=('/ASCII','/RTU');
   modbus_delay:array[0..7]of string[10]=('/0','/1 сек','/3 сек','/5 сек',
                               '/10 сек','/30 сек','/60 сек','/5 мин');
var j,k,n:integer;s,num:string;str:string[3];str_val:string[1];val:single;
begin
  j:=buffer[14];if j<Length(Conf) then
  case Conf[j].typ of
    0,10:
    begin
      s:='';for k:=0 to 7 do
      s:=s+Char(buffer[6+k]);sgTable.Cells[ofs+2,ind]:=s;
    end;
    1:
    begin
      sgTable.Cells[ofs+1,ind]:=IntToStr(buffer[6]);
      sgTable.Cells[ofs+2,ind]:=IntToStr(buffer[10]);
    end;
    2:
    begin
      if Length(Sel)>0 then for k:=0 to Length(Sel)-1 do
      if (Sel[k].num=j)and(Length(Sel[k].selset)>0) then
      begin
        for n:=0 to Length(Sel[k].selset)-1 do
        if (n=buffer[6])and(Sel[k].selset[n]<Length(select_all))then
        sgTable.Cells[ofs+1,ind]:=select_all[Sel[k].selset[n]];
        for n:=0 to Length(Sel[k].selset)-1 do
        if (n=buffer[10])and(Sel[k].selset[n]<Length(select_all))then
        sgTable.Cells[ofs+2,ind]:=select_all[Sel[k].selset[n]];Break;
      end;
    end;
    3:
    begin
      if Length(Sel)>0 then for k:=0 to Length(Sel)-1 do
      if(Length(Sel[k].selset)>0)and(Length(Sel[k].selset)<8)and(Sel[k].num=j)then
      begin
        s:='';
        for n:=0 to Length(Sel[k].selset)-1 do
        if Sel[k].selset[n]<Length(select_all)then
        begin
          str:=select_all[Sel[k].selset[n]];
          if (buffer[6] and etl[n])>0 then
          str_val:='Y' else str_val:='N';s:=s+str+'-'+str_val+' ';
        end;sgTable.Cells[ofs+1,ind]:=s;s:='';
        for n:=0 to Length(Sel[k].selset)-1 do
        if Sel[k].selset[n]<Length(select_all)then
        begin
          str:=select_all[Sel[k].selset[n]];
          if (buffer[10] and etl[n])>0 then
          str_val:='Y' else str_val:='N';s:=s+str+'-'+str_val+' ';
        end;sgTable.Cells[ofs+2,ind]:=s;Break;
      end;
    end;
    4:
    begin
      MainForm.ConvToFloat(buffer[6],buffer[7],buffer[8],buffer[9],val);
      sgTable.Cells[ofs+1,ind]:=FloatToStrF(val,ffGeneral,6,5);
      MainForm.ConvToFloat(buffer[10],buffer[11],buffer[12],buffer[13],val);
      sgTable.Cells[ofs+2,ind]:=FloatToStrF(val,ffGeneral,6,5);
    end;
    5:
    begin
      sgTable.Cells[ofs+1,ind]:=IntToStr(buffer[7]*65536+
      buffer[8]*256+buffer[9]);sgTable.Cells[ofs+2,ind]:='*****';
    end;
    6:
    begin
      sgTable.Cells[ofs+1,ind]:=str_baud[buffer[6]and 15]+
        str_data[(buffer[6]and 16)shr 4]+str_stop[(buffer[6]and 32)shr 5]+
        str_parity[(buffer[6]and 192)shr 6]+str_ta[buffer[7]and 15];
      sgTable.Cells[ofs+2,ind]:=str_baud[buffer[10]and 15]+
        str_data[(buffer[10]and 16)shr 4]+str_stop[(buffer[10]and 32)shr 5]+
        str_parity[(buffer[10]and 192)shr 6]+str_ta[buffer[11]and 15];
    end;
    7:
    begin
      sgTable.Cells[ofs+1,ind]:=modbus_sel[(buffer[6]and 96)shr 5]+
         modbus_host[(buffer[6]and 16)shr 4]+
         modbus_pool[(buffer[6]and 8)shr 3]+modbus_delay[buffer[6]and 7];
      sgTable.Cells[ofs+2,ind]:=modbus_sel[(buffer[10]and 96)shr 5]+
         modbus_host[(buffer[10]and 16)shr 4]+
         modbus_pool[(buffer[10]and 8)shr 3]+modbus_delay[buffer[10]and 7];
    end;
    8:
    begin
      s:='';
      if buffer[6]=0 then sgTable.Cells[ofs+1,ind]:='Отключена'else
      begin
       for k:=0 to 3 do s:=s+IntToStr(buffer[6+k])+', ';
       sgTable.Cells[ofs+1,ind]:=s;
      end;s:='';
      if buffer[10]=0 then sgTable.Cells[ofs+2,ind]:='Отключена'else
      begin
       for k:=0 to 3 do s:=s+IntToStr(buffer[10+k])+', ';
       sgTable.Cells[ofs+2,ind]:=s;
      end;
    end;
    9:
    begin
      sgTable.Cells[ofs+1,ind]:=IntToStr(buffer[6]*256+buffer[7]);
      sgTable.Cells[ofs+2,ind]:=IntToStr(buffer[10]*256+buffer[11]);
    end;
  end;
  if Conf[j].num<128 then num:=IntToStr(Conf[j].num+1)else num:='';
  if Conf[j].name<Length(conf_all) then
  sgTable.Cells[ofs+3,ind]:=conf_all[Conf[j].name]+num+str_pnt[num_pnt];
end;
//---------------------------------------------------//

procedure ViewSetAlarmsMVS(buf_evt:array of byte;index:integer);
const name_prm:array[0..9]of string[25]=('Нижний аларм р.расх','Верхний аларм р.расх',
           'Гистерезис аларм р.расх','Нижний аларм давлен','Верхний аларм давлен',
           'Гистерезис аларм давлен','Нижний аларм темпер','Верхний аларм темпер',
           'Гистерезис аларм темпер','Разрешение/Запрет аларм');
      name_alm_enb:array[0..2]of string[5]=('Рр-д=','Давл=','Темп=');
var val:single;str:string;i,num_dev,num_prm:integer;
begin
  num_dev:=(buf_evt[14])and($f0) shr 4;num_prm:=buf_evt[14] and $f;
  if num_prm > 9 then Exit;
  if num_prm < 9 then
  begin
    MainForm.ConvToFloat(buf_evt[6],buf_evt[7],buf_evt[8],buf_evt[9],val);
    FormForVariablesView.sgTable.Cells[2,index]:=FloatToStrF(val,ffGeneral,6,5);
    MainForm.ConvToFloat(buf_evt[10],buf_evt[11],buf_evt[12],buf_evt[13],val);
    FormForVariablesView.sgTable.Cells[3,index]:=FloatToStrF(val,ffGeneral,6,5);
  end else if num_prm = 9 then
  begin
    str:='';for i:=0 to 2 do if (buf_evt[6])and(Floor(Power(2,i)))>0 then
    str:=str+' '+name_alm_enb[i]+'Y' else str:=str+' '+name_alm_enb[i]+'N';
    FormForVariablesView.sgTable.Cells[2,index]:=str;
    str:='';for i:=0 to 2 do if (buf_evt[10])and(Floor(Power(2,i)))>0 then
    str:=str+' '+name_alm_enb[i]+'Y' else str:=str+' '+name_alm_enb[i]+'N';
    FormForVariablesView.sgTable.Cells[3,index]:=str;
  end;
  FormForVariablesView.sgTable.Cells[4,index]:='EcoSonic #'+IntToStr(num_dev+1)+','+name_prm[num_prm];
end;
//---------------------------------------------------//

procedure ViewSetAlarmsAIN(buf_evt:array of byte;index:integer);
const name_prm:array[0..4]of string[25]=('Ниже нижнего','Нижний аларм',
           'Верхний аларм','Выше верхнего','Гистерезис аларм');
      name_dev:array[0..1]of string[10]=('первый','второй');
var val:single;str:string;i,num_dev,num_prm,num_chan:integer;
begin
  num_dev:=(buf_evt[14])and($c0) shr 4;num_prm:=buf_evt[14] and $3f;
  num_chan:=Floor(num_prm/5);
  if num_prm > 40 then Exit;
  if num_prm < 40 then
  begin
    MainForm.ConvToFloat(buf_evt[6],buf_evt[7],buf_evt[8],buf_evt[9],val);
    FormForVariablesView.sgTable.Cells[2,index]:=FloatToStrF(val,ffGeneral,6,5);
    MainForm.ConvToFloat(buf_evt[10],buf_evt[11],buf_evt[12],buf_evt[13],val);
    FormForVariablesView.sgTable.Cells[3,index]:=FloatToStrF(val,ffGeneral,6,5);
    FormForVariablesView.sgTable.Cells[4,index]:='AIN '+name_dev[num_dev]+','+'Канал #'+
      IntToStr(num_chan+1)+','+name_prm[num_prm-num_chan*5];
  end else if num_prm = 40 then
  begin
    str:='';for i:=0 to 7 do if (buf_evt[6])and(Floor(Power(2,i)))>0 then
    str:=str+' '+'Y' else str:=str+' '+'N';FormForVariablesView.sgTable.Cells[2,index]:=str;
    str:='';for i:=0 to 7 do if (buf_evt[10])and(Floor(Power(2,i)))>0 then
    str:=str+' '+'Y' else str:=str+' '+'N';FormForVariablesView.sgTable.Cells[3,index]:=str;
    FormForVariablesView.sgTable.Cells[4,index]:='AIN '+name_dev[num_dev]+','+
                                  'Разрешение/Запрет аларм';
  end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewOnEvent(buf:array of byte;sg:TStringGrid;ofs,ind:integer);
const
   str_time:array[0..3]of string[30]=('Питание отключено',
            'Коррекция времени/даты','Автопереход на летнее время',
            'Автопереход на зимнее время');
var num_list:integer;val:single;size:byte;
begin
  try
      sg.Cells[ofs,ind]:=DateToStr(EncodeDate(buf[0]+2000,
                buf[1],buf[2]))+'  '+TimeToStr(EncodeTime
                (buf[3],buf[4],buf[5],0));
    except on EConvertError do end;
    num_list:=(buf[15])and($f);
    case num_list of
    1,2,3,4:{ события по изменению конфигурации точки учёта }
    if (Length(ConfSet)>0)and(Length(Select)>0)then
      ViewConfigEvent(num_list,ofs,ind,ConfSet,Select,buf,sg);
    5: { события по изменению конфигурации дополн точки }
    if (Length(ConfSetExp)>0)then
      ViewExpandEvent(num_list,ofs,ind,ConfSetExp,buf,sg);
    7: {события связанные с изменением ICP }
    if (Length(ConfSetIcp)>0)then
        ViewExpandEvent(num_list,ofs,ind,ConfSetIcp,buf,sg);
    8: { события по изменению конфигурации контроллера }
    if (Length(MainSet)>0)and(Length(SelMain)>0)then
        ViewConfigEvent(num_list,ofs,ind,MainSet,SelMain,buf,sg);
    9:begin { события связанные с откл.питания и коорекцией часов }
        try
          sg.Cells[ofs+2,ind]:=DateToStr(EncodeDate(buf[6]+
            2000,buf[7],buf[8]))+'  '+TimeToStr(EncodeTime
            (buf[9],buf[10],buf[11],0));
        except on EConvertError do ; end;
        if buf[14]<Length(str_time) then sg.Cells[ofs+3,ind]:=str_time[buf[14]];
      end;
   10:begin {события связанные со сбросом счётчиков }
        MainForm.ConvToFloat(buf[6],buf[7],buf[8],buf[9],val);
        sg.Cells[ofs+1,ind]:=FloatToStrF(val,ffGeneral,6,5);
        sg.Cells[ofs+2,ind]:='0';
        if buf[14]<Length(Dyn)then
        if Dyn[buf[14]].name<Length(dyn_all)then
        begin
          sg.Cells[ofs+3,ind]:=dyn_all[Dyn[buf[14]].name];
          if Typ_task<>6 then size:=Length(name_expand) else
          size:=Length(name_expand_oil);
          if Dyn[buf[14]].size<size then
          if Typ_task<>6 then
          sg.Cells[ofs+3,ind]:=sg.Cells[ofs+3,ind]+
            name_expand[Dyn[buf[14]].size] else
          sg.Cells[ofs+3,ind]:=sg.Cells[ofs+3,ind]+
            name_expand_oil[Dyn[buf[14]].size];
          sg.Cells[ofs+3,ind]:=sg.Cells[ofs+3,ind]+str_pnt[buf[13]+1];
        end;
      end;
   11:ViewSetAlarmsMVS(buf,ind);{события связанные с изменением уставок алармов}
   12:ViewSetAlarmsAIN(buf,ind);{события связанные с изменением уставок алармов}
   13:{события связанные с изменением таблиц Modbus или скрипта}
      begin
        sg.Cells[ofs+1,ind]:='';sg.Cells[ofs+2,ind]:='';sg.Cells[ofs+3,ind]:='';
        if buf[14]<10 then sg.Cells[ofs+2,ind]:=str_func[buf[14]] else
        if buf[14]<13 then sg.Cells[ofs+2,ind]:=str_host[buf[14]-10] else
        if buf[14]=13 then sg.Cells[ofs+2,ind]:='Страница Шкал';
        if buf[14]<14 then sg.Cells[ofs+3,ind]:='Таблица Modbus' else
        if buf[14]=14 then sg.Cells[ofs+3,ind]:='Таблица Скрипта';
      end;
  end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ViewEvents;
var i,j,num_list,ind_ident:integer;buf:array[0..size_event-1]of byte;
begin
  Pntr.event:=recive[8]*256+recive[9];
  if recive[7]>0 then for i:=0 to recive[7]-1 do
  begin
    for j:=0 to size_event-1 do buf[j]:=recive[11+i*16+j];
    ind_ident:=(buf[15])and($f0);num_list:=(buf[15])and($f);
    ViewOnEvent(buf,sgTable,1,row);
    PRT.count_str:=PRT.count_str+1;
    sgTable.Cells[0,row]:=IntToStr(PRT.count_str);
    if num_list=9 then
    sgTable.Cells[5,row]:='' else if ind_ident=0 then
    sgTable.Cells[5,row]:='Коммуникации' else sgTable.Cells[5,row]:='Терминал';
    row:=row+1;
    Pntr.cnt_event:=Pntr.cnt_event+1;sgTable.RowCount:=sgTable.RowCount+1;
    if recive[10]=1 then PRT.flg_end:=true else PRT.flg_end:=false;
  end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.ClearTable(sg:TStringGrid);
var i,j:word;
begin
  for i:=0 to sg.ColCount-1 do for j:=0 to sg.RowCount-1 do sg.Cells[i,j]:=' ';
end;
//---------------------------------------------------//

procedure TFormForVariablesView.FormClose(Sender: TObject; var Action: TCloseAction);
begin MainForm.CloseAllWnd;end;
//---------------------------------------------------//

procedure TFormForVariablesView.sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if State=[gdSelected]then with sgTable do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (State=[gdFixed])and(ARow=0)and(ACol>1)and
     ((PRT.status=twHour)or(PRT.status=twDay)or(PRT.status=twMin)) then with sgTable do
  begin
    StrToStrings(Cells[ACol, ARow]);Canvas.FillRect(Rect);
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
  if PRT.flg_ver then
  begin
    if ARow=0 then
    begin
      if ACol=0 then sgTable.Canvas.Font.Size:=12
      else sgTable.Canvas.Font.Size:=16;
    end else sgTable.Canvas.Font.Size:=10;sgTable.Canvas.FillRect(Rect);
    sgTable.Canvas.TextOut(Rect.Left+6,Rect.Top+2,sgTable.Cells[ACol,ARow]);
  end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.bSaveClick(Sender: TObject);
var str:string;i,j:integer;
begin
  if MainForm.SaveDialog1.Execute then
  sFile:=MainForm.SaveDialog1.FileName else Exit;
  list:=TStringList.Create;str:='';
  try
    for j:=0 to sgTable.ColCount-1 do str:=str+sgTable.Cells[j,0]+' ';
    list.Add(str);
    for i:=1 to sgTable.RowCount-1 do
    begin
      str:='';
      for j:=0 to sgTable.ColCount-1 do str:=str+sgTable.Cells[j,i]+'    ';
      list.Add(str);
    end;List.SaveToFile(sFile);
  finally list.Free;end;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.FormCreate(Sender: TObject);
begin
  bStep:=TBitBtn.Create(FormForVariablesView);bStep.Parent:=FormForVariablesView;
  bStep.Glyph:=Image1.Picture.Bitmap;bStep.OnClick:=GoStep;bStep.Visible:=false;
  bStep.Hint:='Подгрузка более ранних архивных записей';bStep.ShowHint:=true;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.GoStep(Sender: TObject);
begin
  bStep.Enabled:=false;Pntr.cnt_arch:=0;Pntr.cnt_event:=0;
  case PRT.status of
    twHour: begin PRT.load_visible:=1;flg_cmd:=12;end;
    twDay:  begin PRT.load_visible:=2;flg_cmd:=12;end;
    twEvent:begin PRT.load_visible:=4;flg_cmd:=10;end;
    twAlarm:begin PRT.load_visible:=5;flg_cmd:=10;end;
    twNst:  begin PRT.load_visible:=6;flg_cmd:=10;end;
  end; PRT.flg_end:=false;
  MainForm.StatusBar.Panels.Items[0].Width:=MainForm.Width;cbStatus.Visible:=false;
end;
//---------------------------------------------------//

procedure TFormForVariablesView.FormResize(Sender: TObject);
begin
  bStep.Left:=sgTable.Left;bStep.Top:=sgTable.Top;
end;
//---------------------------------------------------//

end.
