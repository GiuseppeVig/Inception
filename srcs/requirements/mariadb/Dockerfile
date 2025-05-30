FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

RUN chmod +x /setup_mariadb.sh
RUN mysqld --user=mysql --datadir=/var/lib/mysql

CMD ["/setup_mariadb.sh"]
