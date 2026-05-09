# Fancy Tools

## Description du projet

Fancy Tools est un ensemble de scripts Bash permettant d'améliorer l'utilisation du terminal et de Git.

Le projet automatise :

* l'ajout d'alias utiles
* des fonctions personnalisées Bash
* l'installation rapide sur une nouvelle machine
* la mise à jour automatique depuis GitHub

Objectif : gagner du temps et standardiser un environnement de développement.

---

## Prérequis

### Système d'exploitation

* Linux
* WSL (Windows Subsystem for Linux, Machine virtuelle)

### Outils nécessaires

* Bash
* Git
* Connexion Internet
* Terminal

### Vérification

```bash
bash --version
git --version
```

---

## Installation

### 1. Cloner le dépôt

```bash
git clone https://github.com/lelackwarren-ui/fancy_tools.git
```

### 2. Entrer dans le dossier

```bash
cd fancy_tools
```

### 3. Donner les permissions

```bash
chmod +x install.sh
chmod +x bin/updateFancyTools
```

### 4. Lancer l'installation

```bash
./install.sh
```

### 5. Recharger Bash

```bash
source ~/.bashrc
```

---

## Utilisation

### Alias disponibles

```bash
gss    # git status
gpl    # git pull
gpu    # git push
gap    # git add .
gc    # git commit
ll    # ls -la
```

---

### Fonction personnalisée : gco

Permet de commit automatiquement avec le nom de branche.

```bash
gco "ajout page accueil"
```

Résultat :

```bash
git commit -m "[dev] ajout page accueil"
```

---

### Mise à jour du projet

```bash
updateFancyTools
```

Cette commande :

* se place dans le dépôt
* vérifie la branche main
* effectue un git pull
* met à jour le script dans ~/bin

---

## Structure du projet

```bash
fancy_tools/
├── .aliases                # Alias Bash personnalisés
├── fancy_functions.sh      # Fonctions shell avancées
├── install.sh              # Installation automatique
├── bin/
│   └── updateFancyTools    # Script de mise à jour
└── README.md               # Documentation
```
## Bonus 
  Voici un petit bonus, ce bonus permet d'afficher la branche où vous vous situé dans votre projet git.
```bash
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_status_color() {
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
            echo -e "\033[1;31m"  # Rouge si modifications
        else
            echo -e "\033[1;36m"  # Vert si propre
        fi
    else
        echo -e "\033[1;32m"
    fi
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(git_status_color)$(parse_git_branch)\[\033[00m\]\$ '
```

---

## Auteur

Projet réalisé par LELACK Warren Kenji

---

## Licence

Projet pédagogique.
