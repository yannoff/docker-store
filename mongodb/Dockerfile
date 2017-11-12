# vim: ft=Dockerfile
#
# @package mongo
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM alpine:latest

MAINTAINER yannoff <https://github.com/yannoff>

# Retrieve MongoDB's official entrypoint from github
RUN \
    apk --no-cache add curl; \
    curl https://raw.githubusercontent.com/docker-library/mongo/master/3.0/docker-entrypoint.sh -o usr/local/bin/docker-entrypoint.sh; \
    chmod +x usr/local/bin/docker-entrypoint.sh; \
    ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

# Install needed packages
RUN \
    apk add --no-cache \
        bash \
        mongodb \
        su-exec; \
    ln -s $(which su-exec) /bin/gosu

# Remove unused packages & APK indexes
RUN \
    apk --no-cache del curl; \
    rm -rfv /var/cache/apk/*

# Create & expose MongoDB storage dirs
RUN mkdir -p /data/db /data/configdb \
    && chown -R mongodb:mongodb /data/db /data/configdb

VOLUME /data/db /data/configdb


ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
