FROM debian:latest

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid
ENV DEBIAN_FRONTEND=noninteractive



RUN apt-get update -y && apt-get install apt-utils sudo easy-rsa -y
RUN adduser patrick --disabled-password --gecos ""
COPY conf.sh /home/patrick/conf.sh
COPY vars /home/patrick/vars
RUN cd /home/patrick && bash conf.sh
RUN chown -R patrick.patrick /home/patrick
USER patrick
WORKDIR /home/patrick