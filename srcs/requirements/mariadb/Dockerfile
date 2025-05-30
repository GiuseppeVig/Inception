FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install mariadb-server -y && \
	mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

RUN chmod +x /setup_mariadb.sh

ENTRYPOINT ["/bin/bash", "/setup_mariadb.sh"]
