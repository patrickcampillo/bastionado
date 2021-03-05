FROM debian:latest

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive


VOLUME ["/tmp/certs", "/tmp/certs"]
RUN apt-get update -y && apt-get install apt-utils sudo easy-rsa -y
RUN mkdir /ac-patrick
#RUN adduser patrick --disabled-password --gecos ""
COPY conf.sh /ac-patrick/conf.sh
COPY vars /ac-patrick/vars
RUN cd /ac-patrick && bash conf.sh
#RUN chown -R patrick.patrick /home/patrick
#USER patrick
WORKDIR /ac-patrick/easy-rsa