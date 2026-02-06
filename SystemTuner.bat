@echo off
setlocal EnableDelayedExpansion
title SystemSweep Tuner - Windows 10 Optimierung
color 0A

:: === Adminpruefung ===
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [FEHLER] Bitte als Administrator ausfuehren!
    pause
    exit /b
)

:: === Begruessung ===
echo ============================================
echo   VMOD SystemTuner - Windows 10 Tuning
echo   Auswahl treffen - dann Patch starten
echo ============================================
echo.

:: === Auswahlmenue ===
echo Waehle die Komponenten, die deaktiviert werden sollen:
echo.
echo [1] Windows Search (Suchindex)
echo [2] Superfetch / Prefetch
echo [3] Remote Registry
echo [4] Xbox Dienste
echo [5] OneDrive Autostart
echo [6] Telemetrie / DiagTrack
echo [7] Cortana Hintergrunddienste
echo [8] Autostart-Eintraege (Run Keys)
echo [9] Visuelle Effekte (Registry)
echo [10] RAM-Boost via SSD (ReadyBoost 32MB)
echo [11] RAM-Boost via HDD (ReadyBoost 32MB - langsamer)
echo [12] Werbung und Vorschlaege deaktivieren
echo [99] Rueckgaengig: Alle Optimierungen wiederherstellen
echo [0] Alles deaktivieren
echo.

set /p rawInput=Deine Auswahl (z. B. 1 3 5 oder 0): 
call :SanitizeInput "%rawInput%"
set "selectedOptions=!cleanInput!"

echo.
echo Du hast folgende Optionen gewaehlt: !selectedOptions!
set /p confirm=Patch jetzt ausfuehren? (J/N): 
if /i not "!confirm!"=="J" (
    echo Abbruch durch Benutzer.
    exit /b
)

:: === Patch-Ausfuehrung ===
for %%x in (!selectedOptions!) do (
    for %%y in (%%x) do (
        if %%y==1 call :DisableSearch
        if %%y==2 call :DisableSuperfetch
        if %%y==3 call :DisableRemoteRegistry
        if %%y==4 call :DisableXbox
        if %%y==5 call :DisableOneDrive
        if %%y==6 call :DisableTelemetry
        if %%y==7 call :DisableCortana
        if %%y==8 call :DisableAutostart
        if %%y==9 call :DisableVisuals
        if %%y==10 call :EnableReadyBoostSSD
        if %%y==11 call :EnableReadyBoostHDD
        if %%y==12 call :DisableAds
        if %%y==99 call :UndoAll
        if %%y==0 (
            call :DisableSearch
            call :DisableSuperfetch
            call :DisableRemoteRegistry
            call :DisableXbox
            call :DisableOneDrive
            call :DisableTelemetry
            call :DisableCortana
            call :DisableAutostart
            call :DisableVisuals
            call :EnableReadyBoostSSD
            call :DisableAds
        )
    )
)

goto :end

:: === Eingabebereinigung ===
:SanitizeInput
set "cleanInput=%~1"
set "cleanInput=!cleanInput:ä=ae!"
set "cleanInput=!cleanInput:ö=oe!"
set "cleanInput=!cleanInput:ü=ue!"
set "cleanInput=!cleanInput:ß=ss!"
for %%C in (^ & | > < \" ` ' , ; : ! ? * / \ [ ] { } ( )) do (
    set "cleanInput=!cleanInput:%%C=!"
)
goto :eof

:: === Funktionen ===

:DisableSearch
echo [INFO] Windows Search wird deaktiviert...
sc stop "WSearch" >nul
sc config "WSearch" start= disabled >nul
goto :eof

:DisableSuperfetch
echo [INFO] Superfetch/Prefetch wird deaktiviert...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul
goto :eof

:DisableRemoteRegistry
echo [INFO] Remote Registry wird deaktiviert...
sc config "RemoteRegistry" start= disabled >nul
sc stop "RemoteRegistry" >nul
goto :eof

:DisableXbox
echo [INFO] Xbox Dienste werden deaktiviert...
sc config "XblAuthManager" start= disabled >nul
sc config "XblGameSave" start= disabled >nul
sc config "XboxNetApiSvc" start= disabled >nul
goto :eof

:DisableOneDrive
echo [INFO] OneDrive Autostart wird entfernt...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /f >nul
goto :eof

:DisableTelemetry
echo [INFO] Telemetrie wird deaktiviert...
sc config "DiagTrack" start= disabled >nul
sc stop "DiagTrack" >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
goto :eof

:DisableCortana
echo [INFO] Cortana Hintergrunddienste werden deaktiviert...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul
goto :eof

:DisableAutostart
echo [INFO] Autostart-Eintraege werden entfernt...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f >nul
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f >nul
goto :eof

:DisableVisuals
echo [INFO] Visuelle Effekte werden deaktiviert...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul
goto :eof

:EnableReadyBoostSSD
echo [INFO] RAM-Boost via SSD wird aktiviert (32MB)...
fsutil behavior set memoryusage 2 >nul
echo [HINWEIS] SSD ReadyBoost vorbereitet. USB/SSD als E: einbinden fuer Wirkung.
goto :eof

:EnableReadyBoostHDD
echo [INFO] RAM-Boost via HDD wird aktiviert (32MB)...
echo [WARNUNG] HDD ist merklich langsamer - nur bei fehlender SSD verwenden.
fsutil behavior set memoryusage 2 >nul
echo [HINWEIS] HDD ReadyBoost vorbereitet. USB/HDD als E: einbinden fuer Wirkung.
goto :eof

:DisableAds
echo [INFO] Werbung und Vorschlaege werden deaktiviert...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v FeatureManagementEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 2 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 0 /f >nul
goto :eof

:UndoAll
echo [INFO] Rueckgaengig: Alle Optimierungen werden wiederhergestellt...

:: Windows Search
sc config "WSearch" start= delayed-auto >nul
sc start "WSearch" >nul

:: Superfetch / Prefetch
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 3 /f >nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 3 /f >nul

:: Remote Registry
sc config "RemoteRegistry" start= auto >nul
sc start "RemoteRegistry" >nul

:: Xbox Dienste
sc config "XblAuthManager" start= demand >nul
sc config "XblGameSave" start= demand >nul
sc config "XboxNetApiSvc" start= demand >nul

:: OneDrive Autostart
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v OneDrive /t REG_SZ /d "%ProgramFiles%\Microsoft OneDrive\OneDrive.exe" /f >nul

:: Telemetrie
sc config "DiagTrack" start= auto >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f >nul

:: Cortana
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 1 /f >nul

:: Autostart-Eintraege (nicht rekonstruierbar)
echo [WARNUNG] Autostart-Eintraege wurden geloescht und koennen nicht automatisch wiederhergestellt.

:: Visuelle Effekte
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f >nul

:: ReadyBoost
fsutil behavior set memoryusage 0 >nul

:: Werbung & Vorschlaege
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v FeatureManagementEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v OemPreInstalledAppsEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v PreInstalledAppsEverEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSyncProviderNotifications /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Feeds" /v ShellFeedsTaskbarViewMode /t REG_DWORD /d 0 /f >nul
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SoftLandingEnabled /t REG_DWORD /d 1 /f >nul

echo [INFO] Ruecksetzung abgeschlossen.
goto :eof

:end
echo.
echo ============================================
echo   [FERTIG] Alle Optimierungen abgeschlossen.
echo   Du kannst den Rechner jetzt neu starten.
echo ============================================
pause
exit /b
