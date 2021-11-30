unit Main;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ActnList, Menus, ComPort, Math, ConfigurationSettings,
  EcoSonicSettings, FormForView, InOutModulesSetting, Grids, ComCtrls, CheckLst,
  ToolWin, ModbusSetting, ImgList, Printers;
type
  TMainForm = class(TForm)
    MainMenu: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList1: TActionList;
    aOpenComm: TAction;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    PCommunic: TPanel;
    Label5: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EAdrDev: TEdit;
    EPasswDev: TEdit;
    EPasswProg: TEdit;
    gbSelLink: TGroupBox;
    BLink: TBitBtn;
    BSave: TBitBtn;
    aSaveConf: TAction;
    aOnLine: TAction;
    aLoadConfig: TAction;
    aMVS205: TAction;
    aICPmodule: TAction;
    aEvents: TAction;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ComPort: TComPort;
    Timer1: TTimer;
    Timer3: TTimer;
    N6: TMenuItem;
    N7: TMenuItem;
    Panel2: TPanel;
    StatusBar: TStatusBar;
    Label9: TLabel;
    ePhoneNumber: TEdit;
    Label10: TLabel;
    eAT: TEdit;
    Label11: TLabel;
    cbSelModem: TComboBox;
    chTone: TCheckBox;
    chLine: TCheckBox;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    pSelPageConf: TPanel;
    clListConf: TCheckListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    N12: TMenuItem;
    aAlarms: TAction;
    N8: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    tmModem: TTimer;
    eStatus: TEdit;
    tmDelay: TTimer;
    cbAnsModem: TComboBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    cbSelLink: TComboBox;
    Label2: TLabel;
    cbNamePort: TComboBox;
    cbBaud: TComboBox;
    Label12: TLabel;
    aNst: TAction;
    N16: TMenuItem;
    N17: TMenuItem;
    aMbfunc: TAction;
    aMbhost: TAction;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    cbData: TComboBox;
    cbStop: TComboBox;
    cbParity: TComboBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EDelay: TEdit;
    ETimeOut: TEdit;
    ERetryCnt: TEdit;
    N20: TMenuItem;
    N15: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    ICP1: TMenuItem;
    MVS2052: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ImageList1: TImageList;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    aMonitor: TAction;
    aHourArch: TAction;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    aLoadScript: TAction;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    GroupBox5: TGroupBox;
    eArchRec: TEdit;
    eEventRec: TEdit;
    eAlarmRec: TEdit;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N111: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    PDF1: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    procedure aOpenCommExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure aSaveConfExecute(Sender: TObject);
    procedure cbSelLinkChange(Sender: TObject);
    procedure EAdrDevKeyPress(Sender: TObject; var Key: Char);
    procedure aOnLineExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure aLoadConfigExecute(Sender: TObject);
    procedure aEventsExecute(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure EAdrDevDblClick(Sender: TObject);
    procedure EPasswProgDblClick(Sender: TObject);
    procedure EPasswDevDblClick(Sender: TObject);
    procedure EDelayDblClick(Sender: TObject);
    procedure ETimeOutDblClick(Sender: TObject);
    procedure ERetryCntDblClick(Sender: TObject);
    procedure cbSelModemChange(Sender: TObject);
    procedure chToneClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure aAlarmsExecute(Sender: TObject);
    procedure tmModemTimer(Sender: TObject);
    procedure tmDelayTimer(Sender: TObject);
    procedure cbBaudChange(Sender: TObject);
    procedure aNstExecute(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure aMonitorExecute(Sender: TObject);
    procedure aHourArchExecute(Sender: TObject);
    procedure aICPmoduleExecute(Sender: TObject);
    procedure aMVS205Execute(Sender: TObject);
    procedure aMbfuncExecute(Sender: TObject);
    procedure aMbhostExecute(Sender: TObject);
    procedure aLoadScriptExecute(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
  private
    { Private declarations }
    function ReadConfigFile:boolean;
    procedure InitialComport(baud,data,stop,parity:integer);
    procedure WriteConfigFile(baud,data,stop,parity:integer;flag:boolean);
    procedure ReadFromDevice;
    procedure SendStrToDev;
    procedure AnsFromDev;
    procedure FileName;
    procedure LoadInterface(name_arch:string;typ:byte);
  public
    { Public declarations }
    procedure EventType(cb:TComboBox;ind:byte);
    procedure EventTypeT(list:TStrings;ind:byte);
    procedure LongToBynare(val:longword;var a,b,c,d:byte);
    procedure ConvertToLong(a,b,c,d:byte;var val:longword);
    procedure PrepareSend(kop:byte);
    procedure FloatToBynare(val:single;var a,b,c,d:byte);
    function  ConvToFloat(a,b,c,d:byte;var val:single):boolean;
    procedure CalcCRC32(buffer:array of byte;count:byte;var kod:longword);
    procedure SendToDevice;
    procedure LoadArchive(name_arch:string;typ:byte);
    procedure GetListModems;
    procedure CloseAllWnd;
    procedure EnableStatusMessage;
  end;

  const conf_all:array[0..103]of string[24]=(''{0},'������ �����'{1},
   '����� ���� ������. ����'{2},'����� ����� ���. �������'{3},
   '����� ����� ��������'{4},'����� ����� �����������'{5},
   '����� ����� ��. �������.'{6},'������ �������'{7},'����� �������������'{8},
   '������������� ��������'{9},'������� �������'{10},'������� ������������'{11},
   '������� (������) ��'{12},'������� �����. �������'{13},
   '�����. ������. ���������'{14},'����. ������. ���������'{15},
   '��������� ������ ������'{16},'������������� ���������'{17},
   '��� � ������������'{18},'��� � ������������'{19},'��� � ������������'{20},
   '��� � ��������� ����.'{21},'��� � ��������� ����.'{22},'��� � ��������� ����.'{23},
   '���. ����� �������'{24},'����. ����� �������'{25},'���. ����� ���.����'{26},
   '����. ����� ���.����'{27},'���������� ���. ���.����'{28},'���. ����� ��������'{29},
   '����. ����� ��������'{30},'���������� ���. ��������'{31},'���. ����� �����������'{32},
   '����. ����� �����������'{33},'���������� ���. ��������'{34},'��� �������������'{35},
   '����� �����������'{36},'����������� ���'{37},
   '�������� ���������'{38},'����� EcoSonic #1'{39},'����� EcoSonic #2'{40},
   '����� EcoSonic #3'{41},'����� EcoSonic #4'{42},'������� �� ������/������'{43},
   '������ ��� ���������'{44},'����� ICP #1'{45},'����� ICP #2'{46},
   '����� ICP #3'{47},'����� ICP #4'{48},'������'{49},
   '���������� �����'{50},'��������� ������'{51},'��� ICP #1'{52},
   '��� ICP #2'{53},'��� ICP #3'{54},'��� ICP #4'{55},
   '�������� �����'{56},'�������� �������'{57},
   'Modbus'{58},'COM'{59},'�������� #'{60},
   '������ ��������������'{61},'Hart'{62},'��������� ���. �������'{63},
   '����� �������'{64},'������� ��������� AIN #'{65},'������ ������� AIN #'{66},
   '������� ������� AIN #'{67},'�������� #'{68},'���������'{69},'����'{70},
   '�����. ���'{71},'���� ���������'{72},'Data #'{73},'��������� �������'{74},
   '����� ������� ��� ������'{75},'���������� ���. �������'{76},
   '������� ��������� AOUT #'{77},'������ ������� AOUT #'{78},
   '������� ������� AOUT #'{79},'������'{80},'���. ����� ������'{81},
   '������� ����� ������'{82},'���������� ������'{83},'���. ����� ���������'{84},
   '������� ����� ���������'{85},'���������� ���������'{86},'����� �������� #1'{87},
   '��������� �����'{88},'��������� ����'{89},'���'{90},'�����'{91},'����'{92},
   '���'{93},'������'{94},'������� �����������'{95},'������ �����������'{96},
   '���������� �������'{97},'����� ��������� #2'{98},'�������/������� ���. #'{99},
   '������� ����'{100},'����� ����� ������'{101},'����� ���������'{102},
   '������������� ABB'{103});

   dyn_all:array[0..70]of string[25]=(''{0},'������� ������'{1},'�������� ���'{2},
   '�����������'{3},'���������'{4},'������ ��������'{5},
   '������ ��������'{6},'���������'{7},'������ ����. �� ��.��� '{8},
   '������ �����. �� ��.��� '{9},'����� �����'{10},
   '������� �� ��.��� '{11},'���� '{12},'��� ���'{13},'����� �����'{14},'�����'{15},
   '����'{16},'������'{17},'������� �����'{18},'�-�����'{19},
   '� �����������'{20},'� �������'{21},'� ����������'{22},'� ���������'{23},
   '� �������������'{24},'� ����������'{25},'����� ����������'{26},
   '�������� �����.'{27},'�������� ������'{28},'�������� ���������'{29},
   '���������� ��������'{30},'����� �����������'{31},
   '����� �����'{32},'�-�����'{33},'�-������'{34},'�-������'{35},'������'{36},
   '�������'{37},'������� ���.'{38},'������'{39},'�����'{40},'�����'{41},
   '�����'{42},'���� ���'{43},'��������'{44},'�������'{45},'�����������'{46},
   '�����'{47},'������'{48},'��������� �������'{49},'Register #'{50},
   '����������'{51},'����� ��������'{52},'��������� ������.'{53},'������'{54},
   '�����'{55},'������ ���������'{56},'���������'{57},'Drive Gain'{58},
   'Live Zero'{59},'������� �����������'{60},'��������� �����'{61},
   '��������� ����'{62},'������ ��'{63},'����� ��'{64},'��������� ��'{65},
   '����'{66},'����� �����'{67},'����� �����'{68},'������ �� ��. ���'{69},
   '� ���������'{70});

  select_all:array[0..125]of string[25]=('���������'{0},'��������'{1},'��������� (�������)'{2},
   '��������� (���������)'{3},'��������� (���������)'{4},'������� +10S'{5},
   '������� +15/16S'{6},'������� +25/26S'{7},'������� +35/36S'{8},
   '������� +45/46S'{9},'������� 485_Size_1'{10},'������� 485_Size_2'{11},
   '������� 485_Size_3'{12},
   '�������� ����������'{13},'���������'{14},'EcoSonic #1'{15},'EcoSonic #2'{16},
   'EcoSonic #3'{17},'EcoSonic #4'{18},'AIN #1'{19},'AIN #2'{20},'AIN #3'{21},'AIN #4'{22},
   'AIN #5'{23},'AIN #6'{24},'AIN #7'{25},'AIN #8'{26},'AIN #9'{27},'AIN #10'{28},
   'AIN #11'{29},'AIN #12'{30},'AIN #13'{31},'AIN #14'{32},'AIN #15'{33},
   'AIN #16'{34},'������ DIO ������'{35},'������ DIO ������'{36},
   'RTD #3'{37},'RTD #4'{38},'RTD #5'{39},
   'RTD #6'{40},'����'{41},'���'{42},'�������� (������)'{43},'��������� (�������)'{44},
   '������� ������'{45},'��������'{46},'�����������'{47},'������ ����������'{48},
   '������ '{49},
   '��������� � ���3 '{50},'��������� � ���1'{51},'��������� � ���2'{52},'����'{53},
   '������'{54},'������ AIN ������'{55},'������ AIN ������'{56},
   '������ AOUT ������'{57},'������ AOUT ������'{58},'��������'{59},'�����������'{60},
   '����� 8'{61},'����� 10'{62},'����� 15'{63},'�� 15�/20�'{64},'����� 16�'{65},
   '����� 20'{66},'����� 25'{67},'����� 30/35'{68},'�6��/�7��'{69},'12��'{70},
   '12�18�9/10�'{71},'316 (S31600/CF8M)'{72},'14X17H2'{73},'15���'{74},'15X1�10'{75},
   '15�5�'{76},'17�18�9'{77},'20�23�13'{78},'36�18�25�2'{79},
   '301 (S30100)'{80},'12X1��'{81},'15�1�1�'{82},'15�12����'{83},'NX-19 mod'{84},
   'GERG-91 mod'{85},'����-���'{86},'�������������'{87},'����������'{88},
   'I-7060'{89},'I-7080'{90},'I-7040'{91},'������������'{92},'�� ����������'{93},
   '�� ����������'{94},'����������'{95},'�� ������ �������'{96},
   '�� ����� ������������'{97},'����� 40/45'{98},'����� 20�'{99},'����� 25�'{100},
   '����� 35�'{101},'����� 45�'{102},'12�18�10�/12�'{103},'12�18�9��'{104},
   '25�1��'{105},'18�2�4��'{106},'12�19�9�'{107},'10�14�14�4�'{108},
   '31�19�9����'{109},'37�12�8�8���'{110},'���������'{111},'�������������'{112},
   '�������������'{113},'������ PIN ������'{114},'��������� 1195'{115},'������ RTD'{116},
   'RTD #1'{117},'RTD #2'{118},'RTD #3'{119},'RTD #4'{120},'RTD #5'{121},
   'RTD #6'{122},'����������������'{123},'MVS205'{124},'ABB-267CS'{125});

  units_all:array[0..33]of string[10]=(''{0},', ��'{1},', ���'{2},', '+Char(176)+'�'{3},
    ', �3/�'{4},', �/�'{5},', ���'{6},', ����'{7},', ��/�3'{8},', ��*�'{9},
    ', �/�'{10},', �-6/'+Char(176)+'�'{11},', ���/��'{12},', �'{13},
    ', �3'{14},', ���/�'{15},', ����/�'{16},', ��.�3/�'{17},', ��.�3'{18},
    ', ����/��'{19},', ���� %'{20},', ����� %'{21},', ���'{22},', ��� ��3'{23},
    ', ��/�'{24},', ����/�'{25},', ��'{26},', �����'{27},', ��� ���'{28},
    ', ���*�'{29},', %'{30},', �'{31},', �/��3'{32},', c'{33});

  units_all_bis:array[0..33]of string[10]=(''{0},' ��'{1},' ���'{2},' '+Char(176)+'�'{3},
    ' �3/�'{4},' �/�'{5},' ���'{6},' ����'{7},' ��/�3'{8},' ��*�'{9},
    ' �/�'{10},' �-6/'+Char(176)+'�'{11},' ���/��'{12},' �'{13},
    ' �3'{14},' ���/�'{15},' ����/�'{16},' ��.�3/�'{17},' ��.�3'{18},
    ' ����/��'{19},' ���� %'{20},' ����� %'{21},' ���'{22},' ��� ��3'{23},
    ' ��/�'{24},' ����/�'{25},' ��'{26},' �����'{27},' ��� ���'{28},
    ' ���*�'{29},' %'{30},' �'{31},' �/��3'{32},' �'{33});

  name_expand:array[0..6]of string[15]=(' ',' ���',' �����',' �� ���',
    ' �����',' �� ���',' ���');

  name_expand_oil:array[0..8]of string[15]=(' ',' ���',' 4 ���',' �����',' �� ���',
    ' �����',' �� ���',' ',' �����');

  code_script:array[0..25]of string[19]=('END'{0},'VAL, RR=ARG'{1},'SAV, ARG=RR'{2},
  'ADD, RR=RR+ARG'{3},'SUB, RR=RR-ARG'{4},'MUL, RR=RR*ARG'{5},'DIV, RR=RR/ARG'{6},
  'AND, RR=RR AND ARG'{7},'OR, RR=RR OR ARG'{8},'XOR, RR=RR XOR ARG'{9},
  'ABS, RR=Abs(ARG)'{10},'EXP, RR=Exp(ARG)'{11},'LN, RR=Ln(ARG)'{12},
  'LOG, RR=Log10(ARG)'{13},'SQR, RR=Sqr(ARG)'{14},'POW, RR=Pow(RR,ARG)'{15},
  'If RR=ARG Goto M'{16},'If RR<>ARG Goto M'{17},'Goto M'{18},'If RR>ARG Goto M'{19},
  'If RR>=ARG Goto M'{20},'If RR<ARG Goto M'{21},'If RR<=ARG Goto M'{22},
  'Wait 1 sec'{23},'Wait 5 sec'{24},'Wait 20 sec'{25});

  pnt_script:array[0..18]of string[18]=('���������','������� #1','������� #2',
    '������� #3','������� #4','��������������','���-���������','EcoSonic #1',
    'EcoSonic #2','EcoSonic #3','EcoSonic #4','������ AIN','������ AIN',
    '������ AOUT','������ AOUT','������ DIO','������ DIO','������ PO','������ PO');

  exp_arch:array[0..4]of string[15]=(' �������',' ������',' �����',' �����',' ���');

  set_arch:array[0..4]of byte=(0,2,3,4,6);

  scal:array[0..5]of string[30]=('��������� ������ �������',
                  '��������� ������� �������','��������� ������ �����',
                  '��������� ������ �����','��������� ������� �����',
                  '���������� ���������');

  nameICP:array[1..7]of string[20]=('I-7012 (1 �����)','I-7017 (8 �������)',
                 'I-7022 (2 ������)','I-7024 (4 ������)','I-7060 (4 ������)',
                 'I-7015 (6 �������)','I-7080 (2 ������)');

  str_status:array[0..7]of string[60]=('��������� ���: ���� 8.563-97,�� 2667-2004',
      '�������� �������: ���� 8.563-97,�� 2667-2004',
      '��������� ���: ���� 8.586-2005,�� 2667-2004',
      '�������� �������: ���� 8.586-2005,�� 2667-2004','���� ����������� ���������',
      '���������� ������������','���� �����','���� �������');

  sel_pnt:array[0..3]of string[15]=('���������','�������','��������.','����/�����');

  log_pnt:array[0..3]of string[15]=('������','������','������','��������');

  prm_dt:array[0..5]of string[15]=('���','�����','����','���','������','�������');

  etl:array[0..7]of byte=(1,2,4,8,16,32,64,128);

  ind_conf:array[0..7]of byte=(7,0,1,2,3,4,6,5);{����� ������.�������� �����������}

  size_event=16;

  pnt_str:array[0..3]of string[4]=(' #1',' #2',' #3',' #4');

  str_func:array[0..9]of string[35]=
      ('1 (������ ���������� �����)','2 (������ ���������� ������)',
       '3A (������ ��������� ��������)','3B (������ ��������� ��������)',
       '4A (������ ������� ���������)','4B (������ ������� ���������)',
       '5 (������ � ���������� ������)','6 (������ � ������� ��������)',
       '15 (������ � ������ ���.�����)','16 (������ � ��. ���.��������)');

  str_host:array[0..2]of string[25]=('�������� � (1 - 30)',
        '�������� B (31 - 60)','�������� C (61 - 90)');

  sNameEvt=       'c:\��� ���������\gas_event.txt';
  sNameAlm=       'c:\��� ���������\gas_alarm.txt';
  sNameMonth=     'c:\��� ���������\gas_month.txt';

//29.11.2021 YN added:
  units_press:array[0..13]of string[10]=(' ','InH2O','InHg','FtH2O','mmH2O'{4},
                 'mmHg','PSI','bar','mbar','g/cm2','kg/cm2','PA','kPA','torr');

  units_temp:array[0..3]of string[10]=('dgC','dgF','dgR','Kelvin');

  str_err:array[0..31]of string[40]=('Hardware error','Memory error',
           'Measurement error','Configuration invalid','Maitenance required',
           'EEPROM error mainboard','EEPROM error sensor',
           'max.write cyles EEPROM mainboard','max.write cyles EEPROM sensor',
           'EEPROM error electronic data','EEPROM error sensor data',
           'EEPROM error user data','EEPROM error factory data',
           'Saving EEPROM data','Device busy','ROM error','RAM error',
           'Device mailfunction','Software mailfunction',' ',
           'Diffpres input out range','Pressure input out range',
           'Temperature input out range','Temperature transducer out limit',
           'Temperature transducer out range','Pressure transducer out limit',
           'Pressure transducer out range',' ',' ',' ',' ',' ');

type Conf=record                         {���������������� ��������� ����������}
      c_string:array[0..9]of string[40];     {���������� �����,��������� ������}
      c_byte:array[0..49] of word;  {��������� �����:���,�����,��� �����,������;
                                  ����� �����,��������,����-���,����� ��������}
      c_long:array[0..10] of longword;{������}
      c_name:array[0..255]of string[20];
end;

var f_conf:file of conf;                    {���������� ����������������� �����}
    d_conf:conf;                         {���������� ���������������� ���������}

type Archive=record                                         {���������  ������ }
     a_time:TDateTime;a_type:byte;
     a_data:array[0..39] of single;
end;

var f_arc:file of Archive;                            {���������� �����  ������}
    d_arc:Archive;                                {���������� ���������  ������}

type Event=record
     a_event:array[0..size_event-1] of byte;
end;

var f_event:file of Event;d_event:Event;

type TComponentView=(cvSelect,cvCheck,cvEdit,cvOff);

type TArchive=record                                  {��������� �������� �����}
     pnt,logn,num,offset:byte;
end;

type TTypeWind =(twNone,twConf,twEvent,twAlarm,twNst,twHour,twDay,twMin,twIcp,
                twMvs,twMonitor,twModbusFunc,twModbusHost,twModbusScale,twHart,
                twScript,twDispExp,twSaveConfig,twLoadConfig,twUser,
                twModbusStatus);

type TProgramRunTime=record
     flg_reciv,flg_ver,flg_picker,flg_first,flg_end,flg_port:boolean;
     status:TTypeWind;count_str,cnt_err,cnt_intv:word;
     number_arc,size_arc,pool,addr_buf,num_prm,load_visible,load_update:byte;
     typ_task:byte; cnt_pool:longword;
end;

type TLoadDescript=record
     addr:word;step:byte;flg_end:boolean;end;

type                  {�����������:�������,������� �����,�������� �����,�������}
  TSetConfigPrm=record name,size,addr,typ,num,units:byte;
end;

type TConfigSelect=record num:byte;selset:array of byte;end;

type                              {�����������:������������ ����� ������� �����}
  TSetDynamPrm=record addr,size,typ,units,script,verify,name,clear,modbus:byte;
end;

type TSetModbusFunc=record addr:word;pnt,logn,prm,conv:byte;end;

type TSetModbusHost=record reg,new:word;addr,func,count,status:byte;end;

type TSetModbusScale=record lo_val,hi_val:single;end;

type {�����������:�������� �����}
  TSetArchivePrm=record units,typ,addr,name:byte;
end;

type TSetClear=record number:array of byte;flag:boolean;end;

type TModbus=record mode,pool,com,delay,select:byte;end;

type TSetScript=record op_code,pnt,param,num:byte;value:single;transit:word;end;

var f_script:file of TSetScript;                      {���������� ����� �������}
    d_script:TSetScript;                          {���������� ��������� �������}

type TModulICP=record
     addr:array[0..3]of byte;
     typ,alm_enb:byte;
     lo_brd,hi_brd:array[0..7]of single;
     units,alm_status:array[0..7]of byte;
     status:array[0..6]of byte;        {��� �����,������,��� ������,����� ������}
     alm_set:array[0..7,0..4]of single;
     flg_set:array[0..7,0..4]of boolean;
     flg_enb:boolean;
     wrt:array[0..2]of byte;      {������ ��� ��� ������ ��� ������/���� ������}
     value:array[0..7]of single;                        {������ �������.�������}
     event,flg_calibr:byte;
end;

type TSetupPort=record baud,data,stop,parity,t_a,typ:byte;flag:boolean;end;

type TVerifyInput=record data:single;row,num:byte;enable:boolean;end;

type TConfigData=record
     flag:boolean;                {������� ��������� ������. �����. �����������}
     num:byte;                                           {�������� ������ �����}
     val:array of byte;                                     {�������� ���������}
end;

type TConfigAllData=record
     buf:array[0..239]of byte;                      {�������� ��������� �������}
     setwr:array of TConfigData;
     ver_input:array of TVerifyInput;           {�������� �����.������� �������}
end;

type TMVS =record
     byn:array[0..2]of byte;                                 {�����, ��., ����.}
     tag:string[10];
     prm:array[0..20]of single;                          {������ ���������� MVS}
     alm_set:array[0..2,0..2]of single;
     alm_status:array[0..2]of byte;alm_enb:byte;
     flg_set:array[0..2,0..2]of boolean;flg_enb:boolean;
end;

type TPointer =record
     page,minute:byte;event,alarm,error,archive,cnt_arch,cnt_event:word;
end;

var
  MainForm: TMainForm;cbStatus:TComboBox;Typ_task:byte;       {���������� �����������}
  Arch:array of TArchive;                  {��������� ���������� �������� �����}
  SetClear:TSetClear;
  PRT:TProgramRunTime;
  ICP:TModulICP;
  SetPort:array[0..7]of TSetupPort;
  Load:TLoadDescript;
  ConfData:TConfigAllData;
  ModbusConf:TModbus;
  Sensor:TMVS;
  Pntr, Older, Newest:TPointer;
  ConfSet,MainSet,ConfSetIcp,ConfSetExp:array of TSetConfigPrm;{������ �������� ������������}
  Select,SelMain,SelIcp,SelExp:array of TConfigSelect;{������ �������� ���������� ������}
  Dyn,DynExp:array of TSetDynamPrm;{����� �������� ������������ ����������}
  ArchBasicSet,ArchExpandSet:array of TSetArchivePrm;
  ModbusFunc:array of TSetModbusFunc;ModbusHost:array of TSetModbusHost;
  ModbusScale:array[0..11]of TSetModbusScale;
  ScriptData:array of TSetScript;
  send,recive:array[0..255]of byte;smb_del:char;list:TStringList;
  sFile:AnsiString;Disp:array of single;
  alm_stat,media_heat,hight_disp,set_modbus,set_hart:byte;
  dot_verify:array[0..19]of byte;                 {����� �������� ����� �������}
  password:longword;               {������ ��� ��������� � ����������� � �����.}
  calc_in:array[0..3,0..2]of single;{�������� ������� ����.��� ������ }
  mvs_cmd:array[0..1]of byte;
  mvs_val:single;//������.����� � MVS
  cnt_send, cnt_recive, pnt_arch_old:word;
  mvs_cbr, stp_cbr, page_flow, flg_cmd, flg_yes, mvs_ret:byte;
  flg_icp:array[0..7]of boolean;  row:word;
  Fname:string; contract:word;
  modbus_val:array[0..23]of single;check:array[0..29]of boolean;
  flg_reload:boolean;{������������ ������������ ��� ������ ����� ����� ������}
  num_page_conf,ind_prm_alm:array of byte;{��������� ���������������� �������}
  num_item_conf:array of array[0..4]of byte;flg_set_conf:boolean;
  namea,namet,namer:string;buff_archive:array of Archive;
  buff_event:array of Event; flg_config:boolean;
  old_rec_arc:Archive;
  old_rec_evt:Event;
  units_report:array of string;
  s_long:array[0..10] of longword;      {��������� �������� ��������� ���������}
  s_byte:array[0..49] of word;          {��������� �������� ��������� ���������}
implementation

uses script,report,ViewTheArchiveFromFile;
{$R *.DFM}
const strErr:array[1..4]of string[60]=
             ('����������� �� ��������, ��������� ����������!',
              '������������ ������ ������������ ����!',
              '������ ������������! ��������� ������������ ����������!',
              '���������������� �������!');

  sbarc:array[0..11]of string[70]=
    (' ',
    '��� �������� �������� ������ �� �����������, ���������� ���������...',
    '��� �������� ��������� ������ �� �����������, ���������� ���������...',
    '��� �������� ��������� ������ �� �����������, ���������� ���������...',
    '��� �������� ������� ������� �� �����������, ���������� ���������...',
    '��� �������� ������� ������� �� �����������, ���������� ���������...',
    '��� �������� ������� ��������� ��������, ���������� ���������...',
    '�������� ������������ ����� ������ �� ������, ���������� ���������    ',
    '�������� ������ ����� ������ ��������� �����, ���������� ���������...',
    '��� ������ ������������ �� �����������, ���������� ���������   ',
    '��� ������ ������������ � �����������, ���������� ���������    ',
    '���������� ������������ �� �����������, ���������� ���������    ');

  strAT:array[0..2] of string[20]=('ATZ','ATI4','+++');size_panel=111;

var
  f_config:file of byte;{���������� ����������������� ����� �����������}
  Main_config:array[0..7,0..255]of byte;
  flg_modem,rpt_ck,page_mvs,rpt_tmr,rpt_mdm_tmr,rpt_com,flg_err,size_disp,
  fl_ans,conf_page,fl_err:byte;
  cnt_interv:word;start_time,now_time,crDT:TDateTime;
  fl_end, fl_rsv, flg_save, flag_list:boolean;
  platform:cardinal;mdm_comport:array[0..4] of string[10];key_mdm:hkey;
  key_reg:array[0..4]of hkey;key_reg_mdm:array[0..4] of hkey;
  musor,kod:longword;s_at,s_comp,mdm_name:string;
  list_err:TStringList;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure TMainForm.AnsFromDev;
const s:array[0..5] of string[7]=('OK','CONNECT','ERROR','NODIAL','NOCARR','BUSY');
var i,j,g,k:word;smb:char;str:string;flg:boolean;
begin
  if ComPort.InputCount=0 then begin fl_rsv:=false;Exit;end;
  for i:=1 to ComPort.InputCount do
  begin
    smb:=ComPort.ReadChar;
    if smb=Char(13) then
    begin
      smb:=' ';
      if Length(s_comp)>0 then
      begin  {StaticText1.Caption:=s_comp; }
        if fl_end=false then if Length(s_comp)>10 then
        begin fl_end:=true;mdm_name:=s_comp end;
        s_comp:=Trim(s_comp);j:=0;str:='';
        if s_comp<>'' then cbAnsModem.ItemIndex:=cbAnsModem.Items.Add(s_comp);
        for g:=1 to Length(s_comp) do
          if Copy(s_comp,g,1)<>' ' then str:=str+Copy(s_comp,g,1);
        repeat
          flg:=false;k:=0;
          repeat
            if Copy(str,k+1,1)<>Copy(s[j],k+1,1) then
            begin flg:=true;Break;end;k:=k+1;
          until (k=Length(s_comp))or(k=Length(s[j]));
          if flg=false then Break;j:=j+1;
        until j>=6;
      end else flg:=true;s_comp:='';
      if flg=false then begin fl_ans:=j;fl_rsv:=true end;
    end  else s_comp:=s_comp+smb;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.SendStrToDev;
begin
  s_at:=s_at+Char(13);
  ComPort.PurgeInput;ComPort.PurgeOutput;ComPort.SetRTS;
  ComPort.WriteString(s_at);ComPort.WaitForWriteCompletion;
  ComPort.ClearRTS;tmModem.Enabled:=true;
end;
//---------------------------------------------------//

procedure TMainForm.GetListModems;
const {��������� �� ������� ������ ������������� �� ���������� �������}
  name_98:array[0..3]of PChar=('CurrentControlSet','Services','Class','Modem');
  name_NT:array[0..3]of PChar=('CurrentControlSet','Control','Class',
                               '{4D36E96D-E325-11CE-BFC1-08002BE10318}');
  name_num:array[0..4]of Pchar=('0000','0001','0002','0003','0004');
  sub_name:array[0..1]of PChar=('Model','AttachedTo');
var res:integer;i,k:byte;s:array[0..4]of string;key_value:Pointer;
    valtype,number:longword;struct:_OSVERSIONINFOA;res_ver:boolean;
label M;
begin
  CBSelModem.Items.Clear;
  struct.dwOSVersionInfoSize:=sizeof(OSVERSIONINFO);
  res_ver:=GetVersionEx(struct);{��������� ������ ������������ �������}
  if res_ver=true then platform:=struct.dwPlatformId else Exit;
  res:=RegOpenKeyEx(HKEY_LOCAL_MACHINE,'System',0,KEY_READ,key_reg[0]);
  if res<>ERROR_SUCCESS then Goto M;
  case platform of
   1:begin
      for i:=0 to 3 do
      begin
        res:=RegOpenKeyEx(key_reg[i],name_98[i],0,KEY_READ,key_reg[i+1]);
        if res<>ERROR_SUCCESS then Goto M;
      end;
     end;
   2:begin
      for i:=0 to 3 do
      begin
        res:=RegOpenKeyEx(key_reg[i],name_NT[i],0,KEY_READ,key_reg[i+1]);
        if res<>ERROR_SUCCESS then Goto M;
      end;
     end;
  end;
  for i:=0 to 4 do
  begin
   res:=RegOpenKeyEx(key_reg[4],name_num[i],0,KEY_READ,key_reg_mdm[i]);
   if res<>ERROR_SUCCESS then
   begin
     if i=0 then
     begin
       ShowMessage('�� ���������� ������������� �������!');
       cbNamePort.Enabled:=true;Exit;
     end else Break;
   end;
   for k:=0 to 1 do
   begin
     number:=100;GetMem(key_value,number);
     res:=RegQueryValueEx(key_reg_mdm[i],sub_name[k],nil,@valtype,key_value,@number);
     if  res<>ERROR_SUCCESS then Goto M;
     s[k]:=PChar(key_value);
   end;
   mdm_comport[i]:=s[1];s[0]:=s[0]+'('+s[1]+')';//ShowMessage(mdm_comport[i]);
   CBSelModem.ItemIndex:=CBSelModem.Items.Add(s[0]);
  end;
  RegCloseKey(HKEY_LOCAL_MACHINE);
  for i:=0 to 4 do RegCloseKey(key_reg[i]);Exit;
M:ShowMessage('������ ��� ������ � ��������� ��������!');
end;
//---------------------------------------------------//

function TMainForm.ReadConfigFile:boolean;
var flg_res:integer;i:byte;
begin //������ ����������������� ����� � ������ ����������� � ����������
  AssignFile(f_conf,Fname);{$I-} Reset(f_conf);{$I+} flg_res:=IOResult;
  if flg_res=0 then
  begin
    Read(f_conf,d_conf);
    with d_conf do
    begin
      cbSelLink.ItemIndex:=c_byte[0];cbNamePort.ItemIndex:=c_byte[1];
      s_byte[2]:=c_byte[2];s_byte[3]:=c_byte[3];
      s_byte[4]:=c_byte[4];s_byte[5]:=c_byte[5];
      s_byte[6]:=c_byte[6];s_long[0]:=c_long[0];s_long[1]:=c_long[1];
      EAdrDev.Text:=IntToStr(s_byte[2]);EDelay.Text:=IntToStr(s_byte[3]);
      ETimeOut.Text:=IntToStr(s_byte[4]);ERetryCnt.Text:=IntToStr(s_byte[5]);
      EPasswDev.Text:=IntToStr(s_long[0]);EPasswProg.Text:=IntToStr(s_long[1]);
      ePhoneNumber.Text:=c_string[0];eAT.Text:=c_string[1];
      FormForReports.eIdentif.Text:=c_string[2];
      if c_byte[6]=1 then chLine.Checked:=true else chLine.Checked:=false;
      if c_byte[7]=1 then chTone.Checked:=true else chTone.Checked:=false;
      cbBaud.ItemIndex:=c_byte[8];cbData.ItemIndex:=c_byte[9];
      cbStop.ItemIndex:=c_byte[10];cbParity.ItemIndex:=c_byte[11];
      Older.page:=c_byte[12];Older.archive:=c_byte[13]*256+c_byte[14];
      Older.event:=c_byte[15]*256+c_byte[16];
      Older.alarm:=c_byte[17]*256+c_byte[18];
      for i:=0 to 13 do s_byte[20+i]:=c_byte[20+i]; FileName;
      AssignFile(f_arc,namea);{$I-}Reset(f_arc);{$I+} flg_res:=IOResult;
      if flg_res = 0 then
      begin eArchRec.Text:=IntToStr(FileSize(f_arc));CloseFile(f_arc);end else
      eArchRec.Text:='0';
      AssignFile(f_event,namet);{$I-}Reset(f_event);{$I+} flg_res:=IOResult;
      if flg_res = 0 then
      begin eEventRec.Text:=IntToStr(FileSize(f_event));CloseFile(f_event);end else
      eEventRec.Text:='0';
      AssignFile(f_event,namer);{$I-}Reset(f_event);{$I+} flg_res:=IOResult;
      if flg_res = 0 then
      begin eAlarmRec.Text:=IntToStr(FileSize(f_event));CloseFile(f_event);end else
      eAlarmRec.Text:='0'; flg_config:=true;
      MainMenu.Items.Items[9].Visible:=true;
      //ShowMessage(IntToStr(Older.page)+' '+IntToStr(Older.archive)+' '+IntToStr(Older.event)+' '+IntToStr(Older.alarm));
    end;CloseFile(f_conf);result:=true;bLink.Enabled:=true;
  end else result:=false;
end;
//---------------------------------------------------//

procedure TMainForm.CloseAllWnd;
begin
  FormEcoSonicSetting.Visible:=false;FormForVariablesView.Visible:=false;FormModbusSetting.Visible:=false;
  FormIOModulesSetting.Visible:=false;FormForScript.Visible:=false;FormConfigurationSettings.FormStyle:=fsNormal;
  FormEcoSonicSetting.FormStyle:=fsNormal;FormForVariablesView.FormStyle:=fsNormal;FormModbusSetting.FormStyle:=fsNormal;
  FormIOModulesSetting.FormStyle:=fsNormal;FormForScript.FormStyle:=fsNormal;PRT.status:=twNone;
  FormForReports.Visible:=false;FormForReports.FormStyle:=fsNormal;
  cbStruct.Visible:=false;eStruct.Visible:=false;bStep.Visible:=false;
  cbScript.Visible:=false;eScript.Visible:=false;
  PRT.load_visible:=0;StatusBar.Panels.Items[0].Width:=size_panel;
  cbStatus.Visible:=true;FormForReports.BitBtn1.Enabled:=false; MainForm.Visible:=true;
end;
//---------------------------------------------------//

procedure TMainForm.InitialComport(baud,data,stop,parity:integer);
var a:byte;
begin
  ComPort.DeviceName:=cbNamePort.Items.Strings[cbNamePort.ItemIndex];
  cnt_interv:=Round(StrToInt(ETimeOut.Text)/Timer1.Interval);
  case baud of
    0:ComPort.BaudRate:=br1200;1:ComPort.BaudRate:=br2400;
    2:ComPort.BaudRate:=br4800;3:ComPort.BaudRate:=br9600;
    4:ComPort.BaudRate:=br19200;5:ComPort.BaudRate:=br38400;
    6:ComPort.BaudRate:=br57600;7:ComPort.BaudRate:=br115200;
  end;
  case data of 0:ComPort.DataBits:=db8;1:ComPort.DataBits:=db7;end;
  case stop of 0:ComPort.StopBits:=sb1;1:ComPort.StopBits:=sb2;end;
  case parity of
    0:ComPort.Parity:=paNone;1:ComPort.Parity:=paOdd;2:ComPort.Parity:=paEven;
  end;send[0]:=StrToInt(EAdrDev.Text);send[1]:=0;
  LongToBynare(StrToInt(EPasswDev.Text),a,send[2],send[3],send[4]);
  {ShowMessage(IntToStr(send[1])+' '+IntToStr(send[2])+' '+IntToStr(send[3])+
  ' '+IntToStr(send[4]));}
end;
//---------------------------------------------------//

procedure TMainForm.LongToBynare(val:longword;var a,b,c,d:byte);
var ms:word;abcd:array[0..3]of byte;
begin //�������������� ������ ����� � 4 �����: �-����� ������� ����
  CopyMemory(@abcd,@val,4);a:=abcd[3];b:=abcd[2];c:=abcd[1];d:=abcd[0]; 
  {ms:=Floor(val/65536);a:=Floor(ms/256);b:=ms-a*256;ms:=val-ms*65536;
  c:=Floor(ms/256);d:=ms-c*256;}
end;
//---------------------------------------------------//

procedure TMainForm.FileName;
{������������� ����� �������� ������ �� ����� �����������������}
var i:byte;smb:string[1];fl:boolean;str:string[60];
begin
  str:='';fl:=false;i:=1;
  repeat
    smb:=Copy(Fname,i,1);
    if smb<>'.' then str:=str+smb else fl:=true;i:=i+1;
  until (fl=true)or(i>=Length(Fname));
  namea:=str+'.dat';namet:=str+'.evt';namer:=str+'.alm';
end;
//---------------------------------------------------//

procedure TMainForm.ConvertToLong(a,b,c,d:byte;var val:longword);
begin
  val:=(256*a+b)*65536+256*c+d;
end;
//---------------------------------------------------//

procedure TMainForm.aOpenCommExecute(Sender: TObject);
var flg:boolean;a:double;
begin
  try a:=StrToFloat('22,22');
  except on EConvertError do flg:=true;
  end;OpenDialog1.FilterIndex:=1;
  if flg=true then smb_del:='.'else smb_del:=',';
  if OpenDialog1.Execute then Fname:=OpenDialog1.FileName
    else Application.Terminate;
  if ReadConfigFile=false then
  begin
    ShowMessage('����������� ���������������� ����! ��������� ��������� � ���������.');
    pCommunic.Visible:=true;Exit;
  end;PCommunic.Visible:=true; BSave.Enabled:=false; flg_err:=0; rpt_com:=0;
  if cbSelLink.ItemIndex=2 then
  begin gbSelLink.Visible:=true; GetListModems; cbNamePort.Enabled:=false;end else
  gbSelLink.Visible:=false;
end;
//---------------------------------------------------//

procedure TMainForm.FormCreate(Sender: TObject);
var i:integer;
begin
  flg_config:=false;
  for i:=1 to MainMenu.Items.Count-1 do
  MainMenu.Items.Items[i].Visible:=false;Panel2.Visible:=false;flg_save:=false;
  SetLength(SelIcp,1);SetLength(SelExp,1);
  cbStatus:=TComboBox.Create(MainForm);cbStatus.Parent:=MainForm;
  cbStatus.Visible:=false;cbStatus.Color:=clWindow;cbStatus.Font.Color:=clBlue;
  MainMenu.Items.Items[7].Items[2].Enabled:=false;
  MainMenu.Items.Items[7].Items[3].Enabled:=false;
end;
//---------------------------------------------------//

procedure TMainForm.aSaveConfExecute(Sender: TObject);
begin
  BSave.Enabled:=false;EAdrDev.Color:=clWhite;EAdrDev.Font.Color:=clBlack;
  EPasswDev.Color:=clWhite;EPasswDev.Font.Color:=clBlack;EPasswProg.Color:=clWhite;
  EPasswProg.Font.Color:=clBlack;EDelay.Color:=clWhite;EDelay.Font.Color:=clBlack;
  ETimeOut.Color:=clWhite;ETimeOut.Font.Color:=clBlack;ERetryCnt.Color:=clWhite;
  ERetryCnt.Font.Color:=clBlack;
  WriteConfigFile(cbBaud.ItemIndex,cbData.ItemIndex,cbStop.ItemIndex,
  cbParity.ItemIndex,true);flg_save:=false;
end;
//---------------------------------------------------//

procedure TMainForm.WriteConfigFile(baud,data,stop,parity:integer;flag:boolean);
var i,j:word;flg_res:integer;
begin //������ �������� ��������� � ����
  with d_conf do
  begin
    c_byte[0]:=cbSelLink.ItemIndex;c_byte[1]:=cbNamePort.ItemIndex;
    c_byte[8]:=baud;c_byte[9]:=data;c_byte[10]:=stop;c_byte[11]:=parity;
    s_byte[2]:=StrToInt(EAdrDev.Text);s_byte[3]:=StrToInt(EDelay.Text);
    s_byte[4]:=StrToInt(ETimeOut.Text);s_byte[5]:=StrToInt(ERetryCnt.Text);
    s_long[0]:=StrToInt(EPasswDev.Text);s_long[1]:=StrToInt(EPasswProg.Text);
    c_string[0]:=ePhoneNumber.Text;c_string[1]:=eAT.Text;
    if chLine.Checked then c_byte[6]:=1 else c_byte[6]:=0;
    if chTone.Checked then c_byte[7]:=1 else c_byte[7]:=0;
    for i:=2 to 5 do c_byte[i]:=s_byte[i];for i:=0 to 1 do c_long[i]:=s_long[i];
  end;
  if (flag)and(SaveDialog1.Execute) then
    begin
      Fname:=SaveDialog1.FileName + '.cnf';
    end;
  AssignFile(f_conf,Fname);{$I-}Reset(f_conf);{$I+} flg_res:=IOResult;
  if flg_res<>0 then Rewrite(f_conf);Write(f_conf,d_conf);CloseFile(f_conf);
end;
//---------------------------------------------------//

procedure TMainForm.cbSelLinkChange(Sender: TObject);
begin
  if cbSelLink.ItemIndex=2 then
  begin GetListModems; cbNamePort.Enabled:=false; gbSelLink.Visible:=true;end
  else begin cbNamePort.Enabled:=true; gbSelLink.Visible:=false;end;
  BSave.Enabled:=true; flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.EAdrDevKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in['0'..'9',Char(8)])then Key:=#0;
end;
//---------------------------------------------------//

procedure TMainForm.aOnLineExecute(Sender: TObject);
begin
  if flg_save then if MessageDlg('��������� ��������� ���������������� ���������?',
    mtConfirmation,[mbYes,mbNo],0)=mrYes then aSaveConfExecute(Sender);
  InitialComport(cbBaud.ItemIndex,cbData.ItemIndex,cbStop.ItemIndex,
                 cbParity.ItemIndex);ComPort.Open;ComPort.SetDTR;
  bLink.Enabled:=false; PRT.load_visible:=7; list_err:=TStringList.Create;
  MainForm.StatusBar.Panels.Items[0].Style:=psOwnerDraw; flag_list:=true;
  flg_err:=0; rpt_tmr:=0; PRT.cnt_pool:=0; PRT.cnt_err:=0;
  if cbSelLink.ItemIndex<>2 then
  begin
    start_time:=Now;flg_cmd:=32;
    Load.step:=0;Load.addr:=0;Load.flg_end:=false;Timer3.Interval:=100;
    Timer3.Enabled:=true;
  end else
  begin
    flg_modem:=0;s_at:=strAT[0];cbAnsModem.Visible:=true;rpt_tmr:=0;
    tmModem.Interval:=500;SendStrToDev;rpt_mdm_tmr:=0;
  end;
end;
//---------------------------------------------------//

procedure LoadConfig(SetConfig:array of TSetConfigPrm);
var i,j,count:integer;flag:boolean;
begin
  send[8]:=conf_page; flag:=false; count:=0;  
  if PRT.num_prm<Length(SetConfig)then for i:=PRT.num_prm to Length(SetConfig)-1 do
  begin
    send[9+count]:=i;
    if SetConfig[i].size>0 then for j:=0 to SetConfig[i].size-1 do
      send[10+count+j]:=Main_config[conf_page,PRT.addr_buf+j]; 
    if (count+SetConfig[i].size+1)<240 then
    begin
      count:=count+SetConfig[i].size+1;
      PRT.addr_buf:=PRT.addr_buf+SetConfig[i].size;
    end else begin flag:=true;Break;end;
  end;send[6]:=13+count;send[7]:=i-PRT.num_prm;
  if flag then begin PRT.flg_first:=true;PRT.num_prm:=i;end
  else PRT.flg_first:=false;
end;
//---------------------------------------------------//

function GetNameFunction (opcode:byte):string;
var str:string;
begin
  case opcode of
    1:str:='������ ������������';    2:str:='������ ������������';
    3:str:='������ ����/�������';    4:str:='������ ����/�������';
    5:str:='������ ����������';      6:str:='������ �������';
    7:str:='������ � MVS';           8:str:='������ ���������';
    9:str:='���������� MVS';         10:str:='������ �������';
    11:str:='������ � ICP';          12:str:='������ ������';
    15:str:='������� ���������';     16:str:='������� ������ MVS';
    17:str:='������ �������';        18:str:='�������� ������ MVS';
    19:str:='������������� ������';  20:str:='������ �������';
    21:str:='������ ������� Modbus'; 22:str:='������ ICP';
    23:str:='��������� ���� MicroMotion';24:str:='������ �������';
    25:str:='������� ��������� MicroMotion';28:str:='������ ��������� ������';
                                     30:str:='������ ������� Modbus';
                                     32:str:='������ ������������';
    33:str:='������ ������� �������';
    else str:='���������������� ��������';
  end; Result:=str;
end;
//---------------------------------------------------//

procedure TMainForm.PrepareSend(kop:byte);
const ind_icp:array[0..2]of byte=(8,12,13);
var musor:longword;s:string;i,j,k,m:byte;dt:array[0..6]of word;
label M1;
begin { ���������� ����� ��� �������� � ���������� }
  for i:=5 to Length(send)-1 do send[i]:=0;
  send[5]:=kop;send[6]:=11;rpt_ck:=0;
  case kop of
    1:if PRT.status<>twLoadConfig then
      begin {�������� ������������ �� ����� ����������,������ �����,������ ���� }
        j:=0;k:=0;send[6]:=13;
        if PRT.status<>twIcp then
        begin
          if Length(ConfData.setwr)>0 then
          for i:=0 to Length(ConfData.setwr)-1 do if ConfData.setwr[i].flag then
          begin
            send[6]:=send[6]+Length(ConfData.setwr[i].val)+1;
            send[9+j]:=ConfData.setwr[i].num;
            for m:=0 to Length(ConfData.setwr[i].val)-1 do
            send[10+j+m]:=ConfData.setwr[i].val[m];
            j:=j+Length(ConfData.setwr[i].val)+1;k:=k+1;
          end;send[7]:=k;send[8]:=ind_conf[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]];
        end;
        for i:=0 to Length(ConfData.setwr)-1 do ConfData.setwr[i].flag:=false;
        {s:='';for i:=0 to send[6]-1 do s:=s +IntToStr(send[i])+' ';
        ShowMessage('������: '+s);Exit;}
      end else
      begin
      case conf_page of
        0,1,2,3:LoadConfig(ConfSet);4:LoadConfig(ConfSetExp);
        6:LoadConfig(ConfSetIcp);7:LoadConfig(MainSet);
      end; 
      end;
    2:begin { ������ ������������ �� ������ ����� }
        if PRT.status=twSaveConfig then send[7]:=conf_page else
        send[7]:=ind_conf[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]];send[6]:=12;
      end;
    3:begin { �������� ����-����� }
        DecodeDate(FormConfigurationSettings.MonthCalendar1.Date,dt[0],dt[1],dt[2]);
          dt[0]:=dt[0]-2000;
        DecodeTime(FormConfigurationSettings.DateTimePicker1.Time,dt[3],dt[4],dt[5],dt[6]);
        for i:=0 to 5 do send[7+i]:=dt[i];send[6]:=17;
      end;
    5:begin { �������� ��������� ��� ������� }
        if Length(ConfData.ver_input)>0 then
        begin
          send[7]:=ind_conf[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]];
          send[8]:=Length(ConfData.ver_input);
          for i:=0 to Length(ConfData.ver_input)-1 do
          begin
            send[9+i*5]:=ConfData.ver_input[i].num;
            FloatToBynare(ConfData.ver_input[i].data,send[10+i*5],send[11+i*5],
                           send[12+i*5],send[13+i*5]);
          end;send[6]:=13+send[8]*5;
        end else begin flg_cmd:=1;Exit;end;
      end;
    6:begin send[7]:=ind_conf[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]];send[6]:=12;end;{ ������ ������� }

    //29.11.2021 YN
    {7:begin { �������� ���,������� MVS }
    {    send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;send[6]:=24;
        send[8]:=Sensor.byn[0];send[9]:=FormEcoSonicSetting.cbUnits.ItemIndex;
        for i:=1 to 10 do send[9+i]:=Ord(Sensor.tag[i]);
      end;}

    9:begin  { ��������� ���������� MVS }
        send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;send[8]:=mvs_cmd[0];
        send[9]:=mvs_cmd[1];send[6]:=18;
        FloatToBynare(mvs_val,send[10],send[11],send[12],send[13]);
      end;
    10:begin { ��������� �� 15-�� ������� ��� ������� }
         send[6]:=15;send[7]:=0;send[8]:=Hi(Pntr.event);send[9]:=Lo(Pntr.event);
         case Prt.status of
           twEvent:send[10]:=0;twAlarm:send[10]:=1;twNst:send[10]:=2;
         end;
         if PRT.load_update=3 then send[10]:=0 else
          if PRT.load_update=4 then send[10]:=1;
       end;
    11:begin { �������� �  ������ I-7000 }
         send[7]:=FormIOModulesSetting.tcPageICP.TabIndex;send[8]:=ICP.event;
         for i:=0 to Length(ICP.wrt)-1 do send[9+i]:=ICP.wrt[i];send[6]:=16;
       end;
    12:
    begin { ��������� �������� �����,�������,���������������� }
      send[6]:=15;send[7]:=Pntr.page;send[8]:=Hi(Pntr.archive);
      send[9]:=Lo(Pntr.archive);
      case PRT.status of
        twHour:send[10]:=0;twDay:send[10]:=1;twUser:send[10]:=3;
      end;if PRT.load_update=2 then send[10]:=255;{���������� �� ����}
    end;
    15:{ ����� ��������� ��������� }
    begin
      send[6]:=13;j:=0;send[7]:=ind_conf[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]];
      if FormConfigurationSettings.clClear.Items.Count>0 then for i:=0 to FormConfigurationSettings.clClear.Items.Count-1 do
      if FormConfigurationSettings.clClear.Checked[i] then
      begin
        send[9+j]:=SetClear.number[i];send[6]:=send[6]+1;
        j:=j+1;FormConfigurationSettings.clClear.Checked[i]:=false;
      end;send[8]:=j;SetClear.flag:=false;
      //s:='';for i:=0 to send[6]-1 do s:=s +IntToStr(send[i])+' ';
      //  ShowMessage('������: '+s);{Exit;}
    end;
    16:begin { ������ ���. ����������, ���� � ���������� MVS }
         send[6]:=12;send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;mvs_ret:=0;
       end;
    17:begin {������ ���� ������� }
         send[7]:=Hi(Load.addr);send[8]:=Lo(Load.addr);send[9]:=Load.step;
         send[6]:=14+Load.step*6;
         for i:=0 to Load.step-1 do
         begin
           send[10+i*6]:=ScriptData[Load.addr+i].op_code;
           send[11+i*6]:=ScriptData[Load.addr+i].pnt;
           if ScriptData[Load.addr+i].pnt=0 then
           FloatToBynare(ScriptData[Load.addr+i].value,
           send[12+i*6],send[13+i*6],send[14+i*6],send[15+i*6])else
           begin
             send[12+i*6]:=ScriptData[Load.addr+i].param;
             send[13+i*6]:=ScriptData[Load.addr+i].num;
             send[14+i*6]:=Hi(ScriptData[Load.addr+i].transit);
             send[15+i*6]:=Lo(ScriptData[Load.addr+i].transit);
           end;
         end;
    {s:='';for i:=0 to send[6]-1 do s:=s +IntToStr(send[i])+' ';
    ShowMessage('������: '+s);Exit;}
       end;
    18:begin send[6]:=12;send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;end;{�������� ������ MVS }
    20:begin send[6]:=12;send[7]:=Load.step;end;{ ��������� ������� }
    21:
    begin
      send[6]:=252;
      case PRT.status of
      twModbusFunc:
      begin
        send[7]:=FormModbusSetting.cbSelFunc.ItemIndex;
        for i:=0 to Length(ModbusFunc)-1 do
        begin
          send[8+i*6]:=Hi(ModbusFunc[i].addr);send[9+i*6]:=Lo(ModbusFunc[i].addr);
          send[10+i*6]:=ModbusFunc[i].pnt;send[11+i*6]:=ModbusFunc[i].logn;
          send[12+i*6]:=ModbusFunc[i].prm;send[13+i*6]:=ModbusFunc[i].conv;
        end;
      end;
      twModbusHost:
      begin
        send[7]:=FormModbusSetting.cbSelFunc.ItemIndex+10;
        for i:=0 to Length(ModbusHost)-1 do
        begin
          send[8+i*8]:=ModbusHost[i].addr;send[9+i*8]:=ModbusHost[i].func;
          send[10+i*8]:=Hi(ModbusHost[i].reg);
          send[11+i*8]:=Lo(ModbusHost[i].reg);
          send[12+i*8]:=Hi(ModbusHost[i].new);
          send[13+i*8]:=Lo(ModbusHost[i].new);
          send[14+i*8]:=ModbusHost[i].count;send[15+i*8]:=ModbusHost[i].status;
        end;
      end;
      twModbusScale:
      begin
        send[7]:=13;
        for i:=0 to Length(ModbusScale)-1 do
        begin
          FloatToBynare(ModbusScale[i].lo_val,send[8+i*4],send[9+i*4],
                             send[10+i*4],send[11+i*4]);
          FloatToBynare(ModbusScale[i].hi_val,send[56+i*4],send[57+i*4],
                             send[58+i*4],send[59+i*4]);
        end;
      end;
     twHart:send[7]:=FormModbusSetting.cbSelFunc.ItemIndex+14;
    end;
    end;
    22:
    begin {��������� ������, ��������� � ������ ���������� ������}
      send[6]:=13;send[7]:=FormIOModulesSetting.tcPageICP.TabIndex;
      if PRT.flg_first then send[8]:=0 else send[8]:=1;
    end;
    24:begin send[6]:=13;send[7]:=Hi(Load.addr);send[8]:=Lo(Load.addr);end;{��������� ������}
    28:begin send[6]:=12;send[7]:=Pntr.minute;end;{ ��������� �������� ����� }
    30:begin {��������� ������� Modbus}
         send[6]:=12;
         case PRT.status of
           twModbusFunc:send[7]:=ModbusConf.select;
           twModbusHost:send[7]:=ModbusConf.select+10;
           twModbusScale:send[7]:=13;twModbusStatus:send[7]:=15;
           twHart:send[7]:=FormModbusSetting.cbSelFunc.ItemIndex+14;
         end;
       end;
    32:begin {��������� ������.�����������}
         send[6]:=13;send[7]:=Load.step;send[8]:=Load.addr;
       end;

    //29.11.2021 YN added:
    36:begin {��������� ������ EcoSonic}
         send[6]:=12; send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;
       end;
    38:begin {��������� ������ � �������� �������}
         send[6]:=12; send[7]:=FormEcoSonicSetting.cbSelDisk.ItemIndex;
       end;

    33:
    begin {�������� ������� ������� MVS}
      if PRT.status=twMvs then
      begin
        send[7]:=FormEcoSonicSetting.tcPageMVS.TabIndex;k:=0;m:=0;send[9]:=0;
        for i:=0 to Length(Sensor.alm_set)-1 do
        for j:=0 to Length(Sensor.alm_set[i])-1 do
        if Sensor.flg_set[i,j] then
        begin
          send[10+k]:=i*3+j;
          FloatToBynare(Sensor.alm_set[i,j],send[11+k],
                        send[12+k],send[13+k],send[14+k]);k:=k+5;
          Sensor.flg_set[i,j]:=false;m:=m+1;
        end;
        if Sensor.flg_enb then
        begin
          send[10+k]:=9;send[11+k]:=Sensor.alm_enb;Sensor.flg_enb:=false;
          k:=k+2;m:=m+1;
        end;send[6]:=14+k;send[8]:=m;{����� ����������}
      end;
      if PRT.status=twIcp then
      begin {�������� ������� ������� ���������� ������}
        send[7]:=ICP.typ;k:=0;m:=0;send[9]:=1;
        for i:=0 to Length(ICP.alm_set)-1 do
        for j:=0 to Length(ICP.alm_set[i])-1 do if ICP.flg_set[i,j] then
        begin
          send[10+k]:=i*5+j;
          FloatToBynare(ICP.alm_set[i,j],send[11+k],
                        send[12+k],send[13+k],send[14+k]);k:=k+5;
          ICP.flg_set[i,j]:=false;m:=m+1;
        end;
        if ICP.flg_enb then
        begin
          send[10+k]:=40;send[11+k]:=ICP.alm_enb;ICP.flg_enb:=false;k:=k+2;m:=m+1;
        end;send[6]:=14+k;send[8]:=m;
      end; {s:='';for i:=0 to send[6]-1 do s:=s +IntToStr(send[i])+' ';
        ShowMessage('������: '+s);Exit;}
    end;
  end;
M1:CalcCRC32(send,send[6]-4,musor);cnt_send:=send[6];
  LongToBynare(musor,send[cnt_send-4],send[cnt_send-3],send[cnt_send-2],
                      send[cnt_send-1]);
  SendToDevice;
end;
//---------------------------------------------------//

procedure TMainForm.FloatToBynare(val:single;var a,b,c,d:byte);
var abcd:array[0..3]of byte;
begin {�������������� ��������������� ����� � 4 ����� IEEE-754d }
  CopyMemory(@abcd,@val,4);a:=abcd[0];b:=abcd[1];c:=abcd[2];d:=abcd[3];
end;
//---------------------------------------------------//

function TMainForm.ConvToFloat(a,b,c,d:byte;var val:single):boolean;
var abcd:array[0..3]of byte;
begin {�������������� 4-� ���� � �������������� ����� }
  if (a=255)and(b=255)and(c=255)and(d=255) then Result:=false else
  begin
    abcd[0]:=a;abcd[1]:=b;abcd[2]:=c;abcd[3]:=d;
    CopyMemory(@val,@abcd,4);Result:=true;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.CalcCRC32(buffer:array of byte;count:byte;var kod:longword);
const polynom:longword=$edb88320;
var i,j:byte;flg:boolean;
begin //���������� �������� 32-������� ������������ ����
  kod:=$ffffffff;i:=0;
  repeat
    j:=0;kod:=kod xor buffer[i];
    repeat
      if (kod and 1)=1 then flg:=true else flg:=false;
      kod:=kod shr 1;
      if flg=true then kod:=kod xor polynom;j:=j+1;
    until j=8;i:=i+1;
  until i=count;kod:=kod xor $ffffffff;
end;
//---------------------------------------------------//

procedure TMainForm.SendToDevice;
begin
  ComPort.PurgeInput;ComPort.PurgeOutput;
  cnt_recive:=0;PRT.flg_reciv:=false;ComPort.SetRTS;tmDelay.Interval:=s_byte[3];
  tmDelay.Enabled:=true;
end;
//---------------------------------------------------//

procedure TMainForm.tmDelayTimer(Sender: TObject);
var i:byte; str:string;
begin
  tmDelay.Enabled:=false;PRT.cnt_pool:=PRT.cnt_pool+1; str:='';
  for i:=0 to cnt_send-1 do str:=str +IntToStr(send[i])+' ';
  list_err.Add('������: '+str);
  for i:=0 to cnt_send-1 do ComPort.WriteByte(send[i]);
  ComPort.WaitForWriteCompletion;ComPort.ClearRTS;Timer1.Enabled:=true;
end;
//---------------------------------------------------//

procedure TMainForm.ReadFromDevice;
var i, j, a, cnt:byte; fl_ck, flg:boolean; res:word;
    str:string;
begin //������ ������ �� �����������
  if ComPort.InputCount>0 then
  begin
    a:=ComPort.InputCount;
    for i:=0 to a-1 do recive[cnt_recive+i]:=ComPort.ReadByte;
    cnt_recive:=cnt_recive+a;
    if cnt_recive < 7 then begin PRT.flg_reciv:=false;Exit;end;
    if cnt_recive < recive[6] then begin PRT.flg_reciv:=false; Exit;end; str:='';
    for i:=0 to recive[6]-1 do str:=str+IntToStr(recive[i])+' ';
    cnt:=recive[6]-4; CalcCRC32(recive,cnt,musor);
    ConvertToLong(recive[cnt],recive[cnt+1],recive[cnt+2],recive[cnt+3],kod);
    if musor <> kod then
    begin
      rpt_ck:=rpt_ck+1;
      list_err.Add('������ ������������ ����: '+GetNameFunction(recive[5]));
      if rpt_ck > 10 then flg_err:=2 else flg_err:=5;
    end else
    begin
      rpt_ck:=0;flg_err:=0; list_err.Add('�����: '+str);
    end; PRT.flg_reciv:=true;
  end else begin PRT.flg_reciv:=false;Exit;end;
end;
//---------------------------------------------------//

procedure TMainForm.EventType(cb:TComboBox;ind:byte);
begin
  FormForVariablesView.sgTable.Cells[2,row]:=cb.Items.Strings[recive[11+6+ind*16]];
  FormForVariablesView.sgTable.Cells[3,row]:=cb.Items.Strings[recive[11+10+ind*16]];
end;
//---------------------------------------------------//

procedure TMainForm.EventTypeT(list:TStrings;ind:byte);
begin
  FormForVariablesView.sgTable.Cells[2,row]:=list[recive[11+6+ind*16]];
  FormForVariablesView.sgTable.Cells[3,row]:=list[recive[11+10+ind*16]];
end;
//---------------------------------------------------//

procedure SetParamsModul(index,ind_name:integer);
const tp_sel:array[0..2]of string[30]=('����������� �������','% �� ������ �����',
               '����������������');
      num_chan:array[0..7]of string[10]=('������','������','������','��������',
                    '�����','������','�������','�������');
      ai_sel:array[0..5]of string[30]=('�� -10.25 � �� +10.25 �',
             '�� -5.125 � �� +5.125 �','�� -1.025 � �� +1.025 �',
             '�� -512.5 �� �� +512.5 ��','�� -153.75 �� �� +153.75 ��',
             '�� -20.5 �A �� +20.5 �A');
      ai_filter:array[0..1]of string[20]=('�������� 60 ��','�������� 50 ��');
      ai_speed:array[0..1]of string[20]= ('10 �������/�','75 �������/�');
      name_item_ai:array[0..12]of string[15]=('����� ������','������� ����',
            '�������� � ��','������ ����','������� ����','�������','��� ��� ���',
            '������ �����','������� �����','���� ���� ���','������ ������',
            '����/���� �����','������ ������');
      name_item_ao:array[0..7]of string[15]=('����� ������','������� ����',
            '�������� � ��','������ ����','������� ����','�������','��� ������',
            '������');
      name_item_cnt:array[0..3]of string[20]=('����� ������','�������� ��������',
            '�������� � ��������','�����������');
      name_item_rtd:array[0..2]of string[20]=('����� ������','�����������, ��.�',
            '��� ��������������');
      ao_sel:array[0..5]of string[25]=('�� 0.0 �� �� 20.0 ��',
             '�� 4.0 �� �� 20.0 ��','�� 0.0 � �� 10.0 �','�� -10.0 � �� 10.0 �',
             '�� 0.0 � �� 5.0 �','�� -5.0 � �� 5.0 �');
      ao_sel_bis:array[0..2]of string[25]=('0.0 ��-20.0 ��',
             '4.0 ��-20.0 ��','0.0 �-10.0 �');
      ao_slew:array[0..15]of string[25]=('����������','0.125 ��/�',
             '0.25 ��/�','0.5 ��/�','1.0 ��/�','2.0 ��/�','4.0 ��/�','8.0 ��/�',
             '16.0 ��/�','32.0 ��/�','64.0 ��/�','128.0 ��/�','256.0 ��/�',
             '512.0 ��/�','1024.0 ��/�','2048.0 ��/�');
      ao_slew_bis:array[0..15]of string[25]=('����������','0.0625 �/�',
             '0.125 �/�','0.25 �/�','0.5 �/�','1.0 �/�','2.0 �/�','4.0 �/�',
             '8.0 �/�','16.0 �/�','32.0 �/�','64.0 �/�','128.0 �/�','256.0 �/�',
             '512.0 �/�','1024.0 �/�');
var i,j:integer;str:string;
begin
  if index<0 then Exit;
  for i:=0 to FormIOModulesSetting.sgTable.ColCount-1 do for j:=0 to FormIOModulesSetting.sgTable.RowCount-1 do
  FormIOModulesSetting.sgTable.Cells[i,j]:='';FormIOModulesSetting.cbDataType.Items.Clear;
  FormIOModulesSetting.cbInputType.Items.Clear;FormIOModulesSetting.cbFilter.Items.Clear;
  FormIOModulesSetting.ComboBox2.Items.Clear;
  with FormIOModulesSetting do case index of
  0,1:
  begin
    ICP.typ:=index;
    for i:=0 to Length(ai_filter)-1 do cbFilter.Items.Add(ai_filter[i]);
    for i:=0 to Length(ai_speed)-1 do ComboBox2.Items.Add(ai_speed[i]);
    if index=0 then
    begin
      sgTable.DefaultColWidth:=81;
      if ind_name=1 then
      begin
        lIdentModul.Caption:='������ ���������� ������ AIN #1';
        sgTable.RowCount:=2;
      end else if ind_name=2 then
      begin
        lIdentModul.Caption:='������ ���������� ������ (AIN #1..AIN #8)';
        sgTable.RowCount:=9;
      end;
    end else
    begin
      if ind_name=1 then
      begin
        lIdentModul.Caption:='������ ���������� ������ AIN #9';
        sgTable.RowCount:=2;
      end else if ind_name=2 then
      begin
        lIdentModul.Caption:='������ ���������� ������ (AIN #9..AIN #16)';
        sgTable.RowCount:=9;
      end;
    end;sgTable.ColCount:=13;bCallibr.Enabled:=true;
    for i:=0 to sgTable.ColCount-1 do sgTable.Cells[i,0]:=name_item_ai[i];
    for i:=0 to sgTable.RowCount-2 do sgTable.Cells[0,i+1]:=num_chan[i];
    for i:=0 to Length(tp_sel)-2 do cbDataType.Items.Add(tp_sel[i]);
    for i:=0 to Length(ai_sel)-1 do cbInputType.Items.Add(ai_sel[i]);
  end;
  2,3:
  begin
    cbSelectChan.Clear;if ind_name=3 then j:=1 else j:=3;ICP.typ:=index;
    for i:=0 to j do cbSelectChan.Items.Add(num_chan[i]);
    cbSelectChan.ItemIndex:=0;
    if index=2 then
    begin
      if ind_name=3 then
      begin
        lIdentModul.Caption:='������ ���������� ������� (AOUT #1..AOUT #2)';
        sgTable.RowCount:=3;sgTable.ColCount:=8;sgTable.DefaultColWidth:=85;
        if (ICP.status[4]) and ($f)<Length(ao_sel_bis)then
          sgTable.Cells[6,1]:=ao_sel_bis[ICP.status[4] and $f];
        if (ICP.status[5]) and ($f)<Length(ao_sel_bis)then
          sgTable.Cells[6,2]:=ao_sel_bis[ICP.status[5] and $f];
        if (ICP.status[4]) and ($f)<2 then
        sgTable.Cells[7,1]:=ao_slew[(ICP.status[4] and $f0)shr 4] else
        sgTable.Cells[7,1]:=ao_slew_bis[(ICP.status[4] and $f0)shr 4];
        if (ICP.status[5]) and ($f)<2 then
        sgTable.Cells[7,2]:=ao_slew[(ICP.status[5] and $f0)shr 4] else
        sgTable.Cells[7,2]:=ao_slew_bis[(ICP.status[5] and $f0)shr 4];
      end else if ind_name=4 then
      begin
        lIdentModul.Caption:='������ ���������� ������� (AOUT #1..AOUT #4)';
        sgTable.RowCount:=5;sgTable.ColCount:=6;sgTable.DefaultColWidth:=85;
        for i:=0 to Length(ao_sel)-1 do cbInputType.Items.Add(ao_sel[i]);
        if ICP.status[0]<$32 then
        for i:=0 to Length(ao_slew)-1 do cbFilter.Items.Add(ao_slew[i]) else
        for i:=0 to Length(ao_slew_bis)-1 do cbFilter.Items.Add(ao_slew_bis[i]);
      end;
    end else
      if ind_name=3 then
      begin
        lIdentModul.Caption:='������ ���������� ������� (AOUT #5..AOUT #6)';
        sgTable.RowCount:=3;sgTable.ColCount:=7;
      end else if ind_name=4 then
      begin
        lIdentModul.Caption:='������ ���������� ������� (AOUT #5..AOUT #8)';
        sgTable.RowCount:=5;sgTable.ColCount:=5;
        for i:=0 to Length(ao_sel)-1 do cbInputType.Items.Add(ao_sel[i]);
        if ICP.status[0]<$32 then
        for i:=0 to Length(ao_slew)-1 do cbFilter.Items.Add(ao_slew[i]) else
        for i:=0 to Length(ao_slew_bis)-1 do cbFilter.Items.Add(ao_slew_bis[i]);
      end;bCallibr.Enabled:=true;
    for i:=0 to sgTable.ColCount-1 do sgTable.Cells[i,0]:=name_item_ao[i];
    for i:=0 to sgTable.RowCount-2 do sgTable.Cells[0,i+1]:=num_chan[i];
    for i:=0 to Length(tp_sel)-1 do cbDataType.Items.Add(tp_sel[i]);
  end;
  4,5:
  begin
    ICP.typ:=index; sgTable.DefaultColWidth:=125;
    if (index=4)and(ind_name=5) then
    begin
      lIdentModul.Caption:=
                 '������ ���������� ������/������� DI #1..DI #4,DO #1..DO #4';
      sgTable.RowCount:=9;
    end;
    if (index=5)and(ind_name=5) then
    begin
      lIdentModul.Caption:=
                 '������ ���������� ������/������� DI #5..DI #8,DO #5..DO #8';
      sgTable.RowCount:=9;
    end;sgTable.ColCount:=2;bCallibr.Enabled:=false;
    for i:=0 to sgTable.ColCount-1 do sgTable.Cells[i,0]:=name_item_ai[i];
    for i:=0 to 3 do sgTable.Cells[0,i+1]:=num_chan[i]+' DI';
    for i:=0 to 3 do sgTable.Cells[0,i+5]:=num_chan[i]+' DO';
  end;
 6:
 begin
   //ICP.typ:=index;sgTable.DefaultColWidth:=105;
   //lIdentModul.Caption:=
   //              '������ ���������� ������ PIN #1..PIN #2'; sgTable.RowCount:=3;
   //sgTable.ColCount:=4; bCallibr.Enabled:=false;
   //for i:=0 to sgTable.ColCount-1 do sgTable.Cells[i,0]:=name_item_cnt[i];
   //for i:=0 to 1 do sgTable.Cells[0,i+1]:=num_chan[i]+' CNT';
   ICP.typ:=index;
   for i:=0 to Length(ai_filter)-1 do cbFilter.Items.Add(ai_filter[i]);
   for i:=0 to Length(ai_speed)-1 do ComboBox2.Items.Add(ai_speed[i]);
   sgTable.DefaultColWidth:=105; sgTable.ColWidths[1]:=105;
   sgTable.ColWidths[2]:=171;
   lIdentModul.Caption:='������ ��������������������� RTD'; sgTable.RowCount:=7;
   sgTable.ColCount:=3; bCallibr.Enabled:=false;
   for i:=0 to sgTable.ColCount-1 do sgTable.Cells[i,0]:=name_item_rtd[i];
   for i:=0 to sgTable.RowCount-2 do sgTable.Cells[0,i+1]:=num_chan[i];
   for i:=0 to Length(tp_sel)-2 do cbDataType.Items.Add(tp_sel[i]);
 end; end;
end;
//---------------------------------------------------//

procedure ReadModulSetup(Sender: TObject);
const lbl_txt:array[0..6]of string[15]=('��� �����','��� �����',
                '��� ������','��� ������','��� ������','��� ������','��� �����');
      rtd_sel:array[0..7]of string[30]=('PT100, a=0.00385, -100..+100',
             'PT100, a=0.00385, 0..+100','PT100, a=0.00385, 0..+200',
             'PT100, a=0.00385, 0..+600','PT100, a=0.003916, -100..+100',
             'PT100, a=0.003916, 0..+100','PT100, a=0.003916, 0..+200',
             'PT100, a=0.003916, 0..+600');
var i,j:integer;s:string; value:double;  val:single; 
begin { ������ ������ � ������ ������ ICP �� �����������}
  //s:='';for i:=0 to recive[6]-1 do s:=s +IntToStr(recive[i])+' ';
  //   ShowMessage('�����: '+s);
  if (recive[6]>12)and(recive[8]>0)then with FormIOModulesSetting do
  begin { ������ ������� ������� ������ ICP:
          0-��� �����, 1-������, 2-�����, 3-������ �����, 4-������ ������ }
    if (PRT.flg_first)and(recive[7]=FormIOModulesSetting.tcPageICP.TabIndex) then
    begin
      PRT.flg_first:=false;
      if recive[9]=7 then pCounters.Visible:=true else pCounters.Visible:=false;
      for j:=0 to 5 do ICP.status[j]:=recive[10+j];
      SetParamsModul(recive[9],ICP.status[3]); FormIOModulesSetting.sgTable.Visible:=true;
      if (ICP.status[3]>0)and(ICP.status[3]<7)then
      eNameMod.Text:=nameICP[ICP.status[3]]else eNameMod.Text:='';
      Edit5.Text:=IntToStr(ICP.status[2]);
      if (ICP.status[1]and $20)>0 then
             ComboBox2.ItemIndex:=1 else ComboBox2.ItemIndex:=0;
      cbDataType.ItemIndex:=ICP.status[1]and $3;
      Label2.Caption:=lbl_txt[recive[9]];
      case recive[9] of
        0,1:                                          {������ ���������� ������}
        begin
          ICP.status[6]:=1;
          if (ICP.status[1]and $80)>0 then
             cbFilter.ItemIndex:=1 else cbFilter.ItemIndex:=0;
          case ICP.status[0] of
            8,9,10,11,12,13:cbInputType.ItemIndex:=ICP.status[0]-8;
          end;
          for i:=0 to Length(ICP.lo_brd)-1 do
          begin
            MainForm.ConvToFloat(recive[16+i*4],recive[17+i*4],
                      recive[18+i*4],recive[19+i*4],ICP.lo_brd[i]);
            FormIOModulesSetting.sgTable.Cells[3,i+1]:=FloatToStrF(ICP.lo_brd[i],ffGeneral,6,5);
          end;
          for i:=0 to Length(ICP.hi_brd)-1 do
          begin
            MainForm.ConvToFloat(recive[48+i*4],recive[49+i*4],
                      recive[50+i*4],recive[51+i*4],ICP.hi_brd[i]);
            FormIOModulesSetting.sgTable.Cells[4,i+1]:=FloatToStrF(ICP.hi_brd[i],ffGeneral,6,5);
          end;ICP.alm_enb:=recive[248];
          for i:=0 to Length(ICP.units)-1 do
          begin
            ICP.units[i]:=recive[80+i];
            FormIOModulesSetting.sgTable.Cells[5,i+1]:=units_all_bis[ICP.units[i]];
            for j:=0 to Length(ICP.alm_set[i])-1 do
            begin
              MainForm.ConvToFloat(recive[88+j*4+i*20],recive[89+j*4+i*20],
                      recive[90+j*4+i*20],recive[91+j*4+i*20],ICP.alm_set[i,j]);
              FormIOModulesSetting.sgTable.Cells[6+j,i+1]:=FloatToStrF(ICP.alm_set[i,j],ffGeneral,6,5);
            end;
            if (ICP.alm_enb)and(Floor(Power(2,i)))>0 then check[i]:=true else
            check[i]:=false;
          end;
        end;
        2,3:                                          {������ ���������� �������}
        begin
          ICP.status[6]:=2;
          case ICP.status[0] of
            $30,$31,$32,$33,$34,$35:
            begin
              cbInputType.ItemIndex:=ICP.status[0]-$30;
              cbFilter.ItemIndex:=ICP.status[0]-$30;;
            end;
            $3F:cbInputType.Items.Clear;
          end;
          for i:=0 to 3 do
          begin {}
            MainForm.ConvToFloat(recive[16+i*4],recive[17+i*4],
                      recive[18+i*4],recive[19+i*4],ICP.lo_brd[i]);
            FormIOModulesSetting.sgTable.Cells[3,i+1]:=FloatToStrF(ICP.lo_brd[i],ffGeneral,6,5);
            MainForm.ConvToFloat(recive[32+i*4],recive[33+i*4],
                      recive[34+i*4],recive[35+i*4],ICP.hi_brd[i]);
            FormIOModulesSetting.sgTable.Cells[4,i+1]:=FloatToStrF(ICP.hi_brd[i],ffGeneral,6,5);
            ICP.units[i]:=recive[48+i];
            FormIOModulesSetting.sgTable.Cells[5,i+1]:=units_all_bis[ICP.units[i]];
          end;
        end;
        6:
        begin
          FormIOModulesSetting.pCounters.Visible:=false;  ICP.status[6]:=1; 
          if (ICP.status[1]and $80)>0 then
             cbFilter.ItemIndex:=1 else cbFilter.ItemIndex:=0;
          for i:=0 to 5 do if recive[16+i]>=$20 then
          FormIOModulesSetting.sgTable.Cells[2,i+1]:=rtd_sel[recive[16+i]-$20];
        end;
      end;
    end else
    begin
      case recive[9] of
        0,1:
        for i:=0 to Length(ICP.value)-1 do
        begin
          MainForm.ConvToFloat(recive[10+i*4],recive[11+i*4],
                      recive[12+i*4],recive[13+i*4],ICP.value[i]);
          if(ICP.hi_brd[i]>ICP.lo_brd[i])and((ICP.hi_brd[i]-ICP.lo_brd[i])<>0)then
          value:=(ICP.value[i]-ICP.lo_brd[i])/((ICP.hi_brd[i]-ICP.lo_brd[i])/16)+4
          else value:=ICP.value[i];
          FormIOModulesSetting.sgTable.Cells[1,i+1]:=FloatToStrF(ICP.value[i],ffGeneral,6,5);
          FormIOModulesSetting.sgTable.Cells[2,i+1]:=FloatToStrF(value,ffGeneral,6,5);
          ICP.alm_status[i]:=recive[42+i];
          if (ICP.alm_enb)and(Floor(Power(2,i)))>0 then
          case ICP.alm_status[i] of
            0:FormIOModulesSetting.sgTable.Cells[12,i+1]:='';
            1:FormIOModulesSetting.sgTable.Cells[12,i+1]:='Lo Lo';
            2:FormIOModulesSetting.sgTable.Cells[12,i+1]:='Lo';
            3:FormIOModulesSetting.sgTable.Cells[12,i+1]:='Hi';
            4:FormIOModulesSetting.sgTable.Cells[12,i+1]:='Hi Hi';
          end else FormIOModulesSetting.sgTable.Cells[12,i+1]:='';
        end;
        2,3:
        for i:=0 to 3 do
        begin
          MainForm.ConvToFloat(recive[52+i*4],recive[53+i*4],
                      recive[54+i*4],recive[55+i*4],ICP.value[i]);
          if(ICP.hi_brd[i]>ICP.lo_brd[i])and((ICP.hi_brd[i]-ICP.lo_brd[i])<>0)then
          value:=(ICP.value[i]-ICP.lo_brd[i])/((ICP.hi_brd[i]-ICP.lo_brd[i])/16)+4
          else value:=0;
          FormIOModulesSetting.sgTable.Cells[1,i+1]:=FloatToStrF(ICP.value[i],ffGeneral,6,5);
          FormIOModulesSetting.sgTable.Cells[2,i+1]:=FloatToStrF(value,ffGeneral,6,5);
        end;
        4,5:                                  {������ ���������� ������/�������}
        for i:=0 to 3 do
        begin
          if (recive[14])and(Floor(Power(2,i)))>0 then
          FormIOModulesSetting.sgTable.Cells[1,i+1]:='OFF (����)' else
          FormIOModulesSetting.sgTable.Cells[1,i+1]:='ON  (���)';
          if (recive[15])and(Floor(Power(2,i)))>0 then
          FormIOModulesSetting.sgTable.Cells[1,i+5]:='ON (���)' else
          FormIOModulesSetting.sgTable.Cells[1,i+5]:='OFF (����)';
        end;
        6:
        begin                                       {������ ���������������������}
          for i:=0 to 5 do
          begin
            MainForm.ConvToFloat(recive[10+i*4],recive[11+i*4],
                      recive[12+i*4],recive[13+i*4],ICP.value[i]);
            FormIOModulesSetting.sgTable.Cells[1,i+1]:=FloatToStrF(ICP.value[i],ffGeneral,6,5);
          end;
        end;
        7:
        begin                                       {������ ��������� ���������}
          for i:=0 to 1 do
          begin
            MainForm.ConvToFloat(recive[14+i*4],recive[15+i*4],recive[16+i*4],
                          recive[17+i*4],val);
            FormIOModulesSetting.sgTable.Cells[1,i+1]:=FloatToStrF(val,ffGeneral,10,0);
            MainForm.ConvToFloat(recive[22+i*4],recive[23+i*4],
                      recive[24+i*4],recive[25+i*4],val);
            FormIOModulesSetting.sgTable.Cells[2,i+1]:=FloatToStrF(val,ffGeneral,6,5);
            MainForm.ConvToFloat(recive[30+i*4],recive[31+i*4],
                      recive[32+i*4],recive[33+i*4],val);
            FormIOModulesSetting.sgTable.Cells[3,i+1]:=FloatToStrF(val,ffGeneral,6,5);
            s:='������: ';
            if recive[38]=0 then s:=s+'������ - OFF  ' else s:=s+'������ - ON  ';
            if recive[39]=0 then s:=s+'������ - OFF' else s:=s+'������ - ON';
            FormIOModulesSetting.Label7.Caption:=s;
          end;
        end;
      end; Screen.Cursor:=crDefault;
    end;
  end else               {����������� ������������ ������ ��� ������ �� �������}
  begin
    Screen.Cursor:=crDefault;
    with FormIOModulesSetting do
    begin
      eNameMod.Text:='';Edit5.Text:='0';
      cbDataType.ItemIndex:=-1;ComboBox2.ItemIndex:=-1;cbFilter.ItemIndex:=-1;
      cbInputType.ItemIndex:=-1;
      lIdentModul.Caption:='������ ��������';
    end;
  end;
end;
//---------------------------------------------------//

procedure ReadModbusSetup;
var i:integer;str:string;
begin
  case PRT.status of
    twModbusFunc:
    begin
      if PRT.flg_first then
      begin
        PRT.flg_first:=false;FormModbusSetting.ViewWndModbusFunc;
        FormModbusSetting.cbSelFunc.ItemIndex:=2;
      end;SetLength(ModbusFunc,40);
      for i:=0 to Length(ModbusFunc)-1 do
      begin
        ModbusFunc[i].addr:=recive[8+i*6]*256+recive[9+i*6];
        ModbusFunc[i].pnt:=recive[10+i*6];ModbusFunc[i].logn:=recive[11+i*6];
        ModbusFunc[i].prm:=recive[12+i*6];ModbusFunc[i].conv:=recive[13+i*6];
        FormModbusSetting.sgTable.Cells[1,i+1]:=IntToStr(ModbusFunc[i].addr);
        FormModbusSetting.sgTable.Cells[2,i+1]:=IntToStr(ModbusFunc[i].pnt);
        FormModbusSetting.sgTable.Cells[3,i+1]:=IntToStr(ModbusFunc[i].logn);
        FormModbusSetting.sgTable.Cells[4,i+1]:=IntToStr(ModbusFunc[i].prm);
        FormModbusSetting.sgTable.Cells[5,i+1]:=IntToStr(ModbusFunc[i].conv);
      end;
    end;
    twModbusHost:
    begin
      if PRT.flg_first then
      begin PRT.flg_first:=false;FormModbusSetting.ViewWndModbusHost;end;
      SetLength(ModbusHost,30);
      for i:=0 to Length(ModbusHost)-1 do
      begin
        ModbusHost[i].addr:=recive[8+i*8];ModbusHost[i].func:=recive[9+i*8];
        ModbusHost[i].reg:=recive[10+i*8]+recive[11+i*8];;
        ModbusHost[i].new:=recive[12+i*8]+recive[13+i*8];;
        ModbusHost[i].count:=recive[14+i*8];
        ModbusHost[i].status:=recive[15+i*8];
        FormModbusSetting.sgTableHost.Cells[1,i+1]:=IntToStr(ModbusHost[i].addr);
        FormModbusSetting.sgTableHost.Cells[2,i+1]:=IntToStr(ModbusHost[i].func);
        FormModbusSetting.sgTableHost.Cells[3,i+1]:=IntToStr(ModbusHost[i].reg);
        FormModbusSetting.sgTableHost.Cells[4,i+1]:=IntToStr(ModbusHost[i].new);
        FormModbusSetting.sgTableHost.Cells[5,i+1]:=IntToStr(ModbusHost[i].count);
        if (ModbusHost[i].status and 128)=0 then check[i]:=false
               else check[i]:=true;
      end;FormModbusSetting.sgTableHost.Invalidate;
    end;
    twModbusScale:
    begin
      if PRT.flg_first then
      begin PRT.flg_first:=false;FormModbusSetting.ViewWndModbusScale;end;
      for i:=0 to Length(ModbusScale)-1 do
      begin
        MainForm.ConvToFloat(recive[8+i*4],recive[9+i*4],recive[10+i*4],
                       recive[11+i*4],ModbusScale[i].lo_val);
        FormModbusSetting.sgScale.Cells[1,i+1]:=
                           FloatToStrF(ModbusScale[i].lo_val,ffGeneral,6,5);
        MainForm.ConvToFloat(recive[56+i*4],recive[57+i*4],recive[58+i*4],
                       recive[59+i*4],ModbusScale[i].hi_val);
        FormModbusSetting.sgScale.Cells[2,i+1]:=
                           FloatToStrF(ModbusScale[i].hi_val,ffGeneral,6,5);
      end;
    end;
    twModbusStatus:
    begin
      if PRT.flg_first then
      begin PRT.flg_first:=false;FormModbusSetting.ViewWndModbusStatus;end;
      for i:=0 to Length(current_status)-1 do
      begin
        current_status[i]:=recive[8+i];
        case current_status[i] of
          128:str:='������ ���';
          129:str:='�������� ��� �������';
          130:str:='�������� ����� ������';
          131:str:='�������� ������';
          132:str:='�������� ������������';
          136:str:='���������� �� ��������';
        end;
        if current_status[i]<128 then
        begin current_status[i]:=0;str:='������ ��������';end;
        FormModbusSetting.sgStatus.Cells[1,i+1]:=str;
      end;
    end;
  end;Screen.Cursor:=crDefault;
end;
//---------------------------------------------------//

procedure ReadAllDescriptors;
const str_name:array[0..7]of string[15]=('����� ���������','������ �����',
      '������ �����','������ �����','�������� �����','��������������',
      '������ �/�',' ');
      status_size_panel:array[0..5]of word=(111,281,55,21,65,111);
var i,j,n:integer;str:string;
begin
  if recive[9]>0 then
  case Load.step of
    0:
    begin
      SetLength(ConfSet,recive[9]);
      for i:=0 to recive[9]-1 do
      begin {�������� �������� ����� �����}
        ConfSet[i].name:=recive[11+i*3];ConfSet[i].size:=recive[12+i*3];
        ConfSet[i].addr:=recive[13+i*3];
      end;
    end;
    1:for i:=0 to recive[9]-1 do
      begin {�������� �������� ����� �����}
        ConfSet[i].typ:=recive[11+i*3];ConfSet[i].num:=recive[12+i*3];
        ConfSet[i].units:=recive[13+i*3];
      end;
    2:
    begin {�������� ������� ������ ����� �����}
      SetLength(Select,recive[9]);n:=0;
      for i:=0 to recive[9]-1 do
      begin
        Select[i].num:=recive[10+n];
        SetLength(Select[i].selset,recive[11+n]);
        if Length(Select[i].selset)>0 then
        for j:=0 to Length(Select[i].selset)-1 do
        Select[i].selset[j]:=recive[12+n+j];n:=n+2+recive[11+n];
      end;
    end;
    3:begin  {�������� ���.��� �����}
        SetLength(Dyn,recive[9]);
        for i:=0 to recive[9]-1 do
        begin
          Dyn[i].addr:=recive[11+i*4];Dyn[i].size:=recive[12+i*4];
          Dyn[i].name:=recive[13+i*4];Dyn[i].units:=recive[14+i*4];
        end;
      end;
    4:for i:=0 to recive[9]-1 do
      begin
        Dyn[i].verify:=recive[11+i*4];Dyn[i].modbus:=recive[12+i*4];
        Dyn[i].script:=recive[13+i*4];Dyn[i].clear:=recive[14+i*4];
      end;
    5:
    begin
      SetLength(MainSet,recive[9]);
      for i:=0 to recive[9]-1 do
      begin {�������� �������� �������}
        MainSet[i].name:=recive[11+i*3];MainSet[i].size:=recive[12+i*3];
        MainSet[i].addr:=recive[13+i*3];
      end;
    end;
    6:for i:=0 to recive[9]-1 do
      begin {�������� �������� �������}
        MainSet[i].typ:=recive[11+i*3];MainSet[i].num:=recive[12+i*3];
        MainSet[i].units:=recive[13+i*3];
      end;
    7:
    begin {�������� ������� ������ �������}
      SetLength(SelMain,recive[9]);n:=0;
      for i:=0 to recive[9]-1 do
      begin
        SelMain[i].num:=recive[10+n];SetLength(SelMain[i].selset,recive[11+n]);
        if Length(SelMain[i].selset)>0 then
        for j:=0 to Length(SelMain[i].selset)-1 do
        SelMain[i].selset[j]:=recive[12+n+j];n:=n+2+recive[11+n];
      end;
    end;
    9:
    begin
      SetLength(ConfSetICP,recive[9]);
      for i:=0 to recive[9]-1 do
      begin
        ConfSetICP[i].typ:=recive[11+i*3];ConfSetICP[i].num:=recive[12+i*3];
        ConfSetICP[i].units:=recive[13+i*3];
      end;
    end;
    10:for i:=0 to recive[9]-1 do
       begin
         ConfSetICP[i].name:=recive[11+i*3];ConfSetICP[i].size:=recive[12+i*3];
         ConfSetICP[i].addr:=recive[13+i*3];
       end;
    11:
    begin
      SetLength(ConfSetExp,recive[9]);
      for i:=0 to recive[9]-1 do
      begin
        ConfSetExp[i].name:=recive[11+i*3];ConfSetExp[i].units:=0;
        ConfSetExp[i].addr:=recive[13+i*3];ConfSetExp[i].size:=recive[12+i*3];
      end;
    end;
    12:
    for i:=0 to recive[9]-1 do
    begin
      ConfSetExp[i].typ:=recive[11+i*2];ConfSetExp[i].num:=recive[12+i*2];
    end;
    13:
    begin
      SetLength(DynExp,recive[9]);n:=0;
      for i:=0 to recive[9]-1 do
      begin
        DynExp[i].addr:=recive[11+i*5];DynExp[i].size:=recive[12+i*5];
        DynExp[i].typ:=recive[13+i*5];DynExp[i].name:=recive[14+i*5];
        DynExp[i].modbus:=recive[15+i*5];
      end;
      for i:=0 to Length(DynExp)-1 do if(DynExp[i].typ>0)and(DynExp[i].typ<4)then
      begin
        SetLength(ArchExpandSet,n+1);ArchExpandSet[n].units:=0;
        ArchExpandSet[n].typ:=DynExp[i].typ;
        ArchExpandSet[n].addr:=DynExp[i].addr;
        ArchExpandSet[n].name:=DynExp[i].name;n:=n+1;
      end;//ShowMessage(IntToStr(n));
    end;
    14:
    begin
      PRT.load_visible:=0; PRT.typ_task:=recive[23];
      MainForm.StatusBar.Panels.Items[0].Width:=size_panel;
      cbStatus.Width:=MainForm.StatusBar.Panels[1].Width;
      cbStatus.Height:=MainForm.StatusBar.Height-4;
      if recive[23]=6 then
      begin {���������� ���� MVS}
        MainForm.MainMenu.Items.Items[5].Items[2].Enabled:=false;
        MainForm.ToolButton10.Enabled:=false;
      end;
      if recive[23]<Length(str_status) then cbStatus.Items.Add(str_status[recive[23]]);
      str:='';for i:=0 to 7 do str:=str+IntToHex(recive[11+i],2);
      cbStatus.Items.Add('����������� �����: '+
      IntToHex((recive[19]*256+recive[20])*65536+recive[21]*256+recive[22],8));
      cbStatus.Items.Add('�������� �����: '+str);cbStatus.ItemIndex:=0;
      cbStatus.Visible:=true;FormConfigurationSettings.tcConf.Tabs.Clear;
      for i:=0 to 7 do if recive[27+i*6]=1 then
      begin
        n:=FormConfigurationSettings.tcConf.Tabs.Add(str_name[i]);
        SetLength(num_item_conf,FormConfigurationSettings.tcConf.Tabs.Count);
        SetLength(num_page_conf,FormConfigurationSettings.tcConf.Tabs.Count);num_page_conf[n]:=i;
        for j:=0 to 4 do num_item_conf[n,j]:=recive[28+i*6+j];
      end;contract:=recive[75];
      for i:=0 to Length(SetPort)-1 do SetPort[i].typ:=recive[76+i];
      n:=recive[6]-84;
      if n>0 then
      begin
        SetLength(ind_prm_alm,n);
        for i:=0 to Length(ind_prm_alm)-1 do ind_prm_alm[i]:=recive[80+i];
      end;
      //for i:=0 to Length(num_item_conf)-1 do for j:=0 to 4 do ShowMessage(IntToStr(num_item_conf[i,j]));
      MainForm.StatusBar.Visible:=true;
      MainForm.Panel2.Width:=800;MainForm.Panel2.Height:=510;MainForm.Panel2.Left:=2;
      MainForm.pCommunic.Visible:=false;MainForm.Panel2.Visible:=true;
      MainForm.Top:=0;MainForm.Left:=0;MainForm.Width:=800;MainForm.Height:=575;
      FormConfigurationSettings.Top:=MainForm.Top+105;FormConfigurationSettings.Left:=MainForm.Left+75; MainForm.ToolBar1.Visible:=true;
      for i:=1 to MainForm.MainMenu.Items.Count-1 do
      MainForm.MainMenu.Items.Items[i].Visible:=true;
      MainForm.MainMenu.Items.Items[0].Enabled:=false;
      MainForm.MainMenu.Items.Items[9].Visible:=false;
    end;
    8:
    begin {�������� �������� �������� ����������}
      SetLength(ArchBasicSet,recive[9]);
      if Length(ArchBasicSet)>0 then for i:=0 to recive[9]-1 do
      begin
        ArchBasicSet[i].units:=recive[11+i*4];
        ArchBasicSet[i].addr:=recive[12+i*4];
        ArchBasicSet[i].typ:=recive[13+i*4];
        ArchBasicSet[i].name:=recive[14+i*4];
      end;
    end;
  end;Load.step:=Load.step+1;Load.addr:=0;
end;
//---------------------------------------------------//

procedure ReadMonitor;
var i:integer;s:string;
begin {������ ���� ���������� �������  }
  if PRT.flg_first then
  begin
    if PRT.status=twMonitor then
    begin FormForVariablesView.ViewWndMonutor;PRT.flg_first:=false;end else
    if PRT.status=twDispExp then
    begin FormForVariablesView.ViewWndMonutorExp;PRT.flg_first:=false;end;
  end;
  if recive[8]>0 then
  begin
    SetLength(Disp,recive[8]);
    for i:=0 to recive[8]-1 do MainForm.ConvToFloat(recive[9+i*4],recive[10+i*4],
                       recive[11+i*4],recive[12+i*4],Disp[i]);
    if PRT.status=twMonitor then FormForVariablesView.ViewMonutor else
    if PRT.status=twDispExp then FormForVariablesView.ViewMonutorExp;
  end;Load.step:=Load.step+1;Screen.Cursor:=crDefault;
end;
//---------------------------------------------------//

procedure ReadParamVerify;
var i,j,n:integer;values:array of single;
begin {������ ���� ���������� ���������� �������,�� ����� �����.}
  n:=1;
  if recive[7]>0 then
  begin
    SetLength(values,recive[7]);
    for i:=0 to recive[7]-1 do
    MainForm.ConvToFloat(recive[8+i*4],recive[9+i*4],recive[10+i*4],
                      recive[11+i*4],values[i]);i:=0;
    for j:=0 to Length(Dyn)-1 do if Dyn[j].verify>0 then
    begin
      if (Dyn[j].verify=1)and(i<Length(values)) then
      begin
        FormConfigurationSettings.sgConfPnt.Cells[1,n]:=FloatToStrF(values[i],ffGeneral,6,5);i:=i+1;
      end;n:=n+1;
    end;
  end;Screen.Cursor:=crDefault;
end;
//---------------------------------------------------//

procedure ReadDateTime;
var flg:boolean;
begin {������ ������� ����/����� ����� ����������� }
  flg:=false;
  try
    crDT:=EncodeDate(recive[7]+2000,recive[8],recive[9])+
                EncodeTime(recive[10],recive[11],recive[12],0);
  except on EConvertError do flg:=true;end;
  if flg=false then
  begin
    if PRT.flg_picker=true then
    begin
      FormConfigurationSettings.DateTimePicker1.DateTime:=crDT;FormConfigurationSettings.MonthCalendar1.Date:=crDT;
      PRT.flg_picker:=false;
    end;
  end;
end;
//---------------------------------------------------//

procedure TerminateLoad;
begin
  PRT.status:=twNone;flg_cmd:=1;FormForVariablesView.Visible:=false;Screen.Cursor:=crDefault;
  PRT.load_visible:=0;MainForm.StatusBar.Panels.Items[0].Width:=size_panel;
  cbStatus.Visible:=true;
end;
//---------------------------------------------------//

procedure ReadLestArchRecord;
var flg_res,size:integer;
begin
  AssignFile(f_arc,namea);{$I-}Reset(f_arc);{$I+} flg_res:=IOResult;
  if flg_res = 0 then
  begin
    size:=FileSize(f_arc);Seek(f_arc,size-1);Read(f_arc,d_arc); 
    old_rec_arc:=d_arc;CloseFile(f_arc);
  end;
end;
//---------------------------------------------------//

procedure ReadLestEventRecord(file_name:string);
var flg_res,size:integer;
begin
  AssignFile(f_event,file_name);{$I-}Reset(f_event);{$I+} flg_res:=IOResult;
  if flg_res = 0 then
  begin
    size:=FileSize(f_event);Seek(f_event,size-1);Read(f_event,d_event);
    old_rec_evt:=d_event;CloseFile(f_event);
  end;
end;
//---------------------------------------------------//

procedure ReadAllPointers;
var flg_res,size:integer;
begin {������ ��������� ������� ������ � �������}
  Pntr.page:=recive[13];Pntr.minute:=recive[22];PRT.count_str:=0;
  case Pntr.page of
    0:Pntr.archive:=recive[14]*256+recive[15];
    1:Pntr.archive:=recive[16]*256+recive[17];
    2:Pntr.archive:=recive[18]*256+recive[19];
  end;Newest.page:=Pntr.page;Newest.archive:=Pntr.archive;
  //ShowMessage('��������: '+IntToStr(Pntr.page)+' ����� ������: '+IntToStr(Pntr.archive));
  if PRT.load_update<>1 then
  begin
    if (Pntr.archive=0)and(Pntr.page=0)and((PRT.status=twDay)or
       (PRT.status=twHour)) then TerminateLoad
    else Pntr.archive:=Pntr.archive-1;Pntr.cnt_arch:=0;
    if Pntr.minute=0 then Pntr.minute:=59 else Pntr.minute:=Pntr.minute-1;
    case Prt.status of
      twEvent:Pntr.event:=recive[7]*256+recive[8];
      twAlarm:Pntr.event:=recive[9]*256+recive[10];
      twNst:Pntr.event:=recive[11]*256+recive[12];
    end;
    if ((Prt.status=twEvent)or(Prt.status=twAlarm)or(Prt.status=twNst))and
        (Pntr.event=0) then TerminateLoad
    else Pntr.event:=Pntr.event-1;Pntr.cnt_event:=0;bStep.Enabled:=false;
  end else
  begin
    Pntr.event:=recive[7]*256+recive[8];Pntr.alarm:=recive[9]*256+recive[10];
    Pntr.error:=recive[11]*256+recive[12];Newest.event:=Pntr.event;
    Newest.alarm:=Pntr.alarm;Newest.error:=Pntr.error;
    if ((Pntr.archive=0)and(Pntr.page=0))or((Older.archive=Pntr.archive)and
       (Older.page=Pntr.page)) then
    begin
      if Older.event<>Pntr.event then
      begin
        Pntr.event:=Pntr.event-1;PRT.load_update:=3;SetLength(buff_event,0);
        Pntr.cnt_event:=0;ReadLestEventRecord(namet);
      end else
      if Older.alarm<>Pntr.alarm then
      begin
        Pntr.event:=Pntr.alarm-1;PRT.load_update:=4;SetLength(buff_event,0);
        Pntr.cnt_event:=0;ReadLestEventRecord(namer);
      end else
      begin PRT.load_update:=0;TerminateLoad;MainForm.Timer3.Interval:=800;end;
    end else
    begin
      //ShowMessage('�������� ������');
      Pntr.archive:=Pntr.archive-1;PRT.load_update:=2;SetLength(buff_archive,0);
      Pntr.cnt_arch:=0;ReadLestArchRecord;
    end;
  end;
end;
//---------------------------------------------------//

procedure ReadLargeBlockMVS;
const str_units:array[0..1]of string[100]=(
      '    �����               IH2O                    PSI                    F',
      '    �����               ���                     ���                     '+
                   Char($b0)+'�');
var i,j:integer;s:string;
begin {������ ������� ���� ���������� MVS }
  {if Prt.status=twMvs then
  begin
    for i:=0 to 2 do
    Sensor.byn[i]:=recive[7+i];
    FormEcoSonicSetting.EAdrMVSset.Text:=IntToStr(recive[7]);
    FormEcoSonicSetting.cbUnits.ItemIndex:=Sensor.byn[1];
    if Sensor.byn[1]<Length(str_units)then
      FormEcoSonicSetting.Label2.Caption:=str_units[Sensor.byn[1]];s:='';
    if Sensor.byn[2]=0 then
    FormEcoSonicSetting.Edit60.Visible:=false else FormEcoSonicSetting.Edit60.Visible:=true;
    if Sensor.byn[2]=128 then
    begin
      FormEcoSonicSetting.Edit60.Text:='������ �� ��������';
      FormEcoSonicSetting.sgTable.Visible:=false;
      FormEcoSonicSetting.GroupBox10.Enabled:=false;FormEcoSonicSetting.GroupBox11.Enabled:=false;
      FormEcoSonicSetting.GroupBox12.Enabled:=false;FormEcoSonicSetting.BReturn.Enabled:=false;
    end else
    begin
      FormEcoSonicSetting.sgTable.Visible:=true;
      FormEcoSonicSetting.GroupBox10.Enabled:=true;FormEcoSonicSetting.GroupBox11.Enabled:=true;
      FormEcoSonicSetting.GroupBox12.Enabled:=true;FormEcoSonicSetting.BReturn.Enabled:=true;
    end;
    if Sensor.byn[2]=4 then
    FormEcoSonicSetting.Edit60.Text:='������������������ ���������';
    for i:=0 to 9 do s:=s+Char(recive[10+i]);
    FormEcoSonicSetting.ETagMVS.Text:=s;Sensor.tag:=s;
    for i:=0 to 20 do
    MainForm.ConvToFloat(recive[20+i*4],recive[21+i*4],recive[22+i*4],
              recive[23+i*4],Sensor.prm[i]);
    FormEcoSonicSetting.Edit52.Text:=FloatToStrF(Sensor.prm[0],ffGeneral,6,5);
    FormEcoSonicSetting.Edit53.Text:=FloatToStrF(Sensor.prm[1],ffGeneral,6,5);
    FormEcoSonicSetting.Edit54.Text:=FloatToStrF(Sensor.prm[2],ffGeneral,6,5);
    FormEcoSonicSetting.Edit55.Text:=FloatToStrF(Sensor.prm[3],ffGeneral,6,5);
    FormEcoSonicSetting.Edit1.Text:=FloatToStrF(Sensor.prm[5],ffGeneral,6,5);
    for i:=0 to 4 do for j:=0 to 2 do
    FormEcoSonicSetting.sgTable.Cells[j+1,i+1]:=FloatToStrF(Sensor.prm[j*5+i+6],ffGeneral,6,5);
    for i:=0 to Length(Sensor.alm_set)-1 do
    for j:=0 to Length(Sensor.alm_set[i])-1 do
    begin {���������� ������� �������}
{      MainForm.ConvToFloat(recive[104+j*4+i*12],recive[105+j*4+i*12],
              recive[106+j*4+i*12],recive[107+j*4+i*12],Sensor.alm_set[i,j]);
      FormEcoSonicSetting.sgTable.Cells[i+1,j+7]:=FloatToStrF(Sensor.alm_set[i,j],ffGeneral,6,5);
    end;
    Sensor.alm_enb:=recive[140];
    for i:=0 to 2 do
    if (Sensor.alm_enb)and(Floor(Power(2,i)))>0 then
    check[i]:=true else check[i]:=false;FormEcoSonicSetting.sgTable.Repaint;
  end;Screen.Cursor:=crDefault; }
end;
//---------------------------------------------------//

procedure ReadSmallBlockMVS;
var i:integer;str_alm:array[0..2]of string;
begin {������ ������ � ������������ ��������� MVS  }
{  if Prt.status=twMvs then
  begin
    Sensor.byn[2]:=recive[7];
    if Sensor.byn[2]=0 then FormEcoSonicSetting.Edit60.Visible:=false
    else FormEcoSonicSetting.Edit60.Visible:=true;
    if Sensor.byn[2]=128 then
    begin
      FormEcoSonicSetting.Edit60.Text:='������ �� ��������';
      FormEcoSonicSetting.sgTable.Visible:=false;
      FormEcoSonicSetting.GroupBox10.Enabled:=false;FormEcoSonicSetting.GroupBox11.Enabled:=false;
      FormEcoSonicSetting.GroupBox12.Enabled:=false;FormEcoSonicSetting.BReturn.Enabled:=false;
    end else
    begin
      FormEcoSonicSetting.sgTable.Visible:=true;
      FormEcoSonicSetting.GroupBox10.Enabled:=true;FormEcoSonicSetting.GroupBox11.Enabled:=true;
      FormEcoSonicSetting.GroupBox12.Enabled:=true;FormEcoSonicSetting.BReturn.Enabled:=true;
    end;
    if Sensor.byn[2]=4 then FormEcoSonicSetting.Edit60.Text:='������������������ ���������';
    for i:=0 to 3 do
    MainForm.ConvToFloat(recive[8+i*4],recive[9+i*4],recive[10+i*4],
              recive[11+i*4],Sensor.prm[i]);
    case mvs_cbr of
      1,4,5:FormEcoSonicSetting.ECbrCurVal.Text:=FloatToStrF(Sensor.prm[1],ffGeneral,6,5);
      2:FormEcoSonicSetting.ECbrCurVal.Text:=FloatToStrF(Sensor.prm[2],ffGeneral,6,5);
      3:FormEcoSonicSetting.ECbrCurVal.Text:=FloatToStrF(Sensor.prm[3],ffGeneral,6,5);
    end;
    FormEcoSonicSetting.Edit52.Text:=FloatToStrF(Sensor.prm[0],ffGeneral,6,5);
    FormEcoSonicSetting.Edit53.Text:=FloatToStrF(Sensor.prm[1],ffGeneral,6,5);
    FormEcoSonicSetting.Edit54.Text:=FloatToStrF(Sensor.prm[2],ffGeneral,6,5);
    FormEcoSonicSetting.Edit55.Text:=FloatToStrF(Sensor.prm[3],ffGeneral,6,5);
    for i:=0 to Length(Sensor{[page_mvs]}{.alm_status)-1  do
    begin
      Sensor.alm_status[i]:=recive[24+i];
      if (Sensor.alm_enb)and(Floor(Power(2,i)))>0 then
      case Sensor.alm_status[i] of
        0:str_alm[i]:='';1:str_alm[i]:='Lo';2:str_alm[i]:='Hi';
      end;FormEcoSonicSetting.sgTable.Cells[i+1,10]:=str_alm[i];
    end;
  end;}
end;
//---------------------------------------------------//

procedure ReadCodeScript;
var i,k:integer;
begin  
  if PRT.flg_first then
  begin FormForScript.ViewNewTable;FormForScript.Visible:=true;PRT.flg_first:=false;k:=0;end
  else k:=Length(ScriptData);
  if recive[9]>0 then for i:=0 to recive[9]-1 do
  begin
    SetLength(ScriptData,k+1+i);ScriptData[k+i].op_code:=recive[10+i*6];
    if ScriptData[k+i].op_code>0 then
    begin
      ScriptData[k+i].pnt:=recive[11+i*6];
      if ScriptData[k+i].pnt=0 then
      MainForm.ConvToFloat(recive[12+i*6],recive[13+i*6],recive[14+i*6],
        recive[15+i*6],ScriptData[k+i].value)else
      begin
        ScriptData[k+i].param:=recive[12+i*6];
        ScriptData[k+i].num:=recive[13+i*6];
        ScriptData[k+i].transit:=recive[14+i*6]*256+
          recive[15+i*6];
      end;
    end else begin Load.flg_end:=true;Break;end;
  end; Load.addr:=Load.addr+40; if Load.addr>=680 then Load.flg_end:=true;
  if Load.flg_end then FormForScript.ReadScript;
end;
//---------------------------------------------------//

procedure WriteCodeScript;
begin
  Load.addr:=Load.addr+Load.step;//ShowMessage(IntToStr(Load.addr));
  if Load.addr<Length(ScriptData)then
  begin
    if Length(ScriptData)-Load.addr>=40 then Load.step:=40 else
    Load.step:=Length(ScriptData)-Load.addr;
  end else Load.flg_end:=true;
end;
//---------------------------------------------------//

//29.11.2021 YN added:
procedure ReadDataFS;
var i, j, num:byte; value:longword; str:string;
begin
  //str:='';for i:=0 to recive[6]-1 do str:=str +IntToStr(recive[i])+' ';
  //   ShowMessage('�����: '+str);
  if recive[6]>12 then
  begin
    FormEcoSonicSetting.mFs.Clear; num:=recive[8]*256+recive[9];
    FormEcoSonicSetting.eNum.Text:=IntToStr(num);
    MainForm.ConvertToLong(recive[10],recive[11],recive[12],recive[13],value);
    FormEcoSonicSetting.eGut.Text:=IntToStr(value);
    MainForm.ConvertToLong(recive[14],recive[15],recive[16],recive[17],value);
    FormEcoSonicSetting.eBad.Text:=IntToStr(value);
    if num>0 then for i:=0 to num-1 do
    begin
      str:='';
      for j:=0 to 11 do if recive[18+i*16+j]>$20 then
        str:=str+Char(recive[18+i*16+j]) else str:=str+Char($20);
      MainForm.ConvertToLong(recive[30+i*16],recive[31+i*16],recive[32+i*16],
                    recive[33+i*16],value);
      str:=str+'                         '+IntToStr(value);
      FormEcoSonicSetting.mFs.Lines.Add(str);
    end; Screen.Cursor:=crDefault;
  end;
end;
//---------------------------------------------------//

//29.11.2021 YN added:
procedure ReadDataABB;
var i, j:byte;
begin
  if recive[6]>12 then
  begin   
    for i:=0 to 2 do
    MainForm.ConvToFloat(recive[8+i*4],recive[9+i*4],recive[10+i*4],recive[11+i*4],
                       Sensor.prm[i]);
    FormEcoSonicSetting.eValDiff.Text:=FloatToStrF(Sensor.prm[0],ffGeneral,5,5);
    FormEcoSonicSetting.eValPress.Text:=FloatToStrF(Sensor.prm[1],ffGeneral,5,5);
    FormEcoSonicSetting.eValTemp.Text:=FloatToStrF(Sensor.prm[2],ffGeneral,5,5);
    if recive[20]<Length(units_press) then
    FormEcoSonicSetting.eUDiff.Text:=units_press[recive[20]] else FormEcoSonicSetting.eUDiff.Text:=' ';
    if recive[21]<Length(units_press) then
      FormEcoSonicSetting.eUPress.Text:=units_press[recive[21]] else FormEcoSonicSetting.eUPress.Text:=' ';
    if (recive[22]>=32)and(recive[22]<=35) then
      FormEcoSonicSetting.eUTemp.Text:=units_temp[recive[22]-32] else FormEcoSonicSetting.eUTemp.Text:=' ';
    for i:=0 to 5 do
    MainForm.ConvToFloat(recive[24+i*4],recive[25+i*4],recive[26+i*4],recive[27+i*4],
                       Sensor.prm[i+3]);
    FormEcoSonicSetting.eLoDiff.Text:=FloatToStrF(Sensor.prm[3],ffGeneral,5,5);
    FormEcoSonicSetting.eHiDiff.Text:=FloatToStrF(Sensor.prm[4],ffGeneral,5,5);
    FormEcoSonicSetting.eLoPress.Text:=FloatToStrF(Sensor.prm[5],ffGeneral,5,5);
    FormEcoSonicSetting.eHiPress.Text:=FloatToStrF(Sensor.prm[6],ffGeneral,5,5);
    FormEcoSonicSetting.eLoTemp.Text:=FloatToStrF(Sensor.prm[7],ffGeneral,5,5);
    FormEcoSonicSetting.eHiTemp.Text:=FloatToStrF(Sensor.prm[8],ffGeneral,5,5);
    FormEcoSonicSetting.mError.Lines.Clear;
    for j:=0 to 3 do for i:=0 to 7 do
    begin
      if (recive[48+j])and(etl[i])>0 then FormEcoSonicSetting.mError.Lines.Add(str_err[i+j*8]);
    end;
  end;
  Screen.Cursor:=crDefault;
end;
//---------------------------------------------------//

procedure CalibrationMVS;
const
   k:array[0..4]of byte=(1,2,3,4,5);{������� ���������� }
begin
{  if mvs_cbr<4 then
  begin
    FormEcoSonicSetting.Label55.Caption:=scal[stp_cbr];mvs_cmd[1]:=k[stp_cbr];
    if FormEcoSonicSetting.pCallibr.Visible then
    begin
      FormEcoSonicSetting.ECbrValue.Text:='';FormEcoSonicSetting.ECbrValue.SetFocus;
    end;
    if stp_cbr>=2 then FormEcoSonicSetting.bCalibrSave.Enabled:=true;
    if stp_cbr>=5 then FormEcoSonicSetting.bCalibrExec.Enabled:=false;stp_cbr:=stp_cbr+1;
  end; }
end;
//---------------------------------------------------//

procedure ReadEventsAlarms;
var i,j:integer;flag:boolean;
begin {���� ��������: �������,�������,��������� }
  if (PRT.load_update = 3)or(PRT.load_update = 4) then
  begin
    Pntr.event:=recive[8]*256+recive[9];
    //ShowMessage('����� ������� �����: '+IntToStr(Pntr.cnt_event));
    if recive[7]>0 then for i:=0 to recive[7]-1 do
    begin
      SetLength(buff_event,Length(buff_event)+1);flag:=false;
      for j:=0 to size_event-1 do
      buff_event[Pntr.cnt_event].a_event[j]:=recive[11+j+i*size_event];
      for j:=0 to size_event-1 do
      if buff_event[Pntr.cnt_event].a_event[j]<>old_rec_evt.a_event[j] then
      begin flag:=true;Break;end;
      if flag=false then
      begin PRT.flg_end:=true;SetLength(buff_event,Pntr.cnt_event);Break;end else
      Pntr.cnt_event:=Pntr.cnt_event+1;
    end;if recive[10]=1 then PRT.flg_end:=true;
  end else
  begin
    case Prt.status of
      twEvent:
      begin
        if PRT.flg_first then
        begin PRT.flg_first:=false;FormForVariablesView.ViewWndEvents;end;FormForVariablesView.ViewEvents;
      end;
      twAlarm:
      begin
        if PRT.flg_first then
        begin PRT.flg_first:=false;FormForVariablesView.ViewWndAlarms;end;FormForVariablesView.ViewAlarms;
      end;
      twNst:
      begin
        if PRT.flg_first then
        begin PRT.flg_first:=false;FormForVariablesView.ViewWndNst;end;FormForVariablesView.ViewNst;
      end;
    end;Screen.Cursor:=crDefault;
  end;
end;
//---------------------------------------------------//

procedure CalibrationICP;
begin
  Screen.Cursor:=crDefault;
  if ICP.flg_calibr>0 then
  begin
    if ICP.event<>11 then ICP.flg_calibr:=ICP.flg_calibr+1;
    if ICP.flg_calibr<4 then FormIOModulesSetting.CalibrateStep;
    if ICP.flg_calibr=4 then
    begin
      ICP.flg_calibr:=0;FormIOModulesSetting.Label4.Caption:='';FormIOModulesSetting.Label9.Caption:='';
      FormIOModulesSetting.tcPageICP.Enabled:=true;FormIOModulesSetting.pCallibrAin.Visible:=false;
      if ICP.typ<2 then {��������� ���������� ������ ��� ������ ������ �������}
      begin ICP.event:=2;ICP.wrt[0]:=0;flg_cmd:=11;end;
      Screen.Cursor:=crHourGlass;
    end;
  end;
end;
//---------------------------------------------------//

procedure ReadHourDayArchive;
var i,j,arc_point:integer;value:single;flag:boolean;
begin {������� ����� �� ��������}
  if PRT.load_update<>2 then
  begin
    if (PRT.status=twHour)or(PRT.status=twDay)then
    begin
      if PRT.flg_first then
      begin PRT.flg_first:=false;FormForVariablesView.ViewWndArchive;end;
      FormForVariablesView.ViewArchive(PRT.number_arc,PRT.size_arc);
      if PRT.flg_end then bStep.Enabled:=false;
    end;Screen.Cursor:=crDefault;
  end else
  begin     
    Pntr.page:=recive[8];Pntr.archive:=recive[9]*256+recive[10];PRT.number_arc:=0;
    if Length(Arch)>0 then for i:=0 to Length(Arch)-1 do
    case Arch[i].pnt of
      1:if Length(ArchBasicSet)>0 then for j:=0 to Length(ArchBasicSet)-1 do
        if Arch[i].num=ArchBasicSet[j].addr then
        begin PRT.number_arc:=PRT.number_arc+1;Break;end;
      2:if Length(ArchExpandSet)>0 then for j:=0 to Length(ArchExpandSet)-1 do
        if Arch[i].num=ArchExpandSet[j].addr then
        begin PRT.number_arc:=PRT.number_arc+1;Break;end;
    end;PRT.size_arc:=PRT.number_arc*4+7;
    //ShowMessage('��������: '+IntToStr(Pntr.page)+' ���������: '+IntToStr(Pntr.archive)+' �����: '+IntToStr(recive[11]));
    if recive[7]>0 then for i:=0 to recive[7]-1 do
    begin
      SetLength(buff_archive,Length(buff_archive)+1);flag:=false;
      buff_archive[Pntr.cnt_arch].a_type:=recive[12+i*PRT.size_arc];
      try
        buff_archive[Pntr.cnt_arch].a_time:=
          EncodeDate(recive[13+i*PRT.size_arc]+2000,recive[14+i*PRT.size_arc],
          recive[15+i*PRT.size_arc])+EncodeTime(recive[16+i*PRT.size_arc],
          recive[17+i*PRT.size_arc],recive[18+i*PRT.size_arc],0);
      except on EConvertError do;end;
      for j:=0 to PRT.number_arc-1 do if MainForm.ConvToFloat(
        recive[19+i*PRT.size_arc+j*4],recive[20+i*PRT.size_arc+j*4],
        recive[21+i*PRT.size_arc+j*4],recive[22+i*PRT.size_arc+j*4],value) then
        buff_archive[Pntr.cnt_arch].a_data[j]:=value;
      if (buff_archive[Pntr.cnt_arch].a_time=old_rec_arc.a_time)and
         (buff_archive[Pntr.cnt_arch].a_type=old_rec_arc.a_type) then
      begin
        for j:=0 to PRT.number_arc-1 do
        if buff_archive[Pntr.cnt_arch].a_data[j]<>old_rec_arc.a_data[j] then
        begin flag:=true;Break;end;
      end else flag:=true;
      if flag=false then
      begin PRT.flg_end:=true;SetLength(buff_archive,Pntr.cnt_arch);Break;end else
      Pntr.cnt_arch:=Pntr.cnt_arch+1;
      //arc_point:=Pntr.archive-1;
      //if arc_point>=0 then  Pntr.archive:=Pntr.archive-1 else
     // begin
      //  Pntr.archive:=0;
      //  case Pntr.page of
      //    0:Pntr.page:=2;1:Pntr.page:=0;2:Pntr.page:=1;end;
      //end;
      //if (Pntr.page=Current.page)and(Pntr.archive=Current.archive) then
      //begin PRT.flg_end:=true;Break;end;
    end else PRT.flg_end:=true;
    if recive[11]=1 then PRT.flg_end:=true;
  end;
end;
//---------------------------------------------------//

procedure ReadMinuteArchive;
begin {������� �������� ����� �� ��������}
  if PRT.status=twMin then
  begin
    if PRT.flg_first then
    begin PRT.flg_first:=false;FormForVariablesView.ViewWndArchive;end;
    FormForVariablesView.ViewArchiveMinute(PRT.number_arc,PRT.size_arc);
  end;Screen.Cursor:=crDefault;
end;
//---------------------------------------------------//

procedure SaveConfigToFile;
var i:integer;count:byte;
begin { ��������� �������� ������������ � ������}
  count:=recive[6]-11;
  for i:=0 to Length(Main_config[conf_page])-1 do Main_config[conf_page,i]:=0;
  for i:=0 to count-1 do Main_config[conf_page,i]:=recive[i+7];conf_page:=conf_page+1;
end;
//---------------------------------------------------//

procedure LoadConfigToDevice;
begin
  if PRT.flg_first=false then
  begin
    conf_page:=conf_page+1;
    if conf_page=7 then PRT.addr_buf:=1;PRT.num_prm:=0;PRT.addr_buf:=0;
  end;
end;
//---------------------------------------------------//

procedure ReadConfiguration(Sender: TObject);
const str_name:array[0..7]of string[25]=('������������ �����','������������ �������',
      '������������ �������','������������ �������','������������ �������',
      '������������ ��� ������','������������ ������� �/�',' ');
      str_item:array[1..11]of string[20]=('��������','���� � �����',
      '��������� ������','��������� ������','Modbus','��������',
      '������� ��������','����� ���������','��������','���������','��������');
      ind_image:array[1..11]of byte=(9,0,3,10,11,9,4,6,9,4,9);
var i,j:integer;a:TTreeNode;
begin {������ ���������������� ���������}
  for i:=0 to Length(ConfData.buf)-1 do ConfData.buf[i]:=recive[7+i];
  if flg_set_conf=false then
  begin
    if FormConfigurationSettings.tvConfMain.Selected<>nil then
      FormConfigurationSettings.tvConfMainChange(Sender,FormConfigurationSettings.tvConfMain.Selected)
  end else
  begin
    flg_set_conf:=false;FormConfigurationSettings.tvConfMain.Items.Clear;
    a:=FormConfigurationSettings.tvConfMain.Items.Add(nil,
                          str_name[num_page_conf[FormConfigurationSettings.tcConf.TabIndex]]);
    a.ImageIndex:=1;a.SelectedIndex:=1;a.StateIndex:=0;
    for i:=0 to 4 do
    if num_item_conf[FormConfigurationSettings.tcConf.TabIndex,i]>0 then
    begin
      a:=FormConfigurationSettings.tvConfMain.Items.AddChild(FormConfigurationSettings.tvConfMain.Items.Item[0],
                     str_item[num_item_conf[FormConfigurationSettings.tcConf.TabIndex,i]]);
      a.ImageIndex:=ind_image[num_item_conf[FormConfigurationSettings.tcConf.TabIndex,i]];
      a.SelectedIndex:=a.ImageIndex;
      a.StateIndex:=num_item_conf[FormConfigurationSettings.tcConf.TabIndex,i];
    end;
  end;
  FormConfigurationSettings.pDevice.Visible:=true;
  if num_page_conf[FormConfigurationSettings.tcConf.TabIndex]=0 then
  begin
    Typ_task:=recive[7];j:=0;
    if Length(MainSet)>0 then for i:=0 to Length(MainSet)-1 do
    begin
      if (MainSet[i].typ=8)and(ConfData.buf[MainSet[i].addr]>0) then
      begin {���������� �������� ���������� ��� �����}
        SetLength(Arch,j+1);Arch[j].pnt:=ConfData.buf[MainSet[i].addr];
        Arch[j].logn:=ConfData.buf[MainSet[i].addr+1];
        Arch[j].num:=ConfData.buf[MainSet[i].addr+2];
        Arch[j].offset:=ConfData.buf[MainSet[i].addr+3]; j:=j+1;
      end;
      if Length(Arch)>0 then
      MainForm.MainMenu.Items.Items[4].Enabled:=true else
      MainForm.MainMenu.Items.Items[4].Enabled:=false;
      if MainSet[i].typ=7 then
      begin {���������� �������� Modbus}
        ModbusConf.mode:=(ConfData.buf[MainSet[i].addr] and 16) shr 4;
        ModbusConf.pool:=(ConfData.buf[MainSet[i].addr] and 8) shr 3;
        ModbusConf.com :=(ConfData.buf[MainSet[i].addr] and 96) shr 5;
        ModbusConf.delay:=ConfData.buf[MainSet[i].addr] and 7;
      end;
    end;
  end;PRT.flg_picker:=true;Screen.Cursor:=crDefault;MainForm.CloseAllWnd;
end;
//---------------------------------------------------//

procedure TMainForm.Timer1Timer(Sender: TObject);
var s:string;i,j,n,size:byte;prl:longword;val:single;rect:TRect;
    values:array of single;
    flg:boolean;
label M;
begin {��������� ������, ���������� �� �����������}
  Timer1.Enabled:=false;rpt_tmr:=rpt_tmr+1;
  {���������� ����� �� ������� ������� ������ }
  now_time:=Now;now_time:=now_time-start_time;
  if rpt_tmr > cnt_interv then
  begin
    rpt_com:=rpt_com +1;StatusBar.Panels.Items[3].Text:=IntToStr(rpt_tmr);rpt_tmr:=0;
    {s:='';for i:=0 to recive[6]-1 do s:=s +IntToStr(recive[i])+' ';
     ShowMessage('�����: '+s);ShowMessage(IntToStr(cnt_recive));}
    if rpt_com > s_byte[5] then
    begin rpt_com:=0;rpt_tmr:=0;flg_err:=1;Goto M;end;PRT.cnt_err:=PRT.cnt_err+1;
    if cnt_recive=0 then
    list_err.Add('������ ����-����: '+ GetNameFunction(send[5])) else
    list_err.Add('���� ��������: '+ GetNameFunction(send[5]));
    //s:='';for i:=0 to cnt_send do s:=s +IntToStr(send[i])+' ';ShowMessage('������: '+s);
    SendToDevice;Exit;
  end;ReadFromDevice;
  if PRT.flg_reciv then
  begin
    PRT.cnt_intv:=rpt_tmr;rpt_tmr:=0;rpt_com:=0;
    if flg_err=5 then begin PRT.cnt_err:=PRT.cnt_err+1;flg_err:=0;s:='';for i:=0 to cnt_send do s:=s +IntToStr(send[i])+' ';ShowMessage('������ �� ���: '+s);SendToDevice;Exit;end;{������ �� ������ ������������ ���� }
    if recive[5]=254 then flg_err:=4;
    if recive[5]=255 then flg_err:=3;if flg_err<>0 then Goto M;
    if PRT.pool<>recive[5] then begin SendToDevice;Exit;end;{������ �� ������������ ������� � ������}
    case recive[5]of
      1:begin  //ShowMessage('������ ���������');
          if PRT.status=twLoadConfig then LoadConfigToDevice;
          if flg_reload then Load.step:=11;
          if PRT.flg_port then
          begin
            //ShowMessage('��������� ����� ��������');
            PRT.flg_port:=false;if Length(ConfData.setwr)>0 then
            for i:=0 to Length(ConfData.setwr)-1 do if (SetPort[i].flag)
            and(recive[7]=MainSet[ConfData.setwr[i].num].num+1) then
            begin
              InitialComport(SetPort[i].baud,SetPort[i].data,SetPort[i].stop,
                             SetPort[i].parity);
              WriteConfigFile(SetPort[i].baud,SetPort[i].data,SetPort[i].stop,
                              SetPort[i].parity,false);
              Break;
            end;for i:=0 to Length(SetPort)-1 do SetPort[i].flag:=false;
          end;
        end;
      2:if PRT.status=twSaveConfig then SaveConfigToFile
        else ReadConfiguration(Sender);
      4:ReadDateTime;
      6:ReadParamVerify;
      8:ReadAllPointers;

      //29.11.2021 YN
      {9:CalibrationMVS;}

      10:ReadEventsAlarms;
      11:CalibrationICP;
      15:Screen.Cursor:=crDefault;
      12:ReadHourDayArchive;

      //29.11.2021 YN
      {16:ReadLargeBlockMVS;}

      17:WriteCodeScript;
      18:ReadSmallBlockMVS;
      19:LoadConfigToDevice;
      20:ReadMonitor;
      //21:ShowMessage('������ ���������');
      22:ReadModulSetup(Sender);
      24:ReadCodeScript;

      //29.11.2021 YN added:
      36:ReadDataABB;
      38:ReadDataFS;

      28:ReadMinuteArchive;
      30:ReadModbusSetup;
      32:ReadAllDescriptors;
    end;Timer3.Enabled:=true;Exit;
  end else begin Timer1.Enabled:=true;Exit;end;
M: Screen.Cursor:=crDefault;
   if (flg_err=1)or(flg_err=2)then
   begin
     MainForm.PCommunic.Visible:=true;MainForm.CloseAllWnd;MainForm.Panel2.Visible:=false;
     EnableStatusMessage;StatusBar.Panels.Items[0].Style:=psText;
     FormConfigurationSettings.Close;MainForm.Width:=640;MainForm.Height:=421;bLink.Enabled:=true;
     for i:=0 to MainMenu.Items.Count-1 do
     MainMenu.Items.Items[i].Visible:=false;cbStatus.Visible:=false;
     MainMenu.Items.Items[0].Visible:=true;ToolBar1.Visible:=false;
     MainMenu.Items.Items[0].Enabled:=true;ComPort.Close;rpt_com:=0;
   end else Timer3.Enabled:=true;
   MessageDlg(strErr[flg_err],mtInformation,[mbOk],0);flg_err:=0;
end;
//---------------------------------------------------//

procedure DisableStatusMessage;
begin
  MainForm.StatusBar.Panels.Items[0].Width:=size_panel;cbStatus.Visible:=true;
  PRT.load_visible:=0;
end;
//---------------------------------------------------//

procedure TMainForm.Timer3Timer(Sender: TObject);
var i,j,flg_res,size:integer; flg:boolean; name_file:string;
label M;
begin
  Timer3.Enabled:=false; StatusBar.Repaint;
  //if flg_cmd<>1 then ShowMessage(IntToStr(flg_cmd));
M:case flg_cmd of
  0:ComPort.Close;
  1:begin {������ ����-����� }
      if PRT.status=twMvs then flg_cmd:=18 else
      if (PRT.status=twMonitor)or(PRT.status=twDispExp) then flg_cmd:=20 else
      if PRT.status=twIcp then flg_cmd:=22;
      if PRT.status=twModbusStatus then flg_cmd:=30;Timer3.Interval:=800;
      PRT.pool:=4;PrepareSend(4);
    end;
  2:begin PRT.pool:=2;PrepareSend(2);flg_cmd:=1;end;{������ ������������ }
  3:begin {��������� ������������ �����������  }
      PRT.pool:=1;PrepareSend(1);
      if PRT.status=twIcp then flg_cmd:=22 else if flg_reload then flg_cmd:=32
      else flg_cmd:=2;
    end;
  4:begin PRT.pool:=3;PrepareSend(3);flg_cmd:=2;end;{������ ����-����� � ���������� }
  5:begin PRT.pool:=5;PrepareSend(5);flg_cmd:=6;end;{������ �������� ��� ������� }
  6:begin PRT.pool:=6;PrepareSend(6);flg_cmd:=1;end;{������ ������ �������  }
  7:begin PRT.pool:=7;PrepareSend(7);flg_cmd:=16;end;{��������� ������,����,��.MVS  }
  8:begin {������ ���������� ������� � ������� �� ������ �������  }
      case PRT.status of
        twHour,twDay,twUser:flg_cmd:=12;twMin:flg_cmd:=28;
        twAlarm,twEvent,twNst:flg_cmd:=10;
      end;PrepareSend(8);PRT.pool:=8;
    end;
  9:begin Timer3.Interval:=10000;flg_cmd:=16;PrepareSend(9);PRT.pool:=9;end;{������.MVS }
  10:begin {������ �� 60 ������� �� ������ �������}
       if (Pntr.cnt_event>=60)or(PRT.flg_end) then
       begin
         flg_cmd:=1;
         if PRT.flg_end then bStep.Enabled:=false else bStep.Enabled:=true;
         DisableStatusMessage;Goto M;
       end else Timer3.Interval:=50;PrepareSend(10);PRT.pool:=10;
     end;
  11:begin flg_cmd:=22;PRT.pool:=11;PrepareSend(11);end;{������ � ������  }
  12:begin {������ ��������� ������,������ �������� ������ }
       if (Pntr.cnt_arch>=60)or(PRT.flg_end) then
       begin
         flg_cmd:=1;
         if PRT.flg_end then bStep.Enabled:=false else bStep.Enabled:=true;
         DisableStatusMessage;Goto M;
       end else begin Timer3.Interval:=50;PRT.pool:=12;PrepareSend(12);end;
    end;
  15:begin flg_cmd:=1;PRT.pool:=15;PrepareSend(15);end;{������� ���������}

  //29.11.2021 YN Commented
  {16:begin {������ ������� ���� ������ MVS}
  {     flg_cmd:=18;Timer3.Interval:=800;FormEcoSonicSetting.pMessg.Visible:=false;
       FormEcoSonicSetting.Enabled:=true;PRT.pool:=16;PrepareSend(16);
     end;}

  17:begin  {������ �������}
       if Load.flg_end then
       begin Screen.Cursor:=crDefault;flg_cmd:=1;Goto M;end else
       begin Timer3.Interval:=100;PRT.pool:=17;PrepareSend(17);end;
     end;
  18:begin flg_cmd:=1;PRT.pool:=18;PrepareSend(18);end;{������ ������������ ��������� MVS}
  19:
  if conf_page<8 then
  begin
    if clListConf.Checked[conf_page]=false then
    begin conf_page:=conf_page+1;Goto M;end;
    if (PRT.flg_first=false)and(conf_page=7)then PRT.addr_buf:=1;PRT.pool:=1; 
    PrepareSend(1);
  end else
  begin
    Screen.Cursor:=crDefault;PRT.status:=twNone;DisableStatusMessage;
    for i:=1 to MainMenu.Items.Count-1 do MainMenu.Items.Items[i].Enabled:=true;
    flg_cmd:=1;Goto M;
  end;
  20:
  begin
    if PRT.status=twMonitor then
    begin
      if Load.step>3 then {������ ������� ���������� ����� �����}
      begin flg_cmd:=1;Load.step:=0;Goto M;end else
      begin PRT.pool:=20;PrepareSend(20);end;
    end else
    if PRT.status=twDispExp then
    begin
      flg_cmd:=1;Load.step:=4;PRT.pool:=20;PrepareSend(20);
    end else begin flg_cmd:=1;Goto M;end;
  end;
  21:begin flg_cmd:=30;PRT.pool:=21;PrepareSend(21);end;{������ � Modbus}
  22:begin flg_cmd:=1;PRT.pool:=22;PrepareSend(22);end;{������ ������ � ������ ������}
  24:begin {������ ��� �������}
       if Load.flg_end then
       begin Screen.Cursor:=crDefault;flg_cmd:=1;Goto M;end else
       begin Timer3.Interval:=100;PRT.pool:=24;PrepareSend(24);end;
     end;
  26:if conf_page<8 then begin PRT.pool:=2;PrepareSend(2);end else
     begin {������ ������������ ����� �������� }
       SaveDialog1.FilterIndex:=2;SaveDialog1.DefaultExt:='ccf';
       Screen.Cursor:=crDefault;PRT.status:=twNone;DisableStatusMessage;
       if SaveDialog1.Execute then
       begin
         name_file:=SaveDialog1.FileName; AssignFile(f_config,name_file);{$I-}
         Reset(f_config);{$I+} flg_res:=IOResult;
         if flg_res<>0 then Rewrite(f_config);
         for i:=0 to Length(Main_config)-1 do for j:=0 to Length(Main_config[i])-1 do
         Write(f_config,Main_config[i,j]);CloseFile(f_config);
       end;for i:=1 to MainMenu.Items.Count-1 do
       MainMenu.Items.Items[i].Enabled:=true;flg_cmd:=1;Goto M;
     end;
  28:begin {������ ��������� ������ }
       if Pntr.cnt_arch>=60 then
       begin
         flg_cmd:=1;DisableStatusMessage;Goto M;
       end else Timer3.Interval:=50;PRT.pool:=28;PrepareSend(28);
     end;
  30:begin {������ ������ Modbus ��� Hart}
       PrepareSend(30);PRT.pool:=30;flg_cmd:=1;
     end;
  32:begin {������ ������������ ������������}
       if (Load.step>14)or((Load.step>13)and(flg_reload)) then
       begin
         flg_reload:=false;flg_cmd:=2;DisableStatusMessage;Goto M;
       end else
       begin PRT.pool:=32;Timer3.Interval:=200;PrepareSend(32);end;
     end;

  //29.11.2021 YN added:
  36:begin PRT.pool:=36;PrepareSend(36);flg_cmd:=1;end;{������ ������ �� EcoSonic}

  33:begin {����� ������� ������� MVS}
       if PRT.status=twMvs then flg_cmd:=16;
       if PRT.status=twIcp then  begin flg_cmd:=22;PRT.flg_first:=true;end;
       PRT.pool:=33;PrepareSend(33);
      end;

  //29.11.2021 YN added:
  38:begin PRT.pool:=38;PrepareSend(38);flg_cmd:=1;end;{������ ������ � �������� �������}

  34:begin {�������� ���� ���������� �������, �������, �������}
       case PRT.load_update of
         0:begin flg_cmd:=1;Goto M;end;
         1:begin Timer3.Interval:=50;PrepareSend(8);PRT.pool:=8;end;
         2:
         if PRT.flg_end then {�������� ������ ��������,���������� � �����}
         begin
           if Length(buff_archive) > 0 then
           begin
             //ShowMessage('����� ����� �������:'+IntToStr(Length(buff_archive)));
             AssignFile(f_arc,namea);{$I-} Reset(f_arc); {$I+} flg_res:=IOResult;
             if flg_res<>0 then Rewrite(f_arc);size:=FileSize(f_arc);
             for i:=0 to Length(buff_archive)-1 do
             begin
               d_arc:=buff_archive[Length(buff_archive)-1-i];
               Seek(f_arc,size);Write(f_arc,d_arc);size:=FileSize(f_arc);
             end; CloseFile(f_arc);
             AssignFile(f_conf,Fname);{$I-}Reset(f_conf);{$I+} flg_res:=IOResult;
             if flg_res=0 then
             begin
               d_conf.c_byte[12]:=Newest.page;
               d_conf.c_byte[13]:=Hi(Newest.archive);
               d_conf.c_byte[14]:=Lo(Newest.archive);Write(f_conf,d_conf);
               CloseFile(f_conf);Older.page:=Newest.page;
               Older.archive:=Newest.archive;
             end;
           end;
           if Pntr.event<>Older.event then
           begin
             ReadLestEventRecord(namet);
             Pntr.event:=Pntr.event-1;PRT.load_update:=3;PRT.flg_end:=false;
             SetLength(buff_event,0);Pntr.cnt_event:=0;PRT.pool:=10;
             PrepareSend(10);
           end else if Pntr.alarm<>Older.alarm then
           begin
             ReadLestEventRecord(namer);
             Pntr.event:=Pntr.alarm-1;PRT.load_update:=4;PRT.flg_end:=false;
             SetLength(buff_event,0);PRT.pool:=10;PrepareSend(10);
           end else
           begin PRT.load_update:=0;TerminateLoad;Timer3.Interval:=800;Goto M;end;
         end else begin Timer3.Interval:=50;PRT.pool:=12;PrepareSend(12);end;
         3:
         if PRT.flg_end then {�������� ������� ��������,���������� � �����}
         begin
           if Length(buff_event) > 0 then
           begin
             //ShowMessage('����� ����� �������:'+IntToStr(Length(buff_event)));
             AssignFile(f_event,namet);{$I-}Reset(f_event);{$I+}flg_res:=IOResult;
             if flg_res<>0 then Rewrite(f_event);size:=FileSize(f_event);
             for i:=0 to Length(buff_event)-1 do
             begin
               d_event:=buff_event[Length(buff_event)-1-i];
               Seek(f_event,size);Write(f_event,d_event);size:=FileSize(f_event);
             end; CloseFile(f_event);
             AssignFile(f_conf,Fname);{$I-}Reset(f_conf);{$I+} flg_res:=IOResult;
             if flg_res=0 then
             begin
               d_conf.c_byte[15]:=Hi(Newest.event);
               d_conf.c_byte[16]:=Lo(Newest.event);Write(f_conf,d_conf);
               CloseFile(f_conf);Older.event:=Newest.event;
             end;
           end;
           if Pntr.alarm<>Older.alarm then
           begin
             ReadLestEventRecord(namer);
             Pntr.event:=Pntr.alarm-1;PRT.load_update:=4;PRT.flg_end:=false;
             SetLength(buff_event,0);PRT.pool:=10;Pntr.cnt_event:=0;
             PrepareSend(10);
           end else
           begin PRT.load_update:=0;TerminateLoad;Timer3.Interval:=800;Goto M;end;
         end else begin Timer3.Interval:=50;PRT.pool:=10;PrepareSend(10);end;
         4:
         if PRT.flg_end then {�������� ������� ��������,���������� � �����}
         begin
           if Length(buff_event) > 0 then
           begin
             //ShowMessage('����� ����� �������:'+IntToStr(Length(buff_event)));
             AssignFile(f_event,namer);{$I-}Reset(f_event);{$I+}flg_res:=IOResult;
             if flg_res<>0 then Rewrite(f_event);size:=FileSize(f_event);
             for i:=0 to Length(buff_event)-1 do
             begin
               d_event:=buff_event[Length(buff_event)-1-i];
               Seek(f_event,size);Write(f_event,d_event);size:=FileSize(f_event);
             end; CloseFile(f_event);
             AssignFile(f_conf,Fname);{$I-}Reset(f_conf);{$I+} flg_res:=IOResult;
             if flg_res=0 then
             begin
               d_conf.c_byte[17]:=Hi(Newest.alarm);
               d_conf.c_byte[18]:=Lo(Newest.alarm);Write(f_conf,d_conf);
               CloseFile(f_conf);Older.alarm:=Newest.alarm;
             end; PRT.load_update:=0;TerminateLoad;Timer3.Interval:=800;Goto M;
           end;
         end else begin Timer3.Interval:=50;PRT.pool:=10;PrepareSend(10);end;
       end;
     end;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.aLoadConfigExecute(Sender: TObject);
begin
  FormConfigurationSettings.Visible:=true;MainForm.Enabled:=false;flg_set_conf:=true;
  Screen.Cursor:=crHourGlass;flg_cmd:=2;
end;
//---------------------------------------------------//

procedure TMainForm.aEventsExecute(Sender: TObject);
begin  LoadArchive('������ ������������ �����������',3);end;
//---------------------------------------------------//

procedure TMainForm.EnableStatusMessage;
begin
  StatusBar.Panels.Items[0].Width:=Width;cbStatus.Visible:=false;
end;
//---------------------------------------------------//

procedure TMainForm.LoadArchive(name_arch:string;typ:byte);
begin {��������� ������� �������� ������� ��� ��������}
  FormForVariablesView.Caption:=name_arch;CloseAllWnd;PRT.flg_first:=true;
  PRT.load_visible:=typ+1;PRT.flg_end:=false;EnableStatusMessage;
  case typ of
    0:begin PRT.status:=twHour;bStep.Visible:=true;end;
    1:begin PRT.status:=twDay;bStep.Visible:=true;end;
    2:begin PRT.status:=twMin;bStep.Visible:=false;end;
    3:begin PRT.status:=twEvent;bStep.Visible:=true;end;
    4:begin PRT.status:=twAlarm;bStep.Visible:=true;end;
    5:begin PRT.status:=twNst;bStep.Visible:=true;end;
    6:begin PRT.status:=twUser;bStep.Visible:=true;end;
  end;Screen.Cursor:=crHourGlass;flg_cmd:=8;
end;
//---------------------------------------------------//

procedure TMainForm.N7Click(Sender: TObject);
begin LoadArchive('�������� ����� �����������',1);end;
//---------------------------------------------------//

procedure TMainForm.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var s:string;
begin
  if Panel=StatusBar.Panels[0] then
  begin
    if PRT.load_visible<>0 then
    begin
      StatusBar.Canvas.Brush.Color:=clSilver;
      StatusBar.Canvas.Font.Color:=clBlue;StatusBar.Canvas.Font.Style:=[];
      StatusBar.Canvas.FillRect(Rect);s:=sbarc[PRT.load_visible];
      if(PRT.load_visible=7)or(PRT.load_visible=11)then s:=s+IntToStr(Load.step);
      if(PRT.load_visible=9)or(PRT.load_visible=10)then s:=s+IntToStr(conf_page);
      StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,s);
    end else
    begin
      StatusBar.Canvas.Font.Color:=clBlack;StatusBar.Canvas.Font.Style:=[];
      StatusBar.Canvas.Brush.Color:=$00A9C497;StatusBar.Canvas.FillRect(Rect);
      StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,'  '+DateTimeToStr(crDT));
    end;
  end;
  if Panel=StatusBar.Panels[1] then
  begin
    cbStatus.Left:=StatusBar.Left+Rect.Left-2;
    cbStatus.Top:=StatusBar.Top+Rect.Top-2;
  end;
  if Panel=StatusBar.Panels[2] then
  begin
    StatusBar.Canvas.Font.Color:=clBlack;StatusBar.Canvas.Font.Style:=[];
    StatusBar.Canvas.Brush.Color:=$00D4C4A9;StatusBar.Canvas.FillRect(Rect);
    StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,'  '+TimeToStr(now_time));
  end;
  if Panel=StatusBar.Panels[3] then
  begin
    StatusBar.Canvas.Font.Color:=clBlack;StatusBar.Canvas.Brush.Color:=clYellow;
    StatusBar.Canvas.FillRect(Rect);StatusBar.Canvas.Font.Style:=[];
    StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,IntToStr(PRT.cnt_intv));
  end;
  if Panel=StatusBar.Panels[4] then
  begin
    StatusBar.Canvas.Font.Color:=clBlack;StatusBar.Canvas.Brush.Color:=clAqua;
    StatusBar.Canvas.FillRect(Rect);StatusBar.Canvas.Font.Style:=[];
    StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,'['+IntToStr(PRT.cnt_pool)+']'+
            '['+IntToStr(PRT.cnt_err)+']');
  end;
  if Panel=StatusBar.Panels[5] then
  begin
    StatusBar.Canvas.Font.Color:=clBlack;StatusBar.Canvas.Brush.Color:=clLime;
    StatusBar.Canvas.FillRect(Rect);StatusBar.Canvas.Font.Style:=[];
    if cbSelLink.ItemIndex<>2 then s:='On Line: '+ComPort.DeviceName else
    s:=cbSelModem.Items.Strings[cbSelModem.ItemIndex];
    StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,s);
  end;
end;
//---------------------------------------------------//

procedure TMainForm.EAdrDevDblClick(Sender: TObject);
begin
  EAdrDev.Color:=clBlack;EAdrDev.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.EPasswProgDblClick(Sender: TObject);
begin
  EPasswProg.Color:=clBlack;EPasswProg.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.EPasswDevDblClick(Sender: TObject);
begin
  EPasswDev.Color:=clBlack;EPasswDev.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.EDelayDblClick(Sender: TObject);
begin
  EDelay.Color:=clBlack;EDelay.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.ETimeOutDblClick(Sender: TObject);
begin
  ETimeOut.Color:=clBlack;ETimeOut.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.ERetryCntDblClick(Sender: TObject);
begin
  ERetryCnt.Color:=clBlack;ERetryCnt.Font.Color:=clWhite;
  BSave.Enabled:=true;flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.cbSelModemChange(Sender: TObject);
const sub_name:array[0..3] of PChar=('Compression_Off','ErrorControl_Off',
                                     'FlowControl_Off','Modulation_Bell');
var res:integer;i,cmd_nmb:byte;key_value:Pointer;valtype,number:longword;
begin
  eAT.Text:='';
  res:=RegOpenKeyEx(key_reg_mdm[CBSelModem.ItemIndex],
                              'Settings',0,KEY_READ,key_mdm);
  if res<>ERROR_SUCCESS then
  begin
    ShowMessage('������ ��� ������ � ��������� �����������!');Exit;
  end;
  if chLine.Checked=true then cmd_nmb:=3 else cmd_nmb:=2;
  for i:=0 to cmd_nmb do
  begin
    number:=100;GetMem(key_value,number);
    res:=RegQueryValueEx(key_mdm,sub_name[i],nil,@valtype,key_value,@number);
    if res=ERROR_SUCCESS then eAT.Text:=eAT.Text+PChar(key_value);
  end;RegCloseKey(key_mdm);
  for i:=0 to CBNamePort.Items.Count-1 do
  if CBNamePort.Items.Strings[i]=Trim(mdm_comport[CBSelModem.ItemIndex])
    then begin CBNamePort.ItemIndex:=i;CBNamePort.Enabled:=false;Break;end;
  flg_save:=true;
end;
//---------------------------------------------------//

procedure TMainForm.chToneClick(Sender: TObject);
begin bSave.Enabled:=true;end;
//---------------------------------------------------//

procedure TMainForm.N10Click(Sender: TObject);
var flg_res,i:integer;
begin
  CloseAllWnd; PRT.load_visible:=9; EnableStatusMessage;
  for i:=1 to MainMenu.Items.Count-1 do MainMenu.Items.Items[i].Enabled:=false;
  Screen.Cursor:=crHourGlass; conf_page:=0; PRT.status:=twSaveConfig; flg_cmd:=26;
end;
//---------------------------------------------------//

procedure TMainForm.N11Click(Sender: TObject);
var flg_res,i,k:integer;s,name_file:string;j:byte;
begin
  OpenDialog1.FilterIndex:=2;
  if OpenDialog1.Execute then
  begin
    name_file:=OpenDialog1.FileName;
    AssignFile(f_config,name_file);{$I-}Reset(f_config);{$I+} flg_res:=IOResult;
    if flg_res<>0 then
    begin ShowMessage('��������� ���� �� ������!');Exit;end;
    for i:=0 to Length(Main_config)-1 do for j:=0 to Length(Main_config[i])-1 do
      if Eof(f_config)=false then Read(f_config,Main_config[i,j]);
    CloseFile(f_config);
    //s:='';for i:=0 to Length(conf_calc)-1 do for j:=0 to Length(conf_calc[i])-1 do s:=s+IntToStr(conf_calc[i,j])+' ';
   // ShowMessage(s);
   // if Main_config[7,0]<>Typ_task then
   // begin
   //   ShowMessage(IntToStr(Main_config[7,0]));  ShowMessage(IntToStr(Typ_task));
    //  ShowMessage('������������: '+str_status[Main_config[7,0]]+
    //              ' �� ������������� ��������!');Exit;
    //end;
    for i:=1 to MainMenu.Items.Count-1 do MainMenu.Items.Items[i].Enabled:=false;
    for i:=0 to clListConf.Items.Count-1 do clListConf.Checked[i]:=false;
    pSelPageConf.Visible:=true;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.BitBtn2Click(Sender: TObject);
var i:integer;
begin
  pSelPageConf.Visible:=false;
  for i:=1 to MainMenu.Items.Count-1 do MainMenu.Items.Items[i].Enabled:=true;
end;
//---------------------------------------------------//

procedure TMainForm.BitBtn1Click(Sender: TObject);
var i:integer;flag:boolean;
label M;
begin
  flag:=false;if clListConf.Checked[5] then clListConf.Checked[5]:=false;
  for i:=0 to clListConf.Items.Count-1 do if clListConf.Checked[i] then
  begin flag:=true;Break;end;
  if flag then
  begin
    if MessageDlg('��������!������� ������������ ��������� �������'
       +Char(13)+'����� ��������! �� ������������� ������ ��������� �����?',
       mtConfirmation,[mbNo,mbYes],0)=mrNo then Goto M;
  end else Goto M;
  PRT.load_visible:=10; EnableStatusMessage;
  pSelPageConf.Visible:=false; Screen.Cursor:=crHourGlass;
  PRT.status:=twLoadConfig; conf_page:=0; PRT.flg_first:=false;
  PRT.addr_buf:=0; PRT.num_prm:=0; flg_cmd:=19; Exit;
  M:pSelPageConf.Visible:=false;for i:=1 to MainMenu.Items.Count-1 do
    MainMenu.Items.Items[i].Enabled:=true;
end;
//---------------------------------------------------//

procedure TMainForm.N12Click(Sender: TObject);
begin LoadArchive('�������� ����� �����������',2);end;
//---------------------------------------------------//

procedure TMainForm.aAlarmsExecute(Sender: TObject);
begin LoadArchive('������ ������� �����������',4);end;
//---------------------------------------------------//

procedure TMainForm.tmModemTimer(Sender: TObject);
const str_mdm:array[2..6] of string[60]=('������������ ��-������� ��� ������ ������!',
     '����������� ������� ������ ���,����� �����!','� �������� ����������� �����!',
     '������� �����, ������� ������!',
     '������������� ����� �������� �� ������� ���������� �������!');
     str_err:array[4..6] of string[70]=('����� ���������� ��� �����������!',
     '�� �������� ���������� ����� ��������!',
     '������ ���������� �����! ����������� ���������� ����������!');
label M;
begin
  tmModem.Enabled:=false;
  rpt_mdm_tmr:=rpt_mdm_tmr+1;if rpt_mdm_tmr>=5 then begin fl_err:=4;Goto M end;
  AnsFromDev;if fl_rsv=false then begin tmModem.Enabled:=true;Exit;end;
  rpt_mdm_tmr:=0;if fl_ans>1 then Goto M;
  case flg_modem of
    0:begin s_at:=strAT[1];flg_modem:=1;fl_rsv:=false;SendStrToDev;end;
    1:begin
        eStatus.Text:=Trim(mdm_name);eStatus.Color:=clRed;fl_rsv:=false;
        if eAT.Text<>'' then
        begin
          s_at:='AT'+eAT.Text;flg_modem:=2;SendStrToDev;
        end else begin flg_modem:=2;Goto M;end;
      end;
    2:if ePhoneNumber.Text<>'' then
      begin
          flg_modem:=3;
          if chTone.Checked=true then s_at:='ATDT'+ePhoneNumber.Text
          else s_at:='ATDP'+ePhoneNumber.Text;
          tmModem.Interval:=20000;SendStrToDev;
      end else begin fl_err:=5;Goto M end;
    3:begin
        if fl_ans<>1 then begin tmModem.Enabled:=true;Exit;end;
        start_time:=Now; flg_cmd:=32; Load.step:=0; Load.addr:=0;
        Load.flg_end:=false; Timer3.Interval:=100; Timer3.Enabled:=true;
      end;
    end;Exit;
M:if fl_ans<>0 then MessageDlg(str_mdm[fl_ans],mtError,[mbOK],0);
  if fl_err>=4 then MessageDlg(str_err[fl_err],mtError,[mbOK],0);
end;
//---------------------------------------------------//

procedure TMainForm.cbBaudChange(Sender: TObject);
begin BSave.Enabled:=true;flg_save:=true;end;
//---------------------------------------------------//

procedure TMainForm.aNstExecute(Sender: TObject);
begin LoadArchive('������ ��������� �������� �����������',5);end;
//---------------------------------------------------//

procedure TMainForm.LoadInterface(name_arch:string;typ:byte);
begin {��������� ������� �������� ������� ��� ��������}
  FormModbusSetting.Caption:=name_arch;CloseAllWnd;PRT.flg_first:=true;
  case typ of
    0:begin
        ModbusConf.select:=2;
        if FormModbusSetting.GetEnableModbusFunc(ModbusConf.select)=false then Exit;
        PRT.status:=twModbusFunc;
      end;
    1:begin
        ModbusConf.select:=0;
        if(ModbusConf.mode=1)or(FormModbusSetting.GetEnableModbusHost=false)then Exit;
        PRT.status:=twModbusHost;
      end;
    2:Prt.status:=twModbusScale;
    3:Prt.status:=twModbusStatus;
  end;flg_cmd:=30;
end;
//---------------------------------------------------//

procedure TMainForm.N18Click(Sender: TObject);
begin LoadInterface('����� �������������� Modbus',2);end;
//---------------------------------------------------//

procedure TMainForm.N22Click(Sender: TObject);
begin
  FormForScript.ViewNewTable;FormForScript.Caption:='����� ������';FormForScript.Visible:=true;
end;
//---------------------------------------------------//

procedure TMainForm.N26Click(Sender: TObject);
begin
  CloseAllWnd;PRT.flg_first:=true;Screen.Cursor:=crHourGlass;
  PRT.status:=twDispExp;flg_cmd:=20;
end;
//---------------------------------------------------//

procedure TMainForm.N24Click(Sender: TObject);
var i,flg_res,k:integer; name_file:string;
begin
  with MainForm do
  begin
    OpenDialog1.Title:='������� ��� ����� �������';
    OpenDialog1.FilterIndex:=3;OpenDialog1.DefaultExt:='csf';
    if OpenDialog1.Execute then
    begin
      name_file:=OpenDialog1.FileName; AssignFile(f_script,name_file);{$I-}
      Reset(f_script);{$I+} flg_res:=IOResult;
      if flg_res<>0 then
      begin ShowMessage('��������� ���� �� ������!');Exit;end;k:=0;
      FormForScript.ViewNewTable; FormForScript.Caption:='C����� �� �����';
      SetLength(ScriptLabel,0); SetLength(EnableLabel,0);
      while Eof(f_script)=false do with d_script do
      begin
        Read(f_script,d_script);SetLength(ScriptData,k+1);
        ScriptData[k].op_code:=op_code; ScriptData[k].pnt:=pnt;
        ScriptData[k].param:=param; ScriptData[k].num:=num;
        ScriptData[k].value:=value; ScriptData[k].transit:=transit;
       { ShowMessage(IntToStr(op_code)+' '+IntToStr(pnt)+' '+
         IntToStr(param)+' '+IntToStr(num)+' '+
         FloatToStr(value)+' '+IntToStr(transit));}
        k:=k+1;

      end;CloseFile(f_script); FormForScript.Visible:=true; FormForScript.ReadScript;
    end;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.aMonitorExecute(Sender: TObject);
begin
  CloseAllWnd;PRT.flg_first:=true;
  Screen.Cursor:=crHourGlass;PRT.status:=twMonitor;Load.step:=0;flg_cmd:=20;
end;
//---------------------------------------------------//

procedure TMainForm.aHourArchExecute(Sender: TObject);
begin LoadArchive('������� ����� �����������',0);end;
//---------------------------------------------------//

procedure TMainForm.aICPmoduleExecute(Sender: TObject);
begin
  CloseAllWnd;with FormIOModulesSetting do
  begin
    Top:=MainForm.Top+105; Left:=MainForm.Left+35; cbInputType.Clear;
    cbDataType.Clear;FormStyle:=fsStayOnTop; Visible:=true; PRT.flg_first:=true;
    sgTable.Visible:=false;
  end;PRT.status:=twIcp; Screen.Cursor:=crHourGlass; flg_cmd:=22;
end;
//---------------------------------------------------//

procedure TMainForm.aMVS205Execute(Sender: TObject);
const stc:array[1..3]of string[15]=('�������','��������','�����������');
      str:array[0..10]of string[20]=('����� ����������','������ �������',
          '������� ������','������� ������','������� ������','������� �������',
          '���������� �������','������ ������� ���','������� ������� ���',
          '���������� �������','������ �������');
var i:integer;
begin

  //29.11.2021 YN was:
  {CloseAllWnd;FormEcoSonicSetting.Top:=MainForm.Top+105;
  FormEcoSonicSetting.Left:=MainForm.Left+75;FormEcoSonicSetting.sgTable.ColWidths[0]:=115;
  for i:=1 to FormEcoSonicSetting.sgTable.ColCount-1 do
    FormEcoSonicSetting.sgTable.Cells[i,0]:=stc[i];FormEcoSonicSetting.FormStyle:=fsStayOnTop;
  for i:=0 to FormEcoSonicSetting.sgTable.RowCount-1 do
    FormEcoSonicSetting.sgTable.Cells[0,i]:=str[i];FormEcoSonicSetting.Visible:=true;
  Screen.Cursor:=crHourGlass;PRT.status:=twMvs;flg_cmd:=16;}
  //now:
  CloseAllWnd;FormEcoSonicSetting.Top:=MainForm.Top+105;
  FormEcoSonicSetting.Left:=MainForm.Left+75;
  FormEcoSonicSetting.Visible:=true;
  Screen.Cursor:=crHourGlass;PRT.status:=twMvs; FormEcoSonicSetting.tcPageMVS.Visible:=true;
  FormEcoSonicSetting.pFs.Visible:=false;
  flg_cmd:=36; FormEcoSonicSetting.pABB.Visible:=true;

end;
//---------------------------------------------------//

procedure TMainForm.aMbfuncExecute(Sender: TObject);
begin LoadInterface('������� ������� Modbus',0);end;
//---------------------------------------------------//

procedure TMainForm.aMbhostExecute(Sender: TObject);
begin LoadInterface('������� �������� Modbus',1);end;
//---------------------------------------------------//

procedure TMainForm.aLoadScriptExecute(Sender: TObject);
begin
  FormForScript.Caption:='������ �� ����������� (���)';
  CloseAllWnd;PRT.flg_first:=true;PRT.status:=twScript;flg_cmd:=24;
  Load.addr:=0;Load.step:=0;Load.flg_end:=false;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TMainForm.N27Click(Sender: TObject);
begin LoadArchive('���������������� ����� �����������',6);end;
//---------------------------------------------------//

procedure TMainForm.N19Click(Sender: TObject);
begin LoadInterface('������� �������� Modbus',3);end;
//---------------------------------------------------//

procedure TMainForm.N29Click(Sender: TObject);
begin {������ ��������� ������� � ��������}
  PRT.load_update:=1;PRT.load_visible:=8;PRT.flg_end:=false;
  StatusBar.Panels.Items[0].Width:=MainForm.Width;cbStatus.Visible:=false;
  flg_cmd:=34;Screen.Cursor:=crHourGlass;
end;
//---------------------------------------------------//

procedure TMainForm.N30Click(Sender: TObject);
var i,j,index:integer;
begin
  MainForm.CloseAllWnd;
  FormForReports.rgArchType.ItemIndex:=0;FormForReports.Top:=MainForm.Top+75;FormForReports.Left:=MainForm.Left+8;
  FormForReports.clParamList.Clear;SetLength(units_report,0);
  if Length(Arch)>0 then
    for i:=0 to Length(Arch)-1 do
    case Arch[i].pnt of
      1:
        for j:=0 to Length(ArchBasicSet)-1 do
          if Arch[i].num=ArchBasicSet[j].addr then
            begin
              if ArchBasicSet[j].name<Length(dyn_all)then
                begin
                  index:=FormForReports.clParamList.Items.Add(dyn_all[ArchBasicSet[j].name]);
                  SetLength(units_report,Length(units_report)+1);
                end;
              if (Arch[i].offset=4)or(Arch[i].offset=6)then
                FormForReports.clParamList.Items.Strings[index]:=
                  FormForReports.clParamList.Items.Strings[index]+name_expand[Arch[i].offset];
              FormForReports.clParamList.Items.Strings[index]:=
              FormForReports.clParamList.Items.Strings[index]+pnt_str[Arch[i].logn];
              if ArchBasicSet[j].units<Length(units_all_bis) then
                units_report[index]:=units_all_bis[ArchBasicSet[j].units];
              PRT.number_arc:=PRT.number_arc+1;
              Break;
            end;
      2:
        for j:=0 to Length(ArchExpandSet)-1 do
          if Arch[i].num=ArchExpandSet[j].addr then
            begin
              if ArchExpandSet[j].name<Length(dyn_all)then
              begin
                index:=FormForReports.clParamList.Items.Add(dyn_all[ArchExpandSet[j].name]);
                SetLength(units_report,Length(units_report)+1);
              end;
              if (Arch[i].offset=4)or(Arch[i].offset=6)then
                FormForReports.clParamList.Items.Strings[index]:=
                  FormForReports.clParamList.Items.Strings[index]+name_expand[Arch[i].offset];
              FormForReports.clParamList.Items.Strings[index]:=
              FormForReports.clParamList.Items.Strings[index]+' ���';
              if ArchExpandSet[j].units<Length(units_all_bis) then
                units_report[index]:=units_all_bis[ArchExpandSet[j].units];
              PRT.number_arc:=PRT.number_arc+1;
              Break;
            end;
      end;
  for i:=0 to FormForReports.clParamList.Items.Count-1 do
    if i<7 then
      FormForReports.clParamList.Checked[i]:=true;
  FormForReports.FormStyle:=fsStayOnTop;
  ReadLestArchRecord;
  FormForReports.mcSelect.Date:=Floor(old_rec_arc.a_time);
  FormForReports.ViewArchiveTable;
  FormForReports.Visible:=true;
end;
//---------------------------------------------------//

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var flg_res:integer;
begin
  if flag_list then
  begin
    try
      list_err.SaveToFile('c:\testlink.txt');
    except on EFCreateError do;end;list_err.Free;
  end;
  if flg_config=true then
  begin
    AssignFile(f_conf,Fname);{$I-} Reset(f_conf);{$I+} flg_res:=IOResult;
    if flg_res=0 then
    begin
      d_conf.c_string[2]:=FormForReports.eIdentif.Text;
      Seek(f_conf,0); Write(f_conf,d_conf); CloseFile(f_conf);
    end;
  end;
end;
//---------------------------------------------------//

procedure PrintArchive(max_data,max_col,typ_arc:integer;sgArch:TStringGrid);
const
  st_gl:array[0..1] of string[60]=('�������� ����� ������� ���������� ����',
                                   '�������� ����� ������� ���������� ����');
  st_ed:array[0..1] of string[60]=('�� ����� ������������� �������, �������:  ',
                                   '�� ����� ������������� �������, �������:  ');
var a,b,w_int,x,y,c_int,x_m,str_cnt,grd_cnt,x_d:word;
    h_str,h_fnt,h_int,j,i,pg_cnt,adr_prm:byte;
label M;
begin
  a:=Printer.PageHeight;
  b:=Printer.PageWidth;
  Printer.Orientation:=poPortrait;
  h_str:=Ceil(a/60);
  h_int:=Ceil(h_str*0.1);
  h_fnt:=h_str-2*h_int;
  pg_cnt:=0;
  grd_cnt:=0;
  w_int:=Ceil((b-Ceil(b/5))/3);
  str_cnt:=max_data-1;
  x_d:=Ceil(b/210);
  if (str_cnt>0)and(typ_arc<2) then
  begin
    Printer.BeginDoc;
    with Printer.Canvas do
    begin
M:    Font.Height:=h_str;x:=Ceil(b/5);y:=h_str;
        {������� "�����"}
      TextOut(x,y,st_gl[typ_arc]);
      y:=y+3*h_str;
      x:=Ceil(b/5);
      Font.Height:=h_fnt;
      TextOut(x,y,'�������� �������:                  '+FormForReports.eIdentif.Text);
      y:=y+h_str;
      TextOut(x,y,'���� � ����� ����������:           '+DateTimeToStr(Now));
      y:=y+2*h_str;
      x:=x-Ceil(b/10);
      c_int:=Ceil((b-x-Ceil(b/10))/8);
      x_m:=x+c_int*(max_col+2);
        {������� ���������� �������}
      MoveTo(x,y);
      LineTo(x_m,y);
      for j:=0 to 1 do
      begin
        TextOut(x+h_int,y+(h_str*j)+h_int,sgArch.Cells[0,j]);
        for i:=1 to max_col do
          TextOut(x+c_int*(i+1)+h_int,y+(h_str*j)+h_int,sgArch.Cells[i,j]);
        MoveTo(x,y);
        LineTo(x,y+2*h_str);
        for i:=1 to max_col+1 do
        begin
          MoveTo(x+c_int*(i+1),y);
          LineTo(x+c_int*(i+1),y+2*h_str);
        end;
      end;
      MoveTo(x,y+2*h_str);
      LineTo(x_m,y+2*h_str);{������ ����� ����������}
        {������� �������}
      str_cnt:=str_cnt-48*pg_cnt;
      grd_cnt:=grd_cnt+48*pg_cnt;j:=0;
      repeat
         TextOut(x+h_int,y+(h_str*(j+2))+h_int,sgArch.Cells
                   [0,sgArch.TopRow+j+grd_cnt]);
         for i:=1 to max_col do
          TextOut(x+c_int*(i+1)+h_int,y+(h_str*(j+2))+h_int,sgArch.Cells
                   [i,sgArch.TopRow+j+grd_cnt]);
         MoveTo(x,y+h_str*(j+2));
         LineTo(x,y+h_str*(j+3));
         for i:=1 to max_col+1 do
         begin
           MoveTo(x+c_int*(i+1),y+h_str*(j+2));
           LineTo(x+c_int*(i+1),y+h_str*(j+3));
         end;
         MoveTo(x,y+h_str*(j+3));
         LineTo(x_m,y+h_str*(j+3));
         j:=j+1;
      until (j>=48)or(j>=str_cnt+1)or(j+grd_cnt>=sgArch.RowCount);
    end;
    if (str_cnt+1-j)>0 then
    begin
      pg_cnt:=1;
      Printer.NewPage;
      Goto M
    end;
    with Printer.Canvas do
    begin
      y:=y+h_str*(j+3);
      x:=Ceil(b/5);
      TextOut(x,y,st_ed[typ_arc]+
              FormForReports.lCountEvent.Caption+', '+FormForReports.lCountAlarm.Caption);
    end;
    Printer.EndDoc;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.N32Click(Sender: TObject);
begin
  PrintArchive(max_data,max_col,FormForReports.rgArchType.ItemIndex,FormForReports.sgArchive);
end;
//---------------------------------------------------//

procedure PrintEvents(max_event:integer;sgArch:TStringGrid);
const ind:array[0..4,0..1]of byte=((0,0),(2,1),(4,2),(6,3),(9,4));
      cnt_intv=10; {����� �������������� ����������}
 {������: ������ ������ �������� ���������, ������: ������ ������ �������}
var a,b,w_int,x,y,c_int,x_m,str_cnt,grd_cnt,x_d:word;
    h_str,h_fnt,h_int,j,i,pg_cnt:byte;
label M;
begin  {��������� ���������� ������ �������}
  a:=Printer.PageHeight;b:=Printer.PageWidth;Printer.Orientation:=poPortrait;
  h_str:=Ceil(a/60);h_int:=Ceil(h_str*0.1);h_fnt:=h_str-2*h_int;pg_cnt:=0;
  grd_cnt:=0;w_int:=Ceil((b-Ceil(b/5))/3);str_cnt:=max_event-1;
  x_d:=Ceil(b/210);
  if str_cnt>0 then
  begin
    Printer.BeginDoc;
    with Printer.Canvas do
    begin
M:    Font.Height:=h_str;x:=Ceil(b/4);y:=h_str;
      TextOut(x,y,'���� ����� ���������� ����.');
      y:=y+2*h_str;x:=Ceil(b/5);Font.Height:=h_fnt;
      TextOut(x,y,'���������� � ������, ����: '+IntToStr(Printer.PageNumber));
      y:=y+h_str;
      TextOut(x,y,'������� ������ �������:   '+FormForReports.eIdentif.Text+', '+
                                                    DateTimeToStr(Now));
      y:=y+h_str;x:=x-Ceil(b/10);c_int:=Ceil((b-x-Ceil(b/10))/(cnt_intv-1));
      {������ ��������� ������������ ��������� ������� ���������������}
      x_m:=x+c_int*cnt_intv;MoveTo(x,y);LineTo(x_m,y);
      for i:=0 to Length(ind)-1 do
      begin {����� ���������� �������}
        TextOut(x+c_int*ind[i,0]+h_int,y+h_int,sgArch.Cells[ind[i,1],0]);
        MoveTo(x+c_int*ind[i,0],y);LineTo(x+c_int*ind[i,0],y+h_str);
      end; i:=cnt_intv;
      MoveTo(x+c_int*i,y);LineTo(x+c_int*i,y+h_str);
      MoveTo(x,y+h_str);LineTo(x_m,y+h_str);
      str_cnt:=str_cnt-48*pg_cnt;grd_cnt:=grd_cnt+48*pg_cnt;j:=0;
      repeat {����� ����������� �������}
        for i:=0 to Length(ind)-1 do
        begin
          TextOut(x+c_int*ind[i,0]+h_int,y+(h_str*(j+1))+h_int,
                  sgArch.Cells[ind[i,1],sgArch.TopRow+j+grd_cnt]);
          MoveTo(x+c_int*ind[i,0],y+h_str*(j+1));
          LineTo(x+c_int*ind[i,0],y+h_str*(j+2));
        end; i:=cnt_intv;
        MoveTo(x+c_int*i,y+h_str*(j+1));LineTo(x+c_int*i,y+h_str*(j+2));
        MoveTo(x,y+h_str*(j+2));LineTo(x_m,y+h_str*(j+2));
        j:=j+1;
      until (j>=48)or(j>=str_cnt+1)or(j+grd_cnt>=sgArch.RowCount);
      if (str_cnt+1-j)>0 then begin pg_cnt:=1;Printer.NewPage;Goto M end;
    end; Printer.EndDoc;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.N33Click(Sender: TObject);
begin
  PrintEvents(max_event,FormForReports.sgEvent);
end;
//---------------------------------------------------//

procedure PrintAlarms(max_alarm:integer;sgArch:TStringGrid);
const ind:array[0..3,0..1]of byte=((0,0),(2,1),(4,2),(5,3));
      cnt_intv=8; {����� �������������� ����������}
var a,b,w_int,x,y,c_int,x_m,str_cnt,grd_cnt,x_d:word;
    h_str,h_fnt,h_int,j,i,pg_cnt:byte;
label M;
begin {��������� ���������� ������ �������}
  a:=Printer.PageHeight;b:=Printer.PageWidth;Printer.Orientation:=poPortrait;
  h_str:=Ceil(a/60);h_int:=Ceil(h_str*0.1);h_fnt:=h_str-2*h_int;pg_cnt:=0;
  grd_cnt:=0;w_int:=Ceil((b-Ceil(b/5))/3);str_cnt:=max_alarm-1;
  x_d:=Ceil(b/210);
  if str_cnt>0 then
  begin
    Printer.BeginDoc;
    with Printer.Canvas do
    begin
M:    Font.Height:=h_str;x:=Ceil(b/4);y:=h_str;
      TextOut(x,y,'���� ����� ���������� ����.');
      y:=y+2*h_str;x:=Ceil(b/5);Font.Height:=h_fnt;
      TextOut(x,y,'���������� � ������, ����: '+IntToStr(Printer.PageNumber));
      y:=y+h_str;
      TextOut(x,y,'������� ������ �������:   '+FormForReports.eIdentif.Text+', '+
                                               DateTimeToStr(Now));
      y:=y+h_str;x:=x-Ceil(b/10);c_int:=Ceil((b-x-Ceil(b/10))/cnt_intv);
      x_m:=x+c_int*cnt_intv;MoveTo(x,y);LineTo(x_m,y);
      for i:=0 to Length(ind)-1 do
      begin
        TextOut(x+c_int*ind[i,0]+h_int,y+h_int,sgArch.Cells[ind[i,1],0]);
        MoveTo(x+c_int*ind[i,0],y);LineTo(x+c_int*ind[i,0],y+h_str);
      end; i:=cnt_intv;
      MoveTo(x+c_int*i,y);LineTo(x+c_int*i,y+h_str);
      MoveTo(x,y+h_str);LineTo(x_m,y+h_str);
      str_cnt:=str_cnt-48*pg_cnt;grd_cnt:=grd_cnt+48*pg_cnt;j:=0;
      repeat
        for i:=0 to Length(ind)-1 do
        begin
          TextOut(x+c_int*ind[i,0]+h_int,y+(h_str*(j+1))+h_int,sgArch.Cells
                   [ind[i,1],sgArch.TopRow+j+grd_cnt]);
          MoveTo(x+c_int*ind[i,0],y+h_str*(j+1));
          LineTo(x+c_int*ind[i,0],y+h_str*(j+2));
        end; i:=cnt_intv;
        MoveTo(x+c_int*i,y+h_str*(j+1));LineTo(x+c_int*i,y+h_str*(j+2));
        MoveTo(x,y+h_str*(j+2));LineTo(x_m,y+h_str*(j+2));j:=j+1;
      until (j>=48)or(j>=str_cnt+1)or(j+grd_cnt>=sgArch.RowCount);
      if (str_cnt+1-j)>0 then begin pg_cnt:=1;Printer.NewPage;Goto M end;
    end; Printer.EndDoc;
  end;
end;
//---------------------------------------------------//

procedure TMainForm.N34Click(Sender: TObject);
begin
  PrintAlarms(max_alarm,FormForReports.sgAlarm);
end;
//---------------------------------------------------//

procedure TMainForm.N37Click(Sender: TObject);
begin
  FormArchFromFile.Visible:=true; FormArchFromFile.cbTypeChange(Sender);
end;
//---------------------------------------------------//

procedure TMainForm.N38Click(Sender: TObject);
begin
  FormArchFromFile.sgTable.TopRow:=FormArchFromFile.sgTable.FixedRows;
  case FormArchFromFile.cbTypeTable.ItemIndex of
    0:PrintArchive(max_data,max_col,FormArchFromFile.cbType.ItemIndex,FormArchFromFile.sgTable);
    1:PrintEvents(max_event,FormArchFromFile.sgTable);
    2:PrintAlarms(max_alarm,FormArchFromFile.sgTable);
  end;
end;
//---------------------------------------------------//

end.
