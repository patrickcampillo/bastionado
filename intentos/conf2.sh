#!/bin/bash

#Instalación de paquetes
apt-get update -y
apt-get install apt-utils -y
apt-get install sudo -y
apt-get install easy-rsa -y

#Creación de usuario
#adduser patrick --disabled-password --gecos "" --ingroup sudo

#Posicionamiento en el home del usuario administrador de la AC
cd /home/patrick

#Creación de la infraestructura de easy-rsa
mkdir /home/patrick/easy-rsa
ln -s /usr/share/easy-rsa/* /home/patrick/easy-rsa/
chmod 700 /home/patrick/easy-rsa
cd /home/patrick/easy-rsa
bash easyrsa init-pki

#Creación de entidad certificadora
cp /vars /home/patrick/easy-rsa/
bash easyrsa build-ca nopass

#Borrado de archivos de configuración
rm /conf.sh
rm /vars