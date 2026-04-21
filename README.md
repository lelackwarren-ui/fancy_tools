# Creation_Outil_Installation_Shell

# Fancy Tools — Projet Complet

## Structure du projet

```bash
fancy_tools/
├── .aliases
├── fancy_functions.sh
├── install.sh
├── bin/
│   └── updateFancyTools
└── README.md
```

---

## `.aliases`

```bash
alias gs='git status'
alias ga='git add .'
alias gc='git commit'
alias ll='ls -la'
```

---

## `fancy_functions.sh`

```bash
gco() {
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 || {
        echo "Erreur : ce répertoire n'est pas un dépôt Git."
        return 1
    }

    [ -z "$1" ] && {
        echo "Usage : gco 'message_du_commit'"
        return 1
    }

    branch=$(git branch --show-current)
    [ -z "$branch" ] && {
        echo "Erreur : impossible de récupérer la branche."
        return 1
    }

    git commit -m "[$branch] $*"
}
```

---

## `install.sh`

```bash
#!/bin/bash
set -e

REPO_URL="https://github.com/<votre_login>/fancy_tools.git"
SRC_DIR="$HOME/src/fancy_tools"
BASHRC="$HOME/.bashrc"

add_if_missing() {
    grep -qxF "$1" "$BASHRC" || echo "$1" >> "$BASHRC"
}

[ -f "$BASHRC" ] && cp "$BASHRC" "$HOME/.bashrc.bak.$(date +%Y%m%d_%H%M%S)"
mkdir -p "$HOME/src"

if [ ! -d "$SRC_DIR" ]; then
    git clone "$REPO_URL" "$SRC_DIR"
fi

add_if_missing 'export PATH="$HOME/bin:$PATH"'
add_if_missing "[ -f $SRC_DIR/.aliases ] && source $SRC_DIR/.aliases"
add_if_missing "[ -f $SRC_DIR/fancy_functions.sh ] && source $SRC_DIR/fancy_functions.sh"

echo "Installation terminée. Lance : source ~/.bashrc"
```

---

## `bin/updateFancyTools`

```bash
#!/bin/bash
set -e

SRC_DIR="$HOME/src/fancy_tools"
BIN_DIR="$HOME/bin"

[ ! -d "$SRC_DIR" ] && {
    echo "Fancy Tools non installé."
    exit 1
}

cd "$SRC_DIR"
branch=$(git branch --show-current)

[ "$branch" != "main" ] && {
    echo "Passez sur la branche main."
    exit 1
}

git pull
mkdir -p "$BIN_DIR"
cp "$SRC_DIR/bin/updateFancyTools" "$BIN_DIR/updateFancyTools"
chmod +x "$BIN_DIR/updateFancyTools"

echo "Mise à jour terminée."
```

---

## Utilisation

```bash
git clone https://github.com/<votre_login>/fancy_tools.git
cd fancy_tools
chmod +x install.sh
./install.sh
source ~/.bashrc
```

### Commandes utiles

```bash
gco "ajout fonctionnalité"
updateFancyTools
gs
ga
gc
ll
```
