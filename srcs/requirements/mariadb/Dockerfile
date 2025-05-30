FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server mariadb-client && \
    mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

COPY ./tools/setup_mariadb.sh /docker-entrypoint-initdb.d/setup_mariadb.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/mariadb.conf

RUN chmod +x /docker-entrypoint-initdb.d/setup_mariadb.sh

CMD ["mysqld_safe"]