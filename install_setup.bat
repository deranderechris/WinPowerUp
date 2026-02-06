@echo off
setlocal enabledelayedexpansion
title Inno Setup Installer Builder
color 0A

:: Projektname = Ordnername
for %%I in (.) do set "ProjectName=%%~nxI"

:: EXE-Datei suchen
set "MainExe="
for %%F in (*.exe) do (
    if /i not "%%~nxF"=="%~nx0" (
        set "MainExe=%%F"
        goto :found
    )
)
echo ❌ Keine EXE-Datei gefunden im aktuellen Ordner.
pause
exit /b

:found
echo [INFO] Gefundene EXE: %MainExe%

:: ISS-Datei erzeugen
set "ISSFile=%ProjectName%.iss"
echo ; Inno Setup Script für %ProjectName% > "%ISSFile%"
echo [Setup] >> "%ISSFile%"
echo AppName=%ProjectName% >> "%ISSFile%"
echo AppVersion=1.0 >> "%ISSFile%"
echo DefaultDirName={pf}\%ProjectName% >> "%ISSFile%"
echo DefaultGroupName=%ProjectName% >> "%ISSFile%"
echo OutputDir=Output >> "%ISSFile%"
echo OutputBaseFilename=%ProjectName%_Setup >> "%ISSFile%"
echo Compression=lzma >> "%ISSFile%"
echo SolidCompression=yes >> "%ISSFile%"
echo >> "%ISSFile%"
echo [Files] >> "%ISSFile%"
echo Source: "%MainExe%"; DestDir: "{app}"; Flags: ignoreversion >> "%ISSFile%"
echo >> "%ISSFile%"
echo [Icons] >> "%ISSFile%"
echo Name: "{group}\%ProjectName%"; Filename: "{app}\%MainExe%" >> "%ISSFile%"
echo >> "%ISSFile%"
echo [Run] >> "%ISSFile%"
echo Filename: "{app}\%MainExe%"; Description: "Starte %ProjectName%"; Flags: nowait postinstall skipifsilent >> "%ISSFile%"

:: Inno Setup Compiler starten
set "ISCCPath=C:\Program Files (x86)\Inno Setup 6\ISCC.exe"
if exist "%ISCCPath%" (
    echo 🚀 Starte Inno Setup Compiler...
    "%ISCCPath%" "%ISSFile%"
    echo ✅ Installer wurde erstellt!
) else (
    echo ⚠️ Inno Setup Compiler nicht gefunden unter: %ISCCPath%
    echo Bitte Inno Setup installieren und Pfad ggf. anpassen.
)

pause
exit /b
