ROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y

COPY ./tools/mariadb_script.sh /mariadb_script.sh

COPY ./conf/mdb.cnf /etc/mysql/mariadb.conf.d/mdb.cnf

ENTRYPOINT ["/bin/bash", "/mariadb_script.sh"]
