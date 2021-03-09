#!/bin/bash

#Creación de la infraestructura de easy-rsa
mkdir /ac-patrick/easy-rsa
ln -s /usr/share/easy-rsa/* /ac-patrick/easy-rsa/
cd /ac-patrick/easy-rsa
bash easyrsa init-pki

#Creación de entidad certificadora
cp /ac-patrick/vars /ac-patrick/easy-rsa/vars
sed "3d" /usr/share/easy-rsa/openssl-easyrsa.cnf > /ac-patrick/easy-rsa/pki/openssl-easyrsa.cnf
ln -s /usr/share/easy-rsa/safessl-easyrsa.cnf /ac-patrick/easy-rsa/pki/safessl-easyrsa.cnf
bash easyrsa --batch --vars=vars build-ca nopass
chmod 700 /ac-patrick/easy-rsa

#Borrado de archivos de configuración
rm /ac-patrick/conf.sh
rm /ac-patrick/vars