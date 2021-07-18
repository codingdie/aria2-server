FROM nginx:1.21.1

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Shanghai

USER root

WORKDIR /root

RUN  apt update

RUN apt install -y aria2 procps 

ADD nginx.conf /etc/nginx/nginx.conf

ADD www /root/www

ADD start.sh  /root/start.sh

RUN chmod +x  /root/start.sh

RUN ls -all /root/www

ENV ARIA2_HOST 192.168.31.12

ENV ARIA2_PORT 6800

ENV ARIA2_SECRET default

ADD aria2.conf /root/aria2.conf

ENTRYPOINT ["/bin/bash", "/root/start.sh"]

