ARG VERSION=latest

FROM alpine:${VERSION}

ENV CARGO_INSTALL_ROOT /usr/local
ENV SOZU_HOME /etc/sozu
ENV SOZU_RUN  /run/sozu
ENV SOZU_PORTS \
    80 \
    8080 \
    443 \
    8443 \
    8125 \
    1026

RUN \
    apk add --no-cache --virtual .run-deps bash gcc openssl; \
    apk add --no-cache --virtual .build-deps cargo openssl-dev; \
    cargo install sozu sozuctl; \
    apk del .build-deps; \
    rm -rfv ${CARGO_HOME:-/root/.cargo}; \
    mkdir -p \
        ${SOZU_RUN} \
        ${SOZU_HOME} \
    ;

COPY *.toml ${SOZU_HOME}/
COPY docker-entrypoint /usr/local/bin

EXPOSE ${SOZU_PORTS}

ENTRYPOINT [ "docker-entrypoint" ]
CMD [ "sozu", "start", "-c", "/etc/sozu/demo.toml" ]
