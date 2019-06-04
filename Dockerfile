FROM sangram/alpine-mini:latest

LABEL maintainer="Sangram Chavan <schavan@outlook.com>" \
    architecture="amd64/x86_64" \
    mariadb-version="10.3.13" \
    alpine-version="3.9" \
    build="29-May-2019" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Sangram Chavan <schavan@outlook.com>" \
    org.opencontainers.image.vendor="Open Source" \
    org.opencontainers.image.version="v10.3.13" \
    org.opencontainers.image.url="https://hub.docker.com/r/sangram/alpine-mariadb/" \
    org.opencontainers.image.source="https://github.com/sangram-chavan/alpine-mariadb"

ARG IMAGE_NAME
ARG DOCKER_REPO
ARG BUILD_DATE
ARG VCS_REF

# fix labels
#LABEL maintainer="nimmis <kjell.havneskold@gmail.com>" \
#      org.label-schema.docker.dockerfile="/Dockerfile" \
#      org.label-schema.name="MariaDB database" \
#      org.label-schema.url="https://www.nimmis.nu" \
#      org.label-schema.build-date=$BUILD_DATE \
#      org.label-schema.vcs-ref=$VCS_REF \
#      org.label-schema.vcs-url="https://github.com/nimmis/docker-alpine-mariadb.git"


ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

COPY root/. /

RUN chmod a+x /sbin/start_runit && \
    chmod a+x /etc/run_always/db_init && \
    chmod a+x /etc/service/mysqld &&\
    apk update && apk upgrade && \
    mkdir -p /etc/BUILDS/ && \
    #printf "Build of %s, date: %s\n" $(echo $IMAGE_NAME | sed 's#^.*io/##')  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/$(echo $DOCKER_REPO | awk -F '/' '{print $NF}') && \
    apk add mariadb mariadb-client && \
    rm -rf /var/cache/apk/*

EXPOSE 3306

VOLUME ["/data"]

