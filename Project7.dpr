program Project7;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ConfigurationSettings in 'ConfigurationSettings.pas' {FormConfigurationSettings},
  EcoSonicSettings in 'EcoSonicSettings.pas' {FormEcoSonicSetting},
  FormForView in 'FormForView.pas' {FormForVariablesView},
  InOutModulesSetting in 'InOutModulesSetting.pas' {FormIOModulesSetting},
  ModbusSetting in 'ModbusSetting.pas' {FormModbusSetting},
  script in 'script.pas' {FormForScript},
  report in 'report.pas' {FormForReports},
  ViewTheArchiveFromFile in 'ViewTheArchiveFromFile.pas' {FormArchFromFile};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TFormConfigurationSettings, FormConfigurationSettings);
  Application.CreateForm(TFormEcoSonicSetting, FormEcoSonicSetting);
  Application.CreateForm(TFormForVariablesView, FormForVariablesView);
  Application.CreateForm(TFormIOModulesSetting, FormIOModulesSetting);
  Application.CreateForm(TFormModbusSetting, FormModbusSetting);
  Application.CreateForm(TFormForScript, FormForScript);
  Application.CreateForm(TFormForReports, FormForReports);
  Application.CreateForm(TFormArchFromFile, FormArchFromFile);
  Application.Run;
end.
