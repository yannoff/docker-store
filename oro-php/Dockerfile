ARG ALPINE_VERSION=

FROM php:${PHP_VERSION}-fpm-alpine${ALPINE_VERSION}

ARG USER=1000
ARG GROUP=1000
ARG USERLAND=

ENV PACKAGES ${PACKAGE_LIST}
ENV PECL_EXTS ${PECL_EXT_LIST}
ENV PHP_EXTS ${PHP_EXT_LIST}
#ENV PHP_DEPS ${PHP_DEP_LIST}

ENV NPM_DIRS \
    ${USER_LAND}/.npm \
    ${USERLAND}/.config \
    ${USERLAND}/.cache

ENV COMPOSER_DIRS \
    ${USERLAND}/.composer \
    ${USERLAND}/.composer/cache

ENV APP_DIRS \
    ${APP_DIR_LIST} \
    ${NPM_DIRS} \
    ${COMPOSER_DIRS}

ENV ALPINE_TOOLS_URL=https://raw.githubusercontent.com/yannoff/alpine-tools/master/bin

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN \
    # Create special dirs to ensure they will be mounted with the right ownership
    for d in ${APP_DIRS}; \
    do \
        mkdir -v -p ${d}; \
        chown -v ${USER}:${GROUP} ${d}; \
    done; \
    \
    # Install required binaries
    apk add --update ${PACKAGES}; \
    \
    # Install PHP/PECL extensions
    printf "\033[01;32mExtensions planned for install:\033[00m\n"; \
    printf "\033[01;32m-> PECL:\033[00m %s\n" "${PECL_EXTS}"; \
    printf "\033[01;32m-> PHP :\033[00m %s\n" "${PHP_EXTS}"; \
    for ext in ${PECL_EXTS} ${PHP_EXTS}; \
    do \
        # We check if the extension is installed yet to avoid useless installs
        if (! php -m | grep -i "^${ext}$" >/dev/null 2>&1); \
        then \
            printf "- [\033[01mext-%s\033[00m] Installing extension.\n" ${ext}; \
            install-php-extensions ${ext} 1>/dev/null; \
        else \
            printf "- [\033[01mext-%s\033[00m] already installed.\n" ${ext}; \
        fi; \
    done; \
    # Temporary fix: force disable Xdebug extension
    echo ';disabled' > ${PHP_INI_DIR}/conf.d/docker-php-ext-xdebug.ini

RUN \
    _info(){ \
        printf "$*"; \
    }; \    
    \
    # Install support for locales
    # @see https://github.com/gliderlabs/docker-alpine/issues/144
    _info "Installing \033[01m%s\033[00m support...\n" [musl-locales]; \
    curl -s ${ALPINE_TOOLS_URL}/install-locales | bash; \
    \
    # Fix ICONV library implementation
    # @see https://github.com/docker-library/php/issues/240
    _info "Fixing \033[01m%s\033[00m implementation...\n" [iconv]; \
    curl -s ${ALPINE_TOOLS_URL}/rebuild-iconv-lib | bash; \
    \
    # Install composer & offenbach
    _info "\033[01;32m- Installing composer...\033[00m\n"; \
    curl -s ${ALPINE_TOOLS_URL}/install-composer | bash; \
    \
    \
    # Cleanup directories
    docker-php-source delete; \
    rm -rf \
        /usr/src/php \
        /usr/src/php.tar.* \
        /usr/local/include/php \
        /usr/share/apk/*; \
    \
    #
    echo "ORO-PHP Image build process ended.";

COPY docker-php-entrypoint /usr/local/bin

COPY supervisord.conf oro*.conf /etc/supervisord/
COPY www.conf /usr/local/etc/php-fpm.d/www.ini


# Needed by locales
ENV MUSL_LOCPATH /usr/local/share/i18n/locales/musl

# Fix ICONV library implementation
# @see https://github.com/docker-library/php/issues/240
ENV LD_PRELOAD /usr/local/lib/preloadable_libiconv.so
