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
# - su-exec for gosu
# - mysql_embedded for mysql (so we don't need to install mysql-client)
RUN \ 
    apk add --no-cache bash su-exec; \
    ln -s $(which su-exec) /sbin/gosu; \
    ln -s /usr/bin/mysql_embedded /usr/bin/mysql

# Purge
RUN \
    apk del curl; \
    rm -rfv /var/cache/apk/

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "mysqld" ]
VOLUME [ "/var/lib/mysql" ]
EXPOSE 3306
