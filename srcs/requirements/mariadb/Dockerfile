FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y mariadb-server mariadb-client && \
	mkdir -p /run/mysqld && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql

RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

EXPOSE 3306

RUN chmod +x /setup_mariadb.sh

ENTRYPOINT ["/setup_mariadb.sh"]
