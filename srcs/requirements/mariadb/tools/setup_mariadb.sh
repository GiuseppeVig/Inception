#!/bin/bash
set -e
set -x

# mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
# mariadb -uroot -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD';"
# mariadb -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
# mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
# mariadb -uroot -p$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
	
# mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown

# exec mysqld_safe --datadir=/var/lib/mysql

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Start mysqld in background
mysqld_safe --datadir=/var/lib/mysql &

# Wait for it to be ready
MAX_TRIES=30
TRIES=0
until mariadb -uroot -e "SELECT 1" &>/dev/null; do
    if [ "$TRIES" -ge "$MAX_TRIES" ]; then
        echo "ERROR: MariaDB did not become ready in time"
        exit 1
    fi
    echo "Waiting for MariaDB... Attempt $((TRIES+1))/$MAX_TRIES"
    TRIES=$((TRIES+1))
    sleep 1
done

mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mariadb -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown
exec mysqld_safe --datadir=/var/lib/mysql