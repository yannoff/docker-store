FROM yannoff/alpine:latest

RUN \
    BUILD_DEPS="autoconf coreutils gcc libc-dev make"; \
    \
    apk update \
    && \
    apk add --virtual .build-deps \
        ${BUILD_DEPS} \
#        build-essentials \
    && \
#    apk cache clean --purge \
#    && \
    rm -rf /var/cache/apk/*
