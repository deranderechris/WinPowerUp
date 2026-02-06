Was macht der SystemTweaker Win10?
SystemTweakWin10 ist ein portabler Windows-Tweaker, der Windows 10 auch auf schwächerer Hardware reibungslos laufen lässt. Es blockiert, optimiert und schaltet gezielt Systemfunktionen wieder frei – auf Wunsch ohne Installation, ohne Chaos in der Registry. Das Tool läuft direkt und bietet beispielsweise die Möglichkeit, den virtuellen Arbeitsspeicher zu erweitern. Dadurch kann Windows mehr Festplattenspeicher (bis zu 32 GB) als „RAM-Ersatz“ nutzen, was besonders bei einer schnellen SSD interessant ist, wenn der physische Arbeitsspeicher knapp wird. Die Registry-Einträge werden so angepasst, dass Windows größere Auslagerungsdateien erlaubt, was hilfreich ist, wenn viele Programme gleichzeitig genutzt werden oder der physische RAM begrenzt ist.

gezielte Systemanpassungen für Windows 10
batchbasierte Zusatzfunktionen über SystemTuner.bat
integrierten Installer für saubere Verteilung
keine Abhängigkeiten, keine Streuverluste


Heruntergeladenen Projektordner vorbereiten

um die exe zu erstellen, musst Du den Advanced Batch to exe instaliert haben,

- per Rechtsklick auf batch und

- Wahl im Menu, Bat to exe compile startest du den Vorgang,

- dort wählst Du alles aus was Du noch anpassen möchtest. icon.ico, Name der exe, etc.



1. Führe die build_installer.bat aus.

Diese:

erkennt automatisch den Ordnernamen als Projektnamen
sucht die .exe
erzeugt ein passendes .iss-Skript
startet den Inno Setup Compiler (ISCC.exe)
erstellt den Installer im Unterordner Output


Ergebnis Du erhältst eine Setup-Datei, z. B. SystemTweakWin10_Setup.exe, die:

deine .exe installiert
optional die .bat mitliefert
Startmenüeinträge setzt
direkt ausführbar ist
Und Du kannst die exe verteilen und auf x Geräten installieren.
⚠️ Warnhinweis
SystemTweakWin10 nimmt gezielte Eingriffe in die Windows-Registry vor. Diese Änderungen betreffen Systemfunktionen, Sicherheitseinstellungen und Verhalten von Windows-Komponenten. ⚠️ Achtung: Unsachgemäße Anwendung oder unerwartete Systemkonfigurationen können zu Instabilität, Funktionsverlust oder im Extremfall zu einem vollständigen Systemabsturz führen. Die Nutzung erfolgt auf eigene Verantwortung. Vor dem Einsatz wird dringend empfohlen, ein vollständiges Backup oder einen Wiederherstellungspunkt zu erstellen.

INFO: Beide Exe sind im Download Ordner enthalten, viel Spass beim Win10 tweaken



Die install_setup.bat, kannst du in jeden Projektordner mit ner exe tun, in den selben Ordner wie die EXE, egal ob aus einer .bat oder .py erstellt. Die Datei findet in deinem Ordner alles was Sie braucht automatisch.(ganz Wichtig alles muss in dem selben Ordner liegen.)

Und baut daraus eine iss, dann mit InnoSetup, in einem Rutsch eine exe mit Installer (welche ohne Python oder X funktioniert, auf jedem Rechner funktioniert.)
