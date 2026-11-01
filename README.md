# Konfiguracja VS Code do pisania skryptów w Bash-u

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

```
sudo apt update
sudo apt install -y shfmt

```

Sprawdzenie lokalizacji zainstalowanego pliku:

```
which shfmt

```

*Oczekiwany wynik:* `/usr/bin/shfmt`

#### B. System Windows (gdy VS Code działa lokalnie na Windowsie)

Otwórz terminal PowerShell jako Administrator i wykonaj jedno z poniższych poleceń:

* **winget**: `winget install --id mvdan.shfmt`

* **Chocolatey**: `choco install shfmt`

* **Scoop**: `scoop install shfmt`

Sprawdzenie lokalizacji zainstalowanego pliku w systemie Windows:

```
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
   *(Zostanie to zapisane w pliku settings.json - pełny widok pliku na końcu punktu 4).*

#### B. Utworzenie pliku `.editorconfig` (opcjonalnie)

W głównym katalogu projektu utwórz plik `.editorconfig`:

```
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

```
sudo apt update
sudo apt install -y shellcheck
which shellcheck

```

*Oczekiwany wynik:* `/usr/bin/shellcheck`

#### B. System Windows

* **winget**: `winget install koalaman.shellcheck`

* **Chocolatey**: `choco install shellcheck`

```
where.exe shellcheck

```

### 3.2 Instalacja wtyczki shellcheck

Otwórz panel rozszerzeń w VS Code (`Ctrl + Shift + X`) i zainstaluj:

* **`timonwong.shellcheck`** (autor: Timon Wong)

### 3.3 Konfiguracja wtyczki shellcheck

🔗 **Strona domowa i opisy błędów:** [shellcheck.net](https://www.shellcheck.net/)
🔗 **Dokumentacja wtyczki:** [GitHub - vscode-shellcheck](https://github.com/vscode-shellcheck/vscode-shellcheck)

Wtyczka zazwyczaj działa od razu. Warto jednak jawnie aktywować analizę w locie i wykluczyć ustawienie z synchronizacji (szczegóły w pliku `settings.json` na końcu punktu 4).

### 3.4 Sprawdzenie działania wtyczki i korzyści

1. Wklej kod z celowym błędem: `PLIK="nazwa.txt"; rm $PLIK`

2. **Wynik:** `$PLIK` zostanie podkreślony. Po najechaniu myszą zobaczysz kod **SC2086**.

3. **Korzyści:** Wyłapywanie błędów składniowych w locie, zapobieganie lukom w bezpieczeństwie i edukacja (podpowiedzi uczą dobrych praktyk w Bashu).

4. **Ignorowanie reguły (opcjonalnie):**

```
# shellcheck disable=SC2086
rm $PLIK

```

## 4. Instalacja wtyczki Bash IDE

### 4.1 Instalacja pakietu nodejs

#### A. System Linux / Raspberry Pi / WSL

```
sudo apt update
sudo apt install -y nodejs
node -v

```

#### B. System Windows

* **winget**: `winget install OpenJS.NodeJS`

* **Chocolatey**: `choco install nodejs`

```
node -v

```

### 4.2 Instalacja wtyczki Bash IDE

Otwórz panel rozszerzeń w VS Code (`Ctrl + Shift + X`) i zainstaluj:

* **`mads-hartmann.bash-ide-vscode`** (autor: Mads Hartmann)

### 4.3 Konfiguracja wtyczki Bash IDE

🔗 **Dokumentacja serwera językowego:** [GitHub - bash-language-server](https://github.com/bash-lsp/bash-language-server)

Aby zoptymalizować serwer językowy i podpowiedzi (np. limit analizy plików w tle), konfigurujemy odpowiednie zmienne w `settings.json` (szczegóły poniżej).

### 4.4 Sprawdzenie działania wtyczki i korzyści

1. Utwórz funkcję i zacznij ją wywoływać linijkę niżej.

2. **Wynik:** Wyskoczy menu IntelliSense z podpowiedzią dokończenia nazwy. Najechanie na komendy wbudowane (np. `echo`) pokazuje ich dokumentację.

3. **Korzyści:** Szybsze pisanie (autouzupełnianie), błyskawiczna nawigacja po kodzie (Go to Definition pod `Ctrl + Klik`) i dostęp do dokumentacji (Hover) bez przełączania się do terminala (man).

### 4.5 Finalny, kompletny wygląd pliku settings.json

Łącząc konfigurację `shfmt`, `shellcheck`, `Bash IDE` oraz Twoje integracje z GitHub Copilot, Twój ostateczny plik **`settings.json`** (`Ctrl + Shift + P` -> `Preferences: Open User Settings (JSON)`) powinien wyglądać dokładnie tak:

```
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
    "[shellscript]": {
        "editor.defaultFormatter": "mkhl.shfmt"
    },
    
    "shellcheck.enable": true,
    "shellcheck.run": "onType",
    
    "bashIDE.backgroundAnalysisMaxFiles": 500,
    "bashIDE.enableSourceErrorDiagnostics": true,
    "bashIDE.explanationSymbolMandatory": false,
    
    "settingsSync.ignoredSettings": [
        "shellcheck.enable"
    ]
}

```

## 5. Instalacja i konfiguracja wtyczki SFTP

### 5.1 Wymagania po stronie serwera

Raspberry Pi (lub serwer Linux) musi mieć działającą usługę SSH. Jest ona domyślnie zainstalowana, wymaga jedynie włączenia (np. przez `raspi-config`).

### 5.2 Instalacja wtyczki SFTP

W panelu rozszerzeń VS Code (`Ctrl + Shift + X`) wyszukaj i zainstaluj:

* **`Natizyskunk.sftp`** (autor: Natizyskunk)

### 5.3 Konfiguracja środowiska (sftp.json)

🔗 **Dokumentacja i Wiki wtyczki SFTP:** [GitHub - vscode-sftp](https://github.com/Natizyskunk/vscode-sftp/wiki)

Wtyczka SFTP do działania wymaga utworzenia własnego pliku konfiguracyjnego w folderze projektu. **Nie modyfikuje ona ani nie wykorzystuje głównego pliku `settings.json`.**

#### A. Konfiguracja połączenia (.vscode/sftp.json)

Wciśnij **`Ctrl + Shift + P`** -> wpisz `SFTP: Config`. Wygenerowany plik skonfiguruj następująco:

```
{
    "name": "RaspberryPi",
    "host": "WSTAW_IP_SERWERA",
    "protocol": "sftp",
    "port": 22,
    "username": "WSTAW_NAZWE_UZYTKOWNIKA",
    "remotePath": "WSTAW_SCIEZKE_DO_KATALOGU",
    "uploadOnSave": false,
    "useTempFile": false,
    "openSsh": false,
    "ignore": [
        "**/*",
        "!**/*.sh"
    ]
}

```
*Uwaga do sekcji `ignore`: Zastosowaliśmy tu logikę wykluczenia (negacji). Wpis `"**/*"` ignoruje absolutnie wszystkie pliki i foldery, natomiast wykrzyknik w `"!**/*.sh"` tworzy od tej reguły wyjątek – dzięki temu na serwer zostaną wysłane wyłącznie skrypty `.sh`.*

#### B. Zabezpieczenie w Git

Zabezpiecz plik `sftp.json` przed wysłaniem do repozytorium Git. W głównym folderze projektu dodaj do pliku **`.gitignore`**:

```
.vscode/

```

### 5.4 Sprawdzenie działania wtyczki i korzyści z jej użycia

1. Kliknij na dowolny skrypt `.sh` prawym przyciskiem myszy w drzewie plików i wybierz **`Upload`**.

2. **Wynik:** Plik trafi na zdalny serwer (do podanej `remotePath`) z automatycznie nadanymi uprawnieniami do wykonywania (dzięki fladze `"chmod": "0755"`). Natomiast próba wysłania pliku o innym rozszerzeniu zostanie zignorowana.

3. **Korzyści:** Bezpieczny proces deploymentu, pełna kontrola nad momentem wysyłki i oszczędność czasu na ręcznym wpisywaniu `chmod +x` w terminalu na serwerze, a także gwarancja, że na serwer trafią tylko skrypty powłoki.
