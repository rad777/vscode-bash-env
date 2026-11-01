#!/usr/bin/env bash
#
# Przykładowy skrypt demonstrujący działanie środowiska.
# Zawiera poprawne formatowanie i jest w 100% zgodny z ShellCheck.

# Zatrzymanie skryptu w przypadku błędu (dobra praktyka)
set -euo pipefail

# Deklaracja zmiennych (zawsze używaj podwójnych cudzysłowów przy wywoływaniu!)
GREETING="Witaj w skonfigurowanym środowisku Bash!"
TARGET_DIR="/tmp/bash_demo"

# Funkcja pokazująca autouzupełnianie w Bash IDE
setup_environment() {
    local dir_path="$1"
    
    if [[ ! -d "$dir_path" ]]; then
        echo "Tworzenie katalogu: $dir_path"
        mkdir -p "$dir_path"
    else
        echo "Katalog $dir_path już istnieje."
    fi
}

main() {
    echo "$GREETING"
    setup_environment "$TARGET_DIR"
    
    # Przetestuj formater: zepsuj wcięcia poniżej i naciśnij Shift+Alt+F
    for i in {1..3}; do
        echo "Testowanie synchronizacji SFTP - plik nr $i" > "${TARGET_DIR}/test_${i}.txt"
    done
    
    echo "Operacja zakończona sukcesem."
}

# Wywołanie głównej funkcji
main