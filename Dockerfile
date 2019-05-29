FROM alpine:latest

LABEL maintainer="Sangram Chavan <schavan@outlook.com>" \
    architecture="amd64/x86_64" \
    mariadb-version="10.3.13" \
    alpine-version="3.9.4" \
    build="29-May-2019" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Sangram Chavan <schavan@outlook.com>" \
    org.opencontainers.image.vendor="Open Source" \
    org.opencontainers.image.version="v10.3.13" \
    org.opencontainers.image.url="https://hub.docker.com/r/sangram/alpine-mariadb/" \
    org.opencontainers.image.source="https://github.com/sangram-chavan/alpine-mariadb"

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

ADD scripts/run.sh /scripts/run.sh
RUN mkdir /entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]