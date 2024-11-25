#!/bin/bash

# Mettre à jour les paquets existants
echo "Mise à jour des paquets..."
sudo apt update -y

# Installer OpenJDK
echo "Installation de OpenJDK..."
sudo apt install openjdk-11-jdk -y

# Vérifier l'installation de Java
if java -version; then
    echo "Java installé avec succès."
else
    echo "L'installation de Java a échoué."
    exit 1
fi

# Ajouter la clé et le dépôt de Jenkins
echo "Ajout du dépôt de Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

# Installer Jenkins
echo "Installation de Jenkins..."
sudo apt update -y
sudo apt install jenkins -y

# Démarrer Jenkins
echo "Démarrage de Jenkins..."
sudo systemctl start jenkins

# Activer Jenkins au démarrage
echo "Activation de Jenkins au démarrage..."
sudo systemctl enable jenkins

# Afficher le mot de passe initial
echo "Jenkins est installé et en cours d'exécution."
echo "Pour déverrouiller Jenkins, utilisez le mot de passe initial trouvé ici :"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Accéder à Jenkins
echo "Accédez à Jenkins via votre navigateur à l'adresse : http://localhost:8080"