FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y

COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/mariadb.cnf

ENTRYPOINT ["/bin/bash", "/setup_mariadb.sh"]
