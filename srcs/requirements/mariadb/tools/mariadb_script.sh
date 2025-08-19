#!/bin/bash
set -e

echo "Initializing MariaDB data directory if needed..."

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB manually for initialization..."

mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
pid="$!"

# Wait until MariaDB is ready
for i in {30..0}; do
    if mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; then
        break
    fi
    echo -n "."
    sleep 1
done

if [ "$i" = 0 ]; then
    echo "MariaDB init process failed."
    exit 1
fi

echo "Running setup SQL..."
echo "$MYSQL_ROOT_PASSWORD"
echo "$MYSQL_DATABASE"
echo "$MYSQL_USER"
echo "$MYSQL_PASSWORD"

if [[ -z "$MYSQL_ROOT_PASSWORD" || -z "$MYSQL_DATABASE" || -z "$MYSQL_USER" || -z "$MYSQL_PASSWORD" ]]; then
    echo "ERROR: One or more required environment variables are missing."
    echo "Please set MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD"
    exit 1
fi

mysql --protocol=socket --socket=/run/mysqld/mysqld.sock -u root <<-EOSQL
    SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

echo "Shutting down temporary MariaDB..."
mysqladmin --protocol=socket --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

echo "Starting MariaDB in foreground..."
exec mysqld_safe
