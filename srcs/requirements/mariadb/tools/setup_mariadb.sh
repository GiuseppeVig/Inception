#!/bin/bash
set -e

# Initialize database if empty
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
fi

# Start MariaDB in background
echo "Starting MariaDB in background..."
mysqld_safe --datadir=/var/lib/mysql &
pid="$!"

# Wait for socket to exist
echo "Waiting for MariaDB to be ready..."
until [ -S /run/mysqld/mysqld.sock ]; do
    sleep 1
done

echo "MariaDB socket found!"

# Run setup if database doesn't exist
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    echo "Setting up database..."
    mysql -u root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL
fi

# Shutdown the temporary server
echo "Shutting down MariaDB setup instance..."
mysqladmin -u root --password="${MYSQL_ROOT_PASSWORD}" shutdown

# Start final MariaDB server
echo "Starting MariaDB foreground..."
exec mysqld_safe
