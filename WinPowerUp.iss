; Inno Setup Script für WinPowerUp 
[Setup] 
AppName=WinPowerUp 
AppVersion=1.0 
DefaultDirName={pf}\WinPowerUp 
DefaultGroupName=WinPowerUp 
OutputDir=Output 
OutputBaseFilename=WinPowerUp_Setup 
Compression=lzma 
SolidCompression=yes 
ECHO ist ausgeschaltet (OFF).
[Files] 
Source: "SystemTweakWin10.exe"; DestDir: "{app}"; Flags: ignoreversion 
ECHO ist ausgeschaltet (OFF).
[Icons] 
Name: "{group}\WinPowerUp"; Filename: "{app}\SystemTweakWin10.exe" 
ECHO ist ausgeschaltet (OFF).
[Run] 
Filename: "{app}\SystemTweakWin10.exe"; Description: "Starte WinPowerUp"; Flags: nowait postinstall skipifsilent 
