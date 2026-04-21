#!/bin/bash
set -e

REPO_URL="https://github.com/lelackwarren-ui/Creation_Outil_Installation_Shell.git"
SRC_DIR="$HOME/src/Creation_Outil_Installation_Shell"
BASHRC="$HOME/.bashrc"

# Fonction : ajoute une ligne si absente
add_if_missing() {
    grep -qxF "$1" "$BASHRC" || echo "$1" >> "$BASHRC"
}

echo "Installation Fancy Tools..."

# 1. Sauvegarde de .bashrc avec horodatage
if [ -f "$BASHRC" ]; then
    cp "$BASHRC" "$HOME/.bashrc.bak.$(date +%Y%m%d_%H%M%S)"
    echo "Sauvegarde de .bashrc effectuée."
fi

# 2. Création dossier ~/src si absent
mkdir -p "$HOME/src"

# 3. Cloner le dépôt si absent
if [ ! -d "$SRC_DIR" ]; then
    git clone "$REPO_URL" "$SRC_DIR"
    echo "Dépôt cloné dans $SRC_DIR"
else
    echo "Dépôt déjà présent."
fi

# 4. Ajouter ~/bin au PATH
add_if_missing 'export PATH="$HOME/bin:$PATH"'

# 5. Sourcer .aliases
add_if_missing "[ -f $SRC_DIR/.aliases ] && source $SRC_DIR/.aliases"

# 6. Sourcer fancy_functions.sh
add_if_missing "[ -f $SRC_DIR/fancy_functions.sh ] && source $SRC_DIR/fancy_functions.sh"

echo "Configuration terminée."
echo "Recharge avec : source ~/.bashrc"
