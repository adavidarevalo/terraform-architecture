#!/bin/bash

# Actualiza la lista de paquetes
sudo apt update -y &&

# Instala Apache
sudo apt install -y apache2 &&

# Inicia el servicio Apache
sudo systemctl start apache2 &&

# Habilita Apache para que se inicie en el arranque
sudo systemctl enable apache2 &&

# Crea una página HTML con "Hola Mundo" y limita permisos
echo "Hola Mundo" | sudo tee /var/www/html/index.html > /dev/null &&
sudo chmod 644 /var/www/html/index.html
