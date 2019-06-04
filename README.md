# This is Docker image of MariaDB running on Alpine Linux

[![Docker Automated build](https://img.shields.io/docker/automated/sangram/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/sangram/alpine-mariadb/)
[![Docker Pulls](https://img.shields.io/docker/pulls/sangram/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/sangram/alpine-mariadb/)
[![Docker Stars](https://img.shields.io/docker/stars/sangram/alpine-mariadb.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/sangram/alpine-mariadb/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.9.4-green.svg?style=for-the-badge)](https://alpinelinux.org/)
[![MariaDB Version](https://img.shields.io/badge/Mariadb%20version-v10.3.13-green.svg?style=for-the-badge)](https://mariadb.org/)

##### Alpine Version 3.9.4 (Released May 09, 2019)
##### MariaDB Version 10.3.13

----

## What is Alpine Linux?
Alpine Linux is a Linux distribution built around musl libc and BusyBox. The image is only 5 MB in size and has access to a package repository that is much more complete than other BusyBox based images. This makes Alpine Linux a great image base for utilities and even production applications. Read more about Alpine Linux here and you can see how their mantra fits in right at home with Docker images.

## What is MariaDB?
MariaDB Server is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source.

MariaDB turns data into structured information in a wide array of applications, ranging from banking to websites. It is an enhanced, drop-in replacement for MySQL. MariaDB is used because it is fast, scalable and robust, with a rich ecosystem of storage engines, plugins and many other tools make it very versatile for a wide variety of use cases.

MariaDB is developed as open source software and as a relational database it provides an SQL interface for accessing data. The latest versions of MariaDB also include GIS and JSON features.

## Features

* Minimal size only, minimal layers
* Memory usage is minimal on a simple install.
* MariaDB the MySQL replacement


## Architectures

* ```:amd64```, ```:x86_64``` - 64 bit Intel/AMD (x86_64/amd64)

##### PLEASE CHECK TAGS BELOW FOR SUPPORTED ARCHITECTURES, THE ABOVE IS A LIST OF EXPLANATION

## Tags

* ```:latest``` latest branch based

## Layers & Sizes

![Version](https://img.shields.io/badge/version-amd64-blue.svg?style=for-the-badge)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/sangram/alpine-mariadb/amd64.svg?style=for-the-badge)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/sangram/alpine-mariadb/amd64.svg?style=for-the-badge)


## Volume structure

* `/var/lib/mysql`: Database files
* `/var/lib/mysql/mysql-bin`: MariaDB logs


## Environment Variables:

### Main Mariadb parameters:
* `MARIADB_DATABASE`: specify the name of the database
* `MARIADB_USER`: specify the User for the database
* `MARIADB_USER_PASSWORD`: specify the User password for the database
* `MARIADB_ROOT_PASSWORD`: specify the root password for Mariadb
* `MARIADB_REMOTE_ROOT`: specify the root remote access for Mariadb

> https://mariadb.org/

## Creating an instance


```bash
# Create named volume for persistent data
docker volume create db-data

# Run container with named volumed
docker run -it --name mariadb -p 3306:3306 -v db-data:/data --env-file ./mysql.env sangram/alpine-mariadb
```

### Initializing a fresh instance
When a container is started for the first time, a new database with the specified name will be created and initialized with the provided configuration variables. Furthermore, it will execute files with extensions .sh, .sql and .sql.gz that are found in /entrypoint-initdb.d. Files will be executed in alphabetical order. You can easily populate your mariadb services by mounting a SQL dump into that directory and provide custom images with contributed data. SQL files will be imported by default to the database specified by the MYSQL_DATABASE variable.


## Docker Compose example:

##### (Please pass your own credentials or let them be generated automatically, don't use these ones for production!!)

```yalm
version: '3.7'
services:
  mariadb:
    image: sangram/alpine-mariadb
    environment:
      MARIADB_ROOT_PASSWORD=<mysqlrootpasswd>
      MARIADB_DATABASE=<mysqldb>
      MARIADB_USER=<mysqluser>
      MARIADB_USER_PASSWORD=<mysqluserpasswd>
      MARIADB_REMOTE_ROOT=Yes
    expose:
      - "3306"
    volumes:
      - db-data:/data
    restart: on-failure
volumes: 
  db-data:
```

## Environment variables used in the container

#### MARIADB_ROOT_PASSWORD
This variable defines the password for the root user in the database, se it with

	-e MARIADB_ROOT_PASSWORD=secretpassword

add quotes if there is spaces or other special character in the passwordd

	-e MARIADB_ROOT_PASSWORD='password with spaces'

if parameter is omitted default random password is generated for root. Password can then be found by looking at the logoutput

	docker logs <container>

#### MARIADB_REMOTE_ROOT
Normal the root user can only use localhost to access the databases adding

	-e MARIADB_REMOTE_ROOT=yes

allows root access from any host

#### MARIADB_DATABASE
creates a database with the defined name

	-e MARIADB_DATABASE=databasename

#### MARIADB_USER
creates a user with password defined with MARIADB_PASSWORD and full access to the database defined by MARIADB_DATABASE

	-e MARIADB_USER=username

#### MARIADB_PASSWORD
The apssword for the user defined by MARIADB_USER

	-e MARIADB_PASSWORD=donottell


## Volumes

The /data volume is defined containing

##### /data/conf - Contains the configuration of mariadb (**my.cnf**)

##### /data/db - Contains the database files

##### /data/logs - Contains logs from mariadb


## Source Repository

* [Github - sangram-chavan/alpine-mariadb](https://github.com/sangram-chavan/alpine-mariadb)

## Links

* [Dockerhub - sangram/alpine-mariadb](https://hub.docker.com/r/sangram/alpine-mariadb)
