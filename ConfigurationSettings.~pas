unit ConfigurationSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Buttons, CheckLst, ImgList, Grids, Math;

type
  TFormConfigurationSettings = class(TForm)
    tcConf: TTabControl;
    ImageList1: TImageList;
    pDevice: TPanel;
    pTime: TPanel;
    GroupBox7: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    bSetTime: TBitBtn;
    tvConfMain: TTreeView;
    bSetConf: TBitBtn;
    pMain: TPanel;
    sgConfPnt: TStringGrid;
    pArchive: TPanel;
    sgArchive: TStringGrid;
    pClear: TPanel;
    clClear: TCheckListBox;
    MonthCalendar1: TMonthCalendar;
    procedure tcConfChange(Sender: TObject);
    procedure bSetConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bSetTimeClick(Sender: TObject);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure bResetConfClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tvConfMainChange(Sender: TObject; Node: TTreeNode);
    procedure sgConfPntDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgConfPntSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgArchiveDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgArchiveSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure clClearClick(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GoSelectExecute(Sender: TObject);
    procedure GoCheckExecute(Sender: TObject);
    procedure GoClickExecute(Sender: TObject);
    procedure GoEditExecute;
    procedure GoKeyPressExecute(Sender: TObject; var Key: Char);
    function EnterFloatValue(ed:TEdit;ind:byte;var b:single):boolean;
    //procedure GoSelectDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    { Public declarations }
    procedure PrepareToClose;
  end;

var
  FormConfigurationSettings: TFormConfigurationSettings;cbConfig:TComboBox;clConfig:TCheckListBox;bVerify:TBitBtn;
  eConfig:TEdit;

implementation

{$R *.DFM}
uses Main, FormForView;

type TSetArchSel=record addr,offset:byte;end;

const
  modbus_exp:array[0..6]of string[15]=('Нет','Slave (Func 3)','Host (Func 3)',
                            'Host (Func 4)','Host (Func 5)','Host (Func 6)',
                            'Slave (Func 16)');

  modbus_code:array[0..6]of byte=(0,66,130,131,132,133,71);

  typ_exp:array[0..6]of string[15]=('Отключен','Текущий','Накопл','Усреднён','Буфер (5)',
          'Буфер (10)','Буфер (20)');

  mvs_alm_brd:array[0..2,0..2]of byte=((22,25,28),(31,34,37),(40,43,46));//MVS,канал

  baud_port:array[0..7]of string[10]=('1200 бод','2400 бод','4800 бод',
       '9600 бод','19200 бод','38400 бод','57600 бод','115200 бод');

  data_port:array[0..1]of string[10]=('8 бит','7 бит');

  stop_port:array[0..1]of string[10]=('1 бит','2 бит');

  parity_port:array[0..2]of string[15]=('Нет(None)','Нечёт(Odd)','Чёт(Even)');

  time_out:array[0..7]of string[10]=('150 мсек','250 мсек','350 мсек',
        '500 мсек','750 мсек','1000 мсек','1500 мсек','2500 мсек');

  typ_protocol:array[0..6]of string[10]=('Неопред','Коммуник','EcoSonic','DCON',
        'Modbus','MicroMotion','Коммуник/ABB');

  mb_delay:array[0..6]of string[10]=('0 сек','1 сек','3 сек','5 сек','10 сек',
        '30 сек','60 сек');

  mb_mode:array[0..1]of string[10]=('Host','Slave');

  mb_pool:array[0..1]of string[10]=('ASCII','RTU');

  mb_com:array[0..3]of string[10]=('Отключен','СОМ2','COM3','COM1');

var tab_row,tab_col,{координаты ячейки показа компонентов}
    tab_row_btn,tab_col_btn,{координаты ячейки показа кнопки}
    all_verify,top_row,{сброс показа при прокрутке}
    num_param:integer;
    flag_view:TComponentView;{признак показа в ячейке таблицы компонентов}
    number,{признак числа или строки для фильтра ввода с клавиатуры}
    flag_edit,flg_view_btn,
    flg_enter_err:boolean;ArchSel:array of TSetArchSel;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

{procedure TFormConfigurationSettings.GoSelectDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin //использование TComboBox для ввода
  if Key=VK_INSERT then cbConfig.Items.Add(cbConfig.Text);
  if Key=VK_DELETE then cbConfig.Items.Delete(cbConfig.ItemIndex);
end;}
//---------------------------------------------------//

procedure TFormConfigurationSettings.GoSelectExecute(Sender: TObject);
var i:byte;
begin
  if (num_page_conf[tcConf.TabIndex]=0)and(tvConfMain.Selected.StateIndex=3) then
  begin
    sgArchive.Cells[tab_col,tab_row]:=cbConfig.Items.Strings[cbConfig.ItemIndex];
    ConfData.setwr[tab_row-1].flag:=true;
    case tab_col of
      1:
      begin
        ConfData.setwr[tab_row-1].val[0]:=cbConfig.ItemIndex;
        if cbConfig.ItemIndex=0 then
        begin
          ConfData.setwr[tab_row-1].val[1]:=0;ConfData.setwr[tab_row-1].val[2]:=0;
          ConfData.setwr[tab_row-1].val[3]:=0;
        end;
      end;
      2:ConfData.setwr[tab_row-1].val[1]:=cbConfig.ItemIndex;
      3:begin
          ConfData.setwr[tab_row-1].val[2]:=ArchSel[cbConfig.ItemIndex].addr;
          ConfData.setwr[tab_row-1].val[3]:=ArchSel[cbConfig.ItemIndex].offset;
        end;
    end;
  end else
  if (num_page_conf[tcConf.TabIndex]=0)and(tvConfMain.Selected.StateIndex=4) then
  begin
    sgArchive.Cells[tab_col,tab_row]:=cbConfig.Items.Strings[cbConfig.ItemIndex];
    ConfData.setwr[tab_row-1].flag:=true;
    case tab_col of
      1:begin
          ConfData.setwr[tab_row-1].val[0]:=
          (ConfData.setwr[tab_row-1].val[0]and 240)+cbConfig.ItemIndex;
          SetPort[tab_row-1].baud:=cbConfig.ItemIndex;
        end;
      2:begin
          ConfData.setwr[tab_row-1].val[0]:=
          (ConfData.setwr[tab_row-1].val[0]and 239)+cbConfig.ItemIndex*16;
          SetPort[tab_row-1].data:=cbConfig.ItemIndex;
        end;
      3:begin
          ConfData.setwr[tab_row-1].val[0]:=
          (ConfData.setwr[tab_row-1].val[0]and 223)+cbConfig.ItemIndex*32;
          SetPort[tab_row-1].stop:=cbConfig.ItemIndex;
        end;
      4:begin
          ConfData.setwr[tab_row-1].val[0]:=
          (ConfData.setwr[tab_row-1].val[0]and 63)+cbConfig.ItemIndex*64;
          SetPort[tab_row-1].parity:=cbConfig.ItemIndex;
        end;
      5:ConfData.setwr[tab_row-1].val[1]:=cbConfig.ItemIndex;
    end;PRT.flg_port:=true;SetPort[tab_row-1].flag:=true;
  end else
  if (num_page_conf[tcConf.TabIndex]=0)and(tvConfMain.Selected.StateIndex=5) then
  begin
    sgArchive.Cells[tab_col,tab_row]:=cbConfig.Items.Strings[cbConfig.ItemIndex];
    ConfData.setwr[tab_row-1].flag:=true;
    case tab_col of
      1:ConfData.setwr[tab_row-1].val[0]:=
         (ConfData.setwr[tab_row-1].val[0]and 239)+cbConfig.ItemIndex*16;
      2:ConfData.setwr[tab_row-1].val[0]:=
         (ConfData.setwr[tab_row-1].val[0]and 247)+cbConfig.ItemIndex*8;
      3:ConfData.setwr[tab_row-1].val[0]:=
         (ConfData.setwr[tab_row-1].val[0]and 159)+cbConfig.ItemIndex*32;
      4:ConfData.setwr[tab_row-1].val[0]:=
         (ConfData.setwr[tab_row-1].val[0]and 248)+cbConfig.ItemIndex;
    end;
  end else
  if ((num_page_conf[tcConf.TabIndex]=0)and(tvConfMain.Selected.StateIndex=1))or
     ((num_page_conf[tcConf.TabIndex]>0)and(num_page_conf[tcConf.TabIndex]<5)and
      (tvConfMain.Selected.StateIndex=6))or(num_page_conf[tcConf.TabIndex]=6)then
  begin
    ConfData.setwr[tab_row].val[0]:=cbConfig.ItemIndex;
    ConfData.setwr[tab_row].flag:=true;
    sgConfPnt.Cells[1,tab_row]:=cbConfig.Items.Strings[cbConfig.ItemIndex];
  end else
  if num_page_conf[tcConf.TabIndex]=5 then
  begin 
    sgArchive.Cells[tab_col,tab_row]:=cbConfig.Items.Strings[cbConfig.ItemIndex];
    if tab_col<>3 then
    ConfData.setwr[tab_row-1].val[tab_col-1]:=cbConfig.ItemIndex else
    ConfData.setwr[tab_row-1].val[tab_col-1]:=modbus_code[cbConfig.ItemIndex];
    ConfData.setwr[tab_row-1].flag:=true;flg_reload:=true;
  end;
  bSetConf.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.GoCheckExecute(Sender: TObject);
var i:integer;val:byte;s:string;str:string[3];res:string[1];
begin
  val:=0;bSetConf.Enabled:=true;s:='';
  if clConfig.Items.Count>0 then for i:=0 to clConfig.Items.Count-1 do
  begin
    if clConfig.Checked[i] then
    begin val:=val+etl[i];res:='Y';end else res:='N';
    str:=clConfig.Items.Strings[i];s:=s+str+'-'+res+' ';
  end;ConfData.setwr[tab_row].flag:=true;ConfData.setwr[tab_row].val[0]:=val;
  sgConfPnt.Cells[1,tab_row]:=s;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.GoClickExecute(Sender: TObject);
var flg:boolean;i:integer;
begin {Выполняет передачу значений входов для поверки }
  bVerify.Enabled:=false;Screen.Cursor:=crHourGlass;flg_cmd:=5;
end;
//---------------------------------------------------//

function EditEnter(Conf:array of TSetConfigPrm):boolean;
var i:integer;value:single;flg:boolean;long:longword;a:word;
begin {изменение конфигурации через окно редактирования}
  flg:=false;
  case Conf[num_param].typ of
    0,10:
      begin
        if Length(eConfig.Text)<Conf[num_param].size+1 then
        for i:=Length(eConfig.Text)+1 to Conf[num_param].size do
        eConfig.Text:=eConfig.Text+Char(32);
        for i:=0 to Conf[num_param].size-1 do
        ConfData.setwr[tab_row].val[i]:=Ord(eConfig.Text[i+1]);
      end;
    1:begin
        try i:=StrToInt(eConfig.Text);
        except on EConvertError do flg:=true;end;
        if flg=false then ConfData.setwr[tab_row].val[0]:=i;
       end;
    4:begin  
        try value:=StrToFloat(eConfig.Text);
        except on EConvertError do flg:=true;end;
        if flg=false then
        MainForm.FloatToBynare(value,ConfData.setwr[tab_row].val[0],
           ConfData.setwr[tab_row].val[1],ConfData.setwr[tab_row].val[2],
           ConfData.setwr[tab_row].val[3]);
       end;
    5:begin
        try long:=StrToInt(eConfig.Text);
        except on EConvertError do flg:=true;end;
        if flg=false then
        MainForm.LongToBynare(long,ConfData.setwr[tab_row].val[0],
           ConfData.setwr[tab_row].val[1],ConfData.setwr[tab_row].val[2],
           ConfData.setwr[tab_row].val[3]);
      end;
    9:begin
        try a:=StrToInt(eConfig.Text);
        except on EConvertError do flg:=true;end;
        if flg=false then
        begin
          ConfData.setwr[tab_row].val[0]:=Hi(a);
          ConfData.setwr[tab_row].val[1]:=Lo(a);
        end;
      end;
    15:begin
         try long:=StrToInt(eConfig.Text);
         except on EConvertError do flg:=true;end;
         if flg=false then
         begin
           ConfData.setwr[tab_row].val[0]:=Floor(long/65536);
           ConfData.setwr[tab_row].val[1]:=
             Floor((long-ConfData.setwr[tab_row].val[0]*65536)/256);
           ConfData.setwr[tab_row].val[2]:=
             long-ConfData.setwr[tab_row].val[0]*65536-
             ConfData.setwr[tab_row].val[1]*256;
         end;
       end;
  end;if flg then Result:=true else Result:=false;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.GoEditExecute;
var flg:boolean;i:integer;
label M;
begin
  if flag_edit=false then Exit;flg:=false;
  if (num_page_conf[tcConf.TabIndex]>0)and(num_page_conf[tcConf.TabIndex]<5)and
     (tvConfMain.Selected.StateIndex=7) then
  begin
    for i:=0 to Length(ConfData.ver_input)-1 do
    if ConfData.ver_input[i].row=tab_row then
    begin
      try ConfData.ver_input[i].data:=StrToFloat(eConfig.Text);
      except on EConvertError do flg:=true;end;
      if flg then Goto M;sgConfPnt.Cells[1,tab_row]:=eConfig.Text;
      bVerify.Enabled:=true;Break;
    end;Exit;
  end;
  if (num_page_conf[tcConf.TabIndex]>0)and(num_page_conf[tcConf.TabIndex]<5)and
    (tvConfMain.Selected.StateIndex=6) then if EditEnter(ConfSet) then Goto M;
  if (num_page_conf[tcConf.TabIndex]=0)and(tvConfMain.Selected.StateIndex=1)then
    if EditEnter(MainSet) then Goto M;
  if (num_page_conf[tcConf.TabIndex]=5)and(tvConfMain.Selected.StateIndex=10)then
    if EditEnter(ConfSetExp) then Goto M;
  if (num_page_conf[tcConf.TabIndex]=6)and(tvConfMain.Selected.StateIndex=11)then
    if EditEnter(ConfSetIcp) then Goto M;
  ConfData.setwr[tab_row].flag:=true;bSetConf.Enabled:=true;
    sgConfPnt.Cells[1,tab_row]:=eConfig.Text;Exit;
M:ShowMessage('Неверный ввод! Пожалуйста повторите..');
  flg_enter_err:=true;bSetConf.Enabled:=false;bVerify.Enabled:=false;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.GoKeyPressExecute(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then begin GoEditExecute;Exit;end;flag_edit:=true;
  if number then if not (Key in ['0'..'9','-',smb_del])then Key:=#0;
end;
//---------------------------------------------------//

procedure ViewSelectParam(Prms:array of TConfigSelect;num_prm:integer;val:byte);
var i,j:integer;
begin {вывод в ячейку таблицы конфиг параметр с однократным выбором}
  if Length(Prms)>0 then
  begin
    for j:=0 to Length(Prms)-1 do
    if (Prms[j].num=num_prm)and(Length(Prms[j].selset)>0) then
    for i:=0 to Length(Prms[j].selset)-1 do if i=ConfData.setwr[val].val[0] then
    begin
      if Prms[j].selset[i]<Length(select_all) then
      FormConfigurationSettings.sgConfPnt.Cells[1,val]:=select_all[Prms[j].selset[i]];break;
    end;
  end;
end;
//---------------------------------------------------//

procedure SelSelectParam(Prms:array of TConfigSelect;row,col:integer);
var i,j:integer;
begin {отображение в строке таблицы компонента список строк}
  cbConfig.Clear;
  if Length(Prms)>0 then for j:=0 to Length(Prms)-1 do
  if Prms[j].num=ConfData.setwr[row].num then
  begin
    for i:=0 to Length(Prms[j].selset)-1 do
    if Prms[j].selset[i]<Length(select_all)then
    cbConfig.Items.Add(select_all[Prms[j].selset[i]]);
    num_param:=ConfData.setwr[row].num;break;
  end;
  cbConfig.Style:=csDropDownList;
  cbConfig.ItemIndex:=ConfData.setwr[row].val[0];eConfig.Visible:=false;
  cbConfig.Height:=FormConfigurationSettings.sgConfPnt.RowHeights[row];tab_row:=row;
  cbConfig.Width:=FormConfigurationSettings.sgConfPnt.ColWidths[col];cbConfig.Visible:=true;
  tab_col:=col;flag_view:=cvSelect;clConfig.Visible:=false;
end;
//---------------------------------------------------//

procedure ViewCheckParam(Prms:array of TConfigSelect;num_prm:integer;ind:byte);
var j,k:integer;s:string;str:string[3];val:string[1];
begin {вывод в ячейку таблицы конфиг параметра с множественным выбором}
  if Length(Prms)>0 then
  begin
    for j:=0 to Length(Prms)-1 do
    if Prms[j].num=num_prm then
    if(Length(Prms[j].selset)>0)and(Length(Prms[j].selset)<8)then
    begin
      s:='';
      for k:=0 to Length(Prms[j].selset)-1 do
      if Prms[j].selset[k]<Length(select_all)then
      begin
        str:=select_all[Prms[j].selset[k]];
        if (ConfData.setwr[ind].val[0] and etl[k])>0 then
        val:='Y' else val:='N';s:=s+str+'-'+val+' ';
      end;FormConfigurationSettings.sgConfPnt.Cells[1,ind]:=s;
    end;
  end;
end;
//---------------------------------------------------//

procedure SelCheckParam(Prms:array of TConfigSelect;row,col:integer);
var i,j:integer;
begin
  clConfig.Clear;
  if Length(Prms)>0 then for j:=0 to Length(Prms)-1 do
  if Prms[j].num=ConfData.setwr[row].num then
  begin
    for i:=0 to Length(Prms[j].selset)-1 do
    if Prms[j].selset[i]<Length(select_all)then
    begin
      clConfig.Items.Add(select_all[Prms[j].selset[i]]);
      if (ConfData.setwr[row].val[0] and etl[i])>0 then
      clConfig.Checked[i]:=true else clConfig.Checked[i]:=false;
    end;num_param:=ConfData.setwr[row].num;break;
  end;
  clConfig.Height:=(FormConfigurationSettings.sgConfPnt.RowHeights[row]+
                    FormConfigurationSettings.sgConfPnt.GridLineWidth)*3;
  clConfig.Width:=FormConfigurationSettings.sgConfPnt.ColWidths[col];clConfig.Visible:=true;
  tab_col:=col;flag_view:=cvCheck;cbConfig.Visible:=false;
  tab_row:=row;eConfig.Visible:=false;
end;
//---------------------------------------------------//

procedure SelEditParam(Conf:array of TSetConfigPrm;row,col:integer);
begin
  if (Conf[ConfData.setwr[row].num].typ=0)or
     (Conf[ConfData.setwr[row].num].typ=10)then
  number:=false else number:=true;
  eConfig.Text:=FormConfigurationSettings.sgConfPnt.Cells[col,row];num_param:=ConfData.setwr[row].num;//Conf[row].num;
  eConfig.Height:=FormConfigurationSettings.sgConfPnt.RowHeights[row];tab_row:=row;
  eConfig.Width:=FormConfigurationSettings.sgConfPnt.ColWidths[col];eConfig.Visible:=true;
  tab_col:=col;flag_view:=cvEdit;clConfig.Visible:=false;
  cbConfig.Visible:=false;eConfig.SetFocus;
end;
//---------------------------------------------------//

procedure PanelsVisibleFalse;
begin
  with FormConfigurationSettings do
  begin
    pTime.Visible:=false;pArchive.Visible:=false;pMain.Visible:=false;
    pClear.Visible:=false;
  end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.tcConfChange(Sender: TObject);
var i:integer;
begin //загрузка конфигурации точки
  cbConfig.Visible:=false;clConfig.Visible:=false;sgConfPnt.TopRow:=0;
  bVerify.Visible:=false;eConfig.Visible:=false;flag_view:=cvOff;
  PanelsVisibleFalse;flg_view_btn:=false;flg_reload:=false;
  tvConfMain.FullCollapse;PRT.flg_port:=false;flg_set_conf:=true;
  if Length(ConfData.setwr)>0 then for i:=0 to Length(ConfData.setwr)-1 do
    ConfData.setwr[i].flag:=false;pDevice.Visible:=false;
  flg_cmd:=2;bSetConf.Enabled:=false;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

function TFormConfigurationSettings.EnterFloatValue(ed:TEdit;ind:byte;var b:single):boolean;
var flg:boolean;
begin
  flg:=false;
  try b:=StrToFloat(ed.Text);except on EConvertError do
      begin ed.Text:='';ed.SetFocus;flg:=true;end;
  end;{if flg=false then ConfPnt.val[ind]:=b;}Result:=flg;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.bSetConfClick(Sender: TObject);
{const anb_min:array[0..7]of double=(3.955,8.344,19.568,28.233,44.58,14.2367,25.5778,46.3296);
      anb_max:array[0..7]of double=(4.833,10.198,23.912,34.525,54.48,15.7353,28.2702,51.2064);
      anb:array[0..7]of double=(4.394,9.271,21.742,31.369,49.53,14.986,26.924,48.768); }
var flg:boolean;i:byte;str:string;
begin //запись конфигурации в контроллер
  flg:=false;BSetConf.Enabled:=false;
  if (num_page_conf[tcConf.TabIndex]=5)and(flg_reload)then
  str:='Параметры дополнительной точки могут быть перераспределены!'else str:='';
  if SetClear.flag then
  if MessageDlg('Вы действительно хотите обнулить выбранные параметры?',
                 mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin flg_cmd:=15;Screen.Cursor:=crHourGlass;Exit;end;
  if Length(ConfData.setwr)>0 then for i:=0 to Length(ConfData.setwr)-1 do
    if ConfData.setwr[i].flag then begin flg:=true;Break;end;
  if flg then if ((tvConfMain.Selected.StateIndex<>3)and
  (MessageDlg('Вы действительно хотите изменить конфигурационные настройки?'+Char(13)+str,
                 mtConfirmation,[mbYes,mbNo],0)=mrNo))or
  ((tvConfMain.Selected.StateIndex=3)and(MessageDlg(
  'Вы действительно хотите изменить архивные настройки?'+Char(13)+
  'Архивная память будет очищена, указатели сброшены!',
                 mtConfirmation,[mbYes,mbNo],0)=mrNo)) then
  begin
    for i:=0 to Length(ConfData.setwr)-1 do ConfData.setwr[i].flag:=false;
    flg_reload:=false;Exit;
  end;if flg_reload then begin PRT.load_visible:=11;MainForm.EnableStatusMessage;end;
  flg_cmd:=3;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.FormCreate(Sender: TObject);
begin
  PanelsVisibleFalse;
  cbConfig:=TComboBox.Create(FormConfigurationSettings);cbConfig.Parent:=FormConfigurationSettings;
  cbConfig.Visible:=false;cbConfig.OnChange:=GoSelectExecute;
  cbConfig.Color:=$00D8E9EC;cbConfig.Font.Color:=clBlue;
  cbConfig.Font.Style:=[fsBold];cbConfig.Style:=csDropDownList;//cbConfig.OnKeyDown:=GoSelectDown;
  clConfig:=TCheckListBox.Create(FormConfigurationSettings);clConfig.Parent:=FormConfigurationSettings;
  clConfig.Visible:=false;clConfig.OnClickCheck:=GoCheckExecute;
  clConfig.Color:=$00D8E9EC;clConfig.Font.Color:=clBlue;
  clConfig.Font.Style:=[fsBold];
  bVerify:=TBitBtn.Create(FormConfigurationSettings);bVerify.Parent:=FormConfigurationSettings;
  bVerify.Visible:=false;bVerify.OnClick:=GoClickExecute;bVerify.Enabled:=false;
  bVerify.Caption:='Выполнить расчёт!';
  bVerify.Glyph:=bSetConf.Glyph;
  eConfig:=TEdit.Create(FormConfigurationSettings);eConfig.Parent:=FormConfigurationSettings;eConfig.Visible:=false;
  eConfig.Font.Color:=clBlue;eConfig.Font.Style:=[fsBold];
  eConfig.OnKeyPress:=GoKeyPressExecute;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.bSetTimeClick(Sender: TObject);
begin //Установка даты/времени
  BSetTime.Enabled:=false;Screen.Cursor:=crHourGlass;flg_cmd:=4;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.DateTimePicker1Change(Sender: TObject);
begin BSetTime.Enabled:=true;end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.bResetConfClick(Sender: TObject);
begin flg_cmd:=13;end;
//---------------------------------------------------//

procedure ClearTable(table:TStringGrid);
var i,j:integer;
begin
  for i:=0 to table.ColCount-1 do
    for j:=0 to table.RowCount-1 do table.Cells[i,j]:=' ';
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.PrepareToClose;
begin
  cbConfig.Visible:=false;clConfig.Visible:=false;
  bVerify.Visible:=false;eConfig.Visible:=false;flag_view:=cvOff;
  PanelsVisibleFalse;flg_view_btn:=false;pDevice.Visible:=false;
  tvConfMain.FullCollapse;flg_reload:=false;MainForm.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin PrepareToClose;end;
//---------------------------------------------------//

procedure ViewTableSetArchive(setarch:array of TSetArchivePrm;
                              index,compare:integer);
var i:integer;
begin
  if (Length(setarch)>0)and(ConfData.setwr[index].val[0]=compare)then
  for i:=0 to Length(setarch)-1 do
  if setarch[i].addr=ConfData.setwr[index].val[2] then
  begin
    if setarch[i].name<Length(dyn_all)then
    FormConfigurationSettings.sgArchive.Cells[3,index+1]:=dyn_all[setarch[i].name];
    if (ConfData.setwr[index].val[3]=4)or(ConfData.setwr[index].val[3]=6)then
    FormConfigurationSettings.sgArchive.Cells[3,index+1]:=FormConfigurationSettings.sgArchive.Cells[3,index+1]+
                            name_expand[ConfData.setwr[index].val[3]];Break;
  end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.tvConfMainChange(Sender: TObject; Node: TTreeNode);
const name_arc:array[0..3]of string[20]=('Номер точки','Выбор списка',
      'Лог.номер','Выбор параметра');
      name_port:array[0..6]of string[15]=('Имя','Скорость','Данные',
      'Стоповые','Паритет','Тайм-аут','Протокол');
      name_modbus:array[0..4]of string[15]=('Настройки','Режим','Протокол',
      'Подключение','Задержка');
      str_exp:array[0..3]of string[15]=('Параметр','Имя','Тип парам','Modbus');
var i,j,k,n:integer;s:string;str:string[3];val:string[1];value:single;
    flg,flg_passw:boolean;
begin {визуализация конфигурационных таблиц}
  ClearTable(sgArchive);cbConfig.Visible:=false;clConfig.Visible:=false;
  bVerify.Visible:=false;eConfig.Visible:=false;ClearTable(sgConfPnt);
  sgConfPnt.Color:=clWhite;flag_view:=cvOff;flg_view_btn:=false;
  sgConfPnt.ScrollBars:=ssVertical;PRT.flg_port:=false;
  sgArchive.ScrollBars:=ssVertical;bSetConf.Enabled:=false;
  if Length(ConfData.setwr)>0 then for i:=0 to Length(ConfData.setwr)-1 do
    ConfData.setwr[i].flag:=false;
  case Node.StateIndex of
    0:PanelsVisibleFalse;
    1:
    begin
      PanelsVisibleFalse;sgConfPnt.ColCount:=2;
      sgConfPnt.ColWidths[0]:=201;sgConfPnt.ColWidths[1]:=161;
      sgConfPnt.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1]+24;
      sgConfPnt.FixedCols:=1;sgConfPnt.FixedRows:=0;k:=0;
      if Length(MainSet)>0 then for i:=0 to Length(MainSet)-1 do
      if (MainSet[i].typ<6)or(MainSet[i].typ>8) then
      begin
        if MainSet[i].name<Length(conf_all) then
        sgConfPnt.Cells[0,k]:=conf_all[MainSet[i].name];
        if MainSet[i].units<Length(units_all) then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+units_all[MainSet[i].units];
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,MainSet[i].size);
        if MainSet[i].size>0 then
        for j:=0 to Length(ConfData.setwr[k].val)-1 do
        ConfData.setwr[k].val[j]:=ConfData.buf[MainSet[i].addr+j];s:='';
        case MainSet[i].typ of
          0,10:
          begin
            for j:=0 to Length(ConfData.setwr[k].val)-1 do
            if ConfData.setwr[k].val[j]>31 then
            s:=s+Char(ConfData.setwr[k].val[j]);sgConfPnt.Cells[1,k]:=s;
          end;
          1:sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[0]);
          2:ViewSelectParam(SelMain,i,k);
          3:ViewCheckParam(SelMain,i,k);
          4:;
          5:
          begin
            if(ConfData.setwr[k].val[1]*65536+ConfData.setwr[k].val[2]*256+
               ConfData.setwr[k].val[3])=s_long[0] then flg_passw:=true else
               flg_passw:=false;
            if flg_passw then sgConfPnt.Cells[1,k]:=IntToStr(s_long[0])else
               sgConfPnt.Cells[1,k]:='*****';
          end;
          9:if flg_passw then sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[0]*256+
              ConfData.setwr[k].val[1]) else sgConfPnt.Cells[1,k]:='*****';
        end;k:=k+1;
      end;sgConfPnt.RowCount:=k;pMain.Visible:=true;
    end;
    2:begin PanelsVisibleFalse;pTime.Visible:=true;end;
    3:
    begin {открывает конфигурацию архива}
      PanelsVisibleFalse;k:=0;
      sgArchive.ColCount:=4;sgArchive.FixedCols:=1;
      sgArchive.DefaultColWidth:=95;sgArchive.ColWidths[2]:=73;
      sgArchive.ColWidths[3]:=125;sgArchive.FixedRows:=1;
      sgArchive.Width:=sgArchive.ColWidths[0]+sgArchive.ColWidths[1]+
                       sgArchive.ColWidths[2]+sgArchive.ColWidths[3]+24;
      for i:=0 to sgArchive.ColCount-1 do sgArchive.Cells[i,0]:=name_arc[i];
      if Length(MainSet)>0 then for i:=0 to Length(MainSet)-1 do
      if MainSet[i].typ=8 then
      begin
        if MainSet[i].name<Length(conf_all) then
        sgArchive.Cells[0,k+1]:=conf_all[MainSet[i].name]+IntToStr(k+1);
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,MainSet[i].size);
        if MainSet[i].size>0 then
        begin //ShowMessage('точка: '+IntToStr(k));
          for j:=0 to MainSet[i].size-1 do
          ConfData.setwr[k].val[j]:=ConfData.buf[MainSet[i].addr+j];
          if ConfData.setwr[k].val[0]<Length(sel_pnt)then
            sgArchive.Cells[1,k+1]:=sel_pnt[ConfData.setwr[k].val[0]];
          if (ConfData.setwr[k].val[0]<>0)and
             (ConfData.setwr[k].val[1]<Length(log_pnt))then
            sgArchive.Cells[2,k+1]:=log_pnt[ConfData.setwr[k].val[1]];
          ViewTableSetArchive(ArchBasicSet,k,1);{вывод настроек основ точки}
          ViewTableSetArchive(ArchExpandSet,k,2);{вывод настроек дополн точки}
        end;k:=k+1;
      end;sgArchive.RowCount:=k+1;pArchive.Visible:=true;
    end;
    4:
    begin {порты}
      PanelsVisibleFalse;sgArchive.ColCount:=7;
      sgArchive.FixedCols:=1;sgArchive.DefaultColWidth:=85;
      sgArchive.Width:=sgArchive.DefaultColWidth*sgArchive.ColCount+10;k:=0;
      sgArchive.RowCount:=5;sgArchive.FixedRows:=1;
      for i:=0 to sgArchive.ColCount-1 do sgArchive.Cells[i,0]:=name_port[i];
      if Length(MainSet)>0 then for i:=0 to Length(MainSet)-1 do
      if MainSet[i].typ=6 then
      begin
        if MainSet[i].name<Length(conf_all) then
        sgArchive.Cells[0,k+1]:=conf_all[MainSet[i].name]+IntToStr(k+1);
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,MainSet[i].size);
        if MainSet[i].size>0 then
        begin
          for j:=0 to MainSet[i].size-1 do
          ConfData.setwr[k].val[j]:=ConfData.buf[MainSet[i].addr+j];
          SetPort[k].baud:=ConfData.setwr[k].val[0] and 15;
          SetPort[k].data:=(ConfData.setwr[k].val[0] and 16)shr 4;
          SetPort[k].stop:=(ConfData.setwr[k].val[0] and 32)shr 5;
          SetPort[k].parity:=(ConfData.setwr[k].val[0] and 192)shr 6;
          SetPort[k].t_a:=ConfData.setwr[k].val[1] and 15;
          if (SetPort[k].baud)<Length(baud_port)then
            sgArchive.Cells[1,k+1]:=baud_port[SetPort[k].baud];
          if (SetPort[k].data)<Length(data_port)then
          sgArchive.Cells[2,k+1]:=data_port[SetPort[k].data];
          if (SetPort[k].stop)<Length(stop_port)then
          sgArchive.Cells[3,k+1]:=stop_port[SetPort[k].stop];
          if (SetPort[k].parity)<Length(parity_port)then
          sgArchive.Cells[4,k+1]:=parity_port[SetPort[k].parity];
          if (SetPort[k].t_a)<Length(time_out)then
          sgArchive.Cells[5,k+1]:=time_out[SetPort[k].t_a];
          if (SetPort[k].typ)<Length(typ_protocol)then
          sgArchive.Cells[6,k+1]:=typ_protocol[SetPort[k].typ];
        end;k:=k+1;
      end;pArchive.Visible:=true;
    end;
    5:
    begin {Modbus}
      PanelsVisibleFalse;sgArchive.ColCount:=5;
      sgArchive.FixedCols:=1;sgArchive.DefaultColWidth:=83;
      sgArchive.Width:=sgArchive.DefaultColWidth*5+10;k:=0;
      sgArchive.RowCount:=2;sgArchive.FixedRows:=1;
      for i:=0 to sgArchive.ColCount-1 do sgArchive.Cells[i,0]:=name_modbus[i];
      if Length(MainSet)>0 then for i:=0 to Length(MainSet)-1 do
      if MainSet[i].typ=7 then
      begin
        if MainSet[i].name<Length(conf_all) then
        sgArchive.Cells[0,k+1]:=conf_all[MainSet[i].name];
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,MainSet[i].size);
        if MainSet[i].size>0 then
        begin
          for j:=0 to MainSet[i].size-1 do
          ConfData.setwr[k].val[j]:=ConfData.buf[MainSet[i].addr+j];
          ModbusConf.mode:=(ConfData.setwr[k].val[0] and 16) shr 4;
          ModbusConf.pool:=(ConfData.setwr[k].val[0] and 8) shr 3;
          ModbusConf.com :=(ConfData.setwr[k].val[0] and 96) shr 5;
          ModbusConf.delay:=ConfData.setwr[k].val[0] and 7;
          if ModbusConf.mode<Length(mb_mode)then
            sgArchive.Cells[1,k+1]:=mb_mode[ModbusConf.mode];
          if ModbusConf.pool<Length(mb_pool)then
            sgArchive.Cells[2,k+1]:=mb_pool[ModbusConf.pool];
          if ModbusConf.com<Length(mb_com)then
            sgArchive.Cells[3,k+1]:=mb_com[ModbusConf.com];
          if ModbusConf.delay<Length(mb_delay)then
            sgArchive.Cells[4,k+1]:=mb_delay[ModbusConf.delay];
        end;k:=k+1;
      end;pArchive.Visible:=true;
    end;
    6:
    begin {открывает базовую конфигурацию}
      PanelsVisibleFalse;sgConfPnt.ColCount:=2;
      sgConfPnt.ColWidths[0]:=201;sgConfPnt.ColWidths[1]:=177;
      sgConfPnt.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1]+24;
      sgConfPnt.FixedCols:=1;sgConfPnt.FixedRows:=0;k:=0;
      if Length(ConfSet)>0 then for i:=0 to Length(ConfSet)-1 do
      if (ConfSet[i].typ<6)or(ConfSet[i].typ>8) then
      begin
        if ConfSet[i].name<Length(conf_all)then
        sgConfPnt.Cells[0,k]:=conf_all[ConfSet[i].name];
        if ConfSet[i].units<Length(units_all) then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+units_all[ConfSet[i].units];
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,ConfSet[i].size);
        if ConfSet[i].size>0 then
        for j:=0 to Length(ConfData.setwr[k].val)-1 do
        ConfData.setwr[k].val[j]:=ConfData.buf[ConfSet[i].addr+j];s:='';
        case ConfSet[i].typ of
          0,10:
          begin
            for j:=0 to Length(ConfData.setwr[k].val)-1 do
            if ConfData.setwr[k].val[j]>31 then
            s:=s+Char(ConfData.setwr[k].val[j]);sgConfPnt.Cells[1,k]:=s;
          end;
          1:sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[0]);
          2:ViewSelectParam(Select,i,k);
          3:ViewCheckParam(Select,i,k);
          4:
          begin
            MainForm.ConvToFloat(ConfData.setwr[k].val[0],
              ConfData.setwr[k].val[1],ConfData.setwr[k].val[2],
              ConfData.setwr[k].val[3],value);
            sgConfPnt.Cells[1,k]:=FloatToStrF(value,ffGeneral,6,5);
          end;
          5:sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[1]*65536+
              ConfData.setwr[k].val[2]*256+ConfData.setwr[k].val[3]);
          9:sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[0]*256+
              ConfData.setwr[k].val[1]);
          15:sgConfPnt.Cells[1,k]:=IntToStr(ConfData.setwr[k].val[0]*65536+
              ConfData.setwr[k].val[1]*256+ConfData.setwr[k].val[2]); {идентиф}
        end;k:=k+1;
      end;sgConfPnt.RowCount:=k;pMain.Visible:=true;
    end;
    7:
    begin {открывает поверку}
      PanelsVisibleFalse;sgConfPnt.ColCount:=2;all_verify:=0;j:=0;
      sgConfPnt.ColWidths[0]:=181;sgConfPnt.ColWidths[1]:=111;
      sgConfPnt.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1]+24;
      sgConfPnt.RowCount:=1;sgConfPnt.Color:=$00D8E9EC;
      if Length(Dyn)>0 then for i:=0 to Length(Dyn)-1 do
      begin
        if Dyn[i].verify>0 then
        begin
          sgConfPnt.RowCount:=sgConfPnt.RowCount+1;flg:=true;
          if Dyn[i].name<Length(dyn_all) then
          s:=dyn_all[Dyn[i].name]{+name_expand[Dyn[i].size]};
          if Dyn[i].units<Length(units_all)then s:=s+units_all[Dyn[i].units];
          sgConfPnt.Cells[0,all_verify+1]:=s;
          if Dyn[i].verify>1 then
          begin
            SetLength(ConfData.ver_input,j+1);
            ConfData.ver_input[j].num:=i;
            ConfData.ver_input[j].row:=all_verify+1;
            if ConfData.buf[Dyn[i].verify]=0 then
            begin {ввод константы разрешён}
              ConfData.ver_input[j].enable:=true;
              ConfData.ver_input[j].data:=0;
              sgConfPnt.Cells[1,all_verify+1]:=FloatToStr(0);
            end else ConfData.ver_input[j].enable:=false;j:=j+1;
          end;all_verify:=all_verify+1;
        end;
        if flg then
        begin
          bVerify.Enabled:=false;pMain.Visible:=true;
          bVerify.Height:=sgConfPnt.RowHeights[sgConfPnt.DefaultRowHeight];
          bVerify.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1];
          tab_row_btn:=0;flg_view_btn:=true;flag_view:=cvOff;
          tab_col_btn:=0;bVerify.Visible:=true;
        end;
      end;
    end;
    8:{открывает сброс счётчиков}
    begin
      PanelsVisibleFalse;clClear.Clear;k:=0;
      if Length(Dyn)>0 then for i:=0 to Length(Dyn)-1 do
      if Dyn[i].clear>0 then
      begin
        if (Dyn[i].units<Length(units_all))and(Dyn[i].name<Length(dyn_all))then
        if Typ_task<>6 then
        clClear.Items.Add(dyn_all[Dyn[i].name]+name_expand[Dyn[i].size]+
                          units_all[Dyn[i].units]) else
        clClear.Items.Add(dyn_all[Dyn[i].name]+name_expand_oil[Dyn[i].size]+
                          units_all[Dyn[i].units]);
        SetLength(SetClear.number,k+1);SetClear.number[k]:=i;k:=k+1;
      end;pClear.Visible:=true;
    end;
    9:
    begin
      PanelsVisibleFalse;sgArchive.ColCount:=Length(str_exp);j:=0;
      sgArchive.DefaultColWidth:=91;sgArchive.ColWidths[1]:=121;
      for i:=0 to sgArchive.ColCount-1 do j:=j+sgArchive.ColWidths[i];
      sgArchive.Width:=j+24;
      for i:=0 to sgArchive.ColCount-1 do sgArchive.Cells[i,0]:=str_exp[i];
      sgArchive.FixedCols:=1;sgArchive.FixedRows:=1;k:=0;
      if Length(ConfSetExp)>0 then for i:=0 to Length(ConfSetExp)-1 do
      if ConfSetExp[i].typ=14 then
      begin
        if ConfSetExp[i].name<Length(conf_all)then
        sgArchive.Cells[0,k+1]:=conf_all[ConfSetExp[i].name];
        if ConfSetExp[i].units<Length(units_all) then
        sgArchive.Cells[0,k+1]:=sgArchive.Cells[0,k+1]+
                                units_all[ConfSetExp[i].units];
        if ConfSetExp[i].num<128 then
        sgArchive.Cells[0,k+1]:=sgArchive.Cells[0,k+1]+IntToStr(ConfSetExp[i].num+1);
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,ConfSetExp[i].size);
        if ConfSetExp[i].size>0 then
        for j:=0 to Length(ConfData.setwr[k].val)-1 do
        ConfData.setwr[k].val[j]:=ConfData.buf[ConfSetExp[i].addr+j];
        if ConfData.setwr[k].val[0]<Length(dyn_all) then
        sgArchive.Cells[1,k+1]:=dyn_all[ConfData.setwr[k].val[0]];
        if ConfData.setwr[k].val[1]<Length(typ_exp)then
        sgArchive.Cells[2,k+1]:=typ_exp[ConfData.setwr[k].val[1]];
        for j:=0 to Length(modbus_exp)-1 do
        if ConfData.setwr[k].val[2]=modbus_code[j] then
        begin sgArchive.Cells[3,k+1]:=modbus_exp[j];Break;end;
        k:=k+1;
      end;sgArchive.RowCount:=k+1;pArchive.Visible:=true;
    end;
    10:
    begin
      PanelsVisibleFalse;sgConfPnt.ColCount:=2;sgConfPnt.ColWidths[0]:=201;
      sgConfPnt.ColWidths[1]:=161;
      sgConfPnt.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1]+24;
      sgConfPnt.FixedCols:=1;sgConfPnt.FixedRows:=0;k:=0;
      if Length(ConfSetExp)>0 then for i:=0 to Length(ConfSetExp)-1 do
      if ConfSetExp[i].typ=4 then
      begin
        if ConfSetExp[i].name<Length(conf_all)then
        sgConfPnt.Cells[0,k]:=conf_all[ConfSetExp[i].name];
        if ConfSetExp[i].units<Length(units_all) then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+
                                units_all[ConfSetExp[i].units];
        if ConfSetExp[i].num<128 then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+IntToStr(ConfSetExp[i].num+1);
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,ConfSetExp[i].size);
        for j:=0 to Length(ConfData.setwr[k].val)-1 do
        ConfData.setwr[k].val[j]:=ConfData.buf[ConfSetExp[i].addr+j];
        MainForm.ConvToFloat(ConfData.setwr[k].val[0],ConfData.setwr[k].val[1],
                          ConfData.setwr[k].val[2],ConfData.setwr[k].val[3],value);
        sgConfPnt.Cells[1,k]:=FloatToStrF(value,ffGeneral,6,5);
        k:=k+1;
      end;sgConfPnt.RowCount:=k;pMain.Visible:=true;
    end;
    11:
    begin
      PanelsVisibleFalse;sgConfPnt.ColCount:=2;
      sgConfPnt.ColWidths[0]:=201;sgConfPnt.ColWidths[1]:=161;
      sgConfPnt.Width:=sgConfPnt.ColWidths[0]+sgConfPnt.ColWidths[1]+24;
      sgConfPnt.FixedCols:=1;sgConfPnt.FixedRows:=0;k:=0;
      if Length(ConfSetIcp)>0 then for i:=0 to Length(ConfSetIcp)-1 do
      if (ConfSetIcp[i].typ=4)or(ConfSetIcp[i].typ=12) then
      begin
        if ConfSetIcp[i].name<Length(conf_all)then
        sgConfPnt.Cells[0,k]:=conf_all[ConfSetIcp[i].name];
        if ConfSetIcp[i].units<Length(units_all) then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+units_all[ConfSetIcp[i].units];
        if ConfSetIcp[i].num<128 then
        sgConfPnt.Cells[0,k]:=sgConfPnt.Cells[0,k]+IntToStr(ConfSetIcp[i].num+1);
        SetLength(ConfData.setwr,k+1);ConfData.setwr[k].num:=i;
        SetLength(ConfData.setwr[k].val,ConfSetIcp[i].size);
        if ConfSetIcp[i].size>0 then
        for j:=0 to Length(ConfData.setwr[k].val)-1 do
        ConfData.setwr[k].val[j]:=ConfData.buf[ConfSetIcp[i].addr+j];s:='';
        case ConfSetIcp[i].typ of
          4:
          begin
            MainForm.ConvToFloat(ConfData.setwr[k].val[0],
              ConfData.setwr[k].val[1],ConfData.setwr[k].val[2],
              ConfData.setwr[k].val[3],value);
            sgConfPnt.Cells[1,k]:=FloatToStrF(value,ffGeneral,6,5);
          end;
          12:if ConfData.setwr[k].val[0]<Length(units_all)then
             sgConfPnt.Cells[1,k]:=units_all_bis[ConfData.setwr[k].val[0]];
        end;k:=k+1;
      end;sgConfPnt.RowCount:=k;pMain.Visible:=true;
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.sgConfPntDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;i:byte;
begin
  if sgConfPnt.TopRow<>top_row then
  begin
    cbConfig.Visible:=false;clConfig.Visible:=false;eConfig.Visible:=false;
  end;
  if State=[gdSelected]then with sgConfPnt do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvSelect)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    cbConfig.Left:=pMain.Left+sgConfPnt.Left+Rect.Left+2;
    cbConfig.Top:=pMain.Top+sgConfPnt.Top+Rect.Top+2;
  end;
  if (flag_view=cvCheck)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    clConfig.Left:=pMain.Left+sgConfPnt.Left+Rect.Left+2;
    clConfig.Top:=pMain.Top+sgConfPnt.Top+Rect.Top+2;
  end;
  if flg_view_btn then
  begin
    if(tab_row_btn=ARow)and(tab_col_btn=ACol)then
    begin
      bVerify.Left:=pMain.Left+sgConfPnt.Left+Rect.Left+2;
      bVerify.Top:=pMain.Top+sgConfPnt.Top+Rect.Top+2;
    end;
    if Length(ConfData.ver_input)>0 then
    for i:=0 to Length(ConfData.ver_input)-1 do
    if (ConfData.ver_input[i].row=ARow)and(ACol=1)then
    begin
      with sgConfPnt do if ConfData.ver_input[i].enable then
      begin
        Canvas.Font.Color:=clBlue;Canvas.Brush.Color:=clWhite;
        str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
      end else
      begin
        Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
        str:='';Canvas.FillRect(Rect);
        Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
      end;
    end;
  end;
  if (flag_view=cvEdit)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    eConfig.Left:=pMain.Left+sgConfPnt.Left+Rect.Left+2;
    eConfig.Top:=pMain.Top+sgConfPnt.Top+Rect.Top+2;
  end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.sgConfPntSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var i,j:byte;
begin
  if flg_enter_err then begin eConfig.SetFocus;flg_enter_err:=false;Exit;end;
  top_row:=sgConfPnt.TopRow;
  case num_page_conf[tcConf.TabIndex] of
  0:begin
      if tvConfMain.Selected.StateIndex=1 then
      begin
        if (MainSet[ConfData.setwr[ARow].num].typ=0)or
           (MainSet[ConfData.setwr[ARow].num].typ=1)or
           (MainSet[ConfData.setwr[ARow].num].typ=4)or
           (MainSet[ConfData.setwr[ARow].num].typ=5)or
           (MainSet[ConfData.setwr[ARow].num].typ=9)or
           (MainSet[ConfData.setwr[ARow].num].typ=10)then
        SelEditParam(MainSet,ARow,ACol);
        if MainSet[ConfData.setwr[ARow].num].typ=2 then
        SelSelectParam(SelMain,ARow,ACol);
        if MainSet[ConfData.setwr[ARow].num].typ=3 then
        SelCheckParam(SelMain,ARow,ACol);
      end;
      if tvConfMain.Selected.StateIndex=3 then ;{архивные точки}
    end;
  1,2,3,4:
  begin
    if tvConfMain.Selected.StateIndex=6 then
    begin
      if (ConfSet[ConfData.setwr[ARow].num].typ=0)or
         (ConfSet[ConfData.setwr[ARow].num].typ=1)or
         (ConfSet[ConfData.setwr[ARow].num].typ=4)or
         (ConfSet[ConfData.setwr[ARow].num].typ=5)or
         (ConfSet[ConfData.setwr[ARow].num].typ=9)or
         (ConfSet[ConfData.setwr[ARow].num].typ=10)or
         (ConfSet[ConfData.setwr[ARow].num].typ=15)then
        SelEditParam(ConfSet,ARow,ACol);
      if ConfSet[ConfData.setwr[ARow].num].typ=2 then
        SelSelectParam(Select,ARow,ACol);
      if ConfSet[ConfData.setwr[ARow].num].typ=3 then
        SelCheckParam(Select,ARow,ACol);
    end;
    if tvConfMain.Selected.StateIndex=7 then
    begin {выбор строки ввода для поверки}
      if Length(ConfData.ver_input)>0 then
      for i:=0 to Length(ConfData.ver_input)-1 do
      if(ConfData.ver_input[i].row=ARow)and(ConfData.ver_input[i].enable)then
      begin
        eConfig.Height:=sgConfPnt.RowHeights[ARow];tab_row:=ARow;
        eConfig.Width:=sgConfPnt.ColWidths[ACol];eConfig.Visible:=true;
        tab_col:=ACol;flag_view:=cvEdit;clConfig.Visible:=false;
        cbConfig.Visible:=false;eConfig.Text:=sgConfPnt.Cells[ACol,ARow];
        eConfig.SetFocus;
      end;
    end;
  end;
  5:if (tvConfMain.Selected.StateIndex=10)and
     (ConfSetExp[ConfData.setwr[ARow].num].typ=4) then
    SelEditParam(ConfSetExp,ARow,ACol);
  6:if tvConfMain.Selected.StateIndex=11 then
  begin
    if ConfSetIcp[ConfData.setwr[ARow].num].typ=4 then
    SelEditParam(ConfSetIcp,ARow,ACol);
    if ConfSetIcp[ConfData.setwr[ARow].num].typ=12 then
    begin
      cbConfig.Clear;
      for i:=0 to Length(units_all_bis)-1 do cbConfig.Items.Add(units_all_bis[i]);
      cbConfig.ItemIndex:=ConfData.setwr[Arow].val[0];eConfig.Visible:=false;
      cbConfig.Height:=FormConfigurationSettings.sgConfPnt.RowHeights[Arow];tab_row:=Arow;
      cbConfig.Width:=FormConfigurationSettings.sgConfPnt.ColWidths[Acol];cbConfig.Visible:=true;
      tab_col:=Acol;flag_view:=cvSelect;clConfig.Visible:=false;
      cbConfig.Style:=csDropDownList;
    end;
  end;
  end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.sgArchiveDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if sgArchive.TopRow<>top_row then cbConfig.Visible:=false;
  if State=[gdSelected]then with sgArchive do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvSelect)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    cbConfig.Left:=pArchive.Left+sgArchive.Left+Rect.Left+2;
    cbConfig.Top:=pArchive.Top+sgArchive.Top+Rect.Top+2;
  end;
end;
//---------------------------------------------------//

procedure SelSelectArchive(Arch:array of TSetArchivePrm;row:integer);
const selarch:array[0..4,0..2]of byte=((1,1,0),(2,2,0),(2,4,4),(2,6,6),(3,3,0));
var i,j:integer;
begin
  for i:=0 to Length(Arch)-1 do
  if Arch[i].name<Length(dyn_all)then for j:=0 to Length(selarch)-1 do
  if Arch[i].typ=selarch[j,0] then
  begin
    cbConfig.Items.Add(dyn_all[Arch[i].name]+name_expand[selarch[j,2]]);
    SetLength(ArchSel,cbConfig.Items.Count);
    ArchSel[cbConfig.Items.Count-1].offset:=selarch[j,1];
    ArchSel[cbConfig.Items.Count-1].addr:=Arch[i].addr;
  end;
  for i:=0 to Length(ArchSel)-1 do
  if ConfData.setwr[row].val[2]=ArchSel[i].addr then
  begin cbConfig.ItemIndex:=i;Break;end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.sgArchiveSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var i:integer;flag:boolean;
begin
  top_row:=sgArchive.TopRow;cbConfig.Clear;flag:=false;
  if num_page_conf[tcConf.TabIndex]=0 then if tvConfMain.Selected.StateIndex=3 then
  case ACol of
    1:begin
        for i:=0 to Length(sel_pnt)-1 do cbConfig.Items.Add(sel_pnt[i]);
        cbConfig.ItemIndex:=ConfData.setwr[ARow-1].val[0];flag:=true;
      end;
    2:begin
        if ConfData.setwr[ARow-1].val[0]=1 then
        for i:=0 to Length(log_pnt)-1 do cbConfig.Items.Add(log_pnt[i]);
        if ConfData.setwr[ARow-1].val[0]=2 then cbConfig.Items.Add(log_pnt[0]);
        cbConfig.ItemIndex:=ConfData.setwr[ARow-1].val[1];flag:=true;
      end;
    3:begin
        if (ConfData.setwr[ARow-1].val[0]=1)and(Length(ArchBasicSet)>0)then
          SelSelectArchive(ArchBasicSet,ARow-1);
        if (ConfData.setwr[ARow-1].val[0]=2)and(Length(ArchExpandSet)>0)then
          SelSelectArchive(ArchExpandSet,ARow-1);flag:=true;
      end;
  end else
  if tvConfMain.Selected.StateIndex=4 then
  case ACol of
    1:begin
        for i:=0 to Length(baud_port)-1 do cbConfig.Items.Add(baud_port[i]);
        cbConfig.ItemIndex:=SetPort[ARow-1].baud;flag:=true;
      end;
    2:begin
        for i:=0 to Length(data_port)-1 do cbConfig.Items.Add(data_port[i]);
        cbConfig.ItemIndex:=SetPort[ARow-1].data;flag:=true;
      end;
    3:begin
        for i:=0 to Length(stop_port)-1 do cbConfig.Items.Add(stop_port[i]);
        cbConfig.ItemIndex:=SetPort[ARow-1].stop;flag:=true;
      end;
    4:begin
        for i:=0 to Length(parity_port)-1 do cbConfig.Items.Add(parity_port[i]);
        cbConfig.ItemIndex:=SetPort[ARow-1].parity;flag:=true;
      end;
    5:begin
        for i:=0 to Length(time_out)-1 do cbConfig.Items.Add(time_out[i]);
        cbConfig.ItemIndex:=SetPort[ARow-1].t_a;flag:=true;
      end;
  end else
  if tvConfMain.Selected.StateIndex=5 then
  case ACol of
    1:begin
        for i:=0 to Length(mb_mode)-1 do cbConfig.Items.Add(mb_mode[i]);
        cbConfig.ItemIndex:=ModbusConf.mode;flag:=true;
      end;
    2:begin
        for i:=0 to Length(mb_pool)-1 do cbConfig.Items.Add(mb_pool[i]);
        cbConfig.ItemIndex:=ModbusConf.pool;flag:=true;
      end;
    3:begin
        for i:=0 to Length(mb_com)-1 do cbConfig.Items.Add(mb_com[i]);
        cbConfig.ItemIndex:=ModbusConf.com;flag:=true;
      end;
    4:begin
        for i:=0 to Length(mb_delay)-1 do cbConfig.Items.Add(mb_delay[i]);
        cbConfig.ItemIndex:=ModbusConf.delay;flag:=true;
      end;
  end;
  if (num_page_conf[tcConf.TabIndex]=5)and(tvConfMain.Selected.StateIndex=9)then
  case ACol of
    1:begin
        for i:=0 to Length(dyn_all)-1 do
        cbConfig.Items.Add(dyn_all[i]);
        cbConfig.ItemIndex:=ConfData.setwr[ARow-1].val[0];flag:=true;
      end;
    2:begin
        for i:=0 to Length(typ_exp)-1 do cbConfig.Items.Add(typ_exp[i]);
        cbConfig.ItemIndex:=ConfData.setwr[ARow-1].val[1];flag:=true;
      end;
    3:begin
        for i:=0 to Length(modbus_exp)-1 do cbConfig.Items.Add(modbus_exp[i]);
        for i:=0 to Length(modbus_exp)-1 do
        if modbus_code[i]=ConfData.setwr[ARow-1].val[2] then
        begin cbConfig.ItemIndex:=i;Break;end;flag:=true;
      end;
  end;
  if flag then
  begin
    cbConfig.Height:=FormConfigurationSettings.sgArchive.RowHeights[ARow];tab_row:=ARow;
    cbConfig.Width:=FormConfigurationSettings.sgArchive.ColWidths[ACol];cbConfig.Visible:=true;
    tab_col:=ACol;flag_view:=cvSelect;
  end else begin cbConfig.Visible:=false;flag_view:=cvOff;end;
end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.clClearClick(Sender: TObject);
begin SetClear.flag:=true;BSetConf.Enabled:=true;end;
//---------------------------------------------------//

procedure TFormConfigurationSettings.MonthCalendar1Click(Sender: TObject);
begin BSetTime.Enabled:=true;end;
//---------------------------------------------------//

end.
