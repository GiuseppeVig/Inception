FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install mysql-server -y && \
    apt-get install mariadb-server -y

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

RUN chmod +x /setup_mariadb.sh

RUN mysql_install_db

ENTRYPOINT ["/bin/bash", "/setup_mariadb.sh"]
