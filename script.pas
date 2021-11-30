unit script;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, ExtCtrls, StdCtrls, Buttons;

type
  TFormForScript = class(TForm)
    pScript: TPanel;
    sgScript: TStringGrid;
    bSaveDev: TBitBtn;
    bSaveFile: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure sgScriptDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure sgScriptSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure bSaveDevClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bSaveFileClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GoSelectExecute(Sender: TObject);
    procedure GoKeyPressExecute(Sender: TObject; var Key: Char);
    procedure GoEditExecute;
  public
    { Public declarations }
    procedure ViewNewTable;
    procedure ReadScript;
  end;

var
  FormForScript: TFormForScript;cbScript:TComboBox;eScript:TEdit;

type TScriptLabel=record
     name:string[10]; val:word; num:byte;
end;

var  ScriptLabel, EnableLabel:array of TScriptLabel;

implementation

{$R *.DFM}
uses Main;

const name_col:array[0..5]of string[18]=('№ записи', 'Метка', 'Команда',
      'Выбор списка', 'Значение/Параметр', 'Переход');

      rec_op:array[0..1]of string[15]=('Вставить', 'Удалить');

      ind_val:array[0..14]of byte=(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,15,16);

      ind_sav:array[0..10]of byte=(1, 2, 3, 4, 5, 13, 14, 15, 16, 17, 18);

      ind_log:array[0..1]of byte=(15, 16);{индексы списков для разных команд}

      ind_func:array[0..12]of byte=(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);

var flag_edit, filter:boolean; top_row, tab_row, tab_col:integer;
    flag_view:TComponentView;
    num_param, num_point:array of byte;

{--\\//---------\\//*****  Procedures and functions  *****\\//-----------\\//--}

procedure CreateListParam(cb:TCombobox;ind:integer;var flag:boolean);
const mvs_prm:array[0..2]of string[15]=('Рабочий расход','Давление','Температура');
      max_chan_ai=8;max_chan_ao=4;max_chan_panel=3;
var i,j,k:integer;s:string;flg_prm:boolean;size:byte;
begin
  flg_prm:=false;
  case ScriptData[ind].pnt of
    0:flag:=false;
    1,2,3,4: {список параметров для базовой }
    begin
      if Length(Dyn)>0 then for i:=0 to Length(Dyn)-1 do
      if Dyn[i].script>0 then
      begin
        if Dyn[i].name<Length(dyn_all)then s:=dyn_all[Dyn[i].name];
        if Typ_task<>6 then size:=Length(name_expand) else
           size:=Length(name_expand_oil);
        if Dyn[i].size<size then if Typ_task<>6 then
        s:=s+name_expand[Dyn[i].size]else s:=s+name_expand_oil[Dyn[i].size];
        cb.Items.Add(s);
        SetLength(num_param,cb.Items.Count);flg_prm:=true;
        num_param[cb.Items.Count-1]:=Dyn[i].addr+Dyn[i].size;
      end;
      if flg_prm then flag:=true else Exit;
    end;
    5: {список параметров для дополнительной }
    begin
      if Length(DynExp)>0 then for i:=0 to Length(DynExp)-1 do
      begin
        if (DynExp[i].name<Length(dyn_all))and(DynExp[i].name>0)then
        s:=dyn_all[DynExp[i].name] else s:=IntToStr(i+1);
        if (DynExp[i].typ=4)or(DynExp[i].typ=5)or(DynExp[i].typ=6) then
        for j:=0 to DynExp[i].size-1 do
        begin
          cb.Items.Add(s+IntToStr(j+1));
          SetLength(num_param,cb.Items.Count);
          num_param[cb.Items.Count-1]:=DynExp[i].addr+j;
        end else
        begin
          cb.Items.Add(s);SetLength(num_param,cb.Items.Count);
          num_param[cb.Items.Count-1]:=DynExp[i].addr;
        end;
      end;flag:=true;
    end;
    6: {список параметров для констант дополнительной }
    begin
      k:=0;
      if Length(ConfSetExp)>0 then for i:=0 to Length(ConfSetExp)-1 do
      if ConfSetExp[i].typ=4 then
      begin
        cb.Items.Add(conf_all[ConfSetExp[i].name]+IntToStr(k+1));
        SetLength(num_param,cb.Items.Count);num_param[cb.Items.Count-1]:=k;
        k:=k+1;
      end;flag:=true;
    end;
    7,8,9,10:{список параметров для многопараметрического датчика }
    begin  
      for i:=0 to Length(mvs_prm)-1 do
      begin
       cb.Items.Add(mvs_prm[i]);SetLength(num_param,cb.Items.Count);
       num_param[cb.Items.Count-1]:=i;
      end;flag:=true;
    end;
    11,12:
    begin
      for i:=0 to max_chan_ai-1 do
      begin
       cb.Items.Add('Канал #'+IntToStr(i+1));SetLength(num_param,cb.Items.Count);
       num_param[cb.Items.Count-1]:=i;
      end;flag:=true;
    end;
    13,14:
    begin
      for i:=0 to max_chan_ao-1 do
      begin
       cb.Items.Add('Канал #'+IntToStr(i+1));SetLength(num_param,cb.Items.Count);
       num_param[cb.Items.Count-1]:=i;
      end;flag:=true;
    end;
    17:
    begin
      for i:=0 to max_chan_panel-1 do
      begin
        cb.Items.Add('Строка #'+IntToStr(i+1));SetLength(num_param,cb.Items.Count);
        num_param[cb.Items.Count-1]:=i;
      end;flag:=true;
    end;
  end;if flag then cb.ItemIndex:=ScriptData[ind].num;
end;
//---------------------------------------------------//

procedure TFormForScript.ReadScript;
var i,j,k:integer;flg:boolean;
begin
  for i:=0 to sgScript.ColCount-1 do for j:=1 to sgScript.RowCount-1 do
  sgScript.Cells[i,j]:=''; {очистка таблицы скрипта}
  k:=0;
  if Length(ScriptData)>0 then for i:=0 to Length(ScriptData)-1 do
  begin
    {ShowMessage('номер записи:'+IntToStr(i)); ShowMessage('код:'+IntToStr(ScriptData[i].op_code));
          ShowMessage('переход:'+IntToStr(ScriptData[i].transit)); }
    sgScript.Cells[0,i+1]:=IntToStr(i+1); flg:=false;
    if ScriptData[i].op_code<Length(code_script)then
    sgScript.Cells[2,i+1]:=code_script[ScriptData[i].op_code]else
    sgScript.Cells[2,i+1]:='';
    if ScriptData[i].op_code=0 then Break;
    if ScriptData[i].pnt<Length(pnt_script)then
    sgScript.Cells[3,i+1]:=pnt_script[ScriptData[i].pnt]else
    sgScript.Cells[3,i+1]:='';
    if ScriptData[i].pnt=0 then
    sgScript.Cells[4,i+1]:=FloatToStrF(ScriptData[i].value,ffGeneral,6,5)else
    begin
      cbScript.Clear;CreateListParam(cbScript,i,flg);
      if ScriptData[i].num<cbScript.Items.Count then
      sgScript.Cells[4,i+1]:=cbScript.Items.Strings[ScriptData[i].num]else
      sgScript.Cells[4,i+1]:='';
    end; flg:=false;
    if ScriptData[i].transit>0 then
    begin {ShowMessage('номер записи:'+IntToStr(i)); ShowMessage('номер метки:'+IntToStr(k));
          ShowMessage('переход:'+IntToStr(ScriptData[i].transit)); }
     if Length(ScriptLabel)>0 then
      for j:=0 to Length(ScriptLabel)-1 do
      if ScriptLabel[j].val=ScriptData[i].transit then begin flg:=true;Break;end;
      if flg=false then
      begin
        SetLength(ScriptLabel,k+1);ScriptLabel[k].name:='Метка #'+IntToStr(k+1);
        ScriptLabel[k].val:=ScriptData[i].transit;ScriptLabel[k].num:=k;
         k:=k+1;
      end;
    end;
  end;sgScript.RowCount:=Length(ScriptData)+1;
  if (Length(ScriptLabel)>0)and(Length(ScriptData)>0) then
  for i:=0 to Length(ScriptData)-1 do
  begin
    for j:=0 to Length(ScriptLabel)-1 do if i=ScriptLabel[j].val then
    begin sgScript.Cells[1,i+1]:=ScriptLabel[j].name;Break;end;
    for j:=0 to Length(ScriptLabel)-1 do if ScriptData[i].transit=ScriptLabel[j].val then
    begin sgScript.Cells[5,i+1]:=ScriptLabel[j].name;Break;end;
  end;
end;
//---------------------------------------------------//

procedure TFormForScript.ViewNewTable;
var i:integer;
begin
  sgScript.ColCount:=Length(name_col);sgScript.DefaultColWidth:=101;
  sgScript.ColWidths[0]:=81;sgScript.ColWidths[1]:=81;
  sgScript.ColWidths[2]:=141;
  sgScript.ColWidths[4]:=107;sgScript.ColWidths[5]:=81;
  for i:=0 to Length(name_col)-1 do sgScript.Cells[i,0]:=name_col[i];
  for i:=1 to sgScript.RowCount-1 do sgScript.Cells[0,i]:=IntToStr(i);
  SetLength(ScriptData,sgScript.RowCount-1);
  FormForScript.Top:=MainForm.Top+75;FormForScript.Left:=MainForm.Left+75;
end;
//---------------------------------------------------//

procedure TFormForScript.GoSelectExecute(Sender: TObject);
var i:integer;
begin
  case tab_col of
    0:begin
        if cbScript.ItemIndex=0 then {вставляет пустую строку}
        begin
          SetLength(ScriptData,Length(ScriptData)+1);
          if tab_row<Length(ScriptData) then
          for i:=0 to Length(ScriptData)-tab_row-1 do
          begin
            ScriptData[Length(ScriptData)-1-i].op_code:=
                               ScriptData[Length(ScriptData)-2-i].op_code;
            ScriptData[Length(ScriptData)-1-i].pnt:=
                               ScriptData[Length(ScriptData)-2-i].pnt;
            ScriptData[Length(ScriptData)-1-i].param:=
                               ScriptData[Length(ScriptData)-2-i].param;
            ScriptData[Length(ScriptData)-1-i].num:=
                               ScriptData[Length(ScriptData)-2-i].num;
            ScriptData[Length(ScriptData)-1-i].transit:=
                               ScriptData[Length(ScriptData)-2-i].transit;
            ScriptData[Length(ScriptData)-1-i].value:=
                               ScriptData[Length(ScriptData)-2-i].value;
          end;ScriptData[tab_row].op_code:=255;ScriptData[tab_row].pnt:=255;
          ScriptData[tab_row].param:=255;ScriptData[tab_row].num:=255;
          ScriptData[tab_row].value:=0;ScriptData[tab_row].transit:=0;
          ReadScript;
        end;
        if cbScript.ItemIndex=1 then {удаляет выбранную строку}
        begin
          if tab_row<Length(ScriptData)-1 then
          for i:=0 to Length(ScriptData)-tab_row-1 do
          begin
            ScriptData[tab_row-1+i].op_code:=ScriptData[tab_row+i].op_code;
            ScriptData[tab_row-1+i].pnt:=ScriptData[tab_row+i].pnt;
            ScriptData[tab_row-1+i].param:=ScriptData[tab_row+i].param;
            ScriptData[tab_row-1+i].num:=ScriptData[tab_row+i].num;
            ScriptData[tab_row-1+i].transit:=ScriptData[tab_row+i].transit;
            ScriptData[tab_row-1+i].value:=ScriptData[tab_row+i].value;
          end;SetLength(ScriptData,Length(ScriptData)-1);ReadScript;
        end;
      end;
    1:begin
        SetLength(ScriptLabel,Length(ScriptLabel)+1);
        ScriptLabel[Length(ScriptLabel)-1].val:=tab_row-1;
        ScriptLabel[Length(ScriptLabel)-1].name:=
                               cbScript.Items.Strings[cbScript.ItemIndex];
        ScriptLabel[Length(ScriptLabel)-1].num:=EnableLabel[cbScript.ItemIndex].num;
        sgScript.Cells[tab_col,tab_row]:=ScriptLabel[Length(ScriptLabel)-1].name;
      end;
    2:begin
        ScriptData[tab_row-1].op_code:=cbScript.ItemIndex;
        sgScript.Cells[tab_col,tab_row]:=cbScript.Items.Strings[cbScript.ItemIndex];
      end;
    3:begin
        ScriptData[tab_row-1].pnt:=num_point[cbScript.ItemIndex];
        sgScript.Cells[tab_col,tab_row]:=cbScript.Items.Strings[cbScript.ItemIndex];
      end;
    4:if ScriptData[tab_row-1].pnt<>0 then
      begin
        ScriptData[tab_row-1].param:=num_param[cbScript.ItemIndex];
        ScriptData[tab_row-1].num:=cbScript.ItemIndex;
        sgScript.Cells[tab_col,tab_row]:=cbScript.Items.Strings[cbScript.ItemIndex];
      end;
    5:begin
        ScriptData[tab_row-1].transit:=ScriptLabel[cbScript.ItemIndex].val;
        sgScript.Cells[tab_col,tab_row]:=cbScript.Items.Strings[cbScript.ItemIndex];
      end;
  end;cbScript.Visible:=false;flag_view:=cvOff;
end;
//---------------------------------------------------//

procedure TFormForScript.GoKeyPressExecute(Sender: TObject; var Key: Char);
begin
  if Ord(Key)=13 then begin GoEditExecute;Exit;end;flag_edit:=true;
  if filter then if not (Key in ['0'..'9','-',smb_del])then Key:=#0;
end;
//---------------------------------------------------//

procedure TFormForScript.GoEditExecute;
var flg:boolean;
label M;
begin
  case tab_col of
    4:begin
        flg:=false;
        try ScriptData[tab_row-1].value:=StrToFloat(eScript.Text);
        except on EConvertError do flg:=true;end;
        if flg then ShowMessage('Неверный ввод! Пожалуйста повторите..')else
        sgScript.Cells[tab_col,tab_row]:=eScript.Text;
      end;
  end;
M:eScript.Visible:=false;flag_view:=cvOff;
end;
//---------------------------------------------------//

procedure TFormForScript.FormCreate(Sender: TObject);
begin
  cbScript:=TComboBox.Create(FormForScript);cbScript.Parent:=FormForScript;
  cbScript.OnChange:=GoSelectExecute;
  cbScript.Color:=$00D8E9EC;cbScript.Font.Color:=clBlue;
  cbScript.Font.Style:=[fsBold];cbScript.Style:=csDropDownList;
  eScript:=TEdit.Create(FormForScript);eScript.Parent:=FormForScript;
  eScript.Font.Color:=clBlue;eScript.Font.Style:=[fsBold];
  eScript.OnKeyPress:=GoKeyPressExecute;eScript.Visible:=false;
  cbScript.Visible:=false;
end;
//---------------------------------------------------//

procedure TFormForScript.sgScriptDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var str:string;
begin
  if sgScript.TopRow<>top_row then
  begin cbScript.Visible:=false; eScript.Visible:=false; end;
  if State=[gdSelected]then with sgScript do
  begin
    Canvas.Font.Color:=Font.Color; Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow]; Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (ACol=2)and(ScriptData[ARow-1].op_code>=16)and
    (ScriptData[ARow-1].op_code<=22)then with sgScript do
  begin
    Canvas.Font.Color:=clBlue; Canvas.Brush.Color:=Brush.Color;
    str:=Cells[ACol,ARow]; Canvas.FillRect(Rect);
    Canvas.TextOut(Rect.Left+2,Rect.Top+2,str);
  end;
  if (flag_view=cvSelect)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    cbScript.Left:=pScript.Left+sgScript.Left+Rect.Left+2;
    cbScript.Top:=pScript.Top+sgScript.Top+Rect.Top+2;
  end;
  if (flag_view=cvEdit)and(tab_row=ARow)and(tab_col=ACol)then
  begin
    eScript.Left:=pScript.Left+sgScript.Left+Rect.Left+2;
    eScript.Top:=pScript.Top+sgScript.Top+Rect.Top+2;
  end;
end;
//---------------------------------------------------//

procedure TFormForScript.sgScriptSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var flag,flg:boolean;i,j:integer;
begin
  top_row:=sgScript.TopRow;cbScript.Clear;
  case ACol of
    0:begin
        flag:=true;filter:=false;
        for i:=0 to Length(rec_op)-1 do cbScript.Items.Add(rec_op[i]);
      end;
    1:begin
        for i:=0 to 49 do
        begin
          flg:=false;if Length(ScriptLabel)>0 then
          begin
            for j:=0 to Length(ScriptLabel)-1 do
            if i=ScriptLabel[j].num then begin flg:=true;Break;end;
          end;
          if flg=false then
          begin
            cbScript.Items.Add('Метка #'+IntToStr(i+1));
            SetLength(EnableLabel,cbScript.Items.Count);
            EnableLabel[cbScript.Items.Count-1].num:=i;
          end;
        end;flag:=true;
      end;
    2:begin
        for i:=0 to Length(code_script)-1 do cbScript.Items.Add(code_script[i]);
        cbScript.ItemIndex:=ScriptData[ARow-1].op_code;flag:=true;
      end;
    3:begin {установка списка точек}
        if (ScriptData[ARow-1].op_code=1)or((ScriptData[ARow-1].op_code>2)and
           (ScriptData[ARow-1].op_code<7))then for i:=0 to Length(ind_val)-1 do
        begin
          cbScript.Items.Add(pnt_script[ind_val[i]]);SetLength(num_point,i+1);
          num_point[i]:=ind_val[i];
        end else
        if ScriptData[ARow-1].op_code=2 then for i:=0 to Length(ind_sav)-1 do
        begin
          cbScript.Items.Add(pnt_script[ind_sav[i]]);SetLength(num_point,i+1);
          num_point[i]:=ind_sav[i];
        end else
        if (ScriptData[ARow-1].op_code>6)and(ScriptData[ARow-1].op_code<10)then
        for i:=0 to Length(ind_log)-1 do
        begin
          cbScript.Items.Add(pnt_script[ind_log[i]]);SetLength(num_point,i+1);
          num_point[i]:=ind_log[i];
        end else
        if (ScriptData[ARow-1].op_code>9)and(ScriptData[ARow-1].op_code<23)then
        for i:=0 to Length(ind_func)-1 do
        begin
          cbScript.Items.Add(pnt_script[ind_func[i]]);SetLength(num_point,i+1);
          num_point[i]:=ind_func[i];
        end;cbScript.ItemIndex:=ScriptData[ARow-1].pnt;flag:=true;
      end;
    4:CreateListParam(cbScript,ARow-1,flag);{установка списка параметров точки}
    5:begin
        if ((ScriptData[ARow-1].pnt=0)and(ScriptData[ARow-1].op_code<>18))or
          (ScriptData[ARow-1].op_code<16)or(ScriptData[ARow-1].op_code>22)then
          Exit; flag:=true;
        if Length(ScriptLabel)>0 then for i:=0 to Length(ScriptLabel)-1 do
        cbScript.Items.Add(ScriptLabel[i].name); 
      end;
  end;
  if flag then
  begin
    eScript.Visible:=false;cbScript.Height:=sgScript.RowHeights[ARow];
    tab_row:=ARow;cbScript.Width:=sgScript.ColWidths[ACol];
    cbScript.Visible:=true;tab_col:=ACol;flag_view:=cvSelect;
  end else
  begin
    eScript.Height:=sgScript.RowHeights[ARow];tab_row:=ARow;
    eScript.Width:=sgScript.ColWidths[ACol];eScript.Visible:=true;
    tab_col:=ACol;flag_view:=cvEdit;cbScript.Visible:=false;
    eScript.SetFocus;
  end;
end;
//---------------------------------------------------//

procedure TFormForScript.bSaveDevClick(Sender: TObject);
begin
  if MessageDlg('Вы действительно хотите установить новый скрипт?',
                 mtConfirmation,[mbYes,mbNo],0)=mrNo then Exit;
  if Length(ScriptData)>0 then
  begin
    Load.addr:=0;Load.step:=0;Load.flg_end:=false;Screen.Cursor:=crHourGlass;
    if Length(ScriptData)>40 then Load.step:=40 else
    Load.step:=Length(ScriptData);flg_cmd:=17;
  end;
end;
//---------------------------------------------------//

procedure TFormForScript.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MainForm.CloseAllWnd;
end;
//---------------------------------------------------//

procedure TFormForScript.bSaveFileClick(Sender: TObject);
var i,flg_res:integer; name_script:string;
begin
  if Length(ScriptData)>0 then with MainForm do
  begin
    SaveDialog1.Title:='Укажите имя файла Скрипта';
    SaveDialog1.FilterIndex:=3;SaveDialog1.DefaultExt:='csf';
    if SaveDialog1.Execute then
    begin
      name_script:=SaveDialog1.FileName; AssignFile(f_script,name_script);{$I-}
      Reset(f_script);{$I+} flg_res:=IOResult;
      if flg_res<>0 then Rewrite(f_script);
      for i:=0 to Length(ScriptData)-1 do with d_script do
      begin
        op_code:=ScriptData[i].op_code; pnt:=ScriptData[i].pnt;
        param:=ScriptData[i].param; num:=ScriptData[i].num;
        value:=ScriptData[i].value; transit:=ScriptData[i].transit;
        Write(f_script,d_script);
      end; CloseFile(f_script);
    end;
  end;
end;
//---------------------------------------------------//

procedure TFormForScript.BitBtn1Click(Sender: TObject);
var i:integer;
begin
  SetLength(ScriptLabel,0); SetLength(EnableLabel,0);
  for i:=0 to Length(ScriptData)-1 do
  begin
    sgScript.Cells[1,i+1]:=' '; sgScript.Cells[5,i+1]:=' ';
    ScriptData[i].transit:=0;
  end;
end;
//---------------------------------------------------//

end.
