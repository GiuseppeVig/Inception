#! /bin/bash

sleep 30

mkdir -p /run/php

if [ ! -f ./wp-config.php ]; then
	echo "Creating Configuration"

	wp config create --dbhost=$MYSQL_HOSTNAME \
					 --dbname=$MYSQL_DATABASE \
					 --dbuser=$MYSQL_USER \
					 --dbpass=$MYSQL_PASSWORD \
					 --path="/var/www/inception" --allow-root

	wp core install --url=$DOMAIN_NAME \
					--title="$WORDPRESS_TITLE" \
					--admin_user=$WORDPRESS_ADMIM \
					--admin_password=$WORDPRESS_ADMIM_PASS  \
					--admin_email=$WORDPRESS_ADMIM_EMAIL --allow-root
	wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --user_pass=$WORDPRESS_USER_PASS \
					--role=author  --allow-root
	
	wp theme install twentysixteen --activate --allow-root

	echo "Configuration Created"
fi

/usr/sbin/php-fpm7.4 -F;
