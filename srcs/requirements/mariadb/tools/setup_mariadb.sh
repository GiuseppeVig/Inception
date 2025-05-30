#!/bin/bash

# Ensure the MySQL data directory exists and is initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "Initializing MariaDB data directory..."
  mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null
fi

# Start MariaDB in the background (without networking to avoid conflicts)
echo "Starting MariaDB..."
mysqld_safe --skip-networking &
sleep 5  # give it a moment to boot

# Wait for MariaDB to respond
echo "Waiting for MariaDB to become ready..."
tries=30
while ! mariadb -uroot -e "SELECT 1;" > /dev/null 2>&1; do
  sleep 1
  tries=$((tries-1))
  if [ $tries -le 0 ]; then
    echo "MariaDB failed to start within timeout."
    exit 1
  fi
done

# Run SQL setup
echo "Running initial SQL setup..."
mariadb -uroot -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mariadb -uroot -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -uroot -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -uroot -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Now start MariaDB in the foreground (keep the container alive)
echo "MariaDB setup complete. Starting server."
exec mysqld_safe
