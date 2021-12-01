unit ModbusSetting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, ExtCtrls, Math;

type
  TFormModbusSetting = class(TForm)
    pTable: TPanel;
    Label1: TLabel;
    cbSelFunc: TComboBox;
    sgTable: TStringGrid;
    BitBtn1: TBitBtn;
    imCheckYes: TImage;
    imCheckNo: TImage;
    sgTableHost: TStringGrid;
    pScale: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    sgScale: TStringGrid;
    bSetModbus: TBitBtn;
    pHostStatus: TPanel;
    sgStatus: TStringGrid;
    bOpen: TBitBtn;
    bSave: TBitBtn;
    procedure sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure cbSelFuncChange(Sender: TObject);
    procedure bSetModbusClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgTableSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure eScale1LoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgTableHostDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgTableHostSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgScaleDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgScaleSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgStatusDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bOpenClick(Sender: TObject);
    procedure bSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure GoExecute(Sender: TObject);
    procedure GoEditExecute;
    procedure GoKeyPressExecute(Sender: TObject; var Key: Char);
  public
    procedure ViewWndModbusFunc;
    procedure ViewWndModbusHost;
    procedure ViewWndModbusScale;
    procedure ViewWndModbusStatus;
    function GetEnableModbusFunc(select:integer):boolean;
    function GetEnableModbusHost:boolean;
    { Public declarations }
  end;

var
  FormModbusSetting: TFormModbusSetting;cbStruct:TComboBox;eStruct:TEdit;
  current_status:array[0..29]of byte;
implementation

{$R *.DFM}
uses Main, FormForView;

const 
  sel_func:array[0..9]of byte=(0,1,2,2,3,3,4,5,6,7);

  conv_slave:array[0..12]of string[25]=('Без преобразования',
    'Веществ в Целое, Шкала 1','Веществ в Целое, Шкала 2','Веществ в Целое, Шкала 3',
    'Веществ в Целое, Шкала 4','Веществ в Целое, Шкала 5','Веществ в Целое, Шкала 6',
    'Веществ в Целое, Шкала 7','Веществ в Целое, Шкала 8',
    'Веществ мл.часть в Целое','Веществ ст.часть в Целое',
    'Длинное мл.часть в Целое','Длинное ст.часть в Целое');

   conv_host:array[0..12]of string[25]=('Без преобразования',
    'Целое в Веществ Шкала 1','Целое в Веществ Шкала 2','Целое в Веществ Шкала 3',
    'Целое в Веществ Шкала 4','Целое в Веществ Шкала 5','Целое в Веществ Шкала 6',
    'Целое в Веществ Шкала 7','Целое в Веществ Шкала 8',
    'Целое в Веществ мл.часть','Целое в Веществ ст.часть',
    'Целое в Длинное мл.часть','Целое в Длинное ст.часть');

var tab_col,tab_row,top_row:integer;val_param:array of byte;
    flag_view:TComponentView;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure TFormModbusSetting.GoKeyPressExecute(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then begin GoEditExecute;bSetModbus.Enabled:=true;Exit;end;
  if not (Key in ['0'..'9','-',smb_del])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.GoEditExecute;
var flag:boolean;value:word;val_float:single;
begin
  flag:=false;
  case PRT.status of
  twModbusFunc:
  begin
    try ModbusFunc[tab_row-1].addr:=StrToInt(eStruct.Text);
    except on EConvertError do flag:=true;
    end;
    if flag=false then sgTable.Cells[tab_col,tab_row]:=eStruct.Text;
  end;
  twModbusHost:
  begin
    try value:=StrToInt(eStruct.Text);
    except on EConvertError do flag:=true;
    end;
    if flag=false then
    begin
      sgTableHost.Cells[tab_col,tab_row]:=eStruct.Text;
      case tab_col of
        1:ModbusHost[tab_row-1].addr:=value;
        2:ModbusHost[tab_row-1].func:=value;
        3:ModbusHost[tab_row-1].reg:=value;
        4:ModbusHost[tab_row-1].new:=value;
        5:ModbusHost[tab_row-1].count:=value;
      end;
    end;
  end;
  twModbusScale:
  begin
    try val_float:=StrToFloat(eStruct.Text);
    except on EConvertError do flag:=true;
    end;
    if flag=false then
    begin
      sgScale.Cells[tab_col,tab_row]:=eStruct.Text;
      case tab_col of
        1:ModbusScale[tab_row-1].lo_val:=val_float;
        2:ModbusScale[tab_row-1].hi_val:=val_float;
      end;
      BitBtn2.Enabled:=true;
    end;
  end;
  end;
  if flag then ShowMessage('Неправильный ввод числа!');
  eStruct.Visible:=false;
  flag_view:=cvOff;
end;
//---------------------------------------------------//

function TFormModbusSetting.GetEnableModbusHost:boolean;
var flag:boolean;i:integer;
begin
  flag:=false;
  if Length(Dyn)>0 then for i:=0 to Length(Dyn)-1 do
  if (Dyn[i].modbus)>=128 then begin flag:=true;Break;end;
  if Length(DynExp)>0 then for i:=0 to Length(DynExp)-1 do
  if (DynExp[i].modbus)>=128 then begin flag:=true;Break;end;
  Result:=flag;
end;
//---------------------------------------------------//

function TFormModbusSetting.GetEnableModbusFunc(select:integer):boolean;
var i:integer;flag:boolean;
begin
  flag:=false;
  if Length(Dyn)>0 then for i:=0 to Length(Dyn)-1 do
  begin
    if ModbusConf.mode=0 then if (Dyn[i].modbus and 128)>0 then
    if (Dyn[i].modbus and 31)=select then begin flag:=true;Break;end;
    if ModbusConf.mode=1 then
    if (Dyn[i].modbus and 64)>0 then
    if (Dyn[i].modbus and 31)=select then begin flag:=true;Break;end;
  end;
  if Length(DynExp)>0 then for i:=0 to Length(DynExp)-1 do
  begin
    if ModbusConf.mode=0 then if (DynExp[i].modbus and 128)>0 then
    if (DynExp[i].modbus and 31)=select then begin flag:=true;Break;end;
    if ModbusConf.mode=1 then
    if (DynExp[i].modbus and 64)>0 then
    if (DynExp[i].modbus and 31)=select then begin flag:=true;Break;end;
  end;Result:=flag;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.ViewWndModbusFunc;
const str_modbus:array[0..5]of string[20]=('№ зап.','Адрес регистра',
      'Номер точки','Логический','Номер параметра','Способ преобраз.');
var i:byte;
begin
  flag_view:=cvOff;
  sgTableHost.Visible:=false;
  sgTable.Visible:=true;
  cbSelFunc.Clear;
  FormForVariablesView.ClearTable(sgTable);
  cbSelFunc.Visible:=true;
  for i:=0 to Length(str_func)-1 do cbSelFunc.Items.Add(str_func[i]);
  Label1.Caption:='Функция';
  Label1.Visible:=true;
  pScale.Visible:=false;
  sgTable.ColCount:=Length(str_modbus);
  sgTable.RowCount:=41;
  row:=1;
  sgTable.DefaultRowHeight:=19;
  sgTable.DefaultColWidth:=101;
  sgTable.ColWidths[0]:=41;
  sgTable.ColWidths[3]:=85;
  sgTable.ColWidths[4]:=171;
  sgTable.ColWidths[5]:=191;
  pHostStatus.Visible:=false;
  cbSelFunc.ItemIndex:=0;
  pTable.Height:=520;
  sgTable.Height:=480;
  pTable.Visible:=true;
  for i:=0 to Length(str_modbus)-1 do sgTable.Cells[i,0]:=str_modbus[i];
  for i:=1 to sgTable.RowCount-1 do sgTable.Cells[0,i]:=IntToStr(i);
  AutoSize:=true;
  Top:=MainForm.Top+95;
  Left:=MainForm.Left+25;
  FormStyle:=fsStayOnTop;
  bSetModbus.Enabled:=false;
  Visible:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.ViewWndModbusHost;
const str_modbus:array[0..6]of string[20]=('№ зап.','Адрес устройства',
        'Номер функции','Начальный адрес','Переадресация','Число регистров',
        'Статус');
var i:byte;
begin
  cbSelFunc.Clear;
  FormForVariablesView.ClearTable(sgTableHost);
  cbSelFunc.Visible:=true;
  cbSelFunc.Items.Add(str_host[0]);
  flag_view:=cvOff;
  pTable.Visible:=true;
  sgTable.Visible:=false;
  pScale.Visible:=false;
  pHostStatus.Visible:=false;
  Label1.Caption:='Страница';
  sgTableHost.Visible:=true;
  Label1.Visible:=true;
  sgTableHost.ColCount:=Length(str_modbus);
  sgTableHost.RowCount:=31;
  row:=1;
  sgTableHost.DefaultRowHeight:=19;
  sgTableHost.DefaultColWidth:=95;
  sgTableHost.ColWidths[0]:=41;
  cbSelFunc.ItemIndex:=0;
  pTable.Height:=520;
  sgTableHost.Height:=480;
  sgTableHost.ColWidths[6]:=81;
  for i:=0 to Length(str_modbus)-1 do sgTableHost.Cells[i,0]:=str_modbus[i];
  for i:=1 to sgTableHost.RowCount-1 do sgTableHost.Cells[0,i]:=IntToStr(i);
  AutoSize:=true;
  Top:=MainForm.Top+95;
  Left:=MainForm.Left+25;
  FormStyle:=fsStayOnTop;
  bSetModbus.Enabled:=false;
  Visible:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.ViewWndModbusScale;
const str_modbus:array[0..2]of string[20]=('Номер шкалы','Нижнее значение',
        'Верхнее значение');
var i:byte;
begin
  FormForVariablesView.ClearTable(sgScale);
  flag_view:=cvOff;
  pTable.Visible:=false;
  sgScale.ColCount:=Length(str_modbus);
  sgScale.RowCount:=9;
  row:=1;
  BitBtn2.Enabled:=false;
  pHostStatus.Visible:=false;
  sgScale.DefaultRowHeight:=19;
  sgScale.DefaultColWidth:=101;
  for i:=0 to Length(str_modbus)-1 do sgScale.Cells[i,0]:=str_modbus[i];
  for i:=1 to sgScale.RowCount-1 do sgScale.Cells[0,i]:=IntToStr(i);
  pScale.Visible:=true;
  FormStyle:=fsStayOnTop;
  bSetModbus.Enabled:=false;
  AutoSize:=true;
  Top:=MainForm.Top+95;
  Left:=MainForm.Left+25;
  Visible:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.ViewWndModbusStatus;
const str_modbus:array[0..1]of string[20]=('№ запроса','Статус запроса');
var i:byte;
begin
  pTable.Visible:=false;
  pScale.Visible:=false;
  pHostStatus.Visible:=true;
  sgStatus.ColWidths[0]:=61;
  sgStatus.ColWidths[1]:=209;
  for i:=0 to Length(str_modbus)-1 do sgStatus.Cells[i,0]:=str_modbus[i];
  for i:=1 to sgStatus.RowCount-1 do sgStatus.Cells[0,i]:=IntToStr(i);
  FormStyle:=fsStayOnTop;
  AutoSize:=true;
  Top:=MainForm.Top+95;
  Left:=MainForm.Left+25;
  Visible:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;i:byte;
begin
  if sgTable.TopRow<>top_row then
  begin
    flag_view:=cvOff;cbStruct.Visible:=false;eStruct.Visible:=false;
  end;
  if State=[gdSelected]then with sgTable do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvSelect)and(tab_col=ACol)and(tab_row=ARow)and
     (PRT.status=twModbusFunc)then
  begin
    cbStruct.Left:=pTable.Left+sgTable.Left+Rect.Left+2;
    cbStruct.Top:=pTable.Top+sgTable.Top+Rect.Top+2;
  end;
  if (flag_view=cvEdit)and(tab_col=ACol)and(tab_row=ARow) then
  begin
    eStruct.Left:=pTable.Left+sgTable.Left+Rect.Left+2;
    eStruct.Top:=pTable.Top+sgTable.Top+Rect.Top+2;
  end;
  if (PRT.status=twModbusHost)and(ACol=6)then with (Sender as TStringGrid)do
  with Canvas do for i:=0 to Length(check)-1 do if ARow=(i+1)then if check[i]then
  Draw(Rect.Left+11,Rect.Top+3,imCheckYes.Picture.Bitmap) else
  Draw(Rect.Left+11,Rect.Top+3,imCheckNo.Picture.Bitmap);
end;
//---------------------------------------------------//

procedure TFormModbusSetting.cbSelFuncChange(Sender: TObject);
begin
  if (cbSelFunc.ItemIndex>=0)and(PRT.status=twModbusFunc)and
     (GetEnableModbusFunc(sel_func[cbSelFunc.ItemIndex])=false) then
  begin
    cbSelFunc.ItemIndex:=ModbusConf.select;
    ShowMessage('Функция не используется!');Exit;
  end;
  cbStruct.Visible:=false;ModbusConf.select:=cbSelFunc.ItemIndex;
  flg_cmd:=30;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.bSetModbusClick(Sender: TObject);
begin
  bSetModbus.Enabled:=false;flag_view:=cvOff;BitBtn2.Enabled:=false;
  flg_cmd:=21;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.BitBtn1Click(Sender: TObject);
var i,j:byte;
begin
  case PRT.status of
    twModbusFunc:
    begin
      for i:=1 to sgTable.RowCount-1 do  for j:=1 to sgTable.ColCount-1 do
      sgTable.Cells[j,i]:='0';
      if Length(ModbusFunc)>0 then for i:=0 to Length(ModbusFunc)-1 do
      begin
        ModbusFunc[i].addr:=0;ModbusFunc[i].pnt:=0;ModbusFunc[i].logn:=0;
        ModbusFunc[i].prm:=0;ModbusFunc[i].conv:=0;
      end;
    end;
    twModbusHost:
    begin
      for i:=1 to sgTableHost.RowCount-1 do
        for j:=1 to sgTableHost.ColCount-1 do sgTableHost.Cells[j,i]:='0';
      if Length(ModbusHost)>0 then for i:=0 to Length(ModbusHost)-1 do
      begin
        ModbusHost[i].reg:=0;ModbusHost[i].new:=0;ModbusHost[i].addr:=0;
        ModbusHost[i].func:=0;ModbusHost[i].count:=0;
      end;
    end;
    twModbusScale:
    begin
      for i:=1 to sgScale.RowCount-1 do
        for j:=1 to sgScale.ColCount-1 do sgScale.Cells[j,i]:='0';
      if Length(ModbusScale)>0 then for i:=0 to Length(ModbusScale)-1 do
      begin ModbusScale[i].lo_val:=0;ModbusScale[i].hi_val:=0;end;
    end;
  end;bSetModbus.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.FormCreate(Sender: TObject);
begin
  cbStruct:=TComboBox.Create(FormModbusSetting);cbStruct.Parent:=FormModbusSetting;
  cbStruct.Visible:=false;cbStruct.OnChange:=GoExecute;
  cbStruct.Color:=$00D8E9EC;cbStruct.Font.Color:=clBlue;
  cbStruct.Font.Style:=[fsBold];
  eStruct:=TEdit.Create(FormModbusSetting);eStruct.Parent:=FormModbusSetting;eStruct.Visible:=false;
  eStruct.Font.Color:=clBlue;eStruct.Font.Style:=[fsBold];
  eStruct.OnKeyPress:=GoKeyPressExecute;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.GoExecute(Sender: TObject);
begin
  case tab_col of
  2:begin
      ModbusFunc[tab_row-1].pnt:=cbStruct.ItemIndex;
      sgTable.Cells[tab_col,tab_row]:=IntToStr(cbStruct.ItemIndex);
    end;
  3:begin
      ModbusFunc[tab_row-1].logn:=cbStruct.ItemIndex;
      sgTable.Cells[tab_col,tab_row]:=IntToStr(cbStruct.ItemIndex);
    end;
  4:if Length(val_param)>0 then
    begin
      ModbusFunc[tab_row-1].prm:=val_param[cbStruct.ItemIndex];
      sgTable.Cells[tab_col,tab_row]:=IntToStr(val_param[cbStruct.ItemIndex]);
    end;
  5:begin
      if ModbusConf.mode=0 then
      begin
        ModbusFunc[tab_row-1].conv:=cbStruct.ItemIndex;
        sgTable.Cells[tab_col,tab_row]:=IntToStr(cbStruct.ItemIndex);
      end else
      begin
        ModbusFunc[tab_row-1].conv:=cbStruct.ItemIndex+20;
        sgTable.Cells[tab_col,tab_row]:=IntToStr(cbStruct.ItemIndex+20);
      end;
    end;
  end;bSetModbus.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgTableSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var i,j,num_pnt,size:byte;s:string;
begin
  top_row:=sgTable.TopRow;
  if PRT.status=twModbusFunc then
  begin
    cbStruct.Clear;
    case ACol of
      1:begin
          eStruct.Text:=sgTable.Cells[ACol, ARow];
          eStruct.Height:=sgTable.RowHeights[Arow];tab_row:=Arow;
          eStruct.Width:=sgTable.ColWidths[Acol];eStruct.Visible:=true;
          tab_col:=Acol;flag_view:=cvEdit;cbStruct.Visible:=false;
          eStruct.SetFocus;
        end;
      2:begin
          for i:=0 to Length(sel_pnt)-1 do cbStruct.Items.Add(sel_pnt[i]);
          cbStruct.ItemIndex:=ModbusFunc[ARow-1].pnt;flag_view:=cvSelect;
        end;
      3:begin
          for i:=0 to Length(log_pnt)-1 do cbStruct.Items.Add(log_pnt[i]);
          cbStruct.ItemIndex:=ModbusFunc[ARow-1].logn;flag_view:=cvSelect;
        end;
      4:begin
          if (ModbusFunc[ARow-1].pnt=1)and(Length(Dyn)>0)then
          begin
            for i:=0 to Length(Dyn)-1 do
            if ((ModbusConf.mode=0)and((Dyn[i].modbus and 128)>0))or
               ((ModbusConf.mode=1)and((Dyn[i].modbus and 64)>0))then
            if (Dyn[i].modbus and 31)=sel_func[cbSelFunc.ItemIndex]then
            begin
              if Dyn[i].name<Length(dyn_all)then s:=dyn_all[Dyn[i].name];
              if Typ_task<>6 then size:=Length(name_expand) else
                  size:=Length(name_expand_oil);
              if Dyn[i].size<size then if Typ_task<>6 then
              s:=s+name_expand[Dyn[i].size]else s:=s+name_expand_oil[Dyn[i].size];
              cbStruct.Items.Add(s);
              SetLength(val_param,cbStruct.Items.Count);
              val_param[cbStruct.Items.Count-1]:=Dyn[i].addr+Dyn[i].size;
            end;flag_view:=cvSelect;
          end;
          if (ModbusFunc[ARow-1].pnt=2)and(Length(DynExp)>0)then
          begin
            for i:=0 to Length(DynExp)-1 do
            if ((ModbusConf.mode=0)and((DynExp[i].modbus and 128)>0))or
               ((ModbusConf.mode=1)and((DynExp[i].modbus and 64)>0))then
            if ((DynExp[i].modbus and 31)=sel_func[cbSelFunc.ItemIndex])or
                ((DynExp[i].modbus and 31)=7)then
            begin
              if (DynExp[i].name<Length(dyn_all))and(DynExp[i].name>0)then
              s:=dyn_all[DynExp[i].name] else s:=IntToStr(i+1);
              if DynExp[i].typ=2 then for j:=0 to Length(name_expand)-1 do
              begin  {накопленные до 7 чисел}
                cbStruct.Items.Add(s+name_expand[j]);
                SetLength(val_param,cbStruct.Items.Count);
                val_param[cbStruct.Items.Count-1]:=DynExp[i].addr+j;
              end else {буфер=5,10,20 чисел}
              if (DynExp[i].typ=4)or(DynExp[i].typ=5)or(DynExp[i].typ=6) then
              for j:=0 to DynExp[i].size-1 do
              begin
                cbStruct.Items.Add(s+IntToStr(j+1));
                SetLength(val_param,cbStruct.Items.Count);
                val_param[cbStruct.Items.Count-1]:=DynExp[i].addr+j;
              end else
              begin {одиночные или усреднённые}
                cbStruct.Items.Add(s);SetLength(val_param,cbStruct.Items.Count);
                val_param[cbStruct.Items.Count-1]:=DynExp[i].addr;
              end;
            end;
          end;
          if ModbusFunc[ARow-1].pnt=3 then
          begin
            for i:=0 to Length(prm_dt)-1 do cbStruct.Items.Add(prm_dt[i]);
            cbStruct.ItemIndex:=ModbusFunc[ARow-1].prm; flag_view:=cvSelect;
            SetLength(val_param,cbStruct.Items.Count);
            for i:=0 to Length(val_param)-1 do val_param[i]:=i;
          end;
          if Length(val_param)>0 then for i:=0 to cbStruct.Items.Count-1 do
          if val_param[i]=ModbusFunc[ARow-1].prm then
          begin cbStruct.ItemIndex:=i;Break;end;flag_view:=cvSelect;
        end;
      5:begin
          if ModbusConf.mode=0 then for i:=0 to Length(conv_host)-1 do
          begin
            cbStruct.Items.Add(conv_host[i]);
            cbStruct.ItemIndex:=ModbusFunc[ARow-1].conv;
          end;
          if ModbusConf.mode=1 then for i:=0 to Length(conv_slave)-1 do
          begin
            cbStruct.Items.Add(conv_slave[i]);
            cbStruct.ItemIndex:=ModbusFunc[ARow-1].conv-20;
          end;flag_view:=cvSelect;
        end;
      end;
  end;
  if flag_view=cvSelect then
  begin
    tab_col:=ACol;tab_row:=ARow;eStruct.Visible:=false;
    cbStruct.Height:=sgTable.RowHeights[ARow];
    cbStruct.Width:=sgTable.ColWidths[ACol];cbStruct.Visible:=true;
  end;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.eScale1LoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',smb_del,Char(8),'-']) then Key:=#0;bSetModbus.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin MainForm.CloseAllWnd;end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgTableHostDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;i:byte;
begin
  if sgTableHost.TopRow<>top_row then
  begin
    flag_view:=cvOff;cbStruct.Visible:=false;eStruct.Visible:=false;
  end;
  if State=[gdSelected]then with sgTableHost do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvEdit)and(tab_col=ACol)and(tab_row=ARow) then
  begin
    eStruct.Left:=pTable.Left+sgTable.Left+Rect.Left+2;
    eStruct.Top:=pTable.Top+sgTable.Top+Rect.Top+2;
  end;
  if (PRT.status=twModbusHost)and(ACol=6)then with (Sender as TStringGrid)do
  with Canvas do for i:=0 to Length(check)-1 do if ARow=(i+1)then if check[i]then
  Draw(Rect.Left+11,Rect.Top+3,imCheckYes.Picture.Bitmap) else
  Draw(Rect.Left+11,Rect.Top+3,imCheckNo.Picture.Bitmap);
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgTableHostSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  top_row:=sgTableHost.TopRow;
  if PRT.status=twModbusHost then
  begin
    if ACol=6 then
    begin
      check[ARow-1]:=not check[ARow-1];
      if check[ARow-1] then
      ModbusHost[ARow-1].status:=(ModbusHost[ARow-1].status and $7f)+$80 else
      ModbusHost[ARow-1].status:=ModbusHost[ARow-1].status and $7f;
    end else
    begin
      eStruct.Text:=sgTableHost.Cells[ACol, ARow];
      eStruct.Height:=sgTableHost.RowHeights[Arow];tab_row:=Arow;
      eStruct.Width:=sgTableHost.ColWidths[Acol];eStruct.Visible:=true;
      tab_col:=Acol;flag_view:=cvEdit;cbStruct.Visible:=false;
      eStruct.SetFocus;
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgScaleDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;i:byte;
begin
  if sgScale.TopRow<>top_row then
  begin
    flag_view:=cvOff;cbStruct.Visible:=false;eStruct.Visible:=false;
  end;
  if State=[gdSelected]then with sgScale do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvEdit)and(tab_col=ACol)and(tab_row=ARow) then
  begin
    eStruct.Left:=pScale.Left+sgScale.Left+Rect.Left+2;
    eStruct.Top:=pScale.Top+sgScale.Top+Rect.Top+2;
  end;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgScaleSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  top_row:=sgScale.TopRow;
  if PRT.status=twModbusScale then
  begin
    eStruct.Text:=sgScale.Cells[ACol, ARow];
    eStruct.Height:=sgScale.RowHeights[Arow];tab_row:=Arow;
    eStruct.Width:=sgScale.ColWidths[Acol];eStruct.Visible:=true;
    tab_col:=Acol;flag_view:=cvEdit;cbStruct.Visible:=false;
    eStruct.SetFocus;
  end; 
end;
//---------------------------------------------------//

procedure TFormModbusSetting.sgStatusDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var i:integer;str:string;
begin
  with sgStatus do if (ARow > 0)and(ACol > 0) then
  begin
    Canvas.Brush.Color:=Brush.Color;str:=Cells[ACol,ARow];
    Canvas.FillRect(Rect);
    if current_status[ARow-1]=0 then Canvas.Font.Color:=clBlack else
    if current_status[ARow-1]=128 then Canvas.Font.Color:=clBlue else
    if current_status[ARow-1]>128 then Canvas.Font.Color:=clRed;
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end else Canvas.Font.Color:=clBlack;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.bOpenClick(Sender: TObject);
var i,flg_res,k:integer; file_name:string; f_modbus:file of byte;
    buf_data:array of byte;
begin
  with MainForm do
  begin
    OpenDialog1.Title:='Укажите имя файла таблицы Modbus';
    OpenDialog1.FilterIndex:=5; OpenDialog1.DefaultExt:='msf';
    if OpenDialog1.Execute then
    begin
      file_name:=OpenDialog1.FileName; AssignFile(f_modbus,file_name);{$I-}
      Reset(f_modbus);{$I+} flg_res:=IOResult;
      if flg_res<>0 then
      begin ShowMessage('Указанный файл не найден!');Exit;end; k:=0;
      while Eof(f_modbus)=false do
      begin SetLength(buf_data,k+1); Read(f_modbus,buf_data[k]); k:=k+1;end;
      k:=Floor((Length(buf_data)-2)/6);
      if k>0 then if (buf_data[0]=Typ_task)and(buf_data[1]=cbSelFunc.ItemIndex)then
      begin
        SetLength(ModbusFunc,40);
        for i:=0 to Length(ModbusFunc)-1 do
        begin
          ModbusFunc[i].addr:=buf_data[2+i*6]*256+buf_data[3+i*6];
          ModbusFunc[i].pnt:=buf_data[4+i*6]; ModbusFunc[i].logn:=buf_data[5+i*6];
          ModbusFunc[i].prm:=buf_data[6+i*6]; ModbusFunc[i].conv:=buf_data[7+i*6];
                    sgTable.Cells[1,i+1]:=IntToStr(ModbusFunc[i].addr);
          sgTable.Cells[2,i+1]:=IntToStr(ModbusFunc[i].pnt);
          sgTable.Cells[3,i+1]:=IntToStr(ModbusFunc[i].logn);
          sgTable.Cells[4,i+1]:=IntToStr(ModbusFunc[i].prm);
          sgTable.Cells[5,i+1]:=IntToStr(ModbusFunc[i].conv);
        end; bSetModbus.Enabled:=true;
      end else ShowMessage('Тип задачи или номер таблицы не совпадают!');
      CloseFile(f_modbus);
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormModbusSetting.bSaveClick(Sender: TObject);
var i,flg_res:integer; name_file:string; buf_data:array of byte;
    f_modbus:file of byte;
begin   {Сохранение содержимого таблицы функций в файле}
  if Length(ModbusFunc)>0 then with MainForm do
  begin
    SaveDialog1.Title:='Укажите имя файла страницы Modbus';
    SaveDialog1.FilterIndex:=4; SaveDialog1.DefaultExt:='msf';
    if SaveDialog1.Execute then
    begin
      name_file:=SaveDialog1.FileName; AssignFile(f_modbus,name_file);{$I-}
      Reset(f_modbus); {$I+} flg_res:=IOResult;
      if flg_res<>0 then Rewrite(f_modbus);
      SetLength(buf_data,2+Length(ModbusFunc)*6);
      buf_data[0]:=Typ_task; buf_data[1]:=cbSelFunc.ItemIndex;
      for i:=0 to Length(ModbusFunc)-1 do
      begin
        buf_data[2+i*6]:=Hi(ModbusFunc[i].addr);
        buf_data[3+i*6]:=Lo(ModbusFunc[i].addr);
        buf_data[4+i*6]:=ModbusFunc[i].pnt; buf_data[5+i*6]:=ModbusFunc[i].logn;
        buf_data[6+i*6]:=ModbusFunc[i].prm; buf_data[7+i*6]:=ModbusFunc[i].conv;
      end;
      for i:=0 to Length(buf_data)-1 do Write(f_modbus,buf_data[i]);
      CloseFile(f_modbus);
    end;
  end;
end;
//---------------------------------------------------//

end.
