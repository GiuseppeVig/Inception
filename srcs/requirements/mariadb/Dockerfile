FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y

# Remove all existing config files to prevent unexpected overrides
RUN rm -f /etc/mysql/my.cnf \
         /etc/mysql/mariadb.cnf && \
    find /etc/mysql/mariadb.conf.d/ ! -name 'mdb.cnf' -type f -delete

COPY ./conf/mdb.cnf /etc/mysql/mdb.cnf
COPY ./tools/mariadb_script.sh /mariadb_script.sh

RUN chmod +x /mariadb_script.sh

EXPOSE 3306

ENTRYPOINT ["/bin/bash", "/mariadb_script.sh"]
