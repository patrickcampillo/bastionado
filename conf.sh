#!/bin/bash

#Creación de la carpeta principal de easy-rsa.
mkdir /ac-patrick/easy-rsa

#Creación de enlaces simbólicos a los ficheros de configuración.
ln -s /usr/share/easy-rsa/* /ac-patrick/easy-rsa/

#Acceso a la carpeta y ejecución del comando de easyrsa que crea su estructura.
cd /ac-patrick/easy-rsa
bash easyrsa init-pki

#Copia de las variables de eas-rsa a su carpeta correspondiente.
mv /ac-patrick/vars /ac-patrick/easy-rsa/vars
mv /ac-patrick/entrypoint.sh /ac-patrick/easy-rsa/
#Copia del fichero de configuración, sin la 3a línea ya que esta produce un error.
sed "3d" /usr/share/easy-rsa/openssl-easyrsa.cnf > /ac-patrick/easy-rsa/pki/openssl-easyrsa.cnf

#Creación de un enlace simbólico a la carpeta correspondiente.
ln -s /usr/share/easy-rsa/safessl-easyrsa.cnf /ac-patrick/easy-rsa/pki/safessl-easyrsa.cnf

#Creación de la CA y securización de la carpeta de easy-rsa
bash easyrsa --batch --vars=vars build-ca nopass
chmod 700 /ac-patrick/easy-rsa

#Borrado del archivo que contiene el script y de las variables de la carpeta inicial.
rm /ac-patrick/conf.sh