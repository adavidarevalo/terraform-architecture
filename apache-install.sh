#!/bin/bash
# Actualiza la lista de paquetes
yum update -y

# Instala Apache
yum install -y httpd

# Inicia el servicio Apache
systemctl start httpd

# Habilita Apache para que se inicie en el arranque
systemctl enable httpd

# Crea una página HTML con "Hola Mundo"
echo "Hola Mundo" > /var/www/html/index.html
