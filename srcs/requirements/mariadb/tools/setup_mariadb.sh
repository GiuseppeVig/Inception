#!/bin/bash

echo Starting MariaDB Service...

mysqld_safe --datadir=/var/lib/mysql &

until mariadb -uroot -e "SELECT 1;" >/dev/null 2>&1; do
  echo "Waiting for MariaDB to start..."
  sleep 1
done

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -uroot -p $MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"

wait