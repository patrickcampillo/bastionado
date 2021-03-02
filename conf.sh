#!/bin/bash

#Inicio de sesión el adminitrador de la AC
su patrick
cd

#Creación de la infraestructura de easy-rsa
mkdir /home/patrick/easy-rsa
ln -s /usr/share/easy-rsa/* /home/patrick/easy-rsa/
chmod 700 /home/patrick/easy-rsa
cd /home/patrick/easy-rsa
bash easyrsa init-pki

#Creación de entidad certificadora
cp /home/patrick/vars /home/patrick/easy-rsa/vars
bash easyrsa build-ca nopass

#Borrado de archivos de configuración
rm /home/patrick/conf.sh
rm /home/patrick/vars