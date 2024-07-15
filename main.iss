#include "config\variables.iss"

// ====================== C O N S T A N T S ======================
#define C_PATH_TOE_DEFAULT   ''

// ISO
#define C_REGISTRY_TOE_CD    'SOFTWARE\WOW6432Node\Ubisoft\Heroes of Might and Magic V - Tribes of the East';

// GOG
#define C_REGISTRY_TOE_GOG   'SOFTWARE\GOG.com\Games';

// Steam
#define C_REGISTRY_STEAM     'SOFTWARE\WOW6432Node\Valve\Steam';
#define C_REGISTRY_TOE_STEAM 'SOFTWARE\WOW6432Node\Valve\Steam\Apps\15370';
#define C_STEAM_TOE          '\steamapps\common\Heroes of Might and Magic 5 Tribes of the East';

#if APP_LANGUAGE == "English"
  #define V_LANGUAGE_SET "compiler:Default.isl,config\texts\Messages.txt"
#else
  #define V_LANGUAGE_SET "compiler:Default.isl,compiler:Languages\" + APP_LANGUAGE + ".isl,config\texts\Messages.txt"
#endif

[Code]
function ReadSteamLibraryFolders(FilePath: string): TArrayOfString;
var
  Lines: TArrayOfString;
  Line: string;
  I, StartPos, EndPos: Integer;
begin
  SetArrayLength(Result, 0);
  if LoadStringsFromFile(FilePath, Lines) then
  begin
    for I := 0 to GetArrayLength(Lines) - 1 do
    begin
      Line := Trim(Lines[I]);
      if Pos('"path"', Line) > 0 then
      begin
        StartPos := Pos('"path"', Line) + 7;
        EndPos := Length(Line);

        // Extract the path value
        Line := Copy(Line, StartPos, EndPos - StartPos + 1);
        Line := Trim(Line);

        // Remove double quotes if any
        if (Length(Line) >= 2) and (Copy(Line, 1, 1) = '"') and (Copy(Line, Length(Line), 1) = '"') then
          Line := Copy(Line, 2, Length(Line) - 2);

        SetArrayLength(Result, GetArrayLength(Result) + 1);
        Result[GetArrayLength(Result) - 1] := Line;
      end;
    end;
  end;
end;

function GetOtherAppPath(empty: string): string;
var
  RootKey: Integer;
  Subkey: string;
  SubkeyNames: TArrayOfString;
  InstallPath: string;
  GameName: string;
  I: Integer;
  SteamPath: string;
  InstallDirs: TArrayOfString;


begin
  Result := ExpandConstant('{#C_PATH_TOE_DEFAULT}');
  RootKey := HKEY_LOCAL_MACHINE;

  Subkey := ExpandConstant('{#C_REGISTRY_TOE_CD}');
  if RegGetSubkeyNames(RootKey, Subkey, SubkeyNames) then
  begin
    for I := 0 to GetArrayLength(SubkeyNames) - 1 do
    begin
      if RegQueryStringValue(RootKey, Subkey + '\' + SubkeyNames[I], 'InstallPath', InstallPath) then
      begin
        Result := InstallPath;
        Exit;
      end;
    end;
  end;

  Subkey := ExpandConstant('{#C_REGISTRY_TOE_GOG}');
  if RegGetSubkeyNames(RootKey, Subkey, SubkeyNames) then
  begin
    for I := 0 to GetArrayLength(SubkeyNames) - 1 do
    begin
      if RegQueryStringValue(RootKey,Subkey + '\' + SubkeyNames[I], 'gameName', GameName) then
      begin
        if GameName = 'Heroes of Might and Magic V - Tribes of the East' then
        begin
          if RegQueryStringValue(RootKey, Subkey + '\' + SubkeyNames[I], 'path', InstallPath) then
          begin
            Result := InstallPath;
            Exit;
          end;
        end;
      end;
    end;
  end;
  
  Subkey := ExpandConstant('{#C_REGISTRY_TOE_STEAM}');
  if RegKeyExists(RootKey, Subkey) then
  begin
    Subkey := ExpandConstant('{#C_REGISTRY_STEAM}');
    RegQueryStringValue(RootKey, Subkey, 'InstallPath', SteamPath)
    SteamPath := SteamPath + '\steamapps\libraryfolders.vdf';
    InstallDirs := ReadSteamLibraryFolders(SteamPath);
    for I := 0 to GetArrayLength(InstallDirs) - 1 do
    begin
      if DirExists(InstallDirs[I] + ExpandConstant('{#C_STEAM_TOE}')) then
      begin;
        Result:= InstallDirs[I] + ExpandConstant('{#C_STEAM_TOE}'); 
      end;
    end;
  end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  if CurStep = ssInstall then
  begin
    if ((ExpandConstant('{#APP_CHECK1}') <> '') and FileExists(ExpandConstant('{app}\{#APP_CHECK1}'))) or
       ((ExpandConstant('{#APP_CHECK2}') <> '') and FileExists(ExpandConstant('{app}\{#APP_CHECK2}'))) or
       ((ExpandConstant('{#APP_CHECK3}') <> '') and FileExists(ExpandConstant('{app}\{#APP_CHECK3}'))) then
    begin
      MsgBox('Another version of ' + ExpandConstant('{#APP_Name}') + ' is already installed in the selected folder. Please uninstall the existing version before installing again.', mbInformation , MB_OK);
      Abort;
    end;
  end;
end;

[Setup]
AppId={{{#APP_ID}}
AppName={#APP_Name}
AppVersion={#APP_Version}
AppPublisher={#APP_Publisher}
AppPublisherURL={#APP_URL}
AppSupportURL={#APP_Support}
DefaultDirName={code:GetOtherAppPath|{#C_PATH_TOE_DEFAULT}}
DefaultGroupName={#APP_StartName}
OutputDir=output
OutputBaseFilename={#APP_SetupName}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
DirExistsWarning=no
UninstallDisplayName={#APP_Name}
DisableWelcomePage=no
AppendDefaultDirName=no
//Texts
InfoBeforeFile=config/texts/information.txt
//Images
SetupIconFile=config/images/setup_file.ico
WizardImageFile=config/images/side.bmp                       
WizardSmallImageFile=config/images/top_right.bmp


[Languages]
Name: "default"; MessagesFile: "{#V_LANGUAGE_SET}"

[Files]
Source: "files\*"; DestDir: "{app}"; Flags: recursesubdirs

#include "config\icons.iss"
