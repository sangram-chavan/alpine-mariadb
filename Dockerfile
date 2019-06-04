
ARG VERSION
FROM sangram/alpine-mini:$VERSION
LABEL   maintainer="Sangram Chavan <schavan@outlook.com>" \
        architecture="amd64/x86_64" 

ARG VERSION
ARG BUILD_DATE
ARG VCS_REF

LABEL   org.label-schema.schema-version="1.0" \
        org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="MariaDB database" \
        org.label-schema.description="MariaDB Docker image running on Alpine Linux" \
        org.label-schema.url="https://hub.docker.com/r/sangram/alpine-mariadb" \
        org.label-schema.vcs-url="https://github.com/sangram-chavan/docker-images/alpine-mariadb.git" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vendor="Open Source" \
        org.label-schema.version=$VERSION \
        org.label-schema.image.authors="Sangram Chavan <schavan@outlook.com>" \
        org.label-schema.image.vendor="Open Source" 

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

