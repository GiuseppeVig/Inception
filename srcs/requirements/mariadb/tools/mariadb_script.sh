#!/bin/bash

mysql_install_db --user=mysql --datadir=/var/lib/mysql &

sleep 20

echo "Starting MariaDB with custom config only..."

mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mdb.cnf &

sleep 20

service mariadb start

	mariadb --protocol=TCP -h127.0.0.1 -P3306 -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mariadb --protocol=TCP -h127.0.0.1 -P3306 -uroot -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -P3306 -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -P3306 -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
	mariadb --protocol=TCP -h127.0.0.1 -P3306 -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	
mysqladmin --protocol=TCP -h127.0.0.1 -P3306 -uroot -p$MYSQL_ROOT_PASSWORD shutdown

exec mysqld --defaults-file=/etc/mysql/mariadb.conf.d/mdb.cnf

wait