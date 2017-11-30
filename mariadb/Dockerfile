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

# Installation
# 1. Create socket dir
# 2. Install mariadb server...
# 3. and the libs needed by entrypoint script:
#    - bash
#    - mysql-client
#    - pwgen
#    - su-exec (alternative for gosu: lighter and already packaged for Alpine)
RUN \
    apk --update --no-cache add \
        bash \
        su-exec \
        mysql \
        mysql-client \
        pwgen \
        tzdata \
        libssl1.0 \
        libstdc++; \
    ln -s $(which su-exec) /sbin/gosu; \
    mkdir /run/mysqld && chown mysql:mysql /run/mysqld; \
    rm -rfv /var/cache/apk/; \
    rm -rfv /usr/share/apk/keys/; \
    cd /usr/sbin/; rm -v ftpd httpd; cd /usr/bin/; rm -v mysql_client_test_embedded mysqltest mysqltest_embedded

# Fetch genuine entrypoint from mariadb official github repo, to be sure we have an up-to-date version
RUN \
    apk add --no-cache curl; \
    curl https://raw.githubusercontent.com/docker-library/mariadb/master/docker-entrypoint.sh -o /docker-entrypoint.sh; \
    chmod +x /docker-entrypoint.sh; \
    ln -s /docker-entrypoint /usr/local/bin/; \
    apk del curl; \
    rm -rfv /var/cache/apk/; \
    rm -rfv /usr/share/apk/keys/



# Fix MariaDB bug in granting root user's permissions
# https://github.com/docker-library/mariadb/issues/48
COPY fix-permissions.sql /docker-entrypoint-initdb.d/fix-permissions.sql

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
