# 🚀 WinPowerUp

> **Portabler Windows 10 Optimierer für maximale Performance – auch auf schwächerer Hardware**

WinPowerUp ist ein leistungsstarker Windows-Tweaker, der gezielt Systemfunktionen optimiert, unnötige Dienste deaktiviert und Windows 10 deutlich schneller macht. Das Tool arbeitet ohne Installation direkt und nimmt präzise Registry-Anpassungen vor – ideal für schwächere Hardware oder wenn maximale Systemperformance gefragt ist.

## ⚠️ **WICHTIGER WARNHINWEIS**

**WinPowerUp nimmt tiefgreifende Eingriffe in die Windows-Registry und Systemdienste vor!**

Diese Änderungen betreffen kritische Systemfunktionen, Sicherheitseinstellungen und das Verhalten von Windows-Komponenten. Unsachgemäße Anwendung kann zu:
- Systeminstabilität
- Funktionsverlust von Windows-Features
- Im Extremfall zu einem vollständigen Systemabsturz

**➡️ Vor der Nutzung UNBEDINGT:**
- ✅ Einen Wiederherstellungspunkt erstellen
- ✅ Vollständiges Backup anlegen
- ✅ Die Auswirkungen der einzelnen Optionen verstehen

**Die Nutzung erfolgt auf eigene Verantwortung!**

---

## ✨ Features

### 🎯 Optimierungen (einzeln wählbar oder alle auf einmal)

- **[1] Windows Search deaktivieren** – Suchindex-Dienst ausschalten für weniger RAM-Verbrauch
- **[2] Superfetch / Prefetch deaktivieren** – Reduziert Hintergrund-Aktivität auf SSD-Systemen
- **[3] Remote Registry deaktivieren** – Sicherheitsoptimierung
- **[4] Xbox-Dienste deaktivieren** – Gaming-Dienste für Non-Gamer entfernen
- **[5] OneDrive Autostart entfernen** – Verhindert automatischen OneDrive-Start
- **[6] Telemetrie / DiagTrack deaktivieren** – Stoppt Datensammlung durch Microsoft
- **[7] Cortana Hintergrunddienste deaktivieren** – Spart Ressourcen
- **[8] Autostart-Einträge entfernen** – Löscht alle Autostart-Programme (⚠️ vorsichtig!)
- **[9] Visuelle Effekte deaktivieren** – Reduziert Animationen für mehr Speed
- **[10] RAM-Boost via SSD** – ReadyBoost für bis zu 32 GB virtuellen RAM (schnell)
- **[11] RAM-Boost via HDD** – ReadyBoost über HDD (langsamer, nur wenn keine SSD verfügbar)
- **[12] Werbung & Vorschläge deaktivieren** – Entfernt Windows-Werbung und -Vorschläge
- **[99] Rückgängig machen** – Stellt alle Optimierungen wieder her
- **[0] Alles deaktivieren** – Führt alle Optimierungen gleichzeitig aus

### 📦 Zusätzliche Tools

- **SystemTuner.bat** – Hauptprogramm mit interaktivem Menü
- **install_setup.bat** – Automatischer Inno Setup Installer-Generator
- **WinPowerUp.iss** – Inno Setup Konfigurationsdatei

---

## 📋 Systemanforderungen

- **Betriebssystem:** Windows 10 (32/64-bit)
- **Berechtigung:** Administrator-Rechte erforderlich
- **Build-Tools (nur für Entwicklung):**
  - [Advanced Batch to EXE Converter](https://www.battoexeconverter.com/)
  - [Inno Setup 6](https://jrsoftware.org/isdl.php)

---

## 🚀 Installation & Verwendung

### Methode 1: Fertige EXE verwenden (Endbenutzer)

1. **`SystemTweakWin10.exe` herunterladen** (aus dem Download-Ordner/Release)
2. **Rechtsklick → Als Administrator ausführen**
3. Gewünschte Optimierungen auswählen
4. Mit **J** (Ja) bestätigen
5. Optional: Neustart durchführen

### Methode 2: Installer verwenden

1. **`WinPowerUp_Setup.exe` herunterladen**
2. Installer ausführen
3. Installationspfad wählen
4. Nach Installation: Programm als Administrator starten

### Methode 3: Von Quelle (Entwickler)

1. Repository klonen:
   ```bash
   git clone https://github.com/deranderechris/WinPowerUp.git
   cd WinPowerUp
   ```

2. **SystemTuner.bat direkt ausführen:**
   ```cmd
   Rechtsklick auf SystemTuner.bat → Als Administrator ausführen
   ```

---

## 🔧 Build-Anleitung (für Entwickler)

### EXE aus BAT-Datei erstellen

1. **[Advanced Batch to EXE Converter](https://www.battoexeconverter.com/) installieren**
2. **Rechtsklick auf `SystemTuner.bat`**
3. Im Kontextmenü: **"Compile to EXE"** wählen
4. Im Converter:
   - Icon auswählen (optional: `icon.ico`)
   - EXE-Name festlegen (z.B. `SystemTweakWin10.exe`)
   - Kompilieren

### Installer erstellen

1. **[Inno Setup 6](https://jrsoftware.org/isdl.php) installieren**
2. **`install_setup.bat` als Administrator ausführen**
   
   Das Skript:
   - ✅ Erkennt automatisch den Ordnernamen als Projektnamen
   - ✅ Findet die `.exe`-Datei im Ordner
   - ✅ Erzeugt automatisch eine `.iss`-Datei
   - ✅ Startet Inno Setup Compiler (`ISCC.exe`)
   - ✅ Erstellt den Installer im Unterordner `Output/`

3. **Ergebnis:** `Output/WinPowerUp_Setup.exe`

**Hinweis:** Die `install_setup.bat` ist universell einsetzbar! Lege sie einfach in jeden Projektordner mit einer EXE (egal ob aus `.bat`, `.py` oder anderen Quellen erstellt).

---

## 📖 Verwendung

### Interaktives Menü

Nach dem Start erscheint ein Auswahlmenü:

```
Waehle die Komponenten, die deaktiviert werden sollen:

[1] Windows Search (Suchindex)
[2] Superfetch / Prefetch
[3] Remote Registry
[4] Xbox Dienste
[5] OneDrive Autostart
[6] Telemetrie / DiagTrack
[7] Cortana Hintergrunddienste
[8] Autostart-Eintraege (Run Keys)
[9] Visuelle Effekte (Registry)
[10] RAM-Boost via SSD (ReadyBoost 32MB)
[11] RAM-Boost via HDD (ReadyBoost 32MB - langsamer)
[12] Werbung und Vorschlaege deaktivieren
[99] Rueckgaengig: Alle Optimierungen wiederherstellen
[0] Alles deaktivieren

Deine Auswahl (z. B. 1 3 5 oder 0):
```

### Beispiele

- **Einzelne Optionen:** `1 5 12` (Windows Search, OneDrive, Werbung aus)
- **Alle Optimierungen:** `0`
- **Rückgängig machen:** `99`

---

## 🛡️ Sicherheitshinweise

- ✅ **Wiederherstellungspunkt** vor Nutzung erstellen
- ✅ **Option [99]** zum Rückgängigmachen verwenden
- ⚠️ **Option [8] (Autostart)** löscht ALLE Autostart-Einträge unwiderruflich
- ⚠️ Getestete Funktionalität nur auf **Windows 10**
- ⚠️ Nicht für kritische Produktivsysteme ohne Test verwenden

---

## 📂 Projektstruktur

```
WinPowerUp/
├── SystemTuner.bat         # Hauptskript mit Optimierungsfunktionen
├── SystemTweakWin10.exe    # Kompilierte Version (in Releases)
├── install_setup.bat       # Automatischer Installer-Generator
├── WinPowerUp.iss          # Inno Setup Konfiguration
├── zip_project.bat         # Projekt-Packskript
├── README.md               # Diese Datei
└── Output/                 # Generierte Installer (nach Build)
    └── WinPowerUp_Setup.exe
```

---

## 🤝 Beitragen

Contributions sind willkommen! Bitte:

1. Fork das Repository
2. Erstelle einen Feature-Branch (`git checkout -b feature/AmazingFeature`)
3. Commit deine Änderungen (`git commit -m 'Add some AmazingFeature'`)
4. Push zum Branch (`git push origin feature/AmazingFeature`)
5. Öffne einen Pull Request

---

## 📄 Lizenz

Dieses Projekt wird "wie es ist" bereitgestellt ohne jegliche Garantie. Die Nutzung erfolgt auf eigene Verantwortung.

---

## 👨‍💻 Autor

**deranderechris**  
GitHub: [@deranderechris](https://github.com/deranderechris)

---

## 🎉 Danksagung

- Microsoft für Windows 10
- Community-Feedback zu Windows-Optimierungen
- Inno Setup für das großartige Installer-Tool

---

**Viel Erfolg beim Optimieren! 🚀**

> **Tipp:** Teste die Änderungen erst an einem unwichtigen System oder in einer VM, bevor du sie auf deinem Hauptrechner anwendest!
