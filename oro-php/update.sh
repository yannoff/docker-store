#!/bin/bash

export ORO_EDITION=${1:-ee}
export ORO_VERSION=${2:-4.1.0}
export PHP_VERSION=7.3.14

PACKAGES=(
    bash
    su-exec
    # composer
    unzip
    git
    # Supervisor
    openrc
    python supervisor
    # NodeJS & co.
#    'nodejs-current>=${NODE_VERSION}'
    'nodejs-current>=12'
    npm
    yarn
)
PHP_EXTS=(
    bcmath
    dba
    gd
    intl
    imap
    ldap
    mbstring
    opcache
    pcntl
    pdo
    soap
    xml
    zip
    zlib # ? FIXME
)
PECL_EXTS=(
    apcu
    xdebug
)
PHP_DEPS=(
    # ext-xml
    libxml2-dev
    # ext-gd
    libpng-dev
    # ext-intl: native install is bugged
    icu-dev
    # ext-ldap
    openldap-dev
    # ext-zip
    libzip-dev
    # ext-imap
    imap-dev
    krb5-dev
)
APP_DIRS=(
    var/run
    var/logs
    var/cache
    var/session
)

case ${ORO_EDITION} in
    ce)
        PHP_EXTS+=(
            mysql
            pdo_mysql
        )
        ;;

    ee)
        PHP_EXTS+=(
            pgsql
            pdo_pgsql
        )
        PHP_DEPS+=(
            # ext-pgsql
            postgresql-dev
            # AMQP PECL Extension
            rabbitmq-c-dev
        )
        PECL_EXTS+=(
            amqp
        )
        ;;
esac

export \
    ORO_EDITION \
    PHP_VERSION \
    APP_DIR_LIST="${APP_DIRS[@]}" \
    PHP_EXT_LIST="${PHP_EXTS[@]}" \
    PHP_DEP_LIST="${PHP_DEPS[@]}" \
    PACKAGE_LIST="${PACKAGES[@]}" \
    PECL_EXT_LIST="${PECL_EXTS[@]}"

OUT_DIR=${ORO_VERSION}/${ORO_EDITION^^}

if [ ! -d "${OUT_DIR}" ]
then
    printf "Creating directory \033[01m%s\033[00m as it does not exist yet... \n" ${OUT_DIR} && mkdir -p ${OUT_DIR}
fi

printf "Generating \033[01m%s\033[00m in \033[01m%s\033[00m ...\n" Dockerfile ${OUT_DIR}
envsubst <Dockerfile >${OUT_DIR}/Dockerfile '$PHP_VERSION $PHP_EXT_LIST $PHP_DEP_LIST $PACKAGE_LIST $PECL_EXT_LIST $APP_DIR_LIST'

for f in docker-php-entrypoint *.conf
do
    printf "Copying \033[01m%s\033[00m in \033[01m%s\033[00m ...\n" $f ${OUT_DIR}
    cp -v $f ${OUT_DIR}/
done
