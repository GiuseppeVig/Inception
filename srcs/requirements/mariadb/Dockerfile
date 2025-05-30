FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /run/mysqld \
	&& chown -R mysql:mysql /run/mysqld \
	&& chmod 775 /run/mysqld

EXPOSE 3306

COPY ./tools/setup_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mariadb.sh

ENTRYPOINT [ "/usr/local/bin/setup_mariadb.sh" ]
