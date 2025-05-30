#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Start MariaDB temporarily to run setup
mysqld_safe --skip-networking &
pid="$!"

# Wait for MariaDB to become ready
timeout=30
while ! mariadb -uroot -e "SELECT 1;" >/dev/null 2>&1; do
  sleep 1
  timeout=$((timeout-1))
  if [ "$timeout" -le 0 ]; then
    echo "MariaDB failed to start within timeout."
    kill "$pid"
    exit 1
  fi
done

# Create database and users
mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Wait for mysqld_safe to stay in foreground
exec mysqld_safe

