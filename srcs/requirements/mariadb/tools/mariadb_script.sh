#!/bin/bash

mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mdb.cnf &

service mariadb start

	mariadb --protocol=TCP -h127.0.0.1 -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mariadb --protocol=TCP -h127.0.0.1 -uroot -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	
mysqladmin --protocol=TCP -h127.0.0.1 -uroot -p$MYSQL_ROOT_PASSWORD shutdown

exec mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mdb.cnf