# vim: ft=dockerfile
#
# @package sshbox
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM alpine:latest

MAINTAINER Yannoff <https://github.com/yannoff>

ENV TERM=xterm-color

RUN \
    apk add --no-cache --update \
    bash \
    openssh-client \
    su-exec \
    curl \
    git \
    ; \
    mkdir -p /app/src; \
    mkdir -p /app/ssh; \
    echo 'while [ 1 -eq 1 ];do echo "Alive...";sleep 3600; done' > /keep-alive && chmod +x /keep-alive; \
    rm -rfv /var/cache/apk; \
    rm -rfv /usr/share/apk/keys;

COPY entrypoint.sh /usr/bin
VOLUME [ "/app/ssh" ]
ENTRYPOINT [ "entrypoint.sh" ]
