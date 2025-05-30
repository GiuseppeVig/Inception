FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y

COPY ./conf/mdb.cnf /etc/mysql/mariadb.conf.d/mdb.cnf
COPY ./tools/mariadb_script.sh /mariadb_script.sh

RUN chmod +x /mariadb_script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash", "/mariadb_script.sh"]
