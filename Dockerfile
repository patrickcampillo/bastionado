FROM debian:latest

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && apt-get install apt-utils sudo easy-rsa -y
RUN adduser patrick --disabled-password --gecos ""
RUN mkdir /certs
RUN mkdir /ac-patrick

COPY conf.sh /ac-patrick/conf.sh
COPY vars /ac-patrick/vars

RUN cd /ac-patrick && bash conf.sh
RUN cp /ac-patrick/easy-rsa/pki/ca.crt /certs/ca.crt
WORKDIR /ac-patrick/easy-rsa