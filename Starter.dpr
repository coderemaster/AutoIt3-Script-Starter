program Starter;

{$WARN SYMBOL_PLATFORM OFF}

uses
  System.IniFiles, System.IOUtils, System.StrUtils, System.SysUtils,
  Vcl.Forms,
  Winapi.ShellAPI, Winapi.Windows;

{$R *.res}

var
  AppDir, AppName, IniPath: string;
  IniFile: TIniFile;
  IniSuccess: Boolean = False;
  AutoItPath: string = '';
  ScriptPath: string = '';
  AutoItPathExact: Boolean = False;
  ScriptPathExact: Boolean = False;

begin
  AppDir := ExtractFileDir(Application.ExeName);
  AppName := TPath.GetFileNameWithoutExtension(Application.ExeName);
  IniPath := ChangeFileExt(Application.ExeName, '.ini');

  if FileExists(IniPath, False) then begin
    IniFile := TIniFile.Create(IniPath);
    try
      AutoItPath := IniFile.ReadString('Starter', 'AutoItPath', '?');
      ScriptPath := IniFile.ReadString('Starter', 'ScriptPath', '?');
      IniSuccess := True;
    finally
      IniFile.Free;
    end;
    if not IniSuccess then begin
      MessageBox(0, PWideChar('Read INI file failed'), PChar(AppName), MB_ICONERROR or MB_TASKMODAL);
      Exit;
    end;
    
    if AutoItPath = '' then
      AutoItPath := AppDir + '\AutoIt3.exe'
    else if AutoItPath = '?' then
      AutoItPath := AppDir + '\AutoIt\AutoIt3.exe'
    else begin
      if not TPath.IsPathRooted(AutoItPath) then
        AutoItPath := AppDir + '\' + AutoItPath;
      if RightStr(AutoItPath, 1) = '\' then
        AutoItPath := AutoItPath + 'AutoIt3.exe'
      else
        AutoItPathExact := true;
    end;
    
    if ScriptPath = '' then
      ScriptPath := AppDir + '\' + AppName + '.au3'
    else if ScriptPath = '?' then
      ScriptPath := AppDir + '\AutoIt\' + AppName + '.au3'
    else begin
      if not TPath.IsPathRooted(ScriptPath) then
        ScriptPath := AppDir + '\' + ScriptPath;
      if RightStr(ScriptPath, 1) = '\' then
        ScriptPath := ScriptPath + AppName + '.au3'
      else
        ScriptPathExact := true;
    end;

  end else {not FileExists(IniPath, False)} begin
    AutoItPath := AppDir + '\AutoIt\AutoIt3.exe';
    ScriptPath := AppDir + '\AutoIt\' + AppName + '.au3';
  end;

{$IFDEF WIN64}
  if not AutoItPathExact and FileExists(AutoItPath.Replace('\AutoIt3.exe', '\AutoIt3_x64.exe'), False) then
    AutoItPath := AutoItPath.Replace('\AutoIt3.exe', '\AutoIt3_x64.exe')
  else
{$ENDIF}
  if not FileExists(AutoItPath, False) then begin
    MessageBox(0, PWideChar('AutoIt program not found'), PChar(AppName), MB_ICONERROR or MB_TASKMODAL);
    Exit;
  end;

  if not ScriptPathExact and FileExists(ChangeFileExt(ScriptPath, '.a3x'), False) then
    ScriptPath := ChangeFileExt(ScriptPath, '.a3x')
  else 
  if not FileExists(ScriptPath, False) then begin
    MessageBox(0, PWideChar('AutoIt script not found'), PChar(AppName), MB_ICONERROR or MB_TASKMODAL);
    Exit;
  end;

  ShellExecute(0, 'open', PChar(AutoItPath), PChar(ScriptPath), nil, SW_SHOW);
  if GetLastError() <> 0 then
    MessageBox(0, PWideChar('Start AutoIt process failed'), PChar(AppName), MB_ICONERROR or MB_TASKMODAL);
end.
