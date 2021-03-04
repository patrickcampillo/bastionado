#!/bin/bash

#Creación de la infraestructura de easy-rsa
mkdir /home/patrick/easy-rsa
ln -s /usr/share/easy-rsa/* /home/patrick/easy-rsa/
cd /home/patrick/easy-rsa
bash easyrsa init-pki

#Creación de entidad certificadora
cp /home/patrick/vars /home/patrick/easy-rsa/vars
sed "3d" /usr/share/easy-rsa/openssl-easyrsa.cnf > /home/patrick/easy-rsa/pki/openssl-easyrsa.cnf
ln -s /usr/share/easy-rsa/safessl-easyrsa.cnf /home/patrick/easy-rsa/pki/safessl-easyrsa.cnf
bash easyrsa --batch build-ca nopass
chmod 700 /home/patrick/easy-rsa

#Borrado de archivos de configuración
rm /home/patrick/conf.sh
rm /home/patrick/vars