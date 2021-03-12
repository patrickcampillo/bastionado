#Seleccionar la imagen en la que basaremos el contenedor.
FROM debian:latest

#Establecer las variables de entorno.
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

#Instalar los paquetes necesarios
RUN apt-get update -y && apt-get install apt-utils easy-rsa -y

#Creación de un usuario, mediante el cual se pasarán los certificados sin ser de root.
RUN adduser patrick --disabled-password --gecos ""

#Creación de la carpeta que almacenará la clave pública de la CA.
RUN mkdir /certs

#Creación de la carpeta que almacenará la estructura de easy-rsa.
RUN mkdir /ac-patrick

#Copia del script que configurará easy-rsa.
COPY conf.sh /ac-patrick/conf.sh

#Copia de las variables que se le pasarán a easy-rsa.
COPY vars /ac-patrick/vars

#Ejecución del script de configuración.
RUN cd /ac-patrick && bash conf.sh

#Copia y cambio del permiso de ejecución del script que realizará la función de entrypoint.
COPY entrypoint.sh /ac-patrick/easy-rsa/entrypoint.sh 
RUN chmod +x /ac-patrick/easy-rsa/entrypoint.sh

#Copia de la clave pública de la CA a la carpeta correspondiente.
RUN cp /ac-patrick/easy-rsa/pki/ca.crt /certs/ca.crt

#Establecimiento del directorio en el que se lanzará el Docker.
WORKDIR /ac-patrick/easy-rsa