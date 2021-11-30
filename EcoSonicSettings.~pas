unit EcoSonicSettings;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, ComCtrls, Grids;

type
  TFormEcoSonicSetting = class(TForm)
    tcPageMVS: TTabControl;
    pABB: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    eValDiff: TEdit;
    eValPress: TEdit;
    eValTemp: TEdit;
    eUDiff: TEdit;
    eUPress: TEdit;
    eUTemp: TEdit;
    eLoDiff: TEdit;
    eLoPress: TEdit;
    eLoTemp: TEdit;
    eHiDiff: TEdit;
    eHiPress: TEdit;
    eHiTemp: TEdit;
    mError: TMemo;
    Label7: TLabel;
    pFs: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    cbSelDisk: TComboBox;
    mFs: TMemo;
    eNum: TEdit;
    eGut: TEdit;
    eBad: TEdit;

    procedure EAdrMVSsetKeyPress(Sender: TObject; var Key: Char);
    procedure ECbrValueKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tcPageMVSChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbSelDiskChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEcoSonicSetting: TFormEcoSonicSetting;eSetAlarm:TEdit;

implementation

{$R *.DFM}
uses Main, ConfigurationSettings, ModbusSetting;

const
  sb52='Выполняется пункт калибровки, пожалуйста подождите..';
  sb53='Выполняется установка нуля датчика перепада...';
  sb61='Возврат прибора к заводским установкам.....';
  sb62='Изменение адреса, тэга, единиц прибора.....';

  typ_cbr:array[1..5]of string[30]=('Калибровка перепада','Калибровка давления',
     'Калибровка температуры','Сдвиг нуля перепада','Коррекция нуля перепада');

var tab_col,tab_row,top_row:integer;flag_view:TComponentView;
    flg_units:boolean;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure TFormEcoSonicSetting.EAdrMVSsetKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',Char(8)])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormEcoSonicSetting.ECbrValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9','-',smb_del,Char(8)])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormEcoSonicSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin MainForm.CloseAllWnd;end;
//---------------------------------------------------//

procedure TFormEcoSonicSetting.tcPageMVSChange(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass; PRT.status:=twMvs;
  flg_cmd:=36; FormEcoSonicSetting.pABB.Visible:=true;
end;
//---------------------------------------------------//

procedure TFormEcoSonicSetting.FormCreate(Sender: TObject);
begin
  eSetAlarm:=TEdit.Create(FormEcoSonicSetting);eSetAlarm.Parent:=FormEcoSonicSetting;eSetAlarm.Visible:=false;
  eSetAlarm.Font.Color:=clBlue;
  pFs.Left:=0; pFs.Top:=0; cbSelDisk.ItemIndex:=0;
end;
//---------------------------------------------------//

procedure TFormEcoSonicSetting.cbSelDiskChange(Sender: TObject);
begin
  Screen.Cursor:=crHourGlass; flg_cmd:=38;
end;
//---------------------------------------------------//

end.
