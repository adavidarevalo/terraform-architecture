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
wget https://www.free-css.com/assets/files/free-css-templates/download/page296/healet.zip

# Descomprime el archivo ZIP
unzip *.zip

# Elimina el archivo ZIP descargado
sudo rm -rf *.zip

# Borra el contenido del directorio HTML de Apache
sudo rm -rf /var/www/html/*

# Copia el contenido descomprimido al directorio HTML de Apache
sudo mkdir -p /var/www/html/app2 && sudo cp -r *-html/* /var/www/html/app2/


# Elimina el directorio temporal descomprimido
sudo rm -rf /tmp/*-html

# Reinicia el servicio Apache
sudo systemctl restart apache2
