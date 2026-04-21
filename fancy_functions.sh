#!/bin/bash

# fancy_functions.sh

gco() {
    # Vérifier que l'on est dans un dépôt Git
    git rev-parse --is-inside-work-tree >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Erreur : ce répertoire n'est pas un dépôt Git."
        return 1
    fi

    # Vérifier qu'un message a été fourni
    if [ -z "$1" ]; then
        echo "Usage : gco 'message_du_commit'"
        return 1
    fi

    # Récupérer le nom de la branche courante
    branch=$(git branch --show-current)

    # Vérifier si une branche a été trouvée
    if [ -z "$branch" ]; then
        echo "Erreur : impossible de récupérer le nom de la branche."
        return 1
    fi

    # Construire le message formaté
    message="[$branch] $*"

    # Effectuer le commit
    git commit -m "$message"
}
