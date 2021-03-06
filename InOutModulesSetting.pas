unit InOutModulesSetting;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, Grids, Math;

type
  TFormIOModulesSetting = class(TForm)
    tcPageICP: TTabControl;
    Label1: TLabel;
    eNameMod: TEdit;
    Label11: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    cbDataType: TComboBox;
    Label12: TLabel;
    ComboBox2: TComboBox;
    Label13: TLabel;
    cbFilter: TComboBox;
    Label2: TLabel;
    cbInputType: TComboBox;
    bCallibr: TBitBtn;
    bWrite: TBitBtn;
    lIdentModul: TLabel;
    pCallibrAin: TPanel;
    Label4: TLabel;
    Label9: TLabel;
    bExecute: TBitBtn;
    BitBtn2: TBitBtn;
    pCallibrAout: TPanel;
    GroupBox1: TGroupBox;
    bMinusMinus: TBitBtn;
    bMinus: TBitBtn;
    bPlus: TBitBtn;
    bPlusPlus: TBitBtn;
    cbSelectChan: TComboBox;
    Label3: TLabel;
    pTable: TPanel;
    sgTable: TStringGrid;
    pCounters: TPanel;
    Label5: TLabel;
    cbSelChan: TComboBox;
    Label6: TLabel;
    cbSelChanStart: TComboBox;
    Label7: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure tcPageICPChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bWriteClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit5DblClick(Sender: TObject);
    procedure cbDataTypeChange(Sender: TObject);
    procedure cbFilterChange(Sender: TObject);
    procedure cbInputTypeChange(Sender: TObject);
    procedure bCallibrClick(Sender: TObject);
    procedure bExecuteClick(Sender: TObject);
    procedure CalibrateStep;
    procedure sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bPlusClick(Sender: TObject);
    procedure bMinusClick(Sender: TObject);
    procedure bPlusPlusClick(Sender: TObject);
    procedure bMinusMinusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sgTableSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure cbSelChanChange(Sender: TObject);
  private
    { Private declarations }
    procedure GoEditExecute;
    procedure GoKeyPressExecute(Sender: TObject; var Key: Char);
  public
    { Public declarations }
  end;

var
  FormIOModulesSetting: TFormIOModulesSetting;eAlarmSet:TEdit;

implementation

{$R *.DFM}
uses Main, ModbusSetting;

var tab_col,tab_row,top_row,left_col:integer;flag_view:TComponentView;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure TFormIOModulesSetting.GoEditExecute;
var flag:boolean;
begin
  flag:=false;
  try ICP.alm_set[tab_row-1,tab_col-6]:=StrToFloat(eAlarmSet.Text);
  except on EConvertError do flag:=true;end;
  if flag=false then
  begin
    sgTable.Cells[tab_col,tab_row]:=eAlarmSet.Text;
    ICP.flg_set[tab_row-1,tab_col-6]:=true;bWrite.Enabled:=true;
  end else ShowMessage('???????????? ???? ?????!');
  eAlarmSet.Visible:=false;flag_view:=cvOff;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.GoKeyPressExecute(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then begin GoEditExecute;Exit;end;
  if not (Key in ['0'..'9','-',smb_del])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.CalibrateStep;
const lbl_txt:array[1..3,0..1]of string[40]=(
      ('?????????? ???? ? ?????????','?????????? ?????????? ??????'),
       ('?????????? ??????? ????????','?????????? ??? ?????????'),
        ('?????????? ??????? ????????','?????????? ???'));
      lbl_txt_bis:array[1..3,0..1]of string[40]=(
      ('???? ??? ??????????','? ?????????? ??????'),
       ('???? ??? ??????????','4.0 ??(I-7022) ??? 0.0 ??(I-7024)'),
        ('???? ??? ??????????','????????? 20.0 ??'));
      cbr_txt:array[1..3]of string[40]=(
       '?????????? ??????????:','?????????? ???? (Zero):',
       '?????????? ????? (Span)');
var typ:byte;
begin
  if ICP.typ<2 then typ:=0 else typ:=1;
  Label4.Caption:=lbl_txt[ICP.flg_calibr,typ];
  Label3.Caption:=lbl_txt_bis[ICP.flg_calibr,typ];
  Label9.Caption:=cbr_txt[ICP.flg_calibr];
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9','-',smb_del,Char(8)])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.tcPageICPChange(Sender: TObject);
var i:byte;
begin
  cbInputType.Clear;cbDataType.Clear;bWrite.Enabled:=false;PRT.flg_first:=true;
  sgTable.Visible:=false;Screen.Cursor:=crHourGlass;  //flg_cmd:=22;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.FormClose(Sender: TObject; var Action: TCloseAction);
var flg_res:integer;i:byte;
begin MainForm.CloseAllWnd;bWrite.Enabled:=false;end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bWriteClick(Sender: TObject);
const bit_mask:array[0..1,0..7]of byte=((112,176,208,224,247,251,253,254),
                                          (1,2,4,8,16,32,64,128));
var a:single;i,j,alarms_enb:byte;b:word;flg:boolean;
label M,M1;
begin
  flg:=false;alarms_enb:=0;
  for i:=0 to Length(ICP.flg_set)-1 do for j:=0 to Length(ICP.flg_set[i])-1 do
  if ICP.flg_set[i,j] then begin flg:=true;Break;end;
  if ICP.flg_enb then for i:=0 to Length(ICP.flg_set)-1 do
  if check[i] then alarms_enb:=alarms_enb+Floor(Power(2,i));
  if (flg)or(ICP.flg_enb) then
  begin
    if MessageDlg('?? ????????????? ?????? ???????? ??????? ??????? ???????',
                        mtConfirmation,[mbYes,mbNo],0)= mrYes then
    begin
      bWrite.Enabled:=false;ICP.alm_enb:=alarms_enb;flg_cmd:=33;
      Screen.Cursor:=crHourGlass;Exit;
    end else
    begin
      ICP.flg_enb:=false;bWrite.Enabled:=false;
      for i:=0 to Length(ICP.flg_set)-1 do
        for j:=0 to Length(ICP.flg_set[i])-1 do ICP.flg_set[i,j]:=false;
      tcPageICPChange(Sender);Exit;
    end;
  end;
  ICP.wrt[0]:=Icp.status[2];ICP.wrt[1]:=Icp.status[0];
  ICP.wrt[2]:=Icp.status[1];
  if flg_icp[2] then
  begin                                                  {???????? ????? ??????}
    b:=StrToInt(Edit5.Text);if (b>254)or(b=0)then Goto M1;
    ICP.event:=1;ICP.wrt[0]:=b;
  end;
  if flg_icp[4] then
  begin
    ICP.event:=1;
    case ICP.status[6] of
      1:ICP.wrt[1]:=cbInputType.ItemIndex+$8;            {???: ??? ??????.???? }
      2:ICP.wrt[1]:=cbInputType.ItemIndex+$30;     {???: ??? ??????????????????}
    end;
  end;
  if flg_icp[5] then                        {?????????? ???: ??? ?????? ?????? }
  begin
    ICP.event:=1;ICP.wrt[2]:=(Icp.status[1]and $fc)+cbDataType.ItemIndex;
  end;
  if flg_icp[6] then                     {?????????? ???: ??? ??????? ???????? }
  begin
    ICP.event:=1;ICP.wrt[2]:=(Icp.status[1]and $7f)+cbFilter.ItemIndex*128;
  end;
  if flg_icp[7] then
  begin
    Icp.wrt[0]:=cbSelChan.ItemIndex; Icp.event:=15;
  end; flg:=false;
  for i:=0 to Length(flg_icp)-1 do if flg_icp[i] then begin flg:=true;Break;end;
  if flg then if MessageDlg('????????! ????????? ???????? ?????? ????? ????????'+
     Char(13)+'? ???????????? ??????. ?? ????????????? ?????? ???????? ????????? ???????',
                        mtConfirmation,[mbYes,mbNo],0)= mrYes then
  begin flg_cmd:=11; Screen.Cursor:=crHourGlass; end; bWrite.Enabled:=false;
  for i:=0 to Length(flg_icp)-1 do flg_icp[i]:=false;
  {for i:=0 to 3 do ShowMessage(IntToStr(icp_wr[i]));}Exit;
M:ShowMessage('?????????? ????! ?????????? ?????????..');Exit;
M1:ShowMessage('????????!????? ?????? ?????? ???? ?? 1 ?? 254!');flg_icp[2]:=false;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.ComboBox1Change(Sender: TObject);
begin {???????? ??? ?????????????????? }
  flg_icp[3]:=true;bWrite.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.Edit5DblClick(Sender: TObject);
begin {???????? ????? ?????? }
  flg_icp[2]:=true;bWrite.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.cbDataTypeChange(Sender: TObject);
begin {???????? ?????? ??????  }
  flg_icp[5]:=true;bWrite.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.cbFilterChange(Sender: TObject);
begin {???????? ??????? ????????   }
  flg_icp[6]:=true;bWrite.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.cbInputTypeChange(Sender: TObject);
begin {???????? ??? ????? ??????  }
  flg_icp[4]:=true;bWrite.Enabled:=true;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bCallibrClick(Sender: TObject);
begin
  if MessageDlg('?? ????????????? ?????? ????????? ?????????? ???????',
     mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    if ICP.typ>1 then pCallibrAout.Visible:=true;ICP.flg_calibr:=1;
    pCallibrAin.Visible:=true;CalibrateStep;
  end;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bExecuteClick(Sender: TObject);
begin
  case ICP.flg_calibr of
    1:
    if ICP.typ<2 then {????????? ?????????? ?????? ?????? ??????}
    begin ICP.event:=4;ICP.wrt[0]:=1;end else
    begin {?????????? ????????? ??? ?????????? ?????? ?????? ?????? ???????}
      ICP.event:=4;ICP.wrt[1]:=cbSelectChan.ItemIndex;
      if ICP.typ=2 then ICP.wrt[0]:=1 else ICP.wrt[0]:=2;
    end;
    2:
    if ICP.typ<2 then {?????????? Zero}
    ICP.event:=5 else begin ICP.event:=6;ICP.wrt[1]:=cbSelectChan.ItemIndex;end;
    3:
    if ICP.typ<2 then {?????????? Span}
    ICP.event:=6 else begin ICP.event:=5;ICP.wrt[1]:=cbSelectChan.ItemIndex;end;
  end;flg_cmd:=11;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.sgTableDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;i:integer;
begin
  if (sgTable.TopRow<>top_row)or(sgTable.LeftCol<>left_col) then
  begin flag_view:=cvOff;eAlarmSet.Visible:=false;end;
  if State=[gdSelected]then with sgTable do
  begin
    Canvas.Font.Color:=Font.Color;Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (ARow>0)and(ACol>0) then with sgTable do
  begin
    Canvas.Brush.Color:=Brush.Color;
    if ACol=1 then Canvas.Font.Color:=clBlue else if ACol=2 then
    Canvas.Font.Color:=clGreen else Canvas.Font.Color:=clBlack;
    Canvas.Font.Style:=[fsBold];str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if ICP.typ<2 then
  begin
    if (flag_view=cvEdit)and(tab_col=ACol)and(tab_row=ARow) then
    begin
      eAlarmSet.Left:=pTable.Left+sgTable.Left+Rect.Left+2;
      eAlarmSet.Top:=pTable.Top+sgTable.Top+Rect.Top+2;
    end;
    if (ARow>0)and(ACol=11)then with (Sender as TStringGrid)do
    with Canvas do for i:=0 to Length(check)-1 do if ARow=(i+1)then if check[i]then
    Draw(Rect.Left+25,Rect.Top+3,FormModbusSetting.imCheckYes.Picture.Bitmap) else
    Draw(Rect.Left+25,Rect.Top+3,FormModbusSetting.imCheckNo.Picture.Bitmap);
    if (ARow>0)and(ACol=12)then with (Sender as TStringGrid)do
    begin
      Canvas.Font.Color:=clRed;Canvas.Brush.Color:=Brush.Color;
      str:=Cells[ACol,ARow];Canvas.FillRect(Rect);
      Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bPlusClick(Sender: TObject);
begin
  if(ICP.flg_calibr=2)or(ICP.flg_calibr=3)then
  begin ICP.event:=11;ICP.wrt[1]:=cbSelectChan.ItemIndex;ICP.wrt[0]:=$02;end;
  flg_cmd:=11;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bMinusClick(Sender: TObject);
begin
  if(ICP.flg_calibr=2)or(ICP.flg_calibr=3)then
  begin ICP.event:=11;ICP.wrt[1]:=cbSelectChan.ItemIndex;ICP.wrt[0]:=$fd;end;
  flg_cmd:=11;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bPlusPlusClick(Sender: TObject);
begin
  if(ICP.flg_calibr=2)or(ICP.flg_calibr=3)then
  begin ICP.event:=11;ICP.wrt[1]:=cbSelectChan.ItemIndex;ICP.wrt[0]:=$4f;end;
  flg_cmd:=11;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.bMinusMinusClick(Sender: TObject);
begin
  if(ICP.flg_calibr=2)or(ICP.flg_calibr=3)then
  begin ICP.event:=11;ICP.wrt[1]:=cbSelectChan.ItemIndex;ICP.wrt[0]:=$b0;end;
  flg_cmd:=11;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.FormCreate(Sender: TObject);
begin
  eAlarmSet:=TEdit.Create(FormIOModulesSetting);eAlarmSet.Parent:=FormIOModulesSetting;eAlarmSet.Visible:=false;
  eAlarmSet.Font.Color:=clBlue;eAlarmSet.Font.Style:=[fsBold];
  eAlarmSet.OnKeyPress:=GoKeyPressExecute; cbSelChan.ItemIndex:=0;
  cbSelChanStart.ItemIndex:=0;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.sgTableSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  top_row:=sgTable.TopRow;left_col:=sgTable.LeftCol;
  if ICP.typ<2 then
  begin
    if (ACol=11)and(ARow>0) then
    begin
      check[ARow-1]:=not check[ARow-1];ICP.flg_enb:=true;bWrite.Enabled:=true;
    end;
    if (ACol>5)and(ARow>0)and(ARow<10)and(ACol<11)then
    begin
      eAlarmSet.Text:=sgTable.Cells[ACol, ARow];
      eAlarmSet.Height:=sgTable.RowHeights[Arow];tab_row:=Arow;
      eAlarmSet.Width:=sgTable.ColWidths[Acol];eAlarmSet.Visible:=true;
      tab_col:=Acol;flag_view:=cvEdit;eAlarmSet.SetFocus;
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormIOModulesSetting.cbSelChanChange(Sender: TObject);
begin
  bWrite.Enabled:=true; flg_icp[7]:=true;
end;
//---------------------------------------------------//

end.
