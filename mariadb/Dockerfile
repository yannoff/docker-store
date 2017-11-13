# vim: ft=dockerfile
#
# Alpine Linux image for MariaDB, using original entrypoint script
#
# @package mariadb
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM alpine:latest

MAINTAINER Yannoff <https://github.com/yannoff>

# Install mariadb server, 
# Also install bash, pwgen and libs needed by entrypoint script at first run
RUN \
    apk --update --no-cache add \
        mysql \
        mysql-client \
        pwgen \
        tzdata \
        libssl1.0 \
        libstdc++;

# Fetch genuine entrypoint from mariadb official github repo, to be sure we have an up-to-date version
RUN \
    apk add curl; \
    curl https://raw.githubusercontent.com/docker-library/mariadb/master/docker-entrypoint.sh -o /docker-entrypoint.sh; \
    chmod +x /docker-entrypoint.sh; \
    ln -s /docker-entrypoint.sh /usr/local/bin/; 

# Create socket dir
RUN \
    mkdir /run/mysqld && chown mysql:mysql /run/mysqld;

# Alternatives - MariaDB genuine entry point needs gosu & mysql
# - su-exec for gosu: lighter and already packaged for Alpine
RUN \ 
    apk add --no-cache bash su-exec; \
    ln -s $(which su-exec) /sbin/gosu

# Fix MariaDB bug in granting root user's permissions
# https://github.com/docker-library/mariadb/issues/48
COPY fix-permissions.sql /docker-entrypoint-initdb.d/fix-permissions.sql
RUN chmod +x /docker-entrypoint-initdb.d/fix-permissions.sql

# Purge
RUN \
    apk del curl; \
    rm -rfv /var/cache/apk/

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
