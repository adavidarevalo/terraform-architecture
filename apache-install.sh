#!/bin/bash

# Actualiza la lista de paquetes
sudo apt update -y 

# Instala Apache, wget y unzip
sudo apt install -y apache2 wget unzip

# Inicia el servicio Apache
sudo systemctl start apache2 

# Habilita Apache para que se inicie en el arranque
sudo systemctl enable apache2 

# Cambia al directorio /tmp
cd /tmp

# Descarga el archivo ZIP del sitio web
wget https://www.free-css.com/assets/files/free-css-templates/download/page296/neogym.zip

# Descomprime el archivo ZIP
unzip neogym.zip

# Elimina el archivo ZIP descargado
sudo rm -rf neogym.zip

# Borra el contenido del directorio HTML de Apache
sudo rm -rf /var/www/html/*

# Copia el contenido descomprimido al directorio HTML de Apache
sudo cp -r neogym-html/* /var/www/html/

# Elimina el directorio temporal descomprimido
sudo rm -rf /tmp/neogym-html

# Reinicia el servicio Apache
sudo systemctl restart apache2
