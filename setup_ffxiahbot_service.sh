#!/bin/bash

# Variables de configuration
USER="alexandre" # Remplacez par votre nom d'utilisateur si nécessaire
GROUP="alexandre"
BIN_DIR="/home/$USER/.local/bin"
WORKING_DIR="/home/$USER/ffxiahbot/bin"
SERVICE_FILE="/etc/systemd/system/ffxiahbot.service"

# Vérification des permissions (requiert sudo)
if [[ $EUID -ne 0 ]]; then
   echo "Ce script doit être exécuté avec sudo" 
   exit 1
fi

# Vérifier que le répertoire existe
if [ ! -d "$BIN_DIR" ]; then
    echo "Le répertoire $BIN_DIR n'existe pas. Veuillez installer uv et vérifier l'emplacement."
    exit 1
fi

# Créer le fichier de service systemd
echo "Création du fichier de service systemd pour FFXIAH Bot..."

cat <<EOL > $SERVICE_FILE
[Unit]
Description=FFXIAH Bot
After=network.target

[Service]
ExecStart=$BIN_DIR/uv run ffxiahbot broker
WorkingDirectory=$WORKING_DIR
Restart=always
User=$USER
Environment=PATH=$BIN_DIR:/usr/bin:/bin

[Install]
WantedBy=multi-user.target
EOL

# Recharger systemd pour appliquer les changements
echo "Rechargement de systemd..."
systemctl daemon-reload

# Activer et démarrer le service
echo "Activation et démarrage du service..."
systemctl enable ffxiahbot.service
systemctl start ffxiahbot.service

# Vérifier le statut du service
systemctl status ffxiahbot.service

echo "Le service FFXIAH Bot a été configuré avec succès."