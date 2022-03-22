# vim: ft=Dockerfile
#
# @package phpma
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

ARG VERSION=5.1.3

FROM phpmyadmin:${VERSION}-fpm-alpine

COPY docker-entrypoint.patch /docker-entrypoint.patch

RUN \
    apk add --no-cache --virtual .build-deps patch && \
    patch /docker-entrypoint.sh /docker-entrypoint.patch && \
    apk del --no-cache .build-deps

CMD [ "php", "-S", "0.0.0.0:80", "-t", "/var/www/html" ]
