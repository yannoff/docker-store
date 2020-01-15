# vim: ft=dockerfile
#
# @package elastic
# @author  yannoff <https://github.com/yannoff>
# @license MIT
#

FROM openjdk:8-jre-alpine

MAINTAINER Yannoff <https://github.com/yannoff>

ARG ES_VERSION=6.8.6
ARG ES_HOME=/usr/share/elasticsearch
ARG ELASTICSEARCH_REPO="https://artifacts.elastic.co/downloads/elasticsearch"
# TODO: If set, launch bin/elasticsearch-plugins install ${ES_PLUGINS}
ARG ES_PLUGINS="analysis-icu"
# Optional UID/GID overrides
ARG UID=9200
ARG GID=9200

ENV ES_HOME ${ES_HOME}


# ensure elasticsearch user exists
RUN addgroup -g ${GID} -S elasticsearch && \
    adduser -u ${UID} -S -G elasticsearch elasticsearch

# grab su-exec for easy step-down from root
# and bash for "bin/elasticsearch" among others
RUN apk add --no-cache 'su-exec>=0.2' bash

# https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4

WORKDIR ${ES_HOME}
ENV PATH ${ES_HOME}/bin:$PATH

ENV ELASTICSEARCH_VERSION ${ES_VERSION}
# TODO Do we REALLY need those as ENV variables? Some space could be saved here
#ENV \

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		gnupg \
		openssl \
		tar \
        curl \
	; \
	\
    ELASTICSEARCH_TARBALL_URL="${ELASTICSEARCH_REPO}/elasticsearch-${ELASTICSEARCH_VERSION}.tar.gz"; \
	ELASTICSEARCH_TARBALL_NAME=`basename ${ELASTICSEARCH_TARBALL_URL}`; \
	ELASTICSEARCH_TARBALL_SHA512=`curl ${ELASTICSEARCH_TARBALL_URL}.sha512`; \
	ELASTICSEARCH_TARBALL_ASC_URL="${ELASTICSEARCH_TARBALL_URL}.asc"; \
	\
	curl -O "$ELASTICSEARCH_TARBALL_URL"; \
    \
	if [ "$ELASTICSEARCH_TARBALL_SHA512" ]; then \
		echo "$ELASTICSEARCH_TARBALL_SHA512" | sha512sum -c -; \
	fi; \
	\
	if [ "$ELASTICSEARCH_TARBALL_ASC_URL" ]; then \
		wget -O elasticsearch.tar.gz.asc "$ELASTICSEARCH_TARBALL_ASC_URL"; \
		export GNUPGHOME="$(mktemp -d)"; \
		gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"; \
		gpg --batch --verify elasticsearch.tar.gz.asc ${ELASTICSEARCH_TARBALL_NAME}; \
		rm -rf "$GNUPGHOME" elasticsearch.tar.gz.asc; \
	fi; \
	\
	tar -xf ${ELASTICSEARCH_TARBALL_NAME} --strip-components=1; \
	rm ${ELASTICSEARCH_TARBALL_NAME}; \
    \
    # Machine-learning module not supported by Alpine
    rm -rf modules/x-pack-ml; \
	\
	apk del .fetch-deps; \
	\
    # TODO: Include in below <for> loop
	mkdir -p ./plugins; \
	for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done; \
	\
    # fix https://github.com/pires/docker-elasticsearch/issues/56
    export ES_TMPDIR=`mktemp -d -t elasticsearch.XXXXXXXX`; \
    chown -R elasticsearch:elasticsearch ${ES_TMPDIR}; \
    # endfix
    \
    # Additional plugins to be included in the image
    # TODO: Implement loop to handle multiple plugins
    if [ "$ES_PLUGINS" ]; then \
        for plugin in ${ES_PLUGINS}; do \
            elasticsearch-plugin install ${plugin}; \
        done; \
    fi; \

# we shouldn't need much RAM to test --version (default is 2gb, which gets Jenkins in trouble sometimes)
	export ES_JAVA_OPTS='-Xms32m -Xmx32m'; \
	if [ "${ELASTICSEARCH_VERSION%%.*}" -gt 1 ]; then \
		elasticsearch --version; \
	else \
# elasticsearch 1.x doesn't support --version
# but in 5.x, "-v" is verbose (and "-V" is --version)
		elasticsearch -v; \
	fi; \
    \
    rm -rf ${ES_TMPDIR}


VOLUME /usr/share/elasticsearch/data

COPY --chown=elasticsearch:elasticsearch config ./config
COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
USER elasticsearch
