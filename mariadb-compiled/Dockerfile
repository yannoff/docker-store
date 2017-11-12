# vim: ft=Dockerfile
FROM alpine:latest
MAINTAINER Yannoff <https://github.com/yannoff>

RUN \
    apk --update --no-cache add curl bash;

# FOR MariaDB build:
RUN \
    apk add git g++ make cmake bison ncurses-dev libevent-dev openssl-dev libexecinfo-dev gnutls linux-headers; \
    apk add libssl1.0 libstdc++; \
    tmpdir=`mktemp -d` && cd $tmpdir; \
    git clone https://github.com/MariaDB/server.git source; \
    cd source && git checkout 10.1 && cd -; \
    mkdir build && cd build; \
    cmake -DPLUGIN_TOKUDB=NO ../source; \
    make && make install; \
    cd /; \
    rm -rf $tmpdir; 
#Post-install
RUN \
    addgroup -S mysql; \
    adduser -S -D -h /var/lib/mysql -s /sbin/nologin -G mysql -g mysql mysql; \
    chown -R mysql /usr/local/mysql/; \
    cd /usr/local/mysql/; \
    scripts/mysql_install_db --user=mysql; \
    /usr/local/mysql/bin/mysqld_safe --user=mysql &
# End build

RUN \
    curl https://raw.githubusercontent.com/docker-library/mariadb/master/10.1/docker-entrypoint.sh -o /docker-entrypoint.sh; \
    chmod +x /docker-entrypoint.sh; \
    ln -s /docker-entrypoint.sh /usr/local/bin/; \
    apk del curl;

RUN \
    mkdir /run/mysqld;

RUN \ 
    apk add --no-cache pwgen su-exec; \
    ln -s $(which su-exec) /sbin/gosu;

RUN \
    ln -s /usr/local/mysql/bin/mysqld /usr/bin;

# Purge
RUN \
    apk del git g++ make cmake bison ncurses-dev libevent-dev openssl-dev libexecinfo-dev gnutls linux-headers;

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
