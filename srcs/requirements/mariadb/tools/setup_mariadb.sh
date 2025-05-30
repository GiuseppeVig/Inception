#!/bin/bash

service mariadb start

	mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;"
	mariadb -uroot -e "CREATE USER IF NOT EXISTS '$MARIADB_USER'@'localhost' IDENTIFIED BY '$MARIADB_USER_PASSWORD';"
	mariadb -uroot -e "GRANT ALL PRIVILEGES ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_USER_PASSWORD';"
	mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';"
	mariadb -uroot -p$MARIADB_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	
mysqladmin -uroot -p$MARIADB_ROOT_PASSWORD shutdown

exec mysqld_safe