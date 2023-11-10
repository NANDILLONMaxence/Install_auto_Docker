# Rapport d'Erreurs dans les Sources APT

W: La cible Packages (stable/binary-amd64/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Packages (stable/binary-all/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr_FR) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
Tous les paquets sont à jour.
W: La cible Packages (stable/binary-amd64/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Packages (stable/binary-all/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr_FR) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-en) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Packages (stable/binary-amd64/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Packages (stable/binary-all/Packages) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr_FR) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-fr) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/sources.list.d/docker.list:1
W: La cible Translations (stable/i18n/Translation-en) est spécifiée plusieurs fois dans /etc/apt/sources.list:21 et /etc/apt/source

## Problème Identifié

Lors de l'exécution de la commande `sudo apt update`, plusieurs avertissements ont été générés, indiquant que certaines cibles dans les fichiers de sources sont spécifiées plusieurs fois. Les erreurs comprennent des duplications dans les cibles Packages (stable/binary-amd64/Packages, stable/binary-all/Packages) et Translations (stable/i18n/Translation-fr_FR, stable/i18n/Translation-fr, stable/i18n/Translation-en).
Cela est dû à l'ajout des dépôts APT dans l'installation de Docker.

## Localisation des Erreurs

Les duplicatas ont été détectés dans les fichiers `/etc/apt/sources.list` à la ligne 21 et dans le fichier `/etc/apt/sources.list.d/docker.list` à la ligne 1.

## Actions Recommandées

1. **Correction dans /etc/apt/sources.list :**
   - Utiliser la commande suivante pour ajouter un '#' à la ligne 21 de `/etc/apt/sources.list` :
     ```bash
     sudo sed -i '21s/^/#/' /etc/apt/sources.list
     ```
   - Cela commentera la ligne 21, résolvant ainsi la duplication des cibles.

2. **Correction dans /etc/apt/sources.list.d/docker.list :**
   - Utiliser la commande suivante pour ajouter un '#' à la ligne 1 de `/etc/apt/sources.list.d/docker.list` :
     ```bash
     sudo sed -i '1s/^/#/' /etc/apt/sources.list.d/docker.list
     ```
   - Cela commentera la première ligne du fichier, éliminant la duplication des cibles.

3. **Mise à Jour des Sources :**
   - Après les corrections, exécuter la commande suivante pour mettre à jour la liste des paquets :
     ```bash
     sudo apt update
     ```
   - Cela garantit que les modifications sont prises en compte.

*Ces actions devraient résoudre les erreurs détectées lors de la mise à jour du système.*

Veuillez noter que ces commandes modifient directement les fichiers système. Assurez-vous d'avoir une sauvegarde appropriée avant de les exécuter.
