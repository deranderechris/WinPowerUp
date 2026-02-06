@echo off
setlocal

:: Aktueller Ordner, in dem die Batch-Datei liegt
set "CURRENT_DIR=%~dp0"

:: Name des ZIP-Archivs (basierend auf Ordnername)
for %%I in ("%CURRENT_DIR:~0,-1%") do set "FOLDER_NAME=%%~nxI"
set "ZIP_NAME=%FOLDER_NAME%.zip"
set "ZIP_PATH=%CURRENT_DIR%%ZIP_NAME%"

echo [INFO] Erstelle ZIP-Archiv: %ZIP_NAME%

:: Prüfen, ob PowerShell verfügbar ist
where powershell >nul 2>nul
if %errorlevel% neq 0 (
    echo [FEHLER] PowerShell nicht gefunden. ZIP-Erstellung nicht möglich.
    pause
    exit /b
)

:: ZIP erstellen: alles im aktuellen Ordner außer dem ZIP selbst
powershell -Command ^
"$source = Get-ChildItem -Path '%CURRENT_DIR%' -Exclude '%ZIP_NAME%'; ^
Compress-Archive -Path $source.FullName -DestinationPath '%ZIP_PATH%' -Force"

echo [FERTIG] Archiv erstellt: %ZIP_NAME%
pause
endlocal
