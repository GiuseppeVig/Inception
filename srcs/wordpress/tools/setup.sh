#!/bin/bash

# Download WordPress if not already there
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz

    # Create wp-config.php
    cp wp-config-sample.php wp-config.php

    # Configure wp-config.php with env vars
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${WORDPRESS_DB_HOST}/" wp-config.php

    # Generate authentication keys
    curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php
fi

# Set correct permissions
chown -R www-data:www-data /var/www/html

# Start PHP-FPM
exec php-fpm7.4 -F
