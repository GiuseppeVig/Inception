FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y \
	mariadb-server -y

COPY conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

EXPOSE 3306

COPY ./tools/setup_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mariadb.sh

ENTRYPOINT [ "/usr/local/bin/setup_mariadb.sh" ]
