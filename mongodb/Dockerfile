# vim: ft=Dockerfile
#
# @package mongo
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM alpine:3.9

MAINTAINER yannoff <https://github.com/yannoff>

RUN \
# Retrieve MongoDB's official entrypoint from github
    apk --no-cache add --virtual build-deps curl git && \
    curl https://raw.githubusercontent.com/docker-library/mongo/6e4f9aebd519141a0f8dffbdb2a9502e668c3bd7/4.0/docker-entrypoint.sh -o usr/local/bin/docker-entrypoint.sh && \
    chmod +x usr/local/bin/docker-entrypoint.sh && \
    # backwards compat
    ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh && \
# Install needed packages
    apk add --no-cache \
        bash \
#        mongodb \
        su-exec \
        build-base \
        musl-dev \
        xz-dev openssl-dev gcc curl-dev python3-dev libressl-dev py3-pip make \
        && \
    ln -s $(which su-exec) /bin/gosu && \
# Remove unused packages & APK indexes
    apk --no-cache del build-deps &&  \
    rm -rfv /var/cache/apk/* && \
# Create & expose MongoDB storage dirs
    mkdir -p /data/db /data/configdb && \
    chown -R mongodb:mongodb /data/db /data/configdb

RUN \
    cd /tmp && \
    git clone https://github.com/mongodb/mongo.git && \
    cd mongo && \
    python3 -m pip install -r etc/pip/compile-requirements.txt;

RUN \
    python3 buildscripts/scons.py DESTDIR=/opt/mongo install-mongod

VOLUME /data/db /data/configdb

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
