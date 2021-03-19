#Seleccionar la imagen en la que basaremos el contenedor.
FROM debian:latest

#Establecer las variables de entorno.
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

#Instalar los paquetes necesarios, creación del usuario, y creación de carpetas.
RUN apt-get update -y -qq >/dev/null && apt-get install -y apt-utils easy-rsa >/dev/null && adduser patrick --disabled-password --gecos "" && mkdir /certs /ac-patrick

#Copia de los ficheros necesarios.
COPY conf.sh vars entrypoint.sh /ac-patrick/

#Ejecución del script de configuración.
RUN cd /ac-patrick && bash conf.sh && cp /ac-patrick/easy-rsa/pki/ca.crt /certs/ca.crt

#Establecimiento del directorio en el que se lanzará el Docker.
WORKDIR /ac-patrick/easy-rsa

#Establecer el entrypoint y los comandos que realizará.
ENTRYPOINT ["./entrypoint.sh"]
CMD $1 $2