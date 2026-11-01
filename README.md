# Konfiguracji VS Code do pisania skryptów w Bash

## 1. Plan i wymagane elementy

Do stworzenia kompletnego środowiska programistycznego w VS Code (dla skryptów uruchamianych na Raspberry Pi/Linux) potrzebne są:

1. **Pakiety systemowe CLI** (instalowane w systemie Linux/Raspberry Pi lub Windows):
   * `shfmt` – wymagany do działania wtyczki formatującej **`mkhl.shfmt`**.
   * `nodejs` – wymagany jako środowisko uruchomieniowe dla serwera językowego we wtyczce **`mads-hartmann.bash-ide-vscode`** (Bash IDE).
   * `shellcheck` – wymagany do działania wtyczki analizującej kod **`timonwong.shellcheck`**.

2. **Podstawowe ustawienia plikowe**:
   * Ustawienie końców linii w formacie Unix (LF).
   * Zabezpieczenie plików konfiguracyjnych i systemowych w Git (`.gitignore`).

3. **Rozszerzenia VS Code (w kolejności instalacji)**:
   * Formater: `mkhl.shfmt` (autor: mkhl) oraz pomocniczo `EditorConfig.EditorConfig` (autor: EditorConfig).
   * Wykrywanie błędów na żywo: `timonwong.shellcheck` (autor: Timon Wong).
   * Inteligentne podpowiedzi i nawigacja: `mads-hartmann.bash-ide-vscode` (autor: Mads Hartmann).
   * Transfer i połączenie ze środowiskiem zdalnym: `Natizyskunk.sftp` (autor: Natizyskunk).

## 2. Instalacja wtyczki Shfmt i opcjonalnie wtyczki EditorConfig

### 2.1 Instalacja pakietu shfmt
Aby wtyczka w VS Code mogła formatować kod, w systemie operacyjnym musi znajdować się zainstalowany program wykonywalny `shfmt`.

#### A. System Linux / Raspberry Pi / WSL
Otwórz terminal w systemie Linux i wykonaj po kolei polecenia:
```bash
sudo apt update
sudo apt install -y shfmt
```
Sprawdzenie lokalizacji zainstalowanego pliku:
```bash
which shfmt
```
*Oczekiwany wynik:* `/usr/bin/shfmt`

#### B. System Windows (gdy VS Code działa lokalnie na Windowsie)
Otwórz terminal PowerShell jako Administrator i wykonaj jedno z poniższych poleceń:
* **winget**: `winget install --id mvdan.shfmt`
* **Chocolatey**: `choco install shfmt`
* **Scoop**: `scoop install shfmt`

Sprawdzenie lokalizacji zainstalowanego pliku w systemie Windows:
```powershell
where.exe shfmt
```

### 2.2 Instalacja wtyczki shfmt i wtyczki EditorConfig
Otwórz panel rozszerzeń w VS Code (`Ctrl + Shift + X`) i zainstaluj wtyczki:
1. **`mkhl.shfmt`** (autor: mkhl) – rozszerzenie integrujące systemowy silnik `shfmt` z VS Code (wymagane).
2. **`EditorConfig.EditorConfig`** (autor: EditorConfig) – odpowiada za odczytywanie uniwersalnych zasad formatowania z pliku `.editorconfig` (opcjonalne).

### 2.3 Konfiguracja wtyczki shfmt i EditorConfig
🔗 **Dokumentacja wtyczki shfmt:** [GitHub - mkhl/vscode-shfmt](https://github.com/mkhl/vscode-shfmt)
🔗 **Strona domowa EditorConfig:** [editorconfig.org](https://editorconfig.org/)

#### A. Wskazanie domyślnego formatera
Najprostszym sposobem konfiguracji jest wymuszenie jej podczas pierwszego użycia:
1. Otwórz plik `.sh` i wciśnij **`Ctrl + Shift + I`** (lub `Shift + Alt + F`).
2. VS Code wyświetli komunikat z prośbą o wybór narzędzia do formatowania. Z listy wybierz **`mkhl.shfmt`**.
   *(Zostanie to zapisane w pliku konfiguracyjnym projektu - pełny widok pliku na końcu punktu 4).*

#### B. Utworzenie pliku `.editorconfig` (opcjonalnie)
W głównym katalogu projektu utwórz plik `.editorconfig`:
```ini
root = true

[*]
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.sh]
indent_style = space
indent_size = 4
```

### 2.4 Sprawdzenie działania wtyczek i korzyści z ich użycia
1. Wpisz nierówno sformatowaną linię kodu i wciśnij **`Ctrl + Shift + I`**.
2. **Wynik:** Kod zostanie natychmiast wyrównany z zachowaniem końców linii `LF` oraz wcięć na 4 spacje.
3. **Korzyści:** Przenośność reguł między edytorami w zespole, automatyczna spójność kodu i czysta historia w Git (brak błędów LF/CRLF).

## 3. Instalacja wtyczki ShellCheck

### 3.1 Instalacja pakietu shellcheck
#### A. System Linux / Raspberry Pi / WSL
```bash
sudo apt update
sudo apt install -y shellcheck
which shellcheck
```
*Oczekiwany wynik:* `/usr/bin/shellcheck`

#### B. System Windows
* **winget**: `winget install koalaman.shellcheck`
* **Chocolatey**: `choco install shellcheck`

### 3.2 Instalacja wtyczki shellcheck
Otwórz panel rozszerzeń w VS Code (`Ctrl + Shift + X`) i zainstaluj:
* **`timonwong.shellcheck`** (autor: Timon Wong)

### 3.3 Konfiguracja wtyczki shellcheck
🔗 **Strona domowa i opisy błędów:** [shellcheck.net](https://www.shellcheck.net/)
🔗 **Dokumentacja wtyczki:** [GitHub - vscode-shellcheck](https://github.com/vscode-shellcheck/vscode-shellcheck)

Wtyczka zazwyczaj działa od razu. Warto jednak jawnie aktywować analizę w locie (szczegóły w pliku `settings.json` na końcu punktu 4).

### 3.4 Sprawdzenie działania wtyczki i korzyści
1. Wklej kod z celowym błędem: `PLIK="nazwa.txt"; rm $PLIK`
2. **Wynik:** `$PLIK` zostanie podkreślony. Po najechaniu myszą zobaczysz kod **SC2086**.
3. **Korzyści:** Wyłapywanie błędów składniowych w locie, zapobieganie lukom w bezpieczeństwie i edukacja (podpowiedzi uczą dobrych praktyk w Bashu).

## 4. Instalacja wtyczki Bash IDE

### 4.1 Instalacja pakietu nodejs
#### A. System Linux / Raspberry Pi / WSL
```bash
sudo apt update
sudo apt install -y nodejs
node -v
```
#### B. System Windows
* **winget**: `winget install OpenJS.NodeJS`
* **Chocolatey**: `choco install nodejs`

### 4.2 Instalacja wtyczki Bash IDE
Otwórz panel rozszerzeń w VS Code (`Ctrl + Shift + X`) i zainstaluj:
* **`mads-hartmann.bash-ide-vscode`** (autor: Mads Hartmann)

### 4.3 Konfiguracja wtyczki Bash IDE
🔗 **Dokumentacja serwera językowego:** [GitHub - bash-language-server](https://github.com/bash-lsp/bash-language-server)

Aby zoptymalizować serwer językowy i podpowiedzi (np. limit analizy plików w tle), konfigurujemy odpowiednie zmienne w `settings.json` dla projektu (szczegóły poniżej).

### 4.4 Sprawdzenie działania wtyczki i korzyści
1. Utwórz funkcję i zacznij ją wywoływać linijkę niżej.
2. **Wynik:** Wyskoczy menu IntelliSense z podpowiedzią dokończenia nazwy.
3. **Korzyści:** Szybsze pisanie, błyskawiczna nawigacja po kodzie (Go to Definition pod `Ctrl + Klik`) i dostęp do dokumentacji (Hover).

### 4.5 Podział ustawień: Globalne vs Lokalne (Projektu)
Aby projekt wyglądał profesjonalnie na GitHubie i działał u każdego programisty, konieczne jest rozdzielenie prywatnych ustawień VS Code od ustawień wymuszanych w danym repozytorium.

#### A. Ustawienia Globalne (Twoje prywatne środowisko)
Te ustawienia zachowaj dla siebie (otworzysz je przez `Ctrl + Shift + P` -> `Preferences: Open User Settings (JSON)`). Zapisują się one w Twoim systemie (np. `~/.config/Code/User/settings.json`) i zależą od Twoich subskrypcji oraz specyficznych ścieżek instalacji. **Nie umieszczaj ich w repozytorium projektu.**

```json
{
    "github.copilot.enable": {
        "*": true,
        "plaintext": false,
        "markdown": false,
        "scminput": false,
        "jsonc": false
    },
    "github.copilot.nextEditSuggestions.enabled": true,

    "shellformat.path": "/usr/bin/shfmt",

    "settingsSync.ignoredSettings": [
        "shellcheck.enable"
    ]
}
```

#### B. Ustawienia Projektu (Dołączane do repozytorium GitHub)
Te ustawienia lądują w pliku **`.vscode/settings.json`** wewnątrz folderu Twojego projektu. Będą współdzielone z każdym, kto pobierze kod. Gwarantują one, że inni członkowie zespołu będą mieli narzucony ten sam formater i znormalizowane końcówki linii.

```json
{
    "[shellscript]": {
        "editor.defaultFormatter": "mkhl.shfmt"
    },

    "shellcheck.enable": true,
    "shellcheck.run": "onType",

    "bashIDE.backgroundAnalysisMaxFiles": 500,
    "bashIDE.enableSourceErrorDiagnostics": true,
    "bashIDE.explanationSymbolMandatory": false,

    "files.eol": "\n"
}
```

## 5. Instalacja i konfiguracja wtyczki SFTP

### 5.1 Wymagania po stronie serwera
Raspberry Pi (lub serwer Linux) musi mieć działającą usługę SSH.

### 5.2 Instalacja wtyczki SFTP
W panelu rozszerzeń VS Code (`Ctrl + Shift + X`) wyszukaj i zainstaluj:
* **`Natizyskunk.sftp`** (autor: Natizyskunk)

### 5.3 Konfiguracja środowiska (sftp.json)
🔗 **Dokumentacja i Wiki wtyczki SFTP:** [GitHub - vscode-sftp](https://github.com/Natizyskunk/vscode-sftp/wiki)

Wtyczka SFTP wymaga utworzenia własnego pliku konfiguracyjnego.
#### A. Konfiguracja połączenia (.vscode/sftp.json)
Wciśnij **`Ctrl + Shift + P`** -> wpisz `SFTP: Config`. Wygenerowany plik skonfiguruj następująco:

```json
{
    "name": "RaspberryPi",
    "host": "WSTAW_IP_SERWERA",
    "protocol": "sftp",
    "port": 22,
    "username": "USERNAME",
    "password": "PASSWORD",
    "remotePath": "/home/USERNAME/scripts",
    "uploadOnSave": false,
    "useTempFile": true,
    "openSsh": false,
    "ignore": [
        "**/*",
        "!**/*.sh"
    ]
}
```
*Uwaga do uprawnień wykonywania skryptów: Wtyczka SFTP ma trudności z automatycznym przydzielaniem `chmod +x` w locie (szczególnie przy włączonej opcji `useTempFile`). Zaleca się ręczne nadanie uprawnień do katalogu docelowego na serwerze, wyłączenie flagi `useTempFile` lub uruchamianie skryptów bezpośrednio przez interpreter: `bash skrypt.sh`.*

#### B. Zabezpieczenie w Git
Aby dane dostępowe (hasło i adres IP) nie wyciekły do publicznego repozytorium GitHub, koniecznie zignoruj plik SFTP. W głównym folderze projektu utwórz/edytuj plik **`.gitignore`** i dodaj:

```gitignore
.vscode/sftp.json
```

### 5.4 Sprawdzenie działania wtyczki
1. Kliknij na dowolny skrypt `.sh` prawym przyciskiem myszy w drzewie plików i wybierz **`Upload`**.
2. **Wynik:** Plik skryptu trafi bezpiecznie na zdalny serwer do podanej lokalizacji, podczas gdy wszystkie inne pliki z folderu zostaną zignorowane.
